Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.201.59
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795647696;
	b=loPKGyBnaa59hGFJhu3330hgxHLpGyIMRuAngINtwwBlnFwZROgzdprV7FCbMCdwAs/b
	 jwZS31997LTlKwiaDgNScOd9QW1Z3qJbT16p5aj7rXpvpuEOzWRKY48Ej9lGboaerfXcn
	 0OZgvViOyAjH2ACYUg7MO1vrscbK2ox/BzX5XJRfm+2zMO1pIOcFCeiVFVPNDQDGW79O9
	 plU7UVaKLixVlnhrjGU5EdbT334WfH1rKE0t+T4FGs161uG/SLc2OMr5OXwTkRIfJdL+G
	 BmrvV0lsHHY1JXJKjvlf+W8m6Uz+KQgBmOtSr3FRXRJZ900uTUrUSL34Xr9eREYuE6Q==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795647696;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:CC:Subject:
	 Thread-Topic:Thread-Index:Date:Message-ID:References:In-Reply-To:
	 Accept-Language:Content-Language:X-MS-Has-Attach:X-MS-TNEF-Correlator:
	 user-agent:x-ms-publictraffictype:x-ms-traffictypediagnostic:
	 x-ms-office365-filtering-correlation-id:x-ms-exchange-senderadcheck:
	 x-ms-exchange-antispam-relay:x-microsoft-antispam:
	 x-microsoft-antispam-message-info:x-forefront-antispam-report:
	 x-ms-exchange-antispam-messagedata-chunkcount:
	 x-ms-exchange-antispam-messagedata-0:Content-Type:Content-ID:
	 Content-Transfer-Encoding:MIME-Version:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-AuthAs:X-MS-Exchange-CrossTenant-AuthSource:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-originalarrivaltime:
	 X-MS-Exchange-CrossTenant-fromentityheader:
	 X-MS-Exchange-CrossTenant-id:X-MS-Exchange-CrossTenant-mailboxtype:
	 X-MS-Exchange-CrossTenant-userprincipalname:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=Dh2mhLAucLFd/1bSwZ1ISoak4z6oxQVl5CKlMCly2Dk=;
	b=dQlFSwgldb2C0X9y02ynz6VA+VLfbdQLTiDaiyigb/48zY4A1XTBkEGkbMDsNLg4OUWS
	 ZDCBWVh62HUxEvlO2VbvrkmjyH969CYkKYNXrymQ3yOBU815Ym5L6SgJf0W8ZtpUJ/LFU
	 5XTYhU/pyLc7FtYq5G+SRNdicyAqI5pJkqsg4qEChwWZp2vVh8dg4EPXdDxh3lyHva3bM
	 8VQ2Fl5y5/+j24+wjiRCVrA7R24EB7q1T/B6fNzH5aTtXKlhaDSGGbucEG0xs+rlHvd7q
	 mBx6YL0xwDLvX/Ma81rdROqcedBreZt4opJtK0iCeXRSVMJK0OrTyxjLhI8kFVoJQZQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=TJ51CFjZ;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.201.59
Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013059.outbound.protection.outlook.com [40.93.201.59])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C735606A33D
	for <linux-block@vger.kernel.org>; Wed, 25 Nov 2026 23:01:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3C735606A33D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=TJ51CFjZ
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gOVDLPgI98pE8FXd1DxmjVNgLpHS7qel5p9KVPtig/cP/A8tHEDwWf69TFv2kRIO+Hm/r0Kv+V+zuJ3mT/0TkyFNjlexsclU8YFORNE1W7EigtWcZvN1YQRPv90ZuRlvrmSNUATwtU5lQnsDc2EZFMTnA26c78DBf/v/uq2vG229zc6GySRvrO4n0B+1WmD/hMpcDkJ3NpLws8SmxUdN5d1cv826sENf+1ZXcjZmDh1TSkjZE4yrRiq+wx27sx+qJqeSzDh8viiujN4CELAXihFm+s8UvTuKJAvflQy7WKTPxs3wKSZSkclJ2+6VU7YRNyyVyMuRcgi7DXvLQRqYUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Dh2mhLAucLFd/1bSwZ1ISoak4z6oxQVl5CKlMCly2Dk=;
 b=GybwiWXk5ZyJEU3MKa/FPSVIJWtYkZ9O4jcAdRp7Mi5spMAZJTh9KCEQbSYjgk7BB8e6be/ufVH3J5EwUUMCFq80DKWZucfRl2bZ7o3uDwc11aBAkOGi+LxfxG3HamiRd/LqRiO+JFstosvgSWOHbKnK9Jx7clqLbL2au3P+MQpo2wj8CQCRgzSZlOxkviZ22dc9Ij2LfJa9Tr7k2/SY2gtdWUeMpE2tLo52Ye2bRUfSeHTsMZs/GSRRVh9NulMxD1ms9Ky+XcdkqCVSz9GHjLGlbfsgFcUV4fNvHkQvdf4xClQlE79U50BXvrtcVemtRBdm3qB+rjPcf2TQI239rw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Dh2mhLAucLFd/1bSwZ1ISoak4z6oxQVl5CKlMCly2Dk=;
 b=TJ51CFjZ2QeqPA/clKoAhKTJNBkBd810zkhLGfdBksLscGGpJ0LKHHDzPuh/ijHBmZyUlnFJAO3S64cWJAutdJKOKRCJ+iI8o7Z2HCttw90qOY0vn6jwFhSOdKVU4nELin05pHHdP2Fl/mG+b7cSVhCJpCWiCv2fgJliM/qrgIz3WenwvB8aTQ0/FpU6USJR+O+jdGVjc4ZngD/OOOWaGXvpsoppAY1SBoA2koVeMkevwnGOMftny/xKhmlZD+jjkSDY0GiWcIZgyrIkozDm5d4iJKXgzgOsJxCq5wBxYi+dhDbUGazDQdRIKb1e5nE9tO7/VkBlY6rbnjaMW/y3WQ==
Received: from MN2PR12MB4159.namprd12.prod.outlook.com (2603:10b6:208:1da::17)
 by CH3PR12MB7644.namprd12.prod.outlook.com (2603:10b6:610:14f::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.6; Wed, 25 Nov
 2026 23:01:15 +0000
Received: from MN2PR12MB4159.namprd12.prod.outlook.com
 ([fe80::5f4c:13a2:f9f8:8aee]) by MN2PR12MB4159.namprd12.prod.outlook.com
 ([fe80::5f4c:13a2:f9f8:8aee%6]) with mapi id 15.21.0662.004; Wed, 25 Nov 2026
 23:01:15 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Johannes Thumshirn <johannes.thumshirn@wdc.com>, Shinichiro Kawasaki
	<shinichiro.kawasaki@wdc.com>
CC: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>, Christoph
 Hellwig <hch@lst.de>, Damien Le Moal <dlemoal@kernel.org>, Niklas Cassel
	<cassel@kernel.org>, Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH 2/5] blktrace: add iotprio recording test
Thread-Topic: [PATCH 2/5] blktrace: add iotprio recording test
Thread-Index: AQHdfBrKsGwGSrSTJ0yOQDSgOncNFbc/aYmA
Date: Wed, 25 Nov 2026 23:01:15 +0000
Message-ID: <e0e8a33a-7fea-4c31-ab6f-82461ad24581@nvidia.com>
References: <20261124135016.153657-1-johannes.thumshirn@wdc.com>
 <20261124135016.153657-3-johannes.thumshirn@wdc.com>
In-Reply-To: <20261124135016.153657-3-johannes.thumshirn@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN2PR12MB4159:EE_|CH3PR12MB7644:EE_
x-ms-office365-filtering-correlation-id: 6e78b5d9-245e-45e8-3079-08df4b48024c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|376014|23010399003|4143699003|261009223027099003|18002099003|22082099003|10067099003|261102123227099003|11063799006|5023799004|56012099006|261022105027099003|261026140227099003|261022075727099003|261021121427099003|261028144727099003|38070700021;
x-microsoft-antispam-message-info:
 Pn5yWPQ3ykwfk/JdIXujn4oKIOKdsRgQxQg5SjLHpLmSFlcTTE/+JJcwH4kJesM3xOvkQKXRUMKZ1F2Wmtju91jOc304WXXh9FyB49p6k6Rt3iIltVopNzj45VLdiADhZJQMW/04YnjhPIRu7Y/Xw9Sa4cj8qzCa0fPiW7z9GuD3b10YMp6mQWqS7eV6M5I8zVrzz7FNQA+RrH6pnw37YhAJrtp1hMuGaMWBH1rVwr5H26wWOqon/dUVTDBdd5JBLzNO0d64oPCycBQ/UsmnqMq0yLsYBZZ0jWu+4n3G84VN7t1wrC/tg+rGTEKiVADjQpwZ2kPOi/JMVRC6Qa+3ERRF1a1raI0KTNTCX3P12LNjYtHjewAH/O6QnynZnRuUrNubES9JgfVKXk8G/v0fQ3l/MADSDB9m6hblKV4mwWWZxbARO1fTkjnDy2XxDP/h9le0jeC1jwL5jRA5a6csjJklXq93yPpHqF6gnrDD3OFAPNW7YfdqFavfRWMu0va9GY6Sz05Cou06poadkVHccs8jgjUPEWwvDo3Erb8VTQylDLEqWiGWgfB/iLxkPW0pzHGux9jBzqm5irpjB+MBgO38jl9sOv5x2Z91f4HLahvn0gxiS9DFskAGhJIE6pjdjYgqHxr3bN4TemD7M8Z3jeRSXCGhzA0mu/HVxQx9MXBtvCyhoaJYGf/KOXSuawp5SWVd0aiKHo0VezcgPlCbO1IMAvlg9B8XWQPHHcLDMgI=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4159.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(4143699003)(261009223027099003)(18002099003)(22082099003)(10067099003)(261102123227099003)(11063799006)(5023799004)(56012099006)(261022105027099003)(261026140227099003)(261022075727099003)(261021121427099003)(261028144727099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?R1BQM1FSMGwreCsvZVhhcFV2UHYwZ0ZSM2FWWkp3czc5Q0hhUlFINFArWFVa?=
 =?utf-8?B?eDlFdEVEcGd0QzI5NVpLOXB6eG5RRGlVemx3ek0rTUNZSG1ydWFoQUt0Zm9B?=
 =?utf-8?B?azREbzQ1UXdEU1dhNTBVSEQrQXlnVmVON0xTNDNCaW5FMFVIM2ozaGYvTGRM?=
 =?utf-8?B?VjNSTitLc2VsVDVkOERlbzlUeCsxTjk1Z1RlZ0I4YUh0WGU0UTI4dTBXN2FD?=
 =?utf-8?B?a1JLTXA0dmFCL1ZwcXkvYzduUWR6V1F3d2FpK1NsTzBvVTAvTG1SMEEzTVRh?=
 =?utf-8?B?eVNlYUR4dGdKcHBaTkJhaG9lWW5keFRlNTg0K1Fhd0VweXIyMGVCdEdHaDZG?=
 =?utf-8?B?Q3dQVDNUb1U1K1hSLzNGSTBUU2hIVjU3cU41WFNhdFE2ZmluRUwxQU5PTkdI?=
 =?utf-8?B?WjUyQnB1b1RHUjNITjJNdWl2Q2hNOUt4VmIwSjAwQzRlK3VBc3dFbk5BTHVJ?=
 =?utf-8?B?MHBIQU11TDQrUUJYQ0xBTHBJUkpTT2xhb0JhK3ZwUm5KSXBoaTNjT256cjI2?=
 =?utf-8?B?WGd0QWpqVXAxWHVoRWo3QmdOWFlnNGJTU1pzYkdPaC9nb2JMOWlqQkoxSE93?=
 =?utf-8?B?RThBT2NUNCtpVkE4ZGU3QzF4Y0ZJNGptdE0vdTNGazg5WUlXOTZHZkF0OU00?=
 =?utf-8?B?RDJTRC90QWpyMUdmcm40aC9ia1JYVVRKTHNUS1ZyNU9oVFozUDhqUXlvN3Ru?=
 =?utf-8?B?MXpzRkVOekdGcmozdE12emw4ck9ERTNHTk9aS2c1NXdScUtUeVQzUURrYmFq?=
 =?utf-8?B?SnZWL0JyOGJqOVpGQUJaODBmY21hWTNDU09VVEtvUTl2Z2w3UWF0bHpsYzhB?=
 =?utf-8?B?aFJsYk4ybmc0NUF4Tk9EYW44b2pWcU9nUytxaWE5RFVYRDhINVYyd0daTFZH?=
 =?utf-8?B?cU13d3ZtTHQ4eGpIend4THdUWUlaMElvRGIxcjRuNDYrSzJuSGJTU1NiejEx?=
 =?utf-8?B?RmZXeFhPTUFiS3cweVU4YU9wTk50VUxvSlg0eU9kTUQ4dmtBWlpRWldUczYr?=
 =?utf-8?B?bXZQd2lja2k1OVlXdWxGSk1GQTZiSmJPUUYzbTd2NFFIaHlDbld3Z2xQNDg1?=
 =?utf-8?B?QW0vL1BmYzd4Y3hzMTNWWmp0MDd0WXIyeEk0UXozclNZSWNCTDgrVGRyVDV2?=
 =?utf-8?B?UnFJWkhnbGVIUVZYTXY4NzBiRFY3MkFSZGRGVEZTQ0VyZ1dyRnFERnRxV0Iv?=
 =?utf-8?B?VE51U0psNCtIcm1OR28xNm1vSWlUU3VIUjVrQVEzSFFJZUdncU9MOFNoT3l6?=
 =?utf-8?B?UjZINTR4RWp3aytZb2IxSXJTT2hGeTRkQWV4ejlCaHBMMWlGU3QyWHlSK1BD?=
 =?utf-8?B?MFE5L01JN09KaVp3VkNOZFQ3Uko5NFZvMW1DQ2o1UFVMdEQwYVlqVHIxWTJ2?=
 =?utf-8?B?Q2dyeC81YXpGQ2NSTFJrSkp2SUlXcENwVHNoWmI4VXlLd1dkMEswMHJSN1ZZ?=
 =?utf-8?B?TWhFZTFGdWY1WTUvUWlmYWNlVTFlajd5RUsrV1RyVm9iS3VhcHFRNGVWb0JW?=
 =?utf-8?B?RXpHYXNHQU9GVUd4OEt3ODZFL3EzOEViOUcwR0lqZ3hheW00QlpFdEFPZG9x?=
 =?utf-8?B?YUU2TjB4TlRDdkVHUGQzMm5qTUx6NjZoOGlMNWI0QlJuMkRhZWpKRWdOR1dQ?=
 =?utf-8?B?S2wxcXRSTStWNVpWVC9HM0EzL2FpMkQydWFVNTE5MjhSbGMwc0JrV21SNURq?=
 =?utf-8?B?WWozUWZFZlJzTWkxVGNpU3U4OVlkcURmNnpZQ0twSWpsaXh6T085NnRUZXRL?=
 =?utf-8?B?bVFWRFg5TXF0dk9zSXBGSzl6NDI2REJnbnVxTTVuTTJkR1NUSFZWNGZXbk9Y?=
 =?utf-8?B?TmhtTEFOU255VkFSWFd1UmRodmQ3UkJFSGRTMS9rN0ROcnU1SzRTT2lZQm42?=
 =?utf-8?B?UWxEMENQbGJIeWEyUnIvZ2VtOVgyOEFYZ2FTdXhhTXZoTUl6RTBUV2UwT3Jt?=
 =?utf-8?B?ZWFaMks2Mk5kN3RYUlNYcjJ5Wit3RmtLL2dqcG1XdUhGNlR3SWtLeFZYNi9u?=
 =?utf-8?B?LzM5a0hUc1VYbjRJZjluRGxPeWVIYUdBNlkrM04yd1pPV0VOTENoeFBrMXlu?=
 =?utf-8?B?TFBkVmJpb2toTkp5bkhaNmRLb0ZSdExMdVBzN0NSYlQ1NzlETGdHeldNaHRC?=
 =?utf-8?B?WldoRnN6UklRTVZaU20xZVJpK29JRDNRdmZPb0E1bnpzY1RpRXQxNTh3QUpX?=
 =?utf-8?B?SWtYYlNHeXZYcTRqWXhmZ2NOUTJvaFExa3luUHpNdnNnQ2g5NGtURm1oai9h?=
 =?utf-8?B?bmxNSGVnOUtuZGRURGd6aHVSR0FQd1JhdEhHNm9hSHUwd3V1cmFrQ1hFZmlG?=
 =?utf-8?B?SjdweFovKzQra0p4ekN4MzdsampSaUJMWHVJaVo1UWdCc2U3bTkwQT09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <2E0DB9D118A9DB4D9629602B8EF88B3A@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4159.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e78b5d9-245e-45e8-3079-08df4b48024c
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Nov 2026 23:01:15.7932
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: a2p/I+FECyL+FhcqRxYNe/7IzZl+J1NxrWhC88HTz/EbSK9PWX4z5LUaPTdXOTEZxhqoX2T1PyS+301R8SggKA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7644

T24gMTEvMjQvMjYgNTo1MCBBTSwgSm9oYW5uZXMgVGh1bXNoaXJuIHdyb3RlOg0KPiBDaGVjayB0
aGF0IGJsa3RyYWNlIC0taW9wcmlvIHJlY29yZHMgdGhlIEkvTyBwcmlvcml0eSBvZiBiaW8gYW5k
IHJlcXVlc3QNCj4gYmFzZWQgZXZlbnRzIGluIHRoZSB2MiB0cmFjZSBmb3JtYXQuIEV2ZXJ5IFND
U0kgY29tbWFuZCBkdXJhdGlvbiBsaW1pdA0KPiAoQ0RMKSBoaW50IChJT1BSSU9fSElOVF9ERVZf
RFVSQVRJT05fTElNSVRfMS4uNyksIG5vIGhpbnQsIGFuZCB0aGUgUlQNCj4gYW5kIElETEUgY2xh
c3NlcyBhcmUgY292ZXJlZC4gVGhlIGhpbnQgaXMgcGFzc2VkIHRocm91Z2ggdGhlIGJsb2NrIGxh
eWVyDQo+IGFzIGlzLCBzbyBubyBDREwgY2FwYWJsZSBkZXZpY2UgaXMgbmVlZGVkIGZvciB0aGlz
Lg0KPg0KPiBTaWduZWQtb2ZmLWJ5OiBKb2hhbm5lcyBUaHVtc2hpcm48am9oYW5uZXMudGh1bXNo
aXJuQHdkYy5jb20+DQoNCkxvb2tzIGdvb2QuDQoNClJldmlld2VkLWJ5OiBDaGFpdGFueWEgS3Vs
a2FybmkgPGtjaEBudmlkaWEuY29tPg0KDQoNCg==
