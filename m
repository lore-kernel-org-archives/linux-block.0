Received: from relay.hostedemail.com (smtprelay0013.hostedemail.com [216.40.44.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E203DC8F0;
	Fri, 30 Jan 2026 03:45:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769744732; cv=none; b=txdb6OEuGpJzIpEo8/rMSlLR7P+BBTnzhsEd3f/u82ZI3mb50GX4iwfFvvCVsOZeHm0/Pj5mR1mwLwK4Xopf+Hg/J1UOKzBrk3rBC5SQ9Nt+Kq6X5JMVHl1jguJr8CSXIBaN0iQmxa/843R2tjhZMcqrg+UtUDviRU0x4b3BxOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769744732; c=relaxed/simple;
	bh=pneDh+olfzLcXLhXbDymTNw29UPvot1LIiwITdPOPJE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PqszmHEBEHGUqkYyNE3+4QRR3GIlEFbLvT52aeM4M6b+zoj1Y5uMYEfNUvFXqoeoh0gRnDjZfQUk/pG9xXroMVoq84Vhg9HoEuehkNAqzYu2noJF7tqtdUn3ksE/XuyOcP4/51wQsIOKqNUapr2knwfrF+OEDE2xtyfiawy/CY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf20.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay05.hostedemail.com (Postfix) with ESMTP id 9A87058E1F;
	Fri, 30 Jan 2026 03:45:23 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf20.hostedemail.com (Postfix) with ESMTPA id 699D620029;
	Fri, 30 Jan 2026 03:45:21 +0000 (UTC)
Date: Thu, 29 Jan 2026 22:45:20 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Yaxiong Tian <tianyaxiong@kylinos.cn>
Cc: Jens Axboe <axboe@kernel.dk>, mhiramat@kernel.org,
 mathieu.desnoyers@efficios.com, corbet@lwn.net, skhan@linuxfoundation.org,
 linux-trace-kernel@vger.kernel.org, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH v4 5/5] blktrace: Make init_blk_tracer() asynchronous
 when trace_async_init set
Message-ID: <20260129224520.7f043338@robin>
In-Reply-To: <20260129223116.489a01fd@robin>
References: <20260128194104.30051be1@gandalf.local.home>
	<56C8934E-3D17-4467-93E6-D813770BF577@kernel.dk>
	<20260129152958.05c1ca46@gandalf.local.home>
	<bb29a10c-6130-4040-8521-0b5375c017ef@kylinos.cn>
	<a61e6bc0-58d1-46f0-8a4f-17f02503fe17@kylinos.cn>
	<20260129222608.7000bffd@robin>
	<20260129223116.489a01fd@robin>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: hqaqghghrfn5mckzfrcerkzb86wzz1zh
X-Rspamd-Server: rspamout02
X-Rspamd-Queue-Id: 699D620029
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1+uy1ixrt/aqFfavrtOFiTZek+RqaVJ+AM=
X-HE-Tag: 1769744721-585260
X-HE-Meta: U2FsdGVkX19hCWcu997EoTmFS38/ung1Y/pCgiAsDj1WDhxW8aY/lsQ7ShuX/BvY3W7CzCF8EQHajN5YWTgo+3FN8iod6RmuWHZP0wJhXQ6xEOkUP+tirHix7pdSMeJv01Lsgk4XmeHLZT2feKlSs4J77cItOHhw9UgLrpedgzTssXNgds1hfSysQcYp22yH/14z1U/RsZEmsJ7l+K9S8MFi6N7TNDDA7FBhAlkJBXMO/2/CDd0sigN4mrSk5msNcztfFqHCSihDq7qC3i9mhrsVCzZjwtzDiUGb1rg8Rsheky9LYfV5m3MU4E0wLHNjHOxce8dvOiLzNchnXj4TvUg4W2kRFCwAvnSnTvEBiDpZanFxWGr8AALD+nOvAoDR

On Thu, 29 Jan 2026 22:31:16 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

> I added the below patch and have this result:
> 
>    kworker/u33:1-79      [002] .....     1.840855: trace_event_update_all: Start syncing
>        swapper/0-1       [005] .....     6.045742: trace_eval_sync: sync maps
>    kworker/u33:1-79      [002] .....    12.289296: trace_event_update_all: Finish syncing
>        swapper/0-1       [005] .....    12.289387: trace_eval_sync: sync maps complete
> 
> Which shows that the final initcall waited for the work queue to complete:

Switching to printk() gives me the same results:

# dmesg |grep sync
[    1.117856] Start syncing
[    4.498360] sync maps
[   11.173304] Finish syncing
[   11.175660] sync maps complete

-- Steve
