Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D2F2156CF
	for <linux-block@vger.kernel.org>; Fri,  4 Oct 2024 14:41:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728052880; cv=none; b=qtZpZbecsqgWHxgcbSSVY43bB5xZe99d5UMldonRheJm+Q1GlK/Fjkb5CRHcjhHsnLgusrgbsAOFWskB6DtGkyqArIEFtfq4M0szW3ti5vpnv23HzBNbp5EWFmq8UB6+ngYKWdHjHyyUPtWZDW9NpONBxXC4HsiMufc49GteIoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728052880; c=relaxed/simple;
	bh=H1NA4KlGMXoH2/fXUr/RX5rs7C/uXDqE0r+EPQqR168=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=agnpCo+1TE9F7zk1j1U8cDivMBTIVegTxngDSsqMkVkrpRel7IRp9QeUCKn2YXliNg9LtoCxUG0xuhVjd5jkv9Tvgvwe7qY+8OaNlPDKQ09MXh4x2YgMzA+y5hYYfZcRfx+cxs9YYDyoqSy8CQFsqA+7N6qdLmIxHDP/r2JeUEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=PwKks+N4; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="PwKks+N4"
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-7e6d04f74faso1865790a12.1
        for <linux-block@vger.kernel.org>; Fri, 04 Oct 2024 07:41:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1728052878; x=1728657678; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=U/KMzpXLSFW7nopAcwssRx4fHTJn/Em8LJvbGMYdVno=;
        b=PwKks+N4Gn1nJVwkEhtnwNqqMhGuzkEVyRr1jQwO7I4Wr5uPdrLnWFVLTkrgnlJ5WC
         4YuQ7r9FWyULC+eXDcLgcNcKd6/zuwBiqK3VsYzW06ZL4OooX35lsP8B0ESCVUWVK9Fz
         ZouykIJvQyCSuyUp+5D9y35s0QHzR2MSrIqhs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728052878; x=1728657678;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U/KMzpXLSFW7nopAcwssRx4fHTJn/Em8LJvbGMYdVno=;
        b=mMD4Rr5qbdOy/hUmV2xQikYDl5rKW8VoDpsaG53L/fqmDXXCM02vfNycTe3usi+zS3
         hoL0O4KPME6ODN4tKcXuSncM/sFQuiu+JVsMyL+eXbQbpPxt5PuGhTEFGkKlqYWbROYl
         cJROwpwZGWUAtBQ5sUEYOKFmye1sSSUX0My2gm58oa99YuUns0pGNG9AXq/WyTE/v+7s
         JWK4ho9vSCXxxJCZS596jkBhdoDzDHnk8xmTf2B2Y1ZCgv1fM9wHOWRwC7s6OEs7xuvo
         LIHztHcXm2Gloa86wlomDVWslcyhAFyQdj8chDm0zOPgn2y23qxuzFCK1RBhIIPHQepo
         4Jbw==
X-Forwarded-Encrypted: i=1; AJvYcCUt1Jh5eXbqOxEzKNaBNi5ndYKI6q2lcrd9N8SgdGHnoLt4YAYPU0hzcUNyHLnLvesn7XYcFz3BFsJLyA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwDGGNDAUMBWuq1r4WzHZ9DMyTak98fv6eCYD6INfFYNqhKuHgA
	M4bLd+QiyT5i93vKx8z+LBg9+6cDP4Cj9Tau/Sk01HGAJJzTiyNYHLfNEnuIJw==
X-Google-Smtp-Source: AGHT+IGjE5i2EwKgWQxYkmq74iwg0IXwWL7GkHw6WF3t4qtxWwmvvupN+xB6qqnOWiReWdGvogZhjg==
X-Received: by 2002:a05:6a20:db0d:b0:1d3:1fea:27d8 with SMTP id adf61e73a8af0-1d6e02b197dmr4273976637.5.1728052877619;
        Fri, 04 Oct 2024 07:41:17 -0700 (PDT)
Received: from google.com ([2401:fa00:8f:203:17b3:dfd3:7130:df15])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71dd9def6f6sm3383524b3a.148.2024.10.04.07.41.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Oct 2024 07:41:17 -0700 (PDT)
Date: Fri, 4 Oct 2024 23:41:13 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Yang Yang <yang.yang@vivo.com>
Subject: Re: block: del_gendisk() vs blk_queue_enter() race condition
Message-ID: <20241004144113.GS11458@google.com>
References: <20241003085610.GK11458@google.com>
 <Zv6d1Iy18wKvliLm@infradead.org>
 <Zv6fbloZRg2xQ1Jf@infradead.org>
 <20241003140051.GM11458@google.com>
 <20241003141709.GN11458@google.com>
 <20241004042127.GO11458@google.com>
 <Zv-O9tldIzPfD8ju@infradead.org>
 <20241004074818.GP11458@google.com>
 <Zv_ddkAZhjC9OQyo@infradead.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zv_ddkAZhjC9OQyo@infradead.org>

On (24/10/04 05:20), Christoph Hellwig wrote:
> This needs to check for a NULL disk.  And now that I'm looking at the
> code a bit more this makes me worried that checking for q->disk here
> sounds like a good way to hit a race with clearing it.  So I fear we
> need the other hack variant that sets QUEUE_FLAG_DYING unconditionally
> in __blk_mark_disk_dead and then clears it again (for GD_OWNS_QUEUE
> only) toward the end of del_gendisk.

Something like this?

---

diff --git a/block/genhd.c b/block/genhd.c
index 1c05dd4c6980..aca43c8fa4ed 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -589,9 +589,6 @@ static void __blk_mark_disk_dead(struct gendisk *disk)
 	if (test_and_set_bit(GD_DEAD, &disk->state))
 		return;
 
-	if (test_bit(GD_OWNS_QUEUE, &disk->state))
-		blk_queue_flag_set(QUEUE_FLAG_DYING, disk->queue);
-
 	/*
 	 * Stop buffered writers from dirtying pages that can't be written out.
 	 */
@@ -649,6 +646,9 @@ void del_gendisk(struct gendisk *disk)
 
 	disk_del_events(disk);
 
+	blk_queue_flag_set(QUEUE_FLAG_DYING, disk->queue);
+	wake_up_all(&disk->queue->mq_freeze_wq);
+
 	/*
 	 * Prevent new openers by unlinked the bdev inode.
 	 */
@@ -725,6 +725,9 @@ void del_gendisk(struct gendisk *disk)
 		if (queue_is_mq(q))
 			blk_mq_exit_queue(q);
 	}
+
+	if (!test_bit(GD_OWNS_QUEUE, &disk->state))
+		blk_queue_flag_clear(QUEUE_FLAG_DYING, disk->queue);
 }
 EXPORT_SYMBOL(del_gendisk);
 
