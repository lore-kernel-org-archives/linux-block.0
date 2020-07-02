Return-Path: <SRS0=sMug=AN=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E107CC433DF
	for <linux-block@archiver.kernel.org>; Thu,  2 Jul 2020 16:57:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BF1F92088E
	for <linux-block@archiver.kernel.org>; Thu,  2 Jul 2020 16:57:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="kgIqadgb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726140AbgGBQ5e (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 2 Jul 2020 12:57:34 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:44450 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726632AbgGBQ5e (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 2 Jul 2020 12:57:34 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 062GqJGE156916;
        Thu, 2 Jul 2020 16:57:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=BvjLT1ZYJAR6dbqrkdQx5cOnxCqmgZXn/o58vda98r4=;
 b=kgIqadgbCDfs+DKLhXNxl+MKXL014Y8XC5Iyhjq3i/IZt6iBN0x0CHOCo4F5fpz6KVd9
 oLy46+d/JU+wD8y9cLXFgvnrp6wBL6D176z2qk2J6gEnwed9wSWeZGcGsfm3BcNvetZx
 Dll++F7VHLCi7nUSNstk7OTgR6kftrCtUpD+sntQLqsgvZ0ygPT4TDRtnCZD2+zJBRlB
 xwoktOfnqycyD6Cak15Rdtpks5B0F5ljb1NVnFw76FuSp4SM8urh7mgOzdKG14thEFlD
 LXMsFCxKgY1qkY+lhZmaKS9MiwMSTZad16LP42/Owf3LR0WESBcDHW4BAlJJlUDSVJHK uQ== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2120.oracle.com with ESMTP id 31xx1e6fap-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 02 Jul 2020 16:57:25 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 062GrsiH121697;
        Thu, 2 Jul 2020 16:57:24 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3030.oracle.com with ESMTP id 31xg218b9t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 02 Jul 2020 16:57:24 +0000
Received: from abhmp0002.oracle.com (abhmp0002.oracle.com [141.146.116.8])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 062GvNZn023108;
        Thu, 2 Jul 2020 16:57:23 GMT
Received: from localhost (/10.159.237.133)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 02 Jul 2020 16:57:23 +0000
Date:   Thu, 2 Jul 2020 09:57:21 -0700
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Shijie Luo <luoshijie1@huawei.com>
Cc:     linux-block@vger.kernel.org, axboe@kernel.dk
Subject: Re: [PATCH] loop: change to punch hole if zero range is not supported
Message-ID: <20200702165721.GS7625@magnolia>
References: <20200702015401.51199-1-luoshijie1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200702015401.51199-1-luoshijie1@huawei.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9670 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 spamscore=0 phishscore=0
 malwarescore=0 mlxlogscore=999 adultscore=0 mlxscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2007020115
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9670 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 clxscore=1011 adultscore=0
 suspectscore=0 mlxlogscore=999 cotscore=-2147483648 lowpriorityscore=0
 malwarescore=0 phishscore=0 impostorscore=0 mlxscore=0 spamscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2004280000 definitions=main-2007020115
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Jul 01, 2020 at 09:54:01PM -0400, Shijie Luo wrote:
> We found a problem when excuting these operations.
> 
> $ cd /tmp
> $ qemu-img create -f raw test.img 10G
> $ mknod -m 0660 /dev/loop0 b 7 0
> $ losetup /dev/loop0 test.img
> $ mkfs /dev/loop0
> 
> Here is the error message.
> 
> [  142.364823] blk_update_request: operation not supported error,
>  dev loop0, sector 20971392 op 0x9:(WRITE_ZEROES) flags 0x1000800
>  phys_seg 0 prio class 0
> [  142.371823] blk_update_request: operation not supported error,
>  dev loop0, sector 5144 op 0x9:(WRITE_ZEROES) flags 0x1000800
>  phys_seg 0 prio class 0
> 
> The problem is that not all filesystem support zero range (eg, tmpfs), if
>  filesystem doesn 't support zero range, change to punch hole to fix it.

NAK, ZERO_RANGE requires[1] that "Within the specified range, blocks are
preallocated for the regions that span the holes in the file."
PUNCH_HOLE has the opposite effect, and does not qualify as a
replacement.

--D

[1] https://man7.org/linux/man-pages/man2/fallocate.2.html

> Fixes: efcfec579f613 ("loop: fix no-unmap write-zeroes request behavior")
> Signed-off-by: Shijie Luo <luoshijie1@huawei.com>
> ---
>  drivers/block/loop.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/block/loop.c b/drivers/block/loop.c
> index c33bbbfd1bd9..504e658adcaf 100644
> --- a/drivers/block/loop.c
> +++ b/drivers/block/loop.c
> @@ -450,6 +450,13 @@ static int lo_fallocate(struct loop_device *lo, struct request *rq, loff_t pos,
>  	}
>  
>  	ret = file->f_op->fallocate(file, mode, pos, blk_rq_bytes(rq));
> +
> +	if ((ret == -EOPNOTSUPP) && (mode & FALLOC_FL_ZERO_RANGE)) {
> +		mode &= ~FALLOC_FL_ZERO_RANGE;
> +		mode |= FALLOC_FL_PUNCH_HOLE;
> +		ret = file->f_op->fallocate(file, mode, pos, blk_rq_bytes(rq));
> +	}
> +
>  	if (unlikely(ret && ret != -EINVAL && ret != -EOPNOTSUPP))
>  		ret = -EIO;
>   out:
> -- 
> 2.19.1
> 
