Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05A393B19D6
	for <linux-block@vger.kernel.org>; Fri,  4 Sep 2026 07:38:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788507514; cv=none; b=S+O1rtXuf5qEUx0a58Zg96KKLN4mHiRw3wV+09dGbaB0RxM6n3BfTKUk6VtN09nOvwpH165FwPakzgDIZGslJxyOIgTqTlIjKpgQQaWrGR8rLU5Mxns2kFYOrvA4ZYDDfysGRionPUf/kD6b02zte1A9e/AnwxjW6541C+onHTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788507514; c=relaxed/simple;
	bh=h8PbCRKvvFJLZm3SHCvQ9QLJl4LS2W9dFMxYCryCOmk=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=l6IL1/74DYMsnyCeZikcVFpciQ+7j1PCdihDjXgVU0wPuhmnTSNr6YBPlEt617dmFwxILMurE84+SCdMQ1B10IDxcfx7KhtBpJ+MsnQHotIaDu4dnv60RpEbxbXVyr2xALEyHDuG1q/aU/1IyjA/nLdFqy4gOxUPIq74frZ3IdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Civ4s4sH; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Civ4s4sH"
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-864cd11a932so20131167b3.0
        for <linux-block@vger.kernel.org>; Fri, 04 Sep 2026 00:38:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788507512; x=1789112312; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to:date
         :subject:cc:to:from:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=nnmn3Oc+vFr5owFtrHhBgb1Vv21EmUmxEFJSlMg6w2E=;
        b=Civ4s4sHeRLEvE0Z0KfyGFhvPVyT0tbOiSxBBO8ID1i7U9CdnG+hItBq6AGLGIFBXH
         ziybo3KrgnGZQdwR9lrZxbyDGAgjn5jzMs60nTC/xESK1oS8QZsfi3PYMNewwJYrpu6N
         pZhgnYVIc61wnQgjiqC60c3kCSAVMAdGF/W6Y9/mVxxF8gmihyLMB9bEhR9Ne+h80pJ9
         1thwOVIXqnOPO6C8nokyn10Eu4RY6F10gAR4xXLhghKds02GDh+OD1FRnCfeoGuDt4VU
         AEOBYxMvFsfINGng/S2IFJZEh5vW43AHmVkMzBZppSZrZwJrXckJd0vp0TTTUHdUqfGS
         jFmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788507512; x=1789112312;
        h=content-transfer-encoding:mime-version:references:in-reply-to:date
         :subject:cc:to:from:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=nnmn3Oc+vFr5owFtrHhBgb1Vv21EmUmxEFJSlMg6w2E=;
        b=C5TfmevdGV9AQg1Xkm8b3i9A2iG0SYuKx0ByvTqyQVWAeKLqmqyoeCn7lACNGoKH43
         hqzk9B62zVJlw31et/pX6TLfk17u3DgAGjNkm/I1ZQmzCHY5jnrv4HVROJtJVYJfPVgr
         z4qnQ+RJFkcncyFx3zhlxUaP16eaLMVET/nWUWu7PwBMMzC0Jn8b60iaxG3VI59VGAog
         7VlG6H90CTDYT8W+Di8RTdqrFJtYps22n6G+WIYhHjijG9rNZAsDePb+wsrCJYdaBp+Q
         8Agb9yGDm5+QGIGu0OpgV4PfZ3rv96duPQizbmzeGTr2wUmiwZU31uighy75B5d6F3Uo
         hnDg==
X-Gm-Message-State: AFuF++mQntz8C0aj8+7/GIM4CNW2u0bMHqnO9jevxkp8RXY4NgBKkhw9
	5bXP6KQO4zRYoUkxvyShqBTecO+gugT/L6v5UTpdWQqg0k7LBuhl1jxCbqW3MZ7L
X-Gm-Gg: AYBFou34b+ttD8qlEhPhmUcXqqgv6sEj8e1YkJY5hU0ylYurUmD5n6bHOavqvGOF3Mc
	rVdouZ7qQrk6nxCSZc0tqFJygdDLwNqU3ZpWnn3GkWwru/exqlSoZ7oa1ROYt7WUfA+TAKwAnwQ
	ZrlmP3Hltsn3b1U0AdGGeEsTQzOe5RF4dgT/zIvdYl/TxY+pSJRpZfR4pL/2nYTzLByYcKev3AI
	logI5lGG+78S2l/q+vxr6d7GKW+mby5DX/B52Us+kbj0HPgfGGs8Rn9NLDf1ANqouEUypaYEcOe
	wyqc1r3ydSwzydKcs0/57HQ/6AyGbPXnr0RuPWI52cIseDNBAPcomODp3J+HbhCYOpxLl2ok7IK
	rnpp0A72zTSvVmnoadxHTQkG0sfVd5tfDrC+iYwOa+xcxJH2j/a/oGX9z2836WmQ+6nuawaazXR
	xlOnREgQRyMQaW8dTapr5laKpwFW4NVp9k7fHEgnvhX8ClsJ2xn2PYFw8xqMmFyLB7L7BN7z1wq
	qRErwuFqqensKemR4Qx
X-Received: by 2002:a53:d012:0:b0:66a:b15e:bb93 with SMTP id 956f58d0204a3-66fb6d605fdmr809951d50.13.1788507511931;
        Fri, 04 Sep 2026 00:38:31 -0700 (PDT)
Received: from emedev.tailf75c28.ts.net ([179.238.17.208])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-66fb48f1646sm1691157d50.9.2026.09.04.00.38.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Sep 2026 00:38:30 -0700 (PDT)
Message-ID: <6a9a7576.4675fc7e.263ae0.6765@mx.google.com>
X-Google-Original-Message-ID: <20260904041502.ramshared-v2-kconfig>
From: emersonbusson <emersonbusson@gmail.com>
To: linux-block@vger.kernel.org
Cc: axboe@kernel.dk,
	linux-kernel@vger.kernel.org,
	emersonbusson <emersonbusson@gmail.com>
Subject: [RFC PATCH v2 2/2] drivers/block: integrate ramshared driver into build system
Date: Fri,  4 Sep 2026 04:38:15 -0300
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260904041500.ramshared-v2-cover>
References: <20260904041500.ramshared-v2-cover>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Connect drivers/block/ramshared to drivers/block/Kconfig and
drivers/block/Makefile under the CONFIG_BLK_DEV_RAMSHARED symbol.

Signed-off-by: emersonbusson <emersonbusson@gmail.com>
---
 drivers/block/Kconfig  | 2 ++
 drivers/block/Makefile | 1 +
 2 files changed, 3 insertions(+)

diff --git a/drivers/block/Kconfig b/drivers/block/Kconfig
index 8e49b12..d3a5e81 100644
--- a/drivers/block/Kconfig
+++ b/drivers/block/Kconfig
@@ -375,3 +375,5 @@ config BLK_DEV_ZONED_LOOP
 	  If unsure, say N.
 
+source "drivers/block/ramshared/Kconfig"
+
 endif # BLK_DEV
diff --git a/drivers/block/Makefile b/drivers/block/Makefile
index 28cb489..f895c11 100644
--- a/drivers/block/Makefile
+++ b/drivers/block/Makefile
@@ -41,3 +41,4 @@ obj- += zloop.o
 
+obj-	+= ramshared/
 
 swim_mod-y	:= swim.o swim_asm.o
