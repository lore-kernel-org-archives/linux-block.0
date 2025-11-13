Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D404726E6FF
	for <linux-block@vger.kernel.org>; Thu, 13 Nov 2025 05:11:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763010715; cv=none; b=pFCH0fsAji6fM0Rl5N+4gNf1y0nAI2YUHbXLnGUMo8bqoI8HU3SkeLnBzag80/L+9B8wOU843a1oovjhkIGeeUrSjyUYDNWbs6u9/Ti4JEW4yllyMRU6WEs6LWoStQC/QiMOWqND6a7vOEBJbx2JMZPmXmHyFHycirdIpAcgE58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763010715; c=relaxed/simple;
	bh=HtLeJlOVzqIUNeAfCoizZGqwB85AEZeZ7qPsWP0odtg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:MIME-Version:
	 Content-Type:References; b=W372SQiqFAX7Ic0frzDVZlZkzKS4YcI8i+D0kX7X6D7Hj5HUOIdPTHlevmfTkmOBvZkw7aDmX4if+fQe3s88qBDrVwsM3od0iI98+dHxoPGI6J09dQCOJDRioRMjlLz/694VtAHn91M/RO+KcAc5bAEKiQdUTJT/NkbnstiCCUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=IU0NfRcX; arc=none smtp.client-ip=203.254.224.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="IU0NfRcX"
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
	by mailout2.samsung.com (KnoxPortal) with ESMTP id 20251113051140epoutp027a3b509b371e5eee82ae47b56c6afc59~3eORCmQeC2263722637epoutp02R
	for <linux-block@vger.kernel.org>; Thu, 13 Nov 2025 05:11:40 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20251113051140epoutp027a3b509b371e5eee82ae47b56c6afc59~3eORCmQeC2263722637epoutp02R
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1763010700;
	bh=HtLeJlOVzqIUNeAfCoizZGqwB85AEZeZ7qPsWP0odtg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IU0NfRcXf8lzqZrdH2gi+rPR8koYVHLejKD8DfenNmVf9TIGASXxsuKe/SslJxc0a
	 RvbLwLGyFa0bwfzcmpiUpAvNwaVCs212pHMCGiZIh3RQ1yHqhegfs0eSy3wymNLo9+
	 0z/X37TK121xQVoy1XWfimkJhGxuS6mYoh8pmvLk=
Received: from epsnrtp03.localdomain (unknown [182.195.42.155]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTPS id
	20251113051140epcas5p3ae7871ef6a91dbc95d14175d3c80f8d3~3eOQt0oP51957919579epcas5p3Y;
	Thu, 13 Nov 2025 05:11:40 +0000 (GMT)
Received: from epcas5p3.samsung.com (unknown [182.195.38.88]) by
	epsnrtp03.localdomain (Postfix) with ESMTP id 4d6Szv3c9Cz3hhT3; Thu, 13 Nov
	2025 05:11:39 +0000 (GMT)
Received: from epsmtip1.samsung.com (unknown [182.195.34.30]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
	20251113050729epcas5p402ab7841efde2458cf1667ff1e3fc55b~3eKmuwMP82731227312epcas5p4m;
	Thu, 13 Nov 2025 05:07:29 +0000 (GMT)
Received: from node122.. (unknown [109.105.118.122]) by epsmtip1.samsung.com
	(KnoxPortal) with ESMTPA id
	20251113050728epsmtip1beae7aa6172fd5675f301b1db72a3a49~3eKmGr_B00353503535epsmtip1W;
	Thu, 13 Nov 2025 05:07:28 +0000 (GMT)
From: Xue He <xue01.he@samsung.com>
To: yukuai1@huaweicloud.com, axboe@kernel.dk
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	yukuai3@huawei.com
Subject: Re:[PATCH v5] block: plug attempts to batch allocate tags multiple
 times
Date: Thu, 13 Nov 2025 05:03:00 +0000
Message-Id: <20251113050300.178228-1-xue01.he@samsung.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251107054219.42615-1-xue01.he@samsung.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20251113050729epcas5p402ab7841efde2458cf1667ff1e3fc55b
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
cpgsPolicy: CPGSC10-505,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20251113050729epcas5p402ab7841efde2458cf1667ff1e3fc55b
References: <20251107054219.42615-1-xue01.he@samsung.com>
	<CGME20251113050729epcas5p402ab7841efde2458cf1667ff1e3fc55b@epcas5p4.samsung.com>

Hi, just a kindly ping......
