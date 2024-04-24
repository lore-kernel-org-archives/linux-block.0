Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0324215F408
	for <linux-block@vger.kernel.org>; Wed, 24 Apr 2024 15:27:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713972427; cv=none; b=AwztbUzsAKvOfhcwXGNCYOpvK7H6cptVusEq97eQsxtG6jpmzB/zNLXTScZ1F8NiFuFF72IVc6nLArs8z0Ukdu0DGu4bDJw0J2+oVLyjrkp4YbNngfuVDmGDijP8bbVqvbJ88vOn6FZlDPdTGDx5qELJtiLLqDu99KjN/bf7AXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713972427; c=relaxed/simple;
	bh=aAHGA87W2AEwtVABrITjZKnHcx33HfOIMJrJSMuSJjs=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:In-Reply-To:
	 Content-Type:References; b=fYMP+eGpKyKuZzqlCMeU849lhQYvmJ76cH1elYxgFZYLDHzQuUPrSNJv5sKgBZYW94dydsMsE3xJeu/Cl5lDWnpjMsJ2yzYYUxiGiC/TfazHDDAwukky5rwEKjea31M9WwEOgfcltXcxE2vA0Fa50eAKerpI9AS2JhuxYG0mitA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=hZu20aP+; arc=none smtp.client-ip=203.254.224.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="hZu20aP+"
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
	by mailout3.samsung.com (KnoxPortal) with ESMTP id 20240424152702epoutp03eab52c64df6c7cefb5db1ffacd722469~JQNZglcgF1672316723epoutp03V
	for <linux-block@vger.kernel.org>; Wed, 24 Apr 2024 15:27:02 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20240424152702epoutp03eab52c64df6c7cefb5db1ffacd722469~JQNZglcgF1672316723epoutp03V
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1713972422;
	bh=+4b5ZBQElcN86bQmR77nOqK52tPmgA25vHU3fWiF47s=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=hZu20aP+SjRTpSF2km78k+GwYJZ8840N2CNPf09Gm5izMc9TamHXT/gOzRbu2U7tY
	 GJwZr7leACFGfuNxCQY90ffoQSCFDZV/JSN94dF1TZLIDETZthJInDWHMcydMeWLJX
	 ux+e9OMhAFBW+sGIMQbtUJwMT8H+uIMmuqIj7AP8=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTP id
	20240424152701epcas5p41abefc2a67c1812e93f3a66be6925595~JQNYmLQuy0784507845epcas5p4D;
	Wed, 24 Apr 2024 15:27:01 +0000 (GMT)
Received: from epsmges5p2new.samsung.com (unknown [182.195.38.175]) by
	epsnrtp3.localdomain (Postfix) with ESMTP id 4VPjX36xh8z4x9Pp; Wed, 24 Apr
	2024 15:26:59 +0000 (GMT)
Received: from epcas5p4.samsung.com ( [182.195.41.42]) by
	epsmges5p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
	AE.AE.09688.3C429266; Thu, 25 Apr 2024 00:26:59 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
	20240424132951epcas5p420002a736a4555ac94d3de9fff0ba5f4~JOnFcJ4A61055710557epcas5p4t;
	Wed, 24 Apr 2024 13:29:51 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
	epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20240424132951epsmtrp1641d123f828797ba94ac30c8309f3af2~JOnFa_s_g0781307813epsmtrp11;
	Wed, 24 Apr 2024 13:29:51 +0000 (GMT)
X-AuditID: b6c32a4a-837fa700000025d8-55-662924c3a36e
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
	epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	2E.E0.08924.F4909266; Wed, 24 Apr 2024 22:29:51 +0900 (KST)
Received: from green245 (unknown [107.99.41.245]) by epsmtip1.samsung.com
	(KnoxPortal) with ESMTPA id
	20240424132950epsmtip19b24f98b998e18839310f13037c3af83~JOnD_IM0S0036300363epsmtip1p;
	Wed, 24 Apr 2024 13:29:50 +0000 (GMT)
Date: Wed, 24 Apr 2024 18:52:46 +0530
From: Kundan Kumar <kundan.kumar@samsung.com>
To: Christoph Hellwig <hch@lst.de>
Cc: axboe@kernel.dk, willy@infradead.org, linux-block@vger.kernel.org,
	joshi.k@samsung.com, mcgrof@kernel.org, anuj20.g@samsung.com,
	nj.shetty@samsung.com, c.gameti@samsung.com, gost.dev@samsung.com
Subject: Re: [PATCH] block : add larger order folio size instead of pages
Message-ID: <20240424132246.7ny74cec7cvphg5i@green245>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240422111407.GA10989@lst.de>
User-Agent: NeoMutt/20171215
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrJJsWRmVeSWpSXmKPExsWy7bCmlu5hFc00gyttBhZNE/4yW6y+289m
	8X17H4vFzQM7mSxWrj7KZHH0/1s2i723tC1uTHjKaLHt93xmi98/5rA5cHlsXqHlcflsqcem
	VZ1sHrtvNrB59G1ZxejxeZNcAFtUtk1GamJKapFCal5yfkpmXrqtkndwvHO8qZmBoa6hpYW5
	kkJeYm6qrZKLT4CuW2YO0F1KCmWJOaVAoYDE4mIlfTubovzSklSFjPziElul1IKUnAKTAr3i
	xNzi0rx0vbzUEitDAwMjU6DChOyMF7P+sRbcE6rY/mYVUwPjGb4uRg4OCQETidd/K7oYOTmE
	BHYzSlxbWAhhf2KU2LI9pIuRC8j+xijxaM09NpAESP3K5p3sEIm9jBI/Fvxng+h4xigx+2Mo
	iM0ioCrxet5dFpAFbAK6Ej+awMIiAkoST1+dZQTpZRY4xShx59s8sF5hAU+JFY+fg9XzCphJ
	nHvECxLmFRCUODnzCQuIzSmgI3HjVzuYLSogIzFj6VdmkDkSAlM5JK53NLFDHOci8ezaF2YI
	W1ji1fEtUHEpiZf9bVB2tsShxg1MEHaJxM4jDVBxe4nWU/1gvcwCGRJXV3VBxWUlpp5axwQR
	55Po/f0EqpdXYsc8GFtNYs67qSwQtozEwkszoOIeEk2ft7FAAmsTo8Sle2/YJzDKz0Ly3Cwk
	+yBsK4nOD02ss4BhwSwgLbH8HweEqSmxfpf+AkbWVYySqQXFuempxaYFRnmp5fDYTs7P3cQI
	TrNaXjsYHz74oHeIkYmD8RCjBAezkgjvzY8aaUK8KYmVValF+fFFpTmpxYcYTYFxNZFZSjQ5
	H5jo80riDU0sDUzMzMxMLI3NDJXEeV+3zk0REkhPLEnNTk0tSC2C6WPi4JRqYJr/M/9wySub
	9LKn3LubH5xemf+pY2tYmdK82nXvFdlPT25X6wiUj30q+vGEtJvCnWnH6r3nvLZX7/t0/RCD
	p9An08Vqlt2FswT3M8z01Vnwc/q8aVqPbj/R6k5YPq1G/uyq3uC1NyLl1nLcPtZ+QKL2uJ1n
	T6fR4a9tO7ksNsld0mM0Kd2s6xLOm3I16fUhtvKZopF9FyOtn++zuqypMEOfyeWP27TQXc1S
	OZ8nuYdNjatPOXRhQctufd44Qbeib7ZW8bHt6m+2BqaIzhf8emff7CShl/X+MawXmt/NFee5
	KCt0vpkn+VJA6vILZzojlBx+fNNiPzRBRo3h7Ha2RjH2CR8tV4esO9XnKnmqSImlOCPRUIu5
	qDgRABsFaZA8BAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrLLMWRmVeSWpSXmKPExsWy7bCSnK4/p2aawZe5GhZNE/4yW6y+289m
	8X17H4vFzQM7mSxWrj7KZHH0/1s2i723tC1uTHjKaLHt93xmi98/5rA5cHlsXqHlcflsqcem
	VZ1sHrtvNrB59G1ZxejxeZNcAFsUl01Kak5mWWqRvl0CV8bbn11sBRMEKq5s+cfcwDiDp4uR
	k0NCwERiZfNOdhBbSGA3o8TJvgyIuIzE7rs7WSFsYYmV/54D1XAB1TxhlGg8fRSsgUVAVeL1
	vLssXYwcHGwCuhI/mkJBwiICShJPX51lBKlnFjjFKHHn2zw2kISwgKfEisfPwep5Bcwkzj3i
	hZi5iVFi/70LYDW8AoISJ2c+YQGxmYFq5m1+yAxSzywgLbH8HwdImFNAR+LGr3awElGgO2cs
	/co8gVFwFpLuWUi6ZyF0L2BkXsUomVpQnJueW2xYYJiXWq5XnJhbXJqXrpecn7uJERwjWpo7
	GLev+qB3iJGJg/EQowQHs5II782PGmlCvCmJlVWpRfnxRaU5qcWHGKU5WJTEecVf9KYICaQn
	lqRmp6YWpBbBZJk4OKUamFo5L/5QDS2+scjqiXhFwrajvzd5Ri4X6pAQds/TYflu/eyIc/P/
	w3lcbQGTWO8qOpZmWpS/2HKXKZYr/evhZRm32Nn79s9tKml7evbsKZnbdjyGZxk1/iXeLGMM
	9MqasGROtwEPk9Pp3ZnG8xniLHNP3OgsV/65UuPr8k8h28SLEvd7/JJ/1LAlVPm7fGiJSTzz
	1IDLVf+aFtdb39rUu8I4+FDgEvfggOnVy3jvehRVre6fzXL4csQemzlXeF0WKNbaXV/2XHFO
	mXrtzVvi72a1/GSM+OMvtzH8VSp/9MID4Uv/xQrumBX7YMup2YkL72/fYH+w+k6YzUbfnuXf
	llV4+jfK/GCd933Jf/eGn0osxRmJhlrMRcWJALibpqsAAwAA
X-CMS-MailID: 20240424132951epcas5p420002a736a4555ac94d3de9fff0ba5f4
X-Msg-Generator: CA
Content-Type: multipart/mixed;
	boundary="----vz81d6m7j.py-bGO0GPJ08-4LvSGVDQp9Yqo3MxnNZXK7Ax7=_b1f9a_"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240419092428epcas5p4f63759b0efa1f12dfbcf13c67fa8d0f0
References: <CGME20240419092428epcas5p4f63759b0efa1f12dfbcf13c67fa8d0f0@epcas5p4.samsung.com>
	<20240419091721.1790-1-kundan.kumar@samsung.com>
	<20240422111407.GA10989@lst.de>

------vz81d6m7j.py-bGO0GPJ08-4LvSGVDQp9Yqo3MxnNZXK7Ax7=_b1f9a_
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Disposition: inline

On 22/04/24 01:14PM, Christoph Hellwig wrote:
>> +		folio = page_folio(page);
>> +
>> +		if (!folio_test_large(folio) ||
>> +		   (bio_op(bio) == REQ_OP_ZONE_APPEND)) {
>
>I don't understand why you need this branch.  All the arithmetics
>below should also work just fine for non-large folios

The branch helps to skip these calculations for zero order folio:
A) folio_offset = (folio_page_idx(folio, page) << PAGE_SHIFT) + offset;
B) folio_size(folio)

>, and there
>while the same_page logic in bio_iov_add_zone_append_page probablyg
>needs to be folio-ized first, it should be handled the same way here
>as well.

Regarding the same_page logic, if we add same page twice then we release
the page on second addition. It seemed to me that this logic will work even
if we merge large order folios. Please let me know if I am missing something.

If we pass a large size of folio to bio_iov_add_zone_append_page then we fail
early due queue_max_zone_append_sectors limit. This can be modified to add
lesser pages which are a part of bigger folio. Let me know if I shall proceed
this way or if it is fine not to add the entire folio.

>bio_iov_add_page should also be moved to take a folio
>before the (otherwise nice) changes here.

If we convert bio_iov_add_page() to bio_iov_add_folio()/bio_add_folio(),
we see a decline of about 11% for 4K I/O. When mTHP is enabled we may get
a large order folio even for a 4K I/O. The folio_offset may become larger
than 4K and we endup using expensive mempool_alloc during nvme_map_data in
NVMe driver[1].

[1]
static blk_status_t nvme_map_data(struct nvme_dev *dev, struct request *req,
                struct nvme_command *cmnd)
{
...
...
                        if (bv.bv_offset + bv.bv_len <= NVME_CTRL_PAGE_SIZE * 2)
                                return nvme_setup_prp_simple(dev, req,
                                                             &cmnd->rw, &bv);
...
...
       iod->sgt.sgl = mempool_alloc(dev->iod_mempool, GFP_ATOMIC);
...
...
}

--
Kundan
>
>

------vz81d6m7j.py-bGO0GPJ08-4LvSGVDQp9Yqo3MxnNZXK7Ax7=_b1f9a_
Content-Type: text/plain; charset="utf-8"


------vz81d6m7j.py-bGO0GPJ08-4LvSGVDQp9Yqo3MxnNZXK7Ax7=_b1f9a_--
