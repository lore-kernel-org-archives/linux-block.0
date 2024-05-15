Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com [209.85.167.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B24F12AAFD
	for <linux-block@vger.kernel.org>; Wed, 15 May 2024 13:21:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715779283; cv=none; b=F3CRunLAh9ALkcEWOyp08Qeyv3VVkFZSgabO6wx+NBzmatHNESjmjaW93jy5hqZnUb0o3lfSHjIes1sNYbzsLq2ODSoYwSWTVI8sPyClNviAL4MZIzmWl8jwfIjPt/F2pYM5ogTo4IlnKrnzVa9fERF2jf2fErWl1Ae6+26VW24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715779283; c=relaxed/simple;
	bh=e8/pYDYtbf8OuDE4k++PDPWJCRs31hyPD+r8+dkMjss=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dlCGG9GY45RDqGnEfb09tALnzdA7Kvv0f+B3C7vsTsV0jer77YB8ZXQ2VRB0GhSzDolOQDrkE/e9NPI5XfQjJ+5/QOnytGg3+ALh1c2t+nevisdRe99woqcNgT4MUINUASXDrvXxlAy6bJ2PrP8tehhYFSXxVmRzNyOOB/4W0Hg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PK5hx74y; arc=none smtp.client-ip=209.85.167.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PK5hx74y"
Received: by mail-oi1-f174.google.com with SMTP id 5614622812f47-3c996526c69so3468961b6e.1
        for <linux-block@vger.kernel.org>; Wed, 15 May 2024 06:21:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715779281; x=1716384081; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=aoeP0Ladk/z24yu+FttWXxEkpyrYh4P15if6ZA4rJMM=;
        b=PK5hx74yt+hDOAPct5nDFH84vrPlSwwZgUMfffDbk6URMTALoLLiSd75bToIcnnduH
         jX1RK2rJaPSDqzeXM+gZUJ9EHOe77+Xmr/r3TYRoFIlPlPIQGXapMTagyPBiZ7AzrgEK
         28pfrcGikgyXU0Ln4J8JHHKEZCqKEjNAtLAqpYjWiP6o2NchcZmVsJbwOoHifCvixq/N
         M+jhnYTBJxCV/Dl3TVbNc6oywdll2JFkRbjcAhRy7lOYBCnHCx0Oc3BHRbuigFlg2QUi
         7VkYJRYM92cb7Ml3JQZudKx8G31MJI3HArN3BHW5Fp+f7iM6nzsRYdbSXauwXJ8/6uA9
         DioQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715779281; x=1716384081;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aoeP0Ladk/z24yu+FttWXxEkpyrYh4P15if6ZA4rJMM=;
        b=JwQby0x88mOlHn6qoNk8eVJgdrtXVLPGaRMH2adRbkWmAd+ynJ7CzPJUzNDc8483S0
         +P5r8Gc2IV9lXc8SkdmpTkwycmn6CLuxKegm9vYvooJeuw3PrsjnxoV7cQ557MlDZbv9
         lRC6NYGVOpOftWE0K7/Eg4BCL6V0tsVoW7cTJkkImJDvF6CWC2zk41t/9rYhyN8EdSXx
         AhxAbiu7nd09WGDA7Fsn8GvfTfv86dnHdrj+6L+THJhYUgRN0GEblwfjD6zKu1zC2PAO
         364URmRIVTfEbcXoeZgn7VZDb4VKzmjipHPCPdCz9ylTR3nfS0Oh0tU7RqTDDmqhO5jO
         eaMQ==
X-Forwarded-Encrypted: i=1; AJvYcCV3H21MrvSRrhc08fOTgd4/jpAnKj+9UaZnaToXqhSfR3RJQN58bHsYe14XyneH/RnWr8PzV6mXKOh5ow4hd+9pMcyjxqQamKlmhVA=
X-Gm-Message-State: AOJu0YwpdKD6VOf5WXp3EcSxj+bA54lcFA0INvTbn2Oz2JufvaenDzZn
	PoFcJRn3/oKlUXPR6uIcDFS9w4VwvVflN4WJr0s9woSvyWJVp6LsCF5+pDN9ZlT75KxfcqZpFjg
	gDFI+6hrehgn3uP+J7DZKJL6tfkw9Ixiz6A8P
X-Google-Smtp-Source: AGHT+IFRMiscPqLBd2sKtTX2XDrcoODrYxZyslOWC/6aiTX3UDrj0ppSEQQFQ2h2p1mCQBzCnpgDsyOm92xKM/ENqjY=
X-Received: by 2002:a05:6808:f0c:b0:3c9:bcf1:96a8 with SMTP id
 5614622812f47-3c9bcf198b0mr2389080b6e.39.1715779280902; Wed, 15 May 2024
 06:21:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <de92101c-f9c4-4af4-95f4-19a6f59b636f@paulmck-laptop>
 <d037f37a-4722-4a1d-a282-63355a97a1a1@acm.org> <c83d9c25-b839-4e31-8dd4-85f3cb938653@paulmck-laptop>
 <4d230bac-bdb0-4a01-8006-e95156965aa8@acm.org> <447ad732-3ff8-40bf-bd82-f7be66899cee@paulmck-laptop>
 <ca7c2ef0-7e21-4fb3-ac6b-3dae652a7a0e@acm.org> <59ec96c2-52ce-4da1-92c3-9fe38053cd3d@paulmck-laptop>
 <CANpmjNMj9r1V6Z63fcJxrFC1v4i2vUCEhm1HT77ikxhx0Rghdw@mail.gmail.com>
 <dd251dba-0a63-4b57-a05b-bfa02615fae5@paulmck-laptop> <CANpmjNMqRUNUs1mZEhrOSyK0Hk+PdGOi+VAs22qYD+1zTkwfhg@mail.gmail.com>
 <ZkSvKbWj1lhGZvLE@gmail.com>
In-Reply-To: <ZkSvKbWj1lhGZvLE@gmail.com>
From: Marco Elver <elver@google.com>
Date: Wed, 15 May 2024 15:20:41 +0200
Message-ID: <CANpmjNP1ajhz5kSuJDv+go=UUvoSaQM2BVphX9LcDA9iGR5A1Q@mail.gmail.com>
Subject: Re: [PATCH] block: Annotate a racy read in blk_do_io_stat()
To: Breno Leitao <leitao@debian.org>
Cc: paulmck@kernel.org, Bart Van Assche <bvanassche@acm.org>, Jens Axboe <axboe@kernel.dk>, 
	"open list:BLOCK LAYER" <linux-block@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Wed, 15 May 2024 at 14:48, Breno Leitao <leitao@debian.org> wrote:
>
> On Wed, May 15, 2024 at 09:58:35AM +0200, Marco Elver wrote:
> > On Wed, 15 May 2024 at 01:47, Paul E. McKenney <paulmck@kernel.org> wrote:
> > > On Mon, May 13, 2024 at 10:13:49AM +0200, Marco Elver wrote:
> > > +Use of volatile and __data_racy
> > > +-------------------------------
> > > +
> > > +Adding the volatile keyword to the declaration of a variable causes both
> > > +the compiler and KCSAN to treat all reads from that variable as if they
> > > +were protected by READ_ONCE() and all writes to that variable as if they
> > > +were protected by WRITE_ONCE().
>
> > "volatile" isn't something we encourage, right? In which case, I think
> > to avoid confusion we should not mention volatile. After all we have
> > this: Documentation/process/volatile-considered-harmful.rst
>
> Since you mentioned this document, the other day I was reading
> volatile-considered-harmful.rst document, and I was surprised that there
> is no reference for READ_ONCE() primitive at all (same for WRITE_ONCE).
>
>         # grep -c READ_ONCE Documentation/process/volatile-considered-harmful.rst
>         0
>
> From my perspective, READ_ONCE() is another way of doing real memory
> read (volatile) when you really need, at the same time keeping the
> compiler free to optimize and reuse the value that was read.

The Linux kernel memory model [1] defines the semantics of READ_ONCE()
/ WRITE_ONCE(). You could say that a READ_ONCE() is something like a
"relaxed (but sometimes consume) atomic load" (in C11 lingo), and a
WRITE_ONCE() is a "relaxed atomic store". But again, not exactly
because the kernel wants to do things that are outside the C standard
and no compiler fully supports. This has fun consequences, such as
[2].

[1] https://www.open-std.org/jtc1/sc22/wg21/docs/papers/2018/p0124r6.html
[2] https://lpc.events/event/16/contributions/1174/attachments/1108/2121/Status%20Report%20-%20Broken%20Dependency%20Orderings%20in%20the%20Linux%20Kernel.pdf

To get what the kernel wants, implementing *ONCE in terms of
"volatile" works in all important cases. But we know that it can go
wrong - [2] discusses this.

The big hope is that one day, the kernel can just switch the *ONCE()
implementation to use something better but as a programmer we
shouldn't care that there's volatile underneath.

> Should volatile-considered-harmful.rst be also expanded to cover
> READ_ONCE()?

No, on most architectures READ_ONCE/WRITE_ONCE are implemented with
volatile, but that's merely an implementation detail. Once upon a
time, READ_ONCE on alpha actually implied a real barrier. On arm64
with LTO, READ_ONCE translates into an acquire-load [3] to mitigate
the risk of "volatile" actually resulting in "miscompilation"
(according to our desired semantics of READ_ONCE).

[3] https://elixir.bootlin.com/linux/latest/source/arch/arm64/include/asm/rwonce.h#L26

Thanks,
-- Marco
