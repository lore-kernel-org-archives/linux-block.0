Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012050.outbound.protection.outlook.com [52.101.53.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B8C422A4E9
	for <linux-block@vger.kernel.org>; Sun, 15 Feb 2026 04:24:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771129499; cv=fail; b=pndH9nhrOtxjQLJ+KK+2SZZEz0ji0N9rs+aDq81d38+g4HyA9EJTD6elX7VQYrOqH26ozLynViwmygy283m7s6+NIU1awa6KZgRfYzuBM4ninRdqzK+a+yARCwwndZ9jo/rSOwRx7Ozm7culAcWmQcm8c8tznunDzdIWdKT8X3A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771129499; c=relaxed/simple;
	bh=Ftr1BkLuoDE7paZxe3dUW+38riykZzeP2XV2u0UWtt0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=J5V3hDSTFvCsdaJIzM6aK2Is3ThyTwUuHtk+9NvFcUW9IrOA9tfXwX6w9VqMy/YYFP1BQDinOSybcmi7el8BN9rwllwWWGwvytp9UP9GDOOXlw9iSf0Bog9SneBPzUtImiQQrfzWxSrAke8GI1B9hpXIarHGHwb4HTEa8FB1DFU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=gFjoftio; arc=fail smtp.client-ip=52.101.53.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="gFjoftio"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sF/bUzKZXAat9XwRMbmoEshf4MZAxVMGo9pOmLpmfPQqfii9BHoyte6uljLgiN377vmHyFxrNGN/oEChhbb9IzPEp02BKsaUi99fmO7FpTASUX22/D4yLHwGl71D58velnlwjglmkxu6jHT0pwC9irw2ammgJVFN3V+enzYeaEgJsArGe7CZsYRY1p3KvdAO2vYE/X1u/lO63RKWl7XJmisarLfyeyhgRqAZe2fqZvmgMkAK6wfOnhca6mOBoBRTI9e4+AAwWmP9ezcrTK+SFcOBRsIopmVeM3BbidyOAvNTIfeSmROsH9bK5t79By/aXXMQOvsRfKNYNCzBGWpUBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ftr1BkLuoDE7paZxe3dUW+38riykZzeP2XV2u0UWtt0=;
 b=cj153Knh3qKX/4XT6vOlr6qp9dzZ3NmpHSdI+I3B/D2nhTy05n//fe9qNMVDUyPmZqHt8T+GlEMTnIWbQsa62t00kXqCNifxKSRK+QMrvtyrvk5cUPU1UrWd8ttUiQgrTLg7EOEAbGpBESD02yrZtO5MSLUl1NgvCLzBgBiNFNi396lnoEvqM0dhq5BI0lyy3tH+YRUHuj4YZw1CGfXqC9btoCv7aWV7kqfs9FHOwXP1L9C1FK458LaToSAcUucmObv40pXfQJUsMQvCJwpCepm1RA5ikm5rKYCW3Q0C1qt5+nz9VDQljBPdusLQRdZAzscIeyPDFRR49TTPQ7m0YQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ftr1BkLuoDE7paZxe3dUW+38riykZzeP2XV2u0UWtt0=;
 b=gFjoftio/tr9lPT0/QWkdILZrVlyGyja269pJs84ptKMxS9ZGqsqHxzPn5cM4FIR8D/YlHhdj7bX1Mly+wtwYda7390jgwtJFo0pgVloQF62Unv4YkHXh5I7hLr1RZzbyGQbo78RPoqX3tUvyCvDKs1gUPyoMRhUowYuW4KAJeABBtbayuzmp1keHOC0gOPACAejnghy/UW2MUpewf+ARBJUWRSlyTXjXWtVh4qyEVSmm47pXpRxJloHFUC3cEeNG/y+3XgR06U8mz+kp76v6IZ5r+iQJ6afAZ1TIcegH814Aw1VbtkrKiV+R1cutrTcbbI6H3zn3RMWGfpLmfwcSw==
Received: from LV3PR12MB9404.namprd12.prod.outlook.com (2603:10b6:408:219::9)
 by DS0PR12MB6461.namprd12.prod.outlook.com (2603:10b6:8:c7::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.15; Sun, 15 Feb
 2026 04:24:51 +0000
Received: from LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::2109:679c:3b3e:b008]) by LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::2109:679c:3b3e:b008%6]) with mapi id 15.20.9611.013; Sun, 15 Feb 2026
 04:24:51 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Christoph Hellwig <hch@lst.de>, Chaitanya Kulkarni <chaitanyak@nvidia.com>
CC: "leon@kernel.org" <leon@kernel.org>, "axboe@kernel.dk" <axboe@kernel.dk>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH] block: fix partial IOVA mapping cleanup in
 blk_rq_dma_map_iova
Thread-Topic: [PATCH] block: fix partial IOVA mapping cleanup in
 blk_rq_dma_map_iova
Thread-Index: AQHcm5gI8K0VikFwAkWJaYRTPpq5L7V+2lCAgARUjAA=
Date: Sun, 15 Feb 2026 04:24:51 +0000
Message-ID: <5546b3c1-4c3c-420b-9aea-d87fa0c6d1dd@nvidia.com>
References: <20260211204944.23380-1-kch@nvidia.com>
 <20260212101711.GA8869@lst.de>
In-Reply-To: <20260212101711.GA8869@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9404:EE_|DS0PR12MB6461:EE_
x-ms-office365-filtering-correlation-id: b2869bc2-5ee4-4210-8669-08de6c4a298e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|10070799003|376014|1800799024|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?QmdOQ1V1d0NHYjA1SmdLaERXUUM3RUIxZVk5ZDh2MVdTVFZ1OVJaRCtuTW13?=
 =?utf-8?B?SVByNkdJNi9Qc3AyY0F4MzZxdnA4L3g3N1BhMk5SaStqMmxVcndyQUFSVW9W?=
 =?utf-8?B?TzVKbTF4cnhTUzdKbE1rNDI1WHJOWmNtQ042NkM1Yzc3NGNrcTYzOWZMU2J0?=
 =?utf-8?B?dUU4UjZsMkRDSzg3UHo1aFFJdmhodElYeUtPTCsxYkR0a3YvWktBQTgrSVZk?=
 =?utf-8?B?Z3ZxS011S1d6UnFBUHEwQS9Ba1dnMEFPUXAxQXM4M0Rsd3BabXoxeG1BdUR0?=
 =?utf-8?B?Qjh3SDhFbFNCb2JwK2I3QkxxbU0yQVB0b2hkNlhaNzNubUhwOXowZWVVdk1S?=
 =?utf-8?B?TzlFQ0o2eTRHKzRpN3p2Slc4V01IODJiTVVVZDVIcHlaMzEvR0pKdFdGR1pG?=
 =?utf-8?B?NG5WTTRCOUpnTWd6aWlvR3FvOEtvdVNOVVgrd04wRGtqeVh4T2ZSRHZVZmla?=
 =?utf-8?B?M01GMmtlcU1WY0lMcUxVbVgyTmhyUVRBSkVjMDQxMXpXNXZzT2QwVUdoRUFo?=
 =?utf-8?B?T2RhRWxSemhLS0RVdXRtczVwU2xDbnQxc1JQdUNzVExNWkEwbko4M1RTWWFy?=
 =?utf-8?B?ZU5SR3pNdkc4RjNUZVhGK0QwL0RCYzlHclFNYlN0cFJaekFTdm1GSm9oT3Q4?=
 =?utf-8?B?azhDand5NXNFUEx6R3dGZlV2Zi8wVnd1M3piSXRCSStIa0pyZUozMWpHUmw3?=
 =?utf-8?B?L09nUG5KU0ZrOThlY1Y2Qlk3UjNBS091M1ZPK210NzB4OFkrZXY0L0FZcGFV?=
 =?utf-8?B?Q2g3YnVLSzVPSEM2anhZUmNMTEdnZ0xVM2Q2Tmp5dmVHUXpLN0ZGcnlUQmx5?=
 =?utf-8?B?SUtCandaWk15NGNPa05YSlU0WnFnbWY1OEsxWktJVlpzdEVXclUzcG5oRWUr?=
 =?utf-8?B?R3hQTmpyREVOVnhUTlhleDJnR2tDSFYwRXBYZjdKUStXcXhtdDBkdDU1NFN1?=
 =?utf-8?B?OHd2OUVma2pTbHoySHpsYzRSd1lpVFVTNHNEa3hveEdnYVZ1VnVDeDdIRTQ3?=
 =?utf-8?B?V0REbjV0ZHpUUW92V2JoZVJNMG50QVpvUU9rSHZMTnczVC9rMnMvc3pyYnRI?=
 =?utf-8?B?VmptT25xQzNpMHRGT0JBanh6bG04V2txRktBQnlIWUM1UDJOSVhjNmxpWWl6?=
 =?utf-8?B?SHBQZUZtaGF4blNWbmxmUjllWmNPeDdaQ1pla244Wjk4Wkc1NUR1Mk9CZmdZ?=
 =?utf-8?B?MVpyZ25LeFB4OE9xZVlEc1BoZkNzMk1rWFZFOFYzbHlrYU43czZKcytMQmVJ?=
 =?utf-8?B?dG9FNzhqM3FESE52OS9EWUFUeS9CdVlHbjNwWnhwbktoWVNscnF6dXZpTjFT?=
 =?utf-8?B?Y3N4RklrRVlnS2RsZkVQcU9FQkF1V1kzVFZvMTg4U1k1Kzh1THRUZS9FS2ln?=
 =?utf-8?B?UVg0NVBOT1dVMVFxYmZKNGlXdUFhNTV6RFFiOERSR1lGSTUwWDZCTE10ejhO?=
 =?utf-8?B?WEdqTzk1dWNxejVva0UxL1ZvU09lRDhmWWc0ZFJLdHV2K1VsbUM0UU0zZHVv?=
 =?utf-8?B?dVdqZ2JkSDVGVXRLaUJBN21ZQ2l0MVJiU0U0bE5hV3ZKTE1MQTVNUURuT0JZ?=
 =?utf-8?B?TUdiRERwYU80Tk8xOHBva0srV2FRK1A2b1NDTkVScWNsdm15L2prYlZ1V1Jj?=
 =?utf-8?B?cFVyM1Q0QkR3RDRVTkFUc0pyRmVtaFhNcHVBSkNGWmsyanJVWTJ0Z3RzZk5p?=
 =?utf-8?B?akhOZnltRjVSRWgvQ0FSQ1RNcjJBSmRFbitKWFlhdzI0ZTB0V0dYWUovQ25v?=
 =?utf-8?B?UHhTUyt2TXQycVVTWWh6dVFNam5GWGNDUklQR0RDbVpLak53RW5LQzlab2Nl?=
 =?utf-8?B?bUl3NmFUUjVrS3lrTUpaNVpJUHpmVGF6S2EwT1Vpb1B4eEFhdUYxMFZiMlFl?=
 =?utf-8?B?UzdUdjgrdWVOc3RUUW1vSWFWMFZodVNqM0llWlVkY2Q0c21PNlV1YzVabEw5?=
 =?utf-8?B?NFlZdEVjaE1VbWZFZ1F0bHlnOUtWd254YXVla2pkajVIbE1BOWNST3BMQkFm?=
 =?utf-8?B?UnRINFc3NnErRG1vd1NVamFJbHhRTkNXLzZUbWM3dFBqWlNyTDhwYTFLVnlq?=
 =?utf-8?B?VmF1Wi9zUElkR1ZQMUdKSTVuQW9GbmovK0gwdkw4SHhZdGJ0ZlJiRjNkYXdL?=
 =?utf-8?B?RVFCaDlYWXNuUXh3bVdUdEhJaXRyamV1THd5KzQxTnFZSzE4UjRzZ01ZVHZs?=
 =?utf-8?Q?yD+H287z8k0MVmgtwKPxuaE=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9404.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(10070799003)(376014)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?ZlZNdWVtSURqQzVRQWJPZHg2Q2MyTExDVmdZc05PQzVCMWtQVVlVOUdUQnFU?=
 =?utf-8?B?YUU0dGI0S1pZMHhKWXh6dVJseHdVeGFlZG8xd2VLb3owbnRHQXBnWXdtamN3?=
 =?utf-8?B?c0c5YUdQQ2xmaUE3UU8rc2p6YVZmL0hIdzc1dnRwWitHa0tQckNPcGtKTmVu?=
 =?utf-8?B?Zm1rWGVzNlB0SktUUmM1dVd5SmZQSlZlelNTdGYzbEhsc2szajhpUWNYM1dT?=
 =?utf-8?B?dTcydXZ0L28xcGFIdTFOak5HSzJNU2hTekkrRUtpd2Zicm1aTTk1VzZzUGpl?=
 =?utf-8?B?WVp1MnBrSXVqQ2ZxVG9WdS85N05TdVJwNVZJQ0Yrb083Vm1TM3EwS2RUcEhH?=
 =?utf-8?B?dXJ1TlV4bkhrb1pmVkhIaEFjR1R5N1FoY2wzMFFvWkI1ZkJzNFUwbGliRUFr?=
 =?utf-8?B?UDBPUkU5THQyV0VuWUp2YWZaNmxTSy9OMnB2WXZ6ZVFrNDYyMVpPa2w4dXIv?=
 =?utf-8?B?Tm9HZ3dzZlZjdVBQallVSklSZHNFREpWTmVINnc5OU1SRm1nSkhhM2dPQlFX?=
 =?utf-8?B?NFJqUFF6ckxxU3hMUG4xV3ZpU01RZW9jbE5KTE9pOUREK3VCbjRMWlU3S3ZF?=
 =?utf-8?B?V3BnYVUzTFdZYjE1d0RacGtqUEpEMDFzQzVxVm5VdUtrc0I3Tk0yZzU0czNu?=
 =?utf-8?B?bytIbU9sZmRwdUs1WGRsMDl2bmZySXNuRnBxODRneDQ5Rjh3MmpOU01LYWNN?=
 =?utf-8?B?ZE9Pa3JjeUJYNFFXYzliNlZXRW5RQk5aS2s4aVdwWUg1WHFVRzh5TEk1N1NT?=
 =?utf-8?B?S0JyczhQN3dBUlFqcHhodHMyaG9kcVI1RkU4alM3aGs4OW5uWDZIMjRSZ0Vi?=
 =?utf-8?B?VEltOEpVaUtkalBMbmJVa2JNZkJXL2tsN21MSW93ZG5OTXF2VnlQNXNYMXN6?=
 =?utf-8?B?RFRjZGxtdW5zNkZLc01veG5ydFlvKzdLd2xSSlF0V2FldnZUSkhtbnNEMTMv?=
 =?utf-8?B?b0VlZmhKRWE3RW4vK3ArTWxEUlJTOGh4MkkvYW9mUGZGRm1hRlhyZnI0RUlZ?=
 =?utf-8?B?N2tiSTJlMHIzdThrVStkdmxScWJob3hmQkZmYTVyazM5c05nN3pYQWh3TGdF?=
 =?utf-8?B?MllrLzZtS2VQMnlxQmcwNlVsZUsxUGhkOG1xWTBCM2w1YnIxa2EwUHpMRTRu?=
 =?utf-8?B?emdXTlJ3N2JWR0RrZUdUVEx3anhEdDg0Mkw5Sk5hYmt0a2VlbDFKbkZKbzdt?=
 =?utf-8?B?NFcvMWlkbGVJVkN3MTJ0V1dOS2NnY3RiOTFuS0R5ZVJZZEJZSzQ4Mko2ejdr?=
 =?utf-8?B?WHJhcVdTKzVWakFITlVOZnV0bFFtNUFzdDQ0NTJEVlZyVldVQ21vckozcFQx?=
 =?utf-8?B?RWlzMEFKWFpGNlhRY0drZ0FGZXI1TlptZ1o0a0dkS083aDZHZTVJbWhjaFFr?=
 =?utf-8?B?dDdmNGMrQUhlbzZuazc0TlZwZWlZb0FMWm5GOE51OXN4Tm10MklJZnRXaVl2?=
 =?utf-8?B?UHBhYVVhM3J3UFZQTktMTUtCcXZVSFd1UlA4OTFvYlpPdjFjZ3Vic3poMEZ6?=
 =?utf-8?B?Vjk4SE9pREhnVWJla3lNM0FyeHYyMWJyU0pWemJSc2MvVFFSMS84elFvYmxV?=
 =?utf-8?B?dHNLTndKb2EzTTByUzcrOHpsTlhvbWNPcU9RanZuZGZNODFPekk1NHJtcnp5?=
 =?utf-8?B?Rk8yd05nOUlaR3dnZmpvcGRmNHpmSlp4Q2FDTnd4QlVnY0YvSTRHRkNISkdH?=
 =?utf-8?B?VklISlgzS1lpWStpYTU5RDJpemxGS3FUeGt5Z1RMdnBkckZWM1JOWWdjVHdJ?=
 =?utf-8?B?SVc1REszS1E3OHRJeGU4cFdwenkxVytUenBVekU2cFNweUJSNWFTaVZiamY0?=
 =?utf-8?B?ZE8yeEtSUE1BQW9EdUZOS29lMml4ZHJ0dUYranhBMGE0QVU5S0YxRUZySml0?=
 =?utf-8?B?MXlpODdVL2gwck9JV21ZMFZEdVRJeVcxd0htOUx0SUd6d0NkdlZINU1tYmtm?=
 =?utf-8?B?Uy9adE1yTmd5K0g4RTJ4QWZTakc5aCtET3ZJcHJsWGJtS3doSE1hVmFZQkZK?=
 =?utf-8?B?RDQ2c21tZFN4K1JhemFkZEQ4Ykl5bk9TbjQ2ZFFUWmR4Yk5vTjJINnMxMmNK?=
 =?utf-8?B?YnB5RitqbGs4VWo0UGxKcGJsWDF6S3V4WjkxNnJTU3RQVGhiNDZqZVpRa1FD?=
 =?utf-8?B?clNUL1NGUHY4TTJjajhuNmdIWVlxb0Z5amoyYUtUeWkvWnJLbGVrUGlmSHpu?=
 =?utf-8?B?OHg2aHhraWpDbTg2NkZJSEUwSlF0bTE4SitURTdlUUNPYTdNNHhacE5tRkQv?=
 =?utf-8?B?bDJleitFR0FoOUlIY2N4TTFuM2ZQVXhvd0NZckRtQ3QxaDVCZFkwclJyWFFj?=
 =?utf-8?B?amROSG82aFlQM0NVaThXSkJKdHNkQmVqUUdlWTJnUFJXVFdDZ1dvb2xzQi9x?=
 =?utf-8?Q?Zjpm0YMHhw7kwCQoKytNo8EEAh0ucFxNANLhf7Yw9i9Fw?=
x-ms-exchange-antispam-messagedata-1: 5SScp4p35DQs8w==
Content-Type: text/plain; charset="utf-8"
Content-ID: <711EEF4213DA474EA2741E57638831BA@namprd12.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: b2869bc2-5ee4-4210-8669-08de6c4a298e
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Feb 2026 04:24:51.3713
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OtkizYn/MOaI1HBoKGwM88XUeIAFCCyci9sZ7qRJZx0YAWQKV+zgCGRchc/zz9jylqgC4EreaUroyyRHJe8HDg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6461

T24gMi8xMi8yNiAwMjoxNywgQ2hyaXN0b3BoIEhlbGx3aWcgd3JvdGU6DQo+IE9uIFdlZCwgRmVi
IDExLCAyMDI2IGF0IDEyOjQ5OjQ0UE0gLTA4MDAsIENoYWl0YW55YSBLdWxrYXJuaSB3cm90ZToN
Cj4+IFdoZW4gZG1hX2lvdmFfbGluaygpIGZhaWxzIHBhcnR3YXkgdGhyb3VnaCBtYXBwaW5nIGEg
cmVxdWVzdCdzIGJ2ZWMNCj4+IGxpc3QsIHRoZSBmdW5jdGlvbiBicmVha3Mgb3V0IG9mIHRoZSBs
b29wIHdpdGhvdXQgY2xlYW5pbmcgdXANCj4+IGFscmVhZHkgbWFwcGVkIHNlZ21lbnRzLiBTaW1p
bGFybHksIGlmIGRtYV9pb3ZhX3N5bmMoKSBmYWlscyBhZnRlcg0KPj4gbGlua2luZyBhbGwgc2Vn
bWVudHMsIG5vIGNsZWFudXAgaXMgcGVyZm9ybWVkLg0KPj4NCj4+IFRoaXMgbGVhdmVzIHBhcnRp
YWwgSU9WQSBtYXBwaW5ncyBpbiBwbGFjZS4gVGhlIGNvbXBsZXRpb24gcGF0aA0KPj4gYXR0ZW1w
dHMgdG8gdW5tYXAgdGhlIGZ1bGwgZXhwZWN0ZWQgc2l6ZSB2aWEgZG1hX2lvdmFfZGVzdHJveSgp
IG9yDQo+PiBudm1lX3VubWFwX2RhdGEoKSwgYnV0IG9ubHkgYSBwYXJ0aWFsIHNpemUgd2FzIGFj
dHVhbGx5IG1hcHBlZCwNCj4+IGxlYWRpbmcgdG8gaW5jb3JyZWN0IHVubWFwIG9wZXJhdGlvbnMu
DQo+IERvIHlvdSBoYXZlIGEgcmVwcm9kdWNlciBmb3IgdGhpcz8NCj4NCj4gT3RoZXJ3aXNlIGxv
b2tzIGdvb2Q6DQo+DQo+IFJldmlld2VkLWJ5OiBDaHJpc3RvcGggSGVsbHdpZyA8aGNoQGxzdC5k
ZT4NCj4NCkkgZG9uJ3QgaGF2ZSBhIHJlLXByb2R1Y2VyLCBJIGZvdW5kIHRoaXMgYnVnIGFsb25n
IHdpdGggQVJNIElPTU1VIGJ1Zw0KcHVyZWx5IGJhc2VkIG9uIHJlYWRpbmcgdGhlIGNvZGUgd2hp
bGUgY2hhc2luZyBhbm90aGVyIGZhaWx1cmUuDQoNCkkgdGhpbmsgaW4gZnV0dXJlIGVycm9yIGlu
amVjdGlvbiBpbiB0aGlzIHBhdGggd291bGQgYmUgdmVyeSB1c2VmdWwuDQoNCi1jaw0KDQoNCg0K
