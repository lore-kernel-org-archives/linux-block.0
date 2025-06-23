Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2076.outbound.protection.outlook.com [40.107.96.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8C1D1AAA1C
	for <linux-block@vger.kernel.org>; Mon, 23 Jun 2025 21:45:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750715129; cv=fail; b=umXa15khT1sKucQkspPoZ10uGiWhnYvJoXFIWGMCk5YrGAVByWG1OZnaCuCJpxeL4HDuTfFuGU+xXNv9cOryPkNm39ylLwNuwyDbd+P/d5gg3OxZwMtnePKxiOSAMx75pl7zAZfGj3c7CImhMD9AVT80KWreqVPshANWdLbK5R4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750715129; c=relaxed/simple;
	bh=9XxdQ/XPAqrm9vKv6xM+w8niEpa7fTE/kBK5nuVrQVY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=K2G1JChNOr2akjOkAOhKIoFoasIj8J8FM7wZl97qceyp/zUpAUeOaFSUDSvCnHyQN8hldEZoca4K2hvGg7Ku7e4e07v+deIlaU6tXkIgcSbBSqjegySZJMTIvJoyGhvfes7ZGXn3cpevij4yrRTb7moF3mTRI2YNxzBWeGGVLuE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=gOFJDHcj; arc=fail smtp.client-ip=40.107.96.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="gOFJDHcj"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KMWN370REFygtzGcBxkMOMya0dHyAQywdOAIt+Z/wikVho2Ov9dp0yowwLHwPxFZPz0HRttJjykSvfoJJT/Z89i+W/vpoMsb1viSgp4TPMvxw5kB/laWJj4WRNGTCcnj58sgHTgGHjDthGGiYYtucMj/DYaq2OhQD3c2W124+GeV2msBqbHINwZXn14efRBbVjPD+qTRFN7iWwrgkUmmQYFsHZukUEVctr+1Pa3iQawACtKjJ27jKTMT+TheTrqjQ3Dvn+dXtwx44wAkbVowvAgGpQ9SUno3yp3/gCeLgASCFT4V23NG3H6ApvE0Rg+OMUgvRYdIneB4EAdctjibUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9XxdQ/XPAqrm9vKv6xM+w8niEpa7fTE/kBK5nuVrQVY=;
 b=nbCF3aXUJR46l7Ir0GKDC+KBp/WWjuHxXcJgTYmdN/dFikc4EizKxwVPDSQbjaJTgKoR/Mo85a9Bv5BSA2xiB0I8JyJm5B2D1j0/Xd6CO/2kaKpIYiUPU2JpFHZR7748lQkPw0VMbFZhPgGVZY5aHvqBEb1YmpgwbaM9qpaJwEkLaV5qW1NbM/IpvF6FTsjkdFNylcYIltsIcDJir+MXJ8x3o3dQ35zckHeTTASOH+tZG3Jtw1dvHvbzipTjkJMEm5bnN08H9o6fSfXJv5SqJm03zIaqs1eEBLvXWL2E2lwQOmesbY3bTcxBGdQ8tsGmFdeYoSstB1YLVrcYVnzFzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9XxdQ/XPAqrm9vKv6xM+w8niEpa7fTE/kBK5nuVrQVY=;
 b=gOFJDHcjbXHXXAnb8PuzZfUsj8wyaiOdu6SHM0/nhL24PedP+QjYQxMsF0iRy6TikIay3dINe8bKyYqFqitLu7scBV0FrCROiVwqfuUzMljwK2iZthB2Hq6LpCm6HcQIH2MwtQr+PeUr6UJj7L8SjAe7ttLwTHWhDDkXqwBT49qzoCfAwBbf2/ZIwtULf/xQT9M4V08nmTxDtHN0kgjsKspOOrq9PyxirVcym1npR+8iI40+TeoG7hZFWtjrqYp4Hy7z1jeOSNGmd+zC269L0/paSp1E0+PQW/DlC/C+Q/ks8oGgMo2kVorI5d5sN2MUZPYgqW0tFKLm2z8gVTozBQ==
Received: from LV3PR12MB9404.namprd12.prod.outlook.com (2603:10b6:408:219::9)
 by SA1PR12MB8093.namprd12.prod.outlook.com (2603:10b6:806:335::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.23; Mon, 23 Jun
 2025 21:45:25 +0000
Received: from LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b]) by LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b%3]) with mapi id 15.20.8857.026; Mon, 23 Jun 2025
 21:45:25 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
CC: Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <chaitanyak@nvidia.com>, Kanchan Joshi
	<joshi.k@samsung.com>, Leon Romanovsky <leon@kernel.org>, Nitesh Shetty
	<nj.shetty@samsung.com>, Logan Gunthorpe <logang@deltatee.com>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: new DMA API conversion for nvme-pci v2
Thread-Topic: new DMA API conversion for nvme-pci v2
Thread-Index: AQHb5EjzDJufsSha2E2LyQ3tiujn77QRR60A
Date: Mon, 23 Jun 2025 21:45:24 +0000
Message-ID: <25a33178-fdd0-408b-a6fa-6cb6c7e7986e@nvidia.com>
References: <20250623141259.76767-1-hch@lst.de>
In-Reply-To: <20250623141259.76767-1-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9404:EE_|SA1PR12MB8093:EE_
x-ms-office365-filtering-correlation-id: 2ae5b764-cf66-4d9f-21e9-08ddb29f4301
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|366016|7416014|1800799024|10070799003|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?bkN4aXZsVmpiNDM3M0JIKzNQaGV6YllCYXB6ZWUyd2Zla3YwWFJsZ3lWQ0JY?=
 =?utf-8?B?OUcrTlQ2dnhlM2dvbHQxY1VRWUVPWXhJdVhvMTZXVzZCNGplU2VzMUxFWThC?=
 =?utf-8?B?ODlGVVI3Yi80NDgveUdmRVhhKzhVNHRTYUZpa05sQlBFOTVDVnl5SHdHZmhu?=
 =?utf-8?B?MXNnZlE5Z0V3Q1hkZHNMamM5Nmdsdk1LVTRHQ3hWSSszcEIyTE5oRUIvaEdN?=
 =?utf-8?B?QUhKMHJSZ3NZSm5xNU0xamg1QmVXeHJWOU5NSGdacjZLZUpxUXNIUWtXUEVr?=
 =?utf-8?B?OUZZaGE3cHpmTkVLNktGYWxKTDVCQkRnT2hXN3d5QzFETHB6TnI4MGxlR2gw?=
 =?utf-8?B?UjZLS2VDWHA2cUxkOWZkaXczSFY5SkVEWFBqMnlZN09RWDBVMFQ5Z1VEZmc3?=
 =?utf-8?B?aldKUG9MMzBmeUxsbXgvUHlicElTS05QcUh1a3plOU5pczk0YzI4Zyt1bTFB?=
 =?utf-8?B?RDAxcUpmL3lCQWFSSlI1aDcrWTAySkYzYWU4eGI2NXFKSFVCcXR0RjdIWXBH?=
 =?utf-8?B?NE1FTnZmNXhzVUwrekNJakpta05XSmFQS1NZMllnSUQybTJDVWJKNTFuS29T?=
 =?utf-8?B?ei9sc0krK1hxTUhzaE1Sc2tZNkR5SXdDSnR5dWNjYXdSLzZ3MERKbzA4UHNj?=
 =?utf-8?B?Q3lzNlNhaUxwSXFNaTZueXE2a0lRVC81Z3BGUHY2a2hqQXA4U1dsWER6MU1G?=
 =?utf-8?B?Ty9XeVpFMFZzV3RpT2x6S24wbkNlSzRYdVBNcUhVYWMwWTVncTRuM1NLQWQw?=
 =?utf-8?B?MEUvYmUrTjlrempRZC9NS2tHdzZHdy9kbTgxTERYTWthVk5VZnh6VnBhbVJP?=
 =?utf-8?B?Y05PRTJ0Z1RQOHkwcml3a2lBQ2JSeFpueHJZVHVHckxxNHQwa2E4NmVaOUZC?=
 =?utf-8?B?YXg4bVlTZjk0d3dUMzgvVmtwSFQ3dit4UEFRSXNiVko1TGRoKzk0MHAwZ3Nz?=
 =?utf-8?B?UE9XdCtEbmk4V0xwNXFkckNTRkVEU1VpRlNUUUlWZ2VwMHBwR0F3T3FaWUxU?=
 =?utf-8?B?QndlRkZ3dG9YUU45blFzL0FzNmErMkhmNTJBSnh5NWlhVXQ1Qmh4dElKRmxB?=
 =?utf-8?B?dlhKTUxPekxJZmorWnNnc21xc0pzM041M2NYTFRSVm8zTlJsZE9Fck5wNlFI?=
 =?utf-8?B?dTAzZlZyR1RCcWRqRk5XWkQ3VlkyNGdKeUF0Yy9LQS92R0hvc0tMeDVOTG9Z?=
 =?utf-8?B?SkZYVFk4MW1xMWxvejNkOW5wUk9QL2ZzRjZENGJwTERndWJ0WktmNEZPM3Iz?=
 =?utf-8?B?ZTBIdjlZUitEYStMY2ZZRVgxQTl1Zm9jeHVRMk15RXI5UEs3SFdIYTRSOCs3?=
 =?utf-8?B?Nk1ZODlBVWFINHBzMk9DOFJvVmdTR1NMRE1CQmNQYUlMMGJRVWFxN2w4WCto?=
 =?utf-8?B?dldSb2FqeHNQNk8raytYcjJaUEI1aisvYXd6YkJXZVIyZ2Qxb2hTdGo2cHhs?=
 =?utf-8?B?VlFScjlzUlAwTXdkb0U5T0hRNTNWNk9SV2haeE00NWtJTFk4Wk51SlBudUVT?=
 =?utf-8?B?amxkTlY1WHNVWUNzdmlXZnhFT01pUWptRTBKZHRadXNNb1NyL3ZDWnpkbWsv?=
 =?utf-8?B?YnZHVHlqWko3NU9FUHFlU0FPSTJCSjNHaE1VaTFpK0xMaXRZd0lKMSszQ3ll?=
 =?utf-8?B?emtpMHFLcXFJYzVQRisyQkY1UWFOcXphZTk4MEpBTXBQSEd5VDRwZVFCNVNB?=
 =?utf-8?B?MzVFdktMaWtkY3RVVHVVeWc4TjRiZWpzdDE0ZU9DbktaMlh3angyZFp0dkxC?=
 =?utf-8?B?VWdjWGw3M3Q1Rzl1bGJ3czZTNTV0YTk3Qm55VVRRVTFCc214YVZseWZhOU5D?=
 =?utf-8?B?S2ZVRjQrT21DUDBUK0tWci9GU3o2Sys0eUVqUEEvZWFjbSt2enpMclN5WGtu?=
 =?utf-8?B?V2dXS2ZsVDZLSU5HNjJ1Uzl5RkgwVjQ3YVFRK3BpSkp2ajFDSU0zTGI0Tmpi?=
 =?utf-8?B?MVFSc09zeUQvYlIxRnh2SWttcHh1a0lwdlk1YS8vRUdaRFFNL0Jra3FneTNL?=
 =?utf-8?Q?cX8CId1J7p4XtJXNh9PN8YTG4g5QKU=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9404.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(7416014)(1800799024)(10070799003)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?bElxU2JDb3ZuVnM5NzFVRjdVQXJmUFVva3FkQ3dOMW9YaVhuRnVwVTdyNFVX?=
 =?utf-8?B?WkZuWlkwNXlnQWlqdmh4d3lQNC9TQ1QyaGd4d3NER3o2SVdwbWxUcVU1TXlz?=
 =?utf-8?B?R0dZMmJ0REc3UzZiT3RHSk96dzhibnJqR3VRdW1SZ2YycDR0UDcveG9qU2ln?=
 =?utf-8?B?L1RTNVFBWVZXS0Ivak84dVdyZ3B0TFR5N2ZPbHk2NjI5OEoyeS9RWjFnRnpk?=
 =?utf-8?B?SEw0OHplZ3F5SXRKLzZpWUh0dzBtLytnRm85UW95SU15a3RneGh5Uy91d1ht?=
 =?utf-8?B?UExaNlN2cVRya0lrSVhLVWoxVk10R29rWnBmZll6a0hPdXJDSFBmQ1NoUUFT?=
 =?utf-8?B?NCtkRVVNWDkrWjhGN2xiZDJDVEtsZ0liQVIwVkFrTjQ5MWZKbkpxOFBzT1Z5?=
 =?utf-8?B?UlpFUUxsaGF3RlhKd2pTd0pPTlBDall6eWRmVU5yZlB4MU9qeCsya0tDRjBC?=
 =?utf-8?B?TTB2bnpyM0lSU1BJY3hWK1crM2wyNVNLL3M3Z3ZtbGFIOUt4dWNoT1lhcTM4?=
 =?utf-8?B?Y3ArQm9vNnh1QXo2RTdlcjRlVWdpem9veW4xOTFGU1FRY29RajFNOGtGcmRm?=
 =?utf-8?B?cFNMUlZJZHpGMVlnQXRJSHBKZ1lCZ2I4WTc1ZHFVMm1iMW9KVDNCUThHT0kr?=
 =?utf-8?B?OFRmSzhTWlJLbzhLMElCZ1lsTDJKd1hvRG5UWFNrR2M4djhkZUFrN0JhZFR3?=
 =?utf-8?B?dWdrQnFBOHZ4UE0xSkplbnZOVUtocnE4dUJBa1I0RHZUYVAwbGYxeUZPQ1Ey?=
 =?utf-8?B?ZDFCM0picDBNOGFERmpzRTlFNFlYQU5vREVWMlBPNXRaV3B4cU4vSXlRajBV?=
 =?utf-8?B?UkJNcGlOZHhuZE1UVzN3M2ZXdEJSSFN4aWtPNFdSc2pqZW8rdjZ6OXB3ZFNR?=
 =?utf-8?B?bitseWppRnVEeGdvRnc5VDMyeElsemdTYU5rNFd5N04zN3laVTQ5N0NlZWtx?=
 =?utf-8?B?aGIvdTR0ajRnYUJubDVESHZlSGdPVGhiTXVCa1hidlBHN2R4SjNIYTVSeCt4?=
 =?utf-8?B?OHFZTVlYdmlPSGZUNUJMUUJWM1JTRDJtdlp6TjkxcFcrZ2JmTTFwR05HZWEx?=
 =?utf-8?B?M2J4aE03VGxWVnRpVjhqVWl0ZWRYa2lZUkdQdTVTb3pxSVBvSUJzc013bVZX?=
 =?utf-8?B?YzNSaWFGQnZPVVgvdEN6NkUycHNlV3JRcUF5Q1NrY240c1FDVEtxdnFlalBq?=
 =?utf-8?B?M2JhSEVDU0JHTEtEUEllZ1dRNjY0QW16cWZhRkVmZXZTS05ZSGFWd2E3enRO?=
 =?utf-8?B?S0hyQ0d1M3NreUpnNUozM1pDRlViMlk1ZHVrTzZua0sxc3RTUldKVFplWTBs?=
 =?utf-8?B?VTdrZEJJaFNzKzUrMHpneEJnMVFhQllUUVVpMktQeXY1Q3NVcFFhemFzZGFW?=
 =?utf-8?B?QlZGWTA5cDA2V1NxV0tpUnYxK0RKRVNlcXd5d2VzVHl3NzZ5R1BlRWlUU0Rt?=
 =?utf-8?B?am52S05DYjlSZUhNM0ZUWHRuN3hMRHNYMjFwK1lhZ1ppY0dRbVA3M3FiRmll?=
 =?utf-8?B?SHFSaVZBUS9ueG40clBXMnBOanRTWmhXOWNNZzVtOWMxRHo1K2NVS3RIR1V5?=
 =?utf-8?B?enR5SlQrdHNaNWpCTnYvcGV6MVNTenh5YXJibnZxRVdRZldhR1l2clVNNW5o?=
 =?utf-8?B?MW44bXBDZkFyYzhOZlR0SEhtQnQ4ajc5c3ExMXd1MjNYdGlyZlhiVTBvYWVY?=
 =?utf-8?B?bE54RTZSc0FFN3BXQzZDYW1LcHYzZHdjTnNJTUdhVTVJczlDZ21RTFo3ZUE4?=
 =?utf-8?B?eWREdThLOXRCR25uVnJDRk9ITVpEK3NWa0dLK3NPb1V4TEptUkhwa05QVFVG?=
 =?utf-8?B?VlYzSk5BcHRzeUMwTGE3QmZFVUUydlo3a1RubDM2MXZlUnhseDV0eGgrVE4v?=
 =?utf-8?B?clB2VlREcTNQUWNzWWpVYnhUa014dU8wR3VscVYvTHJkNy85b2tNOXV2aTh0?=
 =?utf-8?B?ay9aU0tYS0xjRmVaaUtpelVzN2ozdVEzRDlncFZBMkJtZloyV0lhY2VDS2xo?=
 =?utf-8?B?WENGeU1Wb3VRd1VOdjVMd3ZoZWRBMXBnZS9nZUlKNGxHUHNFREFoY2pCU1ZR?=
 =?utf-8?B?MkhSSDBOYmtIWTRua2lsVnI1OGRjVGpITWZOR0N3K2hFRHYxZjIwMFVsYTFq?=
 =?utf-8?B?Vmx2SjNLYjFsQkFud0U4R3FTZTkzYXJIOUdZNThQVkJLdjVwaC80QjhyWS80?=
 =?utf-8?Q?Gf+ZVpIObcY7Xhk+4jHVjEuA0nwM5qvEtah6k1jr/AlI?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <0251EA23B32A9F4C96202B34B6EE3962@namprd12.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ae5b764-cf66-4d9f-21e9-08ddb29f4301
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jun 2025 21:45:24.9746
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2gov0N5teDanXSFW0wPVNuclQuiD7hB/E1JfEimskzaQUKnIQBDXwLoEUUormpjBG+FGYB6/vflWt8V7brFEBg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8093

T24gNi8yMy8yNSAwNzoxMiwgQ2hyaXN0b3BoIEhlbGx3aWcgd3JvdGU6DQo+IEhpIGFsbCwNCj4N
Cj4gdGhpcyBzZXJpZXMgY29udmVydHMgdGhlIG52bWUtcGNpIGRyaXZlciB0byB0aGUgbmV3IElP
VkEtYmFzZWQgRE1BIEFQSQ0KPiBmb3IgdGhlIGRhdGEgcGF0aC4NCj4NCj4gQ2hhbmNlcyBzaW5j
ZSB2MToNCj4gICAtIG1pbm9yIGNsZWFudXBzIHRvIHRoZSBibG9jayBkbWEgbWFwcGluZyBoZWxw
ZXJzDQo+ICAgLSBmaXggdGhlIG1ldGFkYXRhIFNHTCBzdXBwb3J0ZWQgY2hlY2sgZm9yIGJpc2Vj
dGFiaWxpdHkNCj4gICAtIGZpeCBTR0wgdGhyZXNob2xkIGNoZWNrDQo+ICAgLSBmaXgvc2ltcGxp
ZnkgbWV0YWRhdGEgU0dMIGZvcmNlIGNoZWNrcw0KPg0KPiBEaWZmc3RhdDoNCj4gICBibG9jay9i
aW8taW50ZWdyaXR5LmMgICAgICB8ICAgIDMNCj4gICBibG9jay9iaW8uYyAgICAgICAgICAgICAg
ICB8ICAgMjAgLQ0KPiAgIGJsb2NrL2Jsay1tcS1kbWEuYyAgICAgICAgIHwgIDE2MSArKysrKysr
KysrKw0KPiAgIGRyaXZlcnMvbnZtZS9ob3N0L3BjaS5jICAgIHwgIDYxNSArKysrKysrKysrKysr
KysrKysrKysrKysrLS0tLS0tLS0tLS0tLS0tLS0tLS0NCj4gICBpbmNsdWRlL2xpbnV4L2Jsay1t
cS1kbWEuaCB8ICAgNjMgKysrKw0KPiAgIGluY2x1ZGUvbGludXgvYmxrX3R5cGVzLmggIHwgICAg
Mg0KPiAgIDYgZmlsZXMgY2hhbmdlZCwgNTk3IGluc2VydGlvbnMoKyksIDI2NyBkZWxldGlvbnMo
LSkNCg0KSSdsbCBoYXZlIHRoaXMgdGVzdGVkIGFuZCByZXZpZXdlZCBieSB0b21vcnJvdyBlbmQg
b2YgbXkgZGF5IG9uIG15IEgvVyANCnNldHVwLg0KR2VudGxlIHJlcXVlc3QsIHBsZWFzZSB3YWl0
IHRpbGwgdG9tb3Jyb3cgZW5kIG9mIHRoZSBkYXkgYmVmb3JlIGFwcGx5aW5nLg0KDQotY2sNCg0K
DQo=
