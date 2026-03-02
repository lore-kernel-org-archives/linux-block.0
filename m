Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C51103E0C68;
	Mon,  2 Mar 2026 14:31:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772461904; cv=none; b=Htf4WIV25QUuIl1qdkTgQ+y2da3jQlodO4kY1grah6/UtW9Wvx4L2JHZFGDxTEx/2X6OptnceATsOKvfEcmZ9jR+MRPCfcKp2GLXAlqjBNt5+LeKu5cuWLC15CiPaJms/YTviVGUAMcFTRhW5I8Scv2Qc/wWY0oroYUQV1kEv0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772461904; c=relaxed/simple;
	bh=5lJKtMhPVFSMWjcExMLFxvxNnbbIjCoE7No9e4lqig8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BxGzRM3g1w+YjLQbX9JNd6TlyQVvRqWqChAoG+9eNxjyCIQea9P0KfQKFtDLMscYm/wuNNMsCo00VEUQ+urw3zgIyj812J/pdovYiqG9rnnAey8OLElY0hadP2EE0cUsWK3jXAPBgNgcwG/ZPiGZAy3XKHuO/8DUgnOYAYJArao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=Pq8bIPVV; arc=none smtp.client-ip=115.124.30.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="Pq8bIPVV"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1772461898; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=Xm4vXctV0FzuJ+WbTv3JqeE72Q00z0/K308lspoKlYE=;
	b=Pq8bIPVVWLdb8xMWfxvVqP/lUP76reBGvOYMjQN3uvrdR8TquHPysHk3nRTRqDW024Z6+mea63Yau6FmpjeuqJN4h9if9bB7wLUryo0bvwic9MpmRfgsmhWOkCxV/ixSp2UMhO/arN5CQIxHN8iiv6dipS4EBLnq33IBII/Jb2Q=
Received: from 30.42.59.174(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0X-5IIfM_1772461896 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 02 Mar 2026 22:31:37 +0800
Message-ID: <d50a059a-afa1-4803-a570-127c62b6e154@linux.alibaba.com>
Date: Mon, 2 Mar 2026 22:31:36 +0800
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] block: avoild hang when bio_list is non-NULL in
 submit_bio_wait()
To: Christoph Hellwig <hch@infradead.org>
Cc: jiucheng.xu@amlogic.com, Jens Axboe <axboe@kernel.dk>,
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 jianxin.pan@amlogic.com, tuan.zhang@amlogic.com, Gao Xiang
 <xiang@kernel.org>, linux-erofs@lists.ozlabs.org
References: <20260302-for-next-v1-1-eb9339e8dc99@amlogic.com>
 <aaWVwH_Xna22DTAq@infradead.org>
 <dddf1754-d575-4f4b-a11c-09847d0d0475@linux.alibaba.com>
 <aaWe1PsmzYatc_zR@infradead.org>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <aaWe1PsmzYatc_zR@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2026/3/2 22:29, Christoph Hellwig wrote:
> On Mon, Mar 02, 2026 at 10:23:04PM +0800, Gao Xiang wrote:
>>>> I've trimmed down the call stack, as follows:
>>>>
>>>> f2fs_submit_read_io
>>>>     submit_bio
>>>>       mmc_blk_mq_recovery
>>>>         z_erofs_endio
>>>>           vm_map_ram
>>>
>>> ->bi_end_io code really should not be having random in_atomic()
>>> checks that make it completely different, but even if they have
>>
>> Thanks for the head-up.
>>
>> For this part, I'm pretty sure we need this particular one
>> otherwise the scheduling performance (latency sensitive)
>> is unacceptable for all Android phone users.
> 
> Where do you regularly get user context calls to ->bi_end_io?

The obvious one is that dm-verity, it's actually in
the workqueue context.

Thanks,
Gao Xiang


