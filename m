Return-Path: <SRS0=leUH=UL=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63386C31E46
	for <linux-block@archiver.kernel.org>; Wed, 12 Jun 2019 09:10:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 34D832063F
	for <linux-block@archiver.kernel.org>; Wed, 12 Jun 2019 09:10:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="TJONNl46"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405904AbfFLJKf (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 12 Jun 2019 05:10:35 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:49358 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405024AbfFLJKf (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 12 Jun 2019 05:10:35 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5C994Zu173485;
        Wed, 12 Jun 2019 09:10:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=Ulh54NFWlYiUsKSjybeAIpal4mKAIsXmJ5eg+TyVy4A=;
 b=TJONNl46jkj2rOEEW8zkcTg/EZkaYU/9Y5Lt9va/kv0hfrSvCJqVm/bvd7+YKcqeN3yh
 ZNteWXn+pvjSFKvwLCEnN5yGmAl38vketTq5/dHrgfsqCzFNZzsxLnDNDQlHkQItSruu
 ClZA/mfy2WehXFn9eLG9ulCp8KEi+1Gt8s5KZc6DmyLpWSaXGtFyD/NSuoFXmnkitiGV
 3QDUEdRNDs8g8T4Ipb1056vy4kv6wozaqq8/tQ0qeLMnSGBS70SZgpX3zThwXk+fYU01
 cBWon0hUQVhkNsL5WtBoBLbkfaCpuS0+PW6ZGgkXMNpeq030zc6sjxI/7S6hlKm/xSH/ CQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2120.oracle.com with ESMTP id 2t05nqt3bb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 12 Jun 2019 09:10:33 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5C98wv5125228;
        Wed, 12 Jun 2019 09:10:33 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3020.oracle.com with ESMTP id 2t1jphwx6y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 12 Jun 2019 09:10:33 +0000
Received: from abhmp0005.oracle.com (abhmp0005.oracle.com [141.146.116.11])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x5C9AWpF002290;
        Wed, 12 Jun 2019 09:10:32 GMT
Received: from [192.168.1.16] (/101.95.182.98)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 12 Jun 2019 02:10:32 -0700
Subject: Re: [PATCH] null_blk: remove duplicate check for report zone
To:     Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
        linux-block@vger.kernel.org
References: <20190611221017.10264-1-chaitanya.kulkarni@wdc.com>
From:   Bob Liu <bob.liu@oracle.com>
Message-ID: <37020dbf-b01d-47a4-1a82-1778b1729890@oracle.com>
Date:   Wed, 12 Jun 2019 17:10:29 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190611221017.10264-1-chaitanya.kulkarni@wdc.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9285 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1906120064
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9285 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1906120064
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 6/12/19 6:10 AM, Chaitanya Kulkarni wrote:
> This patch removes the check in the null_blk_zoned for report zone
> command, where it checks for the dev-,>zoned before executing the report
> zone.
> 
> The null_zone_report() function is a block_device operation callback
> which is initialized in the null_blk_main.c and gets called as a part
> of blkdev for report zone IOCTL (BLKREPORTZONE).
> 
> blkdev_ioctl()
> blkdev_report_zones_ioctl()
>         blkdev_report_zones()
>                 blk_report_zones()
>                         disk->fops->report_zones()
>                                 nullb_zone_report();
> 
> The null_zone_report() will never get executed on the non-zoned block
> device, in the non zoned block device blk_queue_is_zoned() will always
> be false which is first check the blkdev_report_zones_ioctl()
> before actual low level driver report zone callback is executed.
> 
> Here is the detailed scenario:-
> 
> 1. modprobe null_blk
> null_init
> null_alloc_dev
>         dev->zoned = 0 
> null_add_dev
>         dev->zoned == 0
>                 so we don't set the q->limits.zoned = BLK_ZONED_HR
> 
> 2. blkzone report /dev/nullb0
> 
> blkdev_ioctl()
> blkdev_report_zones_ioctl()
>         blk_queue_is_zoned()
>                 blk_queue_is_zoned
>                         q->limits.zoned == 0
>                         return false
>         if (!blk_queue_is_zoned(q)) <--- true
>                 return -ENOTTY;              
> Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>

Looks good to me.
Reviewed-by: Bob Liu <bob.liu@oracle.com>

> ---
>  drivers/block/null_blk_zoned.c | 4 ----
>  1 file changed, 4 deletions(-)
> 
> diff --git a/drivers/block/null_blk_zoned.c b/drivers/block/null_blk_zoned.c
> index 5d1c261a2cfd..fca0c97ff1aa 100644
> --- a/drivers/block/null_blk_zoned.c
> +++ b/drivers/block/null_blk_zoned.c
> @@ -74,10 +74,6 @@ int null_zone_report(struct gendisk *disk, sector_t sector,
>  	struct nullb_device *dev = nullb->dev;
>  	unsigned int zno, nrz = 0;
>  
> -	if (!dev->zoned)
> -		/* Not a zoned null device */
> -		return -EOPNOTSUPP;
> -
>  	zno = null_zone_no(dev, sector);
>  	if (zno < dev->nr_zones) {
>  		nrz = min_t(unsigned int, *nr_zones, dev->nr_zones - zno);
> 

