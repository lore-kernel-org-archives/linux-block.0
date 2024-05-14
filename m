Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EEB81E491;
	Tue, 14 May 2024 23:47:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715730447; cv=none; b=JgG5IZ4svv61c2hDDwq4FsTPp0S4jmk8DwsShHWXQuZ3cN6RGxqQde25V6s8dwG1Id+2r1ij8hSQQD4m+r1NAqHfRsaRJFrlKoHjIk42fdghxHyR3dRWnMlSHudZ1UH/7qOtUc3vtl7qm71L2K33j6gBWNG5ROILI0LimzLxb10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715730447; c=relaxed/simple;
	bh=o4JgtoyEfkU/Yd1SUDt14xVTJSlfqvyOqiOw5VQG7/0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OdoFuJoTSdGBJ4tABYYFyLTwKtXcFsy59uwgreSnFx00S70DPvDW24Bq5wgIrIsnzhOOLfkSN8dSV4f8Y5YnWDirgtiGWTdn3Jr4Z1XRYUhouPS0hhhlaDh8jYKxfne+Tu/Z/6EcKJYkEYhiDpcxYIiGDIWNHdUTRCNXx8KGBps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fEqx0/Ld; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fEqx0/Ld"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54F3DC2BD10;
	Tue, 14 May 2024 23:47:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715730446;
	bh=o4JgtoyEfkU/Yd1SUDt14xVTJSlfqvyOqiOw5VQG7/0=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=fEqx0/Ld3CgEOSgmJ7Z6qkwX8v/vX6lnyWZSCIIzlxyXFWuljqPLYD6qhFEAhPw1D
	 Lb8veeJshWrPcMZhGi7y++JT0PJiHHGwHL0WpxXht1onot6zQhqfKZhbItKiN+Ztyx
	 oXnKJeN3kFfWHr5P1Cionpx7K0YA1ODVUJVPVDfIVMvYtPvqvpe+9YUlDVpn4PSiSa
	 SsZaB4WPE6++/usvGoe/bOk6iM6XYlXn7dmsxupmypl4QjqURd9b3M1cMIH/vI9OLA
	 7Bz3FZxx1ly1+qv0tzlPg43i3COuwbWnvB9v3yehxEelsUa0vBzKCYEV3V3VvJmnuZ
	 GeZ7/XwTuNw9w==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id B82F0CE0481; Tue, 14 May 2024 16:47:20 -0700 (PDT)
Date: Tue, 14 May 2024 16:47:20 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Marco Elver <elver@google.com>
Cc: Bart Van Assche <bvanassche@acm.org>, Breno Leitao <leitao@debian.org>,
	Jens Axboe <axboe@kernel.dk>,
	"open list:BLOCK LAYER" <linux-block@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] block: Annotate a racy read in blk_do_io_stat()
Message-ID: <dd251dba-0a63-4b57-a05b-bfa02615fae5@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20240510141921.883231-1-leitao@debian.org>
 <ef8c5f6d-17e3-4504-8560-b970912b9eae@acm.org>
 <de92101c-f9c4-4af4-95f4-19a6f59b636f@paulmck-laptop>
 <d037f37a-4722-4a1d-a282-63355a97a1a1@acm.org>
 <c83d9c25-b839-4e31-8dd4-85f3cb938653@paulmck-laptop>
 <4d230bac-bdb0-4a01-8006-e95156965aa8@acm.org>
 <447ad732-3ff8-40bf-bd82-f7be66899cee@paulmck-laptop>
 <ca7c2ef0-7e21-4fb3-ac6b-3dae652a7a0e@acm.org>
 <59ec96c2-52ce-4da1-92c3-9fe38053cd3d@paulmck-laptop>
 <CANpmjNMj9r1V6Z63fcJxrFC1v4i2vUCEhm1HT77ikxhx0Rghdw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANpmjNMj9r1V6Z63fcJxrFC1v4i2vUCEhm1HT77ikxhx0Rghdw@mail.gmail.com>

On Mon, May 13, 2024 at 10:13:49AM +0200, Marco Elver wrote:
> On Sat, 11 May 2024 at 02:41, Paul E. McKenney <paulmck@kernel.org> wrote:
> [...]
> > ------------------------------------------------------------------------
> >
> > commit 930cb5f711443d8044e88080ee21b0a5edda33bd
> > Author: Paul E. McKenney <paulmck@kernel.org>
> > Date:   Fri May 10 15:36:57 2024 -0700
> >
> >     kcsan: Add example to data_race() kerneldoc header
> >
> >     Although the data_race() kerneldoc header accurately states what it does,
> >     some of the implications and usage patterns are non-obvious.  Therefore,
> >     add a brief locking example and also state how to have KCSAN ignore
> >     accesses while also preventing the compiler from folding, spindling,
> >     or otherwise mutilating the access.
> >
> >     [ paulmck: Apply Bart Van Assche feedback. ]
> >
> >     Reported-by: Bart Van Assche <bvanassche@acm.org>
> >     Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> >     Cc: Marco Elver <elver@google.com>
> >     Cc: Breno Leitao <leitao@debian.org>
> >     Cc: Jens Axboe <axboe@kernel.dk>
> >
> > diff --git a/include/linux/compiler.h b/include/linux/compiler.h
> > index c00cc6c0878a1..9249768ec7a26 100644
> > --- a/include/linux/compiler.h
> > +++ b/include/linux/compiler.h
> > @@ -194,9 +194,17 @@ void ftrace_likely_update(struct ftrace_likely_data *f, int val,
> >   * This data_race() macro is useful for situations in which data races
> >   * should be forgiven.  One example is diagnostic code that accesses
> >   * shared variables but is not a part of the core synchronization design.
> > + * For example, if accesses to a given variable are protected by a lock,
> > + * except for diagnostic code, then the accesses under the lock should
> > + * be plain C-language accesses and those in the diagnostic code should
> > + * use data_race().  This way, KCSAN will complain if buggy lockless
> > + * accesses to that variable are introduced, even if the buggy accesses
> > + * are protected by READ_ONCE() or WRITE_ONCE().
> >   *
> > - * This macro *does not* affect normal code generation, but is a hint
> > - * to tooling that data races here are to be ignored.
> > + * This macro *does not* affect normal code generation, but is a hint to
> > + * tooling that data races here are to be ignored.  If code generation must
> > + * be protected *and* KCSAN should ignore the access, use both data_race()
> 
> "code generation must be protected" seems ambiguous, because
> protecting code generation could mean a lot of different things to
> different people.
> 
> The more precise thing would be to write that "If the access must be
> atomic *and* KCSAN should ignore the access, use both ...".

Good point, and I took your wording, thank you.

> I've also had trouble in the past referring to "miscompilation" or
> similar, because that also entirely depends on the promised vs.
> expected semantics: if the code in question assumes for the access to
> be atomic, the compiler compiling the code in a way that the access is
> no longer atomic would be a "miscompilation". Although is it still a
> "miscompilation" if the compiler generated code according to specified
> language semantics (say according to our own LKMM) - and that's where
> opinions can diverge because it depends on which side we stand
> (compiler vs. our code).

Agreed, use of words like "miscompilation" can annoy people.  What
word would you suggest using instead?

> > + * and READ_ONCE(), for example, data_race(READ_ONCE(x)).
> 
> Having more documentation sounds good to me, thanks for adding!
> 
> This extra bit of documentation also exists in a longer form in
> access-marking.txt, correct? I wonder how it would be possible to
> refer to it, in case the reader wants to learn even more.

Good point, especially given that I had forgotten about it.

I don't have any immediate ideas for calling attention to this file,
but would the following update be helpful?

							Thanx, Paul

------------------------------------------------------------------------

diff --git a/tools/memory-model/Documentation/access-marking.txt b/tools/memory-model/Documentation/access-marking.txt
index 65778222183e3..690dd59b7ac59 100644
--- a/tools/memory-model/Documentation/access-marking.txt
+++ b/tools/memory-model/Documentation/access-marking.txt
@@ -24,6 +24,12 @@ The Linux kernel provides the following access-marking options:
 4.	WRITE_ONCE(), for example, "WRITE_ONCE(a, b);"
 	The various forms of atomic_set() also fit in here.
 
+5.	ASSERT_EXCLUSIVE_ACCESS() and ASSERT_EXCLUSIVE_WRITER().
+
+6.	The volatile keyword, for example, "int volatile a;"
+
+7.	__data_racy, for example "int __data_racy a;"
+
 
 These may be used in combination, as shown in this admittedly improbable
 example:
@@ -205,6 +211,27 @@ because doing otherwise prevents KCSAN from detecting violations of your
 code's synchronization rules.
 
 
+Use of volatile and __data_racy
+-------------------------------
+
+Adding the volatile keyword to the declaration of a variable causes both
+the compiler and KCSAN to treat all reads from that variable as if they
+were protected by READ_ONCE() and all writes to that variable as if they
+were protected by WRITE_ONCE().
+
+Adding the __data_racy type qualifier to the declaration of a variable
+causes KCSAN to treat all accesses to that variable as if they were
+enclosed by data_race().  However, __data_racy does not affect the
+compiler, though one could imagine hardened kernel builds treating the
+__data_racy type qualifier as if it was the volatile keyword.
+
+Note well that __data_racy is subject to the same pointer-declaration
+rules as is the volatile keyword.  For example:
+
+	int __data_racy *p; // Pointer to data-racy data.
+	int *__data_racy p; // Data-racy pointer to non-data-racy data.
+
+
 ACCESS-DOCUMENTATION OPTIONS
 ============================
 
@@ -342,7 +369,7 @@ as follows:
 
 Because foo is read locklessly, all accesses are marked.  The purpose
 of the ASSERT_EXCLUSIVE_WRITER() is to allow KCSAN to check for a buggy
-concurrent lockless write.
+concurrent write, whether marked or not.
 
 
 Lock-Protected Writes With Heuristic Lockless Reads
