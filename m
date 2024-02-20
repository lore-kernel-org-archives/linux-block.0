Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 575A75FDCC
	for <linux-block@vger.kernel.org>; Tue, 20 Feb 2024 09:32:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708421564; cv=none; b=BClfBLSrHsKD7hbsGvXOFgi4qb1dMo4JExqArnM5vAmoOyDvPLBYsmUifh51IiqtwtbsjU+MMSQ7DSGzOdKicjljC970+Qn41Brs4xfy5f3AyMRjdUyzBndKZfKgS2vM6ZJgXpYfSAUVfgYOi1nFY2L8qEfl9PkgBqgycCFID5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708421564; c=relaxed/simple;
	bh=5/fugB+2ktXmdjWl+Fnfar34xtOWb5BCQ2uRHOrM5NM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=oJYkHRagh6a8295fE4D2DmLB8FxrshPMTI/U0b1qIquEUEzvCcc+QpTV7B2aI5ohRhX4zvtgunFXScajsCFMoooluPS8fK6CDpwcXR5DFRdyJBs8b3GYrzkBJg/0C8ebgAiyPKzNecVkanLyiwTkm+x5dbgLTEY2iMTAV11GeiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=OVsG+Wha; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="OVsG+Wha"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=uNrrmHEE2hz/3VsR04VQ9NhxNsYBLR5vdLBxS3jEUiI=; b=OVsG+WhawMSGEiRaxVmllTF3R2
	QkavwBxYy/PwOIbbxO0VGcegBFnEZgl1S3OReKt5j5ddrj1stVSLzWi/4sH/xL60x81hhM88JBJZB
	x3oom36/BSNxJh8XStc6PxP7QVH0tNifam29M28zW29iYk/0vmG9vwYWSNvPwxzjeWlV2LRxdyP8A
	4hRVRuiyHQbD5GO/IYizSu0r/hK/uvMqDD5N8hoidCJK5xbj/+ODmwmWeR5cNketMUGoakxp/leNF
	J6ARoCY3nBcshGeO1oOpYPRtNK5m+wImBMju7gED34kC3YCX6pNOD+AURFSDWu2WguhDbAYM2e1H2
	EsWUaw+w==;
Received: from 2a02-8389-2341-5b80-39d3-4735-9a3c-88d8.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:39d3:4735:9a3c:88d8] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rcMUT-0000000E0is-1oZt;
	Tue, 20 Feb 2024 09:32:41 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org
Subject: drop bio mode from null_blk and convert it to atomic queue limits v4
Date: Tue, 20 Feb 2024 10:32:43 +0100
Message-Id: <20240220093248.3290292-1-hch@lst.de>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Hi Jens,

sorry for spamming you twice in a day with this series, but the buildbot
decided to send me a delayed warning just after posting the previous
series, so I've fixed it up and resent.

this series drops the obsolete bio mode from the null_blk driver and
then converts the driver to pass the queue limits to blk_mq_alloc_disk.

Changes since v3:
 - fix the !BLK_DEV_ZONE compilation

Changes since v2:
 - rebase on top of the blk_alloc_disk prototype change

Changes since v1:
 - add an incremental from Damien to make sure the zoned tunable are
   properly taken into account

Diffstat:
 main.c     |  503 +++++++++++++++----------------------------------------------
 null_blk.h |   19 --
 trace.h    |    5 
 zoned.c    |   25 +--
 4 files changed, 139 insertions(+), 413 deletions(-)
