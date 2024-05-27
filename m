Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 827E656470
	for <linux-block@vger.kernel.org>; Mon, 27 May 2024 08:39:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716799152; cv=none; b=m2ywqC7/LJxy0cy89JveREp8U656d/pLzZI/bd4BbB2dt6X3xFaQ23f+fOH3HTuC8fen9yjCsMoF4Lnr00gDvMTqIDgcSZoNFgr1wepqaoQu54GdlSXdtTfyCsHUQfc6LA1Hbf10Bc+xze0E+vfnJpJds0UuxKYcF3jfqVnlXt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716799152; c=relaxed/simple;
	bh=y0zyZhvjZhGIy+JqgQVf1Y3tlTr2BPJicX5wSAVLuZo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:MIME-Version:
	 Content-Type:References; b=VW6EwoJM4DLv69OxaszIfA2FnfPdU0IMVfvxqOPLPg2eG2SP+tPLOdcKR7chk1SBVl1s2qICJZCXZHtE/mtEp5a8XyRj4YT+gUP0DfXhXo1TOmG4Pn8catwlNHt3em3fpZA3/5TCam2toHZUW2eVzKFZZVDd4oki++kyQPwsgKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=P+iP+TZU; arc=none smtp.client-ip=203.254.224.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="P+iP+TZU"
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
	by mailout2.samsung.com (KnoxPortal) with ESMTP id 20240527083908epoutp02c8653c0ccf74b3a3ff0337d136a6ecbb~TS7rDuDqA0583705837epoutp028
	for <linux-block@vger.kernel.org>; Mon, 27 May 2024 08:39:08 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20240527083908epoutp02c8653c0ccf74b3a3ff0337d136a6ecbb~TS7rDuDqA0583705837epoutp028
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1716799148;
	bh=cldK3v8hjaOZ5NFr9ZMfKJUSo4QaG/KA3A1fFtLoxOM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=P+iP+TZUlEeEoGpLO28P5sxksCOVkG2Y0v5TBvIyJxjd8Q7WUPjPmieFbIYalF9Tp
	 2zJFb7mR+5CX1hxHJGzmwAVsdUrbtbETfhSgam7dWRpWm4ELADLXFIB/gji/cvqeGT
	 URom9cd9piRS5uaPSNeXnm48jV7Qlv/0uf0BHOkw=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTP id
	20240527083908epcas5p36c0dad40ec0aa905dc1de0b993d104ca~TS7qqlSox2565525655epcas5p3W;
	Mon, 27 May 2024 08:39:08 +0000 (GMT)
Received: from epsmgec5p1new.samsung.com (unknown [182.195.38.178]) by
	epsnrtp1.localdomain (Postfix) with ESMTP id 4VnpwB2bdHz4x9Ps; Mon, 27 May
	2024 08:39:06 +0000 (GMT)
Received: from epcas5p3.samsung.com ( [182.195.41.41]) by
	epsmgec5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	91.D9.08853.AA644566; Mon, 27 May 2024 17:39:06 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
	20240527082328epcas5p205a74058d8163a1c724ad800ba18e056~TSt-Q5XRD0774507745epcas5p2Y;
	Mon, 27 May 2024 08:23:28 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
	epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20240527082328epsmtrp2b7be2d3d2b12c6011a7794ae65681849~TSt-QI1TP0696206962epsmtrp2x;
	Mon, 27 May 2024 08:23:28 +0000 (GMT)
X-AuditID: b6c32a44-d67ff70000002295-45-665446aacceb
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
	epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	18.07.08336.FF244566; Mon, 27 May 2024 17:23:27 +0900 (KST)
Received: from testpc11818.samsungds.net (unknown [109.105.118.18]) by
	epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20240527082326epsmtip1ccfad5257e1af129f208e85886eb318b~TSt_KSNJn1036110361epsmtip16;
	Mon, 27 May 2024 08:23:26 +0000 (GMT)
From: hexue <xue01.he@samsung.com>
To: joshi.k@samsung.com, axboe@kernel.dk
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	peiwei.li@samsung.com, ruyi.zhang@samsung.com, xue01.he@samsung.com
Subject: Re: Re: [PATCH] block: delete redundant function declarations
Date: Mon, 27 May 2024 16:23:22 +0800
Message-Id: <20240527082322.1476057-1-xue01.he@samsung.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <ff59fb89-c186-af41-0990-54de8ef91ef5@samsung.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFuphk+LIzCtJLcpLzFFi42LZdlhTU3eVW0iawcSfvBar7/azWRz9/5bN
	4lf3XUaLvbe0LS7vmsNm8Wwvp8WXw9/ZLc5O+MBq0XXhFJsDp8fls6UefVtWMXp83iQXwByV
	bZORmpiSWqSQmpecn5KZl26r5B0c7xxvamZgqGtoaWGupJCXmJtqq+TiE6DrlpkDdIOSQlli
	TilQKCCxuFhJ386mKL+0JFUhI7+4xFYptSAlp8CkQK84Mbe4NC9dLy+1xMrQwMDIFKgwITvj
	5cr5TAVvmCt6dl9ga2DsYe5i5OSQEDCR+P2rn7GLkYtDSGA3o8TdK8fZIJxPjBKHTt1iBKkS
	EvjGKLFmhi9Mx577G1ghivYySmx/dZMFwvnBKLGx+zzYXDYBJYn9Wz6AdYsIaEhsOH6ZFcRm
	FmhhlPjWmAFiCwu4SSxcu4gdxGYRUJV4vm4uC4jNK2AtcWtrExPENnmJm137wWZyCthLHJ3/
	mx2iRlDi5MwnLBAz5SWat85mBjlCQuARu8TUPy9ZIJpdJBp+NrND2MISr45vgbKlJD6/28sG
	YedLTP6+nhHCrpFYt/kdVK+1xL8re4BsDqAFmhLrd+lDhGUlpp5axwSxl0+i9/cTqDt5JXbM
	g7GVJJYcWQE1UkLi94RFrCBjJAQ8JL7OEYSE1SRGYLjvYpnAqDALyTuzkLwzC2HzAkbmVYyS
	qQXFuempyaYFhnmp5fBITs7P3cQITpZaLjsYb8z/p3eIkYmD8RCjBAezkgivyLzANCHelMTK
	qtSi/Pii0pzU4kOMpsDwnsgsJZqcD0zXeSXxhiaWBiZmZmYmlsZmhkrivK9b56YICaQnlqRm
	p6YWpBbB9DFxcEo1MAXNrl+Z+v34Qb+XpzjZSh/wdp0wZFiuM+XiWZOlhSvD1x78dumpuPBh
	FvUs2R3BS3bu8fHIkltiOvOf7UnViiP1HrYBH/bKyqVM23XIcr7F9t6+U2+2PnpjMIEzuWSl
	sPjuR8yKs30Wn6n+/9Jy3R0NVdcnzvofd78JN3z/+z6LaYHJgkV7eFIWh6ReStVMqr/k0Zl6
	UU6i06CFZ0naDYlFnB7LOPtv/vV8mvX0idPJvEX2jZesfv886tzv+nypkvHH5uItTN8zGp/t
	fpq5QravWWTK4ZjWK5sKF/48XbKeUU4uVeX+c9urX1vOV6lrNS8Ksrgvo/QrqGS945RJvbNz
	dC+Ec71pUa9mOzuxfYsSS3FGoqEWc1FxIgB+D+mGHwQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrKLMWRmVeSWpSXmKPExsWy7bCSnO5/p5A0gwmPLS1W3+1nszj6/y2b
	xa/uu4wWe29pW1zeNYfN4tleTosvh7+zW5yd8IHVouvCKTYHTo/LZ0s9+rasYvT4vEkugDmK
	yyYlNSezLLVI3y6BK+PlyvlMBW+YK3p2X2BrYOxh7mLk5JAQMJHYc38DaxcjF4eQwG5Gib8/
	FrFDJCQkdjz6wwphC0us/PecHaLoG6PEvvYbYN1sAkoS+7d8YASxRQS0JPpanrKBFDELdDFK
	vJmwlQ0kISzgJrFwLcRUFgFViefr5rKA2LwC1hK3tjYxQWyQl7jZtR9sKKeAvcTR+b/B6oUE
	7CRmHXzFClEvKHFy5hOwXmag+uats5knMArMQpKahSS1gJFpFaNkakFxbnpusWGBYV5quV5x
	Ym5xaV66XnJ+7iZGcEhrae5g3L7qg94hRiYOxkOMEhzMSiK8IvMC04R4UxIrq1KL8uOLSnNS
	iw8xSnOwKInzir/oTRESSE8sSc1OTS1ILYLJMnFwSjUwrXf5mxy8dNmtaZyPP0xQfFNZZ3FN
	N+g2y8yGZwsF+OUmtXNuWsxizB6uKncp42v2t0mMUzasjKvLlN5z5lmM3xPFIF3n21s/vPr5
	5E1D0e2FUd/Z58n37HVflr7I04TR/OGa7rhHc8J9fW+6sOx4VGdefiS/UNLg0+bJq843CwSf
	/y97/IDvZ/bJukfYcjb4p5l531y10jYyWemk1gP2ty6mxc45U778TGkI1i5wq3XJ56+dsl4o
	RC9DdcrpqVo8jjFTcoVsbUKFclhmfKpVKwtpWpTkFCIwkzfA5sebmRFKLwS32GvuZFFVbi+Q
	WOaomPemYbLYx3zBllannXPuTA2JLrFXLJJNfHCBZb8SS3FGoqEWc1FxIgCHNkEU2AIAAA==
X-CMS-MailID: 20240527082328epcas5p205a74058d8163a1c724ad800ba18e056
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240527082328epcas5p205a74058d8163a1c724ad800ba18e056
References: <ff59fb89-c186-af41-0990-54de8ef91ef5@samsung.com>
	<CGME20240527082328epcas5p205a74058d8163a1c724ad800ba18e056@epcas5p2.samsung.com>

On 5/27/2024 11:09 AM, Kanchan Joshi wrote:
>On 5/27/2024 7:59 AM, hexue wrote:
>> From: Xue He <xue01.he@samsung.com>
>> 
>> It is used in block hybrid poll, the related function
>
>It -> blk_stats_alloc_enable
>
>Also, you might want to mention the patch that removed it.
>54bdd67d0f88 blk-mq: remove hybrid polling
>
>
>> definitions have been removed, but the function
>> declaration has not been delelted.
>delelted -> deleted.

Thanks, will modify these and submit v2.
