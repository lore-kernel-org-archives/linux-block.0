Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFD0012B169
	for <linux-block@vger.kernel.org>; Mon,  1 Jul 2024 10:22:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.154.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719829378; cv=fail; b=nKONKqX0vgTRL5+NPNIVPrSj5V3knoiUmZ5dqEKzw6i7DfblCbRxXG5TtnkJwV+uer/BXQJYoIMGu1X56O52K18TrUqOp4hwe26Qm8ddoS/39oqRgb0acEch/mMoMHnxxhNxipouwcVQxbzFpL7MEWmNEsfFZVF/+Dc4tkI2DPo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719829378; c=relaxed/simple;
	bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=WmPH5XVB57KtTjA/rjFW6kbh38CN7vP19JazgSeLVXb4BAr3GYcg4BbiSN8kj93KZGuQVKSBRu8mzPIp+t9iLKvVsfJlTOWfltAdPkOGEw68GU+6AHDR/xepns/omegTJ8/qP8UTaIBF+5a9ush2a8gpw5/9tXi1w7yizXakyN8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=WyyMyZZm; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=Bsq70Puf; arc=fail smtp.client-ip=216.71.154.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="WyyMyZZm";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="Bsq70Puf"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1719829376; x=1751365376;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
  b=WyyMyZZmuiJYx1bxPf8qH/HrZTCgmQ0pNjeQ5FC24kanKQnSRm7sIrNE
   eT7z91Pn3QGm1w7RnfNyBce+9PvzzVgDZeEI0/3XVjab18r1RHRQS1dVa
   CRRf25U9GrkaRsV1HF/qPpmrwyXdgD1D4mbVEEpnpGq2ywdpf74bJU4Y/
   JoIJVXnJ937Ua9sPjjB9yYxlfcEXDAw1tPSkonaFUWnRyQ7xRyZKy18WS
   vZv09LeO5Y0S5m0Fb3MnuxJ6WfKi4ZPRt07VaRtIwsD9MNTWAIuBtHGOc
   xrBdoAis7+2MsMyqSP15Bj9YVp9scIBJdnQplYOmS5qkOwAi+yCIMg5cz
   A==;
X-CSE-ConnectionGUID: QT4Jv0AwTFWet5KncrkxCw==
X-CSE-MsgGUID: MpkWqSQ8RLyCMI+fttNiuA==
X-IronPort-AV: E=Sophos;i="6.09,175,1716220800"; 
   d="scan'208";a="20484284"
Received: from mail-mw2nam04lp2168.outbound.protection.outlook.com (HELO NAM04-MW2-obe.outbound.protection.outlook.com) ([104.47.73.168])
  by ob1.hgst.iphmx.com with ESMTP; 01 Jul 2024 18:22:53 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R7Tyu9kK4XEY5XpCCG1n+4RouJYPQz+q2h/FnHgWgSdJ12Hx2tRY4Ypzuee1rRvz/vmnkQt8Eh5r4Ph0OxdWp3Ou/eEQT7H4AeW11OveAFbZQmnXU0mgCQbfeVq3SvbLSAOJf4MusJqdpx++60XyDg2lmk1Rap9E5+pxoaMSZKkLFo7v390qEM06nM/r4Pcg4zdWRVT5CGhHPWuX9s/9J6a8/V8Rf5NhCYSg4joSFa/LE+dQ8HN1umwQQIY3WtABFh5Uqgkm1q4mrTVgmvD1wkiBf1eEszDsdBE82gEiG1JUnKIYZUUDdW/oBSDPIrlOGpjIPxUsYCPyiPC6O2biRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=hmV5ylHfvmzV4hAKgHvYMq26gKJa3Ga+JLQgQIMlwxt0Tpt+jj/Fl1LxCxlRaruGmGJYdCrJ2U/64tmA3j8NVZpPTbVhd5f2YPWZlkDkn3VwFGG/dWE9gmksu6O/SzBeaMSqhRC0M9ln4D7wzcopaL8wjPArQH/HdEEGntTPukRpiNlwWTqx93Igq1TgscQU1dvivUqR/0L8L2zTmw2SnvwAL/gjb9u8EFmHB87J5sobtlD+qvEyKjRXCvBwRSLY4bniEcH2XX+WpyBV9vDeUpBnmMuZyG1oTMb9WbeYZi3KP+DqpkstztI9PMwDTeod00eBXyAV2EGSPVGV9a1gvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=Bsq70PufvjgzD7uekLj8FsdJwvPkvXVBI3Y8rF8ZHzNcbQHcHlsJHIPaYuCN7bpZTJXMPR2GYRdvO1xi7ZCXeRwuJhA9zQacLAoaUQZiMjss1jzUeG00h0QKDBf+qOw4p3fvgguEtO/iQOaPiTqcaG0rGjyr752DYuNWHI1JFa4=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by CO6PR04MB8426.namprd04.prod.outlook.com (2603:10b6:303:145::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.32; Mon, 1 Jul
 2024 10:22:51 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969%4]) with mapi id 15.20.7719.029; Mon, 1 Jul 2024
 10:22:51 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: hch <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
CC: Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>, "Martin
 K . Petersen" <martin.petersen@oracle.com>, "linux-block@vger.kernel.org"
	<linux-block@vger.kernel.org>, "linux-nvme@lists.infradead.org"
	<linux-nvme@lists.infradead.org>
Subject: Re: io_opt fixups
Thread-Topic: io_opt fixups
Thread-Index: AQHay3YVPZYNeRDN6kOgJRklH60QtrHhqlSA
Date: Mon, 1 Jul 2024 10:22:51 +0000
Message-ID: <7a8fafc7-f8e9-4939-837d-39372be05bc4@wdc.com>
References: <20240701051800.1245240-1-hch@lst.de>
In-Reply-To: <20240701051800.1245240-1-hch@lst.de>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|CO6PR04MB8426:EE_
x-ms-office365-filtering-correlation-id: 7e4d129d-d5e4-4d1a-af0e-08dc99b7c341
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?NjFXOUxUTkpKazExL0VIajB3MS9jeGEyS29YSnhLOVRDTmpnOEg4Z29JdjlO?=
 =?utf-8?B?Qko3YTN6MW5FQkVrWHQ0bFVzTGcyWjN6d05hYVN4RmR2YVR0cTVWeWhLT2Vt?=
 =?utf-8?B?blBGT3Z2ODRIck5oQVFDdHpud0FOR2NmOTFlWjNUSk9UTTYyUTNNdHk0ZWFM?=
 =?utf-8?B?U0lpaC9WbUMxbzJBVUFJRVNUNGo4b2tlQzNtbjJrVmV4eFlxRFhnMU44dDBu?=
 =?utf-8?B?UmRSQ0o0cCs3eEdMMlpWZ2tITXRhTkFOVDJzS242elNDVHRURDFEZzl6azF6?=
 =?utf-8?B?NUNoT295UzkwSGhZRC8wSmpnSW5udEswRWZnSDVWdC9QaCtMVktmNG15RCtZ?=
 =?utf-8?B?dkxlVjlWWXVUMDRibjVFZUs5dEdyMkMvU24xa2hJNytGWU5qZXI5MFBaL28z?=
 =?utf-8?B?Lzg2OVN6ZnpXZlpwUExtWVp6bmJpYWZaNkdqN2I2QUd1dGszc2dna0Mrbmto?=
 =?utf-8?B?aXNKZnhZM1N5NlBSYjZOQnJZTFJTRDJ6a2k1TDE0UnVWZ2NsbmtkNXdCaWJa?=
 =?utf-8?B?QjFpRFd3aVkweDdNT0pOdG04cUI3TDBxeWY1cXRiZlI1WFNZZ1lSb1d3Z2V5?=
 =?utf-8?B?TzhMS1JCMS9mMHhHd1d0aEZ6UUUwNk50bkxEd3JsSElVUWNWOWlYbEVpOU5Y?=
 =?utf-8?B?RU0vVyt0a0pYQ3VWcDNqZVVBYW51OFZwYVVka1liVysyTXRTaDR2TWJqZ1Ba?=
 =?utf-8?B?WC85c1VRSHdSY05hYzN1a0lseEYvUHVibytLTzhTY3VKRkZZTGdNdW9yQjdw?=
 =?utf-8?B?QTQvZE81Q1AvZ2phMW93aGRRQmNkUUVITEhiME9pYzd1Z2ZuU1BEVm9leldS?=
 =?utf-8?B?eDZuQjRieVdXeWJISDZwOFh2MXY2aVFOMDNOQWxsNjRRL0FIYVMzMWxtcUpS?=
 =?utf-8?B?M2VVNzUrU0JKeDRnODhyY3o3V3JJalprZXUyL1dyU0dsaFc1MzQxQ1MydEY0?=
 =?utf-8?B?VlF5UTZMR1gyRzZ0WTVaOUx4SlJ6RFcwQlpFRGVPZUVHbXJmZzNlUXRFb2po?=
 =?utf-8?B?WFFLYUk4bS81WXhHdU85OU43bGp6REhHazlFTktNOEZ2b255MUhZUVA1R0Ry?=
 =?utf-8?B?Mm1BdU9XTVQ1c1BZT05pbWtFMmk3RWVab0tKVWxsT2NxRUw4dEdKcWhtVWFV?=
 =?utf-8?B?UzJYVFNBVVVvZVZlejRkT243Ylo5akFselBCeUVDMHRUVHBjS2QyREcxZnlV?=
 =?utf-8?B?c21yRmdNS3VTOW1sbVQxM2NKWXlreEdhbGJSSmNTTzArLzkrdXBScCsra3Q5?=
 =?utf-8?B?bnd4Qjk1VXBaNlFoL3dpZ3ptekk0WGZ6N0R4cVR3aVM1SitnK3JGUUkrbSsz?=
 =?utf-8?B?SnV2cHZHTExiNjdFNjl3Qlp3S2JmTXRCVGtLaE5venp5bHN2MGkzMERyZUZZ?=
 =?utf-8?B?RDVkdUY2Rm9KTlBUcGQ4VFNkWkY3d0FWVm5ScjNwRHRvNVJCU3dNTzJqaFVw?=
 =?utf-8?B?QXlBSVFTMEh3bDRkdFNkSEtNWjZWNXh1WjBWUmExbzJXNTRCZVd0QSs4N0xK?=
 =?utf-8?B?QW5tOCttRFh5VTRLZTRteklwVnRDUlRPVWlwbWw4M3V0UDlHYXVBMkFLeTk0?=
 =?utf-8?B?Y1l1bUNaVUpyNmJ4T3h3WlAxblhoRXJzVC8rMmVxQ3pwN0thcjhSZVEvQzRM?=
 =?utf-8?B?b2kzeDlYZFd1VzN6QmFQNmJHaXJQbVdKVG5oRDZTRjVab1U3QnZrTkxISlUz?=
 =?utf-8?B?Yjl3cmZsYlg3eXhtTTNYZUdlcDRXWnlackpwbTF2RHYzMXBIME9CNFYrM1do?=
 =?utf-8?B?cTUyR2RYdlJsQzl2Z002REx3dHh2dE9yTk9GenY2czJwaGdKekdOQ05NQk1k?=
 =?utf-8?B?TE5Td09IUzNUS281dW11VW8zOUFSRzlvZGpyYzdsV0VxZXQzQzFNcGRzalRF?=
 =?utf-8?B?YzFpajJSZG96L1RvUm04RjBEV0c5ZWxqN3ZKQkNlT1R2aEE9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?U2l5cU02SmlHVGVOZmhaazVUQVk0Sm9ZZnZsRExyWTJIc25ZNjUxWktyR05p?=
 =?utf-8?B?ZkhEYktWMGdRVjhqQTJicFM4SWwzajkxbkh0aE5VZEsrMW4wbWcxSlFBclBu?=
 =?utf-8?B?SjBPY21LVHpuNUlPK3YvcnhTMzZHSDM5Tk1PM3hqbDRnM202dVNSN0U3TlNk?=
 =?utf-8?B?WVZOMVlaRDdKU0Z4MTVVTTRyME11TkQ0U1JmeEtvVVhnZVdkSEhjM1BDZ1pR?=
 =?utf-8?B?VjN3Vkw0M0w2d0tleXdkQUJQMFp2MnFLOXovYW1rWkpMRVBqOWZtS0VGeko5?=
 =?utf-8?B?OWwvaGE5SjdRMEpPUHpDZ0RTcWpNTnByQ3g5OGZ6dlpRT256ZEhGMVB1NkZQ?=
 =?utf-8?B?dmM0VzRIV2ZWZGVOU3N3TkpKSzVZQzlZN1laSDBOQ2tGTTg0R2lKTitCYzRM?=
 =?utf-8?B?dWJCS2VibHNwZnkrTjlUbFVrNWIwUjhLYXh4d1hVT0Jwc3JIZHJzbmxoRUE4?=
 =?utf-8?B?NGh5UzV6NVMzMk9CQ1RIUjZ5WWMrMXRhdVhTSWg0MDBEeVRNdWdzYiswTDk4?=
 =?utf-8?B?Wm8wMkJQUDJGVkh5NnA4MTZpNU5nY244Z2hzVE1IVVRXVU1tMi9rY2RYb0hS?=
 =?utf-8?B?OUc1Z3lFQzN2d3lTQmVOaGV3alY2Tk1qY1lyRVZrSGVkV2VSRGJ2MFg0b0tn?=
 =?utf-8?B?QlFPdWh0cXBNWVN3MUZmYnRNd2xIWm1vSmVPQlpReXUrWnFjclhNUnp2ZkUv?=
 =?utf-8?B?cWk4UTFxTm9SbWFFNzZqdElpMlJIN3gyOWk5NDFuc2VmdUh4Wm00UjI3Sjhk?=
 =?utf-8?B?SVE2bWJwK3RtT3N4N3V5SUhJSnh6a3lnTHc3bFRiZUtSOHpKSFI4Qlh4SFlL?=
 =?utf-8?B?bW1NQ3d5cDByNjJVb1NmakdiNzhyYVNTKzg5emM1a0J0UEFjK1RlQWtieWdF?=
 =?utf-8?B?cGJsanM1MDJKQ3lqZTU1cHR3Qkg4ZXFRV3Zjellld0ZXcHQwQmxpNnEveDQy?=
 =?utf-8?B?dG5yb0dvWnpVMCs4WHFvMnB6c3FTRTVaT2JhVWFsM09UUGZjU2llaGFzQ245?=
 =?utf-8?B?L28yUXA3L1lqWnpadjlndmg2TzYrQUwzTHZsaC91VmxUMjN5N0xlVG9zNXFq?=
 =?utf-8?B?RmZzWTRKT2lybFRJdnBoODNTTTBMV2d2RWdBdXRhTktpZW04RkRhc0tyL1NS?=
 =?utf-8?B?OUpBczc3VVlsRFhSNS9tenZvTTBESW1VRkhrQXdxZi9DcjVPb3RKNmZmNmdC?=
 =?utf-8?B?dTl0bGd4Y29hT3YvTHRFcU1RUXhraE1WN254Uktha2pxWGtZZHpmdDI0UzN1?=
 =?utf-8?B?Mzg2b2tEUFRZaEZtWGw2U2tVK3g5eTVnWGoxdUNGa1dqNlpqVE5FTDdIVlFQ?=
 =?utf-8?B?UGNjcE9VZEtDWGpTM0NZUnYrRWErcEMvRWlQb0FHbFJXcDBKVmoxa1c0cExS?=
 =?utf-8?B?dU53YWppeENKcFhESzRhMlloZXMzajVWdkcrNUk0bStsak5NM0twWjZ5MmZL?=
 =?utf-8?B?MG1kTlhUQnBBOHpQOUdpWnBGMXFQRGt6MWFnNHZuL2xNU1prQWJLbkpTTjNF?=
 =?utf-8?B?VlFXK24rQzBCUHpMcXVRYjRQUTl1SXpKMXpWTloxazkzbi9sQkx5Qk9iMWs0?=
 =?utf-8?B?emNxNCtzRW9IRzBYWnBiUDB2blp0cjFCL0VqM1F0L3Z4emlDUHJ1azV4VTFo?=
 =?utf-8?B?SzBOSjQxSUtBSHRKcTVmdjMwNU5VcEl3aHR3bEVoTFZtTVFpV3U4ZWpLNFIr?=
 =?utf-8?B?Y0Yzb2JzeHFqV0FvR0tWVDZhd2ZXTXdHQzlCRWNmQnorZndERXVVRG1LMkJv?=
 =?utf-8?B?aXlVS1RaREtaMVR0dHFQbHcwS3VmSmFaM2RBd2NsTVR0SEFTWGlnNW0raU80?=
 =?utf-8?B?aGEwMEVIblVpaWExaCt2Y2pNaWFsZ0hxcE9WVzRVckdjbWFVdm83S3dsNDZp?=
 =?utf-8?B?Wll4NkJUNndKWjhnYUc1REpTdUJiMEhrRXIxN3JtVnJqWUlOam1GaVhJNFdY?=
 =?utf-8?B?QXM1Z0EyVWI1UlZiRDQwcXNaWTdjUzBEejZEL3lzTnVYcFRjc2g2QzVaTmRs?=
 =?utf-8?B?eFFGK053bXd2MEhzMjVrWEk2U3hSWkZtZkZ5Ymp0b3FoVTZRenZxbDNERmNF?=
 =?utf-8?B?VWdDbUd2SjhDNGZrL2VaMC91RWRTRkdKaWNWTSthbFBzNHVkVUc0am9hc1pL?=
 =?utf-8?B?elg3bjhEUmpZOTNFbVZrand2bzBhR0d4Z1VsSkZiZTdyUFdSb3dnQ1M0Rkt4?=
 =?utf-8?B?cEFFanhCVCttbFU4RXFzd1dUWlNodWlpV1FsTUlObVRLcEsyanFSRkpJL2pX?=
 =?utf-8?B?dUdZU05yZ2RDOTJYSG5IU3luaHdRPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <13D439A0A403C44DBA400342F4EBD48B@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	P4uBmRJgpgG/PiaIBYWn9yLI7SgkZARSUk4WIXMhuYr9W/JUp2c8YFumoZpw6tROkf0OTbiIwtVMw2xNWycpAn+wF0l6HPvLt6u+sOMRVUeQm6ou4cckDd4Ecse8++czdFYifsDpV1JAocCIdDZkGQDgHwCSLxUiU/my1Hs7VjwEY3jTfu/oPJv2LepnROB1/KJU38pZ/yJMZoU0UlvmPr5Q5uJshGhAYabAyUjbkyxv/HeDtdHYrS66dimlZ+rsVzpaXCxP6hlARvOmppLtO+keHbydm45cmL8406ovlDXE8Aucnlgo4QOH7lh3kcLv8taI0VspdFSf52c8McF/bwz4HjonR/j8IjQIVIbCYwoxHGCkxt3NL/2lZTHcA1+2IH/Me/1IUJ8OmZn2XqgYGr79O2zJN3lPSm+XcvSQ8k7aKhVQ2r2OJPEtZKFccobioGxLY91ulA1ScCfTQoMFbP/5a8pa4uKK4pTkli5jCCZf8l0rEbnXLnBxce85fP8aJ/E4RXvNAhOJzDvqm2NcvhhYSLhCnSGdeL1vpGh1p5BNYbQWv6SYUZ2UswjYMNGW4ytj6NnE0GZv3iLx6bsVKakD7rS0B9UZ0qjqKjkNliRub5QR0/rAp1ORerkS+DLZ
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e4d129d-d5e4-4d1a-af0e-08dc99b7c341
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Jul 2024 10:22:51.3502
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6nUj7Le1z2U30B0ZEjHRJk4OnHWEyStpUmBrgvgaL16hm2T8bMmiP1UuJrAJzrX3TbJCoBgHjMX7VLuUiBbJHotaD7PhcyfDfaC/oXYRFYc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR04MB8426

TG9va3MgZ29vZCwNClJldmlld2VkLWJ5OiBKb2hhbm5lcyBUaHVtc2hpcm4gPGpvaGFubmVzLnRo
dW1zaGlybkB3ZGMuY29tPg0K
