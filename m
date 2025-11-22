Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC7B127144B;
	Sat, 22 Nov 2025 12:24:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763814295; cv=none; b=XEk/wubXZL8YwBEBilt0iRsp1glvH5mR2YyfyNvO/ct2nFOA2tbabD1mpJT41lh+tCicIedKbVj0eBixyFnS1JUVYq08rHNgcZLAR/eebWEde3/tGLYgSIzFDkkp2JQMcen1svIhLc4EZicbNLaMee1ejcH1nxLrfEPZwgIuEu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763814295; c=relaxed/simple;
	bh=RDQVVA6kQF5LQw40jyDuW9rNtASfS5/UmHvMsmmPqeI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hHaGHNF0kQzPyUSuXkhYxAiQN5UmwIdJOh82aADDslv3YMO+cYu/wvT27xqLqxIrjZrXx/0SD+ub/uhMnFr0WapsHmgyF7U/Reieo5tUE19/Kp5m0KirVH/oDTu0840kJEl/Mn96jTWmL04NA06IWRVTb1WjRbD5OG54zsjhDGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=ss3Nk22c; arc=none smtp.client-ip=115.124.30.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="ss3Nk22c"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1763814282; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=QlWKRfdPev+JE8xmARtuY3t4ko4RyH2k7HvUC9+LEHw=;
	b=ss3Nk22cEV4HH7Af2fUMZQGlq7Ypg1P38UrnSy0DW+EWLahp6M2P4SAb8b3pRn9H+8oP4tZhgx+vh96xhccDRUY1rChEdBjDhIl/Noay+e6aabWsrl8ZhSmsfMa4zMIuoKpbEojBF/yYJBe/puuCxrruxPxpaM2liHLNc6vfu4U=
Received: from 30.170.82.147(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0Wt4IUZV_1763814281 cluster:ay36)
          by smtp.aliyun-inc.com;
          Sat, 22 Nov 2025 20:24:42 +0800
Message-ID: <853796e3-fd44-4fc2-8fd2-5810342a6ebe@linux.alibaba.com>
Date: Sat, 22 Nov 2025 20:24:40 +0800
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCHv5 0/6] zram: introduce writeback bio batching
To: Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: Yuwen Chen <ywen.chen@foxmail.com>, akpm@linux-foundation.org,
 bgeffon@google.com, licayy@outlook.com, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, minchan@kernel.org,
 richardycc@google.com
References: <ts32xzxrpxmwf3okxo4bu2ynbgnfe6mehf5h6eibp7dp3r6jp7@4f7oz6tzqwxn>
 <tencent_865DD78A73BC3C9CAFCBAEBE222B6EA5F107@qq.com>
 <buckmtxvdfnpgo56owip3fjqbzraws2wvtomzfkywhczckoqlt@fifgyl5fjpbt>
 <8c596737-95c1-4274-9834-1fe06558b431@linux.alibaba.com>
 <kvgy5ms2xlkcjuzuq7xx5lmjwx3frguosve7sqbp6wh3gpih5k@kjuwfbdd2cqz>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <kvgy5ms2xlkcjuzuq7xx5lmjwx3frguosve7sqbp6wh3gpih5k@kjuwfbdd2cqz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2025/11/22 18:07, Sergey Senozhatsky wrote:
> On (25/11/21 20:21), Gao Xiang wrote:
>>>>> I think page-fault latency of a written-back page is expected to be
>>>>> higher, that's a trade-off that we agree on.  Off the top of my head,
>>>>> I don't think we can do anything about it.
>>>>>
>>>>> Is loop device always used as for writeback targets?
>>>>
>>>> On the Android platform, currently only the loop device is supported as
>>>> the backend for writeback, possibly for security reasons. I noticed that
>>>> EROFS has implemented a CONFIG_EROFS_FS_BACKED_BY_FILE to reduce this
>>>> latency. I think ZRAM might also be able to do this.
>>>
>>> I see.  Do you use S/W or H/W compression?
>>
>> No, I'm pretty sure it's impossible for zram to access
>> file I/Os without another thread context (e.g. workqueue),
>> especially for write I/Os, which is unlike erofs:
>>
>> EROFS can do because EROFS is a specific filesystem, you
>> could see it's a seperate fs, and it can only read (no
>> write context) backing files in erofs and/or other fses,
>> which is much like vfs/overlayfs read_iter() directly
>> going into the backing fses without nested contexts.
>> (Even if loop is used, it will create its own thread
>> contexts with workqueues, which is safe.)
>>
>>   In the other hand, zram/loop can act as a virtual block
>> device which is rather different, which means you could
>> format an ext4 filesystem and backing another ext4/btrfs,
>> like this:
>>
>>    zram(ext4) -> backing ext4/btrfs
>>
>> It's unsafe (in addition to GFP_NOIO allocation
>> restriction) since zram cannot manage those ext4/btrfs
>> existing contexts:
>>
>>   - Take one detailed example, if the upper zram ext4
>> assigns current->journal_info = xxx, and submit_bio() to
>> zram, which will confuse the backing ext4 since it should
>> assume current->journal_info == NULL, so the virtual block
>> devices need another thread context to isolate those two
>> different uncontrolled contexts.
>>
>> So I don't think it's feasible for block drivers to act
>> like this, especially mixing with writing to backing fses
>> operations.
> 
> Sorry, I don't completely understand your point, but backing
> device is never expected to have any fs on it.  So from your
> email:

zram(ext4) means zram device itself is formated as ext4.

> 
>> zram(ext4) -> backing ext4/btrfs
> 
> This is not a valid configuration, as far as I'm concerned.
> Unless I'm missing your point.

Why it's not valid? zram can be used as a regular virtual
block device, and format with any fs, and mount the zram
then.

Thanks,
Gao Xiang

