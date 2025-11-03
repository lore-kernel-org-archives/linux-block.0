Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B37451EDA0B
	for <linux-block@vger.kernel.org>; Mon,  3 Nov 2025 11:16:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762168573; cv=none; b=pbORQOKDn5V9WD/TqDVF/ijsYn5cB6WNaYaTiWRZwMLVsIr3QfsTjDzKqaDSSqkiHYc0P9PXfpwVJVB9LYeldV0oPh1iRIymeJs6K8kYn+rLkMHwnz83vQyw8Eu8yrUQVbYQoAlgBkUWl26dq14XeMItXTA5scr1xplEfAnQYFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762168573; c=relaxed/simple;
	bh=MPy2dmqKlCsrw5okIZFwkiGzwVi0bWXg1j0NfWvMFRQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:In-Reply-To:
	 Content-Type:References; b=Tk7w4issaCQgnE7p4wY8aSkh8esAIex7QQhprTvFKPdrYltFrTmtUUR70cyStoDWIMuY4QL6gRR5aTdmZ1fZLhGDS/QO1M0PcpcFxQJqj5pMdW6vpbYiSZiyIDows+Wj5dXOquQTULmMzlM/hCJXt7xEjy6UVSOGiyxuYGbEtHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=rzbKnoZn; arc=none smtp.client-ip=203.254.224.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="rzbKnoZn"
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
	by mailout3.samsung.com (KnoxPortal) with ESMTP id 20251103111603epoutp03d0eb0a0c049d56435e066e1d19a895b5~0evjeBShd2457424574epoutp03X
	for <linux-block@vger.kernel.org>; Mon,  3 Nov 2025 11:16:03 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20251103111603epoutp03d0eb0a0c049d56435e066e1d19a895b5~0evjeBShd2457424574epoutp03X
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1762168563;
	bh=MPy2dmqKlCsrw5okIZFwkiGzwVi0bWXg1j0NfWvMFRQ=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=rzbKnoZn1p6m+We4irgL/sAGqx1u9we/t3J1QL5ONEdedeP9hJHf9Xkm3QQLiuYie
	 YYWcq0Srr8DSJNDeZXlNGCiGD03CVDajgRpVqaBC+NL1qhgqJSDuYIo+Gz8Hwjz5vw
	 2E1/J/fM192H+zND/muC+C7buA02NNCzKG3snuVs=
Received: from epsnrtp04.localdomain (unknown [182.195.42.156]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTPS id
	20251103111602epcas5p4eed8aad6262bcef6c796402fd1bf2190~0evirviXn1273712737epcas5p4n;
	Mon,  3 Nov 2025 11:16:02 +0000 (GMT)
Received: from epcas5p4.samsung.com (unknown [182.195.38.88]) by
	epsnrtp04.localdomain (Postfix) with ESMTP id 4d0TXn0mrsz6B9m9; Mon,  3 Nov
	2025 11:15:53 +0000 (GMT)
Received: from epsmtip1.samsung.com (unknown [182.195.34.30]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
	20251103111552epcas5p3c1ba08e1e3be41c4d6575a7d5b3195b5~0evY2N-zS0840908409epcas5p3J;
	Mon,  3 Nov 2025 11:15:52 +0000 (GMT)
Received: from [107.122.11.51] (unknown [107.122.11.51]) by
	epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20251103111551epsmtip15ab39f51115dc46f8c123327a46e925a~0evYIC3TS2279822798epsmtip1F;
	Mon,  3 Nov 2025 11:15:50 +0000 (GMT)
Message-ID: <8348b109-7750-4337-8c72-f60114bafd08@samsung.com>
Date: Mon, 3 Nov 2025 16:45:48 +0530
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] block: make bio auto-integrity deadlock safe
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc: "Martin K. Petersen" <martin.petersen@oracle.com>,
	linux-block@vger.kernel.org
Content-Language: en-US
From: Kanchan Joshi <joshi.k@samsung.com>
In-Reply-To: <20251103101653.2083310-3-hch@lst.de>
Content-Transfer-Encoding: 7bit
X-CMS-MailID: 20251103111552epcas5p3c1ba08e1e3be41c4d6575a7d5b3195b5
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
cpgsPolicy: CPGSC10-542,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20251103101825epcas5p2565dd87bee4fe9ef689cd01e02347b73
References: <20251103101653.2083310-1-hch@lst.de>
	<CGME20251103101825epcas5p2565dd87bee4fe9ef689cd01e02347b73@epcas5p2.samsung.com>
	<20251103101653.2083310-3-hch@lst.de>

Reviewed-by: Kanchan Joshi <joshi.k@samsung.com>
