Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010011.outbound.protection.outlook.com [52.101.46.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F9EB1DF980;
	Mon, 23 Mar 2026 13:05:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774271149; cv=fail; b=MVmHR3/i4qQKLS0SldPM4ctEHNrNqRO9AKG1SNdTwa1EnYjVkM9lo1X5t2He+pKzWqiskwUzPFSN8r2Wmwv6cxUHnajZydak/mNCCETug3/+cQuHaZNnd3axhhG0tFQm4WkvkheS9bCFEq2hdFxbNdeBp4SWIqqEHNRjDfnkga8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774271149; c=relaxed/simple;
	bh=427wGycL5ey6to/S8jN+keboAslm4lg2qnwIQLysVLM=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TO7xMcyShG3uCsObHKKh+OMtamGzEfOkJQad4U6wu/2Ztuwvh5uQUnA8RTghjBJ0YoDhN1rpKYc73XRv904BmS3iUR6PUL4bXI9o59oqWOkppohwaUHzNLu/CT3LBNrxdR3KQFjLICHg/CJHBNZJ9Eo0CBu9jYn4O3ads8+DX1E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=caUeKO53; arc=fail smtp.client-ip=52.101.46.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="caUeKO53"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NSJRMI5l51OOUzP5L9zGtLqj553sdAVcSNwaM5PcPXC6dptCX2bE95vZZ1albEOn4Hhb0MNE0h7BtpXC8Ugg20s+Rqesc4NsLLA7l8KUytYugvwwebkzVoOu8cfb3V/kn0BEcBwDNOrpp8Nw2OxrSObhU+/OoQ4Hww8HDJ/vt6CuZzV6TMEJp/BPANGWaY7LVc+7b510b177hJ/0gkg+E0k8jYQI2n8TfHb6BjsiyjC7vfYFTjDB2DgXR9kZanPoGLWyTUyUICECbOj9GXkezqIZcJrEvCSMrnCJ/j/c3C8UsvIiAOMggD5P4VbmqdfrNWhiunGJ2vta95ucG7c1WQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/SIfnfly2JQwu1daxw4aXVtV96O2QvSorFOik2q52DA=;
 b=u1NlRMSzSK4x270l4IBzfZoJPq8Nl6Kbu4AZ4XNYQuRY9yu26kxq1df5gko6XJMJXvVs+rsZVgB9epHLgq6F/w0B4oagCxe/aIVqweznl7k3CjzTHldUtyUW4efS6D9gzw05H3I/F/JWEpB0+D3QgYqczy0RQiYmpO84SNVAhFBm3MlavcnlIu3KT4gL4bl29mZvV/3mvWfBy+RDeTNBtRB25mFrpao6a2RxdNDUS6fidM/lvodFNf31e5hDeaslKzqBWP/AnESips+K6dm1qMoLs0hCke/ynX6NCj4cGATt/+VrZQVxcfGZXdldNmsdgK4lHIg+8MTvLOMJWJcrVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/SIfnfly2JQwu1daxw4aXVtV96O2QvSorFOik2q52DA=;
 b=caUeKO53FUyeJtHPS1QBTE9t+7RmrvxsOAkCMiGE+aUNtcWnd7mgpH1lLCsaukA+5bKKsXmLC60VGgaT+YhF8vQbLJFDb9T4eNvrNGQ+3PBRYst5zfRlEvuY6AVrFWrOAy/euWpyE0AqsDhYPHw153Ju9DKoNtlaRn8U8ummtTA=
Received: from MW4PR04CA0333.namprd04.prod.outlook.com (2603:10b6:303:8a::8)
 by DS0PR10MB997650.namprd10.prod.outlook.com (2603:10b6:8:313::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.31; Mon, 23 Mar
 2026 13:05:45 +0000
Received: from MWH0EPF000C618B.namprd02.prod.outlook.com
 (2603:10b6:303:8a:cafe::b5) by MW4PR04CA0333.outlook.office365.com
 (2603:10b6:303:8a::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9723.25 via Frontend Transport; Mon,
 23 Mar 2026 13:05:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 MWH0EPF000C618B.mail.protection.outlook.com (10.167.249.123) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9723.19 via Frontend Transport; Mon, 23 Mar 2026 13:05:43 +0000
Received: from DFLE207.ent.ti.com (10.64.6.65) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 23 Mar
 2026 08:05:34 -0500
Received: from DFLE205.ent.ti.com (10.64.6.63) by DFLE207.ent.ti.com
 (10.64.6.65) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 23 Mar
 2026 08:05:34 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE205.ent.ti.com
 (10.64.6.63) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Mon, 23 Mar 2026 08:05:34 -0500
Received: from localhost (uda0271908.dhcp.ti.com [128.247.77.70])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 62ND5XvW791610;
	Mon, 23 Mar 2026 08:05:34 -0500
Date: Mon, 23 Mar 2026 08:05:33 -0500
From: Bin Liu <b-liu@ti.com>
To: Shawn Lin <shawn.lin@linux.dev>
CC: <ulf.hansson@linaro.org>, <axboe@kernel.dk>,
	<linux-block@vger.kernel.org>, <linux-mmc@vger.kernel.org>
Subject: Re: [PATCH] mmc: block: use single block write in retry
Message-ID: <20260323130533.y7byr3atch32stn5@iaqt7>
References: <20260310160408.3976760-1-b-liu@ti.com>
 <301ff663-7f18-ae12-f0f8-88c4e4375114@linux.dev>
 <20260317132454.b6i7wp763yj36d3v@iaqt7>
 <1806373b-d402-5655-94d4-5cf7142e1382@linux.dev>
 <20260318151735.ffjhbzz4x32n5i7h@iaqt7>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260318151735.ffjhbzz4x32n5i7h@iaqt7>
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000C618B:EE_|DS0PR10MB997650:EE_
X-MS-Office365-Filtering-Correlation-Id: 69a1bf14-b63f-4046-dcdd-08de88dce471
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700016|376014|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	yM+ttbfff6+cdafz5fL/hEPU/MFZ1N8CR3ppWmBhHfbWCo+U8FPYhIqBE+lYd6c6r4cr35oc5QOJqFzHF8N/LWIdrajDY3sBErvk4rCPVBxwf25PGcQlUQ/UZfqGM3mpw48M0j8vqNvcSDy0+67Po+KzBrSChDIXDbuJvGkCOmjqsP+I6qECVr/rjb6F2vyAgjudewFaYb3GVZlEkoYpB/G0qmKP/pRuMTIRuXGUfIqGhSfoJYiibz1c/h6/J2X8H/uinPHFqzb2q/IKlF6pveag2ehy0N6Yk8djX2JospFWhkO9lO1NCYdEUVbHECWU5jBVoa10UIxZym6R//kVVxhbb77b0itjQHw7eU5yrOjSOluh7GdcTl9SoFhu0xvub98Dwzq5SsI9QlaqoWYmJj9wJmgxliXHaRKwHxVaZUjY76I9IgXrlvFsVDK8Mgp2hvXZqUAaNbfON0/mY3A6BGPEnwP7W5WZyI0j7k80n5ZwBw6Yf7EJny/gVHOWMwiAnJy332hBC8VO5sEbiZgwqLjy0Kc3N66w3+Vggz3/VlhJK/JugjRNHf2A+OToqBRA0ofBimduhK9GQla9HvJEjGuEtPUUwd2psJyDN/wKmDcWhAXbCPpvLzMt6+NQEBH4+bvy21q+4vb0BALAUJiiZb0i6g/KV0XnpKXrRKAxbEN0hXXR9B7LT3eE/TJ5NICGcy/IJvT/2T6VoJhcgNuvZUnpsBNwjltoGhidYJzBVbmNrOebx6zIE0rEmXQ1QTjhUfZsvWFn4wAvVU3WuPYNcA==
X-Forefront-Antispam-Report:
	CIP:198.47.21.195;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:flwvzet201.ext.ti.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700016)(376014)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	VhD1afiIunvoKrv7fCuiIxWYV8fsL5x1NNx5l5s4ZAK6Wpzu04inaJRloVd44MkJ9E3SZ0RYeH1LiDDM+pO8qgxMPa1u0wQYFulYgDpSHbBKpEP2qavZyWu8N9qJBuJx5jNW6fGwZu0dtvdB23V746D6MPLJfnYYDk4+vE1EmuDO6I8k9ipjc99pP/08MaQz1TPInV2Fh2NjxGb80dFk9Z3unC0ASj3SRzhhmBUpp76DAcc9m7yu+1eQq8hbdr13EAbCKULrdnYjRo1r8W0zjiSPETmzIQ5GoVVeXTr4Cqp0U5dje2LwqV6wYlpFrzkD69E0as5hVn16rA8tJKDwf2/AgEH+5Vl+vZPfzKfGvhBvqOWcD0ELBks3+Y3slzQnlvUn8zI41sNxicXvLA6JKhcss8QSmtqzyD7vFGkUi1RWrJwdraygRrSLVthFFfgs
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2026 13:05:43.8759
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 69a1bf14-b63f-4046-dcdd-08de88dce471
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.21.195];Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000C618B.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB997650

Hi,

On Wed, Mar 18, 2026 at 10:17:35AM -0500, Bin Liu wrote:
> Hi Shawn,
> 
> On Wed, Mar 18, 2026 at 09:43:10AM +0800, Shawn Lin wrote:
> > 在 2026/03/17 星期二 21:24, Bin Liu 写道:
> > > Hi Shawn,
> > > 
> > > On Tue, Mar 17, 2026 at 08:46:40PM +0800, Shawn Lin wrote:
> > > > 在 2026/03/11 星期三 0:04, Bin Liu 写道:
> > > > > Due to errata i2493[0], multi-block write would still fail in retries.
> > > > > 
> > > > > This patch reuses recovery_mode flag, and switches to single-block
> > > > > write in retry when multi-block write fails. It covers both CQE and
> > > > > non-CQE cases.
> > > > 
> > > > MMC core natively retries single for multi block read. So I assume
> > > > what you are trying to do is make it the same for write path. We didn't
> > > 
> > > Yes I am trying something similar for writ path, but
> > > 
> > > > resort to upper block layer for help for read case in the past, so  I
> > > > think you could still achieve that within the scope of MMC core.
> > > 
> > > unlike the read path solution, I didn't solve the issue within the scope
> > > of MMC core, becaure it would intruduce more code than this patch does,
> > > especially the CQE and non-CQE cases have different failure path. (I
> > > didn't try to figure out how the single block read retry covers both
> > > failure cases...)
> > > 
> > > I feel the solution in this patch is more clever with less code
> > > introduced.
> > > 
> > > > 
> > > > More importantly, what is the failure rate of this issue? If it occurs
> > > 
> > > Very rare. For example, on the EVM, the issue can only be triggered by
> > > writing 3 or more blocks of data pattern 0xFF00.
> > 
> > I manually modified cqhci and sdhci to inject errors for multi-block
> > writes under both CQE and non-CQE modes. The following patch appears to
> > work by testing. Could you please test it?
> > 
> > diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
> > index 05ee76cb0a08..ca60991a3305 100644
> > --- a/drivers/mmc/core/block.c
> > +++ b/drivers/mmc/core/block.c
> > @@ -1642,13 +1642,13 @@ static int mmc_blk_cqe_issue_flush(struct mmc_queue
> > *mq, struct request *req)
> >  	return mmc_blk_cqe_start_req(mq->card->host, mrq);
> >  }
> > 
> > -static int mmc_blk_hsq_issue_rw_rq(struct mmc_queue *mq, struct request
> > *req)
> > +static int mmc_blk_hsq_issue_rw_rq(struct mmc_queue *mq, struct request
> > *req, int recovery_mode)
> >  {
> >  	struct mmc_queue_req *mqrq = req_to_mmc_queue_req(req);
> >  	struct mmc_host *host = mq->card->host;
> >  	int err;
> > 
> > -	mmc_blk_rw_rq_prep(mqrq, mq->card, 0, mq);
> > +	mmc_blk_rw_rq_prep(mqrq, mq->card, recovery_mode, mq);
> >  	mqrq->brq.mrq.done = mmc_blk_hsq_req_done;
> >  	mmc_pre_req(host, &mqrq->brq.mrq);
> > 
> > @@ -1663,13 +1663,23 @@ static int mmc_blk_cqe_issue_rw_rq(struct mmc_queue
> > *mq, struct request *req)
> >  {
> >  	struct mmc_queue_req *mqrq = req_to_mmc_queue_req(req);
> >  	struct mmc_host *host = mq->card->host;
> > +	int err;
> > 
> > -	if (host->hsq_enabled)
> > -		return mmc_blk_hsq_issue_rw_rq(mq, req);
> > +	if (host->hsq_enabled) {
> > +		err = mmc_blk_hsq_issue_rw_rq(mq, req, 0);
> > +		if (err)
> > +			return mmc_blk_hsq_issue_rw_rq(mq, req, 1);
> > +	}
> > 
> >  	mmc_blk_data_prep(mq, mqrq, 0, NULL, NULL);
> > 
> > -	return mmc_blk_cqe_start_req(mq->card->host, &mqrq->brq.mrq);
> > +	err = mmc_blk_cqe_start_req(mq->card->host, &mqrq->brq.mrq);
> > +	if (err) {
> 
> In the CQE case, when the problem happens due to the errata, this
> function won't return error. The MMC write error is reported in
> mmc_blk_cqe_complete_rq() if you see my original patch.

Which route should we go forward, continue to refine this patch or any
more comments to my original patch?

Thanks,
-Bin.

> 
> -Bin.
> 
> > +		mmc_blk_data_prep(mq, mqrq, 1, NULL, NULL);
> > +		return mmc_blk_cqe_start_req(mq->card->host, &mqrq->brq.mrq);
> > +	}
> > +
> > +	return 0;
> >  }
> > 
> >  static void mmc_blk_rw_rq_prep(struct mmc_queue_req *mqrq,
> > @@ -1776,24 +1786,26 @@ static int mmc_blk_fix_state(struct mmc_card *card,
> > struct request *req)
> >  	return err;
> >  }
> > 
> > -#define MMC_READ_SINGLE_RETRIES	2
> > +#define MMC_RW_SINGLE_RETRIES	2
> > 
> > -/* Single (native) sector read during recovery */
> > -static void mmc_blk_read_single(struct mmc_queue *mq, struct request *req)
> > +/* Single (native) sector read or write during recovery */
> > +static void mmc_blk_rw_single(struct mmc_queue *mq, struct request *req)
> >  {
> >  	struct mmc_queue_req *mqrq = req_to_mmc_queue_req(req);
> >  	struct mmc_request *mrq = &mqrq->brq.mrq;
> >  	struct mmc_card *card = mq->card;
> >  	struct mmc_host *host = card->host;
> >  	blk_status_t error = BLK_STS_OK;
> > -	size_t bytes_per_read = queue_physical_block_size(mq->queue);
> > +	size_t bytes_per_rw = queue_physical_block_size(mq->queue);
> > +
> > 
> >  	do {
> >  		u32 status;
> >  		int err;
> >  		int retries = 0;
> > 
> > -		while (retries++ <= MMC_READ_SINGLE_RETRIES) {
> > +		while (retries++ <= MMC_RW_SINGLE_RETRIES) {
> >  			mmc_blk_rw_rq_prep(mqrq, card, 1, mq);
> > 
> >  			mmc_wait_for_req(host, mrq);
> > @@ -1821,13 +1833,13 @@ static void mmc_blk_read_single(struct mmc_queue
> > *mq, struct request *req)
> >  		else
> >  			error = BLK_STS_OK;
> > 
> > -	} while (blk_update_request(req, error, bytes_per_read));
> > +	} while (blk_update_request(req, error, bytes_per_rw));
> > 
> >  	return;
> > 
> >  error_exit:
> >  	mrq->data->bytes_xfered = 0;
> > -	blk_update_request(req, BLK_STS_IOERR, bytes_per_read);
> > +	blk_update_request(req, BLK_STS_IOERR, bytes_per_rw);
> >  	/* Let it try the remaining request again */
> >  	if (mqrq->retries > MMC_MAX_RETRIES - 1)
> >  		mqrq->retries = MMC_MAX_RETRIES - 1;
> > @@ -1969,12 +1981,9 @@ static void mmc_blk_mq_rw_recovery(struct mmc_queue
> > *mq, struct request *req)
> >  		return;
> >  	}
> > 
> > -	if (rq_data_dir(req) == READ && brq->data.blocks >
> > -			queue_physical_block_size(mq->queue) >> 9) {
> > -		/* Read one (native) sector at a time */
> > -		mmc_blk_read_single(mq, req);
> > -		return;
> > -	}
> > +	/* Perform one (native) sector at a time */
> > +	if (brq->data.blocks > queue_physical_block_size(mq->queue) >> 9)
> > +		mmc_blk_rw_single(mq, req);
> >  }
> > 
> >  static inline bool mmc_blk_rq_error(struct mmc_blk_request *brq)
> > 
