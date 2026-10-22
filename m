Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792660927;
	b=0ljPpffeux7cGWgBW/ryR4ws8S+BFTmwWEQSEPJGX1dSeQwcauH7l4VcugdZ4wMDxlEz
	 f09+r4kpztPERQQtCFEInJPC42ZoqTZavN35PlBos2epvFaPCVPTo6cz7rXDdREEng3rB
	 nzUE/cZe0CwtMG/Oh4lH5TsXaUmDrxF6lhQPzMhyn2VXNW/B9Noara6VTmRA0VldsakM7
	 T+WD4SJhJwjRwbFIYCwjEniaOOHECsIVPWB26D5Pi0Rdt5bCkh/kzlBi+r8im86bluJ1e
	 KbB0L8hSMKAh6W9n8Bxjsvl7DszMGK7i/xwO8zVLpgV4qAYEw7JM8nE1ZYNzGgL7Bmg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792660927;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:X-Developer-Signature:X-Developer-Key:
	 Content-Transfer-Encoding;
	bh=nDLJ6F/aTerROkEt/IPbwhL2ADDBMxFFo7vEwcyHkWg=;
	b=gejU/ueStN2Hl+5BiGAw1Y1O4Gs/OmBjW6SvZuokODv82jdvlUbcOn5ZXdM0PbdDP62Q
	 oevYjcsKopc0cZL26dCX8ZB0pNX3Mp65af7hjA4SIzq84jU+lScTy+qyAqkW82ZwpG3Xv
	 oQte/aintkKow/cpFlz36H9BUp/LyDLCbSO9dlSacsA0jNSvh1r1SjVB00+Wu+iI5cYJw
	 HT2Be7szQCWav2Z//DWpZa5C12GauZOAvEalkAuW8ycJub5eUPm+b0xuwFc84fZDr8qHG
	 XgE6iqG6/MSyLUSb6lzVINOg8QU1ZXvNVhAIj2cP7WwS+062lAI5IXCV8ODQeKuUFTQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=n6RWotc+;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 808C0606A31B
	for <linux-block@vger.kernel.org>; Thu, 22 Oct 2026 09:22:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=n6RWotc+
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1463F1F000C1;
	Thu, 22 Oct 2026 09:22:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792660927;
	bh=nDLJ6F/aTerROkEt/IPbwhL2ADDBMxFFo7vEwcyHkWg=;
	h=From:To:Cc:Subject:Date;
	b=n6RWotc+/tEyVQXliDt6fxLorVEhUxRFQtPL1q4xv1p1c57WGAr6QQF+sZ4FLk+Om
	 wwmk1fp0S6yZhZcCsq9mlrgkh4cQ2a/Hy2QEWw0t3VOM81WD+meFu4AGUnj7e8G/sU
	 N6U/wSYu7426KdVp+Z6aaQW/NdacWKb0XmIznJczCRKDvTXmjAYU1iRXstZ/vBfFML
	 rT3XcRrQpaAvSBfSGHAY/dANRhw48EtgxlI46d+7Uu4kZCSKKyt91QIGvDafe9VGwS
	 8nRPpL5ODFG0YS42CmJ7Kklubt7/fuSEPMRoknzfkxgUHARGrk3YpB6SfmDMRL4aJw
	 HD7PDLC5NtaLA==
From: Niklas Cassel <cassel@kernel.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>,
	Damien Le Moal <dlemoal@kernel.org>,
	linux-block@vger.kernel.org,
	Niklas Cassel <cassel@kernel.org>
Subject: [PATCH v2 0/3] null_blk: zone resource management fixes
Date: Thu, 22 Oct 2026 11:21:59 +0200
Message-ID: <20261022092158.2248831-5-cassel@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1187; i=cassel@kernel.org; h=from:subject; bh=lXZbjGK1wH+bTXtUUg+OYcSgXBbDEx6iOEpNWIjXLN4=; b=owGbwMvMwCV2MsVw8cxjvkWMp9WSGLJuXt0WzNASpM8XecQuwDj5w9XvWf4sKw88O6618UtKx O29Z7RtOkpZGMS4GGTFFFl8f7jsL+52n3Jc8Y4NzBxWJpAhDFycAjCRwsuMDN+Sf/A2Hfk7nTXS sVBxrt35D+ohdxvmpInKG2086bnqzUtGhtsOR3nao/O3xU+vj/IubeJj43z+ekNtkeqWWb/Xbp3 gzwUA
X-Developer-Key: i=cassel@kernel.org; a=openpgp; fpr=5ADE635C0E631CBBD5BE065A352FE6582ED9B5DA
Content-Transfer-Encoding: 8bit

Patch 1 fixes writing, opening and finishing a closed zone when both the
open and the active zone limits are reached: null_blk fails the request
instead of closing an implicitly open zone, as ZBC-3 and NVMe ZNS
require.

Patch 2 fixes zone_readonly and zone_offline, which can close an
unrelated zone, or leak the closed zone count.

Patch 3 cleans up the code that sets zones read-only or offline, with
no functional change.

Both issues were reproduced, and the fixes tested, in QEMU, with
null_blk devices created through configfs (memory_backed=0 and 1,
CONFIG_PROVE_LOCKING=y).

Developed with the help of an AI coding assistant.

Changes since v1:
- Picked up Reviewed-by tags from Damien on patches 1 and 2.
- New patch 3, a cleanup suggested by Damien.

Niklas Cassel (3):
  null_blk: fix opening closed zones at the active zone limit
  null_blk: don't finish zones to set them read-only or offline
  null_blk: clean up setting zones read-only or offline

 drivers/block/null_blk/zoned.c | 63 +++++++++++++++++++++++++---------
 1 file changed, 46 insertions(+), 17 deletions(-)


base-commit: f47d223627f80cb7a1eb14c585fe6cb35de5e984
-- 
2.56.0

