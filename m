Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF2DF2BB13
	for <linux-block@vger.kernel.org>; Thu, 29 Jan 2026 09:48:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769680139; cv=none; b=GWo1iWZMDKomCSdAhRcS4Uv/4wn5HKJIpMaQQQJDkvc0yDUBDLfnCcS6EKaxI1XOOTFYKtbGUVlEGDvduAw6V5ygzDgpvWihLEfK4CgLv0LVoH4qyKk27NWasXd7rlv/LE1bR/RtYBtQa4lHQgYJCIr7MPP2BnX318eRsCqOo1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769680139; c=relaxed/simple;
	bh=Q1A4/FpiX2uqSS5gsOQw0fT404boXs56muaLRndrLOI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:In-Reply-To:
	 Content-Type:References; b=lBSx3dI97uekBfbySFRAiZoO8t1F8RgQk6rP4Jd3ZmdwBpFHBx6Li/AKDxB9I9yl8Jz/o7oKKCssRwTtKPGHtnustQ1CxtU4qs6zmhWoXoUjF71E0V1XgJWG1oFHQM9PAiiZJFxy0VybzloECwDixR+PuLx+oL6dsOcmULtksfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=BGXJT7+p; arc=none smtp.client-ip=203.254.224.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="BGXJT7+p"
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
	by mailout3.samsung.com (KnoxPortal) with ESMTP id 20260129094854epoutp0375d5d4e5472bf4cab4fa6a83a6605e01~PKrTikfKh2629626296epoutp03p
	for <linux-block@vger.kernel.org>; Thu, 29 Jan 2026 09:48:54 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20260129094854epoutp0375d5d4e5472bf4cab4fa6a83a6605e01~PKrTikfKh2629626296epoutp03p
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1769680135;
	bh=t2vK4qkRZjjRCMuYMG0BhKboqlEtUqKKQy4pplpgtnk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=BGXJT7+pOPqA04fIfDv3cu9p9IPa8iwu4iTMM6HKReihW6xp24YadpsvDJzdp6DCs
	 4Axc63ya9WmoghP4v4G+MaKiZhbApTASD0qjuFsXQ3Y+ajsgYa5dvSeI6csWtwuIsa
	 KpFE0275hrhYRkroaKKZtsGjhY+T2UBA3IffTKUo=
Received: from epsnrtp03.localdomain (unknown [182.195.42.155]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTPS id
	20260129094854epcas5p3d1d1fd600c870f1b13d659f8f74a1a50~PKrTRyGOy0132901329epcas5p3c;
	Thu, 29 Jan 2026 09:48:54 +0000 (GMT)
Received: from epcas5p1.samsung.com (unknown [182.195.38.90]) by
	epsnrtp03.localdomain (Postfix) with ESMTP id 4f1vVF4vkJz3hhT9; Thu, 29 Jan
	2026 09:48:53 +0000 (GMT)
Received: from epsmtip2.samsung.com (unknown [182.195.34.31]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
	20260129094853epcas5p1493ab06964e162a2a6933d3f9688118d~PKrSAy_ng1386113861epcas5p1G;
	Thu, 29 Jan 2026 09:48:53 +0000 (GMT)
Received: from green245.gost (unknown [107.99.41.245]) by
	epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20260129094852epsmtip229306cb339b60583e284a15588826135~PKrRh5WFb2777327773epsmtip2Y;
	Thu, 29 Jan 2026 09:48:52 +0000 (GMT)
Date: Thu, 29 Jan 2026 15:14:40 +0530
From: Nitesh Shetty <nj.shetty@samsung.com>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Subject: Re: [PATCH 2/2] block: introduce blk_queue_rot()
Message-ID: <20260129094440.vdbrkuafgvq4auct@green245.gost>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <7a791d5d-cc74-45bb-a7c7-0d681d3601e0@kernel.org>
X-CMS-MailID: 20260129094853epcas5p1493ab06964e162a2a6933d3f9688118d
X-Msg-Generator: CA
Content-Type: multipart/mixed;
	boundary="----HKC0oM6l2X7jDELFNxUL3gr1rNZobpnU9ZVzK0VPY15yFScq=_1371e0_"
CMS-TYPE: 105P
cpgsPolicy: CPGSC10-542,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20260129092258epcas5p1fb7fd90db827d982829475652b43786a
References: <20260129072715.1107336-1-dlemoal@kernel.org>
	<20260129072715.1107336-3-dlemoal@kernel.org>
	<CGME20260129092258epcas5p1fb7fd90db827d982829475652b43786a@epcas5p1.samsung.com>
	<20260129091846.nx3crn6347gf6brv@green245.gost>
	<7a791d5d-cc74-45bb-a7c7-0d681d3601e0@kernel.org>

------HKC0oM6l2X7jDELFNxUL3gr1rNZobpnU9ZVzK0VPY15yFScq=_1371e0_
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Disposition: inline

On 29/01/26 06:38PM, Damien Le Moal wrote:
>On 1/29/26 18:18, Nitesh Shetty wrote:
>> On 29/01/26 04:27PM, Damien Le Moal wrote:
>>> To check if a request queue is for a rotational device, a double
>>> negation is needed with the pattern "!blk_queue_nonrot(q)". Simplify
>>> this with the introduction of the helper blk_queue_rot() which tests
>>> if a requests queue limit has the BLK_FEAT_ROTATIONAL feature set.
>>> All call sites of blk_queue_nonrot() are modified to use blk_queue_rot()
>>> and blk_queue_nonrot() definition removed.
>>>
>>> No functional changes.
>>>
>>> Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
>>> ---
>>> block/bfq-iosched.c    | 20 ++++++++++----------
>>> block/blk-iocost.c     |  2 +-
>>> block/blk-iolatency.c  |  5 +----
>>> block/blk-wbt.c        |  5 ++---
>>> include/linux/blkdev.h |  4 ++--
>>> 5 files changed, 16 insertions(+), 20 deletions(-)
>>>
>>> diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
>>> index 6e54b1d3d8bc..3ebdec40e758 100644
>>> --- a/block/bfq-iosched.c
>>> +++ b/block/bfq-iosched.c
>>> @@ -231,7 +231,7 @@ static struct kmem_cache *bfq_pool;
>>> #define BFQ_RQ_SEEKY(bfqd, last_pos, rq) \
>>> 	(get_sdist(last_pos, rq) >			\
>>> 	 BFQQ_SEEK_THR &&				\
>>> -	 (!blk_queue_nonrot(bfqd->queue) ||		\
>>> +	 (blk_queue_rot(bfqd->queue) ||			\
>>> 	  blk_rq_sectors(rq) < BFQQ_SECT_THR_NONROT))
>>> #define BFQQ_CLOSE_THR		(sector_t)(8 * 1024)
>>> #define BFQQ_SEEKY(bfqq)	(hweight32(bfqq->seek_history) > 19)
>>> @@ -4165,7 +4165,7 @@ static bool bfq_bfqq_is_slow(struct bfq_data *bfqd, struct bfq_queue *bfqq,
>>>
>>> 	/* don't use too short time intervals */
>>> 	if (delta_usecs < 1000) {
>>> -		if (blk_queue_nonrot(bfqd->queue))
>>> +		if (!blk_queue_rot(bfqd->queue))
>> blk_queue_rot looks fine to me in other places.
>> Keeping blk_queue_nonrot would avoid the double negation here and few places.
>
>There is no more double negation. blk_queue_rot() tests for a feature flag being
>set. The !blk_queue_rot(q) tests the opposite.
>
>> I see you made the changes for bdev_nonrot down, but missed to add here
>> ?
>
>Here where ? What did I miss ?
>
My bad, I thought you added a new helper for bdev_rot at the end,
which check for rotation device.

Reviewed-by: Nitesh Shetty <nj.shetty@samsung.com>

------HKC0oM6l2X7jDELFNxUL3gr1rNZobpnU9ZVzK0VPY15yFScq=_1371e0_
Content-Type: text/plain; charset="utf-8"


------HKC0oM6l2X7jDELFNxUL3gr1rNZobpnU9ZVzK0VPY15yFScq=_1371e0_--
