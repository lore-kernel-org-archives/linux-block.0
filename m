Received: from mail-io1-f51.google.com (mail-io1-f51.google.com [209.85.166.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3C0D52F61
	for <linux-block@vger.kernel.org>; Fri, 19 Jan 2024 16:03:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705680225; cv=none; b=LFyGbIMrwRDID8ziGK1whjexOihsLx+TOQS4t4zhxQ9EgRiiEZr9fYzD5+mJxlBuSyaSo7PHj9i13GBCfQmDzZ7/OyRjmOvctg6/FF7mlqJ7TNLo3ha7rL8J4iZZoPSHwJIFCFV+o4XNLKo3PKJS4vExDTzCsXps/gCjwcYKmXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705680225; c=relaxed/simple;
	bh=tcuVntrfVztS32kuzKXBWCs7g7jQvxJZgfWq07XJAK0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uc04BdWcyGPTWXroRzLm7THKV7U1I+GiZMeHmiLW6RXd24OR/3M7ETyblp8Y0YJxrkgGSM6y0NhVWx5wHb1Ho85cZq6ktWCk5OoTiod+Per31EFASg2nvCi+Pf08725+lkCrNLl4vTEsRMxzP5ULgCnx+vdvPF7f/KPjPIHRDu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=DqPRpDQi; arc=none smtp.client-ip=209.85.166.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="DqPRpDQi"
Received: by mail-io1-f51.google.com with SMTP id ca18e2360f4ac-7bee9f626caso13150539f.0
        for <linux-block@vger.kernel.org>; Fri, 19 Jan 2024 08:03:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1705680222; x=1706285022; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OiTfz39ZKyKMN0Cev9jwvMiF20xs0nOs8gdILsd+qdI=;
        b=DqPRpDQiz/a96hCP9pgJA5LSV1u2ra7mY/qCd2tllsOPPjMOUEce53cWTQmp0gK4p1
         bjnkPtXjqltiLdc9bKMtCTewN3HTQtytGOfR/4wpfo7qABqiiol8XC1bgWAUxo3Rmfbc
         xyCNZXMcIVPHuUSH3lZFo1joXHirnGlG4BmeHtbFcw+/LLV5N9YQbqj9IwSUOMTw7Bi7
         L+Z7WH5jvJ1WFixB4I2c8U/NK9KYhgfNUpVFSlKJoXwsiNmO0L/+aWL9Bh4JvxzFt3db
         epJcFtXWKLghjxE3SbG5ZyoS088o9R56Z0Wk/oN9U6VeSvn/8YDpQbdKGxNUEnPjDjYZ
         1n+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705680222; x=1706285022;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OiTfz39ZKyKMN0Cev9jwvMiF20xs0nOs8gdILsd+qdI=;
        b=SCg4vNvREdBG4lVWHlP3wjYncikYX+ekeEtLVkVN0At78ykR547L3BJRrx3KyeB5gg
         r3VylOf55x+ZQKN7GspAi4QAGSqeXBKaZDDVCF8RfigLKaqFoVf3HYAKoYZRLTIZMV8C
         TLL5+1aAE4RUvfox+B4/9Jye4PrIK+9Fi2M8q9whU+HVEdnOf95U6Qs7oXakg3tm8+BB
         jfSlKyU+72F1GCAPsyqbheyWx6vxj0yZOe5BQ+7VXE/gE5TjdxqNBLBRw6jHNF+Bkfhd
         nxlgRjCbNhgiGfj0E2Idl2r98+n1+HQ8FRvKsyMjzrN+sLHUF7bdZhaBJDISAZbCnrfH
         i6SA==
X-Gm-Message-State: AOJu0YwZaI0r/bweyJDwAValj85O+S+7E+2FhtD7LQVTgYBLVSLcjFlc
	BKfoS3PLZmLrUh+G93wqZ/U8Dho7+XoUF2enEh8gBzrPQDD3ye9LETAkzPzaGBYC3d35x3822VK
	2dwA=
X-Google-Smtp-Source: AGHT+IGrnt4TSJrwbZB1W5hK9erkO7reo8k323wAyOYyqAIN327E6dRiMqJy5rOXfjj56RfFkTMGVA==
X-Received: by 2002:a05:6e02:1c2f:b0:35f:f59f:9f4c with SMTP id m15-20020a056e021c2f00b0035ff59f9f4cmr74615ilh.1.1705680222550;
        Fri, 19 Jan 2024 08:03:42 -0800 (PST)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id bc8-20020a056e02008800b0035fe37a9c09sm5645163ilb.20.2024.01.19.08.03.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jan 2024 08:03:41 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: linux-block@vger.kernel.org
Cc: bvanassche@acm.org,
	Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 1/4] block/mq-deadline: pass in queue directly to dd_insert_request()
Date: Fri, 19 Jan 2024 09:02:06 -0700
Message-ID: <20240119160338.1191281-2-axboe@kernel.dk>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240119160338.1191281-1-axboe@kernel.dk>
References: <20240119160338.1191281-1-axboe@kernel.dk>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The hardware queue isn't relevant, deadline only operates on the queue
itself. Pass in the queue directly rather than the hardware queue, as
that more clearly explains what is being operated on.

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 block/mq-deadline.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/block/mq-deadline.c b/block/mq-deadline.c
index f958e79277b8..9b7563e9d638 100644
--- a/block/mq-deadline.c
+++ b/block/mq-deadline.c
@@ -792,10 +792,9 @@ static bool dd_bio_merge(struct request_queue *q, struct bio *bio,
 /*
  * add rq to rbtree and fifo
  */
-static void dd_insert_request(struct blk_mq_hw_ctx *hctx, struct request *rq,
+static void dd_insert_request(struct request_queue *q, struct request *rq,
 			      blk_insert_t flags, struct list_head *free)
 {
-	struct request_queue *q = hctx->queue;
 	struct deadline_data *dd = q->elevator->elevator_data;
 	const enum dd_data_dir data_dir = rq_data_dir(rq);
 	u16 ioprio = req_get_ioprio(rq);
@@ -875,7 +874,7 @@ static void dd_insert_requests(struct blk_mq_hw_ctx *hctx,
 
 		rq = list_first_entry(list, struct request, queuelist);
 		list_del_init(&rq->queuelist);
-		dd_insert_request(hctx, rq, flags, &free);
+		dd_insert_request(q, rq, flags, &free);
 	}
 	spin_unlock(&dd->lock);
 
-- 
2.43.0

