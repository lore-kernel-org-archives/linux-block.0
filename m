Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEAAB2E8B87
	for <linux-block@vger.kernel.org>; Thu,  5 Feb 2026 05:32:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770269549; cv=none; b=t8rdRxEuhn06q1YfEXSzy1QhZUe2fC/7vBgksvIrhKLBBeLK348kjG2ld6HChxHHLmk+VLwAuC9Bw6HQwP6OIthk9yi4M2+aEawbBynQh0W7lgmhAI/iaGyAFONzUkr0cp8uyPkORHKQZDtsvgIanz2gyAfmAQMpYE/VJLk44DQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770269549; c=relaxed/simple;
	bh=D77dSpDx6XxHiHw12gkRRJRdycW0/m7c9bcF272YpI4=;
	h=Mime-Version:Subject:From:To:CC:In-Reply-To:Message-ID:Date:
	 Content-Type:References; b=huoskos6SezSG5iRO4XX3x27Zk72LMMb74/oxKWPAdNspe4o0BJw8RVfnKubzGTtU7TaVzvuFMc+nhoysBbEgec/xKuOmeFk9XlN3zqvH180/lQAoBbrQchlTesFFe/otP74cB8SHhvLqTPR8sr6sHBy/iBaW/YpX3OX7cbpl4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=Lgofhn+B; arc=none smtp.client-ip=203.254.224.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="Lgofhn+B"
Received: from epcas2p3.samsung.com (unknown [182.195.41.55])
	by mailout3.samsung.com (KnoxPortal) with ESMTP id 20260205053220epoutp03934db2ccfdb11c5dfe83018584eb92f2~RQsSUDE3r0752907529epoutp03N
	for <linux-block@vger.kernel.org>; Thu,  5 Feb 2026 05:32:20 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20260205053220epoutp03934db2ccfdb11c5dfe83018584eb92f2~RQsSUDE3r0752907529epoutp03N
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1770269540;
	bh=GwX5cKAP15nRsjmx54ffQ5a/as1w/sPDdfMkfKoW1rs=;
	h=Subject:Reply-To:From:To:CC:In-Reply-To:Date:References:From;
	b=Lgofhn+Bm0ZvdIxYnmtRfC7fKM6wV4V/HrMKLADh3KUqpEyUQzxjF8aIkvO1K/W6v
	 Ei6duvPZy6wPfTS08rtEhWVASEbHykZ2IKIS4IYjtBMM4V2BEMJ01ATdLCUayu0QMS
	 tY/JGmOBJqZ21qfjLFCQTnFo9Ls5FZgL45wUEnhc=
Received: from epsnrtp01.localdomain (unknown [182.195.42.153]) by
	epcas2p3.samsung.com (KnoxPortal) with ESMTPS id
	20260205053220epcas2p3367f123fbc5373b01fd3bab617d4c6bd~RQsR7qUJp0918009180epcas2p3D;
	Thu,  5 Feb 2026 05:32:20 +0000 (GMT)
Received: from epcas2p3.samsung.com (unknown [182.195.38.204]) by
	epsnrtp01.localdomain (Postfix) with ESMTP id 4f65Sz5v06z6B9mG; Thu,  5 Feb
	2026 05:32:19 +0000 (GMT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Subject: [Patch] bsg: initialize request and reply payloads in
 bsg_prepare_job
Reply-To: jonghwi.rha@samsung.com
Sender: =?UTF-8?B?65287KKF7ZyY?= <jonghwi.rha@samsung.com>
From: =?UTF-8?B?65287KKF7ZyY?= <jonghwi.rha@samsung.com>
To: Jens Axboe <axboe@kernel.dk>
CC: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "hch@lst.de"
	<hch@lst.de>, =?UTF-8?B?6rmA7KCV7YOc?= <jt1217.kim@samsung.com>,
	=?UTF-8?B?7KCV7Zic7Jew?= <hyeon.chung@samsung.com>
X-Priority: 3
X-Content-Kind-Code: NORMAL
In-Reply-To: <8c7399bf-76b3-4902-b257-b85c95543f6f@kernel.dk>
X-CPGS-Detection: blocking_info_exchange
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20260205053219epcms2p20a936a2fa681d19d3386fd480c283447@epcms2p2>
Date: Thu, 05 Feb 2026 14:32:19 +0900
X-CMS-MailID: 20260205053219epcms2p20a936a2fa681d19d3386fd480c283447
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
cpgsPolicy: CPGSC10-234,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20260130091020epcms2p2d85af8781639a17ab517208feb270dbd
References: <8c7399bf-76b3-4902-b257-b85c95543f6f@kernel.dk>
	<20260202120425epcms2p481d034d2a8fc522819673f0bcd59cefd@epcms2p4>
	<CGME20260130091020epcms2p2d85af8781639a17ab517208feb270dbd@epcms2p2>

Hello,

This is Jonghwi from Samsung. :)
I am sending you a patch via new email as requested.


bsg: initialize request and reply payloads in bsg_prepare_job

struct bsg_job payloads contain fields that are only populated by
certain commands, such as sg_list pointers.

Because struct bsg_job is allocated with kmalloc(), memory may be
reused across requests. If a command does not populate all payload
fields, stale state from a previous job may remain and later be
misinterpreted during cleanup, potentially leading to use-after-free
or double-free issues.

Initialize both request and reply payloads at the beginning of job
preparation to ensure a clean state for all commands.

Signed-off-by: Jonghwi Rha <jonghwi.rha@samsung.com>

diff --git a/block/bsg-lib.c b/block/bsg-lib.c
index 32da4a4429ce..0fbf8e311c03 100644
--- a/block/bsg-lib.c
+++ b/block/bsg-lib.c
@@ -234,6 +234,12 @@ static bool bsg_prepare_job(struct device *dev, struct request *req)
        struct bsg_job *job = blk_mq_rq_to_pdu(req);
        int ret;

+       /* Clear stale SG state since bsg_job is reused as a request PDU */
+       job->request_payload.sg_list = NULL;
+       job->request_payload.sg_cnt = 0;
+       job->reply_payload.sg_list = NULL;
+       job->reply_payload.sg_cnt = 0;
+
        job->timeout = req->timeout;

        if (req->bio) {


BRs,
Jonghwi,
