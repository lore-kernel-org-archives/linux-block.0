Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011042.outbound.protection.outlook.com [52.101.57.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EF932848A7;
	Thu, 26 Mar 2026 13:41:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.57.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774532521; cv=fail; b=T0ksqz3bOTUAEChq5R/MGCwwWmcHdiJ+ytOwS4ReVls4Pu2FD+8Q4i6EGmrZGjeKVvRGQyXmagsRB8AqGnsryTHUJD1EBMgCrABJ6F0/7plFOIEQF1T2otEu3TDuq400KsNca4mkOuRBvc/q+d2vco082dp86KCctKYKIsWsmjo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774532521; c=relaxed/simple;
	bh=UyFigOeNmUje7dkKXuPCPEliH6tuth2cbC7g8EqvwaE=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=azSTVFIh/JBbuI80lCrOPtNnR1+DurzwnISG158pcvTbNpmgep0kz5O2g2qf7anwcbfpXJYA+F+Nxb/VaCo+NO2Dzv6aWUBQFG9lABAuIQunBQIFXWuldlx/CHfMXUB/ZqFPdXq0I9NyVR0Jg9QFNxIIjDTOGpm9b1s2Yv4dkUo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=ZzAbpPA4; arc=fail smtp.client-ip=52.101.57.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="ZzAbpPA4"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TYziz0/k9PrM+gIz8zzD1VqfgeIFqh0F67BxRIAuFF4Dawk658XQ3I2ngbEP3ug6tzxed8sk8damhPX5TbYNdgFcRcKilvTVuliR8MNpFfbw4czxlYbuAIVk27KbC4QwtNrVMapXjey8Ajfc5P9wtGgWB4NEi8X5Cxc1chT+DTLmIk7ohhHL02mOYtZFWBB+d4ku/r6iiuDShsfFtVtp1dkhAYigUNzb4LXhnAF19erYPIMkomFTqUezbxOA6p3aTO4JgdlERAW9s+u812VTE7tlmvq0astUWkLcjAJdZUf23wS3njuWl9DPnZeP15E4BlrIbvPPnpZ6qYsLVO79Fw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OaE6CsYp2LtBBY0zo7cF1GxKstT0ND5sZEb/26xCbDU=;
 b=V8BWurVjF+yF0jXHqsoHYhZ3iUI90y1voN3EB8oS0aaRr5vNXHWL2PbgkUVuN8RgYV6e19gzNqGv0RD9Ok8dimkpy/UCCRHNb+kRqudQAVU2150Dml3N+dKe/ZP4692/bbD1AFPmpnxr/XsmuIlqSct89lRJ8cY+7d+P8OWu/zE9xNnsM17rdCZrunaEwBv9GK/vzb0ObuDpw9Q9YokU4KFgQrHsPY/YUB27a2HjogfMx5ucLvjoV+gvyopJ+0GqpvHi01BnT4jRNCpsR/iSJaseSOIA9i/d3mMuMidSoHOWo9FPkO0hNZUAQsa3t7KKYyGHAXA3eNcmEmoXhVGQ0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=linux.dev smtp.mailfrom=ti.com; dmarc=pass
 (p=quarantine sp=none pct=100) action=none header.from=ti.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OaE6CsYp2LtBBY0zo7cF1GxKstT0ND5sZEb/26xCbDU=;
 b=ZzAbpPA4xbZKBoCJwC4xLnQAwYZiAbispnKOSQ6zggXoXKXMzhygcm+FVhWeoaOfHgzxpYZHi5doK3niAwqeYiJKmJ4Sq/AFc6fJcisv5io4jkdiO+fGpU8ZK41dreTLYu08gEvspNnBPlfBJJmOm83rLO+MtV6FgsxD271ObaU=
Received: from CH5PR04CA0007.namprd04.prod.outlook.com (2603:10b6:610:1f4::7)
 by DS4PPFAEF42CAE1.namprd10.prod.outlook.com (2603:10b6:f:fc00::d40) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Thu, 26 Mar
 2026 13:41:56 +0000
Received: from CH1PEPF0000A34B.namprd04.prod.outlook.com
 (2603:10b6:610:1f4:cafe::d4) by CH5PR04CA0007.outlook.office365.com
 (2603:10b6:610:1f4::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9745.22 via Frontend Transport; Thu,
 26 Mar 2026 13:41:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 CH1PEPF0000A34B.mail.protection.outlook.com (10.167.244.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9745.21 via Frontend Transport; Thu, 26 Mar 2026 13:41:55 +0000
Received: from DFLE207.ent.ti.com (10.64.6.65) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 26 Mar
 2026 08:41:28 -0500
Received: from DFLE206.ent.ti.com (10.64.6.64) by DFLE207.ent.ti.com
 (10.64.6.65) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 26 Mar
 2026 08:41:27 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE206.ent.ti.com
 (10.64.6.64) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Thu, 26 Mar 2026 08:41:27 -0500
Received: from localhost (uda0271908.dhcp.ti.com [128.247.77.70])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 62QDfRQD1738026;
	Thu, 26 Mar 2026 08:41:27 -0500
Date: Thu, 26 Mar 2026 08:41:27 -0500
From: Bin Liu <b-liu@ti.com>
To: Ulf Hansson <ulf.hansson@linaro.org>
CC: <linux-block@vger.kernel.org>, <linux-mmc@vger.kernel.org>,
	<axboe@kernel.dk>, <shawn.lin@linux.dev>
Subject: Re: [PATCH v3] mmc: block: use single block write in retry
Message-ID: <20260326134127.fne3kykgi572qfep@iaqt7>
References: <20260324143448.2631888-1-b-liu@ti.com>
 <20260325134947.2799552-1-b-liu@ti.com>
 <CAPDyKFq42GDC6V4WZpax_tFM69JPafB9_UOAsfkJN1ZxAP7LeQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CAPDyKFq42GDC6V4WZpax_tFM69JPafB9_UOAsfkJN1ZxAP7LeQ@mail.gmail.com>
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000A34B:EE_|DS4PPFAEF42CAE1:EE_
X-MS-Office365-Filtering-Correlation-Id: be21907c-b286-4aad-d92f-08de8b3d7202
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700016|82310400026|1800799024|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	r0Lu3ZsmoDdbUnOfDNU1YynHQkcvXE8ldzDzgBjmUewO9JsSxBB3m+6ceFXF8wBnE2jAhG7EiiP7KtHu0Me/TM2g9YSERax/4CzJZz7/x/nBQEjqA8XhYKfiF4Oz65AwOXsMZlpW5/x7kgUo4ir3yR5VLnvuc7Jwwx0hTb0/CMxx1OFQg1ApLCVDAGPpSXEAzo71jDsOL/drCLhipfkYWvp+vRlYzLgXOqQpgnS8xtucm+FwRABkD84tLoOUN2M64GBcKdgtcymIuih8QJY8AJ+Gh6fLOW8XArULZivttGuTu8B8UAU1V3CmOs3f8CNhVqyJcqAgi9b2om+7iI2CZQ/Ft8mNRw4T7WG5SvGqIO2tJSmYwRuAbf1vsmEq2W+/HpbJOYgrvgtQd5PV0x5BJxiEoWYU96JJHLqap0OJ42/ZsXiNTBq93m+4I1POSmv0QJ6nK2xBYr8nlEcH66djvVaZk+1XbU0/MmlV8D46NNEgRfOCyUnoHyvVm+f+c5StpkYQ00JJeCw0Y2Mi4kYf9+WvtZYTUEGh1wqIUKf4MlI6wC7PUgKl1WXyM7c2awKNM3JQiySJleSAOxxT72xUzdp3x8NZr1wkMzlSB6wEdMsxQ1y3zd1/gtRzAc0nB+gdSUcpCpOfJTBNuTa82iDF4Q3Zil1/WbJlH8+4jY/BpvWFGvx+mmXOko4h8EeUWyfA0EHWcTxDd2mc1/cQs87vr2YKs+XtuLFDM47k8IsJQ7F4d1c+h4WacLk0ns+VN/82egdMwn8rTCqsNIz1cmA+lBw161l5W9w9y96X2CTzRLk=
X-Forefront-Antispam-Report:
	CIP:198.47.21.195;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:flwvzet201.ext.ti.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(376014)(36860700016)(82310400026)(1800799024)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	yHYF+xM2PZmwKMF/3wX3Kr5i6d3jJjYi24FTxW86vISnJUyeoMfpIHVeXrb7tc4mWqgAoD5RWdkAv5BOdH0Q7oXee5re5DKnB1vrMdtiFACS7jZJ3MAtIe/o9t/kviBIgTyteX2ZYHolT9phFyvKBERo3L21gjFRx/4btZNjAA1ycssWLM1X2zoMazMpMfYKJz1OcndDbzIcaWgu83xKBpuUPiOk/Eux+JirmdyjW/63FIeN2SMUelPihAThz1M7Fnh82uZlyjQSqIoYZ51uN+B+JZUdlTXDT0p4E7OQuv8+jEULMeI2hz6hGpzvUbM4cYxSEbE1/l3XeAIz8FoDaZ3GyLbKfWl+O8c6ZfMwS1h8bmFT8hGE6GYzWrJCGmaJS+WYt44ieSRMV4OCqJzvACvjrg06OE5JcAGLRJ4KzFQAc09NjavnNROfzEQeVnsu
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2026 13:41:55.4368
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: be21907c-b286-4aad-d92f-08de8b3d7202
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.21.195];Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000A34B.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PPFAEF42CAE1

Hi Ulf,

On Thu, Mar 26, 2026 at 01:33:58PM +0100, Ulf Hansson wrote:
> On Wed, 25 Mar 2026 at 14:49, Bin Liu <b-liu@ti.com> wrote:
> >
> > Due to errata i2493[0], multi-block write would still fail in retries.
> >
> > With i2493, the MMC interface has the potential of write failures when
> > issuing multi-block writes operating in HS200 mode with excessive IO
> > supply noise.
> >
> > While the errata provides guidance in hardware design and layout to
> > minimize the IO supply noise, in theory the write failure cannot be
> > resolved in hardware. The software solution to ensure the data integrity
> > is to add minimum 5us delay between block writes. Single-block write is
> > the practical way to introduce the delay.
> >
> > This patch reuses recovery_mode flag, and switches to single-block
> > write in retry when multi-block write fails. It covers both CQE and
> > non-CQE cases.
> >
> > [0] https://www.ti.com/lit/pdf/sprz582
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Bin Liu <b-liu@ti.com>
> 
> Applied for next and by adding a suggested-by tag from Jens, thanks!

Thanks.

> 
> Please consider sending a patch on top, that decreases the data size
> of struct mmc_queue_req.

Will do, in a few days or next week.

-Bin.

> 
> Kind regards
> Uffe
> 
> 
> 
> > ---
> > v3: move the flag to struct mmc_queue_req to reduce the scope
> >     cc stable@
> >
> > v2: add errata details in the commit message.
> >
> > link to v2:
> >     https://lore.kernel.org/linux-mmc/20260310160408.3976760-1-b-liu@ti.com/T/#mb201075c9c466a78b58dbb0bf1f39139f0928591
> >
> > link to v1:
> >     https://lore.kernel.org/linux-mmc/20260310160408.3976760-1-b-liu@ti.com/T/#u
> >
> >  drivers/mmc/core/block.c | 12 ++++++++++--
> >  drivers/mmc/core/queue.h |  3 +++
> >  2 files changed, 13 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
> > index 05ee76cb0a08..db8c99c73a61 100644
> > --- a/drivers/mmc/core/block.c
> > +++ b/drivers/mmc/core/block.c
> > @@ -1401,6 +1401,9 @@ static void mmc_blk_data_prep(struct mmc_queue *mq, struct mmc_queue_req *mqrq,
> >                     rq_data_dir(req) == WRITE &&
> >                     (md->flags & MMC_BLK_REL_WR);
> >
> > +       if (mqrq->flags & MQRQ_XFER_SINGLE_BLOCK)
> > +               recovery_mode = 1;
> > +
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
> > +                               mqrq->flags |= MQRQ_XFER_SINGLE_BLOCK;
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
> > +                       mqrq->flags |= MQRQ_XFER_SINGLE_BLOCK;
> >                 blk_mq_requeue_request(req, true);
> >         } else {
> >                 if (mmc_card_removed(mq->card))
> > diff --git a/drivers/mmc/core/queue.h b/drivers/mmc/core/queue.h
> > index 1498840a4ea0..c254e6580afd 100644
> > --- a/drivers/mmc/core/queue.h
> > +++ b/drivers/mmc/core/queue.h
> > @@ -61,6 +61,8 @@ enum mmc_drv_op {
> >         MMC_DRV_OP_GET_EXT_CSD,
> >  };
> >
> > +#define        MQRQ_XFER_SINGLE_BLOCK          BIT(0)
> > +
> >  struct mmc_queue_req {
> >         struct mmc_blk_request  brq;
> >         struct scatterlist      *sg;
> > @@ -69,6 +71,7 @@ struct mmc_queue_req {
> >         void                    *drv_op_data;
> >         unsigned int            ioc_count;
> >         int                     retries;
> > +       u32                     flags;
> >  };
> >
> >  struct mmc_queue {
> > --
> > 2.34.1
> >
