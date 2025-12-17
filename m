Received: from mail-qk1-f228.google.com (mail-qk1-f228.google.com [209.85.222.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55DE1296BA8
	for <linux-block@vger.kernel.org>; Wed, 17 Dec 2025 05:35:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765949720; cv=none; b=f5MteCc5VLP8xWgPbijpTmp8ID8+OTN4veqtcM5ogYRDDWOiA8jVOONlJEqKRCPqQTZcHzN1nn09mlo7qZBbH3kyeLdC/XNmD3LeZO4Mt9wjo5KcaEYxr8SNsGSTJq4vvMfzoca7B//6+oiwHCyDCqE6GNqVM77cvZTfLJywRBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765949720; c=relaxed/simple;
	bh=F2YA9J7kvPe4E9oFSFW6GvS4Z+ZBhkmjxqsgWcqaulc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Mk+0Ett7R5liWln1vqbM7r+mljutIkgPvSB/PbGwzyY/H8C4rtTdOaqk2T8cMbcItOTMNppNamhJ+h6LX7vuWkBzezdpogf4+D8FWYHXerasa2sq+Jw8HM1U10NmIPypYAJrlZCNamAAddwDPBdTxbZcM4r4obTxyvF0PcVs6zQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=ckoZT62C; arc=none smtp.client-ip=209.85.222.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="ckoZT62C"
Received: by mail-qk1-f228.google.com with SMTP id af79cd13be357-8b6691baa33so93170785a.1
        for <linux-block@vger.kernel.org>; Tue, 16 Dec 2025 21:35:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1765949714; x=1766554514; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UWSWrSXKkDNu/tYQwDsjXq4BKtHb+jfeRIxJwmQpDds=;
        b=ckoZT62C5imhl1JpfIfwNsao/dUS3zzswwZM62pRgRpegbnnJ4Jm76lcLK3xeFCzNh
         lXH0dCvjLkvOz4VR41iNp6uSENI3d4KdqQkFayHWE26nn7YZuZCisScRhhFaxF7IKJzG
         dBR+xHnDwmIgRqyAmstgQfy1cevkMIzmivnQrkoShG992F63E1UrYNS+Gjw51fT9CQPT
         WtgWzDLezCFQKPdwtolT6J9Eq/R9nzICAQC2saOuHVGrQa3TGHNrjplQ3YUsiRZs8+c2
         4dYjioSYUigawZBXHPy9csusVZgW+6QRxR/3iC0hZgHIGBSLyWfn/kVEXzfHzNM31WmV
         cJtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765949714; x=1766554514;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=UWSWrSXKkDNu/tYQwDsjXq4BKtHb+jfeRIxJwmQpDds=;
        b=MT2ET8dIg0T/D+8bQM0HB8BDegjm8IOaGCsrH/07ORrvowIsuBsn5mT+MX4VGCWkr2
         A4zB/q0wzM0hO/xTtvfilOg60whtgvnL0f/7jlIpQvt5bMlHuNp3S0PcHgZJLvQzPoxK
         XNrXXVzmk1aaxjeBBlJXVY4NAXL9HnTlqxj8JJXi1e73Zmgo7Rwog+P5A2ORrdUZafnk
         gX6FtdUM8u8bwEkNts9UwdjYmt5XEavdNhs1r4YUyWxDGZ0f7OI1pBsxI+QrDfEAtpoN
         9wzV3ijZUv79JW0fLvB5vGwjqqS3A5B6gtx3FabnWIoChpi9+9Wosaq8ztdNLZUN1tt+
         e3sA==
X-Gm-Message-State: AOJu0YyPLfYq260+wH2YKWuwGBWDTy3vvz20NGaphLzFOc5HyWuZR3Pa
	QqJnjce2kUo5Nw1tg4+9DKeEb/RqZ7j+O2MyfhMbnh7jU0Y+MfnVoelrsh/rc0S4D/8GeIXtXTb
	ywUDLOosr+etai6JB3olwXCLhJqe3vOnhq4+nXz2GFFk5P8wH36+T
X-Gm-Gg: AY/fxX6vJfWnnHRT3w1UOXITfLw/VOgpljhkCyKcHIHpKOXeyz8pLc/4IHuqMTWvJZ5
	nn0BELodr0O4xHjzTVfAIykko9qrgiTq1LifAr3P1JcfuEZCJz7Dc9HA9EaPG/9bT7gG6aHtorR
	67VqHee8HW72aA7zLQ5ZVcb2upnfQlxzcrOaAGochPaVpZ4Z8wQFk8egfEf8dGxgM4/VrtjA6qY
	NtPT8q7wesZdAObdPeTUdLHWGvbSD97cWuHmAHpbJiEPiyxA5DL6m/PMRxZNZtN5u8NCwn6XEFX
	+A+slRoWJJgVWd1Jlw1PVpvGAqn/ow14TZ7NXEGCKfBaEYwObAD0bOhEvbhmZAazH6Gef8Aaqf6
	eq5Qzt5Yw3ZVvjR8xX8D6CqKgA/0=
X-Google-Smtp-Source: AGHT+IF6N23Mpr6lZoIb0Wx4GWzJ8U4AfU5lbCGIzFBNYvixWrE0mTyk2S4zPw+vQE7GQ5HV8VNP6GCqzM4m
X-Received: by 2002:ad4:5bcf:0:b0:880:5222:358 with SMTP id 6a1803df08f44-8887ddc3d4fmr219746936d6.0.1765949714278;
        Tue, 16 Dec 2025 21:35:14 -0800 (PST)
Received: from c7-smtp-2023.dev.purestorage.com ([2620:125:9017:12:36:3:5:0])
        by smtp-relay.gmail.com with ESMTPS id 6a1803df08f44-88a525a8f2csm2530076d6.14.2025.12.16.21.35.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Dec 2025 21:35:14 -0800 (PST)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (unknown [IPv6:2620:125:9007:640:ffff::1199])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id 2A6DE34225F;
	Tue, 16 Dec 2025 22:35:13 -0700 (MST)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id 256BDE41A08; Tue, 16 Dec 2025 22:35:13 -0700 (MST)
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
Subject: [PATCH 15/20] selftests: ublk: add kublk support for integrity params
Date: Tue, 16 Dec 2025 22:34:49 -0700
Message-ID: <20251217053455.281509-16-csander@purestorage.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20251217053455.281509-1-csander@purestorage.com>
References: <20251217053455.281509-1-csander@purestorage.com>
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
 tools/testing/selftests/ublk/kublk.c        | 44 +++++++++++++++++++++
 tools/testing/selftests/ublk/kublk.h        | 21 ++++++++++
 tools/testing/selftests/ublk/null.c         |  1 +
 tools/testing/selftests/ublk/stripe.c       |  4 ++
 6 files changed, 75 insertions(+)

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
index 185ba553686a..cf58d3b60ace 100644
--- a/tools/testing/selftests/ublk/kublk.c
+++ b/tools/testing/selftests/ublk/kublk.c
@@ -1,10 +1,11 @@
 /* SPDX-License-Identifier: MIT */
 /*
  * Description: uring_cmd based ublk
  */
 
+#include <linux/fs.h>
 #include "kublk.h"
 
 #define MAX_NR_TGT_ARG 	64
 
 unsigned int ublk_dbg_mask = UBLK_LOG;
@@ -1547,10 +1548,12 @@ static void __cmd_create_help(char *exe, bool recovery)
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
@@ -1610,20 +1613,27 @@ int main(int argc, char *argv[])
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
@@ -1694,10 +1704,32 @@ int main(int argc, char *argv[])
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
@@ -1736,10 +1768,22 @@ int main(int argc, char *argv[])
 	    ctx.auto_zc_fallback > 1) {
 		fprintf(stderr, "too many data copy modes specified\n");
 		return -EINVAL;
 	}
 
+	if (!ctx.metadata_size && (ctx.integrity_flags ||
+				   ctx.pi_offset ||
+				   ctx.csum_type != LBMD_PI_CSUM_NONE ||
+				   ctx.tag_size)) {
+		ublk_err("integrity parameters require metadata_size\n");
+		return -EINVAL;
+	}
+	if (ctx.metadata_size && !(ctx.flags & UBLK_F_USER_COPY)) {
+		ublk_err("integrity requires user_copy\n");
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

