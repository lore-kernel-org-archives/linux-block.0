Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010033.outbound.protection.outlook.com [52.101.201.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9167242D9B
	for <linux-block@vger.kernel.org>; Wed, 12 Nov 2025 04:11:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.33
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762920680; cv=fail; b=cN3M87rsQrn0R3B6lOjWlmzNIcf3qkbg9ZbDu8Bwp3D2CojgR9ONu3CbBHTUQesyRXUQ3XbDZ2pw6A/Js2cw6IM0AbIWiD7BjytoVLCtX4H6jrxGl+TDVmKUqcW5Y+W5Jx/8Rg7mc336ibN370Uk8Jgd6MldmVlZ0Z80L/uDe9c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762920680; c=relaxed/simple;
	bh=uqJgr8wAXECVVWnwI7Oqpwmr36yIoPTJeTM3yNFryfs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=eP3uMfnY7RnMCItAXPTp02sknPlBGR3IfnCMAgjdqosOb/68lHeS7MsulnKIvyuF8luE5+fYhC+qxu4zd61jl3819uysBZkSTXKe9U11ch7nJZ2DGN6YhCM+oWLdsfFp2ujMWJNsDKIqEJPlMHSF0LA37jvjXquYMNCAxrr7Ims=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=pzgUr26m; arc=fail smtp.client-ip=52.101.201.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="pzgUr26m"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oM4s8omwn28nyXbUFUMCJuEucFy7gsSj0yLFCWUZGxoWogls41eMB/E2qo0eqDIMwSBBP4KjTbtqc5ezZc19kvZWjFnvaxdgR76Jbxl2U40Ba98ALVOGfcvu9LUOqf+UrQGv09O+HXQ9iVGOJotatLyvFHyRDr2TdjbxE3r5OnTiznS99xNTtfLdvmjG9j2BeM3kLVGkgoLktN0HRY53iOiRnfzvWskPCOmGT5Ge8woUcqxH+pAqrnQnMpiA56RugPif0T91aPicgrlxKqVcLo4cbldIU3nz9eSIX9A57hHynZXCuA1sXlGo2V0TcjZ/89WvQ772R7q6EnWHY74+Xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uqJgr8wAXECVVWnwI7Oqpwmr36yIoPTJeTM3yNFryfs=;
 b=pESBkpXKO1rPHkeALjBTnCzbfc92t7B9o4Sg1VxM4OileOAFW2Z0ORzGmTzx5EhtcHRUZ4TJLA3lNygmcibdGlZwfTB7rmeemIuRDxxp6i+u7EMemRI1EnZCwlLLTZ4XFLS2WSLbwtHZ6EGHPRLdjzq5DHc1fMMp7w+WknStd4bqpfkMZQEMCQ4tNh4wDWPVMIrOHlauq2P/Ap01WaQYP+lM3I2Sl3Sk89YszUWxQ78J7SVIHLmg4qVETk/qpdgCF2CAE4VpiwiVR9WXxFOmZRHd5dyBFHzO/mxXFAT95UygiHVOqtSuQeQgukcM2am2FnKAaAEMhQirAkKDFFJPuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uqJgr8wAXECVVWnwI7Oqpwmr36yIoPTJeTM3yNFryfs=;
 b=pzgUr26mpoMImve4YSQvRQxC369XbRO7FMItIfjeuradM99YzOtWf1xZU7X4pAbiUjuImXvd591sfKtkdrw7B/CTsG4JrZLM8hfe5jTB8QOgD4pQSct1P8sxR15qmM7gEOcP0fZQmSMXefwNarWSfZMmhZhJxX9MUS/7IyPpbElN2sESKtX58Yg5JClPBqfW9Qnzrdbuh82DwJAmHmKcA9Rwvh4Iq33CjwJ/8M/gr7fUPnXui65Nwa7ciyu8ENpMrszqmhDZbIgegd2RMZWhiK7uVczZy0QkIlWUjuzGskHahEbHu2YFaL/5n2wWTXCXn6b6/Iz/v5L6jSgTzj+z7w==
Received: from LV3PR12MB9404.namprd12.prod.outlook.com (2603:10b6:408:219::9)
 by DM4PR12MB7670.namprd12.prod.outlook.com (2603:10b6:8:105::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.15; Wed, 12 Nov
 2025 04:11:15 +0000
Received: from LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b]) by LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b%5]) with mapi id 15.20.9298.015; Wed, 12 Nov 2025
 04:11:15 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Keith Busch <kbusch@kernel.org>
CC: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>, "hch@lst.de"
	<hch@lst.de>, Chaitanya Kulkarni <chaitanyak@nvidia.com>, "axboe@kernel.dk"
	<axboe@kernel.dk>, "dlemoal@kernel.org" <dlemoal@kernel.org>, Chaitanya
 Kulkarni <ckulkarnilinux@gmail.com>, Ming Lei <ming.lei@redhat.com>
Subject: Re: [PATCH V2] blk-mq: add blk_rq_nr_bvec() helper
Thread-Topic: [PATCH V2] blk-mq: add blk_rq_nr_bvec() helper
Thread-Index: AQHcU2IiEOCHpn1A8EelxJPvuVBn2rTuXHSAgAARjQA=
Date: Wed, 12 Nov 2025 04:11:15 +0000
Message-ID: <efb44fe0-6d2e-4c91-be68-a30b53ebdbf2@nvidia.com>
References: <20251111232252.24941-1-ckulkarnilinux@gmail.com>
 <aRP6KdADdbnhwwrj@kbusch-mbp>
In-Reply-To: <aRP6KdADdbnhwwrj@kbusch-mbp>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9404:EE_|DM4PR12MB7670:EE_
x-ms-office365-filtering-correlation-id: a62923a9-a940-4845-1aa5-08de21a185e7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|10070799003|376014|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?TVlSNHZpRnlMZ085SWRDQnBkN0tITTA4OGFiS3JvVzRrLy9DMTFzRVAvOGk3?=
 =?utf-8?B?dmZFa2xZb0g1ZGJQUEIwMDcxZTFibnhJTGpYWjVPYlo3QWQwdmhvOXJHek1j?=
 =?utf-8?B?aTRrdktZOWxxUFhWcDR0MlBydkdOclljRzV2a3hEaFhnMDlRSnczalo5NUU1?=
 =?utf-8?B?Um9La0JGUXZJZk5QTTh4VkZOdXQ5V2NCVjgwM0xOdDJOU29EUFRSZjBKWVRF?=
 =?utf-8?B?bk15cDBIV0V2cGNLcDF3K09va1hjNVVNZkJvOHVUWjFkeGptTVlWRWtWQWRB?=
 =?utf-8?B?ZkNRK2Q2Mm40QUR4UTBQMTNNQ1dGNjROYTR3dFNybkJ5Mmp3UU1IWGhZMkhD?=
 =?utf-8?B?VHk1Y1dkVFhyMGdpVnpzV0VWcWxPdkJ1ZlU2dENSN1hXbWExK3F0Q1cxeDlQ?=
 =?utf-8?B?VkNLTXpSa3VNcXV3SlhJb1NKdUlCbkVrZER4QStxU25XVU1nRmlWa0VYR0NQ?=
 =?utf-8?B?K1U2R0k5NGI2Q0lrK0I2Sk84Zmk2aTZPbFFZaWpaOE8zRExrZ0IxeHd0U2Jq?=
 =?utf-8?B?KzdhMmFoUmxndzd6NDNMWEs0YUdZMGF5VUc2YWtMMDZ2N0FocUpRT3g3UERI?=
 =?utf-8?B?aTdTeGdvamw4WXJoMHhnQUI3alhXYnRqUUVLUXA5SEFIdkZZUHhWUFB2M0hL?=
 =?utf-8?B?MVlBVExWU3hla1hPalhxTWliTzJwa2M1U1FSOGRtc1ZLdzRmU0FoRmVzT0Vi?=
 =?utf-8?B?UTNLdk10NUhYaVUwMER4STdZKzFUMDRvNElhS3YxN0phcXlDZlh6c29hMmtE?=
 =?utf-8?B?N1BMblE1UW5tSFJMQjVMMkU5YjF6MTJmeDJlS1pjS1hhMWg0MjNSd0dmdmtX?=
 =?utf-8?B?KzNsaVE4cVd6RjVseFBocVBNdnJBOEl2V2lidDhhSDFBSnU0aUZhdzFRdmps?=
 =?utf-8?B?Nk9QTWRRZzVvdW5jYUF3bHVwV0tqekpiblEyV1pJQkV6WHdvN3JDL1dxeDdi?=
 =?utf-8?B?Q0hlMEhmUTFkelpUQSsvVFpzTG5zQWdKMjhERGNBdW1oQ2RsUHQ2enBGUzBy?=
 =?utf-8?B?VW40cTRKZ0pXaURMa2xCN3ZRNUppbWhzSklhMnp1ejlheDF6MmtWQmV2UldU?=
 =?utf-8?B?Vk96MDR6Sk5qNzVrUmhDVjlGTXd1ZmN3V04rUGduUmZYdE5XcFIwdmswY1ZF?=
 =?utf-8?B?WmhzVUJUbkpHamtxelN0S1ZqNFBVUjV1SlFpTjNLZC8rQ3JtczJ0b0VtV3ZR?=
 =?utf-8?B?dG1Ed3ZlcS9zYnlFVHF3TC9qRjBYVm9Ibm50ODRLSFR0ZVZBZ3VldFNzaVRi?=
 =?utf-8?B?ZVV5MTFOQ3AzU255NFJBSFVNOFNKendQTTRDU01xTkVHVFdqZThUdUpJeVNK?=
 =?utf-8?B?TWxocG1SbEpGZDB3QnZyTFVyQWpiK0t1UEgrTFcyUzJPc3ZrMlJieHErRGsw?=
 =?utf-8?B?VXJMU0R0bXVmek5GL0tBVkJackJ0ZHFlSkhLak1RVzF2SWRZOWZaUEtyUlp2?=
 =?utf-8?B?ek1ESXczWVI3T3Rodm9TNzRSWGwrdEl0cTRVL3NOTUlkZXp5allodWEycnlu?=
 =?utf-8?B?VzFPb0Qzdm15UGZBUkxMM21GTG4rYWlRSGpBeFJscHJHY2hIZ3lyekp0Visr?=
 =?utf-8?B?RkVQTUVrT2FmWUFDbHE3dS9ibkJabk5xRzZWVjYwaGlORlJWS0NEUFJ1cVJB?=
 =?utf-8?B?a1BhS3ovWUI4dzlROGtaN3VWYk1JZW50R1hxcXJpNVljK2c5YU1ERmdzWFZI?=
 =?utf-8?B?cFk1VVpZYm5YeHFUaThVeE1pQzUrdUNYeTMzRndPWW5TcTVFem5LL25LYm44?=
 =?utf-8?B?NEdOV2lGd1dJRXNXK2UyNklQRWRsMjFEUDc5ZldqUmlkdlJJU3VkbytRVDYr?=
 =?utf-8?B?YWZYZm8rVytCTDVCblZRNXZDMVdzbVVReUN3NTIwSW9rZGV1U3JPaVczcWZV?=
 =?utf-8?B?WUpaMzVaQnpXcVVaOGdoK3JxZDNUQkMrVW5Tb0F5ZmZUbXFRTVRINDVDZGd6?=
 =?utf-8?B?d0ZsdGdRMlE3SnErb2pVTGxxQ1VDbmd2S2JyMkwxb0ZFS3hFSmc1eE4xY1Q5?=
 =?utf-8?B?ZzFya1ZUOFVZMUdrQ2JtTy9LdjFadE1YTmVyWUw5cnZZZUR0OFlXZlhmQVVM?=
 =?utf-8?Q?D2bOA2?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9404.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(10070799003)(376014)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?d2JBMlZDSUZRQ0ZicDZ5KzYwZlBQaFI3Y3RRZ0J1Ny8yejB3RktCN210ZWJx?=
 =?utf-8?B?K254YndOcTB0RlVVNjFVeG1CMm8zTUFvSXltU1R1dGp2dWhyMTVod1dhM2Fh?=
 =?utf-8?B?Qk51RHlueDhmRWlWOHg0MzNldm9NWFpScStEMmpjaXBvbHptVVdHOXpiMDNK?=
 =?utf-8?B?aWV0LzROTzR1VnlSRkRaZkxTaUV0U0w5L3NJaEFtdVI0aFEwU1hDSFlvaXlm?=
 =?utf-8?B?SElmY3pMVG96WlkzQW9PSGc0QWQ0dVZVQ3ZTRlkzckJGNHh6QjJqTzJJcmpO?=
 =?utf-8?B?Y3l4QjhFRTF0Wi85WFp1eGdham4vbndJK2k5RUpFZ0VEQWQ5WVpyWHBabHh1?=
 =?utf-8?B?c1pKQW45eEh4cXBrZW40YjBnbkNITEJYMVYvdVp2WGYvdks0Mm91MG03VzNy?=
 =?utf-8?B?TlovM0J1WWVwK2JNMDZSN1lveFV0WjFSOEpFVllDcS8wQmVHNEpPZ08rdXZD?=
 =?utf-8?B?T3E3eHFCNjVXTUhIa2tpdVlOc1J5NXVoamt3R0ptbkNYVXA5b2EzNmJrUzhn?=
 =?utf-8?B?QlAybTNDS3ZhMm5GMjVNNFRnZXlVUDh2U1N0KzBJSCtUZzlTMld0Z1lXQnpW?=
 =?utf-8?B?SWhJb2VqSHNDSjlBeStNQy95aTJWM00zZkFUZEJmaFBxbE1VSE5WTVNFTWJT?=
 =?utf-8?B?VXJVbjVmK0ljdWlxMnhjNWllblRYZ280dzJTZjB5TmhFYkRwQkthMXdRUE9m?=
 =?utf-8?B?V082N0t3YjFNYW5wMWxvYVZNOHZWWTZ2UzBQSHdsaTR0SjJCUnRURy9vRlV1?=
 =?utf-8?B?dWtUa1QvUVU4OUhIUVU3NjY1ZU93VUlYV0xmK3VWNk0zVGhnWnhpblExOC94?=
 =?utf-8?B?WXJFeE9nWXZUWjdSRS9wOUJ6aE1ObVY0WmxMNStqREtVZlZHT3JKMnh4WUpl?=
 =?utf-8?B?UFluT3h6ZWo4cjJwdmFTdnhJSzhyYy95T2xITXl1UEl1R2grc0FjNVJUa2Qv?=
 =?utf-8?B?RGdnSEt5aGhDWUczKzBCbUoycHJMZlBPNjZ2emd5UWIxWTBiL3pXVFRWenAr?=
 =?utf-8?B?ZjdLMU5VRHBIcWI0YlJLN0plUWFOcU1oZmFkNlB5aEJXajV4NmF3anp6Z05a?=
 =?utf-8?B?WHZHRHlrRitZMmc4RU5QMUt6cFVvQzRUTFR3ZkZQbzYyUTIxWDRPa1JSWVI3?=
 =?utf-8?B?UjN6eGUxQXRKVEtieUFEanNJOWVqYkxmcTdKS0xEbjEzZXU5TmVJZ2E2T1Av?=
 =?utf-8?B?N1BTTjBab2VSV081UzdvR3l4QmxEeGRqbGNWdkpnSk13dDZ5Q3o4bjcvTnFV?=
 =?utf-8?B?aUc0Z1JDV3FBZVJsWHNSaFc1eVpuZ3VNbitxSnNJUE5mVmhmQWFyUFlZSVRX?=
 =?utf-8?B?VFlHTC92clBjUGQ5MTF3SHJybWVLWWpyZWMydUVkaENxUVg5NmRHZEFnVVoz?=
 =?utf-8?B?a3ZpREZLTVlqYkdOSUhERmpneHI1bFRGaG9JRHJHYUNhMzdZZkpkbEIvWlBD?=
 =?utf-8?B?N0xFRTUvNW5VU0VSSTY4R1BoSVhwWTBSMFJOWTlhTjFEclVtVG1IbW1XZGlD?=
 =?utf-8?B?a1gvQmVYVmNsZlg4eG51dDNxYk15UFBjU3ZlUG5HRDV0OVBBN1Zya1dGSm9U?=
 =?utf-8?B?WmNLSWNrSUlZZzUzOEY4aEd1aWxYZXYyNjFreEwzSFdBUkdNT1NEbDk4ek1p?=
 =?utf-8?B?UFJhakNxQUlaZHdiY1ZHU0dYam9NT3hNZk80M1c1UlM3cjMyNE5vZy9yS3hE?=
 =?utf-8?B?MDdtSng4ZmNjc3hPemRkZEdyamhQc0xTdHI3SDJvdDV6V0l2M0xYRWtwNXBH?=
 =?utf-8?B?UVEwUkFpOUpMTkdmdWMwc2V0UjA5Q09valRaMFI5NFl4ZHpOM0gwbTRUSjRr?=
 =?utf-8?B?bGlPeUVTeE54SjIxWFlVUWx6ZEJqek44WW9tTmkzb0w5SUkvYjlZWE85NUUw?=
 =?utf-8?B?Y095RTU0RlA3cTZuMkE3SG9rYjAyOGU0VjVObHZubCtNQ2xFaExFdDArZ0da?=
 =?utf-8?B?dy9VUXhrSHZkMUZuMmtIK3FtQUE3ajJDVDRQKzlQUUJ5bE9LWFI2Y083Zm5T?=
 =?utf-8?B?R25jQzhaYStucjBnWUpFMENPSFlDeFZaR21oS3M0d25ic2V1WGt0amhBM3lz?=
 =?utf-8?B?UWtYUTEvWW9Hc2x1UnNJTWwydDhEaS94aEg3c0ErYWZpam1XcFJTWXhtV2dx?=
 =?utf-8?B?RG1pMGMva0xPZTArUTZrVERtMWwrZGlzdUdpTjBHU1pMY3RtS1F0MGFWV0gw?=
 =?utf-8?Q?lTkMLwOQHX98FMMh7WOIdBDY6tJ0bLyu9GcnmWHuUlRC?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <BF601C06688A33469E6A0EE9FDBCDFE7@namprd12.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: a62923a9-a940-4845-1aa5-08de21a185e7
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Nov 2025 04:11:15.2699
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MKcR1A3Dyr79jglXVlc8eLJrIA3P8CGYuwZRhlTJikPIwhzR+SrmM9buBrxmBHkNhIozTm/6PMdQim2lbqbHBQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7670

T24gMTEvMTEvMjUgMTk6MDgsIEtlaXRoIEJ1c2NoIHdyb3RlOg0KPiBPbiBUdWUsIE5vdiAxMSwg
MjAyNSBhdCAwMzoyMjo1MlBNIC0wODAwLCBDaGFpdGFueWEgS3Vsa2Fybmkgd3JvdGU6DQo+PiBU
aGlzIHBhdGNoIGFsc28gcHJvdmlkZXMgYSBjbGVhciBBUEkgdG8gYXZvaWQgYW55IHBvdGVudGlh
bCBtaXN1c2Ugb2YNCj4+IGJsa19ucl9waHlzX3NlZ21lbnRzKCkgZm9yIGNhbGN1bGF0aW5nIHRo
ZSBidmVjcyBzaW5jZSwgb25lIGJ2ZWMgY2FuDQo+PiBoYXZlIG1vcmUgdGhhbiBvbmUgc2VnbWVu
dHMgYW5kIHVzZSBvZiBibGtfbnJfcGh5c19zZWdtZW50cygpIGNhbg0KPj4gbGVhZCB0byBleHRy
YSBtZW1vcnkgYWxsb2NhdGlvbiA6LQ0KPiBQZXJoYXBzIGJsa19ucl9waHlzX3NlZ21lbnRzIGlz
IG1pc25hbWVkIGFzIGl0IHJlcHJlc2VudHMgZGV2aWNlDQo+IHNlZ21lbnRzLCBub3QgcGh5c2lj
YWwgaG9zdCBtZW1vcnkgc2VnbWVudHMuIEluc3RlYWQgb2YgcmV3YWxraW5nIHRvDQo+IGNhbGN1
bGF0ZSBwaHlzaWNhbCBzZWdtZW50cywgbWF5YmUganVzdCBpbnRyb2R1Y2UgYSBuZXcgZmllbGQg
aW50byB0aGUNCj4gcmVxdWVzdCBzbyB0aGF0IHdlIGNhbiBzYXZlIGJvdGggdGhlIHBoeXNpY2Fs
IGFuZCBkZXZpY2Ugc2VnbWVudHMgdG8NCj4gYXZvaWQgaGF2aW5nIHRvIHJlcGVhdGVkbHkgcmV3
YWxrIHRoZSBzYW1lIGxpc3QuIFRoZXJlIGlzIGFuIG9uZ29pbmcNCj4gZWZmb3J0IHRvIGF2b2lk
IHN1Y2ggcmVwZWF0ZWQgd29yay4NCg0KSSBsaWtlIHRoZSBpZGVhLCBob3cgYWJvdXQgc29tZXRo
aW5nIGxpa2UgdGhpcyBvbiB0aGUgdG9wIG9mIHRoaXMgcGF0Y2guDQoNClRvdGFsbHkgdW50ZXN0
ZWQsIGluY29tcGxldGUsIG9ubHkgZ29vZCBmb3IgY29uY2VwdHVhbCBkaXNjdXNzaW9uIDotDQoN
CiAgYmxvY2svYmxrLW1lcmdlLmMgICAgICB8IDEwICsrKysrKysrLS0NCiAgYmxvY2svYmxrLW1x
LmMgICAgICAgICB8ICAyICsrDQogIGluY2x1ZGUvbGludXgvYmxrLW1xLmggfCAxMyArKystLS0t
LS0tLS0tDQogIDMgZmlsZXMgY2hhbmdlZCwgMTMgaW5zZXJ0aW9ucygrKSwgMTIgZGVsZXRpb25z
KC0pDQoNCmRpZmYgLS1naXQgYS9ibG9jay9ibGstbWVyZ2UuYyBiL2Jsb2NrL2Jsay1tZXJnZS5j
DQppbmRleCBjNDdkMTg1ODdhMGIuLjQwYjdiYTNiNjIxNiAxMDA2NDQNCi0tLSBhL2Jsb2NrL2Js
ay1tZXJnZS5jDQorKysgYi9ibG9jay9ibGstbWVyZ2UuYw0KQEAgLTQ1OCw2ICs0NTgsNyBAQCBF
WFBPUlRfU1lNQk9MKGJpb19zcGxpdF90b19saW1pdHMpOw0KICB1bnNpZ25lZCBpbnQgYmxrX3Jl
Y2FsY19ycV9zZWdtZW50cyhzdHJ1Y3QgcmVxdWVzdCAqcnEpDQogIHsNCiAgCXVuc2lnbmVkIGlu
dCBucl9waHlzX3NlZ3MgPSAwOw0KKwl1bnNpZ25lZCBpbnQgbnJfYnZlY3MgPSAwOw0KICAJdW5z
aWduZWQgaW50IGJ5dGVzID0gMDsNCiAgCXN0cnVjdCByZXFfaXRlcmF0b3IgaXRlcjsNCiAgCXN0
cnVjdCBiaW9fdmVjIGJ2Ow0KQEAgLTQ4Miw5ICs0ODMsMTIgQEAgdW5zaWduZWQgaW50IGJsa19y
ZWNhbGNfcnFfc2VnbWVudHMoc3RydWN0IHJlcXVlc3QgKnJxKQ0KICAJCWJyZWFrOw0KICAJfQ0K
DQotCXJxX2Zvcl9lYWNoX2J2ZWMoYnYsIHJxLCBpdGVyKQ0KKwlycV9mb3JfZWFjaF9idmVjKGJ2
LCBycSwgaXRlcikgew0KICAJCWJ2ZWNfc3BsaXRfc2VncygmcnEtPnEtPmxpbWl0cywgJmJ2LCAm
bnJfcGh5c19zZWdzLCAmYnl0ZXMsDQogIAkJCQlVSU5UX01BWCwgVUlOVF9NQVgpOw0KKwkJbnJf
YnZlY3MrKzsNCisJfQ0KKwlycS0+bnJfYnZlY3MgPSBucl9idmVjczsNCiAgCXJldHVybiBucl9w
aHlzX3NlZ3M7DQogIH0NCg0KQEAgLTUzMSw2ICs1MzUsNyBAQCBzdGF0aWMgaW5saW5lIGludCBs
bF9uZXdfaHdfc2VnbWVudChzdHJ1Y3QgcmVxdWVzdCAqcmVxLCBzdHJ1Y3QgYmlvICpiaW8sDQog
IAkgKiBjb3VudGVycy4NCiAgCSAqLw0KICAJcmVxLT5ucl9waHlzX3NlZ21lbnRzICs9IG5yX3Bo
eXNfc2VnczsNCisJcmVxLT5ucl9idmVjcyArPSBiaW8tPmJpX3ZjbnQ7DQogIAlpZiAoYmlvX2lu
dGVncml0eShiaW8pKQ0KICAJCXJlcS0+bnJfaW50ZWdyaXR5X3NlZ21lbnRzICs9IGJsa19ycV9j
b3VudF9pbnRlZ3JpdHlfc2cocmVxLT5xLA0KICAJCQkJCQkJCQliaW8pOw0KQEAgLTYyNiw2ICs2
MzEsNyBAQCBzdGF0aWMgaW50IGxsX21lcmdlX3JlcXVlc3RzX2ZuKHN0cnVjdCByZXF1ZXN0X3F1
ZXVlICpxLCBzdHJ1Y3QgcmVxdWVzdCAqcmVxLA0KDQogIAkvKiBNZXJnZSBpcyBPSy4uLiAqLw0K
ICAJcmVxLT5ucl9waHlzX3NlZ21lbnRzID0gdG90YWxfcGh5c19zZWdtZW50czsNCisJcmVxLT5u
cl9idmVjcyArPSBuZXh0LT5ucl9idmVjczsNCiAgCXJlcS0+bnJfaW50ZWdyaXR5X3NlZ21lbnRz
ICs9IG5leHQtPm5yX2ludGVncml0eV9zZWdtZW50czsNCiAgCXJldHVybiAxOw0KICB9DQpkaWZm
IC0tZ2l0IGEvYmxvY2svYmxrLW1xLmMgYi9ibG9jay9ibGstbXEuYw0KaW5kZXggZDYyNmQzMmY2
ZTU3Li42MWNkMGJkNWI1YWYgMTAwNjQ0DQotLS0gYS9ibG9jay9ibGstbXEuYw0KKysrIGIvYmxv
Y2svYmxrLW1xLmMNCkBAIC00MzYsNiArNDM2LDcgQEAgc3RhdGljIHN0cnVjdCByZXF1ZXN0ICpi
bGtfbXFfcnFfY3R4X2luaXQoc3RydWN0IGJsa19tcV9hbGxvY19kYXRhICpkYXRhLA0KICAJcnEt
PnN0YXRzX3NlY3RvcnMgPSAwOw0KICAJcnEtPm5yX3BoeXNfc2VnbWVudHMgPSAwOw0KICAJcnEt
Pm5yX2ludGVncml0eV9zZWdtZW50cyA9IDA7DQorCXJxLT5ucl9idmVjcyA9IDA7DQogIAlycS0+
ZW5kX2lvID0gTlVMTDsNCiAgCXJxLT5lbmRfaW9fZGF0YSA9IE5VTEw7DQoNCkBAIC0yNjc1LDYg
KzI2NzYsNyBAQCBzdGF0aWMgdm9pZCBibGtfbXFfYmlvX3RvX3JlcXVlc3Qoc3RydWN0IHJlcXVl
c3QgKnJxLCBzdHJ1Y3QgYmlvICpiaW8sDQogIAlycS0+X19zZWN0b3IgPSBiaW8tPmJpX2l0ZXIu
Ymlfc2VjdG9yOw0KICAJcnEtPl9fZGF0YV9sZW4gPSBiaW8tPmJpX2l0ZXIuYmlfc2l6ZTsNCiAg
CXJxLT5ucl9waHlzX3NlZ21lbnRzID0gbnJfc2VnczsNCisJcnEtPm5yX2J2ZWNzID0gYmlvLT5i
aV92Y250Ow0KICAJaWYgKGJpb19pbnRlZ3JpdHkoYmlvKSkNCiAgCQlycS0+bnJfaW50ZWdyaXR5
X3NlZ21lbnRzID0gYmxrX3JxX2NvdW50X2ludGVncml0eV9zZyhycS0+cSwNCiAgCQkJCQkJCQkg
ICAgICBiaW8pOw0KZGlmZiAtLWdpdCBhL2luY2x1ZGUvbGludXgvYmxrLW1xLmggYi9pbmNsdWRl
L2xpbnV4L2Jsay1tcS5oDQppbmRleCA3Y2VkYzBlYmE1NjEuLmM1NjMyNTU1ODZjNiAxMDA2NDQN
Ci0tLSBhL2luY2x1ZGUvbGludXgvYmxrLW1xLmgNCisrKyBiL2luY2x1ZGUvbGludXgvYmxrLW1x
LmgNCkBAIC0xNTEsNiArMTUxLDcgQEAgc3RydWN0IHJlcXVlc3Qgew0KICAJICovDQogIAl1bnNp
Z25lZCBzaG9ydCBucl9waHlzX3NlZ21lbnRzOw0KICAJdW5zaWduZWQgc2hvcnQgbnJfaW50ZWdy
aXR5X3NlZ21lbnRzOw0KKwl1bnNpZ25lZCBzaG9ydCBucl9idmVjczsNCg0KICAjaWZkZWYgQ09O
RklHX0JMS19JTkxJTkVfRU5DUllQVElPTg0KICAJc3RydWN0IGJpb19jcnlwdF9jdHggKmNyeXB0
X2N0eDsNCkBAIC0xMTg3LDIwICsxMTg4LDE0IEBAIHN0YXRpYyBpbmxpbmUgdW5zaWduZWQgc2hv
cnQgYmxrX3JxX25yX2Rpc2NhcmRfc2VnbWVudHMoc3RydWN0IHJlcXVlc3QgKnJxKQ0KDQogIC8q
Kg0KICAgKiBibGtfcnFfbnJfYnZlYyAtIHJldHVybiBudW1iZXIgb2YgYnZlY3MgaW4gYSByZXF1
ZXN0DQotICogQHJxOiByZXF1ZXN0IHRvIGNhbGN1bGF0ZSBidmVjcyBmb3INCisgKiBAcnE6IHJl
cXVlc3QgdG8gZ2V0IGJ2ZWMgY291bnQgZm9yDQogICAqDQotICogUmV0dXJucyB0aGUgbnVtYmVy
IG9mIGJ2ZWNzLg0KKyAqIFJldHVybnMgdGhlIG51bWJlciBvZiBidmVjcyBpbiB0aGUgcmVxdWVz
dC4gVGhpcyBjb3VudCBpcyBtYWludGFpbmVkDQorICogZHVyaW5nIHJlcXVlc3QgaW5pdGlhbGl6
YXRpb24gYW5kIG1lcmdpbmcgdG8gYXZvaWQgcmVwZWF0ZWQgcmV3YWxraW5nLg0KICAgKi8NCiAg
c3RhdGljIGlubGluZSB1bnNpZ25lZCBpbnQgYmxrX3JxX25yX2J2ZWMoc3RydWN0IHJlcXVlc3Qg
KnJxKQ0KICB7DQotCXN0cnVjdCByZXFfaXRlcmF0b3IgcnFfaXRlcjsNCi0Jc3RydWN0IGJpb192
ZWMgYnY7DQotCXVuc2lnbmVkIGludCBucl9idmVjID0gMDsNCi0NCi0JcnFfZm9yX2VhY2hfYnZl
YyhidiwgcnEsIHJxX2l0ZXIpDQotCQlucl9idmVjKys7DQotDQotCXJldHVybiBucl9idmVjOw0K
KwlyZXR1cm4gcnEtPm5yX2J2ZWNzOw0KICB9DQoNCiAgaW50IF9fYmxrX3JxX21hcF9zZyhzdHJ1
Y3QgcmVxdWVzdCAqcnEsIHN0cnVjdCBzY2F0dGVybGlzdCAqc2dsaXN0LA0KLS0NCg0KDQotY2sN
Cg0KDQo=
