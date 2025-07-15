Received: from mail-wr1-f74.google.com (mail-wr1-f74.google.com [209.85.221.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC4EE25E813
	for <linux-block@vger.kernel.org>; Tue, 15 Jul 2025 09:52:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752573181; cv=none; b=IfJ9Amc6dEIpP1qaYz/OZ7Sv4N25Cs2HFzaNiQE80AsAPjjL4uVut3YrPEBWyTlORmMNaAbyPnyJNEbDJSTd4X6RDieeuIyTWtNFcSlBTH7po93w91uWZ+uJuDywt1h3aCF5LKlAbKoNDoAmaepM8pjTOpuMc4QYLnXlWpQro4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752573181; c=relaxed/simple;
	bh=Eu09dYbizFV5acWWRZPs1ODpYDFIFp/NiPu/UthNcbQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=iacRIHnw93nIkBw7QQZ1CNsoswSVGj5krqdtVTPj+MbQ+bP760MGu8Q5ml7Le8+cwrMB5dUsIkEg/ZzZUVFkBmDrqA9AJqNTqGAAxUkKwO0nplZsBqSeoc6dxDF+dk5pKLcFYJKOBkiMkLDqySdQl/CYgr2EQdE+o53TDYP4vnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Qb5qdK5I; arc=none smtp.client-ip=209.85.221.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Qb5qdK5I"
Received: by mail-wr1-f74.google.com with SMTP id ffacd0b85a97d-3a4eee2398bso2572415f8f.1
        for <linux-block@vger.kernel.org>; Tue, 15 Jul 2025 02:52:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752573178; x=1753177978; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=mRCCvDl2EeLJ6W8Qd9isZ4A2S6Wz/e2h3t5fx1/JbTY=;
        b=Qb5qdK5IRz3ntCWNtc6ZjYm5m8vC2PGue8Os9XPzuZjPzC3LXeimvS/FFEPAsGgMmj
         WYQBUaFpIw+U0DVK4oQ9OZ6ZoC5uDMkafDojnmQIkWE3g1hLg54zOLuaDhVd4fjUIPD6
         oMDVLScQ/t51CQ9lE+x//02VDMs8ONtujurAUW9cf2FmJySFEUiZM2EVsKYA8GbdEyFf
         25/NVffQasRZWV6fiQUqZ5dSHrwoqzA8S50e0h6GITrCT9WKJ/8Od964bslJ3TzC6ftz
         JDqenFTfBTTgRd49LPmB1bsIujcNkI0GHca77ji0/Yt+/4sy7UGZ2FrVBz+AYashECIE
         QjXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752573178; x=1753177978;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mRCCvDl2EeLJ6W8Qd9isZ4A2S6Wz/e2h3t5fx1/JbTY=;
        b=uErkEp2WiV/77rLfhk8QjGqT+w28ZEPuKGutxzCTEbUSolJYOsd8YpsAVlZi5dHCsu
         XZ+81CZiKBnOSYdQZ98c1Sv2kLQKlsyms54dxjtAvn1D1mw5jPLdoVI92Knq0eceeJJt
         r+WqEQGF2jwKkL99+c/xnCug10jF1DdMin7otmYJefTzHvbyPq1KBfbLrYdJup4YF8zj
         P5V+blgiLn4EQtenN7uGFORk31UrKv2SAdk0ndKJm8G237xX9BxZ9Oo6BovHUNnSCx2p
         +R6TzdAKNSnUb2OW9LhxiZXs5GSg16gPDogbTW+JHCoOI8/VN8mmky5Yvv56djR47QWL
         eIww==
X-Forwarded-Encrypted: i=1; AJvYcCV1P+ssPyPQI+SGYbXLcxBEixBMEz8fxfUQJYZ9k9EvlnMLZ95vR4z5wK+S5hKnVsXW21NPlSKA5DNmSQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YyEjHkTLjPb+aJO60JedVFFsRxa9esdg1xRBRCNc1Npw7aGc4Rd
	NAQBbdP6GTIPRD9iviCC0/oJzT/t0iXDdY8l/Rt4zsSeiZzGuEZwqVnXGQYEVFQOLxe0BPQn7tB
	oSJcOoWOUzOLJ3dZUaQ==
X-Google-Smtp-Source: AGHT+IF3EotU00orGgUq5/wPVXDbTRCtotoKNHfSWjvULDWdzffUM8q1DiySCXXfqz39cc6WjFVeYT5gQA6uafw=
X-Received: from wruo9.prod.google.com ([2002:a5d:6709:0:b0:3a5:648f:da85])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a5d:5c0f:0:b0:3a6:f2c1:5191 with SMTP id ffacd0b85a97d-3b5f351ecc4mr11584212f8f.4.1752573178118;
 Tue, 15 Jul 2025 02:52:58 -0700 (PDT)
Date: Tue, 15 Jul 2025 09:52:57 +0000
In-Reply-To: <20250711-rnull-up-v6-16-v3-15-3a262b4e2921@kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250711-rnull-up-v6-16-v3-0-3a262b4e2921@kernel.org> <20250711-rnull-up-v6-16-v3-15-3a262b4e2921@kernel.org>
Message-ID: <aHYk-Y5GrJ2WeCJD@google.com>
Subject: Re: [PATCH v3 15/16] rust: block: add remote completion to `Request`
From: Alice Ryhl <aliceryhl@google.com>
To: Andreas Hindborg <a.hindborg@kernel.org>
Cc: Boqun Feng <boqun.feng@gmail.com>, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Gary Guo <gary@garyguo.net>, 
	"=?utf-8?B?QmrDtnJu?= Roy Baron" <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, Jens Axboe <axboe@kernel.dk>, 
	linux-block@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="utf-8"

On Fri, Jul 11, 2025 at 01:43:16PM +0200, Andreas Hindborg wrote:
> Allow users of rust block device driver API to schedule completion of
> requests via `blk_mq_complete_request_remote`.
> 
> Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>

Reviewed-by: Alice Ryhl <aliceryhl@google.com>
