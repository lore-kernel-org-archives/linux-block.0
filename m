Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DC1F2D022
	for <linux-block@vger.kernel.org>; Wed, 28 Feb 2024 14:46:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709131619; cv=none; b=HcSl1ntQOZtRgzzQRWxCrrbrMvDHWgK6R2pn7LeRsPVcmxucKRe66GD3a3RxNmssNzfESNEuvpP3QZ0J885CUBM1DCkVT1bq2jTY+1NMexmZpGjiO4E2w7TcWq5SoQeXuh2n6AsYbIWIhEefme7CF3l09HKM54a1egzFpeGzdEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709131619; c=relaxed/simple;
	bh=HIHzjpOrKXqxWUafULLKuoxHLdhUSesh8dKt3u79tcI=;
	h=References:From:To:Cc:Subject:Date:In-reply-to:Message-ID:
	 MIME-Version:Content-Type; b=FzCGDfYS5oFNM4tfAUBEx1Cdz2EyP/gM0B/tvmgj8AbhfRaW53MVbo1iepWfOZPIhw7wv1EGo7Ycn8FZJfLirxTCnxSTMw5XNMbA8CEQXFGmTH4gO2FZclsM9fM1zl7ZX9kHIHIZTWApKHGpPKFcib82ZHBcIB48YvJH7tQNGZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=metaspace.dk; spf=none smtp.mailfrom=metaspace.dk; dkim=pass (2048-bit key) header.d=metaspace-dk.20230601.gappssmtp.com header.i=@metaspace-dk.20230601.gappssmtp.com header.b=u5dIV5Qw; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=metaspace.dk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=metaspace.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=metaspace-dk.20230601.gappssmtp.com header.i=@metaspace-dk.20230601.gappssmtp.com header.b="u5dIV5Qw"
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a43f922b2c5so103829066b.3
        for <linux-block@vger.kernel.org>; Wed, 28 Feb 2024 06:46:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=metaspace-dk.20230601.gappssmtp.com; s=20230601; t=1709131616; x=1709736416; darn=vger.kernel.org;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:from:to:cc:subject:date:message-id:reply-to;
        bh=8qxXismbJGcxxSTGQfo0P8Mi+M/PX5Dw7LvQPC3lxVI=;
        b=u5dIV5QwBYHZ3+rbhMuG78masI3SP+jfnoz2ntUIM3QT2VUKX2MPuLxd0jrIQ0srPG
         y94QpMB6EFeYkncliZnquGLLfkFe+XUR7cHfzIZmpStm+3GE07JFv00195r/K0v4l8wW
         3MXrdpMg06FdxDNhSQCmpW8fJOzKFjOhduRqCfjNSn4h/14DkTrY0xY6YpkJO9I7B+Of
         aQnRhHfeIbbZDQBwy/lrGFwf7iIFqkQo6PXR5N1s6pDS1RsZmdqmBTxwEEAcFPqyHiIr
         Cff9Q8HfJfAGVJvW3DfMCOgHDvLvePD5gIkK4befWH6GSJJoZ4p+TrMbcngXMVuT+2jw
         xrqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709131616; x=1709736416;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8qxXismbJGcxxSTGQfo0P8Mi+M/PX5Dw7LvQPC3lxVI=;
        b=m7nleb+B0Z+bHIhGP6rgJLk4ljYQtoU1S5hDXnoKX99ponwlB977hEeukrv9qUpb6R
         tdyv1Gl4+pL/qaAv6bfcRq1u8uxYTx5UYel3K8kIPWI13Mi8DVpqhH1vP9lNtgSFvIV1
         3IpGv3BQo77Df/AR4stxIoRoMWYwik8s0KXCc+BZUHQDNU0i+N4BShvASakxezPCCndm
         vB0bzrMgy8RiFkhV/a0yW/LlZzyT9Hxz70G7RS/PM8n5IN1T+vCec5DRViH0DPzTOhGD
         1RwHrEFm+trVfrccO/queNGYRsk7eryvnnj3finm+H3qBKAM4pQjgmFkdvGXCoiNd/eo
         LLJA==
X-Forwarded-Encrypted: i=1; AJvYcCVkXe47XQdz8RF9KndLaq394Z6avAmDZoyOpuB7cLBaHjXBAKKqK5/UScfaQyGRv6+eC309mpZCQGXc0Np9DIodQGZyQHgdARZEeNo=
X-Gm-Message-State: AOJu0Yw2IyLR/J0PK1cK5rz2dvGcqkX9sUftcTY1vlgxtqnf0iu3hHt+
	EuyTJWC2K2KrRkcKU72dNnM/jNJNgc3XhwZj5v8oD3jGideSGChv+XEz6kNSdGo=
X-Google-Smtp-Source: AGHT+IEaCtfzpxkkLGZrLyaEquAtLxbLxoHoHkahKKccPYaAGg7T1KVamkQdgIwfHk8QmWSe6axdgA==
X-Received: by 2002:a17:906:c196:b0:a3e:8300:1af3 with SMTP id g22-20020a170906c19600b00a3e83001af3mr8976821ejz.30.1709131615583;
        Wed, 28 Feb 2024 06:46:55 -0800 (PST)
Received: from localhost ([79.142.230.34])
        by smtp.gmail.com with ESMTPSA id dc6-20020a170906c7c600b00a441674cae4sm357911ejb.222.2024.02.28.06.46.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Feb 2024 06:46:55 -0800 (PST)
References: <20230503090708.2524310-1-nmi@metaspace.dk>
 <20230503090708.2524310-5-nmi@metaspace.dk>
 <-SiJ5paRDIUkH1WEWhGhEjhIgFbSo5PJAvac53bTnBZ5o41DR-kNWZEQBsnKeW1FRJh35siVFRrx54L0M6ebSzl0rzecgcDjqZFGRa9uypE=@proton.me>
 <87a5pcyqf8.fsf@metaspace.dk>
User-agent: mu4e 1.10.8; emacs 29.2
From: Andreas Hindborg <nmi@metaspace.dk>
To: Benno Lossin <benno.lossin@proton.me>
Cc: "Andreas Hindborg" <nmi@metaspace.dk>, Jens Axboe <axboe@kernel.dk>,
 Christoph Hellwig <hch@lst.de>, Keith  Busch <kbusch@kernel.org>, Damien
 Le Moal <Damien.LeMoal@wdc.com>, Hannes  Reinecke <hare@suse.de>,
 lsf-pc@lists.linux-foundation.org, rust-for-linux@vger.kernel.org,
 linux-block@vger.kernel.org, Matthew  Wilcox <willy@infradead.org>, Miguel
 Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Wedson
 Almeida Filho <wedsonaf@gmail.com>, Boqun  Feng <boqun.feng@gmail.com>,
 Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn?= Roy Baron
 <bjorn3_gh@protonmail.com>,
 linux-kernel@vger.kernel.org, gost.dev@samsung.com
Subject: Re: [RFC PATCH 04/11] rust: block: introduce `kernel::block::bio`
 module
Date: Wed, 28 Feb 2024 15:31:04 +0100
In-reply-to: <87a5pcyqf8.fsf@metaspace.dk>
Message-ID: <878r34aboo.fsf@metaspace.dk>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain


Hi Benno,

"Andreas Hindborg (Samsung)" <nmi@metaspace.dk> writes:

<cut>

>>> +);
>>> +
>>> +impl<'a> Bio<'a> {
>>> +    /// Returns an iterator over segments in this `Bio`. Does not consider
>>> +    /// segments of other bios in this bio chain.
>>> +    #[inline(always)]
>>
>> Why are these `inline(always)`? The compiler should inline them
>> automatically?
>
> No, the compiler would not inline into modules without them. I'll check
> again if that is still the case.

I just tested this again. If I remove the attribute, the compiler will
inline some of the functions but not others. I guess it depends on the
inlining heuristics of rustc. The majority of the attributes I have put
is not necessary, since the compiler will inline by default. But for
instance `<BioIterator as Iterator>::next` is not inlined by default and
it really should be inlined.

Since most of the attributes do not change compiler default behavior, I
would rather tag all functions that I want inlined than have to
disassemble build outputs to check which functions actually need the
attribute. With this approach, we are not affected by changes to
compiler heuristics either.

What do you think?

Best regards,
Andreas

