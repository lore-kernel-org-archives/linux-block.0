Received: from 004.mia.mailroute.net (004.mia.mailroute.net [199.89.3.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25E2A1AF0AF
	for <linux-block@vger.kernel.org>; Fri, 11 Jul 2025 17:19:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.3.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752254375; cv=none; b=sXmI2S6Pbmbw6D8GVtQYYfjMZmUnsD8cbXWBJbHu5/cP99yMu0gSFueNUslHdGx2XLUa+nD9WArG0F5Jg2g7Y3ev+780LIU8PaPRK8SeBMhalqm98J7zuNkQx/9mEWeyBNYPTcXQFrlptsCr95z0frZQV9w4UoNZgwZEkyt58Jk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752254375; c=relaxed/simple;
	bh=aNocptVgkI3dD+l5fPTLAVLJ8CzktZZOXccgC+UZGcc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=E/wVM0LkWPSKTUMFNzCBYcgWzaoGi9LwXSbp6iHEdRLKkR5ATeuhP0ANHss0LaxfudGjUDOXwoCrBvmR0BiiyFNtcjGXrU4ouK2xYJQ5KM64sbcuL+E0iFvyx1B8hMLBQsNP8pWubo3QWAn/xMDK4goenTP+QJ3uDRvnQcyUpRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=STPzFlwB; arc=none smtp.client-ip=199.89.3.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="STPzFlwB"
Received: from localhost (localhost [127.0.0.1])
	by 004.mia.mailroute.net (Postfix) with ESMTP id 4bdz3L6F27zm174l;
	Fri, 11 Jul 2025 17:19:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:x-mailer:message-id:date
	:date:subject:subject:from:from:received:received; s=mr01; t=
	1752254365; x=1754846366; bh=tLZxyr4pntNhT0l5jiUk/xSI3mpKUwhhjPO
	x+PRBJyE=; b=STPzFlwBk3O0PofFx6iltTXTDnzbWTUSShY3XHuZnDDPGSEwcjq
	9vB0yM+dR4G2+9puu2H3GYDCVcAKYO8pXcht7Zpo5EE10PnqE1eTGy4OeRpJZVaj
	iE40JzBxApolr0nh7G2VnLOFxYSPe1lXWVQKTMQzykEni+mAEH9qYpHPRRKDjJf+
	Ywil+Pql9raaV572kEVHDKEFfB3kVhFBa7YJ9QENJiQMtL4MR5SMxW47fM8BGt/u
	jyKCCNduXzVMXkHYF8g/XQS+MzjDzaiSGeGr+1BvVyFaP4C/6EoAGs9aFd85D+LK
	hEYaP/QHR344hhBbSTkopnlOGIXEsjIBiYw==
X-Virus-Scanned: by MailRoute
Received: from 004.mia.mailroute.net ([127.0.0.1])
 by localhost (004.mia [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id 0YR7UrwaE8km; Fri, 11 Jul 2025 17:19:25 +0000 (UTC)
Received: from bvanassche.mtv.corp.google.com (unknown [104.135.204.82])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 004.mia.mailroute.net (Postfix) with ESMTPSA id 4bdz3G5Ljgzm0yt5;
	Fri, 11 Jul 2025 17:19:21 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Eric Biggers <ebiggers@kernel.org>,
	Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH v2 0/2] Fix bio splitting in the crypto fallback code
Date: Fri, 11 Jul 2025 10:18:50 -0700
Message-ID: <20250711171853.68596-1-bvanassche@acm.org>
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

Changes compared to v1:
 - Dropped support for bio-based drivers that do not call bio_split_to_li=
mits().
 - Removed the BLK_FEAT_CALLS_BIO_SPLIT_TO_LIMITS and BIO_HAS_BEEN_SPLIT =
flags.

Bart Van Assche (2):
  block: Split blk_crypto_fallback_split_bio_if_needed()
  block: Rework splitting of encrypted bios

 block/blk-core.c            |  3 ---
 block/blk-crypto-fallback.c | 36 ++++++++++++++----------------------
 block/blk-crypto-internal.h |  7 +++++++
 block/blk-merge.c           | 12 ++++++++++--
 4 files changed, 31 insertions(+), 27 deletions(-)

