Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 551221DE89D
	for <linux-block@vger.kernel.org>; Tue,  8 Oct 2024 08:20:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728375658; cv=none; b=jdqjSL0dqjf1TKs4U8zIgRByATHhH8whLBnj193LhrM74lhE3+9vRjJon5ZTQCDa8waeALqfCSdpHtPPybpcI+9fEYxkyUmwlHRc9BL4shXxyjawPa4rPyyABnXTHeik3MhmUQOcLq9JMaPx+G92HPzc5LBOJSbB5EnJmdsIYCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728375658; c=relaxed/simple;
	bh=ljQrM7B4sfJpM4WrK19gDwfNYUxlHnr8Ji4wA2/L0Mw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DU96T+SL6j38MM1Gi9XpTT9cVr1eysGuFzTEXsQPdlZAa7k/6T8m5CYZK6aWVogZQDenoRuoSUjmsdcs20wSZbasilY+kX3LHQpi5LyePKwJhqcR2wAjhm8r2L4lT1TwKZAz5JE1hVTfZz5VZK2QfNSdD0twvB6FijoNrA/+OLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Y24507tO; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Y24507tO"
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-2e09ff2d890so4502968a91.0
        for <linux-block@vger.kernel.org>; Tue, 08 Oct 2024 01:20:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1728375657; x=1728980457; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+oXLtGSHe5om8v6PBFoBrZroby7ALXloXdoI+49xFMs=;
        b=Y24507tOINdzkt2LGTy9+jQk0ZfYGDR6cqVtE82BNUMaJ2FjBncoDCeNH8hv1d86xW
         WP9QZtpazg1rQPhJ2eGbM63URRDmN5xoh9dTYGvAAUZrB+8CCcC0M8IONIuWrGmASQWF
         0Ctu6FaHI2zSMqynsn2zA1Bq2MncBnhfU2o9E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728375657; x=1728980457;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+oXLtGSHe5om8v6PBFoBrZroby7ALXloXdoI+49xFMs=;
        b=Q09k7lPVrxwxRpERjPwaBcGEoUkc5mzp24cue/CpIfpwYwGEVGyGqUA/V74jguiNyv
         ZHpFQicFz5nNJ+SyZgsfrHkIkJ75mLPl5/2Evx7L94ryxXFtqm5EFn7gGmAhgiBnZzfS
         FjpkLmjQD9mW49aQZQSldvIUBj51zA0yuA7Ej8ZTQiRB9+Z3zYNvFFkORYoGWOHl5k1Q
         CrzOxsutQ7h5el0XWL+iOn59X48g/kQhe+9aZMnBIHPSgpVbR48WM04DovFIYBeKgKk1
         COjBjvCEgenWkIwDqCZ7ie7qED/dtQMNXzSLYOJfMgW6kLDARmoPoyCZl77Sz0pm2CZg
         pWXA==
X-Forwarded-Encrypted: i=1; AJvYcCUoVmuXB9h56aKALd0tB6lBLhE4TV+xKKpLoLvJPlcFrf1kK6rlUVGoWLwoA8SCCzgtm8TCRM8JK7WEtQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YyY/+GHRRV2LTnaBTgJ/rfxYnXbZFid8I5BuguCvI2uE8PNuHQ6
	bnylS/6mJFsKz3ZJwUEJzegm+8/VFFrC1nKBn7ZlLQ7hwjTgv68H7tFNN/mJSA==
X-Google-Smtp-Source: AGHT+IGt4zjrCp4TSKLjR4i6ftAHPqgAifUbRtQSDpQBw50EEVcO6VyrqxgHlu/OqtQu8crW1sV4Ig==
X-Received: by 2002:a17:90b:3891:b0:2d8:9506:5dfd with SMTP id 98e67ed59e1d1-2e1e636770fmr17522849a91.35.1728375656724;
        Tue, 08 Oct 2024 01:20:56 -0700 (PDT)
Received: from google.com ([2401:fa00:8f:203:7cab:8c3d:935:cbd2])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e28b773a77sm737439a91.11.2024.10.08.01.20.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Oct 2024 01:20:56 -0700 (PDT)
Date: Tue, 8 Oct 2024 17:20:52 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	YangYang <yang.yang@vivo.com>, linux-block@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>
Subject: Re: block: del_gendisk() vs blk_queue_enter() race condition
Message-ID: <20241008082052.GF10794@google.com>
References: <20241003085610.GK11458@google.com>
 <b3690d1b-3c4f-4ec0-9d74-e09addc322ff@vivo.com>
 <20241008051948.GB10794@google.com>
 <20241008052617.GC10794@google.com>
 <ZwTJj5__g-4K8Hjz@infradead.org>
 <20241008061053.GE10794@google.com>
 <ZwTprM-QVvMQX3Eo@infradead.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZwTprM-QVvMQX3Eo@infradead.org>

On (24/10/08 01:13), Christoph Hellwig wrote:
> On Tue, Oct 08, 2024 at 03:10:53PM +0900, Sergey Senozhatsky wrote:
> > cd->lock still falls a victim of
> > "blk_queue_enter() and blk_queue_start_drain() are both called under ->open_mutex"
> > thingy, which seems like a primary problem here.  No matter why
> > blk_queue_enter() sleeps, draining under ->open_mutex, given that what we
> > want to drain can hold ->open_mutex, sometimes isn't going to drain.
> 
> Yes. So I think we'll need to move __blk_mark_disk_dead out
> of ->open_mutex again

Right, we also need to make sure that we drain before we try to
lock ->open_mutex in gel_dendisk() for the first time.

> it also isn't protected when calling blk_mark_disk_dead, but we'll
> also need to stop the SCSI LLDs from submitting new commands from
> their ->relase routines.   Let me cook up a little series..

Thank you!
