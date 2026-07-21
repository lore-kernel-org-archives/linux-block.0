Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B51AC46D570
	for <linux-block@vger.kernel.org>; Tue, 21 Jul 2026 16:04:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784649883; cv=none; b=grdCh0pxC3nYnzSuVTIf3iRTC3ehDCrZx5VWwbeQfbDJvBx4uyqajQ5bj60thxysqtOvJRiMRsVQ1VEhbtplGxVM0eVSFb2ZbwLJMCaEDlmUbI7N6dntHBsunwxpQfKUJg4joJCAe1EvLhYMkZ03MkmuYZGbvBRib8xAhczQPF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784649883; c=relaxed/simple;
	bh=bpxQfYFLp3mUBkc4zqYxVsblvHkRiFEovrClIWvSBi4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FX997H6H2Rc5g+nvapM5NeqWEygP467kiUKdJVIqDzfUJM2gFHOPPehMKYB+181fcNqC+SZlJbvJY+Am5jsTFHWDbmAxsem9E0wRicGkrNGigHyrJ0O/aQ1y+Jl4ETPrYEVf3iOk9a5widm/4G6cWJvBdOs6bLb975NUsqPGXnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FTtAIUuR; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FTtAIUuR"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-493f6de72faso35790395e9.0
        for <linux-block@vger.kernel.org>; Tue, 21 Jul 2026 09:04:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784649880; x=1785254680; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=e+iirfZzvSCxodM2aURVzOojt8QSHbU6tXy7MwULQMw=;
        b=FTtAIUuR+RwYWMdnP6LTDOMriaQyusIm5nBL58UHHNj+SRxQiYiq25DCOMoNMqbmuY
         X7XjISXO8dX4fdIJdK0bAYv2Sgoirv4Rt7dq88zmnXdpwaLcZoQUyy9h/RLiEKkIWBhg
         JPosT2i0UT/pKovvs5d392nY5IbB6WvsL5ofzg7CZsR525Q7Ga3eBoteyKDGJ2ehRzUI
         K6cFKiLuX2tWRWAcHQ6XN5MTmNDi3PeSqeCDqBf0H/yuq3PtcYLqNfzfHzgIXiNM3WYO
         KnO0RGu020yX694DIDs+Hj1700gEG7n8uDiaW2/M5kmifdp4DHDR8ZRMPYgi11jPJXYy
         PcUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784649880; x=1785254680;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=e+iirfZzvSCxodM2aURVzOojt8QSHbU6tXy7MwULQMw=;
        b=fegZlON6szmWTA9tU9J0Qb4LakQexs5SDEmBVM2ohaun2CVVSKptKXgAeIbM0DWjnX
         bOCpGbSKGY1BbphXEc+S591z3nRZpgU01sdsdsxTPQnpvfeFY2vZIT98mLtOQ3ANxSG2
         4guJgOOlG2etALe5qF2dx3dpTaQPXOF8slBKtfVPFpntC4yao3OBrrMllVKu1Dmjpdrr
         RobJxKFUoZ2LGLN+LctrTr0pOkITr4qVSC9+9jQY6dNQOIGTw3+8/6x1mx3pTKdS44PV
         sjvHKL3VnYudfbnyrKYJFW87qdN07fyEAZOdnAwkvDspzqFgI06oyxRXD4q9oFhFUz95
         Jt8w==
X-Gm-Message-State: AOJu0YwwksctacG+6eUVbtAt67oFuUEqJ1mNFrSlhv2iW7MRGi/hfWP6
	OylQ7/NewD/gB1eKbVVNVwypHrcow+MopD/ivMj2Bz5kOgXoA8fPrES31GhSJw==
X-Gm-Gg: AfdE7clA941UsnHTc1y9rt8e2XEjKwp+MRZmHTM29vWNAvKtThrK9kyFnCmuTXSArgF
	9iqzQbnm8S14FG5WbqENySEVHmaC/prLyaIV6IncQiVeFvl0IG78ZHnFv7VcW7pOAZNTF4fHZ3Y
	AGLTZMENvi7JjlwDMuIIrxvvvSonPa/iklP0dH4YnZhhtS4U6vHGL785aMnH3JqC6biS3PK7En2
	0qyNu2euX71KHj+NMW/UN8qoXJwmECxpjIgD6SbLCJcJDTetS7hbSy1qNzuhjhHi3FoaH3p24ZV
	LWJX4JGJ1Q3w9QeKuBlrpRh7EvXQqQJys445LKPTG0bDO/Apb2MJnvT81T8QnTr9bWi0hVABMaG
	ezxQBE7gm36KWc88lPB11oGddwbfRu1l5WngMno8YucI8dQkxhsRS2mBcl1YJGq7c6cFmYLtdZE
	7rXUEKnHJ5Y7ZwxBPLRffZdBNonNUDoF3BEyJ1957wZOBhJe4=
X-Received: by 2002:a05:600c:4f88:b0:493:b698:9247 with SMTP id 5b1f17b1804b1-4956a50fe9dmr3242625e9.14.1784649879661;
        Tue, 21 Jul 2026 09:04:39 -0700 (PDT)
Received: from localhost.suse.org ([37.109.161.57])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4956a4f24bcsm5591425e9.1.2026.07.21.09.04.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jul 2026 09:04:39 -0700 (PDT)
From: Sebastian Chlad <sebastianchlad@gmail.com>
X-Google-Original-From: Sebastian Chlad <sebastian.chlad@suse.com>
To: linux-block@vger.kernel.org
Cc: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	Sebastian Chlad <sebastian.chlad@suse.com>
Subject: [PATCH blktests 1/2] loop/009: only skip on a genuinely unrecognized --ping option
Date: Tue, 21 Jul 2026 18:04:31 +0200
Message-ID: <20260721160432.27409-1-sebastian.chlad@suse.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

udevadm control --ping can also fail when udevd is busy or unresponsive
not only when the option is genuinely unsupported. Treating any failure
as "unsupported" risked masking a real udevd problem behind a
misleading skip reason instead of letting the test run and report it.

Signed-off-by: Sebastian Chlad <sebastian.chlad@suse.com>
---
 tests/loop/009 | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/loop/009 b/tests/loop/009
index d3c7991..944f53b 100755
--- a/tests/loop/009
+++ b/tests/loop/009
@@ -11,7 +11,7 @@ DESCRIPTION="check that LOOP_CONFIGURE sends uevents for partitions"
 QUICK=1
 
 requires() {
-	if ! udevadm control --ping >& /dev/null; then
+	if ! udevadm control --help 2>&1 | grep -q -- '--ping'; then
 		SKIP_REASONS+=("udevadm control does not support --ping option")
 	fi
 }
-- 
2.51.0

