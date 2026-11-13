Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=216.40.44.11
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794591416;
	b=D+u6RmLKZvpbQlQ5B8nSmz6lgF10xyzovNP/qpDT0o4lNERVO/a+Swe1sOlQQDu/WvpM
	 JjmjVVchZxeuR/3A4Te8/rx+7iNQx/vBL9DNgxlgyDBq5srVmeTsy7UvlnOVbyGkeOtTe
	 pkGyvT3P3ainE0264WlOQT6QDw6MKGQe6zz/Jn17G9Q9Im3vkANxecuynsaYkc/U4rWDT
	 Hfj6xnuvFU8Eyzw1icSyI35bh8esob99aL8/ncrj6szvvbDam3jGxO8i1OuRVvhkqU0r+
	 A4317Vm7RNEgft5b6GGLwKR6gpDHHgXW69h4At9e9RywR/gVfeeqRcqLC0MDPuWea0Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794591416;
	h=DMARC-Filter:Received:Received:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Spam-Status:X-Rspamd-Server:
	 X-Stat-Signature:X-Rspamd-Queue-Id:X-Session-Marker:X-Session-ID:
	 DKIM-Signature:X-HE-Tag:X-HE-Meta;
	bh=LQiCIvonuLx8A220NEYPOfjw1OhsHbpg/4uyaQR8I7o=;
	b=OUhuDP5WzQNBggzbtJQMlbB6EXwIT9HpyM+307ut7MS8a17cULaIJnSUsJLn750klROH
	 l5IZwQ7JsvaIKX48fgz7kGweFpDcOtcyONABzsob586F8Ff570cd2H8IG4ukBaDi5r2Zk
	 uUwGRcexHL0RExFU1gTpnB1oBg+LquNDERvRPZyt8hUvXm2UIJqu10j/XtIncrYpVpA+z
	 F6Sf5wAbGTlGOc2Tu6jcpLWj1kiTpe8f9tYiatRlGBTHwWdqM4Ugxe6YiLAZC9nnb+yA+
	 jjzkK7k5+6VZFyhJKHWWmwesp1G1TdLZbv+oJKWL4VN6yLPqq90B093i7wj66dq7qoA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=goodmis.org;
	spf=pass smtp.mailfrom=goodmis.org;
	dkim=pass header.d=goodmis.org header.i=@goodmis.org header.a=rsa-sha256 header.s=dkim1 header.b=vQfFN0Dz;
	arc=none smtp.remote-ip=216.40.44.11
Received: from relay.hostedemail.com (smtprelay0011.hostedemail.com [216.40.44.11])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E39FE6079D79;
	Fri, 13 Nov 2026 17:36:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E39FE6079D79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=goodmis.org header.i=@goodmis.org header.a=rsa-sha256 header.s=dkim1 header.b=vQfFN0Dz
Received: from omf16.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay07.hostedemail.com (Postfix) with ESMTP id 4DA96160293;
	Fri, 13 Nov 2026 17:36:47 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf16.hostedemail.com (Postfix) with ESMTPA id 3C77620013;
	Fri, 13 Nov 2026 17:36:45 +0000 (UTC)
Date: Fri, 13 Nov 2026 12:36:39 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Tahera Fahimi <taherafahimi@linux.microsoft.com>
Cc: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>, Yaxiong Tian
 <tianyaxiong@kylinos.cn>, axboe@kernel.dk, mathieu.desnoyers@efficios.com,
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v5 0/3] Tracing: Accelerate Kernel Boot by
 Asynchronizing
Message-ID: <20261113123639.1c014478@gandalf.local.home>
In-Reply-To: <avYiC0Csf45o44CQ@vm-dev.d0aziqou4eyuzblxqhi51nu2sc.xx.internal.cloudapp.net>
References: <20260204015103.155025-1-tianyaxiong@kylinos.cn>
	<20260204191552.881a00764093cf63557a372a@kernel.org>
	<20260206152511.41782db1@gandalf.local.home>
	<avYiC0Csf45o44CQ@vm-dev.d0aziqou4eyuzblxqhi51nu2sc.xx.internal.cloudapp.net>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: rspamout06
X-Stat-Signature: wq41m8hqon5hnrrodestcu99stsj7nrr
X-Rspamd-Queue-Id: 3C77620013
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX19ylmP1ak2tkDT7FvdGPbP5uW0RhH9pqu4=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=goodmis.org; h=date:from:to:cc:subject:message-id:in-reply-to:references:mime-version:content-type:content-transfer-encoding; s=dkim1; bh=LQiCIvonuLx8A220NEYPOfjw1OhsHbpg/4uyaQR8I7o=; b=vQfFN0DzJvcUWnImL7rjiativNqgZwosel7ruGW1Y5os1Qp8Eod0DcP4HEPj6BeV5yn993g0UOHEiTlilUYD/UbQWBFMCHDmvzvx9oUUQSScMMGw1AkQEH4CAuhfuSNF97Hq4vcc1rgsRjmKSf6/m7IBqFySRkW0kfNSDojrRew=
X-HE-Tag: 1794591405-292952
X-HE-Meta: U2FsdGVkX19CIcf+vibfiCDVNnrOn6Q61iRgCn9nVowSUXmxZzXsha4XyNgpzcaP7CiNHwwS5skg60gjt49GyTQhLydTQ3JRzyUUSOhyWWVi82d3WLKRBGCz6O3PTJV84Y4tr08Wn7ox1vu738gNh8QEH602Nlf3A6cblyl77ntupz/J0evdq1OfXiMEUK0c5oXKpLpTxNUOHYPw64eGDMqSsgFkSWSwFw8eoGtbbPClrXzNSUhnaEOaPMlzue/t1FZZtNO8txh4sb1n30HPOIgyt6olCOLWLJ9/egZuyO9wis2BJ/MEo3BOpxKmjNV2JNKpl+2ymWmBUmwAIaZogkG/R2cpJ2ru5lWFIs8LyOvfoUGWL/qn1g==

On Thu, 12 Nov 2026 13:31:07 -0700
Tahera Fahimi <taherafahimi@linux.microsoft.com> wrote:

> > > Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>  
> Hello all,
> 
> Following up on this series, I am evaluating the series on x86_64, with base kernel 6.1.192 and I
> see boot time improvement.
> 
> > Thanks, I'll add this to tracing/core.  
> Steve, would this series be suitable for queueing for an upcoming merge window?

Yeah, I'm working on it. With the AI bug fix explosion, I got buried and
fell behind. I'm trying to triage all the patches I have, which is over 160 :-p

But it's not forgotten.

-- Steve
