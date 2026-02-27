Received: from mail.itpri.com (mx1.itpri.com [185.125.111.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FDD042B74D
	for <linux-block@vger.kernel.org>; Fri, 27 Feb 2026 14:58:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.111.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772204294; cv=none; b=qThZfKuaalRRv5fdZJRzwpEvF/12O5gYZHFX4Bpbch86Je7IRcIylrNDxoOtbnRTPuWGcrrm6H99LZiqqTcZZ0i9Qvn4WJ/owDepmP/uzidkD1wrrW1dMVet266s4udmqEfPz0UdVgqn4M/FdotSOU42ZsL0ge5PMMoCBV4hEps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772204294; c=relaxed/simple;
	bh=cujSyAuHK33icajbIrIekqH/Gp4y/UPzwGJ10NXpuAk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CcdUlzgLOlpo3kSQuKV1Np7Da8fNlkXCHLUXBvsw6mCLZVGVqI1F/uUlfDikskn8Meu1qV37+GMGPwbM50MqbtBtvVoiNpP7nLiLpaI13OOlp+Y99WQssxQyf0G5mlxWmVSFocLv/zayPBnIW93ToZdtotwG564uOPoIXFrCT5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zazolabs.com; spf=pass smtp.mailfrom=zazolabs.com; dkim=pass (4096-bit key) header.d=zazolabs.com header.i=@zazolabs.com header.b=aKXdhqAa; arc=none smtp.client-ip=185.125.111.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zazolabs.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zazolabs.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=zazolabs.com header.i=@zazolabs.com header.b="aKXdhqAa"
X-Virus-Scanned: Yes
From: Alexander Atanasov <alex@zazolabs.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=zazolabs.com; s=mail;
	t=1772204282; bh=cujSyAuHK33icajbIrIekqH/Gp4y/UPzwGJ10NXpuAk=;
	h=From:To:Cc:Subject;
	b=aKXdhqAaL7F+KQIHVyIG906tF7CdMTV8KDs61Ph3RR6V8VNJiRIa5v/JmSRbo0jPQ
	 +k9gSFTdBLf4hDihiuYkDdiTkOfBzUqBAXZDQGlJg7eqhi8Rq5ZHDr4++j8MvL5aPy
	 8cV0/mdXsN/Qf0AYjXbamjU75qbpubzT2ZUxLsOrsuVq0y8lF51SXvESol2HoLNgzA
	 xuzpOvQaP0PILrjpv8F2lmNJ9lbtYVdoJ8EVNDzFaTJK1Qz4/A/C6V2kkRKYeBDxhZ
	 bi3bxWJsJ6eFdSKJd9AZyOSkDUAN/PU4dZBnJ0i7XzMQIdT10SaXpPQ346nfwsQAUj
	 T2EEcv1K4jLuluUsGLgwMGOhLDfRPXxkiT/PGZJDDMqMSg0IBWGfUUjzHUzCZ02GyY
	 wBkTw3NB0lB1p+SCDrzQTx5vjCqnEtE3YxcADVjaGRLUrBeSqlM7K4D37a9LeFU2Hl
	 swW6HnMi6itCGIZWiCQMnVBV31tFkJ7RPd7bG/Q/nkxz0L7mvo0AmDVzAIfJwRJ3Zz
	 1GisAlpX0Fe0hEwwNNDBMhaqvs5Uols5AP+/KjEaPpKT6VJjCEIiiMdEPMWf8Pc3mJ
	 AHqAd4cOFm9yowhNPoLz9izhMQRpGmgdmmSg9FrxkTuCzNXXJc/AxAb4511OwkzS31
	 iBYPzpej7Y+R1s+R/EYZY5/4=
To: Ming Lei <ming.lei@redhat.com>,
	Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Alexander Atanasov <alex@zazolabs.com>
Subject: [PATCH v2 0/4] ublk: rework partition handling
Date: Fri, 27 Feb 2026 14:57:52 +0000
Message-ID: <20260227145756.3877069-1-alex@zazolabs.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Rework how partitions are handled for ublk devices.

Disable partitions on unprivileged devices completely -
GD_SUPPRESS_PART_SCAN is used but partitions still can
be created by userspace scan.
Use GENHD_FL_NO_PART to fully disable partitions on device.

For privileged device partitions are enabled by default -
they can be disabled by new UBLK_F_NO_PARTITIONS flag.
Auto partition scan can be disabled by UBLK_F_NO_AUTO_PART_SCAN.

Update related tests and documentation.

-v1->v2:
  - remove code duplication and extra flag settings
  - switch from out-in to out-out to preserve backwards compatibility

Alexander Atanasov (4):
  ublk: cleanup partition flags handling and introduce UBLK_F_NO_PARTITONS
  selftests: ublk: rework partitions tests for new flags
  ublk: document partition flags, kublk and update external links
  selftests: ublk: cleanup kublk.h

 Documentation/block/ublk.rst                  | 22 +++++++++++++---
 drivers/block/ublk_drv.c                      | 25 +++++++++----------
 include/uapi/linux/ublk_cmd.h                 |  7 ++++--
 tools/testing/selftests/ublk/kublk.c          | 18 ++++++++-----
 tools/testing/selftests/ublk/kublk.h          |  1 -
 .../selftests/ublk/test_integrity_01.sh       |  9 ++++---
 tools/testing/selftests/ublk/test_part_01.sh  | 14 +++++------
 tools/testing/selftests/ublk/test_part_02.sh  |  6 +++--
 8 files changed, 64 insertions(+), 38 deletions(-)


base-commit: 72f4d6fca699a1e35b39c5e5dacac2926d254135
-- 
2.43.0

