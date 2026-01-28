Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81ADA2264A8;
	Wed, 28 Jan 2026 04:49:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769575779; cv=none; b=CsZ0Ig0TJNRuMkyFqm7KnkDayHPpP2iBAU/6cOqWyZrGoSO+Y5KhxxoMJbRv/2cGkR9XOSDeRDcY4b7EwMNkqQOZEAeWRIgmih4NljzFhSnLyfgERlvzH4DidfXgQOmao7UVW2CqFroq8dF2XiGQTynZtINmPb+RpP/uGYG336E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769575779; c=relaxed/simple;
	bh=umvKSX/52KFvcK5MHhG0AKEwZqp2cQ4avhWh2heNEbY=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=YKHYhu8ACvPo5kjHG4DkdDoVjZcyq4/9rTqTPd3cpwufufojdLOP6wv2oV+WndYw0j+uEo/pj8hLU0wu9VnIi0fnoW2mOFi9W3bxgD2U2P1zJWE4ny4wnsik723F4xQHTHIetstiJUxKXjzA9Z8a8Sx0cTrqyqZhe8a+HWbbXDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B0lKhTh2; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B0lKhTh2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE0FAC4CEF1;
	Wed, 28 Jan 2026 04:49:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769575779;
	bh=umvKSX/52KFvcK5MHhG0AKEwZqp2cQ4avhWh2heNEbY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=B0lKhTh2fBTFrbFQfkBWAhdNbPv3OAFg8tZd7cUPRHPbMgsEVLAVe6sdk9CeeLvmZ
	 SpjBlV5ok89NVLuCmw1KeusKTit1bQThc42K2xA67VjAsbP0F5d/nBAirKSqrqB927
	 LKDxmzy4EH7Qu1mD24Oe6fdmSOAwqc+KX0H1umEojUQG2xyvC7U0cYl08xf6CxUAgz
	 9AbA0SFh5vpGPB8fw4sN/1tWMFlted+1hI4crCt2LpP6BnuhXwBuZzKSgBDEL8AbY1
	 XtK72PenfJhMvXpvOy7GUJAcNtPZHXnNhSfrwJyAuek4lT1wFmUSn0AeT8dBoWuD+Z
	 yTRFgmN78Zp7w==
Date: Wed, 28 Jan 2026 13:49:36 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Yaxiong Tian <tianyaxiong@kylinos.cn>
Cc: rostedt@goodmis.org, axboe@kernel.dk, mathieu.desnoyers@efficios.com,
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/3] tracing/kprobes: Make setup_boot_kprobe_events()
 asynchronous
Message-Id: <20260128134936.539782c2112073e55e7a0304@kernel.org>
In-Reply-To: <20260127012312.84659-1-tianyaxiong@kylinos.cn>
References: <20260127012016.76713-1-tianyaxiong@kylinos.cn>
	<20260127012312.84659-1-tianyaxiong@kylinos.cn>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 27 Jan 2026 09:23:12 +0800
Yaxiong Tian <tianyaxiong@kylinos.cn> wrote:

> During kernel boot, the setup_boot_kprobe_events() function causes
> significant delays, increasing overall startup time.
> 
> The root cause is a lock contention chain: its child function
> enable_boot_kprobe_events() requires the event_mutex, which is
> already held by early_event_add_tracer(). early_event_add_tracer()
> itself is blocked waiting for the trace_event_sem  read-write lock,
> which is held for an extended period by trace_event_update_all().
> 
> To resolve this, we have moved the execution of
> setup_boot_kprobe_events() to the trace_init_wq  workqueue, allowing
> it to run asynchronously.
> 
> Signed-off-by: Yaxiong Tian <tianyaxiong@kylinos.cn>
> ---
>  kernel/trace/trace_kprobe.c | 14 +++++++++++++-
>  1 file changed, 13 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/trace/trace_kprobe.c b/kernel/trace/trace_kprobe.c
> index 9953506370a5..4c6621f02696 100644
> --- a/kernel/trace/trace_kprobe.c
> +++ b/kernel/trace/trace_kprobe.c
> @@ -2031,6 +2031,13 @@ static __init int init_kprobe_trace_early(void)
>  }
>  core_initcall(init_kprobe_trace_early);
>  
> +static struct work_struct kprobe_trace_work __initdata;
> +
> +static void __init kprobe_trace_works_func(struct work_struct *work)
> +{
> +	setup_boot_kprobe_events();
> +}
> +
>  /* Make a tracefs interface for controlling probe points */
>  static __init int init_kprobe_trace(void)
>  {
> @@ -2048,7 +2055,12 @@ static __init int init_kprobe_trace(void)
>  	trace_create_file("kprobe_profile", TRACE_MODE_READ,
>  			  NULL, NULL, &kprobe_profile_ops);
>  
> -	setup_boot_kprobe_events();
> +	if (trace_init_wq) {
> +		INIT_WORK(&kprobe_trace_work, kprobe_trace_works_func);
> +		queue_work(trace_init_wq, &kprobe_trace_work);

Hmm, this queue_work is not required if kprobe_boot_events_buf[] is
empty. We should check it because most of the time we don't need it.
Also, deferring initialization makes it indeterminate when this
tracing will begin.

For kprobe event use case, I think setup_boot_kprobe_events() should
check the kprobe_boot_events_buf is empty at first. But I think Yaxiong
use case happens when you are using kprobe events via cmdline, is that
correct?

I think introducing "async" cmdline option is more preferable.

BTW, I found that the kprobe events from kernel cmdline will be made
after boot-time tracing from bootconfig. Maybe it should be run this
earlier timing too.

Thank you,


> +	} else {
> +		setup_boot_kprobe_events();
> +	}
>  
>  	return 0;
>  }
> -- 
> 2.25.1
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
