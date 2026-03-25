Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010060.outbound.protection.outlook.com [52.101.56.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D86F2989B5;
	Wed, 25 Mar 2026 14:28:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774448886; cv=fail; b=oUevbdg4RQkqhDPK9v3mh+uWtBcCkx+47XLIHkkNu+SvMoXslg+DoGBEXLluP3N8olyyr3JdjvU3uBGDmNShJ6fXKT58RgC9imM1XXHkJUZJ0T7nzLoK1HGR3U+ZjDpHL6qcuu7sTEWriWVAdgWOPLiD67MojwXv5fXj/LxkXww=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774448886; c=relaxed/simple;
	bh=wSLsX0o+DEE+Zcv/g/qvu2KXoy8oaeLLyc3UCihALrw=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lSzx6hSp3BC32JlveI/Q94BpOGQdObVQVkETgglfHNJzLIVCUE+/I22qP673/UMQ8tP2rcYFLxFmW8q4Kx2+I2jzQxKhOFAHdcgLQ0cWm2ma+QbbmD47Gl1U0DCk4agduaRLvbnE2Y1A+Gn6C3GNkh0oXHx4gr8DJbE1qQPECTI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=jb2l/s3R; arc=fail smtp.client-ip=52.101.56.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="jb2l/s3R"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gaYOa6hRnBD868aCrJgAyVlyKjRamtNSjRb9q3WQhKkjLy8FDPinLqphakxt2z/a6cCY2B8VV6tSGGVdj3bTgW6CFNaSqil0TAwrYhch33QPVm+DXcif106FO1Da+5dntFkfkRUIZHqFPdR/uFMr7FgJivZhY9AoP94i0PazrwKFTumOrk4bIjUdD8MwdEpOHVPfb18cOmLmzOtQ61680NWSHQILlXpkQ0ls0u2jWHCOyDN8sdvXv7tn+zH9fHHjD7MHyEX1W3x8FRm2DLX4UhTVAk7eEqhc1meaJfre9IUV5LH3RelzQpswKn/2fGkstcS/FC1RS+wGwuTUraTHSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/AhBY3t+STzxnNs/NqKaEFtwD+UKf5Rg4oyENVozFhg=;
 b=y97HVShCiHqfhxbmLJISm18rT9lCRccBfKyqWoV5LMnF5RPjd5rKs1DCgTgFrdl51dCxp3jpJbK5cfBqhv8Kg0S3Bg0kNLNKr9fYetLtyZVzTsCHtpOp2iO0zYzmNbjJTAEOQgJQvSmK8BSfZWVWGAZ6qye3zJx7LvPs7aCvxlynXJV3lsG0lSBEmICg0VeCU1CUE7NjX6rfO7gCkjotRhX/DnO6w13w5oL840AbiPaF88vgLpomPJZyOQpijJHFAK8v4wLGG2yF/FunB2HNSWPRdeSRPCy3UY8XibR6CcZgzbypyogKDoqPY1851KBgQRdr1PIORnzcwXRwy29w0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.195) smtp.rcpttodomain=linux.dev smtp.mailfrom=ti.com; dmarc=pass
 (p=quarantine sp=none pct=100) action=none header.from=ti.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/AhBY3t+STzxnNs/NqKaEFtwD+UKf5Rg4oyENVozFhg=;
 b=jb2l/s3R9gtUxkvskzFeIvSxb6aTapTBK3xcnZkis3vj9/KfEKjSRCWWwkGFPdpuzpFHIh5uCjeu3cZPYMUluDSSJ8gyVLncsaQqPcjPeS3aRjWrdZ2r9oFMYiD2YHQzUxeWMe6y78Sel3vo3pETLwpEOFVhInN89/cuoKEzh1k=
Received: from BY5PR03CA0003.namprd03.prod.outlook.com (2603:10b6:a03:1e0::13)
 by CO6PR10MB5791.namprd10.prod.outlook.com (2603:10b6:303:14c::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Wed, 25 Mar
 2026 14:28:01 +0000
Received: from MWH0EPF000A6734.namprd04.prod.outlook.com
 (2603:10b6:a03:1e0:cafe::6c) by BY5PR03CA0003.outlook.office365.com
 (2603:10b6:a03:1e0::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9723.31 via Frontend Transport; Wed,
 25 Mar 2026 14:28:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.195; helo=lewvzet201.ext.ti.com; pr=C
Received: from lewvzet201.ext.ti.com (198.47.23.195) by
 MWH0EPF000A6734.mail.protection.outlook.com (10.167.249.26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9745.21 via Frontend Transport; Wed, 25 Mar 2026 14:28:00 +0000
Received: from DLEE206.ent.ti.com (157.170.170.90) by lewvzet201.ext.ti.com
 (10.4.14.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 25 Mar
 2026 09:27:59 -0500
Received: from DLEE205.ent.ti.com (157.170.170.85) by DLEE206.ent.ti.com
 (157.170.170.90) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 25 Mar
 2026 09:27:59 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE205.ent.ti.com
 (157.170.170.85) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Wed, 25 Mar 2026 09:27:59 -0500
Received: from localhost (uda0271908.dhcp.ti.com [128.247.77.70])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 62PERxug439062;
	Wed, 25 Mar 2026 09:27:59 -0500
Date: Wed, 25 Mar 2026 09:27:59 -0500
From: Bin Liu <b-liu@ti.com>
To: Jens Axboe <axboe@kernel.dk>
CC: <linux-block@vger.kernel.org>, <linux-mmc@vger.kernel.org>,
	<ulf.hansson@linaro.org>, <shawn.lin@linux.dev>
Subject: Re: [PATCH v3] mmc: block: use single block write in retry
Message-ID: <20260325142759.gnwhbnnffgyppu7l@iaqt7>
References: <20260324143448.2631888-1-b-liu@ti.com>
 <20260325134947.2799552-1-b-liu@ti.com>
 <b4c84630-ff69-4d1c-8b82-815679d3fa72@kernel.dk>
 <20260325142106.j2uiurbkgac6xw52@iaqt7>
 <91fffaac-587b-46bd-9ce9-f3c354d89b6d@kernel.dk>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <91fffaac-587b-46bd-9ce9-f3c354d89b6d@kernel.dk>
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000A6734:EE_|CO6PR10MB5791:EE_
X-MS-Office365-Filtering-Correlation-Id: a0b9a107-5f25-4642-c15b-08de8a7ab7c3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|376014|1800799024|82310400026|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	WhkbOzOl+7h5NFginwg0R4q9gQHwWLv5Uu1GDJ4kWrjslRTTjn+cAcZG7/CgiZO6IQbYj2Kv1C04oggmTN9/Aq+MFoyebqWG5iNUsHTr0vS5qRGWTLk6lC+fMCmoh2ly0qZALxfZqci2HYfCyIrm2iR8B8OhzpCYyQaWacyT2yDssmqciYallRJzzrieCU3dImtG2nqraHvOz7ac2m1dNN4Cq9yp/uFmNOR9LvDFmFz6vKmWvmb2cgUnLsUxvKDq1Pzck4LOavZgJ1wfUU5o4Zd317YNSM7ZTRwaOdSSkGbDa77mW8OZt7lQKVeW2xfpoBb7qmPmdq/78699m7Q1+sa1ZECXDLH6Olu954hlAIM90IvUxyr+FFMjsMuihYwDNQa03SdyQtFyMd8a4LAbPluBp7pPfVqTlfaFLCuqJNFJ3i4ltMa6fcjLa24k34HOTDxmUmpNfHnfDtg6IPZorAEVyjlpzGPpk7Kf2LohXGI4Vqkb5Vqfyr1tme6wXvqkPARpYEvDWM1aRg+N4cwqnN9C/QSmM1Wkm0NNSFIpqniIpXIo5s9iF01kmoxWkoHMa/Uj5vJnyFoha79ag2ht8bES5+IB+Clw1NDHCm8wK0zjt6wfnq9AIMI4OpAYxTVVEalqNZT4SjBbCd+VIN+0m2fW5ercQqUDxOSEGEWB7QKoL1WzcsxI/7zWLys5lsy3vBkGknACeExNws3VnhS+JDduULmKWmdF+CEhzui2djFuUepY8drN4tQMkE9Ygk8CHWsJ+LTEDkpMEPSxpR6nFw==
X-Forefront-Antispam-Report:
	CIP:198.47.23.195;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:lewvzet201.ext.ti.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(376014)(1800799024)(82310400026)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	lT1iYSMcN29ZhkLqzJepS7O+CZ2Brq5r1MA+kM6HcObegwXVo3PupYxO0V5zUp0iYZUUm0cMjOT7RA8be1QzCbUczYAhpyCQ8BCXt0EE7w6uQeIugLHg9oIjdGOH0qhionnRwpSqn/k/LJB1pU4NncSaYY5HJmH2nRN2rJnJzJXXy9JWT5txCQd9kUVo7nKcL6+q5TmE3L4ZUAI7L5zej5oaTNIvmZ7j8IcZmYfu/l4Qkr4V3ih17K5danv+X/Lf7GBdo72ittXrHNLFGAOSaYml4Cjsm6No7GFJG27EDNhG0JoMMpZQ2Lin2DyqHhbNJUfPKWJc6nnKWobH/KYebvEjg8KGQOCowMnJYTrA94gCa+XoYeoEDT/Tl8leZXkU5cKRJmOEI1BD58qM1DB051iFYjaZpUeMTkziCrg7/SPKZFb/QR58W2oAzP4KkHwh
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2026 14:28:00.5540
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a0b9a107-5f25-4642-c15b-08de8a7ab7c3
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.23.195];Helo=[lewvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000A6734.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR10MB5791

On Wed, Mar 25, 2026 at 08:23:29AM -0600, Jens Axboe wrote:
> On 3/25/26 8:21 AM, Bin Liu wrote:
> > On Wed, Mar 25, 2026 at 08:12:36AM -0600, Jens Axboe wrote:
> >> On 3/25/26 7:49 AM, Bin Liu wrote:
> >>> diff --git a/drivers/mmc/core/queue.h b/drivers/mmc/core/queue.h
> >>> index 1498840a4ea0..c254e6580afd 100644
> >>> --- a/drivers/mmc/core/queue.h
> >>> +++ b/drivers/mmc/core/queue.h
> >>> @@ -61,6 +61,8 @@ enum mmc_drv_op {
> >>>  	MMC_DRV_OP_GET_EXT_CSD,
> >>>  };
> >>>  
> >>> +#define	MQRQ_XFER_SINGLE_BLOCK		BIT(0)
> >>> +
> >>>  struct mmc_queue_req {
> >>>  	struct mmc_blk_request	brq;
> >>>  	struct scatterlist	*sg;
> >>> @@ -69,6 +71,7 @@ struct mmc_queue_req {
> >>>  	void			*drv_op_data;
> >>>  	unsigned int		ioc_count;
> >>>  	int			retries;
> >>> +	u32			flags;
> >>>  };
> >>>  
> >>>  struct mmc_queue {
> >>
> >> I'm assuming retries is a pretty small number (didn't check), so if you
> >> care about layout/space in mmc_queue_req, you could make this:
> >>
> >> 	u16 retries;
> >> 	u16 flags;
> > 
> > I quickly went throught block.c, it appears retries would be only a
> > single digit number. I will update the patch to use u16.
> 
> Note that this is just my suggestion, it's down to Ulf. But what I would
> do is a prep patch that makes retries u16 and ensures that's sane, then
> do your flags patch on top of that. I think that's better than making
> that unrelated size change for retries in your patch that isn't related
> to that at all. It just sets you up to not grow the struct after your
> change.

Okay I will wait for Ulf's decision to make the u16 change or not.

-Bin.

> 
> -- 
> Jens Axboe
