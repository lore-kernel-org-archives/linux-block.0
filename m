Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C57323B9DBC;
	Mon, 18 May 2026 06:33:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779086026; cv=none; b=EZuxu9etqIIiIArk9q4gFyL3wIddTjCYRPmWDlRzZDco4edeuEhEjAL5LfjBJcmJOO2yPGp1XJ49gSWy+B57VpYhmtd8rdmIft8oyGn/37GkSXQnKz9vOIr79v/2sKUKl7hA/rxjRhaGI7kaxP8vMitFcrGdCneH6vvzEQRqlDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779086026; c=relaxed/simple;
	bh=gt8XKWfljLAB9/OFF/KXPvNi/Jsv9U5Y4sRf6sQAJMc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VcPJ5ctR8immi30Rb9RmxmfxoZcWfWpNrze/X6DzVt8zAuCCBOCySDBWpBJHf+vgpkY4bSniCkI7AH8iPKj4tUiNQstaKD8xzutf20SJKBNfvOLbseOn7LDtf3tnEKt/VZ99TCGZihx2RMvwZ0PwTcHgpFuEcp7ERcm7Ngd+zps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=0OFdiG0t; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="0OFdiG0t"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=mwocczjneN0nYOvRUdHCQdGt6CQo07Df3dVOockggJw=; b=0OFdiG0tyzBJEF7sCSNdyXdksy
	kdbe8DPeOWYqGnd4zPnHvW/GGjOWv8M6MyEJuGp3ZPcdiBcf6JAAXbPe4VHiUaamqY1xi8Pa9o7uF
	aRE1W8tcqvNkiAmSoE1FE27HnC7BQEUJ54mLycQMhYal19ae8GfIgwWjvHlW6glGK9Sej6cw+gAeC
	ioLLSOl1xtN2kzWbeyM9zY1Vv6GIhrnB/gHoj2Kl5NDhzihSQLt2+ZfuqIR0J94Dd5OHdLgbPr8oK
	heWZzsE7TTraL+Hn0azFWpZORM0gqBRmgUG0hnMk23KIzyknyRHh1b07XVt5wxQhoL+PUDtrMj0L4
	WZYoB86Q==;
Received: from [2001:4bb8:2ee:fcf2:e6ad:a575:3e60:e254] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wOrXn-0000000ERGJ-44P9;
	Mon, 18 May 2026 06:33:40 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org,
	linux-block@vger.kernel.org
Subject: REQ_NOAIT cleanups
Date: Mon, 18 May 2026 08:33:28 +0200
Message-ID: <20260518063336.507369-1-hch@lst.de>
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

this series cleans up spurious code related to REQ_NOWAIT handling.

I have block layer work depending on this pending, so merging it through
the block tree would be helpful.

Diffstat:
 fs/direct-io.c      |   15 ++++-----------
 include/linux/bio.h |    1 -
 2 files changed, 4 insertions(+), 12 deletions(-)
