Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 799D31CFB3
	for <linux-block@vger.kernel.org>; Wed, 10 Jan 2024 09:29:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b9INwKJr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 898D1C433C7;
	Wed, 10 Jan 2024 09:29:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704878983;
	bh=JcxqSMf8VGMXt3fkaHd1QoaQvuL0L+ESrmWCCWgJ3Es=;
	h=From:To:Subject:Date:From;
	b=b9INwKJrL2gzQzWLRR54VSl7yN57dCkiO/7a13nSIextQMER6YwqM2Nk9HUIgjxqu
	 Ie7S0wBkELblQ1U9SUhJ7q4OaZ7X6DLpg8ck6PIo28n31SvTTFmnWor18smYEZeZTv
	 3H45mXWNNS9W/owd3U1nCSvcBh31TV0m3HxN6XqLFu49PVpG8QFBo6JpJo1dINEtiF
	 9vVoA9aeB1e3caJ+kDdvqxnfrjd/lWEqjqhYR/sDeLo5ixMdtUGMRzV1/1kd5/XzSW
	 xM+9wpnD+rgz29QjmkGS79E8nUbUn5rK8XlmRqMQNrezYVhSzDUmQ+2ceKsxdWWaGQ
	 fseQroCk2niuw==
From: Damien Le Moal <dlemoal@kernel.org>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Subject: [PATCH v2] block: fix partial zone append completion handling in req_bio_endio()
Date: Wed, 10 Jan 2024 18:29:42 +0900
Message-ID: <20240110092942.442334-1-dlemoal@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Partial completions of zone append request is not allowed but if a zone
append completion indicates a number of completed bytes different from
the original BIO size, only the BIO status is set to error. This leads
to bio_advance() not setting the BIO size to 0 and thus to not call
bio_endio() at the end of req_bio_endio().

Make sure a partially completed zone append is failed and completed
immediately by forcing the completed number of bytes (nbytes) to be
equal to the BIO size, thus ensuring that bio_endio() is called.

Fixes: 297db731847e ("block: fix req_bio_endio append error handling")
Cc: stable@kernel.vger.org
Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
Changes from v1:
 - Fixed typo in commit message
 - Added review tags

 block/blk-mq.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index c11c97afa0bc..cd59b172c8fc 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -772,11 +772,16 @@ static void req_bio_endio(struct request *rq, struct bio *bio,
 		/*
 		 * Partial zone append completions cannot be supported as the
 		 * BIO fragments may end up not being written sequentially.
+		 * For such case, force the completed nbytes to be equal to
+		 * the BIO size so that bio_advance() sets the BIO remaining
+		 * size to 0 and we end up calling bio_endio() before returning.
 		 */
-		if (bio->bi_iter.bi_size != nbytes)
+		if (bio->bi_iter.bi_size != nbytes) {
 			bio->bi_status = BLK_STS_IOERR;
-		else
+			nbytes = bio->bi_iter.bi_size;
+		} else {
 			bio->bi_iter.bi_sector = rq->__sector;
+		}
 	}
 
 	bio_advance(bio, nbytes);
-- 
2.43.0

