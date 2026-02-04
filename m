Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A60173A1D13;
	Wed,  4 Feb 2026 10:15:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770200156; cv=none; b=qT0CXYYjfU6kzsxi5FgMZwLIuwudJ/2YPDCgZMg+8N/iI0wbQ5SueRxELPi+T4Ly4CZKp/xAFiwTBRzocJneJrL9GNVqWSmqwgrLBPVCr2YSPCWE/pW4uLmXkR1DYAqPRmpf9SvILAHzkM7swwYnDg/RWeUNNEJaEgnOhBeTN2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770200156; c=relaxed/simple;
	bh=Vml1Yv6/8IU5ssSk3RIZ6pAEqcuSbNl+cNLCkYETK7Q=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=rm/rKWSvyxcN4HtJsh6GxbO/7qgSiAeaXnHiiDl1LvAtlyhtYjO5XpVGmFIpFqLbBSTGHA9MvJnL8PoSSrAdLAWsZ/B+2tq8oAmCB9Hp5rA+EXKIKSkDcXWfQHCkZ4JGJBHC++gHR76CMLK3+evARGQXwjVHy8VfQSGTWhYG46g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OhPgqJW9; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OhPgqJW9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 340D0C4CEF7;
	Wed,  4 Feb 2026 10:15:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770200156;
	bh=Vml1Yv6/8IU5ssSk3RIZ6pAEqcuSbNl+cNLCkYETK7Q=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=OhPgqJW9B8KO9AoTInwb0hRe9dxoo6qrc6bfA7bEOupUPrUBOdOA1I6vHZ5+IlSSJ
	 EWMFCy2f+wK6/D7yf4+2fD2UIgYfbiqboS55m4CzrT3ka4Cq3sSMXuRW4hnvujIjsN
	 ShSAPfe4uEEG8pVUQkT7DgSjgB4a+ealjvIbj6C2SZzKScMLr2EERe2iysydlUMzze
	 aU2MMR/1nGkROoSrQL/5sWNyWTFuJMQehdxMQFKrlfyGct0RMaCxb+ixTiGzyksllW
	 joHRHiJA8l3bw0ZEMrXD4N0q1nlVDXDDccud9NV6hJ60d37Lrvz3lD6liMWdUfTi1z
	 Uj88ljHQ/ycuw==
Date: Wed, 4 Feb 2026 19:15:52 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Yaxiong Tian <tianyaxiong@kylinos.cn>
Cc: axboe@kernel.dk, rostedt@goodmis.org, mathieu.desnoyers@efficios.com,
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v5 0/3] Tracing: Accelerate Kernel Boot by
 Asynchronizing
Message-Id: <20260204191552.881a00764093cf63557a372a@kernel.org>
In-Reply-To: <20260204015103.155025-1-tianyaxiong@kylinos.cn>
References: <20260204015103.155025-1-tianyaxiong@kylinos.cn>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Wed,  4 Feb 2026 09:51:03 +0800
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
> init_blk_tracer that are related to this lock to run asynchronously on this
> workqueue. Also check for kprobe_event= grub parameter; if not provided,
> init_kprobe_trace() returns directly. After optimization, boot time is
> reduced by approximately 200ms.
> 
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

Looks good to me.

Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Thanks!

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
> https://lore.kernel.org/all/20260128125117.1704853-1-tianyaxiong@kylinos.cn/
> Changes in v5:
> - remove trace_async_init boot parameter (patch2 v4)
> - remove make  Make setup_boot_kprobe_events() asynchronous (patch4 v4)
> - Adjusted the patch sequence.
> 
> 
> Yaxiong Tian (3):
>   tracing: Rename `eval_map_wq` and allow other parts of tracing use it
>   blktrace: Make init_blk_tracer() asynchronous
>   tracing/kprobes: Skip setup_boot_kprobe_events() when no cmdline event
> 
>  kernel/trace/blktrace.c     | 23 ++++++++++++++++++++++-
>  kernel/trace/trace.c        | 18 +++++++++---------
>  kernel/trace/trace.h        |  1 +
>  kernel/trace/trace_kprobe.c |  4 ++++
>  4 files changed, 36 insertions(+), 10 deletions(-)
> 
> -- 
> 2.25.1
> 
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
