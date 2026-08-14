Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6390A3D7D74
	for <linux-block@vger.kernel.org>; Fri, 14 Aug 2026 02:33:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786674838; cv=none; b=YzEfsIJauq4O1GvfdSJcmI4Ru3P4EXslo0KWLV5oFd/Ypju5h1PWllnnrXekQLWpb2Qqbe9uiV/kEMnzzKYALXiiBHHXpJ9ZiuhTtJBJ16pqVNpi9Yto6/yuO/B/6hF2r63+KlIA9EX5YvnKdba9dzxXr21jOy9s8gXleEbIaC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786674838; c=relaxed/simple;
	bh=pWTGOQlf3LAiOBW1Ik+PfhD2VXrPoNZYaqVgx7ILkDE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=tfNsRcRUjtBNrEJhzuAiJR6HRupIm7S8iObGX5kUpeH/coCQ6im03EKFjLk+IREtj4G5x0KDf+X3nZoAnpGJEKppUZDBzENSlMi/o6A4OiLFBExJEssbc020URRAGKXrrNXTRTbkzm2zpmN9OQPLG0kzz5WJ1jpV02+Au7b92AI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 9280728a978811f1aa26b74ffac11d73-20260814
X-CTIC-Tags:
	HR_CC_COUNT, HR_CC_DOMAIN_COUNT, HR_CC_NAME, HR_CC_NO_NAME, HR_CTE_8B
	HR_CTT_MISS, HR_DATE_H, HR_DATE_WKD, HR_DATE_ZONE, HR_FROM_NAME
	HR_SJ_DIGIT_LEN, HR_SJ_LANG, HR_SJ_LEN, HR_SJ_LETTER, HR_SJ_NOR_SYM
	HR_SJ_PHRASE, HR_SJ_PHRASE_LEN, HR_SJ_WS, HR_TO_COUNT, HR_TO_DOMAIN_COUNT
	HR_TO_NAME, IP_TRUSTED, SRC_TRUSTED, DN_TRUSTED, SA_TRUSTED
	SA_EXISTED, SN_TRUSTED, SN_EXISTED, SPF_NOPASS, DKIM_NOPASS
	DMARC_NOPASS, CIE_GOOD, CIE_GOOD_SPF, GTI_FG_BS, GTI_RG_INFO
	GTI_C_BU, AMN_GOOD, ABX_MISS_RDNS
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:81d41031-a92c-4139-b2ea-9ac485e2a116,IP:10,
	URL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:10
X-CID-INFO: VERSION:1.3.12,REQID:81d41031-a92c-4139-b2ea-9ac485e2a116,IP:10,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
	elease,TS:10
X-CID-META: VersionHash:e7bac3a,CLOUDID:be1917c449ac12504d16af513a6f978c,BulkI
	D:260814103349SKD28DW1,BulkQuantity:0,Recheck:0,SF:10|66|78|81|82|102|127|
	850|865|898,TC:nil,Content:0|15|50,EDM:-3,IP:-2,URL:0,File:nil,RT:nil,Bulk
	:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,
	BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 9280728a978811f1aa26b74ffac11d73-20260814
X-User: sangyao@kylinos.cn
Received: from localhost.localdomain [(223.70.159.239)] by mailgw.kylinos.cn
	(envelope-from <sangyao@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1286203750; Fri, 14 Aug 2026 10:33:45 +0800
From: Yao Sang <sangyao@kylinos.cn>
To: Ming Lei <tom.leiming@gmail.com>
Cc: Jens Axboe <axboe@kernel.dk>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	linux-block@vger.kernel.org,
	Yao Sang <sangyao@kylinos.cn>
Subject: [PATCH v1 2/3] selftests: ublk: add helper for SET_PARAMS
Date: Fri, 14 Aug 2026 10:32:25 +0800
Message-Id: <20260814023226.354288-3-sangyao@kylinos.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260814023226.354288-1-sangyao@kylinos.cn>
References: <20260814023226.354288-1-sangyao@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The normal kublk add command goes through device startup. It does not
tell the shell test whether a bad parameter is rejected by SET_PARAMS or
later by START_DEV.

Add a set_params command. It creates a temporary ublk device, sends
SET_PARAMS with the command line parameters, returns the ioctl result,
and deletes the device before START_DEV.

Signed-off-by: Yao Sang <sangyao@kylinos.cn>
---
 tools/testing/selftests/ublk/kublk.c | 161 ++++++++++++++++++++++++++-
 tools/testing/selftests/ublk/kublk.h |  18 +++
 2 files changed, 178 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/ublk/kublk.c b/tools/testing/selftests/ublk/kublk.c
index be5a0d775952..2400b4615766 100644
--- a/tools/testing/selftests/ublk/kublk.c
+++ b/tools/testing/selftests/ublk/kublk.c
@@ -8,6 +8,13 @@
 #include "kublk.h"
 
 #define MAX_NR_TGT_ARG 	64
+#define KUBLK_PARAM_LOGICAL_BS_SHIFT		9
+#define KUBLK_PARAM_PHYSICAL_BS_SHIFT		12
+#define KUBLK_PARAM_ZONE_SECTORS		128
+#define KUBLK_PARAM_NR_ZONES			16
+#define KUBLK_PARAM_DEV_SECTORS			\
+	(KUBLK_PARAM_ZONE_SECTORS * KUBLK_PARAM_NR_ZONES)
+#define KUBLK_PARAM_ZONE_APPEND_SECTORS		8
 
 unsigned int ublk_dbg_mask = UBLK_LOG;
 static const struct ublk_tgt_ops *tgt_ops_list[] = {
@@ -227,6 +234,55 @@ static int ublk_ctrl_get_features(struct ublk_dev *dev,
 	return __ublk_ctrl_cmd(dev, &data);
 }
 
+static int parse_param_types(const char *arg, __u32 *types)
+{
+	char buf[128], *save = NULL, *tok;
+
+	if (strlen(arg) >= sizeof(buf))
+		return -EINVAL;
+
+	strcpy(buf, arg);
+	*types = 0;
+	tok = strtok_r(buf, ",", &save);
+	while (tok) {
+		if (!strcmp(tok, "none"))
+			;
+		else if (!strcmp(tok, "basic"))
+			*types |= UBLK_PARAM_TYPE_BASIC;
+		else if (!strcmp(tok, "zoned"))
+			*types |= UBLK_PARAM_TYPE_ZONED;
+		else
+			return -EINVAL;
+		tok = strtok_r(NULL, ",", &save);
+	}
+
+	return 0;
+}
+
+static void ublk_init_params_from_ctx(const struct dev_ctx *ctx,
+				      struct ublk_params *params)
+{
+	const struct params_ctx *p = &ctx->params;
+
+	*params = (struct ublk_params) {
+		.types = p->types,
+		.basic = {
+			.logical_bs_shift	= p->logical_bs_shift,
+			.physical_bs_shift	= p->physical_bs_shift,
+			.io_min_shift		= p->io_min_shift,
+			.io_opt_shift		= p->io_opt_shift,
+			.max_sectors		= p->max_sectors,
+			.chunk_sectors		= p->chunk_sectors,
+			.dev_sectors		= p->dev_sectors,
+		},
+		.zoned = {
+			.max_open_zones		= p->max_open_zones,
+			.max_active_zones	= p->max_active_zones,
+			.max_zone_append_sectors = p->max_zone_append_sectors,
+		},
+	};
+}
+
 static int ublk_ctrl_update_size(struct ublk_dev *dev,
 		__u64 nr_sects)
 {
@@ -1772,6 +1828,51 @@ static int __cmd_dev_add(const struct dev_ctx *ctx)
 
 static int __cmd_dev_list(struct dev_ctx *ctx);
 
+static int cmd_dev_set_params(struct dev_ctx *ctx)
+{
+	struct ublksrv_ctrl_dev_info *info;
+	struct ublk_params params;
+	struct ublk_dev *dev;
+	__u64 features;
+	int ret, del_ret;
+
+	dev = ublk_ctrl_init();
+	if (!dev)
+		return -ENODEV;
+
+	ret = ublk_ctrl_get_features(dev, &features);
+	if (ret < 0)
+		goto out;
+
+	if (!(features & UBLK_F_CMD_IOCTL_ENCODE)) {
+		ret = -ENOTSUP;
+		goto out;
+	}
+
+	info = &dev->dev_info;
+	info->dev_id = ctx->dev_id;
+	info->nr_hw_queues = ctx->nr_hw_queues;
+	info->queue_depth = ctx->queue_depth;
+	info->io_desc_size = ctx->io_desc_size;
+	info->flags = ctx->flags;
+
+	ret = ublk_ctrl_add_dev(dev);
+	if (ret < 0)
+		goto out;
+
+	ublk_init_params_from_ctx(ctx, &params);
+
+	ret = ublk_ctrl_set_params(dev, &params);
+	printf("SET_PARAMS returned %d\n", ret);
+
+	del_ret = ublk_ctrl_del_dev(dev);
+	if (del_ret < 0 && ret == 0)
+		ret = del_ret;
+out:
+	ublk_ctrl_deinit(dev);
+	return ret < 0 ? ret : 0;
+}
+
 static int cmd_dev_add(struct dev_ctx *ctx)
 {
 	int res;
@@ -2117,6 +2218,9 @@ static int cmd_dev_help(char *exe)
 	printf("\t --safe only stop if device has no active openers\n\n");
 	printf("%s list [-n dev_id] -a \n", exe);
 	printf("\t -a list all devices, -n list specified device, default -a \n\n");
+	printf("%s set_params [-n dev_id] [-q nr_queues] [-d depth] [-u] [--zoned]\n", exe);
+	printf("\t[--param_types basic[,zoned]|none]\n");
+	printf("\t issue ADD_DEV, SET_PARAMS and DEL_DEV without START_DEV\n\n");
 	printf("%s features\n", exe);
 	printf("%s update_size -n dev_id -s|--size size_in_bytes \n", exe);
 	printf("%s quiesce -n dev_id\n", exe);
@@ -2160,6 +2264,18 @@ int main(int argc, char *argv[])
 		{ "htlb",		1,	NULL,  0  },
 		{ "rdonly_shmem_buf",	0,	NULL,  0  },
 		{ "io_desc_size",	1,	NULL,  0  },
+		{ "zoned",		0,	NULL,  0  },
+		{ "param_types",	1,	NULL,  0  },
+		{ "logical_bs_shift",	1,	NULL,  0  },
+		{ "physical_bs_shift",	1,	NULL,  0  },
+		{ "io_min_shift",	1,	NULL,  0  },
+		{ "io_opt_shift",	1,	NULL,  0  },
+		{ "max_sectors",	1,	NULL,  0  },
+		{ "chunk_sectors",	1,	NULL,  0  },
+		{ "dev_sectors",	1,	NULL,  0  },
+		{ "max_zone_append_sectors", 1, NULL,  0  },
+		{ "max_open_zones",	1,	NULL,  0  },
+		{ "max_active_zones",	1,	NULL,  0  },
 		{ 0, 0, 0, 0 }
 	};
 	const struct ublk_tgt_ops *ops = NULL;
@@ -2173,6 +2289,19 @@ int main(int argc, char *argv[])
 		.tgt_type	=	"unknown",
 		.csum_type	=	LBMD_PI_CSUM_NONE,
 		.io_desc_size	=	sizeof(struct ublksrv_io_desc),
+		.params = {
+			.types			= UBLK_PARAM_TYPE_BASIC,
+			.logical_bs_shift	= KUBLK_PARAM_LOGICAL_BS_SHIFT,
+			.physical_bs_shift	= KUBLK_PARAM_PHYSICAL_BS_SHIFT,
+			.io_min_shift		= KUBLK_PARAM_LOGICAL_BS_SHIFT,
+			.io_opt_shift		= KUBLK_PARAM_PHYSICAL_BS_SHIFT,
+			.max_sectors		=
+				UBLK_IO_MAX_BYTES >> KUBLK_PARAM_LOGICAL_BS_SHIFT,
+			.chunk_sectors		= KUBLK_PARAM_ZONE_SECTORS,
+			.dev_sectors		= KUBLK_PARAM_DEV_SECTORS,
+			.max_zone_append_sectors =
+				KUBLK_PARAM_ZONE_APPEND_SECTORS,
+		},
 	};
 	int ret = -EINVAL, i;
 	int tgt_argc = 1;
@@ -2288,6 +2417,34 @@ int main(int argc, char *argv[])
 				ctx.flags |= UBLK_F_IO_DESC_SIZE;
 				ctx.io_desc_size = strtoul(optarg, NULL, 0);
 			}
+			if (!strcmp(longopts[option_idx].name, "zoned"))
+				ctx.flags |= UBLK_F_ZONED;
+			if (!strcmp(longopts[option_idx].name, "param_types")) {
+				ret = parse_param_types(optarg, &ctx.params.types);
+				if (ret)
+					return ret;
+			}
+			if (!strcmp(longopts[option_idx].name, "logical_bs_shift"))
+				ctx.params.logical_bs_shift = strtoul(optarg, NULL, 0);
+			if (!strcmp(longopts[option_idx].name, "physical_bs_shift"))
+				ctx.params.physical_bs_shift = strtoul(optarg, NULL, 0);
+			if (!strcmp(longopts[option_idx].name, "io_min_shift"))
+				ctx.params.io_min_shift = strtoul(optarg, NULL, 0);
+			if (!strcmp(longopts[option_idx].name, "io_opt_shift"))
+				ctx.params.io_opt_shift = strtoul(optarg, NULL, 0);
+			if (!strcmp(longopts[option_idx].name, "max_sectors"))
+				ctx.params.max_sectors = strtoul(optarg, NULL, 0);
+			if (!strcmp(longopts[option_idx].name, "chunk_sectors"))
+				ctx.params.chunk_sectors = strtoul(optarg, NULL, 0);
+			if (!strcmp(longopts[option_idx].name, "dev_sectors"))
+				ctx.params.dev_sectors = strtoull(optarg, NULL, 0);
+			if (!strcmp(longopts[option_idx].name, "max_zone_append_sectors"))
+				ctx.params.max_zone_append_sectors =
+					strtoul(optarg, NULL, 0);
+			if (!strcmp(longopts[option_idx].name, "max_open_zones"))
+				ctx.params.max_open_zones = strtoul(optarg, NULL, 0);
+			if (!strcmp(longopts[option_idx].name, "max_active_zones"))
+				ctx.params.max_active_zones = strtoul(optarg, NULL, 0);
 			break;
 		case '?':
 			/*
@@ -2377,7 +2534,9 @@ int main(int argc, char *argv[])
 		ops->parse_cmd_line(&ctx, tgt_argc, tgt_argv);
 	}
 
-	if (!strcmp(cmd, "add"))
+	if (!strcmp(cmd, "set_params"))
+		ret = cmd_dev_set_params(&ctx);
+	else if (!strcmp(cmd, "add"))
 		ret = cmd_dev_add(&ctx);
 	else if (!strcmp(cmd, "recover")) {
 		if (ctx.dev_id < 0) {
diff --git a/tools/testing/selftests/ublk/kublk.h b/tools/testing/selftests/ublk/kublk.h
index e27c154fc910..d98f3d612d88 100644
--- a/tools/testing/selftests/ublk/kublk.h
+++ b/tools/testing/selftests/ublk/kublk.h
@@ -63,6 +63,22 @@ struct fault_inject_ctx {
 	bool die_during_fetch;
 };
 
+struct params_ctx {
+	__u32 types;
+
+	__u32 logical_bs_shift;
+	__u32 physical_bs_shift;
+	__u32 io_min_shift;
+	__u32 io_opt_shift;
+	__u32 max_sectors;
+	__u32 chunk_sectors;
+	__u64 dev_sectors;
+
+	__u32 max_open_zones;
+	__u32 max_active_zones;
+	__u32 max_zone_append_sectors;
+};
+
 struct dev_ctx {
 	char tgt_type[16];
 	unsigned long flags;
@@ -99,6 +115,8 @@ struct dev_ctx {
 	/* for 'update_size' command */
 	unsigned long long size;
 
+	struct params_ctx params;
+
 	char *htlb_path;
 
 	union {
-- 
2.25.1

