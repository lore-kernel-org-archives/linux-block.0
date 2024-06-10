Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5DCD757F5
	for <linux-block@vger.kernel.org>; Mon, 10 Jun 2024 09:34:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718012055; cv=none; b=c8AcLRH13cs6c+N9od0zRRunHhEpeSlLQ5bg09WZUhK83u+uqml85FE4GSo57t0rAzL7d9ok9RKDsBaezrQ7b+FtywbYC/dlpXgBcLDbLrl/rt6ZqTy1TvM8gPd8Dmy1A9TvMZoOdMK4wKV6GDBC1IEA2YYdQoXZ/e/a1Qk2/T4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718012055; c=relaxed/simple;
	bh=IcYvx0DrjZGk5nfCLPoMCudNjqKRzmKAjDEyOKKmDRY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:In-Reply-To:
	 Content-Type:References; b=YWZArOsTavPCPSeuinswJw906aVRxMvC9k7GvljU8MRJcmT6LmPh0J8cu/3GQJ6zH9ZY9t2rgDZRFVy9P66C0KPoDZSM15stTFfxyJwAMFu8F3C4Y9jXrLtUNR/q4+uePFv1DayMb6QeoTEqmkvNxSWizN0GX7aZATclaJg0I+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=sDeW1I4m; arc=none smtp.client-ip=203.254.224.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="sDeW1I4m"
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
	by mailout4.samsung.com (KnoxPortal) with ESMTP id 20240610093405epoutp04d19c96a394ff536bc447910bd66b110b~Xmtp43XQ50549405494epoutp04T
	for <linux-block@vger.kernel.org>; Mon, 10 Jun 2024 09:34:05 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20240610093405epoutp04d19c96a394ff536bc447910bd66b110b~Xmtp43XQ50549405494epoutp04T
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1718012046;
	bh=gxSTM8Vp/TWDnEu3ZJVO9fJAWTd/d8FpObJwz9LrK/A=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=sDeW1I4myicgeG4ch3PEpko2MHH0LfCJc37JBSJRfEOImNjqy78YdBhEXDoubjnvF
	 Th/uofG/n12lqT1dCMeO0BQ+D0rX78ftfAFSm81QvShhHtDD3EWU8dUdXPCfXsjcGD
	 jmLqsLmSQpf17XwAN2JmX/xrpsnlCNpTzqTnpxXU=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTP id
	20240610093405epcas5p1dda89fb51ab8a415a6f5465370aaac10~XmtpZUzF30531505315epcas5p1s;
	Mon, 10 Jun 2024 09:34:05 +0000 (GMT)
Received: from epsmgec5p1-new.samsung.com (unknown [182.195.38.175]) by
	epsnrtp1.localdomain (Postfix) with ESMTP id 4VyRT7522gz4x9Ps; Mon, 10 Jun
	2024 09:34:03 +0000 (GMT)
Received: from epcas5p3.samsung.com ( [182.195.41.41]) by
	epsmgec5p1-new.samsung.com (Symantec Messaging Gateway) with SMTP id
	26.DE.19174.B88C6666; Mon, 10 Jun 2024 18:34:03 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
	20240610093316epcas5p1bd7efbe61385edfe6ea26f0a1b0584e2~Xms8G1-6Y1853418534epcas5p11;
	Mon, 10 Jun 2024 09:33:16 +0000 (GMT)
Received: from epsmgmcp1.samsung.com (unknown [182.195.42.82]) by
	epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20240610093316epsmtrp18001a17db058bc700885d3c72f0e3da3~Xms8GIOaT1547215472epsmtrp1C;
	Mon, 10 Jun 2024 09:33:16 +0000 (GMT)
X-AuditID: b6c32a50-b33ff70000004ae6-3e-6666c88b5c74
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
	epsmgmcp1.samsung.com (Symantec Messaging Gateway) with SMTP id
	F4.6D.18846.C58C6666; Mon, 10 Jun 2024 18:33:16 +0900 (KST)
Received: from green245 (unknown [107.99.41.245]) by epsmtip1.samsung.com
	(KnoxPortal) with ESMTPA id
	20240610093315epsmtip14d3de53c952f24fc23cdccb251f58d3c~Xms6gUmiw2473724737epsmtip1O;
	Mon, 10 Jun 2024 09:33:14 +0000 (GMT)
Date: Mon, 10 Jun 2024 14:56:06 +0530
From: Kundan Kumar <kundan.kumar@samsung.com>
To: Christoph Hellwig <hch@lst.de>
Cc: axboe@kernel.dk, willy@infradead.org, kbusch@kernel.org,
	linux-block@vger.kernel.org, joshi.k@samsung.com, mcgrof@kernel.org,
	anuj20.g@samsung.com, nj.shetty@samsung.com, c.gameti@samsung.com,
	gost.dev@samsung.com
Subject: Re: [PATCH v4 1/2] block: add folio awareness instead of looping
 through pages
Message-ID: <20240610092606.ygto3ewsisr2j55v@green245>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240606045638.GF8395@lst.de>
User-Agent: NeoMutt/20171215
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrPJsWRmVeSWpSXmKPExsWy7bCmpm73ibQ0g03fFC2aJvxltlh9t5/N
	4vv2PhaLmwd2MlmsXH2UyeLo/7dsFpMOXWO02HtL2+LGhKeMFtt+z2e2+P1jDpsDt8fmFVoe
	l8+Wemxa1cnmsftmA5tH35ZVjB6fN8kFsEVl22SkJqakFimk5iXnp2TmpdsqeQfHO8ebmhkY
	6hpaWpgrKeQl5qbaKrn4BOi6ZeYAHaekUJaYUwoUCkgsLlbSt7Mpyi8tSVXIyC8usVVKLUjJ
	KTAp0CtOzC0uzUvXy0stsTI0MDAyBSpMyM6YvOcJa8Em7opVX74wNTBu5Oxi5OSQEDCR6Ps3
	n6mLkYtDSGAPo8SeU+/YIJxPjBKrHk5jhXPub3/FDtPyd3szO0RiJ6PEom3PmEESQgLPGCX6
	r0qC2CwCqhKzd74HGsXBwSagK/GjKRQkLCKgJPH01VlGkF5mgfuMEt/u94D1CgtESlyc3MIE
	YvMKmEmse3SHHcIWlDg58wkLiM0poC2xfu1pMFtUQEZixtKvzBAHzeSQONiZCmG7SDya2sQE
	YQtLvDq+BepoKYmX/W1QdrbEocYNUDUlEjuPNEDF7SVaT/Uzg9zMLJAhcapHHCIsKzH11Dqw
	cmYBPone30+gWnkldsyDsdUk5rybygJhy0gsvDSDCWSMhICHRM8FTkhQAUNn4dYG9gmM8rOQ
	fDYLYdsssA1WEp0fmlghwtISy/9xQJiaEut36S9gZF3FKJVaUJybnppsWmCom5daDo/u5Pzc
	TYzglKsVsINx9Ya/eocYmTgYDzFKcDArifAKZSSnCfGmJFZWpRblxxeV5qQWH2I0BcbURGYp
	0eR8YNLPK4k3NLE0MDEzMzOxNDYzVBLnfd06N0VIID2xJDU7NbUgtQimj4mDU6qBqXHPndNM
	C66LtHW2Hvlx7fGCxOs19mL97IwLfpeKuBQfFGH3yPzM7LLljnKVHVdmiFZj75U1tyQEVM7Y
	vYkVtmqscXT/1F5jpjDz3mIXkWtVFW8z1e7NsN4m0M7ze0uMdFujqHaV2xXF+MlvnbilvQ/9
	tvzF8qjhgucc0dPmhRO3nPM/uOFIiZrV1OxAzXCV7XuWSvII3NdZ83vhoV0Xdi59/eT2j6Ol
	1jPjbqjHrrxz4/zN9L/Tl/nZrMgyfW6wVemFWyqDTeZ39qsLW5cdn3bHn8f4/AHNmcwrcwIi
	fi5xWFerOsltX+hhifDTreHThNcZbMzKfFR7qEBK6p7rMsfk1uzPLk8bYucF8/lLKbEUZyQa
	ajEXFScCAOuQSqZCBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrALMWRmVeSWpSXmKPExsWy7bCSnG7MibQ0g4WrdCyaJvxltlh9t5/N
	4vv2PhaLmwd2MlmsXH2UyeLo/7dsFpMOXWO02HtL2+LGhKeMFtt+z2e2+P1jDpsDt8fmFVoe
	l8+Wemxa1cnmsftmA5tH35ZVjB6fN8kFsEVx2aSk5mSWpRbp2yVwZZy8d4Op4AlHxb5jl9gb
	GP+ydTFyckgImEj83d7M3sXIxSEksJ1R4v/TbnaIhIzE7rs7WSFsYYmV/55DFT1hlFi8YB0L
	SIJFQFVi9s73QJM4ONgEdCV+NIWChEUElCSevjrLCFLPLHCfUeLb/R5mkISwQKTExcktTCA2
	r4CZxLpHd6CGPmOUuPZmMitEQlDi5MwnYAuYgYrmbX7IDLKAWUBaYvk/DpAwp4C2xPq1p8FK
	RIEOnbH0K/MERsFZSLpnIemehdC9gJF5FaNoakFxbnpucoGhXnFibnFpXrpecn7uJkZwpGgF
	7WBctv6v3iFGJg7GQ4wSHMxKIrxCGclpQrwpiZVVqUX58UWlOanFhxilOViUxHmVczpThATS
	E0tSs1NTC1KLYLJMHJxSDUyKb226S7Yd2zyD1X7jy6CMl9OlNA7GHytgWbA89UTB0XW+yyQW
	5X/wvDsnarvckhqNJbqqiZHWMUXcdiVtcp6sV7fKxZtXHNPxDjnZEVixqHwr8+Jv6673/cmZ
	8/vpiik23i0uvBe6J53g7JnZyiLjzGmspRvxwF7sVnbs2eyqy9KHjh3gP/p4+f4zdztt3vCI
	h1xw6vv4lsfuYEzUsy81XhZ5DyJjDlxhL5l1dUXtrCPPNp86HcHmH/s1e23M+YIt26aEvOjf
	du7T1mm2jb257epJW+6kBCqKnxJa/ixy34NrWUxuFi8t/7t8vXkqb07HjKm6pZL/Ymou/re+
	N1lg4orEPMdKDpdygfq7ogJKLMUZiYZazEXFiQDEO6nVAwMAAA==
X-CMS-MailID: 20240610093316epcas5p1bd7efbe61385edfe6ea26f0a1b0584e2
X-Msg-Generator: CA
Content-Type: multipart/mixed;
	boundary="----LZGu4PYXs2BAW_XTHz_lwyKyr.30uhOcduHjiEfMHTkCTgtA=_46194_"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240605093225epcas5p335664b9185c99a8fe1d661227d3f4f1a
References: <20240605092455.20435-1-kundan.kumar@samsung.com>
	<CGME20240605093225epcas5p335664b9185c99a8fe1d661227d3f4f1a@epcas5p3.samsung.com>
	<20240605092455.20435-2-kundan.kumar@samsung.com>
	<20240606045638.GF8395@lst.de>

------LZGu4PYXs2BAW_XTHz_lwyKyr.30uhOcduHjiEfMHTkCTgtA=_46194_
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Disposition: inline

On 06/06/24 06:56AM, Christoph Hellwig wrote:
>> @@ -1301,15 +1301,49 @@ static int __bio_iov_iter_get_pages(struct bio *bio, struct iov_iter *iter)
>>
>>  	for (left = size, i = 0; left > 0; left -= len, i++) {
>>  		struct page *page = pages[i];
>> +		struct folio *folio = page_folio(page);
>> +
>> +		/* Calculate the offset of page in folio */
>> +		folio_offset = (folio_page_idx(folio, page) << PAGE_SHIFT) +
>> +				offset;
>> +
>> +		len = min_t(size_t, (folio_size(folio) - folio_offset), left);
>> +
>> +		num_pages = DIV_ROUND_UP(offset + len, PAGE_SIZE);
>> +
>> +		if (num_pages > 1) {
>
>I still hate having this logic in the block layer.  Even if it is just
>a dumb wrapper with the same logic as here I'd much prefer to have
>a iov_iter_extract_folios, which can then shift down into a
>pin_user_folios_fast and into the MM slowly rather than adding this
>logic to the caller.
>
iov_iter_extract_folios will require allocation of a folio_vec array
which then will be filled after processing the pages[] array. This will
introduce extra allocation cost in the hot path.
--
Kundan

------LZGu4PYXs2BAW_XTHz_lwyKyr.30uhOcduHjiEfMHTkCTgtA=_46194_
Content-Type: text/plain; charset="utf-8"


------LZGu4PYXs2BAW_XTHz_lwyKyr.30uhOcduHjiEfMHTkCTgtA=_46194_--
