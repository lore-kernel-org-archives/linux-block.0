Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794328019;
	b=4ApQ0XffRxOoktdq5Mgrbut+24e7/ThZgQNIyAVM8m9ycKAI+XZiJFozBKK9OyGTsKE+
	 2QCpyGjhIw2VUJnELeroR+617IEBNisDtb/VAEziyO+YCYU+a92zD/T/nDqMqwvl2jQKx
	 9eTscwmLud3M3DvvgUPxiJHbors4cb98gmG9Gr+SQ9/6DXlPY+3RshW3dFjrosS1/w14q
	 dKebLa0BxnBx/N1O/mO5K2JkGx/HCpuJho00jUdr2gDu6Tu7mtszapLVkfBT7/sfUokhR
	 MGY7yzUdYb9/79k4Ra5wKPwLVepEYrYu/Lh0TGGMRGKC2jizzUjK/KBS4suBAeVgBmg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794328019;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=j66A61VB02ttIT3aNMpet5+IqRoDe8F2uoe9E4qYXPI=;
	b=OJ2tgomsjzpoomJsl+TLNyfGqVxPOR+bNvhGS/XSqdE5ZITl/X1oxSq/oYLzFrm06YoW
	 yjs5aJ6F+zBpLdiIwiNJpGngylS4w6gLEgSovQpI5WR3mwAEQQsibETHPROtYkMDag0hF
	 qh5UMEqbIu6QZ07o12ALFYY+f5BF07HOb9TWLzdYQhiaZL3wu/zXXDAKS/y0uklkeCtqr
	 ig7X/p7LIShLi8FXGk03v9F1xUXO0a/KJTBc+0l/1gde7H7B4SqwYIY8DvRY5Uq9BdAKy
	 0H4McrVKayLpE6v8QUg9zwsggkuoaENMRNv512sGWY09Ta5bAJyoZh4/KXy9SeLIIWw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linbit.com;
	spf=pass smtp.mailfrom=linbit.com;
	dkim=pass header.d=linbit.com header.i=@linbit.com header.a=rsa-sha256 header.s=google header.b=k7C1+PDE;
	arc=none smtp.remote-ip=209.85.128.44
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DE3F606A331
	for <linux-block@vger.kernel.org>; Tue, 10 Nov 2026 16:26:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4DE3F606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linbit.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linbit.com header.i=@linbit.com header.a=rsa-sha256 header.s=google header.b=k7C1+PDE
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4a59100fa83so19310435e9.0
        for <linux-block@vger.kernel.org>; Tue, 10 Nov 2026 08:26:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linbit.com; s=google; t=1794328018; x=1794932818; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=j66A61VB02ttIT3aNMpet5+IqRoDe8F2uoe9E4qYXPI=;
        b=k7C1+PDEQ7amdzJk++tIPHqB4AVXXQojtbcD3JhTbBIqD15rcWGP/Q95EwVL7zj9dJ
         CVS9MG5q/GXljka10a+sWfQWjaPcueFX8VtttYq8FeXuTc757Hu7N10hL1luoRTxmSus
         QrhNqqtaABmhr/vH9NskLqKxr3Yo3FdAOxBm4g0IVgn/qBtFDrO6W4DQzrJ+iNNmC3mo
         9MfGhBlIha65yHziUebFmQADB2wZBiChYVqTkXsvjf/rex1RpuA61bTW2avGv1pdh6mz
         x6JHl5Pb+duSaoUfy6p2jvsG6p1TJlAVdUxNCo6np1aC3Xugjptki1knvoRKrH7yc2mE
         cfmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794328018; x=1794932818;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=j66A61VB02ttIT3aNMpet5+IqRoDe8F2uoe9E4qYXPI=;
        b=SK7OCdSGjVMscKJpXmSByuj9uZ+/9M01/QP1i7TT7EmcHL4wVPPzOZx3miAfpLMUuD
         TZ24GLj0lhk3YtHnVg+gKhCce2TuNQSce6yWY76/u/cyI+RVV5bDJ2TfiTx4E8EeRopx
         gUflUAzO2nZ1A06tgyomfeakZXGXi7lyZ5sXIzeJ1ET9UyV7yUGcIGzPWxpsMeTSxHIu
         wCy4OnjYz1q8qZj0c3vnXLB3RAj2W8wZcXkVp3sooyfgOGjIR+vqYyw7EKoPCSNsdZrU
         Sxw3D6Gi+GYq8zyc1AEA1jYV4kokYlybzj9P+NPIZqaFqxkcAyJg9JXWCP6og4OeA1GL
         /NIQ==
X-Forwarded-Encrypted: i=1; AL+hErHIcaxUJzgYov9M/Le+P3qtTeSkh8hEPHSauslTUCcsSoIa3wNUHkAzbG8HrIch/36hEdRPLR9Qcpq/fg==@vger.kernel.org
X-Gm-Message-State: APuU4Z+hCH93xD179awPim43GXPS6XYd4+5LB57JGt/X3zHGb6L/RnDB
	7gC+SsGSK2B4oeT9MLG6my1ILM1L3ogbslBcogSufgsJ+YpO/f/CLtAII14l6Jt5vMJ9vLZVuS2
	KDoJsxd4=
X-Gm-Gg: AYBFou2aleGxL0NIlqAm3ubtNgcUSGEhikWeiUcIRe18dVA5loTFg8QnUaoTaLa8sHx
	XPK3sdUnbMme1lFFqR1s/XXsJ+kE0FNShzEl70MKT9DUuBJbPrWwzrJrzMudIby5GyEYK84blEf
	kTEvrheL67yFOJGraWjz8UdcJ30v+PIqwJXpOjhlATSvjtls0LOwDZUjt6wuiw2fTeR0/ppjrDF
	YxzYDFDPraGIr/i7yMmAsPHkI5a9omFEG1ETQLr5R4qyyarnZt2ElXzxSzDFQv1D32Ue0vh52XA
	cyYWYWsdMCOXzeJHiOFEQYdhzqOJpcieuF5dbuO+pYjvxLvV7J7nogPZT4FRqwF9SDY9l7ATVfv
	ZkOJVksu8dzUGeXxI1u5SC7x07y1mDnOOqoqqr6KADzkSC3LJSq/6utGg/sCRMFGfu5MNMo6gur
	7qX5nsKK9OD1B/lb22as0Ta0+Gl/fxKr+N9ip991OV0muAl9UHPlyKrNPxSCDbqg77A98giat6W
	JkCMSqpRt63La8aJnJe9x2oFKEy2fmTkWDx4RH65/Fr9mBXvjA5cKYqEylXdkdcZMayXK0i/6Xh
	9MpQMNvSh11CCIBvILVvvHBJkASBI7+vc/lngIwGJnwD1+eT3AaCbxSqcLN6wplMlx7lVBY7Sw=
	=
X-Received: by 2002:a05:600c:19c9:b0:4af:83ad:8f70 with SMTP id 5b1f17b1804b1-4ba02356ac1mr55662755e9.35.1794328017694;
        Tue, 10 Nov 2026 08:26:57 -0800 (PST)
Received: from linbit.com (h082218129081.host.wavenet.at. [82.218.129.81])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4ba02345d22sm85050695e9.1.2026.11.10.08.26.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 08:26:57 -0800 (PST)
From: =?UTF-8?q?Christoph=20B=C3=B6hmwalder?= <christoph.boehmwalder@linbit.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: drbd-dev@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Lars Ellenberg <lars.ellenberg@linbit.com>,
	Philipp Reisner <philipp.reisner@linbit.com>,
	linux-block@vger.kernel.org,
	=?UTF-8?q?Christoph=20B=C3=B6hmwalder?= <christoph.boehmwalder@linbit.com>
Subject: [PATCH v3 01/20] drbd: mark as BROKEN during DRBD 9 rework
Date: Tue, 10 Nov 2026 17:26:26 +0100
Message-ID: <20261110162646.3028472-2-christoph.boehmwalder@linbit.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261110162646.3028472-1-christoph.boehmwalder@linbit.com>
References: <20261110162646.3028472-1-christoph.boehmwalder@linbit.com>
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Mark DRBD as BROKEN while the driver is being reworked for DRBD 9
multi-peer support. The following commits restructure the driver
extensively, and intermediate states do not compile. DRBD will be
re-enabled once the rework is complete.

Signed-off-by: Christoph Böhmwalder <christoph.boehmwalder@linbit.com>
---
 drivers/block/drbd/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/block/drbd/Kconfig b/drivers/block/drbd/Kconfig
index 495a72da04c6..ab0bf1b7eb7d 100644
--- a/drivers/block/drbd/Kconfig
+++ b/drivers/block/drbd/Kconfig
@@ -9,6 +9,7 @@ comment "DRBD disabled because PROC_FS or INET not selected"
 config BLK_DEV_DRBD
 	tristate "DRBD Distributed Replicated Block Device support"
 	depends on PROC_FS && INET
+	depends on BROKEN
 	select LRU_CACHE
 	select CRC32
 	help
-- 
2.56.0

