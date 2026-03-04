Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C289737B036
	for <linux-block@vger.kernel.org>; Wed,  4 Mar 2026 12:17:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772626662; cv=none; b=eeTlXcIf0j9WyLc5XmBk9S6AZTmNPmNwvXeUejNd/r6u5N7NBg0yYZ469A4uv3jT4ycR06I/cSVf2WxQJBiJh6kNo2p5RduPKtnF7ZDn4qTFWb3MnvqQKNaIxDtqkLpMdceKOC3TcpgOU/gsBufbYpRzAovy1Tjsvgf1Kol36jk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772626662; c=relaxed/simple;
	bh=njh2bthj7lGQKOViJkMsU6uM3q4SBHiy3HpXfN1BycA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=TltSutPwDHmP+cpP0rZ3xqFFlRwDGKr5FEWa3h149b/zwX3DAeU8FocBrydqIwRVxD0X268wGbZbakotj24/xBwj8W84z97/MqcFLOZ4Pb9zyz+UaLvzRl56tvnRUSakc8T4HHOLW3PcdrHDm9vdeGT80P5SjJ4/7W56YSqxM7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=B3D52abH; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=PQ5NosSZ; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="B3D52abH";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="PQ5NosSZ"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6245SeqL3110655
	for <linux-block@vger.kernel.org>; Wed, 4 Mar 2026 12:17:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=PUsU+4Fm1/B
	5TzpCA65Vgoz/dx4A6WK4RfM6wueuLh8=; b=B3D52abHqMNtONXi1OsInS3cW5e
	ZzlUkRV4YuY9ifnnhkQAOT21OEU6/arAFLgLjU0ghw780jLIFWXMqXOqxoWVq/eF
	isYT4AsgpSRVz+geRfIp9BIMp9ebvn3j5MAEjO1m5zQmFvnGXij69pvxTjaiwbpi
	iuR9nM8rtN+0GnOYBCkG0xe3uzWoA+dgxlWPjptdOouSeclglyDwPz+Nnow/zDlp
	mgYQjuy7YA7CnWG0ZmlKhkATe6aqDLV006hd0HnZQi0cDd9NSaiI3+m/k7XJAEtm
	TFmwOMh1FXL5q7NkH8V0iyZed+l0TrVo1Up/Oud/u+XjEQI2oGvOS9f/JTg==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com [74.125.82.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cp5h2b35u-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-block@vger.kernel.org>; Wed, 04 Mar 2026 12:17:40 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id 5a478bee46e88-2b81ff82e3cso3568430eec.0
        for <linux-block@vger.kernel.org>; Wed, 04 Mar 2026 04:17:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1772626659; x=1773231459; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PUsU+4Fm1/B5TzpCA65Vgoz/dx4A6WK4RfM6wueuLh8=;
        b=PQ5NosSZF3F4V9BYDJua9apL/+V74uNf89Fx/I1bwv/a4aimfEjZixht4RuqdCdDNW
         HZIdM4NWaJDtDBO3UyeW4/vFBepHZLi447CskuD0uPOvyQxmLaREyRZ5oFO41bqlx02f
         GRXoD6Cqt6cUxyrm2JV2hUIQCzlguQcESw6BSxX25Bsw49Ej54QLu4Qx6fnf52A6qK3H
         snksfAAfnnc6sLpJ89SB1pqiWDckm2o84+/vk+NsGlhao/jvhsvzHeEKwzEnwzgWbiM1
         E7DA/R5o1Ok3ydnoCVvqoPFM3Bz+DhweTFdicCT5IW0zL9mDe9ApRvIQLy7TSmUFZ8/Q
         okeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772626659; x=1773231459;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=PUsU+4Fm1/B5TzpCA65Vgoz/dx4A6WK4RfM6wueuLh8=;
        b=GrYkI9wj9wpX/+Px2k+w6CCijIfD2on7pjDoqxPX6AWBzh02p7lIziFJhrX2XuP6y1
         W16LGDqARnawlJmotHYBzjK4xotyYzljWAd2udEwMkQez0dtmxD85h2rn76xz0KS8A4r
         Tdf8W1hQ/CesV9H+t4VhYOxeTjbJHhpFIW/Wu8/m6tAOAKyQgBq9ICUX5mrbKGL9yQj3
         CrH9UiN7pkPeL//UPuGdC7pE5MYmGhVt6T2hQqY/coDLD7E50FGASegUsw0yHKVPFKDk
         3gBcZl/iVcVCrgILUvBb/DMPRTuxEdPWdQ84A4pdwBO9tL851E62Z0JCjvzzgXmQjxq9
         UEfw==
X-Gm-Message-State: AOJu0Yxu/1J1BOIIRBFxxi+nyrb+aPqztuXf3D6VfC4qjH/H64l8pmwd
	lCOZBkum9QfEEkf0L/rKFM743QhGR3PWwATZ6MQlJ4dzLpec6Zr8ttnoaBVW2FpaCkevEMNM1yv
	yU/mj9E6mRLXqIfsXeaD4rL29byrjjudAUdJ4uXoLDK88A7gcb0x57IEoEmQ0UVK4GOmXlqc6N0
	Y3
X-Gm-Gg: ATEYQzx+aWSO7g0qjA5NgSSBeNSgqCmuFUp4tEU1KWtg2SsC4kCwiYlJsjlfd8EjnFC
	KqOAXLvHf6gjctk9v3zd2c2maYbMEYNbyYt0D1mwkp8kOJzRPaocX2Tmxa5S+0aYU8f3zT8ZrNP
	lFlov7jJB476GFA2xySyuU2t1cr06nwL0ykuD7s8au4yLKzL2Md/YCFmuMKLgvdneaO0SV4TcR+
	utahyym9GK+UzDDFuvWa1Jo+e/j2xUddHAMwJKAVUOEXR9Ut+a+X0RfT+xithIWFyk5NCQZ/SIK
	T1Mo8b+4P+NNm+Np/MBPDx1Uiza6AmicgpuE3p1w/O35c+FJ2HevPZO4dJW5///RA+WA85Ynjhi
	q7nXzMmEn+jrd6tmf3l2NEke4WKjLKGyN2/0MGLFVd3tZC0tUf6TS2prNkvxqa+gZ3hF3Lhhn/n
	LzwbEM
X-Received: by 2002:a05:7022:608e:b0:127:9cad:f3d5 with SMTP id a92af1059eb24-128b6fa44acmr609765c88.7.1772626658674;
        Wed, 04 Mar 2026 04:17:38 -0800 (PST)
X-Received: by 2002:a05:7022:608e:b0:127:9cad:f3d5 with SMTP id a92af1059eb24-128b6fa44acmr609755c88.7.1772626657961;
        Wed, 04 Mar 2026 04:17:37 -0800 (PST)
Received: from u20-san1p10573.qualcomm.com (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-127899dfc47sm22171276c88.6.2026.03.04.04.17.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2026 04:17:37 -0800 (PST)
From: Linlin Zhang <linlin.zhang@oss.qualcomm.com>
To: linux-block@vger.kernel.org, ebiggers@kernel.org
Cc: linux-kernel@vger.kernel.org, adrianvovk@gmail.com,
        dm-devel@lists.linux.dev, quic_mdalam@quicinc.com, gmazyland@gmail.com,
        israelr@nvidia.com, mpatocka@redhat.com
Subject: [PATCH v1 2/3] dm-inlinecrypt: add target for inline block device encryption
Date: Wed,  4 Mar 2026 04:17:27 -0800
Message-Id: <20260304121729.1532469-3-linlin.zhang@oss.qualcomm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260304121729.1532469-1-linlin.zhang@oss.qualcomm.com>
References: <20260304121729.1532469-1-linlin.zhang@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=JqL8bc4C c=1 sm=1 tr=0 ts=69a822e4 cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=1XWaLZrsAAAA:8
 a=EUspDBNiAAAA:8 a=bWmaV-3qS8QClun7j00A:9 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-ORIG-GUID: C--PW8-jxbQ2ckuFANCsZFHfNPG5y1cp
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA0MDA5NyBTYWx0ZWRfXwkow7zjkvnci
 ZLV/etbTASP7LybhbIlF/2nb28lyJ81V89OOvWPaYSQ0opUe2WElqNdRYzUhms5+NPb933L5so5
 g9PZ+dyiyF8kgx6uPwWd38O8Ngp17WRE0AOZu/TiFelLcwysrKiEMDrpLRrphU8wkX6jz0mdfSd
 MKkEXyFSzCDaETPCvgwtIDj2tDErQOuJP6oIvp00JznLkn5szAQitaRqv6AX5hzxLsyPR2rw+3p
 bUtHLoKTIInbbYTAIMCPizuVMwVn+T/CsJMnWFuBIyC366WHkR3xh6EWpRCTWdWujUSgC/8CDgb
 FXoz0pKbr8e+gKupjohFUobt6cBzgc5vcFLMte9W8SwCsoD0Gn0fYPboe5AQDSNV0yNqHAYC8Tg
 RrMUK6uzo68Tj4JrdyVfNWZfSUZG98w4ZFfPPfG8OxcgePyCqtRKea/V7qdQLaEbyHxHyKGGbvI
 O41gWZrBrgCWyf6OVCw==
X-Proofpoint-GUID: C--PW8-jxbQ2ckuFANCsZFHfNPG5y1cp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-04_05,2026-03-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 priorityscore=1501 lowpriorityscore=0
 clxscore=1011 phishscore=0 spamscore=0 suspectscore=0 malwarescore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2602130000
 definitions=main-2603040097

From: Eric Biggers <ebiggers@google.com>

Add a new device-mapper target "dm-inlinecrypt" that is similar to
dm-crypt but uses the blk-crypto API instead of the regular crypto API.
This allows it to take advantage of inline encryption hardware such as
that commonly built into UFS host controllers.

The table syntax matches dm-crypt's, but for now only a stripped-down
set of parameters is supported.  For example, for now AES-256-XTS is the
only supported cipher.

dm-inlinecrypt is based on Android's dm-default-key with the
controversial passthrough support removed.  Note that due to the removal
of passthrough support, use of dm-inlinecrypt in combination with
fscrypt causes double encryption of file contents (similar to dm-crypt +
fscrypt), with the fscrypt layer not being able to use the inline
encryption hardware.  This makes dm-inlinecrypt unusable on systems such
as Android that use fscrypt and where a more optimized approach is
needed.  It is however suitable as a replacement for dm-crypt.

Signed-off-by: Eric Biggers <ebiggers@google.com>
Signed-off-by: Linlin Zhang <linlin.zhang@oss.qualcomm.com>
---
 drivers/md/Kconfig          |  10 +
 drivers/md/Makefile         |   1 +
 drivers/md/dm-inlinecrypt.c | 416 ++++++++++++++++++++++++++++++++++++
 3 files changed, 427 insertions(+)
 create mode 100644 drivers/md/dm-inlinecrypt.c

diff --git a/drivers/md/Kconfig b/drivers/md/Kconfig
index c58a9a8ea54e..aa541cc22ecc 100644
--- a/drivers/md/Kconfig
+++ b/drivers/md/Kconfig
@@ -313,6 +313,16 @@ config DM_CRYPT
 
 	  If unsure, say N.
 
+config DM_INLINECRYPT
+	tristate "Inline encryption target support"
+	depends on BLK_DEV_DM
+	depends on BLK_INLINE_ENCRYPTION
+	help
+	  This device-mapper target is similar to dm-crypt, but it uses the
+	  blk-crypto API instead of the regular crypto API. This allows it to
+	  take advantage of inline encryption hardware such as that commonly
+	  built into UFS host controllers.
+
 config DM_SNAPSHOT
        tristate "Snapshot target"
        depends on BLK_DEV_DM
diff --git a/drivers/md/Makefile b/drivers/md/Makefile
index c338cc6fbe2e..517d1f7d8288 100644
--- a/drivers/md/Makefile
+++ b/drivers/md/Makefile
@@ -55,6 +55,7 @@ obj-$(CONFIG_DM_UNSTRIPED)	+= dm-unstripe.o
 obj-$(CONFIG_DM_BUFIO)		+= dm-bufio.o
 obj-$(CONFIG_DM_BIO_PRISON)	+= dm-bio-prison.o
 obj-$(CONFIG_DM_CRYPT)		+= dm-crypt.o
+obj-$(CONFIG_DM_INLINECRYPT)	+= dm-inlinecrypt.o
 obj-$(CONFIG_DM_DELAY)		+= dm-delay.o
 obj-$(CONFIG_DM_DUST)		+= dm-dust.o
 obj-$(CONFIG_DM_FLAKEY)		+= dm-flakey.o
diff --git a/drivers/md/dm-inlinecrypt.c b/drivers/md/dm-inlinecrypt.c
new file mode 100644
index 000000000000..251760da9f7e
--- /dev/null
+++ b/drivers/md/dm-inlinecrypt.c
@@ -0,0 +1,416 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright 2024 Google LLC
+ */
+
+#include <linux/blk-crypto.h>
+#include <linux/device-mapper.h>
+#include <linux/hex.h>
+#include <linux/module.h>
+
+#define DM_MSG_PREFIX	"inlinecrypt"
+
+static const struct dm_inlinecrypt_cipher {
+	const char *name;
+	enum blk_crypto_mode_num mode_num;
+	int key_size;
+} dm_inlinecrypt_ciphers[] = {
+	{
+		.name = "aes-xts-plain64",
+		.mode_num = BLK_ENCRYPTION_MODE_AES_256_XTS,
+		.key_size = 64,
+	},
+};
+
+/**
+ * struct inlinecrypt_ctx - private data of an inlinecrypt target
+ * @dev: the underlying device
+ * @start: starting sector of the range of @dev which this target actually maps.
+ *	   For this purpose a "sector" is 512 bytes.
+ * @cipher_string: the name of the encryption algorithm being used
+ * @iv_offset: starting offset for IVs.  IVs are generated as if the target were
+ *	       preceded by @iv_offset 512-byte sectors.
+ * @sector_size: crypto sector size in bytes (usually 4096)
+ * @sector_bits: log2(sector_size)
+ * @key: the encryption key to use
+ * @max_dun: the maximum DUN that may be used (computed from other params)
+ */
+struct inlinecrypt_ctx {
+	struct dm_dev *dev;
+	sector_t start;
+	const char *cipher_string;
+	u64 iv_offset;
+	unsigned int sector_size;
+	unsigned int sector_bits;
+	struct blk_crypto_key key;
+	u64 max_dun;
+};
+
+static const struct dm_inlinecrypt_cipher *
+lookup_cipher(const char *cipher_string)
+{
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(dm_inlinecrypt_ciphers); i++) {
+		if (strcmp(cipher_string, dm_inlinecrypt_ciphers[i].name) == 0)
+			return &dm_inlinecrypt_ciphers[i];
+	}
+	return NULL;
+}
+
+static void inlinecrypt_dtr(struct dm_target *ti)
+{
+	struct inlinecrypt_ctx *ctx = ti->private;
+
+	if (ctx->dev) {
+		if (ctx->key.size)
+			blk_crypto_evict_key(ctx->dev->bdev, &ctx->key);
+		dm_put_device(ti, ctx->dev);
+	}
+	kfree_sensitive(ctx->cipher_string);
+	kfree_sensitive(ctx);
+}
+
+static int inlinecrypt_ctr_optional(struct dm_target *ti,
+				    unsigned int argc, char **argv)
+{
+	struct inlinecrypt_ctx *ctx = ti->private;
+	struct dm_arg_set as;
+	static const struct dm_arg _args[] = {
+		{0, 3, "Invalid number of feature args"},
+	};
+	unsigned int opt_params;
+	const char *opt_string;
+	bool iv_large_sectors = false;
+	char dummy;
+	int err;
+
+	as.argc = argc;
+	as.argv = argv;
+
+	err = dm_read_arg_group(_args, &as, &opt_params, &ti->error);
+	if (err)
+		return err;
+
+	while (opt_params--) {
+		opt_string = dm_shift_arg(&as);
+		if (!opt_string) {
+			ti->error = "Not enough feature arguments";
+			return -EINVAL;
+		}
+		if (!strcmp(opt_string, "allow_discards")) {
+			ti->num_discard_bios = 1;
+		} else if (sscanf(opt_string, "sector_size:%u%c",
+				  &ctx->sector_size, &dummy) == 1) {
+			if (ctx->sector_size < SECTOR_SIZE ||
+			    ctx->sector_size > 4096 ||
+			    !is_power_of_2(ctx->sector_size)) {
+				ti->error = "Invalid sector_size";
+				return -EINVAL;
+			}
+		} else if (!strcmp(opt_string, "iv_large_sectors")) {
+			iv_large_sectors = true;
+		} else {
+			ti->error = "Invalid feature arguments";
+			return -EINVAL;
+		}
+	}
+
+	/* dm-inlinecrypt doesn't implement iv_large_sectors=false. */
+	if (ctx->sector_size != SECTOR_SIZE && !iv_large_sectors) {
+		ti->error = "iv_large_sectors must be specified";
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+/*
+ * Construct an inlinecrypt mapping:
+ * <cipher> <key> <iv_offset> <dev_path> <start>
+ *
+ * This syntax matches dm-crypt's, but the set of supported functionality has
+ * been stripped down.
+ */
+static int inlinecrypt_ctr(struct dm_target *ti, unsigned int argc, char **argv)
+{
+	struct inlinecrypt_ctx *ctx;
+	const struct dm_inlinecrypt_cipher *cipher;
+	u8 raw_key[BLK_CRYPTO_MAX_ANY_KEY_SIZE];
+	unsigned int dun_bytes;
+	unsigned long long tmpll;
+	char dummy;
+	int err;
+
+	if (argc < 5) {
+		ti->error = "Not enough arguments";
+		return -EINVAL;
+	}
+
+	ctx = kzalloc(sizeof(*ctx), GFP_KERNEL);
+	if (!ctx) {
+		ti->error = "Out of memory";
+		return -ENOMEM;
+	}
+	ti->private = ctx;
+
+	/* <cipher> */
+	ctx->cipher_string = kstrdup(argv[0], GFP_KERNEL);
+	if (!ctx->cipher_string) {
+		ti->error = "Out of memory";
+		err = -ENOMEM;
+		goto bad;
+	}
+	cipher = lookup_cipher(ctx->cipher_string);
+	if (!cipher) {
+		ti->error = "Unsupported cipher";
+		err = -EINVAL;
+		goto bad;
+	}
+
+	/* <key> */
+	if (strlen(argv[1]) != 2 * cipher->key_size) {
+		ti->error = "Incorrect key size for cipher";
+		err = -EINVAL;
+		goto bad;
+	}
+	if (hex2bin(raw_key, argv[1], cipher->key_size) != 0) {
+		ti->error = "Malformed key string";
+		err = -EINVAL;
+		goto bad;
+	}
+
+	/* <iv_offset> */
+	if (sscanf(argv[2], "%llu%c", &ctx->iv_offset, &dummy) != 1) {
+		ti->error = "Invalid iv_offset sector";
+		err = -EINVAL;
+		goto bad;
+	}
+
+	/* <dev_path> */
+	err = dm_get_device(ti, argv[3], dm_table_get_mode(ti->table),
+			    &ctx->dev);
+	if (err) {
+		ti->error = "Device lookup failed";
+		goto bad;
+	}
+
+	/* <start> */
+	if (sscanf(argv[4], "%llu%c", &tmpll, &dummy) != 1 ||
+	    tmpll != (sector_t)tmpll) {
+		ti->error = "Invalid start sector";
+		err = -EINVAL;
+		goto bad;
+	}
+	ctx->start = tmpll;
+
+	/* optional arguments */
+	ctx->sector_size = SECTOR_SIZE;
+	if (argc > 5) {
+		err = inlinecrypt_ctr_optional(ti, argc - 5, &argv[5]);
+		if (err)
+			goto bad;
+	}
+	ctx->sector_bits = ilog2(ctx->sector_size);
+	if (ti->len & ((ctx->sector_size >> SECTOR_SHIFT) - 1)) {
+		ti->error = "Device size is not a multiple of sector_size";
+		err = -EINVAL;
+		goto bad;
+	}
+
+	ctx->max_dun = (ctx->iv_offset + ti->len - 1) >>
+		       (ctx->sector_bits - SECTOR_SHIFT);
+	dun_bytes = DIV_ROUND_UP(fls64(ctx->max_dun), 8);
+
+	err = blk_crypto_init_key(&ctx->key, raw_key, cipher->key_size,
+				  BLK_CRYPTO_KEY_TYPE_HW_WRAPPED, cipher->mode_num,
+				  dun_bytes, ctx->sector_size);
+	if (err) {
+		ti->error = "Error initializing blk-crypto key";
+		goto bad;
+	}
+
+	err = blk_crypto_start_using_key(ctx->dev->bdev, &ctx->key);
+	if (err) {
+		ti->error = "Error starting to use blk-crypto";
+		goto bad;
+	}
+
+	ti->num_flush_bios = 1;
+
+	err = 0;
+	goto out;
+
+bad:
+	inlinecrypt_dtr(ti);
+out:
+	memzero_explicit(raw_key, sizeof(raw_key));
+	return err;
+}
+
+static int inlinecrypt_map(struct dm_target *ti, struct bio *bio)
+{
+	const struct inlinecrypt_ctx *ctx = ti->private;
+	sector_t sector_in_target;
+	u64 dun[BLK_CRYPTO_DUN_ARRAY_SIZE] = {};
+
+	bio_set_dev(bio, ctx->dev->bdev);
+
+	/*
+	 * If the bio is a device-level request which doesn't target a specific
+	 * sector, there's nothing more to do.
+	 */
+	if (bio_sectors(bio) == 0)
+		return DM_MAPIO_REMAPPED;
+
+	/*
+	 * The bio should never have an encryption context already, since
+	 * dm-inlinecrypt doesn't pass through any inline encryption
+	 * capabilities to the layer above it.
+	 */
+	if (WARN_ON_ONCE(bio_has_crypt_ctx(bio)))
+		return DM_MAPIO_KILL;
+
+	/* Map the bio's sector to the underlying device. (512-byte sectors) */
+	sector_in_target = dm_target_offset(ti, bio->bi_iter.bi_sector);
+	bio->bi_iter.bi_sector = ctx->start + sector_in_target;
+	/*
+	 * If the bio doesn't have any data (e.g. if it's a DISCARD request),
+	 * there's nothing more to do.
+	 */
+	if (!bio_has_data(bio))
+		return DM_MAPIO_REMAPPED;
+
+	/* Calculate the DUN and enforce data-unit (crypto sector) alignment. */
+	dun[0] = ctx->iv_offset + sector_in_target; /* 512-byte sectors */
+	if (dun[0] & ((ctx->sector_size >> SECTOR_SHIFT) - 1))
+		return DM_MAPIO_KILL;
+	dun[0] >>= ctx->sector_bits - SECTOR_SHIFT; /* crypto sectors */
+
+	/*
+	 * This check isn't necessary as we should have calculated max_dun
+	 * correctly, but be safe.
+	 */
+	if (WARN_ON_ONCE(dun[0] > ctx->max_dun))
+		return DM_MAPIO_KILL;
+
+	bio_crypt_set_ctx(bio, &ctx->key, dun, GFP_NOIO);
+
+	return DM_MAPIO_REMAPPED;
+}
+
+static void inlinecrypt_status(struct dm_target *ti, status_type_t type,
+			       unsigned int status_flags, char *result,
+			       unsigned int maxlen)
+{
+	const struct inlinecrypt_ctx *ctx = ti->private;
+	unsigned int sz = 0;
+	int num_feature_args = 0;
+
+	switch (type) {
+	case STATUSTYPE_INFO:
+	case STATUSTYPE_IMA:
+		result[0] = '\0';
+		break;
+
+	case STATUSTYPE_TABLE:
+		/*
+		 * Warning: like dm-crypt, dm-inlinecrypt includes the key in
+		 * the returned table.  Userspace is responsible for redacting
+		 * the key when needed.
+		 */
+		DMEMIT("%s %*phN %llu %s %llu", ctx->cipher_string,
+		       ctx->key.size, ctx->key.bytes, ctx->iv_offset,
+		       ctx->dev->name, ctx->start);
+		num_feature_args += !!ti->num_discard_bios;
+		if (ctx->sector_size != SECTOR_SIZE)
+			num_feature_args += 2;
+		if (num_feature_args != 0) {
+			DMEMIT(" %d", num_feature_args);
+			if (ti->num_discard_bios)
+				DMEMIT(" allow_discards");
+			if (ctx->sector_size != SECTOR_SIZE) {
+				DMEMIT(" sector_size:%u", ctx->sector_size);
+				DMEMIT(" iv_large_sectors");
+			}
+		}
+		break;
+	}
+}
+
+static int inlinecrypt_prepare_ioctl(struct dm_target *ti,
+				     struct block_device **bdev, unsigned int cmd,
+				     unsigned long arg, bool *forward)
+{
+	const struct inlinecrypt_ctx *ctx = ti->private;
+	const struct dm_dev *dev = ctx->dev;
+
+	*bdev = dev->bdev;
+
+	/* Only pass ioctls through if the device sizes match exactly. */
+	return ctx->start != 0 || ti->len != bdev_nr_sectors(dev->bdev);
+}
+
+static int inlinecrypt_iterate_devices(struct dm_target *ti,
+				       iterate_devices_callout_fn fn,
+				       void *data)
+{
+	const struct inlinecrypt_ctx *ctx = ti->private;
+
+	return fn(ti, ctx->dev, ctx->start, ti->len, data);
+}
+
+#ifdef CONFIG_BLK_DEV_ZONED
+static int inlinecrypt_report_zones(struct dm_target *ti,
+				    struct dm_report_zones_args *args,
+				    unsigned int nr_zones)
+{
+	const struct inlinecrypt_ctx *ctx = ti->private;
+
+	return dm_report_zones(ctx->dev->bdev, ctx->start,
+			ctx->start + dm_target_offset(ti, args->next_sector),
+			args, nr_zones);
+}
+#else
+#define inlinecrypt_report_zones NULL
+#endif
+
+static void inlinecrypt_io_hints(struct dm_target *ti,
+				 struct queue_limits *limits)
+{
+	const struct inlinecrypt_ctx *ctx = ti->private;
+	const unsigned int sector_size = ctx->sector_size;
+
+	limits->logical_block_size =
+		max_t(unsigned int, limits->logical_block_size, sector_size);
+	limits->physical_block_size =
+		max_t(unsigned int, limits->physical_block_size, sector_size);
+	limits->io_min = max_t(unsigned int, limits->io_min, sector_size);
+	limits->dma_alignment = limits->logical_block_size - 1;
+}
+
+static struct target_type inlinecrypt_target = {
+	.name			= "inlinecrypt",
+	.version		= {1, 0, 0},
+	/*
+	 * Do not set DM_TARGET_PASSES_CRYPTO, since dm-inlinecrypt consumes the
+	 * crypto capability itself.
+	 */
+	.features		= DM_TARGET_ZONED_HM,
+	.module			= THIS_MODULE,
+	.ctr			= inlinecrypt_ctr,
+	.dtr			= inlinecrypt_dtr,
+	.map			= inlinecrypt_map,
+	.status			= inlinecrypt_status,
+	.prepare_ioctl		= inlinecrypt_prepare_ioctl,
+	.iterate_devices	= inlinecrypt_iterate_devices,
+	.report_zones		= inlinecrypt_report_zones,
+	.io_hints		= inlinecrypt_io_hints,
+};
+
+module_dm(inlinecrypt);
+
+MODULE_AUTHOR("Eric Biggers <ebiggers@google.com>");
+MODULE_AUTHOR("Linlin Zhang <linlin.zhang@oss.qualcomm.com>");
+MODULE_DESCRIPTION(DM_NAME " target for inline encryption");
+MODULE_LICENSE("GPL");
-- 
2.34.1

