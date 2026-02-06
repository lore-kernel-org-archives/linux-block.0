Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BF303EDAD0
	for <linux-block@vger.kernel.org>; Fri,  6 Feb 2026 13:41:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770385297; cv=none; b=HiGKXNy67Kf7fldbN0LQL8d1pVsOldaQnOFm2IkFPU1ueipvVuxEHeYUbaquDfJHPNtYCLtXj5m4bvBFxVujBnV2CCRVFcN4JX5c/galppiKK/yq4krKSKK6gTHaroCOgBsk3ppX5g/gQis7OAVOyGbcnvzvPOLZXWNddJ5Hzpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770385297; c=relaxed/simple;
	bh=+OZMpUB4NB9Unpm7VBjK4a4FOY+JLHJZXxHyl2rpuo0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=fsd5/Jvr9VTn0sunVUOarIOk3K8nQHrJFUwBGznuZWp9SqtMKAzZ68OsTwm/JoRJ+DUJ/ujW3SwCXWaFjiORHZYjlvrHBWLGkdtQHDgOJPOurPQA01FSvovgd7+pBMeffiy+4NnffgBWGsc5w97zcf8Zv42Uj1P4nuXbYlySl2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=cOyqQm4w; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cOyqQm4w"
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-4362c932df8so401249f8f.1
        for <linux-block@vger.kernel.org>; Fri, 06 Feb 2026 05:41:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1770385296; x=1770990096; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=de3L1Y43pQAlWgG037quWHVZGctmRcLtI04VYJ4LOZw=;
        b=cOyqQm4whw7FEyCNXGQmsqlka4Mxg02pffu3lfTQtDtTPwvf69WAKZfBNkHBKk8KDU
         2Hdjid6fhDBnN/KTYPFAUecDABxZD13G4YMFKOy/pI6Y8bh7rx6s0hMY7ACfwVgm5ux4
         i1lQM7+O+iyOeaYuIaWD3y3zzG7KKuKtr3UkFB6jVnMdx6qpqAwcob0eOhQLYj30EFN1
         zQV02dKXeU7UZOXVpExSbV102Q3ZgcYXI8xINb58DiSKCNsy5rpqmyW0250E/6zs4rJq
         pTxqPb2Ug/8keIr5zmNTVuhMgv84u9M5evY7gZQyhsnPEwwQweBTUUextQ4WomfYMSdl
         6bFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770385296; x=1770990096;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=de3L1Y43pQAlWgG037quWHVZGctmRcLtI04VYJ4LOZw=;
        b=LScF3PQ9p6/jJ5HmAQJ2JphNW9r5xFEMkRjj2M0waWQM8YwBq93Mk5f+FTQVLT3X0K
         0XIb5kKdmoUI4yH17Fo9xdV0KkYRI/38KDKEJMQO3vRzFc1JHVhol9+eAvwbKUAd8jTU
         doq4RsevgOW1MLA5R3pkAs4VeHHqXByNVcHKnNUD2xfLXeEsEwLDjSn7eiccFTC1RmZr
         8w2FpvuHBTN1kc+UpQDU15h9/blEcJQnxZy5ZFYVAMDplTxfLNlzKuLaZnLE7Ete6l6E
         DLsvq6aJlEK1ZXwzCd1Yu7VuDG4AaIC0Sm6uJ3f1uYGmU92yCmCRjPLgkylyidyEBZ65
         Jx+w==
X-Gm-Message-State: AOJu0YyjoB3H1et706yhNi+/TBAg4WfJoCfKeNQuYUyYl9ZvpJaf95JF
	zDyng0ZeKwLNp77K34fbRZ4w+uArc9JJssXVJM9/FdKki8UyYtIwDPBDWpoTOFl6JNs=
X-Gm-Gg: AZuq6aJQHuTtn+Px4XXpjHYhNbT0U8c6hY49MWm90P8yDm7NBjLK6t16SI4LI1Agqh3
	g5zokAaGSnWWyAAbyvfRZK8H4Qri6sHsBrRZjd0esjz4JFXdcWo1Pyv/gqsBo47Js5K/ZzSMSg1
	//hYSP9eOZHHZz1RrNN0bty4Ag3NhGJTYqxIhdpMjAnXkVLZjYpDNq7P3LHQQvczAIvBV5LFbHu
	FrLveIF/czRsfTZm6GjnKdLezia4ZVCsX8zPVq17sBIH0qFOgAsw138XDwqkaOHTy2uMFXxUWr4
	khguKy3wAlvw1nxvQOoH3dUjAniyYY9Pt3GNCHdSMfdR/KcXWVn6lGx14sl/dU/XXi89lburUeV
	PcKOsAzHmT6tQVdKZejsPis3XaO69pUszCzgZ8yoI+hOoyIXsYPvtmysfOvjizlOIFFKLdeaixo
	60f745u9SSU7PbXK//
X-Received: by 2002:a05:6000:2410:b0:432:c0e6:cfcc with SMTP id ffacd0b85a97d-4362937855bmr4814517f8f.23.1770385295867;
        Fri, 06 Feb 2026 05:41:35 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4362972fc1bsm6103719f8f.28.2026.02.06.05.41.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Feb 2026 05:41:35 -0800 (PST)
Date: Fri, 6 Feb 2026 16:41:32 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	linux-kernel <linux-kernel@vger.kernel.org>
Subject: [bug report] bio: add allocation cache abstraction
Message-ID: <aYXvjAi0L-4casuv@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <caa37f28-a2e8-4e0a-a9ce-a365ce805e4b@stanley.mountain>

[ Smatch checking is paused while we raise funding.  #SadFace
  https://lore.kernel.org/all/aTaiGSbWZ9DJaGo7@stanley.mountain/ -dan ]

Hello Jens Axboe,

Commit be4d234d7aeb ("bio: add allocation cache abstraction") from
Mar 8, 2021 (linux-next), leads to the following Smatch static
checker warning:

	block/bio.c:790 bio_cpu_dead()
	error: potential null dereference 'bs'.  (hlist_entry_safe() returns null)

block/bio.c
    785 static int bio_cpu_dead(unsigned int cpu, struct hlist_node *node)
    786 {
    787         struct bio_set *bs;
    788 
    789         bs = hlist_entry_safe(node, struct bio_set, cpuhp_dead);
--> 790         if (bs->cache) {

It doesn't really make sense to use hlist_entry_safe() instead of
hlist_entry() if we're not going to check for NULL.

    791                 struct bio_alloc_cache *cache = per_cpu_ptr(bs->cache, cpu);
    792 
    793                 bio_alloc_cache_prune(cache, -1U);
    794         }
    795         return 0;
    796 }

regards,
dan carpenter
