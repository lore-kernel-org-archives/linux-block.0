Received: from mail3-167.sinamail.sina.com.cn (mail3-167.sinamail.sina.com.cn [202.108.3.167])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB6744B9E7A
	for <linux-block@vger.kernel.org>; Thu,  8 Jan 2026 10:36:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.108.3.167
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767868589; cv=none; b=uepIUZntRcyg2gepRKYSsQxwmMB1wGMhuGQClEcXFsEEZHZChs6tDuCwUWGtjyThBWRXTCy2xO6+eMCMtF1V8nvrWS/fxv42JRDof9Q6hFhUq91rRsHjJPWGRA23Ra4CRCOsEJdEv1EW8xPPcqCa6/o0S1ZT41PgnSGtuqjdjCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767868589; c=relaxed/simple;
	bh=op7055KsVRf0QKrHS7uftM549Xva9fIs9XkoBybVfd0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BfLcw9YjcKoLJojcrtdnOaw8ZpVsNlWACS8iy7Vn776+9ac+bTLqyAHCP/HlKxqNy0uSTlaHz1srrXicgscnwV93ZreXagHsyDDXsRcCsln29P4lyODYk+0Fv0xexm01M+g0lVQtdQDDNLucazibJLXmYRGQolslg1eH/vGMF+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b=Ka1Q6PuG; arc=none smtp.client-ip=202.108.3.167
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b="Ka1Q6PuG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sina.com; s=201208; t=1767868579;
	bh=dvlc7vqh4bhdCSEuA5TpLBp3Xu6DhQ+wjbFss0nogZw=;
	h=Message-ID:Date:Subject:From;
	b=Ka1Q6PuGS52o8s8OrIcYL0AnvGp3A23BV+r/oB3PYdIasb6SEbdoaWdKkkU2QltYA
	 2a+wQCd0hYNvsUWm/FbG+OHo1ILIT1yVG66z9h5V3+71TYEXGglNjjFwve4hyRZrOJ
	 QIHd4R1uTF4aL4m0sFTCOnNpYrQrH46jNzSTrNsg=
X-SMAIL-HELO: [10.189.149.126]
Received: from unknown (HELO [10.189.149.126])([114.247.175.249])
	by sina.com (10.54.253.33) with ESMTP
	id 695F8895000018B3; Thu, 8 Jan 2026 18:36:07 +0800 (CST)
X-Sender: zhangdongdong925@sina.com
X-Auth-ID: zhangdongdong925@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=zhangdongdong925@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=zhangdongdong925@sina.com
X-SMAIL-MID: 117396685200
X-SMAIL-UIID: 0A83DA6CFAD5406983CF226D49853D50-20260108-183607-1
Message-ID: <731f6e5b-f678-49ef-ad8e-fe6ff85d5422@sina.com>
Date: Thu, 8 Jan 2026 18:36:04 +0800
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv2 1/7] zram: introduce compressed data writeback
To: Sergey Senozhatsky <senozhatsky@chromium.org>,
 Jens Axboe <axboe@kernel.dk>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 Richard Chang <richardycc@google.com>, Minchan Kim <minchan@kernel.org>,
 Brian Geffon <bgeffon@google.com>, David Stevens <stevensd@google.com>,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 linux-block@vger.kernel.org, Minchan Kim <minchan@google.com>,
 xiongping1@xiaomi.com, huangjianan@xiaomi.com, wanghui33@xiaomi.com
References: <20251201094754.4149975-1-senozhatsky@chromium.org>
 <20251201094754.4149975-2-senozhatsky@chromium.org>
 <40e38fa7-725b-407a-917a-59c5a76dedcb@sina.com>
 <7bnmkuodymm33yclp6e5oir2sqnqmpwlsb5qlxqyawszb5bvlu@l63wu3ckqihc>
 <2663a3d3-2d52-4269-970a-892d71c966bb@sina.com>
 <z22c2qgw2al73yij2ml2hlle2p24twgpmz4jemfqhjoiekc65f@pvap7olsolfp>
 <a527b179-263f-40ad-9d7c-bfa86731bfde@sina.com>
 <luzn25fgin43cnbmvmxwps7isqeq2pt5kfn26jqzly6hbnedlp@ojpw52ldzmuw>
Content-Language: en-US
From: zhangdongdong <zhangdongdong925@sina.com>
In-Reply-To: <luzn25fgin43cnbmvmxwps7isqeq2pt5kfn26jqzly6hbnedlp@ojpw52ldzmuw>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 1/8/26 11:39, Sergey Senozhatsky wrote:
> Hi,
> 
> On (26/01/08 10:57), zhangdongdong wrote:
>>> Do you use any strategies for writeback?  Compressed writeback
>>> is supposed to be used for apps for which latency is not critical
>>> or sensitive, because of on-demand decompression costs.
>>>
>>
>> Hi Sergey,
>>
>> Sorry for the delayed reply — I had some urgent matters come up and only
>> got back to this now ;)
> 
> No worries, you reply in a perfectly reasonable time frame.
> 
>> Yes, we do use writeback strategies on our side. The current implementation
>> focuses on batched writeback of compressed data from
>> zram, managed on a per-app / per-memcg basis. We track and control how
>> much data from each app is written back to the backing storage, with the
>> same assumption you mentioned: compressed writeback is primarily
>> intended for workloads where latency is not critical.
>>
>> Accurate prefetching on swap-in is still an open problem for us. As you
>> pointed out, both the I/O itself and on-demand decompression introduce
>> additional latency on the readback path, and minimizing their impact
>> remains challenging.
>>
>> Regarding the workqueue choice: initially we used system_dfl_wq for the
>> read/decompression path. Later, based on observed scheduling latency
>> under memory pressure, we switched to a dedicated workqueue created with
>> WQ_HIGHPRI | WQ_UNBOUND. This change helped reduce scheduling
>> interference, but it also reinforced our concern that deferring
>> decompression to a worker still adds an extra scheduling hop on the
>> swap-in path.
> 
> How bad (and often) is your memory pressure situation?  I just wonder
> if your case is an outlier, so to speak.
> 
> 
> Just thinking aloud:
> 
> I really don't see a path back to atomic zram read/write.  Those
> were very painful and problematic, I do not consider a possibility
> of re-introducing them, especially if the reason is an optional
> feature (which comp-wb is).  If we want to improve latency, we need
> to find a way to do it without going back to atomic read/write,
> assuming that latency becomes unbearable.  But at the same time under
> memory pressure everything becomes janky at some point, so I don't
> know if comp-wb latency is the biggest problem in that case.
> 
> Dunno, *maybe* we can explore a possibility of grabbing both entry-lock
> and per-CPU compression stream before we queue async bio, so that in
> the bio completion we already *sort of* have everything we need.
> However, that comes with a bunch of issues:
> 
> - the number of per-CPU compression streams is limited, naturally,
>    to the number of CPUs.  So if we have a bunch of comp-wb reads we
>    can block all other activities: normal zram reads/writes, which
>    compete for the same per-CPU compressions streams.
> 
> - this still puts atomicity requirements on the compressors.  I haven't
>    looked into, for instance, zstd *de*-compression code, but I know for
>    sure that zstd compression code allocates memory internally when
>    configured to use pre-trained CD-dictionaries, effectively making zstd
>    use GFP_ATOMIC allocations internally, if called from atomic context.
>    Do we have anything like that in decompression - I don't know.  But in
>    general we cannot be sure that all compressors work in atomic context
>    in the same way as they do in non-atomic context.
> 
> I don't know if solving it on zram side alone is possible.  Maybe we
> can get some help from the block layer: some sort of two-stage bio
> submission.  First stage: submit chained bio-s, second stage: iterate
> over all submitted and completed bio-s and decompress the data.  Again,
> just thinking out loud.
> 

Hi Sergey,

My thinking is largely aligned with yours. I agree that relying on zram
alone is unlikely to fully solve this problem, especially without going
back to atomic read/write.

Our current mitigation approach is to introduce a hook at the swap layer
and move decompression there. By doing so, decompression happens in a
fully sleepable context, which avoids the atomic-context constraints
you outlined. This helps us sidestep the core issue rather than trying
to force decompression back into zram completion paths.

For reference, this is the change we are experimenting with:
https://android-review.googlesource.com/c/kernel/common/+/3724447

I also noticed that Richard proposed a similar optimization hook recently:
https://android-review.googlesource.com/c/kernel/common/+/3730147

Regarding your question about memory pressure: our current test case
runs on an 8 GB device, with around 50 apps being launched sequentially.
This creates fairly heavy memory pressure. In earlier tests using an
async kworker-based approach, we observed an average latency of about
1.3 ms,but with tail latencies occasionally reaching 30–100 ms.

If I recall correctly, this issue first became noticeable after a block
layer change was merged; I can try to dig that up and share more details
later.

Best regards,
dongdong

