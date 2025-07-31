Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26920522A
	for <linux-block@vger.kernel.org>; Thu, 31 Jul 2025 05:05:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753938341; cv=none; b=dAFeex4Bacls+c5c1up6VO+ply5BBb8JA6zzy6X4b5s6Jt4HiByQoYlqPM/YXy4aq/C9TwSOxnorhGhc+U+ghCVEzxYKR1QzZjtPlWAoZhc4OjMy5xOH6FHPb0Ed+Aow7PwEjYtRMR/8TegcEgeAxsVvjj9FHaZmDZx/c5+ViZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753938341; c=relaxed/simple;
	bh=V5+sOOq7rKMANn9Ut880qlbOQOV80JunqmryWH7O39E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:In-Reply-To:
	 Content-Type:References; b=EtRDaWbmf3U4U+mvLmJqIqF7vvZgKwH/HvfqEGBmKjtNODCeonsdIravAZB5qvvgbJxjFm1VM6ilZHI20R6YheAp0GCSVDF3jKXAh/T1AqhA9QadwjHa5R7FEDmNuCfoQe/tGs0wT6mWLKAF38/DwnM0NFI38DZMoaZc53msi/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=g92NuYMa; arc=none smtp.client-ip=203.254.224.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="g92NuYMa"
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
	by mailout3.samsung.com (KnoxPortal) with ESMTP id 20250731050526epoutp03adf9c176f6c63d88143252f824366424~XPZ2CIGWO2590725907epoutp03c
	for <linux-block@vger.kernel.org>; Thu, 31 Jul 2025 05:05:26 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20250731050526epoutp03adf9c176f6c63d88143252f824366424~XPZ2CIGWO2590725907epoutp03c
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1753938326;
	bh=yWK6U2Cq7XN/X5bkFRdcHPeBoZecY/oOLVS/TcVu7Gs=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=g92NuYMaZZo4Zsq6V1i4x9F4Rk1ouLqIwWeXcIPfIXObjE/ICbuSuMlEukLeLIGv6
	 MjESqGRQCb13kx3v9o6M6wWOmNwTBEGM+wDvTAv4WhW4DiqEI1e3oBWmVdOVUNyIIM
	 dgnimg/+cpgEfm3sDSXMXqs3RLqdYMsPNjdxEkvE=
Received: from epsnrtp03.localdomain (unknown [182.195.42.155]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTPS id
	20250731050526epcas5p2a2e40852fa05e57a8520c1eed890d2d1~XPZ1rE-a92385923859epcas5p2q;
	Thu, 31 Jul 2025 05:05:26 +0000 (GMT)
Received: from epcas5p3.samsung.com (unknown [182.195.38.87]) by
	epsnrtp03.localdomain (Postfix) with ESMTP id 4bsxq93YVJz3hhTC; Thu, 31 Jul
	2025 05:05:25 +0000 (GMT)
Received: from epsmtip2.samsung.com (unknown [182.195.34.31]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
	20250731050525epcas5p1bba1adb57fe4c80c67a73c29e9ee2e3a~XPZ0pM25p2446824468epcas5p1i;
	Thu, 31 Jul 2025 05:05:25 +0000 (GMT)
Received: from [107.122.11.51] (unknown [107.122.11.51]) by
	epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20250731050524epsmtip224c05823040674ab953586780c3e5db2~XPZztUocY0058700587epsmtip2L;
	Thu, 31 Jul 2025 05:05:23 +0000 (GMT)
Message-ID: <c2774764-651f-49d3-8e7e-2609a8dc035e@samsung.com>
Date: Thu, 31 Jul 2025 10:35:23 +0530
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv3 1/7] blk-mq: introduce blk_map_iter
To: Keith Busch <kbusch@kernel.org>
Cc: Keith Busch <kbusch@meta.com>, linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org, hch@lst.de, axboe@kernel.dk,
	leonro@nvidia.com
Content-Language: en-US
From: Kanchan Joshi <joshi.k@samsung.com>
In-Reply-To: <aIo3vLnxQFWCD_pv@kbusch-mbp>
Content-Transfer-Encoding: 7bit
X-CMS-MailID: 20250731050525epcas5p1bba1adb57fe4c80c67a73c29e9ee2e3a
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
cpgsPolicy: CPGSC10-542,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20250729143610epcas5p114f07bbd8e9c27280e6ebd67b1afd47f
References: <20250729143442.2586575-1-kbusch@meta.com>
	<CGME20250729143610epcas5p114f07bbd8e9c27280e6ebd67b1afd47f@epcas5p1.samsung.com>
	<20250729143442.2586575-2-kbusch@meta.com>
	<09c06697-dd77-47bb-85c5-fd64e75c7968@samsung.com>
	<aIo3vLnxQFWCD_pv@kbusch-mbp>

On 7/30/2025 8:48 PM, Keith Busch wrote:
> On Wed, Jul 30, 2025 at 01:48:42PM +0530, Kanchan Joshi wrote:
>> On 7/29/2025 8:04 PM, Keith Busch wrote:
>>> @@ -39,12 +33,11 @@ static bool blk_map_iter_next(struct request *req, struct req_iterator *iter,
>>>    	 * one could be merged into it.  This typically happens when moving to
>>>    	 * the next bio, but some callers also don't pack bvecs tight.
>>>    	 */
>>> -	while (!iter->iter.bi_size || !iter->iter.bi_bvec_done) {
>>> +	while (!iter->iter.bi_size ||
>>> +	       (!iter->iter.bi_bvec_done && iter->bio->bi_next)) {
>>>    		struct bio_vec next;
>>>    
>>>    		if (!iter->iter.bi_size) {
>>> -			if (!iter->bio->bi_next)
>>> -				break;
>>>    			iter->bio = iter->bio->bi_next;
>>>    			iter->iter = iter->bio->bi_iter;
>> This can crash here if we come inside the loop because
>> iter->iter.bi_size is 0
>> and if this is the last bio i.e., iter->bio->bi_next is NULL?
> Nah, I changed the while loop condition to ensure bio->bi_next isn't
> NULL if the current bi_size is 0. But I don't recall why I moved the
> condition check to there in the first place either.

Yes, you moved it, but that is not going to guard when 
iter->iter.bi_size is 0.

while (true || immaterial) {
	..
	if (true) {
		iter->bio = NULL;
		iter->iter = iter->bio->bi_iter;  //crash here
	}
}
