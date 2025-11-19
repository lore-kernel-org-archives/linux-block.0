Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010046.outbound.protection.outlook.com [52.101.85.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1B21256D
	for <linux-block@vger.kernel.org>; Wed, 19 Nov 2025 00:39:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763512795; cv=fail; b=s7BGrSDSwnXDqc7NxQV7J2Iv317xtc0/plzm42dRYwroGGHnHu7VNDl45TcU6vbyeV2GaZH2d+1rj1XTgKUJ9pBw5vQ/cEIccxEvwSE3LHt7B9l0HT7KHf1DzGnqECD2WuiFx6tcD1OnlzS/gZeBxxtr6McfhwJqUlVd+2ASow8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763512795; c=relaxed/simple;
	bh=I+U3YW/H43vvClbGDxzExpzfk1wLd0AePFDU5GF3Ue0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Bn/dYQiXLXrLLPt0zE41Q1ftpyeu6n54HTabrluSyEpfcHzJq2b8QvEJ43DxVHHO9C6RU3+SVbSyRK8TE786zNYPrmKqvF+YeiC/6n6xrJ50WPqHdvbNFOFe/fuKFNqRltI18eOoW7nQIyy0UwaybMmkbx0ZlfgaMN0tm+TkRPg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ElARN60V; arc=fail smtp.client-ip=52.101.85.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ElARN60V"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=a5ovRsLng2gQQQEziCWI5EYTDDakUCau9e5R4Puz7mZCznyIBrirbR0hEtxea8ci2eyO/5IDTXXmrM9p6Nd1qm8PELhAI5J2X3O3FBvKTF6Wf+ycxkco5pbFlF50KqFAFjk4pbEZ9zbeHG9GOxya3A2mO0wv3a218e+t39agD6SEHicWw/xjRObOdIjB004D1FEGZtH31kH3oFWYnja2C/6dCZtc3z/xXZyHbe/+18XuiQDXTMUjUlFgMUm7es3c6CO4oylntCtshL4/VSr3xmgFiTsdKpUmSy+WIhSXlKYIP9HAEuKQAYYYSXonNQ0JPnj3UQaoQX12ha9ceaZBOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I+U3YW/H43vvClbGDxzExpzfk1wLd0AePFDU5GF3Ue0=;
 b=Dsobe2RzHLVNCSmA63o9mW5ItsXG8DouOOab2fHnP7eEqcVyMqA0+04dwKSUlstAXAIiIQ6x05QG67B5bXl+3jpFSZR8mqZD18d/PcrNkWmK+rrABogqJ2kvst/Rz63FHbKcPesbbVfpYZJntBVYWneDMURq4E8Cgjs7MFTnEVdHl8xQvKLLohbiLvDWywconGmjwwv3f/Z/IxN+/ztUqxvJXoXd8045C7dInoePjo15AHABJ3y39Yr3GlKUUypsFenA4P4+nZLHUw7JLah6Zf7tpCOhYq26rZ+Z1/1GWxmT7aRVtFJq3bGVrjdR/jVPg0u5G2T4erIUB9krwI6hTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I+U3YW/H43vvClbGDxzExpzfk1wLd0AePFDU5GF3Ue0=;
 b=ElARN60VDfwHcHmiqZR0lnMqR1UaC/CjVLmPJr56+2560LYRXbMLx9qCSvfoHBZks1oT+fxI9GugKm/e9PrSc7/Vbv5NNkhEiY2llhm43idem2fwKUfdwd4C02P/4qzGoyLMQqO7KDFp24xJxYVkYwchZ3BeqaLCG+QyYxjE8UVMbnEfdlrC5oYxUb4oSolaT3lVvwCzpMTFTLrTO4IbBGkREA7xJF68JpNM8S9Bxhtc9YLlzd39IkSPLrtg4rS1VZVhml+kVK9LQNGbEAgN8pMRi5kSh9ygIG/MLpSpRWzJ47qE+pTNyfyFS6uMODAtzgrVX0ory+9/p2iUga9Bcg==
Received: from LV3PR12MB9404.namprd12.prod.outlook.com (2603:10b6:408:219::9)
 by BY5PR12MB4097.namprd12.prod.outlook.com (2603:10b6:a03:213::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.10; Wed, 19 Nov
 2025 00:39:47 +0000
Received: from LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b]) by LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b%5]) with mapi id 15.20.9320.021; Wed, 19 Nov 2025
 00:39:46 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Jens Axboe <axboe@kernel.dk>, "hch@lst.de" <hch@lst.de>
CC: Damien Le Moal <dlemoal@kernel.org>, Chaitanya Kulkarni
	<ckulkarnilinux@gmail.com>, "linux-block@vger.kernel.org"
	<linux-block@vger.kernel.org>
Subject: Re: [PATCH 1/2] loop: respect REQ_NOWAIT for memory allocation
Thread-Topic: [PATCH 1/2] loop: respect REQ_NOWAIT for memory allocation
Thread-Index: AQHcVqQSWk1ka6Xc10yTpB77BDOaP7T0qwUAgAAfqgCAAx5lAIAAkCwAgACzeQA=
Date: Wed, 19 Nov 2025 00:39:46 +0000
Message-ID: <7b967247-3af5-4041-a381-2610ec6fc4d4@nvidia.com>
References: <20251116025229.29136-1-ckulkarnilinux@gmail.com>
 <6f76d0ec-a746-4eaf-abe9-86b51d2ff9db@kernel.org>
 <67472833-fd71-42a7-ac32-26e1da30f3ad@nvidia.com>
 <20251118052124.GA22100@lst.de>
 <eef289db-72fe-4985-865b-c18c235d586a@kernel.dk>
In-Reply-To: <eef289db-72fe-4985-865b-c18c235d586a@kernel.dk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9404:EE_|BY5PR12MB4097:EE_
x-ms-office365-filtering-correlation-id: de72cafb-7fc0-4333-154e-08de270423c7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|366016|1800799024|10070799003|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?ekJpT2hFNkk3OTR3Z2NBQVlrNUgvT1A1cFNBa3BUKy81aEY1M2hGY2xRK1pp?=
 =?utf-8?B?ajcrbURKTkQvMXdzTThNT2x2T25YN3FCN2pEVDZGd01MZ0VoVXpQVC9lKytw?=
 =?utf-8?B?VFkvZVRGdUhEVm1nRnJJYVZISG1CUmorQ2YzMXpkUzRXN3ZHZitqdHlRSVhn?=
 =?utf-8?B?bkpNR2RQWkI1blArbEJsZTVxU2tSTHVrWURjVklxWlhzTE9iRzdEUGp1SFdw?=
 =?utf-8?B?amdZRTFwTWloQjZabUZvc2NCVWdPU2w1YXFMa0tPR1MrSXNiTDJGL2gyU3hj?=
 =?utf-8?B?a1ZlNUk2VnUyNHVoSVY0cFVlR0lJM0pIN25tSTNEVFpZVEhhbGRpVGxrMC9J?=
 =?utf-8?B?clFaMTZMSkJuSDFkTzlVd09MNWhmVmxVRjVqUTNJR3NlMk5iYkpkUHI5b0or?=
 =?utf-8?B?ZHU5VGJyWGxaL1FPaGUyd0poYVAzN3pzSTk2WFRYcmdGTVBjMVh5K0J3eTBp?=
 =?utf-8?B?ZllzSVBLeW5HN1lvMGFpeXJUbkNqc2ZGcWRuaUh0dDRJUmNjY0VVSWQ4T3RB?=
 =?utf-8?B?eFdKdmpCTG1NWjJHamI3ZGwwQTVDbE80akZYUzUva0FNQnAxMEpYVzdYWVdQ?=
 =?utf-8?B?SW9jMXlvN0pmcHMrQVJaUG9LVVc5ZDBCSVdpQUtBWk9tQnRaMnFycFdCZWF4?=
 =?utf-8?B?eWtISDEzd2lJN0tOTVZyd0h6TkhEdStGZ0NoUGFDdUtNZ0pybG5zeWNlYmFQ?=
 =?utf-8?B?ZFJOVGczNXV3UDkvNXd2TFVJb1BMN1N4bUZnelgxeFF0Q0gwaUtnY2pocUx0?=
 =?utf-8?B?dFdISnpVNkR6eEJJNjBORmVsNDFOc3Mvb3RSdjVuRzU3V3BTS0xVVFY4dXNK?=
 =?utf-8?B?dnFWT3NMSHZGZHdSaDRGQURudEpKZnhKdFBwTmZrRWZQMnJxVmxTOG5tK2lJ?=
 =?utf-8?B?VWpYMXRoejF1NHd4RVFUS05EeUpRQ3hBc0Q1Y1Y3Z24yVXh1ako4dTVrQ3pU?=
 =?utf-8?B?dFhNYTZuN3NNaTJGRWZ5NkE4YUdQYWo0c0J6SHhreVlMaWF5ZDFUN2lqZ1dI?=
 =?utf-8?B?VjY3VncxSG5ubkZMM1plNFJwN2FmTWN5MFFxcEcxR2p3TnlPUjJQbGtmdGs1?=
 =?utf-8?B?NngwRVRBUzk4dWY3RERlc1BTSk9TNzZSK2JESlRCVElqOVo3ZXdNODdsSG9D?=
 =?utf-8?B?VXAzZ1FCWE05bXNkQk5CdGpqaHo0VHdZc3VXcDBaaTJIQlp6TUd6ckQ2ZmFv?=
 =?utf-8?B?ZzJYU2U3eDNOTXhTNHYxSk9UWHNXSURoOExNMURVbndaMjdRaU42NFlqMmtN?=
 =?utf-8?B?TWhCU2xTT21NdU1RU0lTTjNTS1FoRWJYREFIREp3ZkFERjBHbEVycFQ3aW50?=
 =?utf-8?B?bE5nc3V1OVp5WEp6RGNjdC82aWpYYVJTZEp6QTNjUFQ1RkJ6RUFpS2NmeTg2?=
 =?utf-8?B?TjN6YmIvVkRRL2lWdGNHdk9pSGlqRkRjTyt2WkNpUTIzSnFuT3BiT0lWT0FU?=
 =?utf-8?B?NmRhallNTGZmUzcvamtoREFBUDA4Sm04L0lUUVYyeFE2Z2RuOXRSSEtESUIz?=
 =?utf-8?B?RGg1ODI2UmdDTkNycTFXdkVvYVd5YmcwSFNheHl5TkdoeEU5U0NkengzMlhL?=
 =?utf-8?B?cVR2dXQ3a1JlZmRBMG5XQnhUaStWR1RENHh1SUg2TS9FWEV5QWdETlhCZ3Yr?=
 =?utf-8?B?UkNKZFhQS1JOZGNJSXdUN0lZb2NNL05ReHNybTZXTkMxSVV3bzhFWjJmcHVJ?=
 =?utf-8?B?ZjM3cnBJSnlESktLZkU2Z0Q4ZzI1M2c2OUh6QnVQT0Uxd2h1WTV2QlR4dHZq?=
 =?utf-8?B?cmNIY0JIRVl0TGNYcFQ3Z2N2RmxhSWxhRmFrRHpBTC9FYm9BQ0dQZ0hNRGNE?=
 =?utf-8?B?b25mUWg0UlhpVjNoUjJIQUlvZ21PRE0rcUNDdDZ0Y0QwUk5BZk1CYkk5c0Fv?=
 =?utf-8?B?dEhGQnZ2Nko3UjZPMkp1RWNsZzYycjRtbE5xVXYxeWltR2pMOUlSY2o5VlNJ?=
 =?utf-8?B?UWdZSExNcTR4WVNrRWRRbFZVQ3V6WGp4c0srbHNDMzI2OFNCOVRmNEU1VjF1?=
 =?utf-8?B?R2NuOGQ0OUcvUmwyakt0NW5aMGlLT3luaUNLZ2hOZ1l1MWZqMVQwb2FzOGQr?=
 =?utf-8?Q?ZXSp+r?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9404.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(10070799003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?UXhWYkNOT0wrV05WYWhkUVlFTEkvYUZWWmVCbFV3cDBBdkV3amR3REI2dFdH?=
 =?utf-8?B?ZU1CV3NOdlBLYitQRnFnNUFpeC9TUnVmUGRTNStvVGt3YjgycThwTWRNaktz?=
 =?utf-8?B?aTVhYzZYcmxiRVhRRkV0dGlCc0ZEUHZTdVR1RVUvVFU4ZzN6TklTRDk0Yk0z?=
 =?utf-8?B?QjZuZ1B3MVpXNzN0LzdoMm03RHlnam16bVdXY3AxVFIvakZ1TmZabForNEJz?=
 =?utf-8?B?UzVrTUl6d0FUd2k0dXNLS3BXYTBsa09iZ1czdW5FTWhxc3U5Zy94SmY4d3JT?=
 =?utf-8?B?RytpL1g0STFLOTdpZ3JXRWZFVWlrUGRPbTdRQUUwUWI4eGZkMWFYekVTekw4?=
 =?utf-8?B?Uld3NmRJZldOb0lHREluQXBvaW5SRUFaY0V6eXR0YUdTQW5hWUNxYzRaNkR5?=
 =?utf-8?B?N1ZJZmpBaEkxSG5tT0F1aWpJeDhmRmRhM1RZNjlqUHpnMGFzdTZGZVZ1QTJN?=
 =?utf-8?B?ejM3UGdyL3QwenI0UUF3d1UzaXJxRVJmdlpHZHQ2WS9McjNReXpraTlzNnp3?=
 =?utf-8?B?NFhBT1FHYzlGOXU1RTJNc0x3OFYzaEJWdVlvbGpndWlhTnBjaHlTY3FTaC8x?=
 =?utf-8?B?cU04WHFPYjVsL1R5eFZ1S2lETnZRSnNpalcxZmVEZ2k4WDBvWFRLc0oxYmhk?=
 =?utf-8?B?ZUZ4cEFoekhrUlJRUFIxNnlqa3pVZUV0VExzSVl2UXMyMWhrMnZhdVVNL0Yz?=
 =?utf-8?B?U1dyUjBMS1JFY0VJYjAvQnhiMWx6MzVodWhwbXlPVDhXMmxoZ0tIMnVHU2tD?=
 =?utf-8?B?ek9uUzVPbUtlck9lUndVcSt5SXNXSW5KVkJDeTN4TnpucWlLKzRRUGVzUk9I?=
 =?utf-8?B?dGNCVWVlZitPVGg3cmlJOHR5N1NUS0lUOTArYUZYSW9nbGJVTXk4eU9mT1ox?=
 =?utf-8?B?OVpneUZZeEVlYnBuOUtyVEpac1FVM013R2htdkI0SDM2UG5mUVQxUENKTkZS?=
 =?utf-8?B?U3EzSjk4OWorY2tFMElEK1BTM1ZhUEl1M1lhT0hpYnRhTm5TVklSY3NVdHZt?=
 =?utf-8?B?NHNHdWRyeGZTVHdURGpqQVU5cHRDNkJXZmVXcWxBaDJFSEhOV2M5RG0rOU1H?=
 =?utf-8?B?aFZhYVlWeUxiS3NLS1M0WjBvZ1Fqc1oxd0lCcTYvcXBvc1VrWll0c3Rsa29P?=
 =?utf-8?B?eVF4OFIxcm5SQmVhS2ptT2MxbmxXSEVDanBwKzdKNjFBdnVmYjFPbFpZQVhm?=
 =?utf-8?B?ZUx6NkZsNUJQZ2tOR1hBSmlCc0dtbVZBVGxia0pjTGk3aWc1Ym9obmFvQkJv?=
 =?utf-8?B?MWtQSkY4OEpKMW1MdVhaQTVJL296ZUtWNkQ2N21DK3MzVVFOc3NDVE10RUV1?=
 =?utf-8?B?T2FwcDI5Q0tUYjkrcGxCTHpUc2xxRmhtUFAxdmJjSmxuWXdTZTY1ellkQmxw?=
 =?utf-8?B?aGNaNnpwdEZQN3JaU1hFOFhicmVDZVFZaERCNUw0UXNpNFpnSUllT2M0cDlR?=
 =?utf-8?B?QTIyVHc2ZWtWdklUSXJjeTNSQ2pzNFJLL0tmRXdqUHJtb1B6UjhWS0tnREFW?=
 =?utf-8?B?UVlwWHVyNHNud2ZaT2VPZ1BFYW41K0QwekczQTEyTTZBK1l2eGQvbjR4Tjd5?=
 =?utf-8?B?YkFHWnpudmxxc2Q0REoyRXVBUWdPaDlLall5NVR5cVdPdXhkdnUvRjRsekJm?=
 =?utf-8?B?TTdJVVp1OEdtMjhha3RyQlN5VHZaQ3E1c3Q2aVRodjMzVXJJWUllOStNTkh6?=
 =?utf-8?B?SFBGRWZwK2g5MGttNDQvMytnZlJ3c2RKVzQ5M0pHRk1JYlRFTEdBSUZLT0xR?=
 =?utf-8?B?U0tSa1pJcEpHa0c2WVZzeDVqTFNGUGZKLzJ6NUl3MUpRNTlaelpsRkxOME15?=
 =?utf-8?B?NThQT0h6TEFSYTdpYU1JcUZ0dEJ5MENjaEl6TnhpUFphdVFrL0FEeDVHVi9u?=
 =?utf-8?B?cUFJdE9CTXVQQ2c4NStodHFSQUxsWksyeGFGQWN1Q3BuRjRLazBxMHVXVlo4?=
 =?utf-8?B?OG1mNnFHZGkybnliSjFiMDJiYm8vMWoxMHkwcHhLd3BLeldtTDhCVC91Nkhv?=
 =?utf-8?B?cW5Ba3pTY1NqVUxZa3piSXB4dWNWa2lwdWRxODl1aGFiSy9FVWZVWDhlT3Iz?=
 =?utf-8?B?TkJkY3YvaHpPWWViVkVhQVQ4T3I3MUlmSFpQWGVMem95ZlF6dmRIZ3FTRzVF?=
 =?utf-8?B?azFwOXp1Q0pFbm5hNS9FbWYreGVjYnFQOGVDMXpieWRKOVd2TEVlQlRrVmZw?=
 =?utf-8?Q?SjPVTHcfjdsLYJ3a6wCeDb2HrdwSUX1lkApw/WrSCfW0?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <450AB9D76772B744A74D00CE000FEA47@namprd12.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: de72cafb-7fc0-4333-154e-08de270423c7
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Nov 2025 00:39:46.6442
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9kFqGeDQR8bjnhn8Q6ni3Yb9acYL2cgHXHeXO2kH9iiNEZB2kEctx5VisvGYNr6nIxctkUcspoOtwGHJgxJBZg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4097

T24gMTEvMTgvMjUgMDU6NTcsIEplbnMgQXhib2Ugd3JvdGU6DQo+IE9uIDExLzE3LzI1IDEwOjIx
IFBNLCBoY2hAbHN0LmRlIHdyb3RlOg0KPj4gT24gU3VuLCBOb3YgMTYsIDIwMjUgYXQgMDU6NDM6
NTNBTSArMDAwMCwgQ2hhaXRhbnlhIEt1bGthcm5pIHdyb3RlOg0KPj4+IE9uIDExLzE1LzI1IDE5
OjUwLCBEYW1pZW4gTGUgTW9hbCB3cm90ZToNCj4+Pj4gT24gMTEvMTYvMjUgMTE6NTIsIENoYWl0
YW55YSBLdWxrYXJuaSB3cm90ZToNCj4+Pj4+ICAgICA2LiBMb29wIGRyaXZlcjoNCj4+Pj4+ICAg
ICAgbG9vcF9xdWV1ZV9ycSgpDQo+Pj4+PiAgICAgICBsb19yd19haW8oKQ0KPj4+Pj4gICAgICAg
IGttYWxsb2NfYXJyYXkoLi4uLCBHRlBfTk9JTykgPC0tIEJMT0NLUyAoUkVRX05PV0FJVCB2aW9s
YXRpb24pDQo+Pj4+PiAgICAgICAgIC0+IFNob3VsZCB1c2UgR0ZQX05PV0FJVCB3aGVuIHJxLT5j
bWRfZmxhZ3MgJiBSRVFfTk9XQUlUDQo+Pj4+IFNhbWUgY29tbWVudCBhcyBmb3Igemxvb3AuIFJl
LXJlYWQgdGhlIGNvZGUgYW5kIHNlZSB0aGF0IGxvb3BfcXVldWVfcnEoKSBjYWxscw0KPj4+PiBs
b29wX3F1ZXVlX3dvcmsoKS4gVGhhdCBmdW5jdGlvbiBoYXMgYSBtZW1vcnkgYWxsb2NhdGlvbiB0
aGF0IGlzIGFscmVhZHkgbWFya2VkDQo+Pj4+IHdpdGggR0ZQX05PV0FJVCwgYW5kIHRoYXQgdGhp
cyBmdW5jdGlvbiBkb2VzIG5vdCBkaXJlY3RseSBleGVjdXRlIGxvX3J3X2FpbygpIGFzDQo+Pj4+
IHRoYXQgaXMgZG9uZSBmcm9tIGxvb3Bfd29ya2ZuKCksIGluIHRoZSB3b3JrIGl0ZW0gY29udGV4
dC4NCj4+Pj4gU28gYWdhaW4sIG5vIGJsb2NraW5nIHZpb2xhdGlvbiB0aGF0IEkgY2FuIHNlZSBo
ZXJlLg0KPj4+PiBBcyBmYXIgYXMgSSBjYW4gdGVsbCwgdGhpcyBwYXRjaCBpcyBub3QgbmVlZGVk
Lg0KPj4+Pg0KPj4+IFRoYW5rcyBmb3IgcG9pbnRpbmcgdGhhdCBvdXQuIFNpbmNlIFJFUV9OT1dB
SVQgaXMgbm90IHZhbGlkIGluIHRoZQ0KPj4+IHdvcmtxdWV1ZSwgdGhlbiBSRVFfTk9XQUlUIGZs
YWcgbmVlZHMgdG8gYmUgY2xlYXJlZCBiZWZvcmUNCj4+PiBoYW5kaW5nIGl0IG92ZXIgdG8gd29y
a3F1ZXVlID8gaXMgdGhhdCB0aGUgcmlnaHQgaW50ZXJwcmV0YXRpb24/DQo+PiBIYXZpbmcgaXQg
Y2xlYXJlZCBkb2VzIHNlZW0gdXNlZnVsIGFzIHRoZXJlIGlzIG5vIG5lZWQgdG8gc2tpcCBibG9j
a2luZw0KPj4gb3BlcmF0aW9ucy4gIEkgZG9uJ3QgdGhpbmsgaXQgYWN0dWFsbHkgaXMgcmVxdWly
ZWQsIGp1c3QgYSBsb3QgbW9yZQ0KPj4gZWZmaWNpZW50Lg0KPiBBZ3JlZSwgaXQgZG9lc24ndCBt
YWtlIGFueSBzZW5zZSB0byBjYXJyeSB0aGUgUkVRX05PV0FJVCBpbnRvIGEgYmxvY2tpbmcNCj4g
b3V0LW9mLWxpbmUgc3VibWl0Lg0KPg0Kc2VudCBwYXRjaGVzIHdpdGggY2xlYXJpbmcgUkVRX05P
V0FJVCwgcGxlYXNlIGhhdmUgYSBsb29rLg0KDQotY2sNCg0KDQo=
