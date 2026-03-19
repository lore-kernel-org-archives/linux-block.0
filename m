Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A70B3148850
	for <linux-block@vger.kernel.org>; Thu, 19 Mar 2026 06:02:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773900180; cv=none; b=S0woqpuu5PVA7eRkhAdEo9EWk/vU6E4Hp0ZSzoEjTDYoVSNfFyMKArK3mL22fUwLZ9rnFG97PF+P8jGBsJUFMFJN6slQiCyXvzNeNhTgZ1JBs1Ookl86x9Wk7LxdVIrxELxeodTf9bwtUedby4N2hWBsBZ2sqWkHlRl7czSZqiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773900180; c=relaxed/simple;
	bh=pvv6opc+B7Fc8ZiQApE371/g4IV6oD4de1b9prQ8ruw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=aVCeNlgwfocYgYWBNuN2QycGd4GD9IJA1US8RfY83MtM7wBrAOm5If7awNTMtQGCoQJaNIckz8vFjU4+0L14GZBkNmpYpF16ZguOJpa682qyyxvEXBoI3i0diPX4NGkSCL8KFrv+8076NLFAAZctCN6WmTTxwyyW1ARbcvklE3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=0Uxtkj8c; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="0Uxtkj8c"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=3GoUsnN/OfoYiL3wL5ZUYVTNJULYAkTJEALph9OrziY=; b=0Uxtkj8c0ezTe5pAa1bGF89uo0
	/APxuA9V6Ci8x8xUF9dUMR5BNhrKTe2DJpRZ+58nrkSaJ7ZxJ2sESGxnOC5UlNAfEdgXkg7hmUBf2
	qLtWbAu1EjQNwCAlcDhslPREuhUCIOO8D9cPtlu4N4ksQCulz77+HOjN4yAipRe/KQDS/RFLEfc2f
	i2yrtfZlvyUiWLrAk2o06Rz727+x1ZTTOFCy+pqFbVCXQO8OpKxjboY0npRLddPWVdAq+1kkCETZc
	WMg47wgmQH34NIH1ZvdmRqimyr5lQtCFrQZYTKB/oziM5Ek0xviG5+GWzwoaeTwnLI+ehWEKVi5oE
	jDvBe9AQ==;
Received: from 2a02-8389-2341-5b80-d601-7564-c2e0-491c.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:d601:7564:c2e0:491c] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w36T4-00000009yU9-1ZvE;
	Thu, 19 Mar 2026 06:02:50 +0000
From: Christoph Hellwig <hch@lst.de>
To: Damien Le Moal <dlemoal@kernel.org>,
	Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org
Subject: add a "discard cache" debug option to zloop v2
Date: Thu, 19 Mar 2026 07:02:35 +0100
Message-ID: <20260319060246.2084931-1-hch@lst.de>
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

this series adds a new option to zloop to lose data not committed to
stable storage using a flush operation on device removal.  The idea is
to help testing that file system code does the right thing in face of
volatile write caches.  For conventional devices, this can be tested
using dm-log-writes, but the concepts there don't work for sequential
write required zones.  Instead this adds an option to zloop, which
records the write pointer at the last cache flush for each zone file in
an xattr, and truncates the files down to that value on removal,
simulating losing the contents of the volatile write cache.

Changes since v1:
 - fix up the documentation

Diffstat:
 Documentation/admin-guide/blockdev/zoned_loop.rst |    5 
 drivers/block/zloop.c                             |  337 ++++++++++++++--------
 2 files changed, 226 insertions(+), 116 deletions(-)
