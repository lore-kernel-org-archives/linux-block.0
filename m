Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794328050;
	b=vfIfbPUO6XJ/t15JMxgdssSVmrx9lUsqgy5kOIQFVaCH6B07Wd/8ooxJB0w3aJDcpXpk
	 Xr2H+6wpc9dQnqvkhYmI+Ow8luGZmAuNTY1SCI3/GYnU7DUhT+aMU1XYFUfetEziHpHp8
	 2faaRJA0Ndnoo0TtVc59IxJeeXCcKDyDSHiHidqIUnp0ViPGU1412vGadBkHKrgwnsYYC
	 awSmKVQLi70K8ZnzEzwy2qkM1YqoVXbsXQjXFLfR+3F9mJyI98wyjv/MWr8ttNvnQm/2o
	 +BsLgw5qNfjffc2/zCg+RykVtjSviM53lVdvQfgaiSI3ikEjfv+wdP5j5EQEd0p5kQA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794328050;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=a1tYd398psi99x2zsisd/32A0Ti86/9u98Bkj+C2fdU=;
	b=zL55UKoCuTwzLCQSoOFYXjLTAAZelZNxNiVeuJszw1YUIPb2kRox0O9JqzDdJSvTG/Cb
	 6i8nue0ZA3kQaKVuqu3xn3g6ecnST7IzOwZ1j/N4FOLFKX3VXixJvjrMkJcRnfJcVl+GJ
	 JVvg8xbsiXQZ8l29gv8qWOVx1/aXDmH+aGrdOmNLvdNS2CDRZskovOPITdApgL0uMObr8
	 lecpVDaxdoId8D2ETHwtx5Euup2S8bSbQsOxyZ2cfjKVj3oWXLVGAs/T/gbhNvO8DcHBa
	 mddixgNJz0h+m15IZZ3L8gyW4VQVSV90hIGQzcrf0mo7qCkKJvNmGtixmt6yEqLPm1Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linbit.com;
	spf=pass smtp.mailfrom=linbit.com;
	dkim=pass header.d=linbit.com header.i=@linbit.com header.a=rsa-sha256 header.s=google header.b=orYYIpiQ;
	arc=none smtp.remote-ip=209.85.128.54
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E677E606D7E6
	for <linux-block@vger.kernel.org>; Tue, 10 Nov 2026 16:27:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E677E606D7E6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linbit.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linbit.com header.i=@linbit.com header.a=rsa-sha256 header.s=google header.b=orYYIpiQ
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4a2d6d01ecbso13692755e9.0
        for <linux-block@vger.kernel.org>; Tue, 10 Nov 2026 08:27:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linbit.com; s=google; t=1794328047; x=1794932847; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=a1tYd398psi99x2zsisd/32A0Ti86/9u98Bkj+C2fdU=;
        b=orYYIpiQ1X8Lptg/esHZK0OTv0AQPJtOaeZJyI96CRLntgknEqluyPSp22eGvneDUm
         IzTgRChCad3e+ZFOAIvJu6T8MPZIKBMUZ8Hgf3Uf29y+mmUsmf7maqgb6W+Jg0zoigd6
         KI/vBcTh0rX+0gNfrkKAiuSyD3f3Q305focSyO+XpoFaQYJM+hYjcOeJyqn6zbrFDd9R
         Jllx7QDYpWYmGcvDB3ByYPcpe6CQHbeyCLJlv3lCMtyF12L5M/tf0HClwZ7mzIr1ukX8
         EBOzcJaNBbuVxrxh2l18qDvbltthISyspDDmGnolgvn5niAe0Dgz0KG5rBn8el02UO0/
         dLnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794328047; x=1794932847;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=a1tYd398psi99x2zsisd/32A0Ti86/9u98Bkj+C2fdU=;
        b=InUIjPfzED6aWBoKKYjRQxDCewIeFt76SK+Xy3P4RykfsYXBWqOM0+Vj8sDbwoMPZ8
         TPRhzVVfzJsIkHj40kJaDyCgOF3YJaxH6XqPiI76IKdCthGxjmiV7OydceYikhqnFNxX
         5xRyHwbPUOalY7a0TOcKMjSD3mJXID5jyKeruG2BTNmxuE5aXHyFtRprzfDMUv8kVdb8
         CocpWnZ5toYDhPUJKnCPmNNA1sioK4M6xd75HBauv9i1Ti6+ZMafYUHPMzZhaAONEnrF
         d8D53GynBXm+nvCDy8tg2YnUWOtmnHkQY4/q/AXS5VmqwEKySQF74lcqFQABILMemEDH
         xatg==
X-Forwarded-Encrypted: i=1; AL+hErEmdtzUs6xS9FEUWTTLx4Al/m5+q5IgstVTxc1EkrZWPmUXH9wtt4L/VX6cKKYscvikZwzQe5cdZIXQYA==@vger.kernel.org
X-Gm-Message-State: APuU4Z8Dx/xdwDvm6QHKegCHqZgfWIrXgRfV6mIJbiM4ohEKdr1A+Zg2
	ADQGCvNif4Hrep5hQqepS1/+f6Yo1e+GqcchGVnC4N6RpIfx2KHuETw00a3blD4NgHw=
X-Gm-Gg: AYBFou2DCqdGgyQV6hSCBDshR6ZbqiwjwKfSNCIyX+hqx2MPP3z48TGXHSyht8WSLbM
	lw1BsI/gw2VKvJ/GUY2+iPhDosoJ6rpE/KJAzHgTH8knN/MHp+PQSVEMu15458l/YSMhVLkdUTH
	8/M5ieI4qD+5osONU4XfqOYYvXPrEdQGpS8QWaEOOTV9GnKz7hSALdmD5jq4nj/5/ntBg5nNt7f
	1/sTPV7wE+/O48IjA2SisxG97ELERCaEibrn1mILtd7O+E98H00sDeIrCd5lMrObi29MykBRbhp
	+oBR/RRPmaGVbJMi/2A4s5glXMShanO0IltV7bIwj4CMFKa1LPe/vSxzU13TCTTn3+/pCgFJW31
	Edk0IkCqP+8Pj+Cd7xU/K+NVmXBuL6mek7d39dFOlRYQazmhS1AO5JyTKC3sptPMa7y2AvMNAcK
	MVSsZ3N1by4/p+bKhWgwhEaDuzj4F/gaqtUMEskP6WyZkvBAZbekJvwaKeRpp2DGQo+50Avm/Ov
	bde7zNZE5yPlCJT9evmDw0In1TnS4KSws8euY3445N056VS0QmiVeldr7U9yVONYxEQMbR2nfNR
	HZbit5WES3tonGKe7aNeKaYTPTrAmrOomX1pdPHD/qcA9KO/ldukhJOtUks/FRLQig69Y5Robw=
	=
X-Received: by 2002:a05:600c:3e85:b0:4a2:1655:87db with SMTP id 5b1f17b1804b1-4ba022c9b4bmr53849215e9.0.1794328047192;
        Tue, 10 Nov 2026 08:27:27 -0800 (PST)
Received: from linbit.com (h082218129081.host.wavenet.at. [82.218.129.81])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4ba02345d22sm85050695e9.1.2026.11.10.08.27.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 08:27:26 -0800 (PST)
From: =?UTF-8?q?Christoph=20B=C3=B6hmwalder?= <christoph.boehmwalder@linbit.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: drbd-dev@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Lars Ellenberg <lars.ellenberg@linbit.com>,
	Philipp Reisner <philipp.reisner@linbit.com>,
	linux-block@vger.kernel.org,
	=?UTF-8?q?Christoph=20B=C3=B6hmwalder?= <christoph.boehmwalder@linbit.com>
Subject: [PATCH v3 20/20] drbd: remove BROKEN for DRBD
Date: Tue, 10 Nov 2026 17:26:45 +0100
Message-ID: <20261110162646.3028472-21-christoph.boehmwalder@linbit.com>
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

Remove the BROKEN dependency now that the DRBD 9 rework is complete
and the driver compiles cleanly again.

Signed-off-by: Christoph Böhmwalder <christoph.boehmwalder@linbit.com>
---
 drivers/block/drbd/Kconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/block/drbd/Kconfig b/drivers/block/drbd/Kconfig
index 261965d7b054..06be6ce164f5 100644
--- a/drivers/block/drbd/Kconfig
+++ b/drivers/block/drbd/Kconfig
@@ -9,7 +9,6 @@ comment "DRBD disabled because PROC_FS or INET not selected"
 config BLK_DEV_DRBD
 	tristate "DRBD Distributed Replicated Block Device support"
 	depends on PROC_FS && INET
-	depends on BROKEN
 	select LRU_CACHE
 	select CRC32
 	help
-- 
2.56.0

