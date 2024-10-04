Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5DE3139E
	for <linux-block@vger.kernel.org>; Fri,  4 Oct 2024 04:21:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728015694; cv=none; b=L+F1DDs10lNODjzqGdbsO8JWXa8IGNfkLkMvqpoTTcTJK2T1ZpbiUi3eiDqolCv1iagVhlJOeD/3/mSkZAMaPRxEYvljN6QCjtpZ/PkXqU+HC9rR8+UMnnQ4GBXiUeXW3yXqWC1tVHKvXsPdU9Ry3LKP6EIuPWiHdGCXO2a1i9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728015694; c=relaxed/simple;
	bh=WkW1fc54Od/rQwPGZRWq0OWETpcY+tI9wFWpqolpApU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jdbsZWsHtB0+E524msE8s8iq6D9an57fDrJrlbOC4fKgu0HlZiYinPOQx3+7ZZGjkd383GJCXWa+JbvsG45yYZOnXTkiENVJhITgvpEfhE9VRwiCrAq5gdFcxUi2MXwgNDe/GV5hT0OVf29B2Z9suXFvadkReL2TtEJ16IB4yvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=C6UbCaRO; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="C6UbCaRO"
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-718e2855479so1400865b3a.1
        for <linux-block@vger.kernel.org>; Thu, 03 Oct 2024 21:21:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1728015691; x=1728620491; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=s4I4NtPNDyIm+PDwNN/QeCfrN99ND1dJ8tNPzj8NdXE=;
        b=C6UbCaRONucoowKnT/qFLzTzebSUR4SQPDsjNdvSCH/BstLogd/Wzy9CpQ7XFRnfMI
         S5FymaGfr7IhhOBogtZm9CRCEZFD12+ySKqABiRLqpJWIF844Bi2qIYdJyaQ34WbD9h8
         InODV3Hnqc4JF/d2zd9x0h0bvXh4OYFDkx++M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728015691; x=1728620491;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s4I4NtPNDyIm+PDwNN/QeCfrN99ND1dJ8tNPzj8NdXE=;
        b=FAEs6sXzue9zos2c4dgz8ONYhp1YaHkf+CpbeRDyq54C2VCSgX8FyxmqkDXdmRAgle
         Ov/VrbsAjEqtjXIbFCQE6hPXX8//buJ7+442lI/ikGQVflZUmc6abLnNzZK0w++7IRg3
         A4eB+I21zsVvgCFd6eUw/Zvku2PyOWeNO/ZALGAQ3DoL4n0z3YqPsZR9/bZjyBydZ7mS
         E3/B9hV+UULd2qRwNxBqzsoNxpcRMMVxTJ/BfWRctb6w98b+JhBcr8bXeMe+eSKsmSYF
         LkKgnW2JbGLuNXFbK4ly+wj3zqx+oVDrKfVK+NJr7+2E6GjGYqLeUBJjhDJUArIKQXy5
         SvPQ==
X-Gm-Message-State: AOJu0YyPvZOHBz5AflbUJLV90nD59SU7pJ+fBTEOtgZsS6rKOyJAC5Mu
	ZiKd0U2y0ZCDecdu9H88if9rwoCeQynkzCOeOfoyMsvqajVrGhXNgNlmLGb/DWh0Rx4yPqZAaEM
	vlQ==
X-Google-Smtp-Source: AGHT+IFGbyy1026+PRzby+GQn4hVO63I3M5vWHGu0CShzfeBF8QGa9Se9knro3CpwgIdr8p2UZ/hMQ==
X-Received: by 2002:a05:6a00:1149:b0:70e:a42e:3417 with SMTP id d2e1a72fcca58-71de23c7d54mr2158287b3a.10.1728015690820;
        Thu, 03 Oct 2024 21:21:30 -0700 (PDT)
Received: from google.com ([2401:fa00:8f:203:6c:4e9b:4272:1036])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7e9dcb16f99sm1321595a12.51.2024.10.03.21.21.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Oct 2024 21:21:30 -0700 (PDT)
Date: Fri, 4 Oct 2024 13:21:27 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Christoph Hellwig <hch@infradead.org>, Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: Re: block: del_gendisk() vs blk_queue_enter() race condition
Message-ID: <20241004042127.GO11458@google.com>
References: <20241003085610.GK11458@google.com>
 <Zv6d1Iy18wKvliLm@infradead.org>
 <Zv6fbloZRg2xQ1Jf@infradead.org>
 <20241003140051.GM11458@google.com>
 <20241003141709.GN11458@google.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241003141709.GN11458@google.com>

On (24/10/03 23:17), Sergey Senozhatsky wrote:
> On (24/10/03 23:00), Sergey Senozhatsky wrote:
> > On (24/10/03 06:43), Christoph Hellwig wrote:
> [..]
> > So that mutex_lock(&disk->open_mutex) right before it potentially can
> > deadlock (I think it will).
> > 
> > My idea, thus far, was to
> > 
> > 	if (test_bit(GD_OWNS_QUEUE, &disk->state)) }
> > 		blk_queue_flag_set(QUEUE_FLAG_DYING, disk->queue);
> > 		blk_kick_queue_enter(disk->queue);  // this one simply wake_up_all(&q->mq_freeze_wq);
> > 											// if the queue has QUEUE_FLAG_DYING
> > 	}
> > 
> > in del_gendisk() before the very first time del_gendisk() attempts to
> > mutex_lock(&disk->open_mutex), because that mutex is already locked
> > forever.

Dunno. Is something like this completely silly?

---

diff --git a/block/genhd.c b/block/genhd.c
index 1c05dd4c6980..c968b04ccc7c 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -649,6 +649,13 @@ void del_gendisk(struct gendisk *disk)
 
 	disk_del_events(disk);
 
+	/*
+	 * Mark the queue QUEUE_FLAG_DYING and wakeup ->mq_freeze_wq so
+	 * that the waiters (e.g. blk_queue_enter()) can see blk_queue_dying()
+	 * and error out, unlocking the ->open_mutex.
+	 */
+	__blk_mark_disk_dead(disk);
+
 	/*
 	 * Prevent new openers by unlinked the bdev inode.
 	 */
@@ -668,7 +675,6 @@ void del_gendisk(struct gendisk *disk)
 	 * Drop all partitions now that the disk is marked dead.
 	 */
 	mutex_lock(&disk->open_mutex);
-	__blk_mark_disk_dead(disk);
 	xa_for_each_start(&disk->part_tbl, idx, part, 1)
 		drop_partition(part);
 	mutex_unlock(&disk->open_mutex);
