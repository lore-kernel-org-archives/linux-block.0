Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A18A3C00;
	Wed, 14 May 2025 01:29:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747186155; cv=none; b=ZEu1elu9OyxwpHpSmcHEbrYmtEC6bAFKSOaxh27c+hw7lv1Qr9MwLIyqRVRSBRhLnEIP93UyyU+falaa7fsMw0fsCj5XW+X3IlosmcakWUK1xtVTh4AIj2o6Jct/aEyJYtfJrSKbMWNi5nShQEO5ki84ikMD5VKNmxL80E7q0Kw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747186155; c=relaxed/simple;
	bh=tIxAuEYnljGjkk9cCz3K7jL4A7gXJkGqZfQOtkiSMU0=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=H0TNxig8MT+qZViR3rGDB59D27UMzqsSayFrD+sppn475o7F7HXtBLLU584fDD3KlK9a32U2F1DejNZMePzjQR6nnp0ODdQ0TDrsObX1EzLNXJ4XkQrjXRO6o5XYhS9jnWO+nuJHgdMdw+vk29/dRHOmbeau5C5ECh7KEPv/whI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QX5wsP0E; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QX5wsP0E"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9229C4CEE4;
	Wed, 14 May 2025 01:29:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747186154;
	bh=tIxAuEYnljGjkk9cCz3K7jL4A7gXJkGqZfQOtkiSMU0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=QX5wsP0EU+Bv1NtlmbwOfFo5kkJSBrZwYnw8x3v7I1qXjA9BjORuMJQvo9qF6zgbY
	 rG2LJLibSlBN4VRSUJz9FF8b1Ne6NApwn2q3gCGsci3ryMBWGXOkOp8pmYvjW076dD
	 JfimgpS17foisa6rIVoMbdr6X20BRKc1EygcYtqYPXyVE0F7enAKbh5KDxdfc5M8CL
	 ek46l97RUI0XArPBd21mFeagOuWwJnczGcMr8clRrdAZSKdaV76NYyOKTiYEv6BhWW
	 FB0kGQLBXukLJlFjw6J2ygoH+/24hROdZ5Ct/H08haNoplKRyY8L8nMHaQptfsj6+y
	 tr4JrRpd0kIqg==
Date: Wed, 14 May 2025 10:29:08 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: axboe@kernel.dk, rostedt@goodmis.org, mathieu.desnoyers@efficios.com,
 akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
 linux-block@vger.kernel.org, linux-trace-kernel@vger.kernel.org, Jason Xing
 <kernelxing@tencent.com>, Yushan Zhou <katrinzhou@tencent.com>
Subject: Re: [PATCH v1 2/5] relayfs: introduce dump of relayfs statistics
 function
Message-Id: <20250514102908.6a431966ef5b0f5f197bdb48@kernel.org>
In-Reply-To: <CAL+tcoAGCdowY14QL7HEqbW3ewAJi0OXpWNVkbqq9cM6xRmLkg@mail.gmail.com>
References: <20250512024935.64704-1-kerneljasonxing@gmail.com>
	<20250512024935.64704-3-kerneljasonxing@gmail.com>
	<20250513185810.3d57dfe2a0c05784ddf8f0a9@kernel.org>
	<CAL+tcoCThLOL1AKPamh2fpeDjYEqvEber0Eddc2ZVxi6VAYJkQ@mail.gmail.com>
	<20250513222235.33fd1817970cd601b18e92cf@kernel.org>
	<CAL+tcoAGCdowY14QL7HEqbW3ewAJi0OXpWNVkbqq9cM6xRmLkg@mail.gmail.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 13 May 2025 21:46:25 +0800
Jason Xing <kerneljasonxing@gmail.com> wrote:

> > > > > +
> > > > > +     if (flags & RELAY_DUMP_BUF_FULL)
> > > > > +             offset += snprintf(buf, sizeof(unsigned int), "%u", full_counter);
> > > > > +
> > > > > +     snprintf(buf + offset, 1, "\n");
> > > >
> > > > Is there any reason to return the value as string?
> > > > If it returns a digit value and the caller makes it a string,
> > > > it could be more flexible for other use cases.
> > >
> > > Thanks for the feedback.
> > >
> > > I will remove the above one as you pointed out in the next revision.
> > > And it seems unnecessary to add '\0' at the end of the buffer like
> > > "*buf = '\0';"?
> >
> > Sorry, I think you missed my point. I meant it should be
> >
> > /* Return the number of fullfilled buffer in the channel */
> > size_t relay_full(struct rchan *chan);
> >
> > And keep the snprintf() in the blk_dropped_read() because that function
> > is responsible for formatting the output.
> 
> Oh, sorry, it's not what I want because (please see patch [4/5] [1])
> relay_dump() works to print various statistics of the buffer. In this
> patch, 'full' counter is the first one.
> 
> [1]: https://lore.kernel.org/all/20250512024935.64704-5-kerneljasonxing@gmail.com/

Yes, that's why I asked you to make it just returning raw value.
The string formatting of those values is blk_dropped_read()s business
(because it is a 'read' callback), not for relayfs.

For example, other relayfs user wants to summarize the values or
calculate the percentage form that value. Also, we don't need to
bother to check the buffer size etc, because blk_dropped_read()
knows that.

> 
> >
> > static ssize_t blk_dropped_read(struct file *filp, char __user *buffer,
> >                                 size_t count, loff_t *ppos)
> > {
> >         struct blk_trace *bt = filp->private_data;
> >         char buf[16];
> >
> >         snprintf(buf, sizeof(buf), "%zu\n", relay_full(bt->rchan));
> >
> >         return simple_read_from_buffer(buffer, count, ppos, buf, strlen(buf));
> > }
> >
> > But the question is that what blk_subbuf_start_callback() counts
> > is really equal to what the relay_full() counts, because it seems
> > relay_full() just returns the current status of the channel, but
> > bt->dropped is the accumlated number of dropping events.
> >
> > This means that if the client (reader) reads the subbufs the
> > number of full subbufs will be decreased, but the number of
> > dropped event does not change.
> 
> At least in this series, I didn't give the 'full' counter any chance
> to decrement, which means it's compatible with blktrace, unless
> __relay_reset() is triggered :)

Ah, OK. I missed what [1/5] does. I agree that this does the
same thing.

> 
> While discussing with you on this point, I suddenly recalled that in
> some network drivers, they implemented 'wake' and 'stop' as a pair to
> know what the current status of a certain queue is. I think I can add
> a similar thing to the buffer about 1) how many times are the buffer
> full, 2) how many times does the buffer get rid of being full.

Sounds nice.

Thank you,

> 
> Thanks,
> Jason
> 
> >
> > Can you recheck it?
> >
> > Thank you,
> >
> > >
> > > While at it, I'm thinking if I can change the return value of
> > > relay_dump() to "how many bytes do we actually write into the buffer"?
> > > Does it sound better?
> > >
> > > Thanks,
> > > Jason
> > >
> > > >
> > > > Thank you,
> > > >
> > > > > +}
> > > > > +EXPORT_SYMBOL_GPL(relay_dump);
> > > > > +
> > > > >  /**
> > > > >   *   relay_file_open - open file op for relay files
> > > > >   *   @inode: the inode
> > > > > --
> > > > > 2.43.5
> > > > >
> > > >
> > > >
> > > > --
> > > > Masami Hiramatsu (Google) <mhiramat@kernel.org>
> >
> >
> > --
> > Masami Hiramatsu (Google) <mhiramat@kernel.org>


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
