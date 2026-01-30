Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 719712D46BD;
	Fri, 30 Jan 2026 09:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769765427; cv=none; b=CcNbrvFYkQu/ClHz5d7wruqzgKwIzyPcnBXtgkYYkrnN/xFvb+72USTkFQRwWs+BBvvnmdbDsUEsNz4q2YhqfF7jIWKPUp6bqYVML9LumrNcscvTWULJDPFQyUB0bjQuBGg7aUafU/2ajniAXeqACtIGVJDgusNk+qNGicT20Xs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769765427; c=relaxed/simple;
	bh=A/e93zSeuScuKLLv1EFCsZiYkVthcJkWuJEGlAY6QNA=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=m0v5sH2YubUZNNK8NGFIuA0/tWLTns4HE9rj04aK4gPb8+/88ueTBJ0QEc9b7kosWiLioe+gYcGCPhk4ILSKFdc5iao7F7BX/z1BbFJ+D6dq+AyhnjoSlfSLHDg0GLsExPn8EEn52BBb5Xo+uIysMaL7CvHORhgPO4CppLX1LQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HlD0gqm0; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HlD0gqm0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CE07C4CEF7;
	Fri, 30 Jan 2026 09:30:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769765427;
	bh=A/e93zSeuScuKLLv1EFCsZiYkVthcJkWuJEGlAY6QNA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=HlD0gqm0fh9rqu+5ydFFnqQtErkuE9CoVB+/MavUxoVktSjloZfIrJSoAi5hg0nzb
	 XCAE5/NqZy5qB2LXxPTe5hkAjEiuA4FwnhS703qLkWjEucPKAoEzGiPsz8JP/3oeQR
	 uKNsQ+vEd8FsqBdQ/Zx6lLV3HlEn+ZiRtsFUHrfT2T4DgVXdihki7fuiCrkMHyZbAh
	 +ecbxd5fVgcfF3AuhGg49xGfR23mhawtxUKLe741QureYgx9rZqPnj31n9kgLJleiZ
	 /SIxaVLkVHwcquEJ/WRFc7zaihxSOGxwVaQutjXE2v0eYDNZFg+I3pmsTMwaWq1TPc
	 na8vW5szw2nTw==
Date: Fri, 30 Jan 2026 18:30:22 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Jens Axboe <axboe@kernel.dk>, Yaxiong Tian <tianyaxiong@kylinos.cn>,
 mhiramat@kernel.org, mathieu.desnoyers@efficios.com, corbet@lwn.net,
 skhan@linuxfoundation.org, linux-trace-kernel@vger.kernel.org,
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org
Subject: Re: [PATCH v4 5/5] blktrace: Make init_blk_tracer() asynchronous
 when trace_async_init set
Message-Id: <20260130183022.add316050dd9638e6d71a469@kernel.org>
In-Reply-To: <20260129152958.05c1ca46@gandalf.local.home>
References: <20260128194104.30051be1@gandalf.local.home>
	<56C8934E-3D17-4467-93E6-D813770BF577@kernel.dk>
	<20260129152958.05c1ca46@gandalf.local.home>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Thu, 29 Jan 2026 15:29:58 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Wed, 28 Jan 2026 19:25:46 -0700
> Jens Axboe <axboe@kernel.dk> wrote:
> 
> > On Jan 28, 2026, at 5:40 PM, Steven Rostedt <rostedt@goodmis.org> wrote:
> > > 
> > > ﻿
> > > Jens,
> > > 
> > > Can you give me an acked-by on this patch and I can take the series through
> > > my tree.  
> > 
> > On phone, hope this works:
> > 
> > Acked-by: Jens Axboe <axboe@kernel.dk>
> 
> Thanks!
> 
> > 
> > > Or perhaps this doesn't even need to test the trace_async_init flag and can
> > > always do the work queue? Does blk_trace ever do tracing at boot up? That
> > > is, before user space starts?  
> > 
> > Not via the traditonal way of running blktrace.
> 
> Masami and Yaxiong,
> 
> I've been thinking about this more and I'm not sure we need the
> trace_async_init kernel parameter at all. As blktrace should only be
> enabled by user space, it can always use the work queue.
> 
> For kprobes, if someone is adding a kprobe on the kernel command line, then
> they are already specifying that tracing is more important.
> 
> Patch 3 already keeps kprobes from being an issue with contention of the
> tracing locks, so I don't think it ever needs to use the work queue.
> 
> Wouldn't it just be better to remove the trace_async_init and make blktrace
> always use the work queue and kprobes never do it (but exit out early if
> there were no kprobes registered)?

Yeah, for kprobes event case, that sounds good to me. I think [3/5] is
enough to speed it up if user does not define kprobe events on cmdline.

Thank you,

> 
> That is, remove patch 2 and 4 and make this patch always use the work queue.
> 
> -- Steve


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
