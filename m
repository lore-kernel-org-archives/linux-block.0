Return-Path: <SRS0=FxMo=OH=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B88CEC43441
	for <linux-block@archiver.kernel.org>; Wed, 28 Nov 2018 05:20:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 893682081C
	for <linux-block@archiver.kernel.org>; Wed, 28 Nov 2018 05:20:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 893682081C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=fromorbit.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727634AbeK1QUs (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 28 Nov 2018 11:20:48 -0500
Received: from ipmail03.adl2.internode.on.net ([150.101.137.141]:1351 "EHLO
        ipmail03.adl2.internode.on.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726972AbeK1QUs (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 28 Nov 2018 11:20:48 -0500
Received: from ppp59-167-129-252.static.internode.on.net (HELO dastard) ([59.167.129.252])
  by ipmail03.adl2.internode.on.net with ESMTP; 28 Nov 2018 15:47:23 +1030
Received: from dave by dastard with local (Exim 4.80)
        (envelope-from <david@fromorbit.com>)
        id 1gRsDv-00048T-ON; Wed, 28 Nov 2018 16:17:19 +1100
Date:   Wed, 28 Nov 2018 16:17:19 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     Allison Henderson <allison.henderson@oracle.com>
Cc:     linux-block@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        martin.petersen@oracle.com, shirley.ma@oracle.com,
        bob.liu@oracle.com
Subject: Re: [PATCH v1 6/7] xfs: Rewrite retried read
Message-ID: <20181128051719.GK6311@dastard>
References: <1543376991-5764-1-git-send-email-allison.henderson@oracle.com>
 <1543376991-5764-7-git-send-email-allison.henderson@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1543376991-5764-7-git-send-email-allison.henderson@oracle.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Nov 27, 2018 at 08:49:50PM -0700, Allison Henderson wrote:
> If we had to try more than one mirror to get a successful
> read, then write that buffer back to correct the bad mirro
> 
> Signed-off-by: Allison Henderson <allison.henderson@oracle.com>
> ---
>  fs/xfs/xfs_buf.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/fs/xfs/xfs_buf.c b/fs/xfs/xfs_buf.c
> index f102d01..81f6491 100644
> --- a/fs/xfs/xfs_buf.c
> +++ b/fs/xfs/xfs_buf.c
> @@ -847,6 +847,14 @@ xfs_buf_read_map(
>  
>  		}
>  retry_done:
> +
> +		/*
> +		 * if we had to try more than one mirror to sucessfully read
> +		 * the buffer, write the buffer back
> +		 */
> +		if (!bp->b_error && i > 0)
> +			xfs_bwrite(bp);
> +

This can go in the case statement on retry and then you don't need
to check for i > 0 or, well, bp->b_error. i.e.

		swtich (bp->b_error) {
		case -EBADCRC:
		case -EIO:
		case -EFSCORRUPTED:
			/* try again from different copy */
			continue;
		0:
			/* good copy, rewrite it to repair bad copy */
			xfs_bwrite(bp);
			/* fallthrough */
		default:
			return bp;
		}

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
