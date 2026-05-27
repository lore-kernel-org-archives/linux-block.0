Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AE2D250C06
	for <linux-block@vger.kernel.org>; Wed, 27 May 2026 04:48:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779857301; cv=none; b=JbTBFXb8lVCsP1ze+nKfw33z+bC9ZeT7jF5cuXwtKHXujoKuhTmVlpu/uAXbTe7U3H5OI6JA1OST04mkyEPidGWJ9ZPK8pmveOMlwNY+bEqjGW7Zfxr4/56qi9GvoL5TZHkaax6zo/GYg5kUK3jmS2i/K4H4nlGal7idXzQiKbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779857301; c=relaxed/simple;
	bh=LwvBMnJ1UpPWgCimFzDiGtFXtkX4zeCEdu5501y+XsE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Disposition; b=i1FHK81MCoH/uo5OG5gN+mgOsrftf0y+kKxLGnnb+9Krv8Y89WNt56YLikSZTzB2R6KlS3w3zd2lrlzR4hGZEFioxn+MOKqxbiwnVoCZWR4RIADFdvhl96rt6am2Qrj1jzVJgFV20S49Zd/zpnGTC81XepVKals2mF1fkgn3cFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UgRG8o/1; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UgRG8o/1"
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-367d88b9940so7512155a91.1
        for <linux-block@vger.kernel.org>; Tue, 26 May 2026 21:48:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779857300; x=1780462100; darn=vger.kernel.org;
        h=content-transfer-encoding:content-disposition:mime-version
         :mail-followup-to:references:in-reply-to:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Chd1jutX+G+jhl5nJg9KkScymzrTc5Tq+2T6gtcZuEI=;
        b=UgRG8o/1zkcMRIDzPN8GMuLLojIFisr5kfmbaDWegvI3TI5VOR2Aypo3CDHJE/yaSU
         vp/0PHuelk7JUFhdqh+FTIZozl5sBb2aDdN1BjufCR2FbcEu4qYGU1xERKcO+QKe/yLd
         BkGptGHsKnf3v24bW212gzj1c07WFYnli96X9RMttzqE9QZ/V0rMbfC7kpQ5I2nqvioX
         1aC3dbg/vc/vkeoop5mZngiilvUhMK4LAzkLvlevyctsQKotcjix+tIkP33AA0rDqOGJ
         XgBksdzjKpWPJsdR7nWwL+EaLngxt5rpBwdvvj8ql2msjhQrRRjA/68ACCOfOan16ZrQ
         sGDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779857300; x=1780462100;
        h=content-transfer-encoding:content-disposition:mime-version
         :mail-followup-to:references:in-reply-to:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Chd1jutX+G+jhl5nJg9KkScymzrTc5Tq+2T6gtcZuEI=;
        b=hmcZxe+MZXRyC1pnixX5uQ9AEfDSbOmdLgucZpORrGr6bHf88seyimY7wGWPzYrFU9
         DmQaO+wAs3nW5wDJGCNK8kYgBtNqGqfL+EYITQXeIwS0bWrHbQ+1P3W0ggNyFU0ewwBK
         afGceqRS6oRiDDswcEf50MLkkC7NBzg4PR9z4zd6gHOvOlFzkstAkLgUKtIPlDFLvwKz
         VKc7wCtDca8RdvWGWBY508KPNIt4LHPmy+tespl85B9Xh8JZoN8cwk9j2YSj268gd6Dr
         NA0ySCx3bC33gexxrvh9cbNN57qOj0wwDXhJdmJ4Eyu2s9IPxOSPARFcDlDLy108q9es
         HzWg==
X-Forwarded-Encrypted: i=1; AFNElJ+Fz9B6oZL6MD99jn0xj18Esw9TJOaJN0HuJsiFok+tyAkD8QsojodpnzvvBnwArvClQYs0zi/p/o1zFA==@vger.kernel.org
X-Gm-Message-State: AOJu0YweQnikh52YdQriNdBwNVs2PNZhczhizfMLkQS3RK2+PxfQpWa3
	MeWt46CHn0h95JJedXVlqnFo6YDREffeRvH2+8xiwsrnbwkFbWkknfFT
X-Gm-Gg: Acq92OECUdnEntoLG9Q9/hlrd5h6JyQvVEko5hjWCTB7E3T1f0Xt0+qXKCOtaj7AX6v
	DcJMpGMYhyV2oz+LKShAPkEegeePL2DWTkv2iV9MsdNM+Dm8CH5FhuxQnHEh1EDxhWsBhYropwg
	Famn21w/nJ2GH1frN9UJQOjAZL0klFND1xidL2OYM5A7GXaJicfXBN7BOPb+icoAl9JHkVu60Ig
	vsFP7eQqEoehnEQX29jhRs4K7AyjWS/j3xJORouoSQwcTLvJEXfUi1axYsNNw+dl8kmzZRUzDoJ
	5vUkm0LuGitWAVnBrOCTviY5xW1NU1poVmP9X41aikWyWGIOqw5TGRawhHWJl0txN1GDfqEs/C3
	2AHH9H7dINAdTwc+ge5keNYfXhv2pTRJ6WdqUYfYWl6TJhmML4/4DlWiYz0zMm0xKbuxeXa4muV
	7LsWODZEdOa/t6Z2Hn4Zgw90+dkYbTThJHM5gP
X-Received: by 2002:a17:90b:3bcc:b0:366:3517:1a95 with SMTP id 98e67ed59e1d1-36a6746f232mr19970443a91.0.1779857299926;
        Tue, 26 May 2026 21:48:19 -0700 (PDT)
Received: from localhost.localdomain ([116.80.91.208])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-36b2690534csm879124a91.11.2026.05.26.21.48.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 May 2026 21:48:19 -0700 (PDT)
From: Cunlong Li <shenxiaogll@gmail.com>
To: Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: Minchan Kim <minchan@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	stable@vger.kernel.org
Subject: Re: [PATCH] zram: fix use-after-free in zram_bvec_write_partial()
Date: Wed, 27 May 2026 12:48:14 +0800
Message-Id: <ahZ3jSIGz4urice3@debian>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <ahZov_99kMxaTH2P@google.com>
References: <20260527-zram-v1-1-ce1acb2bfaf9@gmail.com> <ahZov_99kMxaTH2P@google.com>
Mail-Followup-To: Cunlong Li <shenxiaogll@gmail.com>, Sergey Senozhatsky <senozhatsky@chromium.org>, Minchan Kim <minchan@kernel.org>, Jens Axboe <axboe@kernel.dk>, Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>, stable@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Wed, May 27, 2026 at 12:45:37PM +0900, Sergey Senozhatsky wrote:
> On (26/05/27 11:26), Cunlong Li wrote:
> > zram_read_page() picks the sync or async backing device read path
> > based on whether the parent bio is NULL.  zram_bvec_write_partial()
> > passes its parent bio down, so for ZRAM_WB slots the read is
> > dispatched asynchronously and zram_read_page() returns 0 while the
> > bio is still in flight.  The caller then runs memcpy_from_bvec(),
> > zram_write_page() and __free_page() on the buffer, leaving the
> > async read to write into a freed page.
> > 
> > zram_bvec_read_partial() was switched to NULL in commit 4e3c87b9421d
> > ("zram: fix synchronous reads") for the same reason; the
> > write_partial counterpart was missed.
> > 
> > Fixes: 4e3c87b9421d ("zram: fix synchronous reads")
> > Cc: Christoph Hellwig <hch@lst.de>
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Cunlong Li <shenxiaogll@gmail.com>
> > ---
> >  drivers/block/zram/zram_drv.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
> > index aebc710f0d6a..b23a8bbb687c 100644
> > --- a/drivers/block/zram/zram_drv.c
> > +++ b/drivers/block/zram/zram_drv.c
> > @@ -2333,7 +2333,7 @@ static int zram_bvec_write_partial(struct zram *zram, struct bio_vec *bvec,
> >  	if (!page)
> >  		return -ENOMEM;
> >  
> > -	ret = zram_read_page(zram, page, index, bio);
> > +	ret = zram_read_page(zram, page, index, NULL);
> 
> Sounds like zram_bvec_write_partial() doesn't need bio parameter then?

Right -- v2 follows up with a cleanup patch that drops the bio
parameter from both zram_bvec_write_partial() and zram_bvec_write().

Will send v2 shortly.

Thanks,
Cunlong
