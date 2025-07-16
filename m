Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D806E289E1C
	for <linux-block@vger.kernel.org>; Wed, 16 Jul 2025 08:38:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752655114; cv=none; b=iUKeVKBaMcdpZ9bhlm0msqyS/GF5smAmbi94RnZscfhKqe43Gu8R8AeYXfvzIuGANngQu7ult6kTRLkfLxEGfN6RrM5cphNXnTwZNgqK74cSkLKDCIi+EwouPvt0kQcfPXzP5p48CttQiPDB4TBaPHftxKjjRVp3ef/m6MXYd+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752655114; c=relaxed/simple;
	bh=izAb8FBqphT5f3PHM4yD/k9xGN60OY9mnwfC3ZgMZbU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kG8uozqN0P3vH/OeRqpK2He7+QfKVYyRxeEGjpNg3GhF7IyHa9S/6Ld1TBZUjqBwTuACUoQHPwX49giKu3aP/vLswkWbp8NHGQHfxyknTbeFUhcUpfT6TUTx09PJoiALYGQnKl776UM5/nilJ7ulduCDOYV1Ds7zX5SSdNIHtbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=fWhKKHjB; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="fWhKKHjB"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-234c5b57557so64224415ad.3
        for <linux-block@vger.kernel.org>; Wed, 16 Jul 2025 01:38:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1752655112; x=1753259912; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=lLh2sm8WqaPVFHFHlj7r6lDUy4RVlkLyvSGa8jle5v4=;
        b=fWhKKHjB7A+IMjx7pSLDgcEwCW/Mp6uY8rSTkzJwwasgpsloWeDX7CupVGvON/AB+r
         Mio9GsDW9gXBywvagZJDT7Cvd8phouPp2XvIMxyd6R12Knt41+bdyajdpZ0y1XbEACJm
         F5ycg6/2zylWyt7v62+JwaShyc54pGSfi2nR4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752655112; x=1753259912;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lLh2sm8WqaPVFHFHlj7r6lDUy4RVlkLyvSGa8jle5v4=;
        b=ct7sdCte2W9qkBJIjqEUwAMhl/1Lna7CX+0TWT2GvUc6XUrbtCu0GRV2j0ND/wzc1v
         WhxwY+mt6a0TSoKd/Lcfp9CAplK2O1aa3IduUUAdglmrhoxvx7bRWy0yz8BSqD0rxSLW
         +je3UNSI/3NzbPNTHcHGRhlCig0eSzzLYupfdaFS5oKBHiCW/UmWL4YCqt5qdoIseJAu
         +wSs7954ln7iS9+cM88oc/+QTOw7Imbopp9ad5kjZAYYSRF/kf2X/xACMdY9wicgxbK1
         QKc55nexJ9KUbxG3qzAuYZpSib/djTJUqVSoCF7U7YkIJwmsZYb7MhnlJXDSG6jEsX9Q
         FRkg==
X-Forwarded-Encrypted: i=1; AJvYcCUXQCC0+aBlCAViKczMwDXl4/gb/Wh4uIGlw+Nk0sTghp1dVMc2g+6GhyM50JeJSWkLIYvOQeP65qXSSA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwsR9BFZg+h74+Ff6YxOtCwmq5IYbr9Ipm+O2ArwBdpXyR/Sk5U
	kB7CIzyVXOKWsxijgNtt//tZ0YCSj2gV+RFBy1QyCZ1rp9Z/05LlLkJFUJjMdsOvWMJ5Gu6r5B9
	k6BA=
X-Gm-Gg: ASbGncvysXMVzYbOa5Y32xGWhKICStHMfkifWiB+ABPY6psis8X/hiSfu+5zdabCw7H
	Ty6rn7kmngZxDp8vXFFtl2SGEO/Hp6KBcHbiuWndCq4YeUAHr1WLl+ZsXthVvN5VIJjDYgvSHp7
	Tewh0gCSGPSCF/5OrYZOWlReGcDdkaPdu7bvgIlnKlixoDgT3sOXwKkBG7FLFi+Om78tfQ8uR8I
	Zw3/FEQQ6acF6smzPYQ/ncRRrXvNe7XTSzeQYUGqrFDp3ba/WTwyjzxS/m8qwhgkPrVAKAN3Xk5
	kEHSbjCeWlggMW8JbeC41Aw89HDSCc0a28TyEEGqQy73F7EixcZ4ml4Rj4MEIxfJ0H5glEUHVd2
	cTmEj3ePCEGeAX63Q5N2Qsp7G5w==
X-Google-Smtp-Source: AGHT+IG3S6Rcx6GMavXOlUdkf9wUf4NC0zv2qrJv8Iv5AETpdbF5yoAKLe/cibG5UK2VUQFwtBG2Ng==
X-Received: by 2002:a17:902:e850:b0:234:c549:da0e with SMTP id d9443c01a7336-23e2578f49fmr22953325ad.47.1752655112070;
        Wed, 16 Jul 2025 01:38:32 -0700 (PDT)
Received: from google.com ([2401:fa00:8f:203:9ab6:c2f9:ca7e:e672])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23de43415b0sm120511365ad.188.2025.07.16.01.38.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Jul 2025 01:38:31 -0700 (PDT)
Date: Wed, 16 Jul 2025 17:38:27 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Minchan Kim <minchan@kernel.org>, 
	Sergey Senozhatsky <senozhatsky@chromium.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Subject: Re: [PATCH 16/17] zram: fix synchronous reads
Message-ID: <rjq6lrsq2mflcry4vtks7wth63cgpjzngcbjxy65z7ucupin3q@owvyk5befvpt>
References: <20230411171459.567614-1-hch@lst.de>
 <20230411171459.567614-17-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230411171459.567614-17-hch@lst.de>

On (23/04/11 19:14), Christoph Hellwig wrote:
> Currently nothing waits for the synchronous reads before accessing
> the data.  Switch them to an on-stack bio and submit_bio_wait to
> make sure the I/O has actually completed when the work item has been
> flushed.  This also removes the call to page_endio that would unlock
> a page that has never been locked.
> 
> Drop the partial_io/sync flag, as chaining only makes sense for the
> asynchronous reads of the entire page.

[..]

Hi Christoph,

>  static int read_from_bdev(struct zram *zram, struct page *page,
> -			unsigned long entry, struct bio *parent, bool sync)
> +			unsigned long entry, struct bio *parent)
>  {
>  	atomic64_inc(&zram->stats.bd_reads);
> -	if (sync) {
> +	if (!parent) {
>  		if (WARN_ON_ONCE(!IS_ENABLED(ZRAM_PARTIAL_IO)))
>  			return -EIO;
> -		return read_from_bdev_sync(zram, page, entry, parent);
> +		return read_from_bdev_sync(zram, page, entry);
>  	}
>  	read_from_bdev_async(zram, page, entry, parent);
>  	return 1;

I was looking at zram's bdev (read from a backing device) today
and got a bit puzzled by that !parent check in read_from_bdev():

zram_bio_read(zram, bio)
  zram_bvec_read(bio)
    zram_read_page(bio)
      read_from_bdev(bio) {
         if (!parent)
           return read_from_bdev_sync()
      }

The thing is, that "parent" is basically "bio" which is passed to
zram_bio_read(), and it cannot be NULL (zram_bio_read() dereferences
it multiple times before passing it down the call chain.)  Is sync
read basically a dead code now?  Am I missing something?
