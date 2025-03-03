Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74FEE2B9AA;
	Mon,  3 Mar 2025 20:37:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741034238; cv=fail; b=JYh3KbKOVaqx7gq15KnfOmG2JKZMS1OKMB+uJESNUp6bBk90XxiwRbBEbQLOsDosAtNV46L5XeBe8wZiGY64v8vf1yehF+7m4INBCX9Ffzw8BB/gwe6kepIR56/P2NNaxRYaobUBzToFJF6mGyjAbVW1SYmfVAO34xbCurG7aQg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741034238; c=relaxed/simple;
	bh=5wbge8DX6JQuEy4ee1aOpvX0fij4hcmQ2cOeqd7sKoI=;
	h=Message-ID:Date:From:To:Cc:Subject:Content-Type:MIME-Version; b=HihNBH/OFst3Hc21Mcl9BX7rSPxiCbEKXvnIvONYg3dBsL40e0SwDv4d9IDUTqu6YACdlZg9rAtzdMYv2HBLcHvvhGvHGJVK/U8wiPGw95F+EL8rD39cUoMHxDmF1UukqYRWLC1MREyXh0SVK9iQyDKMDGgGCjPzRfIsqcHQPe0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=cD54J7Xp; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=qqJ8VLmE; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="cD54J7Xp";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="qqJ8VLmE"
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 523JfetC005279;
	Mon, 3 Mar 2025 20:36:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=corp-2023-11-20; bh=PHaONpIPcENFQ/zi
	NpGtW1XGJ6aHcMcI61xqUUUEURI=; b=cD54J7XpJCZYvRO9ez1IPUUFhUGAodOj
	C8EF2A0jXzRVh6ZuMvyvLbCZJwQQheL0b87u4WFVJQmA9GA3bVW9whbNFBu+Tvo8
	0rCNYS0SARMcClXuTtT80Nnh2zJd73f1/03KIENMWLKeD6Q8Mb9SjK1De08LrZxd
	QvQtuReF6M7Ssn/RaVH/Mmuc93WCQu+hei5Yz0NNCFmnDNxsjwmSlU2kNrYddzkd
	Zga+g7obCnMnEMISEnpdU0x3lAT2eAIIxukxd66QC7t8hh3a0Fl2fB8vCeRMMWIM
	Q5NzrMRA22eZuBza1bExUxahBHxq6u+YUCwf6I24msI1LSDqe7Ipzw==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 453u8hbk9w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 03 Mar 2025 20:36:52 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 523K1BfL040417;
	Mon, 3 Mar 2025 20:36:52 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2177.outbound.protection.outlook.com [104.47.56.177])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 453rpe9mye-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 03 Mar 2025 20:36:52 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iQrKFWPfSBTkgKSqh3FYmukKqr/y14AcW2OfHLSitc3pZVOjRGl6+1tFTMCrlFZOwpycfYbtuRTCyvr4kcMFZdNvg7gjh0RnSJ2eQHx8DBTzndLdk4YvvF31NsXukr45IIQelnAU12XPijQAxRJGFMKgfCTsXrWsnDHZ4b2y6vjLmdJ7M4IlZ1k1nkKsTQe9Tb25qqXY/7aei63iWciRTZKkNvnrTuz7rnQ4NHGnCxCPHWIy5Fd4DXCkme8lenNc8nExuf1XkSgelVqJT3s1edQqfRw3H3ppiI/1ykwauINu9kZdsoowT70/I07KRQIR5xtITkXuyRYTwUX3K8J8Ew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PHaONpIPcENFQ/ziNpGtW1XGJ6aHcMcI61xqUUUEURI=;
 b=t/M806XLcSgdh7pbRjUMtcMlqPR9OnYUJSiX/CwNjd/qY7/3c0bIjnmdWb9U11pDS96jAH4wZO7wpbVS9gBvi/eRR7sQMdh/0RLY6wSJ91suMvHm+KEYYUkQnKgJwcUNsf60HUnNntmX72f5AolzF3RgNYwxiP2mH34wOojHPMquzpobGrZLhCShLfBVMbSv0RMqmmDOPZWliIRDG7SlalmOcMO0BqX4E4vTvvSP+cFAY6NwbnKrITOORUDk+bvC4ODiTiW1vRiaMhV5JYJJirPE44U80sZ2rvc+40WHqxIczLjrVtugNglDwCFtYw8AV0h0X78zMUlXGCNO2Ive8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PHaONpIPcENFQ/ziNpGtW1XGJ6aHcMcI61xqUUUEURI=;
 b=qqJ8VLmEpwzydev/st7ju6uKH1FhvuCkNaF1d3C7iPOS40IqX5LbCaEo049H1vvTa4trIPfiNp9XH9sltLG3PI9HkSn9oFoHPvf2I7NMMRCbbiGycpav7NS/mxtehv60JSLCm3FR/B48K3c/XxAMw6+Elj4jMdLqhNtPEz40Evo=
Received: from CY8PR10MB6707.namprd10.prod.outlook.com (2603:10b6:930:93::22)
 by DM4PR10MB6277.namprd10.prod.outlook.com (2603:10b6:8:b6::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.25; Mon, 3 Mar
 2025 20:36:48 +0000
Received: from CY8PR10MB6707.namprd10.prod.outlook.com
 ([fe80::ccf3:1df:e15d:7465]) by CY8PR10MB6707.namprd10.prod.outlook.com
 ([fe80::ccf3:1df:e15d:7465%6]) with mapi id 15.20.8489.025; Mon, 3 Mar 2025
 20:36:48 +0000
Message-ID: <c0b1189c-6d8e-4c5c-82c6-5c1d9a2bca92@oracle.com>
Date: Mon, 3 Mar 2025 12:36:43 -0800
User-Agent: Mozilla Thunderbird
Content-Language: en-US
From: samasth.norway.ananda@oracle.com
To: yukuai3@huawei.com, czhong@redhat.com, yukuai1@huaweicloud.com
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, axboe@kernel.dk,
        xni@redhat.com, harshit.m.mogalapalli@oracle.com,
        himanshu.madhani@oracle.com, samasth.norway.ananda@oracle.com
Subject: pgbench buffer readwrite mode showing around 24% perf regression
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BN9PR03CA0232.namprd03.prod.outlook.com
 (2603:10b6:408:f8::27) To CY8PR10MB6707.namprd10.prod.outlook.com
 (2603:10b6:930:93::22)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR10MB6707:EE_|DM4PR10MB6277:EE_
X-MS-Office365-Filtering-Correlation-Id: 96b64d05-87ec-495e-e1c0-08dd5a931ebd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RElHRGUweGNtVk1FRmh1dm1PZ3NvSFZ1Z2NpQlpxZGtsNVNXSTBlM01LZ09F?=
 =?utf-8?B?cTBERUFGY1kzZDFGYzdRZGFiVWRERit2N0tXNGFVZmpDVTZYaVkwRitodlpP?=
 =?utf-8?B?ZkU5OHZIYnlET09mdlhma1ZHM2dyTERmdmxJM1A2SGdnMmNQd00rTFdqblVh?=
 =?utf-8?B?aEFhdmhHTFBaMmRYOHpXR2R5Sk5OenBkMUhIM2YyUnVldkprZlh2Q1J0ZkJG?=
 =?utf-8?B?UzEyUTYxSUFnNzJ6UTNaODVEUm5lSS9MTVBMSEF2NFZTLzBveXB6K2k4dFNZ?=
 =?utf-8?B?OGFJQjE3QWNSL1YyNm5BVFFIbTN6UlA1RFRpWFhIMTZyRUhOSE4xUnBUUGZJ?=
 =?utf-8?B?a0tHTGE5LytJb2hONEpkbEdnR0p4Y3BHdTlMLzlsOTlVdENrM2Q3ZWdoeDJ5?=
 =?utf-8?B?Q0tFNFNKUUVmMmRYcGIzdjgvTWNIZXIydjlGaDJZaFFTdm9wUG5EY2JlTnRr?=
 =?utf-8?B?QWlGaDlwYzlXeWxoMVJtRFliSGV3RnFqb2NSTEhuTG81TGpCak9jdkI3ZEsr?=
 =?utf-8?B?aXdZSzV5dVc4QjJqNXZNQzR0MVRYa1pGQnlpejJhUnVKNVRYSExQaFNHM3Q2?=
 =?utf-8?B?N0xkdEhOMkllb3JPb2xtVTZtVWI3NjBCb0VreCs2S2REUUJzSXRnLzBlV3l6?=
 =?utf-8?B?bHN6VFJ3QWpnSlZJQk5YMmRQOTNici9aODZwUGY5ZHczajJMdEdwYStRV09o?=
 =?utf-8?B?RUNpb1J1am01N1IyRytGOG1PRlJRS0JOTWpXcHp0dTBxYVZnQ3U2UDdBTnl6?=
 =?utf-8?B?dkR6cmpyd3hic21GT20yM3RPSDExNFp4cTJaWXBXYWdDcW9XWG9jcXo5ejNw?=
 =?utf-8?B?N0NwUzE1SHFmWElvZEVWNFdpTmd1NG5kS0hDR0p2UTNiZEVsRU5tOGFnNHo3?=
 =?utf-8?B?K2xWb0FFN3B5WXo2TFhiWU5YeXpCQTNHbEVwdTZZNFBYQUpKWEZvTlBXWFQ1?=
 =?utf-8?B?MzBlSzZWdzJDSTBIcEZ4Vi9ESWRjbXhCSmVOWHQ0SjZicGg4RkZOZlZHb1RS?=
 =?utf-8?B?cG4wMTU2VmxYUWZ3dTZlbE9XUGtibG5hUEprcGxya1phTXdmK1ljcnZrS3FY?=
 =?utf-8?B?c2kwV2gxdml3SkEwZjdaTExxdU8wUncrZGFUSmZVNXJ6bTRCK0lnSjR2VGZ6?=
 =?utf-8?B?bHJreFEycEFqSmFTRWQ4YnlIT0FvNmVVSzhSdkdJalpIemx0L1dnZk5wYlQz?=
 =?utf-8?B?dXo0ZDhvUG5xZldSNDJUTE1FS0FLT2pacG83U1N3bGlHb1I5N1REak1wQVJw?=
 =?utf-8?B?NHh2dzMrOElndHh0YWlzWXRkSVZ6VXdwRUFpNzNmWW5yaDBjdGtDUmNodzIz?=
 =?utf-8?B?R1BNMng3ZHVyTEo1M2JQQmYrUkhmdDFkeWhFbXFsb0ZqNHE1RVZrbU1VS1pG?=
 =?utf-8?B?cmVUb0QyWW8vMFdDZy9MRUJSRnl2QWtmWmhjd3lFTThvU1IwUUtuNGcyWFdh?=
 =?utf-8?B?Q1I1aHBJaGhxWFpydEVnaVFDalE0QndSWlhlSDZQNlAvMlpESi9YZkpHdjVK?=
 =?utf-8?B?UENnQUw2TWxGcTA5dzlRbzhnYXlyZFg2UVNDaVlIOEN6UkNETmJmRGRjMVcv?=
 =?utf-8?B?aVh2UThvdUovOVJEOTBUVnZmcHJBUkVCVDFndlkzcHRwRWN0b25zeGorWUxY?=
 =?utf-8?B?dE9xd2ViRjFLOEs5NjdMdXV1VnlaSzdJMkJDWncwNmF1N2pTTHpFRkZqMjll?=
 =?utf-8?B?RzR5UER4RFlMQWowcXdiKzlRYWVqejEwNEk2Y2JFNkFxc2liSHExRlAxWGJT?=
 =?utf-8?B?dVBmNnFXWVhMNWZBalFNYStHK2kwQVZoVDNTZHJIL2ZEbGh1VTBka1NUcyts?=
 =?utf-8?B?UEhRK1JYa29LQWZKeXdkSlhicjltcTh2WldYMzNwc05xTUFFMnpRaDc4OUs2?=
 =?utf-8?Q?iYEFRWzo6ZCRW?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR10MB6707.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RWI2U0Vid25Ec1BqcjZwcGNVS0lQVXVVaHZSazRlZnA0UnVBbFdxZTNwM2xW?=
 =?utf-8?B?NkxzVDdPKytoOHBiRXZYL0ZkWFBvSmRGN0xwOFQrbnc0bUx4bTlVeHloYnZW?=
 =?utf-8?B?WldaYWZiMVFheG5TMlc1WWpRWEtpeHUzVlRrOGp5MDU2OHVpMmRGNjdQanha?=
 =?utf-8?B?RWlqaExZVExkcUdZTWZQd29JVmlEK042NUs2S29YWmJnNVBQc2g5M09GVHpz?=
 =?utf-8?B?RHdzS3Q2T0kxbEtqMVhBeGQvTjFIVlV1bEZTK3dncXZpVkRRWllCUnJML1o3?=
 =?utf-8?B?RlduTW1jOHFsN1pWVmZ6NWpzcTlDNVVFZUpTeC9wNE40UzVxTTlpdElnbXM2?=
 =?utf-8?B?QndFQlYrdDd1VG4wWEJFbExUOXp3Z1VtbitYeDlXejkyNHRVU01SUzV2cDBp?=
 =?utf-8?B?eU1RSjNxSFhjOVJqVElVRzh3bEpYNDFjMlpkMXE0c0xnYi9vSmRMcHFXbGg2?=
 =?utf-8?B?VzFZOG9GZHl1MTh3ZWNyMW9ndkdaTFZuRFUvSVlUcTJ6Q2ZEYmxMZkQyaEVn?=
 =?utf-8?B?OFBDQjNZOTR3TVY5YzliTmZLY1EzWVVyOEowamNUUGRJRmlxNmNuYXFpZ3JG?=
 =?utf-8?B?NEQ2ZGxIbHc0RkdmcDVMdlJiUVBXM0tZNk1zTmVqb0FHSkxlSVFCWS91QjJ2?=
 =?utf-8?B?M2JndnVPc0hyb3JndnFvazZ0dmpsZkgraysyRDZUU3JwWnM0MFhkcjlEZVlE?=
 =?utf-8?B?bHltV2JvSVdsMVpicE9RWjZ5bkdGcVAvSU9JeFZ6T2RuUEZSVlNZREFWVmVu?=
 =?utf-8?B?QTlzSlFONXhKNjIvUkpWd0pvTUdNZi9Rd1ExM3NWYXpzVzlPWGc3UG5JcFZk?=
 =?utf-8?B?cE1EWnlyVVdGbU83MHVXN1FuTC9ZRnk2TUcydndDRkRmNlpCUmkrMGFpVnVU?=
 =?utf-8?B?UjZNZEpiZE5vaTJHdE9vbGZOZDlDZUFmOG4xK1g4aXVzc2w1Z2s2QXJEUkh6?=
 =?utf-8?B?Q1U5cjF6OGNmeXpjQ3VsWnA3Smx0cEZpK1hZcUlNcUNEYTBqUHZjSW5vSkZZ?=
 =?utf-8?B?d1hGUlBpZ04zenp4Ykl3bUkwK0tBRVk3M1gwaE1iaE1vbERjdXNJNnovK0Er?=
 =?utf-8?B?WWE3cG5CMllweks5Um5lZFM2cThjdnhhRWxNZzZOZzNqaEp4czg2K0k2V1hl?=
 =?utf-8?B?Rm9yNkVHQm5UWFRqVVFHNWhCU1ViZUIyQzZSdlh2SWRTL0s2NmsxSXJ1VkFu?=
 =?utf-8?B?aTRFV1IzZVFrQ0tMaEJvLzhJUUVpbW1ZRG5vTWNxYWwxS0dwdHlXLzNGMDhy?=
 =?utf-8?B?UFZOSUpDVGlLK0tFaGo3dVJrd1FuNzlrNXI5SU5aOXh4ZFJVZnhnZm9nOHZm?=
 =?utf-8?B?K0FHSXNqamFBZVN4OVltc1owbm1VdFIra2RzNnR2c05kd0ptZHVnaVlBMTNu?=
 =?utf-8?B?Z2w5NGJWcEFlamxXZ1FrMUFQRWRxNHBIUFU5MDhxczI0UW5BOUVQZnkxYXZQ?=
 =?utf-8?B?ZTIycThPQzIyU0lRaFNldEMvRFRVVTlwbEVFS0hENG8rVEN2SThheEpnbjZv?=
 =?utf-8?B?WmN5aXFuYUhRaE9PVUp6SWc3QTNPTEYvQjFtREU5V3lYVTI4MTdCaUhCeHRV?=
 =?utf-8?B?cmJ5bjdta0NpTlJZYm55akdUMyswb2ovZ0lmT1dxaW5qdVZDSXc2bUNjSXBK?=
 =?utf-8?B?ZnBxMndJQTkvSkhod2xzRWV1N29EbXJ1dm9SQ2ZLWTVUVTg2OURVaUFJbTJD?=
 =?utf-8?B?MGoyYXlVbnBBQ2Zyb096ZjhKckE5ZG1Mb1hmcTM5dmkvQnVPUzZRcXVwZlVp?=
 =?utf-8?B?V3BhUXkzc3dFM2xnSGFLdzU0Q1JaUnhwdEpjTzJBellMR1J0Uk9ieHhaaUU1?=
 =?utf-8?B?S296cml2R0Q2azFvZmZjNTVrSHBpZWdEdExmb2MrWFUxRm9vODFCSzRiM2Rz?=
 =?utf-8?B?NEIvbUJxZGd4WG1pZGhrRURadXVCN2dFV2JzaW45MFNGVzMzdEJxTDJJZFlD?=
 =?utf-8?B?ZEN0c0Q4NXJ4S3l2Mk9QdHYxdWc4T1AyOERmUGZxRzErYVBsSkF2WWN0OVBq?=
 =?utf-8?B?T2s1UFZ3amMxMytSMllBMTZPd3Yva3Z1V0lXaG5mT0s4M21CbVlCQU1SN3RO?=
 =?utf-8?B?VFlnNmhxU1RFaTFxazgrU3JuL1pyZVhaNEpJS1c1Rk1sUVZLaURsemRrUVdK?=
 =?utf-8?B?L2U5emZoSmtBQW5HQ0ROQ0lON245QUdHVkk1ZE02NEIxemVhY1pGdkVZY2x0?=
 =?utf-8?Q?L29pl0UfAJsJh/VFK67JY0Q=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	jhov14uvo24mCwyBDWW1CJO2mbSwntJ0eooUShUD/g2rpfGai5/7GXKHp5ofRrA1chTEN3GgygAyPzUYeCqypMwTHQlCCzsIiAqR9qG/lO9xMGpGy10DWrH806N+CHJ8iinch4+G2e1wDT1PKsSMYje/54sa13q5evfyWmiyuxVGwJcbL3hbYNOOxwbYjuizq/klVyLfvy0jJ0o/CCNKC5xI+xo37EIvcHGc3Emw0OPk9eD4iW0KN3NId5iayhHPpJXiePVgHwDd83rVLu3efsTdZ/7Si8X3sVnTxMwq22AA3yv3LT1jQH8oY8KTG1S9pKV+y9WwVgEH1LjynjszBn8ctWIaEpIheN5GVpg24YE2QpoT5u6vYpGj7uipVOKHKxgiP8eHhagi4N+8FPomrnOsC9tvIu9rKo2k2nODozJC4/OeuyM7GcnCojUREYAIqhmOSHzeTgGAP/O8KvPJ4HfvRYBxoMzeckZas95THN+d/YzX7ySx3Z4jpBSclRam97DrgPDwm7S3JQ461dxwDOQJ8gvDQ1Zv9w7BzqqW9m2+1ge8ey5Baxpqed/28TSrhuKXghIPtqTovBkrSnyse5RGRrpA0Be82W6nwAskjeQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 96b64d05-87ec-495e-e1c0-08dd5a931ebd
X-MS-Exchange-CrossTenant-AuthSource: CY8PR10MB6707.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2025 20:36:48.1372
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9/l7zIZVBgRUjJyZp/qgKj6MSTK/0dKWImBaWG04Tjfci9KH8fi+jb6xq9HVEHDnhfZESTCL6WvZbb7iWT1X9F++cRErN4dAzIwVQumfXho5xnN9Ty436NSjSnpJNr+l
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB6277
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-03_10,2025-03-03_04,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0 adultscore=0
 bulkscore=0 malwarescore=0 mlxlogscore=999 mlxscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502100000
 definitions=main-2503030158
X-Proofpoint-GUID: ZyfoHzmtgFLDS4Y7joj6CJk2v71-fECO
X-Proofpoint-ORIG-GUID: ZyfoHzmtgFLDS4Y7joj6CJk2v71-fECO


Hi,


We recently discovered a performance regression while running pgbench 
buffer readwrite metric over the 6.12 kernel.
After bisecting we were able to narrow it down to the commit
9a42891c35d50a8472b42c61256867b4dfcc1941 (“block: fix lost bio for plug 
enabled bio based device”)

The postgresql db used for this benchmark is stored on an xfs filesystem 
on top of a stripe across 6 disks.
lsblk output -

NAME         MAJ:MIN RM   SIZE RO TYPE MOUNTPOINTS
sda            8:0    0 557.9G  0 disk
└─sda1         8:1    0 557.9G  0 part
   └─tank-lvm 252:0    0   3.3T  0 lvm  /data
sdb            8:16   0 557.9G  0 disk
└─sdb1         8:17   0 557.9G  0 part
   └─tank-lvm 252:0    0   3.3T  0 lvm  /data
sdc            8:32   0 557.9G  0 disk
└─sdc1         8:33   0 557.9G  0 part
   └─tank-lvm 252:0    0   3.3T  0 lvm  /data
sdd            8:48   0 557.9G  0 disk
sde            8:64   0 557.9G  0 disk
└─sde1         8:65   0 557.9G  0 part
   └─tank-lvm 252:0    0   3.3T  0 lvm  /data
sdf            8:80   0 557.9G  0 disk
└─sdf1         8:81   0 557.9G  0 part
   └─tank-lvm 252:0    0   3.3T  0 lvm  /data
sdg            8:96   0 557.9G  0 disk
└─sdg1         8:97   0 557.9G  0 part
   └─tank-lvm 252:0    0   3.3T  0 lvm  /data
sdh            8:112  0 557.9G  0 disk
├─sdh1         8:113  0     1M  0 part
├─sdh2         8:114  0   9.8G  0 part /boot
├─sdh3         8:115  0    32G  0 part /
├─sdh4         8:116  0     1K  0 part
├─sdh5         8:117  0    16G  0 part [SWAP]
└─sdh6         8:118  0 500.1G  0 part /export/bench
0       /var/crash


The regression was only observed on some architectures.
I ran perf on the pqbench operation and found the following report.

Base kernel based on 6.12 -

# Overhead  Command          Shared Object             Symbol 

# ........  ...............  ........................ 
.........................................
#
      8.34%  pgbench          [kernel.kallsyms]         [k] 
update_sg_lb_stats.isra.0
      3.34%  pgbench          [kernel.kallsyms]         [k] 
entry_SYSRETQ_unsafe_stack
      2.57%  pgbench          [kernel.kallsyms]         [k] 
sched_balance_find_src_rq
      2.44%  pgbench          [kernel.kallsyms]         [k] 
_find_next_and_bit
      2.08%  pgbench          [kernel.kallsyms]         [k] idle_cpu
      1.99%  pgbench          [kernel.kallsyms]         [k] 
__raw_spin_lock_irqsave
      1.56%  pgbench          [kernel.kallsyms]         [k] _raw_spin_lock
      1.31%  pgbench          [kernel.kallsyms]         [k] 
native_queued_spin_lock_slowpath
      1.31%  pgbench          libpq.so.private16-5.16   [.] 
printfPQExpBuffer
      1.13%  pgbench          [kernel.kallsyms]         [k] 
cpu_util.constprop.0
      1.11%  pgbench          [kernel.kallsyms]         [k] 
syscall_return_via_sysret
      1.10%  pgbench          [kernel.kallsyms]         [k] 
rep_movs_alternative
      1.08%  pgbench          [kernel.kallsyms]         [k] unix_poll
      ----------------------cut here----------------------------

Base kernel based on 6.12 – with reverting the bisected commit -

  Overhead  Command          Shared Object            Symbol 

# ........  ...............  ....................... 
.........................................
#
      9.19%  pgbench          [kernel.kallsyms]        [k] 
update_sg_lb_stats.isra.0
      3.44%  pgbench          [kernel.kallsyms]        [k] 
entry_SYSRETQ_unsafe_stack
      3.39%  pgbench          [kernel.kallsyms]        [k] 
_find_next_and_bit
      1.85%  pgbench          [kernel.kallsyms]        [k] 
__raw_spin_lock_irqsave
      1.83%  pgbench          [kernel.kallsyms]        [k] idle_cpu
      1.79%  pgbench          [kernel.kallsyms]        [k] 
sched_balance_find_src_rq
      1.61%  pgbench          [kernel.kallsyms]        [k] _raw_spin_lock
      1.21%  pgbench          [kernel.kallsyms]        [k] entry_SYSCALL_64
      1.16%  pgbench          [kernel.kallsyms]        [k] unix_poll
      1.16%  pgbench          [kernel.kallsyms]        [k] 
syscall_return_via_sysret
      1.12%  pgbench          [kernel.kallsyms]        [k] 
cpu_util.constprop.0
      1.09%  pgbench          [kernel.kallsyms]        [k] 
native_queued_spin_lock_slowpath
      ----------------------cut here----------------------------

Please let me know if you need more information.

Thanks,
Samasth.
