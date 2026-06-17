Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 649DE347C6
	for <linux-block@vger.kernel.org>; Wed, 17 Jun 2026 04:29:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.154.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781670569; cv=fail; b=mpidIUjCoXDelDyewy/ht/NRr/XNCJlVSxrl3BiIEU1BM+uFW/XzO3cRfO3C/8R5xtQzlcjt8epuYYrVnDB5YUpIPnM70yvfQVy3e25bKUrMt+bRA3hU+tssRsLS/PFxISyZ8wRboy4qrCR0cLrIuBMZlSTgUS1Jt2PLrSqf8Xg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781670569; c=relaxed/simple;
	bh=HB9nZZTJ/wu79TY6jv1uedkPTWWglmQRYvxZbfH9xhY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ZUCDFPfqZQsTjotVJOS3sLO+Er+vdUJ/FeRKgnay4VQrH4KukzX7f87KODd6c0pdocnNolrXeQIuUTgDLUgetoZos7jMq6HVzqmyVqVmcnerD7uZkLc0Khk9Q2gqPn9JdLp7PJ3opBx35459A+XympyRhhy/55xErU6Nhwnks3A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=HVTCtGfu; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=VX6ECPVO; arc=fail smtp.client-ip=216.71.154.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="HVTCtGfu";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="VX6ECPVO"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1781670568; x=1813206568;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=HB9nZZTJ/wu79TY6jv1uedkPTWWglmQRYvxZbfH9xhY=;
  b=HVTCtGfudkXiYYUzlFXLFDkKT9+qg5Kr/l9KR4YfbQ6/UrZVJlFeq3Dw
   nsOgy3WUW/BSRChtrRW/PZW7VGwhxaoVvUnXXLBBTKe1ajUG63HrvWHxw
   6EU4t6EPhO8gKLfn7ecE6o2n1Bops/CcLk+vYXcB8R6lihBG4xFApsHfl
   bIm4HJ9+R858FZjmWbExSj+GhMP+40jWpD2nK7eIbbXAT8grM0ytTgb2F
   25fnlldR/qsdV5j8BIB+rG/kOb678bOrGijZ05zBak4FlWqSkicmbp+FQ
   jWbMqw09JcfM+vvFwzm6spZjOSee7dTXewuVziOkX8/BGB/ogb4ugH3sO
   w==;
X-CSE-ConnectionGUID: DVraKuNQR5yzD8g/v04NuQ==
X-CSE-MsgGUID: QQ5Ap8nsShed5dxKJmjv/w==
X-IronPort-AV: E=Sophos;i="6.24,209,1774281600"; 
   d="scan'208";a="147795521"
Received: from mail-eastusazon11011004.outbound.protection.outlook.com (HELO BL2PR02CU003.outbound.protection.outlook.com) ([52.101.52.4])
  by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 17 Jun 2026 12:29:21 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MT4StBAUHw88XB0u8MkdrBa3PIqn3i+H58FOEqRzeMJPnk9qUgKE7XDLwuuUkUu+7XIeJIRAaaW0njwOOFMRryYCWeFKL/6kMStN66qymWB8X1XJHIAKiNpQ71Kcn6zRJlA63gEIGtE6eui1JRDU5Ghg7YYX6nkuVo5p379nLbFkLAppV4laz8BliaEpMSzSSPWoHq/QAgaz91oJesbwq5ffgUAtgPnUHczXzDxU2vQ6VOlh+KQBoovCEXRsQI0E8ezwEFPHT1t3PdnGhBNRh/y/PYM5von4bqeTTJVjRe+Z5kvyHscGTb2aM5YQIz9NHN4OUi77+J0INE6ptBZXqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xfZ/sNs5jzsOl821gsrbeJmkjTBor3kIRWc+BiT85ks=;
 b=Y4o25p0ES8N3bZWcJCBpJcUonwlsDL8SW7RUTegjYi9TZ04DX6953o8rBVplu6lKPu3ynsfXRUoPMRvC1MdXNwgN6sfg7z1wbQ7junecOM4STbqwZQwvIKnE7qx1k0TWKoujumx1dfJgnxfgolCckcl2kjTwJgLcQ/mXB7hNgX5nrQe6oQxLzFYGDCdw/lwb/tCS7AbmaOuJOVjFZLgtpwz7VnhDQ46SrMrvyibTyu7YmFrsdXoVstyd55pEa5OSqFwyUG/D8y9Ly10m3x24a+Jq/T+z3iTF9rp/t2/Tn9l4UQdFkMLFtjHt+r958ROOXbmgRh2KHFn5LpYQzwih7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xfZ/sNs5jzsOl821gsrbeJmkjTBor3kIRWc+BiT85ks=;
 b=VX6ECPVOtqdeb0LLpx7VBbA3KUcbWOrxk9Kw/IPs+sPLsUxOxYa/2CXdjSqItwlVji2aJRO8MlLoFC8nWKhAM4PL8sUmuO8MoeugqJ8eJQ2GyE16hmtADT9sJyVlfSuvqx0MsqKqfRctiNQFohslaKQZPibcd0BpnnJgiAM6vsY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
Received: from SA1PR04MB10065.namprd04.prod.outlook.com
 (2603:10b6:806:4dd::14) by PH0PR04MB7383.namprd04.prod.outlook.com
 (2603:10b6:510:13::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Wed, 17 Jun
 2026 04:29:19 +0000
Received: from SA1PR04MB10065.namprd04.prod.outlook.com
 ([fe80::9b98:bf8a:b0b1:ef85]) by SA1PR04MB10065.namprd04.prod.outlook.com
 ([fe80::9b98:bf8a:b0b1:ef85%6]) with mapi id 15.21.0113.015; Wed, 17 Jun 2026
 04:29:19 +0000
Date: Wed, 17 Jun 2026 13:29:13 +0900
From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: Sebastian Chlad <sebastianchlad@gmail.com>
Cc: linux-block@vger.kernel.org, 
	Sebastian Chlad <sebastian.chlad@suse.com>, alan.adamson@oracle.com
Subject: Re: [PATCH blktests] scsi/009: fix unset bytes_to_write in TEST 8
Message-ID: <ajIhtkOIMXeM6BAI@shinmob>
References: <20260614181651.11554-2-sebastian.chlad@suse.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260614181651.11554-2-sebastian.chlad@suse.com>
X-ClientProxiedBy: TYCP301CA0089.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:7b::11) To SA1PR04MB10065.namprd04.prod.outlook.com
 (2603:10b6:806:4dd::14)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR04MB10065:EE_|PH0PR04MB7383:EE_
X-MS-Office365-Filtering-Correlation-Id: eb5f7880-6dac-4555-7f76-08decc28ff8b
WDCIPOUTBOUND: EOP-TRUE
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|19092799006|23010399003|376014|1800799024|11063799006|56012099006|22082099003|18002099003|3023799007;
X-Microsoft-Antispam-Message-Info:
	OwCp+x/s/I7sWZ0UPftYJDFU8jrY+TPaXzzwAzASz/J5GO7jHjXx8PsODdYnLQpYUpKCQNchp/APEFl6tP7O6dEdprysKDlEtICgryRzTCKiyXCFhMawtS/fM6dEJ9Nmyronqwz6R7LTjxeouzKXGyKAVyZPwMRatQaZTYFUpDgxp1uXNfLnhc45qFEPblfruVe25SQ49jnITCRs5ERzOXJCr6vKabDU2P4tg+G8tTKVxZgMy9vE6MhaUOVYPA59mZzECXWOucStNETNXMaJmnekrJTD2ZMfYsMfD7L8fD/QZQoxikC0x6KyukzikIT2fzQkEJBqJZ119cxebjLoDTqYKuL4NoJFVop4GVuTcefuJAeLgeRN2FiEQPpdf82Kuh+TRdpj7C8FGk/EkqMJGIv9Y6WbcIML50rfexqxJA8rJrpVn0cEdaVsy4sq7jViqMzl7lv2/V23XnlDwydE1gWv4z+NcXdg/tAQSUJ9ItSSOjNZuCoB0m3rzBlmMXsnuEJvUPSRQO4nk8sBAQWYLntcKqrKFCD++AsFRWB54UtllhWnsshu9TKcXRrTeO/DJQwyWW+DncYByHP5doLcseQHffijTI1HaTxnkTWXogFBy933FH//Soc4D+SrpmTtOvllEuM0Yv+l96RlwPxrYG1HGQFr1qi0+gBiOpHs8TJTo1LRwfW0vRk8r2b/X0BjROO6iwpwHTvq+jZ/t0Z3Kg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR04MB10065.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(19092799006)(23010399003)(376014)(1800799024)(11063799006)(56012099006)(22082099003)(18002099003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?F+T2mfNp3ZTej+groLCW3UHuPcgCfBLSlxCsfdrYX9ONWfcXksY2X6SJj4xK?=
 =?us-ascii?Q?ih0R20xYqmclA+fkFkhk7yLEvwycDCVnWJRRghWEAsZX082ddJoCF70XeA64?=
 =?us-ascii?Q?IYvCfJHB1h5inqwVpgymlKCmgm4HHiZC6MLlaKnd3amHDsO6/Xc2GbOmTm4N?=
 =?us-ascii?Q?WOxNz4pxmbD3Z9PwxvocDNeKbv0jKOwMqT8C7xCbvV7leghFogx0h5FRsUdv?=
 =?us-ascii?Q?Fhl3xqLOX+1oObWN+Xf6f72YaFlX6Cvte5w4+I4LqfKAJZfJtUc9Asui0P0T?=
 =?us-ascii?Q?F+0LeJnSlYqxClriSK6wr6XAY+Crhw7HEh1RuXiciYvxv6ovDaEWZeLBRGpm?=
 =?us-ascii?Q?kMV0gaNM1QQAK82CSHueoMf1/9II86vaghT2BY1fXaDUp4Kz/LRExXG2H5Sd?=
 =?us-ascii?Q?XuafpO1nNXXStKsIySH+kgwMRAfYXZy8CadH8rAPQWD9xIxnlK2JSNUORQe4?=
 =?us-ascii?Q?Nlth8eoQeHhRUkrkRwF77dDupwR5R/FkbG9SKlqE6z6fZguqLGnOJizNcmzC?=
 =?us-ascii?Q?0K7n3tiQM8vAYs4P4lo2YkkEzCd321rswSxSTNkXknoEKt9qNiBgBrBs9aN6?=
 =?us-ascii?Q?qawrdfMTfozzXirB4qOwny0zFJjcCImUT2RMzl91X+2gloacNXxJjpr8aEMz?=
 =?us-ascii?Q?NJfVK5keNhyVvnreUAJVuxoE3qAOQAK+iuh5+4E9/3Nw3gSROytTlyZ9KMPv?=
 =?us-ascii?Q?A2mo76S+gkiOTSou8HxKBcNX2jKBxxZI1c+hfPNxkKSI3OK5NdkKg+XEcOnn?=
 =?us-ascii?Q?ZAHPcJEbbxSFtALXWhbujKYmod0Qr6f9U9q23JuECfqwGZVds62j/BSnYc34?=
 =?us-ascii?Q?3lh9hcDudskrxmQSehOEp8P+smNo7KLJUlaBA/pHyJPpfJZtHqAFPcpO/wwl?=
 =?us-ascii?Q?a56PvuTTPxf+9lrV1vww50qZEZp/vqwVjBxtJagd0D/VCwL9HBiPE3z4x8vb?=
 =?us-ascii?Q?ZJf2BJi56jyLsQp8GGqb/zFJjABKUG65k8q7WpXUJIOTl3bhbhkYhjELQTcn?=
 =?us-ascii?Q?UVy7gUU+Rzr9lAsRiFrKJ5XlcXyENKwEM/pRidvE2CqqxecJtC/hu35Y6qL0?=
 =?us-ascii?Q?WlpNXhvljlKiVKB1EuWpOUeGrDdgeUlkIpsWG7gjKZYreF8NdjjC4nvakd2g?=
 =?us-ascii?Q?EM/3dNGokdfaLpF9Pe+QcOAf1CBc/85UPOxAzdY77wr5js9kphuvp5LUlLai?=
 =?us-ascii?Q?i4mkfgFIoElBRb6BIiHErOk8nYMKMRvEUcatQ50X7fP5vXAAIekxFyWGORVt?=
 =?us-ascii?Q?dLqm2YHPlDua7bbV8JBZGh475ISL2j4CqbQC7E2IU7HKLNDCpkP2oc4vr/I5?=
 =?us-ascii?Q?G3EhCISCwDukUfkJRt+aHF/vFfl/rEYxyNn6TlA1qhhpzpCM4QbBKX+Y2gO2?=
 =?us-ascii?Q?KCXMrvScYxkd14nMCAvMgCwiNwcAE+u2Jsd6FJD9zUQcW4N/ZjzHj9pg1U7D?=
 =?us-ascii?Q?JOR32WymtROAzQE/i9/jUQZ3qd4jGVm5xcnJMgmLtc0XDGjm4cBPa8rIZYF3?=
 =?us-ascii?Q?VWdjUZ2S4nEKlyRIl1mLXAAv13yJTRBgIfgnfP7kpxR5mLjaF3RHFazZ/CuK?=
 =?us-ascii?Q?dwBBWcvDKWEQkwWaWiS141xtZN+V9c3cSdLd8gRPdSgP6y/mM6JDuAzJeNH2?=
 =?us-ascii?Q?8T3XbPVC57TCn37Sm8bpGVkYBBDHOOtq+9CcR7PDkahn81/v362GHxqVI4jt?=
 =?us-ascii?Q?KIgzBRcSws+dZYBrpHcx2bkITMwu9r9O2K32eU3R1QlxQyDKTtCioQSAwGeP?=
 =?us-ascii?Q?75+PfuVH7DihECoCPA4DGB/rnG5hlYM=3D?=
X-Exchange-RoutingPolicyChecked:
	kHnwxoeGF4/xYinNkReoReiziZONThYb23KvjVMoADxN+H2K9SDsPJAnDRE00jvZmDzg6N1bmbHTPmKS09wEuezAubQw/AhJF2Ap+fvVtoKjmmJuNroSCAiNEBMAv0Q+x6hnJ+n7OogXtgKg0Zlta5gwuYe/6T0q4W7tY+72zwPP5u+hdzzGOyl3r9Dr81+47T1emLIkPv0donYoQkud521eeFvfWmFX0qTshggqw/0ChkVeDpruDuocNt3tcA6r3EZQLNf5mkufwDqAHDBdRC2M1K9GjhcistweK7jaOY7aqDPeGjCUrlNOOaDK1At8bklXn6gKq/BX73zgetNSDA==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	sPR0EvayRVLkI7gmj8/VHbHfWcai1jtVzcjrMZZSrDil0x0EB4i4MY5G5KXubdz4izGEk7RSmUwAf2TDNBMuLgjPUKs6vagv9Pwp9U9cDcPM+ltzexsH1vH6a70r+0+OW8vRz+9H7jQTX0NzYA/1oHSo6v0bU+dlFmlXJx6KLM4AJWx/gdus9c0A50gzb8ZyJRmjSnaL0uCHRcH1TBoQbuxjMFSDX7+NDQDELAV51qcMNUdl6wxzaX32ecYz+PE/ZIznz8rgnAAAgE8OhuEYDgARcUpvIdc1uSPH0z0EnWX/0ie55ZQBe7lnTiaMFyqht36tQf3qA2iTn7h6bdXrLngylNwiY7H6iicuDhm19ENGrdHvhKA8YltigCBGejr2tkxqT/fxi9vzb8+rrjQ/kvHwkDkh3N7/w0LyIl69RnjVtRjP0YvsudiT+Y87Usbk26YL6XgCzq/kSTJEQ+bqTwNFFNkZKHW0XJ19hXICWZvv/MkJSpS3DSNPEE4FeH63iZJAxAdTkbTxKvBMx5ya7mfWjsSGRHzHlTpEBxyco7Xj+F0XvC8dAfWFj5wYgsSsBIvfHVWMTusut7lDK8Veum+RWngPNsC0p152TgbZej3mrDBBCLsESbpt48jiUmbo
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eb5f7880-6dac-4555-7f76-08decc28ff8b
X-MS-Exchange-CrossTenant-AuthSource: SA1PR04MB10065.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2026 04:29:19.1997
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8RDnG1wDU+0ZrqDiIK1+R+uPTTHhP1S4bhMXfeqb1tKIZoHjBWOzSscMvUqi9xmVvlu2N143g36d9f8dJ/8GemvkYS5WwZpMyexPZ62XGfw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR04MB7383

CC+ Alan,

On Jun 14, 2026 / 20:16, Sebastian Chlad wrote:
> bytes_to_write was never assigned before TEST 8, causing it to pass for
> the wrong reason. Set it to atomic_unit_max_bytes + logical_block_size
> and update the golden output with the expected "pwrite: Invalid argument"
> from xfs_io.
> 
> Signed-off-by: Sebastian Chlad <sebastian.chlad@suse.com>

Thanks. The change looks good to me.

I will wait a few more days just in case anyone has opinion on the change.
FYI: Sebastian posted a similar change for nvme/059 [*].

[*] https://github.com/linux-blktests/blktests/pull/245
