Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2053.outbound.protection.outlook.com [40.107.220.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C29A22339
	for <linux-block@vger.kernel.org>; Mon, 14 Oct 2024 06:41:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728888068; cv=fail; b=oWtwc9DD3y3ps0M4pmMeMshPvJGwFG6cqTOV8zSNfsyyg568Xf9NgBthOFrkmB6j1FA946eLLs0wKaBfPFJAEb+jrH36Yqave0+jvIIBNuANrYX0nP2Ugioa56PmVnvjOekPbZ9MI3MBNtGq6lQ85AqAhipvOm53Z35fJIDlveI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728888068; c=relaxed/simple;
	bh=vTZkbHibRAGOZwx70y/m5UBHX3JD7dYwZyo+wuI2t24=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=qhZHrBbMQZgAGMMnYKlc2tI08BGED6fgBYD/DymxNzCaUuGBN1kARwuJftf53noYmTSv9KrtHfm+NsWTVq2U3qv8MyuH9ZY4nbbl4lRyJFbCkDlcApwkuTZzf6E80W5aY8aEUQmxpEOvs06JbohTbZBWKYc/DnQsinjOoVmFCVE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=rNA/7eGG; arc=fail smtp.client-ip=40.107.220.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="rNA/7eGG"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Tp7MTsPoP3zuhKEwDTMu8w6NOYKvLrXDxpHYyF9HpWRMwjIFsO8N+ZQst3H1AjiUthXZFg3WK+4CyOR3r3NAnsA75pdtTt7sySoglh6lvgf1fsBbIVnRuN38AyeBVwF0j3IaF8GI0Jk+BqojK6/F2qaLu7GAc71Tl7QmNMkH4T9lPapLHbJ0cBxG/6jMIWHFkkWrJU4xWvbAX3xFYARh5VmzYy+j/xJWW9bsn6gjCQNlt7QKPVBn0uTqRZW+5Kp8BG0GO7el9GVzUvFTa1vq+Yvm9NIKXSch8e9EcUvXkNiNaKZD5lvS1SJgnjnri0zkvSX2kz/bs9nG8+bhEZmPeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vTZkbHibRAGOZwx70y/m5UBHX3JD7dYwZyo+wuI2t24=;
 b=KZYQMOxvMUo4heOkS7tTWNL629r5LHD0PQljIexx+I4qwkMU0H8zRxz8QE+ugTdv+OjRmwKUAmOb381v2qxAA+gFEwu1NjRcv1ckSiwfiBbTeflzSMALdoz1yowWS6Q7wqCVNWpK0IAHtrUTg4l3+vCmQvf8EUlA92m5gKfNA2fYfJDAnC8okj3Wphck6ttxZihba9s5s4Ot0xkP6T3eaMGUjMViA0pPe6FYomut8K/FOCnLIJ83snvwHBwOl2VnGxL/RRAIe45YIDF9J0Nd/ZGNNQOrWg73kbEpfh8nrI9+5h7VpdfIFw3uDu9CWYUY/03AoHSoVCw2xwa3YZ/ziA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vTZkbHibRAGOZwx70y/m5UBHX3JD7dYwZyo+wuI2t24=;
 b=rNA/7eGGi32rDtfXTkPrhFN2EeLL1NGBLeWQk5YqIkJ6JV5boeSfSj4R7cPZ6tO+1UUzSL/KM2FbPse/VV5wQDVjt16X0t7/l8R04r8Is5RsScgraOyqoDkS4gsWig/WDyK+gaGEc2Nyf5tx4hUudoQeBTohG/0HMApoLQ1b4CjgiFuqyByjd9SBvwb8Z3Ibp2NHVM7BxGmhE+f5mKteHiGOaiBwY5hWG6frJ5f2DQcDsorOp/+qu1OCX2rs6PLn2qYZUCUcPTLDrWQREZznswBRBMjBCVnAdPOuuUUIXKmtBgIxBB7SiageKEbaP6e1e3i1V+tQ3AyYYpk6LAjJhA==
Received: from LV3PR12MB9404.namprd12.prod.outlook.com (2603:10b6:408:219::9)
 by IA1PR12MB6305.namprd12.prod.outlook.com (2603:10b6:208:3e7::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.26; Mon, 14 Oct
 2024 06:41:04 +0000
Received: from LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b]) by LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b%5]) with mapi id 15.20.8048.020; Mon, 14 Oct 2024
 06:41:03 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Guixin Liu <kanie@linux.alibaba.com>, "shinichiro.kawasaki@wdc.com"
	<shinichiro.kawasaki@wdc.com>, "dwagner@suse.de" <dwagner@suse.de>
CC: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH blktests v3 1/2] nvme/{md/001,rc,002,016,017,030,052}:
 introduce --resv_enable argument
Thread-Topic: [PATCH blktests v3 1/2] nvme/{md/001,rc,002,016,017,030,052}:
 introduce --resv_enable argument
Thread-Index: AQHbHJeXOsYVmcxOqkKjic3ksOVCOLKFzuSA
Date: Mon, 14 Oct 2024 06:41:03 +0000
Message-ID: <d421f66a-2e00-4932-8ccb-dda14564288a@nvidia.com>
References: <20241012111157.44368-1-kanie@linux.alibaba.com>
 <20241012111157.44368-2-kanie@linux.alibaba.com>
In-Reply-To: <20241012111157.44368-2-kanie@linux.alibaba.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9404:EE_|IA1PR12MB6305:EE_
x-ms-office365-filtering-correlation-id: 9fb4aeb5-ab93-44d0-84d2-08dcec1b2cbe
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|376014|10070799003|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?WFBsTVFlc1c3RXRNZ01UandUdWFoMzkwZDRSa0ZRbjVaOUZwY0xzWFp0Qm1I?=
 =?utf-8?B?T2dpZjdEcnVURnA2Q1ViMmZ1cHl1YkJIT3Q1Zk9HSEd6amdTbzNyZng4Rjd1?=
 =?utf-8?B?dzA3aTl2c3Zmd0VRclIvZmlGOEt3eE9RQUpncWtkQm1TWkNMVDRzZ3Q1Rnda?=
 =?utf-8?B?L0hHN3pQNkJlTDVYUWcrcWFDSVM3QndTQXMyUVMzMURDRWNNd0xXVnB6Z0pH?=
 =?utf-8?B?OUFOTlY5WWw5dEdIZDFSVTV2YjhyU3piZVVNTGplK1kzR2RLSVVJRjVkaDZG?=
 =?utf-8?B?K2I1NmJNU0xmSTRzUWV3R2lrZ1pUMm5FWGNKL0QyYzV4VTQrZXVPQytUeXNQ?=
 =?utf-8?B?SGVJelZNTGt0NWFWSFk5V1hCZExzVS80WHBJZ1I0bUhuRk45ZzdOSys1L3k0?=
 =?utf-8?B?YlJMNEttZ1ZHbSsxQkIrKzFvRll0VWlLUTlTUC9WS0hHeHoxd081SWFXMllw?=
 =?utf-8?B?MzJLL1k0cXVMaS9LRC9vWGdNSmFmbkpLSlVhcldiWG5VOWdpM2FGeElDR2hh?=
 =?utf-8?B?VXdEeGlhcnBuZjNjQ0w0ZUFPelhRbTQ4a0NHTC9GOTd5dTJMVUoveDV5TFZP?=
 =?utf-8?B?RkNPQUh2MkZQWkRxOXdXdHltZHl6WFptamw0TGtoWFllZDhBYXQ1cHRUS2cv?=
 =?utf-8?B?bnFvZVlYWXlWbUxGT0RPK0hvODRKTTMxbkxjVTlic0NXUm1MeGh2K29URnpR?=
 =?utf-8?B?R2VnRmtOVGpzVDRNV2lYWGNCVXJxUW5yVkJBejNiTEVZc1hBU0hGSjVxb01O?=
 =?utf-8?B?SWhFY3Z6VzBMd2NOSUtEZHQvbDh3TldsR1A2dG5xMkdMVWJRanBobHYraUow?=
 =?utf-8?B?RWRkOVJ1YnNRb3pDNGRISFdCaEtwNjdCSFVLWDVjQjB0bm1LbWh5bERLN24w?=
 =?utf-8?B?aHZEVlBhWFQzMVFtZmsxYno2K3AwbUIwa25IVkNYUTdYYjkxQlZNa3B1R2h0?=
 =?utf-8?B?N2gzUzVVYlU5VXNicnEvVW5wU2JjUXhGOHZyN29CTWlBWDUvUEJxZXdGU0xB?=
 =?utf-8?B?OTV0TURvbXFqY0Z3SUxGWXRhNXdLRVh4ZTdwNE94VUlxYmROSDFOV2NnSmd0?=
 =?utf-8?B?eUF0UlBZWXVFS21IK3loeUs2clgvbHgzQzRXMTI5VEhpT2g1K1pwMnc0OVph?=
 =?utf-8?B?N2pmOUp5ajMzckhvY0ZaR0JhbnJUOFQ4QUdoMjloVXBWbjdKM0pKZE14bUIx?=
 =?utf-8?B?WUhsUHFtbnBtYXBuSm5qN1Y3NlR4eUhuRmVMQTBKL3BqbEF5SG9zQmo4L0Nv?=
 =?utf-8?B?Q1pwc0dBRDN4VitnejN3eUUyNEh0L2JCMlRmY3FMN1V1ZGNlK2RCSGQzcGJP?=
 =?utf-8?B?b3RMMENpSnZLMnZTUmZnTDUva2hBaDFPdGpsZENSRTlNWkNOMHdaTVBPZ1hF?=
 =?utf-8?B?NERlL1o4T1k1em1pZjlmdVNDOU5ET25ZSEFxcHB1WU9HWnVrTVB4VC90RC9v?=
 =?utf-8?B?UXYxTnBRSE5WT2Zpd0FJand2WUtFdDBRUU9wR25Oa05wUG9wRW4ySUwxVmRj?=
 =?utf-8?B?aVNaWnh4NzFzVEU3cXRremJ3djFVRXVDTjRLcURIYy8wZzk0Mi9pSlovTTJH?=
 =?utf-8?B?RkpqS3p5RCszY2FwOW1XZkV3T2hVVTBUWmIvQ3QrYlNwR0hhbzlDdEdRZFdu?=
 =?utf-8?B?VUhmZHF1eXZkKzFDSTBKODZ5U0V5ZEJDQzA1NHM4bkgwaEdLZ1luaFd5S1Uz?=
 =?utf-8?B?RHlOYmZEOHhUQ3pjQStMT1hDcENUVTBRZG9GdysvM2JzamhMNDRFajI4QzBN?=
 =?utf-8?B?em51djI0cUNuc2Urc1lrM3JCZUFVWHpsRjdPU1dad3pjOGVwQk51ZEp5Um02?=
 =?utf-8?B?NzdLTmpZalFKRDdiWE5tZz09?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9404.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(10070799003)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?SDFjU29MR0NnMGJFaDVqSWFWOW11WU92aExkaEZjMWwrZElNRE03R0pDSzJh?=
 =?utf-8?B?K3FueTJCNE1LQkI5RXlvOWQ0dDBxd28wM0ZrRzZRYklYblpkdTNPQ1VyMUhQ?=
 =?utf-8?B?cFg1ZnNObDJ0MTRxRVB4WUllVmxPcEZTcXJKNkZPK1lXR3Y5am9zenlid1N6?=
 =?utf-8?B?VWU4eXNKSTNxN01xemZhTG5BRmowRGRKK2UxS0dRVXIrM1ZKdFdyc0NmWGps?=
 =?utf-8?B?WDd4NEY2T3hZblV4aUhyTzBoK3dPR203UldwYmRzQVlzem5RK0tBcGdvb1Ex?=
 =?utf-8?B?eDdiZzJQMDJQMEZEYjc1Qkg2ZUtEMEdERUorQW1ZTWdlWjRkTzA4S0tXNzJo?=
 =?utf-8?B?eEIvZWtna29sdGthMmhWVEFOYmZaQTgvYWNNSXFEUFpwbWlhd1VsbytwUFlO?=
 =?utf-8?B?aDlXdERHMkxOZUJVMXVENjlCKzVzU09ZUVJ0aTExUUh3SlptdU16V2JjcTBl?=
 =?utf-8?B?ZnNVS0RrN1lsRWVBRmYyc2xQaVhyQVdLNnpJWEkzWk9uMjZEYWk1dDVqTFNM?=
 =?utf-8?B?aExsV2tuZzRQdWxKaXVzZDkzeW85RnpnSkpjU3ZGT1pnakdmQ3Z3ZURQTU9R?=
 =?utf-8?B?OVhMenpqd3ZRZllwNFQ0Y1RvY0tmVHYrNkpUWVh2TzBBT1B1UTkrUWpCVVBw?=
 =?utf-8?B?V1hYV1FxQjNESk1rV3NoQmRWYnFaU0ZodytzU1gwd2ZKZTRnNjJHemdRdzZO?=
 =?utf-8?B?MjVyOWs0UHZoSXM3WHZ5Z2J1aDlKWG5USDB4REFNMmZLS1R4cmgvY0RQamRp?=
 =?utf-8?B?TVpvaVp1MkNuLzAzWm44K2w1bDZmdWxEdlRKWHNnZW5mRVIwWVJaWFBxZ2xG?=
 =?utf-8?B?bDh0YkY3RDdpNHNtU2l0WGpPZXdjR0RORnovOHZ6ZWp6VEJZWjRUOGRDdDI5?=
 =?utf-8?B?SUMyYWNlOVlKTlpabEdlbitjWk9ZMW5NMVU4UVpTZVppeEtKbjFPOWNGR1FU?=
 =?utf-8?B?QU13ODhXUThSQ011czFTbDcva2svUWdCSWpvVTU2WHZSYVgwU3M5UEZIVjRZ?=
 =?utf-8?B?YlRqcVd4TVljTkdPczZBa250QjFYS1ZMODRTMGhmdW0xMFZHVElRa2NQa2RK?=
 =?utf-8?B?T0lTKzBaZmlTbnlCSm9sVGZ2VHJTQStGcnkvc0RoQXhzeVh5T3FVRVBGcVFX?=
 =?utf-8?B?clhFa2pPVzNFTUExalFNMVBJYnA4Mm5Ub3lxaUJJNG9wNWpwc3Z0Ull6bWJ0?=
 =?utf-8?B?K3BKejVnNVpIMUl2YzBKTDVLVmJzOEIrQnVseTVKKzZOclB4T0g5ZUJ2NXZl?=
 =?utf-8?B?cEM0b1BqSWF3dUYvRVhSem1XWkVvNTdLZmxZK081enMzczljUU1jVVZQVVoz?=
 =?utf-8?B?SzRBSXRhQ2NZU0xDb0tjMjBDeS94dHB3SE5JUENwUHpCVS9NaTg3OTc4Z2hi?=
 =?utf-8?B?WmQvdFIvNXl0dTdMTjBOZ0RpczluZGhkalR2T2E3cVFRNm81Vm4xaFY0cWxE?=
 =?utf-8?B?UWFOSFE1cjlTbkExbnNLeTg5R24wVmdXYmNad1FTT091UjZaOXVmV2tEaE5E?=
 =?utf-8?B?QUh5QTVZS0VyamY5Y1RxMzZVME4vNWZmVGlzei80emViYWZwaGU2bjNxMk9I?=
 =?utf-8?B?QzBobFhpTGpTZ2VsYzRjNUJobFRKQTd3NG50aHZaT1BLMHJZMUJmU2xoQVZn?=
 =?utf-8?B?NllodnA3MERPL2FmUVI2Uk52dG5ncndTdm5NZEdBZVo0cFJKaExUZmsvUld2?=
 =?utf-8?B?YnFmeHF5MS94eHNCb2JIK2hlaWI4d2lsM0ladG9zYkRvaE1jMUlncEE3V2ts?=
 =?utf-8?B?ZVViSml1Uk5OdW41U2xsbkU5N3dPcXB3L21tb2hxNVNyUTkxSnBoUHk3TkdY?=
 =?utf-8?B?Zll6b2tpRkxJZXdoVTdhMEE2VVFERE9JTzcxc25pYUYvWTVCZXZxSHFRNGRN?=
 =?utf-8?B?WlNhZUI3ZlByZHdyRWhzVWJoUDFEaFRDKzM3K2xRcFBrdFA0U2pwYUJyNi9t?=
 =?utf-8?B?VWZNMm11Z3V0MHpSS1VOVk5Mak1tWkIrTFIzVEMwVkpvVnBHbXlLaFdOSzMz?=
 =?utf-8?B?RnJkR2R0TUVCSDUwNEE1eC84STlBNE9jNndYK0ZHbTR5Nmp6T0hQOXEvTGlL?=
 =?utf-8?B?aXdrQVpEZXFFelN3NmlNaS85SVlyYUV3bDJIMHRVOFBCamR4NU1BYmdCWVRH?=
 =?utf-8?B?U0EvTVR6WC9DL1ZPS2JYOWNLZndTem44V21MZXViQTAyT1pySml6MUh0NUl5?=
 =?utf-8?Q?XybtHRYHYld9DQYbABQuguko6MhR/RneERq2Mu1t1vdI?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F239E39BDECD0540B2DFEC49C2D58AE9@namprd12.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 9fb4aeb5-ab93-44d0-84d2-08dcec1b2cbe
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Oct 2024 06:41:03.8371
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aoS6IDobmATr0oJQGLDfhbVga1cC7A2N1SnCbUh3oRb2WzA/pDO31l/YiJvHm6UJV04UBSMrdsdCiRQSK+KTsQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6305

T24gMTAvMTIvMjQgMDQ6MTEsIEd1aXhpbiBMaXUgd3JvdGU6DQo+IEFkZCBhbiBvcHRpb25hbCBh
cmd1bWVudCAtLXJlc3ZfZW5hYmxlIHRvIF9udm1ldF90YXJnZXRfc2V0dXAoKSBhbmQNCj4gcHJv
cGFnYXRlIGl0IHRvIF9jcmVhdGVfbnZtZXRfc3Vic3lzdGVtKCkgYW5kIF9jcmVhdGVfbnZtZXRf
bnMoKS4NCj4NCj4gT25lIGNhbiBjYWxsIGZ1bmN0aW9ucyB3aXRoIC0tcmVzdl9lbmFibGUgdG8g
ZW5hYmxlIHJlc2VydmF0aW9uDQo+IGZlYXR1cmUgb24gYSBzcGVjaWZpYyBuYW1lc3BhY2UuDQo+
DQo+IEFuZCBhbHNvIG1ha2UgX2NyZWF0ZV9udm1ldF9ucyBhbmQgX2NyZWF0ZV9udm1ldF9zdWJz
eXN0ZW0gdG8gcGFyc2UNCj4gZm9yIGFyZ3VtZW50cywgdGhpcyBtYWtlcyB0aGVzZSBmdW5jdGlv
bnMgbW9yZSBmbGV4aWJsZSB0byB1c2UuDQo+DQo+IFNpZ25lZC1vZmYtYnk6IEd1aXhpbiBMaXU8
a2FuaWVAbGludXguYWxpYmFiYS5jb20+DQoNClRoYW5rcyBmb3IgdGhlIHRlc3QsIGxvb2tzIGdv
b2QuDQoNClJldmlld2VkLWJ5OiBDaGFpdGFueWEgS3Vsa2FybmkgPGtjaEBudmlkaWEuY29tPg0K
DQotY2sNCg0KDQoNCg==
