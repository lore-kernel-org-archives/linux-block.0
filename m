Received: from mail-pl1-f229.google.com (mail-pl1-f229.google.com [209.85.214.229])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E7BA1A01CC
	for <linux-block@vger.kernel.org>; Mon, 14 Apr 2025 19:58:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.229
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744660731; cv=none; b=oWYWtKUemMw5ahKNYyFYCq4Hfy01d+xtSRqDKQWrT+4hKDDj61IHLJzW+vzFqWPYrjdMhLEvw0X+YLUM0d8HpDVIdDKkZD02jzQ3l2h1Vpms9PJP75PKWjnUr4mxpFluLXRni2F/llXwu9dLz8sui+/hPRI3kSoRkY/LESMBQS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744660731; c=relaxed/simple;
	bh=zmxcGd7jTX7VNH8rZjeblEy9fygEIJQZi5j6n92P+Yw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Tt9d8Oeg3jQIW7Ksl8to1lDkAdMBQVwAT4MlNrO8HuI2Has1ciGXTIVIxcWG2e7jHH4a0R/R5Cbyha+Ur5pLFFCsHTCqzTceDZ8DKJVg0fWqz2z6DYhCSjFb1dRCJ+huUh0B9R9g38A1PBdnwuSCkOahlczsRaqTJ6ObeQuSGOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=OKiQaaDv; arc=none smtp.client-ip=209.85.214.229
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="OKiQaaDv"
Received: by mail-pl1-f229.google.com with SMTP id d9443c01a7336-223f4c06e9fso44474965ad.1
        for <linux-block@vger.kernel.org>; Mon, 14 Apr 2025 12:58:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1744660729; x=1745265529; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=idxbBBp8c4dJqniMeRtLc59cVxXBX7byKlkksui83YE=;
        b=OKiQaaDvwnpD9vrPsVVjtIR+XW/KcK0EUsp9Nvb3cnT9Q9wV8GhaIotzhJ+ISGtmg2
         dluXdXSn/5R/18wFQgQSNmLeLKexYuD61nDABIQt8BuKH+b/d93FHgKw/1lUzA3NClTl
         DFonBvrIihjjMnTiyuKXXzPxQZMYQ/QyWlbbmNL1sq1AiFJy1FAOpvKyNKWF6TbJwP19
         ltDO1H00BOV+r7ACkDPOZeK/7T8/gNQMEM5LbxYXmN6wvgkygnE0/llWRtd9OSl/GVUo
         zqvFQt+f/brTv25sV5TSfrFuUlkNRGAibANMSGwxHwYgyEgbGB0FS93tXTiRn++mf9ED
         bIPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744660729; x=1745265529;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=idxbBBp8c4dJqniMeRtLc59cVxXBX7byKlkksui83YE=;
        b=VNYpc3KIiUBy/Fp2n+3OOhREJxX8GFrOwT2BuKHYhAnObbt5gST2q1kLgLu3jpt4O3
         wh6/R0Z7tBiFAO9tgy+H0vNJNePSnvEfvW1LymmId4q1j2SDJrDoV+2y7P/ya6Z49Iqe
         p+xS/Dw7rpXVx8N0nBobCSiM15HI9vNp1OZkTMsUJ3B6jb9O4dFLjghWebY0k4/iqpzx
         XvnXKGzDDizsVjH++G4Azmp5HIVPPhGvhs+rhPB39ix/aAi2juKS6x3RRqIqc9iEMlz7
         HWInouUa31v3vvLL4w9V/s5IbiarpNnRfP6io1TkUA67TbRHyZV/m1KwtXPIG0H7mMAa
         8e+Q==
X-Forwarded-Encrypted: i=1; AJvYcCWk3xYRmzCtXVdGWtJmCOOkDyu2f3/O07G9rqFzjePi79/0FsmxZI9MOuYgmnTT1n4b7VACiI1ghurmLQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwDaT3jhNhMg1rlsa7CZ9Ssf7IGLPokHz1ykOpMdfyJ2k9APGgQ
	dAGnhJI8SpieobNQZFflzaqKLmUSKfD16LD5K856TW5CUhSDtiggSYy38kOkIoeGCS3NQeRCIwu
	zGSmGqhIzDh0cH1X0NUondbAHIQc6TLPOrDZszQAJu5Q7NOEI
X-Gm-Gg: ASbGncvBBUPagKmbn3N38PQ/3G5cx2uoS2YEmhQEhVhDLvfJkFTF1J9SJ5k6otb67n/
	14b+aAvGlfgYOZnEVxlku1mXZ4xZLg77IxcOQtfHlvrJdrBAn+TBDKgmNGsWtrt+N88oSe2hrrZ
	uxe0GYUo0TX+N++60x8ICu8hQb9KFRMELmn/A2njWNcyZ+p4qlEupDjGpyitxjxlrsytIBCXIF3
	ZMkNBFslKl9IFrz18biyG+o9huYmsm7PmIKSVzAJo6uepQYbpSkqKDLZ51rEGjJQbJ6Hm7zCP2N
	ZTpR0epeFMNOVgBLdzxXte3wxmmHdIM=
X-Google-Smtp-Source: AGHT+IGBcC6lvqfEbpn0rX9rtBlHfHFJdjx4OOe1mpTOwgTO8GRH7kxX21rLuGbwpEyC9N7UsSmaUbjfzkbN
X-Received: by 2002:a17:903:1a0b:b0:215:58be:334e with SMTP id d9443c01a7336-22c2496a4e3mr10575505ad.10.1744660728668;
        Mon, 14 Apr 2025 12:58:48 -0700 (PDT)
Received: from c7-smtp-2023.dev.purestorage.com ([2620:125:9017:12:36:3:5:0])
        by smtp-relay.gmail.com with ESMTPS id d9443c01a7336-22ac7cc8e0fsm6565325ad.124.2025.04.14.12.58.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Apr 2025 12:58:48 -0700 (PDT)
X-Relaying-Domain: purestorage.com
Received: from dev-ushankar.dev.purestorage.com (dev-ushankar.dev.purestorage.com [IPv6:2620:125:9007:640:7:70:36:0])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id C93003401C3;
	Mon, 14 Apr 2025 13:58:47 -0600 (MDT)
Received: by dev-ushankar.dev.purestorage.com (Postfix, from userid 1557716368)
	id BD941E402BD; Mon, 14 Apr 2025 13:58:47 -0600 (MDT)
Date: Mon, 14 Apr 2025 13:58:47 -0600
From: Uday Shankar <ushankar@purestorage.com>
To: Ming Lei <ming.lei@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Caleb Sander Mateos <csander@purestorage.com>
Subject: Re: [PATCH 2/9] ublk: properly serialize all FETCH_REQs
Message-ID: <Z/1o946/z43QETPr@dev-ushankar.dev.purestorage.com>
References: <20250414112554.3025113-1-ming.lei@redhat.com>
 <20250414112554.3025113-3-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250414112554.3025113-3-ming.lei@redhat.com>

On Mon, Apr 14, 2025 at 07:25:43PM +0800, Ming Lei wrote:
> From: Uday Shankar <ushankar@purestorage.com>
> 
> Most uring_cmds issued against ublk character devices are serialized
> because each command affects only one queue, and there is an early check
> which only allows a single task (the queue's ubq_daemon) to issue
> uring_cmds against that queue. However, this mechanism does not work for
> FETCH_REQs, since they are expected before ubq_daemon is set. Since
> FETCH_REQs are only used at initialization and not in the fast path,
> serialize them using the per-ublk-device mutex. This fixes a number of
> data races that were previously possible if a badly behaved ublk server
> decided to issue multiple FETCH_REQs against the same qid/tag
> concurrently.
> 
> Reviewed-by: Ming Lei <ming.lei@redhat.com>
> Reported-by: Caleb Sander Mateos <csander@purestorage.com>
> Signed-off-by: Uday Shankar <ushankar@purestorage.com>

Thanks for picking this up. Can you use the following patch instead? It
has two changes compared to [1]:

- Factor FETCH command into its own function
- Return -EAGAIN for non-blocking dispatch because we are taking a
  mutex.

[1] https://lore.kernel.org/linux-block/20250410-ublk_task_per_io-v3-1-b811e8f4554a@purestorage.com/

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index 2fd05c1bd30b..8efb7668ab2c 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -1809,8 +1809,8 @@ static void ublk_nosrv_work(struct work_struct *work)
 
 /* device can only be started after all IOs are ready */
 static void ublk_mark_io_ready(struct ublk_device *ub, struct ublk_queue *ubq)
+	__must_hold(&ub->mutex)
 {
-	mutex_lock(&ub->mutex);
 	ubq->nr_io_ready++;
 	if (ublk_queue_ready(ubq)) {
 		ubq->ubq_daemon = current;
@@ -1822,7 +1822,6 @@ static void ublk_mark_io_ready(struct ublk_device *ub, struct ublk_queue *ubq)
 	}
 	if (ub->nr_queues_ready == ub->dev_info.nr_hw_queues)
 		complete_all(&ub->completion);
-	mutex_unlock(&ub->mutex);
 }
 
 static void ublk_handle_need_get_data(struct ublk_device *ub, int q_id,
@@ -1906,6 +1905,52 @@ static int ublk_unregister_io_buf(struct io_uring_cmd *cmd,
 	return io_buffer_unregister_bvec(cmd, index, issue_flags);
 }
 
+static int ublk_fetch(struct io_uring_cmd *cmd, struct ublk_device *ub,
+		      struct ublk_queue *ubq, struct ublk_io *io,
+		      const struct ublksrv_io_cmd *ub_cmd,
+		      unsigned int issue_flags)
+{
+	int ret = 0;
+
+	if (issue_flags & IO_URING_F_NONBLOCK)
+		return -EAGAIN;
+
+	mutex_lock(&ub->mutex);
+	/* UBLK_IO_FETCH_REQ is only allowed before queue is setup */
+	if (ublk_queue_ready(ubq)) {
+		ret = -EBUSY;
+		goto out;
+	}
+
+	/* allow each command to be FETCHed at most once */
+	if (io->flags & UBLK_IO_FLAG_ACTIVE) {
+		ret = -EINVAL;
+		goto out;
+	}
+
+	WARN_ON_ONCE(io->flags & UBLK_IO_FLAG_OWNED_BY_SRV);
+
+	if (ublk_need_map_io(ubq)) {
+		/*
+		 * FETCH_RQ has to provide IO buffer if NEED GET
+		 * DATA is not enabled
+		 */
+		if (!ub_cmd->addr && !ublk_need_get_data(ubq))
+			goto out;
+	} else if (ub_cmd->addr) {
+		/* User copy requires addr to be unset */
+		ret = -EINVAL;
+		goto out;
+	}
+
+	ublk_fill_io_cmd(io, cmd, ub_cmd->addr);
+	ublk_mark_io_ready(ub, ubq);
+
+out:
+	mutex_unlock(&ub->mutex);
+	return ret;
+}
+
 static int __ublk_ch_uring_cmd(struct io_uring_cmd *cmd,
 			       unsigned int issue_flags,
 			       const struct ublksrv_io_cmd *ub_cmd)
@@ -1962,34 +2007,7 @@ static int __ublk_ch_uring_cmd(struct io_uring_cmd *cmd,
 	case UBLK_IO_UNREGISTER_IO_BUF:
 		return ublk_unregister_io_buf(cmd, ub_cmd->addr, issue_flags);
 	case UBLK_IO_FETCH_REQ:
-		/* UBLK_IO_FETCH_REQ is only allowed before queue is setup */
-		if (ublk_queue_ready(ubq)) {
-			ret = -EBUSY;
-			goto out;
-		}
-		/*
-		 * The io is being handled by server, so COMMIT_RQ is expected
-		 * instead of FETCH_REQ
-		 */
-		if (io->flags & UBLK_IO_FLAG_OWNED_BY_SRV)
-			goto out;
-
-		if (ublk_need_map_io(ubq)) {
-			/*
-			 * FETCH_RQ has to provide IO buffer if NEED GET
-			 * DATA is not enabled
-			 */
-			if (!ub_cmd->addr && !ublk_need_get_data(ubq))
-				goto out;
-		} else if (ub_cmd->addr) {
-			/* User copy requires addr to be unset */
-			ret = -EINVAL;
-			goto out;
-		}
-
-		ublk_fill_io_cmd(io, cmd, ub_cmd->addr);
-		ublk_mark_io_ready(ub, ubq);
-		break;
+		return ublk_fetch(cmd, ub, ubq, io, ub_cmd, issue_flags);
 	case UBLK_IO_COMMIT_AND_FETCH_REQ:
 		req = blk_mq_tag_to_rq(ub->tag_set.tags[ub_cmd->q_id], tag);
 

