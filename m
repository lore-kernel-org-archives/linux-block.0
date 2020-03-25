Return-Path: <SRS0=yjA8=5K=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61806C1975A
	for <linux-block@archiver.kernel.org>; Wed, 25 Mar 2020 07:29:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 128912051A
	for <linux-block@archiver.kernel.org>; Wed, 25 Mar 2020 07:29:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="NLPDnirl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726086AbgCYH34 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 25 Mar 2020 03:29:56 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:47240 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726017AbgCYH34 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 25 Mar 2020 03:29:56 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 02P7NBIk042530;
        Wed, 25 Mar 2020 07:29:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type; s=corp-2020-01-29;
 bh=vfl2IgSzqdoa7DeIcd3q0m3UeU1wni/uJO+Jr9ZXu3s=;
 b=NLPDnirlb+M/MBnBMOgNTHEC4VK6aQs+0AXm9RLdjTHERvd3ezv7GupgkDvGKC/its4i
 yAodXtLMnBU1CizcoaM1cn5UgpBq2Ga5OhwsgzZTOypl8iuAnVQcx8N1WyZH0MqIhb3K
 7i5HfE3KBNYSvX9EWFFq6NsPsqJCqffakRTIrQhrhSPHx8kwHECpdGNlhNpn/9HxpU4M
 VTv9PidDmgFjo1n+BwPFfHxxfS0u/0L7TKihDqbgM6REOQvpOiy7CqbU5ODlIAIXKbjZ
 efdDILqjI1TVMYv+MotVsTVxGgtXsZF572k6JsQUrvW560sR5rBZM0QNbAdLgCQOpw3R 6A== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2130.oracle.com with ESMTP id 2ywabr87gm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 25 Mar 2020 07:29:43 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 02P7MBs8061366;
        Wed, 25 Mar 2020 07:29:42 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3030.oracle.com with ESMTP id 2yxw943qnw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 25 Mar 2020 07:29:42 +0000
Received: from abhmp0016.oracle.com (abhmp0016.oracle.com [141.146.116.22])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 02P7TfZf014138;
        Wed, 25 Mar 2020 07:29:41 GMT
Received: from [192.168.1.14] (/114.88.246.185)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 25 Mar 2020 00:29:40 -0700
Subject: Re: [RFC PATCH v2 3/3] dm zoned: add regular device info to metadata
To:     Hannes Reinecke <hare@suse.de>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        "dm-devel@redhat.com" <dm-devel@redhat.com>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Dmitry Fomichev <Dmitry.Fomichev@wdc.com>
References: <20200324110255.8385-1-bob.liu@oracle.com>
 <20200324110255.8385-4-bob.liu@oracle.com>
 <CO2PR04MB23438E0AB35CC46732F96085E7CE0@CO2PR04MB2343.namprd04.prod.outlook.com>
 <812da9e9-cfd2-ea24-60cb-4af48f476079@suse.de>
From:   Bob Liu <bob.liu@oracle.com>
Message-ID: <0e7c5043-4345-b052-7cec-a53cfea340f7@oracle.com>
Date:   Wed, 25 Mar 2020 15:29:34 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <812da9e9-cfd2-ea24-60cb-4af48f476079@suse.de>
Content-Type: multipart/mixed;
 boundary="------------2EE09531441FC9B62243DB8E"
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9570 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0 bulkscore=0
 adultscore=0 mlxscore=0 malwarescore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2003250061
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9570 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=0
 lowpriorityscore=0 malwarescore=0 phishscore=0 priorityscore=1501
 clxscore=1015 adultscore=0 mlxscore=0 mlxlogscore=999 bulkscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2003250061
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

This is a multi-part message in MIME format.
--------------2EE09531441FC9B62243DB8E
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

On 3/25/20 2:47 PM, Hannes Reinecke wrote:
> On 3/25/20 7:29 AM, Damien Le Moal wrote:
>> On 2020/03/24 20:04, Bob Liu wrote:
>>> This patch implemented metadata support for regular device by:
>>>   - Emulated zone information for regular device.
>>>   - Store metadata at the beginning of regular device.
>>>
>>>       | --- zoned device --- | -- regular device ||
>>>       ^                      ^
>>>       |                      |Metadata
>>> zone 0
>>>
>>> Signed-off-by: Bob Liu <bob.liu@oracle.com>
>>> ---
>>>   drivers/md/dm-zoned-metadata.c | 135 +++++++++++++++++++++++++++++++----------
>>>   drivers/md/dm-zoned-target.c   |   6 +-
>>>   drivers/md/dm-zoned.h          |   3 +-
>>>   3 files changed, 108 insertions(+), 36 deletions(-)
>>>
> Having thought about it some more, I think we cannot continue with this 'simple' approach.
> The immediate problem is that we lie about the disk size; clearly the
> metadata cannot be used for regular data, yet we expose a target device with the full size of the underlying device.

The exposed size is "regular dev size + zoned dev size - metadata size - reserved seq zone size".
I didn't see why there is a lie?

> Making me wonder if anybody ever tested a disk-full scenario...
> The other problem is that with two devices we need to be able to stitch them together in an automated fashion, eg via a systemd service or udev rule.
> But for this we need to be able to identify the devices, which means both need to carry metadata, and both need to have unique identifier within the metadata. Which the current metadata doesn't allow to.
> 
> Hence my plan is to implement a v2 metadata, carrying UUIDs for the dmz set _and_ the component device. With that we can update blkid to create links etc so that the devices can be identified in the system.
> Additionally I would be updating dmzadm to write the new metadata.
> 
> And I will add a new command 'start' to dmzadm which will then create the device-mapper device _with the correct size_. It also has the benefit that we can create the device-mapper target with the UUID specified in the metadata, so the persistent device links will be created automatically.
> 
> Bob, can you send me your improvements to dmzadm so that I can include them in my changes?
> 

Attached, but it's a big patch I haven't split them to smaller one.
The dmz_check/repair can't work neither in current stage.

--------------2EE09531441FC9B62243DB8E
Content-Type: text/x-patch;
 name="dm-zoned-tools.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="dm-zoned-tools.patch"

diff --git a/src/dmz.h b/src/dmz.h
index 57741b1..51b5019 100644
--- a/src/dmz.h
+++ b/src/dmz.h
@@ -153,19 +153,33 @@ enum dmz_op {
 	DMZ_OP_REPAIR,
 };
 
+struct dmz_raw_dev {
+	char *path;
+	char *name;
+	int fd;
+	size_t		zone_nr_sectors;
+	size_t		zone_nr_blocks;
+	/* Device info */
+	__u64		capacity;
+	unsigned int nr_zones;
+	struct blk_zone	*zones;
+	struct dmz_dev *pdev;
+};
+
 /*
  * Device descriptor.
  */
 struct dmz_dev {
 
 	/* Device file path and basename */
-	char		*path;
-	char		*name;
+	struct dmz_raw_dev zoned_dev;
+	struct dmz_raw_dev regu_dev;
+
 	int		op;
 	unsigned int	flags;
+	size_t		zone_nr_blocks;
+	int 		has_regular;
 
-	/* Device info */
-	__u64		capacity;
 
 	unsigned int	nr_zones;
 	unsigned int	nr_meta_zones;
@@ -178,11 +192,6 @@ struct dmz_dev {
 	unsigned int	total_nr_meta_zones;
 	unsigned int	nr_rnd_zones;
 
-	struct blk_zone	*zones;
-
-	size_t		zone_nr_sectors;
-	size_t		zone_nr_blocks;
-
 	/* First metadata zone */
 	struct blk_zone	*sb_zone;
 	__u64		sb_block;
@@ -195,10 +204,6 @@ struct dmz_dev {
 	/* Mapping table */
 	unsigned int	nr_map_blocks;
 	__u64		map_block;
-
-	/* Device file descriptor */
-	int		fd;
-
 };
 
 /*
@@ -317,16 +322,16 @@ dmz_zone_cond_str(struct blk_zone *zone)
 
 extern int dmz_open_dev(struct dmz_dev *dev, enum dmz_op op);
 extern void dmz_close_dev(struct dmz_dev *dev);
-extern int dmz_sync_dev(struct dmz_dev *dev);
-extern int dmz_reset_zone(struct dmz_dev *dev, struct blk_zone *zone);
-extern int dmz_reset_zones(struct dmz_dev *dev);
-extern int dmz_write_block(struct dmz_dev *dev, __u64 block, __u8 *buf);
-extern int dmz_read_block(struct dmz_dev *dev, __u64 block, __u8 *buf);
+extern int dmz_sync_dev(struct dmz_raw_dev *dev);
+extern int dmz_reset_zone(struct dmz_raw_dev *dev, struct blk_zone *zone);
+extern int dmz_reset_zones(struct dmz_raw_dev *dev);
+extern int dmz_write_block(struct dmz_raw_dev *dev, __u64 block, __u8 *buf);
+extern int dmz_read_block(struct dmz_raw_dev *dev, __u64 block, __u8 *buf);
 
 extern __u32 dmz_crc32(__u32 crc, const void *address, size_t length);
 
 extern int dmz_locate_metadata(struct dmz_dev *dev);
-extern int dmz_write_super(struct dmz_dev *dev, __u64 gen, __u64 offset);
+extern int dmz_write_super(struct dmz_raw_dev *dev, __u64 gen, __u64 offset);
 extern int dmz_format(struct dmz_dev *dev);
 extern int dmz_check(struct dmz_dev *dev);
 extern int dmz_repair(struct dmz_dev *dev);
diff --git a/src/dmz_check.c b/src/dmz_check.c
index 25ce026..da8c1a5 100644
--- a/src/dmz_check.c
+++ b/src/dmz_check.c
@@ -29,7 +29,7 @@
 #include <linux/fs.h>
 #include <assert.h>
 #include <asm/byteorder.h>
-
+#if 0
 /*
  * Message macro.
  */
@@ -1245,4 +1245,4 @@ int dmz_repair(struct dmz_dev *dev)
 
 	return 0;
 }
-
+#endif
diff --git a/src/dmz_dev.c b/src/dmz_dev.c
index e713ae0..a7a57ac 100644
--- a/src/dmz_dev.c
+++ b/src/dmz_dev.c
@@ -36,7 +36,7 @@
 /*
  * Test if the device is mounted.
  */
-static int dmz_dev_mounted(struct dmz_dev *dev)
+static int dmz_dev_mounted(struct dmz_raw_dev *dev)
 {
 	struct mntent *mnt = NULL;
 	FILE *file = NULL;
@@ -57,7 +57,7 @@ static int dmz_dev_mounted(struct dmz_dev *dev)
 /*
  * Test if the device is already used as a target backend.
  */
-static int dmz_dev_busy(struct dmz_dev *dev)
+static int dmz_dev_busy(struct dmz_raw_dev *dev)
 {
 	char path[128];
 	struct dirent **namelist;
@@ -87,7 +87,7 @@ static int dmz_dev_busy(struct dmz_dev *dev)
 /*
  * Get a zoned block device model (host-aware or howt-managed).
  */
-static int dmz_get_dev_model(struct dmz_dev *dev)
+static int dmz_get_dev_model(struct dmz_raw_dev *dev)
 {
 	char str[PATH_MAX];
 	FILE *file;
@@ -122,9 +122,9 @@ static int dmz_get_dev_model(struct dmz_dev *dev)
 	}
 
 	if (strcmp(str, "host-aware") == 0)
-		dev->flags |= DMZ_ZONED_HA;
+		dev->pdev->flags |= DMZ_ZONED_HA;
 	else if (strcmp(str, "host-managed") == 0)
-		dev->flags |= DMZ_ZONED_HM;
+		dev->pdev->flags |= DMZ_ZONED_HM;
 
 	return 0;
 }
@@ -132,7 +132,7 @@ static int dmz_get_dev_model(struct dmz_dev *dev)
 /*
  * Get device capacity and zone size.
  */
-static int dmz_get_dev_capacity(struct dmz_dev *dev)
+static int dmz_get_dev_capacity(struct dmz_raw_dev *dev, int emulated)
 {
 	char str[128];
 	FILE *file;
@@ -147,26 +147,30 @@ static int dmz_get_dev_capacity(struct dmz_dev *dev)
 	}
 	dev->capacity >>= 9;
 
-	/* Get zone size */
-	snprintf(str, sizeof(str),
-		 "/sys/block/%s/queue/chunk_sectors",
-		 dev->name);
-	file = fopen(str, "r");
-	if (!file) {
-		fprintf(stderr, "Open %s failed\n", str);
-		return -1;
-	}
+	if (emulated) {
+		dev->zone_nr_sectors = emulated;
+	} else {
+		/* Get zone size */
+		snprintf(str, sizeof(str),
+				"/sys/block/%s/queue/chunk_sectors",
+				dev->name);
+		file = fopen(str, "r");
+		if (!file) {
+			fprintf(stderr, "Open %s failed\n", str);
+			return -1;
+		}
 
-	memset(str, 0, sizeof(str));
-	res = fscanf(file, "%s", str);
-	fclose(file);
+		memset(str, 0, sizeof(str));
+		res = fscanf(file, "%s", str);
+		fclose(file);
 
-	if (res != 1) {
-		fprintf(stderr, "Invalid file %s format\n", str);
-		return -1;
-	}
+		if (res != 1) {
+			fprintf(stderr, "Invalid file %s format\n", str);
+			return -1;
+		}
 
-	dev->zone_nr_sectors = atol(str);
+		dev->zone_nr_sectors = atol(str);
+	}
 	if (!dev->zone_nr_sectors ||
 	    (dev->zone_nr_sectors & DMZ_BLOCK_SECTORS_MASK)) {
 		fprintf(stderr,
@@ -182,7 +186,7 @@ static int dmz_get_dev_capacity(struct dmz_dev *dev)
 /*
  * Print a device zone information.
  */
-static void dmz_print_zone(struct dmz_dev *dev,
+static void dmz_print_zone(struct dmz_raw_dev *dev,
 			   struct blk_zone *zone)
 {
 
@@ -230,14 +234,14 @@ static void dmz_print_zone(struct dmz_dev *dev,
 /*
  * Get a device zone configuration.
  */
-static int dmz_get_dev_zones(struct dmz_dev *dev)
+static int dmz_get_dev_zones(struct dmz_raw_dev *dev, int emulate)
 {
 	struct blk_zone_report *rep = NULL;
 	unsigned int rep_max_zones;
 	struct blk_zone *blkz;
 	unsigned int i, nr_zones;
 	__u64 sector;
-	int ret = -1;
+	int ret = 0;
 
 	/* This will ignore an eventual last smaller zone */
 	nr_zones = dev->capacity / dev->zone_nr_sectors;
@@ -263,17 +267,35 @@ static int dmz_get_dev_zones(struct dmz_dev *dev)
 
 	sector = 0;
 	while (sector < dev->capacity) {
-
 		/* Get zone information */
 		memset(rep, 0, DMZ_REPORT_ZONES_BUFSZ);
 		rep->sector = sector;
 		rep->nr_zones = rep_max_zones;
-		ret = ioctl(dev->fd, BLKREPORTZONE, rep);
-		if (ret != 0) {
-			fprintf(stderr,
-				"%s: Get zone information failed %d (%s)\n",
-				dev->name, errno, strerror(errno));
-			goto out;
+		if (emulate) {
+			unsigned int f_sector = sector;
+			rep->nr_zones = ((nr_zones < rep_max_zones) ? nr_zones : rep_max_zones);
+			blkz = (struct blk_zone *)(rep + 1);
+			for (i = 0; i < rep->nr_zones && f_sector < dev->capacity; i++) {
+				//set up fake blkz
+				blkz->start = f_sector;
+				blkz->len = dev->zone_nr_sectors;
+				blkz->wp = blkz->start + blkz->len;
+				blkz->type = BLK_ZONE_TYPE_CONVENTIONAL;
+				blkz->cond = BLK_ZONE_COND_NOT_WP;
+
+				f_sector = dmz_zone_sector(blkz) + dmz_zone_length(blkz);
+				if (f_sector > dev->capacity)
+					blkz->len = dev->capacity - dmz_zone_sector(blkz);
+				blkz++;
+			}
+		} else {
+			ret = ioctl(dev->fd, BLKREPORTZONE, rep);
+			if (ret != 0) {
+				fprintf(stderr,
+						"%s: Get zone information failed %d (%s)\n",
+						dev->name, errno, strerror(errno));
+				goto out;
+			}
 		}
 
 		if (!rep->nr_zones)
@@ -282,7 +304,7 @@ static int dmz_get_dev_zones(struct dmz_dev *dev)
 		blkz = (struct blk_zone *)(rep + 1);
 		for (i = 0; i < rep->nr_zones && sector < dev->capacity; i++) {
 
-			if (dev->flags & DMZ_VVERBOSE)
+			if (dev->pdev->flags & DMZ_VVERBOSE)
 				dmz_print_zone(dev, blkz);
 
 			/* Check zone size */
@@ -337,22 +359,35 @@ out:
 static int dmz_get_dev_info(struct dmz_dev *dev)
 {
 
-	if (dmz_get_dev_model(dev) < 0)
+	if (dmz_get_dev_model(&dev->zoned_dev) < 0)
 		return -1;
 
 	if (!dmz_dev_is_zoned(dev)) {
 		fprintf(stderr,
 			"%s: Not a zoned block device\n",
-			dev->name);
+			dev->zoned_dev.name);
 		return -1;
 	}
 
-	if (dmz_get_dev_capacity(dev) < 0)
+	if (dmz_get_dev_capacity(&dev->zoned_dev, 0) < 0)
 		return -1;
 
-	if (dmz_get_dev_zones(dev) < 0)
+	dev->zone_nr_blocks = dev->zoned_dev.zone_nr_blocks;
+	if (dev->has_regular)
+		if (dmz_get_dev_capacity(&dev->regu_dev, dev->zoned_dev.zone_nr_blocks) < 0)
+			return -1;
+
+	if (dmz_get_dev_zones(&dev->zoned_dev, 0) < 0)
 		return -1;
 
+	if (dev->has_regular)
+		if (dmz_get_dev_zones(&dev->regu_dev, 1) < 0)
+			return -1;
+
+	dev->nr_zones = dev->zoned_dev.nr_zones;
+	if (dev->has_regular)
+		dev->nr_zones += dev->regu_dev.nr_zones;
+
 	return 0;
 }
 
@@ -361,7 +396,7 @@ static int dmz_get_dev_info(struct dmz_dev *dev)
  * Return -1 on error, 0 if something valid is detected on the disk
  * and 1 if the disk appears to be unused.
  */
-static int dmz_check_overwrite(struct dmz_dev *dev)
+static int dmz_check_overwrite(struct dmz_raw_dev *dev)
 {
 	const char *type;
 	blkid_probe pr;
@@ -421,10 +456,7 @@ out:
 	return ret;
 }
 
-/*
- * Open a device.
- */
-int dmz_open_dev(struct dmz_dev *dev, enum dmz_op op)
+int dmz_open_raw_dev(struct dmz_raw_dev *dev, enum dmz_op op, int flags)
 {
 	struct stat st;
 	int ret;
@@ -447,7 +479,7 @@ int dmz_open_dev(struct dmz_dev *dev, enum dmz_op op)
 		return -1;
 	}
 
-	if (op == DMZ_OP_FORMAT && (!(dev->flags & DMZ_OVERWRITE))) {
+	if (op == DMZ_OP_FORMAT && (!(flags & DMZ_OVERWRITE))) {
 		/* Check for existing valid content */
 		ret = dmz_check_overwrite(dev);
 		if (ret <= 0)
@@ -455,16 +487,12 @@ int dmz_open_dev(struct dmz_dev *dev, enum dmz_op op)
 	}
 
 	if (dmz_dev_mounted(dev)) {
-		fprintf(stderr,
-			"%s is mounted\n",
-			dev->path);
+		fprintf(stderr, "%s is mounted\n", dev->path);
 		return -1;
 	}
 
 	if (dmz_dev_busy(dev)) {
-		fprintf(stderr,
-			"%s is in use\n",
-			dev->path);
+		fprintf(stderr, "%s is in use\n", dev->path);
 		return -1;
 	}
 
@@ -478,6 +506,18 @@ int dmz_open_dev(struct dmz_dev *dev, enum dmz_op op)
 		return -1;
 	}
 
+	return 0;
+}
+
+/*
+ * Open a device.
+ */
+int dmz_open_dev(struct dmz_dev *dev, enum dmz_op op)
+{
+	dmz_open_raw_dev(&dev->zoned_dev, op, dev->flags);
+	if (dev->has_regular)
+		dmz_open_raw_dev(&dev->regu_dev, op, dev->flags);
+
 	/* Get device capacity and zone configuration */
 	if (dmz_get_dev_info(dev) < 0) {
 		dmz_close_dev(dev);
@@ -487,10 +527,7 @@ int dmz_open_dev(struct dmz_dev *dev, enum dmz_op op)
 	return 0;
 }
 
-/*
- * Close an open device.
- */
-void dmz_close_dev(struct dmz_dev *dev)
+void dmz_close_raw_dev(struct dmz_raw_dev *dev)
 {
 	if (dev->fd >= 0) {
 		close(dev->fd);
@@ -501,10 +538,20 @@ void dmz_close_dev(struct dmz_dev *dev)
 	dev->zones = NULL;
 }
 
+/*
+ * Close an open device.
+ */
+void dmz_close_dev(struct dmz_dev *dev)
+{
+	dmz_close_raw_dev(&dev->zoned_dev);
+	if (dev->has_regular)
+		dmz_close_raw_dev(&dev->regu_dev);
+}
+
 /*
  * Read a metadata block.
  */
-int dmz_read_block(struct dmz_dev *dev, __u64 block, __u8 *buf)
+int dmz_read_block(struct dmz_raw_dev *dev, __u64 block, __u8 *buf)
 {
 	ssize_t ret;
 
@@ -526,7 +573,7 @@ int dmz_read_block(struct dmz_dev *dev, __u64 block, __u8 *buf)
 /*
  * Write a metadata block.
  */
-int dmz_write_block(struct dmz_dev *dev, __u64 block, __u8 *buf)
+int dmz_write_block(struct dmz_raw_dev *dev, __u64 block, __u8 *buf)
 {
 	ssize_t ret;
 
@@ -547,7 +594,7 @@ int dmz_write_block(struct dmz_dev *dev, __u64 block, __u8 *buf)
 /*
  * Write a metadata block.
  */
-int dmz_sync_dev(struct dmz_dev *dev)
+int dmz_sync_dev(struct dmz_raw_dev *dev)
 {
 
 	printf("Syncing disk\n");
diff --git a/src/dmz_format.c b/src/dmz_format.c
index 62cb03b..30286cb 100644
--- a/src/dmz_format.c
+++ b/src/dmz_format.c
@@ -24,14 +24,14 @@
 
 #include <sys/types.h>
 #include <asm/byteorder.h>
-
 /*
  * Fill and write a super block.
  */
-int dmz_write_super(struct dmz_dev *dev,
+int dmz_write_super(struct dmz_raw_dev *dev,
 		    __u64 gen, __u64 offset)
 {
-	__u64 sb_block = dev->sb_block + offset;
+	struct dmz_dev *pdev = dev->pdev;
+	__u64 sb_block = pdev->sb_block + offset;
 	struct dm_zoned_super *sb;
 	__u32 crc;
 	__u8 *buf;
@@ -52,12 +52,12 @@ int dmz_write_super(struct dmz_dev *dev,
 	sb->gen = __cpu_to_le64(gen);
 
 	sb->sb_block = __cpu_to_le64(sb_block);
-	sb->nr_meta_blocks = __cpu_to_le32(dev->nr_meta_blocks);
-	sb->nr_reserved_seq = __cpu_to_le32(dev->nr_reserved_seq);
-	sb->nr_chunks = __cpu_to_le32(dev->nr_chunks);
+	sb->nr_meta_blocks = __cpu_to_le32(pdev->nr_meta_blocks);
+	sb->nr_reserved_seq = __cpu_to_le32(pdev->nr_reserved_seq);
+	sb->nr_chunks = __cpu_to_le32(pdev->nr_chunks);
 
-	sb->nr_map_blocks = __cpu_to_le32(dev->nr_map_blocks);
-	sb->nr_bitmap_blocks = __cpu_to_le32(dev->nr_bitmap_blocks);
+	sb->nr_map_blocks = __cpu_to_le32(pdev->nr_map_blocks);
+	sb->nr_bitmap_blocks = __cpu_to_le32(pdev->nr_bitmap_blocks);
 
 	crc = dmz_crc32(gen, sb, DMZ_BLOCK_SIZE);
 	sb->crc = __cpu_to_le32(crc);
@@ -77,7 +77,7 @@ int dmz_write_super(struct dmz_dev *dev,
 /*
  * Write mapping table blocks.
  */
-static int dmz_write_mapping(struct dmz_dev *dev,
+static int dmz_write_mapping(struct dmz_raw_dev *dev,
 			     __u64 offset)
 {
 	__u64 map_block;
@@ -102,8 +102,8 @@ static int dmz_write_mapping(struct dmz_dev *dev,
 	}
 
 	/* Write mapping table */
-	map_block = offset + dev->map_block;
-	for (i = 0; i < dev->nr_map_blocks; i++) {
+	map_block = offset + dev->pdev->map_block;
+	for (i = 0; i < dev->pdev->nr_map_blocks; i++) {
 		ret = dmz_write_block(dev, map_block + i, buf);
 		if (ret < 0) {
 			fprintf(stderr,
@@ -122,7 +122,7 @@ static int dmz_write_mapping(struct dmz_dev *dev,
 /*
  * Write zone bitmap blocks.
  */
-static int dmz_write_bitmap(struct dmz_dev *dev,
+static int dmz_write_bitmap(struct dmz_raw_dev *dev,
 			    __u64 offset)
 {
 	__u64 bitmap_block;
@@ -140,8 +140,8 @@ static int dmz_write_bitmap(struct dmz_dev *dev,
 	memset(buf, 0, DMZ_BLOCK_SIZE);
 
 	/* Clear bitmap blocks */
-	bitmap_block = offset + dev->bitmap_block;
-	for (i = 0; i < dev->nr_bitmap_blocks; i++) {
+	bitmap_block = offset + dev->pdev->bitmap_block;
+	for (i = 0; i < dev->pdev->nr_bitmap_blocks; i++) {
 		ret = dmz_write_block(dev, bitmap_block + i, buf);
 		if (ret < 0) {
 			fprintf(stderr,
@@ -160,7 +160,7 @@ static int dmz_write_bitmap(struct dmz_dev *dev,
 /*
  * Write formatted metadata blocks.
  */
-static int dmz_write_meta(struct dmz_dev *dev,
+static int dmz_write_meta(struct dmz_raw_dev *dev,
 			  __u64 offset)
 {
 
@@ -180,11 +180,20 @@ static int dmz_write_meta(struct dmz_dev *dev,
 	return 0;
 }
 
+struct dmz_raw_dev *dmz_metadev(struct dmz_dev *dev)
+{
+	if (dev->has_regular)
+		return &dev->regu_dev;
+	else
+		return &dev->zoned_dev;
+}
+
 /*
  * Format a device.
  */
 int dmz_format(struct dmz_dev *dev)
 {
+	struct dmz_raw_dev *mdev = dmz_metadev(dev);
 
 	/* calculate location of metadata blocks */
 	if (dmz_locate_metadata(dev) < 0)
@@ -199,7 +208,7 @@ int dmz_format(struct dmz_dev *dev)
 		printf("  Primary meta-data set: %u metadata blocks from block %llu (zone %u)\n",
 		       dev->nr_meta_blocks,
 		       dev->sb_block,
-		       dmz_zone_id(dev, dev->sb_zone));
+		       dmz_zone_id(mdev, dev->sb_zone));
 		printf("    Super block at block %llu and %llu\n",
 		       dev->sb_block,
 		       dev->sb_block + (dev->nr_meta_zones * dev->zone_nr_blocks));
@@ -231,25 +240,27 @@ int dmz_format(struct dmz_dev *dev)
 
 	/* Ready to write: first reset all zones */
 	printf("Resetting sequential zones\n");
-	if (dmz_reset_zones(dev) < 0)
+	if (dev->has_regular)
+		if (dmz_reset_zones(&dev->regu_dev) < 0)
+			return -1;
+	if (dmz_reset_zones(&dev->zoned_dev) < 0)
 		return -1;
 
 	/* Write primary metadata set */
 	printf("Writing primary metadata set\n");
-	if (dmz_write_meta(dev, 0) < 0)
+	if (dmz_write_meta(mdev, 0) < 0)
 		return -1;
 
 	/* Write secondary metadata set */
 	printf("Writing secondary metadata set\n");
-	if (dmz_write_meta(dev, dev->zone_nr_blocks * dev->nr_meta_zones) < 0)
+	if (dmz_write_meta(mdev, dev->zone_nr_blocks * dev->nr_meta_zones) < 0)
 		return -1;
 
 	/* Sync */
-	if (dmz_sync_dev(dev) < 0)
+	if (dmz_sync_dev(mdev) < 0)
 		return -1;
 
 	printf("Done.\n");
 
 	return 0;
 }
-
diff --git a/src/dmz_lib.c b/src/dmz_lib.c
index 2df0758..3c1874a 100644
--- a/src/dmz_lib.c
+++ b/src/dmz_lib.c
@@ -44,7 +44,7 @@ __u32 dmz_crc32(__u32 crc, const void *buf, size_t length)
 /*
  * Reset a zone.
  */
-int dmz_reset_zone(struct dmz_dev *dev,
+int dmz_reset_zone(struct dmz_raw_dev *dev,
 		   struct blk_zone *zone)
 {
 	struct blk_zone_range range;
@@ -73,7 +73,7 @@ int dmz_reset_zone(struct dmz_dev *dev,
 /*
  * Reset all zones of a device.
  */
-int dmz_reset_zones(struct dmz_dev *dev)
+int dmz_reset_zones(struct dmz_raw_dev *dev)
 {
 	unsigned int i;
 
@@ -85,21 +85,10 @@ int dmz_reset_zones(struct dmz_dev *dev)
 	return 0;
 }
 
-/*
- * Determine location and amount of metadata blocks.
- */
-int dmz_locate_metadata(struct dmz_dev *dev)
+static void count_useable_zones(struct dmz_raw_dev *dev)
 {
 	struct blk_zone *zone;
 	unsigned int i = 0;
-	unsigned int nr_meta_blocks, nr_map_blocks;
-	unsigned int nr_chunks, nr_meta_zones;
-	unsigned int nr_bitmap_zones;
-
-	dev->nr_useable_zones = 0;
-	dev->max_nr_meta_zones = 0;
-	dev->last_meta_zone = 0;
-	dev->nr_rnd_zones = 0;
 
 	/* Count useable zones */
 	for (i = 0; i < dev->nr_zones; i++) {
@@ -126,21 +115,43 @@ int dmz_locate_metadata(struct dmz_dev *dev)
 			       dmz_zone_id(dev, zone));
 			continue;
 		}
-		dev->nr_useable_zones++;
+		dev->pdev->nr_useable_zones++;
 
 		if (dmz_zone_rnd(zone)) {
-			if (dev->sb_zone == NULL) {
-				dev->sb_zone = zone;
-				dev->last_meta_zone = i;
-				dev->max_nr_meta_zones = 1;
-			} else if (dev->last_meta_zone == (i - 1)) {
-				dev->last_meta_zone = i;
-				dev->max_nr_meta_zones++;
+			if (dev->pdev->sb_zone == NULL) {
+				dev->pdev->sb_zone = zone;
+				dev->pdev->last_meta_zone = i;
+				dev->pdev->max_nr_meta_zones = 1;
+			} else if (dev->pdev->last_meta_zone == (i - 1)) {
+				dev->pdev->last_meta_zone = i;
+				dev->pdev->max_nr_meta_zones++;
 			}
-			dev->nr_rnd_zones++;
+			dev->pdev->nr_rnd_zones++;
 		}
-
 	}
+}
+
+/*
+ * Determine location and amount of metadata blocks.
+ */
+int dmz_locate_metadata(struct dmz_dev *dev)
+{
+	unsigned int nr_meta_blocks, nr_map_blocks;
+	unsigned int nr_chunks, nr_meta_zones;
+	unsigned int nr_bitmap_zones;
+
+	dev->nr_useable_zones = 0;
+	dev->max_nr_meta_zones = 0;
+	dev->last_meta_zone = 0;
+	dev->nr_rnd_zones = 0;
+
+	/*
+	 * Count regular device first, so that metadata zone will be in
+	 * regular device.
+	 */
+	if (dev->has_regular)
+		count_useable_zones(&dev->regu_dev);
+	count_useable_zones(&dev->zoned_dev);
 
 	/*
 	 * Randomly writeable zones are mandatory: at least 3
@@ -148,8 +159,8 @@ int dmz_locate_metadata(struct dmz_dev *dev)
 	 */
 	if (dev->nr_rnd_zones < 3) {
 		fprintf(stderr,
-			"%s: Not enough random zones found\n",
-			dev->name);
+			"%s:%s: Not enough random zones found\n",
+			dev->zoned_dev.name, dev->regu_dev.name);
 		return -1;
 	}
 
@@ -161,8 +172,8 @@ int dmz_locate_metadata(struct dmz_dev *dev)
 		dev->nr_reserved_seq = dev->nr_rnd_zones - 1;
 	if (dev->nr_reserved_seq >= dev->nr_useable_zones) {
 		fprintf(stderr,
-			"%s: Not enough useable zones found\n",
-			dev->name);
+			"%s:%s: Not enough useable zones found\n",
+			dev->zoned_dev.name, dev->regu_dev.name);
 		return -1;
 	}
 
@@ -181,8 +192,8 @@ int dmz_locate_metadata(struct dmz_dev *dev)
 
 	if ((nr_bitmap_zones + dev->nr_reserved_seq) > dev->nr_useable_zones) {
 		fprintf(stderr,
-			"%s: Not enough zones\n",
-			dev->name);
+			"%s:%s: Not enough zones\n",
+			dev->zoned_dev.name, dev->regu_dev.name);
 		return -1;
 	}
 
@@ -208,9 +219,9 @@ int dmz_locate_metadata(struct dmz_dev *dev)
 
 	if (dev->total_nr_meta_zones > dev->nr_rnd_zones) {
 		fprintf(stderr,
-			"%s: Insufficient number of random zones "
+			"%s:%s Insufficient number of random zones "
 			"(need %u, have %u)\n",
-			dev->name,
+			dev->zoned_dev.name, dev->regu_dev.name,
 			dev->total_nr_meta_zones,
 			dev->nr_rnd_zones);
 		return -1;
diff --git a/src/dmzadm.c b/src/dmzadm.c
index 0660d02..ff7e9cc 100644
--- a/src/dmzadm.c
+++ b/src/dmzadm.c
@@ -41,23 +41,55 @@ static void dmzadm_usage(void)
 	       "  --force	: Force overwrite of existing content\n"
 	       "  --seq <num>	: Number of sequential zones reserved\n"
 	       "                  for reclaim. The minimum is 1 and the\n"
-	       "                  default is %d\n",
+	       "                  default is %d\n"
+	       "  --regular <device path>: Use a regular block device\n"
+	       "                  for metadata and buffer writes\n",
 	       DMZ_NR_RESERVED_SEQ);
 }
 
+static void dump_info(struct dmz_raw_dev *dev)
+{
+	unsigned int nr_zones;
+	struct dmz_dev *pdev = dev->pdev;
+
+	printf("%s: %llu 512-byte sectors (%llu GiB)\n",
+	       dev->path,
+	       dev->capacity,
+	       (dev->capacity << 9) / (1024ULL * 1024ULL * 1024ULL));
+	printf("  Host-%s device\n",
+	       (pdev->flags & DMZ_ZONED_HM) ? "managed" : "aware");
+	nr_zones = dev->capacity / dev->zone_nr_sectors;
+	printf("  %u zones of %zu 512-byte sectors (%zu MiB)\n",
+	       nr_zones,
+	       dev->zone_nr_sectors,
+	       (dev->zone_nr_sectors << 9) / (1024 * 1024));
+	if (nr_zones < dev->nr_zones) {
+		size_t runt_sectors = dev->capacity & (dev->zone_nr_sectors - 1);
+
+		printf("  1 runt zone of %zu 512-byte sectors (%zu MiB)\n",
+		       runt_sectors,
+		       (runt_sectors << 9) / (1024 * 1024));
+	}
+	printf("  %zu 4KB data blocks per zone\n",
+	       dev->zone_nr_blocks);
+
+}
+
 /*
  * Main function.
  */
 int main(int argc, char **argv)
 {
-	unsigned int nr_zones;
 	struct dmz_dev dev;
-	int i, ret;
+	int i, ret = 0;
 	enum dmz_op op;
 
 	/* Initialize */
 	memset(&dev, 0, sizeof(dev));
-	dev.fd = -1;
+	dev.zoned_dev.fd = -1;
+	dev.regu_dev.fd = -1;
+	dev.zoned_dev.pdev = &dev;
+	dev.regu_dev.pdev = &dev;
 	dev.nr_reserved_seq = DMZ_NR_RESERVED_SEQ;
 
 	/* Parse operation */
@@ -90,7 +122,7 @@ int main(int argc, char **argv)
 	}
 
 	/* Get device path */
-	dev.path = argv[2];
+	dev.zoned_dev.path = argv[2];
 
 	/* Parse arguments */
 	for (i = 3; i < argc; i++) {
@@ -118,7 +150,15 @@ int main(int argc, char **argv)
 					"Invalid number of sequential zones\n");
 				return 1;
 			}
-
+		} else if (strncmp(argv[i], "--regular=", 10) == 0) {
+			if (op != DMZ_OP_FORMAT) {
+				fprintf(stderr,
+					"--regular option is valid only with the "
+					"format operation\n");
+				return 1;
+			}
+			dev.regu_dev.path = argv[i] + 10;
+			dev.has_regular = 1;
 		} else if (strcmp(argv[i], "--force") == 0) {
 
 			if (op != DMZ_OP_FORMAT) {
@@ -149,26 +189,9 @@ int main(int argc, char **argv)
 	if (dmz_open_dev(&dev, op) < 0)
 		return 1;
 
-	printf("%s: %llu 512-byte sectors (%llu GiB)\n",
-	       dev.path,
-	       dev.capacity,
-	       (dev.capacity << 9) / (1024ULL * 1024ULL * 1024ULL));
-	printf("  Host-%s device\n",
-	       (dev.flags & DMZ_ZONED_HM) ? "managed" : "aware");
-	nr_zones = dev.capacity / dev.zone_nr_sectors;
-	printf("  %u zones of %zu 512-byte sectors (%zu MiB)\n",
-	       nr_zones,
-	       dev.zone_nr_sectors,
-	       (dev.zone_nr_sectors << 9) / (1024 * 1024));
-	if (nr_zones < dev.nr_zones) {
-		size_t runt_sectors = dev.capacity & (dev.zone_nr_sectors - 1);
-
-		printf("  1 runt zone of %zu 512-byte sectors (%zu MiB)\n",
-		       runt_sectors,
-		       (runt_sectors << 9) / (1024 * 1024));
-	}
-	printf("  %zu 4KB data blocks per zone\n",
-	       dev.zone_nr_blocks);
+	dump_info(&dev.zoned_dev);
+	if (dev.has_regular)
+		dump_info(&dev.regu_dev);
 
 	switch (op) {
 
@@ -176,6 +199,7 @@ int main(int argc, char **argv)
 		ret = dmz_format(&dev);
 		break;
 
+#if 0
 	case DMZ_OP_CHECK:
 		ret = dmz_check(&dev);
 		break;
@@ -183,6 +207,7 @@ int main(int argc, char **argv)
 	case DMZ_OP_REPAIR:
 		ret = dmz_repair(&dev);
 		break;
+#endif
 
 	default:
 

--------------2EE09531441FC9B62243DB8E--
