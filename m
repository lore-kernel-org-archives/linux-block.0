Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2075.outbound.protection.outlook.com [40.107.237.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 176C119C54F
	for <linux-block@vger.kernel.org>; Tue,  7 Jan 2025 18:26:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736274418; cv=fail; b=LYFfKJdfQfXY0HaUaZm2U+tg0YIwMMmjb69a5cmbDG0Qq1/wvS7iOZr3aU1zKyxLUIq5qomzSfwq43nrxcqkUMznd/1zQnlm3jmhJ/lFiqY1I8N0Bjvelpq6oN5iItxyocGT8Vz6FqnLqPtZJDNecsbalGbZxZJd1aOsEw6DyDs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736274418; c=relaxed/simple;
	bh=4rgSOyiXKzurvlz3spMJvoHHUtHnoa9e93Pz0RyTxZA=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=jLu6uK3vDTZxUyiBxevWliqLG+X9tYS/amxQkCBk7P3MS85TOacB9VkQJOl6TzYBYh01taGuQ9UjdhXMFYnU+D5EheHmXs/1uHGdFuz5vZVUrtp8a/tq5/8l+QWNA6ryw3AXA+ykyVWZKyFOZS8B+sQGYr5SHS1SkkLRM4BLLIs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=5oDmNI05; arc=fail smtp.client-ip=40.107.237.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="5oDmNI05"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=x+XRKJdaZeT7YAKke4vzMjs7msF5tiu4CeyCoCsfUmdi9j0G62m2Z4plJe2soG6+U1dH2KsK1JVNF2KMU/nm8gkCTbT5Od57hZ1adStRqoJfx76Cq4uEGGCLiBR8eA0TbljaWb45xSe/GRk5AGtH/MK1Q/2AuxJE+H1lFyP8R+f347claJ045onZf59cfUr4ttI9L8ju52AVQu/42vRzkYjS5vFX09LQHti05kGszru6P/4/yudgPV+Q9O08jzM17oTEI7U3gxwTR7LO0wDofH0d32nbBK7+8mQL1TaGBo9G2LV3gIyD5Jm2Q+wvS1NsQcBEYuh4JZLI5teklp4Pvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cnCZD72W1e2mB6A7YSCbiHYKW6Mej/VFIClpAtI493M=;
 b=dtzXutoZjjjW8dKpAOkIm8l/rtvSNGm8p++SmGvIr09v+By4e43dvFhzhhBIrMk+Lu/IGPYWhPTVGmbfahsCt3H3bmAowvze1zZP04VyOoLy8gXhXHRpvkmCtl1ktvfhZuYFxgUwNOPziFnG+pxps7L2FXNYQQv/unWpCzf2J9tmKCzlHI8sxRCZPiJr+bSPgWlQrngvPKHzjkoNQeGLDdqTaccyeAkmWRsWvG8/vf7YYQWsj3GqG94Bsx4AFAk3Lb5pGRu3dTQoRZOcLhevg8WGo4dAI8Vxn/n/KTjxMrXbHUgdjmUdX7Greft2hxo9Q6QU5ezd4g3sw5hfU1H2cA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=daynix.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cnCZD72W1e2mB6A7YSCbiHYKW6Mej/VFIClpAtI493M=;
 b=5oDmNI05qsnoq8oo+itYheahzaOxA/G+4LY7nd1h7b9kRIBdBogr7CCe8mQdA56OE6uoP7wOw3x7mOnkwi/fubatd2pTHLpFsaU0trMeMAvwhxIQXUHZ8vBRpotHD0ZRp0XPYqvd7xuqHk2HoLj2S/Co0Ii/5CZ8eLv37ZJ6jdo=
Received: from CH5P220CA0002.NAMP220.PROD.OUTLOOK.COM (2603:10b6:610:1ef::10)
 by DS0PR12MB8042.namprd12.prod.outlook.com (2603:10b6:8:141::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8314.17; Tue, 7 Jan
 2025 18:26:46 +0000
Received: from CH3PEPF00000015.namprd21.prod.outlook.com
 (2603:10b6:610:1ef:cafe::35) by CH5P220CA0002.outlook.office365.com
 (2603:10b6:610:1ef::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8314.18 via Frontend Transport; Tue,
 7 Jan 2025 18:26:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH3PEPF00000015.mail.protection.outlook.com (10.167.244.120) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8356.0 via Frontend Transport; Tue, 7 Jan 2025 18:26:46 +0000
Received: from driver-dev1.pensando.io (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 7 Jan
 2025 12:26:44 -0600
From: Andrew Boyer <andrew.boyer@amd.com>
To: <andrew.boyer@amd.com>
CC: Viktor Prutyanov <viktor@daynix.com>, "Michael S . Tsirkin"
	<mst@redhat.com>, Jason Wang <jasowang@redhat.com>, Paolo Bonzini
	<pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Eugenio Perez
	<eperezma@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Jens Axboe
	<axboe@kernel.dk>, <virtualization@lists.linux.dev>,
	<linux-block@vger.kernel.org>
Subject: [PATCH] virtio_blk: always post notifications under the lock
Date: Tue, 7 Jan 2025 10:25:16 -0800
Message-ID: <20250107182516.48723-1-andrew.boyer@amd.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF00000015:EE_|DS0PR12MB8042:EE_
X-MS-Office365-Filtering-Correlation-Id: 884feca3-976b-49ff-6a2f-08dd2f48d7e0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|376014|7416014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ZuWNYp6BWLyWpyF/PiREqzsaz4zgXUIHp4DxXwGv52Qe5ae82BKbeIBntD6H?=
 =?us-ascii?Q?IqL/CMVf+b+Z/r9UWUWUZ/FA6j/N5rhuYbzr6P4CloUxxWGcZ7xkumO35WKh?=
 =?us-ascii?Q?gS8jLTqP83Hngh93D8TMJoF7LxWf3eH4+te1ahuxpZ+EAUbMknfNytwvt1UR?=
 =?us-ascii?Q?QBX3mPcTnxXsuXuO2TXxFqze026Dg3ycfTPUczRT+oU7ocSLe0xJxPSMI1Ek?=
 =?us-ascii?Q?Blf2bkk953xgPNKJpFRh9FdC9v6BW3UlicmmehgEwx9We8Ws/qRdD4hRIcJ9?=
 =?us-ascii?Q?3fLi0YJsnETq4h0gZD/MzYSl2ZSoEYAlo3+1JpkthbTEzsSKCApQCBad++du?=
 =?us-ascii?Q?g4fQvT49VYTglp6V3cojDpAz3ghJF+4hd1CioDXFzp1yv7a5PpyBh2gXWtwD?=
 =?us-ascii?Q?Io07WTOYPyDHR0NzIhVGZ/ib74zwhNiI/9YMC1Hr582LbAnW1rTXQ3cGMho6?=
 =?us-ascii?Q?z00Lry5HrPnZtdz+KOe8gEKhvwY7oQlKvqcWWf3tdSZozAv/6PU7XWfV/paR?=
 =?us-ascii?Q?Nqtu/1zKBc4pSECQpNoF5W9inLvYDAnWUX1dnAez1u795Y28dYUg/x6YOVzv?=
 =?us-ascii?Q?+vd14DsQxYbaKt8A3u61h1YpA4iJR4xmIm5MdGusy8gooTpKB9AWnLHt3pi5?=
 =?us-ascii?Q?dGTIx9xvZFN4EKIOR6Iex5N7jEMHRO+WnH3pc2BPZkfHoF3OxuuuvK4POIr7?=
 =?us-ascii?Q?PFxOgaw8M838ehPqxbZyEn6DZ/2K5Aq582fu8ukR5NJVIb/e4But68GkoM1G?=
 =?us-ascii?Q?jKoJn0IAXQtK8aEe1ijncpZXUzNjUw48+BRObDZR1BwJcRvAcxSeyyz+lmvT?=
 =?us-ascii?Q?sbRlY110G5Sn59OVPoarlLemXKZODLrM7pY8HBUGuccdFU+iJqa58l1Qp9NX?=
 =?us-ascii?Q?bdj79QBL6rctBAAHRFaMS9x7EETsszqPET4xN1ek0jihvRyO+uEyunogxzxk?=
 =?us-ascii?Q?kermyGOHRyvHzYycTFdxAy+l5nGPJSlwQnQReWplgdk1tvMtCaPjpYbxz745?=
 =?us-ascii?Q?CZFgwu4WVafclvFSF8aguAA0GFR5v1Wb5uxZqWvqcEJ88jL56zDdobnyVgFs?=
 =?us-ascii?Q?z9KxLOjvkRltItoKIZO0BBAQvB3s5rSuHuexKUlYvd567CxeWjncY22zkS5M?=
 =?us-ascii?Q?ukb3AZeXYdsL53v0emDCTc1BdvTpC8oywTCq9GdA2QkfNrqL7XgRXGNUuXfC?=
 =?us-ascii?Q?2blYAAktOhyiKbT7gwsWAG8sRnstuoaTVdHb9jKHIZ14yPB9VxLMCCh0Ppdw?=
 =?us-ascii?Q?M/an9P6xabMUbXg5sgYYLZTKnYDg7gZBcosAhmAmmq6jlc3pkwWaAduDC4SX?=
 =?us-ascii?Q?ytmQWPSlkoJCDUwqM5hRT0ejErLhUmcFc2OGL+ockCVjmgpZWJIMkY+xydNa?=
 =?us-ascii?Q?IEXjQEy04i4iUsK7OVGd7bDqceM7sVb4t7TUc9uHPvQw/xk7jPCXPWveHDm0?=
 =?us-ascii?Q?VFi/NpnIIzGpF2YC9gtBncviiFinzo18uSxi4Mv6MZu0Y4Jbcmf/FNljmYIb?=
 =?us-ascii?Q?Hb1u9bvE/5tVS90=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(376014)(7416014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jan 2025 18:26:46.1656
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 884feca3-976b-49ff-6a2f-08dd2f48d7e0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH3PEPF00000015.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8042

Commit af8ececda185 ("virtio: add VIRTIO_F_NOTIFICATION_DATA feature
support") added notification data support to the core virtio driver
code. When this feature is enabled, the notification includes the
updated producer index for the queue. Thus it is now critical that
notifications arrive in order.

The virtio_blk driver has historically not worried about notification
ordering. Modify it so that the prepare and kick steps are both done
under the vq lock.

Signed-off-by: Andrew Boyer <andrew.boyer@amd.com>
Reviewed-by: Brett Creeley <brett.creeley@amd.com>
Fixes: af8ececda185 ("virtio: add VIRTIO_F_NOTIFICATION_DATA feature support")
Cc: Viktor Prutyanov <viktor@daynix.com>
Cc: virtualization@lists.linux.dev
Cc: linux-block@vger.kernel.org
---
 drivers/block/virtio_blk.c | 19 ++++---------------
 1 file changed, 4 insertions(+), 15 deletions(-)

diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
index 3efe378f1386..14d9e66bb844 100644
--- a/drivers/block/virtio_blk.c
+++ b/drivers/block/virtio_blk.c
@@ -379,14 +379,10 @@ static void virtio_commit_rqs(struct blk_mq_hw_ctx *hctx)
 {
 	struct virtio_blk *vblk = hctx->queue->queuedata;
 	struct virtio_blk_vq *vq = &vblk->vqs[hctx->queue_num];
-	bool kick;
 
 	spin_lock_irq(&vq->lock);
-	kick = virtqueue_kick_prepare(vq->vq);
+	virtqueue_kick(vq->vq);
 	spin_unlock_irq(&vq->lock);
-
-	if (kick)
-		virtqueue_notify(vq->vq);
 }
 
 static blk_status_t virtblk_fail_to_queue(struct request *req, int rc)
@@ -432,7 +428,6 @@ static blk_status_t virtio_queue_rq(struct blk_mq_hw_ctx *hctx,
 	struct virtblk_req *vbr = blk_mq_rq_to_pdu(req);
 	unsigned long flags;
 	int qid = hctx->queue_num;
-	bool notify = false;
 	blk_status_t status;
 	int err;
 
@@ -454,12 +449,10 @@ static blk_status_t virtio_queue_rq(struct blk_mq_hw_ctx *hctx,
 		return virtblk_fail_to_queue(req, err);
 	}
 
-	if (bd->last && virtqueue_kick_prepare(vblk->vqs[qid].vq))
-		notify = true;
+	if (bd->last)
+		virtqueue_kick(vblk->vqs[qid].vq);
 	spin_unlock_irqrestore(&vblk->vqs[qid].lock, flags);
 
-	if (notify)
-		virtqueue_notify(vblk->vqs[qid].vq);
 	return BLK_STS_OK;
 }
 
@@ -476,7 +469,6 @@ static void virtblk_add_req_batch(struct virtio_blk_vq *vq,
 {
 	struct request *req;
 	unsigned long flags;
-	bool kick;
 
 	spin_lock_irqsave(&vq->lock, flags);
 
@@ -492,11 +484,8 @@ static void virtblk_add_req_batch(struct virtio_blk_vq *vq,
 		}
 	}
 
-	kick = virtqueue_kick_prepare(vq->vq);
+	virtqueue_kick(vq->vq);
 	spin_unlock_irqrestore(&vq->lock, flags);
-
-	if (kick)
-		virtqueue_notify(vq->vq);
 }
 
 static void virtio_queue_rqs(struct rq_list *rqlist)
-- 
2.17.1

