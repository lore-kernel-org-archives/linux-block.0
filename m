Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93ABB3016F3
	for <linux-block@vger.kernel.org>; Thu, 13 Nov 2025 05:11:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763010712; cv=none; b=QXiZaR/ELmdAF2qt2p2q48pwYhteCJMx4HUkvRhgacYdPuU20Hqwbl7y1LeT4rWtva/J0HKonUbmdjEAIS4ELsjityo1TvAogU6XvO7GKSQVG6CsT5APJ7WKayNsDhuBYy0vz/vNd2ni77u3XoA6yXq27JsONoxc0945lQIrh3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763010712; c=relaxed/simple;
	bh=HtLeJlOVzqIUNeAfCoizZGqwB85AEZeZ7qPsWP0odtg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:MIME-Version:
	 Content-Type:References; b=klAsWgbQJQAywyxiPWydgb3/GxfR0umCVk/y24sc5m0+mg2TNzts1v1HPaWjz286zeCe4bxCSKPv/sdeKSf9kzlwG8O/iyDYzoXTX0dLwMqV7UMpYmEu7MrPijjKp/qt7i2auA6VZV7D6pY+aV4DTAuqvkbm9S5B8dEFxDozZ8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=sjHbRxx7; arc=none smtp.client-ip=203.254.224.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="sjHbRxx7"
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
	by mailout4.samsung.com (KnoxPortal) with ESMTP id 20251113051142epoutp04e72e1cd6be29f84ba41fe144338f13a6~3eOS25ss00549305493epoutp04_
	for <linux-block@vger.kernel.org>; Thu, 13 Nov 2025 05:11:42 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20251113051142epoutp04e72e1cd6be29f84ba41fe144338f13a6~3eOS25ss00549305493epoutp04_
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1763010702;
	bh=HtLeJlOVzqIUNeAfCoizZGqwB85AEZeZ7qPsWP0odtg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sjHbRxx7/F6Xy4GXOyw9dVkSw/x8Wi6vsKVsMhV9WLPgMhIbBpli4RFyGD7NXarb0
	 ZyunW0TuiEX6WDBb/k7P80EqeEFUWrmZ0iqMxvCoRE6D80KDh5rVN2wipLbrgZCauI
	 Hk1varr8eIXdXEv8zga1U90ZuFXrs2DRrMAmujxo=
Received: from epsnrtp04.localdomain (unknown [182.195.42.156]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTPS id
	20251113051142epcas5p11367acad563d078912fea5f9793f482c~3eOSn_V0l2992829928epcas5p1T;
	Thu, 13 Nov 2025 05:11:42 +0000 (GMT)
Received: from epcas5p3.samsung.com (unknown [182.195.38.90]) by
	epsnrtp04.localdomain (Postfix) with ESMTP id 4d6Szx5RG7z6B9m8; Thu, 13 Nov
	2025 05:11:41 +0000 (GMT)
Received: from epsmtip1.samsung.com (unknown [182.195.34.30]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
	20251113051037epcas5p2c4a88ad26b9a7ece54b0faa635a84610~3eNV8v-vP2276322763epcas5p2m;
	Thu, 13 Nov 2025 05:10:37 +0000 (GMT)
Received: from node122.. (unknown [109.105.118.122]) by epsmtip1.samsung.com
	(KnoxPortal) with ESMTPA id
	20251113051036epsmtip193846bf7a880015303836ef9936b32d0~3eNVOX4i50934409344epsmtip1M;
	Thu, 13 Nov 2025 05:10:36 +0000 (GMT)
From: Xue He <xue01.he@samsung.com>
To: yukuai1@huaweicloud.com, akpm@linux-foundation.org, axboe@kernel.dk
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	yukuai3@huawei.com
Subject: Re:[PATCH] lib/sbitmap: add an helper of sbitmap_find_bits_in_word
Date: Thu, 13 Nov 2025 05:06:06 +0000
Message-Id: <20251113050606.179345-1-xue01.he@samsung.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251107054243.42628-1-xue01.he@samsung.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20251113051037epcas5p2c4a88ad26b9a7ece54b0faa635a84610
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
cpgsPolicy: CPGSC10-505,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20251113051037epcas5p2c4a88ad26b9a7ece54b0faa635a84610
References: <20251107054243.42628-1-xue01.he@samsung.com>
	<CGME20251113051037epcas5p2c4a88ad26b9a7ece54b0faa635a84610@epcas5p2.samsung.com>

Hi, just a kindly ping......
