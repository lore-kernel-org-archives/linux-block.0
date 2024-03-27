Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4CBD14D6E9
	for <linux-block@vger.kernel.org>; Wed, 27 Mar 2024 17:21:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711560118; cv=none; b=IU914O0A7SivzZHf8XFkbzsIR9cpDQ0em4DIi7Gr5aJl3sY8xUOKZHkI15azKFMnbDi6QwhGUVhUqMWUgWCPsK2TXqGth7vONi+4AeRa+YsuKZ0syTTaKR+eXWfuBgU+LMGkM4lPLSPaKsSIsiyW/RMcDnWnRqpsUus4suJB6Ok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711560118; c=relaxed/simple;
	bh=2y6qqpnua++1bY+LO4H78bijPUkjALGOJS2mDwO+RFA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=i6s6LyaZJNufkxvP+5FfyRfpxPP3d7zLYONWa9cZ0IUk9R6Cp3g0y2rI4t8ip/hHhe0gxuopor9UzplTuBQLYZJDqLN9qDddSdKJatMVdjEgBx8x2qhT18Yyzah8/V0NO8qCaxCppp93btQvAWpG1I5y7bpeCoIKB8Xtp0KkrWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=lAPuHZbZ; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="lAPuHZbZ"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=JMfSUduTvICr0rbJirGIevmfZNskKYKvkkydG+5NhaE=; b=lAPuHZbZqLp08IKMcJY34H/pKG
	lCyhInqGd0VdsJFnGLyjgTjEMppMC2lfMSdSIfjw2/im205r/BUDN/WCaJzmIuUeXYRGF6cFNB44X
	i4G6KoaKsbMdr/eRU9wv8cHsM4/H9CjsKYZts5r3jolVzqpocIeq4waqSph9oT90UfBIcWUMmGIga
	+MlzQWwYUlr2OapOIv1pJowplEkHOqMxEujAbSKWQ2zSXOsgXN8GJWvS+449/rpeUmUWsdXbz/WA+
	9b2DL6CODJKsPQUO4irWvfeTw4MMRvCSHDUtb4crJUNa014TAzTHt/NqnQf2et4B+ZOhtMFGBytwj
	W/+wIgYw==;
Received: from 089144220178.atnat0029.highway.webapn.at ([89.144.220.178] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rpWyH-0000000AH6Y-3LKX;
	Wed, 27 Mar 2024 17:21:54 +0000
From: Christoph Hellwig <hch@lst.de>
To: axboe@kernel.dk
Cc: kbusch@kernel.org,
	sagi@grimberg.me,
	linux-nvme@lists.infradead.org,
	linux-block@vger.kernel.org,
	Kanchan Joshi <joshi.k@samsung.com>
Subject: [PATCH 2/2] nvme: cancel the queue limit update when nvme_update_zone_info fails
Date: Wed, 27 Mar 2024 18:21:45 +0100
Message-Id: <20240327172145.2844065-2-hch@lst.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240327172145.2844065-1-hch@lst.de>
References: <20240327172145.2844065-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Starting an atomic queue limits update takes a mutex and thus needs
to be finished, or with the newly added helper, canceled to not leak
the lock critical section.

Fixes: 9b130d681443 ("nvme: use the atomic queue limits update API")
Reported-by: Kanchan Joshi <joshi.k@samsung.com>
Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/nvme/host/core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 943d72bdd794ca..f8a9565bee41d2 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -2115,6 +2115,7 @@ static int nvme_update_ns_info_block(struct nvme_ns *ns,
 	    ns->head->ids.csi == NVME_CSI_ZNS) {
 		ret = nvme_update_zone_info(ns, lbaf, &lim);
 		if (ret) {
+			queue_limits_cancel_update(ns->disk->queue);
 			blk_mq_unfreeze_queue(ns->disk->queue);
 			goto out;
 		}
-- 
2.39.2

