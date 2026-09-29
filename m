Received: from mta0.migadu.com (out-195.mta0.migadu.com [91.218.175.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A27F52BE2D
	for <linux-block@vger.kernel.org>; Tue, 29 Sep 2026 13:47:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790689635; cv=none; b=ns55xl4Uz2EoapEv6i9RYfYGhAxK9nJSPaQ8l1NdceoLBFo53F/Sl/qSQPEzk79Z0SfVZNRBrUEmIk929y8bg/1YRp5EXksuSVD4n0Dd1MgzC5rmQ47EMV9N+1Q76fIBECqTeZuRT9N8UPYcnkfJIemDzEJZgdgZBARtxp1DNls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790689635; c=relaxed/simple;
	bh=WrPfgETFw2Wn26KAsjIVoHMpa4pEd1Ar2QFOaJ6P6ow=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=UG/ZngDqDHLBJsExSgoWZRtA/7neyja8E2x8pINQR7RQTUyFFs1HgswQt/5Kovs3iy6qHOYd9f7vZO2k+Rb+tDpXqTjiozSaSKj9aklTUsrPdaOQWhE6dFZtJdAgsd8tQ/WMrXkh4qeELUCnu1jW3ndcr1vWypMKi9pePdq7rmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=cZ5NYwX5; arc=none smtp.client-ip=91.218.175.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="cZ5NYwX5"
X-Envelope-To: linux-block@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=WrPfgETFw2Wn26KAsjIVoHMpa4pEd1Ar2QFOaJ6P6ow=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1790689631; v=1; x=1791294431;
 b=cZ5NYwX5Z3UHOpSBYiQw8SP7KPYmuhR+2dY4fPrmNvC+U/zjpyB9BOxH13V2ezAPL6v+PVAA
 idDk7LCUVJJJDqMtUO8x+a8yW2DFEMLNyQ0lPDN8L62ki3SARCMvErVTVOd8kpONPj9OtPuGxPp
 LmlaiSO6s9oh/bHnLx0ikh+c=
X-Envelope-To: linux-block@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 3d76b2bad85621cf;
	Tue, 29 Sep 2026 13:47:01 +0000
X-Mizu-Trace-ID: 3d76b2bad85621cf
X-Migadu-Flow: FLOW_OUT
Message-ID: <870cf576-a5b0-4390-ac8d-5ccfea2c82fe@linux.dev>
Date: Tue, 29 Sep 2026 21:46:56 +0800
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: cui.tao@linux.dev, josef@toxicopanda.com, axboe@kernel.dk,
 cgroups@vger.kernel.org, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org, andrii@kernel.org,
 eddyz87@gmail.com, ast@kernel.org, daniel@iogearbox.net,
 linux-kselftest@vger.kernel.org, Tao Cui <cuitao@kylinos.cn>,
 ameryhung@gmail.com, alexei.starovoitov@gmail.com
Subject: Re: [RFC PATCH v7 3/4] blk-iocost: add iocost_ioc_tick tracepoint for
 per-period device summary
To: Tejun Heo <tj@kernel.org>
References: <20260924054549.2271705-1-cui.tao@linux.dev>
 <20260924054549.2271705-4-cui.tao@linux.dev>
 <4af70c48e8c7d1eac1425d368be92dcb@kernel.org>
From: Tao Cui <cui.tao@linux.dev>
In-Reply-To: <4af70c48e8c7d1eac1425d368be92dcb@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hello, Tejun.

在 2026/9/29 08:42, Tejun Heo 写道:
> Hello, Tao.
> 
> On Thu, 24 Sep 2026 13:45:48 +0800, Tao Cui wrote:
> 
>> +	trace_iocost_ioc_tick(ioc, nr_active, usage_us_sum,
>> +			      ioc->period_us, ioc->vtime_base_rate,
>> +			      ioc->busy_level, ioc->running,
>> +			      now.now - ioc->period_at);
> 
> These are still passed in. Can you pass only ioc, &now, nr_active and
> usage_us_sum and read the rest from ioc in TP_fast_assign() like the
> other iocost events do?
> 

Done.  The event now takes only ioc, &now, nr_active and
usage_us_sum.  TP_fast_assign() reads period_us, vrate, busy_level
and running from ioc directly, and derives the elapsed period for
the usage percentage as now->now - ioc->period_at.

Thanks.
Tao> Thanks.
> 
> --
> tejun

