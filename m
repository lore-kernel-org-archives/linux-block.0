Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64F9B14883F
	for <linux-block@vger.kernel.org>; Thu,  4 Jun 2026 06:03:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.154.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780552999; cv=fail; b=raRA2mcxsM9+9jbKZgDFASh3MUK/oxHpgQ+cmGQl6YzrdfumWEZblsMZWnOopzmd2yaVtGl+R8vG0IjrVA0bAuuazoHUDxqyEbIVdlrXsu6Ul6da0ozX/VRnByIdy498Su3l5RC6WJJnuuZtHNwW09Q9x1ljy9ApoTh7etZgSog=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780552999; c=relaxed/simple;
	bh=6nSnqn0rEHEJac0Gbbj8+mHG9aFGH6tOih/lj0g/p/E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=X/e+g00XOc88hlB5vwR0nNb8/g671moJbZKYeG3nqOarGs7WNtZRMhBinKnr/49vA0VHaaAB9G51NMBhXL7+Z4d9RoLZZRAD2FDF6Zaml4qCuP5hmlduS6PkQWL28qreIevwaVlIZpqZ6DytJYURD9mdmGRLmUUqh2VumfV0tjI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=FK/UoCAw; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=PLonsHPL; arc=fail smtp.client-ip=216.71.154.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="FK/UoCAw";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="PLonsHPL"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1780552995; x=1812088995;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=6nSnqn0rEHEJac0Gbbj8+mHG9aFGH6tOih/lj0g/p/E=;
  b=FK/UoCAw0y+vTEDG4/yOCPaK/rToM0P/LNqZUq+JEk6gSjmFuNGE12qa
   3kvaiNqO+UDZlCZNwOxXuR64dhHsE2F9m2GJWfkQPMRDHmu86lhWIQJcC
   6HjajvPk0rr+4u6LIfYOboNb3nwwOOaUSo5vmOK3iGimLcPyegFJXw54x
   OFid4ViYPgyyPpqO23NAfb1HoZMj4Eo37OFhdzP+upyBH4DyWezTHWag9
   2GOTO2KciVgCktEi328ntTayZ00cU3oz7apkwGKMZa+VSqY1cv61QRT2g
   vi57qLm/Sr8+HLAPp7G+FV2B3pVAfCEk7+c4r7qG3ooeYu5qk4HamJzvk
   A==;
X-CSE-ConnectionGUID: GvwaYPqjRYWS3J27TG8E2Q==
X-CSE-MsgGUID: dfavOBelRrijltcBw+y29g==
X-IronPort-AV: E=Sophos;i="6.24,186,1774281600"; 
   d="scan'208";a="144271814"
Received: from mail-westcentralusazon11013056.outbound.protection.outlook.com (HELO CY3PR05CU001.outbound.protection.outlook.com) ([40.93.201.56])
  by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 04 Jun 2026 14:03:08 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xaf1cQuSghuGjr1RblZ+sL7p5buSP5cRfDXh4oDp1nDmLWTHIQpJz+ydGfgSEe+EpXOZ2nP6Lm/RxWsmmeTNt2/a2snLllw9wlPSM/KbHlepj/d3GXKwV319pM5GNxBp5qKCHiASdBok/FxaITaBd55PlKmLlI5MkHRscxT/AcYOPDsgn/pqZESl0T5/4WjfkWWePPm8Gh3vXgbCL3jeW2rmvoz98oub6qRmFCbhy1QgS/VcUxCAYyl0w2Ai5/Ub4Fxs+Q1Z7KuaM+JyDyzImZ6ZQ0JHF9NM3C/om01HFd5En86dYVOKc6PaTn1/3u39iQ/aKdISs+TfMCwlJS0Gng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0Pdzp/UVFEfAeMSgFFolUf3t2SSmDlkD+sE6YFEuxls=;
 b=Wa4URcaEcNzM3LbgMdE0h00Y6VY03ZFCWloqzThhgrVjRpDKqx+RWQq0q8v2aVxxzLmm17sZbNddZE7npq2SRoMikP+IZsfjik6pv7jdH3ycuEZO7cA0R7a/nCgFx6vk3sQpC3SzRnZTVzyQS7PsaWq0n9iZOYMXuMeR7dZUQpZYIivQyrzYZaARe2NdrnNi6YYKOvZwxWkhdSJT/m7Umy97CHMMDdMgv3PAq40fPwkVQpayc+A4KlyFnHuhkOH5zRPiHYVX8At/GYJPidAiPqoUvgfFLaBI6je7C1YQ3L2+YJNL8r/YIUtWYj6LKH841T8sDG/zYRhImruX0EGWkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0Pdzp/UVFEfAeMSgFFolUf3t2SSmDlkD+sE6YFEuxls=;
 b=PLonsHPL4iSYDbRy5Zdaaofk+EfYUbfF1ltc7tyhodi1ZumLX/a23IGpmeV8Z1fab5V8wYzV7LMonSIpNPkme/vKigjI4xLv2Qd87J+RsFrVNyghvDs8XkEux5Nzn5NXdrqSCb1sbGzsjwm2tjXYnWRzF+MSjggiMBmNkABI8O4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
Received: from SA1PR04MB10065.namprd04.prod.outlook.com
 (2603:10b6:806:4dd::14) by BL3PR04MB7993.namprd04.prod.outlook.com
 (2603:10b6:208:344::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.8; Thu, 4 Jun 2026
 06:03:06 +0000
Received: from SA1PR04MB10065.namprd04.prod.outlook.com
 ([fe80::9b98:bf8a:b0b1:ef85]) by SA1PR04MB10065.namprd04.prod.outlook.com
 ([fe80::9b98:bf8a:b0b1:ef85%6]) with mapi id 15.21.0092.006; Thu, 4 Jun 2026
 06:03:06 +0000
Date: Thu, 4 Jun 2026 15:03:00 +0900
From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: Bart Van Assche <bvanassche@acm.org>
Cc: Damien Le Moal <dlemoal@kernel.org>, linux-block@vger.kernel.org
Subject: Re: [PATCH blktests] throtl/008: Add a test for the iocost cgroup
 controller
Message-ID: <aiESTpWx0-0l9Ppj@shinmob>
References: <20260603205007.2654971-1-bvanassche@acm.org>
Content-Type: multipart/mixed; boundary="6x3rc727ktc5xxog"
Content-Disposition: inline
In-Reply-To: <20260603205007.2654971-1-bvanassche@acm.org>
X-ClientProxiedBy: TY4PR01CA0081.jpnprd01.prod.outlook.com
 (2603:1096:405:36c::19) To SA1PR04MB10065.namprd04.prod.outlook.com
 (2603:10b6:806:4dd::14)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR04MB10065:EE_|BL3PR04MB7993:EE_
X-MS-Office365-Filtering-Correlation-Id: 722b1cd0-2885-4f53-f617-08dec1fef240
WDCIPOUTBOUND: EOP-TRUE
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|6049299003|19092799006|1800799024|4013099003|4053099003|22082099003|18002099003|6133799003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	rB9vGXs7JoZjuPs6f2Lg9o30Ap88nH/I3SsOduJUm/Dpd2MWjRpJK7oVw5mx4x3yGh954e5staA9q9IPzQp+Hid1QVMzQWlyltg4oUe41w2NpRhzVebOdVSXHSPyT8goZUc/7smlsMfY0071lMvt3QJnjZWHUoQtyBZ1EMj9ft8CBKCn1GYzvy06t8uVZ2PMW/WCssKSzbTlMToAExufxPatkx5U3wZtAMDf8cp5hmnKQU9y4LBAeWKY/hgzJRESYykQSz0b26zDdQuO6fVAxg5Ew8OmyT1DrRhii8jL3oJCz1FBE+FQK3e1ZmyU8nywYlcERT2KscJm1JmNv1ez7LilVlntRHvc4TTx3mRXJqjrNjzMtxsZ92Mt5Gti6U5mYDKfZ5qegvWAwc7uPR0ru67/LZ6EQqmDrhM1JsvKnhfr65sHY+Xm4GZJHfZCu1stvyfWECEFR3VPhCMWpfJ/5ZRL8s+IsiVtBJZbUhDIBvh0In7+BGT7ulbX91XKt79gaz7klci0meUEGia8DJiYz/lxqd6m61n7yVNg5qqhnAdE9AXyh5mcmfDhYgqi1++gdLJyeXPmIgCU0jHB8CSIrLPKoE5UHFnknZCrEZns2eN1Q9wZpGs1PCzVEBK2GInQYYFfHma3ZYNHt3WsTtbz8zDI7DLuawdHc+fZ8osDGJkWW5tQipKzhKUq+WsuWYgv
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR04MB10065.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(6049299003)(19092799006)(1800799024)(4013099003)(4053099003)(22082099003)(18002099003)(6133799003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?IiwGPnY2lKv9BNh6ZG9zErBmz7G4OrHON7b4oBfgtUR25avgG37zyE73dxgi?=
 =?us-ascii?Q?l5bSLiE02Jv4uGjlagjqF24ywzxN2lxdjjdmzGvwcoHb3d7mxUHboX+JPHsa?=
 =?us-ascii?Q?9JMBVD+cinx2+P1s/dPn+wiKlg88p3CjeHfb02u7yXQYg7iUyMzi1EttrNEV?=
 =?us-ascii?Q?4SpX/tK9nZFaXTXoprztLVLdpoRAy7wWyja+PGk1mkan7aGAu1UGjLWApaNw?=
 =?us-ascii?Q?n+baixcKQhgA7oeHKsbqYti3g8gOTVAWtn4FH7j3qOEz2sl3G0RXQqllESwu?=
 =?us-ascii?Q?leA2ZIQxJnIjgSg3AwboEB6XaH6FkArSdFBoEGY8ZrSPZhoxll1oPyny5+JB?=
 =?us-ascii?Q?frMPPagmd1c5ZlX+HGUBB18jOgHraN1ZdUm+hQfBWITwX5W2+fM3DEmPNXZa?=
 =?us-ascii?Q?CDrC5Rqt8GYSLhFIpq/Pip6slKQ+d1YQppVCb9OkoZXXRZWS303uc5OFrmE+?=
 =?us-ascii?Q?SlvwsaWl01gyl9io1Us6n2/HC7eo7wpODzKCdfbXU0RP6mMiwHRE1uEl6Eq/?=
 =?us-ascii?Q?wsmUyK+oAklPjF8wTkFK6U7bJ1XTlyyEeQ8C5wNh5k7mTdT+Ww9S6biSmuNT?=
 =?us-ascii?Q?agshr8L+bBAvAk7Bo3zqmc9fw/ca9G1ENHSgictjipEqWsTkFUYm+cBoi4S3?=
 =?us-ascii?Q?xVCBNAvmgVDKaGWAeylq+4S1/uiUKAJ+K8ZFyPm9FZEH4tVToUsRWcotBN+j?=
 =?us-ascii?Q?qqn9ozysY8OwGmRTseXw/7MLeOCqunpBvBCU1Baiw0kSBzY9H+bAva1eU0py?=
 =?us-ascii?Q?AjAN+tzOjAslhPOKH0BQkhADi3wN4VkaMcRrNcVu96PFkr9oafkJThiU3KTO?=
 =?us-ascii?Q?fW+DWHBVMQY9ieigbxGHzUBhWQZqMbA+hGv6sPv2Q5BMx+YtU1XWrAByZNDL?=
 =?us-ascii?Q?clH2dY/16Y2w7Fjz0S5inT5xXhrMdhmH3d4zFKjYZV6Uf3FMbrblgm6TPVfI?=
 =?us-ascii?Q?Zi49W3YYSn2EOwPoSgoIINq8PI1gdIlW0rbzFgRBSV8WwXiN+tQ9wwSnFjPs?=
 =?us-ascii?Q?obb9mT35dNngFe4ke7JM10CoeyDp0BtKOGUOkMiDitRDrwItQkYY01PMzD4A?=
 =?us-ascii?Q?A/HgFrn9lISIO5giWWSJKfGSfOEY/482nVQTjv9GNVKhf+HnlQ3RjVAjLPbX?=
 =?us-ascii?Q?aUJTF5KY1IC86z8lnY1KPVTfaiWsVsRp1cMwTB4UWiu0bP29g6owvPXBPDGz?=
 =?us-ascii?Q?AK8eIto+8eMwtUpYOgmj8kIHFu6tVWOjK1/W0ts/jyLkxX9ESoLpw21c9Uqt?=
 =?us-ascii?Q?UyvKCMUvwdDRI9vZSTsrUi1FllWUvyH+kewKEDs80trllgNsa3gNXkekIZL7?=
 =?us-ascii?Q?zLvaCbUcHvDbYczm1L/rr4pKc0SH4Q67woJC1y8IlYTedsSpFcs/gtpU1R4r?=
 =?us-ascii?Q?Uaf8bZSlPoY9Ua1AmZxLNiGD3Sk+RuuFgOt0PNoj0XfcI/126J9hkmx5mmer?=
 =?us-ascii?Q?f6t88xo1dY5D1fw9d5MM71OH9gcLfaMHP7PbYOj8/eUrFhWDYNuNbll9eQb1?=
 =?us-ascii?Q?HxdEUOCze2DPvoM+z47LdpsurR60bZVaxHuYwa8RTSv0XgSet84IyejEJfS9?=
 =?us-ascii?Q?9xIw+pD/sfIBxgiqFYTkXaLLA+n5gT/8BhF/nFRcS3BI+HkA1EfXv/2zNgE+?=
 =?us-ascii?Q?LAR/9v8VLQTwv51f3Wf/vjaqhiA50mvT6ertVAQstQwyMGdiB94Ny6OL5gYS?=
 =?us-ascii?Q?ju/lZ6nIUDQXFfx8NsvfozVgRF9PUb7F9bN3NywmaR+pd90h6jfHVmrniuLM?=
 =?us-ascii?Q?gDRXpk5qPmt0aLQImFlN7wK9tK8ms9Y=3D?=
X-Exchange-RoutingPolicyChecked:
	nIVaiOZwa0q//y3kPSlLGM+67xRQj/S3lXqGN1kJtt4taIF2DwuIUsOD+CCmB4xJ5Gpf5NB1LihTWfOR4BXOgi8LLVIbppV2VtEJcn9ileAbO4qDc/ol+MJ+apoj4ZJeMsZT+UktXhxQ9ryes7zfdQHU3qQSt0g5K8h/aLg+Jj0iLxkdcdoXlgcElCc4eztW3dzNQcElRSX7lrIgA2wKBz0R6tYlPA2bhD82CI/BGlu3IZbl875KNSSp3tNrlCSm86GX5elXGukGGFAlo/PJSHiVal48FyTfvT90UyCQMa//RmA1didZFRyf/apHDfxO4jDFvWW4j9tZmVBsCKkxZw==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	MJI6BRlakUDtieJNVAgio8vE0jzSZxMMw7pgypt6Cgj8C2TKY2jptfQKrSJm+Rg73dBFRtKCUNpHSN+hQJajW3FP5S6eBD+n1Pvh2Z6Gt0ANX1V2SOu9UE8uICB/u2dIMBT2aqVK8YS2mc2L5sLsdvWK3GUa7Z5R8fIKh3wKgXIvbqaVSSWftMqkgrnmqOEEAdxKKBYcgnLXuV5xklMAAO1kDKIb8ftuFuAauIZNGyxRbkm4LKhKRznTQNlQhNAlYbE8jyZ3wWgxjlpb7irq4raqqHD7WctsMWCdJTyYs4kziWOeufPYsBFcD3kvznxsmWi7V58l7EWnowIWgO2SjXthh2VJUcgWQhNP6u9HdRvM3dQrOcd8k21bClCMkvYfr6P8+yf+dpF5NZB+fxT1nzFIFKlQ3Iai7SPK4llpB8PVmldcXz9CIdZnoYg8d8C1bLj2JsYmIPjb+1fn46Qbdw8LmZmmbqmB+46NxcA4n05WdC8DoP7xC8AtxciOMquTzyoU2jJi3IY2ZE6fyuuOjQF7hzF6GfDfpOChdZE63rmi5AeBsSG6BcWYXFyCjsx6hvitg5mIvFDD7AbF4uwDELPWh452I7QkfER3oQ3EitUUkZShAfzozwUkD/7OcjDl
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 722b1cd0-2885-4f53-f617-08dec1fef240
X-MS-Exchange-CrossTenant-AuthSource: SA1PR04MB10065.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2026 06:03:06.4336
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WzckUShcjmXP6PQmhO3BXqhVpf68PBknAe6lA15ZwvM6nhky0PrB/TVvp2ixcOb4MlxdGNesJ4bL86lw6DbSf/qlNV5ZgWYni+hEsmLNgJc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR04MB7993

--6x3rc727ktc5xxog
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Jun 03, 2026 / 13:50, Bart Van Assche wrote:
> Add a test for read and write IOPS throttling. The test implementation
> has been generated by Antigravity and Gemini with a few manual edits.

Hi Bart, thanks for the patch. I think it's nice to add this test case to
cover the iocost controller code paths. It might be the better to note
'the iocost controller' in the commit message also. It will be consistent
with the DESCRIPTION in the test case.

> 
> Signed-off-by: Bart Van Assche <bvanassche@acm.org>
> ---
>  tests/throtl/008     | 152 +++++++++++++++++++++++++++++++++++++++++++
>  tests/throtl/008.out |   2 +
>  2 files changed, 154 insertions(+)
>  create mode 100755 tests/throtl/008
>  create mode 100644 tests/throtl/008.out
> 
> diff --git a/tests/throtl/008 b/tests/throtl/008
> new file mode 100755
> index 000000000000..0570fc0188e0
> --- /dev/null
> +++ b/tests/throtl/008
> @@ -0,0 +1,152 @@
> +#!/bin/bash
> +# SPDX-License-Identifier: GPL-3.0+
> +# Copyright (C) 2026 Google LLC
> +#
> +# Test cgroup iocost IOPS limiting.
> +
> +. tests/block/rc

I guess this should be tests/throtl/rc. With this, the two lines below will not
be required.

> +. common/null_blk
> +. common/cgroup
> +. common/fio
> +
> +DESCRIPTION="test cgroup iocost controller limits"
> +
> +requires() {
> +	_have_cgroup2_controller io
> +	_have_null_blk
> +	_have_fio
> +	_have_program bc

group_require() in tsts/throtl/rc covers the 3 lines out of the 4 lines above.

> +	if [[ ! -e "$(_cgroup2_base_dir)/io.cost.qos" ]]; then
> +		SKIP_REASONS+=("iocost controller not supported (CONFIG_BLK_CGROUP_IOCOST)")
> +		return 1
> +	fi
> +}
> +
> +test() {
> +	echo "Running ${TEST_NAME}"
> +
> +	# Create a null_blk instance
> +	local null_blk_params=(
> +		blocksize=4096
> +		completion_nsec=0
> +		memory_backed=0
> +		size=1024 # MB
> +		submit_queues=1
> +		power=1
> +	)
> +	_init_null_blk nr_devices=0 queue_mode=2 &&
> +	if ! _configure_null_blk nullb0 "${null_blk_params[@]}"; then
> +		echo "Configuring null_blk failed"
> +		return 1
> +	fi
> +
> +	local dev_t
> +	dev_t=$(</sys/block/nullb0/dev)
> +	if [[ -z $dev_t ]]; then
> +		echo "Failed to get major:minor for nullb0"
> +		_exit_null_blk
> +		return 1
> +	fi
> +
> +	# Initialize cgroups
> +	if ! _init_cgroup2; then
> +		echo "Initializing cgroup2 failed"
> +		_exit_null_blk
> +		return 1
> +	fi
> +
> +	# Enable io controller in the subtree
> +	local deactivate_io_ctrlr=false
> +	if ! grep -wq io "$(_cgroup2_base_dir)/cgroup.subtree_control"; then
> +		if ! echo "+io" > "$(_cgroup2_base_dir)/cgroup.subtree_control"; then
> +			echo "Failed to enable io controller on cgroup root"
> +			_exit_cgroup2
> +			_exit_null_blk
> +			return 1
> +		fi
> +		deactivate_io_ctrlr=true
> +	fi
> +
> +	if ! echo "+io" > "$CGROUP2_DIR/cgroup.subtree_control"; then
> +		echo "Failed to enable io controller on $CGROUP2_DIR"
> +		if [[ $deactivate_io_ctrlr == true ]]; then
> +			echo "-io" > "$(_cgroup2_base_dir)/cgroup.subtree_control"
> +		fi
> +		_exit_cgroup2
> +		_exit_null_blk
> +		return 1
> +	fi

The initialization part above has duplications with _set_up_throtl() in
tests/throtl/rc. Is it considered to use _set_up_throtl()? I guess it will
simplify this test case, and make it consisten with other test cases in the
throtl group. It will also allow to run the test case for scsi_debug.

I created a trial patch that applis on top of this patch, which uses
_set_up_throtl(). It is attached to this mail for your reference. It drops
some null_blk options. As far as I did trial runs, it does not look affecting
the run results.


--6x3rc727ktc5xxog
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=patch

diff --git a/tests/throtl/008 b/tests/throtl/008
index 0570fc0..b1bcf84 100755
--- a/tests/throtl/008
+++ b/tests/throtl/008
@@ -4,76 +4,36 @@
 #
 # Test cgroup iocost IOPS limiting.
 
-. tests/block/rc
-. common/null_blk
-. common/cgroup
+. tests/throtl/rc
 . common/fio
 
 DESCRIPTION="test cgroup iocost controller limits"
 
 requires() {
-	_have_cgroup2_controller io
-	_have_null_blk
 	_have_fio
-	_have_program bc
 	if [[ ! -e "$(_cgroup2_base_dir)/io.cost.qos" ]]; then
 		SKIP_REASONS+=("iocost controller not supported (CONFIG_BLK_CGROUP_IOCOST)")
 		return 1
 	fi
 }
 
+set_conditions() {
+	_set_throtl_blkdev_type "$@"
+}
+
 test() {
 	echo "Running ${TEST_NAME}"
 
-	# Create a null_blk instance
-	local null_blk_params=(
-		blocksize=4096
-		completion_nsec=0
-		memory_backed=0
-		size=1024 # MB
-		submit_queues=1
-		power=1
-	)
-	_init_null_blk nr_devices=0 queue_mode=2 &&
-	if ! _configure_null_blk nullb0 "${null_blk_params[@]}"; then
-		echo "Configuring null_blk failed"
+	# Set up throtl device and cgroup
+	if ! _set_up_throtl; then
 		return 1
 	fi
 
 	local dev_t
-	dev_t=$(</sys/block/nullb0/dev)
+	dev_t=$(</sys/block/"$THROTL_DEV"/dev)
 	if [[ -z $dev_t ]]; then
-		echo "Failed to get major:minor for nullb0"
-		_exit_null_blk
-		return 1
-	fi
-
-	# Initialize cgroups
-	if ! _init_cgroup2; then
-		echo "Initializing cgroup2 failed"
-		_exit_null_blk
-		return 1
-	fi
-
-	# Enable io controller in the subtree
-	local deactivate_io_ctrlr=false
-	if ! grep -wq io "$(_cgroup2_base_dir)/cgroup.subtree_control"; then
-		if ! echo "+io" > "$(_cgroup2_base_dir)/cgroup.subtree_control"; then
-			echo "Failed to enable io controller on cgroup root"
-			_exit_cgroup2
-			_exit_null_blk
-			return 1
-		fi
-		deactivate_io_ctrlr=true
-	fi
-
-	if ! echo "+io" > "$CGROUP2_DIR/cgroup.subtree_control"; then
-		echo "Failed to enable io controller on $CGROUP2_DIR"
-		if [[ $deactivate_io_ctrlr == true ]]; then
-			echo "-io" > "$(_cgroup2_base_dir)/cgroup.subtree_control"
-		fi
-		_exit_cgroup2
-		_exit_null_blk
+		echo "Failed to get major:minor for $THROTL_DEV"
+		_clean_up_throtl
 		return 1
 	fi
 
@@ -81,11 +41,7 @@ test() {
 	# min=100.00 max=100.00 forces vrate to be fixed at 100%
 	if ! echo "$dev_t enable=1 min=100.00 max=100.00" > "$(_cgroup2_base_dir)/io.cost.qos"; then
 		echo "Failed to configure io.cost.qos"
-		if [[ $deactivate_io_ctrlr == true ]]; then
-			echo "-io" > "$(_cgroup2_base_dir)/cgroup.subtree_control"
-		fi
-		_exit_cgroup2
-		_exit_null_blk
+		_clean_up_throtl
 		return 1
 	fi
 
@@ -94,25 +50,21 @@ test() {
 	if ! echo "$dev_t ctrl=user model=linear rbps=0 rseqiops=100 rrandiops=100 wbps=0 wseqiops=10 wrandiops=10" > "$(_cgroup2_base_dir)/io.cost.model"; then
 		echo "Failed to configure io.cost.model"
 		echo "$dev_t enable=0" > "$(_cgroup2_base_dir)/io.cost.qos"
-		if [[ $deactivate_io_ctrlr == true ]]; then
-			echo "-io" > "$(_cgroup2_base_dir)/cgroup.subtree_control"
-		fi
-		_exit_cgroup2
-		_exit_null_blk
+		_clean_up_throtl
 		return 1
 	fi
 
 	# Create a child cgroup for test
 	local cg_name="testgrp"
-	local cg_path="$CGROUP2_DIR/$cg_name"
+	local cg_path="$CGROUP2_DIR/$THROTL_DIR/$cg_name"
 	mkdir "$cg_path"
 
 	# 1. Run FIO read test
 	local -a FIO_PERF_FIELDS
 	FIO_PERF_FIELDS=("read iops")
-	if ! _fio_perf --bs=4k --rw=randread --name=read-test --filename=/dev/nullb0 \
+	if ! _fio_perf --bs=4k --rw=randread --name=read-test --filename=/dev/"$THROTL_DEV" \
 			--ioengine=libaio --direct=1 --iodepth=64 --time_based --runtime=10 \
-			--cgroup="blktests/$cg_name" > /dev/null 2>&1; then
+			--cgroup="blktests/$THROTL_DIR/$cg_name" > /dev/null 2>&1; then
 		echo "FIO read test failed"
 	else
 		local read_iops=${TEST_RUN["read iops"]}
@@ -125,9 +77,9 @@ test() {
 
 	# 2. Run FIO write test
 	FIO_PERF_FIELDS=("write iops")
-	if ! _fio_perf --bs=4k --rw=randwrite --name=write-test --filename=/dev/nullb0 \
+	if ! _fio_perf --bs=4k --rw=randwrite --name=write-test --filename=/dev/"$THROTL_DEV" \
 			--ioengine=libaio --direct=1 --iodepth=64 --time_based --runtime=10 \
-			--cgroup="blktests/$cg_name" > /dev/null 2>&1; then
+			--cgroup="blktests/$THROTL_DIR/$cg_name" > /dev/null 2>&1; then
 		echo "FIO write test failed"
 	else
 		local write_iops=${TEST_RUN["write iops"]}
@@ -140,13 +92,7 @@ test() {
 
 	# Clean up cgroups
 	rmdir "$cg_path"
-	if [[ $deactivate_io_ctrlr == true ]]; then
-		{ echo "-io" > "$(_cgroup2_base_dir)/cgroup.subtree_control"; } &> "${FULL}"
-	fi
-	_exit_cgroup2
-
-	# Clean up null_blk
-	_exit_null_blk
+	_clean_up_throtl
 
 	echo "Test complete"
 }

--6x3rc727ktc5xxog--
