Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A105B2DAFA7
	for <linux-block@vger.kernel.org>; Tue, 18 Nov 2025 05:22:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763443372; cv=none; b=uzr/Wl/sswWXQbTI68CZpGXms9D/NFfKX5iZMRz/FtedYLTZi+0o/ZIiEYFVwWyjkCcgtJdhjxwW2mpcE72znmS+8xPQ+bhe5V84XQCs6QpxQEoKBij6EuYcAKS9z8ir1zxSQL0Mau2mYEdhCk97wRDC9ei0SSuGoGUVCaJX3Gc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763443372; c=relaxed/simple;
	bh=4Q48GvKGVTbBdZAVXAqb/DKb6mVp+XlqjRaPiSr97JI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:MIME-Version:
	 Content-Type:References; b=VpqRhkKpL0wK4CNnTdYWLVm/0vuOXefqSpwK7jonhWNQ8y2HfrYPYXnLw5Dee8GXOjrdQnt4pJp3PyR52/T/TguZnM6j9WwCjBsnpvnL3isdHX8WzF9Zxwkz9m2WV8zbXjRN0uaNfC5tVnXzCw5GfCgQc8W9dLRlGKW1XfiDHDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=EuTtQvZJ; arc=none smtp.client-ip=203.254.224.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="EuTtQvZJ"
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
	by mailout4.samsung.com (KnoxPortal) with ESMTP id 20251118052247epoutp04b2074ce53558e7a6bbe7fbdfc4432991~5AmZNbjec0188501885epoutp04M
	for <linux-block@vger.kernel.org>; Tue, 18 Nov 2025 05:22:47 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20251118052247epoutp04b2074ce53558e7a6bbe7fbdfc4432991~5AmZNbjec0188501885epoutp04M
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1763443367;
	bh=4Q48GvKGVTbBdZAVXAqb/DKb6mVp+XlqjRaPiSr97JI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EuTtQvZJmEPkHFliJ19jBSxHcolEp2O4myZPCBLHaS6hUispy4thb2i3tC5PYpA0C
	 qd6roaf6elo4hztzGJgWgUCkCHZEhUNx+kj2skKfugZxh2btiTvLkqr+La1635ZsGc
	 oxuV5ymyNHL6fLU6YaLQYZyN87lEzEoAyZapzzHw=
Received: from epsnrtp04.localdomain (unknown [182.195.42.156]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTPS id
	20251118052246epcas5p1cb391f7ef1147a130ddcb76d2b89e89a~5AmYK806s2236822368epcas5p1I;
	Tue, 18 Nov 2025 05:22:46 +0000 (GMT)
Received: from epcas5p3.samsung.com (unknown [182.195.38.87]) by
	epsnrtp04.localdomain (Postfix) with ESMTP id 4d9Y0P2RZmz6B9mG; Tue, 18 Nov
	2025 05:22:45 +0000 (GMT)
Received: from epsmtip1.samsung.com (unknown [182.195.34.30]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
	20251118052223epcas5p17eb1f4c8af3965b28ae89eae33998777~5AmCZHgCf0550305503epcas5p19;
	Tue, 18 Nov 2025 05:22:23 +0000 (GMT)
Received: from node122.. (unknown [109.105.118.122]) by epsmtip1.samsung.com
	(KnoxPortal) with ESMTPA id
	20251118052222epsmtip130d5a9b29ca730745aeb64c7b00495f2~5AmB0kwab3148531485epsmtip1i;
	Tue, 18 Nov 2025 05:22:22 +0000 (GMT)
From: Xue He <xue01.he@samsung.com>
To: xue01.he@samsung.com
Cc: axboe@kernel.dk, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, ming.lei@redhat.com, yukuai@fnnas.com
Subject: Re: [PATCH v7] block: plug attempts to batch allocate tags multiple
 times
Date: Tue, 18 Nov 2025 05:17:47 +0000
Message-Id: <20251118051747.260560-1-xue01.he@samsung.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251117124229.255796-1-xue01.he@samsung.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20251118052223epcas5p17eb1f4c8af3965b28ae89eae33998777
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
cpgsPolicy: CPGSC10-505,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20251118052223epcas5p17eb1f4c8af3965b28ae89eae33998777
References: <20251117124229.255796-1-xue01.he@samsung.com>
	<CGME20251118052223epcas5p17eb1f4c8af3965b28ae89eae33998777@epcas5p1.samsung.com>

sorry, here was some misunderstanding, please ignore this, I will resend v7 patch.

Xue He
