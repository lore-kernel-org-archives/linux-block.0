Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8B92770E6
	for <linux-block@vger.kernel.org>; Thu, 11 Jul 2024 07:18:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720682290; cv=fail; b=Q3QsfVyU2GbBVJTQ/Yqt6sSYToORvAoMchK2GYNjF4ZKy4WJAdwdd3PJTuS6dHzmQOFVmH5LPb6PIqh7n0x05sx5foI1S8tciX/qcZ9iKZUZIfbL2rg0am0JcyKiyYZOrWu8g7aLiUbXcPMU7S8jKNv/7BsGlQgcPuDVyJl718Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720682290; c=relaxed/simple;
	bh=ki/7MnczT97uU2SKAwfOGTwgIt0bRb+VWnSkvfoQwUE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=T9ID96h6vX1Y1PxgBexK+nFjdRiCUiQi75BMU5eTAG7eQbBMroiU7zZgZ6SSTPEALNe+AHQauSkyVd0dOkzch+3rlQ/Ab1Pr94WEHqixdJ7ZBEADWwZ5hNCGsMyExEHrX+X4Q22jfRtSNZ2pZdGAdhFsF1Hh/j56VLh+eG0pAX8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=bz0A4N99; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=cWrI1XVy; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="bz0A4N99";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="cWrI1XVy"
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46B24ve9012005;
	Thu, 11 Jul 2024 07:17:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:references:in-reply-to
	:content-type:content-transfer-encoding:mime-version; s=
	corp-2023-11-20; bh=ki/7MnczT97uU2SKAwfOGTwgIt0bRb+VWnSkvfoQwUE=; b=
	bz0A4N99ITgsxmUh4oaQ4KOW0YG8lOO9jAHuhj7/6SzQ1mbrBqzq+ZsJUeypMtzB
	tspwYsmejvqDkFn0eZkbCaGJ6FZHIpJncQWnnAU3D91//wTJIRoh1ShrPcJMDVg7
	v4TC4Y4pMcCRNvoVDQ2+UTPoZ9LwTsX3HxC8SFl9x5cXN/oaEZLjbUI+4+wxN+eb
	Lxhjgy8Fx3aZO8RS69ApONEGpy+rB3dcJbxUrQjlAkLCccWIMuKBk4ztcw0pM6Qh
	jWOWiqWoRqEMwFcPm41EAO6HqI3VWOHussdVUzIKt3g8kGJh7uPc1DKOGRsNJcFX
	tLhJmfS+/HVDUImBIRRd5w==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 406wkcgvtr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 11 Jul 2024 07:17:57 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 46B75vJR010954;
	Thu, 11 Jul 2024 07:17:57 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2045.outbound.protection.outlook.com [104.47.55.45])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 409vv5c6n0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 11 Jul 2024 07:17:56 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TnO3Bja+5+Ua7PQaehISmUh1VLhACFXuQ6VPn76MCsuntoxqQe+q9bH3WdDF8ILahNXQMJkw/FY7L5Jeffq4AsX36aLDcXMZbvfc4GSEEzyw50HufB0ygL7J15PTte8jq5pAmOFEvVpqtDafpugnRM9rd8PGoDr7kHc0zuX6oFrlcCBO5h1hPZ48x0BpgrIBi8hDsxEOer0gR/bSl4yvQTyP50Qb6I3cQx4Lmq0PQJ6AxmWRBbiA8c+vSKyWRtxlwvO7YMViWxCwM4DIcH7ttzc+eHVEyrzkbo4KSTe1te5z8t5Sct5Vb6gFLYezXcQYv3VzG9Z361yMuOUcUuRElg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ki/7MnczT97uU2SKAwfOGTwgIt0bRb+VWnSkvfoQwUE=;
 b=qnr/xvO9pqMJh/ncLf/Ns4YorOxWSlufPn7Y1UIiqkJomiWlQ86det70GqvdSnRdgRY6UzS2CGcI0Y5eHw7+hHmmdaTJw1SgokXcQoulLcvQTKEiGXmOGgQlB4vCxTkHCCvuARlcQ7IQ9z9uV2I06oafC521VIebFSdRdIz3pEjNa8gmXhngHVlUnXCZKRMHU/rTRQEnFI0r/pilqLmuuhPF5t7F7L7hvmfbbxkq+xMuyQB2n+Q7ksFA7XlqFS1MV6ZGXzA1uCWs9KnNtD+aqA6UwZbRqHk6DWOBKMLs0DOyu5sCUrVGJxmbnqm2PQ8NOH0AxC6UjsbWwzpoaGq34g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ki/7MnczT97uU2SKAwfOGTwgIt0bRb+VWnSkvfoQwUE=;
 b=cWrI1XVydQj3BCy9J/oMuAopTtyXpA5B8Ize/8KAPogBu0f9zyN+Q65PYdYn6XATo0QEFD7KdZk1xhFzB/HFlEbe/0/KAi/quUxn7tDcOHEfbXjwKvAByQIiLDi6FjTD3Gq28COR66dKh9EB+PC1g7+z3JkJ0bELtFlvJIc8eW0=
Received: from IA1PR10MB7240.namprd10.prod.outlook.com (2603:10b6:208:3f5::9)
 by MN6PR10MB8120.namprd10.prod.outlook.com (2603:10b6:208:4f7::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.35; Thu, 11 Jul
 2024 07:17:54 +0000
Received: from IA1PR10MB7240.namprd10.prod.outlook.com
 ([fe80::962f:da30:466c:6a1]) by IA1PR10MB7240.namprd10.prod.outlook.com
 ([fe80::962f:da30:466c:6a1%2]) with mapi id 15.20.7741.033; Thu, 11 Jul 2024
 07:17:54 +0000
From: Gulam Mohamed <gulam.mohamed@oracle.com>
To: Petr Vorel <pvorel@suse.cz>
CC: Li Wang <liwang@redhat.com>, "ltp@lists.linux.it" <ltp@lists.linux.it>,
        Cyril Hrubis <chrubis@suse.cz>, Jens Axboe <axboe@kernel.dk>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: RE: [LTP] Request for Modification of test cases
Thread-Topic: [LTP] Request for Modification of test cases
Thread-Index: AdrPE+E5zP1T61RgRZ2SWJGBqXDPgQAQsVeAAKyqAiAAEiULAABEHZVw
Date: Thu, 11 Jul 2024 07:17:54 +0000
Message-ID: 
 <IA1PR10MB724000DDC9B27E375CADCFBA98A52@IA1PR10MB7240.namprd10.prod.outlook.com>
References: 
 <IA1PR10MB724059C5A7A69CE2A4AF257698DF2@IA1PR10MB7240.namprd10.prod.outlook.com>
 <CAEemH2fLGJY6D+GAgmFcoCk5jSw7-K5VkoDb1CEqTbwqfKw+Wg@mail.gmail.com>
 <IA1PR10MB7240E961E4C697B7379EB66E98DB2@IA1PR10MB7240.namprd10.prod.outlook.com>
 <20240709224650.GB214763@pevik>
In-Reply-To: <20240709224650.GB214763@pevik>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR10MB7240:EE_|MN6PR10MB8120:EE_
x-ms-office365-filtering-correlation-id: 184c56f1-4394-47e2-2829-08dca1799517
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info: 
 =?utf-8?B?dFM4ZksrbW4xMXFIc2U1STEwbzFEY01QZ0ptS2tkTkxkd21IV01idGNsUy9U?=
 =?utf-8?B?ZnJyUGQ3S1E1Qk5JUmM5bGl3UkR6RkE2OHlIT0ZteVFqbmkvK25mbmw1S28v?=
 =?utf-8?B?U3EvUzNxU1U3SGU4L1RTYndySXpvODF5Mm1tZ0NDbDZHVDZDWjllZFBKYlVv?=
 =?utf-8?B?TnlhK2ppSno3U2NtOVBCWHhWQWxQcndFVEh5emtsdnNwRy9ncXhDTFJ1SzZI?=
 =?utf-8?B?WDl0QkZMNVdrQm9Cc01WOWxmSUlTbXlTZVdJRDlscFEvZHB5ODBnQkw3eXVG?=
 =?utf-8?B?alZnU1I0V3c4L211VWsyLytESG1IakN0Ym1sY20waFNiWEdRZ1dsS0lqQkRH?=
 =?utf-8?B?cjBuSmVXdHltaytGTjN4Rnl3ZUJrcklEQ055aHBzUVVHU2grdm5HTjd0ZVNY?=
 =?utf-8?B?Unl0TXFIeThNRUZOODRrS2luUWUxcXdDSDhkYnlENTM5eTArc1YwVzJaZ2Iv?=
 =?utf-8?B?SkRGYlRRdUJSb2JnVzM1MVNHekZySGVQSzV4Z1BlM1lnL25zaGxsL0xBZEFS?=
 =?utf-8?B?N2dSdmowN3h3Y0dBUGtMK2lRZEx0YmRDcUNJVmh5alAwV3VjZWtrRGZBUkY1?=
 =?utf-8?B?U0FWRTZCOWpMcDRqd2lPbGhqdjhwVVRnSUpXdFNhSGsybWYzNk9COHNyT2JX?=
 =?utf-8?B?czE3S294WDhsNzBVcE9PVnFaT00vYllMQzRJYzFZNXEwbGc0N1BmMUY1VUJn?=
 =?utf-8?B?WXk1K1dGQ2hTN1VIdHllYjFwMVhOTS9KNVd5U3JsOXNhUVNYMENWbUpwTmJG?=
 =?utf-8?B?TDI0bERmNzNEN1duWXROTW9lckpmVFByeFFuU1JHdW5meE1XNWpJWWM1NnAx?=
 =?utf-8?B?aU9URWNOdFVuMTI0Y1ZKYVNyN1l1Y3BjdERYQmpEUmpWOXVCeFhVUG5ZdTZ0?=
 =?utf-8?B?MUJlM2d0U3lRM1VyaGVjdkp3VFkyVGdxVmRoc1hqRkc0TDNkSmVUbTdlc04r?=
 =?utf-8?B?QTMzWDdqNWhQNkhFN1ZTb2g4aTN3RVZsUjVoR3pNU1ZEbEhjWTNJaFJFdENZ?=
 =?utf-8?B?NzlOQ04xTkVid2dHTm82SGFSRkFUdjgyYnJSNDNETExRa1ZMajdzNVlQcHpJ?=
 =?utf-8?B?MnRaUmFZaEZaK1pFUk5ZekRNQmlLVjBUN1NtVU5rMXZmcDN0R1RraUFRS0lV?=
 =?utf-8?B?M0t4UlZMTG9yRXhpVk5tc3FHajcvNzlkcXBGMDNxRDZkVTVxVlBCMmlqKy93?=
 =?utf-8?B?QVo2Nm43bTBtbmVZeGx5STNoUlZtM0drSVpGbisxLzNhNFp3NDc3azJ3aTU5?=
 =?utf-8?B?RzlUMmxxL0JoQTZldmhSUm43Tk1hNUVqQjgwd250TnhST3M5aHRvM0U1YTFy?=
 =?utf-8?B?Y0tkVld1eGd3eXUvaXlzVmZNMjI5TS9oY0Z2RzRUcmpJdVo5VFBxSXo4cW9U?=
 =?utf-8?B?YkNzM1Z4TkIzQnZUTWRGT2xhaEJuQ1BKdWpOM3liUW5LcUlKVzFxVE96Sldx?=
 =?utf-8?B?UkhBTEJvZVRDSmRjeUJlUHBUS2o5MEl1Y0NoMWx0RmNWQS8yejBIaTlBbWJ4?=
 =?utf-8?B?eGFSOE14UzVvMVJvUy9hcWkvUndNa3RwRXdHaUpCV25tYitMeTlDaFZsdEtE?=
 =?utf-8?B?eDRUK1F1N0VRWkF0NFV3NnNNdTlVUXpMY3oxMTdXZDcySGE3enRtQWFyRDBh?=
 =?utf-8?B?YVk5WW1TdVJkbkZjZWVheTJ1SWEzd3B3Z25XaWpTTGY2RklPQU93c0NSMUJq?=
 =?utf-8?B?VUFZMU9qWU4wSlhnRlhQZFVaemJHOXVCb0RnQmhLTTl6ZUhkd3VkdXA3UGZE?=
 =?utf-8?B?T1RJV2tiMlpuTWdFL2p3OVUvNTZDL29KMzZXWERraS90ak9ZMlJDYyszWSth?=
 =?utf-8?Q?3Ot0BCQ3zEWse1RdfDU2MI/zMnVH4Htfs2r/s=3D?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR10MB7240.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?V00reUJhbktveFFPTS9qYm1DRGJTeDEvWDhTcU53WlFFN0MyWnZyUStqWDdS?=
 =?utf-8?B?cjJxQ1F5dnM5b0pVN1FyZUxyTWpXQ2o4dGc2Mys1eGpsTG1Rcno4dmdzc1Yw?=
 =?utf-8?B?YU9ZTXVZSmN2c3o0akNReHI0cWtHRk1USExweCtUZnBMRFJRUUU3eFlYWDVY?=
 =?utf-8?B?dVBITUlSd2ZnVmlPS0swaGQrcG9kWnl1SWN6ZGtaYm1nK2lpUTl2a3dIVVNv?=
 =?utf-8?B?NXZncjJ5UkRwQ09QeHRqTTBQTWNZQzBzT0FFRmgzOU5iWE9NV3kvaG9HcGd2?=
 =?utf-8?B?Qlloa0tkUWJtaWRGZHFNRWlnOGFDVDRnVzJwaEh2b1hjcnpSS3VRU0hMdlZW?=
 =?utf-8?B?dHFJczd1YlhNQmVaYnFYd09WVU9XREkvVWV2NGFFTE1kZ2RzcFg2aUtxRHNk?=
 =?utf-8?B?eE5vZnpRNHdaN2VPODluRW8zczVSZmVDelNOWFhpYlNUanpvUklsSVZKQnk0?=
 =?utf-8?B?cDJnejVIL3JFOEN6MU45QUZoRUdQWjFtYjA3Qml1TS83L0hGWnMvVVJYdEpC?=
 =?utf-8?B?QjBRczVtTDV5cm9WTDZNQ3VTSitFQytFL0UzbVhON0pmZzRvL2Y5TmhCc3lu?=
 =?utf-8?B?S1RtMU1mR0JDa2NkSENBTkdSNjYyYTBiU3RsQ2tKbm9lTldUdTMvYitseUtx?=
 =?utf-8?B?azZ0NjREbklJTm9xb2YzSGVTM3hMSDQ2NEFCSHFtWG1YVmtkcWRhTWpzMUNx?=
 =?utf-8?B?bGphemd2d2JSeUgyOHVleXlzR1l5dE9RVkdFdWtZT1h2QktDTWFZYlFQc2ND?=
 =?utf-8?B?ZHZCNGFIWW5VcitRT1JGd3JYYXQvUGJKMDhDTGplZXFQZDRiOGU2R1BpVk83?=
 =?utf-8?B?UkswU2xtVlUrMUxpckMrWXdBZkJrK28zd2h2eWROMkllOHRZTzhiQytHc01F?=
 =?utf-8?B?RTFGTW85UWRpQ1lqRWM5VU9YQVFZZGgydEo3bU50WWVnSFFWTDlOUjZaSmEx?=
 =?utf-8?B?NTRLSXRBZ3drd1BHcFREZGkzVndUMnoyNVZkMy9HRldHMHFnc3hLczlTSHJm?=
 =?utf-8?B?d091NnlNY1JYeHRqL1lJZ0laeWNzZnFRYUhVSmd2T0hZZ1hIcDlHQitaWDJ0?=
 =?utf-8?B?OTdyN2RsekpyTXVoUThNNmtoRmZlOWE3S2cvU1Q1eFdXN0RLMEh0Z1IxNndT?=
 =?utf-8?B?bmJXYjF4eVNZM3JjYkZkcVFuRGJSbmR2T28xdTRQUDJ5ZmpodWV1ZUh3VHdv?=
 =?utf-8?B?cEc1SUNIRUIycmQySlZXQWxqcW1PYVhqbjVxYlRFampoWDVtajhsNysrR3lM?=
 =?utf-8?B?bGtGNWlYNkdVbHFlY3NhQ0hpWU9wb0pldm1rczBha2pnbEZ5M3A0ZExkSXJL?=
 =?utf-8?B?MGFXZS9UdmlUeFEwMy9rVGhPZHNCQVNZYnZIbjhTbWxaV0tZUlRVMHh3MFVY?=
 =?utf-8?B?a1Z0Y2ZSK0xub05tZ3ZzcGV1d25GMHc4WVVabVlkUyt3UXlQRjdHUHlzUjVn?=
 =?utf-8?B?dTZiMkxvQnpnb0xmeUhFT2RSb3ZZVWE5N3haVHhBVVdZOWJsd3JURklEdENQ?=
 =?utf-8?B?MUVLeTV1MnEyTUFOVFBoVnVvUk9PV2JRZVBGQVNJbThZUm9LcnEwem1qNklk?=
 =?utf-8?B?WVVkOXorOTBXOHJlaS8wQ01CUlo3a1gxN1hxNW1zaFlraEp4UXVJbUZqQTdD?=
 =?utf-8?B?N1lYTTJ0eHNWcnorVnhpVStNT2paeVNzclFPcU1Pamh1a2ZiUnVDMUg5YkV1?=
 =?utf-8?B?a3JWUTZ6NVJJRERUSUx0TkdEU3ZYVDhxd3pidXhpNWNSMTdEUUVoZ1VvSFRW?=
 =?utf-8?B?ZHF3OFJMWW5VZ0QyeFdXeHUvMGtWVWJVdE9yM0xvR082MGpMMUR3ZW96enpw?=
 =?utf-8?B?Qk5USVpYODMvOEVPUCtxRjE2QUFnajBoekRhMzAxbVgvMUlmazVFWW50TVBm?=
 =?utf-8?B?T05NZWhjekQ2aXVsRnBLUStTWUtrWUVwRjkwVlFLVzlaRUZaUFhTeXFYcDBi?=
 =?utf-8?B?OFVvKy9QNDYxSnJ4MGVybFF2UWFLdldieEFkbnFMOFlaRmRkQWp6TDlOSjJ5?=
 =?utf-8?B?K0tGenhMNmNHRDRUME5NeEhvQ0RkU2o1eTlkd0RTd1lzVUt4b3dSMXhQekRY?=
 =?utf-8?B?WTZmUHVEVExoN3VJSUhXQlExUTc3TU5DcGh5d21wY0VMNTNLWTJFa0VERmor?=
 =?utf-8?Q?/98f7/Y00tqMYnh5KwxLwVE/7?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	vraSXPnQQqNY85XjgvHOdQfQX0HgUzunH+G2Auoo1UzaNeyU36YykBR/0VPQ4O9/pV4+ajbSWG7IML3LWYlurLFjW537puVnZ+QywLySTPZxQDRwHqg5MsbX6pjvSEkjxNo8r+kWHn9kxn3slCbGil1By2H2Nwy8HAzLKXvh8WCNQMyZQxuNscmWBouBsa5EApco3RoCd+jLJjgqctK4v6Tv7L+yc2bA9QZNLc9OnIwVfGPa4b4jebxUu6brBaDYO6PabbF9ud28qWYKmUr4TJFYc/+UJ9sB3HD0HbBPHcCtChUxR639h7meS4c5GIFLXFnoZEs/lxTr6rw5uAkDb4k77MH6nCCT25sLcz7PuQR53Lb+Au07AhSkiV+vp5lLmSfH0JYY4//ZIZcbW26gDu/h8hqvQw2eCV9cPGFazq23eBDtV9xqiR/u91aPuhQ7EL6Z2hIWOq06n0xboZrI2/a82gl7MyTjZaB58TPw+YM3PBGVQ9xR2ivajS3C5FAtm/qy1L3H1nxYXkvPwBPRwHFqVLqQyGSwXQMJpy593EMGK+dcY7Asv9BM8pEuX1PdKgnzrcyGqv0ui0KQ/ibuvmMgIdfz2I+XAqdqCpHl6W0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA1PR10MB7240.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 184c56f1-4394-47e2-2829-08dca1799517
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jul 2024 07:17:54.4117
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1GHx1ETI8YvV08TJAF9EHbw9JeszbDBLZRK/rAibnwOZTNy+zQx8lbKKs+JP507b1KNLJ7f3NH00PUxGfNXOS2Mcye5OTjLUexJxsjhT8VM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR10MB8120
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-11_03,2024-07-10_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 malwarescore=0 phishscore=0
 spamscore=0 mlxscore=0 suspectscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2406180000
 definitions=main-2407110048
X-Proofpoint-ORIG-GUID: oJ4kD-Bqi5ihaKlGs5zRS9nd4ekWFZBE
X-Proofpoint-GUID: oJ4kD-Bqi5ihaKlGs5zRS9nd4ekWFZBE

SGkgUGV0ciwNCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBQZXRyIFZv
cmVsIDxwdm9yZWxAc3VzZS5jej4NCj4gU2VudDogV2VkbmVzZGF5LCBKdWx5IDEwLCAyMDI0IDQ6
MTcgQU0NCj4gVG86IEd1bGFtIE1vaGFtZWQgPGd1bGFtLm1vaGFtZWRAb3JhY2xlLmNvbT4NCj4g
Q2M6IExpIFdhbmcgPGxpd2FuZ0ByZWRoYXQuY29tPjsgbHRwQGxpc3RzLmxpbnV4Lml0OyBDeXJp
bCBIcnViaXMNCj4gPGNocnViaXNAc3VzZS5jej47IEd1bGFtIE1vaGFtZWQgPGd1bGFtLm1vaGFt
ZWRAb3JhY2xlLmNvbT47IEplbnMNCj4gQXhib2UgPGF4Ym9lQGtlcm5lbC5kaz47IGxpbnV4LWJs
b2NrQHZnZXIua2VybmVsLm9yZw0KPiBTdWJqZWN0OiBSZTogW0xUUF0gUmVxdWVzdCBmb3IgTW9k
aWZpY2F0aW9uIG9mIHRlc3QgY2FzZXMNCj4gDQo+IEhpIEd1bGFtLCBhbGwsDQo+IA0KPiBbIENj
IGxpbnV4LWJsb2NrIGFuZCBhdXRob3IgYW5kIGNvbW1pdHRlciBvZiB0aGUgY2hhbmdlIGluIGtl
cm5lbCBdDQo+IA0KPiA+IEhpIExpIFdhbmcsDQo+IA0KPiA+IEZyb206IExpIFdhbmcgPGxpd2Fu
Z0ByZWRoYXQuY29tPg0KPiA+IFNlbnQ6IFNhdHVyZGF5LCBKdWx5IDYsIDIwMjQgOToxMyBBTQ0K
PiA+IFRvOiBHdWxhbSBNb2hhbWVkIDxndWxhbS5tb2hhbWVkQG9yYWNsZS5jb20+DQo+ID4gQ2M6
IGx0cEBsaXN0cy5saW51eC5pdA0KPiA+IFN1YmplY3Q6IFJlOiBbTFRQXSBSZXF1ZXN0IGZvciBN
b2RpZmljYXRpb24gb2YgdGVzdCBjYXNlcw0KPiANCj4gPiBIaSBHdWxhbSwNCj4gDQo+ID4gT24g
U2F0LCBKdWwgNiwgMjAyNCBhdCAzOjQ44oCvQU0gR3VsYW0gTW9oYW1lZCB2aWEgbHRwDQo+IDxs
dHBAbGlzdHMubGludXguaXQ8bWFpbHRvOmx0cEBsaXN0cy5saW51eC5pdD4+IHdyb3RlOg0KPiA+
IEhpIFRlYW0sDQo+IA0KPiA+ICAgICBUaGlzIGlzIHJlZ2FyZGluZyB0aGUgY2hhbmdlIGluIGtl
cm5lbCBiZWhhdmlvciBhYm91dCB0aGUgd2F5IHRoZSBsb29wDQo+IGRldmljZSBpcyBkZXRhY2hl
ZC4NCj4gDQo+ID4gICAgICAgICAgICAgICBDdXJyZW50IGJlaGF2aW9yDQo+ID4gICAgICAgICAg
ICAgICAtLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQ0KPiA+ICAgICAgICAgICAgICAgV2hlbiB0aGUg
TE9PUF9DTFJfRkQgaW9jdGwgY29tbWFuZCBpcyBzZW50IHRvIGRldGFjaCB0aGUgbG9vcA0KPiBk
ZXZpY2UsIHRoZSBlYXJsaWVyIGJlaGF2aW9yIHdhcyB0aGF0IHRoZSBsb29wICAgICBkZXZpY2Ug
dXNlZCB0byBiZSBkZXRhY2hlZCBhdA0KPiB0aGF0IGluc3RhbmNlIGl0c2VsZiBpZiB0aGVyZSB3
YXMgYSBzaW5nbGUgb3BlbmVyIG9ubHkuIElmDQo+ID4gICAgICAgICAgICAgICAgdGhlcmUgd2Vy
ZSBtdWx0aXBsZSBvcGVuZXJzIG9mIHRoZSBsb29wIGRldmljZSwgdGhlIGJlaGF2aW9yIHdhcyB0
bw0KPiBkZWZlciB0aGUgZGV0YWNoIG9wZXJhdGlvbiBhdCB0aGUgbGFzdCBjbG9zZSBvZiB0aGUg
ZGV2aWNlLg0KPiANCj4gPiAgICAgICAgICAgICAgIE5ldyBiZWhhdmlvcg0KPiA+ICAgICAgICAg
ICAgICAgLS0tLS0tLS0tLS0tLS0tLS0tDQo+ID4gICAgICAgICAgICAgICBBcyBwZXIgdGhlIG5l
dyBiZWhhdmlvciwgaXJyZXNwZWN0aXZlIG9mIHdoZXRoZXIgdGhlcmUgYXJlIGFueQ0KPiBvcGVu
ZXJzIG9mIHRoZSBsb29wIGRldmljZSBvciBub3QsIHRoZSBkZXRhY2ggb3BlcmF0aW9uIGlzIGRl
ZmVycmVkIHRvIHRoZSBsYXN0DQo+IGNsb3NlIG9mIHRoZSBkZXZpY2UuIFRoaXMgd2FzIGRvbmUg
dG8gYWRkcmVzcyBhbiBpc3N1ZSwgZHVlDQo+ID4gICAgICAgICAgICAgICB0byByYWNlIGNvZGl0
aW9ucywgcmVjZW50bHkgd2UgaGFkIGluIGtlcm5lbC4NCj4gDQo+ID4gICAgICAgICAgICAgICBX
aXRoIHRoZSBuZXcga2VybmVsIGJlaGF2aW9yIGluIHBsYWNlLCBzb21lIG9mIHRoZSBMVFAgdGVz
dCBjYXNlcyBpbg0KPiAidGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxscy9pb2N0bC8iIGFyZSBmYWls
aW5nIGFzIHRoZSBkZXZpY2UgaXMgY2xvc2VkIGF0IHRoZSBlbmQNCj4gb2YgdGhlIHRlc3QgYW5k
IHRoZSB0ZXN0IGNhc2VzIGFyZSBleHBlY3RpbmcgZm9yIHRoZQ0KPiA+ICAgICAgICAgICAgICAg
IHJlc3VsdHMgd2hpY2ggY2FuIG9jY3VyIGFmdGVyIHRoZSBkZXZpY2UgaXMgZGV0YWNoZWQuIFNv
bWUgb2YgdGhlDQo+IHRlc3QgY2FzZXMgd2hpY2ggYXJlIGZhaWxpbmcgYXJlOg0KPiANCj4gPiAg
ICAgICAgICAgICAgIDEuIGlvY3RsMDQsIGlvY3RsMDUsIGlvY3RsMDYsIGlvY3RsMDcsIGlvY3Rs
MDkNCj4gPiAgICAgICAgICAgICAgIDIuIGlvY3RsX2xvb3AwMSwgaW9jdGxfbG9vcDAyLCBpb2N0
bF9sb29wMDMsDQo+ID4gaW9jdGxfbG9vcDA0LCBpb2N0bF9sb29wMDUsIGlvY3RsX2xvb3AwNiwg
aW9jdGxfbG9vcDA3DQo+IA0KPiA+ICAgICAgICAgICAgICAgVGhlIG1haW4gcm9vdCBjYXVzZSBv
ZiB0aGUgbW9zdCBvZiB0aGUgdGVzdCBmYWlsdXJlcywgaXMgdGhlIGZ1bmN0aW9uDQo+ICJ0c3Rf
ZGV0YWNoX2RldmljZV9ieV9mZCgpIiB3aGVyZSB0aGUgZnVuY3Rpb24gaXMgZXhwZWN0aW5nIGVy
cm9yIEVOWElPDQo+IHdoaWNoIGlzIHJldHVybmVkIG9ubHkgYWZ0ZXIgdGhlIGRldmljZSBpcyBk
ZXRhY2hlZC4gQnV0DQo+ID4gICAgICAgICAgICAgICBkZXRhY2gsIGFzIHBlciBuZXcgYmVoYXZp
b3IsIGhhcHBlbnMgb25seSBhZnRlciB0aGUgbGFzdCBjbG9zZSAoaS5lDQo+IGFmdGVyIHRoaXMg
ZnVuY3Rpb24gaXMgcmV0dXJuZWQpLCB0aGUgdGVzdCB3aWxsIGZhaWwgd2l0aCBmb2xsb3dpbmcg
ZXJyb3I6DQo+IA0KPiA+ICAgICAgICAgICAgICAgImlvY3RsKC9kZXYvbG9vcDAsIExPT1BfQ0xS
X0ZELCAwKSBubyBFTlhJTyBmb3IgdG9vIGxvbmciDQo+IA0KPiA+ICAgICAgICAgICAgICAgU2lt
aWxhcmx5LCBzb21lIG90aGVyIHRlc3QgY2FzZXMgYXJlIGV4cGVjdGluZyByZXN1bHRzIHdoaWNo
IGFyZQ0KPiByZXR1cm5lZCBhZnRlciB0aGUgZGV0YWNoIG9wZXJhdGlvbiwgYnV0IGFzIHRoZSBk
ZXRhY2ggZGlkIG5vdCBoYXBwZW4sDQo+IHVuZXhwZWN0ZWQgdmFsdWVzIGFyZSByZXR1cm5lZCBy
ZXN1bHRpbmcgaW4gdGhlIHRlc3QgZmFpbHVyZS4NCj4gDQo+ID4gICAgICAgICAgICAgICBTbywg
Y2FuIExUUCBtYWludGFpbmVycyB0ZWFtIGNoYW5nZSB0aGUgaW1wYWN0ZWQgdGVzdCBjYXNlcyB0
bw0KPiBhY2NvbW1vZGF0ZSB0aGUgbmV3IGJlaGF2aW9yIG9mIGtlcm5lbCBmb3IgdGhlIGRldGFj
aCBvcGVyYXRpb24gb2YgdGhlDQo+IGxvb3AgZGV2aWNlPw0KPiANCj4gDQo+ID4gVGhhbmtzIGZv
ciBoaWdobGlnaHRpbmcgdGhlIGlzc3VlLCBjYW4geW91IHRlbGwgd2hpY2gga2VybmVsIHZlcnNp
b24NCj4gPiAoY29tbWl0ID8pIGludHJvZHVjZWQgdGhhdCBjaGFuZ2UsIHRoZW4gd2UgY291bGQg
YWRqdXN0IHRoZSB0ZXN0IGFnYWluc3QgdGhlDQo+IGRpZmZlcmVudCBrZXJuZWxzLg0KPiANCj4g
PiBUaGFua3MgZm9yIHRoZSBoZWxwLiBUaGUgcGF0Y2ggaXMgYWxyZWFkeSBpbiBxdWV1ZSBieSB0
aGUgYmxvY2sgbWFpbnRhaW5lcnMNCj4gZm9yIDYuMTEuIFNlZW1zIGxpa2UgaXQgd2lsbCBiZSBt
ZXJnZWQgc29vbi4NCj4gDQo+IFRoYW5rcyBmb3IgeW91ciByZXBvcnQuIEkgc3VwcG9zZSB5b3Ug
YXJlIHRhbGtpbmcgYWJvdXQgY29tbWl0DQo+IDE4MDQ4YzFhZjc4MzYNCj4gKCJsb29wOiBGaXgg
YSByYWNlIGJldHdlZW4gbG9vcCBkZXRhY2ggYW5kIGxvb3Agb3BlbiIpIFsxXSwgcmlnaHQ/IFRo
ZQ0KPiBjb21taXQgaXMgYWxyZWFkeSBpbiB0aGUgbmV4dCB0cmVlIFsyXS4NCj4gDQo+IEtpbmQg
cmVnYXJkcywNCj4gUGV0cg0KDQpZZXMsIHRoaXMgaXMgdGhlIG9uZSBJIHdhcyB0YWxraW5nIGFi
b3V0Lg0KDQpSZWdhcmRzLA0KR3VsYW0gTW9oYW1lZC4NCj4gDQo+IFsxXSBodHRwczovL3VybGRl
ZmVuc2UuY29tL3YzL19faHR0cHM6Ly9naXQua2VybmVsLmRrL2NnaXQvbGludXgtDQo+IGJsb2Nr
L2NvbW1pdC8/aD1mb3ItDQo+IDYuMTEqYmxvY2smaWQ9MTgwNDhjMWFmNzgzNmI4ZTMxNzM5ZDll
YWVmZWJjMmJmNzYyNjFmN19fO0x3ISFBQ1dWNQ0KPiBOOU0yUlY5OWhRIUtFMlh2ZEhUa3lJTUpr
a0NyOE5fMTRjSnpqdVJrQnpyLVlHcC0NCj4gZ29oeWRFdzdQVlhZXzRqZGl6OXhRSWZUNDFYR1px
MkFsYnJfc0lJVmRSZlVRJA0KPiBbMl0NCj4gaHR0cHM6Ly91cmxkZWZlbnNlLmNvbS92My9fX2h0
dHBzOi8vZ2l0Lmtlcm5lbC5vcmcvcHViL3NjbS9saW51eC9rZXJuZWwvZ2l0Lw0KPiBuZXh0L2xp
bnV4LW5leHQuZ2l0L2NvbW1pdC8/aD1uZXh0LQ0KPiAyMDI0MDcwOSZpZD0xODA0OGMxYWY3ODM2
YjhlMzE3MzlkOWVhZWZlYmMyYmY3NjI2MWY3X187ISFBQ1dWNU45DQo+IE0yUlY5OWhRIUtFMlh2
ZEhUa3lJTUpra0NyOE5fMTRjSnpqdVJrQnpyLVlHcC0NCj4gZ29oeWRFdzdQVlhZXzRqZGl6OXhR
SWZUNDFYR1pxMkFsYnJfc0lHc2xsODlnJA0KPiANCj4gPiBSZWdhcmRzLA0KPiA+IEd1bGFtIE1v
aGFtZWQuDQo=
