Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2846C1741D2
	for <linux-block@vger.kernel.org>; Wed,  3 Jul 2024 12:21:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720009276; cv=none; b=A0R0Yfq8l2w0YtJolWvu7OQsJ6DJzCEIrvitR21qW6Y37F5I9G4yOItuHy9luirTOFAEcHpwrfs5w5WfR19P3c2qz0CGblrgqj689hSWNt1A/D98f/ZmR0wzQ/u7hpaGMkvKIbb/nbx6zndhTW9f4jXuXak7IX0YSmkCMv9K0sg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720009276; c=relaxed/simple;
	bh=MPy2dmqKlCsrw5okIZFwkiGzwVi0bWXg1j0NfWvMFRQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:In-Reply-To:
	 Content-Type:References; b=QOEkb2+JaeO2ZJ2LA6WwDdd12Le6IG12Sy5DORY1rlQHT/Qk0HFH+ucfyUihPQ84qXpZ1PguHLw4JOLtQYOKedHyD9dMYHhXB6NpmXCXxGPbEon+jzjFJ+Exm+cDU23RcsdXPa0y+ZM1geXhzf7rWiEZzrIXSpuE0+lnTql6PpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=Tuu3ZYn2; arc=none smtp.client-ip=203.254.224.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="Tuu3ZYn2"
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
	by mailout2.samsung.com (KnoxPortal) with ESMTP id 20240703122111epoutp02ef16999b12370ba31174b685ea3a546e~es1G49U4I1211912119epoutp02g
	for <linux-block@vger.kernel.org>; Wed,  3 Jul 2024 12:21:11 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20240703122111epoutp02ef16999b12370ba31174b685ea3a546e~es1G49U4I1211912119epoutp02g
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1720009271;
	bh=MPy2dmqKlCsrw5okIZFwkiGzwVi0bWXg1j0NfWvMFRQ=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=Tuu3ZYn2AP9TSSop/4VAKT9IiDoY18yrbXsROx2BmQZNKSwhUvmRZzh8PqUfRR0vo
	 6TWZN0aStXrCKjnKBD7/dd9ME3H2Ifty2CpIu5cEscarm6Za591dfoL0YVITWzLqMe
	 656t5OG/Vyiw4/WHHv1tA0C6pSVnj36FvZkp/+Ro=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTP id
	20240703122110epcas5p120925213338da641b4a9a5cec4b41f8f~es1GheMG62872528725epcas5p1W;
	Wed,  3 Jul 2024 12:21:10 +0000 (GMT)
Received: from epsmgec5p1-new.samsung.com (unknown [182.195.38.176]) by
	epsnrtp4.localdomain (Postfix) with ESMTP id 4WDf5K4Wrfz4x9Px; Wed,  3 Jul
	2024 12:21:09 +0000 (GMT)
Received: from epcas5p4.samsung.com ( [182.195.41.42]) by
	epsmgec5p1-new.samsung.com (Symantec Messaging Gateway) with SMTP id
	D5.53.19174.33245866; Wed,  3 Jul 2024 21:21:07 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
	20240703122106epcas5p45357e9bd5fc730210c3b313e8f0b465e~es1CP5MDQ0457904579epcas5p4V;
	Wed,  3 Jul 2024 12:21:06 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
	epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20240703122106epsmtrp27ac7cbac22a1d6133ee704c7d545bbaa~es1CPMGzY2835428354epsmtrp2b;
	Wed,  3 Jul 2024 12:21:06 +0000 (GMT)
X-AuditID: b6c32a50-87fff70000004ae6-39-66854233d475
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
	epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	DB.04.29940.23245866; Wed,  3 Jul 2024 21:21:06 +0900 (KST)
Received: from [107.122.11.51] (unknown [107.122.11.51]) by
	epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20240703122105epsmtip1b7e39b84df4f4e1ce3958ce6d84f77aa~es1BYz_fK2681126811epsmtip1Q;
	Wed,  3 Jul 2024 12:21:05 +0000 (GMT)
Message-ID: <b4268254-129f-ab2a-80a3-08bfef73ddbf@samsung.com>
Date: Wed, 3 Jul 2024 17:51:04 +0530
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0)
	Gecko/20100101 Thunderbird/91.13.1
Subject: Re: [PATCH 6/6] block: don't free the integrity payload in
 bio_integrity_unmap_free_user
Content-Language: en-US
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc: "Martin K . Petersen" <martin.petersen@oracle.com>, Anuj Gupta
	<anuj20.g@samsung.com>, linux-block@vger.kernel.org
From: Kanchan Joshi <joshi.k@samsung.com>
In-Reply-To: <20240702151047.1746127-7-hch@lst.de>
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupjk+LIzCtJLcpLzFFi42LZdlhTS9fYqTXN4Ey/kEXThL/MFqvv9rNZ
	rFx9lMli7y1ti+XH/zE5sHpcPlvqsftmA5vHx6e3WDz6tqxi9Pi8SS6ANSrbJiM1MSW1SCE1
	Lzk/JTMv3VbJOzjeOd7UzMBQ19DSwlxJIS8xN9VWycUnQNctMwdotZJCWWJOKVAoILG4WEnf
	zqYov7QkVSEjv7jEVim1ICWnwKRArzgxt7g0L10vL7XEytDAwMgUqDAhO+PUjqVMBUYV1+b2
	MTUw6nYxcnJICJhIbF+3hq2LkYtDSGAPo0Tvxh8sEM4nRok1l/6xQzjfGCXevv7ACNOysXsb
	I0RiL6PE39srmSCct4wS8/9tZwKp4hWwk1j18yVYB4uAisShX3dYIeKCEidnPmEBsUUFkiV+
	dh1gA7GFgezdB3eDxZkFxCVuPZkPNkdEwEFi9oalbBDxComp954B2RwcbAKaEhcml4KEOQWM
	JH4s+cQEUSIvsf3tHGaQeyQEfrJLTLjwkR3iaheJh58OMkHYwhKvjm+BiktJfH63lw3CzpZ4
	8OgBC4RdI7Fjcx8rhG0v0fDnBivIXmagvet36UPs4pPo/f2ECSQsIcAr0dEmBFGtKHFv0lOo
	TnGJhzOWQNkeEtMezYMG1VpGiam32xknMCrMQgqVWUi+n4XknVkImxcwsqxilEotKM5NT002
	LTDUzUsth8d3cn7uJkZwwtQK2MG4esNfvUOMTByMhxglOJiVRHil3jenCfGmJFZWpRblxxeV
	5qQWH2I0BcbPRGYp0eR8YMrOK4k3NLE0MDEzMzOxNDYzVBLnfd06N0VIID2xJDU7NbUgtQim
	j4mDU6qBacIExc8/HvQUbuEMW923a0bp3LYLKeGzfqb6ZcX9k/loOVfuqN7te8vPPQ280vkv
	KTBEXMHObff2Vi3ts9sycmZIXrp7/3uqyjedszorbHwnpYU4zn/npFwuWnE52aGzdZWg8P8p
	893mBR3R4hO0PbMz/tqBfVPfWXeYeSw0/XncxrpKrmOxgtiRB0sDPxspLH+xQUScL/I5o1b2
	Xs2KfT5RxrP/Smi7PEm+tWbK7V6vm7OV31ze/oy/ak3q+9inD29vOVfrpKjgIDOvL6jm3amj
	rul3pv5La4y+mL6WOcLWTyi06vm1jusphx81rNwkHRp5tPV9edKB+wrvey1/XtzsISBh2Bu6
	umJF3kGJLiWW4oxEQy3mouJEAMdph+whBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrBLMWRmVeSWpSXmKPExsWy7bCSnK6RU2uawZntfBZNE/4yW6y+289m
	sXL1USaLvbe0LZYf/8fkwOpx+Wypx+6bDWweH5/eYvHo27KK0ePzJrkA1igum5TUnMyy1CJ9
	uwSujFM7ljIVGFVcm9vH1MCo28XIySEhYCKxsXsbYxcjF4eQwG5GiY+tncwQCXGJ5ms/2CFs
	YYmV/56zQxS9ZpRY+eEaE0iCV8BOYtXPl4wgNouAisShX3dYIeKCEidnPmEBsUUFkiVe/pkI
	NkgYyN59cDdYnBlowa0n88HmiAg4SMzesJSti5EDKF4hcWdlIcSutYwSi09dZQSJswloSlyY
	XApSzilgJPFjyScmiDFmEl1buxghbHmJ7W/nME9gFJqF5IpZSLbNQtIyC0nLAkaWVYySqQXF
	uem5xYYFhnmp5XrFibnFpXnpesn5uZsYwZGhpbmDcfuqD3qHGJk4GA8xSnAwK4nwSr1vThPi
	TUmsrEotyo8vKs1JLT7EKM3BoiTOK/6iN0VIID2xJDU7NbUgtQgmy8TBKdXA1F4+9+qW1kyt
	KuHjDx/y7NDcMa1xp+PyGbbXZ7lNZina4vJmccZN5q5JRvNvfrzx6d1b9V+21sfv/JvS8Ot/
	tFJK6fEbjUdKFVd939IvseDFG5nrLJ67E2dYM9VIPN7qJ/R8o/jeRZZC1cmNZkp5L1ZKBlQu
	+//j2LcLW19ekEjadb9999YvbdkdF/9sOm6i4/XCni15pqCM4VLGqezTNE/K/Fy+f7+vNFvW
	AVZBVlkRjh/CCwU4n++ffbqfa2fk36clPfe89ySsbtLgPjM5rOIyx3eBiw2uIRdPb9EJOrOE
	oXaj8lvPzLUHTfNfn/ETjW6zKWBb+TxRddlByxfe6zzqjlyenq90hLuClWGptrASS3FGoqEW
	c1FxIgB5daUL+wIAAA==
X-CMS-MailID: 20240703122106epcas5p45357e9bd5fc730210c3b313e8f0b465e
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240702151108epcas5p10cac773e9e1992e768b3a685edd4cdaa
References: <20240702151047.1746127-1-hch@lst.de>
	<CGME20240702151108epcas5p10cac773e9e1992e768b3a685edd4cdaa@epcas5p1.samsung.com>
	<20240702151047.1746127-7-hch@lst.de>

Reviewed-by: Kanchan Joshi <joshi.k@samsung.com>
