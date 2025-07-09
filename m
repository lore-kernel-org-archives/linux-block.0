Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B2D828D8EF
	for <linux-block@vger.kernel.org>; Wed,  9 Jul 2025 13:14:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752066897; cv=none; b=NUJ2m4fGb3S4wCeILNP3kzYD2zchL+e89+MZq3Y6MgV2h28ImS6L8+keKOb41kI0eU3xZbqCr+6Ik0drdZFcnYihGaiiyNO7HzLPpUJDcpnIE9ZxuUQVHOH0t6LBxeF6VpWG8p7uLG4FxzfyzHw3egEunAGyXbXBxSFVvYCgRWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752066897; c=relaxed/simple;
	bh=W+dKv/OILAWDNbhcTCFP1hGgC+67NpjoeUsnxn5ZeGU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=fTahD4zOY6is/UeRnV+1jO6gJDiHQF0MjKbCFm1WaEPVHheF5SdUJFBG3ZEi11rdSMJAOcY/IUKCsO8l1sA6GWxueeA8pYDhF81cTmm/sGCRGGmst+w5I5BXhZIAOTMybaE6aSUnhfgW6ff+vA1zw9/Yppo7i32TR0rSWCc6HIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bqBlbIOI; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bqBlbIOI"
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-45311704d22so32520925e9.2
        for <linux-block@vger.kernel.org>; Wed, 09 Jul 2025 06:14:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752066893; x=1752671693; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=N6bM68ZXZdOjcEM+X0vttOiWXtJPLJGmyTWfeRHvOMs=;
        b=bqBlbIOIhfE9Zy++tztmCWZPimabQA7hxenoKoKrjSVRDENrkRjOr8hjvRn/ncR92s
         mnteGgQokm87wtTfMQ3wWbPES/ehWK9CRkH2SD8eKHp32tda9VKPb6fREOVpPJb1kUVr
         xXQ9mOnkscuiNHIdpJeM7mZSALYMKBxbXhj7p4RK6nTuDMFt8PWf4HVW7gbAJCYkt+lL
         Wdpllqo4hbsbnX4ufvcptUhCj1ssP9L+4hTBzkSfPbxvUOQbJFFG6h96qWBkIHV1W4u8
         cKuWiy1yRbuj1bbPe4PPRXg4amD1PFnSWTMFSRuqMSHcN9qUS46rkB5JgjZauRt0Qgie
         8G8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752066893; x=1752671693;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=N6bM68ZXZdOjcEM+X0vttOiWXtJPLJGmyTWfeRHvOMs=;
        b=e/L4tj7fGo0yWrf/sI+d/M1ryRIwwJUxs3nyvzcG8JdJgENWQ9/z0bU17jC+Vxah8u
         VNlO1bhPtLaQrC0lZxkmtxi61FmpOnPHigpa+9SRk6myqSzcVfWsRDdmWJn6oCXMka0f
         S0XTpAiyYsDbBDHNBb5gWN9hcirosZ7Hsm1GKOUi0z1d3kNKfTGxmQmStTQL986QqRfn
         XtsMRYn+0ZatJGnP2n7PvnLjWLtTC3vn5xd8sqNapgFA9yAPH60FqIUTKGn4g7w/lCkp
         KsvQCx2/YTps9YD7CWQ2Qasv/baT/bRJBDOTFayLRtfkAkUbY0lJ6eZV+EtixmqmdvRg
         6t1w==
X-Forwarded-Encrypted: i=1; AJvYcCXMthxwQJMJGMgehKt0CpSE2Wbg+olsV+QjLao/G+VIQIA/enC4RoXK9D0r+fvA8s6C+08E7D1hSKoq3w==@vger.kernel.org
X-Gm-Message-State: AOJu0YwlJIzjDxAu8hA7J1p0Lx59DKjYtRqBKNxJQYWc8rfUvsjTs3+3
	bZgCZ0D5RJegC6A/PUW5NzCJdkpk4bO907W5BBt2KMIhyTk5atvTLgR7yrgho3opu6ObVrLaiec
	LlDLSR285DGPdZ4xIBg==
X-Google-Smtp-Source: AGHT+IHnmAAJG3RJlC4ROAU21sZqv+pruz2DzGzFq+8FpI0+2cgAxpyO20tNdvivqrXSxhzp0D2DJS6T08OvLvw=
X-Received: from wmbhc16.prod.google.com ([2002:a05:600c:8710:b0:43d:9035:df36])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:c083:b0:454:d975:6aa7 with SMTP id 5b1f17b1804b1-454d9756eb0mr6844005e9.28.1752066893751;
 Wed, 09 Jul 2025 06:14:53 -0700 (PDT)
Date: Wed, 9 Jul 2025 13:14:52 +0000
In-Reply-To: <20250708-rnull-up-v6-16-v2-2-ab93c0ff429b@kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250708-rnull-up-v6-16-v2-0-ab93c0ff429b@kernel.org> <20250708-rnull-up-v6-16-v2-2-ab93c0ff429b@kernel.org>
Message-ID: <aG5rTNGn_NbnCISe@google.com>
Subject: Re: [PATCH v2 02/14] rust: str: introduce `BorrowFormatter`
From: Alice Ryhl <aliceryhl@google.com>
To: Andreas Hindborg <a.hindborg@kernel.org>
Cc: Boqun Feng <boqun.feng@gmail.com>, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Gary Guo <gary@garyguo.net>, 
	"=?utf-8?B?QmrDtnJu?= Roy Baron" <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, Jens Axboe <axboe@kernel.dk>, 
	linux-block@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="utf-8"

On Tue, Jul 08, 2025 at 09:44:57PM +0200, Andreas Hindborg wrote:
> Add `BorrowFormatter`, a formatter that writes to an array or slice buffer.
> This formatter is backed by the existing `Formatter`.
> 
> Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>

I don't think we need a separate BorrowFormatter. We can instead add a
lifetime to Formatter and give it a safe constructor from a mutable
slice.

Alice
