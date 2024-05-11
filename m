Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC2D2A48;
	Sat, 11 May 2024 00:41:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715388065; cv=none; b=REn9RGliXvcDXZJU4nibjgGlPVkrAMxKABb2QuCwSVsJ4jA+fs2XiQFxJ8Fbp7El4JDFzYszmTII86PW0KNZ6c+cou3eZ+gAnWBrzpJ61gtN7h10cweeNKFUvVFDpMaQ+pEGSNdTeupI9YLKEYGRRgDxJY3dDut6jEd47k/vZRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715388065; c=relaxed/simple;
	bh=pIPPzYuAehENWnP6ADisG/tghpPKOf9MUXmBw/VMOEQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p3x8XCnP90iyfuxD/hQ2NSDCeCk+tucwkaqBg9ei2CZmO+W9NecaO+TCoHSaiyRPNfowPce1VnX4fImN/SSbr4+etjJP2X3+rU+IFqlcSOoAg//VgZjuN3tAMMAuh42aZb5q1TjXVKrKE3mFatEYCcnMMqDhR9J6DHPtMQTN2ug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mhlojpax; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mhlojpax"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28CD2C113CC;
	Sat, 11 May 2024 00:41:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715388065;
	bh=pIPPzYuAehENWnP6ADisG/tghpPKOf9MUXmBw/VMOEQ=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=mhlojpaxwDiEI7cVAv+KhylgYHCK8rn6AO8HBpz9r/RbSBIUGDCiNBJvOPt7IhenY
	 KpZ/NqGgc1JwmPwQicLtoWhlqg74IX93QVcgH9BcLTFobQ7YycXx4B6qWXELWi2TPo
	 Snu2pGrowb0YNq73itfO9a5AweYpnjkiaWpDj27VT7WyIy6Z4HwBgIT/9u8GcOB1BN
	 k8DIsxoGm980Upn0P+zkrPcS0Zsaq0RiF6dZX2PKR9uHVfcaQKKSDnbWgBo70FhaN8
	 SNSaF1qwTpV+oiI24Lm+4NE6ty+4h/qAVOFDVDf+4nwMlbVGzNPbgmUGwDtvIkMZUy
	 0cak9LyyrwgZQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id B49C6CE095C; Fri, 10 May 2024 17:41:04 -0700 (PDT)
Date: Fri, 10 May 2024 17:41:04 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Bart Van Assche <bvanassche@acm.org>
Cc: Breno Leitao <leitao@debian.org>, Jens Axboe <axboe@kernel.dk>,
	"open list:BLOCK LAYER" <linux-block@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>,
	Marco Elver <elver@google.com>
Subject: Re: [PATCH] block: Annotate a racy read in blk_do_io_stat()
Message-ID: <59ec96c2-52ce-4da1-92c3-9fe38053cd3d@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20240510141921.883231-1-leitao@debian.org>
 <ef8c5f6d-17e3-4504-8560-b970912b9eae@acm.org>
 <de92101c-f9c4-4af4-95f4-19a6f59b636f@paulmck-laptop>
 <d037f37a-4722-4a1d-a282-63355a97a1a1@acm.org>
 <c83d9c25-b839-4e31-8dd4-85f3cb938653@paulmck-laptop>
 <4d230bac-bdb0-4a01-8006-e95156965aa8@acm.org>
 <447ad732-3ff8-40bf-bd82-f7be66899cee@paulmck-laptop>
 <ca7c2ef0-7e21-4fb3-ac6b-3dae652a7a0e@acm.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ca7c2ef0-7e21-4fb3-ac6b-3dae652a7a0e@acm.org>

On Fri, May 10, 2024 at 04:22:58PM -0700, Bart Van Assche wrote:
> On 5/10/24 3:35 PM, Paul E. McKenney wrote:
> > diff --git a/include/linux/compiler.h b/include/linux/compiler.h
> > index c00cc6c0878a1..78593b40fe7e9 100644
> > --- a/include/linux/compiler.h
> > +++ b/include/linux/compiler.h
> > @@ -194,9 +194,18 @@ void ftrace_likely_update(struct ftrace_likely_data *f, int val,
> >    * This data_race() macro is useful for situations in which data races
> >    * should be forgiven.  One example is diagnostic code that accesses
> >    * shared variables but is not a part of the core synchronization design.
> > + * For example, if accesses to a given variable are protected by a lock,
> > + * except for diagnostic code, then the accesses under the lock should
> > + * be plain C-language accesses and those in the diagnostic code should
> > + * use data_race().  This way, KCSAN will complain if buggy lockless
> > + * accesses to that variable are introduced, even if the buggy accesses
> > + * are protected by READ_ONCE() or WRITE_ONCE().
> > + *
> > + * This macro *does not* affect normal code generation, but is a hint to
> > + * tooling that data races here are to be ignored.  If code generation must
> > + * be protected *and* KCSAN should ignore the access, use both data_race()
> > + * and READ_ONCE(), for example, data_race(READ_ONCE(x)).
> >    *
> > - * This macro *does not* affect normal code generation, but is a hint
> > - * to tooling that data races here are to be ignored.
> >    */
> 
> This patch changes the end of the comment from "*/" into "*\n*/".
> That's probably unintended? Otherwise this patch looks good to me.

Good eyes, thank you!

How about like this instead?

							Thanx, Paul

------------------------------------------------------------------------

commit 930cb5f711443d8044e88080ee21b0a5edda33bd
Author: Paul E. McKenney <paulmck@kernel.org>
Date:   Fri May 10 15:36:57 2024 -0700

    kcsan: Add example to data_race() kerneldoc header
    
    Although the data_race() kerneldoc header accurately states what it does,
    some of the implications and usage patterns are non-obvious.  Therefore,
    add a brief locking example and also state how to have KCSAN ignore
    accesses while also preventing the compiler from folding, spindling,
    or otherwise mutilating the access.
    
    [ paulmck: Apply Bart Van Assche feedback. ]
    
    Reported-by: Bart Van Assche <bvanassche@acm.org>
    Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
    Cc: Marco Elver <elver@google.com>
    Cc: Breno Leitao <leitao@debian.org>
    Cc: Jens Axboe <axboe@kernel.dk>

diff --git a/include/linux/compiler.h b/include/linux/compiler.h
index c00cc6c0878a1..9249768ec7a26 100644
--- a/include/linux/compiler.h
+++ b/include/linux/compiler.h
@@ -194,9 +194,17 @@ void ftrace_likely_update(struct ftrace_likely_data *f, int val,
  * This data_race() macro is useful for situations in which data races
  * should be forgiven.  One example is diagnostic code that accesses
  * shared variables but is not a part of the core synchronization design.
+ * For example, if accesses to a given variable are protected by a lock,
+ * except for diagnostic code, then the accesses under the lock should
+ * be plain C-language accesses and those in the diagnostic code should
+ * use data_race().  This way, KCSAN will complain if buggy lockless
+ * accesses to that variable are introduced, even if the buggy accesses
+ * are protected by READ_ONCE() or WRITE_ONCE().
  *
- * This macro *does not* affect normal code generation, but is a hint
- * to tooling that data races here are to be ignored.
+ * This macro *does not* affect normal code generation, but is a hint to
+ * tooling that data races here are to be ignored.  If code generation must
+ * be protected *and* KCSAN should ignore the access, use both data_race()
+ * and READ_ONCE(), for example, data_race(READ_ONCE(x)).
  */
 #define data_race(expr)							\
 ({									\
