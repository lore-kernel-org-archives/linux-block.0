Return-Path: <SRS0=FxMo=OH=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 551CBC43441
	for <linux-block@archiver.kernel.org>; Wed, 28 Nov 2018 05:22:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1BF0A20873
	for <linux-block@archiver.kernel.org>; Wed, 28 Nov 2018 05:22:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="w0UezZXe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1BF0A20873
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727432AbeK1QXN (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 28 Nov 2018 11:23:13 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:60938 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726894AbeK1QXN (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 28 Nov 2018 11:23:13 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id wAS5J6tZ056646;
        Wed, 28 Nov 2018 05:22:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=M6KDT99q+AHq3H5h55or9b+0G0YiTpLvNM9SQ/YTN04=;
 b=w0UezZXe7P8zr1gSEZteC20EF+T7meCDC2XxkJuWaQKVWIXsuvwt+jml/MD74Dm5U0YP
 bEsENKWpewxx4UM0MMhjNBwyaidBhngTsm9Voz9JBjaQToBCzcCeujP/xwSTnLhXnZhk
 JxTIDF/QaiSUqRMpGhNXQZnKLY6mcDrP+nI0r+iz8miZsFaT4NwAGhQYb6NmQ4xxLe/Z
 lVuKLMxE0iG1CYterx/pDjpH0Xf8y9rV1mHXYd7ruhoGO8OGZlk6yQxOnbPwdOV1VC5h
 R0S2LGLNq8FSHlrY3g4FkK970XG9ENzXsBbYfARtvn0dhwlUm7T5uEohETTUOC6dNFks PA== 
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
        by aserp2120.oracle.com with ESMTP id 2nxxkqfyx6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 28 Nov 2018 05:22:49 +0000
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userv0022.oracle.com (8.14.4/8.14.4) with ESMTP id wAS5MmKU030858
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 28 Nov 2018 05:22:48 GMT
Received: from abhmp0020.oracle.com (abhmp0020.oracle.com [141.146.116.26])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id wAS5MlbN006464;
        Wed, 28 Nov 2018 05:22:47 GMT
Received: from localhost (/10.159.132.173)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 27 Nov 2018 21:22:47 -0800
Date:   Tue, 27 Nov 2018 21:22:45 -0800
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Dave Chinner <david@fromorbit.com>
Cc:     Allison Henderson <allison.henderson@oracle.com>,
        linux-block@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        martin.petersen@oracle.com, shirley.ma@oracle.com,
        bob.liu@oracle.com
Subject: Re: [PATCH v1 5/7] xfs: Add device retry
Message-ID: <20181128052245.GD8125@magnolia>
References: <1543376991-5764-1-git-send-email-allison.henderson@oracle.com>
 <1543376991-5764-6-git-send-email-allison.henderson@oracle.com>
 <20181128050850.GJ6311@dastard>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181128050850.GJ6311@dastard>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9090 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1811280048
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Nov 28, 2018 at 04:08:50PM +1100, Dave Chinner wrote:
> On Tue, Nov 27, 2018 at 08:49:49PM -0700, Allison Henderson wrote:
> > Check to see if the _xfs_buf_read fails.  If so loop over the
> > available mirrors and retry the read
> > 
> > Signed-off-by: Allison Henderson <allison.henderson@oracle.com>
> > ---
> >  fs/xfs/xfs_buf.c | 28 +++++++++++++++++++++++++++-
> >  1 file changed, 27 insertions(+), 1 deletion(-)
> > 
> > diff --git a/fs/xfs/xfs_buf.c b/fs/xfs/xfs_buf.c
> > index dd8ba59..f102d01 100644
> > --- a/fs/xfs/xfs_buf.c
> > +++ b/fs/xfs/xfs_buf.c
> > @@ -21,6 +21,7 @@
> >  #include <linux/migrate.h>
> >  #include <linux/backing-dev.h>
> >  #include <linux/freezer.h>
> > +#include <linux/blkdev.h>
> >  
> >  #include "xfs_format.h"
> >  #include "xfs_log_format.h"
> > @@ -808,6 +809,8 @@ xfs_buf_read_map(
> >  	const struct xfs_buf_ops *ops)
> >  {
> >  	struct xfs_buf		*bp;
> > +	struct request_queue	*q;
> > +	unsigned short		i;
> >  
> >  	flags |= XBF_READ;
> >  
> > @@ -820,7 +823,30 @@ xfs_buf_read_map(
> >  	if (!(bp->b_flags & XBF_DONE)) {
> >  		XFS_STATS_INC(target->bt_mount, xb_get_read);
> >  		bp->b_ops = ops;
> > -		_xfs_buf_read(bp, flags);
> > +		q = bdev_get_queue(bp->b_target->bt_bdev);
> > +
> > +		/*
> > +		 * Mirrors are indexed 1 - n, specified through the rw_hint.
> > +		 * Setting the hint to 0 is unspecified and allows the block
> > +		 * layer to decide.
> > +		 */
> > +		for (i = 0; i <= blk_queue_get_mirrors(q); i++) {
> > +			bp->b_error = 0;
> > +			bp->b_rw_hint = i;
> > +			_xfs_buf_read(bp, flags);
> 
> So the first time through this loop the block layer devices what
> device to read from, then we iterate devices 1..n on error.
> 
> Whihc means if device 0 is the only one with good information in it,
> we may not ever actually read from it.
> 
> I'd suggest that a hint of "-1" (or equivalent max value) should be
> used for "device selects mirror leg" rather than 0, so we can
> actually read from the first device on command.

"read from the first device on command" => "set bio.bi_rw_hint = 1"...

> i.e.
> 		bp->b_error = 0;
> 		bp->b_rw_hint = -1;

...which is confusing.  The intended behavior for this RFC (though not
so well documented) is that bi_rw_hint == 0 means "let the device
choose", and rw_hint > 1 means "choose mirror (rw_hint - 1)".  That's
sort of an odd behavior because now we have:

blk_queue_get_mirrors(q) returns 5 (as in 5 mirrors) but we access the
5 mirrors as indices 1-5, not 0-4 like most programmers would probably
expect.

Also, I think it's probably necessary to create a #define to attach a
name to the "let the device choose" value...

#define BIO_RW_HINT_ANY_MIRROR	(0)

for (i = BIO_RW_HINT_ANY_MIRROR; i <= blk_queue_get_mirrors(q); i++) {
	...
	bp->b_rw_hint = i;
	...
	_xfs_buf_read(bp, flags);
	...
}

(or offset things -1 like you propose)

--D

> 		_xfs_buf_read(bp, flags);
> 
> 		if (!bp->b_error)
> 			return bp;
> 
> 		/* manual iteration to find a good copy */
> 		for (i = 0; i <= blk_queue_get_mirrors(q); i++) {
> 			bp->b_error = 0;
> 			bp->b_rw_hint = i;
> 			_xfs_buf_read(bp, flags);
> ......
> > +
> > +			switch (bp->b_error) {
> > +			case -EIO:
> > +			case -EFSCORRUPTED:
> > +			case -EFSBADCRC:
> > +				/* loop again */
> > +				continue;
> > +			default:
> > +				goto retry_done;
> 
> Just return bp here, don't need a jump label for it.
> 
> Cheers,
> 
> Dave.
> -- 
> Dave Chinner
> david@fromorbit.com
