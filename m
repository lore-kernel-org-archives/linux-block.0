Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AE91211A14
	for <linux-block@vger.kernel.org>; Mon, 15 Jun 2026 09:41:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781516518; cv=none; b=iBiaUSRFBwdnT3Wvhhfp9xk3Isr3rSevhPOo8IoHsqT9MsnF2dQhdNVb8gwcyq9GQD/PHK3XKQSTCeBj4zOzh1+Tio3MiHRjXnGc3BqNOrSr13R8JFm0F5Dl93jRvJqYeBbneWslxl1xqIhtlpxNNBp3bHPZEWpoCnpwXeWvyEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781516518; c=relaxed/simple;
	bh=azJfFqVOB2MaxT88ytf0/OBfidzqNbLjP0eMXeuVpaA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=j40X0ZXMlNRg+3rUveZ/zdKMZDMUVOJlZSgZo6zI58NAVzRhDp5GjeDZLq08hH7K6ioiF2trwWP3TIa6hAj+IyJG3SShPaw8sLtajgdQDIC6grxGs3QXem5rVC7gbv5yHCyWDw3mDC4mNF6BfJ1ZneiZu7Ax2iZ8lfTf7Gi+4Go=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=emLNom7J; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="emLNom7J"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4908b92904fso38068695e9.0
        for <linux-block@vger.kernel.org>; Mon, 15 Jun 2026 02:41:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781516515; x=1782121315; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+nHWnBYuKAI333Ay4FRBj7Tm6npP4rVtGMWoXA5dsUs=;
        b=emLNom7JpJYkSk3VOebXDOkbF3IhNDXjCeF8iCnfEO94lcmrpyXn7QjLELKD58rtMa
         cmwtj1fTvehQ4/l360zhFUmkplr/j1UMjUvupRkbBicd3BnrSKR3f47fJe24h/3b2QdK
         R4SrlxrpKc8/WbC+nGh+LrivOeJUC2ThqfznptguHd04JwDeVzHEbshgY/KPg79hfMPL
         mRosICK8QkyCTzrPIy7QTi0XxTrQpNUuxV0elenp4S3+s0YTbUlTOlyyhOgkfn8TYXdr
         wcs2rNaXRLmepHpL2YVLKRoVSIpqzaX6F+m2JD7R8gPT7B5/ujdoXBhlikObaRtEEwhi
         2f6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781516515; x=1782121315;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+nHWnBYuKAI333Ay4FRBj7Tm6npP4rVtGMWoXA5dsUs=;
        b=YK8d12eQVxOUQ3bI4RXi7/qVSkDK3NPRX5ATWp4zygbqHlhUlKE/5/bg/4trWg7YpO
         TFB7zYYYs/4dBLrIbhX3Clis+R3WY4giyXwtkzv/ZKZKz9QM50MmyIMrPiBwTEQ8BaWn
         XSfMpyM8oNqE/XBmr+4IVMSyuphX+lMQktREchflgIOvYt3K1EdSHl8i8Tzoa9gi98F/
         hIIzysvlUxTCxTvW1HjUo2Ep81ChTy/x67ywDGry9/Oxv1YHrjTH49dP3DUohWVHbMP3
         XKpwqTwM52zaurUKBgI6ULF/xIDEmuhxrK5hVtdk3epKAw/MM0taPUtYt1Lim+sWyKW6
         +liA==
X-Gm-Message-State: AOJu0YxTkmvSW12aGqgJlPslLlJ1yi2IXooxT8YJoBEBVFj2an4Aha2B
	hmDGCki9oDogZDh9wFjpn/VQ7AhjKMY5PQefAcYa8vPjml5fDcI78PlN
X-Gm-Gg: Acq92OEUCklygx+AZpRmnuQnPdVw2E/NuIvQvJLQIBywOrNZvyIWDjmA5FNBshCJiUP
	Ab64/lBiNb38KMNXrFfCS84Hcd8Nauo33lXgKCTERW8r2b2KEiijvt8JfCkMp1dn8NLCnSNigrO
	Gol0k38rE+Lx4gu95oM7vRhFHfN/OpUQxdiZ6updIQv5CRbamtBXlGh0NNjcdkO1Vtr9vnqYnl8
	UufitPNshzNocpcrnVebBrn32zF7dfj055LAyaPXkvA032x+LW6eA/H3x27OlLV4fdW+cT5+KlB
	24lu70RvIH5k5vM/q41P6tMRu3n7/zlMge4OJopZqv0lpqif/rzmKPrUHp/hTu30HZ+o6NoqCRE
	9RZe51QIeopLaKEU2fvc24zUQYkDX5yuiZ7a5pU3DGfI8cBaWIlTjU6BJYKKu5BmIDvtcjxmX6B
	kopFKwt80Djrk8wBP3BYSe1l1q31iuH/IJFQ2AcSxwj9WByR2N+VT0eCoM24mSSY83xHC7PeJYl
	rtKeDPe33yk2rujZ5FmLL93pczFX/fp9eHkCCx61Hz/eec=
X-Received: by 2002:a05:600c:314a:b0:490:b8c0:d470 with SMTP id 5b1f17b1804b1-490ec504d5dmr161971375e9.19.1781516514793;
        Mon, 15 Jun 2026 02:41:54 -0700 (PDT)
Received: from localhost.suse.org (apn-78-30-82-184.dynamic.gprs.plus.pl. [78.30.82.184])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4922031b7d2sm254353105e9.5.2026.06.15.02.41.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jun 2026 02:41:54 -0700 (PDT)
From: Sebastian Chlad <sebastianchlad@gmail.com>
X-Google-Original-From: Sebastian Chlad <sebastian.chlad@suse.com>
To: shinichiro.kawasaki@wdc.com
Cc: linux-block@vger.kernel.org,
	Sebastian Chlad <sebastian.chlad@suse.com>
Subject: [PATCH blktests] ublk: mark all tests as QUICK
Date: Mon, 15 Jun 2026 11:41:44 +0200
Message-ID: <20260615094144.13060-1-sebastian.chlad@suse.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

These tests are quick to run so mark them accordingly to ensure
they are included in quick runs.

Signed-off-by: Sebastian Chlad <sebastian.chlad@suse.com>
---

I checked locally - all tests execute well below 10 seconds

 tests/ublk/001 | 1 +
 tests/ublk/002 | 1 +
 tests/ublk/003 | 1 +
 tests/ublk/004 | 1 +
 tests/ublk/005 | 1 +
 tests/ublk/006 | 1 +
 6 files changed, 6 insertions(+)

diff --git a/tests/ublk/001 b/tests/ublk/001
index 3435316..c994cff 100755
--- a/tests/ublk/001
+++ b/tests/ublk/001
@@ -7,6 +7,7 @@
 . tests/ublk/rc
 
 DESCRIPTION="test ublk delete"
+QUICK=1
 
 _run() {
 	local type=$1
diff --git a/tests/ublk/002 b/tests/ublk/002
index ca357b6..aaea4a7 100755
--- a/tests/ublk/002
+++ b/tests/ublk/002
@@ -7,6 +7,7 @@
 . tests/ublk/rc
 
 DESCRIPTION="test ublk crash with delete after dead confirmation"
+QUICK=1
 
 _run() {
 	local type=$1
diff --git a/tests/ublk/003 b/tests/ublk/003
index e366813..40bbd6f 100755
--- a/tests/ublk/003
+++ b/tests/ublk/003
@@ -7,6 +7,7 @@
 . tests/ublk/rc
 
 DESCRIPTION="test mounting block device exported by ublk"
+QUICK=1
 
 requires() {
 	_have_program mkfs.ext4
diff --git a/tests/ublk/004 b/tests/ublk/004
index 1d74fea..6812431 100755
--- a/tests/ublk/004
+++ b/tests/ublk/004
@@ -7,6 +7,7 @@
 . tests/ublk/rc
 
 DESCRIPTION="test ublk crash with delete just after daemon kill"
+QUICK=1
 
 _run() {
 	local type=$1
diff --git a/tests/ublk/005 b/tests/ublk/005
index 1e21674..69c1fca 100755
--- a/tests/ublk/005
+++ b/tests/ublk/005
@@ -9,6 +9,7 @@
 . tests/ublk/rc
 
 DESCRIPTION="test ublk recovery with one time daemon kill"
+QUICK=1
 
 _run() {
 	local type=$1
diff --git a/tests/ublk/006 b/tests/ublk/006
index 85087bd..2a4d886 100755
--- a/tests/ublk/006
+++ b/tests/ublk/006
@@ -9,6 +9,7 @@
 . tests/ublk/rc
 
 DESCRIPTION="test ublk recovery with two times daemon kill"
+QUICK=1
 
 _run() {
 	local type=$1
-- 
2.51.0

