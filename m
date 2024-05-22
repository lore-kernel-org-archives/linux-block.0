Received: from mail-m17224.xmail.ntesmail.com (mail-m17224.xmail.ntesmail.com [45.195.17.224])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D87082D047;
	Wed, 22 May 2024 09:22:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.195.17.224
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716369776; cv=none; b=Avy070/wz7rrgsgmrKH6GA+dPUVb3jgRlVdAeFROf8appbmk38iYb+5Fy5qPcpKZTochADR2GbTU5FDh5OVGotjXaUtuTi2373Shyf/3K/lpb/9iIoCqb3c5IZ6sT0DaM3uUhEfeWjHrewRKo2We+NPTL2loZ5K/eEXwRaC2/18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716369776; c=relaxed/simple;
	bh=WmJQo640ZQb8OrummdMPWB3IkXWYN23+eVltn+PnS9g=;
	h=From:Subject:To:Cc:References:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=Fj8dfTYuyzo2fI+xLdzn1BCv+8isZSUbf6s5DkHsKzPqiQOWpUg67shEHI9YGlUH8o6F+yi3m/SP5hq813IfuZm9X+OmNywcq2I/3ZqQ0BgybbduAzLm9RfUQolxPJJLFyetnQXCIul7vqAhdqPGtc7Rjn22/FrZRSSRToWNm/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=easystack.cn; spf=none smtp.mailfrom=easystack.cn; arc=none smtp.client-ip=45.195.17.224
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=easystack.cn
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=easystack.cn
Received: from [192.168.122.189] (unknown [218.94.118.90])
	by smtp.qiye.163.com (Hmail) with ESMTPA id 536F18602E0;
	Wed, 22 May 2024 14:17:39 +0800 (CST)
From: Dongsheng Yang <dongsheng.yang@easystack.cn>
Subject: Re: [PATCH RFC 0/7] block: Introduce CBD (CXL Block Device)
To: Dan Williams <dan.j.williams@intel.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: John Groves <John@groves.net>, Gregory Price
 <gregory.price@memverge.com>, axboe@kernel.dk, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-cxl@vger.kernel.org,
 nvdimm@lists.linux.dev
References: <8f373165-dd2b-906f-96da-41be9f27c208@easystack.cn>
 <wold3g5ww63cwqo7rlwevqcpmlen3fl3lbtbq3qrmveoh2hale@e7carkmumnub>
 <20240503105245.00003676@Huawei.com>
 <5b7f3700-aeee-15af-59a7-8e271a89c850@easystack.cn>
 <20240508131125.00003d2b@Huawei.com>
 <ef0ee621-a2d2-e59a-f601-e072e8790f06@easystack.cn>
 <20240508164417.00006c69@Huawei.com>
 <3d547577-e8f2-8765-0f63-07d1700fcefc@easystack.cn>
 <20240509132134.00000ae9@Huawei.com>
 <a571be12-2fd3-e0ee-a914-0a6e2c46bdbc@easystack.cn>
 <664cead8eb0b6_add32947d@dwillia2-mobl3.amr.corp.intel.com.notmuch>
Message-ID: <8f161b2d-eacd-ad35-8959-0f44c8d132b3@easystack.cn>
Date: Wed, 22 May 2024 14:17:38 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <664cead8eb0b6_add32947d@dwillia2-mobl3.amr.corp.intel.com.notmuch>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFJQjdXWS1ZQUlXWQ8JGhUIEh9ZQVkZGkoYVk5ITE1ITR5MSEJPHlUZERMWGhIXJBQOD1
	lXWRgSC1lBWUlKQ1VCT1VKSkNVQktZV1kWGg8SFR0UWUFZT0tIVUpNT0lMTlVKS0tVSkJLS1kG
X-HM-Tid: 0a8f9ef2be66023ckunm536f18602e0
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6OS46PRw6GDctHDMrDRoLDBoQ
	OTMKC0JVSlVKTEpNSE5DTU1LS0hPVTMWGhIXVR8UFRwIEx4VHFUCGhUcOx4aCAIIDxoYEFUYFUVZ
	V1kSC1lBWUlKQ1VCT1VKSkNVQktZV1kIAVlBT0JPSjcG



在 2024/5/22 星期三 上午 2:41, Dan Williams 写道:
> Dongsheng Yang wrote:
>> 在 2024/5/9 星期四 下午 8:21, Jonathan Cameron 写道:
> [..]
>>>> If we check and find that the "No clean writeback" bit in both CSDS and
>>>> DVSEC is set, can we then assume that software cache-coherency is
>>>> feasible, as outlined below:
>>>>
>>>> (1) Both the writer and reader ensure cache flushes. Since there are no
>>>> clean writebacks, there will be no background data writes.
>>>>
>>>> (2) The writer writes data to shared memory and then executes a cache
>>>> flush. If we trust the "No clean writeback" bit, we can assume that the
>>>> data in shared memory is coherent.
>>>>
>>>> (3) Before reading the data, the reader performs cache invalidation.
>>>> Since there are no clean writebacks, this invalidation operation will
>>>> not destroy the data written by the writer. Therefore, the data read by
>>>> the reader should be the data written by the writer, and since the
>>>> writer's cache is clean, it will not write data to shared memory during
>>>> the reader's reading process. Additionally, data integrity can be ensured.
> 
> What guarantees this property? How does the reader know that its local
> cache invalidation is sufficient for reading data that has only reached
> global visibility on the remote peer? As far as I can see, there is
> nothing that guarantees that local global visibility translates to
> remote visibility. In fact, the GPF feature is counter-evidence of the
> fact that writes can be pending in buffers that are only flushed on a
> GPF event.

Sounds correct. From what I learned from GPF, ADR, and eADR, there would 
still be data in WPQ even though we perform a CPU cache line flush in 
the OS.

This means we don't have a explicit method to make data puncture all 
caches and land in the media after writing. also it seems there isn't a 
explicit method to invalidate all caches along the entire path.

> 
> I remain skeptical that a software managed inter-host cache-coherency
> scheme can be made reliable with current CXL defined mechanisms.


I got your point now, acorrding current CXL Spec, it seems software 
managed cache-coherency for inter-host shared memory is not working. 
Will the next version of CXL spec consider it?
> 
