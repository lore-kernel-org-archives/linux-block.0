Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74FEB5A4D8
	for <linux-block@vger.kernel.org>; Wed, 13 Mar 2024 19:03:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710356603; cv=none; b=nMGZTYSKSR7K/HcMm8/6Jp9ZT3krk+/HQvz3xX0dmt3MI/PbnHBVVjFLrDePYMNNFzVE4to/KuriTJW8aMCUHOYUd0hAEDJDe6rVpZENdmVG1yzEPCzsLl1HpQsgYN1dQKWg1U3Qz8N+i4wR7zemmWS7i1u35Nb+lpq7TXyit+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710356603; c=relaxed/simple;
	bh=SX+fEPlUzQH+SDjF+fg9M0nYR4xU4g4PvaNbAOfrrho=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=eQUclu7hSfzv6EH58739meB5Li6GkilKIWgaNF0emaYHMLexolDDL+M7DBVe2Hd8q8hlQNc9lyMW6agsyvF+6SX7nMfOZsD/dJp4UcNwCO+FFZqMH/sa8d4fkUC9dtgJ4FdA2zCj1FNSn+JDxTMVKtx7bSQM3Ensvlpzcjk8OEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=metaspace.dk; spf=none smtp.mailfrom=metaspace.dk; dkim=pass (2048-bit key) header.d=metaspace-dk.20230601.gappssmtp.com header.i=@metaspace-dk.20230601.gappssmtp.com header.b=L1pgeIkS; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=metaspace.dk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=metaspace.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=metaspace-dk.20230601.gappssmtp.com header.i=@metaspace-dk.20230601.gappssmtp.com header.b="L1pgeIkS"
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-5682ecd1f81so267663a12.0
        for <linux-block@vger.kernel.org>; Wed, 13 Mar 2024 12:03:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=metaspace-dk.20230601.gappssmtp.com; s=20230601; t=1710356599; x=1710961399; darn=vger.kernel.org;
        h=mime-version:message-id:date:user-agent:references:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=z0czGQahQJmLOhb1t7D6nFie7YcEp1Eo0BOuwVvzqhY=;
        b=L1pgeIkSkB6oidxQZW6w0VEPRoHmSjDrbfQchntBbcZuaO7ElZW3FyTCpKsEtQY9OH
         pU8d6ZfECLovqMLuWahuE32Lu33FenkpsBQ/AUteZf4j3h+QNcqdyG2qksNxIWVKKvdX
         2ebRMxIzu8A2J3SLZ0O6/zXHuiF14s1TpFxx1GgAQAgXcWKesCFP6LDJaejcR35nGFeq
         cGa7D/742K6iQHhk3J4qxSbLS54rPCBo92G3TsuVWKXeG977KRORTj6ZqmAh3kWEUqIO
         HUIBInQVaiz3OvocMvgRGG8g/iSsq6fwfEf87L9CPEZ7hbz+dv2VaC/3LQ1Yb5Q8LCRi
         4aFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710356599; x=1710961399;
        h=mime-version:message-id:date:user-agent:references:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z0czGQahQJmLOhb1t7D6nFie7YcEp1Eo0BOuwVvzqhY=;
        b=S8iemIIp7yBPnia87Np+Ft+lGCztg12njCuw3e+evhzxuXcEY2phDtjvEl1m3PMyYa
         fElOgiZiSicml1kEu8/FNppQsiIYKZVveMy3paot7Q9pNCurvMRRWA8E/WKP7P1uvJ+s
         cbuQ2JvSOK1L/qA6JMwXcozloww7lTlknM3h3kEbLUkTZEvjp9VIvaWkk/t/LykdnscT
         hPiW24AnDRvtdY5xubChsUHRauSbavBgo19JCRNX/slXpMKuvOmT3jxsKAwxUYIXBERK
         kFLmTh5RsU7szFJ+3k75ZNs8d/31H4E8D9Tql3jJWsdlft7aL0PpUR9rsfRyuV39NCI8
         g5Ng==
X-Forwarded-Encrypted: i=1; AJvYcCXmBX1Wx1991YwyGffd/3D4tw+hqdXvqfQTkhSPKf+28gfNC3VxINlpxovNJnqyYOak9dN/jhGFtxga1nq0s++3QJJxN5wzUNdEmvA=
X-Gm-Message-State: AOJu0YzpZ8xKn09IewrXPMvNz5Pn+o5OHKKPqvkwUQe5WEUuMv5ne/Mq
	XSPjv6BZokVfJyNU6z5DZ2v4T5sDtIpjoD7q9a1qhCquw1q6+HvUekngLrBK+tI=
X-Google-Smtp-Source: AGHT+IHlCY08CcHpJhARgnL+nVCYWz4gNBvKEftYoIsGP8VnUgwgLnr/RbwslLxE6aluPvisCaT/ug==
X-Received: by 2002:a17:906:1308:b0:a46:60c6:98c9 with SMTP id w8-20020a170906130800b00a4660c698c9mr1283936ejb.68.1710356599394;
        Wed, 13 Mar 2024 12:03:19 -0700 (PDT)
Received: from localhost ([79.142.230.34])
        by smtp.gmail.com with ESMTPSA id r1-20020a170906364100b00a4320e22b31sm5163914ejb.19.2024.03.13.12.03.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Mar 2024 12:03:19 -0700 (PDT)
From: Andreas Hindborg <nmi@metaspace.dk>
To: Boqun Feng <boqun.feng@gmail.com>
Cc: Bart Van Assche <bvanassche@acm.org>,  Jens Axboe <axboe@kernel.dk>,
  Christoph Hellwig <hch@lst.de>,  Keith Busch <kbusch@kernel.org>,  Damien
 Le Moal <Damien.LeMoal@wdc.com>, 	Hannes Reinecke <hare@suse.de>,
  "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,  Andreas
 Hindborg <a.hindborg@samsung.com>,  Niklas Cassel <Niklas.Cassel@wdc.com>,
  Greg KH <gregkh@linuxfoundation.org>,  Matthew Wilcox
 <willy@infradead.org>, 	Miguel Ojeda <ojeda@kernel.org>,  Alex Gaynor
 <alex.gaynor@gmail.com>,  Wedson Almeida Filho <wedsonaf@gmail.com>, 	Gary
 Guo <gary@garyguo.net>,  =?utf-8?Q?Bj=C3=B6rn?= Roy Baron
 <bjorn3_gh@protonmail.com>,
  Benno Lossin <benno.lossin@proton.me>, 	Alice Ryhl
 <aliceryhl@google.com>,  Chaitanya Kulkarni <chaitanyak@nvidia.com>,  Luis
 Chamberlain <mcgrof@kernel.org>,  Yexuan Yang <1182282462@bupt.edu.cn>,
  Sergio =?utf-8?Q?Gonz=C3=A1lez?= Collado <sergio.collado@gmail.com>,  Joel
 Granados
 <j.granados@samsung.com>,  "Pankaj Raghav (Samsung)"
 <kernel@pankajraghav.com>,  Daniel Gomez <da.gomez@samsung.com>,  open
 list <linux-kernel@vger.kernel.org>,  "rust-for-linux@vger.kernel.org"
 <rust-for-linux@vger.kernel.org>,  "lsf-pc@lists.linux-foundation.org"
 <lsf-pc@lists.linux-foundation.org>,  "gost.dev@samsung.com"
 <gost.dev@samsung.com>
Subject: Re: [RFC PATCH 0/5] Rust block device driver API and null block driver
In-Reply-To: <ZfHu48NGktOx_uhG@boqun-archlinux> (Boqun Feng's message of "Wed,
	13 Mar 2024 11:22:27 -0700")
References: <20240313110515.70088-1-nmi@metaspace.dk>
	<855a006d-5afc-4f70-90a9-ec94c0414d4f@acm.org>
	<ZfHu48NGktOx_uhG@boqun-archlinux>
User-Agent: mu4e 1.12.0; emacs 29.2
Date: Wed, 13 Mar 2024 20:03:07 +0100
Message-ID: <87r0get0no.fsf@metaspace.dk>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Boqun Feng <boqun.feng@gmail.com> writes:

> On Wed, Mar 13, 2024 at 11:02:23AM -0700, Bart Van Assche wrote:
>> On 3/13/24 04:05, Andreas Hindborg wrote:
>> > This is the second version of the Rust block device driver API and the Rust null
>> > block driver. The context and motivation can be seen in cover letter of the RFC
>> > v1 [1]. If more context is required, a talk about this effort was recorded at
>> > LPC [2]. I hope to be able to discuss this series at LSF this year [3].
>> 
>> Memory safety may land in C++ in the near future (see also
>> https://herbsutter.com/2024/03/). If memory-safe C++ or memory-safe C
>> would be adopted in the kernel, it would allow writing memory-safe
>> drivers without having to add complicated bindings between existing C
>
> I honestly doubt it, memory-safe is not free, basically you will still
> want unsafe part for the performance reason (or interacting with
> hardware), and provide a safe API for driver development. I don't think
> that part will be gone with a memory-safe C++. So the complication still
> exists. But I'm happy to be proved wrong ;-)

I think it is great that people are starting to realize that bringing
memory safety to other systems languages is a good idea. But from one
person blogging about it to things being ready for production is a long
journey. Language designers have to design ways to express the new
semantics, standards committees has to agree, compiler engineers have to
build and test their compilers. Probably we need a few cycles of this to
get things right. At any rate, it is going to take a while.

Second, as Boqun is saying, interfacing the unsafe C part of the kernel
with memory safe C++ is going to require the same complicated
abstraction logic as the safe Rust APIs are bringing. The complexity in
bringing Rust to the kernel is not coming from interfacing a foreign
language. It stems from the inherent difficulty in designing memory safe
wrappers around unsafe C APIs.

Best regards,
Andreas
