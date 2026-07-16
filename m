Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 342163BED1F;
	Thu, 16 Jul 2026 09:18:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784193523; cv=none; b=j2mw5+jnryGAYAGp6Blg+aoekXC3cm1A1FLnnsznF3Y4wjuaMMhwVS07uk87vFgMDqoWWXPwmkZFXt8f6es/DKThol+fcApVpFfKU8KmVxQ2wh1NpwmuFva1AjWZxTTfQtHoGaTQ8lV0ksGITHKmiqMgJ6eY0eJ3E+JRcjn0eVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784193523; c=relaxed/simple;
	bh=yzhYtq5excvnAjlDefACM8M43Mwi/AtWgv16F0zyTk0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jddkuzzLOa4AHcbtU+zLX3wcK9QZqsyXldZ+AVCLBlwms+/Vt1E12m9HQB1KZdcw7To+EAVAGmB3684nVKNQ1PG/MvTW7A6DbHNVn6q8HKMetO23sauWupKtBeOk+d1RYqq2XzUpG8VOlcaRUOP2Cj290MhuVH1OuAhVXnKOy2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=C6p4tFKv; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="C6p4tFKv"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=S2UYwSFierpIGFXsrLko62JtkINry70zJtB9MXXXhq0=; b=C6p4tFKvJqwZBoozeQ94W4PdW3
	QZQZGXPByxZo/eWIwImJyDLgOPPBudIyyse+VG3DUhOWE/aP2Xa9GqjV924gmZBHCH/rO1YValIIw
	ZnU1OR4Hm0go+7v4w5/QGMXbGHwVpybm57Q4A/d5iBZ+Rg4RnVOIsF24d08mmLnPCG7DE7Bi+izcS
	uiA4ECTP1efOWn5YxCzttZRnng45QRqMlLydJM1cEXSB2xAzyonLY+bGZD8jteoEdntvB6iQfGmSy
	pqEWsfdgSBhxQDWYD8D3lRxagkxkBG1immbJeEWKPF2hdJSKLshP8+ZH2+MfmTnV6u1jtv4xeeJvy
	fJvRLMEQ==;
Received: from 2a02-8389-2301-9f00-b29a-36e9-8c1c-0994.cable.dynamic.v6.surfer.at ([2a02:8389:2301:9f00:b29a:36e9:8c1c:994] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wkIEq-0000000GqBn-3Hww;
	Thu, 16 Jul 2026 09:18:41 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: Damien Le Moal <dlemoal@kernel.org>,
	linux-block@vger.kernel.org,
	io-uring@vger.kernel.org
Subject: add a ZONE_RESET_ALL uring cmd v2
Date: Thu, 16 Jul 2026 11:17:46 +0200
Message-ID: <20260716091838.318082-1-hch@lst.de>
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

this series adds a new ZONE_RESET_ALL uring cmd, and cleans up the
io_uring discard support and the block layer zone management code a
little bit in preparation for that.

This command is useful to speed up workloads that need to initialize a
large number (or even a small > 1 number) of disks.

Diffstat:
 block/blk-core.c            |    6 +++-
 block/blk-zoned.c           |   30 ----------------------
 block/ioctl.c               |   60 ++++++++++++++++++++++++++++++++++----------
 include/uapi/linux/blkdev.h |    1 
 4 files changed, 53 insertions(+), 44 deletions(-)
