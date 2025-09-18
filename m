Received: from mail-qv1-f98.google.com (mail-qv1-f98.google.com [209.85.219.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E079824418F
	for <linux-block@vger.kernel.org>; Thu, 18 Sep 2025 01:50:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758160243; cv=none; b=u7TiXMhrdHQLF3G+LlrIM2n3c7ZFoGUifZvG48NuK1v/yIqiWz9av8gUKNX+QTPJr5NxWcxmbYfaxJCLZe0VuEZiEJA9BMEwE0tmMwmjvDaoIL+pxtqUkiJVEGPNFTkg4YebIib+XUbRmuGPLxklzbuMYJv+b/rVuegrlAzQgBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758160243; c=relaxed/simple;
	bh=c6RQ+BNEdeNwCxnWN7FfIQhLAKW5YX5ymjHB/hiq8k8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ieR2gps4NFdmwugip+qqwIznk0B8D8W4ITteDxTuqwBMdTvoLhyToADVeQU9y9DcQuKPo7qpVaXjusRi4hlemZAVJPKC2RzJOUaaKOEFHwzYSBGWLFQ4xSeOMm2iNqDC5K6DQ9GXps+VuTXjGdNUFZY98V0WzOOP46S01Ur1N2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=bh1sO2k2; arc=none smtp.client-ip=209.85.219.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="bh1sO2k2"
Received: by mail-qv1-f98.google.com with SMTP id 6a1803df08f44-745ade243edso529146d6.0
        for <linux-block@vger.kernel.org>; Wed, 17 Sep 2025 18:50:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1758160239; x=1758765039; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Tz73FTq7ab4TFen3lM78IPlNs2F8DXtU0PujcZeWTLo=;
        b=bh1sO2k2153mMQhs8RRCFvS6DBVodsvlQADDN8qwVu/exXOFla5omtp8/8qHdInBNt
         FsPbk6yCjVIGyzkCqFxFQgUZBoNLos4yzdM6OEzDMQJjTj3NSNfZkzLB79SkEaoonybL
         wojrOAKnOnSfE0r/afD+wr5BQnZB854Jlfs26vjs11yWUKmIlrGE2eB6OkX/5XADlzw+
         3BzLmOuRxbZY60kJGn+1sQrgb+UTvgFl4Cq+qY4rx00LctJhLHtxfy6DCVZ+7+AJpGLz
         6mRjRtj8tRg6V6+l/zJQqUZXzf77mFWBHPVA/jsWB2swFo10chJJjst3dt//aPkk/wGl
         /9wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758160239; x=1758765039;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Tz73FTq7ab4TFen3lM78IPlNs2F8DXtU0PujcZeWTLo=;
        b=q8zYYvVdpZIPNNgY+MieZk52gtvAbNBTWfRBusdXydMMdBHmGkdZbgkm3Ec6oDJd60
         HSCRvOeQuM3E9CWE/3YhRS2rGmbvuWSff8kUej9KgS00+tmekmtMPFIidzKPsNKT8zHw
         aRww+BqH0S8FvkBK+H1LuE+XxjFbVyseXA3Z6vUntFINDgySJuupXJrsa9IrFoXOoAGG
         KitphNTdUtkTMHXIRtItCDhqPrQUW8M4wdnZYMRTYU7z4hQ4wsMFANsYQZcJrwTQOBvD
         0IGU92NcuRtB0JDiLnsRDIWPsjmZH8BKZnRV/dSgWY8ZFuW7ELxyvfMRH5ofIJqdxxSy
         TdSQ==
X-Gm-Message-State: AOJu0YxqXTGBwbbpv074tAjHi1SJ+5jUTT/yurkHQleWSSMgWn8+SzNC
	19zAmeMohXpu+LDZpx58e9pOUlA0lvKPbI8pD4bYCpKq27XexqRsj73uxrgpU+ZilHn9lQQmeDB
	KNmLfkfghI0PuCqOeqGNOXvuLcLT96L0ZFY3d
X-Gm-Gg: ASbGncvsYvqLl2DhLVqPdXe17vCXe73Zv/s7FxuL3TCxpUC3NgZPNe3Yck6ZLiqXXdH
	fHglootVC6APPVoGjdFFCq9y+QmVKztyWjuOLzOzRDJBN6CKHUP5gxPPxk/7H/Ep4ueFSp0d4vL
	3nbxQO16POp/oUyFu1C2bWKcdTHcfHhj2OyDrwF+o8SaD7LnBn7r/rXvzZUdiohUdDM/iWZPs6T
	6kUmS28Ziy99Svw9EBY5ZOJRs0nwqlXpncLilwbR+qHNyZwZts5s3AGCZOueLMxbvxFRZZLoKpy
	xvRPD+5xxCDtLILWqu7MLIwCot2yj/NuSJ264DU24QfrokqofReWGW6qdcjGBIiSg73NTn7Q
X-Google-Smtp-Source: AGHT+IE4PJWZwvdk77SSiLKqg+5T6nEhgQ5KR/mhfh/dZfFueYMnHrVpHtzLhwrTTnJbXbFrp9pf0/HoozM0
X-Received: by 2002:ad4:5c83:0:b0:738:2797:92c7 with SMTP id 6a1803df08f44-78ecf309822mr34683716d6.7.1758160239432;
        Wed, 17 Sep 2025 18:50:39 -0700 (PDT)
Received: from c7-smtp-2023.dev.purestorage.com ([208.88.159.129])
        by smtp-relay.gmail.com with ESMTPS id 6a1803df08f44-793532b8435sm743166d6.44.2025.09.17.18.50.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Sep 2025 18:50:39 -0700 (PDT)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (unknown [IPv6:2620:125:9007:640:ffff::1199])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id D0DC034059B;
	Wed, 17 Sep 2025 19:50:38 -0600 (MDT)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id CAB18E41B42; Wed, 17 Sep 2025 19:50:38 -0600 (MDT)
From: Caleb Sander Mateos <csander@purestorage.com>
To: Ming Lei <ming.lei@redhat.com>,
	Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Caleb Sander Mateos <csander@purestorage.com>
Subject: [PATCH 13/17] ublk: don't pass ublk_queue to ublk_fetch()
Date: Wed, 17 Sep 2025 19:49:49 -0600
Message-ID: <20250918014953.297897-14-csander@purestorage.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250918014953.297897-1-csander@purestorage.com>
References: <20250918014953.297897-1-csander@purestorage.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ublk_fetch() only uses the ublk_queue to get the ublk_device, which its
caller already has. So just pass the ublk_device directly.

Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
---
 drivers/block/ublk_drv.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index 9535382f9f8e..9a726d048703 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -2204,14 +2204,13 @@ static int ublk_check_fetch_buf(const struct ublk_device *ub, __u64 buf_addr)
 		return -EINVAL;
 	}
 	return 0;
 }
 
-static int ublk_fetch(struct io_uring_cmd *cmd, struct ublk_queue *ubq,
+static int ublk_fetch(struct io_uring_cmd *cmd, struct ublk_device *ub,
 		      struct ublk_io *io, __u64 buf_addr)
 {
-	struct ublk_device *ub = ubq->dev;
 	int ret = 0;
 
 	/*
 	 * When handling FETCH command for setting up ublk uring queue,
 	 * ub->mutex is the innermost lock, and we won't block for handling
@@ -2341,11 +2340,11 @@ static int ublk_ch_uring_cmd_local(struct io_uring_cmd *cmd,
 	/* UBLK_IO_FETCH_REQ can be handled on any task, which sets io->task */
 	if (unlikely(_IOC_NR(cmd_op) == UBLK_IO_FETCH_REQ)) {
 		ret = ublk_check_fetch_buf(ub, addr);
 		if (ret)
 			goto out;
-		ret = ublk_fetch(cmd, ubq, io, addr);
+		ret = ublk_fetch(cmd, ub, io, addr);
 		if (ret)
 			goto out;
 
 		ublk_prep_cancel(cmd, issue_flags, ubq, tag);
 		return -EIOCBQUEUED;
-- 
2.45.2

