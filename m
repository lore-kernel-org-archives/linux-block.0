Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A985A31
	for <linux-block@vger.kernel.org>; Wed, 26 Jun 2024 04:59:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719377997; cv=none; b=pCbawneYuP7ZjBOSuVQ2SftiHWvl5BbxGFYPV4zVu+T1iQ+OkqjAclkMh2HIZgjxlKUwpX1mBetOtHE88OTdZIJC7dsZ/h30pca/uYAJIUowOXT3c1bjP8JCSHks+tmxS1U821XTpcTVuep1a3gOtfIYK7bjT04cngfi111KhyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719377997; c=relaxed/simple;
	bh=7kla/wSXoT6xh/ImzjWAOOTatUXis7CftttxU8Fnelg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qLg3yNBfD11qbKqwTuQBiBN2gb8e9s0X0VGxQ1YsOC+VEYbIV5yYqo8yg59oZWyxyr/Y/BB2B1OTf1ZOtxXUXXds0uMzFKDcukNW1uZvetMV3BU+U9qHRgwyrCDNyQiUL7/b4GpDVClzgu8BP/xUW3hMT66yLhPYQLj4O9PHZCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=x7zC/AEi; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="x7zC/AEi"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=eSAF0+kO/PhrgWC5QKOK8QM1jqnrigu/m0obJf2+i3E=; b=x7zC/AEimABCY6NOuFAaYrA0Bp
	MQ3YG/d5yz60JttasymiF1xbCAR+aLnS5Y+1JSIY/GHTzuvPj7xLkdRRJmgHcl2ofjW/BTNwnLU3Z
	u4Ks2NF21RNxRynvRGNmPiuqj6YVSm3jqE8N2K8WHLByc8j8JwLMbuhA6sIy+5YR6mAXb0j6fmr4P
	49JRPp2orQmDkI9HvmfWrM34Mk+bWcNlDkiMnX6usnePI4szfX9ucjfznRhBDU8YOlvQPjSipeFwc
	HUyzcfOLT7LANtjhzccq5sNqROVTEMJYormOkhyyrJAgO0CECR3z4FAtrr7AMp73xCwP3e5Slu7v2
	LUOwXe8Q==;
Received: from [2001:4bb8:2cd:5bfc:fac4:f2e7:8d6c:958e] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sMKl7-00000005NkN-0z28;
	Wed, 26 Jun 2024 04:59:53 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: "Martin K . Petersen" <martin.petersen@oracle.com>,
	linux-block@vger.kernel.org
Subject: integrity cleanups
Date: Wed, 26 Jun 2024 06:59:33 +0200
Message-ID: <20240626045950.189758-1-hch@lst.de>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Hi Jens and Martin,

this series has a few cleanups to the block layer PI generation and
verification code.

Diffstat:
 block/bio-integrity.c         |  101 +++++++-----------------------------------
 block/blk.h                   |    7 --
 block/t10-pi.c                |   97 +++++++++++++++++++++++++++++++---------
 include/linux/blk-integrity.h |    9 ---
 4 files changed, 96 insertions(+), 118 deletions(-)
