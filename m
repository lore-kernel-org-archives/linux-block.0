Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013063.outbound.protection.outlook.com [40.107.201.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E7C121CC79
	for <linux-block@vger.kernel.org>; Thu,  8 Jan 2026 02:08:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767838100; cv=fail; b=cTuKwfIP8IBWMOZS8Fh1VCA3g2H9eAb7QaQBPERcAXYJV6Gy2qpn1lv3qbqa/GowPi5HOf9OG34CX9AirEMnr9ZjHIlV4sKWAx7wak7PYLXBKIlzNeVhLBfn4TUk+vfvdgyFMVOGegSNvwu59mIXsqf3E/sTS0yNs+iKdOzUYfk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767838100; c=relaxed/simple;
	bh=C9cj6qH1OXja4HwPtFDtbx7RQKhvSJLO5VQdPm+Gup4=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=cW9rXHTq9HTtWOJFuPFvTk1u1nU5BA0R62AODX3QuHeFZ8r6Z48iAu6t+GZvscuADJysJmhKFhNRWP85Nhq/lmodClIpGF/mebkhtJJK3Vrat3ogCbWl46ZYjNFBRerzInreMlN0RmejaPw+G2JLJ/+kxYZDYu2gdlTNUhlBDcw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=VNcq9DV1; arc=fail smtp.client-ip=40.107.201.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="VNcq9DV1"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YfrSwGAcA5J75uhFmjM0VupEA6H0CJIDfLJs63vA/isMQHkhQI7c5SJ3r7CZAkr87NVpO7oJY+F3bbvrSw06omBAqIzDOh+kPLJEW1xuR4WspvDlQ2cIm46C+MY0DNu+QkAuIJZI7wC7mFiTOznH4WkAiUvMRQWdzXg+tEWmag3vmiw9SL26BKy2ZvA64vgYB3P5qiVuDmz03YzprL/Ywm+KQK/NNG3V/1DRRfSdzOpTvCVdKEO3xXd85CM3DlbyRHkuV8MwyzK5n/W/GtLmWUUsJBq+uRaHytZ7JJD9qkYTY3t5n9dhN/yCS0X4/nZbJzY1rW7ZOrUMuVU54QbYyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C9cj6qH1OXja4HwPtFDtbx7RQKhvSJLO5VQdPm+Gup4=;
 b=NSENzwZK/ecmNVWZ4kst0iZwunNtgsIKphXWr3xm79HrWiq5qFnm6Hgh9EnSC0Xcd2C7M8bfN4KpzxPlDk46VUlHC5NzSZ1t8ets1mTB4HUMqAp5lj1qMjVDvVRmblZUjnhZpn74++bJGJCbS4MHpvTVnRPQp9lK1S/4Nn8T/YZHRLCcj6yPvX/sgZiRu43LwCm4gyqk4r5gZWMhaUb+pZW4IzRLdwoEYq4qZ7MmIMXTXlv9HQmk+ReupmaLQ2O93pbBNLKau9XbVbrF84VX6CNaV6+/52CcDncDH0PeUERhA/ZP+jPrvSTCN1ibMINydqZhol0ISLCm2RA+49hzfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C9cj6qH1OXja4HwPtFDtbx7RQKhvSJLO5VQdPm+Gup4=;
 b=VNcq9DV1NQieR1P781kMCn8p1GSUhHDVWFn4z54q8njj/BdKX7ySlX6C16zr6dm1ijbORsXMBFqo0YOcVCkYygZ3Mp8jtcrJejXCkNuMJ+F2J09TlMZer0OuAH7fCX8MW13X0GtO1AqDD1xTyyce4oeQs+L3RDw4MAqIC3d0RWUCRMnY0bQs8I4q10Od6NHiiTB80w2/V7I7oKHsw2Q9MNgdFVmF7Dz+AH0BqnYKf5c2CPpiy4NnaTIM8ikBqEke3EztoNAZA25hmWYyyyxSzMbOVn4k3gfnrkOYWRsoYuvfydLw19nX3JeOiHWn0EVve95RVvd/21Yj8LzPr+o15A==
Received: from LV3PR12MB9404.namprd12.prod.outlook.com (2603:10b6:408:219::9)
 by DM4PR12MB5889.namprd12.prod.outlook.com (2603:10b6:8:65::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.2; Thu, 8 Jan
 2026 02:08:10 +0000
Received: from LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b]) by LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b%5]) with mapi id 15.20.9499.002; Thu, 8 Jan 2026
 02:08:10 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Damien Le Moal <dlemoal@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH 1/2] block: fix blk_zone_cond_str() comment
Thread-Topic: [PATCH 1/2] block: fix blk_zone_cond_str() comment
Thread-Index: AQHcftrkwTAPqvaZvEyd1SBpKukxYLVHiY+A
Date: Thu, 8 Jan 2026 02:08:10 +0000
Message-ID: <16593f93-2642-4a74-9920-706c43722d2b@nvidia.com>
References: <20260106070057.1364551-1-dlemoal@kernel.org>
 <20260106070057.1364551-2-dlemoal@kernel.org>
In-Reply-To: <20260106070057.1364551-2-dlemoal@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9404:EE_|DM4PR12MB5889:EE_
x-ms-office365-filtering-correlation-id: 30d6c7fc-4050-41ff-fe91-08de4e5ac586
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|366016|10070799003|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?MnZpUXprVFhvNVhHR0hYeEFZdTJKTTNMMlBiUmRhdVRHUmZWUUZ2N1luZENM?=
 =?utf-8?B?b0tkOHJQNGRqQ2EweVY1TDk2OVQxYVk3VFpDc2tsMWZsYzZ3Z2x5ejZhVll2?=
 =?utf-8?B?R0pneWE4T2IwZ3J0clR6TnQ0bGJ0ZlpjSm1lek9KMHJmTkp1dGpPOHp0T1Yr?=
 =?utf-8?B?NnBaWXFqb01ZVUh1bXBmU3JscnJiUGF5OGdqTGdHQWkxeHdsejRoaVg1ZW1G?=
 =?utf-8?B?SU01azN2OFU4LzVZYUN0RDV5em00cGx5RmVKNmdZaHNZV0hOMEhGVlJZUjVk?=
 =?utf-8?B?R0xTWU1xdnBVTE1oTFJNdEkzS3pJeXRmRGh1b1MrcStIUHZaTnQwVGdjbElX?=
 =?utf-8?B?QVBhOEdqUlE5Wnd6VGNjRy9rUmdBdG9xVnNsT0gweHJreEMySWZ2dU51OHB2?=
 =?utf-8?B?b2FXNzd2dXFiL0pJQnJ4YXI0K1FrSEJNbWFSTzAvRit3bGc4V3RNSDZUelV4?=
 =?utf-8?B?a3pXL0kyK1FSa1QxbTAzMUVkeXFyOG5rZEl2cjVDSnZTRGZoK1VvSjc4T2Ja?=
 =?utf-8?B?UElSdS9RbjFKSXdRYThSMVNKa1B2cEhjNGREZFlza2F1SDdIQWp6azVNWVV0?=
 =?utf-8?B?MENyVTVnVXVYeFM1U1kyUFc5dStpcFJnUGwxbzlFV2VEVVJQeHNYcU1nbkMv?=
 =?utf-8?B?MnNEZlJYNENacEhYbDBjQUlPZUVlR1QxeVFTVXcwZXNUL0wxbmwybXViM1ow?=
 =?utf-8?B?R0E3ZXd0UGxJQkJ3M1lqWFdRSEdBVGhNei96ekwwbU5BcEpIak5uK2cveU9P?=
 =?utf-8?B?Q0kvOWlpVnArTHUva1ZSRkNVWnc4U0ZnUC91Tmw1ZDhPR3lSa1JjeWZyelNL?=
 =?utf-8?B?S29tZFZqeGdaVmVQZmw2SXlqLzJwWnAxNnRmb3ZwYThtM1dBU3NYYjMzb3hW?=
 =?utf-8?B?MHFFd1VkWGNGblo5MUJmMldpYXYyQjVyTXI1dXhCSzRQTGNGMGd4WlBwZlky?=
 =?utf-8?B?am5SMzd5UmpHb1AzNW5FVGRKUWFGd2FlVUp3N1ZvSk5hWW5yOFFzYVNsY2Rk?=
 =?utf-8?B?cFlmdjZIWWloblpRQVRnZ2d2dGswYk5sQ0hERW02UWMvbmVKaXdyaGFzVElh?=
 =?utf-8?B?WTROMVQvVHA5TGNicDVXNERtQm5MdzR4QkZPQkdSKzg1QVZtbWQra0RjMFo2?=
 =?utf-8?B?U05vUDRRQWxHeWdWOGRLQ283KzhNUElzdnZncWNOUHNYY1dvcGRLN3NSWldr?=
 =?utf-8?B?NXdCR2hKTHVoVE1nUUczSENJNFp5bkFqbFRJZU5ENG5tU3c3aWs0SnhZeE5s?=
 =?utf-8?B?anpxUi9oeVVPQ01GSnRtaXR6V28wMW14ZVRzUkxPYVYzbHBxa0pMMEFJdElq?=
 =?utf-8?B?VmJxWitRRTdLSkI3VG1BK2ZZemdNWVpkbDMyRFVsRW8rc2tSSkNEVDZZVGt4?=
 =?utf-8?B?WTVqK3lNZlhoajlvd0wzWUhNdlZyYzZrMkZwM0cydWdxVDl1WkIzSUZ5NFFa?=
 =?utf-8?B?OVFoTm15cDhna1ZuWU54UE5sdmFRRVFKTlZzNGNvT3VVUEVmbTl2Q253T2dV?=
 =?utf-8?B?LytvZjBNNUYyeHMzeEJmRGUyL1g5ZEg3ajF0SmRvazZIT2RSMTI2VXExTFpR?=
 =?utf-8?B?WDBrNlFXZER6d3ZWa0pEMXEzV0poY0VoOWZIQnZna1llaWVhSVVJbHlJRkhw?=
 =?utf-8?B?MW56aEwwRW1MZWtmUkFkelRQR1pPblc5TWNkTU5teGVYenZYRDMyNDM5cW1q?=
 =?utf-8?B?NXFEcU1HMmg5UnVkZ2FzL0VHckpEMHdSbU1SbUNwTzIyUXJ5ZXJoWFdGVlJh?=
 =?utf-8?B?cTlDWElmTC9NNitONHNPQ0FhcW9pWm5qWG1BaWRPRXlzZXZ2VlpGVkN0QkRN?=
 =?utf-8?B?VFUxU1RnaHhzeEdxaWxYT2pCS3lXekVYeFp4aWo4czFuVnkxbVlUVzZrYVBz?=
 =?utf-8?B?UjVaVFJsQS9sQ3d6QmloRXppdUpqNmg4cldBMVREcHgzVkJZMHhpMC9VbGZX?=
 =?utf-8?B?QWpIeC9LRnBDK1RyaGVhN0VpOEZtc2lmNkV5U3RrVzJtOGk4OGxpQ2U1ano4?=
 =?utf-8?B?aDJRNStVU3RvM3gyck10bmtPRUxYcElzakRSNXplRGRNQWx3L1p6T2cvaXRX?=
 =?utf-8?Q?/Gy9eI?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9404.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(10070799003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?dlMwVlpzYU9tRWJLOFNuL201V2lFRTY3SmJBa2VrTjB5elplZklTZCtsYTBM?=
 =?utf-8?B?V055ZUZRWGxuQVhsdkhuTE9tbVhKNjQwRUVhRFRQZCtXa3lNNXBmaU1iN0tv?=
 =?utf-8?B?SStCMS9WUkZoWE5IVjhUVFl2WURJK3RNbHNVMmxZbDVaUkhvaHBzTmdkcmpj?=
 =?utf-8?B?bWZSb1UyQ3JsQTVhMjhRRjlIdWtuNFhRam41Z1NnckdRbG9tWmV6YWVKS2k0?=
 =?utf-8?B?T1d5eHBNMXgreFcrQ21qRkNGZDhiRFk1ckw1UjJlMks0RFVEc3BxT1VUWVhL?=
 =?utf-8?B?MlhKend0dGM5OTc5aDVhWDA2QUtsc3ZxR2NmS0RGcTJLTGVKeThMNURpS0ZZ?=
 =?utf-8?B?dHYwejNwSWNRb2M5cE9JSmRnak5lbFVTaThwbitDWUZYbW5pV2hYbWZreFN6?=
 =?utf-8?B?TG42NXFxMFVlaU5MMTFLUWxIbFVXWjlubFpjZUtBUmpWTGxXVnVpZmluaER4?=
 =?utf-8?B?aStVaE1tWnRwWmRQWnJJcGJiRkdZeGhMdWdjdFlpMHUzOXFybW1KOHAyUkx3?=
 =?utf-8?B?RkNBZWpkNk42dyt5TDlBZmh3azJPUm5aTHBSZFFKS3ZjUjVIRCs2cDJleTVX?=
 =?utf-8?B?TlhzWlczWHRpS0QydDliekVLbVNNL1R3Y2IwV2VZZU9RdkpTdzJmTG9NZkRO?=
 =?utf-8?B?OTdtRXpCbmpLb0NNS3BIci9oRXlkcldxZEU4VjhjdS8wdDV5Vi9LakpNUU5h?=
 =?utf-8?B?a3o2VW1GbWZVUXhqek0wNlNVYXdpbGNaOWRBenRETkVhZDBnMnI1MzR3VStE?=
 =?utf-8?B?Z0xwVFJoOC9aSHg2N1VHaWwvVnpkY3BOZ0JsOG41OVIyNDluNkhUVVJGckdx?=
 =?utf-8?B?RENNaWtyVHJSZFdIc1k2VTBDQ2p4bXVEUkJvbmhUZTVVSmRMV3AzVDIxQi9m?=
 =?utf-8?B?dHViVFQ3K0VXR01zZ3NyazEzRU5PYzlBNDB0RTFNUDEvaUw5OHM3OGxOYWE3?=
 =?utf-8?B?dVdtZ3R6dGg5VEMwM0tTbVVHcGVHK0tFbVhZWll6ek9LcTZ3Mi91NzRaTzlq?=
 =?utf-8?B?Q3VwL3RRSG9PTmdaa0o3SFM3aXJzYlZKS20wTjBXQ2RpbGtDU0ZZcUFNR3Jo?=
 =?utf-8?B?blo3UXoyU1pYNkFvdFpPYWhqWERqajFVc0RWWUFtZXR0VFRKNG8vY0hHUU9W?=
 =?utf-8?B?eEhLWDRGaGJvd0dYTXZwRHErMjFyT3ZqZWhGc0FSZmNzVFNxblJMQkhBVmE5?=
 =?utf-8?B?UXdZdEIxbzJkRW4vZWhQZy92bklUQjQwTml0QmpaWm1tZUdFS1p2b1V5OTBO?=
 =?utf-8?B?QzVURGQwTkYyU2pndUkrZjliejdwQlY3bjdvOTlRaEZ0MjVOa0tZVmJpNjVG?=
 =?utf-8?B?UDNCdXZLUFhibTlvajNHbnNmRFU0b1Y2ZHZiTFBUNVFSL0dicWUvSnRod1c2?=
 =?utf-8?B?SUo4dEliZDZqNDBZeW9YTHU4WG5IcWtCTk1lUmkvdmJMK1gwbExLOVBQR3Ay?=
 =?utf-8?B?U1ZjTWtBeTNrZlVVQi9UVUN2dmE1TzlZRVpkNERhTjA4dGxEc3c3ZkN6dURW?=
 =?utf-8?B?T2N2dW9TZ1pCRXVqR28rMnNHVEgycXFCSXRoc0pmSHFEaTZZdjVsdWtzRWxE?=
 =?utf-8?B?Z0EwRHlkRWFhcUl1K1VVQXVTSlhoaGFJV3diRElFN1dUMEVjWGRvNTlUaDhs?=
 =?utf-8?B?Q2xQREtsSlVzdCthcnBVdkx4YVEraU1LV3dDSVVrdDZ5bzYyT0RWTlVwai94?=
 =?utf-8?B?WkxncEpUMWMyUDl2SWRKbDZBVlhqTElaVG9wNHBTc2Jic3dXSGcvQlp3OVBV?=
 =?utf-8?B?Ri9sNlBjTk5vUlFVR0NuZ2hhY0RUL2x6Z2hrRFZRdHlvVE1ZaVVqY0V2Q2dV?=
 =?utf-8?B?QnV2SFB6SzhueloxYVVySllLN0tzWHp2cVZJbHB3YUliWnoya0R1WDBNK3V5?=
 =?utf-8?B?cVZHendiZU9LbnFjOUFGckxFTWRkcWViMFJ5eHFTaktDaUFHSUJHOS9PTUNK?=
 =?utf-8?B?bzQyckM4eTNJS3JSV3Z4akczQzE4NnBuYkxWcGYrUGlCaytPb29ZT2N1K2cx?=
 =?utf-8?B?Z1ZUdmtYR1dvcHE2WjdubUZLMFNHUTFuUTlmQWcxaXE1anNCcjlVNTBiVXhw?=
 =?utf-8?B?U3FiaWcvNTBuVzVndWhoTnQ3ZVBTcExJWEZNY3QyajlWQnBkKzNFNkcyWmN0?=
 =?utf-8?B?QzRMSXBnZzU5MHFrYmg3TkhxQVMrZDdUalJwUG1LTnhPdmF1VzZpalJGRkMr?=
 =?utf-8?B?OHprYmRZYnFySXJEV3ZvUmRwYTl6UWtqR3R3M2U5RlROUm9oQmY4bm83RlR3?=
 =?utf-8?B?aHhOL3hETEdUUVg2OCtJZmx5a3B5M01kMVpYZnAvRzl4N1VjMVVGRlU3OXZo?=
 =?utf-8?B?ZnMwMEduUW5kZmZvSGFsb0RCOXZpbVNZWnFVYVNYbkRQeHJxUXlLMHBpOWxs?=
 =?utf-8?Q?//jlTIFRayxLIjUQMgVcp+vlf3tCRdosHhvJtCL9Kb87Q?=
x-ms-exchange-antispam-messagedata-1: gKsIkNjBvCNwwA==
Content-Type: text/plain; charset="utf-8"
Content-ID: <878A82197CB25044947DF34A6977EBE0@namprd12.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 30d6c7fc-4050-41ff-fe91-08de4e5ac586
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jan 2026 02:08:10.0784
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UBua7f8yqvrKMiT39WjmDGvPZb6Yh5YE1d1Jd/NbXEN4+CywtP6iLq6FtNw71U8nMrQZEfEuBu96IO9ndTK5bA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5889

T24gMS81LzI2IDIzOjAwLCBEYW1pZW4gTGUgTW9hbCB3cm90ZToNCj4gRml4IHRoZSBjb21tZW50
IGZvciBibGtfem9uZV9jb25kX3N0cigpIGJ5IHJlcGxhY2luZyB0aGUgbWVhbmluZ2xlc3MNCj4g
QkxLX1pPTkVfWk9ORV9YWFggY29tbWVudCB3aXRoIHRoZSBjb3JyZWN0IEJMS19aT05FX0NPTkRf
bmFtZSwgdGh1cyBhbHNvDQo+IHJlcGxhY2luZyB0aGUgWFhYIHdpdGggd2hhdCB0aGF0IGFjdHVh
bGx5IG1lYW5zLg0KPg0KPiBTaWduZWQtb2ZmLWJ5OiBEYW1pZW4gTGUgTW9hbDxkbGVtb2FsQGtl
cm5lbC5vcmc+DQoNCkxvb2tzIGdvb2QuDQoNClJldmlld2VkLWJ5OiBDaGFpdGFueWEgS3Vsa2Fy
bmkgPGtjaEBudmlkaWEuY29tPg0KDQotY2sNCg0KDQo=
