Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01D7A40F755
	for <linux-block@vger.kernel.org>; Wed, 22 Jul 2026 13:59:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784728796; cv=pass; b=Wfrqr+nkDvCoB3SzlABWD9o9OmG2nRDKoePOIVjV7Q1kMqkpJGcdoR2c3kjh6eKlY+dfPrRbNKf+ejs2xAtEvQAAAedf4MDCJljQp6kZhGnaRGhBvz13lGmALVcSl+X8Q2GSvQmTpIuFSfqQ3xWzpkLkwuiKrJoJb1K+KgwNgd4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784728796; c=relaxed/simple;
	bh=EUW/0YA6sW48kKaoT8QUnu/HRnk1W7kX322PmycN4JU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rpKEDyPX+B/u5OkMxNcsHh/3qn4Un1mYvNpiP338EIoYDZPFlf6FCoRev+h5O+axwCnYzVcJAXRTthijqJ4vkdgNiX4NF1nz09ncM5uc0QaS24+p03mS2LQUbnR/QVZzl03vTDPouWptf+suK7qwjNqco9LTf7dHy35iNexLzCk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T3mi/0wm; arc=pass smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T3mi/0wm"
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-698bf7a1a2dso16620695a12.0
        for <linux-block@vger.kernel.org>; Wed, 22 Jul 2026 06:59:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784728793; cv=none;
        d=google.com; s=arc-20260327;
        b=aKq5hf7diACeFSWiwbht7h6ss8KyQDk+4Uoud9kHaJxu4OI025/S/3AWrafWL0Wt+u
         fa8WxkSRD1BWfNdP1f4WZ7LdQyqfkMTvyB3GEL+TGwWYyjmmG5YcWRKvkl3m6wq4gW2j
         ff9V4s0EfasEs2RouLIIxnSZDHRG5P+Q3rlvBfs83pCrX60arRgERhsfF/Ld1QhKSKh8
         0WU6Tm7G419tkd7pBy4RiJES9XVtHiNhpkbHeVFF4TUiHqKzaFvxhc5hc5b097OTIS3A
         U2anPcljkwRRKSRkZ7hMUEHnQ1wyYVrOyiBUgBGat/iJ++gcLr8CvEVrlX3ViSeUA528
         7t9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=1/9q/womlf+GA1DlJGRjl5rlLjU9A+gzcug/ampWIXg=;
        fh=tbULcXOoIX7b3jM70kCW9YmaNoX4BnUUmZn6dAK2O84=;
        b=flp+mx40Vttg2n71V3RaCrB/ndSCKFg2pbjSfYfYybFk7lyqKxrUoLZrrx3ukfEOWQ
         8C15GMwUdalVW0KqHT/py51IrbUBTnbgeBjJPcuGlHS5DSZaw8Y151Inp7c7MJyNaRU7
         5CoeVBAPzLoChkyh7KYUbR5WrJep9I4O5sS+FUzz8joIzpsJIwUuqC0DFL5taqE6lBce
         ck8f4VDudZpWErdpuZn/PfQzB9VTmCMYVYa/UxJNnLGc8UiPDb+RvsdLhff7Kq+8BGTp
         Lg0oWXJh/dp6xmq6HZ3ioK4kysT2fbCfjYmK+ze0V03yl8hc/7KFWGwjfVLTHu+Cq78I
         3A1g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784728793; x=1785333593; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1/9q/womlf+GA1DlJGRjl5rlLjU9A+gzcug/ampWIXg=;
        b=T3mi/0wmoaujp4i4s8dzVnCHtbGrtgygHSZiAxTB8RwAmKfIM5uJC4HofaGZBWayps
         8G7eH2Ifjt5OpHw/s3QvL6zL03PZsP4KcBeBGayxfa21x/JKXYA2eMlI6cM3M6hNyqaJ
         4yLQVvtlhW14Cj1MY2/XKXjddct/zU110T6bwcNXy/i0JauSLr61e398LdRfJ13igsL6
         hZVXixUknHW6/uQfu6OtE+b1Zz6WjIowhW7Gh5X7CGsg/qR15zThRIyc+Rv1Z/8YM7bT
         sKAV3Zq3uLt9ql3/uhAOMizJ89wjSXELtuXxKMcKCDLpHqhpOkk6xrFMQZy0Jq1ZKjF4
         vm1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784728793; x=1785333593;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=1/9q/womlf+GA1DlJGRjl5rlLjU9A+gzcug/ampWIXg=;
        b=oPme1ZvTxsUpHV6tA987/emcUUbHGw4x48FUKpHff0mVyWsdzmeCDKjzF7zkdCcALC
         YlFiU3zLj3YHdXWe+Crn/yZCjLiF6rEGdyWUGz2T/wl/gm/l6ZPWEmO5+KWLxQ3Qqj8C
         xAPNaHjTm7q5ArClSWRU0XObQA5FjcWs+8ep7IeCOpHz4rhdxHMIbO2xh18oczNimWVs
         8vJfUbgzSlkGU3jv3tAzxX2JyGqqFywWc078Mvn/vfOjKHlS1OIEPI5RviQ5z3DmL4X7
         k6QFaXp3OpvwWtMLIiGFl4q0qryLhpBjm8WnNUnc1UcodhfreSqVxmw+EmAJACK/jbap
         PzNQ==
X-Forwarded-Encrypted: i=1; AHgh+Ro+AHM+DqC8PxRWPO6gzMhDerDMTEutBBBo+fhJK37V/h4N9Wcu98PfmgclD04zDWlJB6R9RJ0jCi6dLA==@vger.kernel.org
X-Gm-Message-State: AOJu0YyCqHBllwO16L3H1gPtXbJlPtGFshDmGkbicfYWtzhkDffIbV+n
	rgb+kRI8XP7yy5/LmUKykCb5p9N1PpR/2SXDc78Pb2WTuU4MDta/tKcElo+tD5O/nVZ3EznyGYY
	gn+/ghNQHIHvZyX/3OKVVyQFSMqUMDg==
X-Gm-Gg: AR+sD13XI4rq8Tg8c487YTqbbRdBGQw+SAGpTzvdGWUizQvNCwm19LDKMaoDCCSacNw
	01flYoxgS2k7ZqlB/IX0a0rPqq0WzQvpiXqvomyH+FU0R8SJ1f9pWrktWQnJX53Uba/sPKthkh7
	AHH0OIBYroT+yDt0871+mNfvNB+PO2Z3c1lnIAX93QvBf+weqeZbC7QYphOUgzBFR3z8D3V0MN9
	2V0JJ6/I7eTC4IVNbyvMtbXGa9/RIwRLjADtHUjMtkhA+0rsW/bfPZ10obC15noMKDBFG2qFIQo
	F0R5RrmzVhqFJfHZZ2cOZ6wDS/R9wmatsxWpmWMe8rY=
X-Received: by 2002:a17:907:c80e:b0:c16:72ba:d352 with SMTP id
 a640c23a62f3a-c16b47d6f0fmr850940366b.31.1784728793197; Wed, 22 Jul 2026
 06:59:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260721071739.2514228-1-hch@lst.de> <20260721071739.2514228-4-hch@lst.de>
In-Reply-To: <20260721071739.2514228-4-hch@lst.de>
From: Anuj gupta <anuj1072538@gmail.com>
Date: Wed, 22 Jul 2026 19:29:16 +0530
X-Gm-Features: AUfX_my7IPuiQB5aohsPpREaoyA4_63snvFtOYHPDVi4PnaprqiKwvMV2qfCSUA
Message-ID: <CACzX3AvuR0r59nEo6Uef6OHw9Z=8AxdYboRsE4bcswO1x2umJA@mail.gmail.com>
Subject: Re: [PATCH 3/4] block: handle nogenerate/noverify properly in fs-integrity
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, "Martin K. Petersen" <martin.petersen@oracle.com>, 
	Kanchan Joshi <joshi.k@samsung.com>, Anuj Gupta <anuj20.g@samsung.com>, linux-block@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

>  void fs_bio_integrity_generate(struct bio *bio)
>  {
> -       if (fs_bio_integrity_alloc(bio))
> +       fs_bio_integrity_alloc(bio);
> +       if (bio_integrity(bio)->bip_flags & BIP_CHECK_FLAGS)

This causes a NULL pointer dereference when write_generate is disabled
on a offload capable device. fs_bio_integrity_alloc() returns without
allocating bio->bi_integrity, but it is still dereferenced here.

Maybe check bio_integrity(bio) before accessing bip_flags?
