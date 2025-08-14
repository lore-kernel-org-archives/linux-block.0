Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9135E318125
	for <linux-block@vger.kernel.org>; Thu, 14 Aug 2025 10:19:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755166748; cv=none; b=PtsXmcfMeY8uZWFoZWhCGm+wpe2+Bi+ka0+/nLLhLjaud8WfeWSv4lqvcuIRI1vjzUsHALNgch2zh+zhCjuQVrFRyJH9T3upI4oCAETt9kg8NJi7InlLKD7bsgq0EmnkekbkKPFa6UaDzk/5TOPcTVGXRO/EdX+hjW/VYDSzS1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755166748; c=relaxed/simple;
	bh=MPy2dmqKlCsrw5okIZFwkiGzwVi0bWXg1j0NfWvMFRQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:In-Reply-To:
	 Content-Type:References; b=BeeAil56f/X//aS+gf8mz+8J9cFJx8Sx7f52YgXOv+P3U4Eobh14v52yqCXA/VnLr0c5rcTph5mY7nesYQL1jvHrf4Bl2XhfBr66AleAkCh7i9mZN9nGqNQY5WOF5w4RmfCmhIx63CFD9atAfnj8CHxraiM8L+ZwgykVhsX0138=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=KRm9SZuH; arc=none smtp.client-ip=203.254.224.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="KRm9SZuH"
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
	by mailout3.samsung.com (KnoxPortal) with ESMTP id 20250814101904epoutp03411e2c3dedfbada10f4c80f279c53ede~bmtreHJp20258302583epoutp03g
	for <linux-block@vger.kernel.org>; Thu, 14 Aug 2025 10:19:04 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20250814101904epoutp03411e2c3dedfbada10f4c80f279c53ede~bmtreHJp20258302583epoutp03g
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1755166744;
	bh=MPy2dmqKlCsrw5okIZFwkiGzwVi0bWXg1j0NfWvMFRQ=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=KRm9SZuHBOVsFXAPjbcBWiYNxbyOLjoQpbc1oXnG6nj7R9mMmT9exP0xg0/cOD0ab
	 npMikj0Ya3Lzf5T5bp2WnPtwMGWe+fwtE0ok5xJj+zpfigS0qEgwMyhnD/hnji/UtI
	 YFq6W0SQrV3PSGn6S3YRTMCebIfvqm4DO37yKAMA=
Received: from epsnrtp01.localdomain (unknown [182.195.42.153]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTPS id
	20250814101903epcas5p1fb57ac49a123584de124e99553427e3d~bmtqyRzr51323713237epcas5p1X;
	Thu, 14 Aug 2025 10:19:03 +0000 (GMT)
Received: from epcas5p3.samsung.com (unknown [182.195.38.93]) by
	epsnrtp01.localdomain (Postfix) with ESMTP id 4c2h6b3Hpjz6B9mB; Thu, 14 Aug
	2025 10:19:03 +0000 (GMT)
Received: from epsmtip2.samsung.com (unknown [182.195.34.31]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
	20250814101903epcas5p42d87b111af021856d5f2a228164b2706~bmtqAslX_3044630446epcas5p47;
	Thu, 14 Aug 2025 10:19:03 +0000 (GMT)
Received: from [107.122.11.51] (unknown [107.122.11.51]) by
	epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20250814101902epsmtip2c41dd11d771c993a9e159c6a87857bcb~bmtpLjtWd0731907319epsmtip2R;
	Thu, 14 Aug 2025 10:19:02 +0000 (GMT)
Message-ID: <96e4c31a-6184-4456-b2e9-a5bb61cfc93c@samsung.com>
Date: Thu, 14 Aug 2025 15:49:01 +0530
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv7 4/9] blk-mq: remove REQ_P2PDMA flag
To: Keith Busch <kbusch@meta.com>, linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org
Cc: hch@lst.de, axboe@kernel.dk, Keith Busch <kbusch@kernel.org>
Content-Language: en-US
From: Kanchan Joshi <joshi.k@samsung.com>
In-Reply-To: <20250813153153.3260897-5-kbusch@meta.com>
Content-Transfer-Encoding: 7bit
X-CMS-MailID: 20250814101903epcas5p42d87b111af021856d5f2a228164b2706
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
cpgsPolicy: CPGSC10-542,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20250813153223epcas5p4f1ee75d1bfb98a338ffe65348631b731
References: <20250813153153.3260897-1-kbusch@meta.com>
	<CGME20250813153223epcas5p4f1ee75d1bfb98a338ffe65348631b731@epcas5p4.samsung.com>
	<20250813153153.3260897-5-kbusch@meta.com>

Reviewed-by: Kanchan Joshi <joshi.k@samsung.com>
