Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4D0E1F1317;
	Mon, 21 Apr 2025 18:53:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745261612; cv=none; b=ZFgz3ON5NxfJvRhEnjv2AvuPVVVCokb5KetbSFzb7o+G7ZJUHWPbulOhHneRGNQp+s6JXBCcJkObQWCU6tQ0QeezC8Eztso2Qc/6ldXzC7hyfrzEPiQcvgrdkLbI6wcKB0VU1dmjm+DFAoTtD8CrTJitGedn4eQPPUg3iJtW7oo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745261612; c=relaxed/simple;
	bh=QLhViLfIrAZjXcd3M5I0q7WDZ0NsOOXefuZorG6G8G0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u9w0Eh/E5DkqzRuLUnCOf264cbnvQ/CJj39/AiBQrEnk5r7Te/KIi/qvHH82yln/e1paL4GQqpBLQM5wL7hLqNxf31q70xdqSnPw6Tgj3plQDxQOHDpBq2al7rCqNzYmN8cS55s65/Ir4c6b2YBR6AnPVY+/c3BQUvu0sWV4eYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SlFTfTCC; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SlFTfTCC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F33CDC4CEEC;
	Mon, 21 Apr 2025 18:53:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745261612;
	bh=QLhViLfIrAZjXcd3M5I0q7WDZ0NsOOXefuZorG6G8G0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SlFTfTCCrJcN/j6bVbJcp55zkqWwgGeC+bv27HRmotUJCKOIV2MUIlPgVWSROXGu1
	 QmLXPtkVqa5rZ4oU4GQagCmSLsjbVvtgMixjQ+7I0kgUC7B+iXGztFj0uhYqKvJ5s4
	 qoGJA0rYXkNqOco3oVsmef9XfIjcxb5Nvw3SNFDUCkAUnjz+1kcxfq3qapHamnM6z7
	 PxB254j+0u0L91qZzuM9Ld09TwGvfgywLuTnV+9zqfxPa+PMNejcKswp8UAXNJPMJ/
	 1Pd8Mf8Q1GlEc9MhkUqC53LzI/EyXi1MYByIB248422VCvGT9pBGrcgURi+CEbDWKB
	 Y1ep/FwJhjOHw==
Date: Mon, 21 Apr 2025 12:53:29 -0600
From: Keith Busch <kbusch@kernel.org>
To: Matt Fleming <mfleming@cloudflare.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kernel-team <kernel-team@cloudflare.com>
Subject: Re: 10x I/O await times in 6.12
Message-ID: <aAaUKenXzkFPZaMb@kbusch-mbp.dhcp.thefacebook.com>
References: <CAGis_TVSAPjYwVjUyur0_NFsDi9jmJ_oWhBHrJ-bEknG-nJO9Q@mail.gmail.com>
 <aAZiwGy1A7J4spDk@kbusch-mbp.dhcp.thefacebook.com>
 <CAGis_TXyPtFiE=pLrLRh1MV3meE4aETi6z36NWLrMkYKkcjGNQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGis_TXyPtFiE=pLrLRh1MV3meE4aETi6z36NWLrMkYKkcjGNQ@mail.gmail.com>

On Mon, Apr 21, 2025 at 07:35:24PM +0100, Matt Fleming wrote:
> On Mon, 21 Apr 2025 at 16:22, Keith Busch <kbusch@kernel.org> wrote:
> >
> > On Mon, Apr 21, 2025 at 09:53:10AM +0100, Matt Fleming wrote:
> > > Hey there,
> > >
> > > We're moving to 6.12 at Cloudflare and noticed that write await times
> > > in iostat are 10x what they were in 6.6. After a bit of bpftracing
> > > (script to find all plug times above 10ms below), it seems like this
> > > is an accounting error caused by the plug->cur_ktime optimisation
> > > rather than anything more material.
> > >
> > > It appears as though a task can enter __submit_bio() with ->plug set
> > > and a very stale cur_ktime value on the order of milliseconds. Is this
> > > expected behaviour? It looks like it leads to inaccurate I/O times.
> >
> > There are places with a block plug that call cond_resched(), which
> > doesn't invalidate the plug's cached ktime. You could end up with a
> > stale ktime if your process is scheduled out.
> 
> Is that intentional? I know the cached time is invalidated when
> calling schedule(). Does the invalidation need to get pushed down into
> __schedule_loop()?
> 

Not sure. I'm also guessing cond_resched is the reason for your
observation, so that might be worth confirming is happening in whatever
IO paths you're workload is taking in case there's some other
explanation.

fs-writeback happens to work around it by unplugging if it knows
cond_resched is going to schedule. The decision to unplug here wasn't
necessarily because of the plug's ktime, but it gets the job done:

  https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/fs/fs-writeback.c?h=v6.15-rc3#n1984

Doesn't really scale well to copy this for every caller of
cond_resched(), though. An io specific helper implementation of
cond_resched might help.

Or if we don't want cond_resched to unplug (though I feel like you would
normally want that), I think we could invalidate the ktime when
scheduling to get the stats to read the current ktime after the process
is scheduled back in.

---
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -6978,6 +6978,9 @@ static void __sched notrace preempt_schedule_common(void)
 		 * between schedule and now.
 		 */
 	} while (need_resched());
+
+	if (current->flags & PF_BLOCK_TS)
+		blk_plug_invalidate_ts(current);
 }
 
 #ifdef CONFIG_PREEMPTION
--
