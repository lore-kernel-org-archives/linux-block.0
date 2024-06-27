Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81E6C15216F
	for <linux-block@vger.kernel.org>; Thu, 27 Jun 2024 15:37:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719502627; cv=none; b=bfPgatV0fOImHtEHsiCvxMt5kQs5QKh93ob9JzdHHXvWOaEPYcYCbWLNw26IFQInZ6KQA3ibg3yk0wmWfqHB0e3BNl5bIVZcMkxziV9oAgz7Nl7nOYAYgSf09Ysa0LG4Tn61z3xwCCIAelhFfniY0cPYJCDdmK5E5VfvDGp+yy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719502627; c=relaxed/simple;
	bh=V9iudWKtVj7+SdAgTww2hCOxhJhYYv5HDN9zAbAVe1s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:In-Reply-To:
	 Content-Type:References; b=mhJPsMOdAek+W4pTe99XraenTwalfKnZwN6WGEvf0nRXxui+G/OEMN04WFKWMmCHLixeO3x83KRYEIqZ62PH5ZT8pVlyMEGOE7U0WIW8joJM7cEVPsxSocBnRPyxov8XmNB+1iV22hgDq6Hcz5ZQN0RQFfpcSwCNd6scGCUpupk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=uUQpdU7H; arc=none smtp.client-ip=203.254.224.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="uUQpdU7H"
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
	by mailout1.samsung.com (KnoxPortal) with ESMTP id 20240627153701epoutp0191f871a04e9d662d89bd57cdb181540b~c5oYjw7Pk0213102131epoutp01W
	for <linux-block@vger.kernel.org>; Thu, 27 Jun 2024 15:37:01 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20240627153701epoutp0191f871a04e9d662d89bd57cdb181540b~c5oYjw7Pk0213102131epoutp01W
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1719502621;
	bh=V3zFGc7n49oeFMzVkk4hbtT7zrPdX9I8SOpy8Cd5Jgs=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=uUQpdU7H8qVngwwdFzr7YtXYfMavupQZFzW6cJg+3AF44g1l0Wu59NrFQ2j30Upmh
	 bo7uydz7LyS4b/zFOgDj71k1fJWKJ0J5YqFiCp3JNqmjYw1UNY1i/THEc2/XcktU6/
	 5omNgOgseXZZBLyPZUp5RHz/UY9/B3M0YhTi4SDs=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTP id
	20240627153700epcas5p1723288a00022057e50a53bc62f7e31dd~c5oX74GQl3067730677epcas5p1k;
	Thu, 27 Jun 2024 15:37:00 +0000 (GMT)
Received: from epsmges5p1new.samsung.com (unknown [182.195.38.175]) by
	epsnrtp3.localdomain (Postfix) with ESMTP id 4W92k31FCgz4x9Pp; Thu, 27 Jun
	2024 15:36:59 +0000 (GMT)
Received: from epcas5p2.samsung.com ( [182.195.41.40]) by
	epsmges5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	B4.71.11095.B178D766; Fri, 28 Jun 2024 00:36:59 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
	20240627153658epcas5p2e79eec4407ce7d92b73b5f2105fd9ca1~c5oVzYkLH1984819848epcas5p2F;
	Thu, 27 Jun 2024 15:36:58 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
	epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20240627153658epsmtrp10f21ea9b5c9d4f38a8e4e02b8e0a9c8f~c5oVy3Pla0742307423epsmtrp1W;
	Thu, 27 Jun 2024 15:36:58 +0000 (GMT)
X-AuditID: b6c32a49-3c3ff70000012b57-49-667d871b4f2f
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
	epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
	0D.9C.19057.A178D766; Fri, 28 Jun 2024 00:36:58 +0900 (KST)
Received: from [107.122.11.51] (unknown [107.122.11.51]) by
	epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20240627153657epsmtip12a7609340d21e6bfc8d0f772ce5f77cf~c5oU4BqNM0985609856epsmtip1L;
	Thu, 27 Jun 2024 15:36:57 +0000 (GMT)
Message-ID: <a7fd0e31-63bd-8fff-d7d4-6ba990098e7a@samsung.com>
Date: Thu, 27 Jun 2024 21:06:56 +0530
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0)
	Gecko/20100101 Thunderbird/91.13.1
Subject: Re: [PATCH 5/5] block: remove bio_integrity_process
Content-Language: en-US
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc: "Martin K . Petersen" <martin.petersen@oracle.com>,
	linux-block@vger.kernel.org
From: Kanchan Joshi <joshi.k@samsung.com>
In-Reply-To: <20240626045950.189758-6-hch@lst.de>
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpik+LIzCtJLcpLzFFi42LZdlhTQ1e6vTbNYP4ONovVd/vZLFauPspk
	sfeWtsXy4/+YHFg8Lp8t9dh9s4HN4+PTWywenzfJBbBEZdtkpCampBYppOYl56dk5qXbKnkH
	xzvHm5oZGOoaWlqYKynkJeam2iq5+AToumXmAC1UUihLzCkFCgUkFhcr6dvZFOWXlqQqZOQX
	l9gqpRak5BSYFOgVJ+YWl+al6+WlllgZGhgYmQIVJmRnrN5/ib3gD0dF370N7A2MS9m7GDk5
	JARMJE58PsbSxcjFISSwm1Fi1e93jBDOJ0aJv8veQmW+MUrs6fzABtPS3bgYKrGXUeLQ0RY2
	COcto8Sy41MZQap4BewklixYzwpiswioSuxZuQQqLihxcuYTFhBbVCBZ4mfXAbCpwgI2Ekem
	djKB2MwC4hK3nswHs0UEHCRmb1jKBhEPlfgwZyZQLwcHm4CmxIXJpSAmp4ChxPJb8hAV8hLb
	385hhrjzEbvEz/+aELaLxIalL1kgbGGJV8e3QL0vJfGyvw3KzpZ48OgBVE2NxI7NfawQtr1E
	w58brCCrmIG2rt+lD7GKT6L39xMmkLCEAK9ER5sQRLWixL1JT6E6xSUezlgCZXtInLjfBfaT
	kMBqRomOG5ETGBVmIQXJLCSvz0LyzCyExQsYWVYxSqYWFOempxabFhjmpZbDYzs5P3cTIzgx
	annuYLz74IPeIUYmDsZDjBIczEoivKElVWlCvCmJlVWpRfnxRaU5qcWHGE2BcTORWUo0OR+Y
	mvNK4g1NLA1MzMzMTCyNzQyVxHlft85NERJITyxJzU5NLUgtgulj4uCUamAqmMmtL3JQtu3I
	2asHnYJqm68ml5VNMuaYeLEzYl5fauK932cv/d21ZY5ws2TRhoaQTMW5fJMuXb7O+uzegaje
	DoVqy+aN8tKC56fasAbt1sg69sEj76mp9feJjy8/+6t5jO9nyrpdDVx3k544cTDzVu66tHaL
	lCzP+YAt6ZLRDw3a3bcfmv9NLFxnXUTZb/kfxov/v1m8o95UmfdzniH79cKV7sV7IuVrvcT6
	DDxSY2I6mjiqtqs+sSrmT0mT/R8fHetS09V0aPldr/IiyT1hHryrH7HNWZF7ccrCqJcpy/cy
	7+ss2M0a5L7h3KRzyltUMnbc7dzW9iH7l3Gizl3tTfv92rI4X5uFZFQ0+iixFGckGmoxFxUn
	AgBBwwr+FQQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrPLMWRmVeSWpSXmKPExsWy7bCSnK5Ue22awbslshar7/azWaxcfZTJ
	Yu8tbYvlx/8xObB4XD5b6rH7ZgObx8ent1g8Pm+SC2CJ4rJJSc3JLEst0rdL4MpYvf8Se8Ef
	joq+exvYGxiXsncxcnJICJhIdDcuZgGxhQR2M0o8+cYKEReXaL72A6pGWGLlv+dANhdQzWtG
	iW8XPzCCJHgF7CSWLFgP1sAioCqxZ+USqLigxMmZT8CGigokS7z8MxFskLCAjcSRqZ1MIDYz
	0IJbT+aD2SICDhKzNyxlg4iHSpw89oMVYtlqRonXj3cCJTg42AQ0JS5MLgUxOQUMJZbfkoco
	N5Po2trFCGHLS2x/O4d5AqPQLCRXzEKybRaSlllIWhYwsqxilEwtKM5Nzy02LDDKSy3XK07M
	LS7NS9dLzs/dxAiOAy2tHYx7Vn3QO8TIxMF4iFGCg1lJhDe0pCpNiDclsbIqtSg/vqg0J7X4
	EKM0B4uSOO+3170pQgLpiSWp2ampBalFMFkmDk6pBqZ5H3tvmpw+znK4aZKS0jKJpemyfk/3
	yPJaejurmV84KxovVP9dcX4B76KmD3MWMaRlP7DZv+z/1ImMrt9+v4lYKRQ2+3+m7ZLW39l3
	Kibu2colvDbpwVcNA8fOlQ0py6Zs5zvhkpb1aXFMd3XOQh8JfuOb5fpM3htYmeIePTnMmRxu
	84GlPFxutvu/e3xWE51fHrnt4hb9+cW2luw5vOxnuT+Yfaltv/nmfKAPo1fstVdP76l8vfRB
	p9/o5qzYqz+qZ0ecDHFb3sSXwz5n/umrfxad0q5q3xhwdOGxtG3VRplsekyHI5zWSSRfnXLB
	7/Zefc3kxcsmOZzdJN3ysnnWe2/WnRy/g/yNnv3gzEpSYinOSDTUYi4qTgQAMpFSN/ICAAA=
X-CMS-MailID: 20240627153658epcas5p2e79eec4407ce7d92b73b5f2105fd9ca1
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240626050052epcas5p29fc1cf1ef40fdec63860f6d6df9ffad1
References: <20240626045950.189758-1-hch@lst.de>
	<CGME20240626050052epcas5p29fc1cf1ef40fdec63860f6d6df9ffad1@epcas5p2.samsung.com>
	<20240626045950.189758-6-hch@lst.de>

On 6/26/2024 10:29 AM, Christoph Hellwig wrote:
> +	struct blk_integrity *bi = blk_get_integrity(bio->bi_bdev->bd_disk);
> +	struct bio_integrity_payload *bip = bio_integrity(bio);
> +	struct blk_integrity_iter iter;
> +	struct bvec_iter bviter;
> +	struct bio_vec bv;
> +
> +	iter.disk_name = bio->bi_bdev->bd_disk->disk_name;
> +	iter.interval = 1 << bi->interval_exp;
> +	iter.seed = bio->bi_iter.bi_sector;
> +	iter.prot_buf = bvec_virt(bip->bip_vec);
> +	bio_for_each_segment(bv, bio, bviter) {
> +		void *kaddr = bvec_kmap_local(&bv);
> +
> +		iter.data_buf = kaddr;
> +		iter.data_size = bv.bv_len;
> +		switch (bi->csum_type) {
> +		case BLK_INTEGRITY_CSUM_CRC64:
> +			ext_pi_crc64_generate(&iter, bi);
> +			break;
> +		case BLK_INTEGRITY_CSUM_CRC:
> +		case BLK_INTEGRITY_CSUM_IP:
> +			t10_pi_generate(&iter, bi);
> +			break;
> +		default:
> +			break;
> +		}

The bi->csum_type is constant as far as this bio_for_each_segment loop 
is concerned.
Seems wasteful processing, and can rather be moved out where we set a 
function pointer to point to either ext_pi_crc64_generate or 
t10_pi_generate once.
