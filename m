Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C9BA1DDE5
	for <linux-block@vger.kernel.org>; Wed, 18 Mar 2026 06:18:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773814724; cv=none; b=KQ9mukPBcJvigpwGXl8QXR+x1L8OSSGsN9rzRk9E91wGVadXWUZCP0J9VSs4XWgXkTXkK0pB92jHZxLx90sp4f2k5qvvL6hE53wRsvdxHGNsAe7F9BNuOEqg0tbewgdshjVaeKqGlmp3/YhDyOXEdVrzoJZ0ISk4s7TRgaLASRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773814724; c=relaxed/simple;
	bh=MF5ODPm6Dcsu1TyWFZYO+6Kyvbhm67TMGeSuOMtpeTw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=s4oLVvASVcItAFygfuis8WEzHsnTf/9kDe5neXYw0MGrRZZs/Eg9OJuYD/+ayIpYiLRjtXnzsmG6Fg+Ap4/er44UZXQq3XG2LhFVoYvskX/KOQOPYMx3VMXtrFKuafdHtIt+FfUsAFyaF+KvulEZ30Trkh2AAGlLjz4ebriK/6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=ZO64JCjW; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ZO64JCjW"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=HJTfJXGRFZuPo7rUWyi2CHxAthMhl9YvcfOphubGDPs=; b=ZO64JCjWyXwKAxjSawL/VG0mBP
	UdEOAaXPC2NhVZee+NHP+ZETCPdKFrSFRU0HeA2zXmIBe5HLcXOLxidIXsvTucl4cpyc0x//wlLs5
	gHepoerI3N9JxF3OX2MPxRhf4x5Iis5rERQaunR8Yn5Db3xVoFSUYcrbVqEMQw9qR5JaanoKOitby
	D5e0bgkxEy0UlDqslOhl0nD0Bodyj5uNYI+fMS4RudgqRx9fefakv0DEu6F1thTUAD3ip/+B8SJ2e
	UTYPZMH6TGfaMlm4a2Xk0RZJU7QreCsI46HOCYXeBJJj8enI/oj7RLPFVTqAAKgAZUfeKMAZR6vlm
	ha1IyUEw==;
Received: from 2a02-8389-2341-5b80-d601-7564-c2e0-491c.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:d601:7564:c2e0:491c] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w2jqa-00000007o5a-3UuC;
	Wed, 18 Mar 2026 05:53:37 +0000
From: Christoph Hellwig <hch@lst.de>
To: Damien Le Moal <dlemoal@kernel.org>,
	Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org
Subject: add a "discard cache" debug option to zloop
Date: Wed, 18 Mar 2026 06:53:13 +0100
Message-ID: <20260318055331.1824108-1-hch@lst.de>
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

this series adds a new option to zloop to lose data not committed to stable
storage using a flush operation on device removal.  The idea is to help
testing that file system code does the right thing in face of volatile
write caches.  For conventional devices, this can be tested using
dm-log-writes, but the concepts there don't work for sequential write
required zones.  Instead this adds an option to zloop, which records the
write pointer at the last cache flush for each zone file in an xattr,
and truncates the files down to that value on removal, simulating losing
the contents of the volatile write cache.

Diffstat:
 Documentation/admin-guide/blockdev/zoned_loop.rst |    5 
 drivers/block/zloop.c                             |  337 ++++++++++++++--------
 2 files changed, 226 insertions(+), 116 deletions(-)
