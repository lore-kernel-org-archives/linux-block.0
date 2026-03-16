Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D44FC388E66
	for <linux-block@vger.kernel.org>; Mon, 16 Mar 2026 10:01:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773655300; cv=none; b=j1uqibXQyZJEtuay71fkRJyb8pG1773SVYYtyrfO6lEhPMu0299PXjrSUJMmCHzzT8FrX6LLMM5Wo7Ij3NB6M9g9CNEqv+uMnaAlQyvRmPU3dxuNDAuEleKFRmBk877g9nXiMJMJb1fT94In19v21GtSsxrBisZqq15zJ2791gQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773655300; c=relaxed/simple;
	bh=ePcQnVV3wOBbXpa9SoROQTFTPC6BW+i1x+9xp6YI+X0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=dtJvmDVIV/oyqk+DRo5yaDg7V7T7Xy6rXIiB3GJnm10mptpsiuWHoZNgPoqP8bsZkt7L+QksDt3HhUqr2gPy7uiuRhKmwiwW79EzPoNL6v0kdYxCXQVLSyOyGyGeBN+7Rsf9uWYm5/qSkCmDvXnaVEug3INyD9iF2cAiCe2S3n8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vUjJrgOV; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vUjJrgOV"
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-48539bda3dcso48938675e9.2
        for <linux-block@vger.kernel.org>; Mon, 16 Mar 2026 03:01:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1773655297; x=1774260097; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=WlcqbF6Fi0ANmT9UrxWcGsAHJorJqkrv5GS5junUEeE=;
        b=vUjJrgOVQfBjhxjhperVZ69+HtKfs1MIEeF+a0HqrRJ3HoUq1mXjIR3xrb5s27ykVm
         +VXc9jwEgFMeotYHEzDds9UT1/YMEou67EYVyaPcCxj7wy4khqccW0K1845LhRsbn5bo
         srLPpJ4PUCVR/adtpC3iCC+HKWBi4ilLyAPsX4GM642papwDy7K+RcqCKaVDupz1quuE
         Pn1uKpcCufbze3zhOm/q6IBgf2YJReQjMDUIcg6MfXymxEBMNnJxBDtyq34zRwbOIwWj
         UkmB2R/0wmqqP/4WC+fV76bBO5vFBZisIr1j1tThvbXdL6ik1gWyY4yRvbz9FjcVPRYV
         GGFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773655297; x=1774260097;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WlcqbF6Fi0ANmT9UrxWcGsAHJorJqkrv5GS5junUEeE=;
        b=T01XoVON2X2ukgnqPDm62XYCygnAicjogx8/y4JABBy0XnCqiAtl0VV/+eM+a9Dka+
         4mkb7sfpvLJ8oODKu5hYx27GaJMQNurPlfyOqe+cwrlw1QDfq81288d+oBJSkbkAWxVm
         c00ZPICU6GnUQLgvJ64VMvRe5D+GPlyDy3lxYLZEj0KS28vINsGhP9unEcbCTkvumDLQ
         xi69UOYTeWGUKoTRd7F1M4PaD8LoQHqrIRPvRaG3XgYWlqHrQa98MklEOEteF7zhmHTe
         ExvhHCzb98CjYAjqWbdAmWgdbQ53c7Z7WkQxgOVC8Ln+5zHrFJ9MRyB/qhau6B+mENYp
         sEsA==
X-Forwarded-Encrypted: i=1; AJvYcCXXV1WV5KsiLHjZaMG7TupQU7/VG6wGnKs1MUmsGvq/vdoNcZqgTwljUl9Nyhy+WQA3KH9vnlmxtXJHIg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwPRZArzN4xDM1rO7kWvaBzMj+TKKz1RjMjKO2bkgZZJdTsrsp/
	DLGcoLXZj/i1cnh0qIxTK6p3aE7AlbbQHzJClFAUdtelswZyvQw08PSO2PZWjKwE92PJ8AlrZq8
	XzdUxEBO3RohZOwYN1A==
X-Received: from wmim11.prod.google.com ([2002:a7b:cb8b:0:b0:483:5126:2240])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:a39a:b0:485:3b00:f93b with SMTP id 5b1f17b1804b1-48556728b5emr152715195e9.31.1773655296989;
 Mon, 16 Mar 2026 03:01:36 -0700 (PDT)
Date: Mon, 16 Mar 2026 10:01:34 +0000
In-Reply-To: <20260216-rnull-v6-19-rc5-send-v1-5-de9a7af4b469@kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260216-rnull-v6-19-rc5-send-v1-0-de9a7af4b469@kernel.org> <20260216-rnull-v6-19-rc5-send-v1-5-de9a7af4b469@kernel.org>
Message-ID: <abfU_itQLa4jDy5L@google.com>
Subject: Re: [PATCH 05/79] block: rust: change `queue_rq` request type to `Owned`
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

On Mon, Feb 16, 2026 at 12:34:52AM +0100, Andreas Hindborg wrote:
> Simplify the reference counting scheme for `Request` from 4 states to 3
> states. This is achieved by coalescing the zero state between block layer
> owned and uniquely owned by driver.
> 
> Implement `Ownable` for `Request` and deliver `Request` to drivers as
> `Owned<Request>`. In this process:
> 
>  - Move uniqueness assertions out of `rnull` as these are now guaranteed by
>    the `Owned` type.
>  - Move `start_unchecked`, `try_set_end` and `end_ok` from `Request` to
>    `Owned<Request>`, relying on type invariant for uniqueness.
> 
> Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>

It would be a lot cleaner if we could implement HrTimerPointer for
Owned<Request> and entirely get rid of the refcount in request so we
don't need ARef<Request> at all.

Is there a reason we *need* ARef here?

Alice
