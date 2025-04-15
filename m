Received: from mail-io1-f48.google.com (mail-io1-f48.google.com [209.85.166.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D7062DFA56
	for <linux-block@vger.kernel.org>; Tue, 15 Apr 2025 14:52:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744728736; cv=none; b=kTaaoGKFglbry/FChr9O3wegCKKeO+g/2fB3y7jTAnP59CBCPuqz1+pJdk55CcI91U9fXuLCMQaE0dBTpxEQ2G4dj3ONWrPMElpNWgmZlLxh+pcCo9YTVjlXlNwuXTKmQuy52iVigzhQ8XOvVzoTsTgsVLKjxNGne2/kS9bhkGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744728736; c=relaxed/simple;
	bh=+UjIgIiV6Djq1tA+qSHKvJ7Lre9ITS9vMILUMTkVeq0=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=pO9FhVpJFH4S6HxL1PW7NZbVlspeiJ1gipxsfPszkcpnik3qAfa1GHD/UzMvb8mmMIOQ/sGPX5uEBe7Tzt7Z3w7DdZengCOakBXGYPFbEzkYNZN1FufGlMMqiscLtUpzo9hZAmULe515jmzY+wI+Gj88hWYWlzkLvDEOx/Lm5nE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=DG6/s7ft; arc=none smtp.client-ip=209.85.166.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="DG6/s7ft"
Received: by mail-io1-f48.google.com with SMTP id ca18e2360f4ac-854a68f5a9cso476468839f.0
        for <linux-block@vger.kernel.org>; Tue, 15 Apr 2025 07:52:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1744728732; x=1745333532; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JwgOZmjhYKq9blbBb1ftn94+qIElnsoJPIzLXtr4sWo=;
        b=DG6/s7ftbNzYfVh8Wq6Ttbww/yjo+OLuseo2zj9KfKUpiOiJd+PGBbhtSDmlDuWiRS
         LpSfEk+/rXWRtiHGZguNakVSUJjyf/mw2o81JFNhByQy3A0cxP0dbja44YAnKeMUjRap
         KjO0rZhJs+QemVBlKsFcj5eDGd4F2fxJZJP5jhUAadxwxgAy87moXOkkOKvgwMmVb0BV
         X18HnG1NbHP/djm8ZZtaUUoCzt6aUB6PL1RF78zuQA+1i3neEzHLtuPhqFvTuEhI8Yd/
         Q0gQgmiDWQxYCTr0DRAYAnsq5xMzSAuWi6BulVCXQHDDP5teGBRSXC8nxQvBx2cExnLH
         7tXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744728732; x=1745333532;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=JwgOZmjhYKq9blbBb1ftn94+qIElnsoJPIzLXtr4sWo=;
        b=BBXGrHRAuEqTGj5DRwjkFIvMnOOFfNRkQhpVu4ygdYq9HNBESSfokIdF0wb2oLZwph
         LJwwHSMQNwYY0eJvEBsMky6bpQWvsID26NoFbAKxn1plXll8g7uqH3sJ7eiJYg0ipnAx
         KmGdvk36XuLsR+LMaPYIoUfMz50IaOnqnlv8DjK4nzEiAF+X6l4tWMcjfRgnEBwr1v9s
         VQ06Q1WjMISNaIpYyDVP1dmhGSBZG9EwYdXVcFsGd8cR8tVUJq7igwGO94OlHYnt/AEP
         zFp5RKTeFU68NzQh2qjHrAHE4OdvLzyBX1vi1gnYhUVuVoHp9jcAHmHWbUccLxqOihjc
         wDNA==
X-Gm-Message-State: AOJu0YzHQrjUwoAuhhOW7Tx8+ECJbRGS39DEVAb9KES6Z/LqazqtOcpH
	2QihIlHywTPy0mkMCJOmu6A5BFm4zkSxKRWb9IEMlN1YIfoIeAUpJddbXcNQX7J6ZDD5B+QxFDn
	s
X-Gm-Gg: ASbGncsB2SgIdlXdklnmd8WHoUqZ1eU0JR+qsg3R1yJgL/tvgDNOkQ4EUNXkxxCPGjq
	1IYBe8YNXZ9XwZJ3LmVPBr5ai8TU7gcQIywYBuJOcjYyqldc5o9QSsI53eJMI+rj0zKDTainlsN
	p+MMtD5JsN2v4TbF+dQPJeAA5DXK0QPbf0JUsATl9W1jjVM1QS8sBDczFpqo6OzMOQ3v6NO+cMO
	XTF1c8vSQQFy/ZyXZh7oEi83RrCHJtBTx0/MSqPJUgpkqisHgj6xSnCtLbAo+TEiJZdQbReumuz
	twlqlL+O3tRH8+umO0k9idMLYu4Y+tdPfXfdPw==
X-Google-Smtp-Source: AGHT+IFvWpWZjgDy9WGa5PDsla6UHHjSD0zzOb5IW5UdqNaNjkAUoSL465yG6PLsfCyE/84z+KEhtg==
X-Received: by 2002:a05:6602:358c:b0:85b:43a3:66b2 with SMTP id ca18e2360f4ac-8617cb88392mr1865621239f.7.1744728731631;
        Tue, 15 Apr 2025 07:52:11 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-8616522cf6bsm255587839f.7.2025.04.15.07.52.10
        for <linux-block@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Apr 2025 07:52:11 -0700 (PDT)
Message-ID: <ee26d050-dd58-4672-93c2-d5b3fa63bbae@kernel.dk>
Date: Tue, 15 Apr 2025 08:52:10 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
From: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH] block: blk-rq-qos: guard rq-qos helpers by static key
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Even if blk-rq-qos isn't used or configured, dipping into the queue to
fetch ->rq_qos is a noticeable slowdown and visible in profiles. Add an
unlikely static key around blk-rq-qos, to avoid fetching this cacheline
if blk-iolatency or blk-wbt isn't configured or used.

Signed-off-by: Jens Axboe <axboe@kernel.dk>

---

diff --git a/block/blk-rq-qos.c b/block/blk-rq-qos.c
index 95982bc46ba1..848591fb3c57 100644
--- a/block/blk-rq-qos.c
+++ b/block/blk-rq-qos.c
@@ -2,6 +2,8 @@
 
 #include "blk-rq-qos.h"
 
+__read_mostly DEFINE_STATIC_KEY_FALSE(block_rq_qos);
+
 /*
  * Increment 'v', if 'v' is below 'below'. Returns true if we succeeded,
  * false if 'v' + 1 would be bigger than 'below'.
@@ -317,6 +319,7 @@ void rq_qos_exit(struct request_queue *q)
 		struct rq_qos *rqos = q->rq_qos;
 		q->rq_qos = rqos->next;
 		rqos->ops->exit(rqos);
+		static_branch_dec(&block_rq_qos);
 	}
 	mutex_unlock(&q->rq_qos_mutex);
 }
@@ -343,6 +346,7 @@ int rq_qos_add(struct rq_qos *rqos, struct gendisk *disk, enum rq_qos_id id,
 		goto ebusy;
 	rqos->next = q->rq_qos;
 	q->rq_qos = rqos;
+	static_branch_inc(&block_rq_qos);
 
 	blk_mq_unfreeze_queue(q, memflags);
 
diff --git a/block/blk-rq-qos.h b/block/blk-rq-qos.h
index 37245c97ee61..39749f4066fb 100644
--- a/block/blk-rq-qos.h
+++ b/block/blk-rq-qos.h
@@ -12,6 +12,7 @@
 #include "blk-mq-debugfs.h"
 
 struct blk_mq_debugfs_attr;
+extern struct static_key_false block_rq_qos;
 
 enum rq_qos_id {
 	RQ_QOS_WBT,
@@ -112,31 +113,33 @@ void __rq_qos_queue_depth_changed(struct rq_qos *rqos);
 
 static inline void rq_qos_cleanup(struct request_queue *q, struct bio *bio)
 {
-	if (q->rq_qos)
+	if (static_branch_unlikely(&block_rq_qos) && q->rq_qos)
 		__rq_qos_cleanup(q->rq_qos, bio);
 }
 
 static inline void rq_qos_done(struct request_queue *q, struct request *rq)
 {
-	if (q->rq_qos && !blk_rq_is_passthrough(rq))
+	if (static_branch_unlikely(&block_rq_qos) && q->rq_qos &&
+	    !blk_rq_is_passthrough(rq))
 		__rq_qos_done(q->rq_qos, rq);
 }
 
 static inline void rq_qos_issue(struct request_queue *q, struct request *rq)
 {
-	if (q->rq_qos)
+	if (static_branch_unlikely(&block_rq_qos) && q->rq_qos)
 		__rq_qos_issue(q->rq_qos, rq);
 }
 
 static inline void rq_qos_requeue(struct request_queue *q, struct request *rq)
 {
-	if (q->rq_qos)
+	if (static_branch_unlikely(&block_rq_qos) && q->rq_qos)
 		__rq_qos_requeue(q->rq_qos, rq);
 }
 
 static inline void rq_qos_done_bio(struct bio *bio)
 {
-	if (bio->bi_bdev && (bio_flagged(bio, BIO_QOS_THROTTLED) ||
+	if (static_branch_unlikely(&block_rq_qos) &&
+	    bio->bi_bdev && (bio_flagged(bio, BIO_QOS_THROTTLED) ||
 			     bio_flagged(bio, BIO_QOS_MERGED))) {
 		struct request_queue *q = bdev_get_queue(bio->bi_bdev);
 		if (q->rq_qos)
@@ -146,7 +149,7 @@ static inline void rq_qos_done_bio(struct bio *bio)
 
 static inline void rq_qos_throttle(struct request_queue *q, struct bio *bio)
 {
-	if (q->rq_qos) {
+	if (static_branch_unlikely(&block_rq_qos) && q->rq_qos) {
 		bio_set_flag(bio, BIO_QOS_THROTTLED);
 		__rq_qos_throttle(q->rq_qos, bio);
 	}
@@ -155,14 +158,14 @@ static inline void rq_qos_throttle(struct request_queue *q, struct bio *bio)
 static inline void rq_qos_track(struct request_queue *q, struct request *rq,
 				struct bio *bio)
 {
-	if (q->rq_qos)
+	if (static_branch_unlikely(&block_rq_qos) && q->rq_qos)
 		__rq_qos_track(q->rq_qos, rq, bio);
 }
 
 static inline void rq_qos_merge(struct request_queue *q, struct request *rq,
 				struct bio *bio)
 {
-	if (q->rq_qos) {
+	if (static_branch_unlikely(&block_rq_qos) && q->rq_qos) {
 		bio_set_flag(bio, BIO_QOS_MERGED);
 		__rq_qos_merge(q->rq_qos, rq, bio);
 	}
@@ -170,7 +173,7 @@ static inline void rq_qos_merge(struct request_queue *q, struct request *rq,
 
 static inline void rq_qos_queue_depth_changed(struct request_queue *q)
 {
-	if (q->rq_qos)
+	if (static_branch_unlikely(&block_rq_qos) && q->rq_qos)
 		__rq_qos_queue_depth_changed(q->rq_qos);
 }
 
-- 
Jens Axboe

