Received: from forward201b.mail.yandex.net (forward201b.mail.yandex.net [178.154.239.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A17A18E025
	for <linux-block@vger.kernel.org>; Wed, 13 May 2026 07:05:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778655939; cv=none; b=H2aknq0PcdqOmef9WTUgAGhmTeICO/ahvSkItlth4PqaRV7Nn2351u609f70qvZouEt8rq5Pp8NXA1fgoiudf21HlcSfYvhUhMlStTr1IhZjc4h4Am+yOTiTQxYz0mIlcbOMpgfrb5ATaa5RPNVZcSf+jSSKiUvjNcvnJjZGSsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778655939; c=relaxed/simple;
	bh=shODB+zfPSlL/9axeKYgINsS80yow8aTFBcBKvIUdNg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=C55lLCRgvsfSFrxWTWTIwOR3n5dMCr/W9Pp4om19eDHiwCkxk/ctKuxyjBGScc3qW23KO7Lw11y0eJ+3x1Q+r1olRsJX/dcJU90AlhhKwkt/7IUcPHWG/GzoQWMS1wcxslHcMt94l1wGAB0foc9UYriEx3hShu26igOrJeTbsGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru; spf=pass smtp.mailfrom=yandex.ru; dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b=IeKcbsGe; arc=none smtp.client-ip=178.154.239.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b="IeKcbsGe"
Received: from forward101b.mail.yandex.net (forward101b.mail.yandex.net [IPv6:2a02:6b8:c02:900:1:45:d181:d101])
	by forward201b.mail.yandex.net (Yandex) with ESMTPS id 50971C5E1B
	for <linux-block@vger.kernel.org>; Wed, 13 May 2026 10:05:31 +0300 (MSK)
Received: from mail-nwsmtp-smtp-production-main-57.sas.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-57.sas.yp-c.yandex.net [IPv6:2a02:6b8:c1e:478a:0:640:bc50:0])
	by forward101b.mail.yandex.net (Yandex) with ESMTPS id AF5A3C00F9;
	Wed, 13 May 2026 10:05:22 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-57.sas.yp-c.yandex.net (smtp) with ESMTPSA id K5FfqbCSWqM0-lEjRhdjr;
	Wed, 13 May 2026 10:05:21 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
	t=1778655921; bh=7lrwf2pfZ9QJ0zIageGlT0y9KS0M3GnO4JbDoqXkYtM=;
	h=Message-ID:Date:Cc:Subject:To:From;
	b=IeKcbsGebtDoLNlZaS88anIxIutyc2pAZhUIfShDQfsxaNH9ojx4kezJHl98TYAqB
	 JSh1WEjoLWC4SJJHPREZnk4Lidd+WGKwzPRLT/bAmHbKN+0eRY3cwENKyDZCPwzR2N
	 ByPklhE4QXquPmb1towG0niZSiKzQF/3a8g494gU=
Authentication-Results: mail-nwsmtp-smtp-production-main-57.sas.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
From: Dmitry Antipov <dmantipov@yandex.ru>
To: Jens Axboe <axboe@kernel.dk>
Cc: Weidong Zhu <weizhu@fiu.edu>,
	Chao Shi <cshi008@fiu.edu>,
	Sungwoo Kim <iam@sung-woo.kim>,
	Dave Tian <daveti@purdue.edu>,
	Keith Busch <kbusch@kernel.org>,
	Caleb Sander Mateos <csander@purestorage.com>,
	Christoph Hellwig <hch@lst.de>,
	linux-block@vger.kernel.org,
	lvc-project@linuxtesting.org,
	Dmitry Antipov <dmantipov@yandex.ru>
Subject: [PATCH] block: bio-integrity: fix memory leak in bio_integrity_map_user()
Date: Wed, 13 May 2026 10:05:15 +0300
Message-ID: <20260513070515.528861-1-dmantipov@yandex.ru>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since 'iov_iter_extract_pages()' may allocate new array of pages
even when it returns non-zero error value, matching cleanup with
'vfree()' should be performed on all return paths afterwards. So
adjust 'bio_integrity_map_user()' to ensure that both 'pages' and
'bvec' arrays are always freed on return.

Fixes: 8582792cf23b ("block: bio-integrity: Fix null-ptr-deref in bio_integrity_map_user()")
Fixes: 492c5d455969 ("block: bio-integrity: directly map user buffers")
Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
---
 block/bio-integrity.c | 21 ++++++---------------
 1 file changed, 6 insertions(+), 15 deletions(-)

diff --git a/block/bio-integrity.c b/block/bio-integrity.c
index e796de1a749e..53fb04adb09b 100644
--- a/block/bio-integrity.c
+++ b/block/bio-integrity.c
@@ -400,7 +400,7 @@ int bio_integrity_map_user(struct bio *bio, struct iov_iter *iter)
 	ret = iov_iter_extract_pages(iter, &pages, bytes, nr_vecs,
 					extraction_flags, &offset);
 	if (unlikely(ret < 0))
-		goto free_bvec;
+		goto out_free;
 
 	/*
 	 * Handle partial pinning. This can happen when pin_user_pages_fast()
@@ -414,16 +414,12 @@ int bio_integrity_map_user(struct bio *bio, struct iov_iter *iter)
 			for (i = 0; i < npinned; i++)
 				unpin_user_page(pages[i]);
 		}
-		if (pages != stack_pages)
-			kvfree(pages);
 		ret = -EFAULT;
-		goto free_bvec;
+		goto out_free;
 	}
 
 	nr_bvecs = bvec_from_pages(bvec, pages, nr_vecs, bytes, offset,
 				   &is_p2p);
-	if (pages != stack_pages)
-		kvfree(pages);
 	if (nr_bvecs > queue_max_integrity_segments(q))
 		copy = true;
 	if (is_p2p)
@@ -434,15 +430,10 @@ int bio_integrity_map_user(struct bio *bio, struct iov_iter *iter)
 	else
 		ret = bio_integrity_init_user(bio, bvec, nr_bvecs, bytes);
 	if (ret)
-		goto release_pages;
-	if (bvec != stack_vec)
-		kfree(bvec);
-
-	return 0;
-
-release_pages:
-	bio_integrity_unpin_bvec(bvec, nr_bvecs);
-free_bvec:
+		bio_integrity_unpin_bvec(bvec, nr_bvecs);
+out_free:
+	if (pages != stack_pages)
+		kvfree(pages);
 	if (bvec != stack_vec)
 		kfree(bvec);
 	return ret;
-- 
2.54.0

