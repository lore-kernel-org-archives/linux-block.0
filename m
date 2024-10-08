Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 025682B9BB
	for <linux-block@vger.kernel.org>; Tue,  8 Oct 2024 05:31:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728365466; cv=none; b=TJEbEtQiFxlE+Y5fc6apfXhWTXvDFAu9cu7IkyEZO0qwCCH0vtUns8Gs18Hmd6ZwEE4rxuNmNBoiOcvqOg26luKk+kG5U8XM6zMdiQEpXU70bGw0WqUD7+06nHx6a8iLWz/iIgxiEMXBPgr1Yk5q/CDQUUgiFYBOSd/vfUsC+4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728365466; c=relaxed/simple;
	bh=IAfiDToOJW+Ez7XrG/0lJuA4sFwOif89lRvUHXMRY94=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f1PWCyHo56zdtFu9YLiV6WhNEmdw5iD8v+Cg71gDc69JjyyV2rMLDl9AKM2yrPSd7SzEJLuKm87MmDP62NfJr39OgVR1+X13GGGjRGY22KG90SdzOp7chMe123R6ToQlOjvsqe3JcQDnl1BtgxCY8IYemdYzjyUzhNmYcuSs41I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=d5SVoUZh; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="d5SVoUZh"
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-71e03be0d92so1224674b3a.3
        for <linux-block@vger.kernel.org>; Mon, 07 Oct 2024 22:31:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1728365464; x=1728970264; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=B17KIKbJwD3hYF4U7LKe5kxdqR3+qRfR5jlXRt0ED8U=;
        b=d5SVoUZhcS76PpWg4nooCfLDbRPq8FvlGeuieu50jPfM8c80VrJrvI1P3dC5Tl3f4A
         yQOMcBcnDbTF+W/Zd7d49C6nXaWU9I9a6KXbWYj4RY0xhaTcuERqAiHxlRZpc0jDwz9O
         OAdQtyhvXbr1Z4F354RaptWMnxvvKJG/ZQE+o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728365464; x=1728970264;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B17KIKbJwD3hYF4U7LKe5kxdqR3+qRfR5jlXRt0ED8U=;
        b=bzzV2B66DEw+sI5aLZZs3nYk5cIq7RTn+FqLhpRYLVkGWcEOQPTwFdYYGi5jEefBJQ
         IgxLdvnLv4dMJOvo8IkF+aC2twu10+cbsDuzDnRM1YanslKPgO/l6RQU/Yv2kTaTRgtY
         MVxHgRkeKCeIDneNmaSeH1OQ9JsZE0XcRbkwrsxJnf0J/c/MSI6zh8CvfSGqfTxCZ12h
         wRkiN6z1bM0UZPWkqINpzcIvUm1Mva+Mdjvg2InO1wvGIbEFO8ZSal/pGrrSQk2AWYKl
         FPhmaaYdpw40G/a3wlpUiCxRqE1uyAszaRfLLHw072bKi8SLqENU3Rv2oQr+2Q1YdgP2
         dnHQ==
X-Forwarded-Encrypted: i=1; AJvYcCXcgCL8FgHMIzNcLmZKfNvI/Sn0EZE4CBa7IjYdqM/Xl1wfl6hFImOo6PVWSucj+KU5AjtAZnRXKhwsXg==@vger.kernel.org
X-Gm-Message-State: AOJu0YyEzhsTamNNiY13UE0MtqGSSlnQ7/HPbANTp1JtiVSafAbhl3f7
	vGUkF2l5ZJUFKmG85r2c/A21itaeg6+J4BI54hSYmCAVlxr3iJ7aRoWHqw+n+w==
X-Google-Smtp-Source: AGHT+IEtcS5b4gGpaB8JNzh8Up4fWGeeQSSyzx0HTSQqD1ZRDi/yRiEv7EbHvneCNro58Vqyjqnm0w==
X-Received: by 2002:a05:6a00:2e96:b0:71d:fad0:df17 with SMTP id d2e1a72fcca58-71dfad0e101mr13870512b3a.15.1728365464250;
        Mon, 07 Oct 2024 22:31:04 -0700 (PDT)
Received: from google.com ([2401:fa00:8f:203:e05b:ffee:c9cf:bdec])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71df0cbd78fsm5329767b3a.4.2024.10.07.22.31.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Oct 2024 22:31:03 -0700 (PDT)
Date: Tue, 8 Oct 2024 14:31:00 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: Christoph Hellwig <hch@infradead.org>, Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org, Yang Yang <yang.yang@vivo.com>
Subject: Re: block: del_gendisk() vs blk_queue_enter() race condition
Message-ID: <20241008053100.GD10794@google.com>
References: <Zv6fbloZRg2xQ1Jf@infradead.org>
 <20241003140051.GM11458@google.com>
 <20241003141709.GN11458@google.com>
 <20241004042127.GO11458@google.com>
 <Zv-O9tldIzPfD8ju@infradead.org>
 <20241004074818.GP11458@google.com>
 <Zv_ddkAZhjC9OQyo@infradead.org>
 <20241004143234.GR11458@google.com>
 <ZwN7OTXW3uDBbo--@infradead.org>
 <20241007094511.GA10794@google.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241007094511.GA10794@google.com>

On (24/10/07 18:45), Sergey Senozhatsky wrote:
> +	/*
> +	 * Tell the file system to write back all dirty data and shut down if
> +	 * it hasn't been notified earlier.
> +	 */
> +	if (!test_bit(GD_DEAD, &disk->state))
> +		blk_report_disk_dead(disk, false);
> +	/* TODO: big fat comment */
> +	blk_queue_flag_set(QUEUE_FLAG_DYING, disk->queue);
> +	__blk_mark_disk_dead(disk);
> +
>  	/*
>  	 * Prevent new openers by unlinked the bdev inode.
>  	 */
> @@ -657,18 +667,10 @@ void del_gendisk(struct gendisk *disk)
>  		bdev_unhash(part);
>  	mutex_unlock(&disk->open_mutex);
>  
> -	/*
> -	 * Tell the file system to write back all dirty data and shut down if
> -	 * it hasn't been notified earlier.
> -	 */
> -	if (!test_bit(GD_DEAD, &disk->state))
> -		blk_report_disk_dead(disk, false);
> -
>  	/*
>  	 * Drop all partitions now that the disk is marked dead.
>  	 */
>  	mutex_lock(&disk->open_mutex);
> -	__blk_mark_disk_dead(disk);
>  	xa_for_each_start(&disk->part_tbl, idx, part, 1)
>  		drop_partition(part);
>  	mutex_unlock(&disk->open_mutex);
> @@ -714,6 +716,10 @@ void del_gendisk(struct gendisk *disk)
>  	rq_qos_exit(q);
>  	blk_mq_unquiesce_queue(q);
>  
> +	/* TODO: big fat comment */
> +	if (test_bit(GD_OWNS_QUEUE, &disk->state))

       if (!test_bit()), muppet.

> +		blk_queue_flag_clear(QUEUE_FLAG_DYING, disk->queue);
