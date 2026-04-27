Received: from relay.hostedemail.com (smtprelay0011.hostedemail.com [216.40.44.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 596E23D34B7;
	Mon, 27 Apr 2026 16:41:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777308073; cv=none; b=T6LHwpkbutBypCu2D8Ndryaot2mVDfRJiV8/f5MKQswfd/qyJJVD8Qzkxm3QKKPJzMCy9sxjncKWihbE3wznNer2472GWI+E55oMi0wAtHe31FlblG3Nirx8d2Qu4llO3hi2D/4CHqDGOdb2qGzTBIdm5K33xrgYccxpe/hU/yQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777308073; c=relaxed/simple;
	bh=0wPH/Fl3RB62b5MLKmyh8mpdOjOulQAC7ohtud3SMP8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RJjaQJbwdwEYl9pRWgK71TYp8sH8z1XoQxaMewGF+KaJwhtCZW+KuSEiZVeFNzaQU/dMd7fnjJOip8eEqUbGqcOx0+GlSPmFDAGTXyMN1tgJHpKUu/GzxS6yexRWk7fuyBZICh1TutbygG+74WogWGMqnQfecqBaWHM905qkjpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf11.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay05.hostedemail.com (Postfix) with ESMTP id 3ADDE4052A;
	Mon, 27 Apr 2026 16:38:40 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf11.hostedemail.com (Postfix) with ESMTPA id 7FE6E2002F;
	Mon, 27 Apr 2026 16:38:36 +0000 (UTC)
Date: Mon, 27 Apr 2026 12:38:48 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Aaron Tomlin <atomlin@atomlin.com>
Cc: axboe@kernel.dk, mhiramat@kernel.org, mathieu.desnoyers@efficios.com,
 bvanassche@acm.org, johannes.thumshirn@wdc.com, kch@nvidia.com,
 dlemoal@kernel.org, ritesh.list@gmail.com, loberman@redhat.com,
 neelx@suse.com, sean@ashe.io, mproche@gmail.com, chjohnst@gmail.com,
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v5 1/2] blk-mq: add tracepoint block_rq_tag_wait
Message-ID: <20260427123848.1e6b63d2@gandalf.local.home>
In-Reply-To: <20260427020142.358912-2-atomlin@atomlin.com>
References: <20260427020142.358912-1-atomlin@atomlin.com>
	<20260427020142.358912-2-atomlin@atomlin.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: c8q7uzk37jdeojro1hdsgzgz8514oasf
X-Rspamd-Server: rspamout04
X-Rspamd-Queue-Id: 7FE6E2002F
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1+ezFbHvfao1EGoVLpXuzorTHt2Yl/LyF8=
X-HE-Tag: 1777307916-952419
X-HE-Meta: U2FsdGVkX19D95yn3snxCao9QXEhOmUtHRvqZ56CHwoRM3MWL4Zb/dNq77gR4SpiCUAIs+8464BCPdpZmBSq96Y8YAxV59YzomGqBOSkhBIi2FYim19s8WP0OBzD2YrG8xqIqtipiZLT/3sX/mXe6U+bzl8UNo2zytLtFL2hXOUNlff3NhqfU4U2U17MrVGyJxC970UNHxwwYGsaLj9/Rn1MjWA1bWJG0P2Z+v4FuVHX8NZIjRhpaJrKkP0o3T2fBKHPj3SmOrCp3LsCNeAXVQ48mfv+hKQ7KmrzrpkPl/BYp8sIgsYM8+r9J93KKvpd6oY7EmgqVVr1oC6Zyso4XCx1cZmW4kSBJGZbH9xqSU4W2LJ76vgw/xzaDB/o9Rlf

On Sun, 26 Apr 2026 22:01:41 -0400
Aaron Tomlin <atomlin@atomlin.com> wrote:

> +TRACE_EVENT(block_rq_tag_wait,
> +
> +	TP_PROTO(struct request_queue *q, struct blk_mq_hw_ctx *hctx, bool is_sched_tag),
> +
> +	TP_ARGS(q, hctx, is_sched_tag),
> +
> +	TP_STRUCT__entry(
> +		__field( dev_t,		dev			)
> +		__field( u32,		hctx_id			)
> +		__field( u32,		nr_tags			)
> +		__field( bool,		is_sched_tag		)
> +	),
> +
> +	TP_fast_assign(
> +		__entry->dev		= q->disk ? disk_devt(q->disk);

Hmm, does the above even compile?

-- Steve

> +		__entry->hctx_id	= hctx->queue_num;
> +		__entry->is_sched_tag	= is_sched_tag;
> +
> +		if (is_sched_tag)
> +			__entry->nr_tags = hctx->sched_tags->nr_tags;
> +		else
> +			__entry->nr_tags = hctx->tags->nr_tags;
> +	),
> +
> +	TP_printk("%d,%d hctx=%u starved on %s tags (depth=%u)",
> +		  MAJOR(__entry->dev), MINOR(__entry->dev),
> +		  __entry->hctx_id,
> +		  __entry->is_sched_tag ? "scheduler" : "hardware",
> +		  __entry->nr_tags)
> +);
> +
