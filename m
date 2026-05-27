Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F40533ACEF4
	for <linux-block@vger.kernel.org>; Wed, 27 May 2026 06:53:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779864820; cv=none; b=CRYk4NgtrmPsIjtUQrjOyIi9odyCrBl2AluedwUtdTr1ErvRTwM7IORN5yJVWmichys3JQRAEpDC178KF+iiCzYhEre5ws22ZTsYzaka6vura0TJWfA7DgTesD1x+fOGKziB20TyqkXGfzfnzmyO7q135/rY6Nc5aOdC8kNsa9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779864820; c=relaxed/simple;
	bh=l59s0fNAl4RuOQhAf+XFh+T2wNDwWFyo+YhMvt+Ib+s=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:In-Reply-To:
	 Content-Type:References; b=accyVpmKVwBDaYV/MxhCjIRjfdbQcomdzVC/ZRto3/TzDh/YSLpBEWPwKN/2X6jnaJIRS8rUyXmlu+Q7Puu7GIAtOodQD0AON7ayyH4axjj0vzNSa7e2KGC3xOU2qp/Dzxf1A2eosit5NYBohAtTCPpxLaEuBOwY9NYFAldCGaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=bpHalGQv; arc=none smtp.client-ip=203.254.224.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="bpHalGQv"
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
	by mailout4.samsung.com (KnoxPortal) with ESMTP id 20260527065331epoutp0492fad3eac8d71739c757b9d58a91d8aa~zWZ2lTnk91401914019epoutp04e
	for <linux-block@vger.kernel.org>; Wed, 27 May 2026 06:53:31 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20260527065331epoutp0492fad3eac8d71739c757b9d58a91d8aa~zWZ2lTnk91401914019epoutp04e
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1779864811;
	bh=l59s0fNAl4RuOQhAf+XFh+T2wNDwWFyo+YhMvt+Ib+s=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=bpHalGQv+/gAmHfsXMblGC13fBalRHgwci/qMIdZAB/cTHwgrs6nDxqomSeYYc1cv
	 k0g5MntVKoL6aeNFIvlGOq03HrzLfXr1JE7rdz+YBuQWPkZT+Ss8s2YyTyd729v134
	 40fRHtPN0kck6o21YITyf5ki10gXERc65JH39jEE=
Received: from epsnrtp03.localdomain (unknown [182.195.42.155]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTPS id
	20260527065330epcas5p114007b29d70e82c524822093cc216ad3~zWZ2Fjrcs1217812178epcas5p10;
	Wed, 27 May 2026 06:53:30 +0000 (GMT)
Received: from epcas5p4.samsung.com (unknown [182.195.38.86]) by
	epsnrtp03.localdomain (Postfix) with ESMTP id 4gQL1P5ZDZz3hhTL; Wed, 27 May
	2026 06:53:29 +0000 (GMT)
Received: from epsmtip2.samsung.com (unknown [182.195.34.31]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
	20260527065329epcas5p35d3e652004e6d1da9ab7abf4951cb806~zWZ0seu6N0256402564epcas5p3B;
	Wed, 27 May 2026 06:53:29 +0000 (GMT)
Received: from green245.gost (unknown [107.99.41.245]) by
	epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20260527065328epsmtip242fea4b9fbe9b6fc797f313783452c60~zWZzmL39C0795807958epsmtip2k;
	Wed, 27 May 2026 06:53:27 +0000 (GMT)
Date: Wed, 27 May 2026 12:16:59 +0530
From: Nitesh Shetty <nj.shetty@samsung.com>
To: Keith Busch <kbusch@meta.com>
Cc: linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
	axboe@kernel.dk, hch@lst.de, nilay@linux.ibm.com, Keith Busch
	<kbusch@kernel.org>
Subject: Re: [PATCHv2 1/2] block: export passthrough stats enabled
Message-ID: <20260527064659.ulxmr4sq3bqkjv2h@green245.gost>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20260526153921.2402015-2-kbusch@meta.com>
X-CMS-MailID: 20260527065329epcas5p35d3e652004e6d1da9ab7abf4951cb806
X-Msg-Generator: CA
Content-Type: multipart/mixed;
	boundary="----NsOwSKzRCMo1F7NCLP8h0BXJf.fS38eRA1mrMVinGGpiNbWw=_7f61b_"
CMS-TYPE: 105P
cpgsPolicy: CPGSC10-542,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20260527065329epcas5p35d3e652004e6d1da9ab7abf4951cb806
References: <20260526153921.2402015-1-kbusch@meta.com>
	<20260526153921.2402015-2-kbusch@meta.com>
	<CGME20260527065329epcas5p35d3e652004e6d1da9ab7abf4951cb806@epcas5p3.samsung.com>

------NsOwSKzRCMo1F7NCLP8h0BXJf.fS38eRA1mrMVinGGpiNbWw=_7f61b_
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Disposition: inline

On 26/05/26 08:39AM, Keith Busch wrote:
>From: Keith Busch <kbusch@kernel.org>
>
>A user can enable io accounting for passthrough requests, so export the
>helper that checks if the request should be tracked. This will enable
>stacking drivers to to report iostats for passthrough workloads.
>
>Signed-off-by: Keith Busch <kbusch@kernel.org>

Reviewed-by: Nitesh Shetty <nj.shetty@samsung.com>

------NsOwSKzRCMo1F7NCLP8h0BXJf.fS38eRA1mrMVinGGpiNbWw=_7f61b_
Content-Type: text/plain; charset="utf-8"


------NsOwSKzRCMo1F7NCLP8h0BXJf.fS38eRA1mrMVinGGpiNbWw=_7f61b_--
