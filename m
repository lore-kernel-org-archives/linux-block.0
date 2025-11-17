Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E86D0267386
	for <linux-block@vger.kernel.org>; Tue, 18 Nov 2025 04:51:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763441472; cv=none; b=JvJfV/SKdKeE7NfLXXgcwqSk3xHUMZx26UWcl34G3PA9VkMDKVU9Ojn3Vit3TMJ1pc5U0LRYeDuhRLmXnTogTeTAO8lghtmt4x8CEbmM8MQhcDTXrwdNEPzDrqC+q+9l259oChKAFzbw0vI2RXKE1eCBuFuAy6Wo9wjXEKim+Dg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763441472; c=relaxed/simple;
	bh=8XT70j/AkA8v08lr4RtF1ct4UfyfN7/KEgk4d3sKMds=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:MIME-Version:
	 Content-Type:References; b=Rg6Ja/14P8xk1aVHKPI7JYcPzaM/0ikgQgLLG/QQzZFd3FMPV2BkGdlq1ybDigOXR8WNqQX2NzlvaAxS+1j89zoiKWnCELdO7ClyH3m+E+fauQ88YAeCd41pm4I7W8Z4Tdmsy6eVoGQLuNTiJodL3f/CfuE3CAYYfosHBkpPqh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=eSuX+vq8; arc=none smtp.client-ip=203.254.224.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="eSuX+vq8"
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
	by mailout3.samsung.com (KnoxPortal) with ESMTP id 20251118045107epoutp03a14b5348999ba7d31e0ec76732afe0c6~5AKvvH0aY1238612386epoutp03Z
	for <linux-block@vger.kernel.org>; Tue, 18 Nov 2025 04:51:07 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20251118045107epoutp03a14b5348999ba7d31e0ec76732afe0c6~5AKvvH0aY1238612386epoutp03Z
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1763441467;
	bh=8XT70j/AkA8v08lr4RtF1ct4UfyfN7/KEgk4d3sKMds=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=eSuX+vq85od0QRYT3WyYp7VVGjMQjJ4GBwZZ8gQ49M9BoIhsOmxWexunZbThwBA66
	 R9KH8ePCsiMoR9gH+pNhj8roCKRFp03H2N5fglxLSBF9sHPLCVRfezR4egV7JPN6Gi
	 Nw0V7SR02bKpeWv3NPyYXgONLvaTdakUo55nuxkY=
Received: from epsnrtp04.localdomain (unknown [182.195.42.156]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTPS id
	20251118045107epcas5p206cd4d5e9be181079a9c1d7508ef4545~5AKvejpNI2325423254epcas5p2O;
	Tue, 18 Nov 2025 04:51:07 +0000 (GMT)
Received: from epcas5p2.samsung.com (unknown [182.195.38.89]) by
	epsnrtp04.localdomain (Postfix) with ESMTP id 4d9XHt2LC1z6B9m6; Tue, 18 Nov
	2025 04:51:06 +0000 (GMT)
Received: from epsmtip2.samsung.com (unknown [182.195.34.31]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
	20251117102659epcas5p404ff3e462dcda573338ef47beadd2cc7~4xGth613i1408114081epcas5p4Y;
	Mon, 17 Nov 2025 10:26:59 +0000 (GMT)
Received: from node122.. (unknown [109.105.118.122]) by epsmtip2.samsung.com
	(KnoxPortal) with ESMTPA id
	20251117102659epsmtip242285a4f13392568ecd631f2914658da~4xGs-Ybu50148501485epsmtip2D;
	Mon, 17 Nov 2025 10:26:58 +0000 (GMT)
From: Xue He <xue01.he@samsung.com>
To: ming.lei@redhat.com
Cc: axboe@kernel.dk, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, xue01.he@samsung.com, yukuai@fnnas.com
Subject: Re: [PATCH v6] block: plug attempts to batch allocate tags multiple
 times
Date: Mon, 17 Nov 2025 10:22:25 +0000
Message-Id: <20251117102225.255504-1-xue01.he@samsung.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <aRr2x89ShJa08jNk@fedora>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20251117102659epcas5p404ff3e462dcda573338ef47beadd2cc7
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
cpgsPolicy: CPGSC10-505,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20251117102659epcas5p404ff3e462dcda573338ef47beadd2cc7
References: <aRr2x89ShJa08jNk@fedora>
	<CGME20251117102659epcas5p404ff3e462dcda573338ef47beadd2cc7@epcas5p4.samsung.com>

>The above two lines can be kept in original position, then the change
>outside loop can be avoided.
>
>With above update, feel free to add:
>
>Reviewed-by: Ming Lei <ming.lei@redhat.com>
>
>Thanks,
>Ming

Thanks for review, I'll update and add this, then resubmit v7.

Thanks,
Xue He
