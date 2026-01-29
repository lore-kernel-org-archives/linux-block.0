Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAF4B3783A5
	for <linux-block@vger.kernel.org>; Thu, 29 Jan 2026 09:26:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769678784; cv=none; b=i1vH+WFvfRxLwaWlaIpJPLcu8X/P+bwEahK+1Quk+56vq1RSdlI7wHX2G7tIVSaNXLmmNT5a125Kiyn26ksJ0Fs8cqOYs/tghxf3UxS386y29Kk64aZJiXxl5hn91AV2CVE/XdkOn8VsP+dmJoFxNf0d5dEvd/dpHdGY1CCP+v4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769678784; c=relaxed/simple;
	bh=xjm2p3qaSda7vbBTyXyzpBMogbZTtEAmMp/qGhezn8U=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:In-Reply-To:
	 Content-Type:References; b=j7zULtrWMBFMKfBgJ3ZDXxKiL6A+hSNfuy8wMRYg9SdGnKrIx6CVaSsCz2gnuzZECD8LGfL7nH/ddS5Y+C8K9cnr5MOzpG4NOuiFcC6JzOzFbgZ/hsvQfL8vsUSTKuJ8CiNTKJVhrGKjbtDV1BrUK9F0YDOxKNNT7eWPlNqOppY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=iNomuOJV; arc=none smtp.client-ip=203.254.224.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="iNomuOJV"
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
	by mailout2.samsung.com (KnoxPortal) with ESMTP id 20260129092620epoutp0274916ada22ce2bc41639b16de4727cfe~PKXmdSl6I1628716287epoutp02P
	for <linux-block@vger.kernel.org>; Thu, 29 Jan 2026 09:26:20 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20260129092620epoutp0274916ada22ce2bc41639b16de4727cfe~PKXmdSl6I1628716287epoutp02P
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1769678780;
	bh=xjm2p3qaSda7vbBTyXyzpBMogbZTtEAmMp/qGhezn8U=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=iNomuOJVbojcetsPeSkIJYYoXaj8pTh+TqULFPz68TIXFYii7gR6/3k2FusjCuReJ
	 y0jieCpyNTZ6qKqcn5xXYMHCC0wtp8Ff8AeUtVDmrkxmRybMu+JOLuIImA2q1WtdGF
	 U3zD/Hxo7X74tOkvWD8TCg2NglDtaWQk8nJ44ql4=
Received: from epsnrtp04.localdomain (unknown [182.195.42.156]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTPS id
	20260129092620epcas5p4997b55ade206483956ef61c222d00393~PKXmQMMqe3121531215epcas5p4O;
	Thu, 29 Jan 2026 09:26:20 +0000 (GMT)
Received: from epcas5p1.samsung.com (unknown [182.195.38.94]) by
	epsnrtp04.localdomain (Postfix) with ESMTP id 4f1v0C6nDxz6B9m9; Thu, 29 Jan
	2026 09:26:19 +0000 (GMT)
Received: from epsmtip1.samsung.com (unknown [182.195.34.30]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
	20260129092619epcas5p4091e2e45f05f99ed376d4707f39f15e6~PKXk7WORi3121531215epcas5p4M;
	Thu, 29 Jan 2026 09:26:19 +0000 (GMT)
Received: from green245.gost (unknown [107.99.41.245]) by
	epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20260129092618epsmtip1a68387c0e3f594ac9c11d35c1e7091a9~PKXkUbHOA0870608706epsmtip1I;
	Thu, 29 Jan 2026 09:26:18 +0000 (GMT)
Date: Thu, 29 Jan 2026 14:52:06 +0530
From: Nitesh Shetty <nj.shetty@samsung.com>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Subject: Re: [PATCH 1/2] block: cleanup queue limit features definition
Message-ID: <20260129092206.kxbcu7uvwycwegqn@green245.gost>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20260129072715.1107336-2-dlemoal@kernel.org>
X-CMS-MailID: 20260129092619epcas5p4091e2e45f05f99ed376d4707f39f15e6
X-Msg-Generator: CA
Content-Type: multipart/mixed;
	boundary="----HKC0oM6l2X7jDELFNxUL3gr1rNZobpnU9ZVzK0VPY15yFScq=_137046_"
CMS-TYPE: 105P
cpgsPolicy: CPGSC10-542,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20260129092619epcas5p4091e2e45f05f99ed376d4707f39f15e6
References: <20260129072715.1107336-1-dlemoal@kernel.org>
	<20260129072715.1107336-2-dlemoal@kernel.org>
	<CGME20260129092619epcas5p4091e2e45f05f99ed376d4707f39f15e6@epcas5p4.samsung.com>

------HKC0oM6l2X7jDELFNxUL3gr1rNZobpnU9ZVzK0VPY15yFScq=_137046_
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Disposition: inline

On 29/01/26 04:27PM, Damien Le Moal wrote:
>Unwrap the definition of BLK_FEAT_ATOMIC_WRITES and
>renumber this feature to be sequential with BLK_FEAT_SKIP_TAGSET_QUIESCE.
>
>Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
>---
Reviewed-by: Nitesh Shetty <nj.shetty@samsung.com>

------HKC0oM6l2X7jDELFNxUL3gr1rNZobpnU9ZVzK0VPY15yFScq=_137046_
Content-Type: text/plain; charset="utf-8"


------HKC0oM6l2X7jDELFNxUL3gr1rNZobpnU9ZVzK0VPY15yFScq=_137046_--
