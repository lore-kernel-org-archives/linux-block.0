Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2071.outbound.protection.outlook.com [40.107.237.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4D8217573
	for <linux-block@vger.kernel.org>; Tue, 16 Apr 2024 02:50:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713235843; cv=fail; b=rl7WxgPfAUC04oHQ1K6jg2fBRWCIEBgbDOrgF3nL9vyWGZj+ok9LXHez0HopLuRA60A6FqfNXEJKJGcjHwOIMN7u/VRRDhnTY5fvEhyXTaRPHwShnmUcT6bpMgtEPeYqU0RI7Su8AcLsc7L729M8m4lNTogBfBO1e3MyTvYPNvY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713235843; c=relaxed/simple;
	bh=zjplC4un8dmkR3q92XqKMXIRgMWmQo9UV3uh5FvYva4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=K1LqBXBVsssVGf9YJJAR8+AZZzKPG4A4SlIIfBW+2BGkduOkUUFDdiJV+fjHxgq5XhnIDmDquVkcbUqjqYQSUV0S7lkg7X5WXaM1603Yi8OkaBubQRvCCOhZF2Csf4dKGBRwgioQ1GR/9BbBSSYAo7iIGpuj500pV5NlrYUEtSI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=gU4aGDOD; arc=fail smtp.client-ip=40.107.237.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="gU4aGDOD"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e4tosj1jdqvmiSgMDVzU12W6Mn5wWBshDuv06BF8aNC1+BGxh4OfVPhZhamAgCX+RyqoWiZgUuWIoakjrVntawVHRAonShD0VAJfLKkKp3OznV1LAnNI+m9+hKmYJCwxZs2ZuVWB6SeNwFtOkX/X2YCSbwlH/kdi66mritZKtYmu8UpsyBdDV7YAPKa5nbVl3dfa63QPjw5xowkioABVh9E4LhXd+ZuHuwGm1Jjptfn0lpXelhQuZKpEwVCzWDKhRyaH1IUCc4+KGgLDpkuF1zJh7N/RRBRR3Wdn+k5iL6cT/X8XRksBWSBzIWSgWaNeB3urE5aJV/01lC4qxwZsew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zjplC4un8dmkR3q92XqKMXIRgMWmQo9UV3uh5FvYva4=;
 b=cidn66d4xp3WL5peqz43srewhVuI/A0M+lfO5T/jIX5xp3TT32C7gAKVOa1DfzYMo9eEurXKxPTi5VH2ozlOHaZmGdULv9jmhTVYyseRmhBvz4vmaE1wCB5rFqPX10Vh6Akm1NTytJhmD86DqF/tHsyufcZlp+Hg/fkRUnL+Y//4rug2Csi68c5j5giZLRh7Q2sY/deTrmtlOHFBLX9htC4uTzIxwOM8qEAPUDnokfczi4L4nu1paPX066emuX2qrnS7nnU3F/d98TVuUYaQBinj8ftHjn5zjCmB+ES3/lCjd1J7Ew7XlPEquC2raxJYVHN+O1sLadEwnCMmMhiopA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zjplC4un8dmkR3q92XqKMXIRgMWmQo9UV3uh5FvYva4=;
 b=gU4aGDODb+A4vCEb0sZSnJjnwPEcVLvbc+0fCX14BCLmZhiA5jBJ96HnDq5XqP1/rlUrdOW0zjaTM8x9DB3C8xf/RTWntuPxmWrLjLVAbZE3z/k0lkZqhDxz6IZdtJZUv24sHhedWctR5D5nJx6z2GYsd7xSVXqYh0yoYLBuAesF0hGl+bmkmYd+mlH8lrwOD2QxQs7b09g3J6De3Z1CFehlmrxltnQKYBWPVpX2NhN5DKGYvzqv67pXmDcIMLkSsuM7L3DQA1fjKJC8hfC6KarWtwxVGEtPGe+WxRZtEpmEEr7c3qcOIBa6FDiEc7ze/srAe53oq8obqD2Ze6ia0w==
Received: from LV3PR12MB9404.namprd12.prod.outlook.com (2603:10b6:408:219::9)
 by SN7PR12MB8129.namprd12.prod.outlook.com (2603:10b6:806:323::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.50; Tue, 16 Apr
 2024 02:50:38 +0000
Received: from LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::a1:5ecd:3681:16f2]) by LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::a1:5ecd:3681:16f2%7]) with mapi id 15.20.7452.049; Tue, 16 Apr 2024
 02:50:37 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Daniel Wagner <dwagner@suse.de>
CC: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>, Hannes Reinecke
	<hare@suse.de>
Subject: Re: [PATCH blktests v2 00/18] refactoring and various cleanups/fixes
Thread-Topic: [PATCH blktests v2 00/18] refactoring and various cleanups/fixes
Thread-Index: AQHafF/jk7TRMlGGbEaIXsrxLSLfrrFqWPiA
Date: Tue, 16 Apr 2024 02:50:37 +0000
Message-ID: <c189008d-b07f-4930-86df-4059ef4750d6@nvidia.com>
References: <20240322135015.14712-1-dwagner@suse.de>
In-Reply-To: <20240322135015.14712-1-dwagner@suse.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9404:EE_|SN7PR12MB8129:EE_
x-ms-office365-filtering-correlation-id: f42d8080-7480-41ea-8fe6-08dc5dbfff16
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 lXuleGAh6xsGD1L0cGue3qtJqfTnGrjm8zeDGeGWvYxIJT1eCmrxZxx4eLSNbKV++GC6F785GK9Jgd1Vqo00oEhIzNaioVQn1v5Jfq/kLWCYAkPMEmp32EETGSUS/M8HXoLPWYgn+k7JqC+FhoHP9DT/Njr1NZjBanfQGu5vMSJy3TTtkFDOCCOzaPrV9fJOmxg/zQaJ9n9zCab1LoE8/jUrAZHiGYZtnjNI8z00Xhl/xbCEmtc897ZpNDhVKAgc+jug+34mm7Vid0JIEqj9TMIFoneQUbseDUDQeE5gpBWuhw7DloTEYW32tYVV5kAMK+cRV+0g/DB/FO1F5b00NV7gViGFg/BHucUvZ6buuJUkpVn0QExEP0cm9CdW+01BMs+aJ4XI5h1Fa/rVma4w7XyLtsqIdapsTcH7R0/C/wDPKAsNpXMJ7gY1GQi3pCMrsDBtddpDBHMAJ7IbAsxJ7tyjGSYtOtOYq/bWJud7mNJ8k2UQpsGy3tDzRInLMD85XzYZ+GrwmAqKCsTXtZ00V0ffTkC4+HCtNSV0yC7NPgFBPryeETaIHj4y3Xl+YnX+H00n4gUtW+urNwqez697skQNRvt3rwB+gaOvNEExa+h+rdLOokNE0zpvJ8wL0W3SdKrzFyhk8p3TEP9jt75eEgbndDK1nEvCiV9yVKhwK+IsPPFAZDH0LLFXfC0PjUISN8+9qq4eg9vifkjrFNwxN1EiyUQiU300BwZzzdPfNyE=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9404.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?amt0ZUlqQWswZlBvSXRhcURpc2RuNVoyb3kyZjU2ZmkxcW5tTzQzcHBEUEZz?=
 =?utf-8?B?bitpdkZ1N1RIRU5TbkQybVRFWVJlWDJaOUZNV3lodWZRaUJub2o1M2pxNWZk?=
 =?utf-8?B?TzVjZG1sUW11WkJMUU9qaGFkOGo3RHRlYldGRkVvcndpWG1nMlJwRkszVkt3?=
 =?utf-8?B?YXRWS0NWaHZ6S1RGS05sZitwb2NzQ1BacGNvNFljbXdiNjhmbTNXa0ZsamYy?=
 =?utf-8?B?b25OYWN0WFBYTDQvYnRtYzAzRGJtR3NiUFJDWGlXZHF2SHprTGNlajgrWVJk?=
 =?utf-8?B?YnRmbjRIMW55eFMrcjdWd1lQRm9pL3V6NUljSmdLcXE2WFhrcDJZbVRHVkRS?=
 =?utf-8?B?OGNhRERoWTRwbmxHSWxCZjdnanpWWTBFdS8xaDAxQWpVTmk5dWlDK1pRZTdK?=
 =?utf-8?B?bDJscVN6MGtCcll3Vm1TcExIRm1wdkVTUmhjTVE2SDFMM1Z0VHc2T0xjYkhN?=
 =?utf-8?B?UEhweFozc1VzSldmRHBpcnlaSW9JMHdWNDVBTWxkNGp6cVhKdDdUYlFISXl2?=
 =?utf-8?B?Sllhdms0UFJidUdRMzViaGJxMHMwVHlwNWtkb2hjSjZVZEVsa3luWHRha2VH?=
 =?utf-8?B?RHdEZzZONzh2SUo2NG5UejBlWDJyblZuMktsREVSd0tORXdHZVJzU0VVTitn?=
 =?utf-8?B?MDBJRTBYWW9nWGlpb2VhbVNrT0E3WFVNZUNHdVoxS0xhcW5DdUREbmpKTlZm?=
 =?utf-8?B?SW1sQkoyb1RRRTNWRERwTVVQTSsweFRtUTREbGdSTlgzalI4TlBROHBRQ0l5?=
 =?utf-8?B?WTVCbVp5aUtzbmpGZ2RKYVcxY1E2WHBCUlZiOWpZaFZtdFE2Z0NqeDk1UGVP?=
 =?utf-8?B?KytZTW9SZ3pnRis4NlRUSDFPM1NhQyszU1Q5d2thWnZCTUpQVTJ6NE5KZndL?=
 =?utf-8?B?ajNYd0QyMDVLd0wwbnN6Zk5vSEhOMk1ucUpKdmY5czF5WEo3Y1o5MnJzQTM4?=
 =?utf-8?B?QlpSMTdRaitrSkRUNHJCMERxQWpqMGhudnRaQ3E1NXp1cllLM3kxN0hHTjB6?=
 =?utf-8?B?eUNyMGFZMTJQN04zZEx3dDdwV0JSQkVoZlRSMW0zQjNKTjlKYy8xMGpiaUdK?=
 =?utf-8?B?VUpjbGhLUHZVUXNXNHc5MHQva3FRR1VOWWRhTnRHaUd0UW8rZGFRb3hwRFlx?=
 =?utf-8?B?dTMvbWZvZDhmSk9DL21NQ09IN003VEd2dWNZMXJKVFN6a0FOUk1Eck5XYmlj?=
 =?utf-8?B?SU40K3pEcTkvZnFtcElNUkJjNTh6WG5wQWc1TS8vV2Q2WGlDMURGN1lvTG45?=
 =?utf-8?B?OUFaUU55SjVhM2xpSjU0V25SMkdKVzFWZFpLMk1BN3BTbkRLbzFyb0V6d2F5?=
 =?utf-8?B?K0x2SnpRVWorSVl3L1h4eFZPQnNHQWdidGNKalFOeXB2Qyt4N0pCT3ZJS1Jn?=
 =?utf-8?B?ZFptSnNoR0V2QTNOWjhKMUxUcjVYQlBJdFRRc1c3RWoyUmxtaDR3K1EzZFNq?=
 =?utf-8?B?TGczV2NOak1WOE1uOFNYWkowb2U4cnMwM2ZxTlphdFlURTl3bFRtc0RGQktz?=
 =?utf-8?B?RWNzTHBvRlBrRGhnU3RnUlJBMzBGRlRDMTBnSlBzbVBYbjlpQzFONjB1V29J?=
 =?utf-8?B?eTUzQ3NxRkZ4elpqODFHRUpSODAzaHAyL0ZycHRkQytweHVXeFFJb2MrNVAz?=
 =?utf-8?B?TS9kOHNEUG9mVURzNHlHa1VqTUZ1NE1LWGlXS0RVNlNaRGlhcEtKWnltMW9n?=
 =?utf-8?B?dHlCZWMyNnJ4WVRRNElIc2RieUdiSWtXSnN1YnVlc3dibG42aUYyQ3JGVTRP?=
 =?utf-8?B?RlZ1a3FITnVEdG5ybmJITUVxT2xVOVRhRUJ4Mk1zamtRMDVrSldUUkRZMmNF?=
 =?utf-8?B?VkRTdW41c0pLeHNVS3h0SW5BeDhtZkdYaUs0VEtxTWNnanEwOFlENnphRmpk?=
 =?utf-8?B?ZHZ4VEZXQjBaMy9IZHdWQzdTM1B6LzNuS2pqU0xPWVlvbE5iMHo1alEya1hJ?=
 =?utf-8?B?UGpnc044RS8zWWhYVllIK3N1R052MkpHdWZGMVhQVTBLTmVtT1VMMVpyUlhM?=
 =?utf-8?B?WGdFRTZBRWdTNFl6TUU1dlpwNXdGdzl4UVE3MmdqY2tSak9ubWhVSWpEcFEx?=
 =?utf-8?B?OVZqNzhNUWU4VnVoYnhIY0E3ZmdPKyt0bmd1RXkzMEZrdnE1S1RJc3MxbTdy?=
 =?utf-8?B?c3ZuaC9KaXVkbmowOThwTVZxSHlWNGxsVWl4d1QxVnFIQS9JdGg5MkV6VlEw?=
 =?utf-8?Q?l0/ejoYjdiEi2IWDu5/BjESBTn44gXE/w0ZIIEuzb03q?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <5AC0BAA95EB90845B49633F5E9955CAE@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9404.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f42d8080-7480-41ea-8fe6-08dc5dbfff16
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Apr 2024 02:50:37.8963
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ngkqvhN3lT1cq+c+m3sWKHNPaMnpRzSax/xGvbwBIiumyEq3Ma3BCnDsrATKXtCrwKO/Gb4mNf2kxKi3/ZAMXw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8129

T24gMy8yMi8yNCAwNjo0OSwgRGFuaWVsIFdhZ25lciB3cm90ZToNCj4gVXBkYXRlZCB0aGUgc2Vy
aWVzIHRvIGluY2x1ZGUgYWxsIHRoZSBmZWVkYmFjayBmcm9tIFNoaW5pY2hpcm8uDQo+DQo+IGNo
YW5nZXM6DQo+ICAgdjI6DQo+ICAgIC0gYWRkcmVzc2VkICdtYWtlIGNoZWNrJyBlcnJvcnMNCj4g
ICAgLSBzcXVhc2hlZCAnbnZtZS9yYzogcmVtb3ZlIGNvcnJlY3QgcG9ydCBmcm9tIHRhcmdldCcN
Cj4gICAgICBpbnRvICdudm1lL3JjOiBhZGQgbnFuL3V1aWQgYXJncyB0byB0YXJnZXQgc2V0dXAv
Y2xlYW51cCBoZWxwZXInDQo+ICAgIC0gcmVvcmRlcmVkIHBhdGNoZXMNCj4gICAgLSBhZGRlZCAn
bnZtZTogZHJvcCBkZWZhdWx0IHRydHlwZSBhcmd1bWVudCBmb3IgX252bWV0X3Bhc3N0aHJ1X3Rh
cmdldF9jb25uZWN0Jw0KPg0KPiAgIHYxOg0KPiAgICAgLWh0dHBzOi8vbG9yZS5rZXJuZWwub3Jn
L2xpbnV4LW52bWUvMjAyNDAzMjEwOTQ3MjcuNjUwMy0xLWR3YWduZXJAc3VzZS5kZS8NCg0Kb3Zl
cmFsbCBpdCBsb29rcyBnb29kIHRvIG1lLCBJJ2xsIHdhaXQgZm9yIFYzIHRvIHByb3ZpZGUgcmV2
aWV3DQpzaW5jZSBTaGluaWNoaXJvIGhhcyBzb21lIGNvbW1lbnRzIG9uIHRoaXMgb25lwqAgLi4u
DQoNCi1jaw0K
