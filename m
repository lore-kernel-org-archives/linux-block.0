Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012026.outbound.protection.outlook.com [52.101.48.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 967333128DF
	for <linux-block@vger.kernel.org>; Sun, 18 Jan 2026 14:09:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.26
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768745355; cv=fail; b=cLuiCYWLrxPggvD+RyCkHsPDLJA1mfIKJG0t8hB63d4+K0xPfh+jpWdfl3aHz8UTKqCpil1uo75xRnRbLqSJqZVRxjWjsNvWKbNHxiBDCtBc5Glns7OybJI6I5phhf72ziMJ17Ny8rNuYR81ihc2eL4e+KGxH9lpgDLxhKtJtkQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768745355; c=relaxed/simple;
	bh=RBJbUscS6/KpK097CRGwibpxsC8Nm36MP1s/+DvCtoE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=GXFsRIfZiQ439iuZLbPLFtVi6hJ3S6ndKzUeXk1vjmgWp4JmpY6It61SZXKjNbZgmgP5IooeR34pxMT+2KEdS6jR4GzRWlF+9avULAlpqog3GmzI0sp2GMwW2Z69gS6oIO0Er4/iKNOl+aFDFCOqTr+uiIIL2JkITPX4balKhT8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=e5t7sSzS; arc=fail smtp.client-ip=52.101.48.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="e5t7sSzS"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=q1t5sHI386vuQr94iOCKI2SqcQeCJ/M9DYxKns1yGmAvVGPojlf32lctO8IkGBA0NJABForf17LQfwfiXHZe5evsqxVbZF/EJOHAbe67AtwVqn7OIhH8GkVB0F1nEdresyeUlC3CzlmKv86LFQkqO37sVut5zj3byh06j74CNy7expPHVxi5frrkYw9KEcV+ZHob/vn6cUoLKwaNj5z8JvIw8j9Z9MPbsZmf0PeZg6vmqF/zH9Dt0de+vxsRJy0qS8pVMqOUVdE8iyKETfa0VC39cu7QBRgLirTbXqmxbSMpe5t8GmzOmvwowoWHQTOeZ/27NY5al4GGrkIAp4eejQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RBJbUscS6/KpK097CRGwibpxsC8Nm36MP1s/+DvCtoE=;
 b=c60H5+J5AG0+IYAkqqz7A0iIQ11CVo+nxeiYSAd1XJaIee+cqUqF3R5PwA8WldJWenFHjkll23pjnxFxFB1AqAJJneQR65AN5sjBf0cqn9GnKXLaq67miWOKfsplhYGMx2VCiUuw3KP/K24eHHDh7B80WwAoa7gdQd+IAsGsUUnHFGK4EKn2DuZgwA4m+czC/MjplCGDn1Zlpw9jYR8B1jyQpHUoHDBBnVwpMmv9axi4ji5cLghJLsbR2wnaBPy56UHwHTbDc/3zYtlF3rpwOHWKS/silhERNSR1oWBxPNn+rZpsfcKTPUZB18Iqqld9aLX3ll8NHd3CLqsv1G3R5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RBJbUscS6/KpK097CRGwibpxsC8Nm36MP1s/+DvCtoE=;
 b=e5t7sSzSahD7JXvBs27AxMLgGwL+Dr7J2NntItq8yHamevrulGwTzWFnAt0P/dogFIsvgvooCcv+tyrZwZuj/9e6kriZ/g00EHwpt09Ijvgji1UDyYAn9A7wOHHsqsKv9eXkMjFv7+wXuvsB+HCcWk6X3FPQv3qiCzjNudk6PRKIoWVNzH2JuwD4RT/nTW6uZu1yj/eZA9E5GDNz7Ns4nBPQFcnwjfvaLWdquBmk/m2P6KjUA74sqqlzRdYPYu7fO8UJ6eZrz2AZ96WksQBOL/koRM5hjAyRgYfSq11KoS1Dd8hkhaOrqRkC1JU1ycEQSdf7Gy34DhzJOpTJPKQwGg==
Received: from DM4PR12MB6328.namprd12.prod.outlook.com (2603:10b6:8:a0::16) by
 MW4PR12MB7359.namprd12.prod.outlook.com (2603:10b6:303:222::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.5; Sun, 18 Jan
 2026 14:09:11 +0000
Received: from DM4PR12MB6328.namprd12.prod.outlook.com
 ([fe80::35dd:a6f9:6b74:3caa]) by DM4PR12MB6328.namprd12.prod.outlook.com
 ([fe80::35dd:a6f9:6b74:3caa%5]) with mapi id 15.20.9520.010; Sun, 18 Jan 2026
 14:09:10 +0000
From: Yoav Cohen <yoav@nvidia.com>
To: Alexander Atanasov <alex@zkern.zazolabs.com>, Ming Lei
	<ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"csander@purestorage.com" <csander@purestorage.com>
CC: Jared Holzman <jholzman@nvidia.com>, Omri Levi <omril@nvidia.com>
Subject: Re: [PATCH v4 2/2] ublk: add UBLK_CMD_TRY_STOP_DEV command
Thread-Topic: [PATCH v4 2/2] ublk: add UBLK_CMD_TRY_STOP_DEV command
Thread-Index: AQHcf0vWxjzS10H3JkqOapULI6psc7VYCJ2AgAAA0oA=
Date: Sun, 18 Jan 2026 14:09:10 +0000
Message-ID: <fb2d4e85-d1cc-4e8c-b22c-e1f982b2a9a6@nvidia.com>
References: <20260106203333.30589-1-yoav@nvidia.com>
 <20260106203333.30589-3-yoav@nvidia.com>
 <922b4c45-14ba-497b-8a00-eac2903a2854@zkern.zazolabs.com>
In-Reply-To: <922b4c45-14ba-497b-8a00-eac2903a2854@zkern.zazolabs.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB6328:EE_|MW4PR12MB7359:EE_
x-ms-office365-filtering-correlation-id: 967d9ada-6a37-4778-7050-08de569b271a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?c1FWdTRycXhYcXRvTy9QTjBsV29hM2FTanlkbzNQTWZTLzBuT0xyNG8zMUdm?=
 =?utf-8?B?K2U1S0JEV1NvUzYxT0JxVHpzelVqME5qVngwcVc2STNPZlR2REtDZVdPTGU1?=
 =?utf-8?B?SkNOM3FqcDJvM1ROM3RFbFh3c2pvZXNPQmVORDZBcDFMOHRxTFBYdk5BUWs4?=
 =?utf-8?B?VmwxWWc5UmJUN3FTWGVvY2xTREtFVTR0a3BrbGwxVGJJMVdCM0plNndDdjdF?=
 =?utf-8?B?SkpScS9YV0JsTjUzeUxCZEVIQWt4U3RYU3dBcmlIeDBPdVJKcDZaMzlZZnFw?=
 =?utf-8?B?cjAwVC9aLzUvVlovdEJlTERXbzJVK3dzTk1xWkFUOUhxL3VSbVVJbVdnMHF6?=
 =?utf-8?B?eit2WVhTTHE4V1FFS1B0RXZYeVVxY0NUdXEwamhIWWgxOFowWXRSeCtya3BM?=
 =?utf-8?B?Z3lHZEdnSXRhZzB1MzFlUERib01DSFM1UUFHUDJvdzh2L2laUUJudC9reFo4?=
 =?utf-8?B?UFA2eG9BV2hVenMxRDVpZTNnZGJRY1YwMjFqanlkTWVtcDhSYTR6SW9JY2Rn?=
 =?utf-8?B?NE83SUE0eXU5UStCejBvai9LaytqZFpoVjMrSHpFWTUwNi9WTEw1M2FlVnlC?=
 =?utf-8?B?TjJOYTF2V05sd3F1VmoxSDFkaS92Y2VyWU9BNmJZQmxrbWhLTURIRmVLQmkz?=
 =?utf-8?B?S2d4Z0xrRk00MFVpak83ZE9FREx0TEVxOWVXVVZjT0E0aUlHSFdxZUg2a0Nw?=
 =?utf-8?B?dU9qVUw1MnZqWmZ2dWxhdHNkOEFETjhXLytQcXR1Z3NMWjhNWjZyMUlYblpr?=
 =?utf-8?B?bjVwa2duMWc1d0cxbjJWUmdQQWhsd1BwNmxUZ1FLZE1vWDdTZWVEWTZGNkZ4?=
 =?utf-8?B?VlRZdTFWNW5SWnBrQmZYSFJLbW14WkV0K1R1TGlBVmZ6V2pEL3dqYkFXWGhG?=
 =?utf-8?B?NnA2blZxTyszNCt5RGhOakZZbXNVYlFDamdid3plRlVnTjJHUk9CR3MwWjFr?=
 =?utf-8?B?SnRUUEthTlB5dy9CL0QyemxnVGNWV3h5M0JkZnlpOGZIM3hSQVpOVklhK2ow?=
 =?utf-8?B?VStQSm5LQ2pVVHlEa2Z6cFJEUjJjZVZFV1VjOWlvWnQ5QVRzVDJieTdyRWxX?=
 =?utf-8?B?SWU3ZjdzS2FQQkFsQm44UXBweGZKMVNsMjluakZGTGhwSzdCNVYvZVpUQVZq?=
 =?utf-8?B?TThaL1VJVFZkeWYvdzREbXRNZUJlQ1hMZGNPL0I0blRnMm5mYTc5bFpQZUJ1?=
 =?utf-8?B?K2RqSFUrUlgwZTlFWjUvbzZsckFGaHlSZEpzRExqQmVGbzM2ZHdoSmF1Q3hw?=
 =?utf-8?B?TStkM1V5UGs3R0xhZkQ5bUNxaHlpd2RIVXFRNzFjLzZnTUhMdWJTRTBWNTI1?=
 =?utf-8?B?YkRHQ0Z1WFk5WU14VlFJUmVVU0xpYjNxeGJUemcra0NPUEh0WjlEbTR5dUpM?=
 =?utf-8?B?MTN0VWtEMGJyLzVRM0ZYR05ZOE5Na3A3NWxpTUxhMktIRE5XTGcvNCs5THdY?=
 =?utf-8?B?eXFoY0tlTGV4Q0lDU3pyT2g5ZzRsN0pteFVZdkt6ZmQzaDEwbmF5bWcxUE1K?=
 =?utf-8?B?cEFvc2Nwd0VJZ2VQZHROWTBiZWFBN3BMdUFZOUYrdFY1VDZVNjlvTUdweEo4?=
 =?utf-8?B?c2U4TEtRK0ZhaVA0blJlTndQYjBFUElHQ2RteGlxVVl2cndhZlI3cUU4ZEJn?=
 =?utf-8?B?NlFwcHdwWFNkcjQyR2NMdVI3b0xkTmV2K0YrejlVc0J0cUZ3RUIxZmR0TVBi?=
 =?utf-8?B?NVJhOUQ5VlJLSzh4Sk9mSmdXOFhkNWZXZkdWTHlCNENWc1M3VnBsNDdTc0Rm?=
 =?utf-8?B?aWVhNFRoakpnaGtMbEZ4Qmx4Sy81MWhhejU0YUd4a2hiQmhkSjhQTFFObGdY?=
 =?utf-8?B?WEg2N2dORkhoWnVJcmZaVUN5REIrZkU0WkFLTjFSTVM5R1dxRjFOT3F6TmNn?=
 =?utf-8?B?U2N0THNrL0IvSU1zYjFmT25HcXNWdTdJOXFHU1VTc1RRcE83Q2haVVNMY1Rv?=
 =?utf-8?B?S0VEZExZUTdxaXppSExEc21aQXFGb2tIR3VWVXRBK1BlaDBmdkxZSy9lMFRH?=
 =?utf-8?B?RTU4cWJtci9pbVE4aFppRXliZzJUQWJ6NVYvdDB6Sm1hUnkwbHVKU2M0MWdN?=
 =?utf-8?B?V0JxUU51RFhaT3doNjFSaHR0TzV1VU5ZNkxscmFJUXhFamFnTDdDTTVsMXZN?=
 =?utf-8?B?a2dpSlMyQ2xJVVpLOUYvejYrQWowL3RSWkZOcWgzUGV2ZGphMTB6VXlVZW9t?=
 =?utf-8?Q?NLc+ciMF83hKbeCTSX60s+o=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB6328.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?dkVqR1RPY1FyNE5XZWZtNVFrbXQvVFVDQllHVzhZVUU1cVV4TWVlQXpjTEE0?=
 =?utf-8?B?eWpCUFJ2UTZodmt2dDJrZTQ1QnR5UEF3QnBHbVFiSUc2VWhVSUp3elRUVk9r?=
 =?utf-8?B?cW5aV090RndudG5uclZ1QlNEMkZraHhuNzNsTkxpUVpROHp1K3F6V3Vnd3dy?=
 =?utf-8?B?c09JMGJxV241S3ljczFaekRqT2t3Nmo3VXlSbUVTSEM0Y2wxby9iK0dxNmh2?=
 =?utf-8?B?Rk5MeUI2cE1aU3VPOSs2MGluWVBrU25vR0l4QVlmZks0TjVnN3k4NENUdHFj?=
 =?utf-8?B?YTdpVWNGcjhzM1lhOVN2Zk0yOHpwbU1qNnMzOG0rNVcxcWhFdFprajNoMytI?=
 =?utf-8?B?elFPUGREbGQ0NTZIbWFTM0JvYnlnSVdBbDgxVXhOelRBSjluN3J1SzdzVzRD?=
 =?utf-8?B?ei95eGlwUGY1T2R4a2wzNjZPak9WV2phK2l1TkNWTjZVd3NYdXp5NDErNkdP?=
 =?utf-8?B?WDBxRzA1d0UzLzdqVGh1eFdJSURWTzJOV0hscFhJdTB5K054TjJmeDhTOUlT?=
 =?utf-8?B?ZExJNHAwb3RXT1NNN3BrRUs0azVlbU9NNUYxTGNWdk96WjdRRHFrcEl1ak9J?=
 =?utf-8?B?bm1OUVBGbDZyTitGNW1ZeS9vNWtVd1B0UGxqRnpncHl0bWc3MGRrTmk5Q0h4?=
 =?utf-8?B?RFpyUnY2UmJBTEc2VHV3eVVwaDlJcmphNGYxZkNkemEvSkl5VjBDaHcvbnpS?=
 =?utf-8?B?VS9IbW0vZUh5T0FSQ0FQa2xyUEVQbjBwbUkrM085Snk5eDNhOGd4ZmxTaXFX?=
 =?utf-8?B?RmhqVEhwc25qZDNiQkljSGdTSUxURFJXRUVGNm9HWTdBRGtyclUxb2RLcUQz?=
 =?utf-8?B?MGtVNEovaXBDdW9jdDBFUnYxL0RWR3dVM0crUzFBUGZBY3YranBmUHcrZFll?=
 =?utf-8?B?bnBaZEdva1EyNFNYVGpBSGdlZlF0elFqRjJtaUlDakdES21Fa3dCNmp1MWNh?=
 =?utf-8?B?OTVOT2NOeVYzbzNOUWxDT0xzNHZ2UFR6bzcycldib3VOMVQ0M1E2cFBNaVFN?=
 =?utf-8?B?UnZzcGtybXl3UVlnVnF1L1ZaYU8wM0lCaktrRkg1NW0xSkl6MEJwcGVvSnhC?=
 =?utf-8?B?Q2pUUFFXZlF2bDdrNTZaTzRwL0tvWGdESjA1RnZvTUV1dGkrRjJKaDBTL0JJ?=
 =?utf-8?B?elBBM2RyK0EwZjdwRDVEV0ZtUWV5ZlpsY3Fwd1djOFRVelNHVzh0MVk3d1Uw?=
 =?utf-8?B?RFhjZ1ZtWnlTNlBZSnZwd1BoeHJyZDk3ZWFhNld5eEhnaTZCcVljbjVlTTV1?=
 =?utf-8?B?amxETHdXbE9jUWxrNVJjRk5rZjlYMHZDN3Q2YzEwM0FLOWN5VUN0TlR2VXY0?=
 =?utf-8?B?YkZLWGVSemtIZFBGZDl5OGRId08ycVU3R1k0VzU3SDJXNmlVejVWT1kzQmda?=
 =?utf-8?B?NU9iYmxkbllLVU9tN3NSZGF5UUZpUTRybGYvRVc0RExpTkk1Ym1kekpKd0kv?=
 =?utf-8?B?d0hhVnZkaVVFSnh3R3VDTFV2V1JKY1N6RG56NXlRMHZwT1BRV1MzYTRtbEU2?=
 =?utf-8?B?bXc0QVprZEtST3FGeWVQanRXQ1dDTEFoMjBCQ1QrTW90eC9QMHhmWEdVNUNJ?=
 =?utf-8?B?NmdXOTVxTG1oc0QvTkwyT2ZUWlBwcE9wZFhWSHE1MjFCMFl4bmhnQlBrZWEz?=
 =?utf-8?B?LzFOSW5ySWlXT3RtTm56cW40M0MrL1JjUk93VStOY1BOWHBmSHlnS0lXVWsw?=
 =?utf-8?B?YmUvSUVreTRhbllCOHRtM0hWRW5iR0JWeXpVdnB0cjUzcElweERsRXdhZ0pY?=
 =?utf-8?B?Zlo2NnoxQWczTnFMME11MlRFU3lwU2lpeXRoZVJLbHB6dkl3VmZwc2ozcGFU?=
 =?utf-8?B?SXU5akE2RU4xQ1c4c3hINHh1aWNkeVlwRXhDNzIxZGUxWTluZUQrRUlMN2FT?=
 =?utf-8?B?UkpweHM2YkxreVJtd0pmUHkwcE84T1BSODBiK0IrWVZmcDFXeElUSHR2UDZt?=
 =?utf-8?B?OGZoRHpoakVmaWZFRkJpb1dWUUZhTGVzVFBrbnByL2drWC9EQWtnQ0hsUFNU?=
 =?utf-8?B?dlIvczZGd25MR2d6N0ZKTkdxTHhYZ0liUGJaV2F4QUc0c0tVUy9yS1RCYndo?=
 =?utf-8?B?Ym5wMFRlVGJlN0o1bFhwMU1SVnFnVFB6endFbVA1amowcXpwVm9IczJ2bXNp?=
 =?utf-8?B?V0xvWWxaeXhWRTdhN0NiS3NEL3daUHN3K0RWRGhZOU1ucFFVMnpubkpJbzJZ?=
 =?utf-8?B?QnRkK2RPdVdXaDl2a3RRd2FNRU1pc0RYcWw2cDIrM3ZDV09UdmRYcTRBbGtL?=
 =?utf-8?B?TUhQMy9yVEo3RTZ0WTNCWkxjb2Z4Q21iRVdoNUhFNjlBZkxGbVFWY3ZpbW10?=
 =?utf-8?Q?x2BWGBQlDDT785fdwq?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <848DD0C78416B84D97726237D34818F3@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6328.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 967d9ada-6a37-4778-7050-08de569b271a
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jan 2026 14:09:10.8713
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4vb1lLv8a7j4LYJOMYHNi0jXvpdaeM4+uSGXSZIpxPhwl4/7HLbF45SmFW2B9GKA
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7359

T24gMTgvMDEvMjAyNiAxNjowNiwgQWxleGFuZGVyIEF0YW5hc292IHdyb3RlOg0KPiBFeHRlcm5h
bCBlbWFpbDogVXNlIGNhdXRpb24gb3BlbmluZyBsaW5rcyBvciBhdHRhY2htZW50cw0KPiANCj4g
DQo+IE9uIDYuMDEuMjYgMjI6MzMsIFlvYXYgQ29oZW4gd3JvdGU6DQo+PiBUaGlzIGNvbW1hbmQg
aXMgc2ltaWxhciB0byBVQkxLX0NNRF9TVE9QX0RFViwgYnV0IGl0IG9ubHkgc3RvcHMgdGhlDQo+
PiBkZXZpY2UgaWYgdGhlcmUgYXJlIG5vIGFjdGl2ZSBvcGVuZXJzIGZvciB0aGUgdWJsayBibG9j
ayBkZXZpY2UuDQo+PiBJZiB0aGUgZGV2aWNlIGlzIGJ1c3ksIHRoZSBjb21tYW5kIHJldHVybnMg
LUVCVVNZIGluc3RlYWQgb2YNCj4+IGRpc3J1cHRpbmcgYWN0aXZlIGNsaWVudHMuIFRoaXMgYWxs
b3dzIHNhZmUsIG5vbi1kZXN0cnVjdGl2ZSBzdG9wcGluZy4NCj4+DQo+PiBBZHZlcnRpc2UgVUJM
S19DTURfVFJZX1NUT1BfREVWIHN1cHBvcnQgdmlhIFVCTEtfRl9TQUZFX1NUT1BfREVWDQo+PiBm
ZWF0dXJlIGZsYWcuDQo+Pg0KPj4gU2lnbmVkLW9mZi1ieTogWW9hdiBDb2hlbiA8eW9hdkBudmlk
aWEuY29tPg0KPj4gLS0tDQo+PiDCoCBkcml2ZXJzL2Jsb2NrL3VibGtfZHJ2LmPCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqAgfCA0NCArKysrKysrKysrKysrKysrKysrKysrKysrKy0tDQo+PiDCoCBp
bmNsdWRlL3VhcGkvbGludXgvdWJsa19jbWQuaMKgwqDCoMKgwqDCoMKgIHzCoCA5ICsrKysrLQ0K
Pj4gwqAgdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMvdWJsay9rdWJsay5jIHzCoCAxICsNCj4+IMKg
IDMgZmlsZXMgY2hhbmdlZCwgNTEgaW5zZXJ0aW9ucygrKSwgMyBkZWxldGlvbnMoLSkNCj4+DQo+
PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ibG9jay91YmxrX2Rydi5jIGIvZHJpdmVycy9ibG9jay91
YmxrX2Rydi5jDQo+PiBpbmRleCAyZDU2MDJlZjA1Y2MuLmZjOGI4NzkwMmY4ZiAxMDA2NDQNCj4+
IC0tLSBhL2RyaXZlcnMvYmxvY2svdWJsa19kcnYuYw0KPj4gKysrIGIvZHJpdmVycy9ibG9jay91
YmxrX2Rydi5jDQo+PiBAQCAtNTQsNiArNTQsNyBAQA0KPj4gwqAgI2RlZmluZSBVQkxLX0NNRF9E
RUxfREVWX0FTWU5DwqDCoMKgwqDCoCBfSU9DX05SKFVCTEtfVV9DTURfREVMX0RFVl9BU1lOQykN
Cj4gW3NuaXBdDQo+IA0KPiANCj4+IEBAIC05MTksNiArOTIzLDkgQEAgc3RhdGljIGludCB1Ymxr
X29wZW4oc3RydWN0IGdlbmRpc2sgKmRpc2ssIA0KPj4gYmxrX21vZGVfdCBtb2RlKQ0KPj4gwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHJldHVybiAtRVBFUk07DQo+
PiDCoMKgwqDCoMKgIH0NCj4+DQo+PiArwqDCoMKgwqAgaWYgKHViLT5ibG9ja19vcGVuKQ0KPj4g
K8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCByZXR1cm4gLUVCVVNZOw0KPj4gKw0KPiANCj4gV2h5
IGJhY2sgdG8gRUJVU1k/DQo+IA0KPiANClRoaXMgaXMgYW4gb2xkIHBhdGNoIHZlcnNpb24gLSB2
NyB3YXMgYWxyZWFkeSBwdXNoZWQgd2l0aCB5b3VyIGNvbW1lbnRzIA0KYXBwbGllZCgtRU5YSU8p
DQo=
