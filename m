Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F0FC16DC39;
	Mon,  1 Jul 2024 16:52:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719852747; cv=none; b=e29IuIMfp7jepA8MDL/HIJOMaaXD/0E982O8AWLtcTUCnLU5uAhk9Jk0pDVGf2zg8Qmbx4tChalX0l80RqjN8zS1cU7oXZgybPQsYbHsAbJ4sof8mIYMrmPm1V5JT1MzWxRgV9SnlXEHSfJujPD5txf8xzDyTtRxuuab9ODPyBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719852747; c=relaxed/simple;
	bh=eQ188u5otJLr+/ye/qC2MHfoFwSvzXnlNkLlcinEezg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XuRR3bCrJbH2bVu0ZPAUIA9F2Sw+rNMf2IAHQAWVPl1i/8WUDsZlMlvTqOY3AnkeUWc1LhnPDTaX2VwDm+IHk2WIFT5uyLpDMzgyCpnqdj+9xhS8nGVcfbjLMFcYbo0PhCtaTRJlrn8GMeT4b32qbnYWG5NClUl0aoPcXKTqBXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=BqlnIaeq; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="BqlnIaeq"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=g7CLfCApS1E6b7Q88cJLyjqyW1ZSAp5sVavC/eXAKt8=; b=BqlnIaeqHKd74Dm1FlBRPRvj4V
	nirKcauiuxhMr1kkrZ2A5C9cwTJU2p3Q5Jerxw2XgxW4+xJO8sI6hQQKJc4fxQRgNqOC9LcH4nDPr
	547CIVNAnycgOed5qJLFlZTTMEiY8q3G60DbXV82DJVpQKG+pgBcDzR/EabMqEixYYdgOzP0Od5XN
	HCsU2q92d4YeZeCYZn0h6tfC/SDT/vcsutqqjDRwrMUy0QS5w229KnLCb6e13uF7I1snLN1GPor4t
	Ocs2bFZUWj/u/WxKD9LWa1xvhGiofv3BDzHgHuRlXDh2c7ib1H/WiKjgY0tcdtqN5jS+iQqETp3uX
	DI/g+g9Q==;
Received: from 2a02-8389-2341-5b80-6bfa-ffbf-d1d1-ec94.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:6bfa:ffbf:d1d1:ec94] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sOKGN-00000004BXE-3Ofa;
	Mon, 01 Jul 2024 16:52:24 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: Keith Busch <kbusch@kernel.org>,
	Conrad Meyer <conradmeyer@meta.com>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	linux-mmc@vger.kernel.org,
	linux-block@vger.kernel.org
Subject: make secure erase and write zeroes ioctls interruptible as well
Date: Mon,  1 Jul 2024 18:51:10 +0200
Message-ID: <20240701165219.1571322-1-hch@lst.de>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Hi all,

Following discard in the last merge window, this series also makes secure
erase and discard interruptible by fatal signals.

The secure erase side is a straight port of the discard support.
Unfortunately I don't have a way to test it, so I'm adding the eMMC
maintainer as that is where the support originated so maybe they can
give it a spin?  (just do a blkdiscard -f -s /dev/<dev> and then Ctrl+C)

The write zeroes support is a bit different as it is more complex due to
the fallback code and there already is a helper taking flags that we
piggy back on.  This side has been extensively tested.

Diffstat:
 block/blk-lib.c        |  267 +++++++++++++++++++++++++++----------------------
 block/ioctl.c          |   44 +++++++-
 include/linux/bio.h    |    2 
 include/linux/blkdev.h |    1 
 4 files changed, 193 insertions(+), 121 deletions(-)
