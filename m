Received: from mail-pj1-f99.google.com (mail-pj1-f99.google.com [209.85.216.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC55F42A571
	for <linux-block@vger.kernel.org>; Thu,  8 Jan 2026 09:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767864008; cv=none; b=e3NDO9l80ZfVN0pMQtebO4bGq8z/2kswLDxMdjfeaSh5CflLTBGEeLFLA74eWf/IhpWscUSzAwHsyoBGH6cJ7NphvGkeR/wL0gr4Nnzt8zFk7oxuU3ACt0nkPwDPstg9+NZM2G9UQkkZS/5K5ogxXfMnbTbYUOQbEGGOT6KcdzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767864008; c=relaxed/simple;
	bh=MFrMgizmK5MaIPV+Gko7o6kSYnpBboKUcVmDmAwyHCk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EQRNJqLWPNI/7BWUlf3ClmuxtmvO0sWUmlmcxeflmDSbcgCXrPf7+OOBr4l4EexJpt3yQinOVUPgdvcQEMWBPNbvEhHrv3guSnfRIs7S9EQoS/v5S6E+jE3DX0dDDtrxYA5pSLgYCilOZWENlc7eURT1xiy2MHRnqIXsbUb59JY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=PJhDWRyJ; arc=none smtp.client-ip=209.85.216.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="PJhDWRyJ"
Received: by mail-pj1-f99.google.com with SMTP id 98e67ed59e1d1-34e825b0c42so167452a91.1
        for <linux-block@vger.kernel.org>; Thu, 08 Jan 2026 01:20:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1767863996; x=1768468796; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MNQyNIuF0YsgyAJSwbc/xgpZYuEtibH5Z0ga5IDU7gw=;
        b=PJhDWRyJZgdhzo2osYdH0DTJHjzirGkQ/nd2uZaVlWMcOZzJyKm8pyzfSIMOFwCjNU
         9vDOfUl/uYejrQj2Ue23t/9ROQWOS0ap/5y2ruR5cYPVvAc2xLQkpuZzmYO5Ke0RSIW6
         DIkCl5jTQk7hspV6w1qhZ54u84R2s261WEYAJ5ynh/u1CZuIiAOxVcfwV6yU7bmU4xzP
         KakK/FEaRJd8EVyg4PBMHRdg6XfDhVOEfAyAk+nJwS9+bolHHBFXnVOolaSN8Dz77EZz
         yWvJ7ZVK+cBbWIMRIV+nPhSCIJ6S5TdwWH/137SRTQoY3rSmN56LN/C82oPlufqRRuVz
         LbhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767863996; x=1768468796;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=MNQyNIuF0YsgyAJSwbc/xgpZYuEtibH5Z0ga5IDU7gw=;
        b=bPRNujQK4QvDqm8c4IB0Wm3AXtvBz7DQRBePAre5Ot7dpJnx1gQkLcZdq2568Mxs2u
         lmYHkzONMNP4dfd2zB53mWFiZBexIRPNzlU0CiDckQi1qRAo4qsdoJ0t1oIyrAtamyrl
         RUPXeCl+FzVWag1caVqUgDpBNLsecMwZuZoqoMxMEf/K6lDddU/4in6fUyYTFpoHlJm1
         t85SMjrqAfK2yZrPTnzneQYeJ23gqwuYosNkxyRbReoFlji3BvBIk1MmQIRTXgkAvXPQ
         WsJCWlJogW+EmarBhg1xGWGY59viRanZ3oXxsMQcdIhly2dIKRqB/EbLNGG0+atx7c2r
         2iPA==
X-Gm-Message-State: AOJu0YyDYVlj0ZTsueKPgexhaQmeRc5pag9Cw5QLuyMuEH9JdWv9PUg2
	yR9PXLapkpll9ya+RlZt+NmMFTpWncyitB2IHbvz77bMb/Pqje8qzG52cwBeq2D2qsVwnLdi533
	e13Mq/tdIF+IWtVe4O01tGolS2La6uks6ZaZM
X-Gm-Gg: AY/fxX4Ik2TushmH46amZSemMulkNm4vSLNo7d3kkW37iDc8Iij7dOXIoUf/sknuaWm
	vQX0XTAO1BF3WxH+LmO51kcGx6aZS9Kt5E8AC0IFshoqxJwsV+mUZf4N4Rg3XqcoAz1U/XqFWZX
	EC6tsMP3/X0HipLf3zAcv+2cSC5SXARDv/yMWXsZV71kMP4BnqvWO9WmP0NtVTNMBfn6ngnsYAp
	eddqXtVZ23no+jtXZHBz1/qAu7E740x41HZegBaNhnX1e46Dx+H/9R7Qx22mhufNYiMhUy9Ynaw
	48AgVs42xFmvx+kKztOAL5qpnHyKCaIJ5K//Nq1o6e5uUOwlUfk6pWEa4pMSC46pP4wwSapdjpe
	wcBqskLnaCoGGZ4zBiT6kSruiqLjTCjR5DyE2sUoC7A==
X-Google-Smtp-Source: AGHT+IGgsECl/s5X0anN6YN0NbDvXYMzPEZuaAu3pVTMt09j26paUiPRz914MTdupMzpukRtZg1N3wOUfHwP
X-Received: by 2002:a17:90b:2e0c:b0:343:e480:49f1 with SMTP id 98e67ed59e1d1-34f68c28ea4mr3826621a91.5.1767863995746;
        Thu, 08 Jan 2026 01:19:55 -0800 (PST)
Received: from c7-smtp-2023.dev.purestorage.com ([208.88.159.129])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-34f5f8d0c46sm1010471a91.0.2026.01.08.01.19.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jan 2026 01:19:55 -0800 (PST)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (dev-csander.dev.purestorage.com [10.112.6.120])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id 294EA342170;
	Thu,  8 Jan 2026 02:19:55 -0700 (MST)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id 23952E42F2C; Thu,  8 Jan 2026 02:19:55 -0700 (MST)
From: Caleb Sander Mateos <csander@purestorage.com>
To: Ming Lei <ming.lei@redhat.com>,
	Jens Axboe <axboe@kernel.dk>,
	Shuah Khan <shuah@kernel.org>
Cc: linux-block@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Stanley Zhang <stazhang@purestorage.com>,
	Uday Shankar <ushankar@purestorage.com>,
	"Martin K . Petersen" <martin.petersen@oracle.com>,
	Caleb Sander Mateos <csander@purestorage.com>
Subject: [PATCH v4 01/19] blk-integrity: take const pointer in blk_integrity_rq()
Date: Thu,  8 Jan 2026 02:19:29 -0700
Message-ID: <20260108091948.1099139-2-csander@purestorage.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20260108091948.1099139-1-csander@purestorage.com>
References: <20260108091948.1099139-1-csander@purestorage.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

blk_integrity_rq() doesn't modify the struct request passed in, so allow
a const pointer to be passed. Use a matching signature for the
!CONFIG_BLK_DEV_INTEGRITY version.

Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
Reviewed-by: Ming Lei <ming.lei@redhat.com>
Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>
---
 include/linux/blk-integrity.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/linux/blk-integrity.h b/include/linux/blk-integrity.h
index a6b84206eb94..c15b1ac62765 100644
--- a/include/linux/blk-integrity.h
+++ b/include/linux/blk-integrity.h
@@ -89,11 +89,11 @@ static inline unsigned int bio_integrity_bytes(struct blk_integrity *bi,
 					       unsigned int sectors)
 {
 	return bio_integrity_intervals(bi, sectors) * bi->metadata_size;
 }
 
-static inline bool blk_integrity_rq(struct request *rq)
+static inline bool blk_integrity_rq(const struct request *rq)
 {
 	return rq->cmd_flags & REQ_INTEGRITY;
 }
 
 /*
@@ -166,13 +166,13 @@ static inline unsigned int bio_integrity_intervals(struct blk_integrity *bi,
 static inline unsigned int bio_integrity_bytes(struct blk_integrity *bi,
 					       unsigned int sectors)
 {
 	return 0;
 }
-static inline int blk_integrity_rq(struct request *rq)
+static inline bool blk_integrity_rq(const struct request *rq)
 {
-	return 0;
+	return false;
 }
 
 static inline struct bio_vec rq_integrity_vec(struct request *rq)
 {
 	/* the optimizer will remove all calls to this function */
-- 
2.45.2

