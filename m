Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E2152BD033
	for <linux-block@vger.kernel.org>; Thu,  6 Nov 2025 11:23:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.154.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762428237; cv=fail; b=g9z8YEIFR7KZag02lq2WjtuhrWJ2Nq18Xeky8nUZ3x/fota9KduqparkFXWnHM471JOg5ZU79VK0Rp5yusv834sJAofigWVNA/y//nj1POXR7eLUEp8szb89qS3qX9UqlkD8et0+xziAB9iwjEdvukc78O8eYx7/mS4A/SAtKw0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762428237; c=relaxed/simple;
	bh=f+z6ql9M5JhawzkmfcJJBxApS2D5ls0dv54BOWw8ja8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=XDkB26TXQmEwLwcHkjL3y75375eSgjd7NAcb3g0UaaReKjy9PMpbOrj6QcyBxe0TtVpOk+NzB9hswuiXYMHwi0Q70WSlskefVMLG8wElnm6PHVnnmt/yOZkJD42Tj1qyiMHpSd3+29JalL2X2BipwBwy2f8unYiq0+3mIVEiuKA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=YiTmDsEC; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=BjMwPIwS; arc=fail smtp.client-ip=216.71.154.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="YiTmDsEC";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="BjMwPIwS"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1762428236; x=1793964236;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=f+z6ql9M5JhawzkmfcJJBxApS2D5ls0dv54BOWw8ja8=;
  b=YiTmDsECW8YhDp9GuJM8zDaM7qD1YaIx4tSrc8Iq+mGP8uuCD6NNde2a
   5jTsf/ioP/GBwyJEZLkDnlkxMga0PlKehkA6PrvD1T9qc81Tx0nlZq6x4
   oqs4NqNGPtS+JrHKNu6wz1Cbf/AGgBx4/LH9EMZdkob9JFuuHLV2a2JkC
   TZIe8amy7xh5OwB0HwotRT9Pyxdu4SxnEQQGLDnJLu2CsDWGfUE71LmcG
   5pcofhhJrMwm75aatL8KsKiM9bFKXXUnOsf5ArCgCSySQUHfkaZr/fuw2
   K87Ne2oFPrcb9DAiSdC7FYk8dwIkazWsVQKJN7SYqFdjwIMSCiiDykvX2
   A==;
X-CSE-ConnectionGUID: 6FnFgjw0SUW5tAwxZlaVbA==
X-CSE-MsgGUID: N2q9nDW+S6elmglalXCTrA==
X-IronPort-AV: E=Sophos;i="6.19,284,1754928000"; 
   d="scan'208";a="131599022"
Received: from mail-westus2azon11010030.outbound.protection.outlook.com (HELO CO1PR03CU002.outbound.protection.outlook.com) ([52.101.46.30])
  by ob1.hgst.iphmx.com with ESMTP; 06 Nov 2025 19:23:54 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wf4nHVDMPFJW02K/qlaaJUUshmo7hZ/8NMk+t5S2h99xb6sYr15UUtQtvIIcOWEYGaKhZ/w1KXQgdTRGxGH4IiKmQanAjeVrWCC/tliD+my3ItLU1hRQINs7xZB+uwAZJkCG5q1n4iJK1wL29/Fr/ywPOrbQ9Cd4NXWESs0nEvBwyUdVZm9GSaaS9Kkp/8BPxHhN0MeItx2oXJOBt0flRF9nPMzT5PRMR93cD7vX1zuIYjNXlvoA4taoXjaPUcuEzwzmTV+2MTjFGCR8In+CN0eTsixk8B8zCTx2IEnI9zFulH7t1hB1WKQXuw9iAuuYaCBVMT5CE/AsvOC9TQ9gyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f+z6ql9M5JhawzkmfcJJBxApS2D5ls0dv54BOWw8ja8=;
 b=vTkw1gFGaoBxklJDrQSElDm8muD8KzDoNEAIKVa/BleHmTvU5Ic4lPDgmzSdSIeI76sz93Te3qiWBwMD1IZjv1qPcS/0ztURdCk5dC/r7Omo2LLvI36JVxMXQOo+42ylWqllugMwrVg6vP64WbyB29kBV3oZhkD7WHS4qhDHHqFdZ/Ss16L5fRFd8O5vTqCRLpcdz/araeehsw2+DZuyB3MBF3MHVD60PLzPrKsNxE3AGpVa8Dq45WxWbcpu55etS0MsGQdeC8iH6JC+nXlDrAF9wHzrQED1K5rlJHtYoNk2dL5wJ6ecf+ctKXyUk4Ylc9oiuD5Vka0Su8OpooCPjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f+z6ql9M5JhawzkmfcJJBxApS2D5ls0dv54BOWw8ja8=;
 b=BjMwPIwSmelo5RfhIRW0zUagfuh2/02qgSXYYIuJn6yb0fxlnI0/3h52yiZk4jU0v+S0NPcFxKAXFi6gjvEollBXCtG65sy29dYTeauC1dDx0IZWQqel7O6rM4bEa2ANNomkor4nPWFs+BUgSwR5H5chaLto+Dekjr5fe4Wq+nI=
Received: from SA0PR04MB7418.namprd04.prod.outlook.com (2603:10b6:806:e7::18)
 by SA1PR04MB8854.namprd04.prod.outlook.com (2603:10b6:806:387::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.12; Thu, 6 Nov
 2025 11:23:52 +0000
Received: from SA0PR04MB7418.namprd04.prod.outlook.com
 ([fe80::17f4:5aba:f655:afe9]) by SA0PR04MB7418.namprd04.prod.outlook.com
 ([fe80::17f4:5aba:f655:afe9%3]) with mapi id 15.20.9298.010; Thu, 6 Nov 2025
 11:23:52 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: Keith Busch <kbusch@meta.com>, "linux-block@vger.kernel.org"
	<linux-block@vger.kernel.org>, hch <hch@lst.de>, "axboe@kernel.dk"
	<axboe@kernel.dk>, "dlemoal@kernel.org" <dlemoal@kernel.org>, Hans Holmberg
	<Hans.Holmberg@wdc.com>
CC: Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCHv2 4/4] null_blk: allow byte aligned memory offsets
Thread-Topic: [PATCHv2 4/4] null_blk: allow byte aligned memory offsets
Thread-Index: AQHcTsByGOVbfvXjL0WryNx7ZuqcnLTlgicA
Date: Thu, 6 Nov 2025 11:23:52 +0000
Message-ID: <0203c581-593a-4f5e-9185-c8cdbeff4e80@wdc.com>
References: <20251106015447.1372926-1-kbusch@meta.com>
 <20251106015447.1372926-5-kbusch@meta.com>
In-Reply-To: <20251106015447.1372926-5-kbusch@meta.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA0PR04MB7418:EE_|SA1PR04MB8854:EE_
x-ms-office365-filtering-correlation-id: 1013c5bc-72a3-4b5b-d6db-08de1d26f743
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|366016|19092799006|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?bkcwVGp2TGE4eFUzcVlKRkp3OGhQMkMzNjlaaEhBWEh4d0liaDkwL0JBVXNY?=
 =?utf-8?B?WjM2bGR4ZUhvdkt2clB1cENBNmI0UmoyekZWUUZiTkV4aUVjZE51VlZvaTFC?=
 =?utf-8?B?S0Rwc0hmRFlENnVDU05nMjA2WUVURnlPcW1GSFNnc3EyQzg4endyMzNNM0ZN?=
 =?utf-8?B?TitTMXM2MXhkVnkydEZvSFlkZ2ZKWThhMWRrdEYvZGVhSmwvdnJadEtIY2Vo?=
 =?utf-8?B?a3ZDYlZ4YmszMFJZUDdPQytpVmxicUhFTy9CaFRreitUVlZFTEdXaGNTeXo3?=
 =?utf-8?B?ekFqbjU4TEg0VVFadkNHU3RueXNHWC8rUGJVR2NuMDJYaURYSnhvdGlCZGJq?=
 =?utf-8?B?RTQvbW80WnovcVJhVHdQZ2dYNUVWN3VmMWFLQU9IdFVZaGMvY0k5T1lwR0Zy?=
 =?utf-8?B?UUVTU1U3a0FhVjE3U212ZU5jQkdiY0hyb255UnYrclJSZ0F0U0xvMHc4SHJI?=
 =?utf-8?B?aGp3blJjZW80Q2psY3ZsS29aUFNQMHVTRC9xU3dlazQwSkl6dElBcEd5MURV?=
 =?utf-8?B?Z0MzYVRHZGpFRjRXQUt3MUV0SXdSbHNXQzJRcGlwekVWVlpvajNKbnQxOU13?=
 =?utf-8?B?Y3VjdE03WVVKeUt3RE9XVklGV3FMdG9TbXVIVXRaQndsVG1USVE2UE1EbU9C?=
 =?utf-8?B?c0dSNTdWSmFEbkM2YzNicVdwQS84clBsMytSazZHUHVRL25EWjNoeWh3bGVI?=
 =?utf-8?B?bjZQTzJydUo0WGZtN296UERCdnFqdWUyQ2lEcE96MHN2bGRMVUlXY05XaEhr?=
 =?utf-8?B?RTMzTXRhSVl0dEo5cEZFbFhienZHMGliR3FIaTlkbHl1dktxZU1oczBKTEsw?=
 =?utf-8?B?WWVEMjJwNnpmL1NGNzRrbDRHbHRNc1pGVk9lT2xJK3cwZVcrMmdIMGMrcFJD?=
 =?utf-8?B?MU5NYnl6MjlQNFI1K2hiZXNCbEZ3YUJIR0JaZFhvWkRCRFJHQXRMZm5SWXUz?=
 =?utf-8?B?ZkNRQTh2dnFndFk5MmxJN01GVzJsVFVUb3lqQTFvVWZDTk96RGJYSjI0SEh0?=
 =?utf-8?B?OEFTMHVZdTdEc1BtZ1RVS2c5Z0RKcEdyNE9pYVdYYnRGaWtReUt5WW83YThJ?=
 =?utf-8?B?WkorY25GczNWNndBdzRYV0F6NS8yb0lIUXIwR0lpRmdRLzlZRGRlb1MvY29T?=
 =?utf-8?B?aUtXclhTdFBBdDJYNlpVenJsVFI4TUxJbFU1UlFleFBjNU1KRVd1TEpMT2FB?=
 =?utf-8?B?dkVhTGo3UnJVaW1UQWU1cDY0ZnpYMFVRYjJ3byt0ZEVQdUl2cEpIeGUwY3ZW?=
 =?utf-8?B?aERaQ0Q3SVBEODVYL0dGRzQxVDBoaEY1N0FRMWUyOXJzSjBLQXk1STlDR1RQ?=
 =?utf-8?B?dDJrNVVpVzZkRnlwaHorcmhBOXVCLzFEUDJHcTZQVFh0RWxlUjAxeGQ1OVdV?=
 =?utf-8?B?a1V0eE5QaHhhbUF6NmlXM0ZNc3pGUU96Rzk5MDk1anEyVForVG53d3d1WUsy?=
 =?utf-8?B?VlB5cHVhTVJuUVBsNzB1QXFCWEJIUG1GSlZXczBTbEtBTG11cG9KZHBTQ0Z0?=
 =?utf-8?B?Mzl0aDFNTFBORzJxTy9GY0pDaVh6WWtOZ3Vra2FrU09xdVFPTXhkZFNXOEV1?=
 =?utf-8?B?TGEwK0RheURwN1NuUDNrRURCZEVNd2U3YWZ5NmxmcFNXWnNRTUJzWFhKRXRQ?=
 =?utf-8?B?RklZVEpzTXEyNWxJYzZBejNhaVpid1hzQmhOeGNrOUtoSWpDMVNWbkU4SDNq?=
 =?utf-8?B?OWRnN3ZuUkZORDRuck5oV3pLK2l2M3JuNFNmUUlXd0NMcStHMExEVjFKSTRQ?=
 =?utf-8?B?WGlydkQ1RjRIQVBKcEpNZXFnOE0rUUMvRFQzTGtVRGwzNDJiUlU3dW9rTlJm?=
 =?utf-8?B?QThVc2lqRUFoQXA1N042VFJuSGpsejM2RDBQYkN4dC8wNytWWkpFMlROdmxk?=
 =?utf-8?B?ZUN5VklrRXJDbGwyOFFFRkl4Mks5cTN2VVJGUHZMVGNoQUVIZ3pYME45OTk0?=
 =?utf-8?B?QkdDT2NtNmREenhyUldnNVk1enI2QnFQdkxZNUQ3RG56RndDeHExRVduZzVX?=
 =?utf-8?B?ZG9WakdIRnBlMDRtK09rN1NNazJJTTJqbVZlZEI4VGdKOGJkbFRxSlF3dzBs?=
 =?utf-8?Q?57M8/o?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA0PR04MB7418.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(19092799006)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?SWRxMnhGeWZZOHNxa3RuY0tnRGc2dWR3MVRFakUreG5EUU5aR2k4NktrNVY0?=
 =?utf-8?B?S2xnVG55alc1d3hLcjVGQyt3d0VhMzVWY0hDUWdPSjNFM2c1c1FKSTV6SUdj?=
 =?utf-8?B?YW9XL1dBOHZoZWhiSDJHTDJCSm81KzhZOWtZbjl5YjdxU25qdTZqVUovTG9R?=
 =?utf-8?B?M2ZBbDJhWXQ3NzZPcFJBYWViM1o2RHhYM1Y4TXFjZ2FqcU9yVTJpRmZ6dVZr?=
 =?utf-8?B?L3Z5SlZUVEhuR3RiUmhlMmlyaHhEMTB4N2JMc3p6MlAwdVVQYjYzN3E0SFlJ?=
 =?utf-8?B?cXZyZ0hCMUhTRXlock82ZWo5cldkKzBIQ045b0hxVCtSOUszWDNic25ZS2Vu?=
 =?utf-8?B?VElHWVJJMDVwdFp2dVZGQ21TcTh2dnVKenFkZEJlM3pXRjVWQ0haVnBVN2RZ?=
 =?utf-8?B?MU1EaG4wNHB3VjRBazhyUmhLVGJBR3hHbkxibWJnMFk3YWtFMmN1SGRmN3Vv?=
 =?utf-8?B?ODR3aGpHV1cyeDljQmRlbDl6VklYRjdDdEROK3FYLy9sREY3aU1zbmdTSVNy?=
 =?utf-8?B?WDZUTTROUm5aSWtMaWNaekludWplZjYwMUliT1Q5WDQ2QjZFVzFVQy9KWElr?=
 =?utf-8?B?c2ZoRkhjZnJmeE1hc3Z3dERodTIxTzJIVWZ4NG5YbU1Ed1JEeExSRExjK294?=
 =?utf-8?B?Z010OGM0OGlhUDJZc05uU3k5RkkwMjUvQWpXc0VsSGxmeXhVckNBNmYvUWhQ?=
 =?utf-8?B?RGY5KytCME01aVgydmI1cVFxZTRrRW1zTUh0cE5BdHNSMm9wcTlSdW9xQWV5?=
 =?utf-8?B?UGNjYW9MeDVMYjlVaytvSjdYTUdDSEFveVlIUWs0bU53Q0txa1pxOXBhTUcw?=
 =?utf-8?B?Rk1Eb3hYU2RJdGl2cGJrUVl5eTRyUVA4ZDNxU0hmaDhDdEhGZDBBUkxadnJP?=
 =?utf-8?B?blVqYU9keVBvYmhmd2QvQXl4UXlOTE5zOGxlVUd0aVhTU3VGdUx4S05ScWRG?=
 =?utf-8?B?VnMzTEg5bVN1Z2k4Y0EwZzBER3Fsa0ZTWGJMdGdiaFgyeGZObURHTTYyd0Ri?=
 =?utf-8?B?akxEa24yRjhrNHlzR0daRC9hUnRLbnRqQUZRWW92QnFZRXJ0UHU4dHNYNmpa?=
 =?utf-8?B?aE9uTzc1RFJQZEgwMFV6WlhTTzJUWXhZMTJObWdkR1ZOTGQ4RUNLeXpKbyt0?=
 =?utf-8?B?dG4wMUpzczNYWmpJZGxqM1JkUzlmSVNLTWlzRFhZT1ZOSytkZVd1OGNNZG1G?=
 =?utf-8?B?a1RzNlBtUDI1S1d5bUpYQVFIZmRUQ3djNnJyZFlsRmhRcWx6SVY0ZXZmeUN6?=
 =?utf-8?B?TEgvYm1MU2V6UG1NNXFTQVJiNUlMYmM2UEpHQWUrN1IvYXRkTkU1WW00V0hI?=
 =?utf-8?B?SEYwQnRXQUw2R2QvUGhKREV1azBlanVHWWhSbnZqNnVRQWNELzZ1ajhjL3gw?=
 =?utf-8?B?R3NIOUVraElhMDNySTVwc1F0QTZ3b3lnR3NjN0Nsdm5mSlVjVjJ5cVVXdVZa?=
 =?utf-8?B?NGVQd1B5QVkyNDdMK3pXMm9BNWJBeGh5NE8rRmhDeWt0Q3daVE82SzlsRkZR?=
 =?utf-8?B?bGFyZ1BROGoyK255ZU8zNlVxTU9RWEhiaEZWVmc2c1E2dDhyakdpZk56L2VU?=
 =?utf-8?B?U0Q5R3BTSkk3RkdIMHlTaWlXY2tPTVVSRkp6OHZqSEJNMUxFSGVKb1R6a0NU?=
 =?utf-8?B?ZDVDSy9UZ01TZXE1Y1VYbS8wSzVXQ2JYYU5RemFVeDJ5Z0JKaE4xZlptYW83?=
 =?utf-8?B?Z3BHUHp4a0FTN1Rpeis3L0V4bE5SRFIxcFgzRGc0dE9PcjIzWmRrZUQ3dDRz?=
 =?utf-8?B?VCtMa1BpQ0FqMVpMUTB4U0F4WFR3MXJMWmtHeEJLb3RieE9iL0JlaHFOVnpm?=
 =?utf-8?B?c2F6blJWWDdLdkNpVnltclJHZUJaQXV6NVY3a1VrUDN4alYrckJJL3VwRnAz?=
 =?utf-8?B?MjNpNXBMYW1pc0p2MUF5RDc3MS9NMjdRdjU0eis2YW02UjRwUEJLajR4QnNs?=
 =?utf-8?B?Q1hkd1k2ZUJLRjZFWnBjQ1NCNHptZ1Z2L0pzSlZIN0hsaVRyRndaT3BlYmdR?=
 =?utf-8?B?SjZKcFVlQTl2VUtKTDdpUFhUU0MyS2xQMkFIQVBIMzFORkFmblUxbWVxelp2?=
 =?utf-8?B?L3p5YlJNREhjd0hCaHNzZ0tWQnJDUG5NR2g2cXhGVHowVkEvVm1vZTQ4TnFu?=
 =?utf-8?B?cmhoRlRqZ3RmdTArZldSOWVzQ1BURXhsZGxjdFMrb2szNnRHRHpiSXpiM1Yz?=
 =?utf-8?Q?zmjZ2ZZAEblqZISgSm6dpIE=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F9E832C9829EAA4994E728F012052AEA@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	VhEdcoHzwVbHkWVl0O3VboNySWj45e3QycuAATAveQrKtCSsKIh7X9642i2jbxU1Y3n2wmqkSDrgmIZlxSo+2zFqeUGCBUkTBRLUpZlr44rvrTfxWefs9GN1QVw6fDMl0RPpZqNZJDWplR0m3sFA3g8CENbY915vmhk3scTg/41AbMbWC6+JjdExsPCWFF8EIb23xE2oHrO+N5MPIsYbejhLFoDpWvDBsDvALqF1xtmUH6r7D7q5VUZWlCVRH7+Yr6YtH/8KfEzdcgtp7XXagmIwOX0ZCLZmpm+AuBMA2+SlxnJYch4+/WjizeBFkMmbnPTXvNZzo03O6H9XND3BOiE2mGMNqYnDsRIhIeS5Zq3gtArcoASPkeLXT0974ZI4EkuNKWjuXEEKklZydJh6yKTz3B2AzF09Y64MjpFTpl5+oucznTld/pn/8mUQHa1rnBxvdUpkEVr4ARIviwphp/WRgYbF+7x85qJAq+1n15YOdzDU7SnWIZtebGF1Y7nUVEljNET7O4N5xwr+HhiqY480jW93gpTR/s+C5rWeGUKcMBEpCc6Xz4Z05lrpu4MHqgbt1vIwsvSYr9lr8Ww450Nrmum+N3g50bF5vQZzI4bOsZpTV2zRaTEE0Rv6iCzC
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA0PR04MB7418.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1013c5bc-72a3-4b5b-d6db-08de1d26f743
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Nov 2025 11:23:52.7331
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9eIp/l3Q7xhhVZNiVPn2m/kKKlSFcI+YEL8U33XLRnysdqD9v11fw/GX8fdPImTKkRd2rDNf6E+mO0CoCbjsmgcirehj+FwR6I15jDC9IgY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR04MB8854

TG9va3MgZ29vZCwNCg0KUmV2aWV3ZWQtYnk6IEpvaGFubmVzIFRodW1zaGlybiA8am9oYW5uZXMu
dGh1bXNoaXJuQHdkYy5jb20+DQoNCg==
