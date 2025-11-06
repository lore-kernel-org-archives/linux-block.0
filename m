Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DBC32BCF4C
	for <linux-block@vger.kernel.org>; Thu,  6 Nov 2025 10:52:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.154.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762426346; cv=fail; b=Ctt8AsGb0AoUxdMzNYWonBdKsqaTgHG4ubFHDTFoMsSGBJJQldXszNYTYKbRlzw3ojg94a9e8NXbFr2k+bmO3psMxcsUyJb16F0aXOSvp5f+qDE/Kwf9O1HWX3bjWmW1SCw7Ul5kX09UcZs+3ya26oc/dyGZblaJZVf3ZOWyhVI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762426346; c=relaxed/simple;
	bh=f+z6ql9M5JhawzkmfcJJBxApS2D5ls0dv54BOWw8ja8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Rr8mHZ5osN+GKUoSOOZL3f2wA6N1H6cbZhiZRg8s4INaIeT5yOcnUtBITAO90y++yDHsapmdTMQibi9B+lZetbYLqH5okgxq0hOr0ZVU9KXICWyK31MnoVdhcHj5xH/rsemxHAkz5BD2g20Xp2oa/zunX9VOakdjmFvYkBIhxuY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=iV/GMOLH; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=I9IJPq+v; arc=fail smtp.client-ip=216.71.154.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="iV/GMOLH";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="I9IJPq+v"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1762426344; x=1793962344;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=f+z6ql9M5JhawzkmfcJJBxApS2D5ls0dv54BOWw8ja8=;
  b=iV/GMOLHugC/EgGV49es0ruWjBLV0VYhgFTW3ovsC+oaoK6BM0wAEn6U
   u2iqes317STX2xY4MfpeqdRukDp1bECz0LUuUd22bgvLkbJvlihLOqIbj
   t3XXaumJ0QuAtRT9xMnw5/ZbDjl3uU6fXJPrBxLwMsBysw0pBu0J89Y+L
   o8F89HLZ0zX6r2VGJb+z5vG0QaT9DR/M/rY7HCh+p7DDG2fO9FTTTZy5b
   3m5odn4gOG8nQnZVSKmFATcml8I0mf1yEqTM2kbnc2JvN6Qr0NJNpm95P
   2nM7xkV/nb2WJXduOXX6Z61CzfmrKINpj5IsdbsidBGfUab6iV+Ty+HKc
   g==;
X-CSE-ConnectionGUID: kLHSFzhFSdeEwfCH81Cs3w==
X-CSE-MsgGUID: Q+KQkwq8SQGV3tiMAUE2yw==
X-IronPort-AV: E=Sophos;i="6.19,284,1754928000"; 
   d="scan'208";a="131597855"
Received: from mail-westus2azon11010031.outbound.protection.outlook.com (HELO CO1PR03CU002.outbound.protection.outlook.com) ([52.101.46.31])
  by ob1.hgst.iphmx.com with ESMTP; 06 Nov 2025 18:52:16 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cAlUC+OmCasKDiIR/yccKPFNZGQ9z3vQ5em6XXXZkwKMdQ/A/nPS7P+17ujFTiNT1V8aCvqu0XdUY7GrJh6T3QYqA85jdwqioHCMm73ifQSkiCzKpNMGCCJtcPPTXy6Njt8TVAHO/Jm3ovH4KHQxhAgnNwgl8QVprYi86kz4+ryAtT84L1LyLwrlaILTuwqQ4ZWOJvjdYZ/4ko0YJBjFlDZjNnPf8V/is5rsQ8muSgRLif5hJvMK7bwySC0vEGVI3lbPTnfRAEpXIUUCaXYTk7lHlInuTChHF3s03vOxs3cxdHMld4OIw+TyjbECwjnGtQGFpedSJBQ1q7DqdvlJ2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f+z6ql9M5JhawzkmfcJJBxApS2D5ls0dv54BOWw8ja8=;
 b=R7wCCbvpRT+yBhDdv3mW86l8lTEm+YDdDC3dpv5OBzXvT+j928kMejyJSYxUDTQA59LdTHzWFwMCvi/cqt4eEWEpYGMqq9cADuz494AVV8k2E5XRVS4fUUjO5KrZweJ3wkjoXyG5B7fL9K78TlOy+3J0BnrBh9HYtEVHgiyGkntjg8pfuOohRvOEUF6SCzcyDSvBCT3J0GGXWB9U0ywVEi4T5QK8GW3lcvgmEvppTJOB2wH+pGME3sgID7X4AceUsYqqbjBcjZXnZhXedF5S12u8rM65Rf0urxLbTkl32YQgXc9FMylt6IyoOUYIsaZkw7YhQtaemi7y19mXC0xGbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f+z6ql9M5JhawzkmfcJJBxApS2D5ls0dv54BOWw8ja8=;
 b=I9IJPq+v43pTkO3k8LIJaOmCjkXQRYxsmnGbcoU36MstUsEkCzVvjqGyA4Dcq8WktVdzQ23Vun8QCm5BzsEoMY49dfZ+aWWJjVUiVefajqS3+ZX/K6XgLErNFIKx88VGqYRte1fIG+OhJHlZeyLbz0R6STW6Z8AfmxSThtuEdM0=
Received: from SA0PR04MB7418.namprd04.prod.outlook.com (2603:10b6:806:e7::18)
 by SA1PR04MB8519.namprd04.prod.outlook.com (2603:10b6:806:330::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.12; Thu, 6 Nov
 2025 10:52:14 +0000
Received: from SA0PR04MB7418.namprd04.prod.outlook.com
 ([fe80::17f4:5aba:f655:afe9]) by SA0PR04MB7418.namprd04.prod.outlook.com
 ([fe80::17f4:5aba:f655:afe9%3]) with mapi id 15.20.9298.010; Thu, 6 Nov 2025
 10:52:14 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: Keith Busch <kbusch@meta.com>, "linux-block@vger.kernel.org"
	<linux-block@vger.kernel.org>, hch <hch@lst.de>, "axboe@kernel.dk"
	<axboe@kernel.dk>, "dlemoal@kernel.org" <dlemoal@kernel.org>, Hans Holmberg
	<Hans.Holmberg@wdc.com>
CC: Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCHv2 2/4] null_blk: consistently use blk_status_t
Thread-Topic: [PATCHv2 2/4] null_blk: consistently use blk_status_t
Thread-Index: AQHcTsBqfyeyFCq+p0+P1eZ1TBLGQ7TleVCA
Date: Thu, 6 Nov 2025 10:52:14 +0000
Message-ID: <dbf80bbf-a5d3-4f4e-83db-7a5df6bec223@wdc.com>
References: <20251106015447.1372926-1-kbusch@meta.com>
 <20251106015447.1372926-3-kbusch@meta.com>
In-Reply-To: <20251106015447.1372926-3-kbusch@meta.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA0PR04MB7418:EE_|SA1PR04MB8519:EE_
x-ms-office365-filtering-correlation-id: c3195591-b671-4e77-d829-08de1d228b9c
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|19092799006|366016|376014|1800799024|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?bW9EVndxT0Z0Si9KQjJEem1ldjN0Q0UyZmVHSTgwMllhYml1OEVTbzZzVG5m?=
 =?utf-8?B?bTFYRjY5NlVUMlVJUDVDVHBsNzlZSHA3aTVENTdJekFFa045aHBuVzVGdHl2?=
 =?utf-8?B?VHN1ekR5NlowN3l4d29td1ZQMlo3SzY1d1NUUWlmYjhMbll1cksrTjNUS05v?=
 =?utf-8?B?aHhSTkZTd0huRWp6QS9OSjdvTjhDZTViMlFRZHBUQlZFR3FTT0x6dURjWDdj?=
 =?utf-8?B?Q3RSQ0lwZDc4YWMwSTNmUVlSbW9BdDQxRk9BbmtzZnRVeDRuRnZhNDZhRVlU?=
 =?utf-8?B?Rk51cWdUZ1AzOWxJYjJtRXdjTmtHN3A5V3dRZUZYbXhoS2RORWdrN1lpUVdF?=
 =?utf-8?B?R0Y0eUs0Tk96SGtaaTNXOXJOUnBjMmpkQTZtQ2c1TmJ6bGlvSjdRVS9ndjda?=
 =?utf-8?B?Mk9nQlJ4THhLS3VXZzRQOEwrWGhFeU1TSDFWRWVoR0gveitZdTN6d1hBY3Zp?=
 =?utf-8?B?TzZxRXJkTHVtRzNnRXVMWnZiRlJJQ2xlRDhYUDNaLzBIU0pNQUFKdXZEZkdE?=
 =?utf-8?B?dGl1aDIvZWZKTkpIeGxWZVkvWjg0TGpoeFk4TWZoZ3dkd09CYmZIUE5mQmpv?=
 =?utf-8?B?d2w3ek1VUk1LeEtYVXBSY0RzdkJWZlhETVRLZ1dtcmdpeUNwMU1SV0NOTDBF?=
 =?utf-8?B?b0UzUUd2N3pKL1d6MFVqRlFXM2N0Ymt4QXc2WldzbWpyanZiTEdjSzNhVThT?=
 =?utf-8?B?VWpvdmUxTXZ4Q2dlV1o5TWYwTVZvOXhCUmZJbEZsTEMzUUx0bXdCaEhsSUlM?=
 =?utf-8?B?WVhpdi9CRVYwMVpHbGtMZVpiWDBsc3VjdG01Z2VXNnRxTDJ6bG96VjNtQkNq?=
 =?utf-8?B?RnJ3TGZXQmp5dFMvOFRaZ1F5NlAxUnNwdWwwalc4ZG1RQnRKOTdJU0JWT0Yr?=
 =?utf-8?B?LzlzT2ZtMk1HeUpKRUJFZDhZZGRCbVRtRDZ0R2RmdEtHeWtNazRETDNXc1RU?=
 =?utf-8?B?RWhFZWVxd2krakdFRUNHenFyVDdZaTVScExES1VjeEdKeERseW9HQlRSaVdE?=
 =?utf-8?B?aVAreGRMblZzNkR2N0tGRGQ5ZG8yaTZmSEsrRnlLNGVRZndIRlJCRGVPa25j?=
 =?utf-8?B?MlpnTng1eHJLc0ovWU1mdlZWS0c5TzE2T1NKdVNqbkRaOVMvS0JVNGtNRUZV?=
 =?utf-8?B?bDdFVUxvUzlsNE9aM3J0NERDd0Y2Zys0ZVdHTnZkZVNMdTZ3SUFOeGlNckZj?=
 =?utf-8?B?REdDQ0pSK3ViY21nTk80RkpFWFJCcTh5endJdWp0MEdiWnZOb1ladTZTbHN3?=
 =?utf-8?B?akhzN3hQR2haTWluN2F4ZWFHWkFMNDdwZFpuNWJWMDRjWFRyaHNKazFNNG5v?=
 =?utf-8?B?RS80VGdRNENKajVZRWEvaUp6aXlSVTkvaHZhSkRrdFZ3OHZ4UWxCaFVSVk9m?=
 =?utf-8?B?YUpVbGd1L2hpREVQdFJnVWU2Wmh4M3kyaERCOW9wcm1KQXBnbllmNlFzSkhm?=
 =?utf-8?B?Tzd5SUhYMXdKWmIxMEFjSm5WRUFmSjRyUUEybkdJU0pqbnB2dFF1SjkvM3BR?=
 =?utf-8?B?K0M1dXpaRnRrWTMreXh6T1RMN1VEL2Facjl0TTRadjY4d0xITW5wNGlRR0lS?=
 =?utf-8?B?L3lhcDhmVUpLb2t1aUZqcDZudnE0eFBXRlEwZEYrVGd1UjdjemVXcDRoZjJy?=
 =?utf-8?B?YnpjQlEzTDZvY3ZuV1haUGxvaEJwVFBZSytUTysxV1U5LzFTaFZHVDdBNHFO?=
 =?utf-8?B?MktNOGhxNzdyYWpad0tIY2NaQllrYlkyYWtZMlVOSjdpd01WRTJMVC9WRE5W?=
 =?utf-8?B?WUNWMjNHOWlSRXFLTTZoNEtUSDVYdGMwUWhRaXpDaThpY1hMMm02cWtoQXdM?=
 =?utf-8?B?M0RFVE82Q2RYak1kVGdMdEtpUW42MnkvbjNQekh4U013bC95ZWRPbTE3ME5B?=
 =?utf-8?B?VHl1LzgxQm9hdThSY3dIRWxlMDhmOFRBaTY4ZFpWVkpHRytuelM0TG1VWkVW?=
 =?utf-8?B?RmRlR0c3ZXpORDRvL01RUG1JTGhuci9UN3p0M242K3lKSjhKSWlkUVZWS3Zn?=
 =?utf-8?B?SmpKSVB2R3NuRFRrSkRJTHFTdnJJZmx1V3pTMGcwNGNhcXFpcklNQnEya0NO?=
 =?utf-8?Q?TZPfRl?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA0PR04MB7418.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(366016)(376014)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?R2Y5N3ZiUkxVQ2ZjR1NXeVk0dzUzRGZzZVlHcUtRZTNZTGlBMGc2TVVOWjI5?=
 =?utf-8?B?cTcrTU1nMVZzdFJLSW0vTWREU0VKN3dVWllTazd3Z0NYRzlMbnAyY012TVRt?=
 =?utf-8?B?bEhBN0RrWEFWdzdxc3FxczFkdS9wVlBWa0dZYVpuUVlpWlp4elJlWWVrVXBp?=
 =?utf-8?B?M0JjOXVFY2Y0NHp4M1hURldBVmdpeml2UjUzQldtZExaVmNiOXQzR3JtY0Vl?=
 =?utf-8?B?bW9LU3VZWkV3WEgyamI3dEtCMW9LcjZLemcrbnRtays2TzNmUXl2RDdCb1dx?=
 =?utf-8?B?d3ZsRXkwUHVOR1dacHJYdzdKaGwwN2xKUmJKZHVEVFZ6MWRSVy9PcFZmQXV3?=
 =?utf-8?B?N3BrdVM3SlA1RU1hb05YNlJVcUx0SWVRN2pKMm14MU9nZWVUZzJueFM0L1Ni?=
 =?utf-8?B?V1hyRG9hMDVJV2QvVG1PZW16aVdIYTh5Tk9kbjdkVHVEaWNyQmtlMzljam9n?=
 =?utf-8?B?amlkaEpsWmVnVzFOYVZSbG43NnhKZ0ZMVno4Tjc1SGRvMkk0ZnFrb0MvbkhG?=
 =?utf-8?B?T2JzM2E1aXNZam83UUVRejBEazBGNnhDaXY2UHdkaFhWSUFtTHFkeFNtZWtQ?=
 =?utf-8?B?cjhMVW80UFFlNExCT1Y3TG0ybHEvNUh6RTRWRCtWWTVzTDBCUmhlNUhRSkx6?=
 =?utf-8?B?U28vNUlpYkU3ejZHak9nYmRYTE5lYVlFYjZQajZJR2paWnRRSlF3Mk9qR1Nu?=
 =?utf-8?B?SVQxdXI0aEJmZ0ZoLzNuQmNiR0VPblVHMzhCcHUzVWw0SnFTOVhSWXVqZDd0?=
 =?utf-8?B?eEd4Q3diUU1KTW9hKzA5VWVhWGpJV2kwT3FUMzNWSlY0a1JWL3BoTkxOcmh3?=
 =?utf-8?B?Zlc1TXFFV2lVUEp1MEN0b3p5K2FBa1ZYZ0VydDV3dEMvbDE3UHFWK08yZ1hh?=
 =?utf-8?B?Vmg0cE5DSnVlMjVZTzBpU0kwNWVXV2I2bnU3UVExNkpicFEwdmVkWC9DamhN?=
 =?utf-8?B?aWovRjljWFNmNGU3eCs1aHV0LytZY1dxRXd4K1kxQzgwb3JHRm5jeFk3M2lR?=
 =?utf-8?B?cnZvWFVVTFl6dHc2RjltQUgyRDFTUDdYQ0dOY2Z4ZU5Wd294VTNaS1Z0cXVx?=
 =?utf-8?B?VGQvMi9LdnNsc243YXNLVVFvQXBnM21IU1p1ZDdjYUtIYkFxNUIwSm5qUUhx?=
 =?utf-8?B?NWFaUXJhSlRwanNMOFNkWDV5cTZOTnJyOGxiMmh4UWg3OGNhclc1eGpWQlFO?=
 =?utf-8?B?QUF2WmpsMFFNM1NaRnAwU3pBclVmRW5kem1hbXBzS29XODVZUTNQZGJHM1pw?=
 =?utf-8?B?Z01hdDgyeW1uWmY1MzRJc21JL0U1bjQvV3RQSGcvYlp6WU1CSTlRMWg5SC9a?=
 =?utf-8?B?NmZEZEVVdUpGYldpU0tsWldpQmZxbWdyRVJOdXJmV05YcE00MkZNQVJFYVhO?=
 =?utf-8?B?YWo5ajh3ekpzL01lMllqZ2l0RTJGYzlOU0xzYnk1cnVyS1RMZ0RxdFdsdzhq?=
 =?utf-8?B?SDcyRlo0dER1aFc1QXRXTDlXLzk0TXpaMGVlNlpocUhaZFhrS1pGeTBtRUZl?=
 =?utf-8?B?aytmVlI5dTRLZ3UxY05PYXRZcmRmVjBhNm9zRFlTTktpaUhhZ2NpZlI4K1JT?=
 =?utf-8?B?dGQ0c2FaNE16UUFucmpFTDVrMjREYjFKZ0NKcnF1djgrMkRXbWx2VXBTSWVW?=
 =?utf-8?B?NEdjNUZnNFVnSjg2ekVwcUREQktzRDNpdXBQZGhCMFB4OENOOFE3SlBlTW9j?=
 =?utf-8?B?U2JYMmNQNXdHek90K1A1eE1JL2JZRXFseHVqQlgzb1BtZzIyMi9USC9pTGw4?=
 =?utf-8?B?eC9WRThNaFJrRDU1ZzRyTTBEN2tUZGdZczA1VCtYSXZNb1hyOUJPK2hTRFFC?=
 =?utf-8?B?OXhJQmRYL29VbE9WQzF4UGE4NkRHaU50OWYxM1FoL3dNYmdDV3lGYlRNY1hz?=
 =?utf-8?B?SHQydHVYUzJyNnFCaHQydVdhNFRtaGs1U3ZFblFsekowOENTQk8zTS9NdDFM?=
 =?utf-8?B?c09KdzhCUTNuTzBHNFhoN2RFRlBaTFFMM0Q0clZucGdibjVKYzg5dUR3RUdO?=
 =?utf-8?B?Mmc3ZmJMSFRnVCtvcVV0RERQM0RIN1MzeHZRSEhtMHdFQkFqaUxPclJBSjV4?=
 =?utf-8?B?QzBUaVE5UFJ2K2pVYnpQUWY1M3grS0ZaOXVyY2ZHTzh1TmJ0U2N5N2c0Qkp4?=
 =?utf-8?B?NkZ5ckx3c2paWGQwcVVsNU03a0gwM0RPMFFZVHE2N0ZxWHk5WUJxTDgwWGdu?=
 =?utf-8?B?MWc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <4A29D7940193CB48A66DE12EA9439F86@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	3QMlWU/rUnf4d1ssefZZ/+EpO4gs4+eiQ92YTSHeoAQt5FORbbuTaxkzPkA9YqZkqy6HMb1WDo486mYZ8LGqTNOg1T62kspkYCA0EM722/c0/WxSc8phgQ/NT17iatWCHMlzr3NQ7zFCKkCgHvRQpDBzGXpk3eymXspMKoDvd0YLtKOJf3T+ATTUphIlmyFz5VUOonhQVeTsM3/n4FTDN2lZHyKlDtf1x+qD/w0flzk8P57qt99H5aI870NmNVAxZstVZ+bvWBoDO8k63OwXp4SC3s+RpPc0ANWc9UghQwTWmsVLASwzShvTB/3KmSKXVEyrE6U09TreFEgyYpmshHPF9UmaCyYsdvJc6CLIAP9raciqAkeqpULsnlfDB5pyl2XhrVikOMJenBCBuEKFyQvejoLjjxJVJmYMcpoQh4wDSsss4I58lOQ58dyb0ji1zflHsx0zjp0UqnWD9lP7YKmVuCBX+/fIYtwSswDrooBEX1qS0Jon7R56c6dKsVKeTFeGfcbU7Nm/XNrzGdvleKzn8GZzQEzooKaLrVNTWnB6EpR+et3N7SChNj0XVDXbsuXBwenkwCK4e+TXjzEVmzYKL7vFdhFF4ON3V0bVcokJS7dRtatrVdAXx+JLNm8E
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA0PR04MB7418.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c3195591-b671-4e77-d829-08de1d228b9c
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Nov 2025 10:52:14.1184
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LJhkf1ciM20e0jSLe2Vvbex+8a8m65Z62Q/4WaEjIhCN8T2RNBrA2pp+aq7CVRI9jRR88lYnL71yB0A9Lmssk0rOfZuIy+KWb//mSbkOp5A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR04MB8519

TG9va3MgZ29vZCwNCg0KUmV2aWV3ZWQtYnk6IEpvaGFubmVzIFRodW1zaGlybiA8am9oYW5uZXMu
dGh1bXNoaXJuQHdkYy5jb20+DQoNCg==
