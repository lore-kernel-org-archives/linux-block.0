Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DBBC23EAB2
	for <linux-block@vger.kernel.org>; Sun, 26 Apr 2026 17:11:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777223502; cv=none; b=jW2gJR3ttBCAB1M0paInksLC2mtPB4Dv9LDAmpbnWQSL6pZLa32TaxyN1mmD+yWUF0tuFEiXKYmpFJW2emtblFXVHKhHeU/khCYPliKPiHtpxNv7QsGA1Jm0HtohBLIlH/EBJZmv9iMqH/k3PPHh95yEUD57HAgk6A+IopcQeDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777223502; c=relaxed/simple;
	bh=f5KUPirb57RDjWENIHNoF8u5aH/MAhFuU6nneylvfw8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Cil1aBppHTLHpXPNIBcGMVdGEp3W2lXukSnQOndU3Taj3ztMxeOCeBGAckZbvqKq+sq8xabfnikAgxjvv6WHDwjELgF5gfi9ZFgxoT36UDfOSJdFyX/xQLWExMB9y7ApmIlhJ2sM5nuYlKOviTgWauInvMM2cn3A3rRAzp5p9+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jz7mfx57; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jz7mfx57"
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-82f6b592fc7so4215850b3a.3
        for <linux-block@vger.kernel.org>; Sun, 26 Apr 2026 10:11:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777223501; x=1777828301; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BxADud1PZirSyqdsb8JfLx0QMYvthh7FalT/vayYhIk=;
        b=jz7mfx57cm0dWlsPnPrwS6UPt2yi/12lhfEggsYMqO/Eok3VKtg5L3mUkxTpjG3Q/+
         juzvE8ZosMBU319xzVmuemBVnvT33A6vWbb39WOpAfK2qbn1LEwVLSNEiaB1mKNpAl8H
         h7nmzktt8H8UAhHf3kucljjDpkwbfcCJhtgh6uAcaqJPE/vX6NGHKeo7mvPBvF0zLUYt
         I2oUBBwgL7Zs0v+7zSeYKgUcjzm6Asis3nvHNJEnyuXjgQZTBc85svreFVD4Z5VGiVm5
         ql9YMkFzFB2Iy5v6MDI7/OTO0NaAkvHq3BsbTgqgqS9G2MyeFEwW4b3Q/mWH3KhmyxjO
         d+lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777223501; x=1777828301;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=BxADud1PZirSyqdsb8JfLx0QMYvthh7FalT/vayYhIk=;
        b=UA52MV9Z7d0muXVc21rNvNHCpeU1C8nXfvf3MzvB6jmWATSKZHKzNOEYQmQPNsUwvL
         UoQ1i7kgswofpCUnLKzFxHjENW4vw2dsOxj1PHzrhFZN6GlrDmLNfqONHKQRCx75ZJ9y
         0FFu03auteE1ZXPZXHo50h87UwtehfsQbH2aifBMhFLogaQwaW9Byh1k1Vj3FJZhC9Oz
         sQ08i6HJERsSfIY8TviIhHUaONQfpRH1p7FiCKOktImvylTqYUPpNFcAAOXy+BJIspoh
         iDf5VKH21fArUMAzSx1HeSlNEzrnIx7K36XAlDj6uY3FlevmlLPPC5ZKgtQPyVlcZO4Q
         Saiw==
X-Forwarded-Encrypted: i=1; AFNElJ9AlUyOiXSMJJ4UB7qhSCiIZ1lhDYz1770SRwu7aAKGBv520CiEO+L6u6/XKdfAgmvQAeWAqtbtKnntUg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+1OdL+asvwqMq7EhF/4ai7C9ezFFzjknps0BzJKWZs2ZMLXM0
	zMtMz65ArNBoLuQf051sVL+PxRyF6uZSR5W2stVdJF7XCb231CsfB9c=
X-Gm-Gg: AeBDieuFOLko6o1H1VK8I4uVo39em07ti1UwGsiU7KWH2qBVv+bu447v0VDIOjaSRqp
	pBRw9GGmyOBVeegGAs0wskj/aqxu1R1XoN8v1z8rZ/0cMJOrI340aqOp8Ex1KfOHw84HWTGcpmy
	1iTGQSIOEIx2gg/aUShwhgVMeJPz3sGtzI/b/HF8OT28riC/IYKzNS7IBdTlZKNrZAS674849Al
	m2wiiyiPJujzl/sVFtuZ+TpQhXykXnjKhZaHSdDMoSCN+slLvUQbHKoW7JM9nwYvCGZLYOTw4xM
	S0Y4Jxb7TkUYhcWSN15CqbInaJQzcXyISxhXGp8TkbaUcxUAXl68Q6Eqt3KR9JKXCByNYhelImo
	Ms1/z6hlM0CVceUu3pfbwmFwV88WdTKKZcm+TchcufOxktOTtpQSlvrwfMzWZDcFsDwCU9iu0O5
	wkdHxiLeRVM+3uFcVjm5ts7tEYbHqTtWLgaoyMvH2VWw+x+WTi+WROeCoNF1lPO3GNdhfNxAdxb
	ZhVbJhg7g6y
X-Received: by 2002:a05:6a00:22c5:b0:82c:e670:7691 with SMTP id d2e1a72fcca58-82f8c9300ebmr42231149b3a.48.1777223500589;
        Sun, 26 Apr 2026 10:11:40 -0700 (PDT)
Received: from coe.tail83f5bd.ts.net ([137.59.92.178])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82f8e984f20sm32012607b3a.8.2026.04.26.10.11.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Apr 2026 10:11:40 -0700 (PDT)
From: Ramesh Adhikari <adhikari.resume@gmail.com>
To: gregkh@linuxfoundation.org
Cc: axboe@kernel.dk,
	linux-block@vger.kernel.org,
	security@kernel.org,
	Ramesh Adhikari <adhikari.resume@gmail.com>
Subject: [PATCH v2] block: fix infinite loop in badblocks_clear()
Date: Sun, 26 Apr 2026 22:41:19 +0530
Message-ID: <20260426171119.625747-1-adhikari.resume@gmail.com>
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

An infinite loop can occur in _badblocks_clear() when BB_OFFSET(p[prev + 1])
equals bad.start, resulting in len = 0. This causes the update_sectors loop
to spin forever without making progress:

    s += 0;         // no advancement
    sectors -= 0;   // stays positive
    goto re_clear;  // infinite loop

The bug exists in two code paths:
1. _badblocks_clear() at line 1153 (behind overlap check)
2. _badblocks_check() at line 1240 (behind overlap check)

Add checks in both functions to ensure len is non-zero before entering
the loop.

Signed-off-by: Ramesh Adhikari <adhikari.resume@gmail.com>
---
 block/badblocks.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/block/badblocks.c b/block/badblocks.c
index ece64e76fe8..1c6728866f9 100644
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
@@ -1234,6 +1238,10 @@ static int _badblocks_check(struct badblocks *bb, sector_t s, sector_t sectors,
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

