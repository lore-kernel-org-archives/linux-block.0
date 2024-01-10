Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E452C8BF7
	for <linux-block@vger.kernel.org>; Wed, 10 Jan 2024 05:16:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p8f4c3My"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 116C9C433F1;
	Wed, 10 Jan 2024 05:16:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704863761;
	bh=4iThx6V5nwSRXP8pDARsS/T+kPME/uMXlyT7w2V5UfQ=;
	h=From:To:Subject:Date:From;
	b=p8f4c3MyupHQH4tLBJhX2drG0l/amKdtjJy+ZYDXGdF8pa0so/fIw6Q8XDCPDUjNy
	 lVbXGaYceiTW8+nQv4WBKZ/dRiZMmjhrib8NLrxdbE1fjXIgSFy8pcNlDHFvyRa+9g
	 4a0PrC1I13ZH9ZjYc4YJqf8hbrC8hC3ZgWwZyaZIRkoyszq4UfWsttEqEtOllrVWES
	 iOe9C25HSx4tAPcUqOaAIjBH4y3cbqJt+dtGkpOBFyjFUpFrQl2IuHwTxjQNo5pZ8O
	 N4GuDFEdsQbjuRdYyOpvoc5rccjMBndegtflWhOtmK0DbSFbiNTRrhXhNxj7BUNeVP
	 Yig66EdnqFuUg==
From: Damien Le Moal <dlemoal@kernel.org>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Subject: [PATCH] block: fix partial zone append completion handling in req_bio_endio()
Date: Wed, 10 Jan 2024 14:15:59 +0900
Message-ID: <20240110051559.223436-1-dlemoal@kernel.org>
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
equal to the BIO sizei, thus ensuring that bio_endio() is called.

Fixes: 297db731847e ("block: fix req_bio_endio append error handling")
Cc: stable@kernel.vger.org
Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
---
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

