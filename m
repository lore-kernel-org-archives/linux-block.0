Received: from mail-qk2-f42.google.com (mail-qk2-f42.google.com [74.125.230.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C093338D6A8
	for <linux-block@vger.kernel.org>; Fri, 18 Sep 2026 01:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.234
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789695609; cv=none; b=WaKaNOgAfPLrL5oGNwDYGe77wZZc5vbrmtY6l4s6Vc8AXmx6mH1q+wRJhi7FuaLgQjqp7f5zBXFHlhkkm9TCcLIyYwlANCM/RbkhYmZOqFBnh55jEGRjnMyOfY2g/DIwYRHfJeH1WMtOmYDmZZ2jvlXza1lZoArlAffIfu8wwB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789695609; c=relaxed/simple;
	bh=rKVQkrvlKxZErMl62PyziscJ1x3B0r117JG0Jg7t32g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QIdjRoloN429Bnko8fv8j1/ujLhOuNMtmpKGuvlcxnNBv3A659EP/BhZ7ra5qUUnt/QUCMsYTczFs0jAv6YtVNtUuy9hpMlsofM3AqtVzTBf5WGEWJl8jyB9yCmgvvIL2qkup72mMoe4fSx09UioIQUTQ2a5GWg6MGSQKBOri7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cU6yFz11; arc=none smtp.client-ip=74.125.230.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cU6yFz11"
Received: by mail-qk2-f42.google.com with SMTP id d75a77b69052e-5329fc7e0bcso2493421cf.1
        for <linux-block@vger.kernel.org>; Thu, 17 Sep 2026 18:40:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789695606; x=1790300406; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=idpqljwjFAkaCsozxTgUjb3fkRVspfWwVpLs7VsVxlY=;
        b=cU6yFz11LkYkLPJF1gL9iX1UubBU/8hivNrBDNTc7kgDmTIJv7i2+9iboYPrRca+5i
         yIzgYhfwA3hcJrh9QSHx5eLAZ9oEJbH1bcaPTN0xmpu5xbqfBt/BOha4wQS6GZyNmWvS
         7uK0P3HXwWpYuuqSAaUL35qtZYKhN7ZCbUoWRvFKHTcA7nim4F8EuYlP1DSoiaGsVhAT
         DLdr8TKJbfaOQyogNLLiOkG4ZPSL3fokCQfIHdhb0046Jf0nxHhSc7e8X9behqI63h1U
         u8jmYFEMjRCLd4rKAUWMeDGkAJpA4GvcpoeHLzk4oN1/hKisxdIcUhs3jMCNUSvUvU8B
         lamA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789695606; x=1790300406;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=idpqljwjFAkaCsozxTgUjb3fkRVspfWwVpLs7VsVxlY=;
        b=0OG5+PM26LbiLrAT+nvq76rjXuQQyNfWPGF8bsJdleNXPjKm95obTRuWnGHjRyAzVk
         h1msQ17WXx6HRd19Yw7jiFUlHsmd1c5zNo2RFwEhn7iWc9Tuxn70yfz32xqaReejFL+f
         +S6vEl7EOQkBWQwa97TEPxZH/6jW0Wmzh0hGBRirpSZpLWcDa5wKIzR535DpQoZ6+ixI
         5ePg+/8hRgLnuHpfxbgWtfmBEEkbVDUtRKyVZ7EZTon+0R9LKNblO5Jmi6mElqNYlSv+
         rxLuDq3nuIVlgvTMoo6QpGogAFgFzsGaQRyspE1ErHwDyVhxySXeXZY4reFnp1IL0Qlw
         bMbA==
X-Gm-Message-State: AFuF++lwxUcfw2DbZKBXwNf2re/wNu0y95Z2v93r879+dswKL3Yk/1+S
	tXmLrNyJvudXRGOkFZcRBRyvzKmKh/o6M0bS1dCfMT5etm7AQweSKoweIql6QLzK7Gw=
X-Gm-Gg: AYBFou0tZoVt0nxznU9ZTo7Xv2egrSWKsTvutsk1vbJ+wtPprWpvkRtuC8Vg29gN+Cj
	1YPXAJDivKrUAyi+YNK6q77Fw8HDzdGx6vruk8FGF8R9olhU3rq5Q2ni+0cujS4TvumtEeU2qyk
	ZuzJKA6GsiiKvvex6ecfoFvJN+C0Vz/HGpI2/mnmuDGbQdyx+owLdk+wVNmMaV12r/+PrcfFBxM
	0N+g1gXb0zUXOn6uK2/h0FifRtdmkFDJvrdSQbcr/fcb4hugE2ETaujLdMoZHUUMUPriZbzNUeE
	p5BLyGvM4vCDUwGhX3v9n7Y45oNWbNwCFszHPsw7tpDKUmcfAGEdAO9YQ0Bht/rGGwfIOvd9VFI
	nYaOMaXTVak8bgAmfixQlYFiff6bB3mDWp9EdrYm/iMuAbNeg0xhv7s+GHeSNPWYMAhBCSe7Fty
	fn210MQMkcXoi+dibJWxwMfeozq9HXECFP6Y/XIW0O0o7NvjvaQuMP1rY2sc5BSK/coI2ge1W1+
	sqT1dmTFfEM32N+L1MYxZSn1q0rXTQY
X-Received: by 2002:a05:622a:17cf:b0:532:9ca3:a409 with SMTP id d75a77b69052e-5329e3ab307mr19151701cf.24.1789695606384;
        Thu, 17 Sep 2026 18:40:06 -0700 (PDT)
Received: from emedev.tailf75c28.ts.net ([148.222.209.140])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-532a185be6bsm2157041cf.1.2026.09.17.18.40.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Sep 2026 18:40:05 -0700 (PDT)
From: Emerson Busson <emersonbusson@gmail.com>
To: linux-block@vger.kernel.org
Cc: axboe@kernel.dk,
	linux-kernel@vger.kernel.org,
	emersonbusson@gmail.com
Subject: [PATCH v3 2/2] drivers/block: integrate ramshared driver into build system
Date: Thu, 17 Sep 2026 22:39:55 -0300
Message-ID: <20260917223828.ramshared-v3-2-kconfig@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260917223828.ramshared-v3-0-cover@gmail.com>
References: <20260917223828.ramshared-v3-0-cover@gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Connect drivers/block/ramshared to drivers/block/Kconfig and
drivers/block/Makefile under the CONFIG_BLK_DEV_RAMSHARED symbol.

Signed-off-by: Emerson Busson <emersonbusson@gmail.com>
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
@@ -41,3 +41,4 @@ obj-$(CONFIG_BLK_DEV_ZONED_LOOP)	+= zloop.o
 
+obj-$(CONFIG_BLK_DEV_RAMSHARED)	+= ramshared/
 
 swim_mod-y	:= swim.o swim_asm.o
