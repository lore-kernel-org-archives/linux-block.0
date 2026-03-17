Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2DE43101C2;
	Tue, 17 Mar 2026 16:30:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773765042; cv=fail; b=HgE1GpmHHHs/w6DIYSWRzmZrtE2cxyBuG4gkkQTUsnffrQlpbroIt3dRa2dLxD7KRdCJ8C36tfApC7LfkQz6ZFRiaVy8xe+a37o5VwAfdT1wVbzHMbq1gxDCUIuTIe8Ytl8vFyehpLxi25mZDCb15aO7dSIjE2jmSTWBMUFmhtI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773765042; c=relaxed/simple;
	bh=lKCSen6ZxmCpo2IfjS4TNG72r1Y+u4prPKYRU5fpIqc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Ijb4rrVHralpbUnMDF+Wn0nY2Vd3czaLewOWtjuHQmFSWPmkYqd3JtTq2kvTj9n4p0wALBBQc0N1GjecK8ZpmnB46N6Ebiz3XEkcy68Jbx1Sxvl6C9MtgD724VATycs3hk0HRLzXMQ1/FnY4fcywc49LEASQfAGoBdKv5gexnrc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=HDRs7GlP; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=AyjvNaqM; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="HDRs7GlP";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="AyjvNaqM"
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62HE8r421061276;
	Tue, 17 Mar 2026 16:30:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=39ToQpNL8azg1KkSxh0m0yMJNCOI8Wi6LZTwChjwlzA=; b=
	HDRs7GlP43TveIg+FiJQc0LCTgUu2qqSG05afcdUKjmKU/rsE4Py2rQpkJqpwYGH
	KRIvF34Bie6+A5srdO3VV0v1f+nMlCoTRoKsBLQj0Ca14opabtrfpgpBtRwpyI5N
	Wc1RIRvKJ6nAFFCEqmNWsTwi8oKpiA/kX8yQbZhpm76WCWJ2gQBsSBFD9ZiTwSuV
	fB2J6zDYYcJ7WIXcPjNmSgFgLHka23uMDrmQ2pxQB0fyAab4Fbl1cTUglrJWn1dl
	eaU4X7UiQMGwTIIIBvfSSpjtY6AGSCB9Jq14F5/hAk8qgbhSJ5MCmE6OMCWMeScJ
	VWAYmcGiRFXq9OwS3IM/Ww==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4cvy9rve1u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 17 Mar 2026 16:30:38 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 62HFQETw017790;
	Tue, 17 Mar 2026 16:30:38 GMT
Received: from sn4pr2101cu001.outbound.protection.outlook.com (mail-southcentralusazon11012015.outbound.protection.outlook.com [40.93.195.15])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4cvx4mw7xb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 17 Mar 2026 16:30:38 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JZEc42pNgMO77y+SyZkukr9Z9x78JHQycVlwFbDBR0753C3b0W8Jrzk0mQsH/p2Ohc6zDMbVHQFY//JVCouQjIZ4P6rRhhJI/965mxn2cvF1uwL0XoJAGUa7ePn/dyk8Vani5nyPZEKHW0lxP6Ap/o0u/Usvs/heWVpB+SFZ17iQ1RDeqQXpPVhpuZnn6acZRDBRCXxd/18LCF1As4ZZPyfoFtM9HdfwwbQJOhwc1WPWJrcYcUH85dWmnkmQREzJFn0wOT43wdhuIuKP0RwaYHMZ8FVdIj6jzXxLJt1dp3t+k7yPgS6j5JN3T5KRzMvvPJH0vpm2iQeNN9uPu01WHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=39ToQpNL8azg1KkSxh0m0yMJNCOI8Wi6LZTwChjwlzA=;
 b=afHqNZ6oZFoF0orLl8MffmPgRlBnY93CX0Ipfg/MGeBU2YuBEJj4gN5vpr92thzPSdqPor3PSrktkK8QOPLqzeuwmdZEtc5hPQtaoXI7O67Ckx0LEFRlQ5hvNmNdxeGuRgDavvaQabYjICuEGwouP4eYQdZNAjAakggJZqill6fJKCTtiJ8bQPMr+koJQfTCd2NU1q7yhxv08M9/NzBkMlgxsfE+pRJT0zvvyupQb/GJpDBFb1k8R5POhKr5sq4hKDeFeOcWrJ7tl8sIn63loMs001qB+b6jiY2UmbIVPuOAv2EMA8rd9VFGb/2MxHBw2xpfTq6fIFNYyq0jVMEBQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=39ToQpNL8azg1KkSxh0m0yMJNCOI8Wi6LZTwChjwlzA=;
 b=AyjvNaqMhdsE+IvSj2+Dr2HKA9brrUjRokDBCi4Tm0LBx8uIDIwbq1dqswVxJEfmxoAbvo7i8jM3928QiPZTWxQIhku9WRcYudIsat8hd45aRV5dUV8pZQ1BEoqKTFCxjtJngMM5O9cIuHvupv4QH4nLNeEkrsxtZ19fOMwqqkw=
Received: from DS4PPFEAFA21C69.namprd10.prod.outlook.com
 (2603:10b6:f:fc00::d54) by SJ0PR10MB5598.namprd10.prod.outlook.com
 (2603:10b6:a03:3d9::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.27; Tue, 17 Mar
 2026 16:30:35 +0000
Received: from DS4PPFEAFA21C69.namprd10.prod.outlook.com
 ([fe80::5266:1601:5598:3f0a]) by DS4PPFEAFA21C69.namprd10.prod.outlook.com
 ([fe80::5266:1601:5598:3f0a%5]) with mapi id 15.20.9700.022; Tue, 17 Mar 2026
 16:30:34 +0000
Message-ID: <2d4116da-eeef-49f6-bd75-5ea424a36da2@oracle.com>
Date: Tue, 17 Mar 2026 16:30:31 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] blk-crypto: make blk_crypto_attr instances const
To: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>,
        Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260316-b4-sysfs-const-attr-block-v1-0-a35d73b986b0@weissschuh.net>
 <20260316-b4-sysfs-const-attr-block-v1-3-a35d73b986b0@weissschuh.net>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20260316-b4-sysfs-const-attr-block-v1-3-a35d73b986b0@weissschuh.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR0P281CA0141.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:96::12) To DS4PPFEAFA21C69.namprd10.prod.outlook.com
 (2603:10b6:f:fc00::d54)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPFEAFA21C69:EE_|SJ0PR10MB5598:EE_
X-MS-Office365-Filtering-Correlation-Id: 2a0f1e45-5cbc-49a4-9116-08de8442834d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|56012099003|18002099003|22082099003|7053199007;
X-Microsoft-Antispam-Message-Info:
	rpW2DSWKA0YKdFbaYtJGMF99dFFl8yV80yWVyQ9qK9MDHyZPyMmt4Pr9xSqg7fIMWofKIxzenOQy8D/Or2f8gmu8d0sezq5RrskLbPrG0oOw97y5N8DXtgXoYDzvI3bGR65qBjkCMkY2dW/U0fpsAjaalInnSuFQ/ZshHGxdhO5R4z1uG/+NMI52RMnHr//+yt1RL+/ZpfIU+LP2YzBPyfNaunKKquDkpPTClCRZnKcl6VxwyuGFx1ZqEMckEBEQlLOlPSxJUvTDc2cb2X9+SiBzKUBt+Hy2XxCQ9SJ9PoMqJHalJxmuGPIGwfljaZJ9rDWtMKOYtbNEVmH4ckagsGx3v0LBkuzfrESiYxVK8SvDwBqWd1SHZyEdixLV8+v8JyHchZcxz8XZKWChRmjco7YeoYpnfSzofsYg3xJPt3fUw3ui0hlKRdxA21v6BXg94lApZYyqsEnPIByoTVZbQQTpohYPYV3jG9EQ/716+ei/f0sNGb5BMDsj50Wz2viYfQjINz61qwGddnAqbYLp2G6ew8n/aHPotMMcNMJezQPg/pPdtRR/9GDu4UnoA0JW8i83BsHBkaS+LUrANYZxEA16fkrsu/8R44tNuYuIZzLP8oIAIWUv3nkXdYhetXHU16axar+XVHW9Bq9Q/a5sMHxem6Zkd8sQQu1mqtfo5zhNMrcba07XyjqpeCqf5MZsJ7/ak6+9YF1poxTX1ghfyq/3zcnSv+bHRJsPcJxzkyg=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPFEAFA21C69.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(56012099003)(18002099003)(22082099003)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WTA1Vy9pMWxERXg4TzZVV2E1czd2UU9INk43OTEvZU42T0luZVBuTzZOcWNY?=
 =?utf-8?B?aVBCVFNmZHlPTzFXZGlhbkcvWE52LytQa1F0anVUb2ppUVhNaFo3NGsvd0cr?=
 =?utf-8?B?Z0RBdm16c3BlakFyRjQwVUV6d1NZZUE3cHJjN3JGM1d5Q0tTUEJ5VGU5STQ0?=
 =?utf-8?B?ckZqODV6TWVVaEIzdEhtTFdpNDRiblFkWWJkNVVKS2xaZkVrc25lYXRsOERM?=
 =?utf-8?B?R3k4Mkx3bzhkNkZIUzI1UEE1UFNRN3FRY0ZKQTRBcmpLS2tXUWZhdkE3Yk51?=
 =?utf-8?B?eWI2cWFFNHlMWkVnSDcxNTV2VlZnaXhYUFA0dVpSZWhJWjhSbERqZ0d5YlNJ?=
 =?utf-8?B?SGZ0azFrVExsVVpXNDVNUHZOMXBjajRVcDVRZStYbGwveGU4cjIrTVUrK3kv?=
 =?utf-8?B?Y3Y5S3lENlFqS21TRkhJdCtPYVJCaXp3ZnVpR3RyT1poOEsxWUx6YTNVWnY1?=
 =?utf-8?B?TmdKd05kN2FqTllqVGhib3pDTkJCRTZEWnF2cHk3bG92bURnbWZTQ2JVaXBy?=
 =?utf-8?B?aXFrcUNSUGpKQi94V055SUpZWm5KYTZTRUljNmNTVFBBeloxNXJ4RTdkWm5P?=
 =?utf-8?B?Z2NyT2lrYXliVVhkVU9FTEJkOXpZNUliSFRjVFpiSzN5ekhvUUwvdTl3SnNu?=
 =?utf-8?B?MWVkdzY1ZWZBWXVVRytHNHFmT2V1bEhFek00NUhacmNtV2N6bHZmY0orYUVz?=
 =?utf-8?B?Sm9ncXRnaDhGQks3RkY3emhESVhmVEUzVnVGR3R5STArQUFuTFM1Z1gvUENP?=
 =?utf-8?B?bTg2NXBDNzZFNm1UTDVUQzF6VnZUa0t5MXh5MCsrcGRDK1hGalprb2JvOXRZ?=
 =?utf-8?B?NU5WcS90UEtvM04rWGI4Y014V2p5RkNCZ1FqTm5BM2hmRncrK2dmY2doSE43?=
 =?utf-8?B?OVQvVk9mSWpoSXdZZ0hrWDBOSjc3cGdXR1BHckxEaHR5Nkd2V0Rndlh5VXVD?=
 =?utf-8?B?b0tyK2VGNnBaalJuUnFVMXpFOWdSc1NCR2cySEtoek04Ni9rS0xKdG1HS29s?=
 =?utf-8?B?djU1YTMxdm9BTTQ3VXpYdG1yZWV5Z3JOTnJSNHBrWHZsWlFObnVTc0ZMTDFx?=
 =?utf-8?B?SzJHVTJKMTVsd0xGMURBczVLRmxFV1kwMVJPZU4xSk91dlRBTDVnc0N6akJ3?=
 =?utf-8?B?QkxIRklCYi9LcHFxdTBKQlZvR3hFNENFTmd5VVpNekNvc2pYUjRNaXJWNTly?=
 =?utf-8?B?dEl1dDRnZUJFZDZWTVpQUld1TGZFOUZERVlTcTY2SzBuT0UzMmNUTzlnVDlG?=
 =?utf-8?B?RXFqNFdZVit3SmpoNVVBb0JhT0dFNy9paGR6RUErMmF3WWZjeEl6T2RvU3I0?=
 =?utf-8?B?c2s3N2FubGdGQlM3WDdSVTE1TkJDcVQ3LzczRGlBZzNZT0xnRjIwSUFyNmtr?=
 =?utf-8?B?RXJwMlhvc24zcGc1dTBKTktqUUxBN0F1bG5JQUhsdUI4ZVA5bkhHejJrY0RP?=
 =?utf-8?B?Q09vc3FoUlFHUzlNbmYxVDl6VkxxZDA5cVlxVktQbkZSRFkvM2l3WlUyc2hP?=
 =?utf-8?B?TjdMUDBhT0JrUkVmMmwyalVESTUyZlV6dXlCcVNlbVk3MG9jSWUrcEZKd0Y2?=
 =?utf-8?B?T0JQVG1PTVBtN2phTmZibHR3cXRMVTBUNmFhc2JGdklkUjVYOGtPbmdmVlF5?=
 =?utf-8?B?STUyR0l6TnBDMTFBR1A5UWtTcUhBb1EzRzNQdnZBajBmRlh5cmZuczd2aXhp?=
 =?utf-8?B?R2cvcE1NSXd3bjIxUGNrQlJ4ZkdRaDY1eTkvV2h4TDZZSXRjdUtUTDZlK0Q3?=
 =?utf-8?B?aW9zeWcwMzZKd0RDaDFCZEh4MThDTngrSTUxdklHU0F0Z0lKMHI2b1p2Z1N5?=
 =?utf-8?B?Sk1IQkpZcXpJUWtRSXlUSHN5M3VVQVBzVFZWZVU2Q0QzLzAwYVFmUzBYbXFn?=
 =?utf-8?B?d0JiZWxnVGI0NVBOK0VVUGdqK1dKV3lITlBDeGF2ZUNTc3JJQ1JYWmxmaElZ?=
 =?utf-8?B?dlBXbi9kK24vOTVobnJudmNQSWhuUElsMzBxcml5NjdRRzdHM2hQUktYWVB6?=
 =?utf-8?B?SFlOK0xOVnErT3RNZkdkQjZtYTJLVUxBMVhyUGx2NHhNMC9PNnpDT1UxMERC?=
 =?utf-8?B?blZWS3E4QUgwaThRYUtYeGZqaEo0Q0d0TnlYWlVrbTJLRmw1amMvbExSYXZI?=
 =?utf-8?B?d3M2OElSQlhoTmc0QlkzUC9LVkEzUmpjSmx2T0l6TUtkVUxVSC9yamh6ZjV5?=
 =?utf-8?B?elBEcVdHZXRZQUZkb3ZQREg5bzV3LytaOHJGYkVhMUE5SXkzQ3podGkvem0x?=
 =?utf-8?B?eHlQRk9kOWVSbFhnNkh3SXZpWVBjeW5FYklhMThBMi9ua1FEUEZLeWVxNytT?=
 =?utf-8?B?cHNDU3JPb085dEhaWlVrcmRTdUNsTU0rY3Fnam9jMURtYTJoTGFjK1JmdnM2?=
 =?utf-8?Q?E+RlxOKIarVXqjfQ=3D?=
X-Exchange-RoutingPolicyChecked:
	AT7s45OFeKlh6HQvz+v/4GXxOcIo4BtxVetrA8aDq/U68OdorafxmNsdgjzkrxSAuOrVdcfb5QQJ5U4dcopG56stkVlJjmdGpT4Ot+T+Mg6kKmaXsPFPv1NHyE6uKZTihHPf4BDC5OJIAAKhhDU4RV74Fg1797xCvU7IxpLifrNO1U9fIsvZfhv9u0VuSXW5WhoHjJsSsFhWmEjZFPsvFz0obFIkWrorAWV7Fw6CXp0e8q2G8t1B5/ZwrndtJ/iSJcBQkS3ZNN6XbBOZnWq93s0dOP78WhzX0RK9H86m/lRYmIrQjPwO/BDWMxvZOfUvxX5XOt7x4jVM3/Ywys7tvA==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	h5UzUt1syk8zCBWaOJQQxo5FLtuZK6g7jCX2ac7hFQqTGywoZGsIT7dAyPOL6MspfKjZcOSP97J6coitsNXsL/qPv0b42TS1zZba4vVlwENs2u8OVOIWZyZNGAQ2G99WIvy+6KtDwqCzB6mZggWAG/rqfyS7Szx2MQTfAEL04BSoxaPeSeva971lW+tpRnB3Dg+4AFJzeMjwY4f+eHpniVJT7VJx8HXYTP0+UZhmDqUziwOpFdIF0ogXHgvKdxS15bntsYdMstPu6YFDBEsP7AD4JtnUT02w2xZfBH0OsjUKe4L1CsHKbFWaexX2sxB5ywR6jhnDym2hbkzhAviJsMTQnbwVj2gae1qxEJwp1NjCnW6kGyNLJR+q7oTLcsPco8QhWZMp4Bs41qL7LqCYezXSDpxY4omp5ahV8fn0ptgwbK5C23hMx5UwuifGrigFbGFDdfKpxHekXU8McwSfxFqdJvlH2mD5PRw3ki3X6c6iPVhO54cI+v+y1spdeVH5setcy1AurvOEAcU6XrYISheydr5asEuqgOvMr/rOkTmFRnaP8L4l9nOBmH5UuhWOHGCxS5bcb4ZUAnHz2o3YXXCIB/kYunnVif0gl0ZbD2g=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a0f1e45-5cbc-49a4-9116-08de8442834d
X-MS-Exchange-CrossTenant-AuthSource: DS4PPFEAFA21C69.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2026 16:30:34.1487
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zmKBhEmROPu/oqqH4EOigVO9RunapbVS4QRRRzmHaMeEkHfOgxXRZkMrGqKJJGQmmnSpCiuYa7L6ddDXd1Oe4A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5598
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-17_03,2026-03-17_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 adultscore=0
 suspectscore=0 bulkscore=0 spamscore=0 phishscore=0 mlxlogscore=999
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2603050001 definitions=main-2603170145
X-Authority-Analysis: v=2.4 cv=X5Vf6WTe c=1 sm=1 tr=0 ts=69b981af b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Yq5XynenixoA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=jiCTI4zE5U7BLdzWsZGv:22 a=3I1J8UUJPc9JN9BFgKH3:22 a=VTue-mJiAAAA:8
 a=yPCof4ZbAAAA:8 a=KZ_mT3XTZquE53ZskNgA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=S9YjYK_EKPFYWS37g-LV:22 cc=ntf awl=host:12273
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE3MDE0NiBTYWx0ZWRfXzrEMZAi/0WKx
 S+eDm9lYrSn7DQi3LVYYXxu1Jx9eUxLq7S6lh0Zdx2tjVnk10igEDhnT7dV4nvNsqK0pqLW1XEF
 w/Bv0DPirk8T3OJIkJT8t5z39zyw0WhQr5snsEn2F60bCBDH7Jmd0GvArvLdWqNcQJu+AiugHl5
 PH8ZLNb51BaE9wEQLpDlqLio+78fMTNWNEpqdn3gtP9xx0cXRYiqhgoGyXb99E4hjKaTAxQHMPT
 pxbTOsagtDD5cCwEYdqlpf7MUKw+rXcMyCzMfHht2Ntxd7qD1oAoQGVmsouWNq7sJTUm02l+uY2
 zCENrkegs1gnb4dZCTOC6QEhq13dqCWIlVYCck6ouiWHoELUainXQmKcVDdyZcCVl7oLwTfHGve
 VWGN56e7QT+uTtI1OgkT0LQF9KDjWbooR3+MQkfi+vcmR0sZW+roRcFSBJxiBcmIOrftSBU3sHx
 BI7BZaR0NdAgKzun1eYO32fIWFCvkOGH7jsT5GFU=
X-Proofpoint-GUID: X5Us5itjOH-j08E9QBUY-ZszII5dRhSk
X-Proofpoint-ORIG-GUID: X5Us5itjOH-j08E9QBUY-ZszII5dRhSk

On 16/03/2026 22:43, Thomas Weißschuh wrote:
> The blk_crypto_attrs structures are never modified, mark them as const.
> 
> Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>

With reservations, below:
Reviewed-by: John Garry <john.g.garry@oracle.com>>
>   static struct blk_crypto_profile *kobj_to_crypto_profile(struct kobject *kobj)
> @@ -26,39 +26,39 @@ static struct blk_crypto_profile *kobj_to_crypto_profile(struct kobject *kobj)
>   	return container_of(kobj, struct blk_crypto_kobj, kobj)->profile;
>   }
>   
> -static struct blk_crypto_attr *attr_to_crypto_attr(struct attribute *attr)
> +static const struct blk_crypto_attr *attr_to_crypto_attr(const struct attribute *attr)

 > 80 again, FWIW

And this code is becoming very "wordy" now. Maybe someone would think 
that the following is better:

#define attr_to_crypto_attr(attr) \
	container_of_const(attr, struct blk_crypto_attr, attr)

>   {
> -	return container_of(attr, struct blk_crypto_attr, attr);
> +	return container_of_const(attr, struct blk_crypto_attr, attr);
>   }
