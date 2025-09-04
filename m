Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DEC223D7EC
	for <linux-block@vger.kernel.org>; Thu,  4 Sep 2025 06:37:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756967864; cv=none; b=LEymAP5Yetsjhme0MdDrg322Im/fHZIcPYZ+rjtvpIoN0Jo9nF76x/uJO/ClcYhHuqOa3bJgUur0nWTkcQr+vkhql8v2O/Nfi6CesYoKZfcpZ/xVN+FmCL88ZlNXn9Z+0k0TyGXWiPtMhh2eDnEQ9pm2lRFFeMgYAcDzvlcYNv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756967864; c=relaxed/simple;
	bh=4G9E878SIS/wbuyZyR8KFsHh8YP6quGk35BoPlc/5o0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:MIME-Version:
	 Content-Type:References; b=RDHkvDoi08tiCPHXWQFmJ4LUyhNywvdwtN/DamoLNkckw63jG4klyolcZGMW40zatqxnWrhKUMl2WZ7Ahnxdid8xMOkNXOzpcD5i+DUoaEGSCYJak7OtAPYYkObzssjlLUo3yET14MIppZYywtzJLDglXCV8KLICNBkY8SHRr1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=rYnNUfie; arc=none smtp.client-ip=203.254.224.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="rYnNUfie"
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
	by mailout3.samsung.com (KnoxPortal) with ESMTP id 20250904063740epoutp0380f1ecb1cfbb5c78352ce8fbd4f133a4~iAPXQ4hnM1917519175epoutp03V
	for <linux-block@vger.kernel.org>; Thu,  4 Sep 2025 06:37:40 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20250904063740epoutp0380f1ecb1cfbb5c78352ce8fbd4f133a4~iAPXQ4hnM1917519175epoutp03V
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1756967860;
	bh=L7d+FR1/8tzMMzgyBtzSiqeqlPWmljT4OodjD28MEuE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rYnNUfieCPp1two5PYM4yfmwkEP5UrJka+GQycWZGrula6GFRqwzXYDzLC1560hgW
	 yYs/zyxj0peIaR/sRVFZ9oaPwQL/SzRbd5uNpdDhZ0Ivj2fzSozf4x/L1d0FWHknCL
	 jM28GCeU7AHEV9RNmRyWJKItiNkNHyTc1IpjO884=
Received: from epsnrtp01.localdomain (unknown [182.195.42.153]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTPS id
	20250904063740epcas5p46e506f80abbf698a49575878c2fd3dc1~iAPW97Ib01444614446epcas5p4c;
	Thu,  4 Sep 2025 06:37:40 +0000 (GMT)
Received: from epcas5p2.samsung.com (unknown [182.195.38.87]) by
	epsnrtp01.localdomain (Postfix) with ESMTP id 4cHVCQ6wY7z6B9mB; Thu,  4 Sep
	2025 06:37:38 +0000 (GMT)
Received: from epsmtip2.samsung.com (unknown [182.195.34.31]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
	20250904063643epcas5p3a831ee47fb91bae02b07dfe398b77dd8~iAOibCy-J0506205062epcas5p3A;
	Thu,  4 Sep 2025 06:36:43 +0000 (GMT)
Received: from node122.. (unknown [109.105.118.122]) by epsmtip2.samsung.com
	(KnoxPortal) with ESMTPA id
	20250904063642epsmtip249667dfd8f792ee479b5833d10408d3d~iAOhnvQLo1627016270epsmtip2u;
	Thu,  4 Sep 2025 06:36:42 +0000 (GMT)
From: Xue He <xue01.he@samsung.com>
To: yukuai1@huaweicloud.com, axboe@kernel.dk
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	yukuai3@huawei.com
Subject: Re: [PATCH] block: plug attempts to batch allocate tags multiple
 times
Date: Thu,  4 Sep 2025 06:32:09 +0000
Message-Id: <20250904063209.12586-1-xue01.he@samsung.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <bfc12406-e608-b3fa-45e7-2105d9cc15bf@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20250904063643epcas5p3a831ee47fb91bae02b07dfe398b77dd8
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
cpgsPolicy: CPGSC10-505,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20250904063643epcas5p3a831ee47fb91bae02b07dfe398b77dd8
References: <bfc12406-e608-b3fa-45e7-2105d9cc15bf@huaweicloud.com>
	<CGME20250904063643epcas5p3a831ee47fb91bae02b07dfe398b77dd8@epcas5p3.samsung.com>

On 2025/09/03/18:35PM, Yu Kuai wrote:
>On 2025/09/03 16:41 PM, Xue He wrote:
>> On 2025/09/02 08:47 AM, Yu Kuai wrote:
>>> On 2025/09/01 16:22 PM, Xue He wrote:
>> ......
>> 
>> the information of my nvme like this:
>> number of CPU: 16
>> memory: 16G
>> nvme nvme0: 16/0/16 default/read/poll queue
>> cat /sys/class/nvme/nvme0/nvme0n1/queue/nr_requests
>> 1023
>> 
>> In more precise terms, I think it is not that the tags are fully exhausted,
>> but rather that after scanning the bitmap for free bits, the remaining
>> contiguous bits are nsufficient to meet the requirement (have but not enough).
>> The specific function involved is __sbitmap_queue_get_batch in lib/sbitmap.c.
>>                      get_mask = ((1UL << nr_tags) - 1) << nr;
>>                      if (nr_tags > 1) {
>>                              printk("before %ld\n", get_mask);
>>                      }
>>                      while (!atomic_long_try_cmpxchg(ptr, &val,
>>                                                        get_mask | val))
>>                              ;
>>                      get_mask = (get_mask & ~val) >> nr;
>> 
>> where during the batch acquisition of contiguous free bits, an atomic operation
>> is performed, resulting in the actual tag_mask obtained differing from the
>> originally requested one.
>
>Yes, so this function will likely to obtain less tags than nr_tags,the
>mask is always start from first zero bit with nr_tags bit, and
>sbitmap_deferred_clear() is called uncondionally, it's likely there are
>non-zero bits within this range.
>
>Just wonder, do you consider fixing this directly in
>__blk_mq_alloc_requests_batch()?
>
>  - call sbitmap_deferred_clear() and retry on allocation failure, so
>that the whole word can be used even if previous allocated request are
>done, especially for nvme with huge tag depths;
>  - retry blk_mq_get_tags() until data->nr_tags is zero;
>

I haven't tried this yet, as I'm concerned that if it spin here, it might
introduce more latency. Anyway, I may try to implement this idea and do some
tests to observe the results.

Thanks.
