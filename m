Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62A2A3AB26C
	for <linux-block@vger.kernel.org>; Fri, 24 Jul 2026 12:29:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784896186; cv=none; b=qnFkDEQVSkK3/NoeLj+ghvO27l4GPVVXFcUX3oj4VORnO4V9xeJpjcuMIh+VhHWFn3tj7UTj49QM6wqXtzKjqGULoR8rT1bT4yUtU0/nMhHh2YFKk+O6hr4KD5gxt7xpm5RiJAcnanCN+8v75sPZDGiizHukBzzo6znTtWOZIfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784896186; c=relaxed/simple;
	bh=MPy2dmqKlCsrw5okIZFwkiGzwVi0bWXg1j0NfWvMFRQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:In-Reply-To:
	 Content-Type:References; b=mvLMBcmlTANOss91IF/iwmEqOLKAmdPPbEPv2otxDadtwvYfdVH31IUCDfxEKP2BABCRtq+iiaBNXVYXForPbZZPnNpb/LLXUvWz4tO2ZDq6weZH2C3x0VyP+cOXvRSp44KgVTF1Umif8gzekwzOulF5RR7jzhxM4AcGOlxSSZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=OULIiiI2; arc=none smtp.client-ip=203.254.224.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="OULIiiI2"
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
	by mailout1.samsung.com (KnoxPortal) with ESMTP id 20260724122942epoutp01d8b0bb7549c80a5cb54c3e55b6407afe~FOZ7w51xG1118411184epoutp01f
	for <linux-block@vger.kernel.org>; Fri, 24 Jul 2026 12:29:42 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20260724122942epoutp01d8b0bb7549c80a5cb54c3e55b6407afe~FOZ7w51xG1118411184epoutp01f
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1784896182;
	bh=MPy2dmqKlCsrw5okIZFwkiGzwVi0bWXg1j0NfWvMFRQ=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=OULIiiI269+1WxJT3BSgRxZXaThIg3KzJ0Y8uSoSA5JHMoWS/WHk2mSRYypMcnLKA
	 YQRDBpQTBVsoNeyIpJ/k+Z/dThr1/xzUlXdts15RnXTgR7eqkDEMd9s2cwvO0ljL37
	 g1xiKlUA56jK0/M27xEvdiYhoz+1Zowa7A1Yu54A=
Received: from epsnrtp02.localdomain (unknown [182.195.42.154]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTPS id
	20260724122940epcas5p470a17d834a633b68f21a1a505ff45a54~FOZ6nPzM-1979419794epcas5p4m;
	Fri, 24 Jul 2026 12:29:40 +0000 (GMT)
Received: from epcas5p4.samsung.com (unknown [182.195.38.91]) by
	epsnrtp02.localdomain (Postfix) with ESMTP id 4h66kX1c0Nz2SSKZ; Fri, 24 Jul
	2026 12:29:40 +0000 (GMT)
Received: from epsmtip2.samsung.com (unknown [182.195.34.31]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
	20260724122939epcas5p10b6ca4e663c8a28da6a21f976dee3dc5~FOZ4458aG1950819508epcas5p1B;
	Fri, 24 Jul 2026 12:29:39 +0000 (GMT)
Received: from [107.122.11.51] (unknown [107.122.11.51]) by
	epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20260724122937epsmtip282d53e8241dfc2741e0011bae7490d27~FOZ3Bmc-q2587125871epsmtip2l;
	Fri, 24 Jul 2026 12:29:36 +0000 (GMT)
Message-ID: <6c122cdc-d874-48aa-bca3-686459dee84e@samsung.com>
Date: Fri, 24 Jul 2026 17:59:35 +0530
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] iomap: don't free integrity payload that doesn't
 exist
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc: "Martin K. Petersen" <martin.petersen@oracle.com>, Anuj Gupta
	<anuj20.g@samsung.com>, Christian Brauner <brauner@kernel.org>, "Darrick J.
 Wong" <djwong@kernel.org>, linux-block@vger.kernel.org,
	linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	stable@vger.kernel.org
Content-Language: en-US
From: Kanchan Joshi <joshi.k@samsung.com>
In-Reply-To: <20260724051001.202741-5-hch@lst.de>
Content-Transfer-Encoding: 7bit
X-CMS-MailID: 20260724122939epcas5p10b6ca4e663c8a28da6a21f976dee3dc5
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
cpgsPolicy: CPGSC10-542,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20260724051221epcas5p4308310d7cf98403add5912ab223419b7
References: <20260724051001.202741-1-hch@lst.de>
	<CGME20260724051221epcas5p4308310d7cf98403add5912ab223419b7@epcas5p4.samsung.com>
	<20260724051001.202741-5-hch@lst.de>

Reviewed-by: Kanchan Joshi <joshi.k@samsung.com>
