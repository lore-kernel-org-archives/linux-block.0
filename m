Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76D6A13D24C
	for <linux-block@vger.kernel.org>; Tue,  8 Oct 2024 06:10:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728367859; cv=none; b=Ocs/QzwOEQpKciRYwFjXF4cEf56AW5hwheljOf0nwItH6UgWRvjZJRrF460cuxf5n1A2251xGl7aK/zgLj3CZdsKCEF23Xu1VNhMX91zrQGjn2uCmac5/E3w6/cUSSR2rxzKYBN2bRHgubIzAOgvH/Q2a/Nnn5bphBGu0Sc7WvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728367859; c=relaxed/simple;
	bh=J7k72rcreHpum8zzs4boKxlDlCONkpsnQW+XKPZjbk0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OyLijc0jhJOyRFl/Ae7bGTZrNw26ZJXb40MAWjWVuNpi/d3t34vjrxrc3520PT3txC4H8DrdI50N/Y7fpEz/E1JmJEpdf2+v/4QNLC4Z7IL74GRGH7fokGdPgCVmqK/IoYRWUzDZzrV3QI/6TN2Ew5ZiJdWZW3kbUf7Id5VTbz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=I/ouzm6a; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="I/ouzm6a"
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-71e0cd1f3b6so970780b3a.0
        for <linux-block@vger.kernel.org>; Mon, 07 Oct 2024 23:10:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1728367858; x=1728972658; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=cDNysr7O1Ymf6qPXep3lZ58zMq8Zcc6aOQaV6CRgfYI=;
        b=I/ouzm6abQovnL8uSnjoWsOCMI2GDdnIduNyu9oRNEPxDZPtLrbpnCRDrg3UckMdaF
         yWcyxcGc/MQqY8uKwPML8iH8y6oAPT4ZmLn+9W7RhKs80f1EnI397UV8WfiECkkvfmV2
         dWkmM/4zChx2xMSY2ME/hV3eBGER/EPF02b8M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728367858; x=1728972658;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cDNysr7O1Ymf6qPXep3lZ58zMq8Zcc6aOQaV6CRgfYI=;
        b=Vpzzgwi9/CV5XOa99SnQq84NBrUXfizyzUdN/w1tneVX0HEEcE8OAe6PQoTVixe5uN
         Ned2xIPH3vc1xyC9UGvJWAOTehGIcznV3OJUTSYDyY/uztvjipFjm9icVcGYo6QyQWEI
         I42uqy5CSREvTML3a11iADIaZflLuvP3mwXHTE8G3bIMutPd+nIJ43MM+Xv2YOJwPDXm
         tavAsYLJnb0o+2DnGR6eXZqYKf2FUtJNLaPcrrkEhRRc/MZScm+A8ekylVOzssy8bao7
         cplAmSUg2pKNhKUAfOQayiGoAuh0gscFi+N2HdKfuxmg3EffF1IdIJ9PRLXe94Flsmz7
         Sezg==
X-Forwarded-Encrypted: i=1; AJvYcCWUHzlrJ7Xu/c/a3kWDRHo8ksQ7bqrJSV+Sd2aWyFGaW/qnJ+E2Y0P/3GLDyOBaSTOGi08MrDeXrOp4cA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yxbs35F8fxQfEmna3kG8e9hqFXTOCBSNBoOVg33JpVPtssRyxg1
	1Zr0dl/Hj3a5c+fAcshei64mue2uSIB5/XfeYaFhMVzXaWscZCCY2e9As9zppw==
X-Google-Smtp-Source: AGHT+IFXeO5gCh1mEyxAzDIIq9T2hwj+EsCVIVEaE4VHD3TeULUF8DkyTujq9w8jixAkmmZ6ZILpCQ==
X-Received: by 2002:a05:6a00:884:b0:71d:fd28:709a with SMTP id d2e1a72fcca58-71dfd28739fmr12501550b3a.23.1728367857670;
        Mon, 07 Oct 2024 23:10:57 -0700 (PDT)
Received: from google.com ([2401:fa00:8f:203:e05b:ffee:c9cf:bdec])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7e9f682fe56sm5991010a12.51.2024.10.07.23.10.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Oct 2024 23:10:57 -0700 (PDT)
Date: Tue, 8 Oct 2024 15:10:53 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	YangYang <yang.yang@vivo.com>, linux-block@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>
Subject: Re: block: del_gendisk() vs blk_queue_enter() race condition
Message-ID: <20241008061053.GE10794@google.com>
References: <20241003085610.GK11458@google.com>
 <b3690d1b-3c4f-4ec0-9d74-e09addc322ff@vivo.com>
 <20241008051948.GB10794@google.com>
 <20241008052617.GC10794@google.com>
 <ZwTJj5__g-4K8Hjz@infradead.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZwTJj5__g-4K8Hjz@infradead.org>

On (24/10/07 22:56), Christoph Hellwig wrote:
> On Tue, Oct 08, 2024 at 02:26:17PM +0900, Sergey Senozhatsky wrote:
> > Didn't copy one more backtrace here, there are two mutexes involved.
> > 
> >   schedule+0x554/0x1218
> >   schedule_preempt_disabled+0x30/0x50
> >   mutex_lock+0x3c/0x70
> >   sr_block_release+0x2c/0x60 [sr_mod (HASH:d5f2 4)]
> >   blkdev_put+0x184/0x290
> >   blkdev_release+0x34/0x50
> >   __fput_sync+0xa8/0x2d8
> >   __arm64_sys_close+0x6c/0xd8
> >   invoke_syscall+0x78/0xf0
> > 
> > So process A holds cd->lock and sleeps in blk_queue_enter()
> >    process B holds ->open_mutex and sleeps on cd->lock, which is owned by A
> >    process C sleeps on ->open_mutex, which is owned by B.
> 
> Oh, cd->mutex is a bit of a problem.  And looking into the generic
> CD layer code this can be relatively easily avoided while cleaning
> a lot of the code up.  Give me a little time to cook something up.

Sure, thanks.  I can't test the patch, tho.  At least not yet.

CD layer is in several reports, I also have reports with SD, and
a bunch of reports that I still have to look at. E.g.

		schedule
		blk_queue_enter
		blk_mq_alloc_request
		scsi_execute_cmd
		ioctl_internal_command
		scsi_set_medium_removal
		sd_release
		blkdev_put

cd->lock still falls a victim of
"blk_queue_enter() and blk_queue_start_drain() are both called under ->open_mutex"
thingy, which seems like a primary problem here.  No matter why
blk_queue_enter() sleeps, draining under ->open_mutex, given that what we
want to drain can hold ->open_mutex, sometimes isn't going to drain.

> I also wonder if simulating a cdrom removal might be possible using
> qemu to help reproducing some of this.

Hmm, that's an interesting idea.  I've only tried to "unsafely"
remove a USB stick out of my laptop so far, with no success.
