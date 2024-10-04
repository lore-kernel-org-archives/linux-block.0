Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ACD1217330
	for <linux-block@vger.kernel.org>; Fri,  4 Oct 2024 14:32:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728052361; cv=none; b=gM2isD726I4fEKG9X3UR7Rk/Z5XyW3PkZEBWJTvs7I6eNmh4Ru+VmOV4P8N/SDnreNsXQUb9MSQzGkoyyDT8FTsGxxJipCl1ep+KL/GFDHyf58ehcqdfeMe4hTizSu7t1IcGIQ69kk9gMw7/5biHpwlNEJnIR+70EneEBt/G73E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728052361; c=relaxed/simple;
	bh=F8PsO+BnwCJVC3akmaDfGnwEiRevyDbGGoLVqNO7VTw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cGS0ybd/7gubKI13clPe+JrP00YBKM+Cleja6wFTBYy7QIqcdavU7rGqaWGE0elRny9vSmpiC70SYxqfgogzkSCgbC4EdZUscy0f5MNl/blNashryyywjk4/T5F/0HpCTpBrsmxt2d8hlQFRMh4ffm8Ys89ZLHnPAWzcqzJw9EM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=YV4OCnLv; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="YV4OCnLv"
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-71970655611so2066537b3a.0
        for <linux-block@vger.kernel.org>; Fri, 04 Oct 2024 07:32:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1728052359; x=1728657159; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=jGOVuLxflFVNxqaDGKYkyq7bKX0WqijX5gWjK6fbSfo=;
        b=YV4OCnLvC9OtzsYuaJ377Nsth88pzwhlYbx+7qL3QuiIDuyiKgi3wSQPij9+5cW9M1
         k+0oikAoAFyVD8NdzSu5zHTpxnWfYqqN7gRxAWnO4eXV1YAJyBfV5lEX4MP1XtpOogCu
         9ggJct/ftTgIEomYI5Rcv82hB8gaI8tZkqN6o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728052359; x=1728657159;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jGOVuLxflFVNxqaDGKYkyq7bKX0WqijX5gWjK6fbSfo=;
        b=wJmUFbxGR/bdR3erX+KCORjYdt3HdkHa4WAo7a177hH3KVncE4Z7ZNH988PrwiF/+T
         GREVJ82nPS8orjElT19l12/YasZoJGmqbpsCDbo5njRro2tQ2x/mnpkGqvBjxkE2AI3I
         wRZ9ZFmfbbjFNF7bAbsi6VxHCGO/dGQ4lunNLEofXuXKTEEk5bXbehg/l0+cDG8nKMTh
         9CXEetwDk2XldK8nGBSj1n4r+txGWIAwVWUhiUQ4kULmfkXzendmRvdCOQGV0CbpRS04
         Ioc8cpfN8WowcQKgid5VPT79NErcMz+tG3QUa9q+A1n8zFZSfeROI8N8TMRz6Co5CrG8
         lbGg==
X-Forwarded-Encrypted: i=1; AJvYcCW6BQI4pCXlsJsbyiaZ6JhEmTNf+HO0MgEPXWhNVko0CayyzSo5HyDArS4il1IlxyEfzZC2QU5PgW0qZQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6Kv08M/8DJY/unsrV/J4Su9R3/u+Ju9pf5DRBODvb+BsEgK7x
	OTbAo7wqAfbZAjjZa2u4ktt3UbNiGCi3Nzj5pzy9vk0hW1REoRIEip90WZnKiw==
X-Google-Smtp-Source: AGHT+IFW6CoB4T2NkyJVW1ixt0XrONiXKf9TMTr1q/qQkG9eMOXRbXl39yOVbxRZcpZzrW0suZiZIg==
X-Received: by 2002:aa7:88c9:0:b0:70e:9907:ef75 with SMTP id d2e1a72fcca58-71de23a57a1mr5609940b3a.4.1728052359616;
        Fri, 04 Oct 2024 07:32:39 -0700 (PDT)
Received: from google.com ([2401:fa00:8f:203:17b3:dfd3:7130:df15])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71dd9ddb69fsm3366143b3a.98.2024.10.04.07.32.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Oct 2024 07:32:38 -0700 (PDT)
Date: Fri, 4 Oct 2024 23:32:34 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Yang Yang <yang.yang@vivo.com>
Subject: Re: block: del_gendisk() vs blk_queue_enter() race condition
Message-ID: <20241004143234.GR11458@google.com>
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
> On Fri, Oct 04, 2024 at 04:48:18PM +0900, Sergey Senozhatsky wrote:
> > diff --git a/block/blk-core.c b/block/blk-core.c
> > index bc5e8c5eaac9..ccd36cb5ada7 100644
> > --- a/block/blk-core.c
> > +++ b/block/blk-core.c
> > @@ -292,6 +292,16 @@ void blk_queue_start_drain(struct request_queue *q)
> >  	wake_up_all(&q->mq_freeze_wq);
> >  }
> >  
> > +void blk_queue_disk_dead(struct request_queue *q)
> > +{
> > +	struct gendisk *disk = q->disk;
> > +
> > +	if (WARN_ON_ONCE(!test_bit(GD_DEAD, &disk->state)))
> > +		return;
> > +	/* Make blk_queue_enter() reexamine the GD_DEAD flag. */
> > +	wake_up_all(&q->mq_freeze_wq);
> > +}
> 
> Why is this a separate helper vs just doing the wake_up_all in the
> only caller that sets (with the suggested fixup anyway) GD_DEAD?

It looked to me like whatever happens to ->mq_freeze_wq stays in Las^W
blk-core or blk-mq, so I added a new helper to follow suit, IOW to not
spread ->mq_freeze_wq wakeup across multiple files.

> > +			   blk_queue_dying(q) ||
> > +			   test_bit(GD_DEAD, &disk->state));
> 
> This needs to check for a NULL disk.

Ack.

> And now that I'm looking at the code a bit more this makes me worried
> that checking for q->disk here sounds like a good way to hit a race with
> clearing it.  So I fear we need the other hack variant that sets
> QUEUE_FLAG_DYING unconditionally in __blk_mark_disk_dead and then clears
> it again (for GD_OWNS_QUEUE only) toward the end of del_gendisk.

Hmm, setting QUEUE_FLAG_DYING unconditionally in __blk_mark_disk_dead()
implies moving it up, to the very top of del_gendisk(), before the first
time we grab ->open_mutex, because that's the issue that we are having.
Does this sound like re-introducing the previous deadlock scenario (the
one you pointed at previously) because of that "don't acquire ->open_mutex
after freezing the queue" thing?
