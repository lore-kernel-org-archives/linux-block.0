Received: from mail-pf1-f226.google.com (mail-pf1-f226.google.com [209.85.210.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15200225A29
	for <linux-block@vger.kernel.org>; Wed, 30 Apr 2025 22:52:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746053566; cv=none; b=ZF1genSqcLKgwuC7497jEV1DzE+xJT0EH1QxGuuuQ/mJ0DCYqVrH5blTcJjS9wHgxM5hwAR1OSG2IbEYMWMyYkD6fCDDvVyS+uOzB0UmhfwlmunheibVHQFb3qo7FtIru1Vrx43283JeB7ZH08nBF5dW29nnBnzEF99Yn2wQeHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746053566; c=relaxed/simple;
	bh=yUtEHoQ4xRUN+TbTy6hSjbTUHM3GxPcNU0fnKHjGl9Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=A3Ns6zTWMre76d3kyfty03vCYJNHhKE+Rjlpz6GUDMsH6MRCOLiCjEZfSXQVauiKtqcYj3JjVajd7PHDoKQPFHYGe4VCGJwKNehQaCKayoxF2iSMvjAqPI9R0m3Qxp2VH1PfUwlVYiCTBvCPcI9qcf5dJ1oo5Hzzk8JFRY4x/K0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=JTFJ8X9e; arc=none smtp.client-ip=209.85.210.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="JTFJ8X9e"
Received: by mail-pf1-f226.google.com with SMTP id d2e1a72fcca58-736abdac347so66404b3a.2
        for <linux-block@vger.kernel.org>; Wed, 30 Apr 2025 15:52:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1746053563; x=1746658363; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jXNvXWhGudyXXPiWCUtWfoACEHHbGSETRpmhgFO97Ds=;
        b=JTFJ8X9eDxJF0bj1buhicyDAD4ljV7Qe3IoaATuUSmYYWc3o7hvYQQW2cQHjt/xusz
         Vzve7iog+ACRH/o1guUMxuYMO6VVeRvStS/AVtuXH0x5D/8iVHsHDjFWWAfEuAcwvSw+
         3/DKycoM5ntIowFxhAgpsiXylxEkQqes39t0mW/OKJRGrvN4Nvi/UEicpyaxghEfQpR8
         g56OvhKlqNu/wdRPCdTuzSMA4GuDNz09okJvfcTofvHqXdM4l52J1aczDz+0UVUDE7w2
         lxmcHYlcPv7Yg1g6OQNjHQbZ0HGfO8XBPLJuzyG7fkjVm4lswhYE4u1j2jOBzEbISfcn
         zbdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746053563; x=1746658363;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jXNvXWhGudyXXPiWCUtWfoACEHHbGSETRpmhgFO97Ds=;
        b=V5sCyElHCewjOOoZ2Q6FI0uAJwOWWABTbYsw9JdvYiyjuPS2vl1IHgQFMF8+J/zoGi
         EwKcBAQ5AWlIHSwGPEhxVr+9axB4+CZeUalKJmPMCEMhgP9upMun3rKGP1A0l46Qtzgp
         cgT/f9JxOYzC/HWCEqyTpP//nmT8fmV92TATUSDrW+5RYpiQckYgOSEV0p2NTWM5SQoO
         EjHDz/xR9WsQBlNWJ11vYnhVhawpU54x8mERuO1HSZcsFMnP1fYptSwRo/+nUnAxnTf9
         A1yr9+wayjC579IUJEDGjXxf/mtcW86CfST6PYwQtHLiswVwBIHJ/xNvMr/ZktzXtBfu
         fNPA==
X-Forwarded-Encrypted: i=1; AJvYcCUTX8a6lMsW9r4H5GI/JvL9oQq/lxG7SgdQ92Mx6ODeDkFs6prKG8PbgtK3OwDUXOkGpsZyKNJc1pCyDw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2GKkcPerGWjSzTUWIbjMX6ZTRauGoVAkbQEgG432Jv+V6VDl8
	DX8XMLHFoiQxzlB+RP8Uu1w5/nbwPD4NCuBO/sL/Btf/UI/YrEdecgV4HzLs8/h+07WWuhwUJzc
	Mpd39hZiLLb3lL4yiwL/vat6pB2SAJ8fkfQnI6WbJfe4NT5jJ
X-Gm-Gg: ASbGncuHqRTzG3OjHmngzp0biwLajOqO5aas8uSS4gyoQuNYla9cmwSeaSJOzppwOzu
	Xx2SBEgc6Do6N+MbId/b5/oE/DP4wNCTt4vIgZjj9J9dnE7vmQnynaoZrf8YcAd5QASCF1mWLWN
	9HpofFkIm0slMlb6lUprYcI3aYnjMFB6tfBr8+sgqoyiFZS06bhWhT5IuJfsNHLkFZ7OLCniYzT
	/LaH2pe3dBP0rvUAB0exJQvUNEa0rxW7OtUZS15b5bOSq572yXaJf8atfDzAtJaaB9IroBvOGi7
	M+JgUMeOdtj7gkKvxioTbda24Cj9Qg==
X-Google-Smtp-Source: AGHT+IFRgsolljz1XF8/Gy7pXyOvrGsDYWSmtyIVq1MRhWiFE/8/w5kqKRXbM01ufqUkz3FSfQVkK8mKIiHO
X-Received: by 2002:a05:6a00:369b:b0:730:8526:5db2 with SMTP id d2e1a72fcca58-7403aa56808mr2087247b3a.5.1746053563341;
        Wed, 30 Apr 2025 15:52:43 -0700 (PDT)
Received: from c7-smtp-2023.dev.purestorage.com ([2620:125:9017:12:36:3:5:0])
        by smtp-relay.gmail.com with ESMTPS id d2e1a72fcca58-7403979d657sm158609b3a.0.2025.04.30.15.52.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Apr 2025 15:52:43 -0700 (PDT)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (dev-csander.dev.purestorage.com [10.7.70.37])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id 9B5DB34022D;
	Wed, 30 Apr 2025 16:52:42 -0600 (MDT)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id 99374E41CC0; Wed, 30 Apr 2025 16:52:42 -0600 (MDT)
From: Caleb Sander Mateos <csander@purestorage.com>
To: Ming Lei <ming.lei@redhat.com>,
	Jens Axboe <axboe@kernel.dk>
Cc: Uday Shankar <ushankar@purestorage.com>,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Caleb Sander Mateos <csander@purestorage.com>
Subject: [PATCH v2 1/9] ublk: factor out ublk_commit_and_fetch
Date: Wed, 30 Apr 2025 16:52:26 -0600
Message-ID: <20250430225234.2676781-2-csander@purestorage.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250430225234.2676781-1-csander@purestorage.com>
References: <20250430225234.2676781-1-csander@purestorage.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Uday Shankar <ushankar@purestorage.com>

Move the logic for the UBLK_IO_COMMIT_AND_FETCH_REQ opcode into its own
function. This also allows us to mark ublk_queue pointers as const for
that operation, which can help prevent data races since we may allow
concurrent operation on one ublk_queue in the future. Also open code
ublk_commit_completion in ublk_commit_and_fetch to reduce the number of
parameters/avoid a redundant lookup.

Suggested-by: Ming Lei <ming.lei@redhat.com>
Signed-off-by: Uday Shankar <ushankar@purestorage.com>
Reviewed-by: Caleb Sander Mateos <csander@purestorage.com>
Reviewed-by: Ming Lei <ming.lei@redhat.com>
Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
[Restore __ublk_ch_uring_cmd() req variable used in commit d6aa0c178bf8
("ublk: call ublk_dispatch_req() for handling UBLK_U_IO_NEED_GET_DATA")]
---
 drivers/block/ublk_drv.c | 90 +++++++++++++++++++---------------------
 1 file changed, 43 insertions(+), 47 deletions(-)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index a183aa7648c3..7809ed585e1c 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -1587,34 +1587,10 @@ static int ublk_ch_mmap(struct file *filp, struct vm_area_struct *vma)
 
 	pfn = virt_to_phys(ublk_queue_cmd_buf(ub, q_id)) >> PAGE_SHIFT;
 	return remap_pfn_range(vma, vma->vm_start, pfn, sz, vma->vm_page_prot);
 }
 
-static void ublk_commit_completion(struct ublk_device *ub,
-		const struct ublksrv_io_cmd *ub_cmd)
-{
-	u32 qid = ub_cmd->q_id, tag = ub_cmd->tag;
-	struct ublk_queue *ubq = ublk_get_queue(ub, qid);
-	struct ublk_io *io = &ubq->ios[tag];
-	struct request *req;
-
-	/* now this cmd slot is owned by nbd driver */
-	io->flags &= ~UBLK_IO_FLAG_OWNED_BY_SRV;
-	io->res = ub_cmd->result;
-
-	/* find the io request and complete */
-	req = blk_mq_tag_to_rq(ub->tag_set.tags[qid], tag);
-	if (WARN_ON_ONCE(unlikely(!req)))
-		return;
-
-	if (req_op(req) == REQ_OP_ZONE_APPEND)
-		req->__sector = ub_cmd->zone_append_lba;
-
-	if (likely(!blk_should_fake_timeout(req->q)))
-		ublk_put_req_ref(ubq, req);
-}
-
 static void __ublk_fail_req(struct ublk_queue *ubq, struct ublk_io *io,
 		struct request *req)
 {
 	WARN_ON_ONCE(io->flags & UBLK_IO_FLAG_ACTIVE);
 
@@ -2019,10 +1995,51 @@ static int ublk_fetch(struct io_uring_cmd *cmd, struct ublk_queue *ubq,
 out:
 	mutex_unlock(&ub->mutex);
 	return ret;
 }
 
+static int ublk_commit_and_fetch(const struct ublk_queue *ubq,
+				 struct ublk_io *io, struct io_uring_cmd *cmd,
+				 const struct ublksrv_io_cmd *ub_cmd)
+{
+	struct blk_mq_tags *tags = ubq->dev->tag_set.tags[ub_cmd->q_id];
+	struct request *req = blk_mq_tag_to_rq(tags, ub_cmd->tag);
+
+	if (!(io->flags & UBLK_IO_FLAG_OWNED_BY_SRV))
+		return -EINVAL;
+
+	if (ublk_need_map_io(ubq)) {
+		/*
+		 * COMMIT_AND_FETCH_REQ has to provide IO buffer if
+		 * NEED GET DATA is not enabled or it is Read IO.
+		 */
+		if (!ub_cmd->addr && (!ublk_need_get_data(ubq) ||
+					req_op(req) == REQ_OP_READ))
+			return -EINVAL;
+	} else if (req_op(req) != REQ_OP_ZONE_APPEND && ub_cmd->addr) {
+		/*
+		 * User copy requires addr to be unset when command is
+		 * not zone append
+		 */
+		return -EINVAL;
+	}
+
+	ublk_fill_io_cmd(io, cmd, ub_cmd->addr);
+
+	/* now this cmd slot is owned by ublk driver */
+	io->flags &= ~UBLK_IO_FLAG_OWNED_BY_SRV;
+	io->res = ub_cmd->result;
+
+	if (req_op(req) == REQ_OP_ZONE_APPEND)
+		req->__sector = ub_cmd->zone_append_lba;
+
+	if (likely(!blk_should_fake_timeout(req->q)))
+		ublk_put_req_ref(ubq, req);
+
+	return 0;
+}
+
 static int __ublk_ch_uring_cmd(struct io_uring_cmd *cmd,
 			       unsigned int issue_flags,
 			       const struct ublksrv_io_cmd *ub_cmd)
 {
 	struct ublk_device *ub = cmd->file->private_data;
@@ -2077,34 +2094,13 @@ static int __ublk_ch_uring_cmd(struct io_uring_cmd *cmd,
 		ret = ublk_fetch(cmd, ubq, io, ub_cmd->addr);
 		if (ret)
 			goto out;
 		break;
 	case UBLK_IO_COMMIT_AND_FETCH_REQ:
-		req = blk_mq_tag_to_rq(ub->tag_set.tags[ub_cmd->q_id], tag);
-
-		if (!(io->flags & UBLK_IO_FLAG_OWNED_BY_SRV))
-			goto out;
-
-		if (ublk_need_map_io(ubq)) {
-			/*
-			 * COMMIT_AND_FETCH_REQ has to provide IO buffer if
-			 * NEED GET DATA is not enabled or it is Read IO.
-			 */
-			if (!ub_cmd->addr && (!ublk_need_get_data(ubq) ||
-						req_op(req) == REQ_OP_READ))
-				goto out;
-		} else if (req_op(req) != REQ_OP_ZONE_APPEND && ub_cmd->addr) {
-			/*
-			 * User copy requires addr to be unset when command is
-			 * not zone append
-			 */
-			ret = -EINVAL;
+		ret = ublk_commit_and_fetch(ubq, io, cmd, ub_cmd);
+		if (ret)
 			goto out;
-		}
-
-		ublk_fill_io_cmd(io, cmd, ub_cmd->addr);
-		ublk_commit_completion(ub, ub_cmd);
 		break;
 	case UBLK_IO_NEED_GET_DATA:
 		if (!(io->flags & UBLK_IO_FLAG_OWNED_BY_SRV))
 			goto out;
 		ublk_fill_io_cmd(io, cmd, ub_cmd->addr);
-- 
2.45.2

