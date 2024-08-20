Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41F6518E34F
	for <linux-block@vger.kernel.org>; Tue, 20 Aug 2024 07:58:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724140698; cv=none; b=CXxiAnUsup1UoDak6rTOKDhZ1Fc2XeeDN80jrYKNVVKt1GSyryNwlRkN8/y4EO1lyhKyYXpMzktK1ZMNxq202+3OcvEI/MC9vYR1536uRSUp9yX0CX/buH2ibtt8nYI6HaDLMEZ+88cB2LwFiWWMfVAEh2fLaDvUPZSXbNFOWE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724140698; c=relaxed/simple;
	bh=gpwtE6Bp1AiaIl5ZsIKRTj25WTSViH0Pce7tm1HMtDA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:In-Reply-To:
	 Content-Type:References; b=sgYAT3rnwuiMAMsUdmwAFjKpka8LA8PvfcdFFnghYaCmmWu0oixb+KJl9aP0bugbpc7t17snXz1GCQPpCHJqSN7i1h5FVTGsr4G7E4aa85O21Yw9NmZgO+YIGXq5AYJur53EJA1jgeitZgj019NC8j7oiKq1EIAr7FBI3HPVuTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=vBW+gI0I; arc=none smtp.client-ip=203.254.224.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="vBW+gI0I"
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
	by mailout3.samsung.com (KnoxPortal) with ESMTP id 20240820075814epoutp03c0aa41ff6b46a7d48e361f48118dcbc5~tYNOQ9Qfd3131131311epoutp03R
	for <linux-block@vger.kernel.org>; Tue, 20 Aug 2024 07:58:14 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20240820075814epoutp03c0aa41ff6b46a7d48e361f48118dcbc5~tYNOQ9Qfd3131131311epoutp03R
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1724140694;
	bh=n1op7kAX1nG07G4nghX8cBHUl5wUBr1ZSxziuhLqLDw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=vBW+gI0IGprGyJGxu3ptaOyJT4WJETn8KI5hnqNg2rGwRtTT8wJEnsh0LGkJqQacz
	 ArYvsXL5Cu1gzKkLl2OL3tlbfCOSlpkQrY1XeFTzJirnJGOe6SADVFoDDPQsJq0JTG
	 UBP1hyKHZpJWPo9uh9aSKkeajMwV5MVrdReR/HeQ=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTP id
	20240820075813epcas5p4df09804ccc489a360a8e9bf10302515f~tYNNryvhr0688506885epcas5p4c;
	Tue, 20 Aug 2024 07:58:13 +0000 (GMT)
Received: from epsmgec5p1-new.samsung.com (unknown [182.195.38.179]) by
	epsnrtp3.localdomain (Postfix) with ESMTP id 4Wp1zl4SMJz4x9Pt; Tue, 20 Aug
	2024 07:58:11 +0000 (GMT)
Received: from epcas5p4.samsung.com ( [182.195.41.42]) by
	epsmgec5p1-new.samsung.com (Symantec Messaging Gateway) with SMTP id
	A4.04.19863.39C44C66; Tue, 20 Aug 2024 16:58:11 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
	20240820075104epcas5p4c54b3d4d81703cd1eb8209182026905a~tYG_J2DnS2271822718epcas5p4G;
	Tue, 20 Aug 2024 07:51:04 +0000 (GMT)
Received: from epsmgmc1p1new.samsung.com (unknown [182.195.42.40]) by
	epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20240820075104epsmtrp2380cb688a4f7e5b0c1a69156b13de175~tYG_IyMNo0902009020epsmtrp2k;
	Tue, 20 Aug 2024 07:51:04 +0000 (GMT)
X-AuditID: b6c32a50-c73ff70000004d97-34-66c44c936758
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
	epsmgmc1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	8A.75.07567.8EA44C66; Tue, 20 Aug 2024 16:51:04 +0900 (KST)
Received: from green245 (unknown [107.99.41.245]) by epsmtip1.samsung.com
	(KnoxPortal) with ESMTPA id
	20240820075102epsmtip118e64ca0808443d851154d982ab59c78~tYG8m_NSQ1149211492epsmtip1b;
	Tue, 20 Aug 2024 07:51:02 +0000 (GMT)
Date: Tue, 20 Aug 2024 13:13:21 +0530
From: Kundan Kumar <kundan.kumar@samsung.com>
To: Matthew Wilcox <willy@infradead.org>
Cc: axboe@kernel.dk, hch@lst.de, kbusch@kernel.org,
	linux-block@vger.kernel.org, joshi.k@samsung.com, mcgrof@kernel.org,
	anuj20.g@samsung.com, nj.shetty@samsung.com, c.gameti@samsung.com,
	gost.dev@samsung.com
Subject: Re: [PATCH v8 1/5] block: Added folio-ized version of
 bvec_try_merge_hw_page()
Message-ID: <20240820074321.i5budzkt4efcqodd@green245>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <ZsAlsjZeNmsBI6J0@casper.infradead.org>
User-Agent: NeoMutt/20171215
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrHJsWRmVeSWpSXmKPExsWy7bCmlu5knyNpBou+yVs0TfjLbLH6bj+b
	xfftfSwWNw/sZLJYufook8XR/2/ZLCYdusZosfeWtsWNCU8ZLbb9ns9s8fvHHDYHbo/NK7Q8
	Lp8t9di0qpPNY/fNBjaPvi2rGD0+b5ILYIvKtslITUxJLVJIzUvOT8nMS7dV8g6Od443NTMw
	1DW0tDBXUshLzE21VXLxCdB1y8wBOk5JoSwxpxQoFJBYXKykb2dTlF9akqqQkV9cYquUWpCS
	U2BSoFecmFtcmpeul5daYmVoYGBkClSYkJ1x83EPU8FVgYpjS9qYGhhf8HYxcnJICJhIPF98
	jbWLkYtDSGAPo8TWI3+ZIZxPjBL3txxhh3C+MUpcuH6MEaZl3qXVLBCJvYwS7+ZuhHKeMUpM
	f9vKBFLFIqAqsfTMZqAEBwebgK7Ej6ZQEFNEQEPizRYjkHJmgWuMEifXH2cDiQsLREosOscI
	YvIKmElsbQgGGcIrIChxcuYTFhCbE2jt1zUfmEFsUQEZiRlLv4IdKiEwl0Pi4imQFziAHBeJ
	xlMqEGcKS7w6voUdwpaS+PxuLxuEnS1xqHEDE4RdIrHzSANUjb1E66l+ZpAxzAIZEtu3mkGE
	ZSWmnloHVs4swCfR+/sJVCuvxI55MLaaxJx3U1kgbBmJhZdmQMU9JDafWgIN3PeMEodnXWac
	wCg/C8lrsxDWzQJbYSXR+aGJFSIsLbH8HweEqSmxfpf+AkbWVYxSqQXFuempyaYFhrp5qeXw
	2E7Oz93ECE64WgE7GFdv+Kt3iJGJg/EQowQHs5IIb/fLg2lCvCmJlVWpRfnxRaU5qcWHGE2B
	8TSRWUo0OR+Y8vNK4g1NLA1MzMzMTCyNzQyVxHlft85NERJITyxJzU5NLUgtgulj4uCUamAK
	zL6/XFZnravWM/aMl9vtpTzC1ycu73LTmj9ppf6vD6KTDK67bZ5UderN+QXZpscFbvb+/nVx
	s4t4x5mrK3cJTS1eyHruyOrwWS9azP/F8NwteRxqPPvH8SpFmf/MEvdyfv7P3uza3Ggyd8J3
	9rK4hvj/BU1Vt1PMPiQ8PaL+Y+7s/NkaX558qtrUuCYtwm+T65V6frbaC9I+4j5/gnVtstaL
	mpguctzTuzKvR7Fwld6dfEsWwbpYu80/y7N/ra53VXPSPqeW/SzT8B1n8ukDRbf+51qeWBSo
	pXN+jdZn7opa8xaufUuPhnj8lhKUj7QSfsbFuXhD1XXmqtr24nOm7DV7/s9zrqw+wXyU6aYS
	S3FGoqEWc1FxIgBn9S9oQQQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrILMWRmVeSWpSXmKPExsWy7bCSnO4LryNpBh/+Slk0TfjLbLH6bj+b
	xfftfSwWNw/sZLJYufook8XR/2/ZLCYdusZosfeWtsWNCU8ZLbb9ns9s8fvHHDYHbo/NK7Q8
	Lp8t9di0qpPNY/fNBjaPvi2rGD0+b5ILYIvisklJzcksSy3St0vgyjg8+yRjQTtfxcLTPSwN
	jFu4uxg5OSQETCTmXVrN0sXIxSEksJtRYsPGe0wQCRmJ3Xd3skLYwhIr/z1nhyh6wiix7vVW
	sASLgKrE0jObgbo5ONgEdCV+NIWCmCICGhJvthiBlDMLXGOUOLn+OBtIXFggUmLROUYQk1fA
	TGJrQzDExPeMEgfnnmMBmcgrIChxcuYTMJsZqGbe5ofMIPXMAtISy/9xgIQ5gU7+uuYDM4gt
	CnTljKVfmScwCs5C0j0LSfcshO4FjMyrGCVTC4pz03OTDQsM81LL9YoTc4tL89L1kvNzNzGC
	Y0VLYwfjvfn/9A4xMnEwHmKU4GBWEuHtfnkwTYg3JbGyKrUoP76oNCe1+BCjNAeLkjiv4YzZ
	KUIC6YklqdmpqQWpRTBZJg5OqQamvFPXPD5/d6tLipaYafjmxKuTqxblTrxdeffvwqpKwZ+8
	rK8UzjzLCHq65PEerx5lZ3m5HR6HE1Yu95fqXm4UIHG6epfIvPyoPIYau627MrXm1K1Y5733
	1bfDdsv39vz5XnZ7e83S56xtyRv97vTtmzvJYd4KFaPrzj8MM+o8vkgVhj6vFDucGBx43vbO
	3LMxmv/2Zh64qxvHz1hzt+rH4QCjxBdff1iUbAu6Fz0lJX7iha/31rbMt5LqnsjVe25NxfvZ
	ZoumJDEc+VZaPfFJ5Qm1Sdvms591mv3TSz54bqasI1c1q3OEuvXybcccHj/XXDL7j/Mndram
	hUp7PTsdO4MnHtw5e/pq7UTpN1d9ipVYijMSDbWYi4oTAdE7aEAEAwAA
X-CMS-MailID: 20240820075104epcas5p4c54b3d4d81703cd1eb8209182026905a
X-Msg-Generator: CA
Content-Type: multipart/mixed;
	boundary="----K_xth5sKcUEfCV0X9aU-k.Br-XWllh-4huxyB_iNSY1rR3o.=_8c32d_"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240711051529epcas5p1aaf694dfa65859b8a32bdffce5239bf6
References: <20240711050750.17792-1-kundan.kumar@samsung.com>
	<CGME20240711051529epcas5p1aaf694dfa65859b8a32bdffce5239bf6@epcas5p1.samsung.com>
	<20240711050750.17792-2-kundan.kumar@samsung.com>
	<ZsAlsjZeNmsBI6J0@casper.infradead.org>

------K_xth5sKcUEfCV0X9aU-k.Br-XWllh-4huxyB_iNSY1rR3o.=_8c32d_
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Disposition: inline

On 17/08/24 05:23AM, Matthew Wilcox wrote:
>On Thu, Jul 11, 2024 at 10:37:46AM +0530, Kundan Kumar wrote:
>> -bool bvec_try_merge_hw_page(struct request_queue *q, struct bio_vec *bv,
>> -		struct page *page, unsigned len, unsigned offset,
>> +bool bvec_try_merge_hw_folio(struct request_queue *q, struct bio_vec *bv,
>> +		struct folio *folio, size_t len, size_t offset,
>>  		bool *same_page)
>>  {
>> +	struct page *page = folio_page(folio, 0);
>>  	unsigned long mask = queue_segment_boundary(q);
>>  	phys_addr_t addr1 = bvec_phys(bv);
>>  	phys_addr_t addr2 = page_to_phys(page) + offset + len - 1;
>[...]
>> +bool bvec_try_merge_hw_page(struct request_queue *q, struct bio_vec *bv,
>> +		struct page *page, unsigned int len, unsigned int offset,
>> +		bool *same_page)
>> +{
>> +	struct folio *folio = page_folio(page);
>> +
>> +	return bvec_try_merge_hw_folio(q, bv, folio, len,
>> +			((size_t)folio_page_idx(folio, page) << PAGE_SHIFT) +
>> +			offset, same_page);
>> +}
>
>This is the wrong way to do it.  bio_add_folio() does it correctly
>by being a wrapper around bio_add_page().
>
>The reason is that in the future, not all pages will belong to folios.
>For those pages, page_folio() will return NULL, and this will crash.
>

I can change in this fashion. page_folio is getting used at many other
places in kernel and currently there are no NULL checks. Will every place
need a change?
In this series we use page_folio to fetch folio for pages returned by
iov_iter_extract_pages. Then we iterate on the folios instead of pages.
We were progressing to change all the page related functions to accept
struct folio.
If page_folio may return NULL in future, it will require us to maintain
both page and folio versions. Do you see it differently ?


------K_xth5sKcUEfCV0X9aU-k.Br-XWllh-4huxyB_iNSY1rR3o.=_8c32d_
Content-Type: text/plain; charset="utf-8"


------K_xth5sKcUEfCV0X9aU-k.Br-XWllh-4huxyB_iNSY1rR3o.=_8c32d_--
