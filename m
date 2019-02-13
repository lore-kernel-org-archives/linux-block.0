Return-Path: <SRS0=Y8Hj=QU=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 989B6C282C2
	for <linux-block@archiver.kernel.org>; Wed, 13 Feb 2019 09:53:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 53CAC222CD
	for <linux-block@archiver.kernel.org>; Wed, 13 Feb 2019 09:53:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="cPEOtW0I"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387762AbfBMJxk (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 13 Feb 2019 04:53:40 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:58376 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387608AbfBMJxj (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 13 Feb 2019 04:53:39 -0500
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x1D9mvIb165103;
        Wed, 13 Feb 2019 09:53:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2018-07-02;
 bh=jfJEGyUia68X02HRL/FFy0BAdRTlo865x0zKmnFbipc=;
 b=cPEOtW0IK+izQ10dNCphR8MF8OqxZOQVKzmYRnwI2InBY5hgzuFbZUnvxPGrYYie+2KG
 UuoRXAsndS3StgRGkxEEEZkGEI+TDK32mbJ/A9HWcEcS2WWIfMH1k/hht3jDBeaQVa3e
 HsrJXVeTMC8Z9m5xm6RLAf0/SSRdOFrHPiEwmKuzS4FMW9A8kwKGwkNPW5ARQ9L36zx/
 4G68qU2XJiHaoA4D4zw5n1UEHHRwanm2SNC7kTd+aqlJ+fLKddjGXaiDv9T8DCJo0apO
 V0wpgOWWdPdVn3mBNGAKdLE/qc+ScRtBsaQs7nPosMzNCQPkClLooZ/A5lws5X1D6fji 3g== 
Received: from userv0021.oracle.com (userv0021.oracle.com [156.151.31.71])
        by aserp2130.oracle.com with ESMTP id 2qhre5gyut-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 13 Feb 2019 09:53:31 +0000
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userv0021.oracle.com (8.14.4/8.14.4) with ESMTP id x1D9rTJ6010256
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 13 Feb 2019 09:53:30 GMT
Received: from abhmp0006.oracle.com (abhmp0006.oracle.com [141.146.116.12])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x1D9rTXx005217;
        Wed, 13 Feb 2019 09:53:29 GMT
Received: from localhost.localdomain (/116.239.187.160)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 13 Feb 2019 09:53:28 +0000
From:   Bob Liu <bob.liu@oracle.com>
To:     linux-block@vger.kernel.org
Cc:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        martin.petersen@oracle.com, shirley.ma@oracle.com,
        allison.henderson@oracle.com, david@fromorbit.com,
        darrick.wong@oracle.com, hch@infradead.org, adilger@dilger.ca,
        Bob Liu <bob.liu@oracle.com>
Subject: [RFC PATCH v2 4/9] md:raid1: rd_hint support and consider stacked layer case
Date:   Wed, 13 Feb 2019 17:50:39 +0800
Message-Id: <20190213095044.29628-5-bob.liu@oracle.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190213095044.29628-1-bob.liu@oracle.com>
References: <20190213095044.29628-1-bob.liu@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9165 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1902130072
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

rd_hint is a bit map for stacked md layer supporting.
When submit bio to a lower md layer, the bio->bi_rd_hint should be split
according mirror number of each device of lower layer.
And merge bio->bi_rd_hint in the end path vise versa.

For a two layer stacked md case like:
                           /dev/md0
             /                |                        \
      /dev/md1-a             /dev/md1-b                /dev/md1-c
   /        \           /       |        \           /      |      \
/dev/sda /dev/sdb  /dev/sdc /dev/sdd  /dev/sde  /dev/sdf /dev/sdg /dev/sdh


- 1) First the top layer sumbit bio with bi_rd_hint = [00 000 000],
then the value of bi_rd_hint changed as below when bio goes to lower layer.
                         [00 000 000]
             /                |                       \
         [00]               [000]                    [000]
   /        \           /       |        \           /      |      \
[0]         [0]        [0]     [0]       [0]       [0]     [0]     [0]


- 2) i/o may goes to  /dev/sda at first:
[1]         [0]        [0]     [0]      [0]       [0]     [0]     [0]
  \         /           \       |        /          \      |      /
         [10]                [000]                    [000]
             \                |                       /
                         [10 000 000]
The top layer will get bio->bi_rd_hint = [10 000 000]


- 3) Fs check the data is corrupt, resumbit bio with bi_rd_hint = [10 000 000]
                         [10 000 000]
             /                |                       \
         [10]               [000]                    [000]
   /        \           /       |        \           /      |      \
[1]         [0]        [0]     [0]       [0]       [0]     [0]     [0]


- 4) i/o can go to any dev except /dev/sda(already tried), assum goes to /dev/sdg
this time.
[1]         [0]        [0]     [0]      [0]       [0]     [1]     [0]
  \         /           \       |        /          \      |      /
         [10]                [000]                    [010]
             \                |                       /
                         [10 000 010]
The top layer will get bio->bi_rd_hint = [10 000 010], which means we already
tried /dev/sda and /dev/sdg.


- 5) If the data is corrupt again, resumbit bio with
bi_rd_hint = [10 000 010].

Loop until all mirrors are tried..

Signed-off-by: Bob Liu <bob.liu@oracle.com>
---
 drivers/md/raid1.c | 117 ++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 116 insertions(+), 1 deletion(-)

diff --git a/drivers/md/raid1.c b/drivers/md/raid1.c
index 0de28714e9b5..75fde3a3fd3d 100644
--- a/drivers/md/raid1.c
+++ b/drivers/md/raid1.c
@@ -325,6 +325,41 @@ static int find_bio_disk(struct r1bio *r1_bio, struct bio *bio)
 	return mirror;
 }
 
+/* merge children's rd hint to master bio */
+static void raid1_merge_rd_hint(struct bio *bio)
+{
+	struct r1bio *r1_bio = bio->bi_private;
+	struct r1conf *conf = r1_bio->mddev->private;
+	struct md_rdev *tmp_rdev = NULL;
+	int i = conf->raid_disks - 1;
+	int cnt = 0;
+	int read_disk = r1_bio->read_disk;
+	DECLARE_BITMAP(tmp_bitmap, BLKDEV_MAX_MIRRORS);
+
+	if (!r1_bio->master_bio)
+		return;
+
+	/* ignore replace case now */
+	if (read_disk > conf->raid_disks - 1)
+		read_disk = r1_bio->read_disk - conf->raid_disks;
+
+	for (; i >= 0; i--) {
+		tmp_rdev = conf->mirrors[i].rdev;
+		if (i == read_disk)
+			break;
+		cnt += blk_queue_get_mirrors(bdev_get_queue(tmp_rdev->bdev));
+	}
+
+	/* init map properly from most lower layer */
+	if (blk_queue_get_mirrors(bdev_get_queue(tmp_rdev->bdev)) == 1)
+		bitmap_set(bio->bi_rd_hint, 0, 1);
+
+	bitmap_shift_left(tmp_bitmap, bio->bi_rd_hint, cnt, BLKDEV_MAX_MIRRORS);
+	bitmap_or(r1_bio->master_bio->bi_rd_hint,
+		  r1_bio->master_bio->bi_rd_hint, tmp_bitmap,
+		  BLKDEV_MAX_MIRRORS);
+}
+
 static void raid1_end_read_request(struct bio *bio)
 {
 	int uptodate = !bio->bi_status;
@@ -332,6 +367,7 @@ static void raid1_end_read_request(struct bio *bio)
 	struct r1conf *conf = r1_bio->mddev->private;
 	struct md_rdev *rdev = conf->mirrors[r1_bio->read_disk].rdev;
 
+	raid1_merge_rd_hint(bio);
 	/*
 	 * this branch is our 'one mirror IO has finished' event handler:
 	 */
@@ -539,6 +575,37 @@ static sector_t align_to_barrier_unit_end(sector_t start_sector,
 	return len;
 }
 
+static long choose_disk_from_rd_hint(struct r1conf *conf, struct r1bio *r1_bio)
+{
+	struct md_rdev *tmp_rdev;
+	unsigned long bit, cnt;
+	struct bio *bio = r1_bio->master_bio;
+	int mirror = conf->raid_disks - 1;
+
+	cnt = blk_queue_get_mirrors(r1_bio->mddev->queue);
+	/* Find a never-readed device */
+	bit = bitmap_find_next_zero_area(bio->bi_rd_hint, cnt, 0, 1, 0);
+	if (bit >= cnt)
+		/* Already tried all mirrors */
+		return -1;
+
+	/* Decide this device belongs to which mirror for stacked-layer raid
+	 * devices. */
+	cnt = 0;
+	for ( ; mirror >= 0; mirror--) {
+		tmp_rdev = conf->mirrors[mirror].rdev;
+		cnt += blk_queue_get_mirrors(bdev_get_queue(tmp_rdev->bdev));
+		/* bit start from 0, while mirrors start from 1. So should compare
+		 * with (bit + 1) */
+		if (cnt >= (bit + 1)) {
+			return mirror;
+		}
+	}
+
+	/* Should not arrive here. */
+	return -1;
+}
+
 /*
  * This routine returns the disk from which the requested read should
  * be done. There is a per-array 'next expected sequential IO' sector
@@ -566,6 +633,7 @@ static int read_balance(struct r1conf *conf, struct r1bio *r1_bio, int *max_sect
 	struct md_rdev *rdev;
 	int choose_first;
 	int choose_next_idle;
+	int max_disks;
 
 	rcu_read_lock();
 	/*
@@ -593,7 +661,18 @@ static int read_balance(struct r1conf *conf, struct r1bio *r1_bio, int *max_sect
 	else
 		choose_first = 0;
 
-	for (disk = 0 ; disk < conf->raid_disks * 2 ; disk++) {
+	if (!bitmap_empty(r1_bio->master_bio->bi_rd_hint, BLKDEV_MAX_MIRRORS)) {
+		disk  = choose_disk_from_rd_hint(conf, r1_bio);
+		if (disk < 0)
+			return -1;
+
+		/* Use the specific disk */
+		max_disks = disk + 1;
+	} else {
+		disk = 0;
+		max_disks = conf->raid_disks * 2;
+	}
+	for (; disk < max_disks; disk++) {
 		sector_t dist;
 		sector_t first_bad;
 		int bad_sectors;
@@ -1186,6 +1265,34 @@ alloc_r1bio(struct mddev *mddev, struct bio *bio)
 	return r1_bio;
 }
 
+static void raid1_split_rd_hint(struct bio *bio)
+{
+	struct r1bio *r1_bio = bio->bi_private;
+	struct r1conf *conf = r1_bio->mddev->private;
+	unsigned int cnt = 0;
+	DECLARE_BITMAP(tmp_bitmap, BLKDEV_MAX_MIRRORS);
+
+	int i = conf->raid_disks - 1;
+	struct md_rdev *tmp_rdev = NULL;
+
+	for (; i >= 0; i--) {
+		tmp_rdev = conf->mirrors[i].rdev;
+		if (i == r1_bio->read_disk)
+			break;
+		cnt += blk_queue_get_mirrors(bdev_get_queue(tmp_rdev->bdev));
+	}
+
+	bitmap_zero(tmp_bitmap, BLKDEV_MAX_MIRRORS);
+	bitmap_shift_right(bio->bi_rd_hint, r1_bio->master_bio->bi_rd_hint, cnt,
+			BLKDEV_MAX_MIRRORS);
+
+	cnt = blk_queue_get_mirrors(bdev_get_queue(tmp_rdev->bdev));
+	bitmap_set(tmp_bitmap, 0, cnt);
+
+	bitmap_and(bio->bi_rd_hint, bio->bi_rd_hint, tmp_bitmap,
+			BLKDEV_MAX_MIRRORS);
+}
+
 static void raid1_read_request(struct mddev *mddev, struct bio *bio,
 			       int max_read_sectors, struct r1bio *r1_bio)
 {
@@ -1199,6 +1306,7 @@ static void raid1_read_request(struct mddev *mddev, struct bio *bio,
 	int rdisk;
 	bool print_msg = !!r1_bio;
 	char b[BDEVNAME_SIZE];
+	bool auto_select_mirror;
 
 	/*
 	 * If r1_bio is set, we are blocking the raid1d thread
@@ -1230,6 +1338,8 @@ static void raid1_read_request(struct mddev *mddev, struct bio *bio,
 	else
 		init_r1bio(r1_bio, mddev, bio);
 	r1_bio->sectors = max_read_sectors;
+	auto_select_mirror = bitmap_empty(r1_bio->master_bio->bi_rd_hint, BLKDEV_MAX_MIRRORS);
+
 
 	/*
 	 * make_request() can abort the operation when read-ahead is being
@@ -1238,6 +1348,9 @@ static void raid1_read_request(struct mddev *mddev, struct bio *bio,
 	rdisk = read_balance(conf, r1_bio, &max_sectors);
 
 	if (rdisk < 0) {
+		if (auto_select_mirror)
+			bitmap_set(r1_bio->master_bio->bi_rd_hint, 0, BLKDEV_MAX_MIRRORS);
+
 		/* couldn't find anywhere to read from */
 		if (print_msg) {
 			pr_crit_ratelimited("md/raid1:%s: %s: unrecoverable I/O read error for block %llu\n",
@@ -1292,6 +1405,8 @@ static void raid1_read_request(struct mddev *mddev, struct bio *bio,
 	    test_bit(R1BIO_FailFast, &r1_bio->state))
 	        read_bio->bi_opf |= MD_FAILFAST;
 	read_bio->bi_private = r1_bio;
+	/* rd_hint of read_bio is a subset of master_bio. */
+	raid1_split_rd_hint(read_bio);
 
 	if (mddev->gendisk)
 	        trace_block_bio_remap(read_bio->bi_disk->queue, read_bio,
-- 
2.17.1

