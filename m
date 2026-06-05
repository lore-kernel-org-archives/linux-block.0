Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6696A3E6390;
	Fri,  5 Jun 2026 18:44:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780685089; cv=none; b=gglMAxFCvq07wES60b8naeHtY4hQi/4gjiE0kVmbpZ5gn56H6TOUzfrLm2M07Dm8I6i8NSNS7DCAhpO3HMToXO5OuHq45H+iZcLe7UWLmYS4oHoTPXa4Xfl3OI+9TBj9YWwIkNELFdX5048rMt5fX3/n1H+l2FqJseesePZcq9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780685089; c=relaxed/simple;
	bh=cirykKdh3Ux92qaOxJoBnqcR5RrkCF2mEARPSAqjQdI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DtQ67+Xh7uvutGojtm3WuFChC3/Ohvl7TMQEauW6VkQvkKoLdldS5VYDz/F1+sorh6Hhck+1Xyvtdiii+RfL5KwOYG5aTN+5aPP/QKg+Yi4koc5Yp9sB9gtmR4HYj8Q78V3S/MM45AYlOSV0ZsvG5HVWGkJOf8UcZxm09b3uSZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=QoDp9175; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="QoDp9175"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=Q/NZDcElzJiPyhuVgJ6Gqb6zS6Id795zUdlTqyADuI8=; b=QoDp9175PdipNxE12OyqYT8V6h
	PgtrW2jDKgYmWEMbWzfznrpV4c2JMgcErbJg2RVJX6Fznf2FdgSbWkbQrpd70N0Qc1AnTmxC/iMdK
	Y6zO24BHjmgNVQiqlTU9vQWH2kHdEqjAoS9C5gSHPtlX9OqWjiy4T8lAU0D78uFlGmDhEcKXskxOl
	oS7SIPOwvg/J6WHG6C/HXgJjrdvsJKn1vPrrt3eYI1CKY0Li1DJlp/HfuFTOTpfWgKN2hyJKm+FMA
	thPZExzzxVwR+vaWFPe9xcnJ1BcVXPhRSRk14QFOesyvfTXmIay53MT7iEwbJjWjij6lN6GeruimK
	WGn7Q4Wg==;
Received: from 2a02-8389-2341-5b80-decc-1a96-daaa-a2cc.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:decc:1a96:daaa:a2cc] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wVZXA-000000014Nw-4BEZ;
	Fri, 05 Jun 2026 18:44:45 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: Jonathan Corbet <corbet@lwn.net>,
	linux-block@vger.kernel.org,
	linux-doc@vger.kernel.org
Subject: configurable block error injection v2
Date: Fri,  5 Jun 2026 20:44:26 +0200
Message-ID: <20260605184441.590927-1-hch@lst.de>
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

this series adds a new configurable block error injection facility.
We already have a few to inject block errors, but unfortunately most
of them are either not very useful or hard to use, or both:

 - The fail_make_request failure injection point can't distinguish
   different commands, different ranges in the file and can only injection
   plain I/O errors.
 - the should_fail_bio 'dynamic' failure injection has all the same issues
   as fail_make_request
 - dm-error can only fail all command in the table using BLK_STS_IOERR
   and requires setting up a new block device
 - dm-flakey and dm-dust allow all kinds of configurability, but still
   don't have good error selection, no good support for non-read/write
   commands and are limited to the dm table alignment requirements,
   which for zoned devices enforces setting them up for an entire zone.
   They also once again require setting up a stacked block device,
   which is really annoying in harnesses like xfstests

This series adds a new debugfs-based block layer error injection
that allows to configure what operations and ranges the injection
applied to, and what status to return.  It also allows to configure a
failure ratio similar to the xfs errortag injection.

Changes since v1:
 - drop the should_fail_bio removal and cleanup depending on it, as it's
   used by eBPF programs and thus a hidden UABI.
 - as a result split the code out to it's own Kconfig symbol
 - various error handling fixed pointed out by Keith
 - documentation spelling fixes pointed out by Randy

Diffstat:
 Documentation/block/error-injection.rst |   59 ++++++
 Documentation/block/index.rst           |    1 
 block/Kconfig                           |    7 
 block/Makefile                          |    1 
 block/blk-core.c                        |   86 ++++++--
 block/blk-sysfs.c                       |    4 
 block/blk.h                             |   15 +
 block/error-injection.c                 |  308 ++++++++++++++++++++++++++++++++
 block/genhd.c                           |    4 
 include/linux/blkdev.h                  |    6 
 10 files changed, 471 insertions(+), 20 deletions(-)
