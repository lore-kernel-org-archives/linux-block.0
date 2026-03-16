Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F77A33ADA2
	for <linux-block@vger.kernel.org>; Mon, 16 Mar 2026 10:46:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773657995; cv=none; b=WfIt3OB8DoXklb0ccbMc8HjdUdp5qie7BEU24V8RNxto6TJCi9ae9/heKr0Nu4FYNH3QUQ5gPHhqTWh+Sj8H8ybSUVnwiLmZinVQcnAZAtmNmSEvJs+H6QTGqAWRTSJFvZYusbeEJtdsE7dKigW8eJNQk3KNe72FCSKDQZExSZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773657995; c=relaxed/simple;
	bh=mujOiA7/8GSOhusdiXfY20I4tDnR2Y2QbnZ132TAJ2s=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=jVrkraCdrJiMKh0CsbnahkaBmn801gQL9uyngWa566zkDhlbY2SNhO32pznMhZBNmEEgg6Z01TeE6gzPPomjWaQVvOl+8v6GIaSpKs2zhJpVKJnua2+oCVcGHAH8I9e7o5MWODY0pZ/8IITy3VCaYMiUV7eG9Ze0Em+CuV0TWBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CkVDdpSz; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CkVDdpSz"
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-485389bf0daso30183615e9.0
        for <linux-block@vger.kernel.org>; Mon, 16 Mar 2026 03:46:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1773657992; x=1774262792; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=8LZg1f0pUQ21eLP/CjPzvaDoUL0JnStFtL27P6lG08E=;
        b=CkVDdpSzl6VQwGVh5CqHh0861RkkeCjiQiRiFke44s8adRPAAtmvxV+OxowWk0tmKy
         bcmTDNBAyMVVwAhi8VJ1SMkir2GAVQ5qs+yqj/ORuV24VNfNzDryxZHLMO2vCCv/x1ii
         e3VlJfiJWgv1iEWhGR3kjrAsgAK52gM98fk5/EXdLJkzZ6wKsS2WKjcPuKCl19EbEjy7
         WveH0fDurAYndzZ1aCfG+MLX4Jl74U1c/11BRwYp84hURp56DjP6bLOmypQo+TzOGmCr
         rFkUu5g78O+1pqzrUWwPNr6AtM7Oaf8QOqPySLSWgF0feWpGsuA/yX/k7Ps7VoaGK2M5
         H8sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773657992; x=1774262792;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8LZg1f0pUQ21eLP/CjPzvaDoUL0JnStFtL27P6lG08E=;
        b=qLOupYVJiHyCaqi3BqQkd9vCVfQbsIO5UR0KjMuPdugNpbSQmX9VBWbDKgJVwq7bzL
         aSzrdPRMhjj3kZCpJHaJ4vr2E79I6DLuuiZMJemgqKliMzN4+jCrhg1VhfQh9RbeRygh
         u7+ZkaqeGFdmuIXWeMIG4XDEldgQ+vYQoiCObF8jw2tK4BfPg2vlNp++eJcGa/PbQhpi
         2r6RKXkSRMUj+kpVgnwLJz+8ccsDyGqpbwA6xBhSfoOKoefi8+YFfhjo6kJ3sd8aXAXc
         3oGZLgS9q/hm2h6j/j01jUUV0al7y3pHvJ39mWuV72koXWmGz/G8B1BCIz5eMLxR+W0c
         GmEw==
X-Forwarded-Encrypted: i=1; AJvYcCXPiXftgBzGCYqMo3yx2zzaflqtQIfvSE1+z5bymhCjuWVB56ux+lvYgJzs1zOaGBq83s5bRlk7GGzveA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxghHjDlJpUiaeXiK2YHOn4EBgh8ZWY51uE4799qrPUzLusFIq7
	BHQuKILKlKwJf7NjYJjQBfrbBifrDm+kUw3H84WcCdCkvL6eSRhP0RnKr4RPyw6fXkuZZZemYWT
	crpxK3sTgf2I86qRnmg==
X-Received: from wmga11.prod.google.com ([2002:a05:600c:2d4b:b0:483:7fc9:95e5])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:c4ac:b0:485:33ad:3c9f with SMTP id 5b1f17b1804b1-4855670c164mr205445595e9.25.1773657992295;
 Mon, 16 Mar 2026 03:46:32 -0700 (PDT)
Date: Mon, 16 Mar 2026 10:46:31 +0000
In-Reply-To: <20260216-rnull-v6-19-rc5-send-v1-16-de9a7af4b469@kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260216-rnull-v6-19-rc5-send-v1-0-de9a7af4b469@kernel.org> <20260216-rnull-v6-19-rc5-send-v1-16-de9a7af4b469@kernel.org>
Message-ID: <abffh79AODRjhcqM@google.com>
Subject: Re: [PATCH 16/79] block: rust: allow specifying home node when
 constructing `TagSet`
From: Alice Ryhl <aliceryhl@google.com>
To: Andreas Hindborg <a.hindborg@kernel.org>
Cc: Boqun Feng <boqun.feng@gmail.com>, Jens Axboe <axboe@kernel.dk>, 
	Miguel Ojeda <ojeda@kernel.org>, Gary Guo <gary@garyguo.net>, 
	"=?utf-8?B?QmrDtnJu?= Roy Baron" <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, 
	FUJITA Tomonori <fujita.tomonori@gmail.com>, Frederic Weisbecker <frederic@kernel.org>, 
	Lyude Paul <lyude@redhat.com>, Thomas Gleixner <tglx@kernel.org>, 
	Anna-Maria Behnsen <anna-maria@linutronix.de>, John Stultz <jstultz@google.com>, 
	Stephen Boyd <sboyd@kernel.org>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
	"Liam R. Howlett" <Liam.Howlett@oracle.com>, linux-block@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org
Content-Type: text/plain; charset="utf-8"

On Mon, Feb 16, 2026 at 12:35:03AM +0100, Andreas Hindborg wrote:
> Add a `numa_node` parameter to `TagSet::new` to specify the home NUMA
> node for tag set allocations. This allows drivers to optimize memory
> placement for NUMA systems.
> 
> Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>

We already have a NumaNode type, which you should probably use instead
of raw integers.

Otherwise this looks ok.

Alice
