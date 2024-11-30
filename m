Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7343C33F9;
	Sat, 30 Nov 2024 09:47:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732960063; cv=none; b=aX1+Q5nWvxuD1l+bZizMbIKYZU8Ik2y3R5CWkhdDqNEePuZuuUfY4YuYmxHwlVB2oTrEXv5Ilsujr+SpvGXmi+KpJI2uRsJdYCD5J5y/or8hi5lrYLuWHJjSwzHrU72UkaIDdzc1SSbUckc94J7kZjEVACgsOBsx+GUJxF13f2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732960063; c=relaxed/simple;
	bh=oayArv7nYZFav4cxS3/svkT06T2YpN2GZolROI10vtI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KWwR4F9gLuZLnPja0gPIrDjWhIOKjjdYrnwshaO0p9WtfUbPMYeWh70BEA8I+GLpLmJuadWg8fnfG0M1EXB34I12fz1bt5ZQLl3aUtVJI4VSlUunYUFDMm/xyQ36LtrP/HV/C5K4TwY3qSDeDEubACkJco4vtWUstGMOcdyTRzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HY6L7Kz1; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HY6L7Kz1"
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-7ea8de14848so1804963a12.2;
        Sat, 30 Nov 2024 01:47:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732960061; x=1733564861; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=VoUMEMbWtlX6JpGvJE/VVxsHbk08KrI2AOQ3zoQri20=;
        b=HY6L7Kz1z8S/norNo8DBiRuFANtRbOUARDhe4buHvelDiyoJX9DMsAocrQ6/PbSD1M
         jdSStySUbWu/PwGTWD0ImKqpGGNKbVxZSDG0QZHIKamkDrRHfYYaHioyvxnp5U0UbfRz
         EZFM/OtTOczUncBhxhn5z4B7N1I88JgVYKfSuNfeBYQu8fJghbWxEqx3JO84hpm8hP2x
         sy2bpBqFqF2rnw72Mpjt09dsoD5Kh2BN5viStD1nmhRjbsKDjByH1EP6M9dd+rxvMyXr
         b/rvckJyWdxghXRioYW5Kk+R7d3X+qhLSLr5+nvu1NU6O9MCS2mH7QvWaFTVn9XXFTe3
         MZ5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732960061; x=1733564861;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VoUMEMbWtlX6JpGvJE/VVxsHbk08KrI2AOQ3zoQri20=;
        b=Ysl2fvwzG+G4bRGCqAobO1s41UdRver3XhVhQeBdHjhpiEchPkt44gkPChw/NLI9YC
         8bPiug2C7eeg4haUIZ716/y4Diu07oRpgi09ll0eReZm7mG272TgdkXt/ZlrsNNCwTvz
         waf2rNE/2eXhJNBcNo+5IFtlpx4nbz3N4rTusGPp+uiM9orkp7pa2J9uyZZWqRHeVCnd
         GlwUzzLd8X0jVQR1KhFZUkGn3BG5Tr0sw+WfcSLHTwaE/PevJRO/pn0xRSEbo1+deJgw
         SQL+SZ9GjJ4GvZgu2xpIMfSb1WZrD0tChqG3jCCEubt0bgXA1Jo6KgvS9ZBUTm72JUPt
         6HWg==
X-Forwarded-Encrypted: i=1; AJvYcCWOxUTQ4LcjwSQBVSWy7d6SueiR4pTkkhiE/FcktWuXx3SeVgWxWtshieTSaJrPGWPQV7imD+iCWmcBqaA4oA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+klKH9oHs4LE4fBf7zNSKOyP9ckLrYjCgs0c3z9F5gUN7Y1+A
	ssQbSEA7b/ar/zkAuO6RmYMwmEEaWn8obD1J9v7NbxhvPrEAy1YIYcX5NQ==
X-Gm-Gg: ASbGncsrKRdvYjCmk16Zc2RgPKfZohbvsoqRA5W61nNv0g9WWuAnrAkdpwgiF/Pbvf7
	+OajA6pAIJeb/cRedSJDNfgyCUnHQzTNR9A5/0/WIARJI6KLvn0prgUcir03TYA8qc3ufNGCCkW
	TXmYPQm8F2xXRGRojYzEZVwev3obI7uqckdTTfrF4PEby9j4eppmH6PMZNHKO4qRfRF8TjZJrxA
	qfk46p1GEo2TWiOvsxSj6ttbzrWwM+Jek94ZAftBXTeiEl1fKPYl1Yza7jhgmZmt/XEomXPgXqS
	Rim8FgHdvQm3Vil/9Wmdb2jZ
X-Google-Smtp-Source: AGHT+IFYzfrjFMROl6xXx44lWRNNvOA5HhvhFcrglK7FqkQISr6h7L+PGtbmh1ohvktLtxqrjqs25Q==
X-Received: by 2002:a05:6a20:4394:b0:1db:d932:ddcc with SMTP id adf61e73a8af0-1e0e0b26197mr21378099637.19.1732960060642;
        Sat, 30 Nov 2024 01:47:40 -0800 (PST)
Received: from mew.. (p4007189-ipxg22601hodogaya.kanagawa.ocn.ne.jp. [180.53.81.189])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-725417fba8esm4842038b3a.97.2024.11.30.01.47.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Nov 2024 01:47:40 -0800 (PST)
From: FUJITA Tomonori <fujita.tomonori@gmail.com>
To: linux-block@vger.kernel.org
Cc: a.hindborg@kernel.org,
	boqun.feng@gmail.com,
	axboe@kernel.dk,
	rust-for-linux@vger.kernel.org
Subject: [PATCH] block: rnull: add missing MODULE_DESCRIPTION
Date: Sat, 30 Nov 2024 18:45:21 +0900
Message-ID: <20241130094521.193924-1-fujita.tomonori@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add the missing description to fix the following warning:

WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/block/rnull_mod.o

Signed-off-by: FUJITA Tomonori <fujita.tomonori@gmail.com>
---
 drivers/block/rnull.rs | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/block/rnull.rs b/drivers/block/rnull.rs
index 5de7223beb4d..9cca05dcf772 100644
--- a/drivers/block/rnull.rs
+++ b/drivers/block/rnull.rs
@@ -28,6 +28,7 @@
     type: NullBlkModule,
     name: "rnull_mod",
     author: "Andreas Hindborg",
+    description: "Rust implementation of the C null block driver",
     license: "GPL v2",
 }
 

base-commit: 2ba9f676d0a2e408aef14d679984c26373bf37b7
-- 
2.43.0

