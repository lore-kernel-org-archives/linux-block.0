Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D90F517DE36
	for <linux-block@vger.kernel.org>; Thu,  7 Nov 2024 08:49:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.143.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730969343; cv=fail; b=nwKGWPoeFZbX54DUzMabu6kjrdDsYwPpLe9R9UkqBMrXsNvaXI9iVmcza9rmWpZNtrlcGjbxjWJYYimsAjLPPobJSbvFTnFFg2ncoe5C+WlBfaKCj7MDmY6J1yF1DaxGbkfQS7Ela3L6Bra3c/IYeEs2aa6w5xLtFHZ6sJtrqDk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730969343; c=relaxed/simple;
	bh=3OTQIm7orki45HZYQutnnCso82H/D/Nv0I77oC9qhyE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=cKllbb29jR7jOkkZ8uPcdkowmd61R7d0kAJXW22xDRHAqmR0bnjPdEewVPjcB99iGFURgCDI4aiPfDoOH9uL7U/aMUB2IBYvFg8Q83x0XEUX+S1Z/aM51IJeDyBW3DszbkEPMWfcIfpjANr1Yr/0kwSf+LuM9/6S9T/b3keLPFM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=i3cjmd3X; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=B0v15OWU; arc=fail smtp.client-ip=68.232.143.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="i3cjmd3X";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="B0v15OWU"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1730969341; x=1762505341;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=3OTQIm7orki45HZYQutnnCso82H/D/Nv0I77oC9qhyE=;
  b=i3cjmd3XmD4Te6bDhAccKjZut4u2mjc8yj7siWqLh/48GvH1ilm9DWNa
   mdCX0MkMEeVhhlBsAIVA2NqDJvOTxMSMw0R7YhrDBtBUofy737P+og0vM
   1JLqSC97jhKASneh0sCu4khadg4/p4wv2zX2WHwQMf9+MbW010SJmJXzf
   aeasbxAQPCIsMGoizkeE2Ba3SQZiv5M+n6iUpYKAAxnG8jeSfP9LBxbuh
   ukE7TJtFgVu6AZ7rL8+K3rMBNHC5hdjAOCPKAiDvGS46iQGpj5u7E4SXE
   s7qdkT5e5Y3kb0Q5QFo6sUws3TYfuZH/u9qC85gjhl5C7zrhGq9pMKuxy
   w==;
X-CSE-ConnectionGUID: pW1/1dSQQCutpG8zA5rY1A==
X-CSE-MsgGUID: oSpcj8CQSWmA0Vuw9Sn75w==
X-IronPort-AV: E=Sophos;i="6.11,265,1725292800"; 
   d="scan'208";a="31392532"
Received: from mail-mw2nam10lp2048.outbound.protection.outlook.com (HELO NAM10-MW2-obe.outbound.protection.outlook.com) ([104.47.55.48])
  by ob1.hgst.iphmx.com with ESMTP; 07 Nov 2024 16:49:00 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MGug123sic6czqVFfoD+1COwWfmsV5/mhNyIIKy2hS1KvLAMdCmkfwXZBbUyuLCOv/X1crYIpDrPBDvqFJS0PJgI27qno0hzOkJffE0RotCGSG65Xr3ffK7w4pKMx6+xsIyCFWwxTkzZ0EBGguzry0si+0NcvDhKKqncJhai9813LmiVB1RSEAxpLdtZIMs3+iQ5hxPW+Ozzlv8OdnrXqQQAzUje/3sEp0s2AmTi+yujLyi+51p0g/X4FBc13JWtc9MsayoNw5L7qpriWEpHYriUvAuX8i6Ut+aA46VWVffB8OKMMd8OWg70OhGDk1Pbtc8rJwV+OqGNC8nMWJb6Cg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3OTQIm7orki45HZYQutnnCso82H/D/Nv0I77oC9qhyE=;
 b=DdfMF7TPESYd6bAEkpuocDVKh1rOORSIAIt6C3nWNuQ4hDxZGE2jb2MvUUGjgtOROXqcDNu2ybbYiDeNSaRaTsk01VhRdMEb6rqQPuAUhDYZGbz/kKMmr5lf7NB1Ahjv+iXMybcgytOZSUFzZxT/bzZqezUqJFI/WSXl1poSzRSHDmc83p7ASvbdu/hkT6A5h2ZbgJc3ZuL2ZAxh9gH4iCb5kMWnVpI1O0I859ikW2M24pNyoNmRRz5mi6VC44zbm8AVU5o/KXPUGYkvg3W4aXjpbbn9C55m/S4PvQXG+Uh/87OCI50LfGNENI6PhtsCRP7tQ695BCXFZxdEFBJShw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3OTQIm7orki45HZYQutnnCso82H/D/Nv0I77oC9qhyE=;
 b=B0v15OWUrvGBQsR7MG9CcEWPipeWTi8NuJjqJqCLvtPlTGOzUF2bunz3zvQsvvspPM/EGaiVAvXGg8IeSEA5vA5vV2Qw/4E3FbYqRjAZKiS4jUJBUGdK9889nPqxuqENHx0Om4WxuMt6KEd8xwWpV2qQPlVIpIeAyeO+o/msywc=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by SJ0PR04MB8230.namprd04.prod.outlook.com (2603:10b6:a03:3f7::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.21; Thu, 7 Nov
 2024 08:48:58 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969%4]) with mapi id 15.20.8137.018; Thu, 7 Nov 2024
 08:48:58 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: Damien Le Moal <dlemoal@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
CC: hch <hch@lst.de>
Subject: Re: [PATCH v2 0/2] Introduce bdev_zone_is_seq()
Thread-Topic: [PATCH v2 0/2] Introduce bdev_zone_is_seq()
Thread-Index: AQHbMOBQLA56Hv4+dUuqBS3YbNf7GrKrggQA
Date: Thu, 7 Nov 2024 08:48:58 +0000
Message-ID: <2041f3b2-be7d-436f-bd85-ab1aa892e29f@wdc.com>
References: <20241107064300.227731-1-dlemoal@kernel.org>
In-Reply-To: <20241107064300.227731-1-dlemoal@kernel.org>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|SJ0PR04MB8230:EE_
x-ms-office365-filtering-correlation-id: 5bd98abe-ed0c-421f-3d1f-08dcff090541
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?RXdoVmxpTVJ0UEhhckh0MVhueHg5UE1wRkxMQXF2ck9DU3hTK1pNNkptUTBC?=
 =?utf-8?B?aFBDS251M2FMaHBQcEt5UjNHcng0YkU1a1ZVTjRuazZPVWRmL1hkb0I5ZDQy?=
 =?utf-8?B?U3E5cVYrUDRPTXdBSTJ3aDhoZCtwOVQ4eG9wcVZwYlc1UkJiMy9VakhGeUZB?=
 =?utf-8?B?MTkyVytrVnZWOEhnWDVNWUJENjl1TGh3U3RKNW8ycVE3MjBxaEZwdVNqK0sv?=
 =?utf-8?B?Wkw5R0pQM01DN0pITXE3cDN6ck9ZSkNsRDMrUjEzM3F2Rk5JWXo0TDU0NkhC?=
 =?utf-8?B?MDZTREVlOUFmSXg4VTlOVnlxRVN4NTBLK082ZkFER0QwYjg2Tk9lUGFVU0lU?=
 =?utf-8?B?QVVGT2JCYWJVTGl0alpRMGsremhTdmpBbG5Wc2Jpd1o0TFd4VHZ6Z2RIMGNS?=
 =?utf-8?B?T3Jhb3ZLYmFrcVRFcTdhZk9UZEpSdjR3em1VbVRPUTg3cHhkZk5yR2pUdGZU?=
 =?utf-8?B?Q2NjWUVzemJFZ0YrL3dBL2NUWWs0YUh5Q2g3aTNyQUpLbFpqTm1NTlpRN1Bj?=
 =?utf-8?B?WGxSUVhYeFhVdnl1SnVNdjFJblJ6VS91OGpWKy9TY2owM1lMakxqb0RPYVlo?=
 =?utf-8?B?MEJoWGsyQXd6L2RzMDJpOVBxTjlPVGo4V0hjVWNDYThjZmxmOWtHSFlZVHVU?=
 =?utf-8?B?b21rcFNlcGtWWmF1bm1sUTRwLzE3K1Z2MlRYd0dUQXFldW9jWG9wd2xaNGh0?=
 =?utf-8?B?N0ZES0JFOW1jcTR6ZjAyT1lsZXBscVk5UmR5T0hXSnh3REFFUDhNU2dLbURv?=
 =?utf-8?B?dUQvRnozd2h4MU41TlFCN3lpbGJGUVZNS3JpY01xZElubk1UNUh5Q21ubjVL?=
 =?utf-8?B?eTdFVDRrS28yZEVGS083NGVzbkdBOUNUc2NMVDFSbGVvbC9rN0svY0ljTnhl?=
 =?utf-8?B?VE5PYThXdnRZb1NOVlhOcU9PWFU1UldZbXZEd1VMU2xyWjE3ZFNSUGx6dFZt?=
 =?utf-8?B?dSt4aFFESmVpblZYM0JpUDV0ZUVhYVhUWERuRk0rdktqL2xGcWVHSXZRcWpR?=
 =?utf-8?B?NFdYUlVrM2I1bXB0TVRCTWNMNzBHVjFlbTF3N1EvRnZmb0hhakN1N28xZW1E?=
 =?utf-8?B?eGwvYTMwckJQWUFoVkY2WjA5cDlKL2gzNEMyQzF6N2YwM3p5UkpCVjBxc0pq?=
 =?utf-8?B?eGd5OGdtZTNKcTdxU2FpTjZWTjdCdTJJTFZZZzFLNm5XQjlRaEcxcUFOVW4r?=
 =?utf-8?B?RVlINzNjYmcxZXVVS21mMEd3TmEreGx5NkNVUDhGaWlKOFRBbTY4a0FIb255?=
 =?utf-8?B?d0ZQcVQzVXlWYTI0a3ppSmQ1cGFTVXVMbDNVaWFvaUFrV0Ixdk5YYzN5RERZ?=
 =?utf-8?B?OUQzaXc2d3BJWElNeE9rMzd1Wmh6R1FCOXhZWlgwUmsweVhLUWo0c3B0cHho?=
 =?utf-8?B?d2t6bjB1R0JBSDgzWXM3S2FJUE4reDhObC9QcEVRSkNhWm5aaUNaYlNXNnBD?=
 =?utf-8?B?dlJhNHY4b05CZ0UzbVdjZ1lHQzFPT2NFdGVHZkozOFlJc1d4OWh5L1NYTG1m?=
 =?utf-8?B?QU9DdUsxMEMzYnBGRGZEdThQUnc3bTBjWFpDamFjQ3p5SlVXa0ZqY0ZDaUE1?=
 =?utf-8?B?b0JoSE9yRWZzVHVKVzY1dEZiemJpYkdLN3AxZDZzVFArOG1KdUMxWmZxbm1l?=
 =?utf-8?B?dlNKYjVqc0FKWGVyeFdmUFZhMVhudTF0ZFFoT1NFN1kxdlVHNTBvU3FBS2pI?=
 =?utf-8?B?RklvYXg4Z3Y0akhwWEpuWmd4K3dFajJKbzB3bzNPTXMrS3FLN2l0UjRDU1ds?=
 =?utf-8?B?NExIaVViU25TbGdiZXNJVWs2NTVabWR4QVNqZkdBM25HNG5VN04yUUhzWkxw?=
 =?utf-8?Q?S53vOMacr6m8lBglK0YDjeJWqOCtC2Legz8TU=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?d04ycWpGQ1lwZzhteHFCUENSeCtxd2RzUTdUNzRmWnJ2VVJ2b0VLaENhU3Nk?=
 =?utf-8?B?cjN2Mms4VHV5WFB0bWxYL2svL3NVVWRLVEVXN3JWSjhKNGFwQ2F1YzNNZmFW?=
 =?utf-8?B?Y254NlVoZjdmQVlkYUN1UDIxc2Qvd2NGL2RRb0N0VHl4TEgzMWk5ZVlpRGRm?=
 =?utf-8?B?bkRWV29Genl6NGpPb1g1eC9OVWJvWGpHSzc4RmZVSU5sNlFKUjFVV1Y4c0h3?=
 =?utf-8?B?cWJuYjRwM29saTQzb1JnbG9CMUNJaHBrN3pTQ3NQVDUwbGMrUXZLcy9CSFFK?=
 =?utf-8?B?UitTTHhmMitZME5hbEp4c0ZSbkxpaUt5MFVkb3E4QVRaWmVaZk9NZGZGaHpL?=
 =?utf-8?B?SE9OOXgxeWJ2aFdSYVpxM2tCZUJxR1dueGlzT0s4eFNicUptR0lmODQ5Mjha?=
 =?utf-8?B?QU15enE3UDJ6NWw0TG1OcVdpOFBBTjF4RGJ1K0dMNDFHakg4TnhMSm03QWlR?=
 =?utf-8?B?MnQ5ajVYazlmVGtlazVkNlViYXNKSW9DRWtLVTRBQThYOS9aTkNhajVVd3Nn?=
 =?utf-8?B?d1FVUEk0eEtpcHBFdzIrd3FydU1yYUtZdTd1YWJ4U1JuZUdtSVErRjlCZndD?=
 =?utf-8?B?Rjd1RldRbnJ2Z2VoMnJYZ2xrY2NDOCtscXdXR0dNN0VpZGVZOWdFSUhoRUQy?=
 =?utf-8?B?b3drekIrNk9FcWQ5MWp1QW9mbGdFS2xHWWJQdHNqcFFjcmFjV3R6V3Zobmky?=
 =?utf-8?B?eTZtK3hMK1FiTTA4WGtueEFUc0U4cDgwVUY0Y0NENllsYXZTQzJzRGQwWVF4?=
 =?utf-8?B?dThzNW4vRHo0RDJTZytpMGNlbVMwRkllclhXdkNYT3lwZlVMWHRtdk45MnJq?=
 =?utf-8?B?UHdzcGhYcnlyVkx2VDJvQTRNdkhUUzExQ3VRV1hqZFNKWm10WU14MlpQT0pJ?=
 =?utf-8?B?ZFk1MG51STNlRzZkMVNJU25NL3NJUURzTStOcHY0RVpJZnNxVTB5UGM3S3Mw?=
 =?utf-8?B?cEVzaEs2UWpHWTRydzVrdG00b3hmRDhwbjdLeWs2dXdxZnJ3dys4SXhldlpy?=
 =?utf-8?B?djQ2Z3pnNi9PVUhsQmVvemtrVjBpcXNTY0g0cCtobUtSU2Z4b1cyNmwyY0x4?=
 =?utf-8?B?b1RvMFhVdE1qcEo0L1MzU2JrcUE3LzRkWTcxTGVFblpKaC9IWUhWZE50NlRV?=
 =?utf-8?B?NHZLZmt3aG43eS8zUHdKZHZBVnA5SzRleTFsU1YwZDJMUXE0QUVrLy9KUDVR?=
 =?utf-8?B?ZjNUZDJoM3pvV2dDWUdUSkdDZGhuZkxBanRCUmhiTFlqazV2OHo1eDlTTjlt?=
 =?utf-8?B?L3lZbVpjdGl0anZBYk5LSzJUZnFIOHhJcUtCS0cweWJycTJFdWtrTE5GcGhp?=
 =?utf-8?B?YUVFNElwaTBDUS9GZXpnb0lRS0xsU1ZtNVpKUmJOeWRCY0VEVFc4Z1Bpc0ZG?=
 =?utf-8?B?dXZJUXlGZGY0Uk9odlJNbURTTDhxdmthNEZaUWM1K216ZVd5dDM5VXZEY3BP?=
 =?utf-8?B?WS90Uk5iQk9tMXl5QXQ1VmdDV3VwbTR3ejlhaEd0dUl5NDUySzNVeTJKOHph?=
 =?utf-8?B?WlNKbThGYm1zSlpIWW9hZ2x1VmJobGpIUW5Kc0RVZEg0SlMrOGFOK3pxVk9s?=
 =?utf-8?B?QWZCMVZPdzRGSi9VSE9YZlp4KzdMSnc2TmVuWUxycXMrYjdRWEQwdkQzem0x?=
 =?utf-8?B?RHFrRTFKbFhlNGR6YkE0TVRYeWdrSHcvUGRLZ1NCK1lqWTZzRmRKekorQlRQ?=
 =?utf-8?B?Q0xZdEc1eTZHZ01YRkN4aHhqcjdYMVl3M0dzbTA1M3Ayck55dnZ2TGlMZ1Vx?=
 =?utf-8?B?c1pFZjVEV2hBeTV0R2JTSmM2S3gwRnhBbkdiNmIvc1VSRU9CRXRKVElvaDVp?=
 =?utf-8?B?bVlyTW9kdllnOG1iWTVPUHdZbld0bDFaamdMNml1OHJxQVJlajJsQlpKa2NG?=
 =?utf-8?B?SXlXNUNXUTNhNjAzeUhDTHFXUTg5b1JMSjhkd29iTEN2bHhBUENEY2xCMS9B?=
 =?utf-8?B?VjVpcXlVSTJKVlNkL0hFSzVGaVJZUW1rMEhhTWloN0s2bHlHczQxbVFObEpj?=
 =?utf-8?B?UjhuRjd4QS8zRkM5U1JpdDlTbURlMTZVTnRoS0ZVYlhRYmxkdG9XQS9zRVRT?=
 =?utf-8?B?V3p2VjRaQkUzRVprQzJXMXUrd2hVVG5jaVAxQ3JQL2JaYk0zZUtXUE5ZOHJ2?=
 =?utf-8?B?em1TeElDTUYvUzRYMkhUT2hBZk5nSW80c0gybjJhMEFRYU1vbHRvTVlyQW1i?=
 =?utf-8?B?MGc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <204C82B55C8FE94FA7CD610F5E144B4D@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	afr2RYeNfTlaU6yXe4mxifqTEv04ldfSLUF5j1zJjYoXgexY5rlbgxZ6RU75dt3IQEcN8Od0wBOTyPSe/LpROckDrJjpp1d8nuxqKfrks4HYoa5ZK96WQpWOcEWE1cx0d7cKEXYsnGyrN+6XVz71vIqWPvK4yCqj6MjbF3PMRm1fMBkZdg7swPNff5iYsE0svok91TyNZlRPywh/OMzg1XotLlpuTv2fuuJtozedThscfl729XtgJMRs6X3Y6c2NJLJ0dGShi9ooOL1QwRnNCsEY8Dyc+gTwopdSBUizRC4l3YuJ0O6a6MAWxa4nSB3DIpZU6H3P2Pel8YZE8akWQUMJgkrrevj1x0Xq5gJ3degBH5UghTpb0q1C3rWh2VqDhcVSXaXb1/yTcUXePFxLWbSpUM0gYuGWfJe2mmYYJNXs88bSwdLXvvWFGWWxzeNjXZOgIYYUd8ejsD6Lo5Bz+PbO4bu0D1DOMS2u05Jw/bnx9iH3P0EOM+1clrdIsyi8ei812H5PplXSpx5JhqZIk57i0U91swaV7wZq9tqISmbAp3wagDQEhP/M/fkKe2xiZgR6e6f4HvcfCPd8rSVtzDzo8+oKZhIdJPHruys6Z0KIjXLwSznn4eNUiuuCnrKi
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5bd98abe-ed0c-421f-3d1f-08dcff090541
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Nov 2024 08:48:58.7493
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FwVSOlSZqHMQ77BfodIDq65legJkLeIQLmo+iz6bqsmTFl78efNDDKMb1ixoeyLjBCt0eCKxc8QP+MH/4QiRVdtG8WZUDFRyjwl/O1n6GbM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR04MB8230

TG9va3MgZ29vZCwNClJldmlld2VkLWJ5OiBKb2hhbm5lcyBUaHVtc2hpcm4gPGpvaGFubmVzLnRo
dW1zaGlybkB3ZGMuY29tPg0KZm9yIHRoZSBzZXJpZXMNCg==
