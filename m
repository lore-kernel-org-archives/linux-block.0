Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7BFF1EDA0B
	for <linux-block@vger.kernel.org>; Mon,  3 Nov 2025 11:16:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762168581; cv=none; b=AzVpzEGEbHs13jiAoVXDJow+ugRyGKXSXCGgfhZeFp9pWqVNxX61tmWzJ3Q5iiM8sg0RkXUP2DGMGCbqgvGiyH2ECQ28leJYKNeh3CgFMmZ/7gjWTU/NGfjnXeWw575c7t5B7jPDTxLd1NM9ra7oQ3oBa01m19Ha1+U2f83G3KI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762168581; c=relaxed/simple;
	bh=MPy2dmqKlCsrw5okIZFwkiGzwVi0bWXg1j0NfWvMFRQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:In-Reply-To:
	 Content-Type:References; b=sog2RuBt18DxJVwa1o4571WhqDyI+U0j9i4c6uCTbPN0pPsb4WJ8ZJ13WCLJbs7xd4cRRw4JJb6s4s76azvJis4MrBLSjlsaP3qx1lkTpTtzOc6fGdtlIWOAIN85vUVrnyRtvfEwCvKAYfpsYupd0tQ022rqm18CScsvyUxKm1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=UrfibS39; arc=none smtp.client-ip=203.254.224.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="UrfibS39"
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
	by mailout2.samsung.com (KnoxPortal) with ESMTP id 20251103111615epoutp0250c9e785e70d6ca82774f132c9c0334b~0evug9wOX1108011080epoutp02e
	for <linux-block@vger.kernel.org>; Mon,  3 Nov 2025 11:16:15 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20251103111615epoutp0250c9e785e70d6ca82774f132c9c0334b~0evug9wOX1108011080epoutp02e
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1762168575;
	bh=MPy2dmqKlCsrw5okIZFwkiGzwVi0bWXg1j0NfWvMFRQ=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=UrfibS39kLx8YJRQH414YIU23wKjr9i78rB79/PInR+0Wnri9bMliofeHxPm/gqED
	 9llB1PMNGzmcnKHKwSRjK3z1kGkl4kv11FmTlyUdm8mz8dVICi7k+HA4WTGBaDbHH2
	 yISdhzIq40o41RSz5TkPWFz/9EJQh0oTw7xmEsaE=
Received: from epsnrtp03.localdomain (unknown [182.195.42.155]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTPS id
	20251103111614epcas5p3632b6e6e29d51d908a8af93300d054c9~0evtpKMze0840908409epcas5p31;
	Mon,  3 Nov 2025 11:16:14 +0000 (GMT)
Received: from epcas5p1.samsung.com (unknown [182.195.38.92]) by
	epsnrtp03.localdomain (Postfix) with ESMTP id 4d0TY958Q0z3hhT3; Mon,  3 Nov
	2025 11:16:13 +0000 (GMT)
Received: from epsmtip1.samsung.com (unknown [182.195.34.30]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
	20251103111613epcas5p3289865e745e0dfea27be79ddd7f46c5e~0evspM45r0840908409epcas5p3y;
	Mon,  3 Nov 2025 11:16:13 +0000 (GMT)
Received: from [107.122.11.51] (unknown [107.122.11.51]) by
	epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20251103111611epsmtip1f5255c7d27d04b3dbc96e7d134f0fd74~0evrRFzoo2284522845epsmtip1X;
	Mon,  3 Nov 2025 11:16:11 +0000 (GMT)
Message-ID: <bc3114da-63fd-4703-9b62-12b01fbd29f5@samsung.com>
Date: Mon, 3 Nov 2025 16:46:09 +0530
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] block: blocking mempool_alloc doesn't fail
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc: "Martin K. Petersen" <martin.petersen@oracle.com>,
	linux-block@vger.kernel.org
Content-Language: en-US
From: Kanchan Joshi <joshi.k@samsung.com>
In-Reply-To: <20251103101653.2083310-2-hch@lst.de>
Content-Transfer-Encoding: 7bit
X-CMS-MailID: 20251103111613epcas5p3289865e745e0dfea27be79ddd7f46c5e
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
cpgsPolicy: CPGSC10-542,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20251103101819epcas5p247a0968c23f2b0eea3dd7d2712de1565
References: <20251103101653.2083310-1-hch@lst.de>
	<CGME20251103101819epcas5p247a0968c23f2b0eea3dd7d2712de1565@epcas5p2.samsung.com>
	<20251103101653.2083310-2-hch@lst.de>

Reviewed-by: Kanchan Joshi <joshi.k@samsung.com>
