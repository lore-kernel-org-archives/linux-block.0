Received: from mail-dy1-f172.google.com (mail-dy1-f172.google.com [74.125.82.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF0E53BB11C
	for <linux-block@vger.kernel.org>; Wed, 24 Jun 2026 14:03:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782309791; cv=pass; b=UUH+cHXSUZsu20rX/H4XmzXjLtVFx6v8dFZ8ncxSSSSzcp2Orse8/Lpn9wq9iXcyqqLYlYW7JQ44LW9iBVDveQ9PG0pKqC0EL2NT61BNQGPMaMfCGM68uT+QojWd8NsDB1RyzBwKsZ5dx/+1GMBHSBCltCtrjCRtlMgg6llV0Xo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782309791; c=relaxed/simple;
	bh=ksijtf2IRLNHsT3AVS8XAMToSq3zWqz1VXfdch2/aYo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ArS46cSddVNKmPdULS5ZoAU/4DhAomstsYaOn4roK9epOMpYEwZmOuXoArJBnKEoPjsrgFrQby9bkqFpRV81UlYb6AO9XS/5MHKeVsAuU8wHmU8kOP1laQ4XIATZs029ad0JOu3pDBheR087snQz2Gd4BdVuuUgLq5H86CmqAzE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hsecUjtc; arc=pass smtp.client-ip=74.125.82.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hsecUjtc"
Received: by mail-dy1-f172.google.com with SMTP id 5a478bee46e88-30bf42b0ad2so75154eec.0
        for <linux-block@vger.kernel.org>; Wed, 24 Jun 2026 07:03:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782309790; cv=none;
        d=google.com; s=arc-20240605;
        b=SNvbYY+mMr8hm/NHC0ccL3nk2sUu1+Vhsebn21+YInGJC+kYFX1b87bFCo0bPAjx2n
         aLtLA+gyfFwuD2dW4LrTw8hIvrv//euKrxaUbxC3NlrosBuC41j+Eb9g/L3z2DHLQzzq
         zOCJF3EnCK7r3/xMwX1L4A5SasQ886c0OD5CGo/hAJApI1/SFd1DCwNGGsgA6NB6Wm51
         +4tjk9eqoa/n2dZAw8qAofoQy3WSj+FA15YPLz6/CwCSyH8Of9JxBk6Kr0+7OGnporr7
         b/6jYD04wvYl59fwAM/jH8CiDPQ7Y0HpXfP3Ip1nbSW406e2paoP6sMR/fOx8y9BgJQS
         M/4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ksijtf2IRLNHsT3AVS8XAMToSq3zWqz1VXfdch2/aYo=;
        fh=8obUmwbbBJzzNFi0I90+n+xJ2w9KXu54QnZP/iMCkUo=;
        b=V5QqeCD53t5am3tZ0yVtvaNuZCBJSViXziFtyZ0773H9fInGVuiwv/QgKkugRjsJng
         0ZNSue2K2v+OotjDFJ4hzCDubGPZw5lqdCDTL54FuDeuJmuZwNy3u+QzgisllfxwvJ5S
         NNe4d657ReDNn/7+GNHdkS9+v9nMfNfqDfEkeEO0ExSami4fdK5PqG2lN+chRN3H8F87
         mt2Hl0Zj9RC0Z3YY4S+scSrLJqs/ki8DEK/qTdhzLYtEomsjTcp0BsREaX+kaZboms/Z
         XdYHTtTfQiTsqpcIbg3NgdU9jQcsuQX22F1yEXyEzREd+tn/9xe5mNl0ng8ydbOuEs1x
         SYNA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782309790; x=1782914590; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ksijtf2IRLNHsT3AVS8XAMToSq3zWqz1VXfdch2/aYo=;
        b=hsecUjtcX+2100VDiJTVQfiUzHkHNfosIUE1h1VgZ/aN73Nrll8dHIpfVxaPNGO3th
         oOYuhmQtxznpu59gHGEhhbQo15BpIV9NQ7ImlhNajXvohWnXDFnpuDm1cuVRFVcfNJTz
         k6CNvUOh4DZBOquwW3nuxkWRdr/+7q6JdjrF1dzUp6OzGj9cq0/tWnIR94yAw/mPyO3q
         6/lKvpIoQSgjkltjJSjbxiKJGWJCinrf5FAQ9zF7i9/S/fRNLEvQT/qqxwU3yHCpOGXH
         sRz/hIttFhf08bwI68pb0WiDIZm/lziXf5I8tsWdnEJ8IIxOgezA93WhXXVH7t6v5Ulc
         2sKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782309790; x=1782914590;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ksijtf2IRLNHsT3AVS8XAMToSq3zWqz1VXfdch2/aYo=;
        b=IfvBwoO3Aks+qWMCoaL/oQKc9nXh+lYwhw2kZDubwLo/Rhkr9fZvGRVO3gKjyUUKQR
         fofzE45+Ndd9rqwCCDC7iy8X7LXwL3NuCUShMtRJRf/bcipmuJJg/kHupwZQoYm8iUvY
         XbeJFWXS64uhDa+MKVhSqjvImSo9GDTmOkjpDBU9/V5Vt/TqPrNL3qPY1b1k6zGDOXuk
         fSg9glWlldEvlrlwHkYEsLQLFp4LmlZH2Wropg1T1IFSKaREPdMbHiUgjyzqh2W0vgJw
         VLcJD0YmeCQcHv/0umdQ8WITVUNBkWFyb7vQ0DYg5lXre6LxwtLhB1r4mY6pYe928wXr
         w2IQ==
X-Forwarded-Encrypted: i=1; AHgh+Rrmo6mD//6rMvYuGKznL1TNxYzRAN0qFZutFYFt9SeIicZdXG8h4TUjerLFIv7N9Z/gviZgdB6BGJGo1w==@vger.kernel.org
X-Gm-Message-State: AOJu0YzK+sMEGpLuEer+9YfFInTiM+YN3wLQFtmiymYi/goccO/Wzl3A
	KVqWbq8yq4IdqeQ+z8w3EEZ7OS72AyN1h8eoKIRR+a9oaX3ltdwht0JuZxxZi99n3HSkO+Cco1u
	g5ilipdopJHPnB+uXt0ivYues3iI3X5w=
X-Gm-Gg: AfdE7cn/eK4+F09NGYV9Hn2RKVx+Ns1N65PCQOGBC2iKhUpF5lRT4RpAVoKZo15KZSQ
	LozcyF6/BUBNdMOWXWSQ8iDRelsrXtbmlago5LF0S9GlcPSV5IoZCrcjx/kLlHLz4c7EEYDnJ7+
	jGyat+ArjRR7h/O9p5iNTcib5YtSbXzq1JGVq+8IvA8djkrdHw4tiWl95uIhMU+0s0vqOjhzbzP
	pk58BVqrzlMLKvZ664cXLcK9WiQNagRRyb5J7kXvFh6xpWt4JqJ+pUaco+emRJ0/M4vDrMf3q6I
	SkVcwlK3yX1ppYiEnucHePv28L7WB7nfd4eqSaHANPjY0iq8mpDIdJQNbWoK0rqyRp3f43URRoy
	iUaUiQMgvnK5P
X-Received: by 2002:a05:7301:658a:b0:30b:c8bb:588f with SMTP id
 5a478bee46e88-30c5240f7damr3538472eec.5.1782309787929; Wed, 24 Jun 2026
 07:03:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260624-fix-fops-owner-v5-0-aa1cba242f05@linux.dev> <8ea21b29-9baf-4926-a16f-7d21c5a1a1b8@suse.com>
In-Reply-To: <8ea21b29-9baf-4926-a16f-7d21c5a1a1b8@suse.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Wed, 24 Jun 2026 16:02:53 +0200
X-Gm-Features: AVVi8CdZJD474qdF4GDgFLlfJ_vD8WsFaomaTI3YSRH6pluhcoRUR51gh_iz4VE
Message-ID: <CANiq72m_LakPxHt99+3eBn2rXokr3vZbdJf=Wk-Yi8_ufQ2mvA@mail.gmail.com>
Subject: Re: [PATCH v5 0/9] Fix missing fops.owner in Rust DRM/misc abstractions
To: Petr Pavlu <petr.pavlu@suse.com>
Cc: Alvin Sun <alvin.sun@linux.dev>, Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>, 
	Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, Luis Chamberlain <mcgrof@kernel.org>, Daniel Gomez <da.gomez@kernel.org>, 
	Sami Tolvanen <samitolvanen@google.com>, Aaron Tomlin <atomlin@atomlin.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Daniel Almeida <daniel.almeida@collabora.com>, Arnd Bergmann <arnd@arndb.de>, 
	Brendan Higgins <brendan.higgins@linux.dev>, David Gow <david@davidgow.net>, 
	Rae Moar <raemoar63@gmail.com>, Breno Leitao <leitao@debian.org>, Jens Axboe <axboe@kernel.dk>, 
	Dave Ertman <david.m.ertman@intel.com>, Leon Romanovsky <leon@kernel.org>, 
	Igor Korotin <igor.korotin@linux.dev>, FUJITA Tomonori <fujita.tomonori@gmail.com>, 
	Bjorn Helgaas <bhelgaas@google.com>, =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	=?UTF-8?B?QXJ2ZSBIasO4bm5ldsOlZw==?= <arve@android.com>, 
	Todd Kjos <tkjos@android.com>, Christian Brauner <brauner@kernel.org>, 
	Carlos Llamas <cmllamas@google.com>, rust-for-linux@vger.kernel.org, 
	linux-modules@vger.kernel.org, driver-core@lists.linux.dev, 
	dri-devel@lists.freedesktop.org, nova-gpu@lists.linux.dev, 
	linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, 
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, linux-pci@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 24, 2026 at 3:23=E2=80=AFPM Petr Pavlu <petr.pavlu@suse.com> wr=
ote:
>
> I would only suggest adding the new file rust/kernel/module.rs in
> patch #1 under the MODULE SUPPORT support entry in the MAINTAINERS file,
> similarly to the other module-related Rust code, so that the module
> maintainers are emailed when changes to this file are proposed. I think
> you can change the existing 'F: rust/kernel/module_param.rs' to
> 'F: rust/kernel/module*.rs'.

That would be great, yes -- thanks!

Cheers,
Miguel
