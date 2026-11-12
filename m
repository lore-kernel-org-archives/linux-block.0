Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=13.77.154.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794515483;
	b=Q0NpyhRu3jDD1ihxZ4ZIo1j3Za5Sp2heYtsVo3SjOFg4lTVpb1lG189jaPrTHK1BEYWg
	 Z/yN+XTrkGNUGUN1s/sCNIGrs/wu/Smi0jYr+yrElOz70oN0cxL/+ZWOX+kS52uYuShKU
	 qJMq/trlafQekVSr8o0TycYDzs513jUQRB7iTDw3C/fhdHUEafKukCpEHABK/0t/adGp1
	 ksyZZ+vJcpToFvuEQqc/mRFSHl1+KBD48w7GF74PwVFd8fyPFT5PB5rsJcmKPE7jOx50n
	 x6kZQLxwgtkf3Z2Lx1GwJ3QT/joZifzWI28Iryh+nR+lnpo1kwYd4CuAz0uOD4s4kaA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794515483;
	h=DMARC-Filter:Received:DKIM-Filter:DKIM-Signature:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-Spam-Status:X-Spam-Checker-Version;
	bh=+Mws4qymTJcNUhGtjGCXpJPWsRTgs5A+EyptBbipnB0=;
	b=3wuRNpJG4tGE8SkJbY8pW7TQyjz4EIUCWYURJCT1mwgOE17NUGcppD2el3266qpDIsb7
	 A6lEe8YCK6wu0KFMOrM/penk3ynjwMJjdciaDISOzxNuuZeC8YhorcSL2iAjomig/BVPY
	 rxRRIhQK58Cj/Ywse5i5XApZWdwIF75zfhRrTUw+Dmw60LNcCQH3VM03jHgJxCtBSPanZ
	 BZkMbT4F+2Wg4O8rqoriGeljzs4srbSIk1FoumgGfNXhoCLqrARxxXGRJuHWEYmBBZ7xj
	 fd12FnagAbnTu0sQg95pIVxQFNyjfFDvexha221Mg56GbCurRNDPeA9B6pXxfU6E2Hg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.microsoft.com;
	spf=pass smtp.mailfrom=linux.microsoft.com;
	dkim=pass header.d=linux.microsoft.com header.i=@linux.microsoft.com header.a=rsa-sha256 header.s=default header.b=Y9xqWS1S;
	arc=none smtp.remote-ip=13.77.154.182
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 618FD606A31C;
	Thu, 12 Nov 2026 20:31:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 618FD606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.a=rsa-sha256 header.s=default header.b=Y9xqWS1S
Received: from vm-dev.d0aziqou4eyuzblxqhi51nu2sc.xx.internal.cloudapp.net (unknown [4.246.87.102])
	by linux.microsoft.com (Postfix) with ESMTPSA id 0314420B716D;
	Thu, 12 Nov 2026 12:31:19 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 0314420B716D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1794515479;
	bh=+Mws4qymTJcNUhGtjGCXpJPWsRTgs5A+EyptBbipnB0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Y9xqWS1SHJtm6kzo6v68NpWz9uL1VyJqdkBy5Dg7SdryNv5X5lvE9J5l1uOJ5zJnk
	 wwadLzUgubsnPQmKuNkSGjFA6Fbz93R1vRXQkpa9/IsJITdUmL6VlNcQX/X8B01J06
	 421NIuMwU/RchtxPc3+lfKw/AddPabV4NY6cfoE8=
Date: Thu, 12 Nov 2026 13:31:07 -0700
From: Tahera Fahimi <taherafahimi@linux.microsoft.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
	Yaxiong Tian <tianyaxiong@kylinos.cn>, axboe@kernel.dk,
	mathieu.desnoyers@efficios.com, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v5 0/3] Tracing: Accelerate Kernel Boot by Asynchronizing
Message-ID: <avYiC0Csf45o44CQ@vm-dev.d0aziqou4eyuzblxqhi51nu2sc.xx.internal.cloudapp.net>
References: <20260204015103.155025-1-tianyaxiong@kylinos.cn>
 <20260204191552.881a00764093cf63557a372a@kernel.org>
 <20260206152511.41782db1@gandalf.local.home>
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260206152511.41782db1@gandalf.local.home>

On Fri, Feb 06, 2026 at 03:25:11PM -0500, Steven Rostedt wrote:
> On Wed, 4 Feb 2026 19:15:52 +0900
> Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:
> 
> > Looks good to me.
> > 
> > Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Hello all,

Following up on this series, I am evaluating the series on x86_64, with base kernel 6.1.192 and I
see boot time improvement.

> Thanks, I'll add this to tracing/core.
Steve, would this series be suitable for queueing for an upcoming merge window?

Thanks,
Tahera
> -- Steve
