Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C55397603F
	for <linux-block@vger.kernel.org>; Tue,  8 Oct 2024 11:58:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728388683; cv=none; b=qZDHtAd6Far341oKwUbJ1U5a+jj45JXfFhmnkc12oZVinqFcjCsPg2x+NeCb+zLIPFj4TMjELZPIYCXwZ3zns1w9vDAdaX25KzwLGiNaje5psxdVB9qxoLUoU7zXsMJXUl5LusEuIbiyEkvhoB8GvUplWcuu6Vx1kO7FAm26hnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728388683; c=relaxed/simple;
	bh=J5B71StSY8EAuxc+N+jOSoLMA8E1Gsx/nTDfJMU1+hc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pLnobCnV0x3ylaWZ0zlpXMHdVyaPsoMhSfdLIyn3WxbnDmRdMyIfud7MqaDoFtUxOKhEyg7VuS6Zar1cTktj2IDXOaYda8TSByyAzgQbo72uv/PbduZnHhWp/xioc+cb9gugwT3mR+VVmXWWH8allxQXgquk9B3dJS6ZnsuRtCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=s+4IWaZY; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="s+4IWaZY"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=bwPOU94ezTjZB+dYoExaZviNQILmlCv3Q6Fx386GZ74=; b=s+4IWaZYYOpVZqFEOUdXTWW/7j
	1/EkSJFMjjcF/5RSXzN69UFWQAD7CMz3dHJWL6vf3+xiHhV7w5kFULd441jiyMDhud7tOLLRFfy5q
	HN9vEi4eo8g7ESdZi81gFqUPbfJymsmLmJebrSZxn1IaTcJUhGF9XIFxUXP661YRY44xgKb5hSj+S
	nqAexs0Bq6bXlLE9Q/ZKJBRtSxdzJM6hmhUpGWDrHeDzF2dq7Pr35CQHoNpQqIFrB/Um/K7LffjQC
	5G/0xswOc+fnHSODbnAnbRq3FQvFMFrGf5RmZ0qN4yAsPrZrtMJ//gOiJ3PRC1+Q6FILSllzhhkwP
	kf2tPwHA==;
Received: from 2a02-8389-2341-5b80-a172-fba5-598b-c40c.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:a172:fba5:598b:c40c] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1sy8qm-00000005imr-3Hxf;
	Tue, 08 Oct 2024 11:58:01 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	YangYang <yang.yang@vivo.com>,
	linux-block@vger.kernel.org
Subject: RFC: try to avoid del_gendisk vs passthrough from ->release deadlocks
Date: Tue,  8 Oct 2024 13:57:49 +0200
Message-ID: <20241008115756.355936-1-hch@lst.de>
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


Diffstat
 block/genhd.c          |   40 ++++++++++++++++++++++++++--------------
 include/linux/blkdev.h |    1 +
 2 files changed, 27 insertions(+), 14 deletions(-)
