Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E37CF1891AB
	for <linux-block@vger.kernel.org>; Tue,  7 Oct 2025 09:06:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759828011; cv=none; b=cG1J6Z+kSYJ6Nyf/suqknGS0m04vp0cju7cp7jz8/j5JWdr3U5H7zTJtwkl5ByeEtKJokQnUo13kwfTIA9X+ZrS9zzUuUA3SbAI3Vaeta6mVrcnhA/EEOkFZIWtohxwzFrcZDFaFTn+3rEgISjproLnUYkk4WDdZF+EpNB1QJLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759828011; c=relaxed/simple;
	bh=aurHrFnQtJhrf0F82cedLq61rHgszJ9CLqbt+d5u3Cs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CUrlHzvHTMDwJqNlwdB5g0nRk6K/S0Z/lMr0Mun2S2/nzj+HJchsrcLDw5DqkJnYb0sLMY5TUaTUPkWlYq1cgzhtfAqBDh+ju1cGQKv2rYbK/DwcSJkaNH6XrQhzDbvwrQ70iSjSHQ5FJt2T0bxknXWlYRMLfAIcqUsb1EB4D/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=UyZIxvjr; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="UyZIxvjr"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=EUK3XwojZypRU7TjkvmcS0Oxak6P1HVcWC/NLv/N2T0=; b=UyZIxvjr6sIqwoVjqkBavQVxH1
	fat/Mvzwya3y5UZtY8Lxqn1fi0D9d64+WiuuKYus75KgixBE2ZMtwoaof4lXcCeyTkdTlPkYGq3Ps
	Kfcr0dFxcXRajbSbMRnEwOiSb2WSrANLt4Q9lMnxmE3rBNlB+kZ/3PEWSx5XT62fUAptT35pOiUti
	RVcXTf8b6tVa4IVpEuzljLY5wsDUiKecS3ChArSBGxS0G5WTgZ6XcvUaIAKxNwOYKYRPLmkO548nO
	haMmY/sTgt4UlU+3h+TV0B7/rX0uXvWy6T9dK2XmzqY1EjtigxUhR43Hfd4r8RCEALQU9WNizmVNH
	WtzxHOFA==;
Received: from [2001:4bb8:2c1:22e6:ca8d:97b7:39cd:b2e9] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v63eh-00000001fW1-3MN5;
	Tue, 07 Oct 2025 09:06:48 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: Qu Wenruo <quwenruo.btrfs@gmx.com>,
	Keith Busch <kbusch@kernel.org>,
	linux-block@vger.kernel.org
Subject: cleanup for the recent bio_iov_iter_get_pages changes
Date: Tue,  7 Oct 2025 11:06:24 +0200
Message-ID: <20251007090642.3251548-1-hch@lst.de>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Hi all,

while looking over the bio splitting issue reported by Qu, I noticed
that some of the recent changes to bio_iov_iter_get_pages lead to
more indirections than really needed, especially with the bcachefs
abuse now removed in 6.18-rc.  This small series cleans this up
an prepares for the file system block size splitting needed by
btrfs bs > PAGE_SIZE support.

Diffstat:
 block/bio.c            |    5 ++---
 block/blk-map.c        |    6 +++++-
 block/fops.c           |   13 ++++++++++---
 fs/iomap/direct-io.c   |    3 ++-
 include/linux/bio.h    |    7 +------
 include/linux/blkdev.h |    7 -------
 6 files changed, 20 insertions(+), 21 deletions(-)
