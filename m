Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8F1539F188
	for <linux-block@vger.kernel.org>; Mon, 16 Mar 2026 14:05:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773669946; cv=none; b=IKdJR22xDEh9JzAtcYCDUGet8rGqj5drirZYHWMUcRqCp+uBwr7+yI1v7PsjpgM4iD9rRp/WcjqDYEQ2J9pbRxOckS6TM7VlT0iwC9rCebPNA+563ZfLtMTPp7RafQ2HdZAvPhQ9muFXpJ36TDUDWqEGKFEAxa6LE/4TFSMmEQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773669946; c=relaxed/simple;
	bh=S+D8dSLW8oWKsKSTJ1PKigEnOCf3XPfVYvzqfqISQaU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=MyeMB0jOgnH1D1dixwXP1fxmu0rctQw3TYQru53iyvbIkiLpDk8ZP5wfAFV5rf8/kPBxq61werqhv2h5bkjr/OZCX1YogUt6zR8mYq3EHCnE8jp21kn+E8GIsgooBlb6ObvJq7F84jYv9b9705j/BHJLWuFL2i+yT6ou4S+sNtY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ZvqBxHQu; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZvqBxHQu"
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-48535f4d5e1so45380745e9.0
        for <linux-block@vger.kernel.org>; Mon, 16 Mar 2026 07:05:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1773669943; x=1774274743; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=KPjHmgruixhmkQjw04sh9Mjy1u+NZy/GWXT+thsthOE=;
        b=ZvqBxHQukFU93I/gPsZYLd5MR0bzK6ax2krIrR+3t6HKAfIRmI/LwMbnG/7K8ZuXOD
         ZM86TCM46gxdbhKAvXAZbbjD0ZWHdsYJ1fYUF9dwxDS722GffSZC+ztJz/RY1TnL77b6
         hXAPCTJvl/zInACwYmqiF5+dIf+uyiOEw+ZOFTSZCM8o4JvULCTxb6TpCTgacvF+pNT/
         AnbFdzSNn8QeDSG39YkvGBK5E5bFmSFxvagEEGrkDP3zIzVFjmmQ08fmtBnZPFpx1F2G
         MkUoMbGTNxy3fs5n5I9lD2NtiPfGMhNmFBY6CCQVKXSWuaCb1WClGmxojHeYlEVd/KUl
         OSqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773669943; x=1774274743;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KPjHmgruixhmkQjw04sh9Mjy1u+NZy/GWXT+thsthOE=;
        b=GZ/rgFEuArdUjEjBh3kfumj55lpGWocbwl6+meXpqGFFEswqcu2Bvh3eT8W9MElbeW
         84+tjcd5F+RzlMnDbA1F1HvdsqTIcZNnVTl0JuRFubamSddyKjwEBThBfCQNsn25tVPB
         LqY+9jftrDAZu85A62NguF4XWUxtkOM+jSn0u0p0QfBtieavhirbc1shSyrUeCXw1fXn
         FUBqJDKGmsO8PxwV1svsXgAeSatON4gWvBJ1BeC/LEwt2uVYF/NwsiM2VyAnOgu2+6Xm
         E5hLt4m7AKKvOJfETCT59B9zEzwb3+VrIcRHwKh6bu4iyGZR5SrAVrHRa04DlGtqjgw+
         pUgw==
X-Forwarded-Encrypted: i=1; AJvYcCWQHm7iY42UNoC2zTKm7cA8OXNM4A//CYe7wAmbn4ztLg378QVN2AwpXLMXXK4sDI/SnENrH+aZ4U4mJA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzqzKfXu9c1Mnq8weVHdyPKc8pU2WShw0+QV4GZ7WYzW+lgls8o
	Yb13eb81jd0nRQi/wjl6xbzDxO58pl5Q+gUndCHshrls6mPVGf9Fwc/5M6903u+NBr26N4l9je+
	eZJOqLU8Gd6JAZYNiSw==
X-Received: from wmqy12.prod.google.com ([2002:a05:600c:364c:b0:485:408f:802f])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:64ce:b0:485:3b34:2f62 with SMTP id 5b1f17b1804b1-485566d0c13mr212567075e9.14.1773669940884;
 Mon, 16 Mar 2026 07:05:40 -0700 (PDT)
Date: Mon, 16 Mar 2026 14:05:39 +0000
In-Reply-To: <87cy13swpw.fsf@t14s.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260216-rnull-v6-19-rc5-send-v1-0-de9a7af4b469@kernel.org>
 <20260216-rnull-v6-19-rc5-send-v1-15-de9a7af4b469@kernel.org>
 <Y7WTRL6v0WsR-DWju2vumM1EBu4KZgQzE0VJul7mK3pUwD6ba0UuQO8sclDzOaeLGGh9u3WG5iSKq9T3kQqH-Q==@protonmail.internalid>
 <abfe2LbhLzXiGCkA@google.com> <87cy13swpw.fsf@t14s.mail-host-address-is-not-set>
Message-ID: <abgOM3k4hmDCSkon@google.com>
Subject: Re: [PATCH 15/79] block: rnull: add `use_per_node_hctx` config option
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

On Mon, Mar 16, 2026 at 02:57:47PM +0100, Andreas Hindborg wrote:
> "Alice Ryhl" <aliceryhl@google.com> writes:
> 
> > On Mon, Feb 16, 2026 at 12:35:02AM +0100, Andreas Hindborg wrote:
> >> Add a configfs attribute to enable per-NUMA-node hardware contexts.
> >> When enabled, the driver creates one hardware queue per NUMA node
> >> instead of the default configuration.
> >>
> >> Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>
> >
> > This and other patches make me think that module parameters should have
> > value() return a copy of the value (and require Copy). For non-copy
> > types, there can be a separate value_ref() method. You would avoid *so*
> > many asterisks by doing that.
> 
> Makes sense, I'll send a patch.

Nice!

> >> +        use_per_node_hctx: u8 {
> >> +            default: 0,
> >> +            description:
> >> +        "Use per-node allocation for hardware context queues, 0-false, 1-true. Default: 0-false",
> >> +        },
> >
> > formatting (rustfmt ignores macros)
> 
> This is intentional. The line gets too long if I pull it up, and I don't
> think I can break the string in any way. I think it would require
> changes to the module parameter macro.

Just keep the wrong line. Checkpatch will complain, but it's standard to
ignore that checkpatch warning in C code for long strings to keep them
greppable, so I think it's fine here too.

Alice
