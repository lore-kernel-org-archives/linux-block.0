Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012061.outbound.protection.outlook.com [40.107.209.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33CA63E2762;
	Wed, 18 Mar 2026 15:11:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773846665; cv=fail; b=Cq6yykh5OdMhIQAdETDeKy2bTO3DQ45nHLvnIGi0qqfqo9do9O2ge25voguBlxEdSM13VRz2XczSqgJXACWVv1+goblnf2zomjjUzFrLO59vb9cbn7gHEY9VQQvH2rwXG/yu88tiROJg/RbIqoiE9m7ihJFk2ESoGBvjCZeOHx8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773846665; c=relaxed/simple;
	bh=+kFFVJS4qI87TbhGy0iSo6IvrYBTu8v7dVTcR9vZT+I=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gXldPzfTW95sHBDMR2dbXoKkOH5l14eVv1EGCGFgBsq8fL18btJaEgmy7RIDyN1lfGartvmlpIJR2wOmK+yDyAYtHDNSqk56B/nqxbL3xToSkCQdvrnubTRYG4mjtjjyYoHfq+i2Tww96WUWhG99YVvK3mr81ZCceeZIhE7pTro=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=VhTJ2BFV; arc=fail smtp.client-ip=40.107.209.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="VhTJ2BFV"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=G/PSc8DIbdWvQbcRuCGImETAsfWCyyYWle5X+hK0DxQkY4GbkZoUchfZK3akPAWJsDeFac+Gkt5jXEB3rhbBkBtdF0gt1SZqNZ/ztq1sT/4ZPU3/K9DBRYxD/gg7PfVJ/b4pMM6EUnNxEwbCPVzZNnEMlcRbrIfRx2nzGiO6S0U6PScKNmOYn0u4Epj65LacyrHOmlXnDD5kIwoFDd8AoLOkVkYQFUwD6doANKxcP/xodfLhnE2Yf/olF0OpmtJzLtU7YkS9hPD9IhNTODSpZZgw7rzi0/IzasRgILjmT4biru9fGhbQtsHiz/4cbXA1+uHWhuSLnDpQNmY2Pl5v4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4CU86tXuDMK9Mqzqlf7m/NXNCGMIqrC01dahk0zqjQs=;
 b=ya4dolsGPajtp3HHJ4Fb67jmuDAKMffqaa5xEsSx9Qa1T8WZdMc+B+qbdtT25jYvtqdwmj/+k7o28FYDoGWwyE2ob+26/TB9Y64sFBN8MkB1+unw14K5X3LxcCOxCBGbOaUvCVv9efTTTfqMIrsvG91a08sZqSPB7VjP2RElaK/sEldJyg1A2lsJCm4IL0e523LGRQ+COhMR7ZTOfQwnZ9TV+ttwUnwATLcj7lkWcs2g1gOaEJ8OgVxosl9JWD3CDgHQYqE/r/dMi2uxItMlF4cdAHGPIqMZKe+bR4MiPVmwXZc03h50eY4pCIVfgTNuS3FF7KV+CeXZwXoTUFfHNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4CU86tXuDMK9Mqzqlf7m/NXNCGMIqrC01dahk0zqjQs=;
 b=VhTJ2BFVO8pzLqwLo8hy9180CTLWu5uzsU6U/eqsslLbq98vMwJd2fAg+70hM6zCF9Ke0ZSLQFFrXW2EwhHHHb0+8d5wMxQyTamqmVZMj4ShKnV/OhITcwaEYEFkY7pAEKkm3I2r0dINx1P7pXV5PNT5CqsUQrVWW5KjYRbyhD4=
Received: from BL1PR13CA0246.namprd13.prod.outlook.com (2603:10b6:208:2ba::11)
 by DM3PPFA3FC49FBA.namprd10.prod.outlook.com (2603:10b6:f:fc00::c3d) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.19; Wed, 18 Mar
 2026 15:10:59 +0000
Received: from BL02EPF00021F6A.namprd02.prod.outlook.com
 (2603:10b6:208:2ba:cafe::9c) by BL1PR13CA0246.outlook.office365.com
 (2603:10b6:208:2ba::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9723.19 via Frontend Transport; Wed,
 18 Mar 2026 15:10:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 BL02EPF00021F6A.mail.protection.outlook.com (10.167.249.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9723.19 via Frontend Transport; Wed, 18 Mar 2026 15:10:58 +0000
Received: from DFLE207.ent.ti.com (10.64.6.65) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 18 Mar
 2026 10:10:57 -0500
Received: from DFLE209.ent.ti.com (10.64.6.67) by DFLE207.ent.ti.com
 (10.64.6.65) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 18 Mar
 2026 10:10:57 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE209.ent.ti.com
 (10.64.6.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Wed, 18 Mar 2026 10:10:57 -0500
Received: from localhost (uda0271908.dhcp.ti.com [128.247.77.70])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 62IFAvYq543756;
	Wed, 18 Mar 2026 10:10:57 -0500
Date: Wed, 18 Mar 2026 10:10:57 -0500
From: Bin Liu <b-liu@ti.com>
To: Shawn Lin <shawn.lin@linux.dev>
CC: <ulf.hansson@linaro.org>, <axboe@kernel.dk>,
	<linux-block@vger.kernel.org>, <linux-mmc@vger.kernel.org>
Subject: Re: [PATCH] mmc: block: use single block write in retry
Message-ID: <20260318151057.4shfkngoq5df3gad@iaqt7>
References: <20260310160408.3976760-1-b-liu@ti.com>
 <301ff663-7f18-ae12-f0f8-88c4e4375114@linux.dev>
 <20260317132454.b6i7wp763yj36d3v@iaqt7>
 <1806373b-d402-5655-94d4-5cf7142e1382@linux.dev>
 <20260318145547.23vep24pwhzdfjrj@iaqt7>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260318145547.23vep24pwhzdfjrj@iaqt7>
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF00021F6A:EE_|DM3PPFA3FC49FBA:EE_
X-MS-Office365-Filtering-Correlation-Id: a6b7626d-82eb-4f09-eaf4-08de85008f74
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|1800799024|36860700016|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	vAi5B8A2jUVDa5SKTSob1tR52Ce+gCbV8zVxkTc3qPvzU+F4HH3w5fXeIZqIThY15WjieCuYzbU3xRHtuV5h/g2cOwXadLiWKbsaXzlSVxKiEuENBJTFVK8VpUWx5g/veEspN517vwvLIAr1MmB7QDD65AEANfiPNZl7Zz0Cg2CubiieabAlKvxYIyVxvn9t7+vEvg2Mp3/BCM9YO38c4+bPqVDAWSyPhb97aYD3dcyQbVyHS6S8pRZzR1CnUH+z+3FyAJn7XDtju/7TNsqKH7QUjp8tCob4/J5uGqor01xq3OTWt4jvHqOUikYG0qv0iqH+zOuCvDSmlLjYNbXYSh7Gv4ThMgwhVWuN01p/TzhARhZ1IWdyG/xkNrkxd4KCG9Ebdug7JeChVOb4oUHbMEZ2LJQ8kGH33bSMwquDnJGvdYa0MCdHpktdV3XBdKcl2RWe6ObEcR+cpAz0KYbgIS02vw0s6+xNn2BbgnssBrlZHhHrxi5yfcgmWktXjPdVxPq1SF7zHadPby89TAcDnnRXr5UehmTlofPdTRiwQwnf3GGQKWqt6yi4vetcQXyeyJJr6yiwmdrS4mVl95zLbkDh/uu5LSUKNrjwLqRMQQDmd/xZ2zyMCyI23XRvopSMvsADNSU7qyGi2gVaIN3QgpmSnDvK2atglt2NV7mKe7hYdZ3YtFfv84CFJcC7fXdYxlKv2kVFrHiu38rHlPJ1am+TfGa+DR49WyDFbzPupgNGEROlhHxnpSJt/OIGpiN0Y/W9hBkqukVm8H2yrQYo6Q==
X-Forefront-Antispam-Report:
	CIP:198.47.21.195;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:flwvzet201.ext.ti.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(376014)(82310400026)(1800799024)(36860700016)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	grNLHIj/NkfmFcu1ifDt+V3Iva1VSR2mLScMgMXRpfggqAY0QfgwBxT/P12L8GdioMBW5Qg80+LC+E9N7tWa71B+r0qhJZ05qh/Wof1/mbQTtdumHhF71C+bpmw8ahVHTlwPOCldY9aMPQnXG+tR/LDxYa+Ec88LK468tVAx30SMoXs9/+rZ+NlOuv4z3AJhLrMscUr7bh/c0bAG0J7BsHcRfs4o/c9irbf5dEECezr8D5IBp50J+3LrtPsQ+TPIopQIQRFev2vQ6PmOTxxVf3QRO9k67WYhfVc0UNO2JRyvlH4n/5MEKB75W8H31u7dA3ZVFfipMpR6oU8AkMyPOlu8mJ6RWFN1z8U7DT80UNJsruG2qYdIlxuqYDfMF5rQCKwY1haF6X7UOfD5PZ6LRQIUOsx9VC/glefuSC4wbFx+V8jITUc3UOeAF9FWTkAc
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2026 15:10:58.5379
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a6b7626d-82eb-4f09-eaf4-08de85008f74
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.21.195];Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF00021F6A.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PPFA3FC49FBA

On Wed, Mar 18, 2026 at 09:55:47AM -0500, Bin Liu wrote:
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
> 
> I tested the following patch in CQE mode, it fixes the data corruption
> problem, however the kernel prints Buffer I/O error messages which is
> confusing. Please see the test log below.

The patch doesn't seem to catch the CQE error path. I added a few
pr_err() in the places you patches, but none of them is printed on
console. And this time data corruption happens, so the patch doesn't
seem to fix the problem. Here is the test log:


# hexdump -n 4096 /dev/mmcblk0p1
0000000 0000 0000 0000 0000 0000 0000 0000 0000
*
0001000
# dd if=ff00-4096.dat of=/dev/mmcblk0p1
[   89.208865] mmc0: running CQE recovery
[   89.214757] mmc0: running CQE recovery
[   89.219414] mmc0: running CQE recovery
[   89.223743] I/O error, dev mmcblk0, sector 2048 op 0x1:(WRITE) flags 0x800800 phys_seg 1 prio class 2
[   89.233152] Buffer I/O error on dev mmcblk0p1, logical block 0, lost async page write
8+0 records in
8+0 records out
# hexdump -n 4096 /dev/mmcblk0p1
0000000 00ff 00ff 00ff 00ff 00ff 00ff 00ff 00ff
*
0000600 0000 0000 0000 0000 0000 0000 0000 0000
*
0001000

-Bin.

> 
> # hexdump ff00-4096.dat
> 0000000 00ff 00ff 00ff 00ff 00ff 00ff 00ff 00ff
> *
> 0001000
> # dd if=/dev/zero of=/dev/mmcblk0p1 bs=1024
> count=4
> 4+0 records in
> 4+0 records out
> # hexdump -n 4096 /dev/mmcblk0p1
> 0000000 0000 0000 0000 0000 0000 0000 0000 0000
> *
> 0001000
> # dd if=ff00-4096.dat of=/dev/mmcblk0p1
> 8+0 records in
> 8+0 records out
> [  390.990581] mmc0: running CQE recovery
> [  390.995129] mmc0: running CQE recovery
> [  390.999684] mmc0: running CQE recovery
> [  391.004002] I/O error, dev mmcblk0, sector 2048 op 0x1:(WRITE) flags 0x800000 phys_seg 8 prio class 2
> [  391.013596] Buffer I/O error on dev mmcblk0p1, logical block 0, lost async page write
> [  391.021678] Buffer I/O error on dev mmcblk0p1, logical block 1, lost async page write
> [  391.029681] Buffer I/O error on dev mmcblk0p1, logical block 2, lost async page write
> [  391.037754] Buffer I/O error on dev mmcblk0p1, logical block 3, lost async page write
> [  391.045821] Buffer I/O error on dev mmcblk0p1, logical block 4, lost async page write
> [  391.053922] Buffer I/O error on dev mmcblk0p1, logical block 5, lost async page write
> [  391.061926] Buffer I/O error on dev mmcblk0p1, logical block 6, lost async page write
> [  391.069982] Buffer I/O error on dev mmcblk0p1, logical block 7, lost async page write
> # hexdump -n 4096 /dev/mmcblk0p1
> 0000000 00ff 00ff 00ff 00ff 00ff 00ff 00ff 00ff
> *
> 0001000
> 
> -Bin.
> 
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
