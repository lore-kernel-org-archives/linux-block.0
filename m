Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9ABA3812DE
	for <linux-block@vger.kernel.org>; Sun, 30 Aug 2026 08:57:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.153.141
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788080267; cv=fail; b=UGAZsmod08eorwBHXx1kg3SABGJURzkP7vB2740izlk0CFgXIRWToG2zuPQcFmxb4pxoMYwSFJJbo7cl4ScvwKoHrOIClKu6GnBKhgbVif9gW5BeULPUkryh0fy6xL9Uspr6war4m4ys5jv61NVotgrd4MsLbr62JSlBn+pV9CY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788080267; c=relaxed/simple;
	bh=Cng0jLdRDR5YNbr7a8Z5I9rGvVNGmM15Pn4ZCl/PC30=;
	h=Date:From:To:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=WFjxBaD9gPkORgbZ0ov0OyaoJqY3oDNVNpKklzW3JSjLQjZ0uD2tFvxS758JLdTTEI72Gpi/5BrTuYvj097XofgqLOTH98ylmEY1hDjM9J1kN0ENIF+i9MrkECC1sdijhQdJZiGdXWfoh2SE48Vdqcsc8FSMDMhvz5xMFD4W4uk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=Ypw4ih1Y; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=0QxZg62o; arc=fail smtp.client-ip=216.71.153.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="Ypw4ih1Y";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="0QxZg62o"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1788080266; x=1819616266;
  h=date:from:to:subject:message-id:references:in-reply-to:
   mime-version;
  bh=Cng0jLdRDR5YNbr7a8Z5I9rGvVNGmM15Pn4ZCl/PC30=;
  b=Ypw4ih1Y8NFDpmfvc0zpPhJxGczMyJvpTvh8bBf3Y84jZq6nmaWPAF3k
   UU5HVHX0lm9V9cl1S8n2Se3gso8MjA5FaAo3mAmx8FFQen9X/6rX8YInG
   wolNYLFHR74pCAXDMjx5/yS+/l471VYkqGKrKkp+COKFkG7dtcOy/trOE
   MpTZY9orLqXd5aZiBDmJ1a0pmf6Ov2w9LI3XWkuLu4T3NqEmliBc3o9PP
   bfC86TPXuszcfQq4Iog3x9R3nnAeH9RyAPyeifW0XkB4EBgZrrUIuSDmC
   L+Ex/+Rvd9C5Fmc3IfvNTEb3un4oG/81mDDhQWk4TUYlgy9eiMJF/3EwC
   Q==;
X-CSE-ConnectionGUID: phooTsM0QnCed2dTNGyGOA==
X-CSE-MsgGUID: WJQAV3kpRY+Lp7k2a02h1g==
X-IronPort-AV: E=Sophos;i="6.25,251,1779120000"; 
   d="scan'208";a="154557015"
Received: from mail-northcentralusazon11013041.outbound.protection.outlook.com (HELO CH4PR04CU002.outbound.protection.outlook.com) ([40.107.201.41])
  by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 30 Aug 2026 16:57:39 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=A+R9H6W8Ye1qNXUkItWscjbKXURQUmFy3irc2YCEoYczms0pSHqJqd5xLEIVeoKfos8gbP9sluJHnNDnlNrvUu/R5W/GMPGbI/BhK5Pke76nIzFD+dz7KUERHp7frD18RW4d9agpssgw3yZHikItlrodXLMGbsUXwOzwdMZ1SDPisYp54JR4EOZcC59HVXtUKpmENXsTAW2RPgkv/AlX5H08pAMqo580pKk6PsgjTKZgZIHSi4OJmyZRxZadjK0Am3UR9KIJ399iibBAQCNQgSg+DrJulNHQe3pHY4lA5Gq/X4HPzRqkej5mGCH5OCDMtk4BBjX/O+wrzuci1Jd+xw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6GGc7ZkqraGWtKkjRfqYuWM5HzSmrXfbxxf02UROKRQ=;
 b=scTSUbYPzoPtmLZVwTqfRk2aL+I7fqdHcTTJiwGK0PSCvyPBVFCYm4aCYXPioIqw/Q1+oLNGyB6lXdcFhZ6391imhlZfZFboaUfZF5eCeLDg9aKd5KmASLIU4fOyy8LTTmng13b88IkHICmgAS9D/ugfbo1cKK9WWx3Ovms4o3OTMN7Y5HXCDjHgW/kuDqhaNr4RbxyAJI3w+f+b9KiXLinb5V3E2YOZsJpwQbyQrQRFF5AFnERDAgqIEGxXv1baq28tYdrep9xjiDkFMV/z/a1Vz0uY5b7vF3SjH8kqUl7imruCxI6wEpyslYIgq8vwqlRT9tO7/yJ1JzJ/Lndxww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6GGc7ZkqraGWtKkjRfqYuWM5HzSmrXfbxxf02UROKRQ=;
 b=0QxZg62owF+EutOc2zXx/LNjeTUWf84up/XnT8hnZavf/QKK7n+IZThA7PW8SA0ZpAFiKNneNj5ejd5jzWjkedLQkAmarmNHLdDLLV07+lf8QJ6YNaNGplUrD9tIli8GpW9OAhgqvsQOhI8fGUpi4qIHvkcVr0QajCg87lR5Ey8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
Received: from SA1PR04MB10065.namprd04.prod.outlook.com
 (2603:10b6:806:4dd::14) by SA6PR04MB9541.namprd04.prod.outlook.com
 (2603:10b6:806:430::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Sun, 30 Aug
 2026 08:57:35 +0000
Received: from SA1PR04MB10065.namprd04.prod.outlook.com
 ([fe80::9b98:bf8a:b0b1:ef85]) by SA1PR04MB10065.namprd04.prod.outlook.com
 ([fe80::9b98:bf8a:b0b1:ef85%4]) with mapi id 15.21.0360.008; Sun, 30 Aug 2026
 08:57:35 +0000
Date: Sun, 30 Aug 2026 17:57:30 +0900
From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: linux-block@vger.kernel.org, Ming Lei <tom.leiming@gmail.com>
Subject: Re: [PATCH blktests] block/040: relicense from GPL-2.0 to GPL-3.0+
Message-ID: <apPv0K4N9t8PsBXY@shinhome>
References: <20260821105419.794516-1-shinichiro.kawasaki@wdc.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260821105419.794516-1-shinichiro.kawasaki@wdc.com>
X-ClientProxiedBy: TYCPR01CA0155.jpnprd01.prod.outlook.com
 (2603:1096:400:2b1::17) To SA1PR04MB10065.namprd04.prod.outlook.com
 (2603:10b6:806:4dd::14)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR04MB10065:EE_|SA6PR04MB9541:EE_
X-MS-Office365-Filtering-Correlation-Id: a42762c6-35f3-4c20-a2a6-08df0674bc21
WDCIPOUTBOUND: EOP-TRUE
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|19092799006|23010399003|376014|18002099003|22082099003|56012099006|4133799003|3023799007|11063799006|10067099003;
X-Microsoft-Antispam-Message-Info:
	ym9S533aBHJTwJpabnHumTHnGKHEvoJkmoRN81EvNnmGXyM7euwYZngpHWC1QLIqfUQlXSnu3T7pS1tO03UkiVwwBph9DbzWAHZFz/aLnsOw5aeO2blNR+VxmuWEeZlZPlbdY8BRdNAl2tFYPahcwzmTYm34AHyo7N6R3VqHngxqILvVpCWOnii6163u2CrVbQWGgU0uUwGRa1bft9/as/J1XGxfFLn39ooppepxEpWqzPl3irntaUCvbZYgUV1xHW8xVTkE2FFOAa8l2uv2e9yJFRn97XOV35zODKfMBv6X7h9u1zp7b3rEemkQhgJ/lCE957cqKDhNA99f9SKEtMRKiV5uc/3b1eSze/+Clu4ejI4HAZqAJNlMDOFcXLI2Kw+PvRuJnvJxQBqTXhFEofupvZ+auvETZxYjOqW5Ob/ep72O6X46FIqHxFHnIxuojX9ifLzLk0FSxIJiEsON2t9aTKyP8Jh98zugyMGM02rK1r2F9VXTg6xci2BnNv4UoW5QEnXOmbjykSliIz4IsUAzoJ9PZ0jpBrejtbDO/AVurN2x7BcefS/ZAz9J0rhp2vTw2kpcy3VypDmfwlCgQ31F/rcZf/M3D0eY/mN7jLqGGWe5kFYnjjM/OcPZ2gIyTCXds9xzlRkxNHDAKDYZL3/QuuD5gnwr+qk5Hp7dw0c=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR04MB10065.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(19092799006)(23010399003)(376014)(18002099003)(22082099003)(56012099006)(4133799003)(3023799007)(11063799006)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?IP+iIs/1zwh5foMXxyrYcbDCQiVAZCFYYKofpe84Tk9ogBFg5gomc89MzC3L?=
 =?us-ascii?Q?+hdzdwMfzWJN+rKQPDh4Iu9CVbMnvGgkw+4fViGGU4nG3Ng/8AwU1lxkN2FG?=
 =?us-ascii?Q?D3jnUBkGfHbrCXLgEZBUo/fw9Qj/gP2NTUTCgj8CUW2unIVEEtujW9ZbruC+?=
 =?us-ascii?Q?6hERtQ6Ye9acZ7SiBt0ZeNuZOfKRTaGtV5Kk426b79uWHAXDTGLRXytBCiSj?=
 =?us-ascii?Q?0dGpn69TYcY6dIdSeApEFNKbVfaeERzcRKGkPwRd5ZKOozlPsRIWiu7kwcW8?=
 =?us-ascii?Q?4Gm8fB5EnF5lEX3RiwVOR0eNl9x5OpWOJCU4PSXZk2rl7ipFjZ1U5UcC8XPe?=
 =?us-ascii?Q?5b74lfmjAOG+4mvZy05YBzIN8AKXnTYOUepK3sJBMPttJcprWtvo0r/HAiM+?=
 =?us-ascii?Q?KFwXtugcPIDHYV9hdExDMtIWdfyojtdL2Xg/F96Q2br1SqiUYo9gk8ztFIes?=
 =?us-ascii?Q?bUL9REi+LKhmExPQ4rEuD2gYfq+h1TERaafF2eHf3S1cxUhKPnVFJ1vDRJSe?=
 =?us-ascii?Q?zEPOdlNdiTA7wcHfYLGH5BaXApIdLZOxcQ5GduBvZfGy8gKj25lrJh+hNzvl?=
 =?us-ascii?Q?Lf25VX+ydLfvz7ub72sXIlG2BQWae+Cp8C5I5uTI8Zx0QcmqrP10/Pa42YwD?=
 =?us-ascii?Q?A9DS0D1XrgDW7icRBIPdVbaX1ojYxVitQW7oB8FRP53RRWPz8XS6VZutJ2GF?=
 =?us-ascii?Q?VptZuBRo3JDhm2NMYVqoQhPd144JVSTC8vDqMUWkZap1Qak+hPobTET1f1A+?=
 =?us-ascii?Q?bibJX8VvLGbUz+OBomdz/F2g6+sc47pRaIEP2VvXx1amerSFb4HUmDlysDnh?=
 =?us-ascii?Q?c4W16RXk7VRWLceY77M7C4fAHUToBadf6/AOi6I68t19tWmggUibp9j5Ujbj?=
 =?us-ascii?Q?r9g3gWb/JcE+pAhRi/B28SIjIhwKpae2xdToBLkuBP/fjy1zyA/q1VztVFvh?=
 =?us-ascii?Q?r3vkX3fPJN924OG65In/0aLwuMDDS0T196WVYDHO1ysodNuOKIJtBAb4GtiS?=
 =?us-ascii?Q?GGIKSXF9ke2a6cEEK3vLzYNm9Agn7ZDQgyN1dgZvUXNRY1YbURbU07Si2KvM?=
 =?us-ascii?Q?K5NCptvjkVjAzwvoZinDtCJIK4No8I0lYVvbi/hBfA3CZuT33Qrjj7fleDuo?=
 =?us-ascii?Q?cXPjptp98uQcTkAfqoZc4I+YEIwwird86vVrVeZMK6L5dssNn3Gnacc/7b79?=
 =?us-ascii?Q?THu87+9xE76lnz+iBfCipk24c1lNn+iEkfsclepKfiUrqfgK5bmqrKHZnoFM?=
 =?us-ascii?Q?jiCPQlrVhiD71BilCSD0VIdgwwlVQJLgfQwOgNMbAPCBJMMDvOyOOk/T4BOp?=
 =?us-ascii?Q?7P9ltlHzj6/lW5TPYEZFkBJ6xym1hHI8pPVUI2J9v+LRKYWvVexw4Fofwb3u?=
 =?us-ascii?Q?WXbNtOhniyi9mDaapc6w3xF3kTtNYzle+SKhdtbeDgIDgLwgTyQiGucfIRZy?=
 =?us-ascii?Q?9Br/3qn6Tjab6RLWGDYaQwv8Qzlpp/pZvD61FP3P1SGR7ssPeGa9IYyM+TMg?=
 =?us-ascii?Q?+gl7yJXbbCcw9qB8W42BjHO614xlVyZwSt7jpzskQFVOCXNxKx3KCv6YCa2G?=
 =?us-ascii?Q?0KVkZBdZlxt91c7s0+bZ8OYj4mNl/4nxEPOW4WVThzvWt8JQiUelehR3ArBq?=
 =?us-ascii?Q?hHo7WjszNvvBIa0VNd85AMXbSAjGhBy+V2gfuquCZ8BZ16p2x7REjQChR2Jz?=
 =?us-ascii?Q?eTHp4+fnFugnelSVx1MDTLe+Rthwahtt3pI3Ebj5B+46TGyqI7g9frG3pje2?=
 =?us-ascii?Q?UuTlqaMa7+Hl9N62xRsrryS9R+Y4xWg=3D?=
X-Exchange-RoutingPolicyChecked:
	hxwBTY/W4rNqxtYJwZ3vQCV3Q2U5WYLgmNcctCPvqxWBAFnkmIgfL2BMUvcrZuco+NPXr0yXq/tkr9btNG5I7km8Cm9E4x2K0VRWLLL4SOrosY8GWD/K0FyhQzWNpkZARgweixX5k/V1P3fnxF86rLEbX0Rr8Nfu1fw5HqCzM8uKcddC4K1ikVi+5O9B876kCPN7TTlUXUWVfP4lXH+TiU7uyfSmb7xxW1k1cX0AhrXbNI1C2RkMRLNEMfn5uwBM8jqEo/6dSs7vPEw4cz40RFyyal7dIIjkqt/t/XnfJR8oGvakfYbt+xhYwHvu7tNEwwM3egC9/MqKMNJbdP5sCA==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	nzWFYdEliXtxB+MbFN0BHlkdlkVrLChImysEOhFfCxO9+VFAPgATP7W0AZw77mHa9qiwpXcMcis9SYZAbcAdXqgZ3HvTNgCrgT2lp0iQu+AijhaneCpyNiEDKRbqdciXXul1JpBf+56yoX9QbB+yg8jRUjJF35lBH9SJe+d1AZJtODmZa4SJHhDVbcqxyIs/1u/v0iT6xDD3QaqwtJ2nXyQh1GLjJ9TIottdWvhZuNSmy7TNsFEhqFHbV7M0128YIj6HbKXOfiBfUiKEWIRMmcKn7bIoT720zE1H5uihGbOqJDzZJsFYioptFuvMsZgHHsGLGFlrVvwBkrdnz21V7LtlG3O2B+09dqCQjrw17Qdy0obE2VKShY3fQQjMAuhEnAa6osvjjtLITiVY8opTWVdsU7s1Ud1pRU4/vJVElekt6WN15pve+yHQBtNFow4UCm6hrprWIkpKCOOVGxRjNfoEfiywjQQmGMt6U4W/C9BL77DYP5gLHqwdXP1CBXwEwoZSH0itI4UCHGZ0j0/mR0UX8RYOnRbCiIOhSVNC/D3FumJhC1/q0XDcAyiXWKVPz9N8pGuwyhupxKi3bAPeKgRdcSN0LMoKKUDWPy0lykOeR9SxZUNCwuf0AS4sXGvo
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a42762c6-35f3-4c20-a2a6-08df0674bc21
X-MS-Exchange-CrossTenant-AuthSource: SA1PR04MB10065.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Aug 2026 08:57:35.3214
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jeXNA2L1ggNm6XGwcKgz92pdGcM8UN3surCB8YI4675liKEYgtPd1wwZX+ixRxb+A4Y84RUW+Dj+YgjEBGE+fKRop7/2OsLRBljSJfPus18=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA6PR04MB9541

On Aug 21, 2026 / 19:54, Shin'ichiro Kawasaki wrote:
> Most blktests code, including check and common/rc, is licensed under
> GPL-3.0+. However, tests/block/040 is licensed under GPL-2.0 only. This
> test script sources GPL-3.0+ shell code, but GPL-2.0-only code is
> incompatible with GPL-3.0 code [1].
> 
> Relicense this test script under GPL-3.0 or later to resolve this
> incompatibility. The script file was authored by Ming Lei, and he agreed
> to the relicensing [2]. Shin'ichiro Kawasaki subsequently modified the
> test and also agrees to the relicensing.

Ming, thanks for your acked-by tag. I applied the patch.

> 
> [1] https://www.gnu.org/licenses/gpl-faq.html#v2v3Compatibility
> [2] https://lore.kernel.org/linux-block/CACVXFVMio4pcYVrnd6LzYffymFUOLsSY6Oo3C31Yzb7sEcOGAQ@mail.gmail.com/

While at it, I replaced the link above with the URL that Ming provided the
Acked-by tag:

     https://lore.kernel.org/linux-block/CACVXFVMWCbvZHte0MpfHo06jWKqd-nhQ91-Hf=pCxNnpxW+x+g@mail.gmail.com/
