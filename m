Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D35202BE03D;
	Wed, 28 Jan 2026 23:38:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769643500; cv=none; b=K+T1JGO622KhCnSG4pXkV5nwTCJnriDMrYUhD+TzNxyU2KDKyc4DSPF6ihiAZaHxMVNB1mL2vexXY0DwdW8iHMIHibRZxYXwYDC9E2tvElHSyNMd7hpl0PlPxd2Hn7XboiXFJIXdc+rOxap0sGovhlN5sDTnNsWfcoGSyj8fhyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769643500; c=relaxed/simple;
	bh=F0SGT1zA7nJrKcds9k2gzkJL1tql6F1LMQ2X/R9SLXU=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=TkHGM5aiyCg/YwMZfYh158+Hl4AYaCYos4jXrIbNsaobwwLnp5nGb/g9ku6d98wtrEnfDtnDalQmr/Vlt1x9+og8tulgOu+gz4YMsNWvu/3LPBlABlI/uuTuEc/XN9fJQVWejpArtbPAmSkTLI1leW5CozkgTq2AL3lZM90cHBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u5Z8pkQs; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u5Z8pkQs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10D22C4CEF1;
	Wed, 28 Jan 2026 23:38:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769643500;
	bh=F0SGT1zA7nJrKcds9k2gzkJL1tql6F1LMQ2X/R9SLXU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=u5Z8pkQsCsASHBAWQsH9T1G5ZcaqbryygrnEcq1600aasgTUAnDh3GNvGpgJ0D9lv
	 xPa4jgCIpnpMBjCBuYljQSCb60qJCO9igRU8Hp/RKs6EkVei4Fc+8AKOle+vuQPysG
	 FWSJ/pvJC62A1eD8OrsjajN7ic4SgGkD/mWkderuV0tsgEuL9xwUPS7oFw9Ad+w3Vc
	 t0v9qojp+LNw+AkWJskfFTGxq+uNrg1X8mhv4VeYCk9Ea0zUrphX5DFqvLBMDRdOyS
	 OOHfmQ2upHuEMDALuFfFT+J2swjVrLdqNxZpYA3UqiWc/fnrZTNHOXbLxp+v4jrLMp
	 yP/X61KGrVeKQ==
Date: Thu, 29 Jan 2026 08:38:17 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Yaxiong Tian <tianyaxiong@kylinos.cn>
Cc: rostedt@goodmis.org, axboe@kernel.dk, mathieu.desnoyers@efficios.com,
 corbet@lwn.net, skhan@linuxfoundation.org,
 linux-trace-kernel@vger.kernel.org, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH v4 0/5] Tracing: Accelerate Kernel Boot by
 Asynchronizing
Message-Id: <20260129083817.d26c61da3cf274bf37e1b2a0@kernel.org>
In-Reply-To: <20260128125117.1704853-1-tianyaxiong@kylinos.cn>
References: <20260128125117.1704853-1-tianyaxiong@kylinos.cn>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Wed, 28 Jan 2026 20:51:17 +0800
Yaxiong Tian <tianyaxiong@kylinos.cn> wrote:

> On my ARM64 platform, I observed that certain tracing module
> initializations run for up to 200ms—for example, init_kprobe_trace().
> Analysis reveals the root cause: the execution flow eval_map_work_func()
> →trace_event_update_with_eval_map()→trace_event_update_all()
> is highly time-consuming. Although this flow is placed in eval_map_wq
> for asynchronous execution, it holds the trace_event_sem lock, causing
> other modules to be blocked either directly or indirectly. Also in
> init_blk_tracer(), this functions require trace_event_sem device_initcall.
> 
> To resolve this issue, I rename `eval_map_wq` and make it global and moved
> other initialization functions under the tracing subsystem that are
> related to this lock to run asynchronously on this workqueue. After this
> optimization, boot time is reduced by approximately 200ms.
> 
> Given that asynchronous initialization makes it indeterminate when tracing
> will begin, we introduce the trace_async_init kernel parameter.Asynchronous
> behavior is enabled only when this parameter is explicitly provided.
> 
> Based on my analysis and testing, I've identified that only these two
> locations significantly impact timing. Other initcall_* functions do not
> exhibit relevant lock contention.
> 
> A brief summary of the test results is as follows:
> Before this PATCHS:
> [    0.224933] calling  init_kprobe_trace+0x0/0xe0 @ 1
> [    0.455016] initcall init_kprobe_trace+0x0/0xe0 returned 0 after 230080 usecs
> 
> Only opt setup_boot_kprobe_events() can see:
> [    0.258609] calling  init_blk_tracer+0x0/0x68 @ 1
> [    0.454991] initcall init_blk_tracer+0x0/0x68 returned 0 after 196377 usecs
> 
> After this PATCHS:
> [    0.224940] calling  init_kprobe_trace+0x0/0xe0 @ 1
> [    0.224946] initcall init_kprobe_trace+0x0/0xe0 returned 0 after 3 usecs
> skip --------
> [    0.264835] calling  init_blk_tracer+0x0/0x68 @ 1
> [    0.264841] initcall init_blk_tracer+0x0/0x68 returned 0 after 2 usecs

OK, this series looks good to me.

Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

for this series.

Thank you,


> 
> ---
> Changes in v2:
> - Rename eval_map_wq to trace_init_wq.
> Changes in v3:
> - Opt PATCH 1/3 commit
> Changes in v4:
> - add trace_async_init boot parameter in patch2
> - add init_kprobe_trace's skip logic in patch3
> - add Suggested-by tag 
> - Other synchronous optimizations related to trace_async_init
> 
> Yaxiong Tian (5):
>   tracing: Rename `eval_map_wq` and allow other parts of tracing use it
>   tracing: add trace_async_init boot parameter
>   tracing/kprobes: Skip setup_boot_kprobe_events() when no cmdline event
>   tracing/kprobes: Make setup_boot_kprobe_events() asynchronous when
>     trace_async_init set
>   blktrace: Make init_blk_tracer() asynchronous when trace_async_init
>     set
> 
>  .../admin-guide/kernel-parameters.txt         |  8 ++++++
>  kernel/trace/blktrace.c                       | 23 +++++++++++++++-
>  kernel/trace/trace.c                          | 27 ++++++++++++-------
>  kernel/trace/trace.h                          |  2 ++
>  kernel/trace/trace_kprobe.c                   | 18 ++++++++++++-
>  5 files changed, 67 insertions(+), 11 deletions(-)
> 
> -- 
> 2.25.1
> 
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
