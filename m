Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0DA22FFFBF
	for <linux-block@vger.kernel.org>; Thu,  4 Dec 2025 12:28:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.143.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764851299; cv=fail; b=jR8IIrmySXVBVgqHYrnTydekHyhkTikXxWILDRNPXD9LDxU9sH/5x0jywfETvccFs7nq4u115/KPZ19m0yCPurIPnAqklPlOKrmy+VHgZIwkZs/MYXBwnt1dO7TL2wd7cioAwzECKqm5LEyUNtmx2u5gBcgyXCOrLmRiBCnkr2Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764851299; c=relaxed/simple;
	bh=f+z6ql9M5JhawzkmfcJJBxApS2D5ls0dv54BOWw8ja8=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=SB2V4INfiX9oamYcrR5uVn5V5VkgBO72iQiFQKEj5EKDDtu+piuI0jEeSvAL1t8I3hFyz4X0J9tcmEq/3nwydrFexBrwTyrhDq2vQB1UhOtEec/gQtQQ3MYgcolC/Y2W23B5Irp/9gDZ7rTWVAOS5+vdnwWmN3JzAREGoSWVLgk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=IOKzprfm; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=LXsVM1Bn; arc=fail smtp.client-ip=68.232.143.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="IOKzprfm";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="LXsVM1Bn"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1764851297; x=1796387297;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=f+z6ql9M5JhawzkmfcJJBxApS2D5ls0dv54BOWw8ja8=;
  b=IOKzprfm9x8OTjkXZbW3e038G9a05+7OXlos2fduwdEqIt2o1K6VFIN+
   kxrSsciyP+62Qbj2BksVZp5nWaPBLjBGheUf3uz4Xz2ICw2051VzizJwk
   OEaCRVektB8L04coxsonDEOcbJK6YSAzayJxdFmuZvclvCSd5OZN9Jn6G
   qQExg2E8/xkWVM6J7Y3BAC9j41Ky7sKwVtzjxE1G23Ud4yHRUCeuAYhLz
   SZ2xB+gMG6tRTHVV6c0SG5T7Uk7dIA6rfQWm6zDXKUPZ6D+BjXijWVE3t
   2WTiGn08h4uojZ4WAtmliu+18SttyDUpZFMI3HuwW6SouNHguNO5BVD+w
   w==;
X-CSE-ConnectionGUID: Mme9p38RSv6qC+XszPsKew==
X-CSE-MsgGUID: saAE0I6pTLGPxmJENZ58nQ==
X-IronPort-AV: E=Sophos;i="6.20,248,1758556800"; 
   d="scan'208";a="137668960"
Received: from mail-westcentralusazon11013020.outbound.protection.outlook.com (HELO CY3PR05CU001.outbound.protection.outlook.com) ([40.93.201.20])
  by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 04 Dec 2025 20:28:10 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=D4OWGmo7TtrtZiRb7oev6Be62sw30nzKrWFaWm1VYgSU6iZUqcUIfsYthYGwJRBSrzJJjPIYJqO4FjHBj7R6VMeKliJZV110nSq49WsOtGEeJdQot+uQybWS3HpRHdoSVNMVWQ8Y9jxDsIeKKzUSxYd19z8/taoVa2D+zSsAZKoSllhmAlo/+kuHrYvqTcEsJDcJ1b70pls0IlWv9R01zjff1t8Ph1UFiBxU6fkf6E6O8xq6lL4ayxsc/e86l87DJHQX6HKEXLpq4zfiF4uPkDL7LW3rEJgKjB908QMfXsAkWm++qaupoEC1jo4JUbEojmMTfIZnKEF/P9AwrNsttg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f+z6ql9M5JhawzkmfcJJBxApS2D5ls0dv54BOWw8ja8=;
 b=GObbdfeDLK5Zzf7CUeqo92ZwisKYz8crU5zKhl0yrTosrZiQS5QuIZaWdFCQnKlAPSpjN+kRffhMS+XwPqI9CV3a4LPcEUvq2VIvihiSJm8hxpz0kif29yhCums2rjyPehUMM5RhB43MK/tlY5WlXdYq5yaOeZtza5elSb0fC44Upwz3ipCDA5otYDovVzFdgayUVavorZh8OWlLvTlskxLxCaAz4KRbppZzf+qMdOzyvViaKOXxuzmu1NIm+B+KF36WYbjlewpNPdD7Z4dWgdJdEg2hXyKFvOpwWVLuNXENKBgJ4OslAnsfeC+TOvY/T2GEDNC/fFQqEU5dF3adjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f+z6ql9M5JhawzkmfcJJBxApS2D5ls0dv54BOWw8ja8=;
 b=LXsVM1Bn4+H8GAy5cBf2M6DvYEkdEhKjBw2MOd4V8WZMVHo/k63uCLwYI5Jq79yJCfGI0Oe/NjFBoAkaeomxlGEZR3+q00lZxu3bp33/ei9GPzyAeNWKlfkeikM0P3dJcqZ3HLogXqnlXbc+qEM9IVVwJyFyoW10KBQB3xlmi3c=
Received: from LV8PR04MB8984.namprd04.prod.outlook.com (2603:10b6:408:18b::13)
 by MN2PR04MB6431.namprd04.prod.outlook.com (2603:10b6:208:1ae::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.12; Thu, 4 Dec
 2025 12:28:09 +0000
Received: from LV8PR04MB8984.namprd04.prod.outlook.com
 ([fe80::9ba6:7273:90bc:53a8]) by LV8PR04MB8984.namprd04.prod.outlook.com
 ([fe80::9ba6:7273:90bc:53a8%5]) with mapi id 15.20.9388.003; Thu, 4 Dec 2025
 12:28:09 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: Damien Le Moal <dlemoal@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH] block: Clear BLK_ZONE_WPLUG_PLUGGED when aborting plugged
 BIOs
Thread-Topic: [PATCH] block: Clear BLK_ZONE_WPLUG_PLUGGED when aborting
 plugged BIOs
Thread-Index: AQHcZQ28AdLwR2bhUEij59qeHCddkbURaMkA
Date: Thu, 4 Dec 2025 12:28:09 +0000
Message-ID: <c3332470-1ad4-4ad3-8d21-7a7c556c69d0@wdc.com>
References: <20251204105952.178201-1-dlemoal@kernel.org>
In-Reply-To: <20251204105952.178201-1-dlemoal@kernel.org>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV8PR04MB8984:EE_|MN2PR04MB6431:EE_
x-ms-office365-filtering-correlation-id: e7f9ff66-6857-49f8-49e6-08de3330957d
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|366016|19092799006|10070799003|1800799024|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?RHVJUEpUODBsK2pPeDlzVm45Q2owcE5xRmRWZGhmR0hhbUJZaW1PbTFMTGdx?=
 =?utf-8?B?Yk5EVlFWRFk4TGNwZUxOQXBLY2g2SE9meGVQQjJRS3ZVMVlKRXZjSHdiN0Jo?=
 =?utf-8?B?bU5tSWNRM0ZvK1BmSEtaSVhkaVUzRURlRUwwRXk4Y1BBRGMyYzJwTSs4UUp3?=
 =?utf-8?B?S3ZPOEVneHFzbVBKcUlzNFk3NURQYUx0K3lDb3MvTUF2blk5NjRXYVQzaXNL?=
 =?utf-8?B?UU9sK3dvbUJMaXlOWXc3cGQydU9sbndvMG13MWJ3MVNTWjI4QkFWTjd2YURt?=
 =?utf-8?B?Mjh1aSsyU1loUk04MjYxQ0hyKzdkVXVyeDFLNzdWdkoxMzUvY2wyNThJdlVJ?=
 =?utf-8?B?RjVVL01GbVhWeG1WbnhkUkZvRG1VWFJCanJrVTFJVGUwWDNzdFdIMEdwNFQ4?=
 =?utf-8?B?QTZWa21pbWlRR1VELzBsREpsTEZFNFhFOHE1ZnZNUGdpaktua2MwZDNoTjUy?=
 =?utf-8?B?VDRRWDg2K0FEbnJySWVkUHd4UVpyajFDUGE3dmM4c2tCQUxvMEhFQ2tqZVlv?=
 =?utf-8?B?UGZMTHJEOUlicS9tb1Zobnh0SWQ3T0w3UGZlRHY4TjVkMkpUNTBkY3hWV0hD?=
 =?utf-8?B?OWpiOVlwVEJlTzdUVlVLWHZMYXJ1c3ZtNlgwSW5DMlEyajc5bXc3VDBhS2Uy?=
 =?utf-8?B?WjZGbm5wUE9hUVVFQWk4TjdNWlZncXV6QlZsL3BSb21sdTVHdm1OSnA5bDJh?=
 =?utf-8?B?bTI1Ti9telhlM0JoN1psMGE3azY3cGt5c2ZKbk5ZeUErYlhSWHphbkl3M1dw?=
 =?utf-8?B?WDczL0JRRWVscTZNSExRUEFTSGtSY2ZoU2NySHlKUVJieGVmZHN2Ykwvcnpt?=
 =?utf-8?B?TWdKT3piZHJFZ0xpcEF2ZFpkMGI0OS9UaWpvanl2M0tiYnNRMVpNQjU5MXBz?=
 =?utf-8?B?ZlNqVDRrQ05vWTg0Y1oyV01JcDdRZ0xJZVI3QlVJdVk5eVpZMkZoenB2bTVw?=
 =?utf-8?B?ZU16WWo5UFhranBSYW5xVVhVbGNXRGdTLzc2Z2pBTUhCQ05rRkpPTGZCSXV0?=
 =?utf-8?B?MFpDNzFlbUhOeE13TmZTQ2pueUNtdzQ0VVNVRE1XV2dVbEZpTlBhc3JYa0xB?=
 =?utf-8?B?bS81ZGhmK3V4citnWnMzM2pLZGhiUTh3aEpidkFLWnpzTkpyb3FmNGllREpM?=
 =?utf-8?B?bHk2LzdEYnlBR0h2ZnBqLzhBUlV6enVFR044N3phZVZLbi9kMlpaVEhlRG81?=
 =?utf-8?B?elRqOGZWZC9oVHdCZkEva0JDTWwxU3FaUW54cWMzOTZSSWtEZkJlbWY1ZVpt?=
 =?utf-8?B?WHN4MHBsaGdVQUpJbUxZK1htWFV0L2ZhbFV6SjNZWnYxVzdHTTNTV2FkNFEx?=
 =?utf-8?B?Nlg4dzYvN2lUSUdLODF6MVZHUklWbkJDVyt4THFtZVVpZEg0OGNNVWVaOTVh?=
 =?utf-8?B?ay9nckpaYmpaT3E1MVFMVWpvN0dYVHVrb1A1Tm1kYllzeDRSTitFRXdyZFVj?=
 =?utf-8?B?Y2Rzc2ZKb05IclA4S0dlcmtoZFdCRXBNaFR5MkkrY2hxcHV0ajJwaXZiOU5a?=
 =?utf-8?B?Y1BGb1Qvck4xdUNLczhmOVF3YnBzd3RKblJSK3JXOXNEUHlLVng2cGFDbzEy?=
 =?utf-8?B?cEJ6UFh1YzBmaHpUSWhJaHlocjYveXhQeDI4dTgweGQ5aE9BWDdmMHZRWWVJ?=
 =?utf-8?B?eWtmZlYxUndEeG8wS3ZZWGl5K2dveG43ZGE5YzdHV05jaGdsUVRReUtSeWJU?=
 =?utf-8?B?K3haa1dmMWx2Y1VkZWFaa2dXY2NtbUZidlZGdnJXWHFEK0g3aTE5aEVJMmtN?=
 =?utf-8?B?NWZ6S01yMStXUVZxNEhKaTRMWFlDYi9Fb1BObjYxd3BKTmtHYXl0WmZFMHhF?=
 =?utf-8?B?dVJuMlFlQTB1VEZoTG43aHNRU0NGVjA3bWZXRUVYQXpzYVhkWGE2UWxmYXB6?=
 =?utf-8?B?cFhxVTVhTWxDSUpJR2NXQlk5dzduSVJUZ3MxMUowc3dXVm42cWhlL09lVlFi?=
 =?utf-8?B?YnRhRWhmMzNsTGZIRXRXVmlkbm83eWNsTmd3aGpCWjAvVGEyQk5DTmw3Y1Rj?=
 =?utf-8?B?WkpQWGxZKzZKMi9mMWtQOGdneDhab01BTjJOclhna0JxNmVOZFJiMU1sTlhW?=
 =?utf-8?Q?MqF+RK?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR04MB8984.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(19092799006)(10070799003)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Y29OQU5rQjVaZHpkaXFzSGt6aGdESlB4UGFTbzdjdDJsblowNzkzZFRZMUFa?=
 =?utf-8?B?aGF2RlRnYU4xbWI4dHpmRUlwem8zSC9PWlFueHd1ak9PVkpSSGJpemVUUk1m?=
 =?utf-8?B?b0ttQ1hZNW1MTWVqYUVkVEtyNkdGSXRvWTFodHo2MW5WTmRVTTJYN0VvaExa?=
 =?utf-8?B?anp2R0o5VVNRQmdVckc2d2lrc2VFNXpmbGhUZU5LMndxYWtVZlJCRzFlblov?=
 =?utf-8?B?Z21PZHZLSUErbUhnYnlrOGlnYVhiTkJmUGdvQ2UxRWt3QzdEQnRaZGZBMXl2?=
 =?utf-8?B?aWNTNEd3UTAzU1I3b245M1N2YmR6OWhrYzJiMTl0Yk56Z2NFYmRKbGZVcEQv?=
 =?utf-8?B?S2xzeG9pa1NMbERSdHdhWW1QbVMwdGl0UGdJeWFzTStZUlVERStsdEtzdGV6?=
 =?utf-8?B?bzVtZUZLejZmVlNVTFF1V2FYSWZQYW5jYlVPaTJNS1ZFaE9GSU0xZFVPQUxP?=
 =?utf-8?B?NWh2d3RlbmVpekJiZnZySTJLWmRpR0lvU24xczNmTzhMWEJodFErNTU0YjA4?=
 =?utf-8?B?T2E0clJxVGc5cTFDbnhkTjdhbWs3OHZ3SEV4ei9DYklhUFNGbzJhakpOTlZQ?=
 =?utf-8?B?Si9jZkNKMlY4Q3N3SkhITlRSMWc1ckZrN2xjRlpFYnhaUmFwUXdqdStaS3RY?=
 =?utf-8?B?R051S25MWlNrZjJCR1RoZmRJTHdDeFBqRmYvVC8vMjN1SG1Gd3ZwMUljcVFB?=
 =?utf-8?B?NzNKNjIvTytUYm95TG9kUzB0TEtRMGhHOUNoUCsvUytHWVdSUkhUM0hIVS9o?=
 =?utf-8?B?ZFRqdWwwVkhYT3lXWkNuUUF3Mlg2TVo5N21rNVZSM1ZmcmVkYUMwbnlaR0FW?=
 =?utf-8?B?RjQrQzMvVEE4M3FIYVQ3WmJSb3hwMkptTk5zcjE1RzNrOXFOanNXUHg1VjNw?=
 =?utf-8?B?SEZ3a0t0M3l0K0Y1SDFmMmZGSzEwV0J2eGY3MWxUZnVyNlY5SWszNjAzVERy?=
 =?utf-8?B?YURwbitTVXYwRUhlNzE4eHBJaThKd240T0xaS1JFbmVvYzQxRnA5bm15S0NR?=
 =?utf-8?B?M3dLUXBmQnh5RUtJSjY1dm8yOVBSZ1hxTXlYa3JaYXVJblExT2JIS00zeS9t?=
 =?utf-8?B?ZjBkb1N6dEtpWlhRaUlkNkcyWkhZUTRvbW5wdU9FWnQ2dG90VlN5Z3N5Z1RJ?=
 =?utf-8?B?WGpyS01JcUZEZ053ejFlSGNQMUswSUs0eWpuL09TYkJ5TlhxVWtnUVNmT1Vo?=
 =?utf-8?B?alBKVWpsWG1sNGpXejdtOWZ3ZUpsdXIrRnBzdGVYUm4vRCs1ZFdodVNZd3BU?=
 =?utf-8?B?R3hSZ3FrVTI3cUJkVXBwclZqdG54SlY4MExpZ2QxZXBhTDZMc0dCaVJGV1FW?=
 =?utf-8?B?aUtNWGJ6UlVXbjlNSjVPUjh4L1hkRURHS2xoWDdRQkd2dmR3S3JjTUdkVnlS?=
 =?utf-8?B?a3QybUg4azNNWDdDNWFXYTM1a3I0L2I0SmZvRmlZcEhwR0lqbm5mdGY2cHJI?=
 =?utf-8?B?cmZXYWR4REJQNXQ2UFVwa0IxU1ZjVW5mWXRqWUV0cjhGOVppMXdRQlZONXJI?=
 =?utf-8?B?NUhiZ0Q0QWtMUHNaV09kYzk0eUxIWjhSamxwdVc1SEZzNXU2Q0ZCNmlVc2Mx?=
 =?utf-8?B?RGh4OENBUmUvd1hUalNBY0kyZzBpK25ZQnkwM014OTNZMUpzVnRRODZtYUFP?=
 =?utf-8?B?TUZINUFZejREVWM3bkxHY2hEOEJoU3pUbVVLR05ORG9EdWEwNXA0NVBNQm5y?=
 =?utf-8?B?YnJ1QzlwWWxZbDNwZnRhbFhlMDlnY0FmazliTnhBUG4vS1RFODgrZFJCaG42?=
 =?utf-8?B?TDlwbFRSWFNtKzkvTUp6Q1B0VEFsQVYzQ3ZiSDlVWFhPaG1CTUJQZGkzWVB3?=
 =?utf-8?B?dURtTjc3ajlTQkNzbnhmU2ZYTjRxaVlxNUxiYkZBRWFyWG0rTmRLWjFMeWti?=
 =?utf-8?B?MzlhTnZqa2FxOHFJZTVvemlhMElFelNHaEk1U1hlZWhvQnFmNk5RUXR4Ykxz?=
 =?utf-8?B?aW1xQk5WYzA5THQ0anJUMk10QmlmY2ltcWpRYTcyZzlmQ2ExWkNPL2UwSEpz?=
 =?utf-8?B?TCt3WGhSZmxHUllYWnpMQ05kZTl5VzhEM1o5TEJjYUpUNFpHZVorNlpqVW9Q?=
 =?utf-8?B?SUJDdS9YT0JjVlNXSU1uUzhnYk1URmttWDY0Qmh3WW5CLzdtNVhHbUNUM1d1?=
 =?utf-8?B?SzN5YmRVQmN4WUZHQ3RtMnZaeGJXSllOcCt5d3VxNzBEY0xFS05DTHdVRndv?=
 =?utf-8?B?aStZZDA0b2xBMkJWNHhadWJVc3BzcTB6TS8rbnRFT1JRYmlTOStLWjd4S0Uw?=
 =?utf-8?B?NmRObzBYZjl0RTJxYlhNYmZTMjJnPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <553D044751564C4F8299B7B5C86588B1@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	VAw0Lh51sg1GAWChmuaLo2dlret9t7TMSfZB/b+a3A2p220Z2n5Zf+4cTS2ZCwGaOz4BHIjVvYRJ9SRBeaJWOW+63BluG5Bg7D7EedqiKgMSIEtQTuxCJN6ro3xlZaJxAGphlRTX13YhwGZobF/pnIb7UsyB9j30f1Y3PgYOLCfvXmiKmQVyMbstZhrLGcx1ID6v0gc8tELqwvsi6MG7J17sHKVDf7pNUKy1hO+31o0zJWENa5fAlOOyp7hIbJWcx0J6xJQCyVbVSP8uo4h9jspCpys2YviM8CZkITFbdXL81EBgle2+0KZnmFP/1+yDW5kLqM5+Nr26qlilHr5R3V48tTuHCwoABNRGkU1GDSomhRGovUdBez2D9LlEmmFP76fA6X0XGj+in2KFNjm/1ZDJl9VEOgeza9gu3LyLhKG9j7AoCLmyaoRX70AxQpl6DqC4C+pQ1iU2UrbMXYVeNRfzQK7LB8gOAS9MyN/oRzcUvYjzAaoX+FaMpfPMxy5Z5Z4ayQ2SUe2hv3H878ctDSFQoNmkgqUqXBOL/raor8MFWyZfMtBEAcEOc+GBtqSAyoSI4mft1wC9945sLr89ShVQdTB0bsrXPOJwfCnjv/rOwKNH2v8eFg45+o4bw3ev
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV8PR04MB8984.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e7f9ff66-6857-49f8-49e6-08de3330957d
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Dec 2025 12:28:09.2431
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xCiqdDawehXfRm4Nq9+WU6t/B2oaXhQlxy3CVPgrNKkKnFlOtE7+A81ylWx+KFmS+3y42IVqp5OvN2yKXk3HaNXh4FTppToV3oR27V2MnJk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR04MB6431

TG9va3MgZ29vZCwNCg0KUmV2aWV3ZWQtYnk6IEpvaGFubmVzIFRodW1zaGlybiA8am9oYW5uZXMu
dGh1bXNoaXJuQHdkYy5jb20+DQoNCg==
