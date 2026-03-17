Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010063.outbound.protection.outlook.com [52.101.56.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44ADA3CB2DB;
	Tue, 17 Mar 2026 13:25:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773753903; cv=fail; b=s09RhvmG4ooBpi3zbKXcXOYzfJazTYWcF+Sr+ACswNaTLj1sQE86O1jcgiPZ30fAOBI8T2R1X3LRUfOR6b2TNloQebtadL3D+AxQ+mMQ7q9BioTU5FzB18Q6YI67rQfgAh7Oq2gXEEw6VtoqXYEd4n71cP8mrbvnYlKdCeQE+LQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773753903; c=relaxed/simple;
	bh=DcHN7COMb1QMMJbclEVTSMJ7qrIEbqFsqrfHQf5pp3w=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V5/4plvojZZGSPx7VOE5di1ytrHlZZH0l2qWiN/RS/lt9H7iIE2t/pwY/BISSa2ujMal4afupfrrpHWoqeNnmjHshqzR8RqDXD53G6WY2/l+Nc+E6nQomU9gVwIlj3uTmjv5TTSx79lhnjTDsVUdP/hVg/L1Pw4rizSotndqJK8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=Rri+wWi7; arc=fail smtp.client-ip=52.101.56.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="Rri+wWi7"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WJnSR8WWHitIJZTaAWI6hgQeiNqkzuNe6yP1ciS0Kz2vmVc8Lspy/ucwrJVTw+2qbiQfK+a3F1NMlwbcO3YT+1dXPBOzZENEJfda8sPET9T5DL0F0v8VgPBL4zzhWGL2e3RFBcYvl28REgz2ZRz9YIAbhBCGjhVQgmSJIwiAe28T1RMU+lzJlPTHQdN8nyqupnPF795TRkJlbIBWKjf88R7+2iTT66ZQxdMLF5GJc3rNpEjcOVg59gpZiF9DNrIJvma3IXNttBil4yLmRBPkgJZcwe+CFAdCi9RhewYj4m+zbyNTZlabL2IWqEEFZ7Mxf5RqWkVTOKvDqlOEtl6wEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QCPXZHGMS1ezryfZw/QOq3m392NcOUeHvIYjHcXobT0=;
 b=TmfBSStG22/1+ffO0w5DhlPDKzj3XrksQrLa4qc7fpUSLiRvNfNb3B5+uacyxp5A8LXF/GjF5V86U3pfh/Dm0eXv4jd6OwyGBeOUqkv76ms2ApW0cWHO0ejCQzZxhNcOXHUS85gw9WjfIpJ8hlDytS+8iLOBwEK96eomrbxgZO4f+NibAIwuJ1XBphsXg3lPMXno1h8Jvf9vtCygho1dXcb5hd7WwYdX3CUfp0NoSaAVgNJSytdm/GIdlwq5p0SEpkB65pEh/snR3nLd+ExBAtryz9oL1Di9k9YD7jKk2sjnG56K7J7kgOnCSP8HCegi3+vclRwelKZFWma4WQzcrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.194) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QCPXZHGMS1ezryfZw/QOq3m392NcOUeHvIYjHcXobT0=;
 b=Rri+wWi7niZPQ7VVT4K4nxsga6CNSjYE67JbOc6yClhNbHXQsIdMmsRNkam3vzrVI6lU9GpQ4EqexeRr84x0KvSQG/uUn7ua/fqq5zWuiwehMJGKBPaMYxM7O7vvSXr+MnB5CsyZLh0UT8kEiaGZO+W6bqWcqiBH8o6ae9mFT48=
Received: from CH2PR11CA0020.namprd11.prod.outlook.com (2603:10b6:610:54::30)
 by MN2PR10MB4207.namprd10.prod.outlook.com (2603:10b6:208:198::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.25; Tue, 17 Mar
 2026 13:24:58 +0000
Received: from CH3PEPF0000000D.namprd04.prod.outlook.com
 (2603:10b6:610:54:cafe::8) by CH2PR11CA0020.outlook.office365.com
 (2603:10b6:610:54::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9700.27 via Frontend Transport; Tue,
 17 Mar 2026 13:24:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.194; helo=flwvzet200.ext.ti.com; pr=C
Received: from flwvzet200.ext.ti.com (198.47.21.194) by
 CH3PEPF0000000D.mail.protection.outlook.com (10.167.244.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9700.17 via Frontend Transport; Tue, 17 Mar 2026 13:24:56 +0000
Received: from DFLE207.ent.ti.com (10.64.6.65) by flwvzet200.ext.ti.com
 (10.248.192.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 17 Mar
 2026 08:24:54 -0500
Received: from DFLE202.ent.ti.com (10.64.6.60) by DFLE207.ent.ti.com
 (10.64.6.65) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 17 Mar
 2026 08:24:54 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE202.ent.ti.com
 (10.64.6.60) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Tue, 17 Mar 2026 08:24:54 -0500
Received: from localhost (uda0271908.dhcp.ti.com [128.247.77.70])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 62HDOsYM2750459;
	Tue, 17 Mar 2026 08:24:54 -0500
Date: Tue, 17 Mar 2026 08:24:54 -0500
From: Bin Liu <b-liu@ti.com>
To: Shawn Lin <shawn.lin@linux.dev>
CC: <ulf.hansson@linaro.org>, <axboe@kernel.dk>,
	<linux-block@vger.kernel.org>, <linux-mmc@vger.kernel.org>
Subject: Re: [PATCH] mmc: block: use single block write in retry
Message-ID: <20260317132454.b6i7wp763yj36d3v@iaqt7>
References: <20260310160408.3976760-1-b-liu@ti.com>
 <301ff663-7f18-ae12-f0f8-88c4e4375114@linux.dev>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <301ff663-7f18-ae12-f0f8-88c4e4375114@linux.dev>
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF0000000D:EE_|MN2PR10MB4207:EE_
X-MS-Office365-Filtering-Correlation-Id: e540c5ab-0766-4921-423f-08de84289530
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|36860700016|1800799024|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	pY3B4ZeGpbZDeqMtn9U4Z5BAVMTtgUZQzhSLr0EBTT6OzPpa2oybVDdpWMUMff+avfTReJFu0KaauEqxVM8jaFU4w/Uq0rVOF1l3PNUIm6rZx3M0r6ZMgVNW5oTraiP48efQjAFfSV4MoGOvhlG8SP7GpGHnqMNzzd60/yGlbRLD6Xa8HLDmZQQ9i2Lnrjwffar/+LHsTRFll10rv4qYJPUA4TKvCE9E8Xj9XU5D8y1gPMAA7o1T891VtJZeaaFs7M9xWoTh6TnYCOTmayxtYkDnZ0+ggjmDJfSj9r1zI8L8F6QmlBtBjltG9WlkN2Ispqd1viWHR5Ib5GK0cs/ygRCAHNTsb5EfpIHVg8zGGVfu3k6a+rVn4+hZTCXP0Ph8tqwox4r+DzR2KBzazP0X6csqrHr8sagsRyWShzgWySq+isOe301Zd/co1qQ2MdQukzzjnBHW9WvvjCHFsP8/Mr8/SfiyzChqvQkpMOT/uoKK/qclOhIBSpOpdVwRsJ5RA0dDTkVMyqsixklhY+vItUh6twTHzdOO7JNgZWNvZd/lBSCSk4oTWCTuXoJPdn9k9E69E93u53uahubramUvARi1kdhq0NnsrY2ELtTkmDx2Uy6s8v+8ydFZYyGXpiYvhV7BDziVRsDckXkh/PRsgqa/XWZh/vGELhI28LcoklmyJ62JpTMTFBmkFRrqoNEL/BvbHFTn62dtptemfvVPdv8lD6KxlYv1zeiGToMkz1IWNWos3AkuqfNGc2tWFyusl35xT2OsbY8gZhPVkVIczQ==
X-Forefront-Antispam-Report:
	CIP:198.47.21.194;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:flwvzet200.ext.ti.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(82310400026)(376014)(36860700016)(1800799024)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	ji7pyoxg+KzlQ4EebXa7FQRwk47dTx7rIUcU0U3Lus/djSDUH471QeLeSVi+7pszLcgMhKXt+UQuDSFJl106cCXT6jOvVUvEIDeiJ+Fn2Ou+Jpz2C4L8L9wlFk7RYtNlgJiaVG3H0KneIkKgFgcUtq7CBTS6Skbj4TSnMAIR7/dnRbwYEXeX7jv9DEDeS3B9oqt3v4ZpNGGHpdDSIFG/3A+7hNMNPATWD5x+AIPoIcuBkw36L1Im/kMT5aJNa3pIZiPzuuqbnvaM2XptHTXfmqYQhiyf86/F1Ui6wU9xcSF9vPFdRYEcssjS0Vw6wqh0g6blR6dp5LFBqnHLXjDPYjgo2FeoKSP5Z1N3+G3gISRTuNd8jyj02WBLB2fnsw24iT+kUIK9T/pkwWk0uJGzySJgzC4DdHOXD0NgESPsj6qzxNec0Ang6MZuJX52jz7L
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2026 13:24:56.8773
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e540c5ab-0766-4921-423f-08de84289530
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.21.194];Helo=[flwvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH3PEPF0000000D.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB4207

Hi Shawn,

On Tue, Mar 17, 2026 at 08:46:40PM +0800, Shawn Lin wrote:
> 在 2026/03/11 星期三 0:04, Bin Liu 写道:
> > Due to errata i2493[0], multi-block write would still fail in retries.
> > 
> > This patch reuses recovery_mode flag, and switches to single-block
> > write in retry when multi-block write fails. It covers both CQE and
> > non-CQE cases.
> 
> MMC core natively retries single for multi block read. So I assume
> what you are trying to do is make it the same for write path. We didn't

Yes I am trying something similar for writ path, but

> resort to upper block layer for help for read case in the past, so  I
> think you could still achieve that within the scope of MMC core.

unlike the read path solution, I didn't solve the issue within the scope
of MMC core, becaure it would intruduce more code than this patch does,
especially the CQE and non-CQE cases have different failure path. (I
didn't try to figure out how the single block read retry covers both
failure cases...)

I feel the solution in this patch is more clever with less code
introduced.

> 
> More importantly, what is the failure rate of this issue? If it occurs

Very rare. For example, on the EVM, the issue can only be triggered by
writing 3 or more blocks of data pattern 0xFF00. 

> frequently, we should consider this a significant hardware defect. In
> that case, the host driver could register a multi_io_quirk to apply
> certain restrictions on the write path. This approach has been used
> previously on TI OMAP platforms.

-Bin.

> 
> > 
> > [0] https://www.ti.com/lit/pdf/sprz582
> > Signed-off-by: Bin Liu <b-liu@ti.com>
> > ---
> >   block/blk-mq-debugfs.c   |  1 +
> >   drivers/mmc/core/block.c | 12 ++++++++++--
> >   include/linux/blk-mq.h   |  3 +++
> >   3 files changed, 14 insertions(+), 2 deletions(-)
> > 
> > diff --git a/block/blk-mq-debugfs.c b/block/blk-mq-debugfs.c
> > index 28167c9baa55..5f97d07fa3c8 100644
> > --- a/block/blk-mq-debugfs.c
> > +++ b/block/blk-mq-debugfs.c
> > @@ -243,6 +243,7 @@ static const char *const rqf_name[] = {
> >   	RQF_NAME(ZONE_WRITE_PLUGGING),
> >   	RQF_NAME(TIMED_OUT),
> >   	RQF_NAME(RESV),
> > +	RQF_NAME(XFER_SINGLE_BLK),
> >   };
> >   #undef RQF_NAME
> > diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
> > index 05ee76cb0a08..00016584d70d 100644
> > --- a/drivers/mmc/core/block.c
> > +++ b/drivers/mmc/core/block.c
> > @@ -1401,6 +1401,9 @@ static void mmc_blk_data_prep(struct mmc_queue *mq, struct mmc_queue_req *mqrq,
> >   		    rq_data_dir(req) == WRITE &&
> >   		    (md->flags & MMC_BLK_REL_WR);
> > +	if (req->rq_flags & RQF_XFER_SINGLE_BLK)
> > +		recovery_mode = 1;
> > +
> >   	memset(brq, 0, sizeof(struct mmc_blk_request));
> >   	mmc_crypto_prepare_req(mqrq);
> > @@ -1540,10 +1543,13 @@ static void mmc_blk_cqe_complete_rq(struct mmc_queue *mq, struct request *req)
> >   		err = 0;
> >   	if (err) {
> > -		if (mqrq->retries++ < MMC_CQE_RETRIES)
> > +		if (mqrq->retries++ < MMC_CQE_RETRIES) {
> > +			if (rq_data_dir(req) == WRITE)
> > +				req->rq_flags |= RQF_XFER_SINGLE_BLK;
> >   			blk_mq_requeue_request(req, true);
> > -		else
> > +		} else {
> >   			blk_mq_end_request(req, BLK_STS_IOERR);
> > +		}
> >   	} else if (mrq->data) {
> >   		if (blk_update_request(req, BLK_STS_OK, mrq->data->bytes_xfered))
> >   			blk_mq_requeue_request(req, true);
> > @@ -2085,6 +2091,8 @@ static void mmc_blk_mq_complete_rq(struct mmc_queue *mq, struct request *req)
> >   	} else if (!blk_rq_bytes(req)) {
> >   		__blk_mq_end_request(req, BLK_STS_IOERR);
> >   	} else if (mqrq->retries++ < MMC_MAX_RETRIES) {
> > +		if (rq_data_dir(req) == WRITE)
> > +			req->rq_flags |= RQF_XFER_SINGLE_BLK;
> >   		blk_mq_requeue_request(req, true);
> >   	} else {
> >   		if (mmc_card_removed(mq->card))
> > diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
> > index 18a2388ba581..06b6e1c4fca3 100644
> > --- a/include/linux/blk-mq.h
> > +++ b/include/linux/blk-mq.h
> > @@ -64,6 +64,7 @@ enum rqf_flags {
> >   	/* ->timeout has been called, don't expire again */
> >   	__RQF_TIMED_OUT,
> >   	__RQF_RESV,
> > +	__RQF_XFER_SINGLE_BLK,
> >   	__RQF_BITS
> >   };
> > @@ -85,6 +86,8 @@ enum rqf_flags {
> >   			((__force req_flags_t)(1 << __RQF_ZONE_WRITE_PLUGGING))
> >   #define RQF_TIMED_OUT		((__force req_flags_t)(1 << __RQF_TIMED_OUT))
> >   #define RQF_RESV		((__force req_flags_t)(1 << __RQF_RESV))
> > +#define RQF_XFER_SINGLE_BLK	\
> > +			((__force req_flags_t)(1 << __RQF_XFER_SINGLE_BLK))
> >   /* flags that prevent us from merging requests: */
> >   #define RQF_NOMERGE_FLAGS \
> > 
