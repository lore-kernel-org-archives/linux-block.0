Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011030.outbound.protection.outlook.com [52.101.52.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF8B42ED84C;
	Tue, 24 Mar 2026 20:42:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774384923; cv=fail; b=UL9bGspEWw6Y0kJO1+hOA+A3TG1C3JwA9WhI4Tzx7SWgaByfgsySJ9cAFffz+Qg4MO9s5YaajkT1Wg/UneDgROdO1OxC7UP21V8/laWcNXteZV7Zflr6w9c0rGqWDKbU4I0Yw0ZKK6iQaXQbcRm0kKwEgS2bAZYrij4fyJCYy1Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774384923; c=relaxed/simple;
	bh=4UpAm8yR94aA1E3vXgYT41RWKiaGZvtaoG6+lvB8IlE=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=esCgDEITlQHKT/YQpVNUbotkwOlzKETcJdIa3ao/sRwkQaLWK4yhl3X2erYjDo56XFq5HUwZZd+oI875a3k9eRZlIDjM32l5eDX2mlUai1Tcgorup1hP4izbMh1HToOlOow7dSiwxwEtPJQp5Hk8gB2rHGWTCznJEaUuTpFW1Io=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=DIIQioVh; arc=fail smtp.client-ip=52.101.52.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="DIIQioVh"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gvdf+2YL85pAaK4PBKhaVabRfSVJSuotKFNxny8OkQ1xqQEVLFAZvw+mIvj7apu0gqERt8wFdqPwVEwfEjCtRYNdi8JNt/AG9fSIL5JfuRrDI+E1FUMEyiMqqxr7rAu9bO3Nxqdm04n/LUdW1u4+C+m/ax+LaBXmuM7dhKPXm3Uh0q235cRBVrTlSKDwMy5Q7bsOBaiLS48YxUvkiD0wnnsXBABoO6UggjQuL3PsJfuhXs913Z28Wc5/6u5H229Brdqc1uACkLsQCgQy2Zo7looSwYHmJLB0P08/w+bpsWnZHwqzq5oWc+2grYNubrNZDVbaD6GXtfC3IenuO3AyWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qOip9xjd1QIfaQz9gxUrDT3o7YNDLt4xn+CVe+waKYM=;
 b=eJGGNLvgFv+8RtxsxrWgIzLhg6hCVVlHA48OiSTXaVIUjnNdEuOuoVkl74/OxWI0lVwVU3Odf4UB/qPEZ3/CJUxgt0J9Aw1PCi6KeKa15XGe5ee1XQgF9wTBNVjypJqsaFD2RwQ8gBT1TleeJduw7g8aXDk4LGmvduqBXKKDQxwBPnQ7ugImVSE5kqiiZzIYtoC9hOxUv6kbFvE8KWjuqjjIKaKXvU4JgK65Gc/L4Hhcok2Jsxy4mRmfd6SXsQkrqBhD71Y4mP20AicifAJ8CgFjs7mUMEr7bsqQQa539BrpfgFfUGuuOQeg50CA891+SzNze0uGursD/ePD/lt04A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.194) smtp.rcpttodomain=linux.dev smtp.mailfrom=ti.com; dmarc=pass
 (p=quarantine sp=none pct=100) action=none header.from=ti.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qOip9xjd1QIfaQz9gxUrDT3o7YNDLt4xn+CVe+waKYM=;
 b=DIIQioVhdtD2+nXIhKzWnS4TGc3L+szfryvsUlDPYDhlzSlutkqlrYtb9Dwa6hFFTdDOuzLbjP5lSl732IYmMPKXLaesidsueJpB/+y9/BxR28QeB8a9A1edyCYzBn08V8ng63gytSR4DKg9wJPHaugmrPILnEAhqIfDDToodaY=
Received: from BN0PR08CA0011.namprd08.prod.outlook.com (2603:10b6:408:142::33)
 by DS7PR10MB5165.namprd10.prod.outlook.com (2603:10b6:5:297::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.31; Tue, 24 Mar
 2026 20:41:57 +0000
Received: from BL02EPF0002992C.namprd02.prod.outlook.com
 (2603:10b6:408:142:cafe::f1) by BN0PR08CA0011.outlook.office365.com
 (2603:10b6:408:142::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9723.31 via Frontend Transport; Tue,
 24 Mar 2026 20:41:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.194; helo=flwvzet200.ext.ti.com; pr=C
Received: from flwvzet200.ext.ti.com (198.47.21.194) by
 BL02EPF0002992C.mail.protection.outlook.com (10.167.249.57) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9723.19 via Frontend Transport; Tue, 24 Mar 2026 20:41:56 +0000
Received: from DFLE204.ent.ti.com (10.64.6.62) by flwvzet200.ext.ti.com
 (10.248.192.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 24 Mar
 2026 15:41:53 -0500
Received: from DFLE211.ent.ti.com (10.64.6.69) by DFLE204.ent.ti.com
 (10.64.6.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 24 Mar
 2026 15:41:53 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE211.ent.ti.com
 (10.64.6.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Tue, 24 Mar 2026 15:41:53 -0500
Received: from localhost (uda0271908.dhcp.ti.com [128.247.77.70])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 62OKfrvA3261696;
	Tue, 24 Mar 2026 15:41:53 -0500
Date: Tue, 24 Mar 2026 15:41:53 -0500
From: Bin Liu <b-liu@ti.com>
To: Jens Axboe <axboe@kernel.dk>
CC: <linux-block@vger.kernel.org>, <linux-mmc@vger.kernel.org>,
	<ulf.hansson@linaro.org>, <shawn.lin@linux.dev>
Subject: Re: [PATCH v2 1/2] block: define new rqf_flags RQF_XFER_SINGLE_BLK
Message-ID: <20260324204153.a77cieh5kti7ydla@iaqt7>
References: <20260310160408.3976760-1-b-liu@ti.com>
 <20260324143448.2631888-1-b-liu@ti.com>
 <20260324143448.2631888-2-b-liu@ti.com>
 <5c12f6f8-5962-4d66-8414-8f5185438ecb@kernel.dk>
 <20260324191126.kfhwuw4njinh2vrw@iaqt7>
 <33177597-8df5-4494-830e-6e287bb8188a@kernel.dk>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <33177597-8df5-4494-830e-6e287bb8188a@kernel.dk>
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0002992C:EE_|DS7PR10MB5165:EE_
X-MS-Office365-Filtering-Correlation-Id: 416887ac-2866-4b93-b97f-08de89e5ca37
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|376014|36860700016|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	i3xOXpiJHFF1eWrHPJH3VpbSEcRvb16jiB++ojUppFpdB7HxcWgrv7tKRps1hBQsbVzGffKRkaojXsTGBLYzo6FBkLxee+ZK1izzzgeioUZHml3FJfw3MEMFCzVVuWhx+kQfcR/eTXcYj4cjQoz5gYzDK88yiCPQDI3rJ99oJ1oRiVENDBQhhvVlS7dIR0XpOYc2f6r9ggX4i44haZgTTDYVG8EptU5vnfasXjJsw+1GHda+HgJDT3JC00dyCXJcLio72uuRCSw8eevSxvWCgF1kKRcgMM3TPIJ5/32v/Rde2NCeHDcoEbKS1hAyfc8ceKpacLhoiLEjPIa/5gNLnMeIVulSjyFnCwu2g7sDoMrt/wHBVwUtNHj0fJ4f22vWbuumiZ8jEFhd8GLTN+gopB/wJBBcNMuPw5LC0t9pFJk8/yEuwL9yURSePTbDm4RWwJyMc2+/ueFQKfE1pUPCeplKrmLskGbC8fcI8762fyvq4YJnYXan7tLZhsm/Uv81Gc2vcuOdgrfq5MhrkSxaI77/UVvMpoZwG77jCchDPbZ2NhlDoGcyyzXlpl5FUHzkmN2oLFQpD+3kvKGzme6BLT1ngnA+76KS8qhdhsS8HbSFbxnlqBl+onm5FmD/Yt7WNMqUza3qeSkSItgwmOWzOGv/NlFn+IlhinIEjkduZHm7S+E3A4dcLrQjLnRfRZmCOTxil0HbSHNP/68d4cY0B8L/cfUnhp5sKCHw3IIhJa/BNK8eYmoi9KXPpEzQ2loe6GY0ukFjvBqDT9Cr4m5jsQ==
X-Forefront-Antispam-Report:
	CIP:198.47.21.194;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:flwvzet200.ext.ti.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(376014)(36860700016)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	p6C8hawromMHGK13Oi0/EHb8QqfQOw+QeUVIQHQBygGhkOQWJjNk2O5i3Cb6gazZWnqKL8Jlfrt14wEaajZvkkH//LpkHvh3QlQrHd/LQrueIHks/RUdTUbAH2ZRIYq/cT4oY6a/qRgCNSf/AJ0PdvyX97ZElNYmqHNwDQm8HniNKszM6psRvr0UZKoXCevu9fI0u+jmRBlamvKD/BoyayJ5Hua+AaPLknKdB77G9qkKe49f4bFYLEZrZK9dGOJJ657rmS+zqMeNxDAhZAvXgcDRw3VJ8ix15hYNRRWANpPeLeerG2knFdttkeZGpw+jXms+jN4hhwmFaynF9df1oj5Of0OkhtMXiKbZ3fRdeVGDyjKlNFbRuPBMmjpiBWNsWOPBVAR6INl4Aks9Tk7lwGrlH6nkVvonlClLSfWT4zTfwF2qWKk8E7UjxcfWMZw5
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2026 20:41:56.5167
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 416887ac-2866-4b93-b97f-08de89e5ca37
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.21.194];Helo=[flwvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0002992C.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5165

Hi Jens,

On Tue, Mar 24, 2026 at 01:16:34PM -0600, Jens Axboe wrote:
> On 3/24/26 1:11 PM, Bin Liu wrote:
> > Hi Jens,
> > 
> > On Tue, Mar 24, 2026 at 12:48:11PM -0600, Jens Axboe wrote:
> >> On 3/24/26 8:34 AM, Bin Liu wrote:
> >>> This new flag will be used to handle multi-block transfer failure, in
> >>> which case single-block transfer will be used.
> >>
> >> Maybe I missed this in previous discussions, but why can't this flag go
> >> into struct mmc_queue_req?
> > 
> > You didn't miss anything. We didn't discuss about it until now.
> > 
> > I added the flag in struct request because it already has rq_flags to
> > host all the flag bits. But I don't see struct mmc_queue_req has any
> > member for this flag purpose. Do you mean we should add a new flag
> > member into struct mmc_queue_req?
> 
> It's a bad idea to add driver specific flag to the core flags,
> particularly when you already have per-rq data associated with the
> driver. Then it should surely go there. The block layer doesn't care
> about RQF_XFER_SINGLE_BLK, that's strictly a device property. Hence it
> should go in the driver, NOT in the block layer.
> 
> So yes, add a bool or flags or whatever you need on the driver side.

Sure I will add a variable in struct mmc_queue_req to carry this flag.
Thank you for the comments.

-Bin.
> 
> -- 
> Jens Axboe
