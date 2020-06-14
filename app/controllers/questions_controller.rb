class QuestionsController < ApplicationController
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
      #ストロングパラメータ。セキュリティを強固にするために指定されたパラメーターのみ受け付ける仕組み
      #パラメータ:フォームなどから送られてきた値(下記ではtitleとbodyの値のみを受け付けている)
      #privateメソッド以下に書かれたコードは、このコントローラー内でしか使えない
      private
        def question_params
            params.require(:question).permit(:title, :body)
        end
end
