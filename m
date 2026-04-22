Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B0BB37DE8C
	for <linux-block@vger.kernel.org>; Wed, 22 Apr 2026 16:25:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776875121; cv=none; b=cLLRpx1SDqivSttU0wt32HdlaQ2EoQ+6cAfePj++qot6Vo4q7YeQvAfutNXLdjwUW7AMxVD6mus56xrfNpaM/QjrOG2lvZUeZN5w7emr7GYPgOVDrUnI6ps++Y5zk9TcrrzeU8vEc4XUKrgnrZ09DhBKMndJTWOLObjzp8MmuH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776875121; c=relaxed/simple;
	bh=relbCsxTarhTN/DEzWhHsVEnDfMzmaIQrETkxNLHpDg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k4ZEWG4Dzo+hLxVX3KOWI76GHh9zirJu4HhePnfX0fzQc+pzFAnldjV+Pyd0dcQdwgUhNdHxFuNuIQcga795Zq58l6i6FYQGixqrbEVGvxSvAwgncG1WPG9O45vomOrZAc4SJc7Gm1UmknlZNyf6nWgBHnqYPn2whAELRszEJD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sn47eyXK; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sn47eyXK"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-488b3f8fa2bso59751045e9.1
        for <linux-block@vger.kernel.org>; Wed, 22 Apr 2026 09:25:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776875117; x=1777479917; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=5/XQOT4wkfrl5gFL1ciRkF4ytLnsNeqbo+o9raOSWLA=;
        b=sn47eyXKgOtGENP5oh7LALWSVhCJHteISgjqg0y8vN0La35PESTrpqxT9CDSja/8m6
         wBraoTRnzCWAlv9XmURJ7gCiwKbIYnWThMcLLmg4w0nV5Yn/Ou4uWN2RmdTWtzqpz4oV
         yySK63EFabOGs9CNhgSKPTi7+lwazKe7TPHbCuoVLjNwUk0rWxNZy+Y4WtW2bL7V+o+a
         Evu6tBfLj3KShg378jzeb7/azw+oArNg7vY4H5NhuRkUT70GISmZc5aF525AVCUoyb32
         CvM6Aw9h++/F0vN3UnJ73SogQtiRPAlmlZpFhHYKa6rp0efIbh2eoaP2GqkF+GYuKxVh
         2kiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776875117; x=1777479917;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5/XQOT4wkfrl5gFL1ciRkF4ytLnsNeqbo+o9raOSWLA=;
        b=OsKrBMCAneFLRJ4fU383Q4NTNqyhA1nSbusidss5VBiMWacGmRBaHPWJAFPaJX85bI
         xsv0m5wkTizDMFPtMiLzQtFWTuIYuVwvIKjW7aCk4b7bq+ohCr6jnXDpo2wvr9T5rjpi
         bY/QHkDeioV73zW1mgN55VPQ4lt8NjdjSBszDLIb4UtkvoaMqREUkZeIh5+x+re2nJeP
         rf3iLAgR15BMI5DHNJUUOUI/qxmGNGXZZA6j+sC5bAxRf4aDtw1Dik56bNvnmzMhwR5H
         vi/StGcSNGZ9JqG9RpbyOd7YRLs7BZAFUwNJw+uVrsahBRhb7RR4kwgwOXW28Zd/egk5
         f0lg==
X-Forwarded-Encrypted: i=1; AFNElJ8cm4bWdmkusJNTofEWIGQKfiyNt0/SP796haXMZ6mfwU9liWEiELcnXSZ0VSxwriRJezYG4dJPIgWJBQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yyj5qSmibT6EOx7W0vFhPZsgtk2TIAQ+tSMi+7Ni6Jyh4FeRdW6
	wlv0+wDdwnrcDVISrZ13lGWYdddeHk1dMtiuuPJRMLSuo7ZZ70zhoYou
X-Gm-Gg: AeBDiesmd952ctNxCcnCzduk8ak7sFWnlTD0bmn09N2Rmwy3i9DVhbWF0FKr/V57RJq
	1ha48snwR1+eoOwXTwNpUgPMEy7Hqie0vTFiJyE+enxN9m7IntJ+oQrtrIDQCy0Efmq3H91edGB
	YRtMMB2dRjwp50JhdoO+sCTXjeb4SiRFo2ebfOMtleq5oBZ8h5Su3FwUB9/PSNoSB2wgh0LuHk+
	uRYEcY+eGnqN58TuYSTkph5cQV4TCwbvaOx7NMyTNF50u+mcOhi6WEZfsq2cii1xtrCJmJRSrsd
	2mKsgF2JxL24JEGoRd33hN060u0gfkxDf5MaUJoadb9C0/hsqzOELI8ikSYAJLwqmzePI7+8eCJ
	WWcSBiRBdU90lR1tV6pga1Zra7YxRmyLbcbEDuG+zd79o6yNvyXqCswwZtmDAERfs8OySctoACL
	EaOAuutxrNPlZQW7002HLR15n4o7joYnUCMHztrw+QdsjMUjvQT4ike8CyFr1mEA7rDM7Dm92ZQ
	ucWt+iT4UfVLsxzu1w=
X-Received: by 2002:a05:600c:3ba0:b0:486:faa8:9e4 with SMTP id 5b1f17b1804b1-488fb8b91a7mr299355075e9.12.1776875117203;
        Wed, 22 Apr 2026 09:25:17 -0700 (PDT)
Received: from fedora (185-147-214-8.mad.as62651.net. [185.147.214.8])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48a5499b0edsm147182145e9.14.2026.04.22.09.25.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Apr 2026 09:25:16 -0700 (PDT)
Date: Thu, 23 Apr 2026 00:25:11 +0800
From: Ming Lei <tom.leiming@gmail.com>
To: Caleb Sander Mateos <csander@purestorage.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ublk: optimize ublk_rq_has_data()
Message-ID: <aej2Z-7lOpC6tNDS@fedora>
References: <20260421194744.1524637-1-csander@purestorage.com>
 <aegNf5C5-0ccxBPp@fedora>
 <CADUfDZq3yY2j3j+Jofqab1VLrm8jk+phF24BHPnVjv0hD3vyKg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CADUfDZq3yY2j3j+Jofqab1VLrm8jk+phF24BHPnVjv0hD3vyKg@mail.gmail.com>

On Tue, Apr 21, 2026 at 05:31:40PM -0700, Caleb Sander Mateos wrote:
> On Tue, Apr 21, 2026 at 4:51 PM Ming Lei <tom.leiming@gmail.com> wrote:
> >
> > On Tue, Apr 21, 2026 at 01:47:42PM -0600, Caleb Sander Mateos wrote:
> > > ublk_rq_has_data() currently uses bio_has_data(), which involves 2
> > > indirections and several branches. Use blk_rq_bytes() instead, which
> > > performs a single indirection with no branches.
> > >
> > > Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
> > > ---
> > >  drivers/block/ublk_drv.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
> > > index ef8a0705e68b..5f9b3c3876f4 100644
> > > --- a/drivers/block/ublk_drv.c
> > > +++ b/drivers/block/ublk_drv.c
> > > @@ -1172,11 +1172,11 @@ static inline struct ublk_queue *ublk_get_queue(struct ublk_device *dev,
> > >       return dev->queues[qid];
> > >  }
> > >
> > >  static inline bool ublk_rq_has_data(const struct request *rq)
> > >  {
> > > -     return bio_has_data(rq->bio);
> > > +     return blk_rq_bytes(rq);
> > >  }
> >
> > blk_rq_bytes() doesn't return the actual payload data bytes, such as,
> > discard command, but bio_has_data() does.
> 
> So you're saying that on a discard, rq->__data_len is set to
> bio->bi_iter.bi_size, which represents the number of bytes being
> trimmed even though there's no data payload? I guess we could check
> req_op(rq) here to at least avoid the bio indirection.

Yeah, you may add blk_has_data() or open-code it.

Thanks,
Ming
