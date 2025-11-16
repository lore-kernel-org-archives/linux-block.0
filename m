Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012011.outbound.protection.outlook.com [52.101.43.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F86E228CB8
	for <linux-block@vger.kernel.org>; Sun, 16 Nov 2025 05:43:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763271837; cv=fail; b=aVdb09S8fqFv8f+41q0ICx+sJpUo/LM6bHxybZvOS92QJjcXOZ+uel2CiUAwkqGxBOsJmpDnkRy7dwlWU/qwZRlYLFNJpkykwJmBcgJkILJlqfhO/piWC4O57JDQCECiWDOE3fnvggYkLAIVqfF30/OEXuxejCZ+x1bhjarwINI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763271837; c=relaxed/simple;
	bh=f9aQFjfiB8TM/k1oP68vj3fSahQJXPljoassaSzxf1U=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=VQW/E94xIpSEL8IRe7MekqH2ibDx3AWxOI6tkpq2CUFDxDdy+1TGCgLbPTSOG7bR+b81jtZzsA9R+Mxtxus/wIQhPUN7QjKGaoFrnEf0U7jAyQWTtHmzaz+Gz4vAns6lKvpynye60h7qy3G/GClF81Q+lWJZyuYogn3ad0XIoaE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=q/8LrmJI; arc=fail smtp.client-ip=52.101.43.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="q/8LrmJI"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qLYVeeNo2ur8Hp6avXVdeJIDKK3HlaSxGo7szjyZpjuojH6/E7QoSaiI1Cwn5YZAGhzTHrL21s3TmPFKYPHtHD3pkztFnnbVx/VHrXneNnGcRqDO2esUv9ze+Bp7Q1M5A6MY8xwaI/zDh53DFM3MwElpnf6qcsEsxQzIn85hgvb8mEW724zakIOs1kvHaZUmxxmCKlHR0pu5xcaZLZtEyqpK1ieB7LtOy1xq7WIPCUW3WlozZ0Xnw0SUvTqR6w/yMw8ZnrFxA2+MKKk/dLa9URd3kQRXzxU74RG8YYIveKcwiK6Nxc/s2TPg8sMXBNtZO0cAzHClVDQPdyfW/EpikA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f9aQFjfiB8TM/k1oP68vj3fSahQJXPljoassaSzxf1U=;
 b=iMWpDxr89B1dDHi1gVInEeIlvMhlUaCDXT5U4JS5wd6QeheQekG0Hjjb5ihUnq5SPYyXpqI0UGHY+Mejl46ucHZyr2wvZ/CEwxSwGm0rX7+h5yB717M1Y9y+YBuhHwJI+tNg9hIDDhu/Xq+x6T2xUx369qbhICEPBkwe4OgNySUVMcEzLaQnBxpmsjeA78b/pEFeRWtm69um5pGjDA7vpeHT6T5+MhUK6CG5EOW0Fx6uAc/87NG/d3ZD76KkS320kxY5gZdr2y08jAhYUxelKD9GysvCwQIIM00/DoGqqCjSB7U+Gkvf7k3Po0OQOxb1Nn5e/m5G60dEDblx3F/Nyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f9aQFjfiB8TM/k1oP68vj3fSahQJXPljoassaSzxf1U=;
 b=q/8LrmJIRFB1SkQ5ll9LKVd8DjwJrnZQ07Ho8w7yhV6za27rgtSXxeRgawGlI78rkee62tE/4fHjAm93Ar4oLqd66hDwszCmzlwER9gQhD8zKnB17jMQRHfhRWXll0KXYnPQ97En+6amiKqy5qYchCbFqgNbSFKTQStCpvdtmFJE9o12Yt9ILMWEDSJBval9NHJoerd5Wx1fDvzWH1jx5zZog8z+LPPahtJYr8909EQOEF9m2vuRGKMaEPlZMpCQD8FuKXBN9Npxyuw5LvKw+X50tMR/VtSApMmfcLLT5rfyXqdIlIXmcdTpmj5qiVp/n+i5uQi3oi0geuh8y3I4WA==
Received: from LV3PR12MB9404.namprd12.prod.outlook.com (2603:10b6:408:219::9)
 by SJ5PPF6375781D1.namprd12.prod.outlook.com (2603:10b6:a0f:fc02::995) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.18; Sun, 16 Nov
 2025 05:43:53 +0000
Received: from LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b]) by LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b%5]) with mapi id 15.20.9320.019; Sun, 16 Nov 2025
 05:43:53 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Damien Le Moal <dlemoal@kernel.org>, Chaitanya Kulkarni
	<ckulkarnilinux@gmail.com>, "linux-block@vger.kernel.org"
	<linux-block@vger.kernel.org>
CC: "axboe@kernel.dk" <axboe@kernel.dk>, "hch@lst.de" <hch@lst.de>, Chaitanya
 Kulkarni <chaitanyak@nvidia.com>
Subject: Re: [PATCH 1/2] loop: respect REQ_NOWAIT for memory allocation
Thread-Topic: [PATCH 1/2] loop: respect REQ_NOWAIT for memory allocation
Thread-Index: AQHcVqQSWk1ka6Xc10yTpB77BDOaP7T0qwUAgAAfqgA=
Date: Sun, 16 Nov 2025 05:43:53 +0000
Message-ID: <67472833-fd71-42a7-ac32-26e1da30f3ad@nvidia.com>
References: <20251116025229.29136-1-ckulkarnilinux@gmail.com>
 <6f76d0ec-a746-4eaf-abe9-86b51d2ff9db@kernel.org>
In-Reply-To: <6f76d0ec-a746-4eaf-abe9-86b51d2ff9db@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9404:EE_|SJ5PPF6375781D1:EE_
x-ms-office365-filtering-correlation-id: 6f916a55-f005-4d73-8407-08de24d32052
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|10070799003|1800799024|366016|376014|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?NlhVUUN5REdCYmFpTHJ6MmQzWWs0cWNjQ3pEQTI1dkZteVlCZ1FPcXVldjBj?=
 =?utf-8?B?QjB6dWZRTjJRbmhPNUsvMDdsaFR1Tkt1ck5mTWlXcGRtNW1QRnNoOFJNMmRz?=
 =?utf-8?B?SXMxMHZOMW8veTBueDNBNkNNMzkvc3h5ZWQ4TEVHYmV4aExxcGhaeW0wZWFH?=
 =?utf-8?B?ZXJRYVR5aHBneEZPWWxSakkvZWQxUVAvd0FVSGpHY0xZeVhOMVJCNEd0MTdF?=
 =?utf-8?B?c3k5eU5sSXU3cE1QYm8xcGNhUnJjQWxjc282QXpVNkZyRWNJSW5lK3U1ZGNw?=
 =?utf-8?B?ZnZmUWc2eldhU0JqRjUxeHFIQ3FVb2xGK0E2R3phekphdVI1MmhoamMzZ0V0?=
 =?utf-8?B?WG9NdWdJSTBacGYrRllDaWdkd21VcjcxZUY1TmhuVzk5UHUwNWNZeUlORyt0?=
 =?utf-8?B?YzdrOXU0L0xzVkh3ZlhxTVdjd2ZWemtVR213RFJLT3pldEJqRG5JemhTcTJZ?=
 =?utf-8?B?WkdpNHVRREh4ZW8rODhLc055OU5mQjMzR0JQV3owUVZEaVptVXhlNTFKS25S?=
 =?utf-8?B?VG5uY0dNNDYzdE5oSVNsMVNvQ29vcXhyK0lqZFM3UVdZVTZjd0ZTMnNFREh2?=
 =?utf-8?B?Y3VHOHI5Ly9rWVpCaFVoZ0x6anRQWG9TNy9yaldLcUk2Y0lveFYxM0I2dEoz?=
 =?utf-8?B?R1VBZnZBbk1Eb29ZUHlYUlQzVEwrbS84YkwwY2QrK1h0OUhrSC9VSWxGNEZH?=
 =?utf-8?B?TythSzZOMWorZUdFNEhFaUpNTmMrbHJMRjQxem5yTHBwSVF4KzJjQ3p1OFhR?=
 =?utf-8?B?SlBVYXBvVUF3V3dFWHVJRXZ0b0FiTTBEUmNFYnhISDFuT3pocFlidHpWTWNm?=
 =?utf-8?B?MFBvdzJKZnlVS2NCWlAxMEJ0WExZbjFSNk5MQjUwOG1YRlFHa0NtZWNwcmFp?=
 =?utf-8?B?dG5yUHkzSzU5MnJqYkZZekwyeWwrRFUxd296Vm54WVM5OTlwYk8zSEFuRHFF?=
 =?utf-8?B?c3hzZ0FLelNJUThvbGs5WjVwT0g3N0R2UVJTYkFqYW1GSlEydXVtc2I0d1V4?=
 =?utf-8?B?UnN4ZmtOVlpTNnlSU3U4aGJIc20rNS9GSVhUZ0xDck9jenh5MjYrUS9NQzRF?=
 =?utf-8?B?SEFKMlM3UkVkaDhjNzJLa3kwV0dTendUV1VpQ3EyTElLYU9PSzltMDBuVytG?=
 =?utf-8?B?MFpROHJZUThRZy9BL0V5UmU1QnVrYVdkR0c3b2NhNzUwT2RyT1hXcmU4T3BS?=
 =?utf-8?B?VytlK1lGYndCaTBWclo5SEZTaFlHRUN2N0RHM1dOcjEwZlZOc25zcGpqM1Rz?=
 =?utf-8?B?WUpqMVE0VmdsMTZCeTErcGZZVCtabUpaM0M5OGFBei8wZlRHZm04SG9jUFFr?=
 =?utf-8?B?RWYyYkprVWZLYmFmcXRGSWo2dEE5MWFoK3lpcm1tUFdsMDJ5YWVmdERXOU5v?=
 =?utf-8?B?UnBYUUppS255WURLczlGNGthTGdCTnFKY0RDOWQ0MnFNMDRGOVMwS0pheFVW?=
 =?utf-8?B?MXBvWVVDbFZPVFlBeDRqK2hCWDZaWE82WUNySlhjUXNQb3FEYU1FT0QrYWQ1?=
 =?utf-8?B?NG92VExtM1pnTkQ3OGRsZHFuQWo5S2wxYkoxYy9tdDZDWGNWdFZkTzhIbGg4?=
 =?utf-8?B?cFpDZXV3a296aXUrMVN0SllvMkVEUnFWUVB6QzJ3YWM3eXBkeEwydTQ4ZExw?=
 =?utf-8?B?WXB3WDk4bGl1bmlIYnFZRm9qcnhuL1pkMzVHdHhjdDQ2Lzhaa2FyZGVmbGQv?=
 =?utf-8?B?Mis1ZFN2VkEwd1ZyS3hxVk5oRG1razRaQnpsckZnYXp0aDdqdHNUUjFKaWZY?=
 =?utf-8?B?NldJMStFTUxZNjFoMTFOMktCZWlJUW5BLzRJM3YzekdWUHZPdnRBVllKWTBs?=
 =?utf-8?B?MUwwNGM2eWMrbXR3aDhuQjZRNnBXSW9HQTkxNjNqUlBhWU5aWHJ4MmNiVUlh?=
 =?utf-8?B?VmRYY1gybTQ5Y1JKb3JFWU5TZmNTSjlZQWcxaHFIL20yVCtpdHh6OUVLNy9N?=
 =?utf-8?B?d09LSFVBUW91cXVNQ1k4RXZEL3RTc2pNK3ZiaU93bkhtQlRYbGZmZkZiaVJT?=
 =?utf-8?B?WDEwVGp1blIvOU4rSXhpQlVIVXR0UXpLOWY0dDlkcVNZek9RaFJxalpzbGxT?=
 =?utf-8?Q?RblWyU?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9404.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(1800799024)(366016)(376014)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?MkE2SGl3RVFBZ1A0ZVpvbmRzQzBNSkNGT01va0ZzakpDdDJHb1VNWVNKNUVi?=
 =?utf-8?B?VHpGTURVMTRqVkR5SU56Q1pCRGR5eEhGeDZQWjE1NUJSbFlCelFLRmV0Smd4?=
 =?utf-8?B?R1NIMGRGWTRuaXdIcERiR2lYZC8ySkZlZ1pVcG9FdURjeFR4aTcvbGY4TW9F?=
 =?utf-8?B?TVFCMXNuZG9yeGtHL2hwbW9RamVCa0lFNTV5ZEY0UzhZbjdjYjlvOWRpWGNl?=
 =?utf-8?B?bkVIQXhZa3E0UmtFWkFaeDZPRFhUekEvUkFISWNXWnVuNGFYREdaL3RNR0R5?=
 =?utf-8?B?ZC9kQkVZUlhiOVI0SThYelBETW0zM0hNSzQ2d3IvNkttd2xTUUtreEVLN3kw?=
 =?utf-8?B?MmhxSFBxTjRLTVcvNHBjSVQ0RDFiZ1JiaEdTZ0dtOWNSUnEwS2lhL2M0Ui80?=
 =?utf-8?B?RUx1ZjdrWUN6KzhPRlVnM2l4M2duZDhBSFFHZnJ1NTVqWUk3V2JpWVRCRUxI?=
 =?utf-8?B?TkVQWnZCTWRoSm5TV0twUEJYM2U1dEgveEtHMEFzNUdTVlhUNkZreldPVkNw?=
 =?utf-8?B?Y1RwS25CL1JyYWhxOFhuQURRVWo3eHRnT2UxQktSOThEMHBQWVBTZHJhMEQ0?=
 =?utf-8?B?RDdPb1RHMnFVUlVVYkZiV3pHaE1VcnJKMnlVNWxMR2o0QkpMRHlLRHhwdGE5?=
 =?utf-8?B?djJsYTNHZ2Rpdkd3TVNXVFhjNGo3dE1GWWV3L2prK0Q4YWs3enV5TzMzQ0pz?=
 =?utf-8?B?QkdIMVdJdnRVUXJhTitKeGQyY2I1cmNTSmdQbTc3UWp1TFZYMUFJMjJZNVBJ?=
 =?utf-8?B?TFBVVmp1aVdiWFYydWhPamxSSk5nZUhvNVVWbXU1bW1hWE8wTWNTMzl3NGRa?=
 =?utf-8?B?K0V0VXFHOUtvQ3Z0bnIwRElIV3JRSVQ0T2dXa0d6cUhJUktUWEU1N3R6OVlJ?=
 =?utf-8?B?cU1vL0R3SVBuN1hSakM1b1FQaHhkbGZ0dzZUdUd1NkZuejJQTHRsdHQxRXRF?=
 =?utf-8?B?ZjU2MGpKMHcyTlNteHZoY3hOYTA1bi84bFRLRWwyZisxMnFkYjluZDFUTC9C?=
 =?utf-8?B?ZnJaT1pCaE8xMUpXVG5oSnJqay80Z0FGUktqWGhxVDR5cmUxVnJBZVRUS1JT?=
 =?utf-8?B?S1NLNWFkd1RyV1NTWUpsUVZja1ZsSmtMVElHREJZbGdXZjdNTjlBYzVDaXVR?=
 =?utf-8?B?MWc4WnJEMGVxZ28xRDdNWUgxRG5hUEQvTEJ3NkRyNU96K2w0M0R0UVpPRzFC?=
 =?utf-8?B?bGhieGVpSS9TMmM4bkZqaGw0WnBickh0ZUhSSVFSVFlKNUZEcXo1MEcwQnhZ?=
 =?utf-8?B?VGZ4Wm1JQmZtNmkwb290dFdPVUhMZGxic2MrV0FGUXVRWTQrMXgyL0dUdGRy?=
 =?utf-8?B?WitGNWFMcllVWUdXbzdHNThITDNqMGRKWUd4SmZvVUt1Uld6c1lObEh5YkVE?=
 =?utf-8?B?OGorNkt5V1RJREdWcXdLaFJmc0Rud1RDeWsrVmZZQTdkd2x4dUtnQVVYd091?=
 =?utf-8?B?d05hejE5VEU5WTVRTm5NT3dMNXVXVWY4TVNOSUhXdVR3dGEzR2J0U0xydHRM?=
 =?utf-8?B?T0lCNE1tRS9CaUxlVFZLMWRqcnZLb01EaHVta2RhclZicDhRRTJPdFl4OGto?=
 =?utf-8?B?aWRZVWVEbEx5aXBYWjE0Z2wwcHhXLy8zQ3hTSER6QlRGcjRXSGgzMmk3eTFH?=
 =?utf-8?B?TUNjSmY4WWZuSjNYem40VzVaSithRndzZi9mYmlWWHNqWGJpZ0UzdURsdjdH?=
 =?utf-8?B?Zy9QN2FvUU5aeFpHaTd0KzVDMUQyU0RSVU8yclBsYzBHTEhxNGNGSUR4eTc0?=
 =?utf-8?B?SmFsb0FhM0dTcGU1b1RudHZzZDZ1TEpBdE5kcmdkalpxWi8vY1orTFE1MFJD?=
 =?utf-8?B?ZDlTQmI0azlKUWVzVEVJUUxwcTVKckdLM1hKNWlmMzJkZXA4MkhPZHhFa3ZD?=
 =?utf-8?B?bUFNanpJMW1wTFRNOTdqRDRzMWZXYVNNTHMwRFFNc2JwaFVYcDdPVVpPeUFm?=
 =?utf-8?B?eHhxMnRUcGt5bnlZaDZRc3JNK0FyTlMzK1NudWZRbll4QzdSMEs4ZnlmTEhF?=
 =?utf-8?B?ZTJaOGRFL3VSbEJ2RFVwc2oxWStyNjYvRFEydEpndmNVYW0rVWpFVjBpNjJh?=
 =?utf-8?B?d2xQRW83M1hqTFlNUkw1TzZreU9wN1djWFpJdzJObzFkU0xDb21rU0hJdVFW?=
 =?utf-8?B?N28xTWFuOTdJNjN3eHFUeWpZK0pzenNLY0JkVUE1U1RRajlqbGJHTUtQakVP?=
 =?utf-8?Q?8hEpNc2gUTxpJLtwEzvx2g2I7yX8Wf5SVW6zIx1lPA5Z?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <8C9E798FA122F0468D54ED613194BC1B@namprd12.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f916a55-f005-4d73-8407-08de24d32052
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Nov 2025 05:43:53.1976
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: egtDAXwRK9kVJQuCC4zm6kkMHAhZxG03pylJQE8l7H5bW0nzoNgT7II+hj7JyIofZRiBBI3AgYWsrX4dGYmWrg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF6375781D1

T24gMTEvMTUvMjUgMTk6NTAsIERhbWllbiBMZSBNb2FsIHdyb3RlOg0KPiBPbiAxMS8xNi8yNSAx
MTo1MiwgQ2hhaXRhbnlhIEt1bGthcm5pIHdyb3RlOg0KPj4gICAgNi4gTG9vcCBkcml2ZXI6DQo+
PiAgICAgbG9vcF9xdWV1ZV9ycSgpDQo+PiAgICAgIGxvX3J3X2FpbygpDQo+PiAgICAgICBrbWFs
bG9jX2FycmF5KC4uLiwgR0ZQX05PSU8pIDwtLSBCTE9DS1MgKFJFUV9OT1dBSVQgdmlvbGF0aW9u
KQ0KPj4gICAgICAgIC0+IFNob3VsZCB1c2UgR0ZQX05PV0FJVCB3aGVuIHJxLT5jbWRfZmxhZ3Mg
JiBSRVFfTk9XQUlUDQo+IFNhbWUgY29tbWVudCBhcyBmb3Igemxvb3AuIFJlLXJlYWQgdGhlIGNv
ZGUgYW5kIHNlZSB0aGF0IGxvb3BfcXVldWVfcnEoKSBjYWxscw0KPiBsb29wX3F1ZXVlX3dvcmso
KS4gVGhhdCBmdW5jdGlvbiBoYXMgYSBtZW1vcnkgYWxsb2NhdGlvbiB0aGF0IGlzIGFscmVhZHkg
bWFya2VkDQo+IHdpdGggR0ZQX05PV0FJVCwgYW5kIHRoYXQgdGhpcyBmdW5jdGlvbiBkb2VzIG5v
dCBkaXJlY3RseSBleGVjdXRlIGxvX3J3X2FpbygpIGFzDQo+IHRoYXQgaXMgZG9uZSBmcm9tIGxv
b3Bfd29ya2ZuKCksIGluIHRoZSB3b3JrIGl0ZW0gY29udGV4dC4NCj4gU28gYWdhaW4sIG5vIGJs
b2NraW5nIHZpb2xhdGlvbiB0aGF0IEkgY2FuIHNlZSBoZXJlLg0KPiBBcyBmYXIgYXMgSSBjYW4g
dGVsbCwgdGhpcyBwYXRjaCBpcyBub3QgbmVlZGVkLg0KPg0KVGhhbmtzIGZvciBwb2ludGluZyB0
aGF0IG91dC4gU2luY2UgUkVRX05PV0FJVCBpcyBub3QgdmFsaWQgaW4gdGhlDQp3b3JrcXVldWUs
IHRoZW4gUkVRX05PV0FJVCBmbGFnIG5lZWRzIHRvIGJlIGNsZWFyZWQgYmVmb3JlDQpoYW5kaW5n
IGl0IG92ZXIgdG8gd29ya3F1ZXVlID8gaXMgdGhhdCB0aGUgcmlnaHQgaW50ZXJwcmV0YXRpb24/
DQoNCmUuZy4NCg0KbG9vcF9xdWV1ZV9ycSgpDQogIGxvb3BfcXVldWVfd29yaygpDQogICAgLi4u
DQogICAgLi4uDQogICAgcnEtPmNtZF9mbGFncyAmPSB+UkVRX05PV0FJVDsgPC0tLQ0KICAgIA0K
ICAgIGxpc3RfYWRkX3RhaWwoJmNtZC0+bGlzdF9lbnRyeSwgY21kX2xpc3QpOw0KICAgIHF1ZXVl
X3dvcmsobG8tPndvcmtxdWV1ZSwgd29yayk7DQogICAgc3Bpbl91bmxvY2tfaXJxKCZsby0+bG9f
d29ya19sb2NrKTsNCg0KSSBoYXZlIHJlYWQgdGhlIGNvZGUgWzFdIGFuZCB0aGUgY29tbWl0IHRo
YXQgYWRkZWQgdGhlIGZsYWcgWzJdIGFzIHdlbGwuDQpJIGNvdWxkIG5vdCBmaW5kIGFueSBtZW50
aW9uIG9mIGhvdyBzd2l0Y2hpbmcgdG8gYSB3b3JrcXVldWUgY29udGV4dA0KYWZmZWN0cyB0aGUg
aW50ZXJwcmV0YXRpb24gb2YgUkVRX05PV0FJVCwgb3Igd2hldGhlciBpdHMgc2NvcGUgaXMNCnN0
cmljdGx5IGxpbWl0ZWQgdG8gWFhYX3F1ZXVlX3JxKCkgaW4gdGhlIHJlcXVlc3QgbGlmZWN5Y2xl
Lg0KDQotY2sNCg0KWzFdDQoNCmZpbyBjb250ZXh0ID09PT09PT09PT09PT0+Pg0KDQpsb29wX3F1
ZXVlX3JxKCkNCiAgbG9vcF9xdWV1ZV93b3JrKCkNCiAgICBxdWV1ZV93b3JrKGxvLT53b3JrcXVl
dWUsIHdvcmspOw0KDQpmaW8gPT09PiB3b3JrcXVldWUgY29udGV4dA0KDQpXb3JrIHF1ZXVlIGNv
bnRleHQgPT09PT0+Pj4NCg0KbG9vcF93b3JrZm4NCiAgbG9vcF9wcm9jZXNzX3dvcmsNCiAgIGxv
b3BfaGFuZGxlX2NtZA0KICAgIGRvX3JlcV9maWxlYmFja2VkKCkNCg0KICAgICBzdHJ1Y3QgcmVx
dWVzdCAqcnEgPSBibGtfbXFfcnFfZnJvbV9wZHUoY21kKTsNCg0KWzJdDQoNCiBGcm9tIDAzYTA3
YzkyYTllZDk5MzhkODI4Y2E3ZjFkMTFiOGJjNjNhN2JiODkgTW9uIFNlcCAxNyAwMDowMDowMCAy
MDAxDQpGcm9tOiBHb2xkd3luIFJvZHJpZ3VlcyA8cmdvbGR3eW5Ac3VzZS5jb20+DQpEYXRlOiBU
dWUsIDIwIEp1biAyMDE3IDA3OjA1OjQ2IC0wNTAwDQpTdWJqZWN0OiBbUEFUQ0hdIGJsb2NrOiBy
ZXR1cm4gb24gY29uZ2VzdGVkIGJsb2NrIGRldmljZQ0KDQpBIG5ldyBiaW8gb3BlcmF0aW9uIGZs
YWcgUkVRX05PV0FJVCBpcyBpbnRyb2R1Y2VkIHRvIGlkZW50aWZ5IGJpbydzDQpvcmlnbmF0aW5n
IGZyb20gaW9jYiB3aXRoIElPQ0JfTk9XQUlULiBUaGlzIGZsYWcgaW5kaWNhdGVzDQp0byByZXR1
cm4gaW1tZWRpYXRlbHkgaWYgYSByZXF1ZXN0IGNhbm5vdCBiZSBtYWRlIGluc3RlYWQNCm9mIHJl
dHJ5aW5nLg0KDQpTdGFja2VkIGRldmljZXMgc3VjaCBhcyBtZCAodGhlIG9uZXMgd2l0aCBtYWtl
X3JlcXVlc3RfZm4gaG9va3MpDQpjdXJyZW50bHkgYXJlIG5vdCBzdXBwb3J0ZWQgYmVjYXVzZSBp
dCBtYXkgYmxvY2sgZm9yIGhvdXNla2VlcGluZy4NCkZvciBleGFtcGxlLCBhbiBtZCBjYW4gaGF2
ZSBhIHBhcnQgb2YgdGhlIGRldmljZSBzdXNwZW5kZWQuDQpGb3IgdGhpcyByZWFzb24sIG9ubHkg
cmVxdWVzdCBiYXNlZCBkZXZpY2VzIGFyZSBzdXBwb3J0ZWQuDQpJbiB0aGUgZnV0dXJlLCB0aGlz
IGZlYXR1cmUgd2lsbCBiZSBleHBhbmRlZCB0byBzdGFja2VkIGRldmljZXMNCmJ5IHRlYWNoaW5n
IHRoZW0gaG93IHRvIGhhbmRsZSB0aGUgUkVRX05PV0FJVCBmbGFncy4NCg0K
