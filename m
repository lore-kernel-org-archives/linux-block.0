Return-Path: <ndesaulniers@google.com>
MIME-Version: 1.0
References: <20180911215040.7906-1-natechancellor@gmail.com>
In-Reply-To: <20180911215040.7906-1-natechancellor@gmail.com>
From: Nick Desaulniers <ndesaulniers@google.com>
Date: Tue, 11 Sep 2018 14:55:00 -0700
Message-ID: <CAKwvOdk97dLyTAyt6g29HcQ-moPXqg6WpVHBwSRivDfFvSPREg@mail.gmail.com>
Subject: Re: [PATCH] rsxx: Remove unnecessary parentheses
To: Nathan Chancellor <natechancellor@gmail.com>
Cc: josh.h.morris@us.ibm.com, pjk1939@linux.vnet.ibm.com, axboe@kernel.dk,
	linux-block@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-block@vger.kernel.org>

On Tue, Sep 11, 2018 at 2:51 PM Nathan Chancellor
<natechancellor@gmail.com> wrote:
>
> Clang warns when more than one set of parentheses is used for a
> single conditional statement:
>
> drivers/block/rsxx/cregs.c:279:15: warning: equality comparison with
> extraneous parentheses [-Wparentheses-equality]
>         if ((cmd->op == CREG_OP_READ)) {
>              ~~~~~~~~^~~~~~~~~~~~~~~
> drivers/block/rsxx/cregs.c:279:15: note: remove extraneous parentheses
> around the comparison to silence this warning
>         if ((cmd->op == CREG_OP_READ)) {
>             ~        ^              ~
> drivers/block/rsxx/cregs.c:279:15: note: use '=' to turn this equality
> comparison into an assignment
>         if ((cmd->op == CREG_OP_READ)) {
>                      ^~
>                      =
> 1 warning generated.
>
> Reported-by: Nick Desaulniers <ndesaulniers@google.com>
> Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
> ---
>  drivers/block/rsxx/cregs.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/block/rsxx/cregs.c b/drivers/block/rsxx/cregs.c
> index c148e83e4ed7..d9a8758682c9 100644
> --- a/drivers/block/rsxx/cregs.c
> +++ b/drivers/block/rsxx/cregs.c
> @@ -276,7 +276,7 @@ static void creg_cmd_done(struct work_struct *work)
>                 st = -EIO;
>         }
>
> -       if ((cmd->op == CREG_OP_READ)) {
> +       if (cmd->op == CREG_OP_READ) {
>                 unsigned int cnt8 = ioread32(card->regmap + CREG_CNT);
>
>                 /* Paranoid Sanity Checks */
> --
> 2.18.0
>

LGTM
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

-- 
Thanks,
~Nick Desaulniers
