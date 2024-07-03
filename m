Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A52AC8C0
	for <linux-block@vger.kernel.org>; Wed,  3 Jul 2024 09:29:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.153.141
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719998968; cv=fail; b=csmYRH8pJJwX8es78RF29PCiIx5UXteLtJRbsPvQjajomfNnCai8xEQMhBw7OZjrnjv06OYSqg+WhkbZfGKtJMbLN8i+C1wCmOXU0VlMWIhXCD8OUGY9xI3sYrU9qWXQy2jcgItIsedCiYib3fi+6t1t6hsEgXQPLps65pjbTZY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719998968; c=relaxed/simple;
	bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=cL2V+rkouppHhhNu/WW0Pe+V1Holxc58UnwxJVFyQ+UdFIwh3eSht/VWlAlqIbf71yoMzX5URpqBWu+fWlAIrlCFOQ+oSSCZofe8wDEyZaZuKvrATcX1jkKMaKbY5+eFpggjQyKmS+MCVjqMdP4ZXcFu/MLdF4zpNR/x1jv7ZCE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=m5vBT541; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=yavtvw0V; arc=fail smtp.client-ip=216.71.153.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="m5vBT541";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="yavtvw0V"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1719998967; x=1751534967;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
  b=m5vBT541kN+vC/fY9q42hlQMSh+hGmc3fyO/XRsG6yLlqmxvEMRcgy3J
   L3HINl2zO0IbRtE4Tb5IVGZ5pSjoeLKMltkhZVawgE1n624t3LVrdugdw
   7Y6qmhGVx20PAorhYAQbzT8lu5jKhHeTU+V39T5W+Eom+nRO9VmlU0Rpw
   HyGKlvPM55cge8u4eSnCftTiV6xM0ruBYLpPlzJpSV4ug1h7uQF8cd5ji
   qyaXCBhrBZwTbczDKwKEJb9T6asjY5H3RNx18UHrCJ5fRkDXjVnrHwiGo
   LGwBrnpd1vMaYIKaa9SVErX3iue+83Jq+RKqUTe3cPoiI7fOwGTjL0Wg4
   Q==;
X-CSE-ConnectionGUID: N9tYoOY9SrqYphBk13LZPQ==
X-CSE-MsgGUID: nk6cEZWkTmGi1rXDEFFghQ==
X-IronPort-AV: E=Sophos;i="6.09,181,1716220800"; 
   d="scan'208";a="20456155"
Received: from mail-northcentralusazlp17010006.outbound.protection.outlook.com (HELO CH1PR05CU001.outbound.protection.outlook.com) ([40.93.20.6])
  by ob1.hgst.iphmx.com with ESMTP; 03 Jul 2024 17:29:25 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TAmswtb5hXfz2ycVu4JUph5E38YdXdRLaeURyovG+mTIZLpqcMkSDGKYhPGFoOYxhugIf1/GvXvzHRPFs/S++mYr477A+A+Bw3gyvS236pykIKyc8pvhELsdzUv8A6nqYY2U0iWRG6nc+QpQCZzTG13A0pXQE227FuAUqcDlJ9n8JJlbS6CedFV7Gcma0Bvzqwjf6KKb9AqFRzIvS02XLuoeDwdA/Z70xr0xtM760wJED19Yrd7UjCoDKPKeZvkxNqqvINQRR6VrOxgQ9ENorPw0IZqCVb+6322VkQ8pI8XZ+eG7zeWSr1pBfnSv07BJhYJRokxkfCY+qmjrJL9Vfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=oRs5vat6tvrPNHqduONYNt3Gs23xeizDas244D7R6S2NketB/WvqhNCiRZ+cHTdVqqXp3/9AzxS9tRahI8SmNSQ3PWq/43Xxoy3XGFk9yomJ8iOyWu1eTmTGCSGQxRHKB7PtFTI7q2mX+BYmC0Vx4WjtVo1enxqVXmwKBXOlMqEGzgad0CMq7mdzVpbzjG3zR1By44A+6Z6v1rhPL0aCbI1z/sNqEDREHzEPZHAO5XuEqO8idJAHJP28GMeYgO5wz6QkItTsLoNc/SyBnYpjQDZmeGQsv2diZx2Yb0Ugqv0IOMvvEldUkQGA1ZYBKhPzsQZUlEzSh3tOEXaDAWAIsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=yavtvw0VQGyOOi58xFDqsVRaK345bCdw4Lq3Y+HrqF3M/+m/Q1FQ95GV3LO0NEJGfgwHvsObNk433PNljryt6yuQGsA3LjsTSFZ8onXnNU7ODyJUJ2FPyBrQzgdIYlddFSbR/A6R2fhOjTGhWDSmKwpzFivyeAQHtm7TOSu1/Bo=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by MN2PR04MB6381.namprd04.prod.outlook.com (2603:10b6:208:1a1::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.26; Wed, 3 Jul
 2024 09:29:23 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969%4]) with mapi id 15.20.7719.029; Wed, 3 Jul 2024
 09:29:23 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: hch <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
CC: "Martin K . Petersen" <martin.petersen@oracle.com>, Anuj Gupta
	<anuj20.g@samsung.com>, Kanchan Joshi <joshi.k@samsung.com>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH 2/6] block: also return bio_integrity_payload * from stubs
Thread-Topic: [PATCH 2/6] block: also return bio_integrity_payload * from
 stubs
Thread-Index: AQHazJIV+OOFZPVFnUyO3ggAzWt95rHkvdUA
Date: Wed, 3 Jul 2024 09:29:22 +0000
Message-ID: <2e420338-aee2-4977-b986-66124662334f@wdc.com>
References: <20240702151047.1746127-1-hch@lst.de>
 <20240702151047.1746127-3-hch@lst.de>
In-Reply-To: <20240702151047.1746127-3-hch@lst.de>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|MN2PR04MB6381:EE_
x-ms-office365-filtering-correlation-id: 5376358c-2e45-406a-8bc7-08dc9b429fc2
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?VE1kakRXNHFNV1ErSHE4OTdsRVZmV2YzUnUyb0l2ZUFqc3NhbkVoMWFUc3VB?=
 =?utf-8?B?MkROcnpBMXN4cUpoQzJydkE0L0dScGlWb0VIdkJzdlJTMHpNcEZ4c1pzdG1j?=
 =?utf-8?B?V3BRdEdwSDVuZE0zL1ZUZVJXRWxnL091WWdUa0dIc1V6dzlnRUVKbjNjOExW?=
 =?utf-8?B?RzdyblFIR2tvQUl4K3FZQjExZGdsSkY0UjMvVVBTMEZkci9LeE0vVGpVUzE4?=
 =?utf-8?B?M0FGL0tGczVTblQ1bU1kSENtNFFtOUREbXNzR2o4WmxLZXFjWnJqbmpiaHQ0?=
 =?utf-8?B?TldnTkJzVTF4c3FaMkpBZi8rY3VrUGJVakRwOWZYTktQRU9LMVBhK2VyMGhM?=
 =?utf-8?B?WVVXQkVJWExSTjdDakZIQXR4RFRMSkRJYStNM0h6Nll1SHJwV0xtNlhXNlpq?=
 =?utf-8?B?QVZMdVRNWEVERjRWVDI1cjlVMmUwdndGZmxTM2ZWZjl1L0RZSjlZWDRmeGxN?=
 =?utf-8?B?N0RTT1p2ZkVyUnZwdmxhQmNRTVBQM014MnVUVXoyZGt0azJ2c1FYNEFoMEVy?=
 =?utf-8?B?Y0dWMTFmTHVLQk80OWprZlpVODQvdnlqUHJ3MDEyM3JhdHNabkFoVWsxbnhq?=
 =?utf-8?B?eE1SR3ZDb3VFQzZ1YVh0cE90MHdLZGlGcko3bFA0VVNkRFA1K0FHWENoYVdr?=
 =?utf-8?B?aHhBdzc4aEhEVk5HL3pJS092YUE0cnNSK0UyUDZ2TTQrMldKc3ZmaFpaNW9M?=
 =?utf-8?B?dncza0JmMkNUY2dSNU5Eemp3cWk3ZzVZeWlid1lKYkpvL09NNmdMbnB0T0lG?=
 =?utf-8?B?anRGNHFUcUpkeXpoM01ZUUVxb1JTeEhXZWtaN211WUJvVFkwNDlBcjBXdDZy?=
 =?utf-8?B?UFdaem51UUwybjN0Z29lek5yMS9pa3lHZzVFTTNLOVpMdEZwaytUL1B2elNa?=
 =?utf-8?B?cCtTWUZTRUU0WmtvU1JNYkhTQVRBRTRlYjVpaG93SHI1WjQ3cjNGOVEwNkc4?=
 =?utf-8?B?RGhrV1VNWWo0d3FJL20vKzZrNXNEaE5BZ29lRTd5VXpHUkJoUE5GRXRBOWxp?=
 =?utf-8?B?M2NxTWE1THNGRUptcStBckFDbE1BaWlsNTZzMFZpL1dyS1JCTFZxczM3dkor?=
 =?utf-8?B?aEVZdllKNUI3ZEtkVHl3ZDRGTVc0aUNJQmc4NGtTVldEU2hvRW5FMnpuS2xu?=
 =?utf-8?B?NTl4M2IzVGN3aW5XVmlFcEMyNzFQSmoySENmQVpPd3NpcmlaOTZqNkVKVzJt?=
 =?utf-8?B?SkVna2VXSk9JaGFmNmZxTVB3aE83anM0QXh1VDk3TWpEa3hjaEVNOWlwb0tt?=
 =?utf-8?B?V0xBYXJnei92UnpLSVlLdnhZcnlDWkkwNE9ENXI5Tk8rdDBiS0xEdHhWdG8z?=
 =?utf-8?B?cVhOTnNsWEp4U3pKVXNWVUNkSEtDeTMxa1NkUWFkWDZaWW1sOUpabFpGMkpG?=
 =?utf-8?B?ei9wYkZxaExERkF5Wjk0NHg2RmE4ejFlSlcyVXpZVFZFMEhEbnZqWnBJeDdV?=
 =?utf-8?B?a3NmZ3I4Qlc1QzF3SFJqNjV1N2huUmt3QVRiSFZVN1h0RXhVczBKWHJ5M2o4?=
 =?utf-8?B?c0VqWUp1Mk9KMGVmbnlsaHpJdGZOckpLMDhQbDB3VHBaZDREUHNEdmE5WGov?=
 =?utf-8?B?ZEVhck1CVWJKNVZRUHRyWngrL3lWYzZiQy9ORm42MjU5dEJZZ0NqUm5PSjR1?=
 =?utf-8?B?VENXanYrRlVISUZ5MlhZT0NOMkhFUmhFamE1ZjFIdjFtTURtR2hXcmxPVlBq?=
 =?utf-8?B?WkphSVVRdWRSWFFScW9TRklMaGp5S3hIRFdldmFiTzN3UFFvdTNmNnhlK1pW?=
 =?utf-8?B?cjY0bFdlc3puTWlyaTdGQXRHVXAvNWhoOWw4S3hmcVVlbDRRWFllVE9rckN1?=
 =?utf-8?B?WlFDQ3QzYkxqeXBibGdVZDBoNTV5NDZJU1ZXR0x2TzFsMzl1Q1QzaVFBUGFF?=
 =?utf-8?B?VmN2dFhFdE5sMXVLZFljcHVMMWNGKzR5R0tETjNZQXlUdUE9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?YkYxb1g3dWFhUUpqMEtjZFNRR3pTR3RkbmFaNHpnMXY2Z2c0TXJkaUQ3TU5C?=
 =?utf-8?B?aitvdTYzWEpFRVJvdTBIcHZhMG1VeDVFUC9GVDBBNW1pZmNGYjlTOVNCNGFi?=
 =?utf-8?B?RU9nS2NPVG9wUXVQTElwa1psV1FZRWN6NTJyc0ZVb1lvNjV1WnUydG9yNUl1?=
 =?utf-8?B?QXlHd0RYYTFhZlBQQVFrYjhKYkxNVm14aGRlUWlHRkVkUng5aUN5ZVFTcU9y?=
 =?utf-8?B?WU52RzByZE5qYk5peE0yYzdaZEZYQUE2WGtUelJTNWFWL3lLbUJoSXZsQkxQ?=
 =?utf-8?B?a3NCYjEzUzd3VHlJNmZma0VsNUxIR3pJcmpBZWRrNnRycEFyenYvSEgzSjh6?=
 =?utf-8?B?S08vd3pKSzQvQWtrKzdYZy8yRUpJK2gzZVZHSE1ZYitFd2dmbGUrVmh0NDM0?=
 =?utf-8?B?V29lMXBibDdabk5LNVRkTnVYNUZPNlMzN3hFNHU3M1NYOTE2aU4xdVBrUFJl?=
 =?utf-8?B?MlRrdmJtckUvbnNqSlRjKy9PRjBpaWxJek9wTDIxNUtwSjhaa0pOc0tmTWp1?=
 =?utf-8?B?c3d2MjR2dm1JMnBVeCt6TWxSN2ZaZEg5OTRFcXFxWmc3SjdJNit5eFBpMHZX?=
 =?utf-8?B?VkFjMHJIbTMyTlc4dGE3WHllMENDNHFRV3hlNTFpMjdrYnZLNXg4YmFNR2xi?=
 =?utf-8?B?ejZ3WHlNMHFPc2xpVmdRTldJUTc2MVRwOW9oYVFla2RBaEZHQ1BRZDlUenhi?=
 =?utf-8?B?YXNHQ2VyRHoxNW9nTXFLTzdmbGRDTjVzK0pOa3I2VVFEWjV6bmp5bitCQzU4?=
 =?utf-8?B?SFhrbS9XS0p4bFF1ZTkzQkNsYzBOcDVld1IyNlF1M0dZWDNmSlNyL2NGWGQw?=
 =?utf-8?B?OW94TGNqeEhWdTZVczVobmxHendqaWV2NVRmSDJYbTZGaXhjY3ZqbHBieXFp?=
 =?utf-8?B?clpLL3M5SjVPMDQ5bUlJeUJNRXhIR295c0NSZUx2KzlMMmY5cEo4SDJpN1NM?=
 =?utf-8?B?WkZQZUtqZktaZG5mNVFnVWJveUcvdjNNdGM3MHJuMVdkV1o0TnM3akdidlJQ?=
 =?utf-8?B?ei9sTWVibXRpbytsZnhnZEEyL1piOUk5bkxwTkpsR3c3SEh1TFlMbUp0NU9R?=
 =?utf-8?B?TGtsWmQrOENlZFkwRDZIWXI5bUFFQlI4QysrUzBNUm9GZWNtVTRPNGJyZGh3?=
 =?utf-8?B?Sk5VekVndzIyVGtYdnNwcUlyOWtCQzdPdy9QOWNkQUZwVzd2ZkQ4MVFTM0lG?=
 =?utf-8?B?dU9KTzJzRVhJcjVzdVJCM1hLK0JNVkJZZmZFNDhQbThrM2UveEs3Zis2Nlp5?=
 =?utf-8?B?d3hZKzVqZXB3dkpWTEpjeWdpK2IreGVaU05ST3ZYcnJmQnpvbkxLN3l5dmIx?=
 =?utf-8?B?OHJjK2IxemcxZG5jSG9zSzEyTjdjMlZsSVdUVER1ME5YRWtaNHpjdVZ1Mldx?=
 =?utf-8?B?NHFOcHU4SUFNZ2RjSDVPU2NHM2wxUzhkeXNZeDVmSDZ3NzY0MGQ3ZlNReGFI?=
 =?utf-8?B?V2QvTHVEZEVvb29BSGhnZGpaeXJsYVE3Rk96Ykw5bnBPL1RrQUlhZVpXcm42?=
 =?utf-8?B?M09xMWFlV2lwYzcxZlZ6TFJiQ2RkSGMxSmppNGhzd3YydFFRS3RyMTJ4MUtq?=
 =?utf-8?B?Vk9rR0dEOHljV0hEb05GRGM2N2xGbnpyYnhHTElVZGpodU10WFRteEx5dk03?=
 =?utf-8?B?MFdVd1huQ1hNd3haZFpiejZwcXd1bDBtOGRHRFYzbUhQOE9laUdHYTJrb1RO?=
 =?utf-8?B?ckl3VUZKWUJOZXBDem1pS0pwTlpkL1lHazYzVmlNaDJXUElQVjJ1NTQxcHAx?=
 =?utf-8?B?NkdUcHU2RFBPWU1hVERRaEk5QXUzOHI1d0FWdGRBUEw3dm82STJmeUFZOWpl?=
 =?utf-8?B?azc2OTgycXg5ZjJhR09kNjloZzJvUWgrVkxoRmxzN1lOQ0pnRmRPMXNOYXgy?=
 =?utf-8?B?d1NKejRMZTEvUEZySGJTRVpUU0pQazF4L2dtWWpoY2pRbTFVR09JSlFSNGRC?=
 =?utf-8?B?dUxpMTFNdlFnUktTL21DUmdyUjV5U0QvN2lnTTZzdnFhSmtia1d3aERaS3Rv?=
 =?utf-8?B?YnFhL2VBdGN5T1VUc1ZRMG5DVUtDWXBZRmw1eDQxMVoxbjJQa0dFWG1oaUpu?=
 =?utf-8?B?ZUpqTXFNVm1EdUJkRjd5a1g0VWNLSnhkY2pDd3VWUVJ0SE8zWXByVHRHeFBw?=
 =?utf-8?B?dmxOa3ZNNU1WUzQwT25ZZDZOMS82Q1lqMFl4dko3NW5iaVNNajZWYkVBVGty?=
 =?utf-8?B?Wmt1eENkSW1KY3ZWbzJMQ0pwajJUUUlPaXRRb2lodUNyemFqSzRxSUhsVnVP?=
 =?utf-8?B?Tis5aG5xWkhmQS8zUXdGMTFHSmxnPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <39333A68F2223C45950DE657D6EA3B3D@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Ctu5tgkWCH+l8fHLs7HLfEje8HH0B6o5M9pRoOHu8Kh0NQPZXIUQ4K6Q/S1EX84AivuRtel0AghKeAD71KhBCwjwBokplAKepZIjaweZxG/Q7dF98/JcBFvWHqrZm7fbSjD+mITYHifray0pTDRn6Idj6VlXJzO8SfQRIqWM6vWlMvVbYWUMkK34qtOw9l9Z8b14NAHlVZgZQUHFBfuHaAp33nYR8ifWro9JPW4e8VmmtLbJx7wcZf+xQILLOzQtJ9kwm7Xmxj78Nph/QbZ9vb+hk9NaLx+9+0gREmYTTK91gOYXg7aqyCBp39j29wki1dxMThg//TZrGmtCWBpIoUwFiIc2BODT54l53wqxh2G5ZASptXb5XEqwXjJeF77C71X2os8EPuDSp0ydUJoXMwK3GVoXao6o8bVmfXBZRgSXnAV6sGC+1J7GfERfVxg4/rb4rKjqzNTWlcHjWsJvv96NsWb6MFIN/7YRI3MQAaBDQVAaF7MHojDdhnHgwBtup9nO5rJSjy7hEjugtkmZX6Vtwy83mY7mbHumgRVlBbUffi9jkOj0dkk+igLMqgBtgfU5x6qyrREsUlvzFV/I/VAU5Cyr3n7Dv5yzQux5Hx3NmYpc4Q4MYCe6LE7NPLNM
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5376358c-2e45-406a-8bc7-08dc9b429fc2
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jul 2024 09:29:22.9794
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XxDQvd4fqga0Jf86RGdMGd76nHgmg0t1SP6HWhydn+CeMsez1KmlErs6At5G/O7kqhtcfNKK6+w8pGUI4+G1NVN60+2pDnEDlQioj8VOdys=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR04MB6381

TG9va3MgZ29vZCwNClJldmlld2VkLWJ5OiBKb2hhbm5lcyBUaHVtc2hpcm4gPGpvaGFubmVzLnRo
dW1zaGlybkB3ZGMuY29tPg0K
