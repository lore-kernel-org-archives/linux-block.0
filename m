Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4844533C9
	for <linux-block@vger.kernel.org>; Mon, 27 Jan 2025 09:20:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.143.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737969655; cv=fail; b=QvwCsYE5WFXXP2OvfIczMqihiLcNWydzbFRP+L4Ezt7SuqPMWYAbJ/YXa42e6PgU6o/xEmQaOgsoaNtmP6BjQ0Kf5E5Ye+avBII8Py18hjgDk6VKexw6hg7LHp01hXPkrkFzLv1fSu4/cYfusmMV+JW0eExFwV5ug74hMnCChrY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737969655; c=relaxed/simple;
	bh=tsSZFGldNvIteEtxniA/VeLPPTSnQsRjbi2hNzmDsJE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=NQYo2ZcLYPlxlGpcbsbZreACnNNsE7ixn0UACmQS3eTfXwgBpF4GQ7/KcCpDuuq8mOOw5dfMZ3eqXH3zahfkUYPAq1iv0s9Sf4dVDUsX6SygUHeALhe/RCG0HVOopu+V7TclEVdvnQ2orgd/SpgqseU7NHbjIlvK9Bao0CXjBQg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=pIjlOe4K; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=SD2EvG5Q; arc=fail smtp.client-ip=68.232.143.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="pIjlOe4K";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="SD2EvG5Q"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1737969653; x=1769505653;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=tsSZFGldNvIteEtxniA/VeLPPTSnQsRjbi2hNzmDsJE=;
  b=pIjlOe4KUyvq6qqEuEw69BtjtcCA2x1DRuN3MxxNFR6PfIbouoZDCzrX
   3BDHK1aOprol7BtGKv5jzR2ak53HDl36WH/Y1YxQQAdMc7kF59qvmOg3J
   Zu90fdLEwfgyQTblgxXcWXNUxtFmX6I5y2a6wXfqArMcDuzBPtHCpTShy
   IWMFMq6ub+dSMg786NkCfYK5xUsKQHgX6EiFwvhN1FdoElqr359mUbSgc
   h9538fKp7/Mr3+2gAwK0mQrcAk6T9g6ibN2vTHBRK5cTAOOaNDz/t/rJA
   tH0FbodfBMJQRtrPIvnpVjPPa9rbxIH9zJnFuOR9iY606+EuvhG69YDXy
   g==;
X-CSE-ConnectionGUID: /aDKG+MWSqiUk6FVi3RYaw==
X-CSE-MsgGUID: An3KmcGvRGu56QuVLqfFlA==
X-IronPort-AV: E=Sophos;i="6.13,237,1732550400"; 
   d="scan'208";a="37413505"
Received: from mail-southcentralusazlp17011028.outbound.protection.outlook.com (HELO SA9PR02CU001.outbound.protection.outlook.com) ([40.93.14.28])
  by ob1.hgst.iphmx.com with ESMTP; 27 Jan 2025 17:20:45 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zBbREWnsY8hCyTBQNy7wAOLRRxyYMXQ+vY7LMXc+T0+CSmRNgWHTrO27gLHOizFrVxnnZBv+GfdIhTLRFauelbjI/C0enjTK++/Ya0XFU/tbXnmhQQNxX2yDdb/f2v7H29+CkgWXDZNT7okh+RLASXGg4vTjc+bMVb4DcjKMhizcz7YWZWKYYT6g9Yxt8jxaxXX3EoiuuE7ImXmvS7Gzaa7ZSNY5/HThXHy9RcsLhtLM1rvtUcFdpxi2/EtE+qPM9OD89XTif2YXaONnGBEk0/7A/xHtICE3AcNfdGsZoqkP3O+en6EEl2/9g5fCu7Y1gZh2q9TKz8SLGENTlOf+ZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tsSZFGldNvIteEtxniA/VeLPPTSnQsRjbi2hNzmDsJE=;
 b=QmUtYfDG90RAulZEkn/qBnygagu5KJegoVu2R4mo6ORXkULrP9U/UdVwtP5ETYnKuVDHcKHnPRJ9l9VNar08RCEwI7hjtfMqUqGmDFTn2lXpiQEM5y7dgObe0p+a4Jxw5rfByKsyNFr/VJ6hRZau/0PeRIbuxGvswty5XT9pjPIYVpC6M+xuws098hWKU+9BbTgWaWElHuD4CWcABOm+QqojqR/jmrdK3+i+RbFTj1KWXVr9PuwpXMUKgvj7Xl0V3jYFf+6LXY4UT2iacO0AtHx2pW7O1yYz9LU9AZc8sIHlNHyulvmK6k+4zTDP2dRVmD+mSJro18lt5BADfpuJZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tsSZFGldNvIteEtxniA/VeLPPTSnQsRjbi2hNzmDsJE=;
 b=SD2EvG5QEJk99AdzMrDBsBrKE/iZCtBxNc3MLbsB7tIhSoYIJ5+xduptkSaVrXB4rHnmfAWlpMadul81sciLNgvNmGJJWhcGrQH/1LRvRPwZF5fB/2SVGCRgKk35xZD/uUxX8q08U9j2ePejeKnWZr11/JXqaFKoR7Hy8qDI1AE=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by SJ0PR04MB8327.namprd04.prod.outlook.com (2603:10b6:a03:3de::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8377.16; Mon, 27 Jan
 2025 09:20:43 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969%5]) with mapi id 15.20.8377.009; Mon, 27 Jan 2025
 09:20:43 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>, Jens Axboe
	<axboe@kernel.dk>
CC: Damien Le Moal <dlemoal@kernel.org>, Bart Van Assche <bvanassche@acm.org>
Subject: Re: [PATCH v5 0/5] null_blk: improve write failure simulation
Thread-Topic: [PATCH v5 0/5] null_blk: improve write failure simulation
Thread-Index: AQHbbsiOfCvDRUb4LUOaIxPJpqyFxrMqW+gA
Date: Mon, 27 Jan 2025 09:20:43 +0000
Message-ID: <142ca67a-13d5-40ad-856b-9228026eb6d4@wdc.com>
References: <20250125012908.1259887-1-shinichiro.kawasaki@wdc.com>
In-Reply-To: <20250125012908.1259887-1-shinichiro.kawasaki@wdc.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|SJ0PR04MB8327:EE_
x-ms-office365-filtering-correlation-id: 61ae0d24-fb01-4c70-1598-08dd3eb3e025
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|1800799024|10070799003|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?Zm1tZEI2bDEyVnExc25FRFJjeDkrLzZJamIxd2pmRlRXNmt0V0ZNLzJ1bk5p?=
 =?utf-8?B?U2FDMXpqc1BaMUQ2d004dERqVVM4UVlIaFRhazJHOWc5c0ZBT05BVGp2czFZ?=
 =?utf-8?B?QW1jRjArZUNvNW9XTkdTZCt1TnlTK1BxTTNkL2kydFBSSTJXekNwWk1PeGhu?=
 =?utf-8?B?VGRGbmhORFFRV1dLSWRRL25NVmlwY0NHZWpTeXd0UXdYTk1IUHpMTy94b3Nu?=
 =?utf-8?B?c2lNZkVsdzhudXNmcEd3WkpZenlLUjlIbGZxei9neFBqa25CTU1OUkNuMEpa?=
 =?utf-8?B?ODNtT0JQR0lvRFE4dDJRSWJtTTNlY2hVRkwvWjJGTGdydzRFUFUvMTVCYU90?=
 =?utf-8?B?cFVLZDkvcHd6YUNmbHNhSHR2MWdDOWMzV3ByQUVyZDBYaDcxOGtldjFqRHlO?=
 =?utf-8?B?RHJRL0ZHekNyZU1Xd3lLcSsvMlhjdXlaS0NwTjZ4VThmRlZsZEpwMlNWOVlM?=
 =?utf-8?B?a0NUc1hxSkdTNlQ3MGpvclpUSE1BV1NaZkdnbktnektaMnd6TEoyb2NMT1Fu?=
 =?utf-8?B?S0dYd2lDVmwxMVhMRmtoWmJHVXR3WVdlaHlpWHBUZHVyaDhDRXZiUm9OcXI4?=
 =?utf-8?B?SmxZUW9NNEROV00veThZTDR3VmxTNng2K2QyY3NMY1NXOWxBRElmTkU4Yytk?=
 =?utf-8?B?MXdEUDZicEpBaGsyTW10d2N2eWlaSm9WQ1NSM21LNkQ4Z3JYRlZCS2pWcXdC?=
 =?utf-8?B?UkdmRzd0QTlmMVJ6dWcybmpHbEZHOWtTZzhoSjRyYml1TFpTUzZDYWpxOENO?=
 =?utf-8?B?QWlHci9wa2xBUmNhaGJNZVBWN2pWaTRQeEQ2aWpwWkthY0xZRnMwdEc1R2g4?=
 =?utf-8?B?Vm8raFUrcXZ3aEtPdytUbWExeVg1WjlydjNQR2c0dkhlaktGQUUrUDF6SXlq?=
 =?utf-8?B?dGJHdHliTHhlY2hVdTZ0ajB5N2ZUaDFlNm5uaDhhQS9XYXIrYmpEN3FJVENJ?=
 =?utf-8?B?VEd5UXdsS1hyUXVhbldZYXFSUm9pVmc5N0oxNkZxdEZyUnhBQ1VyYjZQa1Rj?=
 =?utf-8?B?RVJoV2NWT0pSQ0JxVlJ4a3pkT0svT2VTcTFiR0JmcmtuNStyUkJMVGQwcjVa?=
 =?utf-8?B?Y0xBczV0YmdIMzhSM0kvejF1OFJjcVVrcG9nLzNhTUphcFpFR21uSFlKVmdu?=
 =?utf-8?B?cEF2eU9tM3dmWlBwa3pCN291VUoxL1ZzbjU4YWRKdHdYVFJqWXB2c2g4TWpk?=
 =?utf-8?B?QjYvVnBwaXYxSTlEZU5uNWF3L25LRmZadU5CTHU4YjY1NEttaVNOL2xQSVpR?=
 =?utf-8?B?V2h2b3NxMU5PcFBCSnhjbE9ucE4yTmVWRTc3Yk1VRHB3dTdPczdaaUhHOURR?=
 =?utf-8?B?RHUvc0FZNGEvRTdwRSs5eWFKZFM0aWZ4SXVCSWsxUHUxc0dKNWc0MEJocHpX?=
 =?utf-8?B?U01Rdi9mdDd6SU00VnMzQVRDMXE4enVZNEI3UTl1bHBEaTZKeUNIZWNwZjVI?=
 =?utf-8?B?MzlSVnJ1Qzluc0tndm0vcURWYVVSRVlXWDZqOE9zOUY5b09TVWUvMHN1OWJs?=
 =?utf-8?B?YVNBNkM0VCtrMnlVYVdsa0FrTUplb3d0N3lFZ1ZEUWlnaFRSRWE4TkZGVVZ2?=
 =?utf-8?B?dUFxZWJJdjBpZXRDVjVJMHh6OVR6US9rSmZJWFp0NGZ2Zi8wSURnQnpTaHlM?=
 =?utf-8?B?RTBqWEloMzJuRUlFWGNKbCtqaXRyZ0ljYXlGdjJ1amZ4S3IwSzF0alVxYUxZ?=
 =?utf-8?B?QmVBc0E4M2F0dWhQaTFRdFlrVmpJWXBSZHZWNjA3MGZoUHUvS1pUSHF0ZW54?=
 =?utf-8?B?ZGsrTmRoa2dib210TGdhN0dUekJTQVJKcFNLSXAxc3NiUVNTWkpHZWJlbTNq?=
 =?utf-8?B?VDNkcXAzYzJqd0xRcWNvTmxnd2xYMDQraThVOEZaK2ZEb2F5enc4RXRkL0t5?=
 =?utf-8?B?LytXUHl6TnoxdW5RL0dqcEFDU3pTNE5qRDMrMlFZYXp0Q0lNSUNza0FWYUgz?=
 =?utf-8?Q?8GqQLb/halEJCSLlKMc7jF+L/JEbVD8h?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(10070799003)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?ZjY0MndRVVoraUxidHdwR0hPeTMyS0hDTy84Rm5BK3FnSTdueHNOOVNKcVVr?=
 =?utf-8?B?RGt4V3RYSFZlNGxnMm4xWXY5c1F5Mkkxd2dkUmh6Y2R6VE5Wc1o1b2pvS1dG?=
 =?utf-8?B?aG95Z1NxbXV5aGN5VGxEUUloTnMzcGVsVVltaVBaeGJ6akRCMGNLMnlMU3o0?=
 =?utf-8?B?T0tPS05DVDhZVmxpUVIvRlIzdy9TNldsZXJTeEFQSlpZY2hqbWVJdU1tVzFy?=
 =?utf-8?B?WERFTVgzc0Rjc1N4cXlNU0RDZTErYVFHbmk0WXlJVnBwWkViL01pM0gvcVdR?=
 =?utf-8?B?SE1LTTR2NVNaS0JhNlFUckVROHorWHAxWkI1Unp2WnVyc0YzZUpsNGtKK0w5?=
 =?utf-8?B?anlybnZFdFF1U1prQ212UVlqL0FYSS93UW1zRWRBa3BMYUFtQlFyN1JWaEI0?=
 =?utf-8?B?Q3R0Z3hDSFhLWUJmVUNFVVhFanlmRjhLY2gxQjJMSExMOW4xSHltTDR1SnBE?=
 =?utf-8?B?NzhIb3Y3VG9EblRKMGNGdTlIUGF1WFdyU2JGUTArQlNOQ2tGc2RHYkR5WE1j?=
 =?utf-8?B?ME9VbVMwVW5mTnNEcmRVVUNRTCtFM25tTTJueEljSHR4NkNnR2lNMmU3NEVN?=
 =?utf-8?B?VUYzUm5LeExadnBHTlRtK1FLcWo4Y0hvVWNHaGJrbEFzZlhKWkFUeXdDNVM3?=
 =?utf-8?B?L3F1MzFrckJRSHZMWm9uT2ttcUdWK2I3YjlRK3Q5N0t1QjNYdTl3UXBjSEIx?=
 =?utf-8?B?U05SQ2o2YTFpemtCMklsN2VXVVU2YnV5VS9TdWRPMDFXaGpkbGVYM1ZSbWFD?=
 =?utf-8?B?NENBUHhneXBrUDdHWHlwbXBMQS9ramNoOC9XM1R0Y0Y2cHIxMndzN0FDUTRx?=
 =?utf-8?B?cDBtTFgybzMwZ2lIYUZqc2J6OXBTT0FHbzVWbDEzZ2dGcCt2STNraWd6NzVK?=
 =?utf-8?B?cGxtdUNFc0dDbnBucnp4SWdzVjlOdERXaW5LNGZ2SkU0SXhXWjg5eGV2TkF0?=
 =?utf-8?B?eHY1blZZRVFVN1ZZb0NVQ3dNRXhkQ2RrejNGc1dXZDE4N0d5ZTNNVFJpS2VJ?=
 =?utf-8?B?UlcwcmVDanJGUmVxOXNDekdWNlFzNlhGUnNQems5bDJ2dld4WERhQW1mSkw3?=
 =?utf-8?B?blYycnlaNEgveUM1Y2g4YmJBeHdSclNJRWFDVkdjNjUyZjJVVldoYlBVT1lI?=
 =?utf-8?B?alpTWjBvRERaWHdrSHNFTThVWVhjMnBhZHZXZzhXQW9pdEJoajE4RVZ5bmxw?=
 =?utf-8?B?czk3WkpYZHY5NnVzVlBSZ2w5Ui9KdHVzTHRHcjNqUC9JNks2M3dSdlFPN1hK?=
 =?utf-8?B?Y0hIbWRiQUExU29PQXg2MU54TTNKNmlQTXpkcmVxc0RrdEsvTWxLRy9ZeHRj?=
 =?utf-8?B?R0R1ZjFKSGEyN05wTklpSGdxSEhMVnRjUjhqcjdQcXlKOGY4bXdUSmtRNWdU?=
 =?utf-8?B?bllBMm5SQjZHYUN4R0h6ZjljMUsweDFlQ2pXV2NPUmJZci9ySUZ0REdiTW1z?=
 =?utf-8?B?b2c5SG9TQkg1TTFCcUsvWmFLeDRCK0hMUnFtczRyOUV5eTBZR1ZHL0tpaXFn?=
 =?utf-8?B?OGtUc0t5Nlh4b1pqZEd1MkFyZTgzWDRuS3MreUJ1ckZZMlBtd3pIQ3ZiUXhO?=
 =?utf-8?B?MkJOaVdjT2pqR2lUZnZhUWtlTDhJV0dTWGdhK0NOZjFqMGp6MzJudnI1Nklq?=
 =?utf-8?B?dmJ2enFKbFkzdGQ4WU1nYVlCZkU1Z3R2aDZ3eGNLYzdnQVF6S1ovdjJnMjZm?=
 =?utf-8?B?YXIvRlp0OE1QT1BVVUhLa2tnc0JPZGxXWEpEMEd1aW1Pc2FkMEc0V1FqKzcr?=
 =?utf-8?B?ZXZCYXByS1NzYVVrb0pxaWcyRVBNK2NHUkNaVXcybHM4L3NxL0R1WkRjTURS?=
 =?utf-8?B?WUFwNnpsb28rTmhIRnIxS0s3dFlkMjc1QUdmRkU2Tnl0bzZOaEc5OGlJNDVp?=
 =?utf-8?B?NXZJK1IwNHlhZ2FrSFVpUVVWUlF4THYvTXRtS21BeXVuOEZPZ1RVakxOdTNG?=
 =?utf-8?B?ZFFTb244VG1VYjQwVjJrdVVrazlMWERWa2ltTms0NFVJblVTT2Y3aThWdldZ?=
 =?utf-8?B?M24vQWk1K2dDcmp6Y0dGZ1lGdmNaNWFCMlFOWlNTM3ErL0l6QVZLekowU0pJ?=
 =?utf-8?B?cHUraktScjNMMFB4eVFVWkM3TDBmRElpUjkxVkxGOWFucis3NEI3d0UwT25q?=
 =?utf-8?B?MTBPN3F6ZFhXZ3doOUhHU3BkbTdxbmtXSHl6NmR3WlRXK1lrZ2gwTnZUZnl2?=
 =?utf-8?B?Z3RmMDJxKzRsdHdlZTYzUnVmSG5xRHg5dkxYam5nZHdSVCt0djlmSVB2TXpZ?=
 =?utf-8?B?SFpTbjkzR3hyWWhjQjNNNTBOcUVRPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F23FFDE50E6D6245820B7BA83958577C@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Q6FUP6EY1zLuNFL+d5dy0uwjgwdn/BBX0A2GikIOBSmCP6VZ9U55m5K2oyYNJM/YNKwCSufnHDjj5QQa73t55RRGqjbMRAXsuVFdnBgMs8C9Q8WJgM4PfZt5xmUHcB/w2gO+vB8JYdB8b9O3gRNKHPT1wYJMCLJcO8uqdYOKfWWdw64MX7YI/xhERx/yFW4Pec85KTBdaCOSk3r6UOaXFrb2fCh+xCQDGQq387xJW4E3OY1SNcaUJ2QgvdLwRr2UQpKvCRamWzR9nMX/QYc3ce8vS/NbiWGNAbTmuqdPjXOg86LeukYF5uZGs4dL9X0krIeaf3jpo+PB0FZTrdWmWxVd8830xZm6fILoz2MTqjhwo++F0zZhkVIvRaYJQ7lRM1xViVeCUR94J/nGaO1wEjzQgNXX12+z/2ibI+J9Q+BkuIa8/QrxNWTbJSTmDbY1rwTewYJhJ+oILHQKuq50iNxbLT6YT6QLZte9GK+B44Yieuf3P7fntCWMjmNqQV0LbZ0N6u1D5U4NLdQnwZL0yyqJa4vV1ur4TzIFVk5KTAeLMxaoDYNwwUawmCN4+9uImDs0K/flx6otMYFrwdbFs1Ihw9T/1iby2mK2E7hLbM4ojZvgy3bK6C1yDGCxzAkW
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 61ae0d24-fb01-4c70-1598-08dd3eb3e025
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jan 2025 09:20:43.6869
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Q3j//VxseFzG9C1hD1Soj7nFLpNaXw8EMRNdGVOSBkxBASVm0l4VjWaiO/DWngJjGRjRtC6cgg90JFZn6rPPQSjIC2Qj+4xtEVRrD1kOfIY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR04MB8327

T24gMjUuMDEuMjUgMDI6MjksIFNoaW4naWNoaXJvIEthd2FzYWtpIHdyb3RlOg0KPiBDdXJyZW50
bHksIG51bGxfYmxrIGhhcyAnYmFkYmxvY2tzJyBwYXJhbWV0ZXIgdG8gc2ltdWxhdGUgSU8gZmFp
bHVyZXMNCj4gZm9yIGJyb2tlbiBibG9ja3MuIFRoaXMgaGVscHMgY2hlY2tpbmcgaWYgdXNlcmxh
bmQgdG9vbHMgY2FuIGhhbmRsZSBJTw0KPiBmYWlsdXJlcy4gSG93ZXZlciwgdGhpcyBiYWRibG9j
a3MgZmVhdHVyZSBoYXMgdHdvIGRpZmZlcmVuY2VzIGZyb20gdGhlDQo+IElPIGZhaWx1cmVzIG9u
IHJlYWwgc3RvcmFnZSBkZXZpY2VzLiBGaXJzdGx5LCB3aGVuIHdyaXRlIG9wZXJhdGlvbnMgZmFp
bA0KPiBmb3IgdGhlIGJhZGJsb2NrcywgbnVsbF9ibGsgZG9lcyBub3Qgd3JpdGUgYW55IGRhdGEs
IHdoaWxlIHJlYWwgc3RvcmFnZQ0KPiBkZXZpY2VzIHNvbWV0aW1lcyBkbyBwYXJ0aWFsIGRhdGEg
d3JpdGUuIFNlY29uZGx5LCBudWxsX2JsayBhbHdheXMgbWFrZQ0KPiB3cml0ZSBvcGVyYXRpb25z
IGZhaWwgZm9yIHRoZSBzcGVjaWZpZWQgYmFkYmxvY2tzLCB3aGlsZSByZWFsIHN0b3JhZ2UNCj4g
ZGV2aWNlcyBjYW4gcmVjb3ZlciB0aGUgYmFkIGJsb2NrcyBzbyB0aGF0IG5leHQgd3JpdGUgb3Bl
cmF0aW9ucyBjYW4NCj4gc3VjY2VlZCBhZnRlciBmYWlsdXJlLiBIZW5jZSwgcmVhbCBzdG9yYWdl
IGRldmljZXMgYXJlIHJlcXVpcmVkIHRvIGNoZWNrDQo+IGlmIHVzZXJsYW5kIHRvb2xzIHN1cHBv
cnQgc3VjaCBwYXJ0aWFsIHdyaXRlcyBvciBiYWQgYmxvY2tzIHJlY292ZXJ5Lg0KPiANCj4gVGhp
cyBzZXJpZXMgaW1wcm92ZXMgd3JpdGUgZmFpbHVyZSBzaW11bGF0aW9uIGJ5IG51bGxfYmxrIHRv
IGFsbG93DQo+IGNoZWNraW5nIHVzZXJsYW5kIHRvb2xzIHdpdGhvdXQgcmVhbCBzdG9yYWdlIGRl
dmljZXMuIFRoZSBmaXJzdCBwYXRjaA0KPiBpcyBhIHByZXBhcmF0aW9uIHRvIG1ha2UgbmV3IGZl
YXR1cmUgYWRkaXRpb24gc2ltcGxlci4gVGhlIHNlY29uZCBwYXRjaA0KPiBpbnRyb2R1Y2VzIHRo
ZSAnYmFkYmxvY2tzX29uY2UnIHBhcmFtZXRlciB0byBzaW11bGF0ZSBiYWQgYmxvY2tzDQo+IHJl
Y292ZXJ5LiBUaGUgdGhpcmQgYW5kIHRoZSBmb3VydGggcGF0Y2hlcyBwcmVwYXJlIGZvciB0aGUg
ZmlmdGggcGF0Y2guDQo+IFRoZSBmaWZ0aCBwYXRjaCBhZGRzIHRoZSBwYXJ0aWFsIElPIHN1cHBv
cnQgYW5kIGludHJvZHVjZXMgdGhlDQo+ICdiYWRibG9ja3NfcGFydGlhbF9pbycgcGFyYW1ldGVy
Lg0KPiANCj4gQ2hhbmdlcyBmcm9tIHY0Og0KPiAqIDNyZCBwYXRjaDogTW92ZWQgbnVsbF9oYW5k
bGVfYmFkYmxvY2tzKCkgY2FsbCBhbmQgcmV3cm90ZSBjb21taXQgbWVzc2FnZQ0KPiAqIEFkZGVk
IFJldmlld2VkLWJ5IHRhZ3MNCj4gDQo+IENoYW5nZXMgZnJvbSB2MzoNCj4gKiA0dGggcGF0Y2g6
IFJlbmFtZWQgbnVsbF9oYW5kbGVfcnEoKSB0byBudWxsX2hhbmRsZV9kYXRhX3RyYW5zZmVyKCkN
Cj4gKiA1dGggcGF0Y2g6IEltcHJvdmVkIGNvbW1lbnRzIG9mIG51bGxfaGFuZGxlX2JhZGJsb2Nr
cygpDQo+ICogQWRkZWQgUmV2aWV3ZWQtYnkgdGFncw0KPiANCj4gQ2hhbmdlcyBmcm9tIHYyOg0K
PiAqIDFzdCBwYXRjaDogUmVmbGVjdGVkIGNvbW1lbnRzIG9uIHRoZSBsaXN0DQo+ICogMm5kIHBh
dGNoOiBNb3ZlZCB0aGUgNHRoIHBhdGNoIGluIHYyIHNlcmllcyB0byAybmQNCj4gICAgICAgICAg
ICAgICBSZWR1Y2VkIGlmLWJsb2NrIG5lc3QgbGV2ZWwNCj4gKiAzcmQgcGF0Y2g6IEFkZGVkIHRv
IGZpeCB6b25lIHJlc291cmNlIG1hbmFnZW1lbnQgYnVnDQo+ICogNHRoIHBhdGNoOiBBZGRlZCB0
byBwcmVwYXJlIGZvciB0aGUgbmV4dCBwYXRjaA0KPiAqIDV0aCBwYXRjaDogUmV3cml0dGVuIHRv
IGNhcmUgem9uZSByZXNvdXJjZSBtYW5hZ2VtZW50DQo+ICAgICAgICAgICAgICAgSW50cm9kdWNl
ZCBiYWRibG9ja3NfcGF0aWFsX2lvIHBhcmFtZXRlcg0KPiANCj4gQ2hhbmdlcyBmcm9tIHYxOg0K
PiAqIEFkZGVkIHRoZSBmaXJzdCBwYXRjaCB3aGljaCBhdm9pZHMgdGhlIGxvbmcsIG11bHRpLWxp
bmUgZmVhdHVyZXMgc3RyaW5nDQo+IA0KPiBTaGluJ2ljaGlybyBLYXdhc2FraSAoNSk6DQo+ICAg
IG51bGxfYmxrOiBnZW5lcmF0ZSBudWxsX2JsayBjb25maWdmcyBmZWF0dXJlcyBzdHJpbmcNCj4g
ICAgbnVsbF9ibGs6IGludHJvZHVjZSBiYWRibG9ja3Nfb25jZSBwYXJhbWV0ZXINCj4gICAgbnVs
bF9ibGs6IHJlcGxhY2UgbnVsbF9wcm9jZXNzX2NtZCgpIGNhbGwgaW4gbnVsbF96b25lX3dyaXRl
KCkNCj4gICAgbnVsbF9ibGs6IHBhc3MgdHJhbnNmZXIgc2l6ZSB0byBudWxsX2hhbmRsZV9ycSgp
DQo+ICAgIG51bGxfYmxrOiBkbyBwYXJ0aWFsIElPIGZvciBiYWQgYmxvY2tzDQo+IA0KPiAgIGRy
aXZlcnMvYmxvY2svbnVsbF9ibGsvbWFpbi5jICAgICB8IDE2NCArKysrKysrKysrKysrKysrKysr
LS0tLS0tLS0tLS0NCj4gICBkcml2ZXJzL2Jsb2NrL251bGxfYmxrL251bGxfYmxrLmggfCAgIDYg
KysNCj4gICBkcml2ZXJzL2Jsb2NrL251bGxfYmxrL3pvbmVkLmMgICAgfCAgMjAgKysrLQ0KPiAg
IDMgZmlsZXMgY2hhbmdlZCwgMTI5IGluc2VydGlvbnMoKyksIDYxIGRlbGV0aW9ucygtKQ0KPiAN
Cg0KRm9yIHRoZSBzZXJpZXMsDQpSZXZpZXdlZC1ieTogSm9oYW5uZXMgVGh1bXNoaXJuIDxqb2hh
bm5lcy50aHVtc2hpcm5Ad2RjLmNvbT4NCg==
