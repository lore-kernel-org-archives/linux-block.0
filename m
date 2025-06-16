Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2087.outbound.protection.outlook.com [40.107.94.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 855321A8F84
	for <linux-block@vger.kernel.org>; Mon, 16 Jun 2025 04:25:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750047947; cv=fail; b=n6uAkB1S6p34D9pjyRBp1oOIJxkcfCWeiTbau0cwJ9cmulu+v5LVOmCj+X+zf+RSH3MBLTNpU7u5vuwPHLhX7TVtEGNlHanoHWABYzr86igkyqAwwnsJ58Tv6sJIB8VIAqDV18nJeJe9R+xvOY+Lw7wKRKrTJIp1hh77oXMyxxw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750047947; c=relaxed/simple;
	bh=0o84rHj6kOYWcHS8OjV/gee3X0fxt3SQp46YC7+iOiA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ROLTPbNLOwSVRiNibY5Nx8rhaQ2zzrrfAHvusM1a8ymogkoNE2MbMDg6O1kxPoAC8j/rBOEzxMDnvArMFue3Ms3DG/6MIqOiSHqjs+a7aJTP+eJK9qU9DTDNhoSZLNF8Ktbex0JzQtn6z3+kZTbHVFDNRI12wCnoHo4nsoWwVK0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=tAjMl6uQ; arc=fail smtp.client-ip=40.107.94.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="tAjMl6uQ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lQpFSFzl2kzLTx1fKGbu/6GJ621Ta4cr7J8StRW0vtyx/0GVSUqIuzU8LhY4QBInng/QueGGsVbFhIPYNQZxylkXzgNDszkhhT+hsNTwmRkgT2JUF14Ipdw09v0XdDR8FbGbqQc63SE392nf2qpYknoXZZ6WcinVNYaYpBqgtnqbevGIqnCQtqCsNg0IuEVwwbCm6Rab8OVG/CMEybf32G3ChJcZPf/r3KqYIU221OGcgrFTXkmiUiE7Uv+180zhxHOQVfaG57DQ4IGW5s2278asp63+inNERt91ktRnY6VegQU5/6zLagC2iKrAEzicTW3HI7f5AVMmpsG05Gv+uA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0o84rHj6kOYWcHS8OjV/gee3X0fxt3SQp46YC7+iOiA=;
 b=Q3SjWxFKkcUlzlpiQ2+cQX+gUyJZ20taj6YBRoYdRsSZ9vb30IePx5bDZUkvgYa70eQYZCC3l2cldKJwmct/2HMzUCxT2UxjGbPPo6/Go7DjMX254CrTyqBPF7z588WL04b0Mfzghip5JiE0PriMMk6QwqvXolL7bbPRgX0139QE9+TbP6Fx0zXcleL5qeDrgfTFCikilbKpVwoMi/4ppLI6ZkjPQgCkY7l+EtVoYVs+/PumfZpHf0wehB7tFTFke8RlyQ8meKubAal82+X2MjfN2ZU/K5A+1oC1BJX4NYmCa0D3fKLIKBD29CgWkBO2ycSJ8uHtG4F7aH7ii1yJHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0o84rHj6kOYWcHS8OjV/gee3X0fxt3SQp46YC7+iOiA=;
 b=tAjMl6uQ+4lgtBaPjHsmS0ihQEEQZ01kGJ+VWpwPHwbFyIL0f9ssjo2EuQa3gMuAopsekMetE+5p1qlAUa4cbBrbVm6reJJQWQdP64Yjh8fl9dpvTyvf9txVxEJnBK0mEvvyp2Ko+ek+jlD0VVztuf4LQUugWxpB5EZFQicOMlFCyf7WW+nUN0129bcjXRADlHhjjCH9BA3UleHP2Yp07KEU7GxBP7v3WK4looWaAxTCGQGNt0RkogW2G/ZHa6znHesoEr8vYwx+SEJHIP38H3sRGSjSNVsCOW0yOhRoJSHBmL9hWZ1NZBk/E7JgC6GhU9aJi8o/ZoHtn7UOVnc4OA==
Received: from LV3PR12MB9404.namprd12.prod.outlook.com (2603:10b6:408:219::9)
 by DS7PR12MB6144.namprd12.prod.outlook.com (2603:10b6:8:98::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8835.29; Mon, 16 Jun 2025 04:25:43 +0000
Received: from LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b]) by LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b%3]) with mapi id 15.20.8835.027; Mon, 16 Jun 2025
 04:25:43 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
CC: Keith Busch <kbusch@meta.com>, Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH blktests 1/2] nvme/rc: introduce helper functions to check
 namespace metadata
Thread-Topic: [PATCH blktests 1/2] nvme/rc: introduce helper functions to
 check namespace metadata
Thread-Index: AQHb3mNvi//7TxxNPE6bnq6IFSQgG7QFMKoA
Date: Mon, 16 Jun 2025 04:25:43 +0000
Message-ID: <3aaec03e-09f2-44e4-9895-2a89e50e0f40@nvidia.com>
References: <20250616020716.2789576-1-shinichiro.kawasaki@wdc.com>
 <20250616020716.2789576-2-shinichiro.kawasaki@wdc.com>
In-Reply-To: <20250616020716.2789576-2-shinichiro.kawasaki@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9404:EE_|DS7PR12MB6144:EE_
x-ms-office365-filtering-correlation-id: 89b52cb4-a912-4bb8-106e-08ddac8ddba5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|366016|10070799003|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?K1h0WUJkMUY2L0g3WHMyYVY3am9MTWkzUzl5aTAzMG5ERjZGR292SUJmTFk1?=
 =?utf-8?B?V3pyaHlhSzNzcm5yUCtLcW8vU3FBRjYrYmhaL05KQkhHM0lvVkt3ejIxck96?=
 =?utf-8?B?R21sQWtOT2tRN1BxV1IvdStaVHhteDJRZmkrcC95UWl4amdxdUlPRXZLVXV5?=
 =?utf-8?B?ZDNDY29QOGdmem91MnhzSVp4UDRHWVFSekF0V3hBU2NhdGtFVmRZTEtYRWVK?=
 =?utf-8?B?YWpzVi9kd1BqVXZnWEhzUDlkVTJ4M3laMDhFNlpta2FRNTRRZHByazZSOWFR?=
 =?utf-8?B?N0grUFN3Z2t4ZGozWkttNUZlejNSNVpOS0xIaXFNcFZvNk9YT080emZ1dmFF?=
 =?utf-8?B?Q2Q1UThreklRV2RIVHVuWjdoOWh1WW5TWWJQRy9CRnVTazJHcEthczRkWHlo?=
 =?utf-8?B?YXVNMEdqZHhZZVNiQURWa21QaVhUaGdsWXo0MWVUanNIVFcyZUM1N1FTYUpW?=
 =?utf-8?B?TDdsc2dabVBDN2FxWlYyOEdZZ0toRElGdkd5c1JGWld3RS9HMUd5VUJBT1BM?=
 =?utf-8?B?WTRmMk9rd0lSelFoSHFobDJWVloybWliSWNsSCszRXM1d2IxVitFTXNCOURY?=
 =?utf-8?B?bnVYdmpRTUZJUHlPaGFBaytxVGhLQ3NrdmxBbmJiRVlKTlgwQjNMWVhNZWpL?=
 =?utf-8?B?b2VwQ1h4c2MrcSt6SHo3N3VHRFhFNVk3VkF0a0ozeFE1MWRIKzVzWGZPeVRX?=
 =?utf-8?B?ZXFVU2p2bTMzUTBkUkhMaDFNeFduMHhONXQrK2xzWVZUUDBBTU9hNFlVNjlD?=
 =?utf-8?B?eXJiUTNIbnhBaDNGT1BONGh2NmJ2ck4wdHZZdHJTR0RhR012d2FNcWYxejBl?=
 =?utf-8?B?Tmo2U2UyWUxPeld4MjA0S0x5NXlPWkc1TTdXd1JWUStCRitKSFpRSDIyN2RO?=
 =?utf-8?B?ZUQyK2Q2ZGVuVGRxNnpxVkY0THVyaTVKckFpbkt0YkNNL3A3OFlYVktBU3Ru?=
 =?utf-8?B?NjRPK3J1SmpSTHMxSTRHN0I0bVhSZTFkMVJnMU5Vblc5QkxpTVRFVi92OUtU?=
 =?utf-8?B?cjVQYlMrYkd6amVrcHhXeUtWakhFQzIyemhaMC9VQ0dpbkRCa2N3TnM5OTRD?=
 =?utf-8?B?cUd1dk9PeE5VVTJwY1l4aTZKdlgwdHlSV1BvSE1rL1B3T0FXTWpsaUdMYUE3?=
 =?utf-8?B?UjJNVStoL0cxbVdxTFNEZ3RiTExpZlhQbDZia1B0cEljYWRKOEpyMzVwZWtl?=
 =?utf-8?B?ZVUvQkFhbkoySzc1dEZpUFNGWk52Z1A2ZnBBYjBONExVZzlwTWRtQmdEK2Y1?=
 =?utf-8?B?SWRoTFJMK2dPcnk2L2MyRkFmWlVnRG9ndjJnTVhxY2hxMjhVWkpFKzYxUndU?=
 =?utf-8?B?NDc1T0VOUW5WTk1vNzljNEdCaGxZTllnT1YvdkVkcGdZMFloUmZmODBzYmJQ?=
 =?utf-8?B?NHErVk43WFpPbjlEQXRtZ2NmYXN3Qmxmb0dSdlY2UFNSejRjVUx3ZHgrU3pN?=
 =?utf-8?B?QVovdEJSM1Npb2ZGTWFqWUxjTEJEaU9qczF0TFlkZXpHandTUzFRYVJOc2xD?=
 =?utf-8?B?Nm5YSElVZVVFU0VWeFZaaHdlNS9OOFFjd3NZYzRabkVDc0xSM2ZVVTNFbVE3?=
 =?utf-8?B?OGJzNjJ4Qkxxa2gwRTZNTkJZVm12MGNxNlI4MDFyaERjQTZwWFNGdk0xdXRK?=
 =?utf-8?B?Mnk0a0RwaVJPa3JKbEZCckJSUUM0cW5XWDNOU3JQTEp3RmFUWTdsWnJnc2V5?=
 =?utf-8?B?TUFsMXN5dFhkenBjYjl5c045YVd4cUNBRXZONlZQL2QrUXptWnU5NTI0dXJ3?=
 =?utf-8?B?bTFieUt1dERMYnVIZXJZWG83Y1J5eEZ3TlBzbGJkSUtNMGgweTViazFCRW5w?=
 =?utf-8?B?QjNUOThZYzliWUt4Q1F0bmJ2aERnR0NuUWc3SEZPOS83S1FiTkFZcGdDbW01?=
 =?utf-8?B?K0NCU3Z5QjVkYTc5MDZEZHNXVGhuUkU3TDh4K2J0MG9vV2dKNnZKcEVGc0xs?=
 =?utf-8?B?emk3ejh0KzJZQzRMcjE2a0QwRzFQUG40OTZwZ0dPRURETFVqWG81eWpGSlJq?=
 =?utf-8?B?VHZYaUdvVGlBPT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9404.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(10070799003)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?QkZZWDlrbWRaVEtBNVFaVkxXK3VqU0JBQ3d6ck9hQUl6cHR4anRuR25VQ0pu?=
 =?utf-8?B?UytHa0pwQWZXek5TUlM0UjB6TTZBcnRuMmpqUSttOHdNNjg5MDR1WmU3U01H?=
 =?utf-8?B?OGh0bGxtdEZMbStDZm51c0xJc1l6Sk5WQVNHVlAyZk10bEtHdVJ4L3RHZmVQ?=
 =?utf-8?B?dURpYWxiNk1NTlE2eUtwdHc4WXY4SFRnUSs3MjdHTVRDM1FEOGJqbG1yaVp4?=
 =?utf-8?B?RlNteS80emt1M3BFd3JUbTN5dnNQNXhOcFpMU0xmaTRpME1hZzlMMW5IZTVr?=
 =?utf-8?B?Y1N0ZnhhbUc5ai9LVmdFbVdNVmlOSTd1Uzd0VzBSVVB0dGx0R3piR3VqL3Yz?=
 =?utf-8?B?RE5GTGZ6UU0xNzdGWGNEYWVCTkh4MXBkUDRaS0tJU1ZEOXhBT2NPTS9qVEN2?=
 =?utf-8?B?S2ZyemhqM0FHblpPejZoSGJ6eFo2QXRrd0JLU0ZKZG9tWHJNdk44OUhJQkIr?=
 =?utf-8?B?ZXFpVExDVHJiK2g1bHcwZjl1QmIwQytib1J0cmRtSFd6aGg1WjZKUFBaU3VD?=
 =?utf-8?B?N21PS3d1RHFUb2V0NWpBTHViN281eEE4VnlSRXVuOC9GbEVYdnRpbE5KbnJm?=
 =?utf-8?B?dHd3cW13SzdPNG9qYVZGNndCQXpuZm1pS1ZNSk9BKytYT2lQa05NeGhFVzU5?=
 =?utf-8?B?MUZ0bVNwV3FyekJVdjVxSVdKREZIOFNRL3pUREJUQU9GTXpRK3A2Z0xsM2tw?=
 =?utf-8?B?d2dWckpvWlowTVhEc3BPczR6UHZqUTVrOGVmWTIxVURzR1JxRkxvdnNxTTV4?=
 =?utf-8?B?aU9uNC8reGM1NzVMdVRpQzlYdXIwRXY4ZTlQTGNIL1pOeCs0Rm5jV1p0QjRF?=
 =?utf-8?B?TVAwNVhvVnArVElZdFd3ZGRZb0pUR3E4azFyeVkyWnVoVmFzQmJadlVTaEdS?=
 =?utf-8?B?TlJRbmdrcURhZkhkZ2dPd3RRVHg5dktaNjRJUE9wTTM1MG41VlMvU0lGaXVv?=
 =?utf-8?B?b2ZseEZ6cFlaNGxEbTNFMXBvcStReXlPKytEczk2Y3o4aUtWdzFHZ1BwNi9y?=
 =?utf-8?B?MVE2UXd3b0ZqZy9Ob1g4Z0JGMkhJWEVBTVVwdGZBZ045WUZ2WnY4SFk0N3hS?=
 =?utf-8?B?N2VlbTdLOVlyRmI4RXQvWkxXMUgwUEpucXdZWEVIRGN6SHF6V21obmFra2k2?=
 =?utf-8?B?RlRsL2o5cytkWXBTNEUwMWV1QlIyWHZBZXJFVmdpN1pZVkVLNVkwYUM2K0Nz?=
 =?utf-8?B?TlloTmdMRXI3WEtqSVdXU2t6SWFwV2pBNktkeUM2VzhaZ0gyK1RrTlZWckhK?=
 =?utf-8?B?SWlmWVdzUURXT251b1VQc2pYbnY2M0dCeTBmelNoSXVXTmdSUzg0MkdEY0dv?=
 =?utf-8?B?T0NTdkN2dTN6M2pjWE5MK1dybmVoemk2cDVycFZidkYyZlNYam1qaDB2eUYz?=
 =?utf-8?B?Q0tycVdKQk4yVno1QTFBNUdLWXY5ZzNOSnRZUGwweE9tdkRZdGFLcGxWdjFZ?=
 =?utf-8?B?RFJETXh1NjFZanlnUXlWQllYeXQ5TE9MMVpka1NsclNhWlBUbGV4NUhrTnRC?=
 =?utf-8?B?aFdHWnd4TkQ4aUw5eGEvUnBwc2ZPSEl5c25WYjBkMXFvbWxIRkJlSWl0Z3da?=
 =?utf-8?B?QVU4dVkveURUb1BHVnRjS0xUS1pWV1c4YW1qS01EQ1lXUXNVS3MxVHpDdVRy?=
 =?utf-8?B?aG45eTcvMk5zNERzeWZXREpZVmRKRGoweFd5YXM4Si80aE52SGdBK01GRVB3?=
 =?utf-8?B?QmVmMElKVDNicnVVUnRMeW16RS9LTFoyaWk1eVRHMWxvM1ZkL1JtbmNQNWV2?=
 =?utf-8?B?SVFRMDJhU2pWTW5SVFYxY2Ivcks1ckdQVHBtRVlsbmRadVFhNWlDS2NVdjhu?=
 =?utf-8?B?S2QwR0RrMllpb0ozV2VVaXBudy9mTkl6U2lkVW95UWRITDYrenRtTUoxKzMv?=
 =?utf-8?B?SkxoMGNyMVdPenczNzZmaFIxUkl6Y1plOHFtYzIyWDVGaDNPSDQzcUh3cDJx?=
 =?utf-8?B?Y2ZaZmRiOGxKVERPWFVFZEhsMGlNaEh6c1dRemlEUnRSakNoSFFoSUZsanpo?=
 =?utf-8?B?VE11ZTdKM0E2cUd4bFlEbmZhd1Zyd3ZsbGZ3c2xqQ1dPbVVWLzdRa3ZqKzRw?=
 =?utf-8?B?NlpGdkJwNmhQZG40RTBQalI0aVZ5K3pOci9wZmQyRE9EOHVEc1BwZWZIL2tq?=
 =?utf-8?B?TGU2d056ZnhQcmFYbEhXYjhjc3owWkRQZ3ZMUG9qd2F6K1dSYnN1WmtXOVJX?=
 =?utf-8?Q?4e/qkpAVn5XBcNnhaygVMlH1H7MEVfKSGPCuj4FIdDv8?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <34EA9AC45593A244A1D7981457152556@namprd12.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 89b52cb4-a912-4bb8-106e-08ddac8ddba5
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jun 2025 04:25:43.1660
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZuBG4zHoSxAspEuj+wzWk0eLHNRqJnnasbnp1nj+qKYFWGqieMVC7GWFl84nEvZ2/rxdDjAxQCeP6mQwQWsFiQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6144

T24gNi8xNS8yNSAxOTowNywgU2hpbidpY2hpcm8gS2F3YXNha2kgd3JvdGU6DQo+IFRvIGNvbmZp
cm0gdGhhdCB0aGUgVEVTVF9ERVYgbmFtZXNwYWNlIGhhcyBtZXRhZGF0YSBhcmVhIGZvciBlYWNo
IExCQSBvcg0KPiBub3QsIGludHJvZHVjZSB0aGUgaGVscGVyIGZ1bmN0aW9uIF90ZXN0X2Rldl9o
YXNfbWV0YWRhdGEoKSwgd2hpY2gNCj4gY2hlY2tzIHRoZSBzeXNmcyBhdHRyaWJ1dGUgbWV0YWRh
dGFfYnl0ZXMuDQo+DQo+IEFsc28sIHRvIGNvbmZpcm0gdGhhdCB0aGUgbWV0YWRhdGEgaXMgbm90
IHVzZWQgYXMgdGhlIGV4dGVuZGVkIExCQSwNCj4gaW50cm9kdWNlIHRoZSBoZWxwZXIgZnVuY3Rp
b24gX3Rlc3RfZGV2X2Rpc2FibGVzX2V4dGVuZGVkX2xiYSgpLCB3aGljaA0KPiBjaGVja3MgdGhl
IE5WTUVfTlNfRkxCQVNfTUVUQV9FWFQgZmxhZyBpbiB0aGUgZmxiYXMgZmllbGQuDQo+DQo+IFNp
Z25lZC1vZmYtYnk6IFNoaW4naWNoaXJvIEthd2FzYWtpPHNoaW5pY2hpcm8ua2F3YXNha2lAd2Rj
LmNvbT4NCg0KTG9va3MgZ29vZC4NCg0KUmV2aWV3ZWQtYnk6IENoYWl0YW55YSBLdWxrYXJuaSA8
a2NoQG52aWRpYS5jb20+DQoNCi1jaw0KDQoNCg==
