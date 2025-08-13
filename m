Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EE4F2E9EB3
	for <linux-block@vger.kernel.org>; Wed, 13 Aug 2025 07:21:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755069685; cv=none; b=mHWEV0m+RUtEY55H3j23puqJ+XuyllTjRKWbE+rOSqkodIUXQ61aOmUZJKqXbGYQvUnJ22Uf8S9CnXrm06PQHzvweAWxs7bZIqIFspUzT6/YU8Gx0+AY1uOSoKup5m/YFYEXIqldhbbSnP01t2JpFGgCWoSWAJOx31Yk0kLl75Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755069685; c=relaxed/simple;
	bh=yYtc86jTqQuPqXSQG7t/PuhwvRbJ/TjC3YM7JlrgQis=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=iCkBTPyA7e5W+3qBpL4jRNpnES/XFFRx4ROuvQKbqkEhbI0SlFtyRwqnibI/vh3ZiaiBakb7/7wtT5LBBF9CRtBbFyXim4D32NYJ2yqrf1yOHzQbmCedKUdam6xCarZnpwdJ5dVRHMyBhw3wJulzvwVCFohDrJ0+4zcHkHDlnx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=AnKapQiv; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AnKapQiv"
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-451ecc3be97so31869175e9.0
        for <linux-block@vger.kernel.org>; Wed, 13 Aug 2025 00:21:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755069683; x=1755674483; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=6auZLdmjrU9XvvBQvF7iO6sbfbUfX9sDWwrhFdoryBw=;
        b=AnKapQivXVs34H1YWSRid2s/9ImyCzBp5v+YrliZiWR3hBrH7kTGtareYVsbInDeNV
         MBRjSxSYbfQ31vtC86mgOv2jSNcQ+C4oNSV7ZL/m/8RlYHu7XssmBKbMvzf8q7h4J462
         uoLfm4/w8jIN2mmqgAYxwdzycDB2Vik72QDOcrcKJ7UpMfja3kD2HI+O6MBCh7FNekhT
         2g2WX6sdDWKguqnNXF9uEp792g88yRNZdJfFSZYanLqyDoVu/DHBDjGLGdUrqUjczrxG
         HWI/vbZahyvNrjy2tAEF9NH2V4bwdm19TCs2xLK2mzw0FIhwbd5ra6LlSbYbXUigmxSE
         JcSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755069683; x=1755674483;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6auZLdmjrU9XvvBQvF7iO6sbfbUfX9sDWwrhFdoryBw=;
        b=mI3SkcYLyb2GblNIr7zD3K06dx7RPMAdKgJ4ZOInFLSNu6Wb4TGk21tWjK/vIS81Pw
         iEd7BWqdfCIWac2RetRlvTi0aU39D1BNLVO1JxWlGk9HdDOLiD/GSZApabqRbeoFySgy
         OALoHEJyO/PQE48P96+dx9jZqIeW1h334HIHl/JEdeO+XACTOtGbHJXMlQhWiB6O5AXT
         wlPSLx1qYxBvPbQs5UzmnWpZ3TSADbd001pE5wOQmonLfy2Dedfz+4boS4TKQderqAo+
         CQdsNvHRgrK+Ft2/1gnBYBPyv85uRjgp2NtiTZMNV3lsmtieItrl4qbQNI+Ed8IS7GjS
         YsBg==
X-Forwarded-Encrypted: i=1; AJvYcCV7LQCUvoDA70mV0aaVR2e6ITS8OOMvHwTvY1to4scGR0OhaduwcDNHR3vI6A1FfkqTFqbTf3dF595jWg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7LEv7uH9FAVpr7evIIIQBf6QbrH0HJqXQEbXNP5dih2sTc6w0
	WqTpWPbXi4A0OBwGGzKb8r9R0LU9g1A+c7XxumOnP71Vmm0GA4FRxhWlvr5l/SlRRY1xQMZ9n7U
	bYB3q6/AsxZDcJiVjQQ==
X-Google-Smtp-Source: AGHT+IF0Y//cw0eQBZRIh69r+ikstzcZPTKfdKKV7ybr3e7Hu/OWn7hC8UwPmHe3snLhsQgpFa+DXwZzHEcEXCo=
X-Received: from wmbes27.prod.google.com ([2002:a05:600c:811b:b0:459:d67d:cbd1])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:548a:b0:456:1824:4808 with SMTP id 5b1f17b1804b1-45a16602c99mr13135805e9.32.1755069682800;
 Wed, 13 Aug 2025 00:21:22 -0700 (PDT)
Date: Wed, 13 Aug 2025 07:21:20 +0000
In-Reply-To: <20250812-rnull-up-v6-16-v4-4-ed801dd3ba5c@kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250812-rnull-up-v6-16-v4-0-ed801dd3ba5c@kernel.org> <20250812-rnull-up-v6-16-v4-4-ed801dd3ba5c@kernel.org>
Message-ID: <aJw88P7K_6GFmWvW@google.com>
Subject: Re: [PATCH v4 04/15] rust: str: introduce `NullTerminatedFormatter`
From: Alice Ryhl <aliceryhl@google.com>
To: Andreas Hindborg <a.hindborg@kernel.org>
Cc: Boqun Feng <boqun.feng@gmail.com>, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Gary Guo <gary@garyguo.net>, 
	"=?utf-8?B?QmrDtnJu?= Roy Baron" <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, Jens Axboe <axboe@kernel.dk>, 
	linux-block@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="utf-8"

On Tue, Aug 12, 2025 at 10:44:22AM +0200, Andreas Hindborg wrote:
> Add `NullTerminatedFormatter`, a formatter that writes a null terminated
> string to an array or slice buffer. Because this type needs to manage the
> trailing null marker, the existing formatters cannot be used to implement
> this type.
> 
> Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>

Reviewed-by: Alice Ryhl <aliceryhl@google.com>

> +    #[expect(dead_code)]
> +    pub(crate) fn from_array<const N: usize>(

Don't you delete this function in the next patch?

Alice
