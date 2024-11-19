Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02A311CC88B
	for <linux-block@vger.kernel.org>; Tue, 19 Nov 2024 16:58:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.154.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732035486; cv=fail; b=Q1zxRdeK8uis3DUObFAyNV4103isN3Y7h2gVa2arhUv+naPCzZM17UQzIht+7B/eN19iWnOSzWmwnryfZfH/iRz4b44GmOdgioQPGuuOXeViVqmgGPrMQx8UdmqSZkEnqUjI0wDPF3UVFgEJ8mBZ9taeRQ9mEr2HUzpfntY9l9U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732035486; c=relaxed/simple;
	bh=twmw2pQayNH8j4zrcfYpXt3q3qPZywjQAwtMF0i5334=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=twaDrlhaDUMwXDazaxU53hxkcvg/h33TsPJziw0oXUwy+fJsTOEw3TVMfr7flj0/12ritTXBWIPloLFt628pu6sINi1oZhILYteABkpya/eqHUQX0LdyRBpqGbHIWrc+PxWx2arZfuK7VGrYECHARBKdR3ep77FmzrbkLLLKRQE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=VUfx/xCZ; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=rPgtO/mz; arc=fail smtp.client-ip=216.71.154.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="VUfx/xCZ";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="rPgtO/mz"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1732035485; x=1763571485;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=twmw2pQayNH8j4zrcfYpXt3q3qPZywjQAwtMF0i5334=;
  b=VUfx/xCZZ9m9dfOVaIc1VfDzi5Q5W/ATNPXmOuYtLl0b8gYxFdOiFYx3
   JnTyKPggCySsZ18tYHZ0ewHK/ZCHp3kurm8yLjfGpMJ+qRbeQfsGENopT
   xsC2+MByvl3SsKnfFmmv8fN1xjWTNvGALgjZbPwkjbW/mjLOQo9Lab3l0
   K55MHcWnS2R1RyeSGHSQDtF89e2S3hpXCcJjcwMmUI4ATTkxBgI/MsZLE
   fJRAuh/3Zo4L4I80AICtl4RWbTdOJ0MOkLVzMSFo4+5T7P/cSucV9jNch
   i7RkXwxsSOd89v8qW7E/VQ4XHeYJCQ8iWq7vh8IboznM9/bm3KyMR3bCX
   Q==;
X-CSE-ConnectionGUID: MkuHnXGaQOO68mOfoquR0g==
X-CSE-MsgGUID: USrgULGnRdC8O0i4P0RQQw==
X-IronPort-AV: E=Sophos;i="6.12,166,1728921600"; 
   d="scan'208";a="31776492"
Received: from mail-eastusazlp17010000.outbound.protection.outlook.com (HELO BL2PR02CU003.outbound.protection.outlook.com) ([40.93.11.0])
  by ob1.hgst.iphmx.com with ESMTP; 20 Nov 2024 00:58:03 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MGalPfuuZy6m/fFZuMI4JAGhF00dITFQquHRj4TDObZ4efEGvHz+ImLd9MPpLFUp/2hhHJmGxggWde5OStq2VFzqQibz+qeH76S613PN4VEoRAwJvwE5WmiFOtl95RV+F132yBVjBh1TTHm9shWAFgp/NJoz5gtMAgxzNRkND9VHo5NTbFvI9UXOICdkbpeo4MjvR6AmaSD6wAqs8+l2SGMNKpFlELJOeWLo7JbHC573/6r87PxS4M1v18IQesEsI4I/0EisQVbq2KAEtrU9+/H9jEXdJXmXVaNB6fAMBGFu2di73WyD6FhJTpE9F4RpDk5PQr1OamZikF9voFjB6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=twmw2pQayNH8j4zrcfYpXt3q3qPZywjQAwtMF0i5334=;
 b=iDymKiRqCxEMISmpMakPTrJJGnASyHlhY6ptzpoPfP4wb+9a1FoqSGEl357swmAX1L/LsGDmOPg++R3r8RvPIeCDFGGNJigCcf3VO3uPZAGcNrMFZe7c9R5iA7TT5yEqkzo0It7PMb421fjRNV+h329WNOxXRAUrXO+nQGBHYDrtIsDuqu5o6C4UoKJmTW7jQlhBgyLumd1CLMAcavTibQaI3fwgo+6IT0g6CV57FN8QrVIEWElq/Nwaaf2sGa9oclNiQG8Ui5pbeOWp60d35h0z3GcDW0kErmFY9iXGHc6GjLl3Hz/m9f6RNK5DSjM/NNRWMtiVXAVRYStJiUbsSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=twmw2pQayNH8j4zrcfYpXt3q3qPZywjQAwtMF0i5334=;
 b=rPgtO/mzmgaPbuKK1RpVzCUhmVcPoowc3QWeZJXl1PiAYgCT73PGaexorCMtEgiRmPVFdIEb1X6xybje1jmU5bnqXeWKf8hwfoBDeguhKq56XezoRNWoXDYPrS4gEwGUd4i/6ofJbNeyElM5B5ayaR8wA8BXgpm6abBDaxg0A0Q=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by PH0PR04MB8501.namprd04.prod.outlook.com (2603:10b6:510:29b::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.22; Tue, 19 Nov
 2024 16:58:00 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969%5]) with mapi id 15.20.8158.023; Tue, 19 Nov 2024
 16:58:00 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: hch <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
CC: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: more int return value cleanup for blkdev.h helpers
Thread-Topic: more int return value cleanup for blkdev.h helpers
Thread-Index: AQHbOp11H7yRGjnk0kKwOA97rUTPXbK+0yYA
Date: Tue, 19 Nov 2024 16:58:00 +0000
Message-ID: <16eb991b-ba9b-4137-b8c3-ca73e085a4fd@wdc.com>
References: <20241119160932.1327864-1-hch@lst.de>
In-Reply-To: <20241119160932.1327864-1-hch@lst.de>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|PH0PR04MB8501:EE_
x-ms-office365-filtering-correlation-id: af239ba2-d86c-4751-451a-08dd08bb5356
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?eTRwcDFJL2VEY0liSGFNZG44d0dWa3EyMDhoUFFGUHFiOGZqUjQwdnNmd3Fm?=
 =?utf-8?B?U3ArK216MUV4QVBLRExKR3NyalU5UlRRSjMyMGwwZkpPMzFuK3lJcjJrZ0dY?=
 =?utf-8?B?OHlxWFVzVHI4VWFmZ0k3NHl3ZU1FeUN5b1A1NHRjUDJ2U2V2WjJPQUVsbm1m?=
 =?utf-8?B?SFdZT0VDaHVyMVRXc0hEWDhYekZVNnRVZUtHamtTaDJyQ1Zsdjc0QnVidFQx?=
 =?utf-8?B?YW4rOWliTkdmdFp0bHNqQUNET0FiNjZvTjlQdHRLdXNySWRPbVZtb3JISE52?=
 =?utf-8?B?ZnVxb2cxVmhHdkd4VXpBYlZpYnZvZXR0eEFhZzdhc3V1ZDlwVm0xOE5tYi9J?=
 =?utf-8?B?aENLdnplbXhzM0JyZERSeVpYSkZmUmhzVG5obGJhK0cxZEE0UTE5aVVUNzBp?=
 =?utf-8?B?U09YUFhWVVdTVVhjODN1M0NNaHNlck45Q2Jwa01vWjZ1QjVrb3JLeThIVlVK?=
 =?utf-8?B?ZXBYcGdLeGhQMjFNUTdqcWszSkdUdHRpSTZsMCtna0YrUzkweDZhSHJ1Tlhp?=
 =?utf-8?B?ODJrUXRiQkhjOFkycUl5TjZuMWlZS2NUNkUrQzdhUmFUY1lDbHFIWndUMnA1?=
 =?utf-8?B?STZ3ck9jYUNvbDRsNWQvMHliNTVqUVRudmxLV3BQZXQ2ZFlJSVo3UU42MGFV?=
 =?utf-8?B?eERDVUE5VGVIeFZHdjV3TFFidmZTMng1YU9RTWhKUzFnQThNbERJMGhKWnZU?=
 =?utf-8?B?dmhGM2pyZUp2aGwrMFhNQkswaFJWMHVzUFhyOHUwU3dKVkxhaHZzVFNzblpi?=
 =?utf-8?B?NlFvbHBkT1pVc2Fubk9MWndRenpsS0dxc2hQUFRWWDF4M2dNWUVJS2k1clBI?=
 =?utf-8?B?WFVZMnJGQU5ZeDBRUWdwVU5renNOTjZuZGRDWjNSVEVGTzM3UXVKdXMyRGVK?=
 =?utf-8?B?cmZZYWh0QWdEY2Z6UTNKT1dkMGgxbFBqbTM5SVBld2dscGx4RzRKalZoVlZj?=
 =?utf-8?B?M3BBQVRHSGg5SHZXUGFUQzc3bURGdFQ2bXFqV2pnNVdhV09yOCs1WEJNVC9v?=
 =?utf-8?B?dCtlWlNZMkZIbEUzUEx0OTFNZldmNXhKUkQ2ejJUT2h5ZmRGLzBBb0lveXgr?=
 =?utf-8?B?dUdjeldobjEyektKYms1cVYvWE92Tld2L1hvTytMdDFqSGpwdFhrOW9tTzFY?=
 =?utf-8?B?NWp6eFNaaFAwbng2V3g0bEppNndCRTdBV283bUsybm8rcWlmUXdXUVdWL2Nz?=
 =?utf-8?B?Ni9ZZ2ZzZ0s5amE0RnAxMFJTNkVoenR5WVV2dHM4REh3eWdrSmdhVzZ0NDdW?=
 =?utf-8?B?bXl6VDd1Zzc3RiszU3pPUUdBZ3Y0YlV3QUpGU2dRR0YwK1p1aE5zZi9ZRDBC?=
 =?utf-8?B?WEJCbHZIbnpsMTZpWVRQMXJwaWlWbWduc2Z5OUV0NFFTMjJhUVFpTjlvR1FM?=
 =?utf-8?B?NGREdU1jQ1JkNjZ5S2kzL3Q4Y2ZGR1F2Z3o5MWRJdDV5RUdvY3g5Z21tb1Ju?=
 =?utf-8?B?UHpoY0FXeWR1SzFPeFl0dG5xZFlhaWkxeit4YzlqRGdFVStnd1FZK25rMFFC?=
 =?utf-8?B?WjI3K0d0K00ycWJWKyttYnI2b0Npc1lzMFRNcUI1V1VOMVZ1WTYyQVFTNHNq?=
 =?utf-8?B?MUMrVXVlcndPT0FiWElxS1lQVVZjblV2bEtjUFpkSis5OWVuc0F3bWFtQXg4?=
 =?utf-8?B?WHRYQ01KQys5amNyZzlYRDJLd1ZQdnAvaWlNNnlSM0pmaTJjT2hWZkNMT1lm?=
 =?utf-8?B?ZXBpVzF1dUs2ZlMvWVVHSy9uem9Cc3FKd1IrdGN1ZDJZMms4VFpVbS9RcDAr?=
 =?utf-8?B?djNiazY5cmEvNmxuaSs1cVhETVdlNU5BeU5vMnhxUjBRVUpGUXJha09GSHdL?=
 =?utf-8?Q?XzxUXy6BxZBbuWo8OD4D6OzCPglEJOUo+zjU0=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?U2xzeWk0dXJVdW5pNDBZOWRrVFB4VjVxYUxLWWtZMHBrZmcvazZhUFVMZlUy?=
 =?utf-8?B?SVR4RC9JL3phcll0ZDd4bGlvU2ZUd0tZeTFHSDNWQVZoSlNURFBUalV4TU9y?=
 =?utf-8?B?RVRvaXRaUlNYcTVuV1ZpYUNNKzNqZDZYWEtEWjZ6Z1AwbTBKMk92bUJna0lk?=
 =?utf-8?B?YzhZaSsyTFVaYUxGblNSVTU2S1hGM3k3MC8yVDVDSnh3MFVrUWlPeU1WNzVM?=
 =?utf-8?B?TktZL1lQak9USVpGL25oQklWeXpFMTZKV2VBSVJkck50SlUwdDlERXRieFhz?=
 =?utf-8?B?aHRLTE1Ja1hnWjJhR0RCcXZiN1QvKzdVMS9oZWFBWUwxb3Bja0JFbW1WS2wx?=
 =?utf-8?B?bWpmb1FGaUhlV1V5N1RweGVIc1FZQUNOVFA0K0pKNmZaWVMweC9ZUDQzelYr?=
 =?utf-8?B?SUdaejJVdE9PWGZDcGlaOXEvRGFWNkdEK2RKQkNvamVreEtSbnVJYzEvdzBM?=
 =?utf-8?B?aWxDWm83VC95cEVDaU96Vm8ycm80NWEwdVVUNHgwWnlGNjdodUVVT3dHTEV4?=
 =?utf-8?B?Sk5SVEZwRldBZGJpMUhraU5TQi9MUU5QMUdPaUlWQzJqT2dDZ2ZJWU04MVRU?=
 =?utf-8?B?UXA3YnN6QnlvemIxb1hlNTQrekZ5WFZnVkNkV2laanQ2QjZwek1acjNHWk42?=
 =?utf-8?B?aExjYnpFaDFicFVVd2xDUlREcUp5b3pacVBFa3hTWWNGRHdhaHVxYVoyYTRk?=
 =?utf-8?B?VERBL2IrZjRlcDIvaUI5T1BqMUl5dFYvT0NjS2xLaXBQTi9JV3JaWW4veTlj?=
 =?utf-8?B?NWR1N2djb3RjMElFVVBqMDVla3FVVG5FS0tKdHRmSGl5Mk4wSEhJVjNJSi9W?=
 =?utf-8?B?YXV6UFNHL0JHWk9qOWVlN0lmZHFCVFpncnd4VE0wcEZVSnVWbnV1dXRZbTNq?=
 =?utf-8?B?SjYvRkRSZUNXWmVJTkEzSUhBQWw3d1IvOTBjWHlIV09yNkk2ZkRDNEJnNDVl?=
 =?utf-8?B?KzNqSTJoSVhIZDl4VUFNYVY3UkpPZHlsNHpWRXVERWI2N3lhZmpFdGlpTzBQ?=
 =?utf-8?B?T2dCd0pUOFJqS2NGUU1rTDJ5OGNnT21lN2p3dFlJSlVVZmJIOXdYeVNrdFF0?=
 =?utf-8?B?OUwwUGRSR2V1Ui9VUWZucmpGNnp5a1JQd2psam0wcjJnV0ZCaTM1cjFyUlVi?=
 =?utf-8?B?TG8wQ0dLaVZoMFhxN2lYbFR2bXdyeDhCOGthUGhLWklzdUxBdmRFTzRrNUdh?=
 =?utf-8?B?V0JFQWxZZmNtRVZ5SjJsU0ovaWRTMjBGajloMXFEV2lYRnV4RVVjUmtuOS9j?=
 =?utf-8?B?SlhuVDdFcjl1WHloWDFDWkIvYVB4UmVpdGtXTDlhaVErRUFIV0QwU3hNT2VV?=
 =?utf-8?B?eXA1cE02b1Vsdm54RlhBdnN0Q1V2SVFOVmFLVnA2VU5OZ0ZIVTAvT2t3V1B3?=
 =?utf-8?B?d29LT3gyT0JtUFpEU2VoRzY1bEtnem8wRjV1ejQvamRPUmw4UTc2TWRMYWo4?=
 =?utf-8?B?c2FFT0c4Z2tQbWd5UEZoeDVVbFgwM0dZR2MrbURpVVZZakVWOS9aeU0vTmFy?=
 =?utf-8?B?c3A3MjIwSlJEVVFvMkxYRkpjSUNWYkpaYnBKSWUwd24vQ3FSV3duSlA4N1Fr?=
 =?utf-8?B?d3pzUGdWL0VvRC9OdkVETjFhc21lU1IwQ3BIZWtyQTNMUlFCV1F5SHphQ2lE?=
 =?utf-8?B?eDZpdENVaGVmMTZCRE5QekFFeEVzckNTNU83dFJ3K0ZnUUloZ3RpdVFMWEp6?=
 =?utf-8?B?d0EydEJYaDg0UXZibU9wVEJNMGhXbFN0ck9TeWZFNFJuL0hDRXJNRmVhOUwy?=
 =?utf-8?B?ZFRMSmJhSDlKOUliNXdQQVFYWEl2MUlveURZTXBpWlNuNWZxYUoyS3RQRzhS?=
 =?utf-8?B?bThnZ3NuR094YkN4dis0TG9sWTlGR294SXpWRFhpaU41V2QrdERwUDB0T1BU?=
 =?utf-8?B?aVNJcmhUVE54S29Wc0ZvSDNmZU0vMFVBSER2VVFFVE9TQnVzNHBvbzhQa3g0?=
 =?utf-8?B?SjU4UHhDZWEvQTF5emVseHNZUzJock5ndm45aWcvaURja3M0WWMxWnJzK2Zm?=
 =?utf-8?B?Z0cwS29GOENRb1RNWHBUb0tEeHN3aUNtL21jcnV2UlFMeGhJWjJBZ3c2ZnRQ?=
 =?utf-8?B?SEsrekp5NXVvMDE2NVpJUDdzY2dla01UK3FKQXJ2Ly9iTWVzT0ZyYXltMmpz?=
 =?utf-8?B?ak9FWVNNaFlDWVNKNk5lZ25xVlBYRHBMRWdqb0EzREdQU3FDVVh1ZC9hQXBO?=
 =?utf-8?B?RVE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <80496D3C4074764A905F3A766A4492E5@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	AiE8s+6k70AZd2ZzqnWN4tvGk4pEjSTujznzP1OdYZZ0/HtNXGwIUTm+SEQb21fQ2bnog7+Qq8elqLviIGpjpcGLTVdtZUxR8xDSj1C+LVEUHk0bIMbbWfsbHTaIXltEc7O4e9C89+f2J0nuDoGsSqQgOkpdjNyogLIkdtHkVCY/aDFdCYWk1+JHWmXl8HdRSVczWE2n7ih0egjbnZtDoq3KBnk6RfZFob+XXHB8gM6F/0dGxoibmfh/iy7YF5msfjiqzzpvowTIRBdnJh9zrRxSTwK7eD89/58Q760cNuLdt5am3xt4sX4hLILpM97+/CSBTiZbUzEvSwE25ePn7buZWjZ+X+p5K+5SPdsW8dsaReySj47K2NxeKOv0eB6rrrZe/8XFOEaEE550abSW6acfA+4otqIRUg86+U4jueprqtUhdXCpx4H50CxpgzYfmNBTkJb2TMqu/tM2JdciiXL4xIUJCZENiXbJe687WGrPRNZvroP+gKMNU2K5AW+XRDF8T6h+4lLHGzOmCGws/XnzfEOIk7Lha6awB/RFiN/0iImaBVVheDsYs9v8WTCDNIZn9etZHgkjZflHUAUZrb73/GRAWmye2DMzpKJxWvE5WEyYhyOshmBvB5pLhJef
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: af239ba2-d86c-4751-451a-08dd08bb5356
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Nov 2024 16:58:00.6010
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Zxx0V1czvcfrdMuojPtLbDcilDpR+76SYsGrexmlU7UbYPXtvRBMZTksWPsQxN9/pD2F1hBuzYmdaYWMpYTU3f2Ee0uKS5/eUSfU2yJN8rM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR04MB8501

TWludXMgdGhlIHNwZWxsaW5nIGVycm9yIEpvaG4gcG9pbnRlZCBvdXQsDQpSZXZpZXdlZC1ieTog
Sm9oYW5uZXMgVGh1bXNoaXJuIDxqb2hhbm5lcy50aHVtc2hpcm5Ad2RjLmNvbT4NCg==
