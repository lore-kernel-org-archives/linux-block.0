Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D76714F70
	for <linux-block@vger.kernel.org>; Fri, 31 Jan 2025 12:01:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738324887; cv=none; b=rH7orPKRqSwjCOkkDrDW13z6pXkPv/pYWzWWcWRb1z5XKYHcvsboKsmUzormEtWFrZJx1lEU4JDf0d+fVBQtYhqVLWgFo0uRPpQgMn4cPwty2rQsrdWPHCqghuhgwUSRPhIg33GWuu8S+upWe9pDMTN3PJYigJ16ljY3jQgfj0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738324887; c=relaxed/simple;
	bh=IOroSI3GuxGbWAB9GEVszCltxrk2qYeHEVJK/hnZZHY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PQZC2Un6uujKOd0TLb+gyXqkyahVYKnTRfXyCbNZCdzvjoXc4oHkMsADfLKFRUDRu1lblGMp99/Ps1N41HMG5fr+ZWnCEzrgz+xNAcdxwaX+VdaRdD7EdMuH+0m/4reY9xDm2n/qHvHJc91AM/7t2CEOjeKvHZOnDCEgpq2Hyb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Q81oIWi2; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Q81oIWi2"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=+I4+n4+UPhWk0+KclaVfXnM4KsAGt1GrvpVfa3IkwVY=; b=Q81oIWi2uecIbOpIUbyLeSZ5Hc
	5/VLcOEDxVhA+Kp3pw7G2ukzdu/GKuirK+zRcGnsV8n+O8s5azHX34wLGOroLVT1q5cPP9+M6c4cR
	VhrmFsnSBJ+wlBfbtP+CJ2GaTSODyAjX4EODxDYl8rFiCIVfNjLAXy1SW+tAvPenBieKwuUQ1BlgI
	NgncX3NIB+eeWYwoKvUCYPtmxT0PjBvYYxttsqW0+y9Dg9ahq6MqwdUC1Rx1pDZhyLzdM/qOshayv
	b5b8cpZc8X6NcWXyrXPJ18xa+I9W1SS9esBkIfaZ7FbqPgYgUYuU2mqxAXWPUNWJE11ewzVjUpp6c
	Ex5JTy7g==;
Received: from 2a02-8389-2341-5b80-85a0-dd45-e939-a129.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:85a0:dd45:e939:a129] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tdpi8-0000000AZC5-1kgV;
	Fri, 31 Jan 2025 12:01:24 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: Damien Le Moal <dlemoal@kernel.org>,
	linux-block@vger.kernel.org
Subject: loop: take the file system minimum dio alignment into account v2
Date: Fri, 31 Jan 2025 13:00:37 +0100
Message-ID: <20250131120120.1315125-1-hch@lst.de>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Hi Jens,

this series ensures that the loop device blocksize default also works on
file systems that require a bigger direct I/O alignment than the logical
block size of sb->s_bdev.

Changes since v1:
 - also do the right thing when direct I/O is enabled through loop flag
   and not by passing in a O_DIRECT FD
 - minor cleanups to the calling convention of a helper

Diffstat:
 loop.c |   84 +++++++++++++++++++++++++++++++++++------------------------------
 1 file changed, 46 insertions(+), 38 deletions(-)
