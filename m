Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFA0B372B39;
	Fri, 24 Apr 2026 18:48:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.158.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777056536; cv=fail; b=fGUhGaIdgrjsk3WVI6+QrLlbVd0AXz+/7qix7izokKyh6IYMjhkvpnIWH+bJ9ZSA9geGp4ctXh9mPHoAJ3X6ryCHTw31pr3KWEZ/t7WURuzNgJztI1i5D6VXgh9zOl6xGiur2gJGaFJu9CmAm6e9ase+4ksBRo9jBbwLpRlH3Fk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777056536; c=relaxed/simple;
	bh=AWBjw/l5rDqat2M257JMlRGSm58GYc8HGwE2tZyWdyQ=;
	h=From:To:CC:Date:Message-ID:References:In-Reply-To:Content-Type:
	 MIME-Version:Subject; b=YsIc+RCTN50bpKtU2e+wmKHUHpLWhAaRnfNOmb2peFpre2wHoZYA4SbtDEzn+pg/+lFyZukJIujCJ7hGuv0+3tOxr2TO5uzSvY6k9aiHzOK2Xp20IaYdH/5t9g8b4KgkX01VgNVw2lyVZ7kAoK4iYiRsgMOvDQsJv0VrecBoXao=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com; spf=pass smtp.mailfrom=ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=nXPkMrs8; arc=fail smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="nXPkMrs8"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63OBWtsA3107426;
	Fri, 24 Apr 2026 18:48:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pp1; bh=AWBjw/l5rDqat2M257JMlRGSm58GYc8HGwE2tZyWdyQ=; b=nXPkMrs8
	ygd8pyzN4Fdihgfnc1Yh4PoZkemO85pwXeSJkRDjoLAk9jwL/njy1p0yQaSLci3T
	J/5rA2DySu3IwY0QbvIpr9z9HmSBXN7hM6i5E7o1yXGi83H6ITeg8I8H5RWxShQL
	sFJ2D33Rli3Ra68uehQKAvzs+CgEKaoGx8J8dw8bYFJRm0ZbM6d/y18YYjxD5mbE
	elhw4zDE6HTSuN/iUl1iYN6dnPF/VTYuLQ6zWJzMFGjhtcDOOXv8fe0/QHWAdOJ2
	MRszf46oZMusK/8FcVwhx9TPMeuQbHV0uaTwA3liEVdf+vWNRd8mZj2ScLotxrMV
	ve6yxpwoTzOnEw==
Received: from dm5pr21cu001.outbound.protection.outlook.com (mail-centralusazon11011067.outbound.protection.outlook.com [52.101.62.67])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dpeu6pg8d-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 24 Apr 2026 18:48:38 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VP6gyPbTJUezacxiSxjr3AaVSEBvi5q1BGYR+uJfVQDuupFmbdQg85fkGBXO0IM0y8P1a4J2Bn/t8NKzlaEtokLa5QlHNnP/6E+4RDdVfThEr8/aljSg2aE6/Y30rkNvO6qXx5aWkKzX3GBJuNfIf1LL99Aahr3u63ImMdy3LLML5ZuLFlr2v6K0pBfOpnbfNL+Kj4Vk3Cyaic05gHQxRXcV0RPpDyuzz1oQKpZ8CjHWMw8TiauO4BfsfdfYdcuBHqJtqnArsQi1ZWFVd+6Dqu2z/dzs5Icr0cgxOBkXlE0vleBUaAjjkE9+p2ktqGuqN/R18OZ4qyH57mVAhuhneA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AWBjw/l5rDqat2M257JMlRGSm58GYc8HGwE2tZyWdyQ=;
 b=k0F+IoRquY/e1tYjMArEdoE+roXGx3jcfySaEvG64Vx/VNt2pMnCDV1cdjSiyDxpGVigc9B+LXs1zy5rCH+jRCUccD6jDKrMxkyBj50jWnM0KcN2xXEZTM3c01qAb3Ffy9liwEOHrXn1SAcNxD+S4XROzcJEwqLSeUzNqxvO80eTa3hC/T8YQHiaK8tJaP0n3CjBFzUQpnkeWb25lkPwj3iAogOzIwYXScyInuudXqFd0LTrzuMWwWCsf6Ru0Q1wkbgn8ZYYiAvvONe0SNMy+G0NtsYyyI7V2+1nVfkgqL5kFZTHseg5m5B9ZCkW0vrOu0RQ6irX+A0k3+V4PoDIDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ibm.com; dmarc=pass action=none header.from=ibm.com; dkim=pass
 header.d=ibm.com; arc=none
Received: from SA1PR15MB5819.namprd15.prod.outlook.com (2603:10b6:806:338::8)
 by SA3PR15MB5630.namprd15.prod.outlook.com (2603:10b6:806:304::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.16; Fri, 24 Apr
 2026 18:48:32 +0000
Received: from SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::920c:d2ba:5432:b539]) by SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::920c:d2ba:5432:b539%7]) with mapi id 15.20.9846.021; Fri, 24 Apr 2026
 18:48:32 +0000
From: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
To: "idryomov@gmail.com" <idryomov@gmail.com>,
        "johan@kernel.org"
	<johan@kernel.org>
CC: "dongsheng.yang@linux.dev" <dongsheng.yang@linux.dev>,
        "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>,
        "axboe@kernel.dk"
	<axboe@kernel.dk>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        "linux-block@vger.kernel.org"
	<linux-block@vger.kernel.org>
Thread-Topic: [EXTERNAL] [PATCH] block: rbd: switch to dynamic root device
Thread-Index: AQHc09avEAA1hC0vnEm7dyjQBbLXvLXujjcA
Date: Fri, 24 Apr 2026 18:48:32 +0000
Message-ID: <ac8ef2a52e42512d17ef3e29cc94353c191c6846.camel@ibm.com>
References: <20260424103931.2616903-1-johan@kernel.org>
In-Reply-To: <20260424103931.2616903-1-johan@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR15MB5819:EE_|SA3PR15MB5630:EE_
x-ms-office365-filtering-correlation-id: 73a9a896-fb5e-4e9c-0136-08dea2321595
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|1800799024|366016|10070799003|22082099003|18002099003|56012099003|38070700021;
x-microsoft-antispam-message-info:
 7bQhQY3JzV9tucF/3bxb2BoAMzbsZHZbS3xwRiPkDX4hABk88ruCndAgyjxFvdXIKT7PrYDDxLVIKmVWKRb1zFFZ4x0NLx7Kp8Z2M/xRcv3S7RWU99YY4G3Ziva0B+Iq5ekbkwbAYVVpGCwazrkb6+Q5LeTd0t582XhTYtzGsP9mq7jnEanyXGfF3DsBRMk8oUAWsvRO/QsuszBTws082C8Bhlms8kBnPMQccW5O+3EG7RVLMXV9Pc056oVmP+F2t45Qe6hoQp0t8IB8T+kraMWEMP7hg+9dOzgSvg2gnhjp3rGGZLrqXvgI0K67ISWbLYK4/hp3zkdg8OhDCGmAnlVYqSZ2rjgysREAp9+whfvAG9baz/2BD1kXcCw0gjMmSYdOVNxi/T6A2qKUy2Ho59N1TvGrig5v0YDupdCsNGqK+e8mgpKuaMycBT/xoxYVOEr8/oMiNKWepvzCSqLc9d9wjsFVRz822O+Q/4o4l3pNiTIAYzTa0Nrs4lFzqgCxkNmGQxE19H7FKR8m2uUMEFZu1/OEDKlGnDeT0AJIJHaCDvlE3crcfdt+iMz2yihBwxbccnAdjIr+bQfS/zlISzts+D/2olHi4ZmzP5K5nweJ6RdyY1MdyowBQQyEf/vAp6pJvfkJYjkSRuY5Fv2drPl4VljSsZDl+OuJLgFiXKTR/AqljrV8NrhQ1/jfKtiAvEw0oIMt5/eGwq0G5KxXX6s9iUohMheX6hY8P30dkt53+Fh9wzT565rJXitUXmUp7QUlJU98h36OgTiGABTEYAt+f6mmjgUGluLHE3IDepg=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5819.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(10070799003)(22082099003)(18002099003)(56012099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?a1lDZzVsSmJMWjRoVE5rVjY2S2ZPb0RIT08rQ0ZZcjdNQllEVWNLOW16WmlR?=
 =?utf-8?B?ZjZCQXl2YW5IcFhqUk13MmtrRWxaMnNyN0RpTE1NVTNVNW1IdWM2ak1mcGho?=
 =?utf-8?B?eFFsSElSUi9QRlpzdkdFcEtwK0tMNDJYMDBaVkVleWRtSXpKL0VlOWc5dmNk?=
 =?utf-8?B?eEJlTWRBNDdScVdVamJNamZXVk8yam93WElDZnlFYXFqV3p5YzlFUzNlNzRG?=
 =?utf-8?B?M3BZOTVKZnNTWDBxdjNsaWNzemMxR1YvSnRZNWhjdjRZOHQ2UmxRa24yUHJV?=
 =?utf-8?B?amwrckh6bHFSbllEcmhmOW01WHlocmFQd0JtNHU5cG1xOVRCRDlRSUxmUmVq?=
 =?utf-8?B?S1Z2SzNseXRnb2VxemtLYXNJQjdnRTFiMGplWXhrL21hZVFwajhiV1lpbUJL?=
 =?utf-8?B?U0xvOElvT05CQ0YzNEJPcDMrdzcyQUIvTHlTWld1S0ZTRitMTjhTbVJRM0dM?=
 =?utf-8?B?NmV2eWczVm5BYnExWFhBWEI5K0Q2ZHU2K3hodWdndGFSeFl3b2d1ejhSSzJl?=
 =?utf-8?B?RWR5MjVObk1MNmp5MWRhNkR3UVl6OXF4VzV0emNlWlBGS3NmREM2aVo1UnRB?=
 =?utf-8?B?TkIvc3RWWWJiMCt3REdvUnVibzM3aFRxOGJ1ejdrbjRMRHZWWGowQ25peG8y?=
 =?utf-8?B?eUZ4ZHhJbzVvQ2RTbW5ZYjkzMTFrU1h6RTJNL1M4a0VCK21LZkZmVHBmT2FF?=
 =?utf-8?B?TTB1M0MxazJLMlBwL252VlE0czlTTVdNdGlXcXZrVkNNdlVqRnNUUzN2K1A5?=
 =?utf-8?B?TjRqSnVwcEM5dm8vWVowQ1Y3ZDFNUFp0RVdjUWlZUHRIYmt2WmZMMnRvUGZQ?=
 =?utf-8?B?RjgwRzR3VGc4UkV1NFN0M1BPbzdXVkJKZkZzQlV2OVdqVzY2S0hzWXdEbXN5?=
 =?utf-8?B?UXVHR0dWYmxzOWxXSDBVTC9uQmtyVTYzZjBtejZUZldqNDR3UUhIVk1CMGNv?=
 =?utf-8?B?K1Y1R1lPbUJBWTZKMDdCdmhmR1QxdmU5cTFqUUN0L2srOERZeGpXUWlJWUxm?=
 =?utf-8?B?cEhGdlVCTFNwTmU0RmIyakhOOWpNbmJBRVlOL0oyZnVicVZhL3JQdEhEN2dO?=
 =?utf-8?B?bUdoelU2dmxPUGhYalNIUC9aR1pQNGkvTnNZM3JLWVRrWWZJNjhWSHNzeUVD?=
 =?utf-8?B?MEUwUE56eWpSc2ZCS2dyWjNaTmppREZlbVFwSHdZK040REpHWm9JNUUwQndW?=
 =?utf-8?B?U3paOW56QVJwbVV3VVBiMEdFa2p5Uk00aWozVzJPMmlHbllQNHQra3ltMWds?=
 =?utf-8?B?OHdhaWdDQ1NGbzliL2FlSGNvN0w4d3ZkcDRNOTJaV3ZqTHdzK0h0d1pJdmFV?=
 =?utf-8?B?emtmenh5MkxyT0RYY2xEamtLaHZITGhXVk9JM1NVbVp3dWZqUGkrWWhBRWNn?=
 =?utf-8?B?YkJ2K1hlQkJjekZkTkttTnFQb3BJdVZSRjZWdG50Rnp4UE4vVmgwRytTMjZK?=
 =?utf-8?B?eWpIYTdrTjJsVHhUdG1oVENic0d1U3doZnl3SzBkQVl2ZlZpYjBhNGRNWU1N?=
 =?utf-8?B?VzhxTUJWaStKWWc2UmR0Z09ITmk1bWZTL2FDTFdmUi8zQno2VFVVY0pZNGF6?=
 =?utf-8?B?YzRqTk9WaUNwaHhMNXpDbHFyR0s3bnBtK2ppaTY4ZHVFRGRyaVFHaXdLZWRr?=
 =?utf-8?B?ellIOWhoS3pVUis2UVJ4WklrRHFmdTlzeEd3N0wrc2cxRG04NGpLaTAwU0Q2?=
 =?utf-8?B?a2wySFM1WDVwSXNXQlVJZWR5WkF1VFRTQnJEYWx3ZHU5dk55dEkwOHEvamdy?=
 =?utf-8?B?M0Z4Vk0zbEd2K3JqNXdtV21laGFhV1B6Q05IaGIwaXVJMFJFeUNLTjZyRnFh?=
 =?utf-8?B?TG1aNVh1MDRjYS9ZR3l1M2NRenBRd2lWWUl1NXcvV21JQy9CYjBLSWJsY1BF?=
 =?utf-8?B?L0FjTHVYM1NYeG0ySnJ0TGVwZjQ5MUE2bG5JR2QwZmJrL0dwN2svWWJXL0NK?=
 =?utf-8?B?bjVSRnpRS016empxaEtmK09MV3ZETTVQL0I4eGdLc21XMmwycEdyazZ3V0RH?=
 =?utf-8?B?VUh0bytKVUR6bGJZc0N2Q0duNHVKSG1TNFVyNUI2d3JpMTNVcE0yUERtNCsx?=
 =?utf-8?B?SUxLSE9mMTVlYkdPOXFKNURaaWtrTHo5NHFyVitud04vWTNsVjd5WVVvNGhD?=
 =?utf-8?B?NmxzdTZLYjBUWk5HdlVJanM2d09xS1JuMklxdlNZVFYvamZzZDEza2duNXow?=
 =?utf-8?B?S1AxZHhJajBkcmMrL1pZQm5rRU4xb05PbTRlQ1p6cTNSdUZKbDVOUXpyVlB3?=
 =?utf-8?B?ZU9OSVFNSkxCVnBDV1lGQmRSMk4vS2luaFpsVFpFTC9RNERla1JKdW5uV0Zw?=
 =?utf-8?B?WXV4aU9LaXZkaS9qaFFoUUxrVEY5cWJTVkVzKzBUdksyUmc5V0NHVDhGNGpM?=
 =?utf-8?Q?hp8Xpt2gpDW2W2Ifc2eQNLL4IwT4KBzJ2EWVK?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <73ABFFEA9E789A49A318B8DA089DAB9A@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	isztU3iqwoOF+iZde0HNhu2T3dfX74eFeZ8uol2biha2Wg+RrVhceVgS3cn7L34kmJOe+/QmtLRQQYHoCBypzq5GXqjwqK9wsNEPUtyf07ZY7BuYk8X88Ou8ESAufBNp0C92s0IsX3KONA0t+N6GGRBydxRN7qnaW4AbXrkZYArtaebbqiiP1PyW1AB6eHuM4jftOF87V41aRqQX214mhUZUFPPksyaCWweDobbZ3/6UcbN7bOk4ooTN5pznnooptmhwzvVOfNKpjbO2jROvFfGSfMubVMCu+7lU57uc3V2nyvYGJes+c55GGphkfF3w7mgpQQn8XkabNBnAfNw3gA==
X-OriginatorOrg: ibm.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR15MB5819.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 73a9a896-fb5e-4e9c-0136-08dea2321595
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Apr 2026 18:48:32.7062
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: u4QzweiSJeQXT/QNuRsLmnqhPxw0EzJz/JNjevjbQMXGuKiaxkhJTSx9gh7CVT3DVB+zZMMFaLiu/F+x5b8Fkg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR15MB5630
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI0MDE4MyBTYWx0ZWRfX4j8bk8Vliwr8
 CnWO4cRgQy5pJigHL1ayYI/cjinGwQKWpyX2d0QRfR4Vn6kHdNBQY702bahfsbipvpyLl9VV1eQ
 HFiA+W25Y5qHvmg4LVwKmcWvWVh3e0Td3ImGNwLAsWdc+W2vUbEDHfcIeDXq6zja3TJ/r6A+oPw
 fEKhGv8ukNlvaF2/gQKTrZD2BNTVXnmoyU3WZmCT0rHjbZ006HY374Q5T7CZ2ZP2aCCrgxWxEzF
 aFo+sCIi02iIXavAVUdxh7ljiMlA0LPw2SGJIrd6e6QjAcJddutEfr+RkHg/8I3zn54DgDnWoVL
 IyEgEp2uHMhLOgVgizRYDHD3D15TTDUPJLcCYnG63GBFoxF86sLrDWP8X1ayHKmUWVelbzU05Uv
 kMpAX2gBCbA+3dNKPSLOjmEMGeNlKa4zrwVmV3+dfSs5m9Lo0KB1LmwSCS1iy2+PBqL71y8kWYq
 AoEzOAqEk1ggCtIQGIQ==
X-Proofpoint-ORIG-GUID: bG_TD4ZDXi9LL_915FL6lHP4-7Anw3va
X-Proofpoint-GUID: tgTDGh2HtXV-xvMQvbaGEGCUNutzVJ2_
X-Authority-Analysis: v=2.4 cv=BYfoFLt2 c=1 sm=1 tr=0 ts=69ebbb06 cx=c_pps
 a=GcdpE1at2Es8HfJfZlkF2Q==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VwQbUJbxAAAA:8 a=daZStwMXCoe1VwiMu4AA:9
 a=QEXdDO2ut3YA:10
Subject: Re:  [PATCH] block: rbd: switch to dynamic root device
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-24_02,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 malwarescore=0 suspectscore=0
 lowpriorityscore=0 adultscore=0 spamscore=0 clxscore=1011 bulkscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2604240183

T24gRnJpLCAyMDI2LTA0LTI0IGF0IDEyOjM5ICswMjAwLCBKb2hhbiBIb3ZvbGQgd3JvdGU6DQo+
IERyaXZlciBjb3JlIGV4cGVjdHMgZGV2aWNlcyB0byBiZSBkeW5hbWljYWxseSBhbGxvY2F0ZWQg
YW5kIHdpbGwsIGZvcg0KPiBleGFtcGxlLCBjb21wbGFpbiBsb3VkbHkgd2hlbiBubyByZWxlYXNl
IGZ1bmN0aW9uIGhhcyBiZWVuIHByb3ZpZGVkLg0KPiANCj4gVXNlIHJvb3RfZGV2aWNlX3JlZ2lz
dGVyKCkgdG8gYWxsb2NhdGUgYW5kIHJlZ2lzdGVyIHRoZSByb290IGRldmljZQ0KPiBpbnN0ZWFk
IG9mIG9wZW4gY29kaW5nIHVzaW5nIGEgc3RhdGljIGRldmljZS4NCg0KSSB0aGluayB0aGUgYXBw
cm9hY2ggbWFrZXMgc2Vuc2UuIElseWEsIHdoYXQgZG8geW91IHRoaW5rPyBEbyB3ZSBoYXZlIGFu
eQ0Kb2JqZWN0aW9uPw0KDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBKb2hhbiBIb3ZvbGQgPGpvaGFu
QGtlcm5lbC5vcmc+DQo+IC0tLQ0KPiAgZHJpdmVycy9ibG9jay9yYmQuYyB8IDIzICsrKysrKyst
LS0tLS0tLS0tLS0tLS0tDQo+ICAxIGZpbGUgY2hhbmdlZCwgNyBpbnNlcnRpb25zKCspLCAxNiBk
ZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2Jsb2NrL3JiZC5jIGIvZHJp
dmVycy9ibG9jay9yYmQuYw0KPiBpbmRleCBlN2RhMDYyMDBjMWUuLmZmYWIxYjRlN2MyNSAxMDA2
NDQNCj4gLS0tIGEvZHJpdmVycy9ibG9jay9yYmQuYw0KPiArKysgYi9kcml2ZXJzL2Jsb2NrL3Ji
ZC5jDQo+IEBAIC01ODAsMTQgKzU4MCw3IEBAIHN0YXRpYyBjb25zdCBzdHJ1Y3QgYnVzX3R5cGUg
cmJkX2J1c190eXBlID0gew0KPiAgCS5idXNfZ3JvdXBzCT0gcmJkX2J1c19ncm91cHMsDQo+ICB9
Ow0KPiAgDQo+IC1zdGF0aWMgdm9pZCByYmRfcm9vdF9kZXZfcmVsZWFzZShzdHJ1Y3QgZGV2aWNl
ICpkZXYpDQo+IC17DQo+IC19DQo+IC0NCj4gLXN0YXRpYyBzdHJ1Y3QgZGV2aWNlIHJiZF9yb290
X2RldiA9IHsNCj4gLQkuaW5pdF9uYW1lID0gICAgInJiZCIsDQo+IC0JLnJlbGVhc2UgPSAgICAg
IHJiZF9yb290X2Rldl9yZWxlYXNlLA0KPiAtfTsNCj4gK3N0YXRpYyBzdHJ1Y3QgZGV2aWNlICpy
YmRfcm9vdF9kZXY7DQo+ICANCj4gIHN0YXRpYyBfX3ByaW50ZigyLCAzKQ0KPiAgdm9pZCByYmRf
d2FybihzdHJ1Y3QgcmJkX2RldmljZSAqcmJkX2RldiwgY29uc3QgY2hhciAqZm10LCAuLi4pDQo+
IEBAIC01MzkwLDcgKzUzODMsNyBAQCBzdGF0aWMgc3RydWN0IHJiZF9kZXZpY2UgKl9fcmJkX2Rl
dl9jcmVhdGUoc3RydWN0IHJiZF9zcGVjICpzcGVjKQ0KPiAgDQo+ICAJcmJkX2Rldi0+ZGV2LmJ1
cyA9ICZyYmRfYnVzX3R5cGU7DQo+ICAJcmJkX2Rldi0+ZGV2LnR5cGUgPSAmcmJkX2RldmljZV90
eXBlOw0KPiAtCXJiZF9kZXYtPmRldi5wYXJlbnQgPSAmcmJkX3Jvb3RfZGV2Ow0KPiArCXJiZF9k
ZXYtPmRldi5wYXJlbnQgPSByYmRfcm9vdF9kZXY7DQo+ICAJZGV2aWNlX2luaXRpYWxpemUoJnJi
ZF9kZXYtPmRldik7DQo+ICANCj4gIAlyZXR1cm4gcmJkX2RldjsNCj4gQEAgLTczMzEsMTUgKzcz
MjQsMTMgQEAgc3RhdGljIGludCBfX2luaXQgcmJkX3N5c2ZzX2luaXQodm9pZCkNCj4gIHsNCj4g
IAlpbnQgcmV0Ow0KPiAgDQo+IC0JcmV0ID0gZGV2aWNlX3JlZ2lzdGVyKCZyYmRfcm9vdF9kZXYp
Ow0KPiAtCWlmIChyZXQgPCAwKSB7DQo+IC0JCXB1dF9kZXZpY2UoJnJiZF9yb290X2Rldik7DQo+
IC0JCXJldHVybiByZXQ7DQo+IC0JfQ0KPiArCXJiZF9yb290X2RldiA9IHJvb3RfZGV2aWNlX3Jl
Z2lzdGVyKCJyYmQiKTsNCj4gKwlpZiAoSVNfRVJSKHJiZF9yb290X2RldikpDQo+ICsJCXJldHVy
biBQVFJfRVJSKHJiZF9yb290X2Rldik7DQo+ICANCj4gIAlyZXQgPSBidXNfcmVnaXN0ZXIoJnJi
ZF9idXNfdHlwZSk7DQo+ICAJaWYgKHJldCA8IDApDQo+IC0JCWRldmljZV91bnJlZ2lzdGVyKCZy
YmRfcm9vdF9kZXYpOw0KPiArCQlyb290X2RldmljZV91bnJlZ2lzdGVyKHJiZF9yb290X2Rldik7
DQoNCkkgdGhpbmsgd2UgbmVlZCB0byBhc3NpZ24gTlVMTCBoZXJlOg0KDQpyYmRfcm9vdF9kZXYg
PSBOVUxMOw0KDQo+ICANCj4gIAlyZXR1cm4gcmV0Ow0KPiAgfQ0KPiBAQCAtNzM0Nyw3ICs3MzM4
LDcgQEAgc3RhdGljIGludCBfX2luaXQgcmJkX3N5c2ZzX2luaXQodm9pZCkNCj4gIHN0YXRpYyB2
b2lkIF9fZXhpdCByYmRfc3lzZnNfY2xlYW51cCh2b2lkKQ0KPiAgew0KPiAgCWJ1c191bnJlZ2lz
dGVyKCZyYmRfYnVzX3R5cGUpOw0KPiAtCWRldmljZV91bnJlZ2lzdGVyKCZyYmRfcm9vdF9kZXYp
Ow0KPiArCXJvb3RfZGV2aWNlX3VucmVnaXN0ZXIocmJkX3Jvb3RfZGV2KTsNCg0KVGhlIHNhbWUg
aXNzdWUgaGVyZToNCg0KcmJkX3Jvb3RfZGV2ID0gTlVMTDsNCg0KVGhhbmtzLA0KU2xhdmEuDQoN
Cj4gIH0NCj4gIA0KPiAgc3RhdGljIGludCBfX2luaXQgcmJkX3NsYWJfaW5pdCh2b2lkKQ0K
