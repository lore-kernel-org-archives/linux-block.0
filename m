Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012047.outbound.protection.outlook.com [40.107.200.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B13E3246F8;
	Mon, 16 Mar 2026 16:23:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773678192; cv=fail; b=JbpNm1ICenVFRiWlOdnfOfcTN9TGmaS51GtCloF6JmUz9dyjUNIc+mABQtAsoO0VfK77N66rzmXXWmBh+gAgyRyYdqCjMU8lFCkuENvYbFa76+Vlo57yTWGpA0lmYti/htXV2EkLgK5c40y7sk+Nl3GNoYbs9lw3FHdSgsm6NFE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773678192; c=relaxed/simple;
	bh=bCYRNfoa+bMUlQNjKs3hZMdoWBh30VPdKtLmxt/3MKo=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JQFKcXInZlb6g+xyrCGmWuIv5457n6sxcmpOk4fDEomw3e2VeuIX7CbZFwXEjg6rKQcNRxH5V2jAd+9CR1wtZbck7wwFlmTQlCx3oWxMoUPMGsCmSUxqyjeNbyFMJ98BFxLKo+dWeJ+fWY+i5HmYi5GkKQ+oN6TIuKW5uvQEnrQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=u0hWMZRE; arc=fail smtp.client-ip=40.107.200.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="u0hWMZRE"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hMbjPw6w88njRKXKKkCGU254TNjqy9Je6z+gDL5zJ0wWZoWDYJo2rZ7tyE3d3ox4oBxkLXVYczpIMEEn29yCzMY///WKdHbM1ePVf8jizQsIaJNxbDlib6PJ8bH0pLm9ikuZEwTr4eTWM1Lrt5YQxoI8Gsbkoyod3jI2fSzpI4prV1aYLlZFyZm/zYzCveInn8flVCDObekxFIWP6sjAq6Qwuh4Cs1BVDp7rEnuuylSj9pc2P1JR++JgGvpF39bCGEcLHPQJSh2Sral5TyzWnTaz98rM2+LbEuhrdGb9sg8cdDAqq0HhCFcURsuxXnQCw29r+Img2ZjuCTRUTjaCYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7Lit4y01UNtDWTJZDnU3i/cRZKcooqqhaET5CFD2Deg=;
 b=GpLTrdPYhf/PHNiOmLNyk0q90WKVeNRdHuvjJJcxU9RzMxrYSZoQkJq9EBKc7S7r4lQkciUAIyb15UpZqclO2KaVXKOOQNW8zIaPeQIULtMZ80qwGWHicgUs1NziLGg+9rM3oxcvUf0r3A3bhsR0FmqtVfsK87RIXgfOYYaaWaeJnGZj0EA3II8WD66cElPFt2b/8NyQ9DbjBJWlj4GhEAI7VWLuBLDkkHdq6VNPvt97+p8mJa30ZlhGUWDYc0SAsKmcouvlFQWHDGCcf1xXhnKkGFrKIXfJEKqujWAsT633j+JVfMGf8NqXgoZZP+Q8yhawDcBScKRlnohLMT/Rcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=kernel.dk smtp.mailfrom=ti.com; dmarc=pass
 (p=quarantine sp=none pct=100) action=none header.from=ti.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7Lit4y01UNtDWTJZDnU3i/cRZKcooqqhaET5CFD2Deg=;
 b=u0hWMZREEDBGXHC46kHxnK1tcY85wZCRBmwx2d7ud16YoksHk9PQ82hmp5fBXiZgB1uCDw/7LJJriVMAhTKAnOCZD0mOpzUv4Q8fZKHFFbdVKleqXqn4R+aNY67W+q98h9DumuxlIy6plyu/mEYbJApxdHZJhkyogNnEbODnNlY=
Received: from CH2PR17CA0026.namprd17.prod.outlook.com (2603:10b6:610:53::36)
 by DS4PPFF0E76365E.namprd10.prod.outlook.com (2603:10b6:f:fc00::d57) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.24; Mon, 16 Mar
 2026 16:23:08 +0000
Received: from CH1PEPF0000AD77.namprd04.prod.outlook.com
 (2603:10b6:610:53:cafe::c1) by CH2PR17CA0026.outlook.office365.com
 (2603:10b6:610:53::36) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9700.25 via Frontend Transport; Mon,
 16 Mar 2026 16:22:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 CH1PEPF0000AD77.mail.protection.outlook.com (10.167.244.55) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9700.17 via Frontend Transport; Mon, 16 Mar 2026 16:23:07 +0000
Received: from DFLE205.ent.ti.com (10.64.6.63) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 16 Mar
 2026 11:22:41 -0500
Received: from DFLE212.ent.ti.com (10.64.6.70) by DFLE205.ent.ti.com
 (10.64.6.63) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 16 Mar
 2026 11:22:41 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE212.ent.ti.com
 (10.64.6.70) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Mon, 16 Mar 2026 11:22:41 -0500
Received: from localhost (uda0271908.dhcp.ti.com [128.247.77.70])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 62GGMfp41109000;
	Mon, 16 Mar 2026 11:22:41 -0500
Date: Mon, 16 Mar 2026 11:22:41 -0500
From: Bin Liu <b-liu@ti.com>
To: Ulf Hansson <ulf.hansson@linaro.org>
CC: <linux-block@vger.kernel.org>, <linux-mmc@vger.kernel.org>,
	<axboe@kernel.dk>
Subject: Re: [PATCH] mmc: block: use single block write in retry
Message-ID: <20260316162241.2zry4hjmufiwphmg@iaqt7>
References: <20260310160408.3976760-1-b-liu@ti.com>
 <CAPDyKFrM92eAxCxU9E1eDNfXMdOC4JvAOXYgY=HcmFG2YfrQEg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CAPDyKFrM92eAxCxU9E1eDNfXMdOC4JvAOXYgY=HcmFG2YfrQEg@mail.gmail.com>
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD77:EE_|DS4PPFF0E76365E:EE_
X-MS-Office365-Filtering-Correlation-Id: fc0d4a18-9b28-4b66-1c7a-08de83784ea6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|82310400026|36860700016|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	KRYHgwsdjEU9VIXQPWzWvHNHriSddFN+24QDpAwa/cQcLFdBCVjgFmETiyKpzc4dvN1ySHAFmphgYZjo9IsPmbE+HhO3bDIFVjdOnYUL56ltlDleG3iuSknian2cAJSIFUGa2JuALS/QaAxSDe5oMlhreuoxY3J/jOCPSKocygHf2tygM+4kVPz5VE9lJ64vB8fs1ZjlQOA9tpHHq/KTXRmznPpIrO3eTkKoTz+ZMfXRnQqB0K22+5TsuOa9hvGWiHb/3tQF1Z211hopq46F1c2tOXH7AL6oq+NW38yIj/5/nJQh5sHt09eQvivcsKQGwILPD3hEhpY+Yya4l0WEhB+deqUjTRysbdgOgfQKU71/iY0Lj9Qu2zOYSADFftpSWaa2kWxyU6g1d+MZXNGv8A9j4Cppq4YVggtSNENXt8eCoMwIsHfGlLgqwAyyv68BMMO0XGtVhGvv8zBdQlkHO88DSYoe4hD5jubsMlnnMmxkIl6GUnT9OO5HgOiE7BKL2EA3S872hEfbYE6V21jdIfPfEINAXxbh4VmiU8a44uZmgXAmHm+Kg9isPMk5Twpn/VILcEiEV2e7v7D/q2dPqzrn91wBLDJUjUF3gI8fK9xiUFAbVUKAUlXTJpRYNJx1KZYmWGkRmXN+q1mmEuDf586EGn6eh9Qiq5lOHU6ClxWCSnzuGnqZoVcJpDlemRjKBW4pCAUOdL6sa6pnQNSSTQ1oHcMOUoL9MUhLFnuGxohx8/Lu7yjy+lJ1rp0tYVAwJ8wQStd7E+165whPigRmfg==
X-Forefront-Antispam-Report:
	CIP:198.47.21.195;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:flwvzet201.ext.ti.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(376014)(1800799024)(82310400026)(36860700016)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	cdyCHgJxFnt0OOMYXff9NU5ctvqKUw+yLXn2URnBmhXpvvlRt/LSC10SlIB/tLUByDvw6cZEFoKaFnTwRSTsF0VwM8lJmBF2HT/JUqWBozl5QPQhOW8I8ZvKBYDPoLyfDa4wuY6EwNbUppuVoN7J7JtxlcgJItAvP21zYEHAsu6RVT1Pg/nVHryO+RDyAlqqeAjoJy/ooE/2OaJdSbozfBaEFuBmQ7xStTrRbh/WJe5yw4oaH92Fcqr1j8zr1hn0V/eBIMmYSVLssVrQCwBnswBTn40pDyuY0LwHSXNXZLGWjrh4UK2/C0YduyCM0u1mObXNMPv9PzPFf+6NUcKs1jFB1ByGHXG348WK6jlGAoeLDnfLhwC1jplfSrceARbAHUMwu4/yTq6etqhYnJOx1Qtfc4aVUzpFrQKIeg+DSo8y4MTJPnZcxwUwDaEb+XEB
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Mar 2026 16:23:07.0941
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fc0d4a18-9b28-4b66-1c7a-08de83784ea6
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.21.195];Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000AD77.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PPFF0E76365E

Hi Ulf,

On Mon, Mar 16, 2026 at 04:01:38PM +0100, Ulf Hansson wrote:
> On Tue, 10 Mar 2026 at 17:04, Bin Liu <b-liu@ti.com> wrote:
> >
> > Due to errata i2493[0], multi-block write would still fail in retries.
> >
> > This patch reuses recovery_mode flag, and switches to single-block
> > write in retry when multi-block write fails. It covers both CQE and
> > non-CQE cases.
> >
> > [0] https://www.ti.com/lit/pdf/sprz582
> 
> It's great that a link like the above can be provided, still it would
> be nice to explain a bit more about the problem in the commit message
> too. Can you please do that?

Sure I will add the errata details in the commit message in v2.

> 
> > Signed-off-by: Bin Liu <b-liu@ti.com>
> > ---
> >  block/blk-mq-debugfs.c   |  1 +
> >  drivers/mmc/core/block.c | 12 ++++++++++--
> >  include/linux/blk-mq.h   |  3 +++
> >  3 files changed, 14 insertions(+), 2 deletions(-)
> >
> > diff --git a/block/blk-mq-debugfs.c b/block/blk-mq-debugfs.c
> > index 28167c9baa55..5f97d07fa3c8 100644
> > --- a/block/blk-mq-debugfs.c
> > +++ b/block/blk-mq-debugfs.c
> > @@ -243,6 +243,7 @@ static const char *const rqf_name[] = {
> >         RQF_NAME(ZONE_WRITE_PLUGGING),
> >         RQF_NAME(TIMED_OUT),
> >         RQF_NAME(RESV),
> > +       RQF_NAME(XFER_SINGLE_BLK),
> >  };
> >  #undef RQF_NAME
> >
> > diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
> > index 05ee76cb0a08..00016584d70d 100644
> > --- a/drivers/mmc/core/block.c
> > +++ b/drivers/mmc/core/block.c
> > @@ -1401,6 +1401,9 @@ static void mmc_blk_data_prep(struct mmc_queue *mq, struct mmc_queue_req *mqrq,
> >                     rq_data_dir(req) == WRITE &&
> >                     (md->flags & MMC_BLK_REL_WR);
> >
> > +       if (req->rq_flags & RQF_XFER_SINGLE_BLK)
> > +               recovery_mode = 1;
> > +
> 
> I don't get this, sorry.

No worries, the logic of this solution is not that obvious.

In summary of this patch, in both CQE-enabled and non-CQE cases, in
*_complete_rq(), flag RQF_XFER_SINGLE_BLK is set in req->rq_flags when
WRITE request fails. This is to mark that single-block write, according
to errata i2493, should be used in retrying this WRITE request. 

In retrying, mmc_blk_data_prep() is called again with
RQF_XFER_SINGLE_BLK set, this makes recovery_mode to be forced to 1,

then a few lines down in mmc_blk_data_prep():

	if (recovery_mode)
		brq->data.blocks = queue_physical_block_size(mq->queue) >> 9;

The req block size is set to 1 to use single block write.

Please let me know if this explains the logic of this patch.

> 
> Under what circumstances do we need to fall back to using "single
> block"? Or is this just for debugging?

When multiple block write fails, use single block write. This is
the software workaround documented in the errata i2493.

This is not for debugging. When multiple block write fails, switching
to single block write will sccuseed.

-Bin.

> 
> >         memset(brq, 0, sizeof(struct mmc_blk_request));
> >
> >         mmc_crypto_prepare_req(mqrq);
> > @@ -1540,10 +1543,13 @@ static void mmc_blk_cqe_complete_rq(struct mmc_queue *mq, struct request *req)
> >                 err = 0;
> >
> >         if (err) {
> > -               if (mqrq->retries++ < MMC_CQE_RETRIES)
> > +               if (mqrq->retries++ < MMC_CQE_RETRIES) {
> > +                       if (rq_data_dir(req) == WRITE)
> > +                               req->rq_flags |= RQF_XFER_SINGLE_BLK;
> >                         blk_mq_requeue_request(req, true);
> > -               else
> > +               } else {
> >                         blk_mq_end_request(req, BLK_STS_IOERR);
> > +               }
> >         } else if (mrq->data) {
> >                 if (blk_update_request(req, BLK_STS_OK, mrq->data->bytes_xfered))
> >                         blk_mq_requeue_request(req, true);
> > @@ -2085,6 +2091,8 @@ static void mmc_blk_mq_complete_rq(struct mmc_queue *mq, struct request *req)
> >         } else if (!blk_rq_bytes(req)) {
> >                 __blk_mq_end_request(req, BLK_STS_IOERR);
> >         } else if (mqrq->retries++ < MMC_MAX_RETRIES) {
> > +               if (rq_data_dir(req) == WRITE)
> > +                       req->rq_flags |= RQF_XFER_SINGLE_BLK;
> >                 blk_mq_requeue_request(req, true);
> >         } else {
> >                 if (mmc_card_removed(mq->card))
> > diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
> > index 18a2388ba581..06b6e1c4fca3 100644
> > --- a/include/linux/blk-mq.h
> > +++ b/include/linux/blk-mq.h
> > @@ -64,6 +64,7 @@ enum rqf_flags {
> >         /* ->timeout has been called, don't expire again */
> >         __RQF_TIMED_OUT,
> >         __RQF_RESV,
> > +       __RQF_XFER_SINGLE_BLK,
> >         __RQF_BITS
> >  };
> >
> > @@ -85,6 +86,8 @@ enum rqf_flags {
> >                         ((__force req_flags_t)(1 << __RQF_ZONE_WRITE_PLUGGING))
> >  #define RQF_TIMED_OUT          ((__force req_flags_t)(1 << __RQF_TIMED_OUT))
> >  #define RQF_RESV               ((__force req_flags_t)(1 << __RQF_RESV))
> > +#define RQF_XFER_SINGLE_BLK    \
> > +                       ((__force req_flags_t)(1 << __RQF_XFER_SINGLE_BLK))
> >
> >  /* flags that prevent us from merging requests: */
> >  #define RQF_NOMERGE_FLAGS \
> > --
> > 2.34.1
> >
> 
> Kind regards
> Uffe
