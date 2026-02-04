Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DB413644D2
	for <linux-block@vger.kernel.org>; Wed,  4 Feb 2026 06:07:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770185250; cv=none; b=c4ZMRVulBZoV3bdGcCXn7F+mogqatKvimHxzagOIbNCrNB4JZsApLVnZXjuem1+ylot8EGkvRVBxJGH910pcJtamvb64IJpSLMvP4md54Om0/8QN6Txvl5z++dnlVeRy00Q5h1q/yUpvGk1RavxI0Hyc8mgCjYK2nyIvajgpRv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770185250; c=relaxed/simple;
	bh=vFeASoXmH/a8+nINHgGsmh6ICV7WwiJIChiSbgDwE7s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:In-Reply-To:
	 Content-Type:References; b=CoLRBc0XpPFs2o+m7XHF9f9J4+irlPF3u+B9CkBjBtbHnOnEUycNm00VdghFuVb5K3nkOA0YtjzBP4Qvh47c6zC4zq5sHfFoAjFYlnJ1EDYWr673bYAPNpb0w9PVzAH99lby8TDe1Q9FUfCqEIRSrMsJ0W9bM6B7mInDqfpMQNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=NhzBjLSH; arc=none smtp.client-ip=203.254.224.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="NhzBjLSH"
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
	by mailout2.samsung.com (KnoxPortal) with ESMTP id 20260204060727epoutp028496a3769ff5cb680799c05c06836c06~Q9hqm4Bu60207102071epoutp02C
	for <linux-block@vger.kernel.org>; Wed,  4 Feb 2026 06:07:27 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20260204060727epoutp028496a3769ff5cb680799c05c06836c06~Q9hqm4Bu60207102071epoutp02C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1770185247;
	bh=y2frTBlrPcApGJAKcojyrODxcLgxJHU1QEnp9KWJoZE=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=NhzBjLSHtZQSQfwpotD0ry+Zimlaaw5fqm639OJbdbhO5fR5z5AnqlhFlOCe902o8
	 frZCx7w8qfrbc9ahl5e4C1eLYZNUptEigCQ8ZEOyCMxJPQOOiJ1ezeBjZ7cSv9MUPd
	 pWrdY+SkrHWCbDZFh9P9kvzipTxVl2Dyw8JReVZ8=
Received: from epsnrtp02.localdomain (unknown [182.195.42.154]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTPS id
	20260204060727epcas5p232ff332ff546f37733e37b0c13d6cada~Q9hqaEc0W0625406254epcas5p2u;
	Wed,  4 Feb 2026 06:07:27 +0000 (GMT)
Received: from epcas5p4.samsung.com (unknown [182.195.38.94]) by
	epsnrtp02.localdomain (Postfix) with ESMTP id 4f5VHy44lQz2SSKd; Wed,  4 Feb
	2026 06:07:26 +0000 (GMT)
Received: from epsmtip2.samsung.com (unknown [182.195.34.31]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
	20260204060726epcas5p3816adfde071ae343471ac7a6a33a0e82~Q9ho7YiaV1775217752epcas5p3N;
	Wed,  4 Feb 2026 06:07:26 +0000 (GMT)
Received: from [107.122.10.194] (unknown [107.122.10.194]) by
	epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20260204060722epsmtip24e8143a262629db8288b2256b0e51ace~Q9hlWsA3n1083210832epsmtip2D;
	Wed,  4 Feb 2026 06:07:22 +0000 (GMT)
Message-ID: <beb2ebf6-8207-4bbe-a77c-ccb09e2d841e@samsung.com>
Date: Wed, 4 Feb 2026 11:37:20 +0530
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [LSF/MM/BPF TOPIC] dmabuf backed read/write
To: Keith Busch <kbusch@kernel.org>, Pavel Begunkov <asml.silence@gmail.com>
Cc: linux-block@vger.kernel.org, io-uring <io-uring@vger.kernel.org>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	=?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, Christoph
	Hellwig <hch@lst.de>, Kanchan Joshi <joshi.k@samsung.com>, Nitesh Shetty
	<nj.shetty@samsung.com>, "lsf-pc@lists.linux-foundation.org"
	<lsf-pc@lists.linux-foundation.org>
Content-Language: en-US
From: Anuj Gupta/Anuj Gupta <anuj20.g@samsung.com>
In-Reply-To: <aYI5S1puAZ-rPvlC@kbusch-mbp>
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20260204060726epcas5p3816adfde071ae343471ac7a6a33a0e82
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
cpgsPolicy: CPGSC10-542,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20260203180716epcas5p1c9658e583e26197b515f6db07a100aa9
References: <4796d2f7-5300-4884-bd2e-3fcc7fdd7cea@gmail.com>
	<CGME20260203180716epcas5p1c9658e583e26197b515f6db07a100aa9@epcas5p1.samsung.com>
	<aYI5S1puAZ-rPvlC@kbusch-mbp>

On 2/3/2026 11:37 PM, Keith Busch wrote:
> Thanks for submitting the topic. The performance wins look great, but
> I'm a little surpised passthrough didn't show any difference. We're
> still skipping a bit of transformations with the dmabuf compared to not
> having it, so maybe it's just a matter of crafting the right benchmark
> to show the benefit.
> 

Those numbers were from a drive that saturates at ~5M IOPS, 
sopassthrough didn’t have much headroom. I did a quick run with two such
drives and saw a small improvement (~2–3%): ~5.97 MIOPS -> ~6.13 MIOPS,
but I’ll try tweaking the kernel config a bit to see if there’s more
headroom.

+1 on the topic - I'm interested in attending the discussion and
reviewing/testing v3 when it lands.

Thanks,
Anuj
