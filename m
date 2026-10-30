Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793324766;
	b=TuUQ3j9Ern3YndZkAlcnvJCohFzVYX60vPADefCSJ8qwMJta/TF+RWn5qeYOKefSz7Dw
	 wYKnor4jVBwcJxx6K9otTzKZP7YSMju6rJC8UYKSsebUjT/rjDnaUCqn2r6E74X3T4E0Y
	 6qVIZy00xLdWlKL7xs/v6i4eDyusSh9MlT3xAIOa99T6UzG4t2pI0HE4m/OpNq06Dg2EK
	 uItJVC1Tg7Vcr1CT5uSKFrConSXzQARJBZI7Wi3caod8yPOwY3Upj3wh/k6zO3DJIcCG6
	 rXZNcoIc7En9X21hWi55ze+IPORMmoKS5pmObvqZSXHpLADYrDhbQZ3PDefSomCqshA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793324766;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=VA9n7u5udKY5o86NILqNHNelhcHr5Omn4I4tRtC62Fg=;
	b=N+QmCOce3Pt91SY3DdAVPlylXhG0QaO2XUX1tjIs8jle06I9LNsJLnzctuwJ8fpQ10G+
	 W9IGp+fNPrAOPUOXsWNVGnuh2+BonnW6LAzeMeu3SfOpxiMct+w2dc/c2PeoioYmtF12r
	 axAB5jkJ5vRnzscglg+smqZfe+FULM5kisYDSewFXXVNuLKSDi65xuFVqh0/0DS1wYjCx
	 A216Tx+r2H2MfG8ADIX2JM2gvKgrOD17cVUvyHTil0sSSDyE92XXDEz0lr9t2OeB0cDTt
	 2CDBkj90G+0wsmYjLjQc0bGQEZHQckrvJ+iuY/wkrQ1Kv9UT9R6ciZJ9IcFxoGu/baA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=dT+Ame6b;
	arc=none smtp.remote-ip=74.125.82.174
Received: from mail-dy1-f174.google.com (mail-dy1-f174.google.com [74.125.82.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9404D606A324
	for <linux-block@vger.kernel.org>; Fri, 30 Oct 2026 01:46:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9404D606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=dT+Ame6b
Received: by mail-dy1-f174.google.com with SMTP id 5a478bee46e88-36a18fc7a38so631502eec.1
        for <linux-block@vger.kernel.org>; Thu, 29 Oct 2026 18:46:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793324765; x=1793929565; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=VA9n7u5udKY5o86NILqNHNelhcHr5Omn4I4tRtC62Fg=;
        b=dT+Ame6bjXArbCSUBed/L9j6jCpuv/OaqpN5MuAuoGHMlbSKSMh528Sh8soF9Ydr48
         MkoxgqTxfnHJ3B5pQYTBh+BDX9iG39G012E3p4FkLN5bboFAEgDRBWev5SRey+CuABW/
         3inQvh50kpx0X8W/SsoycEo4dDJum2afuUbbwjoPR2gmCVnUE4JUxtORJ9Pfv08QvXw0
         rPDTKMCtZ+rpRaT2RDTVxeex9nliS9QhwPjXvQDy0Bb9a7yqAfek5QdahGAgJRo3QFTA
         TxC6CcvoCG4eUEYMDKS44Iytl7R340nl2bLyLq9NEOUUAmTolKgOoW1O7WVl7sqKuvyo
         VRpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793324765; x=1793929565;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=VA9n7u5udKY5o86NILqNHNelhcHr5Omn4I4tRtC62Fg=;
        b=H8DlCS3spoAurX/G/iFodqQPjbivlxG6c2NXPZ+3nspDulGshbE/NNHnnoZbb7o0Fs
         i9BL52AxV/E7fV9WU5mWwWex0ahLvxpbiTZnLL4S0/+YdPmP4x1uZnGh1KUlrqu4fHL1
         8Rj+5qSsHNc3XXOJ8ifIc82XB/hcJZWSOh8wweWsi7P0+Ik4Sb6r8eBz3TnXbhTajzfb
         /Ap7ixAwIg/G8tUGA4VOhXffuv8iZ+rgTx0h+Jl5fv2CBHcvzCRTjNM4fl+xzYN+Y49l
         0xJZ5jxBSTIJsM+XO9vLlr52EGTl8NkgCeNrf/85pxG4XZJSnHRgk0tQo4Iu0k6qhQl/
         wAlg==
X-Forwarded-Encrypted: i=1; AKwUvBxYCf74bxswtXEAfGsfpLGQDpm9UATIaALzRuPlOJiUqtTxo15NEBVyFvzddJIZv3AIjQqbsVHNDd6Uqw==@vger.kernel.org
X-Gm-Message-State: AFq9FYIzQQkUsaA/hbhT0uOJRi03sTp0ReLlrSUfNmL/znBcCqEIzqp5
	BNseC7cnd38pNg9HuW9Ogvhupg2rlvmirohTP0HIz9aX6MW6iu2KEsI=
X-Gm-Gg: AYBFou28X+R9ieJpEg8kOYCeGGkuigbJpQsh47Q2Asxq4Yx+XMjtLzoBzpJRdZRBY9q
	Zi+1oAIMRqMft0O7o01CBaRa5zQzM7louUzDlxZNvnXau/N9xMuiVh9iWJ/t2wwfffatGtqkHrQ
	wCTJp6JMRKabDR/5mMl7qsCR6Bddl1h7txYl0mM2imnOFkyvKUX/qR1oLEFYX9db1ZtAo3C+wfp
	Rv8SrXIqTASyQjEyBsoUvTgpUnAktFZ/mgHqCzyT+I+6xy0ETyC/2wazlYQEQ36MVh20lUpBa8T
	mMzNXteJhNTmEFrMlauNVqP+CGR+0E5YBlB/tu/vvAYyJAyj0RobaycuJH8vOAm6H7CE3kSuLlr
	ET+KnWtxpLEtAJD3QJfmH4iAQJc1+2It8EEWNlsPmsrHr+ETnSZ+kfCxdpTj6mAXEz7d8MyL9ct
	GwnZlxOjAEGdpH1djgCxF51NnBpxbJSADkCTQL3Ixr5RhN8Wft+m7pjne2f/N77KyMWjmrienYG
	nM/dD5JWAvC/gZAmt4jmQEdgkzZi5X7CIshd3F3dnuD24awNeUlSaxVg3wLz/eC8i2rD4/pv7YH
	b9m7U3tx8uM6wuBsOdAT7aXAS+U4KJj5toW+R+Cl/+4RnsirSYh+oHKSaCBVDBmQkzrQPNKp/0t
	AxoK/4/LL05D1zC12
X-Received: by 2002:a05:7300:e918:b0:35c:de00:93d3 with SMTP id 5a478bee46e88-36a4247d812mr1334717eec.40.1793324764241;
        Thu, 29 Oct 2026 18:46:04 -0700 (PDT)
Received: from anuj-MacBookPro.. ([2406:7400:63:75fd:f9a4:4062:7980:1324])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36a428fa380sm2209020eec.12.2026.10.29.18.45.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2026 18:46:03 -0700 (PDT)
From: Anuj Gupta <anuj1072538@gmail.com>
To: axboe@kernel.dk,
	asml.silence@gmail.com,
	kbusch@kernel.org,
	hch@lst.de,
	sagi@grimberg.me,
	James.Bottomley@HansenPartnership.com,
	mkp@kernel.org,
	bernd@bsbernd.com,
	joannelkoong@gmail.com,
	miklos@szeredi.hu
Cc: io-uring@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	linux-block@vger.kernel.org,
	linux-scsi@vger.kernel.org,
	fuse-devel@lists.linux.dev,
	joshi.k@samsung.com,
	anuj20.g@samsung.com
Subject: [PATCH v3 2/5] io_uring/uring_cmd: add import flags to io_uring_cmd_import_fixed()
Date: Fri, 30 Oct 2026 07:15:37 +0530
Message-ID: <20261030014540.3065403-3-anuj1072538@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261030014540.3065403-1-anuj1072538@gmail.com>
References: <20261030014540.3065403-1-anuj1072538@gmail.com>
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Anuj Gupta <anuj20.g@samsung.com>

Add an import flags argument to io_uring_cmd_import_fixed(), so callers
can opt in to buffer types they support. No flags are defined yet, and
all callers pass 0.

No functional change.

Suggested-by: Pavel Begunkov <asml.silence@gmail.com>
Signed-off-by: Anuj Gupta <anuj20.g@samsung.com>
Reviewed-by: Pavel Begunkov <asml.silence@gmail.com>
---
 drivers/nvme/host/ioctl.c    | 2 +-
 drivers/scsi/scsi_bsg.c      | 2 +-
 fs/fuse/dev_uring.c          | 2 +-
 include/linux/io_uring/cmd.h | 5 +++--
 io_uring/uring_cmd.c         | 5 ++++-
 5 files changed, 10 insertions(+), 6 deletions(-)

diff --git a/drivers/nvme/host/ioctl.c b/drivers/nvme/host/ioctl.c
index a87c9ca9d06c..d342ccad067a 100644
--- a/drivers/nvme/host/ioctl.c
+++ b/drivers/nvme/host/ioctl.c
@@ -533,7 +533,7 @@ static int nvme_uring_cmd_io(struct nvme_ctrl *ctrl, struct nvme_ns *ns,
 					ddir, &iter, issue_flags);
 		else
 			ret = io_uring_cmd_import_fixed(d.addr, d.data_len,
-					ddir, &iter, ioucmd, issue_flags);
+					ddir, &iter, ioucmd, issue_flags, 0);
 		if (ret < 0)
 			return ret;
 
diff --git a/drivers/scsi/scsi_bsg.c b/drivers/scsi/scsi_bsg.c
index 5eec248a77a6..e53b417c27b9 100644
--- a/drivers/scsi/scsi_bsg.c
+++ b/drivers/scsi/scsi_bsg.c
@@ -87,7 +87,7 @@ static int scsi_bsg_map_user_buffer(struct request *req,
 	if (ioucmd->flags & IORING_URING_CMD_FIXED) {
 		ret = io_uring_cmd_import_fixed(buf_addr, buf_len,
 						is_write ? WRITE : READ,
-						&iter, ioucmd, issue_flags);
+						&iter, ioucmd, issue_flags, 0);
 		if (ret < 0)
 			return ret;
 		ret = blk_rq_map_user_iov(req->q, req, NULL, &iter, gfp_mask);
diff --git a/fs/fuse/dev_uring.c b/fs/fuse/dev_uring.c
index c6dd420c4034..5cc206abccc0 100644
--- a/fs/fuse/dev_uring.c
+++ b/fs/fuse/dev_uring.c
@@ -727,7 +727,7 @@ static int fuse_uring_import_payload(struct fuse_ring_ent *ent, int dir,
 
 	if (bufpool_registered(ent->queue))
 		err = io_uring_cmd_import_fixed((u64)(uintptr_t)base, len, dir,
-						iter, ent->cmd, issue_flags);
+						iter, ent->cmd, issue_flags, 0);
 	else
 		err = import_ubuf(dir, base, len, iter);
 
diff --git a/include/linux/io_uring/cmd.h b/include/linux/io_uring/cmd.h
index e18d4af62e1a..23fb66a1e2c1 100644
--- a/include/linux/io_uring/cmd.h
+++ b/include/linux/io_uring/cmd.h
@@ -64,7 +64,8 @@ static inline void io_uring_cmd_set_res32(struct io_uring_cmd *cmd, s32 ret, u64
 int io_uring_cmd_import_fixed(u64 ubuf, unsigned long len, int rw,
 			      struct iov_iter *iter,
 			      struct io_uring_cmd *ioucmd,
-			      unsigned int issue_flags);
+			      unsigned int issue_flags,
+			      unsigned int import_flags);
 int io_uring_cmd_import_fixed_vec(struct io_uring_cmd *ioucmd,
 				  const struct iovec __user *uvec,
 				  size_t uvec_segs,
@@ -124,7 +125,7 @@ int io_buffer_unregister(struct io_uring_cmd *cmd, unsigned int index,
 static inline int
 io_uring_cmd_import_fixed(u64 ubuf, unsigned long len, int rw,
 			  struct iov_iter *iter, struct io_uring_cmd *ioucmd,
-			  unsigned int issue_flags)
+			  unsigned int issue_flags, unsigned int import_flags)
 {
 	return -EOPNOTSUPP;
 }
diff --git a/io_uring/uring_cmd.c b/io_uring/uring_cmd.c
index 4dac3ba162ae..d77a94d19cb5 100644
--- a/io_uring/uring_cmd.c
+++ b/io_uring/uring_cmd.c
@@ -272,12 +272,15 @@ int io_uring_cmd(struct io_kiocb *req, unsigned int issue_flags)
 int io_uring_cmd_import_fixed(u64 ubuf, unsigned long len, int rw,
 			      struct iov_iter *iter,
 			      struct io_uring_cmd *ioucmd,
-			      unsigned int issue_flags)
+			      unsigned int issue_flags,
+			      unsigned int import_flags)
 {
 	struct io_kiocb *req = cmd_to_io_kiocb(ioucmd);
 
 	if (WARN_ON_ONCE(!(ioucmd->flags & IORING_URING_CMD_FIXED)))
 		return -EINVAL;
+	if (WARN_ON_ONCE(import_flags))
+		return -EINVAL;
 
 	return io_import_reg_buf(req, iter, ubuf, len, rw, issue_flags, 0);
 }
-- 
2.43.0

