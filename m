Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH] rsxx: Remove unnecessary parentheses
To: Nathan Chancellor <natechancellor@gmail.com>,
 Joshua Morris <josh.h.morris@us.ibm.com>,
 Philip Kelleher <pjk1939@linux.vnet.ibm.com>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 Nick Desaulniers <ndesaulniers@google.com>
References: <20180911215040.7906-1-natechancellor@gmail.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <f8ee0011-d544-ce09-0bd7-94946c101fbd@kernel.dk>
Date: Tue, 11 Sep 2018 16:57:35 -0600
MIME-Version: 1.0
In-Reply-To: <20180911215040.7906-1-natechancellor@gmail.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 9/11/18 3:50 PM, Nathan Chancellor wrote:
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

Applied for 4.20, thanks.

-- 
Jens Axboe
