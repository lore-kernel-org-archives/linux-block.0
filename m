Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011039.outbound.protection.outlook.com [40.93.194.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4862A2882A7;
	Wed, 18 Mar 2026 15:18:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.39
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773847093; cv=fail; b=jk2ryTPtG/hpX3ZtrPnzni1jPpf2aOkiyZEFe4R1hzAj9wP36gukJaPIWSE3vtLEjHBrxwuacqJWnPT2lm578M1mNZYWzhexUVklcw2T2TkpOrRxodKxsI0sCeNe+mvc33kt0zeSYZQK2LpnBMNuAJdF7YI2Fl3m057jdUXtd4A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773847093; c=relaxed/simple;
	bh=Ji5jtPhxH9q4u7ZhEqp+FXPiLG6mStizp3IrTEs8O+A=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oNf9essl/HYmp6itTyqGf6ZQ3KZvb1SbkaFwR1RMGN1pXV183+CE+gwq+pHqG2mrtHgB46TKDGgIkIkGsmlupBRO4XbquL07/A8EoVEhtRtCDI+7J3BHBShirE/h25O2y2Q6RIT36QsGWEIkDqt/+Oj0sPahGuN5hyjxXq0GLjQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=EPtKKGfc; arc=fail smtp.client-ip=40.93.194.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="EPtKKGfc"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TIombC3u0dmuFBwWVVeQ4q5hvJ3NqDTv2YQz18FAqGnX1TOA/G55xYOoBvFeyfzfQJ3FmKB/0IdwgO09ejZ07RdtC7TtbslldRsHenKt8BSmsofn+b+C8JG1j+InXMDY0YNS7OwqoOXvr2IR5VjKE3KLzae4CREdZ3A7KCjFxzI34hZUQCdn+HjLfL1XJqXwLqhufUcQFkbpa8WIAQdygzhhveh4kTDqRgkDmUF1Nmb2Bz3L0SKh7LauEENZeOXvWkUPo1OWaRyTY0LLX6IcExpGJkwAbP3w3ye+LIAXPLOzS6B9EU6MTVrqjskWEBwEaK5WlNtq6BYNTimuCKzTkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UIsFkftSgSGI4f/3OTMO/fYdJJM3svuGaxCnLeUa8UI=;
 b=e2yJgswrjrGEk0K/fLPjaYTPtEvWQRhpRK5mHev1ettTDHoWukoku1Wfr2aYumcLBrvHQZCUJliVB/78SLIxhH/vNWc0TgBENYkU2+rsR34Tlw5g1YEPVv1cKS0H69XGnwU3MF7LTYfXaw1MyQfMc79q6sAwECat0N2Uyo8LmaPhkwWgY8Wv27AjOV6zf0jZ4OBWrB5eAyj+1sbB78sKvubEss2PrvwXxPQMn4PskImwclq7Ypcad014fVW/SU0gHCSt75acb6C46bDG9kMu7bmr/CZiz5vHzZjhjA40MhSgrNvuWSoW3RZscz18IkwfY8Oqxvi11qw6d9M4Xf23bg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UIsFkftSgSGI4f/3OTMO/fYdJJM3svuGaxCnLeUa8UI=;
 b=EPtKKGfctDMcyKdzni6r8cThoraWkMXrLVvEgKMOYuvEXAS3aMmlOdy+eLFLUHw39cz7DCHgk+/Vgfm1zxifVYYTN8zBPc3X0+OSeTRFSRs3kHIxIGKHeH3GutG/Cp2IsQA2Qk8j+YR7I7xQuosZXSfpFQ7f3HJIBGuyKEuSbeQ=
Received: from CY8PR12CA0016.namprd12.prod.outlook.com (2603:10b6:930:4e::20)
 by CH4PR10MB8097.namprd10.prod.outlook.com (2603:10b6:610:241::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.19; Wed, 18 Mar
 2026 15:18:07 +0000
Received: from CY4PEPF0000EDD5.namprd03.prod.outlook.com
 (2603:10b6:930:4e:cafe::87) by CY8PR12CA0016.outlook.office365.com
 (2603:10b6:930:4e::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9700.27 via Frontend Transport; Wed,
 18 Mar 2026 15:18:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 CY4PEPF0000EDD5.mail.protection.outlook.com (10.167.241.201) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9723.19 via Frontend Transport; Wed, 18 Mar 2026 15:18:05 +0000
Received: from DFLE205.ent.ti.com (10.64.6.63) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 18 Mar
 2026 10:17:35 -0500
Received: from DFLE211.ent.ti.com (10.64.6.69) by DFLE205.ent.ti.com
 (10.64.6.63) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 18 Mar
 2026 10:17:35 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE211.ent.ti.com
 (10.64.6.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Wed, 18 Mar 2026 10:17:35 -0500
Received: from localhost (uda0271908.dhcp.ti.com [128.247.77.70])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 62IFHZSR553305;
	Wed, 18 Mar 2026 10:17:35 -0500
Date: Wed, 18 Mar 2026 10:17:35 -0500
From: Bin Liu <b-liu@ti.com>
To: Shawn Lin <shawn.lin@linux.dev>
CC: <ulf.hansson@linaro.org>, <axboe@kernel.dk>,
	<linux-block@vger.kernel.org>, <linux-mmc@vger.kernel.org>
Subject: Re: [PATCH] mmc: block: use single block write in retry
Message-ID: <20260318151735.ffjhbzz4x32n5i7h@iaqt7>
References: <20260310160408.3976760-1-b-liu@ti.com>
 <301ff663-7f18-ae12-f0f8-88c4e4375114@linux.dev>
 <20260317132454.b6i7wp763yj36d3v@iaqt7>
 <1806373b-d402-5655-94d4-5cf7142e1382@linux.dev>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1806373b-d402-5655-94d4-5cf7142e1382@linux.dev>
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD5:EE_|CH4PR10MB8097:EE_
X-MS-Office365-Filtering-Correlation-Id: 88eff0a7-39a0-4770-53be-08de85018e32
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|82310400026|376014|1800799024|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	wPZZtICxwQxWZIXc0pjCBnBkdiq5J5GyyHya/ETkjzYeTnlrhBcGnZTy/VBb5UzHve+34vf9hsLcwCNBzB+tmgVWZgfftQ712hyNjsC7q3jODjf1lh9Bu7HWxwUKRz/XoBPyvh59cHlK+d6DsgOH25V3VQgZnLFb9eps6IRj90+pVcshVfvJauNK1u3EZsRqRnTv7CRFcbMl0+uGRo0vxKJf3iNC4syMlCPU5WgquFqCjggn8R0N8iGS01O8qarWVma1oouoTRRVzxSMnayDtGy4S4Ag3Fk7CkU1k6OIpgK5Z9HNmg1gck6RB9duqH3WQ4GJcKQgWJipBFU8mon9xW/GoQe8dYTJgAkn87MxkKBHNQGrsdcfTjwR33xG9xsgXr+9JkaYUjJ6gIy24fkszBQaXWQ6c+sGE4P7xS6elUdl1GMd8vDW1EJ9YEpmEZD3iTEgDegjYKPyNZG2LXnJyxGXAgjAWZ4PKNr10gXB3pRF9ptxop40FL33S2NDZp3ehw0aW+otNanrKiZD+tPLaKMSj8lsXIWRrqbgDNLJf4mCOvfHjoxET5T0V+H3+aWcFPsI81aaENbG8g3nY38YNU/MWk0ZcOui9mj4XwylSsSlPs8bB47E3+VS1COpVquZgqUU+35AmHxWnznfPJ43UfnB2EgqVYF0wDb20e+EzZAHUgQifHdb+8ZTvbC2XKP1aHRh1aSvguVM2P8K2BSLDa2ybqZwUNwVxxqzlh5hRyBINTEbWi9BTqKQ9txpy5zG9E4oUetXva8wQRtwHr7XqA==
X-Forefront-Antispam-Report:
	CIP:198.47.21.195;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:flwvzet201.ext.ti.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(36860700016)(82310400026)(376014)(1800799024)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	sWH1iqV6ewJXz3hTZYf+1uQ+DJCIUjgDW/8o8AoqrFkujvHQlxHXO1P1JTcg/bsACPyCfTP1+84V/CFdY3upfUhi7pF6pz4ztTfeAC3EFCCzwXvd2bsITv+exQ9yAGKZORoK7Cd0ROWF98zvaQ8JEOdy5JWEy3wT3pGwbhGNWK6Q6VOzZ9hz9ypkIaCaJGf+ffoVgwgGT+zzrB7QxwwHZS6S+Sw4FkWrTh9p0CI90w8e8/35hEfWtjPH34sSbPFGikiUVxrG8LtWtE4FBQMy8oafVsSFx0rmCp99Y/HwrQU8ttKXiUbBqMNBdpk+MfVYCYnX2nGyuNectGiDYeLLOXBI3vT6yAU6ga0ZFH5UUoGCUDMXUk8T9JQvxWJaF3Nb0AQi6r4nIqTAsohqsJYFyxctsiKg73zWcIHWGIlwz5oZTlpPWqUD4duNXZjNxtIw
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2026 15:18:05.9434
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 88eff0a7-39a0-4770-53be-08de85018e32
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.21.195];Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EDD5.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH4PR10MB8097

Hi Shawn,

On Wed, Mar 18, 2026 at 09:43:10AM +0800, Shawn Lin wrote:
> 在 2026/03/17 星期二 21:24, Bin Liu 写道:
> > Hi Shawn,
> > 
> > On Tue, Mar 17, 2026 at 08:46:40PM +0800, Shawn Lin wrote:
> > > 在 2026/03/11 星期三 0:04, Bin Liu 写道:
> > > > Due to errata i2493[0], multi-block write would still fail in retries.
> > > > 
> > > > This patch reuses recovery_mode flag, and switches to single-block
> > > > write in retry when multi-block write fails. It covers both CQE and
> > > > non-CQE cases.
> > > 
> > > MMC core natively retries single for multi block read. So I assume
> > > what you are trying to do is make it the same for write path. We didn't
> > 
> > Yes I am trying something similar for writ path, but
> > 
> > > resort to upper block layer for help for read case in the past, so  I
> > > think you could still achieve that within the scope of MMC core.
> > 
> > unlike the read path solution, I didn't solve the issue within the scope
> > of MMC core, becaure it would intruduce more code than this patch does,
> > especially the CQE and non-CQE cases have different failure path. (I
> > didn't try to figure out how the single block read retry covers both
> > failure cases...)
> > 
> > I feel the solution in this patch is more clever with less code
> > introduced.
> > 
> > > 
> > > More importantly, what is the failure rate of this issue? If it occurs
> > 
> > Very rare. For example, on the EVM, the issue can only be triggered by
> > writing 3 or more blocks of data pattern 0xFF00.
> 
> I manually modified cqhci and sdhci to inject errors for multi-block
> writes under both CQE and non-CQE modes. The following patch appears to
> work by testing. Could you please test it?
> 
> diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
> index 05ee76cb0a08..ca60991a3305 100644
> --- a/drivers/mmc/core/block.c
> +++ b/drivers/mmc/core/block.c
> @@ -1642,13 +1642,13 @@ static int mmc_blk_cqe_issue_flush(struct mmc_queue
> *mq, struct request *req)
>  	return mmc_blk_cqe_start_req(mq->card->host, mrq);
>  }
> 
> -static int mmc_blk_hsq_issue_rw_rq(struct mmc_queue *mq, struct request
> *req)
> +static int mmc_blk_hsq_issue_rw_rq(struct mmc_queue *mq, struct request
> *req, int recovery_mode)
>  {
>  	struct mmc_queue_req *mqrq = req_to_mmc_queue_req(req);
>  	struct mmc_host *host = mq->card->host;
>  	int err;
> 
> -	mmc_blk_rw_rq_prep(mqrq, mq->card, 0, mq);
> +	mmc_blk_rw_rq_prep(mqrq, mq->card, recovery_mode, mq);
>  	mqrq->brq.mrq.done = mmc_blk_hsq_req_done;
>  	mmc_pre_req(host, &mqrq->brq.mrq);
> 
> @@ -1663,13 +1663,23 @@ static int mmc_blk_cqe_issue_rw_rq(struct mmc_queue
> *mq, struct request *req)
>  {
>  	struct mmc_queue_req *mqrq = req_to_mmc_queue_req(req);
>  	struct mmc_host *host = mq->card->host;
> +	int err;
> 
> -	if (host->hsq_enabled)
> -		return mmc_blk_hsq_issue_rw_rq(mq, req);
> +	if (host->hsq_enabled) {
> +		err = mmc_blk_hsq_issue_rw_rq(mq, req, 0);
> +		if (err)
> +			return mmc_blk_hsq_issue_rw_rq(mq, req, 1);
> +	}
> 
>  	mmc_blk_data_prep(mq, mqrq, 0, NULL, NULL);
> 
> -	return mmc_blk_cqe_start_req(mq->card->host, &mqrq->brq.mrq);
> +	err = mmc_blk_cqe_start_req(mq->card->host, &mqrq->brq.mrq);
> +	if (err) {

In the CQE case, when the problem happens due to the errata, this
function won't return error. The MMC write error is reported in
mmc_blk_cqe_complete_rq() if you see my original patch.

-Bin.

> +		mmc_blk_data_prep(mq, mqrq, 1, NULL, NULL);
> +		return mmc_blk_cqe_start_req(mq->card->host, &mqrq->brq.mrq);
> +	}
> +
> +	return 0;
>  }
> 
>  static void mmc_blk_rw_rq_prep(struct mmc_queue_req *mqrq,
> @@ -1776,24 +1786,26 @@ static int mmc_blk_fix_state(struct mmc_card *card,
> struct request *req)
>  	return err;
>  }
> 
> -#define MMC_READ_SINGLE_RETRIES	2
> +#define MMC_RW_SINGLE_RETRIES	2
> 
> -/* Single (native) sector read during recovery */
> -static void mmc_blk_read_single(struct mmc_queue *mq, struct request *req)
> +/* Single (native) sector read or write during recovery */
> +static void mmc_blk_rw_single(struct mmc_queue *mq, struct request *req)
>  {
>  	struct mmc_queue_req *mqrq = req_to_mmc_queue_req(req);
>  	struct mmc_request *mrq = &mqrq->brq.mrq;
>  	struct mmc_card *card = mq->card;
>  	struct mmc_host *host = card->host;
>  	blk_status_t error = BLK_STS_OK;
> -	size_t bytes_per_read = queue_physical_block_size(mq->queue);
> +	size_t bytes_per_rw = queue_physical_block_size(mq->queue);
> +
> 
>  	do {
>  		u32 status;
>  		int err;
>  		int retries = 0;
> 
> -		while (retries++ <= MMC_READ_SINGLE_RETRIES) {
> +		while (retries++ <= MMC_RW_SINGLE_RETRIES) {
>  			mmc_blk_rw_rq_prep(mqrq, card, 1, mq);
> 
>  			mmc_wait_for_req(host, mrq);
> @@ -1821,13 +1833,13 @@ static void mmc_blk_read_single(struct mmc_queue
> *mq, struct request *req)
>  		else
>  			error = BLK_STS_OK;
> 
> -	} while (blk_update_request(req, error, bytes_per_read));
> +	} while (blk_update_request(req, error, bytes_per_rw));
> 
>  	return;
> 
>  error_exit:
>  	mrq->data->bytes_xfered = 0;
> -	blk_update_request(req, BLK_STS_IOERR, bytes_per_read);
> +	blk_update_request(req, BLK_STS_IOERR, bytes_per_rw);
>  	/* Let it try the remaining request again */
>  	if (mqrq->retries > MMC_MAX_RETRIES - 1)
>  		mqrq->retries = MMC_MAX_RETRIES - 1;
> @@ -1969,12 +1981,9 @@ static void mmc_blk_mq_rw_recovery(struct mmc_queue
> *mq, struct request *req)
>  		return;
>  	}
> 
> -	if (rq_data_dir(req) == READ && brq->data.blocks >
> -			queue_physical_block_size(mq->queue) >> 9) {
> -		/* Read one (native) sector at a time */
> -		mmc_blk_read_single(mq, req);
> -		return;
> -	}
> +	/* Perform one (native) sector at a time */
> +	if (brq->data.blocks > queue_physical_block_size(mq->queue) >> 9)
> +		mmc_blk_rw_single(mq, req);
>  }
> 
>  static inline bool mmc_blk_rq_error(struct mmc_blk_request *brq)
> 
