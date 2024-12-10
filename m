Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 093D77DA6C;
	Tue, 10 Dec 2024 07:13:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.143.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733814797; cv=fail; b=Lu+/gi2l4pgnzuvdB2JxfrmxFvjQaL3R+6NFnbdH//7Ku0Wq7XWdPxb3YrLRtAIFaZ91KJtPt2MUYaFbnChxGtflaVbEEDgKGngb3E2rl5gqFJNG9U07sDhqHieWrI1QQq6FtdVuIHKnx18EYhmPTdDN/Da62bLto8v9MM9g4Rc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733814797; c=relaxed/simple;
	bh=8pWpvb07rNK2dDDeSHllnfAlnZgpvw3/p5MpYoJRpf8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=KfW0jBBlhFl8C7qiXgQlGYXFPUl74hHsTg2dzKCNWatUMOH1shoYHussacH9rRj9EuSaoJ5A9VdUQPS5yoMoqFslkP0TQLIXAVCMcwoyX09U0/pS1C1aGSt/nhVfyWLbtfdVK18K0ZgWaTXmuAbk7CWeI5zPWwOUiBU2kh7Ei54=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=SHc/Fswz; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=NLYTl1xV; arc=fail smtp.client-ip=68.232.143.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="SHc/Fswz";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="NLYTl1xV"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1733814796; x=1765350796;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=8pWpvb07rNK2dDDeSHllnfAlnZgpvw3/p5MpYoJRpf8=;
  b=SHc/FswzRp2B1AONZN9H7spqqor7puQzKKWU0PiLFsQL5CAlskVbzAXO
   sO/XZSzChkT51iGSB+cWDoyxDhm9COQJTe5yv2JmBS6g6X03Bka+rTiHZ
   AEdnaIyUWuff7kw4Mq3IZb0U6tlwToI/frjP+y6ktr3WYdxpxIWohxiHK
   Gt40QWlpNo72G1yvYyNLrmxz+aOj+Z7aDniMRmBKiyiUrWCbaXrWHz6qV
   544ydgByik9TzOvWAyPrk6X7PJAMpEYkNYWaW65rOvK1H1nJ3J9AtfyB4
   oIebQ4J8iXTa9y7OQw/U1FllSTi81k4Hntm/JVLb+5NgF2ayg+0S7LShb
   w==;
X-CSE-ConnectionGUID: GBXwZPeySRmsdAnMmsI0xg==
X-CSE-MsgGUID: Gq33wjobQyOShyqrLCB1Dw==
X-IronPort-AV: E=Sophos;i="6.12,221,1728921600"; 
   d="scan'208";a="33972516"
Received: from mail-westusazlp17010003.outbound.protection.outlook.com (HELO BYAPR05CU005.outbound.protection.outlook.com) ([40.93.1.3])
  by ob1.hgst.iphmx.com with ESMTP; 10 Dec 2024 15:13:09 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pWXLZs5I44embOvb6gzbpfT88emKUoUoWGrmo/emGuSAWAojNitTpuc/GUeycg+dNzVXd8sNhpRScIOOhxBk/Q8duTOr5ubviB1bi3n5By5H4E1Cm2N0g/pgop9neE8mz4RuPjssJGCa1hYIdmUtVZkO/CxVi6kH91+sgNGwsSPEE2qbHi+/xnPezkD/W0sWP0/O2rtGcq+QagqBJZTV6h/6Q90ePWTcLootQS1NydKMrb6Sd621ComVzFMOzEaEbfTY8qX4wsAcYQmYyEkQ+N3cs+IyP2tnaWJVe6U9TbyfYYudkmv+2gARxF8IJ2SEPN01ePwN+Qm05J7lcr0nGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8pWpvb07rNK2dDDeSHllnfAlnZgpvw3/p5MpYoJRpf8=;
 b=ImF4AiFI8kvH0WOPfceSR7Vdr4Xv78hkb7lthpkAbE1DYULsfaetBL3tVz4y5neRasHxp8DStbIPVwvx/9Hnws6gSEVjAkAwhMi49BAgR7utljAkQv34qxcNluK2bu+zpOBZBAhV3VJKVD9WRHTl0Dp/gaX6gxwdL2XzYmcHQg3Hs3o5MmfqV7nD9Aw+MwMCsbGIZym40b6pntaYSe74XUns/h9e0BZyl/O3q3jyUWMonkfP1aWIviuJ90G9Ujc7t/HQEX11aRtm8FpnFeFf3BhBSFtmS3JWbN6qnpqwgKOfL2P4Qkc/zKVvFww2056DamxgweowVJvvpFfxXC7mZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8pWpvb07rNK2dDDeSHllnfAlnZgpvw3/p5MpYoJRpf8=;
 b=NLYTl1xVfmRE/oG/qB9fYchnqJSPToUwyvRReDpZgrJFmfNXlnM75VC/tBvrdYI6Uq0aay/szWy5eswZcHOg0HXiaGsF/sx5X/Tt10V/ef8WQ+q8k0J99j0belzPCGQv3N7QzQoWxYmNyNNkMo8EeJhGWUAl46c/LNfVLDq8vEw=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by SA6PR04MB9520.namprd04.prod.outlook.com (2603:10b6:806:434::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.12; Tue, 10 Dec
 2024 07:13:07 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969%6]) with mapi id 15.20.8230.010; Tue, 10 Dec 2024
 07:13:06 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: "hch@infradead.org" <hch@infradead.org>
CC: Atharva Tiwari <evepolonium@gmail.com>, Jens Axboe <axboe@kernel.dk>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] THE INITIAL VALUE OF wp_offset MAY BE NOT THE POWER OF 2
Thread-Topic: [PATCH] THE INITIAL VALUE OF wp_offset MAY BE NOT THE POWER OF 2
Thread-Index: AQHbSswdXU9f8X5MAk2rlV09yjhWHLLfDyyAgAAAooCAAACEAA==
Date: Tue, 10 Dec 2024 07:13:06 +0000
Message-ID: <0fcb9e73-5595-49fb-866a-a981c01bdd14@wdc.com>
References: <20241210062340.2386-1-evepolonium@gmail.com>
 <7e04fc51-e7d7-472d-acf9-a7bcdc6c5496@wdc.com>
 <Z1fpkzrKMcoFncfI@infradead.org>
In-Reply-To: <Z1fpkzrKMcoFncfI@infradead.org>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|SA6PR04MB9520:EE_
x-ms-office365-filtering-correlation-id: 7ae8eeff-e56f-49a8-ee05-08dd18ea1873
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?MjBHalJjeWxnN1psUkpwTERzSEY4YXp6YVF0WDVnR1ZZQjdEU3ZPYitLcnNL?=
 =?utf-8?B?ZDM1czZZZm1FcXJxZ0N0b3VuNTVCdDBQNVV0UE04QzAxekswMi9TRzdoeXB2?=
 =?utf-8?B?Ti93SUxQN1lrODV5SXNaMStCSHFzaXBRaW5nVng4eTBFQUw1WHNXdU5tanph?=
 =?utf-8?B?YnJBcWM2eWR4VTFIR3E4OFhOMFZLcmpiSTk3d3M1L2VVWmx4LzlPRzRDSnM0?=
 =?utf-8?B?TENkMUhTeVlWMXJ4TVRKSldoWkVOWm8zaCtBRjRVQmtnaksyb2RLWi9lUEZz?=
 =?utf-8?B?SXNUSlI1ZmZJNndIOVJMU3dwcWpHdGJ1WE0zZmJOWk8zY2VyUTMzbW93bm93?=
 =?utf-8?B?Rmt0K1daQUppTlpEZ0Q3ZFdIZzlZYTZEcEtaSm1kQzBZbFJMZHJwN1lZeE5Y?=
 =?utf-8?B?YS9nWVVtd3d5WkM2dG9Qa053blV2ekxWZXJGcVpTUUx3eVhYNFVtRkR2bFlu?=
 =?utf-8?B?SVk2RnNUeXBnNlErcFJMTzlWUzRxOTF4bndhL3I2dDhTbzV6M0tDb0tBc0Iz?=
 =?utf-8?B?WUlQMWR5aGNvSnZuOWk5dFVlNk84bVFYaXViN1VTRUwvVTVhOTQ2UFUzakFr?=
 =?utf-8?B?VENKS2RWVUJUSzcvNE5HZXVidzJvZ0ZUT3FrRU9HYzFGNDhWT3hQdFhRQU5X?=
 =?utf-8?B?Sk9RT21WM0s1aUYrdVdLYmNnRTRaV1RlQXgxK1FwdCtKL250eGZHVE5neHUx?=
 =?utf-8?B?bzNGSFNScnFSQzU2enF2TkhORmgrSzF6eExQSFU2ZHNVeFhySGVTTS9yLytk?=
 =?utf-8?B?V3dtT1pGZDJ2LzFsYXUrZXBlL09QTmwvR1ZPVkFUS090b0J0bDRSSysyTzAv?=
 =?utf-8?B?ZzRDTThjVk5YWXBZaGZHM2dLRVFMc3NoTDJMMk01bXRyU2l2NUJBVlN4MXpp?=
 =?utf-8?B?bG1sMlo3amJBUVc3TUxIbTdIb3pleklBaWIzOVUyUFVoVEJ4S1NFTXpSblZ2?=
 =?utf-8?B?RmoyZmU2UkZYNDFtdFV3TGYwaE1iT1BPZm11eGpJeWtaZ24xN0FtVjFjdkFX?=
 =?utf-8?B?NG8zZmR2R3IrQmlSSmU1UlZnb1M0MzU2aXYxM1BmczgzQ2dOV2Q3NnBVak1Z?=
 =?utf-8?B?NkZHcTBtYS9NTllzUWJiVCtKVUwvbyt0ejNqRSsyZ0lIc21YSGhRL2xFYXp0?=
 =?utf-8?B?dTh0T0hBRXA4N2xXYW41Z1ExbWFzUkMvWVZyRnBsM25FZmFjT3lXckQ0VHk1?=
 =?utf-8?B?WDc1VDNSRzBNTGpYbEpjdUIwS0FCd1pUNlNxREdSbFhxNjBLRkNDUGRSTzRa?=
 =?utf-8?B?Yzg3ejkzbzRIcURxWmU2VFMvWjkxSlJJQWxGditEbmlRWDRDWkI2aVhlaENO?=
 =?utf-8?B?QU0yTkxaTEowR2pJUmhlS3gvR1dkZWZTUndXdGVDMzJ6SXF4ZFFzTzh3OUZV?=
 =?utf-8?B?U0FPZFd6YlpKdHNJdUZJZ3ZxS3l5b3g3WndoOXozeER5UWcvY2xSeERIdFFV?=
 =?utf-8?B?dXNhZVFWUHNhUWt6Y215NDE4STZIdlRzZ0NJeUl3Y1FtZCtpd1ZDSEJvM254?=
 =?utf-8?B?Sno4U3YzazlsaGZIWStXOEZwaUpIZUgyWmNsbU9zVnpkOElOUkhrOGhRczdn?=
 =?utf-8?B?WDhESTV6TlBoM3Y4T00xYlN1REJwZ0pKMitVOWllM3BzeWZ0ejhyT25hWnho?=
 =?utf-8?B?SWN1QWZKMFBoZVE2TWV4U1dTS0ZXTitLazVlRlJoWjZ6anpBdGZjM21IREZi?=
 =?utf-8?B?RUFESzVUT1B1QWdIcGRnckJXZ0FHa09LZVU0UUtjS2d6SjhTL0FkVlcrZElX?=
 =?utf-8?B?VFYzRDRNRnh1TDJMcTR6REpyOVhoTzNFZHkrNUp1cWF4WS9kdmV3VmQzT0lG?=
 =?utf-8?B?NEhOTGRoR2xBbTl6dUtMekhGU3lxaE1RdkRETmNHUVF6RTkrc2pXVnpna1FU?=
 =?utf-8?B?Y2R5Mmlmb1liRlNDdTFXbTJkOWNFVHc1NDBIb2FXaVEvK0E9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?NzFweCtsYUVEa2c2aktCUkFxbmRha0dZVU1XZDdDakZERkdxdE5NSEViMm01?=
 =?utf-8?B?WkVtcFV6MU10Q0kxd1ZhRmJvZndWNVV2K2pPK1dvUlJQQTdhNDIvaC9IRWVt?=
 =?utf-8?B?U2gwSzd2Yk40UGxpd1I4UjVpcDlJZ1JOK3UyMWFEZk1WbDlTSnkrMWt5czky?=
 =?utf-8?B?V3MvZ1RUOUtVZllHQzhMRHF0czdITDA3K2hzZ2k1NTJSSTFBQVJmbW4vVFhu?=
 =?utf-8?B?RWYwNHFoVnV6K21yWjdqczcwTk9nUGZGYk41Ykd5c0NCSmVmYUJ6alNxSkFx?=
 =?utf-8?B?M1FibzFuVEJaNld4Zk96MGI2OUdWdkpBTk1nQmpXaWNNSUlQaDhkR3NabkEv?=
 =?utf-8?B?S0x0T1MwOWJTYTZMc3RTd1FPQlp3NE5tTll4Z0hqWEpKZGNsRFRiOVVEb0dR?=
 =?utf-8?B?dlFpTVZmKzJuWlVHV1FScFE2YXlTNlV6eDFmLzFpMFE0cVhDRDhURS9URU9U?=
 =?utf-8?B?bzBIVzBGLyt4ZHVEVUdoS0ZndEU4UGtzSlMrQ1owa3lvZTNkZU5iVWRNK2NO?=
 =?utf-8?B?WjRYL29iMSsyN1Z5L0g0MWFac0RFdmxYcEo5SFRKMWNXbUIwUURQRGhUTjlX?=
 =?utf-8?B?Z21velJlNm13WkQ0b3Z1K2ltQ3JHb3dydTFVclZDLytTREJ6L2Y2bUM5c21R?=
 =?utf-8?B?TWdyWXpsNXFENkg2VWdOMCtUMkdSTDZPTi9xYmthVkdCenZiMXRNbVQ0UnVk?=
 =?utf-8?B?WHUxeE4yN3RzaVRmREliVm94K0ZPb0hRKzlGSHVYZHluYmp4VEpmYVI5WEdE?=
 =?utf-8?B?S0VnSDVFZkpGWHFYSTQ2YytVSTlqRXFwTzhTeHQ0MEYvbWlNdnVJUXh3OXJl?=
 =?utf-8?B?bWxvN3hIVXVkRGxhOVFuMjlrSFRJd3Z4L0pJSjF0OWduTEN4V0xrOC91K1A3?=
 =?utf-8?B?VjJZR2g3T1IxSEFmWmVnbEpBU0Q5T1FseStnbTJpeGQzWEVyN3RaOUdxNWVK?=
 =?utf-8?B?ZytHSkJOemM4eFQ4T3FpWm1JRzRQTmtnamZEb0ZZSjN4cWtIWjVrcEQrY01H?=
 =?utf-8?B?WllvdkIrTFFoMi9WNU5TUVBWd1dhY1A4L1dNa3JyUEVwZ2YydzRJMnNFc1pX?=
 =?utf-8?B?ZTZJQmV2bFQyK20wRS83TDhXZjJhSkg3KzQwK3h6SGkydzBzTzlXaHozOWJQ?=
 =?utf-8?B?UEJ0NERFUnhMYktVTUh5ZFZjSGxod1dSTHBrQzdhZUFPT3RQSUp1bGc2Z3Zw?=
 =?utf-8?B?ak9SanBvT0tHaTlGQmRGVjBENmgwNi9aUHBwRDVnSnBCL2JMZGtVbE1nd05h?=
 =?utf-8?B?Z2Y4eVI1eDlvcU1UbFhQNklnMHJGb0pudGdpeGtxNmJvb0xHWnZQTkJGVDBv?=
 =?utf-8?B?SWNiYUl4SHI2WUJYR2VIcFRPS0Zod3pvQ0hvQzUvNkcwOGgvaGJGWXhSVnpo?=
 =?utf-8?B?cWdKU0Y4anpvUlJ0bTJVQ1hGcFhaWHIrSDh1TVJhU2srSEkyM2pvc3hOOTM3?=
 =?utf-8?B?ZnJyUTM4YjVWN3lIT0ZCL05QakZZdDZadmN0SmZhZmxHaFllMXBLcWZaVUJO?=
 =?utf-8?B?ZUpGMFczVVVtUFJjZVhNSGxIQ2ZUZGlibWx0VzFZSThLSkpsTmRVQTR5STYr?=
 =?utf-8?B?c2o1SVhhUDQwSC92cnlvcXhOdDBQTFNyNHBzZ2RVMTJBZkE4YW9mUENJV3NJ?=
 =?utf-8?B?ZnlxRXA0Zk96L2Rmanh1VFFCSUJIWnZRaXk5TTNPd0hxS0t2WEtvNUtjQmNO?=
 =?utf-8?B?dlZJK3RtdGpBd3MxVDF2cmlTSE1lM0x6RnFYR0RXYWtoLytHWVcxN3QyOU9p?=
 =?utf-8?B?UlRwaml6TGIyb0ttSTRWbi9BM3VNODJoaVZVWXpoZnRERzB3b2MrMk9mTE1Y?=
 =?utf-8?B?K3lOQ2dHbDVQKzJHdUkvQ3VuK0xIWm1lT2M4d0hwL3dpQnRYNUdsVHpuUG9G?=
 =?utf-8?B?bm02NWk5NEt5NGJDbkx4MUQzTDBtd0U1cStPcXBrei9kTEh1Tno3ZWxSR0Rj?=
 =?utf-8?B?c3ZPZHg3dit0bFZaNUlBK3hBeERaUlBzcXdLZjFzalZqZHowSm54K3VuazJG?=
 =?utf-8?B?U01FaXNDbS9FeU5hU0ZvaW1ndkYwSXBKUlFLTGt6NGg3bGNzcXFWaTIwYm8x?=
 =?utf-8?B?YlhHd2gva0dkL0VhdG1nTzh3Zm9GT2UyeEcyVTlyS0x5TWdCVTBXWndjNHMv?=
 =?utf-8?B?WGJVMHY3RkFKRXZHcGY1WlR3MXFQZFcxWUN0YkpuWlVVczZXK3NmRlJtUFFa?=
 =?utf-8?B?Mnc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <9898D3BB040D2F4AB0328BFA165E6C35@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	eWJc8Yh1rmWu3+BmpHxkr35h7+09TaWFpU/LtwSB6/Zco8hJRw8DSXGQdQ5WpXo9emR/3GrzB68Z0vgMjGNK6dnyZ8fkvBt1rCB24ilXc75KAzCbEYx8Fe6T9TIpWmL/XMG0//pcO7nH1yiuUemTZ+1aunEWsGEmnLqb4R4wtDu0ifPP2DiB+pWTzUFR2XRnlM6f5XUuP6TPAaVRzuQ3IHasCBPzStGktbRpwuSAeJ4SiaSs0CIEeylEvh2UuF+o3mfhZdRfwoNu4zpXlQFrIMmrGZzIeclt+Z3qEi4IcSIUsXh8JC4VR0CqxlqWphvOZz0Z7QoO2ntzIEQhHOwpCthLf+94XlxgRUK001rzsjC18NLeK1yQJhhoZZtbtCQYr2/gSIlok6B7S/osYgsLyk/FN+x+5B6GybVgafvlejIu2Cz2XPq811UhU1YX6S1hzkWwnLL5UGoc2RTfI863CQKqQrmIA39nnPA1uBxe27xYe1vUZ1tyNbJWfB/1vALTXrxudeKjO/MdRTjQlqjXDIYx2b2R6xXczWW5HZrrz6TK0K60EsqxM0f7O/+zmAnbIYF4mEKxy01wdlJb6P5o8Cc/XJLILPlKUQ/RSncwzoUS81p0VPnA8E0n8KDJW84H
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ae8eeff-e56f-49a8-ee05-08dd18ea1873
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Dec 2024 07:13:06.7804
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rOwPLof546ETJiHsqb7HxhjKUNz0pQujIP0fSDr59OSsof/VGMQpYbe95MPp1VM/J3s84pQkPhDF0uoe0mNjeOOatZWuEOhDpni0QhGgcxk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA6PR04MB9520

T24gMTAuMTIuMjQgMDg6MTEsIENocmlzdG9waCBIZWxsd2lnIHdyb3RlOg0KPiBPbiBUdWUsIERl
YyAxMCwgMjAyNCBhdCAwNzowOTowMEFNICswMDAwLCBKb2hhbm5lcyBUaHVtc2hpcm4gd3JvdGU6
DQo+PiBPbiAxMC4xMi4yNCAwNzoyNCwgQXRoYXJ2YSBUaXdhcmkgd3JvdGU6DQo+Pj4gU2lnbmVk
LW9mZi1ieTogQXRoYXJ2YSBUaXdhcmkgPGV2ZXBvbG9uaXVtQGdtYWlsLmNvbT4NCj4+PiAtLS0N
Cj4+DQo+PiBZb3UgYXQgbGVhc3QgbmVlZCB0byBzdGF0ZSB3aHkuDQo+IA0KPiBXaGljaCB3aWxs
IGJlIGhhcmQgdG8gcHJvdmUgZ2l2ZW4gdGhhdCB3ZSBhdHVhbGx5IGNoZWNrIHRoYXQgaXQgY2Fu
J3QNCj4gZHVyaW5nIGRpc2sgcmVnaXN0cmF0aW9uLg0KPiANCj4gDQoNCkkga25vdywgc28gSSB3
YW50ZWQgdGhlIGV4cGxhbmF0aW9uIDspDQo=
