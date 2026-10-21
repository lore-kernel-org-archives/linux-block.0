Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792614075;
	b=Q+NFO1a5n3paFD2oPYXaoS/qtLSOapCHebp7pMhLvb/HrclDMKZPKUrBorIJx7b2XFEX
	 FIXrbkxEdgEvGYn6cyTnDsKnDSv9BWdIUKZszdZLPft3OodHPOj45+1J6yg1j2UNDvOlk
	 iqFVxsmAQ1z6bJZp2J7OqFpHBK0EaIdYjBoVEop0CM5RzKZmdN6/Kl7TaBWDWz6H8iyir
	 WIF8G3wEpyzNg7Fg9YGG5Z8IjRTo0mCPCLFPTP9WnZDVsTvVADgWgVtHO1Zdg3xAApldw
	 EuWXYIxnbxVPWeTFqg4xTwqJXLBfcKq+mZ+8tTZqZxEGpUUsQ5zMqrdYs1ppUkGTw8Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792614075;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:X-Developer-Signature:X-Developer-Key:
	 Content-Transfer-Encoding;
	bh=47QQzboTv7AoPgZ8tzH/czrKfYk0Q79J1E2KpvO5Lzo=;
	b=5c2pKzeYcHUFSwnPjqr5fTVM4Xl4pHu4PzTS4uwjdADtOam1LCyJvV/FQMYo9G7eJlq8
	 gS34mTEm+CvYjmLVZ9IAnT77G6evCbA+FKCxUdx88QmPYKJJPrllGTlObaNRt9K2cjmXq
	 O7QHx4ZvuTKk6IWYTPlyXMmA3P2H1s40OxPS+qfk83N/bkpBGjQknkOxJ6KYJd0CP7b/i
	 9OFXWN0JsULyeiLOj+JXoScER7sutvL2wd8WGyCOD/eo6Lmc3h6tsSSkBX5EUctX80dAd
	 AD/ii7/oIhFXLbyr5P3oSgutXn8UYf+eC6ocYsUpSBaD9gIdc10uZ52rsPsxzjADvdQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=F495EXlU;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8A08606A319
	for <linux-block@vger.kernel.org>; Wed, 21 Oct 2026 20:21:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=F495EXlU
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0968F1F000C1;
	Wed, 21 Oct 2026 20:21:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792614074;
	bh=47QQzboTv7AoPgZ8tzH/czrKfYk0Q79J1E2KpvO5Lzo=;
	h=From:To:Cc:Subject:Date;
	b=F495EXlUzKw9iXkF93Lg6LGeB6Jls91Kyi0I2J9uHoJQ7CIsXTpER9LOnSO3gk8eU
	 wwTC2D2RB52CNXBCMb59GVyvRCGNBJjdVxzpNeL6VKdtE6s2/loAknnAEJ13M0/oiP
	 olwie0gruFJvuANBjTD1KjRPD9tF8Ce0+E1P4ibM7z6teHS5YRBUL5dlGHPixnH1YY
	 Cn5H9Vfh1XSpFcyjs1rYY8m3dW2cmyA+vvSPJ4ty2CCPI4esz5bD+tCvnZ39BnrJhG
	 85V3eLx1kfPXgUpn8bompzNbFwwdjdFwEw2uzXUVCnZg6EBwevrJnmnEi8jajEgem4
	 n07a4toKDDMaA==
From: Niklas Cassel <cassel@kernel.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>,
	Damien Le Moal <dlemoal@kernel.org>,
	linux-block@vger.kernel.org,
	Niklas Cassel <cassel@kernel.org>
Subject: [PATCH 0/2] null_blk: zone resource management fixes
Date: Wed, 21 Oct 2026 22:21:01 +0200
Message-ID: <20261021202100.2017938-4-cassel@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=904; i=cassel@kernel.org; h=from:subject; bh=T204+bxphM+rnfxU3jBhR7ftF9OLJrJElyhw3uhCIVw=; b=owGbwMvMwCV2MsVw8cxjvkWMp9WSGLJuyq3x/68WIXynUY5zQ4xJb273sVuM818INGbInZWZV 3X5V9PhjlIWBjEuBlkxRRbfHy77i7vdpxxXvGMDM4eVCWQIAxenAExkujwjwyb+OxYCB5nXaVke 6b088fuL2VnyCQkGO9nu51/dc23TASGGf2ouD0XKvrkVvWC1VLxg9zzu0we1xxP3JQQnT1/qZHL gIh8A
X-Developer-Key: i=cassel@kernel.org; a=openpgp; fpr=5ADE635C0E631CBBD5BE065A352FE6582ED9B5DA
Content-Transfer-Encoding: 8bit

Patch 1 fixes writing, opening and finishing a closed zone when both the
open and the active zone limits are reached: null_blk fails the request
instead of closing an implicitly open zone, as ZBC-3 and NVMe ZNS
require.

Patch 2 fixes zone_readonly and zone_offline, which can close an
unrelated zone, or leak the closed zone count.

Both issues were reproduced, and the fixes tested, in QEMU, with
null_blk devices created through configfs (memory_backed=0 and 1,
CONFIG_PROVE_LOCKING=y).

Developed with the help of an AI coding assistant.

Niklas Cassel (2):
  null_blk: fix opening closed zones at the active zone limit
  null_blk: don't finish zones to set them read-only or offline

 drivers/block/null_blk/zoned.c | 48 ++++++++++++++++++++++++++--------
 1 file changed, 37 insertions(+), 11 deletions(-)


base-commit: f47d223627f80cb7a1eb14c585fe6cb35de5e984
-- 
2.56.0

