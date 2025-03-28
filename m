Received: from mail-qv1-f99.google.com (mail-qv1-f99.google.com [209.85.219.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1F9D440C
	for <linux-block@vger.kernel.org>; Fri, 28 Mar 2025 19:42:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743190964; cv=none; b=WYeHFfs8XjCDemSRP5PeCqfZCmoc54DSN2sIa08IbRFTZTku/2uYbEsgEiDefLasETJTYUBDmq3pivIokR7Ko07Y6AGoC8JsyObdbcgfC/50njkEomMSB8kp0X934lP4+VpbRPU350hW12W+ZEfzKD5EDPPMJ5XZKG3KeFusBEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743190964; c=relaxed/simple;
	bh=IIFz4j2C2Eh7fAQD0vF3myZwWOH3MPOPveM/pvRkH1c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DhQz8IZdDGPaZwT4KEWMfSaCo4vRGI7y73LmHcRWdPt4fZWjAV9minYCM/XUCFUhLuZu2AYSski4R8LzhnqjdigeX9lZoQ4rMiwO4j5qy0TsYyfXH00CF9/f0nnBcXvjvk6xeKEX3JeK8kqQxFaKa3/5xZ7paJgKTmdaMHfHBSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=dcPP/t60; arc=none smtp.client-ip=209.85.219.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="dcPP/t60"
Received: by mail-qv1-f99.google.com with SMTP id 6a1803df08f44-6e8fa2d467fso3629886d6.2
        for <linux-block@vger.kernel.org>; Fri, 28 Mar 2025 12:42:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1743190961; x=1743795761; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lLazX2sR1QiGKeTx3lHr1mcmdxpFqxEOFWM2x5oC3Fg=;
        b=dcPP/t60EJ04nWA4KNJSsA28QsWcIhbE+btJeaFWjL8RBB9EWMcwDo7Jrw3pJ0a6Uy
         OUhC42H5kJO3/3DtTC+OXjC963gJ5P3BfRtSvJ9BVfZdq4EIToMyLzU1MClaCAhc10qp
         xpNSJ3Cq59ANj2a+VWs4SM18EBFgaM35wCrAB1PG1XZxXOpEPWt3iJ2aXGneAIiwhqrJ
         z3FJA8V4LTgpMvSjhokkSeZYcTaM6eamUnAwMZRf/nkOnNjcfUb2KmXip3e12QRLtfSG
         YMJ7LFo+ZE6aTGjH+xqiRcMq47/kYEOogqoLH+sTsIuP/xHQgktgLq+s3usLAuVQwJdS
         PlaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743190961; x=1743795761;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lLazX2sR1QiGKeTx3lHr1mcmdxpFqxEOFWM2x5oC3Fg=;
        b=C57fP3MzrRxyQAsbir4Nnv6dHu434Ox+2HwtXMNHUyR4a5FXc+geAcRt2xKR5fCCWX
         TY3e+G4SjqYZDySYzl5KIZnbMGrsj8E9EwMZThNWf8XGaZcDPZLyB+OaX21xZ6QWweDw
         538IE/8A25DuAtZr/wLf67afzeRburw6sULJDdJsZVDkOsoo08TP7KWC2peEOh7S96G7
         aOq58OvRnpyxKVWSuAQfEoe5V7A/ALGlzOpsX/HnOTMO3BusNTx8pDfxzT99HhEWFPn4
         ooSKy7/5UbVt3e11259sXAP6C5oXRhJhFvnj8OKG/0WePNut2HNxHFGbzwCt3vUAEN8u
         L88g==
X-Gm-Message-State: AOJu0YyGnEfYxVsZDMqBAtezGNf5uXBCqprWMbGhO3iLv+rz5/buA7PE
	H/jXXkBIqkH5m4M+FP3N5xKWu+wnmaxNFfnQdDSC18jP49lTADvwBvdRzpSMaxNnVOhiCCla/kP
	HP1lzMN559bUWbzCSzpxGtpr+lxeswCuD
X-Gm-Gg: ASbGncs0NzCOsTEBeIOOGQItl0qZwjFM/q5QdO4YYEZnxnXYf5i6lLz7yjRSKknxC/i
	MKsVah3LOSczWdNEkoe9DwcOS0Yi23/bnn1zFkhzoPyiQH8X6Wo2FuNF5RRf/fE+dOkwUl1hq/9
	2ovGv49IWFjIPy2TxwHDu3vDHJp8Ei7EzKpxLk6fAyM7Cxplv33ixMHUGZ9c9VncpObahugvlET
	FBg2cslx2T1vWbFBMWTZYWOkapa32F7TYJaRNCvXaJzRSk5iL3BKLA7zdpT1IhLyqlwysxybHXf
	MQoPFKAVwHwQUOYgnVbszHpSQTdRYGZ9AWs3W6ZXiRGZHCqH
X-Google-Smtp-Source: AGHT+IGTVuJ9wsa8D0YOPf/IR0bLXPoK/A+oaStmp2cHkFUKuudrLMCf9S4wmCfByWcdBV5jz2al3JueEfox
X-Received: by 2002:a05:622a:110f:b0:474:e996:197a with SMTP id d75a77b69052e-477ed7b2291mr3086091cf.10.1743190960620;
        Fri, 28 Mar 2025 12:42:40 -0700 (PDT)
Received: from c7-smtp-2023.dev.purestorage.com ([208.88.159.129])
        by smtp-relay.gmail.com with ESMTPS id d75a77b69052e-47782a2849asm2198541cf.6.2025.03.28.12.42.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Mar 2025 12:42:40 -0700 (PDT)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (dev-csander.dev.purestorage.com [10.7.70.37])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id 8A3F73402DD;
	Fri, 28 Mar 2025 13:42:39 -0600 (MDT)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id 8669BE40DF3; Fri, 28 Mar 2025 13:42:39 -0600 (MDT)
From: Caleb Sander Mateos <csander@purestorage.com>
To: Ming Lei <ming.lei@redhat.com>,
	Jens Axboe <axboe@kernel.dk>,
	Shuah Khan <shuah@kernel.org>
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Caleb Sander Mateos <csander@purestorage.com>
Subject: [PATCH 1/2] ublk: specify io_cmd_buf pointer type
Date: Fri, 28 Mar 2025 13:42:29 -0600
Message-ID: <20250328194230.2726862-2-csander@purestorage.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250328194230.2726862-1-csander@purestorage.com>
References: <20250328194230.2726862-1-csander@purestorage.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

io_cmd_buf points to an array of ublksrv_io_desc structs but its type is
char *. Indexing the array requires an explicit multiplication and cast.
The compiler also can't check the pointer types.

Change io_cmd_buf's type to struct ublksrv_io_desc * so it can be
indexed directly and the compiler can type-check the code.

Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
---
 drivers/block/ublk_drv.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index 355a59c78539..ed73e2ffdf09 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -153,11 +153,11 @@ struct ublk_queue {
 	int q_id;
 	int q_depth;
 
 	unsigned long flags;
 	struct task_struct	*ubq_daemon;
-	char *io_cmd_buf;
+	struct ublksrv_io_desc *io_cmd_buf;
 
 	bool force_abort;
 	bool timeout;
 	bool canceling;
 	bool fail_io; /* copy of dev->state == UBLK_S_DEV_FAIL_IO */
@@ -701,15 +701,15 @@ static inline bool ublk_rq_has_data(const struct request *rq)
 }
 
 static inline struct ublksrv_io_desc *ublk_get_iod(struct ublk_queue *ubq,
 		int tag)
 {
-	return (struct ublksrv_io_desc *)
-		&(ubq->io_cmd_buf[tag * sizeof(struct ublksrv_io_desc)]);
+	return &ubq->io_cmd_buf[tag];
 }
 
-static inline char *ublk_queue_cmd_buf(struct ublk_device *ub, int q_id)
+static inline struct ublksrv_io_desc *
+ublk_queue_cmd_buf(struct ublk_device *ub, int q_id)
 {
 	return ublk_get_queue(ub, q_id)->io_cmd_buf;
 }
 
 static inline int __ublk_queue_cmd_buf_size(int depth)
-- 
2.45.2

