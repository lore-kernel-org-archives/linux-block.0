Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70D57433BAC
	for <linux-block@vger.kernel.org>; Wed, 23 Sep 2026 05:30:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.153.144
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790141422; cv=fail; b=uDcXjlobfJT6Hh01d/cMvUB7mBR4pBnQWc3IqnNX9fzbYcBWbe83ciKoxS48IjTweS2OpI+O83g0ogUMIi+/Du89UCoLzOCRx/baOXgLG6rgNABYxS5tXh/9OOcNTh/mBsv2SlCEJMRkGwb07KOEqqt08N7brS0m0D4rRghxuto=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790141422; c=relaxed/simple;
	bh=hGSaiUErQG14wJc+YxHQ6EymysCoepNMIcVRw8GJzQg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=kdNfflugSFMRqYfzWptUpznfekag9v1PIbCMNzOEoj9WV15DaMoMsd2RuaVKuwXqdeMNuICybHlGW0z9ESIdGqvsFc+vgnogSNx3ElCkNh6zcPqxxA4ZWMsSaXiWTp4ckW5MYNaqWeJwM9Xs2IDAu5zM49EGPWm7/O8QYZQ9Akg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=nBXjX5Ej; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=s4W2sJI2; arc=fail smtp.client-ip=216.71.153.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="nBXjX5Ej";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="s4W2sJI2"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1790141421; x=1821677421;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=hGSaiUErQG14wJc+YxHQ6EymysCoepNMIcVRw8GJzQg=;
  b=nBXjX5Ejy4kzycjnBxHOwPF55uKJ4TaPuf/v1f8LvxSTKMXT2NsKoygS
   q95Zqj77CqVtsghZT6Ac9iKWVlH46V3bPM+Z2huLmBn3P7WeUpMy7/xTf
   KmMngK87r+IN94EGf5MM6ckVyzD+zBTvnnTsLYVIeF2/za5E7aLGt+THd
   EEzUx3EP9Yn/IJd0ionF5V1CoCbOcetPC3j+EudVdX99QBSAmkWfvEIal
   OHrcRkiakMCd7nTGWyRb42wNYrDnvgOaj83llku/93NnogJtBXwxFSMHK
   ci+jeQtAu5zY4y4JELsHwDEVGPh4oGZfzhJcmOMA2hTMmj3mJrRmYdWwZ
   g==;
X-CSE-ConnectionGUID: EAPJ5KOBSbikiL9fJSGGsw==
X-CSE-MsgGUID: wU4xxoIfSbmXb6IzJnSqjg==
X-IronPort-AV: E=Sophos;i="6.27,117,1786982400"; 
   d="scan'208";a="155374958"
Received: from mail-eastusazon11011011.outbound.protection.outlook.com (HELO BL2PR02CU003.outbound.protection.outlook.com) ([52.101.52.11])
  by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 23 Sep 2026 13:30:14 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fb3IaLcifQsSxo391WH7yrAkVp/KA48U4kjXJLV192VbmCw12WpY16o6M8668PCL5HQtv8Adm2h4dvaOtdTa7pfmdi8ZGpSTM8TO1dVj7XF810aHhJnwdtlGEfUXAzI0kMhtDnw1jJmmQsitELhoLxhvNP0FpxMRtxXL3iUFa27BC2MyjECS6DdUhrrK804g9i/ZE3ELXl0gzQPSKwjGsYkCGJPJmlAsx6Ra14pSgjzanWdw1mdZ0CYQsGC7Yb1L4axC4cAuA3rD0OHvPp1ehveC0ly3v5pj6feB8q8aaiuHeW97bi2KzbDg2DHGlItGA/pD34wBzYJEGvpANT7osw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lLAoyXtUTUiSTH3+PhTmoZX+EQaSNuk9KpNKQysSj4Y=;
 b=zCcGqdVOffIh/KhRjSa1ZJiQk39q46e2ML+SAMGpaFQSha5s2ez934qx+WurSkYCOkoEi/l33O7Mj/q5Uhr4CgIsLkfSvvT6YrdVEFTMCLce3OfZelYF5aE4lVocrOOnXBmqY+dn86J8YRIG2ndoHJSkPWtJ8lqex5G/7XXvDhqQYQ95dl3MJH1paodna/m75GdoU9sLpAUv5t80pkBLHssmCk76+dsoCyl9X/MBa6on0qy2EVlhuu2LhtmCBZi7z85mYPcqpSj5A6mZRY19mUFht8f7LYKLpE2dwgTbyf4wOlEcW1LM8vOvsZwj40wIY6y7NwZ1uZOSIjtwjZCe5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lLAoyXtUTUiSTH3+PhTmoZX+EQaSNuk9KpNKQysSj4Y=;
 b=s4W2sJI2D8r/QZc8xlRAQpqsAzeMaEbICCu3NJ5RQGc6impjzdY1Gi7NxiFFynX4OtcroPgJOpFZl2IZiLntVYQo/OqRs3PrzN+840/sexarq7ByhCddRTQDdY2c/uqC4MlfNpjf/Z326myanQRGan22cgUFFf+o8mOM7JjTscE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
Received: from SA1PR04MB10065.namprd04.prod.outlook.com
 (2603:10b6:806:4dd::14) by BL3PR04MB8202.namprd04.prod.outlook.com
 (2603:10b6:208:349::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.16; Wed, 23 Sep
 2026 05:28:30 +0000
Received: from SA1PR04MB10065.namprd04.prod.outlook.com
 ([fe80::9b98:bf8a:b0b1:ef85]) by SA1PR04MB10065.namprd04.prod.outlook.com
 ([fe80::9b98:bf8a:b0b1:ef85%5]) with mapi id 15.21.0451.014; Wed, 23 Sep 2026
 05:28:30 +0000
Date: Wed, 23 Sep 2026 14:28:24 +0900
From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: Jack Wang <jinpu.wang@ionos.com>
Cc: linux-block@vger.kernel.org, Jack Wang <jinpu.wang@cloud.ionos.com>
Subject: Re: [PATCH blktests] tests/md: add test 005 for raid1 deadlock under
 I/O, limit changes and recovery
Message-ID: <arNiSSZ37GJF431J@shinmob>
References: <20260910100916.1638378-1-jinpu.wang@ionos.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260910100916.1638378-1-jinpu.wang@ionos.com>
X-ClientProxiedBy: TY4PR01CA0019.jpnprd01.prod.outlook.com
 (2603:1096:405:2bf::9) To SA1PR04MB10065.namprd04.prod.outlook.com
 (2603:10b6:806:4dd::14)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR04MB10065:EE_|BL3PR04MB8202:EE_
X-MS-Office365-Filtering-Correlation-Id: e50b86b1-69d1-4a5d-9d9b-08df193380c8
WDCIPOUTBOUND: EOP-TRUE
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|1800799024|366016|19092799006|10067099003|56012099006|11063799006|18002099003|22082099003|13003099007;
X-Microsoft-Antispam-Message-Info:
	tLfOoi+D1ndZjn18mR4iOpCoLsHp6+cb8MuPBBjfdPdGkF3flueWM1p4FlPpPyC8RwsO85CQFIMfI4M7mJtWNv97xmjC4Pd8vlNqQDH8E0NFNCSyMkD+iq4SjZYaImm65oeIZzUukQveBSONScyFei/OpA5I6YASNm1KLsZMI24vbiLfjfVItCIEJnHTxOxGhmiXcdKKc3Y868W329nl1D5tKQqRpySCk7SC1X192JmO1Xx7bCClGe3PXpLWiCDMQvyu+Nw6gg51W5RD6dmr0eME3n+LjXhd1Y1u8x/bNOIkyujP1AqYRoqd4le0f3U0odnInKLS3nb5MV9xCY3kx20JQhbWXXS+bQkA5n5xx1fn/Zh7NLgcQ0SyFcrUBJXKYcqK/TJ7qPIaIjxrHZ0H6/zyCBWN2FTjxCHStsoZUdKw4hK3iyiABcQ1LMq8a5t8xMqgrtFWJA/QEI/Yl8WIB5f4/iRt7ChYXrDlNa6hFbjvdBDGgK+9+l//7GuOstmqQzXjtbLp2KQC9rspf9iMO7DJpZWVlB16CZsOaKxE73ky/YNkyUJzKKasTKjsVKEkGOWjooC9Wt1FVRCtbsZHfxbn1IYti26LnTZigoX67vyR3Gll3kTtFKA9+xIiClVN
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR04MB10065.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(19092799006)(10067099003)(56012099006)(11063799006)(18002099003)(22082099003)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?e5Fy3reYHelflEsfSBoHCrUsM378VirL/dLMBJznPizIg2ERpWCzJs3i6MN0?=
 =?us-ascii?Q?wR1eOlKH3UenTU1aWPEh1TMl3+OpsdA6PmBRHFWALphaQDug2kMRqHFVgOh3?=
 =?us-ascii?Q?Es2vu/Yv2O6/TFpTuNxgW2ZUD+VH3ODyq+qORKN/omPBCWnMhCcx2Hs78BgW?=
 =?us-ascii?Q?kak7tkzeSUCy5h4QJHmk1EmfIaS7CAiMi0tgZUaL9QixaxbcDrIetxHeL8Ce?=
 =?us-ascii?Q?8gdJ+v7OqhOet67pZwvX7F3fH5n765gTLYifUyQIkoIA/WeDqjVqtP32tvp+?=
 =?us-ascii?Q?qUUrFHt2ORt9uHFEhJH+oqRn+tJ+jIJyrzx3oUGBJpfoe6wjCjugQGXCRfRK?=
 =?us-ascii?Q?eyG5igNeb/lGaqZoH81ZlSmeNbUKDNzt3FfjxuL4Eopp1p1cT5z1c/b0nSdd?=
 =?us-ascii?Q?OPrPb6ja7XyG5kOFkXIX5opm8YN+eUky7L/ruH9dCO0z5XjePWlB1tTxtLnz?=
 =?us-ascii?Q?TWTn6RkzZE8ZgvVdpeqMtL8UxL4WKSdmy4Jtyxk60J4dkPOmvMReYYFC3Tvl?=
 =?us-ascii?Q?OsJ/9dIGP96T1igalJnNMvkkoeIvhI7b+85zz+11uXxP9+VA7rsDoApSb7Jj?=
 =?us-ascii?Q?ox+AzuBBWtuePGW1oiifJsniZYTkSb1AxJc5B8pTfJL8kKNVGFesWv9bXdwv?=
 =?us-ascii?Q?2G9rQpDxIkCuC2pjpWdVCy99VdG8vS3xKINa+efCaBpxKLolfoteY+8EvljS?=
 =?us-ascii?Q?ieo2xT4jwVHxohAhIM8rwHimmjbcw801PKeaChqf4dpbYo6vmbDfAFmxkSLz?=
 =?us-ascii?Q?4ziOAVIDjT+4TK09Lapyaw86aIuhtXJjqGButHzgA58fKAvPd0anWTdftR5W?=
 =?us-ascii?Q?mdTuVjSuBTFuhMxJIKrG74eVX9F13B4odmhrTfRq+KqPMzapmoqRe10H9sDt?=
 =?us-ascii?Q?8/gPaUq0i7BQ14h6gkpFyitmz7KPUyh0kRwLesPi8ez/dG9lWgWxZfvc/jNn?=
 =?us-ascii?Q?gdbuldSmkRufbAUU3KLSJ2bq8r0jTuUaDO67Lf3OZor/4KuWbGbwwwUblnDR?=
 =?us-ascii?Q?g1YoZqhUoEW4kbdOafTW5B4pDf2RbwR+TSP08ZO9DDumtXTSc5eq72yACrp6?=
 =?us-ascii?Q?lIVttPO5U0H7WKO6S0cmK6fKjioyMLukKOjetaVaQ+xH2CbyF2+T9u/NqCpT?=
 =?us-ascii?Q?xQryyvjf4z67tJMybWOGYhsqvnm9rko96x99YCdSdXiiJKAjMhGcee+8QqSe?=
 =?us-ascii?Q?hwEW+N9BLev13UaOjoysYn4cXy9vjdq5lM2lpivtZT8FN+2Fmfl97GVjFf1Z?=
 =?us-ascii?Q?P5/4F5uCSaGT9KnE1l+96QMgQDfj7zLv4VAaMV30al3KHuroQBLAlxKmW4eu?=
 =?us-ascii?Q?8zvMlBcjN30E3zyGu9zJUwWFV1TZfzRqU5dtEzKJZCasYyhxBNLt4RPAVtkP?=
 =?us-ascii?Q?F3HbdxOTW4WhHv8N4i77GUq1MnExEzThBPSQcCmreax2JzC1XZ4tEphHpKVd?=
 =?us-ascii?Q?474GrIjLiOVDg2O6RKfUK5nVpzCURXriddtSkoS+8EjTQ1BnqzSLYoth8T9p?=
 =?us-ascii?Q?UjmYUQ5uiupxVkDCEi+8/Ra6Y5nklL8tkW6bJbA/uk0i1YOo4NzSjG2X69+B?=
 =?us-ascii?Q?pEtfLWElQLt+9WSoqJjzeLDu1X6V4tRoyHh9WYA75+e02fPOaKefEPjqgboj?=
 =?us-ascii?Q?qByc6sYz9rn6A8w2Ng5msSWkiWuelklmKP0XjpIjZK2oiaMP6MYKZq0VaH9/?=
 =?us-ascii?Q?eJZh1ZsgXKgBRZcoAeMouTaBO3b9ulQUjK4hKi7Tl+2Nv0nuJ9IV+rp8IQqf?=
 =?us-ascii?Q?7n+T1JTsSDwaegZWE3oN5AmSHSG7EZs=3D?=
X-Exchange-RoutingPolicyChecked:
	TUrEieGbeluIMePxQ9TIxHOIus6PFKp7x6rBLLiSAtaQImGGnzIkwCaTaEfWRU85sXR3jVuWviXutQ4LOWroF598iHz75avNeYeqaSAdneU5ZdXCPKGHgzaicYmef0oSskbcNk1iXiTkSZdumz1rht7ZtgqBdMG7ykxKsqNCRhNEWuqZhKAqXBD9/JjanTYvOKEzuCOqBxmigMDMa3+qFIrQx/stgTHM72U5NLSgKTrKYNxv8PS9CAsPDRMiRDZTljSjt22kVy/YAOSGqVjilDUrLnVOb3wkaEcfy9dSL5+SJwlDbpJOV5DqrKMWaWFFnOKNEBY9ZWbyG4SRHAwMQg==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	pQJuHNauLa84YVyReI/6i2ZLaT7DFESR6Q2akyN63BUfdbgAFHvkKF/MuFxd1kxQ+ZjzEnd0bnwWGmEHnSPU+XoLqggg+9sgsWwpKYvUofnWakrWeSo5+fpL5zFlFI45/0P+qk9w1fl+02urXcFxa6gj43FaEsH0nupnDR/sKxAd1G1ez5Zl0lMBCx1CGQTd9TK1q7RViTgBxvdOg2nW0HElfUUaVWd+LSm2uJkQW81ys6GjXQ8Unk09/fc2eSyqLbQukPBooqIRESI9iEdGSb0pLRmh45BtdHqL813Ilc4X7Com8gB5ccof7vKrRtt0TCwkMuYR1tRRCjzuiANHHtcHU/FsUWFi55RemE/vQRDQsdpIOCXS2Uhl2L97qSiJvp8wtsK1E5e/FZXPgkCXTgO5ZoG1jCRBkD8BVUhv3tN9oh1Mer4zIUvKflbjpVZVdFMEDgLFCZtRHdEoJ5mUe2LDYw2J49nMhYQtCvq30l5nAlxIqFreh4tfmg59p7p0I+T4NWZIYrXu2lTRQ8YAO95VmMAkIfJOVpahBVSZJ7G835ShAyRt6YRiyv68DxyCNZj+pNv6sAGeGRu+KXJhzmq7GNXRqi5T1QLrqR8ykXjNWd6PweOKNi9M5lHSOF5K
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e50b86b1-69d1-4a5d-9d9b-08df193380c8
X-MS-Exchange-CrossTenant-AuthSource: SA1PR04MB10065.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2026 05:28:30.5849
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: freacwlYWVSJChu0xHb+PXG4fB6wFQEcMoIPyfYtqBMTmd63ttMpm5Hp1xbms3eGxgfjQB9Vjvj1woQ/fygXJYJ/+kfk7P22kp58EwWi1YA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR04MB8202

On Sep 10, 2026 / 12:09, Jack Wang wrote:
> From: Jack Wang <jinpu.wang@cloud.ionos.com>
> 
> Add a regression test for a deadlock reported against raid1 with an
> internal bitmap, where concurrent I/O, queue limit updates
> (max_sectors_kb) and device fail/remove/add (recovery) cycles can
> deadlock.
> 
> The test creates a raid1 array with an internal bitmap on two brd
> devices, drives it with fio while repeatedly toggling
> max_sectors_kb and cycling one member through fail/remove/add, and
> flags a likely deadlock if any of these steps fail to make progress
> within a bounded timeout.
> 
> Link: https://lore.kernel.org/linux-raid/CAMGffE=heGA3y8FjQ0Sm1jj-kd-=H9Y54WozKASSEZhc9UNKjA@mail.gmail.com/T/#t
> Signed-off-by: Jack Wang <jinpu.wang@cloud.ionos.com>

Thanks for the patch. Overall, the patch looks good to me. I have one comment in
line. Also, I ran the test case on v7.3-rc4 kernel, and confirmed it avois the
hang. When I applied the kernel side fix v2 series [*] on top of v7.3-rc4
kernel, and confirmed that the test case passes. Good.

[*] https://lore.kernel.org/linux-block/20260910081114.1605746-1-jinpu.wang@ionos.com/

I will wait for the kernel side patches get settled on Linus master branch
before applying this patch. Thanks!


[...]

> diff --git a/tests/md/005 b/tests/md/005
> new file mode 100755
> index 000000000000..5493d0edc933
> --- /dev/null
> +++ b/tests/md/005
> @@ -0,0 +1,142 @@
> +#!/bin/bash
> +# SPDX-License-Identifier: GPL-3.0+
> +# Copyright (C) 2026 Jack Wang
> +#
> +# Regression test for a deadlock reported against raid1 with an internal
> +# bitmap, where concurrent I/O, queue limit updates (max_sectors_kb) and
> +# device fail/remove/add cycles (recovery) can deadlock.
> +#
> +# See: https://lore.kernel.org/linux-raid/CAMGffE=heGA3y8FjQ0Sm1jj-kd-=H9Y54WozKASSEZhc9UNKjA@mail.gmail.com/T/#t
> +
> +. tests/md/rc
> +. common/brd
> +. common/fio
> +
> +DESCRIPTION="test for raid1 deadlock with internal bitmap under I/O, queue limit changes and fail/remove/add"

This description line looks a bit lengthy. How about to make it shorter as
follows?

"raid1 internal bitmap race among I/O, queue limit changes and fail/remove/add"

If you are okay with it, I can fold in the change when I apply the patch.
