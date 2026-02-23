Received: from mail.itpri.com (mx1.itpri.com [185.125.111.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89E511DE3DC
	for <linux-block@vger.kernel.org>; Mon, 23 Feb 2026 12:15:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.111.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771848941; cv=none; b=l2m2xTU7cmqaqDO4n9Ej6tYhuWIwCr0yOyBOOQ2fO7M/3gvsrik61FDNxemlcqheKmqAYdad/8O4nHfI+8GxZ7VbRg3cANddNtQ7NeKdg9Yi+8Fca7XEaXTdhRW/8BJ24DRk527XlpE2ixv0ID+PgwxkU4E5bA5178l8f+0Z780=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771848941; c=relaxed/simple;
	bh=4OcuD5ZcDKdRD+Bi9bCa8Ujvaj5gFzwiyjB4ChXmEtw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Mma8N6+xAy3gySH0lPeT8AszjmLUGUOah3ongXD8IaF7MIrRu+Z51d0fWpxpoZp0tf1MlJktZN7xLJ5w3w460i91sNRkxh3Kj178KFT2LKSgWL8Pslyv0GpqbF6ZwofjjRPcCNCobQeNdeoaKhR/SixweanotohtT36vu4xldpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zazolabs.com; spf=pass smtp.mailfrom=zazolabs.com; dkim=pass (4096-bit key) header.d=zazolabs.com header.i=@zazolabs.com header.b=IG8LDSfj; arc=none smtp.client-ip=185.125.111.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zazolabs.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zazolabs.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=zazolabs.com header.i=@zazolabs.com header.b="IG8LDSfj"
X-Virus-Scanned: Yes
From: Alexander Atanasov <alex@zazolabs.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=zazolabs.com; s=mail;
	t=1771848929; bh=4OcuD5ZcDKdRD+Bi9bCa8Ujvaj5gFzwiyjB4ChXmEtw=;
	h=From:To:Cc:Subject;
	b=IG8LDSfjitrqEbr9AbJnLqcMFfwhgW5P0nMpoQOtSFBJyHtb82mcSdYQDylAR5eL5
	 b932Ul1VjEF0fNFqJd+PsYjZq1kx70EDcs1ZXls/uV+hs2Yxpk+gdlVz9PbO1p5Dk/
	 eE+Zl0PcKnyKeSMrE6NgOHbyxb51yAvzgdkUMR4xP5TQ0TMJKsfXD8QW6Ju2pZwGNH
	 J17PoUoSFxZTVtgS04vtAisWHLTgOFaLmtmRfz8WfI9vV/ntbM+rQ5TvhCJfHLmftO
	 hikc6bxpLyDDKE92+1xh3rYmJWVQ7u1zqUdzDSpWbYZsgmArF111A5nCXVfIRU/LXJ
	 hYlqnNIdO86IKk+2WKN+0xVM8bZ0MzQ0uSAZkn4Elxa6lgtnePdhhVSwPfx7geLp9Y
	 bgAzlzmtcSVX5Yvyukiu1os85t45LYe0bkzkkaUsym+iVPrzhQIY5DrnSSMjXX2izT
	 nAXaTrSIwtt8T5x6dMt/gSC8YubpTgpqx+1YvGm4MZ/16AC1l74rTQo6kv4TkQA4cA
	 SQVHwHD3zZrvY2I8ru2Xz3e3UXVrJi90FlNypjZl8FGj4699xP1Rp56VdSMt43Fxyf
	 uxv/SWZsZ+xY6R6vfAcMT3ZnuiDPTlyrAwWFJPDZHkaGFoQM4cU9YRqPLTMzGOB/+6
	 vKsbYz+JYvJP4W2GM58wXsek=
To: Ming Lei <ming.lei@redhat.com>,
	Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Alexander Atanasov <alex@zazolabs.com>
Subject: [PATCH 0/4] ublk: rework partition handling
Date: Mon, 23 Feb 2026 12:15:10 +0000
Message-ID: <20260223121515.3296983-1-alex@zazolabs.com>
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
Use GENHD_FL_NO_PART to truly disable partitions on device.

For privileged device partitions are optional - disabled
by default.
They can be enabled with UBLK_F_PARTITIONS flag.
Auto partition scan is performed only when explicitly requested
by user.

Update related tests and documentation.

Alexander Atanasov (4):
  ublk: cleanup flag handling and fix UBLK_F_NO_AUTO_PART_SCAN
  selftests: ublk: rework partitions tests for new flags
  ublk: document partition flags, kublk and update external links
  selftests: ublk: cleanup kublk.h

 Documentation/block/ublk.rst                  | 22 ++++++++++--
 drivers/block/ublk_drv.c                      | 34 +++++++++++--------
 include/uapi/linux/ublk_cmd.h                 |  7 ++--
 tools/testing/selftests/ublk/kublk.c          | 18 ++++++----
 tools/testing/selftests/ublk/kublk.h          |  1 -
 .../selftests/ublk/test_integrity_01.sh       |  9 ++---
 tools/testing/selftests/ublk/test_part_01.sh  | 14 ++++----
 tools/testing/selftests/ublk/test_part_02.sh  |  6 ++--
 8 files changed, 71 insertions(+), 40 deletions(-)


base-commit: 72f4d6fca699a1e35b39c5e5dacac2926d254135
-- 
2.43.0

