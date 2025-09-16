Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02853306D5E
	for <linux-block@vger.kernel.org>; Tue, 16 Sep 2025 12:27:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758025652; cv=fail; b=DTYQPpSwWmt3w4dAo00eEatq9H+gtEz6byvMt/e+5aHhIJqRQJuig31c6S6oIhY6Sf+3utQ3bW8jngSTmg5uKgwtLN/ODkphjxVodXNKCFQHVXGa60h8ny3a0fxyEaPCsjqmGFPGlaiJe/pqx+Xui2Mgdkn6uW9JVTUJW3X45JE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758025652; c=relaxed/simple;
	bh=3tp1Du+JhUaIj0eFFnFbV70w0iJIWd+GJ63BnHjDSvc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=k3sWJnXWaoWd+g8MZhcdMKV8FKAbeckl1cN1SwCpOwSRRInSIC2HQH14bSbmiGeEw/Z9DDLq5Hcd0WbXGoknlIzjfjENa/ebVWm6Gox9TTIRWwpy6JeZs28wqlRo9byWOavTmpvE9QoGfPXn6RTQR7GAAfvmDppCEQSHameljoM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=K+bx7MCH; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Ji5o80qJ; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="K+bx7MCH";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Ji5o80qJ"
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58G1fqug012950;
	Tue, 16 Sep 2025 12:27:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=oKyMpxDj405/HY6juKOC2e+frSlSRLpZya5puV/Qb6U=; b=
	K+bx7MCHXQX+isRLKryOgM98tmlZbgL972iGbo7cZaONrNxakkeYRh5IlTz4J4+L
	24vTxrJYIBIngNklmoMQe9zhlbqojpRVDFrogPnoRo9/eXj/eYehhBctRUAdyh5D
	TfCJFIWdF1MZEdyYuvAp5MofNGnY/Vg+uMDKC5tIc+NDxuO85xwHYvKvEmFVtx2J
	YKiQRPNZpwMImU5UbfqK8+KJNeF+xlsmh6+W3crWXiPPIV9bdVh/A5EPN8Z57iPI
	2Z0B1Di4lV4H/GsDpZTmU6YCRoPvkHVHWUMJoHbI6DUbUkXCW4Uh39R/jmG4YlgF
	wgoxMRUP83y6HZdpP1qqfA==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 494yhd4jn3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 16 Sep 2025 12:27:29 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 58GBhm9u033697;
	Tue, 16 Sep 2025 12:27:29 GMT
Received: from bn8pr05cu002.outbound.protection.outlook.com (mail-eastus2azon11011071.outbound.protection.outlook.com [52.101.57.71])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 494y2ca2qs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 16 Sep 2025 12:27:29 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BCoaPxXowSTtWtGip7zuC5k48lU0VALAzeN8hfP8YvKOgBc7r83PrFItn/Z9vypNDGpRa8IhuDc6jyFswsIgmBFxu3AbMCuKGcmueLoeIYPM9t2QFIS3lLPg7SUB95qbhuVR4CCHAzS/A52qzjW8+3Uiz49rkA8PC4D+PpGchllPYmJWRdCoBM6ySb6BxiGd7gwoRdTO8RL7wg1bSQuwoGNGezKYM+9PTi2vagvIvXn8MHh75ODTeZl1GbHBau7gialzZAlPhmTXtvq+E1VxlOBmyUKlvb+tR8Ro8I7oe/HE0q7VglviljFM0SzDcRyb5t34R5Uct4f/swi9Kulnkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oKyMpxDj405/HY6juKOC2e+frSlSRLpZya5puV/Qb6U=;
 b=TvDtEO9+47ofdYx6TxeXh9xWYYep0Z9RhdB0jkJ3M1kehAJJRNiRh8JXVT+5b2dm96rviu9h3i3HjtUJFhcXehj3IcHsCg5vbsFpvgg9OzSRzoDbpcLBXdkbO9za5n7a8B9/Hao1d8mg0MEnUufV/HaXVxE6Qog97Fgey1mUPn5AZUBZ2qn3HuC1SWS/WqDoj8afj0AsIZojiaUEmVs8/5ib+QWB6hFjLQ0nrjptpNj4eyzsrtCcS/1064R5hvlfhAtXqjld9n7fo/W4oGwhwqjePOK0tTEFTYzOsJJbEJaThWpd7eNiOJaGR7IWpDr4yhb5hi+VMmW+9dBjuY4f+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oKyMpxDj405/HY6juKOC2e+frSlSRLpZya5puV/Qb6U=;
 b=Ji5o80qJKoPVr6kSPnyNMrjPs4nAgH3PSkvv9hOUO0JLcvROBWrzcamuiSu6c9UawLPbHb3yD9khv65OUwZMI4PLI4RyU+YT3VPxDbN9JR2VsRF27NIVMiJPbAFCAmKkua8dlj3a92k7YSVDV2+qGT04b5mXKP66WZ5bUY9RY1Y=
Received: from MN2PR10MB4320.namprd10.prod.outlook.com (2603:10b6:208:1d5::16)
 by SJ0PR10MB5890.namprd10.prod.outlook.com (2603:10b6:a03:3ef::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.23; Tue, 16 Sep
 2025 12:27:22 +0000
Received: from MN2PR10MB4320.namprd10.prod.outlook.com
 ([fe80::42ec:1d58:8ba8:800c]) by MN2PR10MB4320.namprd10.prod.outlook.com
 ([fe80::42ec:1d58:8ba8:800c%7]) with mapi id 15.20.9115.020; Tue, 16 Sep 2025
 12:27:22 +0000
Message-ID: <78cddd6e-b953-4217-b6f6-deab7afc38e4@oracle.com>
Date: Tue, 16 Sep 2025 13:27:19 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH blktests 0/7] Further stacked device atomic writes testing
To: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
References: <20250912095729.2281934-1-john.g.garry@oracle.com>
 <5eri4pgxaqhd2mcdruzubylfjshfo5ktye55crqgizhvr34qm7@mhqili4zugg5>
 <39c9f89a-6e6f-422f-88a2-3b2730b659a3@oracle.com>
 <70d8a0c1-5000-4a3d-82c8-2ac7a76056e1@oracle.com>
 <vpds7n4kuilakmqajzmkeipkkbd3wpehuf2ku66wevq2dlfwnf@wxne2chta3ir>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <vpds7n4kuilakmqajzmkeipkkbd3wpehuf2ku66wevq2dlfwnf@wxne2chta3ir>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P265CA0002.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2ad::22) To MN2PR10MB4320.namprd10.prod.outlook.com
 (2603:10b6:208:1d5::16)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR10MB4320:EE_|SJ0PR10MB5890:EE_
X-MS-Office365-Filtering-Correlation-Id: fdd48d15-400c-4656-5da7-08ddf51c624a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?YVBVaEdJM2lySEZYc0IzUFg2aDZPNlA4aDIwL2wxSmloWkxsSHljWjZsSTNG?=
 =?utf-8?B?aExEZkJFUURJZENlb0k1UzlVdGhzTGtBcFhlMTJwUUJmRmNPeG5sTWlXMmh4?=
 =?utf-8?B?eHczT05ldkhuczlNMldFWkROTTk2NE9XZDkxa1c5RUttQ0h0UDNrQ1hHVDlB?=
 =?utf-8?B?eHkwQkRTcjlwaFhGcEdoM3h3OXU0WmtVRzZSYUIxdHpVU3V4SzlOM0NnRkUv?=
 =?utf-8?B?M2Y3VktWL0Q4MEVwLzVGUkZHaUtqUlR1ampZTldUOCs5QzEveVpuNk1pbStQ?=
 =?utf-8?B?NDdiYTNjcDRqQVlRTWxiRDh0STdTYXVIRkIrZFYzK1JOTE95bzhDeXlySzFJ?=
 =?utf-8?B?YkNPRUVYTHRvRUplb1l4KzQwUC85RmpzT1lkZk1qOHhVUlBuMEdVNnJSZHdZ?=
 =?utf-8?B?M2tiNGlzeXdqY0ZTT0hsaEoyTUJpUnRETUxrQlJvcUNKenY5WnBxZTYvUXVx?=
 =?utf-8?B?djh4YjU1dW1ROTN3SGdianVrbFRrOW5lc095ZTY5MVNmUWhlWDRNNWw5VnZv?=
 =?utf-8?B?WGVkenBTQ3c2bU1nTjduNElwR1pVUkQ0eHhEL3hhYmZvYTB4cFhka052aFp3?=
 =?utf-8?B?U3VaS3ZvWS9zZldRSXU1S2pHZDUxM1NaSGlUcUF4TEo0Z1hUZVFEdlJTZ09T?=
 =?utf-8?B?R3JKa2ZpYWFEREVPbWpuUmJxVHhNYXVjbEloL1hXWm9KbUVaSEIrVlhMQldy?=
 =?utf-8?B?c0YrWFNxRjdvZnZxOG5hWTAvcUlYcDRWWUF0eXd3bFUzTDFWUi9MZWZRM21B?=
 =?utf-8?B?ZVpSVE1BaW83cnFobWNPQXVOczRsaXl3d1Q5cXVlOVZFYWVvRW92cDZzZjZ1?=
 =?utf-8?B?c3AxNGRXTWFNNzQ0VjF2N29jYXFHVll3aXlJeWY5ays3Nm05TlNCVVFPb1ZQ?=
 =?utf-8?B?bWdMN3hDN2tJSWpuOVRIN2VZMk13NU80ZWJWL1FIWnAwdEdDNXhDaW93aDl3?=
 =?utf-8?B?R21CSzlEaysrRkVSRmIzUWtjd255dmlBTVIyVnpOQ2ZFakJIYlJ4SnNicHg4?=
 =?utf-8?B?cERSY0ltS09JUngrLyt4K2VhajZWUWtPMW9DZFViVXRmazFQY1k5cEJYcVIx?=
 =?utf-8?B?TFJVSmhkQWZsbisxY3p6UURVNjRaOVliTm15K2M0L0RpOFlIcmNWZ2E4enFa?=
 =?utf-8?B?ZmhERGVqYisrK2ZHTHRoejFoRE1xcnVyWWJUODZFRDJFTmttZWtrYVJGWlEx?=
 =?utf-8?B?am03WnJoMFFsSXpyNlBIUmNxcFNveGtDQTZ5dVJteUhrTGZlTTMwWUo2ai9U?=
 =?utf-8?B?bGw4VXJFMnpFZU5yVjFQczNYaFc2eWxXMUNTSWpLOEJYam1PQUNNNVlFT2JW?=
 =?utf-8?B?Q2dYS1pHTFhaWjZETk43MzlzbzQ1Uk9rUWwrQ290Sm1PQjdOSUJwRmNONklG?=
 =?utf-8?B?TlZMM2R4VFIvbmkyY09YWWdDVWlOUkRZSlRDV1dDeHVpb3pPeERDWVVRZnIv?=
 =?utf-8?B?Z0FPT1FaMTh4bVNGMlVudmY2ZFJSc0o1R2V2TlUwWTMzVHdFNGZWMEoyYjB5?=
 =?utf-8?B?QXN6ZXp0TEMwT1ZSd3Y4bEpRZmpNMzVsOER0ZmNiNXNDMzB2NnlaTXJBbEk4?=
 =?utf-8?B?emIxOTRtSHh1bUQzQXQvMkk2SURCWmJvbUtVdFBkMmhkT1FtRWQzdVVoNFAv?=
 =?utf-8?B?azBBVmlqZkVETmhvZS9Nd2Y0TXZvV1ZGc2pOWDMrbGpQQ29TL3JVaEloWlpo?=
 =?utf-8?B?eDdicms1Q0RCVTU4TTBnUmVTcGM0bVlLb3lRWSswWThJOU1jck9sTkF1YkFH?=
 =?utf-8?B?MU10NkRSYUNpcmJUTk9iZHEvN00zTXdIU3p4NlppWXBxV0JYbnNuT3QyQzdN?=
 =?utf-8?Q?nOu7sxbfO5CwsikutMdLJLU45kCLII95vRPVQ=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4320.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SHZSbHBnd0dlNmxyWXg5cmIxZWFhV1hSOVNoQWxiQjVra0VUdGg4RzgrK1U2?=
 =?utf-8?B?STJuQVVaMjYyaWFja3QwNTZCbXdPMHYwNkZ6RG42K1Y2UHQvaDRSeWlGOTRr?=
 =?utf-8?B?S00zRi9HMHdRNko0OFF6bzBSeDNqaXR3Ulh2UTlxR0NhY1BvZUF4dWVnZkZs?=
 =?utf-8?B?TnlQMlpWd2IxMXZURFlHZnZTTk5WMmc5VURMSWJPYzlSc29MMG52SlBFcis1?=
 =?utf-8?B?WUJaWjNLZ1dwRVlRUTRUU0pFRTZyNEhTUDV6d0xRNm1YelMrK2lkN0ZEZzgr?=
 =?utf-8?B?bDdIMnRMMEExQThvSDF2ak9VdFJYL3NOUDU0VDExdUhmQkNzWldmS2g0ak5u?=
 =?utf-8?B?MDVDUndCcmNvaHVBdE43WWtzTXo1N2ZFck1EVzU1K25GQkJYbmRHTVRrMUdP?=
 =?utf-8?B?QjF2MFRxVzhVMVJGN25iL1AvYnVpallaZWRNcHEvWHQvVExYZUhLdFZvOHJ2?=
 =?utf-8?B?b3oyTDJJaGdvcldDNkhadEd2a2YwUVJoQnk3UWUvcHZOMGxTbzNOT21CdWly?=
 =?utf-8?B?bTI4b1QrRjlyREdHMm5mbEtSTTQrN2cyZm4wU1RvWS95Y0Q2V2VGa3pNcFhs?=
 =?utf-8?B?NGtnNkxYZ08yeUFlV0FJZGYwT3dpSWRhRlBZOXFBLzdtM0ExK0pXOVNpdGMv?=
 =?utf-8?B?SE9qTGNVN0tFMzVZSGpmdW53eEMwelVzdmNhSEFUQTdONnJ0VUVOdFlQdFR2?=
 =?utf-8?B?VjhHTXhYakJnY0Q5N0I0VFBlWFB4SWVoR1BMR05Va0prOWVqeVRBZ2QwVWc3?=
 =?utf-8?B?dTFCY0dLcVdDemNxT1Vtd1JqNXdURndUTkM5YUh5ZTVObm9uaVpQUG9CVG9i?=
 =?utf-8?B?KzU2c28ranhLZ1UxT2R6RXU3WEJoOUhIbGZ0MnlFb3VSeXlKMWs5ODduWXFq?=
 =?utf-8?B?MG9CR0pGME9BOHVLNC94ekZwSTNSRTJ3L2doaUZGeXQ3YXNXWDVVZGRiRjJT?=
 =?utf-8?B?bjg1VG85cHB6VEQ0Zkg3VkhTTFpUWS9sS1VqSzkzaWdVVEFUOTVEblNYc2JO?=
 =?utf-8?B?N05UcHlXWTNWblFIU0NYcmo3V296QXVwYlRndzdaTHJNd0J0YVNLbFd1b0w5?=
 =?utf-8?B?NmFzcGtXTk9OL0ZxZXhDTTJzbVJVVlowU3c3eHpYVyttM2dGQVFwMXlZVjJW?=
 =?utf-8?B?cmNHdWNvUWsySWROYWxsMW1lU3BBbmlPWndsUHdOeW5uNm1YMmlNVEJpZ3lv?=
 =?utf-8?B?Z25idVlXWXR4SVhMOTQvUzZVbnA2RkZqeERNUjZtYTlTTDNBTDNoSjM4VEo1?=
 =?utf-8?B?MXRWZjZFMHhFZDFCY1E0YzNOK0ppd1RJVk1LRWtGMCtDeUtJd2RPSVJGN2Rm?=
 =?utf-8?B?ejZ5RklTOVE1ZnRubGtNc2ZXUHdIT2s5d2VrTUF6SElGbzhjdzNkZ2srMUJz?=
 =?utf-8?B?S2tucXFuSGR4OWdiNXZqZk9hbFA1Wk5lajVHTXl4VE1BaTNaME5rY2E1QTVy?=
 =?utf-8?B?L3Ava0xoTmhQS1pnSTliT0pUK0VTYXVZUEg5eVVpSG5WYWovMTFGbExKRUVo?=
 =?utf-8?B?Y0FqMkRJSWFkWDRLT3JqUFc5ZDgyY255RE4zc0pTNklPQytHNlRsSThXazAr?=
 =?utf-8?B?c1pVZFp1T094aVhod3Q3b3NtOXFFVkwySFJ5aTRFQ2VFZ1JxLyttVTU3aUNq?=
 =?utf-8?B?SUMxUUgxdFlaNFhvSmtDcVNDcVQreWJNTXlBS3Q2emdNZFVxczNGMEpTV1pI?=
 =?utf-8?B?bFBiWGdZZW4yTVFnNER4UWdIemlrMG9FNXNNVnNVZTVqaWVFWUtwcGxZNFpN?=
 =?utf-8?B?OGFqQTZIRDh6QTZoSFpzMjczYnJtLzQyMUdFUHpjTHZ6WVJBTHY1enp6QWlr?=
 =?utf-8?B?WGdFWUxwcEVZZHlVNjR5U2p0YVdQNjBBMjZxSUxxZk5mSVJiNzJSODJHdjQ1?=
 =?utf-8?B?eFBGNXdtaVRad1BCR0JaN0lubldMWldwRkx5TmdTSWxvWWQ2TFJCdXZzY1dr?=
 =?utf-8?B?bnk3ci9iczNZOTNGNFZXdFYrYUhUa1plei83RkErb1Facm44UE5rbHZxK0JI?=
 =?utf-8?B?eGwrdURIcXh1YWtueGZUY2VRWVo1SzhOWHhXRmFXNDNyaWJ1YlRDSFAvWkpW?=
 =?utf-8?B?MlV2cG42eU5mSzczQkJ6Z2NaY3RCOHVHMWhiSHliN3RHdVBoYzVXUFlMeFRY?=
 =?utf-8?B?c0ROMGxjV1NIMVplZXI4TlhZM2E5NlZicEZLVGRlMWZGcVdvend5L2dVc041?=
 =?utf-8?B?cUE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	bGiY4AT1Y14RD11a2GMP1eIfauk0mB4h1Dh3W382d9PokU4aLDqbx/ofp42AQ+99p/xGJdrWBrQu4IIlYJ3vhwm5k1JDMPkjSXQNxYNczjr27+M6Oi5jRsMfvPvN+p4wL/INCCTbDnT9k4hE/18APp+2HDnp9UvlUfRtrM+YXwbcy9dTF5oXXCo6qitj0JQ5GJC65cFvQd/zVWySdDnDME5J8dpPwnoQoDT9o4FCTJHTuSYIyV0hvJn6Eey1PKXhD+20nhQe3sE7C/BDSiZl+cg2vY5opk0r5j/yZT15JGL0EfJVP9+X3mcCgQCUKTAtu92EmPqgSv2RivMY/Q3BFBwZ+gSrtqC4TIu62SLpYt5Qcb4Bnu1o+DmyetlvFlo2AvnrGYQTxs+F5uZVpjiUdv3iF7ejCo2VmN3FeLc7CQlSCV74d9xKZkEIBWOnqY+tOoOWUYK1P+BT0Pd3CNghtUU0L3si2Mk91gcG1GRBV+a8gKqDKu4KgPINICuWiPO07+F5tsm0hFjgV6Gr9V7ueldqzfCix+U6H2uLqeJZS8eYnvAlLZMwUdQ7QDwlzrLoTQyXjv8yDa/yu8qEbyksBkYPaHWR1O2B/QhxiTeeGH0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fdd48d15-400c-4656-5da7-08ddf51c624a
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4320.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2025 12:27:21.6734
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wqJt81XsEzn0gPeXPbJPDxE2wV3YxlqEQlhb07twoHVHG8hs8s532gcqRWxp9GjI2h6BNUNoOWLsABKLasmzAg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5890
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-16_02,2025-09-12_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 adultscore=0
 mlxlogscore=999 spamscore=0 mlxscore=0 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2508110000
 definitions=main-2509160116
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTEzMDAxOCBTYWx0ZWRfXzRN/vguk1cfP
 T0fd7aK/WYzCpoWUj61O9yl0xJBzeyPrujrf8yIiE8gGyM6UqXXwrYcMtM2SmUEusyQbrWRvfuT
 HJBnXLWKv0iVcAic10J/W/Gruie6Pyce+cdd6vea6g8o6cTx7vbc468dRST8vaGfdfYxt8gF6/N
 XNYBbZB3iKj0FlYqytIin9g3OL1uyDYhg9qp9p2v5oJ4Lkyt7r9J/Rzc1sLaBAF1xhk1XoWiIbq
 9aFEpBbm3/CRmKNCLWE6eNfFPjUliM5TBOG0zniMrVW10ZI5BngNsv936sVZ2AdNU66HUqk19fF
 FFpQlNlxg4oQjLXShCKUOc+JCJurtUOrzIUoAYaSgWYh7tQ7USp1hnuy4BO1ngW5GrgVZSux7dQ
 WYSf8jEi
X-Proofpoint-ORIG-GUID: SNkc2Q-0Zx3NnUFK0VYnbkZzpdT-dc-y
X-Authority-Analysis: v=2.4 cv=YKafyQGx c=1 sm=1 tr=0 ts=68c957b2 b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=yJojWOMRYYMA:10 a=GoEa3M9JfhUA:10 a=uherdBYGAAAA:8 a=NEAV23lmAAAA:8
 a=_XFzGM7T7uq2xQ028W8A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: SNkc2Q-0Zx3NnUFK0VYnbkZzpdT-dc-y

On 16/09/2025 13:23, Shinichiro Kawasaki wrote:
> On Sep 16, 2025 / 12:55, John Garry wrote:
>> On 16/09/2025 11:20, John Garry wrote:
>>>> also modified md/003 to adapt to the change [2].
>>>>
>>>> [1]
>>>> https://urldefense.com/v3/__https://github.com/kawasaki/blktests/
>>>> commit/7db35a16d7410cae728da8d6b9b2483e33e9c99b__;!!ACWV5N9M2RV99hQ! Lm9AlQ3T9qSGDEjCR0nGmjCGC_2wfuAbkP6zN9EfZD7L2Y7mgpKPah_fYZh6L_OPkH9IIxP4f9n1Q9dRRRJxbZQeqRtr$
>>>> [2]
>>>> https://urldefense.com/v3/__https://github.com/kawasaki/blktests/
>>>> commit/278e6c74deba68e3044abf0e6c3ec350c0bc4a40__;!!ACWV5N9M2RV99hQ! Lm9AlQ3T9qSGDEjCR0nGmjCGC_2wfuAbkP6zN9EfZD7L2Y7mgpKPah_fYZh6L_OPkH9IIxP4f9n1Q9dRRRJxbSlcsw0E$
>>>>
>>>> Please let me know your thoughts on the two approaches.
>>>
>>> Let me check it, thanks!
>>
>> I gave it a spin for 003 and it looks to work ok - thanks!
> 
> Sounds good! Then let's seek for this solution approach :)

ok, great!

> 
> Let me have a day or two to improve the patch [1]. I rethough and now I think
> TEST_DEV_ARRAY values will be test case dependent. When we have another test
> case to have multiple devices, the new test will require different set of
> devices from md/002, probably. So TEST_DEV_ARRAY can be an associative array:
> 
>    TEST_DEV_ARRAY[md/002]="/dev/nvme0n1 /dev/nvme1n1 /dev/nvme2n1 /dev/nvvme3n1"
> 
> I need to do some trials to see if this idea is feasible.

ok

> 
>>
>> I further comment I have on my own code is about this snippet from 003:
>>
>> 	for ((i = 0; i < ${#NVME_TEST_DEVS[@]}; ++i)); do
>> 		TEST_DEV_SYSFS="${NVME_TEST_DEVS_SYSFS[$i]}"
>> 		TEST_DEV="${NVME_TEST_DEVS[$i]}"
>> 		_require_device_support_atomic_writes
>> 		_require_test_dev_size 16m
>> 	done
>>
>> Notice that I set TEST_DEV_SYSFS and TEST_DEV, as these are required for the
>> _require_device_support_atomic_writes and _require_test_dev_size calls. I'm
>> just trying to reuse helpers normally used for test_device(). Is this ok to
>> do so? I'm not sure if it is a bit of a bodge...
> 
> Not really, TEST_DEV_SYSFS and TEST_DEV are part of the interface between the
> blktests framework and test cases. They should be set only by the blktests
> framework, and test cases should not modify them. My prototype patch [1]
> ensures that device_requires() is called for each element of the
> TEST_DEV_ARRAY. Then, the code snippet you quoted can be replaced as follows:

ok, good

> 
> diff --git a/tests/md/003 b/tests/md/003
> index 94c1132..765c4cc 100755
> --- a/tests/md/003
> +++ b/tests/md/003
> @@ -14,6 +14,11 @@ requires() {
>   	_nvme_requires
>   }
>   
> +device_requires() {
> +	_require_device_support_atomic_writes

Incidentally, I think that we can drop this, as it is worth testing 
stacking of devices which don't support atomic writes (to unsure that 
the stacked device also do not support atomic writes).

> +	_require_test_dev_size 16m
> +}
> +
>   test_device_array() {
>   	local ns
>   	local testdev_count=0
> @@ -33,13 +38,6 @@ test_device_array() {
>   		fi
>   	done
>   

Thanks for the help!
