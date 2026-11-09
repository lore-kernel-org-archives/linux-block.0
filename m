Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.88
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794229567;
	b=s6kWRVyc50Kdo7XpWKqDO8Jsy44XDkYikVWbaXO88bL6PjrIuFlxxceNgVq+HODKzTJV
	 i2VWhMzcM/v/syl3kD23jHK9v+pdn2m43S9dsEV3J5cUgjkUdTz7zIxx903RoiJDMGcM6
	 k150qgGPpaoJffAAJOYjnDYtYLSDD00b3BRTeERF3MSfKdBnMcF29CQUQu9gX+N/9ie5W
	 5BcIDyI6JbgG3vZFMLP9kD5QcjyvyU+GoY9yiXidPoou6KdBW/MJKR++AyKiMuQgCe2Un
	 baPu/joetIXSK3+pNjfAhFWfxnqkoLrN5Lqc0MbBuwrqZwlJvWnGf5v5wV9JwVlBqFA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794229567;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Message-ID:Date:MIME-Version:User-Agent:
	 Cc:Subject:To:References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=91+PrshXlXFSwP6fmMo9THAMzpUAzOQonBKifsHDzvY=;
	b=5VlKSEggmsMoMrAbsAWjcWmvZG3bDBP5RFsBHbhlMyLBNk0FQkAQkJ5UqSijM4rJkMRz
	 k1QyHLnf4Ye0mZH0Px9qSHgA5568kQcWuMyPtVeiy0i1KccP+AlBKFX5MRWQUl5QmiFJ7
	 Ze1gvkMgD6DH91ZkM1bM9jvPCGi7xC5vwZcMKf3Z350xstqZH5hQudvXQvT6VAEltaR4z
	 MTNqARVh243Zr6JXsEvH2r4qtORD6/AkvO1ujbAz054VlvuXi9BFz5FFmwDyLoBISubRn
	 xGM4yHxyJUrz5N+mGvdeIYk8quIy4p++TdaAGa3FJPjYX3qINVFokigbrLZYKZ67amA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	arc=none smtp.remote-ip=91.218.175.88
Received: from mta0.migadu.com (out-88.mta0.migadu.com [91.218.175.88])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B415606A325
	for <linux-block@vger.kernel.org>; Mon,  9 Nov 2026 13:06:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2B415606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: linux-block@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=Vb2HvE4C+LsP6a08cxDbF41GOuV0T8q7dEJG6iihUxU=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1794229563; v=1; x=1794834363;
 b=W1CodLmtnLn5HrTpardRoGaMj16hktHrXTVqdiPkFobfGU4JR+kU4IM5lmByKudj3VepudO6
 mFHukN3TlUy/MJ3hp18VecbNkd8LmVg7jgc/R0p+EtlzOnt5Yb+w2yCu4aQjS3UcDBdl8n9o+1P
 ocGDrW3Cz4dlvwmAnvcujZc0=
X-Envelope-To: linux-block@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 7c06950158a956d2;
	Mon, 09 Nov 2026 13:06:03 +0000
X-Mizu-Trace-ID: 7c06950158a956d2
X-Migadu-Flow: FLOW_OUT
Message-ID: <1c4078e4-dd6a-4a70-bdda-d5cded19937a@linux.dev>
Date: Mon, 9 Nov 2026 21:05:53 +0800
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: cui.tao@linux.dev, cgroups@vger.kernel.org, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org, andrii@kernel.org,
 eddyz87@gmail.com, ast@kernel.org, daniel@iogearbox.net,
 linux-kselftest@vger.kernel.org, cuitao@kylinos.cn, ameryhung@gmail.com,
 martin.lau@kernel.org, yonghong.song@linux.dev, mason@kernel.org,
 ihor.solodrai@linux.dev
Subject: Re: [RFC PATCH v13 2/4] blk-iocost: add iocost_ioc_tick tracepoint
 for per-period device summary
To: bot+bpf-ci@kernel.org, tj@kernel.org, josef@toxicopanda.com,
 axboe@kernel.dk, alexei.starovoitov@gmail.com
References: <20261106122356.3224638-3-cui.tao@linux.dev>
 <ebb6ebc5ddce3089fe912ca2d6e7a0658864c7369d15e1cdb7f203eae6d5a0d0@mail.kernel.org>
From: Tao Cui <cui.tao@linux.dev>
In-Reply-To: <ebb6ebc5ddce3089fe912ca2d6e7a0658864c7369d15e1cdb7f203eae6d5a0d0@mail.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hello,

在 2026/11/6 20:56, bot+bpf-ci@kernel.org 写道:
>> blk-iocost: add iocost_ioc_tick tracepoint for per-period device summary
> 
> TL;DR: Commit message only: it restates the code comment instead of giving the
> motivation (monitoring without drgn) for the new iocost_ioc_tick tracepoint.

Right, the changelog ended up restating the code comment.  I'll
rewrite it to lead with the motivation: the tracepoint gives a
per-period summary so monitoring iocost doesn't require drgn.  The
emission semantics stay documented in the code.

Thanks,
Tao
> Not a bug.
> 
>> blk-iocost: add iocost_ioc_tick tracepoint for per-period device summary
>>
>> Add iocost_ioc_tick, emitted once per period from ioc_timer_fn() with
>> the overall controller state: period_us, vrate, busy_level, active iocg
>> count and usage percentage.  busy_level, cur_period, nr_active and
>> usage_us_sum are complete at the emission point.  usage is wall time
>> over wall time, summed over iocgs, and is not capped at 100.  vrate and
>> period_us reflect the current controller state, which an io.cost.qos
>> write may have changed mid-period.
>>
>> The event fires every period the controller is running, including
>> steady states, plus one final tick before the controller goes idle, so
>> the transition to dormancy is directly visible.  The active iocg count
>> is only gathered when the tracepoint is enabled.
>>
>> Suggested-by: Tejun Heo <tj@kernel.org>
>> Signed-off-by: Tao Cui <cuitao@kylinos.cn>
> 
> this isn't a bug, but the middle of the first paragraph ("busy_level,
> cur_period, nr_active and usage_us_sum are complete at the emission point
> ... which an io.cost.qos write may have changed mid-period") restates the
> block comment added above the tracepoint call in ioc_timer_fn() almost word
> for word.
> 
> The reason for adding the event only appears in the comment in
> include/trace/events/iocost.h ("so basic monitoring doesn't require drgn").
> 
> Could the changelog say why a per-period summary event is needed, for
> example the monitoring-without-drgn motivation, rather than repeating the
> code comment?
> 
> 
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md
> 
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/42219005018

