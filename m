Received: from mail-m1040.netease.com (mail-m1040.netease.com [154.81.10.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10D794A08;
	Mon,  3 Jun 2024 01:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=154.81.10.40
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717379958; cv=none; b=nQReflqet7LPHqTxUD8gE9OM/iociwY6XukkIUynuoUm7822qJKxZn5d/NmjOjUWp/YHrJ/dlgrWdDgk/cPweRpd1kbKjG6jnvl7AG3Yl83Tu+bpaDlfXK4rg7G5/zaEAPeIiaFNv28NuqYxJe56ofkrgC5WfsZ5EAzRMAJSIbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717379958; c=relaxed/simple;
	bh=GZVCi5VbbjTDmXB32ysDacElGhSOcP5bQWWnQ1WtVSU=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=gMcODAeawgcdfr5WKuCSns5yfi9+KF8Bcmxiz8m3SWP95zLc7+3jlSTKNhLDJVrsRkgSC0+QAdzd7vx2Xs59eXPybw0lngJGTylgO3Nvrpk+JhpD2JDYMe1D1ykS44xYAl9PoTlUI4AOq7nZWFWbaI8RBz9cKQ1UU0mQvXn11tI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=easystack.cn; spf=none smtp.mailfrom=easystack.cn; arc=none smtp.client-ip=154.81.10.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=easystack.cn
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=easystack.cn
Received: from [192.168.122.189] (unknown [218.94.118.90])
	by smtp.qiye.163.com (Hmail) with ESMTPA id 5363886017F;
	Mon,  3 Jun 2024 09:33:29 +0800 (CST)
Subject: Re: [PATCH RFC 0/7] block: Introduce CBD (CXL Block Device)
To: Gregory Price <gregory.price@memverge.com>
Cc: Dan Williams <dan.j.williams@intel.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>, John Groves
 <John@groves.net>, axboe@kernel.dk, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-cxl@vger.kernel.org,
 nvdimm@lists.linux.dev
References: <20240508131125.00003d2b@Huawei.com>
 <ef0ee621-a2d2-e59a-f601-e072e8790f06@easystack.cn>
 <20240508164417.00006c69@Huawei.com>
 <3d547577-e8f2-8765-0f63-07d1700fcefc@easystack.cn>
 <20240509132134.00000ae9@Huawei.com>
 <a571be12-2fd3-e0ee-a914-0a6e2c46bdbc@easystack.cn>
 <664cead8eb0b6_add32947d@dwillia2-mobl3.amr.corp.intel.com.notmuch>
 <8f161b2d-eacd-ad35-8959-0f44c8d132b3@easystack.cn>
 <ZldIzp0ncsRX5BZE@memverge.com>
 <5db870de-ecb3-f127-f31c-b59443b4fbb4@easystack.cn>
 <Zlndc8NI0eK3MmuR@memverge.com>
From: Dongsheng Yang <dongsheng.yang@easystack.cn>
Message-ID: <a04a5bbc-a44b-57e4-0fa6-0ce84b18a395@easystack.cn>
Date: Mon, 3 Jun 2024 09:33:29 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <Zlndc8NI0eK3MmuR@memverge.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFJQjdXWS1ZQUlXWQ8JGhUIEh9ZQVkZT0geVh0dTxoYSEhOHx1NQlUZERMWGhIXJBQOD1
	lXWRgSC1lBWUlKQ1VCT1VKSkNVQktZV1kWGg8SFR0UWUFZT0tIVUpNT0lMTlVKS0tVSkJLS1kG
X-HM-Tid: 0a8fdbbae4da023ckunm5363886017f
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6Pi46ASo4IjcsCCwyChcyPww#
	EA4KChlVSlVKTEpMSExDT0pLS01OVTMWGhIXVR8UFRwIEx4VHFUCGhUcOx4aCAIIDxoYEFUYFUVZ
	V1kSC1lBWUlKQ1VCT1VKSkNVQktZV1kIAVlBT0JNSzcG



在 2024/5/31 星期五 下午 10:23, Gregory Price 写道:
> On Thu, May 30, 2024 at 02:59:38PM +0800, Dongsheng Yang wrote:
>>
>>
>> 在 2024/5/29 星期三 下午 11:25, Gregory Price 写道:
>>>
>>> There are some (FAMFS, for example). The coherence state of these
>>> systems tend to be less volatile (e.g. mappings are read-only), or
>>> they have inherent design limitations (cacheline-sized message passing
>>> via write-ahead logging only).
>>
>> Can you explain more about this? I understand that if the reader in the
>> writer-reader model is using a readonly mapping, the interaction will be
>> much simpler. However, after the writer writes data, if we don't have a
>> mechanism to flush and invalidate puncturing all caches, how can the
>> readonly reader access the new data?
> 
> This is exactly right, so the coherence/correctness of the data needs to
> be enforced in some other way.
> 
> Generally speaking, the WPQs will *eventually* get flushed.  As such,
> the memory will *eventually* become coherent.  So if you set up the
> following pattern, you will end up with an "eventually coherent" system


Yes, it is "eventually coherent" if "NO CLEAN WRITEBACK" bit in both 
CSDS and DVSEC is set.
> 
> 1) Writer instantiates the memory to be used
> 2) Writer calculates and records a checksum of that data into memory
> 3) Writer invalidates everything
> 4) Reader maps the memory
> 5) Reader reads the checksum and calculates the checksum of the data
>     a) if the checksums match, the data is coherent
>     b) if they don't, we must wait longer for the queues to flush

Yes, the checksum was mentioned by John, it is used in FAMFS/pcq_lib.c, 
pcq use sequence and checksum in consumer to make sure data consistency.

I think it's a good idea and was planning to introduce it into cbd, of 
coures it should be optional for cbd, as cbd current only supports
hardware-consistency usage. it can be an option to do data verification.

Thanx
> 
> This is just one example of a system design which enforces coherence by
> placing the limitation on the system that the data will never change
> once it becomes coherent.
> 
> Whatever the case, regardless of the scheme you come up with, you will
> end up with a system where the data must be inspected and validated
> before it can be used.  This has the limiting factor of performance:
> throughput will be limited by how fast you can validate the data.
> 
> ~Gregory
> .
> 
