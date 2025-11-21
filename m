Received: from out30-112.freemail.mail.aliyun.com (out30-112.freemail.mail.aliyun.com [115.124.30.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0339530FC3D;
	Fri, 21 Nov 2025 12:43:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.112
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763729035; cv=none; b=Xr1+ku6iXnlc3wZ6ve1ouG8E4i7NZINhJa3FZmyEus5gYA1HRNTuZLXZNVRam50fReWkiI1FOO0io8Noj0KeaKKIXRMeKCrigHxvquwfZLpOJMwxmDd3ZJSD+5vB9CJumI9HqtZoYdcI7KiqCA4e72eOjzRyOB1Ifj5jCZn2U8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763729035; c=relaxed/simple;
	bh=SseNgIZp6gPDgR2IeWAnrRjcKo5B1YeAinQknMrLT9w=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=Io3g+/in4IGzoRsO4AFNbs0ecFVN/TFEBDuTans37zHGZhPIHEvlLsBpRsEXdXleMG5mBrdh5+8qN3+xTLktRvFltBWfdOtRE3UcfSMVdR9rVa1GI4gmwMq+BDOm91P9nrfz+My5G52WfceIidMRQvpM/Lka1Pmo8lab1mvDdJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=HvE3C/FR; arc=none smtp.client-ip=115.124.30.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="HvE3C/FR"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1763729027; h=Message-ID:Date:MIME-Version:Subject:From:To:Content-Type;
	bh=UXNEr7vcm3thFtEulF8bEeGgEGO9nmCn0v+aGXpJLHk=;
	b=HvE3C/FRH/Xk4hMHhYrsjTgfGuCHjuldYsbPVZiT9+R1HALhq9/Wci5N2DVw+ygHkzlU/TpxNLH+Rci3CW6k8VxkFqTFkD87gQKOt7VJlaqanJKma0QQzz1ol1r2f7ehf0/qPJTDNbL/uTJMTyv3yTIJW9wSsKsMKpCFNzqMI/A=
Received: from 30.170.82.147(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0Wt003i5_1763729026 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 21 Nov 2025 20:43:46 +0800
Message-ID: <d7140963-3b21-4b51-9a9c-bcf8362bf1da@linux.alibaba.com>
Date: Fri, 21 Nov 2025 20:43:45 +0800
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCHv5 0/6] zram: introduce writeback bio batching
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: Sergey Senozhatsky <senozhatsky@chromium.org>,
 Yuwen Chen <ywen.chen@foxmail.com>
Cc: akpm@linux-foundation.org, bgeffon@google.com, licayy@outlook.com,
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, minchan@kernel.org, richardycc@google.com
References: <ts32xzxrpxmwf3okxo4bu2ynbgnfe6mehf5h6eibp7dp3r6jp7@4f7oz6tzqwxn>
 <tencent_865DD78A73BC3C9CAFCBAEBE222B6EA5F107@qq.com>
 <buckmtxvdfnpgo56owip3fjqbzraws2wvtomzfkywhczckoqlt@fifgyl5fjpbt>
 <8c596737-95c1-4274-9834-1fe06558b431@linux.alibaba.com>
In-Reply-To: <8c596737-95c1-4274-9834-1fe06558b431@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 2025/11/21 20:21, Gao Xiang wrote:
> 
> 
> On 2025/11/21 17:12, Sergey Senozhatsky wrote:
>> On (25/11/21 16:23), Yuwen Chen wrote:
> 
> ..
> 
> 
>>>> I think page-fault latency of a written-back page is expected to be
>>>> higher, that's a trade-off that we agree on.  Off the top of my head,
>>>> I don't think we can do anything about it.
>>>>
>>>> Is loop device always used as for writeback targets?
>>>
>>> On the Android platform, currently only the loop device is supported as
>>> the backend for writeback, possibly for security reasons. I noticed that
>>> EROFS has implemented a CONFIG_EROFS_FS_BACKED_BY_FILE to reduce this
>>> latency. I think ZRAM might also be able to do this.
>>
>> I see.  Do you use S/W or H/W compression?
> 
> No, I'm pretty sure it's impossible for zram to access
> file I/Os without another thread context (e.g. workqueue),
> especially for write I/Os, which is unlike erofs:
> 
> EROFS can do because EROFS is a specific filesystem, you
> could see it's a seperate fs, and it can only read (no
> write context) backing files in erofs and/or other fses,
> which is much like vfs/overlayfs read_iter() directly
> going into the backing fses without nested contexts.
> (Even if loop is used, it will create its own thread
> contexts with workqueues, which is safe.)
> 
>   In the other hand, zram/loop can act as a virtual block
> device which is rather different, which means you could
> format an ext4 filesystem and backing another ext4/btrfs,
> like this:
> 
>    zram(ext4) -> backing ext4/btrfs
> 
> It's unsafe (in addition to GFP_NOIO allocation
> restriction) since zram cannot manage those ext4/btrfs
> existing contexts:
> 
>   - Take one detailed example, if the upper zram ext4
> assigns current->journal_info = xxx, and submit_bio() to
> zram, which will confuse the backing ext4 since it should
> assume current->journal_info == NULL, so the virtual block
> devices need another thread context to isolate those two
> different uncontrolled contexts.
> 
> So I don't think it's feasible for block drivers to act
> like this, especially mixing with writing to backing fses
> operations.

In other words, a fs claims it can do file-backed-mounts
without a new context only if:

  - Its own implementation can be safely applied to any
    other kernel filesystem (e.g., it shouldn't change
    current->journal_info or do context save/restore before
    handing over, for example); and its own implementation
    can safely mount itself with file-backed mounts.

So it's filesystem-specific internals to make sure it can
work like this (for example ext4 on erofs, ext4 still uses
loop to mount). The virtual block device layer knows
nothing about what the upper filesystem did before the
execution passes through, so it's unsafe to work like this.

Thanks,
Gao Xiang
