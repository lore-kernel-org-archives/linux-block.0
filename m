Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5C9717F4F7
	for <linux-block@vger.kernel.org>; Mon,  7 Oct 2024 09:45:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728294318; cv=none; b=lPb93JbvjSWmaHj82whI19X/WU1Hlun103kZnXzV/JF9ly4gOaLK1YPjDvRqNtFEMqOYo936T/SeEr6aMMmp76CH3llEFqPITTkGbhZ68KL7ErvsOm7h8JT5Oyz+OJeZ6X2luKeao3irx3HavV7gt10fd2q+uS8BuYjrwWpnv1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728294318; c=relaxed/simple;
	bh=Hx1F0tikbNColnhleodGdUAOmDHsZ0l3SwGG52L6zwE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N+i6fS8cTwyDGmPfo6sdwvxXTPJaYG8WI9auSDDpB0RIgkofFc6l7Fx/aAz3ydWOLYkzBIurEGvPQWsELbGKxjkLeWvlZdwqM3tkO0EalHpjQ0atL5Tqafh6zpkGsyuFrNvRbXV1p6RzgZ+i9S4Gg+vkkGtlXTf+H8PT5q23DhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=XhlDi3ct; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="XhlDi3ct"
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-71def715ebdso1584141b3a.2
        for <linux-block@vger.kernel.org>; Mon, 07 Oct 2024 02:45:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1728294316; x=1728899116; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Ibq+LEAfPemunpVqR7LHp3t7YmtoUUQ7QEqbyhSu2tw=;
        b=XhlDi3ctvRbbuzPvBt/CagIfRHvpEH8KrLgOfNW5yfJJweEExUWHoG0StFOYWFWasO
         O1ovFtO+afjHK61iIG4zPnh+CClv1Gm0Z7DiNawHjLQmD3rVbfZFM8MuOsarR9AQswxE
         hveByBNUAK0QrjnpB+JPSWtjWufEM1CHYk5Ao=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728294316; x=1728899116;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ibq+LEAfPemunpVqR7LHp3t7YmtoUUQ7QEqbyhSu2tw=;
        b=k/XMUDkAdzCpBS45OShexvV2l875MQNMbkJwMBpt3Pme4OwA4yNDrQorNeeTrZJllS
         cHzlie6fSZKdle8aGVr/IGlVAmaeU2CQpXUiTdA6oDq87U/0buZ00G+cNJXMna8XaJb4
         IUqaFyC0IPrkSXWbhNSbdO1Iz09QRopvyxO4bVb3vOZWYvGutZkno31Ukmb8uyxLrHDD
         Uz+hJBpslWhKKM4bXFVyisr4sHS2Tw9a0pR8SPQyp+pvxbq4IfDQDDEUQgBEyM1Yv9fz
         VMIWkc+vFgOpBbL3XRdsDDuBifoC35nGEau9MdEVhp7T94J/UevH8xQEEzcnFa7Lcfqv
         uL5g==
X-Forwarded-Encrypted: i=1; AJvYcCVqTLuu5TGJAr0wuc37IRkuxaUO3ZNg8q+gNp1ezBM00Lk39vtcgCsmqasvDviBVJbW9V7BYbQuDL3XKw==@vger.kernel.org
X-Gm-Message-State: AOJu0YybuEBtoVoGYgwaFtszlXJxwPCsUzNtZqvamaLCyD/iw1ZeUL4l
	ch25qGLinZyKhw4hw4KzYRn+jF4XdrXLRAh+VPYzfdnd99320hz6/oOFdHOivg==
X-Google-Smtp-Source: AGHT+IGlphmJFtEqg+/TLxxWa6abQtsAjeVhInDIuEplGxIH3E9TBeO2FzZ86m1IGlDp/7Bqkgi/MA==
X-Received: by 2002:a05:6a21:6f83:b0:1d2:e81c:ac76 with SMTP id adf61e73a8af0-1d6dfababffmr18648559637.32.1728294315839;
        Mon, 07 Oct 2024 02:45:15 -0700 (PDT)
Received: from google.com ([2401:fa00:8f:203:e05b:ffee:c9cf:bdec])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71df0d45323sm3993759b3a.122.2024.10.07.02.45.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Oct 2024 02:45:15 -0700 (PDT)
Date: Mon, 7 Oct 2024 18:45:11 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Yang Yang <yang.yang@vivo.com>
Subject: Re: block: del_gendisk() vs blk_queue_enter() race condition
Message-ID: <20241007094511.GA10794@google.com>
References: <Zv6d1Iy18wKvliLm@infradead.org>
 <Zv6fbloZRg2xQ1Jf@infradead.org>
 <20241003140051.GM11458@google.com>
 <20241003141709.GN11458@google.com>
 <20241004042127.GO11458@google.com>
 <Zv-O9tldIzPfD8ju@infradead.org>
 <20241004074818.GP11458@google.com>
 <Zv_ddkAZhjC9OQyo@infradead.org>
 <20241004143234.GR11458@google.com>
 <ZwN7OTXW3uDBbo--@infradead.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZwN7OTXW3uDBbo--@infradead.org>

On (24/10/06 23:10), Christoph Hellwig wrote:
> On Fri, Oct 04, 2024 at 11:32:34PM +0900, Sergey Senozhatsky wrote:
> > Hmm, setting QUEUE_FLAG_DYING unconditionally in __blk_mark_disk_dead()
> > implies moving it up, to the very top of del_gendisk(), before the first
> > time we grab ->open_mutex, because that's the issue that we are having.
> > Does this sound like re-introducing the previous deadlock scenario (the
> > one you pointed at previously) because of that "don't acquire ->open_mutex
> > after freezing the queue" thing?
> 
> So the trace of that one is literally the same as the one you reported,
> and I'm still wondering how they are related (I hope Yang Yang can
> chime in)
>
> I suspect that if we mark both the disk and queue dead
> early that will error out everything and should fix it.

Does the diff below look like something that you are thinking about?

__blk_mark_disk_dead() cannot be moved alone, we need
blk_report_disk_dead() before it.  And all of these should be
done before the first time we take ->open_mutex.

I keep __blk_mark_disk_dead() the way it is and just forcibly
set QUEUE_FLAG_DYING right before __blk_mark_disk_dead(), so
that hopefully bio_queue_enter() can detect DYING.

---

diff --git a/block/genhd.c b/block/genhd.c
index 1c05dd4c6980..3b2a7e0f2176 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -649,6 +649,16 @@ void del_gendisk(struct gendisk *disk)
 
 	disk_del_events(disk);
 
+	/*
+	 * Tell the file system to write back all dirty data and shut down if
+	 * it hasn't been notified earlier.
+	 */
+	if (!test_bit(GD_DEAD, &disk->state))
+		blk_report_disk_dead(disk, false);
+	/* TODO: big fat comment */
+	blk_queue_flag_set(QUEUE_FLAG_DYING, disk->queue);
+	__blk_mark_disk_dead(disk);
+
 	/*
 	 * Prevent new openers by unlinked the bdev inode.
 	 */
@@ -657,18 +667,10 @@ void del_gendisk(struct gendisk *disk)
 		bdev_unhash(part);
 	mutex_unlock(&disk->open_mutex);
 
-	/*
-	 * Tell the file system to write back all dirty data and shut down if
-	 * it hasn't been notified earlier.
-	 */
-	if (!test_bit(GD_DEAD, &disk->state))
-		blk_report_disk_dead(disk, false);
-
 	/*
 	 * Drop all partitions now that the disk is marked dead.
 	 */
 	mutex_lock(&disk->open_mutex);
-	__blk_mark_disk_dead(disk);
 	xa_for_each_start(&disk->part_tbl, idx, part, 1)
 		drop_partition(part);
 	mutex_unlock(&disk->open_mutex);
@@ -714,6 +716,10 @@ void del_gendisk(struct gendisk *disk)
 	rq_qos_exit(q);
 	blk_mq_unquiesce_queue(q);
 
+	/* TODO: big fat comment */
+	if (test_bit(GD_OWNS_QUEUE, &disk->state))
+		blk_queue_flag_clear(QUEUE_FLAG_DYING, disk->queue);
+
 	/*
 	 * If the disk does not own the queue, allow using passthrough requests
 	 * again.  Else leave the queue frozen to fail all I/O.
