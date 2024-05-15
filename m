Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56E9F15B54A;
	Wed, 15 May 2024 21:51:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715809863; cv=none; b=nQ1nm73TAUU7gxZmzO/Lafh64vECHEBMNqjtv4on8EX4306Tcknr6VcUs2q6Vfh+/ePzmc/Wo6Lgh/y1f9j3IFiJIsYSWadmwFkPaGAqmmsfP7yGq/lHeoVSIYtnyPhZdmfWYIip8kYuylGhKk26Y15knOaiGoZ1AqRGL5pNHuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715809863; c=relaxed/simple;
	bh=0DXBzG5HSOGPu4fQRLxlcEQFxW8zkEG7odaxH8d2qII=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZcdtF2cxqJTn053n4ZtIfDTVXILlc434QdYee570GZRrwIfdWRbMF8pr78TjvZHo8ImUuhks6Vg3Gq0YZpoatXUF6vjEs3phkuHmV210zABtcmrYc3cCDJmbZ+aLZVOzA2OOm1E/XLai4hNeQPSVdh0oJbK9BiC9zzFiHC+ut/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ot3QPVvo; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ot3QPVvo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DAD2FC116B1;
	Wed, 15 May 2024 21:51:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715809862;
	bh=0DXBzG5HSOGPu4fQRLxlcEQFxW8zkEG7odaxH8d2qII=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=ot3QPVvoXLBcRKW7d9jOH3R8j7cAacPPDYyldX5dqeswn6MW/we1wkXIo5cuzNMoi
	 iutcCb2oFNiqpfdivDd/OTuUg8O57U/Z5PRbOtc8b8rTFuMUX9DPAbhesqs8bnYtqV
	 R9rgNQ/qpjmRGdu1U5TQ/Ak8a1yV4tH5918yL1qYv3V9Hf4oPYERgXIR1bUvnH9oSh
	 eizYQrM+siWNWZtQsSneCKw9APMtsYCLkUcPxjOLCzn5KuJC8+Xy4R7dR/mUGvgjA2
	 GWqhNuFuKN89NVJJMWtXhnisI0Py/npkiRSh1wOXKbde8+x5FdOVHG4eF80TxEtb37
	 WakY5VW+QmsTQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 2F22ACE0DEC; Wed, 15 May 2024 14:51:02 -0700 (PDT)
Date: Wed, 15 May 2024 14:51:02 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Marco Elver <elver@google.com>
Cc: Bart Van Assche <bvanassche@acm.org>, Breno Leitao <leitao@debian.org>,
	Jens Axboe <axboe@kernel.dk>,
	"open list:BLOCK LAYER" <linux-block@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] block: Annotate a racy read in blk_do_io_stat()
Message-ID: <d9df8351-7cc2-4562-a8b5-440344bfeb91@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <c83d9c25-b839-4e31-8dd4-85f3cb938653@paulmck-laptop>
 <4d230bac-bdb0-4a01-8006-e95156965aa8@acm.org>
 <447ad732-3ff8-40bf-bd82-f7be66899cee@paulmck-laptop>
 <ca7c2ef0-7e21-4fb3-ac6b-3dae652a7a0e@acm.org>
 <59ec96c2-52ce-4da1-92c3-9fe38053cd3d@paulmck-laptop>
 <CANpmjNMj9r1V6Z63fcJxrFC1v4i2vUCEhm1HT77ikxhx0Rghdw@mail.gmail.com>
 <dd251dba-0a63-4b57-a05b-bfa02615fae5@paulmck-laptop>
 <CANpmjNMqRUNUs1mZEhrOSyK0Hk+PdGOi+VAs22qYD+1zTkwfhg@mail.gmail.com>
 <75421237-4c5a-48bc-849e-87a216ee9d32@paulmck-laptop>
 <CANpmjNM-Cg12qCU3WoLeBboogLQVgn4znFerRwD3BVAFMc9BiQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANpmjNM-Cg12qCU3WoLeBboogLQVgn4znFerRwD3BVAFMc9BiQ@mail.gmail.com>

On Wed, May 15, 2024 at 07:40:08PM +0200, Marco Elver wrote:
> On Wed, 15 May 2024 at 17:57, Paul E. McKenney <paulmck@kernel.org> wrote:
> > On Wed, May 15, 2024 at 09:58:35AM +0200, Marco Elver wrote:
> > > On Wed, 15 May 2024 at 01:47, Paul E. McKenney <paulmck@kernel.org> wrote:
> > > > On Mon, May 13, 2024 at 10:13:49AM +0200, Marco Elver wrote:
> > > > > On Sat, 11 May 2024 at 02:41, Paul E. McKenney <paulmck@kernel.org> wrote:
> > > > > [...]
> > > > > > ------------------------------------------------------------------------
> > > > > >
> > > > > > commit 930cb5f711443d8044e88080ee21b0a5edda33bd
> > > > > > Author: Paul E. McKenney <paulmck@kernel.org>
> > > > > > Date:   Fri May 10 15:36:57 2024 -0700
> > > > > >
> > > > > >     kcsan: Add example to data_race() kerneldoc header
> > > > > >
> > > > > >     Although the data_race() kerneldoc header accurately states what it does,
> > > > > >     some of the implications and usage patterns are non-obvious.  Therefore,
> > > > > >     add a brief locking example and also state how to have KCSAN ignore
> > > > > >     accesses while also preventing the compiler from folding, spindling,
> > > > > >     or otherwise mutilating the access.
> > > > > >
> > > > > >     [ paulmck: Apply Bart Van Assche feedback. ]
> > > > > >
> > > > > >     Reported-by: Bart Van Assche <bvanassche@acm.org>
> > > > > >     Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> > > > > >     Cc: Marco Elver <elver@google.com>
> > > > > >     Cc: Breno Leitao <leitao@debian.org>
> > > > > >     Cc: Jens Axboe <axboe@kernel.dk>
> > > > > >
> > > > > > diff --git a/include/linux/compiler.h b/include/linux/compiler.h
> > > > > > index c00cc6c0878a1..9249768ec7a26 100644
> > > > > > --- a/include/linux/compiler.h
> > > > > > +++ b/include/linux/compiler.h
> > > > > > @@ -194,9 +194,17 @@ void ftrace_likely_update(struct ftrace_likely_data *f, int val,
> > > > > >   * This data_race() macro is useful for situations in which data races
> > > > > >   * should be forgiven.  One example is diagnostic code that accesses
> > > > > >   * shared variables but is not a part of the core synchronization design.
> > > > > > + * For example, if accesses to a given variable are protected by a lock,
> > > > > > + * except for diagnostic code, then the accesses under the lock should
> > > > > > + * be plain C-language accesses and those in the diagnostic code should
> > > > > > + * use data_race().  This way, KCSAN will complain if buggy lockless
> > > > > > + * accesses to that variable are introduced, even if the buggy accesses
> > > > > > + * are protected by READ_ONCE() or WRITE_ONCE().
> > > > > >   *
> > > > > > - * This macro *does not* affect normal code generation, but is a hint
> > > > > > - * to tooling that data races here are to be ignored.
> > > > > > + * This macro *does not* affect normal code generation, but is a hint to
> > > > > > + * tooling that data races here are to be ignored.  If code generation must
> > > > > > + * be protected *and* KCSAN should ignore the access, use both data_race()
> > > > >
> > > > > "code generation must be protected" seems ambiguous, because
> > > > > protecting code generation could mean a lot of different things to
> > > > > different people.
> > > > >
> > > > > The more precise thing would be to write that "If the access must be
> > > > > atomic *and* KCSAN should ignore the access, use both ...".
> > > >
> > > > Good point, and I took your wording, thank you.
> > > >
> > > > > I've also had trouble in the past referring to "miscompilation" or
> > > > > similar, because that also entirely depends on the promised vs.
> > > > > expected semantics: if the code in question assumes for the access to
> > > > > be atomic, the compiler compiling the code in a way that the access is
> > > > > no longer atomic would be a "miscompilation". Although is it still a
> > > > > "miscompilation" if the compiler generated code according to specified
> > > > > language semantics (say according to our own LKMM) - and that's where
> > > > > opinions can diverge because it depends on which side we stand
> > > > > (compiler vs. our code).
> > > >
> > > > Agreed, use of words like "miscompilation" can annoy people.  What
> > > > word would you suggest using instead?
> > >
> > > Not sure. As suggested above, I try to just stick to "atomic" vs
> > > "non-atomic" because that's ultimately the functional end result of
> > > such a miscompilation. Although I've also had people be confused as in
> > > "what atomic?! as in atomic RMW?!", but I don't know how to remove
> > > that kind of confusion.
> > >
> > > If, however, our intended model is the LKMM and e.g. a compiler breaks
> > > a dependency-chain, then we could talk about miscompilation, because
> > > the compiler violates our desired language semantics. Of course the
> > > compiler writers then will say that we try to do things that are
> > > outside any implemented language semantics the compiler is aware of,
> > > so it's not a miscompilation again. So it all depends on which side
> > > we're arguing for. Fun times.
> >
> > ;-) ;-) ;-)
> >
> > > > > > + * and READ_ONCE(), for example, data_race(READ_ONCE(x)).
> > > > >
> > > > > Having more documentation sounds good to me, thanks for adding!
> > > > >
> > > > > This extra bit of documentation also exists in a longer form in
> > > > > access-marking.txt, correct? I wonder how it would be possible to
> > > > > refer to it, in case the reader wants to learn even more.
> > > >
> > > > Good point, especially given that I had forgotten about it.
> > > >
> > > > I don't have any immediate ideas for calling attention to this file,
> > > > but would the following update be helpful?
> > >
> > > Mentioning __data_racy along with data_race() could be helpful, thank
> > > you. See comments below.
> >
> > I did add a mention of it in "Linux-Kernel RCU Shared-Variable Marking"
> > [1], but just a mention, given that I do not expect that we will use it
> > within RCU.
> >
> > > Thanks,
> > > -- Marco
> > >
> > > >                                                         Thanx, Paul
> > > >
> > > > ------------------------------------------------------------------------
> > > >
> > > > diff --git a/tools/memory-model/Documentation/access-marking.txt b/tools/memory-model/Documentation/access-marking.txt
> > > > index 65778222183e3..690dd59b7ac59 100644
> > > > --- a/tools/memory-model/Documentation/access-marking.txt
> > > > +++ b/tools/memory-model/Documentation/access-marking.txt
> > > > @@ -24,6 +24,12 @@ The Linux kernel provides the following access-marking options:
> > > >  4.     WRITE_ONCE(), for example, "WRITE_ONCE(a, b);"
> > > >         The various forms of atomic_set() also fit in here.
> > > >
> > > > +5.     ASSERT_EXCLUSIVE_ACCESS() and ASSERT_EXCLUSIVE_WRITER().
> > >
> > > Perhaps worth mentioning, but they aren't strictly access-marking
> > > options. In the interest of simplicity could leave it out.
> >
> > Interestingly enough, they can be said to be implicitly marking other
> > concurrent accesses to the variable.  ;-)
> 
> The document starts with "guidelines for marking intentionally
> concurrent normal accesses to shared memory".  The ASSERT_EXCLUSIVE
> macros do capture more of the concurrency rules, and perhaps they
> could be seen as some kind of "negative marking" where concurrent
> access should _not_ happen concurrently with these. But I'm still not
> convinced it's the same kind of marking the document introduces.
> 
> I always considered them in the realm of general assertions that we
> can just use to tell the tool more than can be inferred from the bits
> of C code required for the functional implementation of whatever we're
> doing.
> 
> > I believe that the do need to be mentioned more prominently, though.
> >
> > Maybe a second list following this one?  In that case, what do we name
> > the list?  I suppose the other alternative would be to leave them in
> > this list, and change the preceding sentence to say something like
> > "The Linux kernel provides the following access-marking-related primitives"
> >
> > Thoughts?
> 
> And I just checked the current access-marking.txt to see where we
> might add more, and found the section "ACCESS-DOCUMENTATION OPTIONS"
> already exists. I think that section is perfectly reasonable as is,
> and it does explicitly talk about ASSERT_EXCLUSIVE* macros.
> 
> Did you want to add it more prominently at the top? If so, maybe a
> brief forward-reference to that section might be helpful.

How about like this?

------------------------------------------------------------------------

The Linux kernel provides the following access-marking options:

1.	Plain C-language accesses (unmarked), for example, "a = b;"

2.	Data-race marking, for example, "data_race(a = b);"

3.	READ_ONCE(), for example, "a = READ_ONCE(b);"
	The various forms of atomic_read() also fit in here.

4.	WRITE_ONCE(), for example, "WRITE_ONCE(a, b);"
	The various forms of atomic_set() also fit in here.

5.	__data_racy, for example "int __data_racy a;"

6.	KCSAN's negative-marking assertions, ASSERT_EXCLUSIVE_ACCESS()
	and ASSERT_EXCLUSIVE_WRITER(), are desccribed in the
	"ACCESS-DOCUMENTATION OPTIONS" section below.

------------------------------------------------------------------------

Would that work?

							Thanx, Paul
