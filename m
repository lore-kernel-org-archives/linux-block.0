Received: from 004.mia.mailroute.net (004.mia.mailroute.net [199.89.3.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A01F32E610E
	for <linux-block@vger.kernel.org>; Mon, 11 Aug 2025 16:01:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.3.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754928074; cv=none; b=sgJ0R5ZX5Y1zVD1stL9wdPzsbGJNLwcheHN6Xb2KRY6ohDisJlTWgD2/zusj1+mtXHRV/Gr8H1Zv4yPpnkVtKw+HjWuGdXTba9RS3rXCME10qrfOqeJv8O+ZCtDtZ79muBUa2uGFYi6L6Rvrc6Vy8v2x3RaLC38Cy7pA5vnlwFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754928074; c=relaxed/simple;
	bh=SDcxsc7hwFySjBr1w+u0k9w5DLRULJo40KLXb3tSRZs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bD+ha95VUkhVWCh7xFyXGmywT3duIko5ug8othMVU5e2L9n76lSJpwjiaHIGVx2YeGWf63rLvW/u+1CR4X463j0nse/qbK7hmxQx6AqcTuTb4SRLTCtKQPgR+ZaJI/ESqbH1FUNj++8lDz4ijm1wN0D50uZ3QzvetmUH1/uAZC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=EfQ81wHV; arc=none smtp.client-ip=199.89.3.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="EfQ81wHV"
Received: from localhost (localhost [127.0.0.1])
	by 004.mia.mailroute.net (Postfix) with ESMTP id 4c0zm92Y4rzm0ytH;
	Mon, 11 Aug 2025 15:57:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:x-mailer:message-id:date
	:date:subject:subject:from:from:received:received; s=mr01; t=
	1754927832; x=1757519833; bh=i2pWneOcu2rAs1metYAsXDxHIhFMuCRZ0u0
	2ELmB0t0=; b=EfQ81wHVp4RumfGni8mfvv1hFkQSqfCIgqBI6+h5vZwE1i+TdEG
	EI5J2q2yJ4wNxq/H9f9aR5qFGEb96u00Y84BebWpt/T1KdPM900vKNFakjDc8UBR
	L0o0roPXehBpgyOHPr23QYIkrTsOnVWNYA0oPiHyJ+s4k1eCF2XhdgP6qcmqCVS8
	JPAj0dF8wgJd+ZL8L6kluO56yq/vZgqhls9tTnKVB5LEn48c7WDb3Q89JvxokgdK
	q6ov+4ifA2ySYZed8BzEY3VlFO+4oA/cfS7sQwhfPA4oPHDqobKbik1B5W72Z4sN
	g1f3wZtBtA9Db/XOKtXhl8/+0eIRthOmuSQ==
X-Virus-Scanned: by MailRoute
Received: from 004.mia.mailroute.net ([127.0.0.1])
 by localhost (004.mia [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id Nq0Gn8t6u0J9; Mon, 11 Aug 2025 15:57:12 +0000 (UTC)
Received: from bvanassche.mtv.corp.google.com (unknown [104.135.204.82])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 004.mia.mailroute.net (Postfix) with ESMTPSA id 4c0zm55PSXzm0yVL;
	Mon, 11 Aug 2025 15:57:07 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH v2 0/5] Remove several superfluous sector casts
Date: Mon, 11 Aug 2025 08:56:47 -0700
Message-ID: <20250811155702.401150-1-bvanassche@acm.org>
X-Mailer: git-send-email 2.50.1.703.g449372360f-goog
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Jens,

This patch series fixes one bcache bug and removes superfluous casts of s=
ector
numbers / offsets. Please consider this patch series for the next merge w=
indow.

Thanks,

Bart.

Changes compared to v1:
 - Rebased on top of v6.17-rc1.
 - Added Acked-by and Reviewed-by tags.

Bart Van Assche (5):
  block, bfq: Remove a superfluous cast
  block, genhd: Remove disk_stats.sectors casts
  bcache, tracing: Do not truncate orig_sector
  bcache, tracing: Remove superfluous casts
  block, tracing: Remove superfluous casts

 block/bfq-iosched.c           |  3 +--
 block/genhd.c                 | 12 ++++++------
 include/trace/events/bcache.h | 15 +++++++--------
 include/trace/events/block.h  | 34 +++++++++++++---------------------
 4 files changed, 27 insertions(+), 37 deletions(-)

