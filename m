Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F189E356766
	for <linux-block@vger.kernel.org>; Mon,  7 Sep 2026 07:41:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788766880; cv=none; b=YcF37VBceUGiG32WOHcF1c3OHCZPoZjQeFbpEu49HFAOcloNq+JZCsdzqGSwTtSQiXgI7izffha8ah8dIAP/cY/xiJI3eDXBy89s50v0WwHsWPrdyekndKVAKgeGN43bOEj2xxeweZ7SgkPVhS6t5xzA2dz9nY1WmTp+tJsm7Zs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788766880; c=relaxed/simple;
	bh=MvCb7TarGadGmRt/hZ9UTOD732dcXMHYy7T9Khaob88=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Brqqy4FECo/By7nRc2D069EZZvpgDE39wzBSArnN1C9nQfGmQo9jECNxINHrUAImLrYf+FgMaGT1gOOzXWKc3Oz+4QZ4kHtQMYd9KwlBiaeZJKODHj397weo9o91PJabCWZQd9Unk3CauTelk7Lurw7TGdAroJc6YbMWsLfnvPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=MWmHG7aX; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="MWmHG7aX"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=qV0Zi+J6PRzPz1UoPuwMkRupbCiJWpqWRZJXnidfjAI=; b=MWmHG7aX7xWAXEUVzKb57RpYV+
	6NLWXWgQb9xtfv8ji2YR0atlHgNsgufBTSsSm3Hr02eELE/GYC8QIOh64QNlPjttI+1CBEUM4r9Xd
	QlskxqlKA8PHZmhNHDf+VMOQFTlPVWE1PLAFoypeZV5pxpnWxJk5RKvVqENoveh9KrpsRwddwrjuU
	ksKxxCJCVxrbwrAMeSGjIks+PPCBbBrlJqgJ1g4xXoyEdiJ8HvORs48R02jlW7RNESxgUTW0cpvrb
	7CFQ/iRO+FhrZPX63SiWlgPM/m+ysnwKafiucgobYQGWmnTKx4FdYoQ587ZK3rUr8o5huYj60NxUs
	2G6iImxg==;
Received: from [91.92.197.219] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x3Tyf-00000006Awo-0GWE;
	Mon, 07 Sep 2026 07:41:17 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: John Garry <john.g.garry@oracle.com>,
	"Martin K. Petersen" <mkp@kernel.org>,
	linux-block@vger.kernel.org
Subject: misc block PI / bounce buffering fixes
Date: Mon,  7 Sep 2026 10:40:51 +0300
Message-ID: <20260907074111.721054-1-hch@lst.de>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Hi all,

this series fixes pre-existing issues found by the Sashiko review of
the lazy bounce buffering series.

Diffstat:
 block/bio.c            |   11 +++++++++--
 block/blk-settings.c   |    6 ++++++
 include/linux/blkdev.h |    8 +++++---
 3 files changed, 20 insertions(+), 5 deletions(-)
