Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012003.outbound.protection.outlook.com [40.93.195.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5FB727603A;
	Wed, 18 Mar 2026 14:55:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.3
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773845757; cv=fail; b=WIhyF713iZ+Yocp9wZ3arRSir63vlhW+SSClg/boByLtBtT4cZ5P0+8Sv9TgitP44ZkCvfyGt+JXI5PCaybmwi0yKmW39ZkiZNVsI2QH6rVauYPJy9QBYrgnzgnj0FWzoLjEhUSBlxPyzNFsInt6T7FKtfPBZU7xGzhRsHnvQCE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773845757; c=relaxed/simple;
	bh=bCmM6mC+kn059HWtC9FTcunzsKph6GXTcv27sv5Z1lw=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kZyusT0yLCa6QNNLQwA+Mp6jIUg8xgglyqOpKxANQh39iUAi2ZaG+2XapVGrXV6zfPj0MqgpvGejkTQ9b0U/ZWD2GOYYBOLuHs/AwhQavIZHNyhzbi8GjMrbrcfyJlr86EPsRbTMZvWg7hHWvC/y4khPob3WYoeolqR7ynakAMI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=SFkBdUIE; arc=fail smtp.client-ip=40.93.195.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="SFkBdUIE"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Lb4n//n2UTvc4u2j5NLHVET968hOYeVQDxUm7m7N0ZmXDUtUd25Lrv5uUMgBnfL3WIVWtuXF109njT80MaJ9NbFW69K+W1zUTNdjboZ3q4X8NlH9kh8yDQQm7mSkCZAALYUEMfiwnPMAgULL23iOHOVy8FeOhjLcmvT2h9HwUI8yUjXr/o9FDYjEecUXkweNzS6SvAzOOJ/nlxonl9262r6fkCbrh25zkQxUZUIDjVh7dfE5aIdIfLieiqiSrYSs8nn4ri7Yowf2hiOYJxGjAwDKaOt7g0qEdWoLgkqXf8+/rNVaybpjLEiP3zaYtsYkl45T/iKu31FEpZfILYVmMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BjODN8qwhuoQNs1f+/JgclNUlRRUBmEtwjoSrH/8D2M=;
 b=GNYBQH6Sd/Synunf7L54Z3VQkzOENmlAJApEAZqPoelo4xWnp8esL0EduGT2GE5qWLxqOxeLl77Y4MYxi3wfYNyodoYqut4+/zAfQ33hH9Vvzx7sFMLwduC1glmQZnrOFopEbP+8LdOsoxOXYXuwqCJVPV4oBQT3iCfqs86p7iLpBnWVRH5kww6aFdW1V1udD1fsxap9n43/JpIn4zLhmdTVM0MpqOIYnu5sKteuScbfSn5UhVfCwt70nHKMuhhrzs+aiPUr+XO5GdtFAXEgtTYKVJXE4wqyUWadGaHV7m1IYVO6QLzUe2d7dJmguPytQRnogFSE6wKNtQbxfcbNCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.195) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BjODN8qwhuoQNs1f+/JgclNUlRRUBmEtwjoSrH/8D2M=;
 b=SFkBdUIERluOnfNeVNZglZDvkKcl2Fqy8AN6IsgDIv6z5cbcUYQ0JowrjIrrGRbwnbn0hLqQWGjdKFqLynFTbFU48ehhKttKjni7hsQDMv/uJpgbYZO8ZfLj65IfDTWQyaU3OGkJzRg4sG7zEEp/P5IniGNWdT6ZqhmMbeVfIjE=
Received: from SJ0PR05CA0001.namprd05.prod.outlook.com (2603:10b6:a03:33b::6)
 by SA2PR10MB4715.namprd10.prod.outlook.com (2603:10b6:806:fb::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.19; Wed, 18 Mar
 2026 14:55:53 +0000
Received: from CO1PEPF000066EA.namprd05.prod.outlook.com
 (2603:10b6:a03:33b:cafe::9e) by SJ0PR05CA0001.outlook.office365.com
 (2603:10b6:a03:33b::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9723.19 via Frontend Transport; Wed,
 18 Mar 2026 14:55:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.195; helo=lewvzet201.ext.ti.com; pr=C
Received: from lewvzet201.ext.ti.com (198.47.23.195) by
 CO1PEPF000066EA.mail.protection.outlook.com (10.167.249.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9700.17 via Frontend Transport; Wed, 18 Mar 2026 14:55:52 +0000
Received: from DLEE201.ent.ti.com (157.170.170.76) by lewvzet201.ext.ti.com
 (10.4.14.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 18 Mar
 2026 09:55:48 -0500
Received: from DLEE203.ent.ti.com (157.170.170.78) by DLEE201.ent.ti.com
 (157.170.170.76) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 18 Mar
 2026 09:55:47 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE203.ent.ti.com
 (157.170.170.78) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Wed, 18 Mar 2026 09:55:47 -0500
Received: from localhost (uda0271908.dhcp.ti.com [128.247.77.70])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 62IEtlob1012741;
	Wed, 18 Mar 2026 09:55:47 -0500
Date: Wed, 18 Mar 2026 09:55:47 -0500
From: Bin Liu <b-liu@ti.com>
To: Shawn Lin <shawn.lin@linux.dev>
CC: <ulf.hansson@linaro.org>, <axboe@kernel.dk>,
	<linux-block@vger.kernel.org>, <linux-mmc@vger.kernel.org>
Subject: Re: [PATCH] mmc: block: use single block write in retry
Message-ID: <20260318145547.23vep24pwhzdfjrj@iaqt7>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000066EA:EE_|SA2PR10MB4715:EE_
X-MS-Office365-Filtering-Correlation-Id: 8adaf17d-4617-46ce-5bf1-08de84fe73a9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700016|82310400026|1800799024|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	UkkRGnM3oqBwtBnw/muCIMibEDZiU3OpLZ4jnE1FXefk2jO+ZkYGH49/2y/W55IiJ3113RHEYhpVsvWpw5epe3Yjzj//0u3NETU2v0vMI50GcGfj74sTEMt68KwWwSH4dL74mVez7IWlqal6KOPv6f4K+L2puQGL4kEuTAF/gb1XQnCnJsN9LZt+JBnAx96Qe6vY0zfTuic6xrJxLgVAZGRDcCPINfEQjB45cKMKF/t/XkmlBZ9+1JwUY1M3y+eouU92LDAEKQJQfC1NjIKm/YhMi/6pHyfl0p4Qcx67eIDctzB3WOyhmVVLopV6lqqsbEoZdwFGjOhyNLi+FcCYgjtOD1d2tSExCCGvnE4hIndbDd4zMW95FG5SlSfavwqFpVQsx2Pk+WqZ7ljAPdtTgG6fHB8+pQtGsgjsde0tD//jbV4OmJ4Ov7XHIfm7b7M4M4d9l99uvEbcJJq4UHRNiofaP/wdY5nKc5CLw991Wk33LCe3dSbY2sWDwo6/OGtect2RJsx3yxLAkKstOYkIGVnJ13OkcmQbjEz+dQS6cLKJ1vHsf2ZQi3Q5kLpI/pXptgBAKdcJl9y2x66Z54ESJZBEJsKcYf4yq/FnLgio176j+JNiTb10BWXLmzambnLhDlhQrap11g1qVxT7Kiy25oH/LPVQban6GDQcpWMlwqA7VCH+ZjaurMiEEWn2J0MZWYG24Gf7n+EMIQZilPkuxukK1MGJcq78+ZfGMrM7ruSJUeAsDmskFAF6GS8LHhygA6AZyklJfQeitlap1NNNlQ==
X-Forefront-Antispam-Report:
	CIP:198.47.23.195;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:lewvzet201.ext.ti.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(36860700016)(82310400026)(1800799024)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	tgiCg6bMm5F2PuktUfwFqfNlOYAPWOdo67x5YqV6p0tDCJJabGNe+retVRLypyXbWu/k6tOPhom5vAp5oNOe5w1t7YwzXldmdIw54bmY1OoY0xRF0JurmMIi60b2O8ZfBANV1t6JwDuF7q/HxvhX0BTlFKdmPvKqS6oyDnd2hBGEfvQ7xxa3KJPVQmTch6iDxn/uWUE/4ICcatX6qq1N/Lpq3BM9ZIAQhcKwF+qvrWjVOXuxr+xXnAvi/hHFMai/uJb7zP2uc+DFUS+PO7bSGxF9e85Kd/S7VYkdWcKBQL0yAEBCxLtx9qHkLKqakH9p7nuh3us37uutrYUfQlS45cJwm4YBNXWTIICTITsEhsEqGEcc8zf0WSrvhm2VAPnRMxbkHyWM5MX/eM5oJ4bDb+fBcGgVLcgYhHcLMqIj53tJdD4dB2+TR8z/jiQui2FN
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2026 14:55:52.8933
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8adaf17d-4617-46ce-5bf1-08de84fe73a9
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.23.195];Helo=[lewvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000066EA.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4715

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

I tested the following patch in CQE mode, it fixes the data corruption
problem, however the kernel prints Buffer I/O error messages which is
confusing. Please see the test log below.

# hexdump ff00-4096.dat
0000000 00ff 00ff 00ff 00ff 00ff 00ff 00ff 00ff
*
0001000
# dd if=/dev/zero of=/dev/mmcblk0p1 bs=1024
count=4
4+0 records in
4+0 records out
# hexdump -n 4096 /dev/mmcblk0p1
0000000 0000 0000 0000 0000 0000 0000 0000 0000
*
0001000
# dd if=ff00-4096.dat of=/dev/mmcblk0p1
8+0 records in
8+0 records out
[  390.990581] mmc0: running CQE recovery
[  390.995129] mmc0: running CQE recovery
[  390.999684] mmc0: running CQE recovery
[  391.004002] I/O error, dev mmcblk0, sector 2048 op 0x1:(WRITE) flags 0x800000 phys_seg 8 prio class 2
[  391.013596] Buffer I/O error on dev mmcblk0p1, logical block 0, lost async page write
[  391.021678] Buffer I/O error on dev mmcblk0p1, logical block 1, lost async page write
[  391.029681] Buffer I/O error on dev mmcblk0p1, logical block 2, lost async page write
[  391.037754] Buffer I/O error on dev mmcblk0p1, logical block 3, lost async page write
[  391.045821] Buffer I/O error on dev mmcblk0p1, logical block 4, lost async page write
[  391.053922] Buffer I/O error on dev mmcblk0p1, logical block 5, lost async page write
[  391.061926] Buffer I/O error on dev mmcblk0p1, logical block 6, lost async page write
[  391.069982] Buffer I/O error on dev mmcblk0p1, logical block 7, lost async page write
# hexdump -n 4096 /dev/mmcblk0p1
0000000 00ff 00ff 00ff 00ff 00ff 00ff 00ff 00ff
*
0001000

-Bin.

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
