Received: from mail-pj1-f98.google.com (mail-pj1-f98.google.com [209.85.216.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 547152309B9
	for <linux-block@vger.kernel.org>; Wed, 17 Dec 2025 05:35:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765949716; cv=none; b=Uf/TfqpXgLvqdbkS045K0AqobrqIhrFoQdjkHJVQ58bsPLa9qokTtguVO7H4j3XexZGWOoWs7bvGao652lRj3DIw7RbXTKyn/eqJ8cdkWq1DgdO5VePXPi1vfuLwwveQHIdArcmkXNLK/W1Ad8rHnlynODUmbN4+J79hPi5qYe8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765949716; c=relaxed/simple;
	bh=zNjQrhjX8JZLaXK8gmwe1fdVRs/ji/Di5HGBiJEYyx0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kuwG+FbatDHHBUAU/yh5c8o78dVk55ucL9Ef+vTXLrWRF2jGMVswID/2e8mG28aFEEh+UK3nWH2sbIr+FP50wn6SnqDZnldwbCBS7PGUq2v2vX5mzCv/Vo0Ne4OMjzIyOkWxXEe8Q1ZJyudYUS+JPAbAUqoOHqSs78WBRy2UBBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=BBaqLx4j; arc=none smtp.client-ip=209.85.216.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="BBaqLx4j"
Received: by mail-pj1-f98.google.com with SMTP id 98e67ed59e1d1-349e7fd4536so724940a91.3
        for <linux-block@vger.kernel.org>; Tue, 16 Dec 2025 21:35:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1765949712; x=1766554512; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gO9go+VLEnZ5bIbrwPckrpuRlhcnoKEdRdraJ94IRAM=;
        b=BBaqLx4jBKDWsJLkyxRn2FVEEgG9fSwzwFYN/ZiknLb6XqEA6xzuxlf0q/mobGPVAI
         I2C8Am9J4JaqbchMimhryyNBF7/jbw478rWHtO3RqQ3pS/XdyMHUstsw5qbzG0xMANcs
         a5O9TgVn+zdDu5G/EJf7enB5h5Zq8RFhNp+po9LOh+irieSThdOEm+JwnhRNKrF/Fw/k
         ODgU1agA1lGwdzhNNwrmY3B+RQCzl338VSlC9oB4Ob7Z1MxZcQkORAwHoEUIJgoU55c3
         jWOo2h/4IeOlU0oTN1qcRbUQkFBjQM+Tiyh3BxcNsOJ1CrnTdf+O+x7uX9JglB78KAf0
         3IBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765949712; x=1766554512;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=gO9go+VLEnZ5bIbrwPckrpuRlhcnoKEdRdraJ94IRAM=;
        b=hn5DAt5P75ojc5qOsE3jypSQZbRDzOuVtpJ9WfWdIRLW0RQnayeMv5zMw17wSamDPs
         HByKS5dhWqBkrVWC/6tw9PmSyUld+z7ciIRt5+YOiKp7vrf1fIn4YjN3BX+KdgUjmBiN
         5MGyPEujVZmqA3xzv7XnT4WTwC94np5WmQ/qn5703s+cXZkH2kG6XbtuAI0Q/ydgWRXl
         w7Be6meXfqaHpwhPxP30NeLBle5TqG5EdwpT2mevvXwxp42bOAISDsW2seOLF1ILFRtu
         j+u+vchHEQBmxX5jxte/ak4r+7NRrgvKmdRqryohPkXaqInwBgFTCCIf9FIpLZPoR9hT
         1Oww==
X-Gm-Message-State: AOJu0YyMIVEu2DCNwyfP7pKFTCQHPB2P3UsbB4riPvdxKuIxkwHSCsfI
	MRymcgaFJE11VB3EtFrqLvdRpMZtlSeeaLQ+iqdKRTmbAKqZPlSyiHiD1t7OI7fIj2xLtgOEfGo
	pXC7LWxUjecF97bEL17GLIOGjzLijJa/6OiSb
X-Gm-Gg: AY/fxX5L4Ya6i4rcZvw5mSkHFHN58OUsHe+Qg64gLc4UlKVzwVmXUex+Jebi25soEi8
	sNvaY1c2fcpAXAm33OhiWLKIENXidO0U0oriF2mOr01bB1cjwLH+8Zhf3xnk0aDe2djZ0J6wVYy
	atjxpdU9iEKtfgFkVt6sVVH65/J1Vjhq536IGmLi5T2tpvuSawUwLS5vZ5AedemBJSUmkFAw7nf
	26B+yxLxmO2lQkOKRWGWOdOA8GSZMDCV8yOm7xcmIeu8ALB87NW4YmPqH0pmjwcZYWhrvrX+DpA
	esBgPaq6ovG4y+1uOfGRoIsnv3AexdH2xVPZ+TUO2744rv9PzFn9hShJcPnKen9bA6r+BZ+lmmU
	UkzIWLw6NBt7NXf0zSxYYHxssOInawrujcv60oeWjVg==
X-Google-Smtp-Source: AGHT+IG2gaZMnrtuUwE0e3yeoSmxUpr9QSg6vaNvSXYJOUbZXsVgkWvgGHLyHIaCBfPRPU8lfsCDFHynz0Yo
X-Received: by 2002:a17:90b:2692:b0:340:e8ce:7558 with SMTP id 98e67ed59e1d1-34abd3d3a27mr11742349a91.0.1765949712374;
        Tue, 16 Dec 2025 21:35:12 -0800 (PST)
Received: from c7-smtp-2023.dev.purestorage.com ([208.88.159.128])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-34cfce259ebsm224228a91.0.2025.12.16.21.35.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Dec 2025 21:35:12 -0800 (PST)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (unknown [IPv6:2620:125:9007:640:ffff::1199])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id CC0573420F0;
	Tue, 16 Dec 2025 22:35:11 -0700 (MST)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id C9387E41A08; Tue, 16 Dec 2025 22:35:11 -0700 (MST)
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
Subject: [PATCH 04/20] ublk: add integrity UAPI
Date: Tue, 16 Dec 2025 22:34:38 -0700
Message-ID: <20251217053455.281509-5-csander@purestorage.com>
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

From: Stanley Zhang <stazhang@purestorage.com>

Add UAPI definitions for metadata/integrity support in ublk.
UBLK_PARAM_TYPE_INTEGRITY and struct ublk_param_integrity allow a ublk
server to specify the integrity params of a ublk device.
The ublk driver will set UBLK_IO_F_INTEGRITY in the op_flags field of
struct ublksrv_io_desc for requests with integrity data.
The ublk server uses user copy with UBLKSRV_IO_INTEGRITY_FLAG set in the
offset parameter to access a request's integrity buffer.

Signed-off-by: Stanley Zhang <stazhang@purestorage.com>
[csander: drop feature flag and redundant pi_tuple_size field,
 add io_desc flag, use block metadata UAPI constants]
Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
---
 include/uapi/linux/ublk_cmd.h | 20 +++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

diff --git a/include/uapi/linux/ublk_cmd.h b/include/uapi/linux/ublk_cmd.h
index ec77dabba45b..5bfb9a0521c3 100644
--- a/include/uapi/linux/ublk_cmd.h
+++ b/include/uapi/linux/ublk_cmd.h
@@ -129,11 +129,15 @@
 #define UBLK_QID_BITS		12
 #define UBLK_QID_BITS_MASK	((1ULL << UBLK_QID_BITS) - 1)
 
 #define UBLK_MAX_NR_QUEUES	(1U << UBLK_QID_BITS)
 
-#define UBLKSRV_IO_BUF_TOTAL_BITS	(UBLK_QID_OFF + UBLK_QID_BITS)
+/* Copy to/from request integrity buffer instead of data buffer */
+#define UBLK_INTEGRITY_FLAG_OFF		(UBLK_QID_OFF + UBLK_QID_BITS)
+#define UBLKSRV_IO_INTEGRITY_FLAG	(1ULL << UBLK_INTEGRITY_FLAG_OFF)
+
+#define UBLKSRV_IO_BUF_TOTAL_BITS	(UBLK_INTEGRITY_FLAG_OFF + 1)
 #define UBLKSRV_IO_BUF_TOTAL_SIZE	(1ULL << UBLKSRV_IO_BUF_TOTAL_BITS)
 
 /*
  * ublk server can register data buffers for incoming I/O requests with a sparse
  * io_uring buffer table. The request buffer can then be used as the data buffer
@@ -406,10 +410,12 @@ struct ublksrv_ctrl_dev_info {
  *
  * ublk server has to check this flag if UBLK_AUTO_BUF_REG_FALLBACK is
  * passed in.
  */
 #define		UBLK_IO_F_NEED_REG_BUF		(1U << 17)
+/* Request has an integrity data buffer */
+#define		UBLK_IO_F_INTEGRITY		(1U << 18)
 
 /*
  * io cmd is described by this structure, and stored in share memory, indexed
  * by request tag.
  *
@@ -598,10 +604,20 @@ struct ublk_param_segment {
 	__u32 	max_segment_size;
 	__u16 	max_segments;
 	__u8	pad[2];
 };
 
+struct ublk_param_integrity {
+	__u32	flags; /* LBMD_PI_CAP_* from linux/fs.h */
+	__u8	interval_exp;
+	__u8	metadata_size;
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
+#define UBLK_PARAM_TYPE_INTEGRITY       (1 << 6)
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

