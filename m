Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8381A168490;
	Mon, 17 Jun 2024 17:07:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718644078; cv=none; b=CodCKFE/6c7hzCAKdJtrBflnPE3j5BFpDkfX4npI5h/yWh7u/pnaM3/aBAOFVZAlarIEnk/Qw78RK1OxYIghBWSikEZ3zwuLt0c1rUe/OqvLg/Xo4j9P49+sj/aEiWPWHGL7kOdfUYUFBN5GzQaNWYvUIpHrdotkLJESRHMO/9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718644078; c=relaxed/simple;
	bh=R04srHi6Ng6jDR0S2/u3J1fH1eVapnydxeg+PnaGE78=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=swAzDEIWjt9jF6OETO4yXzk9oJuCRfGUdOXfB4eNp6wYBWwDPa2y4+9vmS0PCzQsrTqrwMuGZKygavF2ACMn/ilY4A8Y/rGvUzdEeQ4wrmU95RJYC0rlXRcxtnKLt7DvQ7+wIEDdaOiqOa2CmYGHsQhVle4Q+esMutA8RF3sSWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5BE4BC2BD10;
	Mon, 17 Jun 2024 17:07:56 +0000 (UTC)
Date: Mon, 17 Jun 2024 13:07:54 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Bart Van Assche <bvanassche@acm.org>
Cc: dongliang cui <cuidongliang390@gmail.com>, Dongliang Cui
 <dongliang.cui@unisoc.com>, axboe@kernel.dk, mhiramat@kernel.org,
 mathieu.desnoyers@efficios.com, ebiggers@kernel.org, ke.wang@unisoc.com,
 hongyu.jin.cn@gmail.com, niuzhiguo84@gmail.com, hao_hao.wang@unisoc.com,
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 akailash@google.com
Subject: Re: [PATCH v5] block: Add ioprio to block_rq tracepoint
Message-ID: <20240617130754.3b4dbd62@rorschach.local.home>
In-Reply-To: <84e024ba-b921-481c-a83d-eec0dd0e8328@acm.org>
References: <20240614074936.113659-1-dongliang.cui@unisoc.com>
	<7d0f68b8-ecdb-45fb-ae10-954eac5ed32c@acm.org>
	<CAPqOJe1=+dqcapg-_Y+Fq9W61wDMMzDLzP+CQqcTW69WdKQqRw@mail.gmail.com>
	<84e024ba-b921-481c-a83d-eec0dd0e8328@acm.org>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 17 Jun 2024 10:02:48 -0700
Bart Van Assche <bvanassche@acm.org> wrote:

> >> Do we really want to include the constant "[0]" in the tracing output?  
> > This is how it is printed in the source code.
> >  From the code flow point of view, there is no need to print this value
> > in trace_block_rq_requeue.
> > Do we need to consider the issue of uniform printing format? If not, I
> > think we can delete it.  
> 
> I'm not aware of any other tracing statement that prints out a constant.
> Is there perhaps something that I'm missing or overlooking?

The only time that is done, is if the trace event is used in multiple
places and there's one place that the value will always be the same.

-- Steve
