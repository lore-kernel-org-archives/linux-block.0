Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013014.outbound.protection.outlook.com [40.93.201.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E435F1CEAC2;
	Sun,  9 Nov 2025 19:05:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762715129; cv=fail; b=iloBy2Tn+7l9EeGt6IpvunXIdNlId8oQJ9ZzNCpzT8rKoMeCrwh81Jf7uzkVk/qyTvrErWFs4fDNv7Byvimv+g8a4bvZVRU1XwU60bldWnQV8EYqgMLut/dX2jEg90vmW2VYY+wyDBc4LtCGGIZPPqFd4mthD9Vyyhm7HNdsbnc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762715129; c=relaxed/simple;
	bh=3SNBQxNXo239pjfJ9d9+LgZqt8uBxr5YDViep+17cDc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=piKL3Z3i8D/CIFrBKixzQTwNIKR6Ir7ddWyUDEr8KqP4OIxpsomGTx+KIDibauV8YTkKST3WDO3pshdbrheujSa3cdTqm9KxC7S/6b1dheulz8ehT3aI6m7wB1Qr5KtWo2tys3DZpxP/BhTLtNwM8STndHbXSvvkrC4KY2vhfyI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=VTM/29Hj; arc=fail smtp.client-ip=40.93.201.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="VTM/29Hj"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jGLIooaH4sA21MN0m9bxcKxkWGzL1W/DTrzlc2bCg/qdn79AEhKI4Du0C6h2IEQef8xNCkaaQFf/Fbg3pJQvk1S/vRK38JRVKCa37gUTC36XuNbQNvVp3PCwFVWOXWvNUBjEyRqNZGxsN12nPYxkJH12bXmqgf7v/DP3Lv59sDCu0JF9Wh6NIusjwvUINHVqwL3TbjHnotP9Sd/psUmk93vrwD4oau7mUCrPyCQjRoQpg8YFoF62VDb2GRvKwZ04g5p+dC3RR/IUKWfMfxBh0fW/eY2MR4cjUTHQd1Fl+0B+YNzBY501TgzmnMFKsCC2fm2ni+DOyg0PJpk6lJQIeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3SNBQxNXo239pjfJ9d9+LgZqt8uBxr5YDViep+17cDc=;
 b=ugOxQSDf8jRT13A1yEBChvRhxNfulQz2uqV7X1OCQmFGKiFwgwHglmH0SHQkGnLpFFBPq0lOQwEMu7nRwrnp4q0okYLJ4OiXIhduKGukmBXgBvCjukZEQ1sscZnr0nfd8QBVy8INAv3dGIvBLGbNnhB5slr6U6Esb5B7CUkVIbKCC0cH59SJ76vJ+CZ5hFIl5GPyyMK/a2vLjKGsWuNSRao/BJRLMDr40/XzZ6gB1I1uKHOKukEkRsRLTBt4K4i19K9I+uFTCy74sOVk0RucqIKVoUuTR6Zh6a0sWk81ChePxWavu8EP0RkBLqSZrnEIDuoTh9gDBWsUoFMElc3dug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3SNBQxNXo239pjfJ9d9+LgZqt8uBxr5YDViep+17cDc=;
 b=VTM/29HjEJxCjf2pS4GnDZ98e8h5JEbmtpOjMZUuyGD/BEESLt9ejYrP+jkSVB5F+UpsS1eanh6DT2N2pRM+yDDSTmcOmHv8FHmLmVKLseNEyVX4BZjJ8Zg94iYWdtCZD74px3OugND6dEKsT0rQqEhI+GgJ1fbfkOecKchJT/th/FtudDeoW7t2BL+jAKbvWBsn1R+p9UZt0JOlHxprCJGW8wvcsHfU/zv+xnzgGDgDUFG20ogJyTYqmCnxag4gORV264WsUuZinJb70qdupzXHPngZ/mftsgRODbN/2D8Gntt+jvRyI1PF05YlIWL3D62AEu7xV6SzxaYRMBk72w==
Received: from LV3PR12MB9404.namprd12.prod.outlook.com (2603:10b6:408:219::9)
 by SA1PR12MB8723.namprd12.prod.outlook.com (2603:10b6:806:385::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.16; Sun, 9 Nov
 2025 19:05:25 +0000
Received: from LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b]) by LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b%5]) with mapi id 15.20.9298.015; Sun, 9 Nov 2025
 19:05:25 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Ming Lei <ming.lei@redhat.com>, Caleb Sander Mateos
	<csander@purestorage.com>
CC: Jens Axboe <axboe@kernel.dk>, Damien Le Moal <dlemoal@kernel.org>,
	Christoph Hellwig <hch@lst.de>, "linux-block@vger.kernel.org"
	<linux-block@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] loop: use blk_rq_nr_phys_segments() instead of
 iterating bvecs
Thread-Topic: [PATCH 1/2] loop: use blk_rq_nr_phys_segments() instead of
 iterating bvecs
Thread-Index: AQHcUQOdjgtc2W0TJUScOtgtPtkTArTqRDcAgABxXYA=
Date: Sun, 9 Nov 2025 19:05:25 +0000
Message-ID: <b62e658a-a35c-4fa8-9674-2d3a12266176@nvidia.com>
References: <20251108230101.4187106-1-csander@purestorage.com>
 <20251108230101.4187106-2-csander@purestorage.com> <aRCG3OUThPCys92r@fedora>
In-Reply-To: <aRCG3OUThPCys92r@fedora>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9404:EE_|SA1PR12MB8723:EE_
x-ms-office365-filtering-correlation-id: 85f6a7fd-9d70-4b1e-7bd9-08de1fc2f0a6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|10070799003|376014|366016|1800799024|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?dVd1Wkl4MlJJdWFNNzBRQVFBNTRzWXUxVkpCTitpOUZsSmNPSVovOVF6VXcz?=
 =?utf-8?B?eEF0bm5QcEJib2QrL1RkZ0FtaTRnbmUwL0d1RU50Y2x0aWlUb0RZWmdQWEJQ?=
 =?utf-8?B?WTJLVjBKUFhzRExYQ1Z3cHBUcmxCTGVldTlaZmJPVzFPa3ZMZnlvTmRFamtz?=
 =?utf-8?B?YllNRkZ6a0xHQTNWTUhRM3VKN3ErQVFzL0R1dXU2MG5YU0cweUVDd1hoYVpW?=
 =?utf-8?B?QlpEdCt1UkxxODJoaEVKdktQSzRpOWd1czFQMWsrUmFsSGNSUHdHRThUWlAz?=
 =?utf-8?B?ak9xTWRjMmo3b3RpSi9WdEtkbm5QNzA2Mk9LUjlSTkpST3dnODRkMFJ4Y0lx?=
 =?utf-8?B?MmhRM0lVL1Urd1dZck1KVW9qd2ZqcE8vU1lRbUhVMEltdzl3MTV2TUJqWWdS?=
 =?utf-8?B?OEN5clE5aWxGeXVoZlhLdm11OFZHdG5Xa2ZtZU81VmQyRVhqM0xvNk1ockRj?=
 =?utf-8?B?Z05WeVY1c2RPRTdWN3A5bDVNNXg3dmZBQmdRbmp5TTJIZ2NYbkRjZU91aDAz?=
 =?utf-8?B?YmdGeXYvQU02ZnE3TTZMcTFSVm1GdUxKc2MreWhYb0ZraGhPRjBHZU9ob2xW?=
 =?utf-8?B?eFdEcWdMdjZTWEFOc0h6TFJjcVc3UVRONG5KamtIRGdhU1BtL251bUw4TjZL?=
 =?utf-8?B?WTdrUml6RnUwRGF5blJIdWJtL2dzcUx0TWRRY092M1ZDT0Mrd1FTWXJHVGQ1?=
 =?utf-8?B?bWNTOVYyY2cxZ0dCdm11dGdENnF3eVBQdUtzVDRpWFFUZWxBVEI3REZvaGo1?=
 =?utf-8?B?Z0wwUDhqUzFrVU5BbkZrMFZaUVlGYUJ1a1RESUdUdjVDWEhEM05tc3FLeDNY?=
 =?utf-8?B?ZTIydlhUU05rT2tpM0h2a3lsMWUrZUJUaDc1bFAxb0h1QWZjeG5ZZk8ySEdE?=
 =?utf-8?B?N3ZYWkZIREJuVEoxdXZ6alBtbWtEVjVhdVpVL1dRM015L0hlaHZoN2pwQUdD?=
 =?utf-8?B?MDRBd2I4V29MOTFzem0rbUZEcThYMFBNc2ZZeTZDRjNQZ1NzVlNsNVErSGxR?=
 =?utf-8?B?M1FRNXNqeWVxS3NUa0RFZXpjcTR4cFFybXZlbGZyVDhwenJRL24rVDdWRVVL?=
 =?utf-8?B?NEd5UUZ1YWdOVnUzUzNGOUdRRnFrcVZMcWtZanVNejN1V0hHMFdOMUY1ekRp?=
 =?utf-8?B?TVZzREZ4alZ5b01NdnVYbnpYNHBXa2Jkb3ZLbExpeGZaWnR6MVdDaC94VEMw?=
 =?utf-8?B?NGsrYzAyNUhtalJXMExiZW52TXJFSmtaRVdxK3JJSTYxMWdSTWtQWUdBTFdY?=
 =?utf-8?B?eGd6ZE53b1pUWDF3aDhGMnorbzNkVmNBTGpRMUFGTWhyRFB3UVJaMVRjc3Vr?=
 =?utf-8?B?d0pjd2d5MlJhU1J2cENoTVoxZUtKUVBEZWhYOTJ4aTVta0ZFTHJlUHV4L1lG?=
 =?utf-8?B?TmRRdE9sUTZqNkNkblhEdTlSSm8rcm5DZ2QzV1diTWVybnZMZU5IZXJrQi9L?=
 =?utf-8?B?UHdjZHNCeHU1dHI5ZllrNSt5WkVucVlOL2xwTzRjc0dBc2Q0OGFZdmVLY0E0?=
 =?utf-8?B?Q09qb3lvUTN2RFhqR0pHR0xBbEJ4UTZqY3AzZkdnNWxIajFsaXhLQUFuOWN6?=
 =?utf-8?B?bFRxaFp5YzZDN1Z6QUJSalhYZHFQYk4zdC9CT1JkS3FZL3lidUFEcmUxT0FT?=
 =?utf-8?B?Ly83R1dNN2ZsUlZPMGJwWk15UGVKQjlGa1hpL00xK29wMm1iK0xLOS9YUTAv?=
 =?utf-8?B?TGdXcVh6QnJYdkVuMFYzREp3NmVydjB5U3o0WlhuTksvSjlxRS9tb0laZFpK?=
 =?utf-8?B?blNYRE9vTmFxYy9jTXdBSU82OG9xYWZMSkt1bWdhTzJ3RGdka1N0Q1Ruc0Z1?=
 =?utf-8?B?L3Q4cEpEaFVROFRVTnBDR2NiNEwvZnRFaUQ4RU13SmdtbFhma2hwK1VjWE1Z?=
 =?utf-8?B?djZpOWtVUklzLzJSUTBuMnpqMkg5aVRRZC9jNnliR2lYdlRzeXNKODFmM3NW?=
 =?utf-8?B?WXJkSzB2Z3VUbVlRcW1wYVJPZHhtTVFValM0QTRDNTVOR3QzeExkbU1CekJv?=
 =?utf-8?B?TThCT2RtdS80T1hFR2FpQXFQN2pubmlOQnZCWE5FdFRWdUN4ekxvVmErYlJV?=
 =?utf-8?Q?RUDvOT?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9404.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(376014)(366016)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?UTQvc0lMdFBacnNJOWVWcDVqeHNDLy9lTDBNbjVzV0F0bVhCTnB0ZGthN29E?=
 =?utf-8?B?N29nYzhjT1Z5QWVDcGo3TElHS1R2aDdtMDdqa05LMDd6RTRTQmhVdm1nakVi?=
 =?utf-8?B?VkZnQit2MVNxNjYyemp6WEd6bVNyYzgzQWFrdDJYTlRibkx3eUIvV25WdkJj?=
 =?utf-8?B?WkJQQnY5bnBFRHJhakoxNlNiSksrTXh6SUFLbUw3RkpaVFdzSzFXcTRxNW83?=
 =?utf-8?B?YmJDdDJYYWlDUk9NWXY3UWlLTGlaK2RMVmtoV01YYVBvRkIyNnlwTW9ML0Mr?=
 =?utf-8?B?Sy82RzU1c3UvUGwzTEhIRGtKVkl6S3RIS3pWLzhHNVp3ZVNoaVJiVyt0c08z?=
 =?utf-8?B?RkM0S2huUVluYitkY0VLYmNKcmRpVmlXankwbXp0eW9ranQ2RUZDRkZ5bUtZ?=
 =?utf-8?B?V3lLcjJuK003UW4yWnY1cHZzSEMwNEk5RkdZOXQ1NFd2aUZCVXRoTGZXRTBY?=
 =?utf-8?B?T3pXZUtYTURFWFh5Qm1peHdvSUxuUHh0TFJXbVJaeFlHQTFxQ3VFOHkzdmY0?=
 =?utf-8?B?em1yOXRuSHYvSWZwRFNPcTFNRVB2MXA0MjdHOWQyQnhvVy9sNGR6Qm9qUXpj?=
 =?utf-8?B?Wm4xS2hPOUtKdHFWMEpqUlhKY29FcndISUhCN2RZZVk3dFJUOXdGMWlkdWZI?=
 =?utf-8?B?UncvRFJScDB0Ukk5QmlhcTJVZDc4Z3B1ZVZTQUZRZVJGL21NdVpKelcwWmIy?=
 =?utf-8?B?b3ZRM2xrUlhIQncxR29LdVZocThJQXREZ3g5ZEpQZmNYOWF1S0FMOEdFWmQx?=
 =?utf-8?B?WDNjQ0FiS1grSUM5MXo4a2xDUGpCMjZFbUFPc3BXK0VGVTI0ajlaNm1FVW9X?=
 =?utf-8?B?UFRWY01UWjBHWDZOZmRhRGdubThZWXcxdnFmcVVLd3JrK3lTVmhrakZXYVZn?=
 =?utf-8?B?YkJoeC9la2sxNFNoamgzRFhiaEpuUTkycUwzRG9qVngwYXppbVc4TW9aNEZ6?=
 =?utf-8?B?aUo3RURER09Ca1hrQnV5cHhHbDJuQXJtelZoeW9OSkE0Ukx1ekRLcTRHUnd2?=
 =?utf-8?B?ZEpuaTdueDN5Z3U5eXdJdVdqTERxdzd2WjRvcDhlU3piZk9BN0JTVjRoQlRq?=
 =?utf-8?B?bEZWeHpsdVAxWWc1TXdJdTVRNXRGbXQrQkVtdVN1Nk1PVGVWeDg1aDhYc1Nh?=
 =?utf-8?B?STY2ajFNUXVJUVJ5TVJGQXpiZnlaOWVFSGl6VVVoZC9yRjY1bStTbC9sbUdX?=
 =?utf-8?B?NU8ydHpBaDJsMkxQZGV0Y3JKU0xPcVNFWGlNdVVrSTAvaTBsakRrVEVJR2Nr?=
 =?utf-8?B?NFlmUDFua3RvblFWMzQzK00xVk45STRSa3F0K2lRV0N2cWdqZCtoNjhYK0Va?=
 =?utf-8?B?QXZLYjBPRS95THJHRjlaRUlZSFdyRzhpa0VzMHllbE85R0t3cG9oL05NV2g4?=
 =?utf-8?B?aFMyNm16WldJbVZhbWVIRzFPbXB1UkZ5a0ZxM3ovcm9DdCtETFRtRUtTQTVn?=
 =?utf-8?B?RWF6cVlObEY4NDc1d05OT1daZmpYYklxQklIUEhmZ3JiWHZ1SGNTaDMxMG83?=
 =?utf-8?B?cXB5cXpCVGxKc1FlWVIvN2ZwWDJmTFFmS2I1L0JBbFhSamF0Ri9YUTgrNG5E?=
 =?utf-8?B?ZHZ1Vjl3c0ZaVWR4S0tTallPSmRUb1BLNStZZUU3QnAyR3lmU3hvU1lSTWRP?=
 =?utf-8?B?aEJvNkwzRzVQKzl0V0JtR3c0SmRUaUF2bGhZT1RZS2thZDFUSEJwWGU3Z0Nk?=
 =?utf-8?B?MDcvbmxXdHZ2ZlVmY3lsRnRNZjNrQ3F1QUdNTGZMTXA2aDhMQWJCQ21VbS9S?=
 =?utf-8?B?SzZVNWpHQVdaWXdlNlJwUVVBQnBDMnUzNnB4dWowNEs4T1kwV3Y0TmwyUGJn?=
 =?utf-8?B?V2wxQmRDeThOcGM5aFMrcFIwV3FIaVNMV2NwZkl0dkQwZEhSN0hwQVJmRWZU?=
 =?utf-8?B?SEFBSWgzMWhXdzVVT21leXgvbnFqenRKT1NoNjBTcWxCNXR0elF6ekNYcnl2?=
 =?utf-8?B?ejRIUzV0ekNoVmVVdDhIN0QyQUpudlF0ZXhhdjhqaHdGSm5jemlUNjIwVjZD?=
 =?utf-8?B?VGltTGVsQjNZdnArVVlCYktHTk1VbUplUGJXQ1R3bnZ5OXUvcGRBaXRsZTd1?=
 =?utf-8?B?Nk1UZXA1LzJYTHYrS0hqRURCWG9NbFQ4akt3OFdUK3pNeVNGQzd0UERTVmo0?=
 =?utf-8?B?azhzMVc0cTl6elVrSlhrNC93OWZCcHF2QUUwWmp3aGNISlJDOFpwRFZCb3ZR?=
 =?utf-8?Q?CTAsC7zm3kqCw5SwH5QXb9cGr/N7Pcy+cViEzjSGdg7v?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <5F6EEAF3DAA4FD4A830C93B8534ED0BB@namprd12.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 85f6a7fd-9d70-4b1e-7bd9-08de1fc2f0a6
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Nov 2025 19:05:25.4383
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7ouDHDPz8z9vdNcb5wOA6RF3BNpFvJtK0CHQ8t9JqCkAfQ7kJsAAo4QGHJZao2VFq+Mu6tbNgnSQWItGm9Ujkw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8723

T24gMTEvOS8yNSAwNDoxOSwgTWluZyBMZWkgd3JvdGU6DQo+IE9uIFNhdCwgTm92IDA4LCAyMDI1
IGF0IDA0OjAxOjAwUE0gLTA3MDAsIENhbGViIFNhbmRlciBNYXRlb3Mgd3JvdGU6DQo+PiBUaGUg
bnVtYmVyIG9mIGJ2ZWNzIGNhbiBiZSBvYnRhaW5lZCBkaXJlY3RseSBmcm9tIHN0cnVjdCByZXF1
ZXN0J3MNCj4+IG5yX3BoeXNfc2VnbWVudHMgZmllbGQgdmlhIGJsa19ycV9ucl9waHlzX3NlZ21l
bnRzKCksIHNvIHVzZSB0aGF0DQo+PiBpbnN0ZWFkIG9mIGl0ZXJhdGluZyBvdmVyIHRoZSBidmVj
cyBhbiBleHRyYSB0aW1lLg0KPj4NCj4+IFNpZ25lZC1vZmYtYnk6IENhbGViIFNhbmRlciBNYXRl
b3MgPGNzYW5kZXJAcHVyZXN0b3JhZ2UuY29tPg0KPj4gLS0tDQo+PiAgIGRyaXZlcnMvYmxvY2sv
bG9vcC5jIHwgNSArLS0tLQ0KPj4gICAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDQg
ZGVsZXRpb25zKC0pDQo+Pg0KPj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvYmxvY2svbG9vcC5jIGIv
ZHJpdmVycy9ibG9jay9sb29wLmMNCj4+IGluZGV4IDEzY2UyMjlkNDUwYy4uODA5NjQ3OGZhZDQ1
IDEwMDY0NA0KPj4gLS0tIGEvZHJpdmVycy9ibG9jay9sb29wLmMNCj4+ICsrKyBiL2RyaXZlcnMv
YmxvY2svbG9vcC5jDQo+PiBAQCAtMzQ2LDE2ICszNDYsMTMgQEAgc3RhdGljIGludCBsb19yd19h
aW8oc3RydWN0IGxvb3BfZGV2aWNlICpsbywgc3RydWN0IGxvb3BfY21kICpjbWQsDQo+PiAgIAlz
dHJ1Y3QgcmVxdWVzdCAqcnEgPSBibGtfbXFfcnFfZnJvbV9wZHUoY21kKTsNCj4+ICAgCXN0cnVj
dCBiaW8gKmJpbyA9IHJxLT5iaW87DQo+PiAgIAlzdHJ1Y3QgZmlsZSAqZmlsZSA9IGxvLT5sb19i
YWNraW5nX2ZpbGU7DQo+PiAgIAlzdHJ1Y3QgYmlvX3ZlYyB0bXA7DQo+PiAgIAl1bnNpZ25lZCBp
bnQgb2Zmc2V0Ow0KPj4gLQlpbnQgbnJfYnZlYyA9IDA7DQo+PiArCXVuc2lnbmVkIHNob3J0IG5y
X2J2ZWMgPSBibGtfcnFfbnJfcGh5c19zZWdtZW50cyhycSk7DQo+PiAgIAlpbnQgcmV0Ow0KPj4g
ICANCj4+IC0JcnFfZm9yX2VhY2hfYnZlYyh0bXAsIHJxLCBycV9pdGVyKQ0KPj4gLQkJbnJfYnZl
YysrOw0KPj4gLQ0KPiBUaGUgdHdvIG1heSBub3QgYmUgc2FtZSwgc2luY2Ugb25lIGJ2ZWMgY2Fu
IGJlIHNwbGl0dGVkIGludG8gbXVsdGlwbGUgc2VnbWVudHMuDQo+DQo+IFRoYW5rcywNCj4gTWlu
Zw0KPg0KPg0KDQpJIGhhZCB0aGlzIHBhdGNoIG9ubHkgdG8gcmVhbGl6ZSB0aGlzIDotDQoNCmJ2
ZWNfc3BsaXRfc2VncygpOi0NCiogV2hlbiBzcGxpdHRpbmcgYSBiaW8sIGl0IGNhbiBoYXBwZW4g
dGhhdCBhIGJ2ZWMgaXMgZW5jb3VudGVyZWQgdGhhdCBpcyB0b28NCiogYmlnIHRvIGZpdCBpbiBh
IHNpbmdsZSBzZWdtZW50IGFuZCBoZW5jZSB0aGF0IGl0IGhhcyB0byBiZSBzcGxpdCBpbiB0aGUN
CiogbWlkZGxlLiBUaGlzIGZ1bmN0aW9uIHZlcmlmaWVzIHdoZXRoZXIgb3Igbm90IHRoYXQgc2hv
dWxkIGhhcHBlbi4gVGhlIA0KdmFsdWUNCiogJXRydWUgaXMgcmV0dXJuZWQgaWYgYW5kIG9ubHkg
aWYgYXBwZW5kaW5nIHRoZSBlbnRpcmUgQGJ2IHRvIGEgYmlvIHdpdGgNCiogKkBuc2VncyBzZWdt
ZW50cyBhbmQgKkBzZWN0b3JzIHNlY3RvcnMgd291bGQgbWFrZSB0aGF0IGJpbyANCnVuYWNjZXB0
YWJsZSBmb3INCiogdGhlIGJsb2NrIGRyaXZlci4NCg0KaWYgZm9sbG93aW5nIG1lc3N1cCB0aGUg
aW5kZW50YXRpb24gYWZ0ZXIgSSBzZW5kIHBseiBpZ25vcmUgOi0NCg0Kc3VibWl0X2JpbygpDQog
wqAgLT4gc3VibWl0X2Jpb19ub2FjY3QoKQ0KIMKgIMKgIC0+IF9fc3VibWl0X2Jpb19ub2FjY3Qo
KQ0KIMKgIMKgIMKgIC0+IF9fc3VibWl0X2JpbygpDQogwqAgwqAgwqAgwqAgLT4gYmxrX21xX3N1
Ym1pdF9iaW8oKQ0KIMKgIMKgIMKgIMKgIMKgIC0+IF9fYmlvX3NwbGl0X3RvX2xpbWl0cygpDQog
wqAgwqAgwqAgwqAgwqAgwqAgLT4gYmlvX3NwbGl0X3J3KCkNCiDCoCDCoCDCoCDCoCDCoCDCoCDC
oCAtPiBiaW9fc3BsaXRfcndfYXQoKQ0KIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIC0+IGJpb19z
cGxpdF9pb19hdCgpDQoNCiDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCAtLSBiaW9fZm9yX2Vh
Y2hfYnZlYygpwqAgwqAoaXRlcmF0ZSBhbGwgYnZlY3MpDQogwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAtLSBbRmFzdCBwYXRoXQ0KIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIG5zZWdzKyvCoCDCoCDCoCDCoCDCoCDCoCDCoCgxIGJ2ZWMgPSAxIHNlZ21lbnQpDQogwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgYnl0ZXMgKz0gYnYuYnZfbGVuDQogwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAtLSBbU2xvdyBwYXRoXQ0KIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIC8qIG9uZSBidiBpcyBwYXNzZWQgZnJvbSBiaW8gYnZlYyBsaXN0
wqAgKi8NCiDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCAtPiBidmVjX3NwbGl0X3Nl
Z3MobGltLCAmYnYsICZuc2VncywgJmJ5dGVzLA0KIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgbGltLT5tYXhfc2VnbWVudHMsIG1h
eF9ieXRlcykNCg0KIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgLyog
d29ya2luZyBvbiBvbmUgYnZlYyBhbmQgYXNzb2NpYXRlZCANCnNlZ21lbnRzICovDQogwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAtLSB3aGlsZSAobGVuICYmICpuc2Vn
cyA8IG1heF9zZWdzKSB7DQoNCiDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCAuLi4NCg0KIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIGdldF9tYXhfc2VnbWVudF9zaXplKCkNCiDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCAtPiBtaW4obGVuLA0KIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgc2VnX2JvdW5k
YXJ5X21hc2sgLSBvZmZzZXQsDQogwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBtYXhfc2VnbWVudF9zaXplKQ0KDQogwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgKCpuc2VncykrKw0KIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIHRvdGFsX2xlbiArPSBz
ZWdfc2l6ZQ0KIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IGxlbiAtPSBzZWdfc2l6ZQ0KDQogwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgLi4uDQoNCiDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCB9DQoNCiDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoC0t
ICpieXRlcyArPSB0b3RhbF9sZW4NCiDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoC0tIHJldHVybiAobGVuID4gMCkNCg0KIMKgIMKgIMKgIMKgIMKgIC0+IGJsa19tcV9i
aW9fdG9fcmVxdWVzdCgpDQogwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBycS0+bnJfcGh5c19zZWdt
ZW50cyA9IG5yX3NlZ3MNCg0KLWNrDQoNCg0KDQo=
