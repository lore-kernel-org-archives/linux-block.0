Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795620954;
	b=iwQL2buwGktZUP3oIIbHg3jHJAuqLnwQPMUPP/WOKV/zoiD6EFhTNq3YN+2DvQv02p4R
	 FghcaKr6y/vLSVb7DWgl8UxeH4Q4bqtkYmUZfyA1FQ8MvFyk8b0cWXLxeQIMi110rhkVp
	 Aco6SBFMF20ge3SrfrPHb2jaBpCIz5IZfzX7HOSTPYpVP8Dt3sXFuw1jvsu6EuWOBX/g8
	 v4MGknIXtC1OpVUxABzggzti1eOVZIBuvjzY41taXkiA79kcI6Af3JGKE0OBVPf2c/Afc
	 t1A5YKUS5nfgFOfZ335vjMaHK0WEaNdOiv/NYYeT6o4TpTCdSd9YyS/TP3mLAdIK5ug==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795620954;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=zW5K52MSqR13vjMOGRw7WSmYMI0ONd2XOyiatd+7KVc=;
	b=0QlDcEVeWTaVRf0dkhFiCpjZso9074tmlFwLguZKINPYhry1zBS1ZqFn3hLDJIrDQc+B
	 lGZvUc82ZdW6J83+FJDorQCHUgI0HhLFeJQ42dNY2gx7GhI30oN7WX1Gj2KQ/HOVMmiX0
	 DmIrxhbBWlKt+cnJ31UYwdYLi9FNnMUPdzBjVesbSdACybQErHABXherYiLx34SHlSSkf
	 VBbJJX0uSQP7/jTiD88m7FXunZMbnpu5HYDigZToBT+I04/KXqC65zm3Q/FFuMHrU6ckt
	 JIO+Cho/as6k/r+oisQiLMTCyvBJ4q8p36ROct5LxEC5ZMU8DuhjUjjwsw1d6MdzPAQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linbit.com;
	spf=pass smtp.mailfrom=linbit.com;
	dkim=pass header.d=linbit.com header.i=@linbit.com header.a=rsa-sha256 header.s=google header.b=lWFrForJ;
	arc=none smtp.remote-ip=209.85.221.44
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B97FF60A2602
	for <linux-block@vger.kernel.org>; Wed, 25 Nov 2026 15:35:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B97FF60A2602
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linbit.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linbit.com header.i=@linbit.com header.a=rsa-sha256 header.s=google header.b=lWFrForJ
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-492690dd5daso4508972f8f.1
        for <linux-block@vger.kernel.org>; Wed, 25 Nov 2026 07:35:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linbit.com; s=google; t=1795620948; x=1796225748; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=zW5K52MSqR13vjMOGRw7WSmYMI0ONd2XOyiatd+7KVc=;
        b=lWFrForJqT7zOrmjI34bqPJSqTHNMyN/22Z0Uwzi6TGnnWYFmLAEaFB3BAm3W/LuLo
         xUrUv9rG0AKytxLHhYYf3h8wvi3OAFbRxgABdukzShaCQ2v2dFE+u29vyjS/2bSeBWU8
         tf291Ha0kj3NO0gmHsF1x71k/mzX1TIlGRNr/97o9HRrxReM1N4J2mT1t3m8LmTcPsLc
         BQuFiYmRtJ9zmkZRTXvWHgi1SjhjC39kV7pQhSY26r1r48JHyyOfHFJf+8I046conMZZ
         iRQtTHmF6WZFsbaRNFcClyFprfVKj95scia3KJlE7x2v7jisPYcQL4RY2jpZa859232T
         8ovA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795620948; x=1796225748;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=zW5K52MSqR13vjMOGRw7WSmYMI0ONd2XOyiatd+7KVc=;
        b=zuDQ1bO1VE0OZgxkVCjwRdtpWatk3bviHq/2FfYS6QD7q478N+83NEIlug3w4s/BOu
         gTUO118EJ1AcDMEV0DqhA0fIwSLuHHRileSosLvEKoXfHO8u2CJbG2Tb0bs5HHYw9AZt
         sFUkF+Wletz3xV9VNGSdEHa712PI8/6mnlx8UfBKkeddsPPLtFxXcdSlSFCts53sU4HM
         XBNhgayixV90CxLfZ6YD1cNIYyzp8NIgqWoEVyONAE2EWgGyFvkF7+IeLSps5aVHFIYp
         3G+j+fhCoGH8KlYhiaAp6cpmJbgP5N2k7NBZwZj+zQinnURcPzeeQJRGZpdbL8Qfmy82
         qI2g==
X-Forwarded-Encrypted: i=1; AL+hErF2/Uiyfp6MsSMRKNeQPxh63ulgujUfWQfkQU2x1dgj1aE+bqCwykz67hzFwx6MqaAUyVubJ5LcfDXzEw==@vger.kernel.org
X-Gm-Message-State: APuU4Z9R1xtZdoZF2OzPo+s0jqBMSaEtYXPlur28RIfyJSibF5XQVHvD
	6y71eRAVGBuqnO6MsXJNYBRdixNrSflUYCXMSAHPmQFnz//SbAChteGu0vqKc1S1xK0=
X-Gm-Gg: AZFdTZfO45jZjxY8n9JRU+Uq3G9UXMFj0QLwbY08/9dCnz920VpboNK74v7FnSeZC8m
	UUynpxaNORr/QIZ3+fx9Okh0DOz8e2nk3h43SvXykoz0iS1cRJdcdVdajBZJhcvPiYYGKFDqNNt
	wnpyowRAJ3Tc1AWsF6njZZHkMyvLDfnNeK5jUSLJfvNkz4IJIobP6xt/IFSjfJAxExt90g7meK6
	rlc4wq+xzFLeDuOgTjyakLsX/hG0R3KWas2JlfClsVh/imnrUzYnfHG4ouLmd/1ECoJcoYbOCj5
	tzq2ydDFLx6X6kng8jMwHvYpfyEi6xKCUsynSOQJfUSkcW6ywrX/WYWcyetMjcpw3j64puiz/m1
	9PtjsG+NHHKR7HKBsoSyLea8Y1hS9zO/hZ7EBlZCAMDEaCPhL5oppUAMWEhImDth+/dWilLV95i
	Bhw6jukgl4Sya0wUkqLoXj2+zblkWcvwDbtBuS1V+9Ootmxei2piKd7uvq6nhjUtZ8Ch7GiQmAG
	/bBu+5cc+aG3MZLlvaFQmaWdVMQaRkSOOJVcwLc7qYaHdeehGxmPa2X7ill82lrg26blNTV1Kcs
	xNHsR2zUerHtEETUcNHs+h8j5c95oUPtrjs0jRZCFArSaHCLvOgQX1wZFZq+D4jNaCSPlPEglw=
	=
X-Received: by 2002:a05:6000:1a86:b0:4ad:d65:aaf9 with SMTP id ffacd0b85a97d-4ad0d65afa1mr37658772f8f.56.1795620948143;
        Wed, 25 Nov 2026 07:35:48 -0800 (PST)
Received: from linbit.com (h082218129081.host.wavenet.at. [82.218.129.81])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4ab658e2d60sm35816275f8f.3.2026.11.25.07.35.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 07:35:47 -0800 (PST)
From: =?UTF-8?q?Christoph=20B=C3=B6hmwalder?= <christoph.boehmwalder@linbit.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: drbd-dev@lists.linux.dev,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Philipp Reisner <philipp.reisner@linbit.com>,
	Lars Ellenberg <lars.ellenberg@linbit.com>,
	=?UTF-8?q?Christoph=20B=C3=B6hmwalder?= <christoph.boehmwalder@linbit.com>
Subject: [PATCH v4 21/21] drbd: remove BROKEN for DRBD
Date: Wed, 25 Nov 2026 16:35:11 +0100
Message-ID: <20261125153511.3060599-22-christoph.boehmwalder@linbit.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261125153511.3060599-1-christoph.boehmwalder@linbit.com>
References: <20261125153511.3060599-1-christoph.boehmwalder@linbit.com>
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
index 713ac6c9f9f1..058a30efd6d0 100644
--- a/drivers/block/drbd/Kconfig
+++ b/drivers/block/drbd/Kconfig
@@ -8,7 +8,6 @@ comment "DRBD disabled because PROC_FS or INET not selected"
 
 config BLK_DEV_DRBD
 	tristate "DRBD Distributed Replicated Block Device support"
-	depends on BROKEN
 	depends on PROC_FS && INET
 	select LRU_CACHE
 	select CRC32
-- 
2.56.0

