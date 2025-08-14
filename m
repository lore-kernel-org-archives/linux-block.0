Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31A6F318125
	for <linux-block@vger.kernel.org>; Thu, 14 Aug 2025 10:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755166731; cv=none; b=swZ0FtAQSlrqhsS86p5tST3qxlWCmDdy0+rAH5SuyTw8+EUunWOdENPSCed8+zlP5AdFbBwq/IixRyBaM2+AphMRDh25eyB0nQc5g2E/wvwosabnmeL0Fl3pKBN6zsWnGMAGylwY/oqql/yNydXqRQCnCFc2CwG3Ir5XlhNMzac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755166731; c=relaxed/simple;
	bh=MPy2dmqKlCsrw5okIZFwkiGzwVi0bWXg1j0NfWvMFRQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:In-Reply-To:
	 Content-Type:References; b=O5wvdRBzjh8J8t7VPcgyLOxh2Bz2oE66lgeII4xHtA6BRX+fWDyoaTIid+jn1CnlA4v2xvQ1ZMb3eG5LRKp/tNB/q03460awFD59nzndSC8yL2UNKZ8UMVby9LakJftOyZdMul0t6Y4scxOWJ9wcsFQ2xXBX/22LDFZ1c0s/7co=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=t/Gqglrh; arc=none smtp.client-ip=203.254.224.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="t/Gqglrh"
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
	by mailout1.samsung.com (KnoxPortal) with ESMTP id 20250814101847epoutp01c6d667747bea13ce5131463f27de9217~bmtbSPjFJ2245122451epoutp01K
	for <linux-block@vger.kernel.org>; Thu, 14 Aug 2025 10:18:47 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20250814101847epoutp01c6d667747bea13ce5131463f27de9217~bmtbSPjFJ2245122451epoutp01K
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1755166727;
	bh=MPy2dmqKlCsrw5okIZFwkiGzwVi0bWXg1j0NfWvMFRQ=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=t/GqglrhnCRXJtJXvL07IJFrKC2by+yilid145KvwH8UxyiOMVSA3Wo5BjePBjA6J
	 CLOOhOmBKAAgOl6eU5MJ0kF9vLjt1GuJR0jHZ/JQdB4nt+54GqLiTCbu3jxaU3rXBt
	 t38a1XZFqDy2bLVo8sO3RcIeGtHKv9OciskMw+Ms=
Received: from epsnrtp01.localdomain (unknown [182.195.42.153]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTPS id
	20250814101846epcas5p1a3ce485aa19b78c5148ebfee6c321365~bmta9vAqn1323713237epcas5p1X;
	Thu, 14 Aug 2025 10:18:46 +0000 (GMT)
Received: from epcas5p4.samsung.com (unknown [182.195.38.89]) by
	epsnrtp01.localdomain (Postfix) with ESMTP id 4c2h6G1X5Nz6B9m7; Thu, 14 Aug
	2025 10:18:46 +0000 (GMT)
Received: from epsmtip2.samsung.com (unknown [182.195.34.31]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
	20250814101845epcas5p4c2c3dfd67a80e3e43a91aff66c314c93~bmtZ3-8Ga2778127781epcas5p43;
	Thu, 14 Aug 2025 10:18:45 +0000 (GMT)
Received: from [107.122.11.51] (unknown [107.122.11.51]) by
	epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20250814101844epsmtip28fec19ebeee122086ab912e968a4a66c~bmtY1U_yX0772407724epsmtip2T;
	Thu, 14 Aug 2025 10:18:44 +0000 (GMT)
Message-ID: <81d5973c-bd9e-4cae-8b2e-d1106c911e89@samsung.com>
Date: Thu, 14 Aug 2025 15:48:43 +0530
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv7 3/9] blk-mq-dma: require unmap caller provide p2p map
 type
To: Keith Busch <kbusch@meta.com>, linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org
Cc: hch@lst.de, axboe@kernel.dk, Keith Busch <kbusch@kernel.org>
Content-Language: en-US
From: Kanchan Joshi <joshi.k@samsung.com>
In-Reply-To: <20250813153153.3260897-4-kbusch@meta.com>
Content-Transfer-Encoding: 7bit
X-CMS-MailID: 20250814101845epcas5p4c2c3dfd67a80e3e43a91aff66c314c93
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
cpgsPolicy: CPGSC10-542,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20250813153211epcas5p1f2b7ff2536a368d396e32c6bf96fc8c9
References: <20250813153153.3260897-1-kbusch@meta.com>
	<CGME20250813153211epcas5p1f2b7ff2536a368d396e32c6bf96fc8c9@epcas5p1.samsung.com>
	<20250813153153.3260897-4-kbusch@meta.com>

Reviewed-by: Kanchan Joshi <joshi.k@samsung.com>
