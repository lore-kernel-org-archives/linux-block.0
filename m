Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88AFA466B5B;
	Tue, 14 Jul 2026 13:13:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784034811; cv=none; b=jgJtyLChCv7toFbZM1DOeKzyB2a1X9gCBw4FwiyHEQiT4kyC50ptjLNScz2w6lasoWHkmjolvoDVyJwJkEKhQ0EPK3EXsKvHZ+JY9YB3j8Vt8xcuxzEL1mscTpITt19b9d4QcqaGqwE0I7zWB/NAO568H0ziCupsP1Cd2gV9SjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784034811; c=relaxed/simple;
	bh=Kd8Hjq26ElAaCW1/Px99WnlOw6HZa8PySS1R0TbssT8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZSuAOcgQO0pLGJdqqi1kN2OY6ypi4xiUMcg9lkZ57bCplvRehwsk+liJ/yeA7w+4nc0nLhca+7yNFP1kDe36XNFQQoH2e3WwswzQwbkqyxR4EUnGj4tfTRftOC8OVaof3Lg57JA6JSnR++t7J+KV1yXwoVplO7pSyQQM+n2hivI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=qvXVfWPB; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="qvXVfWPB"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=5D79ZllZUvOm+6j5YQwY4jHcm9toCynPEGeNdBfStDw=; b=qvXVfWPBw+S12uxYhwqIZW4/q3
	4kMu/JMYx/VZf84g8T74vBCfL0R/Ru61Xt3wYz3CGOW/Ud/wDbMPjDTH0A9cCNKs80gA6nWW8I2XC
	qFoww0JXcG2cD55l+28uXQgoF+I792b8dIQcKXnZPyxmMpBp5fNdYu1o0aBjAtEe2gD4/NuVGInj+
	r+KafRutnuT5Pgg09wSwESuR/IW/XyMpxTysZAzSVw5guf2CZAb6Lofird/7gRp/FZI81lcsYTQrR
	vdX1tnrn0MP7JZiOcwOMGJJvg+1ryR81VhdSSagkTVVdK2WQ+FRl1ZHKDwcEyGh9tM7ticoktmvA0
	tUIAAQCg==;
Received: from 2a02-8389-2301-9f00-3397-c9eb-6d8a-9179.cable.dynamic.v6.surfer.at ([2a02:8389:2301:9f00:3397:c9eb:6d8a:9179] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wjcwt-0000000C7eX-1DB9;
	Tue, 14 Jul 2026 13:13:23 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: Al Viro <viro@zeniv.linux.org.uk>,
	Andrew Morton <akpm@linux-foundation.org>,
	Keith Busch <kbusch@kernel.org>,
	Qu Wenruo <wqu@suse.com>,
	Neptune <z1281552865@gmail.com>,
	linux-block@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: bio bounce buffering fixes
Date: Tue, 14 Jul 2026 15:11:57 +0200
Message-ID: <20260714131318.2670042-1-hch@lst.de>
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

this series fixes a few issues with the bio bounce buffering code.

The patches are on top of the "block: validate direct I/O memory
alignment" series from Keith.

A git tree with that already applied is available here for convenience:

    git://git.infradead.org/users/hch/misc.git block-bounce-fix

Gitweb:

    https://git.infradead.org/?p=users/hch/misc.git;a=shortlog;h=refs/heads/block-bounce-fix

Diffstat:
 block/bio.c         |   53 +++++++++++-----------------------------------------
 include/linux/uio.h |    1 
 lib/iov_iter.c      |   37 ++++++++++++++++++++++++++++++++++--
 3 files changed, 48 insertions(+), 43 deletions(-)
