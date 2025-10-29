Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D56562EBB96
	for <linux-block@vger.kernel.org>; Wed, 29 Oct 2025 16:02:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.154.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761753732; cv=fail; b=UUD/oF6FKvi4t5Lnq9gsPzt+wpBnUGhzTalSRnXdq71DhjreKGLckTqlGQQbcyHdMYpNTLJbMlPVU6btisgQofd4gnzrpuCn6OgIZNoMwnjjYWSF7OwlVdQ6sI7ESq/Lcxkpu+PiXm3Ktyn+8laKldN7NkjFGLijJ/QslaE+QSk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761753732; c=relaxed/simple;
	bh=ZfNRGwJh3h/97EvDoy4y1WzzWf2l9GzDzHfCiStF6S0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=sx9Q1XWbssFtehPA2e3/zTLpfBMa9WcwO8s3cxKII3+qxBr6IPr8eVxUpoyIFYg69gwcnREpIhkxqni4Bfa2ZH9SXu8KiNO6oANmmjoTpAFgNUsuAXHPdxS8CBA3TILSMkksIU+WQlvChmWd57yX/zCgjab1nxqOoWGfRNQUQ6Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=R713Jn9B; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=Wa58Y5ns; arc=fail smtp.client-ip=216.71.154.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="R713Jn9B";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="Wa58Y5ns"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1761753730; x=1793289730;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=ZfNRGwJh3h/97EvDoy4y1WzzWf2l9GzDzHfCiStF6S0=;
  b=R713Jn9BxBZGxrzQ5eFP00YKk2kGwrur2zAo6rDJzsMBYdxAscHP/ubR
   1Xv9SmmmfXQrfkhHJALORyHyGZ5LeWrctRsC3ub8+6wyFMmDfyTkj/2IN
   hJeWozbFvVOcWWdozJCzxfXFYTmndVRRaqdFsMcebrcg69HwvdXDQKMXn
   Si/KD4LcvctOS9IC+Uz8jRUjCr0ZNG9tSiPUnFH+x0PQMSnDI2YZC9zM0
   xyUzIacR0UoM6AbF94Q3qm38pmGNoSyp9tUpVbwZhR4TgWKRPjNy+++Ql
   Ja7MDcmoYGctKb/a2OLJw7tBihQZrrHHkEGZou+nUkDqC2KuEjtlK0JK6
   g==;
X-CSE-ConnectionGUID: ngHFkmXnSM6/4DdKqw+0ng==
X-CSE-MsgGUID: LnDb6Q0FTWq/HrzSZMEBXg==
X-IronPort-AV: E=Sophos;i="6.19,264,1754928000"; 
   d="scan'208";a="133785495"
Received: from mail-southcentralusazon11013008.outbound.protection.outlook.com (HELO SA9PR02CU001.outbound.protection.outlook.com) ([40.93.196.8])
  by ob1.hgst.iphmx.com with ESMTP; 30 Oct 2025 00:02:04 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gOOoOd2zsixfozUL7DgHSe3I2zXSHhyKkZN/lW5299AxU9dp5VPjf8fx//HqORwz+8U/8XjzgLbrOjJeDj3OAL+66uFd72d8elU2pmmA0RBnXt02pDxMS9Pf/AbfarqQUBBkZjnmuOE8HAgX16WplCSH6+u1e11K1Nl0hE4YYEl+0XhrOrdkW0YBJLY2in1XKae9pbjOHdg0QjkJctqzA4UwwzhX9paU6Qj7VsrubTIgupqbQEC/sNtYgxH+xGOXxMMxUR0C9cieqigb/W4ejrOzfvvl0l9ooy7OwyeSuVXyRAefEYxl8Vt4dZ0SHsFL61GAtgOQterN6ThZ9Q9orQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZfNRGwJh3h/97EvDoy4y1WzzWf2l9GzDzHfCiStF6S0=;
 b=wEJNa7kBmZv4ZywLFTfin/OgknvScjLTE834ubsNwGKejP3LrSG41bXtAtTK6vV7epGB65WQAk3Ufl7cBH+XwE0Y7bEtR2A+OsDogSM2v/3enT6ATCueuceYt35CxQUJViF7Qr5xEpil7BQMO3z3m/sJWOZlMi5xTB/NBiQKqsRsqWNj4KWr+JWeInYU2OuchvV7Tph5mrCAm2bvKoadKc8CPrCotOX82VL/CWqaJOPz1+5PMfY8uBWqFZRiz+AyC0s5BQF3l914lAr0qFyGUgyo23wKe1aVYnB7dWzJ84Vv4AyijswN8QRanTJ8I9SbgT5E+QGkWkLzTo/ytwZkkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZfNRGwJh3h/97EvDoy4y1WzzWf2l9GzDzHfCiStF6S0=;
 b=Wa58Y5nscuJwFGsZIf2T/jdioKevqfpmcbDygEwvtIWui3RVjxqDdgC6Xts2xG1AWhmIqXTbOKRrnapKGhnsa9SPBzWXqLpkoo/YhM8G55L6bGcQS2HRlZ10Qz8A9mFu4QhPEnAGXDfTURqzR4ll6lnK9GANu4fyH0p3xOVMvM4=
Received: from PH7PR04MB8755.namprd04.prod.outlook.com (2603:10b6:510:236::8)
 by SJ0PR04MB8441.namprd04.prod.outlook.com (2603:10b6:a03:4e0::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.18; Wed, 29 Oct
 2025 16:02:00 +0000
Received: from PH7PR04MB8755.namprd04.prod.outlook.com
 ([fe80::4372:e8cb:5341:9a9b]) by PH7PR04MB8755.namprd04.prod.outlook.com
 ([fe80::4372:e8cb:5341:9a9b%4]) with mapi id 15.20.9275.013; Wed, 29 Oct 2025
 16:01:59 +0000
From: Hans Holmberg <Hans.Holmberg@wdc.com>
To: Keith Busch <kbusch@kernel.org>
CC: Jens Axboe <axboe@kernel.dk>, "linux-block@vger.kernel.org"
	<linux-block@vger.kernel.org>, Damien Le Moal <dlemoal@kernel.org>, Johannes
 Thumshirn <Johannes.Thumshirn@wdc.com>, hch <hch@lst.de>, Shinichiro Kawasaki
	<shinichiro.kawasaki@wdc.com>, Andreas Hindborg <a.hindborg@kernel.org>
Subject: Re: [PATCH] null_blk: set dma alignment to logical block size
Thread-Topic: [PATCH] null_blk: set dma alignment to logical block size
Thread-Index: AQHcSNmRMl31g9c7cUqN+P/TmYvZCbTZKlqAgAAWbACAAAg9gA==
Date: Wed, 29 Oct 2025 16:01:59 +0000
Message-ID: <4d7dca6c-ea8d-4506-a692-a6515ebc7c6d@wdc.com>
References: <20251029133956.19554-1-hans.holmberg@wdc.com>
 <aQIgvwec4Ol7ed8K@kbusch-mbp> <49749a76-5849-410f-966d-6011dd4d5f41@wdc.com>
In-Reply-To: <49749a76-5849-410f-966d-6011dd4d5f41@wdc.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR04MB8755:EE_|SJ0PR04MB8441:EE_
x-ms-office365-filtering-correlation-id: 94ab68cc-72e3-456f-ea2c-08de17047e40
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|19092799006|366016|1800799024|376014|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?QmVFSDZNTnFPb0gxVHEzM0Vzd2xjaU9IUStMQ1Qra0FnV01zRGhMK0UySVMw?=
 =?utf-8?B?b0JCYVgra0ZCcXVIbzVxb3ZkVGJUdVZ4NXNGb1pBbytUdkhoRXNrOW1obVc1?=
 =?utf-8?B?V1NxVnlaNW5WaVNNeGx1MEVBbndpcDJUTDJLcWpjY2k0dDlZR3hVNklpVE1W?=
 =?utf-8?B?dDhzeDRWV1kxWmZxQTM1ZnBmdHNWSGVtSkMxODRjMG0ycWpkSTNRWFhRdkcy?=
 =?utf-8?B?M2Z1V09GUEhYTlBuQzk1TnlBYklraTd6ZVVuNjgycWh1cGtYQUtzQnN1RXh2?=
 =?utf-8?B?TTBBemNFdXg3MHlqbmR1MEZDbVlURnAzRWNBbmFHd3cyQmlCNnN4Yk5ZOXA1?=
 =?utf-8?B?VDdDOWlONXova0ZOaUZEWmZ1TkJnVWsxZEszK2N1aFcxSFB2eUxWOFlScjZ1?=
 =?utf-8?B?OWl1WUM1L1k5ZDNTUUh6QldRcFFsbkZ0ZUQyNUR2QktnUWxSanBaaVVQb3J4?=
 =?utf-8?B?aWtiZ2JaQ1dkRkM3M1VvZWlSN2FHcE5RWjE1UytuenkzdmhvNXg2OWdpa0VV?=
 =?utf-8?B?M0pGdmVNUUhzSVNKVEU0WTM1L2VjZ1Znd09kQnpuY05uOWQ3VjIvQVRNWEpw?=
 =?utf-8?B?Z1QyV3pTbS9hcXhxNENDa0F3bmwxb0hxVjdUTi9iVndwTEZyWXcyd1BCZURC?=
 =?utf-8?B?OC93KzhpbzZDNjBBZks2Z3A1QlBTeDF6TmFlcE82c09TS05STzJYRm82a2VR?=
 =?utf-8?B?OVM0SS8ybDdVTGwrWjNwNXhKZGJyV1dTN2RsWC9kdlVXL1grTHY3cWsrNXJv?=
 =?utf-8?B?WmJ4UDV0VWpnUVBjNjBjcDZ2bGtQOFNUYmFXM0JQWlEvVFVVL0txOGczNFl6?=
 =?utf-8?B?a015dWY5R0NudlBVMWJocGxHSE9EbTRGRzZQUGEvVmdDMHpJWlNTQ1Jxc1hr?=
 =?utf-8?B?dmkyYXl2bVZWN0dBK3JYdXdTM1dkbzdOVmhFWWpzbHoyWmtPTVpNS0tTYU9l?=
 =?utf-8?B?Nk9lWmp0ekQ3SURrbStNb2ZFa1h2VWJVemJ4SmxCeWFPa0xwUUxTQjAwNVlN?=
 =?utf-8?B?VUtlWW4xRVlLdGI4amJMdThyVndtNCtjbGIrV0NqSVNkMmtiUWw2bjkyaDBJ?=
 =?utf-8?B?MitYVXR6Wkg4ck5rWmdsK1l4TnkvQmowN2h6d3RqU0xnZHN5MURPN3RLbTdP?=
 =?utf-8?B?OUFsS2dzNm1mK0tLRE5VWmJGRGpmVEVaSkhWOVJsekdWV1V0cUphUlhqQWx5?=
 =?utf-8?B?QUR0NkVTbjVuQUN4UWZuWTM2UkJvTTF6citMZTNNcFJwcnlYOVdidGxmNkRi?=
 =?utf-8?B?VXhGTFlLTlRpZ2M4MnB2Q1FJQU83Q2RQeStRcFBKczFwVGVzUWlXWEJDQVVP?=
 =?utf-8?B?R3U0VmNEOTVGbnpoRmI5ZUFiT2lwWEQ5NFBRa1pDaytPZ0c3Nm81Vm5tYmxF?=
 =?utf-8?B?T0F6dTFqczc5OG9GTGNDeWNxWlRkdmJMMjFDZU91UkJPb2g4bzc3SVFvUmFo?=
 =?utf-8?B?SStTeXBodFJxRWFjUzRZc3phbW5pRENhWG1ZRXprdnZsM2xkZXlFT2RUeVlM?=
 =?utf-8?B?eWFJdll6L1dwUW5zZDVvWGtDZGNweTdyVTR1TDlXSjFGM2dib0Z1M01RSjg5?=
 =?utf-8?B?MWk2eWg0Z0FlWmhIcXVLOGJKd0puODFXaytUeGFyUDZIcjZEME9IcHQ3cHJ3?=
 =?utf-8?B?bGtZZ3BwVXo3TGdGKzdMRDBvTU1vVHgzVWZSWWIwdDdQQmZZMmJNd1dUVW5O?=
 =?utf-8?B?R1RXdjNQekFxbjZUeEljdUNXQ3V1aTh0VHFQSG5sL1BZbXVkM245TkZYQUxh?=
 =?utf-8?B?aEtjclNVZjQ3cnFpbFlXck4xQTJVNWlYY1lhdytzMkJuNG1KWE5sQVZBZ0Vv?=
 =?utf-8?B?aVdreXlsSnhhTGFVeFBWVVROL2FNTDJ5TERjMEVld0VTR3pDNi9FeXpnbGxk?=
 =?utf-8?B?b3FoNDh2TG5QWlp3S3dGd1ptZ0dUVm9vbjJ1Z1k4Y3B2cThGRTZTTC8vci9p?=
 =?utf-8?B?Zk92MmJNWmJVQkJueld4b0gyc1FhWlRVYm9IbnF0d3JJNUpIVEN0bzRyUHhM?=
 =?utf-8?B?SUREVERYb05lcnVSQkJWMXVPU0M1ZWEzNjBFOGRDU3NEQjI2aFFVcTBlbnlH?=
 =?utf-8?Q?RKcX+9?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR04MB8755.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(366016)(1800799024)(376014)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?S0MzdDhKVVNBSTh0MzRmRmk3NnUxVUZZNlFob3BxWHVXb3VaYnVFY3FyQ1Vo?=
 =?utf-8?B?c2NDMkM5N1pxYkRkbzdKSTVZSDNIUEpyK0hqbUtVYlYxa0F2RE1jcmpoQWFZ?=
 =?utf-8?B?WFNLNHoveUdZclJRSDFaOTNBYmVFR1YzcnlNYVIwTkQxRndnQlRCcXRVN3VX?=
 =?utf-8?B?cWFVSTZXUDZ0MHFJNlRqa25IV3BNbFA2NmlSa0ZURmMvcEpuQkM3ZDNUVVZY?=
 =?utf-8?B?MG1BbndDSTRNRVU0UU1JUEg4K1ozUFhNRkFRcjhoS2oyYXVqeUdLNGFuM25j?=
 =?utf-8?B?NisraFRkMnlaUVArdkFDaWYrNVh4Wk9aa0FoZ3pucEl3SzVCRGlkSFU5WlBQ?=
 =?utf-8?B?cGcxQUNyVEdyaXZYZ1BwUHNuaVBQSldhZXRTWDMvNTJxcStxM1ArWE4zc2xw?=
 =?utf-8?B?RWJ3M1FwYWl0bjFrZE1WenpPSW9ieGhDdDAxVGs3NlVXOExXeXJHNXVZY1BW?=
 =?utf-8?B?L0VoS2ZjOXNJclY1MGJzSVE4MEJQdlVxemV3Uk9vWlY4SzEzRlpGRE9lNWdw?=
 =?utf-8?B?dndCaWVQVUMrQ1VlMEk5SUlSbU84NjM0MkI5TVlpZ3Uram5XeFc2NUcya1Ew?=
 =?utf-8?B?SkJEbDJxOTlkN2VaSEEyTlBSc21OQ2RvaWxKaFc0b3R0ZUw5WmRreUwxcGJv?=
 =?utf-8?B?aEdkeXdvajNIQ29EZmxscHhYdmxkdzlhMzVtYlJaVFBjbUJnTk1yL0tIb3BD?=
 =?utf-8?B?a3hDVkJQRUJ6Y0Q5TGJPNGdFdTk1c1hPV2E5LzRKQ0xMOXk4RDVWL0ZBYlhn?=
 =?utf-8?B?RFFnRzFkNXJoUUhHRG9XRnVrVEFhMmc2d3AwVFY5QnMwZ1AwU01hNXpGQ3Qw?=
 =?utf-8?B?UVU0c08wZ043cW5iMlRtWmE4eGJxYlc1aXBnVE56SjRhTEFRZHAxd0ZUSnNm?=
 =?utf-8?B?c3VpSUlCZ1RaUXN5NnU1WXIvbUZTTjA3dmNVeHdVODRodW1FenQybE9paysz?=
 =?utf-8?B?L1NRZVR0cnplVkdDNTVDenV5QU9oLzkyZ2pmRG9NRWVmT01ySkxpanQ2eVVN?=
 =?utf-8?B?MDZobGZKNmFwVmc5SWg4em5aWGVCbFpaYml1cFFRb1lnOXA3ZnFhaGI3ZHd6?=
 =?utf-8?B?SlYrU2s3MnpaUDhlaDVkVXFiT2hsQXUwek43REVJTzk2TXdlK2VHaWg2MWx1?=
 =?utf-8?B?YzZTZ2tnZ3UrTUpjeEEzT21xeUM4UHk4b2hSWmxGcXBSaktnR1NLbmdLazBy?=
 =?utf-8?B?OHNvQ0FyclJnV2ZBUkphbXQrTWZweEpJS0J4RUREbnRlcEFpaXp3S2ljWE14?=
 =?utf-8?B?UzIxb1lPeGIvNTl2NzBzWm15Z1RtYVRpY1VrbHZ6TkE0NHhvTDd0TjJmK09S?=
 =?utf-8?B?cTRVanlnWnd4RFZTN0lwSjl1Zkg1UklYSWpxays4T21SNTRRb3I4TUZ5QVN4?=
 =?utf-8?B?RUxxQXhKak12bng3Q0hTSURzZkxNUk4xQU9rK2pXclJtRG9wVStld2tSRjBk?=
 =?utf-8?B?MUlIRmk4OGlUTzVZMXR4Y2Jxc1lRelVSN2puaGZlS3h5NlNIaVg2YzlvVHdl?=
 =?utf-8?B?STNjRi8vT2l2QUZDSTluUGswTmRTRTZRbUJMd2MxWkpTeGZ3VHRtaEFRUmVI?=
 =?utf-8?B?RmVyTzREZ0JtQlFwanRzUTBXa3lpNVozMkZiR0g1SitGUFE3d0dIRGJEK3Zq?=
 =?utf-8?B?eDlza3JHcytsai9rcVNLdC8rNGMzQ0wxM0djMi9DYUlJbENtU1Fha2lVOUhT?=
 =?utf-8?B?U09vdzNRaEF3bFJYVHFqR25qcnJvYVc2ekR2dndQOGRyUC84eUNSU0dCVXpU?=
 =?utf-8?B?aWM3WGNUMUhpVGRWdHRMSEUwZlZYeWFESXRvaUFya01VN3ZXaXNMNkFNNFV6?=
 =?utf-8?B?SVJXYW1XMEUydnN1QjZHcFVGeHpWaTBqT3ZhUnFhWHE4RjZnNnBGVUVNdGlW?=
 =?utf-8?B?OUlEVHF0di9nR3ZmT2V0ZjFzQ1RkWS9zUnIrblpzY2l0aTU3cDFnR3JxWUxv?=
 =?utf-8?B?R2ZJTEI0alQzdWsyWXdvR3I4RnVDUzlmemNOSzhZYmRzb0U1QkdqNldJRTJU?=
 =?utf-8?B?aHdTOEJBSEw1by84WWtlRUN0elFKbENzOVVoUmZiZzh4c3l5d3gwU1lnNXJV?=
 =?utf-8?B?aUlPMSs2dGhyNlVWS05FYzFQeDFuMVgwbTlyQWNwdE1GSUVLbXNxMml4U1Q3?=
 =?utf-8?B?c3J5NW9aekFiU2tnbjUraGJINFZ4QzJ3YWpKOWEyNUpFdmlSdXd0aTlFNGEv?=
 =?utf-8?B?d0E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C2223D5EE37C064A82E89525D52D2BA9@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	y1xRo0dLdIUtdVWrN1IkWWAVsLdzcua2ipTUtCSYErw7A5iLIuxbGTbrV594b76TkTVHjIF5x6QXgr/CopS2yQk3ddOVQVAbKDunNB26WMFpmWWZwQj71yL9MRgyY7xFdWYvjTJMTInfJ2M5BjkaCLzXWSe11Ayz00SloMXsudVkjkwIarb04Q924VqBITCEKiHySNtemZw38l5VCbRzkWrbJV4ZySO+out0YFd10fB09BdgDOBz/Oz+1ULXnuKQxkTDQZM44PgSk4e5ld8y9b4YVLP0wDc+k3hC+BbtkSufXxqXMDmaBz04q/yVoKKSl2vOg6zSwHr9dXFweVC37wn4IvYnn54HJ+wzcw6FBkDoiFqe2k7Yx56b4Y92VLXVwt27SkhDkft3pQIJSuVKW/zI/kJAros7NxVLlv9WpMZw17/3t4Ix39KZRi7YrzHSeATCdhZHRFzMSDWTG+4dRtUV4TGO0PB0cXRqgQS8xIKP6g9txjNWA1AbdltJmpSEJvx1i5NHJ2pbR4Dj3mMibRu+lFnt1l9OSx7Ss5lKFU5lmjUf72E08lUDzMyqA4oNy3Ranux53Morqx8rw3C+HJxwpVdbkfJi6K7HQkyUzIImI2/5CVWcUaKAYrSkOkxH
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR04MB8755.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 94ab68cc-72e3-456f-ea2c-08de17047e40
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Oct 2025 16:01:59.8286
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /u1+YBhlYHWqoOOsQQUobst8zMnzMjrvfedMtbLRS3CKQNDOIAo09WlBO/tDecvjBH3sXB3mA9c9QiuDDRTlhg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR04MB8441

T24gMjkvMTAvMjAyNSAxNjozMiwgSGFucyBIb2xtYmVyZyB3cm90ZToNCj4gT24gMjkvMTAvMjAy
NSAxNToxMiwgS2VpdGggQnVzY2ggd3JvdGU6DQo+PiBPbiBXZWQsIE9jdCAyOSwgMjAyNSBhdCAw
MjozOTo1NlBNICswMTAwLCBIYW5zIEhvbG1iZXJnIHdyb3RlOg0KPj4+IFRoaXMgZHJpdmVyIGFz
c3VtZXMgdGhhdCBiaW8gdmVjdG9ycyBhcmUgbWVtb3J5IGFsaWduZWQgdG8gdGhlIGxvZ2ljYWwN
Cj4+PiBibG9jayBzaXplLCBzbyBzZXQgdGhlIHF1ZXVlIGxpbWl0IHRvIHJlZmxlY3QgdGhhdC4N
Cj4+Pg0KPj4+IFVubGVzcyB3ZSBzZXQgdXAgdGhlIGxpbWl0IGJhc2VkIG9uIHRoZSBsb2dpY2Fs
IGJsb2NrIHNpemUsIHdlIHdpbGwgZ28NCj4+PiBvdXQgb2YgcGFnZSBib3VuZHMgaW4gY29weV90
b19udWxsYiAvIGNvcHlfZnJvbV9udWxsYi4NCj4+Pg0KPj4+IFNpZ25lZC1vZmYtYnk6IEhhbnMg
SG9sbWJlcmcgPGhhbnMuaG9sbWJlcmdAd2RjLmNvbT4NCj4+PiAtLS0NCj4+Pg0KPj4+IEEgZml4
ZXMgdGFnIHdvdWxkIGJlIGluIG9yZGVyLCBidXQgSSBoYXZlIG5vdCBmaWd1cmVkIG91dCBleGFj
dGx5IHdoZW4NCj4+PiB0aGlzIGJlY2FtZSBhIHByb2JsZW0uDQo+Pg0KPj4gU29ycnkhIFRoaXMg
aXMgZnJvbSB0aGUgcmVsYXhlZCBtZW1vcnkgYWRkcmVzcyBhbGlnbm1lbnQgY2hhbmdlcyBJJ3Zl
DQo+PiBiZWVuIG1ha2luZyB0byByZWR1Y2UgdGhlIG5lZWQgZm9yIGJvdW5jZSBidWZmZXJzLg0K
Pj4NCj4+PiBAQCAtMTk0OSw2ICsxOTQ5LDcgQEAgc3RhdGljIGludCBudWxsX2FkZF9kZXYoc3Ry
dWN0IG51bGxiX2RldmljZSAqZGV2KQ0KPj4+ICAJCS5sb2dpY2FsX2Jsb2NrX3NpemUJPSBkZXYt
PmJsb2Nrc2l6ZSwNCj4+PiAgCQkucGh5c2ljYWxfYmxvY2tfc2l6ZQk9IGRldi0+YmxvY2tzaXpl
LA0KPj4+ICAJCS5tYXhfaHdfc2VjdG9ycwkJPSBkZXYtPm1heF9zZWN0b3JzLA0KPj4+ICsJCS5k
bWFfYWxpZ25tZW50CQk9IGRldi0+YmxvY2tzaXplIC0gMSwNCj4+PiAgCX07DQo+Pg0KPj4gSXQg
bG9va3MgbGlrZSBudWxsX2JsayBvbmx5IG5lZWRzIChTRUNUT1JfU0laRSAtIDEpLiBBbGwgdGhl
IGRhdGEgY29waWVzDQo+PiB3b3JrIGluIHNlY3Rvcl90IHVuaXRzIGFuZCBTRUNUT1JfU0laRSBn
cmFudWxhcml0eSwgc28gZG9lcyBkbWENCj4+IGFsaWdubWVudCByZWFsbHkgbmVlZCB0byBtYXRj
aCB0aGUgYmxvY2tzaXplIGlmIGl0J3MsIGZvciBleGFtcGxlLCA0az8NCj4+IEFuZCBpZiBub3Qs
IHNpbmNlIG51bGxfYmxrIGRpZG4ndCBzZXQgZG1hX2FsaWdubWVudCBiZWZvcmUsIGl0IHNob3Vs
ZA0KPj4gaGF2ZSBiZWVuIGRlZmF1bHRpbmcgdG8gNTExIGFscmVhZHkuDQo+Pg0KPiANCj4gSG1t
LCB0aGUgZGF0YSBpcyBhY3R1YWxseSBjb3BpZWQgbnVsbGItPmRldi0+YmxvY2tzaXplIHNpemVk
IGNodW5rcw0KPiANCj4gc2VlIGNvcHlfdG9fbnVsbGI6DQo+IA0KPiB0ZW1wID0gbWluX3Qoc2l6
ZV90LCBudWxsYi0+ZGV2LT5ibG9ja3NpemUsIG4gLSBjb3VudCk7DQo+IC4uDQo+IG1lbWNweV9w
YWdlKHRfcGFnZS0+cGFnZSwgb2Zmc2V0LCBzb3VyY2UsIG9mZiArIGNvdW50LCB0ZW1wKTsNCj4g
DQo+IEp1c3QgdG8gdmVyaWZ5IHRoYXQgbnVsbGJsayB3YXMgbWlzc2JlaGF2aW5nIEkgZW5hYmxl
ZCBkZWJ1Z2dpbmcNCj4gZm9yIHRoZSBjb3B5IGFuZCBoaXQgYSBidWdfb24gaW4gbWVtY3B5X3Bh
Z2U6DQo+IA0KPiBWTV9CVUdfT04oZHN0X29mZiArIGxlbiA+IFBBR0VfU0laRSB8fCBzcmNfb2Zm
ICsgbGVuID4gUEFHRV9TSVpFKTsNCj4gDQo+IChUaGlzIHdhcyBhIDRrIGJsb2NrIHNpemUgbnVs
bGJsayB3aXRoIHRoZSBkZWZhdWx0IDUxMSBieXRlIGRtYSBsaW1pdCkNCj4gDQoNCkkgY2FuIHJl
cHJvZHVjZSBhbmQgZGV0ZWN0IHRoZSBpc3N1ZSBieSBydW5uaW5nIHhmcy81MzggaW4geGZzdGVz
dHMNCndpdGgga2FzYW4gKG9yIHRoZSBhYm92ZSBCVUdfT04pIGVuYWJsZWQuDQoNCg0KDQoNCg==
