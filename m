Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7D38371D06
	for <linux-block@vger.kernel.org>; Sun, 15 Mar 2026 17:16:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773595020; cv=none; b=U4i2O2desVF23A95wf8hI9OPQvL27XMbk49w7ZmntdbiFFVnH6Z7IewFr7X1Hllql6H3eyf9Nf0229/auQ6hkGibu89bsY+k3cM2EBcLbW6QdZgmBCVpQjOorwmlP6uMFnbPhHSR4XhFVrN9QQTpcmU/XBgvKz0LaNbu7mgo98k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773595020; c=relaxed/simple;
	bh=Da/cK6OQrHU3pcAlgLxrLXJu8wvJOC9tkJMNybOwlek=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NIJLPkGWtxXFE6l0UFvCouq7L48LDDMZ4pxXLNQBl504uQYjd6G7X+p0W4WV1BEhhPZiJTPnJOTt0dQdudJ/WLcMKlq3/dqSsihVd0VvSKkksb3g0C8Aaf/pCCTeuK7GTytBZN9eH3PLRhCr2XShI189g9qjA4jawQFDXcpzez0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Hbt4Z7J/; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hbt4Z7J/"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-482f454be5bso45698525e9.0
        for <linux-block@vger.kernel.org>; Sun, 15 Mar 2026 10:16:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773595017; x=1774199817; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=MVyBXQRSzr9/lSeks120us8HXOhp+dnwI23FH9hEtAQ=;
        b=Hbt4Z7J/pTX/JBJKLFLkJhcHX8Te9jRBHsvSWNnUlQiuRHV3hP7fQZrm7OkUBSD1Gb
         J3QJhFaH4HXXRowOLMg71+jZcION16MfaioBo6ogIdcHvkjDQ3UsgTsi2eGVxWEWqQmS
         HLZxSm6wwatviSEX2YQHF3Hb7wgoWzj11ZNwc4H8W5wME2A0YrI+z8jIkeXLrt0vkP2+
         NeStjmEDeM1kzfwwi6sloXfvOc7UfLjjF9P1HQCyV0QkD+FSnsi35hKLwDg39V1JL6NL
         aQpf01uSQxxmO3PfSiCOLHBPAP+VTzxAYeaGBWNCgq2O287yZG9fg3Sj0v2phZcaEPdZ
         QCzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773595017; x=1774199817;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MVyBXQRSzr9/lSeks120us8HXOhp+dnwI23FH9hEtAQ=;
        b=r/EPa1omtgpGtEMnfEOAgDPHNbeGVjjnjHO1N7lv16+j62Usu/Gyl9DvvwfLK3LTKC
         3koIw9AsutKCR7tIYW/wTd9JgGaOF7tsw07D83llyKBHWJMNBI2sHDCSxYQ9QfUSDIxY
         9aMSVvEMs8jcOkMB7QfkGURpaUtMccmqcKttR6j1sLLc/LhUEM/ayajRPrgXcxfTgyH9
         83Yt5YspY5X3bjlB8mFl4yWWZnalsPToPseXvl9JX7W6v9FEO7BGuVJOFZeYV7v/15MH
         GX8SHzJxSoy0S+Hfjp25FYZTdyPjny+eRkcCkmLp17wCoMvHqg5RQfrByWSwIbRCHoWo
         W2ag==
X-Forwarded-Encrypted: i=1; AJvYcCVeaT/h38h7FmnVaYZagEtr6P6ZFR5tz/YU64gziDmJgQf6hCE6WGSZjq+rguLc6l4DAUNsmis0NxsvWQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YyFOeejF8aSYKjszV7lrjxnGRw/ETKKVE/JiqFlDrznIDpa3zbf
	kmzVw55270Cmvjd7iRFcfXpSiP6qYcbSCyIuWefgKoIXiKbQNrbElv9i
X-Gm-Gg: ATEYQzxz5fH9J2zht3swJ5feb1jPu3tOgBeFfuRqdTWAFrACDppsLYfBqPt5gS0vdOI
	hNEDFkrYgvNv9c22y0aTBXqLlqckozxhDFCYPLWkbPIhPwL1xbhrZ4VJ909zQ1fNXLgkXvyAVcm
	nXZXJ+qG44usvRJHPiore4vAKO2J9PHx/8pUCR6spjB4Ef+LUbiRcqm6u+H4RuwvGGiFjUUJGcu
	XA4MCgBdWufKAoQJQ4mHdYxO1EZBcBoUv3svV/VH8bOvcOiVDdxKDtQWcLcVxNfI/EAeY0hvoA2
	CiItB5vh/k9rJZ8RI3JYd+xPhAP0sFASnZK3Nr2xx8pVGNVrUS4NqMpMiCyrgYWCsR/bWmOdWJz
	t7f8zjXVUBcZZ73XzqvWpng449Ea0X2NgR9C48jW4F9rCHSq1sqBhr+o4yaoS2xFKemlExBf7Sn
	B35Qbdxe/JNo9O6NSGvbNF4vPh33kCSxW3xg==
X-Received: by 2002:a05:600c:230c:b0:485:3a4f:8bfb with SMTP id 5b1f17b1804b1-4854f56bf7bmr178045195e9.6.1773595016983;
        Sun, 15 Mar 2026 10:16:56 -0700 (PDT)
Received: from debian.lan ([171.22.84.130])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-439fe21b631sm40536429f8f.27.2026.03.15.10.16.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Mar 2026 10:16:56 -0700 (PDT)
From: Adrian Garcia Cicuelo <adriangarciacasado42@gmail.com>
X-Google-Original-From: Adrian Garcia Cicuelo <adriangarciacicuelo@gmail.com>
To: Ulf Hansson <ulf.hansson@linaro.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Miri Korenblit <miriam.rachel.korenblit@intel.com>
Cc: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
	Haibo Chen <haibo.chen@nxp.com>,
	Frank Li <Frank.Li@nxp.com>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Boqun Feng <boqun@kernel.org>,
	linux-mmc@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-block@vger.kernel.org,
	rust-for-linux@vger.kernel.org,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Adrian Garcia Cicuelo <adriangarciacicuelo@gmail.com>
Subject: [PATCH v2 0/3] Optimization and alignment for MMC, Rust and iwlwifi
Date: Sun, 15 Mar 2026 18:16:49 +0100
Message-ID: <20260315171652.269020-1-adriangarciacicuelo@gmail.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch series provides functional optimizations and alignments for 
multiple kernel components, specifically targeting MMC quirks, 
Rust block driver abstractions, and iwlwifi interrupt affinity.

These changes were previously submitted as a single monolithic patch 
but have now been split into logical, atomic commits as requested. 
The code style has been verified against checkpatch.pl.

Summary of changes:
1. MMC: Consolidate imx25/35 quirk data and add Kingston CID support.
2. Rust: Update rnull driver to use Pin<KBox<QueueData>> for alignment
   with kernel 7.0 zero-copy initialization.
3. iwlwifi: Optimize MSI-X interrupt affinity mapping by skipping 
   the boot core (CPU0) for high-rate RSS queues.

v1 -> v2:
- Split monolithic patch into logical commits.
- Removed accidental addition of nested kernel repository.
- Fixed Rust code style (line wrapping).
- Fixed iwlwifi white space issue.
- Wrapped commit descriptions to 75 characters.

Cc: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Haibo Chen <haibo.chen@nxp.com>
Cc: Frank Li <Frank.Li@nxp.com>
Cc: Sascha Hauer <s.hauer@pengutronix.de>
Cc: Andreas Hindborg <a.hindborg@kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>
Cc: Boqun Feng <boqun@kernel.org>
Cc: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Cc: linux-mmc@vger.kernel.org
Cc: imx@lists.linux.dev
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-block@vger.kernel.org
Cc: rust-for-linux@vger.kernel.org
Cc: linux-wireless@vger.kernel.org
Cc: linux-kernel@vger.kernel.org

Adrian Garcia Cicuelo (3):
  mmc: sdhci-esdhc-imx: consolidate imx25/35 data and add Kingston CID
  rust: block: rnull: update to Pin<KBox<QueueData>> for PinInit
  wifi: iwlwifi: pcie: optimize MSI-X interrupt affinity

 drivers/block/rnull/rnull.rs                         | 13 +++++++++----
 drivers/mmc/core/quirks.h                            |  4 ++++
 drivers/mmc/host/sdhci-esdhc-imx.c                   | 12 ++++--------
 drivers/net/wireless/intel/iwlwifi/pcie/gen1_2/trans.c | 10 ++++++++++
 4 files changed, 27 insertions(+), 12 deletions(-)

-- 
2.34.1
