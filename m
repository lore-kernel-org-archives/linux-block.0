Return-Path: <SRS0=5S7O=Q4=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF693C43381
	for <linux-block@archiver.kernel.org>; Thu, 21 Feb 2019 11:01:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF0F720855
	for <linux-block@archiver.kernel.org>; Thu, 21 Feb 2019 11:01:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726419AbfBULBx (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 21 Feb 2019 06:01:53 -0500
Received: from mx2.suse.de ([195.135.220.15]:39530 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725814AbfBULBw (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 21 Feb 2019 06:01:52 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id AD1A4AEFE;
        Thu, 21 Feb 2019 11:01:51 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 29DE11E0900; Thu, 21 Feb 2019 12:01:51 +0100 (CET)
Date:   Thu, 21 Feb 2019 12:01:51 +0100
From:   Jan Kara <jack@suse.cz>
To:     Dongli Zhang <dongli.zhang@oracle.com>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        axboe@kernel.dk, jack@suse.cz
Subject: Re: [PATCH 1/2] loop: do not print warn message if partition scan is
 successful
Message-ID: <20190221110151.GE27474@quack2.suse.cz>
References: <1550722655-15102-1-git-send-email-dongli.zhang@oracle.com>
 <1550722655-15102-2-git-send-email-dongli.zhang@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1550722655-15102-2-git-send-email-dongli.zhang@oracle.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu 21-02-19 12:17:34, Dongli Zhang wrote:
> Do not print warn message when the partition scan returns 0.
> 
> Fixes: d57f3374ba48 ("loop: Move special partition reread handling in loop_clr_fd()")
> Signed-off-by: Dongli Zhang <dongli.zhang@oracle.com>

Yeah, thanks for the fix! Not sure how come I didn't see this in my
testing. You can add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  drivers/block/loop.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/block/loop.c b/drivers/block/loop.c
> index cf55389..7908673 100644
> --- a/drivers/block/loop.c
> +++ b/drivers/block/loop.c
> @@ -1115,8 +1115,9 @@ static int __loop_clr_fd(struct loop_device *lo, bool release)
>  			err = __blkdev_reread_part(bdev);
>  		else
>  			err = blkdev_reread_part(bdev);
> -		pr_warn("%s: partition scan of loop%d failed (rc=%d)\n",
> -			__func__, lo_number, err);
> +		if (err)
> +			pr_warn("%s: partition scan of loop%d failed (rc=%d)\n",
> +				__func__, lo_number, err);
>  		/* Device is gone, no point in returning error */
>  		err = 0;
>  	}
> -- 
> 2.7.4
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
