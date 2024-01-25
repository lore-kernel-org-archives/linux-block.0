Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2041.outbound.protection.outlook.com [40.107.94.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADDB71BC26
	for <linux-block@vger.kernel.org>; Thu, 25 Jan 2024 08:58:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706173082; cv=fail; b=XOz03evMK4SyOfdKV5tdvWc4hcCBbvevsvabWDU8BpkbQKcL3Fj0eH4zNltofGhiZYsPItmvLHI4AZIiNwUuRpCO9TOffJ6hA2ThQv8yB2LilauaLpgSvV0RX7ZkaQoviXDwH/VSNRy1SRKu/ArCigmiqDurY3zmC3wcwwe9tE0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706173082; c=relaxed/simple;
	bh=tHk06XkzTPH99Rymf6Jn0uUuDozplg2Qa2eOqsPLvFI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=UvFTB57G3KI132x9xiikqSXBpVRlj845TH6ZFXCfI9OH3DI4O1WeARFG2AUXgl48GLW7oUh57CM5j5kxvDrbbNHM5JTdRV/7ST6RP7nbnXRjL+RgzGG2A6Nldfw6pOyPzwu3CayPexfHz7sttkz4E8t4u/AD3YAralPQeoSGWtI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=MLep3DCx; arc=fail smtp.client-ip=40.107.94.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="MLep3DCx"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S/bSGt9k1rb9lmP6KO8qFNfkLkFpCwyhObBpa1VKi1M9IiueSMMac8PXh1tXiUzEkaZjDUUOgDRbAb8IYb6QAOvMFa1F+obCdJLXGFipHm3w9Gf2s0YsYilARwr1ctIfuNCX2mJBI0NSXCH+tCS9fyyzu5pXyvOoS+fgYikZRPoeTP5Yaku17KoSeXg7NrW/ghXPgMVPcLik/tWS2ZKrqQloT0luxAxssEmHUjbC9RlIhtmbAaAO3X4ReiYkcnzo9t/KQOa/Wajx/837gnZe6mpeiFIdJdE33+Xpx4FWj1/NmnNSAw5aNV4OK/lQpNQL773lwFEMewKP4Bi0WcR/pg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tHk06XkzTPH99Rymf6Jn0uUuDozplg2Qa2eOqsPLvFI=;
 b=ANhiws3Wk2oKzZ7H2LwGNiYoVLh3nbBdwbJ1gPrIypSOyfej+Xz4idMoAvaNFU+dKJZTzhvP5K6jRPdwhbEATlGxrKfU0E8AUNXAZTcaKuEKc6tMiOniW82V8qEVPDHfbD2zleeWkjz44+C88UE4Rbp3vS1nKaKdF63bwgQ/RJ9AEZRcX7om3G3X8QLSvJp0SIdHjWGwGfAqmS93LnWYTpJISHBv9ZUuwyeYEydFGmYLap2uBf7iBlizx6sUBmzFY9yKnlQm19zXYzZbQ6OiIg5uh5cSFYW+JBQGvdrnlHbCYPxfdVqVtcS6ZDG6C0oEIkBDU9eNCmlO8HfmC3W3wQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tHk06XkzTPH99Rymf6Jn0uUuDozplg2Qa2eOqsPLvFI=;
 b=MLep3DCxbIaiCvNbl/tozYno9wgH349xWiWsmB2gxqdYvRM3o9gB8/7EsuS7zU+WlCgCtAlX9f469+9xVtCZpo/+QOxT29Mn+CgIrO3IK9AX42AYHPN3JPTjhf50kF0T8LitiFv0uQGg2ieuMLmB30ymDdVlkjfJpiKzepMGCNmYAq0woY9kGVDwsTu9R+k4V6OnGYB6k1hNctgVWPI5oXJ36+Eb9iuT22vuj6BtbaAU+cytivbq2RnzOebqVWv8KB1aAXnYgp4IlcAtAUiPtBqeESRWnesvERSQNmQK9yw1HXUOAIiBUubUlE/NPDspuGQNXpgVu7+9ZZAw9xi+Mw==
Received: from LV3PR12MB9404.namprd12.prod.outlook.com (2603:10b6:408:219::9)
 by SN7PR12MB7977.namprd12.prod.outlook.com (2603:10b6:806:340::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.22; Thu, 25 Jan
 2024 08:57:58 +0000
Received: from LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::ffce:bbde:c1ca:39ed]) by LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::ffce:bbde:c1ca:39ed%4]) with mapi id 15.20.7228.022; Thu, 25 Jan 2024
 08:57:58 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Christoph Hellwig <hch@lst.de>
CC: "axboe@kernel.dk" <axboe@kernel.dk>, "linux-block@vger.kernel.org"
	<linux-block@vger.kernel.org>
Subject: Re: can we drop the bio based path in null_blk
Thread-Topic: can we drop the bio based path in null_blk
Thread-Index: AQHaTdlGIGiGKoqxwke9v0ex+jH9wLDpbOeAgADElgCAAAv+gA==
Date: Thu, 25 Jan 2024 08:57:58 +0000
Message-ID: <f2f14d30-7192-4a8e-ae5e-246e3c081eea@nvidia.com>
References: <20240123084942.GA29949@lst.de>
 <znc7pqdsqkznoszbzhvxyyphmpqbesjh56ygn5xt5fjej4glvc@mcccy2dky5eg>
 <20240125081502.GC21006@lst.de>
In-Reply-To: <20240125081502.GC21006@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9404:EE_|SN7PR12MB7977:EE_
x-ms-office365-filtering-correlation-id: 7e09e1a8-02fd-4bb5-a519-08dc1d83ba27
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 aWR+H+vZIhhEJ+y4NYt2+wsvTlf8HkRaldmFBQk3Kyymzg7sfrrAwk0zfKhXkGl39vL5n2nM1g/N08evDCLB/TMUo5RUt9a0FuoxR2t8ohEPyS4tJasYqGvmwJZaRE4Y2VYTexvEK4u1GGXCYzUZRM8/MrWNhNdwfwqiiQaIglDvT7ciLuSnWie70QZZCLIHMwIG5LcirAZ+yaih+oe7RgX0fZAIEikEZcborxtxjBFCf+QqY8scna05qNgshYnaCMxuuUZcdu6yuxt+Q2Y1889XRZXUraVJ7y3DU8fBgjMLmVz9A5rVatoMfJQhotLX1lxFNKJICixZUgwLVzrILJl0tWJnHGo1Xz+Ox70GMCWT9cPmV0zldrOI0z0v2M3Og40cmyB0BYTTnjTE5XvHz624ZKocJHkGVl7RP6U4aoYrqVcqn1GF0+8o+P8PPgNUNyseG77ewx9365kNwm1QlxSfKRzyaIMLIl74g+GXLznNlIRAGjlBZVMkOlI3ajdydXYfuH0amF6KgW6Nj3wXrC8IDws6py5YeThTs6YTUErcxOhls/xL97BSxuT39ToSsEhma0OyM8yhvzz9pUG4zdeFKpg2wDVDLGweEW1dW5tR5JY7VD9Kgq4q+j6RvQNeq7af+tybx0DwObXybI7kPps86eI81lYzILeUyWJsz3AG8FkCaDu+dH8sFIdxKyMK
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9404.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(346002)(39860400002)(136003)(396003)(366004)(230922051799003)(1800799012)(64100799003)(186009)(451199024)(4326008)(66556008)(8676002)(8936002)(66946007)(66476007)(76116006)(64756008)(316002)(54906003)(6916009)(91956017)(66446008)(31696002)(38070700009)(86362001)(36756003)(2906002)(41300700001)(5660300002)(6506007)(38100700002)(53546011)(31686004)(6512007)(122000001)(6486002)(71200400001)(478600001)(26005)(83380400001)(2616005)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?SGJFN3kwQldQRWRWNTRpV1cxOGJjNHhuOEdkcm9KK3g0UmRpcVJFYkkrajJR?=
 =?utf-8?B?dVF1Tk1vcHZDelhidzV0NjEvbXNBQjVlZFJvWEl0WUwxYmlIdGVjQ1lrQTJT?=
 =?utf-8?B?Y2N4K1B0RXJXcUN3WDg3eWdUeVhOTzFXOHFaN0dCNVpRak93ZG9QcVFTYi9N?=
 =?utf-8?B?OS8yZjZPTzhGU2x6VjZsZzlNaHhvNG1pc3RuVVY4Q25qREZhclZrU0NPUVlW?=
 =?utf-8?B?bXpoTTJwME9BWnI3U2FmMFBjOFg4Si9JSmtwcU91WUlnRHJDTGdNZkdWYXkv?=
 =?utf-8?B?WG13UUQ2eXVnZFVCNWtwSDUwblZJa09qQ3o5dU9lYnIrUWdJek1IVFMrMzBl?=
 =?utf-8?B?Q3VaaWRSdGJkK0V1NFVOWnAyd2tmZkswRTVwcDVWN1NTUmt2VkoxQUZWQWRm?=
 =?utf-8?B?UUNMMzdtNU1xMEhzYVB5Zm95d1V3Mnp4OW9tL1ZTTFFPQmhBYVprVm9CUTY4?=
 =?utf-8?B?VmprclF5NlhLL05IVDRoNzFkV24vNnRRMExlZUx3NnRoU1FpNkZkdlpDbjJH?=
 =?utf-8?B?L3MzbUlFTXo1Ri9uNFFxV0o2TE9CWk1JSmt1QzJuc0N1bHYwMlJ1YW5UNnlq?=
 =?utf-8?B?aUpJa01tV0txbkNNVEpEZVhCUUdlUlUyM045UjlqZXg5cmI2U0d1akI0NzRZ?=
 =?utf-8?B?R3BWaTVSem9lM3RLNXVpSmIyTVR5Z3Robk5NeGxmMU5RZUFEWkE4VlBnZjdh?=
 =?utf-8?B?cG9QTWNHZndoc3gwbkU1RGgySUFwTVlKc3ZpZURJN3Y1dHh1eGJaSlRoejY0?=
 =?utf-8?B?c2hVTnNBeDkrRnhhWGhnQkxtSVV6cGY1aS9IakZzU3FKWFY0UzdmU2ZMeU1w?=
 =?utf-8?B?TFBtZXRkUGVORG00NUYxc3ltTWpzM2t1QmVSVkwrdmJQMkpPK0Q3SWI4Vkwr?=
 =?utf-8?B?SWtYWXdER2x0K3h6azdlbmZtd01EYlk0aUE2WDZ4QjNFbUVWVnk4VTRoUEJ1?=
 =?utf-8?B?d3d0NFRFWFNLOGtnSWl2Nk4yWEVhN2ZiMVU0dVJGcmJsK1J3K3g3T3BzVHVu?=
 =?utf-8?B?SWpiYzlsOVhJclBkbEs5NWMzWUl2V0tpUmRGUUFlVHBMRDU4M3Y0Um1zQ3d5?=
 =?utf-8?B?UTBVSGQ1NEVrSXVyRXJYaDJDdVlYMjhzR0krVFlndjlZdkljVkdNTGhqNCtT?=
 =?utf-8?B?TmVqRkxtZFlCejlHT3N1WnZMUC91N3R5QUEvSEFkU3pQS2J3U2MrV2VydHBx?=
 =?utf-8?B?dDJqTlhEeFlRV2w3S3NrV1hoZ3FaT0lyNTZvcFhGcmprdVpYQjFTZ1pKUlF3?=
 =?utf-8?B?Y0dxZjNQQ2tWQU1BbVQ0WkRSUHc0ODBHbUhvRjdhWHAxaVpua3dRdlRwcWEr?=
 =?utf-8?B?YVpOTFY3ZlRsVlhkVTJSQVVwYnNJZEl5OEFaRjBxNDZ5NWoySjNNK00zZmJX?=
 =?utf-8?B?UkF0K2d1Q2N6eDFDdjExdHFrQmlIQ0hTMFU2TkhvMXZodUo1TWQ4WFlCV2xD?=
 =?utf-8?B?QWw1bGc3M0FnT3ZiTWtMdE1qZkxNdUxVQ2lpYzREa2V5NmtZdmNzaUtjaTVj?=
 =?utf-8?B?VFJSbjBwbDBEdllnQ1RtNkxFNlVpRURuRVpBUHFibUVWWHJDR3hrM3dmTzRt?=
 =?utf-8?B?MjJDLzErdEhYdm9CaGRBVmV1a1FZaXRBOUNRei9DbHlJb0pDdXBpUVNhQlc4?=
 =?utf-8?B?TldXZjRIK0UvSHR4dGVZQjFYdnNEbHZOVytQYTVHNnFRQlJBOGR0UWVWQzZ0?=
 =?utf-8?B?UXVrL0RKam95a0lSSVNDTk15dGNkdjZiVGJPdGw4a3paM2cvUnV2WlFMWll4?=
 =?utf-8?B?M1dNS0R3azI0cE5OdVhBQ3BkY2tkNUlEc0EweFZUTGFnekR5YTFTeng2OVkr?=
 =?utf-8?B?ZEJ5WndEenJoeURkcUliWFpzVGpNajFwUkF0UWtXRm8vTlErMDZIWkFMb2xi?=
 =?utf-8?B?M0o2cG1lc1VpSlFldGlCNDdJSkFZcGxaSVl0ZlkycW9kV3krZlhVQlFvRjZ5?=
 =?utf-8?B?YTJXK2plcUdoMVhGbkRiVnRJdzdYNURLa0hKWWlEZGJDencrcFNZdDB5TTUx?=
 =?utf-8?B?dlNVNDFobldCYVdtM1pHSXlGVjNvcEsrNy9JTmpPcWlHV2EwMEFJMnp2N0w5?=
 =?utf-8?B?STBNeXRBQml5eDVqRmtUWFY0RnJJanlJVnBtVDZYd2FuZzdSS0RUV2VpSlox?=
 =?utf-8?Q?PRp+cG8nZdgLb9TooJ5g8eQUA?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <3251E664F75CAB42A550B7F39D24A011@namprd12.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e09e1a8-02fd-4bb5-a519-08dc1d83ba27
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jan 2024 08:57:58.0195
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dm76vlQ7dlHrFv+bF9YAKy9W1uRJhcmQ6Xfh1f7/2FOpljm1sgAdWgpMPc1WO/osFW5Mm6c/zrVpeTNqOutxMA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7977

Q2hyaXN0b3BoLA0KDQpPbiAxLzI1LzI0IDAwOjE1LCBDaHJpc3RvcGggSGVsbHdpZyB3cm90ZToN
Cj4gT24gV2VkLCBKYW4gMjQsIDIwMjQgYXQgMDk6MzE6MjVQTSArMDEwMCwgUGFua2FqIFJhZ2hh
diAoU2Ftc3VuZykgd3JvdGU6DQo+PiBUaGUgc3ViamVjdCBzYXlzIHJlbW92aW5nIHRoZSBiaW8g
bW9kZSBpbiBudWxsX2JsayBidXQgaGVyZSB5b3UgYXJlDQo+PiBhc2tpbmcgYW4gb3BlbiBxdWVz
dGlvbiBhYm91dCB0aGUgbm9uLXNvLXJlbGV2YW50IG9uZXMgc2hvdWxkIG1vdmUgdG8NCj4+IGJs
ay1tcS4gTXkgaW5wdXQgaXMgZm9yIHRoZSBsYXR0ZXIgcGFydCwgRldJVy4NCj4gV2VsbCwgaXQn
cyB0d28gZGlmZmVyZW50IHRoaW5ncy4gIE15IHByaW1lIGNvbmNlcm4gcmlnaHQgbm93IGlzDQo+
IG51bGxfYmxrLCB3aGljaCBpcyB2ZXJ5IGNsdW1zeSBkdWUgdG8gdGhlIHR3byBkaWZmZXJlbnQg
SS9PIHBhdGhzLA0KPiBhbmQgYWN0dWFsbHkgYnJva2VuIGluIHRoYXQgdGhlIGJpbyBtb2RlIGRv
ZXNuJ3QgcmVzcGVjdCB2YXJpb3VzDQo+IEkvTyBsaW1pdHMgdGhhdCBjYW4gYmUgY29uZmlndXJl
ZCwgYW5kIGF0IGxlYXN0IGluIHpvbmUgbW9kZXMgYWxzbw0KPiBvbmVzIHRoYXQgYXJlbid0IGNv
bmZpZ3VyZWQgYnV0IHJlcXVpcmVkIChJL09zIHNwYW5uaW5nIHpvbmVzKS4NCj4NCj4NCg0KRm9j
dXNpbmcgb24gbnVsbF9ibGsgOi0NCg0KcmVtb3ZpbmcgYmlvIG1vZGUgd2lsbCBzaWduaWZpY2Fu
dGx5IHNpbXBsaWZ5IG51bGxfYmxrIGNvZGUsIGJ1dCB0aGVuIHdoaWNoDQpiaW8gYmFzZWQgZHJp
dmVyIHdlIHNob3VsZCB1c2UgYXMgYSByZXBsYWNlbWVudCB0byA6LQ0KDQoxLiBFc3RhYmxpc2gg
YmFzZWxpbmUgc3RhYmlsaXR5IG9mIGJsb2NrIGxheWVyIGJpbyBtb2RlID8gZmlvIHZlcmlmeSAN
CnRlc3QgZXRjLi4NCjIuIEVzdGFibGlzaCBwZXJmb3JtYW5jZSBjb25zaXN0ZW5jeSBvZiBibG9j
ayBsYXllciBiaW8gbW9kZSBkcml2ZXIgYWNyb3NzDQogwqDCoCBkaWZmZXJlbnQga2VybmVsIHJl
bGVhc2U/DQozLiBXaGljaCBkcml2ZXIgb25lIHNob3VsZCB1c2UgdG8gY29tcGFyZSB0aGUgYmlv
IHZzIG1xIG1vZGUgcGVyZm9ybWFuY2UNCiDCoMKgIGNvbXBhcmlzb24gd2l0aG91dCB0aGUgbmVl
ZCBvZiByZWFsIEgvVyA/DQoNCm9uZSBjYW5kaWRhdGUgY29tZXMgdG8gbWluZCBpcyBicmQgZm9y
ICMxICYgIzIsIGJ1dCB1bmZvcnR1bmF0ZWx5IGl0IGRvZXNuJ3QNCnN1cHBvcnQgYmxrLW1xIG1v
ZGUgc28gIzMgaXMgc3RpbGwgYW4gb3BlbiBxdWVzdGlvbiBvciB3ZSBkb24ndCBoYXZlIHRvIA0K
d29ycnkNCmFib3V0ICMzIGF0IGFsbCA/DQoNCi1jaw0KDQoNCg==
