Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010021.outbound.protection.outlook.com [52.101.46.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 511E93BD645;
	Wed, 25 Mar 2026 14:21:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774448471; cv=fail; b=eA9KbkBMPVGfpAp4ZGj2dAQs0r7nrIjej/KSo9Z23z3BStfBWCBtz4lfNPWQqtt3SzZ0GwIh06Y97y1Rb50dJFuOmWxUWS4dcrlVqdYiimjg89NTw++tQ0rOXvuvYfCKkQqbcyD2tm5wwdTcw7PLIV+g12n5+9QkVSePHgCeHc4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774448471; c=relaxed/simple;
	bh=41AIcONo9SzhjGVg3J9wQ0alEEkSy9cnslg+ZVInenw=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VucwuUotQGS1Ya9HMe2Y8uGXH4ZkFTJQpTrj4BHZIw7wO0FAtOYab8QHQtBmFFwNp+R127E87Ffy+jCBoMp0ZWyB91q0MOBTsi7yb3APmEvWVDaYgsNUCR6hbutLrlIV+zSPXi2TNhzhdOWjzPYXmcrgxawQxURC1x6Opwo67KI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=fxSZMVqw; arc=fail smtp.client-ip=52.101.46.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="fxSZMVqw"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jlD4hbwPfTMnqU9ACCtLLqWda+5k2p/8Hz0ziI4VWXAVJdrQ7z/oPNiup52U5TKKEnodEn++u6Oxt005nY+sHxemm7K+VFaLDEMkFUsXISEstXw9yStKEPJeLKrnuIo0WXjezZ/kVG3R9f5nOVXsknryJsxXHn5tC1FPF5avlApU7UAKoJPoQ6bLNeu/hq2EPFiR/2VasPZiSt751ui5hgnLpryKkDTer/y5xl9ilfuHYBgr8oXdhjdJi7ckhjNNlR2np3IDvAdFoTjmag9fZ1UwC8Fcv8Lsup+8T8I0RAmh2z/K9BqEv16ZwT53tdaZB0umaoHd1rMAbK9wDXIXRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JGg1zkiTSpZIVSM3888j1oINospk4BgP/cCiiI5H9DM=;
 b=vtKHd2Gsm8ZIHCj6hYJ1lI0ekeURyNg4alaSvMeejXV4pqS2+QpVHkBvBlj5lVZeXZlBA8RpJVCCMyQY5Kr/VD58wwbKMPr64gJTVG521JAhJJhjtNgT/3Qa+zFZC5PM4QXKroXTG3ORoCEfSaXQoT8yo992GYarJeCL9I01w2U5ajR0jPiwzS4nnH3rDCG0FZ/UF9SgU8o5y8ymYaOb1A1kSGW7LgT0ZjKIvjUx76nXnCde5TVhixB+CqyRLbBB4rKuAysBm3MkxcE/JXCiEKKrp+GbW6ra0l/cpz5PPsSTkY+9hmyrFfm8H2e9+af2vYIEdMIvWk6y784LHpD2Xg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.195) smtp.rcpttodomain=linux.dev smtp.mailfrom=ti.com; dmarc=pass
 (p=quarantine sp=none pct=100) action=none header.from=ti.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JGg1zkiTSpZIVSM3888j1oINospk4BgP/cCiiI5H9DM=;
 b=fxSZMVqwO9i0cuQratFNrNZvbjWKsUzpT38RLmNPq9ZLFxvOhXY73dZRo/aYsMtfvmoAOnbZv4DrurATNlW4LHXeHkppMZDmuXCSaeVQgGtbxIssF639+e1ne43lcEEiQ1IVTZOct/iqiPCCWXiNP9+nbPY3cWp8JMX8fOG3GG8=
Received: from SJ0PR03CA0150.namprd03.prod.outlook.com (2603:10b6:a03:33c::35)
 by CY5PR10MB6263.namprd10.prod.outlook.com (2603:10b6:930:41::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Wed, 25 Mar
 2026 14:21:08 +0000
Received: from CO1PEPF000066ED.namprd05.prod.outlook.com
 (2603:10b6:a03:33c:cafe::52) by SJ0PR03CA0150.outlook.office365.com
 (2603:10b6:a03:33c::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9723.31 via Frontend Transport; Wed,
 25 Mar 2026 14:20:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.195; helo=lewvzet201.ext.ti.com; pr=C
Received: from lewvzet201.ext.ti.com (198.47.23.195) by
 CO1PEPF000066ED.mail.protection.outlook.com (10.167.249.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9723.19 via Frontend Transport; Wed, 25 Mar 2026 14:21:06 +0000
Received: from DLEE200.ent.ti.com (157.170.170.75) by lewvzet201.ext.ti.com
 (10.4.14.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 25 Mar
 2026 09:21:06 -0500
Received: from DLEE209.ent.ti.com (157.170.170.98) by DLEE200.ent.ti.com
 (157.170.170.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 25 Mar
 2026 09:21:06 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE209.ent.ti.com
 (157.170.170.98) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Wed, 25 Mar 2026 09:21:06 -0500
Received: from localhost (uda0271908.dhcp.ti.com [128.247.77.70])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 62PEL6sx4152384;
	Wed, 25 Mar 2026 09:21:06 -0500
Date: Wed, 25 Mar 2026 09:21:06 -0500
From: Bin Liu <b-liu@ti.com>
To: Jens Axboe <axboe@kernel.dk>
CC: <linux-block@vger.kernel.org>, <linux-mmc@vger.kernel.org>,
	<ulf.hansson@linaro.org>, <shawn.lin@linux.dev>
Subject: Re: [PATCH v3] mmc: block: use single block write in retry
Message-ID: <20260325142106.j2uiurbkgac6xw52@iaqt7>
References: <20260324143448.2631888-1-b-liu@ti.com>
 <20260325134947.2799552-1-b-liu@ti.com>
 <b4c84630-ff69-4d1c-8b82-815679d3fa72@kernel.dk>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <b4c84630-ff69-4d1c-8b82-815679d3fa72@kernel.dk>
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000066ED:EE_|CY5PR10MB6263:EE_
X-MS-Office365-Filtering-Correlation-Id: 73048a8b-8b10-4720-4e10-08de8a79c125
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|376014|36860700016|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	5iD6ZGbsOw8eSAFBkX71n/WYFfsW0JkpTVzZOLhBT0dh8qnWE9cfuM3b9Ogc5qbQimQ1kTPXg9tdgfs8l4lew4GfQIOSadXm0L9ZdNbDfEJqKirRnksPSKfoBO2H0kvM62SbxRtVFkSqy34Fi5dmc//7TWEUKT8MPenFev1bOvIgZciHnmnKcweTFEUoXUyCQpApsPP3Wfz5PxI2ZRUGInPa1I2rtsKPQNATkT4sq6VMbw55MZcroG/WxDOR7MjZN6wCDdtUEAXbKMIIyKnyGWE7SynTUa5FwCz4+AO2xFxu/OTZjXx33/tqLZXLECpaqMR7HNm7i6/JJfDdi3ngXF41xohJbiOq65EpDunpXCc9P8ejwBQTJHFh07G50WAjoZg4sMpWPoeC7lt9/SfCuOOJWxpCukfEpiPnPoflyIadntpO/r58ysLq1x+6RbkcuVXTd6ZU95vf3fYSYz+ttPbjOhlE0cjbDYuBCucm7oIVFRQrORrf/YZ2yz+L9PJexQU0xcLzy41tLZbzDvVkzN6rdoUgpbTkyBTpg+s8hNev3gXLlQzrLePQPmhsP1dO5wgqPv58XfyIqGvObGSP855JxQBQHC3Ya1TZ4UH1SceO9GLDo1GdoeK2AkA2QEjpsS/f174NJavwJqRypunbNQj/GWd3LYoIEplUF3y1IiIkuVFg0/ebmfhE6hZRpeAWMSVMUoZqOh6BvdSrrzbZUc1oLm4UQx6FqD2zBgd38XQt/A6L0ly4kEmZhjO6RGOv26xmPM/Bn2ZA9pnzlNzoGg==
X-Forefront-Antispam-Report:
	CIP:198.47.23.195;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:lewvzet201.ext.ti.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(376014)(36860700016)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	aLBWVlrDluobHT3OjYDr/+7ZAVM3eIOgI210ctvGOPwnMOxluOGYIGZa6v74rR8EunhxYdDVH3Od7cXjpBi0Y85wKGIDCrPrHKw7LiYtFpgNeKYQQGIwcPEFv+Wn0MgJ5rZaO6yKLtqLLl+bsh5Nna6sLwKzY84IDpj5sbpZYR7+r0TGadyq0rDTegP/JHxDY+QugROHumTtvpYCFls1LNaqtXatsuX7HacEw0PGEAmyNLp9N+QNZM87sq1CuAVT2tIxK33tzYPZP5GNyUCg4w78ZWJL5ynn6GvELQBjbLZjzqh9esIegy0CCTGs/5fq4fq4Qly8Wpcb5jeO6D/A/GHj/bi1CGJJeZ1oJumh7jnz9688LcAuV1/8/QHRm2r8fBvdxhuNaLs0fWiZj8w43An3dXhkX6jyF2KfYBlUjWBK+0vZG38xQYf9JwYuvxZ8
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2026 14:21:06.8028
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 73048a8b-8b10-4720-4e10-08de8a79c125
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.23.195];Helo=[lewvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000066ED.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR10MB6263

On Wed, Mar 25, 2026 at 08:12:36AM -0600, Jens Axboe wrote:
> On 3/25/26 7:49 AM, Bin Liu wrote:
> > diff --git a/drivers/mmc/core/queue.h b/drivers/mmc/core/queue.h
> > index 1498840a4ea0..c254e6580afd 100644
> > --- a/drivers/mmc/core/queue.h
> > +++ b/drivers/mmc/core/queue.h
> > @@ -61,6 +61,8 @@ enum mmc_drv_op {
> >  	MMC_DRV_OP_GET_EXT_CSD,
> >  };
> >  
> > +#define	MQRQ_XFER_SINGLE_BLOCK		BIT(0)
> > +
> >  struct mmc_queue_req {
> >  	struct mmc_blk_request	brq;
> >  	struct scatterlist	*sg;
> > @@ -69,6 +71,7 @@ struct mmc_queue_req {
> >  	void			*drv_op_data;
> >  	unsigned int		ioc_count;
> >  	int			retries;
> > +	u32			flags;
> >  };
> >  
> >  struct mmc_queue {
> 
> I'm assuming retries is a pretty small number (didn't check), so if you
> care about layout/space in mmc_queue_req, you could make this:
> 
> 	u16 retries;
> 	u16 flags;

I quickly went throught block.c, it appears retries would be only a
single digit number. I will update the patch to use u16.

Thanks,
-Bin.

> 
> and not grow the size of it by 8 bytes with that addition.
> 
> Not a huge deal, obviously, but always good to consider things like that
> to avoid wasting memory for nothing.
> 
> -- 
> Jens Axboe
