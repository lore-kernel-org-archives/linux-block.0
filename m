Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E02D3B794
	for <linux-block@vger.kernel.org>; Wed, 21 Feb 2024 12:58:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708520333; cv=none; b=c5fSaCDb+BiPEGrCwnB2d4yXwCfrci2R2Mho8Fc3axKHKwM3h19/+/jeVvkFHDgMHQh1FYQVhLg4rGcerFUhc4yIoXyVt9jZ4B1FXNdxgitIOYZ9o0QJVaIMJ/Dg8XlLvUr9F0Z8ETMCL+LgYfnDpX8/PU3JLn/WEVX+6NJ0xj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708520333; c=relaxed/simple;
	bh=1OZT/vlR3nZmXKTLOq2/yzv19q7+8byFWlYrhFctdkY=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=j/GK9BM72zAoIGXmROITLnOMulEcnoZO5Shk23nDMk9vviKAFnCSr7NTNNGDN/jwc5/9rg0EvM5bejJ+SdAMqPv/fXmBfXgvPy3EPaFiWljRaNi6u3dgVvckvpzs3/hQgcdIVHI/roiipkBDlA3L2j0R8AWRkrJiQA4zpobCUWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=TLLFdF3h; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="TLLFdF3h"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=TLqbe5eB45zE6JDeJk2bwZfFOKKXQJ5aMNlrvDgw0Fs=; b=TLLFdF3hIPpuyvuEvHNUa/tPbJ
	D3wPfOyi+liltFjp06FdZVYZl+ndpbqTNHOg5WaQMvN51FsQpycpPo3LWgpFdF5ECcChTDVyXrmEx
	G1cdzOrAuFLGwBEL/r69hIkvu31pidcEkYJMDDUfndvC8oyVBi16xG3UXLKpsBq+dqTmlN7rbEqlC
	ML7OCIydIMJk4sFKe53MLlbOxWekXLOyGWNXZJKO3aU9WvULwUnlAVVHC9/N3saQ4RxUxI2lB3rFv
	/8Z80oV7eGgtrXTGM9ZJsi/1kgv6jg404yDrtwwkh5dQWFxSHtp2sQZXyQkYMeuZZWcn8SS1IXva9
	3TFHREWg==;
Received: from 2a02-8389-2341-5b80-39d3-4735-9a3c-88d8.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:39d3:4735:9a3c:88d8] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rcmBU-00000000wAK-1ase;
	Wed, 21 Feb 2024 12:58:48 +0000
From: Christoph Hellwig <hch@lst.de>
To: Juergen Gross <jgross@suse.com>,
	Stefano Stabellini <sstabellini@kernel.org>,
	Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
	=?UTF-8?q?Roger=20Pau=20Monn=C3=A9?= <roger.pau@citrix.com>,
	Jens Axboe <axboe@kernel.dk>,
	xen-devel@lists.xenproject.org,
	linux-block@vger.kernel.org
Subject: convert xen-blkfront to atomic queue limit updates v2
Date: Wed, 21 Feb 2024 13:58:41 +0100
Message-Id: <20240221125845.3610668-1-hch@lst.de>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Hi all,

this series converts xen-blkfront to the new atomic queue limits update
API in the block tree.  I don't have a Xen setup so this is compile
tested only.

Changes since v1:
 - constify the info argument to blkif_set_queue_limits
 - remove a spurious word from a commit message

Diffstat:
 xen-blkfront.c |   53 +++++++++++++++++++++++++++--------------------------
 1 file changed, 27 insertions(+), 26 deletions(-)
