Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2073.outbound.protection.outlook.com [40.107.93.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2336426AE4
	for <linux-block@vger.kernel.org>; Fri, 14 Jun 2024 23:29:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718407797; cv=fail; b=LsCgEJTR9wiRl4kUcirikS8B69A1flJ84GVOPlgadga9bhTCJtk2lE8Wjs/7Ci91niNjeKyLXu8QUTIlIDFiu4GYR8gHTWSs1btWDQH/pIBJbUw8O69Mi4zczHPBLGqlGDc4B9uRtaq/vD20xbMwEhE2X8/czw+2Es26ccqXnU0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718407797; c=relaxed/simple;
	bh=JQSpJwuMgpjoR6IabzIvNfsVyDajRLvezwswPZBd8QU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=M1AAlLp72w1lxx4j1A2ykMTUhW/wtqX4ZGw3Qdwl4ZwT1mXpDnzd3dYGFzgh15TNccnOqoeJaSDY1vwGo9+AOkgi8A547KQbW0JWcjCmJfDLv04/5DWroMsP1ZSOu9nydrWNh7YVJR/q0WKzLmUdLehV2p5+PTk8wbsDZhR95vk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ioMt0DT7; arc=fail smtp.client-ip=40.107.93.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ioMt0DT7"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QMdQRa4M+C+KeV+I+KmKYh65CuxTeAjH2ODpjBQFLAPHtyDloEQCfq3LXI3bN8TQPzQKYalHCmhIAoRMzl8A7TFT7WW4ENYEIe7ttuTPkBMAW5RCW5WPkmqLCUiTc9z2HuuSnkk6/ktaVTUTqI5fv4DvBaDKDKR9DUssc07B2soGWSWpNw2GfPCq4RK/UTpuKLEdkuQMrOotA6AUrsa44HY3x5hq3h0gQjI5ctddWY9wyY6VCD5aswWM+R3cmaNIrcTl58LrLwhJiLSSrjxohzAfkS/Gm6e5GdNWnW8MM62jDTmdGrZKRxj6YKZ7c25zz9cC4cczwlQ2o9OTz9/4iw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JQSpJwuMgpjoR6IabzIvNfsVyDajRLvezwswPZBd8QU=;
 b=D3oBGrSvbx+NAiLzj+/uyeFj54NEZLv+ViU1DW6t9iNi+mzmbu8Ttpxtiy8W5VeW/vt2aKugrm+2bwklmI2mWDD6w588evJUcVki1FQURIuRU11AifQrG1NqCZ/wrOaASh/uvHG3Anp/w/yzO8dDOigSqP3KszYEJs5oKMjptCJwZigfzZOh0uf+OUvTlzorNBF33kLE8Y78jH5wUZDgjdi4ARoL9OhaM/HEXEl7VCMw/nyd3Q9ZC/BtwouhVvXTuJi6tNTg11S92BV4prcyanryKdRphQm1qaDgyxmlBBAZ7PDPB+MbotRpxvO5OlbYVde4VqHqZ3g5z31iMe66FQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JQSpJwuMgpjoR6IabzIvNfsVyDajRLvezwswPZBd8QU=;
 b=ioMt0DT76airKpHJpzpH+bZYwY22oB6v0WintpTdw/JRfgTiNAtkZpU4fuvVIWugYxT+vkCDZ3LKnuzxc/ehYI65KS+UersyFypL0rcuhZYJngEFwDXW9Z1QGUuK5yI8CKkPrtyczqGdow3DKArf0+Bdvrqn/ed9XFu4xLysuv6H2GdKLabA/l3ExVBAV1dxqzjjTZTSepQWbJSUzFWgRCZK/ZvZrxp8bC2TFWX2138BdjVm4ms4ZlcA7YuLmUsSfrUyuPoDgqTWhuY9C0uGmZ5/tvBoORNxjH4Vw4k7D+GWh3j8+esQBfhM5wT1c7bs1kiaBbxufrVVpidmRjVNnw==
Received: from LV3PR12MB9404.namprd12.prod.outlook.com (2603:10b6:408:219::9)
 by DM4PR12MB5866.namprd12.prod.outlook.com (2603:10b6:8:65::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7633.37; Fri, 14 Jun 2024 23:29:53 +0000
Received: from LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b]) by LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b%5]) with mapi id 15.20.7677.019; Fri, 14 Jun 2024
 23:29:52 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Cyril Hrubis <metan@ucw.cz>, "linux-block@vger.kernel.org"
	<linux-block@vger.kernel.org>
CC: Christoph Hellwig <hch@infradead.org>, Shin'ichiro Kawasaki
	<shinichiro.kawasaki@wdc.com>, Cyril Hrubis <chrubis@suse.cz>
Subject: Re: [PATCH] loop: Add regression test for unsupported backing file
 fallocate
Thread-Topic: [PATCH] loop: Add regression test for unsupported backing file
 fallocate
Thread-Index: AQHavbBsmNiuYdPCZkaw0Qgty3DftLHH6iIA
Date: Fri, 14 Jun 2024 23:29:52 +0000
Message-ID: <dfe2e079-2cf4-4f13-8433-6e05f12427f2@nvidia.com>
References: <20240613164007.22721-1-metan@ucw.cz>
In-Reply-To: <20240613164007.22721-1-metan@ucw.cz>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9404:EE_|DM4PR12MB5866:EE_
x-ms-office365-filtering-correlation-id: 05c73327-55a4-46f6-f6f0-08dc8cc9e464
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230037|1800799021|366013|376011|38070700015;
x-microsoft-antispam-message-info:
 =?utf-8?B?Y3Yxd2Z5NUtaZThEcm9yOUVrVHhhdXVhdmhVS1Y2cXppL1NQTFl5bWtTR21T?=
 =?utf-8?B?VjdOTTVQamc2Z1VJeWtvQ2V0eXp4eFJLR1BNVm5LSFRQZVJjdFRNUyttaTR3?=
 =?utf-8?B?cEV1TU95WTlUdGM0ZlpiVUszaGN3NDFrK0JNQW55dXl3Qi9FdmpCaGlwS1g4?=
 =?utf-8?B?SndoU2RibEtqUTAzT0hsUUpIckhtMjRTOGVaUXFYaEFoMWdzTEYzN0F0UkdG?=
 =?utf-8?B?aDJrUnRobVBGVjRpeWdVTUx2cWhqM2FxZjU1YjVwK2NOeGNCVTkyYjd6SHI4?=
 =?utf-8?B?akIzSmVxYzBxMTNvS3lKVmlBSjN5a0RES3lCWnZxRDBFcFNIVSthYklDVTVl?=
 =?utf-8?B?cHFUb0FKZHE5bWlPZmhtdFAvYXJQckQxNWJIakdDRUcxeGRmKzdQTGZNbWd4?=
 =?utf-8?B?dFdWVVVSM2ozc1FxdG1EQ0hjcWVQdHZkcGI0bDhSRkVoV3Y0c24vSlZRLzVD?=
 =?utf-8?B?U3NKekJncEh6aVM0UVRLTXVRTTl1aWNRVXdiaVhvYXFpa1Z1Rml5OWMxU25l?=
 =?utf-8?B?bXRvNDJRU0ZMQVU5eVRqNWNTQjRlK3c4ZGxlUExYNStjM2k4ZFAzQXpFV1Vx?=
 =?utf-8?B?V3lTRmgraDdRWG82d3QwdzFzOGJDNGxmUTRRL2wxd0N2S2tHbFFoSk9Zc3dq?=
 =?utf-8?B?T213L1BxYlFGRlRRTVRzRHFITm4wWXI5NFB4V3ZlZnVEWStldzJuYnJabmJn?=
 =?utf-8?B?ZG9FZzRnakdrUEJEaUNiRnh6QXZxZGdLSmN6b0M2SnR5enp3UllxRkk3OFQ2?=
 =?utf-8?B?U1lzTGdCMXZQUVg5SUg5S3pFdnJGTm9JdkRqbDQyVCtNOWZiYURYWjYzRWho?=
 =?utf-8?B?c0kyZlAvNTJrUTYzcXBUMmNZZUpPLy9WSnU4c3lBb094YndSMWxhWVgxWUU5?=
 =?utf-8?B?dkoydUlXNm81V25GZUlBdkJjVEo0bU8vc1JDdnNEMWl1aHJJNTVQKzR0T1VC?=
 =?utf-8?B?TWlVNjkyTzkwVXo0VEMwN2NESmM1ZStGNlIrYnAzTU9LcmtEVDh0ZVJ1MkFU?=
 =?utf-8?B?ZTRydmVtQ3V2OFdCRGZFdy9HS0xPemYvN3pMczlSdGZlLy9aSWoyeXJpZEVJ?=
 =?utf-8?B?MU5ac2d2VnBVSEtJa3JHUmJqQlRraHVmL08wcjRaNmljell1RU53WG5NU2NZ?=
 =?utf-8?B?dVFNVGVxS3lkNTVlUXg3OTNFSERVemozOWJyVUdROUFmVnhTcGhPQjFlb3Q0?=
 =?utf-8?B?QXgvN2tKRVA0eDBhUWFaRUJBOFlxZ2tXMDA2RlVJeGRGbzdta1NKaXNDeWdj?=
 =?utf-8?B?Zk0wUHk1VnpCRXBwMzVwZDFGendtUWo0RUdUWlZob1lTWXV5ZmZTUWMyWlRu?=
 =?utf-8?B?QUNQaEJJclhIUnFlUlgxODRwUnlNUllFOVUvNVBKMDh3b2h5ZUR6Y1RkZ3Av?=
 =?utf-8?B?TC9nalhQbXVYSFNxUTM1aXhNeFBQQnQzYnluZHpzOWc0NGxxaFpoY1pwdytK?=
 =?utf-8?B?RWxIVTZSWFF3Mi9QSmRWa3JhV0dZcHp1cFlTaUtoRy9VaTcyaW44OHE4amor?=
 =?utf-8?B?UW1xR1d4VlBPb1NIcGRuWTMwTzArUDhXSGFTd21sNDRxbm4wYTB2U2Vpd09t?=
 =?utf-8?B?UlRadmQ2MFQ2NC8rNGc4dlR5ZDBLcjltd3lpYTVSbWQ2cys0czdJblZsVnpq?=
 =?utf-8?B?THRDMEwzS3BxTENkME5iWWUxRWdPck5rZm02SG41TllXMGhTclFvR2lvTWtt?=
 =?utf-8?B?WnRMa3F0czEvSm5ZR3lVZDVOUnovZDlBck51dVJ2ZHQrWWlkSVNLYi9UWUFD?=
 =?utf-8?B?eHpGb00vL251N2I3bEYvVkd0dDNlbnZQdzBET1hGdDJQbE45SkFEcHcybTVY?=
 =?utf-8?Q?rdDCoyxloGPBH2iqVDP26qAb5N1cbaajoQZiU=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9404.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(1800799021)(366013)(376011)(38070700015);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?TjA3dzNsSWlxOWphUUNuMUpXSGpxT3MzdlRMcGJ2RXBqTDduYm9aZmEvUkZ6?=
 =?utf-8?B?SFJsMURuTnRsdmI1cTVMaXgxOFFUU3dPdGR1VHRHK3BjRU81RzVJU3RkQjNN?=
 =?utf-8?B?c1ZYMjVwK0F5MEdUN1cyNmMrNmMwazhlbzlzMGltdUZpL0dxOW9iZ3piUmJK?=
 =?utf-8?B?bVFIMFFtYmxnZGNaUlJFRlVxRHoydzlmenNEeEtaZVBWczBTQ00zQWx0RGtJ?=
 =?utf-8?B?YnBhNG9qNFl1ZXRVaStYL1A5bnNsZkxsd3duTUdaUm0wVlZLQnNYU2hQdDVL?=
 =?utf-8?B?Rkwyb0VRa3RQQzlvTGF0RHBJaytjQ0l5MWFuTHpKc3YwcjRGWE92elNxWDhS?=
 =?utf-8?B?TUZQV29teWhJTW5tVmljVWhOZlRLVVMvL2luNElOQnRma3RZVWNwbVZmSHVu?=
 =?utf-8?B?Z2VhTE9vcDM4WlZqUVlOSzVHRzcvV1Bjc0VzTnFPZkZOYUxRVFNHMEpManhC?=
 =?utf-8?B?ekpkbFRHR1BUeUFtVklnYmpkK2szT3p4NUVzT2kwUlFPVWRwZ0k0c3kyYkNN?=
 =?utf-8?B?dUl3dFhqdGx2VFRRbUNzeTZxeGd1ZjdKRkhibFVyby9CdnloVGhIbWZQY0Jw?=
 =?utf-8?B?aEZyWEVhTW9LYjlsVkNJZUVFWmRkSEpEWmtTRmRBS0J0QkdWQmxLSWMza3cz?=
 =?utf-8?B?TXRrWGRZTEJPM1J5ZXM5ak10K2M1STR0WDZ3Wlg1MUFLQjZBa3publkyMXl3?=
 =?utf-8?B?dnlHbm1hdVJuQURqRlF2RmRIeThVVGtNMkQ4WkhQZDlpWHJML2ZtenJaWWJD?=
 =?utf-8?B?QnpEd1pHV3ZXYUVuSzFnWnZFakM4VDlLTHJHRVNpcUVXUWtNTGZGZnNoSmNk?=
 =?utf-8?B?eXdWRWowMSs0dHJwb2ZsZFVEdzlwSDRxM2pia0ZMQkduVjlubUJrNStESDRJ?=
 =?utf-8?B?RURQVUQ2bFRxeFNQNHBaaDcwNXUvdW41anc5eDhUQmxGODRDZksxL2pWblRI?=
 =?utf-8?B?V01rZ2orSUdnZWxtWlRubmRaM0N0eTREaFZleDF1RUhSR1RDaFpuVDNKbEpl?=
 =?utf-8?B?TDdYdmphbW54VVRPQk1zM0IyMGdIMFVvd285bEFmK093MHhTWkhwT0J5UjNV?=
 =?utf-8?B?YkRYMGtXNTRTSGdpZWRUNkhLYnNvNHpDaFVuaVp5ME9iTlB3RVB6ZndPV3pB?=
 =?utf-8?B?UmQ3eVpoYkljbTVveWJmdXBRSnk4NzBmZENPZUJvU3FBVVNLTmFqVVBLblo5?=
 =?utf-8?B?ZnYyQTFmYWxiTEJxYzBkWE56SC9panl3RG5MTllsOGY4bkFwTVdvbDNJcnFI?=
 =?utf-8?B?d3g5SWhmS05uaVJnM0pEMU9ENTVCU0thOHBHVjF1ekU4aUViQ09rdVdETHg3?=
 =?utf-8?B?a3RkZjdUdUZrdG92S08xbmVETWJEbGZCV3l2RXRnTUNFT2swWkNCcGorRFIy?=
 =?utf-8?B?dHR6VzBhby8xaEdZbWtqOWRTcFlSNENKUGZ4NzRXM0RXN21NL3ZWdEg5U1pL?=
 =?utf-8?B?amdHV2lxV3VkRGJIYWNYMllpVXg1R1g0WEpDTjlEWGdSa3VZRUdzZlhKVDVM?=
 =?utf-8?B?amp5eTBnUDc3RGRCbi9TUzk3WlF3TVNlUzFMVVU0cG5oVktYNlpqak9JTXFD?=
 =?utf-8?B?OUwwQlpVaExLL2hHaGl3dTRUZVRTTnhEZGcrVC9SZlpjeGpwV2xRQ3lQTm50?=
 =?utf-8?B?Q2toNUJickluS0c3a0lOR2lndjVnVEx5YURPUk1mL28vNlc4OEg3Tk9wbmlM?=
 =?utf-8?B?QTdscCswQUpsUjhoWDFiOTRVdldNbkNBdTNCVTR5YkpFN2hHakVnMWNDK0NY?=
 =?utf-8?B?d3hHSHFqLzlvWnNneFlqSUdXdEJVRXBtTXpWMk4rUjdyZFI2NndYYndoV091?=
 =?utf-8?B?T3RhVFc4eGpFMUhPWDFnWFdseTE4bjRPY05nS3FYV3RweDVsdXl1Sks2R215?=
 =?utf-8?B?enZ4RlhHOStMNVQyTGRDUCs2aG04SFBVS0U2YlBlWlZTaXVkNmhBTlRhbkxB?=
 =?utf-8?B?eFlPSitxL1JraFdtdkdWbEo4ZnlNMXhqT3J4Vlg0ZlcrVlJISmV1QkM0WkJX?=
 =?utf-8?B?U2pjRldVUUFlL3ZuejZoOS93d0tPMStMTnAyNnRWdmtWN0d3anZQSXo4anIz?=
 =?utf-8?B?RG9MWGZmKzV5RitENEx2SjdXbXpZaTBkSGRXOEV0VE1OMThMcEVUNE5od252?=
 =?utf-8?B?Uit1bDNUNFAxeVZWbmY1N0xGUVlhSDk5VDRKVXpzbU5xOUdMQVVpM2xOaVdI?=
 =?utf-8?Q?o2JjAX+D0OPb7Wc3ARJur2/WX19GITH3ViglMezwmL0m?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <77F8378164A978428D455911FAF16CDC@namprd12.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 05c73327-55a4-46f6-f6f0-08dc8cc9e464
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jun 2024 23:29:52.7664
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YVhltr1ACd/7/Mbt6kx2T5xYOA+INreadSAgl2N5QTX34ETWNfMmlXf117PrDQanbstU/RF6/nScVkTKh8QN+Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5866

T24gNi8xMy8yNCAwOTo0MCwgQ3lyaWwgSHJ1YmlzIHdyb3RlOg0KPiBGcm9tOiBDeXJpbCBIcnVi
aXMgPGNocnViaXNAc3VzZS5jej4NCj4NCj4gU2lnbmVkLW9mZi1ieTogQ3lyaWwgSHJ1YmlzIDxj
aHJ1YmlzQHN1c2UuY3o+DQoNCnRoYW5rcyBmb3IgdGhlIHRlc3QsIGxpdHRsZSBkZXRhaWwgYWJv
dXQgdGhlIGlzc3VlIGluIHRoZSBjb21taXQNCmxvZyBpcyBhbHdheXMgaGVscGZ1bCBpbiBsb25n
IHJ1biAuLi4NCg0KWy4uLl0NCg0KPiArdGVzdCgpIHsNCj4gKwlsb2NhbCBsb29wX2RldjsNCj4g
KwllY2hvICJSdW5uaW5nICR7VEVTVF9OQU1FfSINCj4gKw0KPiArCW1rZGlyICIkVE1QRElSL3Rt
cGZzIg0KPiArCW1vdW50IC10IHRtcGZzIHRlc3RmcyAiJFRNUERJUi90bXBmcyINCj4gKwlkZCBp
Zj0vZGV2L3plcm8gb2Y9IiRUTVBESVIvdG1wZnMvZGlzay5pbWciIGJzPTFNIGNvdW50PTEwMCAm
PiAvZGV2L251bGwNCj4gKw0KPiArCWlmICEgbG9vcF9kZXY9IiQobG9zZXR1cCAtZiAtLXNob3cg
IiRUTVBESVIvdG1wZnMvZGlzay5pbWciKSI7IHRoZW4NCj4gKwkJcmV0dXJuIDENCj4gKwlmaQ0K
PiArDQo+ICsJbWtmcy5leHQyIC9kZXYvbG9vcDAgJj4gL2Rldi9udWxsDQo+ICsNCj4gKwllcnJv
cnM9JChfZG1lc2dfc2luY2VfdGVzdF9zdGFydCB8Z3JlcCAib3BlcmF0aW9uIG5vdCBzdXBwb3J0
ZWQgZXJyb3IsIGRldiIgfHdjIC1sKQ0KDQpuaXQ6LSBjYW4gd2UgdXNlIGdyZXAgLWMgYnkgYW55
IGNoYW5jZSBpbnN0ZWFkIG9mIHdjIC1sID8NCg0KZXJyb3JzPSQoX2RtZXNnX3NpbmNlX3Rlc3Rf
c3RhcnQgfCBncmVwIC1jICJvcGVyYXRpb24gbm90IHN1cHBvcnRlZCANCmVycm9yLCBkZXYiKQ0K
DQppZiBub3QgcGxlYXNlIGlnbm9yZSB0aGlzIGNvbW1lbnQgLi4uDQoNCj4gKw0KPiArCWxvc2V0
dXAgLWQgIiRsb29wX2RldiINCj4gKwl1bW91bnQgIiRUTVBESVIvdG1wZnMiDQo+ICsNCj4gKwll
Y2hvICJGb3VuZCAkZXJyb3JzIGVycm9yKHMpIGluIGRtZXNnIg0KPiArDQo+ICsJZWNobyAiVGVz
dCBjb21wbGV0ZSINCj4gK30NCj4NCg0Kd2UgYXJlIGxvb2tpbmcgZm9yIFJFUV9PUF9XUklURV9a
RU9SRVMgZmFpbHVyZSBpLmUuIHN0cmluZyANCiJXUklURV9aRVJPRVMiIG9uIHRoZQ0KbG9vcCBk
ZXZpY2UgImxvb3AwIiB0aGF0IHdpbGwgY29tZSBmcm9tIDoNCg0KYmxrX2NvbXBsZXRlX3JlcXMo
KQ0KIMKgYmxrX21xX2VuZF9yZXF1ZXN0KCkNCiDCoCBibGtfdXBkYXRlX3JlcXVlc3QoKQ0KIMKg
wqAgYmxrX3ByaW50X3JlcV9lcnJvcigpDQogwqDCoMKgIGJsa19vcF9zdHIoKSA8LS0tDQoNCmVs
c2Ugd2UgbWlnaHQgdGFrZSByYW5kb20gZXJyb3JzIGludG8gY29uc2lkZXJhdGlvbiB0aGF0IGFy
ZSBub3QgcmVsYXRlZCB0bw0Kd3JpdGUtemVyb2VzIGFuZCBsb29wMCA/DQoNCm90aGVyIHRoYW4g
dGhpcyBpdCBsb29rcyBnb29kIHRvIG1lIC4uLg0KDQotY2sNCg0KDQo=
