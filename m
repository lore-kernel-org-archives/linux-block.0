Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 894853BBED;
	Tue, 11 Jun 2024 16:54:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718124868; cv=none; b=afRVQV6h3qyX8MwRhUSqIhLtngxmr6SJ5D96NKlFfuOylaQR7ojvDXQTBVxdGYZltfpNgtblO/uV9c+YIDTXg1uvCggE/b/DtOlq4a0C/Ay0ivkIHFrmqdjW/tSPI//OSwBzWpG60j58a2b98nFZfr24ui8SL7gGwxd8awqzKw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718124868; c=relaxed/simple;
	bh=k1/dmpbynMnrbBscn/VmbNjjSCbrZOi5ZMoFxGslAcM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aSsa/U/gWR4dRLWZVStOUkVi6UGM7phEQwb7ZXZa20s4Q16+NmhXne5CX780yctOkARlswUgT6m/UobC/RwIcxWDkDIO+J1IZ9d2WXfW9dlRRqrWkDAVJyAPU15Dtbr94IFiqFQFrTKbQUG79JSifDWADF/kljIORks0wBkqSjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D4A4C2BD10;
	Tue, 11 Jun 2024 16:54:25 +0000 (UTC)
Date: Tue, 11 Jun 2024 12:54:40 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Bart Van Assche <bvanassche@acm.org>
Cc: Dongliang Cui <dongliang.cui@unisoc.com>, axboe@kernel.dk,
 mhiramat@kernel.org, mathieu.desnoyers@efficios.com, ebiggers@kernel.org,
 ke.wang@unisoc.com, hongyu.jin.cn@gmail.com, niuzhiguo84@gmail.com,
 hao_hao.wang@unisoc.com, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org, akailash@google.com,
 cuidongliang390@gmail.com
Subject: Re: [PATCH v4] block: Add ioprio to block_rq tracepoint
Message-ID: <20240611125440.6d095270@gandalf.local.home>
In-Reply-To: <86eb3dd0-77a1-4d1d-8e62-38c46bd7563a@acm.org>
References: <20240611073519.323680-1-dongliang.cui@unisoc.com>
	<86eb3dd0-77a1-4d1d-8e62-38c46bd7563a@acm.org>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 11 Jun 2024 09:26:54 -0700
Bart Van Assche <bvanassche@acm.org> wrote:

> On 6/11/24 12:35 AM, Dongliang Cui wrote:
> > +#define IOPRIO_CLASS_STRINGS \
> > +	{ IOPRIO_CLASS_NONE,	"none" }, \
> > +	{ IOPRIO_CLASS_RT,	"rt" }, \
> > +	{ IOPRIO_CLASS_BE,	"be" }, \
> > +	{ IOPRIO_CLASS_IDLE,	"idle" }, \
> > +	{ IOPRIO_CLASS_INVALID,	"invalid"}  
> 
> Shouldn't this array be defined in a C file instead of in a header file?

The way the TRACE_EVENT() macro works, this will not work in a C file.

> -	TP_printk("%d,%d %s (%s) %llu + %u [%d]",
> +	TP_printk("%d,%d %s (%s) %llu + %u %s,%u,%u [%d]",
>  		  MAJOR(__entry->dev), MINOR(__entry->dev),
>  		  __entry->rwbs, __get_str(cmd),
> -		  (unsigned long long)__entry->sector,
> -		  __entry->nr_sector, 0)
> +		  (unsigned long long)__entry->sector, __entry->nr_sector,
> +		  __print_symbolic(IOPRIO_PRIO_CLASS(__entry->ioprio),
> +				   IOPRIO_CLASS_STRINGS),
> +		  IOPRIO_PRIO_HINT(__entry->ioprio),
> +		  IOPRIO_PRIO_LEVEL(__entry->ioprio),  0)
>  );
>  

It's used for __print_symbolic() which the TRACE_EVENT() macro logic (using
header files) will expand it to something useful.

-- Steve
