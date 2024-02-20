Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEFCF5D745
	for <linux-block@vger.kernel.org>; Tue, 20 Feb 2024 08:49:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708418973; cv=none; b=KWTHHXj+SHoSbfmGm2+DS5Lv44d2OAP4AzLehPASwAqOhjVn+x3KOPcLwom2gHXSUwE2MwjReyeO/lzv/RYN3Kz7qEfUgru0eWDOm/vIATYiM3Vy4uh4JCVK0dH3/YcgkErd5qil8wQKAhMByMeRgnbt9pQ/BTXEDfCTQ47EUw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708418973; c=relaxed/simple;
	bh=N+yvqBosNFiqyBOiymQb02tw2TEVJVCbl6PaaGdXAds=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=tys3oM0QSUtRE0+Q4fPC481UaWlqOdJt3rknvUyvEpH7YaEQUOdGBY48pZYnxIDym1CD2NHA3Ew+3TTXkSwckcwli4PPKMTRyIHwuYAMpglu1xTnS6pvLNrfj1EWekzUAqkKkoV2Nd+ZBN2KIG0BL18+tEO8DAop106K9q3WMaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Y5mx2woS; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Y5mx2woS"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=6SfuAW972KnH6xK9mYEnu2XAsI1rZD/avgu8EQxehHo=; b=Y5mx2woS3KFrn6CgZJLKOsBj+J
	Xwmwlm0FH7ap7OXCaFYehCJOmmEicnpNRO0Hl3KlNxFgwMkGAcfCcb0mKdslDzLJpaVi4ICjcyc2c
	2+xuChxrG3o/ecPy0dwxKDLLgMNm5N9L8aU5j/RpV+HRRJkL7kKPPU0kE8n7Oce1Twm26S3iaZz7k
	VpaSnYugMXaMxnipTxpMcb/zio2et/Glx3VsFtRm+9HJSkhCDwV064YHupdN+U8f34/63JREO8GmQ
	6Dhn8HBm4NPhr8Bbn6+Sloc6MXlIcauVH5Q+rF4utCQfPY0VwG042LTNq2Yg3ICoUch7V/3Tl27hS
	ivNp54AQ==;
Received: from 2a02-8389-2341-5b80-39d3-4735-9a3c-88d8.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:39d3:4735:9a3c:88d8] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rcLof-0000000DnT3-1reG;
	Tue, 20 Feb 2024 08:49:29 +0000
From: Christoph Hellwig <hch@lst.de>
To: Juergen Gross <jgross@suse.com>,
	Stefano Stabellini <sstabellini@kernel.org>,
	Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
	=?UTF-8?q?Roger=20Pau=20Monn=C3=A9?= <roger.pau@citrix.com>,
	Jens Axboe <axboe@kernel.dk>,
	xen-devel@lists.xenproject.org,
	linux-block@vger.kernel.org
Subject: convert xen-blkfront to atomic queue limit updates
Date: Tue, 20 Feb 2024 09:49:31 +0100
Message-Id: <20240220084935.3282351-1-hch@lst.de>
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

Diffstat:
 xen-blkfront.c |   53 +++++++++++++++++++++++++++--------------------------
 1 file changed, 27 insertions(+), 26 deletions(-)
