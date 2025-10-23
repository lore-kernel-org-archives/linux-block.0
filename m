Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D0472EC0A7
	for <linux-block@vger.kernel.org>; Thu, 23 Oct 2025 08:09:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761206970; cv=none; b=GSScWIW/+RG97vwoVC0YHLdyck1CTfCsmkxuUcCd/lWyas2Jwl6xeICdFJdVn4knNBe0j2a1x7npWQs4WYI3RDXrNGDpybBUcA11kxFvbkMg4i/L/3tONMYrPvCrh7XVtny+Ep0rMV0hofl8OaY26Q9sx3aq2nA5NP8ewlORJes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761206970; c=relaxed/simple;
	bh=tQsoMX8P1aXFyp93Y9HvEu9WEQIsclqaFX4t9xcqCdo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=V7buFzgL8B/abWk14YDjFOR95s+WVJoq/FUwLno628oObB5C6D4of/QXi/bv6MbbVDVUrGHG2dlBoFjYIbgbF4ZMQvA882uWugTKjzbxDNajXG0ldeEXDG5ZFEYpDoWnfgRAW9mopDDwl75VJrUsO9AsgDY203lZbFH2CZPYACA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Xlp3eQ6q; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Xlp3eQ6q"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=X5Z35GBvuU1/F8eoNN2dfHt9OmH4uDnc9uf4te8p8NI=; b=Xlp3eQ6qwkzZxpgVYyoufjPeA7
	aBIgLzxe5e6fMa+PR3PctfItwwQ6TERgjvk/jP1Wyg81StojqPOKhkad1XdpVlrsBqVX3G3Gpp93Y
	qjOwoySNY+GD3h/AapW59wwM0INX2TBJRlkpwlT8kSeXLqwXCyPyZ6VcYxy1oTDhkIp3SwqnSxZ1J
	rJ59Ownx5zfQQTkGgUj6aMliCht08IvvOeIvAEj80E0QfQDzAG334L61xXvYu4c+fhsQL3nGEFxbS
	1AScHiEyodbUyLGjMMqAq3m8Fiz0WFSLJe1NPMHOzJ1Yx3s9muW1rrjFleA9ux7RX/sfSVwgFseug
	5gAwVWcQ==;
Received: from 2a02-8389-2341-5b80-d601-7564-c2e0-491c.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:d601:7564:c2e0:491c] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vBqNx-00000005TlH-0pvY;
	Thu, 23 Oct 2025 08:09:25 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: Vlastimil Babka <vbabka@suse.cz>,
	Andrew Morton <akpm@linux-foundation.org>,
	Christoph Lameter <cl@gentwo.org>,
	David Rientjes <rientjes@google.com>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Harry Yoo <harry.yoo@oracle.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	linux-block@vger.kernel.org,
	linux-mm@kvack.org
Subject: make block layer auto-PI deadlock safe
Date: Thu, 23 Oct 2025 10:08:53 +0200
Message-ID: <20251023080919.9209-1-hch@lst.de>
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

currently the automatic block layer PI generation allocates the integrity
buffer using kmalloc, and thus could deadlock, or fail I/O request due
to memory pressure.

Fix this by adding a mempool, and capping the maximum I/O size on PI
capable devices to not exceed the allocation size of the mempool.

This is against the block-6.18 branch as it has a contextual dependency
on the PI fix merged there yesterday.

Diffstat:
 block/bio-integrity-auto.c    |   26 ++---------------------
 block/bio-integrity.c         |   47 ++++++++++++++++++++++++++++++++++++++++++
 block/bio.c                   |   13 +----------
 block/blk-settings.c          |   11 +++++++++
 include/linux/bio-integrity.h |    6 +++++
 include/linux/blk-integrity.h |    5 ++++
 include/linux/slab.h          |   10 ++++++++
 7 files changed, 84 insertions(+), 34 deletions(-)
