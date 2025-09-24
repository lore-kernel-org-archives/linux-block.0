Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B61AA2D9EE1
	for <linux-block@vger.kernel.org>; Wed, 24 Sep 2025 13:54:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758722067; cv=none; b=WKRfu7r2VwWjYbg/Ju1D8aDiYjASugOdMVeMKP+1xV160qrqSxltR2U6KH3XM3h75L74EhXEAhurQgiE6kWkNGPjbrvFvGLs5Ei9mXaRnpz2/S0WFa+GF0YNqytuMrtC++Nh8Rolio8k/ICH9Q8qXsBINeMjv9762KFJgKwjLzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758722067; c=relaxed/simple;
	bh=Qn/EJ/wI+telkDpzU5fKmVPa80PL9bwwbeT6wzKvHoQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:MIME-Version:
	 Content-Type:References; b=rzy4L9wQeN1t2kWCueRnv9uDmEIYXCo0K8pEloHXzA7jCtcbOexIMy1C0sTBWskEaaBZoskwtbPw0NFY7KBNA5UdP5xnl0R9C4iKHDXS9AEfk9ijbUe//r22uGSEo+r/pooZ4StD5qrkI2VnC0jlCLO6ijk4yb6sYg0vQyQQJ+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=XVz+cGxA; arc=none smtp.client-ip=203.254.224.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="XVz+cGxA"
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
	by mailout3.samsung.com (KnoxPortal) with ESMTP id 20250924135423epoutp03e0b323f5a6b11743442938f8a82b5ef6~oPGYa-xHd2368423684epoutp03V
	for <linux-block@vger.kernel.org>; Wed, 24 Sep 2025 13:54:23 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20250924135423epoutp03e0b323f5a6b11743442938f8a82b5ef6~oPGYa-xHd2368423684epoutp03V
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1758722063;
	bh=ovnF6OfTXYKDWILIVkUvwa7/ZYS2a3/Q5l8vUa0/x0s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XVz+cGxAt+LsnaJfl3N/pCL+jnPwY/1Sq/bQimYzIxe4aCM9wdJtR2CYfSeQy2OGy
	 SBNguVTVwbcE8R291e5Er6xyk5Y8ws644Hp+P7t6cc4arjHHFDdJINOxxsl/fIoH9g
	 7nKQqHHpipfkNqf2oYCaDRWggN4whjXQjqnvfw1Q=
Received: from epsnrtp03.localdomain (unknown [182.195.42.155]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTPS id
	20250924135423epcas5p396bd11636c235766a4b781fc4e6aeeae~oPGYAETgS0085700857epcas5p3F;
	Wed, 24 Sep 2025 13:54:23 +0000 (GMT)
Received: from epcas5p1.samsung.com (unknown [182.195.38.93]) by
	epsnrtp03.localdomain (Postfix) with ESMTP id 4cWyy620srz3hhT7; Wed, 24 Sep
	2025 13:54:22 +0000 (GMT)
Received: from epsmtip1.samsung.com (unknown [182.195.34.30]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
	20250924114923epcas5p24d397694d8ce433d126136b79f3fd21d~oNZPk2W901762517625epcas5p2w;
	Wed, 24 Sep 2025 11:49:23 +0000 (GMT)
Received: from node122.. (unknown [109.105.118.122]) by epsmtip1.samsung.com
	(KnoxPortal) with ESMTPA id
	20250924114922epsmtip1841610c5812a14f8e43398633e0abaea~oNZOXFmTw1007810078epsmtip1B;
	Wed, 24 Sep 2025 11:49:22 +0000 (GMT)
From: Xue He <xue01.he@samsung.com>
To: yukuai1@huaweicloud.com
Cc: akpm@linux-foundation.org, axboe@kernel.dk, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, xue01.he@samsung.com, yukuai3@huawei.com
Subject: Re: [PATCH] block: plug attempts to batch allocate tags multiple
 times
Date: Wed, 24 Sep 2025 11:44:53 +0000
Message-Id: <20250924114453.5587-1-xue01.he@samsung.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <7626767b-35c1-4c55-399c-24e21ec81ced@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20250924114923epcas5p24d397694d8ce433d126136b79f3fd21d
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
cpgsPolicy: CPGSC10-505,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20250924114923epcas5p24d397694d8ce433d126136b79f3fd21d
References: <7626767b-35c1-4c55-399c-24e21ec81ced@huaweicloud.com>
	<CGME20250924114923epcas5p24d397694d8ce433d126136b79f3fd21d@epcas5p2.samsung.com>

On 2025/09/24 18:23, Yu Kuai wrote:
>On 2025/09/18 15:55, Xue He write:
>Hi,
>
>I'm not in the cc list, so it can take sometime before I notice this
>patch.

Oh sorry I missed this, I'll add you in cc list, and resend the v3 patch,
thank you. 
