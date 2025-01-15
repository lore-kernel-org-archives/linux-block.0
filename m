Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D272035952
	for <linux-block@vger.kernel.org>; Wed, 15 Jan 2025 01:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.153.144
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736904617; cv=fail; b=L5IfEDz85VmDEcvSmnqNYXVRwSFGu1HVZSsG7cf9hWOysHd2/xKk94nYtkHOB/VARJ5Q2QepnGa3DoyaxSQEgoiIvd8vDqIF2yhoVt2ZgQYzNakyOhouOIx47C9dGOzfMKjxAWwzP+XiHTjqWbUM0AzLSrzpuML1rVNRwQKizWM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736904617; c=relaxed/simple;
	bh=T3r+EyQWtHdyVUKGCpQa8nBwimVDnxnSs1+CW668A6Q=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=gPGRuOSJoT3DDZsH1hU+zfnJx3mTvOqC7VLPOUEq9q5QNNcXRR1doO7sfBZZm3KfIOtnojJp/tQBjaWggYmzy6gx8/u9uruyKiLSzBrnBTG6LNzwHJc6861iKOIwnJX7BCsh11eYQhbz3jMK8xzQugNQqd/8qOxVZFpezl4HIzY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=UMHX+uu2; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=FHKc874r; arc=fail smtp.client-ip=216.71.153.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="UMHX+uu2";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="FHKc874r"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1736904615; x=1768440615;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=T3r+EyQWtHdyVUKGCpQa8nBwimVDnxnSs1+CW668A6Q=;
  b=UMHX+uu2KNgl8YNQ52DLfBhcS09jzwFma1fj3g8Y32rMe8F6qHHIapzB
   chafihyS6RjBPJvNu5Ssd21xE9xddovFNCs59m3vFzszq2uQB1CpBcKSB
   j7bhAiKCGZ/N9w4MU9KMok+LIqz06h/gZSHQp2+U2RuO4taWYXxuEh7nY
   73XblK6JS93O4WZsFq2hQBMFVpm01iIILU37xOtskB8L3l9kMVko638Ip
   nP6d1Jev9bva/07SIH6Pecsk3/2fRqza7RamAaT4EhgEJq0uGBN9Gj05Z
   8XowaoLWPW2jCr0E/A+A3ZquklwDyY+ZVXKC7sR3wA2n9ilfvqsH5viCz
   A==;
X-CSE-ConnectionGUID: 2yCpBdvsTOOIVgX4LPSzNQ==
X-CSE-MsgGUID: 8oUQ/voCS3Gbolj3nDv3gg==
X-IronPort-AV: E=Sophos;i="6.12,315,1728921600"; 
   d="scan'208";a="36970694"
Received: from mail-bl0pr05cu006.outbound1701.protection.outlook.com (HELO BL0PR05CU006.outbound.protection.outlook.com) ([40.93.2.9])
  by ob1.hgst.iphmx.com with ESMTP; 15 Jan 2025 09:30:13 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wfCs7p5TH0PZo9NFj9EquOl99ect9vzMBnUZ6mW1WP/T6C0/WCAVZqJC9vbNtvwFCGk1dRtu6WeIlJubahtIFoi7E2PCYyPnhnBStyn6k0wizTZW7O+m1kNXL2T9GcrNVVHCfydcZk6qwRewNzuJ5aa40lyJf7HsMtgDyjnachkL3BiBfReZWNhL17uSYxvb/qy8pDbtQVxA5Jl+zeHdr/M+dL0PUIFiILfoxRPDggrrEGHATNOq8RteSeBPsm7lrVAU5acL9Yc20RMSPHcM/XEx76A6ick1P3j4RSl0bPXDm24zM3K5qZvWTeL/LW7EPH1lfjQoq1eRWd9/uAACJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VJl7oBvDusJEN25UsNlzfAfObuBZHuAt5HAatkMLo7U=;
 b=SvR4FKWB4hQpwc84mtjGzCh2HX4OJ+aIRsOTbFnZTXsZVWg6Ie5xUIrXD9X3drXwLh4gOFfAuiHIBznnqTQC8SWhLMhJwOO4xEzcAVRAY7NqoQy7B3vxYccgv1RJKWd4MYRATeFJ+g5otzN1q2gIbMY9IFd4A03g+bRKWX1HdfpbaJsMF0HyTPbBkD6A6cVYCGdWTda9aYI1sOHaZc1O2NXNIB0bb8B6rgXpZR65yGafQYllFXGWlHd0ZtK3KoMMKKnIZR9XVoPUwkfdqJiShVOT1fcrnCWvQHM4mIBcwm4LASEBEjuGRuBWn8QIaQcDnxfN7N9TgVRh1XdogRmZDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VJl7oBvDusJEN25UsNlzfAfObuBZHuAt5HAatkMLo7U=;
 b=FHKc874rUqDh2PKoJRa0UjYSqSgdNIsfNhNhe5ty0Ufh3A9gMAZ5UHmFtupEhmw5mpj1ygBOJEBVVlCoPt4rdyJFkwfUIGSC6+1Fg+iciHztLpgoPQNYfBdX5ACBZpN9YCU1e95GcLLamBk1gR23rz50eAEYgrjEc05hn+I8+yk=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 CH3PR04MB8904.namprd04.prod.outlook.com (2603:10b6:610:179::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.18; Wed, 15 Jan
 2025 01:30:12 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::b27f:cdfa:851:e89a]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::b27f:cdfa:851:e89a%5]) with mapi id 15.20.8335.017; Wed, 15 Jan 2025
 01:30:12 +0000
From: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: Bart Van Assche <bvanassche@acm.org>
CC: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>, Jens Axboe
	<axboe@kernel.dk>, Damien Le Moal <dlemoal@kernel.org>
Subject: Re: [PATCH for-next v2 1/4] null_blk: generate null_blk configfs
 features string
Thread-Topic: [PATCH for-next v2 1/4] null_blk: generate null_blk configfs
 features string
Thread-Index: AQHbYGPgycJCrX2bOkmyC8YKxcjEXrMXGUGA
Date: Wed, 15 Jan 2025 01:30:12 +0000
Message-ID: <asgvs65esq2x7mlrorbxccuc6tmzqpfaqvmzylooyr7ia6rano@x3kxdgt75ly6>
References: <20241225100949.930897-1-shinichiro.kawasaki@wdc.com>
 <20241225100949.930897-2-shinichiro.kawasaki@wdc.com>
 <75c395f1-606d-44c3-9fa7-434e056c03ac@acm.org>
In-Reply-To: <75c395f1-606d-44c3-9fa7-434e056c03ac@acm.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR04MB8037:EE_|CH3PR04MB8904:EE_
x-ms-office365-filtering-correlation-id: 7d5b7cb0-e8cc-4333-2a96-08dd350427e2
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?rAIUOrXrgL3jzamBVoi/leh0SV1/7AlIRD6lkapZqo5d0mYsmG/BYs/kIplz?=
 =?us-ascii?Q?AhvzhWS+Yl1BxKw8xqEtnAJ8plrMP7UCIxeHmefM12qTLNIlZv2sG/tptche?=
 =?us-ascii?Q?iDjgnuVAXJ1663xS6+CgsAQfrSDUcikA6KHhLPOssTCyeyDRORI2JLICzaGC?=
 =?us-ascii?Q?wSQ8Fll55p+tdc86Ue8jumuxpEo8Hr+sb8QBx3jMnilroY935/5ED5IH7kUk?=
 =?us-ascii?Q?7FO6Q/v8TG9HLDu2FlKBI1blqUS4/cURym8cdqb2Pbgh2xsndGYU48arrMoY?=
 =?us-ascii?Q?RaPZmx/jV9LghVU7lQl2PDYM0XZOnBcwc1ZtKKMrQVP1fKGFaAKCaDGq6fLi?=
 =?us-ascii?Q?eYnZq3AirKuzbDnFB0l2VHEgdYWZx2aePwjux5kGNEk+ElUZpp+3IbvXHTS6?=
 =?us-ascii?Q?2h4iwbwfFbWue/8hG4awaWkxg7Wx28OiKxNrLePKLgp814BJR9lgJVvu0wAR?=
 =?us-ascii?Q?JFOFKY5ZbbYV/p9KEXh+lVFrPcHcvXPrTSTI+iO/tUA35aZSWRQIRleBWxNE?=
 =?us-ascii?Q?lMN0ImK62JBy7ws/s9SIW0IKrzsGljLtRIXrMdzDgeWD3Kzp0Ra8e3HkhRae?=
 =?us-ascii?Q?aKPMyCAGBmtWY1yhm/75+kGgW5GkaK+bdlQZZ6OfFGB/Wl8iWoGEiZUIgo/x?=
 =?us-ascii?Q?8xbO+sgmon7HNe3JrU+ox6mm9FkhShfD+1vVFfuWWOHCQS2h3sFgUv4S2NUV?=
 =?us-ascii?Q?h+Ov7v8lH12FDEEedVllkszOmt2E90SRxjFlJbXYneNY+bZKNQP5+2ZFhq4G?=
 =?us-ascii?Q?8rXSAsbnVsV/ijjkniBNm5GvSWpzW3KrvITbmBZWKeI6dHhvUlPGykGbdFmk?=
 =?us-ascii?Q?IbE1QWnufDJndo+G/aGvUC35EuaRm/pHw7aYXgzZaCuPncm5n9mSO8Hxn4kw?=
 =?us-ascii?Q?lv/gr4l0z8UTVcUONVVXy+aZGY3YgPjHA92V7eauCmiYz2z6RErQ17ovfj5U?=
 =?us-ascii?Q?8qV40fvK/0GehHFpyNvKmMZf1wooR9HXH5c5CeJHN4nu/5xk7GgU+7nD00Jx?=
 =?us-ascii?Q?Vzp5bUX723KUkq2SZnvQ/jgYYEch7J0jegAhMquyozo+jKWckpVY/D6LEq7I?=
 =?us-ascii?Q?KHvhR09CGDAimwr0uQ0I66G0apfvywYrLmSHexp55KnML4wqMx36+tjzgJTc?=
 =?us-ascii?Q?tFyGcdjsgvcSPIjY0jxNUBkzStcgIBN5FS/HluPUAJ1wEmPzxHab3sdaYHPx?=
 =?us-ascii?Q?3mjEbKhKnwdT1Bm9/DgVOk37OvMY7lOzV5DWvIvxxidCdE+uwyx3q57iek7/?=
 =?us-ascii?Q?vQdGgfmcieOfxUpBWgdm7u7r7kUyU2AUkf+J8ua4pM+idXlNG31rzgM2tfwr?=
 =?us-ascii?Q?+OOFNWRwQ+GwTTBIpjpz08elrkfBBJ+7/b9p0Cex5MT+crBrIGPYfxcCK5p7?=
 =?us-ascii?Q?fBfYC1fcJ9Ac+zZIVFd57fzWGOIxF5c83x9dlX1e9ivbiDYRsHIrpOGqiDQC?=
 =?us-ascii?Q?aX05OXTb4/6awrgD0J/sxG1XFgc/9K0M?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?m0q1JZy/ABVMcpp1HU6Q/so3aMVN7vLtA7EensKyV3uuKQGxODYXiJDlgL11?=
 =?us-ascii?Q?11iCQrBvSMTO+O5luyifDovE3rN+Qm5VoKfHPf7pNN7LjsB+X8OEbA2vobuO?=
 =?us-ascii?Q?ryR86ODf31FyhqfncQ8b5JBLW8bGnuYTgvwxTqnfbbUWNP5wgsDdqZslTe5S?=
 =?us-ascii?Q?p9nnlwctwphjCSSCbd7xzVheNdBJZf89JoCbzaokm1rEJhO+GXWd1ObJtAW4?=
 =?us-ascii?Q?4kEKNxGiESsuF2X19Ro4f6HgP4k2k6LAdzMHKJJ8AHk+Nf0FDY1p3/qeUOzo?=
 =?us-ascii?Q?yZieuIbD9VhwYpElqrXcU7Yqej2ndAke4Dl6cJjnzHq48UvWPyfSHAZrWSpw?=
 =?us-ascii?Q?ICEhwVCtAGsSM95G37PFd/Gh6rRIslBaE13YWvk0dHbBawVKEXmMdE6re63X?=
 =?us-ascii?Q?anVg4E/j4Hbb08DouWfX4+dcEE4STM+r28q6QUvJfScWKz9mqmvlWKO0Dwkw?=
 =?us-ascii?Q?CfoYV5IUUd0fJp1qy9HFI1K7qf6t9sXWq38xyRoX9rR9L52kgYr+wd/Rlvon?=
 =?us-ascii?Q?cdddZj5pE1K3X5J5pwTv+EgAy0KsL4QkqdagrYmQm2iz2umJrAYDIh+l6dH9?=
 =?us-ascii?Q?1R5i5oWaA4oHu3ST3LVLIwz4mG4bvMiiVuXCIsjGdRp4p2dMLw5xPyEB58Ej?=
 =?us-ascii?Q?4rswmwSSxI8MncSOvWnxtjY8ePSV8LIO0K6PUSAikHQpTdqyLkvZLF8c6sfq?=
 =?us-ascii?Q?CiagWHDpX4Y63z57wLwKW8+mmCms/v5H3CjKjOWBY/ehVRiM/wdH2xIBhrVs?=
 =?us-ascii?Q?TFTJzaloBrlsUTkLTRbw5xOR5uDJXAHJI5xIzt1JInuN+fqVGHpcEQJvBJuP?=
 =?us-ascii?Q?s2rftbYWR6rtGxnTGukMi/f+2k9LnGOi1H5+X+1vFLXWHj8MRLeCaMAz6lcD?=
 =?us-ascii?Q?NaO021MP3lo2QOJHyFx27BskvCc2jlosFDB9ghEuO3kzwvjamObmov4JDjTU?=
 =?us-ascii?Q?9zAI0Hg86K8bxRymHS2uavMECY8AYFMdgmDqjKbfz/0aLUTi7EJX/xdG7C9u?=
 =?us-ascii?Q?r7AL+v4NLctoUUXlnNvLh71AIwocXBUAugujqy9QD8g6OgLIwgDt6ok6xkkb?=
 =?us-ascii?Q?W4mUuEdvBYMudzFEFjamc5WccZ2LDrl2VS10YXr8MToC9xmEDq6ev/hQFEqU?=
 =?us-ascii?Q?Qy8+Y0VLk3NHQJhxCT42apQeQOwBisrJNbe4UptN8ESbsR0GLZz0ABmlP8+Z?=
 =?us-ascii?Q?mAqul1WkOBVawabdH3/lRBl++OfbvsTg99u3AL7XksP9PYX34dmiZphtTOYt?=
 =?us-ascii?Q?LcNjTsuWNjdpPEUdoSnntsBD9fXKKJ6QQbEhoLVsggs8CGzslliX7bWg9tFC?=
 =?us-ascii?Q?cgPMstIBdzBwnqOMrrbk+Sdk5EEZq4IUxRVALMV1QWo0mjPxGAC4VtpQwzpv?=
 =?us-ascii?Q?m8BdNj1OpJ1XejDc06UsSsS8tZOxXpkSAJcMKMqEcIjXRL0NCgFsBCvdsxph?=
 =?us-ascii?Q?IfBfe9MTmC810R84WEEF+SRguXOhD7H//auURPCsGxB3yzAFVMfGn+NFchjp?=
 =?us-ascii?Q?lEp/Zh+ZM/VIjwA16oA7L+3VNtJekbCFAEtSS88GVL78kdLaWlgWAOELYciB?=
 =?us-ascii?Q?B7MDRcyK+KlB4QwcDbA+/mQfp7f3p39c0NvgVCk14klEW7UiPKh201sXXzhj?=
 =?us-ascii?Q?VAV0OOyvXJednaEuwdbTgBg=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <8E1A66399AFBE347A4B2A8A9DBA78F8F@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	dRsvDpy/Z4t3uUVlELWDHCMEnpbz6ysXk9GXbg5s0YvmVMqmt/Ti9wYufgUSuzEEhBOEQnAGdr18gmFavN+kAPyvaqmyvOrvHY7XRl4jAUR8xifCwoIy2aEZYDsv+P1blA1MZjKPdSx6x2Ej++E4/jFq8+NgsQh1re4Cldxko7s41ASUGj1e2IL0BwIsEYodxDf2PK1aPf5JGK/cYGjvmOdP5tdsklKL7lUB8rgNo8N0rvsjtnXP9y7bwdQq5ltUCZpEX7wObLfyXK1ev9fSNPcYw0Fd8rElRLaoNp0dcT6PJpiLGjxi3Zei6bm4ZnBk+8dguLW3RxVeu9v0/5oKLa9zh0bNjRVNF4TfgwytDR7laZWp9faB36OGuGLhSxWQOApfiRtIt/c8xBIRISmDUUbUuH/O9fKG7R2WdTbtVC2HYUStxzF1NQ6mxvjZ7Q1bwrYQRwvYY2D39NaPsaRf5Xfx5aDVQkS6O3J1e7V3vUEag9grC6bnZ/GoHUHqAXYVrHy61Uxe9sLxtuI9NpqfxRT8CC7eWjV96K09TJD+xLr05CZRLnre2nKZ84Ebz8dBsZGnoY7l4bkwBIwUWfyBbGlFopIMa2DWpWWwdKIaIRDX/GpiF9SJ1/C5Yum4wDB2
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d5b7cb0-e8cc-4333-2a96-08dd350427e2
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jan 2025 01:30:12.1204
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: m9sQQtOJIcuDInihctbXvJsyI4b0S/1MVSTEimBqRRO8G+fLpctgsqCzppEjKGHbjwBQnY65s4Us+ccmMTt6g/SOAPF86ikjoElKfmb0rJs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR04MB8904

On Jan 06, 2025 / 09:53, Bart Van Assche wrote:
> On 12/25/24 2:09 AM, Shin'ichiro Kawasaki wrote:
> > Also, modify order of the
> > nullb_device_attrs table to not change the list order of the generated
> > string.
>=20
> No software should depend on the order of the names of the attributes in
> the help text, isn't it? Mentioning that the order has been changed into
> alphabetical order may be sufficient.

Thanks, refelcted to v3.

>=20
> > +/*
> > + * Place the elements in alphabetical order to keep the confingfs
> > + * 'features' string readable.
> > + */
>=20
> confingfs -> configfs
>=20
> Thank you for having sorted this list in alphabetical order.
>=20
> Additionally, I don't think that a reference to the 'features' string is
> necessary here. It is a common practice in Linux kernel code to keeps
> list of things sorted if the order doesn't matter.

Thanks. Now I think the block comment is not meaningful, so I removed it in=
 v3.

>=20
> > +		if (!*(entry + 1))
> > +			fmt =3D "%s\n";
> > +		ret =3D snprintf(page + written, left, fmt, (*entry)->ca_name);
>=20
> Compilers do not support checking the format specifiers if the format
> specification is not constant. Please make the format specification
> constant, e.g. "%s%c" instead of fmt.

Good idea. Reflected to v3. Thanks!
