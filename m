Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BF53390233
	for <linux-block@vger.kernel.org>; Wed, 17 Jun 2026 06:15:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781676914; cv=none; b=C7eKkFvxeq9moCp+kBW1PqIXkFjixlp63o7KdXjzvZJCYwd0W1BD87mU+TFznpYYf2fcK/wwZwi1hbhADaxD4w+l04BkF/wtnnv/8/bz0dXp4R8g5ousloPsaHXcA1ehLS4UOGRwudG0KTWkmvwQNKwBNaw4DVD73E6jv7alcGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781676914; c=relaxed/simple;
	bh=614yp7So0F5qyjoPHiz1xrAFzHyvVzS5lL4XHAeeOrY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:In-Reply-To:
	 Content-Type:References; b=ica2QZRrQNznu9TK+Qw+Rx1KNdGsTRxv18ufQfBaPD+L5N2iiedt/I/KJgTyfp6/y95SLOeQ2s3shcJ5U7mxvx6whV6N1nSX9aNNiduOeDrNGM0/7qoZurfKrFScCYO3a27yiZGkUnC+yYgsD0IWfKKRprLlfVLNxa102bkyk7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=Io3Dy4NT; arc=none smtp.client-ip=203.254.224.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="Io3Dy4NT"
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
	by mailout1.samsung.com (KnoxPortal) with ESMTP id 20260617061509epoutp01bc041eb96c1cabacc0bc20d0b497e726~5ybWyIBV90891208912epoutp01w
	for <linux-block@vger.kernel.org>; Wed, 17 Jun 2026 06:15:09 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20260617061509epoutp01bc041eb96c1cabacc0bc20d0b497e726~5ybWyIBV90891208912epoutp01w
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1781676909;
	bh=looy25guBxmRQYLHdOxQcJhFp8WHufn7xAcxrFBynK8=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=Io3Dy4NT2P3cV0U3owcf0Li3sa6HaTmWKNDb+bso04dMC65dLp/pnDUWzL96TAySB
	 NLg8sv6EJIez8grgpqvgXRgHYwoHBS0/Qx/9UHfPo1p/sYIt8g/u7GlkRiq38LWJvR
	 NEn96OFkwcaD2n5hiIoBsy4N35q6OMUyEKawc/kI=
Received: from epsnrtp02.localdomain (unknown [182.195.42.154]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTPS id
	20260617061509epcas5p2c9d84a6a8e409e54dd05e257447a5827~5ybWPg4j71694416944epcas5p2g;
	Wed, 17 Jun 2026 06:15:09 +0000 (GMT)
Received: from epcas5p4.samsung.com (unknown [182.195.38.89]) by
	epsnrtp02.localdomain (Postfix) with ESMTP id 4ggD9S3ylNz2SSKg; Wed, 17 Jun
	2026 06:15:08 +0000 (GMT)
Received: from epsmtip1.samsung.com (unknown [182.195.34.30]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
	20260617061507epcas5p4f7f04c2273385138b5abd1496025ef99~5ybVE6ZDB2336723367epcas5p4o;
	Wed, 17 Jun 2026 06:15:07 +0000 (GMT)
Received: from [107.122.10.194] (unknown [107.122.10.194]) by
	epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20260617061506epsmtip1a1be0610fd1cdccac36d81fbf22ea02e~5ybTRR01k2669226692epsmtip1r;
	Wed, 17 Jun 2026 06:15:05 +0000 (GMT)
Message-ID: <137fc9f3-16f6-481f-98d0-d8eccb346a14@samsung.com>
Date: Wed, 17 Jun 2026 11:44:59 +0530
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] blk-mq: bound blk_hctx_poll() to one jiffy
To: Fengnan <changfengnan@bytedance.com>, axboe@kernel.dk, hch@lst.de,
	kbusch@kernel.org, lidiangang@bytedance.com, tom.leiming@gmail.com,
	nj.shetty@samsung.com, joshi.k@samsung.com, anuj1072538@gmail.com
Cc: linux-block@vger.kernel.org, Alok Rathore <alok.rathore@samsung.com>
Content-Language: en-US
From: Anuj Gupta/Anuj Gupta <anuj20.g@samsung.com>
In-Reply-To: <2e916cee-3a82-47ac-a416-b52a9744cdd5@bytedance.com>
Content-Transfer-Encoding: 7bit
X-CMS-MailID: 20260617061507epcas5p4f7f04c2273385138b5abd1496025ef99
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
cpgsPolicy: CPGSC10-542,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20260611163403epcas5p2bba1c085eaab24852acfb0751ef148ab
References: <CGME20260611163403epcas5p2bba1c085eaab24852acfb0751ef148ab@epcas5p2.samsung.com>
	<20260611162719.910837-1-anuj20.g@samsung.com>
	<2e916cee-3a82-47ac-a416-b52a9744cdd5@bytedance.com>

On 6/12/2026 7:23 AM, Fengnan wrote:
>> diff --git a/block/blk-mq.c b/block/blk-mq.c
>> index 4c5c16cce4f8..d85fa4a51e79 100644
>> --- a/block/blk-mq.c
>> +++ b/block/blk-mq.c
>> @@ -5248,6 +5248,7 @@ static int blk_hctx_poll(struct request_queue *q, struct blk_mq_hw_ctx *hctx,
>>    			 struct io_comp_batch *iob, unsigned int flags)
>>    {
>>    	int ret;
>> +	unsigned long start = jiffies;
> how about this :
> 
> unsigned long timeout = jiffies + 1;
> ...
> } while (!need_resched() && time_before(jiffies, timeout));

Thanks for taking a look.
These are functionally identical but your form is established idiom at 
other places.
I will switch to that in v2.
--
Anuj
