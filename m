Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C683A4C8F
	for <linux-block@vger.kernel.org>; Thu,  3 Oct 2024 14:00:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727964058; cv=none; b=heqaWidrroJZoMdnpZWcP3imREOCPhBG8v4uEJhevKLOytSKEt6A2eoS3utg22vQvVCq/EgJ2HHNYsj9+tVMt2e9gPedE0QlGYQVbS+Yr6ijGyBHWEN/UlLpyqYtEw1NjYMVH/iBDLpwajHa3PyqmkFFBDJTmECDXjhrvCA536Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727964058; c=relaxed/simple;
	bh=RQL4QjpqchFgOcGF2B7uahui+O8eS3CoDAMT+dsZJHI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Uwn6pNqTdQNX+mCHGmW9x+Fk3Axm8LVUogdEkMl0ppWhkST09EjF1AvoGmBZsQGvH/tjj7I61uerYMrZbKWo9jWNNVtesf+ftTfcedhx8G1CcEDnOcpw+tfFGs3Ob4gbToDMdfoFGekOxp7qsO+wBP1HJZzVqLyfMENE1WXCnlU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=nnNFlv6w; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="nnNFlv6w"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-20b4a0940e3so9117165ad.0
        for <linux-block@vger.kernel.org>; Thu, 03 Oct 2024 07:00:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1727964056; x=1728568856; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=753mx/7pCrmnoX7mm74hHzjg0t05RcMqETsZB9pRwag=;
        b=nnNFlv6wuyyP462lQnAsNo9W8RHh5upSXg63fnsqLXJwoJY9NP92yWEjOkeHlEggpe
         t0Z1aL9lx6WefWEoAE7nGtsK2jdwhZ+bAQQnVPZmrcOLk2b7M0GeBjfmCffrXdGxR6hy
         enXvgz5AdzrgjkbXRkn5fehlGw24tas5P4RnE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727964056; x=1728568856;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=753mx/7pCrmnoX7mm74hHzjg0t05RcMqETsZB9pRwag=;
        b=sVL7EOLTgFJhFej7Ar2FUUe5DIcduHRRfsHDPr1MjEixQZn2h5nUGFjB9E0X9xCTMG
         Ejy6YlOck8Qn2BN1D+utqozWgUOuiyI9cLX+xoja/xzcLIeTKoimE2f037v47+bX+VgR
         DuI3nEoXout2KqKL+9MT1gVdlwvrGnxQwLOSONNMpdDEk6BGLKhMVf9aMfbeYqGKjrIm
         os3U25JNgSbpsgn9bSBtbYk6s3LxSFb7QRi2PUqFTEOGLa2nTlf9MxZtdsZsPFa0EHui
         CRwai4pX/Lq0D2zos693cOC4wazQ6c7SkfzTcrTc28HdPlGwGcxFtKtME3lc+AXHuUMh
         4eKg==
X-Forwarded-Encrypted: i=1; AJvYcCXRLmbXXAhYTNDwSQ9rDLrzxRtfap8m7ElIEbF/jhN0QVxCeFF/VpwEQtJ/nEs+p8Q1xIKcquMcBF04Ww==@vger.kernel.org
X-Gm-Message-State: AOJu0YzqT0zdaOnhBzSvataiaHDr9XAshqGLR1mE2TjCqak+tmFC70uw
	WSD7ggOZuNvPKOozWCslKX7SLuJ9SvJjZwjTptQTgN5aqZriM63/t48PKKc//g==
X-Google-Smtp-Source: AGHT+IGiBN2BQXcafaWeNWNeVgDFgbnQA3gNndPbz+AtnoklIimSGUdiTGTX5pVgN25WBZhmy+FuXQ==
X-Received: by 2002:a17:902:f552:b0:20b:9822:66fa with SMTP id d9443c01a7336-20bc5a0b178mr111597335ad.16.1727964056008;
        Thu, 03 Oct 2024 07:00:56 -0700 (PDT)
Received: from google.com ([2401:fa00:8f:203:6c:4e9b:4272:1036])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20bef706f96sm9106035ad.286.2024.10.03.07.00.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Oct 2024 07:00:55 -0700 (PDT)
Date: Thu, 3 Oct 2024 23:00:51 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Subject: Re: block: del_gendisk() vs blk_queue_enter() race condition
Message-ID: <20241003140051.GM11458@google.com>
References: <20241003085610.GK11458@google.com>
 <Zv6d1Iy18wKvliLm@infradead.org>
 <Zv6fbloZRg2xQ1Jf@infradead.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zv6fbloZRg2xQ1Jf@infradead.org>

On (24/10/03 06:43), Christoph Hellwig wrote:
> .. actually, we still clear QUEUE_FLAG_DYING early.  Something like
> the pathc below (plus proper comments) should sort it out:
> 
> diff --git a/block/genhd.c b/block/genhd.c
> index 1c05dd4c6980b5..9a1e18fbb136cf 100644
> --- a/block/genhd.c
> +++ b/block/genhd.c
> @@ -589,9 +589,6 @@ static void __blk_mark_disk_dead(struct gendisk *disk)
>  	if (test_and_set_bit(GD_DEAD, &disk->state))
>  		return;
>  
> -	if (test_bit(GD_OWNS_QUEUE, &disk->state))
> -		blk_queue_flag_set(QUEUE_FLAG_DYING, disk->queue);
> -
>  	/*
>  	 * Stop buffered writers from dirtying pages that can't be written out.
>  	 */
> @@ -673,6 +670,9 @@ void del_gendisk(struct gendisk *disk)
>  		drop_partition(part);
>  	mutex_unlock(&disk->open_mutex);
>  
> +	if (test_bit(GD_OWNS_QUEUE, &disk->state))
> +		blk_queue_flag_set(QUEUE_FLAG_DYING, disk->queue);

So that mutex_lock(&disk->open_mutex) right before it potentially can
deadlock (I think it will).

My idea, thus far, was to

	if (test_bit(GD_OWNS_QUEUE, &disk->state)) }
		blk_queue_flag_set(QUEUE_FLAG_DYING, disk->queue);
		blk_kick_queue_enter(disk->queue);  // this one simply wake_up_all(&q->mq_freeze_wq);
											// if the queue has QUEUE_FLAG_DYING
	}

in del_gendisk() before the very first time del_gendisk() attempts to
mutex_lock(&disk->open_mutex), because that mutex is already locked
forever.

>  	if (!(disk->flags & GENHD_FL_HIDDEN)) {
>  		sysfs_remove_link(&disk_to_dev(disk)->kobj, "bdi");
