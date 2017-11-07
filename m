Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH] null_blk: add an usage for shared tags in documentation
To: Minwoo Im <minwoo.im.dev@gmail.com>
Cc: linux-block@vger.kernel.org, Minwoo Im <dn3108@gmail.com>
References: <1510064307-20916-1-git-send-email-minwoo.im.dev@gmail.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <761c2f1f-d759-ef17-e630-00de7240715a@kernel.dk>
Date: Tue, 7 Nov 2017 09:24:31 -0700
MIME-Version: 1.0
In-Reply-To: <1510064307-20916-1-git-send-email-minwoo.im.dev@gmail.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 11/07/2017 07:18 AM, Minwoo Im wrote:
> add usage explanation for a shared_tags of
> commit 82f402fefa50f1675bf918bcd009981bd6b30ac8
> ("null_blk: add support for shared tags") to this documentation.
> 
> Signed-off-by: Minwoo Im <minwoo.im.dev@gmail.com>
> ---
>  Documentation/block/null_blk.txt | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/Documentation/block/null_blk.txt b/Documentation/block/null_blk.txt
> index b7161c8..e1d1aa9 100644
> --- a/Documentation/block/null_blk.txt
> +++ b/Documentation/block/null_blk.txt
> @@ -77,3 +77,8 @@ use_lightnvm=[0/1]: Default: 0
>  no_sched=[0/1]: Default: 0
>    0: nullb* use default blk-mq io scheduler.
>    1: nullb* doesn't use io scheduler.
> +
> +shared_tags=[0/1]: Default: 0
> +  0: Tag set is not shared.
> +  1: Tag set shared between devices for blk-mq.
> +     Requires nr_devices to be bigger than 1.

I have added this, but reworded slightly.

-- 
Jens Axboe
