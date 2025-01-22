Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2058.outbound.protection.outlook.com [40.107.244.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 397297462
	for <linux-block@vger.kernel.org>; Wed, 22 Jan 2025 01:02:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737507774; cv=fail; b=X3PH2kNWuTzu7mq//AKrswMeJJMVlsULQtUWhCdjhewEpRPNHVtRM7ECBxQPbvMgvejaa0sKQa04p3pAXavrKYoK3R/ji7KaK5aERxfMgAfyTHvgc2alKl6JMhGrxkOCP+Pm317RyRTmmzHj6webKUHk8vaV975yDxrTP0gf/u8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737507774; c=relaxed/simple;
	bh=urS1TU6y8DWJCvpRp8BHQo+7qJWsmLvW/bep2nRGgSw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=e6ThKP+kY9PJU72QO5685F0q64NWey5CqDluNDvHLJGE+li1+6kKXh+sQUBMJ8OAuENZl92QrFLmgfKIyxc8u7+n4eKKX0oLtKsCrql6vA7i6mjvcJKLAbXpSho41GhZNyE55M0qUZg5IBsLDRHtTRQMUGxGyo09fN4JSPlWBhc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=gafTXd6a; arc=fail smtp.client-ip=40.107.244.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="gafTXd6a"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JtAfVgGCvvIehBabdgMz9lo2deQqdHqtolIKZdEUMmBZG+x1JKzwjbHpAnOIE1FIaDRattQAd3tlEoyulqFExcHXDZGWr+PpaIOLGUjOhBPlVSdGqmjj9MJ1J8PtyaH3EQlEyodwW1aTHQRptl0PYEjkIB0rM0XbS/YW6Cb2+WaNzUbItFjMIo+3ZYNSkleGa3wksC3Rp28UyUSK8a7GlzwMtI8bNwhUQthOyWtR8oolQ6G7F8H8rF+j9xTLKqnWrpj6USS9xy620HXTOPRD/neS9u6F1p+me9r8r+cMVK5xqDKVHClaw9WDtrX5nMgdpTsAKlgjdTppuPpp+XOZJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=urS1TU6y8DWJCvpRp8BHQo+7qJWsmLvW/bep2nRGgSw=;
 b=h7WIoP4hYTmhH+bS7hBP24lW/x5Pm9srgtSG2lltPiqZ/CM7q64QK4MsmdyOvhm735cGaHkm7axWMOKGeB766gdzOG5Bb+7ww2YEeYHfUX2SpMEXND2H4/Rb2bd7q9AJ8qnf8ykzQh7hHzNTCueCFcQS4W5fDaBiTxwAPkw1zbHjaCGBhu1ZsOSOJ3hFQPjS7Sik3mldskuUaF6NX6t2vugldf9+YPkR75NHY7vBW8J2slKfKb3fCF10ep/JqveTJxZ24x1HDZgvFy7be3MtxvE5GOm4U/D/vVoNRGbu+gHhwct8azGXTmZ3BwS181zYJH10riqE0c3Tja/N2o+MFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=urS1TU6y8DWJCvpRp8BHQo+7qJWsmLvW/bep2nRGgSw=;
 b=gafTXd6a9f8A0ZTn3v19KAP4yVfF/JNOJkhXSgk0DnwLWhSEx8x2WFeEyNCuRhJ3Y3DsYnulcgYmrxysCLN8Dk7f/5+2tqRKnvnrABgjWviSsuO931sqMYKwSaC++M+Xn2asGgTiytEkxPeT2yxWrYw0gZgOHZGugERHw9PW3varxumYPwx9vT06TO6oNWOQpElS6w0yycYjwewRKn/0iA46LT9eJ7GDf9BIZ/jaWYt1g4WkNprfMU2Sem7lDpv0wrCKD5DqvW+UeS+BAh53RGX2WdkSQw/7qhud4v6zZ3YQLFF4odCtPtYf3NzjHX8pt+Qc6JpaF93ZtijIeF1bsw==
Received: from LV3PR12MB9404.namprd12.prod.outlook.com (2603:10b6:408:219::9)
 by IA1PR12MB6282.namprd12.prod.outlook.com (2603:10b6:208:3e6::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.19; Wed, 22 Jan
 2025 01:02:50 +0000
Received: from LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b]) by LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b%6]) with mapi id 15.20.8356.020; Wed, 22 Jan 2025
 01:02:50 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>, Jens Axboe
	<axboe@kernel.dk>
CC: Damien Le Moal <dlemoal@kernel.org>, Bart Van Assche <bvanassche@acm.org>
Subject: Re: [PATCH for-next v4 0/5] null_blk: improve write failure
 simulation
Thread-Topic: [PATCH for-next v4 0/5] null_blk: improve write failure
 simulation
Thread-Index: AQHba9ytq/EsO+z4yU+GQuSe1QZCvbMh+rSAgAAASQA=
Date: Wed, 22 Jan 2025 01:02:50 +0000
Message-ID: <1b7bb875-292d-44e4-a673-5a285110ddb3@nvidia.com>
References: <20250121081517.1212575-1-shinichiro.kawasaki@wdc.com>
 <3927c72c-7cb9-4d91-9296-fb0e70b64354@nvidia.com>
In-Reply-To: <3927c72c-7cb9-4d91-9296-fb0e70b64354@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9404:EE_|IA1PR12MB6282:EE_
x-ms-office365-filtering-correlation-id: 1bcf8879-458a-4e61-0169-08dd3a807e6a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|366016|1800799024|10070799003|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?dzQvUlZDZ0pUQ1VkTytRZDdRR240Y1JqWmZPQUpHa3Q3R1ZiSnMrOGJEM2pW?=
 =?utf-8?B?ZWlCVlFrT0J0WUtxNnFqRXdEbXhJRCtlYVlrZ3g4c20ycGc1OWwreVVlbDM1?=
 =?utf-8?B?L2Y5cHhyblV4QnJ4U1h1SFRKc0Z0Q1VlSEFnaTFrYkZyVnV4d0g5aEJxenF5?=
 =?utf-8?B?a05Wc0hQSFRSYnJkWktDeFR0aXFkVXZRRXdzVURYSzJEZFYzcXJjWGtMS240?=
 =?utf-8?B?K2RXTC92VEtFeVcwd2ZXMThHeVNnVi9rNjNhS1MyMXZDVnhQWXd1Q0tsY0ta?=
 =?utf-8?B?V3AyL2xXTW0wS0FMMkxjYW0xeTdHWWxXYy9VQ29Lc0N3aWUySEhQd2VIYzM3?=
 =?utf-8?B?ZDU4ZGV2RkwvSGV0azRnOFRKNUw2MzJRZ0xLTm1UVmxaS1l5SmNXWjRoOHRG?=
 =?utf-8?B?S0Y4WG1sRmJVMVlzNnF1M3FNVnV1KzQ5eUpnSGV1RW1JVDdsdGtPcXl2M1VB?=
 =?utf-8?B?clRXT2lOT1c5STJTT3JjSnpTSkcxTlBEb1dmYjg3Y2RzSlRWRHVnakgrQ1NG?=
 =?utf-8?B?dFp5ZXhZK3hsRmFCK09XdjlBNHMvYVMzTnpaRGNYV1hIKzZxZHQ4VnlrdWFs?=
 =?utf-8?B?NDg2SFBrb3ZzWVpFQUcrTnJWK1QwTUtrZGVFVjN5WG1uVjBtS1hRL0o0TlZl?=
 =?utf-8?B?VGpHWEMxejFMeERJYWptMXpQUjZEMXNtL0tDVUFCMjhobVpvZHdFcVlOZkZG?=
 =?utf-8?B?TE5xOVRZMUprNHVTOEl3VmFDMGxwZWorVVZiRWdxYmN3NFBpQ1l6bXRNZHhT?=
 =?utf-8?B?UmFvQkp1SDNJNG9LMDFPU3FnWXRnaU5KM1NiaTBDcktlRWtBYy91ZEJNcUZK?=
 =?utf-8?B?Y1hoV215c3RERzF5Q3Y4VXF6L0NjY1IxdCtsSDgyT2UrOEdvV0xJeTQ5M0Zh?=
 =?utf-8?B?M2VyWVowaVl1c0t0cG5EcXhqUEw2ZmMyTVZIMGJ6aXdpRWhaTk5Ebm1FbXBr?=
 =?utf-8?B?MDdNakZmZ0NISm9pMWx1bVJBMThjQnZLaUI4YzdTblNRVDI4cExnTzZlMW5y?=
 =?utf-8?B?MDBDd21JeEx2OVFZMHdWVHNyNjllbHlyYkZBbHFoOTIzRXN2VS9vVnl3Tk5K?=
 =?utf-8?B?OXhUSUlSbjNmVmVSa3VxREluOWxHSTFLM3B6UnFtbi9TdnRWTjBFb1Y2TFM5?=
 =?utf-8?B?UDFzc3NBeTZWdFhDeEdNTTY2Ymt5N2FqeW1zbnZLd09VREp0aCtjaFF2Wmpo?=
 =?utf-8?B?amNvMCtONU5YenJ2cFFuL25OdGJZYmRSWmxaUVcxSmZjRUFFcmh3WjZhdVBp?=
 =?utf-8?B?Z3Y3K2xuTUI4ckdBVmZVN2RDNDU3Tm5YY0JuMVVCaVIwd2dpSjd5ZUxRLzNQ?=
 =?utf-8?B?TFd5a0d1RlU2V2pWc0JsNGg4OHJZZWE2Y1E0b3pGQmlVWG10NWtoSFdGZm8v?=
 =?utf-8?B?ckRhYzJyQUxidlJNMGVYV3hpUGFHNWs2MDRkME5ReEhlc0xUcXZHM3pldTVR?=
 =?utf-8?B?eDh5TC9yeFhUanU2VGZDWmRMV2ZPZFkxMWJ1SHd4V050cW9GZFFFbm9lWFBE?=
 =?utf-8?B?MFRTbHJIV1diQ0xMMEhFc0lUTElxcU9kVEFmZlRiNzErQUNwVjdnU3VidjJs?=
 =?utf-8?B?SExZY29sYVZ2KzA1cVN6ZWhNczcrR01INWNrMnFYQW5iUkJOa1Y2aVY3b1Jx?=
 =?utf-8?B?NVAwaTBERVEzVTk0SmR4RGZ2cEN1dGYvMzR6ZldhMWJrNUZhMTltU3VPUXhJ?=
 =?utf-8?B?aWZMR0lESnhHM09MczBVM3BWd1Y3eGhiTFNOOHYwdWN3OHRBbEdkMXNOYWJS?=
 =?utf-8?B?NDVyV1loelZXTEhlZWd2T1dob00vWUhZbGoxUlJvSytuQ0hEU0UxM1gyWHg5?=
 =?utf-8?B?c3dRamZCeWZoazBWZnB6REhlTURkVWVNSENSd0FKRnFVdW5BaVdpeUgyTnJx?=
 =?utf-8?B?UUI4SEpKMzFZUktzTGhGVDJTQ1JML1R3dkM0cWFQZkQ5cVdCZ1NKcVFDRmQw?=
 =?utf-8?Q?T2llNKSrof4tmlI1N3DABTvaP1GjgRDx?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9404.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(10070799003)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Y0l0ZHA5TS9MVUVHMmw3bnNjbFdNSEI1bHRtTHlqWEhaQkd2eGpyZXh5ajY5?=
 =?utf-8?B?MmVEWnprTkVINnV2ZlNhTlFkWi9WQXRJcDVJNndlMllXSTBYN0k1YXd5N0tn?=
 =?utf-8?B?ZmVQeEpETmZ5WHJTN0N0ZWh3Sm1hTXpOdXdiOUxwOGwrMVJITkRXQVo4ankr?=
 =?utf-8?B?SUVndmFIZVFrQWN0T2IyNGplcmd2U1hGR05aeXJZK3hqQ1ArdHJ4VmNaL3p2?=
 =?utf-8?B?N1RNck04a2RUS0NZeTlrakZ4OUFCcXcwRzVCZmIrdVM3bkM4aExYTjhVdkcw?=
 =?utf-8?B?bmhKaS9wZjlmZVM1cm9CamM3cXFWb05oQ2lOS0xMTVZCRzdCdXJHaVoyZ013?=
 =?utf-8?B?U3pNMXExRjRObWRaYUJMYU1LelVZMlY2ejBlcWZHZmJVbG5oWUJad0E3Misy?=
 =?utf-8?B?U01JTkxmMTVoZ0Z3T0JkOVV3YXRJbUtjY0xNSlppSEtkNW5sWTJhWXdiVk00?=
 =?utf-8?B?cVozUElueSsyd1hDdVdHMWpBS3phRVZvS1lIQTkzQVlLWTR0TVczaC9FZHdy?=
 =?utf-8?B?TVp3R29pT0FiSS9YOS9TUHIxeG1qZ3h5RHgwRXZFK2ZwVjJCU0VvUUVQOW4z?=
 =?utf-8?B?TXFpWFRWbFRMVlhEb3d1ZEdvTktqaGt6MjhpMFc5MXRVVWloK0UwQnNwYkQr?=
 =?utf-8?B?d3BhRWQ5b0Q1bHp3eGpjdXlxd2JtSDlTb1ZSQklpcVRMODZHRjBrbkFBamQx?=
 =?utf-8?B?cEFNVmNkVDBud2RkNUdPQTA4Y05iVDQyQVJtV05majJnTGJoVXY3Y2I0aWIz?=
 =?utf-8?B?Ni9HamdCaThzVXpaTzZ2R2dPdmk5VDd5dmplOVlxMzNhOXpTL3NuTGF1THRN?=
 =?utf-8?B?RGhGMU95UStyS3hUQTMvTWVmRjRvNXMralNydlFpcmkrNENpYjAvKzdCRFV5?=
 =?utf-8?B?N1hxc0hwUUxsVkZWazEvSndsV2FWdm1EN2ZKRWdwMmhUNlNIbmhuZXZBbmRu?=
 =?utf-8?B?U2UxY2lxWlVKZ2J4U3o2c1RXd1RnTjc3NWNKRUh4NGtvNERLSVFjamcyZXpQ?=
 =?utf-8?B?VXlUbkhJSlR3aTdrWDVDcHVLVEFRN3RMV0wrNytnaFhKUzl4UWxHKzdpT0l6?=
 =?utf-8?B?dnEyV2NNS2dZZFZaUFk5cThEdldCM1h3bkJJOCs1OFN3aFVTQVEvUzIrRUVj?=
 =?utf-8?B?ZG5CMG5RelB3VGtFTnYvNW5PbzNqYi9VeW8yUzBFbkNsQThOSzJBVEkwWmhk?=
 =?utf-8?B?YVFWQm0rSUNKOVMzZ3RNdnEwOFBZZW0yTkpRQUh5UTErL0hzWElmUHltdGZH?=
 =?utf-8?B?QncwSlJNTDFnVUdpVVFBcWxhWHQ2SXNPWXU5K0Q4d2JTM1dOWVJacmNaVDZW?=
 =?utf-8?B?VnRMblVXT2d3cysrTTFuSTNaMUNrQkU1MHB1dEx6Qy9HREN0TGIvZHdOK3Rw?=
 =?utf-8?B?cHN6dHFRdVhpZW01ZExkeGY1TGt2YzY5RTRWck1neWRxTXJnWFg2L0lTY1Ju?=
 =?utf-8?B?ZlcvVjdkOC9QYk1rUFlENFhaVlpuRnM0V01FSGxDRHQ3RG5yUU5neW5Ecksz?=
 =?utf-8?B?VjNadjQvbkRIS0ZqQ0NoZmg1dWdWQ1VydDd4bjlHSytkeWlWbTBTYmxRZG9F?=
 =?utf-8?B?MHI0Q25YQUlqc1FsMTdRUU1PTTdkSVRVWTY5b2FjNitNME9ISzRBdCtZYTAv?=
 =?utf-8?B?TjRwdTRnWmF4VHNCek5NRHV2TnFhVmZ1TGliSU1RazFWUVpEdE5FR0VCTUQv?=
 =?utf-8?B?bGc3bkprYlQ1SUZ1TnRsL1RjMkJ1UDhaeEJqOWZEM0dXTTdENWl6dXZHL3Jt?=
 =?utf-8?B?eDgxaDVTZDU5ekpBZ3JIT0E0dGQzZTNybUFMZ2toTFRKQWVaRngyUTFwOXB5?=
 =?utf-8?B?RmYraDBQOVowLzdKbldjUmV3c25XdUs3WEdBNzJuSUdYM1FLbWFJM25ETk9j?=
 =?utf-8?B?QVE1UUlOSFdWUWMwdkJQQ1cwVlRwSWFXS2g0TmRFNTFISnVTMTFpMGt4b3A3?=
 =?utf-8?B?emtFZ0FjT3kveUF5UjNId2pIYStsU2xjTVhpWTZTZW1CUERmOFE5WTNDRENJ?=
 =?utf-8?B?ZnFtclVaRkpaS09jeTh1ZnNGZHFseWNKc0trVEJBN0FLVklvWUZCL1NmKzVn?=
 =?utf-8?B?MEdjTi9qcDhHZ25SYXcwM1VKcHNBbE51VjgzdGY1TkUrZGhiS1ZtWnp4SzEr?=
 =?utf-8?B?Y0RGTlBoNEZINVV3OStHSVp3NDUrL3VkNW5XNnVIeG51TjB3d3NGbUtvVklC?=
 =?utf-8?Q?u3X+BiEQ/y/DSIYRrfMLmhtkEUayDX5kZaT0/e5Pa+dc?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <38DB26F19BA191498DDFB78A5E5F0153@namprd12.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 1bcf8879-458a-4e61-0169-08dd3a807e6a
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jan 2025 01:02:50.7128
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sD7Vl6/dfgT748xDtPjXcKJGgkN8tYugln2E6A/h7TH/Q4b0n33hR0gU7VGb0EV14htl9xNB0RH3DC6mHAcF6w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6282

UmVwbHlpbmcgdG8gbXkgb3duIGVtYWlsIDotDQoNCk9uIDEvMjEvMjUgMTc6MDEsIENoYWl0YW55
YSBLdWxrYXJuaSB3cm90ZToNCj4gT24gMS8yMS8yNSAwMDoxNSwgU2hpbidpY2hpcm8gS2F3YXNh
a2kgd3JvdGU6DQo+PiBDdXJyZW50bHksIG51bGxfYmxrIGhhcyAnYmFkYmxvY2tzJyBwYXJhbWV0
ZXIgdG8gc2ltdWxhdGUgSU8gZmFpbHVyZXMNCj4+IGZvciBicm9rZW4gYmxvY2tzLiBUaGlzIGhl
bHBzIGNoZWNraW5nIGlmIHVzZXJsYW5kIHRvb2xzIGNhbiBoYW5kbGUgSU8NCj4+IGZhaWx1cmVz
LiBIb3dldmVyLCB0aGlzIGJhZGJsb2NrcyBmZWF0dXJlIGhhcyB0d28gZGlmZmVyZW5jZXMgZnJv
bSB0aGUNCj4+IElPIGZhaWx1cmVzIG9uIHJlYWwgc3RvcmFnZSBkZXZpY2VzLiBGaXJzdGx5LCB3
aGVuIHdyaXRlIG9wZXJhdGlvbnMgZmFpbA0KPj4gZm9yIHRoZSBiYWRibG9ja3MsIG51bGxfYmxr
IGRvZXMgbm90IHdyaXRlIGFueSBkYXRhLCB3aGlsZSByZWFsIHN0b3JhZ2UNCj4+IGRldmljZXMg
c29tZXRpbWVzIGRvIHBhcnRpYWwgZGF0YSB3cml0ZS4gU2Vjb25kbHksIG51bGxfYmxrIGFsd2F5
cyBtYWtlDQo+PiB3cml0ZSBvcGVyYXRpb25zIGZhaWwgZm9yIHRoZSBzcGVjaWZpZWQgYmFkYmxv
Y2tzLCB3aGlsZSByZWFsIHN0b3JhZ2UNCj4+IGRldmljZXMgY2FuIHJlY292ZXIgdGhlIGJhZCBi
bG9ja3Mgc28gdGhhdCBuZXh0IHdyaXRlIG9wZXJhdGlvbnMgY2FuDQo+PiBzdWNjZWVkIGFmdGVy
IGZhaWx1cmUuIEhlbmNlLCByZWFsIHN0b3JhZ2UgZGV2aWNlcyBhcmUgcmVxdWlyZWQgdG8gY2hl
Y2sNCj4+IGlmIHVzZXJsYW5kIHRvb2xzIHN1cHBvcnQgc3VjaCBwYXJ0aWFsIHdyaXRlcyBvciBi
YWQgYmxvY2tzIHJlY292ZXJ5Lg0KPj4NCj4+IFRoaXMgc2VyaWVzIGltcHJvdmVzIHdyaXRlIGZh
aWx1cmUgc2ltdWxhdGlvbiBieSBudWxsX2JsayB0byBhbGxvdw0KPj4gY2hlY2tpbmcgdXNlcmxh
bmQgdG9vbHMgd2l0aG91dCByZWFsIHN0b3JhZ2UgZGV2aWNlcy4gVGhlIGZpcnN0IHBhdGNoDQo+
PiBpcyBhIHByZXBhcmF0aW9uIHRvIG1ha2UgbmV3IGZlYXR1cmUgYWRkaXRpb24gc2ltcGxlci4g
VGhlIHNlY29uZCBwYXRjaA0KPj4gaW50cm9kdWNlcyB0aGUgJ2JhZGJsb2Nrc19vbmNlJyBwYXJh
bWV0ZXIgdG8gc2ltdWxhdGUgYmFkIGJsb2Nrcw0KPj4gcmVjb3ZlcnkuIFRoZSB0aGlyZCBwYXRj
aCBmaXhlcyBhIGJ1ZywgYW5kIHRoZSBmb3VydGggcGF0Y2ggYWRkcyBhDQo+PiBmdW5jdGlvbiBh
cmd1bWVudCB0byBwcmVwYXJlIGZvciB0aGUgZmlmdGggcGF0Y2guIFRoZSBmaWZ0aCBwYXRjaCBh
ZGRzDQo+PiB0aGUgcGFydGlhbCBJTyBzdXBwb3J0IGFuZCBpbnRyb2R1Y2VzIHRoZSAnYmFkYmxv
Y2tzX3BhcnRpYWxfaW8nDQo+PiBwYXJhbWV0ZXIuDQo+DQoNCkZvciB0aGUgd2hvbGUgc2VyaWVz
IDotDQoNCj4gTG9va3MgZ29vZC4NCj4NCj4gUmV2aWV3ZWQtYnk6IENoYWl0YW55YSBLdWxrYXJu
aSA8a2NoQG52aWRpYS5jb20+DQo+DQo+IC1jaw0KPg0KPg0KDQo=
