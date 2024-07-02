Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DA471BB6A0
	for <linux-block@vger.kernel.org>; Tue,  2 Jul 2024 15:10:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719933059; cv=none; b=h1yytyjApQG/xTSn7EWyfhaUhSrBRlBq1OGrEJwTPXh8uE5B18XdN+QYjrT1OQBtpVohpJba6meLPD7WRo0XnXWJG6CKd4DmPg/0Gre5h9gQfI5hHdrOZ30RTkKnkJ3KZ5jzRW58M1bwTagPr5C/JJHd9QosuTMHvKV+QHgEFmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719933059; c=relaxed/simple;
	bh=nvTkX70sZacyzNpQ7y51WYTL/FNQJMpq5ifElsunDkU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qBJy8lyQWISxGqzEmnvK+DesQrF16/RhSt9EGMyBKpCEk23kvFIbJf92AIP9dsRWFZVL07nkSdhZ7XYxkrD87s783XDk9EiYf2mUDnGt6duQmSGYhjqn83b7OaVDIKrxjZkvMPrsAdsOzRSXegD4nP9KPhLMJE87XKt1VYP9trk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=ptokIS4T; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ptokIS4T"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=hIGUP22CMXhQJHh5zIIR2ZxDvxkUYfILjr/RfURYB+Q=; b=ptokIS4Tdvv/G+4BVtlKjM74Re
	k3E9UsWNfgF2fUYSl5K3A6uQ9GAvWxfHrIqdpeL7CQw1JcTTTmv7Fi3vwTOdW+7Za/5KCFhMO20un
	ASROFhFFtLzlaE9Cu9UreyelINQuedWwAiLrc1Z4C8bNFmx9kaE3+kAI4A5xyCiYLGBecxvXc122m
	zGPSV4/ZN0qYSl5n08wlzoUl+5/6cG16Z5S+ZX98o/Viy7QNG6IyV0fEntllzCt92L/Q8fMZmXUli
	r8KdRg8TPa8tvOdtZ4KLpqAqP6FsHUtHVxJScDoPmpaM8Gic3RQzqXZ7FFe0v8bLA7MHuDlYeQLJu
	c730grtw==;
Received: from 2a02-8389-2341-5b80-4c69-cf21-4832-bbca.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:4c69:cf21:4832:bbca] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sOf9l-000000079UR-1Xkq;
	Tue, 02 Jul 2024 15:10:57 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: "Martin K . Petersen" <martin.petersen@oracle.com>,
	Anuj Gupta <anuj20.g@samsung.com>,
	Kanchan Joshi <joshi.k@samsung.com>,
	linux-block@vger.kernel.org
Subject: [PATCH 3/6] block: don't call bio_uninit from bio_endio
Date: Tue,  2 Jul 2024 17:10:21 +0200
Message-ID: <20240702151047.1746127-4-hch@lst.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240702151047.1746127-1-hch@lst.de>
References: <20240702151047.1746127-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Commit b222dd2fdd53 ("block: call bio_uninit in bio_endio") added a call
to bio_uninit in bio_endio to work around callers that use bio_init but
fail to call bio_uninit after they are done to release the resources.
While this is an abuse of the bio_init API we still have quite a few of
those left.  But this early uninit causes a problem for integrity data,
as at least some users need the bio_integrity_payload.  Right now the
only one is the NVMe passthrough which archives this by adding a special
case to skip the freeing if the BIP_INTEGRITY_USER flag is set.

Sort this out by only putting bi_blkg in bio_endio as that is the cause
of the actual leaks - the few users of the crypto context and integrity
data all properly call bio_uninit, usually through bio_put for
dynamically allocated bios.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/bio.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/block/bio.c b/block/bio.c
index 4ca3f31ce45fb5..68ce75fd9b7c89 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -1630,8 +1630,18 @@ void bio_endio(struct bio *bio)
 		goto again;
 	}
 
-	/* release cgroup info */
-	bio_uninit(bio);
+#ifdef CONFIG_BLK_CGROUP
+	/*
+	 * Release cgroup info.  We shouldn't have to do this here, but quite
+	 * a few callers of bio_init fail to call bio_uninit, so we cover up
+	 * for that here at least for now.
+	 */
+	if (bio->bi_blkg) {
+		blkg_put(bio->bi_blkg);
+		bio->bi_blkg = NULL;
+	}
+#endif
+
 	if (bio->bi_end_io)
 		bio->bi_end_io(bio);
 }
-- 
2.43.0

