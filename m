Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9D9326B764
	for <linux-block@vger.kernel.org>; Sun, 26 Apr 2026 17:26:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777224418; cv=none; b=U3kSTensV91UcgzI0121HfQcryUlAnzL8ic9I5Pj1YUgWl/zd5KIfDTYDOzms8v/h/ukubhQpfeSzKeRzdwU7wqGGSMS3UXWg9oB2wDtWUVF0DJVZ8jWb4/cFm2T28LxscuEtDLPsAniAQxfC+bYV25tzn0L9Brs9CZlQCLcMgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777224418; c=relaxed/simple;
	bh=olZfzzpgNfx3fWy9cSGPG6/RfFdfAl5c4nmkGUK4Z1k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=W8cv2cKB7eChmd85MZ7L82mL+MghQlDE1V3BupiLnXj8oUz5V4lRnmAbBVuplg6bstaMVIU/jByQcebCzwHoLOQ97on5g/cfLMNdhfbOAd8F16duUeHpp++PQl3VE+whBn9vYp/UY1YNw/mtNLE7e/3NCMdO84VbzlMbCWBHM6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eGRkFPqf; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eGRkFPqf"
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-83177129e28so1419958b3a.1
        for <linux-block@vger.kernel.org>; Sun, 26 Apr 2026 10:26:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777224417; x=1777829217; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fTT+TO2xhHSlxpJL1vJszLb3/iiY49X4ai00zMg+zAI=;
        b=eGRkFPqfzdsjblpjdqPuVbhQE4ZYGf2QjaTQCqL7A++LSH9hDz/o3qW8Jv89coLYlV
         9XzcAIFeFLgvNWkWVKIHZ+HBbIRKKWbZn0XUy/f4jt2zyK0j/XpDBx0l1t1ao5ts0gP/
         fF6fzo6iPqh4oneiOwtXfa1zU6tWFONX4bjIiLpkUF8SPmnD7kIKqmjZ5KO6iUy8nRPP
         oDyMZRR51ugqQEi5ZpDzKO/gOW4O3G6Onht7tobdzLnmkV1i5R7kQtV5bMW4pWi/rkrV
         hTrWyL3EbAQYcNiEDuvVIxjmTRGDDQOXNsXjmuDb6p7zUAaRt09dq1htCuiFoDqyJ9S5
         1LZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777224417; x=1777829217;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=fTT+TO2xhHSlxpJL1vJszLb3/iiY49X4ai00zMg+zAI=;
        b=GNp5AnMr9rWJE8Dr+X6/Mi+QxXQp+dihcloYGGA/irDMfJJh9DOTzd1tJ8ANA0xFcI
         mJ5AQvcb1QZSq7sLyIANzfJRxq0rnO8uWQXjAh+v9OzHXn23LNKugpRcLA5YP25ITFg0
         8S3mQTaFisMOzfKr+BVPopYvLOtsR9xmI/AcXoRbKGXFiYrmAoTTSL1WencVZ24O9Vyv
         dgiBGYzIQWhjzBJngGOr75tvRty4fFsIIvlfEAYVUSDDqPqKyx94YQ9kxFGd/ZMPKjIi
         1xop3o9lAyw17c0GBX6JCkh27BAIQufioRibo4APa2xIOpv/oKe893zndsIpwdOBZGFA
         EBCQ==
X-Forwarded-Encrypted: i=1; AFNElJ9f3/Cg6y+MDqjmn4jd62i/8l1OL02ofA1eS0W9WJnsCdjDizFx8gbmJrivNuKaou2GRKLDqjcY6xKvow==@vger.kernel.org
X-Gm-Message-State: AOJu0YzsnMKFleuU7OHMu2U2ug2NDs+ljOrlf/3u29nUQsQJGudqEcsA
	nf1A5dfbP1+2WYvtFD6lPipLfyvvAeBQ2DdjR1XmuH5LehfrJCquqSo=
X-Gm-Gg: AeBDietIlXww4EsHsvBRrTtrd/23UC/MqLLzoJ6Xs3INUxpCRsBI/cReBfHt100qJe0
	+2F3xNafdbIB/CgLx4ETxm+AwE8IXGpFnpp5145AbQgUBpD2xeo3snJgP7DjW3Kb9DvbRtxBj9v
	ft9j87JRX4sHkZc8S5Qv5FWTMQxMUAzn14CqTE80JIz3NdlDMzNxXqyNxt2qG/YZspNiFgdPDi/
	kpBxy/ZAnBTcv/huZFm7Qv7XB+sk2AysiSmow0mjrnV4zIa0nhna5iXRqL1VvCsuUlzJqZ2ri63
	tsEfJjnSerrBnVjBXGNuL0ko993s25C6Pf3n4OczfwPKSosaUZV+mxiJxQOjxgrkBX+zJ142LoD
	dBKIoY/iEqSwqzuKaNeoBN9qywwgsP1KO8/G0D9SbcUX89Ni08QPn++zeoet2TOtq3wtCQIQldI
	H6kI3ANy4eAa8pegVzh52vvGa5LwUYVXsLbFBwbC7esWVgGPl0nogkZp+JfXLNYh9skgEDQ3Hms
	J/ZQrsyQy5b5xU=
X-Received: by 2002:a05:6a00:3690:b0:829:73f4:6ff with SMTP id d2e1a72fcca58-82f8c8df455mr41427992b3a.37.1777224416992;
        Sun, 26 Apr 2026 10:26:56 -0700 (PDT)
Received: from coe.tail83f5bd.ts.net ([202.177.225.148])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82f8ebe901csm36664856b3a.48.2026.04.26.10.26.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Apr 2026 10:26:56 -0700 (PDT)
From: Ramesh Adhikari <adhikari.resume@gmail.com>
To: gregkh@linuxfoundation.org
Cc: axboe@kernel.dk,
	linux-block@vger.kernel.org,
	security@kernel.org,
	Ramesh Adhikari <adhikari.resume@gmail.com>
Subject: [PATCH v3] block: fix infinite loop in badblocks_clear() and badblocks_check()
Date: Sun, 26 Apr 2026 22:56:40 +0530
Message-ID: <20260426172641.629158-1-adhikari.resume@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260426145527.589804-1-adhikari.resume@gmail.com>
References: <20260426145527.589804-1-adhikari.resume@gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

An infinite loop can occur in both _badblocks_clear() and _badblocks_check()
when BB_OFFSET() equals the start position, resulting in len = 0. This causes
the update_sectors loop to spin forever without making progress:

    s += 0;         // no advancement
    sectors -= 0;   // stays positive
    goto re_clear;  // infinite loop

The bug exists in three code paths:
1. _badblocks_clear() at line 1100 (start before all badblocks)
2. _badblocks_clear() at line 1153 (behind overlap check)
3. _badblocks_check() at line 1240 (behind overlap check)

Add checks in all three locations to ensure len is non-zero before
entering the loop.

Signed-off-by: Ramesh Adhikari <adhikari.resume@gmail.com>
---
 block/badblocks.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/block/badblocks.c b/block/badblocks.c
index ece64e76fe8..9dd2d921e1b 100644
--- a/block/badblocks.c
+++ b/block/badblocks.c
@@ -1098,6 +1098,10 @@ static bool _badblocks_clear(struct badblocks *bb, sector_t s, sector_t sectors)
 	if (prev < 0) {
 		if (overlap_behind(bb, &bad, 0)) {
 			len = BB_OFFSET(p[0]) - s;
+			if (len == 0) {
+				pr_warn_once("badblocks_clear: zero-length at start\n");
+				len = 1;
+			}
 			hint = 0;
 		} else {
 			len = sectors;
@@ -1151,6 +1155,10 @@ static bool _badblocks_clear(struct badblocks *bb, sector_t s, sector_t sectors)
 	/* Not front overlap, but behind overlap */
 	if ((prev + 1) < bb->count && overlap_behind(bb, &bad, prev + 1)) {
 		len = BB_OFFSET(p[prev + 1]) - bad.start;
+		if (len == 0) {
+			pr_warn_once("badblocks_clear: zero-length segment detected\n");
+			len = 1;
+		}
 		hint = prev + 1;
 		/* Clear non-bad range should be treated as successful */
 		cleared++;
@@ -1234,6 +1242,10 @@ static int _badblocks_check(struct badblocks *bb, sector_t s, sector_t sectors,
 	/* Not front overlap, but behind overlap */
 	if ((prev + 1) < bb->count && overlap_behind(bb, &bad, prev + 1)) {
 		len = BB_OFFSET(p[prev + 1]) - bad.start;
+		if (len == 0) {
+			pr_warn_once("badblocks_check: zero-length segment detected\n");
+			len = 1;
+		}
 		hint = prev + 1;
 		goto update_sectors;
 	}
-- 
2.43.0

