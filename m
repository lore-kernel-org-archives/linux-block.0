Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2BA0202969;
	Mon, 11 Aug 2025 14:13:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754921585; cv=none; b=bYLBdRoz27vfowUOO6P2GK+AW1Ah9bi9tXWHV16fkMbwcQ6rRZ3gltvWoFdlK7Mddvqu0c7I2NIoPhQNRrgxnyL/BHcuzuTViRkl81QpngZiLRycKmQRBN9T1tkqBCuO3DTG+WwBA0FC8cZc5UBG0342Dit8DwTFcV/TouDxbVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754921585; c=relaxed/simple;
	bh=EMguDzvtR8S3CAmnXI3rwvEIyT3kEbSy6TUdHcnNbOg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jjnbw1VbF8/vdvgFVbQKMj3yR45/p/H0K8mYbZm7E/CVhqbgPTmw8kqyZcSMxXA1ocLt+Vzv2b+JIQbFIvOZcJXEWCr3XzhkeZROjyj5vXgPPEq/Hk2Pv2FwgwKIbMy41qxXBh371H0exNMVgLK9Bx438gzHwE/gb+LTLC1mvZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nSol5r+Q; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nSol5r+Q"
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-4b0770954faso69443501cf.1;
        Mon, 11 Aug 2025 07:13:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754921582; x=1755526382; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=toD6ZaCq7RdEKdMIlGQmFzN+kPC0hgjo2o54e/dUNx0=;
        b=nSol5r+QwwuJCVSmGJgV72px9lDzs/DYN/zzfHcX1oDsO8g/SI2JNKJD4oz4wqTCmM
         uw4hxVCx6lb7ZFyeqtAvJlNscvfpcKjZ4WvkQIcM3rjD6KiUJ0uYEvnrSaDiBOeth4j/
         lL5uwctCjjCGoeGlmvHXRIn1ky2/hNcFK3C6v74IwWwG1jZ50G7CI4ECnEX+L1A55G5w
         Rufb7SbyfkA11s+dFqPhTLn2MqiPF+T/6gP8xlY+c1oZ3ZNz6CiSoKnY2bXYU1jr1uPK
         y9ZWdQ7uetJ/tkU3AcPVTOb1OvFjLmj66AnvJddeewRCZBwkZ467hUIcFRjk2H1+08dM
         oSJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754921582; x=1755526382;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=toD6ZaCq7RdEKdMIlGQmFzN+kPC0hgjo2o54e/dUNx0=;
        b=BX4ba+ngMRoVOk/kpV7MwDByC6lP3cyyyC8PT8wLNZix/xdZqSfwaI2V5D5Nk54xR8
         Esq5tCcgHxA/ymVJePAF/wy12WoSYZn2uwjlTfFxczIf92PQfCSS55PMVl1EUhL5CRmQ
         YGYMid98nYxNsTvvUnoWjGbAr4tIxt8uT86WQe/WMkmJcGCmk0xmA66ERv1t3ln1WG4c
         kCq9TuzsQKRY0OKp3DCVweLnICezaTp6xdBV7eraylHrkWkIsFnGNarEOfxoIwyGBWHN
         cNEimSruv0iZDe/Pw6MImTHqPaU836SKZv7dDZazmkPoNGikNX0JtLe1gY4pbmnssBue
         8zmQ==
X-Forwarded-Encrypted: i=1; AJvYcCUV5UJTT0jp7h53QjBDNSENFd11ND7JsAc8U3F1MH2AmnLZVYEVc2opNHxmKi3scnrWIqYdv68IiidAraD5xXY=@vger.kernel.org, AJvYcCW5T8lkr6FXH8XV8+b1ornaNBC8/d+LdvkVZeI9sim2toAHknWWFdbJEafNYWCn3jamlEW4KIyOl0rHQvaB@vger.kernel.org, AJvYcCXgGPvviMYjicbEs2P5aK2uKK+Ta8mwcsHytEhNO0uABjkznSAtGZ8gf0Fbpj2ncKPT5L/tmWhdFuOkfQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwCj1Y4YZDy2QW+zgAYsBsR10c3hvokJ6DEypsYMV4I5OhspP2d
	KhQ7sXswk9dTQSZX8y/i0Z3SjT+FClfhpizdvXGMVno8YQmvdIB8v7rgAZqyqA==
X-Gm-Gg: ASbGnctCwGw1N+QmZsU2Gp+A41nvM88pcuQPJn42WbrgyoFjYE7C4tCdRX5EN6ZsHVo
	ck1IiTtNnRl22b/s0FUGwb8TeNnCAEKj0Er9Fb93VgWOIBVXil1Ml38FF9lg0v0QOBcktB9OYSx
	O1hVKePGhldIbvL3/WpJ5QnRBthY8d39iPmwsR3NwmC5PH3hCnnoRh7HH8uUM9sbpTfQq7+KbkB
	vCHumwujFrCSWS0WXfS37najrB380NCK2UAPM7w9MxcEc2zLLsHrcCEWnRpHxNvlsoSuToEectu
	CHoY18G7jYsbnv/RESTTjhcYKZR6/L0w5JDG1+2mOiOcQ99bEj/NWZaoCdr7O/PMdR2Ipq68rlf
	CLR6rVJ/Zul2Xn65qn4aZ3LGZHxYAFMdXvNAFHpmLtFQEwYAXfZJ3PF6bcYy7i/jTUQ14euIV1h
	pslvkR+93+sZTmV7W9OovrJRQ=
X-Google-Smtp-Source: AGHT+IGVqQ0DGXwepke9q0UetJtTR1FVnzuHHpaC7cYJmU07cJxGgL62jt0c0w5rZ7kHtzxJkz+enQ==
X-Received: by 2002:ac8:5942:0:b0:4af:18d3:58a6 with SMTP id d75a77b69052e-4b0aed432c8mr214286811cf.41.1754921582191;
        Mon, 11 Aug 2025 07:13:02 -0700 (PDT)
Received: from fauth-a1-smtp.messagingengine.com (fauth-a1-smtp.messagingengine.com. [103.168.172.200])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4b0867b7b70sm83623431cf.9.2025.08.11.07.13.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Aug 2025 07:13:01 -0700 (PDT)
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfauth.phl.internal (Postfix) with ESMTP id D225CF40066;
	Mon, 11 Aug 2025 10:13:00 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Mon, 11 Aug 2025 10:13:00 -0400
X-ME-Sender: <xms:bPqZaFVxMS2KvdcD58nZLWzLzD3oG-9Nl_AEmw7tOgVgLiqKs-BFtQ>
    <xme:bPqZaGBmqPVquJlusSAMvGuXkQZhr3PXE3ySq_87YDrHPAD8ZVlH2h0xEsTdsw2Xy
    Zn7zFndE70zCHTHhg>
X-ME-Received: <xmr:bPqZaG0a7FnF1j8FbZnKKyuSKokHOxnBJp_LiV5UlO8iC3SsJ7dOpqcmeQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddufedvieeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepuehoqhhunhcu
    hfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmqeenucggtffrrghtth
    gvrhhnpeehudfgudffffetuedtvdehueevledvhfelleeivedtgeeuhfegueevieduffei
    vdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsoh
    hquhhnodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdeiledvgeehtdeigedq
    udejjeekheehhedvqdgsohhquhhnrdhfvghngheppehgmhgrihhlrdgtohhmsehfihigmh
    gvrdhnrghmvgdpnhgspghrtghpthhtohepvddvpdhmohguvgepshhmthhpohhuthdprhgt
    phhtthhopegrtghouhhrsghothesnhhvihguihgrrdgtohhmpdhrtghpthhtohepghgrrh
    ihsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehojhgvuggrsehkvghrnhgvlhdrohhr
    ghdprhgtphhtthhopegrlhgvgidrghgrhihnohhrsehgmhgrihhlrdgtohhmpdhrtghpth
    htohepghgrrhihsehgrghrhihguhhordhnvghtpdhrtghpthhtohepsghjohhrnhefpghg
    hhesphhrohhtohhnmhgrihhlrdgtohhmpdhrtghpthhtoheplhhoshhsihhnsehkvghrnh
    gvlhdrohhrghdprhgtphhtthhopegrrdhhihhnuggsohhrgheskhgvrhhnvghlrdhorhhg
    pdhrtghpthhtoheprghlihgtvghrhihhlhesghhoohhglhgvrdgtohhm
X-ME-Proxy: <xmx:bPqZaGSF-WEu5Lf4vF6p5gLz8VIbfpnqU7z_CEdnNmabwmbpTVtplQ>
    <xmx:bPqZaDYc_YxCQKWfXbYHFZJOO8CJzpvQN-L69KChogKh8o4SIwqPog>
    <xmx:bPqZaECOrlpi9WAecsuUj0O0ZwPGA9v9tu413r9F2FdIqm-xoZw2OQ>
    <xmx:bPqZaKD24XmaLNDGCHqLAALx2Pp5B6ORaYro_JY_qpc3U2NuPjOQJA>
    <xmx:bPqZaAFpW8oSWJ9bYoranDvL31XUdadMLTktFZC4SpJx_vx5zdBf998->
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 11 Aug 2025 10:12:59 -0400 (EDT)
Date: Mon, 11 Aug 2025 07:12:58 -0700
From: Boqun Feng <boqun.feng@gmail.com>
To: Alexandre Courbot <acourbot@nvidia.com>
Cc: Gary Guo <gary@kernel.org>, Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>, Will Deacon <will@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Tamir Duberstein <tamird@gmail.com>,
	Francesco Zardi <frazar00@gmail.com>,
	Antonio Hickey <contact@antoniohickey.com>,
	rust-for-linux@vger.kernel.org, David Gow <davidgow@google.com>,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 4/5] rust: block: convert `block::mq` to use `Refcount`
Message-ID: <aJn6au5X09eXHq6N@Mac.home>
References: <20250723233312.3304339-1-gary@kernel.org>
 <20250723233312.3304339-5-gary@kernel.org>
 <DBXR255ZMW6F.2AF1IOPN7IPI7@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DBXR255ZMW6F.2AF1IOPN7IPI7@nvidia.com>

On Sat, Aug 09, 2025 at 05:21:49PM +0900, Alexandre Courbot wrote:
> On Thu Jul 24, 2025 at 8:32 AM JST, Gary Guo wrote:
> > From: Gary Guo <gary@garyguo.net>
> >
> > Currently there's a custom reference counting in `block::mq`, which uses
> > `AtomicU64` Rust atomics, and this type doesn't exist on some 32-bit
> > architectures. We cannot just change it to use 32-bit atomics, because
> > doing so will make it vulnerable to refcount overflow. So switch it to
> > use the kernel refcount `kernel::sync::Refcount` instead.
> >
> > There is an operation needed by `block::mq`, atomically decreasing
> > refcount from 2 to 0, which is not available through refcount.h, so
> > I exposed `Refcount::as_atomic` which allows accessing the refcount
> > directly.
> >
> > Tested-by: David Gow <davidgow@google.com>
> > Acked-by: Andreas Hindborg <a.hindborg@kernel.org>
> > Signed-off-by: Gary Guo <gary@garyguo.net>
> > ---
> >  rust/kernel/block/mq/operations.rs |  7 ++--
> >  rust/kernel/block/mq/request.rs    | 63 ++++++++----------------------
> >  rust/kernel/sync/refcount.rs       | 14 +++++++
> >  3 files changed, 34 insertions(+), 50 deletions(-)
> >
> > diff --git a/rust/kernel/block/mq/operations.rs b/rust/kernel/block/mq/operations.rs
> > index c2b98f507bcbd..c0f95a9419c4e 100644
> > --- a/rust/kernel/block/mq/operations.rs
> > +++ b/rust/kernel/block/mq/operations.rs
> > @@ -10,9 +10,10 @@
> >      block::mq::Request,
> >      error::{from_result, Result},
> >      prelude::*,
> > +    sync::Refcount,
> >      types::ARef,
> >  };
> > -use core::{marker::PhantomData, sync::atomic::AtomicU64, sync::atomic::Ordering};
> > +use core::marker::PhantomData;
> >  
> >  /// Implement this trait to interface blk-mq as block devices.
> >  ///
> > @@ -78,7 +79,7 @@ impl<T: Operations> OperationsVTable<T> {
> >          let request = unsafe { &*(*bd).rq.cast::<Request<T>>() };
> >  
> >          // One refcount for the ARef, one for being in flight
> > -        request.wrapper_ref().refcount().store(2, Ordering::Relaxed);
> > +        request.wrapper_ref().refcount().set(2);
> >  
> >          // SAFETY:
> >          //  - We own a refcount that we took above. We pass that to `ARef`.
> > @@ -187,7 +188,7 @@ impl<T: Operations> OperationsVTable<T> {
> >  
> >              // SAFETY: The refcount field is allocated but not initialized, so
> >              // it is valid for writes.
> > -            unsafe { RequestDataWrapper::refcount_ptr(pdu.as_ptr()).write(AtomicU64::new(0)) };
> > +            unsafe { RequestDataWrapper::refcount_ptr(pdu.as_ptr()).write(Refcount::new(0)) };
> 
> Ah, so that's why `0` is allowed as a valid value for `Refcount::new`.
> Seeing the use that is made of atomics here, I wonder if `Refcount` is a
> good choice, or if we could adapt the code to use them as expected. I am
> not familiar enough with this part of the code to give informed advice
> unfortunately.
> 
> But at the very least, I think the constructor should not be made unsafe
> due to account for one particular user. How about doing a

Hmm.. a refcount being 0 is not unsafe I would say, it means no one
references the object (usually in a particular type of referencing). In
general, one should use `Arc` and be done with that, but if you were to
have different types of referencing to a same object, then one of the
refcounts may end up being 0.

> `Refcount::new(1)` immediately followed by a `set(0)` so other users are
> not tricked into creating an invalid Refcount?

This I will call bad code, as it would introduce further confusion
because the `new(1)` is pretty pointless imo.

Regards,
Boqun

> 
> 
