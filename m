Received: from out30-98.freemail.mail.aliyun.com (out30-98.freemail.mail.aliyun.com [115.124.30.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 106AAA927;
	Sun, 23 Nov 2025 01:39:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763861976; cv=none; b=GwSFw4+QjX2nGtFA7FVBl/vOlQ6MeI33xM6pLcAVP9KxcY0WAAL6vtu9ys+wExxEtRufz3MaMlq/OuiBBrVbzRGSD3d//cnEhVvuk2S02Met4hRXXj1nHn4A7pcQFVcy835UUR5/SgjAgPUSCsXuxvhLGAV7KqyYjOorH6cOP0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763861976; c=relaxed/simple;
	bh=9/N7pBRpE3vQz2DsaPGyGq4ZXC1fDMZRo83NmQFplLs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hiA3nak5YajfbDKxpIASuYWxEUsVPpXjUi84ZTFkaz6nQuFxMfSzTTxkpfqwOiKD84x6ZPRVOVbaUUx+Qbyg37DPzgfZxGDVb4WboOQR+QEyG03e/LgKYqA4V1YCTHDrK/+FQPVMeLaHv7sP4KIFifUd7XV5DvAjtO1xdYrvTLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=WeyHqbHM; arc=none smtp.client-ip=115.124.30.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="WeyHqbHM"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1763861963; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=R0FaNTVmYaM0SpQ82sulzhFW6ARj1Mibc6jdHQb9PbE=;
	b=WeyHqbHM8R00ktJ7mO3FtPCwN4Ve83bVstJQKbpJM+F/Q1XJ/i4zsAZvNVF2ahk0phhqAWCrK1aed6fHe0tMAh193hQh/PWumBM5X1gNTZFgpHIiJw5ZwGQDfS9D0DAFKF0U/YWTIv3dWYi5k2QaYE6uO7JNVsKD6JdXOg79DTc=
Received: from 30.170.82.147(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0Wt66ic3_1763861962 cluster:ay36)
          by smtp.aliyun-inc.com;
          Sun, 23 Nov 2025 09:39:23 +0800
Message-ID: <45155eea-2fde-4a72-8ea1-353bc4e14a7e@linux.alibaba.com>
Date: Sun, 23 Nov 2025 09:39:21 +0800
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
 <d652n6zrqbkt4oltusd5egbnrvd5xz3k4kbmqnfuwuatdyuekn@22jscte4mx7m>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <d652n6zrqbkt4oltusd5egbnrvd5xz3k4kbmqnfuwuatdyuekn@22jscte4mx7m>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2025/11/23 08:22, Sergey Senozhatsky wrote:
> On (25/11/22 20:24), Gao Xiang wrote:
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
> If you want to move data between two filesystems, then just
> mount both devices and cp/mv data between them.  zram is not
> going to do that for you, zram writeback is for different
> purpose.

No, I know what zram writeback is and I was definitely not
saying using zram writeback device to mount something (if
you have interest, just check out my first reply, it's
already clear.  Also you can know why loop devices need a
workqueue or a kthread since pre-v2.6 in the first place
just because of the same reason).  I want to stop here
because it's none of my business.

Thanks,
Gao Xiang

