Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73E2B30E82A
	for <linux-block@vger.kernel.org>; Thu, 13 Nov 2025 05:22:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763011376; cv=none; b=Mt+mWVnmpcJVUbBYyEqBGLG2iuGRfG90soJeFG84KoGwFlgEldc/nCkdssjgIeXmBRm8f0gIoQItNBy++KmArUZ2l4NW/CqwHg2NQaFepDzyIE9N1s2OypUJsgxPBYapMg6GMvdhhiqtVKgG07Z3qFT7sc3+kCDUN2BW+FlTI6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763011376; c=relaxed/simple;
	bh=PZl6EEVVkEhJaOGfh8QRw+p43fU7fx801+XUDV+dF4c=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:MIME-Version:
	 Content-Type:References; b=vAbQng5G97V8KPpb89gLUTv+wMObQfuQTLXtWtuqOEGLjAUSZtwO4+4HmNbxHIC7HAs4FhQHSVl0tkQA0T0JbA3njtT/4SUAgGcU5unBsEv6VfpzMW6ARH3uhAPBGzGZtdKYIcnWvSDLYeBqok8UK6zseN3cc1Fr4gssibSoybc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=SwuTZC6R; arc=none smtp.client-ip=203.254.224.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="SwuTZC6R"
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
	by mailout2.samsung.com (KnoxPortal) with ESMTP id 20251113052252epoutp023251c26990f53473b6c4d1c0ef064311~3eYChtstR3136531365epoutp02N
	for <linux-block@vger.kernel.org>; Thu, 13 Nov 2025 05:22:52 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20251113052252epoutp023251c26990f53473b6c4d1c0ef064311~3eYChtstR3136531365epoutp02N
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1763011372;
	bh=PZl6EEVVkEhJaOGfh8QRw+p43fU7fx801+XUDV+dF4c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SwuTZC6Rzpq/2eF2xuybehrgLWBsQDa7hZ2SnfHzZU4Q5RPcj0HTHHN7dg8I9Iu5P
	 LlmdjCfuJ6CzNDHpYP4dNT7+yj+DHBIACPXoQElHL7jufj+iILb36ShmEBUvLHaZ1m
	 ADh5bDZPFFCfCJbuP8hu6ksE327nSiGV00M0yLWo=
Received: from epsnrtp02.localdomain (unknown [182.195.42.154]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTPS id
	20251113052252epcas5p145773d8a7981bf0cd7e405c6e3b78532~3eYCWog-S2495624956epcas5p1F;
	Thu, 13 Nov 2025 05:22:52 +0000 (GMT)
Received: from epcas5p2.samsung.com (unknown [182.195.38.87]) by
	epsnrtp02.localdomain (Postfix) with ESMTP id 4d6TDq2BvSz2SSKY; Thu, 13 Nov
	2025 05:22:51 +0000 (GMT)
Received: from epsmtip2.samsung.com (unknown [182.195.34.31]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
	20251113052231epcas5p4b02eb55dc591ce7de6db0341052f8cef~3eXvHozNI1807418074epcas5p4V;
	Thu, 13 Nov 2025 05:22:31 +0000 (GMT)
Received: from node122.. (unknown [109.105.118.122]) by epsmtip2.samsung.com
	(KnoxPortal) with ESMTPA id
	20251113052231epsmtip28abc8e9c82b11ecc6f345a53c3d4fcc4~3eXuoUTW-1768317683epsmtip2t;
	Thu, 13 Nov 2025 05:22:31 +0000 (GMT)
From: Xue He <xue01.he@samsung.com>
To: yukuai@fnnas.com
Cc: axboe@kernel.dk, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v5] block: plug attempts to batch allocate tags multiple
 times
Date: Thu, 13 Nov 2025 05:18:03 +0000
Message-Id: <20251113051803.183585-1-xue01.he@samsung.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251107054219.42615-1-xue01.he@samsung.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20251113052231epcas5p4b02eb55dc591ce7de6db0341052f8cef
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
cpgsPolicy: CPGSC10-505,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20251113052231epcas5p4b02eb55dc591ce7de6db0341052f8cef
References: <20251107054219.42615-1-xue01.he@samsung.com>
	<CGME20251113052231epcas5p4b02eb55dc591ce7de6db0341052f8cef@epcas5p4.samsung.com>

Hi Yu Kuai, sorry I didn't notice you changed your email address, here is new patch.
