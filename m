Return-Path: <SRS0=FxMo=OH=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63089C43441
	for <linux-block@archiver.kernel.org>; Wed, 28 Nov 2018 05:03:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A2E520832
	for <linux-block@archiver.kernel.org>; Wed, 28 Nov 2018 05:03:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2A2E520832
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=fromorbit.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727019AbeK1QDq (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 28 Nov 2018 11:03:46 -0500
Received: from ipmail07.adl2.internode.on.net ([150.101.137.131]:41355 "EHLO
        ipmail07.adl2.internode.on.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727008AbeK1QDq (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 28 Nov 2018 11:03:46 -0500
Received: from ppp59-167-129-252.static.internode.on.net (HELO dastard) ([59.167.129.252])
  by ipmail07.adl2.internode.on.net with ESMTP; 28 Nov 2018 15:33:24 +1030
Received: from dave by dastard with local (Exim 4.80)
        (envelope-from <david@fromorbit.com>)
        id 1gRs0R-00047K-NM; Wed, 28 Nov 2018 16:03:23 +1100
Date:   Wed, 28 Nov 2018 16:03:23 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     Allison Henderson <allison.henderson@oracle.com>
Cc:     linux-block@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        martin.petersen@oracle.com, shirley.ma@oracle.com,
        bob.liu@oracle.com
Subject: Re: [PATCH v1 4/7] xfs: Add b_rw_hint to xfs_buf
Message-ID: <20181128050323.GI6311@dastard>
References: <1543376991-5764-1-git-send-email-allison.henderson@oracle.com>
 <1543376991-5764-5-git-send-email-allison.henderson@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1543376991-5764-5-git-send-email-allison.henderson@oracle.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Nov 27, 2018 at 08:49:48PM -0700, Allison Henderson wrote:
> This patch adds a new field b_rw_hint to xfs_buf.  We will
> need this to properly initialize the new bio->bi_rw_hint when
> submitting the read request.  When the read completes, we
> then store the returned mirror in the b_rw_hint.
> 
> Signed-off-by: Allison Henderson <allison.henderson@oracle.com>
> ---
>  fs/xfs/xfs_buf.c | 5 ++++-
>  fs/xfs/xfs_buf.h | 7 +++++++
>  2 files changed, 11 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/xfs/xfs_buf.c b/fs/xfs/xfs_buf.c
> index b21ea2b..dd8ba59 100644
> --- a/fs/xfs/xfs_buf.c
> +++ b/fs/xfs/xfs_buf.c
> @@ -1322,8 +1322,10 @@ xfs_buf_bio_end_io(
>  	if (!bp->b_error && xfs_buf_is_vmapped(bp) && (bp->b_flags & XBF_READ))
>  		invalidate_kernel_vmap_range(bp->b_addr, xfs_buf_vmap_len(bp));
>  
> -	if (atomic_dec_and_test(&bp->b_io_remaining) == 1)
> +	if (atomic_dec_and_test(&bp->b_io_remaining) == 1) {
> +		bp->b_rw_hint = bio->bi_rw_hint;
>  		xfs_buf_ioend_async(bp);
> +	}
>  	bio_put(bio);
>  }
>  

This will miss setting bp->b_rw_hint for IO that completes before
submission returns to __xfs_buf_submit() (i.e. b_io_remaining is 2
at IO completion).

So I suspect it won't do the right thing on fast or synchronous
block devices like pmem. You should be able to tst this with a RAID1
made from two ramdisks...

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
