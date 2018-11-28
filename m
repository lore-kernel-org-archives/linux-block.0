Return-Path: <SRS0=FxMo=OH=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7968C43610
	for <linux-block@archiver.kernel.org>; Wed, 28 Nov 2018 05:09:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 80F7020832
	for <linux-block@archiver.kernel.org>; Wed, 28 Nov 2018 05:09:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 80F7020832
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=fromorbit.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727074AbeK1QJP (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 28 Nov 2018 11:09:15 -0500
Received: from ipmail07.adl2.internode.on.net ([150.101.137.131]:23750 "EHLO
        ipmail07.adl2.internode.on.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726894AbeK1QJP (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 28 Nov 2018 11:09:15 -0500
Received: from ppp59-167-129-252.static.internode.on.net (HELO dastard) ([59.167.129.252])
  by ipmail07.adl2.internode.on.net with ESMTP; 28 Nov 2018 15:38:52 +1030
Received: from dave by dastard with local (Exim 4.80)
        (envelope-from <david@fromorbit.com>)
        id 1gRs5i-00047o-VL; Wed, 28 Nov 2018 16:08:50 +1100
Date:   Wed, 28 Nov 2018 16:08:50 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     Allison Henderson <allison.henderson@oracle.com>
Cc:     linux-block@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        martin.petersen@oracle.com, shirley.ma@oracle.com,
        bob.liu@oracle.com
Subject: Re: [PATCH v1 5/7] xfs: Add device retry
Message-ID: <20181128050850.GJ6311@dastard>
References: <1543376991-5764-1-git-send-email-allison.henderson@oracle.com>
 <1543376991-5764-6-git-send-email-allison.henderson@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1543376991-5764-6-git-send-email-allison.henderson@oracle.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Nov 27, 2018 at 08:49:49PM -0700, Allison Henderson wrote:
> Check to see if the _xfs_buf_read fails.  If so loop over the
> available mirrors and retry the read
> 
> Signed-off-by: Allison Henderson <allison.henderson@oracle.com>
> ---
>  fs/xfs/xfs_buf.c | 28 +++++++++++++++++++++++++++-
>  1 file changed, 27 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/xfs/xfs_buf.c b/fs/xfs/xfs_buf.c
> index dd8ba59..f102d01 100644
> --- a/fs/xfs/xfs_buf.c
> +++ b/fs/xfs/xfs_buf.c
> @@ -21,6 +21,7 @@
>  #include <linux/migrate.h>
>  #include <linux/backing-dev.h>
>  #include <linux/freezer.h>
> +#include <linux/blkdev.h>
>  
>  #include "xfs_format.h"
>  #include "xfs_log_format.h"
> @@ -808,6 +809,8 @@ xfs_buf_read_map(
>  	const struct xfs_buf_ops *ops)
>  {
>  	struct xfs_buf		*bp;
> +	struct request_queue	*q;
> +	unsigned short		i;
>  
>  	flags |= XBF_READ;
>  
> @@ -820,7 +823,30 @@ xfs_buf_read_map(
>  	if (!(bp->b_flags & XBF_DONE)) {
>  		XFS_STATS_INC(target->bt_mount, xb_get_read);
>  		bp->b_ops = ops;
> -		_xfs_buf_read(bp, flags);
> +		q = bdev_get_queue(bp->b_target->bt_bdev);
> +
> +		/*
> +		 * Mirrors are indexed 1 - n, specified through the rw_hint.
> +		 * Setting the hint to 0 is unspecified and allows the block
> +		 * layer to decide.
> +		 */
> +		for (i = 0; i <= blk_queue_get_mirrors(q); i++) {
> +			bp->b_error = 0;
> +			bp->b_rw_hint = i;
> +			_xfs_buf_read(bp, flags);

So the first time through this loop the block layer devices what
device to read from, then we iterate devices 1..n on error.

Whihc means if device 0 is the only one with good information in it,
we may not ever actually read from it.

I'd suggest that a hint of "-1" (or equivalent max value) should be
used for "device selects mirror leg" rather than 0, so we can
actually read from the first device on command.

i.e.
		bp->b_error = 0;
		bp->b_rw_hint = -1;
		_xfs_buf_read(bp, flags);

		if (!bp->b_error)
			return bp;

		/* manual iteration to find a good copy */
		for (i = 0; i <= blk_queue_get_mirrors(q); i++) {
			bp->b_error = 0;
			bp->b_rw_hint = i;
			_xfs_buf_read(bp, flags);
......
> +
> +			switch (bp->b_error) {
> +			case -EIO:
> +			case -EFSCORRUPTED:
> +			case -EFSBADCRC:
> +				/* loop again */
> +				continue;
> +			default:
> +				goto retry_done;

Just return bp here, don't need a jump label for it.

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
