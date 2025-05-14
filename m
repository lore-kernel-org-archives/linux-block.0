Received: from 003.mia.mailroute.net (003.mia.mailroute.net [199.89.3.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49B3D18D620
	for <linux-block@vger.kernel.org>; Wed, 14 May 2025 20:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.3.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747254617; cv=none; b=GSFmhhF95v0CwUzJbsLokvu2Q8Fubbd8HP+6HA/+YhLbhiif1eyVhwIO3Qc6Ofg3omLGYjBSSH1BGbhglfku1hLNtXOQ0oUBBzZMBnceuCG2HIZMD1znZEQA2xvFvP46YdZi6c2MOedqFgQDRgO8OhkVSCgyo3BZwfqL2XlrCp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747254617; c=relaxed/simple;
	bh=d9dHkNjbLRozoNMO+tYTEsPOqvLTF1g7nsMwA0CZX5g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HpBi+5euxD+XMQGadli6TdZez/w+UKzPDmrx5NyEYUHtt60AJ/nUTENnlyPLUnsJdMeGbJ394aeQDpSgy2r+MK1KawQu9gXoB0jXT+z+THvAqBrRutCjUAz6fB8L/Qdo2CtEH0aA8jbFIrIfGLCzowiCnRohhk3xh4sdMPap2wc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=b69d6DLZ; arc=none smtp.client-ip=199.89.3.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="b69d6DLZ"
Received: from localhost (localhost [127.0.0.1])
	by 003.mia.mailroute.net (Postfix) with ESMTP id 4ZyQ275Pq5zlgqyp;
	Wed, 14 May 2025 20:30:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:x-mailer:message-id:date
	:date:subject:subject:from:from:received:received; s=mr01; t=
	1747254606; x=1749846607; bh=eI+db/FM2c5uE3FcH8smSKTX8SxaJcJVCeB
	nrbUf79A=; b=b69d6DLZKAwhG9QP4YyPR+fwJKfX496WVXormcgBOAvm5w3OsQJ
	cea1T103R7JJSk/C/cLP7EZJB32rLENi3MMb5o0SC62jYjhv8p52qH2D5HAtiFm+
	fepWHt8YYqjXGSqTsG/oHrhI43c3ohxobOnXgPQgmOhUqkePCCKENjuSwYVP1bCc
	NSiEXCJ/6IKu4sSm6aVDo0Xke88SbNiC3Y0Ia2n+xFN1+FPk/LFPvDtdJ62vnuFI
	l42dG124WfJAlpTS1fOFMVHaFCIkmPgvECLWmcNtd0pxIhQLbErFvOovQe25noet
	iZ+GbB4hc3G5bGogMJxmGEHTbkGE/ZUz3dg==
X-Virus-Scanned: by MailRoute
Received: from 003.mia.mailroute.net ([127.0.0.1])
 by localhost (003.mia [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id 9tAx0ZBucLu6; Wed, 14 May 2025 20:30:06 +0000 (UTC)
Received: from bvanassche.mtv.corp.google.com (unknown [104.135.204.82])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 003.mia.mailroute.net (Postfix) with ESMTPSA id 4ZyQ223ZT2zlgqW1;
	Wed, 14 May 2025 20:30:01 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH 0/2] Two bug fixes for zoned block devices
Date: Wed, 14 May 2025 13:29:35 -0700
Message-ID: <20250514202937.2058598-1-bvanassche@acm.org>
X-Mailer: git-send-email 2.49.0.1045.g170613ef41-goog
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Jens,

The two patches in this series fix the issues that I ran into by stacking=
 a
dm driver on top of a zoned storage device. Please consider these two bug
fixes for the next merge window.

Thank you,

Bart.

Bart Van Assche (2):
  block: Make __submit_bio_noacct() preserve the bio submission order
  block: Fix a deadlock related freezing zoned storage devices

 block/blk-core.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

