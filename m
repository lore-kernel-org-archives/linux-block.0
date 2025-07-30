Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96DEF7E1
	for <linux-block@vger.kernel.org>; Wed, 30 Jul 2025 08:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753863530; cv=none; b=E1fYsRQZCRRGQwXS/LoXTwlMJmosE1QXEc+ym1EiZRff0dlpzyWVwPuV1/nkMdtl2Knymz0mIImGHKWwGuqjTESoJksUDuwbUyLO/FoG5GYxs8GPCQURvlbEj03+sRDwK2ip64uj4OXUYlRwd7R4RVB7svySGGi/NyeLDo5BQzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753863530; c=relaxed/simple;
	bh=B5lxFhaGaMXGrKRTN2QNOQqTV02ZxORGFe9DocZYyjo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:In-Reply-To:
	 Content-Type:References; b=JszuYOBIn3qjNkQ3cHhlh0k1/Nzvjhg50xWmyAxzHL+zZmqlnsu5CeXMo7hFIOHq2Fxmc67PNiKZE5vV7x1LdvXZrFQmf1LT2YegWIQXOchbxZJyMDwKHcbxcVbWxqQe70TqtwNB/nY9w6T4G/yZGffNLzFZ3/0sW1LFGgYdT2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=jJ/roB/E; arc=none smtp.client-ip=203.254.224.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="jJ/roB/E"
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
	by mailout2.samsung.com (KnoxPortal) with ESMTP id 20250730081846epoutp02770763b1d98d7f11e54d462b7e75c305~W_ZW_MqHO2728927289epoutp02-
	for <linux-block@vger.kernel.org>; Wed, 30 Jul 2025 08:18:46 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20250730081846epoutp02770763b1d98d7f11e54d462b7e75c305~W_ZW_MqHO2728927289epoutp02-
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1753863526;
	bh=7tle2Ig+xZHeUculCrMm8JZ5XDdMkIORqRSnHOVg2S0=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=jJ/roB/EsMLARdVD7r/oQ562VpNqF7CVvwwJc795ct3/1WjfyvjolcUUyTNrzc4v7
	 OkDS2Eas0HGjVqot64C4yT57iQTs+jXuEszV94pCNc2gpV4ZgRk4j4HyUChwjlyOE0
	 qmG2bM0c7oFoWRrIxQpBsC99eHMIy5pXIJHkTL0s=
Received: from epsnrtp01.localdomain (unknown [182.195.42.153]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTPS id
	20250730081845epcas5p1e6b259e8081b9a35240d0933d5634c71~W_ZWFR2_d0760807608epcas5p1b;
	Wed, 30 Jul 2025 08:18:45 +0000 (GMT)
Received: from epcas5p3.samsung.com (unknown [182.195.38.90]) by
	epsnrtp01.localdomain (Postfix) with ESMTP id 4bsQ8h5lWqz6B9mS; Wed, 30 Jul
	2025 08:18:44 +0000 (GMT)
Received: from epsmtip1.samsung.com (unknown [182.195.34.30]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
	20250730081844epcas5p1abca54e976cf9ab4f116c71b99a7a132~W_ZVGjnDE0760807608epcas5p1Z;
	Wed, 30 Jul 2025 08:18:44 +0000 (GMT)
Received: from [107.122.11.51] (unknown [107.122.11.51]) by
	epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20250730081843epsmtip1dec56cd22af8d06770003f4a91ba7673~W_ZUKBPTk2278222782epsmtip1R;
	Wed, 30 Jul 2025 08:18:43 +0000 (GMT)
Message-ID: <09c06697-dd77-47bb-85c5-fd64e75c7968@samsung.com>
Date: Wed, 30 Jul 2025 13:48:42 +0530
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv3 1/7] blk-mq: introduce blk_map_iter
To: Keith Busch <kbusch@meta.com>, linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org, hch@lst.de
Cc: axboe@kernel.dk, leonro@nvidia.com, Keith Busch <kbusch@kernel.org>
Content-Language: en-US
From: Kanchan Joshi <joshi.k@samsung.com>
In-Reply-To: <20250729143442.2586575-2-kbusch@meta.com>
Content-Transfer-Encoding: 7bit
X-CMS-MailID: 20250730081844epcas5p1abca54e976cf9ab4f116c71b99a7a132
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
cpgsPolicy: CPGSC10-542,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20250729143610epcas5p114f07bbd8e9c27280e6ebd67b1afd47f
References: <20250729143442.2586575-1-kbusch@meta.com>
	<CGME20250729143610epcas5p114f07bbd8e9c27280e6ebd67b1afd47f@epcas5p1.samsung.com>
	<20250729143442.2586575-2-kbusch@meta.com>

On 7/29/2025 8:04 PM, Keith Busch wrote:
> @@ -39,12 +33,11 @@ static bool blk_map_iter_next(struct request *req, struct req_iterator *iter,
>   	 * one could be merged into it.  This typically happens when moving to
>   	 * the next bio, but some callers also don't pack bvecs tight.
>   	 */
> -	while (!iter->iter.bi_size || !iter->iter.bi_bvec_done) {
> +	while (!iter->iter.bi_size ||
> +	       (!iter->iter.bi_bvec_done && iter->bio->bi_next)) {
>   		struct bio_vec next;
>   
>   		if (!iter->iter.bi_size) {
> -			if (!iter->bio->bi_next)
> -				break;
>   			iter->bio = iter->bio->bi_next;
>   			iter->iter = iter->bio->bi_iter;

This can crash here if we come inside the loop because 
iter->iter.bi_size is 0
and if this is the last bio i.e., iter->bio->bi_next is NULL?



