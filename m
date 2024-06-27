Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6326C2139D6
	for <linux-block@vger.kernel.org>; Thu, 27 Jun 2024 18:33:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719513199; cv=none; b=djcMN3b9FIU70JDvFDsreMoJCqt2x2f1QTLUaLWP+gr4/Q6+XqoUuDxVulyAHhA7DSka6GPnNgLhJ5+q5a3HRc//+tos7ONkBJVPN9KXcOqFrUZ449oy6hh2Cee3seLi3WeJhysy79xK27d6/LlK1xMwR4CfaPrth6eWBOsWZGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719513199; c=relaxed/simple;
	bh=HgFhDG1X3upg9nMzm5lde1P1nuSPBBFmAIwLNBYCpU4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:In-Reply-To:
	 Content-Type:References; b=d6Y2nkleDPuGOQ77C2fpUp207Z9mjpgR6Z0V+chKSATeBeHHGVjSbWINUN4U3t5AiC/nx98lNpssNxZqKj8ktJNsW005fJI74uFHna1vzZCqyU9e6AcZdCB78ikKlwCCl7dI9RSbW4kffnl+XG5go5tzt1T1FHaBnws91vsj+n8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=QiEs6P3h; arc=none smtp.client-ip=203.254.224.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="QiEs6P3h"
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
	by mailout3.samsung.com (KnoxPortal) with ESMTP id 20240627183314epoutp038ab51811d7653534f5b1d1c3c8a9903f~c8CO9GE9U2810328103epoutp03X
	for <linux-block@vger.kernel.org>; Thu, 27 Jun 2024 18:33:14 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20240627183314epoutp038ab51811d7653534f5b1d1c3c8a9903f~c8CO9GE9U2810328103epoutp03X
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1719513194;
	bh=LeeS3mzNAHp/KygIL8uRYQf61jRwdU46yOoymoQIX9o=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=QiEs6P3hG1A0RLCBtTya20mGlKYnunfab0THHfIstCd7FYo1u0v8o8gjr5NgH/p9Y
	 FwojV+dMMVqygivZVBPXZ815H5JiaDAaQQg5gF5UeTTpqQyopZ/WzbeXwqDHcHkHW4
	 mYAjEgvEjp0fFPlLqVAz20o89KR9DnCn3bjhjzP8=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTP id
	20240627183313epcas5p4b610d56f2f11fc9b99f88b6b6ac4f3d7~c8CObcLHi1026110261epcas5p4S;
	Thu, 27 Jun 2024 18:33:13 +0000 (GMT)
Received: from epsmges5p2new.samsung.com (unknown [182.195.38.182]) by
	epsnrtp1.localdomain (Postfix) with ESMTP id 4W96dM5ynzz4x9Pp; Thu, 27 Jun
	2024 18:33:11 +0000 (GMT)
Received: from epcas5p3.samsung.com ( [182.195.41.41]) by
	epsmges5p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
	16.2B.09989.760BD766; Fri, 28 Jun 2024 03:33:11 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
	20240627183311epcas5p463bfb0ad5ba319ab9efbf4b46d967918~c8CMknoHR1026110261epcas5p4O;
	Thu, 27 Jun 2024 18:33:11 +0000 (GMT)
Received: from epsmgmcp1.samsung.com (unknown [182.195.42.82]) by
	epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20240627183311epsmtrp2db54af5ff44eb852a0faed9a6e5e188d~c8CMj9mO51214112141epsmtrp2x;
	Thu, 27 Jun 2024 18:33:11 +0000 (GMT)
X-AuditID: b6c32a4a-bffff70000002705-fd-667db06783c2
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
	epsmgmcp1.samsung.com (Symantec Messaging Gateway) with SMTP id
	E8.83.18846.760BD766; Fri, 28 Jun 2024 03:33:11 +0900 (KST)
Received: from [107.122.11.51] (unknown [107.122.11.51]) by
	epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20240627183310epsmtip1927f53799ad3fa354e639584e967e237~c8CL1GmV31627116271epsmtip1N;
	Thu, 27 Jun 2024 18:33:10 +0000 (GMT)
Message-ID: <d482d9a0-9d9f-1b4b-5511-c787f43a31af@samsung.com>
Date: Fri, 28 Jun 2024 00:03:09 +0530
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0)
	Gecko/20100101 Thunderbird/91.13.1
Subject: Re: [PATCH 5/5] block: remove bio_integrity_process
Content-Language: en-US
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, "Martin K . Petersen"
	<martin.petersen@oracle.com>, linux-block@vger.kernel.org
From: Kanchan Joshi <joshi.k@samsung.com>
In-Reply-To: <20240627154759.GA25261@lst.de>
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmphk+LIzCtJLcpLzFFi42LZdlhTUzd9Q22awb7n+har7/azWaxcfZTJ
	Yu8tbYvlx/8xObB4XD5b6rH7ZgObx8ent1g8Pm+SC2CJyrbJSE1MSS1SSM1Lzk/JzEu3VfIO
	jneONzUzMNQ1tLQwV1LIS8xNtVVy8QnQdcvMAVqopFCWmFMKFApILC5W0rezKcovLUlVyMgv
	LrFVSi1IySkwKdArTswtLs1L18tLLbEyNDAwMgUqTMjOmHMmu+A9e8WlmX/YGhgXs3UxcnJI
	CJhIHHnwnaWLkYtDSGA3o0Tj9TWMEM4nRonJk66ywjlnpi9hh2nZfvUHVMtORomru2+zQThv
	GSXWf97GClLFK2AncWprC5jNIqAqMfHPaXaIuKDEyZlPWEBsUYFkiZ9dB8AOERawkTgytZMJ
	xGYWEJe49WQ+mC0ioCTx9NVZRoh4scSyhVOB6jk42AQ0JS5MLgUJcwroSOyd+pkZokReYvvb
	Ocwg90gI3GOXOPdsKiPE1S4SX6/OYoWwhSVeHd8C9Y2UxOd3e6GBkS3x4NEDFgi7RmLH5j6o
	enuJhj83WEH2MgPtXb9LH2IXn0Tv7ydMIGEJAV6JjjYhiGpFiXuTnkJ1iks8nLEEyvaQOHG/
	iwkSVE1MEutPTmKfwKgwCylUZiH5fhaSd2YhbF7AyLKKUTK1oDg3PbXYtMAoL7UcHt/J+bmb
	GMHJUctrB+PDBx/0DjEycTAeYpTgYFYS4Q0tqUoT4k1JrKxKLcqPLyrNSS0+xGgKjJ6JzFKi
	yfnA9JxXEm9oYmlgYmZmZmJpbGaoJM77unVuipBAemJJanZqakFqEUwfEwenVANTK1Pf1dCd
	n351CqzcGZK8xbJL6HbVV5Hnh3vm8Uws0q5TlKg/drpMlyfiQPaJtet/LRM4G7htdkYJ6z/e
	pB0OxnHTOY/v1Is59ul9v+3njy8lvZfGyrJelmieGZx16Ef1u/pbaUJ5rtohrwS2RBlWzTYL
	ds5ddT/lTFxaQFTuE921MaGnVPZPbvjjP+f1wXONT5Le9hj1JET29AiHvkgQvaiUff2B148T
	eSE7bu1/uHuvocqza1LaT+tca0pCVi9ccTxn29+qV+b/RUoDU/48O/Yjvy/UUtXVbt3MSRm7
	P8RzM19b/v2TbunWu1p9Me5iJ1r0a9mzJH9zRHjV9V84mx5frPX0Dm9VgC/TQQUlluKMREMt
	5qLiRABSnsgBFwQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrNLMWRmVeSWpSXmKPExsWy7bCSnG76hto0gz13JC1W3+1ns1i5+iiT
	xd5b2hbLj/9jcmDxuHy21GP3zQY2j49Pb7F4fN4kF8ASxWWTkpqTWZZapG+XwJUx50x2wXv2
	iksz/7A1MC5m62Lk5JAQMJHYfvUHSxcjF4eQwHZGiUtTd7NDJMQlmq/9gLKFJVb+e84OUfSa
	UWLOhd+MIAleATuJU1tbWEFsFgFViYl/TrNDxAUlTs58wgJiiwokS7z8MxEsLixgI3FkaicT
	iM0MtODWk/lgtoiAksTTV2cZIeKlEl9uXACLCwk0MUksWq/dxcjBwSagKXFhcilImFNAR2Lv
	1M/MEOVmEl1bu6Ba5SW2v53DPIFRaBaSK2Yh2TYLScssJC0LGFlWMYqmFhTnpucmFxjqFSfm
	Fpfmpesl5+duYgSHv1bQDsZl6//qHWJk4mA8xCjBwawkwhtaUpUmxJuSWFmVWpQfX1Sak1p8
	iFGag0VJnFc5pzNFSCA9sSQ1OzW1ILUIJsvEwSnVwCSR7lU8h80gy+OD40r/kn6ZB5Mdf73i
	b3ros1rK2qI48OcRrn/Rp1ZNmrxJ0dt0ebVF/D1f/czVVWrat7S+JxQ09S9IDDF9uOeaUNgW
	vcCrDDFPzjy9Un2Ts/ewFLNG/hnuya3i/PWHF99RNkpqz/qRzbfIs9Xk1qVNqpe45PLEm4yE
	H0T1tap8XcL+0XaWnkSP21y3Zi2G3dc9YuruL3X2UQ3kiCj3Xhh9KDt18wJbLu2Uqg6pQtFZ
	kV4u6WdX7QxRUpHo2xSX//F+/OEbCxhEgzpO18wJ8ZWcPCl4++uDHRz71j085TB/zQeWPtOk
	mE6RRA/9dd5vyq93OQUnPq4+qbQvmNXgyM3LLpJKLMUZiYZazEXFiQCi9e9T7gIAAA==
X-CMS-MailID: 20240627183311epcas5p463bfb0ad5ba319ab9efbf4b46d967918
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240626050052epcas5p29fc1cf1ef40fdec63860f6d6df9ffad1
References: <20240626045950.189758-1-hch@lst.de>
	<CGME20240626050052epcas5p29fc1cf1ef40fdec63860f6d6df9ffad1@epcas5p2.samsung.com>
	<20240626045950.189758-6-hch@lst.de>
	<a7fd0e31-63bd-8fff-d7d4-6ba990098e7a@samsung.com>
	<20240627154759.GA25261@lst.de>

On 6/27/2024 9:17 PM, Christoph Hellwig wrote:
> On Thu, Jun 27, 2024 at 09:06:56PM +0530, Kanchan Joshi wrote:
>> The bi->csum_type is constant as far as this bio_for_each_segment loop
>> is concerned.
>> Seems wasteful processing, and can rather be moved out where we set a
>> function pointer to point to either ext_pi_crc64_generate or
>> t10_pi_generate once.
> A function pointer is way more expensive than a few branches, especially
> easily predictable ones.
> 

In general yes. Maybe I can profile this particular case someday and get 
myself convinced. But regardless, I am unsure what the patch buys.

During write:
-               bio_integrity_process(bio, &bio->bi_iter);
+               blk_integrity_generate(bio);

During read:
-       bio->bi_status = bio_integrity_process(bio, &bip->bio_iter);
+       blk_integrity_verify(bio);

One less argument is passed, but common code of bio_integrity_process 
got mostly duplicated into blk_integrity_generate/verify now.
