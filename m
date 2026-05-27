Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C0F417A31E
	for <linux-block@vger.kernel.org>; Wed, 27 May 2026 03:45:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779853543; cv=none; b=MzoN1a1knNeR9ro2JtiU46onpYp8/77R20CQfdl9jdxxGE6gjJOc/bYWB8Q/sxzjWZjDJ4vssHgbLsuTZTfJ9QjWJR35EKRAsvetfQcOsD1+syDL/1ue9k7X3e4MtKiuMLzlLlnVkSe4+ZTNzaxqj50TEV5XD/nYuQuBIxpP2eg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779853543; c=relaxed/simple;
	bh=RB6k6fJeesvAOl3RIkf0eAcn1RQtk89RN7lhQyACCTw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o5+lLCQ+iRt95NhCNVT3CPgFqwGN3ldHhB7qEijxemxOavxYAShgPxZRWRI9Xhd2C17F1fk81R2RGGDW6cYRBe+XkIgu2vUjC3oIgv9sRwKuQi/Xpguw0xiH+cRm9ARmts+rmoDE/5P1myUFSi4erO+TH+G0COtxdZpzqT4gXho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=ayj1HHei; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ayj1HHei"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2bccb978bd9so69267005ad.0
        for <linux-block@vger.kernel.org>; Tue, 26 May 2026 20:45:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1779853541; x=1780458341; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=DIzXofIA1kQTMtH8bue4R/Y/pLpr9GrF0sr5GiXdihw=;
        b=ayj1HHeiFDESNa0nU4rAU236dEYHpGQ9unLqwSyokZNmPI2sOv/iMP9QAuyRfFEfCY
         KI2RKZmWfb9qsHManq3LX4O+V49ZVg5x4QLvjFoDuar+BX/EI2w++ekpe8Zmhol9yGk2
         pf5sBulDKqvqp8CENBNeaeHk97Q3Hht0JrJmY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779853541; x=1780458341;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DIzXofIA1kQTMtH8bue4R/Y/pLpr9GrF0sr5GiXdihw=;
        b=g1/X+uhWsa+B5+jk0syQT8dB2/xDZCxg899iS2xM98E7NmliWjrHke8CWEdu8JgEhL
         dqGfwq2FvnQc4jV16BXrZM8MW6YRp6WUeCF+GGoZ3gXoNhrhlWsZ6clWRD1piChLxQD+
         FzbgdDsGVcrm3j+rr0bPtPwE348T2291II3H8vr7LRG9lyh9EDEkjQkjhcYR19CpLS/+
         /VwjARd7rEyfDLFzEdWJymD/vziajThNW8UrWVFgVvQ1om/pv4rUh7h6C0mLNXKp8uau
         jshjHPD7xu4+n6oVkLHqz9DiYCHJxc4oNC+A/EdfWAXJb2KJvPBh0C2GOp7ncIqB5CIV
         RqfQ==
X-Forwarded-Encrypted: i=1; AFNElJ9PoNoythesDZbnWHsvAIMqHekQhQ3UpZMWRMGweJ0MV4soe0FaiTJJljVpsx1OktqxMHB75MuzDXpwEA==@vger.kernel.org
X-Gm-Message-State: AOJu0Ywo/In/3tMv2xNf/xR7KKzq3gIbVnWxUoo74c4foje6yzODLdIQ
	rmt3biW4x3nxjjp2ZhoVPgwn0OsTE/PKazofZx8dIz0D3CIqV6JpPq5tQoH+rB4WCg==
X-Gm-Gg: Acq92OGj/MJKblOBUnf0I5GlQYSRmQ92dI3lotqSp+Q066APznbmWJAgQtdRjgU33La
	btzHXefwura4ZA0rn1Yu8oEwJQX/y8tK5nHT+/6c23Buor/PmA/dlTMYVKL3vsj2DWQrUUIPrhY
	Z3A8HDkE/qZIZuOP6KjaSvXqTRr68qMj7dqrxeQoBwjC6M/9rg6rRgc5vuKaBCMxHiavVqrN1YX
	bfOS1Wzi86gplvZYUcoYu3Rdig/ijbmCiVD1Zv7UBY9dbbz3TTxcT0RJPSZYZVwRfOyd3e5N5kB
	fCflraSAzv8a0mStugJi4Vy72GXoCya3g/dUV/E4CTjdHEzD+d0BSpP1Nfv5qzBRJzqJBODR9US
	gTfm6ME8VqkZRwYalcGLWiIE5f2iZm+ga3zWO6f8Kxjrgr7feJbMJJYvTs/IUBQH8q4LKt8ttYV
	rghpsqggtiLsk4S6WkuoMyne9c1EFjEY5QAeR9gEHyef/XaJBIDSrgSL/g6hMz6IaJA+iZytWBw
	Q==
X-Received: by 2002:a17:902:d482:b0:2b2:ec33:cf15 with SMTP id d9443c01a7336-2bea20c02e2mr237439135ad.7.1779853541545;
        Tue, 26 May 2026 20:45:41 -0700 (PDT)
Received: from google.com ([2a00:79e0:2031:6:b55c:5b57:6435:9af4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2beb58b2ccbsm141659055ad.48.2026.05.26.20.45.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 May 2026 20:45:40 -0700 (PDT)
Date: Wed, 27 May 2026 12:45:37 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Cunlong Li <shenxiaogll@gmail.com>
Cc: Minchan Kim <minchan@kernel.org>, 
	Sergey Senozhatsky <senozhatsky@chromium.org>, Jens Axboe <axboe@kernel.dk>, 
	Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-block@vger.kernel.org, 
	Christoph Hellwig <hch@lst.de>, stable@vger.kernel.org
Subject: Re: [PATCH] zram: fix use-after-free in zram_bvec_write_partial()
Message-ID: <ahZov_99kMxaTH2P@google.com>
References: <20260527-zram-v1-1-ce1acb2bfaf9@gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260527-zram-v1-1-ce1acb2bfaf9@gmail.com>

On (26/05/27 11:26), Cunlong Li wrote:
> zram_read_page() picks the sync or async backing device read path
> based on whether the parent bio is NULL.  zram_bvec_write_partial()
> passes its parent bio down, so for ZRAM_WB slots the read is
> dispatched asynchronously and zram_read_page() returns 0 while the
> bio is still in flight.  The caller then runs memcpy_from_bvec(),
> zram_write_page() and __free_page() on the buffer, leaving the
> async read to write into a freed page.
> 
> zram_bvec_read_partial() was switched to NULL in commit 4e3c87b9421d
> ("zram: fix synchronous reads") for the same reason; the
> write_partial counterpart was missed.
> 
> Fixes: 4e3c87b9421d ("zram: fix synchronous reads")
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: stable@vger.kernel.org
> Signed-off-by: Cunlong Li <shenxiaogll@gmail.com>
> ---
>  drivers/block/zram/zram_drv.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
> index aebc710f0d6a..b23a8bbb687c 100644
> --- a/drivers/block/zram/zram_drv.c
> +++ b/drivers/block/zram/zram_drv.c
> @@ -2333,7 +2333,7 @@ static int zram_bvec_write_partial(struct zram *zram, struct bio_vec *bvec,
>  	if (!page)
>  		return -ENOMEM;
>  
> -	ret = zram_read_page(zram, page, index, bio);
> +	ret = zram_read_page(zram, page, index, NULL);

Sounds like zram_bvec_write_partial() doesn't need bio parameter then?
