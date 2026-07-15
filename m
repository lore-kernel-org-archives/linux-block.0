Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 745E926CE2C
	for <linux-block@vger.kernel.org>; Wed, 15 Jul 2026 06:37:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784097463; cv=none; b=kyyRQBli6kebh5m4kexTrZrVhjCyiv0dSv4LXuD9hS4IBrSA2kfhtDdxfjrDMAQEUVReA48+k21dyc6jyQ9hZYxb0JjOP5NGT/MKjMq+i6gyYQdNoW1FugcLfRfBV8lUVENBdglqXv2UsyuT3l8dAuDGXQppvLGmV7iFQr8eXW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784097463; c=relaxed/simple;
	bh=0ZUWe3Q8shHyiAYl6UApmSJwONLr6V5JXVjbAzKfGHg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=csWWvb5CO9dHfpvGr9uNXjSiKNmLpqLnHcZ+sWOuqW4hZwAdiUZocWZkb3vfKC+h+sJbfOgZEUlOuylumY0WFzyEDhvTvjeysgP2PMsP2hdiDNsBcuQmzbjLdhNk4bhVCRrDb4rEOUZNpCeQnfxFNVp4LdGtIUU8XbgH6bNsj9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=wAQT4Y/f; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="wAQT4Y/f"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=/SGL0gUzbstxN4RZcVjVgGimGLo8xLun4lf5ATuaXWo=; b=wAQT4Y/fZXyd1WwbRN85G6L9XM
	+iG0V0r+CDggcHJqb/CSdNQYcdbnzGUMcgIEAqMjG8JLAqIRJoctv1jh4cYPW7VcxhKZxpTnPIVkz
	XCUBCkyCjRSFFAiqU7PbkRMXz8Sr4T6VYJ9UV80doJxl2nBnVUmhQsopsaLWMtqWiR369RhBEmB9V
	WZfwdURsEooXaBi8Wpr679kIR9fASvf2CEOr1bLnFkVstQ9XTf3nFsmi9IrI4jAWsel8wScHqZGRo
	ZIWPDir19UTrmGJP3nrsa6oXFJsU8ls42fOltXItwHLU/NIj79z36U5fFYDwgZU74cU3RKht7p96l
	qTjVsjHQ==;
Received: from 2a02-8389-2301-9f00-3397-c9eb-6d8a-9179.cable.dynamic.v6.surfer.at ([2a02:8389:2301:9f00:3397:c9eb:6d8a:9179] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wjtFS-0000000Duyk-3wzO;
	Wed, 15 Jul 2026 06:37:39 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: Damien Le Moal <dlemoal@kernel.org>,
	linux-block@vger.kernel.org
Subject: add a ZONE_RESET_ALL uring cmd
Date: Wed, 15 Jul 2026 08:37:14 +0200
Message-ID: <20260715063734.2933511-1-hch@lst.de>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Hi Jens,

this series adds a new ZONE_RESET_ALL uring cmd, and cleans up the discard
support a little bit in preparation for that.

This command is useful to speed up workloads that need to initialize a
large number (or even a small > 1 number) of disks.

Diffstat:
 block/ioctl.c               |   58 ++++++++++++++++++++++++++++++++++----------
 include/uapi/linux/blkdev.h |    1 
 2 files changed, 46 insertions(+), 13 deletions(-)
