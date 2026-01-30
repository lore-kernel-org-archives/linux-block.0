Received: from relay.hostedemail.com (smtprelay0015.hostedemail.com [216.40.44.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2B557E0E8;
	Fri, 30 Jan 2026 03:26:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769743581; cv=none; b=XXMEIEGU8u/X4mx+JK7hiXaF9hvZ5utWMxswI5zlIne0gRbkSJZeRk/aigKw2Ze+FPFnxO9wA+ALFgRp7RsUUR/JIHVsWuhsbq0xEzQFo5RR/zazkXQz0sXSW/CdhWtBv1rYYLZsPXbj1nud15al9UH1E2/ozDaeaaY/S/AuXEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769743581; c=relaxed/simple;
	bh=HBQS152Mw0IXJPnR5nbgNusqYpqCTZQzkBb2wDH79pU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cHuN9785epgdAJVuBnbnl0wNCmuPouMxCMY/mCgM4YwbT5gReXxetmtOI4Nq58LTIMcUgn4+s0e1sETregnCoxRhvSer+uh5TuG0F8RAcR9kO6IemKU2zZQrZXpfF7nd0G132MRK2e9fnsWv7dsgxPuElreJ0q32mSFNJAYQIe4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf07.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay08.hostedemail.com (Postfix) with ESMTP id 69F21140348;
	Fri, 30 Jan 2026 03:26:12 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf07.hostedemail.com (Postfix) with ESMTPA id 363202002E;
	Fri, 30 Jan 2026 03:26:10 +0000 (UTC)
Date: Thu, 29 Jan 2026 22:26:08 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Yaxiong Tian <tianyaxiong@kylinos.cn>
Cc: Jens Axboe <axboe@kernel.dk>, mhiramat@kernel.org,
 mathieu.desnoyers@efficios.com, corbet@lwn.net, skhan@linuxfoundation.org,
 linux-trace-kernel@vger.kernel.org, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH v4 5/5] blktrace: Make init_blk_tracer() asynchronous
 when trace_async_init set
Message-ID: <20260129222608.7000bffd@robin>
In-Reply-To: <a61e6bc0-58d1-46f0-8a4f-17f02503fe17@kylinos.cn>
References: <20260128194104.30051be1@gandalf.local.home>
	<56C8934E-3D17-4467-93E6-D813770BF577@kernel.dk>
	<20260129152958.05c1ca46@gandalf.local.home>
	<bb29a10c-6130-4040-8521-0b5375c017ef@kylinos.cn>
	<a61e6bc0-58d1-46f0-8a4f-17f02503fe17@kylinos.cn>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: rspamout06
X-Rspamd-Queue-Id: 363202002E
X-Stat-Signature: 63ezdrjoofk7jup95bori3da8fc1f3ad
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX19YFBScFr3TMXDbKj7ztEZxpTuoqiC5kHU=
X-HE-Tag: 1769743570-586980
X-HE-Meta: U2FsdGVkX181ZMMbQ4KKLYJOtTQlrwzFnxbcTmizDfrmUrkd+/3HvvVYGyeXHl2El0Jcqd97157wGEy15nSgaAMB6CywAgXf89VCKcI2wGXdzPJZ39Twpl3RNsTGyNFQTZOO+RWP6ul7Ntk2FTIUpK8kX5zMZ6Rzhlmzobye5QzsB/rMEzFhMIVdqiyD19C/ktUA12dGK8GX1K7TfKDNu4nVRNdZz6Ym5/UOrw4M2lShZHVe/jzFKtFdVdeTOabTuMcJzaduBsr1NvLHXsLCMCzO1m58tyRtru84/EM5Wr6TSlcCQTahXKy1FOI97UDV

On Fri, 30 Jan 2026 11:09:26 +0800
Yaxiong Tian <tianyaxiong@kylinos.cn> wrote:

> > thought|trace_eval_sync()|'s|destroy_workqueue()|would wait for all=20
> > tasks to complete, but it seems that might not be the case. From this,=
=20
> > if the above conclusion is true, then strictly speaking, tasks=20
> > using|queue_work(xx)|cannot be guaranteed to finish before the init=20
> > process executes. If it's necessary to strictly ensure initialization=20
> > completes before user space starts,=20
> > using|async_synchronize_full()|or|async_synchronize_full_domain()|would=
=20
> > be better in such scenarios. =20
> I need to double-check this issue=E2=80=94theoretically, it shouldn't exi=
st. But=20
> I'm not sure why the print appeared at the 14-second mark.

Use trace_printk() instead. printk now has a "deferred" output. I'm not
sure if the timestamps of when it prints is when the print took place
or when it got to the console :-/

-- Steve


> >
> > Of course, the situation described above is an extreme case. I don't=20
> > oppose this approach; I only hope to make the startup faster for=20
> > ordinary users who don=E2=80=99t use trace, while minimizing the impact=
 on=20
> > others as much as possible.
> > =20
