Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73C1884FD4
	for <linux-block@vger.kernel.org>; Fri, 24 May 2024 10:19:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716545988; cv=none; b=BHoGX4qN39PPNTbsPkX5M7a7xjaYtLKUNvI5p4Jpzah5DLKT7FtjNXQhvku/gbTAMYr/IPr6f0atC1QHRl5Sxxbh5DOCYja7oFRtUk17vhDe8BzCa5fdWMGbgr96mg/IpDu4cJYOfDZpRlIzTjfEsymbFDXymHL+XH1+DxX6HFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716545988; c=relaxed/simple;
	bh=HYIbLlewHBqch2Rhc4Pgg/2Hp+zX6YGY1L5FKlVXcM8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:In-Reply-To:
	 Content-Type:References; b=uo1bcig7NJX7++Q7PvmfZ6jMq/BWBuYSeVKSZxQMdJ71JBO4XhUzQdRtcYT91V8pGHjctTAX0LyIVV9gEA5KTzbqVLAZKV3V+m0S3ODgcVfzH22NMwiza9xEe4GuFwwIBoV67/Ud4GXH3mwzHoaqY5y0/XhcI4MkJ+1MoUEZJVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=hsUbKew2; arc=none smtp.client-ip=203.254.224.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="hsUbKew2"
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
	by mailout2.samsung.com (KnoxPortal) with ESMTP id 20240524101936epoutp026859e2056971f787a5ee5812576b4a7b~SZXihGZCy0742707427epoutp02T
	for <linux-block@vger.kernel.org>; Fri, 24 May 2024 10:19:36 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20240524101936epoutp026859e2056971f787a5ee5812576b4a7b~SZXihGZCy0742707427epoutp02T
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1716545976;
	bh=ZhR12I05zkWrFi8rGaGtHcwrErsg208ZqJpD9O0alVY=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=hsUbKew2w84gE/CpGrPcbaw7+ujyST4ccsAknGF3rgGME9U5oxIV3jUII1tQ3Zse/
	 xWu7e9JoNWdzrUrda0LaXCQFAzxLyTuto8e8WvvwG/ARcAEXyi3ShOnjm2bw7x6Iw5
	 E7CUMCAb97XLjCLeUdmNOcWm5NQ+YQus+id8Xkc0=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTP id
	20240524101936epcas5p2576c3b790ca8d91a13de03098b66f3b5~SZXh7yrLj1735817358epcas5p27;
	Fri, 24 May 2024 10:19:36 +0000 (GMT)
Received: from epsmgec5p1-new.samsung.com (unknown [182.195.38.176]) by
	epsnrtp4.localdomain (Postfix) with ESMTP id 4Vm1HV1tB9z4x9Pv; Fri, 24 May
	2024 10:19:34 +0000 (GMT)
Received: from epcas5p4.samsung.com ( [182.195.41.42]) by
	epsmgec5p1-new.samsung.com (Symantec Messaging Gateway) with SMTP id
	9D.AA.19431.6B960566; Fri, 24 May 2024 19:19:34 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
	20240524101933epcas5p3809e5993650dc7c018956fb5965b9b38~SZXf303ne2575325753epcas5p3C;
	Fri, 24 May 2024 10:19:33 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
	epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20240524101933epsmtrp1c8fd001eac975d79f80e3101c6c90581~SZXf3NTeu3246832468epsmtrp1L;
	Fri, 24 May 2024 10:19:33 +0000 (GMT)
X-AuditID: b6c32a50-f57ff70000004be7-b4-665069b6721b
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
	epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
	04.92.08390.5B960566; Fri, 24 May 2024 19:19:33 +0900 (KST)
Received: from [107.122.11.51] (unknown [107.122.11.51]) by
	epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20240524101932epsmtip1caed712a390045c4c1e44881b33e3f20~SZXeuoMpk3147031470epsmtip1A;
	Fri, 24 May 2024 10:19:32 +0000 (GMT)
Message-ID: <d07ac170-b364-8c15-0edd-94132f47d9fd@samsung.com>
Date: Fri, 24 May 2024 15:49:31 +0530
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0)
	Gecko/20100101 Thunderbird/91.13.1
Subject: Re: [PATCH v2] block: unmap and free user mapped integrity via
 submitter
Content-Language: en-US
To: Christoph Hellwig <hch@lst.de>, Anuj Gupta <anuj20.g@samsung.com>
Cc: axboe@kernel.dk, kbusch@kernel.org, linux-nvme@lists.infradead.org,
	linux-block@vger.kernel.org, martin.petersen@oracle.com
From: Kanchan Joshi <joshi.k@samsung.com>
In-Reply-To: <20240520154943.GA1327@lst.de>
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrCJsWRmVeSWpSXmKPExsWy7bCmlu62zIA0gzU72C2aJvxltlh9t5/N
	YuXqo0wWkw5dY7TYe0vbYv6yp+wWy4//Y3Jg97h8ttRj06pONo/NS+o9dt9sYPP4+PQWi0ff
	llWMHp83yQWwR2XbZKQmpqQWKaTmJeenZOal2yp5B8c7x5uaGRjqGlpamCsp5CXmptoqufgE
	6Lpl5gBdo6RQlphTChQKSCwuVtK3synKLy1JVcjILy6xVUotSMkpMCnQK07MLS7NS9fLSy2x
	MjQwMDIFKkzIzji66AVrwVvOisYjR5kaGH+zdzFyckgImEh0f94OZHNxCAnsYZSY96yRBcL5
	xCgx5fI8qMw3RomHc6eywLT8WLuHESKxl1Hi8LUvbBDOW0aJ51/3sYFU8QrYSVxcvwesg0VA
	VeJw0zOouKDEyZlPwOKiAskSP7sOgMWFBYIluucfYwSxmQXEJW49mc8EYosIuEqcenCRGWQB
	s0Ajo8T+c4uAHA4ONgFNiQuTS0FqOAW0JU5/+sgK0Ssvsf3tHLB6CYGpHBIz175kgzjbRWLp
	jaNQLwhLvDq+BRoCUhIv+9ug7GSJSzPPMUHYJRKP9xyEsu0lWk/1g+1lBtq7fpc+xC4+id7f
	T5hAwhICvBIdbUIQ1YoS9yY9ZYWwxSUezlgCZXtIbDzxkhUSVqsZJY4u6mCfwKgwCylYZiF5
	fxaSd2YhbF7AyLKKUSq1oDg3PTXZtMBQNy+1HB7lyfm5mxjByVUrYAfj6g1/9Q4xMnEwHmKU
	4GBWEuGNXumbJsSbklhZlVqUH19UmpNafIjRFBhBE5mlRJPzgek9ryTe0MTSwMTMzMzE0tjM
	UEmc93Xr3BQhgfTEktTs1NSC1CKYPiYOTqkGpkB+Wb56p80hu/vPzur2PX752qrbLr2zlHlm
	nFVcu1j5818FY36XiGOfz7vlBKp/+7M5wlcs6IDPvUm/Mw2vHzxzL6dqu+dzN++IntbU/pXL
	EtKP5d7snsPR/6zn9STJeTpbtzJbcm0t/6W04PScxYafmmMNT6g37QrU2/aI8QW3QZVc0rFl
	fmldieKHQ6NXVN/waaiO+v3Q2WeB39EAnZ2aTHHOMVwzIgIutKyaevn5xSxthstc7tzNadnH
	jc6I80zjqJgn82OlYHBmUHxR/ZrnpyaUqDoqSRyq3aHd38+13bWJf0bt21035u01ORfyydIx
	y4Vvz6+1ep0bGi9ETFWeMzfo2etSNf5SoeOflFiKMxINtZiLihMBXBniODcEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrHLMWRmVeSWpSXmKPExsWy7bCSnO7WzIA0g/mTDSyaJvxltlh9t5/N
	YuXqo0wWkw5dY7TYe0vbYv6yp+wWy4//Y3Jg97h8ttRj06pONo/NS+o9dt9sYPP4+PQWi0ff
	llWMHp83yQWwR3HZpKTmZJalFunbJXBlHF30grXgLWdF45GjTA2Mv9m7GDk5JARMJH6s3cPY
	xcjFISSwm1Fifd9NRoiEuETztR9QRcISK/89Z4coes0o0fN0IhNIglfATuLi+j0sIDaLgKrE
	4aZnbBBxQYmTM5+AxUUFkiVe/pkINkhYIFiie/4xsAXMQAtuPZkPNkdEwFXi1IOLzBDxRkaJ
	vpWmEMtWM0rMaF3M2sXIwcEmoClxYXIpSA2ngLbE6U8fWSHqzSS6tnZBzZSX2P52DvMERqFZ
	SM6YhWTdLCQts5C0LGBkWcUomVpQnJueW2xYYJSXWq5XnJhbXJqXrpecn7uJERxFWlo7GPes
	+qB3iJGJg/EQowQHs5IIb/RK3zQh3pTEyqrUovz4otKc1OJDjNIcLErivN9e96YICaQnlqRm
	p6YWpBbBZJk4OKUamNbeiV6lZKj92TDv+YyXy3qUE7j/Sxak78k22vKzfbOPbHrF0YMerZoO
	DMs1otRn7H3Fkn7r5Erm8kYxh/1d3My2337mdJm+kxDc06i+9uPbrnNnr3GsEuELlGyes8+A
	fe02MSEDxt96r7XqYt5f2DZX3GPish8nV2rVHPyhtXfbfz+hHbP/pqec2RR9f3aWHvPOe1dD
	jvwt2uKrX/v1uekVhtNH0g97lmXd2ftSbta3yhSH678XxGQ9vPkywbjg4KZ7Doo2s0rkl89M
	qvmxQH+fGcOy5oxHPF/Lzzn7qUjdVEu+fDNG66qcfbL87AfP6z33/PvxbU/Wdd8zW268u51f
	8GrTbxmOT8X348uK/qUqsRRnJBpqMRcVJwIAIShFYREDAAA=
X-CMS-MailID: 20240524101933epcas5p3809e5993650dc7c018956fb5965b9b38
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240513084939epcas5p4530be8e7fc62b8d4db694d6b5bca3a19
References: <CGME20240513084939epcas5p4530be8e7fc62b8d4db694d6b5bca3a19@epcas5p4.samsung.com>
	<20240513084222.8577-1-anuj20.g@samsung.com> <20240520154943.GA1327@lst.de>

On 5/20/2024 9:19 PM, Christoph Hellwig wrote:
>> diff --git a/block/bio-integrity.c b/block/bio-integrity.c
>> index 2e3e8e04961e..8b528e12136f 100644
>> --- a/block/bio-integrity.c
>> +++ b/block/bio-integrity.c
>> @@ -144,16 +144,38 @@ void bio_integrity_free(struct bio *bio)
>>   	struct bio_integrity_payload *bip = bio_integrity(bio);
>>   	struct bio_set *bs = bio->bi_pool;
>>   
>> +	if (bip->bip_flags & BIP_INTEGRITY_USER)
>> +		return;
>>   	if (bip->bip_flags & BIP_BLOCK_INTEGRITY)
>>   		kfree(bvec_virt(bip->bip_vec));
>> -	else if (bip->bip_flags & BIP_INTEGRITY_USER)
>> -		bio_integrity_unmap_user(bip);
>>   
>>   	__bio_integrity_free(bs, bip);
>>   	bio->bi_integrity = NULL;
>>   	bio->bi_opf &= ~REQ_INTEGRITY;
> 
> This looks correct.  I wish we could go one step further (maybe
> in a separate patch/series) to also move freeing the bio integrity
> data to the callers.  In fact I wonder if there is any point in
> doing this early separate free vs just doing it as part of the
> final bio put.

Tried to think in this direction in past.
But bio_put will not be called if bio is statically allocated. Currently 
that gets freed implicitly because bio_endio is called and it tries to 
free the integrity.
