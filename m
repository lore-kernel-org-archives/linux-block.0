Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2081.outbound.protection.outlook.com [40.107.243.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2FB81A71F
	for <linux-block@vger.kernel.org>; Fri, 26 Jan 2024 08:37:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706258242; cv=fail; b=mYebTOjqVB/wOCIRuL4J6NNihF9vQ4IM8sojypy/D3e7tJlEgbu3pU03V2kByMv6SqVaNIt/z9EYwMh7bx+yk+w9iP+gPqDNji8kk+NCZfzNnfxGusnwWbN+uM1UdGAycNhVyJvI+d5hZj1UXY8jFHCgNSOHqyO9h8yyFymotyM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706258242; c=relaxed/simple;
	bh=nC3Vx+3iNnNiWVh3I9+8g3T6e8lZ6rrdJ4okVTQduD8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=kdmJBaMlIsddUO3sJGR+OlxXBHkduU/WccfdDJoiumwLfXscy8nbUl6WzUCEwrS+SGtdMWA9Gh5WGqmRfqd1noJJcz7Q3gqxJ3oGV/QHIagWPlbZis612SMOVIgJw3VWpcMeqPYdRRnv+OyQBVNlWT0kFhRACVAH3yteGKk/l5I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=JX6KVLgY; arc=fail smtp.client-ip=40.107.243.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="JX6KVLgY"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=muAzOkQD5gdAys8qIbWZ7n7PbfYVClOJa9mu+EQMtDvXFIuVrpiUgZca/0dDVZBc/MOqrmaQjtwDJY/R3ErjbDu08Iu1/q8tmeK7+H+qAHZJP9hm4loLRcquUtFWxH2ViqplBbhEeKb7LYP9INNEAjYC22CjN41yEb5xTW/crzjnxPe4pJxaDHHaEmuHd+Bsxp5WQmBYs2AWrNpTtJfvNfi3Z1/CC1YGKi764QaLrwAo61l3BF7z+chK56AZxKT9j2P/IV3ju5apB8xHdHIfrwtbwSWfglIXTRjRgurpGWo22aoJu/WuKb00pZxSlRuRIJyJnwG3aqXlRM14JsAPEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nC3Vx+3iNnNiWVh3I9+8g3T6e8lZ6rrdJ4okVTQduD8=;
 b=LPQoBhB+UguY/ciWe/6BEgnCCgBLgrnFsZ7h+DLJy8aEnRCZWwwqZhUV2RpAFyeGgfgLPsK4WJxNsxZXp8OBg8VqmEkbGLQUuI8VARoXwjKJ7/iINY1D4qXbkVSeUywxr39Wnz6l5VRZwWoZC3Y0oj6KzVdNhWNxlNZW4088GJKWc1ihD0LpCqOpg85nJBzCCl2EQxd9Od4HJu2qgCeZ9B4y2AX9FcKdK0RjmjTUc+DqrBD9h0STT14br4krxZpH+ndA9dmLemNJhU8y0TZuD2klWel9oj2jeXqqImKY2iwxJPH2Koi8gZHx2s9HR1Y/5ZO9eU2ZKxQXcQ362UieHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nC3Vx+3iNnNiWVh3I9+8g3T6e8lZ6rrdJ4okVTQduD8=;
 b=JX6KVLgYxOEAA2Qe/EqEZfmW0MH4O9XBUjrQTf95LsRJqWrHh5Miwr7Su0ZXNtuGVBsXXru3cY1F5D9se7yyZM2R5SS4Y0IpwsRIVTD5nFKIKS/gWVsJAaC2S05zMi8GmMW9f/5xidyuf1HHXKClrOyt6+OTheYQURFW5Y8yeEN+3H/hcxZAREGIeX6h0KfK7STIOs00NlB5pzRVks+nWcyXxBoyLg8ou6EUoyKUjqrtkWzJJP0iFOQkLhVhQkXjnW0n1GUMk9zO4ZoI9xdjr0VGjuXjxLR+g+5F9pUrAspfhxvvEXgFYIMBnBeodFKJpzo0fGqH9WImhbtPXs3GUg==
Received: from LV3PR12MB9404.namprd12.prod.outlook.com (2603:10b6:408:219::9)
 by SA1PR12MB7248.namprd12.prod.outlook.com (2603:10b6:806:2be::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.37; Fri, 26 Jan
 2024 08:37:18 +0000
Received: from LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::ffce:bbde:c1ca:39ed]) by LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::ffce:bbde:c1ca:39ed%4]) with mapi id 15.20.7228.027; Fri, 26 Jan 2024
 08:37:18 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Damien Le Moal <dlemoal@kernel.org>, Hannes Reinecke <hare@suse.de>
CC: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>, Jens Axboe
	<axboe@kernel.dk>
Subject: Re: [PATCH] null_blk: Always split BIOs to respect queue limits
Thread-Topic: [PATCH] null_blk: Always split BIOs to respect queue limits
Thread-Index: AQHaT/G6xCRQH27V9EOFj2KStGm7CrDrwUaYgAAEk4A=
Date: Fri, 26 Jan 2024 08:37:18 +0000
Message-ID: <b21b781d-36d8-4f5a-824e-5a7f98b3f627@nvidia.com>
References: <20240126005032.1985245-1-dlemoal@kernel.org>
 <84dce2ee-5d71-47a4-b114-3ca69b3c31fb@suse.de>
 <89fcb470-2e21-43a3-a428-000e1c6ab706@kernel.org>
In-Reply-To: <89fcb470-2e21-43a3-a428-000e1c6ab706@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9404:EE_|SA1PR12MB7248:EE_
x-ms-office365-filtering-correlation-id: 78037a41-0211-4fbd-1601-08dc1e4a0176
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 o1vx619EfxOK9up/W7qsHJAQuf5K8YuITySdNXEJrVWjL6Ys5kkrtv6DnHCyxh6OGBc4NU1DETWPE+ImpwYv2zLJLCJt87Nn+m1Y3j13X5SFZ2cFOQgGZ67SlQVrWaHELQ6sYTLPtjL2vR+n4pTenzg7NuKxkALEF409dTI7eiHIecSRt0CPKIFqlESZXSpkFAJnonkm8HZYufKDpEWO51zeZ7xwkFjhkgHq9XD4um2+OwQm8k308kALoEr8Yx0HliAipAv/7Azy07ZDTx7BCjZf/Rk7zChXKZmOC96mHUzJsl/lBZ2d+AdH6ZHNH+LogYZdJvKXYItlUP2tgT7HzezWKX/VpWAAk5NaH/6c5kEOaX4gyDzBtILAdBerOHhT0If3ser2TMbrcD4p7Hn4YPA1e9L+OsGQSXmdG0ZuRBZaa1HOH/6ACTyW0xWoxTpXxI8mujchGG0VRoSvjAG7K6f6NQj36+hDlZQDH7dx21FczYPorSKI2c/spnMnxbUyJKbfx+FGhnIDSImAJU/2GguUeJNpICuMt9zOi0fjKlMFwqMD/eXKHOGvmqwttkHnScNz+7M6qPV0xo6NFt9zngXD9WXZZ3bGicsuH/aOP7eMeDG24l174ARUVajL43EipjKTd0GqdPZ7R3V/kE0n5Aav//PpyTdBClAbjrdEia7iuZejwSs4N9Rj0UHVtqCx
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9404.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(366004)(376002)(136003)(39860400002)(396003)(230922051799003)(1800799012)(451199024)(64100799003)(186009)(2616005)(83380400001)(66476007)(26005)(38100700002)(6512007)(54906003)(122000001)(53546011)(41300700001)(8676002)(4326008)(2906002)(76116006)(5660300002)(66556008)(71200400001)(110136005)(316002)(478600001)(66946007)(64756008)(66446008)(6506007)(31696002)(8936002)(91956017)(36756003)(38070700009)(86362001)(6486002)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?RUxqV0tCTXBhc0s2WVMxakJBbTJFenZVdkYwdWN5clNTNEwxTFpXd2RneEVp?=
 =?utf-8?B?RmdBTndVOXhhU3hkNWMxZGlPbkhzKzg5WHFOQ1lyVWd2RTIwMWRmd0pLdlM5?=
 =?utf-8?B?TzJTT2Vsc0x0eGtxeVkwc0JlREVwSmprZ2VrZkM5enRzNmRYTlRYd3doVm91?=
 =?utf-8?B?anVKMkZLYkwzZjBQWEVGVlJNUHg2d2NoVzN1ZEdycHJiTEdibVoxUjhLTTBU?=
 =?utf-8?B?clpIN2hya1pIMUU1ajM2RDdIdVUrUWM5QmxoQmxyaHhiSkRTTWhndGY1N2pF?=
 =?utf-8?B?d21vYml2Vlc5dVR3Uno2cUFGK0dLbTFZL205OVAvMkd3UmFXdUlMaFI1VlVY?=
 =?utf-8?B?dEhSMzRYZVBtZFZrZEtpbWpNZnAydkF6Qkd4b2RPU2R4Z1h4RVIxZHRTSUNO?=
 =?utf-8?B?N2dVMmNUdTdJaGZBRTczQU8rWFlaaGxGbmZqWXYxakRXZHJVRmlMYkxIYmgx?=
 =?utf-8?B?VVFBNXhXY1pNcThKZkN4Wm1Eb1ppV3pLYnBkbnVXSjdCTU1nS2RFNHk4SjFS?=
 =?utf-8?B?L1FLZExhMjlaZW1NOTdYaFFueDRnMXBGSGpqSlFscEVMdjladHpobWpackZY?=
 =?utf-8?B?eXJ0ZlV6VzRJcGw0WHZDNlNWNzZFdTJ0WTJvMkcvSVgrQVJKTU4rdWVzaVh0?=
 =?utf-8?B?eVd6d2Y2aHd6aGo4RHJ6dHZaUTNUQVZhd3NrUGF0QzBZRXR4QmNnWXhDMElC?=
 =?utf-8?B?RGkxME5NQmFZQnhtMmUrMUdkcXVRaDI4T2lNMDA5djV4SU1vZmR3dTZudFg1?=
 =?utf-8?B?clZRdyt1OUIyam9kSmU5TDl4YWs3dlc4TXR4RTNDL25CR0JYcnhwbC9UQjhK?=
 =?utf-8?B?MlNYMzBEQmpXWEoyWlZZM2hoUFRUbXFJZm92Vm1oR2Nkb2E5ZWltcE1JOXlp?=
 =?utf-8?B?R1hNY3RYOTVBemE0ZGEyanV3dm9Kdm0xa3Y0cGs3b1NPNDdES2l4ZHN2dDNq?=
 =?utf-8?B?cHN1R0ttak04c0Z0QitobXFUaUxMQUVvRWF1YVlWZ2hleEorVkYzeDZzcU5z?=
 =?utf-8?B?YWgyaWpQaTdvTjk0d29xeWVEVDRWVDFjU2NBR29nd21aTE9MZEd3RERtbW5a?=
 =?utf-8?B?d21wUXJMSDYvL01QWERPN2QyS2o2TVZyTnFLWXM1QVN6VCtyQjNvUjJObUxp?=
 =?utf-8?B?bDFCSE5MNExGZVVaOW8xZWxnQmErMmsydFU2RmJrNmVYc3ZzTkJKUEV5MWpt?=
 =?utf-8?B?TWpBWFEweGt5YUVDY2JTYnlZem8wTjhzYUVnQ1l5NzhMWndOMTlvWE1NR0h3?=
 =?utf-8?B?Q3RBK0RqYzMxSVA4bXdsdmErcnd6WkN6YVpwdmR2V1NrcU1JQVYyL0pIMEx6?=
 =?utf-8?B?RENFS2J3TWRVNjZFV2s5YUVSbSt0MmpQV0ZyQWdxOUlHZGVtVGNLVmhPUHVW?=
 =?utf-8?B?YS9yUkhMVnlqWTVkZm5WUUpZalV5c0Y1eE9UZVkvYnpkUk9iUFJPVS9Xck15?=
 =?utf-8?B?K3JPbTRaRnpzNitaZDlKOFM2bWxmVnkwTkhnY2thV0ZYMExHQzU4YjZrS21l?=
 =?utf-8?B?WkoxOFZtd1FuY2lybFFhMjNFY0o4L1IzQThvOEtubGtSZVdHbnI2TTZWTnRN?=
 =?utf-8?B?cDU1OTl6WFJSYmlSY0ZwWFg1L1F2YzNQY1EwM0FVT2RLb2RVak9JcnVWa0Q1?=
 =?utf-8?B?VTR2K3V5UkRqa29OY0dVY3RWRVo1Ty85UEpuK2NCMUw0N1E4MThZS1FZYjd1?=
 =?utf-8?B?TzN0dS9zZ002dzhuR0pmTEQrLzVpMnQxT2t6REh3eVN6YjJFMFoxTmtVK2kr?=
 =?utf-8?B?MVJWTGlJbjZ2QldOZVBoT1V1czBlbFNPcjR0aXJEbFNMMkJ0WFlldGRSb09R?=
 =?utf-8?B?OXp5RDRHeGh0dTljdG5wT3UwcWZVVHcwNEkrUHRjWXpzUlo3QnQrYThGVXE2?=
 =?utf-8?B?Ty8xZWpFVXhBN2R5ZUk3Yk9KVVEzRjJ6bVhKODRHU0piL3JLNDdDKzJ5RG9r?=
 =?utf-8?B?T3F2WlZ0V3B3VjBaa3FnM3V3ai90b3ZOR05LQjNjR2dCbnNsMGs2OG40dk1z?=
 =?utf-8?B?YzdTbXRxNzduNWIxRU91ckg1ZjJ2WUExS3drNU80UmZVRnlaNEEzSVBNR29R?=
 =?utf-8?B?VjFGZzBwUTE1SnZJQkZlVS8zN295M2tURlJDRUNlTFZISWxNdFNRMDJnNU1P?=
 =?utf-8?Q?xRZWkVN4iFrjech3hndDOJ0Df?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <2CE6D292D3009345BBC22F549F7A3521@namprd12.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 78037a41-0211-4fbd-1601-08dc1e4a0176
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jan 2024 08:37:18.0446
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 29uKF824Jq+t3091ewhPcXwclPw57U8/z4UblE5a54aZeDLmjN2ocAWErpzZ+sskl1DZ8ksROPkQh4KxM5P1Cg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7248

T24gMS8yNS8yNCAyMzowOSwgRGFtaWVuIExlIE1vYWwgd3JvdGU6DQo+IE9uIDEvMjYvMjQgMTY6
MDUsIEhhbm5lcyBSZWluZWNrZSB3cm90ZToNCj4+IE9uIDEvMjYvMjQgMDE6NTAsIERhbWllbiBM
ZSBNb2FsIHdyb3RlOg0KPj4+IFRoZSBmdW5jdGlvbiBudWxsX3N1Ym1pdF9iaW8oKSB1c2VkIGZv
ciBudWxsX2JsayBkZXZpY2VzIGNvbmZpZ3VyZWQNCj4+PiB3aXRoIGEgQklPLWJhc2VkIHF1ZXVl
IG5ldmVyIHNwbGl0cyBCSU9zIGFjY29yZGluZyB0byB0aGUgcXVldWUgbGltaXRzDQo+Pj4gc2V0
IHdpdGggdGhlIHZhcmlvdXMgbW9kdWxlIGFuZCBjb25maWdmcyBwYXJhbWV0ZXJzIHRoYXQgdGhl
IHVzZXIgY2FuDQo+Pj4gc3BlY2lmeS4NCj4+Pg0KPj4+IEFkZCBhIGNhbGwgdG8gYmlvX3NwbGl0
X3RvX2xpbWl0cygpIHRvIGNvcnJlY3RseSBoYW5kbGUgbGFyZ2UNCj4+PiBCSU9zIHRoYXQgbmVl
ZCBzcGxpdHRpbmcuIERvaW5nIHNvIGFsc28gZml4ZXMgaXNzdWVzIHdpdGggem9uZWQgZGV2aWNl
cw0KPj4+IGFzIGEgbGFyZ2UgQklPIG1heSBjcm9zcyBvdmVyIGEgem9uZSBib3VuZGFyeSwgd2hp
Y2ggYnJlYWtzIG51bGxfYmxrDQo+Pj4gem9uZSBlbXVsYXRpb24uDQo+Pj4NCj4+IFRoYXQgZmVl
bHMgc28gd3JvbmcuIFdoeSB3b3VsZCB3ZSBuZWVkIHRvIGFwcGx5IHF1ZXVlIGxpbWl0cyB0byBh
IGJpbz8NCj4+IChZZXMsIEkga25vdyB3aHkuIFdlIHN0aWxsIHNob3VsZG4ndCBiZSBkb2luZyBp
dC4pDQo+IFNwbGl0dGluZyBpcyBhdCBsZWFzdCBuZWVkZWQgZm9yIHpvbmVkIGRldmljZXMuIE90
aGVyd2lzZSwgZXZlcnl0aGluZyBicmVha3MNCj4gd2l0aCB0aGUgem9uZSBlbXVsYXRpb24uDQo+
PiBNYXliZSBpbmRlZWQgdGltZSB0byBraWxsIHRoZSBiaW8tYmFzZWQgcGF0aC4NCj4gSSBoYXZl
IG5vdGhpbmcgYWdhaW5zdCB0aGF0IDopDQo+DQo+PiBCdXQgdW50aWwgdGhhdCBoYXBwZW5zOg0K
Pj4NCj4+IFJldmlld2VkLWJ5OiBIYW5uZXMgUmVpbmVja2UgPGhhcmVAc3VzZS5kZT4NCj4+DQo+
PiBDaGVlcnMsDQo+Pg0KPj4gSGFubmVzDQoNCklmIHdlIGFyZSBnb2luZyB0byBraWxsIGl0IHdl
IHJlYWxseSBkb24ndCBuZWVkIHRoaXMgcGF0Y2gsIGlycmVzcGVjdGl2ZSBvZg0KdGhhdCA6LQ0K
DQpSZXZpZXdlZC1ieTogQ2hhaXRhbnlhIEt1bGthcm5pIDxrY2hAbnZpZGlhLmNvbT4NCg0KLWNr
DQoNCg0K
