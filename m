Received: from 003.mia.mailroute.net (003.mia.mailroute.net [199.89.3.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09BB731BCA0
	for <linux-block@vger.kernel.org>; Tue, 16 Sep 2025 20:41:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.3.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758055270; cv=none; b=nt+c72xFMwUZj53L6YV3iOn+qKBvDSYVXtYljk7z8owIXJmj9jFwxClY7xzQo717jjkus3UIftxCh5bEROQ3BsLLO5mZCHSbRlYQpDv2hgW9XePI6d4wY7INwWcymgHj/mt5YQx2WZS4iY/f6yTlJ6fHLa/seZqP0sJ9th8IrOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758055270; c=relaxed/simple;
	bh=ayGtxgYDKhrxxmde7KprFHdY0i1h8h6cBdCBUSZ30zY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=eDrUhQx9DSzc01762FP9ii3rkh3YIBAPvxdj21gPEzsWUca85y0HRU2PHNHH6bNfcZxTeyT9FjVkcEATWON6CUilNykxHK+IxskV8+fQRvGMyCWhwpRV+MpK2l9R8jSJmUF86yqv8ogeRwTcBK+FN2x4qQAWVym15UwlVzzthT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=P2mjbZY8; arc=none smtp.client-ip=199.89.3.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="P2mjbZY8"
Received: from localhost (localhost [127.0.0.1])
	by 003.mia.mailroute.net (Postfix) with ESMTP id 4cRDM222pNzlscjM;
	Tue, 16 Sep 2025 20:41:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:x-mailer:message-id:date
	:date:subject:subject:from:from:received:received; s=mr01; t=
	1758055260; x=1760647261; bh=WCX9tXwzFDkyGVim3BS2EcdnRRfHgvCkMuH
	Ree8NrlY=; b=P2mjbZY820/IWlaK/w0R4bw9WHxjalZkGILBrco6MlpS8QaxCzP
	oHBybiJFyj71x1sLQzW64nzPBF4EoORDVKuB2MxAvvAaGSehkpTI7MPGzyvhPtXW
	D1aVy0SuE/kVIEn2RsDxyZQK1zGupVRYHJs91eC0MnWvhO7rLb3c/uiPO+7E5al2
	8lhu7rhsCLUZsG5nTgwgWwktxTrejHVvWxTC1RcehfhodheBFT7gQQ/Oq601jduK
	8Jhq4TkWOKHc8w48rNUW/TL8Dmo8EtkljSsneN7J1TBCOjIegSBgz+T1FrfFLDEc
	6OgDdxCzRRjqm8JEjFDm9WUS3ceuFTKsTXA==
X-Virus-Scanned: by MailRoute
Received: from 003.mia.mailroute.net ([127.0.0.1])
 by localhost (003.mia [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id 5VTVvWUJqE-y; Tue, 16 Sep 2025 20:41:00 +0000 (UTC)
Received: from bvanassche.mtv.corp.google.com (unknown [104.135.204.82])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 003.mia.mailroute.net (Postfix) with ESMTPSA id 4cRDLv4dHjzlrwfb;
	Tue, 16 Sep 2025 20:40:54 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Bart Van Assche <bvanassche@acm.org>,
	Christoph Hellwig <hch@infradead.org>,
	Ming Lei <ming.lei@redhat.com>,
	John Garry <john.g.garry@oracle.com>
Subject: [PATCH] blk-mq: Fix the blk_mq_tagset_busy_iter() documentation
Date: Tue, 16 Sep 2025 13:40:43 -0700
Message-ID: <20250916204044.4095532-1-bvanassche@acm.org>
X-Mailer: git-send-email 2.51.0.384.g4c02a37b29-goog
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Commit 2dd6532e9591 ("blk-mq: Drop 'reserved' arg of busy_tag_iter_fn")
removed the 'reserved' argument from tag iteration callback functions.
Bring the blk_mq_tagset_busy_iter() documentation in sync with that
change.

Cc: Jens Axboe <axboe@kernel.dk>
Cc: Christoph Hellwig <hch@infradead.org>
Cc: Ming Lei <ming.lei@redhat.com>
Cc: John Garry <john.g.garry@oracle.com>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 block/blk-mq-tag.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/block/blk-mq-tag.c b/block/blk-mq-tag.c
index a63d21a4aab4..0602ca7f1e37 100644
--- a/block/blk-mq-tag.c
+++ b/block/blk-mq-tag.c
@@ -424,10 +424,9 @@ void blk_mq_all_tag_iter(struct blk_mq_tags *tags, b=
usy_tag_iter_fn *fn,
  * blk_mq_tagset_busy_iter - iterate over all started requests in a tag =
set
  * @tagset:	Tag set to iterate over.
  * @fn:		Pointer to the function that will be called for each started
- *		request. @fn will be called as follows: @fn(rq, @priv,
- *		reserved) where rq is a pointer to a request. 'reserved'
- *		indicates whether or not @rq is a reserved request. Return
- *		true to continue iterating tags, false to stop.
+ *		request. @fn will be called as follows: @fn(rq, @priv) where
+ *		rq is a pointer to a request. Return true to continue iterating
+ *		tags, false to stop.
  * @priv:	Will be passed as second argument to @fn.
  *
  * We grab one request reference before calling @fn and release it after
