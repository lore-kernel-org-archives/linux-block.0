Return-Path: <sboisvert@gydle.com>
To: Peng Hao <penghao122@sina.com.cn>, axboe@kernel.dk
Cc: linux-block@vger.kernel.org, Peng Hao <peng.hao2@zte.com.cn>
References: <1539361453-3383-1-git-send-email-penghao122@sina.com.cn>
From: =?UTF-8?Q?S=c3=a9bastien_Boisvert?= <sboisvert@gydle.com>
Subject: Re: [PATCH] block/sx8 : remove unnecessory check
Message-ID: <f545d380-b6cc-c476-439d-edc3705845a0@gydle.com>
Date: Fri, 12 Oct 2018 13:01:41 -0400
MIME-Version: 1.0
In-Reply-To: <1539361453-3383-1-git-send-email-penghao122@sina.com.cn>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 2018-10-12 12:24 PM, Peng Hao wrote:
> From: Peng Hao <peng.hao2@zte.com.cn>
> 
> TAG_VALID(tag)= ((((tag) & 0xf) == 0xf) && (TAG_DECODE(tag) < 32)).
> But '(X & 0x1f) < 0x20(32)' is always true. The second half of
> TAG_VALID is unnecessary.
> 

Hello Peng Hao,

A small typo:

unnecessory => unnecessary


Your claim is that this is always true:
(TAG_DECODE(tag) < 32))

It is called with "TAG_VALID(handle)". handle is a u32.


Let's simplify it:

(TAG_DECODE(tag) < 32))

(((tag) >> 16) & 0x1f) < 32


As you point out, "X & 0x1f" only selects the 5 last significant bits.

0x1f = 0b 0000 0000 0001 1111
32   = 0b 0000 0000 0010 0000

That checks out !

Reviewed-by: Sébastien Boisvert <sboisvert@gydle.com>

> Signed-off-by: Peng Hao <peng.hao2@zte.com.cn>
> ---
>  drivers/block/sx8.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/block/sx8.c b/drivers/block/sx8.c
> index 4d90e5e..b8e9ebf 100644
> --- a/drivers/block/sx8.c
> +++ b/drivers/block/sx8.c
> @@ -75,7 +75,7 @@
>  /* 0xf is just arbitrary, non-zero noise; this is sorta like poisoning */
>  #define TAG_ENCODE(tag)	(((tag) << 16) | 0xf)
>  #define TAG_DECODE(tag)	(((tag) >> 16) & 0x1f)
> -#define TAG_VALID(tag)	((((tag) & 0xf) == 0xf) && (TAG_DECODE(tag) < 32))
> +#define TAG_VALID(tag)	(((tag) & 0xf) == 0xf)
>  
>  /* note: prints function name for you */
>  #ifdef CARM_DEBUG
> 
