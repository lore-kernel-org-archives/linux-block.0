Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2052.outbound.protection.outlook.com [40.107.92.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DBB641A91;
	Sat, 17 Feb 2024 18:09:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708193359; cv=fail; b=Wrtt68XbJCrWRKgLhe4FqwzMCjUM2NN66SblOzMHgyvBFn5eXbOwLhBEbHdxPg1tO5GZCiMLvHkcw9jVhbQqIhu4IEO9d/3tf/tyxoGpzfA6wrjiHO61Rnc8J5a9BQvcZgNNfWYjDlpoY0KZQ1m1GzbUMPG2jNNT/UCUgGlQNzw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708193359; c=relaxed/simple;
	bh=jQ57MvKgn3EfrhO6y2x0oOWiKRneF+/aAfFXyuSpeWo=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=aWQBiHfhDojexaTSSGmYnDyAcK7sUv14rvy720NCfFVG2T1IyzKSlsImMMxHwOMCRESYNvPzbDBaCzRQXt38DWmB1rnf/nBDzbMUq5CAfpN4epvR1yaHsKjQRnMqvLLJiXzZUdWUWNG+snmanLzvIEmfS5FydbvMKy+3BesXp7k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=c4ZXX9j9; arc=fail smtp.client-ip=40.107.92.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="c4ZXX9j9"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JVT9nU5H3/wA38t9AAd6LaAJ2j4jG2tFKJ1QDjQCelupPd59HD9PZmpwhXSKoPjv+2LapdklchOmHvkSEUR7WJ7cj2L+RYRNqZqqMqDy2mV1YMPy52Pyr5RURXlC/JEXQEEe+JWsVc6GDXeg5kyCfYjuZrxPgJcqp3gVNi+GjUuK5EEhUcEG41Rxu6g7SEItY4TcfkCLrJ43BK22TsDnR0i0wNs9dOrV5xOHfM6cuOr/THBBf3FKf0fx0JPnsAPj1s6tqytot4VRae3ZEhb/JS5rYW/xOKuYRewZ1+F4q14e3JSeaAjDnqz/IYXSt+GBuzNKQBOaB6c1o1PKC0WnTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BvvTxol+0w8JCtOQB8GD8ea8lYD23b9NgalUBwIFWro=;
 b=X1abJez9oF4Wd1uUd+OD/s6Zm3cLwtApSKqTvKmoNkhXzKO6kcCjCsDFihJ4QwIJcbExQSQyQQ01mb4D5Q6/2hBdv6MEalFMjFn/KUlXmVk6ARaCXbHZVv8TeZyTJJL6Aq7ZNNLfyv59VpiWlzhXOUQsjOAaZWs70PQ93LGfclkNc3jcrYkxBI1O6yAw8WyjpunwuthCDToDYoSMbDoOWTXWTX8r3vjGPm6ubEAWa05u9VgFeaAScE4d3aB2fOt2SL3RotK54C1DSYTdqr1LSymbOFBzG0S2We678ANVllCZ7KL0G5B/I1KgcEk9WR1Q1vmeC5M976kLd0MqK+rRIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BvvTxol+0w8JCtOQB8GD8ea8lYD23b9NgalUBwIFWro=;
 b=c4ZXX9j9rI7VJ+C4mUd3z9nvpeoejbugZEMB/7OH1BYt+u8L45696qqi5TnButpx/IhldA57hdxJROAdEwjpEEhqPeJQzrkCwtE0Hv0XRdjpEl/8m5ru5txvArH6nI+/v63kHYVyiwbRyOW1stLmo/5WPVgVVIGfLqWtcXQBqpsPY9d7u9ANi0cXtR10CymLaEGiMJj00MVKTAzgCXodolovV+cTXG0mzxu8NU14U015zfoZSuACu8OY+ewI+7hTUHkh7No+al/hEsY8dw5tEI6Et1kF244SsvHi0huc/x9RO4l0jZYv+uhUW7ontzZ3dDNlrAtBeeaKGZD0oauzDA==
Received: from PH8PR07CA0011.namprd07.prod.outlook.com (2603:10b6:510:2cd::19)
 by DS0PR12MB8070.namprd12.prod.outlook.com (2603:10b6:8:dc::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.15; Sat, 17 Feb
 2024 18:09:13 +0000
Received: from SN1PEPF0002BA4B.namprd03.prod.outlook.com
 (2603:10b6:510:2cd:cafe::79) by PH8PR07CA0011.outlook.office365.com
 (2603:10b6:510:2cd::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.34 via Frontend
 Transport; Sat, 17 Feb 2024 18:09:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SN1PEPF0002BA4B.mail.protection.outlook.com (10.167.242.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7292.25 via Frontend Transport; Sat, 17 Feb 2024 18:09:12 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Sat, 17 Feb
 2024 10:09:02 -0800
Received: from sw-mtx-036.mtx.labs.mlnx (10.126.231.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.12; Sat, 17 Feb 2024 10:09:00 -0800
From: Parav Pandit <parav@nvidia.com>
To: <mst@redhat.com>, <jasowang@redhat.com>, <xuanzhuo@linux.alibaba.com>,
	<pbonzini@redhat.com>, <stefanha@redhat.com>, <axboe@kernel.dk>,
	<virtualization@lists.linux.dev>, <linux-block@vger.kernel.org>
CC: Parav Pandit <parav@nvidia.com>, <stable@vger.kernel.org>,
	<lirongqing@baidu.com>, Chaitanya Kulkarni <kch@nvidia.com>
Subject: [PATCH] virtio_blk: Fix device surprise removal
Date: Sat, 17 Feb 2024 20:08:48 +0200
Message-ID: <20240217180848.241068-1-parav@nvidia.com>
X-Mailer: git-send-email 2.26.2
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA4B:EE_|DS0PR12MB8070:EE_
X-MS-Office365-Filtering-Correlation-Id: 8d8b95db-4fab-494a-2a5f-08dc2fe38be3
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	oJONh0CJ2+tg5K3bgCamvxNVEOD/7hRXnowm0VVX27RCyikGSL5+ikaZacbP+ZNiaKMoRIeX6E2CLW+q4zuw7iOaC2jOLQLl6Fw90F6Il2EC6Taq7pYkoXqG0GQ/Sz2Zup3PXdX0uP3T0akIFdUFSgE9lvYxUgh/X1/173Tz/HBUduogGj4FgPd3iYGpX60Ra+eI/rivUlqd8E9JkN7Dc9qivS4ZAocKJwJuiR0cttNhMplT0kSCcLQvhCgq1/o+z0RsL4Hg9966TyZO3CqQlGGMTo4CBJmgvnR0PqiaNRkzldLCgsIfx+5D4WxAUJfpApGzPni6tOY0sub4UbxPVK/r20G/VFPkQkjYjNl2hCdL2AJA9BR4FvVevMKDF1rSsXwxAvP3Jkvfddk5uaJcCZ77oIj8mWbLds2vAkM9uO56KHJVpK7/j3mcVRTNdG9BW4WJiwI9SAlh19lzyyddOoL3hWgcyQloMmfXUQiPnQN2IsdkgOalzlOCIGsbWZkxrFa2SkHAYZV3Ue2Gmxp+6osn7isfLSVygkCMlFsp3ZscRufK+R34Ka7a0FY0s1FMd5z6wm24x+TsHSEaeHHYZWA4x3AI2BjXDeSbBderibJ8dRhKp9+cflmNDHTbJd03VzsS9/aIjWP+ir9SO3tvN9smCvAQH3c3K9RbyqnNbMmnphG63qtitTqrikz2XTPf/ZOxyWglr4Mq+ehf/3Xx+A==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(346002)(39860400002)(136003)(376002)(396003)(230922051799003)(36860700004)(64100799003)(1800799012)(451199024)(82310400011)(186009)(40470700004)(46966006)(86362001)(356005)(7636003)(966005)(82740400003)(2906002)(70206006)(5660300002)(8676002)(8936002)(4326008)(70586007)(316002)(6666004)(110136005)(54906003)(83380400001)(478600001)(26005)(41300700001)(2616005)(7416002)(36756003)(1076003)(336012)(107886003)(426003)(16526019);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Feb 2024 18:09:12.9363
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d8b95db-4fab-494a-2a5f-08dc2fe38be3
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002BA4B.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8070

When the PCI device is surprise removed, requests won't complete from
the device. These IOs are never completed and disk deletion hangs
indefinitely.

Fix it by aborting the IOs which the device will never complete
when the VQ is broken.

With this fix now fio completes swiftly.
An alternative of IO timeout has been considered, however
when the driver knows about unresponsive block device, swiftly clearing
them enables users and upper layers to react quickly.

Verified with multiple device unplug cycles with pending IOs in virtio
used ring and some pending with device.

In future instead of VQ broken, a more elegant method can be used. At the
moment the patch is kept to its minimal changes given its urgency to fix
broken kernels.

Fixes: 43bb40c5b926 ("virtio_pci: Support surprise removal of virtio pci device")
Cc: stable@vger.kernel.org
Reported-by: lirongqing@baidu.com
Closes: https://lore.kernel.org/virtualization/c45dd68698cd47238c55fb73ca9b4741@baidu.com/
Co-developed-by: Chaitanya Kulkarni <kch@nvidia.com>
Signed-off-by: Chaitanya Kulkarni <kch@nvidia.com>
Signed-off-by: Parav Pandit <parav@nvidia.com>
---
 drivers/block/virtio_blk.c | 54 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 54 insertions(+)

diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
index 2bf14a0e2815..59b49899b229 100644
--- a/drivers/block/virtio_blk.c
+++ b/drivers/block/virtio_blk.c
@@ -1562,10 +1562,64 @@ static int virtblk_probe(struct virtio_device *vdev)
 	return err;
 }
 
+static bool virtblk_cancel_request(struct request *rq, void *data)
+{
+	struct virtblk_req *vbr = blk_mq_rq_to_pdu(rq);
+
+	vbr->in_hdr.status = VIRTIO_BLK_S_IOERR;
+	if (blk_mq_request_started(rq) && !blk_mq_request_completed(rq))
+		blk_mq_complete_request(rq);
+
+	return true;
+}
+
+static void virtblk_cleanup_reqs(struct virtio_blk *vblk)
+{
+	struct virtio_blk_vq *blk_vq;
+	struct request_queue *q;
+	struct virtqueue *vq;
+	unsigned long flags;
+	int i;
+
+	vq = vblk->vqs[0].vq;
+	if (!virtqueue_is_broken(vq))
+		return;
+
+	q = vblk->disk->queue;
+	/* Block upper layer to not get any new requests */
+	blk_mq_quiesce_queue(q);
+
+	for (i = 0; i < vblk->num_vqs; i++) {
+		blk_vq = &vblk->vqs[i];
+
+		/* Synchronize with any ongoing virtblk_poll() which may be
+		 * completing the requests to uppper layer which has already
+		 * crossed the broken vq check.
+		 */
+		spin_lock_irqsave(&blk_vq->lock, flags);
+		spin_unlock_irqrestore(&blk_vq->lock, flags);
+	}
+
+	blk_sync_queue(q);
+
+	/* Complete remaining pending requests with error */
+	blk_mq_tagset_busy_iter(&vblk->tag_set, virtblk_cancel_request, vblk);
+	blk_mq_tagset_wait_completed_request(&vblk->tag_set);
+
+	/*
+	 * Unblock any pending dispatch I/Os before we destroy device. From
+	 * del_gendisk() -> __blk_mark_disk_dead(disk) will set GD_DEAD flag,
+	 * that will make sure any new I/O from bio_queue_enter() to fail.
+	 */
+	blk_mq_unquiesce_queue(q);
+}
+
 static void virtblk_remove(struct virtio_device *vdev)
 {
 	struct virtio_blk *vblk = vdev->priv;
 
+	virtblk_cleanup_reqs(vblk);
+
 	/* Make sure no work handler is accessing the device. */
 	flush_work(&vblk->config_work);
 
-- 
2.34.1

