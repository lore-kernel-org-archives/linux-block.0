Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38DB933B6FC
	for <linux-block@vger.kernel.org>; Mon, 18 May 2026 10:40:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779100826; cv=none; b=bOO+btFHPMeWB/LBhxHr60okjdTVTTzSc4OBLBzBoOpkdEqm1ju2KgGVsu2moLqtC1LLv8YMiOMIvk9a9qvJfsaB6V5qjMcFTuNtsUxd5BBYsYBj4N6k5Az4ewmFQ95G7rfhGy6DtbBpzNsEKhthz9btJtC/hAzGT9VR/FeALew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779100826; c=relaxed/simple;
	bh=nvWmJIaONRzVgGZxYOqc+RrJHx05ZpEkKGknRiyvoD8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=T0kQJY+gaf8fB/q+zypMPut+BudWajvHLQCg4IAI3Dkh0nt+2/AxqhKyV/erSEm6aEfPrX4YVSwd2e8sgIPivQRI02VbhdzrcNwiKRiNg140VSUuIlm49et4odbNd2Q893y1LG+h40yPof720Tm23ETcJuxnXufJidtgwkfaikc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YOYYn5lU; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YOYYn5lU"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-488a8ca4aadso20309125e9.3
        for <linux-block@vger.kernel.org>; Mon, 18 May 2026 03:40:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779100813; x=1779705613; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KBUJm1g4jrVLHLARnQ410xCyIfZ2+knqUA7xvFczZVo=;
        b=YOYYn5lUbwDpJJVHgwa+b/uqKmMzzJUm2hIehQT0RfeFic6DPTkEctu4+6yrgoTAaT
         u9kxlBwiCUk0uHQ4MQ/QBAMPpt5K718IZ1zg5BOo0iQ4OLbx3XAXNVsWFT6PYjxqxiG3
         oHvr3OC9nqzpeCxci5FlRGKp37b70XvyPHj0YP2cIbP8cJX6i2a3sWtAjU3noV+2X2PV
         wkzhPFtUIxCLP4t2y+z/oBQ4ozn1vMXZ6+OkNNIHU/t1RtK8qSsYeCEvIA84yzvQhJL7
         MTCcnZhiu8pCfSAOkym3yaNcHT8UovdrqFjblxy1DWYmyiaOdzDrXeutHhDa+t8th2oz
         CsUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779100813; x=1779705613;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=KBUJm1g4jrVLHLARnQ410xCyIfZ2+knqUA7xvFczZVo=;
        b=f/pipM+6EyXV+0KRfVFiWVa050nV+Q0fITi4uDDnADw5t/M8WEVJpPTOOW/yw2N2nv
         J5OO6UGUJevFf2f1WFXYa5w1X+HW6Yd8wpG1AyyVuiDngz980hI8qWOL81TY7lldWNXg
         v4mFucJSbgO7KvkEr4lkKUa3ShZoND8EJRWiaMv1FuBMT8uvxWOHkJVC00qfecItUP7V
         VcYv6aRJh/Ghv/Gjk3EiID9tflB/bKmCxlmL1LahLqx9VfYPuw1FHI0eJz5VyqLOVoEU
         7ROqvkt0s3nzKA+AplCBXl/BgBIdZdtQ5XqzWp8VwtnpKlRKUO0yRKmLi8OYioFXoo58
         TQtQ==
X-Forwarded-Encrypted: i=1; AFNElJ/njHYsne7Rg4jl1Y30lbsDsUB+cYC9t2MEeAqY7Y3DlpmQoMVu0dsLWyrLzeat5Gx9o/eoPWWFjJnE2A==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3N2WN4ZpoZq5EJDV8SOHgvNAdUVIyZZBBBMwKj30/zz8tn6cd
	zG5O/53i83vzTOPhiDvxDhjvwIb76zYbZ4AEMTh/bUT6DLAwyAABnpdL
X-Gm-Gg: Acq92OHG9VhihGtjB2bCZWdYC0E738SG8Vk5usT5UuRy85/S0tvxmV+HsWekNG+GeM9
	6jPa0fx1qiBJN5zOIYse7zaLH67e4gjlGQfWBXU6j357WPpSpT/FYgeMJCUSxCI4WjFK1ZwQYmV
	25vPv9zrgk9RRoMgaVEw65sDSf/UYrUI9HmVMUMjSfnicKfla/Xlj2Ubs1DumgyyHzsRZ1z0YSJ
	TwKZvwPUHOXYmFdB6vY0wj3dFhJdVaKG4l27ZCBNVwI7abc71sCypbnika2kzbt8pq+DxnWbBbq
	w5eRBYU9ab/zSNSj6SbXSRT5UFp1AJv1NUnT3/yNBp5XJdbshIe2k4KfaLj0IeALGrvaHQ2NaOO
	JkY0LsM1FCno4BhRwg2EVrilc0B/7UgocJ9/QihShECWuelfWpE2lR3MYZMgea1NTKW/Er5wieG
	MQZYbYvt8H4s66gAt7n6pLExbBdC16KN20SxLFKEWCSyPYcf2Sfeyv4bli690gv0BiirgeEf7bb
	eTH2Zur3wArbw==
X-Received: by 2002:a05:600c:4fc9:b0:489:1c1f:35df with SMTP id 5b1f17b1804b1-48fe60e58ecmr202920365e9.10.1779100812550;
        Mon, 18 May 2026 03:40:12 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48fe4c90b27sm255713955e9.8.2026.05.18.03.40.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2026 03:40:12 -0700 (PDT)
Date: Mon, 18 May 2026 11:40:10 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Pavel Begunkov <asml.silence@gmail.com>
Cc: Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>, Christoph
 Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, Alexander Viro
 <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Andrew
 Morton <akpm@linux-foundation.org>, Sumit Semwal <sumit.semwal@linaro.org>,
 Christian =?UTF-8?B?S8O2bmln?= <christian.koenig@amd.com>,
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-fsdevel@vger.kernel.org,
 io-uring@vger.kernel.org, linux-media@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org, Nitesh
 Shetty <nj.shetty@samsung.com>, Kanchan Joshi <joshi.k@samsung.com>, Anuj
 Gupta <anuj20.g@samsung.com>, Tushar Gohad <tushar.gohad@intel.com>,
 William Power <william.power@intel.com>, Phil Cayton
 <phil.cayton@intel.com>, Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: [PATCH v3 02/10] iov_iter: add iterator type for dmabuf maps
Message-ID: <20260518114010.6e1f7391@pumpkin>
In-Reply-To: <4b2f74e9-3225-47f6-85fe-911720030e35@gmail.com>
References: <cover.1777475843.git.asml.silence@gmail.com>
	<20a233d2f35274817aa643cc0fe113707eb47e72.1777475843.git.asml.silence@gmail.com>
	<20260513110557.705bdeed@pumpkin>
	<20260513142909.03ae6c2b@pumpkin>
	<4b2f74e9-3225-47f6-85fe-911720030e35@gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 18 May 2026 10:24:35 +0100
Pavel Begunkov <asml.silence@gmail.com> wrote:

> On 5/13/26 14:29, David Laight wrote:
> > On Wed, 13 May 2026 11:05:57 +0100
> > David Laight <david.laight.linux@gmail.com> wrote:
> > 
> > ...  
> >>> @@ -575,7 +575,8 @@ void iov_iter_advance(struct iov_iter *i, size_t size)
> >>>   {
> >>>   	if (unlikely(i->count < size))
> >>>   		size = i->count;
> >>> -	if (likely(iter_is_ubuf(i)) || unlikely(iov_iter_is_xarray(i))) {
> >>> +	if (likely(iter_is_ubuf(i)) || unlikely(iov_iter_is_xarray(i)) ||
> >>> +	    unlikely(iov_iter_is_dmabuf_map(i))) {  
> >>
> >>
> >> Doesn't the extra check add more code to all the non-ubuf cases?
...
> >> or writing an iter_is_one_of(i, ITER_xxx, ITER_yyy) define that uses
> >> '(1 << i->iter_type) & ((1 << ITER_xxx) | ...)'  
> > 
> > This seems to DTRT:
> > 
> > #define _ITER_IS_ONE_OF(iter, t1, t2, t3, t4, t5, t6, t7, t8, ...) \
> >      ((1u << (iter)->iter_type) & ((1u << ITER_##t1) | (1u << ITER_##t2) | \
> >          (1u << ITER_##t3) | (1u << ITER_##t4) | (1u << ITER_##t5) | \
> >          (1u << ITER_##t6) | (1u << ITER_##t7) | (1u << ITER_##t8)))
> > #define ITER_IS_ONE_OF(iter, t, ...) \
> >      _ITER_IS_ONE_OF(iter, t, ## __VA_ARGS__, t, t, t, t, t, t, t)  
> 
> We definitely don't want that, using them directly would've been
> much cleaner.
> 
> if (get_type_mask(i) & (TYPE1 | TYPE2)) ...

You need to shift all the TYPEn as well.
The above condition would become:
	if (likely(ITER_IS_ONE_OF(i, UBUF, XARRAY, DMABUF_MAP))) {
which reads reasonable well.
Without the token pasting it becomes:
	if (likely(ITER_IS_ONE_OF(i, ITER_UBUF, ITER_XARRAY, ITER_DMABUF_MAP))) {
and the line starts getting long.
Although that version probably needs a check that the mask is constant.

-- David


> 

