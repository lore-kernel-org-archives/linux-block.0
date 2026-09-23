Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94A4537AA6D
	for <linux-block@vger.kernel.org>; Wed, 23 Sep 2026 08:33:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.154.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790152424; cv=fail; b=MsgTtpfy2nVFIlaSkW/TkWJmmXlDUEa7B1U/qJyAUHJRA9tU3hNYaffv64YxMprQTgf4+2Opgg7K6HBKtQNYOOYE0NxW/yocf1ldQ3mdLVIWdshEaGwuZ++7sNiGsNy6dpBTNjMnpwQkupUgb3BbJfY3SavCAExXpes77V8WOBg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790152424; c=relaxed/simple;
	bh=HoeclieoPsjafIaEca7rtlN2bo5wwHI5e94macaj6L0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=PCQUa68SrIlqY8EDy5PdctmFqVyKzkwF1sk4k63D8BCke3zCwfyseSCynPuy+9sJoF8YXw/UsqJFGdsIQnUH1j+1jFham3VrwDF0jUqgB5o+EweZhLo2qW5ec3RuDN3MADWGg0DfALPA7+eC08Cs850Wr12KDUDGTcP15xfgqhs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=As3Fxgv5; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=u3brwLT8; arc=fail smtp.client-ip=216.71.154.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="As3Fxgv5";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="u3brwLT8"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1790152422; x=1821688422;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=HoeclieoPsjafIaEca7rtlN2bo5wwHI5e94macaj6L0=;
  b=As3Fxgv5lFWOSGrnYyVAWh6ChPyOuOwMxx4YoY9McbfmhkJG65gaNL+Y
   5lvh9sVBiTP/jM0ShF+ictZN6QzcPjyk1Ta5b5LuC7uUTZWyl3Ifga+js
   WCcmiUJ7mpxyXSiXOICJHuk4yfdzH8zu5FJBIyM89YpILx/kyYKAXGVtF
   3w+ggt4S4x/yYGFBpObKsW7vykwQdEt+GvUGiT473YWxhyqU5jJf+ueia
   SAu0ujdmly2GS/caWeu13ymBvsjOvjzZUS72DbZFsH/LKbw6agzUz1+NV
   b+dLOe71BJUir+zK6JaCg9eq2g4vgNK9vEPj+hxxIhTBUl8ETxUrN7VNZ
   g==;
X-CSE-ConnectionGUID: d+tYiVbYR72vXtmEZMxl9A==
X-CSE-MsgGUID: +3VjjleBQ26eS9QjWI6vFA==
X-IronPort-AV: E=Sophos;i="6.27,118,1786982400"; 
   d="scan'208";a="154749766"
Received: from mail-southcentralusazon11011000.outbound.protection.outlook.com (HELO SN4PR0501CU005.outbound.protection.outlook.com) ([40.93.194.0])
  by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 23 Sep 2026 16:33:35 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cgKrI5bN/a51K3cJfXSXJm0KE8PBAZPqa4jjSP2LVlV+/xTKHl2h8bAPBwAC8vTbVKYmG2Di5/gNkrXov3mVB7ui8Thg5J2YFBE80nfDGwpBtRC7Rw9iI6bGkr/FNZtVo1VVPkCPR52CAfFqB7L/0pR0ceRgZkwlqN9imw+aIgo5FVJaW4qtDv0FCoRloeLKiOQQPRpYRDPGOsUiB1LHg/4/rG9TZEfoGNe3gqwXI0ndBn3cu81Ci+KhJba++MF1OqmHTUCohVsD02t+9/asEEy4Zlv3uFVXBM/l/NEjU7Jwl3V1HiDRoTHB/7Puckim/NGFgShuvNI6XWvxjhsTeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0te6YEJnt7N7ZPqe/eP2BU6lNF2owCskNv7f0BKmLOY=;
 b=xyxcrI/emckUj3ug/nVrRsszt+vtxXSXeIGuhmZ29rgvIXsG/GpEg1H454oXOTBfcKmbCqBmxee68C8K4xv0akx3bE3lkwHn0b2R9wFF5STk4RVEiGXIMObJCqjufeIxE7rXfvR2pFWNs+CWDLYRuPOUkqpfotfSXLbEMJLQIQ31UwVqZoc9otB+yfuC4K0CsqSRe7PmiSETdZMqS5QCb+coF4yYq/SAMQsdgibpvS2k+eAsL6PJpnwPPlra4b5jqWPPklOGK8XnKEsDph/F0cl3VPlxtyMfTPa56ehG4aZ5x0all34kxVSLATzOLm4jXrZY58S8GXmWniYYunsLsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0te6YEJnt7N7ZPqe/eP2BU6lNF2owCskNv7f0BKmLOY=;
 b=u3brwLT8lURiUBOjhtIV+U4fbfvrlqgkgHIHngh+MsnF7k/kjD0/IYaWXsDzshtt1AsKiqIj2926S5HSnt26PDUByQk/ikZ95AEeuWBOUPhZqo61R/P23rX9LMSCUkUQ/8ZCqkRzKVCoEgvpshoL06WmUtWKCJYhrN9ZEx4Dwcg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
Received: from SA1PR04MB10065.namprd04.prod.outlook.com
 (2603:10b6:806:4dd::14) by CH2PR04MB6556.namprd04.prod.outlook.com
 (2603:10b6:610:6b::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.14; Wed, 23 Sep
 2026 08:33:33 +0000
Received: from SA1PR04MB10065.namprd04.prod.outlook.com
 ([fe80::9b98:bf8a:b0b1:ef85]) by SA1PR04MB10065.namprd04.prod.outlook.com
 ([fe80::9b98:bf8a:b0b1:ef85%5]) with mapi id 15.21.0451.014; Wed, 23 Sep 2026
 08:33:33 +0000
Date: Wed, 23 Sep 2026 17:33:26 +0900
From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: Nguyen Ngoc Thang <ngocthang2710.1999@gmail.com>
Cc: linux-block@vger.kernel.org, Daniel Wagner <dwagner@suse.de>, 
	Hannes Reinecke <hare@suse.de>, linux-nvme@lists.infradead.org
Subject: Re: [PATCH blktests] nvme/071: add a test for fcloop LS request
 use-after-free
Message-ID: <arOLaz8NSnz6bqL2@shinmob>
References: <20260921145659.17151-1-ngocthang2710.1999@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260921145659.17151-1-ngocthang2710.1999@gmail.com>
X-ClientProxiedBy: TYCP286CA0201.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:385::15) To SA1PR04MB10065.namprd04.prod.outlook.com
 (2603:10b6:806:4dd::14)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR04MB10065:EE_|CH2PR04MB6556:EE_
X-MS-Office365-Filtering-Correlation-Id: 73c7a92f-dd36-45a0-fd91-08df194d5a87
WDCIPOUTBOUND: EOP-TRUE
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|23010399003|1800799024|19092799006|376014|10067099003|11063799006|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	LshjcWy4qrlnpscPmTsDyI5Zc6zTC93XUbvLUOP1FMiTyxfCGRmw1kFKeJiGqR4S0I7Penp5Iuue+ZDrDlfPdUIUmiDqQocn4GIemL59pxkNifbEiIlIPA8Tpwp5vCt/zgnMq5/PwFb7blcPB7cD2dbcXecGy7fACpibQQxOWK10NfuUZD0lTxswxK972wJw4sm6RupPBdVWFzfvyuKb4dT20wmfe7BPU8Reh0sLsu0V2pU+ZJ7FKm+YrLVEe3uPJb6JOjsx1BXvm30GrUj/g/97rZAqKcwJMg35PlCY0lovG3jZMG77B53277yAsRGafohHoBVH45tIjr30uNE409duwKVL3wFp8phMZT9eYGAXL0V1ODM2E7nR3Pz0asfdVWlJAQ0jo3ZL0Ev45DgDIQZour233uLTQ/eYt7DaD8FCE630jvc131+Z3tTyd/24bzZgO7N0xOZVmfZS/6JT+RSGzZcAgCZN6kNHUK+AkGOv2fHD2ufIltkqKitKY9DcDVIdgpNXXvt+jTcHJASUDJOTIheXt89D0G/SG1s0zPZca5HDbqRuz5vtix9/oDnS/SQ4oE3unGH3D9BwWPOk3JkA75mm6uiFd8TaDxC7dKsQ/iAViC5hj05BbiLr0CEX
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR04MB10065.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(1800799024)(19092799006)(376014)(10067099003)(11063799006)(56012099006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?fev3jGJP7icCsnj5ejbwIQbEUeVWmCTO2u/UKeXprAPSLCrwCesxxX9S68bp?=
 =?us-ascii?Q?X/7uswBsp3hQwmAkPzG4+WB6KPDtOBrGsXInuk41R4EULQwUdnZFdKwfw3Pw?=
 =?us-ascii?Q?HVSFqA2AHE0orlO/AcOgV/usX3tptiwp5AGc1pznxve1y/OUkjaCyoiDG9SN?=
 =?us-ascii?Q?xqsi5PkWPnwAHKvXpUVzMup6VSDm8CK15oqXannfhsi/f5FL7C5HPNuIlXLY?=
 =?us-ascii?Q?ZIFxuK8w2GOey9+otfTZ6MPx6NIBI6SZArnHEVtG+rkyNVL2XSxUEB3PNvQU?=
 =?us-ascii?Q?J9o/d3rjbvqdHawsEGlwzpZ+FSTkOwEpmKbG0tOv2Vd8ytKd3IMwWDd3QCBh?=
 =?us-ascii?Q?S0c7EkTyQ06OIGswyCEhiG/PKE7YtZJZ/9slrIwT3uC0XcitpW4XVBsEczY2?=
 =?us-ascii?Q?Oy2yb8MTmYg6D2/0j7wPW4umBnzOnVgrDmtzD5JfGKcCEaujscLxbpvHsqV4?=
 =?us-ascii?Q?b4/eq16W0zAE38lkOhqwQB3crgug3GnVZ/WCNMyiK8mRFSq4NG2wwQmRtJrF?=
 =?us-ascii?Q?ghTtbQGGObAUbKbE6rBPzXabhOTb9yKeCgzyJpsg0DxMUpKFK9D00nbY02g2?=
 =?us-ascii?Q?tGfEr2Rst0gzdQYUN9dwHB30hsB1kWYG4xgcHUUUWrn1yUdTvarv25a/XVQC?=
 =?us-ascii?Q?p/jquUklqkV2Wk8pVueq3T7EJucYwXan5Tf1RfkbxvTawEPoQT9a9T0Hirx7?=
 =?us-ascii?Q?V64Y+79mIHzEOGLS07clXy/v/dvNGWaPzCARaBFNpc/oNUMPon2E2mcnk5Y7?=
 =?us-ascii?Q?vYn84jm/v7S8mW8/SgoleiezI7v4PZUeID01G+YjXnYN7W/T5mkFloeI1ZPP?=
 =?us-ascii?Q?9x1WH/lj+tFEIiJVhE8pvR8oY/cbcUz7w8G8cIWt61mSXO1sz8zoY7O5FWhk?=
 =?us-ascii?Q?kvjUdlos5Rlkh1HaZwH1Nd6YlA9Ma0sBi/FsCe4GSs5nkfT0FSemsNVkSzA8?=
 =?us-ascii?Q?5WI0lj5WHDMaSS0ScU3THOm1HWDiLM0L+CVxfM3N8u80XPmHAgoALBC8yxUP?=
 =?us-ascii?Q?HRpeSrWJXagY/KXPyjRZSU2EEzPaRnkmWurfXtQKrUwceuAynmCEgVdoaMC9?=
 =?us-ascii?Q?qf4deDibyJRyuEdM9IC2rfqaHfHVL4EDvhOUE8Oe4h70vqjKAL3pd1X81rT/?=
 =?us-ascii?Q?dDkk+yvNCy45XwNgJxvIcg4hvAqK5+WNPfNLOp10o9Dtz/AAgbU3ICkOVr9q?=
 =?us-ascii?Q?ME/kpr8Gjc+i/s968YyLMG4ErP80DksiMc5z93kfeiMkc03ikknQtLdS3eYM?=
 =?us-ascii?Q?xygt2X31lTAslrry/7Lkho6eSgtu4lMb9Kkax/IIXtXJOJklyPfg+TMCGuQN?=
 =?us-ascii?Q?Px/R1rrF5fcAofgBmwFoB5GNPrUNbahz1yA3JZIabLM78SJAagvORv62GS2X?=
 =?us-ascii?Q?N0UlCT09m+6AsMgW405aawMPhAPEy9VFh5AZ2vGGTvRjBYgjOEs82KXkSzIc?=
 =?us-ascii?Q?ret0qiIX5EeBW97EbTOGZJyFGCQsKvm9TqvvoBCFetP94J+Uj3KgYEke5krB?=
 =?us-ascii?Q?SK3bvJgNvn9AozKb1AFjKh2p0hl+6qYzhgWt58yNoQxSBFYB4rGnKAlo3SDh?=
 =?us-ascii?Q?gCisxypaxmWMxDG/rC6V7TVpMiR3VLjJ3QFX9B3r+CtWHooYVPGcJWttQ61M?=
 =?us-ascii?Q?wFVUdhtF8JYWk9f9Ony5mNYOuobDYefm6JnlEbCFccYDs2+Ett2gTQHmRBhi?=
 =?us-ascii?Q?khE39fhOR8yzcZc7ju2+nGZAcp+H6n+t6CxkC7oT/tTH2fCGHhdXYMncQZQu?=
 =?us-ascii?Q?hMPUkWX3WDdLuMvsHZmpnTXUfHuDBnU=3D?=
X-Exchange-RoutingPolicyChecked:
	2jbWGEqiyayPphILXT1jmwkBCce2GueIyKbCLBpU8PL21oF0/F1/KBhQlAXZpvheMKoTAhq+Nv9+6Zclua6rZ4baudz/C+9SYJCmifR+Sake4V2hI64Js0qB4DK4Hl3nmNLqest7VZgGu5ni3aDXbhCQgAtaawVLv18GptFx41Ow+00pRzQanxXvO6iS50ZjJv963nTFlTd4pro7EyxmugwbfQDJ6ZHzB9Bi1atBv/27b0xDlxyE9oQsX0r4Y4qtPH+WbD0DRTPQvyFTwWhWRwkpfYob8+M27QgdNoa1EcdUp/rsHLL33u3ccKALmLeO2sChgCY5RGjqH1BLROz+Lg==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	qbzL+ZZ3jO6UZmmHdcAXzuyNDb4S8cv29y4QzyrmVCGxlqAqGgqtzm6vE9znU6fGAeNtaFe1pnXyMiePHEPYgHxIlTmr/yncexY090NRfcS74QtCNLHBGcGsBjz4tVPEUYNHEXZUS5NLdGjXyrgDn+cO3UE4JD8wzdFxpbIf/x105sCTH4Hf748QFSN39auF5/BOosi/Jf++eXNX9TeX72Ie4mzIHUglJQRyvoPrOM01kndGSqj0fOiaNmAA0n89OTwoVTNsCz0UtHs1rQQckHt/t9R9J3frE7Ernx9Z9u8ECP6Q4tGcTr8NYM2fTutloM/Vk+ZLv9dnS2Ovl7HCawj0BLHVke99kSZoTGfQxAuKLlNq4vTzPjpRIHGEBU3jqttCSrsseJnES5Dl/cAxQjugXq/mr18AMx1FtcNSNpE2ZbuHNcxb+NxeQePwhqAERStra5lmB0E1tOujc2PWgvh1SgSLZ6D6/KbpHJ8lLZhJU21W/NszOnKtVmdZwDpUc0Cgcn/8UzzCkfjjfoc9eaOjr6W31YW8Q3f4Ov6ZFUPu2LAqp/TGYD9o/S9vYb0++HBGsRg5Ufqy+IyVTbIUcymPfy6QvS508U7w4GVlnU+oC3yT8yMUDWI0V3Tz/WLL
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 73c7a92f-dd36-45a0-fd91-08df194d5a87
X-MS-Exchange-CrossTenant-AuthSource: SA1PR04MB10065.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2026 08:33:33.3929
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iEB6cAOFePF0+uzJm4oUk4OnzcmWulRBKcNmWKvumvBEodH5TiiQ02qjq1oINKx/LDH79GNPYUbGYWkEXuZb9sVx8dNBg1Et5/4b8w7S/QY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR04MB6556

On Sep 21, 2026 / 21:56, Nguyen Ngoc Thang wrote:
> Delete the fcloop remote port and then the target port while an
> association is being deleted. The Disconnect Association LS is completed
> from a work item that can run after nvmet_fc_unregister_targetport() freed
> the pending request, which KASAN reports as a use-after-free in
> fcloop_tport_lsrqst_work().

It is the better to note which kernel side fix is related to this test case.
I suggest to note the commit title of the kernel fix here.

  If its git hash could be noted, it would be the best, but the fix is not
  yet applied, so we can not do that yet.


When I tried to run this test case, I often observed the test run hanged.
The hang was observed with v7.3-rc4 kernel. It was observed even with the
v2 fix patch [*]. Do you observe hangs on your test systems?

[*] https://lore.kernel.org/linux-nvme/20260921145651.17131-1-ngocthang2710.1999@gmail.com/

Also, please find my comments in line. Thanks!

> 
> Signed-off-by: Nguyen Ngoc Thang <ngocthang2710.1999@gmail.com>
> ---
>  tests/nvme/071     | 70 ++++++++++++++++++++++++++++++++++++++++++++++
>  tests/nvme/071.out |  2 ++
>  2 files changed, 72 insertions(+)
>  create mode 100755 tests/nvme/071
>  create mode 100644 tests/nvme/071.out
> 
> diff --git a/tests/nvme/071 b/tests/nvme/071
> new file mode 100755
> index 0000000..d17ef18
> --- /dev/null
> +++ b/tests/nvme/071
> @@ -0,0 +1,70 @@
> +#!/bin/bash
> +# SPDX-License-Identifier: GPL-3.0+
> +# Copyright (C) 2026 Nguyen Ngoc Thang
> +#
> +# Regression test for a use-after-free in fcloop when the target port is
> +# deleted right after the remote port. Deleting the association sends a
> +# Disconnect Association LS whose completion is queued while
> +# nvmet_fc_unregister_targetport() is flushing nvmet_wq. The pending LS request
> +# was freed before that completion ran.

I suggest to the note the kernel side fix commit here too.

> +
> +. tests/nvme/rc
> +
> +DESCRIPTION="delete fcloop target port right after remote port"
> +QUICK=1
> +
> +requires() {
> +	_nvme_requires
> +	_have_loop
> +	_require_nvme_trtype fc
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
> +	local i ports port host_port

Nit: ports is an array, so I suggest to seprarte it from other variables and
declare it as an array:

        local -a ports

> +
> +	_nvmet_target_setup
> +
> +	_get_nvmet_ports "${def_subsysnqn}" ports
> +	port="${ports[0]}"
> +	host_port="${ports_to_hosts[${port}]}"

common/nvme provides _get_fc_host_port(). Let's use it to avoid the
reference to the global variable.

> +
> +	for ((i = 0; i < 20; i++)); do
> +		_nvme_connect_subsys
> +		sleep 0.05
> +
> +		# Deleting the association sends a Disconnect Association LS.
> +		_remove_nvmet_subsystem_from_port "${port}" "${def_subsysnqn}"
> +		sleep "0.00$(printf "%02d" "${i}")"

Is there any reason to variate the sleep time here?

I tried to recreate the KASAN use-after-free using v7.3-rc4 kernel, but I was
not able to do it on my test node. I modified the above line to "sleep 0", then
I was able to recreate the failure. I guess the sleep lengths f
r KASAN recreation could be test system dependent.
