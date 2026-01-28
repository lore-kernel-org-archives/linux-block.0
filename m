Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011023.outbound.protection.outlook.com [40.107.208.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FE601D5178
	for <linux-block@vger.kernel.org>; Wed, 28 Jan 2026 00:21:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.23
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769559677; cv=fail; b=E3RbaxJBc2J1QXMajXpcPFFw+gbHJQW/wJBF2JBA1FwHzovDefiBgBYR9PMigNNqGqIZu1QzR255U4tVH14gE132RgPbU6d9/Dqoem7Dahy4pshseULOD1OL1GKXvqzUejPvIk4is0GhbizKsbpfPRL8yjvmgIYIBzREslQrC0Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769559677; c=relaxed/simple;
	bh=nvwz8exDjVltsTCkupOPOCH92G/vD2CgRjxCG2GMZoM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=LNHK3aKh4uEhD4YFzTlRMt3brGzi3iWjzsO5M8XqWdbHFTyWUV1o+CsYhLponrIjzbq29UQvX7X73eVFxbBH2ZCWLCY3jxhtr2ejocX4vlP0fY5aDdRCsidEqAvl2Nq1FKEFKsv9B4boARBSgkq1w1ypQDIYvESforyuiBgCQwo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=IEPeCvqm; arc=fail smtp.client-ip=40.107.208.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="IEPeCvqm"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=V98ErmWcR0UkuRTt60K+XwWoXZB0wfK1p+EawsUP1x9I4dg74TZIZJhiJfbsoV3JZSRcampetXePaqBeBbCzARsXZyFKh2hbWL+ekY3tBVujRWiRQLIj6vX5ZMiCoZw2BOFFRrpBbbIl+jrIpz0/SCUWJld12EqhMS2FE/QX7FZzwI4s7IqW6olCBnAPwHVA/mNn9f2tFnTgwfL3nC70IM2M8CX90ZNoLc+yynAEUXDXFcQiCR3E9Z1/ZXM1x93gAOC8vIq+gbVBE09U9pwNhych6ZVnGbDBe7ziswFWeZjl1LOV+o5tmOhMJYA56rijrrhG7Qc0jr3DuvowLDVnUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nvwz8exDjVltsTCkupOPOCH92G/vD2CgRjxCG2GMZoM=;
 b=gCM3DN0pcX9iQnNL5p6P3XE1ib1cA76eaGBr5aYC7pSFQ84E8rSUZ93Cq31XptWqaa41kiD9bp3oJUoyU+FNK7TDpcOQrsAuIukcJ3pPAprArgsgqsxF4YAuwjXiB8KNmJlzPNOR9G9e9tdsB+eO13wUbCAo/0LCZX7jb/Er42LQOrw8DS4ggvgve8EF2jRt34aaGxjyCG15umd037Q9rEHp3ejSaT2WE6Esm/vUFo5wyNHNhpdPMZNQ//aE7OwXaqfrXozckJH2skRrxl8LnEPQUjBB0WxUx2g5SjvfPamxy1AaAqnmIwACoCMNzB0GSoflGb9NiKFTk1Zrn0JC9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nvwz8exDjVltsTCkupOPOCH92G/vD2CgRjxCG2GMZoM=;
 b=IEPeCvqmkBn5bJ9UjI1DMbAud6Qg869tXO0DCvS/jOnlD9TzzFXaz1BFVJpiYh0SoI/TUGdWeOr4wZFv4USHjsmDZJXSKHJeFvmHB1cQ6rX7l6fVAuNsSAH4meEnzUHDVmV4Ssrbia/07umBa8NpXKtiAmrGlM+L2AEUxDg/8O596Y+ybIK2lECJl7y/Zspv9ZUS9o4Q8iPwRs2ct8rMml3peRFo6FNKySi/x5+q0bDSdVlJIDwKXtsSwWoRNez96XABZTbblFNMWMLjoaS68ZQKIVzdhGmCzu+uNzj6osULkeNGbgm9j6F4eU/vvCon0lu0C0LFxp84aE2K0ZkSvQ==
Received: from LV3PR12MB9404.namprd12.prod.outlook.com (2603:10b6:408:219::9)
 by SA1PR12MB8094.namprd12.prod.outlook.com (2603:10b6:806:336::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.7; Wed, 28 Jan
 2026 00:21:11 +0000
Received: from LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b]) by LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b%5]) with mapi id 15.20.9542.015; Wed, 28 Jan 2026
 00:21:10 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
CC: "haris.iqbal@ionos.com" <haris.iqbal@ionos.com>, "jinpu.wang@ionos.com"
	<jinpu.wang@ionos.com>, "yanjun.zhu@linux.dev" <yanjun.zhu@linux.dev>,
	Chaitanya Kulkarni <ckulkarnilinux@gmail.com>, "grzegorz.prajsner@ionos.com"
	<grzegorz.prajsner@ionos.com>, "axboe@kernel.dk" <axboe@kernel.dk>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>, Chaitanya
 Kulkarni <chaitanyak@nvidia.com>
Subject: Re: [PATCH] rnbd-clt: fix refcount underflow in device unmap path
Thread-Topic: [PATCH] rnbd-clt: fix refcount underflow in device unmap path
Thread-Index: AQHchBnvMmj8aOk0+kaT6bvRmUvcZbVlrtaAgAEg9wA=
Date: Wed, 28 Jan 2026 00:21:10 +0000
Message-ID: <9ddb4708-ffb0-4748-9939-9f879046041d@nvidia.com>
References: <20260112231928.68185-1-ckulkarnilinux@gmail.com>
 <aXhLQmRudk7cSAnT@shinmob>
In-Reply-To: <aXhLQmRudk7cSAnT@shinmob>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9404:EE_|SA1PR12MB8094:EE_
x-ms-office365-filtering-correlation-id: 21b5248a-a477-477d-1001-08de5e03239c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|366016|10070799003|1800799024|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?TjJtQittam5vNzZkYkJiYjFGMHB0RmZxc002SDRobVlhUzBXUldIaWVrVjNq?=
 =?utf-8?B?dlVSTGptckptMVFHTkx0dVRnOHJXME9ERFpjM0sxbFVoWUdUR0I2SCtnNkh6?=
 =?utf-8?B?cGhGMWNyd0VuQ3dreUJtMHNHZFRmUGVveXNOUXp3bmozRFhDVnVZbTJ1L08y?=
 =?utf-8?B?cWhrbXkyMm9ERGZvaDZ1TllFSklOR0ZtekhKa3JZcTVsZHpyYUI0Qmc1STRi?=
 =?utf-8?B?d3EyblRwdGg1ZEtxRm9mOXkzK2s1ck1lVEtFQ1ZqK1hjOVBnVEs0dVBHRjR0?=
 =?utf-8?B?TkpVbnNSek9relV1N3pSNUJiTVFlT2luOFlBNXdrcWIyWDEwTkxHY2U3U0F6?=
 =?utf-8?B?UWxacGhsRTd1ZG5JcHBRMTl6MTl6NmxoSnFRNnlRZW9UYll0cTdFODVVbkpD?=
 =?utf-8?B?WHpsQlEwZ2t5aWZLbUJWUDBoSlFXdEE2RzZnb0ZLd1lvZVVRUkZETU9DS0Zl?=
 =?utf-8?B?cEUyamFUZ2NGN3l2WUV6QmRhZmFDcU1zeHFmR2N3NHd2a2tqSkdQZTRPeUpY?=
 =?utf-8?B?YStqeHlwTmRPS0I3elYrTkZQdDVlUmpRSUhXdEg3NUZmY1cxdm1QQ0VWTVAz?=
 =?utf-8?B?Z1ZVR3RBaGF6ZGQ1akJLNjd3WjBoM1lsWmQ2TkhZSDZkTmtEY1A5ZjcrMUYx?=
 =?utf-8?B?ZGhDVHNxMmhEbXgvblRXVmIyeXB0eG84N2F2NVdXV09MbktyS2d1MnBuaVp3?=
 =?utf-8?B?OWlHV2FpNlpIbmlQUTUwVWs1TUNVaC9QK1AvcVJxcVFtNTRFTDZiem5DZmVJ?=
 =?utf-8?B?S2pOQytUdFd5cHZhTzM2U2gvYWoxNFVVc3lCSkE2N1dZcEhIbVJsckZFNyta?=
 =?utf-8?B?ak9Bc2pQbkZWcis4WDJvY3RYZy9sdHpXQmQzQmFsd1pxTmptbGxtNTkvY0pD?=
 =?utf-8?B?YjE5WFkrVzVrNURUckdsU1NaR2RsdnZWRmk1MC9zWExFdER4KzVhWXZscXRG?=
 =?utf-8?B?NUdzRHAxV09UUkVyRjJjcnJDN0ZJQ0RZZTZiTjlXN0c3MUN2ZmcwTC93MXRD?=
 =?utf-8?B?aG95aUk0QXg2T2haRVJ1cHBSVkt6Rk5Ibm1TdTZVMVBOVldRVHl0MHFMNmdC?=
 =?utf-8?B?SWlHNklNOUp5T1NZSm03ejZKLzEvWDQ3bzR2THpjakFRRFZhM1ppZTMyU3Zt?=
 =?utf-8?B?b1NQVWY2YWVWUS9TOVN6em5rZ2NsbmswOVQvOGVLemQ4dTcwVlJsdHlpVlpJ?=
 =?utf-8?B?b2RmaHhhMVNmNmJuSHFHVVh1OER5dXFrR085RlpwQzFaT2grTUw0MEEwaUlk?=
 =?utf-8?B?SStIa3pWdE00bzRhM2FGOFR4cE9UVXIxeHNoeXJWajNTTXJDYVlVTS9Jbmth?=
 =?utf-8?B?dlEwRUYzMGkva0duOWRKOFJQb09pVklMTnJHSmZpeEVVdHZlYjVTcnhXUGI0?=
 =?utf-8?B?SlRNVTYxSUhiclZnTnJTNUtoSGZKSE84Qjl1QTM5S0lZeU1wRVo2V3dpcXE2?=
 =?utf-8?B?S3ZvcW9FQnd4UExGaFU4b2poSFcrNkJ4SzN0RnV3alh2TWp2VTV5c3U3UHVk?=
 =?utf-8?B?amdVVVpESUhTYjByOVVpN281Qnk1RDFPbzhrdGVpeGMyblFpdXB3RUFjWXd3?=
 =?utf-8?B?dGd0L2JYbi96MUNEaU1KdXFrL0d0KzM3YUVzYVFUZDlWS2ppY01vUzJYV2gv?=
 =?utf-8?B?MEwySkFKRkFRVFFYc2grcVhPNXhNQ3NuR0ErMkVoT0dwVDNxWHR0UklxbE12?=
 =?utf-8?B?RHJIOUlmOFhGUG5MaDRKbHFZTk9GTE5iQW9NcC9sTnFKZ1BtTWVTWlFxc1hH?=
 =?utf-8?B?R3BqSUkyYmFOdVg1U3pDeVlEcURYaXJ3MVFYSUtQbldjaUszWjlIbEFtdEl0?=
 =?utf-8?B?S0RMdEh4WVFBRnNDdmNxRnVQbTJ6emZxcmFpRzRGMEZhRTFGSEFCYnp5MDFn?=
 =?utf-8?B?TnZwcTVhYUFDa1hOMS9DVmxqREgxQWliRzVuVVBrVGVCeFo2YVRjZjRYYzM0?=
 =?utf-8?B?ZXZ1Z1IrQ2MrakFMQVFPTm8vVmhEUkxvSGFjOGtLV215MGxDY3RObnl0TlpC?=
 =?utf-8?B?TysxVERJZEhnaDJWeXpLL1l1cWFveDZ2K0pMdzRSYm1nR1FtYmF6WUFSbHBB?=
 =?utf-8?B?d1FUTEtscEZhSHJGT0FsUTgzekhYZU1RR2NSYXg2eW4zV1NIZmpsMjc1RDRF?=
 =?utf-8?B?aDlrMkJVZlQ2NDJMeTdhQktoVVNxbTd4YThuelhhbDdWT01uZG9oSVpHTHND?=
 =?utf-8?Q?gJGCL+DZ59oWEUpulh+jljY=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9404.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(10070799003)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?MkhFS2djQkM1bTZRbmZCVWY1cUZPTll2T2lOYWUycnpZT2o4VENGdWhEVm9W?=
 =?utf-8?B?cFJHdnFOaGZldTFuVHVZZFR3MmpYNmYxM0ZRbEJhaEFId1Q3ZE5oaWYwNDlQ?=
 =?utf-8?B?WHNIV2FxdG9WbUcrbzBpeCs5aWFEQTZ1eEdyOEwwLzZscTlCYjFROGUvN1Ba?=
 =?utf-8?B?VTRRQzRKVWorKzFQdEUvWmF2bWp0SnpONlZOZHZHTHZQWDl4eUdXR0ZaZUJm?=
 =?utf-8?B?OC9iS0phN1ExNEhhTGY4WklhVHptNWZ0a1ZMNzUyemdoQ0UvNW1HSFZCVlJ2?=
 =?utf-8?B?dDZJZG9LaXZsRDl0aUdmOG1RMUFSUjRLd0pwOC9qZ3NMT2tWc1FqZkZnK2Nn?=
 =?utf-8?B?R0FzRmNTNWNpUXBKci81QTQxWCt0VmJ3czlHZmQ0RENianJ0cWd5OE1FOUtM?=
 =?utf-8?B?Mm9hOERNMFJ4S1JKOEFiNXhGWGpHMnVRVkJqSmRGem9NUE9aamU0dXByN0VJ?=
 =?utf-8?B?M2QvTXhWTEIxd0UyYmtUVjBQOXNYaXJsejB1SmpaV3hQR1l5NlJGaTJkQkhU?=
 =?utf-8?B?TTdCTkEreCs3U1Z3MDVrK2dNampqRTlhWjZCOTNwWUdFMFA0WFFvN1lVOGo0?=
 =?utf-8?B?dmpyeGU3TVdDVk9GVnhkZnVwUTg0RlYyNTdXM21nTDNDZUpzRHAvL3JDbXlo?=
 =?utf-8?B?Um1kenpKcVQya3d0dVY0ZVlSanZTMXgxeUIydDlCcmo2N3poc3pQLzh0a0Fn?=
 =?utf-8?B?NTVmOXVjV0FyZndRM214MXl2MHdNeXpLOEEwS29kbmJuMFhZMk9QdGtIWDc2?=
 =?utf-8?B?dEdpL0VnMEhldG9UWXhDYmVuVUE4WVlVUHFKNkU5UE5NWjZ4L0RjS1NxbzEw?=
 =?utf-8?B?L3AzY3g5MDJ1TStMbGRuM2FTbmpNYjZOSlExZTZVNTJGOGoyc0tqeDdFdVlI?=
 =?utf-8?B?ejNsaC9HSm53bHorV3Ayc3lSL3RGdk9lUUQ0eFY0blpuTlQrcXdHcUxqMmhL?=
 =?utf-8?B?VUFnVlhGVzJiWHlDOWorTTJoZTJCSVBRYU5sOVFlTk10SVRrQ09EdFhZMmIy?=
 =?utf-8?B?bCt2MXZ5ZDBuY09QbzE5QUpxS09hRktnSStHMnlRV2d5Y2FFSkcrSkViQW9u?=
 =?utf-8?B?S2hiUHJ5bXB3aVRoVzY1ZnJIeHNEb3dNS0ErV3VodHk0cEZXVDVJdS93Uk1B?=
 =?utf-8?B?M20vTWNyZGsyQmtadEIvQnkweFVFbmw5Y1ZEQUE5ZVhBOWordTlXdjYrS3J3?=
 =?utf-8?B?NlExVEJoZVA3VTUyeWsrNElRYmlmV3A4L2VnZnhpOEF3YXIyZzVCaUxYcUVw?=
 =?utf-8?B?RzdyQUYrS2xNT0VVMW1SN3RhZ1N3cFlteTBTdkEza1JET3NTbUhRZkJVRGdm?=
 =?utf-8?B?b243QVQyVXNuR2lXUmtJRitlbnNxdHhUVG9sWUJPYmsrVi9nZ2owMWllNU9Q?=
 =?utf-8?B?MHF1bTdEVW41SGNWY1JJVlg1NS8vWFFlNytFVXpCYm9wdWl3Y2VuaStJdk44?=
 =?utf-8?B?WnVFSXZHRy9oZlRzVTZHZ2RvKzNZQ1JPb1UycEVLNzRzV05yT1NibHhKUVN5?=
 =?utf-8?B?YzE4ZldSdEtlMHZsQmIwd043L0JQSXFodC91YU53MktsaXFTcnhUbm04YWZh?=
 =?utf-8?B?RWtSY3RnTlhrejA4REsyZUxSQVNVVFlteXo4cE9nUEtnT1hza2pEK01ISWQw?=
 =?utf-8?B?NS82RXcrOU04NTdsV2NSeVFIWVJVTWR6RUJXVldLeVVQK0Z2cUpUY3pMancx?=
 =?utf-8?B?U3NCbTJLR21Qcmd3L0UxT01ZbnFJaFpON3pEVFZwZ29OOUl0OHdyK3Y2cS8z?=
 =?utf-8?B?aG50bmtpZ1VqVHV2VkxDa1ZyZ3JiNjhxWU92bXAwUys3d2dhdWxPSm40eklv?=
 =?utf-8?B?R3g5S0x1VUJYbGl3YnI1amVjaldJd0JsejA2bkppeVo0aWNMc0FIUkM2SHJZ?=
 =?utf-8?B?a3Z0Y05ZSVJxMnlnSUM0aWN2TGp5TzJ6VjAyWEtnUTl5MHJhKy9lb0hlaTA1?=
 =?utf-8?B?cVRmUEFPanUzUDFRWmpQeW50YS9BNHlwb2tiM0NEOXRGczBkTlI5cFBOVFln?=
 =?utf-8?B?T3RRS1N5NDdFRUpObExVVlNCQ2h0U1dkaUdDQW1FaTdBcDZOR0lkMUo3dmVh?=
 =?utf-8?B?YXVKRHl1LzBOa3RkZ1VhK2VWOHh4TVliNXRUQXhRLzBWdmxZTmRFMmN1cGJ6?=
 =?utf-8?B?Wk1CYzF4NVQ0aWhOWHU2Sno1LzBsQXBPQjlUNXZhVkUyNFd2MG1ZNG9TSzFa?=
 =?utf-8?B?V3RrTk42L0d6dElHT2NMcit2RHgrbFdSdFpBeE5kbmdLNHJ5YU9PcG00R2Rz?=
 =?utf-8?B?aklvWGViQ0toSDRDL2JndzJTazR3SmZNeFZmV2I0ZXlsRWFxbDV3dU1FbmVl?=
 =?utf-8?B?TDQ3bTg3TURQZWtiazNza3lCeEYxYlFFQ3dvaHRuQTBkVFd0bTE3MFhXazls?=
 =?utf-8?Q?T8nc2GQKQms3l+yoanWljCKIJ4WzdraVh5asPIQAkn6fM?=
x-ms-exchange-antispam-messagedata-1: tGEmBsLowoWjuw==
Content-Type: text/plain; charset="utf-8"
Content-ID: <8D79F7B2B17B8444AD580E2213A328E0@namprd12.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 21b5248a-a477-477d-1001-08de5e03239c
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jan 2026 00:21:10.8324
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: S04ZicDvOrXmoVN8lDhg1PWql9RqVx3tqplCHACwaeybb/XrV8PnV6bvKs27voq2mRomfDU2FaEr7CJEn+T3Ug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8094

T24gMS8yNi8yNiAyMzowNiwgU2hpbmljaGlybyBLYXdhc2FraSB3cm90ZToNCj4gSGFyaXMgYW5k
IEplbnMsDQo+DQo+IEkgc3VnZ2VzdCB0byBwaWNrIHVwIDU4MWNmODMzY2FjNCAoImJsb2NrOiBy
bmJkOiBhZGQgLnJlbGVhc2UgdG8NCj4gcm5iZF9kZXZfa3R5cGUiKSB0byB2Ni4xOS1yYzggdG8g
Zml4IHRoZSBrbWVtbGVhayBpc3N1ZSBvbiB0aGUgTGludXMgbWFzdGVyDQo+IGJyYW5jaC4gSSBh
cHBsaWVkIDU4MWNmODMzY2FjNCBvbiB0b3Agb2YgdjYuMTgtcmM3IGtlcm5lbCwgYW5kIGNvbmZp
cm1lZCB0aGUNCj4ga21lbWxlYWsgZmFpbHVyZSBkaXNhcHBlYXJzLg0KDQpUaGFua3MgeW91IFNo
aW5pY2hpcm8gZm9yIGRldGFpbGVkIGFuYWx5c2lzLiBQbGVhc2UgbGV0IG1lIGtub3cgaWYgdGhl
cmUgDQppcyBhbnl0aGluZyBJIGNhbiBkby4gLWNrDQoNCg==
