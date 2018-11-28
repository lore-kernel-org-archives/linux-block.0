Return-Path: <SRS0=FxMo=OH=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7887FC43441
	for <linux-block@archiver.kernel.org>; Wed, 28 Nov 2018 03:53:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 43BDC20873
	for <linux-block@archiver.kernel.org>; Wed, 28 Nov 2018 03:53:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="jjJqDbxQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 43BDC20873
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727310AbeK1Own (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 28 Nov 2018 09:52:43 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:49868 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726847AbeK1Owl (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 28 Nov 2018 09:52:41 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id wAS3n7cD189030;
        Wed, 28 Nov 2018 03:52:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2018-07-02;
 bh=BGxfOtbnwbxoSi86gUIBC5QMn8k64hISnYOpB7SmpVE=;
 b=jjJqDbxQ5S1OgAErXyJi3ukv7lpyF3jBLnHzYjpQ2IJBC4G8KRyy4eG7DvGsI8eOosL+
 IjxA+10xGpEid2GI3zpCTRCXd+QRrQZPrqIb9jIevTbAjMwxwcCC1aoWWQN8YoIlZHZz
 25uEKFvyYiTgun23m22MLa3EYawAMrJic/QZsK+H3UeY47QnN/RW5UuGzQKOXdPCgXtr
 /Du4RiE+VMA6UWJLOlKydW/cuRf5SLd0tZbmVFKOGo222q8dawus8wFqZvid8ME6deQ8
 R5oUFTtB2fpVYxd69m1j3+bt4Lw1+zB3b2JW1w3shdsc3ni86dKpx6UBHijJwnFGWzAG cw== 
Received: from aserv0021.oracle.com (aserv0021.oracle.com [141.146.126.233])
        by userp2120.oracle.com with ESMTP id 2nxy9r7rb9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 28 Nov 2018 03:52:33 +0000
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserv0021.oracle.com (8.14.4/8.14.4) with ESMTP id wAS3qWPu018742
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 28 Nov 2018 03:52:32 GMT
Received: from abhmp0014.oracle.com (abhmp0014.oracle.com [141.146.116.20])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id wAS3qWAu005861;
        Wed, 28 Nov 2018 03:52:32 GMT
Received: from localhost.localdomain (/70.176.225.12)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 27 Nov 2018 19:52:32 -0800
From:   Allison Henderson <allison.henderson@oracle.com>
To:     linux-block@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Cc:     martin.petersen@oracle.com, shirley.ma@oracle.com,
        bob.liu@oracle.com, allison.henderson@oracle.com
Subject: [PATCH v1 3/7] md: raid1: handle bi_rw_hint accordingly
Date:   Tue, 27 Nov 2018 20:49:47 -0700
Message-Id: <1543376991-5764-4-git-send-email-allison.henderson@oracle.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1543376991-5764-1-git-send-email-allison.henderson@oracle.com>
References: <1543376991-5764-1-git-send-email-allison.henderson@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9090 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1811280033
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Bob Liu <bob.liu@oracle.com>

* nr_mirrors that raid1 device support should be @raid_disks, init it properly.
* Recording i/o went to which mirror in bio->bi_rw_hint.
* Read from specific real device if bi_rw_hint was set.

Todo:
 * Support more drivers.

Signed-off-by: Bob Liu <bob.liu@oracle.com>
---
 drivers/md/raid1.c | 31 ++++++++++++++++++++++++++++---
 1 file changed, 28 insertions(+), 3 deletions(-)

diff --git a/drivers/md/raid1.c b/drivers/md/raid1.c
index fedf8c0..d2bdd0e 100644
--- a/drivers/md/raid1.c
+++ b/drivers/md/raid1.c
@@ -553,7 +553,8 @@ static sector_t align_to_barrier_unit_end(sector_t start_sector,
  *
  * The rdev for the device selected will have nr_pending incremented.
  */
-static int read_balance(struct r1conf *conf, struct r1bio *r1_bio, int *max_sectors)
+static int read_balance(struct r1conf *conf, struct r1bio *r1_bio, int *max_sectors,
+			unsigned short disk_hint)
 {
 	const sector_t this_sector = r1_bio->sector;
 	int sectors;
@@ -566,6 +567,7 @@ static int read_balance(struct r1conf *conf, struct r1bio *r1_bio, int *max_sect
 	struct md_rdev *rdev;
 	int choose_first;
 	int choose_next_idle;
+	int max_disks;
 
 	rcu_read_lock();
 	/*
@@ -593,7 +595,20 @@ static int read_balance(struct r1conf *conf, struct r1bio *r1_bio, int *max_sect
 	else
 		choose_first = 0;
 
-	for (disk = 0 ; disk < conf->raid_disks * 2 ; disk++) {
+	if (disk_hint) {
+		disk = disk_hint - 1;
+		/*
+		 * Consider replacement as a special case, use original device to
+		 * indicate which mirror this i/o was happened.
+		 */
+		if (disk >= conf->raid_disks)
+			disk -= conf->raid_disks;
+		max_disks = disk + 1;
+	} else {
+		disk = 0;
+		max_disks = conf->raid_disks * 2;
+	}
+	for (; disk < max_disks; disk++) {
 		sector_t dist;
 		sector_t first_bad;
 		int bad_sectors;
@@ -1234,7 +1249,7 @@ static void raid1_read_request(struct mddev *mddev, struct bio *bio,
 	 * make_request() can abort the operation when read-ahead is being
 	 * used and no empty request is available.
 	 */
-	rdisk = read_balance(conf, r1_bio, &max_sectors);
+	rdisk = read_balance(conf, r1_bio, &max_sectors, bio->bi_rw_hint);
 
 	if (rdisk < 0) {
 		/* couldn't find anywhere to read from */
@@ -1247,6 +1262,10 @@ static void raid1_read_request(struct mddev *mddev, struct bio *bio,
 		raid_end_bio_io(r1_bio);
 		return;
 	}
+
+	/* Recording i/o went to which real device. */
+	bio->bi_rw_hint = rdisk;
+
 	mirror = conf->mirrors + rdisk;
 
 	if (print_msg)
@@ -1279,6 +1298,11 @@ static void raid1_read_request(struct mddev *mddev, struct bio *bio,
 	r1_bio->read_disk = rdisk;
 
 	read_bio = bio_clone_fast(bio, gfp, &mddev->bio_set);
+	/*
+	 * Clear bi_rw_hint, because it was set last i/o went to which real
+	 * device.
+	 */
+	read_bio->bi_rw_hint = 0;
 
 	r1_bio->bios[rdisk] = read_bio;
 
@@ -3078,6 +3102,7 @@ static int raid1_run(struct mddev *mddev)
 	if (mddev->queue) {
 		blk_queue_max_write_same_sectors(mddev->queue, 0);
 		blk_queue_max_write_zeroes_sectors(mddev->queue, 0);
+		blk_queue_set_mirrors(mddev->queue, mddev->raid_disks);
 	}
 
 	rdev_for_each(rdev, mddev) {
-- 
2.7.4

