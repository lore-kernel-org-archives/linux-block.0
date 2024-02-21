Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2086.outbound.protection.outlook.com [40.107.237.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F241B39AF1
	for <linux-block@vger.kernel.org>; Wed, 21 Feb 2024 05:32:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708493572; cv=fail; b=sEmkHGvwhXICFbXMH895O/4vgLcgn03mqgvYPaihaOkrH68huHkOQDXcjCa+fUMhw07WuHTjh/XFbdhhRVSoecWljSQtKffW990kjZ+kLQBwhO1d58oOWJ6ba35xH+WM3wVV93jj5P5n1kKM5sk3kB8Nrt8llJY/iS2iGthHXSY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708493572; c=relaxed/simple;
	bh=ttbcoE3nFRUh2AWoR9Di4KmT0Fnc5Aq0ZkDODK45iD4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=evufaeyjKCkj5M5WllKaf/RveSiQ1E89KD8Pkc8lQtn75ladV0AuZrX9bYsgoUtLP1Fu7+rIuAnn0YFUp0zDJosFw8YXvRlkintpuItxLUCU6CGDAc/XZf1HFW01+7oJgZNhsNqyQD61cjocvHo2jkEGW/VPaLcYlLc4gQpTWqk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=AxzSyaaA; arc=fail smtp.client-ip=40.107.237.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="AxzSyaaA"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B45T3ToG3HoynIXCsua1MnhmjRnAVaYQPh7Ok5BN2EgjUAbAvlneVSwfQaodUWQIIYgYjcPpAPFWfB54zGMjfVcl82Xz5zqynmSUHYSE0Ba1QqbPGkLJp+amXekfSU+Yj/rG1vF29Vckoqkm3seBYqi3zppqgN0PT2zDrLX0nZ6In/Cm59E0G0zBDszqx0YN+EFcqNIexvelesr1tNKPYZ5sLGJEEIu3bjA2HGRgPuh35Naq9dKsQDb/EaXgS/JADrAi3wavC9fPmzW+l7XnND12YqVYyzpLr2HNLhc2hnaV5B/daTmCnHqGdXg6P+NhiW1zOggP0XBt6pBV/Z7bNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ttbcoE3nFRUh2AWoR9Di4KmT0Fnc5Aq0ZkDODK45iD4=;
 b=NO1pAPYhE0lOYeLxRXCQNpfHioNY2QGXyvPil7zfudiw8VPJuoNGE3J9ElR9snUy0zWbLdGEGBfkwflrx2g7PSqqlJ/Va0Spcjvy/iXhYqZPvgjIQ1KzE1VwdEEfD76lqcw/WJeQd7/9KtHileXhIjTVRtssDyIpPJpW11t0qf4BA2LbB2vxXBz4Z1ZFfozKJls20N6HZqihVpoew/DxAEvIdc9k3pjka+frTzJwzufcYS0BM8OkG1ZetWe9WncfrSehBvRHrDmhg/yVE0fioqBYlagxpzeQeJuce5wCJVLhbReU5UrWvPu6IQ9VL86qsH9wkvVtDiZL8iDOtDmrNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ttbcoE3nFRUh2AWoR9Di4KmT0Fnc5Aq0ZkDODK45iD4=;
 b=AxzSyaaApo7e5AwWgHJYDE/hwJKg0x6AJzACpnQo0skLauAFuOSAimocjP2ExGc7AR3MjOmnu9VlxePevkYPnIeZJgERkh29kEagHh5WIMEMHFc3kjcvgppAvhMENR3vKpK61cfiGLlZXS5487784xvIi+vuU9LaiDo7rPxmkdVHaoQTWwRx9+w3FHn8ZrR3l9IELGAFTyfCSOcCOFg6nrH/2hY6GNINRMESon8juYVvxdUzIgMJpEx/VqZNYz+hBzJUI/pKbUZeW50dgL4z2lvHOW3FHPc/Brd+wBkBoI76aStYK5miwLHXk7MQqQridRlbf3xIgZlxX6dAVxh7xA==
Received: from LV3PR12MB9404.namprd12.prod.outlook.com (2603:10b6:408:219::9)
 by SA1PR12MB8723.namprd12.prod.outlook.com (2603:10b6:806:385::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.20; Wed, 21 Feb
 2024 05:32:44 +0000
Received: from LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::ffce:bbde:c1ca:39ed]) by LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::ffce:bbde:c1ca:39ed%4]) with mapi id 15.20.7316.018; Wed, 21 Feb 2024
 05:32:43 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Keith Busch <kbusch@kernel.org>
CC: Keith Busch <kbusch@meta.com>, "linux-block@vger.kernel.org"
	<linux-block@vger.kernel.org>, "axboe@kernel.org" <axboe@kernel.org>
Subject: Re: [PATCH] blk-lib: let user kill a zereout process
Thread-Topic: [PATCH] blk-lib: let user kill a zereout process
Thread-Index: AQHaZD06sUSdY4lj2Ee2Ig44LaIhIrEUHSwAgAADEoCAAAGGAIAAJIqA
Date: Wed, 21 Feb 2024 05:32:43 +0000
Message-ID: <926339b1-e4b9-4aa8-8fab-3576fcd912b8@nvidia.com>
References: <20240220204127.1937085-1-kbusch@meta.com>
 <132449a7-634c-41b6-b14c-863cb198133e@nvidia.com>
 <ZdVrDbaQ2DbSKQtL@kbusch-mbp> <ZdVsVFQk38v7-zaz@kbusch-mbp>
In-Reply-To: <ZdVsVFQk38v7-zaz@kbusch-mbp>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9404:EE_|SA1PR12MB8723:EE_
x-ms-office365-filtering-correlation-id: b55dd8d5-08ed-4402-3ec9-08dc329e8782
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 r0mh8bkHsiwueeC+ljT3UsVoAd6w9AW0cbrtPNFfE/lCWvyh2TwhsUhRBM8nKFVjTEXRP/EXoSkVX6Vt3Icg5S/FAW1Dbqr41uTdR0zXx82F6o/WTn29Kr8zYD/RR/vjDI+JVCLBlf9gjq9vjMKP/TbPMRIWocm//e+qrNpFb28YFxtJDxxdgH8JFxtsOvj+MKARSlT7IXYbkQWkhoAz3PcSB0vFJeBCkAPzjsaROJcEHY18DUfV8Rb7sAYyT2lWu4d+PwTNe71imBwzmsmJLKRCQLQfBrScF8+yCUZB1R9DDMSYTnuRduzRkRMV/M9Cdsce4/or6FzFTIMJSpbAgFZ3441B5s5KzTAn6alBh3Xk2KkmWaR3vfS76gEb3dJwJ4hCqb+2mhO0E+h3RvOOKZpiRSBwYGqPLv1tt5rAQnT4+1ATdHXMwRbIFj81Qc84kwxPqYbQjEO/G2wLeOpsSUemu9qrGdQiX/GwccrHxMedEXFkRyCMMchw6PduxtgOYg09V8NdOgi7GshFMoGRjFBbE7DL9RNl0MHFiqDV3BLlXynH5izStWfcFRMEc6pewCiXnMFHSZtPPJJk4wOKjDLXOn12YbcQ95vylpJhf2rrrwjE6S0vaql4I5L0Hhu6
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9404.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?bEszRHJkTmdQM3BzTUkzby96VWVOamtUNTgvM24xR0o2aFlhTGVndVRYSWZj?=
 =?utf-8?B?dFcwaXI4b01DT09BRDdjV0NhVk9FVENsZVB1U0J0WVBZaDFQL3VPclBkcEs2?=
 =?utf-8?B?WmpDcWh3bDBYWEhXZEkweGIxNFZ6NVM1dVFDZm8yM21HZWdCYk9DTXV0cFRx?=
 =?utf-8?B?NWlIbnBMVVJpczFxZmwxbEJvbjQwd2pud2VlZW1FUzJUOURTYVNSNGZnQ2Nh?=
 =?utf-8?B?ckdTN1dhbFFja1dXL1ovY3JUc3FzWGQ3WU9nV3p5UXVvWStiZE1VS0NpMThY?=
 =?utf-8?B?MzM1d1huY3JBTW9qMnMxSm05alBzOU0ybFhJcGZjcW00NFpSbURuNkJkQ2cx?=
 =?utf-8?B?WklNajlwWXdIRWxZNm0zSUEwK0tvNC9OSGhVSTh0QlVuVmxIREZrUTBQSnBL?=
 =?utf-8?B?Y2NNcmtaNSsyRVpOVmtKM01zT2tRa0Q2cWd6MUFBZVRrTzhKUVBJdTk0bmNq?=
 =?utf-8?B?RjVUekpVMTV5c1BkVHlhMEpmakZmZG5aeTJFNk45SEIzNVpvdWNYb2ZQUzBR?=
 =?utf-8?B?MjA3enZTTCtkS3hqK2RZOWsxRGVDZUJ3cTA1RzE0NVJhYWhxK3VQTkRpYXJE?=
 =?utf-8?B?WXh4dnNSS1hEVXRNYjJ0ek9RUVpHanoyY1grcmdoRHU2UDVRdXVZQ2luakxP?=
 =?utf-8?B?SDkvWjY0ODlKNzljRUREZlFmaFlTMWJWTVFDVlpYRDE2K25YSUd3d0NvQ05B?=
 =?utf-8?B?MC9wREYzbDUzNEFXZUhQcW5pZmpmQ1FIQmlzeldHM2xuQ2VOekw2a1VGV0NQ?=
 =?utf-8?B?eDg3R0FKSDlaaTYvVkgvcm5HWDJURlpWYkRqZ1VyWEFIL2c1dFJLOXlOUDV2?=
 =?utf-8?B?bm0rNUpKcmJqU0VFV2tTdDVkTTdBMjV6ZmUwaWVHaExmUmVKRWl0R2hyZzd2?=
 =?utf-8?B?dVlLWWFzZkVWVXVWK1V1OGlMVGN1OGFPQm1veFcvQ3dxdUg0eGNNQ1J4bVBo?=
 =?utf-8?B?bnVKNWluaGppalNsK0JHVW9xOXZoSmM5Z0k4bDh1ODN2c21aTkFVSXdlZ3kv?=
 =?utf-8?B?RlJXUEErL1U4N3lSK29DWlhqY2s1aEZrTU9UNTRaVmZRbld3bkQvY2lnR1o1?=
 =?utf-8?B?UG9WM3JDRGhydWdoa2JQL0xSRWI3dS83R09SS3dhUGZ6dWh2b0J5Wm5CT1gv?=
 =?utf-8?B?V3Ewc1ZVMi9oMkU2V1JqVUVnU0s4SXI4RjgvRk1JNksvNkZrMmtBUnRFNmx5?=
 =?utf-8?B?UHNNWTdDTHMxRHYyTkdUM2dDZUtMaWFRSk8wdXdqQU5VbFZCTVVIdHl3RXNl?=
 =?utf-8?B?RkdwVHlKS2VmelZ1UWlndU1UNFd4UkgzZk0vc0RkczJkeWtDR3pObWVpWE1H?=
 =?utf-8?B?SHBMYk9VV3dxYkdESGVIVmgwd0dKdlpQRXNTVFZSTVF0cW1mWTA5UDRSRUkv?=
 =?utf-8?B?TjYyYVZNWTZtTmlaUHBudHR4NEh2eUFIbEJYRS91dGZwRGNjQUU5OWZmQksx?=
 =?utf-8?B?QTNPR2htSzdPbTREWW9EdHZvU2NPZkprY1VYUVFVeTJ4Yk1UWEE2dlNIY3ht?=
 =?utf-8?B?eFZsdVltSVhwdzQvNFVJQVJINWxVMjNTZ1dnK05udkNWcGtoWEMyVUdOdERo?=
 =?utf-8?B?V1k3UDBXRktQR1IxWFp2UVpDdzRidVJ6YmVDeERwNEJiQ2M4ME0vaFdtSmFC?=
 =?utf-8?B?cGRRTWRBZ1BXS1l0Ni9IV3pDMXNwNllsMkFFWTJuR2l2MTFQKzZhbjJQU2J5?=
 =?utf-8?B?WDc2aTdzWFRFZUFrQ2dCcTZyWXBMVFJ4MXduZkxEczBBMWg2RXhBUXkxb3pU?=
 =?utf-8?B?akNvcTAyQi8zU3VIU1h1b3A3SDdtTGxOeWFxN0dGL0JHS004RU5RMWJJZDJI?=
 =?utf-8?B?MHpzMWdlL2JZWTRSampkRVBNWjk3ZWEzZmdUNm90WEREVFVpaHFZWlJ5NjdE?=
 =?utf-8?B?MkVCUGNMbUQyR1EyRWVBclVJWG05OURIRVlRcHJMSDdDdlExYXI2ckIya1Jm?=
 =?utf-8?B?bHViakFkdkMwVmoxbTZkRmlxMDBJODBMZHNCUm1nd1pFU2JXV0xlK1VueFBV?=
 =?utf-8?B?K3RyUGR6Q2c1d3haWldxNWJFaFF2NU55dm5IRVlaQnlCeTI5akhabXBpMCtN?=
 =?utf-8?B?WCtWQStiektGaURRWXZLSmtBQzZYZVFIVWp3b016aEtPdVl3Um1kZFVMbHA5?=
 =?utf-8?B?N3g3cUoyN3F5Z2RsQnI0U3FPQ0lVVjZBMURIWnY4NDNrVGVhWmdYMzRYblhG?=
 =?utf-8?Q?x6AL4hTcIJS+SAN2qk549jjhokmpqad56q8hkVMHLeJr?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <EEBA620BF8FCF6498E085894BD01F0D5@namprd12.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: b55dd8d5-08ed-4402-3ec9-08dc329e8782
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Feb 2024 05:32:43.9373
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3daJr4I59HNHXh5Ydm1qACHp0ym53+AMeXdLNNML3D7mwkd/rVYFiPTqBOw//p8hqSZWS7lSvWNZEahYpZ08PQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8723

T24gMi8yMC8yNCAxOToyMSwgS2VpdGggQnVzY2ggd3JvdGU6DQo+IE9uIFR1ZSwgRmViIDIwLCAy
MDI0IGF0IDA4OjE2OjI5UE0gLTA3MDAsIEtlaXRoIEJ1c2NoIHdyb3RlOg0KPj4gT24gV2VkLCBG
ZWIgMjEsIDIwMjQgYXQgMDM6MDU6MzBBTSArMDAwMCwgQ2hhaXRhbnlhIEt1bGthcm5pIHdyb3Rl
Og0KPj4+IE9uIDIvMjAvMjQgMTI6NDEsIEtlaXRoIEJ1c2NoIHdyb3RlOg0KPj4+PiBGcm9tOiBL
ZWl0aCBCdXNjaCA8a2J1c2NoQGtlcm5lbC5vcmc+DQo+Pj4+IEBAIC0xOTAsNiArMTkwLDggQEAg
c3RhdGljIGludCBfX2Jsa2Rldl9pc3N1ZV96ZXJvX3BhZ2VzKHN0cnVjdCBibG9ja19kZXZpY2Ug
KmJkZXYsDQo+Pj4+ICAgIAkJCQlicmVhazsNCj4+Pj4gICAgCQl9DQo+Pj4+ICAgIAkJY29uZF9y
ZXNjaGVkKCk7DQo+Pj4+ICsJCWlmIChmYXRhbF9zaWduYWxfcGVuZGluZyhjdXJyZW50KSkNCj4+
Pj4gKwkJCWJyZWFrOw0KPj4+PiAgICAJfQ0KPj4+PiAgICANCj4+Pj4gICAgCSpiaW9wID0gYmlv
Ow0KPj4+IFdlIGFyZSBleGl0aW5nIGJlZm9yZSBjb21wbGV0aW9uIG9mIHRoZSB3aG9sZSBJL08g
cmVxdWVzdCwgZG9lcyBpdCBtYWtlcw0KPj4+IHNlbnNlIHRvIHJldHVybiAwID09IHN1Y2Nlc3Mg
aWYgSS9PIGlzIGludGVycnVwdGVkIGJ5IHRoZSBzaWduYWwgPw0KPj4+IHRoYXQgbWVhbnMgSS9P
IG5vdCBjb21wbGV0ZWQsIGhlbmNlIGl0IGlzIGFjdHVhbGx5IGFuIGVycm9yLCBjYW4gd2UgcmV0
dXJuDQo+Pj4gdGhlIC1FSU5UUiB3aGVuIHlvdSBhcmUgaGFuZGxpbmcgb3V0c3RhbmRpbmcgc2ln
bmFsID8NCj4+IEkgaW5pdGlhbGx5IHRob3VnaHQgc28gdG9vLCBidXQgaXQgZG9lc24ndCBtYXR0
ZXIuIE9uY2UgdGhlIHByb2Nlc3MNCj4+IHJldHVybnMgdG8gdXNlciBzcGFjZSwgdGhlIHNpZ25h
bCBraWxscyBpdCBhbmQgdGhlIGV4aXQgc3RhdHVzIHJlZmxlY3RzDQo+PiBhY2NvcmRpbmdseS4g
VGhhdCdzIHRydWUgZXZlbiBiZWZvcmUgdGhpcyBwYXRjaCwgYnV0IGl0IHdvdWxkIGp1c3QgdGFr
ZQ0KPj4gbG9uZ2VyIGZvciB0aGUgZXhpdC4NCj4gQWxzbyBjb25zaWRlciB0aGF0IHdlIGhhdmUg
YmlvJ3MgaW4gZmxpZ2h0IGhlcmUsIGFuZCBhbiBlcnJvciByZXR1cm4NCj4gd2lsbCBza2lwIHdh
aXRpbmcgZm9yIHRoZW0uIFRoZSBraWxsIHNpZ25hbCBoYW5kbGluZyBoZXJlIGRvZXNuJ3QgYWJv
cnQNCj4gaW5mbGlnaHQgcmVxdWVzdHMgKHRoYXQncyB0b28gaGFyZCk7IGl0IGp1c3QgcHJldmVu
dHMgY3JlYXRpbmcgYW5kDQo+IHdhaXRpbmcgZm9yIHRoZSByZXN0IG9mIHRoZW0sIHdoaWNoIGNv
dWxkIGJlIG1pbGxpb25zLg0KDQpjb21tZW50IHdvdWxkIGJlIG5pY2UgYnV0IG5vdCBuZWNlc3Nh
cnksIGlycmVzcGVjdGl2ZSBvZiB0aGF0LA0KbG9va3MgZ29vZCA6LQ0KDQpSZXZpZXdlZC1ieTog
Q2hhaXRhbnlhIEt1bGthcm5pIDxrY2hAbnZpZGlhLmNvbT4NCg0KLWNrDQoNCg0K
