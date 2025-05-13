Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0CF126868E;
	Tue, 13 May 2025 13:22:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747142560; cv=none; b=VJE+pTpJcIy9vyOGREFPYIkZ2gwQbdf3YUbt5HszsmlZR35dl/sgI5NjOqUUHJ7xPUeKDvf26m3H0D7G4aAiE8HLRHXA6Uh8o7ZRsdCAfK9jg9NrtAJbCasBbRs+iUHIX1Yw2xB2yqQdVSF8HEJoo+mXFa9U8gUj6e3uaB+ncso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747142560; c=relaxed/simple;
	bh=AYBGImU4JxAuokQBi+yhBoIxIhu5mhSguQdQWa0LSrk=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=uquNxa7XCSSKnuoBmPmmWwaaDYu609CvJYEbLPnB7aWxt1Nrmg4SUKkLSY6VSDK/nVI9ewqvOfPxdkxFI1NLdULOHTH0S55gPSo8PkviFutTeg8id87doUaxomT6a0w/qeSvS1WX1PZkq2HFpYjnJmOuGzhcGIDfDO3wiMxid1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JoTlH0rY; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JoTlH0rY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40A2CC4CEE4;
	Tue, 13 May 2025 13:22:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747142559;
	bh=AYBGImU4JxAuokQBi+yhBoIxIhu5mhSguQdQWa0LSrk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=JoTlH0rY06mrVkLc3fdgAaE8v+P1iplak1yCHw1mrVS9y8wWG3L+Um5x0rDDcykhS
	 WcpvNTySLARd+8counqcxajs9GNBoHJ9KCmJwoZVQwZHdoH806vDxg7Gpr8wddaVWW
	 e2hh2goOAmDRRMJPOfdVby9Cat5ru8RDJhPYRtY1/AIe8+AL2K/eGg/UIUjzHQopjp
	 hndlo7nUrJ0nVgntSbV9VqCfL+u9+KdTqbQP90D0abjUp13rwy+fZT/TtBaqp8o4eS
	 iK2o6hMkCcWXvDY9uI17FXY0eUr9K7/LKFSWt3zonVR8BKD5T+qX+k7mgfg5UrrNrD
	 U5DXK8aGoEUMw==
Date: Tue, 13 May 2025 22:22:35 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: axboe@kernel.dk, rostedt@goodmis.org, mathieu.desnoyers@efficios.com,
 akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
 linux-block@vger.kernel.org, linux-trace-kernel@vger.kernel.org, Jason Xing
 <kernelxing@tencent.com>, Yushan Zhou <katrinzhou@tencent.com>
Subject: Re: [PATCH v1 2/5] relayfs: introduce dump of relayfs statistics
 function
Message-Id: <20250513222235.33fd1817970cd601b18e92cf@kernel.org>
In-Reply-To: <CAL+tcoCThLOL1AKPamh2fpeDjYEqvEber0Eddc2ZVxi6VAYJkQ@mail.gmail.com>
References: <20250512024935.64704-1-kerneljasonxing@gmail.com>
	<20250512024935.64704-3-kerneljasonxing@gmail.com>
	<20250513185810.3d57dfe2a0c05784ddf8f0a9@kernel.org>
	<CAL+tcoCThLOL1AKPamh2fpeDjYEqvEber0Eddc2ZVxi6VAYJkQ@mail.gmail.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Tue, 13 May 2025 18:32:29 +0800
Jason Xing <kerneljasonxing@gmail.com> wrote:

> Hi Masami,
> 
> On Tue, May 13, 2025 at 5:58 PM Masami Hiramatsu <mhiramat@kernel.org> wrote:
> >
> > Hi Jason,
> >
> > On Mon, 12 May 2025 10:49:32 +0800
> > Jason Xing <kerneljasonxing@gmail.com> wrote:
> >
> > > From: Jason Xing <kernelxing@tencent.com>
> > >
> > > In this version, only support dumping the counter for buffer full and
> > > implement the framework of how it works. Users MUST pass a valid @buf
> > > with a valid @len that is required to be larger than RELAY_DUMP_BUF_MAX_LEN
> > > to acquire which information indicated by @flags to dump.
> > >
> > > RELAY_DUMP_BUF_MAX_LEN shows the maximum len of the buffer if users
> > > choose to dump all the values.
> > >
> > > Users can use this buffer to do whatever they expect in their own kernel
> > > module, say, print to console/dmesg or write them into the relay buffer.
> > >
> > > Reviewed-by: Yushan Zhou <katrinzhou@tencent.com>
> > > Signed-off-by: Jason Xing <kernelxing@tencent.com>
> > > ---
> > >  include/linux/relay.h | 10 ++++++++++
> > >  kernel/relay.c        | 35 +++++++++++++++++++++++++++++++++++
> > >  2 files changed, 45 insertions(+)
> > >
> > > diff --git a/include/linux/relay.h b/include/linux/relay.h
> > > index 022cf11e5a92..7a442c4cbead 100644
> > > --- a/include/linux/relay.h
> > > +++ b/include/linux/relay.h
> > > @@ -31,6 +31,15 @@
> > >  /*
> > >   * Relay buffer error statistics dump
> > >   */
> > > +enum {
> > > +     RELAY_DUMP_BUF_FULL = (1 << 0),
> > > +
> > > +     RELAY_DUMP_LAST = RELAY_DUMP_BUF_FULL,
> > > +     RELAY_DUMP_MASK = (RELAY_DUMP_LAST - 1) | RELAY_DUMP_LAST
> > > +};
> > > +
> > > +#define RELAY_DUMP_BUF_MAX_LEN 32
> > > +
> > >  struct rchan_buf_error_stats
> > >  {
> > >       unsigned int full;              /* counter for buffer full */
> > > @@ -170,6 +179,7 @@ extern int relay_late_setup_files(struct rchan *chan,
> > >                                 struct dentry *parent);
> > >  extern void relay_close(struct rchan *chan);
> > >  extern void relay_flush(struct rchan *chan);
> > > +extern void relay_dump(struct rchan *chan, char *buf, int len, int flags);
> > >  extern void relay_subbufs_consumed(struct rchan *chan,
> > >                                  unsigned int cpu,
> > >                                  size_t consumed);
> > > diff --git a/kernel/relay.c b/kernel/relay.c
> > > index b5db4aa60da1..0e675a77285c 100644
> > > --- a/kernel/relay.c
> > > +++ b/kernel/relay.c
> > > @@ -810,6 +810,41 @@ void relay_flush(struct rchan *chan)
> > >  }
> > >  EXPORT_SYMBOL_GPL(relay_flush);
> > >
> > > +/**
> > > + *   relay_dump - dump statistics of the specified channel buffer
> > > + *   @chan: the channel
> > > + *   @buf: buf to store statistics
> > > + *   @len: len of buf to check
> > > + *   @flags: select particular information to dump
> > > + */
> > > +void relay_dump(struct rchan *chan, char *buf, int len, int flags)
> > > +{
> > > +     unsigned int i, full_counter = 0;
> > > +     struct rchan_buf *rbuf;
> > > +     int offset = 0;
> > > +
> > > +     if (!chan || !buf || flags & ~RELAY_DUMP_MASK)
> > > +             return;
> > > +
> > > +     if (len < RELAY_DUMP_BUF_MAX_LEN)
> > > +             return;
> > > +
> > > +     if (chan->is_global) {
> > > +             rbuf = *per_cpu_ptr(chan->buf, 0);
> > > +             full_counter = rbuf->stats.full;
> > > +     } else {
> > > +             for_each_possible_cpu(i) {
> > > +                     if ((rbuf = *per_cpu_ptr(chan->buf, i)))
> > > +                             full_counter += rbuf->stats.full;
> > > +     }
> > > +
> > > +     if (flags & RELAY_DUMP_BUF_FULL)
> > > +             offset += snprintf(buf, sizeof(unsigned int), "%u", full_counter);
> > > +
> > > +     snprintf(buf + offset, 1, "\n");
> >
> > Is there any reason to return the value as string?
> > If it returns a digit value and the caller makes it a string,
> > it could be more flexible for other use cases.
> 
> Thanks for the feedback.
> 
> I will remove the above one as you pointed out in the next revision.
> And it seems unnecessary to add '\0' at the end of the buffer like
> "*buf = '\0';"?

Sorry, I think you missed my point. I meant it should be

/* Return the number of fullfilled buffer in the channel */
size_t relay_full(struct rchan *chan);

And keep the snprintf() in the blk_dropped_read() because that function
is responsible for formatting the output.

static ssize_t blk_dropped_read(struct file *filp, char __user *buffer,
 				size_t count, loff_t *ppos)
{
	struct blk_trace *bt = filp->private_data;
	char buf[16];
 
	snprintf(buf, sizeof(buf), "%zu\n", relay_full(bt->rchan));
 
 	return simple_read_from_buffer(buffer, count, ppos, buf, strlen(buf));
}

But the question is that what blk_subbuf_start_callback() counts
is really equal to what the relay_full() counts, because it seems
relay_full() just returns the current status of the channel, but
bt->dropped is the accumlated number of dropping events.

This means that if the client (reader) reads the subbufs the
number of full subbufs will be decreased, but the number of
dropped event does not change.

Can you recheck it?

Thank you,

> 
> While at it, I'm thinking if I can change the return value of
> relay_dump() to "how many bytes do we actually write into the buffer"?
> Does it sound better?
> 
> Thanks,
> Jason
> 
> >
> > Thank you,
> >
> > > +}
> > > +EXPORT_SYMBOL_GPL(relay_dump);
> > > +
> > >  /**
> > >   *   relay_file_open - open file op for relay files
> > >   *   @inode: the inode
> > > --
> > > 2.43.5
> > >
> >
> >
> > --
> > Masami Hiramatsu (Google) <mhiramat@kernel.org>


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
