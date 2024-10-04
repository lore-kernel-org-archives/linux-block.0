Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C54241D5CC3;
	Fri,  4 Oct 2024 12:39:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728045589; cv=none; b=SFN6w7KtL2FPD9OG/x/M2I10vk1lD/HTSajWtONSGM/WCAaqP+XIAFZwt1Vl0/AmS8wOe8gR12W8qlKKhpUaofzSx8aQU9rSDgXUZJoWTkAOPJAqf0PMXpEShI3BNcGH6mE/fIOmnDLu9VhL100Pb7pNSkWtlkiF9xPnD1AbIlw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728045589; c=relaxed/simple;
	bh=AIp8Sb9E5Fz+WpvcD+u9V4krizPFdDbX2AQ5FoKmGpc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=haoVCWE6jbcgSzrH05B1QCozJdTq+cr3n4mvmp4zfJoHeaDAZ3vksz7z26Nyzc1pU/4D1DhHEBr/3kYQkyn3MaHtUM31P1vKIhGLAaQ2f8LH29dmmfaVdc55x9cmjs2oKRvKiy61dsbYrQshId3dBiA2khYx92KyuzI7gjJKYjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NSKFZnbu; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NSKFZnbu"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-20b7eb9e81eso24000075ad.2;
        Fri, 04 Oct 2024 05:39:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728045587; x=1728650387; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=R4pe5uGwNtuOGba2q34Cr4z8s4d37tWlPOENsVKw6Kk=;
        b=NSKFZnbu9C3jW0iZkI3JMWwIa41L5W+cGPH0+bG5odaDLobgRDkBsjgXeMtrI9ml16
         D9BqeuIdlxtUFWjnCE02bCDRsQfyDA6vJd7Q4W0aW9pJajYCrKWeRrpTG/aXVOdc0eHN
         rc6sVce5yJ2wYg6myhKCHfGc2tdMqlgRtz2N6YryUpdp7z++wOQdkYrAlou2gQPKHjK1
         ZfNXNFdM6yEij9MMkQqchwjmMo9nuouE1yWEX8VYeINpp1V39KIgeHDcKfod3FJ38q27
         e5QRQaJH77vcfN2CM4Hk80UvJA+lvMcKHFOqSiV5LSWDaAFgK3q1z7OdYhP5/pSbYvYb
         Di7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728045587; x=1728650387;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=R4pe5uGwNtuOGba2q34Cr4z8s4d37tWlPOENsVKw6Kk=;
        b=QIuZ11o60zCxsaU/Ji8jN53FWZkpsFCU7sOeZgu8zK1VJ7hW67LbRamlROh1w3SNsy
         2U+0uTJH4yaO4nqde3YO/vwropHpg4M5xkB60na1q0M8SmzlUQDR1mEj62ufnIFV764K
         6xPj4r99S3sUGMzL5SfZ48rcyOIJYf5ml1JvXZIBjVhFVQK/PXvhUzcCCAkPTcjB948y
         JiooEsT3nibvnHLNIv2P0UuvejjhQOBZ53fr86ZmxsEsROrSWEaVztOnqqXnTxpG7ihm
         sP0tMV80/VgKCkflHmOybNvd9SS2r11bLgnjPX+45Gajkn8EkwmUwbEi9ZiaiM642Z4p
         fk8w==
X-Forwarded-Encrypted: i=1; AJvYcCXtYEIOzT/wg7dOw5uDAvbXPZtfCltWEVI6z/rs3zmFe8MmBPEf7gainQvlIKk1ISHrTKN/hRzMaMy3/Uw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyQsrmhMJbpZzoDew9XO1m/5iFMhZOBcYmKi1Uxj9yHIpXoOwj7
	hZQpJ0SHXaZgU3JtVakNlDnrAJqDbyCzgTyHMui7JCJeuIJLLkBH
X-Google-Smtp-Source: AGHT+IG3EQZR7ZrNyH5xNXe6CPTWG5X6RRuPMP27wu3wLUE6qkHY6N6F6EhoubsfunDfouc4XiOWFw==
X-Received: by 2002:a17:902:e882:b0:20b:9078:707b with SMTP id d9443c01a7336-20bfe02199emr32505615ad.30.1728045586991;
        Fri, 04 Oct 2024 05:39:46 -0700 (PDT)
Received: from purva-IdeaPad-Gaming-3-15IHU6.. ([2405:204:20:6275:2654:2317:92c7:7b80])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20beeca1879sm23454145ad.114.2024.10.04.05.39.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Oct 2024 05:39:46 -0700 (PDT)
From: SurajSonawane2415 <surajsonawane0215@gmail.com>
To: axboe@kernel.dk
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	SurajSonawane2415 <surajsonawane0215@gmail.com>
Subject: [PATCH] block: Fix elevator_get_default() to check for null q->tag_set
Date: Fri,  4 Oct 2024 18:09:22 +0530
Message-Id: <20241004123922.35834-1-surajsonawane0215@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix null pointer error by checking if q->tag_set is null.
Address "block/elevator.c:569 elevator_get_default() error:
we previously assumed 'q->tag_set' could be null (see line 565)"
This change prevents errors by making sure q->tag_set is valid
before accessing its flags.

Signed-off-by: SurajSonawane2415 <surajsonawane0215@gmail.com>
---
 block/elevator.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/block/elevator.c b/block/elevator.c
index 4122026b1..9ca32a6bd 100644
--- a/block/elevator.c
+++ b/block/elevator.c
@@ -562,12 +562,14 @@ static inline bool elv_support_iosched(struct request_queue *q)
  */
 static struct elevator_type *elevator_get_default(struct request_queue *q)
 {
-	if (q->tag_set && q->tag_set->flags & BLK_MQ_F_NO_SCHED_BY_DEFAULT)
-		return NULL;
+	if (q->tag_set) {
+		if (q->tag_set->flags & BLK_MQ_F_NO_SCHED_BY_DEFAULT)
+			return NULL;
 
-	if (q->nr_hw_queues != 1 &&
-	    !blk_mq_is_shared_tags(q->tag_set->flags))
-		return NULL;
+		if (q->nr_hw_queues != 1 &&
+			!blk_mq_is_shared_tags(q->tag_set->flags))
+			return NULL;
+	}
 
 	return elevator_find_get(q, "mq-deadline");
 }
-- 
2.34.1

