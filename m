Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 403A521FF49
	for <linux-block@vger.kernel.org>; Sun, 27 Jul 2025 16:47:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753634843; cv=none; b=XE80jI5hN11+/OO8NY9uLdGDDCjTqUVe0SEF07YBPtafxkZfZNIP57RKNgW1pz7Phur0FP0R0Rg0W6hpni9ck+hfz0BLjmymOsK4UMXAITjOhelhaXHOGMvNUvmMvqPULAdWiwedennQ3dYgLGi+bTiOQIGqTtVyzfq5VgXrJSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753634843; c=relaxed/simple;
	bh=I3xew8je8GRIx1/aB/St3V1iUJkyLvLXJlWO4o8KLoY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mTw9x+cTQxyTT3IvUY9k0xl8zn/i63yFFqRXTCN9DlrxcIotT+giykZVC22agjlSPO+V7Beof5GmKba8urTTkLT7bR7zG3NIjbwsoQHVtdEE48XuZKEVnGktdaZ+PuR+SqwIakcYhxNn3TYN2cEMrLgRbx3wra1wPld3xku7PLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=shopee.com; spf=pass smtp.mailfrom=shopee.com; dkim=pass (2048-bit key) header.d=shopee.com header.i=@shopee.com header.b=Dd17NR6r; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=shopee.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shopee.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shopee.com header.i=@shopee.com header.b="Dd17NR6r"
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-748e378ba4fso4588703b3a.1
        for <linux-block@vger.kernel.org>; Sun, 27 Jul 2025 09:47:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shopee.com; s=shopee.com; t=1753634841; x=1754239641; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QWYCKfy27tzmCzfyC4JZHP6ASajzBlmmh8Lqhq4+b6w=;
        b=Dd17NR6rV1ZIVAWBB6atZVuY38oYNDkrMEy1LwhxI++M2WG4OaM3iR05S1yLwDxSp0
         XTEHbzQ6X+eyBEEB4eXsDkw8qT2mNQxrx346RwdPpvq7JdoGhcuHQo1loPcS46uuZSRs
         6g2YEBV6xRCovuEoaOQ5AK2F/h16HfKtiHYeQI7mNY18tUWgQEub71mf8T9C6AbcuS5Z
         ai/iITIXxcSKHCq6qjfJa2eLo+MZgq359NeYtgPyAP6KS3Kgn1cEZtErP/iXp79mbgn1
         Iqs0Toyc0oqGHGQZtTVbIKbkDw0Pg0mviogl8TWhfHk/P2GUag9/k/1yACsgAEe+kniT
         uJBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753634841; x=1754239641;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QWYCKfy27tzmCzfyC4JZHP6ASajzBlmmh8Lqhq4+b6w=;
        b=plsKLQW0FRgVg69JcdON8gt0RK90Wxts7lI2cQ137za9EpYhcKBzTJIq24f+PVSEfo
         jMRLeD17LmYea2iLrS34gOsXn02R8vw901fOEmXZFhFiQSuQD6kLgmij/+RIG83xG4MJ
         MjU54QzSdQKAPdAmdnLb5RH5uR9s59qWyrhuvc/3Ss7AzesT9678tOLfH3gMHFtYDiI1
         nmxBPBxfhxYfgG8DfCeGDvo5H+jFbzOTFoDopToS1wvOviYilSHeHE42WOu5YAKk7PX8
         Vs6byY5RH97Qk3jP4uIu3+nR9hMlO6SYvDlYGVZ+3M8YoVoDVsnHsI+dA4XBDkqA2evV
         stTA==
X-Gm-Message-State: AOJu0Yy7cpCQCLY21eZFfXrqVnvjXL6Gun3ndtB1+RX5DScjKfUTOEma
	2oERWNp0GTFLkQzX8I8ltGlZkGO6C+dwzwyPIjqEnGbOjZKQO6/uRSorkl0z8TCsaGZr18BNZe5
	gqTqt
X-Gm-Gg: ASbGncu7QeGVe4bAlnUjubSqONZLMfo0WKyaErXqXcn54PvaehMaEezZACFeVK1iSVd
	uUOV2YP0wzO0aZLyuttVCjS8T8FT2r3cleNZPQEVYR1GZieP/nh4ctxDxJSYxMBUMGyu9u+aKK1
	TP9JwLoAjvFl5VTrTlmHfhB16p9yclBXSbknCom1YH7CyncMogEr5uBrMl5Pde8+szopkewqDCD
	ZHd1dYMUSTFpdYFeM1jPIpgu8ZPcSz7QpuOx3O5vW0hI2Vi/nd6/oDUodYGkkwD6xMMhBKlBvSW
	GCR7++zwqcKkfrQYv3p+BL6HGLSY0dQbYZEpx/Q0NwrSi7XL9O69Md8v9PyLhM1kRMuDUYPeebE
	bTQ08i//uqorQpUkUcg==
X-Google-Smtp-Source: AGHT+IFRol1JcpMwHBaIr/iN69m2fbS57Zw0c2c31BLpe0M2WVnu9P/3rtcV5uRwgswPSOGO4xpIVw==
X-Received: by 2002:a05:6a00:3c88:b0:74e:ac15:10ff with SMTP id d2e1a72fcca58-76332578505mr14337976b3a.4.1753634841498;
        Sun, 27 Jul 2025 09:47:21 -0700 (PDT)
Received: from localhost.localdomain ([143.92.64.17])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7640baa00a9sm3402878b3a.140.2025.07.27.09.47.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Jul 2025 09:47:20 -0700 (PDT)
From: Tang Yizhou <yizhou.tang@shopee.com>
X-Google-Original-From: Tang Yizhou
To: axboe@kernel.dk,
	hch@lst.de,
	jack@suse.cz
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	tangyeechou@gmail.com,
	Tang Yizhou <yizhou.tang@shopee.com>
Subject: [PATCH v2 2/3] blk-wbt: Eliminate ambiguity in the comments of struct rq_wb
Date: Mon, 28 Jul 2025 00:47:08 +0800
Message-Id: <20250727164709.96477-3-yizhou.tang@shopee.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250727164709.96477-1-yizhou.tang@shopee.com>
References: <20250727164709.96477-1-yizhou.tang@shopee.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Tang Yizhou <yizhou.tang@shopee.com>

In the current implementation, the last_issue and last_comp members of
struct rq_wb are used only by read requests and not by non-throttled write
requests. Therefore, eliminate the ambiguity here.

Signed-off-by: Tang Yizhou <yizhou.tang@shopee.com>
Reviewed-by: Jan Kara <jack@suse.cz>
---
 block/blk-wbt.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/block/blk-wbt.c b/block/blk-wbt.c
index 30886d44f6cd..eb8037bae0bd 100644
--- a/block/blk-wbt.c
+++ b/block/blk-wbt.c
@@ -85,8 +85,8 @@ struct rq_wb {
 	u64 sync_issue;
 	void *sync_cookie;
 
-	unsigned long last_issue;		/* last non-throttled issue */
-	unsigned long last_comp;		/* last non-throttled comp */
+	unsigned long last_issue;	/* issue time of last read rq */
+	unsigned long last_comp;	/* completion time of last read rq */
 	unsigned long min_lat_nsec;
 	struct rq_qos rqos;
 	struct rq_wait rq_wait[WBT_NUM_RWQ];
-- 
2.25.1

