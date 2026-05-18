Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CDFE15C14F;
	Mon, 18 May 2026 06:33:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779086035; cv=none; b=rgIIXUqyd60jJ2s72lO7YLwd9ce0mSBYuVBu2ZS/DhNlBQw+L1O81tuRVe0N1/HwEZ5RX9xG7kasGeYNUdkw1feWbc7FVpktAtyid2JHGPXmS2i38gwP0z/Qq7sPQ9PMmCKoEbnoSNKyYJ4SVHPepEY5RNcGl5QVSTdeBfsEyGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779086035; c=relaxed/simple;
	bh=j3QTDC8yDwPPtroAwXq3qr87mPdpW0/E6Oo2g7devGU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XpF+2xC+fQAf6b66m3CdXaH26m2vJzKGUz6fK3S7DB4o0PZLdqZYgwiiPxc2IvQyqKC7ou9Qf1HVJIkI0CEFtR2E+gNu7vogBE5g8Nyu2yji1+2i4AN2Bxw/AK3LLoV1qkJrPtAJpyP4XaeSVcfUUChxlYmD4b9QUWhMaGSDmCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=qC42MBdi; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="qC42MBdi"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=ZXdlojor4eZreSZvQ2niU3VpTmSTWNa557g2Qmob984=; b=qC42MBdi/sl9Vti0QiPKRYGs60
	KV05/8Lar1aBCkKsHkPlrVbQHUkjL57R0W8q3Y6Pi4ck0aYbUwHtXlv+p+bLS9gLOkEvhnjeD4RYa
	KgYh6SIOHo2ahBUZgPcQTPAeOnqCpd+y6gZa6jlJfNEMFvfHRtVLisPK49kvFVP+uFsyicNwVmQHQ
	F/pbavy9FCuYTLHGASIHYczvBude7sPzp/iDZV+PQkWz3otyepjTQC+mv1K7hBaIshUmvQCPJP6yD
	IJvQrLTuBexzbW07Hg4SnsR98zIHfFWlOdqp8oCHgIYYwyI6ldmMxRUgR0MR/mkdPRjU3u+Pk27+F
	3apjxxFA==;
Received: from [2001:4bb8:2ee:fcf2:e6ad:a575:3e60:e254] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wOrXy-0000000ERIM-0iur;
	Mon, 18 May 2026 06:33:50 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org,
	linux-block@vger.kernel.org
Subject: [PATCH 2/2] block: don't set BIO_QUIET for BLK_STS_AGAIN
Date: Mon, 18 May 2026 08:33:30 +0200
Message-ID: <20260518063336.507369-3-hch@lst.de>
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

Commit abb30460bda2 ("block: mark bio_wouldblock_error() bio with
BIO_QUIET") added this to suppress buffer_head warnings, but neither
when this commit was added nor now any buffer_head using code actually
ever sets REQ_NOWAIT which can lead to BLK_STS_AGAIN.

Remove the special handling for now.  If we ever plan to use REQ_NOWAIT
for buffer_head based I/O we're better off handling BLK_STS_AGAIN in
the completion handler as it actually needs to retry the I/O as well.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 include/linux/bio.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/include/linux/bio.h b/include/linux/bio.h
index 85463981d0f5..7597ae4dc52b 100644
--- a/include/linux/bio.h
+++ b/include/linux/bio.h
@@ -379,7 +379,6 @@ static inline void bio_io_error(struct bio *bio)
 
 static inline void bio_wouldblock_error(struct bio *bio)
 {
-	bio_set_flag(bio, BIO_QUIET);
 	bio->bi_status = BLK_STS_AGAIN;
 	bio_endio(bio);
 }
-- 
2.53.0

