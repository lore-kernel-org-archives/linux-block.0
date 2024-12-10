Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBCA118651
	for <linux-block@vger.kernel.org>; Tue, 10 Dec 2024 12:30:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733833853; cv=none; b=Pmzgq+E+34J47FVA65JVMJaJaFZsVJtzzVSs2mjNteWaZxToh9288tv7FNwn4JfTnG1KZt8mtl7ZiYafuLqXeCfDqPPZsG8M6Ks0W1KgPT84EKaR3noWZFX10GCLFNR/7+qHJ432xvb8euh8pY4Elq5KRrwMxu8hgabf7+UutpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733833853; c=relaxed/simple;
	bh=u6euVx7vB6UmjxKFgsFc62s6Pt7QeiU7Bc7MMNEOO9o=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:In-Reply-To:
	 Content-Type:References; b=j5lheRR+KE2394T3O4POJbWioD01y9Nrx+zWBkqk+mQZhEBp+ZWxxAZ4PwhJ54ZGPTAfXh7cfagEytwV1EAzfJ5kWBZOQjf13jR/E5ycVpSSlj0BcOxo2w48Is+eQY9wqc8Sx4nwK2/Yimfc1aIKnsZfmVTfUbE5juMlPm9MUZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=JiUHcfm6; arc=none smtp.client-ip=203.254.224.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="JiUHcfm6"
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
	by mailout2.samsung.com (KnoxPortal) with ESMTP id 20241210123048epoutp02f68c2b83b54e7414e7414c84c97ae498~P0LLXK37t1904819048epoutp02u
	for <linux-block@vger.kernel.org>; Tue, 10 Dec 2024 12:30:48 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20241210123048epoutp02f68c2b83b54e7414e7414c84c97ae498~P0LLXK37t1904819048epoutp02u
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1733833848;
	bh=u6euVx7vB6UmjxKFgsFc62s6Pt7QeiU7Bc7MMNEOO9o=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=JiUHcfm6/T4aXTrtUmsBVq9uNYjD3zS/t5DHsTtTgxhDjWVdcQmoSQhcieg7zGf4P
	 jZ3pTnZvOfw3E7Wmv+I26H9Y42sb9VkdWzXMshU22nG8HYdGA6jrMVsoW+de2FdWzd
	 wgwYiKpdrn15nZ2+P6e70gEovN1jU9ksZTNYZ2u4=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTP id
	20241210123047epcas5p2c142659570a44ec78add52d53f56c64c~P0LKlDGnj2586425864epcas5p2g;
	Tue, 10 Dec 2024 12:30:47 +0000 (GMT)
Received: from epsmgec5p1new.samsung.com (unknown [182.195.38.181]) by
	epsnrtp4.localdomain (Postfix) with ESMTP id 4Y6ykY4pP3z4x9Pv; Tue, 10 Dec
	2024 12:30:45 +0000 (GMT)
Received: from epcas5p2.samsung.com ( [182.195.41.40]) by
	epsmgec5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	95.35.19710.57438576; Tue, 10 Dec 2024 21:30:45 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
	20241210121958epcas5p27d14abfca66757a2c42ec71895b008b1~P0BuiJSh11588015880epcas5p2a;
	Tue, 10 Dec 2024 12:19:58 +0000 (GMT)
Received: from epsmgmcp1.samsung.com (unknown [182.195.42.82]) by
	epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20241210121958epsmtrp14297f20fa55d83293190eb5d01e17e2e~P0BuhfvOO0358403584epsmtrp13;
	Tue, 10 Dec 2024 12:19:58 +0000 (GMT)
X-AuditID: b6c32a44-36bdd70000004cfe-3a-675834755089
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
	epsmgmcp1.samsung.com (Symantec Messaging Gateway) with SMTP id
	19.60.33707.EE138576; Tue, 10 Dec 2024 21:19:58 +0900 (KST)
Received: from ubuntu (unknown [107.99.41.245]) by epsmtip2.samsung.com
	(KnoxPortal) with ESMTPA id
	20241210121956epsmtip28c69a82e7d5d92d1fe1f370c43920ca0~P0BsxQ5-22915829158epsmtip2f;
	Tue, 10 Dec 2024 12:19:56 +0000 (GMT)
Date: Tue, 10 Dec 2024 17:42:03 +0530
From: Nitesh Shetty <nj.shetty@samsung.com>
To: Keith Busch <kbusch@meta.com>
Cc: axboe@kernel.dk, hch@lst.de, linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org, linux-fsdevel@vger.kernel.org,
	io-uring@vger.kernel.org, sagi@grimberg.me, asml.silence@gmail.com,
	anuj20.g@samsung.com, joshi.k@samsung.com, Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCHv12 08/12] nvme: add a nvme_get_log_lsi helper
Message-ID: <20241210121203.52hmvesybxmwkg2l@ubuntu>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20241206221801.790690-9-kbusch@meta.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrJJsWRmVeSWpSXmKPExsWy7bCmhm6pSUS6wfOjChZNE/4yW8xZtY3R
	YvXdfjaLlauPMlm8az3HYnH0/1s2i0mHrjFanLm6kMVi7y1tiz17T7JYzF/2lN1i3ev3LA48
	Hjtn3WX3OH9vI4vH5bOlHptWdbJ5bF5S77H7ZgObx7mLFR59W1YxenzeJBfAGZVtk5GamJJa
	pJCal5yfkpmXbqvkHRzvHG9qZmCoa2hpYa6kkJeYm2qr5OIToOuWmQN0r5JCWWJOKVAoILG4
	WEnfzqYov7QkVSEjv7jEVim1ICWnwKRArzgxt7g0L10vL7XEytDAwMgUqDAhO2Pmm5iCA6wV
	ny+/ZWlgfMXSxcjJISFgIrH8XxNTFyMXh5DAbkaJPedmM0I4nxglFrZfY4Jznh3bB9dyeeM6
	NojETkaJkwtfQrU8YZR41DGNHaSKRUBVYuOGl0BVHBxsAtoSp/9zgIRFBBQlzgNDAqSeWWAi
	k8TvQ01g9cICjhK9H3tZQOp5gTa8fSgOEuYVEJQ4OfMJ2GJOATOJRc83MYP0Sggs5JD49XUl
	E8RFLhJXl7+Guk5Y4tXxLewQtpTEy/42KLtcYuWUFWwQzS2MErOuz2KESNhLtJ7qZwaxmQUy
	JDZsPQsVl5WYemodE0ScT6L39xOoZbwSO+bB2MoSa9YvYIOwJSWufW+Esj0kZh/8Bw2VrYwS
	Pw6+YJrAKDcLyUezkOyDsK0kOj80sc4CBgCzgDQwVjggTE2J9bv0FzCyrmKUTC0ozk1PTTYt
	MMxLLYfHcnJ+7iZGcBrWctnBeGP+P71DjEwcjIcYJTiYlUR4ObxD04V4UxIrq1KL8uOLSnNS
	iw8xmgIjaCKzlGhyPjAT5JXEG5pYGpiYmZmZWBqbGSqJ875unZsiJJCeWJKanZpakFoE08fE
	wSnVwCQTqnSKRz3a+p/n4q0GydM60rRDYvf6LPzs6PuIaaPxt/RLmzbcrXpy+dOX+hVvvp+X
	K1swJez07H77yj7N0ISSVWdiTxco+vaGTMrYfOfL62OTXoVc95XYd1Zrecu1BQaM0WpKP4pC
	XvJcdNl1I4Xz66FLWyxtu6d9PPuE4UtH22TWrp0nXZ1spnU73ntn59vq+mAC3wqpHXcC16w9
	oDf9TBYX16vFvz5vCXov7nHuCKP9smjHfgnHhl0Rdz7J8v5pPp/Qf+yzvtOBrd5T3ZJYtG5P
	Mmyt60gwOd3Z9cLYqV5Sqex1op3a5lVOyQvmBF2/q/xxqsYGnxybC++1lOY284vzGryce53v
	m87Xu0lKLMUZiYZazEXFiQD9DxZ1TAQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrMLMWRmVeSWpSXmKPExsWy7bCSvO47w4h0g4s3VCyaJvxltpizahuj
	xeq7/WwWK1cfZbJ413qOxeLo/7dsFpMOXWO0OHN1IYvF3lvaFnv2nmSxmL/sKbvFutfvWRx4
	PHbOusvucf7eRhaPy2dLPTat6mTz2Lyk3mP3zQY2j3MXKzz6tqxi9Pi8SS6AM4rLJiU1J7Ms
	tUjfLoEr48zfO2wFn5gqDnZvZ25g3MbUxcjJISFgInF54zo2EFtIYDujxLLp8hBxSYllf48w
	Q9jCEiv/PWeHqHnEKPHikRyIzSKgKrFxw0ugXg4ONgFtidP/OUDCIgKKEueBjuli5OJgFpjM
	JPF85jEWkISwgKNE78deFpB6XqC9bx+KQ4xMlFi9/j4jiM0rIChxcuYTsHJmATOJeZsfMoOU
	MwtISyz/BzaeEyi86Pkm5gmMArOQdMxC0jELoWMBI/MqRtHUguLc9NzkAkO94sTc4tK8dL3k
	/NxNjOB40Qrawbhs/V+9Q4xMHIyHGCU4mJVEeDm8Q9OFeFMSK6tSi/Lji0pzUosPMUpzsCiJ
	8yrndKYICaQnlqRmp6YWpBbBZJk4OKUamKZ35b2IYSldqrVtTVKzscnrdvOtBsu9L5zmfnXl
	wKvwttVnFbPfXVD8xzNj/7fUyRs3RH9kXMLmy2vqtfW4P0+uQtOq2Vc47b6KTXo9Od0jZOd6
	YwG5nhPcF1fWnJnz5tnjBdfu+xx5vnNF0pnf1sG9E1KnHDbsWbpsxvpToieUFkzR/BYqWNWz
	I0TUXse0rN36UhVTqEa2qgC7N/O5FB2HlsWr9K6k/25fYPb4t8VbDTEVdvbXZmYhamGJpxsu
	NW3+IXL/jnCfT0Gg5METzNmbVjjrpffpV0b23HrDGXBOo2Xpso+zyn5x2Fuud74iflpervXV
	RVU7Uxu3N3fXML5az1+qahTlO7eG9U/5HSWW4oxEQy3mouJEAMZNV3kGAwAA
X-CMS-MailID: 20241210121958epcas5p27d14abfca66757a2c42ec71895b008b1
X-Msg-Generator: CA
Content-Type: multipart/mixed;
	boundary="----gzWopnPZ_Ctz0vx8ivNX8AC.S.UWijgAUb-gyMezoI7qaEzu=_726b8_"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20241210121958epcas5p27d14abfca66757a2c42ec71895b008b1
References: <20241206221801.790690-1-kbusch@meta.com>
	<20241206221801.790690-9-kbusch@meta.com>
	<CGME20241210121958epcas5p27d14abfca66757a2c42ec71895b008b1@epcas5p2.samsung.com>

------gzWopnPZ_Ctz0vx8ivNX8AC.S.UWijgAUb-gyMezoI7qaEzu=_726b8_
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Disposition: inline

On 06/12/24 02:17PM, Keith Busch wrote:
>From: Christoph Hellwig <hch@lst.de>
>
>For log pages that need to pass in a LSI value, while at the same time
>not touching all the existing nvme_get_log callers.
>
>Signed-off-by: Christoph Hellwig <hch@lst.de>
>Signed-off-by: Keith Busch <kbusch@kernel.org>
>---

Reviewed-by: Nitesh Shetty <nj.shetty@samsung.com>

------gzWopnPZ_Ctz0vx8ivNX8AC.S.UWijgAUb-gyMezoI7qaEzu=_726b8_
Content-Type: text/plain; charset="utf-8"


------gzWopnPZ_Ctz0vx8ivNX8AC.S.UWijgAUb-gyMezoI7qaEzu=_726b8_--
