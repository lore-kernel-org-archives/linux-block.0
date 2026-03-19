Received: from relay.hostedemail.com (smtprelay0011.hostedemail.com [216.40.44.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EBF137DE9D;
	Thu, 19 Mar 2026 21:52:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773957145; cv=none; b=PE01qX41a18BsGLBzc74lYf2c14lgoDKAYxRwYKCI7YXV/5XfF+lISqLlktfTGqp8cusz6biQWTnCLp4pCXGk2gjcX+rOgA4rs1ugwdTYyZfWxWGdfIQh0Pta1FmUbQ8XfDkpQHI4OgV1x6YekSeWWnBhICPXfin/ukJMgxVInk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773957145; c=relaxed/simple;
	bh=jwHlAMcakKM7yr7h5bK6LR1kqKdekHOHX8yg5Kd0UYY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UdLR2G42Kjo1dA6j4ugTXFNEhQMz8BBEmIQ47o4ffhZxTTdtqZEporKMprJAkOX0601Hwhp8Yo253dVnlL8bKofmzi0XuD2endCOZlf8i3rlE/Pmkr6GWg4E52IO4w4rB+xk84lPCUVus87aunsHmo/kOM5qPiuS2p0Qndk94HE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf07.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay10.hostedemail.com (Postfix) with ESMTP id EB6DAC2541;
	Thu, 19 Mar 2026 21:52:21 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf07.hostedemail.com (Postfix) with ESMTPA id B755C20024;
	Thu, 19 Mar 2026 21:52:18 +0000 (UTC)
Date: Thu, 19 Mar 2026 17:52:49 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Aaron Tomlin <atomlin@atomlin.com>
Cc: axboe@kernel.dk, mhiramat@kernel.org, mathieu.desnoyers@efficios.com,
 johannes.thumshirn@wdc.com, kch@nvidia.com, bvanassche@acm.org,
 dlemoal@kernel.org, ritesh.list@gmail.com, neelx@suse.com, sean@ashe.io,
 mproche@gmail.com, chjohnst@gmail.com, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v2] blk-mq: add tracepoint block_rq_tag_wait
Message-ID: <20260319175249.560f27a7@gandalf.local.home>
In-Reply-To: <20260319015300.287653-1-atomlin@atomlin.com>
References: <20260319015300.287653-1-atomlin@atomlin.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: rspamout05
X-Rspamd-Queue-Id: B755C20024
X-Stat-Signature: ybsiqziohnm5mnu6k7ob5fy77cqg1k7y
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX18w67Qx9JCBQNzxkMc6Scfc/RwIcQpmo7I=
X-HE-Tag: 1773957138-993911
X-HE-Meta: U2FsdGVkX18VVuBuyNRdg/5iHdETKgJJHF7V7Y611KbHR8XvNmDoIh4rAJofCWupGBuAaQSy88l/OSXgcgdrVRcPVMNbDU+Oib9cT6O1VFko/h9gk5N9/Y4Eo2cu0xB8jicw+o5d1wXdjOmab6XOibA4LOZeTVSpqZIKC1nZYnTWbU32Q0XJc5b028MDtU7RiDWoVyUZRGVfWHI7RARlFFdKWR7mkc3wLVWKBIJaiX60wEosmOOHXMvb15a/g2q8UJnUAQV5LlQLmONH7uhlmm0/jh7Weg47A2IxHqv6dm90A3iE6QdJsro5DAb/H5TlyYrkjI5z8nPdPLVtEuj3m78h2J606vhkcP2HPLhq8b9E1nn6wNWr4bL16/lv7kGZ

On Wed, 18 Mar 2026 21:53:00 -0400
Aaron Tomlin <atomlin@atomlin.com> wrote:

> +	TP_fast_assign(
> +		__entry->dev		= disk_devt(q->disk);
> +		__entry->hctx_id	= hctx->queue_num;
> +		__entry->is_sched_tag	= is_sched_tag;
> +
> +		if (__entry->is_sched_tag)

Nit, but why use __entry->is_sched_tag instead of is_sched_tag.

Not sure if the compiler will optimize it (likely it will), but it seems
cleaner to use the variable directly and not the one assigned.

Perhaps the compiler is smart enough to use one register for both updates.

-- Steve


> +			__entry->nr_tags = hctx->sched_tags->nr_tags;
> +		else
> +			__entry->nr_tags = hctx->tags->nr_tags;
> +	),
> +
