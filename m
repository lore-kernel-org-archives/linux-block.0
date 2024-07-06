Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ACC520DD2;
	Sat,  6 Jul 2024 07:52:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720252354; cv=none; b=acq4PC4DvLzWHjz2D77t6rP8HuryXKcjU3OZdSB59FtqTnXMs3E5EEBNKWVI/AZYx/2j8/bF4CV4I/FOMGvctz1itXKgqWUW4oPUXfY6tBpFkmvqNcNeeuTpRV9OXevqtF38XELaiK9HrNPynDTyhpn3uzcB+ZBdtqPqldgFCZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720252354; c=relaxed/simple;
	bh=XD7xvQzS/c6AU/JYvDJt1Ce7auaKvy4i5vk2fnvOKQE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=U8Zrwnod3nPnWov8r3eSUE+2fB90PxCweVuQ4CDoDlq4wDm0+WDrKgNSZf5PTuYSGyg0xVZ74pYkoiBkHCo3kLB5hAP+W5IRE9IINV43ThYZU1+AYHeYukToFv5Fm76lPBmnk2ObuTpAP6OEvB9/YZjMTlZilzj9XPeCunHRK7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=OShA6qa8; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="OShA6qa8"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=dsTTu515nhE3EiNHghMRN8VuppmfZeLHwdnzi/+9rcA=; b=OShA6qa8g6swWbtH1MLEVUlFqb
	S6PyutFBlglENgIlSZQFwzDckgjpMchmdj6cd0uAHV2Mkh1Cm800DAYh+wEKkgHF8FUAjbO+DECJW
	n8MLZYxSmg8NRKJOVEvGBntmsgfzJOOk+WYQpn+GAOXAg8Fj9M+1MU3xRWK/r52NVb8mTq5p5M8vH
	jNzWMvMyrVFdrffCA+G7UvlBV1pyhEZdnrOcLlTLUzf0/mHx+53uiEzpwdiG+IufdZryBPMZeKiX6
	PRiabsoxUfwYRSRpA2Z3paB1kgQyRI1HSmtusIMIiLHUsHP3L/jbfCOuyfShueVuKDtSTE7PyZeuc
	dfe4dKyg==;
Received: from 2a02-8389-2341-5b80-918c-9045-e0f1-f54a.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:918c:9045:e0f1:f54a] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sQ0De-0000000HUu1-3Y4O;
	Sat, 06 Jul 2024 07:52:31 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>,
	linux-m68k@lists.linux-m68k.org,
	linux-block@vger.kernel.org
Subject: add a bvec_phys helper v3
Date: Sat,  6 Jul 2024 09:52:16 +0200
Message-ID: <20240706075228.2350978-1-hch@lst.de>
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

this series adds a bvec_phys helper to get the physical address
of a bio_vec so that callers don't have to poke into bvec internals.
There aren't a whole lot of user of it yet, but with the new proposed
DMA mapping API we might grow a lot more soon.

Changes since v2:
 - keep the existing (somewhat weird) description of get_max_segment_size

Changes since v1:
 - reorder the two patches as suggested by Geert
 - fix a comment typo
 - use PFN_PHYS instead of open coding it
 - also pass a len argument to get_max_segment_size instead of open
   coding a min in both callers

Diffstat:
 arch/m68k/emu/nfblock.c |    2 +-
 block/bio.c             |    2 +-
 block/blk-merge.c       |   25 +++++++++++--------------
 block/blk.h             |    4 ++--
 include/linux/bvec.h    |   14 ++++++++++++++
 5 files changed, 29 insertions(+), 18 deletions(-)
