Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BC6D3C489
	for <linux-block@vger.kernel.org>; Mon,  6 May 2024 04:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714969234; cv=none; b=JyXH8MSoDUEVBR/b+v37A29GKx14uTfWnHLgYQ5CD1WTK8zIrT2SPCtUCFJ/jnGDgrShQAYg9sEdHDsm4L9rGbR46tXk0SFUNJfL2E60ALwtEjbF3nLLbIbpTNoL8+Zq6rclVbanPrI54dWTfSeWjmFhLO4QrTcDr7mLxjo+ZMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714969234; c=relaxed/simple;
	bh=OCCgyTKxoXoan4KeRcURdG9fTwIyq01NX5xc2Il5sAM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ZtGbHY4gA4ljIq/qsGrkks7g4j7ZMoYWrhyACRXt9iTQzV0ihDGwCM0w+LVNHwiUlMjojQih7ZNzy68KfBpVeSGIwB4GXUUiwg65IYQ02u1GRe0KOmnEYQkTR60IaEDd9uOFN9OujfjN4cXGkUGRTf0BEB2X+CPxjNRH8WHtez0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=VRwzMvTh; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="VRwzMvTh"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=tv8qdYLrVgnITfCJ8E/Z5Vkq+L5nxWarEBS9VVodZiU=; b=VRwzMvThLSFC+uiFVIFjnflRZq
	ZScHeb1eesNEcocmfkcOJynBPzTqQkC83nM6PWxpc4azKgPWvcytMpl93i3Duc3xadNqiJb9au6Ib
	wCjSXhvzGa3dL70iG+9M/kUyEYWCrCerakoeVF7kRBAHr4vqC9MApy25vrTba+7ycaZSUxnLw/1Mv
	EPxMEMyKEm3vX7MgxsKL5JFC3ETT1Cb/dSqobgLeeTQmDwjYMRXuApnRUmlqZHP0KlwOsWCMcK6fy
	1V1w29YQt9+UNV7pNCM29AiVEk0PJc2oJSmRkkeCqAgecUih4cgn18PwfzLTgd1bsaFq8vz5T01o4
	YSjlRONw==;
Received: from [2001:4bb8:188:7ba8:c70:4a89:bc61:3] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s3pq1-000000060Js-0qPi;
	Mon, 06 May 2024 04:20:29 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: Keith Busch <kbusch@kernel.org>,
	Conrad Meyer <conradmeyer@meta.com>,
	linux-block@vger.kernel.org
Subject: next try at interruptible BLKDISCARD
Date: Mon,  6 May 2024 06:20:21 +0200
Message-Id: <20240506042027.2289826-1-hch@lst.de>
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

this tries to resurrect Keith's series to allow fatal signals to
interrupt discards, after first refactoring the low-level code so
that calls from fs code do not get interrupted unexpectedly.

Unlike the original series it only handles discards.  Write zeroes
and secure discard could get the same treatement, but I'd rather
sort out the discard side first.
