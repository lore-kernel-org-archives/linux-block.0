Received: from mail-oa1-f100.google.com (mail-oa1-f100.google.com [209.85.160.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 636B7493D4C
	for <linux-block@vger.kernel.org>; Wed,  9 Sep 2026 22:29:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788992967; cv=none; b=Zr48SkZ3mTBZsFt5utkuGnA1d01WEqI6rXO10NGvJxHNi22Ifkj280tbpXShj9fErnEzN586j0/Q8QVAgXvT7rX2S2YKEbVFa7ZS+PeGxTH5hZnpjLSoyForO5wQKIjsKLDs49zgJsHYUaBF1P5xtHtmC6IT1pNvyxa53aXmvTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788992967; c=relaxed/simple;
	bh=ZsRCPU0J121h1w/y85vunBI0gv6iQjmpHXlh3qUdYlg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ewYV2C99cP1pWWnH2a5fdzDPU8rr7F9whHVdYAS5HZ4aLB7nWXGv5veam4SYQge2A/FejaDQOTbfvjVhYgPvJCW8fde3Ba5JxnhLpYLkLPhuTdA3wFKyY65gvz93mZ/Q5wJwkTvNU73JgrN3BIQlzbIaTwq+4EHW2zNzeRptqA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=pass smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=LMnDcxSW; arc=none smtp.client-ip=209.85.160.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="LMnDcxSW"
Received: by mail-oa1-f100.google.com with SMTP id 586e51a60fabf-47beb94e2e7so1709fac.1
        for <linux-block@vger.kernel.org>; Wed, 09 Sep 2026 15:29:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1788992944; x=1789597744; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ImWYQroYLYn1yUntaG3yDyG9poZ7C84uz/cQieFkqu0=;
        b=LMnDcxSWOPQs3Iluim5mr8nhBkssXls8io+aEc8xhd83PNawOi0+HS6tnL3fvPYHaF
         Z0iCc+OYZyTwjDW/F7qqK6yJag2bT21rnE2ASpUB/iZ8TmQjXU/O46v3sSrqcT04NA1E
         dtwypgDV+a3DHU9lUzP0dckuysAdmbq7A/WKjXl5/lKNWkcZBNVY4gyAjX6sEGR6jkpk
         jCrxkSHb80WRk0Bti8ABy1rfmvmoOn3W9Uw0g44odA4sEEH6c8PkWTw6ii23hZSiGNJc
         7pi6YE71ax6Tib3PdUBqj7Cmr7GDnTAkUbGvx7YnJjbSUa9v40Tb0IwmJD7QzcVmYCUY
         gwDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788992944; x=1789597744;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ImWYQroYLYn1yUntaG3yDyG9poZ7C84uz/cQieFkqu0=;
        b=JJfTMiCm9cCQBFwVG16yUw7JhJNdm2mdAj29JMrJPzii+Ly7Y0D4AQbUfnhylrKsq0
         PmKoguM/8Qh5QTrVxoW5xZPkgbG8QMSShMqE4JkNmYwzO6ooAZctOG7xfLauBSe6bUMZ
         5ukjSb8+sARnoW1Oop+LCS0vXSKcRJSoQBMHWckXlVc9KKgF7ajoHCczWbR+QRzj05eJ
         j2RRM6rZ3EKFqmCtQbxfMUmcDa9iLgEPi8571AqF7+V/YEvXm5uAk1Jf/FL8zBWGtLvh
         clQbx9Gpe2JJue6Ap9L/PsyvUtGmL17DLV1Kko4nJsOK5+w9TGHuzglTajxJCyvSejVA
         oWeA==
X-Forwarded-Encrypted: i=1; AKwUvBz1ldNfVPEAnoXYIMUhy4Q3rkXd0jeCdE2Fo4IFDhfqp06ElS7C6q2/FF+31tshQUS0yI+TUvxujYHRTg==@vger.kernel.org
X-Gm-Message-State: AFuF++n87iIFAhcR83z2EVwG7u6kizqpkn31vSgRspfa1JV7qao2RkrK
	vF4+9Dm/Qx+TQmr8Dkg93j9MMOSxj1yzSkv9XvUHUkO883t9FpsVWa5uDQISeedqqBI9AnmMxfh
	K+Ko7iuL55rbjrSTeVIBRSLPzcvxVGjqW0Q/W
X-Gm-Gg: AYBFou1bSEUeFP5Y/O/FkZQKc2EqkdM4BXdykhfZCddZihiCtJ1Z6ijXpTrMs2dGgFK
	qnXiaq6e3G/SyEb0MB/YEJmIw0CSwmZ4xynDyOUmApwz5nu6cdFBlgKBEyN5p1t50rD310g50pe
	bWYCHmKUAsGgk14VA2IfUlUgUAu9gW7w19QjNhyJutFbbudLG/lNbouzmnxHDWX/53NwKTnOsso
	xdZ4MXgVWAlPEASftPB1T7EfSRjuTuHLVPRVFdWiFMwWPGkI0wa1R6JdjYPtRkhuCN/RBtPe16q
	rMYVZdSJqJKsNgjRL4iSsrBm52RGPPeK39fCv4kIWn8OJUx60+3caXDP7kbI0seYrAzxEqO1FUB
	6h+ziTfwYb/ZUximNTXs5IYWivBQ4gKBK
X-Received: by 2002:a05:6830:f89:b0:7ee:363d:ce16 with SMTP id 46e09a7af769-7fb76e3cd73mr16877278a34.0.1788992944121;
        Wed, 09 Sep 2026 15:29:04 -0700 (PDT)
Received: from c7-smtp-2026.dev.purestorage.com ([208.88.159.129])
        by smtp-relay.gmail.com with ESMTPS id 46e09a7af769-7f9f6aa689fsm2773280a34.5.2026.09.09.15.29.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2026 15:29:04 -0700 (PDT)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (dev-csander.dev.purestorage.com [10.112.12.104])
	by c7-smtp-2026.dev.purestorage.com (Postfix) with ESMTP id AFA1C402BE;
	Wed,  9 Sep 2026 16:29:03 -0600 (MDT)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id AD682E40322; Wed,  9 Sep 2026 16:29:03 -0600 (MDT)
From: Caleb Sander Mateos <csander@purestorage.com>
To: Jens Axboe <axboe@kernel.dk>,
	Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>
Cc: io-uring@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Caleb Sander Mateos <csander@purestorage.com>
Subject: [PATCH 6/6] nvme/ioctl: support fixed buffer for metadata
Date: Wed,  9 Sep 2026 16:28:36 -0600
Message-ID: <20260909222836.2475352-7-csander@purestorage.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260909222836.2475352-1-csander@purestorage.com>
References: <20260909222836.2475352-1-csander@purestorage.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

io_uring NVMe passthrough supports using a "fixed" (registered) buffer
for data, but not metadata. On high-IOPS workloads, the pinning and
unpinning overhead for the metadata pages is significant and could be
avoided if fixed metadata buffers were supported.

Define a NVME_URING_CMD_FIXED_METADATA bit for the nvme_uring_cmd's
flags field (which is currently required to be 0) to indicate that the
metadata buffer belongs to a fixed buffer registered with the io_uring.
The metadata fixed buffer index is specified in a metadata_buf_index
field replacing the existing rsvd1 in nvme_uring_cmd.

If NVME_URING_CMD_FIXED_METADATA is set, the metadata iov_iter is
obtained from io_uring_cmd_import_fixed_metadata() instead of
iov_iter_ubuf().

Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
---
 drivers/nvme/host/ioctl.c       | 21 ++++++++++++++++-----
 include/uapi/linux/nvme_ioctl.h |  5 ++++-
 2 files changed, 20 insertions(+), 6 deletions(-)

diff --git a/drivers/nvme/host/ioctl.c b/drivers/nvme/host/ioctl.c
index 8e722184ecf1..4da8cf92c2e0 100644
--- a/drivers/nvme/host/ioctl.c
+++ b/drivers/nvme/host/ioctl.c
@@ -488,21 +488,22 @@ static int nvme_uring_cmd_io(struct nvme_ctrl *ctrl, struct nvme_ns *ns,
 	struct iov_iter iter, meta_iter;
 	struct iov_iter *map_iter = NULL, *map_meta_iter = NULL;
 	struct request *req;
 	blk_opf_t rq_flags = 0;
 	blk_mq_req_flags_t blk_flags = 0;
+	u8 flags = READ_ONCE(cmd->flags);
 	u32 metadata_len, data_len;
 	u64 metadata, addr;
 	u32 timeout_ms;
 	int ddir;
 	int ret;
 
-	c.common.opcode = READ_ONCE(cmd->opcode);
-	c.common.flags = READ_ONCE(cmd->flags);
-	if (c.common.flags)
+	if (flags & ~NVME_URING_CMD_FIXED_METADATA)
 		return -EINVAL;
 
+	c.common.opcode = READ_ONCE(cmd->opcode);
+	c.common.flags = 0;
 	c.common.command_id = 0;
 	c.common.nsid = cpu_to_le32(cmd->nsid);
 	if (!nvme_validate_passthru_nsid(ctrl, ns, le32_to_cpu(c.common.nsid)))
 		return -EINVAL;
 
@@ -539,12 +540,22 @@ static int nvme_uring_cmd_io(struct nvme_ctrl *ctrl, struct nvme_ns *ns,
 			return ret;
 
 		map_iter = &iter;
 	}
 	if (data_len && metadata && metadata_len) {
-		iov_iter_ubuf(&meta_iter, ddir, nvme_to_user_ptr(metadata),
-			      metadata_len);
+		if (flags & NVME_URING_CMD_FIXED_METADATA) {
+			u16 buf_index = READ_ONCE(cmd->metadata_buf_index);
+
+			ret = io_uring_cmd_import_fixed_metadata(
+				ioucmd, buf_index, metadata, metadata_len, ddir,
+				&meta_iter, issue_flags);
+			if (ret < 0)
+				return ret;
+		} else {
+			iov_iter_ubuf(&meta_iter, ddir, nvme_to_user_ptr(metadata),
+				      metadata_len);
+		}
 		map_meta_iter = &meta_iter;
 	}
 
 	if (issue_flags & IO_URING_F_NONBLOCK) {
 		rq_flags |= REQ_NOWAIT;
diff --git a/include/uapi/linux/nvme_ioctl.h b/include/uapi/linux/nvme_ioctl.h
index 2f76cba67166..93973f636b48 100644
--- a/include/uapi/linux/nvme_ioctl.h
+++ b/include/uapi/linux/nvme_ioctl.h
@@ -68,15 +68,18 @@ struct nvme_passthru_cmd64 {
 	__u32	timeout_ms;
 	__u32   rsvd2;
 	__u64	result;
 };
 
+/* struct nvme_uring_cmd flags field bits */
+#define NVME_URING_CMD_FIXED_METADATA (1U << 0)
+
 /* same as struct nvme_passthru_cmd64, minus the 8b result field */
 struct nvme_uring_cmd {
 	__u8	opcode;
 	__u8	flags;
-	__u16	rsvd1;
+	__u16	metadata_buf_index;
 	__u32	nsid;
 	__u32	cdw2;
 	__u32	cdw3;
 	__u64	metadata;
 	__u64	addr;
-- 
2.55.0

