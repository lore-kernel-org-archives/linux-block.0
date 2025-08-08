Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D16D527A91D
	for <linux-block@vger.kernel.org>; Fri,  8 Aug 2025 12:54:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754657664; cv=none; b=oQQ5T7V9dQDXGpBr1PMG6g7fCIynBkSP9rfoPEW8jJ++9LNgwjxZ7j2Li7zYzMd9PyjK9r+XWeIUfQ7WatBjkslEJquq7Ln0cpHBV1RZvQPfqXRvQhv36U3jLA3jEC/v8uGsfeLqZJvTJhkGqzkvZdnnx/FmjM7AoF8hdN1irzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754657664; c=relaxed/simple;
	bh=unzE1xgcFLviHHSDwia9lFZRZnD4S1KimEPEHwlnRnw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:In-Reply-To:
	 Content-Type:References; b=sREMVKFqoKTmCm8A4G6KvQbHGKwiNH4hhiPTlSKVj6vGBF99dPHQWqfgeI9FYZsZ3X7jCutlMVxiPyIoSWbHEopmi9nFZ4Nm3tguKL+tghR4R7CybaxGGjdWv3oyWDUu3UCYb710zmTij0dTIH+QfG8P14UnjquUTPGYqE7cXPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=EdoVoxf1; arc=none smtp.client-ip=203.254.224.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="EdoVoxf1"
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
	by mailout4.samsung.com (KnoxPortal) with ESMTP id 20250808125419epoutp04db90edaaba8036d099f7fd95298a8a29~Zy9hMTZMt2125921259epoutp04F
	for <linux-block@vger.kernel.org>; Fri,  8 Aug 2025 12:54:19 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20250808125419epoutp04db90edaaba8036d099f7fd95298a8a29~Zy9hMTZMt2125921259epoutp04F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1754657659;
	bh=A7nQq3bAqMIxxN/XxLCukV6f4+OY2/BogMqasaFwx3w=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=EdoVoxf1UdlSyQZfNNdMyr8RpWUgowXccwaN/DY1gXThRxgoLelJELbOAOLcLOvWl
	 isfh3m4q/HKBK/iUM8D6zeueM8ciGeUiQJlxpYA49ENOe6yb55otWdRP006pmY+277
	 bQ+FVgrbRY3vZX0ACp7GRmm6Tnz0pbEUr3seGgEU=
Received: from epsnrtp02.localdomain (unknown [182.195.42.154]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTPS id
	20250808125419epcas5p3b484d595b795a0708e59d5b68d5b559e~Zy9gxCNKX2117521175epcas5p3V;
	Fri,  8 Aug 2025 12:54:19 +0000 (GMT)
Received: from epcas5p2.samsung.com (unknown [182.195.38.89]) by
	epsnrtp02.localdomain (Postfix) with ESMTP id 4bz3rV3pJmz2SSKX; Fri,  8 Aug
	2025 12:54:18 +0000 (GMT)
Received: from epsmtip2.samsung.com (unknown [182.195.34.31]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
	20250808125418epcas5p4d66269e567cceb4658c965f2991493ec~Zy9fq9tyY2971229712epcas5p4D;
	Fri,  8 Aug 2025 12:54:18 +0000 (GMT)
Received: from [107.122.11.51] (unknown [107.122.11.51]) by
	epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20250808125417epsmtip22e814d8c3e62e358ea6a890005f1532c~Zy9e1hL150076300763epsmtip2u;
	Fri,  8 Aug 2025 12:54:17 +0000 (GMT)
Message-ID: <5e218cb4-af0a-49a8-ad1c-21cfb7ac467c@samsung.com>
Date: Fri, 8 Aug 2025 18:24:16 +0530
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv4 4/8] blk-mq: remove REQ_P2PDMA flag
To: Keith Busch <kbusch@meta.com>, linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org
Cc: hch@lst.de, axboe@kernel.dk, Keith Busch <kbusch@kernel.org>
Content-Language: en-US
From: Kanchan Joshi <joshi.k@samsung.com>
In-Reply-To: <20250731150513.220395-5-kbusch@meta.com>
Content-Transfer-Encoding: 7bit
X-CMS-MailID: 20250808125418epcas5p4d66269e567cceb4658c965f2991493ec
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
cpgsPolicy: CPGSC10-542,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20250731150528epcas5p1f3970f09cf6e32cf277ba6f38acaf385
References: <20250731150513.220395-1-kbusch@meta.com>
	<CGME20250731150528epcas5p1f3970f09cf6e32cf277ba6f38acaf385@epcas5p1.samsung.com>
	<20250731150513.220395-5-kbusch@meta.com>

On 7/31/2025 8:35 PM, Keith Busch wrote:
> -#define REQ_P2PDMA	(__force blk_opf_t)(1ULL << __REQ_P2PDMA)

since this is gone, __REQ_P2PDMA can also be removed.
