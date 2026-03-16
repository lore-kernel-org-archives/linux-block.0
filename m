Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FF5E30CD82
	for <linux-block@vger.kernel.org>; Mon, 16 Mar 2026 10:30:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773657038; cv=none; b=DYlD5xNyDtfTX+vJkosptfD4OLocdmZk7h5H6a4sJQKmOw+L2JrYTksTsPStwvs3QMrgrRxVPJrpGTsxePjYAAiCs+jMbfD+ayT8onMMIMR0ovJHr09fphWtkzzbHuKfNqnYNh0fn/v2sk9Fznioe3JZNZZI/cMMrMQjL56EgRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773657038; c=relaxed/simple;
	bh=Fn1Z0lBgz6sX38jQOL32jtRPnwQO+I+S3aYN4A2tb6g=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=NIIjyKftx1Ea3nPCIzG71HEdW57zc39z5Eo5H2u36ULCWO5fp4Pq+J2g9GYehS4IeJKcRTkAGMBvSqQZBkqifJ1C5HUWAJX+MhBserH9ojBzBTNshoINPXwaGuiAQ4munMwMJI/EpXRCAkGufnYWLaU62ArJ90JIm5BrCOpsj0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cm52u6QZ; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cm52u6QZ"
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-4853553944fso46070245e9.0
        for <linux-block@vger.kernel.org>; Mon, 16 Mar 2026 03:30:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1773657035; x=1774261835; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=GnI3L0XQnlP9mY2nbxG4p27V2eYyKmct78Co1ZDhRco=;
        b=cm52u6QZYkPGC9mCF/FvBO1bjAtPfNKyCHuo/GyzXZeFWQBKC7RzPzAa1YaVkxjGjf
         zJu5z/uGtXdq1LCjC2VHX1/dOekNqoU053bEOic+WLdmn2LpAKw2zC0Ccn7G0fDVvNxE
         c/gexKCCPqHWa6id1vun5Sw58tbN4vWY6ZcU4h+dCJDDiNpTh09ok7AmPeGnzkvjt1LB
         ZQ2ytFg5OOdcAbkiQwcjSGlUP9VYfFcEUDv1SrhHClgWrIng8eRRX/DV83AcWZWfkrVt
         zDr30sk6mI1DYH2fmKzwzd1G2iPoANbmvYHC+2rYNVy3TL9CxLHmJz7FVA0LoFl4RE+y
         7rKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773657035; x=1774261835;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GnI3L0XQnlP9mY2nbxG4p27V2eYyKmct78Co1ZDhRco=;
        b=KJoRTcoZ12nhQ9IyYPjg/Wj+GCwRUoqSGkc304sgGuVSjttZJzfQaU6mSUwMQu4wOR
         6pgxYONjTA8+gR5jjXcw/EzU2IqHwPDf7l2rAUO697lVvpvV1mm/3iSfxPu4Dqiv7gKx
         PoklMRuuN9YmsUghWSQMV9afIrGr9rVG2+lQTt0f3W9SdVVD6OAjTj1BcoUA2Mb9UQYg
         7sYPD74HidlyEjIFBSyh/84+HWAymxDkn36iZ2bkOEATPVLG4TdzLFZpQtnpR64qgKcs
         hT+VQTmmtU4B5hNYd3LeKUGQ0UkEDVya6gEH1rYgbUo0gi3b3maWT9w4nfejKSF26Lra
         /ehg==
X-Forwarded-Encrypted: i=1; AJvYcCV+K+PNX2QF3HbILP5+kAAGdfdKNU9aY2NrnpfgX8Y2LhBlURZ1/84ubWLaOXpXQ903mnM8WBmKjMgm4A==@vger.kernel.org
X-Gm-Message-State: AOJu0YyADqIEZ3kxt4gaRDRnfKhdLVFKbvfvVruQFLJqBwSzKYurRmvH
	k+K/3Gbzs5sBtliXxQ98qsSLdrwdLjeVBXAI+Pe564gsmLsNB1H1tpLwMb61+I/5/UIkzotfqNA
	9eM78DX61agenmWJQeA==
X-Received: from wmbjt1.prod.google.com ([2002:a05:600c:5681:b0:485:2d79:6c7f])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:3e05:b0:485:3428:774c with SMTP id 5b1f17b1804b1-48555ab09e1mr180890215e9.4.1773657035188;
 Mon, 16 Mar 2026 03:30:35 -0700 (PDT)
Date: Mon, 16 Mar 2026 10:30:34 +0000
In-Reply-To: <20260216-rnull-v6-19-rc5-send-v1-11-de9a7af4b469@kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260216-rnull-v6-19-rc5-send-v1-0-de9a7af4b469@kernel.org> <20260216-rnull-v6-19-rc5-send-v1-11-de9a7af4b469@kernel.org>
Message-ID: <abfbyuTWIXDz8iax@google.com>
Subject: Re: [PATCH 11/79] block: rust: mq: use GFP_KERNEL from prelude
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

On Mon, Feb 16, 2026 at 12:34:58AM +0100, Andreas Hindborg wrote:
> Remove the explicit import of kernel::alloc::flags and use GFP_KERNEL
> directly from the prelude in the module documentation example.
> 
> This simplifies the import list and follows the pattern of using
> commonly used constants from the prelude.
> 
> Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>

Reviewed-by: Alice Ryhl <aliceryhl@google.com>
