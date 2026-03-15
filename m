Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C51337754E
	for <linux-block@vger.kernel.org>; Sun, 15 Mar 2026 17:25:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773595518; cv=none; b=bjyT5crl8KY3Cv6cFBCkINRMhxkbPGonD69rNjX1+9qvgGREESp52qAZhrRb3cBS8CKh2wo+HefMRtQN+n7z8Y1sjBUpGiCGQvkwGL770iJAWcMbsAjuIhNce3UMjo/2LzGafQyho4ZoqLY3bCRHt9wQq5Gr499zUS2SeScgTaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773595518; c=relaxed/simple;
	bh=t4IEjrlPC/zChObroSpygBEwzjH0OsQxo5JZHzvQ1T4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=VV26TY3xIMoDnlBNKJvaNku8LvJkAXJd5lNveyrPr/qoWxXfay2RgzOGozBzc5IpjNe9p01Bq07fV7QXZt/6umYLmBBjFRdKuOSqQK13ejoIrmpYqIjOs5PmcqHAsUUhus6G4G0fcK3sm0kFqfpfe7NYW+DhU/IWbe0Qk82iX4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PFJKUc7m; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PFJKUc7m"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-48540355459so34332605e9.3
        for <linux-block@vger.kernel.org>; Sun, 15 Mar 2026 10:25:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773595514; x=1774200314; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=nwUo5hAkI8FkU3V+3kGLnu098RQoJ8LL+Qih0GJFD4o=;
        b=PFJKUc7mj/jOLsLlx0u0TGb7O5VMQ83GWjJicV52NVFxFjGZ7jqvKmGPXxbz5yMEWz
         R7FQQsrdHqcx5nuCYm9wspa0/1nuz1zFXJGo3PUcJDs8hAS9xRvvJ5vG/1D9b1vNBrzS
         N+E5QMy9GUBapnga4VofMPLgcpuisvI3S5zOSJ93EY8WXDkdAe6oammnMRMdN1TyGn1y
         oAaTgz3xRPu5Z6VBGdpsoaZyuADhws6RT4MAfEagM9V1a6IM6sc9dfr/G7coI9U+oPTJ
         mfoKyDWCpu45R2undLLqM7aMNRYYxlKRO7WKN2JlhXR+bTWmlp5ge+AhIQ2q7x7iuSw9
         hbPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773595514; x=1774200314;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nwUo5hAkI8FkU3V+3kGLnu098RQoJ8LL+Qih0GJFD4o=;
        b=naowhQWV6+K4T1Dk/hujoKPMPYZBQcFrRov46yswBe+Wt02hVRyYICyLfLthV22/9S
         pDfHAJ8dw6Kiw8H3C/+M9fTW0gierk4EQZwDglPBlv4ABGWyi0Plwr5SJWGkZw13AXeo
         qw+lmHqmtx7S85NLnktlQghNdib+tq/HnJVWdIqc/xvj2iP6me6MOPd1EXJy8mAyoaL2
         sODAhEfJkMy4jgWHBpbxaRT29YQrseLaP0EI+pnKubf2rb3Vbqeyirx/ofQE+vNEH3pk
         p0QJflt+RDa1/Fbys41iFpOC8KEFisC1nlc6mKGRpcwKeWJhebp2/MMqxixHd/ftSMii
         /OXA==
X-Forwarded-Encrypted: i=1; AJvYcCWkOHPO0zCUs+7yw5l9v725kqsKDIJsNdECXQITUEtClNU5vXgXt1XgiJQ5abgxf7USO6c8NNkn7B7hBw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwHqyldK0y+a54PFYIGjC6r+GSDHV7Nw5WeAn9Gik0jWHGwhZv7
	/3jQMYTSQr/ChsrTsYMdneSg56qRaAar7l5Jp0602/Wda1DTzsJssXKG
X-Gm-Gg: ATEYQzy7/FYRiQv6Irlch+rLNg9Vd1HoT/KtrUOXtAbKwdvoho6D7O/pHfY6LhGb53B
	s1AQspQIgN/pY6aGK4nITu3+RItz1qB6iUM81KiQ9TWf7UdvCReYnDRhbKz7VJkp/1Ue8Tja2Oz
	zFhrw3LJJJZ8v/hNnz/WMA83DZm/Y3tCYwxD0sTBsr3IWSuHg0tyGS8WIeRlCl2GlW2niAExgSQ
	cRfMgbRGQarVAzXSBellTu5qGZznNe6IFCNJ7qse60J8daKKorGapEvmyxL8AwlBjMrgCwxQ/U6
	S9tkMv1i4gzlykWKImMFEJiGexEtE0zW9SFJX1okBzH9ssqyi5j7FxYE96AI+bDVNHGe/CGRnjw
	pBrdcteIR0XqHM8WiZKNs/vh0M9z9ordQmFWxCWeAMCaUWFzzywxUnL5yxwKx/gIKDpub1k5DJQ
	D1pKAwiD5jR6MHwvsmo/p0qVvPlZURl0eav9k=
X-Received: by 2002:a05:600c:45d5:b0:485:40a6:442e with SMTP id 5b1f17b1804b1-4855649c956mr173044125e9.0.1773595513423;
        Sun, 15 Mar 2026 10:25:13 -0700 (PDT)
Received: from debian.lan ([171.22.84.130])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48541aa73easm457168325e9.3.2026.03.15.10.25.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Mar 2026 10:25:11 -0700 (PDT)
From: =?UTF-8?q?Adri=C3=A1n=20Garc=C3=ADa=20Casado?= <adriangarciacasado42@gmail.com>
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
	=?UTF-8?q?Adri=C3=A1n=20Garc=C3=ADa=20Casado?= <adriangarciacasado42@gmail.com>
Subject: [PATCH v2 0/3] Optimization and alignment for MMC, Rust and iwlwifi
Date: Sun, 15 Mar 2026 18:25:04 +0100
Message-ID: <20260315172507.270480-1-adriangarciacasado42@gmail.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
- Updated author and email to Adrián García Casado <adriangarciacasado42@gmail.com>.
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

Adrián García Casado (3):
  wifi: iwlwifi: pcie: optimize MSI-X interrupt affinity
  rust: block: rnull: update to Pin<KBox<QueueData>> for PinInit
  mmc: sdhci-esdhc-imx: consolidate imx25/35 data and add Kingston CID

 drivers/block/rnull/rnull.rs                         | 13 +++++++++----
 drivers/mmc/core/quirks.h                            |  4 ++++
 drivers/mmc/host/sdhci-esdhc-imx.c                   | 12 ++++--------
 drivers/net/wireless/intel/iwlwifi/pcie/gen1_2/trans.c | 10 ++++++++++
 4 files changed, 27 insertions(+), 12 deletions(-)

-- 
2.47.3
