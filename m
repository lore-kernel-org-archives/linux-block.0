Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 162B73451DA
	for <linux-block@vger.kernel.org>; Thu, 16 Jul 2026 06:49:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.153.141
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784184589; cv=fail; b=Zxvf01BP7sNJuy8+iAbJsSnTUweTaiqk9Xu24/L4RFV72K9sdqitf9JLACi3skfrh8tvq2/5W0zKYSsU6U6voicyp9S+U0xYLyCosL2FJSqUfH26fwZQB8JzIFajb9EdMW3iekWoavStJrJFOD11CpBWpu3614YYNRuLDgJiAUg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784184589; c=relaxed/simple;
	bh=uIiSbUCj8mw3nl9yGclb7XP9piF5j9JV/dH6Ysx6A2Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=S5RAh35M74foXFugOP3UWuUB5WxCGj3We1008cAAZghWfL15q/hfCttbTP9Sn0IRZCx+G+1eHGRF+buHL3K4tV9wCkwiSKKV5QYIPMljYxvJb45eGJjpVDtwY98V2d3Z0RnUWMCNlbQpZ9/uRYi3dmMzG7yE+XRy+pwMDSsC0N4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=aXZ+BiPv; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=AD1c5u5c; arc=fail smtp.client-ip=216.71.153.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="aXZ+BiPv";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="AD1c5u5c"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1784184588; x=1815720588;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=uIiSbUCj8mw3nl9yGclb7XP9piF5j9JV/dH6Ysx6A2Q=;
  b=aXZ+BiPvJ2TmjtbFwaUUrZNXHJSegSND6aTUkWfJfpE0pq4cdjN+RpOI
   GYFzCsOGln6JD3snENCad6H0YCaqoioM2G6HnI7P7y5TlyNdJl1KigrF9
   jVJf09UQO8U1E9olJ1r4dsN49yX+w+jQuyRRb/tn89fA5hYKDkMyuqGq2
   636upi9gB70j8R7bMvkGCbyQ4FEtbu9YTuqf1ZrdUSNJhlKT+Uqrfr2t9
   14PjK76IdC/OLzr+Zqi0qQiWfEneBXOtUyWIJyf8zX7vklMUI1A4xCU/2
   dfm8R5+cQb7t93KwosAd3sLKASCVd3c+4X2NFb08biEA8mhPPqhBgn6J4
   Q==;
X-CSE-ConnectionGUID: YVwjOyFFQtKohmkA6TwS1g==
X-CSE-MsgGUID: CTLEjhmFSmer/ABkvOybLg==
X-IronPort-AV: E=Sophos;i="6.25,167,1779120000"; 
   d="scan'208";a="151134843"
Received: from mail-centralusazon11010067.outbound.protection.outlook.com (HELO DM1PR04CU001.outbound.protection.outlook.com) ([52.101.61.67])
  by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 16 Jul 2026 14:48:39 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UUPUwMelNAwnxqMe3ovjW0WPoJFiEPJkJDI9KLrAXRt5ojdRYgfSDe6Q5ItrTPOOPE/Yslb80Wnm0UBoDzUEpuu5kLlzHyOxOo2AEDGNCAtfiu6SKmY3TiwAxrTcmsu8Cq3yi7kYbILN7CqS6CNI9zl2TtZWyV+gMdUYHWZu2eYbZVjr1r2jP5NpldxmuFDnRa6N4jedZur4gjFjBsNBh7JpVKgV4E4vgLCsw907tJOJM+BOVGb6deKRwdet3DcfkzKNzWcktEhLvvPNoh8N6OLWxZBxQLv1xgOkWkod/SrwAxNPueJdt9ewmH38Ri9WEeHJOmRidcida99EfvC+7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=arV86yWFcV4OgdNQic1WE1ec2VFG9I0uhioCIT9YkAM=;
 b=M5u/dUXGams8Xn2AmmPCE57ozNCUs9W8wGCA+QmvTGb+0L6f9WjP5zuWZIppYC3qaJYzKGXcfQLieN/Lmr1n7bh1fmEaHlW3gVeUO3KKZNXkmarBCU0pTcCht/1da3llvUtWyjWbMT9tjBf8B8fxpK06apTXhqoYHAS+/B9W3e+nowP3pgAMt/tVkdF7VJPKSMtLmxE3jqpa+cDY+a/BQdYYwbtkvoiBusXLUIYyiPBn/xA2LcKWF3kzNUatlgFyqGvRgwE5paG+0UutjIkyfItLQGhWyuuuuwgMuA4DeSnPTnkDHTLeo4M2mRdLo0rO9WUcRotMtjBZZZPt03Z8EQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=arV86yWFcV4OgdNQic1WE1ec2VFG9I0uhioCIT9YkAM=;
 b=AD1c5u5ckjeolPx0ulSC8aQ5JMnOaDe6TgJQcnSCWzws6NWX81GhiPIbqVnQRr4zfaIhaqj1MuInDKWCIOkzutGgMjReBD6IcTAZAffoBJAHZUlP6j4upFOMgsF81CMm5eQZtbhxHysbUXr4URXPY/qKC9Dqss2ZW3gKJ0/LGQM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
Received: from DS3PR04MB10053.namprd04.prod.outlook.com (2603:10b6:8:38f::5)
 by SJ2PR04MB8963.namprd04.prod.outlook.com (2603:10b6:a03:562::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.202.18; Thu, 16 Jul
 2026 06:48:36 +0000
Received: from DS3PR04MB10053.namprd04.prod.outlook.com
 ([fe80::faeb:7524:f842:9f3a]) by DS3PR04MB10053.namprd04.prod.outlook.com
 ([fe80::faeb:7524:f842:9f3a%7]) with mapi id 15.21.0223.008; Thu, 16 Jul 2026
 06:48:36 +0000
Date: Thu, 16 Jul 2026 15:48:30 +0900
From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: John Garry <john.g.garry@oracle.com>
Cc: linux-block@vger.kernel.org, hch@lst.de, 
	linux-nvme@lists.infradead.org, dwagner@suse.de, John Garry <john.garry@linux.dev>
Subject: Re: [PATCH v3] nvme/069: add a test for multipath cdev lifetime
Message-ID: <alh8G0J1kXHGaOPo@shinmob>
References: <20260715155531.3811457-1-john.g.garry@oracle.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260715155531.3811457-1-john.g.garry@oracle.com>
X-ClientProxiedBy: TYCP286CA0274.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:3c9::10) To DS3PR04MB10053.namprd04.prod.outlook.com
 (2603:10b6:8:38f::5)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PR04MB10053:EE_|SJ2PR04MB8963:EE_
X-MS-Office365-Filtering-Correlation-Id: b0d2f9f6-281c-4142-1704-08dee30642bd
WDCIPOUTBOUND: EOP-TRUE
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|19092799006|366016|23010399003|22082099003|18002099003|3023799007|6133799003|10067099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	gapXSGLdSTw1ewpjYNTsnytDY9lw6w9THcmP6VOueoucXf4RVObBxVqPKz8TYLBdeRAfEOS8yyym89vn6vTm6SQ7ZD3q2g8g0A4kqwmfO6a6lu+kvnHA3H8ieoq0bB25DuJUoJkRIqyck7suj8fKCgaheWqs8qJhjHU6KK8B1FTrRmelpfeUDllUCDN1JCTK2KpJeOEwcebwaAW0M7pEPqbGRcJAxqAApcfXooUw3vVdu5UfbC2dwcJsnrUkX/MFnn8jl32z8npm1WvqeivFUq02Bz7oFlogHThXecRCkXrNx3MEMbxv7zEUAlZDVF1/Ee18OOYKD29sx4l6FZJ9Sim5bL7poZ2iUEuxFCdu7CDAwNNKXxV0eBn8ZMCxrwdkgQCOZOQ4SuJ2ZlKMqIw7rw1sHvPVG6tAlUEN7Abn2z0TBBMU21iH40BuyA7H+RdvywVCIJTBL+1sKah9Fa6bG+H7P/kOzXReX5HbMyzlQTRFvjA13j+tfXG/FtnVYw4i+WEfNpBOVMoOGHiPwWpyT7LxyNhR5mQdaWbnxfhqChnGSoNozakIdcRYyIIdeooJLVf5e+jSUQhgP38UxQ6r/4jx/n7T0McsH4NeEiVp1bAJmK1gVCUa53SFblTeSABc
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS3PR04MB10053.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(19092799006)(366016)(23010399003)(22082099003)(18002099003)(3023799007)(6133799003)(10067099003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?01KDHV+bD8nlNdrt9l7/pIALa68W1s6d72i6HjnR85KMA33TsQyFyrXtjRsp?=
 =?us-ascii?Q?s2j9qwZVzcOGcb1e8kumKUClyLZDtye+dfuMs3zBOruFH2Rv0VlZxqyK49dn?=
 =?us-ascii?Q?BqioVs7qfc9xLlyVkVW52c61lTPmPMIdutk8G364db4T0phqNyWYbslx7Y1e?=
 =?us-ascii?Q?m9Hgnigb8dzf7HK9oxztT8T3DSm9KCACeX95WGRz37gE2rNs2X9JCRBmvTU/?=
 =?us-ascii?Q?oQBhcbqm2bJeE6xjyoWPGu89fuO4DK7rXg8x4qMQ8T8e97H+lVZRdV4c+sLT?=
 =?us-ascii?Q?taBv0NGkk5TVKQPBdF5lvWFYMZVDPzQgrcPZCp0ZeaXhCeIte6nEbZNmBhRI?=
 =?us-ascii?Q?BAT0scCPkcO9nw0R08yIe8CN8x3qzi8zL2eT5NDmYa3yLS39dYqpspY+nJHR?=
 =?us-ascii?Q?UuLPS+kyXtb3AThVQ/wkuVKXncqYTD0A8sEpyX3jwGXC8BJ1H5yYX+K46BId?=
 =?us-ascii?Q?W9NC5gCETl1fs1SNyu7qrIV6gk2W95uJNkUIl34A3k3a1qnTouva6vhpWueR?=
 =?us-ascii?Q?Iekj1kszaNmbpGQVBEWEBJFDdLHIvN4a9QHerKoXwixSv7zlxQSlHYFvs9zo?=
 =?us-ascii?Q?oiLh9O4OGZ9zN2FPKPoO9UiMSSk3RMxSQl1p/Lt+PsfCmEJSEFvKiyY8zei6?=
 =?us-ascii?Q?Oefv5pS1s14r1n0PXD1rxF018BQdsh7d6Xyp9B04p+/NlZ87IYwsGOwr+iD8?=
 =?us-ascii?Q?I3CRkpyShlETpTZj4LyLlWGLTGl7kzD4P8V2rwJ0Jndgx+exz69Prg/Jan7j?=
 =?us-ascii?Q?iZb0IWqU5fPnJCbqmnD+4XR1IdK/uX6kz9LPIQsTYMq6I7qyBYLYd3IXrSmj?=
 =?us-ascii?Q?bur48x0MTIMejEPC1PYp6NvHXfszS9K6WaOzUicftEWMmD/L5W04mVlxY2bx?=
 =?us-ascii?Q?XIxEHyRNtD9pJoHpFTLNDN/mRu8KL7P5IcXYwPyPfqhskq9vdZEJjYO1KxYs?=
 =?us-ascii?Q?hA0iZkOglV3o/utbjQ5HBG+DOeKl4uIs+Z7mAYHaCxvw3GldoSSi7awBdTTs?=
 =?us-ascii?Q?Tmzl69IXZ9gw/gwTIogpCtJQ26ZKkioBElC+aeflRD1euR4NuMERlPppcQX7?=
 =?us-ascii?Q?ft40WPSZb4qHPhortTJZH5E6tpFeAKsEGtgIm6EfYKBbJd9qkvlshkCWvTRh?=
 =?us-ascii?Q?h3HRtbLXS6qmigZ79kEq87fNuBpjPgWhGMSd4qf8af2lsPz6vLVX79VLh183?=
 =?us-ascii?Q?2iIyVuGfKbcoZ6AC7Id+w9425V+EXypcr4JXN9aD9m/G6AhSF89mB3yhPm0V?=
 =?us-ascii?Q?BQDi/exFltWzCxbAJu+S0NlJzWcfb18fYXvHocnrCZ58PFhTDuq53/ZEnpJt?=
 =?us-ascii?Q?Y1sLnsbOOo+0HXurMVv2C5Xn6ynyFcbGIM9fYJpBvj9TpFpzH5Wces7nREpI?=
 =?us-ascii?Q?gwtZkaxDrNg0+lconwaaVhooA/lZTG8e1QSuNyCFR7XHgGIn3j940xMrGl72?=
 =?us-ascii?Q?yNeY9cfzQnLx2PnBq+8dCSCcdpTjuPGYnb4WFSzDPNeslBl0DF5gl3NC4bKt?=
 =?us-ascii?Q?773CpEMh2tQTeDjSOrZnXFhEUmnL2XHM3aWL9rNgwmL8lscZ8D0/7cFqGdBl?=
 =?us-ascii?Q?gPkl5rEyTud8f5lSxUCLOn6PMyimaXLkJroRSVaVXaVPpe1qt1bCZ39At71R?=
 =?us-ascii?Q?DXjfWYbDZxGFdR1qQ/t+0JWb/xTqCs3369ffljBKyV7kv/0TtjvTIBayA9Iy?=
 =?us-ascii?Q?rsFC21sa5mPXoMA7iHS/XbEwnCyIPG7dmRluGQMso13Z0fuWyNg9pWSg1kD+?=
 =?us-ascii?Q?rmnGi3Pzw2bTw2V/sbauSqVnbifvEAI=3D?=
X-Exchange-RoutingPolicyChecked:
	ATTZ1eaLKmX46mfF+QGBoJYNYSzbe4ruKwqbZ3pep45NJ4DPcjwW8h8i1DS5fjOLEo3tf6iS8dWMcM2rEGfoHeeryMNfk7oDGtPQSsOZWIU7573Q5vte4xW1gs0eIGwBTL0wtMvV/tdkNbnGrnHLW1lccpfogWSTmCbLYuCXLo5tntl/Onto0W7viiRe+lQUnlPd0J7/OmxzP0QaSSSBO/9dDI1BpSx9aIv+WLD3xIrl0pUNp4q04V6prICuF+baaDc1oWgv4lsUb3CyZC/X44rPIbyBpUI0uSroaNY99oKGx//GfwF1bxbLzb6p5gwq3manDBnuhEPVOIQFKDjJuA==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	xN+LyOss5Hp7uEKlozEoa7UIJ3+mGLftYgXaSGCf7y0YeHqUj5KC/gVfrmeUebUysXdcYbkZsk+lIiWQHMBvPZAfJHrkmjyze3HS28mQxe09ScsPtw1wXUOy4RT9IN0bOkZN9Hw8TELCDusHE8n9Uaj+RUCAddk88NzlPhBBIuWXD0CSraxlyKt37tkrEV2/uzArwbpHR68TV6acswYxaB5fDywySK4D01z6wjkpLyj/HKh4DJVkLi9G647MGItowXxBj/1P+1ZhGb6FN2aJ64S1eOUtg4D5cJmI+o35nEaS0kc9z2C29XBPhyJGrxugxOksn+GgVGOy5P2wRzrWtm5wKLoUDceN8Ws8TNDrRrcJQA/uyKxlRHf2ksIDLWJzJhv/pVJfUyngtrYLQnyVmdzdujmlvHKe6e4YXnWaaT22p02ygffREQs/UM3ZO2AdKEClSv9g/0HH/PbXg/DB0uaTfid6cZZ6LQjP713PhAIWPHJdJ19kWrB8AjzzAcaowhbOuknUhGNoJW4T8VTMl1YU5d948ja+ryIIXA85lNhi13dcvwYjgKiPFJExq3QuOJvC/Nneu5j7LnMge5wzjp+1QvhDhPuJ1YcTczcIqlc3fHoLvbUaP0eDm87oO+Gz
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b0d2f9f6-281c-4142-1704-08dee30642bd
X-MS-Exchange-CrossTenant-AuthSource: DS3PR04MB10053.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2026 06:48:36.4389
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UEXJzT6zn+kxtZpMrjcpiH2IpyNCejepjYQzRfVO6hsfNme8NRgf8BG0LCK3yZd94XCC+2wTj2fa2PxbBCUDI7+I/zht9eza9FTaNvza1BM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR04MB8963

On Jul 15, 2026 / 15:55, John Garry wrote:
> From: John Garry <john.garry@linux.dev>
> 
> In [0], a fix was proposed for the NS and NS head (multipath) cdev
> lifetime.
> 
> The issue was that fds for the nvme-generic cdev may exist after we tear
> down the nvme-subsystem. Issuing an ioctl on that cdev may expose a
> use-after-free.
> 
> This test recreates the method described in [0] to expose this issue
> for NS head cdev.
> 
> First a fd is created by opening the nvme-generic cdev. Next we tear down
> the nvme-subsystem. Finally we try to issue an ioctl on the cdev - without
> the kernel fix in [0], this should trigger a KASAN warn.
> 
> [0] https://lore.kernel.org/linux-nvme/20260713104238.3034640-1-john.g.garry@oracle.com/T/#me118851584fbcbb960795d0f04e2262e5a295613
> 
> Signed-off-by: John Garry <john.g.garry@oracle.com>

Hi John, thank you for the patch. I ran the test case and confirmed that it
triggers the KASAN. I also confirmed the kernel patch [0] avoids the KASAN.
Looks good from test run point of view.

Please find some review comments in-line.

...

> diff --git a/common/nvme b/common/nvme
> index 15e9c3f..902a33f 100644
> --- a/common/nvme
> +++ b/common/nvme
> @@ -300,6 +300,26 @@ _nvme_wait_subsys_removed() {
>  	done
>  }
>  
> +_nvme_find_subsys_nvme_generic() {
> +	local subsysnqn="$def_subsysnqn"

Nit: though it is not strictly required, I suggest to declare local variables.

	local subsyspath _subsysnqn subsyspathbase nvmegenericbase devicelink

> +
> +	for subsyspath in /sys/class/nvme-subsystem/*; do
> +		_subsysnqn=$(cat "${subsyspath}/subsysnqn" 2> /dev/null)
> +		if [ "$subsysnqn" == "$_subsysnqn" ]; then
> +			subsyspathbase="$(basename "$subsyspath")"
> +			for nvmegeneric in /sys/class/nvme-generic/*; do
> +				nvmegenericbase="$(basename "$nvmegeneric")"
> +				devicelink="$(readlink "$nvmegeneric/device")"
> +				if [[ "$devicelink" =~ $subsyspathbase ]]; then
> +					echo "$nvmegenericbase"
> +					break
> +				fi
> +			done
> +			break
> +		fi
> +	done
> +}
> +
>  _nvme_connect_subsys() {
>  	local subsysnqn="$def_subsysnqn"
>  	local hostnqn="$def_hostnqn"

...

> diff --git a/src/nvme-delay-ioctl.c b/src/nvme-delay-ioctl.c
> new file mode 100644
> index 0000000..854b702
> --- /dev/null
> +++ b/src/nvme-delay-ioctl.c
> @@ -0,0 +1,69 @@
> +// SPDX-License-Identifier: GPL-3.0+

Copyright is missing here.

...

> diff --git a/tests/nvme/069 b/tests/nvme/069
> new file mode 100755
> index 0000000..89f048c
> --- /dev/null
> +++ b/tests/nvme/069
> @@ -0,0 +1,61 @@
> +#!/bin/bash
> +# SPDX-License-Identifier: GPL-3.0+
> +# Copyright (C) 2026 John Garry
> +#
> +# Test NVMe multipath nvme-generic cdev lifetime behaves as expected.
> +
> +. tests/nvme/rc
> +
> +DESCRIPTION="NVMe multipath cdev lifetime test"
> +CHECK_DMESG=1

This test case completes within a few seconds, so I suggest,

QUICK=1

> +
> +requires() {
> +	_nvme_requires
> +	_have_loop
> +	_have_module_param_value nvme_core multipath Y
> +	_require_nvme_trtype_is_fabrics
> +	_have_kernel_options KASAN
> +}
> +
> +set_conditions() {
> +	_set_nvme_trtype "$@"
> +}
> +
> +test() {
> +	echo "Running ${TEST_NAME}"
> +
> +	_setup_nvmet
> +
> +	local nvmedev

Nit: I suggest to declare nvmegeneric also:

	local nvmedev nvmegeneric

> +	local loops=0
> +	local quit=0
> +	_nvmet_target_setup
> +
> +	_nvme_connect_subsys
> +
> +	nvmedev=$(_find_nvme_dev "${def_subsysnqn}")
> +
> +	nvmegeneric=$(_nvme_find_subsys_nvme_generic)
> +
> +	trap 'quit=1' USR2
> +	# nvme-delay-ioctl will open the nvme-generic cdev, wait for teardown,
> +	# and then issue an ioctl.
> +	# We tear down the nvme-subsystem in the foreground so we can catch
> +	# if the ioctl triggers a use-after-free KASAN warn.
> +	src/nvme-delay-ioctl "/dev/$nvmegeneric" &
> +
> +	while [ "$quit" -ne 1 ]; do
> +		sleep 0.1
> +		((loops++))
> +		if [[ "$loops" == "100" ]]; then
> +			echo "no signal"
> +			break
> +		fi
> +	done
> +
> +	_nvme_disconnect_ctrl "${nvmedev}"
> +	_nvmet_target_cleanup
> +	wait < <(jobs -p)

My understanding is that wait command does not receive pids from stdin. Then I
think "jobs -p" output is ignored here. I guess you meant,

	wait $(jobs -p)

> +
> +	echo "Test complete"
> +}
