Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05F0029429;
	Tue, 11 Jun 2024 17:32:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718127121; cv=none; b=YoJaJvspfVouqFLiY2YIgFRq6fC9e3IBEVFNgZHntMvXkKRPs04uvYe6tH/UVs7WF0MPFKNYnnexvzx1UenlUqD4PgJ5xmARAtrzY+tlGBSAa38UFdKTxBHHJRPLFNwHAVRmEeU5YdjYRH5azX24oL3ztLit6VJq6fSc5iqsows=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718127121; c=relaxed/simple;
	bh=CrNGOTYh6R/63u6KWmkKpoCdC3WNSHRNIBN1JbMpBPU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IOMtwtAMGlLTgoO7fkkFkGe8rMidosL6LF9hKPA2SUJRmWCNF6nRlW+ma+A+CUOcO1o6I03JMin4wliwTrW5Rb0jltrgi8/A2ci8wg8xkFaZkikysblqiMztM5LqyaX64JRhzfc33Bc42I+JbtyJNBg0Q5yfegNHVY03k6qZPhc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27332C2BD10;
	Tue, 11 Jun 2024 17:31:59 +0000 (UTC)
Date: Tue, 11 Jun 2024 13:32:14 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Bart Van Assche <bvanassche@acm.org>
Cc: Dongliang Cui <dongliang.cui@unisoc.com>, axboe@kernel.dk,
 mhiramat@kernel.org, mathieu.desnoyers@efficios.com, ebiggers@kernel.org,
 ke.wang@unisoc.com, hongyu.jin.cn@gmail.com, niuzhiguo84@gmail.com,
 hao_hao.wang@unisoc.com, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org, akailash@google.com,
 cuidongliang390@gmail.com
Subject: Re: [PATCH v4] block: Add ioprio to block_rq tracepoint
Message-ID: <20240611133214.3ab0c1a5@gandalf.local.home>
In-Reply-To: <20240611131737.564b6655@gandalf.local.home>
References: <20240611073519.323680-1-dongliang.cui@unisoc.com>
	<86eb3dd0-77a1-4d1d-8e62-38c46bd7563a@acm.org>
	<20240611125440.6d095270@gandalf.local.home>
	<be0dc105-e205-4b0e-9bd4-49690249fd26@acm.org>
	<20240611131737.564b6655@gandalf.local.home>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 11 Jun 2024 13:17:37 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> > Hmm ... if the above array is terminated with a { -1, NULL } sentinel and if
> > __print_symbolic() is changed into trace_print_symbols_seq(p, ...) then the above
> > array can be moved into a C file, isn't it?
> >   
> 
> Then it breaks user space parsing. The reason for __print_symbolic() is
> that libtraceevent knows how to parse it. If you put the array into a C
> file, the above mappings will not show up in the tracefs format file for
> the event, and you'll just get "[FAILED TO PARSE]" output from the user
> space tracing tooling.

Note, the trace headers are not normal headers. They are included multiple
times (when TRACE_HEADER_MULTI_READ is defined). Only one C file will
include this header with CREATE_TRACE_POINTS defined and these headers will
then build global C functions and variables.

So technically, this "array" is in C file and not in a header, as it will
not be created unless a C file includes it with CREATE_TRACE_POINTS, and
only one C file may do that (otherwise the kernel will fail to build).

-- Steve
