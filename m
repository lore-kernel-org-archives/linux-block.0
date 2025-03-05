Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8ED52E3364
	for <linux-block@vger.kernel.org>; Wed,  5 Mar 2025 04:32:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741149126; cv=none; b=uNsH40JHN5tdWx1updijoJ1Iwg03ZC0XDVKYU/u1uPfhpf2QYKOYPKPn5HW2tu4Y2d1iZ+JCUB74XjiLYCDx7qWUrJoo+eUwLDlXTcodOESavQmnfOklrzKoQUJFdRduDaKCTIZji6/1IvyvhcLEIlsWf886f9vOcoQZwec81w4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741149126; c=relaxed/simple;
	bh=6RD7Jsyn/7cK98b0iDQ56Wn8vAgkajfZfzNXfL3xO0A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dRoDUC7o3J9gPav4U2WpeXMrshryg+ZsjIG0UBUMCI+UzLeEjp/GUggOhdzNbCWIHCXwkvdfwevEhxQ8WIR86uN4dhvaDyOj/BwMnZYEf78eUMobbWvvBrcdw9DTxzrjvvLQOC5LjoyLEEyJaAH6vlJrasObwMu5qdX9lqUvL+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gMOfjA8M; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gMOfjA8M"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741149123;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YGbGADK8QGivfh0qwaJFruuIu7drAuoUTqxBCkiNM30=;
	b=gMOfjA8MRe5twldTS+Rq6scRHfkfT0PAxiXix+0AugMGSertnO0VnmluEpIqZJ733TCVlS
	zC3ffhnD1F/RqfrtjzLjcLNOBUDoStRD/NZMEWX24hHzxZ8Px9MLJz7AHzVD8+xcln96dA
	Gi4qhhKWy31PGn6HIJRKFmZfTwM5qIo=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-124-G35JB6pBPseCRqE0Rj-owQ-1; Tue,
 04 Mar 2025 23:31:44 -0500
X-MC-Unique: G35JB6pBPseCRqE0Rj-owQ-1
X-Mimecast-MFC-AGG-ID: G35JB6pBPseCRqE0Rj-owQ_1741149103
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 003431955BC6;
	Wed,  5 Mar 2025 04:31:43 +0000 (UTC)
Received: from localhost (unknown [10.72.120.23])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id D8D65195608F;
	Wed,  5 Mar 2025 04:31:41 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Ming Lei <ming.lei@redhat.com>,
	Tejun Heo <tj@kernel.org>,
	Josef Bacik <josef@toxicpanda.com>,
	Yu Kuai <yukuai3@huawei.com>
Subject: [PATCH 2/3] blk-throttle: don't take carryover for prioritized processing of metadata
Date: Wed,  5 Mar 2025 12:31:20 +0800
Message-ID: <20250305043123.3938491-3-ming.lei@redhat.com>
In-Reply-To: <20250305043123.3938491-1-ming.lei@redhat.com>
References: <20250305043123.3938491-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

Commit 29390bb5661d ("blk-throttle: support prioritized processing of metadata")
takes bytes/ios carryover for prioritized processing of metadata. Turns out
we can support it by charging it directly without trimming slice, and the
result is same with carryover.

Cc: Tejun Heo <tj@kernel.org>
Cc: Josef Bacik <josef@toxicpanda.com>
Cc: Yu Kuai <yukuai3@huawei.com>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/blk-throttle.c | 15 +++++----------
 1 file changed, 5 insertions(+), 10 deletions(-)

diff --git a/block/blk-throttle.c b/block/blk-throttle.c
index 213e7b04617a..7271aee94faf 100644
--- a/block/blk-throttle.c
+++ b/block/blk-throttle.c
@@ -1620,13 +1620,6 @@ static bool tg_within_limit(struct throtl_grp *tg, struct bio *bio, bool rw)
 	return tg_may_dispatch(tg, bio, NULL);
 }
 
-static void tg_dispatch_in_debt(struct throtl_grp *tg, struct bio *bio, bool rw)
-{
-	if (!bio_flagged(bio, BIO_BPS_THROTTLED))
-		tg->carryover_bytes[rw] -= throtl_bio_data_size(bio);
-	tg->carryover_ios[rw]--;
-}
-
 bool __blk_throtl_bio(struct bio *bio)
 {
 	struct request_queue *q = bdev_get_queue(bio->bi_bdev);
@@ -1663,10 +1656,12 @@ bool __blk_throtl_bio(struct bio *bio)
 			/*
 			 * IOs which may cause priority inversions are
 			 * dispatched directly, even if they're over limit.
-			 * Debts are handled by carryover_bytes/ios while
-			 * calculating wait time.
+			 *
+			 * Charge and dispatch directly, and our throttle
+			 * control algorithm is adaptive, and extra IO bytes
+			 * will be throttled for paying the debt
 			 */
-			tg_dispatch_in_debt(tg, bio, rw);
+			throtl_charge_bio(tg, bio);
 		} else {
 			/* if above limits, break to queue */
 			break;
-- 
2.47.0

