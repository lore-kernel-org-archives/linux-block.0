Return-Path: <SRS0=3pRW=3I=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0349AC32771
	for <linux-block@archiver.kernel.org>; Sun, 19 Jan 2020 01:47:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB35F2468C
	for <linux-block@archiver.kernel.org>; Sun, 19 Jan 2020 01:47:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="BBph0UEF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729014AbgASBry (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 18 Jan 2020 20:47:54 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:34678 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728779AbgASBrx (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 18 Jan 2020 20:47:53 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 00J1iCUw177678;
        Sun, 19 Jan 2020 01:47:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2019-08-05;
 bh=VD8E+v/6K89dpk+5pvqo8X9az9h0A/hX8rT0o8KnhtE=;
 b=BBph0UEF5XqSu6x3H6h7dfj9DjC9kOu0EbC/5QdouLBghCmK6j+h4svabydkRSM0F6r5
 OBgXsvWc6K43emomYYaqd6lThWvxb797o2wZmm8EW9IAXt4tFttllEDL0hWPOSGLGk3E
 8XnvuqvyexgD/lezdPG46XSX2uhgaIDx5fv1eKSIJcSLjZuYynJIRpBJuvPGqVOIT1HK
 xdDsbxtDP30iSLae0gG+PakZ0AdU+lZH7RO3yD2ykWYO2EuK9ne8c+jjPJ3v6tj6qOrm
 8CXtluoseR4EmLyl2JCUWOUAABBaEi0Y5WiAaWMKr3g6Ol/sWxh1agFykCsqlJ/9V2j/ sQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2120.oracle.com with ESMTP id 2xktnqt44f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 19 Jan 2020 01:47:21 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 00J1iAkn073220;
        Sun, 19 Jan 2020 01:47:20 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3020.oracle.com with ESMTP id 2xmbhqpwww-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 19 Jan 2020 01:47:20 +0000
Received: from abhmp0013.oracle.com (abhmp0013.oracle.com [141.146.116.19])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 00J1l9eS003461;
        Sun, 19 Jan 2020 01:47:09 GMT
Received: from [192.168.1.14] (/114.88.246.185)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Sat, 18 Jan 2020 17:47:09 -0800
Subject: Re: [PATCH block v2 1/3] block: Add @flags argument to
 bdev_write_zeroes_sectors()
To:     Kirill Tkhai <ktkhai@virtuozzo.com>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, martin.petersen@oracle.com,
        axboe@kernel.dk, tytso@mit.edu, adilger.kernel@dilger.ca,
        Chaitanya.Kulkarni@wdc.com, darrick.wong@oracle.com,
        ming.lei@redhat.com, osandov@fb.com, jthumshirn@suse.de,
        minwoo.im.dev@gmail.com, damien.lemoal@wdc.com,
        andrea.parri@amarulasolutions.com, hare@suse.com, tj@kernel.org,
        ajay.joshi@wdc.com, sagi@grimberg.me, dsterba@suse.com,
        bvanassche@acm.org, dhowells@redhat.com, asml.silence@gmail.com
References: <157917805422.88675.6477661554332322975.stgit@localhost.localdomain>
 <157917815798.88675.11900718803129164489.stgit@localhost.localdomain>
From:   Bob Liu <bob.liu@oracle.com>
Message-ID: <a8c5c5fd-d6b1-950e-0493-b5020e5ca87d@oracle.com>
Date:   Sun, 19 Jan 2020 09:46:55 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <157917815798.88675.11900718803129164489.stgit@localhost.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9504 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-2001190011
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9504 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-2001190011
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 1/16/20 8:35 PM, Kirill Tkhai wrote:
> This is a preparation for next patch, which introduces
> a new flag BLKDEV_ZERO_ALLOCATE for calls, which need
> only allocation of blocks and don't need actual blocks
> zeroing.
> 
> CC: Martin K. Petersen <martin.petersen@oracle.com>
> Signed-off-by: Kirill Tkhai <ktkhai@virtuozzo.com>
> ---
>  block/blk-lib.c                     |    6 +++---
>  drivers/md/dm-kcopyd.c              |    2 +-
>  drivers/target/target_core_iblock.c |    4 ++--
>  include/linux/blkdev.h              |    3 ++-
>  4 files changed, 8 insertions(+), 7 deletions(-)
> 

Looks good to me.
Reviewed-by: Bob Liu <bob.liu@oracle.com>

> diff --git a/block/blk-lib.c b/block/blk-lib.c
> index 5f2c429d4378..3e38c93cfc53 100644
> --- a/block/blk-lib.c
> +++ b/block/blk-lib.c
> @@ -224,7 +224,7 @@ static int __blkdev_issue_write_zeroes(struct block_device *bdev,
>  		return -EPERM;
>  
>  	/* Ensure that max_write_zeroes_sectors doesn't overflow bi_size */
> -	max_write_zeroes_sectors = bdev_write_zeroes_sectors(bdev);
> +	max_write_zeroes_sectors = bdev_write_zeroes_sectors(bdev, 0);
>  
>  	if (max_write_zeroes_sectors == 0)
>  		return -EOPNOTSUPP;
> @@ -362,7 +362,7 @@ int blkdev_issue_zeroout(struct block_device *bdev, sector_t sector,
>  	sector_t bs_mask;
>  	struct bio *bio;
>  	struct blk_plug plug;
> -	bool try_write_zeroes = !!bdev_write_zeroes_sectors(bdev);
> +	bool try_write_zeroes = !!bdev_write_zeroes_sectors(bdev, 0);
>  
>  	bs_mask = (bdev_logical_block_size(bdev) >> 9) - 1;
>  	if ((sector | nr_sects) & bs_mask)
> @@ -391,7 +391,7 @@ int blkdev_issue_zeroout(struct block_device *bdev, sector_t sector,
>  			try_write_zeroes = false;
>  			goto retry;
>  		}
> -		if (!bdev_write_zeroes_sectors(bdev)) {
> +		if (!bdev_write_zeroes_sectors(bdev, 0)) {
>  			/*
>  			 * Zeroing offload support was indicated, but the
>  			 * device reported ILLEGAL REQUEST (for some devices
> diff --git a/drivers/md/dm-kcopyd.c b/drivers/md/dm-kcopyd.c
> index 1bbe4a34ef4c..f1b8e7926dd4 100644
> --- a/drivers/md/dm-kcopyd.c
> +++ b/drivers/md/dm-kcopyd.c
> @@ -831,7 +831,7 @@ void dm_kcopyd_copy(struct dm_kcopyd_client *kc, struct dm_io_region *from,
>  		 */
>  		job->rw = REQ_OP_WRITE_ZEROES;
>  		for (i = 0; i < job->num_dests; i++)
> -			if (!bdev_write_zeroes_sectors(job->dests[i].bdev)) {
> +			if (!bdev_write_zeroes_sectors(job->dests[i].bdev, 0)) {
>  				job->rw = WRITE;
>  				break;
>  			}
> diff --git a/drivers/target/target_core_iblock.c b/drivers/target/target_core_iblock.c
> index 51ffd5c002de..73a63e197bf5 100644
> --- a/drivers/target/target_core_iblock.c
> +++ b/drivers/target/target_core_iblock.c
> @@ -117,7 +117,7 @@ static int iblock_configure_device(struct se_device *dev)
>  	 * Enable write same emulation for IBLOCK and use 0xFFFF as
>  	 * the smaller WRITE_SAME(10) only has a two-byte block count.
>  	 */
> -	max_write_zeroes_sectors = bdev_write_zeroes_sectors(bd);
> +	max_write_zeroes_sectors = bdev_write_zeroes_sectors(bd, 0);
>  	if (max_write_zeroes_sectors)
>  		dev->dev_attrib.max_write_same_len = max_write_zeroes_sectors;
>  	else
> @@ -468,7 +468,7 @@ iblock_execute_write_same(struct se_cmd *cmd)
>  		return TCM_INVALID_CDB_FIELD;
>  	}
>  
> -	if (bdev_write_zeroes_sectors(bdev)) {
> +	if (bdev_write_zeroes_sectors(bdev, 0)) {
>  		if (!iblock_execute_zero_out(bdev, cmd))
>  			return 0;
>  	}
> diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
> index c45779f00cbd..4cd69552df9a 100644
> --- a/include/linux/blkdev.h
> +++ b/include/linux/blkdev.h
> @@ -1418,7 +1418,8 @@ static inline unsigned int bdev_write_same(struct block_device *bdev)
>  	return 0;
>  }
>  
> -static inline unsigned int bdev_write_zeroes_sectors(struct block_device *bdev)
> +static inline unsigned int bdev_write_zeroes_sectors(struct block_device *bdev,
> +						     unsigned int flags)
>  {
>  	struct request_queue *q = bdev_get_queue(bdev);
>  
> 
> 

