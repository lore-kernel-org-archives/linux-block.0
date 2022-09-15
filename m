Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2A1AC6FA89
	for <linux-block@archiver.kernel.org>; Thu, 15 Sep 2022 16:49:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230095AbiIOQt0 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 15 Sep 2022 12:49:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229715AbiIOQs7 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 15 Sep 2022 12:48:59 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8DBC9DF93
        for <linux-block@vger.kernel.org>; Thu, 15 Sep 2022 09:48:50 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id t3so18917164ply.2
        for <linux-block@vger.kernel.org>; Thu, 15 Sep 2022 09:48:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=Ez356cXmd+P7nHsJjjr+e0UneH5b2Is7vVwjmIs0dPs=;
        b=hf5bm+zkYxj81k0yr271q/Vk7dx9PD258+F9SK/a1tGt7tNa+NuehKD3IiLyt97euU
         FtXSg24Apya78hp1GXFu5BbK+vkKNo1ymR0Rwg7K+y3rnIb3ONI2XzkuntNb07Nm+r9L
         GJij3Ake6waJf54qKgjqFZkAvVur99qaXQO6Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=Ez356cXmd+P7nHsJjjr+e0UneH5b2Is7vVwjmIs0dPs=;
        b=ivkbDJFddzso3nWIoU6kdv1Ad6NWFf7MnaZQZw232sUiKR0FKR1fYlSatkwvQQWDkm
         OetQWn5nBnp5b+W79hVOpmtcaEGVUhW6L0NurtG5fzUwM2DHIW6VPXbYpTfKFBJ1ffzA
         t4plGflXzM9DtQAeWU44vAfpeBjoMf9LiGblojldLxlD11+1jHt+Ko5xdQt9LY//IvZy
         4aCO/hq865VajNHFLLqzK3lkdH+HMb3/y5VJtZj5zZWQwzmd0fKx9ra+dfreVDmM2pGU
         eqvt4qrHvduFk0364SIhmgTiI2TINkgP5xF8rZfZQ2/EhkcupUkjmsoxG3+rBqjELYP3
         2tlA==
X-Gm-Message-State: ACrzQf2uu+NELxu35rgnk4dGXIWDma73SfOyHNK0a03PdURnUovOjbVX
        vAmGHeEa9eA6DVkSGeIrxkOTEj5LDG2vAA==
X-Google-Smtp-Source: AMsMyM6TOx0VvMscZBFt6MT5oz7OIxc3H7dIKcJ55IvOLIdBAuHhmlUHl0xBUb5jKhe4p8X37LYvkw==
X-Received: by 2002:a17:902:c106:b0:178:8cb:2762 with SMTP id 6-20020a170902c10600b0017808cb2762mr482863pli.58.1663260530537;
        Thu, 15 Sep 2022 09:48:50 -0700 (PDT)
Received: from sarthakkukreti-glaptop.hsd1.ca.comcast.net ([2601:647:4200:b5b0:3af2:34b2:a98a:a652])
        by smtp.gmail.com with ESMTPSA id o4-20020a170902bcc400b00177ee563b6dsm13174970pls.33.2022.09.15.09.48.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Sep 2022 09:48:49 -0700 (PDT)
From:   Sarthak Kukreti <sarthakkukreti@chromium.org>
X-Google-Original-From: Sarthak Kukreti <sarthakkukreti@google.com>
To:     dm-devel@redhat.com, linux-block@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org
Cc:     Jens Axboe <axboe@kernel.dk>,
        "Michael S . Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@kernel.org>,
        Theodore Ts'o <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Bart Van Assche <bvanassche@google.com>,
        Daniil Lunev <dlunev@google.com>,
        Evan Green <evgreen@google.com>,
        Gwendal Grignou <gwendal@google.com>,
        Sarthak Kukreti <sarthakkukreti@chromium.org>
Subject: [PATCH RFC 5/8] loop: Add support for provision requests
Date:   Thu, 15 Sep 2022 09:48:23 -0700
Message-Id: <20220915164826.1396245-6-sarthakkukreti@google.com>
X-Mailer: git-send-email 2.37.2.789.g6183377224-goog
In-Reply-To: <20220915164826.1396245-1-sarthakkukreti@google.com>
References: <20220915164826.1396245-1-sarthakkukreti@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Sarthak Kukreti <sarthakkukreti@chromium.org>

Add support for provision requests to loopback devices.
Loop devices will configure provision support based on
whether the underlying block device/file can support
the provision request and upon receiving a provision bio,
will map it to the backing device/storage.

Signed-off-by: Sarthak Kukreti <sarthakkukreti@chromium.org>
---
 drivers/block/loop.c | 42 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index ad92192c7d61..83f486b9bceb 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -327,6 +327,24 @@ static int lo_fallocate(struct loop_device *lo, struct request *rq, loff_t pos,
 	return ret;
 }
 
+static int lo_req_provision(struct loop_device *lo, struct request *rq, loff_t pos)
+{
+	struct file *file = lo->lo_backing_file;
+	struct request_queue *q = lo->lo_queue;
+	int ret;
+
+	if (!q->limits.max_provision_sectors) {
+		ret = -EOPNOTSUPP;
+		goto out;
+	}
+
+	ret = file->f_op->fallocate(file, FALLOC_FL_PROVISION, pos, blk_rq_bytes(rq));
+	if (unlikely(ret && ret != -EINVAL && ret != -EOPNOTSUPP))
+		ret = -EIO;
+ out:
+	return ret;
+}
+
 static int lo_req_flush(struct loop_device *lo, struct request *rq)
 {
 	int ret = vfs_fsync(lo->lo_backing_file, 0);
@@ -488,6 +506,8 @@ static int do_req_filebacked(struct loop_device *lo, struct request *rq)
 				FALLOC_FL_PUNCH_HOLE);
 	case REQ_OP_DISCARD:
 		return lo_fallocate(lo, rq, pos, FALLOC_FL_PUNCH_HOLE);
+	case REQ_OP_PROVISION:
+		return lo_req_provision(lo, rq, pos);
 	case REQ_OP_WRITE:
 		if (cmd->use_aio)
 			return lo_rw_aio(lo, cmd, pos, WRITE);
@@ -754,6 +774,25 @@ static void loop_sysfs_exit(struct loop_device *lo)
 				   &loop_attribute_group);
 }
 
+static void loop_config_provision(struct loop_device *lo)
+{
+	struct file *file = lo->lo_backing_file;
+	struct inode *inode = file->f_mapping->host;
+
+	/*
+	 * If the backing device is a block device, mirror its provisioning
+	 * capability.
+	 */
+	if (S_ISBLK(inode->i_mode)) {
+		blk_queue_max_provision_sectors(lo->lo_queue,
+			bdev_max_provision_sectors(I_BDEV(inode)));
+	} else if (file->f_op->fallocate) {
+		blk_queue_max_provision_sectors(lo->lo_queue, UINT_MAX >> 9);
+	} else {
+		blk_queue_max_provision_sectors(lo->lo_queue, 0);
+	}
+}
+
 static void loop_config_discard(struct loop_device *lo)
 {
 	struct file *file = lo->lo_backing_file;
@@ -1092,6 +1131,7 @@ static int loop_configure(struct loop_device *lo, fmode_t mode,
 	blk_queue_io_min(lo->lo_queue, bsize);
 
 	loop_config_discard(lo);
+	loop_config_provision(lo);
 	loop_update_rotational(lo);
 	loop_update_dio(lo);
 	loop_sysfs_init(lo);
@@ -1304,6 +1344,7 @@ loop_set_status(struct loop_device *lo, const struct loop_info64 *info)
 	}
 
 	loop_config_discard(lo);
+	loop_config_provision(lo);
 
 	/* update dio if lo_offset or transfer is changed */
 	__loop_update_dio(lo, lo->use_dio);
@@ -1815,6 +1856,7 @@ static blk_status_t loop_queue_rq(struct blk_mq_hw_ctx *hctx,
 	case REQ_OP_FLUSH:
 	case REQ_OP_DISCARD:
 	case REQ_OP_WRITE_ZEROES:
+	case REQ_OP_PROVISION:
 		cmd->use_aio = false;
 		break;
 	default:
-- 
2.31.0

