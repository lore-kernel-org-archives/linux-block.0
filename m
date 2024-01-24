Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8FAF17BDD
	for <linux-block@vger.kernel.org>; Wed, 24 Jan 2024 09:27:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706088427; cv=none; b=jm1DlI+fcQEe6PRvfdotbPE09WLrY8/u7aJzTFXv6baSw7sct+5mW3pKoz4PZfxXpKIWSI+7TmH/t3WRXoH2m9jfly/XR7d6MWXn9Y5C+2eyCd5x0MrJxlQ+jcrJALS8BOS15x4c9GfI7CBhmyzWaGP9DBMHaLdfZbnf0+JwN7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706088427; c=relaxed/simple;
	bh=TG2fius+8l5R+piAxD1NTweIOLj+zi/3xlUjB5/FLbc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=QggK7dxK0To2mvXSi0PxKg7bF3EtFQPnPE1b8rtRzcXyMnp4wA6APYiJIAsT6OR+8BL3roH/eYzdtjT78SGVOD1ET6B1qxLeh9c2+royr/pqaLsq8HCHcnhKoPc6LagBtcZtqu5yW6QYGfsZqABYIPrIrsoo9oGuTNjm45oN004=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=p8q/ov4C; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="p8q/ov4C"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=HxWTshbT1s3nPKhi6FnZBs1z5J7U9bA5Yi6edW1xyaU=; b=p8q/ov4CN/eLffFEFVwEN1CZdi
	bCsC9djh0VekZMPvBbHoLxbmz49DtPWI7NbPQAWf42w+cSdHkpDwIfJc5ILU/ffF0kRiRYvSpdM9P
	YMNjrKRVEaJJhp0m+VjM87I6JUz1+2euVON90wrnzFVqXFM7vhTJYqxDs5pjsnIvuJxfd+udfUaXK
	rMudzaOow5fWttdGkqyYhE//UlSbcmH/XUTzU2PGGBopp4qwjgXbm9jY/4s0JCmwmHaxKWgScsusO
	2uxDo8sGui/I4ivCditNa6TnBQ5sNMf0RwrBvymGX27U7rJlZT7aM3C24DNVm2khD4vEzsRXRNI2F
	DsGjoyBQ==;
Received: from [2001:4bb8:188:3f09:9c13:25f:1e5b:57f9] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
	id 1rSZXE-002EDG-1j;
	Wed, 24 Jan 2024 09:27:05 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org
Subject: clean up blk_mq_submit_bio
Date: Wed, 24 Jan 2024 10:26:55 +0100
Message-Id: <20240124092658.2258309-1-hch@lst.de>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Hi Jens,

this series tries to make the cached rq handling in blk_mq_submit_bio
a little less messy and better documented.  Let me know what you think.

Diffstat:
 blk-mq.c |  105 +++++++++++++++++++++++++++++++++------------------------------
 1 file changed, 56 insertions(+), 49 deletions(-)
