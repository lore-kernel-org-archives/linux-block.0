Received: from 004.mia.mailroute.net (004.mia.mailroute.net [199.89.3.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2458486337
	for <linux-block@vger.kernel.org>; Tue, 15 Jul 2025 20:11:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.3.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752610287; cv=none; b=ZkCmii654+QdEnnPXK/x5HKHXJjcURVter+E9RbIGrgsWOyEGsfUXd5DPt0ntzSWi/8L4aZfl1Mlr58yKT/R/UdXPQPI95Hhsaszjxpg0bQuxHhlGGTVg1lkvDjrOSBkERlXtDUKHPdiE0jCqsMwjgHeqRo7jAK4tEn0O+IHf/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752610287; c=relaxed/simple;
	bh=W7yaa9O3iOlD4ShP4uPrxAZ211SaXWBo1KsIh/t/qEc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TFDW5SXTX0+sU5gqb1WfbpUv0ylew5ArBQb2DqF0OoeGS3WOc9vxzgIXB0TOsRrH/FxOkYy81L6F3E8ghyowpM6Sz7dZeQxCzLLVRBMnLpUy9sFaxMdQR8bfHAGsLqcC5THWL/ZGgkowWSdCjjlzpFFPgPZJN6700HGcP9t5At4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=DKP5NxiO; arc=none smtp.client-ip=199.89.3.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="DKP5NxiO"
Received: from localhost (localhost [127.0.0.1])
	by 004.mia.mailroute.net (Postfix) with ESMTP id 4bhVgx14p7zm174M;
	Tue, 15 Jul 2025 20:11:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:x-mailer:message-id:date
	:date:subject:subject:from:from:received:received; s=mr01; t=
	1752610283; x=1755202284; bh=xHVmBgqq72VtV3nUuj4640JuV2mc8sIJEMS
	l2XLEDA4=; b=DKP5NxiOSDM4CkzUJHJjgDZJlA0EBJNFjwNpxYtqH/QnOYwugr2
	u+73zIrKvoGtbChVEh/ZOWigOxyA9fvhiKsd4xrxfAoAMrrls2J5dZJ0Bdi+Pjsk
	RxB+GzV54KgVhdFYdh6jmmn0qMvxvY5BVHG25zfMIKNDWnSLlYm8uRKQGnR6BCpV
	obfMMD+X/l/3cyHrMS13BeKMuQKnSvajl18QyotG/iLcwpcbRqe6oEuRQngcEbgk
	hWpRre1jUL1MTMI+4XMiBEqJwJbfK3bdI7IGxbYJtOUC0yQbjUiNIhMrv/Dhro1M
	I5UY36aZHJcpvFeV6VngN7aX3B621fxAJNQ==
X-Virus-Scanned: by MailRoute
Received: from 004.mia.mailroute.net ([127.0.0.1])
 by localhost (004.mia [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id 8Ce2qYY4WnyV; Tue, 15 Jul 2025 20:11:23 +0000 (UTC)
Received: from bvanassche.mtv.corp.google.com (unknown [104.135.204.82])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 004.mia.mailroute.net (Postfix) with ESMTPSA id 4bhVgq68Whzm0xkf;
	Tue, 15 Jul 2025 20:11:19 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Eric Biggers <ebiggers@kernel.org>,
	Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH v3 0/7] Fix bio splitting by the crypto fallback code
Date: Tue, 15 Jul 2025 13:10:48 -0700
Message-ID: <20250715201057.1176740-1-bvanassche@acm.org>
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Jens,

When using the crypto fallback code, large bios are split twice. A first
time by bio_split_to_limits() and a second time by the crypto fallback
code. This causes bios not to be submitted in LBA error and hence trigger=
s
write errors for zoned block devices. This patch series fixes this by
splitting bios once. Please consider this patch series for the next merge
window.

Thanks,

Bart.

Changes compared to v2:
 - Added a patch that optimizes blk_crypto_max_io_size().
 - Added three patches that change calling conventions in the crypto fall=
back
   code.
 - Added a patch to remove crypto_bio_split.
 - Moved the blk_crypto_max_io_size() call into get_max_io_size().

Changes compared to v1:
 - Dropped support for bio-based drivers that do not call bio_split_to_li=
mits().
 - Removed the BLK_FEAT_CALLS_BIO_SPLIT_TO_LIMITS and BIO_HAS_BEEN_SPLIT =
flags.

Bart Van Assche (7):
  block: Improve blk_crypto_fallback_split_bio_if_needed()
  block: Split blk_crypto_fallback_split_bio_if_needed()
  block: Modify the blk_crypto_bio_prep() calling convention
  block: Modify the blk_crypto_fallback_bio_prep() calling convention
  block: Change the blk_crypto_fallback_encrypt_bio() calling convention
  block: Rework splitting of encrypted bios
  block, crypto: Remove crypto_bio_split

 block/blk-core.c            |  3 --
 block/blk-crypto-fallback.c | 85 ++++++++++++++-----------------------
 block/blk-crypto-internal.h | 25 +++++++----
 block/blk-crypto.c          | 26 ++++++------
 block/blk-merge.c           |  9 +++-
 5 files changed, 68 insertions(+), 80 deletions(-)

