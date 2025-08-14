Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 178D8310778
	for <linux-block@vger.kernel.org>; Thu, 14 Aug 2025 10:17:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755166657; cv=none; b=K50DWZRvHHkh53bQrRZxRQ8LBorIQumJcb+iBhQg48boFO1oC3srKUBFDg0ZVvK1Ri2lxaYWDaLTcG1WX4IPb8rgjHUdufZWIcAHgbIaabbpQfd0LqEx3xJJ8BnJ4ANp9N4EG/b8TptayITKJgZTSYa3U03afVZv5G7SrREa72s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755166657; c=relaxed/simple;
	bh=MPy2dmqKlCsrw5okIZFwkiGzwVi0bWXg1j0NfWvMFRQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:In-Reply-To:
	 Content-Type:References; b=f5Lq75LtW3Az22NBi/0+g3VL2LhR4VFriU3GpkjvDbU63q6wF7oWEAfyE7hwh0v1JwekAPsToF5dGWJUmBCTtCljObTB+1ZD8dj8a8zO9ijseQyslb6FQIpTm+RgJfO7LroKCyi3rC83IjLF50aYDOZbsneuaiF+hzadg8jE82o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=gDWd+Q06; arc=none smtp.client-ip=203.254.224.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="gDWd+Q06"
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
	by mailout1.samsung.com (KnoxPortal) with ESMTP id 20250814101732epoutp014a3313d718491d2d88721c53db64914a~bmsWAcHaN2219422194epoutp01s
	for <linux-block@vger.kernel.org>; Thu, 14 Aug 2025 10:17:32 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20250814101732epoutp014a3313d718491d2d88721c53db64914a~bmsWAcHaN2219422194epoutp01s
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1755166652;
	bh=MPy2dmqKlCsrw5okIZFwkiGzwVi0bWXg1j0NfWvMFRQ=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=gDWd+Q06QXSORMGzRq6uIimPO5t2altkJgjKY0dVhcleqWtI09A1cXSEF0bcHY9cu
	 pKgcJexG0s1uL95q95j4xpF2J2pBAiSE04i8HI35oaHiB/di1LC20HCx4wV+5TFz2D
	 WLAQRqGzwwF/oybPw6yYBgSbr3TazyEOmciGpq3U=
Received: from epsnrtp02.localdomain (unknown [182.195.42.154]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTPS id
	20250814101732epcas5p3b4f3470beaac99f7db14a82f3dbaac24~bmsVziEsj3091930919epcas5p3x;
	Thu, 14 Aug 2025 10:17:32 +0000 (GMT)
Received: from epcas5p2.samsung.com (unknown [182.195.38.93]) by
	epsnrtp02.localdomain (Postfix) with ESMTP id 4c2h4r155Nz2SSKb; Thu, 14 Aug
	2025 10:17:32 +0000 (GMT)
Received: from epsmtip2.samsung.com (unknown [182.195.34.31]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
	20250814101731epcas5p3e35e879da59d3431fe098666efe81d3f~bmsUtw--X3199631996epcas5p3h;
	Thu, 14 Aug 2025 10:17:31 +0000 (GMT)
Received: from [107.122.11.51] (unknown [107.122.11.51]) by
	epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20250814101730epsmtip240974655840b18cd4da448029040835f~bmsT1bZPM0692206922epsmtip2r;
	Thu, 14 Aug 2025 10:17:30 +0000 (GMT)
Message-ID: <09b6a041-2011-4b2b-aff6-2e25bb9125a3@samsung.com>
Date: Thu, 14 Aug 2025 15:47:29 +0530
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv7 1/9] blk-mq-dma: create blk_map_iter type
To: Keith Busch <kbusch@meta.com>, linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org
Cc: hch@lst.de, axboe@kernel.dk, Keith Busch <kbusch@kernel.org>
Content-Language: en-US
From: Kanchan Joshi <joshi.k@samsung.com>
In-Reply-To: <20250813153153.3260897-2-kbusch@meta.com>
Content-Transfer-Encoding: 7bit
X-CMS-MailID: 20250814101731epcas5p3e35e879da59d3431fe098666efe81d3f
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
cpgsPolicy: CPGSC10-542,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20250813153222epcas5p49a56589a697f9ba0482a353450f78494
References: <20250813153153.3260897-1-kbusch@meta.com>
	<CGME20250813153222epcas5p49a56589a697f9ba0482a353450f78494@epcas5p4.samsung.com>
	<20250813153153.3260897-2-kbusch@meta.com>

Reviewed-by: Kanchan Joshi <joshi.k@samsung.com>
