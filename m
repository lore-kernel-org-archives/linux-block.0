Received: from relay.hostedemail.com (smtprelay0012.hostedemail.com [216.40.44.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27A7C18FC80;
	Fri, 23 Jan 2026 20:32:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769200344; cv=none; b=avXNu7fcKYWLnchSU6+e6Ntf3qZzyuw79BsbvxH599IBZedGHyOTDcdKR5aQElEmFu9e0bmCwYJjyz9rs5BGayzSHC1koUnzZNBuGmKIyNhGo5N3HqXLAg7FPZlgS7CglarERHEtCawMSEPirsCIt/NrMpX3v8rL/5EuFJRMLYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769200344; c=relaxed/simple;
	bh=4lkwQ7iW/kaqXjEt5Q+cIRty/QB0fh4q7chQXrl3Ia8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=putC2z407FJZ7CU0ZdvQ7DP3e+hrjarthJNPxCS4UgVWayuu5+e0DOSS3m4W4PGKEKa5gi3SP8CwAi4NhH1L+GhBj0APynquylriyxn4KHagEQPggtUvSFBVqPSuLb852uPGBQg2UY+qvP1hENFTr0PQSyKZrAWO6BBWoafwuNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf10.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay09.hostedemail.com (Postfix) with ESMTP id B39748C152;
	Fri, 23 Jan 2026 20:32:20 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf10.hostedemail.com (Postfix) with ESMTPA id CA9772F;
	Fri, 23 Jan 2026 20:32:18 +0000 (UTC)
Date: Fri, 23 Jan 2026 15:32:47 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Yaxiong Tian <tianyaxiong@kylinos.cn>
Cc: axboe@kernel.dk, mhiramat@kernel.org, mathieu.desnoyers@efficios.com,
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] tracing: Export eval_map_wq for asynchronous use by
 other modules
Message-ID: <20260123153247.004688f6@gandalf.local.home>
In-Reply-To: <20260122032415.395548-1-tianyaxiong@kylinos.cn>
References: <20260122032051.386331-1-tianyaxiong@kylinos.cn>
	<20260122032415.395548-1-tianyaxiong@kylinos.cn>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: CA9772F
X-Stat-Signature: mjcaisees6qtjyzu3y9c4fbm6a5e8wwu
X-Rspamd-Server: rspamout08
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX18TE4v3b6cYeHshQ8nMe0mwBUNOCTR19KU=
X-HE-Tag: 1769200338-690880
X-HE-Meta: U2FsdGVkX187iAiokqEjL54ekCswSFMs6Gpc1fUa6J8U+CEiE5/oWgMCqO3Xqp1OdJj9qe4ZMV/WHSCSDWvGy6+qNx/T5aBOWg2cGVf9I1+asvYtcZNqYau4+4+VM/P0i9EoW16YTxuKrXnpK0tOOh1qT6S/HtfI1LYkT1T3HU7UIk21qJ88K0ZVtIbgqrEaQlW8sKIiB2ftNOyqYCOnDsYePhTtOazSJqXPEINd674J/lez9vH9B+smekoGKVwMm3ZIdRO5pJB0duDzjp0WU/4wEyt9wGg8gBYywkWaxG9A7+rxuwq/ZKMkJxmIck9c

On Thu, 22 Jan 2026 11:24:15 +0800
Yaxiong Tian <tianyaxiong@kylinos.cn> wrote:

> The eval_map_work_func() function, though queued in eval_map_wq,
> holds the trace_event_sem read-write lock for a long time during
> kernel boot. This causes blocking issues for other functions.
> 
> Making eval_map_wq extern allows other modules to schedule their
> work asynchronously on this queue,  preventing it from blocking
> the main boot thread.

If you are going to make this wq generic for other parts of the tracing
code, then let's rename it. As "eval_map" is specific to the enum mappings
being updated (which I hope someday I can get that update working at build
time. And when I do, the name will be totally meaningless).

Let's rename it to "trace_init_wq" instead.

-- Steve
