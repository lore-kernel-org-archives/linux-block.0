Return-Path: <SRS0=aQmj=Q2=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 039F5C00319
	for <linux-block@archiver.kernel.org>; Tue, 19 Feb 2019 03:00:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C807821900
	for <linux-block@archiver.kernel.org>; Tue, 19 Feb 2019 03:00:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="d7FMcOm9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725768AbfBSDAq (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 18 Feb 2019 22:00:46 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:40540 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725308AbfBSDAq (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 18 Feb 2019 22:00:46 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x1J2sJ9r004388;
        Tue, 19 Feb 2019 03:00:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=bb0vSjoRc5go8RL61OrCI9AruDJXk6iG1uBGGoIYDs8=;
 b=d7FMcOm9WwEloM284B956hXgJmQ7QD7yW3lAajJeHda/+Zy1Pa+L4eOiSvfC7psuVpWu
 o0H/QX10x5Z/DhRoieXioaJ12CNhAQKAkbL62r+Q9ZqlUdI8D2UVjuqu9r9NIeFlKP9P
 M/jDHzCYKjnBlvZjlnDaDL+y5IRjEigyx36zEWJQ4rPOL0KjmfZdAKrqO5IU6LsjQRLZ
 eHxiN2P+ZCwMdQh6g368KJ2nDcvsB+BpFioWnFwDTr6gIDZw/iBiW+4pzq63Xa72LqFz
 PV79miSLG+4ni6MlSyoOcNhTCLN+eeedLheglVFdxeW5EXyN2o37t14zjfj6pVxCwxuw qw== 
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
        by userp2120.oracle.com with ESMTP id 2qpb5r8gt2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 19 Feb 2019 03:00:33 +0000
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserv0022.oracle.com (8.14.4/8.14.4) with ESMTP id x1J30STN008662
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 19 Feb 2019 03:00:28 GMT
Received: from abhmp0020.oracle.com (abhmp0020.oracle.com [141.146.116.26])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x1J30R2V006126;
        Tue, 19 Feb 2019 03:00:27 GMT
Received: from localhost (/10.159.150.107)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 18 Feb 2019 18:55:24 -0800
Date:   Mon, 18 Feb 2019 18:55:20 -0800
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Dave Chinner <david@fromorbit.com>
Cc:     Bob Liu <bob.liu@oracle.com>, linux-block@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        martin.petersen@oracle.com, shirley.ma@oracle.com,
        allison.henderson@oracle.com, hch@infradead.org, adilger@dilger.ca
Subject: Re: [RFC PATCH v2 0/9] Block/XFS: Support alternative mirror device
 retry
Message-ID: <20190219025520.GB32253@magnolia>
References: <20190213095044.29628-1-bob.liu@oracle.com>
 <20190218213150.GE14116@dastard>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190218213150.GE14116@dastard>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9171 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1902190021
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Feb 19, 2019 at 08:31:50AM +1100, Dave Chinner wrote:
> On Wed, Feb 13, 2019 at 05:50:35PM +0800, Bob Liu wrote:
> > Motivation:
> > When fs data/metadata checksum mismatch, lower block devices may have other
> > correct copies. e.g. If XFS successfully reads a metadata buffer off a raid1 but
> > decides that the metadata is garbage, today it will shut down the entire
> > filesystem without trying any of the other mirrors.  This is a severe
> > loss of service, and we propose these patches to have XFS try harder to
> > avoid failure.
> > 
> > This patch prototype this mirror retry idea by:
> > * Adding @nr_mirrors to struct request_queue which is similar as
> >   blk_queue_nonrot(), filesystem can grab device request queue and check max
> >   mirrors this block device has.
> >   Helper functions were also added to get/set the nr_mirrors.
> > 
> > * Introducing bi_rd_hint just like bi_write_hint, but bi_rd_hint is a long bitmap
> > in order to support stacked layer case.
> > 
> > * Modify md/raid1 to support this retry feature.
> > 
> > * Adapter xfs to use this feature.
> >   If the read verify fails, we loop over the available mirrors and retry the read.
> 
> Why does the filesystem have to iterate every single posible
> combination of devices that are underneath it?
> 
> Wouldn't it be much simpler to be able to attach a verifier
> function to the bio, and have each layer that gets called iterate
> over all it's copies internally until the verfier function passes
> or all copies are exhausted?
> 
> This works for stacked mirrors - it can pass the higher layer
> verifier down as far as necessary. It can work for RAID5/6, too, by
> having that layer supply it's own verifier for reads that verifies
> parity and can reconstruct of failure, then when it's reconstructed
> a valid stripe it can run the verifier that was supplied to it from
> above, etc.
> 
> i.e. I dont see why only filesystems should drive retries or have to
> be aware of the underlying storage stacking. ISTM that each
> layer of the storage stack should be able to verify what has been
> returned to it is valid independently of the higher layer
> requirements. The only difference from a caller point of view should
> be submit_bio(bio); vs submit_bio_verify(bio, verifier_cb_func);

What if instead of constructing a giant pile of verifier call chain, we
simply had a return value from ->bi_end_io that would then be returned
from bio_endio()?  Stacked things like dm-linear would have to know how
to connect the upper endio to the lower endio though.  And that could
have its downsides, too.  How long do we tie up resources in the scsi
layer while upper levels are busy running verification functions...?

Hmmmmmmmmm....

--D

> Cheers,
> 
> Dave.
> -- 
> Dave Chinner
> david@fromorbit.com
