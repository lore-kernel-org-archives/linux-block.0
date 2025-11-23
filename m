Received: from out30-110.freemail.mail.aliyun.com (out30-110.freemail.mail.aliyun.com [115.124.30.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F7C68479;
	Sun, 23 Nov 2025 01:23:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.110
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763861019; cv=none; b=DVN45hKikqG1KSxFquiUM+fp9eI3tSDHtp6KpwTakVxXeYBadan3GZd3FFbfcFMlwRF7yx2aAqGw36SUFlxkHPUaFeqlvMBE3Stk9HV2OAGTekhaND2B5JcQk9d6+BhQ8lxstUy2WKjh5Znzk9XPKpkPqr/QsZEXNnWDvmytxzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763861019; c=relaxed/simple;
	bh=xeeOy9Y9AfZHjdQ419M8o1x6xYIid00dkdAZDe44HXo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Q5JOi1rqhMooziS3zGXQoqceGmrGtHdjfsnsgGXAvwIHUbz5BxSTH63zvYlqFE+B10f40QO/G8MgZ7QzuX4XjAP/NoQwezislGOGjKcO0qGaxjHQMGZQLg0eNFr2l6aUKe2ZabqNPLOk/S2NOLrxVS8jriusMuLfpuITOUg7Fgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=iq7nSKs/; arc=none smtp.client-ip=115.124.30.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="iq7nSKs/"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1763861013; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=VCIF5DLiQMx6oN9DUx9P7XFgjwtiupQtB75jei15lO8=;
	b=iq7nSKs/oouky7FRG2MwTRD41R0/nCUFP8w5WyTRhRfU9V1d6ro26yPJvGwVIGUS30x6C2Kbwl/hVrbr7bl9gv67nYgrjR6YGvktq7QbXP4dPsBF0YNl4JvzuKJqyzfFGE6scbAXFY8J96zm2PdKRozmnpIem+15Iltez2KO0bo=
Received: from 30.170.82.147(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0Wt66DMu_1763861012 cluster:ay36)
          by smtp.aliyun-inc.com;
          Sun, 23 Nov 2025 09:23:33 +0800
Message-ID: <d3c01e18-c556-4892-8283-08765c5e6cb9@linux.alibaba.com>
Date: Sun, 23 Nov 2025 09:23:31 +0800
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
 <2c6906d1-132e-401f-830f-ae771fe836c5@linux.alibaba.com>
 <nx6o4gwpetxjeyfbu4xyibulvldr3xz6lyfjrar62cidy5gxum@xmx4ojyq3mbf>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <nx6o4gwpetxjeyfbu4xyibulvldr3xz6lyfjrar62cidy5gxum@xmx4ojyq3mbf>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2025/11/23 08:08, Sergey Senozhatsky wrote:
> On (25/11/22 22:09), Gao Xiang wrote:
>>> I thought you were talking about the backing device being
>>> ext4/btrfs.  Sorry, I don't have enough context/knowledge
>>> to understand what you're getting at.  zram has been doing
>>> writeback for ages, I really don't know what you mean by
>>> "to act like this".
>>
>> I mean, if zram is formatted as ext4, and then mount it;
>> and then there is a backing file which is also in another
>> ext4, you'd need a workqueue to do writeback I/Os (or needs
>> a loop device to transit), was that the original question
>> raised by Yuwen?
> 
> We take pages of data from zram0 and write them straight to
> the backing device.  Those writes don't go through vfs/fs so
> fs on the backing device will simply be corrupted, as far as
> I can tell.  This is not intendant use case for zram writeback.

I'm pretty sure you don't understand what I meant.

I won't reply this anymore, good luck.

Thanks,
Gao Xiang
