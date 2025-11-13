Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 080901D5ADE
	for <linux-block@vger.kernel.org>; Thu, 13 Nov 2025 05:21:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763011309; cv=none; b=Yt7XLhCdUHNdDQDWMTRz06vcxgKSVRBO+K8oOb9+tQkcBXx6reOWnJaJ0vV5++IZ6/xXuX+e3+KWIIQXA+7FKzMQclPA9zYldje2UARJzToLaOA+ZFgi9/XSOaq/0h7oj2KzPICyZKnr7cGiolHz07MhiHXK7VL/zd3GwSvSyzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763011309; c=relaxed/simple;
	bh=WQbvpfRXVaZhZ9fABl0EBrhCW18hjliCX22Xt5Hnog0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:MIME-Version:
	 Content-Type:References; b=BvEIXyEM9AHFkQPgMfdhgOTcWzzruOLsjp3ltajBwt4hdlpsePVvsG22OKdY5qUuJOwGm/ZaUIIPuxH1KpDCByNcb3w4HC+BhyZRvWNImjHFIbXDnHOB8cYiohGJiX1olzi8m4TSEBsQlVGzGyaix/L5Hv6LLE50uc3tJKRy5os=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=WbWZkh1p; arc=none smtp.client-ip=203.254.224.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="WbWZkh1p"
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
	by mailout2.samsung.com (KnoxPortal) with ESMTP id 20251113052145epoutp02d034143c6cde8c2ac3ba2926c8614556~3eXDwTZzX3199031990epoutp02c
	for <linux-block@vger.kernel.org>; Thu, 13 Nov 2025 05:21:45 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20251113052145epoutp02d034143c6cde8c2ac3ba2926c8614556~3eXDwTZzX3199031990epoutp02c
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1763011305;
	bh=WQbvpfRXVaZhZ9fABl0EBrhCW18hjliCX22Xt5Hnog0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WbWZkh1p9Lb+mJptkrpVVa+BrzPEAkeMZaYmnc19T7uqkxYt4jSAVNvCDHVgyjEAs
	 Lt0c6n6gXoqx/VSD/6PZRQGPMkFYVEUOQmDOkpfLlY8ciCUiCLpInqkSHvR3vwQtNG
	 +hJAbxNvByQ2wZh3KKFAAtZBiyBBKAg5tmL9tf4E=
Received: from epsnrtp04.localdomain (unknown [182.195.42.156]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTPS id
	20251113052144epcas5p4bc5888e8a6819e90b99cdfc500d83ec6~3eXDkz3800320803208epcas5p4v;
	Thu, 13 Nov 2025 05:21:44 +0000 (GMT)
Received: from epcas5p1.samsung.com (unknown [182.195.38.91]) by
	epsnrtp04.localdomain (Postfix) with ESMTP id 4d6TCX3ZWmz6B9mG; Thu, 13 Nov
	2025 05:21:44 +0000 (GMT)
Received: from epsmtip2.samsung.com (unknown [182.195.34.31]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
	20251113052041epcas5p4e8be496d4f6dfe193bdebd02844a42a1~3eWI7EWs40471504715epcas5p4N;
	Thu, 13 Nov 2025 05:20:41 +0000 (GMT)
Received: from node122.. (unknown [109.105.118.122]) by epsmtip2.samsung.com
	(KnoxPortal) with ESMTPA id
	20251113052041epsmtip2aac8e003f50dcdb810bc5a38a37bc79b~3eWId12_l1722617226epsmtip2j;
	Thu, 13 Nov 2025 05:20:41 +0000 (GMT)
From: Xue He <xue01.he@samsung.com>
To: yukuai@fnnas.com
Cc: akpm@linux-foundation.org, axboe@kernel.dk, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re:[PATCH] lib/sbitmap: add an helper of sbitmap_find_bits_in_word
Date: Thu, 13 Nov 2025 05:15:09 +0000
Message-Id: <20251113051509.182557-1-xue01.he@samsung.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251107054243.42628-1-xue01.he@samsung.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20251113052041epcas5p4e8be496d4f6dfe193bdebd02844a42a1
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
cpgsPolicy: CPGSC10-505,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20251113052041epcas5p4e8be496d4f6dfe193bdebd02844a42a1
References: <20251107054243.42628-1-xue01.he@samsung.com>
	<CGME20251113052041epcas5p4e8be496d4f6dfe193bdebd02844a42a1@epcas5p4.samsung.com>

Hi, sorry I didn't notice you changed your email address, here is new patch.
