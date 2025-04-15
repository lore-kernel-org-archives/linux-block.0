Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2049.outbound.protection.outlook.com [40.107.237.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FA5920F081
	for <linux-block@vger.kernel.org>; Tue, 15 Apr 2025 15:39:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744731592; cv=fail; b=IwIqiWqjXjN1crpnz95BajKRg7uv6cErR9SCTaVFz5x+2f0OuuXJLR305H4zs4ckj3jMrGAvXx6dSTFhrIRlx0Z15YDKb6JKMINIpM/HJdAMrJB04G0tKd7j5/Z4a4IWt2WWsin9u57lVw4JQK/GRjb34QqRPDuwmwVsmOEJ7j8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744731592; c=relaxed/simple;
	bh=wk34r8mfzKxdFrcvki1Cw+I5WsTf0E3xsydnrdKMSnw=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Zpx7nbKN9S4eIJMg1DcHqImnTJzEHuBGKInCqd2AcZ8GhOEJRykIxMJobs8u6gBlVruLSb/Uo7brJiYTfFSnIN1cj4mjOjRmfIx4G5RQNqhhdtan5ETRR9ECp7KDfOPI0fUR/GQFrnX3rDKVITojHPOoZjHBO8zOU0qsfH7ok+8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=aa2Eow0z; arc=fail smtp.client-ip=40.107.237.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="aa2Eow0z"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jdXTPE8pdemiFrDS7dYxzxPFO7eNJunap32iyPFDqVtLIQHrzS5TNnqGGydRluYBs5DMK+Gk3ntfASmpM6YfEIXJvGMvifrkpHpSdeCogoErPALOejuxwH04aShFvdf/8Mc9ovF99bIrgSjBfcylGXbUI4ggX9Nau1iceshp5VI6iHswHqY+KF6vhb7RTLS+KwD2wDQ2aOTUU0X3uHlDKrxIoTxghJE/SDFh+VqwoFaO68boq6RrETbXo/r9x5xeih6iqEpzbW/PVOPoXTkTXX7zgomf+h2KQPopURBpWgN/qujazZrMiYP59dZwwFR/zrftue1c2tkFZSAvTYCJQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wk34r8mfzKxdFrcvki1Cw+I5WsTf0E3xsydnrdKMSnw=;
 b=ZPRkJ77o+R5S94txuXgUqLMQebUfJj5d+dfRAEysSfcE9UiOk4zHAs7L2a2lyvH405YbckLqfDzwM6Mk1JtJ8eePCorLbaRrFG9cv4+mePQq2CyDyRpTvm4DvTjXTaH5tFUU+H0Zq1t7gw9BhA5tOVhqaUhzVv9sk0pVIVV1arco56N1TJbeC2FF4G3eoKv/YRwKIHvqb9zP4t3IkULvLOnVQo18SBJPgv0Alfbw1hijxgzPfqzCr0Xl0C3ZdORWnGGbvUrRWYDqHEldom40YpjMbtTJO49ic/eQy+5McGy6+BcUlT3Wabf2vxScxcI65fo3NIYNnQLuK+IznZ+kRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wk34r8mfzKxdFrcvki1Cw+I5WsTf0E3xsydnrdKMSnw=;
 b=aa2Eow0zel04AlvcD8P0yIROzPJlQi2dJ/4jwF6O4VvIBt2D2okmU54vX9fnbgp2ZZWMcZuQb522UG975GG6FkgCKCzcRDWhwGnAZn/y8h22k7Mk3UVU7p8FnasSaFIm/DajdwttcA0VPs//pc289jzZo0Td5/s4cMlJKOmt9dl0wMgYXvLwPXCuWUajOkTZqLeDns7ai7i1jOmv1HOwF1DZjZatbXEeoWXPz8Geqf/h4EeLTszmeqL06S0mcIqAldd4lwtStnudRi5KMuQ2BrIBnmAKR/Rm7/rBxsMUiQVAnEcN/aE9o7wCmX+5YPLn75IRuuNnicf4q1wpCVOaRw==
Received: from LV3PR12MB9404.namprd12.prod.outlook.com (2603:10b6:408:219::9)
 by DS7PR12MB8249.namprd12.prod.outlook.com (2603:10b6:8:ea::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.34; Tue, 15 Apr
 2025 15:39:46 +0000
Received: from LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b]) by LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b%5]) with mapi id 15.20.8632.025; Tue, 15 Apr 2025
 15:39:46 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Jens Axboe <axboe@kernel.dk>, "linux-block@vger.kernel.org"
	<linux-block@vger.kernel.org>
Subject: Re: [PATCH] block: ensure that struct blk_mq_alloc_data is fully
 initialized
Thread-Topic: [PATCH] block: ensure that struct blk_mq_alloc_data is fully
 initialized
Thread-Index: AQHbrhXv1kAtGUmFU0KbtJmq2Iv/KbOk3Q4A
Date: Tue, 15 Apr 2025 15:39:46 +0000
Message-ID: <f76042e9-6855-4134-bc45-a38c5102b33d@nvidia.com>
References: <1720cf81-6170-4cac-abf3-e19a4493653b@kernel.dk>
In-Reply-To: <1720cf81-6170-4cac-abf3-e19a4493653b@kernel.dk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9404:EE_|DS7PR12MB8249:EE_
x-ms-office365-filtering-correlation-id: 29668b74-8e86-4ad2-33ad-08dd7c33c025
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|10070799003|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?TVoxbnZpWHFma3V4a2J1QUl2N1BKalY2R0VGQW9uTEJuby9KNEFCNXhUcUxt?=
 =?utf-8?B?ZHFaRmlHNmFHT1pvc1FOSTBjTzFwMHJac08ybXlsUXdHR1JQczRmV1pNRGNC?=
 =?utf-8?B?Z0RDV2tSVjNZeng3ZG9EdjZmRGFLUis4OHdVT0RJcnloSGhISzhrWi9RWGl1?=
 =?utf-8?B?ODBYWXU1N29CWUd3ZzRiYlpOR1FzV2VieWxZbkVmSTMwSjYyUlVtUEE0cXha?=
 =?utf-8?B?dWx2UVZDcjd5OTdvR2ZieDFkYWpSQm4zSjM3MXRBS0lmbDgxRjB2UDZtR2RR?=
 =?utf-8?B?cDQyUXNLOWduaTY3THo2R1l2MndwU21jWEcxcjlUWE1oMUpHUytWN0VJUlZv?=
 =?utf-8?B?RmkveWJNTE5RVk5hMFlMUFFjNS9ZYWdBSm9vMmhGY25WOXUyNXdFcS9QUFRV?=
 =?utf-8?B?VytuYVI0MzB5dUVWSXRtTXJsclpiTWJScUVwOEpjTFdpd2N2dW12OUt0TElE?=
 =?utf-8?B?dUpHdWR2YWdNQ09vZzBaQ3FTVmxITXREUWMrbGFBZENlU1crQVQ1NEF4TWFP?=
 =?utf-8?B?YVc4NzJFV0RnNjNSRVBpaXgxUld6VFV6YUc1d3Z0bkh6K0ZGVmh4S1ZQYzhQ?=
 =?utf-8?B?cUJHa3J1WVpnMWhGbEdIZ3FzL3M1SXY5Z21JZGZMTlFRNjNmTFBGZVZ5V0Jp?=
 =?utf-8?B?OWhrbDlTd2VRZVc1ZUNKNkxlMEtQdXViQWVnWURtdTlPcFBOWjFZYm55RWFx?=
 =?utf-8?B?RTBJRlduR25pQkJhc2RDV0M1WTAza1FQbmlWdDF5bVl3Vll3RGpUWEh6Y2hM?=
 =?utf-8?B?NmRWRnptaC9oYituUThEMEJreGZZWjFYYnUwZW1KR1RrandQUjhTTDJ1T0Zt?=
 =?utf-8?B?MGR4eC8wZlVhS3pNYVp4cWVNNUMwQnJLczNmcGFIVXBZU2cya0hYb2lhZTlX?=
 =?utf-8?B?OEorQWtRYlNTck5EV24vaWt1d0lHZW1jUXN0SVd1TTlEZ0FVOHdTcW44Nklt?=
 =?utf-8?B?VDVrZ0xXQXN4ZGZMUjlBL0Y2bzlLK1d3TXhiSzJSYmNaZ2JZVkM0RGxyeFJT?=
 =?utf-8?B?VHp5dXUrb3pYendaUWppZkR2TmMrQld6Sm1abVlKMzVMN1A3aVVRL1l6a0V6?=
 =?utf-8?B?aFJCeGsvV213cStCQkI4bE9Db0k4bnlpV0JKVTNxaGptNGFGM3R6WDg3YytE?=
 =?utf-8?B?M3JHbGhxOWVDb0hBakRTcVd5SmRjTnpzVTIxNkpDME8wbVFSWkpqclBadVEv?=
 =?utf-8?B?dkZWQjZoZWxvQlhwbFE5Ykp6WEgyQVkvbkt0c1JUN2lLdTk5UTR0d1UvZHVO?=
 =?utf-8?B?WkVvd0hRdklVNERBRGRGNjM4MHVEY0RmOWoydWRaZUlkZXNRb0VoN282eFc5?=
 =?utf-8?B?MFdEcGxnNk03TzdNWTFoTG1yTmJ5K1Y2eURsUWFUMndaRUwrcWo4Q3pmQWlZ?=
 =?utf-8?B?dVh0TXZLUVZyS1hqSGx4d1BybHVoQmlVUmR2a210bE1VS010c0N1dXFIZXhn?=
 =?utf-8?B?RTlzYzJVS1UrTVAycjlGZFcyM1JBVzdRdmh2T1V5TmxneDZadU1HWndRb29Y?=
 =?utf-8?B?UG9GVlc0aGhBUE5kalkxc0d4WWRWelFjS0VlUmsvRzA2VnREcjRVMkptdkk1?=
 =?utf-8?B?TDdIRHBUenVGSFRsNVBwdWhrYlBsSDdBU0lYRDhMaExIcVlVM2hzRVNZaHFo?=
 =?utf-8?B?K3BocktYZnlwTjRxZjVEWXR0RktZMGVmNXVwYlRuZFRBUmlqSXNUeDZDTDFa?=
 =?utf-8?B?RnB1M2Fob1Rha1Y5cTZNTVB0azQySVg2bzl0YnMxQzVSdWIyWm1mczhCdWVG?=
 =?utf-8?B?VTcwb1BiMk9lVENRM1JSMXFidHdNejY2ZzFGVFVFM0ljV0RSWloybzQwMXhG?=
 =?utf-8?B?L1BKSzRYcEZRWUhxWWRxV3hUWkdUaDRrMXZBYjBNYmtiT0ZVdi9LSGdGREZN?=
 =?utf-8?B?d2d0WDhLcWdvV2Q5b1NIank5QlIrNDN6b3dhYW54dks1eStkUzhkWnJ6QUFo?=
 =?utf-8?B?WWc3OXg1MktqUW12Wmx0T1lheFBURlpXQTRsSjJkdENSKytwenRZTDVtNEE3?=
 =?utf-8?B?QncxVTJPUmx3PT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9404.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(10070799003)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?VkRoNVpLWGpOc2FVTEtCNS9uTmF1MmdHNERLdUFweEhqSkpQcmhXM2NFM0J4?=
 =?utf-8?B?dXZTR0ptRlRLaUJScFBsNXd0MThIL3JGSisyb0MrWkRObFlpVDViMFA0bFZt?=
 =?utf-8?B?TWE2bHBXbndqdEZyWFFmTDBlLzNSTG1hR01zaTN0RmZVS2hINDNsM1djNFJu?=
 =?utf-8?B?ZkQ0UUczNmE2UFY2eFlQYzI3anJ4WDMxT3M5Nm5DcHVoQ3VBNUoyVnk1MFFp?=
 =?utf-8?B?QmdVREhGcFlweE04SXBWVEhPOHBUTFhXMTh3cVFVZzIwRUdaMEpjRFdFdGdO?=
 =?utf-8?B?NUJCdTF1RXlDeTI1TkZMd3RKeTY5TkJjTE50YzlCMVdmbEIrVnFNMDIxZTNi?=
 =?utf-8?B?VEVMcGJ0T3B0MGdFRUNjY0lONC9sQjlGK2hpVDJjN0VhbGEvcFYxS2ZzeEdy?=
 =?utf-8?B?V3NDd0lBa1lZWmlHMDNVUkNEcUwvcER6aEU5aGhzQmpHRGUwQjg2WHJwSFM0?=
 =?utf-8?B?Y0xNUVdaNlZoVmVBUUxpN3NOaXhMSUsycGl0ZVZmQkxlOXhYT2RLUTdmUm0v?=
 =?utf-8?B?MW4zU2RiazdrSlZTU1AyQldYODM1NktIOWFEdFpVVFdSdHRHcVFBelZOSzF5?=
 =?utf-8?B?ZWN0dnlOYno2QkNlN3h3bTBWdnp4UlJ2dUFhbmJuTnZ4V3BKakV0ejAvcXFp?=
 =?utf-8?B?ejc5WnZ3amkvbGVjQVhLLzNnUmlCZGFweTlaQ1FXWStSOU4wNVBvMW9obFc2?=
 =?utf-8?B?OXRxZnNBd0VwamJ1ZnNkYXArZnFvR1ZRaG5jbFF5eU9DVzAvUHdDYjlhRUFk?=
 =?utf-8?B?cGlZMVdhcUpwUjlMMjhUc0JQajAxdmp6TXhSZ2VHcjNGbzdNTlhSWnFMREIr?=
 =?utf-8?B?aEV3V3MvYjdMRFl5RmpDblRIYk5PdzVIeVVhUDVySnFDR05uU3U3NW1oeTJU?=
 =?utf-8?B?aTE5LzFMVGFFd0xMakwyRjJ1WVA0RFk3QXRMT1d4Wm5uNTRzNGRYR21qamo2?=
 =?utf-8?B?Q1NSeGwwMTA5VlJCekxuSnM1M2tBNE8wdHhsbHVBdG5FVWRlWFlNMnNFekIy?=
 =?utf-8?B?R3k3eTRWeVFrN1BLS1F5b2V1Mm5WZEk0MTZmS253ZDM4dG9PK3Y2YlFDQi9E?=
 =?utf-8?B?TUprQUQrUFI1eDhOWmJoenlZelp4eDR1UjZBc0ltbUkzZE9WNWJ5RGUyV1Fp?=
 =?utf-8?B?d0ZvRVU3cGVaVXAvWU9sTkQ0YjdMcFdXekNzK21mdTZQYWx4N01CRGFBWCtL?=
 =?utf-8?B?NVJyNmMyLzBCeXNndUpoYlpWcnBYN0VqSUxUMHo3a0RBRnJYeWliTFVzcm4y?=
 =?utf-8?B?VWUvbUFQSmVTcG5Qb3M1YU80VWNTNWZ0ZHdFZktrQnI2SnNTdHczanQ2WjlR?=
 =?utf-8?B?aHIvMWZMVnZvM2tFU1BVWDJqdWlvRGZJN2VaRE83WkthNGVvY3FQbWRzS2My?=
 =?utf-8?B?RFJEZ2d2V2dGYURXZ090bXg3QkJ2UW56VWtuZEF3NDVvMk9ORXlyNEhadlRM?=
 =?utf-8?B?S2lVRWNwbEdmRlBWTGhtME5lV0dveTBmeVk5b2FxYTh0bkVxTmkybDByTksz?=
 =?utf-8?B?eEhQb2sxSjhCM2UvVmxYUkdsOWVrU1VSSSsydElnWWsxbWpZeC9zelVkODRH?=
 =?utf-8?B?QmhWcWhMUGxQOFgwRjE0U2VXNTAycW4vTEZ1aURyZnVWMHM2RGxPVWVkaGdp?=
 =?utf-8?B?MkgyTEFNN3c3aVFPRHF0Ynlmb2VoTVdha2wxZUlCM3ZRclQ0RGZaaWViMDR5?=
 =?utf-8?B?a2ZTRVhjWUNvY2M3NDJUc290R2QwUGRNc0RsbkYzNEVvaGYrTmZlVEZWTFFQ?=
 =?utf-8?B?Q0ZMd0o4c0hDZUZLZmF5R2k5d0ljdmFDNzNzMXdHaHExRERJcERDOXN0ZFBk?=
 =?utf-8?B?WSs0ZHBIYUpTQlN4b2UzeU1tdGZacTlaZWx5bFZNVXp4SDlUVmRmTGFWczFt?=
 =?utf-8?B?eVZ6K3gzSWt2OW9UaWJVNUgrTVpWSEwyM2grSGlGWXkrSXl0YnBRSzFWd2N5?=
 =?utf-8?B?VnBSWm9rZWh3WTkzWkhvUXhaNUVuYkxMaUsyMTFxRkJWNnJGT1ZRWEszWHh2?=
 =?utf-8?B?UUJpdXM2SGo4QzIzTHErUDBCMXZ1bVZLUU00RW8ra2pYOGNmeTZkRVlaYjhH?=
 =?utf-8?B?czl2WWQ1Ylk1alI4ZEU2R3FiMkNkTWZpUGFwWGluZTc1NFU4QkczWFJ2SkFk?=
 =?utf-8?B?bjZWZnN2aldEL3VDNmVSL0ZvMjYrd3VOeTBpVERRQncva0VRQndQZVc4MGlS?=
 =?utf-8?Q?5TFFlHE0cQXpNK8R1hGx99KsPgB3kkbemSK9JR20/tUx?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <AC6F666A7F8BCD45B0E54C24BBA2597C@namprd12.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 29668b74-8e86-4ad2-33ad-08dd7c33c025
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Apr 2025 15:39:46.5247
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mMymXMpHtreDleIwJwGkStGBlOm8JNP11gxG5QyfOVGc5jBvLnA4mRzMVjGhCd/MJJYYvKRLZyYKKPFBsG62XA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8249

T24gNC8xNS8yNSAwNzo1MSwgSmVucyBBeGJvZSB3cm90ZToNCj4gT24geDg2LCByZXAgc3RvcyB3
aWxsIGJlIGVtaXR0ZWQgdG8gY2xlYXIgdGhlIHRoZSBibGtfbXFfYWxsb2NfZGF0YQ0KPiBzdHJ1
Y3QsIGFzIG5vdCBhbGwgbWVtYmVycyBhcmUgYmVpbmcgaW5pdGlhbGllZC4gRGVwZW5kaW5nIG9u
IHRoZQ0KPiB0eXBlIG9mIENQVSwgdGhpcyBpcyBhIG5vdGljZWFibGUgc2xvd2Rvd24gY29tcGFy
ZWQgdG8ganVzdCBlbnN1cmluZw0KPiB0aGF0IHRoZSBzdHJ1Y3QgaXMgZnVsbHkgaW5pdGlhbGl6
ZWQgd2hlbiBzZXR1cC4NCj4NCj4gU2lnbmVkLW9mZi1ieTogSmVucyBBeGJvZTxheGJvZUBrZXJu
ZWwuZGs+DQoNCkxvb2tzIGdvb2QuDQoNClJldmlld2VkLWJ5OiBDaGFpdGFueWEgS3Vsa2Fybmkg
PGtjaEBudmlkaWEuY29tPg0KDQotY2sNCg0KDQo=
