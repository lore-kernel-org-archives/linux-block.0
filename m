Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E97F2629D
	for <linux-block@vger.kernel.org>; Sat, 19 Oct 2024 12:37:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729341454; cv=none; b=Ysoa32Ey7dGnwf/Om1uEpN+CtHkIytbk7WpNRel88pyfRNqIoti4daTWilCodFgU1SOjSRrpuU85N3+bcIf7eua1wwyIWkjeFBiCkC1PlwtV9OkGjOOUInlSTtOBk8+cfZCBN0FiuyZxp3onP5e0obz2b3ra7L0HNpcOQ/A0dhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729341454; c=relaxed/simple;
	bh=+6qo2mgBr3FQ6tGCgif3LKnjPCMGrVa3ZZbWV1l5/t0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LL+ocZ+34OWXqCis/BuPJcQDtOEAiBT1oBCrjhuVcFVu2PrMwSxJl7VIu1hMEqckyVd5DuRrMJfKMIz11pPO00uALCduM/3W1HlnZQ3eQF2CVEahnG/By+qk4hfpJGbR2h104gpV1MQmv9kxyx30rQmkY1KfzoLim/RdTBJxp4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=iG6NZLxk; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="iG6NZLxk"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-20ce65c8e13so26454595ad.1
        for <linux-block@vger.kernel.org>; Sat, 19 Oct 2024 05:37:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1729341451; x=1729946251; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=95dbupw36UI+8Q6H/9D0wZnW4PrnA2d20dFuvAUzZzg=;
        b=iG6NZLxktzHdhscwQGFFCUWuT6wfsYcXT99UcFd86uSeChFaC62aNWyUyerqTBs6Ka
         qJYo7EJ33d8Oy1pkaxhOjIhHDswFWXXNe2adXmTRNYQlPoOp4tUBAnhjesPTKCDIPO1O
         FdQBRgwnjiYs9aomniGu8CvqcOO1SqvNUqtRo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729341451; x=1729946251;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=95dbupw36UI+8Q6H/9D0wZnW4PrnA2d20dFuvAUzZzg=;
        b=jvU9Ef5i7V+kKf6havI9NZaX/qxqsxmLE7KfuDEXrJrdEe1jMGd60T0rCoPpAnMkJl
         4cBtcvdVB1Qz+8fI4tzcRxPXK9F+XJIBTGyxr6Kn7glpOBybbJWqtpj0h2ptN9MdYND9
         XK9ZTQaO6hLTOmIHv2VWw7MHbMzGwpaa7ZvvUFSPMy9nEwhAw+f9CqKo2IbVfQNQOYUO
         CxlgtYF3BD9YD/QJTOdjJoU41RKDzA3aXgOMapORTj+Mk8kjB4g/aWYx78Qgm//UlahY
         J6TtBTWlQDNYmYQBGxzrJa12wgtN6Y02+De4bOdEJHp29VBV9rv3tHojRKnHUTmHBgHO
         x6DA==
X-Forwarded-Encrypted: i=1; AJvYcCWTnhSYOy6ZXx3TGcGVvLAbc8hddzjygLqaxNGZIIaFiXhawT0oVH0lz5y4OWUNMzgzwJkEfFG/3+8aRQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Ywbj12P6xJW9WvWKcgocbCydXNvaUHvIeCHoPuvaWTxaZikrqI1
	LYc3AKMceQoFORu21onTRbzdPdCnhBwbO5VziRDChNDEvQcn5pxFX8HlmjJ6cA==
X-Google-Smtp-Source: AGHT+IEL+o6erM12SM6xLVGThX4JVBGGxoPYQG5rhAWQAmA6+P9vVVSaNH45lwoVu6LoqN+yq/Kc5Q==
X-Received: by 2002:a17:902:ce89:b0:20c:ecd8:d0af with SMTP id d9443c01a7336-20e5a79f4d7mr78664205ad.9.1729341451605;
        Sat, 19 Oct 2024 05:37:31 -0700 (PDT)
Received: from google.com ([2401:fa00:8f:203:4f31:a9b3:f4ca:dea7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20e5a8f08a2sm27013205ad.182.2024.10.19.05.37.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Oct 2024 05:37:31 -0700 (PDT)
Date: Sat, 19 Oct 2024 21:37:27 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Ming Lei <ming.lei@redhat.com>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
	YangYang <yang.yang@vivo.com>, linux-block@vger.kernel.org
Subject: Re: [PATCH 1/2] block: also mark disk-owned queues as dying in
 __blk_mark_disk_dead
Message-ID: <20241019123727.GE1279924@google.com>
References: <20241009113831.557606-1-hch@lst.de>
 <20241009113831.557606-2-hch@lst.de>
 <Zw_BBgrVAJrxrfpe@fedora>
 <20241019012541.GD1279924@google.com>
 <ZxOmzVLWj0X10_3G@fedora>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZxOmzVLWj0X10_3G@fedora>

On (24/10/19 20:32), Ming Lei wrote:
[..]
> > > When ->release() waits in blk_enter_queue(), the following code block
> > > 
> > > 	mutex_lock(&disk->open_mutex);
> > > 	__blk_mark_disk_dead(disk);
> > > 	xa_for_each_start(&disk->part_tbl, idx, part, 1)
> > > 	        drop_partition(part);
> > > 	mutex_unlock(&disk->open_mutex);
> > 
> > blk_enter_queue()->schedule() holds ->open_mutex, so that block
> > of code sleeps on ->open_mutex. We can't drain under ->open_mutex.
> 
> We don't start to drain yet, then why does blk_enter_queue() sleeps and
> it waits for what?

Unfortunately I don't have a device to repro this, but it happens to a
number of our customers (using different peripheral devices, but, as far
as I'm concerned, all running 6.6 kernel).
