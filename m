Return-Path: <linux-block-owner@vger.kernel.org>
Received: from smtprelay0077.hostedemail.com ([216.40.44.77]:49857 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1750787AbcIIBUn (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 8 Sep 2016 21:20:43 -0400
Message-ID: <1473384038.13672.23.camel@perches.com>
Subject: Re: [PATCH 3/5] nbd: use flags instead of bool
From: Joe Perches <joe@perches.com>
To: Josef Bacik <jbacik@fb.com>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@fb.com,
        mpa@pengutronix.de, nbd-general@lists.sourceforge.net
Date: Thu, 08 Sep 2016 18:20:38 -0700
In-Reply-To: <1473369130-22986-4-git-send-email-jbacik@fb.com>
References: <1473369130-22986-1-git-send-email-jbacik@fb.com>
         <1473369130-22986-4-git-send-email-jbacik@fb.com>
Content-Type: text/plain; charset="ISO-8859-1"
Mime-Version: 1.0
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Thu, 2016-09-08 at 17:12 -0400, Josef Bacik wrote:
> In preparation for some future changes, change a few of the state bools over to
> normal bits to set/clear properly.
[]
> diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
[]
> @@ -41,8 +41,12 @@
>  
>  #include <linux/nbd.h>
>  
> +#define NBD_TIMEDOUT			0
> +#define NBD_DISCONNECT_REQUESTED	1
> +
>  struct nbd_device {
>  	u32 flags;
> +	unsigned long runtime_flags;

Better to use DECLARE_BITMAP

> @@ -626,7 +627,7 @@ static int __nbd_ioctl(struct block_device *bdev, struct nbd_device *nbd,
>  			return -EINVAL;
>  		}
>  
> -		nbd->disconnect = true;
> +		set_bit(NBD_DISCONNECT_REQUESTED, &nbd->runtime_flags);

And remove the & from runtime_flags here

