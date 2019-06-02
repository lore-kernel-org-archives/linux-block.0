Return-Path: <SRS0=BT6h=UB=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43CDFC282DC
	for <linux-block@archiver.kernel.org>; Sun,  2 Jun 2019 17:07:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A4A527980
	for <linux-block@archiver.kernel.org>; Sun,  2 Jun 2019 17:07:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726270AbfFBRHz (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 2 Jun 2019 13:07:55 -0400
Received: from smtp.infotech.no ([82.134.31.41]:42000 "EHLO smtp.infotech.no"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726170AbfFBRHz (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Sun, 2 Jun 2019 13:07:55 -0400
X-Greylist: delayed 345 seconds by postgrey-1.27 at vger.kernel.org; Sun, 02 Jun 2019 13:07:53 EDT
Received: from localhost (localhost [127.0.0.1])
        by smtp.infotech.no (Postfix) with ESMTP id EB8CF20423F;
        Sun,  2 Jun 2019 19:02:06 +0200 (CEST)
X-Virus-Scanned: by amavisd-new-2.6.6 (20110518) (Debian) at infotech.no
Received: from smtp.infotech.no ([127.0.0.1])
        by localhost (smtp.infotech.no [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id XETDBFeBHOJw; Sun,  2 Jun 2019 19:01:59 +0200 (CEST)
Received: from [172.20.1.42] (96-80-82-153-static.hfc.comcastbusiness.net [96.80.82.153])
        by smtp.infotech.no (Postfix) with ESMTPA id 8312C204155;
        Sun,  2 Jun 2019 19:01:56 +0200 (CEST)
Reply-To: dgilbert@interlog.com
Subject: Re: [PATCH 4/9] scsi_debug: support host tagset
To:     Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org, linux-scsi@vger.kernel.org,
        "Martin K . Petersen" <martin.petersen@oracle.com>
Cc:     James Bottomley <James.Bottomley@HansenPartnership.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Hannes Reinecke <hare@suse.com>,
        John Garry <john.garry@huawei.com>,
        Don Brace <don.brace@microsemi.com>,
        Kashyap Desai <kashyap.desai@broadcom.com>,
        Sathya Prakash <sathya.prakash@broadcom.com>,
        Christoph Hellwig <hch@lst.de>
References: <20190531022801.10003-1-ming.lei@redhat.com>
 <20190531022801.10003-5-ming.lei@redhat.com>
From:   Douglas Gilbert <dgilbert@interlog.com>
Message-ID: <9a43b5ff-f9a6-f0a2-bb9a-4686b7741cbf@interlog.com>
Date:   Sun, 2 Jun 2019 13:01:53 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190531022801.10003-5-ming.lei@redhat.com>
Content-Type: multipart/mixed;
 boundary="------------E37CB4B85A913D07A9A197E2"
Content-Language: en-CA
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

This is a multi-part message in MIME format.
--------------E37CB4B85A913D07A9A197E2
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2019-05-30 10:27 p.m., Ming Lei wrote:
> The 'host_tagset' can be set on scsi_debug device for testing
> shared hostwide tags on multiple blk-mq hw queue.
> 
> Signed-off-by: Ming Lei <ming.lei@redhat.com>

Hi,
Attached are my suggestions to clean up this patch a bit. It basically
   - drops the unneeded initialization (pointed out in another review)
   - places new module_param_named() in alphabetical order
   - adds MODULE_PARM_DESC() for 'modinfo scsi_debug' online help

Doug Gilbert

> ---
>   drivers/scsi/scsi_debug.c | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/scsi/scsi_debug.c b/drivers/scsi/scsi_debug.c
> index d323523f5f9d..8cf3f6c3f4f9 100644
> --- a/drivers/scsi/scsi_debug.c
> +++ b/drivers/scsi/scsi_debug.c
> @@ -665,6 +665,7 @@ static bool have_dif_prot;
>   static bool write_since_sync;
>   static bool sdebug_statistics = DEF_STATISTICS;
>   static bool sdebug_wp;
> +static bool sdebug_host_tagset = false;
>   
>   static unsigned int sdebug_store_sectors;
>   static sector_t sdebug_capacity;	/* in sectors */
> @@ -4468,6 +4469,7 @@ module_param_named(vpd_use_hostno, sdebug_vpd_use_hostno, int,
>   module_param_named(wp, sdebug_wp, bool, S_IRUGO | S_IWUSR);
>   module_param_named(write_same_length, sdebug_write_same_length, int,
>   		   S_IRUGO | S_IWUSR);
> +module_param_named(host_tagset, sdebug_host_tagset, bool, S_IRUGO | S_IWUSR);
>   
>   MODULE_AUTHOR("Eric Youngdale + Douglas Gilbert");
>   MODULE_DESCRIPTION("SCSI debug adapter driver");
> @@ -5779,6 +5781,7 @@ static int sdebug_driver_probe(struct device *dev)
>   	sdbg_host = to_sdebug_host(dev);
>   
>   	sdebug_driver_template.can_queue = sdebug_max_queue;
> +	sdebug_driver_template.host_tagset = sdebug_host_tagset;
>   	if (!sdebug_clustering)
>   		sdebug_driver_template.dma_boundary = PAGE_SIZE - 1;
>   
> 


--------------E37CB4B85A913D07A9A197E2
Content-Type: text/x-patch;
 name="0002-sg-convert-to-blk_mq-hw-queue-Ming-Lei.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="0002-sg-convert-to-blk_mq-hw-queue-Ming-Lei.patch"

From bb14859f821ade9e3a0ee5f187e66a419d310ec0 Mon Sep 17 00:00:00 2001
From: Douglas Gilbert <dgilbert@interlog.com>
Date: Sat, 1 Jun 2019 18:07:51 -0400
Subject: [PATCH 2/2] sg: convert to blk_mq hw queue; Ming Lei

Signed-off-by: Douglas Gilbert <dgilbert@interlog.com>
---
 drivers/scsi/scsi_debug.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/scsi/scsi_debug.c b/drivers/scsi/scsi_debug.c
index e27f4df24021..a880ac4d13f8 100644
--- a/drivers/scsi/scsi_debug.c
+++ b/drivers/scsi/scsi_debug.c
@@ -669,6 +669,7 @@ static bool sdebug_clustering;
 static bool sdebug_host_lock = DEF_HOST_LOCK;
 static bool sdebug_strict = DEF_STRICT;
 static bool sdebug_any_injecting_opt;
+static bool sdebug_host_tagset;
 static bool sdebug_verbose;
 static bool have_dif_prot;
 static bool write_since_sync;
@@ -4515,6 +4516,7 @@ module_param_named(every_nth, sdebug_every_nth, int, S_IRUGO | S_IWUSR);
 module_param_named(fake_rw, sdebug_fake_rw, int, S_IRUGO | S_IWUSR);
 module_param_named(guard, sdebug_guard, uint, S_IRUGO);
 module_param_named(host_lock, sdebug_host_lock, bool, S_IRUGO | S_IWUSR);
+module_param_named(host_tagset, sdebug_host_tagset, bool, 0644);
 module_param_string(inq_vendor, sdebug_inq_vendor_id,
 		    sizeof(sdebug_inq_vendor_id), S_IRUGO|S_IWUSR);
 module_param_string(inq_product, sdebug_inq_product_id,
@@ -4575,6 +4577,7 @@ MODULE_PARM_DESC(every_nth, "timeout every nth command(def=0)");
 MODULE_PARM_DESC(fake_rw, "fake reads/writes instead of copying (def=0)");
 MODULE_PARM_DESC(guard, "protection checksum: 0=crc, 1=ip (def=0)");
 MODULE_PARM_DESC(host_lock, "host_lock is ignored (def=0)");
+MODULE_PARM_DESC(host_tagset, "host_tagset for multiple hw queues (def=0)");
 MODULE_PARM_DESC(inq_vendor, "SCSI INQUIRY vendor string (def=\"Linux\")");
 MODULE_PARM_DESC(inq_product, "SCSI INQUIRY product string (def=\"scsi_debug\")");
 MODULE_PARM_DESC(inq_rev, "SCSI INQUIRY revision string (def=\""
@@ -5866,6 +5869,7 @@ static int sdebug_driver_probe(struct device *dev)
 	sdbg_host = to_sdebug_host(dev);
 
 	sdebug_driver_template.can_queue = sdebug_max_queue;
+	sdebug_driver_template.host_tagset = sdebug_host_tagset;
 	if (!sdebug_clustering)
 		sdebug_driver_template.dma_boundary = PAGE_SIZE - 1;
 
-- 
2.17.1


--------------E37CB4B85A913D07A9A197E2--
