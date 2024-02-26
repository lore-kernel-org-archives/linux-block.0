Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2062.outbound.protection.outlook.com [40.107.220.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7C3E12DDBB
	for <linux-block@vger.kernel.org>; Mon, 26 Feb 2024 22:02:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708984981; cv=fail; b=GSXKS2b3Ts+0nPpKDm+XWKtYyo+sWhKkl6MH6C6erfWIqr3CCsDw/6wesX03CVWFEJwXHDXCL1/pL7epNNeRWNObnbgr0w830c25OCawUJEkMPTleda2aGr9x+V1AAQz/vTuhpXufYWPPujoC4mAC3tEtGuDm17AYgFFl3VHyiY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708984981; c=relaxed/simple;
	bh=m4Hj38OxcWRyjLg4GJxMIR4BrD4i5TnTjGdbOLfatfI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=EkUvSCdq/BvRnfzFk1eyWPOQiexsTafVGCJs20imRythvQ6CAlj6/KGzfs/FY+M+VoxtBtRHj15dSKJQlLwn28NWZ3WdCu9RgUmQXIMp/I+7k8s8Nln7N86aAs80S6WpJ8P7dDs3Kqv7ZjLFN0DzMUFD3nvBm+cmGGJBQV5BMqU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=eJz+kCTM; arc=fail smtp.client-ip=40.107.220.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="eJz+kCTM"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IYIX2T7t0mZ4EUJj6FgyF+Yf6yHLmDroQTuGGDCUQK24OjmVe0u6Zro+vE30dHrRXeeesfuUCEYXJwat6ZYeoehDZKeYQhogZbynzrQo5uJasXBX8DXlqRRRwcO4PX+AvSyQ2bxuhBGHnqG03CFyizMHi4qa/rkKAUNE6FjtX/knF9L47e2Rm9lZIt7us0lmSR4mw16fP4OsvdfJqFsaPzceTFBmOKdkeeE2d/fh1Rm4acTujTXrBCqAQWOGkqCall75ngqy+iWGoSNxT/u9jncqW+Ilba2FYnFhM3PUgdRf3BoV2wHmEXus6/bm8zcVIquorA1Pm30AOrEoNgjsrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m4Hj38OxcWRyjLg4GJxMIR4BrD4i5TnTjGdbOLfatfI=;
 b=dhkzJIIDivgJv623ffhZccmR5WveLRwMyn0NjfIisuD5l4tHL3bc9qjDoEMskxF3KNYHZZXa4l6v1rV9X/3PqCA0qAkBYzyOw8cZBYe/1ZBqiW+zeRrCQ6HPOu625bj++jxc8yMvt4z0uKzfgUUV0U1SIhUeHoV1ze36q3ZRPHDLO4aLyo9GJjZAOsbo1FWe8u1i/9JLFg3piga2Ykel5HyNRMJQm//trVHpr8TsQ1ZI8jXlxBIkxpCblCEer3SUGSumflaV220uGbHDDc/CWQvjeZd/LBWcwIxMGBe59TJCPSplL9KEV2G7hc0I5lfs0AuF5okOUxt4WzYah05Pbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m4Hj38OxcWRyjLg4GJxMIR4BrD4i5TnTjGdbOLfatfI=;
 b=eJz+kCTMp1EdXrvVJUDnMxs1kqDsJqDbqBeN+31FcrDfQB+nQ4uhh1mfQF/f5qjzRz/SMHxMeB+lt4bsj96VFyEXDY3aCdlPbvvLt/LpwcI7MRkoyV34p6ShvMBDhmI0V2TYdLUgx0MAvwDGyU2eTaAagxo+vAxSOf/cM/ox4PH37d4+jfprunmnMfwKIoUV+RhaiNBVgRQN5iLRPqdQUZefkkFUJI8UsP6W9HR32lwV5BFUVH4hROBzzd0bbhBOxSvbVYlbfwR3h5AVyNLb1SY1/mwhOCMdiEIhTTxqzKZov4UVzkfqb7qFnVRzrmoh19bFtlKuhJZO5ALld7LwSg==
Received: from CYXPR12MB9386.namprd12.prod.outlook.com (2603:10b6:930:de::20)
 by CY5PR12MB6322.namprd12.prod.outlook.com (2603:10b6:930:21::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.34; Mon, 26 Feb
 2024 22:02:54 +0000
Received: from CYXPR12MB9386.namprd12.prod.outlook.com
 ([fe80::fd67:3880:45c:8a3]) by CYXPR12MB9386.namprd12.prod.outlook.com
 ([fe80::fd67:3880:45c:8a3%6]) with mapi id 15.20.7316.035; Mon, 26 Feb 2024
 22:02:54 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>, Chaitanya Kulkarni
	<chaitanyak@nvidia.com>, "linux-block@vger.kernel.org"
	<linux-block@vger.kernel.org>
CC: "axboe@kernel.dk" <axboe@kernel.dk>, "damien.lemoal@opensource.wdc.com"
	<damien.lemoal@opensource.wdc.com>, "hare@suse.de" <hare@suse.de>,
	"zhouchengming@bytedance.com" <zhouchengming@bytedance.com>,
	"akinobu.mita@gmail.com" <akinobu.mita@gmail.com>, Shinichiro Kawasaki
	<shinichiro.kawasaki@wdc.com>, "john.g.garry@oracle.com"
	<john.g.garry@oracle.com>
Subject: Re: [PATCH] null_blk: add simple write-zeroes support
Thread-Topic: [PATCH] null_blk: add simple write-zeroes support
Thread-Index: AQHaaIOJBd1tywPuQUuwEZ2sWPVYUbEci2AAgACisIA=
Date: Mon, 26 Feb 2024 22:02:54 +0000
Message-ID: <b826af45-a164-4b9d-90dc-dc9f30a9eade@nvidia.com>
References: <20240226071355.16723-1-kch@nvidia.com>
 <4549b888-4613-4c96-8ac2-ffe08b52da3f@wdc.com>
In-Reply-To: <4549b888-4613-4c96-8ac2-ffe08b52da3f@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CYXPR12MB9386:EE_|CY5PR12MB6322:EE_
x-ms-office365-filtering-correlation-id: 57008eaa-bd49-41eb-a65c-08dc3716af26
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 XLP2bbTogp9V7+EZE0qRyv0ZlN2r10LXyClUs89jJjJZXykNF7jeRvz3Z2X7Vi66pGGSqloZ7SuXX1xj1Erimi+wVXfAWwqtBZJshN/HT0lXrvsUMgjEDa+sJxa6OjACQTLJoVD55qaRAy2s7N6lmBrwdrcTM8DHIEW2OmpQ7oANg9E4NdvzMkU+rx3QfuMXiVeAroewitkLuT0zvBhWZNdPmNWShgxWT+nfT9xgc+ehe7VV825JZphg10dA7RuSNcrOTM5m1dzG/RdhEcJLptRDt1XaxVGkkJjg/mgRoGnxP3E+v1IgkEb9CpT3yIWhRvnJbQaW/LJKlytm6MrZh8Vc1orj6f3IRuxRBXnZ6cx87lUnWHk9LklSgroJ30+Trf5hCVMi9jx15OAWUSt+69e8iaglkaGxtc/h/sxZVZc9kkVKmcuEYcyOdeqLbBa4qqIVOvoATaUkSnxRHxNSgJfgVxQ0Z0hVmYE+LJi+zm0+DBkDrCTS6f9f8Uv6T1lQnOQChTGQburYYQEN2Js/LVPZq7kKJS69TeYxstRQ+jAkcaHERdGJaRUCynkSt+zy5GubTehsGYQCys9tOAlw7ESzHLS4Jn7YGdggsrkj6Hzl1jxhjP01aILFTWTEbyCLWDYfdbq4uMc3ICBtSNbZ5Ra8tLCNN5MnREg1SswoaA+m2XTC12OsNyoiCfNqgKDos1akCgMpTQF0AFydMUcTKg==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CYXPR12MB9386.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Q2lVNThPYXl5LytJenFwbVF3UTJaUXdRRFZjZlRkaERRajNHV0pDQ2Q3UlFj?=
 =?utf-8?B?TEI5QzlOd0h5NkpsUUZrS0l2TTRIOEJ2WE9QUTk4Kyt4cVkyY2svRUpUNDd5?=
 =?utf-8?B?M3FhNzRwaUlBaWdraHovR0YyUDFIeUFuR1Aya1lONkFDdVdSTFMzREx2QjVZ?=
 =?utf-8?B?MThoVHI2M2hVY0lLc2RmLzB4Unh5amhPYzB2eE1hSlU2QTJ1cGh1MjhQWDlR?=
 =?utf-8?B?NzhKUDhYYmVPRldkVjYyQitYRnBCYzVpTGVoRVVKRXBJalRLSXFLS2wva2FB?=
 =?utf-8?B?V2U5dWV3WFZZWlg0aWdXOTBIKzlvQWxmY0xWNjB1VUU5L3V5dWpSUFNqN1BH?=
 =?utf-8?B?QVhHaDZZM015WXpBbUxmQm5MU3VEN2ZWQmJQNCtRUFExSzU1dDEzMjlLMEsv?=
 =?utf-8?B?Z013TjY5SzdzT3VrVjE1UlF4TkU5Ym9WdjU1aEFldno2eWMraTFpRE02ekdn?=
 =?utf-8?B?cm00RFk0Q2xHdmZBQmEzeW5UaWhpSlFMSTM3WmVLUGFudFVoTjBVZnlKYkl0?=
 =?utf-8?B?dWlRL0NtbW1iYTBuTGZXV2xRbmlsYkdQTmgrdXZDRVBJS3JMM2o1TDRzRkxo?=
 =?utf-8?B?WXVoVkhHT09JaFZxUEFuTEQwMWxNNWlCUWdzYUtLM05HY0FXTllXSUJCRk9E?=
 =?utf-8?B?TUxVaW1QQThXYno1dDArWmlQTFl1Z1F1YjIrdldSSmNyaStlc1JUQ25zWksv?=
 =?utf-8?B?ODl5eDZIa2huSVgvYnR3dlFmbkgyUnNYREJ5QmZJMEVxYUZMN0lZMlJ6TWJB?=
 =?utf-8?B?dHAyZGg1NTlaOGZIa3ZMdzlQK0tKbE1sL0R0UWtCZDRKZjQrSG45Vmt6aWJN?=
 =?utf-8?B?SVdNS2hQd2IySkF3MDdyTVZrRHM4czhkdDc0YUtVeUxSOUJvVjdralBnSkNx?=
 =?utf-8?B?ZkU2OUplZlNCR1JGZElGLzFmcW9XYy9TVktuQXpEQ3MvRmpTMDdSd29mSjlK?=
 =?utf-8?B?ZHhNeHhNcXR5UUJlclFYU2Z0UE02YllqODcybmVGeXlSTFBRak4raTU2bnlw?=
 =?utf-8?B?Y1BjeWFTQ21GMU1Fa0U5cjZ1aWpOSGVCQWdhdUJjM2lsdXVhb3I4eWEvV2Zo?=
 =?utf-8?B?S0VFNlJUalBRZ3llT0lVNFA1R2Y4SCt5Wk1hck13YWN6RnJwTG5jTGhqY3d5?=
 =?utf-8?B?OVQzVzdCVjJUbEJCb3REQU00MDY3UStDcHVSR0E0NjB4Q2NGZEFSYURnTDF0?=
 =?utf-8?B?R0tTSWUrTU5kUUtYdWlVL2FhS005NEZ2YVJDZ09Nb3lGUFpRaDNKZjYrMlJa?=
 =?utf-8?B?QXNVR1ZqTGN3amtrMlpFRW9jaXRUWldIQ0t0QllJRllRcENsWGFPU1BUYm4r?=
 =?utf-8?B?VmtvYUs0WVV6UFpNelNmbmR4YWt6SXVRWkUwRmVjbUw4dm45QklueXArL1hr?=
 =?utf-8?B?NFpsOTBpYUZJYVpVM0RvM0ZRZjBwSHdYZWZmZXIzdG5EeUtUMnhmZFc0T2or?=
 =?utf-8?B?eW1vUG5IT3VIRU1XVDFiUWlUbjQxSndHMmdhUitFL2xxcit1SHUvUTR4YW1t?=
 =?utf-8?B?Vk50cGxxWTdtTjYyd3lEeHZOM1ltRTlCbG1DeFc0MUwrYVBkRTRET0JrZHN3?=
 =?utf-8?B?VlNDZmkzMUx1cUZhMDBZL25RZDJRdzN6Y2FvNFBsdE1TZk1MQkZUUVZIUnlh?=
 =?utf-8?B?MGhNM2ZUc0N6cHF4bEVYZ3d6Q0dXL1RuR3ExYnNTa2pqN3BTL1FCYjZxNmg3?=
 =?utf-8?B?U2FHanBrdHF5aFBZRG5zd1R4RE9xTmttZ3B2VGZBV3B6RHlUS3FyTUVGclFZ?=
 =?utf-8?B?MllhdzVpTFZUdmp1KzZ3bUFudmplenFwbVQwNm1vTjZKVFgxY0FvYSsweG1E?=
 =?utf-8?B?ODdOaFZpb2FPdGlpcm9FSW1qTlFzUXN2ZzRMNjloS25mWmRpMFVGa1NCNEdo?=
 =?utf-8?B?ejcvYlppMkYxZk1VNWtyNGtvYzJYMVFaRFhyT3UyeXNlajdmZ3hwZEkzeWpq?=
 =?utf-8?B?RVh2VDM5Smt0R0w3UGlGU09sMDRUM0JOQ2pyWnhmSnpIMTEweThHYUp0MVpv?=
 =?utf-8?B?ZlZSREtqeEdZNEZVTXpiQ0gyeW4wWDRZWUdBcW56LzZ6Mlp4OWhIOXh2S1hv?=
 =?utf-8?B?dlo1N2xCeU5OT29JM05XdDVmS1F6dU9EL3NaWFB3VE9Bcmx1ekpsNE02c2xM?=
 =?utf-8?Q?/RIbpO1wy7+ysksGBioOPLihk?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B8462BD1FE0AB4498F3B06BA19AFDE74@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CYXPR12MB9386.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 57008eaa-bd49-41eb-a65c-08dc3716af26
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Feb 2024 22:02:54.7073
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0ZEzBKNIOAh+6vjc1Y7TjRUCEJC0jsBe3cYX2q3mNdjMy1b6jQXB9MYaBZO6TrEt0rXYAaQ97LLZCGxPZwgmwQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6322

T24gMi8yNi8yNCAwNDoyMCwgSm9oYW5uZXMgVGh1bXNoaXJuIHdyb3RlOg0KPiBPbiAyNi4wMi4y
NCAwODoxNSwgQ2hhaXRhbnlhIEt1bGthcm5pIHdyb3RlOg0KPj4gQEAgLTE2ODQsOCArMTY4OSwx
MyBAQCBzdGF0aWMgdm9pZCBudWxsX2RlbF9kZXYoc3RydWN0IG51bGxiICpudWxsYikNCj4+ICAg
IAlkZXYtPm51bGxiID0gTlVMTDsNCj4+ICAgIH0NCj4+ICAgIA0KPj4gLXN0YXRpYyB2b2lkIG51
bGxfY29uZmlnX2Rpc2NhcmQoc3RydWN0IG51bGxiICpudWxsYiwgc3RydWN0IHF1ZXVlX2xpbWl0
cyAqbGltKQ0KPj4gK3N0YXRpYyB2b2lkIG51bGxfY29uZmlnX2Rpc2NhcmRfd3JpdGVfemVyb2Vz
KHN0cnVjdCBudWxsYiAqbnVsbGIsDQo+PiArCQkJCQkgICAgIHN0cnVjdCBxdWV1ZV9saW1pdHMg
KmxpbSkNCj4+ICAgIHsNCj4+ICsJLyogUkVRX09QX1dSSVRFX1pFUk9FUyBvbmx5IHN1cHBvcnRl
ZCBpbiBub24gbWVtb3J5IGJhY2tlZCBtb2RlICovDQo+PiArCWlmICghbnVsbGItPmRldi0+bWVt
b3J5X2JhY2tlZCAmJiBudWxsYi0+ZGV2LT53cml0ZV96ZXJvZXMpDQo+PiArCQlsaW0tPm1heF93
cml0ZV96ZXJvZXNfc2VjdG9ycyA9IFVJTlRfTUFYID4+IDk7DQo+PiArDQo+PiAgICAJaWYgKG51
bGxiLT5kZXYtPmRpc2NhcmQgPT0gZmFsc2UpDQo+PiAgICAJCXJldHVybjsNCj4gUGxlYXNlIHVz
ZSBTRUNUT1JfU0hJRlQgaW5zdGVhZCBvZiB0aGUgbWFnaWMgJzknLg0KDQpJbiBwYXN0IEkndmUg
YmVlbiB0b2xkIGV4cGxpY2l0bHkgdG8gbm90IHVzZSBTRUNUT1JfU0hJRlQuDQpUaGF0IGFsc28g
Zm9sbG93cyBleGlzdGluZyBjb2RlIGluIHRoZSBmdW5jdGlvbiB3aGVyZSBTRUNUT1JfU0hJRlQg
aXMgbm90DQp1c2VkIFsxXS4NCg0KTm93IEknbSByZWFsbHkgY29uZnVzZWQgOiguDQoNCi1jaw0K
DQpbMV0NCg0Kc3RhdGljIHZvaWQgbnVsbF9jb25maWdfZGlzY2FyZChzdHJ1Y3QgbnVsbGIgKm51
bGxiLCBzdHJ1Y3QgcXVldWVfbGltaXRzIA0KKmxpbSkNCnsNCiDCoMKgwqDCoMKgwqDCoCBpZiAo
bnVsbGItPmRldi0+ZGlzY2FyZCA9PSBmYWxzZSkNCiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqAgcmV0dXJuOw0KDQogwqDCoMKgwqDCoMKgwqAgaWYgKCFudWxsYi0+ZGV2LT5tZW1vcnlf
YmFja2VkKSB7DQogwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIG51bGxiLT5kZXYtPmRp
c2NhcmQgPSBmYWxzZTsNCiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgcHJfaW5mbygi
ZGlzY2FyZCBvcHRpb24gaXMgaWdub3JlZCB3aXRob3V0IG1lbW9yeSANCmJhY2tpbmdcbiIpOw0K
IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCByZXR1cm47DQogwqDCoMKgwqDCoMKgwqAg
fQ0KDQogwqDCoMKgwqDCoMKgwqAgaWYgKG51bGxiLT5kZXYtPnpvbmVkKSB7DQogwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgIG51bGxiLT5kZXYtPmRpc2NhcmQgPSBmYWxzZTsNCiDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgcHJfaW5mbygiZGlzY2FyZCBvcHRpb24gaXMgaWdu
b3JlZCBpbiB6b25lZCBtb2RlXG4iKTsNCiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAg
cmV0dXJuOw0KIMKgwqDCoMKgwqDCoMKgIH0NCg0KIMKgwqDCoMKgwqDCoMKgIGxpbS0+bWF4X2h3
X2Rpc2NhcmRfc2VjdG9ycyA9IFVJTlRfTUFYID4+IDk7DQp9DQoNCg0K
