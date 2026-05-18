Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB5443C4562;
	Mon, 18 May 2026 06:33:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779086030; cv=none; b=INW5iVYQPlS3PIqe5cT/IfMS5nRoJ0WkyFm71OM+IdW9EUPcdxSfCROa/1kOG+bCHGiJqJt3eR8FDv51jeAX4Y4E22xUpek02rLoR7ziv1ofZ2Dv2Ev6UqdYfD0+5vkvqGwSb5V2m8NnKA/wEem9IcQBmb+8qapfSi6RgM5KUBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779086030; c=relaxed/simple;
	bh=kCNPyhQsU4DT2p47yGeY2ujPAxTvnr0F9pRXrE8znO8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZuFqVb3kykwwNW1QJ/HeURJfnCo5BanDAdygs24jz5vMN0p6Q7aVSi3/0hXP0piJKXhaTJKXm4rxErwSG+IK4xDvq3I1W32I6TsZc69DaMs8rgxzFYmLk5kVlDwFJnuMFiWh34O8CExqu2iGVCn1KoV30DAyDmiN6gXt3HIPFrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=n+QdEwp7; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="n+QdEwp7"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=EpphbZFi5DBuUyc7cvVtg3kM9Ux40AdpzJPs7VtdLSA=; b=n+QdEwp7/R7Vev1REhxVdO7qbC
	ST00kEER1ixux8len1eJfzJt5zOFOvR9zp3P/slRB6pdWsRy81VCg3fYeqk9mG6ble4jaNVVj9Enu
	NqSVasfG3AYmZ48JkVApW3TksQig05qLsa3UAZpR0MvAizFrLFVfDHFypipoxuCex4Nfc964ZcFmu
	gjhbAUxNZVo7drFON32hGdAziCjadf3tzXwIu/Rvpg7yMjBlTXngUbFuusmrmis4i5nnmVg+TP6gO
	W8VzFqDWSYME5Zydcw+j7r+On+V7SkPd+93enemjKlV/8OymfnkCoIs5i9eASspJDdHWFPEBiVjO7
	uKSjx3Pw==;
Received: from [2001:4bb8:2ee:fcf2:e6ad:a575:3e60:e254] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wOrXs-0000000ERHF-2PDx;
	Mon, 18 May 2026 06:33:45 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org,
	linux-block@vger.kernel.org
Subject: [PATCH 1/2] direct-io: remove IOCB_NOWAIT support
Date: Mon, 18 May 2026 08:33:29 +0200
Message-ID: <20260518063336.507369-2-hch@lst.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260518063336.507369-1-hch@lst.de>
References: <20260518063336.507369-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

None of the file systems using the legacy direct I/O code actually sets
FMODE_NOWAIT, and if they did this would not work, as the write locking
could not handle the retry.  Remove this dead code.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/direct-io.c | 15 ++++-----------
 1 file changed, 4 insertions(+), 11 deletions(-)

diff --git a/fs/direct-io.c b/fs/direct-io.c
index 2267f5ae7f77..9e4976716985 100644
--- a/fs/direct-io.c
+++ b/fs/direct-io.c
@@ -502,12 +502,8 @@ static blk_status_t dio_bio_complete(struct dio *dio, struct bio *bio)
 	const enum req_op dio_op = dio->opf & REQ_OP_MASK;
 	bool should_dirty = dio_op == REQ_OP_READ && dio->should_dirty;
 
-	if (err) {
-		if (err == BLK_STS_AGAIN && (bio->bi_opf & REQ_NOWAIT))
-			dio->io_error = -EAGAIN;
-		else
-			dio->io_error = -EIO;
-	}
+	if (err)
+		dio->io_error = -EIO;
 
 	if (dio->is_async && should_dirty) {
 		bio_check_pages_dirty(bio);	/* transfers ownership */
@@ -1178,13 +1174,10 @@ ssize_t __blockdev_direct_IO(struct kiocb *iocb, struct inode *inode,
 		dio->is_async = true;
 
 	dio->inode = inode;
-	if (iov_iter_rw(iter) == WRITE) {
+	if (iov_iter_rw(iter) == WRITE)
 		dio->opf = REQ_OP_WRITE | REQ_SYNC | REQ_IDLE;
-		if (iocb->ki_flags & IOCB_NOWAIT)
-			dio->opf |= REQ_NOWAIT;
-	} else {
+	else
 		dio->opf = REQ_OP_READ;
-	}
 
 	/*
 	 * For AIO O_(D)SYNC writes we need to defer completions to a workqueue
-- 
2.53.0

