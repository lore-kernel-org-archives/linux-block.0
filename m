Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34A6913C8F9
	for <linux-block@vger.kernel.org>; Fri,  5 Jul 2024 12:57:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720184225; cv=none; b=gzuwNgqf/wx1NXVqjfycxhcZCNdGgO9+AVS4XrLMHfnQT/UZcOjoDlfu0LEtvVv0NFMmgx5+icAqT3u0MuSWyME0sP5Z3IKebNMwpDrS7fuiEDFkuZtUzVgHfbA+7VyArJ8dUc3FOPYU7CXAy12+EDzixcWCMoDO1vE9sMBs7ps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720184225; c=relaxed/simple;
	bh=m/x8CztLJaQqs/vs+l6q6ZCG1kgEg2uuq7wIDlz19+U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NsB+wzpXNjDeXGS7JjxWdP0SPtBrw2UGDxL26uwQosmK07EPv5fxDmnKWEODoetziaNClbcz8OKAvxiR1f9yPRBInuvZKxazbc3p5lzn1K/DvzhmTik3R9sEvXVeCxv/7ZchYzn1qsX/1HvvSPPfj5SsvzRfbGfxRNUX5QV5/0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=qhBZWBYy; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="qhBZWBYy"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=R1ivfMSkxrOq7I8GPCaMDyrTRPaueT87qdBvrqMI1hM=; b=qhBZWBYyS8iFjyajeFS64P2HR5
	U5mSp+XD5qx96bSjTgWj4aJk8Pd6shvXcUmtCN28UHP3wEkOzVrkvQWm6Y7kQ/Nuh6mXtunvxZX55
	Rk8oG9OaBu82FfK5kEE2yEe0MCEjdAozyRwWYiF2KeGbF9+iuVMvFPlRDiHSuY1pRgUmn/UykakYm
	hahj+vGtT72vKVaqa0Fg877ynbUHKXGz8g2JA35UFKNWz8O96B6YLNVm8B9Fc8ePvuUVeNn3/G1R+
	QWdb3ExR2KiljYTo9Lkns7KRtOIrPJwKarFP71X2BGm51mG5FJegY1wwf0MUORV/S4FlYkcJEhweP
	Tzr80Seg==;
Received: from 2a02-8389-2341-5b80-e919-81a4-5d6c-0d5c.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:e919:81a4:5d6c:d5c] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sPiUp-0000000FyYc-0gid;
	Fri, 05 Jul 2024 12:57:03 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: Ming Lei <ming.lei@redhat.com>,
	linux-block@vger.kernel.org
Subject: extend the bio alignment check to bio based drivers
Date: Fri,  5 Jul 2024 14:56:49 +0200
Message-ID: <20240705125700.2174367-1-hch@lst.de>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Hi Jens,

this series extends the bio alignment check in the block layer to cover
bio based drivers in addition to the blk-mq based path, and then drops
the equivalent debug checks in brd.

Diffstat:
 block/blk-core.c    |    7 +++++--
 block/blk-mq.c      |   11 -----------
 block/blk.h         |   11 +++++++++++
 drivers/block/brd.c |    4 ----
 4 files changed, 16 insertions(+), 17 deletions(-)
