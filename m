Received: from mail-yx1-f100.google.com (mail-yx1-f100.google.com [74.125.224.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34C75207A38
	for <linux-block@vger.kernel.org>; Sat,  3 Jan 2026 00:45:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767401138; cv=none; b=S1sJP3V4blNoaav+DV6yNZdiqmXnBoIG7Z9YDJ3QckwP9OLKP/tIzyqzKZvj6Ii6k5nGS0KS/FoU64AC+BQ9uowvMMvaeTEo7/McMwci0WFv0JX7Bq4kvAoOlkTnCofSaDE+tCpZYi6x4uP2CJxwoS5x1ugSsjOYlKyADFFcdck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767401138; c=relaxed/simple;
	bh=fTJhuC6H0dNBq3FX1co7NhfO2FVWInl52pOu9PDumX4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rU4v89/R1V3MHg7pEEsWxqe4PIe1rv+6WsCxplHUgcHt4F9y7ZS1z4OXJ9rAwKCpB71uEp1ftV3G2A8QmxY28uDxK26Ls6mIDWE4cIC/xF9+1pXhbMQyeURSS0sZSvcbIlBUSIKeEIFEHU8q5q49i8zbvpHuhFKBQLWq0I+nwFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=S+oOYJQU; arc=none smtp.client-ip=74.125.224.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="S+oOYJQU"
Received: by mail-yx1-f100.google.com with SMTP id 956f58d0204a3-6469e4b0ff6so709711d50.2
        for <linux-block@vger.kernel.org>; Fri, 02 Jan 2026 16:45:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1767401133; x=1768005933; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vUye211JIBiRnZQOddGEfx1ZXqYyficSfLxDXccUr6A=;
        b=S+oOYJQUFq3bFq/1ToZhr7LYqluM3fRh4Y+iN0tcWEUMrSd9sDy9JTijWna8YR6Lnq
         DSPsJYhyKDvQokttgibDqVJLwj31zrpfcr33pk7ljaGWGoQuqKGa9feAxgVrKpATMtZr
         aGGDI/SFng/HTIuHBjdTIWKBpKFGJLamDTgSfVcs1HG1SaXPbwdgeJoCeJZfCtdZeKot
         489+zwh3vYASa6PpgpC+7a02pzOnveXW5MAl1bZ5lnjL3CVFhp6w/Up9K7xLrAG9K+Tk
         ahNJ9zOoxmQ4PjzeI6dTSswrsTxFBxJKbhdjRB73hTzjWDd/avQ8JDaTHxlqD1j5aNcL
         58yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767401133; x=1768005933;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=vUye211JIBiRnZQOddGEfx1ZXqYyficSfLxDXccUr6A=;
        b=WceKQyUNMKasPIEveqFcj0jeebm3g6moT6POQ2409RRjMtRDQcl5VaW+8zQ2gmK6nm
         8T4pqtUhx9wLUsa3U8hsFc5Z3+LEzh8jxbKKm8AogLU5AoR5U//9yTErWY7J/WK0Umbj
         CG9jJTtqUNbQXlSRkNYKZmU+pTPHJSQv4DokJgJFY3c1WeL5W3qKZPdgyOY4An0qOpeP
         DRJHtDrNdAsHIKa0m9CPDU6gRFQrrSjgC9kaWmgja7YZQwBl19HTgovj2vqecjfIjaxd
         X0q9dt/VjpFqlSlU7yTT/bYk/MZxKWbS/fCAWmTm5FZr9CxKJautRjJCmZs7+jHm22K0
         Er/Q==
X-Gm-Message-State: AOJu0YzrlRJZGAEUMK31kK6O6mWMfDBuMBMuuhmWwMXw9gT9aqUaRydn
	0KqJD4305WWytXcpVhvDgJ47Waf4hT6xTP7mZIimFduxYpcBufY6lq6+os6CGiRrGfN+l2Q1Xf6
	zsboTu1ZPPNtwrvwz6MbjvasJ8urHeIjRrow0iN/WT4D43eAdIl/V
X-Gm-Gg: AY/fxX5LmhQ2XKv9bfX2ML5mDniWjl/TpyNz4rza3BDlHcByXRFDqCAqpYomiwOJ5pY
	YIAx91cFpcGbNRJSKcyHo1N6TB1E7kBav7ZHSjXcNmdNv7jrJLEoHgRVzCkOY4ljFNCehTAUddK
	ykDHCdBh4W6GPUryrwcPzwh2zYWUHYiwE1VLLjfM/A4+HxRkl8icndwRrLZjCmlVWDqeWakHKs5
	wddsg4EW145FTMefep+oa5fnqxTjl+MmN4xM54A2A1MQKR/UvYpgUbHB8nCRWq8ZUv7Jpn4G2zN
	thlPjPqxv464QKsbCwO9P+1x39GeN1aJTIHCWtsXRgWkBA/z4syXSTBn580x4wfBUmDOo1tLHzQ
	+xGmS00czPiylQrQXN2XedYQ0Jvg=
X-Google-Smtp-Source: AGHT+IF6PH7wb7P58P06jGSyp4LJxTipfWWCGV1r7JBSKpNx8MXPlVVNEe1WWVX2jKZazQFR2kjMF+hFmvhM
X-Received: by 2002:a05:690e:dcf:b0:646:5127:9cfc with SMTP id 956f58d0204a3-6466a872017mr28609377d50.2.1767401133249;
        Fri, 02 Jan 2026 16:45:33 -0800 (PST)
Received: from c7-smtp-2023.dev.purestorage.com ([2620:125:9017:12:36:3:5:0])
        by smtp-relay.gmail.com with ESMTPS id 00721157ae682-78fb451ba6csm20083417b3.25.2026.01.02.16.45.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Jan 2026 16:45:33 -0800 (PST)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (dev-csander.dev.purestorage.com [10.49.34.222])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id 5F408341D2E;
	Fri,  2 Jan 2026 17:45:32 -0700 (MST)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id 5CCAAE43D1D; Fri,  2 Jan 2026 17:45:32 -0700 (MST)
From: Caleb Sander Mateos <csander@purestorage.com>
To: Ming Lei <ming.lei@redhat.com>,
	Jens Axboe <axboe@kernel.dk>,
	Shuah Khan <shuah@kernel.org>
Cc: linux-block@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Stanley Zhang <stazhang@purestorage.com>,
	Uday Shankar <ushankar@purestorage.com>,
	Caleb Sander Mateos <csander@purestorage.com>
Subject: [PATCH v2 03/19] ublk: support UBLK_PARAM_TYPE_INTEGRITY in device creation
Date: Fri,  2 Jan 2026 17:45:13 -0700
Message-ID: <20260103004529.1582405-4-csander@purestorage.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20260103004529.1582405-1-csander@purestorage.com>
References: <20260103004529.1582405-1-csander@purestorage.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Stanley Zhang <stazhang@purestorage.com>

Add a feature flag UBLK_F_INTEGRITY for a ublk server to request
integrity/metadata support when creating a ublk device. The ublk server
can also check for the feature flag on the created device or the result
of UBLK_U_CMD_GET_FEATURES to tell if the ublk driver supports it.
UBLK_F_INTEGRITY requires UBLK_F_USER_COPY, as user copy is the only
data copy mode initially supported for integrity data.
Add UBLK_PARAM_TYPE_INTEGRITY and struct ublk_param_integrity to struct
ublk_params to specify the integrity params of a ublk device.
UBLK_PARAM_TYPE_INTEGRITY requires UBLK_F_INTEGRITY and a nonzero
metadata_size. The LBMD_PI_CAP_* and LBMD_PI_CSUM_* values from the
linux/fs.h UAPI header are used for the flags and csum_type fields.
If the UBLK_PARAM_TYPE_INTEGRITY flag is set, validate the integrity
parameters and apply them to the blk_integrity limits.
The struct ublk_param_integrity validations are based on the checks in
blk_validate_integrity_limits(). Any invalid parameters should be
rejected before being applied to struct blk_integrity.

Signed-off-by: Stanley Zhang <stazhang@purestorage.com>
[csander: drop redundant pi_tuple_size field, use block metadata UAPI
 constants, add param validation]
Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
---
 drivers/block/ublk_drv.c      | 94 ++++++++++++++++++++++++++++++++++-
 include/uapi/linux/ublk_cmd.h | 18 +++++++
 2 files changed, 111 insertions(+), 1 deletion(-)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index 8e3da9b2b93a..2f9316febf83 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -42,10 +42,12 @@
 #include <linux/mm.h>
 #include <asm/page.h>
 #include <linux/task_work.h>
 #include <linux/namei.h>
 #include <linux/kref.h>
+#include <linux/blk-integrity.h>
+#include <uapi/linux/fs.h>
 #include <uapi/linux/ublk_cmd.h>
 
 #define UBLK_MINORS		(1U << MINORBITS)
 
 #define UBLK_INVALID_BUF_IDX 	((u16)-1)
@@ -81,11 +83,12 @@
 
 /* All UBLK_PARAM_TYPE_* should be included here */
 #define UBLK_PARAM_TYPE_ALL                                \
 	(UBLK_PARAM_TYPE_BASIC | UBLK_PARAM_TYPE_DISCARD | \
 	 UBLK_PARAM_TYPE_DEVT | UBLK_PARAM_TYPE_ZONED |    \
-	 UBLK_PARAM_TYPE_DMA_ALIGN | UBLK_PARAM_TYPE_SEGMENT)
+	 UBLK_PARAM_TYPE_DMA_ALIGN | UBLK_PARAM_TYPE_SEGMENT | \
+	 UBLK_PARAM_TYPE_INTEGRITY)
 
 struct ublk_uring_cmd_pdu {
 	/*
 	 * Store requests in same batch temporarily for queuing them to
 	 * daemon context.
@@ -628,10 +631,57 @@ static void ublk_dev_param_basic_apply(struct ublk_device *ub)
 		set_disk_ro(ub->ub_disk, true);
 
 	set_capacity(ub->ub_disk, p->dev_sectors);
 }
 
+static int ublk_integrity_flags(u32 flags)
+{
+	int ret_flags = 0;
+
+	if (flags & LBMD_PI_CAP_INTEGRITY) {
+		flags &= ~LBMD_PI_CAP_INTEGRITY;
+		ret_flags |= BLK_INTEGRITY_DEVICE_CAPABLE;
+	}
+	if (flags & LBMD_PI_CAP_REFTAG) {
+		flags &= ~LBMD_PI_CAP_REFTAG;
+		ret_flags |= BLK_INTEGRITY_REF_TAG;
+	}
+	return flags ? -EINVAL : ret_flags;
+}
+
+static int ublk_integrity_pi_tuple_size(u8 csum_type)
+{
+	switch (csum_type) {
+	case LBMD_PI_CSUM_NONE:
+		return 0;
+	case LBMD_PI_CSUM_IP:
+	case LBMD_PI_CSUM_CRC16_T10DIF:
+		return 8;
+	case LBMD_PI_CSUM_CRC64_NVME:
+		return 16;
+	default:
+		return -EINVAL;
+	}
+}
+
+static enum blk_integrity_checksum ublk_integrity_csum_type(u8 csum_type)
+{
+	switch (csum_type) {
+	case LBMD_PI_CSUM_NONE:
+		return BLK_INTEGRITY_CSUM_NONE;
+	case LBMD_PI_CSUM_IP:
+		return BLK_INTEGRITY_CSUM_IP;
+	case LBMD_PI_CSUM_CRC16_T10DIF:
+		return BLK_INTEGRITY_CSUM_CRC;
+	case LBMD_PI_CSUM_CRC64_NVME:
+		return BLK_INTEGRITY_CSUM_CRC64;
+	default:
+		WARN_ON_ONCE(1);
+		return BLK_INTEGRITY_CSUM_NONE;
+	}
+}
+
 static int ublk_validate_params(const struct ublk_device *ub)
 {
 	/* basic param is the only one which must be set */
 	if (ub->params.types & UBLK_PARAM_TYPE_BASIC) {
 		const struct ublk_param_basic *p = &ub->params.basic;
@@ -690,10 +740,33 @@ static int ublk_validate_params(const struct ublk_device *ub)
 			return -EINVAL;
 		if (p->max_segment_size < UBLK_MIN_SEGMENT_SIZE)
 			return -EINVAL;
 	}
 
+	if (ub->params.types & UBLK_PARAM_TYPE_INTEGRITY) {
+		const struct ublk_param_integrity *p = &ub->params.integrity;
+		int pi_tuple_size = ublk_integrity_pi_tuple_size(p->csum_type);
+		int flags = ublk_integrity_flags(p->flags);
+
+		if (!(ub->dev_info.flags & UBLK_F_INTEGRITY))
+			return -EINVAL;
+		if (flags < 0)
+			return flags;
+		if (pi_tuple_size < 0)
+			return pi_tuple_size;
+		if (!p->metadata_size)
+			return -EINVAL;
+		if (p->csum_type == LBMD_PI_CSUM_NONE &&
+		    (p->flags & LBMD_PI_CAP_REFTAG))
+			return -EINVAL;
+		if (p->pi_offset + pi_tuple_size > p->metadata_size)
+			return -EINVAL;
+		if (p->interval_exp < SECTOR_SHIFT ||
+		    p->interval_exp > ub->params.basic.logical_bs_shift)
+			return -EINVAL;
+	}
+
 	return 0;
 }
 
 static void ublk_apply_params(struct ublk_device *ub)
 {
@@ -2941,10 +3014,25 @@ static int ublk_ctrl_start_dev(struct ublk_device *ub,
 		lim.seg_boundary_mask = ub->params.seg.seg_boundary_mask;
 		lim.max_segment_size = ub->params.seg.max_segment_size;
 		lim.max_segments = ub->params.seg.max_segments;
 	}
 
+	if (ub->params.types & UBLK_PARAM_TYPE_INTEGRITY) {
+		const struct ublk_param_integrity *p = &ub->params.integrity;
+		int pi_tuple_size = ublk_integrity_pi_tuple_size(p->csum_type);
+
+		lim.integrity = (struct blk_integrity) {
+			.flags = ublk_integrity_flags(p->flags),
+			.csum_type = ublk_integrity_csum_type(p->csum_type),
+			.metadata_size = p->metadata_size,
+			.pi_offset = p->pi_offset,
+			.interval_exp = p->interval_exp,
+			.tag_size = p->tag_size,
+			.pi_tuple_size = pi_tuple_size,
+		};
+	}
+
 	if (wait_for_completion_interruptible(&ub->completion) != 0)
 		return -EINTR;
 
 	if (ub->ublksrv_tgid != ublksrv_pid)
 		return -EINVAL;
@@ -3131,10 +3219,14 @@ static int ublk_ctrl_add_dev(const struct ublksrv_ctrl_cmd *header)
 		if (info.flags & (UBLK_F_USER_COPY | UBLK_F_SUPPORT_ZERO_COPY |
 					UBLK_F_AUTO_BUF_REG))
 			return -EINVAL;
 	}
 
+	/* User copy is required to access integrity buffer */
+	if (info.flags & UBLK_F_INTEGRITY && !(info.flags & UBLK_F_USER_COPY))
+		return -EINVAL;
+
 	/* the created device is always owned by current user */
 	ublk_store_owner_uid_gid(&info.owner_uid, &info.owner_gid);
 
 	if (header->dev_id != info.dev_id) {
 		pr_warn("%s: dev id not match %u %u\n",
diff --git a/include/uapi/linux/ublk_cmd.h b/include/uapi/linux/ublk_cmd.h
index ec77dabba45b..a54c47832fa2 100644
--- a/include/uapi/linux/ublk_cmd.h
+++ b/include/uapi/linux/ublk_cmd.h
@@ -309,10 +309,16 @@
  * the I/O's daemon task. The q_id and tag of the registered buffer are required
  * in UBLK_U_IO_UNREGISTER_IO_BUF's ublksrv_io_cmd.
  */
 #define UBLK_F_BUF_REG_OFF_DAEMON (1ULL << 14)
 
+/*
+ * ublk device supports requests with integrity/metadata buffer.
+ * Requires UBLK_F_USER_COPY.
+ */
+#define UBLK_F_INTEGRITY (1ULL << 16)
+
 /* device state */
 #define UBLK_S_DEV_DEAD	0
 #define UBLK_S_DEV_LIVE	1
 #define UBLK_S_DEV_QUIESCED	2
 #define UBLK_S_DEV_FAIL_IO 	3
@@ -598,10 +604,20 @@ struct ublk_param_segment {
 	__u32 	max_segment_size;
 	__u16 	max_segments;
 	__u8	pad[2];
 };
 
+struct ublk_param_integrity {
+	__u32	flags; /* LBMD_PI_CAP_* from linux/fs.h */
+	__u8	interval_exp;
+	__u8	metadata_size; /* UBLK_PARAM_TYPE_INTEGRITY requires nonzero */
+	__u8	pi_offset;
+	__u8	csum_type; /* LBMD_PI_CSUM_* from linux/fs.h */
+	__u8	tag_size;
+	__u8	pad[7];
+};
+
 struct ublk_params {
 	/*
 	 * Total length of parameters, userspace has to set 'len' for both
 	 * SET_PARAMS and GET_PARAMS command, and driver may update len
 	 * if two sides use different version of 'ublk_params', same with
@@ -612,16 +628,18 @@ struct ublk_params {
 #define UBLK_PARAM_TYPE_DISCARD         (1 << 1)
 #define UBLK_PARAM_TYPE_DEVT            (1 << 2)
 #define UBLK_PARAM_TYPE_ZONED           (1 << 3)
 #define UBLK_PARAM_TYPE_DMA_ALIGN       (1 << 4)
 #define UBLK_PARAM_TYPE_SEGMENT         (1 << 5)
+#define UBLK_PARAM_TYPE_INTEGRITY       (1 << 6) /* requires UBLK_F_INTEGRITY */
 	__u32	types;			/* types of parameter included */
 
 	struct ublk_param_basic		basic;
 	struct ublk_param_discard	discard;
 	struct ublk_param_devt		devt;
 	struct ublk_param_zoned	zoned;
 	struct ublk_param_dma_align	dma;
 	struct ublk_param_segment	seg;
+	struct ublk_param_integrity	integrity;
 };
 
 #endif
-- 
2.45.2

