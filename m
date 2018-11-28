Return-Path: <SRS0=FxMo=OH=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98F7FC43441
	for <linux-block@archiver.kernel.org>; Wed, 28 Nov 2018 05:26:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 619F720873
	for <linux-block@archiver.kernel.org>; Wed, 28 Nov 2018 05:26:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="NcIM6OU5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 619F720873
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727082AbeK1Q0i (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 28 Nov 2018 11:26:38 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:33604 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726972AbeK1Q0h (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 28 Nov 2018 11:26:37 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id wAS5Ne1l095794;
        Wed, 28 Nov 2018 05:26:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=wbf8UyzTvYXYuhBbO3p1tI8ndl3x9OZ6HRs461Way/Q=;
 b=NcIM6OU5zzpZT+fZFhocPI25+e6lCHeyyLb9NDUFoAnjXl8ywWBY2IQb/IjK74kMCWD8
 VsUcq30gvZO1epat0KfhKXNjfK1IMJ7jNB9USs0351YiH8U6ZHWxY/SFpTdfBPWl70Fh
 SIgeq6h2cVbBoDPkBwa0hJBNrMb7HmAkIajjtgXBO4TsF79FarpcX44yIhBqdW6yp62S
 R9P8Lh/+NHjBWBiKrOYsCnYi8J5SfOw5ba7PyjnvPrx5/CitoNG3xaip8ITi1Mjsq8eQ
 GS4cpdWZ+BdnMVFnVU+WsQ6p+4pg89dDho+QxtsHXvGcjxTZimXzQQf8xFjqY59OFFWB ng== 
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
        by userp2130.oracle.com with ESMTP id 2nxx2u826w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 28 Nov 2018 05:26:13 +0000
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserv0022.oracle.com (8.14.4/8.14.4) with ESMTP id wAS5Q6Tl000576
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 28 Nov 2018 05:26:07 GMT
Received: from abhmp0006.oracle.com (abhmp0006.oracle.com [141.146.116.12])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id wAS5Q6tm008191;
        Wed, 28 Nov 2018 05:26:06 GMT
Received: from localhost (/10.159.132.173)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 27 Nov 2018 21:26:06 -0800
Date:   Tue, 27 Nov 2018 21:26:04 -0800
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Dave Chinner <david@fromorbit.com>
Cc:     Allison Henderson <allison.henderson@oracle.com>,
        linux-block@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        martin.petersen@oracle.com, shirley.ma@oracle.com,
        bob.liu@oracle.com
Subject: Re: [PATCH v1 6/7] xfs: Rewrite retried read
Message-ID: <20181128052604.GE8125@magnolia>
References: <1543376991-5764-1-git-send-email-allison.henderson@oracle.com>
 <1543376991-5764-7-git-send-email-allison.henderson@oracle.com>
 <20181128051719.GK6311@dastard>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181128051719.GK6311@dastard>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9090 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1811280049
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Nov 28, 2018 at 04:17:19PM +1100, Dave Chinner wrote:
> On Tue, Nov 27, 2018 at 08:49:50PM -0700, Allison Henderson wrote:
> > If we had to try more than one mirror to get a successful
> > read, then write that buffer back to correct the bad mirro
> > 
> > Signed-off-by: Allison Henderson <allison.henderson@oracle.com>
> > ---
> >  fs/xfs/xfs_buf.c | 8 ++++++++
> >  1 file changed, 8 insertions(+)
> > 
> > diff --git a/fs/xfs/xfs_buf.c b/fs/xfs/xfs_buf.c
> > index f102d01..81f6491 100644
> > --- a/fs/xfs/xfs_buf.c
> > +++ b/fs/xfs/xfs_buf.c
> > @@ -847,6 +847,14 @@ xfs_buf_read_map(
> >  
> >  		}
> >  retry_done:
> > +
> > +		/*
> > +		 * if we had to try more than one mirror to sucessfully read
> > +		 * the buffer, write the buffer back
> > +		 */
> > +		if (!bp->b_error && i > 0)
> > +			xfs_bwrite(bp);
> > +
> 
> This can go in the case statement on retry and then you don't need
> to check for i > 0 or, well, bp->b_error. i.e.
> 
> 		swtich (bp->b_error) {
> 		case -EBADCRC:
> 		case -EIO:
> 		case -EFSCORRUPTED:
> 			/* try again from different copy */
> 			continue;
> 		0:
> 			/* good copy, rewrite it to repair bad copy */
> 			xfs_bwrite(bp);

Some day we might want to provide some controls for how long we'll retry
these reads and whether or not we automatically rewrite buffers, since
some administrators might prefer fast fail to get failover started.

(Not now though)

--D

> 			/* fallthrough */
> 		default:
> 			return bp;
> 		}
> 
> Cheers,
> 
> Dave.
> -- 
> Dave Chinner
> david@fromorbit.com
