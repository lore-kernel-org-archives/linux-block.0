Received: from 009.lax.mailroute.net (009.lax.mailroute.net [199.89.1.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9B541CDA2F
	for <linux-block@vger.kernel.org>; Mon, 16 Dec 2024 20:19:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734380373; cv=none; b=g1Xpp3l71PhfDyVOU6S8460b863aVWBZDkVTUti3PhIj3LqmYCaTRTBO23V1DmxArKqofKPkHB0G8YNrbvbqOcWmh2FSczDuQa3d91wzexCQABNKBvfzxoi4V3AjNMu6uAryK1ig4FQckKkm+J7cNFVOgS4x3ruAnQNfYJhEnS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734380373; c=relaxed/simple;
	bh=bC49ZfSuj/kXJ7rpHD//YHAErooSqHW8GyK85AbpmCE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GzoLZ1t1f/6yqkJ5M3hlwWit2saHU085esCZ0U4sFjcXyTAnjChwvibWxNwB2lyxBNpZLJy0P+Sswdw/CSEj4Ls4uty4ZpmM5NiOBQKUbzaTV4kRiQwI12MMxsxjHlWGuARqgUKavmIwm45+LiOkJLnxGq2wIGrIDKhJWSCQLuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=nXO4Q1z2; arc=none smtp.client-ip=199.89.1.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="nXO4Q1z2"
Received: from localhost (localhost [127.0.0.1])
	by 009.lax.mailroute.net (Postfix) with ESMTP id 4YBrrg2rzKzlff09;
	Mon, 16 Dec 2024 20:19:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:x-mailer:message-id:date
	:date:subject:subject:from:from:received:received; s=mr01; t=
	1734380367; x=1736972368; bh=RuOwozuAcgKMcp5sgcvRu66+2Q3a3JMGNXK
	q0m5bWos=; b=nXO4Q1z2Ncp5Zef8MzcqxJZhek9COsKFnWxWgSaVSHWnYcJhBj+
	swPWSS0Eq3bnUzBM6rJtskYyvX+MrrdY6R4SuYztNmv3J3UOEAoM+dhC6zWVAsQ7
	ThlmwvkRI3rdHoA5MGn4J/JgeInDIa4Ul25wFpWegS+M4111RbLGiHHvy2nLiN8V
	N/1SNYphuJvdA67wzvPOHhcirsJfHaF7QRAdhGQTlWN74b8TLBSvu1D6DFwNG5UK
	zREgO9zO/roAzVAVuY0tZIE1CDiH/VO502W1suYjuj+gb3ZLMVpUKGWPXNqSgcKe
	H0W03flWt2eOF8No0EcIEBiErmOKNkqXjZg==
X-Virus-Scanned: by MailRoute
Received: from 009.lax.mailroute.net ([127.0.0.1])
 by localhost (009.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id cXOgZWN1Vq_L; Mon, 16 Dec 2024 20:19:27 +0000 (UTC)
Received: from bvanassche.mtv.corp.google.com (unknown [104.135.204.82])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 009.lax.mailroute.net (Postfix) with ESMTPSA id 4YBrrG1Xt9zlff0d;
	Mon, 16 Dec 2024 20:19:09 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Damien Le Moal <dlemoal@kernel.org>,
	Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH 0/2] Move blk_mq_submit_bio() error handling
Date: Mon, 16 Dec 2024 12:18:59 -0800
Message-ID: <20241216201901.2670237-1-bvanassche@acm.org>
X-Mailer: git-send-email 2.47.1.613.gc27f4b7a9f-goog
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Jens,

Some of the blk_mq_submit_bio() error handling occurs in that function it=
self
while the remaining error handling code occurs in functions called by
blk_mq_submit_bio(). This patch series makes blk_mq_submit_bio() easier t=
o
understand by moving all error handling code into blk_mq_submit_bio(). No
functionality has been changed.

Please consider this patch series for the next merge window.

Thanks,

Bart.

Bart Van Assche (2):
  block: Optimize blk_mq_submit_bio() for the cache hit scenario
  blk-mq: Move more error handling into blk_mq_submit_bio()

 block/blk-mq.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

