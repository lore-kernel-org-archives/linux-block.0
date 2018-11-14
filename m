Return-Path: <SRS0=CiZa=NZ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18951C43441
	for <linux-block@archiver.kernel.org>; Wed, 14 Nov 2018 02:37:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE6C322419
	for <linux-block@archiver.kernel.org>; Wed, 14 Nov 2018 02:37:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="LWpqq477"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE6C322419
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727770AbeKNMiM (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 14 Nov 2018 07:38:12 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:57838 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727357AbeKNMiM (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 14 Nov 2018 07:38:12 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id wAE2XiS4024680;
        Wed, 14 Nov 2018 02:37:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=3OCzkKOY9wwPmCvGXBWB1+4bZXtXbetdvS39TYjFeRo=;
 b=LWpqq477SboysrMeVVPDqGOYY6nXUg6jSjTD6Q2RdHGJaenmVET/3IVkA6goW1OlEtJx
 1UKir2trHCSVG/iosiN3qKqvFS5RO2eq43WUAWMYaDytYaV7bRXNM4PsoGL3EqbA4XGT
 ZVRkvqpgmOW66ONi/jicoSfp5xD4a2/QUG3fApVT/R0Y1lQHMS7S3+JRrjUHO5GXTkBw
 mR6BUHCSIgVumqri39HHFIBJDmvqFTbSyUNh4TWXnCysr1BZqC6dzBxYblZv7hMZe3Ti
 5MwlUxikx3dY5tzVt7XE1bYC+eKKH9sJmBQV5bLfJImzJ7ih1pjWuaEFvUjJQoK/lJKs vw== 
Received: from userv0021.oracle.com (userv0021.oracle.com [156.151.31.71])
        by aserp2120.oracle.com with ESMTP id 2nr7cs0q3y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 14 Nov 2018 02:37:01 +0000
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userv0021.oracle.com (8.14.4/8.14.4) with ESMTP id wAE2at8u026998
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 14 Nov 2018 02:36:55 GMT
Received: from abhmp0004.oracle.com (abhmp0004.oracle.com [141.146.116.10])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id wAE2atD2024458;
        Wed, 14 Nov 2018 02:36:55 GMT
Received: from localhost (/10.159.147.150)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 13 Nov 2018 18:36:55 -0800
Date:   Tue, 13 Nov 2018 18:36:54 -0800
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Dave Chinner <david@fromorbit.com>
Cc:     linux-xfs@vger.kernel.org, linux-block@vger.kernel.org
Subject: Re: [PATCH] block: fix 32 bit overflow in __blkdev_issue_discard()
Message-ID: <20181114023654.GJ4235@magnolia>
References: <20181113214337.20581-1-david@fromorbit.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181113214337.20581-1-david@fromorbit.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9076 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1811140021
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Nov 14, 2018 at 08:43:37AM +1100, Dave Chinner wrote:
> From: Dave Chinner <dchinner@redhat.com>
> 
> A discard cleanup merged into 4.20-rc2 causes fstests xfs/259 to
> fall into an endless loop in the discard code. The test is creating
> a device that is exactly 2^32 sectors in size to test mkfs boundary
> conditions around the 32 bit sector overflow region.
> 
> mkfs issues a discard for the entire device size by default, and
> hence this throws a sector count of 2^32 into
> blkdev_issue_discard(). It takes the number of sectors to discard as
> a sector_t - a 64 bit value.
> 
> The commit ba5d73851e71 ("block: cleanup __blkdev_issue_discard")
> takes this sector count and casts it to a 32 bit value before
> comapring it against the maximum allowed discard size the device
> has. This truncates away the upper 32 bits, and so if the lower 32
> bits of the sector count is zero, it starts issuing discards of
> length 0. This causes the code to fall into an endless loop, issuing
> a zero length discards over and over again on the same sector.
> 
> Fixes: ba5d73851e71 ("block: cleanup __blkdev_issue_discard")
> Signed-off-by: Dave Chinner <dchinner@redhat.com>

Fixes the regression for me too, so...

Tested-by: Darrick J. Wong <darrick.wong@oracle.com>
Reviewed-by: Darrick J. Wong <darrick.wong@oracle.com>

--D

> ---
>  block/blk-lib.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/block/blk-lib.c b/block/blk-lib.c
> index e8b3bb9bf375..144e156ed341 100644
> --- a/block/blk-lib.c
> +++ b/block/blk-lib.c
> @@ -55,9 +55,12 @@ int __blkdev_issue_discard(struct block_device *bdev, sector_t sector,
>  		return -EINVAL;
>  
>  	while (nr_sects) {
> -		unsigned int req_sects = min_t(unsigned int, nr_sects,
> +		sector_t req_sects = min_t(sector_t, nr_sects,
>  				bio_allowed_max_sectors(q));
>  
> +		WARN_ON_ONCE(req_sects == 0);
> +		WARN_ON_ONCE((req_sects << 9) > UINT_MAX);
> +
>  		bio = blk_next_bio(bio, 0, gfp_mask);
>  		bio->bi_iter.bi_sector = sector;
>  		bio_set_dev(bio, bdev);
> -- 
> 2.19.1
> 
