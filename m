Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F2CD155723;
	Wed, 15 May 2024 15:57:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715788665; cv=none; b=Yuti7alAqO3uhpkY19D5E42CMh7kLwy0EspwvO5KzQfj6WQeYI0B+Q5ke3GkUSZSiXq80GEeciJSTa5iJmKnJXynjZ4dvOurBi49Cl+oIGrPFsxa+HzuuWTanyQuaQWS/i9z2nFklfrMOt+19xVdxPbjoaRs/A7Jg2ARBzmoz9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715788665; c=relaxed/simple;
	bh=3Ksx8gj3Hc4Bol620FloWNAz8V3sPL8VH+OdOADSaBI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ecRen81ki0MG753ivxEFqE0XAhzYnZMF6K+cZQb1muqhhFiP9SIXab0YeXQEGaZE/pSslUbxTHi9bA+mAuRBs2DAFxbi4G3/NFQ8pa6KDWIKfiNDGNqfXRSY6m8HMWnqzx1oLZob/BgiCXAxLkQ0SRSUTiWsPwkmZwydklH4EXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E7zSR5Xk; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E7zSR5Xk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDFABC116B1;
	Wed, 15 May 2024 15:57:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715788664;
	bh=3Ksx8gj3Hc4Bol620FloWNAz8V3sPL8VH+OdOADSaBI=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=E7zSR5XkxswZAtso5HWWHvZwd1zOkzfKb1GRWtxHSNXE0AWWgNUO/MhLSX9/G3jrV
	 J8xRTc3YdmEG2q+0uX4gCvVVO+hkqErl0+lDhP2AJwL5oP0FnZ8OKfMOBBi27zpBkT
	 X+CsPYcjtX4He0Q614suhzxXwb8R7aaMh5iAvQ8I2ngOjJTdc8yhraK7wbFAlse7yD
	 mglug1+Itxggt1GZHWckJfoaxvZUfDsC1bTWlo0fIRQqJgfzA7EmCt1OwneltnZiDM
	 mLdY/T6w0Rfu91Frnsu6Af5ydewY3V0f0Cehvxh5c9yg/0uwkuIdhsXEIY169bcjJ/
	 bSkrH3AGHI7hg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 2F1D1CE098A; Wed, 15 May 2024 08:57:44 -0700 (PDT)
Date: Wed, 15 May 2024 08:57:44 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Marco Elver <elver@google.com>
Cc: Bart Van Assche <bvanassche@acm.org>, Breno Leitao <leitao@debian.org>,
	Jens Axboe <axboe@kernel.dk>,
	"open list:BLOCK LAYER" <linux-block@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] block: Annotate a racy read in blk_do_io_stat()
Message-ID: <75421237-4c5a-48bc-849e-87a216ee9d32@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <de92101c-f9c4-4af4-95f4-19a6f59b636f@paulmck-laptop>
 <d037f37a-4722-4a1d-a282-63355a97a1a1@acm.org>
 <c83d9c25-b839-4e31-8dd4-85f3cb938653@paulmck-laptop>
 <4d230bac-bdb0-4a01-8006-e95156965aa8@acm.org>
 <447ad732-3ff8-40bf-bd82-f7be66899cee@paulmck-laptop>
 <ca7c2ef0-7e21-4fb3-ac6b-3dae652a7a0e@acm.org>
 <59ec96c2-52ce-4da1-92c3-9fe38053cd3d@paulmck-laptop>
 <CANpmjNMj9r1V6Z63fcJxrFC1v4i2vUCEhm1HT77ikxhx0Rghdw@mail.gmail.com>
 <dd251dba-0a63-4b57-a05b-bfa02615fae5@paulmck-laptop>
 <CANpmjNMqRUNUs1mZEhrOSyK0Hk+PdGOi+VAs22qYD+1zTkwfhg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANpmjNMqRUNUs1mZEhrOSyK0Hk+PdGOi+VAs22qYD+1zTkwfhg@mail.gmail.com>

On Wed, May 15, 2024 at 09:58:35AM +0200, Marco Elver wrote:
> On Wed, 15 May 2024 at 01:47, Paul E. McKenney <paulmck@kernel.org> wrote:
> > On Mon, May 13, 2024 at 10:13:49AM +0200, Marco Elver wrote:
> > > On Sat, 11 May 2024 at 02:41, Paul E. McKenney <paulmck@kernel.org> wrote:
> > > [...]
> > > > ------------------------------------------------------------------------
> > > >
> > > > commit 930cb5f711443d8044e88080ee21b0a5edda33bd
> > > > Author: Paul E. McKenney <paulmck@kernel.org>
> > > > Date:   Fri May 10 15:36:57 2024 -0700
> > > >
> > > >     kcsan: Add example to data_race() kerneldoc header
> > > >
> > > >     Although the data_race() kerneldoc header accurately states what it does,
> > > >     some of the implications and usage patterns are non-obvious.  Therefore,
> > > >     add a brief locking example and also state how to have KCSAN ignore
> > > >     accesses while also preventing the compiler from folding, spindling,
> > > >     or otherwise mutilating the access.
> > > >
> > > >     [ paulmck: Apply Bart Van Assche feedback. ]
> > > >
> > > >     Reported-by: Bart Van Assche <bvanassche@acm.org>
> > > >     Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> > > >     Cc: Marco Elver <elver@google.com>
> > > >     Cc: Breno Leitao <leitao@debian.org>
> > > >     Cc: Jens Axboe <axboe@kernel.dk>
> > > >
> > > > diff --git a/include/linux/compiler.h b/include/linux/compiler.h
> > > > index c00cc6c0878a1..9249768ec7a26 100644
> > > > --- a/include/linux/compiler.h
> > > > +++ b/include/linux/compiler.h
> > > > @@ -194,9 +194,17 @@ void ftrace_likely_update(struct ftrace_likely_data *f, int val,
> > > >   * This data_race() macro is useful for situations in which data races
> > > >   * should be forgiven.  One example is diagnostic code that accesses
> > > >   * shared variables but is not a part of the core synchronization design.
> > > > + * For example, if accesses to a given variable are protected by a lock,
> > > > + * except for diagnostic code, then the accesses under the lock should
> > > > + * be plain C-language accesses and those in the diagnostic code should
> > > > + * use data_race().  This way, KCSAN will complain if buggy lockless
> > > > + * accesses to that variable are introduced, even if the buggy accesses
> > > > + * are protected by READ_ONCE() or WRITE_ONCE().
> > > >   *
> > > > - * This macro *does not* affect normal code generation, but is a hint
> > > > - * to tooling that data races here are to be ignored.
> > > > + * This macro *does not* affect normal code generation, but is a hint to
> > > > + * tooling that data races here are to be ignored.  If code generation must
> > > > + * be protected *and* KCSAN should ignore the access, use both data_race()
> > >
> > > "code generation must be protected" seems ambiguous, because
> > > protecting code generation could mean a lot of different things to
> > > different people.
> > >
> > > The more precise thing would be to write that "If the access must be
> > > atomic *and* KCSAN should ignore the access, use both ...".
> >
> > Good point, and I took your wording, thank you.
> >
> > > I've also had trouble in the past referring to "miscompilation" or
> > > similar, because that also entirely depends on the promised vs.
> > > expected semantics: if the code in question assumes for the access to
> > > be atomic, the compiler compiling the code in a way that the access is
> > > no longer atomic would be a "miscompilation". Although is it still a
> > > "miscompilation" if the compiler generated code according to specified
> > > language semantics (say according to our own LKMM) - and that's where
> > > opinions can diverge because it depends on which side we stand
> > > (compiler vs. our code).
> >
> > Agreed, use of words like "miscompilation" can annoy people.  What
> > word would you suggest using instead?
> 
> Not sure. As suggested above, I try to just stick to "atomic" vs
> "non-atomic" because that's ultimately the functional end result of
> such a miscompilation. Although I've also had people be confused as in
> "what atomic?! as in atomic RMW?!", but I don't know how to remove
> that kind of confusion.
> 
> If, however, our intended model is the LKMM and e.g. a compiler breaks
> a dependency-chain, then we could talk about miscompilation, because
> the compiler violates our desired language semantics. Of course the
> compiler writers then will say that we try to do things that are
> outside any implemented language semantics the compiler is aware of,
> so it's not a miscompilation again. So it all depends on which side
> we're arguing for. Fun times.

;-) ;-) ;-)

> > > > + * and READ_ONCE(), for example, data_race(READ_ONCE(x)).
> > >
> > > Having more documentation sounds good to me, thanks for adding!
> > >
> > > This extra bit of documentation also exists in a longer form in
> > > access-marking.txt, correct? I wonder how it would be possible to
> > > refer to it, in case the reader wants to learn even more.
> >
> > Good point, especially given that I had forgotten about it.
> >
> > I don't have any immediate ideas for calling attention to this file,
> > but would the following update be helpful?
> 
> Mentioning __data_racy along with data_race() could be helpful, thank
> you. See comments below.

I did add a mention of it in "Linux-Kernel RCU Shared-Variable Marking"
[1], but just a mention, given that I do not expect that we will use it
within RCU.

> Thanks,
> -- Marco
> 
> >                                                         Thanx, Paul
> >
> > ------------------------------------------------------------------------
> >
> > diff --git a/tools/memory-model/Documentation/access-marking.txt b/tools/memory-model/Documentation/access-marking.txt
> > index 65778222183e3..690dd59b7ac59 100644
> > --- a/tools/memory-model/Documentation/access-marking.txt
> > +++ b/tools/memory-model/Documentation/access-marking.txt
> > @@ -24,6 +24,12 @@ The Linux kernel provides the following access-marking options:
> >  4.     WRITE_ONCE(), for example, "WRITE_ONCE(a, b);"
> >         The various forms of atomic_set() also fit in here.
> >
> > +5.     ASSERT_EXCLUSIVE_ACCESS() and ASSERT_EXCLUSIVE_WRITER().
> 
> Perhaps worth mentioning, but they aren't strictly access-marking
> options. In the interest of simplicity could leave it out.

Interestingly enough, they can be said to be implicitly marking other
concurrent accesses to the variable.  ;-)

I believe that the do need to be mentioned more prominently, though.

Maybe a second list following this one?  In that case, what do we name
the list?  I suppose the other alternative would be to leave them in
this list, and change the preceding sentence to say something like
"The Linux kernel provides the following access-marking-related primitives"

Thoughts?

> > +6.     The volatile keyword, for example, "int volatile a;"
> 
> See below - I'm not sure we should mention volatile. It may set the
> wrong example.

Good point.  I removed this item from this list.

> > +7.     __data_racy, for example "int __data_racy a;"
> > +
> >
> >  These may be used in combination, as shown in this admittedly improbable
> >  example:
> > @@ -205,6 +211,27 @@ because doing otherwise prevents KCSAN from detecting violations of your
> >  code's synchronization rules.
> >
> >
> > +Use of volatile and __data_racy
> > +-------------------------------
> > +
> > +Adding the volatile keyword to the declaration of a variable causes both
> > +the compiler and KCSAN to treat all reads from that variable as if they
> > +were protected by READ_ONCE() and all writes to that variable as if they
> > +were protected by WRITE_ONCE().
> 
> "volatile" isn't something we encourage, right? In which case, I think
> to avoid confusion we should not mention volatile. After all we have
> this: Documentation/process/volatile-considered-harmful.rst

Good point, I removed this paragraph.  But we do sometimes use volatile,
for example for atomic_t and jiffies.  Nevertheless, agreed, we don't
want to encourage it and additions of this keyword should be subjected
to serious scrutiny.

> > +Adding the __data_racy type qualifier to the declaration of a variable
> > +causes KCSAN to treat all accesses to that variable as if they were
> > +enclosed by data_race().  However, __data_racy does not affect the
> > +compiler, though one could imagine hardened kernel builds treating the
> > +__data_racy type qualifier as if it was the volatile keyword.
> > +
> > +Note well that __data_racy is subject to the same pointer-declaration
> > +rules as is the volatile keyword.  For example:
> 
> To avoid referring to volatile could make it more general and say "..
> rules as other type qualifiers like const and volatile".

Very good, thank you!  I happily took your wording.

							Thanx, Paul

> > +       int __data_racy *p; // Pointer to data-racy data.
> > +       int *__data_racy p; // Data-racy pointer to non-data-racy data.
> > +
> > +
> >  ACCESS-DOCUMENTATION OPTIONS
> >  ============================
> >
> > @@ -342,7 +369,7 @@ as follows:
> >
> >  Because foo is read locklessly, all accesses are marked.  The purpose
> >  of the ASSERT_EXCLUSIVE_WRITER() is to allow KCSAN to check for a buggy
> > -concurrent lockless write.
> > +concurrent write, whether marked or not.
> >
> >
> >  Lock-Protected Writes With Heuristic Lockless Reads
