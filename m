Received: from relay.hostedemail.com (smtprelay0013.hostedemail.com [216.40.44.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47DEA3D1CB1;
	Fri, 27 Feb 2026 19:19:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772219979; cv=none; b=qnQoHEZz6JAgMB7216LHwUN9V/aVE6FHF6VfJTEhrJTxg+cSLfmYf+91DXy+xiDl/UTU6KtIlKtnLCCo/lnJ3XgbtN8VEG/kpnMDdICfu7wIBz0W/fRSTBh8fB7TNb9hHq7yDUj9IKStbydNDFi2lhkZuSb2YxJKDV4ZPOzRqA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772219979; c=relaxed/simple;
	bh=omdyWATOk+1bsTz6vm1xBAr2qEDPOku6BXtUH5LcIBM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fur93Uu7is5WEgn1jC/kybQZ0xf6MoCabcbyjxQWaLBKMPfmH5XZkGVGmete0wpXbHJk0D6s5wLMo2Ym1IHATWw8hlKldZMAvy9hU4pzk8srjPZPTJw82HCBLIqWV2jo5Fh3mE0kNNbMcxHVOzEBaf4AIshis1jn40CCIpeU/Zo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf08.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay02.hostedemail.com (Postfix) with ESMTP id A4819139F33;
	Fri, 27 Feb 2026 19:19:28 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf08.hostedemail.com (Postfix) with ESMTPA id A6C6A20027;
	Fri, 27 Feb 2026 19:19:26 +0000 (UTC)
Date: Fri, 27 Feb 2026 14:19:51 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Chaitanya Kulkarni <kch@nvidia.com>
Cc: <axboe@kernel.dk>, <mhiramat@kernel.org>,
 <mathieu.desnoyers@efficios.com>, <shinichiro.kawasaki@wdc.com>,
 <linux-block@vger.kernel.org>, <linux-trace-kernel@vger.kernel.org>
Subject: Re: [PATCH] blktrace: fix __this_cpu_read/write in preemptible
 context
Message-ID: <20260227141951.102e19ce@gandalf.local.home>
In-Reply-To: <20260227050303.10945-1-kch@nvidia.com>
References: <20260227050303.10945-1-kch@nvidia.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: A6C6A20027
X-Rspamd-Server: rspamout06
X-Stat-Signature: r4qqxqiszkhab4sehibryxzocaq78913
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX18D3dX5k0KHc6/1OC6JwPvbmjmshfA+M8k=
X-HE-Tag: 1772219966-529596
X-HE-Meta: U2FsdGVkX18w1tJZ+tTxvJpfXrhGJtIUwrwE7Z7rqFFEA0BBj9kVtzfdaAf95c4jJGuMJWa2nzTVyMT/BgYFArgwWziLkJ+d4Me1UUdXRXJgqiZN+kwLwa8c5Dsv7zg86ePzpKNtoOlaeqOWG2SWT5xDoSCugfHJh51DFV1Ad86aRBpFNYh2CD7xweqqjBdA3crJiqOVPHxqBG5G/udDzQ860dcvZ+Wsv/NzBakcVCFhjcrWkv8tc+dVXoIyxjrqjgI/kkclBFzHYiO0DKwP31aK7tKPbCKlea54KyVrv9HjDHEudKrtI4GIbP0rA4KmdNZLLJE25KOXAgjWD4l9j+CDZvp75b/R

On Thu, 26 Feb 2026 21:03:03 -0800
Chaitanya Kulkarni <kch@nvidia.com> wrote:

> diff --git a/kernel/trace/blktrace.c b/kernel/trace/blktrace.c
> index 3b7c102a6eb3..488552036583 100644
> --- a/kernel/trace/blktrace.c
> +++ b/kernel/trace/blktrace.c
> @@ -383,7 +383,9 @@ static void __blk_add_trace(struct blk_trace *bt, sector_t sector, int bytes,
>  	cpu = raw_smp_processor_id();
>  
>  	if (blk_tracer) {
> +		preempt_disable_notrace();
>  		tracing_record_cmdline(current);
> +		preempt_enable_notrace();
>  
>  		buffer = blk_tr->array_buffer.buffer;
>  		trace_ctx = tracing_gen_ctx_flags(0);

Do you know when this started? rcu_read_lock() doesn't disable preemption
in PREEMPT environments, and hasn't for a very long time. I'm surprised it
took this long to detect this? Perhaps this was a bug from day one?

Anyway, the tracing_record_cmdline() is to update the COMM cache so that
the trace has way to show the task->comm based on the saved PID in the
trace. It sets a flag to record the COMM from the sched_switch event if a
trace event happened. It's not needed if no trace event occurred. That
means, instead of adding preempt_disable() here, just move it after the
ring buffer event is reserved, as that means preemption is disabled until
the event is committed.

i.e.

diff --git a/kernel/trace/blktrace.c b/kernel/trace/blktrace.c
index e6988929ead2..3735cbc1f99f 100644
--- a/kernel/trace/blktrace.c
+++ b/kernel/trace/blktrace.c
@@ -383,8 +383,6 @@ static void __blk_add_trace(struct blk_trace *bt, sector_t sector, int bytes,
 	cpu = raw_smp_processor_id();
 
 	if (blk_tracer) {
-		tracing_record_cmdline(current);
-
 		buffer = blk_tr->array_buffer.buffer;
 		trace_ctx = tracing_gen_ctx_flags(0);
 		switch (bt->version) {
@@ -419,6 +417,8 @@ static void __blk_add_trace(struct blk_trace *bt, sector_t sector, int bytes,
 		if (!event)
 			return;
 
+		tracing_record_cmdline(current);
+
 		switch (bt->version) {
 		case 1:
 			record_blktrace_event(ring_buffer_event_data(event),

-- Steve
