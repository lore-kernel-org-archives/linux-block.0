Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 000387F7EB
	for <linux-block@vger.kernel.org>; Thu,  2 May 2024 13:00:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714654844; cv=none; b=adI394rJSFdY1Io6v1Y/PwXraUNj7m19t9wKsCAOx9QMQqmHhL2pu4jdVwdpsQTd8+iBKSeBLM/0b6PT7fx+ccB66Cgp+K9cTaMM1wEZgntvzO4PudkwMd4VnF41u2cdpSdRNigBqjC/YymBxjeJ6lt1DpHyVMqDLNYU21loB50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714654844; c=relaxed/simple;
	bh=qZAyWq+TS9bYlr27JsBzvMwM3/uNnMKgABvexkPSnVA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=e22aBfGmq5x7AgFp2qDnxWNCrSWDCAzdPfejFMcKF1EJuJXb9VjABvgOieIBC3QlWW+ESz92zEBhFBGuqhTZwCDFz+iBBjbnpClC7CSuepQ+aan/VneFtp8Fr5N91ZfTPmm79L62Mf5lUzWzTUnaLIO7nu9QiT6/dtlEr5tlnV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=mdOEqx/j; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="mdOEqx/j"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=vHossGz0SwtDpMtpdmDY2giEgihRp5vqNwDPjv7F5hw=; b=mdOEqx/j2d5ldvU/EzTZva4DsX
	JUGrJEZPDVYhAzMAp5IRUmLAcIpsyFyC4RlAF5rJqBoQ2sFbbwwez65EcdaVHlwq0EiDtBAMpeb8i
	Xapx7KFkZuhN9Xxc7Hm50lFBjm4+n9CctnnX0m4UvrkoxWtrFhEctoGr978b+Sf2lrvOqBuKQAUxY
	GLxQnGrRBkiqejdBPE8fl3ARi/gCUdFAW+atr7TG+x5w7pdmYn5KJ5iVpu5IA1n+YtO4s9kcbfP3T
	YxmENgzGc2gqfPeHWvywwyxPsspVdRZ8dkLoinX7olxF4SC0rdNkwswudTWTkClVFaggjs/O6ST/V
	45w1x6Hw==;
Received: from 2a02-8389-2341-5b80-39d3-4735-9a3c-88d8.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:39d3:4735:9a3c:88d8] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s2W3A-0000000CjBv-1ttE;
	Thu, 02 May 2024 13:00:36 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: Lennart Poettering <mzxreary@0pointer.de>,
	linux-block@vger.kernel.org
Subject: add a partscan sysfs attribute v2
Date: Thu,  2 May 2024 15:00:31 +0200
Message-Id: <20240502130033.1958492-1-hch@lst.de>
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

this series adds a patscan sysfs attribute so that userspace 
(e.g. systemd) can check if partition scanning is enabled for a given
gendisk.

Changes since v1:
 - update the data from the non-existing month of Atorl to May

Diffstat:
 Documentation/ABI/stable/sysfs-block |   10 ++++++++++
 block/genhd.c                        |   15 ++++++++++-----
 block/partitions/core.c              |    5 +----
 include/linux/blkdev.h               |   13 +++++++++++++
 4 files changed, 34 insertions(+), 9 deletions(-)
