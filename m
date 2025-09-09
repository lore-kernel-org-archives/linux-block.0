Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0613D274B5D
	for <linux-block@vger.kernel.org>; Tue,  9 Sep 2025 08:55:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757408145; cv=fail; b=I1L34m7C3a6sPF4uIY3mH5f57yDx456PIT5fDKmvLoQzyqNkJ/l+m7SWFX1LJ2O8woPpJoIbYvFIxrcjCIFw+N6XOutj23cwFKEAXUlP0pNvjZpiF7u1N3uS7TpWC4XIL/vKMRuLIO2SSTG2Caj4agE0KUiLzDa1NhgU4pzhkUs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757408145; c=relaxed/simple;
	bh=cb6n5uH4e/IFpsktVAhYW6aC4/I9lGZDHnI98M7oG7E=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=kh3SVlAC2n2HM1AR2DIqxmquCn2FFXuo0sGXrune1XOXTYRaSwnhxdgy9BMip+vnLL4wqwyOAd8l91Bzf9NkZ0gon5vjvUOg/b1YVw2FSaG3pvVQEPQXy+RualeJJ5+r2v1cudQroiRFznYvjX66xJlIkaPBh2okWwED3xoQKtU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=KqIBla90; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=URqJZ86I; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="KqIBla90";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="URqJZ86I"
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5897fvM0025866;
	Tue, 9 Sep 2025 08:55:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=9SvV9WQNRhZ6IMee764VpXkce/BCRo9nIPshQsY7iR0=; b=
	KqIBla90VPErRkhCeY3IHhuZSnmZr7MqWMPKYiPrdLQPMVrZOcHFJuLo9qL8/mNF
	j54L+k/eaSFEju+RWFzo916XA+ayw3hQgqgR0sfsJdTrOORrwxOpodYyBfnhBfOb
	JojsSJc8wW1J42Y2W97UAJG5y0OLP5SECOdjo9NU/SjNjg9YKWzTn0/EkbOwuuux
	Zhdn69Di4kt0YxquP3Qyvi5Cszvt/02MrxpkkJcc4+tIBwpuKFF0BLsw/QgAI8HT
	Ls6076FzWk1oNLRIlpJnsrikSn0TjinHDNIBWn9WRvoCTosztlb9xiYVpT/OarTV
	CeV92mqOXz2UvYoCxmIUug==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4921d1hj30-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 09 Sep 2025 08:55:28 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5898iTl4038759;
	Tue, 9 Sep 2025 08:55:27 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11on2087.outbound.protection.outlook.com [40.107.223.87])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 490bd9axb7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 09 Sep 2025 08:55:27 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cxQqgTZeECW0fiH3H5K5DzHIpTh+RUmL3mgPitiNwYtWm4l1ED+yHba+pNQzCkMOEAtRORrYnYU16URp31J27wanWKOT7ofaYI59kKqsvnoK2YfC9jN676g9lz4R3MVe+MeluU1GPiGfnRyCJ1Vckm3FuUo9N4k0kcSyDd+5eV5Np9p1PqOvZMeFFv0z8ZxQzwwGPXTPdOKu+uHvgN15JfTK9HJhlWy5kFNhZj8STUaii4u5d6QLJNz860HjDtPVQHSxt1cVWC1psMz3Fw7GEjIN+wuk5X4wWxw3JDhZQH52cNXWdo4mjFRR5uHWhrFkKfw4p1V6FTjaXyI4pPOZlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9SvV9WQNRhZ6IMee764VpXkce/BCRo9nIPshQsY7iR0=;
 b=nTcrL24NegqU1MXF8/GLJHein1sSDKm2c1sJTTP5mT0V+1rzeTnpwhi/v+L0yxh5+yoayf22vx+NnEy7yVnRkKCl/+cVfcakpmR23m+jM4wPgp3zYaipkh5vEd2jZSSv/7orhBADc9IK90xQWkbQfYNcSIeUTsI+13jOq2L6H80vGgAve2oJAEA8r/PiPguYok/HkkUNT9YJehGZ9QUVRaW3erYnYyJZ4P+4me9L5J+B2C19sxAP0DyFfLc2byK6nBqRgwDIdZBmFO6wKHwtd3AVDm030R/gZVeLLMgjhCYwIqgYTO+JGfcU6h/qt+anXid7+aQWX+M8FmYF6Sfe4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9SvV9WQNRhZ6IMee764VpXkce/BCRo9nIPshQsY7iR0=;
 b=URqJZ86I+PXb73bt9eA5SLrn4dieq1WEpHArsUOyN6fqhnFQGFBhGDp8bjOPZG410VY4va+ikxH4EC8QHDNoJvkVQ7QgUhy+faMAbSrJNfwfyvt3kbEmmBer72PDJ1w75+asoXFRRIm7KbqWkSHtjatWarrqOwldTEhrE4mnRp0=
Received: from MN2PR10MB4320.namprd10.prod.outlook.com (2603:10b6:208:1d5::16)
 by IA3PR10MB8466.namprd10.prod.outlook.com (2603:10b6:208:57f::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Tue, 9 Sep
 2025 08:55:25 +0000
Received: from MN2PR10MB4320.namprd10.prod.outlook.com
 ([fe80::42ec:1d58:8ba8:800c]) by MN2PR10MB4320.namprd10.prod.outlook.com
 ([fe80::42ec:1d58:8ba8:800c%7]) with mapi id 15.20.9094.021; Tue, 9 Sep 2025
 08:55:25 +0000
Message-ID: <8e5b16eb-a5f9-4fdb-8422-34be7c24b93b@oracle.com>
Date: Tue, 9 Sep 2025 09:55:22 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] block: remove the bi_inline_vecs variable sized array
 from struct bio
To: Yu Kuai <yukuai1@huaweicloud.com>, Christoph Hellwig <hch@lst.de>,
        Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, "yukuai (C)" <yukuai3@huawei.com>
References: <20250908105653.4079264-1-hch@lst.de>
 <20250908105653.4079264-3-hch@lst.de>
 <42becc1c-e842-4eba-a7ad-5b1e60594243@oracle.com>
 <8257e4d7-cf2e-6913-06fd-f11c2f94f38a@huaweicloud.com>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <8257e4d7-cf2e-6913-06fd-f11c2f94f38a@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P123CA0525.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:2c5::8) To MN2PR10MB4320.namprd10.prod.outlook.com
 (2603:10b6:208:1d5::16)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR10MB4320:EE_|IA3PR10MB8466:EE_
X-MS-Office365-Filtering-Correlation-Id: 6804841d-0437-4894-c01e-08ddef7e9dc9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?THVzRUJOdzFmYjZrSXk1UW1RbFdSVC9ROCt0bm5sdEdLbHB4RGFQcFBDQ0tK?=
 =?utf-8?B?ajN0cE1ZVnhlSW1ZNE1uUHZzNGR5Vi9xYTBpQmFlSnptWlhJbE16WkVJVTNs?=
 =?utf-8?B?MDA0VldjMUsxRHlXL3BiTUFCQXBTRy91YWIrSG02RVhXTUNBR2hzL3NkLyt3?=
 =?utf-8?B?OU1TZW9ScmlwNS9sSUp6VEQ4WUFXZDU2eWVkODh5Yi8vY05neENXdnlpMVNR?=
 =?utf-8?B?RUdORmRXcjB5czhLdWdLWnF4aytIRnNSOWpJRHJJWGxOT2paMXdaYkcyWjJw?=
 =?utf-8?B?Vm80VUpBcWt3ZG8yYkM5VTdLWXk3clF2eENoU3NhTE80K1B2RFNwSVRtS1lW?=
 =?utf-8?B?cUhhWkxIZUJUTGxHbjN1cW1VYVdZNjh2Y3ZrdDV3eVQ0M2xobFZ3R0gzU2ZV?=
 =?utf-8?B?a0NYc1hNblI3YTMvZmhFYmlHMDF3SU5lUlVrM2xjQnE2NkovRXhLcXlrVUVJ?=
 =?utf-8?B?Yit4YWtRTFhBUFRxTm5kWTlKNHR3NXVTS0pTUFhSc3BYT0MzN0pRSWh4c1o4?=
 =?utf-8?B?UWI5RktvTUh1eTQvK2tlMU40WE9vVVJqMTVKcW81Z2VieWZjekFXODRXenkr?=
 =?utf-8?B?ZkVOeW1PYm5WK1FpUnlJelN5bkJYV0ZMVm9jTDVxdVZzRnRoOHRoc2dFV2ti?=
 =?utf-8?B?aUh6S0tRTGtzVllBdjZta2lBUnk0YlpDbGsyZG50YnhzTG5ucVJBaFZJVi9D?=
 =?utf-8?B?aHpjN2pwa2g4dE1pZmlRV2h0L2oyK3JTVjdyM0s2Sm9UZitySzZkV0lmZFh2?=
 =?utf-8?B?dDFoT1NxL1p0cUZjZDJmTnNFV0dLUUY5MzMyNHJFR2IyU0Mxem94bkFmS2xM?=
 =?utf-8?B?WHE2ajlFRkgxWXZpZU9vaURmTVMrY1N4SHFQYjhrT1ZVM2p4MVFHdCt4eUpp?=
 =?utf-8?B?SEdyWWVFUkhSalRkaVNueEdsY3RtcUhPUlhSV1hvZzkxVE9EM1lWREEvWGJJ?=
 =?utf-8?B?N0tKTXRTbTNWWExvM1BhVzBXZTE2Q2xsN2V3ajl4NExWeENkWE9PcmJOVmdJ?=
 =?utf-8?B?cjFIRWpjU3VzNDM2b2E5OE1VVndmaUVjMFMxZG9ic3FXcHVlVGFIUEQ3WnBG?=
 =?utf-8?B?d0VTaE9wV1BHUSt6VCtnY0RwWnp4N1ljSTRpemFCZ2RWK0lwS2lQSE1sN2E5?=
 =?utf-8?B?RmgzMFQwdktMaVJSblFUdGtQdFJvSlRFRmdrZmN0U1FqVHRLTDFrMVlaSUhY?=
 =?utf-8?B?aXdDdk1Bd0ordlhXQ010WVVKWHVzRk9WelUzSVlSTkJ3eFZrUHRVMzhlNER2?=
 =?utf-8?B?a1d6K3FqcDh4ODdoSjdYanhTMmFtVUIvamZ4RUZybzlIa3VxeDdvNUZRNTkw?=
 =?utf-8?B?WW1RcWwrVDNQdHA5QUdHQzBObXg2cmEwZDZEVFdzMzFRSTVRcG41bzJtOG4z?=
 =?utf-8?B?Ym9DU20yN01welZwS1dLNmpuaUZrQ0F1WTNmUGhXYSszbWVlMDNnYnBGbkwx?=
 =?utf-8?B?NHArK3RRamlzeVZ1MTJiNEpsNWdYTGVYZkhmbExnc3I2cmxnVE5qeXRtMThm?=
 =?utf-8?B?eVJKbDdwRHRscW1qTTJsNjNPYWVBUS9GWlFDcEs3RVRaY2pJUkVTUCtKd3dV?=
 =?utf-8?B?QkhmdVEyZXVCMlFENW92UEtSMHBoRlZyL2FFaytSVFdUMHQzZHdzZFU4RHg1?=
 =?utf-8?B?VEh0OElBS0puYlU2QWRVUGt2RE02UU1qSVVQZmYwZm5peGxzQStvTXVZZmVL?=
 =?utf-8?B?L1RsRXdkK3BWVXRjcDZKYkZPSVZydGdObDNaWVVlN2N5OC9NbHpOTWhxMmJi?=
 =?utf-8?B?RG5RUzliOWlJb2F1UzRId1F2UmNDOXZkT25BRDZXQnppZmxnZDQ2NmlqUHVE?=
 =?utf-8?B?QWhZa3czbmtGL2pXVTJFK0Npb0dUTzBLMlhiRUt3ZXpqLzdKS1lScDI0dFA4?=
 =?utf-8?B?eldablVQQWYrajhiak9OeGVvcG9yQzl4Rmw5K1hYenl2TGVkUzlaL1gyd3NN?=
 =?utf-8?Q?R+ctut6qt0k=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4320.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?elk3WnRyMlNYSUNFMFhMRWFCenB3WmNPTnhITy9NZGtXcTZuclFxM282VG5O?=
 =?utf-8?B?THJrbTVyVWZzdE8yM2gwRWU2QkFMSld1UE9Iaks3dWJaUTF6RFVaa3YreE8y?=
 =?utf-8?B?bVBGbEZDa2lhQUlKNVdjTmlWenR4ckpYUGxtanI4UEdrVmU3c2VmcFFGTmkr?=
 =?utf-8?B?Znk3ZSsyTWQxME5qY3NFZE9UUTVJY1AzUnk5V3dLQmQyNnRyVllIeHdkbkla?=
 =?utf-8?B?NFM4OWJXdGpIVjJNQVROZTVxOVdrNFJweVBWcnl6bEc3bHZuajhWd1BiQVV3?=
 =?utf-8?B?YXExUG5Band0VUlCblFIcnVqeXFiZnFNc1pDdWdoZmt0Z2s0UnR4S1N2bHRa?=
 =?utf-8?B?M2c5a2ZYZnZIa2wySmJkUDdBL3hMc2dwaEFsUlRtT1g2M1B6a3F3WExJQWov?=
 =?utf-8?B?am9XSnB6Q3p4RGJNblRrTjZUSVFMdm9JQ3EzRE1DV0s4bDJMTFFOblEyYXBY?=
 =?utf-8?B?MkxJdjA0OTRFeU5rZjB2NUczbzBudk5LaTFndnRHc0xIOTJMdTdadWhJMks0?=
 =?utf-8?B?WENuNzdGdmFnZFRWSUVIcGVKaHRxTEhrWGMvRHB6UUlSOW45TWlONGdNU2Za?=
 =?utf-8?B?U1NSNWNURWhqR0kxTWJobUZ0VzhtZVBNR3VzSW5pM1ZjdFo4RFIvUkRxWUlr?=
 =?utf-8?B?Qnk1RTZ2YW0rb1FBQkdiOFozYVBqRWR4M0puT3pSMURUTUs0Y3VuUlBMZi9H?=
 =?utf-8?B?V0U0cEdTMFVCTzRUY01UVHphNHQ3UzNhbDY1aXZSTzRpVFgxMk92UHhSc1hs?=
 =?utf-8?B?ekI5RDk3SzdUSnVQUi8zajYyazl3Mk9xdFczdnc2ZHFldk1reWI5MktJUzBX?=
 =?utf-8?B?Q0V6MVQwd21OdDkzeDJDMVJlN013SExTbDVGMlh6SndDWC9QSU95TklmN2RO?=
 =?utf-8?B?TDFnMUNzM2sySm05QXBJMjd1WHcrbjR2bVQ3STExU3h3ODJ4dk5OVnRaREhn?=
 =?utf-8?B?QWxid3JJbll2WUF3SU8yL3dzTGJrQ1RNKzlIRHVwbVpwT1g0RHA0VnRNVFV2?=
 =?utf-8?B?cUlYdjYyaDNkUkg2b3BQYm1UQ0xhL3ByVEJ1N2VYK0lUV2w1dFZMU0hLWHBr?=
 =?utf-8?B?U2hQK1JJdkdnRm9KRDBUTXZzbGlzSkVQRlhGNy9zcFNlTjVUOExBM3BuekFr?=
 =?utf-8?B?b25DMVIrenR0S0RwRnpQM3BDaXFPT2JmTlR4Q04zeFNoWUVleFV2RWR4OTNi?=
 =?utf-8?B?WEdDSW5ZaUhldGFqVWZSa0dCeWpqbmFybmlmOHNIZ3dzVkJvZG0rVzQ1MjZI?=
 =?utf-8?B?WU9ObW4za3RHNjl6Ym9TNktYQVZGZFlIcWdEc3BlSTBrMUl4MllSdkV5QWFv?=
 =?utf-8?B?aEhCVGgwaWJrRG1oSE1VaW5GdWM5VzgvUFVzdDJJQ1c4TU9mcSsxY2FvRXNn?=
 =?utf-8?B?ckJXcHc3eUZjbTR5M2ZsQTR2alpCQk1hbi9KR1lwVjczYkRLK2tZd1hKcWpB?=
 =?utf-8?B?eFJ6Nm5jdENNamo0SnJCZG5wNXE2WTV0UWg5TWI3dWhwajZnN1RxZWQzb1Ry?=
 =?utf-8?B?Z2g5Tk9PWUsvc1ROMlVObFV3NXNrSGMzY3I1M1pCWDFVU1Q2K3IvR3IzM01G?=
 =?utf-8?B?TnRsZFJNbGtpQm9SQzRFQ3p3TUtSNDBtN1VwU3VHQ3N0Q3UxSkwwdzhmR3Jq?=
 =?utf-8?B?ejZwL3UxU0pPQ0lZajYybldlMFlZWWNGa0EzUDRwYjZTNzJTUDBxRTRrUml6?=
 =?utf-8?B?b2VuUGVsbmM5NjBOYktQN1V2WHNFdXhqTHM0b2R0ZzZkL21EZjh1ODFTQjhh?=
 =?utf-8?B?ak54RlBUNlpHSGxEWTlqOSsvOTZkN0xvblMrZkgrbnMvemltTUwyQW9CQWMx?=
 =?utf-8?B?dzJ2cy93R1pUS21SWmlHSlRiZjJJZ2V0M0V5NWFMM1FDQWsvYU1rNjErRkNi?=
 =?utf-8?B?NkpucTBveXpicXlrTXZJU2pQbVZoSzk4NVczN1UzSmpGL1cxRDVIQmZwMFVw?=
 =?utf-8?B?WVMvKzZXWmtHRlFJeEFSQWlxbXFpc3RSZGtUSTZCYnJYWUpVd21ZdXhnajZ1?=
 =?utf-8?B?cEJ2U3EyWm8zVWxxcGVhWnN0bU1uNmNiektGdHBIeHI4TkxEQ3B0eitQVWZq?=
 =?utf-8?B?cUdiVG9ERWxPck9hOVB1cG5abE5tQlpIWUk0ZXkvQlpBNmFIREZpK0V4aVpF?=
 =?utf-8?B?NGtqenl5UzRtajhpREd3bmtjNEhhQTlPU0tCbEwvNDdNVHJMOFZ3TDZoQjg2?=
 =?utf-8?B?Q3c9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	ffMsHqZh9k98Qk9TewVqn/hW5GZ4FAm/xluCTuGO6eYX6PSUEAU4PlRicHA0Ds3tSB6+ujm9psG30UZkjqgR303n+lD7pu/xU/3fTSTkQEJHyXg342JDkyczpBBrrPJhKgDnePpRwFnJBpHx1BIm9m4XVm9/MgsAcXz3dG+0zURkRWJ/jJYlrOULc20byl4hrlgKzVHdp5CP93EC8W0igHcxA5NOByxwFOAgzR3BarXy9EyTlImTspRrlprDI2hIjGNqsFaPUAjvnYg1rskpWchDZfC9kIUMd0agkcSQGxthglFZKz/6af/NQWBLO5A3ONde2rueBi5vdUkflXhzccgJt4ij1jVpyd0iNoTdI8WfwqhTsmL6SrapdAzZGErG5Y4MTrw3eHPYmMdH979zG3h+46+esovzRkRjsf1aR0bn7KwIWplolN3izxsev0qkQJO6CWhMkZeMdbYHIcm98i6p7ABENnStNZM8SP8N5BJIyOyUlMAVGSmMO+RqgXmxv6jYnj6JeQ5UYrGWuYIAFzCBSg4zcl+JCjW36LX10OCJv5lKUL8n4WbRS39y67Av2wwRnHuWkUVoBlyiUUKEE83ulbmqQIAMn05mt2e8hTs=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6804841d-0437-4894-c01e-08ddef7e9dc9
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4320.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2025 08:55:25.0113
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GAbl2XbGiZI7WqCdQCKF16PEdXV25d6O5OHsGFOYY4AqkGKxyrfa2cYIum2hhKBPcOp85UuZw0GGymO6BZ9tBA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR10MB8466
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-08_06,2025-09-08_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 bulkscore=0 suspectscore=0
 mlxlogscore=999 adultscore=0 spamscore=0 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2508110000
 definitions=main-2509090087
X-Proofpoint-ORIG-GUID: 30UzBjyqS36iWdHQRvoc661S8So3vpF-
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA4MDE1MCBTYWx0ZWRfX3rP1T+9VKG8Q
 J9q+w2/vfhgAyznDGp/1HGBve0XxVqWjPGUyNmkMH6yrCy1XXcZN/W+0/Se3pgsFWNBWLk5rr64
 64QmVe9okhOReDY3Eg/TeymMXVLl45y9Dzy5Xsczx+ZrPRn1Box6wpHKnSzZqP5e5Aj/OUAHCnK
 LMpsdf0LOa+llp8SgJEqSnTxf9ratPlBHG/35aqjj0wAQDghLiYLvQJOf6R6oZrIIDM518Q/N2F
 5PHHtDDlBYzPCvPFJgGxpkTLvnBY9RdF31XNL9cU8RZXAV3Gbkq6mxbeg5GXv9jqrVadJOVzawa
 d05J5+QloTmmw+P86VKa7P+AxKFlPimmd5ZVJt7Rx3y1s5+LM+QGpxzk/Ne/K3Q5tVfVD0/FFlf
 zmPtuAoAJijli+0WtC0iP2OC6Sk+9w==
X-Authority-Analysis: v=2.4 cv=d6P1yQjE c=1 sm=1 tr=0 ts=68bfeb80 b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=yJojWOMRYYMA:10 a=GoEa3M9JfhUA:10 a=fDl0ppNIHDzWws7BNAMA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 cc=ntf awl=host:12083
X-Proofpoint-GUID: 30UzBjyqS36iWdHQRvoc661S8So3vpF-

On 09/09/2025 09:40, Yu Kuai wrote:
> 
> 在 2025/09/09 16:16, John Garry 写道:
>>> diff --git a/drivers/md/bcache/movinggc.c b/drivers/md/bcache/movinggc.c
>>> index 4fc80c6d5b31..73918e55bf04 100644
>>> --- a/drivers/md/bcache/movinggc.c
>>> +++ b/drivers/md/bcache/movinggc.c
>>> @@ -145,9 +145,9 @@ static void read_moving(struct cache_set *c)
>>>               continue;
>>>           }
>>> -        io = kzalloc(struct_size(io, bio.bio.bi_inline_vecs,
>>> -                     DIV_ROUND_UP(KEY_SIZE(&w->key), PAGE_SECTORS)),
>>> -                 GFP_KERNEL);
>>> +        io = kzalloc(sizeof(*io) + sizeof(struct bio_vec) *
>>> +                DIV_ROUND_UP(KEY_SIZE(&w->key), PAGE_SECTORS),
>>> +                GFP_KERNEL);
>>
>> this seems a common pattern, so maybe another helper (which could be 
>> used by bio_kmalloc)? I am not advocating it, but just putting the 
>> idea out there... too many helpers makes it messy IMHO
> 
> Not sure how to do this, do you mean a marco to pass in the base
> structure type, nr_vecs and the gfp_mask?

something like the following (which I think is messy and an imprecise 
API, so again I am not advocating it):

struct bio *bio_kmalloc(unsigned short nr_vecs, gfp_t gfp_mask)
{
	return kmalloc(sizeof(struct bio) + nr_vecs * sizeof(struct bio_vec),
gfp_mask);
}

struct bio *bio_kmalloc_inline(unsigned short nr_vecs, gfp_t gfp_mask)
{
	if (nr_vecs > BIO_MAX_INLINE_VECS)
		return NULL;
	return bio_kmalloc(nr_vecs, gfp_mask);
}

