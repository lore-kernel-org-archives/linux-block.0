Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5B68399374
	for <linux-block@vger.kernel.org>; Wed, 17 Jun 2026 07:25:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781681127; cv=none; b=gU/rT/8agYB0Xki7t0HZ1svMuQ5JsTSmdAqa5t/zvlc5Jvuvji5pD2hmA+9eAapIA61lkhfoIEF8KiyR93tN26ZpECBXfG11XdUKzFtqAjLGDyxalU0T7xy1WrDMju3YefZmVuexH9XMJG0Lsn+BDg4jLKX9IP9SLU02XNZQE7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781681127; c=relaxed/simple;
	bh=d3Pa+0SCtloedc8qb0T1CagFMwtsxt+zHkJL+0xCL40=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FNs0vNmHS8sgoyA2WNuX83yEzh8iDWzSiOM1VSwqwqkIOleoKg9K8KIPLGDC5i97uOxwELXcmwiGjQL5II5EO00VbTq9jwqUTJRuoWvb4LPQiLszbeWuJsdYcPhJGaRG+4ggZgyeCBtGr72DHb1ngSGT6Q9/7HBNIKKFs7An7Wo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GFuTQSDV; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GFuTQSDV"
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-45eeea039ebso3081075f8f.1
        for <linux-block@vger.kernel.org>; Wed, 17 Jun 2026 00:25:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781681124; x=1782285924; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5zor5nZc3reLusx5WoisGmqX+BfV/vYhEmVHYmLh2EU=;
        b=GFuTQSDVcfjZzL8R3LqNx87Uf8ZKVdiYg63+0uUdN09eZu5cloZspMCbgERuySVSCs
         MFn6hm+zJ8lklWaIhXJM+MFj1SOV4tua5p8gCKrbxQF4xRuCEryEzUYfh7ao3xzG0gqX
         xSxFrwV7vBZTYn162ntME4Yrwf+gTsBlvuYKbx69P5rSZgd73LAb3h6NH6KIGZgNwNIs
         P3ZieIB/UM4QTLWfzJKWnWIu2TczxxWytTjIZe9cly6D8ntrFWTzeMeOjCOOWH5VAtVk
         B0UrbqnDBpZDGloMG/vzn5vnTRrGWM2pqbLVx4/FD5cTwUfD2A4145NnzLjDtM3Z/S//
         4y9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781681124; x=1782285924;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5zor5nZc3reLusx5WoisGmqX+BfV/vYhEmVHYmLh2EU=;
        b=CULVb1nMAlO46ZQi/oZJEy7jl5x5okTBnqDI5mlTPxpZOPTyNpLoGriaaFErdHJdl/
         AJdqjeTmkjOx+EEa5d3swYirLVNaxysDW9XEvKJyvYoCeccY5rNvgotW0BRX8AJwfIby
         BNtNAtgVQHCYl3ELK97ZQKYx6pEXWB9aHeV86PpDKniaCFGq1rNoKh4rNNN46/MjD4rz
         Z9k0OBSi+evxI5S6ScBNJsIPEZJVoqhnXS8bd0ZP6ZLUzCYi9JlaqUAvlp+92aGsvCoN
         1BN7nqGhWGTLlWD6DmogLsUx/BDvyqqwdd4igp7UUDr5AAEJ+fZgpfgfi3g3SuBWWk2o
         qH6Q==
X-Gm-Message-State: AOJu0YyNpfqnhHvDWdXbEi59UqC107cJQq65dM/lN9nK0oNF+8S0g1Su
	o4HkTMjDzXDN3VKACOieKicWqf2M2MBjB9SZijWdF+7O/yBcJPZYzbNbgfUQZQ==
X-Gm-Gg: AfdE7cnrIs50sEi3x3ZaUR93wVges5fajHkF3h7+uCwPrRDxQTC4SzppUdbLJRwE77m
	XgNEpfT233LfUAtUlVPuu5Ah1Klzx86ViGkgI2NKt10waHo0bxr+DfHnzV7jXwmyvWeoCUIQLSk
	VkQ5PrumYz0Au4PZGjMgeJnxJFR3wKQYa5DaL9CwW6wvODFEF72AL17Fn1ur3yirxRVpH3tkMwJ
	TM4HkKcRSgqic67M97sg5s+I+OwMI0vruF9uwNUu9YHyUnS69aK70Znzm3mDJlb/WiVxSW15BnO
	oQnuCcSgbgSz2ev67imiz8YmnksskPZekcPpH0tc8Gmo7ZLRPQ8mgkDacTgqH8ZaUWpbilATZHd
	BgtAP+rITwE/YjTaPt4PJThoivOEoBT+xX01Sd3qOJ3tX5UYYmue/IFLgfhXLNJYfUZJj5a74iu
	1oFDhXFB1KHFOOig/uYAeIqasQpV3vGS7RGuY7B1kIFGCZ++VLKy2w5TBl+fvD1Y+IdEYUWPLXP
	beP3SZOh3qrGVOxw3h0eadYXoUIG7B90/VF
X-Received: by 2002:a05:6000:4023:b0:43c:fc5c:a9fe with SMTP id ffacd0b85a97d-46238ac9fc7mr4948686f8f.20.1781681124153;
        Wed, 17 Jun 2026 00:25:24 -0700 (PDT)
Received: from localhost.suse.org (apn-78-30-82-184.dynamic.gprs.plus.pl. [78.30.82.184])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-462a9784497sm3009320f8f.34.2026.06.17.00.25.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jun 2026 00:25:20 -0700 (PDT)
From: Sebastian Chlad <sebastianchlad@gmail.com>
X-Google-Original-From: Sebastian Chlad <sebastian.chlad@suse.com>
To: linux-block@vger.kernel.org
Cc: shinichiro.kawasaki@wdc.com,
	Sebastian Chlad <sebastian.chlad@suse.com>
Subject: [PATCH 0/2 blktests] Update the miniublk to use ioctl opcodes
Date: Wed, 17 Jun 2026 09:25:14 +0200
Message-ID: <20260617072516.6238-1-sebastian.chlad@suse.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

miniublk currently uses only legacy opcodes. Kernels built without
CONFIG_BLKDEV_UBLK_LEGACY_OPCODES reject them with -EOPNOTSUPP, causing
all ublk tests to fail. This patch solves the problem and the following
patch adds fallback to legacy opcodes for testing of the older kernels.

I tested against the old 6.3 kernel supporting only legacy opcodes. Also
against new kernel with ioctl opcodes and legacy opcodes still enabled as
well as the new kernel with ioctl opcodes and no support for the legacy ones.

Sebastian Chlad (2):
  src/miniublk: switch to ioctl-encoded ublk commands
  src/miniublk: fall back to legacy opcodes on older kernels

 src/miniublk.c | 77 +++++++++++++++++++++++++++++++++++++-------------
 1 file changed, 57 insertions(+), 20 deletions(-)

-- 
2.51.0

