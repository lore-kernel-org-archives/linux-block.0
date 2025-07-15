Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81232271466
	for <linux-block@vger.kernel.org>; Tue, 15 Jul 2025 09:34:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752572098; cv=none; b=hG8+CPBFkF1MZvtSIidLgUwsc+8Y+hONHLrUQi1PJ40+OYHVbqGDpiRrZTvBxDoFo4GCdSGHsF5dr9unqDZzq1Cwc/GkG/n4ZXlT77z3j1cYTVQF6UM/9TeqLNLKZmzANM6yXQ5sSWo7FwSD9FzMulAcT9srtH3w81Z67XTZOXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752572098; c=relaxed/simple;
	bh=SW8g2sGzj8cOGWOFPcNcOjWxh1xRALfpblwtuQfW44w=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=DKjqYJzBti7qKscrirRg6HKYANLk3iwZvs2znTVCDsbJOdZnhcOCNg6BepOTe3tcY7F8/308mLrIGTuIK5lQO3AgCBJFwD+VdlzfLSvEsobDHVJdjayHPEPv+rjAR7nrOD9wLqRaWZF8j341Cw3tbWA+sCbeUMhiEDbwcUksssg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=eCCmsqYU; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eCCmsqYU"
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-453817323afso32882245e9.1
        for <linux-block@vger.kernel.org>; Tue, 15 Jul 2025 02:34:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752572095; x=1753176895; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=l8yUNfVz2yZkexOKK7SEe5mo3/8fTwZuFskFLzVIPqc=;
        b=eCCmsqYUqt4ZYJ/+b56w72eJU1V48L0rmx8d7Ez5A8en+WKqr/WE00Eao+nn9FVM72
         w6pFcY6r09Wao/VTS32P/0pLsy3EKayqcz1KFjYzimDZlvB2HI8uksSxZXy/I1NlmY8j
         Ljvs1zQK00jhVPbJeMcbHqMM+BYkOtIig4UVCzCVA3R8hVI7pzw57pGafju2ApCw5O9v
         DvIiXm1BafCJegfrboMYZRY5NlYDGzpWLiBsUTVZGrqiYVATV+MPXzZxCWwBUUtFNXDf
         rQOUmDfazugKU3Z0/cL1EJnAwvzkEHYuyGCjvbcfilxayFLNecTfWcVxG1n/7XQiUWfs
         rbAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752572095; x=1753176895;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=l8yUNfVz2yZkexOKK7SEe5mo3/8fTwZuFskFLzVIPqc=;
        b=CBfueHkOq+H3zKu/GqPAB2D7qLeCacsBaqD2rd+leMCurFkDM0pmI7dyu5G1NpaaQQ
         rZIUE4oB1zKVIOku5sKvbRWAtRYbWltPQYMKd/tsUP4q7UDSBDDrFhqyn85W6gpoQ7f+
         3/OLnlNJBgLgEfvcL8Y/XcXxjfSZly6C96Vc5W1Zd99bEiVGp5gV0HT4jTbFTq2GOjq2
         neb8M1xiTETZ+0EzzV5gEDpqPSCxZwvNj3oojYohpgiz5eWUuTGivXLP8y/adcUh0fbW
         z4SJtufpevIWbYIu+/ykLINDaSoYiuyEBpLZkLP2S+ThySoFZowqL3hA03nic1FHmDVE
         5XjA==
X-Forwarded-Encrypted: i=1; AJvYcCU1iH7rnzkLQf2wNBum4zXEw9KDXULBwqyN+WCzBNrB8tG0fh8P1nExiK1EgCYg2eML5f1CPp/PMddv5g==@vger.kernel.org
X-Gm-Message-State: AOJu0YwBoF5nP+we33Kg0FnuWn8z+eyB4MhivyEzE01tmFTBD6qCeq1J
	aIXSs0LOATn0cXMIgj/CjzUl19sdaU9LCViGWg6yVMFowfbMPIPC6URvQ9wqG7zaZ6E337MP6Lc
	5XS+Jn48JFDZlIVGwUQ==
X-Google-Smtp-Source: AGHT+IG5JFdwYFqwZe2nCzfhShGuYrv1qI/g5T/gPRHpEuD7yOmiP4fFJ4+Bp8QT6JxHaKdpkkFLe5FdFIrw2eo=
X-Received: from wmbes26.prod.google.com ([2002:a05:600c:811a:b0:456:217f:2625])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:8b25:b0:456:18cf:66b5 with SMTP id 5b1f17b1804b1-45618cf6c49mr61966405e9.22.1752572095033;
 Tue, 15 Jul 2025 02:34:55 -0700 (PDT)
Date: Tue, 15 Jul 2025 09:34:53 +0000
In-Reply-To: <20250711-rnull-up-v6-16-v3-2-3a262b4e2921@kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250711-rnull-up-v6-16-v3-0-3a262b4e2921@kernel.org> <20250711-rnull-up-v6-16-v3-2-3a262b4e2921@kernel.org>
Message-ID: <aHYgvZ0DEsF93zC9@google.com>
Subject: Re: [PATCH v3 02/16] rust: str: allow `str::Formatter` to format into
 `&mut [u8]`.
From: Alice Ryhl <aliceryhl@google.com>
To: Andreas Hindborg <a.hindborg@kernel.org>
Cc: Boqun Feng <boqun.feng@gmail.com>, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Gary Guo <gary@garyguo.net>, 
	"=?utf-8?B?QmrDtnJu?= Roy Baron" <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, Jens Axboe <axboe@kernel.dk>, 
	linux-block@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="utf-8"

On Fri, Jul 11, 2025 at 01:43:03PM +0200, Andreas Hindborg wrote:
> Improve `Formatter` so that it can write to an array or slice buffer.
> 
> Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>

Reviewed-by: Alice Ryhl <aliceryhl@google.com>

> +    #[expect(dead_code)]

This could just be a public type to avoid this.

