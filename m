Received: from mail-io1-f53.google.com (mail-io1-f53.google.com [209.85.166.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AFBE1D0DCE
	for <linux-block@vger.kernel.org>; Wed,  2 Oct 2024 19:26:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727897174; cv=none; b=HXfEJKCXAddMgEa3Mkr/TkPCaMo/CasJzd2P/ziilETDEn+uTSH9i+hHgD+L4xgPrHfuC8kl0XEaKOlNj6yw0PDlEUf9XGzQAxmZVwN7AQqcy4HolTHQe9UGh/yqNmCWqpMYzWhErnBlOriTpcSDnEgcLIEpzNWNxmbNid8o5u8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727897174; c=relaxed/simple;
	bh=SS0MMl8Qvn6zOuZRE5FgldnXbnjC+iP5YSP8Vy241NY=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=SkzBJNjUmaWgnVcq6fLNheHVWOZJF64OvWH7I6X0fUk1DJ+NRB8OZS+19fX7oyeY6PQd4rYoZ47rQ+bMOFTwlmSsiHrRtLQ6cRzxVwYSxNlZHZFxR68lmxusMJcdmiiDR5CbDyZm65BDZvA07LC8HKR9Ccqceg3HPHlZRfN6rFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=DrXR7Nof; arc=none smtp.client-ip=209.85.166.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="DrXR7Nof"
Received: by mail-io1-f53.google.com with SMTP id ca18e2360f4ac-82aab679b7bso9736339f.0
        for <linux-block@vger.kernel.org>; Wed, 02 Oct 2024 12:26:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1727897170; x=1728501970; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dCIyfNTk1ksfcnMNw/gbC5tHw1ubk6VQ1JS7ix00pfU=;
        b=DrXR7NofT6RhE4TpGrq1wpUfXXGKQcuMIGrJR2LgGEY4F2cMlSsrvxBzT9k4gyHhYU
         PKxQrZW1capi3FAU3xuBd5NSqpyPzvzlWJxjDNJoWTBWo2vbSSrDYo+cQiKwHCkaV0Vc
         4PYLdEAJujk5vCy/SgWEgCdRDn611aeSyqSPEeTznRTA0EQn8Aqh1LTBP13bceGvfKOd
         0+2OwVbtS1kty8Zhq4Re+lTWf/9qgig87arlMe3vNw67kYc/y3bmvbiCYmWRZqPvo0/O
         UAD+9bJztuSBPCn23ANJBfRKZN5LcL5zD19vsHojwNBW0drixS0GB//B3YpiGgW529LC
         WHSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727897170; x=1728501970;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=dCIyfNTk1ksfcnMNw/gbC5tHw1ubk6VQ1JS7ix00pfU=;
        b=G6rsyH0WqQrcFD3apE6UeE+a83tbZX48Vo3hET596ch6Ube63prpfE0LNjtObAjua1
         2Pzv4auOYmhTDsvKiHkrEZji6ZP0wDcEzzLNbLv+pbHjvr7P5TOia9v6UCoXH/R57SaE
         ggBsG4BaXgOa+5aznqVBQ9d+/8w8LoskaVy8mG5H1oA34WFIJ2+dbisSw+uNqNuT7OWO
         LdR3FFRWlRWN68iqInn2/EM24g38Dq9UFXFowhLJQSMvjaRhf3evwi4WLusOcTfqSsJ8
         jrxb4lPRar+gRos76ab8Letig7ofXXR/v8j6XqWO4Bgzxyr+hdouyjuL4ZAzJBKzcjM1
         LkTQ==
X-Gm-Message-State: AOJu0YxaG3C/bhryeMwcuWsTCiypmrIC5UX/DEdMJ4Ub6AsCXayvyBkU
	Yj7+VaFrTY7MAKEmcYlUSoycinuUgFpMPprZp6oHlg1SzDyMAz2iOk7oARzL4xxhRE1aybBn1FU
	5kAgKsg==
X-Google-Smtp-Source: AGHT+IF+ImeFgcC/0uTuTz+hwiJO5hTX9cpqRF4InsoLTf8TkHE2PFJo/PGptLRhTWxFYZdi83vrHg==
X-Received: by 2002:a05:6602:3fca:b0:82c:f85a:4dcb with SMTP id ca18e2360f4ac-834d840a326mr458107039f.6.1727897169706;
        Wed, 02 Oct 2024 12:26:09 -0700 (PDT)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4d888835197sm3227381173.33.2024.10.02.12.26.08
        for <linux-block@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Oct 2024 12:26:09 -0700 (PDT)
Message-ID: <550fc8a0-3461-49ac-879e-32908870f007@kernel.dk>
Date: Wed, 2 Oct 2024 13:26:08 -0600
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
Subject: [PATCH] block: move iostat check into blk_acount_io_start()
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Rather than have blk_do_io_stat() check for both RQF_IO_STAT and whether
the request is a passthrough requests every time, move both of those
checks into blk_account_io_start(). Then blk_do_io_stat() can be reduced
to just checking for RQF_IO_STAT.

Signed-off-by: Jens Axboe <axboe@kernel.dk>

---

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 4b2c8e940f59..ee6cde39e52b 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -359,8 +359,6 @@ static struct request *blk_mq_rq_ctx_init(struct blk_mq_alloc_data *data,
 
 	if (data->flags & BLK_MQ_REQ_PM)
 		data->rq_flags |= RQF_PM;
-	if (blk_queue_io_stat(q))
-		data->rq_flags |= RQF_IO_STAT;
 	rq->rq_flags = data->rq_flags;
 
 	if (data->rq_flags & RQF_SCHED_TAGS) {
@@ -1000,24 +998,28 @@ static inline void blk_account_io_start(struct request *req)
 {
 	trace_block_io_start(req);
 
-	if (blk_do_io_stat(req)) {
-		/*
-		 * All non-passthrough requests are created from a bio with one
-		 * exception: when a flush command that is part of a flush sequence
-		 * generated by the state machine in blk-flush.c is cloned onto the
-		 * lower device by dm-multipath we can get here without a bio.
-		 */
-		if (req->bio)
-			req->part = req->bio->bi_bdev;
-		else
-			req->part = req->q->disk->part0;
+	if (!blk_queue_io_stat(req->q))
+		return;
+	if (blk_rq_is_passthrough(req))
+		return;
 
-		part_stat_lock();
-		update_io_ticks(req->part, jiffies, false);
-		part_stat_local_inc(req->part,
-				    in_flight[op_is_write(req_op(req))]);
-		part_stat_unlock();
-	}
+	req->rq_flags |= RQF_IO_STAT;
+
+	/*
+	 * All non-passthrough requests are created from a bio with one
+	 * exception: when a flush command that is part of a flush sequence
+	 * generated by the state machine in blk-flush.c is cloned onto the
+	 * lower device by dm-multipath we can get here without a bio.
+	 */
+	if (req->bio)
+		req->part = req->bio->bi_bdev;
+	else
+		req->part = req->q->disk->part0;
+
+	part_stat_lock();
+	update_io_ticks(req->part, jiffies, false);
+	part_stat_local_inc(req->part, in_flight[op_is_write(req_op(req))]);
+	part_stat_unlock();
 }
 
 static inline void __blk_mq_end_request_acct(struct request *rq, u64 now)
diff --git a/block/blk.h b/block/blk.h
index c718e4291db0..84178e535533 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -413,7 +413,7 @@ int blk_dev_init(void);
  */
 static inline bool blk_do_io_stat(struct request *rq)
 {
-	return (rq->rq_flags & RQF_IO_STAT) && !blk_rq_is_passthrough(rq);
+	return rq->rq_flags & RQF_IO_STAT;
 }
 
 void update_io_ticks(struct block_device *part, unsigned long now, bool end);

-- 
Jens Axboe

