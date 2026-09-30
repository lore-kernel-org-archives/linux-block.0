Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 425764FDA5F
	for <linux-block@vger.kernel.org>; Wed, 30 Sep 2026 14:52:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790779967; cv=none; b=SdomPHbQXCve0B42qUaUGp8bc+Z42d8USm263eIlTbrqvNpzKHWOunZ9wuK12wDiuTnEAt9iKOLEdKxT/VEIMQwL3LeQnszSTopxPDh09IcARv6IJjI7w0wJju2mDJJDK/0TGoagB/DftISWFbsTW+TmisSwM8tWY2Ya4PX90P4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790779967; c=relaxed/simple;
	bh=02j4F9JFSg7ERF/9QvrdesQkn9RTcMFp4VsCWXlfi5w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=eJDi7yrAug/Vn1MER1vzNg5ERvIsqrle2Y/JcNjTdxQWp23XIGiJU3UZ6FSZtZNeEHbKiRtrxdV75tLXApQa4dyEbGiaIAks30mJGf4fT2O97oFtv7a+lQM6zgNNTXANLVmgIFAM5ZpfPwsMHwziM/EBOUjPgo6BzV4h1LgI82A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=NXu4S4PT; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=C3qs6QgR; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="NXu4S4PT";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="C3qs6QgR"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68UDxsk32404709
	for <linux-block@vger.kernel.org>; Wed, 30 Sep 2026 14:52:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=qQCr3d35S+q
	y9T+DjYv5ittBLkIKQSV2uwID1A6qmpQ=; b=NXu4S4PThe2hl9Z29R88Ipbcc9S
	cr6OsRLERfHZasWIlTgn7JiXJIyJzyBnRVW2vUs4IR6zl0+1Qfi4MdCZXJfwl4un
	UHNSVUwoDmtXoSKIeyxhJlemb8jlU534R4veKicpTC6eUU3tj/JpAAx6YMyVMF7r
	jQFn2BBydw5q1tjUXSpYR2pqP2F2u4Lm/jJbhmp7PSf17co5iTO31AxUx5spCsLZ
	TP29jCpGLvSDzbMUWk4MssX+ou8KMAxq84wIMiLgbsngViIGFkbaR9cZHzRqOwl2
	jcny5QNLWcc73PmN9CZQJ0WSiE5r6yC9lwPXXyXCSCYQq0Gfct8DkeB39rw==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com [74.125.82.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h0x1c1wve-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-block@vger.kernel.org>; Wed, 30 Sep 2026 14:52:27 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id 5a478bee46e88-33baaba6371so1545559eec.1
        for <linux-block@vger.kernel.org>; Wed, 30 Sep 2026 07:52:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1790779943; x=1791384743; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=qQCr3d35S+qy9T+DjYv5ittBLkIKQSV2uwID1A6qmpQ=;
        b=C3qs6QgRYboFFfUyswYw1npWE9c5iEKiMvUEUSftc8YTFgsHt9S+RvBzRqlBRe4/kX
         JzWbAJ8ZB08W+ZFivqPsvLV+LSt4XGvZHzeIYAXfAU7MANWYEBeAJBHN/7O0kBXjPT8Z
         M4330hKEpNDW9EyhxlihXETvqu2kQIfJDpRyCX5WPZYoURMbo7Zl7rkRWK7OBNzNKjGo
         7namL1sJ0eieArgmSu01vch9aUN+QY58cZeGCziPnBkoyf4LgLhUgQjl2QNgoIk5PyvS
         aJNSA4e4ROYrqSEExHJFgPgZgFRp9WZDcdt4GtfcZQ1VSHh+1rqQriH7fG94ayAdpCLX
         a8cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790779943; x=1791384743;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=qQCr3d35S+qy9T+DjYv5ittBLkIKQSV2uwID1A6qmpQ=;
        b=LcReebNwnfB05Xu4c5bnukcxcJ3eFF80hSHRhV4dreAzeJNLMBAOWccbkNs00xmvVa
         JsyIdmnIcjpZwbJeZQ5FZNpfVUp0kbvyC2WAwSRS+wrtmhsKS7mA0TB1EcrM8sLsX4kP
         R1CwUKHsjAiEowDqTfRnO8KCYAG44TGTtOW4PAXuoCl/tiGKb/ai8LwdoT90hY47HalZ
         uTbx7IOvz4HfDEEYANbpbxCcpykGOGjZv794X4aFss9CaENCvFJe48IF82yCl0kX1TPC
         tgJzQ7GJPqr9R0XwFbqmVFKGV2fqvfEvpNxVDCCF/Rff1SVa3VY8EYYto9mzo6yYUD38
         U5Kg==
X-Forwarded-Encrypted: i=1; AKwUvBwNkplAahqHcf+2D7aBSnXyPzFcStahLjSPlbwtUOo085aaD7Rt02du7nD+VGVq8if/KlL22t/8o7R2RQ==@vger.kernel.org
X-Gm-Message-State: AFq9FYLun5jJ/gWymBZA8f9bJgVDvG1+ok5RR/xbq1fkpwYnIqVb4G2J
	1/pr8pVO/9w6K9MHxBvygMfoCIjgxoRvEUzJk42v+TFGQkvZC1SiMLp9INsla8SC7+PA5gWAfjH
	7wF7Y+Rf0MQv82j4orwMKvQSAcP9dCxfytCCAOClhF6HLgx0tmJhq5XvieFS8BqYS0w==
X-Gm-Gg: AYBFou07rs0Lt4nEttLi769Ia7zubDuYj8SKL8nxml8yE4YBdNfGH0W5w3UX6+H+9d6
	ybtihSpcXmV681DBoUZadwTqp+Lcjb+7w56e6cbMAoiZZSAK3FHIE02yojG2UK4byz/2y8l8Sbk
	IL2ZA6OB5RfB0Uk6feq3dFXPeVtyTN+itdVB98rD7hAP+RoJBN7UjTrGdPQrJn8CG7f/hMWuYmF
	Iqs6+WrL2avP5xtALlq6ycpexZ+RaR7ewlTQnuhxYqo+2MLyria6Uh8BvczpCZIMVDaC8bOPTDp
	0WUFDr+nGBLto1NRcgDfbhidpIu6YJB4VjwMUquTa/CxIlxtTZF6mELhwnw9Bpr3xBdGJtdGope
	M9FIohgYzfz7EhPRYmGN+Yh3hs96afL7dX2CDDoTwKpa40kKil8dAYc0=
X-Received: by 2002:a05:7301:1295:b0:344:c0fe:19ee with SMTP id 5a478bee46e88-34cdfd59fe5mr3027116eec.14.1790779942536;
        Wed, 30 Sep 2026 07:52:22 -0700 (PDT)
X-Received: by 2002:a05:7301:1295:b0:344:c0fe:19ee with SMTP id 5a478bee46e88-34cdfd59fe5mr3027062eec.14.1790779941767;
        Wed, 30 Sep 2026 07:52:21 -0700 (PDT)
Received: from hu-c-gdjako-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-34cf5639339sm4524609eec.18.2026.09.30.07.52.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Sep 2026 07:52:21 -0700 (PDT)
From: Georgi Djakov <georgi.djakov@oss.qualcomm.com>
To: andersson@kernel.org, konradybcio@kernel.org, abelvesa@kernel.org,
        robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
        minchan@kernel.org, senozhatsky@chromium.org
Cc: axboe@kernel.dk, rostedt@goodmis.org, mhiramat@kernel.org,
        mathieu.desnoyers@efficios.com, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-block@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        djakov@kernel.org
Subject: [PATCH 2/6] soc: qcom: qpace: Add Qualcomm Page Compression Engine driver
Date: Wed, 30 Sep 2026 07:52:11 -0700
Message-Id: <20260930145215.3380977-3-georgi.djakov@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260930145215.3380977-1-georgi.djakov@oss.qualcomm.com>
References: <20260930145215.3380977-1-georgi.djakov@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTMwMDA1OSBTYWx0ZWRfXx3ny+VZuDet7
 Z3+PLhwJ3ZtmTiKWg6icJgtQEBH5icWUvIv3ZZlluFGhW3/G4/u/wsCTDstMHEQwrsRNxMRzQvY
 mgIZBxSKMJwSHJKRAf5T/koL09hSPQs=
X-Proofpoint-ORIG-GUID: w-yD-IxlHMPk7ya0Y2ukARiZBpw7q-fw
X-Authority-Analysis: v=2.4 cv=VrC2kO2n c=1 sm=1 tr=0 ts=6abd222d cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22 a=EUspDBNiAAAA:8
 a=ocBFd8b8N9jNoggcfRoA:9 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-GUID: w-yD-IxlHMPk7ya0Y2ukARiZBpw7q-fw
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTMwMDA1OSBTYWx0ZWRfX+boAUzGxMGOH
 iqMoH7De2HyS8KZIJIGkq9xyT2cpwDAk8D0cFB3BNNARgNur0aPIcu2Oy0veUDkzINtwdCTk36+
 OFb2fLaqlSzuk7y360Nv4EsHltnKZ1jPf9dRKrXFVfUEyR33Au6PM5JGXn9K02vNz+Zje5Hkq4w
 yWbUBtlXCuU7KsdUR5IkFnvY2MKwaqa0IYIbqFLQIzkJT4ceyG/sCUxGQoAJbpf7kb0+lqNPvn6
 TBgFzVHytnyEcgsx0ijnBkSGj8CA5kHd7odVOhAm1+qK9AGvWDWynG/ORBgj5oM/2kXDDA6NXn0
 gtJ2IW7LL00h59zS5ZvbKavDVh2uV7ywpW85bobv5UsGt4liI7kj4d+5MM4prfNaXcvmoNS7iZ0
 uZpxl6rDG1fBIdgoBgz3MJt3zlXfzhhmsEqVoXkACcrFS2LHOXuWRORxqthap/LRy+vXtWpJRVk
 itwzxDYS1qjm+4iwCFA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-30_03,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 impostorscore=0 clxscore=1015 malwarescore=0
 bulkscore=0 lowpriorityscore=0 suspectscore=0 priorityscore=1501 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609300059

Add a platform driver for the Qualcomm Page Compression Engine (QPaCE), a
hardware block that accelerates compression and decompression of memory
pages.

Provide the urgent command path for synchronous single-page compression and
decompression. This exposes the low-latency operations needed by
compressed-memory users such as zram, especially for page decompression on
the read path.

Signed-off-by: Georgi Djakov <georgi.djakov@oss.qualcomm.com>
---
 drivers/soc/qcom/Kconfig          |  14 +
 drivers/soc/qcom/Makefile         |   1 +
 drivers/soc/qcom/qpace.c          | 764 ++++++++++++++++++++++++++++++
 drivers/soc/qcom/qpace_internal.h |  84 ++++
 include/linux/soc/qcom/qpace.h    | 154 ++++++
 5 files changed, 1017 insertions(+)
 create mode 100644 drivers/soc/qcom/qpace.c
 create mode 100644 drivers/soc/qcom/qpace_internal.h
 create mode 100644 include/linux/soc/qcom/qpace.h

diff --git a/drivers/soc/qcom/Kconfig b/drivers/soc/qcom/Kconfig
index 535c8619197b..6bcb86dcd726 100644
--- a/drivers/soc/qcom/Kconfig
+++ b/drivers/soc/qcom/Kconfig
@@ -288,6 +288,20 @@ config QCOM_PBS
 	  This module provides the APIs to the client drivers that wants to send the
 	  PBS trigger event to the PBS RAM.
 
+config QCOM_PAGE_COMPRESSION_ENGINE
+	tristate "Qualcomm Page Compression Engine (QPaCE)"
+	depends on ARM64
+	depends on ARCH_QCOM || COMPILE_TEST
+	depends on OF
+	depends on INTERCONNECT
+	help
+	  Enable support for the Qualcomm Page Compression Engine (QPaCE),
+	  a hardware accelerator that provides high-throughput page compression,
+	  decompression, and DMA copy operations.
+
+	  The engine is used as a hardware backend for compressed-memory
+	  subsystems such as zram. If unsure, say N.
+
 endif
 
 # Options selected by other drivers from different subsystems must be outside
diff --git a/drivers/soc/qcom/Makefile b/drivers/soc/qcom/Makefile
index bddd6f0a5836..45fe697cf2d4 100644
--- a/drivers/soc/qcom/Makefile
+++ b/drivers/soc/qcom/Makefile
@@ -42,3 +42,4 @@ qcom_ice-objs			+= ice.o
 obj-$(CONFIG_QCOM_INLINE_CRYPTO_ENGINE)	+= qcom_ice.o
 obj-$(CONFIG_QCOM_PBS) +=	qcom-pbs.o
 obj-$(CONFIG_QCOM_UBWC_CONFIG) += ubwc_config.o
+obj-$(CONFIG_QCOM_PAGE_COMPRESSION_ENGINE) += qpace.o
diff --git a/drivers/soc/qcom/qpace.c b/drivers/soc/qcom/qpace.c
new file mode 100644
index 000000000000..69aa14b7c477
--- /dev/null
+++ b/drivers/soc/qcom/qpace.c
@@ -0,0 +1,764 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+ */
+
+#include <dt-bindings/interconnect/qcom,icc.h>
+#include <linux/delay.h>
+#include <linux/dma-mapping.h>
+#include <linux/export.h>
+#include <linux/interconnect.h>
+#include <linux/interrupt.h>
+#include <linux/io.h>
+#include <linux/iopoll.h>
+#include <linux/mm.h>
+#include <linux/module.h>
+#include <linux/mutex.h>
+#include <linux/of.h>
+#include <linux/of_platform.h>
+#include <linux/platform_device.h>
+#include <linux/pm_qos.h>
+#include <linux/soc/qcom/qpace.h>
+#include <linux/workqueue.h>
+
+#include "qpace_internal.h"
+
+#define QPACE_REG_PAGE_SIZE 4096
+#define QPACE_CORE_CACHEINDEX_SIZE 4
+
+struct qpace_priv {
+	void __iomem *gen_regs;
+	void __iomem *gen_core_regs;
+	void __iomem *comp_core_regs;
+	void __iomem *decomp_core_regs;
+	void __iomem *urg_regs;
+
+	struct device *dev;
+	u32 hw_version;
+	bool suspended;
+
+	struct icc_path *interconnect;
+	struct pm_qos_request qos_req;
+
+	int active_rings;
+	struct completion no_active_refs;
+
+	bool broken;
+	struct work_struct disable_work;
+};
+
+static inline u32 qpace_read_gen(struct qpace_priv *p, u32 offset)
+{
+	return readl(p->gen_regs + offset);
+}
+
+static inline void qpace_write_gen(struct qpace_priv *p, u32 offset, u32 val)
+{
+	writel(val, p->gen_regs + offset);
+}
+
+static inline u32 qpace_read_gen_core(struct qpace_priv *p, u32 offset)
+{
+	return readl(p->gen_core_regs + offset);
+}
+
+static inline void qpace_write_gen_core(struct qpace_priv *p, u32 offset, u32 val)
+{
+	writel(val, p->gen_core_regs + offset);
+}
+
+static inline u32 qpace_read_comp_core(struct qpace_priv *p, u32 offset)
+{
+	return readl(p->comp_core_regs + offset);
+}
+
+static inline void qpace_write_comp_core(struct qpace_priv *p, u32 offset, u32 val)
+{
+	writel(val, p->comp_core_regs + offset);
+}
+
+static inline u32 qpace_read_urg_cacheindex(struct qpace_priv *p, int idx, u32 offset)
+{
+	return readl(p->gen_regs + idx * QPACE_CORE_CACHEINDEX_SIZE + offset);
+}
+
+static inline void qpace_write_urg_cacheindex(struct qpace_priv *p, int idx, u32 offset, u32 val)
+{
+	writel(val, p->gen_regs + idx * QPACE_CORE_CACHEINDEX_SIZE + offset);
+}
+
+static inline u32 qpace_read_decomp_core(struct qpace_priv *p, u32 offset)
+{
+	return readl(p->decomp_core_regs + offset);
+}
+
+static inline void qpace_write_decomp_core(struct qpace_priv *p, u32 offset, u32 val)
+{
+	writel(val, p->decomp_core_regs + offset);
+}
+
+static inline u32 qpace_read_urg_cmd(struct qpace_priv *p, int idx, u32 offset)
+{
+	return readl(p->urg_regs + idx * QPACE_REG_PAGE_SIZE + offset);
+}
+
+static inline void qpace_write_urg_cmd(struct qpace_priv *p, int idx, u32 offset, u32 val)
+{
+	writel(val, p->urg_regs + idx * QPACE_REG_PAGE_SIZE + offset);
+}
+
+static inline void qpace_write_urg_cmd_ctx(struct qpace_priv *p, u32 offset,
+					   int urg_reg_num, int ctx_num, u32 val)
+{
+	writel(val, p->urg_regs + urg_reg_num * QPACE_REG_PAGE_SIZE +
+	       offset + ctx_num * URG_CMD_CONTEXT_SPACING);
+}
+
+static struct qpace_priv *qpace_priv;
+
+static DEFINE_STATIC_KEY_FALSE(qpace_drv_probed);
+
+static void qpace_disable_work_fn(struct work_struct *work)
+{
+	static_branch_disable(&qpace_drv_probed);
+}
+
+enum urg_reg_cxts {
+	LZ4_URG_COMP_CNTXT,
+	LZ4_URG_DECOMP_CNTXT,
+};
+
+const struct qpace_algorithm qpace_lz4_algorithm = {
+	.name = "qpace-lz4",
+	.comp_opcode = LZ4_COMP,
+	.decomp_opcode = LZ4_DECOMP,
+	.urg_comp_cntxt = LZ4_URG_COMP_CNTXT,
+	.urg_decomp_cntxt = LZ4_URG_DECOMP_CNTXT,
+};
+EXPORT_SYMBOL_GPL(qpace_lz4_algorithm);
+
+bool qpace_is_valid_algorithm(const char *algo_name)
+{
+	if (!static_branch_likely(&qpace_drv_probed))
+		return false;
+	if (READ_ONCE(qpace_priv->broken))
+		return false;
+
+	return algo_name && !strcmp(algo_name, qpace_lz4_algorithm.name);
+}
+EXPORT_SYMBOL_GPL(qpace_is_valid_algorithm);
+
+static inline void program_urg_comp_context(int urg_reg_num, const struct qpace_algorithm *algo)
+{
+	u32 urg_cmd_settings = 0;
+	int page_cnt = (1 << (PAGE_SHIFT - 12)) - 1;
+
+	/* Set the limit of the compression output size */
+	urg_cmd_settings = FIELD_PREP(URG_CMD_0_CFG_CNTXT_SIZE_SIZE, PAGE_SIZE - 1);
+	qpace_write_urg_cmd_ctx(qpace_priv, QPACE_URG_CMD_0_CFG_CNTXT_SIZE_n_OFFSET,
+				urg_reg_num, algo->urg_comp_cntxt,
+				urg_cmd_settings);
+
+	urg_cmd_settings = FIELD_PREP(URG_CMD_0_CFG_CNTXT_MISC_OPER, algo->comp_opcode);
+
+	/* Set page count for urgent compression input */
+	urg_cmd_settings |= FIELD_PREP(URG_CMD_0_CFG_CNTXT_MISC_PAGE_CNT, page_cnt);
+
+	/* Program part of the SMMU input and output SIDs */
+	urg_cmd_settings |= FIELD_PREP(URG_CMD_0_CFG_CNTXT_MISC_SCTX,
+				       DEFAULT_SMMU_CONTEXT);
+	urg_cmd_settings |= FIELD_PREP(URG_CMD_0_CFG_CNTXT_MISC_DCTX,
+				       DEFAULT_SMMU_CONTEXT);
+
+	/* Cache accesses in the system cache during compression */
+	urg_cmd_settings |= FIELD_PREP(URG_CMD_0_CFG_CNTXT_MISC_WA, 1);
+
+	qpace_write_urg_cmd_ctx(qpace_priv, QPACE_URG_CMD_0_CFG_CNTXT_MISC_n_OFFSET,
+				urg_reg_num, algo->urg_comp_cntxt,
+				urg_cmd_settings);
+}
+
+static inline void program_urg_decomp_context(int urg_reg_num, const struct qpace_algorithm *algo)
+{
+	u32 urg_cmd_settings = 0;
+	int page_cnt = (1 << (PAGE_SHIFT - 12)) - 1;
+
+	/* The input size will be programmed by a requester */
+	urg_cmd_settings = FIELD_PREP(URG_CMD_0_CFG_CNTXT_SIZE_SIZE, 0);
+	qpace_write_urg_cmd_ctx(qpace_priv, QPACE_URG_CMD_0_CFG_CNTXT_SIZE_n_OFFSET,
+				urg_reg_num, algo->urg_decomp_cntxt,
+				urg_cmd_settings);
+
+	urg_cmd_settings = FIELD_PREP(URG_CMD_0_CFG_CNTXT_MISC_OPER, algo->decomp_opcode);
+
+	/* Configure page count which will limit decompression output size */
+	urg_cmd_settings |= FIELD_PREP(URG_CMD_0_CFG_CNTXT_MISC_PAGE_CNT, page_cnt);
+
+	/* Program part of the SMMU input and output SIDs */
+	urg_cmd_settings |= FIELD_PREP(URG_CMD_0_CFG_CNTXT_MISC_SCTX,
+				       DEFAULT_SMMU_CONTEXT);
+	urg_cmd_settings |= FIELD_PREP(URG_CMD_0_CFG_CNTXT_MISC_DCTX,
+				       DEFAULT_SMMU_CONTEXT);
+
+	/* Cache accesses in the system cache during decompression */
+	urg_cmd_settings |= FIELD_PREP(URG_CMD_0_CFG_CNTXT_MISC_WA, 1);
+
+	qpace_write_urg_cmd_ctx(qpace_priv, QPACE_URG_CMD_0_CFG_CNTXT_MISC_n_OFFSET,
+				urg_reg_num, algo->urg_decomp_cntxt,
+				urg_cmd_settings);
+}
+
+static void program_urg_cmd_cacheindex(int urg_reg_num)
+{
+	u32 reg_val;
+
+	reg_val = qpace_read_urg_cacheindex(qpace_priv, urg_reg_num,
+					    QPACE_CORE_URG_CMD_n_CACHEINDEX_CFG_OFFSET);
+	reg_val = u32_replace_bits(reg_val, 0x24, CORE_URG_CMD_n_CACHEINDEX__ENGINE_CACHEINDEX);
+	reg_val = u32_replace_bits(reg_val, 0x1,
+				   CORE_URG_CMD_n_CACHEINDEX__ENGINE_CACHEINDEX_OVERRIDE);
+	qpace_write_urg_cacheindex(qpace_priv, urg_reg_num,
+				   QPACE_CORE_URG_CMD_n_CACHEINDEX_CFG_OFFSET, reg_val);
+}
+
+static void program_decomp_core_cfg(void)
+{
+	u32 reg_val;
+
+	reg_val = qpace_read_decomp_core(qpace_priv, QPACE_DECOMP_CORE_CFG_OFFSET);
+	reg_val = u32_replace_bits(reg_val, 0x8, DECOMP_CORE_CFG_DMA_RD_MAX_OT);
+	reg_val = u32_replace_bits(reg_val, 0x16, DECOMP_CORE_CFG_DMA_WR_MAX_OT);
+	/*
+	 * MEM_MNG_PAGE_SIZE controls the prefetch boundary:
+	 * 0: 4 KB, 1: 8 KB, 2: 16 KB, 3: 32 KB, 4: 64 KB
+	 */
+	reg_val = u32_replace_bits(reg_val, 0x0, DECOMP_CORE_CFG_DECOMP_DMA_MEM_MNG_PAGE_SIZE);
+	qpace_write_decomp_core(qpace_priv, QPACE_DECOMP_CORE_CFG_OFFSET, reg_val);
+}
+
+static void program_urg_command_contexts_v2(void)
+{
+	int urg_reg_num;
+
+	/* Configure the needed contexts for each of the urgent command registers */
+	for (urg_reg_num = 0; urg_reg_num < NUM_TRS_ERS_URG_CMD_REGS; urg_reg_num++) {
+		program_urg_cmd_cacheindex(urg_reg_num);
+		program_urg_comp_context(urg_reg_num, &qpace_lz4_algorithm);
+		program_urg_decomp_context(urg_reg_num, &qpace_lz4_algorithm);
+	}
+}
+
+static inline int qpace_urgent_command_trigger(dma_addr_t input_addr,
+					       dma_addr_t output_addr,
+					       int urg_reg_num,
+					       enum urg_reg_cxts command)
+{
+	void __iomem *td_dst_src_reg = qpace_priv->urg_regs +
+				       (urg_reg_num * QPACE_REG_PAGE_SIZE) +
+					QPACE_URG_CMD_0_TD_DST_ADDR_L_CFG_CNTXT_OFFSET;
+	u64 urg_addr_field_lower, urg_addr_field_upper;
+	u32 stat_reg;
+	unsigned long ret;
+
+	urg_addr_field_lower = FIELD_PREP(URG_CMD_0_TD_DST_ADDR_L__CMD_CFG_CNTXT,
+					  command);
+	urg_addr_field_lower |= GENMASK(63, 8) & output_addr;
+
+	urg_addr_field_upper = input_addr;
+
+	/* Clear a stale request-on-active error before ringing the doorbell. */
+	qpace_write_urg_cmd(qpace_priv, urg_reg_num, QPACE_URG_CMD_0_STAT_CLR_OFFSET,
+			    URG_CMD_0_STAT_CLR_REQ_ON_ACTIVE_ERR);
+
+	/* Ensure that preceding stores that QPaCE will depend on are done executing */
+	dma_wmb();
+
+	/*
+	 * Ring the doorbell with a single 128-bit atomic store. QPaCE
+	 * triggers processing when it observes the (dst_addr, src_addr)
+	 * pair land together.
+	 */
+	asm volatile("stp %0, %1, [%2]\n" :
+		     : "r" (urg_addr_field_lower), "r" (urg_addr_field_upper), "r" (td_dst_src_reg)
+		     : "memory");
+
+	ret = readl_poll_timeout_atomic(qpace_priv->urg_regs +
+					urg_reg_num * QPACE_REG_PAGE_SIZE +
+					QPACE_URG_CMD_0_ED_STAT_OFFSET,
+					stat_reg,
+					FIELD_GET(URG_CMD_0_ED_STAT_COMP_CODE,
+						  stat_reg) != OP_URG_ONGOING,
+					1, 100 * USEC_PER_MSEC);
+	if (ret) {
+		dev_err(qpace_priv->dev, "QPaCE urgent command timed out\n");
+		return -ETIMEDOUT;
+	}
+
+	return stat_reg;
+}
+
+int qpace_urgent_compress(dma_addr_t input_addr,
+			  dma_addr_t output_addr,
+			  struct qpace_algorithm *algo)
+{
+	int urg_reg_num;
+	int stat_reg;
+	u32 stat_reg_val;
+	int ret;
+
+	ret = qpace_get();
+	if (ret)
+		return ret;
+
+	urg_reg_num = get_cpu() % NUM_TRS_ERS_URG_CMD_REGS;
+	stat_reg = qpace_urgent_command_trigger(input_addr, output_addr, urg_reg_num,
+						algo->urg_comp_cntxt);
+	put_cpu();
+
+	qpace_put();
+
+	if (stat_reg < 0) {
+		ret = stat_reg;
+		goto out;
+	}
+
+	stat_reg_val = FIELD_GET(URG_CMD_0_ED_STAT_COMP_CODE, stat_reg);
+
+	if (stat_reg_val == OP_COMP_TOO_BIG) {
+		ret = -E2BIG;
+		goto out;
+	}
+
+	if (stat_reg_val != OP_OK) {
+		pr_err("%s: register %d failed with %u\n",
+		       __func__, urg_reg_num, stat_reg_val);
+		ret = -EINVAL;
+		goto out;
+	}
+
+	ret = FIELD_GET(URG_CMD_0_ED_STAT_SIZE, stat_reg);
+out:
+	return ret;
+}
+EXPORT_SYMBOL_GPL(qpace_urgent_compress);
+
+int qpace_urgent_decompress(dma_addr_t input_addr,
+			    dma_addr_t output_addr,
+			    size_t input_size,
+			    struct qpace_algorithm *algo)
+{
+	int urg_reg_num;
+	int stat_reg;
+	u32 stat_reg_val;
+	int ret;
+
+	ret = qpace_get();
+	if (ret)
+		goto out;
+
+	urg_reg_num = get_cpu() % NUM_TRS_ERS_URG_CMD_REGS;
+	qpace_write_urg_cmd_ctx(qpace_priv, QPACE_URG_CMD_0_CFG_CNTXT_SIZE_n_OFFSET,
+				urg_reg_num, algo->urg_decomp_cntxt,
+				FIELD_PREP(URG_CMD_0_CFG_CNTXT_SIZE_SIZE, input_size));
+	stat_reg = qpace_urgent_command_trigger(input_addr, output_addr, urg_reg_num,
+						algo->urg_decomp_cntxt);
+	put_cpu();
+
+	qpace_put();
+
+	if (stat_reg < 0) {
+		ret = stat_reg;
+		goto out;
+	}
+
+	stat_reg_val = FIELD_GET(URG_CMD_0_ED_STAT_COMP_CODE, stat_reg);
+	if (stat_reg_val != OP_OK) {
+		pr_err("%s: register %d failed with %u\n",
+		       __func__, urg_reg_num, stat_reg_val);
+		ret = -EINVAL;
+		goto out;
+	}
+
+	ret = FIELD_GET(URG_CMD_0_ED_STAT_SIZE, stat_reg);
+out:
+	return ret;
+}
+EXPORT_SYMBOL_GPL(qpace_urgent_decompress);
+
+static DEFINE_MUTEX(qpace_ref_lock);
+
+static void _get_qpace(void)
+{
+	lockdep_assert_held(&qpace_ref_lock);
+	if (!qpace_priv->active_rings) {
+		reinit_completion(&qpace_priv->no_active_refs);
+		pm_stay_awake(qpace_priv->dev);
+		cpu_latency_qos_update_request(&qpace_priv->qos_req, 300);
+		program_urg_command_contexts_v2();
+		program_decomp_core_cfg();
+	}
+	qpace_priv->active_rings++;
+}
+
+static void _put_qpace(void)
+{
+	lockdep_assert_held(&qpace_ref_lock);
+	if (!--qpace_priv->active_rings) {
+		cpu_latency_qos_update_request(&qpace_priv->qos_req, PM_QOS_DEFAULT_VALUE);
+		pm_relax(qpace_priv->dev);
+		complete(&qpace_priv->no_active_refs);
+	}
+}
+
+int qpace_get(void)
+{
+	int ret = 0;
+
+	mutex_lock(&qpace_ref_lock);
+	if (qpace_priv->suspended || READ_ONCE(qpace_priv->broken))
+		ret = -EBUSY;
+	else
+		_get_qpace();
+	mutex_unlock(&qpace_ref_lock);
+	return ret;
+}
+EXPORT_SYMBOL_GPL(qpace_get);
+
+void qpace_put(void)
+{
+	mutex_lock(&qpace_ref_lock);
+	_put_qpace();
+	mutex_unlock(&qpace_ref_lock);
+}
+EXPORT_SYMBOL_GPL(qpace_put);
+
+static irqreturn_t urgent_interrupt_handler(int irq, void *unused)
+{
+	pr_debug("Urgent interrupt handled\n");
+	return IRQ_HANDLED;
+}
+
+static int qpace_hw_init(void)
+{
+	u32 reg_val;
+
+	/* Select CPU SCID for our system cache slice. */
+	reg_val = qpace_read_gen(qpace_priv, QPACE_CORE_QNS4_CFG_OFFSET);
+	reg_val = u32_replace_bits(reg_val, 0x1, CORE_QNS4_CFG_CACHEINDEX);
+	qpace_write_gen(qpace_priv, QPACE_CORE_QNS4_CFG_OFFSET, reg_val);
+
+	/* QMB2 register configurations. */
+	reg_val = qpace_read_gen(qpace_priv, QPACE_CORE_GEN_CFG_OFFSET);
+	reg_val = u32_replace_bits(reg_val, 0x48, CORE_GEN_CFG_QMB2_MAX_RD_OUTST_LIMIT);
+	reg_val = u32_replace_bits(reg_val, 0x48, CORE_GEN_CFG_QMB2_MAX_WR_OUTST_LIMIT);
+	qpace_write_gen(qpace_priv, QPACE_CORE_GEN_CFG_OFFSET, reg_val);
+
+	/* DECOMP_CORE_CFG init steps. */
+	program_decomp_core_cfg();
+
+	/* Below settings help save power since all decomp cores are set to sync. */
+	reg_val = qpace_read_gen_core(qpace_priv, QPACE_CORE_OPER_CFG_OFFSET);
+	reg_val |= CORE_OPER_CFG_COMP_MEM_PWR_DWN_1;
+	qpace_write_gen_core(qpace_priv, QPACE_CORE_OPER_CFG_OFFSET, reg_val);
+
+	reg_val = qpace_read_comp_core(qpace_priv, QPACE_COMP_CORE_CFG_OFFSET);
+	reg_val = u32_replace_bits(reg_val, 0x8, COMP_CORE_CFG_DMA_RD_MAX_OT);
+	reg_val = u32_replace_bits(reg_val, 0x8, COMP_CORE_CFG_DMA_WR_MAX_OT);
+	qpace_write_comp_core(qpace_priv, QPACE_COMP_CORE_CFG_OFFSET, reg_val);
+
+	/* Set all COMP engines to bulk mode. */
+	reg_val = qpace_read_comp_core(qpace_priv, QPACE_COMP_CORE_BULK_MODE_OFFSET);
+	reg_val |= COMP_CORE_BULK_MODE_ALL_CORES;
+	qpace_write_comp_core(qpace_priv, QPACE_COMP_CORE_BULK_MODE_OFFSET, reg_val);
+
+	/* URG CMD register configurations. */
+	program_urg_command_contexts_v2();
+
+	return 0;
+}
+
+enum qpace_interrupts {
+	QPACE_IRQ_URGENT
+};
+
+static int qpace_register_interrupts(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	int irq, ret;
+
+	irq = platform_get_irq(pdev, QPACE_IRQ_URGENT);
+	if (irq < 0)
+		return irq;
+
+	ret = devm_request_irq(dev, irq, urgent_interrupt_handler,
+			       0, "qpace-urgent-irq", NULL);
+	if (ret)
+		dev_err(dev, "failed to request urgent interrupt\n");
+
+	return ret;
+}
+
+static inline bool _qpace_power_on(void)
+{
+	u32 ready_status;
+
+	qpace_write_gen_core(qpace_priv, QPACE_CORE_OPER_CORE_RUN_STOP_OFFSET, QPACE_RUN);
+
+	if (readl_poll_timeout(qpace_priv->gen_core_regs +
+			       QPACE_CORE_OPER_CORE_READY_OFFSET,
+			       ready_status, ready_status,
+			       1000, 5 * QPACE_STATE_CHANGE_TIMEOUT_US)) {
+		pr_err("Timeout in waiting for QPaCE to turn on\n");
+		return false;
+	}
+
+	return true;
+}
+
+static int qpace_power_on(struct device *dev)
+{
+	int ret, ret2;
+
+	qpace_priv->interconnect = devm_of_icc_get(dev, "qpace-mem");
+	if (IS_ERR_OR_NULL(qpace_priv->interconnect)) {
+		ret = PTR_ERR_OR_ZERO(qpace_priv->interconnect);
+		pr_err("%s: devm_of_icc_get() failed with %d\n", __func__, ret);
+		return qpace_priv->interconnect ? ret : -EINVAL;
+	}
+
+	ret = device_init_wakeup(dev, true);
+	if (ret) {
+		pr_err("%s: device_init_wakeup() failed with %d\n", __func__, ret);
+		return ret;
+	}
+
+	cpu_latency_qos_add_request(&qpace_priv->qos_req, PM_QOS_DEFAULT_VALUE);
+
+	icc_set_tag(qpace_priv->interconnect, QCOM_ICC_TAG_ACTIVE_ONLY);
+
+	ret = icc_set_bw(qpace_priv->interconnect, 0, 1);
+	if (ret) {
+		pr_err("Failed to turn on QPaCE VCD: %d\n", ret);
+		goto rm_qos;
+	}
+
+	if (!_qpace_power_on()) {
+		pr_err("Failed to start QPaCE\n");
+		ret = -EINVAL;
+		goto rm_bw;
+	}
+
+	return 0;
+
+rm_bw:
+	ret2 = icc_set_bw(qpace_priv->interconnect, 0, 0);
+	if (ret2)
+		pr_err("Failed to remove QPaCE VCD vote: %d\n", ret2);
+rm_qos:
+	cpu_latency_qos_remove_request(&qpace_priv->qos_req);
+	device_init_wakeup(dev, false);
+
+	return ret;
+}
+
+static inline bool _qpace_power_off(void)
+{
+	u32 ready_status;
+
+	qpace_write_gen_core(qpace_priv, QPACE_CORE_OPER_CORE_RUN_STOP_OFFSET, QPACE_STOP);
+
+	if (readl_poll_timeout(qpace_priv->gen_core_regs +
+			       QPACE_CORE_OPER_CORE_READY_OFFSET,
+			       ready_status, !ready_status,
+			       1000, 5 * QPACE_STATE_CHANGE_TIMEOUT_US)) {
+		pr_err("Timeout in waiting for QPaCE to turn off\n");
+		return false;
+	}
+
+	return true;
+}
+
+static void qpace_power_off(struct device *dev)
+{
+	int ret;
+
+	/* If this fails we can still remove our vote for the VCD to turn QPaCE off */
+	if (!_qpace_power_off())
+		pr_err("Failed to stop QPaCE\n");
+
+	ret = icc_set_bw(qpace_priv->interconnect, 0, 0);
+	if (ret)
+		pr_err("Failed to turn off QPaCE VCD: %d\n", ret);
+
+	cpu_latency_qos_remove_request(&qpace_priv->qos_req);
+
+	device_init_wakeup(dev, false);
+}
+
+static inline int qpace_register_ioremap(struct platform_device *pdev)
+{
+	qpace_priv->gen_regs = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(qpace_priv->gen_regs))
+		return PTR_ERR(qpace_priv->gen_regs);
+
+	qpace_priv->gen_core_regs = qpace_priv->gen_regs + QPACE_GEN_CORE_REGS_OFFSET;
+	qpace_priv->comp_core_regs = qpace_priv->gen_regs + QPACE_COMP_CORE_REGS_OFFSET;
+	qpace_priv->decomp_core_regs = qpace_priv->gen_regs + QPACE_DECOMP_CORE_REGS_OFFSET;
+	qpace_priv->urg_regs = qpace_priv->gen_regs + QPACE_URG_REGS_OFFSET;
+
+	return 0;
+}
+
+bool qpace_is_dev_available(void)
+{
+	return static_branch_likely(&qpace_drv_probed) &&
+	       !READ_ONCE(qpace_priv->broken);
+}
+EXPORT_SYMBOL_GPL(qpace_is_dev_available);
+
+struct device *qpace_get_dma_dev(void)
+{
+	return qpace_priv->dev;
+}
+EXPORT_SYMBOL_GPL(qpace_get_dma_dev);
+
+static int qpace_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct qpace_priv *priv;
+	int ret;
+
+	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	priv->dev = dev;
+	/* Starts already complete since active_rings == 0 at init. */
+	init_completion(&priv->no_active_refs);
+	complete(&priv->no_active_refs);
+	INIT_WORK(&priv->disable_work, qpace_disable_work_fn);
+	qpace_priv = priv;
+	platform_set_drvdata(pdev, priv);
+
+	ret = dma_set_mask_and_coherent(dev, DMA_BIT_MASK(64));
+	if (ret)
+		return dev_err_probe(dev, ret, "failed to set DMA mask\n");
+
+	ret = qpace_register_ioremap(pdev);
+	if (ret)
+		return dev_err_probe(dev, ret, "failed to map QPaCE registers\n");
+
+	ret = qpace_power_on(dev);
+	if (ret)
+		return dev_err_probe(dev, ret, "failed to power on QPaCE\n");
+
+	/* Get QPaCE HW version. */
+	qpace_priv->hw_version = qpace_read_gen(qpace_priv, QPACE_CORE_HW_VERSION_OFFSET);
+	if (qpace_priv->hw_version != QPACE_HW_VERSION_V2) {
+		dev_err(dev, "Unsupported QPaCE HW version returned: 0x%x\n",
+			qpace_priv->hw_version);
+		ret = -EINVAL;
+		goto power_off;
+	}
+
+	ret = qpace_hw_init();
+	if (ret) {
+		dev_err(dev, "init failed: (%d)\n", ret);
+		goto power_off;
+	}
+
+	ret = qpace_register_interrupts(pdev);
+	if (ret) {
+		dev_err(dev, "failed to register interrupts\n");
+		goto power_off;
+	}
+
+	static_branch_enable(&qpace_drv_probed);
+
+	return ret;
+
+power_off:
+	qpace_power_off(dev);
+
+	return ret;
+}
+
+static void qpace_remove(struct platform_device *pdev)
+{
+	mutex_lock(&qpace_ref_lock);
+	qpace_priv->suspended = true;
+	mutex_unlock(&qpace_ref_lock);
+
+	static_branch_disable(&qpace_drv_probed);
+
+	wait_for_completion(&qpace_priv->no_active_refs);
+
+	/* No callers remain; tear down the hardware. */
+	cancel_work_sync(&qpace_priv->disable_work);
+	qpace_power_off(&pdev->dev);
+}
+
+static const struct of_device_id qpace_match_table[] = {
+	{ .compatible = "qcom,hawi-qpace" },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, qpace_match_table);
+
+static int qpace_suspend(struct device *dev)
+{
+	mutex_lock(&qpace_ref_lock);
+
+	qpace_priv->suspended = true;
+
+	if (qpace_priv->active_rings) {
+		dev_err(dev, "active_rings not 0, abort suspend\n");
+		qpace_priv->suspended = false;
+		mutex_unlock(&qpace_ref_lock);
+		return -EBUSY;
+	}
+
+	mutex_unlock(&qpace_ref_lock);
+	return 0;
+}
+
+static int qpace_resume(struct device *dev)
+{
+	int ret;
+
+	mutex_lock(&qpace_ref_lock);
+
+	if (qpace_priv->active_rings)
+		dev_err(dev, "active_rings not 0, unexpected case\n");
+
+	ret = icc_set_bw(qpace_priv->interconnect, 0, 1);
+	if (ret)
+		goto out_unlock;
+
+	program_urg_command_contexts_v2();
+	program_decomp_core_cfg();
+
+	qpace_priv->suspended = false;
+
+out_unlock:
+	if (ret)
+		dev_err(dev, "failed to resume QPaCE: %d\n", ret);
+	mutex_unlock(&qpace_ref_lock);
+	return ret;
+}
+
+static DEFINE_SIMPLE_DEV_PM_OPS(qpace_pm_ops, qpace_suspend, qpace_resume);
+
+static struct platform_driver qpace_driver = {
+	.probe = qpace_probe,
+	.remove = qpace_remove,
+	.driver = {
+		.name = "qcom-qpace",
+		.of_match_table = qpace_match_table,
+		.pm = pm_sleep_ptr(&qpace_pm_ops),
+	},
+};
+
+module_platform_driver(qpace_driver);
+
+MODULE_DESCRIPTION("Qualcomm Page Compression Engine driver");
+MODULE_LICENSE("GPL");
diff --git a/drivers/soc/qcom/qpace_internal.h b/drivers/soc/qcom/qpace_internal.h
new file mode 100644
index 000000000000..7e18d442e32f
--- /dev/null
+++ b/drivers/soc/qcom/qpace_internal.h
@@ -0,0 +1,84 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+ */
+
+#ifndef __QPACE_INTERNAL_H__
+#define __QPACE_INTERNAL_H__
+
+#include <linux/bits.h>
+#include <linux/bitfield.h>
+
+/* hardware definitions and opcode values */
+#define NUM_TRS_ERS_URG_CMD_REGS 8
+#define QPACE_HW_VERSION_V2 0x2000000
+#define DEFAULT_SMMU_CONTEXT 0
+
+#define LZ4_COMP 0x9
+#define LZ4_DECOMP 0xa
+
+#define OP_OK 0x0
+#define OP_BUS_ERROR 0x1
+#define OP_COMP_TOO_BIG 0x2
+#define OP_TIMED_OUT 0x5
+#define OP_URG_ONGOING 0xf
+
+#define LLC_ALLOC 0x1
+
+#define URG_CMD_CONTEXT_SPACING 0x10
+
+#define QPACE_RUN 0x1
+#define QPACE_STOP 0x0
+#define QPACE_STATE_CHANGE_TIMEOUT_US 10000
+
+/* register offsets */
+#define QPACE_GEN_CORE_REGS_OFFSET 0x1000
+#define QPACE_COMP_CORE_REGS_OFFSET 0x2000
+#define QPACE_DECOMP_CORE_REGS_OFFSET 0x6000
+#define QPACE_URG_REGS_OFFSET 0x10000
+
+#define QPACE_CORE_HW_VERSION_OFFSET 0x0
+#define QPACE_CORE_QNS4_CFG_OFFSET 0x14
+#define CORE_QNS4_CFG_CACHEINDEX GENMASK(17, 12)
+
+#define QPACE_CORE_GEN_CFG_OFFSET 0x18
+#define CORE_GEN_CFG_QMB2_MAX_RD_OUTST_LIMIT GENMASK(13, 7)
+#define CORE_GEN_CFG_QMB2_MAX_WR_OUTST_LIMIT GENMASK(6, 0)
+
+#define QPACE_CORE_URG_CMD_n_CACHEINDEX_CFG_OFFSET 0x2fc
+#define CORE_URG_CMD_n_CACHEINDEX__ENGINE_CACHEINDEX_OVERRIDE BIT(6)
+#define CORE_URG_CMD_n_CACHEINDEX__ENGINE_CACHEINDEX GENMASK(5, 0)
+
+#define QPACE_CORE_OPER_CORE_RUN_STOP_OFFSET 0x0
+#define QPACE_CORE_OPER_CORE_READY_OFFSET 0x4
+#define QPACE_CORE_OPER_CFG_OFFSET 0x8
+#define CORE_OPER_CFG_COMP_MEM_PWR_DWN_1 BIT(3)
+
+#define QPACE_COMP_CORE_CFG_OFFSET 0x0
+#define COMP_CORE_CFG_DMA_WR_MAX_OT GENMASK(17, 13)
+#define COMP_CORE_CFG_DMA_RD_MAX_OT GENMASK(12, 8)
+#define QPACE_COMP_CORE_BULK_MODE_OFFSET 0x4
+#define COMP_CORE_BULK_MODE_ALL_CORES GENMASK(5, 0)
+
+#define QPACE_DECOMP_CORE_CFG_OFFSET 0x0
+#define DECOMP_CORE_CFG_DECOMP_DMA_MEM_MNG_PAGE_SIZE GENMASK(12, 10)
+#define DECOMP_CORE_CFG_DMA_WR_MAX_OT GENMASK(9, 5)
+#define DECOMP_CORE_CFG_DMA_RD_MAX_OT GENMASK(4, 0)
+
+#define QPACE_URG_CMD_0_TD_DST_ADDR_L_CFG_CNTXT_OFFSET 0x0
+#define URG_CMD_0_TD_DST_ADDR_L__CMD_CFG_CNTXT GENMASK(3, 0)
+#define QPACE_URG_CMD_0_ED_STAT_OFFSET 0x18
+#define URG_CMD_0_ED_STAT_COMP_CODE GENMASK(23, 20)
+#define URG_CMD_0_ED_STAT_SIZE GENMASK(19, 0)
+#define QPACE_URG_CMD_0_STAT_CLR_OFFSET 0x28
+#define URG_CMD_0_STAT_CLR_REQ_ON_ACTIVE_ERR BIT(1)
+#define QPACE_URG_CMD_0_CFG_CNTXT_SIZE_n_OFFSET 0x40
+#define URG_CMD_0_CFG_CNTXT_SIZE_SIZE GENMASK(19, 0)
+#define QPACE_URG_CMD_0_CFG_CNTXT_MISC_n_OFFSET 0x48
+#define URG_CMD_0_CFG_CNTXT_MISC_WA BIT(21)
+#define URG_CMD_0_CFG_CNTXT_MISC_DCTX GENMASK(17, 16)
+#define URG_CMD_0_CFG_CNTXT_MISC_SCTX GENMASK(15, 14)
+#define URG_CMD_0_CFG_CNTXT_MISC_PAGE_CNT GENMASK(13, 8)
+#define URG_CMD_0_CFG_CNTXT_MISC_OPER GENMASK(7, 4)
+
+#endif /* __QPACE_INTERNAL_H__ */
diff --git a/include/linux/soc/qcom/qpace.h b/include/linux/soc/qcom/qpace.h
new file mode 100644
index 000000000000..7ef7d12c4e66
--- /dev/null
+++ b/include/linux/soc/qcom/qpace.h
@@ -0,0 +1,154 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+ */
+
+#ifndef __LINUX_SOC_QCOM_QPACE_H
+#define __LINUX_SOC_QCOM_QPACE_H
+
+#include <linux/device.h>
+#include <linux/dma-mapping.h>
+#include <linux/errno.h>
+#include <linux/kconfig.h>
+#include <linux/types.h>
+
+/**
+ * struct qpace_algorithm - Descriptor for a QPaCE compression algorithm.
+ * @name:            Algorithm name string (e.g. "qpace-lz4").
+ * @comp_opcode:     Hardware opcode for compression.
+ * @decomp_opcode:   Hardware opcode for decompression.
+ * @unused:          Reserved bits.
+ * @urg_comp_cntxt:  Urgent-path context index for compression.
+ * @urg_decomp_cntxt: Urgent-path context index for decompression.
+ */
+struct qpace_algorithm {
+	char *name;
+	u32 comp_opcode:4;
+	u32 decomp_opcode:4;
+	u32 unused:24;
+	int urg_comp_cntxt;
+	int urg_decomp_cntxt;
+};
+
+#if IS_ENABLED(CONFIG_QCOM_PAGE_COMPRESSION_ENGINE)
+
+/**
+ * qpace_is_valid_algorithm() - Check if a name identifies a supported QPaCE algorithm.
+ * @algo_name: Algorithm name string to check.
+ *
+ * Returns true if @algo_name matches a QPaCE algorithm and the driver has
+ * probed successfully, false otherwise.
+ */
+bool qpace_is_valid_algorithm(const char *algo_name);
+
+/**
+ * qpace_lz4_algorithm - Algorithm descriptor for QPaCE LZ4.
+ *
+ * Pass to qpace_urgent_compress() and qpace_urgent_decompress() to select
+ * the LZ4 algorithm.
+ */
+extern const struct qpace_algorithm qpace_lz4_algorithm;
+
+/**
+ * qpace_is_dev_available() - Check whether the QPaCE hardware is ready.
+ *
+ * Returns true if the driver has probed successfully and the hardware is
+ * available for use, false otherwise.
+ */
+bool qpace_is_dev_available(void);
+
+/**
+ * qpace_urgent_compress() - Compress a page synchronously via the urgent path.
+ * @input_addr:  DMA address of the page to compress.
+ * @output_addr: DMA address to write the compressed output to.
+ * @algo:        Algorithm descriptor to use.
+ *
+ * Blocks the calling CPU until compression completes. May sleep; must not be
+ * called from atomic or IRQ-disabled context.
+ *
+ * Return: Compressed size in bytes on success, negative error code on failure.
+ */
+int qpace_urgent_compress(dma_addr_t input_addr,
+			  dma_addr_t output_addr,
+			  struct qpace_algorithm *algo);
+
+/**
+ * qpace_urgent_decompress() - Decompress a page synchronously via the urgent path.
+ * @input_addr:  DMA address of the compressed input.
+ * @output_addr: DMA address to write the decompressed output to.
+ * @input_size:  Size of the compressed input in bytes.
+ * @algo:        Algorithm descriptor to use.
+ *
+ * Blocks the calling CPU until decompression completes. May sleep; must not
+ * be called from atomic or IRQ-disabled context.
+ *
+ * Return: Decompressed size in bytes on success, negative error code on failure.
+ */
+int qpace_urgent_decompress(dma_addr_t input_addr,
+			    dma_addr_t output_addr,
+			    size_t input_size,
+			    struct qpace_algorithm *algo);
+
+/**
+ * qpace_get() - Acquire a reference to QPaCE, preventing runtime power collapse.
+ *
+ * Must be paired with qpace_put() on success. Callers that hold a reference
+ * will keep the hardware awake and the urgent command contexts programmed.
+ *
+ * Return: 0 on success, -EBUSY if the device is suspended.
+ */
+int qpace_get(void);
+
+/**
+ * qpace_put() - Release a reference acquired with qpace_get().
+ *
+ * When the last reference is dropped, QPaCE may enter a low-power state.
+ */
+void qpace_put(void);
+
+/**
+ * qpace_get_dma_dev() - Return the device to use for QPaCE DMA mappings.
+ *
+ * Return: Pointer to the QPaCE platform device, or NULL if unavailable.
+ */
+struct device *qpace_get_dma_dev(void);
+
+#else /* !CONFIG_QCOM_PAGE_COMPRESSION_ENGINE */
+
+static inline bool qpace_is_valid_algorithm(const char *algo_name)
+{
+	return false;
+}
+
+static const struct qpace_algorithm qpace_lz4_algorithm;
+
+static inline bool qpace_is_dev_available(void)
+{
+	return false;
+}
+
+static inline int qpace_urgent_compress(dma_addr_t input_addr,
+					dma_addr_t output_addr,
+					struct qpace_algorithm *algo)
+{
+	return -EINVAL;
+}
+
+static inline int qpace_urgent_decompress(dma_addr_t input_addr,
+					  dma_addr_t output_addr,
+					  size_t input_size,
+					  struct qpace_algorithm *algo)
+{
+	return -EINVAL;
+}
+
+static inline int qpace_get(void) { return -ENODEV; }
+static inline void qpace_put(void) {}
+
+static inline struct device *qpace_get_dma_dev(void)
+{
+	return NULL;
+}
+
+#endif /* CONFIG_QCOM_PAGE_COMPRESSION_ENGINE */
+#endif /* __LINUX_SOC_QCOM_QPACE_H */
