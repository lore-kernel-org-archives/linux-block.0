Received: from relay.hostedemail.com (smtprelay0013.hostedemail.com [216.40.44.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0A20352C40;
	Thu, 29 Jan 2026 20:29:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769718591; cv=none; b=XN0k2F58OtB4eiXLowUxgSElypi7XpT7ix0lrQqUBnr0btuKHQTZ3TtdxLHkEZNCDZFmHjXRS4PXkx4jLgG28gOU585q48PGrCQRmxWQ0cCHmAH2GZUa9bj8TJrsuqc3SVnOOcgSl+Pj5Rad1yJNFK0CGpJL1epRo3tFfT4jPmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769718591; c=relaxed/simple;
	bh=4qJbSptnmcF43KW9k9yEejbJpKYWg/JMhClRakopTQI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eVbQnHKsI7LckCPf6PmIgKcwbnlolyeSjyJQ/9ykYJvnyjFQ8sdYh12x+Nypdh2TKKidVdZZfwAluqg+tQakHaYQ3KyG9RfUlaqWryMcyjiQdl5AEW4+AJmYkhfsP5ruCphkxWJ5wkQzSdPE9wtroHTkI04SLZa7ldIfiCUtg1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf13.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay04.hostedemail.com (Postfix) with ESMTP id 4B0141A02E0;
	Thu, 29 Jan 2026 20:29:48 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf13.hostedemail.com (Postfix) with ESMTPA id 0C50320010;
	Thu, 29 Jan 2026 20:29:45 +0000 (UTC)
Date: Thu, 29 Jan 2026 15:29:58 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: Yaxiong Tian <tianyaxiong@kylinos.cn>, mhiramat@kernel.org,
 mathieu.desnoyers@efficios.com, corbet@lwn.net, skhan@linuxfoundation.org,
 linux-trace-kernel@vger.kernel.org, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH v4 5/5] blktrace: Make init_blk_tracer() asynchronous
 when trace_async_init set
Message-ID: <20260129152958.05c1ca46@gandalf.local.home>
In-Reply-To: <56C8934E-3D17-4467-93E6-D813770BF577@kernel.dk>
References: <20260128194104.30051be1@gandalf.local.home>
	<56C8934E-3D17-4467-93E6-D813770BF577@kernel.dk>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 0C50320010
X-Stat-Signature: b33d9fd4ichz7wyqqzjufmukuixmzmni
X-Rspamd-Server: rspamout05
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX19qkA0wJOpiwjiiKOANYpARcGxp1NJrOCw=
X-HE-Tag: 1769718585-900540
X-HE-Meta: U2FsdGVkX18NrxCl9h9TMLWr6AHyg4XoMaI4xsFj/zTKMfdNpCY1eMAjTIojzsFqilHKPXu6nzLw3efnC1YKbyCN8QRwd7HBONn2XrNuIGa3NsH7cf2+l3Ziq9pPI7riuNsWui6B1bqIpmRWlIqRcJWv29+PD2M9Y1aqpTdAvqVxryvIDcF7FKrJGnZEkDcs1IyUewHfMtBdQdOYmVPRiuF3vOUyabAzzUs8XtRwdK86jtCKk8yTofnohI/3LizIi+3Wpx7izDMU+bIvo1Pbu5teogmir4QLXasV7gnUrVCLqKToescXf9eAiIBXwi9TTkvTH8DDVqrn2nqar9F0PAToSB1aHyOtE17gIk8IgE8svr1vatd5f2FxSEKZzPoT

On Wed, 28 Jan 2026 19:25:46 -0700
Jens Axboe <axboe@kernel.dk> wrote:

> On Jan 28, 2026, at 5:40=E2=80=AFPM, Steven Rostedt <rostedt@goodmis.org>=
 wrote:
> >=20
> > =EF=BB=BF
> > Jens,
> >=20
> > Can you give me an acked-by on this patch and I can take the series thr=
ough
> > my tree. =20
>=20
> On phone, hope this works:
>=20
> Acked-by: Jens Axboe <axboe@kernel.dk>

Thanks!

>=20
> > Or perhaps this doesn't even need to test the trace_async_init flag and=
 can
> > always do the work queue? Does blk_trace ever do tracing at boot up? Th=
at
> > is, before user space starts? =20
>=20
> Not via the traditonal way of running blktrace.

Masami and Yaxiong,

I've been thinking about this more and I'm not sure we need the
trace_async_init kernel parameter at all. As blktrace should only be
enabled by user space, it can always use the work queue.

For kprobes, if someone is adding a kprobe on the kernel command line, then
they are already specifying that tracing is more important.

Patch 3 already keeps kprobes from being an issue with contention of the
tracing locks, so I don't think it ever needs to use the work queue.

Wouldn't it just be better to remove the trace_async_init and make blktrace
always use the work queue and kprobes never do it (but exit out early if
there were no kprobes registered)?

That is, remove patch 2 and 4 and make this patch always use the work queue.

-- Steve
