Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD3FE745F2
	for <linux-block@vger.kernel.org>; Thu, 14 Mar 2024 17:44:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710438251; cv=none; b=p90cAB12BPTpfcAxKYvukDJ1MhNieIR2Q97bilkap4CzzOb+r2bYMMniSHF1fWiHyw5mX6vUaGk7hpXix0pShzSnTA2yFjo05EYHxMwnSjAt0xNuKdXpdMlG6lBT7yT5PwtDGR/HthztSAC0oDBrg8He1MwECbOtdJD2YjmoCZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710438251; c=relaxed/simple;
	bh=M8N5oZ+/LXyAzxuvMsSQY7clk0qZgqtmEHzrADgnLm0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=k+b/XmV8ysnTrQ0SMvK80PcyuPkztune7nJ9zPIq85idoR3T78E8Dc3iJ3JHs25KlMuzYrgwBiuI2f4/MrrbNXRlFK6+QDRqBsj5NKx8A/48JYBQyiZefHgzH0upHmiE7uECLPLYBHg39HhYIVgk+5o/hFLHQQRa0BXPdWjG2W8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=metaspace.dk; spf=none smtp.mailfrom=metaspace.dk; dkim=pass (2048-bit key) header.d=metaspace-dk.20230601.gappssmtp.com header.i=@metaspace-dk.20230601.gappssmtp.com header.b=K8/t1/OY; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=metaspace.dk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=metaspace.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=metaspace-dk.20230601.gappssmtp.com header.i=@metaspace-dk.20230601.gappssmtp.com header.b="K8/t1/OY"
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a467739e1f0so78365366b.0
        for <linux-block@vger.kernel.org>; Thu, 14 Mar 2024 10:44:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=metaspace-dk.20230601.gappssmtp.com; s=20230601; t=1710438247; x=1711043047; darn=vger.kernel.org;
        h=mime-version:message-id:date:user-agent:references:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=M8N5oZ+/LXyAzxuvMsSQY7clk0qZgqtmEHzrADgnLm0=;
        b=K8/t1/OYbSELH/AtbRGJwsePiQxm+LDoKKW0vrSdTde+JD/3ZSmnWCiMW2yKs0mM7C
         7zLpX6Qhd4b/GIAi31zs5Qp21xTShppS8JrErW/WcbBAAoQPxnuVCnEDm/PrWReSC0hK
         NFfOgnMx7cAuB3DZ6Oc7d/vTh3mxva4lt7vYa4xp364LeX4tSvy6dR8nbVmlIajxjxRO
         4PF37gKpklHycQP5TXgOAJoXuaT0oWq8ARuI6hiQOTSyhzcUWuk+wNFuN0s4YtBMScCB
         Wa/o/ik8crXx4saXDaf9ReNyh2kAZlpFvEr3Ce166+5DzYGYenkaPj1F/MsTZF/L+EVj
         7mFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710438247; x=1711043047;
        h=mime-version:message-id:date:user-agent:references:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M8N5oZ+/LXyAzxuvMsSQY7clk0qZgqtmEHzrADgnLm0=;
        b=MPD0X7bhry9DiGm/4tFNgS26gUNBN8d+O8yLd5kJKbTIe2SsFrJFXl9TjYox+xzmQV
         1hv7193J+UovuJAMYTY++ViqyvmCdJ+oJ8T0uuQpRIx8pWHoUibxcXyEsXVYuUUsJBJE
         Wv/jJMLxdZmcrpH29MZKC7qQctkwhgF9O45153fd8MVy65VE5iWYUF/89ydqKrHKwzHJ
         nYdxUAZwQ6nTNOQGk2AW5fe5n1lRl6A85Lvz9ZlbGdr0/NZ/BV48zEtvaVY29AQTdZQX
         dbxMnWoCM6HAlPmYeHaRrrmUoThLKYjBjc/jOGt52kndsX25pAc1mBc558mc/Y34srny
         bT+Q==
X-Forwarded-Encrypted: i=1; AJvYcCXAEsYRF4gM98GNe3Ctu+MD3uExgCZAPPAytmMLXcsWKo5eTxjhdGvhLO7g12aE/wabv55t4lwTh8apJ1/z7F+zQagwuJsl853jRps=
X-Gm-Message-State: AOJu0YyaOiKtZNMGHmIjwzgokJMORMt+ZgyAHmh3NZwEgX1YtV8axCkK
	FPra22sJw277MoAnO/De4oI73e9uMs9h/6nJK1i8suP5ufPbS49/+YqP75TKZ9I=
X-Google-Smtp-Source: AGHT+IGNGmhd6c8fk9N36efORaPKI9EAIHgsWOB21RuI53fwrlIxyX+LzZWbPTSK4HG2OUGeBRQDIA==
X-Received: by 2002:aa7:dd0f:0:b0:565:b456:435d with SMTP id i15-20020aa7dd0f000000b00565b456435dmr1018190edv.17.1710438246623;
        Thu, 14 Mar 2024 10:44:06 -0700 (PDT)
Received: from localhost ([79.142.230.34])
        by smtp.gmail.com with ESMTPSA id s4-20020aa7d784000000b0056486eaa669sm899978edq.50.2024.03.14.10.44.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Mar 2024 10:44:06 -0700 (PDT)
From: Andreas Hindborg <nmi@metaspace.dk>
To: Bart Van Assche <bvanassche@acm.org>
Cc: Philipp Stanner <pstanner@redhat.com>,  Jens Axboe <axboe@kernel.dk>,
  Christoph Hellwig <hch@lst.de>,  Keith Busch <kbusch@kernel.org>,  Damien
 Le Moal <Damien.LeMoal@wdc.com>,  Hannes Reinecke <hare@suse.de>,
  "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,  Andreas
 Hindborg <a.hindborg@samsung.com>,  Niklas Cassel <Niklas.Cassel@wdc.com>,
  Greg KH <gregkh@linuxfoundation.org>,  Matthew Wilcox
 <willy@infradead.org>,  Miguel Ojeda <ojeda@kernel.org>,  Alex Gaynor
 <alex.gaynor@gmail.com>,  Wedson Almeida Filho <wedsonaf@gmail.com>,
  Boqun Feng <boqun.feng@gmail.com>,  Gary Guo <gary@garyguo.net>,
  =?utf-8?Q?Bj=C3=B6rn?=
 Roy Baron <bjorn3_gh@protonmail.com>,  Benno Lossin
 <benno.lossin@proton.me>,  Alice Ryhl <aliceryhl@google.com>,  Chaitanya
 Kulkarni <chaitanyak@nvidia.com>,  Luis Chamberlain <mcgrof@kernel.org>,
  Yexuan Yang <1182282462@bupt.edu.cn>,  Sergio =?utf-8?Q?Gonz=C3=A1lez?=
 Collado
 <sergio.collado@gmail.com>,  Joel Granados <j.granados@samsung.com>,
  "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>,  Daniel Gomez
 <da.gomez@samsung.com>,  open list <linux-kernel@vger.kernel.org>,
  "rust-for-linux@vger.kernel.org" <rust-for-linux@vger.kernel.org>,
  "lsf-pc@lists.linux-foundation.org" <lsf-pc@lists.linux-foundation.org>,
  "gost.dev@samsung.com" <gost.dev@samsung.com>
Subject: Re: [RFC PATCH 0/5] Rust block device driver API and null block driver
In-Reply-To: <5f502f91-0450-454d-ae8f-36223920532e@acm.org> (Bart Van Assche's
	message of "Thu, 14 Mar 2024 10:03:28 -0700")
References: <20240313110515.70088-1-nmi@metaspace.dk>
	<855a006d-5afc-4f70-90a9-ec94c0414d4f@acm.org>
	<c38358c418d4db11221093d7c38c080e4c2d737f.camel@redhat.com>
	<5f502f91-0450-454d-ae8f-36223920532e@acm.org>
User-Agent: mu4e 1.12.0; emacs 29.2
Date: Thu, 14 Mar 2024 18:43:56 +0100
Message-ID: <87y1akso83.fsf@metaspace.dk>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain


Hi Bart,

Bart Van Assche <bvanassche@acm.org> writes:
> On 3/14/24 05:14, Philipp Stanner wrote:
>> On Wed, 2024-03-13 at 11:02 -0700, Bart Van Assche wrote:

[...]

>> One of the stronger arguments behind the push for Rust is that the
>> language by design forces you to obey, because otherwise the compiler
>> will just reject building.
>
> Rust has a very significant disadvantage that memory-safe C/C++ won't
> have: supporting Rust means adding Rust bindings for all C functions
> called from Rust code. This forces everyone who wants to change an
> interface to also change the Rust bindings and hence will make it
> harder to maintain the Linux kernel in its entirety.

I think you might be missing a key point here. We actually generate Rust
bindings to the existing C kernel automatically. No hand editing
required, except for some corner cases we currently have with static
methods and certain macros. If we just wanted to call the C APIa
directly, there would be no engineering required. The main reason to
deploy Rust would also go away, we might as well stay in C.

The actual engineering effort goes into building memory safe versions of
the C APIs. This requirement will not magically go away, no matter what
memory safe language (or language extensions) your use to interface the
existing unsafe C APIs.

Best regards,
Andreas
