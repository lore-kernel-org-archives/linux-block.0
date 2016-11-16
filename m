Return-Path: <yasu.isimatu@gmail.com>
Return-Path: <yasu.isimatu@gmail.com>
Subject: Re: [PATCH] null_blk: Add notes to use LightNVM
To: linux-kernel@vger.kernel.org, linux-block@vger.kernel.org
References: <37a5a6a3-cd8b-db98-b4f3-7bd66a5bf4d8@gmail.com>
Cc: axboe@kernel.dk
From: Yasuaki Ishimatsu <yasu.isimatu@gmail.com>
Message-ID: <19ff1755-29ce-715f-da02-448d233f19d4@gmail.com>
Date: Wed, 16 Nov 2016 10:19:30 -0500
MIME-Version: 1.0
In-Reply-To: <37a5a6a3-cd8b-db98-b4f3-7bd66a5bf4d8@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
List-ID: <linux-block@vger.kernel.org>

Could you review the patch?

On 10/27/2016 11:56 AM, Yasuaki Ishimatsu wrote:
> If CONFIG_NVM is disabled, loading null_block module with use_lightnvm=1
> fails. But there are no messages and documents related to the failure.
>
> So the patch adds the notes to use LightNVM.
>
> Signed-off-by: Yasuaki Ishimatsu <isimatu.yasuaki@jp.fujitsu.com>
> Cc: Jens Axboe <axboe@kernel.dk>
> ---
>  Documentation/block/null_blk.txt | 2 +-
>  drivers/block/null_blk.c         | 1 +
>  2 files changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/Documentation/block/null_blk.txt b/Documentation/block/null_blk.txt
> index d8880ca..0365a26 100644
> --- a/Documentation/block/null_blk.txt
> +++ b/Documentation/block/null_blk.txt
> @@ -72,4 +72,4 @@ use_per_node_hctx=[0/1]: Default: 0
>       queue for each CPU node in the system.
>
>  use_lightnvm=[0/1]: Default: 0
> -  Register device with LightNVM. Requires blk-mq to be used.
> +  Register device with LightNVM. Requires blk-mq and CONFIG_NVM=y to be used.
> diff --git a/drivers/block/null_blk.c b/drivers/block/null_blk.c
> index ba6f4a2e..4943ee2 100644
> --- a/drivers/block/null_blk.c
> +++ b/drivers/block/null_blk.c
> @@ -577,6 +577,7 @@ static void null_nvm_unregister(struct nullb *nullb)
>  #else
>  static int null_nvm_register(struct nullb *nullb)
>  {
> +    pr_err("null_blk: CONFIG_NVM needs to be enabled for LightNVM\n");
>      return -EINVAL;
>  }
>  static void null_nvm_unregister(struct nullb *nullb) {}
