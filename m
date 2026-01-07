Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 991DD2D6E6F
	for <linux-block@vger.kernel.org>; Wed,  7 Jan 2026 10:45:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767782709; cv=none; b=XxjYR89EqJDyEH5tmgqV3jN8Ac6q620m/zZKW0Y2GtLEGuzIno2JJlA+e94Z5Jd3FOaA/5NGAHoHEmiBAyjr/tavebx6tcrq4clpmu0/DR2q2W4oNTt9iKFQQpSosUR7AiNbeQDDjGNF7h5GcxO6gzzAra6PgrYIiWtIcOhsMKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767782709; c=relaxed/simple;
	bh=v+WKDEsViGraYcGxAfnCHy6lQ12vFK8jQW7jUHTphac=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:In-Reply-To:
	 Content-Type:References; b=Z68T/5iAmULQ5eq5P4MpI+A8SP63SJLD3JsJM+Z+0BqFmnLQkx2dn7neAqJU8XGN7Y9b1R2UzvEnmACRMjZBZmSLkk0cIUxb5VggD/CzNaoFbCiJLfXYj7FKWvNyInVttjsIuaenH5AKrzD4W7VPuGeDMgS/LGpCWOSZU9N2YxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=pRfqWlDK; arc=none smtp.client-ip=203.254.224.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="pRfqWlDK"
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
	by mailout3.samsung.com (KnoxPortal) with ESMTP id 20260107104459epoutp034625626b9626fd67296d2ad517dda7d0~IbP_nG_3c2220122201epoutp03Y
	for <linux-block@vger.kernel.org>; Wed,  7 Jan 2026 10:44:59 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20260107104459epoutp034625626b9626fd67296d2ad517dda7d0~IbP_nG_3c2220122201epoutp03Y
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1767782699;
	bh=86JHWYKwvYo56a5/dl3RgoEI+n+U3DhR8uxQgUFdtIE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=pRfqWlDKke2TDcucdq0RPbxiojtQY4hhlZFmNRDnvmD5jkI2leKCPbsphqNTLZdpa
	 B3T9WoxFc576/fqABujYQ1QxuIpaSLvzAxH/B2EJGwzkTfAf2CF2OM4OVZ1wE9i2iv
	 lrcBsnabvNXbm22CKLBL44AII8SLoSIoADXeKJWQ=
Received: from epsnrtp03.localdomain (unknown [182.195.42.155]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTPS id
	20260107104458epcas5p40d912ba427bd3a6e5dc68b7a11fa3705~IbP9xQ7kp2752027520epcas5p4a;
	Wed,  7 Jan 2026 10:44:58 +0000 (GMT)
Received: from epcas5p1.samsung.com (unknown [182.195.38.90]) by
	epsnrtp03.localdomain (Postfix) with ESMTP id 4dmPn51C43z3hhTB; Wed,  7 Jan
	2026 10:44:57 +0000 (GMT)
Received: from epsmtip2.samsung.com (unknown [182.195.34.31]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
	20260107104456epcas5p2d338842fca72f093ebf233c5c6bda766~IbP8MOkFV0407704077epcas5p2T;
	Wed,  7 Jan 2026 10:44:56 +0000 (GMT)
Received: from green245.gost (unknown [107.99.41.245]) by
	epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20260107104455epsmtip2aa182e94aaabac72a7816a5419f4779d~IbP7Q1ueu1746317463epsmtip2F;
	Wed,  7 Jan 2026 10:44:55 +0000 (GMT)
Date: Wed, 7 Jan 2026 16:10:50 +0530
From: Nitesh Shetty <nj.shetty@samsung.com>
To: Ming Lei <ming.lei@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	io-uring@vger.kernel.org, Caleb Sander Mateos <csander@purestorage.com>
Subject: Re: [PATCH V2 3/3] io_uring: remove nr_segs recalculation in
 io_import_kbuf()
Message-ID: <20260107104050.wetbkrjfsnzw2duk@green245.gost>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20251231030101.3093960-4-ming.lei@redhat.com>
X-CMS-MailID: 20260107104456epcas5p2d338842fca72f093ebf233c5c6bda766
X-Msg-Generator: CA
Content-Type: multipart/mixed;
	boundary="----HKC0oM6l2X7jDELFNxUL3gr1rNZobpnU9ZVzK0VPY15yFScq=_db825_"
CMS-TYPE: 105P
cpgsPolicy: CPGSC10-542,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20260107104456epcas5p2d338842fca72f093ebf233c5c6bda766
References: <20251231030101.3093960-1-ming.lei@redhat.com>
	<20251231030101.3093960-4-ming.lei@redhat.com>
	<CGME20260107104456epcas5p2d338842fca72f093ebf233c5c6bda766@epcas5p2.samsung.com>

------HKC0oM6l2X7jDELFNxUL3gr1rNZobpnU9ZVzK0VPY15yFScq=_db825_
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Disposition: inline

On 31/12/25 11:00AM, Ming Lei wrote:
>io_import_kbuf() recalculates iter->nr_segs to reflect only the bvecs
>needed for the requested byte range. This was added to provide an
>accurate segment count to bio_iov_bvec_set(), which copied nr_segs to
>bio->bi_vcnt for use as a bio split hint.
>
>The previous two patches eliminated this dependency:
> - bio_may_need_split() now uses bi_iter instead of bi_vcnt for split
>   decisions
> - bio_iov_bvec_set() no longer copies nr_segs to bi_vcnt
>
>Since nr_segs is no longer used for bio split decisions, the
>recalculation loop is unnecessary. The iov_iter already has the correct
>bi_size to cap iteration, so an oversized nr_segs is harmless.
>
>Link: https://lkml.org/lkml/2025/4/16/351
>Signed-off-by: Ming Lei <ming.lei@redhat.com>

Reviewed-by: Nitesh Shetty <nj.shetty@samsung.com>

------HKC0oM6l2X7jDELFNxUL3gr1rNZobpnU9ZVzK0VPY15yFScq=_db825_
Content-Type: text/plain; charset="utf-8"


------HKC0oM6l2X7jDELFNxUL3gr1rNZobpnU9ZVzK0VPY15yFScq=_db825_--
