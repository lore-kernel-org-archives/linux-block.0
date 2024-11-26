Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2089.outbound.protection.outlook.com [40.107.237.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFBC317C96
	for <linux-block@vger.kernel.org>; Tue, 26 Nov 2024 02:49:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732589379; cv=fail; b=S5lfglbDKndL+9+qqPckqB6jIC13tntpdiOqSP/wO16aFiLgtYcY9rw/AKKmfoLEHQK33yaxRtTVrLLA3dOY1o6oSyoJu63u3TgzF3Pk/dZ0XsWJ/Rm4oZAnm/EtzBdTnK3nQE3XlASVC8syS4tDDsM/v0Az939LbmoitUbWUD8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732589379; c=relaxed/simple;
	bh=eMIHUkZWpAlJhP/PBRBgRdY1Nu7PC4ZDUcz+afBkByA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=YoFkZEafeaz9tJTTZ2m8lYDcuTot/6sWhTS2vz3Cxwu6OuH3GJJ4hzGBQnkVU4BVfSAAs/VvwpC2eIJkuUH0N/Bg+lEkV4I1Y1r0gFaxvfai2sfx+figppBTHTD1c4jrQAZO/nglz6QELktGJ5ufxAnd10xSVM9ttR031BeFXgg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=cb/XSFHP; arc=fail smtp.client-ip=40.107.237.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="cb/XSFHP"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VJ+R7T0fTucHiRBVtFgUqUNSsV9Xzqbh8+4iu5rQC9ZPR4b77ADrq/QsykB7AXYy0qoIXeC4svx20b8JUXj7/croZLAd86vc6fATtJk0WsTuUU/IhXM5CE5/Ke7oVZ+hckXx4+lZO8ksCZj/DgowWEakNfVGF2R/BuyMiZV7bd+yMyjG6lyYNLmY7BwuTJ6xppw0H60dAuWwB2Y2JT/xMJdVJkxCc4ifYb4sKYyg/2aMgv8v6u6Z2zq0U/k4Ns2yzvI0GnQ/A/t1ZPJmZqW3p8RHYQNWIeN1ZEUg00BY5iikbsGj3m0SnZdyiKmydOS8bbn6OlDcsKC8qfu1hx40nA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eMIHUkZWpAlJhP/PBRBgRdY1Nu7PC4ZDUcz+afBkByA=;
 b=xEq4nTY7gUAlAbMI14btQO7AgkB0xgL81beXwnt4sj+YArQowoPk9KFP3CCFxh9IiVLvZJrbbxUUOV1dpn0anFmujdTyWy8z0cpb1AOQ2At+gUHTeELuNiSyr9MwbcvA4m2zKWLx+qjw2CPTqAMXcRymGCv+fISLT9TuYDaiVOUVDLua+70EAhoz8lPBSoObqPTENewAMuMrFxAvAM+RumdwbQkGkvt4z9y7uSRJteUrDJW3/xOesBijOLv21olKiw70KuUQLFgnmZrDvN31etGBQngbj2vr1clBprWvEigNMmSdBYIWAM3mlTTOmYK2wGicb7wwXquV0U8BxVhwwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eMIHUkZWpAlJhP/PBRBgRdY1Nu7PC4ZDUcz+afBkByA=;
 b=cb/XSFHPp8QxBhBek+Ta2DXNceFk/7GSG/HE7lLugLmFA4Voqr+6qkbL3r2+PnKyOKEiSuxM52PMevd3vr3Xo2DWYk02DfEtYG0Y+SjaBTlL5E+s4b2b/ayG8mHwZuSVsfEEp8w0eEzvRstsdFBwhkLQJaRQ14nXakBS5sAtkC40AV23V18aIxecnqBiRwPpodfmvELcWme9oLh8fRov720P5DW3+TKrYhI5MRuIIt8+C6oSy86JOnf5uX7ZfHhBd2Ms9IE5IOn46L/gO3aytgakvL6Ts27vXD06PZK+v5aVvTfmzM+JqrMOzMGS9znq19YNHWFWypMLVJiQKQwsWw==
Received: from LV3PR12MB9404.namprd12.prod.outlook.com (2603:10b6:408:219::9)
 by LV3PR12MB9185.namprd12.prod.outlook.com (2603:10b6:408:199::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8182.20; Tue, 26 Nov
 2024 02:49:29 +0000
Received: from LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b]) by LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b%4]) with mapi id 15.20.8182.018; Tue, 26 Nov 2024
 02:49:29 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Nilay Shroff <nilay@linux.ibm.com>, "linux-nvme@lists.infradead.org"
	<linux-nvme@lists.infradead.org>, "linux-block@vger.kernel.org"
	<linux-block@vger.kernel.org>
CC: "kbusch@kernel.org" <kbusch@kernel.org>, "hch@lst.de" <hch@lst.de>,
	"sagi@grimberg.me" <sagi@grimberg.me>, "axboe@fb.com" <axboe@fb.com>,
	"yi.zhang@redhat.com" <yi.zhang@redhat.com>, "shinichiro.kawasaki@wdc.com"
	<shinichiro.kawasaki@wdc.com>, "mlombard@redhat.com" <mlombard@redhat.com>,
	"gjoyce@linux.ibm.com" <gjoyce@linux.ibm.com>
Subject: Re: [PATCHv2] nvmet: use kzalloc instead of ZERO_PAGE in
 nvme_execute_identify_ns_nvm()
Thread-Topic: [PATCHv2] nvmet: use kzalloc instead of ZERO_PAGE in
 nvme_execute_identify_ns_nvm()
Thread-Index: AQHbPnBbMTSCz7rNRUqtoB/izuwmRbLI3r4A
Date: Tue, 26 Nov 2024 02:49:29 +0000
Message-ID: <cf29bbd6-b7a4-41da-ac63-6bde2ff52617@nvidia.com>
References: <20241124125628.2532658-1-nilay@linux.ibm.com>
In-Reply-To: <20241124125628.2532658-1-nilay@linux.ibm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9404:EE_|LV3PR12MB9185:EE_
x-ms-office365-filtering-correlation-id: 5702231e-6afb-4ad7-0625-08dd0dc4f2b9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|7416014|376014|10070799003|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?TDBiOFRNZXBvelhNMXdUOXJCNzUxNEVPRVFWemhtY2dHYWpIL2duQUNKdThK?=
 =?utf-8?B?K24wcGpERW1KV05JcmRTc0JSK2dsd0ZkOGswWW5TNVBwT3VjbCtyZ2VTdHlT?=
 =?utf-8?B?bDBva0NVa29mUTFUZGtLck1tLzYrazZ5UkhQQ2pESkJxRmROMnpUYktRK3Bq?=
 =?utf-8?B?YlQ4VHBwYkFVdEphbkliQ2JLSkxGaHNBcWdzSzVjNGpXQlRaeXM4SzNESlBD?=
 =?utf-8?B?WWZBZmcwaDQvbkhWa3FFZENrOTg2T0xyWFlQbnBQbDJsMzdCeEdOSXdtRG43?=
 =?utf-8?B?WWgvU2c1NXF5VlhpV2hVUmxWVmNNQno0K1BYOWJka3pFQnBoYVJLT2Nhekd6?=
 =?utf-8?B?QWUzcTJiTkptaHVtSndQd2tLcVVEVmhhZ3dNM3FUNC9vQW5wc01iaVlKV3dZ?=
 =?utf-8?B?Ty9DZXhmZU9wdjYxY2lma3RrYi8vZ2lpZ3lLWVlyK2V6ajJpQmNwOE43T3Zv?=
 =?utf-8?B?R2cwMWlTODBoRXlLTVFXYnVXZ1BZSlVvUUtaS1AyZzhUVVZ3amVuWFNDNTZU?=
 =?utf-8?B?RU96OWpXVnQyV3Y2bmhzM0VjSmxXR1hoRXpsbXpaNzVKeFgwZmJzWERHSGVF?=
 =?utf-8?B?M3BpSWMzWWFIdXoydm1zdjQ0UTM3elNZRjV1Y3FzYmhvRmIyQy95Q09Za3dD?=
 =?utf-8?B?eFVFYWZFTURZYkN5T3ZHNkU2cHdpY0kyaWZiWDRFUzFSaWxQY1hLd2x2NUdR?=
 =?utf-8?B?ckhNbmVWUHF4QTZteHZTYlArL1VYNW05M2Z1YnVVM0FIQ2I0NFozbUN1QU1F?=
 =?utf-8?B?N2ZFZFNkOHdGcXhuaHNYY01sUEsrZEw4cE8wTW5lTmo4WUdsaVhYVXNUN3lH?=
 =?utf-8?B?R2ZOREFpNFN4SDFWM2Q0NXNaTGhyem5OWUpnU2tSNGY2K0RibmJvemJ2MldW?=
 =?utf-8?B?K0xySmxwVml3MlZxWnNHMDlLV2JlRnFoN0FBMTNMc1JzN0NaOEJqLzA5M1RR?=
 =?utf-8?B?OFR5US9UcFpSbkhrYllLcWVObFpSTTk2eEZXTlljSmEzeFNreUxvTCtveUJN?=
 =?utf-8?B?T0w2UHg1K3A2ait3b0l5RjNXT0tPMFBNRXBTalRscDVQWmtQMmpDeXg0SjVG?=
 =?utf-8?B?YmsvM0hkZTBIL3ZsRmIxMVN3TkhJYURYTjYxSDhYWHZBZ2VhcXZGaDVSOXln?=
 =?utf-8?B?eVRqbDhMRDF3cmdrTWMyMlJveHdvVHlVZGNIY090T3JLalFJN00wUmppZkM4?=
 =?utf-8?B?QUZ6VElEcHVIRXhlemNTajZRSk1vOHdJK2VncFFzODFFUnpJUXZRS2NhU2x1?=
 =?utf-8?B?SFpVbndnOEczWHM1SWFwY0xIbW1LbFFiSmNqNGNpaDdCSFFVbC9vWTBsWEJm?=
 =?utf-8?B?NExMZHV5dy9JQW9PNXo3Yzh0NUNNenkzZWhCdWZ0M2tnT1k5Zkw0US9kcnJr?=
 =?utf-8?B?QUVRK25QZW4zdllMaWhqR2lTazVsYjR5QlBqL3FMWnRibG1SNVlOTUM3RXlu?=
 =?utf-8?B?NERSYUVBN1hnekd3eUgwd1dwNG5Udm95U2NkVDZXbDA1TDhOU2VRekx0QS83?=
 =?utf-8?B?aXZDNE1TeGRrUzdqbEpYeVF3R3Q3anZuTngyWmNSdkFVU2RqMnFyb0JSSUc5?=
 =?utf-8?B?K3IrNkRJR0ErOTg3cEZLWWVxVDMzcVJpckJha0EwZysvV3NkdHFHK2t0VFhw?=
 =?utf-8?B?QTNoMzZwdlpHZFFTR0xtcUtiNlUrTUJYTEo0UFI4LzFMaGxXVmN3aTNCV0ti?=
 =?utf-8?B?Slk2VitsNHZoVFFSUzRRQ05zNTAwOG42NVE1NDlCVHFVbFpiNXBia09iTWJ3?=
 =?utf-8?B?dDRVLzlWSWVhODJqYzZWTnFCbktYN08zMzc3RVFlaXRzTzkrOElFQ0REOWg3?=
 =?utf-8?B?UVVoVDVxOVdnRm1kUnRjd25aOWNzQlpnaWR6M2JmWnB4ejZacC9qVFBGMXFB?=
 =?utf-8?B?cnpjcVBJdUVPOWtnU0loWVpwNXZlVGh2djJvb3M1bkE3NFE9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9404.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(10070799003)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?bS9ydW1xQWttejJxcjJwNEtMb1oxL04vbGRPdHM5N2NpUnYzNWN0c0pHMndt?=
 =?utf-8?B?TnVjYWVFWmR6OFRzOEVlT0tsTFJRbTFaVUVmb3pMeU1YVHZvN0t4dkhQbC9p?=
 =?utf-8?B?UkdvTVlmd1dmWSs1Mlo1TTlXcGwrOURVUjVOZlVYWVI1OFZERS9yc09CMFZ3?=
 =?utf-8?B?WVdXVHAyZG00dkdNeW5QQnRuK1QycVpualdRa2thRnp2TEhzeUdiWDQvVlRF?=
 =?utf-8?B?QjRyMEYrK0tGN2RuR25HZGFUQW1kZkhPak9yWCs3cXZXVDFjT0JrclppeS8v?=
 =?utf-8?B?NWNrUTN2M3p2RmcrckpvWGRNSWJrNXVYOXhiUGpkYThubDltbjkvaHVzOWtF?=
 =?utf-8?B?SWxtSFRQc051VEtpbCt5enY2RHZ5SG1kRUVXOXhLemkzWUxNS3Fnem9Wckwx?=
 =?utf-8?B?eHVLeHVRSWdlT01VN2srSDBJeW54ZC9ZQS9JWXdmTkZ0MmNxMlRvbGpUQWRv?=
 =?utf-8?B?TUl3UFUxTktUN2VBSHUxek5ZejJZVGtTbThaMmY0N0l4Skl1d3o1VUl2Y2Vn?=
 =?utf-8?B?UStmT3pIZStXNjVpeGFTRDJVU05jdGttREh0dVpEMUs3QmtydUIvd2dWQkVT?=
 =?utf-8?B?L2xSa0JSZ2hrSk9vMzd6UzhaMUtUdnpiWE0vM0lTL014RlJxcG1IK21ta3ZP?=
 =?utf-8?B?dkJEZmltaXZrYWVwL0NRQ0NOTUsrdWZudUcwK1pPZ2cxcHZ0aklmTGhWS1FZ?=
 =?utf-8?B?WFJIUnRGN1ZveGMydFpFZEZPaEV1dWlSdGx0eWczUkd6M0ZlMXZURyswS1U4?=
 =?utf-8?B?aTFPQTJheFZCVHk0ZmNrUG9CMS83YkRlcTIzTUFBUlJlWnQrV1FsUGRQYi80?=
 =?utf-8?B?ME8zaTgxWkk5a25kaXVrSTdOQXFZZTRuR2l2UHlTV3Vhd0Fxb3dmMEQ5Y1g4?=
 =?utf-8?B?OU5OWEVvVlJ3Nnp1VHFsenZHRlB2aS9qSHN3MTFPbzRTLzd4S1RHdFlCV1pk?=
 =?utf-8?B?emlJK0VNVElOd0lDaHh3dzF0S3d5UldzRmZPY2p3emE4d1ZMam9KcytQOGta?=
 =?utf-8?B?SmRBVnNwMTNUeXY1SlFERGZranR3V0FOVGZ6OW9xK2RMV0F1eHRXVVoreGxl?=
 =?utf-8?B?QmJkdHVpeVFKQTJZOXZYTWpsaEp4Mys4TDZ3dnJ3SEFza1pHM2ZPVG95dzFR?=
 =?utf-8?B?YWhreGZlVjNSVW00TnNISVJDVXZXckc1V3FDSy9LQUx2eCtIWURYUmsxSTJa?=
 =?utf-8?B?M3lRRDQ1V1pHTHZuV08yM0xNcXcycTJrSmFnSlNPdXEvWEg0YkFpVm9yOENB?=
 =?utf-8?B?OVkxWmh3YzFmdGlodGt2UVRZK2dMeXhEeEpnOW5tS0xKWm01SHlxOEFqQ21x?=
 =?utf-8?B?aGxCMXJTRFBSb1MwUnFvbWdTTEduWVAwTXFjNHdiWWpwRWU1RHhwV0FVeEJC?=
 =?utf-8?B?NkQ1cHdGUFlXcjFocmlNdXRZaEthRmh5eE1Uc29RUjFrS3lwYUJuSkNHRmZI?=
 =?utf-8?B?dis0UVYwcjRFeE05aWtkWUllVFV3RGJwYkU4UGtoamljQzU2UTE3cXVSUWNQ?=
 =?utf-8?B?YXhsYkc4YmdjMXVubm5SR1g3YkZudlNKaCswS1JiRzMveEg0L1NxMC84TTlE?=
 =?utf-8?B?c1VmK0VTYWNzUDZjWHN6NU5MUWIwamhBNENHSWdxdVNKMGs3QWs1UmJjY2U5?=
 =?utf-8?B?THZqcTcrMmhlTFMwYkpxeUVrYndSZlIydTVTVkEwRFRrZWdJU2pZVWJYZm9o?=
 =?utf-8?B?Z1p2aTlqejRMMHVTcTFYbm1YRzNlbFpaNGJDQlMxL3M0MUEzUVMxQnpsNkh6?=
 =?utf-8?B?RXVoYXo0cVU1T24wbHh3Tnpidk9uYlYyeFB3akFGQ2lYNWtZQ0Y5alFCY3lT?=
 =?utf-8?B?N1hBb0MzNUhhcUVHV1FjdE9TRGlUYjZDbjYwdmRJdnB4dmJYaXYxbUNJQTV1?=
 =?utf-8?B?TlFtU2tXNWQrK04wVnd4aEErTU5qOHRNRkRMNHY3Y21idmZIRHgyTUxjaW9D?=
 =?utf-8?B?blU4OERRRWdwYmxZRHRac0FsWE5wTmY4QzFUMUF4K2daTk9WdVpoZlVaUnhD?=
 =?utf-8?B?eXNkR2xiZksxamVPbHFJVlVzUXg4SVQxQVVhTGYyNy84eTFyTG84UyswYmFq?=
 =?utf-8?B?SmJsNnNZeERlbFRQVzRxSjhiYXh5YnNmUHk3eWZDT3VOYUxoOTUrUklWWWtx?=
 =?utf-8?B?SjlVeTR0emVIekptOEtSREhvU1hna1hKUXBsc1R1N1hQOG5HYlp6TVFENWFN?=
 =?utf-8?Q?nRPPhIYDG5lMCkWI6vg229kwhC4Xhk0xAhCQmuz6BhCx?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <3C0681177F0B4A46B8EE3AB7C8695514@namprd12.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 5702231e-6afb-4ad7-0625-08dd0dc4f2b9
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Nov 2024 02:49:29.2997
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: e65LlzEuF0IGNeZrgo+iJJgA03ShGbO6eI1X4Xfi0OdlDhZlYDuyENDNVJdFtCkTS76dStGCFa0bdC8WGqziCg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9185

T24gMTEvMjQvMjQgMDQ6NTUsIE5pbGF5IFNocm9mZiB3cm90ZToNCj4gVGhlIG52bWVfZXhlY3V0
ZV9pZGVudGlmeV9uc19udm0gZnVuY3Rpb24gdXNlcyBaRVJPX1BBR0UgZm9yIGNvcHlpbmcNCj4g
U0cgbGlzdCB3aXRoIGFsbCB6ZXJvcy4gQXMgWkVST19QQUdFIHdvdWxkIG5vdCBuZWNlc3Nhcmls
eSByZXR1cm4gdGhlDQo+IHZpcnR1YWwtYWRkcmVzcyBvZiB0aGUgemVybyBwYWdlLCB3ZSBuZWVk
IHRvIGZpcnN0IGNvbnZlcnQgdGhlIHBhZ2UNCj4gYWRkcmVzcyB0byBrZXJuZWwgdmlydHVhbC1h
ZGRyZXNzIGFuZCB0aGVuIHVzZSBpdCBhcyBzb3VyY2UgYWRkcmVzcw0KPiBmb3IgY29weWluZyB0
aGUgZGF0YSB0byBTRyBsaXN0IHdpdGggYWxsIHplcm9zLiBVc2luZyByZXR1cm4gYWRkcmVzcw0K
PiBvZiBaRVJPX1BBR0UoMCkgYXMgc291cmNlIGFkZHJlc3MgZm9yIGNvcHlpbmcgZGF0YSB0byBT
RyBsaXN0IHdvdWxkDQo+IGZpbGwgdGhlIHRhcmdldCBidWZmZXIgd2l0aCByYW5kb20vZ2FyYmFn
ZSB2YWx1ZSBhbmQgY2F1c2VzIHRoZQ0KPiB1bmRlc2lyZWQgc2lkZSBlZmZlY3QuDQo+DQo+IEFz
IG90aGVyIGlkZW50aWZ5IGltcGxlbWVuYXRpb25zIHVzZXMga3phbGxvYyBmb3IgYWxsb2NhdGlu
ZyBhIHplcm8NCj4gZmlsbGVkIGJ1ZmZlciwgd2UgZGVjaWRlZCB1c2Uga3phbGxvYyBmb3IgYWxs
b2NhdGluZyBhIHplcm8gZmlsbGVkDQo+IGJ1ZmZlciBpbiBudm1lX2V4ZWN1dGVfaWRlbnRpZnlf
bnNfbnZtIGZ1bmN0aW9uIGFuZCB0aGVuIHVzZSB0aGlzDQo+IGJ1ZmZlciBmb3IgY29weWluZyBh
bGwgemVyb3MgdG8gU0cgbGlzdCBidWZmZXJzLiBTbyBlc2VudGlhbGx5LCB3ZQ0KPiBub3cgYXZv
aWQgdXNpbmcgWkVST19QQUdFLg0KPg0KPiBSZXBvcnRlZC1ieTogWWkgWmhhbmc8eWkuemhhbmdA
cmVkaGF0LmNvbT4NCj4gRml4ZXM6IDY0YTUxMDgwZWFiYSAoIm52bWV0OiBpbXBsZW1lbnQgaWQg
bnMgZm9yIG52bSBjb21tYW5kIHNldCIpDQo+IExpbms6aHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcv
YWxsL0NBSGo0Y3M4T1Z5eG1uNFhUdkE9eTR1UTNxV3Bkdy14M00zRlNVWXItS3BFLW5oYUZFQUBt
YWlsLmdtYWlsLmNvbS8NCj4gU2lnbmVkLW9mZi1ieTogTmlsYXkgU2hyb2ZmPG5pbGF5QGxpbnV4
LmlibS5jb20+DQoNCg0KTG9va3MgZ29vZC4NCg0KUmV2aWV3ZWQtYnk6IENoYWl0YW55YSBLdWxr
YXJuaSA8a2NoQG52aWRpYS5jb20+DQoNCi1jaw0KDQo=
