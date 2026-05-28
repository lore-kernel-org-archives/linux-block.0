Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06091363C7C;
	Thu, 28 May 2026 17:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779991151; cv=none; b=I1teJ6iEQstQDHL4ETQhiQS4cQ2C/goM0+AgLwc2UjvLOoNsbjXkTT5ZCV/f1B1mVexeG+/LibdO+4Dd0pfsjsEXfWGcBTJyir4vSIdEVOKcUR4Dne3RY4bs3xnpEyEhOO+whry+5vMjiqvPtnxdCFrXVr0Cof0dAZlNQxhi5aI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779991151; c=relaxed/simple;
	bh=OOpSwKi6eKWgyDI/PIZKFaBjo4KtkkGNmHTHdgH45Aw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WSH/OZjec9jINHKDsTT/fpj58nF+dk21vwetg42+UZdZoMoh/bZYzdgms8Yfljhf8P1rqSdGy3MgMgaKnMwCjSnN66Lz8hbmqAbdJxUHNBR3kRQza0zISrwUsV+S3cPbw5zRqAfufCMS7/2ivwg9f81dwhCot5+ulabilfp3vF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=dxXupcRA; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="dxXupcRA"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:In-Reply-To:References;
	bh=eyENAjnk2aJwSde2nbPfN2ywHeMCCavPgJObBpyXFM0=; b=dxXupcRAnbMiSHF/aR4483vLNC
	0XZRti9N6De3tJeOrzt8jgd7qjnPxPSjFzTVOhDyYHLm2cxIT7COBYR2aPF1IsYaZN7+NKXiFeihu
	Tf8W9ic5rc0a/ERE45RycMwCoQE4GPQQPZ8DCZ2wjNXWcmOYHfkw5aExNv1u1oRcD3/kDfZGAvDyl
	U4byuvX7LxJmNd0wiXQm7/0z3NsQ8PiwMdpOT+WjaykS7lHjCToiLxjZECWwMeWOgIJ/y87ITizii
	oD1htBO6tCkjhRPd8KXG8pKDE/4n6XheUE4ACEQX0CvhHL4ri5Xj6LIs0eUIFSfn+7pWIkX9ny4yt
	IOhodNNQ==;
Received: from willy by casper.infradead.org with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wSf0d-00000004clZ-21QA;
	Thu, 28 May 2026 17:59:07 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	io-uring@vger.kernel.org,
	linux-mm@kvack.org,
	Leon Romanovsky <leon@kernel.org>,
	Christoph Hellwig <hch@infradead.org>
Subject: [PATCH v2 0/2] Add bvec_folio and its kernel-doc
Date: Thu, 28 May 2026 18:59:02 +0100
Message-ID: <20260528175905.1102280-1-willy@infradead.org>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add the convenience helper bvec_folio() to avoid references to bv_page.
Convert a few of the obvious users.

v2:
 - Tweak the kernel-doc (Christoph)
 - Add the bvec kerneldoc to the documentation build

Matthew Wilcox (Oracle) (2):
  block: Add bvec_folio()
  block: Include bvec.h kernel-doc in the htmldocs

 Documentation/core-api/kernel-api.rst |  1 +
 block/bio.c                           |  6 +++---
 include/linux/bio.h                   |  2 +-
 include/linux/bvec.h                  | 17 +++++++++++++++++
 io_uring/rsrc.c                       |  2 +-
 mm/page_io.c                          |  4 ++--
 6 files changed, 25 insertions(+), 7 deletions(-)

-- 
2.47.3

