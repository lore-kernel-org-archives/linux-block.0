Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2041.outbound.protection.outlook.com [40.107.237.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8635523372C;
	Tue, 15 Apr 2025 15:38:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744731504; cv=fail; b=o8vHq9ygVQ4c+nuU9HyZtVKLMCl7ChMw/f3MTFB/ALUGeJkcUbIUmDW97Uu7en4Xk2TIITBO3JhflCYt8rE+YlndJ2hRbPCEwsC728FbCV5oumhO9ma416H8WS1ijaesKFt6FRifk+jwVfxneuMJh4H/d7jGWqDLjAE40G7j56Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744731504; c=relaxed/simple;
	bh=vIIAMNP+YLsXsYclih9QX+b3gc5XdS7dsA81XeclCyo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=EIqyaDr2Svax/6+LLnknjKo8b8zV4ywMPG+zkzJkvL2DHlGwRc8Nvtm6FfYtVlrUs2P7jlC4m6qcoB0qsR0ix07Yw3C4EQpfZPdN3t/JqnSoUtNrN26+Groe7YgaWW9GM8Jt1i3lWCtnohq9tV1k8QgmW1o6d+u0tJP7bT79aXs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=CT154kCc; arc=fail smtp.client-ip=40.107.237.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="CT154kCc"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wPaBNcfItpeL/JTlMPtruwAdccazpJF8ShFrvMK6UHi6aXMaSCpNQSEC7FJHDAOQPwn01+bvWXAONu1Nr2f766lVNIhSKzCG2XyGKJ+ClKLzpsClYVOOIRUOMPJCelr3ur0ywUdva1n8BkjoBakBZjSt6wIWAaILXmWkQE+xry8nmA+1GPRVdOh4k8y9UsfEOFlLhCF3USITMOWCPetix/9ZEechdcaqzNfH6bnV7IY6D7D1IZXQ/2Vskb3lllJjDD2TJWw2mqEirS7j2jUy6LFjlFRjJG6b5hzSDxb9jt6vHLCKhD+eMEpk6iFYQDqkN1E7JK/qdMYpfnbRHA1VRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vIIAMNP+YLsXsYclih9QX+b3gc5XdS7dsA81XeclCyo=;
 b=EqC8ikcXHI/mYYRC4zgLhGzSDAUOKKHfvvNeV0NaRkPuQPPMElmMPK3PySIzLMZxgDIcLqbgl8EYKS4rcY/tNt9VT1jzvb1hE7z2g6UiRviyKFR4FJh2pnewvU1KqYUQe2bNG9GxEraQOSD8mlYAtgeOUdQPAHoIjmYtDNbRw+QvfebOFKZSCgGQ3UzGITz7nJ8pdTZEkCA2Pjqyi+7ekf3Ud2FiQnqkLOWsx194JZj8xcMuevLQQx2KD/wiGgonCtaVsrDgd53wmlz41Iy1hkFzj8pVxwntVq+YGWAPLNX7+NXKzP1M1jNgboxvpxX4CxjkOwmf2O7QOEUMU8KeFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vIIAMNP+YLsXsYclih9QX+b3gc5XdS7dsA81XeclCyo=;
 b=CT154kCcgpaqlLs/l5MWnH/X+peePPqxeIpoFdc0w8iofPA1DcWd2fNdCBLtW9Z0mRV/M+AFhfOXgYIUpR9TBVinYxgNcZjZXWaPxYmU521Z6YPqJhPiTEl940YT1kmXANom/PCN0ojt2O4n3lzYSaodY4ntVKPaZPkmvsgIdppGF55Yy5kcUecCucgHv81sPfly5An1Rb1SGZaQXtSuOcPMpVEr/uNsvVcx0kygus7i/zPGwJgrpeX8fLsTwEK7jEgnwGO29s4/KsyM5O1PFPIhtGqTMqz5TSlX12t1grBzMQbSRDxR26lDGy/mgQP0RTY5wb+HYTwBJzmiP1Y1gg==
Received: from LV3PR12MB9404.namprd12.prod.outlook.com (2603:10b6:408:219::9)
 by DS7PR12MB8249.namprd12.prod.outlook.com (2603:10b6:8:ea::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.34; Tue, 15 Apr
 2025 15:38:17 +0000
Received: from LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b]) by LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b%5]) with mapi id 15.20.8632.025; Tue, 15 Apr 2025
 15:38:17 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Yunlong Xing <yunlong.xing@unisoc.com>, "axboe@kernel.dk"
	<axboe@kernel.dk>, "linux-block@vger.kernel.org"
	<linux-block@vger.kernel.org>, "bvanassche@acm.org" <bvanassche@acm.org>,
	"hch@lst.de" <hch@lst.de>
CC: "niuzhiguo84@gmail.com" <niuzhiguo84@gmail.com>, "yunlongxing23@gmail.com"
	<yunlongxing23@gmail.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "hao_hao.wang@unisoc.com"
	<hao_hao.wang@unisoc.com>
Subject: Re: [PATCH V3] loop: aio inherit the ioprio of original request
Thread-Topic: [PATCH V3] loop: aio inherit the ioprio of original request
Thread-Index: AQHbrcm4S5cLIUPrLUCSnXX3J1EwibOk3TwA
Date: Tue, 15 Apr 2025 15:38:17 +0000
Message-ID: <5b8bf0e6-d09b-4abd-b212-f290894bfe5a@nvidia.com>
References: <20250415054436.512823-1-yunlong.xing@unisoc.com>
In-Reply-To: <20250415054436.512823-1-yunlong.xing@unisoc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9404:EE_|DS7PR12MB8249:EE_
x-ms-office365-filtering-correlation-id: cc86d7d5-2848-4a1b-3f88-08dd7c338af9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|10070799003|1800799024|366016|38070700018|7053199007;
x-microsoft-antispam-message-info:
 =?utf-8?B?RlBoKytMUkZtYjdiWXg4ZkxIN2ttOGV6YWJVMjgvbEF0Q3JIRzhsVHoyeUpO?=
 =?utf-8?B?N0c1dDdGa0Y2a3M2UWZGbW14NVh2NThhK0tUYWNqdjlyK1pRN3V4cjVuT3N1?=
 =?utf-8?B?VkJaTG14dU5XN091ZEJKamRoWWJHcTUyTitJYzhBQ0h6V3lQUGVBdUQyamNj?=
 =?utf-8?B?VWhEOFBCZXBEa2FWUG92dENzbitTQ0tWZHNzYUk1WEd5UEx0czFJUnBLUm1Y?=
 =?utf-8?B?VFVpeGdsVm5xQVgxTW9uWlBBeUdtOVhVMHFYVENHMGxya0p5dG5ZUmY3TGIr?=
 =?utf-8?B?Q1F4WWU5aGl6SmRSc0JZWHJnMi9NSEF4MUU0NGpHR2tKRVRaR2hwZENPZytE?=
 =?utf-8?B?Tzg5M3I2N0Nkb3ZScFFRdWdOS2tZWDVpWUVUTGt2Nlo3OUQ4T21PeFFNdEx5?=
 =?utf-8?B?V1JTdEF2RkZiUHZvS2VUR0pWYXJIM1Jlcnl6Wmx0NVdFUmFPd0hOcjd6bmJO?=
 =?utf-8?B?elZ0NDBEa1prM25WU0MzWUdmZHhFeWhPbmtQNFllWStWeTVETUlBUjluK2Fz?=
 =?utf-8?B?SlYwa0ZDQmk0RkNmNnhQRGVoQTFOZnZTVWt1aHNRODZWSVI0cENTb1JFditt?=
 =?utf-8?B?RGxVeTEyUGFkVzNJNFFPRjdEMy9ndzh5ZVEwMXAwUFU5ZW5zZG0vNHU1a2l0?=
 =?utf-8?B?dDl2Qms3SjdJbnZIM0dEUjF3YlR1L1RISWJBN3FBYm91Y3JFeDNkMEttUHI2?=
 =?utf-8?B?SytEdWNoWXJ4L3BiYkNwUjRMUzZaUDkwS2l6cWphMlJTZ2lxa0o2NnBFV3Z6?=
 =?utf-8?B?TmI5MmE2elFETUJrZGdlUDY0MmJPNGtSbVNqTG4reUFWMnhXdUZzOEJnZ0t6?=
 =?utf-8?B?ZHR1dzBpK3pCRUNlVXJaUUxwMnZQYkRGbXVWRU9tZnZoQ09EbHp4c005TnJJ?=
 =?utf-8?B?VUtGNzFvNXZrdGdGNWdXUW04Mzd0anNTWElHcUZkZjc4K3h3YUtvMGxPRkxE?=
 =?utf-8?B?bWd2UmJvS0o4S0ZoZ3AwbExaSkg4YmpNSWI4Q210NlpndVZEdVpRbXlsOE11?=
 =?utf-8?B?WmY4a3BBSVczaGI1b291d3d4SVh2ajBxam1VZzZYOFFXZU1YS0hsTENvdFA5?=
 =?utf-8?B?N2ZUeVNqK3pha3JxTkNGWkN6NTNGU2Q1NnhxV1ArTlVhYTNteFdHMENKcXRQ?=
 =?utf-8?B?Zy9sc2ZKODFSRVNEMVVkUjRuNzRHZHZjampJRXRDd0FyOHd4TTZYRVpzQzln?=
 =?utf-8?B?OTZ3MFFKanl5Qm4wbmR2S3pUQTA0TzRVTkZuRWFQT3ljTnBJeE04NmRPcWFM?=
 =?utf-8?B?TjdUdWtaM0p6OXkvcEZ0Q1BCaHdyM2QvTXBoSHBhS0U2bkZhaG1UZVhBVDNo?=
 =?utf-8?B?VlV6MzRCeGRhUEREaUwydFdiWWluR2c4T0xtRUZkVGtwS0diRWU5blRDNk0v?=
 =?utf-8?B?Y0lFb2g0bEZQTzN1VmJyRThVVDRaMGwyREJGcHczdFF3NTVGSnhHOGc5WEk2?=
 =?utf-8?B?S29ValE5MGhzV0c2QUZFZzFPN09BVHBWVnNhTGlEMlE5RVJzZGM4aVVESzRn?=
 =?utf-8?B?amVJVTdTMzNTOU5UczZOOTRKYWh6Q0NrVW9IZXpyNC8wYnh0Zmd0a3F5aVdT?=
 =?utf-8?B?bUliYlNKcGc5VVhzWjFqbmMxV2t1V2Y5TFJwdTlDakdoaXRtMHBWUk1vVGFj?=
 =?utf-8?B?S01IZXlicUtqazVSQUFRSWhHN0lqMm1vaGdtaFp0QWxzS1A1bTFBSmJTUld1?=
 =?utf-8?B?ZytoSDRMQkZYVjBRVHVUN005TDlFWHM3UjJ3VVdHaEFPc1N3eFM1akFYOWk1?=
 =?utf-8?B?SklTU0ZCeEMzaG5rNmVBYnlvbjdSNEVFZGxCVmtWU3JSOWpSMUhNYjlVS3Yy?=
 =?utf-8?B?bk5VOVlBWDJnczYvVitSK2orNHZMbkhUdXd4R1Y4anlNY0k4U2h5YzR1RjNG?=
 =?utf-8?B?UVg3UzJUdThZdXAyajZsTG51S1IvWHdMNTFIcjhua0RPMUV1TXdxTUlvc3hM?=
 =?utf-8?B?enEvcUhPdWRmZE9maFhIR1FuYXA0Zk9SSUFiNEZnN2NVMU1IT3d5NzgrTWFS?=
 =?utf-8?B?SGxKRExjRERRPT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9404.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(10070799003)(1800799024)(366016)(38070700018)(7053199007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Q1BlUWE5L2VyV0FycTM0UnkyRVBHN29odlFtcW9Qa0NjRU5TMS9OWHV0R09q?=
 =?utf-8?B?YkE5OXE1L0R1OUxHb1U3Zy9nOXZ2cWF1czQ2TWhXZ1RoTTlCUXhzNi8wTmhv?=
 =?utf-8?B?a0gzcTl1MXZSUnI1VDY3SzJiL1ZLQjJlQnk0bmttRS8wS2tZUzlWZTdxK3Uy?=
 =?utf-8?B?VzNua1FoT0hScjhNSzg3cVIxS3djTEhmYlZYTURVKzdmUW90bVZQamI4a0JE?=
 =?utf-8?B?WklkeEdvV0JRL0R5bTIyNVRnTnh2Smk5QUg1SGUrcTNjTHdWTTRtaGJ6ODFP?=
 =?utf-8?B?YkJrazg1cFdKRlRPLzVQbGc3YmJtMDNuYUd1c0xnUlF4UG9EL1VPL2hIaFIz?=
 =?utf-8?B?K0FpOHlzdVI2TTdZZG1RTWpXZG52dHZhVm42WXdoYm5Wc2lZbnl3bEVHd0p6?=
 =?utf-8?B?Z1I5T2ZKanB5dHA3RHJ6MFNaY3JqZ1FqSEZGNm1XeVVIWVVubExSMTJCZXhD?=
 =?utf-8?B?ajZxR3plS1FoMy9zaHBMV0tBWDI1ZUpPY21CUTh4S2RnZUplTThOcEJrYzUx?=
 =?utf-8?B?eTBHMEI0WGxxRGZ4ZTlhRjlDNTBrekNWRVdxc1dZSjhXOU12cFltWWlDQVVN?=
 =?utf-8?B?OFlHcWlaSG5CQStrNlEwUUZsYkpCMU5PWHRPTjVxYmZHeWxRLzNKcmRqL1lB?=
 =?utf-8?B?c29ZYmtuZmZ5djRaN0dRZHdrNVFFRzQ5dkIwblNXaW82azhIOGFSMHdrVnk4?=
 =?utf-8?B?ZnQ0ODdUOEcwVHR2SlFaVi9jczRVTWMwM1lOVkdoMmsrcE1GVWFrbERuT2cy?=
 =?utf-8?B?SzlDS09xdUdweFBsUno0VVBreEdMVEM4R2E5cFdhWW5PTXRGRXVzdWJYZEtO?=
 =?utf-8?B?c2JKR28vQWZtYWQ2NTRIKzNsRHBLRUN5L0taa25HbEFzMlkxaWxkaHErM2Ew?=
 =?utf-8?B?RldtdnhTUXVYcUQ0QWlUMDlsVk81ampKdUFPdHJTUzNsUXJlOVVWL05kWlJt?=
 =?utf-8?B?UzJ3dkJtZFBPMFkya2QvL0kxMlhjNUExeWowK0hURVJFYjVEMUdjOHFwWS9O?=
 =?utf-8?B?UDRzaE4wQkVvaWJwZGFkSHVGbTJzV1oreHR0NkRtRjdBNjI4UXBjSlN6L2sw?=
 =?utf-8?B?MTJvT0NneTQwOGMvR2dHcDhHNnd2bUFFKzNGbUR3T2lVbEhGZWQxUUtqVloz?=
 =?utf-8?B?L3VNbmticTNlU2VUcVkyQTM1bXVjQTZ2RHBnbmYzQTU1NmFLblYyaGNYRWk5?=
 =?utf-8?B?RHRnM29zT3htb09wV3NTSW4xTDNtcm4zNlhadWQ1VVRLREgza2V4TlltVVEz?=
 =?utf-8?B?QkMwZFp2YUtoUHJQVjhBejgzVnhMVThrT1BHclNkUTNkdkhIQXRrMFZaMTFP?=
 =?utf-8?B?ZjVUZTVMdW1YT21hZTBnKzd2bzQ0a0hJa3RSU2JwZHd1cTJZVjlLSzFnMU5q?=
 =?utf-8?B?Rk0zNC85OFJVOGZ4NEFkaGk2U0NhdmtsdnN1VFg2Sks1QnVBQ1hIM0FlL2FE?=
 =?utf-8?B?M21Xd0YxanFhMFFYK1JyNHA0RVhSNFh4MkhIc1ZTbXJqTTlyNHVtZXQwVVRp?=
 =?utf-8?B?Q0dTNzVLWGF1V0hwQUVoZUJISVpna3dTeE40ZEJ2U2hmOVdVR21tSEJ1SW5Q?=
 =?utf-8?B?WWZkS0p6TDNhekhabG01UDUzOHVETDc1akNEYmlQUjZaYzIyOEs2Slh3dmJl?=
 =?utf-8?B?VEh6RG9uZktuWDNyT202VlBqWnAxcHJFNkhXUjFpOTdVYWp6WmR3OG44cDBm?=
 =?utf-8?B?bDhKTzJvMHhpZjlvb3d5d2VsNktnTUVaS3NNeDhidFV6M0ZKZ3k0b0YwSVBS?=
 =?utf-8?B?VlZER2tiMFdHdEdnMVM5cHlKY3VrL2lYZkZPRysyZnhqZmRuYUpycGN4Z3hH?=
 =?utf-8?B?SEFoRTBjZ3N2L3VtNlFSMkhOZDl2SHhjS0tRNzNoekJqQjJiQ1pUTktDL0VH?=
 =?utf-8?B?SkdTbUppZEdrV2s3VmdyRkZGakZvODlRaEVUcUZLOFBGSlZpTDRodUIxdjdQ?=
 =?utf-8?B?S1JXc3dpei9MNmRPYUxkeGxNS2xZa2ZPNTNzR0FiUDhLNThFeGpZVmM2RG5S?=
 =?utf-8?B?a2Ixd2VOYXRSZzdEbEsvQk9CV1hrS3NoWk5Jcy9kOWx3RUZnQkhVVkhHaFJn?=
 =?utf-8?B?TTZyNEltMmFRc0dhdGM0eW1RTWNITENKbS92WnpmUWR4N2ZhNjJJYjZkRVlr?=
 =?utf-8?B?ZzVlcnVNWmlLUy9NOUd4REcyWVpwVnFETC9BQzlqYlg2UE9iUTlDSzhJS2o5?=
 =?utf-8?Q?I36fqWrdzOZbBZZqqnMUN5mpRoG5VGo0ptOvMvJ7bcAA?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <72547D263D143A4CABA4C84320F8A0FE@namprd12.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: cc86d7d5-2848-4a1b-3f88-08dd7c338af9
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Apr 2025 15:38:17.2643
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: m6TkZr8Ad0yMuHibD1Pesfx7NoSW3Y5wdhBrvJi5oVQ6VH6lTA53NT6+m3fVUXxuQnp9Cq5iWc9Dn1RU5gavYg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8249

T24gNC8xNC8yNSAyMjo0NCwgWXVubG9uZyBYaW5nIHdyb3RlOg0KPiBTZXQgY21kLT5pb2NiLmtp
X2lvcHJpbyB0byB0aGUgaW9wcmlvIG9mIGxvb3AgZGV2aWNlJ3MgcmVxdWVzdC4NCj4gVGhlIHB1
cnBvc2UgaXMgdG8gaW5oZXJpdCB0aGUgb3JpZ2luYWwgcmVxdWVzdCBpb3ByaW8gaW4gdGhlIGFp
bw0KPiBmbG93Lg0KPg0KPiBTaWduZWQtb2ZmLWJ5OiBZdW5sb25nIFhpbmc8eXVubG9uZy54aW5n
QHVuaXNvYy5jb20+DQo+IFNpZ25lZC1vZmYtYnk6IFpoaWd1byBOaXU8emhpZ3VvLm5pdUB1bmlz
b2MuY29tPg0KPiBSZXZpZXdlZC1ieTogQ2hyaXN0b3BoIEhlbGx3aWc8aGNoQGxzdC5kZT4NCj4g
TGluazpodHRwczovL2xvcmUua2VybmVsLm9yZy9yLzIwMjUwNDE0MDMwMTU5LjUwMTE4MC0xLXl1
bmxvbmcueGluZ0B1bmlzb2MuY29tDQo+IFNpZ25lZC1vZmYtYnk6IEplbnMgQXhib2U8YXhib2VA
a2VybmVsLmRrPg0KDQoNCkxvb2tzIGdvb2QuDQoNClJldmlld2VkLWJ5OiBDaGFpdGFueWEgS3Vs
a2FybmkgPGtjaEBudmlkaWEuY29tPg0KDQotY2sNCg0KDQo=
