Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B3A728EC11;
	Thu, 22 May 2025 23:34:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747956859; cv=none; b=nCVQTT9WF4rSy7tzoiQ1pvRCY9/55sie86232/80e97u9Wz94aAT6GdzCHe7xA2So5DqGREd0ejpsfxi2FvKiLjvToaGSWtJJBiaU60aQnVClbwfrEQEpHFakIldV2AYXmrC0DpmBBl2ZyL63f97ZToGr6DOGGhXpYTYe3XatHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747956859; c=relaxed/simple;
	bh=fXmVTVXrbzmhPMkPj/9H+yAuOPsGSaY5GJ5IfTWrlaI=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=ZiMBz1piqufGZwJXL9u85tcLWBSbm6F3+z+CLKOXfYRNIWedJzPHyA+W/W5hqqZmiJBHAJ+tcVfwRA9aFKbY8oP6JIU9XTBaq681geYRFkGCMiGVKeiL1ZSJ0iLAtYNZvq2uBSiEJ3dNCyozHBSOcAIEA881g2V0fbk2lLVTxn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=ZuH8Xulo; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="ZuH8Xulo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E09F1C4CEE4;
	Thu, 22 May 2025 23:34:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1747956859;
	bh=fXmVTVXrbzmhPMkPj/9H+yAuOPsGSaY5GJ5IfTWrlaI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ZuH8XuloJQd5oGqJs2tSkvCaOzzviZgiTpfCALRWkIm7Kgd9FdygZKmGrn3UxctHq
	 8p1XtVDhNdboq8Ct8KwwX1gH7n9Gb2+pAaPfcYj1a+iXS2pgYA/eCkcIqEO4ZOINUs
	 LqyBOXZyKAOLBjVIzjbSzoeZD1+wsSXj629vfsGU=
Date: Thu, 22 May 2025 16:34:18 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: axboe@kernel.dk, rostedt@goodmis.org, mhiramat@kernel.org,
 mathieu.desnoyers@efficios.com, linux-kernel@vger.kernel.org,
 linux-block@vger.kernel.org, linux-trace-kernel@vger.kernel.org, Jason Xing
 <kernelxing@tencent.com>
Subject: Re: [PATCH v3 0/4] relayfs: misc changes
Message-Id: <20250522163418.f14da5eea065296d42ee3497@linux-foundation.org>
In-Reply-To: <CAL+tcoCD5ORW=JqvZg7=uJXkLi-WTG-Szj1k8ya9sX6LcR41jQ@mail.gmail.com>
References: <20250518025734.61479-1-kerneljasonxing@gmail.com>
	<CAL+tcoCD5ORW=JqvZg7=uJXkLi-WTG-Szj1k8ya9sX6LcR41jQ@mail.gmail.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Fri, 23 May 2025 07:16:35 +0800 Jason Xing <kerneljasonxing@gmail.com> wrote:

> On Sun, May 18, 2025 at 10:57 AM Jason Xing <kerneljasonxing@gmail.com> wrote:
> >
> > From: Jason Xing <kernelxing@tencent.com>
> >
> > The series mostly focuses on the error counters which helps every user
> > debug their own kernel module.
> >
> > ---
> > Note: this series is made on top of this cleanup[1] and unmerged commit[2]
> > [1]: https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git/log/?h=mm-nonmm-unstable
> > [2]: https://lore.kernel.org/all/20250507134225.63248-1-kerneljasonxing@gmail.com/
> >
> > Jason Xing (4):
> >   relayfs: support a counter tracking if per-cpu buffers is full
> >   relayfs: introduce getting relayfs statistics function
> >   blktrace: use rbuf->stats.full as a drop indicator in relayfs
> >   relayfs: support a counter tracking if data is too big to write
> >
> >  include/linux/relay.h   | 19 ++++++++++++++-
> >  kernel/relay.c          | 52 +++++++++++++++++++++++++++++++++++------
> >  kernel/trace/blktrace.c | 22 ++---------------
> >  3 files changed, 65 insertions(+), 28 deletions(-)
> 
> Hi Andrew,
> 
> Any comments on the series?
> 

We're at -rc7 now, so I'll park this for consideration for -rc1.

