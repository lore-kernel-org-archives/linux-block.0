Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F63419924D;
	Tue, 13 May 2025 02:04:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747101869; cv=none; b=UHaES/RUaMxwshhmT1++bQAhXIdIcOK8cJqWxWJxbbxDdIqwqIBx+NUB/oqpugvnId4z5T8YlD/xBxCFxfU1/igK368QfiWKt0u9Gxt6tGX5vmaSuezhLGXYzuSCAUfdxACJC2tOKuBtWXz+jzf7DNkiDqw2Fi2BJ/G1IRoO1Vo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747101869; c=relaxed/simple;
	bh=j7lJShPXDvLRqpViinwmB8b87z+E5ER6/vsnTG72xwo=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=HUkMa1nmGl5Kr//HZJ8NLcKPEa/gdI15wCZUWxuGWfbuC8UaA38jayOrU0FWQiZ/cov8xoROe0dr1HCjmEppl2wvIouR9sK+H7vnAzmZ4w025SuIvIgDhftwN5wq7gv7RDvlZL1CVhIB96Y/KjvRCmGi0yaVH8slv/2fzzpGcQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=p/mIrb42; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="p/mIrb42"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85A03C4CEE7;
	Tue, 13 May 2025 02:04:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1747101868;
	bh=j7lJShPXDvLRqpViinwmB8b87z+E5ER6/vsnTG72xwo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=p/mIrb42A4bCdFbqWXAXHXoaxl6ZHd+zxG6jCyS4khDKCOy/ly4qvKlqHSyFWMJop
	 qx3wjilWIvJTX1Xg6SYkVqL4p81CNErg98rRMrqWaPMgil55/S96ArjcOqZnTFAD9Y
	 f8xU04fa2mWCo2iQb0ghFCELUoX0+rCob3a2kY98=
Date: Mon, 12 May 2025 19:04:27 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: axboe@kernel.dk, rostedt@goodmis.org, mhiramat@kernel.org,
 mathieu.desnoyers@efficios.com, linux-kernel@vger.kernel.org,
 linux-block@vger.kernel.org, linux-trace-kernel@vger.kernel.org, Jason Xing
 <kernelxing@tencent.com>, Yushan Zhou <katrinzhou@tencent.com>
Subject: Re: [PATCH v1 2/5] relayfs: introduce dump of relayfs statistics
 function
Message-Id: <20250512190427.b7fb67f6b78fd8699ea2811d@linux-foundation.org>
In-Reply-To: <CAL+tcoDk2TFwAWPwBN+dQQ+guxe71F_R1rFX_f9wozjPpujBAQ@mail.gmail.com>
References: <20250512024935.64704-1-kerneljasonxing@gmail.com>
	<20250512024935.64704-3-kerneljasonxing@gmail.com>
	<20250512175156.7d3d4db53d40c7a34c1f68d6@linux-foundation.org>
	<CAL+tcoDk2TFwAWPwBN+dQQ+guxe71F_R1rFX_f9wozjPpujBAQ@mail.gmail.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 13 May 2025 09:48:15 +0800 Jason Xing <kerneljasonxing@gmail.com> wrote:

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
> >
> > So we left the memory at *buf uninitialized but failed to tell the
> > caller this.  The caller will then proceed to use uninitialized memory.
> >
> > It's a programming error, so simply going BUG seems OK.
> 
> Are you suggesting that I should remove the above check because
> developers should take care of the length of the buffer to write
> outside of the relay_dump function? or use this instead:
> WARN_ON_ONCE(len < RELAY_DUMP_BUF_MAX_LEN);
> ?

It's a poor interface - it returns uninitialized data while not
alerting the caller to this.  You'll figure something out ;)

Perhaps

	BUG_ON(len < RELAY_DUMP_BUF_MAX_LEN);
	*buf = '\0';
	if (!chan || (flags & ~RELAY_DUMP_MASK))
		return;

We don't need to check for !buf - the oops message contains the same info.

Maybe we don't need to check !chan either.  Can it be NULL here?


