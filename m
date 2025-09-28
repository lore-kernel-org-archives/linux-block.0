Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BB072DE717
	for <linux-block@vger.kernel.org>; Sun, 28 Sep 2025 13:29:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759066192; cv=none; b=cySaE4t9vg6UOmGIF2uJfm3aEhp/QSYtBSPlR8J7VfFfxrSdL0cCzv3H2QE0bc9b3DfEGAgHUAcuz9ZqsXRqqM/OTfhqafTBCAPtWxZfArUXR/84ZxnT35NdaP/7Qfq1dWLRpoHNpLXyqeveQhLM9d1SSAaH2pUZlTIWcZOkS/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759066192; c=relaxed/simple;
	bh=ZKQYV7aISWHH9C10tbIWtRgz1+vhqEO64vVYOFrQ8UY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uClExH/3YPqYs4hhQe5olA5v3+eUD3GdXWtYgpN65iT+Oi71z38ZC1GLe1QiYSqBvr2Cpc7bR/C9qtYGaZQI0tdGS5S8t7F0PeLue9PV+oXQYgAUfIRq6ogrdLZxjG7zNR6USD9xDhRvpClfgcUnfe27d87AV75qR4AvzpdDWyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aY0cPR0+; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aY0cPR0+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1759066189;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MMONmUM6gayoqIXLJGw4GQd0IzRDlol0YYWX4b80ytA=;
	b=aY0cPR0+3C9gZhDKY6priCijKNioy33L09EpHSxS14Uv8Scbj8aRWKpmJLkq8mCCSAEWm7
	PshdSUkgY6FLdIaTlhXY25xuKBTDycEVtdHvBmOUQa4cz9sIi/DVoHDy7oHzVPg8eC47lI
	NyJK1BvZime3jgAyBJB27vy2kzzpoak=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-486-mOVN4p68OxaZ2a1KbwXgEQ-1; Sun,
 28 Sep 2025 09:29:42 -0400
X-MC-Unique: mOVN4p68OxaZ2a1KbwXgEQ-1
X-Mimecast-MFC-AGG-ID: mOVN4p68OxaZ2a1KbwXgEQ_1759066181
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3ADFA1800451;
	Sun, 28 Sep 2025 13:29:41 +0000 (UTC)
Received: from localhost (unknown [10.72.120.3])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 2607430001A4;
	Sun, 28 Sep 2025 13:29:39 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Mikulas Patocka <mpatocka@redhat.com>,
	Zhaoyang Huang <zhaoyang.huang@unisoc.com>,
	Dave Chinner <dchinner@redhat.com>,
	linux-fsdevel@vger.kernel.org,
	Ming Lei <ming.lei@redhat.com>
Subject: [PATCH V4 1/6] loop: add helper lo_cmd_nr_bvec()
Date: Sun, 28 Sep 2025 21:29:20 +0800
Message-ID: <20250928132927.3672537-2-ming.lei@redhat.com>
In-Reply-To: <20250928132927.3672537-1-ming.lei@redhat.com>
References: <20250928132927.3672537-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

Add lo_cmd_nr_bvec() and prepare for refactoring lo_rw_aio().

Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 drivers/block/loop.c | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index 053a086d547e..af443651dff5 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -337,6 +337,19 @@ static void lo_rw_aio_complete(struct kiocb *iocb, long ret)
 	lo_rw_aio_do_completion(cmd);
 }
 
+static inline unsigned lo_cmd_nr_bvec(struct loop_cmd *cmd)
+{
+	struct request *rq = blk_mq_rq_from_pdu(cmd);
+	struct req_iterator rq_iter;
+	struct bio_vec tmp;
+	int nr_bvec = 0;
+
+	rq_for_each_bvec(tmp, rq, rq_iter)
+		nr_bvec++;
+
+	return nr_bvec;
+}
+
 static int lo_rw_aio(struct loop_device *lo, struct loop_cmd *cmd,
 		     loff_t pos, int rw)
 {
@@ -348,12 +361,9 @@ static int lo_rw_aio(struct loop_device *lo, struct loop_cmd *cmd,
 	struct file *file = lo->lo_backing_file;
 	struct bio_vec tmp;
 	unsigned int offset;
-	int nr_bvec = 0;
+	int nr_bvec = lo_cmd_nr_bvec(cmd);
 	int ret;
 
-	rq_for_each_bvec(tmp, rq, rq_iter)
-		nr_bvec++;
-
 	if (rq->bio != rq->biotail) {
 
 		bvec = kmalloc_array(nr_bvec, sizeof(struct bio_vec),
-- 
2.47.0

