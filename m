Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010062.outbound.protection.outlook.com [52.101.85.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D9503DBD5F;
	Wed, 25 Mar 2026 15:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774452612; cv=fail; b=Spzz9M4J2a0flFVTkMVZfAvK5SXqW1K+15AtIufWPUNglMOE7H/yXteLZcKGAKw2ml4vr7Y3Z7kgEvV5zyJrN+7hfQYVsIifirnAkKPKDGRKhcgBwY1dDaWmlzF5TVxhQuqHSDYe86QKaecbCF8A17DuqJAXdUR4rGRHQc+9hWM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774452612; c=relaxed/simple;
	bh=uQ1LG2RwWLdmr9zXFLeU7qUlwYoybjvccGVPf/mo1iw=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z+iRPhg9owwvHirfRlC0YTFlEe9pwUaEXv0Btwi4kf/0OLQmWyhCE9EM4JBwF4Oca4RVnllLCXeySVNUQjQlaAzjibDN0P+KVtU8AzacxvRThcPlDC7PNeES7GmE0hiDgiBjLDiXBM6WWqdDXhbJSab/mSkhR9Ngopldp/YK/HY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=cuj2/WgC; arc=fail smtp.client-ip=52.101.85.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="cuj2/WgC"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PNvpan6MwfQmLsBP5jMCKDt5oz+fD8hvZT64Re6mnlO78fvgEhGBaxZEWOeI2xNSXweTxRLpdDJr/wrvvv2H5vvklPV5t6w9yWKtVzhEBMlRpkw3f6zcGMbBK3wgOQ9RlMf2Up2XTCgU8th9MXiYh/2iiKXmBSP+ZCbKDYXvmA2K+Llnqq5xTm8/BV9tQGkT3fz7zipBeSruwBJvKetNi9+wv5N00I1+LffCcG3OJp77tgcLDXcXo5+yxkD6v7a6h7o8ivyijauf6pHgbCncAHZOcoSlJBS1uOgJ8+6Eyqzsjnx3WD2hizrBgkMgAnXgFrbsaIWtBkF62KmnWh8Pgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xlTAS4VbuHBg0t1sDFcAape8V6RihSsVqzbvjcru2mc=;
 b=KLGO/3ftyCr+TZYWiA7YE/Py0LISH84lLhlI0OronB+z7PtXwICOy4sReoxzUkOlbRPcJSURXEZTO24f6wOzO1fjbFZpiQ4G+EOxNsbcGSInEzEjACb6xFHN7cBQlR+M3dAcfcMmIUQt4+rB0RtFdFvSy2hNBTHuvgGexocIaptnRCT5YsIjwr0Nk5WnpPrkEliaeFVp20zLF4UB1az3qYc0VaCoH6WIySUfZrucBNvnZF85vrZugLA4OFB5q9UDj8m6aebgo0+ZRJhP8REDImVb6YueYk5C4yUkE6FzRkka3PWopV2cL4FESMqxesVEEx111OVEAeWN9epAu3ShEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=linux.dev smtp.mailfrom=ti.com; dmarc=pass
 (p=quarantine sp=none pct=100) action=none header.from=ti.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xlTAS4VbuHBg0t1sDFcAape8V6RihSsVqzbvjcru2mc=;
 b=cuj2/WgCBo/a++Xs3Hy4K/WXGNkO0R7khQ5aauJVefrd7T1D3EFxyYBNrjf8t9qlx5xz5GYdqA+1RUBJOufwrQM+qpP6NsIGxMOnIGr+nZKzPZBPCmRcUbWOWUQKtcEnNs0dUsH8aKhWvKPI01tkqC0qsM26AbtY1mbAp2S+sIo=
Received: from SJ0PR03CA0288.namprd03.prod.outlook.com (2603:10b6:a03:39e::23)
 by MW5PR10MB5828.namprd10.prod.outlook.com (2603:10b6:303:190::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Wed, 25 Mar
 2026 15:30:08 +0000
Received: from SJ1PEPF00001CEB.namprd03.prod.outlook.com
 (2603:10b6:a03:39e:cafe::23) by SJ0PR03CA0288.outlook.office365.com
 (2603:10b6:a03:39e::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9723.31 via Frontend Transport; Wed,
 25 Mar 2026 15:29:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 SJ1PEPF00001CEB.mail.protection.outlook.com (10.167.242.27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9745.21 via Frontend Transport; Wed, 25 Mar 2026 15:30:07 +0000
Received: from DFLE204.ent.ti.com (10.64.6.62) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 25 Mar
 2026 10:29:33 -0500
Received: from DFLE213.ent.ti.com (10.64.6.71) by DFLE204.ent.ti.com
 (10.64.6.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 25 Mar
 2026 10:29:32 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE213.ent.ti.com
 (10.64.6.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Wed, 25 Mar 2026 10:29:32 -0500
Received: from localhost (uda0271908.dhcp.ti.com [128.247.77.70])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 62PFTWhW520202;
	Wed, 25 Mar 2026 10:29:32 -0500
Date: Wed, 25 Mar 2026 10:29:32 -0500
From: Bin Liu <b-liu@ti.com>
To: Ulf Hansson <ulf.hansson@linaro.org>
CC: Jens Axboe <axboe@kernel.dk>, <linux-block@vger.kernel.org>,
	<linux-mmc@vger.kernel.org>, <shawn.lin@linux.dev>
Subject: Re: [PATCH v3] mmc: block: use single block write in retry
Message-ID: <20260325152932.gkmc5m2erxwo5xmt@iaqt7>
References: <20260324143448.2631888-1-b-liu@ti.com>
 <20260325134947.2799552-1-b-liu@ti.com>
 <b4c84630-ff69-4d1c-8b82-815679d3fa72@kernel.dk>
 <20260325142106.j2uiurbkgac6xw52@iaqt7>
 <91fffaac-587b-46bd-9ce9-f3c354d89b6d@kernel.dk>
 <20260325142759.gnwhbnnffgyppu7l@iaqt7>
 <CAPDyKFpWL3HPnZOxrhZYni2Hc23LySqxu12tq2ee9wOkm_=KLQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CAPDyKFpWL3HPnZOxrhZYni2Hc23LySqxu12tq2ee9wOkm_=KLQ@mail.gmail.com>
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CEB:EE_|MW5PR10MB5828:EE_
X-MS-Office365-Filtering-Correlation-Id: 50d66b82-e5bd-4aa9-84d5-08de8a8364fd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|376014|1800799024|82310400026|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	L5GO1Ex+BjPeAA6yrwNsccxefwfP1z5K2w1ka5mcOFTTGlw5gaHgazLefSgcYeFKZN9dWzVFESZW+Lakp52WWz2osG98ByhFzG7/XvpQeKstp5nH46gv60YaaZuYVW/Jig57wWVoZrtkhkncU3JFbKrb+jNAj1gMKqf3Z+cflCbt6elxSq+ye0hBYzU/JEtJ6LKw3NX3EyHnb4QHvdpMH0r9hxvNHLP+tVhKakEFf62UUb3uClTcqZCEKrK6OStPxSb+T/pTG1kdy24u4a1n3dw+dLHeZdcVZKK5Gv2oDxkn/pKScnTikyB1coMdEvOXr+VXpz2D4HDeiSMeA2NSYZMy2z3WAuvuYE+9atRg1v6jr9HlpPqN1yHpzcsCv3i+YAf0gQOTWVq+oYHPx2wG1Z/hLlxNw2vLSOEQt5lIyF2ufhokdo1YzlZWZoUtMxKuqeoZhIO13js397hBJtZykd1OCv8EhE73MjxdVyEoj9uoGFwndqibGW/cWe1J8CKp4+gf0XW5Iiy0zTapYEuy5jSEGfHUJl7TlBXqauOiW8klLvh4u+YWSt/Gk/+c+P4DTr1ry9Ne+YSG5EciBzPMHtvjtf31LeWtGB3Eusf3yEnbsHFd5D8415yL8kbe8ISJsqiiBIVqlWhTu58UPg8f2ISEptyUsA3PCKAP6ZvaiZo40XDHkEPEJP1Sc34xXdeyeZRw12vWcxYbyCBKJc0XbhgAlJDnp4a2hAoBvJVuO66XzF5ufMAH+ZHB9e8BUe0V4oPhDB6tNwSbQIL1ZOLGRQ==
X-Forefront-Antispam-Report:
	CIP:198.47.21.195;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:flwvzet201.ext.ti.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(36860700016)(376014)(1800799024)(82310400026)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	vitUIudthiIfSNWGGsMr8/GDWGrDUgxQo0pyL48+hsK9b6ESSftNLXAmexRjekJhiltFu7hdQG4vMdZZhwk3GyucR7hfC0zlnMJvUa37NXbH4ccY3YrIDPQ3uWPFLjShlbGJ15djPihbajJBMwGkvh4jHL/1X5XvT4ZCv0o8RDKNn8qaB6U3mioTB0IkyaH+FsI2m8eGJYTdHiL1AR7KxH9BzT2J/gjXdo+QBA/AHRZ4O4tMQD+Ldh/zj+OOjvQ/yI/0Or4oA7g5dDZWguLkuOv2osPZUJId5xsV6wHpB6wvdIU8YPV63lzH7c1w2tVGc2OTpPMqIKz10sEhj9Avv5n2v9LMpAmnwJW6+AxxYbqquB9CZoYOtcac5lGfgl/dAeFFkugcOApETv1Zh+vn41UHIdWbH0IUOVOpeHbkrz7HQsDFHMR8CGURnJ3FQD6T
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2026 15:30:07.1598
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 50d66b82-e5bd-4aa9-84d5-08de8a8364fd
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.21.195];Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CEB.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR10MB5828

On Wed, Mar 25, 2026 at 04:22:15PM +0100, Ulf Hansson wrote:
> On Wed, 25 Mar 2026 at 15:28, Bin Liu <b-liu@ti.com> wrote:
> >
> > On Wed, Mar 25, 2026 at 08:23:29AM -0600, Jens Axboe wrote:
> > > On 3/25/26 8:21 AM, Bin Liu wrote:
> > > > On Wed, Mar 25, 2026 at 08:12:36AM -0600, Jens Axboe wrote:
> > > >> On 3/25/26 7:49 AM, Bin Liu wrote:
> > > >>> diff --git a/drivers/mmc/core/queue.h b/drivers/mmc/core/queue.h
> > > >>> index 1498840a4ea0..c254e6580afd 100644
> > > >>> --- a/drivers/mmc/core/queue.h
> > > >>> +++ b/drivers/mmc/core/queue.h
> > > >>> @@ -61,6 +61,8 @@ enum mmc_drv_op {
> > > >>>   MMC_DRV_OP_GET_EXT_CSD,
> > > >>>  };
> > > >>>
> > > >>> +#define  MQRQ_XFER_SINGLE_BLOCK          BIT(0)
> > > >>> +
> > > >>>  struct mmc_queue_req {
> > > >>>   struct mmc_blk_request  brq;
> > > >>>   struct scatterlist      *sg;
> > > >>> @@ -69,6 +71,7 @@ struct mmc_queue_req {
> > > >>>   void                    *drv_op_data;
> > > >>>   unsigned int            ioc_count;
> > > >>>   int                     retries;
> > > >>> + u32                     flags;
> > > >>>  };
> > > >>>
> > > >>>  struct mmc_queue {
> > > >>
> > > >> I'm assuming retries is a pretty small number (didn't check), so if you
> > > >> care about layout/space in mmc_queue_req, you could make this:
> > > >>
> > > >>    u16 retries;
> > > >>    u16 flags;
> > > >
> > > > I quickly went throught block.c, it appears retries would be only a
> > > > single digit number. I will update the patch to use u16.
> > >
> > > Note that this is just my suggestion, it's down to Ulf. But what I would
> > > do is a prep patch that makes retries u16 and ensures that's sane, then
> > > do your flags patch on top of that. I think that's better than making
> > > that unrelated size change for retries in your patch that isn't related
> > > to that at all. It just sets you up to not grow the struct after your
> > > change.
> >
> > Okay I will wait for Ulf's decision to make the u16 change or not.
> 
> I have no strong opinion, before or after works for me, while I

Okay, can you please just take this v3 then? I think we typically don't
mix fix and optimization in a single patch set. I am talking about other
subsystems thought...

-Bin.

> certainly thinks it makes sense to do the optimization.
> 
> Even ioc_count can be changed. From a brief analyze it looks like this
> (needs to be double checked).
> ioc_count <= 255
> retries <= max 5
> 
> So maybe u8 is good enough :-)
> 
> Kind regards
> Uffe
