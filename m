Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70C9D14A4C3
	for <linux-block@vger.kernel.org>; Tue, 10 Sep 2024 08:41:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725957675; cv=none; b=CglQaAUPblVGqbATdQ232VxRAl3JMIuDRrRr6p/Smtz7LZnLRF1HJOrCSrT4L577h4HimU1O2v97jj+iWCr5VqlwkKkzi++3rJ1paOyjzGkXxFyV3TmjIpHA1rRU7tZxnqCoV3co3Xd+v6WOhJRruZSTHLdrXrC4wwLnw00TJ3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725957675; c=relaxed/simple;
	bh=z3cG0xErePZGYmqWeXcJYPxNgdaoxs49n0kDu3qPbxk=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:In-Reply-To:
	 Content-Type:References; b=V/OyYyTIF/4g5AJCxCvS/zQ+GEaFb7yqprEzfOTT4Ao2DTUK2wm88txt9CmDCzJLU0dySvzU3FPmoq7IqycH23rL0PmuUMtTp+5cAIOVXZbMoY/WR33veYD6bxbf7Wx+f9id5FuN8t7/94D78rqF39h2n+dc4APoJJxY+AWHLao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=dONkzVP9; arc=none smtp.client-ip=203.254.224.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="dONkzVP9"
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
	by mailout3.samsung.com (KnoxPortal) with ESMTP id 20240910084111epoutp037b7626985009070f9a5a1fd90e6b6da0~z1VuHT42K2945529455epoutp03U
	for <linux-block@vger.kernel.org>; Tue, 10 Sep 2024 08:41:11 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20240910084111epoutp037b7626985009070f9a5a1fd90e6b6da0~z1VuHT42K2945529455epoutp03U
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1725957671;
	bh=feNn+eMNlrPC5iyK0Nz2kYtDWaCMSru6YnuEruPQgk4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=dONkzVP9Q116iBO+3Ejn5xkgx/EjOC9QlxukXxdcAK9myviX84ygtKLj2flg1B1lL
	 gmKzzP/Onx4FuzoT6uoUJXSaIrrTa59smKjVKqERBkB1HswMxy7Vi0xAnmBoBYzmNx
	 vSfkLbVj2pGgpP8qpzj55GdaKg5DMU857ycEW9pU=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTP id
	20240910084110epcas5p1b5df0343a843f10469edfe60ca09a680~z1VtnhlhC0285202852epcas5p1d;
	Tue, 10 Sep 2024 08:41:10 +0000 (GMT)
Received: from epsmges5p1new.samsung.com (unknown [182.195.38.181]) by
	epsnrtp2.localdomain (Postfix) with ESMTP id 4X2xxc1DRLz4x9Q9; Tue, 10 Sep
	2024 08:41:08 +0000 (GMT)
Received: from epcas5p4.samsung.com ( [182.195.41.42]) by
	epsmges5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	99.C7.09640.32600E66; Tue, 10 Sep 2024 17:41:07 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
	20240910062319epcas5p33d2ca85e6edea0d6ecc35f263d586af6~zzdWJ1j9r2730727307epcas5p3r;
	Tue, 10 Sep 2024 06:23:19 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
	epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20240910062319epsmtrp161f501622bff869fd8eca63296f08e0c~zzdWJAhPV2493724937epsmtrp1J;
	Tue, 10 Sep 2024 06:23:19 +0000 (GMT)
X-AuditID: b6c32a49-aabb8700000025a8-f0-66e00623dfc2
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
	epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
	A4.BA.08456.7D5EFD66; Tue, 10 Sep 2024 15:23:19 +0900 (KST)
Received: from green245 (unknown [107.99.41.245]) by epsmtip1.samsung.com
	(KnoxPortal) with ESMTPA id
	20240910062316epsmtip17ba93333e582fb2ff723bc40074612e3~zzdT7TqD62059820598epsmtip1c;
	Tue, 10 Sep 2024 06:23:16 +0000 (GMT)
Date: Tue, 10 Sep 2024 11:45:50 +0530
From: Kundan Kumar <kundan.kumar@samsung.com>
To: Matthew Wilcox <willy@infradead.org>
Cc: axboe@kernel.dk, hch@lst.de, kbusch@kernel.org,
	linux-block@vger.kernel.org, joshi.k@samsung.com, mcgrof@kernel.org,
	anuj20.g@samsung.com, nj.shetty@samsung.com, c.gameti@samsung.com,
	vishak.g@samsung.com, gost.dev@samsung.com
Subject: Re: [PATCH v9 2/4] block: introduce folio awareness and add a
 bigger size from folio
Message-ID: <20240910061550.izpjmlmzoadtstqv@green245>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <Zt9l8fnnx5_vgEop@casper.infradead.org>
User-Agent: NeoMutt/20171215
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrCJsWRmVeSWpSXmKPExsWy7bCmlq4K24M0g61mFk0T/jJbrL7bz2bx
	fXsfi8XNAzuZLFauPspkcfT/WzaLSYeuMVrsvaVtcWPCU0aLbb/nM1ucnzWH3eL3jzlsDjwe
	m1doeVw+W+qxaVUnm8fumw1sHn1bVjF6fN4kF8AWlW2TkZqYklqkkJqXnJ+SmZduq+QdHO8c
	b2pmYKhraGlhrqSQl5ibaqvk4hOg65aZA3SgkkJZYk4pUCggsbhYSd/Opii/tCRVISO/uMRW
	KbUgJafApECvODG3uDQvXS8vtcTK0MDAyBSoMCE749yLb8wFnzkrJn1dxNzAuIKji5GTQ0LA
	ROLo9zNsXYxcHEICuxklln5ZzwjhfGKU2HJkGTuE841RomP3TVaYlp6Fp6ESexklvv8+BtX/
	jFHi99P9TCBVLAKqEkf+/QRKcHCwCehK/GgKBTFFBDQk3mwxAilnFnjDKLHn7mSwcmGBeIkT
	p9vYQGxeATOJ278mMkPYghInZz5hAbE5gRZf3jeBEcQWFZCRmLH0KzPEQUs5JB7dD4WwXST+
	XT8EFReWeHV8CzuELSXxsr8Nys6WONS4gQnCLpHYeaQBKm4v0XqqH6yXWSBDYuGNqVA1shJT
	T61jgojzSfT+fgIV55XYMQ/GVpOY824qC4QtI7Hw0gwmkH8lBDwkLj+EhtVHRokD8y4yTmCU
	n4XktVlI1kHYVhKdH5pYZwG1MwtISyz/xwFhakqs36W/gJF1FaNkakFxbnpqsWmBYV5qOTy+
	k/NzNzGCk6+W5w7Guw8+6B1iZOJgPMQowcGsJMLbb3cvTYg3JbGyKrUoP76oNCe1+BCjKTCm
	JjJLiSbnA9N/Xkm8oYmlgYmZmZmJpbGZoZI47+vWuSlCAumJJanZqakFqUUwfUwcnFINTLwr
	GCc1ZMyTz1BaaM3+P/nGiZlxU5bPiwvK6YtzvvVIfZ2Pn6TV/L7lx2s2cW6J9lU4X/n0CleF
	0DLeSIO7XNPbNW/3bO33nB3cpHhu+UO5W1yZyfz3C5xTZ27+m2iqcURc3WJS2l4j4WkMZw6d
	r3bM7ChSEosNdsnfkLSXeTvjlQcnmYs59uoVbpN6IPX0fBmTZcaRkvgVxW5XNtfe6Vhb9EH9
	PG/b51KdTZVbdcLFTJm2n5Kq2ryiu1XmFk+fo+WTajYrrdT9szpn8S0qFzqhpmHjWx5dvFf6
	zOMpdzpe3AvaVBPMejxS7c+NZaW6wmc4Gd+ppJ/o97R6dGililOl1j2HFYctjp86p5erxFKc
	kWioxVxUnAgA8XCUbUcEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrOLMWRmVeSWpSXmKPExsWy7bCSnO71p/fTDE5fY7domvCX2WL13X42
	i+/b+1gsbh7YyWSxcvVRJouj/9+yWUw6dI3RYu8tbYsbE54yWmz7PZ/Z4vysOewWv3/MYXPg
	8di8Qsvj8tlSj02rOtk8dt9sYPPo27KK0ePzJrkAtigum5TUnMyy1CJ9uwSujCNT9rAULGWv
	mNJ7j62B8QtrFyMnh4SAiUTPwtPsXYxcHEICuxklHkxYzgaRkJHYfXcnVJGwxMp/z6GKnjBK
	LJ30kQUkwSKgKnHk30+gBg4ONgFdiR9NoSCmiICGxJstRiDlzAJvGCX23J3MBBIXFoiX+HDE
	CqSTV8BM4vavicwQIz8ySlz6tIkNIiEocXLmE7DxzEBF8zY/ZAbpZRaQllj+jwMkzAl08+V9
	ExhBbFGgM2cs/co8gVFwFpLuWUi6ZyF0L2BkXsUomVpQnJueW2xYYJSXWq5XnJhbXJqXrpec
	n7uJERw3Wlo7GPes+qB3iJGJg/EQowQHs5IIb7/dvTQh3pTEyqrUovz4otKc1OJDjNIcLEri
	vN9e96YICaQnlqRmp6YWpBbBZJk4OKUamHSO3670aXl9f9v3Sif5RSnq2rbbPR++LqpznMK+
	30tV/8Hzb97bQ8/6HGd0f3WhlL38+sZd1pqL4vfv+nigWePWVDadfv94Z40Zc+9Iswn7Zq2+
	e+uu8ubimCzr3lvl6prafTbf1SzqjAN2zBO7UfdrA+/cnnubXx8yfTBBJi20U/7T7i5/rT9H
	J5Sd01x6br/k1VaHvteVJRXbJ6+K6tqwv/SSZmmY99lvLCW7Hr3ZVXks/HeinMGUKQwMymst
	vrCEnZ+dp5jFP+XGzyXbtszvaNz7dYpu6IP/flctghhtVxYvzX1i87h0odPs52nKEh8t7W7v
	F/hStrhaZ6t1/m7rAw9Py5tlOXz7tDDL5rMSS3FGoqEWc1FxIgCr/+0CCgMAAA==
X-CMS-MailID: 20240910062319epcas5p33d2ca85e6edea0d6ecc35f263d586af6
X-Msg-Generator: CA
Content-Type: multipart/mixed;
	boundary="----uTHwLNezELslVNO.c95wRQiJSVG1Eph5fYD-ITymD0JvNwx.=_13bba_"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240830080052epcas5p459f462c6a2cd2b68c1c28dcfe1ec3ac2
References: <20240830075257.186834-1-kundan.kumar@samsung.com>
	<CGME20240830080052epcas5p459f462c6a2cd2b68c1c28dcfe1ec3ac2@epcas5p4.samsung.com>
	<20240830075257.186834-3-kundan.kumar@samsung.com>
	<Zt9l8fnnx5_vgEop@casper.infradead.org>

------uTHwLNezELslVNO.c95wRQiJSVG1Eph5fYD-ITymD0JvNwx.=_13bba_
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Disposition: inline

On 09/09/24 10:17PM, Matthew Wilcox wrote:
>On Fri, Aug 30, 2024 at 01:22:55PM +0530, Kundan Kumar wrote:
>> +++ b/block/bio.c
>> @@ -931,7 +931,8 @@ static bool bvec_try_merge_page(struct bio_vec *bv, struct page *page,
>>  	if (!zone_device_pages_have_same_pgmap(bv->bv_page, page))
>>  		return false;
>>
>> -	*same_page = ((vec_end_addr & PAGE_MASK) == page_addr);
>> +	*same_page = ((vec_end_addr & PAGE_MASK) == ((page_addr + off) &
>> +		     PAGE_MASK));
>>  	if (!*same_page) {
>>  		if (IS_ENABLED(CONFIG_KMSAN))
>>  			return false;
>
>This seems like a completely independent change, which has presumably
>only now been noticed as a problem, but really should be in a separate
>commit and marked for backporting?

Currently, the offset lies between 0 to PAGE_SIZE. Only after the
changes introduced in this series, folio_offset is used which can be
greater than PAGE_SIZE. So need not be backported.

------uTHwLNezELslVNO.c95wRQiJSVG1Eph5fYD-ITymD0JvNwx.=_13bba_
Content-Type: text/plain; charset="utf-8"


------uTHwLNezELslVNO.c95wRQiJSVG1Eph5fYD-ITymD0JvNwx.=_13bba_--
