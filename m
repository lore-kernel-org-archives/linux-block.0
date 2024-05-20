Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7C4A34CDE;
	Mon, 20 May 2024 18:05:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716228332; cv=none; b=mIJ//TCFRfpt/Llr38CVwipUOWy5fq9vMLc5BefbH1PHWfNDn/7j3KuMGdKQHp3ypArrC+CzCpJ1ZFllVpPaHil+DRE+K71OUoDER9EXLeij0pTkimvD2j7y8EirfAZDncEhj04aOymOhRq2pwfsvgGhXi4ZvO7qhXxBk0RmohU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716228332; c=relaxed/simple;
	bh=fe0UcvX4RKyP+54gpQ64qZRY1cISErxtCFj+FyCrqVI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g7DicqGJSnGYwV1rTE5YVnXKomnOToSijEg8urYpzNW3MFtI8APIpwFVxGmgFV+x5AxYdvb94Q+OHYcdwQw/5JeF2ZHlRQPzR+B7B0dIzvn4ZLWfocTEHcxhkyIZ2Dp1KBlBAqa09+82JuWGXb5uD1J7Mxc+/CH1qxOdKPz0F3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tDnSfZn9; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tDnSfZn9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E39CC2BD10;
	Mon, 20 May 2024 18:05:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716228332;
	bh=fe0UcvX4RKyP+54gpQ64qZRY1cISErxtCFj+FyCrqVI=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=tDnSfZn9+DolgC7qHMN7wdeEtzOqkgm1iuWyrvbwsBvH504JRpoeSIo+vcrSGLEFP
	 3AaGTl2kjDBQdfszqrGVp9DxG4fUCp5ivs54FeOZ9fCoMTOgnGkhQj3qwq0FmoErQY
	 duP5ZS3JxGW1X/UzybA8+VswOAV98w5oJ6mxwLOGnY09pn9r5iR9DWMwTMm5yKJ7it
	 ENxht2fwRbFM98LBRPI8CeD7tnyfrlNu2z54wTy43qMqjD0AACt16kDXGqEK4ixjc4
	 cJzHX7mU1xtHn7UaAaXNwrz5QuM7vyIfM9bqKW7OzO3IfrDLOKKMqJTFdaIbq/KapC
	 idGAeS01yhWZg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id EAE9DCE0C3C; Mon, 20 May 2024 11:05:31 -0700 (PDT)
Date: Mon, 20 May 2024 11:05:31 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Marco Elver <elver@google.com>
Cc: Bart Van Assche <bvanassche@acm.org>, Breno Leitao <leitao@debian.org>,
	Jens Axboe <axboe@kernel.dk>,
	"open list:BLOCK LAYER" <linux-block@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] block: Annotate a racy read in blk_do_io_stat()
Message-ID: <14bb1b20-b03c-45c1-9566-9287eee23c54@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <447ad732-3ff8-40bf-bd82-f7be66899cee@paulmck-laptop>
 <ca7c2ef0-7e21-4fb3-ac6b-3dae652a7a0e@acm.org>
 <59ec96c2-52ce-4da1-92c3-9fe38053cd3d@paulmck-laptop>
 <CANpmjNMj9r1V6Z63fcJxrFC1v4i2vUCEhm1HT77ikxhx0Rghdw@mail.gmail.com>
 <dd251dba-0a63-4b57-a05b-bfa02615fae5@paulmck-laptop>
 <CANpmjNMqRUNUs1mZEhrOSyK0Hk+PdGOi+VAs22qYD+1zTkwfhg@mail.gmail.com>
 <75421237-4c5a-48bc-849e-87a216ee9d32@paulmck-laptop>
 <CANpmjNM-Cg12qCU3WoLeBboogLQVgn4znFerRwD3BVAFMc9BiQ@mail.gmail.com>
 <d9df8351-7cc2-4562-a8b5-440344bfeb91@paulmck-laptop>
 <CANpmjNO+WDF804s49VdCf2=3io5Uh=8ZbM_jiW5j1rcbcONbUA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANpmjNO+WDF804s49VdCf2=3io5Uh=8ZbM_jiW5j1rcbcONbUA@mail.gmail.com>

On Thu, May 16, 2024 at 08:35:02AM +0200, Marco Elver wrote:
> On Wed, 15 May 2024 at 23:51, Paul E. McKenney <paulmck@kernel.org> wrote:
> [...]
> > > And I just checked the current access-marking.txt to see where we
> > > might add more, and found the section "ACCESS-DOCUMENTATION OPTIONS"
> > > already exists. I think that section is perfectly reasonable as is,
> > > and it does explicitly talk about ASSERT_EXCLUSIVE* macros.
> > >
> > > Did you want to add it more prominently at the top? If so, maybe a
> > > brief forward-reference to that section might be helpful.
> >
> > How about like this?
> >
> > ------------------------------------------------------------------------
> >
> > The Linux kernel provides the following access-marking options:
> >
> > 1.      Plain C-language accesses (unmarked), for example, "a = b;"
> >
> > 2.      Data-race marking, for example, "data_race(a = b);"
> >
> > 3.      READ_ONCE(), for example, "a = READ_ONCE(b);"
> >         The various forms of atomic_read() also fit in here.
> >
> > 4.      WRITE_ONCE(), for example, "WRITE_ONCE(a, b);"
> >         The various forms of atomic_set() also fit in here.
> >
> > 5.      __data_racy, for example "int __data_racy a;"
> >
> > 6.      KCSAN's negative-marking assertions, ASSERT_EXCLUSIVE_ACCESS()
> >         and ASSERT_EXCLUSIVE_WRITER(), are desccribed in the
> >         "ACCESS-DOCUMENTATION OPTIONS" section below.
> 
> s/desccribed/described/

Good eyes, fixed!

> > ------------------------------------------------------------------------
> >
> > Would that work?
> 
> It works for me, if we agree that "negative marking" makes sense: if
> the other markings indicate the access is happening concurrently with
> others, a negative marking does the opposite.

Very good, I will send this out shortly after v6.10-rc1 comes out and
let's see where the bikeshedding leads.  ;-)

							Thanx, Paul
