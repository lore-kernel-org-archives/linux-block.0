Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=216.71.153.141
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793075164;
	b=ap3MSz9uipYvcxE4DzcY2wMXYqyuh5eIr7FPODyC/ZKd5Jj6xx6Y8xwG1N0jf7iY99bZ
	 nz5A14pvOQkIQbwgrx+Xf5AlwRMdacT2mUWbPfkZIZatgclMoGCp0fgF4fSd3buPxoK7I
	 0rnG2DKpM8D4GVzyTlJ/FLp7u6La1leWK8jiKcY3nDIa+XD8AGSTzdi68AtlwNEwB6Tqa
	 qTZdgAxHkcoL0KLz7/v4kBjgJiDHx4G6K3RTYaAkg4Y/4vPgAFIi/l8DaN9aXVx4/v5lg
	 52EYysOfmYWGQRgf2OcZquhadUndai+slyBLQ6ts/MGoXkD8U4PHhgBJzpPLHmXa5Mw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793075164;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:Received:DKIM-Signature:Received:Received:Date:From:To:
	 Cc:Subject:Message-ID:References:Content-Type:Content-Disposition:
	 In-Reply-To:X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 WDCIPOUTBOUND:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-Exchange-RoutingPolicyChecked:
	 X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=6buVcb0ySjD3VGLhUXzcY5PdHfXddCaHVeqwtYm8Vt0=;
	b=1S85QoDweMRpgcmiiBgj1rMmoD20Dq5lqbrgJwqnk7vK3jQWVfHAS+0g2VqL+puRY1zc
	 XJuduRaMfhy46SFwajJ4w35ZVsUFW4GsqpaZWdGD+TKK9dnGvFCTkQaguP7sd/I97eqA4
	 6rIg9fsVyiFt2t61HE9ZfkzkqJO+PSCdzedJKV77if96/AxtiN2yyG4IUARuDOCY2XbaB
	 rHlMySzZp68IM6H1V0fWVZ7nfGfJlFO5+x1R+dBH7BhgQijnIyS0eq57IHwz6A1Mk401U
	 XZSMtYdeKgyNhW7HlR8xd9pqyuGBj7lkFHblUwFkuVgcTYqajNYsv8rFADOD3IUr+lw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=wdc.com;
	spf=pass smtp.mailfrom=wdc.com;
	dkim=pass header.d=wdc.com header.i=@wdc.com header.a=rsa-sha256 header.s=dkim.wdc.com header.b=UKeVWmSE;
	dkim=pass header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-sharedspace-onmicrosoft-com header.b=FXFPEH9A;
	arc=pass header.oldest-pass=0 smtp.remote-ip=216.71.153.141
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27DF9606A31A
	for <linux-block@vger.kernel.org>; Tue, 27 Oct 2026 04:26:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 27DF9606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=wdc.com header.i=@wdc.com header.a=rsa-sha256 header.s=dkim.wdc.com header.b=UKeVWmSE;
	dkim=pass (1024-bit key, unprotected) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-sharedspace-onmicrosoft-com header.b=FXFPEH9A
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1793075163; x=1824611163;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=IOc5QNmq0fsax/Aadq8pZLN0cA5KPDETXiWqQfTCA/M=;
  b=UKeVWmSEuj5ENT6C7TUKpb3CPhsOWeSsxo3BOwFXQodzV4tSMWr9R1Ix
   ONVCdQrRDt+3WYnYGX/6c4QgRwB1bPziky39hRAzXz0T3IwokOpKzbuY4
   Nxchm2lv9eGyMnNn0lIHqsgphCAgU3i6iwEIPziH8h8oY0T9ePIk7rHfy
   EfOdhYn4qMN9vn/ovzdAV1VZVOSHrb2VuUxoUiLjx7UaF4ISm4Ko1GJxX
   jMSUj1cJWJejeBWWpY6FuL+eKaDwMvZtFAwOIsw4rZg7mQ5usE5mib7nC
   HAMaP7YtpqkCnj7mhvcZTx1I+Tc7Ho6DsvoqTBuJm07T1+31sWUw4rDot
   Q==;
X-CSE-ConnectionGUID: bJp1399kSpKrUv7WHL6gbw==
X-CSE-MsgGUID: JaD71WkKS6mjRBTHhlWnFA==
X-IronPort-AV: E=Sophos;i="6.27,180,1786982400"; 
   d="scan'208";a="159081000"
Received: from mail-southcentralusazon11012023.outbound.protection.outlook.com (HELO SN4PR2101CU001.outbound.protection.outlook.com) ([40.93.195.23])
  by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 27 Oct 2026 12:26:02 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CDsFV4ne6mizYtP3t0YaPBFU1EuwpVbkwvY/+zbQwVy+Igk6Iy0NXlMwSIq4lpd3Ut5wBac6RTJDS4EkzODVTzxtBO1izUWTcz0uB+J+bXT+BJSpGnn/uPtu8uK2ZC8pPYXR9lKN6gvoC2GQQdC+nbPrAnL82ykyKux2RTLKwg/Ih5z3pPW6doZK8MrH76mQLUItWqPQXyT0v3uP67PQACDP9xR2h/JGMnPxlV5CbR6Te7M8QQOii/pT/lwWcVRTwM8HmZHhggq2qKkzVyVF7Bm3qdv1ODAF/IIWddcHCnF3Fj2XkW+mn6R0JakCy1Q5K+BvRlO6aNwfc75GgSzV5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6buVcb0ySjD3VGLhUXzcY5PdHfXddCaHVeqwtYm8Vt0=;
 b=uSsajZQ8hq7dPz39AnW4nG8ar0UQ23TYJAB3lHs3xDMYYble8jRnnzgzvreVC6jpTz9Rg3kDct6pq9JD0nXrBEdijhTj1cKeVD6g2U0w37fSFtg/d+LoI53dyC7ZNJoHJ8lDHbwjnsQv5576iRAiXHOduHvs6cIEOhnNBvmjfVMQHTBtOqifXliZGeCQhDWwOowSjE6xe7sejPpUw2a555FK9OaIZtPpNi1DmZGGuKGLl1pevSxPAiAG6vMf0YFWhXy+jBueGCO4QT5TFJAwUSIRGDm41vJXNReddsnXlEzj65xWxj3bv9WnUOyKGl6v+AQ4WX0KKnY2alTjfgTClQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6buVcb0ySjD3VGLhUXzcY5PdHfXddCaHVeqwtYm8Vt0=;
 b=FXFPEH9A1e5RubQNCHJdfwvZrfWAkV/SywBYE5zCe/pD8pYmF7vAW6qmFe6o7R9tAtW/DWnBMh1BMYBh3hPnotE1zzZHClUm/Pb24q2Zuc9NVq8h2Ofeqw/3na0U6a4W13S9XsfeaaY50BtN3qUYPuPg2OQeQcEtrU1pmuFKTPI=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
Received: from SA1PR04MB10065.namprd04.prod.outlook.com
 (2603:10b6:806:4dd::14) by DM6PR04MB6605.namprd04.prod.outlook.com
 (2603:10b6:5:1bf::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Tue, 27 Oct
 2026 04:24:14 +0000
Received: from SA1PR04MB10065.namprd04.prod.outlook.com
 ([fe80::9b98:bf8a:b0b1:ef85]) by SA1PR04MB10065.namprd04.prod.outlook.com
 ([fe80::9b98:bf8a:b0b1:ef85%5]) with mapi id 15.21.0546.021; Tue, 27 Oct 2026
 04:24:14 +0000
Date: Tue, 27 Oct 2026 13:24:07 +0900
From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: Julian Sun <sunjunchao@bytedance.com>
Cc: linux-block@vger.kernel.org, jack@suse.cz, axboe@kernel.dk, 
	viro@zeniv.linux.org.uk, mcgrof@kernel.org, djwong@kernel.org, tz2294@columbia.edu
Subject: Re: [PATCH 2/2] block: take the inode lock for buffered write
 fallback
Message-ID: <auAmMShKl4S2lc1u@shinmob>
References: <20261015091105.1315605-1-sunjunchao@bytedance.com>
 <20261015091105.1315605-3-sunjunchao@bytedance.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261015091105.1315605-3-sunjunchao@bytedance.com>
X-ClientProxiedBy: TYCP301CA0041.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:400:380::7) To SA1PR04MB10065.namprd04.prod.outlook.com
 (2603:10b6:806:4dd::14)
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR04MB10065:EE_|DM6PR04MB6605:EE_
X-MS-Office365-Filtering-Correlation-Id: 25473c9e-4bf5-4c09-8eb4-08df33e2287f
WDCIPOUTBOUND: EOP-TRUE
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|19092799006|23010399003|376014|1800799024|6133799003|10067099003|261026121527099003|18002099003|22082099003|3023799007|56012099006|11063799006|4143699003|261022105027099003|261021121427099003|261022075727099003|261009223027099003|261026140227099003;
X-Microsoft-Antispam-Message-Info:
	bbK1dRYcspjFtD38NNPqVvt5R3kn8e0bjId+laWaaJIPa3eH1uCy8qpam3CpXHrjEIRFX+3TERrbE9PG72stoDqui/dweOTFWNX+ZPIZSRdsusy6L31QZS8RkzIvlMkfs7hm9RbUF0ujZ5qVbhjzbLG5MGnMyeuVZVsxlxcxG++sBSn7p2+hDWGypyRfRQ9daG3G84Q5sTOvBsatIzYW2YbvzBYBT/EETUndPPYzPzioY1fsRZ9wYl9taNKoj+RTOYF+K5RAaYdSGAHaZPx3woflpW5QZeHS3kvqXlPaOoxqMpzr6cNpikdtjgL3OegLvszAGfwErgoZs5wAhUnwmhJ1MluDzb+zjDYldDfWU1LjiOyWkDuEUcESxITAvwmxcbQ176yetW3ZoftvZgZppnn+k4qZXrYuArKrOBJtswmSRlDwjBRcXQaAKQI8AXNSsSWWDhhGEkEEKUlBaCGpmLmMa/+sBhj0fBJhC3TbSxcKLSjF4hj56vcIzDU/VTnEztjR7JWeLVQaVGBmNvOaX3Utvtq3/DGvfLrhXvWitWr0qVou6e/gYXYyF8+4bWo9TgftasWZKiGz0fkerUQifbwBNkcCiWSBeKdXVXEKb/SHIRCUL1Nure2GHU3AEZPQ
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR04MB10065.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(19092799006)(23010399003)(376014)(1800799024)(6133799003)(10067099003)(261026121527099003)(18002099003)(22082099003)(3023799007)(56012099006)(11063799006)(4143699003)(261022105027099003)(261021121427099003)(261022075727099003)(261009223027099003)(261026140227099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?3GMK0kQArRq/XKwTpPiEh516li7r5LssNst8YK/39sgZp2tO+PDici600+by?=
 =?us-ascii?Q?t6MUmADWLcOkw7cbSdcvWQ2jAfZmrJ/K/B4LIUwr37VHEtvhLT9Lq9IGTuot?=
 =?us-ascii?Q?UPs5trnxbK36IViBLG07pNIGagokDgOpk7RMinspf8BYnNatrHjb02TRBdh8?=
 =?us-ascii?Q?hIxc96Yy88GECDa9NEo0opuSE7p7WKs6+XHqJMedlStIDbtDdVOV1yKRX/4O?=
 =?us-ascii?Q?sdPnlqyaga3yvlonpPZtPdg+VrXowltVlYf+DRuMQzCLhQMEWStBqRvNg+Ve?=
 =?us-ascii?Q?Tis8F6nI0juGHQB1+qX6XkgFKQ0P6UHLwzQExnGHgwITcILI5r/OT/DgbBFW?=
 =?us-ascii?Q?/IvyF51zQClJ6E56lTLEk8yPBGQfT2rTpru6OC/y7fp/Tq6eRO3MMCPqljBl?=
 =?us-ascii?Q?nNT+/9cGaAATiIDIvnrnrvR4B2UVi7WKg1Pvez5RUqQ7t9qdepYv0JQNcVHD?=
 =?us-ascii?Q?gUmkLHx/l5J/wnjOr7cXcqwWKdxRlye32m0MQwnCqPNK2RLRL50TWN0RLjOs?=
 =?us-ascii?Q?A6QzJgkTkYs64cm3UcSK+DnWRvrhZhtTMmLzIF84wC4yNBep9x5NW5w00lGG?=
 =?us-ascii?Q?k+DN/VhC/ICUT3mboHhavv2H7nX4yDz91/t55Ka5WUct/vQmQWoxTUZq8xZP?=
 =?us-ascii?Q?TKR+C1urQJxorH90mBa4QKYktdHgeCwyMqpqU6yRKLF1GmXg0Z2vfLlJd43M?=
 =?us-ascii?Q?w1YDoJjWa5U3GZBDPSIefpQZPdoq24fvmSKF6vAGlOt4KZBS5OQLfcO/jXGT?=
 =?us-ascii?Q?Oq262vTz8LTDVGNvUfe0OzQYW43VPrIz0JqRK32oq6KEiYu6hx0mhEj75WAV?=
 =?us-ascii?Q?Flv/ACHAS0YyVwY9NPoZshV4iWM20vAH+rW8xEii679cPsyR8diWJ7XrWDA9?=
 =?us-ascii?Q?xaQ/kXjPHNywX2CSmftLHxUAldTS2MMo77wAvNi1wg5WA4MRjv000nvw6zF3?=
 =?us-ascii?Q?DsE/723hT5K7g17FzCwGl6h6QUdgCv4YMIALSlnDV8WTQGhFusRmgjXzZsBu?=
 =?us-ascii?Q?RRBswUvhnkFWW4mYhxNG07qFVplph4oBMMIW8lsopFg7P/WED/j157WHfP5n?=
 =?us-ascii?Q?SXdf7Kns+7KP+mfpWOP3WsCWWaQSh7sErPE8Xottutm8thl1H9e5l/xiq6uV?=
 =?us-ascii?Q?ehEXRS79oBX7fZU0diYBpnn2kPMz/vFIKQPU26haT6tzPkQ3tPs/Px8Y3n4r?=
 =?us-ascii?Q?TgqCV7xB/PCWXSiXQXif6Mq84KaTvL0P6ynnFk9SvglayHeCXheraXojRRhZ?=
 =?us-ascii?Q?xtvSfo++3SDl5SSg5f43xTBSAdGknuT2zeOwn+S/QHlte7JzS8MRf2NJXAHP?=
 =?us-ascii?Q?uRJ051nrepwuWeFzPTDMZFGg/FFHqKvvy09wnWpizztQ2VWiZtPm2k6BCWpT?=
 =?us-ascii?Q?EqP3ABHZzPhglxl4BA4+uyZw/s6HHaZcNotPHBcGATHis1Orof/j6ml/EHEQ?=
 =?us-ascii?Q?9czKvy0n/RnSqq3iCVd09gpYi/ILu7bHiwFh/N9fZUC0+ZbKM/GrrMjzM+mB?=
 =?us-ascii?Q?uxaCn294CGAIxoUjqvwX58eTDGgbTog/o/HPJpsYpiZlyBx/vqui2F5zh0pK?=
 =?us-ascii?Q?jSsOctTp+HcM4dc7T91HIeUbGDkmTQgkRsRFMYOWjZtxuPJImIz6mrwSk89w?=
 =?us-ascii?Q?xd3smnF3PkdVVG9hRuCjfQZSwf0r6XbhIP80Jm9p5vHKDx84dVZRIvCR2JOo?=
 =?us-ascii?Q?9BaFSskeg9Qkz3TBx8fzoMtmRa5sFng/7o5b2NNIyfteaVMLY2r/+Filp2wy?=
 =?us-ascii?Q?4U1B59SYoyBiQs0qXiKgeoaXY+JNZBk=3D?=
X-Exchange-RoutingPolicyChecked:
	wcaOEhG32LR/M2qybRoNsa7ka6zv2du5sjkQ+RqChaOaA+YBFp9fuggjrJqNVBlnR70knGIKSoa91b6ZbHdsaeZ9pqUpu/iAnlyoD3Cjjv4UvbHV21iUURVi3oHymyJiW2zxqMgx6fWy5n40SJzoUg1tShMT8zC9llZSfUYemlNJ7gk6Pij8Pd1JdeqsgFC7ryIJ5I8gwwe2fyrmy5Zwvchckjy0iymRnrBcAxHxyPrH2g9BFvC+LWDG1lcJzDSiGj/KxVdbumdHEV8IUdsftGGrtz21NzWXEcfqYcn349Kp6ae0kjKWGXg5u6/uY4UY3rksVXie5FGMt0WGAkw2wQ==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	qfkNzq/8pbBHlfNCEJvuxNC06Avs+7gRTnWKSe5VuXI0Ht7gS6JoJGfayZLNshXPdBYb7pYCOSsJCICvENRT7G6+KT+EERDsArA4RdmWQ8LARN8fxnVxIds0KlR3tEL4oBdjq6XTFFlOsNGnof3XlM25wVLG+vTDNgm2t3PWxd/8SI5Doh6rgCI3kTrxRC2WQF54xfBk2GhpVvmedBftfurJn5S1asWzHPcjNjHldyJDT1478/vUbzBGRf4HOXgLEht9qzMk1jC6e6jUNZYWuSDjHqjoDxBOznm37JZWClvQRP1D4oEiU8wCfysUFprikNjdGAuSMXIOKEzIjm3QNRIVIyKfu6LSV45ak+/H3xDGtjaNhRpWwu6JKCVZSJKqyYlugLiSocgNP2TUd8uGDosCwTbMl37fohLC3WqtmpgZU76n24khY1DF7wtvid1bvdEhzC7WCBXWz5AZIV1LekOP3yjp7gtxxDNzxILehWtID9NwDMM9VSRyd0teoJ6nJVdyJYa5xLb4+KxloRDc6NlI02S0MysQ72TQ3Wbxk50Bz37+Ir5U1lhJgGN1SR7MQNFtSOaWK+QYpk2FgGYs05MEGFJyYLPyHlNsw3FDnZy5D7i7Ef7EMvE96IZ1CWQC
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 25473c9e-4bf5-4c09-8eb4-08df33e2287f
X-MS-Exchange-CrossTenant-AuthSource: SA1PR04MB10065.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2026 04:24:14.7139
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GeMdKzSaBOnR7UPVnRi4qJPzPTCK7WhbbQA/eBNuq2txLutiS+lgsAKv7P6zqZwhH69206Gefg6gq3baCniJLaypTCRt/xvGFTsBChUbOBw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB6605

CC+: Tal Zassman,

On Oct 15, 2026 / 17:11, Julian Sun wrote:
> Commit c0e473a0d226 ("block: fix race between set_blocksize and read
> paths") added shared inode locking around ordinary buffered writes,
> but missed the direct-I/O fallback path.
> 
> Move the lock into blkdev_buffered_write() so both paths serialize
> with set_blocksize().
> 
> Also correct the comment claiming that this path takes invalidate_lock;
> it only takes i_rwsem.
> 
> Fixes: c0e473a0d226 ("block: fix race between set_blocksize and read paths")
> Signed-off-by: Julian Sun <sunjunchao@bytedance.com>

When I checking the new blktests test case block/050 by Tal Zussman [1], I found
the test case hangs [2]. I bisected and this kernel change triggers the hang.

Julian, may I ask you to take a look in the hang?

[1] https://lore.kernel.org/linux-block/20261015-blkdev-fixes-tests-v3-1-b6ffa6410514@columbia.edu/

[2] dmesg during test case hang

[   93.055848] [   T1042] run blktests block/050 at 2026-10-27 13:15:20.266665152
[   93.132099] [   T1042] null_blk: disk nullb1 created

[   93.204476] [   T1088] ============================================
[   93.205320] [   T1088] WARNING: possible recursive locking detected
[   93.206137] [   T1088] 7.3.0-rc2+ #715 Not tainted
[   93.206784] [   T1088] --------------------------------------------
[   93.207569] [   T1088] dio-fallback-ra/1088 is trying to acquire lock:
[   93.208415] [   T1088] ffff888100452a78 (&sb->s_type->i_mutex_key#13){++++}-{4:4}, at: blkdev_write_iter+0x928/0xf40
[   93.209769] [   T1088] 
                          but task is already holding lock:
[   93.210736] [   T1088] ffff888100452a78 (&sb->s_type->i_mutex_key#13){++++}-{4:4}, at: blkdev_write_iter+0x882/0xf40
[   93.212048] [   T1088] 
                          other info that might help us debug this:
[   93.213080] [   T1088]  Possible unsafe locking scenario:

[   93.214051] [   T1088]        CPU0
[   93.214501] [   T1088]        ----
[   93.214934] [   T1088]   lock(&sb->s_type->i_mutex_key#13);
[   93.215671] [   T1088]   lock(&sb->s_type->i_mutex_key#13);
[   93.216370] [   T1088] 
                           *** DEADLOCK ***

[   93.217409] [   T1088]  May be due to missing lock nesting notation

[   93.218468] [   T1088] locks held by dio-fallback-ra/1088: 1, last CPU#1:
[   93.219343] [   T1088]  #0: ffff888100452a78 (&sb->s_type->i_mutex_key#13){++++}-{4:4}, at: blkdev_write_iter+0x882/0xf40
[   93.220736] [   T1088] 
                          stack backtrace:
[   93.221490] [   T1088] CPU: 1 UID: 0 PID: 1088 Comm: dio-fallback-ra Not tainted 7.3.0-rc2+ #715 PREEMPT(full) 
[   93.222766] [   T1088] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.17.0-10.fc44 06/10/2025
[   93.223972] [   T1088] Call Trace:
[   93.224415] [   T1088]  <TASK>
[   93.224801] [   T1088]  dump_stack_lvl+0x6a/0x90
[   93.225381] [   T1088]  print_deadlock_bug.cold+0xc0/0xcd
[   93.226033] [   T1088]  __lock_acquire+0x1536/0x2490
[   93.226705] [   T1088]  lock_acquire+0x1b1/0x340
[   93.227262] [   T1088]  ? blkdev_write_iter+0x928/0xf40
[   93.227880] [   T1088]  ? __pfx___might_resched+0x10/0x10
[   93.228538] [   T1088]  down_read+0xa6/0x540
[   93.229049] [   T1088]  ? blkdev_write_iter+0x928/0xf40
[   93.229754] [   T1088]  ? __pfx_down_read+0x10/0x10
[   93.230374] [   T1088]  ? filemap_check_errors+0x58/0x100
[   93.231040] [   T1088]  blkdev_write_iter+0x928/0xf40
[   93.231722] [   T1088]  do_iter_readv_writev+0x48a/0xb80
[   93.232382] [   T1088]  ? __pfx_folio_add_lru_vma+0x10/0x10
[   93.233070] [   T1088]  ? rcu_read_unlock+0x1c/0x60
[   93.233764] [   T1088]  ? __folio_mod_stat+0x4c/0x190
[   93.234399] [   T1088]  ? __pfx_do_iter_readv_writev+0x10/0x10
[   93.235108] [   T1088]  ? folio_add_new_anon_rmap+0x34f/0xd40
[   93.235860] [   T1088]  ? selinux_file_permission+0x3c0/0x530
[   93.236577] [   T1088]  ? security_file_permission+0x44/0xc0
[   93.237316] [   T1088]  ? rw_verify_area+0x77/0x650
[   93.237917] [   T1088]  vfs_writev+0x27d/0xbc0
[   93.238484] [   T1088]  ? __pfx_vfs_writev+0x10/0x10
[   93.239095] [   T1088]  ? __handle_mm_fault+0x1584/0x1fb0
[   93.239816] [   T1088]  ? lock_acquire+0x1b1/0x340
[   93.240425] [   T1088]  ? __fget_files+0x1d8/0x440
[   93.241021] [   T1088]  ? do_pwritev+0x18a/0x300
[   93.241653] [   T1088]  do_pwritev+0x18a/0x300
[   93.242183] [   T1088]  ? __pfx_do_pwritev+0x10/0x10
[   93.242837] [   T1088]  ? lock_release+0x1b5/0x340
[   93.243451] [   T1088]  ? rcu_is_watching+0x12/0xb0
[   93.244054] [   T1088]  do_syscall_64+0xf2/0x690
[   93.244688] [   T1088]  ? do_syscall_64+0x2d/0x690
[   93.245277] [   T1088]  ? trace_hardirqs_off_finish+0x139/0x180
[   93.246010] [   T1088]  ? lockdep_hardirqs_off+0xaf/0xf0
[   93.246724] [   T1088]  ? do_syscall_64+0x60/0x690
[   93.247325] [   T1088]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[   93.248054] [   T1088] RIP: 0033:0x7f1cae028e32
[   93.248676] [   T1088] Code: 08 0f 85 91 41 ff ff 49 89 fb 48 89 f0 48 89 d7 48 89 ce 4c 89 c2 4d 89 ca 4c 8b 44 24 08 4c 8b 4c 24 10 4c 89 5c 24 08 0f 05 <c3> 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 00 f3 0f 1e fa 55 bf 01 00
[   93.251120] [   T1088] RSP: 002b:00007f1cadf98d98 EFLAGS: 00000246 ORIG_RAX: 0000000000000128
[   93.252230] [   T1088] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f1cae028e32
[   93.253253] [   T1088] RDX: 0000000000000002 RSI: 00007f1cadf98e20 RDI: 0000000000000004
[   93.254275] [   T1088] RBP: 00007f1cadf98dc0 R08: 0000000000000000 R09: 0000000000000000
[   93.255295] [   T1088] R10: 0000000000000000 R11: 0000000000000246 R12: 00007f1ca8001000
[   93.256307] [   T1088] R13: 00007fff0eee6560 R14: 0000000000000000 R15: 00007fff0eee6667
[   93.257329] [   T1088]  </TASK>
[  247.593474] [     T48] INFO: task dio-fallback-ra:1088 blocked for more than 122 seconds.
[  247.595947] [     T48]       Not tainted 7.3.0-rc2+ #715
[  247.598101] [     T48] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
[  247.599361] [     T48] task:dio-fallback-ra state:D stack:0     pid:1088  tgid:1087  ppid:1042   task_flags:0x400040 flags:0x00080000
[  247.599727] [     T48] Call Trace:
[  247.600141] [     T48]  <TASK>
[  247.600524] [     T48]  __schedule+0x1fcc/0x6ef0
[  247.600905] [     T48]  ? asm_sysvec_apic_timer_interrupt+0x16/0x20
[  247.601293] [     T48]  ? trace_hardirqs_on+0x14/0x190
[  247.601670] [     T48]  ? __pfx___schedule+0x10/0x10
[  247.602045] [     T48]  ? lock_acquire+0x2f5/0x340
[  247.602430] [     T48]  ? lock_acquire+0x2f5/0x340
[  247.602801] [     T48]  ? rcu_is_watching+0x12/0xb0
[  247.603182] [     T48]  ? lock_release+0x285/0x340
[  247.603549] [     T48]  schedule+0xe3/0x2e0
[  247.603917] [     T48]  ? rwsem_down_read_slowpath+0x31e/0x10d0
[  247.604296] [     T48]  schedule_preempt_disabled+0x14/0x30
[  247.604665] [     T48]  rwsem_down_read_slowpath+0x61a/0x10d0
[  247.605050] [     T48]  ? __pfx_rwsem_down_read_slowpath+0x10/0x10
[  247.605412] [     T48]  ? __pfx___might_resched+0x10/0x10
[  247.605765] [     T48]  down_read+0xfa/0x540
[  247.606110] [     T48]  ? __pfx_down_read+0x10/0x10
[  247.606889] [     T48]  ? filemap_check_errors+0x58/0x100
[  247.607286] [     T48]  blkdev_write_iter+0x928/0xf40
[  247.607634] [     T48]  do_iter_readv_writev+0x48a/0xb80
[  247.607987] [     T48]  ? __pfx_folio_add_lru_vma+0x10/0x10
[  247.608348] [     T48]  ? rcu_read_unlock+0x1c/0x60
[  247.608707] [     T48]  ? __folio_mod_stat+0x4c/0x190
[  247.609083] [     T48]  ? __pfx_do_iter_readv_writev+0x10/0x10
[  247.609445] [     T48]  ? folio_add_new_anon_rmap+0x34f/0xd40
[  247.609802] [     T48]  ? selinux_file_permission+0x3c0/0x530
[  247.610167] [     T48]  ? security_file_permission+0x44/0xc0
[  247.610521] [     T48]  ? rw_verify_area+0x77/0x650
[  247.610878] [     T48]  vfs_writev+0x27d/0xbc0
[  247.611244] [     T48]  ? __pfx_vfs_writev+0x10/0x10
[  247.611611] [     T48]  ? __handle_mm_fault+0x1584/0x1fb0
[  247.611971] [     T48]  ? lock_acquire+0x1b1/0x340
[  247.612375] [     T48]  ? __fget_files+0x1d8/0x440
[  247.612731] [     T48]  ? do_pwritev+0x18a/0x300
[  247.613115] [     T48]  do_pwritev+0x18a/0x300
[  247.613472] [     T48]  ? __pfx_do_pwritev+0x10/0x10
[  247.613849] [     T48]  ? lock_release+0x1b5/0x340
[  247.614160] [     T48]  ? rcu_is_watching+0x12/0xb0
[  247.614478] [     T48]  do_syscall_64+0xf2/0x690
[  247.614823] [     T48]  ? do_syscall_64+0x2d/0x690
[  247.615146] [     T48]  ? trace_hardirqs_off_finish+0x139/0x180
[  247.615457] [     T48]  ? lockdep_hardirqs_off+0xaf/0xf0
[  247.615759] [     T48]  ? do_syscall_64+0x60/0x690
[  247.616054] [     T48]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[  247.616360] [     T48] RIP: 0033:0x7f1cae028e32
[  247.616652] [     T48] RSP: 002b:00007f1cadf98d98 EFLAGS: 00000246 ORIG_RAX: 0000000000000128
[  247.616984] [     T48] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f1cae028e32
[  247.617287] [     T48] RDX: 0000000000000002 RSI: 00007f1cadf98e20 RDI: 0000000000000004
[  247.617571] [     T48] RBP: 00007f1cadf98dc0 R08: 0000000000000000 R09: 0000000000000000
[  247.617850] [     T48] R10: 0000000000000000 R11: 0000000000000246 R12: 00007f1ca8001000
[  247.618139] [     T48] R13: 00007fff0eee6560 R14: 0000000000000000 R15: 00007fff0eee6667
[  247.618423] [     T48]  </TASK>
[  247.618698] [     T48] INFO: task dio-fallback-ra:1088 is blocked on an rw-semaphore, but the owner is not found.
[  247.618995] [     T48] INFO: task dio-fallback-ra:1089 blocked for more than 122 seconds.
[  247.619302] [     T48]       Not tainted 7.3.0-rc2+ #715
[  247.619669] [     T48] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
[  247.619997] [     T48] task:dio-fallback-ra state:D stack:0     pid:1089  tgid:1087  ppid:1042   task_flags:0x400040 flags:0x00080000
[  247.620340] [     T48] Call Trace:
[  247.620660] [     T48]  <TASK>
[  247.620982] [     T48]  __schedule+0x1fcc/0x6ef0
[  247.621349] [     T48]  ? __pfx_bio_wait_end_io+0x10/0x10
[  247.621671] [     T48]  ? __pfx___schedule+0x10/0x10
[  247.622021] [     T48]  ? lock_acquire+0x2f5/0x340
[  247.622349] [     T48]  ? lock_acquire+0x2f5/0x340
[  247.622659] [     T48]  ? rcu_is_watching+0x12/0xb0
[  247.622973] [     T48]  ? lock_release+0x285/0x340
[  247.623294] [     T48]  schedule+0xe3/0x2e0
[  247.623602] [     T48]  ? rwsem_down_read_slowpath+0x31e/0x10d0
[  247.623957] [     T48]  schedule_preempt_disabled+0x14/0x30
[  247.624285] [     T48]  rwsem_down_read_slowpath+0x61a/0x10d0
[  247.624637] [     T48]  ? __pfx_rwsem_down_read_slowpath+0x10/0x10
[  247.624955] [     T48]  ? blkdev_direct_IO+0x86f/0x1c50
[  247.625322] [     T48]  ? __pfx___might_resched+0x10/0x10
[  247.625638] [     T48]  down_read+0xfa/0x540
[  247.625985] [     T48]  ? __pfx_down_read+0x10/0x10
[  247.626309] [     T48]  ? filemap_check_errors+0x58/0x100
[  247.626622] [     T48]  blkdev_write_iter+0x882/0xf40
[  247.626979] [     T48]  do_iter_readv_writev+0x48a/0xb80
[  247.627306] [     T48]  ? vfs_writev+0x831/0xbc0
[  247.627618] [     T48]  ? __pfx_do_iter_readv_writev+0x10/0x10
[  247.627976] [     T48]  ? selinux_file_permission+0x3c0/0x530
[  247.628303] [     T48]  ? security_file_permission+0x44/0xc0
[  247.628621] [     T48]  ? rw_verify_area+0x77/0x650
[  247.628941] [     T48]  vfs_writev+0x27d/0xbc0
[  247.629307] [     T48]  ? __pfx_vfs_writev+0x10/0x10
[  247.629628] [     T48]  ? __fget_files+0x4f/0x440
[  247.629981] [     T48]  ? __fget_files+0x1d8/0x440
[  247.630309] [     T48]  ? do_pwritev+0x18a/0x300
[  247.630623] [     T48]  do_pwritev+0x18a/0x300
[  247.630941] [     T48]  ? __pfx_do_pwritev+0x10/0x10
[  247.631265] [     T48]  ? lock_release+0x1b5/0x340
[  247.631577] [     T48]  ? rcu_is_watching+0x12/0xb0
[  247.631918] [     T48]  do_syscall_64+0xf2/0x690
[  247.632239] [     T48]  ? rcu_read_unlock+0x17/0x60
[  247.632548] [     T48]  ? lock_release+0x1b5/0x340
[  247.633267] [     T48]  ? __handle_mm_fault+0x1584/0x1fb0
[  247.633573] [     T48]  ? __lock_acquire+0x54a/0x2490
[  247.633875] [     T48]  ? __pfx___css_rstat_updated+0x10/0x10
[  247.634190] [     T48]  ? lock_acquire+0x1b1/0x340
[  247.634485] [     T48]  ? rcu_is_watching+0x12/0xb0
[  247.634783] [     T48]  ? count_memcg_events+0x107/0x4c0
[  247.635099] [     T48]  ? find_held_lock+0x2b/0x80
[  247.635397] [     T48]  ? rcu_read_unlock+0x17/0x60
[  247.635674] [     T48]  ? lock_release+0x1b5/0x340
[  247.635991] [     T48]  ? find_held_lock+0x2b/0x80
[  247.636308] [     T48]  ? exc_page_fault+0x94/0x140
[  247.636563] [     T48]  ? lock_release+0x1b5/0x340
[  247.636853] [     T48]  ? rcu_is_watching+0x12/0xb0
[  247.637100] [     T48]  ? do_syscall_64+0x2d/0x690
[  247.637359] [     T48]  ? trace_hardirqs_off_finish+0x139/0x180
[  247.637610] [     T48]  ? lockdep_hardirqs_off+0xaf/0xf0
[  247.637864] [     T48]  ? do_syscall_64+0x60/0x690
[  247.638113] [     T48]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[  247.638382] [     T48] RIP: 0033:0x7f1cae028e32
[  247.638639] [     T48] RSP: 002b:00007f1cad797d98 EFLAGS: 00000246 ORIG_RAX: 0000000000000128
[  247.638977] [     T48] RAX: ffffffffffffffda RBX: 0000000000004000 RCX: 00007f1cae028e32
[  247.639260] [     T48] RDX: 0000000000000002 RSI: 00007f1cad797e20 RDI: 0000000000000005
[  247.639534] [     T48] RBP: 00007f1cad797dc0 R08: 0000000000000000 R09: 0000000000000000
[  247.639810] [     T48] R10: 0000000000004000 R11: 0000000000000246 R12: 00007f1c9c001000
[  247.640082] [     T48] R13: 00007fff0eee6560 R14: 0000000000000000 R15: 00007fff0eee6667
[  247.640368] [     T48]  </TASK>
[  247.640636] [     T48] INFO: task dio-fallback-ra:1089 is blocked on an rw-semaphore, but the owner is not found.
[  247.640926] [     T48] INFO: task dio-fallback-ra:1091 blocked for more than 122 seconds.
[  247.641225] [     T48]       Not tainted 7.3.0-rc2+ #715
[  247.641512] [     T48] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
[  247.641813] [     T48] task:dio-fallback-ra state:D stack:0     pid:1091  tgid:1087  ppid:1042   task_flags:0x400040 flags:0x00080000
[  247.642139] [     T48] Call Trace:
[  247.642446] [     T48]  <TASK>
[  247.642753] [     T48]  __schedule+0x1fcc/0x6ef0
[  247.643060] [     T48]  ? blk_stat_add+0xbc/0x450
[  247.643380] [     T48]  ? rcu_is_watching+0x12/0xb0
[  247.643685] [     T48]  ? lock_release+0x285/0x340
[  247.644028] [     T48]  ? percpu_ref_put_many.constprop.0+0x39/0x1d0
[  247.644348] [     T48]  ? __pfx___schedule+0x10/0x10
[  247.644655] [     T48]  ? lock_acquire+0x2f5/0x340
[  247.644964] [     T48]  ? lock_acquire+0x2f5/0x340
[  247.645318] [     T48]  ? rcu_is_watching+0x12/0xb0
[  247.645624] [     T48]  ? lock_release+0x285/0x340
[  247.645973] [     T48]  schedule+0xe3/0x2e0
[  247.646357] [     T48]  ? rwsem_down_read_slowpath+0x31e/0x10d0
[  247.646687] [     T48]  schedule_preempt_disabled+0x14/0x30
[  247.647028] [     T48]  rwsem_down_read_slowpath+0x61a/0x10d0
[  247.647354] [     T48]  ? __pfx_rwsem_down_read_slowpath+0x10/0x10
[  247.647669] [     T48]  ? blk_mq_dispatch_queue_requests+0x51a/0x7e0
[  247.648017] [     T48]  ? blk_mq_dispatch_queue_requests+0x576/0x7e0
[  247.648342] [     T48]  ? __pfx_folio_batch_move_lru+0x10/0x10
[  247.648658] [     T48]  ? __pfx___might_resched+0x10/0x10
[  247.649023] [     T48]  down_read+0xfa/0x540
[  247.649345] [     T48]  ? __pfx_down_read+0x10/0x10
[  247.649657] [     T48]  ? __blk_flush_plug+0x29f/0x540
[  247.649971] [     T48]  ? selinux_file_permission+0x3c0/0x530
[  247.650296] [     T48]  ? security_file_permission+0x44/0xc0
[  247.650610] [     T48]  blkdev_read_iter+0x15a/0x4e0
[  247.650927] [     T48]  ? rw_verify_area+0x77/0x650
[  247.651254] [     T48]  vfs_read+0x6f4/0xb30
[  247.651569] [     T48]  ? blk_finish_plug+0x52/0xc0
[  247.651887] [     T48]  ? __pfx_vfs_read+0x10/0x10
[  247.652243] [     T48]  ? lock_release+0x285/0x340
[  247.652560] [     T48]  __x64_sys_pread64+0x18d/0x250
[  247.652910] [     T48]  ? __pfx___x64_sys_pread64+0x10/0x10
[  247.653237] [     T48]  ? rcu_is_watching+0x12/0xb0
[  247.653552] [     T48]  ? rcu_is_watching+0x12/0xb0
[  247.653864] [     T48]  ? do_syscall_64+0x7f/0x690
[  247.654182] [     T48]  do_syscall_64+0xf2/0x690
[  247.654485] [     T48]  ? force_page_cache_ra+0x21c/0x370
[  247.654857] [     T48]  ? generic_fadvise+0x35c/0x660
[  247.655180] [     T48]  ? __pfx_generic_fadvise+0x10/0x10
[  247.655488] [     T48]  ? rcu_is_watching+0x12/0xb0
[  247.655786] [     T48]  ? lock_release+0x285/0x340
[  247.656078] [     T48]  ? __fget_files+0x1d8/0x440
[  247.656381] [     T48]  ? fput+0x1b/0xa0
[  247.656658] [     T48]  ? fput+0x48/0xa0
[  247.656969] [     T48]  ? rcu_is_watching+0x12/0xb0
[  247.657247] [     T48]  ? do_syscall_64+0x1ff/0x690
[  247.657507] [     T48]  ? trace_hardirqs_on_prepare+0x139/0x180
[  247.657806] [     T48]  ? do_syscall_64+0x21d/0x690
[  247.658049] [     T48]  ? vfs_read+0x3b6/0xb30
[  247.658305] [     T48]  ? vfs_read+0x3b6/0xb30
[  247.658547] [     T48]  ? lock_acquire+0x1b1/0x340
[  247.658792] [     T48]  ? __pfx_vfs_read+0x10/0x10
[  247.659034] [     T48]  ? __fget_files+0x1ce/0x440
[  247.659288] [     T48]  ? lock_release+0x1b5/0x340
[  247.659877] [     T48]  ? fput+0x1b/0xa0
[  247.660117] [     T48]  ? fput+0x48/0xa0
[  247.660364] [     T48]  ? __x64_sys_pread64+0x1ad/0x250
[  247.660604] [     T48]  ? __pfx___x64_sys_pread64+0x10/0x10
[  247.660884] [     T48]  ? rcu_is_watching+0x12/0xb0
[  247.661123] [     T48]  ? do_syscall_64+0x1ff/0x690
[  247.661407] [     T48]  ? trace_hardirqs_on_prepare+0x139/0x180
[  247.661649] [     T48]  ? do_syscall_64+0x21d/0x690
[  247.661939] [     T48]  ? rcu_is_watching+0x12/0xb0
[  247.662188] [     T48]  ? do_syscall_64+0x2d/0x690
[  247.662423] [     T48]  ? trace_hardirqs_off_finish+0x139/0x180
[  247.662658] [     T48]  ? lockdep_hardirqs_off+0xaf/0xf0
[  247.662900] [     T48]  ? do_syscall_64+0x60/0x690
[  247.663147] [     T48]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[  247.663388] [     T48] RIP: 0033:0x7f1cae028e32
[  247.663626] [     T48] RSP: 002b:00007f1ca45fedc8 EFLAGS: 00000246 ORIG_RAX: 0000000000000011
[  247.663880] [     T48] RAX: ffffffffffffffda RBX: 0000000000002000 RCX: 00007f1cae028e32
[  247.664144] [     T48] RDX: 0000000000002000 RSI: 00007f1c94000880 RDI: 0000000000000006
[  247.664441] [     T48] RBP: 00007f1ca45fedf0 R08: 0000000000000000 R09: 0000000000000000
[  247.664695] [     T48] R10: 0000000000002000 R11: 0000000000000246 R12: 00007f1c94000880
[  247.664995] [     T48] R13: 00007fff0eee6540 R14: 0000000000000000 R15: 00007fff0eee6647
[  247.665298] [     T48]  </TASK>
[  247.665551] [     T48] INFO: task dio-fallback-ra:1091 is blocked on an rw-semaphore, but the owner is not found.
[  247.665869] [     T48] INFO: task dio-fallback-ra:1092 blocked for more than 122 seconds.
[  247.666143] [     T48]       Not tainted 7.3.0-rc2+ #715
[  247.666429] [     T48] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
[  247.666719] [     T48] task:dio-fallback-ra state:D stack:0     pid:1092  tgid:1087  ppid:1042   task_flags:0x400140 flags:0x00080000
[  247.667021] [     T48] Call Trace:
[  247.667327] [     T48]  <TASK>
[  247.667661] [     T48]  __schedule+0x1fcc/0x6ef0
[  247.667966] [     T48]  ? rcu_is_watching+0x12/0xb0
[  247.668307] [     T48]  ? __pfx___schedule+0x10/0x10
[  247.668606] [     T48]  ? lock_acquire+0x2f5/0x340
[  247.668906] [     T48]  ? lock_acquire+0x2f5/0x340
[  247.669210] [     T48]  ? rcu_is_watching+0x12/0xb0
[  247.669503] [     T48]  ? lock_release+0x285/0x340
[  247.669800] [     T48]  schedule+0xe3/0x2e0
[  247.670092] [     T48]  ? _raw_spin_unlock_irq+0x34/0x50
[  247.670400] [     T48]  schedule_preempt_disabled+0x14/0x30
[  247.670700] [     T48]  rwsem_down_write_slowpath+0x4b3/0x1830
[  247.671006] [     T48]  ? __pfx_rwsem_down_write_slowpath+0x10/0x10
[  247.671323] [     T48]  ? rcu_is_watching+0x12/0xb0
[  247.671626] [     T48]  ? lock_release+0x285/0x340
[  247.671930] [     T48]  ? __pfx___mutex_lock+0x10/0x10
[  247.672245] [     T48]  ? __pfx___might_resched+0x10/0x10
[  247.672553] [     T48]  down_write+0x1be/0x1f0
[  247.672994] [     T48]  ? __pfx_down_write+0x10/0x10
[  247.673328] [     T48]  ? bdev_open+0x90c/0xc60
[  247.673644] [     T48]  set_blocksize+0x1ad/0x460
[  247.673956] [     T48]  ? bdev_file_open_by_dev+0xe6/0x170
[  247.674279] [     T48]  blkdev_bszset+0x142/0x1e0
[  247.674592] [     T48]  ? __pfx_blkdev_bszset+0x10/0x10
[  247.674937] [     T48]  ? lock_acquire+0x2f5/0x340
[  247.675263] [     T48]  ? rcu_is_watching+0x12/0xb0
[  247.675583] [     T48]  blkdev_ioctl+0x4e9/0x5e0
[  247.675932] [     T48]  ? __pfx_blkdev_ioctl+0x10/0x10
[  247.676257] [     T48]  __x64_sys_ioctl+0x138/0x1c0
[  247.676569] [     T48]  do_syscall_64+0xf2/0x690
[  247.676882] [     T48]  ? rcu_read_unlock+0x1c/0x60
[  247.677268] [     T48]  ? handle_mm_fault+0x35f/0x660
[  247.677608] [     T48]  ? rcu_is_watching+0x12/0xb0
[  247.677952] [     T48]  ? lock_release+0x285/0x340
[  247.678315] [     T48]  ? rcu_is_watching+0x12/0xb0
[  247.678667] [     T48]  ? do_user_addr_fault+0x52e/0xaf0
[  247.679008] [     T48]  ? rcu_is_watching+0x12/0xb0
[  247.679350] [     T48]  ? do_syscall_64+0x2d/0x690
[  247.679690] [     T48]  ? trace_hardirqs_off_finish+0x139/0x180
[  247.680034] [     T48]  ? trace_hardirqs_off+0x14f/0x1a0
[  247.680369] [     T48]  ? do_syscall_64+0x60/0x690
[  247.680690] [     T48]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[  247.681055] [     T48] RIP: 0033:0x7f1cae0a073d
[  247.681399] [     T48] RSP: 002b:00007f1ca7ffedd0 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
[  247.681773] [     T48] RAX: ffffffffffffffda RBX: 0000000000000200 RCX: 00007f1cae0a073d
[  247.682088] [     T48] RDX: 00007f1ca7ffee3c RSI: 0000000040081271 RDI: 0000000000000003
[  247.682386] [     T48] RBP: 00007f1ca7ffee20 R08: 0000000000000000 R09: 00007f1ca7fff6c0
[  247.682710] [     T48] R10: 0000000000000008 R11: 0000000000000246 R12: 0000000000000021
[  247.683016] [     T48] R13: 00007fff0eee6540 R14: 0000000000000000 R15: 00007fff0eee6647
[  247.683330] [     T48]  </TASK>
[  247.683643] [     T48] INFO: task dio-fallback-ra:1092 is blocked on an rw-semaphore, but the owner is not found.
[  247.683985] [     T48] INFO: lockdep is turned off.
[  370.473396] [     T48] INFO: task dio-fallback-ra:1088 blocked for more than 245 seconds.
[  370.475679] [     T48]       Not tainted 7.3.0-rc2+ #715
[  370.477650] [     T48] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
[  370.479255] [     T48] task:dio-fallback-ra state:D stack:0     pid:1088  tgid:1087  ppid:1042   task_flags:0x400040 flags:0x00080000
[  370.479690] [     T48] Call Trace:
[  370.480085] [     T48]  <TASK>
[  370.480454] [     T48]  __schedule+0x1fcc/0x6ef0
[  370.480892] [     T48]  ? asm_sysvec_apic_timer_interrupt+0x16/0x20
[  370.481241] [     T48]  ? trace_hardirqs_on+0x14/0x190
[  370.481575] [     T48]  ? __pfx___schedule+0x10/0x10
[  370.481956] [     T48]  ? lock_acquire+0x2f5/0x340
[  370.482329] [     T48]  ? lock_acquire+0x2f5/0x340
[  370.482679] [     T48]  ? rcu_is_watching+0x12/0xb0
[  370.483565] [     T48]  ? lock_release+0x285/0x340
[  370.483890] [     T48]  schedule+0xe3/0x2e0
[  370.484268] [     T48]  ? rwsem_down_read_slowpath+0x31e/0x10d0
[  370.484619] [     T48]  schedule_preempt_disabled+0x14/0x30
[  370.484939] [     T48]  rwsem_down_read_slowpath+0x61a/0x10d0
[  370.485317] [     T48]  ? __pfx_rwsem_down_read_slowpath+0x10/0x10
[  370.485683] [     T48]  ? __pfx___might_resched+0x10/0x10
[  370.486011] [     T48]  down_read+0xfa/0x540
[  370.486382] [     T48]  ? __pfx_down_read+0x10/0x10
[  370.486738] [     T48]  ? filemap_check_errors+0x58/0x100
[  370.487087] [     T48]  blkdev_write_iter+0x928/0xf40
[  370.487701] [     T48]  do_iter_readv_writev+0x48a/0xb80
[  370.488224] [     T48]  ? __pfx_folio_add_lru_vma+0x10/0x10
[  370.488586] [     T48]  ? rcu_read_unlock+0x1c/0x60
[  370.488912] [     T48]  ? __folio_mod_stat+0x4c/0x190
[  370.489301] [     T48]  ? __pfx_do_iter_readv_writev+0x10/0x10
[  370.489661] [     T48]  ? folio_add_new_anon_rmap+0x34f/0xd40
[  370.490161] [     T48]  ? selinux_file_permission+0x3c0/0x530
[  370.490543] [     T48]  ? security_file_permission+0x44/0xc0
[  370.490874] [     T48]  ? rw_verify_area+0x77/0x650
[  370.491273] [     T48]  vfs_writev+0x27d/0xbc0
[  370.491634] [     T48]  ? __pfx_vfs_writev+0x10/0x10
[  370.491964] [     T48]  ? __handle_mm_fault+0x1584/0x1fb0
[  370.492350] [     T48]  ? lock_acquire+0x1b1/0x340
[  370.492713] [     T48]  ? __fget_files+0x1d8/0x440
[  370.493068] [     T48]  ? do_pwritev+0x18a/0x300
[  370.493440] [     T48]  do_pwritev+0x18a/0x300
[  370.493812] [     T48]  ? __pfx_do_pwritev+0x10/0x10
[  370.494186] [     T48]  ? lock_release+0x1b5/0x340
[  370.494532] [     T48]  ? rcu_is_watching+0x12/0xb0
[  370.494844] [     T48]  do_syscall_64+0xf2/0x690
[  370.495208] [     T48]  ? do_syscall_64+0x2d/0x690
[  370.495547] [     T48]  ? trace_hardirqs_off_finish+0x139/0x180
[  370.495856] [     T48]  ? lockdep_hardirqs_off+0xaf/0xf0
[  370.496326] [     T48]  ? do_syscall_64+0x60/0x690
[  370.496639] [     T48]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[  370.496933] [     T48] RIP: 0033:0x7f1cae028e32
[  370.497283] [     T48] RSP: 002b:00007f1cadf98d98 EFLAGS: 00000246 ORIG_RAX: 0000000000000128
[  370.497644] [     T48] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f1cae028e32
[  370.497965] [     T48] RDX: 0000000000000002 RSI: 00007f1cadf98e20 RDI: 0000000000000004
[  370.498308] [     T48] RBP: 00007f1cadf98dc0 R08: 0000000000000000 R09: 0000000000000000
[  370.498614] [     T48] R10: 0000000000000000 R11: 0000000000000246 R12: 00007f1ca8001000
[  370.498891] [     T48] R13: 00007fff0eee6560 R14: 0000000000000000 R15: 00007fff0eee6667
[  370.499233] [     T48]  </TASK>
[  370.499539] [     T48] INFO: task dio-fallback-ra:1088 is blocked on an rw-semaphore, but the owner is not found.
[  370.499833] [     T48] INFO: task dio-fallback-ra:1089 blocked for more than 245 seconds.
[  370.500182] [     T48]       Not tainted 7.3.0-rc2+ #715
[  370.500541] [     T48] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
[  370.500849] [     T48] task:dio-fallback-ra state:D stack:0     pid:1089  tgid:1087  ppid:1042   task_flags:0x400040 flags:0x00080000
[  370.501230] [     T48] Call Trace:
[  370.501622] [     T48]  <TASK>
[  370.501970] [     T48]  __schedule+0x1fcc/0x6ef0
[  370.502371] [     T48]  ? __pfx_bio_wait_end_io+0x10/0x10
[  370.502711] [     T48]  ? __pfx___schedule+0x10/0x10
[  370.503052] [     T48]  ? lock_acquire+0x2f5/0x340
[  370.503416] [     T48]  ? lock_acquire+0x2f5/0x340
[  370.503759] [     T48]  ? rcu_is_watching+0x12/0xb0
[  370.504097] [     T48]  ? lock_release+0x285/0x340
[  370.504437] [     T48]  schedule+0xe3/0x2e0
[  370.504776] [     T48]  ? rwsem_down_read_slowpath+0x31e/0x10d0
[  370.505113] [     T48]  schedule_preempt_disabled+0x14/0x30
[  370.505480] [     T48]  rwsem_down_read_slowpath+0x61a/0x10d0
[  370.505841] [     T48]  ? __pfx_rwsem_down_read_slowpath+0x10/0x10
[  370.506224] [     T48]  ? blkdev_direct_IO+0x86f/0x1c50
[  370.506576] [     T48]  ? __pfx___might_resched+0x10/0x10
[  370.506938] [     T48]  down_read+0xfa/0x540
[  370.507302] [     T48]  ? __pfx_down_read+0x10/0x10
[  370.507653] [     T48]  ? filemap_check_errors+0x58/0x100
[  370.508052] [     T48]  blkdev_write_iter+0x882/0xf40
[  370.508582] [     T48]  do_iter_readv_writev+0x48a/0xb80
[  370.509013] [     T48]  ? vfs_writev+0x831/0xbc0
[  370.509401] [     T48]  ? __pfx_do_iter_readv_writev+0x10/0x10
[  370.510181] [     T48]  ? selinux_file_permission+0x3c0/0x530
[  370.510538] [     T48]  ? security_file_permission+0x44/0xc0
[  370.510887] [     T48]  ? rw_verify_area+0x77/0x650
[  370.511266] [     T48]  vfs_writev+0x27d/0xbc0
[  370.511627] [     T48]  ? __pfx_vfs_writev+0x10/0x10
[  370.511948] [     T48]  ? __fget_files+0x4f/0x440
[  370.512325] [     T48]  ? __fget_files+0x1d8/0x440
[  370.512676] [     T48]  ? do_pwritev+0x18a/0x300
[  370.512990] [     T48]  do_pwritev+0x18a/0x300
[  370.513356] [     T48]  ? __pfx_do_pwritev+0x10/0x10
[  370.513701] [     T48]  ? lock_release+0x1b5/0x340
[  370.514036] [     T48]  ? rcu_is_watching+0x12/0xb0
[  370.514376] [     T48]  do_syscall_64+0xf2/0x690
[  370.514724] [     T48]  ? rcu_read_unlock+0x17/0x60
[  370.515060] [     T48]  ? lock_release+0x1b5/0x340
[  370.515392] [     T48]  ? __handle_mm_fault+0x1584/0x1fb0
[  370.515725] [     T48]  ? __lock_acquire+0x54a/0x2490
[  370.516047] [     T48]  ? __pfx___css_rstat_updated+0x10/0x10
[  370.516374] [     T48]  ? lock_acquire+0x1b1/0x340
[  370.516712] [     T48]  ? rcu_is_watching+0x12/0xb0
[  370.517009] [     T48]  ? count_memcg_events+0x107/0x4c0
[  370.517347] [     T48]  ? find_held_lock+0x2b/0x80
[  370.517661] [     T48]  ? rcu_read_unlock+0x17/0x60
[  370.517937] [     T48]  ? lock_release+0x1b5/0x340
[  370.518259] [     T48]  ? find_held_lock+0x2b/0x80
[  370.518555] [     T48]  ? exc_page_fault+0x94/0x140
[  370.518810] [     T48]  ? lock_release+0x1b5/0x340
[  370.519079] [     T48]  ? rcu_is_watching+0x12/0xb0
[  370.519384] [     T48]  ? do_syscall_64+0x2d/0x690
[  370.519662] [     T48]  ? trace_hardirqs_off_finish+0x139/0x180
[  370.519911] [     T48]  ? lockdep_hardirqs_off+0xaf/0xf0
[  370.520212] [     T48]  ? do_syscall_64+0x60/0x690
[  370.520493] [     T48]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[  370.520750] [     T48] RIP: 0033:0x7f1cae028e32
[  370.521009] [     T48] RSP: 002b:00007f1cad797d98 EFLAGS: 00000246 ORIG_RAX: 0000000000000128
[  370.521333] [     T48] RAX: ffffffffffffffda RBX: 0000000000004000 RCX: 00007f1cae028e32
[  370.521635] [     T48] RDX: 0000000000000002 RSI: 00007f1cad797e20 RDI: 0000000000000005
[  370.521908] [     T48] RBP: 00007f1cad797dc0 R08: 0000000000000000 R09: 0000000000000000
[  370.522230] [     T48] R10: 0000000000004000 R11: 0000000000000246 R12: 00007f1c9c001000
[  370.522540] [     T48] R13: 00007fff0eee6560 R14: 0000000000000000 R15: 00007fff0eee6667
[  370.522815] [     T48]  </TASK>
[  370.523114] [     T48] INFO: task dio-fallback-ra:1089 is blocked on an rw-semaphore, but the owner is not found.
[  370.523427] [     T48] INFO: task dio-fallback-ra:1091 blocked for more than 245 seconds.
[  370.523746] [     T48]       Not tainted 7.3.0-rc2+ #715
[  370.524053] [     T48] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
[  370.524380] [     T48] task:dio-fallback-ra state:D stack:0     pid:1091  tgid:1087  ppid:1042   task_flags:0x400040 flags:0x00080000
[  370.524727] [     T48] Call Trace:
[  370.525060] [     T48]  <TASK>
[  370.525391] [     T48]  __schedule+0x1fcc/0x6ef0
[  370.525728] [     T48]  ? blk_stat_add+0xbc/0x450
[  370.526058] [     T48]  ? rcu_is_watching+0x12/0xb0
[  370.526390] [     T48]  ? lock_release+0x285/0x340
[  370.526725] [     T48]  ? percpu_ref_put_many.constprop.0+0x39/0x1d0
[  370.527058] [     T48]  ? __pfx___schedule+0x10/0x10
[  370.527393] [     T48]  ? lock_acquire+0x2f5/0x340
[  370.527731] [     T48]  ? lock_acquire+0x2f5/0x340
[  370.528063] [     T48]  ? rcu_is_watching+0x12/0xb0
[  370.528396] [     T48]  ? lock_release+0x285/0x340
[  370.528737] [     T48]  schedule+0xe3/0x2e0
[  370.529061] [     T48]  ? rwsem_down_read_slowpath+0x31e/0x10d0
[  370.529483] [     T48]  schedule_preempt_disabled+0x14/0x30
[  370.529840] [     T48]  rwsem_down_read_slowpath+0x61a/0x10d0
[  370.530206] [     T48]  ? __pfx_rwsem_down_read_slowpath+0x10/0x10
[  370.530590] [     T48]  ? blk_mq_dispatch_queue_requests+0x51a/0x7e0
[  370.530905] [     T48]  ? blk_mq_dispatch_queue_requests+0x576/0x7e0
[  370.531290] [     T48]  ? __pfx_folio_batch_move_lru+0x10/0x10
[  370.531649] [     T48]  ? __pfx___might_resched+0x10/0x10
[  370.531992] [     T48]  down_read+0xfa/0x540
[  370.532351] [     T48]  ? __pfx_down_read+0x10/0x10
[  370.532693] [     T48]  ? __blk_flush_plug+0x29f/0x540
[  370.533008] [     T48]  ? selinux_file_permission+0x3c0/0x530
[  370.533367] [     T48]  ? security_file_permission+0x44/0xc0
[  370.533712] [     T48]  blkdev_read_iter+0x15a/0x4e0
[  370.534047] [     T48]  ? rw_verify_area+0x77/0x650
[  370.534389] [     T48]  vfs_read+0x6f4/0xb30
[  370.534704] [     T48]  ? blk_finish_plug+0x52/0xc0
[  370.535042] [     T48]  ? __pfx_vfs_read+0x10/0x10
[  370.535417] [     T48]  ? lock_release+0x285/0x340
[  370.535765] [     T48]  __x64_sys_pread64+0x18d/0x250
[  370.536104] [     T48]  ? __pfx___x64_sys_pread64+0x10/0x10
[  370.536520] [     T48]  ? rcu_is_watching+0x12/0xb0
[  370.536857] [     T48]  ? rcu_is_watching+0x12/0xb0
[  370.537224] [     T48]  ? do_syscall_64+0x7f/0x690
[  370.537532] [     T48]  do_syscall_64+0xf2/0x690
[  370.537834] [     T48]  ? force_page_cache_ra+0x21c/0x370
[  370.538191] [     T48]  ? generic_fadvise+0x35c/0x660
[  370.538522] [     T48]  ? __pfx_generic_fadvise+0x10/0x10
[  370.538817] [     T48]  ? rcu_is_watching+0x12/0xb0
[  370.539139] [     T48]  ? lock_release+0x285/0x340
[  370.539459] [     T48]  ? __fget_files+0x1d8/0x440
[  370.539778] [     T48]  ? fput+0x1b/0xa0
[  370.540079] [     T48]  ? fput+0x48/0xa0
[  370.540375] [     T48]  ? rcu_is_watching+0x12/0xb0
[  370.540671] [     T48]  ? do_syscall_64+0x1ff/0x690
[  370.540931] [     T48]  ? trace_hardirqs_on_prepare+0x139/0x180
[  370.541234] [     T48]  ? do_syscall_64+0x21d/0x690
[  370.541509] [     T48]  ? vfs_read+0x3b6/0xb30
[  370.541753] [     T48]  ? vfs_read+0x3b6/0xb30
[  370.541994] [     T48]  ? lock_acquire+0x1b1/0x340
[  370.542289] [     T48]  ? __pfx_vfs_read+0x10/0x10
[  370.542564] [     T48]  ? __fget_files+0x1ce/0x440
[  370.542806] [     T48]  ? lock_release+0x1b5/0x340
[  370.543070] [     T48]  ? fput+0x1b/0xa0
[  370.543333] [     T48]  ? fput+0x48/0xa0
[  370.543607] [     T48]  ? __x64_sys_pread64+0x1ad/0x250
[  370.543878] [     T48]  ? __pfx___x64_sys_pread64+0x10/0x10
[  370.544144] [     T48]  ? rcu_is_watching+0x12/0xb0
[  370.544442] [     T48]  ? do_syscall_64+0x1ff/0x690
[  370.544681] [     T48]  ? trace_hardirqs_on_prepare+0x139/0x180
[  370.544922] [     T48]  ? do_syscall_64+0x21d/0x690
[  370.545210] [     T48]  ? rcu_is_watching+0x12/0xb0
[  370.545480] [     T48]  ? do_syscall_64+0x2d/0x690
[  370.545714] [     T48]  ? trace_hardirqs_off_finish+0x139/0x180
[  370.545949] [     T48]  ? lockdep_hardirqs_off+0xaf/0xf0
[  370.546249] [     T48]  ? do_syscall_64+0x60/0x690
[  370.546517] [     T48]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[  370.546757] [     T48] RIP: 0033:0x7f1cae028e32
[  370.546995] [     T48] RSP: 002b:00007f1ca45fedc8 EFLAGS: 00000246 ORIG_RAX: 0000000000000011
[  370.547300] [     T48] RAX: ffffffffffffffda RBX: 0000000000002000 RCX: 00007f1cae028e32
[  370.547627] [     T48] RDX: 0000000000002000 RSI: 00007f1c94000880 RDI: 0000000000000006
[  370.547912] [     T48] RBP: 00007f1ca45fedf0 R08: 0000000000000000 R09: 0000000000000000
[  370.548218] [     T48] R10: 0000000000002000 R11: 0000000000000246 R12: 00007f1c94000880
[  370.548506] [     T48] R13: 00007fff0eee6540 R14: 0000000000000000 R15: 00007fff0eee6647
[  370.548766] [     T48]  </TASK>
[  370.549041] [     T48] INFO: task dio-fallback-ra:1091 is blocked on an rw-semaphore, but the owner is not found.
[  370.549342] [     T48] INFO: task dio-fallback-ra:1092 blocked for more than 245 seconds.
[  370.549635] [     T48]       Not tainted 7.3.0-rc2+ #715
[  370.549985] [     T48] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
[  370.550319] [     T48] task:dio-fallback-ra state:D stack:0     pid:1092  tgid:1087  ppid:1042   task_flags:0x400140 flags:0x00080000
[  370.550642] [     T48] Call Trace:
[  370.550994] [     T48]  <TASK>
[  370.551339] [     T48]  __schedule+0x1fcc/0x6ef0
[  370.551672] [     T48]  ? rcu_is_watching+0x12/0xb0
[  370.552022] [     T48]  ? __pfx___schedule+0x10/0x10
[  370.552349] [     T48]  ? lock_acquire+0x2f5/0x340
[  370.552708] [     T48]  ? lock_acquire+0x2f5/0x340
[  370.553001] [     T48]  ? rcu_is_watching+0x12/0xb0
[  370.553342] [     T48]  ? lock_release+0x285/0x340
[  370.553667] [     T48]  schedule+0xe3/0x2e0
[  370.553961] [     T48]  ? _raw_spin_unlock_irq+0x34/0x50
[  370.554330] [     T48]  schedule_preempt_disabled+0x14/0x30
[  370.554645] [     T48]  rwsem_down_write_slowpath+0x4b3/0x1830
[  370.554949] [     T48]  ? __pfx_rwsem_down_write_slowpath+0x10/0x10
[  370.555308] [     T48]  ? rcu_is_watching+0x12/0xb0
[  370.555643] [     T48]  ? lock_release+0x285/0x340
[  370.555943] [     T48]  ? __pfx___mutex_lock+0x10/0x10
[  370.556300] [     T48]  ? __pfx___might_resched+0x10/0x10
[  370.556639] [     T48]  down_write+0x1be/0x1f0
[  370.556974] [     T48]  ? __pfx_down_write+0x10/0x10
[  370.557328] [     T48]  ? bdev_open+0x90c/0xc60
[  370.557667] [     T48]  set_blocksize+0x1ad/0x460
[  370.557975] [     T48]  ? bdev_file_open_by_dev+0xe6/0x170
[  370.558335] [     T48]  blkdev_bszset+0x142/0x1e0
[  370.558678] [     T48]  ? __pfx_blkdev_bszset+0x10/0x10
[  370.558991] [     T48]  ? lock_acquire+0x2f5/0x340
[  370.559374] [     T48]  ? rcu_is_watching+0x12/0xb0
[  370.559701] [     T48]  blkdev_ioctl+0x4e9/0x5e0
[  370.560016] [     T48]  ? __pfx_blkdev_ioctl+0x10/0x10
[  370.560411] [     T48]  __x64_sys_ioctl+0x138/0x1c0
[  370.560754] [     T48]  do_syscall_64+0xf2/0x690
[  370.561086] [     T48]  ? rcu_read_unlock+0x1c/0x60
[  370.561424] [     T48]  ? handle_mm_fault+0x35f/0x660
[  370.561767] [     T48]  ? rcu_is_watching+0x12/0xb0
[  370.562100] [     T48]  ? lock_release+0x285/0x340
[  370.562451] [     T48]  ? rcu_is_watching+0x12/0xb0
[  370.562806] [     T48]  ? do_user_addr_fault+0x52e/0xaf0
[  370.563149] [     T48]  ? rcu_is_watching+0x12/0xb0
[  370.563471] [     T48]  ? do_syscall_64+0x2d/0x690
[  370.563765] [     T48]  ? trace_hardirqs_off_finish+0x139/0x180
[  370.564087] [     T48]  ? trace_hardirqs_off+0x14f/0x1a0
[  370.564406] [     T48]  ? do_syscall_64+0x60/0x690
[  370.564729] [     T48]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[  370.565044] [     T48] RIP: 0033:0x7f1cae0a073d
[  370.565358] [     T48] RSP: 002b:00007f1ca7ffedd0 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
[  370.565679] [     T48] RAX: ffffffffffffffda RBX: 0000000000000200 RCX: 00007f1cae0a073d
[  370.565968] [     T48] RDX: 00007f1ca7ffee3c RSI: 0000000040081271 RDI: 0000000000000003
[  370.566311] [     T48] RBP: 00007f1ca7ffee20 R08: 0000000000000000 R09: 00007f1ca7fff6c0
[  370.566623] [     T48] R10: 0000000000000008 R11: 0000000000000246 R12: 0000000000000021
[  370.566897] [     T48] R13: 00007fff0eee6540 R14: 0000000000000000 R15: 00007fff0eee6647
[  370.567218] [     T48]  </TASK>
[  370.567514] [     T48] INFO: task dio-fallback-ra:1092 is blocked on an rw-semaphore, but the owner is not found.
[  370.567808] [     T48] INFO: lockdep is turned off.
