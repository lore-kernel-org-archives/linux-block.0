Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20F09261362
	for <linux-block@vger.kernel.org>; Tue,  8 Apr 2025 06:08:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.153.144
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744092497; cv=fail; b=nUqDNm5K5ygKNioHl1QwuN1yEXWttX+EB6zl2aOQyha33PFq7mPdAR0+2rFCDqM7esC8b4tgMlivoyoYY5rfU7F1o+MfM1ARTfCGfLxr2Q1PRdfTbYkQN9jJMgfN+9+CIdNnViftSkbCNLYKlY3mkpOUdS8OQueYwo+Nm++p77c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744092497; c=relaxed/simple;
	bh=Vk2hUJbB8x1kfmvsTSguaM0YPcY6xrQ/6geYb6UO5dM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=BgjQhVe17og+WgYkKgiIFmS6FfmgtBAl6GloF9Rk0PrkFAQtsCrkV1Df0d9bKyWTOcFty106lKfbt/CcPPVFNyn2n+s+KTD6EyZGdMLcN4m/CXWxKnLxknR1Y3jopJNOTvWaAIY5KfBhRXO7fofhfZ71+ZS4UB1Ys6PaCI4NtIc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=AJqf4aUq; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=bIbDd8GJ; arc=fail smtp.client-ip=216.71.153.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="AJqf4aUq";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="bIbDd8GJ"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1744092496; x=1775628496;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=Vk2hUJbB8x1kfmvsTSguaM0YPcY6xrQ/6geYb6UO5dM=;
  b=AJqf4aUqCkKTMIsTalHIjXv6YwEB8NABmIWfc+c5Vl8eg807fpaSXcms
   p70YXo9jc2wQrOg43u/UdgawR8P5q3ZiXQXhgjhi33+uQSBouw2dUJ+NJ
   O9fgoY2szGqLn/XR7npOMoh1lyiEvbF/MfSXjU8+CmpZ6/n6J80ryKIa2
   l/pF8fyJ/0qnpLc9gbwhdWU6aU/AJYqr6vcEFkGjQmaZA9FYLgPBVfAg5
   JiDpfUyOsM5MJP/MOfQz2EfKzzLf5LVkQAcPIG0qk2vJEDdQlBgb4rtAC
   PubcF0vq1cxYXRyXpcNQruJ3SPYvr0FP8n2ICXUHY3rqOpfNUJfBe/nRJ
   g==;
X-CSE-ConnectionGUID: ahrr3jykQFaTMQxT62hgmw==
X-CSE-MsgGUID: DV/4JS69RhWkY5MhJhgvUg==
X-IronPort-AV: E=Sophos;i="6.15,197,1739808000"; 
   d="scan'208";a="73506248"
Received: from mail-bn7nam10lp2042.outbound.protection.outlook.com (HELO NAM10-BN7-obe.outbound.protection.outlook.com) ([104.47.70.42])
  by ob1.hgst.iphmx.com with ESMTP; 08 Apr 2025 14:08:13 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Q/x6Pj2OumbWqQr9ziFLPmcrZ8SQRD/UB9QVw49PPtyW8lIbda7HSDTuugVVNIEQGg22CejaurLD/2Z5f89jchcMm0A892yW/gX7SXox92BlumZVfoUjWYhEJA2WXfvfJEs0fAzw5UvSGaax7TIU1uIy1/zx4YQUUkOp2zZQgzyRhpnR+a184ovw6DC7yX/eKN4MWMW8un7jO+st01iJa0zqwGY0b0EVb2AuodQnsGHeOqAdRVMRZv1kBcMsc8RSZI5EQdJi8Y2uO0jIih0tkUZMX5Q7ApMTUwgj8zYX2vzEtrf/jrXct7Xu/M8TS1ed1z2rqmFBFDQiihtNC6zo6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Vk2hUJbB8x1kfmvsTSguaM0YPcY6xrQ/6geYb6UO5dM=;
 b=cOEv6rErvIeDzgRuxPoI2OdqT9x9A/lUO7MoHvy4tEXvhHprs70IyTt8nLgmwTdxDltjQRQPJayIJ/lS0OFg2onCMV7PpoWdTJGM231wb+HLuaX5kk4mOlK4eKdPfcqsPwl3StjAulJFc91CajtUeIOaGbAZN1T9lEseebt4Y8zWkcUAVHi+Vy/ar8lkTSGbLamZsk3NS6SucF3hZJiJDTBlc7aYdnRdROgGdc1tVDd4rcakTIeAv4shichBAjXC2T5SjMvoaAufrcGD5ekHekBYbryW7wiblqtekuGYW7A6O30TAyOsMZ475Kel/VOHFF7fPASfG7EcyUnzFjqgWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vk2hUJbB8x1kfmvsTSguaM0YPcY6xrQ/6geYb6UO5dM=;
 b=bIbDd8GJeBzFKvAoT9Y8vpQFCdIeE3K9kQyr0eezw7cV+DYj8xFrxuvmuVbrwatdRyOZ+xLJ3n0qHNsShgkO3Wyr1tCbWvZ7+znxW+JWLmWDGVE/66qGySuK9pxE6yQ15CeckvJyadsGOabcowrIDT4k1+negpiHdY1r3lQD3ZI=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by IA3PR04MB9426.namprd04.prod.outlook.com (2603:10b6:208:50e::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.36; Tue, 8 Apr
 2025 06:08:11 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969%4]) with mapi id 15.20.8606.033; Tue, 8 Apr 2025
 06:08:11 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
CC: Caleb Sander Mateos <csander@purestorage.com>, Uday Shankar
	<ushankar@purestorage.com>
Subject: Re: [PATCH 03/13] selftests: ublk: add io_uring uapi header
Thread-Topic: [PATCH 03/13] selftests: ublk: add io_uring uapi header
Thread-Index: AQHbp7+fvY1macqNO0KI0Y/VqtEpS7OZSbUA
Date: Tue, 8 Apr 2025 06:08:11 +0000
Message-ID: <96986e17-2096-4ceb-8451-14989a9fdac4@wdc.com>
References: <20250407131526.1927073-1-ming.lei@redhat.com>
 <20250407131526.1927073-4-ming.lei@redhat.com>
In-Reply-To: <20250407131526.1927073-4-ming.lei@redhat.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|IA3PR04MB9426:EE_
x-ms-office365-filtering-correlation-id: eee42891-d9f3-4dcb-211c-08dd7663bdac
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?ZVoxZE5CckFndFpzb2dSTExsUUNRa1pZTkdKbkdYUmFReUdjVG5xYXJnOVdo?=
 =?utf-8?B?UUhabGZ0SFdyZURZNDIyTmdXeTcweFFWL0o5NU5XQnBkMDdvVGcxVm8valda?=
 =?utf-8?B?aVdRZkhQbW00RGhyNVJ1eGNyWVlGNURGSHlsaW1DSWJzVmlPZURxVlE5Z2Ri?=
 =?utf-8?B?eGdzZEhYZGZNdmxpNFBPT1VNRS9uSlZQRTc0R3QzYnJvR3QzR09TUWZLdzlk?=
 =?utf-8?B?MGVOekdNUkRjaVRqM0VRZ09zcnBzT1dFNVVmNnRjNjZkR2dkVllJNEVXRFBp?=
 =?utf-8?B?MXk3SWVoc0lXN3dycUYrWW9DKzdPdnlTMnNqS2NpOEI1aGNyK3c5anR5Qis1?=
 =?utf-8?B?UFNkRmU0OUtpbDZwVlIyWlRvSkJmMXlYUTVBR1d4RHVrSkp3VlRCOUtQNjc1?=
 =?utf-8?B?MWVTN3FMSG9LeERFR1ZpRXpaYzBYMXZobXhLS0d1TVNpbDVrQ1Q5THBDWFR4?=
 =?utf-8?B?R3pObUpTMGx4NmZGbktoSlkxbXFwaGNnV1dqQnFkNmU1Q1lndnpXZkJoVlF3?=
 =?utf-8?B?R215bGlJQlAzUG9raVd5NklaZnFlZVVnMzhaY1dabHE0V1phVFhvbEkvTkJE?=
 =?utf-8?B?ZWxqUUhaTk9JSjlqaWFIWjNMaUk2Mjg4TUJtcGNoRGg0R1UzUjBlYzhnNjlw?=
 =?utf-8?B?cXdPTkMrWHJGT09zcis3d3MrYjBYWVlrc1d2WGpURUI2MThNbmNzSlYyOWtR?=
 =?utf-8?B?R3gwUHlNdy9xMW1Ec2YyaCtRS0VPdjVJY0ZDUmVvWjhWR0NUZVZuSlgrMFE1?=
 =?utf-8?B?RExMWTNScmdON21yWkVJZnROMFBNMkRtdjhyT2xoYUxXRTBkU0pHRmpGQ0sw?=
 =?utf-8?B?WTc3enBMOTZUNEN0VmhhT1V2b1Z6OUlXN1pEMzNZT0Y2bUwrLys0dVZZVTdo?=
 =?utf-8?B?Z1I5M0dkTGlwWjYyV2pxLzJ0N2NPc0dNSEJtMDRyUFdORk9jSHVQY0RxWWNr?=
 =?utf-8?B?cWc2Mjg5ZGlaQ0t5QmpJK3BTMjN4VlJVUi9jWm5VNW05bThtUWJsNy9PbWY4?=
 =?utf-8?B?N0RXVzJ2b0FoY1FGWk1ZdHVJbGJNZ1drTUYwdUJDZUFMNWpCTWxzbzBQM1Vm?=
 =?utf-8?B?Y3MyL3p0WUxaTGhJVXJSckNJVVQrZFBpdVMybVRldFRHR0FOaFVQdXBsbVRW?=
 =?utf-8?B?TG9qU3MraTJqVDNrdDNId2E4cDFzSHlUbXQxaTNxNTQzUGErZVg4ajY3Z0VN?=
 =?utf-8?B?c3J2WVFXOWZVVytrOGpmWnovS1k2Kzdra2FxUXJaQ2l2dWUyODZybUh5NlZH?=
 =?utf-8?B?SVdkTWVwelhnb2ZNdVVSM0hjcHRQNkw5aXpLWDVUQzJIeFhLaWFESEpEdWEy?=
 =?utf-8?B?dm83NzNMbFFNQUR6TVBmc3d2MWdhV3lxQlArSHdZUGNGQWkyWUM3T056ZDdV?=
 =?utf-8?B?Q0QvN3hZbUw2ZlE5cXhUemdVMGFXeC9Lb2VRRmhmZVl1YjhTNGYzYnBlMUNT?=
 =?utf-8?B?Sjl1MEVwbUViN3ZWSDhRbjdMSEREN3NERTVhM0ZwUVY5SG9EUHRGNVRMd1Qv?=
 =?utf-8?B?THZQSlN6YVhFamJjRTVJSHJZSTFGMXV1cEdqZ2FOdGZnSDBlYlVDZXVYN0ky?=
 =?utf-8?B?VnRWUTUvU01GNWpCaG5EVXpwTTdzQ2V4ZlYzMnhQdkkya0hWNm10RUpaUldv?=
 =?utf-8?B?dWR3eklVejk4UHZMQXZYTXdXSVJaemEzYjJaSjY1ejVMYXp1Zng1TlhycHJF?=
 =?utf-8?B?ZjJnWTdQNG9yaEFhUTgzWVFUWjgzcDVHMnZ6aFpIcUFpZUU4dVpBZHBFYmZT?=
 =?utf-8?B?TkUxUEJBbEY2R1NrOXh3cFlzaEw1ZXc2d0NpZDYzZUx4REFQd2kya0FvNnc4?=
 =?utf-8?B?RGxNYVJ1d0h1aXBTZWRJUkt5T2V4RllZZkdIdkwxTTREWlNSUWRvSEVaeFYw?=
 =?utf-8?B?WG4zNHBUU053VXM1SlJYR2JQTDdDc0ZzcWFKdlduNFY3bGtZY3BHU0Z1ZUxK?=
 =?utf-8?Q?E9RvUcGFqUM400dUOA32o+DQ1ask2AJI?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?OEJLWVQ0dk9uMXBXZDJnTVNDWHU1VG1sdktVUElTTDJibUxIWGpFRHNJTU9W?=
 =?utf-8?B?YWFacnRxZU1WR1FvWEhteVRpelVHRktmWUNqTk9BRExjeWx5RWpocTN6ME15?=
 =?utf-8?B?ZWFZazYwbllGd3VKdDIxNDFHcWIwWHV1YVBkREhzL0tUV0ozUUFXc0tvcVhh?=
 =?utf-8?B?OGNKbDF6S3Q5Ty9hRU5GQ3E5K1poMW1TaVgvb3lVNzV4RzdYcjJFMHlycm8x?=
 =?utf-8?B?MXJsWC94Yk0xdmVJU3kyemNyYlR3RzFrK1V1ZlMrY1BCcE1MRnR6OWMxeWNQ?=
 =?utf-8?B?alpFZUwvQlVkdGZxWVZCZnVmL1ZnM1dwdC9lNnV1dEpQb3p1SlN0WWt5Snpk?=
 =?utf-8?B?aU5tUDJyRmF0Y0lsRldwVURXWXpPczFhU282RmFlK0pGdGdhWjhwZjZRcTNX?=
 =?utf-8?B?THE3ckgvMkxxaGxJMEY1cnFBdXF3QUFWWnJFVEhSQVdLa2toUjJ5Ukl0by9l?=
 =?utf-8?B?Z0UvR1NuRzJvcTB2dy83RVMwcHlhcDZydGpBeXVlbEE5ZXZ6Y3pPcklLb1NU?=
 =?utf-8?B?eFRrUEt5OENqbGRKZndSa2NMb3RZV3YvejJuanFJd2FrbUw0YU9YbXcxL0d6?=
 =?utf-8?B?bWdlN2hFcnNubEU2ODJkdWpoa3NJdnFNdkRjMFZvUVcrck5LcW5xbGJZU2xx?=
 =?utf-8?B?S2xFaGZiNG5TQllMWW54RUwweUt3c1JLYlFSUXB1cHp0ZG4walM4d2ROVzJq?=
 =?utf-8?B?Y2NTdDRHWUxpREZTZitsUmkwUVFTZE9UbUlscXNIQ2ZJY2RJSkx5cmpyVHFL?=
 =?utf-8?B?RHRMTGlCcWlqUVpzYVk3dVAzbUprWDRTQlh6ejhwUVBCMkx5NUREUWIyMDU5?=
 =?utf-8?B?S2xkam4wbnQ3cC9oZ3BsNWJLODkwS2dlTy9tL3RPd3J1VjBoaUF6K2RnUEdi?=
 =?utf-8?B?YnhXMkY5aTFKVGRYRVpXK3FwazIwNFNXQU04blZYWjZFMFEzQ0NWOEJ4MlNt?=
 =?utf-8?B?aG5UMUNUWkZud0dYRWZnK1ZkRWtNcjRrSGxVeE5qSWp2Nml0dmVvckZIZS9T?=
 =?utf-8?B?RFNwV3pOYkVFNmdiUUFlaGtUTHZ4N2oya0tsMFZDc25IaU9BM2hDejhmMTJO?=
 =?utf-8?B?VjE5QjVhUHViZXBwV2xsZnhkb042azFxa3hTSVpPaHNUTjZCdDc3Y2NiaEhn?=
 =?utf-8?B?b203ZGw3YzRoK0tDMllxYytscGg5YWg5S3hwWkE2UTliM25wb1dqdUdzZFRt?=
 =?utf-8?B?TXZ3VE1UcUZwYll6bGs4UjlLd0ErQ2FhNXVVMmxtaHhiNDdWTUNnQzgwZ0Vh?=
 =?utf-8?B?c0VvM1c5V2Fob0NDZVVPcDZhQVRXR1ZjQllVaENFbFN4UjRjV3lCTFV2TURp?=
 =?utf-8?B?TXRISy9tSFdoN0JDZWowSkFkcmJLczRTenBwdTd1WHlyaVFnSXIveEtuQi9j?=
 =?utf-8?B?MG5VN3VJMWV4QXNUaDdMelF2dnBsNVRqUGt6YVgwLzdRaHE4NmozUEY3c3R3?=
 =?utf-8?B?VHdSL0RvbWtNQ0ZYUUUzVk05OEswdVFoTVZVYVJaS3Rua3NsZ3R2UzBFa1h3?=
 =?utf-8?B?ZWZSM2wzdWMxNTFqU0ZnVjJYNkJUbkxnMzZWRHQzSTBoYUEwOEI3SXk5S3Jo?=
 =?utf-8?B?Qml0eUhoNTMydWJubnJDUEJjejkxVzJLdkczc3BSMTBTSTA2UWhZOWoyeTJw?=
 =?utf-8?B?VmpLYldwR25nMUxWVVB2dXNIUTRpM1p3dkcrU3R2eEgzY2NOVWdWaFViVE1B?=
 =?utf-8?B?R3NucXhBTE5Oa1FheTZVM3RCcnFyVVVZa0JJRFQ4dFUzbWd3cGVnQjhkUlFr?=
 =?utf-8?B?SXZSSktYUmZqeHdGOSsyWGRxS0xmWHoxZDZOWmQ2NDcwU3Y0Zkd4cHJTTXAr?=
 =?utf-8?B?RXI4NHZ5OWxOSDVVRnIySWQxTG96OVNDRkw5UkFKelZVNHQ2Y2xuMGRERFdC?=
 =?utf-8?B?SzBLbmlSVUZFQzAvLys4V3VNS0hNYTFYdnNpMW9TdW9MU0l4UDJ3MWhLV3lN?=
 =?utf-8?B?Tlc1VjdUYlp3NUlmRnczb29BNEtyUzRDZVd6ZmhVc2hDSlNYSnUzTGpDaFI0?=
 =?utf-8?B?K012bWh4bXZNdHhRdEdReXdhWnJEOTFGQjR6b05TbUVtcE9xVnh1K3RQbnBr?=
 =?utf-8?B?NGI3RzBZREVMWTFNdGVhR2FFN0ZkZGhWVm5yazFoNW5UdWFac1hmczQvL1Vq?=
 =?utf-8?B?amlDV2dzcTJwQUpXa2w0a1c4OVVXSDFMejFONlNxZnc5WEhNRjJLY1U4Z2hm?=
 =?utf-8?B?UFE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <EBEC37DCBC826741A41B05E0BD088CFB@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	BDqjt9XmKZ0ag2wT88WGeTlr4NZZmEPR4jSoE7k8+0cj49l2owCxBb1pkNQ0KXVjv2ViK222c56Pzp1Hb9BJQQtdZ2KCMj6w+V49sS/xHawBiB6IuieMeFvrhw0hnM9vrR9AIJJt1Y+8wIxTDtTPGaFsIn/ra/cwJDoAuwtIRxH0BrOVcj8PTWEoXiVHkKoaVwse7gDmwUCgS8d+XnbanW1IwBcaYYy4KX72pHzkwcGtqOjfwSprq08NoD7JI3uohM80zuI1ZiIsjrs1m7zAHJkrCO9UjgIBD02vZ43g5GBvfOD/bJht1kDD8UmRhi1iDBATFlOrGXgg8GoNimSxiZYnQqNFTtTt35KL/4l4dzbdrNiHKmDr1sljO1rw3ExpGWbRTo7bNKPIXzOYA4ZY0uksqhvi7CylNzlAmD8mpK1+YmKfq2G+Ic+se/tGx7ONGY6pSUrCk4Q96/w61ZXX2CVIu4lJdgwGbrFTExwIL9DwZEK8nVcUMJj9uMv3g/9mtnVYMtPT8x7dkZ+VSfawqEgcjk/LvBanu/ujRAuQFGQOwBuQFd2H7G75l/IsNGG5CvPyt7ZlZj/v+FegXcJMymm1ETWBhfhkrSziqyXz9550bVyjMoiF5CkdaucKifCo
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eee42891-d9f3-4dcb-211c-08dd7663bdac
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Apr 2025 06:08:11.2247
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ljQMBOBOk+VGfsbLIhRi9qStjLwe9GIcLvEhj3W4FVs36eV8j5YI1K7oaBABVfgZQzu/jSqOWe7HC1T8lvP/I9h5QYQprVomyQDCB06V49g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR04MB9426

UmV2aWV3ZWQtYnk6IEpvaGFubmVzIFRodW1zaGlybiA8am9oYW5uZXMudGh1bXNoaXJuQHdkYy5j
b20+DQo=
