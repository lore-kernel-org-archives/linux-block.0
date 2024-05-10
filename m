Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9ED3635;
	Fri, 10 May 2024 22:35:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715380531; cv=none; b=NEkxEDvZpZuIvzc2pjMKwLh6xVljV7h8FkjKFjPCv16Azi+I0y1zV2K7kH2/XwyTVJOYrIg9w3Sj722wtRY8iF5XSdgky8Lb1pWP8wMe/yX2yCI5P3ejfgqnYrJJak16yDJK/Akm6kw7HzMHkXSH179yXdnXNcz4Kr3CoqvjBUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715380531; c=relaxed/simple;
	bh=RsSwNAFVJJDe067v5AIvDeUDB4gAsGvhvKhNsvBq+b8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T3qVZT2imONdSFAadmx9Qnnn11mLW6ShQ9O3ZESwKvF8jvgpdAA9RC7DDZ69lvI1yknzIk1h4MuiT8MuC1p3GpKFyM1vdzZbqVnYQ5YfIMX2GafxHvk+A7i0/Zal1g+4QkaR2ooexohtvscpHlCjKTDv8LJexCDePkEYMIqyCGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I8IMZvav; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I8IMZvav"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D408C113CC;
	Fri, 10 May 2024 22:35:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715380531;
	bh=RsSwNAFVJJDe067v5AIvDeUDB4gAsGvhvKhNsvBq+b8=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=I8IMZvavCQAC9NFiDsV64W9bdaIP+RM0aCYkfR/kIvdkVMoQFs2Eby+IlPTjnH2zg
	 6sjoUfTgk6eUTSLEyUIE/2VvBJNvsWF5ja5lxeHLThozbu5wp+Xv6DZGOLuBvZvr/Z
	 ykXPojWBixHQdSRVzVZ2KOPRCdzLxFjArZO/eQernL5JuT8uTl5uPGvuI5HCc7k2jP
	 FXu52bDFyoxNuowaNBL12ECakn80Fq4WCFEBQxSVsO8+hnlsAfEx8t8E2ttFj8snIo
	 Mb90BHvkLO6ULqskrLSNNfQq0VtEXV7y1C52Vr997hFmDf65JJEJrQ1vFE2Ikva3AH
	 MfCCwP7YsWiww==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id D2968CE0F90; Fri, 10 May 2024 15:35:30 -0700 (PDT)
Date: Fri, 10 May 2024 15:35:30 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Bart Van Assche <bvanassche@acm.org>
Cc: Breno Leitao <leitao@debian.org>, Jens Axboe <axboe@kernel.dk>,
	"open list:BLOCK LAYER" <linux-block@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>,
	Marco Elver <elver@google.com>
Subject: Re: [PATCH] block: Annotate a racy read in blk_do_io_stat()
Message-ID: <447ad732-3ff8-40bf-bd82-f7be66899cee@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20240510141921.883231-1-leitao@debian.org>
 <ef8c5f6d-17e3-4504-8560-b970912b9eae@acm.org>
 <de92101c-f9c4-4af4-95f4-19a6f59b636f@paulmck-laptop>
 <d037f37a-4722-4a1d-a282-63355a97a1a1@acm.org>
 <c83d9c25-b839-4e31-8dd4-85f3cb938653@paulmck-laptop>
 <4d230bac-bdb0-4a01-8006-e95156965aa8@acm.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4d230bac-bdb0-4a01-8006-e95156965aa8@acm.org>

On Fri, May 10, 2024 at 01:30:03PM -0700, Bart Van Assche wrote:
> On 5/10/24 10:08 AM, Paul E. McKenney wrote:
> > To see that, consider a variable that is supposed to be accessed only
> > under a lock (aside from the debugging/statistical access).  Under RCU's
> > KCSAN rules, marking those debugging/statistical accesses with READ_ONCE()
> > would require all the updates to be marked with WRITE_ONCE().  Which would
> > prevent KCSAN from noticing a buggy lockless WRITE_ONCE() update of
> > that variable.
> > 
> > In contrast, if we use data_race() for the debugging/statistical accesses
> > and leave the normal lock-protected accesses unmarked (as normal
> > C-language accesses), then KCSAN will complain about buggy lockless
> > accesses, even if they are marked with READ_ONCE() or WRITE_ONCE().
> > 
> > Does that help, or am I missing your point?
> 
> Thanks, that's very helpful. Has it been considered to add this
> explanation as a comment above the data_race() macro definition?
> There may be other kernel developers who are wondering about when
> to use data_race() and when to use READ_ONCE().

Well, sometimes you need to use both!

Does the prototype patch below help?

(Also adding Marco on CC for his thoughts.)

							Thanx, Paul

------------------------------------------------------------------------

diff --git a/include/linux/compiler.h b/include/linux/compiler.h
index c00cc6c0878a1..78593b40fe7e9 100644
--- a/include/linux/compiler.h
+++ b/include/linux/compiler.h
@@ -194,9 +194,18 @@ void ftrace_likely_update(struct ftrace_likely_data *f, int val,
  * This data_race() macro is useful for situations in which data races
  * should be forgiven.  One example is diagnostic code that accesses
  * shared variables but is not a part of the core synchronization design.
+ * For example, if accesses to a given variable are protected by a lock,
+ * except for diagnostic code, then the accesses under the lock should
+ * be plain C-language accesses and those in the diagnostic code should
+ * use data_race().  This way, KCSAN will complain if buggy lockless
+ * accesses to that variable are introduced, even if the buggy accesses
+ * are protected by READ_ONCE() or WRITE_ONCE().
+ *
+ * This macro *does not* affect normal code generation, but is a hint to
+ * tooling that data races here are to be ignored.  If code generation must
+ * be protected *and* KCSAN should ignore the access, use both data_race()
+ * and READ_ONCE(), for example, data_race(READ_ONCE(x)).
  *
- * This macro *does not* affect normal code generation, but is a hint
- * to tooling that data races here are to be ignored.
  */
 #define data_race(expr)							\
 ({									\
