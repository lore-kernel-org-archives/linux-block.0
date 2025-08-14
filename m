Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB49131813E
	for <linux-block@vger.kernel.org>; Thu, 14 Aug 2025 10:19:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755166783; cv=none; b=hfmuKhWd75nOcGqBpvlkkDhd63LIB7TE5BDLmDzVY1o0E+PgC0XzA9SR//wPG696j0nSCVTDqUwEVq8F+rWM+LKvXqpQHiYHrOTMz8G7dzkZnyvi5wYouKCaVx5w7gXS5vzuIZRGP/ByloVtTJjgO3tK2dVeT39GKJJqqQUPpx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755166783; c=relaxed/simple;
	bh=MPy2dmqKlCsrw5okIZFwkiGzwVi0bWXg1j0NfWvMFRQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:In-Reply-To:
	 Content-Type:References; b=BTtqapN6aH4bMCJtoV38LQDsVdypWjM4eOjjYtAGFDHVfimUvTYpZ7ogHKf9rvxAeUL4bsaglHsL8p2A/oGqvjON2/g6i47+myePgxuauEQvSeQ9Vus4QvBTkUzigIGlPf1hjvC4xP0ituSVucIbvnePXBBZqrzdp8G8unyHgwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=pYqJrBUL; arc=none smtp.client-ip=203.254.224.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="pYqJrBUL"
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
	by mailout1.samsung.com (KnoxPortal) with ESMTP id 20250814101940epoutp01b643cbdd82b3553ab1e01da4b15eb234~bmuMeBHaX2245122451epoutp01U
	for <linux-block@vger.kernel.org>; Thu, 14 Aug 2025 10:19:40 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20250814101940epoutp01b643cbdd82b3553ab1e01da4b15eb234~bmuMeBHaX2245122451epoutp01U
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1755166780;
	bh=MPy2dmqKlCsrw5okIZFwkiGzwVi0bWXg1j0NfWvMFRQ=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=pYqJrBUL0SizX3ulNSz+++WbY8jL2rtkfSGw1UYtXjyPz9rM8d07O6ULwCMbdBx8K
	 bvIgKgHQ1EudNgH8BXbA8/WAZ/nn5qeuNVGBXrb4rULQa7VZkkg4tIDzQuJLcm9/tn
	 7RV0eOmDoioHsHrr3ZGSzHZE2OJMa5zWNmobIlAI=
Received: from epsnrtp02.localdomain (unknown [182.195.42.154]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTPS id
	20250814101939epcas5p13414b84e40dd8a4c18acd68113da9556~bmuMEeR2Q2712427124epcas5p1X;
	Thu, 14 Aug 2025 10:19:39 +0000 (GMT)
Received: from epcas5p4.samsung.com (unknown [182.195.38.89]) by
	epsnrtp02.localdomain (Postfix) with ESMTP id 4c2h7G6WsJz2SSKg; Thu, 14 Aug
	2025 10:19:38 +0000 (GMT)
Received: from epsmtip2.samsung.com (unknown [182.195.34.31]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
	20250814101938epcas5p1ce0b49e258d364f291d60e4205d6f986~bmuK1tAnt3078130781epcas5p1b;
	Thu, 14 Aug 2025 10:19:38 +0000 (GMT)
Received: from [107.122.11.51] (unknown [107.122.11.51]) by
	epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20250814101937epsmtip254567898b8b94fa7c76ed676c70bfe35~bmuKAOqNS0840808408epsmtip2F;
	Thu, 14 Aug 2025 10:19:37 +0000 (GMT)
Message-ID: <9deaa7f5-7142-4ba5-a17a-2f0ffc84df3c@samsung.com>
Date: Thu, 14 Aug 2025 15:49:36 +0530
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv7 5/9] blk-mq-dma: move common dma start code to a
 helper
To: Keith Busch <kbusch@meta.com>, linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org
Cc: hch@lst.de, axboe@kernel.dk, Keith Busch <kbusch@kernel.org>
Content-Language: en-US
From: Kanchan Joshi <joshi.k@samsung.com>
In-Reply-To: <20250813153153.3260897-6-kbusch@meta.com>
Content-Transfer-Encoding: 7bit
X-CMS-MailID: 20250814101938epcas5p1ce0b49e258d364f291d60e4205d6f986
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
cpgsPolicy: CPGSC10-542,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20250813153730epcas5p3b207c1ce658df5a5f5527611540e8362
References: <20250813153153.3260897-1-kbusch@meta.com>
	<CGME20250813153730epcas5p3b207c1ce658df5a5f5527611540e8362@epcas5p3.samsung.com>
	<20250813153153.3260897-6-kbusch@meta.com>

Reviewed-by: Kanchan Joshi <joshi.k@samsung.com>
