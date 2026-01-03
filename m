Received: from mail-pl1-f227.google.com (mail-pl1-f227.google.com [209.85.214.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47E2D2522A7
	for <linux-block@vger.kernel.org>; Sat,  3 Jan 2026 00:45:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767401143; cv=none; b=NX5esCxreWGtdG6ZsLWF/GXqNblQFNiCeV09hY8r31eZX+3AEOzhB928BYd1nk3DqSw8S+mmfSwE8BJ9NtI16IHZepMGaFQEd9CBoDK7Fgjhv1LPJRJDRxplPiJQaztCG3gnqJ39ST37zp6qpM8Lh2p1yOUVIWQeqTlnY/2cfS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767401143; c=relaxed/simple;
	bh=IPYY2wbBuXA+AcMOcnbpgxkjyrfpEhzCMqJgIVN4z+k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ctMYH2FpItE3P6QOg7ZQ76rVsISm8QeRK39yJReoDC6kXhL640rS7IRF/ik02wAuNW1ZNyCYKxhbx++zPJe9w82FSCAiETG17hi2CT3BHMCvlbsmLZiPYKBehBaw8ghWXK34uqVNvmXfUaW3qKc5Tl89on66OZCtjFhSvKIJc6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=VMa2pHWY; arc=none smtp.client-ip=209.85.214.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="VMa2pHWY"
Received: by mail-pl1-f227.google.com with SMTP id d9443c01a7336-2a0f3d2e503so23533475ad.3
        for <linux-block@vger.kernel.org>; Fri, 02 Jan 2026 16:45:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1767401136; x=1768005936; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NX8hqML+byNHp2sVVzUNGB3O5iFG2jebjBWHWIKuGfk=;
        b=VMa2pHWYJ/53JYvsbEUFjJFCmyVeDe/IaCD5kfgi6oOJgUywj0WOXUuve+Jhpca7HE
         hXbBhs6URsmCNjZSW/fVB2uW3jwQEc2v7fgm4O/tRrD2fby/WKmN1+anWotpg4YdSPtB
         EMRIs0opsPswtgEFVSUy1l49OUs2tFGxPgmAtKphJjFDHwChGSfP70o6U3L+Ak1ADPt3
         YMK9cU8/pIpsUHxvjpsqHlprQJoSLkG5x71m0S/mFX4MWTqW4fZYdQQYdZ6mmaQXoaX5
         OhcAbFR7uUMjySMsw6RmaTZ/+bDen9ZD/K113JsGPSdFLtom+dwMoAB9yIHWi+s/UieN
         SL/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767401136; x=1768005936;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=NX8hqML+byNHp2sVVzUNGB3O5iFG2jebjBWHWIKuGfk=;
        b=tQ7jIg17ab8NmL6Pj+BaboejVnexFMw8BJemMtD0s9yc2ejQ8u1Lqh3yxnwFPUUeA/
         sVWrpCvekHcUPAuGWpPOzmy8uCUkkzmJPVEz8XtkXubPFeEqvWQCy/pBr5yxChuB8TsF
         xlgWY6TXiHN4m6/m5OVMO7J6oHOjfv0DMEWNMHO9DmlMYKT0+8D9gRsSDR/8X/8s2S0d
         +C37QzqYTIgpc+Yj5GG0OpmFmkPKVESg4quUufzz7hR6Hd5j86UNK2vj2Qi96QpyvtS+
         bKCTmjJlzI5EB+h0832An17nMcPrTQTYZApUaRvTHIzKvjrAViQFD8RgdUvTodcVPWdw
         6AEQ==
X-Gm-Message-State: AOJu0YyF6Ra4oZcWuRP44nyXFkc9fIf1EyIZomSL+0vZb4LOrNf4KZua
	ezHAv6FNQ/Uh9YjACtjIrDNwXbFT/g89FbFbchSBHzNNqIpWJItIFtwKnyUWjkOrGq3E/6DNkbw
	rUAGfMc4p3y9MiT2lFV/6CD7+iIztxIk3I8ZK
X-Gm-Gg: AY/fxX7L7y6s4zeuK2n3HacP4V8jk2A796glManzVjiIcxTgokIGncDxHQ4uUNf7Oq/
	+5ulrIAAQ5p5a+tAAT/df+5+3EMQsIZ2bMr93wWRSqhYjntKMpGm21Q2NFsY/uA+nnI8OqQ9n0G
	SL9g62X8g5vHcrLlTD/lC1x9B2zj7W76P2Y+JG1us10t0s1MSYFMH8BawA0WQ4h4d9wiXfrQzfx
	f6oTvn/sXx5dJIKN56UzX4hDed353MZuv9wr9dSC0mdQX/9iet4wTtlYb0EEwZdQAnoIcV5wGhY
	oGvI/zRlDDNaVtlRiaxiuR2qDXcj4K4U0srXxg+d7F/ad/JRbbwuM3ux9fC+A7KhKdMUaeJNWxf
	ani+6q+pvzX78LF2ze7ASPEJy20QxKQPaJk5mx6lfXA==
X-Google-Smtp-Source: AGHT+IGFp1rfzMZd54gQEwvR6JR/KMIfQSjHvp//5kWVIwoBUSWm6YqEABbH/jnQwcJteCU0TCgSQiFmBw9r
X-Received: by 2002:a05:6a20:486:b0:366:5c4a:c482 with SMTP id adf61e73a8af0-376aca60577mr30292837637.8.1767401135928;
        Fri, 02 Jan 2026 16:45:35 -0800 (PST)
Received: from c7-smtp-2023.dev.purestorage.com ([208.88.159.129])
        by smtp-relay.gmail.com with ESMTPS id 41be03b00d2f7-c1e7bf52e1csm2459238a12.13.2026.01.02.16.45.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Jan 2026 16:45:35 -0800 (PST)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (dev-csander.dev.purestorage.com [10.49.34.222])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id 5E94E341D2E;
	Fri,  2 Jan 2026 17:45:35 -0700 (MST)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id 55ADDE43D1D; Fri,  2 Jan 2026 17:45:34 -0700 (MST)
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
Subject: [PATCH v2 14/19] selftests: ublk: add kublk support for integrity params
Date: Fri,  2 Jan 2026 17:45:24 -0700
Message-ID: <20260103004529.1582405-15-csander@purestorage.com>
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

Add integrity param command line arguments to kublk. Plumb these to
struct ublk_params for the null and fault_inject targets, as they don't
need to actually read or write the integrity data. Forbid the integrity
params for loop or stripe until the integrity data copy is implemented.

Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
---
 tools/testing/selftests/ublk/fault_inject.c |  1 +
 tools/testing/selftests/ublk/file_backed.c  |  4 ++
 tools/testing/selftests/ublk/kublk.c        | 48 +++++++++++++++++++++
 tools/testing/selftests/ublk/kublk.h        | 21 +++++++++
 tools/testing/selftests/ublk/null.c         |  1 +
 tools/testing/selftests/ublk/stripe.c       |  4 ++
 6 files changed, 79 insertions(+)

diff --git a/tools/testing/selftests/ublk/fault_inject.c b/tools/testing/selftests/ublk/fault_inject.c
index b227bd78b252..3b897f69c014 100644
--- a/tools/testing/selftests/ublk/fault_inject.c
+++ b/tools/testing/selftests/ublk/fault_inject.c
@@ -31,10 +31,11 @@ static int ublk_fault_inject_tgt_init(const struct dev_ctx *ctx,
 			.io_min_shift		= 9,
 			.max_sectors		= info->max_io_buf_bytes >> 9,
 			.dev_sectors		= dev_size >> 9,
 		},
 	};
+	ublk_set_integrity_params(ctx, &dev->tgt.params);
 
 	dev->private_data = (void *)(unsigned long)(ctx->fault_inject.delay_us * 1000);
 	return 0;
 }
 
diff --git a/tools/testing/selftests/ublk/file_backed.c b/tools/testing/selftests/ublk/file_backed.c
index 269d5f124e06..c14ce6608696 100644
--- a/tools/testing/selftests/ublk/file_backed.c
+++ b/tools/testing/selftests/ublk/file_backed.c
@@ -156,10 +156,14 @@ static int ublk_loop_tgt_init(const struct dev_ctx *ctx, struct ublk_dev *dev)
 
 	if (ctx->auto_zc_fallback) {
 		ublk_err("%s: not support auto_zc_fallback\n", __func__);
 		return -EINVAL;
 	}
+	if (ctx->metadata_size) {
+		ublk_err("%s: integrity not supported\n", __func__);
+		return -EINVAL;
+	}
 
 	ret = backing_file_tgt_init(dev);
 	if (ret)
 		return ret;
 
diff --git a/tools/testing/selftests/ublk/kublk.c b/tools/testing/selftests/ublk/kublk.c
index 261095f19c93..6ff110d0dcae 100644
--- a/tools/testing/selftests/ublk/kublk.c
+++ b/tools/testing/selftests/ublk/kublk.c
@@ -1,10 +1,12 @@
 /* SPDX-License-Identifier: MIT */
 /*
  * Description: uring_cmd based ublk
  */
 
+#include "linux/ublk_cmd.h"
+#include <linux/fs.h>
 #include "kublk.h"
 
 #define MAX_NR_TGT_ARG 	64
 
 unsigned int ublk_dbg_mask = UBLK_LOG;
@@ -1548,10 +1550,12 @@ static void __cmd_create_help(char *exe, bool recovery)
 	printf("%s %s -t [null|loop|stripe|fault_inject] [-q nr_queues] [-d depth] [-n dev_id]\n",
 			exe, recovery ? "recover" : "add");
 	printf("\t[--foreground] [--quiet] [-z] [--auto_zc] [--auto_zc_fallback] [--debug_mask mask] [-r 0|1] [-g] [-u]\n");
 	printf("\t[-e 0|1 ] [-i 0|1] [--no_ublk_fixed_fd]\n");
 	printf("\t[--nthreads threads] [--per_io_tasks]\n");
+	printf("\t[--integrity_capable] [--integrity_reftag] [--metadata_size SIZE] "
+		 "[--pi_offset OFFSET] [--csum_type ip|t10dif|nvme] [--tag_size SIZE]\n");
 	printf("\t[target options] [backfile1] [backfile2] ...\n");
 	printf("\tdefault: nr_queues=2(max 32), depth=128(max 1024), dev_id=-1(auto allocation)\n");
 	printf("\tdefault: nthreads=nr_queues");
 
 	for (i = 0; i < ARRAY_SIZE(tgt_ops_list); i++) {
@@ -1611,20 +1615,27 @@ int main(int argc, char *argv[])
 		{ "user_copy",		0,	NULL, 'u'},
 		{ "size",		1,	NULL, 's'},
 		{ "nthreads",		1,	NULL,  0 },
 		{ "per_io_tasks",	0,	NULL,  0 },
 		{ "no_ublk_fixed_fd",	0,	NULL,  0 },
+		{ "integrity_capable",	0,	NULL,  0 },
+		{ "integrity_reftag",	0,	NULL,  0 },
+		{ "metadata_size",	1,	NULL,  0 },
+		{ "pi_offset",		1,	NULL,  0 },
+		{ "csum_type",		1,	NULL,  0 },
+		{ "tag_size",		1,	NULL,  0 },
 		{ 0, 0, 0, 0 }
 	};
 	const struct ublk_tgt_ops *ops = NULL;
 	int option_idx, opt;
 	const char *cmd = argv[1];
 	struct dev_ctx ctx = {
 		.queue_depth	=	128,
 		.nr_hw_queues	=	2,
 		.dev_id		=	-1,
 		.tgt_type	=	"unknown",
+		.csum_type	=	LBMD_PI_CSUM_NONE,
 	};
 	int ret = -EINVAL, i;
 	int tgt_argc = 1;
 	char *tgt_argv[MAX_NR_TGT_ARG] = { NULL };
 	int value;
@@ -1695,10 +1706,32 @@ int main(int argc, char *argv[])
 				ctx.nthreads = strtol(optarg, NULL, 10);
 			if (!strcmp(longopts[option_idx].name, "per_io_tasks"))
 				ctx.per_io_tasks = 1;
 			if (!strcmp(longopts[option_idx].name, "no_ublk_fixed_fd"))
 				ctx.no_ublk_fixed_fd = 1;
+			if (!strcmp(longopts[option_idx].name, "integrity_capable"))
+				ctx.integrity_flags |= LBMD_PI_CAP_INTEGRITY;
+			if (!strcmp(longopts[option_idx].name, "integrity_reftag"))
+				ctx.integrity_flags |= LBMD_PI_CAP_REFTAG;
+			if (!strcmp(longopts[option_idx].name, "metadata_size"))
+				ctx.metadata_size = strtoul(optarg, NULL, 0);
+			if (!strcmp(longopts[option_idx].name, "pi_offset"))
+				ctx.pi_offset = strtoul(optarg, NULL, 0);
+			if (!strcmp(longopts[option_idx].name, "csum_type")) {
+				if (!strcmp(optarg, "ip")) {
+					ctx.csum_type = LBMD_PI_CSUM_IP;
+				} else if (!strcmp(optarg, "t10dif")) {
+					ctx.csum_type = LBMD_PI_CSUM_CRC16_T10DIF;
+				} else if (!strcmp(optarg, "nvme")) {
+					ctx.csum_type = LBMD_PI_CSUM_CRC64_NVME;
+				} else {
+					ublk_err("invalid csum_type: %s\n", optarg);
+					return -EINVAL;
+				}
+			}
+			if (!strcmp(longopts[option_idx].name, "tag_size"))
+				ctx.tag_size = strtoul(optarg, NULL, 0);
 			break;
 		case '?':
 			/*
 			 * target requires every option must have argument
 			 */
@@ -1737,10 +1770,25 @@ int main(int argc, char *argv[])
 	    ctx.auto_zc_fallback > 1) {
 		fprintf(stderr, "too many data copy modes specified\n");
 		return -EINVAL;
 	}
 
+	if (ctx.metadata_size) {
+		if (!(ctx.flags & UBLK_F_USER_COPY)) {
+			ublk_err("integrity requires user_copy\n");
+			return -EINVAL;
+		}
+
+		ctx.flags |= UBLK_F_INTEGRITY;
+	} else if (ctx.integrity_flags ||
+		   ctx.pi_offset ||
+		   ctx.csum_type != LBMD_PI_CSUM_NONE ||
+		   ctx.tag_size) {
+		ublk_err("integrity parameters require metadata_size\n");
+		return -EINVAL;
+	}
+
 	i = optind;
 	while (i < argc && ctx.nr_files < MAX_BACK_FILES) {
 		ctx.files[ctx.nr_files++] = argv[i++];
 	}
 
diff --git a/tools/testing/selftests/ublk/kublk.h b/tools/testing/selftests/ublk/kublk.h
index 8a83b90ec603..d00f2b465cdf 100644
--- a/tools/testing/selftests/ublk/kublk.h
+++ b/tools/testing/selftests/ublk/kublk.h
@@ -76,10 +76,15 @@ struct dev_ctx {
 	unsigned int	fg:1;
 	unsigned int	recovery:1;
 	unsigned int	auto_zc_fallback:1;
 	unsigned int	per_io_tasks:1;
 	unsigned int	no_ublk_fixed_fd:1;
+	__u32 integrity_flags;
+	__u8 metadata_size;
+	__u8 pi_offset;
+	__u8 csum_type;
+	__u8 tag_size;
 
 	int _evtfd;
 	int _shmid;
 
 	/* built from shmem, only for ublk_dump_dev() */
@@ -200,10 +205,26 @@ struct ublk_dev {
 	void *private_data;
 };
 
 extern int ublk_queue_io_cmd(struct ublk_thread *t, struct ublk_io *io);
 
+static inline void ublk_set_integrity_params(const struct dev_ctx *ctx,
+					     struct ublk_params *params)
+{
+	if (!ctx->metadata_size)
+		return;
+
+	params->types |= UBLK_PARAM_TYPE_INTEGRITY;
+	params->integrity = (struct ublk_param_integrity) {
+		.flags = ctx->integrity_flags,
+		.interval_exp = params->basic.logical_bs_shift,
+		.metadata_size = ctx->metadata_size,
+		.pi_offset = ctx->pi_offset,
+		.csum_type = ctx->csum_type,
+		.tag_size = ctx->tag_size,
+	};
+}
 
 static inline int ublk_io_auto_zc_fallback(const struct ublksrv_io_desc *iod)
 {
 	return !!(iod->op_flags & UBLK_IO_F_NEED_REG_BUF);
 }
diff --git a/tools/testing/selftests/ublk/null.c b/tools/testing/selftests/ublk/null.c
index 280043f6b689..3aa162f08476 100644
--- a/tools/testing/selftests/ublk/null.c
+++ b/tools/testing/selftests/ublk/null.c
@@ -34,10 +34,11 @@ static int ublk_null_tgt_init(const struct dev_ctx *ctx, struct ublk_dev *dev)
 			.seg_boundary_mask 	= 4095,
 			.max_segment_size 	= 32 << 10,
 			.max_segments 		= 32,
 		},
 	};
+	ublk_set_integrity_params(ctx, &dev->tgt.params);
 
 	if (info->flags & UBLK_F_SUPPORT_ZERO_COPY)
 		dev->tgt.sq_depth = dev->tgt.cq_depth = 2 * info->queue_depth;
 	return 0;
 }
diff --git a/tools/testing/selftests/ublk/stripe.c b/tools/testing/selftests/ublk/stripe.c
index fd412e1f01c0..d4aaf3351d71 100644
--- a/tools/testing/selftests/ublk/stripe.c
+++ b/tools/testing/selftests/ublk/stripe.c
@@ -296,10 +296,14 @@ static int ublk_stripe_tgt_init(const struct dev_ctx *ctx, struct ublk_dev *dev)
 
 	if (ctx->auto_zc_fallback) {
 		ublk_err("%s: not support auto_zc_fallback\n", __func__);
 		return -EINVAL;
 	}
+	if (ctx->metadata_size) {
+		ublk_err("%s: integrity not supported\n", __func__);
+		return -EINVAL;
+	}
 
 	if ((chunk_size & (chunk_size - 1)) || !chunk_size) {
 		ublk_err("invalid chunk size %u\n", chunk_size);
 		return -EINVAL;
 	}
-- 
2.45.2

