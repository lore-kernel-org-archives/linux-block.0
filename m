Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 307BC371878
	for <linux-block@vger.kernel.org>; Sun, 15 Mar 2026 17:27:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773595676; cv=none; b=iHAkuoIwK90GUvAiy8aINnRUBVJqaesuQnK+Y4RqNBQsEWzBZPgY6GV6tM4zverb9NEXhDS8tmMtgkxCrYxRL2w/gV0xU18aSi1L4IANBYq7NDyRKp7GbsN42Yz0FQkiKBRbq0K9cEIBCENqXMGGYQoWAXJUaE2g2fMSf4XsDVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773595676; c=relaxed/simple;
	bh=t4IEjrlPC/zChObroSpygBEwzjH0OsQxo5JZHzvQ1T4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=uojZ5ggG7hZ7zued4xIP5gQk80OziBtNxcM7At5uYqYC+1Ccwiej2dy6C/OwLpjBidPphn9BB6T1FS/b8hpVFx/hVoBFfrlLneOvs1w92M6ncN7W2cIRUmEoTiD7Uhkwg4sY3DxPiUOqkSn1YNu5SRgRh02IZMfq5tZvoWCJqH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d+m9ZiIW; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d+m9ZiIW"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-48538c5956bso35274335e9.0
        for <linux-block@vger.kernel.org>; Sun, 15 Mar 2026 10:27:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773595673; x=1774200473; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=nwUo5hAkI8FkU3V+3kGLnu098RQoJ8LL+Qih0GJFD4o=;
        b=d+m9ZiIWprHELt1wMn6ikjKhjod+dOB77GCh7OzPVM0ARTDFsFvqVsb09lbEbU3Goi
         nwV+5DW/URuKiLqMIh+RKdRr3PA7Xw3Y2n2hXuKtLVwhQGfXfUhZOkmxJiEdHqorzGOs
         q2B2tQPvxY5QvYf1PvtHvuHNz66vsCVyw71wDv87vOWsuLHuopLCNGPtmc+4AihKpGKD
         iNC6or1IOq0zjABdxr76npW5Q+08I37BYj9qyVBpmAmKguKulBGaXDIStqrwNqedaxs7
         mVc5qov417XNiyaDj3e+kM2Gt3hVADduNgkjiy3xBvxdNiJgHlRiTOD2vtzF1I/KEUYV
         kpqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773595673; x=1774200473;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nwUo5hAkI8FkU3V+3kGLnu098RQoJ8LL+Qih0GJFD4o=;
        b=VBDsriFEy/BquQ5gm2qHwJpmhxtVAzXYEaw0EDJWLoIEGqNWSDMSDxd6rPPFbUw7nL
         LOK6Mymn1EVc5Qp+AoAXQDkj/rOOc580rcPEtzSY7ngt3JD/2mhRzAte+Fe0SiBOXP+k
         IXU01pHqdnNuLSEwxR8tc9R4G2X54PTGm6rg3H4IxFLkDx2l3PIcHVqyuaSC2m3HDZP1
         oLS1PlaCLjBU4rT7F+yaUmhWpTlyTCqNLpIvHURahQRYOIqVEETeXMEkYQCOKg4NetG8
         +bIeWwTGVywKmgUqodPFqJPpEkrKwNKS1mCvvdMm/axcoSI/3QdhCnQNd+5bdLwYvJNE
         EcTw==
X-Forwarded-Encrypted: i=1; AJvYcCXKF0tbnmvPZ8ch8B8x3t2uEf+xLKno/dXPeap1+TVaEye1OAUK85BmdHCobZbQA3KHb61sZIO1JQtASQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0DhiWJ4gh6mKI6RRkce0yNXqDHmarkBrkF1+Vb85nCKvEHcle
	03UeENptOYeWIIESRv6l8lZaeRYGrR2zLcRyeixNf8+oTuau9QgTyCki
X-Gm-Gg: ATEYQzw19wALBDukL854zyhnxxRORK0SpL3B3VLlTZg9RDO1sjtgZc20WWoMf6hb56Z
	YAQzS1JcMzIkxSbsrO/n5ElCaRy/ljJNd2Fdbny7abJaSxX4cYljRKU6Rh5OaoK12y1UaRVbz6I
	f4t8dhgfE6KOgJke9NNKBC9pCNM0KzbD79Dr3XXBNHsGRuUXSC+Ul6mVMmyoIsyANQMIicgsUQh
	pWsrF4O9dfsX+cXPMIBi7MkEBDnfwiBy35RPAKkZklDq1RBm3ZMGn/KLIjJxbnx5g9i1CBG9hbw
	7Cw0G64iG5R6iA1IehpYmhdhFhEeYBbszhll2uC+T1znIgAEYQTS8HxGjV7AaO7YDlJpJfK80gZ
	tMC82JOLOXN0spiQgrF/0DdJsST7eciNg76QPWok6+b1Km8xPhzoXKIwFa7AqgSNQIvletyL+Oa
	uwWH2hKtcUJQ2V0bnawnqF8y3D8tjkbzkXZWdS9uOy0Zfgtw==
X-Received: by 2002:a05:600c:4594:b0:47e:e59c:67c5 with SMTP id 5b1f17b1804b1-48555acaddcmr154699455e9.8.1773595672220;
        Sun, 15 Mar 2026 10:27:52 -0700 (PDT)
Received: from debian.lan ([171.22.84.130])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48557c6586csm73644905e9.20.2026.03.15.10.27.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Mar 2026 10:27:51 -0700 (PDT)
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
Date: Sun, 15 Mar 2026 18:26:37 +0100
Message-ID: <20260315172746.270734-1-adriangarciacasado42@gmail.com>
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
