Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794386111;
	b=lqoBEC8fRYWrMj4k3YmEHAfoYOwMoGYSVAdVDy4ua+KsNVR22QQIA3aZvJazBqrum6lA
	 0QR05CYKKcoI3PZGCiS2IhZVdPg6rYzMQl5oZggsBF+WD97QsQQXWDGCjcWEINMNgU6Be
	 drAHQmhy4qE8DZUXVVLG/e9+5/BO6F4oD/9z3a3xQM8NVN7vVZt+5tyA/5qZR3lTu6nX+
	 I/SrWyrJtRbqNSCYXr0ql/GWETeY0rBGi/hCDmltItp1d6R8zYAw4aAqknXeL5VQNQfQl
	 JgV0RIyko9/k82egAZwh7ng1tFO4tFweaINKPvwDhyfyr2uTHDRGq6LqRCEsWwoyhCg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794386111;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=sSx1r6YADSLNod2etVKoZeGoyw4STJkD6JZ9QURsIZg=;
	b=OTMBuVly9KeLhzhsvdnwC+OaggdUIyWYDoZf1Ozp54EYp29HbPGzUiJBeEhoS3DMRuTU
	 n3Sk59LDzbrbXomG0asJrrpRVfH5A8MBGZZuU+ZNHrkFcwaIZWyH1RM0J6WBzgYNUW1P2
	 acV5UbigPl1DCvBOBEbLXeFhltaJAkLTWIpkaIy30DSP/NMa6HiRVR+IvwLcfBX5f8WDY
	 L3aDg5F51j5a9d2/r18No171heLgSF81Z08ILT2sr3+acxmYhy4/U4aF+z4YGrzfr66/3
	 GnxSEkLS799RYPLoqxIhpi+LN27JaJb6hDL02binUcaAiG20Jlaouanku/zqX2IcG6Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linbit.com;
	spf=pass smtp.mailfrom=linbit.com;
	dkim=pass header.d=linbit.com header.i=@linbit.com header.a=rsa-sha256 header.s=google header.b=CNY0UGY3;
	arc=none smtp.remote-ip=209.85.128.49
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B6AE60A2602
	for <linux-block@vger.kernel.org>; Wed, 11 Nov 2026 08:35:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1B6AE60A2602
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linbit.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linbit.com header.i=@linbit.com header.a=rsa-sha256 header.s=google header.b=CNY0UGY3
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4a207b02a2cso20053615e9.1
        for <linux-block@vger.kernel.org>; Wed, 11 Nov 2026 00:35:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linbit.com; s=google; t=1794386108; x=1794990908; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=sSx1r6YADSLNod2etVKoZeGoyw4STJkD6JZ9QURsIZg=;
        b=CNY0UGY3JRglswd07ZR9yUlhfd6OS9ERgZHYqKmGeAKBh88Ya4ND0QgAMYg7CKm3hj
         g3n3tCczndcFCr0g5MO7TRSKXJX7zBkXydsA1pcFf0bX0WX4wb1rS7KYIhBTC6wXx+n3
         J9575TilovYVqDp8ecz7Vmt6nHh10/dFxuYdAYzDy1VCd3C+RJ/FT10RmiHEpYQVPVL2
         6romSk0CaluUQyLNSRrBLgqy7rmyrF2Rb97nppmave/fiEBO1Ulvb8Jxd6RJDx96TlSN
         lEGSDew+YIS/a3hl3MhqyvxBKCuo1RfboigthRFXZsHFrWNhcilbOCEWOWx0O3l6S+Oq
         5y8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794386108; x=1794990908;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=sSx1r6YADSLNod2etVKoZeGoyw4STJkD6JZ9QURsIZg=;
        b=OWTob6Aq8HcB/mjGwcrHZDjUgzm/BsfvfMYoVJF6zMYzjpd1bgCbD+LFG3gfjOjZcY
         N6UKnOyrBpvuwB0Uy5Yzl+fsKxPotS7kpjJs4iD0TlAaId1Z5RP1quqLtxAY0UXImSCU
         ludz+ERZt1LHOxFe8CVrgUJ1afVWmYyQTwaknMpYlr+dSaA71jyc1fN605iWrZ6RaCNc
         VyEPDSYIlidmEHx71MdjldkDS2L/e/x2EEyFsELlLR+LdJPM9RuabJxEdmxQhl+UuJVU
         ow3Jwml2CpAr6QVvwmvKpOSf0tDmBD5wlEOY8DLO7/vk4VpiqDoHekGnZIwekHailPAb
         +fYQ==
X-Forwarded-Encrypted: i=1; AL+hErEyUyDd9LJCO+Mf79jQ3qUCC0drunIZnpeFHF/WOKcbXM1dLloJII4w5bC9jTnUuP+MOZOj+JprKXNMqg==@vger.kernel.org
X-Gm-Message-State: APuU4Z83Ax/oFYd8a75oeXiqidwtUmx5zGySYvJyCi7q74PBdX7lWtrt
	iGHPMNeKDSFW5RtKS3Rgpc4E9nQpezI6032F4vI7kOHjcRqBUJHIukqDYx1JCB3N5Xw=
X-Gm-Gg: AYBFou08f0WxQA31F/wyW+DrmsE1BzCdxiaDHIprid6ftIaREPHZVGRJ69xZpF1ODmw
	W2w8uYCrMc0W3W++cWcjyL0jIr1XijT+LVbx/uooQaBYlz0IxDnCb8Q3jr2aAV8IjE/lKt4mB81
	YyZ6N8O1I/9+aexA44Ith2OyWPgiCNLV3v7+mFwmm44N24ZmiowLAZhpGw0fNcZGKaiBwlMLJGt
	VQmj0QkY9eVxjka8Ijo7BzrV6f4uszUC+BpGB0kTYNQ1Yr8irQuRZVNhoVfI+N3KthpMmn6xI4I
	8ceE6m8tBSaGiT19uN6qMz7GTwsXlIZP0UZ3bGWQ9oUFqXrdYJ0S6HETd5MXTzbLq7ZqHfg+bTF
	LWWb7hk1eErUpB7BGFQ6XlfQ6OQQu6lye9EZoKirXz4CIMQl7RmfSopHUZBNtktLcSerT7XM52d
	NHsRDusexaBbjFtQxSMga4Ht41thW92+naFTtzA1vdmduLoFFOnYamcmSMzw0dbFxk8uDp2FmHm
	tpeNm79qXp8VQ1HcbDZOCwRl2C82vCK3ufDYIU6fha0Z0Hk/usUYncjRRWcNtvA12ZDcKMPG6aZ
	feXDVm7FyBA0y/WnqcRzy6KFn6hPrJLtGho5e0gBobp2ZoXhFq+qzDgoeXBM9HpSjvQM5nnqMw=
	=
X-Received: by 2002:a05:600d:82e5:b0:4a1:faa1:3813 with SMTP id 5b1f17b1804b1-4ba0939c32dmr32175315e9.27.1794386108056;
        Wed, 11 Nov 2026 00:35:08 -0800 (PST)
Received: from linbit.com (h082218129081.host.wavenet.at. [82.218.129.81])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-49835c37bdfsm9689492f8f.22.2026.11.11.00.35.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2026 00:35:07 -0800 (PST)
From: =?UTF-8?q?Christoph=20B=C3=B6hmwalder?= <christoph.boehmwalder@linbit.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: drbd-dev@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Lars Ellenberg <lars.ellenberg@linbit.com>,
	Philipp Reisner <philipp.reisner@linbit.com>,
	linux-block@vger.kernel.org,
	=?UTF-8?q?Christoph=20B=C3=B6hmwalder?= <christoph.boehmwalder@linbit.com>
Subject: [PATCH] drbd: select CRYPTO and CRYPTO_HASH
Date: Wed, 11 Nov 2026 09:35:05 +0100
Message-ID: <20261111083505.3998706-1-christoph.boehmwalder@linbit.com>
X-Mailer: git-send-email 2.56.0
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

DRBD uses the shash API for the data integrity, online verify and
checksum-based resync algorithms and for peer authentication, but
BLK_DEV_DRBD does not select the crypto core. With CRYPTO=n, a kernel
with DRBD built in does not link:

  ld: drbd_sender.c:(.text+0x137f): undefined reference to `crypto_shash_finup'
  ld: drbd_receiver.c:(.text+0x58f): undefined reference to `crypto_alloc_shash'

Select CRYPTO and CRYPTO_HASH.

Fixes: b411b3637fa7 ("The DRBD driver")
Signed-off-by: Christoph Böhmwalder <christoph.boehmwalder@linbit.com>
---
 drivers/block/drbd/Kconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/block/drbd/Kconfig b/drivers/block/drbd/Kconfig
index 495a72da04c6..d707187d2cec 100644
--- a/drivers/block/drbd/Kconfig
+++ b/drivers/block/drbd/Kconfig
@@ -11,6 +11,8 @@ config BLK_DEV_DRBD
 	depends on PROC_FS && INET
 	select LRU_CACHE
 	select CRC32
+	select CRYPTO
+	select CRYPTO_HASH
 	help
 
 	  NOTE: In order to authenticate connections you have to select

base-commit: aa7014f8d7565cfea117eac36a5de0a05eba65a4
-- 
2.56.0

