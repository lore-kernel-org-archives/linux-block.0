Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD726223707
	for <linux-block@vger.kernel.org>; Tue, 18 Nov 2025 01:26:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763429214; cv=none; b=ehytMGNE4byjqApQA5C7KWNZ5hkY1H3yZNkfkBP0ZWDIRMLZ8Tp4mUwmB/W+UHJKnbXiA9LOwzlqGgVtLvZjVk5zsw9Pyov/xW4YXDOfso29GT80XXLV7XBuJNYLCx0AnjpgQ9bFMmSKzyBWxbckjBs7xDFpdNySXG8C+VrApuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763429214; c=relaxed/simple;
	bh=8DgTvX9/tmFdz2BTiR/YXf2mUeSpbDBul8RW04sYUWc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=McjyLMso0PRP4adgw4SPux4liTPHbDnRFPEqSltppkwrVeccQDLs7+a1Ga4h7ConqMOwymrvPG8gDxazjVTjvlrb1YRFGyKB2D5PRWVj/OTRTlj+5I2a0mRnE7RG8dcIJqFhQDsNKuxT2F2FCYooHQcqo3S825PAXYX1lSJBKDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RvARgYBO; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RvARgYBO"
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-7ba49f92362so3737950b3a.1
        for <linux-block@vger.kernel.org>; Mon, 17 Nov 2025 17:26:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763429212; x=1764034012; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=B6Ym+T20hVWXlaRGmM+QBpRQedYGM/SmJuXUHhyOXzI=;
        b=RvARgYBOUyNN3Weq2LYGg2Hm+qJufb4bv8kGWZUxJzPDEihMIl2VA/dV0pE8Pq1xZZ
         GOvBAtMTnpxJzhdMaa9YMnjlriFwj++yPzoRHO4eeivmKZNACSZIKCTbkF7Fgbt0AeKr
         Z4MbcNNmcaDAYAineRpLD0+9sXiC/aIBr3FlYQMAHlnvGUxypBDoZ+5qg/P6eWTQ1Pfq
         q8meIs0DP44nH+ABgAQvCPvHJ7pJmkBehZdogz4oTS/HkgaLdRKBf4jmsUXvTwhY1cqK
         JoQYukb9/vc1gw3aaXSDEukul1BfiGblvn1qA2Y8gWI35+zedIMikC2JWHlz7jqcbTRa
         FXDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763429212; x=1764034012;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B6Ym+T20hVWXlaRGmM+QBpRQedYGM/SmJuXUHhyOXzI=;
        b=cWWl/XwJdwDYHHdYNWn7YN6nr9EeDZwkmp7PW4Swk41YCRBB5ZgTLJLFocobcWOrro
         9wXk37embJU4o139/uQmyb/n1eg/LvdB+I0jmLGysabwPye7knGOK7uiQG/0V8It5KiS
         Q99iGamVKoSb0zS8Dz1JYL4OKfA6G+Nc0tV3aY8cuzDr4yrr3gOxjwkVcd9Q+HyMc7d/
         9XAp8VgEyV5PuhPMIFVWXqRot6zIDqtppbfY5u3WzPggRF4Jm7+ffTRZTzs3tX7pKJfR
         DY0kMQFtzY8JuhHJpqm0wgKDPv4yefu3CEXix9+pH2BWg4l11cihhpFhGoTggd0y3/l8
         8Bsg==
X-Gm-Message-State: AOJu0YylB4mY72EgJgC6XCbqm5Beo+WdrwXzN02rfhTzFdJ0Cd7WKMCV
	AL8v9UmXkiSXf75ejxdhq2BY8RWuz2kcbWu9n8SMa8sukPdAqIZmkn/C
X-Gm-Gg: ASbGncsy6vyAe+cL4H1XrBgbaG811Otr70ZqcwzVel+IOi+l89dp3sp3DG3bo71HpGj
	BzXAW1BftFBE8kgXDvDFc0McHYlypHmratqXmqOjNQSr79SKIHvKqeH3zs84w/cmOewqCdEqh37
	R4YfM8mrwdj8q9NYCkeoWcQCYP1PQwNukf17EC7EW9saD9/pT5jof5191+zATO7A6+AR7fsvF0e
	3wClGhADsefFUPBwYRVKSM4FjUjd7QtuN/ZVNvVTp0d5Y8z8PpqZWlCWCvgcOFl3l1+a6pfvqjh
	r9Bv3zyP/oYVrsNogYUWf41K4+evdQXap3gzI4ZTLBfceqQlUp7/RfPgWnOtyKbu0DivYNdNTX0
	dzihyjJL1X7ye0gF9uoz85e92hwyv5YP/SImoHWPSYW9imsUUwTgHpVDXvOT2aJwexAx+zRU+x6
	TSCP6D+NsAgexhn6ir4G/5A6TQxkoGo/oK
X-Google-Smtp-Source: AGHT+IH8T4EEwMEZsayxuRaGnvhJKTgJvcjbcnBK4KrZ0kT0HT+jsJds0+3iGVvInNkoxVne2VbX6A==
X-Received: by 2002:a05:6a00:124e:b0:776:19f6:5d2f with SMTP id d2e1a72fcca58-7c1306060famr1531006b3a.11.1763429212175;
        Mon, 17 Nov 2025 17:26:52 -0800 (PST)
Received: from localhost.localdomain ([116.128.244.171])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7b924aed60bsm14597699b3a.4.2025.11.17.17.26.50
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 17 Nov 2025 17:26:51 -0800 (PST)
From: chengkaitao <pilgrimtao@gmail.com>
To: axboe@kernel.dk
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Chengkaitao <chengkaitao@kylinos.cn>
Subject: [PATCH] block: remove the declaration of elevator_init_mq function
Date: Tue, 18 Nov 2025 09:26:44 +0800
Message-ID: <20251118012644.61754-1-pilgrimtao@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chengkaitao <chengkaitao@kylinos.cn>

In commit 1e44bedbc921 ("block: unifying elevator change"), the
elevator_init_mq function was deleted, but its declaration in elevator.h
was overlooked. This patch fixes it.

Signed-off-by: Chengkaitao <chengkaitao@kylinos.cn>
---
 block/elevator.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/block/elevator.h b/block/elevator.h
index c4d20155065e..07c521c8cfec 100644
--- a/block/elevator.h
+++ b/block/elevator.h
@@ -147,7 +147,6 @@ extern bool elv_attempt_insert_merge(struct request_queue *, struct request *,
 				     struct list_head *);
 extern struct request *elv_former_request(struct request_queue *, struct request *);
 extern struct request *elv_latter_request(struct request_queue *, struct request *);
-void elevator_init_mq(struct request_queue *q);
 
 /*
  * io scheduler registration
-- 
2.50.1 (Apple Git-155)

