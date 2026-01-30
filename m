Received: from sg-1-101.ptr.blmpb.com (sg-1-101.ptr.blmpb.com [118.26.132.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C03833469C
	for <linux-block@vger.kernel.org>; Fri, 30 Jan 2026 02:59:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=118.26.132.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769741980; cv=none; b=TY7W8B+dg8Co3sYC8AGYh3kZaMk+Ern/JOjlpZCD9F8WBhBy37YsVGhEsi/0iqw8uagobiCXXNWfxelBd5QlHXG0CHZsBU21IzQsLiFdGyD/+S72MS+tTZi0ac/vGjFNfa7IhRwL/URI9UmhzIPCj3w0C+gWBIDGTpKZLx9ixZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769741980; c=relaxed/simple;
	bh=eMWwDyIByNpiHRYUN43fVfJqfLictFvS0WLam0IM7IQ=;
	h=In-Reply-To:From:Subject:Message-Id:Content-Type:References:Cc:
	 Date:Mime-Version:To; b=s9uJBBwf+RFBc+Fzrn5O5X5J+Rhr11qWJ/HKz0Q6L7BKXV3E41XGmtF1CyiOFiPGkDIKT5p9rOGYlciFCu3ylV/czzsO3DPldvUOzhsJYs6koM0ElvvzKVCcv2v8sEi48VyKbjvCnYu2uAFuwyx3mVHzHTNejzOfcHqrmbWQTIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=Q2xq+1xU; arc=none smtp.client-ip=118.26.132.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="Q2xq+1xU"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=2212171451; d=bytedance.com; t=1769741964; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=Ncz7fLi2vx1N9dOIDvX6q5Y5aKeZK2x1VYstftIHVXg=;
 b=Q2xq+1xUs1pCJwiY4rZq+Yh+/Qbinm+HCk2gaSQ84Fop4M91Qnc/1zgPcx+78/KC7Tq5PY
 cHZsAqERw69Po1j7irnU0yW4ytsNIu3PKD77v3xWIwojflZOm6lrfz8n6XSBXnovgJf6Nd
 5rABsunwVl8XuQbwJOHol5mh10uOY/GJudtf3uINiateqmkTUE6oYya7II7Yo9ywDk4Zt9
 9JcA1FirAhEPrgaL+C0BY3peXK1q0GfebRzvwkbqid+NHt9f1M3y7Qa+DH0bbgKzwE9i1R
 wzCnVcGAL6dw6AXks1wAUbTVYtEDOej8IPNgN7L82cz39776dPFy7aUGETPZgg==
Content-Language: en-US
In-Reply-To: <20260109083126.15052-1-lidiangang@bytedance.com>
X-Original-From: Diangang Li <lidiangang@bytedance.com>
From: "Diangang Li" <lidiangang@bytedance.com>
Subject: Re: [RFC 0/1] block: export windowed IO P99 latency
Message-Id: <003ed785-455d-4245-bb7d-47e58eae7814@bytedance.com>
Content-Type: text/plain; charset=UTF-8
User-Agent: Mozilla Thunderbird
References: <20260109083126.15052-1-lidiangang@bytedance.com>
Cc: <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>, 
	<changfengnan@bytedance.com>
Date: Fri, 30 Jan 2026 10:59:06 +0800
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
To: "Diangang Li" <diangangli@gmail.com>, <axboe@kernel.dk>
X-Lms-Return-Path: <lba+2697c1e8a+321b29+vger.kernel.org+lidiangang@bytedance.com>
Content-Transfer-Encoding: 7bit

On 2026/1/9 16:31, Diangang Li wrote:
> Production environments occasionally run into elevated tail latencies. The
> source can be the underlying device, but it can also be higher in the
> stack (filesystem contention/journaling, memory reclaim, writeback, etc.).
> Existing block IO statistics only provide throughput and average latency,
> which fail to capture the critical tail end of the latency distribution
> that often causes user-visible performance problems.
> 
> This patch adds windowed P99 latency tracking for block IO operations,
> exposing the 99th percentile latency in /proc/diskstats and
> /sys/block/<dev>/stat. System administrators can now monitor tail latency
> trends over time using tools like iostat, enabling quick validation or
> elimination of disk hardware as the source of latency issues.
> 
> Implementation uses per-CPU sliced ring histograms (21 buckets, 8us..~8s
> range) with minimal overhead. P99 values are computed by aggregating
> recent 1-second slices when reading statistics, reported in microseconds
> using bucket midpoints.
> 
> The added work on the IO path is intentionally small (bucket selection and
> a per-CPU counter update, with occasional per-slice reset), and in our
> testing it does not have a measurable impact on IO performance.
> 
> Diangang Li (1):
>    block: export windowed IO P99 latency
> 
>   block/blk-core.c          |  5 ++-
>   block/blk-flush.c         |  6 ++-
>   block/blk-mq.c            |  5 ++-
>   block/genhd.c             | 50 ++++++++++++++++++++++++-
>   include/linux/part_stat.h | 79 +++++++++++++++++++++++++++++++++++++++
>   5 files changed, 139 insertions(+), 6 deletions(-)
> 

Hi Jens, hi all,

Quick sanity check on the motivation/design before I respin.

I want to expose a simple tail metric (P99) via diskstats/sysfs stat, 
since avg latency/throughput often miss the spikes seen in prod.

I considered read-to-read deltas, but diskstats is polled frequently 
(often sub-second, multiple agents), so the effective window becomes 
reader-dependent and too short/noisy. Current approach uses a fixed 
window (per-CPU 1s slices in a small ring histogram) and aggregates on read.

Does this direction make sense? Is diskstats/sysfs the right place for 
it? Any better low-overhead, polling-independent approach (and 
preferences on percentile/window/buckets)?

Best regards,
Diangang Li
