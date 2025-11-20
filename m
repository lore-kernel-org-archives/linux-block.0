Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010022.outbound.protection.outlook.com [52.101.193.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CEFB18787A
	for <linux-block@vger.kernel.org>; Thu, 20 Nov 2025 00:56:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.22
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763600209; cv=fail; b=TbH04olMJ4OsGjc/GUK3J7tFCroh3HKUpLYC1qCxtwl1uWtq5n518qhUNsdyyWu4NnqCYElCoZNKhBa4fYumWkJvyaL+IN0wk9es3dNOywFNE3yrEOX/4sedJUxlLNsn4nz+gGWdBq9O6ldOwlAbs7oNWwVult60QtNAMjlAer0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763600209; c=relaxed/simple;
	bh=ZnZCO+QYtEpkBrBeAjjU+kFxt0bluwBhLug9zf6oKjA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=dSduOme/Bd0zqWI7TuxP14JKP9gHQT8+BEKzd2Q6PBwKONRA5d4V8157o0PlW4bKZ77RO+27opNT/qV7gS5xj3nxKiitcgCF19Sw+Un30cSijBkQLWUJVZaUSJUIfDU6R7U6XEsAMrPN6XPpEzOmFm9O+0vQpEf3/wO0wiD4Ow8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=VX/Kx8bB; arc=fail smtp.client-ip=52.101.193.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="VX/Kx8bB"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mM506rtYIGzl4EAw7rzvaoMDi9V6v171cGb9JXdX3ye8mGv1Ufv94jPQv5K3PVB/LLXPW9Ae0dRUdP8yMUHdmQXvsEMBtwcptlpicFTKoPEvfJi86/7T/d+tVUquEALse6quZHhc/UPir9mfXBS+k4hvn0IznEZpPe4fprw7g/tIHPyErKwGCY1zMtBLggJOPcK+XRbwnsUFBpHSzHe3VPfhL+UbatCzAaAryum1pp0DR15THYNwNX75zuVd+ELAljqQozeBcSAAsI1cVmBjch1Wl4YLFJ3+rYGB2oPIvOwBbUN6rAQqiZk9wZwHY0mMmlUGgsdmFD4/BqK9QCd7DA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZnZCO+QYtEpkBrBeAjjU+kFxt0bluwBhLug9zf6oKjA=;
 b=bLdWwlK/3L+XUfhiDhd3RjXk5QGyxRxjb/p/6rFJii9McltIVf2g8jhzLTcusxqkKy9XFRpmPRX72RekNepP1dx+Ljo9jxIqgNf9P2wHnl+g7b8zWgexJblCaz2j1KqyWpH4wuNhLtQPvLK0iuKxndl/kzYNpWMD28cfOiIItSESOzneL1LDAJA9Z8LLrL66SZaq2Iwb90QxIzZsYMK/KY0dpcgzDxgFOxwoc45+aecuLza1NU1RyaIod/S+FNStYt4056mWw9yu8bbsR31uypJ3YVztQECLNZSF1R1Afe/nS5bwc1QNH/zhw0GKXMrkfVuK3bqxmGMSVrvZ0mtGyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZnZCO+QYtEpkBrBeAjjU+kFxt0bluwBhLug9zf6oKjA=;
 b=VX/Kx8bBZWxFkGatLFzfzHKRO20t1us71YeMnLvINOWsiXxpK2Teqobhnirv5KGSXs6qdntuhrEaWp3fyDkmPOYBMoZ6ElUNZlWY7/XI9XeW6Audw+XqzB5yE+5Ec/iFvxmiZr/2oZ7J3JmWhw1RaNrhBvjymWMidSp8nYitcHBq1H1wUH7SlfT+jB/Z3OT8GK6KaLRFOni9fJffGnyIWaoRvdaFsNDZO/wCCl0Aqg8DQfKzDJaEG7MRlMjUkcvZckNOs7aB9rPJBoaleOCRprYXmTWKwlTpq36jv+aikR8goPpKi0xKNlAihj8YI+PD2dXZEvXg1n4aAgLHsp9akA==
Received: from LV3PR12MB9404.namprd12.prod.outlook.com (2603:10b6:408:219::9)
 by DM6PR12MB4331.namprd12.prod.outlook.com (2603:10b6:5:21a::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.10; Thu, 20 Nov
 2025 00:56:37 +0000
Received: from LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b]) by LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b%5]) with mapi id 15.20.9320.021; Thu, 20 Nov 2025
 00:56:36 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Keith Busch <kbusch@kernel.org>
CC: Keith Busch <kbusch@meta.com>, "linux-block@vger.kernel.org"
	<linux-block@vger.kernel.org>, "shinichiro.kawasaki@wdc.com"
	<shinichiro.kawasaki@wdc.com>
Subject: Re: [PATCHv2 1/2] blktests: test direct io offsets
Thread-Topic: [PATCHv2 1/2] blktests: test direct io offsets
Thread-Index: AQHcWY5pp8pvRk/tS0G+GdNsr4pEy7T6qvuAgAAC4gCAABAQAA==
Date: Thu, 20 Nov 2025 00:56:36 +0000
Message-ID: <d97a75e3-2ba9-488c-a22c-9cb505cb2ce8@nvidia.com>
References: <20251119195449.2922332-1-kbusch@meta.com>
 <20251119195449.2922332-2-kbusch@meta.com>
 <ddda3d01-b95e-4798-b21d-a0c526b5b5a8@nvidia.com>
 <aR5ZyoBaX-47tgNn@kbusch-mbp>
In-Reply-To: <aR5ZyoBaX-47tgNn@kbusch-mbp>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9404:EE_|DM6PR12MB4331:EE_
x-ms-office365-filtering-correlation-id: 8b7d157b-97e3-4002-715f-08de27cfa845
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|376014|10070799003|1800799024|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?MWpKOVIxczBIbUVIRDRoWkx5ZDJ6SlRmdVJLcnZJRlJ3enFmc1hNVlBwZHll?=
 =?utf-8?B?NGZOR3p1Z0kydGYwRWVQbzJla0s1UEx1V2ZhWGwvSTlnSHE1dmVyemo0anE1?=
 =?utf-8?B?MklRc0xhY1AySlhpSFpUN0JkVExXNk44bXZoZmtmU25ZV0phdE9rTHp1d21p?=
 =?utf-8?B?a2pPYVlTQXdEdUlpbFFMTWRoa1lDUytZRUFsdDFuQ2tKU0JPVVF2Q3RrZk9z?=
 =?utf-8?B?NDl3SVZLZ2dzR1FuYjJGQjdzOGZqNFJ2WVo5RjZQb01MM3FjM1ErVUZkblgr?=
 =?utf-8?B?U1c1U29lZU5lMTJRTEtlTlVjQWtNSkdZSFppMkc5ZnNjQVduTjdIS2RscEtl?=
 =?utf-8?B?WHMzZkJtbnp6VURNNkxuUWg5UEN6NDRNZlEzMzM4eDBNb3I3UFA0YWtnM1Ru?=
 =?utf-8?B?R0cvS0wxNzNLdTFvZVdLQ0ZqMUFTMGlwYzFPYzJOUzdidEtqdTNaRS9xOEpM?=
 =?utf-8?B?VjhUVXFBUXZIQlQwNE54bERwbFh0VzlOUW1WYmMzOGhnTGo3VnZ0WTlVdkU1?=
 =?utf-8?B?aXlzYTRXdGxSNkRaQnBQL1U1NWNZK0RiUUs3Y05oRE92OEVqdGJzZFFxbHlX?=
 =?utf-8?B?MlBMcUNLR29jUVA4TmZUaTVpOGkzK3FuaEJCU1lmQjJ6OUllKzdlRlF2M0NJ?=
 =?utf-8?B?a2lIdVJCMFZCRVlQM1ZZZ0pmYjlPRk9jMDczcm9vaFNFMDd1OCtjaWUyUE5n?=
 =?utf-8?B?QnhrQWRadWJaRlpIdjhNY1JOOUdxdGdtOXI1THVNOE5rWXdTQy81WHlUUzRy?=
 =?utf-8?B?a21yNG0wREUwS0ZLYnpLT3FjL3h1OVpQS1hGR1ZNdnVyVjdvbldxbHlwbkRp?=
 =?utf-8?B?SzdUTXRGVG5Dcm1IMmc0YkZ3dytHcSs5UU5EL0t5ZXlvUHFwdEI5T21QY1g5?=
 =?utf-8?B?V3FwaFJTU0xIckRQRGVGMER4WTV5QzNzYzVSWERGZi9PZHEyNXJRUDZaQ1pL?=
 =?utf-8?B?SE9GVmhFd3RwMHpKb1hYb3JVeXhHK0MwT0o1ZnBHWTJFZlhZeThubll3Y0wx?=
 =?utf-8?B?M2JrSU54eXJGUVNZMys2NXpIZDJwWXpRRm1MTDJGQ0lWOGZFcGJGWVVEL1NQ?=
 =?utf-8?B?MDkyYXZnL09teEZjY0ZVdVdJaHl1dzJFT20xaXl1QUxSTlV5T3RBSVV3dmhs?=
 =?utf-8?B?akd0Z1grYlRrTmxZSTdVSXBhbGZwRGtuUmVDKzhNTGRQTS9CUE9Mcm9GWjZR?=
 =?utf-8?B?NFNyNHJoalhKRjJRYjF5MVhSd0F2bTgxbWxyK3FEbWptaTc0QkdVWTVPOXdJ?=
 =?utf-8?B?aFVWSEIyME10VHNCTU95dWhqOTI5Vk11eHpaRE1ONjYxYkRkRG9MRFo5SzlN?=
 =?utf-8?B?YlM5YjNkWkNiVlJMZTFwdEZMSitVckNmSVBxYWVSNnJSM1NpOTZxdGtMQkdB?=
 =?utf-8?B?T3hITWw4OTNaK0x5dFlaWEREMW5ocnMxWWYwNDZRSHhqd1hiU0RZS2ZaZm5x?=
 =?utf-8?B?akFlaFhyKzRKRE9EMEJOQWx5V2MzNEVkNlhtdzdJMnFQVmh1TGJHb1RsSml3?=
 =?utf-8?B?b2VuZ2dFclh4K04yRjJiby8xaGFVU3FsUWZFRnZhY0w2ZVFTQlJsTTlJZlZV?=
 =?utf-8?B?VTI1bEprS1NXSjZPNGhDbWdsNWVwdTk5ZjN3SDNISXhLcTdtZjFXZ3FnRTRI?=
 =?utf-8?B?T1JGNHZnaHJNNWNDdTU4UFNtNnlZVzBXclBpUE1oTytVcDA5Wjl4a3d1S2ZJ?=
 =?utf-8?B?OW1TeHBmcXI0Mi93WHBBYWVsck54eWl5TjdXQk5JTVluWjNFZnF2eTJ6bGFt?=
 =?utf-8?B?NXJDVDhHb2lJSFNNZFZ4eTJMRmhXSDIxR29GWnZRM09oOWwxWW5GdG02dGFR?=
 =?utf-8?B?Vk1rdFc0aEh3UkxhZ253ajVxQmlJdjByWFZTWlVQTTU5d2ZrVmRiaXlsNzJH?=
 =?utf-8?B?R2JENUdnTDJXWS9UUWZ0enhkZE1jV0hUMWdlc0FqMTc3SmtobUJpaytsNkl4?=
 =?utf-8?B?UndCUWNZWnFNYzRxUG11SXBNcWx3VnFxU1pKT2hLM1hONDBQSlQ2czZSZTZC?=
 =?utf-8?B?Yll3cjZ1d0x1UG1vSkRuL1NGVHVJTU9XU1N5aGZCa3hpTGR3MVZ2WU1tWEdU?=
 =?utf-8?Q?H0K66F?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9404.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(10070799003)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?ekRvdGhxczhROHVmNzMyVWczQmNvc0luOXU3QTRMR1pjZnB6YVdQa2dvR1ho?=
 =?utf-8?B?UURKWjZVZXJJN05RMGZGU3AzbjJYSnFrTzJBVlNuZm9oR0NKaHZkMEJHUEJn?=
 =?utf-8?B?RmtlZDZxTSt0RW0xNGNXZ3ZabHF1VDRIVk84dVNDOHhZS3pFOEtWcmRCMVFX?=
 =?utf-8?B?RjZzOGlVQmQxcWh4QTI2aGVEbklReEN5b2M1M29XT0drOG1hU2RBUjM2VFBm?=
 =?utf-8?B?VGsvYkdOMkd3SFdMcUhsY3c0Tmh4dTltbFhTRk9qZDlIN3E0eTFIcnZyWVZ6?=
 =?utf-8?B?cDdDMm5QTTJDVVBQM3MyK2xwRFJvNnVpa2xBL2laVTZBYkdjUFdVNkx5SHY5?=
 =?utf-8?B?RnhRcXoyRkQzZ2RmbW5oclVYWmFncEtrNms1bDdWZHU3ZWR0bzJBZUdOcTl1?=
 =?utf-8?B?cEpXWTFWV1VMK29kZVhDSEtYZFpzUXBtNGVBTjhuZlFqWHY5NDZCeFFlM3pp?=
 =?utf-8?B?TXRwZW0wRVBWRS9ubEw0OXRxMy9NTEdueXZxQ1liMDYyZlpvZEpSZHlkMjdX?=
 =?utf-8?B?bWlHazlFMFE5UERzc2hqNXdUTEJIck91c2tCK1VNblBha1BVOTNqSG9tWUs2?=
 =?utf-8?B?dnk0YkhwZ1FEcTRKcUJLVDVqWmVmS2JaRDFYWnlvdEQrbXNLMHNxUTF1MTdE?=
 =?utf-8?B?cGZQZ2dSUlUzVmpvWUNsSll1NFgxT0NEUFBNOWFIS3BEMHQwL0pDdFlmOUNF?=
 =?utf-8?B?dWxFWVZRRDhDMW9TV3ZUcEplNWlTU1E5U1JyVWFnSEY1anVxUkQ0TmtkWVBH?=
 =?utf-8?B?aHlya2h0RVVHTTFXNTl2dm4wS0REV3RmZVZ6QWRuWS9hT1RXOW5Db01COFVp?=
 =?utf-8?B?ZmF0c1NqeHNrNWJqY1FZNWgya3VOZ1ZWVnNqSnFKcUc3a0NJQmt2U1JqWkRT?=
 =?utf-8?B?cXFzWUc1bFZyRE82UnVhU2xlc3hXRU5hRTVFaG1tdlVCbVVnK3Q1cVVMQkt3?=
 =?utf-8?B?MVgvM2t0L0dVeUF5d2lkTmpDNlZJMGp4Y2x6SnhKQkpoSWNFR0J3akcvUFRY?=
 =?utf-8?B?K3JVYk9veFRPMDkxQS96c2xkMkRaR2RYN0FMWEhGcHRNVW9QT1lMT1E1cyto?=
 =?utf-8?B?WnB1cTdaOHNiTnN6NjIzQmFPNlJtYkE5Sm1VT25ERW9EU2IzeVVDN0ZjcUJh?=
 =?utf-8?B?ZmZCajB2emMxWVNJQ0NYUWo3Z0JUcWpUVEpLSSttMXo1SnFkQWRQUTNsNlNu?=
 =?utf-8?B?Z3pZeXVuMVExYURCQWtUWVUwTS9ibmNvUzlsQnZiVS8wa3QwSHhXU3A4bEp4?=
 =?utf-8?B?KzdreEJ0V0dFL2I1ZXE2Kzd0cTQ5bWI4TzJNYURtMm5CcE9rL2x0MXhkaDJV?=
 =?utf-8?B?MGVYeXAySHRrTGNKblY3c1pJTkxBbEI3b2YxRndMczNPQ0ZOVzFiY0d5M1lP?=
 =?utf-8?B?TmE5UVdQL3RiODM1UktJMVhSUTA5ME9JSjhERlZOQXpsdlBpN3FEZDB2VDFG?=
 =?utf-8?B?czR3Y0N5VDBOMm56MG5INlZNckpkZk5iQ3VVWGJsM3d5VGpRbm9qd1laaEVT?=
 =?utf-8?B?WEtLb2dWRWRyZGQzVjRNTDM3ay92Ny9oSGI2UldrMVZENkRRMW5ZU2piN2Jo?=
 =?utf-8?B?OWNudjJvaCtsdzg5Y1YxTVlCVVZkZ0gyZWFac1FkR0tCRmJ4aUNTRHI5NzNU?=
 =?utf-8?B?L2JJOWtxYnlGemFMYnk4M2x3dU9zM05Xc1V4cEZnNkxqUnhQYS9KYnFmYlpP?=
 =?utf-8?B?eWhiaVlsalN5QUFZdFViQlVYZ1pNdHFpTW9Wa2t4WFJFMjU2ZHAySmlBeVJD?=
 =?utf-8?B?eER4OE9maE1PNXRScU9KcDc5VGtHSEZmR3pLWjZrdThKdkpycnp2bUZxcFRT?=
 =?utf-8?B?QWw1ajNCV2dEQlVTTXN3MHVjYk5vN0hrS0tUbGlSallXK3hXWUlJdzYrUS9q?=
 =?utf-8?B?MDVwM2NPbHVjNU9nMWJKcnJOZUpyU0lZSlVvcUI5aWNCQTZTdlgzckNpanY0?=
 =?utf-8?B?ZmQxNG9TQWdwUTRxQVRhUGJ4Y0FEWHhMODRKRTVVUFZzM0wwbGE4K1Nmay9I?=
 =?utf-8?B?VDJlbytLOVJRbVU1VjJpaUVBWDJKTkdDaGxHVHY1cVR5MzgrZlFVc0JUYXdk?=
 =?utf-8?B?cjlrUnhMZTY5VTdhQ2Q5dUlaUldRWEw4YmpWb0gvaWJwaC9mekJBanpXMHBv?=
 =?utf-8?B?UXBCYnFLRjJ2QWExcEdJQUg3SlFZVHpnWDV3SEdNWER6R3FQYWdRSFVlS1hL?=
 =?utf-8?Q?WzClr696yGr/Z3QXVu7BOSIJZsZj45QmjLVu4RzOdXVL?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <EE98F6172FB25D4385C9572E90757042@namprd12.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b7d157b-97e3-4002-715f-08de27cfa845
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Nov 2025 00:56:36.7632
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2WRftq+BMF2VIH7RK/kiHdIFTqKPIOMbSNEZmMjS1+rdAbTU8s23mSFQM9ZogWk7t7Atpy0cKbf9/EdIV2CANQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4331

T24gMTEvMTkvMjUgMTU6NTksIEtlaXRoIEJ1c2NoIHdyb3RlOg0KPiBPbiBXZWQsIE5vdiAxOSwg
MjAyNSBhdCAxMTo0ODo0N1BNICswMDAwLCBDaGFpdGFueWEgS3Vsa2Fybmkgd3JvdGU6DQo+PiBP
biAxMS8xOS8yNSAxMTo1NCwgS2VpdGggQnVzY2ggd3JvdGU6DQo+Pj4gKyAgICAgICAgcmV0ID0g
cHdyaXRldih0ZXN0X2ZkLCBpb3YsIHZlY3MsIDApOw0KPj4+ICsgICAgICAgIGlmIChyZXQgPCAw
KQ0KPj4+ICsJCWVycihlcnJubywgIiVzOiBmYWlsZWQgdG8gcmVhZCBidWYiLCBfX2Z1bmNfXyk7
DQo+Pj4gKw0KPj4NCj4+IGlzIHB3cml0ZXYgY29ycmVjdCBhYm92ZSBvciBpdCBzaG91bGQgYmUg
cHJlYWR2ICgpID8NCj4gR29vZCBleWUsIGl0IHNob3VsZCBoYXZlIGJlZW4gcHJlYWR2LiBUaGlz
IHBhcnQgaXMgY3VycmVudGx5IHVucmVhY2hhYmxlDQo+IHRob3VnaCwgYXMgaXQgcmVxdWlyZXMg
Ynl0ZS1hbGlnbmVkIGRtYSBsaW1pdHMgYW5kIHRoZSBrZXJuZWwgZG9lc24ndA0KPiByZXBvcnQg
c3VjaCBhIHZhbHVlLiBCdXQgaWYgdGhpcyB3ZXJlIHRvIHJ1biwgdGhlIHRlc3Qgd291bGQgaGF2
ZQ0KPiBmYWxzZWx5IGRlY2xhcmVkIGRhdGEgY29ycnVwdGlvbi4NCg0KaG93IGFib3V0ID8NCg0K
MS4gS2VlcCB0aGUgY29kZSBidXQgZGlzYWJsZSBpdCB1bnRpbCBrZXJuZWwgZ2V0cyB0aGF0IHN1
cHBvcnQgPyBPUg0KMi4gYWRkIGFuIGFiaWxpdHkgdG8gYXV0b2RldGVjdCBpZiBrZXJuZWwgaGFz
IGEgc3VwcG9ydCBiZWZvcmUgcnVubmluZyB0aGUNCiAgICB0ZXN0IGVsc2Ugc2tpcCB0ZXN0X2lu
dmFsaWRfZG1hX3ZlY3Rvcl9sZW5ndGgoKSA/DQoNCi1jaw0KDQoNCg==
