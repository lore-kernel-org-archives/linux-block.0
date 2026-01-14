Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B149B355811
	for <linux-block@vger.kernel.org>; Wed, 14 Jan 2026 11:32:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.141.245
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768390377; cv=fail; b=I9sHm6+UoBUNPieLntD9nyCbqISP49FdSbpYoT0Y80Fl41yfs/BDptOnpthsSl8/XscuVhCdnrdSYQCz2ZOhnkfhnjOBhHlAgwPM7Uw8CPPmlaeG6YliSDlbQJuhmrOORMx3A6ihbgaz3B+UkmVjvuYdPTi76HE53VXpEWmxoB4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768390377; c=relaxed/simple;
	bh=ZEUZXezoy14i4G4aH33Lo61kykWBVbuRL19ZjZIoG/0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=XFlOpFBTYiiOwfPdMJFruW212brEh/Qje2IpGfXYpwj8b9xWGkmD5QVXtkKcLl7T0VPBGpzcH3YoHnaYJWjme8grrhwZj6ye3OF2exKWPomRZpzowuvG0BMtsWAYF9Oz9n/mdb0gwy3a+L4CsSd+26nzPyf9aMGat2ElUlt4O20=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=SQ9M089j; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=xspGvOPZ; arc=fail smtp.client-ip=68.232.141.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="SQ9M089j";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="xspGvOPZ"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1768390368; x=1799926368;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=ZEUZXezoy14i4G4aH33Lo61kykWBVbuRL19ZjZIoG/0=;
  b=SQ9M089jPbwXg8xEWWGlLyb2inWeRMCt5dvZGo4vfgq1MHY1IvZ0prI6
   7iHerTQw6fFGg/AA2UBLKE4zyjKVyymTte1zZJa8PvSd4IzjoD+I0MCeh
   0ry7vbq+v/9V8oPHN3FPldTX6aTsMYd6Rap7SIWb1KEKTMDNxZekKbkbU
   bMHG/IUpu5IO8TaQ/o242qXqLr819SpeLKqVYJRHtvZ6yaTQVEkMnjHl/
   Xd+oqmXN5tn+rttx0U5FQB98yLjGEedHTlXaTe9DU/k3+sJzeYh7Yq4mS
   uTNICee9pngLhavY1paNvnj4az4BU0cBLoEpEVYp7FRiWqH7diObWYTqM
   A==;
X-CSE-ConnectionGUID: LOnZP+4rT2y935uiOz4Ksg==
X-CSE-MsgGUID: LeFOwcgVQWiiasg1IFGIbA==
X-IronPort-AV: E=Sophos;i="6.21,225,1763395200"; 
   d="scan'208";a="138763947"
Received: from mail-centralusazon11010013.outbound.protection.outlook.com (HELO DM1PR04CU001.outbound.protection.outlook.com) ([52.101.61.13])
  by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 14 Jan 2026 19:31:39 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=acYR3YhV0bGC4ANYaVVfL1xtt78zCex0FtSZbvqulKY4yz6R0RAld/1ybffDPRKjJb1W/zBdN5AzV+QD39qoUylPtgS5I5Rblb7YsmnWJOiZ13GJBh63+etWijVS60KjFTFpqwcmyYbDkvnpvLWdr8mgnT5ioXUVIKbXdBelJSTjlhSN6AMiMKuvgx8WG7UT+KwYNpFwlzalfANq4rY2Bue/j0mx7BYwe5vosCRYqOSVyp4IIVnhg8/+vj6B/WgYYLa/lVpKBdDSNakE5mMfP7595Ec9/Ke2AcMOdoi/OYVnP+/q2meiweGx02SLrsml0XVuUJfXMZDZdZwrsJejIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZEUZXezoy14i4G4aH33Lo61kykWBVbuRL19ZjZIoG/0=;
 b=rBXUo1eizC8HThpzDD3KiQ584B15FH73BT3kG5PeskCpZasJVWcN9BONGQ/+HeiOd9xAm7D7fhz4n2mK8Py2PxxTlJI3Q0CcuCqho0IkCEd0QpT+OiursUEqjt3wATIrnTY/gA3QyCpG8R96MJSSG3eU0qT+nvrgUWAcCL7fl4taAEsh/08TwwZEN2OnriR1PQmqYsJRFLZwUXXl2dUNac+6RjgRu7DtDrjxuJ7D+2jFeOWxQ0S0cHaSPDgn0nvh8HKly5LtqP1b0bGHNqBEt/3Vtp4h2lxFWkDe2Ic2jIeeYFR/h2oszi6K1RpDDcPBdI7ydYGb7D9ZwOGlD5vEDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZEUZXezoy14i4G4aH33Lo61kykWBVbuRL19ZjZIoG/0=;
 b=xspGvOPZrfZo8dhPzsD8EhYbfpgY5HRC+II3CjRJXomavND0kubpSQ6RVc8hLZwXauNzSFjYu2xnAH88cmIK5RXQ8B0dwhjxRfqZlGNNbDKPw3znqPrPDpJaZSD0dRP8lEwYtQgVIyAwXNWL0AsWAD9OjfYZj5Mr2EMHQW49dys=
Received: from LV8PR04MB8984.namprd04.prod.outlook.com (2603:10b6:408:18b::13)
 by PH0PR04MB8227.namprd04.prod.outlook.com (2603:10b6:510:106::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.5; Wed, 14 Jan
 2026 11:31:37 +0000
Received: from LV8PR04MB8984.namprd04.prod.outlook.com
 ([fe80::9ba6:7273:90bc:53a8]) by LV8PR04MB8984.namprd04.prod.outlook.com
 ([fe80::9ba6:7273:90bc:53a8%5]) with mapi id 15.20.9499.004; Wed, 14 Jan 2026
 11:31:37 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: Nilay Shroff <nilay@linux.ibm.com>, "linux-block@vger.kernel.org"
	<linux-block@vger.kernel.org>
CC: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>, "yi.zhang@redhat.com"
	<yi.zhang@redhat.com>, "gjoyce@ibm.com" <gjoyce@ibm.com>
Subject: Re: [PATCH blktests] check: add kmemleak support to blktests
Thread-Topic: [PATCH blktests] check: add kmemleak support to blktests
Thread-Index: AQHchHLcKYnG+16ShE6y9HHMNX7vybVRickA
Date: Wed, 14 Jan 2026 11:31:37 +0000
Message-ID: <017912b6-48af-49fd-81d4-5449b3ac1c4d@wdc.com>
References: <20260113095134.1818646-1-nilay@linux.ibm.com>
In-Reply-To: <20260113095134.1818646-1-nilay@linux.ibm.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV8PR04MB8984:EE_|PH0PR04MB8227:EE_
x-ms-office365-filtering-correlation-id: cd93a3c5-7689-467e-1a1d-08de53607ab0
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|10070799003|1800799024|366016|19092799006|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?QlNFNDdJend4UHVEU2IrWldIZkUwREEwSVp5bWptdUN0UElxdWwzSFRJRGEz?=
 =?utf-8?B?ZFZZUGtkZXdCUnhNdkkxU080Sm4zRlpzUStoTU1ScGhnejRScG9hai9Uazg0?=
 =?utf-8?B?U0JZclJzVGlQNnNQYTR2TXNnYmUyQ2tDQXpJbE9jRUxLSmZnd04vRnNiR3Qr?=
 =?utf-8?B?VmVXODdsZEhQdnZualphdG5ub05ncjNQb2JWWUJqMFJvN2VHQVlsemRCZVgy?=
 =?utf-8?B?Z3RkN2M4V1pRbTFiNm03emUzNzdPZWNBSVBnMmdmQlRaR0lWd1ZWejZJMjUy?=
 =?utf-8?B?ZXBxZWZPekxHOFFhTElPOUc3SllhRjFEcUtnRm5Gek9xdyswcnRsOFZ6VUts?=
 =?utf-8?B?cHliSno4dHB0ZGRLYjlJUGJPMWNqc3FPQXVUVjVvK3JKS2NDQW1PYU1JRWVv?=
 =?utf-8?B?c0wxcC9pYUZHZ0cyOHlKc3dIdVZ3TGM1SVZneExvb2JwV2hodzFBT0pkdGxx?=
 =?utf-8?B?cHV5djRKNTNLeU9XV2M0d3FTV1E1MGtueFhOb1NJOE1kSENneE9rcGgzemo4?=
 =?utf-8?B?YmtqbW1ET2taZkp1cE9LZG9OeXVhNkNnL01lWm1mUGFvUm9nZDBlUEZMdWNu?=
 =?utf-8?B?Sm9rWDlkcGsrQUt6Q1NFZmxjcFFheElSOUx2MlpENVcwTmw5U0srczZ2MzdP?=
 =?utf-8?B?dERNdUFIUVNyeWRWdS90S0dFMDZxd2lta3JFTDE3Y3JoOFBzbk53UG5oNTBI?=
 =?utf-8?B?ZUt5ZVpaUkxNWGU1NjAyVG1tZlZYR3VTQ01GL09VaGRUekVVUk42RDRhM2o2?=
 =?utf-8?B?ei9PTHViWCs1TkYrT1N0RkNmN3kxbS9WZWo3T2ZObnRvT09GbUlwN2JxKzFh?=
 =?utf-8?B?YUNzUW5sSUV2SHRzMjJPbE9PQ0pKN29aMmdidktLLy9KQXA1ZHUwOFhFakl6?=
 =?utf-8?B?b0NCR1UxV2tXem1CU0JDSzFXSy9STHRjNitJSTlzK2Q1WCtuTkdLVlZUVmNF?=
 =?utf-8?B?VjZXRVA4K1pVV0VmLzBwc1JEMnYxSVdsKy9kaHJiVXB4eUJvVWRHTWZmTkEx?=
 =?utf-8?B?MXA5Y2Z1aG1LRGVJTllIVWJMNDQ2a2ZpUzFvZm1YQys2QmJIL2xSUk43Nmc4?=
 =?utf-8?B?NnkvM2ZqVkR0QWhpT3NGWUVCcHMyQW9QMnR5cmxQSzc2d2NtaGo4eGszdUVD?=
 =?utf-8?B?d0lKL2pVKzNZbXBjU2JXbVNvVkI2WmJJTVZTZXBJM3Q1b2VqQXlhSnlYZ2wr?=
 =?utf-8?B?Mk5CUldLMlNETmpvNFdYYUJHRjJMSkQrVllZTXBDRHhUcEpsNDZqWWJpWitl?=
 =?utf-8?B?bC91ajZsaXBSN1BwZVdaN0FOTnhGMWUrNlpRN1pveGlBY0pJNG1kbnFQVUpn?=
 =?utf-8?B?MFppVTh4ZjdJR1JCRlR2V0JyS0oyVlFFbHBuMTBueXBQOEV4UEZOUGxvNkpX?=
 =?utf-8?B?ektNdjlGNEFOLzhLTmhVOUlycVFVdGs1L0tGYWN3NzJRZ1VkYlM5bkplNTZ4?=
 =?utf-8?B?NWlHWGRIdEdRck5BbE5hamtNV240Q3RSL1dpZHpwNG10WER2NzRNZUhTSDRj?=
 =?utf-8?B?K1dtOC9XN1QzYkxlSWZVU2E2WmY4Q2hDQ051RGd1NkVzS2RzZWl2SlZYNlFP?=
 =?utf-8?B?THhEV1R3elZ0SHRBRXNRaWdXK25zRGpHRGtnaXEwREJBVkduUkY4cnhUdWJ4?=
 =?utf-8?B?VmVFaXlBV2tNQVVYMzA5MjgzQkJyU3c4YUo2UWtHaTR1RXV5M0NlbDJaZnJX?=
 =?utf-8?B?cG9mVmxDczlpUUNnaUVtdmhMdXFFNGFKcGc5aFptN0VDUHVlNFg2SitGTG80?=
 =?utf-8?B?SnFJNXg5d01YZUF2WFBPWVVYSitmS2I1UlZJQkZLKy9QSWRQaHl1RnNhdk5a?=
 =?utf-8?B?L2gzdjhUYjBJR3ZFQ2s1azUyTEwxcmJzUE52ZFNaUTdYTWtXYWFhVHRpV2Jv?=
 =?utf-8?B?ZFdGRWp3K24zMzJjeTA4d3RMM05ndmd2d29JM0psUk5PTEp3ZHozazFWY3kw?=
 =?utf-8?B?SzFNZ01XS3hrNXdlS2xFR2lZMTNSVGx0OEJsNzhXT0hFM0VIMlpTd3FLMXpX?=
 =?utf-8?B?aCtJV1EyZlJETnQrS2tKMm9oZHZOOTVhQjNUVmJ5SHd0QnVFK2JlWlpia1Ex?=
 =?utf-8?B?RmJqTzgybThaZmF6ckZwRVNPd1NHeEY3Z1dXR1A1TmJWOUNKYVBjUktqRld1?=
 =?utf-8?B?OExUcE1iL2lBdERCWmMrcStrVENDbG9OT0t0Y2hybStmZTBYSHlRSWNpSHJu?=
 =?utf-8?Q?Rzu/tY5h3qgFwOI+z9gHQYc=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR04MB8984.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(10070799003)(1800799024)(366016)(19092799006)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?WHVGWmt4UGFtWFlwRnB6V1l6dTBGK00waW1kNFF3c0xSVFIwMTdJWDdPNUZm?=
 =?utf-8?B?T29Xc1l6SmVOQ0o0YmUrYng5QmsxYmhiblAzbVBoTnhNTXRBMFFhMkh4V0RT?=
 =?utf-8?B?TmpLeFJwZHdqYzVNemR4dUtna1c4SlBKVTF4OVNSZE8yNXdpck43b1dUMWNp?=
 =?utf-8?B?UGlvRTFkRVBKUmRHRWRmcXlUbTBEaHl3aW01K05xeUdlbFJzWjdOSHkwanIr?=
 =?utf-8?B?QVFaMjY5SzgyZEFVTjdvZ0Fkb2sxa3haZVM4cjU5QnZ6ZDdPODFxcENWa0dD?=
 =?utf-8?B?QXpRcW1qREtkN0gza2F2cSsxVDl2eDRhNEsvRkZWUC81SkNXRVNyeHk2NjhI?=
 =?utf-8?B?SkVHaDBMVGdCTUwzU2Vpa0hUUnU5TGpsa2laOFFhMTZwLzZnSE9LSFUxZ1p1?=
 =?utf-8?B?YVJ0ekVGc0VrbGJLSVZuc0RYdFM0YkJ5L3lkYUxuZVBVVjByT281Z2duSUNh?=
 =?utf-8?B?YjNQNmczbTUxS2h0RUloOGg5OEhZdDdxUjlsQVhNN0cwbE9LK3hyVFZ5bzlx?=
 =?utf-8?B?Vk1zQnpGNzE5Zkc5NFkrWXYra05iTmE4c21MdS85T1NYcktzTGZPWGZXakxB?=
 =?utf-8?B?Z1JaYkdxZ09xZEI0TnQyeHhSRWtWQlNmQXUyL1YyMEJyMjV6YVQ2bFJTU2k0?=
 =?utf-8?B?UjkvaDNvR2FadVM0cFJJaEdGcDdBL0NoK2U3cStGaTYxL08rd2N1SWlMMWVm?=
 =?utf-8?B?MUdxTDU5SitQdzNkbkpPT1JOaEU5SkYxK29ORGl0b21LRzRQQ0RON2NqbUFD?=
 =?utf-8?B?amJUbTZkYnZRcUoxSFJYdmFrRDV4V09qenF3QzFaWTRYaHNiMUlzTEk5VEx5?=
 =?utf-8?B?NHpFYTYyMEtra1VUK2hHbEppdjNrSFFjNVROa2ZKeSsyM0xtL1lVbS9LU3pP?=
 =?utf-8?B?RHBLbDYrRkxKQkFMYzhKQ1EwK051bVJ1WFp4dVZRMDZROVVPWU5MQ2Y2dGNr?=
 =?utf-8?B?b3h6cGVycjJFdWwwZnp2eWgzQlROZURVeW5VNE8yaEltUTg3OXRITy9zT0Qy?=
 =?utf-8?B?M29DeWVlNzNCWVVPYXl2N1VMNjZPbEhoTE4rRkFvaWUvV0tweFdpSDl4VTJx?=
 =?utf-8?B?cnlLV0tpeGFIQlYxYXIrOEZZdGI2NmJMSmJENTJQUUlQemZWT1lNeTE1MTNx?=
 =?utf-8?B?WFc5T3ZQRGZteUJFRFhLM25LZFhVVWExdDI5clVZYW92ejFDYWpwYXFYaGd6?=
 =?utf-8?B?MW5GQ3gxWTVESjA0VWJPSlNhR1JCb2YwMUJlM3ZWdGthL1g0eHNEZEVuMWxm?=
 =?utf-8?B?dlpyUkswRG91M0o2cmNKamtvWWc2VytCdGdKOHlnQnlCa0JxVzhFNXBQL2h0?=
 =?utf-8?B?bEJmOFBaNzZGSmJ6TFUreWNRbmRQVG82ZDdKb1hleWR6RXBRZzBvcEFmQ1dT?=
 =?utf-8?B?K3ZmTzVkOGtRVmQrRmhDREJmcThialBUdVUxSFdwdU82N2dxM3JidGQ1UGpq?=
 =?utf-8?B?d0NOenh0SDBsbTJHZXhGQVdXQ1NleGI4dFRtY2k3MU1tMGJ4YjcrVjJRMUhr?=
 =?utf-8?B?VW9uOVFKTUNXTnpjV2swOHpvSDY5bVZlcTM0WVkxZVBHV1Jyamtab0JpUVR0?=
 =?utf-8?B?aVdldnVmRTFYVEI1eHpFZVI1N3Z5MXVzK2tQMGFMRFY1RUZTbFByRHRIamR6?=
 =?utf-8?B?dVNDS3ZzdldXMDA5WWFreGM0eitKRlhENThuSG84czJKMHdINjJob0JDZ05H?=
 =?utf-8?B?clI0RlRHcDlZRUFsQnlCVmtiOFphdHl1V0tQaStTY1dVT1ZXVTZKZUY5MTJ4?=
 =?utf-8?B?enNoWllPYWFkWlZLbnlibHN2Tmhya2tGZjYzSzEyN2szQWpGS1pndTU1MDIy?=
 =?utf-8?B?SjdNb1l5Q2hVdFdRTlhhM0NreFFSTVpuVjFHbjhpNGFUa1hjQkhEVWI0ZmRi?=
 =?utf-8?B?ODhCNHZZN0M5Vkh5T1NvQS8zMDRRNGhoa1NZU09pQ1dsSFY4WE5oTmEwSlQ2?=
 =?utf-8?B?T21ET2dLWXJHWXA0SjMycmlOVmZCa0lSYXk5WEh3UnAxV09TcXRvemxyeE5R?=
 =?utf-8?B?NURoVTAxTXM5UW9xaDFjRFVkbFNET1BLUFdpNTdFOWR2cEw3ZW51WUhQcDNm?=
 =?utf-8?B?K1M3NnVzSlk0Q09MV0FGQXRGdHNkWTZKQmUvTmtnNGplb1dva01aL2taVFBq?=
 =?utf-8?B?ZWM2czR4cTNMZDI5SjFkMXlrV3JWa1pkdHNXdVpzUHl4MmZMaUgrZ1puRURO?=
 =?utf-8?B?WCtuRnZibnlLbUpjc2Q2Rmkrb1BEOVVwYmt0cTNhUjVRRTdRYkM5Rk5sOGdq?=
 =?utf-8?B?TkJkSStoZXlHd3hPMlVXSmJmYWR1b1FYcFhodytzT1BSd2oydGhuT3VlYjVE?=
 =?utf-8?B?cVJ4UXJMdlpJQWpxeFo1b3RSdXdQeUxOZVNIemFMcFVYMHFVOWZxZURlb09V?=
 =?utf-8?Q?tSpN89g8dsLxtPshbn7APhMxUjpXFbjipj8CSLbsAwNdV?=
x-ms-exchange-antispam-messagedata-1: h7SEsHtfsVd9iu+1RE+nqrDZ2w6pvWOemVU=
Content-Type: text/plain; charset="utf-8"
Content-ID: <89CCBE23C628A943AEB5D8339D165DCE@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	EHT86rqZe2ACKIroXlIbb7RHELIsbhAjAGQekqFH8o2CYdW8YIhAAjDOKCvvFBgYVTCucJ166hhTZWaofeQ2M8zbHkA1MCQ5LbCD6vKxD7q6hguMrPcZqWAEtbNaG9nVkmiHi68oeXN1Chts+hcp9ofNOO5XYvpTcm04w4aZA66dyANdYA56jTZ2P95oWC5xCMtEuGiz2eqW1JJFRviD5EV2H+id7oMbhjCenYBPeet/Fk4l4xl0AGuKdVjfGW1/diCUupPqR8kCSwyNsEa3hJSoppiHZiNofLa8NTaa4DwCyMdtuAOGlteSrGafBb1lP5ZvTQmgAbflgVG/X7w0wsKJZWqdjr5uLWd7dOTu8FYwk8bQuQL0kQ8xnJeXrCkDgmoWuJK1woza05HppZL1aAlV5JLcKhhPxQZO1VPqJYRkxDvkxWYc2Ad5s/Fek/+FFlqAy7GZxitaP7LdDiFsHEK2Nr67wXu44nFkyCJ4rg1x2qDLnAkbNrAdCZ787fjt/tdyc8MBsbI/N9XcxbxxhYTnBWmfjT5y6SS+jlJbPcwM3xK0/8osRPx7R6xxfVML6HOALhPTxqqmwolo4UMxp/P5y69htoyhkbLaIuj201zjiYFQNGbOKNZcEEcmYPQ8
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV8PR04MB8984.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cd93a3c5-7689-467e-1a1d-08de53607ab0
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jan 2026 11:31:37.3080
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Dxhpc3wJ1KwwrgILiARmUC83FKoa0HE4dyWL8US1/shfZhUNudsXXtyLi7nVyP05cteu9va67Hs1NmVpik+L3GQXzKTBt/OhWSnUQO/nuZE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR04MB8227

TG9va3MgZ29vZCB0byBtZSwNCg0KUmV2aWV3ZWQtYnk6IEpvaGFubmVzIFRodW1zaGlybiA8am9o
YW5uZXMudGh1bXNoaXJuQHdkYy5jb20+DQoNCg==
