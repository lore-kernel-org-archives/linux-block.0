Return-Path: <SRS0=0P76=QX=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 722CBC4360F
	for <linux-block@archiver.kernel.org>; Sat, 16 Feb 2019 03:02:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3743F222D0
	for <linux-block@archiver.kernel.org>; Sat, 16 Feb 2019 03:02:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="eC1KSju2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393594AbfBPDCj (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 15 Feb 2019 22:02:39 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:42204 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726232AbfBPDCi (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 15 Feb 2019 22:02:38 -0500
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x1G2sPX0122397;
        Sat, 16 Feb 2019 03:02:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : references : date : in-reply-to : message-id : mime-version :
 content-type; s=corp-2018-07-02;
 bh=3DHiV+HuL9ZoLMeJY985DQ4rbHusWDKJOqlprPqEnSA=;
 b=eC1KSju2fi8mr13hREK+WFrKw/yLra5IU00+4udXQmlWH/LIEQ1qFglSonVj4moOwCrs
 TYZao6J6Joy3w202zjwoXBGsMUQI2aWz3m2PhuJ9gu0ezBB05R/Y1nS/aoL50oqjcm2P
 0zQd4vJU3wCrcU3rwgJ/XBFVJEpXWg1Z/JmGahJ/vp8A4nROTB/jbpKY5sY5+sku/DqZ
 8bR441l5J0XQerOJ3fEZaC9353zr61ORwZ1kJxfUAs6qzjUa6n0KYcFvtbVlE0HrE/y8
 yx8oK/vCHB5OJBtBJI3rHbAQPMtnWINZsct6Z3MEwjXmTXOq5/PGxHAYWid6Vk80VnwA Hw== 
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
        by aserp2130.oracle.com with ESMTP id 2qp81dr69v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 16 Feb 2019 03:02:31 +0000
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserv0022.oracle.com (8.14.4/8.14.4) with ESMTP id x1G32Q5L003046
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 16 Feb 2019 03:02:26 GMT
Received: from abhmp0017.oracle.com (abhmp0017.oracle.com [141.146.116.23])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x1G32Pxw004938;
        Sat, 16 Feb 2019 03:02:26 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Sat, 16 Feb 2019 03:02:24 +0000
To:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc:     linux-scsi@vger.kernel.org, linux-block@vger.kernel.org,
        Jeremy Cline <jeremy@jcline.org>,
        Oleksii Kurochko <olkuroch@cisco.com>, stable@vger.kernel.org
Subject: Re: [PATCH v2] scsi: sd: block: Fix regressions in read-only block device handling
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <yq1d0nxuf73.fsf@oracle.com>
        <20190213025717.20057-1-martin.petersen@oracle.com>
Date:   Fri, 15 Feb 2019 22:02:22 -0500
In-Reply-To: <20190213025717.20057-1-martin.petersen@oracle.com> (Martin
        K. Petersen's message of "Tue, 12 Feb 2019 21:57:17 -0500")
Message-ID: <yq1d0nso2pt.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9168 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1902160018
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


Christoph? Jens?

> Some devices come online in write protected state and switch to
> read-write once they are ready to process I/O requests. These devices
> broke with commit 20bd1d026aac ("scsi: sd: Keep disk read-only when
> re-reading partition") because we had no way to distinguish between a
> user decision to set a block_device read-only and the actual hardware
> device being write-protected.
>
> Because partitions are dropped and recreated on revalidate we are
> unable to persist any user-provided policy in hd_struct. Introduce a
> bitmap in struct gendisk to track the user configuration. This bitmap
> is updated when BLKROSET is called on a given disk or partition.
>
> A helper function, get_user_ro(), is provided to determine whether the
> ioctl has forced read-only state for a given block device. This helper
> is used by set_disk_ro() and add_partition() to ensure that both
> existing and newly created partitions will get the correct state.
>
>  - If BLKROSET sets a whole disk device read-only, all partitions will
>    now end up in a read-only state.
>
>  - If BLKROSET sets a given partition read-only, that partition will
>    remain read-only post revalidate.
>
>  - Otherwise both the whole disk device and any partitions will
>    reflect the write protect state of the underlying device.
>
> Cc: Jeremy Cline <jeremy@jcline.org>
> Cc: Oleksii Kurochko <olkuroch@cisco.com>
> Cc: stable@vger.kernel.org # v4.16+
> Reported-by: Oleksii Kurochko <olkuroch@cisco.com>
> Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=201221
> Fixes: 20bd1d026aac ("scsi: sd: Keep disk read-only when re-reading partition")
> Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
>
> ---
>
> v2:
> 	- Track user read-only state in a bitmap
>
> 	- Work around the regression that caused us to drop user
> 	  preferences on revalidate
> ---
>  block/genhd.c             | 22 +++++++++++++++++-----
>  block/ioctl.c             |  4 ++++
>  block/partition-generic.c |  2 +-
>  drivers/scsi/sd.c         |  4 +---
>  include/linux/genhd.h     |  2 ++
>  5 files changed, 25 insertions(+), 9 deletions(-)
>
> diff --git a/block/genhd.c b/block/genhd.c
> index 1dd8fd6613b8..34667eb1d3cc 100644
> --- a/block/genhd.c
> +++ b/block/genhd.c
> @@ -1544,19 +1544,31 @@ void set_device_ro(struct block_device *bdev, int flag)
>  
>  EXPORT_SYMBOL(set_device_ro);
>  
> +bool get_user_ro(struct gendisk *disk, unsigned int partno)
> +{
> +	/* Is the user read-only bit set for the whole disk device? */
> +	if (test_bit(0, disk->user_ro_bitmap))
> +		return true;
> +
> +	/* Is the user read-only bit set for this particular partition? */
> +	if (test_bit(partno, disk->user_ro_bitmap))
> +		return true;
> +
> +	return false;
> +}
> +EXPORT_SYMBOL(get_user_ro);
> +
>  void set_disk_ro(struct gendisk *disk, int flag)
>  {
>  	struct disk_part_iter piter;
>  	struct hd_struct *part;
>  
> -	if (disk->part0.policy != flag) {
> +	if (disk->part0.policy != flag)
>  		set_disk_ro_uevent(disk, flag);
> -		disk->part0.policy = flag;
> -	}
>  
> -	disk_part_iter_init(&piter, disk, DISK_PITER_INCL_EMPTY);
> +	disk_part_iter_init(&piter, disk, DISK_PITER_INCL_EMPTY_PART0);
>  	while ((part = disk_part_iter_next(&piter)))
> -		part->policy = flag;
> +		part->policy = get_user_ro(disk, part->partno) ?: flag;
>  	disk_part_iter_exit(&piter);
>  }
>  
> diff --git a/block/ioctl.c b/block/ioctl.c
> index 4825c78a6baa..41206df89485 100644
> --- a/block/ioctl.c
> +++ b/block/ioctl.c
> @@ -451,6 +451,10 @@ static int blkdev_roset(struct block_device *bdev, fmode_t mode,
>  		return ret;
>  	if (get_user(n, (int __user *)arg))
>  		return -EFAULT;
> +	if (n)
> +		set_bit(bdev->bd_partno, bdev->bd_disk->user_ro_bitmap);
> +	else
> +		clear_bit(bdev->bd_partno, bdev->bd_disk->user_ro_bitmap);
>  	set_device_ro(bdev, n);
>  	return 0;
>  }
> diff --git a/block/partition-generic.c b/block/partition-generic.c
> index 8e596a8dff32..c6a3c21c2496 100644
> --- a/block/partition-generic.c
> +++ b/block/partition-generic.c
> @@ -338,7 +338,7 @@ struct hd_struct *add_partition(struct gendisk *disk, int partno,
>  		queue_limit_discard_alignment(&disk->queue->limits, start);
>  	p->nr_sects = len;
>  	p->partno = partno;
> -	p->policy = get_disk_ro(disk);
> +	p->policy = get_user_ro(disk, partno) ?: get_disk_ro(disk);
>  
>  	if (info) {
>  		struct partition_meta_info *pinfo = alloc_part_info(disk);
> diff --git a/drivers/scsi/sd.c b/drivers/scsi/sd.c
> index 67cc439b86e4..5dfe37b08d3b 100644
> --- a/drivers/scsi/sd.c
> +++ b/drivers/scsi/sd.c
> @@ -2591,10 +2591,8 @@ sd_read_write_protect_flag(struct scsi_disk *sdkp, unsigned char *buffer)
>  	int res;
>  	struct scsi_device *sdp = sdkp->device;
>  	struct scsi_mode_data data;
> -	int disk_ro = get_disk_ro(sdkp->disk);
>  	int old_wp = sdkp->write_prot;
>  
> -	set_disk_ro(sdkp->disk, 0);
>  	if (sdp->skip_ms_page_3f) {
>  		sd_first_printk(KERN_NOTICE, sdkp, "Assuming Write Enabled\n");
>  		return;
> @@ -2632,7 +2630,7 @@ sd_read_write_protect_flag(struct scsi_disk *sdkp, unsigned char *buffer)
>  			  "Test WP failed, assume Write Enabled\n");
>  	} else {
>  		sdkp->write_prot = ((data.device_specific & 0x80) != 0);
> -		set_disk_ro(sdkp->disk, sdkp->write_prot || disk_ro);
> +		set_disk_ro(sdkp->disk, sdkp->write_prot);
>  		if (sdkp->first_scan || old_wp != sdkp->write_prot) {
>  			sd_printk(KERN_NOTICE, sdkp, "Write Protect is %s\n",
>  				  sdkp->write_prot ? "on" : "off");
> diff --git a/include/linux/genhd.h b/include/linux/genhd.h
> index 06c0fd594097..9645c2604465 100644
> --- a/include/linux/genhd.h
> +++ b/include/linux/genhd.h
> @@ -194,6 +194,7 @@ struct gendisk {
>  	 */
>  	struct disk_part_tbl __rcu *part_tbl;
>  	struct hd_struct part0;
> +	DECLARE_BITMAP(user_ro_bitmap, DISK_MAX_PARTS);
>  
>  	const struct block_device_operations *fops;
>  	struct request_queue *queue;
> @@ -433,6 +434,7 @@ extern struct block_device *bdget_disk(struct gendisk *disk, int partno);
>  
>  extern void set_device_ro(struct block_device *bdev, int flag);
>  extern void set_disk_ro(struct gendisk *disk, int flag);
> +extern bool get_user_ro(struct gendisk *disk, unsigned int partno);
>  
>  static inline int get_disk_ro(struct gendisk *disk)
>  {

-- 
Martin K. Petersen	Oracle Linux Engineering
