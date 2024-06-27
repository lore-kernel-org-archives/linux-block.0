Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A31441990C8
	for <linux-block@vger.kernel.org>; Thu, 27 Jun 2024 15:43:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719502985; cv=none; b=COVT2MFU4rMTnqzOpGAcsuFstXQ2AjaVzbhHAM9ZmGfwknS93VH30YqwDLHE/dlxVYNPemNbxFyDPBU2Y3liYkpNN++R9PgJDy7i6pO0EMwiR7eKYxO3/wMHFQorhi/LMO48V0EAbEZkCq9+Gda16KcpwJdPYBNiaU+r3g85PCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719502985; c=relaxed/simple;
	bh=MPy2dmqKlCsrw5okIZFwkiGzwVi0bWXg1j0NfWvMFRQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:In-Reply-To:
	 Content-Type:References; b=jOMWQ3NkSvge87lAetH4E6qmbp/6a8BdZstYbnwkdqm3A4F9H+w0bcNm2JuxdTJIzOFwyZ3hSV5pvyWqdeEC55jR2z4XiUMo3R/vTBtbHpOHnO7AiEuEWSW2ptvz5ieziBsJTEK+qF6CmLW+4ZbbiDrcEHxmOOtT7lRSlqiHqfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=SxsUf09D; arc=none smtp.client-ip=203.254.224.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="SxsUf09D"
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
	by mailout3.samsung.com (KnoxPortal) with ESMTP id 20240627154301epoutp03f8b02811dd517cf00c5d8a630442387b~c5tnb0sUe3126231262epoutp03L
	for <linux-block@vger.kernel.org>; Thu, 27 Jun 2024 15:43:01 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20240627154301epoutp03f8b02811dd517cf00c5d8a630442387b~c5tnb0sUe3126231262epoutp03L
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1719502981;
	bh=MPy2dmqKlCsrw5okIZFwkiGzwVi0bWXg1j0NfWvMFRQ=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=SxsUf09Dfvf9LyypwNIR6Fpcc/85iyGUUdnlSYYPFno+7BbsGhIOu3/LTKD+4WEiV
	 /x4s4tl12zmCqKiI/mkZiIuH9sySDT7vT0Ki6ulOxqmic1qALVj6lTyb5glIe/QJfV
	 6vSvkdLcio5jxuZxj4YC/mUQU6byM/5qdB9EYFzU=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTP id
	20240627154300epcas5p41eb6b7fa49246170f11b38c783fd165c~c5tmyflsd0991109911epcas5p4D;
	Thu, 27 Jun 2024 15:43:00 +0000 (GMT)
Received: from epsmges5p1new.samsung.com (unknown [182.195.38.175]) by
	epsnrtp3.localdomain (Postfix) with ESMTP id 4W92rz1ysgz4x9Pr; Thu, 27 Jun
	2024 15:42:59 +0000 (GMT)
Received: from epcas5p4.samsung.com ( [182.195.41.42]) by
	epsmges5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	BD.A1.11095.3888D766; Fri, 28 Jun 2024 00:42:59 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
	20240627154258epcas5p3e7640e9a5ab4ad0f68e2205f534be484~c5tlAM-ZJ2917429174epcas5p31;
	Thu, 27 Jun 2024 15:42:58 +0000 (GMT)
Received: from epsmgmcp1.samsung.com (unknown [182.195.42.82]) by
	epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20240627154258epsmtrp2ae991b12a915cba5ff89bcf60ae462f3~c5tk-s7j41300813008epsmtrp2W;
	Thu, 27 Jun 2024 15:42:58 +0000 (GMT)
X-AuditID: b6c32a49-423b770000012b57-1e-667d88830534
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
	epsmgmcp1.samsung.com (Symantec Messaging Gateway) with SMTP id
	71.3E.18846.2888D766; Fri, 28 Jun 2024 00:42:58 +0900 (KST)
Received: from [107.122.11.51] (unknown [107.122.11.51]) by
	epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20240627154257epsmtip28fda35e877b9e750221176d7a016b2ff~c5tkSJqpX2571425714epsmtip22;
	Thu, 27 Jun 2024 15:42:57 +0000 (GMT)
Message-ID: <4a95ef9e-bfde-6115-0900-0595471c888a@samsung.com>
Date: Thu, 27 Jun 2024 21:12:56 +0530
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0)
	Gecko/20100101 Thunderbird/91.13.1
Subject: Re: [PATCH 1/5] block: only zero non-PI metadata tuples in
 bio_integrity_prep
Content-Language: en-US
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc: "Martin K . Petersen" <martin.petersen@oracle.com>,
	linux-block@vger.kernel.org
From: Kanchan Joshi <joshi.k@samsung.com>
In-Reply-To: <20240626045950.189758-2-hch@lst.de>
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpkk+LIzCtJLcpLzFFi42LZdlhTS7e5ozbN4PtGXovVd/vZLFauPspk
	sfeWtsXy4/+YHFg8Lp8t9dh9s4HN4+PTWywenzfJBbBEZdtkpCampBYppOYl56dk5qXbKnkH
	xzvHm5oZGOoaWlqYKynkJeam2iq5+AToumXmAC1UUihLzCkFCgUkFhcr6dvZFOWXlqQqZOQX
	l9gqpRak5BSYFOgVJ+YWl+al6+WlllgZGhgYmQIVJmRnnNqxlKnAqOLa3D6mBkbdLkZODgkB
	E4mtv4+zdTFycQgJ7GaUWDD5EiOE84lR4v3z6Wxwzrm+ZcwwLfveP2EFsYUEdjJKXH3nCFH0
	llGiZfclJpAEr4CdxKfWRWwgNouAqsS9s8tZIOKCEidnPgGzRQWSJX52HQCrERaIkFi0pwfM
	ZhYQl7j1ZD7YHBEBB4nZG5ZCxUMlPsyZCdTLwcEmoClxYXIpSJhTwFDiwbxPrBAl8hLb385h
	BrlHQuAeu8SiF2sYIY52kfhzaDELhC0s8er4FnYIW0ri87u9bBB2tsSDRw+gamokdmzuY4Ww
	7SUa/txgBdnLDLR3/S59iF18Er2/nzCBhCUEeCU62oQgqhUl7k16CtUpLvFwxhJWiBIPiR13
	0iAhtZpRYuKMCUwTGBVmIQXKLCTPz0LyzSyExQsYWVYxSqYWFOempxabFhjmpZbDIzs5P3cT
	IzgtannuYLz74IPeIUYmDsZDjBIczEoivKElVWlCvCmJlVWpRfnxRaU5qcWHGE2BsTORWUo0
	OR+YmPNK4g1NLA1MzMzMTCyNzQyVxHlft85NERJITyxJzU5NLUgtgulj4uCUamByvGd8YqZ/
	5oHyLZ3G2s88Tq/r/vw6PFf5YJ/HbauHsrel9prcN50RJ8ixfzvvv7M6U/4c28C76+i+ewcv
	TGzdyt8jtXQ6/zf5zA8Jz+/0/wrb97lb8VqepUjVcsn1UVk1CTPe3o7UsXmZ8HPZDM61l068
	rsmR9osQey/VZ/8u5PTF1qizFg+b9qbcV/c9GMj+YZ2S9N2swxG7hB97mO28wbi5Xuz6sYJ1
	eQsddzypWBP+bKb9/bO3DfZoaPTbbOjf4WS555qe27LkhT9+Wn2YejGegf+lwY5n6QdnaXa9
	/bfIKS7jra3Goy3Hdn83zC9pjF6Qk3hAcOZb/gsdLgt2iq8q2v648csKJS3xpaHrgpRYijMS
	DbWYi4oTAcobxdQUBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrFLMWRmVeSWpSXmKPExsWy7bCSvG5TR22awY5DUhar7/azWaxcfZTJ
	Yu8tbYvlx/8xObB4XD5b6rH7ZgObx8ent1g8Pm+SC2CJ4rJJSc3JLEst0rdL4Mo4tWMpU4FR
	xbW5fUwNjLpdjJwcEgImEvveP2HtYuTiEBLYzigx99ZGJoiEuETztR/sELawxMp/z8FsIYHX
	jBIT9ueB2LwCdhKfWhexgdgsAqoS984uZ4GIC0qcnPkEzBYVSJZ4+WciWK+wQITEoj09YPXM
	QPNvPZkPtktEwEFi9oalUPFQiZPHfkAdtJpR4u2Kc8xdjBwcbAKaEhcml4LUcAoYSjyY94kV
	ot5MomtrFyOELS+x/e0c5gmMQrOQnDELybpZSFpmIWlZwMiyilE0taA4Nz03ucBQrzgxt7g0
	L10vOT93EyM4+LWCdjAuW/9X7xAjEwfjIUYJDmYlEd7Qkqo0Id6UxMqq1KL8+KLSnNTiQ4zS
	HCxK4rzKOZ0pQgLpiSWp2ampBalFMFkmDk6pBqZYs59Srxc/dngdH5IVbsMZFaxWeMV/1YKM
	EG0pTeUQF0/vu+JfS+XmSH14bvD8SRanqeavE/8fS3PPedb/WaDOxr1kJ593wMvDl3NY5nSk
	rbzDuj98w0a9s6eChQXVU/h8J+fs0udoCj/epKimGpMUq2KRdHDL4fMiBU8Udu2+Uq8hEHbB
	QkvzGqd4Qk9n/eVfXNuWXGPbcHFVZf1i4eeX5j9OuCHP6J9fZGx9+0XTLbHd59dd4ihX2h/D
	4j/n/36tL447p0nNfqm8ZdLbjSdCP/qVyL61ObF+wXTbKRKzH+Yafdh3NXuCWBj74mXWd6Rk
	vQrzZzccF87Zn2hec69v/4F/G73Cw7aXd5uUH1BiKc5INNRiLipOBAA+cKmc7QIAAA==
X-CMS-MailID: 20240627154258epcas5p3e7640e9a5ab4ad0f68e2205f534be484
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240626050008epcas5p25491b84b29a2d51bb49ceac3717075a3
References: <20240626045950.189758-1-hch@lst.de>
	<CGME20240626050008epcas5p25491b84b29a2d51bb49ceac3717075a3@epcas5p2.samsung.com>
	<20240626045950.189758-2-hch@lst.de>

Reviewed-by: Kanchan Joshi <joshi.k@samsung.com>
