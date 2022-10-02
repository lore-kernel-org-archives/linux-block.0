Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CAC7C433FE
	for <linux-block@archiver.kernel.org>; Sun,  2 Oct 2022 15:44:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229805AbiJBPo0 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 2 Oct 2022 11:44:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229923AbiJBPoZ (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Sun, 2 Oct 2022 11:44:25 -0400
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1anam02on2070.outbound.protection.outlook.com [40.107.96.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19A023FEDE
        for <linux-block@vger.kernel.org>; Sun,  2 Oct 2022 08:44:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=agAdc7R0136ys8AHWrC6RoDorM8EkU8W7utOFBTJWlNEFpC1/5UaxzOrW4WcgQnqx8IXyS1MYQO15TZMiM3lFR1msjT/UQr5QB+MkMnxWTzG/hH/aEdQ7cNOB89QuQ0vUpVexXKvrJK2H7+a/kiM4+LjkUcyWwVrY3c1P6WPXbAHIWT70Esr0QF8CACs6r24jKVrHzH1aza+07XQDWmWXpmtJmzKsf/9ZqgcgjBQbbbRWGls6+Az6is6cSLtHeD9tMmXQYq/7LRUnoG8U4no7MUmRL/OzvAvTS+nPMZDrrMqyz+34mhiCmew4b3nCeiGyx+adUPvYTcDqxX9B8hI0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2LDbdCwrGA8Pxfi3f4NZZxM6U8Hm4GyxY/qEc+oBkX8=;
 b=jK4Pd38T4EYyticrzr0g1T5r/X2egCc8Wx9WRsmNcRzn1g09/eyBWVG7tH815mm3pXBn20Bf8x+XsdP6KKE3VuePiG1zrK459dz8P0yl/h/YXLFoyggdPILGaZIouJYBaYgCFH8eTPjpdjvdehdip4dSNMy/uy9Mhc7OkGnqrlfDAwid5rc0xSPY8QAoJtRLP1Kwcgaat6WobZCA4D4Hb5XIIh09BDPwwywTDnD4DNxyDU+XMiO2OqQ9JQ4SUaRE9WhdQSWxCrpyOYEZrnhdT+dZG5qTRJscRAYeLDXk3v0fLEe58cYPOwDwDcRtOvRHSnRNPYxctZpWxMcXYII/FA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2LDbdCwrGA8Pxfi3f4NZZxM6U8Hm4GyxY/qEc+oBkX8=;
 b=BY+mNi2RNJHJm/bJgmm5z0C7EZvepnvo+2L2mN+oeIazA9dRKSGL9oQkfHsBBRKJjoTh7o4mrmnx5pzdX4pzt8RDTk4jr6+jUoE1ADx2rnItOif7/2PKbl0+tpGhxCze87+COBxd3d5yXxOUKyu4Duj4wLe/zalsl2paZjLeq99Q1YCVFbh6RzvJbfvzreY1hseWZcCC1lRs+NttQiixEM0bjWc0fPCYrRtGPYNVKcB7/iWCtKIrDii/XVKD2dzwZQfcRxjc0KuGH1Vk2JWSWmmWEmBGeCSw0OaLV76QsPeuaE2ZS15jFjfCqVkJF7Tb9xc8X/eMZfMqVW38vLI21g==
Received: from BN9PR03CA0931.namprd03.prod.outlook.com (2603:10b6:408:108::6)
 by DM4PR12MB5914.namprd12.prod.outlook.com (2603:10b6:8:67::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.28; Sun, 2 Oct
 2022 15:44:22 +0000
Received: from BN8NAM11FT041.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:108:cafe::d3) by BN9PR03CA0931.outlook.office365.com
 (2603:10b6:408:108::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.24 via Frontend
 Transport; Sun, 2 Oct 2022 15:44:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN8NAM11FT041.mail.protection.outlook.com (10.13.177.18) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5676.17 via Frontend Transport; Sun, 2 Oct 2022 15:44:21 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.26; Sun, 2 Oct 2022
 08:44:20 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Sun, 2 Oct 2022
 08:44:20 -0700
Received: from r-arch-stor03.mtr.labs.mlnx (10.127.8.14) by mail.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server id 15.2.986.29 via Frontend
 Transport; Sun, 2 Oct 2022 08:44:18 -0700
From:   Max Gurtovoy <mgurtovoy@nvidia.com>
To:     <mst@redhat.com>, <stefanha@redhat.com>, <jasowang@redhat.com>,
        <virtualization@lists.linux-foundation.org>
CC:     <linux-block@vger.kernel.org>, <Johannes.Thumshirn@wdc.com>,
        Max Gurtovoy <mgurtovoy@nvidia.com>
Subject: [PATCH 1/1] virtio-blk: simplify probe function
Date:   Sun, 2 Oct 2022 18:44:17 +0300
Message-ID: <20221002154417.34583-1-mgurtovoy@nvidia.com>
X-Mailer: git-send-email 2.18.1
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT041:EE_|DM4PR12MB5914:EE_
X-MS-Office365-Filtering-Correlation-Id: 3a57cb3f-5510-40b2-9e1c-08daa48cf9ef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qtkVOUuQDGl4yTsIa8fyur4W5DLuaN1BseTp5FkfrAPSixq7Mwj72YTMC/vQZpfIxw9MIJQkFeQBapUEwg4kxceWR7BCgTGdr9Tqa6kKaE/usC21DnIu1pEnUnCuVw6Xfpezmf/8m4c2hOCfwHdZ4ZexbiOoVNsGtNGnwFjzfeuSSxpijESgFiazvLvBipRxK7+VbMCqGWjW3oy6IAWlDnBWbuubGE0K3zlJQX65QWkRC98prvJZy6Ri8D+xb8T7YbqW5+/8Qebfk8FT+7Xsaneq4MRlU/azMiFKORxx72mzMNez1mwX0Gub8k1y8iCwVSr2FkV+LnFBddLbQV0qq86qOH5MkewLflFQ/Rd7sbbVg3dv4qwaOfCfVApJZEEE+is0HR7xYoZTyApVCt6HU5F99gQ+MKOkg6Xv8OoVlgZ4s3OITNCIy+iP6n9luTnzq8w0Br5VWhffTLdbEQBXnjllbLI1qhmnDhKuqgLm6qqphHxvLOurSVfllVMETr4aupP42qktIWNlrDNH/A84CAmpDd1B85EVwklYhOaPe5tGnLpafqPP7a7sBvHyH9jhh4VAP4WMIKViivuxgBRfakpdanhIzlLAWhiPbpH3538xdULbyq6/BzOi2Jxc2zuW0pU8VhfaHvECW6/C2/oh2v+4Uy4vGrDKOa0nYf6a7J3pSChNn1RH/oAYPvBChfj6YACHHlEvRi7DP6dZunTOt9X0uHIDKDziRJIf7A7bVxeGf1dJuV2XJj4HRew0GzDNCG+qBBJrk+AWNK+rVcX9gA==
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230022)(4636009)(136003)(396003)(376002)(39860400002)(346002)(451199015)(40470700004)(36840700001)(46966006)(82310400005)(7636003)(110136005)(356005)(82740400003)(478600001)(316002)(54906003)(70586007)(70206006)(8676002)(4326008)(186003)(1076003)(41300700001)(107886003)(36756003)(26005)(86362001)(5660300002)(40480700001)(8936002)(426003)(47076005)(40460700003)(2616005)(336012)(2906002)(36860700001)(83380400001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2022 15:44:21.9922
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a57cb3f-5510-40b2-9e1c-08daa48cf9ef
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT041.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5914
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Divide the extremely long probe function to small meaningful functions.
This makes the code more readably and easy to maintain.

Signed-off-by: Max Gurtovoy <mgurtovoy@nvidia.com>
---
 drivers/block/virtio_blk.c | 227 +++++++++++++++++++++----------------
 1 file changed, 131 insertions(+), 96 deletions(-)

diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
index 30255fcaf181..bdd44069bf6f 100644
--- a/drivers/block/virtio_blk.c
+++ b/drivers/block/virtio_blk.c
@@ -882,28 +882,13 @@ static const struct blk_mq_ops virtio_mq_ops = {
 static unsigned int virtblk_queue_depth;
 module_param_named(queue_depth, virtblk_queue_depth, uint, 0444);
 
-static int virtblk_probe(struct virtio_device *vdev)
+static int virtblk_q_limits_set(struct virtio_device *vdev,
+		struct request_queue *q)
 {
-	struct virtio_blk *vblk;
-	struct request_queue *q;
-	int err, index;
-
-	u32 v, blk_size, max_size, sg_elems, opt_io_size;
-	u16 min_io_size;
 	u8 physical_block_exp, alignment_offset;
-	unsigned int queue_depth;
-
-	if (!vdev->config->get) {
-		dev_err(&vdev->dev, "%s failure: config access disabled\n",
-			__func__);
-		return -EINVAL;
-	}
-
-	err = ida_simple_get(&vd_index_ida, 0, minor_to_index(1 << MINORBITS),
-			     GFP_KERNEL);
-	if (err < 0)
-		goto out;
-	index = err;
+	u16 min_io_size;
+	u32 v, blk_size, max_size, sg_elems, opt_io_size;
+	int err;
 
 	/* We need to know how many segments before we allocate. */
 	err = virtio_cread_feature(vdev, VIRTIO_BLK_F_SEG_MAX,
@@ -917,73 +902,6 @@ static int virtblk_probe(struct virtio_device *vdev)
 	/* Prevent integer overflows and honor max vq size */
 	sg_elems = min_t(u32, sg_elems, VIRTIO_BLK_MAX_SG_ELEMS - 2);
 
-	vdev->priv = vblk = kmalloc(sizeof(*vblk), GFP_KERNEL);
-	if (!vblk) {
-		err = -ENOMEM;
-		goto out_free_index;
-	}
-
-	mutex_init(&vblk->vdev_mutex);
-
-	vblk->vdev = vdev;
-
-	INIT_WORK(&vblk->config_work, virtblk_config_changed_work);
-
-	err = init_vq(vblk);
-	if (err)
-		goto out_free_vblk;
-
-	/* Default queue sizing is to fill the ring. */
-	if (!virtblk_queue_depth) {
-		queue_depth = vblk->vqs[0].vq->num_free;
-		/* ... but without indirect descs, we use 2 descs per req */
-		if (!virtio_has_feature(vdev, VIRTIO_RING_F_INDIRECT_DESC))
-			queue_depth /= 2;
-	} else {
-		queue_depth = virtblk_queue_depth;
-	}
-
-	memset(&vblk->tag_set, 0, sizeof(vblk->tag_set));
-	vblk->tag_set.ops = &virtio_mq_ops;
-	vblk->tag_set.queue_depth = queue_depth;
-	vblk->tag_set.numa_node = NUMA_NO_NODE;
-	vblk->tag_set.flags = BLK_MQ_F_SHOULD_MERGE;
-	vblk->tag_set.cmd_size =
-		sizeof(struct virtblk_req) +
-		sizeof(struct scatterlist) * VIRTIO_BLK_INLINE_SG_CNT;
-	vblk->tag_set.driver_data = vblk;
-	vblk->tag_set.nr_hw_queues = vblk->num_vqs;
-	vblk->tag_set.nr_maps = 1;
-	if (vblk->io_queues[HCTX_TYPE_POLL])
-		vblk->tag_set.nr_maps = 3;
-
-	err = blk_mq_alloc_tag_set(&vblk->tag_set);
-	if (err)
-		goto out_free_vq;
-
-	vblk->disk = blk_mq_alloc_disk(&vblk->tag_set, vblk);
-	if (IS_ERR(vblk->disk)) {
-		err = PTR_ERR(vblk->disk);
-		goto out_free_tags;
-	}
-	q = vblk->disk->queue;
-
-	virtblk_name_format("vd", index, vblk->disk->disk_name, DISK_NAME_LEN);
-
-	vblk->disk->major = major;
-	vblk->disk->first_minor = index_to_minor(index);
-	vblk->disk->minors = 1 << PART_BITS;
-	vblk->disk->private_data = vblk;
-	vblk->disk->fops = &virtblk_fops;
-	vblk->index = index;
-
-	/* configure queue flush support */
-	virtblk_update_cache_mode(vdev);
-
-	/* If disk is read-only in the host, the guest should obey */
-	if (virtio_has_feature(vdev, VIRTIO_BLK_F_RO))
-		set_disk_ro(vblk->disk, 1);
-
 	/* We can handle whatever the host told us to handle. */
 	blk_queue_max_segments(q, sg_elems);
 
@@ -1011,12 +929,13 @@ static int virtblk_probe(struct virtio_device *vdev)
 			dev_err(&vdev->dev,
 				"virtio_blk: invalid block size: 0x%x\n",
 				blk_size);
-			goto out_cleanup_disk;
+			return err;
 		}
 
 		blk_queue_logical_block_size(q, blk_size);
-	} else
+	} else {
 		blk_size = queue_logical_block_size(q);
+	}
 
 	/* Use topology information if available */
 	err = virtio_cread_feature(vdev, VIRTIO_BLK_F_TOPOLOGY,
@@ -1075,19 +994,136 @@ static int virtblk_probe(struct virtio_device *vdev)
 		blk_queue_max_write_zeroes_sectors(q, v ? v : UINT_MAX);
 	}
 
+	return 0;
+}
+
+static void virtblk_tagset_put(struct virtio_blk *vblk)
+{
+	put_disk(vblk->disk);
+	blk_mq_free_tag_set(&vblk->tag_set);
+}
+
+static void virtblk_tagset_free(struct virtio_blk *vblk)
+{
+	del_gendisk(vblk->disk);
+	blk_mq_free_tag_set(&vblk->tag_set);
+}
+
+static int virtblk_tagset_alloc(struct virtio_blk *vblk,
+		unsigned int queue_depth)
+{
+	int err;
+
+	memset(&vblk->tag_set, 0, sizeof(vblk->tag_set));
+	vblk->tag_set.ops = &virtio_mq_ops;
+	vblk->tag_set.queue_depth = queue_depth;
+	vblk->tag_set.numa_node = NUMA_NO_NODE;
+	vblk->tag_set.flags = BLK_MQ_F_SHOULD_MERGE;
+	vblk->tag_set.cmd_size =
+		sizeof(struct virtblk_req) +
+		sizeof(struct scatterlist) * VIRTIO_BLK_INLINE_SG_CNT;
+	vblk->tag_set.driver_data = vblk;
+	vblk->tag_set.nr_hw_queues = vblk->num_vqs;
+	vblk->tag_set.nr_maps = 1;
+	if (vblk->io_queues[HCTX_TYPE_POLL])
+		vblk->tag_set.nr_maps = 3;
+
+	err = blk_mq_alloc_tag_set(&vblk->tag_set);
+	if (err)
+		return err;
+
+	vblk->disk = blk_mq_alloc_disk(&vblk->tag_set, vblk);
+	if (IS_ERR(vblk->disk)) {
+		err = PTR_ERR(vblk->disk);
+		goto out_free_tags;
+	}
+
+	return 0;
+
+out_free_tags:
+	blk_mq_free_tag_set(&vblk->tag_set);
+	return err;
+}
+
+static int virtblk_probe(struct virtio_device *vdev)
+{
+	struct virtio_blk *vblk;
+	int err, index;
+	unsigned int queue_depth;
+
+	if (!vdev->config->get) {
+		dev_err(&vdev->dev, "%s failure: config access disabled\n",
+			__func__);
+		return -EINVAL;
+	}
+
+	err = ida_simple_get(&vd_index_ida, 0, minor_to_index(1 << MINORBITS),
+			     GFP_KERNEL);
+	if (err < 0)
+		goto out;
+	index = err;
+
+	vdev->priv = vblk = kmalloc(sizeof(*vblk), GFP_KERNEL);
+	if (!vblk) {
+		err = -ENOMEM;
+		goto out_free_index;
+	}
+
+	mutex_init(&vblk->vdev_mutex);
+
+	vblk->vdev = vdev;
+
+	INIT_WORK(&vblk->config_work, virtblk_config_changed_work);
+
+	err = init_vq(vblk);
+	if (err)
+		goto out_free_vblk;
+
+	/* Default queue sizing is to fill the ring. */
+	if (!virtblk_queue_depth) {
+		queue_depth = vblk->vqs[0].vq->num_free;
+		/* ... but without indirect descs, we use 2 descs per req */
+		if (!virtio_has_feature(vdev, VIRTIO_RING_F_INDIRECT_DESC))
+			queue_depth /= 2;
+	} else {
+		queue_depth = virtblk_queue_depth;
+	}
+
+	err = virtblk_tagset_alloc(vblk, queue_depth);
+	if (err)
+		goto out_free_vq;
+
+	virtblk_name_format("vd", index, vblk->disk->disk_name, DISK_NAME_LEN);
+
+	vblk->disk->major = major;
+	vblk->disk->first_minor = index_to_minor(index);
+	vblk->disk->minors = 1 << PART_BITS;
+	vblk->disk->private_data = vblk;
+	vblk->disk->fops = &virtblk_fops;
+	vblk->index = index;
+
+	/* configure queue flush support */
+	virtblk_update_cache_mode(vdev);
+
+	/* If disk is read-only in the host, the guest should obey */
+	if (virtio_has_feature(vdev, VIRTIO_BLK_F_RO))
+		set_disk_ro(vblk->disk, 1);
+
+	err = virtblk_q_limits_set(vdev, vblk->disk->queue);
+	if (err)
+		goto out_tagset_put;
+
 	virtblk_update_capacity(vblk, false);
 	virtio_device_ready(vdev);
 
 	err = device_add_disk(&vdev->dev, vblk->disk, virtblk_attr_groups);
 	if (err)
-		goto out_cleanup_disk;
+		goto out_tagset_put;
 
 	return 0;
 
-out_cleanup_disk:
-	put_disk(vblk->disk);
-out_free_tags:
-	blk_mq_free_tag_set(&vblk->tag_set);
+out_tagset_put:
+	virtblk_tagset_put(vblk);
 out_free_vq:
 	vdev->config->del_vqs(vdev);
 	kfree(vblk->vqs);
@@ -1106,8 +1142,7 @@ static void virtblk_remove(struct virtio_device *vdev)
 	/* Make sure no work handler is accessing the device. */
 	flush_work(&vblk->config_work);
 
-	del_gendisk(vblk->disk);
-	blk_mq_free_tag_set(&vblk->tag_set);
+	virtblk_tagset_free(vblk);
 
 	mutex_lock(&vblk->vdev_mutex);
 
-- 
2.18.1

