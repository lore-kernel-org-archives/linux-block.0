Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A2051DC720;
	Tue,  3 Sep 2024 19:47:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725392829; cv=none; b=I1+6Q2xZEQYiFl5Z3otcqgynhtSTBKfG+n31MFv/5B8d1p7z3eQ+eVz/mhhR0tMjMOZP/Jlg3MIRV6otALZh7q/ZM1XOdw+H2jGGqkdE8++3gDU9uiqsaomz6piKMMQo1uPr2p8ovC0CKdnDz3sEYgcpiRhgg7S94lrN28ZRKuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725392829; c=relaxed/simple;
	bh=AW5O3fYmGL289gmg2dbXstbvmyw9Js/B5YLfw07ifLo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pFUU/dWhA7GWTVZJB+X2xbRtC4u3Si92vRegKNdwXq4kF0Rgi2TQ9sqUcUnkvG8h8lXXiV8aLw3yedyhMi7u2uF1g3aJ9Y6kni9qvWsKLEMAMda1QSaIz1QjZ/G/h5V68fpw5HR2KsnrnzCxlhLImMyFjvWBYzybXHtZW4mjZVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UQZwXfJV; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UQZwXfJV"
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-7cb3db0932cso4324984a12.1;
        Tue, 03 Sep 2024 12:47:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725392828; x=1725997628; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=sQE4RGf00KcJD0pcpR6cGZr6q6lFBV5A5RGUfUHfC2A=;
        b=UQZwXfJVlhl+wGkE6duOaV9F6tYPH4AxH8Wemmdos2cmdzVGndxn7avzQ1bSEltGRB
         S7t/nioiSb4uBT6aC2OXfae3W1fdphVvs/uxYkSRJ0FnZ7FhowLleWqsmvYy8uOKR5eC
         d59UzovYbDuJl2QfjUVXyrDPC7bAVWMiLw6vIGWpG1nZrV5naJD+jisWUum5/dW9rHAj
         q7Hncj2S6m0VZOWxadHsGkd8M8orxOivdQAArrrULUv10W3FZAPgI5AOfRGJHgqYRxsT
         eBUK7v2+Z+KouTqfXU9Q0hKV6RSA76AphjCKeh413BzKGyO9j16L+z6hX70fHHyMMFtT
         yjHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725392828; x=1725997628;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sQE4RGf00KcJD0pcpR6cGZr6q6lFBV5A5RGUfUHfC2A=;
        b=bYrQsFewynLMf4F4OnNR/TEHYw01Yty8D5ptpmuhgyStzw0U6RyocI+PvzXtardbMn
         R6Ohw/T3JWowCuByt+UaIEXAEPFEUR+sBSM5mTavOSboCJMrK8P31/VJBNnFVias3lmw
         bKN3SIkjn13Y/zSmVJyoSKXPgIG472GtFvaqUU9wPlm0SSjOZgl9J8dDgpn9zIls9Ks0
         lWITb0+gWOZBRu/saziNwxr72s1oLtxWdWnuIdQvu65xkNRPid0I2woTOulpujatDSYy
         f/5npXd5UiV0NlW8drJPb/4xbWs3b3aoMxwvw489MzRrh9ZJtSad89rjqAoqrX8RPm6L
         E4vA==
X-Forwarded-Encrypted: i=1; AJvYcCUPOuyW4JQjgeVvdpCr4qwUTdMyT4D6/7+Az6ypAXoYWXvXmmy7Qt+2Go/E+MGWu9NjGWh7VpZ5sv0j6Vmk4iA=@vger.kernel.org, AJvYcCW42aWCMFu71PEh026x0aj2DfD6+0YNaKSo59Frs0pqdnvU+iE6bD143pzhJKDGYcFaxo20ChAVyDvqbA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzyqtwlhRc8LGxyN/tv+tJQQulQBnqGHFDA7MI8AWZgbtf/CNyR
	2GmX1ZhjKD/2ELrTXjHfwmBuoGBLnzmDRc/gQkolslwIN3Qo9qm2
X-Google-Smtp-Source: AGHT+IEdvgz/igkRwCVTF1iTKBYnEie+4ECXFulIAHBmC2FHNBpY/Ut/3YcO/5TBs5f58FRsaBMm9g==
X-Received: by 2002:a17:903:40cf:b0:205:9112:efea with SMTP id d9443c01a7336-2059112f137mr73932235ad.35.1725392827404;
        Tue, 03 Sep 2024 12:47:07 -0700 (PDT)
Received: from google.com ([2620:15c:9d:2:e682:e3dc:908:eef0])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-206ae913ad2sm2128605ad.39.2024.09.03.12.47.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Sep 2024 12:47:07 -0700 (PDT)
Date: Tue, 3 Sep 2024 12:47:04 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: Andreas Hindborg <nmi@metaspace.dk>,
	Alexey Dobriyan <adobriyan@gmail.com>,
	Benno Lossin <benno.lossin@proton.me>, Jens Axboe <axboe@kernel.dk>,
	Andreas Hindborg <a.hindborg@samsung.com>,
	Boqun Feng <boqun.feng@gmail.com>, linux-block@vger.kernel.org,
	rust-for-linux@vger.kernel.org
Subject: Re: [PATCH RESEND] block, rust: simplify validate_block_size()
 function
Message-ID: <ZtdnuH9lWtsPCg-X@google.com>
References: <878qwaxtsd.fsf@metaspace.dk>
 <Ztdctd0mbsJOBtJV@google.com>
 <CANiq72=GRbxY=3-NP6RutcJjCqRxRftafVZqDD73tureOh20Ew@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANiq72=GRbxY=3-NP6RutcJjCqRxRftafVZqDD73tureOh20Ew@mail.gmail.com>

On Tue, Sep 03, 2024 at 09:30:53PM +0200, Miguel Ojeda wrote:
> On Tue, Sep 3, 2024 at 9:00 PM Dmitry Torokhov
> <dmitry.torokhov@gmail.com> wrote:
> >
> > If you want to keep dividing into Rust-land and C-land I'm afraid you
> > will have 2 islands that do not talk to each other. I really want to be
> 
> We are not trying to divide the Rust and C side, quite the opposite.
> That should be obvious since dividing both sides only hurts the
> project to begin with.
> 
> > able to parse the things quickly and not constantly think if my Rust is
> > idiomatic enough or I could write the code in a more idiomatic way with
> > something brand new that just got off the nightly list and moved into
> > stable.
> 
> If a feature is in the minimum support version we have for Rust in the
> kernel, and it improves the way we write code, then we should consider
> taking advantage of it.
> 
> Now, that particular function call would have compiled since Rust 1.35
> and ranges were already a concept back in Rust 1.0. So I am not sure
> why you mention recently stabilized features here.

I was talking in general, not about this exact case, sorry if I was
unclear. But in general I personally have this issue with Rust and to
extent also with C++ where I constantly wonder if my code is "idiomatic
enough" or if it looks obsolete because it is "only" C++14 and not 17
or 20.

With C usually have no such concerns which allows me to concentrate on
different things.

> 
> For this particular case, I don't think it matters too much, and I can
> see arguments both ways (and we could introduce other ways to avoid
> the reference or swap the order, e.g. `n.within(a..b)`).
> 
> > This is a private function and an implementation detail. Why does it
> > need to be exposed in documentation at all?
> 
> That is a different question -- but even if it should be a private
> function, it does not mean documentation should be removed (even if
> currently we do not require documentation for private items).

I think exposing documentation for private function that can change at
any time and is not callable from outside has little value. That does
not mean that comments annotating such function have no value. But they
need to be taken together with the function code, and in this case
Alexey's concern about comments like "this increments that by 1"
becomes quite valid.

Thanks.

-- 
Dmitry
