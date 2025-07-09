Received: from mail-wr1-f74.google.com (mail-wr1-f74.google.com [209.85.221.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EBB82DD61E
	for <linux-block@vger.kernel.org>; Wed,  9 Jul 2025 13:26:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752067585; cv=none; b=KfdDhHCn/NPtE90iG1ICxnSm6si9gq6hgbhqfXSiQBWnYKXIseIl6ulGwW4+i1u3nTfAKEDqGMytH/RlhueRUQpJhF5pMViYxAYFV2WQzGMFtPan5OAaEN2a8tu0288AnUMJN8vvu0/ISn+rRMmCg05/bdgzmXS0UFY09rx2S4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752067585; c=relaxed/simple;
	bh=EpIPSnFL3zxtw4E9KyJjVoSQ5FEr+FAlGgdFcHUVawA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=j3oDwn0EEKR/xob0xfBFmWeKTqiTHAhVc8dq8p23XNcZq1E3q3dm7V3eKhs/tgkmqv+9cb6RRVt1ELz3WhXHeuI3hnI5hy/InSogbh5olhF99Sxm6cbq/PVit4NZuPU7jCcCZ7y3FzhSJELNUxwDfY0ryYlUie5LSNOjNtqmpus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hdfwN97u; arc=none smtp.client-ip=209.85.221.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hdfwN97u"
Received: by mail-wr1-f74.google.com with SMTP id ffacd0b85a97d-3a4fac7fa27so2215820f8f.0
        for <linux-block@vger.kernel.org>; Wed, 09 Jul 2025 06:26:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752067580; x=1752672380; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=/2XZ5Qh0Y8/xBI8hFk5wtj+oH/ehg5gQNl0hSLZ7V4U=;
        b=hdfwN97ueykNPqM9h7gIbIpwras/T9IxChYMMHvdZLmjnZU0Fj/Cz61jMSuuzwxPfU
         PhzeQpzO+B+jVYmC/l+KksYF0PEhbTVBK8S0gCoz7Mi6eT/njDRjYB2oiM5n+1+o4NQu
         QupOVJrgqdlm7k7RBxjh54/wzOcG6zpe+3VhH0c1iJxBCHzyZhWyROUPO7Cs/tAz15vO
         44LziQSzP+gVT+Gtm5GVKJcJ1aTaLieYAulRzg/LNGyQ6vFuPthUGdwqeULWDijSNmBf
         DW8UvLd0LBXD8znDbHnNDPZXkDYMjFDJRFq74FGCeFXDYMbi32CSTx5J1XFShtXkaU8G
         VA6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752067580; x=1752672380;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/2XZ5Qh0Y8/xBI8hFk5wtj+oH/ehg5gQNl0hSLZ7V4U=;
        b=VIpvLxMr5A4TJuTkffmfGxBdIDYAO8focVIH6lJCLSBlGg6FY5u1zChJXFfniWmJjY
         35EnJgMQTDmuiXTo/5N6AISgTFiJEPi7vcAyd8SuJP6g+j2/3MpHemA+BRIyr1ZLWKc2
         6LEQ+gx4II+RwlDVKdzM+LcX5YMp+DON6Jq7ZBGpRKlWV4ZkyU+nRGaFI19SnVNQMYfy
         JZmAn0n/sVJhEo7KHhxwR33JpCbV6fqhFQ1mY+W+W7hiWwi5asggSfG5tbVCOVAzrvgZ
         hONV1ScF+Pxm6JayJkMp5+yGzCshjGyciEkNQ+7aFNYkyBxfFYXYEZgeqBkSwpjuKz3d
         lxQw==
X-Forwarded-Encrypted: i=1; AJvYcCWukRcJP9xCz/0cXGw8MOeK0vLGPi5gpKhrWkSL0GZr/ukurbECsW7hK6u0Y3AOjhIpHDGJZhKnzz8K8w==@vger.kernel.org
X-Gm-Message-State: AOJu0YwIZ11mo4klSo0WE8wI6gQhRzhata3ru9QZuDUkq71TErT8biKq
	Sgoq1kxzgU8/GTK8vTw7u28okxNewY2CHxfCMj/w0oCMFn5I3/9PJYbRDz4/1N9+5KSdIYtp6H2
	b4uFdaXM9VuUTNU1pYg==
X-Google-Smtp-Source: AGHT+IF+xK3vC0GxnM5YgdFqU78a1/83sM+KndWW9pR/GYUNx+a3eu0I/KM87az6bLdBJy/RPRIBoTlPLaO8DO4=
X-Received: from wmpz13.prod.google.com ([2002:a05:600c:a0d:b0:43c:f8ae:4d6c])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6000:4287:b0:3a4:f66a:9d31 with SMTP id ffacd0b85a97d-3b5e4514e3fmr2393240f8f.16.1752067580535;
 Wed, 09 Jul 2025 06:26:20 -0700 (PDT)
Date: Wed, 9 Jul 2025 13:26:19 +0000
In-Reply-To: <20250708-rnull-up-v6-16-v2-4-ab93c0ff429b@kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250708-rnull-up-v6-16-v2-0-ab93c0ff429b@kernel.org> <20250708-rnull-up-v6-16-v2-4-ab93c0ff429b@kernel.org>
Message-ID: <aG5t-1nadCfvD9uF@google.com>
Subject: Re: [PATCH v2 04/14] rust: block: normalize imports for `gen_disk.rs`
From: Alice Ryhl <aliceryhl@google.com>
To: Andreas Hindborg <a.hindborg@kernel.org>
Cc: Boqun Feng <boqun.feng@gmail.com>, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Gary Guo <gary@garyguo.net>, 
	"=?utf-8?B?QmrDtnJu?= Roy Baron" <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, Jens Axboe <axboe@kernel.dk>, 
	linux-block@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="utf-8"

On Tue, Jul 08, 2025 at 09:44:59PM +0200, Andreas Hindborg wrote:
> Clean up the import statements in `gen_disk.rs` to make the code easier to
> maintain.
> 
> Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>

Reviewed-by: Alice Ryhl <aliceryhl@google.com>
