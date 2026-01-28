Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAC4032AAA5;
	Wed, 28 Jan 2026 07:53:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769586785; cv=none; b=FmPppTMvCEo+nDoQeWgSYOqzBQbG7XTGsQrkEA/zBtawxPtg9UBud3+QasILKrU+wQ/DHbn/zgfuqCNGwU33Rbj+f35/fv9i0707N2pBXJWziQ5FOUdx4JutexUu2AHmXk0HLjzAKasuzhZUxoOVKXaQSc3tLieVPNWqZXK/DPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769586785; c=relaxed/simple;
	bh=dzd8ja4e3420ghb0+0sOkoo98bKxU6eX/KdF+VoHzSs=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=rv7rt8L41RLTadjVter7xMgzSto6YFqVVNk+HJ0Uc00z4Hh4Hk1g+Lh/55omEbL3dd6xMCfw8oIUbJ+p5Dpj9iVwb2eyxg7+dMbHfvK4XqMtYGgu5aSe3dUPRpw/ik9h+QM4fvM0w2Shnxg0i6t0JTEeVdIE1k6ZOLYhvlkY2hQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OL/tnyao; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OL/tnyao"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5224FC16AAE;
	Wed, 28 Jan 2026 07:53:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769586785;
	bh=dzd8ja4e3420ghb0+0sOkoo98bKxU6eX/KdF+VoHzSs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=OL/tnyao2goyiwU4HtS8dLsNOjQm8GDijeAKfuf+NetohnP/CysYjs1dmkK9v/5e6
	 +BfdZhmRIR7lz4+J8bDS/7bMlrD6P/gYxrcb5KE30qvw1l2n2Vtr3E0RkjWICn0TAt
	 eDHBO+4nbWnWa+tVW8+85uzhNgxiY1e8v1iqyqVJBAKnS8O3kK7smp1P1OPXykSmWf
	 nuWsQPLgf/Sys9Wv2nLS7JPs2lWqzNukDk9jLlV+7057ZRc0qJsbuk1ppGRHGup8/V
	 RAsdBKJUrnWWw8MOtZlqOVHt1i1VMk34YK57F9ucYpI4PF7SOMV42EkFh9b2zCk25d
	 a+3pbo+tmXugg==
Date: Wed, 28 Jan 2026 16:53:02 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Yaxiong Tian <tianyaxiong@kylinos.cn>
Cc: rostedt@goodmis.org, axboe@kernel.dk, mathieu.desnoyers@efficios.com,
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/3] tracing/kprobes: Make setup_boot_kprobe_events()
 asynchronous
Message-Id: <20260128165302.1c67c6fc1c54525247d7f553@kernel.org>
In-Reply-To: <6ab04276-8897-4d5e-a86c-e656cf1f6f91@kylinos.cn>
References: <20260127012016.76713-1-tianyaxiong@kylinos.cn>
	<20260127012312.84659-1-tianyaxiong@kylinos.cn>
	<20260128134936.539782c2112073e55e7a0304@kernel.org>
	<6ab04276-8897-4d5e-a86c-e656cf1f6f91@kylinos.cn>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Wed, 28 Jan 2026 15:24:15 +0800
Yaxiong Tian <tianyaxiong@kylinos.cn> wrote:

> 
> 在 2026/1/28 12:49, Masami Hiramatsu (Google) 写道:
> > On Tue, 27 Jan 2026 09:23:12 +0800
> > Yaxiong Tian <tianyaxiong@kylinos.cn> wrote:
> >
> >> During kernel boot, the setup_boot_kprobe_events() function causes
> >> significant delays, increasing overall startup time.
> >>
> >> The root cause is a lock contention chain: its child function
> >> enable_boot_kprobe_events() requires the event_mutex, which is
> >> already held by early_event_add_tracer(). early_event_add_tracer()
> >> itself is blocked waiting for the trace_event_sem  read-write lock,
> >> which is held for an extended period by trace_event_update_all().
> >>
> >> To resolve this, we have moved the execution of
> >> setup_boot_kprobe_events() to the trace_init_wq  workqueue, allowing
> >> it to run asynchronously.
> >>
> >> Signed-off-by: Yaxiong Tian <tianyaxiong@kylinos.cn>
> >> ---
> >>   kernel/trace/trace_kprobe.c | 14 +++++++++++++-
> >>   1 file changed, 13 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/kernel/trace/trace_kprobe.c b/kernel/trace/trace_kprobe.c
> >> index 9953506370a5..4c6621f02696 100644
> >> --- a/kernel/trace/trace_kprobe.c
> >> +++ b/kernel/trace/trace_kprobe.c
> >> @@ -2031,6 +2031,13 @@ static __init int init_kprobe_trace_early(void)
> >>   }
> >>   core_initcall(init_kprobe_trace_early);
> >>   
> >> +static struct work_struct kprobe_trace_work __initdata;
> >> +
> >> +static void __init kprobe_trace_works_func(struct work_struct *work)
> >> +{
> >> +	setup_boot_kprobe_events();
> >> +}
> >> +
> >>   /* Make a tracefs interface for controlling probe points */
> >>   static __init int init_kprobe_trace(void)
> >>   {
> >> @@ -2048,7 +2055,12 @@ static __init int init_kprobe_trace(void)
> >>   	trace_create_file("kprobe_profile", TRACE_MODE_READ,
> >>   			  NULL, NULL, &kprobe_profile_ops);
> >>   
> >> -	setup_boot_kprobe_events();
> >> +	if (trace_init_wq) {
> >> +		INIT_WORK(&kprobe_trace_work, kprobe_trace_works_func);
> >> +		queue_work(trace_init_wq, &kprobe_trace_work);
> > Hmm, this queue_work is not required if kprobe_boot_events_buf[] is
> > empty. We should check it because most of the time we don't need it.
> Yes, I will improve it in the next version.
> > Also, deferring initialization makes it indeterminate when this
> > tracing will begin.
> Indeed, While most scenarios don't need boot-time tracing, and users 
> prioritize boot speed, we must balance the need for deterministic traces 
> with faster startup.

I just wonder why don't you define kprobe events after boot (e.g.
from init script) instead of kernel cmdline. Using cmdline means
it will be used for tracing kernel boot.

- tracing kernel boot -> use kernel cmdline (synchronous)
- tracing user boot -> use tracefs (asynchronous)

> > For kprobe event use case, I think setup_boot_kprobe_events() should
> > check the kprobe_boot_events_buf is empty at first. But I think Yaxiong
> > use case happens when you are using kprobe events via cmdline, is that
> > correct?
> The issue was identified without enabling kprobe events via the cmdline. 

Interesting. So is it fixed by another patch [1]?

[1] https://lore.kernel.org/all/20260127053848.108473-1-sunliming@linux.dev/

> The core finding is that asynchronous initialization can drastically cut 
> boot time under different workloads. As blocking occurs elsewhere in the 
> tracing infrastructure beyond just kprobe events, adopting async is a 
> broadly applicable strategy for boot time optimization.

Yes, but it is also possible to set it up from user space, because that
user process can work asynchronously.
We can make the ftrace initialization async to accelerate boot time, but
that means it is not useful for tracing kernel boot.

> >
> > I think introducing "async" cmdline option is more preferable.
> 
> Agreed, this works. Users focused on boot speed over early-boot tracing 
> can opt for this parameter to gain a startup performance boost.

Yeah, that is an option. Anyway, basically, users have another option to
setup ftrace after boot user space asynchronously. That is my
recommendation for such use case.

> 
> >
> > BTW, I found that the kprobe events from kernel cmdline will be made
> > after boot-time tracing from bootconfig. Maybe it should be run this
> > earlier timing too.
> 
> Yes. Additionally, this optimization does not conflict with the current 
> patch series at all.
> 
> I'll submit the updated patch for the next version promptly.

OK.

Thank you,

> 
> > Thank you,
> >
> >
> >> +	} else {
> >> +		setup_boot_kprobe_events();
> >> +	}
> >>   
> >>   	return 0;
> >>   }
> >> -- 
> >> 2.25.1
> >>
> >


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
