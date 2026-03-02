Received: from out30-113.freemail.mail.aliyun.com (out30-113.freemail.mail.aliyun.com [115.124.30.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40CC33FB059;
	Mon,  2 Mar 2026 14:23:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.113
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772461391; cv=none; b=agriA6awrvNAxVqAt+KMTvYNjjG91tZEvmf2v0vxcnfoKEHw1qbHK8dzjGPP9PXHICue8jTtcAElJC2hFRb/5glEsg3nl9Do15bFyRFL0U6ocRSqiEEb3R95PSExsF1/rJuH88I8wL0H5DsH5LiLYv/fniBFqTkExACCzSCv3nY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772461391; c=relaxed/simple;
	bh=Nm8YGtmotx8kcbnigsU+0Q4mnfkxrvL0jCW8eItv12E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TBwYIbRjbjRGUZmpzDFZJr/ajitf+4tVDO2YXqtJkpyFMko4i7n3HwSFTM0L6ENLV07RdYCqukHfoSgxzpWYC1fDn+DK71aykFHx3MRwAgwzNRqvh/xqJ1LfbhXoBzjNge+sMOpHCAuzVV2w/ZKqnmsXa4Tb5TZBBS4IuyrBB9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=BRX74265; arc=none smtp.client-ip=115.124.30.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="BRX74265"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1772461385; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=2FugYvgsUqNBnGpuxWyzeKwGRCsMsJJYaZoBUD/m+xs=;
	b=BRX74265ra/SrD+Ywdv0HkQsmvNeFcuq9FRMrjkDRrNYX7DpHlKp0yQ+BQrkTphdAYJFwUzdcSIRn/kJKBtna6L9keiAF5eUqfhUZi72fqchtU42sUKqDiwqDQU8rJmYpHtma/SoWz8ELLOVbGq19OkDKFYfwZGjWMiADjLxBX0=
Received: from 30.42.59.174(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0X-5AKXW_1772461384 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 02 Mar 2026 22:23:05 +0800
Message-ID: <dddf1754-d575-4f4b-a11c-09847d0d0475@linux.alibaba.com>
Date: Mon, 2 Mar 2026 22:23:04 +0800
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] block: avoild hang when bio_list is non-NULL in
 submit_bio_wait()
To: Christoph Hellwig <hch@infradead.org>, jiucheng.xu@amlogic.com
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org, jianxin.pan@amlogic.com,
 tuan.zhang@amlogic.com, Gao Xiang <xiang@kernel.org>,
 linux-erofs@lists.ozlabs.org
References: <20260302-for-next-v1-1-eb9339e8dc99@amlogic.com>
 <aaWVwH_Xna22DTAq@infradead.org>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <aaWVwH_Xna22DTAq@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Christoph,

On 2026/3/2 21:50, Christoph Hellwig wrote:
> On Mon, Mar 02, 2026 at 10:51:03AM +0800, Jiucheng Xu via B4 Relay wrote:
>> From: Jiucheng Xu <jiucheng.xu@amlogic.com>
>>
>> When current->bio_list is non-NULL in submit_bio_wait(),
>> submit_bio_noacct_nocheck appends bio to bio_list but skips IO
>> submission, causing submit_bio_wait() to hang indefinitely.
>>
>> Fix this by temporarily backup bio_list, setting bio_list to
>> NULL before calling submit_bio(), then restoring bio_list
>> after submit_bio() returns.
> 
> No.  Fix this by not doing something that is a bad idea.
> 
>> I've trimmed down the call stack, as follows:
>>
>> f2fs_submit_read_io
>>    submit_bio
>>      mmc_blk_mq_recovery
>>        z_erofs_endio
>>          vm_map_ram
> 
> ->bi_end_io code really should not be having random in_atomic()
> checks that make it completely different, but even if they have

Thanks for the head-up.

For this part, I'm pretty sure we need this particular one
otherwise the scheduling performance (latency sensitive)
is unacceptable for all Android phone users.

> that need to use GFP_NOIO.

Yes, it should make vm_map_ram() in the end_io path use
GFP_NOIO instead.

Jiucheng, could you add memalloc_noio_{save,restore}() to
wrap up this path?

Thanks,
Gao Xiang
