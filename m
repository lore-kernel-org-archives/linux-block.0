Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9410D79EA
	for <linux-block@vger.kernel.org>; Thu, 22 Feb 2024 07:24:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708586665; cv=none; b=NKwUwm+yNxZM5QSnqJG3pqT7ptUOHQ6RcRbaUeRfaYx3OcyGlF3PG3BYWjAM9Dyy++nm0vQo64CeEuc0N3fshWtGvqkF49lu7tvR6hDU1QxlRCWWhQt2VBGhRD7PMstEhLe+cDzHo39JZBysWMRjQObPt+IKe+9aB12M1hsFRUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708586665; c=relaxed/simple;
	bh=A+EShkHVf1kcYhfiH+bP8An2dL5ccDV9HlL0GD9IXmk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ibjiyz9W5gK66TEesoa1WSx6LhHtewW+WsQmNFJc3124sSoHyh/PuzwCynujG4bUsUqbvSwyX9yHvQp3u0svdc4hp3tKXz5f+d7aqzoHfJUrbJXy3UK0VpSwknkVQR/yd+VNM9UgGipKeaR2EP9rkDUmld/4fIhu1k1dXyBjQ7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=CnUnpoRf; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="CnUnpoRf"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=FO7DUyvF6VRHyNg2amxq7/xwMvD8CtHch2mPz+ypuO8=; b=CnUnpoRf97lzjc2YUn4S1N8gg1
	NfXDELoJF7D7Lfs6gmrsXzYu8HoRnVOJsL6mAeuFhghztfUpSjwo6BOmjhlxMEgTJErIMYvy0SfK3
	YHbC/1QIW9kRj2g0gEQlhHsMX6S/GNIo5L5A0nYUC38jH0SOxefryeU0adVqzfpCVC+71RPNMTIMp
	vo9UHCwVfCjqqGdMEVLc9IG2Si/AlehNvxouH9wcy6jEO1DJe83Jz5rbaByOvR2vdaqHMpjbzYzmM
	OlImtKBXG8bfhLTVYqCiMus1O3AFxIUXSZeqCSSF0ZaXx3TwcuMBpZqMkuEdRQSYuRtXOsLQYB9o5
	zuAY2jYQ==;
Received: from [2001:4bb8:19a:62b2:c70:4a89:bc61:3] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rd3RK-00000003ncX-45UO;
	Thu, 22 Feb 2024 07:24:19 +0000
From: Christoph Hellwig <hch@lst.de>
To: Richard Weinberger <richard@nod.at>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	Jens Axboe <axboe@kernel.dk>
Cc: linux-um@lists.infradead.org,
	linux-block@vger.kernel.org
Subject: ubd cleanups
Date: Thu, 22 Feb 2024 08:24:10 +0100
Message-Id: <20240222072417.3773131-1-hch@lst.de>
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

this series cleans up the uml ubd drivers and gets rid of more blk_queue_*
calls.  It is a against Jens' for-6.9/block branch.

Diffstat:
 ubd_kern.c |  127 +++++++++++++++++++++----------------------------------------
 1 file changed, 44 insertions(+), 83 deletions(-)
