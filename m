Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF9A4318126
	for <linux-block@vger.kernel.org>; Thu, 14 Aug 2025 10:18:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755166686; cv=none; b=WgTz26H7zh7IL8xiff3BzVtShG57mJ8lQJt7wEg2HFsl7ab61CjmYDMdSN0owsebG1bwbysZa057lYAbHcEKqR8UDfho0sgKJ3C9CX74Q+67fAy5TMh26qwYpImrzmv0SAQkDmZ+jXs9Fw8neJwZumKqHSIJ1KI5E3VwpPe69uQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755166686; c=relaxed/simple;
	bh=MPy2dmqKlCsrw5okIZFwkiGzwVi0bWXg1j0NfWvMFRQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:In-Reply-To:
	 Content-Type:References; b=ZsBVL1xcMOU4fy6OJoiuuknd+qDBDBMQ2n5uWPMP5wDwFZU0sD/LCoz4cMsu7nxCmZ7q0HtRurxV+FLBt4OQhIjBGJXI5AoWI0RRFGr9e2YJ1GeH8bO6KjS28UXYKAWSD+r5cwSQTnPQJSVgh0bA+ItifOubJ6IfUul6M5guINw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=p/iMwl8W; arc=none smtp.client-ip=203.254.224.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="p/iMwl8W"
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
	by mailout3.samsung.com (KnoxPortal) with ESMTP id 20250814101802epoutp0320617bd66302fe6ac1e3f600ec5de6dc~bmsx5cVDD0252702527epoutp03s
	for <linux-block@vger.kernel.org>; Thu, 14 Aug 2025 10:18:02 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20250814101802epoutp0320617bd66302fe6ac1e3f600ec5de6dc~bmsx5cVDD0252702527epoutp03s
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1755166682;
	bh=MPy2dmqKlCsrw5okIZFwkiGzwVi0bWXg1j0NfWvMFRQ=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=p/iMwl8WRiKK20aKvvNVks9OQM5jZmGTFIRi6rOohBHyuLIIYracWUDS3pS13Gm47
	 m/GnQjyzoAYmU9f6vwqr37+RQcE/jOblxbnGhs4PHY1ngk5cbA3XChjbbChGWdx7Dz
	 AnNaSPlrEtTcui4UP93hUETO4RQj0ltXluQTqBdc=
Received: from epsnrtp02.localdomain (unknown [182.195.42.154]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTPS id
	20250814101802epcas5p3d52659ba0690d317226906d2f82b8435~bmsxgaxND1763617636epcas5p3D;
	Thu, 14 Aug 2025 10:18:02 +0000 (GMT)
Received: from epcas5p3.samsung.com (unknown [182.195.38.92]) by
	epsnrtp02.localdomain (Postfix) with ESMTP id 4c2h5P4gnjz2SSKX; Thu, 14 Aug
	2025 10:18:01 +0000 (GMT)
Received: from epsmtip1.samsung.com (unknown [182.195.34.30]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
	20250814101801epcas5p45dd331437f58bf8471ca3b31d29ce377~bmswVmCEl1575315753epcas5p4N;
	Thu, 14 Aug 2025 10:18:01 +0000 (GMT)
Received: from [107.122.11.51] (unknown [107.122.11.51]) by
	epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20250814101800epsmtip14995173e0b70524de737c14130df23cd~bmsveYB5f1533815338epsmtip1J;
	Thu, 14 Aug 2025 10:18:00 +0000 (GMT)
Message-ID: <fa08192a-6fb2-4ac4-a426-a70adf20b9de@samsung.com>
Date: Thu, 14 Aug 2025 15:47:59 +0530
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv7 2/9] blk-mq-dma: provide the bio_vec array being
 iterated
To: Keith Busch <kbusch@meta.com>, linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org
Cc: hch@lst.de, axboe@kernel.dk, Keith Busch <kbusch@kernel.org>
Content-Language: en-US
From: Kanchan Joshi <joshi.k@samsung.com>
In-Reply-To: <20250813153153.3260897-3-kbusch@meta.com>
Content-Transfer-Encoding: 7bit
X-CMS-MailID: 20250814101801epcas5p45dd331437f58bf8471ca3b31d29ce377
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
cpgsPolicy: CPGSC10-542,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20250813153211epcas5p43fa34d5d05a24e605eb1884f601ecbde
References: <20250813153153.3260897-1-kbusch@meta.com>
	<CGME20250813153211epcas5p43fa34d5d05a24e605eb1884f601ecbde@epcas5p4.samsung.com>
	<20250813153153.3260897-3-kbusch@meta.com>

Reviewed-by: Kanchan Joshi <joshi.k@samsung.com>
