Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D07DB39021F
	for <linux-block@vger.kernel.org>; Mon, 16 Mar 2026 10:56:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773658585; cv=none; b=lurFRwwLBkCzihU0sRBtY4TIYzOIIETU0Nt9nfCwmS8svwZY3abiJ6NcxHBaCZJpY8W8z/EwiWZx3azVoQWMVEzixZOA7rq/yKvO/ojilKkxOcloPjE0QeGFbHrSAhbwyFdPIJ+2/AHf0C4E+QcQmdwmYcTkDg8N7Z2oDM2OHcw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773658585; c=relaxed/simple;
	bh=UsrG64AdOhup+wZBugoJxKc7YGItuood9RNG/AVe/pE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=r4cVKP3s4hQ3G6XMPITPSWa0dFNT5S6nZYbelXiK8E54nUk8nj/dd86z8szOf/wc7nZ2/r6EsmjbV+wuvOtqtgtJhiTRJCwnNnceUtmjDD+10+MF5U2U5Z2TjJBlzouJSolCsfNKW7d7YSSbrgl/yHgufA31qhS0FW82mjGK1sA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Et7Fx+F/; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Et7Fx+F/"
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-4852cf0318dso61014295e9.3
        for <linux-block@vger.kernel.org>; Mon, 16 Mar 2026 03:56:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1773658581; x=1774263381; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=/z1SiqPCUjiS0l1gYfp55UVRcWnc3c5gpJsp5+gG+GQ=;
        b=Et7Fx+F/K0livNgzpWkxm0lDeD3B0CP9OCpBTPmi4vlih/NCJD06O2mZe3+jKqJpT+
         QMiz9z7+7JYrfjXxAofK1n7KgXDlORGSrKR7WlebrahTOsmVx21jMmmiaWr25YCsfAcp
         uFxwv828mgm1zoE+AuJo5YkO18czJzpy7WIRptUnDFFXbGVuXem81QzN7mgBRwN9hlk0
         4Q6AZ3suC20pw9X8DkFhDWk5G4XtUecwwZ2FqfwNd6TrgqhX9NISj7+7r9JQQCvxDIiK
         RsYAV2dKFEkSoRBUDwI2pxD7aYO70yfLlOAZk6KU6bRRn2+czsTX0eGzb+oRTMICFWqe
         t/WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773658581; x=1774263381;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/z1SiqPCUjiS0l1gYfp55UVRcWnc3c5gpJsp5+gG+GQ=;
        b=s75f1ZZmjgx2cy7IFxfzKScVcd2ozyeGVYhFK9GVW/5oBPME51/ttJ6rD/sKNTRna3
         PcwS7xmFcD/CbZrECMvzdnrVY4zUHbWyZAax31GWKpW9tvgW2OczDw2ZDWW+BZRWq30P
         XEjPjMon82H6HyAw7hVl0ewkyBr2O4lsq5ya3ViS3dArVXSzNXY5hXIWstdhkWWPaQyb
         3EntFiliKrIzHyxelwgG9yzRAAf0JynVeTbK4sMYKN7Q/z9Ci+RgFiAZI+u5OVaokuYM
         Prf6SpmEIr7PHhudGcAcmge30IRhXb4pS3U4KWTxLixj9O0Z5bWMz7xadVFHW66n9KUF
         51PQ==
X-Forwarded-Encrypted: i=1; AJvYcCVwjFF/q7ju8vEbiuZvW8sZMA15s3yxhC1MrgQ2FeFkBRV9YTAqG+YBedRVrioon9uuZOpz3APvZZ31vg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy96ibHJG8eiaQ0kw4D0O8Qm4kLYbceMPfYqFOF1Fp9QzL+NrO4
	PzAw/JxoawgzLRJMeiY8iD88dbLHVdnZFrJWPw+JxlIQeM+YiWho12dzAdHjXLoCMIKP62eIXiK
	42I3d5deaecIiuWt/9g==
X-Received: from wmbgx10.prod.google.com ([2002:a05:600c:858a:b0:483:a1ee:5eca])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:3515:b0:47e:e57d:404 with SMTP id 5b1f17b1804b1-485567066a8mr208531255e9.16.1773658581102;
 Mon, 16 Mar 2026 03:56:21 -0700 (PDT)
Date: Mon, 16 Mar 2026 10:56:20 +0000
In-Reply-To: <20260216-rnull-v6-19-rc5-send-v1-23-de9a7af4b469@kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260216-rnull-v6-19-rc5-send-v1-0-de9a7af4b469@kernel.org> <20260216-rnull-v6-19-rc5-send-v1-23-de9a7af4b469@kernel.org>
Message-ID: <abfh1J8_4tOFkFaH@google.com>
Subject: Re: [PATCH 23/79] block: rust: change sector type from usize to u64
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

On Mon, Feb 16, 2026 at 12:35:10AM +0100, Andreas Hindborg wrote:
> Change the `sector()` and `sectors()` methods in `Request` to return
> `u64` and `u32` respectively instead of `usize`. This matches the
> underlying kernel types.
> 
> Update rnull driver to handle the new sector types with appropriate
> casting throughout the read, write, and discard operations.
> 
> Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>

This has lots of unchecked casts from u64 to usize, which could overflow
on 32-bit systems. Could use some CAST: comments or similar.

Alice
