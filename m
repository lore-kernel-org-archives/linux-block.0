Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8AFF3CB8F0
	for <linux-block@vger.kernel.org>; Mon, 22 Jun 2026 16:07:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782144480; cv=none; b=SntVZuaLqxJb+d41Q6iWrVQJjQQdAf7s3l8NI8mT7JPA9ShqVZQn7qbdhaHT1oTHX+w5oZ2hiSfd7cXP/6mGpxlpFf5A0y+7M+ObJPSVCaqLEbXJhBVKdHOQlTWqd/pugwo0TrTRbRdWlPYIjhtcwb0kl3SNbAObeCXkLqevhd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782144480; c=relaxed/simple;
	bh=YArXz+rViJVr5RPisilRcRfT+ofid+qgGCLbW/JFZ0s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=F5RlUja/NZlIfATOk8OWslQEHpmpl8QHzoT82eV0OIE5OAFlsohPE7IImkHyPJwwkWD4y1GJzrDh7gHzezk73+8h9OSX2l64SPBDXR+oiYaU5uV59MDt0T5+2mdTMwuSlpXQRjjld+70MEmwU7LTL/WcTdgCMGC0vIaRDDMbHDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=dmrPW2cj; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="dmrPW2cj"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=HohAlCWQPolK/mJU3tAB/TaiWAc9G3OQ5DTX7sBoBwY=; b=dmrPW2cjn9/kwu6Evi9ur2SD+N
	2cNwGkFkNvmzjUO1D9MahxrwfjF/6wBxlxSId+Fm2dXNPOKKa59gTsLjyd8DOIUllL3YmXFdZXe0N
	JSDY7+F/pU9CdaE5S+oFapiHKtNA5OySp5uXQIznVUnwMNwVGsrm6cWCsjxM+SXnVdn7HWmYn8AKT
	dknkZ/mPZBM+/qOd1vJXvt9H/lSoCCP/9uVANql0I48y+fE07c8+egZjkfOqXWBl8p24699T3anV1
	t4icP+m6AoMALeE+Af+azVkY5cCrrBL6agiXjfrUyHeo3pEYlhydfloO1n1F5dqCKsrtyv6BUxj1A
	Y+2xyO/Q==;
Received: from [2001:4bb8:2ea:7da1:ebb4:65ed:3162:8230] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wbhBj-00000005ANt-291w;
	Mon, 22 Jun 2026 16:07:55 +0000
From: Christoph Hellwig <hch@lst.de>
To: axboe@kernel.dk
Cc: dlemoal@kernel.org,
	linux-block@vger.kernel.org
Subject: [PATCH] block: fix incorrect error injection static key decrement
Date: Mon, 22 Jun 2026 18:07:52 +0200
Message-ID: <20260622160752.1552516-1-hch@lst.de>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Only decrement the static key when we had items and thus it was
incremented before.

Fixes: e8dcf2d142bd ("block: add configurable error injection")
Reported-by: Damien Le Moal <dlemoal@kernel.org>
Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/error-injection.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/block/error-injection.c b/block/error-injection.c
index d24c90e9a25f..cfb83138960c 100644
--- a/block/error-injection.c
+++ b/block/error-injection.c
@@ -120,13 +120,13 @@ static void error_inject_removeall(struct gendisk *disk)
 	struct blk_error_inject *inj;
 
 	mutex_lock(&disk->error_injection_lock);
-	clear_bit(GD_ERROR_INJECT, &disk->state);
+	if (test_and_clear_bit(GD_ERROR_INJECT, &disk->state))
+		static_branch_dec(&blk_error_injection_enabled);
 	while ((inj = list_first_entry_or_null(&disk->error_injection_list,
 			struct blk_error_inject, entry))) {
 		list_del_rcu(&inj->entry);
 		kfree_rcu_mightsleep(inj);
 	}
-	static_branch_dec(&blk_error_injection_enabled);
 	mutex_unlock(&disk->error_injection_lock);
 }
 
-- 
2.53.0

