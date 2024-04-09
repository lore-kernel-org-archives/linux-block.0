Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2104.outbound.protection.outlook.com [40.107.215.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 545C14C69
	for <linux-block@vger.kernel.org>; Tue,  9 Apr 2024 06:07:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.215.104
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712642848; cv=fail; b=YLk/IWsCJYvS3PZutQ4LBOaCdglkNwQojbBRmKXBZtRHJxS4LIyegFv5+wd+xJqjrghJmhbffeCpYR+ejUWAo8v+OLjoDZXpaK2ID/dgCp+K/19Swvjd7YArbyTQBCOPwDC/gQD8wK0tl9iTHLFhqx8mYO9pqC6HKgJMiu7bxCw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712642848; c=relaxed/simple;
	bh=QSS78VX83Mx40FIkmkb2twQ0Rr2dfvQ/Z5JgLuFna88=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=Rlh+jm2t5zjhaUi+49qg0pV03FPmquk+fjjW8yIeZORfeiUafxMZaxSypfF65Ord+CM5+LdIg9ytBNB5bOHhf1DCtECh5esB4YePCeOw7U+PrurHhXG9Xez83d28BY3Ue+le83xnNjyrmjj8dKsmxiMmMA1WRswrbDRbgi1UqrI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=QDJR9N+t; arc=fail smtp.client-ip=40.107.215.104
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="QDJR9N+t"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bobb64vh6zTM/RYJkI4PVML5JE6odwVVHRzOQK1cg5w0TmRr7Qh1LDr5Je60O60gcOqFYA1P+zPLEm2k5e8KAnWzEbMpXBhAB42zwsbKoIp9sN/jyKCb2UNceOrxHxUQjk6GZCDJBzioaQQiolKRvyhgEwHIRx4KTh71R8XDxN/ZYSQdSI3RavEYIUZYa+yL+lM+JY8iCtPB3j63xV1cU6OHjKNVwzE5I8fESfml5zkN5825+d95o9dfGuynOWPtztBFsojA7GLGNDkzIv0FI+iiqzB21BF8vOFj/sSgxUtFv0Gsjx21u0mjr4MPzAg1UnG0v0UDjRvj7Yi527QcjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yQ1mcW1tBAChO+oIktgtx9+1rqPBmhdLsaYz6GNgnJ8=;
 b=lXJog5y9We/sz8X4Yc2MUXgUREX7jyEbm8wfM14F7Nzbbw/Yv1aEOc8yDWLNpp07f1LUr6WU9HG4t06couevAjd7o38mMs7UNuKIP6+tM29t6gntTcgIhY7bxjpjOex0H2TejMsl0qq8hZ/aZ8fY98cPOmAmde8i5oYlmOAjT+gf+7l42p8O8poNptZcQhPbmZyuN4pRoeyBml5oGxLqT/UiSKRlRJl7KTyTkFd8djh2IwRVsW4ZWCqmDlREUwa6mXshrOL6F3Mrs5ITLcRhpq9pZRFX3/844xx+9x99j0UpHkPaMBH35H3BNf9tjwAndQ72MJQEEvDY1+tGTuJ4WA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yQ1mcW1tBAChO+oIktgtx9+1rqPBmhdLsaYz6GNgnJ8=;
 b=QDJR9N+tfZByPSarXx30KVoDRmkgQnnowinE2bG/Fd3lmfsEZl61Sgek6ez08vf5xOH0IovpNUYAJXcAu902VVPe2AZ95YfE7Th5qMOBMdC9KpX/a6N3YxQvuVEQcIvwBb5CQEEIrYM9rNSPAxcPiUIrP3l3e01cPmsLsozPwB1oriihldyJuXqd+BRCi7UtqFIekNNfLHr/FLFKHs1PKfxDDgo0UGouVoFTQoYza3En1QF4evBTIqMQlKzJbVaChrF4g0/S74bTl1SMiZbBGPBc+unjJacSlOzxM47/4IlFq5MqbjzJZjTB7qlKc7wHdC4+0MvHrP1heo0GnQrA7Q==
Received: from TYSPR06MB6411.apcprd06.prod.outlook.com (2603:1096:400:42a::11)
 by PUZPR06MB5724.apcprd06.prod.outlook.com (2603:1096:301:f4::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Tue, 9 Apr
 2024 06:07:20 +0000
Received: from TYSPR06MB6411.apcprd06.prod.outlook.com
 ([fe80::3ef3:744c:5bcf:373b]) by TYSPR06MB6411.apcprd06.prod.outlook.com
 ([fe80::3ef3:744c:5bcf:373b%7]) with mapi id 15.20.7409.042; Tue, 9 Apr 2024
 06:07:20 +0000
From: Yang Yang <yang.yang@vivo.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Yang Yang <yang.yang@vivo.com>
Subject: [PATCH] block: support changing scheduler & nr_requests together
Date: Tue,  9 Apr 2024 14:06:33 +0800
Message-Id: <20240409060633.220596-1-yang.yang@vivo.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR06CA0012.apcprd06.prod.outlook.com
 (2603:1096:4:186::13) To TYSPR06MB6411.apcprd06.prod.outlook.com
 (2603:1096:400:42a::11)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYSPR06MB6411:EE_|PUZPR06MB5724:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Cmkz9DOFkCq8mYZxnk9bUScnIXS9VwQRsZaH10ScRjv2BA5VFuKfCelCFxX+hX9E6uDhUKvbzCyn6TIJMpbyjqnuTfyXnsB3QbsKHPD2OL4mGq6PSJIeHOGSDKTcBibO273V62tYPhG9lh6wX5vYa848YRgsLresL0QcIAWlmPY6ETmxvbHaAabxMalAVFuNDMz2pHfjZe7TazzGB198yjkNsjT0ye2IoNZ7H0PMbl0X4P/ZA8u5Upm9ZbdaZoaFbRjG1UIVd/D/NZmNga+yLMqO+eqsnRE+69IZ1kiMggx7OmEinI5ghIBBgl0zMz1qYP4clUaOlNhTi5yx3TsQefG55fkY4ZgrXm4cMO9SjHit9wr7ky7YE1St5cT27ln5L6KHvZ81rlvel3IgDi03lmrDSk+VUYMIjOfyIVgqWujUyexJ2wRIgBX1URuHzcXbfzdud9vWCdR9iWiYMrWiwk/otbijqjfxGThjsGDie6udVUPj8pg8g9JFGmO2eWe5CdoD9gTSHUDE3aKO8oepgWYH3CqmIfAUUU8HOZ86k6lts7QWQsyCKhBEDjTVxm8hSVd6b392q47Gx7xSFeS2pCEFSKhm1IYZaipoXacVKZWRE2zdgA3XdJ07721K6nkxXacwDp5pNNzadF5bKX4zfHJ0ogJc58fNMxivUmZzR90KvTteEMW3dLr0xLy18N61eng/Bx/PD/N0nbIab1CnqA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYSPR06MB6411.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(52116005)(376005)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ewV5bdfW8YDzUlu68Z04qasUcQDK/wR0eKl3nKC8mjhxLt1eysddhRKkv0d6?=
 =?us-ascii?Q?HLF+RRhEZ8bDRlit7sWOrdQwgWC7DQzXEC6YjdaZYRtN44DOeFUO+ImzlXAl?=
 =?us-ascii?Q?/o9NQHxvxZIBb1kO27rgB76FEha8avp+yVMXNeDPVxYDS7yHW8p0LESxbTCM?=
 =?us-ascii?Q?fQ3cXm2T6bmA+a6bnjC8DY+Un3U1EEWAvK2/5llMBvfKfMzz26LFIDmYIi3c?=
 =?us-ascii?Q?Vy8h7EzDGcgOL3jRlxfTku9SuWSooJh6uuAoglaMFcPkrBjLlWGcmBtKxDXJ?=
 =?us-ascii?Q?kPAxsqHuI40Hd2fh5acBTaRryF+pRbBzWRzTCo+UviJTyR8kXZebjC+gZby3?=
 =?us-ascii?Q?EqtZNBBdkui233yGOdebmBJVRyqTQMp1hbSVogAn4m6YXtZ2G26vk2VWllKJ?=
 =?us-ascii?Q?BvZC5/OU7/gbKfpGOltdpESxAjkWzedsx38dZP8Lq0rn86g8e7sOb+thHGWk?=
 =?us-ascii?Q?3Uu/iS0PIS/Gwr/MC8id7KiUq3wtnFe4aXrGNxJMXqjiUsgLhLoK4XgjQVt5?=
 =?us-ascii?Q?s3kapPnBC5KCUfp/1oYzRwDvU4HI/05aHwKTNGQWR7L2a3i4e006QEoyoTTb?=
 =?us-ascii?Q?Xe3JvgaNKiLJ7g6uzrHKbTnJMaoNZTDdRmxCGL0vi6Ih2n9jeOuiQ3sqiM29?=
 =?us-ascii?Q?5hd7yKf4DxOEXAreqGBqCmXVdK5hWssfiMhQEU0S2SOYtXGwLdPsw1xWd5nM?=
 =?us-ascii?Q?ugfQokaCAz2f6LP1XmP5AOMmIGK2B8Nm0QAwG+WvMlIW59xuNcf8pdX2yPE7?=
 =?us-ascii?Q?vrsRIGXhFj0Il3978mh9wCadVrBwO7V7ZbarNcoq1CAifvoygPN8LxqF64xX?=
 =?us-ascii?Q?BrAqcbj1efSF+8Ey+FTJHl0EBjzSzUOUhzsV1882zVnfA70BkOnyr04ACq0I?=
 =?us-ascii?Q?02QmSvW7TvoMkY9DnBQaCGGkH/AqiWPdcFXrz3vgXzIr4QrwO2wYtJVbLp3F?=
 =?us-ascii?Q?ZfL1henvlI5oHYIsz8ZbXgi7b9DBq+3KsHQZ0IrDQchYUT5Hy9WR4Zs+qiOB?=
 =?us-ascii?Q?lEgGltqU230Urg182EZv0KTDmfhh7NGJJotz977y09AJl4iVFyHHrpMRGD0X?=
 =?us-ascii?Q?v3ctiXNxXFtLzgrLH3HZn+JOvJSElSgINBLnQgPlOmhDt82+ZwbXCWgp9IHv?=
 =?us-ascii?Q?BCjcuR1qeIdprRDd7WEPEbwzWZLD1NFbJxW34DwhhDFisU5MzqNdj+NqheCt?=
 =?us-ascii?Q?BvgoW2omnOzR3gAK+cRs1+bakoacHxy5pv3quQ2eOzDjSZaHcO3BrMGAqMTD?=
 =?us-ascii?Q?8lMFK8RSDoOwUpL9UK3sw7Snie0GY47JJPlMTLdG0LwG1g/eEc74u2Ae5r0N?=
 =?us-ascii?Q?yXVbRyslqM2ZUo/zC8eLAw8rBVLg9sZpGiFP+BbfxfbDGGJ3E1vC5kSBuURq?=
 =?us-ascii?Q?PLtLQ+IWwVgWgrO4dwUoip0uJiKT9Qmbdjz9CZNlyVz7/jWnCg51SIXU5ROG?=
 =?us-ascii?Q?k87zM1AYjBqi3NuK5rqdmIA+IcdLfAO82ql4QYiYOYh5/Wuu6vjN3RznDnOf?=
 =?us-ascii?Q?UKOGyalS3/T8Tnw+We0PxM3O2Zg9h746+9W7ba44MV4oko0GI78kBvS2Sx7V?=
 =?us-ascii?Q?eMs63Zd+b9jM43aInoKL8RE9+gsteQ+SO652IT4c?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 577071ea-494c-45bc-f5d4-08dc585b506f
X-MS-Exchange-CrossTenant-AuthSource: TYSPR06MB6411.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2024 06:07:19.6051
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Xs/Dem56UG2BuJI3yBV0jqbJ8Rk843/hkCi5/nD5Kw7g15Gt1xorcgK/CR/4LMyDEobGmxhcxdwTANuRDBfDCw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PUZPR06MB5724

When switching the scheduler, the nr_requests defaults to an initial
value. If we want to change the nr_requests after switching the
scheduler, we need to perform the setting twice. It means the update
process for nr_requests needs to be run twice. And updating nr_requests
may cost dozens of milliseconds in our test environment.

[2.091825] init: Command 'write /sys/block/sda/queue/nr_requests 96' took 24ms
[2.123248] init: Command 'write /sys/block/sdb/queue/nr_requests 96' took 31ms
[2.146620] init: Command 'write /sys/block/sdc/queue/nr_requests 96' took 22ms
[2.171127] init: Command 'write /sys/block/sdd/queue/nr_requests 96' took 24ms
[2.207286] init: Command 'write /sys/block/sde/queue/nr_requests 96' took 36ms
[2.222515] init: Command 'write /sys/block/sdf/queue/nr_requests 96' took 15ms
[2.246704] init: Command 'write /sys/block/sdg/queue/nr_requests 96' took 24ms

So provide a way to configure scheduler and nr_requests together.

Signed-off-by: Yang Yang <yang.yang@vivo.com>
---
 Documentation/ABI/stable/sysfs-block |  2 ++
 block/blk-mq-sched.c                 | 10 +++++---
 block/blk-mq-sched.h                 |  3 ++-
 block/blk-mq.c                       |  2 +-
 block/blk.h                          |  3 ++-
 block/elevator.c                     | 34 +++++++++++++++++++++++-----
 6 files changed, 42 insertions(+), 12 deletions(-)

diff --git a/Documentation/ABI/stable/sysfs-block b/Documentation/ABI/stable/sysfs-block
index 1fe9a553c37b..3f554fc379da 100644
--- a/Documentation/ABI/stable/sysfs-block
+++ b/Documentation/ABI/stable/sysfs-block
@@ -566,6 +566,8 @@ Description:
 		device to that new IO scheduler. Note that writing an IO
 		scheduler name to this file will attempt to load that IO
 		scheduler module, if it isn't already present in the system.
+		Support setting scheduler & nr_requests together,
+		e.g. echo mq-deadline:256 > scheduler
 
 
 What:		/sys/block/<disk>/queue/stable_writes
diff --git a/block/blk-mq-sched.c b/block/blk-mq-sched.c
index 451a2c1f1f32..e7cd00e238db 100644
--- a/block/blk-mq-sched.c
+++ b/block/blk-mq-sched.c
@@ -438,7 +438,8 @@ static int blk_mq_init_sched_shared_tags(struct request_queue *queue)
 }
 
 /* caller must have a reference to @e, will grab another one if successful */
-int blk_mq_init_sched(struct request_queue *q, struct elevator_type *e)
+int blk_mq_init_sched(struct request_queue *q, struct elevator_type *e,
+		unsigned long nr_rqs)
 {
 	unsigned int flags = q->tag_set->flags;
 	struct blk_mq_hw_ctx *hctx;
@@ -451,8 +452,11 @@ int blk_mq_init_sched(struct request_queue *q, struct elevator_type *e)
 	 * since we don't split into sync/async like the old code did.
 	 * Additionally, this is a per-hw queue depth.
 	 */
-	q->nr_requests = 2 * min_t(unsigned int, q->tag_set->queue_depth,
-				   BLKDEV_DEFAULT_RQ);
+	if (nr_rqs)
+		q->nr_requests = nr_rqs;
+	else
+		q->nr_requests = 2 * min_t(unsigned int, q->tag_set->queue_depth,
+				BLKDEV_DEFAULT_RQ);
 
 	if (blk_mq_is_shared_tags(flags)) {
 		ret = blk_mq_init_sched_shared_tags(q);
diff --git a/block/blk-mq-sched.h b/block/blk-mq-sched.h
index 1326526bb733..11631840341e 100644
--- a/block/blk-mq-sched.h
+++ b/block/blk-mq-sched.h
@@ -18,7 +18,8 @@ void __blk_mq_sched_restart(struct blk_mq_hw_ctx *hctx);
 
 void blk_mq_sched_dispatch_requests(struct blk_mq_hw_ctx *hctx);
 
-int blk_mq_init_sched(struct request_queue *q, struct elevator_type *e);
+int blk_mq_init_sched(struct request_queue *q, struct elevator_type *e,
+		unsigned long nr_rqs);
 void blk_mq_exit_sched(struct request_queue *q, struct elevator_queue *e);
 void blk_mq_sched_free_rqs(struct request_queue *q);
 
diff --git a/block/blk-mq.c b/block/blk-mq.c
index 32afb87efbd0..4ecb9db62337 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -4707,7 +4707,7 @@ static void blk_mq_elv_switch_back(struct list_head *head,
 	kfree(qe);
 
 	mutex_lock(&q->sysfs_lock);
-	elevator_switch(q, t);
+	elevator_switch(q, t, 0);
 	/* drop the reference acquired in blk_mq_elv_switch_none */
 	elevator_put(t);
 	mutex_unlock(&q->sysfs_lock);
diff --git a/block/blk.h b/block/blk.h
index d9f584984bc4..d52e6e087117 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -287,7 +287,8 @@ bool blk_bio_list_merge(struct request_queue *q, struct list_head *list,
 
 bool blk_insert_flush(struct request *rq);
 
-int elevator_switch(struct request_queue *q, struct elevator_type *new_e);
+int elevator_switch(struct request_queue *q, struct elevator_type *new_e,
+		unsigned long nr_rqs);
 void elevator_disable(struct request_queue *q);
 void elevator_exit(struct request_queue *q);
 int elv_register_queue(struct request_queue *q, bool uevent);
diff --git a/block/elevator.c b/block/elevator.c
index 5ff093cb3cf8..07ed7f544ef6 100644
--- a/block/elevator.c
+++ b/block/elevator.c
@@ -639,7 +639,7 @@ void elevator_init_mq(struct request_queue *q)
 	blk_mq_freeze_queue(q);
 	blk_mq_cancel_work_sync(q);
 
-	err = blk_mq_init_sched(q, e);
+	err = blk_mq_init_sched(q, e, 0);
 
 	blk_mq_unfreeze_queue(q);
 
@@ -657,7 +657,8 @@ void elevator_init_mq(struct request_queue *q)
  * If switching fails, we are most likely running out of memory and not able
  * to restore the old io scheduler, so leaving the io scheduler being none.
  */
-int elevator_switch(struct request_queue *q, struct elevator_type *new_e)
+int elevator_switch(struct request_queue *q, struct elevator_type *new_e,
+		unsigned long nr_rqs)
 {
 	int ret;
 
@@ -671,7 +672,7 @@ int elevator_switch(struct request_queue *q, struct elevator_type *new_e)
 		elevator_exit(q);
 	}
 
-	ret = blk_mq_init_sched(q, new_e);
+	ret = blk_mq_init_sched(q, new_e, nr_rqs);
 	if (ret)
 		goto out_unfreeze;
 
@@ -715,7 +716,8 @@ void elevator_disable(struct request_queue *q)
 /*
  * Switch this queue to the given IO scheduler.
  */
-static int elevator_change(struct request_queue *q, const char *elevator_name)
+static int elevator_change(struct request_queue *q, const char *elevator_name,
+		unsigned long nr_rqs)
 {
 	struct elevator_type *e;
 	int ret;
@@ -740,7 +742,7 @@ static int elevator_change(struct request_queue *q, const char *elevator_name)
 		if (!e)
 			return -EINVAL;
 	}
-	ret = elevator_switch(q, e);
+	ret = elevator_switch(q, e, nr_rqs);
 	elevator_put(e);
 	return ret;
 }
@@ -749,13 +751,33 @@ ssize_t elv_iosched_store(struct request_queue *q, const char *buf,
 			  size_t count)
 {
 	char elevator_name[ELV_NAME_MAX];
+	unsigned long nr_rqs;
+	const char *num;
+	char *tmp;
 	int ret;
 
 	if (!elv_support_iosched(q))
 		return count;
 
+	/*
+	 * Support setting scheduler & nr_requests together
+	 * e.g. echo mq-deadline:256 > scheduler
+	 */
+	tmp = strchr(buf, ':');
+	if (tmp) {
+		*tmp = '\0';
+		num = tmp + 1;
+
+		ret = kstrtoul(num, 10, &nr_rqs);
+		if (ret || nr_rqs > MAX_SCHED_RQ)
+			return -EINVAL;
+
+		if (nr_rqs < BLKDEV_MIN_RQ)
+			nr_rqs = BLKDEV_MIN_RQ;
+	}
+
 	strscpy(elevator_name, buf, sizeof(elevator_name));
-	ret = elevator_change(q, strstrip(elevator_name));
+	ret = elevator_change(q, strstrip(elevator_name), nr_rqs);
 	if (!ret)
 		return count;
 	return ret;
-- 
2.34.1

