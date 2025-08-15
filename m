Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16982347DD
	for <linux-block@vger.kernel.org>; Fri, 15 Aug 2025 08:17:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755245850; cv=none; b=D/Ip6QTghbaUs8loPouF6VXcBVa/PmOFXF9TbZgKU4Q7W0pChXsMZgwlcwfSypeEZbSZTnGAnC11dQmKt1v0ao18/Dwmyzs67Sr6NWW0i32MuTLKJYYpME3N4NT7Gz9Et3n8ExnIpHn9cZlAAadWZPKl83HF4/nPF3fy/mIPALY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755245850; c=relaxed/simple;
	bh=cOa7ZuyMM82PjkOXOzWct+P+y+EyW08Q69FZEGbX7io=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=HkVbDWlFNC62JiAhxFf+5YAJIF5MBqeDw1jMpXOqS3dyEBUTE5LabNIF9gIJEUMILzraeF6+KVO+wYEn0YgT6FcIi7wOmZWRga+5WKdkVyFW+O/b3J0qbqBcMFD58NcHvbaDx8T/iRt4L/MLtf5Gn9EdCwe1y8u3e/GqTUtqucY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=1qQs8Adv; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="1qQs8Adv"
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-45a1b05d31cso6366645e9.1
        for <linux-block@vger.kernel.org>; Fri, 15 Aug 2025 01:17:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755245847; x=1755850647; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=u7bS7eW1yyQNa2vjGE9jPA8jEP8yN9eArEpHZlY5uGY=;
        b=1qQs8AdvjSzc6vK3k8Ms4fJR6K3N+u1XWhCF/XH6RxXqP+4kn1fmIzlghpgYfibyan
         5AmfrBlJtSgc+d66BtE+M3ELB9riZn+7zlV/RCImmP6xkiw13PBYa2YnfZFsHzX0JeRg
         8fKUqKkxdFk1Of/DVMDg70KYlSpqtUZb8TVx+ph40B3p4xSnwC0W5H6TiFwj7bLR+y10
         mf5pGQ16kmlCzsbi02/0Do/pPIn+h1vnVk1DeFXj9L8KgkrvYQlqlqSnvLlmQQgmOt3v
         CuE5yHyQjMifpx9OUpWtiJvARSyOA/cRsys1Jnhc4oJV//6ohB+GT2RnpG670WQp3AYC
         Wf/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755245847; x=1755850647;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=u7bS7eW1yyQNa2vjGE9jPA8jEP8yN9eArEpHZlY5uGY=;
        b=RzqfaPMIkBb2oqVVRMaVdbwuwx3X16qDGs1JVzeM5pBUkGUlcx6FSnC/T1JQyrdI7D
         4jIOgx4FYOjVEm829JJlTTXU2/aL6QRI9PqE6Dvzr7UztB9W8cVJyE+YPSbqguUkeT1q
         EQ7PMClB48j2JqT/k4g1UbnXOMsuoIRGQ/qPqdVU25RhDJ+ogDtTJ4ealWiodJwnThh9
         fX4kI+r4TcIp8FpQSLfueJSyuhW3XPoor4AXUCinl2CkJ/SZOflW6zOXAPTPd0i/4YB6
         FcX5K72NW0iaoFn7Pc+z0agNFm0lxhRK68Ap7ol0pSeW6WiSKBmfge0G1GISDgoJm6uy
         TvNQ==
X-Forwarded-Encrypted: i=1; AJvYcCX3Cssa7IdYFY6wvkf0G1w4P7gJ2F3g8SWQAzjtyBr/Sfk45lCWcIO3GD5Qhk4V9oFQMc4lBLVCluDVaQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzrBMtjXj0gIPshcsJGIBXAJxeaVpGhoYQpgyzOUpnffPS4CUfR
	edT2vWKoURaAN+DnXvul9Y5Ohms109yqRR3Mmv+yJZ2jaci3w3xF1fnajiGbHSJ8Q8GEEJjIm/+
	z06IHLIdskzhXQFo9ow==
X-Google-Smtp-Source: AGHT+IE/XcsHqhKTw9p5m5wNvEeLl/SDxmW8eaN5RJoJy1+RidvD8zgIZUVdDHrA8R2xfPTnhYekH16BlPrZfCE=
X-Received: from wmbdv24.prod.google.com ([2002:a05:600c:6218:b0:459:d8e5:aead])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:474f:b0:456:285b:db24 with SMTP id 5b1f17b1804b1-45a21854c6fmr8684195e9.28.1755245847539;
 Fri, 15 Aug 2025 01:17:27 -0700 (PDT)
Date: Fri, 15 Aug 2025 08:17:26 +0000
In-Reply-To: <20250815-rnull-up-v6-16-v5-14-581453124c15@kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250815-rnull-up-v6-16-v5-0-581453124c15@kernel.org> <20250815-rnull-up-v6-16-v5-14-581453124c15@kernel.org>
Message-ID: <aJ7tFulqpuF481Wg@google.com>
Subject: Re: [PATCH v5 14/18] rnull: enable configuration via `configfs`
From: Alice Ryhl <aliceryhl@google.com>
To: Andreas Hindborg <a.hindborg@kernel.org>
Cc: Boqun Feng <boqun.feng@gmail.com>, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Gary Guo <gary@garyguo.net>, 
	"=?utf-8?B?QmrDtnJu?= Roy Baron" <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, Jens Axboe <axboe@kernel.dk>, 
	Breno Leitao <leitao@debian.org>, linux-block@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="utf-8"

On Fri, Aug 15, 2025 at 09:30:49AM +0200, Andreas Hindborg wrote:
> Allow rust null block devices to be configured and instantiated via
> `configfs`.
> 
> Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>

Reviewed-by: Alice Ryhl <aliceryhl@google.com>

> +impl NullBlkDevice {
> +    fn new(
> +        name: &CStr,
> +        block_size: u32,
> +        rotational: bool,
> +        capacity_mib: u64,
> +    ) -> Result<GenDisk<Self>> {
> +        let tagset = Arc::pin_init(TagSet::new(1, 256, 1), flags::GFP_KERNEL)?;

GFP_KERNEL is in the prelude.

Alice
