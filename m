Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8075314A4C3
	for <linux-block@vger.kernel.org>; Tue, 10 Sep 2024 08:41:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725957663; cv=none; b=EDZl5r8AMm9wf0dN7OeEp+ADAzQOrlKvYtmWJF4D2I7cwxjt0wJvqkzcGWruv2AO3q7ikLxXL7q2C0AZiu5uJPkzWkc6hNkLCkhRInRM3LdRvh7AYMiye/+gah8flpqSB0Io0Q5DGhU+UAQZDbTV76gT9hY9bh7Q6lnSfRe4IlM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725957663; c=relaxed/simple;
	bh=gxl5BHVVWLpfgoxe/Oi8OdRmbk2FhZMEhCbgXtNbY/o=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:In-Reply-To:
	 Content-Type:References; b=MHgu4Uf5D47pZhawmCQ9QRVtgiy3co67TrpjcgUy9qX45UszdApPfRoqMPJyXy97oWZn8MSrgWoqzcnexO+71WdlXJFnc/bJGefdygvungiONgfGsNGry3zYPMCpvQR5dWC3UL7RnCSkkp14lqnmUTzcb6Wj3F4pHOd9FwnZwxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=jMl0WRnj; arc=none smtp.client-ip=203.254.224.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="jMl0WRnj"
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
	by mailout1.samsung.com (KnoxPortal) with ESMTP id 20240910084058epoutp012ec138c2deca49c055e93c7e392df8a1~z1ViIIJSZ1230512305epoutp01O
	for <linux-block@vger.kernel.org>; Tue, 10 Sep 2024 08:40:58 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20240910084058epoutp012ec138c2deca49c055e93c7e392df8a1~z1ViIIJSZ1230512305epoutp01O
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1725957658;
	bh=77+vYUZHqVps3Fhq+I0LMpz7+rVXiaNlBp+eYPcPu4o=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=jMl0WRnj6QaO1InzoWTcUqgik5K5w00KtKn64uE9K8HLZafWZj+QDZESLIHj3ZnQU
	 f0I3r4euYdEt5zp7pVWBItmJfQ0h3qvwCT+/DTGZaxz/L4KJSp1LJQcOMrWMcmw43C
	 E3O6A/ndvNKlqmB7NOTMwWV6+EfK46WTc6yIBhTI=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTP id
	20240910084057epcas5p4c0c16fef853d5f37965e89d9ba8fb438~z1VhSr1Tn3165131651epcas5p4n;
	Tue, 10 Sep 2024 08:40:57 +0000 (GMT)
Received: from epsmges5p2new.samsung.com (unknown [182.195.38.177]) by
	epsnrtp1.localdomain (Postfix) with ESMTP id 4X2xxM3LByz4x9QB; Tue, 10 Sep
	2024 08:40:55 +0000 (GMT)
Received: from epcas5p3.samsung.com ( [182.195.41.41]) by
	epsmges5p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
	C2.22.09743.71600E66; Tue, 10 Sep 2024 17:40:55 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
	20240910061911epcas5p22923fc3221b8e4ca83591ffe85a69f80~zzZvUcESD1767817678epcas5p2C;
	Tue, 10 Sep 2024 06:19:11 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
	epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20240910061911epsmtrp24a4adbebf5e6333ad98194f7ce974beb~zzZvTq0Kt1459414594epsmtrp21;
	Tue, 10 Sep 2024 06:19:11 +0000 (GMT)
X-AuditID: b6c32a4a-3b1fa7000000260f-1e-66e006173f47
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
	epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
	32.3A.08456.FD4EFD66; Tue, 10 Sep 2024 15:19:11 +0900 (KST)
Received: from green245 (unknown [107.99.41.245]) by epsmtip2.samsung.com
	(KnoxPortal) with ESMTPA id
	20240910061908epsmtip2e528848301549e081dcecd4e9af1c177~zzZs8mfk81580815808epsmtip21;
	Tue, 10 Sep 2024 06:19:08 +0000 (GMT)
Date: Tue, 10 Sep 2024 11:41:22 +0530
From: Kundan Kumar <kundan.kumar@samsung.com>
To: Matthew Wilcox <willy@infradead.org>
Cc: axboe@kernel.dk, hch@lst.de, kbusch@kernel.org,
	linux-block@vger.kernel.org, joshi.k@samsung.com, mcgrof@kernel.org,
	anuj20.g@samsung.com, nj.shetty@samsung.com, c.gameti@samsung.com,
	vishak.g@samsung.com, gost.dev@samsung.com
Subject: Re: [PATCH v9 2/4] block: introduce folio awareness and add a
 bigger size from folio
Message-ID: <20240910061122.u6w5a6xnf4cf3nb5@green245>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <Zt9nN3geJKjFfZAH@casper.infradead.org>
User-Agent: NeoMutt/20171215
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrGJsWRmVeSWpSXmKPExsWy7bCmpq4424M0g219whZNE/4yW6y+289m
	8X17H4vFzQM7mSxWrj7KZHH0/1s2i0mHrjFa7L2lbXFjwlNGi22/5zNbnJ81h93i9485bA48
	HptXaHlcPlvqsWlVJ5vH7psNbB59W1YxenzeJBfAFpVtk5GamJJapJCal5yfkpmXbqvkHRzv
	HG9qZmCoa2hpYa6kkJeYm2qr5OIToOuWmQN0oZJCWWJOKVAoILG4WEnfzqYov7QkVSEjv7jE
	Vim1ICWnwKRArzgxt7g0L10vL7XEytDAwMgUqDAhO+Pcsj2sBeu5K5ZOf8jSwLiWs4uRk0NC
	wETi9J+nTF2MXBxCArsZJW50d7NAOJ8YJV5t3cEK4XxjlJi3dT4zTMv0s0+hqvYySrTs2sgO
	4TxjlHgzczorSBWLgKrEwsMXgDo4ONgEdCV+NIWCmCICGhJvthiBlDMLvGGU2HN3MhNIubBA
	vMSJ021sIDavgJnEl88fmCBsQYmTM5+wgNicQIsvzdkKdoSogIzEjKVfmUEGSQgs5ZB4P3s6
	I8R1LhLn7i1kgrCFJV4d38IOYUtJfH63lw3CzpY41LgBqqZEYueRBqgae4nWU/1gC5gFMiRW
	710MVSMrMfXUOiaIOJ9E7+8nUHFeiR3zYGw1iTnvprJA2DISCy/NYAJ5WELAQ+LyQ2j4fGSU
	2Nt6i2UCo/wsJL/NQrIOwraS6PzQxDoLqJ1ZQFpi+T8OCFNTYv0u/QWMrKsYJVMLinPTU4tN
	C4zyUsvhEZ6cn7uJEZyAtbx2MD588EHvECMTB+MhRgkOZiUR3n67e2lCvCmJlVWpRfnxRaU5
	qcWHGE2BUTWRWUo0OR+YA/JK4g1NLA1MzMzMTCyNzQyVxHlft85NERJITyxJzU5NLUgtgulj
	4uCUamCqEFTMs/T8aWHIL/tjw9Q29oZLG7ltXzAFf97DL7x+TkPRskmiQVXXdk0RP3A7XqB9
	p83OCR5LrA4W8fxdrDIvpba0fo/QkZrvhsq3TkU98moIXm9SnpXH5nWgJC6vYEVJz2vV69Py
	cx7Pecq067zmOTaL/yGX1khK75PgWf3z7QOrtktqrXUZy2v+Rz42WzEjdbn6neUqT1KS/nVI
	e0mdaKg/8uPHbQv3LHPZ738bzqpP181yeDptp0r52dYnFU2f/e+9bXvk9vzwP/06ueyUzuSn
	1WtnNIe8f/X/s0HNPyZpm+vF3xJ6tKqlrDdcObKizP5ovXVsklzv8dvmlzoftO5g+35UQaJC
	N7b8W7kSS3FGoqEWc1FxIgD/OrAgSQQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrGLMWRmVeSWpSXmKPExsWy7bCSvO79J/fTDK4f47VomvCX2WL13X42
	i+/b+1gsbh7YyWSxcvVRJouj/9+yWUw6dI3RYu8tbYsbE54yWmz7PZ/Z4vysOewWv3/MYXPg
	8di8Qsvj8tlSj02rOtk8dt9sYPPo27KK0ePzJrkAtigum5TUnMyy1CJ9uwSujAm77zMWPOSo
	mN3wg7mB8SdbFyMnh4SAicT0s09Zuhi5OIQEdjNKrO+dwQyRkJHYfXcnK4QtLLHy33N2EFtI
	4AmjRGePCojNIqAqsfDwBaB6Dg42AV2JH02hIKaIgIbEmy1GICOZBd4wSuy5O5kJJC4sEC/x
	4YgVSCevgJnEl88fmCDWfmSUONn8kQ0iIShxcuYTFhCbGaho3uaHYOOZBaQllv/jAAlzAp18
	ac5WsCtFga6csfQr8wRGwVlIumch6Z6F0L2AkXkVo2RqQXFuem6xYYFRXmq5XnFibnFpXrpe
	cn7uJkZw1Ghp7WDcs+qD3iFGJg7GQ4wSHMxKIrz9dvfShHhTEiurUovy44tKc1KLDzFKc7Ao
	ifN+e92bIiSQnliSmp2aWpBaBJNl4uCUamDiOL3pbs0Xi+cN7FYfXh/TXsE474mM5Lyz/i/4
	tir3vdGRTH8uuy9V4EC5/bZ4wYnXAn5UPdxtv/LBmWp5v4cCl9ZNml16n+GijG2+9bqKPUc1
	WcS1L3vNVPr+LPOkjVvHJdMb+1gyPpw6fvKPj+2ly3td/d4tedu9N0LKw6Dz1PIzx7cU63p+
	mL/o7p25t6frLY5+2LJN+C2PvNnKNgn9mWXnjRhdr4r+yWSeFsLxzMMqN1PTRVujbkcJ85IL
	vxPcme7qJkTLXGIqmV3U973ylO6tS//PP5xpIDlxkdlltfMTtvTwNHy1eFkj+sYjQ/NGwK0T
	WzaslzsceML5xsEi+9rg0ubXN3QfLIn3e1+UqcRSnJFoqMVcVJwIAEovQdEJAwAA
X-CMS-MailID: 20240910061911epcas5p22923fc3221b8e4ca83591ffe85a69f80
X-Msg-Generator: CA
Content-Type: multipart/mixed;
	boundary="----lj09sVyn-tOB2AKWHI53LLLuzUygR0h9jjkNdS9akYNnxuib=_13b2a_"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240830080052epcas5p459f462c6a2cd2b68c1c28dcfe1ec3ac2
References: <20240830075257.186834-1-kundan.kumar@samsung.com>
	<CGME20240830080052epcas5p459f462c6a2cd2b68c1c28dcfe1ec3ac2@epcas5p4.samsung.com>
	<20240830075257.186834-3-kundan.kumar@samsung.com>
	<Zt9nN3geJKjFfZAH@casper.infradead.org>

------lj09sVyn-tOB2AKWHI53LLLuzUygR0h9jjkNdS9akYNnxuib=_13b2a_
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Disposition: inline

On 09/09/24 10:23PM, Matthew Wilcox wrote:
>On Fri, Aug 30, 2024 at 01:22:55PM +0530, Kundan Kumar wrote:
>> @@ -1237,30 +1238,61 @@ static int bio_iov_add_page(struct bio *bio, struct page *page,
>>
>>  	if (bio->bi_vcnt > 0 &&
>>  	    bvec_try_merge_page(&bio->bi_io_vec[bio->bi_vcnt - 1],
>> -				page, len, offset, &same_page)) {
>> +				folio_page(folio, 0), len, offset,
>> +				&same_page)) {
>>  		bio->bi_iter.bi_size += len;
>>  		if (same_page)
>> -			bio_release_page(bio, page);
>> +			bio_release_page(bio, folio_page(folio, 0));
>
>Shouldn't there be a subsequent patch that converts this to

Will do it in next version

>		if (same_page && bio_flagged(bio, BIO_PAGE_PINNED))
>			unpin_user_folio(folio, 1)
>
>... also does this mean that 'same_page' is misnamed and it should
>really be 'same_folio', in which case, is the bugfix in patch 1 correct?
>

No, we want to find same page rather than same folio. The logic still
determines whether two addresses lie in the same page. It's just
modified to take care of larger offset values that we may receive in
case of folios.


------lj09sVyn-tOB2AKWHI53LLLuzUygR0h9jjkNdS9akYNnxuib=_13b2a_
Content-Type: text/plain; charset="utf-8"


------lj09sVyn-tOB2AKWHI53LLLuzUygR0h9jjkNdS9akYNnxuib=_13b2a_--
