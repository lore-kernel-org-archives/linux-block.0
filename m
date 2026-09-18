Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3E243C1D72;
	Fri, 18 Sep 2026 03:27:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.154.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789702028; cv=fail; b=QxmpeaToikW1lTisOzj4UEryvI5/apxhNCgKS1/wgsGRwzmJQ+FrV5ysHwxW0CxndypBeIUQWjZEbZbkCdxKY9icrp1GvGxeS09uTPRsEpSb6TbP3x1pBFy8VWRNeJ/7GckrRrDB67PZ4sEazWbr7PU8f2ekzqR36wiNr5a+vMs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789702028; c=relaxed/simple;
	bh=ETPOGCxuHdjSt02Ac6hKt4lFQcXzD+xZAwPPMCKr32U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=GOAVmzpXJg7sx9qYnJcdPws9zw1cxJqAtS2LG17+j4nEF4Kqj6mKJnKPNLayN+t8VuDhU0DKu+G6aw/ZXY/2ePC3t0OlcEIdf80cRzFrvwia2qLrwVS0v2m1DxLq+1lddCnVGpPoZpXd3OVVM5Ge0Z5fA+LKhb7H9Z3gU9qn0+M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=kV1ImWer; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=Avc3BTG0; arc=fail smtp.client-ip=216.71.154.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="kV1ImWer";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="Avc3BTG0"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1789702027; x=1821238027;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=ETPOGCxuHdjSt02Ac6hKt4lFQcXzD+xZAwPPMCKr32U=;
  b=kV1ImWerd+51sVMN8RL/hI6HSy35MS66jWwpppnoYcbtwt0nyuLtdvLh
   um6Rm/lNXZ1+E3guJD/YBB2tmznCpQBHp+r3xrpRNww3w4U0p4ZUu1C/C
   9cTC/0OI94Oo2qQdTCCF8suOudo4+XV9BztV6AMjqoM74RizXF5T74hKR
   1Z8MUi5Hs5Zp3GbmZHTkOmrPBzmpOM7iDnJbHeiJrIc3+c3jZAHb+59QH
   KTYJM7vp4oUUiFIUQhJuSRbif6QcHmm1B8BFLXWyD/mhmt1kf7GAookZy
   D8HQUKxIybz+YqQ4RcJ4kpF+Q4jpYGrPZte+p4VEpQZY0tkFkV+ILUM4v
   w==;
X-CSE-ConnectionGUID: 2hxhcp2xRl2VfrMedqLjqw==
X-CSE-MsgGUID: fXH2rgMlSumQznyckLkO+g==
X-IronPort-AV: E=Sophos;i="6.27,103,1786982400"; 
   d="scan'208";a="151749418"
Received: from mail-eastus2azon11011020.outbound.protection.outlook.com (HELO BN8PR05CU002.outbound.protection.outlook.com) ([52.101.57.20])
  by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 18 Sep 2026 11:27:04 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TCQjuCrCe8QhNoMZ2dLIySz7nd0O7MyUJ96O23OnF2ROjdtaFaxjkXXhzAcOrDgssYWpY8LhqKXapCdvUZFCnL5w1jiHns5aoFYIjm6wnEhpDzF9fYmTrlyEDNDvsIDZ0GaGdVfb5d6nQoS0Uh4Y0CvEZK/9UXyoVFJ53d/HsZfzVmDLIdWxo0+mPl+zUwtjzb125zeNXKu9xkkpVt160w5YggQzrmmzuGeGH0s8Q7xl9r8g0UOCOPHPLfUvzSfmsIzJGFQ1ALJq/Vu5XFM42r0MmJjUkWuEoi8dIUMS+kdjLndxhhP21q1RbI2l+7udkOCnZURpWYY7P780qgIhYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3EyzJFcMru/uGbtdMeTGHN1jODHZLO6/mp+2J098RWw=;
 b=lYGN/wtwDNcxD+qxl8HdRAqsEvqRE4fdbXEG9qGa1PmG0uNSeHUpiJdK/bBmLNZCqAvC2Rqgu2PQe622Gt8UyIvZPZZLi1sRWUGLTkCcm2VCdOmWOIB/lELiiK/wCDZF+G55db5kwC2j3jyA3dwhmsCojraE48hAQFatPm+EgrEN0lqnWKcwoxQwZ7tQKfCUAp2bG1v2I79Or8azdDBIJilKrykOK2A/3JrZhB6AtzEZx2kYjyJIkv1mPaCb/eXyh1qieTJEm4vxuHgBVXn5TrNpUBTnaorxYYus44tOMNY5d8mA14rYB3YTOsNtrdSBErRcCYQv3qhr6oiayOoeSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3EyzJFcMru/uGbtdMeTGHN1jODHZLO6/mp+2J098RWw=;
 b=Avc3BTG0U+/p19KSFngY1TokL6jsKE6V5KXnHuAZGcy81FMEYQKC1MeD5rYmRZp6LlQFejYZwzLreAYJ8PEpreeTJvUkOwDzGBxo4WeZmSKiQn/g6bL71Tf1EZhi5/VOSuSF2GfMykf/hh0gvnLm7mvhO4dIoXGiYYrizXK7t4k=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
Received: from SA1PR04MB10065.namprd04.prod.outlook.com
 (2603:10b6:806:4dd::14) by CH8PR04MB994453.namprd04.prod.outlook.com
 (2603:10b6:610:373::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.13; Fri, 18 Sep
 2026 03:27:02 +0000
Received: from SA1PR04MB10065.namprd04.prod.outlook.com
 ([fe80::9b98:bf8a:b0b1:ef85]) by SA1PR04MB10065.namprd04.prod.outlook.com
 ([fe80::9b98:bf8a:b0b1:ef85%5]) with mapi id 15.21.0428.011; Fri, 18 Sep 2026
 03:27:02 +0000
Date: Fri, 18 Sep 2026 12:26:54 +0900
From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: Tal Zussman <tz2294@columbia.edu>
Cc: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>, 
	Johannes Thumshirn <johannes.thumshirn@wdc.com>, Luis Chamberlain <mcgrof@kernel.org>, 
	Hannes Reinecke <hare@kernel.org>, "Matthew Wilcox (Oracle)" <willy@infradead.org>, 
	John Garry <john.g.garry@oracle.com>, Christian Brauner <brauner@kernel.org>, 
	"Darrick J. Wong" <djwong@kernel.org>, Keith Busch <kbusch@kernel.org>, 
	"Martin K. Petersen" <martin.petersen@oracle.com>, linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Sashiko <sashiko-bot@kernel.org>
Subject: Re: [PATCH v3 6/7] block: unpin all pages of a bvec in
 bio_iov_iter_align_down()
Message-ID: <aqyo0NA6UbdBiBq8@shinmob>
References: <20260909-blkdev-fixes-v3-0-1a5222c6e8ad@columbia.edu>
 <20260909-blkdev-fixes-v3-6-1a5222c6e8ad@columbia.edu>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260909-blkdev-fixes-v3-6-1a5222c6e8ad@columbia.edu>
X-ClientProxiedBy: TYCP286CA0322.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:3b7::11) To SA1PR04MB10065.namprd04.prod.outlook.com
 (2603:10b6:806:4dd::14)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR04MB10065:EE_|CH8PR04MB994453:EE_
X-MS-Office365-Filtering-Correlation-Id: d3f1fd85-0f5e-4358-37e5-08df1534b46f
WDCIPOUTBOUND: EOP-TRUE
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|19092799006|7416014|366016|23010399003|11063799006|4143699003|6133799003|10067099003|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	7T0HhLoI00Bhlp64ubIP3hPmtu7vy45U1owiWxbggB3Koa9a/g7+UhfTbxl8VYQGBFvCO4xyjQizrjLcFCfvrVKSs+UShOKZ7dBci4ZfwDLUAmL53EpjMEw5Vb6GIbFPJEjnCvpKmDJJ/KMoYjs1rg84RQszSlpFrCJ5fiahQbuYiUHcWLtFpZWcR8h1fBm+5j6Vj0A6DPKNlerGnfFLcw4ELCAtNvtZHkZ50HYZwB93StSS22TUuLopTNOQ/K6Fgjx1z9NrEPGYCXJm3El+cCgDReCsgCArAhZi0Wbb349EuQQqVACEW16jMwmYEAsYUMsvtlU6WevD+kSWRTDqKpp3SOWcS+RqImT6q8Qzt4dwsupB0ZtSNIgX5OoXys/YxVPmaNqECbeSQ5h8Bglz0YqLLht4wWEo+Z5idugPqcnuqW6y1ppl7M2CCFW6IlEHzpAhrvA/kdVQqN/VniJrvn+aNVj1gGUQpJjrUIKrNN5ehQXhX3r7AhqobksXUxe/kEuZm4LlpfvQEJZHGUMEPLqrrkOH6evVorg1IYJ6CZqPVR6VuJVWpq4rRWU+ks062JIdOsCC9d5UfoyGw3h0JB7ZEdHl0k0I4T0lA9V8ay4YCj4ZWJQW4uYCnBPN5aGZEehOqR2g8EJeWomG2cBCwLtcEjJkwUmQO4EcQG1TlCg=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR04MB10065.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(19092799006)(7416014)(366016)(23010399003)(11063799006)(4143699003)(6133799003)(10067099003)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?42zxjCt38UqePtUUWnQUyxsFckQXk0qTd9xVrza212Y8uM02+JU7iaHomLqN?=
 =?us-ascii?Q?xaIUbWVdHAERM8QPAlQNjqZLlsR2BdJqRRFLt5YTp+G0VBZhE3ZsUgK7HAIR?=
 =?us-ascii?Q?jzRhIiHd0ZO9NPe19SZaHJ5Nwdkbm4bgW/Kg40dknLpm6+sqrZ3gp95kZBk/?=
 =?us-ascii?Q?RtIQ2NeJs8RYkFt1RzZyNRGTODBA7KRTqFnxp8y+j1K1nwAZpH/aufCn8tJu?=
 =?us-ascii?Q?et7UxVo26EhxGknYhQzkb9cqZIxZA+pZKXn3tMvV3rZrydinN/yF9+zcAJ1t?=
 =?us-ascii?Q?SSHeMzj9EyVwjOz2k4ozwCwWP23CKu9Amz+nxOhOOhlEgUKc+EHteL9oqhxZ?=
 =?us-ascii?Q?aI3Fo9l3+3Uj+7pokZ+sGjHWmQFwC2H9GrlN0JiIxxmjYpnqB2HWkNWTNV8b?=
 =?us-ascii?Q?n5F1wgzHBDryyeQK0DPvIIDNd5Y4bgbMuoZvP1YGaRM4e1TsKvX78i7OZyrS?=
 =?us-ascii?Q?zRtNlDJp3WCel4Z1T82uRPRhudmnrbYeFkh5O6od0RQC3K1FOBNVosLo//3H?=
 =?us-ascii?Q?BIYdg5fPYeJo7/ztNA4fiLsb1NId5J2H/ofevI4JPRRyArG5BkLyZWj0OJa+?=
 =?us-ascii?Q?aJXpTjShp0tE40z9qe1F+3NQEoi50K0Vx9+KHqzsqNjXWr5U7hAHW9cHwiet?=
 =?us-ascii?Q?7dfFjXxnciYrfNAvlfT2GuvjU25hRUDCnbtj0E5K/Tzyvv9LKdQItRs7vplM?=
 =?us-ascii?Q?ThcTXaqBukUmyaql+/pgXLsJ2L78KCfScvcfXGU6T1iAJLhkLpuD4uVTMncg?=
 =?us-ascii?Q?qPSULFpbUGVrs339AKvyHZQbPcPaB/IZfo7KgXZ4slYFI3zMtrKdzAdxU7ya?=
 =?us-ascii?Q?wtiUtLdpJnMfIX7IbxhiDE2Gw7erjgqp7TJ3T8dnZ4fY6c6k4voFj9DJXfuO?=
 =?us-ascii?Q?VyMj01yin2AjtpwnXn/IS0s5PKTTnH5uqQVmuTSH5MyH5LuTGHYTotBfiMXZ?=
 =?us-ascii?Q?7WReyXjk5bBmVmxsuKh1a/yvz4+7HHmxzWcc2u5mzAwCHT4wxz6AYGy2oRUA?=
 =?us-ascii?Q?y+nb2gvy0dHQfQZ/t+1nH3WfHrcw2iL8qy0I3Bnl84fFRpt7DMzdZoGT9ki5?=
 =?us-ascii?Q?fzpw1Jk9GBP8FMm82nXLJgzGhDOPDHBtqaoTqgLa33gvb3Ise/BJK21YspFK?=
 =?us-ascii?Q?nEFhIt6P8/Y/nBKueex+cYLn+MVVwzp87yvhCMIO2oP2NQMglZMbpsO8uAc4?=
 =?us-ascii?Q?siLEjMJ1XGtBqnDt1ODasfX1wO56OTEQucd04YcZIGGQv10OF0HX0VZ6SLm4?=
 =?us-ascii?Q?CJv4sNJ76PgVN7VFjHs4mBFDnd0BR8Rz/OBq9fvHKeLtCRoCkVuykPcN/Qe2?=
 =?us-ascii?Q?LfrGEzQ851GjJuur6ZeiWa2TOESeVbX23g6JC31TrUlrRogng/RrV/f2Pjms?=
 =?us-ascii?Q?aYV4pSXhbaQSL0OWfR+g913G+3RBgNUFFBpIfh5ns7bt+4PtEKsOW/uWyT9u?=
 =?us-ascii?Q?CukCfUTBecWwM/fAkdJq5OIozXW/hZ/J57GxPOWBcxTFmtTwH5zFhSX6Oih1?=
 =?us-ascii?Q?1LG8DzIxSlgR2wdM/fWwCDDEr74yxahxlWZbHmLxXvlXWRiMvIuqHJ7Hjd27?=
 =?us-ascii?Q?fFKNEDQUX8IX62ZqkdCbQYM310yMI2krZZPxuttxtX0hmA6f+UOYhdVqbWM+?=
 =?us-ascii?Q?U18tjXbH0zXh/nUpINWnnZHR/Mcx6z8j6Bh3TWZ66M1245s26eLVgDmlDPZw?=
 =?us-ascii?Q?EhAfjLc0LsEdTSZimuGoyWBjWnrElFVct/oCLMkvg5orsCUdbsr/j+fSsMGX?=
 =?us-ascii?Q?NDlPEfdVf8VFsCZIIbJwO4+JpTUFWBk=3D?=
X-Exchange-RoutingPolicyChecked:
	MyGdJcRlizDeDZY2nNdtud+oOGBMdIlq5yinC202/nQnr8BKfW9xw97CKG07eESutFc8xGm7md5pbLN0uj2Xeit8ziPMbn53PCFJAcVy09JHFmPXM5Ly6VeAB0AeF/AcN3wJ8sGanRkejrXWjHnlh2eqEFQ63nvBBuNy811GdIA31w4cL2oeqKhZXtPvmzFdphMDx/f/AtwgstHKa6paqo+eqol+/uYlwY1P7t6TnRGsoHWSQ/VPihhbvO+N3+MpDe2zvE6WxuB/MtCoNa14gEMrlGIXGsNFgJQ45GjCaONqsrC5AAes1L+L/X3gc50L6oklWmmLDt71Em6/vqMbcA==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	tF6p1E9FMzM6gabxlhByhRBJL+qeqV7yFwA84dui6XpXIscLUt6QeEkNOno65av5cLweIWvP7vNcu6iriVSG0nHJnbVOD+bMJ7LIJ94V8lunL0bnvcFGetSqnm/afqq7a8rvfDjELo5rk//TFyGJG5iBi2D8gGNj3/0d3dGv9KmyCg8ow6/bX+6Hcd1+pwnTf8fgvsW7Ks/VsvcqfPMIWaGqsLA61gv80VnGp8OaGvRbm9IVe13Zen1+dcgcBxqhbAt2aHEsLnqtIQOzhWAtdI7EiP0vBKo8iu0wBgfyhsm2Ytm4Cc4IKDK5+6J0dKOkco0YmLiQ6KHR/tHHMA0S6L2DeNpGaCC8pn6vNNE41cF6nA7FsSiS37zKF8GhAkyEcL3+B8BwFXl7LLceUmdU4ZsrOVDcGLLKiw13i4pJ0KX9UQnpmWwU3ZKKX1wYkiMPA191vi7miuE4bVaDcN8YOwbPUSgTO05jEqRljhjJPHJklJzTiG5AA3TAKsIHdnLEjPv3GbxVfbPIDCgh5ezuksJB/6n77NmnvW7HzwZG8WZ+BB8Pvc4a+g34z/KBfnDKhvLjmQFflvPIiHSLqatyiIvavR1HLWPG6tk0dUyrB6GIWJ2EtOEXH3nu5E+RBQm6
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d3f1fd85-0f5e-4358-37e5-08df1534b46f
X-MS-Exchange-CrossTenant-AuthSource: SA1PR04MB10065.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2026 03:27:02.0448
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: I+kK3DB3Cho5xV7rLc2MrOd/fGdqXFpPVH/VJzzEZDjm0NvmGr+7/CTKgCGK0n85wdAt14rhKNLTKv++M2bM4NWfdXAKgK1Rgnh5rklWRhg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH8PR04MB994453

On Sep 09, 2026 / 18:05, Tal Zussman wrote:
> bio_iov_iter_align_down() drops trailing bvecs with unpin_user_page(),
> but a bvec built by iov_iter_extract_bvecs() can span several pages of
> one folio, each with its own pin. All but the first pin leak.
> 
> The partially trimmed bvec has the same problem. Shrinking bv_len does
> not release the pins for the pages cut off by the trim, and
> __bio_release_pages() only unpins the pages bv_len still covers at
> completion.
> 
> Both issues occur only with a logical block size above PAGE_SIZE and a
> large folio backing the user buffer. On a device with a 64K logical
> block size, an O_DIRECT pwritev() from a hugetlb mapping that ends 16K
> past a block boundary leaks one huge page per call, whether the
> remainder is its own bvec or the tail of a larger one.
> 
> Unpin all pages of a dropped bvec with bvec_unpin(), and unpin the
> pages trimmed off the last bvec as well. Move bvec_unpin() up and split
> its page count into a helper so both sites share it.
> 
> Fixes: 20a0e6276edb ("block: align the bio after building it")
> Assisted-by: Claude:claude-fable-5
> Reviewed-by: Hannes Reinecke <hare@kernel.org>
> Signed-off-by: Tal Zussman <tz2294@columbia.edu>

I confirmed that this patch avoids the failure of the corresponding
blktests test case [*].

Tested-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>

[*] https://lore.kernel.org/linux-block/20260909-blkdev-fixes-tests-v1-3-1f8af8665d16@columbia.edu/
