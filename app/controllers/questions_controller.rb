class QuestionsController < ApplicationController
    #ログインしているユーザーのみアクセスを許可
    before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]
    #
    before_action :ensure_correct_user, only: [:edit, :update, :destroy]

    def index
        @test = "テストテキスト"
    end

    def show
        @question = Question.find(params[:id])
    end

    def new
        @question = Question.new
    end

    def create
        @question = Question.new(question_params)
        #現在ログインしているユーザー
        @question.user_id = current_user.id
        if @question.save
            flash[:notice] = "成功!"
            #ルート、コントローラーを通りnewページを表示させる
            redirect_to("/questions/#{@question.id}")
        else
            flash.now[:alert] = "失敗!"
            #ルート、コントローラーを通らずnewページを表示させる。登録には失敗するが、入力した内容が消されずにすむので実用的。
            render("questions/new")
        end
    end

    def edit
        @question = Question.find(params[:id])
    end

    def update
        @question = Question.find(params[:id])
        if @question.update(question_params)
            flash[:notice] = "成功！"
            redirect_to("/questions/#{@question.id}")
        else
            flash.now[:alert] = "失敗！"
            render("questions/edit")
        end
    end

    def destroy
        @question = Question.find(params[:id])
        @question.destroy
        flash[:notice] = "成功！"
        redirect_to("/questions")
    end

      #ストロングパラメータ。セキュリティを強固にするために指定されたパラメーターのみ受け付ける仕組み
      #パラメータ:フォームなどから送られてきた値(下記ではtitleとbodyの値のみを受け付けている)
      #privateメソッド以下に書かれたコードは、このコントローラー内でしか使えない
      private
        def question_params
            params.require(:question).permit(:title, :body)
        end

        def ensure_correct_user
            @question = Question.find_by(id: params[:id])
            if @question.user_id != current_user.id
                flash[:alert] = "権限がありません"
                redirect_to("/questions/#{@question.id}")
            end
        end
end
