Received: from out30-101.freemail.mail.aliyun.com (out30-101.freemail.mail.aliyun.com [115.124.30.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FC9934E765;
	Tue,  3 Mar 2026 02:11:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772503907; cv=none; b=l6Kll1WPEhPzxXSaKnBn8AROpkoxShxYEmTIIWi9bOtBSg8ZCDrjsxqO74NpLE6DhwmfuXMjwFuoZCSNRn6CpJ2QxSkfNyvanPdjZ8NGnH8E7YHVx5H+ePVRT8OKoIiRv/B4oq76pDjIDmJew6mxQohpmHFOgXr29ta2fXMe9fI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772503907; c=relaxed/simple;
	bh=a+TC0gm3uLYWashzAwaanGyqxXsF7bXFJUVrp559WuA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CvO2l3u9dBUpc1o89FJxvxX+2anxbV9pAEB4tUoCWACdsIqLrWHqAm0gL/Wpn69JPUlCEpCUi5ebjfKTnNlbbN0b/yB/zUUeKVKajvMq1zdAWx6Cy6kUKx6RFDXfYkbiBXDdNj504/bei7FV1t4t3EhPC6SqmXSpIDxbR4Y9wzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=RJQbBhOo; arc=none smtp.client-ip=115.124.30.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="RJQbBhOo"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1772503901; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=nFbFx2/BFofkXvHdvXlriaDv4ASYA0leI76fEaVkqac=;
	b=RJQbBhOo8zP+T+B2GP67r4sFAAJLGsvYitCPCY3uWAqX3dOOPLBDPuwe6RRRAsNN/InDQMOXrqWG6/1XT+wDZYPvhE4VuSr5LfNwgMGggVNqY/I3sG4N6ShzNym8/ql38S+VRYH+ww1H2r6k/0UTTPpwPZ/uxFVh/s76Xb7qi+4=
Received: from 30.221.132.55(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0X-86zLx_1772503900 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 03 Mar 2026 10:11:40 +0800
Message-ID: <6e5aa87c-f3bb-4ae9-8700-27f7f1a9d7b2@linux.alibaba.com>
Date: Tue, 3 Mar 2026 10:11:38 +0800
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] block: avoild hang when bio_list is non-NULL in
 submit_bio_wait()
To: Jiucheng Xu <jiucheng.xu@amlogic.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org, jianxin.pan@amlogic.com,
 tuan.zhang@amlogic.com, Gao Xiang <xiang@kernel.org>,
 linux-erofs@lists.ozlabs.org, Christoph Hellwig <hch@infradead.org>
References: <20260302-for-next-v1-1-eb9339e8dc99@amlogic.com>
 <aaWVwH_Xna22DTAq@infradead.org>
 <dddf1754-d575-4f4b-a11c-09847d0d0475@linux.alibaba.com>
 <b2ad3f3f-105e-4171-b735-84051906cfb5@amlogic.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <b2ad3f3f-105e-4171-b735-84051906cfb5@amlogic.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2026/3/3 10:03, Jiucheng Xu wrote:
> 
> 

...

>>
>>> that need to use GFP_NOIO.
>>
>> Yes, it should make vm_map_ram() in the end_io path use
>> GFP_NOIO instead.
>>
>> Jiucheng, could you add memalloc_noio_{save,restore}() to
>> wrap up this path?
> 
> Thanks for Christoph's and Xiang's comments, I will try it. Thanks!

Just one more note: just wrap up z_erofs_decompressqueue_work() in
z_erofs_decompress_kickoff() with memalloc_noio_{save,restore}() is
enough.

  ...
  memalloc_noio_save()
  z_erofs_decompressqueue_work()
  memalloc_noio_restore()

> 
> Best Regards,
> Jiucheng

