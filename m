Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3588E36126
	for <linux-block@vger.kernel.org>; Tue, 24 Sep 2024 05:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727154633; cv=none; b=mFHDPBzWR9Mw6RGIzBn552OzOM6XZCmggmYYIn3abPXGc+zI8yuSmaMX1y6cw9Q22WjB0s/6RVzClXs3ZpQsQAtyp92D5uZji/gvBkaaH+Y+fBOqp/TEHR3ah9ReDvQiZtFtD0dt5Zw4si9suJPtgoxOtXow2Zas9U6EgFWOKho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727154633; c=relaxed/simple;
	bh=+S4odZIZn4LbjVEzZ+6RSoIlLnUbaQsB7c1O8kXoLt8=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g7lehRjDIbtWPUqBvk2hWDkqQgYYl0/2F81mxBOGKXuN4vVc6iLbXi2BrG8K6Wb66C3K1Q3yU6fQysL8TKVrZTeVEgjy8Wi2fJl+cW2pAa0vT62nBMvaCOXAlpexKYvVzcG7fPudmbWkPncDQ77GdhfgQtzylFrZqifZclfEVbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=ia4hkiNs; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ia4hkiNs"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-208e0a021cfso25129445ad.0
        for <linux-block@vger.kernel.org>; Mon, 23 Sep 2024 22:10:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1727154631; x=1727759431; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=EteOU4cFAYWjSN7R5+m268uN8emxl+m64G3Y9Bnt2c0=;
        b=ia4hkiNs1jpU2rWjwSywaphowND01e+AByQh6K5QimCHjd/Ac9Ky9PVJY1/YBC88Y5
         EmsIM6amPXm6KYEBQWhDf8qRA3NWmYCWXJLvHv7f3v8pQpIpW2HlCtEuGN42b8fTLmIX
         BY1/UGxPfgylkVdjWWr2sd1oLzSmvXp+uLpMo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727154631; x=1727759431;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EteOU4cFAYWjSN7R5+m268uN8emxl+m64G3Y9Bnt2c0=;
        b=GPtxkS18fk8OMY45V6y5fJKAwADWZidUZ0ArI4NXboKEW3IquSHHvN4RUo7K2cR01q
         nQIknjPTVkJgG5ffnutFSSXW1Is3ISYfBTyGmO2DjMFBvroJu0YcvdMXxa28NhGzp6FB
         eRn9dvcjhB5uOW0jWiShyLiSRDVUh5yDmMRhsejmE3NDY8itzsIIdMhtJ8rxRADNETjJ
         vgkwaBDVPGJXW4EgKVittbrnluLNbNt3wOZFL9cBk+sE4euru3a9O2TX3ET8kkZL7/CJ
         ont6I9YLnChN3QRvoYn9Rq4U/lg6hQxh++lyN8FLIQOGDpfOE9CgNtybDDcheTr4Bx0V
         MDag==
X-Forwarded-Encrypted: i=1; AJvYcCUXC4VdCj/K9TNXv9KYoWNpOsSVlRvlJYRtncVjVVSnzcnXRO28EuhMZUCWf583lHDucrWnUvB2h0i2Kw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxOiZ8ZUsshUFuo8/RU0WbH5TVT4Lqsw3KJ+Gf7rccn3Q9HAEp4
	h7NFr9unZN9HVE6xq1yAIc5ddw/IBJpk39pcaqwnIOxlnqMqURzxmKxeb3FJ+A==
X-Google-Smtp-Source: AGHT+IFCC4EYWt8kDXJcEwRzWsCwMWOWYK1tHbRw+EYbP70vw18lbMKxBMFn5yUrc45MBzTrezKf4w==
X-Received: by 2002:a17:902:d50f:b0:207:1709:380 with SMTP id d9443c01a7336-208d838ede3mr187904825ad.27.1727154631524;
        Mon, 23 Sep 2024 22:10:31 -0700 (PDT)
Received: from google.com ([2401:fa00:8f:203:93d1:1107:fd24:adf0])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20af17e3049sm3487615ad.164.2024.09.23.22.10.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Sep 2024 22:10:31 -0700 (PDT)
Date: Tue, 24 Sep 2024 14:10:27 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Andrey Skvortsov <andrej.skvortzov@gmail.com>,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	Venkat Rao Bagalkote <venkat88@linux.vnet.ibm.com>,
	Minchan Kim <minchan@kernel.org>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Jens Axboe <axboe@kernel.dk>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v3] zram: don't free statically defined names
Message-ID: <20240924051027.GJ38742@google.com>
References: <20240923164843.1117010-1-andrej.skvortzov@gmail.com>
 <c8a4e62e-6c24-4b06-ac86-64cc4697bc2f@wanadoo.fr>
 <ZvHurCYlCoi1ZTCX@skv.local>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZvHurCYlCoi1ZTCX@skv.local>

On (24/09/24 01:41), Andrey Skvortsov wrote:
[..]
> > > +++ b/drivers/block/zram/zram_drv.c
> > > @@ -2115,8 +2115,10 @@ static void zram_destroy_comps(struct zram *zram)
> > >   		zram->num_active_comps--;
> > >   	}
> > > -	for (prio = ZRAM_SECONDARY_COMP; prio < ZRAM_MAX_COMPS; prio++) {
> > > -		kfree(zram->comp_algs[prio]);
> > > +	for (prio = ZRAM_PRIMARY_COMP; prio < ZRAM_MAX_COMPS; prio++) {
> > > +		/* Do not free statically defined compression algorithms */
> > > +		if (zram->comp_algs[prio] != default_compressor)
> > > +			kfree(zram->comp_algs[prio]);
> > 
> > Hi,
> > 
> > maybe kfree_const() to be more future proof and less verbose?
> 
> kfree_const() will not work if zram is built as a module. It works
> only for .rodata for kernel image. [1]

Indeed.  It probably shouldn't even be exported; same for
kstrdup_const() [1]

[1] https://lore.kernel.org/linux-mm/20240924050937.697118-1-senozhatsky@chromium.org
