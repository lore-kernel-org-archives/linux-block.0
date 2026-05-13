Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D6DD331202
	for <linux-block@vger.kernel.org>; Wed, 13 May 2026 13:29:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778678955; cv=none; b=dpSsGkMBTdcvxIM8Wpcu613Db9mB8T6rwnBfBg6h0MhNhgPqgcI4kDEk2sEMTwwxt32JKlTzO+7T+3uqv4ar2fNoLDw5G1ngp68oadKnE0bpGuq2gcu8peIP9r1XTl2l3mEuKBSUvFV3kQodpx35YwnB/pVXTaDdrPABVzcR4lo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778678955; c=relaxed/simple;
	bh=qvrzIgPI09xnL+lPNRKw47FDVzkn2xkt2K7Rwhlyrpg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Jg+/1CRqoJQpJpQoa02ewDQBzc/pPa28JAQmCgOoACSPo7rQm4dCB2rGnfoJWhK/GDbAsAK/KUt7nFBOMuCM0RtkiR/UQrN8FIco61dw1LjdT/70kPy3prVdNNpXrKh3WzxHl9Xo5C0gSNenCY43QvTnxUyun5DxP+/uV5UtLjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a107B9Ew; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a107B9Ew"
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-441209fb77eso4152105f8f.1
        for <linux-block@vger.kernel.org>; Wed, 13 May 2026 06:29:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778678952; x=1779283752; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+cq+23+E96HQoAhwgeeSJr3+OJ8IJX5BGImZhad/wV8=;
        b=a107B9Ew/L+JG9kf+Z1nV/fx/+/Yb5mbJ9IZSmqcqG5NRhHtSigWVxLyt5e4tVheRP
         fVjtYzbSvKxWG/9swUAl2JC7bOL4zt7vyjCnIC8OuK2OMjbgJBd7ZXSOd9A2k/U6ZdZx
         IjexhbZVncU3yj8qsWTZZXbphJKEGru0GTV9TW0VSNxNUEF9TejQU1LxeC23owu6b8iT
         ERboyV8DTmKJyNrtYYu2ZtgNGMFqTuCpA+7JxZMpzt9wq45ITtvGgvRTJ8s7Z9NXHaiv
         Dc2JWteKzwRsB8GUKRASoBUvNyZQ288ROHW0dQRuuliK8uDWf25EzvdXbuywp4OcMKw3
         hDpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778678952; x=1779283752;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+cq+23+E96HQoAhwgeeSJr3+OJ8IJX5BGImZhad/wV8=;
        b=rkCksOkdut1n8QIfkpdvHl/8y/qyMquVdtsUpLV8GXfLIzdY8GgPQU7QgaEKEql9G0
         FG+5E4qHcee9Ju9WLx4+8XlHuQHlWsYhKJQD1UrJHu5P72Rkh/QRZLX4ZhRkgdU9VtBZ
         /Z54UXs1JXulRt5DC2MSVBIVAF43l84rwySF2NMxDBFqoI0aAH85o+aDAaKAc6Piwarr
         xjNiCpsqXIX0Pe7ZM53d4VHqj63TMUydJlJmsUw/Ec7cwg5gzcEDVigLyJcjB3nTc2OP
         4l4jtFAjExvZ/AYh9N82ewXIgR0A2s332y0Mg7HnZAEAOhduYKY2DSMHtzvif9i0hc0+
         SUHA==
X-Forwarded-Encrypted: i=1; AFNElJ/lCcbMZ6ZMSg3l5bn0K4OEjPjsc0wQGXVYojqfZSml41IFv0p9P2Ply0ma+5krr8WOKN4eoPyvwQsYBg==@vger.kernel.org
X-Gm-Message-State: AOJu0YxP4Bp1z0hEu91n0HUNCyH/Bc7OS1WgW1bVKIK5gtJkROo07A0N
	fdX8VLWqCwzZnpVowWrC02qOWvHdoYJRlzYIH7xVsqIfnAKwWc9qBrYA
X-Gm-Gg: Acq92OGDcNk0yHarCXUoaCS1tlnoTFPX310smiBz3/L/hUqHKDrbBL4XmozqQFnl2lN
	HVW6qkxqfiYPB94SMcmnpmcXGIc5hn/owbc1BN8eDOtSOfYfDijCQD2NC53dQiQZViXyN5Xjkho
	31bzBlNsz3YER4CYhCdo+Tqxq6F/DQCzRRMSZAuXeyLCqGArHAQv/nDOw6Xg8WFh7nIbPqTvzY5
	oT34Gx/ghLOlfd19vRknSI6DXj7xn1yiE2h6PHezbR6YN347eEnGzgHFm9si1219jFv1K+lFkqT
	2ETI6EQ+s45E48Fxb6sPGzdF2yyxaxs/aeSLyPWEgyismb+GohErL5A8JOK6LVMTi2qFD06UkP4
	1Y+uH120nA+YgDT98qXMynLjBlv4Q3+BGuHkMgxL0//WlqK0Ggnv02mJQFtUPUjRTfyxPXEjbMe
	RlPOIm2u5PFPQ4CnFVvA/RlepQASFMyNBLH3BH/7DF2iJpFqD/LyIL+a0EQc1q
X-Received: by 2002:a5d:591c:0:b0:446:708e:1e8d with SMTP id ffacd0b85a97d-45ac4504a13mr9930360f8f.30.1778678951817;
        Wed, 13 May 2026 06:29:11 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4549120ec0asm40068578f8f.17.2026.05.13.06.29.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 May 2026 06:29:11 -0700 (PDT)
Date: Wed, 13 May 2026 14:29:09 +0100
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
Message-ID: <20260513142909.03ae6c2b@pumpkin>
In-Reply-To: <20260513110557.705bdeed@pumpkin>
References: <cover.1777475843.git.asml.silence@gmail.com>
	<20a233d2f35274817aa643cc0fe113707eb47e72.1777475843.git.asml.silence@gmail.com>
	<20260513110557.705bdeed@pumpkin>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 13 May 2026 11:05:57 +0100
David Laight <david.laight.linux@gmail.com> wrote:

...
> > @@ -575,7 +575,8 @@ void iov_iter_advance(struct iov_iter *i, size_t size)
> >  {
> >  	if (unlikely(i->count < size))
> >  		size = i->count;
> > -	if (likely(iter_is_ubuf(i)) || unlikely(iov_iter_is_xarray(i))) {
> > +	if (likely(iter_is_ubuf(i)) || unlikely(iov_iter_is_xarray(i)) ||
> > +	    unlikely(iov_iter_is_dmabuf_map(i))) {  
> 
> 
> Doesn't the extra check add more code to all the non-ubuf cases?
> This could be fixed by either making iter_type a bitmask (with one bit set)
> or writing an iter_is_one_of(i, ITER_xxx, ITER_yyy) define that uses
> '(1 << i->iter_type) & ((1 << ITER_xxx) | ...)'

This seems to DTRT:

#define _ITER_IS_ONE_OF(iter, t1, t2, t3, t4, t5, t6, t7, t8, ...) \
    ((1u << (iter)->iter_type) & ((1u << ITER_##t1) | (1u << ITER_##t2) | \
        (1u << ITER_##t3) | (1u << ITER_##t4) | (1u << ITER_##t5) | \
        (1u << ITER_##t6) | (1u << ITER_##t7) | (1u << ITER_##t8)))
#define ITER_IS_ONE_OF(iter, t, ...) \
    _ITER_IS_ONE_OF(iter, t, ## __VA_ARGS__, t, t, t, t, t, t, t)

int foo(void *);
int f(struct iov_iter *i)
{
    return ITER_IS_ONE_OF(i, UBUF, KVEC) ? foo(i) : 0;
}

See https://godbolt.org/z/sMz93zah1

Pasting ITER_ on the front ensures the values are constants of the right type.
OTOH it makes it harder to search for uses of each type.
You could paste _ITER_ on the front, elsewhere define _ITER_ITER_UVEC
to be ITER_UVEC (etc), and require the caller use the full name.

-- David
