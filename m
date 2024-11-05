Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B760810F2
	for <linux-block@vger.kernel.org>; Tue,  5 Nov 2024 15:48:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730821705; cv=none; b=JQkKPKSbBB99ANOcf2VZ1b1trBFycZf0Fnh5Q4qDv+UdEzKmfgFZJelkd34kmedxcnHpu8BFxPyjtEYetHTqgZvL3jYJAz+YVsjAxNBzAy9oirgRpmR/6RLYrS6STHC7R8uEf+pS1MJQDew/cCHjt2WefcZFm3bTZTmd07scxHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730821705; c=relaxed/simple;
	bh=sGpfSVfyBxqGVOK5nlg4PA7afiUnj3/nIHmwnPueg8M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PV0SnmD8XotBwT4z6yexilRS6yQracVnGkVxxPWamYju1e3oEqOvHRY0538iGgtHYHZhTtHwzFDN3qaxeKBfvslPZJdV9Mz65xQ2msKWdrMtfubOHJn96UrfmUPhfnSDbVpsSYhq2wLPiccAVNj5qca1qu4IndrOsI2sSFKLbdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=0SZBcxBl; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="0SZBcxBl"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=KP3CTny6X4EF5DpZpN8B26kZWuQaY04gUk1NU+oW06I=; b=0SZBcxBl1RDwwrz2U68gdYEpNR
	ou82NU/dI+gq6B8W0wFHKCLGmupDk9WrncY0pWWAhBfYPqT8yPisHlf/LuGTQPS7ScD7aNOWqcOpR
	mBMcIh3K+4Dd391taXbCnkr85F0GGbu050+QVZWwBkliTpQc0fvoiOTE08WPQXPr9pYN8E3Z0kOg2
	MTGVLerX8/i2AQIIj7OsWdxHSNrj+aoiZCiVu0vJr45V+5XBUIn+LF+uM/Xv1XiFD2SVRaMRns4WC
	0ZxRPNXEGMSzD+XWPRY4spTArLYcUOPcEmK6kZvW1XnRIhQN4M+J9qNOfHnAXFg+csFYwhjeJ2E7y
	klzrJR/Q==;
Received: from 2a02-8389-2341-5b80-f6e3-83d3-c134-af6a.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:f6e3:83d3:c134:af6a] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1t8Ln3-0000000HU7n-0kSS;
	Tue, 05 Nov 2024 15:48:21 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	Yi Zhang <yi.zhang@redhat.com>,
	linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org
Subject: max_hw_zone_append_sectos fixes
Date: Tue,  5 Nov 2024 16:48:10 +0100
Message-ID: <20241105154817.459638-1-hch@lst.de>
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

this series has a fix and a cleanup for the max_hw_zone_append_sectors
change.

Diffstat:
 block/blk-settings.c          |    2 +-
 drivers/nvme/host/multipath.c |    2 --
 2 files changed, 1 insertion(+), 3 deletions(-)
