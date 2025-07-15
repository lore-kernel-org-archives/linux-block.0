Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D5A31E5018
	for <linux-block@vger.kernel.org>; Tue, 15 Jul 2025 09:35:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752572135; cv=none; b=kPegmlJLEv+ayTClnyaLeCoNoe4u7LStswKHcGjtpih4Y9KAjW7IKWl8nVmBqfD6qMNqqKPbc8yhPIEi0e+MGp/ImoTAfvG61PxzO+52zHpiEd8uXyyc4nbga+uGTyf8TvKQF5FtIBhRB2uNaNY3pVsRXkgy5WO7szzhHr7TL0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752572135; c=relaxed/simple;
	bh=yee2NYU6mBR5YlB4KQHX6ZVBUAyXy0AOr2Bpw507kC4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=pFA/u0+pjyg59ttgolpbgk1QdD4imjJ3dPZQKbYaWXwpkN3XeUCnAno6+gMvOz3PB2aPQESwyp67Ip/ewad8dcD/kQVF5oBFjxm3tLyR6y+gZBInYnRo5xSDeeR23kGuBzGDSLIyDIZQWpJR4bIMmnDTShKa5aE0zelk9bqzZYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Whn1/o+1; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Whn1/o+1"
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-451d7de4ae3so33441525e9.2
        for <linux-block@vger.kernel.org>; Tue, 15 Jul 2025 02:35:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752572133; x=1753176933; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=F6OY5zMr/+IuOad0gM9u5Fh24EtyMZ2ZoxgNL4rh6sc=;
        b=Whn1/o+10khwbshewiFqeyk+QKP9c3VN825OVZV/I9nVIBptUJl6hWLnMs1dKdZnJf
         b/x6hcTzYMuzouSKTfd/78tdvvXNtljrvhD4cmXWFPgnQrYoy+X9Ii7IHzEpH4Htg804
         U043dyrOjB+HPGye+UDIpwvil+q9IcOwuGSRiEzAiZQtI572NndlLa7qmyomujSZImdR
         8OpLtbm9OAz70zVOwbs3LJjAhJoPtkqiKC4jl1Ih9FqlV+qhaR4lu/NcZ+JEM4m/+dyE
         /IVORhpNuYNWUlQ2+T37mhaXVLpCU+Qw2ALfj3wrKls/S5o7rtmBV0EnuSTakEvG/fSe
         66FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752572133; x=1753176933;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=F6OY5zMr/+IuOad0gM9u5Fh24EtyMZ2ZoxgNL4rh6sc=;
        b=oRO9JaCVkqovQzsiX6wsJiOkWFtUoZbtIEzKlZH4HPJu11NDugvWRDpEd8UZeS7QXG
         SAYbgW7XRwnTdRn/dI5u3INrIJhaa/qFlGqKKxhVZcJuZ8QVRh3MSa0lOOv4e+gdETtd
         +jaECJQEzavebebGTOAOfv9uJLsdXJUlKMfQ5ecvpQ3WzZO+ODrQaq0+bEB9rWIcmriT
         tjagIx5sxvbO+Lmc/N6J3kCMQZtYHmIDnKijEJEvkLdVb6uc48VD9QpGQyB7mI20JY2T
         oWm9f6KDoq9sQmKfwSL/AdFRGQWgBNTMD5zSWiN1zY29jeXhmg7Z/Y90FIxDZ+7Dbvun
         1asg==
X-Forwarded-Encrypted: i=1; AJvYcCVaN7MQ2xjhf+lqY9zat7iafd7lqAdh9qD0r3jl0ZJfCDnez0gCXlww+5kOuvlUzo+NBrqEoTaPUjaN9g==@vger.kernel.org
X-Gm-Message-State: AOJu0YwQ/TvEgYtZs7cXgZNjTij8L4l+e184U1MGbPn5svUX/+T9Undh
	bAVHKDFv8PNtOoulCtv8kROjx8IjZNrmEsufV2WhbsBe3oLTG1apRTeZbofAv7bYINJZ04txZ0E
	ccBDH30Yx6xXNPXNmaA==
X-Google-Smtp-Source: AGHT+IHqUXC6pWZ+Cef1TJtAf8/IFZ+OtfsS+rQFzogwmB9VBY8LgiwqGFMX3G0NvakLHr9g7Xu55w+rZtDLxNk=
X-Received: from wmbh2.prod.google.com ([2002:a05:600c:a102:b0:453:f66:5f37])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:a08c:b0:456:22f0:d9ca with SMTP id 5b1f17b1804b1-45622f0de79mr41125145e9.26.1752572132937;
 Tue, 15 Jul 2025 02:35:32 -0700 (PDT)
Date: Tue, 15 Jul 2025 09:35:32 +0000
In-Reply-To: <20250711-rnull-up-v6-16-v3-3-3a262b4e2921@kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250711-rnull-up-v6-16-v3-0-3a262b4e2921@kernel.org> <20250711-rnull-up-v6-16-v3-3-3a262b4e2921@kernel.org>
Message-ID: <aHYg5Lbw49-3k_tI@google.com>
Subject: Re: [PATCH v3 03/16] rust: str: expose `str::Formatter::new` publicly.
From: Alice Ryhl <aliceryhl@google.com>
To: Andreas Hindborg <a.hindborg@kernel.org>
Cc: Boqun Feng <boqun.feng@gmail.com>, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Gary Guo <gary@garyguo.net>, 
	"=?utf-8?B?QmrDtnJu?= Roy Baron" <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, Jens Axboe <axboe@kernel.dk>, 
	linux-block@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="utf-8"

On Fri, Jul 11, 2025 at 01:43:04PM +0200, Andreas Hindborg wrote:
> rnull is going to make use of `str::Formatter`, so expose it with public
> visibility.
> 
> Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>

Reviewed-by: Alice Ryhl <aliceryhl@google.com>
