Return-Path: <jthumshirn@suse.de>
Date: Mon, 23 Jan 2017 10:15:11 +0100
From: Johannes Thumshirn <jthumshirn@suse.de>
To: SF Markus Elfring <elfring@users.sourceforge.net>
Cc: linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
	LKML <linux-kernel@vger.kernel.org>,
	kernel-janitors@vger.kernel.org
Subject: Re: [PATCH 1/5] blk-throttle: Move three assignments for the
 variable "ret" in tg_set_max()
Message-ID: <20170123091510.GA3517@linux-x5ow.site>
References: <e734cafa-eec0-9d5b-b368-2de496a96c80@users.sourceforge.net>
 <75495d45-cfc4-9740-39e4-bd4c3e71232b@users.sourceforge.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <75495d45-cfc4-9740-39e4-bd4c3e71232b@users.sourceforge.net>
List-ID: <linux-block@vger.kernel.org>

On Sun, Jan 22, 2017 at 09:31:29AM +0100, SF Markus Elfring wrote:
> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Sat, 21 Jan 2017 21:23:06 +0100
> 
> A local variable was set to an error code before a concrete error situation
> was detected. Thus move the corresponding assignments into if branches
> to indicate a software failure there.
> 
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
> ---
>  block/blk-throttle.c | 23 +++++++++++++----------
>  1 file changed, 13 insertions(+), 10 deletions(-)
> 
> diff --git a/block/blk-throttle.c b/block/blk-throttle.c
> index 6f4c96e5f86b..51d112deb02e 100644
> --- a/block/blk-throttle.c
> +++ b/block/blk-throttle.c
> @@ -1327,27 +1327,30 @@ static ssize_t tg_set_max(struct kernfs_open_file *of,
>  			break;
>  		ctx.body += len;
>  
> -		ret = -EINVAL;
>  		p = tok;
>  		strsep(&p, "=");
> -		if (!p || (sscanf(p, "%llu", &val) != 1 && strcmp(p, "max")))
> +		if (!p || (sscanf(p, "%llu", &val) != 1 && strcmp(p, "max"))) {
> +			ret = -EINVAL;
>  			goto out_finish;
> +		}

Sorry, I don't like this patch. We know the next error if we encounter one
will be EINVAL until we change it. Your patch doesn't introduce a functual
change and doesn't improve readability, so I don't really see a point for it.

Byte,
	Johannes

-- 
Johannes Thumshirn                                          Storage
jthumshirn@suse.de                                +49 911 74053 689
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N�rnberg
GF: Felix Imend�rffer, Jane Smithard, Graham Norton
HRB 21284 (AG N�rnberg)
Key fingerprint = EC38 9CAB C2C4 F25D 8600 D0D0 0393 969D 2D76 0850
