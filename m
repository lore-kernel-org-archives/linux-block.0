Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64C2543AD2;
	Tue, 11 Jun 2024 17:17:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718126243; cv=none; b=CPGx89PCPftd9bCXSnCybztQRoetpA2R1OFc3N31H2OBtbQzsaRlctnP+LZA2sSAoEkaf45bcR0NabQZnVC0JKWp4zqs1GFMJ9MlCbDd8p80w+0NI4oKqBbYZSX/x9cA+6j6JMj6EDFc6WXRx8iwTLQswpae9jLMzHyt8+kKlE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718126243; c=relaxed/simple;
	bh=l3f+DXWam6cq9ppT4pnk4HiwieGMrdZa6UfD8qHGWVw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qIDCcJVGhL8fC3Xzyuzh9sX6uFvfgy9tNQMOuesmEka0MwyWf5vI9TYGVBPXPz5BQHq3iBlcvhhDigWjQZUkzp4nyD0xe+m/YoXQnT7SfvhZjdvBQGqoljifrkMQY35si8m650yJE7/M1xh1zJsPL8cmOW8vWRtdLS+ZJFfv7XQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 820CFC2BD10;
	Tue, 11 Jun 2024 17:17:21 +0000 (UTC)
Date: Tue, 11 Jun 2024 13:17:37 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Bart Van Assche <bvanassche@acm.org>
Cc: Dongliang Cui <dongliang.cui@unisoc.com>, axboe@kernel.dk,
 mhiramat@kernel.org, mathieu.desnoyers@efficios.com, ebiggers@kernel.org,
 ke.wang@unisoc.com, hongyu.jin.cn@gmail.com, niuzhiguo84@gmail.com,
 hao_hao.wang@unisoc.com, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org, akailash@google.com,
 cuidongliang390@gmail.com
Subject: Re: [PATCH v4] block: Add ioprio to block_rq tracepoint
Message-ID: <20240611131737.564b6655@gandalf.local.home>
In-Reply-To: <be0dc105-e205-4b0e-9bd4-49690249fd26@acm.org>
References: <20240611073519.323680-1-dongliang.cui@unisoc.com>
	<86eb3dd0-77a1-4d1d-8e62-38c46bd7563a@acm.org>
	<20240611125440.6d095270@gandalf.local.home>
	<be0dc105-e205-4b0e-9bd4-49690249fd26@acm.org>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 11 Jun 2024 10:09:12 -0700
Bart Van Assche <bvanassche@acm.org> wrote:

> On 6/11/24 9:54 AM, Steven Rostedt wrote:
> > On Tue, 11 Jun 2024 09:26:54 -0700
> > Bart Van Assche <bvanassche@acm.org> wrote:
> >   
> >> On 6/11/24 12:35 AM, Dongliang Cui wrote:  
> >>> +#define IOPRIO_CLASS_STRINGS \
> >>> +	{ IOPRIO_CLASS_NONE,	"none" }, \
> >>> +	{ IOPRIO_CLASS_RT,	"rt" }, \
> >>> +	{ IOPRIO_CLASS_BE,	"be" }, \
> >>> +	{ IOPRIO_CLASS_IDLE,	"idle" }, \
> >>> +	{ IOPRIO_CLASS_INVALID,	"invalid"}  
> >>
> >> Shouldn't this array be defined in a C file instead of in a header file?  
> > 
> > The way the TRACE_EVENT() macro works, this will not work in a C file.  
> 
> Hmm ... if the above array is terminated with a { -1, NULL } sentinel and if
> __print_symbolic() is changed into trace_print_symbols_seq(p, ...) then the above
> array can be moved into a C file, isn't it?
> 

Then it breaks user space parsing. The reason for __print_symbolic() is
that libtraceevent knows how to parse it. If you put the array into a C
file, the above mappings will not show up in the tracefs format file for
the event, and you'll just get "[FAILED TO PARSE]" output from the user
space tracing tooling.

-- Steve
