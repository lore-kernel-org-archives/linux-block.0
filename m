Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62AD1189F58
	for <linux-block@vger.kernel.org>; Wed,  9 Oct 2024 11:38:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728473919; cv=none; b=n75lrrc7xR0y6quDSDY0n3fFcX/L4ReJnHKufsg3TfdmjzXREPokda9kPVKkkHwTyjh0vLRS61v11ncgUiI15xuzyPGzdEI2KmxtmstXvIthzbUAuq2xBMAZqVKbc2sK8n57XjW7s1MTUtRvQnH2/PbsqQClz1CTBRo3cNdpwhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728473919; c=relaxed/simple;
	bh=umD9mqgouXs/hXQI1KlzEhkjERQrZPjiiYpEyR9oO3k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LQ0el3I5jwNhrUQKwbTWbj9P2TychsqPoEfdKiGta2T1fU0U6k1SjvfH4qO42muSzya0hiehV6KEGFvJ9IW9V2fbBsGRbLqSTZyGapITeSbBIw+BuvN4Gqldntpo2tynU0Mi8Wa0tbCZCCx/OdwWVjqIcTHy1yS7LWvoEP5SGb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=eQ9ElMhR; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="eQ9ElMhR"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=Gc7uYe+TfwvPDBGCS9EY9qFgWtlG0/netnbxSqzJbuI=; b=eQ9ElMhR7hqNqwS/Mw4qCX5Qov
	KeOFoEg3apAqzdaXUFI2mV8T45BSUWBP1x8fYDxX/3SNXhvjN0qF2IgLFDhfQNCeZsSxK08CS73gV
	tKibMTXI31dYlvdlz4Slf1YFQ71XV1ZgQ7Dg1S29b31TEaSHRAkuz8xD93DKOt/L+jrtT4yCS3xG9
	twRa2WvZWPrPt5UWXnzf8CJNBy5EYZuLJhXRUZJMsAryW81Az03/hS/yuPd5hYr5eMI7fWeLc76M6
	AcDWUiKmcCW7J6KQjTI7p7r0aSIYu7mGDhMl5+4q8QeDz39wgRh0uh5TmoPUvWshLNTtHW5fWb5mj
	pJJh+9BA==;
Received: from 2a02-8389-2341-5b80-164d-fdb4-bac5-9f5e.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:164d:fdb4:bac5:9f5e] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1syV1X-000000095Gc-0L0k;
	Wed, 09 Oct 2024 11:38:35 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	YangYang <yang.yang@vivo.com>,
	linux-block@vger.kernel.org
Subject: try to avoid del_gendisk vs passthrough from ->release deadlocks v2
Date: Wed,  9 Oct 2024 13:38:19 +0200
Message-ID: <20241009113831.557606-1-hch@lst.de>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Hi all,

this is my attempted fix for the problem reported by Sergey in the
"block: del_gendisk() vs blk_queue_enter() race condition" thread.  As
I don't have a reproducer this is all just best guest so far, so handle
it with care!

Changes since v1:
 - clear the resurrect flag as well at the end of del_gendisk

Diffstat
 block/genhd.c          |   42 ++++++++++++++++++++++++++++--------------
 include/linux/blkdev.h |    1 +
 2 files changed, 29 insertions(+), 14 deletions(-)
