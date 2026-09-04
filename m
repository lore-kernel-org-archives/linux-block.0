Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD52D3AA4EB
	for <linux-block@vger.kernel.org>; Fri,  4 Sep 2026 03:01:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.154.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788490897; cv=fail; b=t28vR7s5JK8Z1a/olnw1i/KYZn9LOk0dwPAVupni748FXY0qrXkbb18h+MaBLPGwmrdana/9nsFRobtqUrTDQj+nRDANjgmU2g6WfTHqg/sbwBee9HLVS3RVZo+HJ4HNiT623Vtlo5mP3F1vGRo/pEDIP+paQW/yFMPiidK+VJA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788490897; c=relaxed/simple;
	bh=Vs6LDe+CGlmGoTuB9AJj0EelWPSqd6j3abgihXMrcu0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Z32zhnmbHZIAlcvFCyf0IcJkrj5i2E/Zk9CmHg2B4U6B8174iSEtzIGc6Gx+F/vQN3ApAZacXVj0EC9/Thp32/8A5sCcpkk5ARo2tIRSGp9HqASZWqEWz/RvYWWEBM/HIUUKvKZFM1fvdDyGp5/ACQLYgJ/knUWEkMS7Uhnzixg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=I+KEnfGm; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=JEMJnctq; arc=fail smtp.client-ip=216.71.154.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="I+KEnfGm";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="JEMJnctq"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1788490895; x=1820026895;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=Vs6LDe+CGlmGoTuB9AJj0EelWPSqd6j3abgihXMrcu0=;
  b=I+KEnfGmPiWjQBC6d+1tHkYdksUdx6KmsBcxBVXBEsnxaJdZ/n3KKZUf
   lyhVRkYzJEsh8z4XCXwlk4vBez8Q2PHi43Bc+ZNeGHYulCQrNu1BCt64w
   Q7D8snoBhmFrxvfon31pmPZD8NCz+tDuqRHsgY8Cyj0Pxpdx5wK5iyS7w
   GDBGXv4kK2DSCPGidcY6uKUa8iUeoMruTWf/tO0Uvf9ZPkm1OjSRbHD5y
   i6Ivwgub7iDa3ZirpC1bBAL9AcsOzNUWwYsyAIub5vU6DgsaVyBXqcLLR
   fj5l3f46tDMiWprwDLzsAwPbeLGabX/SeQcljHX4wQKrsOv2ntwKAd/+P
   Q==;
X-CSE-ConnectionGUID: cZPg2F5YRjCfVIERtMqLLA==
X-CSE-MsgGUID: 9hnSrCDMTB2UUiRqRCucbA==
X-IronPort-AV: E=Sophos;i="6.25,260,1779120000"; 
   d="scan'208";a="150722659"
Received: from mail-centralusazon11011011.outbound.protection.outlook.com (HELO DM5PR21CU001.outbound.protection.outlook.com) ([52.101.62.11])
  by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 04 Sep 2026 11:01:33 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vCC1u9bIxqDlj/37ZcSc5jYRyTt3dd6KzplRjBdfxhLguIMDqprkWkiJSEQZomnEEz3AcNqI0a3ChT1erTRN1lBSflxNut0UWTfj2FahC93ImzlW0y7t2h6DH3QNjufyEYGHCFbZ/EL97CPl1/P4Tl3WvnGp38VcH62yW8b6A0/k3ywDfyeMvNL0iN4A4lWrqkbE1lacH2U11wR+OSOAreRFarayp7dLCENMix7S4aE/fLa/tXfO39v6sW2J/IqQxpzPNAPypKzl8XfK0vwjhm0MPYioayw9tQ46RSV4mctVND2V1sPi/VEp+t63uTD/WIdfZKLCQC1382JD7bNAOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bkLucmfsK96HIpGYleVbtyJ7YaGzgy95OMWsF8sTzOc=;
 b=cyN/uAfX3+/dWQKa9gSqu7hw53gbXgEnwphye3m+XXxXdAsy0AEEDhOOgI7DCdhz4fNnTi8EijVN4jTwH3LcrANogbN51eC8u/oqd3ba1Ads9/mgl0kdmX8EHBWYe0N5pPFw8htUWwPAxspleqq1pNHomoLjrAQY50s+dz5iMHKig1/g/L9SR5x1C7RwmLyrYNq898qP9Z6i8Y3rNh45Lx8A56IuMLWT48gWZ5V8DKQaULijYOCLmDDNDApKtp32ZHsVfTeYzzhW6MLiIkm6Y97WV4QoO52h66xsqc3JcwxnTsdpf4m9TnLEx1cOyFAX3Rux63VkKDlSCsAnNZILtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bkLucmfsK96HIpGYleVbtyJ7YaGzgy95OMWsF8sTzOc=;
 b=JEMJnctqEFX9YOTYOgUYCzBgtXSfRkO0M+9oh4rtnzB6evhtPF6r1lWPv9U4Y2VmwXzZyXwyDyZZg9V2DlMF35/FGnZYmtR0AFAJZRWfJ56wQL4pYtzJp9N141m2cFKEIvZcRGEKY52rF0b7SEyIjmTF0dwvnSOVpe2FWhcTLUI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
Received: from SA1PR04MB10065.namprd04.prod.outlook.com
 (2603:10b6:806:4dd::14) by SA1PR04MB8467.namprd04.prod.outlook.com
 (2603:10b6:806:325::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Fri, 4 Sep
 2026 03:01:30 +0000
Received: from SA1PR04MB10065.namprd04.prod.outlook.com
 ([fe80::9b98:bf8a:b0b1:ef85]) by SA1PR04MB10065.namprd04.prod.outlook.com
 ([fe80::9b98:bf8a:b0b1:ef85%4]) with mapi id 15.21.0360.008; Fri, 4 Sep 2026
 03:01:30 +0000
Date: Fri, 4 Sep 2026 12:01:24 +0900
From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: linux-block@vger.kernel.org, Bart Van Assche <bvanassche@acm.org>
Cc: Christoph Hellwig <hch@lst.de>, Li Zhijian <lizhijian@fujitsu.com>, 
	Akinobu Mita <akinobu.mita@gmail.com>
Subject: Re: [PATCH blktests] block/{029,030,031}: relicense from GPL-2.0 to
 GPL-3.0+
Message-ID: <apo0C2hd3erPRAq1@shinhome>
References: <20260821105335.794406-1-shinichiro.kawasaki@wdc.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260821105335.794406-1-shinichiro.kawasaki@wdc.com>
X-ClientProxiedBy: TYCP286CA0298.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:3c8::12) To SA1PR04MB10065.namprd04.prod.outlook.com
 (2603:10b6:806:4dd::14)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR04MB10065:EE_|SA1PR04MB8467:EE_
X-MS-Office365-Filtering-Correlation-Id: dabdcd7a-a187-495d-214f-08df0a30d186
WDCIPOUTBOUND: EOP-TRUE
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|366016|19092799006|376014|1800799024|11063799006|56012099006|10067099003|3023799007|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	3sRuXlznO47R1H2eLqMaNENbA81V6dwqx02lNpx7FVHbkKCi94QuF37FKZrZvshcvhhjQixd1B/m5iTxcmSmBBdk//thF9EjC3Wj3AkCWW//LpcnHx700VTuq8TrUekUED+ohn4IqysLK5NkAhpNndQau8E4lVkbJ+DKR8KniRyk2j5X2vv9CL/MfBQ7D9QkZBusyQazvxkMsnoA3HWrgsuCGkLaZ8EAsWeykxkco046jZ7GGo9zYV9PfSTUNKfUgq7qycpUbiFjJcrBI32ABdOmq+O+RbP0C54pLFklxw+69wpLayZp8FYVije2zxGSoDdakGKiUCM4Lb1kyhLqca3M5q3he7yJQx39xjH0j3decN3B7wDOUMrvqt+IB7NOwLMR62QhfSDeafYLZgKKIrXVma0sWCFOsloQvKf2E6eoQAoJU67FpLPiqMarwEmxNSs3bbadJljnFqO5CrWivWGUn8zyC7hhkvFaCrqOsx81WnK9r7sbyvkF7dP4sQUJRZmTOgFDeEJ8zduYZ32EJuSGWHksVaS+H9JFxvXAmBCjdcGUP0CTQK1nh6HzxX9/ms168YBnT2V8vMnRauksJH756+GYdRkpCjTzXMqVAxKHg3qfBeCEs+ceQFMxrOoOruH6Lr21Ldx/YdR8TaDu8w7wLcylI4DYcL6dl27vhjE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR04MB10065.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(19092799006)(376014)(1800799024)(11063799006)(56012099006)(10067099003)(3023799007)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Fx7f1JR2ukMFK/Zm1Pp90Fu4IV9Z9NQE+rw1FWVvToQCWT4hFznHGprHlCBK?=
 =?us-ascii?Q?7Iorkzh/wfqp2jNxsfT7h0D/ryhioyAUWoNN5XJBuJhktsrSC+wmAO9GUXEj?=
 =?us-ascii?Q?aWL6gkGHT1kir3vQ6ZbQ1zsHKUUQjlT1C1CWX745RRVjy0mxLcI6ypw3bOjf?=
 =?us-ascii?Q?sTqElD8rR3A68wCtxxUG23HVNHOEJmd3KAuqTr5khN+r0Q1hkGjJM/6almFD?=
 =?us-ascii?Q?9qRV3vhuE66iro57a5XUZ5dOeQpsH0M1yuWjJW9vY8vIqAwHEFqhrMPvKj3O?=
 =?us-ascii?Q?vjaXfRp6Gwc3UCIUzZ6VmCJDBIGE4mmQJL4zoZWLcCwV8GpJj39cCcSqSq94?=
 =?us-ascii?Q?AJl0QXUCspoVGzzqpQ/FURghWBsSZPtBl7xViW83lWx9Fa6UVXEadhlnDv3x?=
 =?us-ascii?Q?OlZW02KA77UW6tWl4BDkGR3W255Hr6Cs/uAq9LnwXr7qHWFQouMjQ2Jiq6Ai?=
 =?us-ascii?Q?SthAm72fGELPT+kEVhyG0UjaJJCxYx43UoVLIXIl3goePYXPV5Pha0IDSgyv?=
 =?us-ascii?Q?Dpx3qpwhJ/hTRWe9LaImLfKwhbpbAa45i0GgQfOLnn6/vh9A1b35vWegsmFy?=
 =?us-ascii?Q?ohvlLJG0gRCBCgCzP0TjMNBJFSmi9h/m9UrFYFmWuh56j6gymxWeDnIjGfJU?=
 =?us-ascii?Q?9PnXiHzLW1pgw9K/l/rZZ3E+VvfPLkGkPaU3dVWguetRac1pNF8Q7UQZUAlo?=
 =?us-ascii?Q?Xrg7JxWODkwkusOzfwV0z0kksvMRybbbijDwp3OuAw6LbuMZ9CMwoAK5sDFL?=
 =?us-ascii?Q?BcZB9VGPgOGP6RPaJnsWaXrsr5LH2raeWcnjdyc3Dl9bLXkrZRZfeXhMBHL0?=
 =?us-ascii?Q?aHPyrHlgPd1xPJtZirRaNA+oF/1VF+7bU3v9LTB6gKT3x4covNp57cy9dByY?=
 =?us-ascii?Q?34S4vbzxcwyKWgfrMo4RMw7RAIcgsS1is1sM20p42D/gMDO8AIGak/ROMPHa?=
 =?us-ascii?Q?NzvMXOqtiu5ZMNrNg9OAqOP8rDmKwsoY/X9G9/E4nZhmaiVbIu+UWRyMdsq6?=
 =?us-ascii?Q?0mvhs/AmFiKI1wTzgg5xY3b/lM9JEs7D6gcjuenoTExZ+yG+sstX+NrMQbe1?=
 =?us-ascii?Q?FCcFWHIAajifKEL2YxLPCVRwsJIIFmVwZ18ea22ukaA7n8z0PUA3hrFECJs7?=
 =?us-ascii?Q?+eY+j+grnnVB+0GpskSHJKAFjyBMq9Fz9LuR7fpqHNBiVdUGnjm2YSz/aZtX?=
 =?us-ascii?Q?Uw7w/wtbPjy2Ve22A2ARWgc0qReY1VfuHl63T5kBPSpPUwLfbYPRNUcTuQcM?=
 =?us-ascii?Q?jxWD9x1jIX5TKDUbhw2d4hTQpg5jS0vvlxLmu19Ad2WZ7LRSWTPAdO1ASvrK?=
 =?us-ascii?Q?p+40FLoxA8adG8FV29vaq46hi1wAns5GxblePSTpgRWupXewcrL2XT14YoNp?=
 =?us-ascii?Q?6QuFIvEscmTF4ROHNg0/wKzrUi9t+D1urQs8thK2mtlQlUm29x9SuKw9ixHp?=
 =?us-ascii?Q?k2IR8txiuXq8hkYlU+aTKOgk0lZEAmdjlXEPD1hVyQcuctS7+Sc2FsD1+oVn?=
 =?us-ascii?Q?rtyLkA6XLfTfX7ws3KM5KrM4k//+nif/WIzf4AKkaQ4M32ZBllZuy6NQCmSG?=
 =?us-ascii?Q?5oj5eCedy1tW1VRMrCoDJ09RtpYmBDZtarjQbKX25StTdvmZjQ5OENTBiqnS?=
 =?us-ascii?Q?jygU5uydn2D0p/MbDzXwfwlJmQiNYIXPc3B3rUW8NQIdtpFKr6xDPufG3fM9?=
 =?us-ascii?Q?VUmmzA6e59QdNNpVLLoSlKeoSPZmuP6nfhDw0DD/mzH7qYRZI0IFLxRDRAHC?=
 =?us-ascii?Q?7dN9YSKcN46veI0pK732aF4qk+IcGN0=3D?=
X-Exchange-RoutingPolicyChecked:
	rL4srijFacgDXv2oGGa5NUUMrZgXJzkousHyWXiZ5ELgaJM4nl7EUjBVKqAv2O4mLP+R8hhLerwtJ7zhrV6LIoK7gCZSIuY7I2pA9280Q2scjjSLg9v0CV1vG/FoSHTD8Nii8wT1LNwKwD+rhvJtIda3+fV1Fk2Ei0lBEvHdnCC1CCNC+AypZXHD954zKYTbXQSgwY1UFga5+0eyViTNIJoJgdfc3Z9T7LwK7wQkq2cWe7zCdHrYRzumkO2bm8Xh6+FYfPAvztniyKbJcj+z16MYKyIZLhDGgiFloMdDzaSLKZdVZaN5NC8+MQfRJGKdGGTZaTmnZJHPCHUab87yoQ==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	PL7rsDQrb444ugV+c8+CtVXG522JYj8JFHvMlt7J1cY32BgIPsn9acoqEjFmIsWXAF8vzyCd6fFxdjtQue+U55MjI6SVgKKH8Ry5EHI0Gw6XiH21FJsQB1NcDehUUXrZQJiH6BN/w9O3s5frcYjTny8FzebHrtnSvKp4K+WtrrNmWE2ZyGSf2aB3Rtra4ClVe3L/b0tAAvM2MaoYoMXFTjQTiskqtDpY7inmg6eBj0sFa7tPHt3HtfukC7wC5bkZ4h9ZyXRc1bDgAPCc8Gw6K/pgtZsKekWUsvJKcJUnaTrukMhAo4Y4+PDppaHeoeop9VOZtF6FH3dmibdNKjD7jbb1LpBrtTGC71tjtxmbCA+cgEAL8RuREtkhM/YbLKtffblmDJ40I0mELMXb/+v4zm+0aW1qUPQnILlT1rl62QWCO0EPEaY81tIppfcE8nvq5vHyZlvAEzXacBSu3WGhtB5e7ueARWYfQQGPgGl7VvMSvriQKj4TLHvYGBXUmJLcpo2mkTjWmUvsFBN7p8EhoWjX6xupPrJurmMRGbZPQc2lgPxBWrCC8mcwGOCscNiyhnv7aJgxShdiCL2c6dQpNNLqcRDc4RPIZt6NErfIrF+YMThchSYSjOCRHrcmTX4Q
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dabdcd7a-a187-495d-214f-08df0a30d186
X-MS-Exchange-CrossTenant-AuthSource: SA1PR04MB10065.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2026 03:01:30.1020
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wpSz3W1BaLy0x5gPQYjyT67+uMQQWEOvcF7Y9/TFnbxiYbRK+9eUKEyjCq9ptJaFEX2/NtGwmgUka0Bol6mHugZmXuuGH13O82WqguQjbps=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR04MB8467

On Aug 21, 2026 / 19:53, Shin'ichiro Kawasaki wrote:
> Most blktests code, including check and common/rc, is licensed under
> GPL-3.0+. However, tests/block/029, 030 and 031 are licensed under
> GPL-2.0 only. These test scripts source GPL-3.0+ shell code, but
> GPL-2.0-only code is incompatible with GPL-3.0 code [1].
> 
> Relicense these test scripts under GPL-3.0 or later to resolve this
> incompatibility.
> 
> The script files were authored by Bart Van Assche <bvanassche@acm.org>,
> and subsequently modified by five contributors:
> 
>  Yi Zhang <yi.zhang@redhat.com>
>  Christoph Hellwig <hch@lst.de>
>  Li Zhijian <lizhijian@fujitsu.com>
>  Akinobu Mita <akinobu.mita@gmail.com>
>  Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
> 
> Bart and all of the listed contributors except Yi Zhang agreed to the
> relicensing. Yi Zhang did not respond to requests sent to his Red Hat
> e-mail address and the address associated with his GitHub account. His
> changes are considered de minimis, so his consent is not required [2].
> 
> [1] https://www.gnu.org/licenses/gpl-faq.html#v2v3Compatibility
> [2] https://lore.kernel.org/linux-block/ama1svBbdVfyEKz1@shinmob/
> 
> Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>

I appreciate the Acked-by tags by the author and the contributors. I applied
the patch.
