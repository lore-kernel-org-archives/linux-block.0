Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D381400E02;
	Wed, 27 May 2026 11:48:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.153.144
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779882526; cv=fail; b=DVg5RcSKRbideEzrZbAgGgiRwnTsWyHfzLn9n2rWUG8snFxvYBz0srg5M4iya9tOb6rzPjKscNXnREbErdDGYTSWtsevK16WDZUb/F7C+HE+rbHlC89LoSGcMcnyptLcqPKubRm26tWo7wXLuTR0bnUKvSL5Qq7WJIS61dbZ09w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779882526; c=relaxed/simple;
	bh=GaRUCkGKdcL+EBPZ+CwuieiYXY+t1Uhn+jNlZOnhYlM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Lu17X/DPbM0PrkMBFCycH8ASdIvdRuzFeioCO1v4rpnihFAOXUqluCntNCdWsEyjXR8Gc8XbITNy2KaLhby3/2UPiv4p8Qlb1u15xTiQklX6vp0tfwoRyF6m+apbLgt6FMFljT/GI1XJ/10OZXJRnM1tw7/opcO9jWd+WHNVIg8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=VFLfNu8n; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=lFmlwqin; arc=fail smtp.client-ip=216.71.153.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="VFLfNu8n";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="lFmlwqin"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1779882524; x=1811418524;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=GaRUCkGKdcL+EBPZ+CwuieiYXY+t1Uhn+jNlZOnhYlM=;
  b=VFLfNu8nvr9VhzB3UhE6eVkjyGOhUmzinPqYA3CsIki5lbJSgV2GygkV
   KpsoVWq8zzRzBf7b7nbs3gCTLgHtuaGxnWV7TbioWrciExtvHSFkS/ysE
   2D5a4XlhrYZm6Hs5Al9HgDK4UMSKuEUcaY/d2OPnVFpSv1COeuAM5OUn7
   Ra1rgMixOKYq8d7S1biiLvUSfZeOXHJNCdAlWlT5LUH8Z055Le5osF9wr
   ab5G1vt6l1Ay45AUZu8dm91XEvz7XHlAS9z5m6WAd0eP/TYbWzxCTxldv
   Pkh1AAq7GHAiqCTJbTjCVxB3Wi3dgIKB1TjKz+tUHv55w6Du4+L8B8aZd
   A==;
X-CSE-ConnectionGUID: q3TukKfBT9eiqq8VaeP/mA==
X-CSE-MsgGUID: 6QCnpA27RHW2lCMQNSgZHQ==
X-IronPort-AV: E=Sophos;i="6.24,171,1774281600"; 
   d="scan'208";a="146916890"
Received: from mail-northcentralusazon11012064.outbound.protection.outlook.com (HELO CH5PR02CU005.outbound.protection.outlook.com) ([40.107.200.64])
  by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 27 May 2026 19:48:37 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fn1F4SBaedDu1aeswELgtPu1l2he6liWNj7KCj/xXSnFQcfCiYIVxHeQFVzwtwk0eInuBiPrfKljFog8jJXb52UD1ENdnC0iAHb3I6xhR97glIXYcrvYZzPxUp+bC3cnH8yT5E0qwZ/NqgsYbdaEXzivTfYQedsVh6Y7l1+SIdAjjlhMZgElLRfMQONMDiEtNdKEGcpw5frAbkjaXhfRo0GJpn6RG30g+hMVvqM2zt42Vh4lgh7m1EfKKs+vSvPr7XCwYfUBD4PlgkcucQb6ybzgdq4BrYJXLrvyhSadYVslFzj4jw+nGCzdTvDsfrC7/IdJmMjvj4D7DtdhcFOWaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H//U+UaY4Hu0dL8F3YE3OHcv4EaxJxUZrZ05o0a411o=;
 b=KQjRkyYBhMQ4Iq5J6HDZ2MyUXs+fs/z0jqRMV7bqUy1dWHLXYJzqZUcD/QQ4DQphXOJmjmrD5dEF4K6m8UCwldpSoYjTP/OkYCc2gmz0Q5qS4dU4OCHeV6EY5BbuiEXou/77LCJ7qKgO5FU0hG/yyyI9zkFZ1Y+v5VpxtP9SEIDnznYaCloQONXdtljTiFpthP3VBjl+IYUdV4x6oRodPyoAIPhJTxfF7SL2otfkbCoblNbJ7S40IpP7tZLtWXjwQntOcSgbTV67EXIrB9xqLZn61jAVdK8qGpQA0aDm9iST838C4VizBpK/92UmT9MLp5F96YyxC22lw4ofpzAo+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H//U+UaY4Hu0dL8F3YE3OHcv4EaxJxUZrZ05o0a411o=;
 b=lFmlwqin0WoWErPUQLw8kEQCSoI1KzXEKQNdctyOc3yDdGqIotEU41WcHPRV9b0AcGUeP2a5afsSMe3/910ZeJpk3uP7thHYOwbRDphLXtMCA1h557miH6KxZhtO+yqHTVDqbwGqGCbf/2fSysh9MuFAiYE23+glETIjkNX0uUI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
Received: from SA1PR04MB10065.namprd04.prod.outlook.com
 (2603:10b6:806:4dd::14) by BN8PR04MB6305.namprd04.prod.outlook.com
 (2603:10b6:408:7b::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.13; Wed, 27 May
 2026 11:48:35 +0000
Received: from SA1PR04MB10065.namprd04.prod.outlook.com
 ([fe80::9b98:bf8a:b0b1:ef85]) by SA1PR04MB10065.namprd04.prod.outlook.com
 ([fe80::9b98:bf8a:b0b1:ef85%6]) with mapi id 15.21.0071.011; Wed, 27 May 2026
 11:48:34 +0000
Date: Wed, 27 May 2026 20:47:30 +0900
From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: Haris Iqbal <haris.iqbal@linux.dev>, Wentao Liang <vulab@iscas.ac.cn>, 
	Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Subject: Re: [PATCH] block: blk-zoned: fix zwplug refcount leak on write
 error path
Message-ID: <ahbZRsqHKKbg9PSB@shinmob>
References: <20260526141824.2293025-1-vulab@iscas.ac.cn>
 <d8be2a57-c950-46c2-b9d8-120b6e53da91@linux.dev>
 <90a1581d-9a3c-46db-bc7b-5fd1a9d9c0e1@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <90a1581d-9a3c-46db-bc7b-5fd1a9d9c0e1@kernel.org>
X-ClientProxiedBy: TYCP301CA0036.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:400:380::20) To SA1PR04MB10065.namprd04.prod.outlook.com
 (2603:10b6:806:4dd::14)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR04MB10065:EE_|BN8PR04MB6305:EE_
X-MS-Office365-Filtering-Correlation-Id: 297f3d7f-40fa-48c3-5359-08debbe5e1eb
WDCIPOUTBOUND: EOP-TRUE
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|1800799024|19092799006|4143699003|6133799003|11063799006|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	NadxqH42RMSaL4qDZukm8AVXG1cB7mDk6iFaKqB6wuLDuhZ4kZLuHx7xO86yWyLzoUl/7/gyWZhQBgrbiAFSsoMm4jRifEuhEe+5ClxTKGZk2eX72Egkp6Yl2IknMudMF7ptPQT38vzIQMkIutzM2IwZogfUvFTMuxDtxMTPGQvo/V7WbSthitnmakDDeYnw0Z7qMVpOGo4Dvb43Ht0Uron+yf7d+XNDPtqlvzDLAxDesdUcjf346jwDdSGVq3vxDdNjK1Mo1bi11LmuZVlX+J5JoAAAIE5/oJlpUzpJS5Eq2X0XYZ6GhHH31i375VD5Yj9CRyX8V8jrzzvO+FucnFkH5tUnwMVjSzfxhkRI1zJV5UoXzZNH0O1QA1EHHAh/r90nlHRQrK2uaPP0OdJUuy3uvJe0cFbNRgeczDfTQETQ6Znj97FLHtU4djfYjetkPg6OH+inVm1YVhEsGuvzU/J+p13l5ekPuCRnXFEca3G9MORx2oYirIV4G7oXms7t59x+GTxiJc9Ey9tZzo3swhsNg+7yPGBWK18QaB9991xwxqSMR/KRNLF0wGneSZJI7dgdodYD1s6g5hC4wdCdRVdEj/4YasOJ7esxiPTkMzYSR+vGOLjBa8m4Y62AAJf7+Be+hgfXi6Y+R+vuXHtZAAxo6HqJ6wgoFv3IWkkaFqiD7O/L+vHPewy5/s88I/hZ
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR04MB10065.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(19092799006)(4143699003)(6133799003)(11063799006)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?tAr21MdZs8swbB0oYEfdmx3SAwMHDy2oAjL3JsvKZSZeDYgQKJhLOE/AKSDI?=
 =?us-ascii?Q?06ujbl9drCHOKR00AsNtDXPFh1gsGiF9QAEtJJzI9VXzl6ocpLPTEU31bh9o?=
 =?us-ascii?Q?ifVyufidWyPupSpm0RD49W9Id34Zmx8VfmAzUdLzCOEPdb0VRbTTuta7aJsz?=
 =?us-ascii?Q?zp8y6NUFFbPjz91Qi2M6FOIP+VBci5uUD4Eta1gdqNoZKenT0YbyurJKMy7B?=
 =?us-ascii?Q?1OTps5JyTvrBgzbz5KA+5XSTx8SE0XFGFMRmN2DBu1dyNRj04+u9RDyXnzNO?=
 =?us-ascii?Q?50C3EgSosQxIRQeI+OfKLvruu9Ncb/XEJAjoJDgHIr9svWumCTxJRdOJCcNg?=
 =?us-ascii?Q?G9+BC7yOIRzaCf2G0fJ2OIQxLmG3St5A+q9VZ0t3zwIRlpKh/IcJ0GMkX6c7?=
 =?us-ascii?Q?o9mie8Gttx50m+SeJLgvuS3aVsmxDc/e0VmZqqK5eQUbb6jYIHE9M6D3w3l2?=
 =?us-ascii?Q?db6U77qLBuqvMMLd1KDo7xUtyulIkH3A/O+Jc4HLuufPJ04ricQ+5RyFahoj?=
 =?us-ascii?Q?JtTFwI1IbXzfxGqILAAEpLmvOhFwT/HMe2W284ne9FecCV5Axso/niGOL5xD?=
 =?us-ascii?Q?HRuEXLmkoKA27Z/fO9EDt35+FSvHIelsnLxbbKFeeYqDBd0KMV78lQvu6nvv?=
 =?us-ascii?Q?VtEuupMhXdCafJyy2i3dE7zYBayFNmuVGj9/GpSZwuLeQXldh3ULga4jh4Rd?=
 =?us-ascii?Q?jwhUYlgyEdFLRvEbIE3w9PDiMKhYoHfkdjJla7ZQkDkIQebN+rRYQ4nca1FY?=
 =?us-ascii?Q?aEIK0sVC6D6AyMJcsjIjnz3QUGoYLQ3VMA4OkiBApFPOkdpfjWS40vBLuth4?=
 =?us-ascii?Q?14zzUuEmQSXsCf5mxaSlSHvYMUbCtobmpyaCTyjXI3rmt/2zCLEc4p6JXUwn?=
 =?us-ascii?Q?r1B8SVcXReYGCof9c/0Jl5ZoGLtoDtwSsghDL3QFur42DL0RZG3cdphnaPxD?=
 =?us-ascii?Q?pSwm0E0h2pV+3SmUWExPagN9qbhf53bZiZJ+iouZe8fIouGePdRsSMYxEYfi?=
 =?us-ascii?Q?2RGNTLCexmpPVia9Rl9J2E/oN4F/ARxxY207jJJduUKLGNxWjl/XwScGAehZ?=
 =?us-ascii?Q?5FwirhNSWiMvJNpcfBD1HhVsZjA937QEGFBPOha3eoDeaqsdy+wS5WdFVyae?=
 =?us-ascii?Q?YzL2b6O99NITH0kFcxY/qK9IFDGPSrQxFN3YHIO8cswpwtwstvIQ3gGv1a0X?=
 =?us-ascii?Q?YmGXJU8Htv5G+u12nKzqM4JwiHXLALDE9FyCj0LoTB+Xojk6k2eooWd+M2B7?=
 =?us-ascii?Q?AxTQLdb9r406ehSzaFtZR0HZhhl82vcTMt+fJ51izw1U6dXzZoqmTmkAsG3t?=
 =?us-ascii?Q?O4Pa6BMHYyQMlybIEsZfUsDnY+8JUaOaQHhjuk0G6PvrayCCFixyOZ6ToPa6?=
 =?us-ascii?Q?74PCVaf6lQQl/0uCUmTVZ8s3s4A80Z+jFJleBVOQxOKL5+28UgvaGVT9cJfQ?=
 =?us-ascii?Q?LS6ATrdbHk9RUGS1UoTh5gdN3hxzbDRP6NwEACTyWtzlphZAzVIiBSRSyb2+?=
 =?us-ascii?Q?ZJuRG3GjZ9IXfsiX9sjU0N+oNpq3A+Fd6DPwOE2t+hoS/UvJ/NjN0d6+aJfE?=
 =?us-ascii?Q?15Y98kvEPXZ9lrBAmBsKctENYpBHW/ED+fMsEB0Aox3/F/6QiKtpK5+vnzE+?=
 =?us-ascii?Q?d9lRzeOgsXGYaofLpMs3JWbHRGpDExjeIIF8c+0VlxFygKlhqkjB6Ft4pGjK?=
 =?us-ascii?Q?3cakp3yMYZ7kiUp132Yd8MXDJXa0ovrNjhQjrlyZ4P8NToZPhS78xyMH0obB?=
 =?us-ascii?Q?IBQSifFQyCiQXtsb9LiaFiL0Ean5iok=3D?=
X-Exchange-RoutingPolicyChecked:
	WgasdCP7M5/2dRbwyfSS9ZkskX+BrNKOsKaonyEm9tUOHOYwBgJJI91lm59pvJQT1xT2Zxy6Hoilnll8v3fr5JGH7s3AfFS/AN02iWywdmhceg/NBbXjyHPPtoiE9sMqMjU56suEynyljRPlH1HiyeK53DpVsQ7R9DiCs9SoH1nAd7iK8+DFPRft0epS/pNDTUEGZvcjVWQMmUw9T80dqmPr7Njy/8ig3XbMO/duwQFOoEGQqz8zbeWP1v3YL4NXsm9I7OMFR3biujOuFNl3jGCIDfTZrLyKnXou6yRIhuRMAUt7V1pB98mzw6AckyBcjxsfe9niCiUeAhJZPdGQMg==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	l7CEGig2CXCZcqitkpPRN0v3RFZBAZ1JhfzfDiWUujXwEMRncCpU30hq4130BhiAa5GNa9dtSFnVFzBMHPB5XQmjPC5IqRGmNyo84wPT+nP/n8X10WpT0CXyqGdlzPbCZiv3TK7XJ8RUMCoI0WYWYi9QcGK4ap64izAsJdPSu+kW9MdeqDVf+7MM9W9I4Kwsy87RKgmtAYI1ZQi+UJezVnCD/LE22AGL4s4qIPC7FbJQ32e+VE30y8hFQdpoEUZm2XBr5slETexu2NfGP9V5hh5fnS3e2khNYffUemn/ec5EZuVbWHJPd7sBb/vRl6IrD3sAQvbbzV0EWOgfz2YkPtt7WUIi/AJyQul7IBHqdydGOUkLwnD3rayVLb1bpVdwIedKRKVryLvivzxUsIY9iPVgZ6U0xQb2qMQxt+P9xfOGmEqjHaxX4vggbpqVICYao8tQ6O7phF9aHkiQ2OQmC49mw4R96QRspWTxW7GOLEzvUJdszflhTEahahRft1hyRBM/3x5/lnwrG0er/+n6PVS4RwqbGAvGIDUyBPTyrKgjoXyQ6v1DEsBa/NVl+yOsRenlm8LSIzxhxZ4iv2raON2j8RNy93WzSYqtIsBnmZMQfGj7eiiLWMsGx886W2Vl
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 297f3d7f-40fa-48c3-5359-08debbe5e1eb
X-MS-Exchange-CrossTenant-AuthSource: SA1PR04MB10065.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 May 2026 11:48:34.7583
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: drYgOxcFvu+vd2XN+GCeozr+V7vi98wyq+CRk+AjUmUf0wevDHGoUOLvkHG3xYnFuvxVtWEwLWz3WgCC4+HMWPvuyeXCKxEUTNi4F4CsDec=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR04MB6305

On May 27, 2026 / 08:15, Damien Le Moal wrote:
[...]
> Wentao,
> 
> You clearly did not test this at all because if you had, you would have seen
> all the warning splats that your patch triggers.

FYI, the blktests CI run for the patch caught failures at block/017, zbd/004,
zbd/009 and zbd/012.

# RUN_ZONED_TESTS=1 ./check block/017
block/017 (do I/O and check the inflight counter)            [passed]
    runtime  2.264s  ...  2.140s
block/017 (zoned) (do I/O and check the inflight counter)    [failed]
    runtime  2.107s  ...  2.080s
    something found in dmesg:
    [  207.429382] [   T1852] run blktests block/017 at 2026-05-27 20:43:45
    [  207.466894] [   T1852] null_blk: nullb1: using native zone append
    [  207.479158] [   T1852] null_blk: disk nullb1 created
    [  207.810531] [   T1956] null_blk: disk nullb0 created
    [  207.811528] [   T1956] null_blk: module loaded
    [  207.830801] [   T1852] null_blk: nullb1: using native zone append
    [  208.404359] [   T1852] null_blk: disk nullb1 created
    [  209.174141] [      C2] ------------[ cut here ]------------
    [  209.175354] [      C2] WARNING: block/blk-zoned.c:590 at disk_free_zone_wplug+0x30c/0x3b0, CPU#2: swapper/2/0
    [  209.176896] [      C2] Modules linked in: null_blk nft_fib_inet nft_fib_ipv4 nft_fib_ipv6 nft_fib nft_reject_inet nf_reject_ipv4 nf_reject_ipv6 nft_reject nft_ct nft_chain_nat nf_nat nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 nf_tables qrtr sunrpc 9pnet_virtio 9pnet i2c_piix4 pcspkr netfs i2c_smbus dm_multipath nfnetlink zram vmw_vsock_virtio_transport vmw_vsock_virtio_transport_common vsock bochs drm_client_lib nvme drm_shmem_helper xfs drm_kms_helper sym53c8xx nvme_core floppy nvme_keyring nvme_auth scsi_transport_spi e1000 drm serio_raw ata_generic pata_acpi i2c_dev qemu_fw_cfg virtiofs fuse virtio_console [last unloaded: null_blk]
    ...
    (See '/home/shin/Blktests/blktests/results/nodev_zoned/block/017.dmesg' for the entire message)
# ./check zbd/004 zbd/009 zbd/012
zbd/004 => nullb1 (write split across sequential zones)      [failed]
    runtime  0.152s  ...  0.626s
    something found in dmesg:
    [  231.263084] [   T2067] run blktests zbd/004 at 2026-05-27 20:44:08
    [  231.714947] [   T2105] ------------[ cut here ]------------
    [  231.716700] [   T2105] refcount_t: underflow; use-after-free.
    [  231.717849] [   T2105] WARNING: lib/refcount.c:28 at refcount_warn_saturate+0xa9/0xe0, CPU#3: dd/2105
    [  231.720269] [   T2105] Modules linked in: null_blk nft_fib_inet nft_fib_ipv4 nft_fib_ipv6 nft_fib nft_reject_inet nf_reject_ipv4 nf_reject_ipv6 nft_reject nft_ct nft_chain_nat nf_nat nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 nf_tables qrtr sunrpc 9pnet_virtio 9pnet i2c_piix4 pcspkr netfs i2c_smbus dm_multipath nfnetlink zram vmw_vsock_virtio_transport vmw_vsock_virtio_transport_common vsock bochs drm_client_lib nvme drm_shmem_helper xfs drm_kms_helper sym53c8xx nvme_core floppy nvme_keyring nvme_auth scsi_transport_spi e1000 drm serio_raw ata_generic pata_acpi i2c_dev qemu_fw_cfg virtiofs fuse virtio_console [last unloaded: null_blk]
    [  231.730390] [   T2105] CPU: 3 UID: 0 PID: 2105 Comm: dd Tainted: G        W           7.1.0-rc5+ #3 PREEMPT(full)
    [  231.732289] [   T2105] Tainted: [W]=WARN
    [  231.733281] [   T2105] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.17.0-10.fc44 06/10/2025
    [  231.735090] [   T2105] RIP: 0010:refcount_warn_saturate+0xa9/0xe0
    [  231.736514] [   T2105] Code: bd ee 5d 03 67 48 0f b9 3a 5b 5d c3 cc cc cc cc 48 8d 3d ba ee 5d 03 67 48 0f b9 3a 5b 5d e9 ce ea 85 01 48 8d 3d b7 ee 5d 03 <67> 48 0f b9 3a 5b 5d c3 cc cc cc cc 48 8d 3d b4 ee 5d 03 67 48 0f
    ...
    (See '/home/shin/Blktests/blktests/results/nullb1/zbd/004.dmesg' for the entire message)
zbd/009 (test gap zone support with BTRFS)                   [failed]
    runtime  11.646s  ...  1.424s
    --- tests/zbd/009.out	2023-04-06 10:11:07.928670527 +0900
    +++ /home/shin/Blktests/blktests/results/nodev/zbd/009.out.bad	2026-05-27 20:44:12.743034470 +0900
    @@ -1,2 +1,4 @@
     Running zbd/009
    -Test complete
    +mount: /home/shin/Blktests/blktests/results/tmpdir.zbd.009.xLW/mnt: wrong fs type, bad option, bad superblock on /dev/sdd, missing codepage or helper program, or other error.
    +       dmesg(1) may have more information after failed mount system call.
    +Test failed
zbd/012 (test requeuing of zoned writes and queue freezing)  [failed]
    runtime  42.181s  ...  23.791s
    --- tests/zbd/012.out	2025-03-06 19:32:02.536851507 +0900
    +++ /home/shin/Blktests/blktests/results/nodev/zbd/012.out.bad	2026-05-27 20:44:38.677211476 +0900
    @@ -2,6 +2,4 @@
     1
     2
     4
    -8
    -16
    -Test complete
    +Test failed
