Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98D9D56452
	for <linux-block@vger.kernel.org>; Mon, 22 Apr 2024 10:14:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713780868; cv=none; b=ToIT+JYH4LWg+1FPUGj/3qTV2haVriBLeI4CuJwgVuwQuSXbpDJiMHKcX0xtMxLC5KdNdQWZJ/W9ck8FlFe4XVnvNq6wFmypvuBs8JymynDmRA/ef1EL/W2Jk9TEcVs1kwMl2QHVTQ8Iorla0v1IwEfDyla5sua4j1kfTxg2nwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713780868; c=relaxed/simple;
	bh=aULLQljMfprQ8EE0nSn/l3diiUItrs4c+qAepkRAJKs=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:In-Reply-To:
	 Content-Type:References; b=IeU/9mCQmQopBCnN84hIPp/4i5xmtOtfuAhwpitLhd6LYEBZwovlSSJOXITt9Gb4dLUMK3eZgU/wkAd4Q4o0oALdBZ8PNJM//bBAc072MC2UYv/PjFBvc01couyHieUlvcUS+JpLelr13UceLSZG57hJGbRCTAcePfG7n/qmCrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=T7fKFqyB; arc=none smtp.client-ip=203.254.224.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="T7fKFqyB"
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
	by mailout3.samsung.com (KnoxPortal) with ESMTP id 20240422101418epoutp03f629dd00768f5dc089722f8dc3eeb807~IkpxRdJ0x1087010870epoutp03p
	for <linux-block@vger.kernel.org>; Mon, 22 Apr 2024 10:14:18 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20240422101418epoutp03f629dd00768f5dc089722f8dc3eeb807~IkpxRdJ0x1087010870epoutp03p
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1713780858;
	bh=gSCnD/phnpph4PzOiUAF0/NyqrylRkO3uerObGexdRI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=T7fKFqyBXezaOrnKTH7B+AFT+rw3yrI22jEtg+yq3S5lJ3ucJOtCZeMLFOuSPwrsH
	 S3FMJ07/Zck/gpUHNwR2c8kHJRYWWGUXA4WfIt0e3iYfHC25zgXMsNkfMA4ztC60BM
	 ReaY+0UFdVVrsLlm8zCQm4EGM0OBbbQIQZTsmfEE=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTP id
	20240422101417epcas5p2e2a1679e3dba224b6a7b242af838f0de~Ikpw3G0x_1162411624epcas5p2B;
	Mon, 22 Apr 2024 10:14:17 +0000 (GMT)
Received: from epsmgec5p1new.samsung.com (unknown [182.195.38.183]) by
	epsnrtp1.localdomain (Postfix) with ESMTP id 4VNLh813BKz4x9Q2; Mon, 22 Apr
	2024 10:14:16 +0000 (GMT)
Received: from epcas5p2.samsung.com ( [182.195.41.40]) by
	epsmgec5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	F5.84.08600.77836266; Mon, 22 Apr 2024 19:14:16 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
	20240422095200epcas5p24ceb8fc2291ae775238621574181b183~IkWTCubKZ2690026900epcas5p2B;
	Mon, 22 Apr 2024 09:52:00 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
	epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20240422095200epsmtrp17e2c74ddcd3a4ce6963bd04586bfee24~IkWTB8wfr3044830448epsmtrp1I;
	Mon, 22 Apr 2024 09:52:00 +0000 (GMT)
X-AuditID: b6c32a44-6c3ff70000002198-7d-662638770f8d
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
	epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
	5D.37.08390.F3336266; Mon, 22 Apr 2024 18:51:59 +0900 (KST)
Received: from green245 (unknown [107.99.41.245]) by epsmtip1.samsung.com
	(KnoxPortal) with ESMTPA id
	20240422095158epsmtip15f1e55d9dd2fb1a98284ad44221120cf~IkWRf-kPK0826608266epsmtip1K;
	Mon, 22 Apr 2024 09:51:58 +0000 (GMT)
Date: Mon, 22 Apr 2024 15:14:58 +0530
From: Kundan Kumar <kundan.kumar@samsung.com>
To: Matthew Wilcox <willy@infradead.org>
Cc: axboe@kernel.dk, hch@lst.de, linux-block@vger.kernel.org,
	joshi.k@samsung.com, mcgrof@kernel.org, anuj20.g@samsung.com,
	nj.shetty@samsung.com, c.gameti@samsung.com, gost.dev@samsung.com
Subject: Re: [PATCH] block : add larger order folio size instead of pages
Message-ID: <20240422094458.fyrluqzar42kac2u@green245>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <ZiJ8yMVb4OoQJzM1@casper.infradead.org>
User-Agent: NeoMutt/20171215
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrFJsWRmVeSWpSXmKPExsWy7bCmhm6FhVqawc1FTBZNE/4yW6y+289m
	8X17H4vFzQM7mSxWrj7KZHH0/1s2i723tC1uTHjKaLHt93xmi98/5rA5cHlsXqHlcflsqcem
	VZ1sHrtvNrB59G1ZxejxeZNcAFtUtk1GamJKapFCal5yfkpmXrqtkndwvHO8qZmBoa6hpYW5
	kkJeYm6qrZKLT4CuW2YO0F1KCmWJOaVAoYDE4mIlfTubovzSklSFjPziElul1IKUnAKTAr3i
	xNzi0rx0vbzUEitDAwMjU6DChOyM1z9PMxY0Klf8vvKPsYGxR7KLkZNDQsBEYuqn+6xdjFwc
	QgK7GSXanpxmgnA+MUpseNbNBFIlJPCNUeLQSxGYjnuv77NBFO1llHj55w4zhPOMUeLd1sVs
	IFUsAqoSKxcfY+xi5OBgE9CV+NEUCmKKCGhIvNliBFLBLHCQUWLFBQkQW1jAU2LF4+csIDav
	gJlE15GJTBC2oMTJmU/A4pxAey9cOsQOYosKyEjMWPoVbK2EwFQOiXufJjFDHOcise7BCTYI
	W1ji1fEt7BC2lMTL/jYoO1viUOMGJgi7RGLnkQaouL1E66l+ZojjMiRefFjKAhGXlZh6ah0T
	RJxPovf3E6heXokd82BsNYk576ZC1ctILLw0AyruIdH0eRsLJBB3MUrcPMg+gVF+FpLfZiFZ
	B2FbSXR+aGKdBQwuZgFpieX/OCBMTYn1u/QXMLKuYpRMLSjOTU9NNi0wzEsth0d3cn7uJkZw
	otVy2cF4Y/4/vUOMTByMhxglOJiVRHh//VFJE+JNSaysSi3Kjy8qzUktPsRoCoypicxSosn5
	wFSfVxJvaGJpYGJmZmZiaWxmqCTO+7p1boqQQHpiSWp2ampBahFMHxMHp1QDUw+D2d2oZult
	puv3d+0rs6w6YzB9Ae/Douv14R0zszfKnNfYZ9qzNsjnk3GL5mGxsOqUaRcNVO5UKyXa2Obs
	ML+1q3TOZUEmLa0jQWc6LRINj2rpGdSUqWbyWyzrvrO20K/1Vo9o0s50RsMws9IljhE3Uvd/
	/9JkfeXf/Y9sP7gNOjfe3+w9s3s165mjalU9jbbP3Rhtxd6XrJ7r5hRcd8j8tUfh27XNXmWL
	Fi+e9tAs7eJiJ/7zWZEL711jv/7d1Sw6/EvW9vK5jKZM7XxHRWZ6hRw4PU9t0p0DvOfrmlxW
	fVWpqfp6T+Gr9Z4LRzWjNrlN8DmpLyJWoKgR887W2mDS6VeGSTXiux+H3PurxFKckWioxVxU
	nAgAPfVT7T0EAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrNLMWRmVeSWpSXmKPExsWy7bCSnK6DsVqawZ8Ei6YJf5ktVt/tZ7P4
	vr2PxeLmgZ1MFitXH2WyOPr/LZvF3lvaFjcmPGW02PZ7PrPF7x9z2By4PDav0PK4fLbUY9Oq
	TjaP3Tcb2Dz6tqxi9Pi8SS6ALYrLJiU1J7MstUjfLoErY3rHSsaCzQoVy9cuZWpgvCHWxcjJ
	ISFgInHv9X22LkYuDiGB3YwSN9samCASMhK77+5khbCFJVb+e84OUfSEUaLn7i8WkASLgKrE
	ysXHGLsYOTjYBHQlfjSFgpgiAhoSb7YYgVQwCxxklFhxQQLEFhbwlFjx+DlYJ6+AmUTXkYlg
	q4QEdjFK3HieAhEXlDg58wkLRK+ZxLzND5lBRjILSEss/8cBEuYEOvnCpUPsILYo0JUzln5l
	nsAoOAtJ9ywk3bMQuhcwMq9ilEwtKM5Nzy02LDDKSy3XK07MLS7NS9dLzs/dxAiODy2tHYx7
	Vn3QO8TIxMF4iFGCg1lJhPfXH5U0Id6UxMqq1KL8+KLSnNTiQ4zSHCxK4rzfXvemCAmkJ5ak
	ZqemFqQWwWSZODilGpjm2+6fGVt37N+yjv+7/67sWWUSt0cieh/z2ieWl2etdk1WyVVsDpWd
	keXqWHJsuczRpQdavhd35fXuEJhsWMG+OnTq3+0pMf+1T2gdL7J+8m8fv5Has5jJb6d9CbLx
	1y86uPZzW/Ov5guti2oPzrNiWnJ4c6+AC+v+s+fFFWzXrt2f/dz6wN95Cco7NeO1+sqScxfO
	PLTlzLIvfxcEKrbPX/Wq/vlJbSH9teaTxVfzvM06XzfHZi8H36QLF594hbyTMLHrnqD9Y+9R
	mZyXP0q19/g3qDLxBaf4hy969XjXJ2ah6jMLpFXdhAr1ln2Wkm6bX6d+d1NPx0PF4yfvbjSP
	3c37aKuZBzvDEou5LrtVlFiKMxINtZiLihMBu1xsWf4CAAA=
X-CMS-MailID: 20240422095200epcas5p24ceb8fc2291ae775238621574181b183
X-Msg-Generator: CA
Content-Type: multipart/mixed;
	boundary="----vz81d6m7j.py-bGO0GPJ08-4LvSGVDQp9Yqo3MxnNZXK7Ax7=_a50ea_"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240419092428epcas5p4f63759b0efa1f12dfbcf13c67fa8d0f0
References: <CGME20240419092428epcas5p4f63759b0efa1f12dfbcf13c67fa8d0f0@epcas5p4.samsung.com>
	<20240419091721.1790-1-kundan.kumar@samsung.com>
	<ZiJ8yMVb4OoQJzM1@casper.infradead.org>

------vz81d6m7j.py-bGO0GPJ08-4LvSGVDQp9Yqo3MxnNZXK7Ax7=_a50ea_
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Disposition: inline

On 19/04/24 03:16PM, Matthew Wilcox wrote:
>On Fri, Apr 19, 2024 at 02:47:21PM +0530, Kundan Kumar wrote:
>> When mTHP is enabled, IO can contain larger folios instead of pages.
>> In such cases add a larger size to the bio instead of looping through
>> pages. This reduces the overhead of iterating through pages for larger
>> block sizes. perf diff before and after this change:
>>
>> Perf diff for write I/O with 128K block size:
>> 	1.22%     -0.97%  [kernel.kallsyms]  [k] bio_iov_iter_get_pages
>> Perf diff for read I/O with 128K block size:
>> 	4.13%     -3.26%  [kernel.kallsyms]  [k] bio_iov_iter_get_pages
>
>I'm a bit confused by this to be honest.  We already merge adjacent
>pages, and it doesn't look to be _that_ expensive.  Can you drill down
>any further in the perf stats and show what the expensive part is?
>
>
Majority of the overhead exists due to repeated call to bvec_try_merge_page().
For a 128K size I/O we would call this function 32 times. The
bvec_try_merge_page() function does comparisions and calculations which adds
to overall overhead[1]

Function bio_iov_iter_get_pages() shows reduction of overhead at these places[2]

This patch reduces overhead as evident from perf diff:
     4.17%     -3.21%  [kernel.kallsyms]  [k] bio_iov_iter_get_pages
Also
     5.54%             [kernel.kallsyms]  [k] bvec_try_merge_page

the above perf diff has been obtained by running fio command[3]

Note : These experiments have been done after enabling mTHP, where we get
one folio for a 128K I/O.

[1]
I.       : 14               size_t bv_end = bv->bv_offset + bv->bv_len;
         : 15               phys_addr_t vec_end_addr = page_to_phys(bv->bv_page) + bv_end - 1;
         : 16               phys_addr_t page_addr = page_to_phys(page);
         : 18               if (vec_end_addr + 1 != page_addr + off)
    3.21 :   ffffffff817ac796:       mov    %ecx,%eax
         : 20               {
    1.40 :   ffffffff817ac798:       mov    %rsp,%rbp
    3.14 :   ffffffff817ac79b:       push   %r15
    2.35 :   ffffffff817ac79d:       push   %r14
    3.13 :   ffffffff817ac7a4:       push   %r12

II.       : 113              if (bv->bv_page + bv_end / PAGE_SIZE != page + off / PAGE_SIZE)
    1.84 :   ffffffff817ac83e:       shr    $0xc,%ecx
    3.09 :   ffffffff817ac841:       shr    $0xc,%r15
    8.52 :   ffffffff817ac84d:       add    0x0(%r13),%r15
    0.65 :   ffffffff817ac851:       add    %rcx,%r14
    0.62 :   ffffffff817ac854:       cmp    %r14,%r15
    0.61 :   ffffffff817ac857:       je     ffffffff817ac86e <bvec_try_merge_page+0xde>

[2]
I.           : 206              struct page *page = pages[i];
    4.92 :   ffffffff817af307:       mov    -0x40(%rbp),%rdx
    3.97 :   ffffffff817af30b:       mov    %r13d,%eax

II.       : 198              for (left = size, i = 0; left > 0; left -= len, i++) {
    0.95 :   ffffffff817af2f0:       add    $0x1,%r13d
    4.80 :   ffffffff817af2f6:       sub    %rbx,%r12
    2.87 :   ffffffff817af2f9:       test   %r12,%r12

III.     : 167              if (WARN_ON_ONCE(bio->bi_iter.bi_size > UINT_MAX - len))
    3.91 :   ffffffff817af295:       jb     ffffffff817af547 <bio_iov_iter_get_pages+0x3e7>
         : 169              if (bio->bi_vcnt > 0 &&
    2.98 :   ffffffff817af2a0:       test   %ax,%ax
         : 173              bvec_try_merge_page(&bio->bi_io_vec[bio->bi_vcnt - 1],
    3.45 :   ffffffff817af2a5:       movzwl %ax,%edi
    1.07 :   ffffffff817af2ab:       lea    -0x41(%rbp),%r8
    3.08 :   ffffffff817af2af:       mov    %r10,-0x50(%rbp)
    5.77 :   ffffffff817af2b3:       sub    $0x1,%edi
    0.96 :   ffffffff817af2b6:       mov    %ebx,-0x58(%rbp)
    0.95 :   ffffffff817af2b9:       movslq %edi,%rdi
    2.88 :   ffffffff817af2bc:       shl    $0x4,%rdi
    0.96 :   ffffffff817af2c0:       add    0x70(%r15),%rdi

[3]
perf record -o fio_128k_block_read.data fio -iodepth=128 -iomem_align=128K\
-iomem=mmap -rw=randread -direct=1 -ioengine=io_uring -bs=128K -numjobs=1\
-runtime=1m -group_reporting -filename=/dev/nvme1n1 -name=io_uring_test

--Kundan

------vz81d6m7j.py-bGO0GPJ08-4LvSGVDQp9Yqo3MxnNZXK7Ax7=_a50ea_
Content-Type: text/plain; charset="utf-8"


------vz81d6m7j.py-bGO0GPJ08-4LvSGVDQp9Yqo3MxnNZXK7Ax7=_a50ea_--
