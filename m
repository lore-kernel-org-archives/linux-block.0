Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E766C3D81
	for <linux-block@vger.kernel.org>; Mon, 21 Apr 2025 07:26:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745220413; cv=none; b=ViVVrvpGy1u/mZHhQ5NjZZyr7quEJisM7kN5OSfVeYXOO5TsnBdiQC8L6YdVdFNmHfwczUO3jBko1rMSQYWHUPGwfPfoOVq7olW4dlgPYIEjKpGdMi8qhA28UGJIv/mVY2TSXn5LBB22nnlHaFvDCXRZ4LYMmuMGrovAo/nqUhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745220413; c=relaxed/simple;
	bh=7PbV8azGsQyxoBDsc1uagC5Znq1MY4vDeeZTI9GTQG8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Y1pip4js2LkdRjAunaoKWC7kN/QWln01qPgvNTpkiXM2VOKdK01XvEyfqVGnlmeKWdpNd6FoMMp/UDu3TCbLojtckRQ0dCLDQjXeOy9+IzUMyZpxF2WGc/rELBmCpOzGk1JkbkDajpaPEPT42OnoVAU+xC/38rtTQNFWGZoxBr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=AqBo5KU8; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="AqBo5KU8"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=i7rHKCifQEEUUX6QJukNhIUgHtETWeNCT3TjInEENMs=; b=AqBo5KU8y1O26hS1IW8PTeaavV
	f+YZMP+oCYKUSs8FozbFRH94XvvfA99f7kC/HkNhrDmlFhEYp2HZFRAyUzNeigOXukg1ciuwwKWgh
	2bl54tIp/2QhOVZKypUl1+wA1EHyvzbJ8SXGaHYYwY1FmAxf04BSGtrMzSxN0cHaECOiuzCfkB7r0
	0DUpX4FkcOCBvkW7WFplDmpYvbk6MhT+qwkA0TBrO4dJ4jycFy1h9nd51l1jOW3yWElCqImgqWxhS
	aeIoSXZcJSKCGM+/f6DxHg0x2VOGcEM/JdHvwGQ2+KT+MD9tavtg/FmzJ19xk5l2D97tViqliGOeD
	LDCXMACQ==;
Received: from [213.208.157.109] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u6lYG-00000003n0Z-0my0;
	Mon, 21 Apr 2025 07:26:48 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>,
	Yu Kuai <yukuai1@huaweicloud.com>
Cc: linux-block@vger.kernel.org
Subject: brd cleanups
Date: Mon, 21 Apr 2025 09:26:04 +0200
Message-ID: <20250421072641.1311040-1-hch@lst.de>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Hi all,

this series has various brd cleanups mostly to get rid kmap_atomic and
poking into the bvec fields.  I'm posting it now because some of the
work might be useful for the discard fixes from Yu Kuai, but I'll happily
rebase it on top of any pending urgent fixes.

Diffstat:
 brd.c |  165 ++++++++++++++----------------------------------------------------
 1 file changed, 37 insertions(+), 128 deletions(-)
