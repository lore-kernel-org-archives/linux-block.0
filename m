Received: from mail-oo1-f99.google.com (mail-oo1-f99.google.com [209.85.161.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54CB48BE0
	for <linux-block@vger.kernel.org>; Tue, 30 Apr 2024 00:54:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714438463; cv=none; b=G4bhF3N0VavTCTUQNTiZrZPZWElSQgZ/N+ZoofPQL1wKucrZv5c5LTeR54MmBk51nwSYxMOJ71+wptOyavmF8e+K8xYa4wKShqSXQs9WogAOYtjObJUi78q6/AErkHlMgOSRgWFQcMnVIpJ6cC64Z0vOvKLFUKQ1TtkEPCKYiUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714438463; c=relaxed/simple;
	bh=gHjS5j499KUfihSIPncWgtmTpJD/R+99zGofVTdSp3k=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=rfq6sWxBhd8TwGa9+orKWWoC5Iic6s1+9UiiRbaswSAzb/JaZAnBKaQnGd8TmqhxEQeRgPD86upS93e/ebMaJGOPFbV4/O46w5K/hwBm3fYmkAaBIsK7M81yH3L2+DHGZiekU22BDP1vSfKq6GmKjkeIyLnG9L82lC6hsNw5s0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=W+LoHLE/; arc=none smtp.client-ip=209.85.161.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="W+LoHLE/"
Received: by mail-oo1-f99.google.com with SMTP id 006d021491bc7-5aa1bf6cb40so3648921eaf.1
        for <linux-block@vger.kernel.org>; Mon, 29 Apr 2024 17:54:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1714438460; x=1715043260; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=GnMzNtVbcN/rwD2dIP7344DOsid1NzlW4hL3MUPHDgc=;
        b=W+LoHLE/1CvqawbMoZYvQRP+DbLcHza5Kg8b2J/0GdKmqdw6CWMalyojYzr0MqIr4T
         iJA0sen7m35+CFGg0NpO56Q4lDoUEBSw7AHQ7aY4n2n65CIcXsoh4ZRecwcW3XBrWQuF
         XeULhXK6iEd87eLkgWARewgeu9jZD2W+RIYrKwWqJD/44AIUj1t0lrIcxXXiXWqHMLkG
         qBUj/i+ynvHdjNor3SrD7L3lh2L+74o32gDNl6Nbb+ZT56oOmxJ8wgqOuYQwj54zokFl
         hOmVrN68wJ+hXm41JnMJf9bUM3wvShAacgh5Oy5i73pnfeCaDF3A9Ti1uZFRST4uSIyv
         JXfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714438460; x=1715043260;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GnMzNtVbcN/rwD2dIP7344DOsid1NzlW4hL3MUPHDgc=;
        b=EhICu/B1BCast38NuS7vA2ZbAFT0Ipu9ws/kQd/LSclswdtwM4ro0YYXuIzjx8Dg4U
         hZmtoqCUrS93wIsW08zGO3xT3CWR+PZFtdfv/mbwaYhTiLmNrmxwLudEZ45xAFBBH2lv
         MoAhzjbWBcD7it7mQNO8O+YFhwNZ4g5oqwi2X7iVinAfNCLQjGuF9jT30u5TGnqGib8v
         Mj1Gk2RloqgDJo2T4xGZPoW4ZqmJR506OkJ2G/HVyfBDY0ptRyoiJwSr9rc0DlljHGxB
         F5z16Gm/B6OVdr4QVeL7PfNGoQSDxvO6c50t9ASzwBM7NoAgPSMcEozCgWkglNUqC4qk
         HG/g==
X-Gm-Message-State: AOJu0YzYArP2SeBN7lVB0OWzAnML0OXCopYL4rZnBOdLPOpv5BP1DZev
	DigpPetRXGMBZKqDjUify/fmk6g6XFmP2rcxdg6ICqwg29/wfq1Zp3rGR5o+U2XED82mRAEEKMW
	BWiaABUqeWZlHQnYyvQoy6q7PiQUznPoA
X-Google-Smtp-Source: AGHT+IGg5kTwSFSmauYczvj5jXp7Y4UQF1kQV6dCKtFy0GBXh0UHeoalkZZEVYoidoKCI0J/7gfM+gSi5byK
X-Received: by 2002:a05:6358:7298:b0:186:1128:bca7 with SMTP id w24-20020a056358729800b001861128bca7mr14540512rwf.6.1714438460349;
        Mon, 29 Apr 2024 17:54:20 -0700 (PDT)
Received: from c7-smtp-2023.dev.purestorage.com ([208.88.159.128])
        by smtp-relay.gmail.com with ESMTPS id q27-20020a63751b000000b005e485fc9c51sm1624067pgc.35.2024.04.29.17.54.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Apr 2024 17:54:20 -0700 (PDT)
X-Relaying-Domain: purestorage.com
Received: from dev-ushankar.dev.purestorage.com (dev-ushankar.dev.purestorage.com [IPv6:2620:125:9007:640:7:70:36:0])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id 981993402AD;
	Mon, 29 Apr 2024 18:54:18 -0600 (MDT)
Received: by dev-ushankar.dev.purestorage.com (Postfix, from userid 1557716368)
	id 8B079E402FE; Mon, 29 Apr 2024 18:54:18 -0600 (MDT)
From: Uday Shankar <ushankar@purestorage.com>
To: Ming Lei <ming.lei@redhat.com>,
	Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Uday Shankar <ushankar@purestorage.com>,
	Riley Thomasson <riley@purestorage.com>
Subject: [PATCH] ublk: remove segment count and size limits
Date: Mon, 29 Apr 2024 18:53:31 -0600
Message-Id: <20240430005330.2786014-1-ushankar@purestorage.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ublk_drv currently creates block devices with the default max_segments
and max_segment_size limits of BLK_MAX_SEGMENTS (128) and
BLK_MAX_SEGMENT_SIZE (65536) respectively. These defaults can
artificially constrain the I/O size seen by the ublk server - for
example, suppose that the ublk server has configured itself to accept
I/Os up to 1M and the application is also issuing 1M sized I/Os. If the
I/O buffer used by the application is backed by 4K pages, the buffer
could consist of up to 1M / 4K = 256 physically discontiguous segments
(even if the buffer is virtually contiguous). As such, the I/O could
exceed the default max_segments limit and get split. This can cause
unnecessary performance issues if the ublk server is optimized to handle
1M I/Os. The block layer's segment count/size limits exist to model
hardware constraints which don't exist in ublk_drv's case, so just
remove those limits for the block devices created by ublk_drv.

Signed-off-by: Uday Shankar <ushankar@purestorage.com>
Reviewed-by: Riley Thomasson <riley@purestorage.com>
---
 drivers/block/ublk_drv.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index bea3d5cf8a83..835b0cc7c032 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -2209,6 +2209,9 @@ static int ublk_ctrl_start_dev(struct ublk_device *ub, struct io_uring_cmd *cmd)
 		lim.max_zone_append_sectors = p->max_zone_append_sectors;
 	}
 
+	lim.max_segments = USHRT_MAX;
+	lim.max_segment_size = UINT_MAX;
+
 	if (wait_for_completion_interruptible(&ub->completion) != 0)
 		return -EINTR;
 
-- 
2.34.1

