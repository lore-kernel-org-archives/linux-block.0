Received: from relay.hostedemail.com (smtprelay0011.hostedemail.com [216.40.44.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CE991D6187;
	Fri, 30 Jan 2026 03:31:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769743883; cv=none; b=nvBrWgkv58CD7za2ic8YdWXS18FMItL4amvPdYA3ToCEfkXD+2iLWiCRJZwu/AzNYN3rgchOM4BkdExCF2YnJaA5GVh2SD2ahQvEH6HuQsFK2FUCgIi71C14amNmTPqUpqROf9EI/tgCpzeR3c/JYmWKrOWxoOMJu+irFVME/HY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769743883; c=relaxed/simple;
	bh=tWZoobf4aGQGPM/wHtCPm5infVuZxqtXkmb9Uav5DsU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=M6vDwmbHTXbUkDeHQzT/mO3DCrg7e+9SKL+xoXxtK3V7Dqm6HmgvnTuaB+EPdFJ7zEmTXKPYCMzT92EQn2RJVaEmWLpFuzTvhuPbngwmCmdxQcq5/oE+vvmKZ6RKE2MJnbRAfGUgTGWOxRkU54kBRXMa58akakBpUbksHv2fgak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf13.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay10.hostedemail.com (Postfix) with ESMTP id 7C794C181D;
	Fri, 30 Jan 2026 03:31:19 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf13.hostedemail.com (Postfix) with ESMTPA id 45E3A2000D;
	Fri, 30 Jan 2026 03:31:17 +0000 (UTC)
Date: Thu, 29 Jan 2026 22:31:16 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Yaxiong Tian <tianyaxiong@kylinos.cn>
Cc: Jens Axboe <axboe@kernel.dk>, mhiramat@kernel.org,
 mathieu.desnoyers@efficios.com, corbet@lwn.net, skhan@linuxfoundation.org,
 linux-trace-kernel@vger.kernel.org, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH v4 5/5] blktrace: Make init_blk_tracer() asynchronous
 when trace_async_init set
Message-ID: <20260129223116.489a01fd@robin>
In-Reply-To: <20260129222608.7000bffd@robin>
References: <20260128194104.30051be1@gandalf.local.home>
	<56C8934E-3D17-4467-93E6-D813770BF577@kernel.dk>
	<20260129152958.05c1ca46@gandalf.local.home>
	<bb29a10c-6130-4040-8521-0b5375c017ef@kylinos.cn>
	<a61e6bc0-58d1-46f0-8a4f-17f02503fe17@kylinos.cn>
	<20260129222608.7000bffd@robin>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: rspamout07
X-Rspamd-Queue-Id: 45E3A2000D
X-Stat-Signature: if3rqawatujz5jdqhgwskg5u97k9uheo
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1+k5kEN8feabnPqX/jEMae0eAenN2p59D4=
X-HE-Tag: 1769743877-885195
X-HE-Meta: U2FsdGVkX1/waOAsEFuCpmccDtR6mGH3uBS3t8ueqKCEeNudKQ7NmVF5Mm3r+p9krEy+K7TnqMG65znftk7tjT05QAjdRiVg4iJNv+uszBEFaV+IT7MMxnnsTKIsH7pKTKizrr57UKZgecc2pAXjD3CF/Oo+CREx0Ge0HHvnXnGS0QYJ62UCf8HU6KCU5Znu2/Gmg1Ws59Ceb/IUvUUK1jyEmxiuWmMVfx5jJ1qkJ9KGBSAFmVhWLl02dEZEbjVoF56N3nnWRRnxuDo9u4yTuEE4ZVMJKKFZgbc+LuU5bqp8/y40o3L706jd7LEIsTnh0PT9gbJpdOOngiKMvuLraWmhyxXkyOe64RiKn/e91PO9DGhR8cpwHJ/XRE8/9zbL

On Thu, 29 Jan 2026 22:26:08 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

> Use trace_printk() instead. printk now has a "deferred" output. I'm not
> sure if the timestamps of when it prints is when the print took place
> or when it got to the console :-/

I added the below patch and have this result:

   kworker/u33:1-79      [002] .....     1.840855: trace_event_update_all: Start syncing
       swapper/0-1       [005] .....     6.045742: trace_eval_sync: sync maps
   kworker/u33:1-79      [002] .....    12.289296: trace_event_update_all: Finish syncing
       swapper/0-1       [005] .....    12.289387: trace_eval_sync: sync maps complete

Which shows that the final initcall waited for the work queue to complete:

-- Steve

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 396d59202438..33180d5622a8 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -10817,9 +10817,11 @@ subsys_initcall(trace_eval_init);
 
 static int __init trace_eval_sync(void)
 {
+	trace_printk("sync maps\n");
 	/* Make sure the eval map updates are finished */
 	if (eval_map_wq)
 		destroy_workqueue(eval_map_wq);
+	trace_printk("sync maps complete\n");
 	return 0;
 }
 
diff --git a/kernel/trace/trace_events.c b/kernel/trace/trace_events.c
index af6d1fe5cab7..194b344400e9 100644
--- a/kernel/trace/trace_events.c
+++ b/kernel/trace/trace_events.c
@@ -3555,6 +3555,7 @@ void trace_event_update_all(struct trace_eval_map **map, int len)
 	int last_i;
 	int i;
 
+	trace_printk("Start syncing\n");
 	down_write(&trace_event_sem);
 	list_for_each_entry_safe(call, p, &ftrace_events, list) {
 		/* events are usually grouped together with systems */
@@ -3593,6 +3594,8 @@ void trace_event_update_all(struct trace_eval_map **map, int len)
 		cond_resched();
 	}
 	up_write(&trace_event_sem);
+	msleep(10000);
+	trace_printk("Finish syncing\n");
 }
 
 static bool event_in_systems(struct trace_event_call *call,
