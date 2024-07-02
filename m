Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2051.outbound.protection.outlook.com [40.107.94.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5193D144D36
	for <linux-block@vger.kernel.org>; Tue,  2 Jul 2024 07:52:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719906741; cv=fail; b=UftKlJ+BxVI39jo6wfLUJxNEUNKa0MTHBEOhAwu529M4QvM89dyfJme6jTzQI5XpksuXpIk8N9Uh400NDCXtyMUT2/ZSWc1/8um/tEJ11aSJFZBl08yEVsXF1Vuxkg276/jtAsjWFdMBeeWIrgKwRzUXZYGoDXF1S3g2j5A0jpo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719906741; c=relaxed/simple;
	bh=XISxC+/KbGN6cAGy/S42yicvXQ79RtLloGNvxgzBi1I=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=uoNgVQQiZg8QUPSRiAWoMAdJkx9/m6p1hDgVcw6GFJHXDjXoFYTjl8pDcUIV18RApnWei8Xg033k7p5BExSPQAPfYdkBZsy1O+zbG5vJVOVYoqzfPwqDrsm5vSyzCaYmJqP6xvgW+Bn3pce8e42+cEOCfKrueHXcZKPD3hW9s38=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Sen2j/7O; arc=fail smtp.client-ip=40.107.94.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Sen2j/7O"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K0vJcGlzv+I/vcanTv1awk7X7CjBb6GchZ7Zx6+h3FNck8EVxibC4Y/G0eC6R55ISOalwc6GnrwZoSaqXFQr0389K2G8utoijmAosnkR0mQ/zlzLEkTXK8rXTHqejzvkVKA9jliDwlz48C68vCpxGXpBQydT7bfeeSrjqbDl+vuVHvamMW3ClDvR2GsuxFkpD9O/E3HpR2x+BwbXWWSCgvXK7u/ePGg3x1w+pgX0rC2G6HNMGiPaUrqrx6cME0+wqCL+FFeHur7Qh3zZMpIwWeDpfRz5h7px94hJOaOnX4EuFPL16segU/bB21A31k9k7AtESl9IbJjWEE5IrlDC0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XISxC+/KbGN6cAGy/S42yicvXQ79RtLloGNvxgzBi1I=;
 b=e2799EffT8is957G/U4CDlhT9HVNBglihW5f1ysKuqiRSo1Zydnh8eJ/7IETh7k2ZeR6XYhnLuSeC102YPj8zxcz25gEnBhxCLMqFMaY0soQM/t7AcgyW5oWH4XJCBL9JlnuRk26/m1gft1hnppi2la6TBjUj+LRktPS+hP7YVunOAypQqjsnAuaQzGnYSy4kxZ7vyV4snJLKsGHy4MoXDZqrzQksLvu2S/jA2pWzlS2T52+BQ2Br/RpZusY/afW0pxI6q/YULaM/tcLshKOMzKuX/86V2GLbEijTPUcT/XC3rYwUE2swcO7UVbOGK7Ad7BPB5IlpjbhkOeddq6o9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XISxC+/KbGN6cAGy/S42yicvXQ79RtLloGNvxgzBi1I=;
 b=Sen2j/7OkAdvWFRilu8YdQIq1pl8UUH1ZqX1G/1NHg2loDJl+YlPxP+MzA/XoggVxvM6FspLoQPA9mVK10lxaNpbg90OzandlJCHEUPvC/h9nD5hovzjwpVrg1HYYcREq1oGk3k4/PlHeBrxl68CGZMebwgXCw5wxZ+62gSV+r1YnqtfHGVZeELA0qiuThRIBKR+W3ieq+qK8rolid7QdAe7gt55mLTgXJQwl+er1PiStG1Wj9fLPe2HsnJTpe2gTgHx3pduGuhJJiNHeEr0Dxs+t3cj0RctT54dv6onAVCBQnxN89FsibNiNmvVpK4kXmcTC6W1gNhbBQAtFMlY0Q==
Received: from LV3PR12MB9404.namprd12.prod.outlook.com (2603:10b6:408:219::9)
 by DS0PR12MB8503.namprd12.prod.outlook.com (2603:10b6:8:15a::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.28; Tue, 2 Jul
 2024 07:52:17 +0000
Received: from LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b]) by LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b%5]) with mapi id 15.20.7719.029; Tue, 2 Jul 2024
 07:52:17 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Damien Le Moal <dlemoal@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH] null_blk: Fix description of the fua parameter
Thread-Topic: [PATCH] null_blk: Fix description of the fua parameter
Thread-Index: AQHazFIHJd3LpQBcK0SEJdKt2UaunLHjEOCA
Date: Tue, 2 Jul 2024 07:52:17 +0000
Message-ID: <1948d4e0-bd49-4750-81df-d05bb92330cf@nvidia.com>
References: <20240702073234.206458-1-dlemoal@kernel.org>
In-Reply-To: <20240702073234.206458-1-dlemoal@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9404:EE_|DS0PR12MB8503:EE_
x-ms-office365-filtering-correlation-id: 39aee161-6ea0-48c7-8d80-08dc9a6be523
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?WWFhY3pCaTlyRnhaQ2l0MWdLWUFtL0E0RlVFbzAxWnlQY2xQTzhxcy9qeVdS?=
 =?utf-8?B?ZDZza0FJdEV6MGNJM0Nwb1FNbnRMTUNWVGJEN3V6c0RrWDhLc1dROExLQWJD?=
 =?utf-8?B?V1hJbzBrQm1sZk9Scnp6RURZemZ2dXlucGNJdk5NUUc2N1BQaWRTMjUvRSs0?=
 =?utf-8?B?NUZnL2hVTksxdS9LSGZCOEZOSTlVZTNtTjJqdVFIazB1UTliNTJVVUlxVmtI?=
 =?utf-8?B?N0YyUW5WcXlTMWdVRkg0dGxPaWw0L1lZMHRQL0plODlURnlRRkVDRnFYL0hr?=
 =?utf-8?B?eFFsQW9ybWU1aWFDbDJ6YUN5NFJTQ2ZldnJUeG1JbUs4V09WWVRobUUvaHJN?=
 =?utf-8?B?SytWdnlSVHcwdGhnNHMxdjlaQ1FNT0YzWldXbGhNR2JjU3AxUEVoVlE3UE10?=
 =?utf-8?B?eWVlSVIrRGRxQzh3ZWM5L1dxTGxPQ2p3QXpOWGpxL2NWdlJSYmlOZzM5bGtk?=
 =?utf-8?B?RHd2NU10eGh0OFJzUDl1aUY5VTVDanpDNXBjdkQ2SlYrWWo3SEJCZTN1N0dF?=
 =?utf-8?B?NDlOUGY5OGNVNkg0ZEJDS0h1VVRranp1Z1YwcWN2TlZHc0gyZEhjTnVlR3JH?=
 =?utf-8?B?YW9TdnlCbWtsbUJsb3ZwTXZJbXl3em5FN3ArWGFHU2RzcEhaUEhlUFNTNDg3?=
 =?utf-8?B?cktrVnAxMlVIeDNXMWJtbkIxckhCMFYrQVJJcERXcGpvd0VuRExlVHRDL3Bn?=
 =?utf-8?B?enlQMGxNWlRXWTBQdzlSS1BETFRhSzV5eENuNURhRzFvTXR4L3VWWjlQWmpD?=
 =?utf-8?B?L0RRUExqcVI3TUdhL0FMMlBDS3hTZWNEQk9NbEtiZXBYODhOK2tBNXA5dDUy?=
 =?utf-8?B?NHM5Ry9nbUR4clQvbS9QamswSWFLSCtHVDFYZW5aQVgyT0k4UnJhVXduZ3Ri?=
 =?utf-8?B?NWpiQzVITE1vVDZaYlZIOW9uNlFsTXRsMUUwOVJ1TENkVzVoTEFrN21CcUY3?=
 =?utf-8?B?aTB4c1hQcnh3dXBEdmxtZGlBUk5aaDhOeS81MDVzNGorNUVvSUpEVG1jMEVj?=
 =?utf-8?B?bTVVZ0JZai80ZUNuS1l5NUgxaEdYU1JZNzFZMm1PcjZsSnpJZnZIRzQ4T1VY?=
 =?utf-8?B?UGo2N2s4eXZsaytFL09IMGR6Q21jcFJoZHRIcUd0TG84U2hIdVZ2V0hFSmtB?=
 =?utf-8?B?TFpNeEVxVHA2aXA5WlJXQkRiTjlianVtbGExZERYQkp4SFNOTE9XZmFJeWky?=
 =?utf-8?B?U0hkR1YvTmdzRTN3Zk4wd09lUE5OQWZDL1gxQURzUjQ2MUdjWHE0blphZTNk?=
 =?utf-8?B?bGtzMkhxRnEwVDhacjMzYVYrcjFOV3k3K3dENy9lN2taUjFvN3VaSm15MmRn?=
 =?utf-8?B?ZUdicE9BT0tNdjR4SVBWd0IyeEhOSWVjcHRxWTBNWUhHRFIxOVhuTGtDcG9w?=
 =?utf-8?B?T0wycHJqS3B6dDBvZEVtc3FpMml6aVVNempRZW8velpQeXZNR1lkYWd3cTUx?=
 =?utf-8?B?VmNkNDVHQjYwcnliWS9zdW4xR2h3dFpUcXFJSjIzRWdlWGhtdHlHV1R2dmdt?=
 =?utf-8?B?STVSZ0U0UEd5Q0xzczUrVm9xRDRHMnRGQlFTVGM4NXU5a1Q1WlF0NTR3cU5w?=
 =?utf-8?B?eVN1UnR5bkVSVDZEbEQzclhqTzRVS1g0a0FRWEpZcXFvakl3c1VaQjNQTFpC?=
 =?utf-8?B?RXN3MWtsNWtPUmdMbTMybjdaVGthRU9LWk9DZWJmU2ROelhPVjlxbjVkUHRD?=
 =?utf-8?B?ZGovbEtka205eVMyeFhDMzBETHNEUGNoSFQrcXdST1B1K1NBQi9UeWZyeVdi?=
 =?utf-8?B?Qjd0dzdWUVMzTG5OLzF6QlZvS0FiZDFYOFZmQVVQb3ZyRVFLZVYwWW9uWnhj?=
 =?utf-8?B?QWdMSHh4MW9DaVlwVlJqcUU5bVVCZTRHOEN1Y1VPamVmV0dLaDJqdzR0cjNy?=
 =?utf-8?B?OXJ6MjY2Syt3dE5xK29WRjBLWU0wQk5rb3UwNVZYcWFRcWc9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9404.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?eUlpOVJCRVY3Tm1xZWc0dUlwNDNYYXRIdElQRzZwdldyMWtxbEdxeEYzZTVn?=
 =?utf-8?B?eFlZeUVSOURlMnk2aDRVSXZzVVZiVkh1MURKWGxhc0k4VGl3czNnZVE5UUhX?=
 =?utf-8?B?WU1vYjFmSDhoSzFaNEQwdnlYMEg0Y1UrMS9kZ0xWU0ZNL3dvRTM2a29IMGVK?=
 =?utf-8?B?VHcvb1hqUGUxRGRKVnpBKzhHUTZOSjhydk5LMGR2OGxNTFNqWlNvdXFqWDRx?=
 =?utf-8?B?QWx1aXBYbllKVFI1Qm5aeWhjMFpLV1JUbkxZSjB1dFo4MTZQTEcyd1U4OWpm?=
 =?utf-8?B?TEV5cEpyRUpoWGFmUWtXQUpKODV6RmkwR2wvNlptNUZyL09aUW1EYU9nejFZ?=
 =?utf-8?B?anRVRFd4ZytqSUx6OWd1R1AzU05La3VUbFA4eHdyNS93OUk4djEzRFFQNis5?=
 =?utf-8?B?SlZqRVdXL094d2xJUFBWL2NyeG4za25PcDZ4Qmp1YTh3ZjFjYjN3ZkJsZElk?=
 =?utf-8?B?ZFVKOGNsRHluVGdwK2tzWHFHWGdrVVNndXI1WG03NmFBdnlQOWNlVm96clBI?=
 =?utf-8?B?L2o4SXY5aFRVNnBYTDJKOGcrbkJQWlVlVWttVTFpWXg0UHZYMDNJR0toSzFv?=
 =?utf-8?B?MHZ2V093M0IzdG1ETUtFMHpSS1Nja0RlUkdxbXFrUEVrakVnMHJNVHlYbjZu?=
 =?utf-8?B?Mnc1TUV2bmhFQXBLWXd0UjV2ZExka0kzZytNY0p1Y3N6UERWTEp2czRLRUhk?=
 =?utf-8?B?VEJkOVUrT2F0MVBWRXR1OVpqZ2tyRFRNT0dWWCtEMHJBZUJmTHB6bDd0TkdZ?=
 =?utf-8?B?bm0yaE1tMGNtZjY1ZWpwNXdTZWR4SEwxbGVMU3NzdmVvR0IrV1BsbVllL2l0?=
 =?utf-8?B?WUowWjZvRlprVU9kWGpVMWVwOU5iRHREQnVuYlNGTzJjZzJKMVpRY1lQU2hQ?=
 =?utf-8?B?cHRQeGRFUXRIMTc3RjRWQzlVZ3M3ajQ3Y2NoZnNKR2FERWZrRW41blh6dDcx?=
 =?utf-8?B?Q0RtN3RRT3pKdklHUlhnR3h4VFBBVHVCVzNSQXRtcTlHM1l5M3Q2Q3o3bkQ2?=
 =?utf-8?B?YjRrT3hIYVovL2F3RkZBYk9wZGhkazZyRHVxVGtpbEpncUJhTk9CUDIzUnQ4?=
 =?utf-8?B?TG80NDVOVS9ha1lwSmxTaXpUcUNZT0F1ZVkrRTFpMDJ6Q3hHTXZsdjh1RDFC?=
 =?utf-8?B?c2o0MS9neEtKSlptallzOVU5Zm0xWlpycGxjS0hBcHpld3dXaXgzM1plUStm?=
 =?utf-8?B?eTJweVI3czBnQVk1UEhEUDJnRW5QMUY4eGJNdUtBdHV1Ny82dld0eXpwQkVI?=
 =?utf-8?B?a0E2d2tvdEhpR3I4ZW1zRjJjc0xPTkEraHdnd21Id0loclEvR1FFcERDU282?=
 =?utf-8?B?N3BMVU51WDZTR005cVhUOUQzSjIwdVdmTFZWU3UyV0lNeU1oSVZ5aUhVeHpN?=
 =?utf-8?B?TTJKaWloc3hkU1JmTmNNVkhnNmdrcENnRWR3dFF4eG9sQU50Z0xxT00rekJh?=
 =?utf-8?B?Uzl6VmQ3NnR3M0J5Z0s3QUtVMGU2R2pkMWJNZUpZRFphWnVXcWIrY3B3NlI5?=
 =?utf-8?B?RDZpdUIydFcrTjVYc2JkekJRTDdXUTljZzZ3SjAyMGpuSzViMkI3d3pkNkJo?=
 =?utf-8?B?TjFvNVJFdmxHajFzUmdhdzVIK1lZUWRRT2w2YzlQRmZMTkhhUTR4VHlEc29Y?=
 =?utf-8?B?dU9BY25HSit0NGhEbjdzMTBVaVNlc0IyaXFDTmgrbHltL1pmY2d3akR4TDNL?=
 =?utf-8?B?Rzk0OGcyOWkydlJhVjFMWFgyWWJwRG03ZStkM0pmcWk2VE0rYTh0OTd0dmFZ?=
 =?utf-8?B?TDBFL3UvMVRlYzRSR2M0S2NFdGJHV2ljSjJuL3hOY3E4ZG8rK1pFSk5vMjZX?=
 =?utf-8?B?YUdHcTFSMlpleUVOVmhWYU5mNTRpSGY0Zjk5WEwwQzl1OGxmMWZyMS9FQmJ3?=
 =?utf-8?B?UG45TzgzMDRjcTd5TG5NM0FNQUpFT0crdE5sUGtlY2NtM3hsdk1kMkYvakZ6?=
 =?utf-8?B?RElZRGNWYWRNT3djVFY2N3dISkVtWmFLU0RxUjFKdGVGZExhRDlHU2JPNE4v?=
 =?utf-8?B?WVZJSnQzMVAxSGtqV2NQRWY2TmhJREhZOUcvZElvanVBNzljT0JsQzRNQ1Zr?=
 =?utf-8?B?RjhqZ1hXZzRoYmVqUHUxbVdhazQrVGxFK0tTZUJLMGFrRXcrTW1xME51ckQw?=
 =?utf-8?B?S3Y4ZkdHM3BiOXpZWXBBYkZvalpPSHBhZ0hpUXlsdjJkV0VUekVpMjBBeXdC?=
 =?utf-8?Q?s3YvzNdlZp7gkcRxhygHBiCsTO9W/5mPkbu9mBQJEO47?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D1F183C824242D498172AB9495C7B327@namprd12.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 39aee161-6ea0-48c7-8d80-08dc9a6be523
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Jul 2024 07:52:17.5891
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xCTf5shbA8Jz1cIWRY9MaxV/v9jDAUk0UV4j9CP18Po5W2EVd62ISzg1J1FLrRCEXy+w0dSOlrqkZz/0IqKUyg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8503

T24gNy8yLzI0IDAwOjMyLCBEYW1pZW4gTGUgTW9hbCB3cm90ZToNCj4gVGhlIGRlc2NyaXB0aW9u
IG9mIHRoZSBmdWEgbW9kdWxlIHBhcmFtZXRlciBpcyBkZWZpbmVkIHVzaW5nDQo+IE1PRFVMRV9Q
QVJNX0RFU0MoKSB3aXRoIHRoZSBmaXJzdCBhcmd1bWVudCBwYXNzZWQgYmVpbmcgInpvbmVkIi4g
VGhhdCBpcw0KPiB0aGUgd3JvbmcgbmFtZSwgb2J2aW91c2x5LiBGaXggdGhhdCBieSB1c2luZyB0
aGUgY29ycmVjdCAiZnVhIiBwYXJhbWV0ZXINCj4gbmFtZSBzbyB0aGF0ICJtb2RpbmZvIG51bGxf
YmxrIiBkaXNwbGF5cyBjb3JyZWN0IGluZm9ybWF0aW9uLg0KPg0KPiBGaXhlczogZjRmODQ1ODZj
OGI5ICgibnVsbF9ibGs6IEludHJvZHVjZSBmdWEgYXR0cmlidXRlIikNCj4gQ2M6IHN0YWJsZUB2
Z2VyLmtlcm5lbC5vcmcNCj4gU2lnbmVkLW9mZi1ieTogRGFtaWVuIExlIE1vYWwgPGRsZW1vYWxA
a2VybmVsLm9yZz4NCj4gLS0tDQo+DQoNCkxvb2tzIGdvb2QuDQoNClJldmlld2VkLWJ5OiBDaGFp
dGFueWEgS3Vsa2FybmkgPGtjaEBudmlkaWEuY29tPg0KDQotY2sNCg0KDQo=
