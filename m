Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012025.outbound.protection.outlook.com [40.107.200.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D525C3AC0CB
	for <linux-block@vger.kernel.org>; Fri,  5 Jun 2026 18:15:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780683346; cv=fail; b=Eh7ASFxjOAAojghUrW6wO40PuPr1S/+wodBxmagEalpsoj1DPCSlCIWT/qV7Xg6DFwkd34XYdVNkPq8dF+Mx72GN0SLyHkD/JgAN6cuBaPxRZMl4jtwgfoqfILUykV9UB89FJ+ZdsBzP0nbn0BAQ9y6UD5Xp1QkBL3TdiXaS9ZU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780683346; c=relaxed/simple;
	bh=Q+rXzjoLU9S3N6xqyCbfPEidREAaN3K2Och7LAz/IkI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Qpkz2RCzR1Lr4uEmAgDbvRq8f5nqh8RfOPp+HpOml+ymlODGeUGWEcJVm7Am/vaiX9UysdMvghO4AY89ndwyhh+NqP9MlCVBLPt5Vu5VzKS/bpGShcnhxxOvy8CKcTgB3ap85QaFFQBwpCzCvq//wutRqZMUjfsGyvUpCqdbzTI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=BE0j0ZpV; arc=fail smtp.client-ip=40.107.200.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="BE0j0ZpV"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=P6F63eyeElMYoewzvvUhPUfPJF/hbO5Dofv06Yy7KIWqrb8S6HS4oAxP0CwsaU9WbhzmMIZm8KL9AOPkNGSX3Hz55snR9cOJPQu3v9jur04228GZczCcHddb7wed7XyG3z0PSH9M6yLZL5LZKi539rt8uwc0z2BY7z5Y2/gvJEwOwRKxRbNpvV53m1rXAdW+80tTcwr9bfXS+B0rQ0FIugSUZzk2DGBXp2UW5EXzya0NbovRhpXbxFDbCgL+kGsF2b4hR7ogmjGwXFublHzgYc+CEzAhZgD9qIZarjO1CJLIZGvFUZs0IltfHm6MoFXyD9oOi8c9wLfsERNRXPKqMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q+rXzjoLU9S3N6xqyCbfPEidREAaN3K2Och7LAz/IkI=;
 b=SXSG+oSZngcE8JmnBplWnsCLqFuPnnkExWz0puGc6USPvTFg/QS40RRKX5ParvS2RmGObkZF6xVAIwBHFhCG+6PIjbFczQGq29GrmKCnD09mRakbrDEvg1NZ0P/wKxGtfVMnyiUYocvL0yt3LCtnKTyu8pLpryoDmJZrhAhTKpm4wlEIILN2gi9ML4qw4XSQloaCw4nJeNe2PPEDeQLFWm1+Vzzsu0naYijplNVLg6St5A6jKh6vL7zRNj9tz4U7gJ+SRhcgQ6PTYTH2bFexrc15ewNFy3YUb3O0WtQJYpewQpc6yUtAsKto8AWnkB0diQmsJFOGTjCdIjsAK2DDfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q+rXzjoLU9S3N6xqyCbfPEidREAaN3K2Och7LAz/IkI=;
 b=BE0j0ZpV8bpQJ35Bhb7700saZ73M/rF2dNlX73rCB7/Ytmr5HyVIsebUjfxQ95lJ5dV7xP4IoDeWTUNxyiSwkec+yCVJ4KPmKuCjGhvtxE8UbfsjAipCKVIkssRFNEqVyvRiaM0vLymk1CP5kbkM/D9o18OOghlOJkDQcd7x0FuJsSmrFJ28Jc6hcIcnHa+uzMf/aYeCKl31nOrA1AB6zUbMmj7O7g9mXMZS4ZVlwkuBQciOBKUJBTHCR3VuHqCBOa+0XXwIS1Rv+3dyqo6uWEkONiV8AUj+2NUiNgwgBiGFu49LlPwwa4TORg7r+vuXRTU5TfSucKN3rr+O5ptQGw==
Received: from LV3PR12MB9404.namprd12.prod.outlook.com (2603:10b6:408:219::9)
 by SN7PR12MB7935.namprd12.prod.outlook.com (2603:10b6:806:349::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.8; Fri, 5 Jun 2026
 18:15:41 +0000
Received: from LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::2109:679c:3b3e:b008]) by LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::2109:679c:3b3e:b008%6]) with mapi id 15.21.0092.007; Fri, 5 Jun 2026
 18:15:41 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Bart Van Assche <bvanassche@acm.org>, Jens Axboe <axboe@kernel.dk>
CC: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>, Christoph
 Hellwig <hch@lst.de>, Hannes Reinecke <hare@kernel.org>, Damien Le Moal
	<dlemoal@kernel.org>, Tejun Heo <tj@kernel.org>, Josef Bacik
	<josef@toxicpanda.com>
Subject: Re: [PATCH v7 07/14] block/cgroup: Inline
 blkg_conf_{open,close}_bdev_frozen()
Thread-Topic: [PATCH v7 07/14] block/cgroup: Inline
 blkg_conf_{open,close}_bdev_frozen()
Thread-Index: AQHc9RWAUpamPVpnVEepPpktdGXVa7YwRHYA
Date: Fri, 5 Jun 2026 18:15:41 +0000
Message-ID: <fe8f139f-e6c3-4be0-8d9a-53ef807fc4dd@nvidia.com>
References: <cover.1780682325.git.bvanassche@acm.org>
 <05661d1555decc6dd5389174ba448d803b72ed9a.1780682325.git.bvanassche@acm.org>
In-Reply-To:
 <05661d1555decc6dd5389174ba448d803b72ed9a.1780682325.git.bvanassche@acm.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9404:EE_|SN7PR12MB7935:EE_
x-ms-office365-filtering-correlation-id: 7e0d79d3-ec2f-4a76-ef54-08dec32e73be
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|10070799003|376014|38070700021|18002099003|22082099003|56012099006|11063799006|4143699003;
x-microsoft-antispam-message-info:
 vkijGQFW0f4EpyohruX4UBe5c1PgVxy6q2BQeL7eArFcU4xg8YBKOODKTVvmbSgYRyPiasDJG8SwUjGbYdmmLUgSPmo0oB2ureRdzw+iIFKXMYjoKUUZcnI6HcO774c63Eq2Q5r5cXt65ip8qy6lU70ACjMEZ/jV39+Vvdnd8/7vKyJB50pZj4QZNGRPqtL36Xt+NWXMzHCsBAb4UNv0H36A3QeolmKODcLb10G9I43naWfUzshHzxe+MnFjDHEtWfvw2boxbrgitRQaoDQXgT/ip7cEclsyQcJm8+zqnEhl6rr9LUMSbaPWXJzBDzWyMSoUsZwpZIIngVQmEG84LzP1CbqDy2ZDjCiVA8BD5HnZSskte4DRSCko7HRiTTk5BV6BzELLT8U511St8yNF5dJcwhiPrhby9268BlHb2uTYvadsQev05z15ztcV0qzQanBJb/nUu8PM7dogl++pAWMMMjwole7jbKpOY+vVlQrhU66Dz4wOajRQa5t8mBZ/ac2MVn7doxO8lW8zpghEpMRHdW8PNLEwWgZiH1RSlOuu8WyilVnhzWF5icC8aXHFCnKbJMFsd8qhovM+kTFihsvELkDq+gGQToz6hpObqkDfny1JrX92B5e/LQqyv2dqAMo5DpWL73mk3yMdJSLkGpay43PjfFIQiDeriN2IOEtEt0xLFDyBbpjzYYgYMKPbrcyxqexKqHQXC+j+erKfU5u6yo85NF7o52w2F+Vez59cjvEYiWOGFdLJzmWLlZIj
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9404.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(10070799003)(376014)(38070700021)(18002099003)(22082099003)(56012099006)(11063799006)(4143699003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?VGpEdWExRXNRU0M1Wm9lWm1KVDd6dkZhYWNPYXdVNk1RaWlpTzBLdkFOejh0?=
 =?utf-8?B?bVhoOVFra25mY1YrOE1ZZG5BaER6RnlEenhhUlc4TkR2SmM5Y29RTEc2NVRt?=
 =?utf-8?B?SGhYU0JyQ3RjYkIvWUFHU3lvVk9VazhyUEtsQmtnQnBDU1p1VTRzbkYzb04v?=
 =?utf-8?B?QkVEdzZyZ1djU1dqUVkyQ1dTdHo1Y0xPWTJ3T3Z3cVB0VVR1SHRrQzlUdkdJ?=
 =?utf-8?B?b3lqWVVlNkxKQmpQaEw1QmlBSThna0J4OVFYbFFLWTIrZUNiRVkyR2NXQVYv?=
 =?utf-8?B?ejg5SzlwNUs2eTBhc1J5NjhnVmg3Rk9IYUhsenJ1Rk51MXNLZzdwQ3VQS3VI?=
 =?utf-8?B?UWNsb2xOVTl2RG9pN1kzZk9sdk9OM3oyeFdySE9neXlGTkQzNDBnb2YwRTJy?=
 =?utf-8?B?bnlrRnJpQXZlYTJhMDNPSkpqdVRXRTI3MkQvMnk5S252U1h6SURZTldBaUJm?=
 =?utf-8?B?eVlzaWVlNGVSL2lPZVVGdWd6dTJrK1dLZW5vdFFGVm9TdzdtY04xRG5tVXRF?=
 =?utf-8?B?VW5oV2hMWkRPMUl1OUswL29SODBhZ0E1MzgrUTVvRGtwY2t4WjN5VzExWm45?=
 =?utf-8?B?SS8wRTFRMVZFNElBVTcwZ2lCN3JQeEJaeVlCbjZsMWloZ3N3T2RxZTV5ODBr?=
 =?utf-8?B?ditRY2ZsWUxBcUd6M0R4SVlTcmRZK2wzNDBWSkYvVUQ4RWQ4UkVuKzFQdWZY?=
 =?utf-8?B?bmpKZzhYeU9Jb0xkZ01zWWoxelBXSnJrd2toL2hhU3hkcXliU2t6c0Z5TlNI?=
 =?utf-8?B?eEdWck8wMWZlTUhPaEh1eWw5SlQrcVpVSjEzZEhHcnN1WVFOMS9mSS8yUW44?=
 =?utf-8?B?aENkSkdqM0laQWhOTVdUbHlHTTVjdnVQUml5RHdnSFJRTkNtdDBPdkdFRXpy?=
 =?utf-8?B?WDdzWE1ITGVxaDJLVW5jM29maTNnclRteU5TUTBkRExXcjNEZFhqVi93UUtw?=
 =?utf-8?B?aEFYbndJZ0t5NG90UlNqQXF1NHVqNjVFZHVDcjBCbmRLaTVHdWRjTm1UQ1NO?=
 =?utf-8?B?UjVVZzhpU2hkbUM2eUFuRGNEaEROaFlBcE9qdnY0bXBTeER5WEpMKzBDVTB0?=
 =?utf-8?B?Q1o1Ti9TYmQ1N0MrWEcwZ05INWloVFJWN2w0NURtWEJQaXpSZnV0cGZuUGox?=
 =?utf-8?B?cnhvd2Njem9FNll5REJzdE94N253N252UVc3enVJRzVMRnVzcUJrZ3Z5eTJD?=
 =?utf-8?B?ME9DYnhLdGRJZ2hsZjYwUmlUTFBWWURUZzlYendlSW1SOCsrN1V3RTJEWUVZ?=
 =?utf-8?B?MFdINzhJekhnbVNaTzRYdHhtTi9LM0dlRk1QcGpxMnZrWWJET2xqWTdmVENC?=
 =?utf-8?B?b1JUNmJBalk1R0h1UUZxK2ZCaVVNN3lITTV5OWtFNTFSdHhIV3o0cVMwSkVL?=
 =?utf-8?B?OHhNQU9JZUtadzJiZUhYV2prR1JTaGNmSWRqVWJiKytxY2NMODVDS2xsNVkx?=
 =?utf-8?B?L2xDV1ZSaXNyUWYwRzR5SkhzL2twdDMvREh2OGtVN3VLV1psMWdjZjRYQlpk?=
 =?utf-8?B?anVBcGFHZnBSemNaU2V3NFp0NktXUmc5dCszQ3RkZDRYK0xLeVFhTjN6T1pF?=
 =?utf-8?B?OTRDYUppK3R6YTg5aGxKcmM4bVZNZUNxcVNyZXJxdWQwUDZXcDZiZFhBZXIw?=
 =?utf-8?B?bWdJNnhrUUVrNk04emY2MmQxUzZDWEtGTCtEd2N2YWFxckVBZGpvOGdDbHpH?=
 =?utf-8?B?Smk4aTc0SkNETXNmV1pUNW1tUk1JdSs5WThLUHVVMHJoL2M2NTZVVXhZY2sr?=
 =?utf-8?B?Y053YklncWxlMWZURUtJbE14b2YyTHQvWlpvb3AvN2xVSTZLVThtZng2UUpM?=
 =?utf-8?B?cnkwcndXemRxSytJMDgwcTFXZlE4RjN0Sk02K3ZoSmp3aXFnc2Z6RkcwRkpo?=
 =?utf-8?B?Sis3UlBOSHpabHFWMWE0MEd4Wk1LaW54UjJLSXhLZWlHQVlDanVvT21SajJW?=
 =?utf-8?B?UXpSMmdxblltRENid0xCdW1GbW0xTUpMajJWUXk4bGNSekovS0Yvc3lFMU1V?=
 =?utf-8?B?Unk2WDNJVGMyMVJHWmhIZGVGMDhsM1RxVDJxMzNhYjJsOFhpLzQ4WWxsSkVs?=
 =?utf-8?B?a0FlUTdwWHk2dDFkQzk5Ukp0dkxuV2NGYXlPRVFGMklSY24rWUgwNWZsekQ5?=
 =?utf-8?B?YjZ2ZzE5YmUwc2FnbzR2amk1akVzay9MWG0rTWp6MWdqdlRJYlpJVzZWR001?=
 =?utf-8?B?a2JoN1B4eXJ2Y0NhYkFqZytFRnRVQjM1Z2xneFNGeHdleDA3UDFYTnBXVDJu?=
 =?utf-8?B?dldGT0xyelpWY2lCdXd4OFhySnY3NzlERFhUZld5L3pabWhNS2hqU2hkVjJH?=
 =?utf-8?B?Qjh5Zk1sdTQza05haVRuQUIrSUY2Y3dxSU9nTlc0TUlOQUo0U1BYYU56UGFP?=
 =?utf-8?Q?VDhPl9IP7s8KCNznmewWGEWnqAWlvKbt+Cogq30Dy9wpd?=
x-ms-exchange-antispam-messagedata-1: fKHsFj95JDXzXw==
Content-Type: text/plain; charset="utf-8"
Content-ID: <042C022050C3144A83FADEDBD017DF7A@namprd12.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e0d79d3-ec2f-4a76-ef54-08dec32e73be
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jun 2026 18:15:41.0557
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: s6w0hr977IoDRo6G8H89YoXoosghu2bfb7gGn2SDEwBqrHjaSVcrUMLt1Mqk2Qkd9rUMHJ4FBzS4fJ0nQ8pZ7A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7935

DQpMb29rcyBnb29kLg0KDQpSZXZpZXdlZC1ieTogQ2hhaXRhbnlhIEt1bGthcm5pIDxrY2hAbnZp
ZGlhLmNvbT4NCg0KLWNrDQoNCg0K
