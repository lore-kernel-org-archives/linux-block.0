Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012045.outbound.protection.outlook.com [40.107.209.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EF5627F4CA;
	Fri, 27 Feb 2026 23:08:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772233726; cv=fail; b=oAtH/kshRylchUzNaAsK0HlGMCq42po+7ojiBHok4ZmpuuELi9SWXVIDEHfAltpRgTUm+hiPkHALxG7noH96bvKyqb5uFE4Zr3hrSAHcwvEDKASyfc8QAVQBo4ei3Xi6zpyyfe9LlQO1M0pghBGw3LYP7Zc/qCQecak5PVWp9Gw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772233726; c=relaxed/simple;
	bh=So2jKKjMG3JTlk4Oh7dbEMMLVbScSt76yaiT/ukmOV8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Z25XSIvxphPjKQf4FaRLdz1XvNLfeaf1Ma/2dXbhFhYSugcdG6e9ffrFFQurg45syJCZYSiV1u50m6aYltkXrFf8dcuTt0vVMuieaULXhXjh94aJxubvGczMYd69JCB5HNRZMHfdCNXn4vEW1Eh5jB4JuZwYtz4MwpTuFKqMOSA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=I4Fcw+D3; arc=fail smtp.client-ip=40.107.209.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="I4Fcw+D3"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=R8eJ9bzrvw6GhRTvYse0ZCduujoGuzrYW3RCuWbENxNN7tQg8b444leaN7AxK9oQ3m3O75vV4cdq+LlGYfbmYBj4dc2JZew1n8y/3W2RZKtDdJ1CeOrNUlOwjDaQA4bw34TOvNdDc6kR7sKcw9XER0pc4BRmBMUpmhkswnPis8cI0nJth2XZOYMikgjLw1eP1pT8Q4zU104hZ2Z4pkb7WFTOQD5QPI6Ql5XizRUHCnjXgZpkJLCMba3V8FNK49RPtJF75gAisM+L9LJBULAmmkuVlrGJpJwC1g2xdG8HMvYo6drm83rYWAld7ovpGnyCHIWnsldYjV+FfB9PW04TUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=So2jKKjMG3JTlk4Oh7dbEMMLVbScSt76yaiT/ukmOV8=;
 b=rQqHxZxznF/TFbGY+dweuKnG03CbjuZuf1jyRZGrznD+oyfPO2IRw8zPgpxvEqWqkQvCwqS0rvBx2PytGoJqNJ7rrHb0VPEAWyn0U4caPSX20P/SAIaU1XN5zJLN7MeIdsEz8k3MItJk3ifADLOuovv5/W1HMVRsvdJCNzkz3ncdpju1yvhawupzoy71kb9wZPslK3asedvqU2eTkana0YBpwZlb63xXTMw1YUW26ISoh23jibdvOj0mXegCwH0g0/VtsPQ44Q0eglq1jHZRzychKjBSbKScf5EOgH7AVPDaZBG96MyQEwuBIcpl9ndK+0PbTKAmWlvX1K3KfC7rIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=So2jKKjMG3JTlk4Oh7dbEMMLVbScSt76yaiT/ukmOV8=;
 b=I4Fcw+D31pzUM2O8rejCgiXUa2VBApW6wGWtaXd+MXcrAPC2hYc6/oIrwD8Lxbxlv8JV9uXLfedterM8OHvHWbg78mLfIOauR1i0Xqrq3kWs93FZjXsSzPbdwcJaFGJQdpYoXVCCFIp4lvd7cnmHz8aSqa3Q5y+mUzFCGwsELbw5nuv+eTjTVg0xKUYqWrJM4x+HNfMDEJ0/2Z5b/Hp6b0fLUhIr5BVxmWIYzGm0O8KsslBWj12X/+LVIavpfsNMtq7av8hvplzI1pxqxARNkGkjMTR4RqbrAzeWA6Ru/V11M8Fupz9W6CKZ0wR6soybkJaZMWyT4Tm8v36oVddK3g==
Received: from LV3PR12MB9404.namprd12.prod.outlook.com (2603:10b6:408:219::9)
 by PH8PR12MB7109.namprd12.prod.outlook.com (2603:10b6:510:22f::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.11; Fri, 27 Feb
 2026 23:08:41 +0000
Received: from LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::2109:679c:3b3e:b008]) by LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::2109:679c:3b3e:b008%6]) with mapi id 15.20.9654.015; Fri, 27 Feb 2026
 23:08:41 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Steven Rostedt <rostedt@goodmis.org>, "axboe@kernel.dk" <axboe@kernel.dk>
CC: "mhiramat@kernel.org" <mhiramat@kernel.org>,
	"mathieu.desnoyers@efficios.com" <mathieu.desnoyers@efficios.com>,
	"shinichiro.kawasaki@wdc.com" <shinichiro.kawasaki@wdc.com>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>, Chaitanya
 Kulkarni <chaitanyak@nvidia.com>, "linux-trace-kernel@vger.kernel.org"
	<linux-trace-kernel@vger.kernel.org>
Subject: Re: [PATCH] blktrace: fix __this_cpu_read/write in preemptible
 context
Thread-Topic: [PATCH] blktrace: fix __this_cpu_read/write in preemptible
 context
Thread-Index: AQHcp6a33CBBdklZxEWB5T4d27FU8LWW7MmAgAA/8IA=
Date: Fri, 27 Feb 2026 23:08:41 +0000
Message-ID: <be02f48a-a4fa-4d4d-814a-61b01e9d62a2@nvidia.com>
References: <20260227050303.10945-1-kch@nvidia.com>
 <20260227141951.102e19ce@gandalf.local.home>
In-Reply-To: <20260227141951.102e19ce@gandalf.local.home>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9404:EE_|PH8PR12MB7109:EE_
x-ms-office365-filtering-correlation-id: 53a9fcb6-3a64-444e-d1af-08de765525e3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|10070799003|366016|38070700021;
x-microsoft-antispam-message-info:
 5O0bXsFbrw61Cv8N2iQ0zCpqh3K4jqi25D8v4yGzB0VcUHWrz7rFfsAHEKLB+eJOGwwoSGRwOlKkkFoSKtFCgWcIf1qd2slFzjIyFIt+7kS4urm1BI+y7RwD9BUh+CNDVPN/yWTh4iweMIrO5qJPrI6khfZgI1uu7JLgFUVtgbGg5Zb50rNSJu1uHpErL+HtYG0NcuuqGjVFzCNBfwFwYe/aWFsDodl5elEXyFNLXFBEyKREH2xl9YAyrMvOWOQnuU0cgv2XcGcK+mu7GwzWfs15c0d2AJsF6KmN88ePO9yWM9jRKp35lfp106WD2dfwKeXRW0b4qat2PWurFTCdFvNBFWqX/OxB9qCGLYDJ+E/E/pmdPEp9OxF06W35A5HWv8CPNhYaCc3zlilIWG1ESey9g2rJWAbCFxd1Wr/0B9g40BGVrNSujcoak9HVCP+uBl/+Wh9VT5lNI5Ez4lEPragZ5LtMnRQs7S6fNBNWGOiw2UqqcpgM5F/kDBBw32W2fTELax/TGpX094AkvnImQGPH/O/cuoYA2ZTkegNUddv1l6UPc36I8OCKvWIwjwFwWIUvSX4VnZ19fCTkX8VXGjwrbYbuKADPYDAZ8AIeDJDhKQ90cKCYBG3WIBpnFwDDNgVY5rmyU4+a4b9VupClmrBZYS+MKR1wLxP1tnyk8/fsbF4y+JGwuVo/IZPNIs2pBVn9n6ITxH3p72HymCENDTRDxOSutqfcspTfunG3i6SSSJzI3hoHlDGKRre2Fdd3pgHZHMRxNiLBA8smcheeOLQ2f+8XOp0fsydVlWKC+nI=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9404.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(10070799003)(366016)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?cXNMZklqcGg2UUR1UURnRk1qNlBIRHZCSGNEYXo0RTNFT2pXVnZXRUtTbUV0?=
 =?utf-8?B?UnRVRFFVVDlVZjkzS3pBRlRJYlc2Q2N3VmFzbGNNOE8zYlZvMVFMVktSQ1JB?=
 =?utf-8?B?ckNvSHZ0c1VPWElMd202Q3RYbVpjeEpZdjBubWtyOGpWa2NtaGJMMWZzL2lP?=
 =?utf-8?B?Q2NBWWRRYnV1Z3dDbEoxMkFMZ0wzQTlNTXI1cTZ4Wk9Icmg1VTAyNE13TTAy?=
 =?utf-8?B?SUVjTlZyTFVvNEVxMG9ubC9YUmQvakFJWnBZUXo5bUY3SGxua25SaVBUOVpo?=
 =?utf-8?B?VU9DYnhwU1lLOGRVajQ4aTlsQTFzcWluY21JRXlCLzdtdXdlMitHNnZoT2Nl?=
 =?utf-8?B?OFMxL05WcE04dk1XMjV2cXBLNkJGN052RVl3NHBMQzJXSVlZbTZJdXR3L3ZG?=
 =?utf-8?B?ditRSXJxdVhzUCtlM0hXQW1VY3hEU2pvQ1cvZnVZMC9DM0tBWDRjdWQwL3Fo?=
 =?utf-8?B?VHp4bUpwU0JDNU0vY3E2VW1ueGN6TTgzVStOYVFINWFqQ1dZRE1GQXA0ZU1M?=
 =?utf-8?B?Qjl5THhmTllTdWJSMmlXUVBOY25mQ0g3TjhpWks4UysrU1ZWTXAwRkVoK0Nz?=
 =?utf-8?B?QWY4MURxejdQbHJaKy9qRkxUcUoyY01LL2t6RWNkcVpjNkt1NEFZWlJwdE5u?=
 =?utf-8?B?dXdHZVYwd2ZUalBwQVFteUF4Wk4raGpFWnFqYjdRWE0wTEVuaDlYYWZPSWFh?=
 =?utf-8?B?QmhIK2RpQlFYWm9BNWtpQ3VwOXoxQU5YTlJ0RGJLSk8zcXRNMllaSVU5bmxT?=
 =?utf-8?B?NjA1MUFySCszbzR0RUYzZXVxL0FCaUtwVXo3L2pCc2c5VFM1MEhsZmZJSzhI?=
 =?utf-8?B?aXdBWERrWDladmlidjN4NmxaM1YwQ0RqRWRHb3NyRXdNU2VHRXNrd2dkT0Fn?=
 =?utf-8?B?NzVBWnViUS92UU9RQVRwb2xJNDBhZXoyY1pzUnN1TDlpV1hRZndkSExUa1E4?=
 =?utf-8?B?eGUvQzhQZGxMQnpzVEY3Y3BnMnV0NVpiSFJBZXBnQXhEUGVOYlQrbGtDR2Jk?=
 =?utf-8?B?aGM0eVY0S0xuYlB6aHhyS2pFMzJWT1BXZGlvYmxFellkay9iNVFtSnQvOTdQ?=
 =?utf-8?B?M0dHY29xZUduVWFISkhueVIvR1I3T1p2WWVEd0FvNzBrclo2WGRmQTJWU0k4?=
 =?utf-8?B?T1gvb0NLQ2Z0cHZ0OGM3ZmNIVWNncmR1ZEU0SVJtME9RNUROeUJyYjk2WGVN?=
 =?utf-8?B?R1hrVnRrV1REdXBTb0FYa2xSd090S0U3Y0hjdUs1c29MQlc1QVc1SmVhRXU4?=
 =?utf-8?B?TE1FVTZuZGRKK0txR0twcFlsb2dOUG1hTlRGOUZEL1BPTEVNbURyK2hMMW0v?=
 =?utf-8?B?clJ2czgxclc0ZFpud0hFR1Z2RW9nK3ZSM1hoZytSUlJwSHphak44dnhpK0tq?=
 =?utf-8?B?c2dKUUhRMG0vYjJDdWpINi9jcTJJTXV6S0FOZzc0dmZwOTVOYkl4eEZpdWti?=
 =?utf-8?B?R2RhQ3VWak1OZnZ3RlhCc3gxZ2ZtSEx3SVArbHk1SlROdkc4bGNJQ1pDbTl2?=
 =?utf-8?B?YU5CeUtOWUhnbEY5dVYwM1Z5NHlCZ2JDc29FWHphZ2VkZWs5OTc2OFpoejRX?=
 =?utf-8?B?Wk5lMWplckRVUm1Ic2xiWlpUOXJEdklFcnNUcEMrSFRDTVQ3Vk82MmV3WHEy?=
 =?utf-8?B?TTBkYUVjN21qdUJybGdCZys1TmV5M0RzQlFQSTdqa0FvZlNQY3ViVEoza1lR?=
 =?utf-8?B?RU8zb2tCbXJNeUMyV0JIMU9zUlFZS2h3RE1QUmE5Zzd6NnNQRW1sK1VpRVZs?=
 =?utf-8?B?RGtVbGZuYWoxTEMyNURyZVlQWi84NnRidTY4OFhGb1JrZmxBZHI5ZHZtQ0p1?=
 =?utf-8?B?WEJIYUdwZVc2d0J3YWQ4c0h4T2UwTkFGQy9zS08vRkdGdUFORUYrVkN6bUpO?=
 =?utf-8?B?dEdSZVRSbW42Mm9iNFk1b0luUllnL2IxWHVyRE9LVFVKUVpkaFVTL3B3R3Jl?=
 =?utf-8?B?Nk1kdzdTc0hUdXlUVEMxaEwxK2Y5ZDBQTTlld0VhQTFSNHdZZzdaSHVpaHg5?=
 =?utf-8?B?ekFqTEZRazVIcHAvdkRlTjdBT3RUcE5NcFU3Z1R3Nno2VlYvK2dqczhvL2cv?=
 =?utf-8?B?VEhBZnJWL3hJY1hSMHNQTHlOY1Qrc3ozUUdIOVpDNFdXSkJueTlmZ05kd2li?=
 =?utf-8?B?REFFWlZ0UXJlV05kSHlXRGxtMUQrcnRQak5iZm9WN0ZPdWJ2UTh0T04rb2Rx?=
 =?utf-8?B?ck5YSnZFM1Nua1RDOE12VFNtOUtHbWRubStXWWYyOUZrWEZMU3dpYmpFTy82?=
 =?utf-8?B?NXhheXRtcmUxUERFcHphVCttVFE3bktOckpKRGloMXZYSmtUU2NuMG9ETDNq?=
 =?utf-8?B?bk5mTXpNYitpeUVwbi84SzJycWNRbWlPQW9va3VVaDdKMVpPL1RBelBwZnhp?=
 =?utf-8?Q?YYN2ijCzT07uE0vmzs771C+eWQN8T0pg50tfx83FuKsKP?=
x-ms-exchange-antispam-messagedata-1: Ct3As4E17IDGwg==
Content-Type: text/plain; charset="utf-8"
Content-ID: <1689D56DB2024448A5E4402A36C876C3@namprd12.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 53a9fcb6-3a64-444e-d1af-08de765525e3
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Feb 2026 23:08:41.3057
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lI0naLpsucgGIXqk2ldPLXe1RdMH+A2hSKyGyJ5wbPHOdZ0CqASJpmWFpFA3d0yijLCqYaXvVgroQJEEdchnBQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7109

T24gMi8yNy8yNiAxMToxOSwgU3RldmVuIFJvc3RlZHQgd3JvdGU6DQo+IE9uIFRodSwgMjYgRmVi
IDIwMjYgMjE6MDM6MDMgLTA4MDANCj4gQ2hhaXRhbnlhIEt1bGthcm5pIDxrY2hAbnZpZGlhLmNv
bT4gd3JvdGU6DQo+DQo+PiBkaWZmIC0tZ2l0IGEva2VybmVsL3RyYWNlL2Jsa3RyYWNlLmMgYi9r
ZXJuZWwvdHJhY2UvYmxrdHJhY2UuYw0KPj4gaW5kZXggM2I3YzEwMmE2ZWIzLi40ODg1NTIwMzY1
ODMgMTAwNjQ0DQo+PiAtLS0gYS9rZXJuZWwvdHJhY2UvYmxrdHJhY2UuYw0KPj4gKysrIGIva2Vy
bmVsL3RyYWNlL2Jsa3RyYWNlLmMNCj4+IEBAIC0zODMsNyArMzgzLDkgQEAgc3RhdGljIHZvaWQg
X19ibGtfYWRkX3RyYWNlKHN0cnVjdCBibGtfdHJhY2UgKmJ0LCBzZWN0b3JfdCBzZWN0b3IsIGlu
dCBieXRlcywNCj4+ICAgCWNwdSA9IHJhd19zbXBfcHJvY2Vzc29yX2lkKCk7DQo+PiAgIA0KPj4g
ICAJaWYgKGJsa190cmFjZXIpIHsNCj4+ICsJCXByZWVtcHRfZGlzYWJsZV9ub3RyYWNlKCk7DQo+
PiAgIAkJdHJhY2luZ19yZWNvcmRfY21kbGluZShjdXJyZW50KTsNCj4+ICsJCXByZWVtcHRfZW5h
YmxlX25vdHJhY2UoKTsNCj4+ICAgDQo+PiAgIAkJYnVmZmVyID0gYmxrX3RyLT5hcnJheV9idWZm
ZXIuYnVmZmVyOw0KPj4gICAJCXRyYWNlX2N0eCA9IHRyYWNpbmdfZ2VuX2N0eF9mbGFncygwKTsN
Cj4gRG8geW91IGtub3cgd2hlbiB0aGlzIHN0YXJ0ZWQ/IHJjdV9yZWFkX2xvY2soKSBkb2Vzbid0
IGRpc2FibGUgcHJlZW1wdGlvbg0KPiBpbiBQUkVFTVBUIGVudmlyb25tZW50cywgYW5kIGhhc24n
dCBmb3IgYSB2ZXJ5IGxvbmcgdGltZS4gSSdtIHN1cnByaXNlZCBpdA0KPiB0b29rIHRoaXMgbG9u
ZyB0byBkZXRlY3QgdGhpcz8gUGVyaGFwcyB0aGlzIHdhcyBhIGJ1ZyBmcm9tIGRheSBvbmU/DQoN
ClRoaXMgc3RhcnRlZCB3aXRoIGxhdGVzdCBwdWxsIHdoaWNoIEkgZGlkIG9uIFdlZC4NCg0KTGFz
dCB0aW1lIHNhbWUgdGVzdCBwYXNzZWQgb24gMi8xMS8yNiBzaW5jZSBJIHJhbiBibGt0ZXN0cyBh
bmQgcG9zdGVkDQpmb2xsb3dpbmcgcGF0Y2ggb24gMi8xMS8yNiAxMjo0NyBwYWNpZmljIDotDQoN
CltQQVRDSCBWNF0gYmxrdHJhY2U6IGxvZyBkcm9wcGVkIFJFUV9PUF9aT05FX1hYWCBldmVudHMg
dmVyMQ0KDQpTaGluaWNoaXJvIENDJ2QgaGVyZSBhbHNvIHJlcG9ydGVkIHNhbWUgYnVnLg0KSSB0
aGluayBGaXhlcyB0YWcgd291bGQgYmUgOi0NCg0KRml4ZXM6IDdmZmJkNDhkNWNhYiAoInRyYWNp
bmc6IENhY2hlIGNvbW1zIG9ubHkgYWZ0ZXIgYW4gZXZlbnQgb2NjdXJyZWQiKQ0KDQpTaW5jZSBh
Ym92ZSBjb21taXQgYWRkZWQgX190aGlzX2NwdV9yZWFkKHRyYWNlX2NtZGxpbmVfc2F2ZSkgYW5k
DQpfX3RoaXNfY3B1X3dyaXRlKHRyYWNlX2NtZGxpbmVfc2F2ZSkgOi0NCg0KZGlmZiAtLWdpdCBh
L2tlcm5lbC90cmFjZS90cmFjZS5jIGIva2VybmVsL3RyYWNlL3RyYWNlLmMNCmluZGV4IGI5MGE4
MjdhNDY0MS4uODgxMTFiMDhiMmMxIDEwMDY0NA0KLS0tIGEva2VybmVsL3RyYWNlL3RyYWNlLmMN
CisrKyBiL2tlcm5lbC90cmFjZS90cmFjZS5jDQpAQCAtNzcsNiArNzcsMTMgQEAgc3RhdGljIGlu
dCBkdW1teV9zZXRfZmxhZyh1MzIgb2xkX2ZsYWdzLCB1MzIgYml0LCBpbnQgc2V0KQ0KICAgICAg
ICAgcmV0dXJuIDA7DQogIH0NCiAgDQorLyoNCisgKiBUbyBwcmV2ZW50IHRoZSBjb21tIGNhY2hl
IGZyb20gYmVpbmcgb3ZlcndyaXR0ZW4gd2hlbiBubw0KKyAqIHRyYWNpbmcgaXMgYWN0aXZlLCBv
bmx5IHNhdmUgdGhlIGNvbW0gd2hlbiBhIHRyYWNlIGV2ZW50DQorICogb2NjdXJyZWQuDQorICov
DQorc3RhdGljIERFRklORV9QRVJfQ1BVKGJvb2wsIHRyYWNlX2NtZGxpbmVfc2F2ZSk7DQorDQog
IC8qDQogICAqIEtpbGwgYWxsIHRyYWNpbmcgZm9yIGdvb2QgKG5ldmVyIGNvbWUgYmFjaykuDQog
ICAqIEl0IGlzIGluaXRpYWxpemVkIHRvIDEgYnV0IHdpbGwgdHVybiB0byB6ZXJvIGlmIHRoZSBp
bml0aWFsaXphdGlvbg0KQEAgLTExMzUsNiArMTE0MiwxMSBAQCB2b2lkIHRyYWNpbmdfcmVjb3Jk
X2NtZGxpbmUoc3RydWN0IHRhc2tfc3RydWN0ICp0c2spDQogICAgICAgICAgICAgIXRyYWNpbmdf
aXNfb24oKSkNCiAgICAgICAgICAgICAgICAgcmV0dXJuOw0KICANCisgICAgICAgaWYgKCFfX3Ro
aXNfY3B1X3JlYWQodHJhY2VfY21kbGluZV9zYXZlKSkNCisgICAgICAgICAgICAgICByZXR1cm47
DQorDQorICAgICAgIF9fdGhpc19jcHVfd3JpdGUodHJhY2VfY21kbGluZV9zYXZlLCBmYWxzZSk7
DQorDQogICAgICAgICB0cmFjZV9zYXZlX2NtZGxpbmUodHNrKTsNCiAgfQ0KICANCkZ1bGwgZGlz
Y2xvc3VyZSBJJ3ZlIG5vIGlkZWEgd2h5IGl0IGhhcyBzdGFydGVkIHNob3dpbmcgdXAgdGhpcyBt
b250aC4NCkkndmUgd29ya2VkIG9uIGJsa3RyYWNlIGV4dGVuc2l2ZWx5IGFuZCB0ZXN0ZWQgbXkg
Y29kZSBhIGxvdCBmb3IgZm9ybQ0KMjAyMC0yMDIxIGFmdGVyIGFib3ZlIGNvbW1pdCBidXQgbmV2
ZXIgaGFzIHNlZW4gdGhpcyBldmVuIHdpdGggbXkgcGF0Y2hlcy4NCg0KPiBBbnl3YXksIHRoZSB0
cmFjaW5nX3JlY29yZF9jbWRsaW5lKCkgaXMgdG8gdXBkYXRlIHRoZSBDT01NIGNhY2hlIHNvIHRo
YXQNCj4gdGhlIHRyYWNlIGhhcyB3YXkgdG8gc2hvdyB0aGUgdGFzay0+Y29tbSBiYXNlZCBvbiB0
aGUgc2F2ZWQgUElEIGluIHRoZQ0KPiB0cmFjZS4gSXQgc2V0cyBhIGZsYWcgdG8gcmVjb3JkIHRo
ZSBDT01NIGZyb20gdGhlIHNjaGVkX3N3aXRjaCBldmVudCBpZiBhDQo+IHRyYWNlIGV2ZW50IGhh
cHBlbmVkLiBJdCdzIG5vdCBuZWVkZWQgaWYgbm8gdHJhY2UgZXZlbnQgb2NjdXJyZWQuIFRoYXQN
Cj4gbWVhbnMsIGluc3RlYWQgb2YgYWRkaW5nIHByZWVtcHRfZGlzYWJsZSgpIGhlcmUsIGp1c3Qg
bW92ZSBpdCBhZnRlciB0aGUNCj4gcmluZyBidWZmZXIgZXZlbnQgaXMgcmVzZXJ2ZWQsIGFzIHRo
YXQgbWVhbnMgcHJlZW1wdGlvbiBpcyBkaXNhYmxlZCB1bnRpbA0KPiB0aGUgZXZlbnQgaXMgY29t
bWl0dGVkLg0KPg0KPiBpLmUuDQo+DQo+IGRpZmYgLS1naXQgYS9rZXJuZWwvdHJhY2UvYmxrdHJh
Y2UuYyBiL2tlcm5lbC90cmFjZS9ibGt0cmFjZS5jDQo+IGluZGV4IGU2OTg4OTI5ZWFkMi4uMzcz
NWNiYzFmOTlmIDEwMDY0NA0KPiAtLS0gYS9rZXJuZWwvdHJhY2UvYmxrdHJhY2UuYw0KPiArKysg
Yi9rZXJuZWwvdHJhY2UvYmxrdHJhY2UuYw0KPiBAQCAtMzgzLDggKzM4Myw2IEBAIHN0YXRpYyB2
b2lkIF9fYmxrX2FkZF90cmFjZShzdHJ1Y3QgYmxrX3RyYWNlICpidCwgc2VjdG9yX3Qgc2VjdG9y
LCBpbnQgYnl0ZXMsDQo+ICAgCWNwdSA9IHJhd19zbXBfcHJvY2Vzc29yX2lkKCk7DQo+ICAgDQo+
ICAgCWlmIChibGtfdHJhY2VyKSB7DQo+IC0JCXRyYWNpbmdfcmVjb3JkX2NtZGxpbmUoY3VycmVu
dCk7DQo+IC0NCj4gICAJCWJ1ZmZlciA9IGJsa190ci0+YXJyYXlfYnVmZmVyLmJ1ZmZlcjsNCj4g
ICAJCXRyYWNlX2N0eCA9IHRyYWNpbmdfZ2VuX2N0eF9mbGFncygwKTsNCj4gICAJCXN3aXRjaCAo
YnQtPnZlcnNpb24pIHsNCj4gQEAgLTQxOSw2ICs0MTcsOCBAQCBzdGF0aWMgdm9pZCBfX2Jsa19h
ZGRfdHJhY2Uoc3RydWN0IGJsa190cmFjZSAqYnQsIHNlY3Rvcl90IHNlY3RvciwgaW50IGJ5dGVz
LA0KPiAgIAkJaWYgKCFldmVudCkNCj4gICAJCQlyZXR1cm47DQo+ICAgDQo+ICsJCXRyYWNpbmdf
cmVjb3JkX2NtZGxpbmUoY3VycmVudCk7DQo+ICsNCj4gICAJCXN3aXRjaCAoYnQtPnZlcnNpb24p
IHsNCj4gICAJCWNhc2UgMToNCj4gICAJCQlyZWNvcmRfYmxrdHJhY2VfZXZlbnQocmluZ19idWZm
ZXJfZXZlbnRfZGF0YShldmVudCksDQo+DQo+IC0tIFN0ZXZlDQoNCkFib3ZlIGRvZXMgZml4IHRo
ZSBwcm9ibGVtIGFuZCBtYWtlIHRlc3RjYXNlIHBhc3MgOi0NCg0KYmxrdGVzdHMgKG1hc3Rlcikg
IyAuL2NoZWNrIGJsa3RyYWNlDQpibGt0cmFjZS8wMDEgKGJsa3RyYWNlIHpvbmUgbWFuYWdlbWVu
dCBjb21tYW5kIHRyYWNpbmcpICAgICAgW3Bhc3NlZF0NCiAgICAgcnVudGltZSAgMy42NTBzICAu
Li4gIDMuNjQ3cw0KYmxrdHJhY2UvMDAyIChibGt0cmFjZSBmdHJhY2UgY29ycnVwdGlvbiB3aXRo
IHN5c2ZzIHRyYWNlKSAgIFtwYXNzZWRdDQogICAgIHJ1bnRpbWUgIDAuNDExcyAgLi4uICAwLjM4
NHMNCmJsa3Rlc3RzIChtYXN0ZXIpICMNCg0KSSdsbCBzZW5kIGEgVjIuDQoNCi1jaw0KDQoNCg==
