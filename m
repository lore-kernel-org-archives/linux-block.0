Received: from out30-119.freemail.mail.aliyun.com (out30-119.freemail.mail.aliyun.com [115.124.30.119])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A22625CDF1;
	Fri, 21 Nov 2025 12:21:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.119
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763727715; cv=none; b=logqhVJipypWyOfI4/IpTN76tMQ8wO775Gb8DuRWljFKaSRNRJP1BCEF1KTV3ddxGZ3aTh1h2g5NaF4IZQc93uHdNprZhxRPQ6xUvLtpMidMe1Y16yuzt1bNTRjToSDERHsrM7hWcyKTmbbbxSxg6JP/LELsm6a8bxALp+7+k6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763727715; c=relaxed/simple;
	bh=Xt1f2IKZaFb6YsVxD0E8CFQc7icoYxfngOGl5WPzDxE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RjPTGqWm9LfBOQnn9ZdoD0b4a1XOe9HBUkXtOHUHNyLture86Vo1XLAS6JiSY9fLCGkaiRgg6p0E/rdvnSMMd6lYLGos97Tv1oExpuzWQ0zfNeEhd0GVe0ftf5B3XnwuzVq09BFS3WUzTtkyjhaJraq7pteIq8w30gFhEGxnukM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=IWkPALJw; arc=none smtp.client-ip=115.124.30.119
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="IWkPALJw"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1763727704; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=4VddRBqQQlyL+Xj+/XmM94zKGHnKwIKpRSELjbmbuWM=;
	b=IWkPALJwXVzYSzTVnqcM3XeO/IqG4VkRfICVYTanb70LVpqou6Avb9Lkf8PFz7Wg+OyxLdqo97IMLdvyFSVuKzyryQu876YEZb4g4+Bs1mRpIH0Rf1Nwx6GDamPoErwGC5gPT7c7yCN56qU5nDcfJ1+qtvpUAioYwsjawlb6+MI=
Received: from 30.170.82.147(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0Wt059Jp_1763727702 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 21 Nov 2025 20:21:44 +0800
Message-ID: <8c596737-95c1-4274-9834-1fe06558b431@linux.alibaba.com>
Date: Fri, 21 Nov 2025 20:21:41 +0800
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCHv5 0/6] zram: introduce writeback bio batching
To: Sergey Senozhatsky <senozhatsky@chromium.org>,
 Yuwen Chen <ywen.chen@foxmail.com>
Cc: akpm@linux-foundation.org, bgeffon@google.com, licayy@outlook.com,
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, minchan@kernel.org, richardycc@google.com
References: <ts32xzxrpxmwf3okxo4bu2ynbgnfe6mehf5h6eibp7dp3r6jp7@4f7oz6tzqwxn>
 <tencent_865DD78A73BC3C9CAFCBAEBE222B6EA5F107@qq.com>
 <buckmtxvdfnpgo56owip3fjqbzraws2wvtomzfkywhczckoqlt@fifgyl5fjpbt>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <buckmtxvdfnpgo56owip3fjqbzraws2wvtomzfkywhczckoqlt@fifgyl5fjpbt>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2025/11/21 17:12, Sergey Senozhatsky wrote:
> On (25/11/21 16:23), Yuwen Chen wrote:

..


>>> I think page-fault latency of a written-back page is expected to be
>>> higher, that's a trade-off that we agree on.  Off the top of my head,
>>> I don't think we can do anything about it.
>>>
>>> Is loop device always used as for writeback targets?
>>
>> On the Android platform, currently only the loop device is supported as
>> the backend for writeback, possibly for security reasons. I noticed that
>> EROFS has implemented a CONFIG_EROFS_FS_BACKED_BY_FILE to reduce this
>> latency. I think ZRAM might also be able to do this.
> 
> I see.  Do you use S/W or H/W compression?

No, I'm pretty sure it's impossible for zram to access
file I/Os without another thread context (e.g. workqueue),
especially for write I/Os, which is unlike erofs:

EROFS can do because EROFS is a specific filesystem, you
could see it's a seperate fs, and it can only read (no
write context) backing files in erofs and/or other fses,
which is much like vfs/overlayfs read_iter() directly
going into the backing fses without nested contexts.
(Even if loop is used, it will create its own thread
contexts with workqueues, which is safe.)

  In the other hand, zram/loop can act as a virtual block
device which is rather different, which means you could
format an ext4 filesystem and backing another ext4/btrfs,
like this:

   zram(ext4) -> backing ext4/btrfs

It's unsafe (in addition to GFP_NOIO allocation
restriction) since zram cannot manage those ext4/btrfs
existing contexts:

  - Take one detailed example, if the upper zram ext4
assigns current->journal_info = xxx, and submit_bio() to
zram, which will confuse the backing ext4 since it should
assume current->journal_info == NULL, so the virtual block
devices need another thread context to isolate those two
different uncontrolled contexts.

So I don't think it's feasible for block drivers to act
like this, especially mixing with writing to backing fses
operations.

Thanks,
Gao Xiang
