Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE99E2F12AB
	for <linux-block@vger.kernel.org>; Tue, 13 Jan 2026 04:54:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768280051; cv=none; b=H6Dj1O/cImfd+DKFM2bBcnSJHB2axEB84s5YBiILWY4u6QkabYEOxl4EI96vjhGTIXgmyXjyet4cLomQmADV/bNPvMAXms6Zn3nKiQzirMF/UwQQf1g+4EfFc6AU1S3IIQc8TmYWA4JCHRc4jg3TtDNkpzjWs1YNuGjBiqEHVNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768280051; c=relaxed/simple;
	bh=4XH7SG21b7snAnQOojHTDt4mSjqwvVfkoZV1gEFjqno=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Gh/fqMjMOR+flCNtZPp6Lfu+2EW7WGThq8AL+M/R8DS/Mnv2r03R0wgjBwCmAW23kUwWIgp8y00r4MO3I5owmWWds0wambOag+LH5pg077qRCaZAs+AJK/Dh+2pI0eAu2cIDwZOlrXnzNVNTDkmSwidbQVQHgIVN+dTActDgevo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Qfdc9vZ1; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Qfdc9vZ1"
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-81dab89f286so1873112b3a.2
        for <linux-block@vger.kernel.org>; Mon, 12 Jan 2026 20:54:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1768280049; x=1768884849; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=UKtScXEwrHQrA89l3N54sxGcQUtq2SKFpHUrz7nEa60=;
        b=Qfdc9vZ1aZAinVhftv+UDUN2dJ0RabuR3WGx9PixKXzkGKjeoVtUN+TyZ6vtxyWfdL
         2wcQweuvFP11Ji2dkLhW12NcCYyWX3cthXmWtmR2lGYOiXkWGWCk3h15ZOw3F3it/c5q
         snh20MhcJivq34Q9iiiCN5eWo6+WgSNtTm/YY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768280049; x=1768884849;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UKtScXEwrHQrA89l3N54sxGcQUtq2SKFpHUrz7nEa60=;
        b=FOnmiLjAUcnw+6sHO/hCfHNgfNZSJlXaqNE40C8+SlvQpdIEL8eW7Cm/tJWIRxQ/qQ
         qV4Zc4DtBDR5kH1L3AcpUdDQsM+c5PwBfe/7hF2esBxNaJRrGKyewxRzoaa3QpoTt7Yh
         +5pCLQsc9/HjHJr6+Uu4+4xGVlK2F3Z+ot3bacI3czQMfnnVMq8TJQTE9WaBzTlujHB2
         nwf43mivCIlFKCvKvoYJhC4IUweg/fDOHwvegZUDr0GUI+m0hpFM3kbMEYEVmi+MuqMs
         pw4l6VZqVEM+0VDMv2O3bvJJ5CWSbAMYfI2GdsFrVys3d/jRgUkRfRivnCSqm1LzMtNN
         2CNw==
X-Forwarded-Encrypted: i=1; AJvYcCV0nWYIcRVUUAhKzPj+rEWdvLtvhciw/EZORNEKD9b40NxnnO7YLCDX5vCerY5ITi7iIPZEK4l6VhsZvQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yzy5awDbfhTJ4X5EvV8X2TA8xchOB2gQu9iI5UXHsINKs3f5P3o
	Ix60SoUKMJ+prN5Swf6F0MA+1r70++/2B1Ndid8M9dYn0EFlMFVmilBP9r4lf0JN5g==
X-Gm-Gg: AY/fxX7dmPXLSyhtv3v8IeWwTCnJM/2xqsAhXiOidbJ0qRaXKKRILc+vacsjbDgU2BL
	GPDzEqOkVxPP3uK6E7MAp/ZMxpzdmp+WynbQ9AZAWkdQkG++oTziuZ48tOzSOaWk6unJuJCklz7
	+kkAeIB1yDFAyBbNTwBLdxlUFVQ4zklmYtO3XvUPGLjlx+GiHJR+w7ynfw5E2oJBi5TuIZTnyye
	be36JOoNeBh8cgw/0WigRCFtI3U4UqVMRdGXJ835nUU29muashjSDKe5tbwtk+YifA6GL+gNtMM
	j0L4bMGuWheof9NZa4OrYAuBjvUkyh3k/kY8zCvJjpeFs+lpQ9+46owoNRSXLol/gAo9R394mOx
	Cdwiof5Gv21qT9CrzSxACPYbtpxu7r9LfiSy0SdL9oLCpF7Eo0f/8mjckaLmhM9Re/mmzuV8p7o
	yAykAG86ye4g3/BYM/1PmMgY/6T81PjEjN6earkTaKMH6IVPQD7Bt/uZ5ZpHAgnw==
X-Google-Smtp-Source: AGHT+IF8giJZ1cwqEfJp/6iUzbp0/TRCRwNaNcmX9U5Tj5XcALJKWgAQYkT9Emt45eu48BVTknyMpA==
X-Received: by 2002:a05:6a20:728a:b0:366:14b2:30a with SMTP id adf61e73a8af0-3898f9cd5d0mr19601101637.61.1768280049256;
        Mon, 12 Jan 2026 20:54:09 -0800 (PST)
Received: from google.com ([2a00:79e0:2031:6:3c61:f146:e418:e233])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c59b0bf72afsm6489637a12.28.2026.01.12.20.54.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jan 2026 20:54:08 -0800 (PST)
Date: Tue, 13 Jan 2026 13:54:02 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: zhangdongdong <zhangdongdong925@sina.com>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>, 
	Jens Axboe <axboe@kernel.dk>, Andrew Morton <akpm@linux-foundation.org>, 
	Richard Chang <richardycc@google.com>, Minchan Kim <minchan@kernel.org>, 
	Brian Geffon <bgeffon@google.com>, David Stevens <stevensd@google.com>, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, linux-block@vger.kernel.org, 
	Minchan Kim <minchan@google.com>, xiongping1@xiaomi.com, huangjianan@xiaomi.com, 
	wanghui33@xiaomi.com
Subject: Re: [PATCHv2 1/7] zram: introduce compressed data writeback
Message-ID: <aswaagdlczqq3sh2okdew2o5jtzmev5ghdz4ksvzmqkfsshbfw@aoxdptshkqvu>
References: <20251201094754.4149975-1-senozhatsky@chromium.org>
 <20251201094754.4149975-2-senozhatsky@chromium.org>
 <40e38fa7-725b-407a-917a-59c5a76dedcb@sina.com>
 <7bnmkuodymm33yclp6e5oir2sqnqmpwlsb5qlxqyawszb5bvlu@l63wu3ckqihc>
 <2663a3d3-2d52-4269-970a-892d71c966bb@sina.com>
 <z22c2qgw2al73yij2ml2hlle2p24twgpmz4jemfqhjoiekc65f@pvap7olsolfp>
 <a527b179-263f-40ad-9d7c-bfa86731bfde@sina.com>
 <luzn25fgin43cnbmvmxwps7isqeq2pt5kfn26jqzly6hbnedlp@ojpw52ldzmuw>
 <731f6e5b-f678-49ef-ad8e-fe6ff85d5422@sina.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <731f6e5b-f678-49ef-ad8e-fe6ff85d5422@sina.com>

Hi,

On (26/01/08 18:36), zhangdongdong wrote:
[..]
> > I don't know if solving it on zram side alone is possible.  Maybe we
> > can get some help from the block layer: some sort of two-stage bio
> > submission.  First stage: submit chained bio-s, second stage: iterate
> > over all submitted and completed bio-s and decompress the data.  Again,
> > just thinking out loud.
> > 
> 
> Hi Sergey,
> 
> My thinking is largely aligned with yours. I agree that relying on zram
> alone is unlikely to fully solve this problem, especially without going
> back to atomic read/write.
> 
> Our current mitigation approach is to introduce a hook at the swap layer
> and move decompression there. By doing so, decompression happens in a
> fully sleepable context, which avoids the atomic-context constraints
> you outlined. This helps us sidestep the core issue rather than trying
> to force decompression back into zram completion paths.

This approach is limited to swap use-cases only, while zram
is a generic block device: one can mkfs on it and use it as
a normal block device.  So, this is not a complete solution.

[..]

> If I recall correctly, this issue first became noticeable after a block
> layer change was merged; I can try to dig that up and share more details
> later.

Interesting.
