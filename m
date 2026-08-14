Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBF34463B76
	for <linux-block@vger.kernel.org>; Fri, 14 Aug 2026 11:24:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.154.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786706703; cv=fail; b=A3BZE9p1wTeoopzT6XWTNECR25jGYvFtTLngRjRowtsc7unoi3hhr+Zx7YFY21C1iSaOvQA/iGq4YCPNPyrf6c39+u2mAxMiHIj12QQn1TF7RLCc3wGT6Pt9gajBgVGYIN5pYBBwmb98f5ZKRvICy3lEn4tK7MBPexiI698ptoQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786706703; c=relaxed/simple;
	bh=7zYPVFSfb/9NeK6kAvx9uCHTh7PUFuNatKTMUfqcfCE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=kJ8hwm0VsrRepFOylAzP+St+5hty9B5jFlNpG7bDTjrbdSyv/wPlK2Q9hoDaRjnwt81DFfGudQLgedztUuZmoPC70/J1CHQg/ZIxgnmPiuY21a2XnzS7iVwm1LJYoGZgQuDG1UFXEQsgQ8/tH5aEXFxVMzjkSulqwjzNE5vvCFA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=Ak3uZyCF; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=NXugAEjt; arc=fail smtp.client-ip=216.71.154.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="Ak3uZyCF";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="NXugAEjt"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1786706697; x=1818242697;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=7zYPVFSfb/9NeK6kAvx9uCHTh7PUFuNatKTMUfqcfCE=;
  b=Ak3uZyCFXObyrY2OiTvxFqomceWPiYvzokWySU852HzLTyWdZf1BNG7/
   7xUmS7vgGINd+/dMy4fhHi1b3QqqJrgfDRgJp9K4F96MWCVAbsFGJxH5N
   cIWZJZ4yg8wf9lgOUyKkn2d7exhYuzUQOMwnXKa6+N0tzw4bjTVkGWQX5
   nXII90JyE1L0RsPxzGqrCl7hq6MRPzKNlf+Mo8cUKkoiv4809cgHh/7oD
   ObX8p2WfoG0FCPnm8gepos47WrBZnPVyk63YW6d2Y7LM9MAUP5a8+e/Dd
   Y7X6BUl3UaTbbhYKPVRZcTxUHibmLAE8c9vs7FqIT1YQUZDZwAI59x8+O
   g==;
X-CSE-ConnectionGUID: tRBnSfIuSMKRdq9JzhPm4g==
X-CSE-MsgGUID: 8uusMYZ8SrCr0waXEhctmw==
X-IronPort-AV: E=Sophos;i="6.25,222,1779120000"; 
   d="scan'208";a="148973863"
Received: from mail-centralusazon11010070.outbound.protection.outlook.com (HELO DM1PR04CU001.outbound.protection.outlook.com) ([52.101.61.70])
  by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 14 Aug 2026 19:24:48 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KkaYojpXURnTn8mafWSDPahI+AJKY0fIeu2+kzi/+ODtvQ4KNUiWMOQ6V6RvmAIXHJsupRtMfxtPT274QYJ2vDUtJq28oVJ2dumsH3uSDGriTf+HjwHzFGxaSKmVBgITEDr71VNvExrLf5VjgR3qIJfaycBQ/+I6cFWn9n0QeKo+8ljw5JJHTdyUd9sNwLpYFzpNBZDq6rjLaUIwMoBq2D31nYX+Lz7I+d38SRcd+9FdaLDIrZ6vhBxxL102F2K2mv2JTuvP3fMUNLOeMzpzaMSfktiFK+ld/xArsP6FoorYbWNHoRsFR4KjuPA8mpo6CWXBSZskXVTw8F9IxsBCoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QCMQ51WWM0p4HTwsgnSC7hGQAqXtISxUYpRd+UejM+M=;
 b=Ks0QUkmyrEZ7d93CkJUoT1Ba+q3OrBK1Y97u2khvca5NDXsjPd9Y1YEV9aEnH15zGV0nFIpRtsAdvqyqIwapwMWj+FruF1YiAlczxZvuHgDcQnDNpYCDZcnAUUF06FL7w2H0ISTRlGHkr2Nb6vUmtpvCmKDQ8DpSzWMfui///78p+Tb5+BtPdSgq9Zc0EsZGIgn7ChaduspUp9toAbh0QTGXz8wIQ8UysS0VtathDe91WDtjqA6Dd2MPxAIQ9L0ipBox6/D0ULFhei44uiaIF5vRY1PF0gtcCtIdWBSiczZeze9TMPu4Bt4DbxEJlRKFFh1nC8VevrIakGAENdrJPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QCMQ51WWM0p4HTwsgnSC7hGQAqXtISxUYpRd+UejM+M=;
 b=NXugAEjt2TTx278TsLhp8gnwYfBhBbf5CUUXovGxWjz2XN81qOzyrv+Pw5lbsaFmTegyYxp3oXtCHSt7cZBsU4UWuvgLdEfi4ZeZP7mn3GFJEhCGWMVmTl6kBchm7kcGR6mqG+jS/TJ81Uo3ivDwB1wzlrVaoi3oQqf9IYd8gqQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
Received: from SA1PR04MB10065.namprd04.prod.outlook.com
 (2603:10b6:806:4dd::14) by PH0PR04MB8296.namprd04.prod.outlook.com
 (2603:10b6:510:10b::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.16; Fri, 14 Aug
 2026 11:24:45 +0000
Received: from SA1PR04MB10065.namprd04.prod.outlook.com
 ([fe80::9b98:bf8a:b0b1:ef85]) by SA1PR04MB10065.namprd04.prod.outlook.com
 ([fe80::9b98:bf8a:b0b1:ef85%4]) with mapi id 15.21.0315.011; Fri, 14 Aug 2026
 11:24:45 +0000
Date: Fri, 14 Aug 2026 20:24:40 +0900
From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: Jesse Taube <jtaubepe@redhat.com>
Cc: linux-block@vger.kernel.org, linux-nvme@lists.infradead.org, 
	John Meneghini <jmeneghi@redhat.com>, Daniel Wagner <dwagner@suse.de>
Subject: Re: [PATCH blktests 0/2] Test multipath and marginal ports
Message-ID: <an75bRJc8J6NexeH@shinmob>
References: <20260812174503.3705830-1-jtaubepe@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260812174503.3705830-1-jtaubepe@redhat.com>
X-ClientProxiedBy: TY4PR01CA0098.jpnprd01.prod.outlook.com
 (2603:1096:405:37d::13) To SA1PR04MB10065.namprd04.prod.outlook.com
 (2603:10b6:806:4dd::14)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR04MB10065:EE_|PH0PR04MB8296:EE_
X-MS-Office365-Filtering-Correlation-Id: 9c6295af-0b89-4a3d-20b7-08def9f6a4cb
WDCIPOUTBOUND: EOP-TRUE
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|23010399003|1800799024|366016|376014|10067099003|11063799006|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	FIzP8Rfy9l384H0RehpAIG/X6d04uY2q6IjSefVVuN40N2IfCU7q1/K2E2mQgQe4qhnofarM+swrHLu7rLlD8g7rCYHruO/drcXnw0UNblrtYVPbOJUiBJT760/tNIeWJEIImikoBUv04Ks0ytUk5m5OP+7QZRJ3mNcTHupzJpS5/9diff6czibD1xDMlKf6qnOHB7lQGfPkkNYG0XxqNVCanXYr24GYhoSx9HlWooguVwKQMcbkC3wOg7vE93HergGfqvKH3GLjRWiq9sagd4WiugKGgVJ4Aex3HbRgCQcLhtObCJ5fLdectdVeOUEwco8mV6Mpfqhbwdn+6eR8yVpAoFwOKaxFX/6sOk1gDibgtmIclK4sfN/Jxo9YEC1VlGOza/j/VV+w/XiJVxPJ1YI0FAHqm0EGCUS+AmnfiyIgsc41kiXLZMsMnTdIb+FhcUEUFPiUJwIj+47SN0XSbFHHakFecPNjz5tfaspdmxEaQwAAuezTlkmWsXSqHW/b54fW/rloUf898l4BJlpNTiwbzW+NJ+GoF9e2XBlkv+7dqtEzgUx9tn3bA4aOZvtqr0smbHKhHuDWMSPneiO66fOqEkbBc98s6JMhq6ymXhaddCnq1r4oqnAwUf1HSiw+Lb6FmftMmYsjCwzK/NyLKO2vlte4laH7V6cb8nhggcA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR04MB10065.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(23010399003)(1800799024)(366016)(376014)(10067099003)(11063799006)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Q/uYb4qWSumPz/PuiuF3RpCcPyzxX0OfM/fO3U3YWqFwBWgB/+pZOXOZGlmh?=
 =?us-ascii?Q?rtRlzDeOwiBnNEawkFNQzAMJKCme0nBd6vnVh90zohkDl+dAyjSb3FL4IrfS?=
 =?us-ascii?Q?so6r6x4nWsHFIKiskr1PaMfpJHfMWBXe0aXDOSoBfrgrvLvESfYJIqT/HRMh?=
 =?us-ascii?Q?7yMMWYkZ+r4RaU/lhdxkXbP1t2n2zrYBTF/vcYBf2zoK4RueBz0ImD7UuyWN?=
 =?us-ascii?Q?UkXnAS2jZnN/0f4GYQCxxgQMSg+TCxQik/UBl1+Qdigl/s+MkZQkVA+hQ+8f?=
 =?us-ascii?Q?5we4vTkb9H1OxH/ma24sj8evcwNgrhLw2Sbv1BBbwmHBB3uX339IlsXu4SYV?=
 =?us-ascii?Q?AWOxWuIjGmgsjVhB7UD1vUfW+DOTzQQAiBk8OOZJ1TyVOj4NP3IU/TnUox+Z?=
 =?us-ascii?Q?AXv7PAU5Jvj/+2Z7BfkJWSiCSqGTG6DPhiqteOIx9+qDhkIJJaipyH4XxPsc?=
 =?us-ascii?Q?wafIx34LIZFS38C26+VsnMqLaXr2ziS2qU+BsfRc9r+92rt7XkhDHHNdwvDj?=
 =?us-ascii?Q?624lgDFbrAH43XjihBWUb9afzqq107sSGjkQNEboSiWqQmJ/vfdf2aNNNDmp?=
 =?us-ascii?Q?1zh+z2BjXxmNUMJ3COvMaoz1F74/MWY4Cvly23oxcmUkpshjpoSkbEXNNQ0g?=
 =?us-ascii?Q?OF5Cpq/Rm8RqS0JC75lNzAmdGk1V7WrLoln589Rb2RY+EGG44u4IFSnhghP4?=
 =?us-ascii?Q?Xd2KQt4hOoMQIdYZXUEEuDEIbODPoEdcG2qRlUvatwv/dTWD6w41QAN6AoAi?=
 =?us-ascii?Q?F9sciyixXKL6WBzDkdC9bKWLzssZXfzkg3h/b2mjUf8pfVFbLVJ5Bug45fk2?=
 =?us-ascii?Q?SdNPIys4AP5SP0AqqN540FicXCTGNS4Ec3sv3fWrJnzgOlOHiI38QR1n27nO?=
 =?us-ascii?Q?iHPyj89tPEmH/JG+GvNqqgwy0kPPb7L7X5++GU1/38xX3CkzBEaPG+Eyccx1?=
 =?us-ascii?Q?ZJvFqx3fEEjMS4nctDsUDn/CWRz95PTOEHpwAprUr9/RqBzEL1LuAC6BlXos?=
 =?us-ascii?Q?Gr/n66HWs7Vw6GHFyE3O64sRU1LmRsVAhehTeVybpD0Esp2a/xpne1bEAvkf?=
 =?us-ascii?Q?rkDiy4K203cn6YPQcS8M3Wfym0p6xyOOTLXUrRAHfyNufxzegluYHpRiRcLr?=
 =?us-ascii?Q?1AnnWsBTYUXz/PG8PgksBWGQJ5PMjJo5kZn3emYU4DxcumSrYXbGktCtP9xD?=
 =?us-ascii?Q?r8dHr9BBad/GTf2tCjy64dHGC6D64BiUHeW1ai5W1htnrJYbIm+C2Jq4ij0b?=
 =?us-ascii?Q?NuWzgmyGmNFqEc/pM7CU8BUeMF1UGyuT2bc+aZPsViTllMwOqcJZmrhRCYI1?=
 =?us-ascii?Q?OiPu/aOVkpijz1HqBnNi3sld/hhPaoHUaA90vsUV2KP3iZAste/5mso6nmSk?=
 =?us-ascii?Q?twV+51PrrdHfHLbm2hQIZVvdXTn0wMU4di690JuRBUEMY87j/vjuSNzv/Cb8?=
 =?us-ascii?Q?+FmIJoOuY+rttOfaSNfQ47rWhe56+Ht5i+gMcabdSMkDSzD+ro2AY4zW+7ut?=
 =?us-ascii?Q?hb1+8y4AtWViDAZLISXM+JCeu4Du3apycfIFKKSwD14cPJrOif2nLli9Sp3d?=
 =?us-ascii?Q?hDwudNMVPnhoEYdvrQYTCF9gGMAMpNKk/9pzADVl+xPMTwHWuXdR9BwDhxmO?=
 =?us-ascii?Q?yR70hPFPy9IBE4RMzAKyZlyrVn49DhhrGknYteXAREtEm0bvM989VeeUc1A8?=
 =?us-ascii?Q?ZZ+Y9W2FY+KgijPyy6FdsT2TWRKn/R0baVDY6tGVHr2xo+94cg/S05UexTzx?=
 =?us-ascii?Q?WVU1gV5yyiDhflJNjjBP9Svlqnob4Ls=3D?=
X-Exchange-RoutingPolicyChecked:
	AjqiCZTs5UL4q0wrrUbMLOlglb2FRDIYdPX1CCD7fhugdAsDmgU0/W60CBv/CaD+jfHla38pYaFdt5gpsUtTWVENw2xOKaRpabKzXAqCYak8OqV1JIaOq212j5p5NFThUx6YuDXH5f845zP9hYK0H3vENnxDVlaqvT/+6Z6B0QGDtHoP6Xvi5e+w/LcrqAQVUwFOR7F/2Bm3C/LEZ9/0wnZXfymdbnACh9YlXcZhe0YGqTw1kioaDg0ggUEptRnTDrmKJoz2Hp+kAN3SqOWJX0TR/ManbXq7zwkGGuwFINZFu1VS5xQ6nmz6s38jsq4KoDVVkMSt8grLvmKfCjweOw==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	soSo6ekNQu3FDIg//cqde//ugNF3oKR9UkTtmox+cMn5aewAMDMk+ZEjnzLyilR4+hNIrCg/HhLdXjxe+S6ftvC/KUNy6Z7PUX8imBqQflROORlkSjU4JfFBX85U9CvtCG6v1sMtn8LBswgj34U8E+7X3P25HIGD45SD5z5sTV1P02C8XR5lDYmSNbXqlLsrzIFz6KZlsaANqe4P7lpXJwJ57P0+YTtlFD2hvYLuEPKcU9CzoIS0TeDbpFqhVErlg8ieItbY8euXSEkRgkUc1Mh6JzE/LhZoKZbgG+6QVLnpvnv2Mro3hXFK1UFiGqRu4wOHD9RVtoVBhTKecY6JCnBFfuCW1VvH9lOy09q3ic2zIPOs82QvLvlhe7VSomq0i9T3n7VK5ykWWeRe2Qvmooe+olLvl41815S3cwDUIAbZZBRT+MnZOhXAYje3z/Ac0v32Mj6LfqfinDvKLcgxkoSUB02Wj8omAnIfM4G4QxTVFwUNy4Zp5z4OFBn00W9g0l5HpS7gKcnNY7mZfASvH1zqFNW89Y7Je8PtZ0HerNbKCecyy2yWvWuhfwWVgn9dkVS3c13a21gsOieVv9hR3tGJG95tj318fqxYy4kVWkkTBMewCFWmuQQ7vP5tuxd9
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c6295af-0b89-4a3d-20b7-08def9f6a4cb
X-MS-Exchange-CrossTenant-AuthSource: SA1PR04MB10065.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2026 11:24:45.6003
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8wb8PJuzyEntrN/eN5E5jUI/sessDRKo9onxi87cZv4uth9zhPib2iLk5T/RSOxKJrbJIJ8YNojudkf08zi4P0h72TBrdr+L0oTFlpuVc/w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR04MB8296

Hi Jesse, thanks for the patches.

On Aug 12, 2026 / 13:45, Jesse Taube wrote:
> Tests for the upcoming nvme-fc: FPIN link integrity handling set.

I assume that above refers to this kernel patch series.

  https://lore.kernel.org/linux-nvme/20260812181300.3712426-1-jtaubepe@redhat.com/

I applied the series on top of v7.2-rc7 kernel. Then I ran the test case added
by this blktests series and observed the failurea below:

nvme/070 (tr=fc) (test nvme-fc marginal path handling)       [failed]
    runtime  33.581s  ...  33.028s
    --- tests/nvme/070.out	2026-08-14 12:03:21.338000000 +0900
    +++ /home/shin/Blktests/blktests/results/nodev_tr_fc/nvme/070.out.bad	2026-08-14 20:17:04.731000000 +0900
    @@ -2,7 +2,8 @@
     Starting background I/O
     Testing iopolicy: numa
     Changing FC links to online
    -Set all online: pass
    +No FC ports are being used, expected atleast one in use when all are online in numa mode.
    +Set all online: fail
     One host marginal: pass
    ...
    (Run 'diff -u tests/nvme/070.out /home/shin/Blktests/blktests/results/nodev_tr_fc/nvme/070.out.bad' to see the entire diff)

Is this failure expected?

I will comment on each patch in line.
