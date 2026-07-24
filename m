Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 368841A9FB0
	for <linux-block@vger.kernel.org>; Fri, 24 Jul 2026 00:46:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.143.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784854007; cv=fail; b=d7VSdAEEVx/dZd+RjaD/zdxVGGUHU1jzjiJU4ZfH/Esx5Clotg0DX9NrS7nOcXdtlzJTUItu/YsBbjjlLtKeU3FQMCjXRbbUH5V+H6SAJn2330ZYbystzWYC3XHr6t7BEneyGX+hsASWvqMVdKCCu0c7W6ncEj68gIm6YQTrObQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784854007; c=relaxed/simple;
	bh=Z2bHfgRCjor9oaLGk207QwLlkf43zwe7a6gEOqbwfq0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Y00V6IQUjvtdYGPW4fkDAixORpTOxF89/O0mwb9SE8cBc2K3e/uD6SIKeGwThfYYTIxWM/xH/eGC17RAK9mUVaIHdJB9x9DWpQ+NOTBjniwwD58wwZwl7mfqcRLYhvXYLNXGgjqbTb1r7qxvaiSCT7q416iowxEzw/Gfgr704Fs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=TVJnSshT; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=MdX3AMq6; arc=fail smtp.client-ip=68.232.143.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="TVJnSshT";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="MdX3AMq6"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1784854006; x=1816390006;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=Z2bHfgRCjor9oaLGk207QwLlkf43zwe7a6gEOqbwfq0=;
  b=TVJnSshTH2fltUwsO0cxRimd33niQ1JykUtqkuzTD80Qvo0OBYIEJOnT
   blfnInvfRMl3SsMke6p1eu2FY4d0lAZw6J752cx+RuawAtUf4THkabyNv
   fXposzlIBSiCQt7tIVdRmT66sefpENPWeuY3+aoKHQxq5I/f1wSLTYxEp
   UZZsn4wgk2t/mHqLMXNzF7rzawzu+G+D/JnLr00lEBGNU92w3YHQ/oNia
   I0MdNHH3Ql9McZCw/1Rd5KYQD8M4O6CQuczbCdgaaWvah1syZ2y4u0Jpp
   nC+j4TIUVTiQ52w12x/Vsa+YBnXxvKPWKS/ybS2JbT8HDWccVq0mYUUQc
   A==;
X-CSE-ConnectionGUID: eIbIpinPSUGjK068W8HsTQ==
X-CSE-MsgGUID: BOq3wE4XQiaMQlkDZeHi+Q==
X-IronPort-AV: E=Sophos;i="6.25,181,1779120000"; 
   d="scan'208";a="152587206"
Received: from mail-westcentralusazon11010068.outbound.protection.outlook.com (HELO CY7PR03CU001.outbound.protection.outlook.com) ([40.93.198.68])
  by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 24 Jul 2026 08:46:44 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AlpW4EruZiG+h+oeZwkknF8fVKBKRNvGSf7GsBz2V7jNJKFTfYb5KIft/mvW4BtPXRVPb0ywHXCklqlTvngzksODWUudpuYDVbSWWUX+3CxPGz9W3UQQUxirbHq0oNnOHQDcWluNFUwuGf5T+NHh/drpX4GuOIrYi2irxyvUifoloX4zXHli2nlgFzn0JLcDmRX+Men2KT/VKEYz7gupHtCsiHwSTz6Es1pzUmEz5p1Sk9Vs7wC1l3DLJroAE//Bk6wOE7ECSUaKkvgQ480IWm1vFMbkcLmAbZ32VND3ju5p5KqH9Iu43ISv8W6kNIiBdyVb8jl12pqZnLHggBOMkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o5WK/KkaA+2mp+cNkbm/zV3neV6B3cdpUAmqClBksVw=;
 b=f0dZPj5RfunC7KcMKXwisoYRzRjJtPZEBtq/jPvdGDBDsOxcz4QMOk5YONkzAYU2ntlEpK16LUU6cbbWl96TrtkEBLxuqo1hUk9U1Lbh3K2UtcHBx0/AnjvsoZkHMURSeo+gKlgAV6IUZRFMkqebnBmo12t41mjTw6hmJqEnfQ3Qx7Y4oDnhwLzBCEBhti+vDDb+pKJP02nX3f/Ij2yiySZCt7dFpGkLSjRI52ljkf69jXRE2GmSG1AlT9lQ2GdcOFfxWml03hzpXXMjTAPweqqCi5/8uf3wgupZP/5NHYs/rdvWRQfhIrh5MtrAh6Vy44NVDlUYhvIF8NhbReOPkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o5WK/KkaA+2mp+cNkbm/zV3neV6B3cdpUAmqClBksVw=;
 b=MdX3AMq6/seeqO5jmvctyosFPpDqQzdzokoM/WE/EnRt0MYcmE9SKFb8jjHCHDUYWOb2bh6LTMB57N8NdaWElp5DWfs8cnioNoGI97qpPfO937c3KhEh8/vO01mEFQ44pVmCEv9zS3QeTMFyw8kA1fPbv0wpVdof9KtzPlJVyl0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
Received: from SA1PR04MB10065.namprd04.prod.outlook.com
 (2603:10b6:806:4dd::14) by SJ0PR04MB7407.namprd04.prod.outlook.com
 (2603:10b6:a03:29e::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.11; Fri, 24 Jul
 2026 00:46:17 +0000
Received: from SA1PR04MB10065.namprd04.prod.outlook.com
 ([fe80::9b98:bf8a:b0b1:ef85]) by SA1PR04MB10065.namprd04.prod.outlook.com
 ([fe80::9b98:bf8a:b0b1:ef85%4]) with mapi id 15.21.0245.009; Fri, 24 Jul 2026
 00:46:17 +0000
Date: Fri, 24 Jul 2026 09:46:12 +0900
From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: Sebastian Chlad <sebastianchlad@gmail.com>
Cc: linux-block@vger.kernel.org, 
	Sebastian Chlad <sebastian.chlad@suse.com>
Subject: Re: [PATCH blktests 1/2] loop/009: only skip on a genuinely
 unrecognized --ping option
Message-ID: <amK1dRmJSiaLbPvu@shinhome>
References: <20260721160432.27409-1-sebastian.chlad@suse.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260721160432.27409-1-sebastian.chlad@suse.com>
X-ClientProxiedBy: TYCP286CA0083.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:2b3::11) To SA1PR04MB10065.namprd04.prod.outlook.com
 (2603:10b6:806:4dd::14)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR04MB10065:EE_|SJ0PR04MB7407:EE_
X-MS-Office365-Filtering-Correlation-Id: 8e9aacdd-9526-4d75-8acb-08dee91cf88a
WDCIPOUTBOUND: EOP-TRUE
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|1800799024|366016|23010399003|376014|22082099003|18002099003|10067099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	zJDU/xAvfcHCUR30Q1TjvZxEqpuloey52WEwdl9qUYhmsvBauF1kkcJsbf3+ZEJMtCwzQ/RoL06KlgrtATusdlAFjY+FMz2t/vf7Vl2DJ4eJxp1odi3uiJY8NkNTg4B3NP1szXJIxtxt0OUWlFE8C1bSZuIkQ2QZ/4rIYLhlzHBzPfXaPrMkEW0abPyzJ4LOIMucEUpEmOt20vZLIiaDQu0yQDh64B99eN9aAHFw7wUlYJMo+/jgMbKR1qj52CcsAWWud4RZd2aPNHmWn8OhwPqQZMWFxnIPpHEMP0VRPAXY1nttKSFO2KUQ2wLWRiE/BWfOS4H6F53ysw8Yd3I8P9Q4+sIwQdgQ69JvuoV2FVlJC08NEvyzvRe+f7ogzYtS/qBymXcPtBAA96a/JVCPX8/Yp0Dh3SvRT9ltL4+aZbeY1yGWz32sqvggKt9ic7VvkSH4P+5zOhByv+um31Yb2/fTBD5QFAfO1wi+6G1LJ/tLFw3sI6q9lMZY6rXjTAP4jtt7t69z/PTcejQ/9AtBh+LwKbOTG4jJlCbnCQYqRo/gOEzErDUS/27Yy9UoxIJsI5SjNQaYJrD3h5a/fAea8rIxyR3xmXoL18YnwMDYksCxrm1MiVI55O1ursmJyklyJnkiPu8Ya3mLTAvjVteHOmjkbPbuvTdUy806ri0xlyw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR04MB10065.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(1800799024)(366016)(23010399003)(376014)(22082099003)(18002099003)(10067099003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Ihj8OT5oQZyxxgmKaCfpTGHEy5dfZ/9oxdAPGiXhZ1axGdAl963+hTT0WIDk?=
 =?us-ascii?Q?sh8bnkmefjQofeIbWzz/gcwcNB2ykeMAnB6M6NmlltRG9I5UYbFQcSYC2sWW?=
 =?us-ascii?Q?G8xK+VYQin5fgTAHDihSRJfpq+RtNoCc44CtEn437qq8NNtPXlSf6B22SxG0?=
 =?us-ascii?Q?AbFJdu4iZX6xGKK7CR0efr4qG+2v+JFstrr79np7Dk6iS494fqD3qN/CZ2QY?=
 =?us-ascii?Q?zSuVK/MFA6O3jQ4fE9jiNMBYHeEe2VgcXgoXysBCtuPI0Y/K4Hkycwgk54ep?=
 =?us-ascii?Q?hCHfX6A66bNU/r9jIJ3QbFFlQkAryP6vEI8e9UoB4whSikr2y3TYo0vksGfb?=
 =?us-ascii?Q?zF9qeOfawnbhfRyn84nvIjXY+UaFkMszx1cbPXoW7WSOALrwskmcZJdY/jZn?=
 =?us-ascii?Q?nFe40uJuZ4ohG7uXyhVCQ9WSBR5H0peazUGwdVcZnJvj0nycslOZSEkMcfKd?=
 =?us-ascii?Q?AV/1ZjQitraeZy7e8f0vkxjYD+YsphJUKCtPV+NOT1vMNHUos57MeMkQgA1j?=
 =?us-ascii?Q?R0Ri66aIMDeYrzhjE2gsq5lYrDtoXH9hiobdw1SM3m4OECAhH5THGvCWvHVI?=
 =?us-ascii?Q?1bGgmxrR0E8H5SZ1ZKL7gCp75jvcorSx+BtHhHAMGs41Wp9o6qjK/PbygrdF?=
 =?us-ascii?Q?AGhahNyggyomOasRArwY7v6pvO+TCiYOkOIs6SSzpjfLlTlHfj8Nf6DYdyXS?=
 =?us-ascii?Q?UDtQ/WxAI8up4oPhIDwAzMJjNVoWmHD/Oo1Bx8DRueayuR8HBULM7DeTQHB8?=
 =?us-ascii?Q?ahOZ3HooJcUlb8O9PB9Wr2QI2lanv4Ea+66FDhIYKnXmleP6woWimAANRiNL?=
 =?us-ascii?Q?nfbpjFhI2xB4zONhlMk5b1tCdqlJkYhZU3G70yu8yNDcC813UJvOCy43bGrc?=
 =?us-ascii?Q?Z/NAYNYT6vi3+ln7wvUeYSnAN0A9cNQrE6UxsGD73RtEQl12HDqVgwsCAyKP?=
 =?us-ascii?Q?HzJ0TkjeevNNIGwU9VQRQJH/a7vD7ZasNRHDKMY/7y/wbsSLBkAtWzqPotG7?=
 =?us-ascii?Q?0QRcemf0qSZA3DglNtAPvI2VC9+nZUaZ6Lhxj94Fu0EZPLsfDp+tVPRPWydn?=
 =?us-ascii?Q?R0RQbwyLRHr8fwK5AxqwpCo6t9O6zNj9KBoJsEodlNbEvDGIKvZ9s7I5M6uN?=
 =?us-ascii?Q?3YG1wMwvTAWthlglVTlNCiszH/4PlRvEZUWKIU3YwH8NLycm9HiAvdVBxBLJ?=
 =?us-ascii?Q?tUmlHoKjfTxRKYiQddIoNIqzfU/oAt+Ht5J51ZUIzG99M/boD9iEQwa0MMcL?=
 =?us-ascii?Q?YEWgVLPUP7GJmAk9Fszx3XUji+XMe/35VbCCkvKXmHgupCGlJof77/EgxLIy?=
 =?us-ascii?Q?iYL9yeEj5NYnYRQiQZ2ZJM1tytbkysCLawLlufoQKz2OUmGBpkgYUkq6vCbk?=
 =?us-ascii?Q?OR1IMLPHGleEcuKsFV+7tAJ5hFqcJP0MQ/kLWmJBBSDAyiuGEXvP1aSr96eu?=
 =?us-ascii?Q?bUp7vgc7/xNlA8PPgHM76QhyKc9mgoLX+02/fDzUNkbaQJhU0YoLA4GO7B2W?=
 =?us-ascii?Q?cAdJVX5qWJcFUfI0771fpYYgEjNYQ1/+p2oZvz4/cTJnPQrXpUSkEVpO7p0p?=
 =?us-ascii?Q?/OlQs8E7eJLMPs6aDxxvY6I5wx+Xax5JOZ+Z3i7yFNAYv1NomYOai8Y9vt3I?=
 =?us-ascii?Q?YMGYXM85qRXicDWXi/p+xPkDNcUxjTBLYGtPX5PzOwSPZ3sFfKS7nGq8XHS7?=
 =?us-ascii?Q?bKtkRdazqPpKgQG785G4GfbpSU5CXOxvu+PKpoKK2reXsdueaFRDloWZbl3P?=
 =?us-ascii?Q?IAxa6NvtozA9++iivX8LkAWt0EZhgZE=3D?=
X-Exchange-RoutingPolicyChecked:
	TxHo2+XhOpvr7Cwe6kuyS3C+VX5+SNRwA48Q03Cw9Jig4xUbNC1BAD5uuP4Y6hkouAE0G6UyBqERjOAJu7cqYAvlDleIRT/SBj2ZXk1PAtXY5igW3UaoWGbMYQ1RkHzixZi2rEsETGveiMX+4p59v965CZFYXz+yl8I7gAxl4mDSNQmUNH5hvXUyfGenMNaI0Df3tZKsWKVY/Xottoum2uU+8dyN2Gj6ApS852QrbHWEi4vSe46OF6lsd1iKapYuqj6zs0++/dw0o8jIJGoacywUNw5oD4e8OiDmQ1vhJPdwO+qZpM6uc7PwupycxxmryDBte7lPuq+qxocPpeJiuQ==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	XTrVbL2Mc5gbGX9RFxkzfxG8owpxKEhEP6/+sIfjAdDV9agLwuntTxmZ3jBnDuvMr7xO59Zo07uJGg4iuQPUjEh3vV26SgANxZ4dC1jHmwOEjytgFM6IHcEsPZg20RA6fLYqcWaY81Ow5OvImjn7k8IjDOei/apKlnzkCfXJSYIYzCjuProZqTwjEEVi03yhs9mltsiYoV0Ut0VOz8ruaxnKjXQqdyBuGoNChP/IlClJThNEifR0iItxsoY5/Jfucvn6WzdYGW8QDAnITDSrM75EMns0OXGCH3Qv6HpbPd4kEQ11072dfqeQosF8ndYl8uF/+YH151Xg/bgt9sPWxzjt0P6jEaX4B2/Za9GeRrHbLws1vIPKYrq6Zx+R6FpIHTj4WpmBuu9fAk0Df14Efg18uboU0mmmt0bwm5db2nqOiAqqrf6LMs4JVJblAKzphOr0qhvu5JnZDp5+ecVq0J8HBDU+1rv0q74SdSkwgDMDRQ8joTnOGNynA4AOTPLQ3iQ28G/o5utY0qp8ORh/efEj5Rm/1/5JH3fcg6rS2wdJ9BLGigF/esAkofdUv+h0SYRa71Tgk1NDwYC9odQurBExNxhX4m2ufSZsDvZH+a9IC/S5MtelIMGZil2B3jEq
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e9aacdd-9526-4d75-8acb-08dee91cf88a
X-MS-Exchange-CrossTenant-AuthSource: SA1PR04MB10065.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2026 00:46:17.2180
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mnTpET52zoS0yWubQ8j0n0kscwJk/RkTCRy3pt/t5zx4Lnp+Stj9Nq35wZ0Yaw+CMmbrNmvdXeCtn0pnEuewS5PPU2PFfBvFwIZAmQpGpD8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR04MB7407

On Jul 21, 2026 / 18:04, Sebastian Chlad wrote:
> udevadm control --ping can also fail when udevd is busy or unresponsive
> not only when the option is genuinely unsupported. Treating any failure
> as "unsupported" risked masking a real udevd problem behind a
> misleading skip reason instead of letting the test run and report it.
> 
> Signed-off-by: Sebastian Chlad <sebastian.chlad@suse.com>
> ---
>  tests/loop/009 | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tests/loop/009 b/tests/loop/009
> index d3c7991..944f53b 100755
> --- a/tests/loop/009
> +++ b/tests/loop/009
> @@ -11,7 +11,7 @@ DESCRIPTION="check that LOOP_CONFIGURE sends uevents for partitions"
>  QUICK=1
>  
>  requires() {
> -	if ! udevadm control --ping >& /dev/null; then
> +	if ! udevadm control --help 2>&1 | grep -q -- '--ping'; then

I applied this patch. FYI, I took the liberty to replace the short option -q
above with the long option --quiet. Thanks!
