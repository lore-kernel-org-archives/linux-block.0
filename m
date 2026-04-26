Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D65633D4F0
	for <linux-block@vger.kernel.org>; Sun, 26 Apr 2026 14:55:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777215348; cv=none; b=pB8Tc78f21uhp7SFrLBnHfRMSvkFPyaKx6FLsvOPrLpxKaT2+/akFQ//BMs+pqGJKOKwf5dTaAdJAv5ii1OOIA4PiRhrew03cZf+XrDTO0yfiey4wcvXqOM40pdmCvJaB6jODOeV+ZbrePD1W+rOW0ugWWDlsqWt6l7BQoLzrko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777215348; c=relaxed/simple;
	bh=dR3QmnLO7ffv3vbjEMfpWpjknR0gSjL/BUhU+hdxeWs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kteWrU2fFEZw6uAmTImg357gUrfb4Pjk1RHiTI1B3hDrKt6AIknHVkM7yfKExgFJAIww09hvvqdspFURnPGCfvp6bZQtvCDKlV9IyARz0sniYhzjWW9gEtv28/Co8ncpDPOFXFLeybDBZEFoKfqBTLXxd3u8isS2Qm/s04itmno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JYiGm2bP; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JYiGm2bP"
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-8296d553142so5183890b3a.3
        for <linux-block@vger.kernel.org>; Sun, 26 Apr 2026 07:55:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777215346; x=1777820146; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=EY64jp7ee1iArzqLD7zWfQPWcLfXhxgOy4Kdnx3r4UI=;
        b=JYiGm2bPTPbEK/4KUMo0llQzlDWrd6AEIyWN2OriMeadwSlrfWaAJ3BK3Z0ojzGMi/
         t8fsFKhAoM7Z82pL49/RTEVdW1SML2SaxzlEG2JVzj347cWgyX6HjmPBxDRqfdr0bCuf
         Y5KjvLrF6Jg0Ti5+K5Gsq7ogbe/6J8XZ4wiALn6ie7RUv85yuPe4HSHBvBfIRebkP0wP
         c8ochLADFJREtnYcWkypyxdHxCFAShduBOKsIn5qDKlwlYz1JZG5Duc550RYsLaBjqjc
         bcXqNS94i8XjIrhFEusVtU7Pp32Ddh5vqCAgT8ZiDjbvT0s/Zksdg2l/YNPqIcAw3bla
         IanA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777215346; x=1777820146;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EY64jp7ee1iArzqLD7zWfQPWcLfXhxgOy4Kdnx3r4UI=;
        b=C0d0J9hxGSkB1XeY9B0wW5y+TyXJfga8XWt0Hmx9RvIhk7UOzKGsN7RAZ8LvPVz7nE
         Fgw/KYkmPkPAj4VHIoCYCCSF/hgidXsHoUhPQjOY0oWCW5j0LknXN9RrzlpaBEAZTci/
         36dYf+UHnEdKQu1lTK71IJYrFmWOMV373rac8chIWqlBf33mdlfAihLAT4kEMjfyuw6u
         FbYniWQaiktncXXrmTD5PihGBJ1lJFsMZ1qJ8OtHNc5m5prj7dwDBIfCxnx5k2zZXoWi
         syU5wNZyp6NTPIJnH5rpne9leVH6CCaWfx4YNYVmCUTKtzePhz4wR/kKZ69Ql4coQw84
         alKQ==
X-Forwarded-Encrypted: i=1; AFNElJ8XzFlOBHrZKKQmHrw7tClikBzK2jZLk8bf+DvPvETUCUvWWi+oECjScuoMU5Q2QLvVDSJJuxk+c3i5cg==@vger.kernel.org
X-Gm-Message-State: AOJu0YyXlr5VakhGgx/U9DCZt60wqpt85YoGcEgKM62PIFvR2P5v0AZ+
	kaxj4Y5ckKeLhs84+3kPXN0/CQ3q7PuBkkRwpEr+BrUDcCxIWETwPQ4=
X-Gm-Gg: AeBDietaDW4JXXaLwwATHWv8MLKA+AlCehlQY4thFTo3e4eTvGKJRPsvBjZUWC+dgWo
	BEt8rAJr+rP4znYnjqvK4R/qHsrO/bNQQ9r2XB3BZD7u09R/LDuqgTiBwNntyYxfr/MjpwFdAIf
	4S4FnUD+6y3P4ElTfEQjgpwFBv6/VRresZUJKPb/n++PzxKU7VQbqljvYQwUAs9U46KzgPQu2/N
	Si+Ss0NiNr38WcLLPg6godNsvhChHRePrKsvAguJr40HoWt7X+NNdh4ZkpG3XEHp89oEL6/Tm7y
	Mp+5k6hJrFpEjegbNpm2T8+qq0xRhe7VJHQdo0Q7MDFWdhh3MUr+sHoQh1k7soWPS3wyOLc4eft
	8LNoF8m51CShRByWCXfdrSciNWdN8rKb2tqBHXdyqDaKOEe433+LJDjRXZfyz9RROxTdhIkwq4X
	hoASgoJiR39Mw0TV24uU41LaiUfw/7OU4Sb4AgyUMiynmElU7r6JiQxTy2SKaBk/66rkrb9GETQ
	KCxWcq8sPmk
X-Received: by 2002:a05:6a00:439b:b0:82f:8696:5a75 with SMTP id d2e1a72fcca58-82f8c8bb700mr41808977b3a.28.1777215346079;
        Sun, 26 Apr 2026 07:55:46 -0700 (PDT)
Received: from coe.tail83f5bd.ts.net ([137.59.92.178])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82f8e981c12sm35638227b3a.6.2026.04.26.07.55.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Apr 2026 07:55:45 -0700 (PDT)
From: Ramesh Adhikari <adhikari.resume@gmail.com>
To: gregkh@linuxfoundation.org
Cc: axboe@kernel.dk,
	linux-block@vger.kernel.org,
	security@kernel.org,
	Ramesh Adhikari <adhikari.resume@gmail.com>
Subject: [PATCH] block: fix infinite loop in badblocks_clear()
Date: Sun, 26 Apr 2026 20:25:27 +0530
Message-ID: <20260426145527.589804-1-adhikari.resume@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

An infinite loop can occur in _badblocks_clear() when BB_OFFSET(p[prev + 1])
equals bad.start, resulting in len = 0. This causes the update_sectors loop
to spin forever without making progress:

    s += 0;         // no advancement
    sectors -= 0;   // stays positive
    goto re_clear;  // infinite loop

After approximately 21 seconds, the RCU stall detector triggers and the
system becomes completely unresponsive, requiring a hard reboot.

Add a check to ensure len is non-zero before entering the loop.

Signed-off-by: Ramesh Adhikari <adhikari.resume@gmail.com>
---
 block/badblocks.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/block/badblocks.c b/block/badblocks.c
index ece64e76fe8..9ea4a067710 100644
--- a/block/badblocks.c
+++ b/block/badblocks.c
@@ -1151,6 +1151,10 @@ static bool _badblocks_clear(struct badblocks *bb, sector_t s, sector_t sectors)
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
-- 
2.43.0

