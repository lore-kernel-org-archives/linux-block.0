Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A416F127E30
	for <linux-block@vger.kernel.org>; Mon, 29 Apr 2024 17:49:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714412946; cv=none; b=op56KSPTvJrxUEx1oh1qS2V1WtYulreYn971THOn6o+FoEhUEpcZyKpSqnC+A/qN44oMC/+iMoCQY+79hd8K6BanC763035x6vVOZ2mjyXMnUpgoLDiciCgUH6Em7bmsWD1yUVT+YtuG0ZVvUI9Ywws7Te3rBxOx0Wnqoq7Ydgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714412946; c=relaxed/simple;
	bh=NcenxhIVqQBOYOw8SLg5Ir1a7YfF8csT2EiBmHSbc+0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=L98GFzceonn9lvmDWtrJSC5hC7zKS03SF+fSkIvrNkmv4AN0r+14hKJnVYbhDmPIoghOTO6o5v+Q5dYnZRxSLEoiMyz8BfRSNM8qfkNTz7QrOzlZGm24bYQFsgDFj0PlNhOQh0P9SAj3zXcGL6WW8kK7JhzeLkjB4EgZGDBEjGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=2tIA8YbW; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="2tIA8YbW"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=fxaw3f4RV1e5XpQDbgmECWughYTNU4Kv7vH7CXkBnbI=; b=2tIA8YbW8zrqhusZnO+9+xGhvH
	iZ7tuvDkqWz/jiFqNkc0dapzUki4TjVgNLprWEBmTd/yxymfxZWzH3ICrKBowjvqU9nrRGc+f1qm6
	heHhqMOuBlpMeP2OQIibRrXrmUoy3L8tx0Ctih8igdBB+Tr5Rh7wKkvqmZ6cqOVWuWy8d3h9bYqam
	l6fO++wVeI2fZ7quBTRGEPdy9lvSVRkmuZJSI1BSARvdZN53GxxaPRKeUjFHHiuP/4zfsw74qo88A
	9b94UbLuQ4Bp59+TImjujUPoivbyXkOBy3Mw6L4w69VcLsg8R+VISULN1dCipao7rZtLi5ynXNPTa
	iX6biNaQ==;
Received: from 2a02-8389-2341-5b80-39d3-4735-9a3c-88d8.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:39d3:4735:9a3c:88d8] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s1V7f-00000003mYm-1v6k;
	Mon, 29 Apr 2024 17:49:03 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: Lennart Poettering <mzxreary@0pointer.de>,
	linux-block@vger.kernel.org
Subject: add a partscan sysfs attribute
Date: Mon, 29 Apr 2024 19:48:59 +0200
Message-Id: <20240429174901.1643909-1-hch@lst.de>
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

Diffstat:
 Documentation/ABI/stable/sysfs-block |   10 ++++++++++
 block/genhd.c                        |   15 ++++++++++-----
 block/partitions/core.c              |    5 +----
 include/linux/blkdev.h               |   13 +++++++++++++
 4 files changed, 34 insertions(+), 9 deletions(-)
