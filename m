Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 401703546CD
	for <linux-block@vger.kernel.org>; Tue, 11 Aug 2026 19:21:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786476075; cv=none; b=HfLMjqc/g23i5DPw1r+NQZDRwVRU+M2dOvUlhpaGHnvbJpxXzIqmQnyi4GGg/y9ZCydgpDqHaUoSFZq+8Ywlhhbz+QOD/kn3hq9v9fufbeP/umoCBVr+1zUUqxkWmn+KQCrQeQBEwviQAV84GESvUx3wWExoqu5XBDc49WbaHOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786476075; c=relaxed/simple;
	bh=GtKx2FrILq6hjs4UID5Fcq+FRzXE15Cu9bDzlLwTZXM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mt8nRg6HaTDF6xVPRg7dboyNph4yyi2uQpFNAWR1QWiYlGopB/UAYOy39XawdT76ggG9ukjAYkip2LNQ9ZChBWLx5iVg5THX/f+m60eEB6uwpy7jdDPi8ZmRRSRqp/+PoAdO4HWfJVbnTqFNlwy/ZTWwWEjGg97QKbcZG+moPNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=liwqHyJM; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="liwqHyJM"
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-8143daf89c7so2117037b3.1
        for <linux-block@vger.kernel.org>; Tue, 11 Aug 2026 12:21:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786476073; x=1787080873; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=xsGRF6OAYtOe4wGNm3PkEdXjvkEOAuUjKX79hFhAsys=;
        b=liwqHyJM0EZMqjksGYHaREU/BNyD5daCcBotSpnkR+zpvdMKgxFgI062NEeJpwF+i/
         Kj612SClPYB8QmnGla/Dfc7aYt5NPEr8ttnh2nc+QQvr7EwkCXPbdRWnVOxVgJ85IlPJ
         JcttBTRh5jFyxXiZ8Fmgkh+moaRVX5IyjxwuSN8tMyYrZnq+MO39l4tBSzGJoKL0Hl4E
         ylntUEXGOXkF/KrPisTA5VqL0nBTD3BcqPYPNQX1qXAsffHdFJdSr1ddaoMuz9ioZqnu
         qSQEP35B5dEZgarL4cO32rmsEFhh40tihE24ZG3nU402g08IaYWxbiYGwBycu8AtBoSf
         516Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786476073; x=1787080873;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=xsGRF6OAYtOe4wGNm3PkEdXjvkEOAuUjKX79hFhAsys=;
        b=lbCAFRrp1aj+sIvgt+4uYZeyLqHnkFePN9H+lu/cL+hp3uB29tTGEcL7dTfG8KX5kv
         QUYGd9OauwLNf7VJwQ2/GaBbgR3sP/EH6oAgZmpvuxeXAotgQhJ5N5Ak4t1Q6vPu1oj+
         MvO0X97o8Z/Nw7WqwTUSAwhBMxrTq7vAU5FEz2Gg65/cfFy6ljUY7lV1Ilb9BqsJRWtZ
         F1Ou8RUapIbqE8GDaIAhDqTcpiqyVS0sQHQBYv/E5K8gY5YUCzXJTg5iZYb/BdnUCFy6
         YmYFV0My8f9llkkPBo8ilCUyyQ/CN958YTGHSHFp6OuBURswUdWxGlV/H4ffC0dOWhAY
         oSmA==
X-Forwarded-Encrypted: i=1; AHgh+Roid3i2btX3o06SZQKIS7ws9K+wVC9UKWGjvzCSBpJ1ku9NHmwjNhU8lksmgyQYF9c7tbd07lIjROGqFg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0Lhs/ZOdmmo6Qb1zBlHC8Fax88URUL+O3oqfk8WYq61LRItZ/
	aOfvCeiAgBvVu3qr0Gi19oFeBYEIwmZkvwZ5v9ZpADoiuDYkOvjZE//7
X-Gm-Gg: AR+sD12RqlqIrNf8RpzueKYkF26aAqW4F3EjS24ERxhsdNc0Xa5Td3ppiwY0cwQLr+K
	Ey6xq7g2S3XtGPLM0fi0obUaT5DdxK7ehwQUEyK9gBSijINWIucsZ43WyOaYM8xq4dHxrdq5hmF
	s3FBtBwpwf90k4jGkxwaDIK2G0KYagGG9bZNhMNWK2sXeyGAcDw44VNuLlxWrV9JyziiB+UoROq
	PR8aThMNbp8QpMKqoR5c/6GuilyB64w20Pjn7qh+bPP7pTi3kph7j6vB4VMb8uQOwNFlm7/Q74l
	7YZL1NlhTczp2FXYMUIvh0F5VYMJeUzsoYaPVGOj2YNDJFSL52f9MMwnpK6OdtYROe19ozINFag
	dqbG0s9vUqARfb8KonnMzXUVTiuP6vIFKcBdVd8WiptdlMWNFXJDTkOTOSCUwwSUaC1Zi4d9K2Q
	cCXj1mWEcGdctr41npytQgC+1IZ/7bBIuAn0Nj+cMU50xp5NugxdZwQjC/fGC1rEf69MA5eV5eQ
	YdL6Mo=
X-Received: by 2002:a05:690c:b88:b0:826:5659:28aa with SMTP id 00721157ae682-82f2ef152e0mr41609287b3.32.1786476073030;
        Tue, 11 Aug 2026 12:21:13 -0700 (PDT)
Received: from syssplab.cs.fiu.edu (nat1.cs.fiu.edu. [131.94.134.89])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-830a41425d1sm2748287b3.11.2026.08.11.12.21.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Aug 2026 12:21:12 -0700 (PDT)
From: Chao Shi <coshi036@gmail.com>
To: Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	linux-nvme@lists.infradead.org
Cc: "Martin K . Petersen" <martin.petersen@oracle.com>,
	Weidong Zhu <weizhu@fiu.edu>,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH] nvme: refuse an unsolicited format change on a namespace that is in use
Date: Tue, 11 Aug 2026 15:21:11 -0400
Message-ID: <20260811192111.2058140-1-coshi036@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A namespace can report a new LBA format or metadata size on revalidation.
The host still holds cached data, queued bios and integrity buffers built
for the old geometry.  Adopting the new one reinterprets all of it.

Freezing the queue does not help.  The request is already complete when
the integrity verify is handed to kintegrityd, so the freeze drains while
that work is still pending.  The verify then walks a buffer sized for the
old metadata_size using the new step size.  That is the reported KASAN
slab-out-of-bounds read in t10_pi_verify().

Christoph suggested failing such a revalidation rather than handling the
fallout.  Do that.  Compare the new LBA data size and metadata size
against the live ones, before the queue is frozen.  If they differ while
the disk is open, return INVALID_NS/DNR.  nvme_validate_ns() turns that
into nvme_ns_remove(), as it already does for changed identifiers.

Host-initiated format and namespace management are exempt.  They arrive
through nvme_passthru_end(), where the host asked for the change.
NVME_CTRL_SELF_RESCAN marks that window.

Link: https://lore.kernel.org/linux-block/ah03bXpgFLQjOUt8@infradead.org/
Link: https://lore.kernel.org/linux-block/20260531-blk-integrity-fix-v1-1-cc7084f42cf1@outlook.com/
Found by FuzzNvme.

Signed-off-by: Chao Shi <coshi036@gmail.com>
---
RFC: the refusal path is untested and the scoping is the part I am least
sure of.

* Build-tested only.  W=1 clean, with and without CONFIG_NVME_MULTIPATH.
  syzkaller could not extract a reproducer, so the new path has not run.

* Is the exemption right?  It keeps "nvme format" working on a namespace
  that merely has a udev probe open.  But it also lets through the one
  case where a change is expected.

* NVME_CTRL_SELF_RESCAN is best effort.  An AER-driven rescan inside the
  nvme_passthru_end() window looks solicited.

* Only lba_shift and ms are compared.  A PI type change with the same
  metadata size is not caught.

* Replaces an earlier attempt from my group that Christoph NAK'd.  We are
  dropping it rather than respinning it.

 drivers/nvme/host/core.c | 40 ++++++++++++++++++++++++++++++++++++++++
 drivers/nvme/host/nvme.h |  1 +
 2 files changed, 41 insertions(+)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 453c1f0b2dd0..ebac5a3d1a07 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1285,8 +1285,15 @@ void nvme_passthru_end(struct nvme_ctrl *ctrl, struct nvme_ns *ns, u32 effects,
 		}
 	}
 	if (effects & (NVME_CMD_EFFECTS_NIC | NVME_CMD_EFFECTS_NCC)) {
+		/*
+		 * The host asked for this change, so let the rescan adopt the
+		 * new namespace geometry even if the disk is open.  Only an
+		 * unsolicited change is refused, see nvme_update_ns_info_block().
+		 */
+		set_bit(NVME_CTRL_SELF_RESCAN, &ctrl->flags);
 		nvme_queue_scan(ctrl);
 		flush_work(&ctrl->scan_work);
+		clear_bit(NVME_CTRL_SELF_RESCAN, &ctrl->flags);
 	}
 	if (ns)
 		return;
@@ -2384,6 +2391,17 @@ static bool nvme_invalid_lba_sz(u64 nsze, signed int shift, sector_t *capacity)
 	return check_shl_overflow(nsze, shift, capacity);
 }
 
+/*
+ * Openers of a multipath namespace go to the head disk; the per-path disk is
+ * hidden and never has any.
+ */
+static unsigned int nvme_ns_openers(struct nvme_ns *ns)
+{
+	if (nvme_ns_head_multipath(ns->head))
+		return disk_openers(ns->head->disk);
+	return disk_openers(ns->disk);
+}
+
 static int nvme_update_ns_info_block(struct nvme_ns *ns,
 		struct nvme_ns_info *info)
 {
@@ -2436,6 +2454,28 @@ static int nvme_update_ns_info_block(struct nvme_ns *ns,
 		goto out;
 	}
 
+	/*
+	 * Changing the LBA format or the metadata size reinterprets everything
+	 * the host has already cached, queued or handed to the integrity code
+	 * for this namespace, and freezing the queue does not cover any of it:
+	 * page cache contents, bios batched on a plug and the deferred
+	 * integrity verify work all outlive the freeze.  If such a change
+	 * arrives unsolicited while the namespace is in use, refuse it and let
+	 * the caller take the namespace offline rather than adopt a geometry
+	 * that describes something else than what the host is holding.
+	 */
+	if (nvme_ns_openers(ns) &&
+	    !test_bit(NVME_CTRL_SELF_RESCAN, &ns->ctrl->flags) &&
+	    (ns->head->lba_shift != id->lbaf[lbaf].ds ||
+	     ns->head->ms != le16_to_cpu(id->lbaf[lbaf].ms))) {
+		dev_err(ns->ctrl->device,
+			"unsolicited format change on in-use nsid %u (lba_shift %u -> %u, ms %u -> %u)\n",
+			info->nsid, ns->head->lba_shift, id->lbaf[lbaf].ds,
+			ns->head->ms, le16_to_cpu(id->lbaf[lbaf].ms));
+		ret = NVME_SC_INVALID_NS | NVME_STATUS_DNR;
+		goto out;
+	}
+
 	lim = queue_limits_start_update(ns->disk->queue);
 
 	memflags = blk_mq_freeze_queue(ns->disk->queue);
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 824651cc898d..93c15d5580e3 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -329,6 +329,7 @@ enum nvme_ctrl_flags {
 	NVME_CTRL_SKIP_ID_CNS_CS	= 4,
 	NVME_CTRL_DIRTY_CAPABILITY	= 5,
 	NVME_CTRL_FROZEN		= 6,
+	NVME_CTRL_SELF_RESCAN		= 7,
 };
 
 struct nvme_ctrl {

base-commit: f5bbbfec59b4e2fb7520a91de3df8a6174325d6a
-- 
2.43.0

