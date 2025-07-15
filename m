Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42CC928D836
	for <linux-block@vger.kernel.org>; Tue, 15 Jul 2025 09:42:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752572560; cv=none; b=oVyuuJAzS5UfIwIvjcL1vE5gMst/aM2GoKPKKpf/qSP39QzifHslRbnSgELvY9H27xvjFdPqYE7Grx6yJpgQRHuZ960BvlrTw6lqjW+A9QNP5v9B3cjDohVaOz/kKX7m6MgLNGz0TI80QvedmSZTFD76R/+q494u51ad/ZjM14s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752572560; c=relaxed/simple;
	bh=dlkAnhJaomQ2T0SdHCSA3+Gcau2eH1xErMq2ETxSbNs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=kEjlyTwjYcMNlKVL3eQi0+Uui60V4FCeKzoWObCZWHyzSugaNZhihHs12NP/6xTbGDIOb1ykTTCaclfw9iQwQLO7UvG+2okGPcIQdChoxED+E35MGDEZ9nwsiBp8DmMCvww964qHn6wsWZf7sct19FIdbrO1b8Mj4rSKabHD+iU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rgYWSuiJ; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rgYWSuiJ"
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-4538a2f4212so30182065e9.2
        for <linux-block@vger.kernel.org>; Tue, 15 Jul 2025 02:42:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752572557; x=1753177357; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=2KuGHyRPDvml4ocX1AZOTeZ8x+ILcOo5ktYP0sgC0Tc=;
        b=rgYWSuiJIaPFDfamKUEb1nfkMOcjLitlIH4WC4ejbYAO6qFhxIF+JQaqv69pXlXH11
         S7n/IDAgjkFaS3e3u5irp6YE29aX6/OVplC0S3d+VQkiwc3ycu11/1PjmjnDmtnTzbL2
         teGi7LDLDD+k/I415Sc/WNzupFHwzX/Rs2aqDsKF/B2AgQ0d6A77oidZn2WpTwEJZcBs
         Y4gbNj1OUrPVnLJ7cx/0zFWVRP+6R7jMpAyADKzYrzRHmzEikA1jGp6r+ES4MwV9Xj2p
         WlstSIcTHVbujAe1x/8fAJYGghm30+Zvnn7qZoSdLfjFPgpJK9JuSCSquo/n68GVisIf
         hdWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752572557; x=1753177357;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2KuGHyRPDvml4ocX1AZOTeZ8x+ILcOo5ktYP0sgC0Tc=;
        b=fHL06a3wbvzR/mH60P1v/4PqONvv20iT5elCjxCVM80GGsiO1FpW3EaZjzHB0OzUp4
         FwinJT9t/OROzSyjZ7JMSj18p8oiFOaA2tReQKKnqqbep3EYDjKnCTN858HfxlHfnDhA
         +CQ+nW8pabzkRRrs8BVKiQ02xEu8NoXRT/ft9qjiGwT84zWty9zBJ2SsHsFsFNQxsNt3
         hwD4zGG3uP1zhInNaH/WjifG5+qCXeD3YvYMxC6r04O2nW+vn9GmWqwAQyP7eyaU6ouT
         LTOEZeQsS3c/W3EVTsTfMVfXAz+GQy5u/2vMrsWXS0/d38xcwZimUFCm4/29GbFzd0br
         MeuQ==
X-Forwarded-Encrypted: i=1; AJvYcCXKrAD+zcFACafqHT/uLPqSkxK09kVvnF25lJ7v2/KY9noaHUvyKUMImYPUU0soSuvs/UV4zR5MdbEmzQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YytuZwJkCQbnTQj5JhqqD956dVadL15j5Ll3TjFNkzryAZBSo1U
	EFtFQY74eKsw6ZaDb4v1yZvqU1WbEKdzGsCny5QfcSDyMmHumSIGAeiABFXyrJzduxTT0sx4L5N
	qh8D1rx4PO+vBUjdpcw==
X-Google-Smtp-Source: AGHT+IHvE4UCK7PBe4CViNkIN5aZzxDl2kn27mYrFfsP21JL2dmQdQ6OGNbYYURJGhutkI27jESTUTpKnrenyiU=
X-Received: from wmqe20.prod.google.com ([2002:a05:600c:4e54:b0:456:43c:dcc3])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:4e12:b0:456:21d2:c6f7 with SMTP id 5b1f17b1804b1-45621d2ca13mr44779585e9.23.1752572557800;
 Tue, 15 Jul 2025 02:42:37 -0700 (PDT)
Date: Tue, 15 Jul 2025 09:42:36 +0000
In-Reply-To: <20250711-rnull-up-v6-16-v3-8-3a262b4e2921@kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250711-rnull-up-v6-16-v3-0-3a262b4e2921@kernel.org> <20250711-rnull-up-v6-16-v3-8-3a262b4e2921@kernel.org>
Message-ID: <aHYijICX_xuF-Mb0@google.com>
Subject: Re: [PATCH v3 08/16] rust: block: remove `RawWriter`
From: Alice Ryhl <aliceryhl@google.com>
To: Andreas Hindborg <a.hindborg@kernel.org>
Cc: Boqun Feng <boqun.feng@gmail.com>, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Gary Guo <gary@garyguo.net>, 
	"=?utf-8?B?QmrDtnJu?= Roy Baron" <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, Jens Axboe <axboe@kernel.dk>, 
	linux-block@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="utf-8"

On Fri, Jul 11, 2025 at 01:43:09PM +0200, Andreas Hindborg wrote:
> `RawWriter` is now dead code, so remove it.
> 
> Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>

Could be squashed into previous commit IMO, but no big deal.

Reviewed-by: Alice Ryhl <aliceryhl@google.com>
