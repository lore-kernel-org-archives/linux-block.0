Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CC601755B
	for <linux-block@vger.kernel.org>; Wed,  3 Jul 2024 09:34:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.143.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719999246; cv=fail; b=dUwJBW0554w+upNtBWbYEvxGN9yO7LTTbDbA7Lq2CK9oaRFLceodP3tsdooxJyd7+g+vAEogH6jCUZzr7GfyjMylzf8wLPkF+7IHOH+lphtMyUVQWL2nX7SbRk57sQ4409bNpWPnhcc7lNwOPVRDlyb4uFyAzp/1RfjY41tUsE8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719999246; c=relaxed/simple;
	bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=q/RqxL95SP3zFX1yzgk5v72C1olFJtoCivghVBGpFXox5SJXbqGlpOtw3VLeE522eCW5jGVovF8t6tpIoV7jlSp8+UkWJ2sxN5syfWKKSlKpMD8Wmw2Xa5FjlgoG9CRRP3FTic27d8AM01n/fiM/oXTZ+yxV/jQHhlKMVr/xxfU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=HmFwtwr8; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=NUmj1DfV; arc=fail smtp.client-ip=68.232.143.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="HmFwtwr8";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="NUmj1DfV"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1719999244; x=1751535244;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
  b=HmFwtwr8nIJgwN/hQedf12fiP+scwr8zxz9YD4NhDGIz6FbV/u/XR7we
   gnbbmzqzBOEHcqq92KYPB7nKO9moYDscsIiobgxWqLPhCBPiyYH2DnoP6
   aR4Zm109nI/Bzbt/eGPAbXpATFJYnDKqM/31hj4L64aeLSZQyCsdxSsR8
   ZyMdb5+hh1JC0aEcxul6DlXi/HSdaKgm9V9Wx7htA2W1yRFBSbpmrGUpV
   R0wOyJQcorObt3ru76QxAqFg8Vw03fKrrAkruQdrjGVlu5DPW7Z14YyV6
   6FTypTgeGRFscgKjDsYyAygeTWTfQF/mzE6l2E+32FN5z0PDQLENjExVL
   Q==;
X-CSE-ConnectionGUID: m5buyAqZT7yV0/qEKvSmUw==
X-CSE-MsgGUID: E/7SIdaUTruJRKWGOeZpqA==
X-IronPort-AV: E=Sophos;i="6.09,181,1716220800"; 
   d="scan'208";a="20799693"
Received: from mail-eastus2azlp17011026.outbound.protection.outlook.com (HELO BN8PR05CU002.outbound.protection.outlook.com) ([40.93.12.26])
  by ob1.hgst.iphmx.com with ESMTP; 03 Jul 2024 17:33:57 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AICOG64J2yqq5ObkBcO5biZvDuIECm6DW2XgZAiux1GDSFoZulUprN/NHajYk4jcF4+y/ng3JK4pWxSzzNS9zDgrzZ9yHtqEZ0hk2Zc6j7Eu4+B+QxOgXS3daTNA3LLLwuK2vTXOxHAmhiuVWRp/AjfHVRCFwE0m2N/QG4CD8Mek1+R3nOKqA3iJWF6rl8ZywF7RqfRjP+eP5oBHodxf9P8B/tlJVyKRqFRGQLkzDD1e39yIYf1MXnR1oid9seayUvqaiIIWneYOcAYkVAiErO81aHBiA+KaCOjmO+krcDRJbu0vogwDOIeCjyt+qW/v8Rc799fvd/jwYtzHfjQRCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=Cqkhi0BEILy3AFYLM4REs0lngecLtMGuRqrzrzDpcvgZ5ALW4RTLbp1Aj9iBAHU7uzb5IIXiDe12Rhd9VxhzHHVmZfDhJZGWIzdVrsrmtwunkesmjn7G0z+90dVmPEl4E/CmwUR0nqe4rSpyJPYAWpgdm8AxszJ1aRzxsjbv3yq6TWnhunBwpwZUal8SuOcJFWgoWOpo7ZkZ48ehoTwyhueXcG3Gy6J0OOk7TNsICYgdls8j2zj73cFDov1+ONaqrc6e73fjqnGfsG7MZalgUAFx66p7FpWEvLDXMmZ7vyMfYCPLnN8bHkExqNSFGs8Q0QWqMn0fb+Cy4aSY297fLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=NUmj1DfVz2u1LkloagTcRXqKNdNorDmztzXLDmfKEOjxGkwxF0MpC/4OR2k2Ixph87xPn4eYY1GBmUh730zKr/Y+WjY5PJUKoUkkVSVMa3W86pDZwv3LEGdfca0735aIrwUjRWI6irNHj2KeGUDghJDFeVud1baua8JcahJnKCw=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by MN2PR04MB6381.namprd04.prod.outlook.com (2603:10b6:208:1a1::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.26; Wed, 3 Jul
 2024 09:33:55 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969%4]) with mapi id 15.20.7719.029; Wed, 3 Jul 2024
 09:33:55 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: hch <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
CC: "Martin K . Petersen" <martin.petersen@oracle.com>, Anuj Gupta
	<anuj20.g@samsung.com>, Kanchan Joshi <joshi.k@samsung.com>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH 6/6] block: don't free the integrity payload in
 bio_integrity_unmap_free_user
Thread-Topic: [PATCH 6/6] block: don't free the integrity payload in
 bio_integrity_unmap_free_user
Thread-Index: AQHazJIXYRcw69oMmkmkIz3qXwBazbHkvxkA
Date: Wed, 3 Jul 2024 09:33:55 +0000
Message-ID: <1cb10153-4a35-442e-a4e5-14e306bd06b0@wdc.com>
References: <20240702151047.1746127-1-hch@lst.de>
 <20240702151047.1746127-7-hch@lst.de>
In-Reply-To: <20240702151047.1746127-7-hch@lst.de>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|MN2PR04MB6381:EE_
x-ms-office365-filtering-correlation-id: db1d273a-e37b-4077-d5f0-08dc9b434202
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?V3V5WEVIRFEwZHhTc1BjdlZNOGxvYTJZWmcwZExQYVNMRUpOVk5IaU1Na0dH?=
 =?utf-8?B?R24wVW9TOWJoVjlMUTZaM3A5SHU4dkNNWHkvMnJYdnV0TWNENGhxeG1nYkpX?=
 =?utf-8?B?aVIwbDVBRStwcG16M0hYcVI2NTVWb2dPNDBHRlZRRlpkR2syeUJXQ2drU05T?=
 =?utf-8?B?amVpbmluOUpnM3JlVHVPK1hsK1F0YVQ1clVPZmVjYzM1OWNzZ0hzVitjTlIr?=
 =?utf-8?B?RytGbjhaOWt3all6bHFwWGpjRjJrSE9RaVFNRHNaTHRQMkFkQnNjNDhYbnZQ?=
 =?utf-8?B?b2UxNzA5Ym15RnpvNnhGcW1uMU1qb1dEb2M5aHZWbHVteDRCRlV4WmI5cU1r?=
 =?utf-8?B?L3dVdEsweTFvTEErMjNHOVpVVzV1MGEvRzBrTy8ydnA3WXJuSzA1ZFdnTjVu?=
 =?utf-8?B?cXE4SWJ2bkhWSWh5ZnhoVEFLdFJSd2Q5Y2p3RWh6cVFGZDdPUE1vcVUxbVR1?=
 =?utf-8?B?RVNTYzJyWVFUSXZhNnRqSmk1cEpjc2x6V3ZBblVYQlRxblFmUTdqNDR0Rkd3?=
 =?utf-8?B?aC9ZTFVMVWE2ZldLakI5TmllNEJzWEFhQlZHYnFBTGh3RFZuVVZPd0Rla0c2?=
 =?utf-8?B?UDBpdHRrbmRPcGZna1VLemVmVVdvNnYrRmlaaGFlNFROd0tGL1hoL2lxVk5Y?=
 =?utf-8?B?ZHlFZ0phNVZsTHJnR0xyM1M4bnpvNFJ6bks2RXM1djNYYSs0RVMxSzliU2dL?=
 =?utf-8?B?TkJBTDZIVEdPckpvWE9Qclc5Znh0aUxRU1NNTHF3ZytjeUpoeGE2a0RVNE11?=
 =?utf-8?B?THBHOUxaOHNMWHMxeUZ6Ly9BdzFhV1paMFhQbTZScnFPU3UvcmY3TWtrTXVX?=
 =?utf-8?B?THRHc3VxNDBVdVhFWmFYcjIybVMwYy9WTGZkMEovbmthaWxwSXEyVDRRTko5?=
 =?utf-8?B?a0U3NzBQSTNxRkVHSkc5TklVYmdBQmJUYTVrbC9EeUZNbDJsdjJRWkF0cUkw?=
 =?utf-8?B?NGRuTm9JeXdxa3F0Sy90MXZhbzhjbnlOTkpVcDFwSE5DMVN1QlpCUk5iWGt4?=
 =?utf-8?B?THd5RWM3VEV2UUpFM1ZsQW1CalRSRVhyQzV0azJveDc4eDAycGFaNXVYUEJw?=
 =?utf-8?B?NCt5WS9qREhUZytYSkFQbDV0aFhDb3lqMCtNcWRGRUpmeFBueTZWczdzQThz?=
 =?utf-8?B?azRGMXdiZUVHNzVkbCtRMFVwWlBnNWY0QnJuOGw2ZnBpTzZ4UEkrYTRHK2Vo?=
 =?utf-8?B?M2Z0MDJyUzBTMWp5b3Y3WVhncWdPdTR5eGJyY3Z4alllVzhsSFlzUXd3TlJV?=
 =?utf-8?B?d3AzbDFUYXZkSUkrMHVORWZuM2V6bDZ1SFZxZlhGanZPdHhjNVhyWWxMYnVi?=
 =?utf-8?B?TGF6WDNZeHpTRDlPa2pIVzhuOGxZYUhGdVplUGhzVklvOUlkQjJwdGQ3dElu?=
 =?utf-8?B?UGQybk91Ky85VGp4Zk9mMjBBVWFPU25CWWdHUk9zSW8yeVZWZjBmd2pIdjRi?=
 =?utf-8?B?UVdxc3hJZHMyRm5YNlFRMVNxRnp6UnpuZWVQVkJBamEvMW4wMGNZRDVBZVY2?=
 =?utf-8?B?WkVsN3htdEk0TS9UT3R1MWVoZmc0ZDhhSDE2Qm1IRkdPemdKTXR6cE44QldQ?=
 =?utf-8?B?UEw1NW1EelcxUmJsQzhMZW9UejIvdzdCUHhQYTVZQ0ZlaUNMNjVWaGk1WmJU?=
 =?utf-8?B?bnBKaEN4S1pjdmRWWGxFZDFGeS9VeHdpdWE4Ny85NWV5b204bklmNDV4cnlT?=
 =?utf-8?B?dE9LMUlGVWxtMnpPMGtSMktzbHkwaG9LUmdsYlNOSU45YUo1ME5ZT0cxaVdt?=
 =?utf-8?B?OVZBd3o5cUNmR2ZONlh4ZlJSa2lLN2x1a3p3dXUvdkg1ZkZhajhFaFRnd3ZS?=
 =?utf-8?B?Y04zUHlTMGU5MngwU0xoTnVEbi9iQ2haMlltQVRpU2tNN3R3U09nOCthOFFC?=
 =?utf-8?B?alFWcktMVSttdFZ1V3N0N3JUeGFySXIxcGZVMmFDS0ttMnc9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?MGpBOGI4WXh4M2xkaFo5YzQ0RjRzSkc2b1pDajRxa1pMR0x4aDAvOVhFdWZy?=
 =?utf-8?B?L1ZyaW14VUZpL3dQWDRzc1oveGVhSDZKVEROcUxWbzhLUmkyOFpkQmJRNjNv?=
 =?utf-8?B?U1N5SjBJa3l0YS95WEZ1eGpSSWJIdFYwcmxoeGJyWXBpSUl5bmtKWUszRXBw?=
 =?utf-8?B?eUpibjlUZ0hmNXZvZnJzQXFLMTVQY1FGMHhVVHpVRGl5ZllWeWU1dzFnTWlJ?=
 =?utf-8?B?VlhYNHZxMWxXQWJxc0p2ZXY1UitPbXVvVDlVWkJpMnBTNlQ1amlEb2E0eE9E?=
 =?utf-8?B?am9KeGJjbFQ5Umh5ejVGYldTVUM2UVduUlE2VW9qQktoMGpBczlPM1M0cGti?=
 =?utf-8?B?VEFWcWQwM3BZYWxHWjFRYVNmTjNacXY4c1ZndlVJY210MG9xTExOQjh3Z00z?=
 =?utf-8?B?NkVQWmIrajRETTVPSzJxaExZYUxIUElxbjZFQ1JrZnNmVWJ6Rm91UW5kOGlz?=
 =?utf-8?B?eThncVlHTE5GUVo0dFhkYmd0SXhTdm1oUEZCcnZ1NjVSTjdJdERPcUROTWIr?=
 =?utf-8?B?ei85VmVEblVxL0lRaCs2aVlhTzZEQWNZZTdGOTlXazVaeGFPSzJkbGxnOGpa?=
 =?utf-8?B?TS96Wng5T3hwN1dtSEx0T2oyS2hIcHBwY0dVVUl1TDJWRFk3ZktLNVNhM3Aw?=
 =?utf-8?B?d2FySjVQUzdXYXNqMVk5N3JMa0dOek5QR2hwZTUwNmJVZWorOWp1NjRKeHdm?=
 =?utf-8?B?VGx5cnQ1QUJpanNyR1RYQmd4ZjRWR1VXdHZjaUtVc29FeDhYeFAyQXdTcHdS?=
 =?utf-8?B?N0tEcTE1Y1M1NXI2VE1wKzc4Z3JzOStHUFlLL2R3UU40YVY5ODRVSlozaVUr?=
 =?utf-8?B?b1M3OEJyamVlSUpJOFNJQUxQTU1WbEwwVHZsdXNwNFl2TFRJWEUxdG5mRFlN?=
 =?utf-8?B?WWpCQ3Buc2JOT0w1UWM5MU1sRWlvRnpzbDV3LzhqL0JBdnRMTitTTFhLZkk5?=
 =?utf-8?B?RUp6QlV0WVNqZ2dLbGdrVXhaVEhtWTVqYjh1algxRmZpSnlrMkVyeFkrdkJx?=
 =?utf-8?B?WFlVRGZTWWVZMVNaYVJkaGdtVUdDNVVZMGJvMzJYN2xWWDUrd3Y4eUMvKzBy?=
 =?utf-8?B?Qys1S1M3OGovWFBSRDFZTzNCYWFNTTd5OGI5aEhWYlBtRG9iUkVudjVNRUFM?=
 =?utf-8?B?dTF1SEJxSTB6RTRlYVdrREN6ZjZyb1RETWJ1cTRjRWRMS0NnUEVIMGVQLzEv?=
 =?utf-8?B?d0hyREFLWGRETnRJdGVjamhHMmhmUTZEbHErUzRMN1k2SkdoUzJFTUhwWnFx?=
 =?utf-8?B?cW9sOWpMSEdnUTZTMU51OE9wT0N6SDk2bXlFUFc4WHVBaEVuT0d4Y0FweXlB?=
 =?utf-8?B?N1ZhUlk3NDhwbGFFVXN0VjN6YUVuNWRTeXczQlU3T3M2UXFMTXE2bEdKUit0?=
 =?utf-8?B?OHNIT0hQeTA1dFQ4endTMFBYMmp2TVl5Rm1jMGJQaTJJT00yZVhRemNSTGk2?=
 =?utf-8?B?d2V4NmN1VU0yNUs3UUlOOEFVR2h4QlJla1FER0dBSkVOOUJZdHdUV3VHcHRm?=
 =?utf-8?B?aVk2clA3VFptZlNkYktGcHBpK1hZMXdSUk13NCt6YlNZQ1MyVDhYUGJjVDN5?=
 =?utf-8?B?OWo3cGZqWnltZHljTElNZlBMbjJZYzVVajRReGNCWjdDaThhVDlZK3NiM3Nr?=
 =?utf-8?B?SW4yc01CcEFMY3VVRllhR2J4aVJMZHl3UVRmb1krdW5URE9VeWRNUUpicXdN?=
 =?utf-8?B?Q1hXUXVub2R5WXg0R1BuRTRUWndwMmdqZTBtTFNpbDN2eUlaYWh1UFdOWFY1?=
 =?utf-8?B?dHZOdlZyYk0zWS9YeFhWN0lzUzEwb1EzTC85czErSkdwa2lwZTNnUmlqN2V0?=
 =?utf-8?B?ZkVSN3loK2JJV3lvS3ZrN1FYREp4Q2YxYnNON0QxWUVQeG5mbmxsb2d5YXlQ?=
 =?utf-8?B?bTMyZVJ0bXBXZlBCYUkzV3g5SG9zczZNYlB6RkRaRXRRZExJbXN3VE9CQzU1?=
 =?utf-8?B?VGtha0EwRHQvL2hGM1ZkUWlzaW5LY292d0ZodmNyaWxUeVU1REpsWkdrb0FS?=
 =?utf-8?B?blBlR3hIVGNxejFoM0NWaVdWaDVjNnFobHMxbE9pM2tPcnpDZU5VQmJ3V1Fr?=
 =?utf-8?B?MkF4N3cyS2w3OWZNS1JhQXZrWjltaXRDRjJmb2U2UmRuYUlIemNCdnk1azF5?=
 =?utf-8?B?bmt5TkFyNWNKbGYraGJLTnlBbk5GYkQ1ZCtERkV4NGZCK3l4b2hvNVYrSG5C?=
 =?utf-8?B?UlJwbTMwSmZYSDZnM2ZFZ2FtTFZaR1h3eHl2bWN3RXJsN0NDa1l2b21hVkts?=
 =?utf-8?B?RUlpRDkyR2FuNlVBWHFnQmtGRDd3PT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D117BE11053E65489114053E745F9DD6@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	ofWj6JjrxvyjOBSkaZEbfXzUje35slArgFRtENNM9S/cqILaFtmHR87Iy03O8OPjf3FTDD1KnYJ0wlO6I2JxfBqB9kEKNnZ/FvnX2vP5aBS1+sKocVo0okax+ZxU7JY2XCF2YTHiyUir1gpM+dM/4vnDs9p+qQNv7PpQQRV0cSyEgjlAxlNT/bL4ZquJMQlZRZdfFp40yndcjnXAKow4G0H1UdMIozkOk4fqA+IAJgVy905tCEmnDy2can6cqFoA0dbVTIF952lirqdMwuA3ljCx5q2BacxvqHgQ5ubMjSYVBntQDhltzLhF3NH9A7Ezd31X9XIYqsHxDioAox5pq1/EQ9izKyqxT9pD7fFwiDrilca/Lld+aum9jH08kPyVyOgTy5F49s+Z0H0kUyIhoqBTl5GgaWR5cLY7dBSnGRYLUh+GKoOFRLe2reuES6olwLP5ZgWrbzzXwmHgAbvpJn30nwf/GhxFNkW0hxmFLlONWzKJLW9SBsD2WuGXYeRqDe3lVDOvTSIy3WrkDJmfXNpub13ylwxgLcBptu/QhOe9UqctSYnmU4JAbgFA4rfMnqYea8smBC/zv7gmzXXVpF+vXNyzuiZTtv3e3CKl5bFOkgj/lsdDU1IRjQd927S5
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: db1d273a-e37b-4077-d5f0-08dc9b434202
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jul 2024 09:33:55.1913
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SglSpT4IVcm+Ll1IaIl6iN45Uya0eUvSKToMn/Hgyqdf2iHoAtNXrVEUzRic/AMoedaPH5PFs5e7YbH0AceotpC7rtUQ4lF1Eh+K1iV8KYg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR04MB6381

TG9va3MgZ29vZCwNClJldmlld2VkLWJ5OiBKb2hhbm5lcyBUaHVtc2hpcm4gPGpvaGFubmVzLnRo
dW1zaGlybkB3ZGMuY29tPg0K
