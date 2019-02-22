Return-Path: <SRS0=hB6L=Q5=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FE29C43381
	for <linux-block@archiver.kernel.org>; Fri, 22 Feb 2019 11:47:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB6BD20643
	for <linux-block@archiver.kernel.org>; Fri, 22 Feb 2019 11:47:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726150AbfBVLrV (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 22 Feb 2019 06:47:21 -0500
Received: from mx2.suse.de ([195.135.220.15]:43176 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726131AbfBVLrV (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 22 Feb 2019 06:47:21 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 7661CAFE2;
        Fri, 22 Feb 2019 11:47:20 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id A234D1E0900; Fri, 22 Feb 2019 12:47:19 +0100 (CET)
Date:   Fri, 22 Feb 2019 12:47:19 +0100
From:   Jan Kara <jack@suse.cz>
To:     Dongli Zhang <dongli.zhang@oracle.com>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        axboe@kernel.dk, jack@suse.cz
Subject: Re: [PATCH v2 2/2] loop: set GENHD_FL_NO_PART_SCAN after
 blkdev_reread_part()
Message-ID: <20190222114719.GI23071@quack2.suse.cz>
References: <1550763223-21764-1-git-send-email-dongli.zhang@oracle.com>
 <1550763223-21764-3-git-send-email-dongli.zhang@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1550763223-21764-3-git-send-email-dongli.zhang@oracle.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu 21-02-19 23:33:43, Dongli Zhang wrote:
> Commit 0da03cab87e6
> ("loop: Fix deadlock when calling blkdev_reread_part()") moves
> blkdev_reread_part() out of the loop_ctl_mutex. However,
> GENHD_FL_NO_PART_SCAN is set before __blkdev_reread_part(). As a result,
> __blkdev_reread_part() will fail the check of GENHD_FL_NO_PART_SCAN and
> will not rescan the loop device to delete all partitions.
> 
> Below are steps to reproduce the issue:
> 
> step1 # dd if=/dev/zero of=tmp.raw bs=1M count=100
> step2 # losetup -P /dev/loop0 tmp.raw
> step3 # parted /dev/loop0 mklabel gpt
> step4 # parted -a none -s /dev/loop0 mkpart primary 64s 1
> step5 # losetup -d /dev/loop0
> 
> Step5 will not be able to delete /dev/loop0p1 (introduced by step4) and
> there is below kernel warning message:
> 
> [  464.414043] __loop_clr_fd: partition scan of loop0 failed (rc=-22)
> 
> This patch sets GENHD_FL_NO_PART_SCAN after blkdev_reread_part().
> 
> Fixes: 0da03cab87e6 ("loop: Fix deadlock when calling blkdev_reread_part()")
> Signed-off-by: Dongli Zhang <dongli.zhang@oracle.com>
> ---
> Changed since v1:
>   * move the setting of lo->lo_state to Lo_unbound after partscan has finished as well
>     (suggested by Jan Kara)
> 
>  drivers/block/loop.c | 26 ++++++++++++++++++++++----
>  1 file changed, 22 insertions(+), 4 deletions(-)

Thanks the patch looks good! Just one nit below:

> diff --git a/drivers/block/loop.c b/drivers/block/loop.c
> index 7908673..a13f5dc 100644
> --- a/drivers/block/loop.c
> +++ b/drivers/block/loop.c
> @@ -1034,6 +1034,16 @@ loop_init_xfer(struct loop_device *lo, struct loop_func_table *xfer,
>  	return err;
>  }
>  
> +static void loop_disable_partscan(struct loop_device *lo)
> +{

I don't think there's any benefit in having this small function with a single
caller and furthermore with the subtle sideeffect that it changes lo_state.
So I'd just put the code inline in __loop_clr_fd(). With that you can add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
