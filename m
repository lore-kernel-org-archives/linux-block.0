Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 253CE194C6B
	for <linux-block@vger.kernel.org>; Wed,  9 Oct 2024 12:31:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728477090; cv=none; b=hHbk6QRYsoSWnSjIQwSYP35pV+Q8AjdCfk9q/ul4pBLw5JUS9KmRR0jx+AQBLgvGKtLvaJH82dbWe8U1ZxNFYfwVb4x68LZbrAxRFMaTjKA5IQTjTVMkFqqceXNEJSUo9r8KsIKe3QATo9VLRy0sg+zBshC33VfLnGs6ejfncIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728477090; c=relaxed/simple;
	bh=cOvvflAY+UKCrgaE6fEgUsG9uJKx5LbBcX3JC5MCYCs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ggmz3hsRG5iP/nz5BtGU5UWkCFHKg3F6/thuvAjh1eBFWCpwjGZdnGA+1KRScjZtAa4WQWdq6SdiqvhOdhTHVa746Tngk5HUZLowWSs7p9A0u+hHQ3rm335YATU82wTHAxJzPiSlJtGajqH9ffUPLt0018sujUFfmk5OrAbSMbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=BPLkan4w; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="BPLkan4w"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-20c5a7b2908so14062545ad.1
        for <linux-block@vger.kernel.org>; Wed, 09 Oct 2024 05:31:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1728477088; x=1729081888; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=vKRrOvOng89GxY0kT9JZM7KgVKoTAVdb6vLt5frKzsA=;
        b=BPLkan4wpudk4h0AnkI2mnAJKzA+6zSMBu3Bu0DyvJyqFahYEB2Tjv9ols//rZCLiz
         CbT+fnLm6FAkx0ewwmd9FAuZAgvl4qfq3s1GZ6JbfjYdjy9k6+h/bCTHUJAmEc0AmLBE
         A6NAYRP8YG7mUFPX+VPGTlCewyudLBwpu0OUk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728477088; x=1729081888;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vKRrOvOng89GxY0kT9JZM7KgVKoTAVdb6vLt5frKzsA=;
        b=cFoEN5gyAIFp9znUfq8abc2kyCLrdu1VuHBQbshAmin3e1+I4HEbemgonlo80v+O3g
         AeMv0erR4wkhMNHv/221VGT4OXRsrVGW5Fz8VtaQue32Iq0Sc1+URRIUWKxLj9fEZJ34
         ELXWGrzq69BuptZIN+pEfhhqdW67mLzLCABk58PYTtjG/0dqfHvmRK2f+QHytQ0SDzVc
         lR8ZxuNo2zAwUHuuuDwr1fxNFqSzAf+ygfc0zDmQlCDNPSX0FXo8SEDjt7GxxNJf+zCN
         u1dM5BrT6wjiEKnq0EWohewK/1bhbDCmUH0lueQLzHpBC7jgr/YR+YwIpK+Z3R12lP6J
         7wjw==
X-Forwarded-Encrypted: i=1; AJvYcCWQb+UhGQYeZ6V3KK4V4aznGlo1Oa9TLoDiiaboIp1tVAYi/JwZMPPmDTQJONMN/e0iDQ+36HcrcTqmBg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzIozaKKkLHhfBEVwqSCHKxS6tw1Cy3hNSwAkvJxk1Xd/LX5CVq
	F17vKXnUaoSIMRtHPme4RdI0yvmawxV3C3mISfpocKeiQ+0m4/a7qkIf5sovJw==
X-Google-Smtp-Source: AGHT+IGOKsrFraGcWhoktYq79UGQ94PGL4B5zoNPkMy0leHK9jI+b4sgRi6Ce0aqh14YcZP5pk1tVA==
X-Received: by 2002:a17:903:2450:b0:20c:60a0:78cb with SMTP id d9443c01a7336-20c6377f740mr43478825ad.38.1728477088356;
        Wed, 09 Oct 2024 05:31:28 -0700 (PDT)
Received: from google.com ([2401:fa00:8f:203:52d9:628d:d815:8496])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20c13968b54sm69837315ad.207.2024.10.09.05.31.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Oct 2024 05:31:27 -0700 (PDT)
Date: Wed, 9 Oct 2024 21:31:23 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	YangYang <yang.yang@vivo.com>, linux-block@vger.kernel.org
Subject: Re: [PATCH 1/2] block: also mark disk-owned queues as dying in
 __blk_mark_disk_dead
Message-ID: <20241009123123.GD565009@google.com>
References: <20241009113831.557606-1-hch@lst.de>
 <20241009113831.557606-2-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241009113831.557606-2-hch@lst.de>

On (24/10/09 13:38), Christoph Hellwig wrote:
[..]
> @@ -589,8 +589,16 @@ static void __blk_mark_disk_dead(struct gendisk *disk)
>  	if (test_and_set_bit(GD_DEAD, &disk->state))
>  		return;
>  
> -	if (test_bit(GD_OWNS_QUEUE, &disk->state))
> -		blk_queue_flag_set(QUEUE_FLAG_DYING, disk->queue);
> +	/*
> +	 * Also mark the disk dead if it is not owned by the gendisk.  This
> +	 * means we can't allow /dev/sg passthrough or SCSI internal commands
> +	 * while unbinding a ULP.  That is more than just a bit ugly, but until
> +	 * we untangle q_usage_counter into one owned by the disk and one owned
> +	 * by the queue this is as good as it gets.  The flag will be cleared
> +	 * at the end of del_gendisk if it wasn't set before.
> +	 */
> +	if (!test_and_set_bit(QUEUE_FLAG_DYING, &disk->queue->queue_flags))
> +		set_bit(QUEUE_FLAG_RESURRECT, &disk->queue->queue_flags);
>  
>  	/*
>  	 * Stop buffered writers from dirtying pages that can't be written out.
> @@ -719,6 +727,10 @@ void del_gendisk(struct gendisk *disk)
>  	 * again.  Else leave the queue frozen to fail all I/O.
>  	 */
>  	if (!test_bit(GD_OWNS_QUEUE, &disk->state)) {
> +		if (test_bit(QUEUE_FLAG_RESURRECT, &q->queue_flags)) {
> +			clear_bit(QUEUE_FLAG_DYING, &q->queue_flags);
> +			clear_bit(QUEUE_FLAG_RESURRECT, &q->queue_flags);
> +		}

Christoph, shouldn't QUEUE_FLAG_RESURRECT handling be outside of
GD_OWNS_QUEUE if-block? Because __blk_mark_disk_dead() sets
QUEUE_FLAG_DYING/QUEUE_FLAG_RESURRECT regardless of GD_OWNS_QUEUE.


// A silly nit: it seems the code uses blk_queue_flag_set() and
// blk_queue_flag_clear() helpers, but there is no queue_flag_test(),
// I don't know what if the preference here - stick to queue_flag
// helpers, or is it ok to mix them.

>  		blk_queue_flag_clear(QUEUE_FLAG_INIT_DONE, q);
>  		__blk_mq_unfreeze_queue(q, true);
