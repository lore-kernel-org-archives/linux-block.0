Received: from out30-113.freemail.mail.aliyun.com (out30-113.freemail.mail.aliyun.com [115.124.30.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0405C1C5D59;
	Sat, 22 Nov 2025 14:09:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.113
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763820563; cv=none; b=pnOPHwotEsYpbaJ3WT9tqMGRZPHJv2MN/hpBWCDj0ZGYy3/YSTKKmLH5vMEehiwanlNyfajSmMDlFBHLXZC5HB0yvFnz7YZcTC2YPRkHrxSctT5rFOLojydYaImCuTDqzZBKUlqaWz5P393H2WU8UQaD23ZS2i19sG10q2/8CqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763820563; c=relaxed/simple;
	bh=HqN60t5Kr9L1orycE6I/k9Pk7qJw1ucp1Rc5gEL0cWQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TpdXXjjXCjdVZd2ghoGf4BxiU99PsQwHZGt/xr9aeug1Ve3YANFnxZogMAWd/10X6OGPf57CT2AKS1ZbUk4By7Au9cG/9L+dYHrIuQ198NhgXVHNgvCFsso55KjUVRndiBz/WbWDKnfLhEhW2hwAy9OMd7DIhklMsgjwoc0yHAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=e4eJ2S/a; arc=none smtp.client-ip=115.124.30.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="e4eJ2S/a"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1763820557; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=3ZDjsY2sg6rvsyUvNLcAYz1go/aL8BSTJ+KSEmWdUmM=;
	b=e4eJ2S/aNNfPW+aDnhFZIZY/nsFKTgLYpbsQqeTQThk+plL2pqPqTNDZMKL66KXgIikZfJD6N+ejHEObQy5IihJoPqBUAFKAevOy5ibaQRIkPs44wudonee0VorqrOSShVZogC4Qa09hlo6Cr4F21yjAiKXC1JkmUfOgdz0uGF4=
Received: from 30.170.82.147(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0Wt4WfL4_1763820555 cluster:ay36)
          by smtp.aliyun-inc.com;
          Sat, 22 Nov 2025 22:09:16 +0800
Message-ID: <2c6906d1-132e-401f-830f-ae771fe836c5@linux.alibaba.com>
Date: Sat, 22 Nov 2025 22:09:15 +0800
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
 <853796e3-fd44-4fc2-8fd2-5810342a6ebe@linux.alibaba.com>
 <ztqfbzq7fwa5znw5ur45qlbnupgepaptzjaw2izsftbtth6zca@db4ruyaulqab>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <ztqfbzq7fwa5znw5ur45qlbnupgepaptzjaw2izsftbtth6zca@db4ruyaulqab>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2025/11/22 21:43, Sergey Senozhatsky wrote:
> On (25/11/22 20:24), Gao Xiang wrote:
>> zram(ext4) means zram device itself is formated as ext4.
>>
>>>
>>>> zram(ext4) -> backing ext4/btrfs
>>>
>>> This is not a valid configuration, as far as I'm concerned.
>>> Unless I'm missing your point.
>>
>> Why it's not valid? zram can be used as a regular virtual
>> block device, and format with any fs, and mount the zram
>> then.
> 
> I thought you were talking about the backing device being
> ext4/btrfs.  Sorry, I don't have enough context/knowledge
> to understand what you're getting at.  zram has been doing
> writeback for ages, I really don't know what you mean by
> "to act like this".

I mean, if zram is formatted as ext4, and then mount it;
and then there is a backing file which is also in another
ext4, you'd need a workqueue to do writeback I/Os (or needs
a loop device to transit), was that the original question
raised by Yuwen?

If it's backed by a physical device rather than a file in
a filesystem, such potential problem doesn't exist.

Thanks,
Gao Xiang
