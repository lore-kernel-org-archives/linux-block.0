Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=144.76.212.145
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795002208;
	b=RCMvTa66F6haANzasqIyyVaREzj/Qe/GDwg0NfV2KBxwjlicSzVgVeVuXIGIGu91hXqF
	 lD5WAgkBF5Q5KyPcrhqt6+bFYFS3QQkvtVK/v1oxh40QohuSMlOYfnxgR0GfdtkRcniIj
	 Hg1Z3NC+n2OuSxnGwhr4UGrHVGUdwfj8YriH6bguhy1JGjaDPMqEU75A7gXrx+W/vf8ZD
	 ov0xnykDaIHYB83tbRixHEXeJ7AYkdy2C7zrrkxe9ymcKsnZydprF6pyiov9Qdo7SCKke
	 4MiX6mckv2Hfo6hv7yD3nUO007oZpHXWi61nIU7uiAg/cL4pfwDdUMMR2XQ/H0jzz6g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795002208;
	h=Received:Received:Date:From:To:cc:Subject:In-Reply-To:Message-ID:
	 References:User-Agent:MIME-Version:Content-Type;
	bh=iii72bAln91AxAYWqMoQsj+xak14m3uKD/kq756gkCc=;
	b=A+dfIGteGfRo2krAgif9EJMEJw5tmqM6zXUzZeDQmQMYcr9ZUrh1kpIAWzpT07hKcbud
	 fPj5woMRMj6rg6HVTO9J7SGfTvbOF4jxznEINgilYUDHwOgACrTGQnaCG4q9Yn86Hjwuk
	 61wterjdEKO4qzqdTNT67WmBsDwjZk/iaCCOr3aiX4xGiwYkRND6I7aMKanYjsUDwKLEj
	 vFdNQxChpezW6OYQ22oW71PF4QXVdFLcMKetTgXGILxgFPaZyhOK7AzkFXPS4JaASQ3WF
	 WCEtOnSPWYg0ClA2VmHX4bhuiUBAMDL6vi3xym2gq3lRr+C0IfqZts5FUKwpZ6KbKsg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=permerror header.from=inai.de;
	spf=pass smtp.mailfrom=inai.de;
	arc=none smtp.remote-ip=144.76.212.145
Received: from a3.inai.de (a3.inai.de [144.76.212.145])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 563A9606A31C;
	Wed, 18 Nov 2026 11:43:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=permerror header.from=inai.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inai.de
Received: by a3.inai.de (Postfix, from userid 25121)
	id 4FF8C1022963DE; Wed, 18 Nov 2026 12:43:17 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by a3.inai.de (Postfix) with ESMTP id 4D5E811040FD86;
	Wed, 18 Nov 2026 12:43:17 +0100 (CET)
Date: Wed, 18 Nov 2026 12:43:17 +0100 (CET)
From: Jan Engelhardt <ej@inai.de>
To: Vitaly Wool <vitaly.wool@konsulko.se>
cc: Andreas Hindborg <a.hindborg@kernel.org>, Jens Axboe <axboe@kernel.dk>, 
    Miguel Ojeda <ojeda@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
    Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>, 
    =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
    Benno Lossin <lossin@kernel.org>, Trevor Gross <tmgross@umich.edu>, 
    Danilo Krummrich <dakr@kernel.org>, 
    Daniel Almeida <daniel.almeida@collabora.com>, 
    Tamir Duberstein <tamird@kernel.org>, 
    Alexandre Courbot <acourbot@nvidia.com>, 
    =?UTF-8?Q?Onur_=C3=96zkan?= <work@onurozkan.dev>, 
    Lorenzo Stoakes <ljs@kernel.org>, "Liam R . Howlett" <liam@infradead.org>, 
    linux-block@vger.kernel.org, rust-for-linux@vger.kernel.org, 
    linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] rust: block: add rbrd, a RAM backed block driver
In-Reply-To: <20261117233211.3137168-1-vitaly.wool@konsulko.se>
Message-ID: <176sn0r1-3s85-0nq0-p258-220pnspno416@vanv.qr>
References: <20261117233211.3137168-1-vitaly.wool@konsulko.se>
User-Agent: Alpine 2.26 (LSU 649 2022-06-02)
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII


On Wednesday 2026-11-18 00:32, Vitaly Wool wrote:
>
>  test                  brd    rbrd   change
>  write, 8 threads     2004    1563    -22%
>
>We think this is a small price for page integrity

A free 28% improvement, just by using a C driver, and a bit of 
discipline in the program (not submitting the same page).
Supercomputing will be all over brd if they need a ramdisk.
