Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9540D3C067
	for <linux-block@vger.kernel.org>; Thu, 11 Jan 2024 13:57:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="D12AvXwH"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=ZQYiXDWdZyC3xOIAIAestUb82yDWt8JGbUxJ17xOGPY=; b=D12AvXwHb7y1mAnOXZux3yW8M8
	nQji+jtjPpl4ZzoXtKPul4oiXx5VwBub+eJKfRUjKGv+PhezYHzqHQCu0kSmWHuYbbCjTz2gKhBJq
	89mYCLy+NHaOxCR6yWxEztPSkVg8FucbCchKktxAt+vKtqi2+DK0Vz9ek8yXxH6tXGJ3oTXAr4uWd
	v/RWniUAr8fkBK7+Hc/x3YdgZI1NJOc8R34zs1TFtr3Yc2ashbyqdst3PDv1gX72PJLqr5CGZuN+N
	f1kG6X68sxweemNcz1k40blbuXvt8HyKvSFiiGbVTQquH7NVPlJwFkkVJ7qLt9j0UKcYSqt4i2nyz
	zkabM5nA==;
Received: from [2001:4bb8:191:2f6b:63ff:a340:8ed1:7cd5] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
	id 1rNvYT-000ESr-2o;
	Thu, 11 Jan 2024 13:57:10 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: Ming Lei <ming.lei@redhat.com>,
	linux-block@vger.kernel.org
Subject: ensure q_usage_counter is held over bio splits
Date: Thu, 11 Jan 2024 14:57:03 +0100
Message-Id: <20240111135705.2155518-1-hch@lst.de>
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

current blk_submit_bio can call into the bio splitting code without
q_usage_counter held, which can lead to inconsistent limits beeing
applied for drivers that change the limits at runtime.

The first patch in the series is a small comment and naming cleanup,
and the second one ensures we always hold q_usage_counter before
even entering blk_mq_submit_bio.

Diffstat:
 blk-core.c |   14 +++++++++-----
 blk-mq.c   |   59 ++++++++++++++++++++++++++++-------------------------------
 blk-mq.h   |    2 +-
 3 files changed, 38 insertions(+), 37 deletions(-)
