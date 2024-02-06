Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2060.outbound.protection.outlook.com [40.107.244.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A8141C68F
	for <linux-block@vger.kernel.org>; Tue,  6 Feb 2024 23:10:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707261044; cv=fail; b=VM9xWJFbC5uLoPc3UIYA4dfV07QH/F7FcX8cYsxCM8LdR/v+fotzO1HfAelRz0P4mpO4xWMYXrCQU+9XNKYalr9GVq5rKKbPBMrhokqUzW9PRzpmov6oq9X3rHBJeO96zboCGBNDbspmEHe+yBQtLyA1NxKlXN6Gm3lBLTxDMvY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707261044; c=relaxed/simple;
	bh=WjBrGKunloE5npBwMbpwAFxTXfeLwMj894OC7ewNmR8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=uUhCehUAGWScgyCX0cJZmzG2jq3fDtSpDS0L4w2qwScgWDKlYGabDz1PTSTOignipmF6jKvigIXPv0gHnKtvbGMF0FELJKThDWcozsyf6KZNyjJIM9481uk6k+Ru5QOY/gmNFzibL+bigQyekRyF6nxc3sQsNt5+3Exsm7zamoc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=tXtHfzAm; arc=fail smtp.client-ip=40.107.244.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="tXtHfzAm"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XHVh2k1Y+EHATb6ZHZA1xggB0ST+/pec7vH4h7IEaezLCZkCsEiruQCPpw87VFYA/goc2wxHy+Xf0gKiKEMPE6fendW0jh6RRGshywYBe4ZnSwwX/dG7wXXPqeZWwyubLqkQE367QXxyo6wqOxAxG3IAo+KKUlqxKyIoVZLI0CewFxOF52oxa+w8/6rMCIX2bgXf+YEqCSCgIWJatqJX1YrhAviAf3S2XAJmmKzITbjuVpN0GHsKpTW0VCXPYn8+IpuppgjFKCxv1M6hRS1SRP7lqVwxUekkywgpSQiVCvitcX1i9BkFthms/0J1leF8+CJ/+Sy+BCf8WgQarlOZBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WjBrGKunloE5npBwMbpwAFxTXfeLwMj894OC7ewNmR8=;
 b=IRJcFQV1smH+H3KK1NYS3nlcfPmWlYvGt4JLPaA+SNmMx7LGJx68JiHWTkfkmmMSi9kfU/qX9h2vMcsgImrQXhgbHrRRPgwj+8S7S94gFTEkhzDRWu/J1mCo4s96FXdnp4Ou20LZTVFAHfcH1Qzj9cdVpNW/S7iSP1CgLRhoGiY5PG/vlv9NTYwad8Yz4NWcsBZY0T4WI+XiymiCSdDsVpfIGRTPo/NaJ8R81CDbzqkDmJynzL3SBeVzOxxh/9feSAQGlX+jlMja8FNARjNQjV+hAsxcJ6gi1YZmLZSddhNPfgxmsXDT0urDXKm3VOZku+A8lMIxZmngEt6ItzV7pA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WjBrGKunloE5npBwMbpwAFxTXfeLwMj894OC7ewNmR8=;
 b=tXtHfzAmJe2jxWyj2cGjtjwcDKTp99XQ1grF6IReZWGhAbbKvKWx9JCw/YBIbTauASILIjrjpxFsUGnDn7MV0xpUPGpyIbuEiE7ui6Wz9Su3b7Crz9WLfvj9bBmhgS2k69GzEXzGrQtC9cCLvdXVufnhiLzA62SIETC7IlIAQFCNMp8CQEYEPxdjghSLnCzfepIL4Zf3u7b8FtTYWc7VwmbYe4PqYoIwULLynr4lQq61slyCPv8lCF417R+6i7I5Y8NNtrf54GBkxljOI/LM6NnLBAZqvm3Sk/WQq68oWPQZNZSgTEr9eEtcZkJgUPEjL4vUFfzBU9mdKl5CTukmpQ==
Received: from LV3PR12MB9404.namprd12.prod.outlook.com (2603:10b6:408:219::9)
 by DM3PR12MB9285.namprd12.prod.outlook.com (2603:10b6:0:49::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7270.15; Tue, 6 Feb 2024 23:10:40 +0000
Received: from LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::ffce:bbde:c1ca:39ed]) by LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::ffce:bbde:c1ca:39ed%4]) with mapi id 15.20.7270.012; Tue, 6 Feb 2024
 23:10:40 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Daniel Wagner <dwagner@suse.de>, Shin'ichiro Kawasaki
	<shinichiro.kawasaki@wdc.com>
CC: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH blktests v1 5/5] nvme/rc: revert nvme-cli context tracking
Thread-Topic: [PATCH blktests v1 5/5] nvme/rc: revert nvme-cli context
 tracking
Thread-Index: AQHaWP7XZwf1IjVVAUeoNH38PNeJXbD98WkA
Date: Tue, 6 Feb 2024 23:10:40 +0000
Message-ID: <e7ace2d5-1c13-47d5-b9cf-d0df22c995b0@nvidia.com>
References: <20240206131655.32050-1-dwagner@suse.de>
 <20240206131655.32050-6-dwagner@suse.de>
In-Reply-To: <20240206131655.32050-6-dwagner@suse.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9404:EE_|DM3PR12MB9285:EE_
x-ms-office365-filtering-correlation-id: b7657f2d-481d-4491-95aa-08dc2768d631
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 YunMm7uUCMdiHJVbgW+L5BQiT8tVpNQnMFZW8D6woOQJ/d/c4ZL4npSLrbi0WYt03Z/99C3RwuKqvXXimWfyMW0h7ceidAYmzk/++Sai3pNJhqJ8IxnrQFEVY6pczM9WtmSN62YqsGb+dhQbHPEEZlmGvqflUtxPD+adW2o18UPdOR+C0Crpzyg/WKKFv5bf/V3aJk9EeVG8a305F4H1nIyHS8SkfolBLCtRuGIHsYCSvz7Ln85vfxrmGopkzadcsoX6DuyWYNs9SBQYimTpvoS2mGrS4xbEXzJ1y8qfcbvJC1EHHp+hbbOpf4HqPghN+Di+zFLd62QHYYR0TeY1KKhJhTNUUoZunCt+209oG25iwhovW+4SGU0hT30XoYRU4IVqr/qWgmqpm3ZViV3Xk5x1U9NxbcHWhuOVOngjEydouOAazhoXSCbxLDhdJ8BhukZAkom4inovl0Th1Q29MAMICXEdo2WlpyV5hQ78qQ5xhuqqrPDNfnwwEuDMu0SHHpfh1Bl1RkStsjDHFY66YCtS0A8jCTInxy4mSv3R8JiNB1nf2/VgRXrJYTISoyq6xRsYuor77troaZN71BaxdZlGTpNVQwfVFfDGsF5ud+1qFgJbitTj07GVLBdFX8eL+bSqZCiRfIuH1ynSkwPAVIjtjH3Ja0bpZVDvKMEYY+csgXwDKQprTir3FUcHPv0x
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9404.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(396003)(366004)(346002)(376002)(39860400002)(230922051799003)(186009)(1800799012)(451199024)(64100799003)(41300700001)(86362001)(6506007)(71200400001)(478600001)(8676002)(64756008)(66946007)(66556008)(66446008)(4326008)(6486002)(2906002)(6512007)(53546011)(76116006)(5660300002)(31696002)(316002)(2616005)(54906003)(110136005)(38100700002)(91956017)(4744005)(122000001)(31686004)(8936002)(66476007)(38070700009)(36756003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?QVNCR0VDd01XNFpjeGNuQUhKRE5RbVYzcHBjY3ZyYUR6Nm92cE10c3ovcEhq?=
 =?utf-8?B?OTMzVVgyeGlEMlRiM3hJVG1xd1F5RDZNeFhKVG9nQU5GWDBRZlNGUG1qdDhV?=
 =?utf-8?B?MkpCU29XdnFwNERPaXVwWUhDajJjTUxJQjdQRVRCbVhodmJ1dFVaeCtqaDZo?=
 =?utf-8?B?L1AyUjVCOHo5TC9zZjZvMlBSY0FSQkZvem4zcG1PZVdDRmFGUUpNU0Jhem85?=
 =?utf-8?B?eld2OWVOTWpkUDR6ZE5HNDlKUFJDRThUT3Z3QlFjRlJUZU1aSGlNYXB3L3VE?=
 =?utf-8?B?b1lwL0hnTDFscERraW9KMlpYaGllWXVKdDQzUXpabEhDV2w4RzNoeXlqQXdS?=
 =?utf-8?B?YmZUeUlqK3ZKTnBwSm04ZDFzWDE0eHNKL3Y5b1Q5bXlrWXBlTGZ6a0djb2xv?=
 =?utf-8?B?cTJ5L3gyYk02KzlheGNHeTRYbkIrcUVuUDFIanFud2tCS3d2UWdPS2FQNGRq?=
 =?utf-8?B?UmVEYzdIN3NYOEwwMkRJSVNkVUl5UGp1RnNVM3h3OXVBa2hKWU9QWFUwR2sw?=
 =?utf-8?B?YTh1SE5jZzMzUWlwQm1TL2MvNW9NTllrRHlCZjJhTFdoWXY3aVdPN2FXZkl5?=
 =?utf-8?B?T0dDejEvUGN3RGl2cmhFMXVZcjZuYmVFUXhTN0ZheEpSazBwYy9lVmxRZThC?=
 =?utf-8?B?TkNxeE9YY0hMVFFaaVk2WVFXUUZrVkVzeEhCNlV3QVRodm5xa1NKTVIwV3BD?=
 =?utf-8?B?bDdlaDZpM2QrYkNGVWxtZnJBL0V6eUFuTEJucjFVNUJsTjdlSWVuREt5U2tq?=
 =?utf-8?B?K3ppZkd1dHBZcGJpSjRsUVF5TG9TMVJrc0UxNUJENEhiUEZ6c3RvVkdqcFY2?=
 =?utf-8?B?M3JzNkVxUzk4bmU1S3NKdDdkRlR0d0V4OFJNemNSZHJ3dTVxVXN5MmdjNUJT?=
 =?utf-8?B?Zk1FVVhWL0ptWG04VWh1bDZsdmFmL1JtY1FBSlBZZHJNYVF1MmlkRkJSakg0?=
 =?utf-8?B?Tk1PdFZ5emwwSUdPUW5heHFPQ2pRbDNWek4rV1pHbFJwNGI2eGJTRlVLWmNk?=
 =?utf-8?B?ZjA1Qk5RVURteVRJZHgwUmhaRmhsVENZaEtYdTJIdGgrWnFHTjlwN201QW1K?=
 =?utf-8?B?MkpyZGExMjE3RW11aS9OQ2FOQ095NVlySmFXUmVDWUVpL1V6N2NOV1FGS2Z2?=
 =?utf-8?B?Z3hIUnVmTkdpbnBhWmZnaEZtS0RkUk1GUXA0MnhiK3NGTTFHSks5dDJSRmM4?=
 =?utf-8?B?dDVrUEVRbHlydjZ3SElad3BReUNQdEVhd0J4MDJnM0tmeHhuMGhaNXlzWWVh?=
 =?utf-8?B?TlcyZkVzNWttZXdvQ1loUHFDTCtXNWFyYnE1UHhRTG9wdDRJcDVPVVNYV3dv?=
 =?utf-8?B?SkpnanBQc3VreG9KMDFiQmJzZ3d4bnJNMWNUeld1NnlORVRRc08zcUlyMW1t?=
 =?utf-8?B?NnVBUUFPYk9oWVNLOHUrcnYxMDlRTFJKeEloMEVsNVJOZ2tnYnFsVk84aUtz?=
 =?utf-8?B?MHRidm43LzhEVHBISnVpYXBSdVgya1pmM0djYktEaEVIMllNSldLak1ydlZZ?=
 =?utf-8?B?VHVmYnVzbUZSR0JTSVFZclJmN0c3N3gvL3RGQXdZcndXbHoxVFNsTDVUTnNE?=
 =?utf-8?B?NlBYS0NHQnl3cWNESExYMkNndVBCVHFKWjRSazIvTG5iVExFNVo2YkFPWkRy?=
 =?utf-8?B?NmpGSmcrR1lYNExpQVcwLzFyK2hYVlpZQTJ3VTlBK0c0S1p6QUlNa0kycVl4?=
 =?utf-8?B?VVVNRWxLUTlSYWFBdVc3ZVUvMndiNnJER3pjR0F5TkRDSUt1ZFFadFNvZmZw?=
 =?utf-8?B?dVRKVjZud3JqWnF0U0djQzlCK2R0ODhRYkVwSkplbm51NXB3ZUpPR2ZCU2J4?=
 =?utf-8?B?aGE2OUtBTWw3dGwzczhjM25DSVVmaWVFUnhETERsNi83NkxvM202d3JxWUd4?=
 =?utf-8?B?NWQrZzRucW5SaUtoNXlNRDd6Y0ppOUpmNG1Za3VQekhlVlVYQzV2VmV5R2E2?=
 =?utf-8?B?MzRFR2pUZEY0N2U1STZHVlhLdHJJcGpVdjM3TW16UUVIckNIWlpUM3FXZm5m?=
 =?utf-8?B?ZGgwMVJkUjVoeHJNYzY4MFpTdEZtdUhNdGhWMmZzMk9NUzE1U0dra25UTWdo?=
 =?utf-8?B?ME9rUjFRSlZSeUpZZEo3OHcxNzhxWjFGTlFkZE9SaVJoR2d1eWRBWmJkLy9q?=
 =?utf-8?B?bVp4YUJpV3hyc1kxZHZkTHpBK3YvbiszRTRrb01FOGFuTjZjMCtENUc2cVRs?=
 =?utf-8?Q?JnRMVAciZoo6XmsioC4AYvfGnE39/WkIOPMvNuubeTIa?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <83D0D7F7F54E1E4B9EC13FD81868CA60@namprd12.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: b7657f2d-481d-4491-95aa-08dc2768d631
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Feb 2024 23:10:40.2972
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: B1junrPFP2b9o+Aoluzlim+4WY8DhSXPXuehruOAOz3k8D77b0A8hIEqloC3YA2WgkPs7PrDHlfNjx3fsjmVww==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR12MB9285

T24gMi82LzIwMjQgNToxNiBBTSwgRGFuaWVsIFdhZ25lciB3cm90ZToNCj4gVGhpcyBmZWF0dXJl
IGlzIG5vdCBuZWVkZWQgYW55bW9yZSwgYWZ0ZXIgZml4aW5nIG52bWV0LWZjLiBUaGUgbnZtZXQN
Cj4gdGFyZ2V0IGNvZGUgaXMgYWJsZSB0byBoYW5kbGUgcGFyYWxsZWwgb3BlcmF0aW9ucyBhbmQg
ZG9lc24ndCBjcmFzaA0KPiBhbnltb3JlLiBGdXJ0aGVybW9yZSwgaXQgY2FuJ3QgcHJldmVudCBm
cm9tIGRpc2NvdmVyeSBjb250cm9sbGVyIGNyZWF0ZWQNCj4gYnkgdGhlIHVkZXYgcnVsZXMsIHNv
IGxldCdzIHJpcCBpdCBvdXQuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBEYW5pZWwgV2FnbmVyIDxk
d2FnbmVyQHN1c2UuZGU+DQoNClJldmlld2VkLWJ5OiBDaGFpdGFueWEgS3Vsa2FybmkgPGtjaEBu
dmlkaWEuY29tPg0KDQotY2sNCg0KDQo=
