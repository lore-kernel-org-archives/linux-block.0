Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6732A3570D3
	for <linux-block@vger.kernel.org>; Tue, 11 Nov 2025 11:59:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762862372; cv=none; b=WG0Nm7eW2/HFTvWgpDTzuvZFgo4X/Lfk1rvf7y6X1Fvct91UW97kqS517vN5QVw2RWS7hp+x2SQ9N7NWfAmoZPURDztTjgOqpSihfS+I6IEyUN/vv+cT2QEZYhjAtP9sHo293jOUYNDCrdaWoQppzw/M2n5T5e+FXAOJE7VVAI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762862372; c=relaxed/simple;
	bh=FdTXxCQ7Q6AxN4RORySKndm6mVXLyDWwpJ+4AHMhLY8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=rxTbGBN1tQBW58KfCXf+IoKZDnY28badu5hKtseLjUhX2tT0APBsPgjp17ScRxe2MgeGf5sQvfpVrIEpKoYSLIPlDgfKHkCCPXewIsNmO3d54mwpPM5W7hx5wLO+Byx99Wslf2Wbgv5gCURwD5gptNfongS2U4SsWdV0+PMR+f0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FPC0Dqnz; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FPC0Dqnz"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-29586626fbeso37026515ad.0
        for <linux-block@vger.kernel.org>; Tue, 11 Nov 2025 03:59:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762862371; x=1763467171; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=tTXQT8S4mtxd9pnn7XmlBWIFpySMyf1Ua7+YxQyn080=;
        b=FPC0Dqnzj4HlGNWiv8Jxly3ohEIHV4Xy58EnOhTIFZpk9RbinMSwmHX0/yQM5sg/H2
         grHYlQUG071UWUHA1eSBywKvueilgH1gGzm5MRscMRgVnkPIJC3o8SFWIBqF4SAHj6Uv
         GWK3TJGq2SvEUX6Jq4obhibOPZ/fc4vf/sIYZh4wZLtAZzppFPrMxhWl2N11CcmSZkQd
         TO7aGCLjHP8vLsOMgv2QSEB6gAdXu/QOyfnysNf6Jzaypk0MOKQfsa7pTuTLsXNHdWQV
         Ru2v56w/b8O/l+BThKG1H96yIbWZCs8F0YGk34S05BFWb8315Z5IimgDzJbfg7tHV84m
         HHFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762862371; x=1763467171;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tTXQT8S4mtxd9pnn7XmlBWIFpySMyf1Ua7+YxQyn080=;
        b=ihJA+L1O2eEBYIhN0h4eGxxk3nnm7Bztoyn15/Y+OGHD1KFOkxiozh1x1eIIkql1TT
         SVC4QAiej0JVXLqAqsogbUzh2TedsmBPe45/RHAaIqCedssz1dKfkyHI3rcjVkV+MFU/
         TIMZHJDWMRPPQRFYcCxQKouQNl0zQx1SYcpHbiLEDoUSXJH4ztsLEjdI7lbFcmahSdJ7
         o5UsOwBrygM9yWmEdXO6jT5C35fbwd8zZfTufFnDtDqrRrAt8N7eTGE3eIHdr2Y7xNdA
         ME5JnGbjyl8ZsCT0LGMf0H03DFaQEkWKthkpYN/v9lEM0Aq8Ljcam5YfbBeLPCcgRr7D
         H60g==
X-Gm-Message-State: AOJu0Yy7BNm0ztnVqZBWO+rnKXNPNmG6uB0lekD/xzeOZM11CDHRZe8+
	5Lp1HpK60ABJYF9ayyA2JJ0i3WX5SwUmM6DKfU7I8XauotJoLO4CAtA3
X-Gm-Gg: ASbGncuDBL5vd0+ivZ24vFojXeQ6BsxHMRi4V8cLLIw3lJWP0WN4UafX+0arHqojoKl
	n+QFCH9HjGR4e40oRF5Bbfd7Yh5cnrj87ttqqQPzURRiZ76Y2oJnV4bEwbwYBpEX9/LkZ9yhGi6
	SpJLRCI7+N3UFYtfX5okdzKSPbBhMUX9+GAIpOY1BIaOAtDHbbumwHRvphV/2/vfa0uzggr/p+C
	KqUTg6mvoSCXKD6425aF9qmMHufMy6ScC2IL6cH2ua+3g5F6+wkazwtAXcXXfPBN89n0yMpeYLY
	qPPSyOgT4R7ifpxy2mGaYWzeKnpHAgTzHU1CofS2O55vROzAGyyRf1G2al5QpU7ilqsxNcjPB2h
	4ZS9YPNJsk2o0VoqiVg2iT+4REEJ8DakbUNaNu9YHRP2Vb1+y69ZL7U3NQP+Wiz8Y3uNibtbc3J
	9QmQVjuHomIK3aNICyEL3v0R/pyWg=
X-Google-Smtp-Source: AGHT+IHEnPWDBHcMURIQBALd4LkxZ9HPi+VzFRx2yEKPAWBgCNMBIOVhcPerQghaB4Tqgzhe3hSDow==
X-Received: by 2002:a17:902:da84:b0:295:73f:90d0 with SMTP id d9443c01a7336-297e56e1cb2mr158685185ad.50.1762862370657;
        Tue, 11 Nov 2025 03:59:30 -0800 (PST)
Received: from crl-3.node2.local ([125.63.65.162])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-343bfef789esm1349609a91.1.2025.11.11.03.59.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Nov 2025 03:59:30 -0800 (PST)
From: Kriish Sharma <kriish.sharma2006@gmail.com>
To: axboe@kernel.dk
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Kriish Sharma <kriish.sharma2006@gmail.com>
Subject: [PATCH] blk-mq-dma: fix kernel-doc function name for integrity DMA  iterator
Date: Tue, 11 Nov 2025 11:58:10 +0000
Message-Id: <20251111115810.2320857-1-kriish.sharma2006@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Documentation build reported:

  Warning: block/blk-mq-dma.c:373 expecting prototype for blk_rq_integrity_dma_map_iter_start(). Prototype was for blk_rq_integrity_dma_map_iter_next() instead

The kernel-doc comment above `blk_rq_integrity_dma_map_iter_next()` used
the wrong function name (`blk_rq_integrity_dma_map_iter_start`) in its
header. This patch corrects the function name in the kernel-doc block to
match the actual implementation, ensuring clean documentation builds.

Fixes: fec9b16dc555 ("blk-mq-dma: add scatter-less integrity data DMA mapping")
Signed-off-by: Kriish Sharma <kriish.sharma2006@gmail.com>
---
 block/blk-mq-dma.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/blk-mq-dma.c b/block/blk-mq-dma.c
index a7ef25843280..b4f456472961 100644
--- a/block/blk-mq-dma.c
+++ b/block/blk-mq-dma.c
@@ -351,7 +351,7 @@ bool blk_rq_integrity_dma_map_iter_start(struct request *req,
 EXPORT_SYMBOL_GPL(blk_rq_integrity_dma_map_iter_start);
 
 /**
- * blk_rq_integrity_dma_map_iter_start - map the next integrity DMA segment for
+ * blk_rq_integrity_dma_map_iter_next - map the next integrity DMA segment for
  * 					 a request
  * @req:	request to map
  * @dma_dev:	device to map to
-- 
2.34.1

