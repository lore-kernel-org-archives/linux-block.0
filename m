Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A95991A08AF
	for <linux-block@vger.kernel.org>; Wed, 27 May 2026 06:53:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779864795; cv=none; b=MCKmi8BWYoonft8l6KIZcqwhKXx6zeUIHevy2y6Qf3MPI0yNUVhquUkFBxI1J2TY6UDRcfSpG5EVUUwl10Z2yWv4mhAkjVWPBe4OVtsBBoeqCTo9XlnLhD5zY55eRl1pkp6XDxqYedjPCcF351q/Rlnbrci0LSWs7829zrknPhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779864795; c=relaxed/simple;
	bh=MrZcQktF5DW8RNK/xMx1QZYMi2nSopdUUfZAgkLoHm4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:In-Reply-To:
	 Content-Type:References; b=ZxT4btTAmt480VQ6nNlgAV9RVo5Wu9PMKzXSR3A6jxE5FWDGIxxO1jes+pDY2WcNMzJi0CAecqSTbCCE4MlfezBz/k6RAZc4CDT7zY4t0sa3YtjJfLgMyJt6PuKOWblUhR4Qxqs3oy6YYPpmnmhAVWGAnaSEUhvmYj7YxCLZbo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=GyQweJHk; arc=none smtp.client-ip=203.254.224.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="GyQweJHk"
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
	by mailout3.samsung.com (KnoxPortal) with ESMTP id 20260527065305epoutp03bdf17fcbbd3dd2fc88403396ca8b5432~zWZewVLot0360103601epoutp03U
	for <linux-block@vger.kernel.org>; Wed, 27 May 2026 06:53:05 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20260527065305epoutp03bdf17fcbbd3dd2fc88403396ca8b5432~zWZewVLot0360103601epoutp03U
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1779864785;
	bh=MrZcQktF5DW8RNK/xMx1QZYMi2nSopdUUfZAgkLoHm4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=GyQweJHktj/HHmf9Xtfk+I4oK6QGejuMSHsDamkdn5C8P66IMVcfGtRcGU16mC1GJ
	 y1F4olu8AtAvt26mOZHi712REpmrE8sevkXPW/hw9sKbfgRYJ1RWqv7aBs9or5EZXz
	 OfDrve+pOz6Iw6mhxX3mfOqkUGYso4nhTB8vEgpU=
Received: from epsnrtp02.localdomain (unknown [182.195.42.154]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTPS id
	20260527065305epcas5p23653ab432932de63119c72268beb9d00~zWZeU6McO0653306533epcas5p2F;
	Wed, 27 May 2026 06:53:05 +0000 (GMT)
Received: from epcas5p4.samsung.com (unknown [182.195.38.86]) by
	epsnrtp02.localdomain (Postfix) with ESMTP id 4gQL0w64k3z2SSKj; Wed, 27 May
	2026 06:53:04 +0000 (GMT)
Received: from epsmtip2.samsung.com (unknown [182.195.34.31]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
	20260527065304epcas5p412cc877c24f6f61ef28a22a15948036f~zWZdeIN2q1893518935epcas5p4Q;
	Wed, 27 May 2026 06:53:04 +0000 (GMT)
Received: from green245.gost (unknown [107.99.41.245]) by
	epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20260527065303epsmtip2524766d6f232760c7328418546b93657~zWZcPnS7V0130601306epsmtip2D;
	Wed, 27 May 2026 06:53:02 +0000 (GMT)
Date: Wed, 27 May 2026 12:16:34 +0530
From: Nitesh Shetty <nj.shetty@samsung.com>
To: Keith Busch <kbusch@meta.com>
Cc: linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
	axboe@kernel.dk, hch@lst.de, nilay@linux.ibm.com, Keith Busch
	<kbusch@kernel.org>
Subject: Re: [PATCHv2 2/2] nvme: add support multipath passthrough iostats
Message-ID: <20260527064634.czevilgtyivc3vto@green245.gost>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20260526153921.2402015-3-kbusch@meta.com>
X-CMS-MailID: 20260527065304epcas5p412cc877c24f6f61ef28a22a15948036f
X-Msg-Generator: CA
Content-Type: multipart/mixed;
	boundary="----Jrw9jMc8q62Q-Jc2IxP2q-7gINpdWZOCnjMJ4YRu1Wh0Ew3m=_7f909_"
CMS-TYPE: 105P
cpgsPolicy: CPGSC10-542,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20260527065304epcas5p412cc877c24f6f61ef28a22a15948036f
References: <20260526153921.2402015-1-kbusch@meta.com>
	<20260526153921.2402015-3-kbusch@meta.com>
	<CGME20260527065304epcas5p412cc877c24f6f61ef28a22a15948036f@epcas5p4.samsung.com>

------Jrw9jMc8q62Q-Jc2IxP2q-7gINpdWZOCnjMJ4YRu1Wh0Ew3m=_7f909_
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Disposition: inline

On 26/05/26 08:39AM, Keith Busch wrote:
>From: Keith Busch <kbusch@kernel.org>
>
>Don't skip io accounting for passthrough commands if the user enabled
>tracking these.
>
>Signed-off-by: Keith Busch <kbusch@kernel.org>
>---

Reviewed-by: Nitesh Shetty <nj.shetty@samsung.com>

------Jrw9jMc8q62Q-Jc2IxP2q-7gINpdWZOCnjMJ4YRu1Wh0Ew3m=_7f909_
Content-Type: text/plain; charset="utf-8"


------Jrw9jMc8q62Q-Jc2IxP2q-7gINpdWZOCnjMJ4YRu1Wh0Ew3m=_7f909_--
