Received: from relay.hostedemail.com (smtprelay0012.hostedemail.com [216.40.44.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA14123EA89;
	Mon, 26 Jan 2026 14:36:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769438215; cv=none; b=uyNlaSeQsPkhAxAzFTs00elDLSb04HCIZO8Zg94CJBJGiA42mWOHZABEPVsToyVzSybXCfFSHzz5lX5izbimlqmFNXPse1kz8DQlfM7YmJaFbw2p1xxISW/aRkO8u28pductaUFl9BgXaZqPz/wsLLCRMxquZ9QgKEIL2s3GWg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769438215; c=relaxed/simple;
	bh=jMPEDTeiWeVa4oLHy6ZcUp/vDUqMEZWPE7aY464U3W4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sniaIaKQwu+DBkvAcNWWxjjAJ7geAfKlUhG473WfKE6MUwZnq3lUq0ltI+IS3XjqsD6dH81SDJuGAzGA+0bCPIw1PzH8yAQI/JTUxzit++bwYwAXsFY6o+h2JO+MDKidkeeWn5l4ul6Ez1KKZcGlCvgvnr+AOGLkVInPrHgTuBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf05.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay06.hostedemail.com (Postfix) with ESMTP id 0AC521B0A3C;
	Mon, 26 Jan 2026 14:36:47 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf05.hostedemail.com (Postfix) with ESMTPA id 0C18D20011;
	Mon, 26 Jan 2026 14:36:44 +0000 (UTC)
Date: Mon, 26 Jan 2026 09:36:46 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Yaxiong Tian <tianyaxiong@kylinos.cn>
Cc: axboe@kernel.dk, mhiramat@kernel.org, mathieu.desnoyers@efficios.com,
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/3] tracing: Rename `eval_map_wq` and export it for
 asynchronous use by other modules
Message-ID: <20260126093646.3922b905@gandalf.local.home>
In-Reply-To: <20260126024316.297178-1-tianyaxiong@kylinos.cn>
References: <20260126024033.290136-1-tianyaxiong@kylinos.cn>
	<20260126024316.297178-1-tianyaxiong@kylinos.cn>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: aqtr4u4qwr5my4umxu56a5z5kf93ixpf
X-Rspamd-Server: rspamout04
X-Rspamd-Queue-Id: 0C18D20011
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX19iq/IWG9jz79aRyHPrTTDnFB2BymTjM70=
X-HE-Tag: 1769438204-242823
X-HE-Meta: U2FsdGVkX1+CjsL7tZvGh7qM4v0yp+S2CJFxEB8OK7MOh91wtNa2vufNnGt3IUOkb3B+zIdQ3XLwPJ6B+UPRHmkrGRoKc4qbOhAG+mXYJxE6oLwkmwVQk+KwI3YSvlA8MDE+Tq3PmVNzd43opcdBpDvrkmNCKfvUJA9EqQtu15IToxUoCFie/z4+WA3yZL5bnw8rDSmkfmKCXbj5xUXcg3kqyOGz5Jrftf0zde0MTq2n1xK5q//Fz0Nxdo2tKlffx7SNfiPsVtxss1g5KVGJ1wvgAIftjlqn9LVD1HkQ3H6h1SuYi3m3pDYTL8YONjNW

On Mon, 26 Jan 2026 10:43:16 +0800
Yaxiong Tian <tianyaxiong@kylinos.cn> wrote:

Hi,

Some of your terminology is a little confusing. The subject says "modules"
but no module will use it (the term module means loadable code at runtime
into the Linux kernel). A better subject would be:


  tracing: Rename `eval_map_wq` and allow other parts of tracing use it


> The eval_map_work_func() function, though queued in eval_map_wq,
> holds the trace_event_sem read-write lock for a long time during
> kernel boot. This causes blocking issues for other functions.
> 
> Rename eval_map_wq to trace_init_wq and export it, thereby allowing

Also saying "export" for a function means something like "EXPORT_SYMBOLE()"
which again deals with Linux modules. A better term is "make it global".

> other modules to schedule work on this queue asynchronously and

 .. other parts of tracing ..

> avoiding blockage of the main boot thread.
> 
> Signed-off-by: Yaxiong Tian <tianyaxiong@kylinos.cn>

Other than that, this patch looks good.

-- Steve

> ---
>  kernel/trace/trace.c | 18 +++++++++---------
>  kernel/trace/trace.h |  2 ++
>  2 files changed, 11 insertions(+), 9 deletions(-)
> 
> diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
> index e18005807395..c61e30cb7339 100644
> --- a/kernel/trace/trace.c
> +++ b/kernel/trace/trace.c
> @@ -10774,7 +10774,7 @@ int tracing_init_dentry(void)
>  extern struct trace_eval_map *__start_ftrace_eval_maps[];
>  extern struct trace_eval_map *__stop_ftrace_eval_maps[];
>  
> -static struct workqueue_struct *eval_map_wq __initdata;
> +struct workqueue_struct *trace_init_wq __initdata;
>  static struct work_struct eval_map_work __initdata;
>  static struct work_struct tracerfs_init_work __initdata;
>  
> @@ -10790,15 +10790,15 @@ static int __init trace_eval_init(void)
>  {
>  	INIT_WORK(&eval_map_work, eval_map_work_func);
>  
> -	eval_map_wq = alloc_workqueue("eval_map_wq", WQ_UNBOUND, 0);
> -	if (!eval_map_wq) {
> -		pr_err("Unable to allocate eval_map_wq\n");
> +	trace_init_wq = alloc_workqueue("trace_init_wq", WQ_UNBOUND, 0);
> +	if (!trace_init_wq) {
> +		pr_err("Unable to allocate trace_init_wq\n");
>  		/* Do work here */
>  		eval_map_work_func(&eval_map_work);
>  		return -ENOMEM;
>  	}
>  
> -	queue_work(eval_map_wq, &eval_map_work);
> +	queue_work(trace_init_wq, &eval_map_work);
>  	return 0;
>  }
>  
> @@ -10807,8 +10807,8 @@ subsys_initcall(trace_eval_init);
>  static int __init trace_eval_sync(void)
>  {
>  	/* Make sure the eval map updates are finished */
> -	if (eval_map_wq)
> -		destroy_workqueue(eval_map_wq);
> +	if (trace_init_wq)
> +		destroy_workqueue(trace_init_wq);
>  	return 0;
>  }
>  
> @@ -10969,9 +10969,9 @@ static __init int tracer_init_tracefs(void)
>  	if (ret)
>  		return 0;
>  
> -	if (eval_map_wq) {
> +	if (trace_init_wq) {
>  		INIT_WORK(&tracerfs_init_work, tracer_init_tracefs_work_func);
> -		queue_work(eval_map_wq, &tracerfs_init_work);
> +		queue_work(trace_init_wq, &tracerfs_init_work);
>  	} else {
>  		tracer_init_tracefs_work_func(NULL);
>  	}
> diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
> index de4e6713b84e..e52f259f8945 100644
> --- a/kernel/trace/trace.h
> +++ b/kernel/trace/trace.h
> @@ -770,6 +770,8 @@ extern unsigned long nsecs_to_usecs(unsigned long nsecs);
>  
>  extern unsigned long tracing_thresh;
>  
> +extern struct workqueue_struct *trace_init_wq __initdata;
> +
>  /* PID filtering */
>  
>  bool trace_find_filtered_pid(struct trace_pid_list *filtered_pids,

