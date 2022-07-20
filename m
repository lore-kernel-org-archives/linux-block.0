Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35761C433EF
	for <linux-block@archiver.kernel.org>; Wed, 20 Jul 2022 11:26:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232084AbiGTL05 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 20 Jul 2022 07:26:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230405AbiGTL04 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 20 Jul 2022 07:26:56 -0400
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2067.outbound.protection.outlook.com [40.107.102.67])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 501EF25C5C
        for <linux-block@vger.kernel.org>; Wed, 20 Jul 2022 04:26:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z5poSkrMA1rKYpBzcCf48MYZk/NdVVfTYZXuHVG8JclzphPTCawNXCC4JJv3ZHg3sZEmUtg0fNRqpoVwJqT9nAfs43q3N+pZIU5zIkwHMnPi14nEnpnGn23ua9R9tHV0wf0fcd4ZWWoVHkk9GyFpetIuSzmpoGh+3CYITEhwo9N5JVL0yBrb80E9X4c4Rg1aq+g/eRbY+QrXO9AaQa56pZrXWhc+107LLUx6I0DrjL8Sl0KrRNHTqKnle9/snVLdiq7VoY3svTISb1VjBTTSTMLpvFiFmSZerzU6J3lh9kiaaGk8gvFISUdBVB3mjk3OgBQ7V1rTjCthvpDhkW4rTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JlA/Bj+84t/ERRpu8Jp6qN7Hy6FX27CPYijHigA4EZI=;
 b=guVOq2FFu+bmjY2g7SKRrYhe+6JpXi14C3pxcDrtjVUspLwQhlhVRueX34jVDuAXhw+G7lZ/YQranWeiJjD5y1soaaOSKCnuIWT6mQM7XHTPIS/SQvfJe/wDEWDrPYB6CSAiMNxtSfvhPCH+pI9BL9+//uK+cMDbRDyAncBJPMgk7srzcGgRkCU67kYqdSDtC6ITFoCc4RdOnjNLgBWc/E+/IYkbWnUiYejUErVc3WeKo+Syea0nYAAuyVoo0ShoDVa/r8GYoECdyLjhD8NBWlFrny2I4FWwJopDOHP8wzmXNK5l4LXzxbqWM1qi1ThFKblNGfyD8Otk0vD1AzwRSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.234) smtp.rcpttodomain=lst.de smtp.mailfrom=nvidia.com; dmarc=pass
 (p=reject sp=reject pct=100) action=none header.from=nvidia.com; dkim=none
 (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JlA/Bj+84t/ERRpu8Jp6qN7Hy6FX27CPYijHigA4EZI=;
 b=psicFAxwyJWhUaZdahZw9bcbX83cHaDDkgPXIjnorxh2RsC+DL6tk+ZCQ0cuNiiUm/u5gx5nwUE2x+WSlErndqAKJCZ+bSL8rB6VP3wWWmXtY8VOInpwxKl4k0FGDV9KuWb09gsqvAfchjfM4NuRzcSZcjRzghUqwwoESJudE9EGCRt86i0H/1eUwDh5NinGtRp71uVib4IITPLTF715M6Tnj37Aq29akFk4ySpnYlGekwMALULv5PhdkqiK8Czigg9yBlfTUbZdy0ZAHtgoApq87p+m77+VCfQ3Vk95TdQuuFibIM7wVqFy7lSVHnRofwssHU8rNf+B6NsJWnr/nA==
Received: from BN0PR02CA0017.namprd02.prod.outlook.com (2603:10b6:408:e4::22)
 by SA0PR12MB4397.namprd12.prod.outlook.com (2603:10b6:806:93::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.14; Wed, 20 Jul
 2022 11:26:51 +0000
Received: from BN8NAM11FT024.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e4:cafe::8b) by BN0PR02CA0017.outlook.office365.com
 (2603:10b6:408:e4::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.23 via Frontend
 Transport; Wed, 20 Jul 2022 11:26:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.234)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.234 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.234; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (12.22.5.234) by
 BN8NAM11FT024.mail.protection.outlook.com (10.13.177.38) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5458.17 via Frontend Transport; Wed, 20 Jul 2022 11:26:50 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by DRHQMAIL101.nvidia.com
 (10.27.9.10) with Microsoft SMTP Server (TLS) id 15.0.1497.32; Wed, 20 Jul
 2022 11:26:50 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.26; Wed, 20 Jul
 2022 04:26:49 -0700
Received: from rsws50.mtr.labs.mlnx (10.127.8.13) by mail.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server id 15.2.986.26 via Frontend
 Transport; Wed, 20 Jul 2022 04:26:47 -0700
From:   Israel Rukshin <israelr@nvidia.com>
To:     Linux-block <linux-block@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        Eric Biggers <ebiggers@kernel.org>
CC:     Israel Rukshin <israelr@nvidia.com>,
        Nitzan Carmi <nitzanc@nvidia.com>,
        Max Gurtovoy <mgurtovoy@nvidia.com>
Subject: [PATCH 1/1] block: Add support for setting inline encryption key per block device
Date:   Wed, 20 Jul 2022 14:26:31 +0300
Message-ID: <1658316391-13472-2-git-send-email-israelr@nvidia.com>
X-Mailer: git-send-email 1.8.4.3
In-Reply-To: <1658316391-13472-1-git-send-email-israelr@nvidia.com>
References: <1658316391-13472-1-git-send-email-israelr@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: aeb5a9da-08fc-4148-c933-08da6a42bddc
X-MS-TrafficTypeDiagnostic: SA0PR12MB4397:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: w1BAE+/7+2eUgxFNL9ey7is8EDhrnqH2u/FyedWXo/PTV9UTmDdeE6nfsbMHskeY37E98FiBpgPcDM3x9B3X72LE4JMxO7Fnd4Qivp2jPSlcVju5s/Ed/TDFFKIiP32z2FeH4pj2wZwYZM6tg3OoSOUCn4Zhd+HFpitlBwmkpAHBLc/emGbN24VC0aFuyb86bOVenJ8+qD+MVMV7D1nOJkojWVLNY3qWaDDPlZrwAiZOYKd5Yu+3YxplO1B1L0EkQiT8kjly/bF/e1bPWf81DBHBCs8AEI1vXcthljrgG56UQZKQM/jhEwacd4aRqe0pd55uXjQUYV1pGRlKYLqc/yZIzY1XF9VOMJBljPbMD3ycWgbg6E9sCGCVIOno4LgBb8V40irvHodJvO4lzYZqQRr6wkmF4D73aY1tCe7DZFG6A9pO9ixN6QSZFKHASYGzod1hrucQGYP1t7Ga7P4SC4avtMi2C0gM5/yN6YQ0BUQywla00xni+Tq5lG50kJH6TcnefNGXomxXyvdYwH05tkNzxskoRNwUTGsoVGw18SrM205QjsfR3QqlwHzJRVKKw1M0zQNgpdkAaO1Ma5c6i/rh8W1UTzXudHNK8mIiXTLsVfFw5bW4WDG2gYVsLu5xTlqj453e8Z3UAiIcUrh65dqZyk2VAT/z6DcgQuIeMM6nChFFWVLc5SYwhOjBcZtf3A7vPWnY0I1YCO6JcT0w8AHqWt86pAHsG1uf1S7274G0nl3uUAN1Twqusea8J2Y7Ym46J1chSmT2U31o7vmMCTt9agZuvSW4YiOfpiPbI1pExslyiX2j5ss1ioL6V5x4oF2D45+CddV+tixWKHZE2g==
X-Forefront-Antispam-Report: CIP:12.22.5.234;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(136003)(346002)(376002)(396003)(36840700001)(46966006)(40470700004)(81166007)(30864003)(5660300002)(41300700001)(54906003)(86362001)(70586007)(336012)(478600001)(6666004)(82740400003)(356005)(8676002)(316002)(110136005)(4326008)(70206006)(426003)(8936002)(47076005)(36860700001)(186003)(40460700003)(40480700001)(36756003)(82310400005)(107886003)(2616005)(26005)(2906002)(83380400001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2022 11:26:50.9127
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: aeb5a9da-08fc-4148-c933-08da6a42bddc
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.234];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT024.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4397
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Until now, using inline encryption key has been possible only at
filesystem level via fs-crypt. The patch allows to set a default
inline encryption key per block device. Once the key is set, all the
read commands will be decrypted, and all the write commands will
be encrypted. The key can be overridden by another key from a higher
level (FS/DM).

To add/remove a key, the patch introduces a block device ioctl:
 - BLKCRYPTOSETKEY: set a key with the following attributes:
    - crypto_mode: identifier for the encryption algorithm to use
    - raw_key_ptr:  pointer to a buffer of the raw key
    - raw_key_size: size in bytes of the raw key
    - data_unit_size: the data unit size to use for en/decryption
      (must be <= device logical block size)
To remove the key, use the same ioctl with raw_key_size = 0.
It is not possible to remove the key when it is in use by any
in-flight IO or when the block device is open.

Signed-off-by: Israel Rukshin <israelr@nvidia.com>
---
 block/blk-core.c                |   4 +
 block/blk-crypto-internal.h     |  19 +++-
 block/blk-crypto-profile.c      |   1 +
 block/blk-crypto.c              | 156 ++++++++++++++++++++++++++++++++
 block/blk-sysfs.c               |   7 ++
 block/ioctl.c                   |   3 +
 include/linux/blk-crypto.h      |  11 +--
 include/linux/blkdev.h          |   2 +
 include/uapi/linux/blk-crypto.h |  14 +++
 include/uapi/linux/fs.h         |   9 ++
 10 files changed, 217 insertions(+), 9 deletions(-)
 create mode 100644 include/uapi/linux/blk-crypto.h

diff --git a/block/blk-core.c b/block/blk-core.c
index 27fb1357ad4b..80fed8c794d7 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -474,6 +474,10 @@ struct request_queue *blk_alloc_queue(int node_id, bool alloc_srcu)
 				PERCPU_REF_INIT_ATOMIC, GFP_KERNEL))
 		goto fail_stats;
 
+#ifdef CONFIG_BLK_INLINE_ENCRYPTION
+	atomic_set(&q->blk_key_use_count, 0);
+#endif
+
 	blk_queue_dma_alignment(q, 511);
 	blk_set_default_limits(&q->limits);
 	q->nr_requests = BLKDEV_DEFAULT_RQ;
diff --git a/block/blk-crypto-internal.h b/block/blk-crypto-internal.h
index e6818ffaddbf..33a162697e53 100644
--- a/block/blk-crypto-internal.h
+++ b/block/blk-crypto-internal.h
@@ -65,6 +65,11 @@ static inline bool blk_crypto_rq_is_encrypted(struct request *rq)
 	return rq->crypt_ctx;
 }
 
+bool blk_crypto_bio_set_default_ctx(struct bio *bio);
+
+int blk_crypto_ioctl(struct block_device *bdev, fmode_t mode, unsigned int cmd,
+		     void __user *argp);
+
 #else /* CONFIG_BLK_INLINE_ENCRYPTION */
 
 static inline int blk_crypto_sysfs_register(struct request_queue *q)
@@ -105,6 +110,17 @@ static inline bool blk_crypto_rq_is_encrypted(struct request *rq)
 	return false;
 }
 
+static bool blk_crypto_bio_set_default_ctx(struct bio *bio)
+{
+	return false;
+}
+
+static inline int blk_crypto_ioctl(struct block_device *bdev, fmode_t mode,
+				   unsigned int cmd, void __user *argp)
+{
+	return -ENOTTY;
+}
+
 #endif /* CONFIG_BLK_INLINE_ENCRYPTION */
 
 void __bio_crypt_advance(struct bio *bio, unsigned int bytes);
@@ -134,7 +150,8 @@ static inline void bio_crypt_do_front_merge(struct request *rq,
 bool __blk_crypto_bio_prep(struct bio **bio_ptr);
 static inline bool blk_crypto_bio_prep(struct bio **bio_ptr)
 {
-	if (bio_has_crypt_ctx(*bio_ptr))
+	if (bio_has_crypt_ctx(*bio_ptr) ||
+	    blk_crypto_bio_set_default_ctx(*bio_ptr))
 		return __blk_crypto_bio_prep(bio_ptr);
 	return true;
 }
diff --git a/block/blk-crypto-profile.c b/block/blk-crypto-profile.c
index 96c511967386..4ca75520b466 100644
--- a/block/blk-crypto-profile.c
+++ b/block/blk-crypto-profile.c
@@ -459,6 +459,7 @@ bool blk_crypto_register(struct blk_crypto_profile *profile,
 		return false;
 	}
 	q->crypto_profile = profile;
+	q->blk_key = NULL;
 	return true;
 }
 EXPORT_SYMBOL_GPL(blk_crypto_register);
diff --git a/block/blk-crypto.c b/block/blk-crypto.c
index a496aaef85ba..39129d8b120f 100644
--- a/block/blk-crypto.c
+++ b/block/blk-crypto.c
@@ -98,20 +98,30 @@ void bio_crypt_set_ctx(struct bio *bio, const struct blk_crypto_key *key,
 	memcpy(bc->bc_dun, dun, sizeof(bc->bc_dun));
 
 	bio->bi_crypt_context = bc;
+	if (bc->bc_key->q)
+		atomic_inc(&bc->bc_key->q->blk_key_use_count);
 }
 
 void __bio_crypt_free_ctx(struct bio *bio)
 {
+	struct request_queue *q = bio->bi_crypt_context->bc_key->q;
+
+	if (q)
+		atomic_dec(&q->blk_key_use_count);
 	mempool_free(bio->bi_crypt_context, bio_crypt_ctx_pool);
 	bio->bi_crypt_context = NULL;
 }
 
 int __bio_crypt_clone(struct bio *dst, struct bio *src, gfp_t gfp_mask)
 {
+	struct request_queue *q = src->bi_crypt_context->bc_key->q;
+
 	dst->bi_crypt_context = mempool_alloc(bio_crypt_ctx_pool, gfp_mask);
 	if (!dst->bi_crypt_context)
 		return -ENOMEM;
 	*dst->bi_crypt_context = *src->bi_crypt_context;
+	if (q)
+		atomic_inc(&q->blk_key_use_count);
 	return 0;
 }
 
@@ -413,3 +423,149 @@ int blk_crypto_evict_key(struct request_queue *q,
 	return blk_crypto_fallback_evict_key(key);
 }
 EXPORT_SYMBOL_GPL(blk_crypto_evict_key);
+
+bool blk_crypto_bio_set_default_ctx(struct bio *bio)
+{
+	struct request_queue *q = bdev_get_queue(bio->bi_bdev);
+	u64 dun[BLK_CRYPTO_DUN_ARRAY_SIZE];
+
+	if (!q->blk_key)
+		return false;
+
+	if (bio_op(bio) != REQ_OP_READ && bio_op(bio) != REQ_OP_WRITE)
+		return false;
+
+	if (!bio_sectors(bio))
+		return false;
+
+	memset(dun, 0, BLK_CRYPTO_MAX_IV_SIZE);
+	dun[0] = bio->bi_iter.bi_sector >>
+			(q->blk_key->data_unit_size_bits - SECTOR_SHIFT);
+	bio_crypt_set_ctx(bio, q->blk_key, dun, GFP_KERNEL);
+
+	return true;
+}
+
+static int blk_crypto_destroy_default_key(struct request_queue *q)
+{
+	int ret;
+
+	if (!q->blk_key)
+		return 0;
+
+	blk_mq_freeze_queue(q);
+	blk_mq_quiesce_queue(q);
+	if (atomic_read(&q->blk_key_use_count)) {
+		ret = -EBUSY;
+	} else {
+		ret = blk_crypto_evict_key(q, q->blk_key);
+		if (!ret) {
+			kfree_sensitive(q->blk_key);
+			q->blk_key = NULL;
+		}
+	}
+	blk_mq_unquiesce_queue(q);
+	blk_mq_unfreeze_queue(q);
+
+	return ret;
+}
+
+static int blk_crypto_ioctl_create_key(struct request_queue *q,
+				       void __user *argp)
+{
+	struct blk_crypto_set_key_arg arg;
+	u8 raw_key[BLK_CRYPTO_MAX_KEY_SIZE];
+	struct blk_crypto_key *blk_key;
+	int ret;
+
+	if (copy_from_user(&arg, argp, sizeof(arg)))
+		return -EFAULT;
+
+	if (memchr_inv(arg.reserved, 0, sizeof(arg.reserved)))
+		return -EINVAL;
+
+	if (!arg.raw_key_size)
+		return blk_crypto_destroy_default_key(q);
+
+	if (q->blk_key) {
+		pr_err("Crypto key is already configured\n");
+		return -EBUSY;
+	}
+
+	if (arg.raw_key_size > sizeof(raw_key))
+		return -EINVAL;
+
+	if (arg.data_unit_size > queue_logical_block_size(q)) {
+		pr_err("Data unit size is bigger than logical block size\n");
+		return -EINVAL;
+	}
+
+	if (copy_from_user(raw_key, u64_to_user_ptr(arg.raw_key_ptr),
+			   arg.raw_key_size)) {
+		ret = -EFAULT;
+		goto err;
+	}
+
+	blk_key = kzalloc(sizeof(*blk_key), GFP_KERNEL);
+	if (!blk_key) {
+		ret = -ENOMEM;
+		goto err;
+	}
+
+	ret = blk_crypto_init_key(blk_key, raw_key, arg.crypto_mode,
+				  sizeof(u64), arg.data_unit_size);
+	if (ret) {
+		pr_err("Failed to init inline encryption key\n");
+		goto key_err;
+	}
+
+	/* Block key size is taken from crypto mode */
+	if (arg.raw_key_size != blk_key->size) {
+		ret = -EINVAL;
+		goto key_err;
+	}
+
+	ret = blk_crypto_start_using_key(blk_key, q);
+	if (ret) {
+		pr_err("Failed to use inline encryption key\n");
+		goto key_err;
+	}
+	blk_key->q = q;
+	q->blk_key = blk_key;
+
+	memzero_explicit(raw_key, sizeof(raw_key));
+
+	return 0;
+
+key_err:
+	kfree_sensitive(blk_key);
+err:
+	memzero_explicit(raw_key, sizeof(raw_key));
+	return ret;
+}
+
+int blk_crypto_ioctl(struct block_device *bdev, fmode_t mode, unsigned int cmd,
+		     void __user *argp)
+{
+	struct request_queue *q = bdev_get_queue(bdev);
+	int ret;
+
+	if (!q->crypto_profile)
+		return -EOPNOTSUPP;
+
+	switch (cmd) {
+	case BLKCRYPTOSETKEY:
+		if (mode & FMODE_EXCL)
+			return blk_crypto_ioctl_create_key(q, argp);
+
+		if (IS_ERR(blkdev_get_by_dev(bdev->bd_dev, mode | FMODE_EXCL,
+					     &bdev)))
+			return -EBUSY;
+		ret = blk_crypto_ioctl_create_key(q, argp);
+		blkdev_put(bdev, mode | FMODE_EXCL);
+
+		return ret;
+	default:
+		return -ENOTTY;
+	}
+}
diff --git a/block/blk-sysfs.c b/block/blk-sysfs.c
index 9b905e9443e4..2d28b17393db 100644
--- a/block/blk-sysfs.c
+++ b/block/blk-sysfs.c
@@ -765,6 +765,13 @@ static void blk_release_queue(struct kobject *kobj)
 
 	might_sleep();
 
+#ifdef CONFIG_BLK_INLINE_ENCRYPTION
+	if (q->blk_key) {
+		blk_crypto_evict_key(q, q->blk_key);
+		kfree_sensitive(q->blk_key);
+	}
+#endif
+
 	percpu_ref_exit(&q->q_usage_counter);
 
 	if (q->poll_stat)
diff --git a/block/ioctl.c b/block/ioctl.c
index 46949f1b0dba..b5358819de6a 100644
--- a/block/ioctl.c
+++ b/block/ioctl.c
@@ -12,6 +12,7 @@
 #include <linux/pr.h>
 #include <linux/uaccess.h>
 #include "blk.h"
+#include "blk-crypto-internal.h"
 
 static int blkpg_do_ioctl(struct block_device *bdev,
 			  struct blkpg_partition __user *upart, int op)
@@ -532,6 +533,8 @@ static int blkdev_common_ioctl(struct block_device *bdev, fmode_t mode,
 	case BLKTRACESTOP:
 	case BLKTRACETEARDOWN:
 		return blk_trace_ioctl(bdev, cmd, argp);
+	case BLKCRYPTOSETKEY:
+		return blk_crypto_ioctl(bdev, mode, cmd, argp);
 	case IOC_PR_REGISTER:
 		return blkdev_pr_register(bdev, argp);
 	case IOC_PR_RESERVE:
diff --git a/include/linux/blk-crypto.h b/include/linux/blk-crypto.h
index 69b24fe92cbf..cea421c9374f 100644
--- a/include/linux/blk-crypto.h
+++ b/include/linux/blk-crypto.h
@@ -7,14 +7,7 @@
 #define __LINUX_BLK_CRYPTO_H
 
 #include <linux/types.h>
-
-enum blk_crypto_mode_num {
-	BLK_ENCRYPTION_MODE_INVALID,
-	BLK_ENCRYPTION_MODE_AES_256_XTS,
-	BLK_ENCRYPTION_MODE_AES_128_CBC_ESSIV,
-	BLK_ENCRYPTION_MODE_ADIANTUM,
-	BLK_ENCRYPTION_MODE_MAX,
-};
+#include <uapi/linux/blk-crypto.h>
 
 #define BLK_CRYPTO_MAX_KEY_SIZE		64
 /**
@@ -39,6 +32,7 @@ struct blk_crypto_config {
  * @data_unit_size_bits: log2 of data_unit_size
  * @size: size of this key in bytes (determined by @crypto_cfg.crypto_mode)
  * @raw: the raw bytes of this key.  Only the first @size bytes are used.
+ * @q: if set, this key is used as a default key for this queue.
  *
  * A blk_crypto_key is immutable once created, and many bios can reference it at
  * the same time.  It must not be freed until all bios using it have completed
@@ -49,6 +43,7 @@ struct blk_crypto_key {
 	unsigned int data_unit_size_bits;
 	unsigned int size;
 	u8 raw[BLK_CRYPTO_MAX_KEY_SIZE];
+	struct request_queue *q;
 };
 
 #define BLK_CRYPTO_MAX_IV_SIZE		32
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index dd552479a15c..b45b13ea2f7d 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -429,6 +429,8 @@ struct request_queue {
 #ifdef CONFIG_BLK_INLINE_ENCRYPTION
 	struct blk_crypto_profile *crypto_profile;
 	struct kobject *crypto_kobject;
+	struct blk_crypto_key *blk_key;
+	atomic_t blk_key_use_count;
 #endif
 
 	unsigned int		rq_timeout;
diff --git a/include/uapi/linux/blk-crypto.h b/include/uapi/linux/blk-crypto.h
new file mode 100644
index 000000000000..5a65ebaf6038
--- /dev/null
+++ b/include/uapi/linux/blk-crypto.h
@@ -0,0 +1,14 @@
+/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
+
+#ifndef __UAPI_LINUX_BLK_CRYPTO_H
+#define __UAPI_LINUX_BLK_CRYPTO_H
+
+enum blk_crypto_mode_num {
+	BLK_ENCRYPTION_MODE_INVALID,
+	BLK_ENCRYPTION_MODE_AES_256_XTS,
+	BLK_ENCRYPTION_MODE_AES_128_CBC_ESSIV,
+	BLK_ENCRYPTION_MODE_ADIANTUM,
+	BLK_ENCRYPTION_MODE_MAX,
+};
+
+#endif /* __UAPI_LINUX_BLK_CRYPTO_H */
diff --git a/include/uapi/linux/fs.h b/include/uapi/linux/fs.h
index bdf7b404b3e7..398a77895e96 100644
--- a/include/uapi/linux/fs.h
+++ b/include/uapi/linux/fs.h
@@ -121,6 +121,14 @@ struct fsxattr {
 	unsigned char	fsx_pad[8];
 };
 
+struct blk_crypto_set_key_arg {
+	__u32 crypto_mode;
+	__u64 raw_key_ptr;
+	__u32 raw_key_size;
+	__u32 data_unit_size;
+	__u32 reserved[9];	/* must be zero */
+};
+
 /*
  * Flags for the fsx_xflags field
  */
@@ -185,6 +193,7 @@ struct fsxattr {
 #define BLKROTATIONAL _IO(0x12,126)
 #define BLKZEROOUT _IO(0x12,127)
 #define BLKGETDISKSEQ _IOR(0x12,128,__u64)
+#define BLKCRYPTOSETKEY _IOW(0x12, 129, struct blk_crypto_set_key_arg)
 /*
  * A jump here: 130-136 are reserved for zoned block devices
  * (see uapi/linux/blkzoned.h)
-- 
2.18.2

