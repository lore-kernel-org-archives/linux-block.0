Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792680357;
	b=DFSMatKzbe1LwsLE/sDvwDapaOp9D4YZgnYtuOPwtEyyqbbnL8LtLL1WTA/KCyW3H0mo
	 wio87RFiUwQbni3fut0uTW9CyrTdWehf0+FOE73k54x+GVfY5G7F5JDKrgCqdOgc55LEn
	 Ojej/31tQDkzoJUgwQUrvAgYccz2YY+SPABCQUy6lxphDtxf+w4MZqYZb8j0kdDP6HRVG
	 ZufOzv/EX0+WW2EQU659m0m4e2IjSfUxwVLAbF9qIJ+PZoG0vmptBtoVaTOKGPAW9uLS9
	 mqnONpV1oUIUqqzIqxSccttzmnvierLSqtuXWMyDI6Ozdwil24k9X5jUEi0oP4wKnAw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792680357;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=zxlzuK4b3EjXwKJngq0cBhTK9G6JWxv2Wu97XDb3XjU=;
	b=NoOtGhwZ1ie2wSlPhvroDgEzVlVpP+kDyGe0YQZ7HvgPGqfP+jJW37hWV9FrS54QN9Nl
	 lQcvmsdja+3CL3NjjFuFHdbwpjn+KFzSre8Iwa0yCyvvNox4CnmdouuoVegS0hqU86oj0
	 lsYkPAUbNtUraT8IZvXN/Kg1oeY+TUwuJn4WA6VwCl5oAe/4LSgtduUsuBLFSg6rhJc9Q
	 1wNh+zHztC3Jz8rjszRbSyZ8zWFcNRs3/FzUimKBTLiDQO0TtPqB4t9BxruV0uadin0qw
	 w+eFWk1W5DJ10+rwDDLIOyZlekCZPq2cZwSeE0YGw3TvpwYMHUypElMaI2C1LUQFDlQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=clhQ+aBH;
	arc=none smtp.remote-ip=74.125.82.51
Received: from mail-dl1-f51.google.com (mail-dl1-f51.google.com [74.125.82.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 777D4606A32E
	for <linux-block@vger.kernel.org>; Thu, 22 Oct 2026 14:45:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 777D4606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=clhQ+aBH
Received: by mail-dl1-f51.google.com with SMTP id a92af1059eb24-181516de561so575856c88.1
        for <linux-block@vger.kernel.org>; Thu, 22 Oct 2026 07:45:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792680356; x=1793285156; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=zxlzuK4b3EjXwKJngq0cBhTK9G6JWxv2Wu97XDb3XjU=;
        b=clhQ+aBHEl1TQ/FS6en8DI3L4SmUryHS6HNBc/jx5g2EbXrPkvKXxv1TAE6pbA+J+W
         9GeJOQVvfbgqaruY4nuUZMXoucY1S0JbtuLN/6p6/c4Nbx4Lhor5l8t/JhJn7W4gKapj
         b+k/Llp7XkWfme0uUEX3XpimKzAmh8nxwDdj8tlJ2ypIN7IcXa6yVZ3mboPkRrqoKL5N
         L3ea6vdCZ/fh4OM4eJwJFRd71d1XOLXgb/5Hf4Jtzo6k2HalPfxtaJ3//0ZptBkRT7O+
         mvzF30a5sW0oXXc5hNV1m1WbDu1LEfEZjDW9uWzoxs6LiSsPGQSMbjy53c3TRROQuJjK
         vlrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792680356; x=1793285156;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=zxlzuK4b3EjXwKJngq0cBhTK9G6JWxv2Wu97XDb3XjU=;
        b=IWQ5u2BULlZnEUSy2OOiwpZeEMqahhL+HzOB+UBDUrNBghemKfnu0xbyk+HCObErL+
         mHnKdVTs+Y62oxAQ2rsvOhJwRYSqvOQjLkuX3/HAc24IsUJ2llWubgdQv1AUkpCBjEHQ
         dC+FJsk+Bgs1EFFRPk/KjICyay5GuMbGmohwD0s9kLKuVOzgML7JxvoJPHxJndCILHp2
         kszbFiQT/D7lH7u3UdPIabC6o+XP4HKHRWgqOD84kofPMY4UVfSyFEH0v765xBVA0xXa
         mYw9BWP1r/pVXPU2RTWTD6M4tBq3ReRqbWRXZ63uVGD9B/vMiQIOMVqeYzpjmKDZP4Mu
         8zQw==
X-Forwarded-Encrypted: i=1; AKwUvBzQkadtsDo8EvBOKurD5BrorhxjcP73r6jdtRj0J3wY4lRCJLxO7mkE61at4xWCDGKQJfTHZBwlAqvqqA==@vger.kernel.org
X-Gm-Message-State: AFq9FYIom4773m22MM4ZV6dCfdjguKnx8SQ2pdEs+dO0H8SyAlYzE/Me
	dEj0YXD8ONxepjynyaOdTDF6sL9yjCJQxTaRpvJJK9XwZKBbiDHbKpY=
X-Gm-Gg: AYBFou2TkVqWX1jA+mp9p6AuVpmmvqN/EcAssv//6YQ9vDIXaDA5LSddXzL8pgKULyv
	UFAjvvDn+5RPEdYr+ZmG/v5xU20E0R7Z7oKacWgNQLrEXGCw27STSlkae5jXE/k4U8vVDoLn6Dc
	bSkHxcjvzwkmkKiLQ5JFI3DpsB1k2PqJbR1pwV7k+JiijuCLiC3tEYDGEkrV0mJGmbgM/URPitP
	Wm1Gnc6mMS+W7P72crWFKL+rr06KXhtx0QmiCGfITHGKa0yb5hOIYPpAkCV1F7gz+02j7/zY12U
	Ajs/EU58kd6lNrXlLdiV2ssSolatrj2Ae3WMbx02TXemkcdmFgGQtUm7YP+yXuqRmWgF8fqIc/9
	3cbaL2Cp9TVd7FAUbDJKqmKcSw9OHcAR+9L2khZ6ArB4B4AQgdh1wFjx4XialMtX5fjy519MPMK
	9hbuD+NXIETg1pISQbmZUvbCtjecw/qLrXicC5qVX/pvGhawNg575vhn0m5BI2NNcymqhOsmk8j
	h7oiessexLSJHLtmCVG9XCG4LmIZTKXOwKnnQEjbmorp7hHkx34oJDxpi+YElXb4y0e3KcTFVRU
	ljDHVpDzgbpkwUD4WRyqQHZKeOeJAYy2ayFmy8JZBN4=
X-Received: by 2002:a05:701b:4241:20b0:15d:d7a2:3a88 with SMTP id a92af1059eb24-192f03cb835mr3210408c88.18.1792680355569;
        Thu, 22 Oct 2026 07:45:55 -0700 (PDT)
Received: from anuj-MacBookPro.. ([2406:7400:63:e55a:5016:92c7:7a35:f3ff])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1903a275026sm23625880c88.5.2026.10.22.07.45.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2026 07:45:54 -0700 (PDT)
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
Subject: [PATCH v2 2/5] io_uring/uring_cmd: add import flags to io_uring_cmd_import_fixed()
Date: Thu, 22 Oct 2026 20:14:53 +0530
Message-ID: <20261022144501.2478417-3-anuj1072538@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261022144501.2478417-1-anuj1072538@gmail.com>
References: <20261022144501.2478417-1-anuj1072538@gmail.com>
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
---
 drivers/nvme/host/ioctl.c    | 2 +-
 drivers/scsi/scsi_bsg.c      | 2 +-
 fs/fuse/dev_uring.c          | 2 +-
 include/linux/io_uring/cmd.h | 5 +++--
 io_uring/uring_cmd.c         | 5 ++++-
 5 files changed, 10 insertions(+), 6 deletions(-)

diff --git a/drivers/nvme/host/ioctl.c b/drivers/nvme/host/ioctl.c
index 3aa5d2f2dfbb..612d3009dd29 100644
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
index 45c9c845f5d0..c2bc9dd242ec 100644
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

