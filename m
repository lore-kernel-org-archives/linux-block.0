Received: from sg-1-13.ptr.blmpb.com (sg-1-13.ptr.blmpb.com [118.26.132.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38077239E9D
	for <linux-block@vger.kernel.org>; Wed, 11 Feb 2026 02:07:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=118.26.132.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770775645; cv=none; b=TK2UW5YvUqRrPUoNmo4HWDnm1zwdztjF3F0oyL3BCZm+/N8g0nmMMLF+daLpEfm+LcJ3MV+P/i3gyypz5hKNJc25QAsQW0dPjZUq8Ss5hbkYq08VZphVBI7ZowRXvyqjpOQBRmzw+Cb8WBaYF37QRsld4fFrRcIbSX6Fh9GiaqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770775645; c=relaxed/simple;
	bh=lE7yrnHhWwTZjWQdgFG+/zmvdS0+p8WYidWv2IPPipI=;
	h=Subject:In-Reply-To:Mime-Version:Content-Type:To:Cc:From:Date:
	 Message-Id:References; b=f5bECRTK5JexmUfCvpyyizvbLK7rnWb5/c3hUueB+2oIzvs9gu0fCzhYCtplKyFjwgsqszi3zQVIeLBfoqiiK1PmajKUcD2FG/k5wo3N6/y0wD7FgCqzoStD/VfcDIQEklFgEsgUVQnSFzPnpg2oEhbXjiLgJNE3OO+FohjUCe0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fnnas.com; spf=none smtp.mailfrom=fnnas.com; dkim=pass (2048-bit key) header.d=fnnas-com.20200927.dkim.feishu.cn header.i=@fnnas-com.20200927.dkim.feishu.cn header.b=qSwpewMy; arc=none smtp.client-ip=118.26.132.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fnnas.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=fnnas.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fnnas-com.20200927.dkim.feishu.cn header.i=@fnnas-com.20200927.dkim.feishu.cn header.b="qSwpewMy"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=s1; d=fnnas-com.20200927.dkim.feishu.cn; t=1770775631;
  h=from:subject:mime-version:from:date:message-id:subject:to:cc:
 reply-to:content-type:mime-version:in-reply-to:message-id;
 bh=lE7yrnHhWwTZjWQdgFG+/zmvdS0+p8WYidWv2IPPipI=;
 b=qSwpewMy2I8/VESCfrLhD4XLy/0tjNH4vUrOnW63I4pl/q3RAE1Dlc7DfIUIYwDtDUBJMA
 OAQZoqUdQpHzD3hwLoptAAELksMBljsUI7Q6vBg/rz1cw+pVgiEi8wwFMTEUAQ602lSit5
 AuE3gKv7uhsP2C/iOfYCNsst8LYncfjzl24l7nzOdX4WB5FODMIk5/rOfKPlsrREx6QxRE
 r8VyfRmWY/+lNRWYadwo+Zoq84w3P/UC2jkhOKp3oIvUBOGrLB+FlvbnbnavunAskx7zfz
 EychBsc5GSJMvuCxyX/vuXEayZLPCgpz4Y+5VjVJJXrQnyLrY+3ZxEHt1ZilhA==
Reply-To: yukuai@fnnas.com
Subject: Re: [PATCH v7 09/16] blk-throttle: fix possible deadlock for fs reclaim under rq_qos_mutex
X-Original-From: Yu Kuai <yukuai@fnnas.com>
In-Reply-To: <924c838e-130b-42a4-8dcd-8c5f5675de53@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Lms-Return-Path: <lba+2698be44e+e3f6b4+vger.kernel.org+yukuai@fnnas.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
Received: from [192.168.1.104] ([39.182.0.137]) by smtp.feishu.cn with ESMTPS; Wed, 11 Feb 2026 10:07:08 +0800
To: "Nilay Shroff" <nilay@linux.ibm.com>, "Ming Lei" <ming.lei@redhat.com>, 
	<yukuai@fnnas.com>
Cc: <axboe@kernel.dk>, <linux-block@vger.kernel.org>, <tj@kernel.org>
From: "Yu Kuai" <yukuai@fnnas.com>
Date: Wed, 11 Feb 2026 10:07:07 +0800
Message-Id: <6b4901df-ccb5-401f-b5d5-796e4916a076@fnnas.com>
References: <20251231085126.205310-1-yukuai@fnnas.com> <20251231085126.205310-10-yukuai@fnnas.com> <aV5L25KZkM4dvzLD@fedora> <e2054693-7100-4bdc-95eb-9e70d9d3231e@fnnas.com> <924c838e-130b-42a4-8dcd-8c5f5675de53@linux.ibm.com>
User-Agent: Mozilla Thunderbird

Hi, Nilay and Ming

=E5=9C=A8 2026/1/9 17:09, Nilay Shroff =E5=86=99=E9=81=93:
>
> On 1/8/26 10:26 PM, Yu Kuai wrote:
>> Hi,
>>
>> =E5=9C=A8 2026/1/7 20:04, Ming Lei =E5=86=99=E9=81=93:
>>> On Wed, Dec 31, 2025 at 04:51:19PM +0800, Yu Kuai wrote:
>>>> blk_throtl_init() can be called with rq_qos_mutex held from blkcg
>>>> configuration, and fs reclaim can be triggered because GFP_KERNEL is u=
sed
>>>> to allocate memory. This can deadlock because rq_qos_mutex can be held
>>>> with queue frozen.
>>>>
>>>> Fix the problem by using blkg_conf_open_bdev_frozen(), also remove
>>>> useless queue frozen from blk_throtl_init().
>>>>
>>>> Signed-off-by: Yu Kuai <yukuai@fnnas.com>
>>>> ---
>>> I think this patch goes toward wrong direction by enlarging queue freez=
e
>>> scope, and blkg_conf_prep() may run into percpu allocation, then new
>>> lockdep warning could be triggered.
>>>
>>> IMO, we should try to reduce blkg_conf_open_bdev_frozen() uses, instead=
 of
>>> adding more.
>> Fortunately, blk_throtl_init() doesn't have percpu allocation, so this i=
s
>> safe now. Unfortunately, blk-iocost and blk-iolatency do have percpu all=
ocation
>> and they're already problematic for a long time. The queue is already fr=
ozen from
>> blkcg_activate_policy() and then the pd_alloc_fn() will try percpu alloc=
ation.
>>
>> To be honest, I feel it's too complicated to move all the percpu allocat=
ion out of
>> queue frozen, will it be possible to fix this the other way by passing a=
nother gfp
>> into pcpu_alloc_noprof() that it'll be atomic to work around the pcpu_al=
loc_mutex.
>>
> I agree that in some cases, when percpu allocation occurs deep within com=
plex call
> chains, it can be quite challenging to move the allocation ahead of ->fre=
eze_lock
> without significantly restructuring the code.
>
> Looking back at the history of percpu allocation behavior, commit 28307d9=
38fb2
> (=E2=80=9Cpercpu: make pcpu_alloc() aware of current gfp context=E2=80=9D=
) changed pcpu_alloc()
> semantics such that allocations were treated as atomic if the current GFP=
 context
> did not include GFP_KERNEL. As a result, GFP_NOIO and GFP_NOFS allocation=
s were
> also treated as atomic. This change was merged in kernel v5.10.
>
> Later, commit 9a5b183941b5 (=E2=80=9Cmm, percpu: do not consider sleepabl=
e allocations
> atomic=E2=80=9D) refined this behavior further. With this change, percpu =
allocations are
> considered atomic only if the the caller explicitly marked the calling co=
ntext
> atomic (probably using GFP_ATOMIC or GFP_NOWAIT).
>
> While commit 9a5b183941b5 ("mm, percpu: do not consider sleepable allocat=
ions
> atomic=E2=80=9D) does the right thing conceptually, it has resulted in a =
number of lockdep
> warnings reporting potential deadlocks when code paths attempt to allocat=
e percpu
> memory while a request queue is frozen.
>
> Given this history, and the recent lockdep splats involving percpu alloca=
tion and
> queue freezing, I would suggest using GFP_ATOMIC for pcpu allocations tha=
t are
> invoked while the queue is already frozen, where feasible. By =E2=80=9Cfe=
asible,=E2=80=9D I mean
> cases where the allocation size is small enough that using GFP_ATOMIC is =
reasonable=E2=80=94
> typically only a few tens or hundreds of bytes per CPU. In such cases, th=
e risk and
> cost associated with atomic allocations are minimal and acceptable.
>
> For example, struct latency_stat, which requires approximately 40 bytes p=
er CPU, and
> struct iocg_pcpu_stat, which requires only 8 bytes per CPU, are good cand=
idates for
> this approach.
>
> Using GFP_ATOMIC in these limited, well-defined cases could help avoid lo=
ckdep warnings
> and potential deadlocks, without requiring invasive refactoring to move p=
ercpu allocations
> outside the queue-freeze window.

Just a notice, I follow the idea to reduce queue frozen scope, see patch 6,=
7 in
the following thread:

[PATCH v2 0/7] blk-cgroup: fix races and deadlocks - Yu Kuai <https://lore.=
kernel.org/all/20260203080602.726505-1-yukuai@fnnas.com/>

>
> Thanks,
> --Nilay
>
--=20
Thansk,
Kuai
