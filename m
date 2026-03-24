Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010044.outbound.protection.outlook.com [52.101.56.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50E133CF68D;
	Tue, 24 Mar 2026 19:11:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774379496; cv=fail; b=MAAgsa3GrKXboV2xmgmmS6sujUpAUimfbo80zBlU/rBBbBILQt73v2CdCrQ/hX+t+lsLPxz3IJrQAGTh1OpJ12YuNJ7x/LgysYB0DmiRZEteobTtcAcG3Bz8/9A2m22SC097vX0hSVQgaRZ3WpC3laNyAOya2xh3rdctuGkaG/o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774379496; c=relaxed/simple;
	bh=WhePd5xMUqL4lAxt8QHp8A4zIPsxTyFlKL0WTX+R4fI=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gR/gz8iR9lTnPUbaC0RRojSraZ+aE4Iw3aiCzyFeAMSuH4WHr/4uDaFO5yK6+Au1/CE0AIvr2YHa+n7b4gTZxgYv+cFlrdGI0XXrjk73xbNftsh3Uirnunc9TzRR+BzDKWOBYawS1Hwnu8CYPBWna3amxqD+8W0aDjROw/G4V48=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=AcxPVJK4; arc=fail smtp.client-ip=52.101.56.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="AcxPVJK4"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HW39tmVg/94zI7/eib6heCT0DcZWUqHOrAAcvaKFrAIDKxry0w7N2RqLtKD8IGNvgXfv3zxskBe5RXKIJonMdNh8dPmdy6PVHNiDjr0eofEqivHzbg5elNWBtrXZsreMUZ6cq2Kh7lpbs3DeBSROlAU4jTLeEVODgEK/sRT0dh3m36okerGh8UI2pik2xC44EvEJqEeiPEdizFfMEtUQTpx38/hJ2Sm3gVQORDbvCHR3Mtb3qQoG6T9+p+2dvmHyObim2wUmL4RdXwsmGH9oLo+vxt4JyTRlFkKkP+MYbIyjr5kV1K9z1Wqpx6qWX1DsFk1G/LHR9e47QWr3fqQskA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BFgnjw8RKF2ORtreKN4JHad68I3J2O7TgtB90PxU9Js=;
 b=fxLZQ5cWEYlMR1oEeR9W5gvxbFugmeLOvr9+rUVjrAYynrdY6H9AEWExLPD4HyKifRX8EOXeytxhEP7/g5655Imok1ki5AmrT7jp/c5NQIDGXvGPqagZ8CfwMnrzCWXZYqQNc8gl+3uc5AaX/UXosqEj91lHe1u9zSiZJJVAJKlV9ppJipdbWUFs4D+EIpLIFfjGWxM21ynscpQ8NviBHUWjOOfqPznrDOZFKfiSbQLHnicOgwMPWOIDGVOfDir30N0asVmIDIVhwpSlraO2uNqKZXAvDiiU/VR+fu/bF0L7F185mYFKzdfLttCIAaDU512OUCXU+4YTrNhK55YhVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.194) smtp.rcpttodomain=linux.dev smtp.mailfrom=ti.com; dmarc=pass
 (p=quarantine sp=none pct=100) action=none header.from=ti.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BFgnjw8RKF2ORtreKN4JHad68I3J2O7TgtB90PxU9Js=;
 b=AcxPVJK4UIc3BAiC/lZxWNWYLYs4/cnpGs583iOL0sDksH4lc1qD6pTj+uGNGFswr1lY5myIpEzIw498cmEf2ngir1ZpUS5i0BpgMQ30E87BjEUrbGg/eOQYDpzLfUcvJXHbMV7m6RNdY78yxkwtOMgd4taGJkis95tONPa+z50=
Received: from BY5PR03CA0030.namprd03.prod.outlook.com (2603:10b6:a03:1e0::40)
 by CY8PR10MB6563.namprd10.prod.outlook.com (2603:10b6:930:59::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.31; Tue, 24 Mar
 2026 19:11:29 +0000
Received: from MWH0EPF000C6193.namprd02.prod.outlook.com
 (2603:10b6:a03:1e0:cafe::fc) by BY5PR03CA0030.outlook.office365.com
 (2603:10b6:a03:1e0::40) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9723.31 via Frontend Transport; Tue,
 24 Mar 2026 19:11:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.194; helo=flwvzet200.ext.ti.com; pr=C
Received: from flwvzet200.ext.ti.com (198.47.21.194) by
 MWH0EPF000C6193.mail.protection.outlook.com (10.167.249.107) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9723.19 via Frontend Transport; Tue, 24 Mar 2026 19:11:28 +0000
Received: from DFLE202.ent.ti.com (10.64.6.60) by flwvzet200.ext.ti.com
 (10.248.192.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 24 Mar
 2026 14:11:27 -0500
Received: from DFLE202.ent.ti.com (10.64.6.60) by DFLE202.ent.ti.com
 (10.64.6.60) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 24 Mar
 2026 14:11:26 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE202.ent.ti.com
 (10.64.6.60) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Tue, 24 Mar 2026 14:11:26 -0500
Received: from localhost (uda0271908.dhcp.ti.com [128.247.77.70])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 62OJBQna2688366;
	Tue, 24 Mar 2026 14:11:26 -0500
Date: Tue, 24 Mar 2026 14:11:26 -0500
From: Bin Liu <b-liu@ti.com>
To: Jens Axboe <axboe@kernel.dk>
CC: <linux-block@vger.kernel.org>, <linux-mmc@vger.kernel.org>,
	<ulf.hansson@linaro.org>, <shawn.lin@linux.dev>
Subject: Re: [PATCH v2 1/2] block: define new rqf_flags RQF_XFER_SINGLE_BLK
Message-ID: <20260324191126.kfhwuw4njinh2vrw@iaqt7>
References: <20260310160408.3976760-1-b-liu@ti.com>
 <20260324143448.2631888-1-b-liu@ti.com>
 <20260324143448.2631888-2-b-liu@ti.com>
 <5c12f6f8-5962-4d66-8414-8f5185438ecb@kernel.dk>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <5c12f6f8-5962-4d66-8414-8f5185438ecb@kernel.dk>
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000C6193:EE_|CY8PR10MB6563:EE_
X-MS-Office365-Filtering-Correlation-Id: 98bb7b5d-e6d5-4443-cdfd-08de89d926de
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|36860700016|82310400026|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	ORJU+AHjQOoZoNtdNrEPyI8th62coX6xXiZhQ7aCLJoCrw9n88nthN1IG03m8ZSfsHRUbW7wCfCyLzw0mJGB6AZwPKPeb7hXFDxEjWhxWkCnsWguE3ffHff9EhK9lqLiCdR/qRxhlSinL7+7F3PEDiJgEJIsVgSqBd2qIn286l+Wws4rW8qCwcDiFbpOVc0yqJMK5iR/6IZjI/jB+yQwmm9w9HFGoXDLT5G7cZNNLW+d7XJDR00IrLZxe4tukvWBe+KLlhDHLLj89zudyCTc3QmgUlMbSoIWpHmIBFAYPK3QLqMs4ZU8rHO2bjB2xglwKeYfxvAeqGGPgroIZgfjx+A4rb3g9/X8nMtNsZckSUCd5wQgS2TizF0BPe+fkUFPHlzvTgwHkZXhbyrh/O/CqMM6CSEHMhFPOLQNVUaHdNcxR/eyIevgywg1Xjlws3mgnjZOdTUqaTSb67T9jqj/0lmTgePpvb5VB/5a11EAY45FH4n1D7dd75IHKWub6PNJO2z4Y8vjrsDOpkWeJYnPHloEd0DegSRzU+plAsEHip55UDyj60+ituSN+/3IhSu2IzK5meP1vnqho+2fAa9Y9sjis3eg0xIFFryEJoAeXi+ByV/pcW78zT00SoiupEFm68ReFJSFe1ZAOxAA3qdnCQOuokpGd+PK05suo0Jv2nVrS8GKQ5shKxsoapGmPtk2VfMVoHWnDya4IJEVvLgkUR5XvbqoBKRy7QD7UR+vV+AE0ITa/tlH8x/PA672ovwsOxwTg5g60B/7npnQfswRxA==
X-Forefront-Antispam-Report:
	CIP:198.47.21.194;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:flwvzet200.ext.ti.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(1800799024)(376014)(36860700016)(82310400026)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	bXKnO79mm0CIB7EJShxnrF2KgN7RknZNlqoXRPCJpuXsBbUyGz1jHCKZzMgiA6G7mztU6UHiSJbkD6bVSxb5LSqd9Eps7JXalynO5IQqYtWFgUeuneYVlp/uQvQd/GfUm/uZEyScHlt32iEeHAA22dZQqIUZkevnP4QbyjO9SIlTEWM1DvFMgDRlIIVmQbY+0039qBWQp64+8TKikQDoKAiaHladJQxw+3sIHsZjiWg/FFkvFl0npUJqdcxic9/s7y1EeE5gpG7XcyMq5zvslXRH45NGIJ05XyuHDKiV2Tdgwd++2AMYvNQs3hSvNd8qvbjVW0g6AiTmpn47feeFkhMJZBO9dBeeQqYgoVvatFFq5L1SQr4x4gKqbrOqJZ1vdtyP6jJPidZR8NU2jdRc+4qbU9UeCEt4Hz9VOebs3V8DEmuD5/j5TzHtwfldzcXf
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2026 19:11:28.4872
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 98bb7b5d-e6d5-4443-cdfd-08de89d926de
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.21.194];Helo=[flwvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000C6193.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB6563

Hi Jens,

On Tue, Mar 24, 2026 at 12:48:11PM -0600, Jens Axboe wrote:
> On 3/24/26 8:34 AM, Bin Liu wrote:
> > This new flag will be used to handle multi-block transfer failure, in
> > which case single-block transfer will be used.
> 
> Maybe I missed this in previous discussions, but why can't this flag go
> into struct mmc_queue_req?

You didn't miss anything. We didn't discuss about it until now.

I added the flag in struct request because it already has rq_flags to
host all the flag bits. But I don't see struct mmc_queue_req has any
member for this flag purpose. Do you mean we should add a new flag
member into struct mmc_queue_req?

-Bin.

> 
> -- 
> Jens Axboe
