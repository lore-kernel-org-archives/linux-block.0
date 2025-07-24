Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF2D02690F9
	for <linux-block@vger.kernel.org>; Thu, 24 Jul 2025 11:10:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753355421; cv=fail; b=W4J+yEe8FGdnHJMYHenS6VPSnESXM0RX/l9c/lRU1dBsB3ushGQU4TEGcsqN4Ut9ZuK1jyJXQjfOsHlIjFRmHWCzQ6O+BbXl/uqJFhF/0Z0QNyproaTCoRuqdNNP3BI4UrqtYxmHRgLpEFTE3/aYEw54wQw6OfBYA5h4Q3GsHW0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753355421; c=relaxed/simple;
	bh=fcHaOPy+U2Ju09w8ek8LmaQjR/V1fqehVrQr/i/kMds=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Tk4z883CtKV+iVTDwYBHYvzxT0PKh35NMUmvS78NCgB9RvutD3MMGr1RbBhzfeTW020piUdhCmnXSKR1XHdylz1cOhjIDJ4bAJW7xckyOOXn2MrHU1JwIe7EzDV60DRavSBLcD3habEGk9OnKiPI0epdymGWAQYoPMBX7FFIvIQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=eJs96XVl; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=cOvI/0nc; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="eJs96XVl";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="cOvI/0nc"
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56OB1csI019166;
	Thu, 24 Jul 2025 11:10:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=eMW9CGRgggpRLKiWF/JZgJeoTVrj1QQzYsnMCg72Frw=; b=
	eJs96XVlsI7WqHTMKugdtCtwXNubNhaJghXYgZwkRpbmcxWbM2fPkk2AKYe3DshO
	SyUDlt+Nyh9r1g0mrmvsWn7CiPhyWYAICfYJpOUfB6y6DnccDVtCwoWb8i25/JKS
	X2Z9sO+5IuaDiPVzXkroRHhD60+5wuqJHBgNCnFZ449TiB0Ip5sCBRLAAeJ3s4yy
	akRQnwpCoS5uvKF3a4LjzbG0aE0EMWjOJ1FIjQGMZkZkoSHl0edpj25G7klPDLTu
	xJM+qnQ0G9x4TBLIhbhLSbtde4gJ782t9aoucGAayjzc8ku2dS1TztMDIBby/lWa
	qDttbigkM0sgFKyxku4gDQ==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4805hphed6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 24 Jul 2025 11:10:10 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 56O9OPu6010797;
	Thu, 24 Jul 2025 11:10:03 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10on2043.outbound.protection.outlook.com [40.107.92.43])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4801tbpf33-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 24 Jul 2025 11:10:03 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PgRCOi0XpiKJegonyW7NfbHDLTvDRDLcp9m2fe58FUypsPuqIxAY3Q8d/LTdGZrri9i28sst/Yd1lrH7I+pmxzLhK7CmPefZik9wVXdTis/64oksr4AI7m8cFS/4jfXjQqz2cWXJnInvZQfcMbZgMFTkNzVaMYoZIALiYFxgHHi84PqYftyR525phPIkwMHhiVfJm1D9OR+zx8TIqtvoHqwden4O8+3UcBgHKNNJU7pEdR0avx/XE3J+dR7eFpTjKEipbmTsyrED2F0sgz0vVe4R3+Tikv1TWgIHEQsYKlvqdf54NzCTuUmxJD2MpvJIFxdn7Cedgc+MZrwokSAEsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eMW9CGRgggpRLKiWF/JZgJeoTVrj1QQzYsnMCg72Frw=;
 b=QuHSHhAqa0+EltxR70gpsQH1eyTOL6ReiWhEP+aYNydgwRXppaTsUnJ9KPK7LVFI90doUymeYyOp0BXDe8VeMQ1No5xD8oEbf9h7ABdfjvPziX3V9Nfxzl0n+nBSHZlWIdgA4euwgrB2AkjaCWpN2UU7QARPMqokDXenhNfxMHBk0J2oaAEulQnEbCeOGypOTnBP4Qs2aM2zNj17RBdG6DzLzeySrGWZAVIwly1hWqDo327HpnUaRsNJqCRtmzXsIAUknjgdP8GClx9Fl8HKRPMfa7Tp/jnYa7NPkc1kn3BiT6gwOrub2ErLSw6mqe/dzw5I5+mhnIh0xmjkKIcURA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eMW9CGRgggpRLKiWF/JZgJeoTVrj1QQzYsnMCg72Frw=;
 b=cOvI/0ncZgBKKXkCqu/nklC/Mo9Kehdsu6yZZa35af/6Qrofm2y3AaeKan9fsbHyIOA0wBAlPuZCzwVTJSojjf39k6O49KyAas6oaOPME/X67SNvJ1mx4KFNuFVlXsoD7Ipxne1CCM5IzYUBr/Qyjg/aIUx3LWvkeQJWk8Qmiho=
Received: from MN2PR10MB4320.namprd10.prod.outlook.com (2603:10b6:208:1d5::16)
 by SA2PR10MB4506.namprd10.prod.outlook.com (2603:10b6:806:111::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.22; Thu, 24 Jul
 2025 11:10:00 +0000
Received: from MN2PR10MB4320.namprd10.prod.outlook.com
 ([fe80::42ec:1d58:8ba8:800c]) by MN2PR10MB4320.namprd10.prod.outlook.com
 ([fe80::42ec:1d58:8ba8:800c%7]) with mapi id 15.20.8964.023; Thu, 24 Jul 2025
 11:10:00 +0000
Message-ID: <87cf53b6-2426-4d33-893b-479128cb38c7@oracle.com>
Date: Thu, 24 Jul 2025 12:09:57 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 2/2] block: Enforce power-of-2 physical block size
To: Hannes Reinecke <hare@suse.com>, axboe@kernel.dk
Cc: linux-block@vger.kernel.org, martin.petersen@oracle.com, hch@lst.de,
        dlemoal@kernel.org
References: <20250722102620.3208878-1-john.g.garry@oracle.com>
 <20250722102620.3208878-3-john.g.garry@oracle.com>
 <f0605f62-0562-420a-b121-67dc247638c9@oracle.com>
 <2969b760-2f7a-4cbb-895a-097dbd88974a@suse.com>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <2969b760-2f7a-4cbb-895a-097dbd88974a@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AS4P191CA0009.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d5::16) To CH2PR10MB4312.namprd10.prod.outlook.com
 (2603:10b6:610:7b::9)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR10MB4320:EE_|SA2PR10MB4506:EE_
X-MS-Office365-Filtering-Correlation-Id: c63b5884-cae4-4679-8160-08ddcaa2a165
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?d3dVWkI3bEwxSWdYWHQydTB0b3VMYko1OHpzQzR2dmxENlQwWUN6RlNHa2My?=
 =?utf-8?B?SG1JRmp4NkJkUGFMM3VwMjlLemZJMUIrSUg1Q3hOS01mSkpCMGFONlNtbkRR?=
 =?utf-8?B?NUFLRE5SVlhGcGhsRnpPVk5kQldySFNvTHluSWhLdExVSmVMME1kbjNKdmZC?=
 =?utf-8?B?VmIvcVZSZTFOOXlRSmExSS9IandzT2lLTGhZOXFVTyt1cEFxMFA1ZnlEVXFu?=
 =?utf-8?B?alNkcktEZHdPWndkOExmbDZHTS9qOUttRDRlUEJDUm56TFFQZUtQY3QxQTBx?=
 =?utf-8?B?OXBWWGJVR0FaZHl1WE9rSE8vSVEwMHJTN1VDVnkyMU5LT2xieCtTQkpRdTVx?=
 =?utf-8?B?dzVTYkZsY0hTbUdUNHZpV1d0QUkreGpUNnVrS1RrQnZhL2RXR2t6ZUtHbG5N?=
 =?utf-8?B?QWhBRENyWkRFdEgwYlR3VlhIL0diS0NVY1hKeGZ6SGVRWSthQllPMlRoYkxj?=
 =?utf-8?B?RGs1NlZLWGdMa3UzcGliQ0hiT1BqYVZRTDZUWHI3MVA4SUNvS3dhS2R1dTNY?=
 =?utf-8?B?TzJrUlV3MzdBdGR6Y2x1eDZ3NG1LVm1rc2NpeW5LN05Cb1psQm92YXJUTXZi?=
 =?utf-8?B?TSt4M09YbksraXBjUGR3UXFPTmgwMUJlbHdKcjJ3akgxVUhxUDBBMWI2MHZS?=
 =?utf-8?B?Yk9IRTQ4cTRLZEFqYmt5bm9RU0xieC80Z3FSdThuTTArMFBWSDcxVFJKRWQ2?=
 =?utf-8?B?RjRwRG42cE13NzZRbmpRcXI0TklldzNPZmlaK3crb1lwaFVwTTBHdEZtemdM?=
 =?utf-8?B?TFRLY3p5N05qTlcvekJUNmRJcEdTeDNGYmZ0NjQvWTMwb05BYXlWT3dFOWxE?=
 =?utf-8?B?TXZOTVY3RFlMc2R1L1o4UFBIaDZMNkoxdEp2SjZFUThsZXIxMUJETzFqMU9j?=
 =?utf-8?B?dzRMcHYzMkRIbE5QTW9tS1pEcFRoQVRFeEErRkRmREdxWkJ0Y2V6T2plcXBK?=
 =?utf-8?B?Q2d4dTFJVU1MbGlsZWY3RnpqQlBIeU91Sk5TNFZoaVlYQkR3d1dLUEhUdVIw?=
 =?utf-8?B?OWRkeFVsOENHcUNqckVSK0tVQjJRNlB2czRwd1lscks4cmlneHQ3eFM4aGNr?=
 =?utf-8?B?RnpSY1VQRjN1U3ptKysrVlp6bTRPT0NTd0FwUjNaTlMxMXJNRWdpU0RMQVlZ?=
 =?utf-8?B?TTR2RTgvbm1MdlU0eVdtNnd4eVZKU3dWdy9hVnErczBwajE4R29MKzdDckN3?=
 =?utf-8?B?Qit0Vlk4ZEVnZnFJaW5LeGR0WWkwdmFCcGl4aWkvRmdKb2MveGlZS0o1R2ta?=
 =?utf-8?B?Q1hJNUU1SmJ1ckVva1VOaWMwV01PdUxYQW1WcUxrcW1VYnVDdkcyRytvUUlD?=
 =?utf-8?B?SWM2bFVlazJydzBoaVJZNTB0eDZtdlYrV0FObXJPK3VjZHBtNXZWNCtvZzRj?=
 =?utf-8?B?a3BKUlR5Wi9kMDRtVmJ6VVg4ZlNlZWpidzBIanNRbWY3MHhuazNYUWc4NEpU?=
 =?utf-8?B?Vm9GZ0o4YVlGUDV0TVpvVzY1eGI1UkNaaVgxUDgxcDF3UWFiRHhFdXliMzFv?=
 =?utf-8?B?R0I0RE1jYzhndUx6VzFkZUZWRmJ1MUI4Z0NZbzZiOGxPZjQ5NzhKVmtHN1JP?=
 =?utf-8?B?eDNSbnphOUxrNlJ5ZFBjcjN4N1NnRjFnVmZZN0lMUzRUeVQ3MW8wdVRsT0V6?=
 =?utf-8?B?V0hCbzBKZnBhd1E3UVBWK1kwM0EvYjVuamNkTlJUTnJYSUVJS1RjdUFiKzFi?=
 =?utf-8?B?bVIrZGV0M05EcURISCtPa2JocWJhV3BWRHRodW5Ed0VYWnpka3dTbE12ZjBt?=
 =?utf-8?B?b0RvZlRiTWM0ZU02WHJaaVZCQ053MmZDNDRlckZSRkVRTHpEdDFWdmgyQ3JH?=
 =?utf-8?B?SCtOUDZnbFpaRnNKTUVTMk44c3lKT3FSN3YxYTAvaW9BalRkNUlmTm9nYnF5?=
 =?utf-8?B?cEw2T056MldvTXJjVXRENXdqQjdQUDB6SEJNaStVMzhWTmc9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4320.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Q2diZ2ZsMFVVdVp0ZUdrbHlkMXZadVVCeWVXV3JRajBobGpqOS9SNVBQNzVU?=
 =?utf-8?B?ZDMwd0ZRbURIY0VoRXdHQmFkR2FKQWh5eVRndEp2OXh2ZEg3NUxXaU8rcC83?=
 =?utf-8?B?SEk2RjBHS1VXK2x3M1M0Znl0dGdjLzFGakNUR3RoT1BTZHh0c2RRSUcxMjQr?=
 =?utf-8?B?YTk2dzBiVnNsYUl2SEE1TFJnV1FvOUp0MzJBUEsxWU5CYXluK2d4L1pNZlJu?=
 =?utf-8?B?SHF2ZnR4clU0RVNtT0NRZUk1S2NLUUJNdjBaSnBFdGwzcHRLQVBwdU1ieVhs?=
 =?utf-8?B?LzViR1R4azhpbDdjcFRiSXRwajZoc0lIUVAwT1JLekdEYzhhU3pVUVRYbXk4?=
 =?utf-8?B?ZjNJMXBUeStYM0lvQk00QmZVNStlTktkMFU4R28rNzI5Ny9IUWk4eXRVVEk4?=
 =?utf-8?B?RDFvRU4yeXRyL2hOYktBUkhKeDdHRU1ERjNzNEdmVnVyU1R0Rzh4bE9RN2Vq?=
 =?utf-8?B?NG15Mmk2YzR2eXR2M0JCMmIxd0ZlUVhpRFpJZVZOYm9KUS9OY0pGcWlMZGpN?=
 =?utf-8?B?emc0TDdlcFNxbDhjR2Z6RDgrQlU0OFFtQ0ExcjhHRDZyNngrenVuLzZJdWhB?=
 =?utf-8?B?ZGIwZjE3U2VLUExNQ0puSnFKUnR5anpQc0hMMitsb1BQeWFZcXNlbGtpMVBX?=
 =?utf-8?B?d2hpSlhWbzljeUhFeHV3RGdXRDB0NG1rWVNQaXZDV2dESW5lUkZ4bTdMNkxs?=
 =?utf-8?B?ZFdOZkgvSzZHRHBNR1BMK3d3QlB3bDhRWC90RjJxQW03ZTJHRW0wSEcyM1hK?=
 =?utf-8?B?bTVRa2RvUXdZZE83UnBCZGYvK1AwejAwQVhmdk9iemkvelBUTGo0WXNWTGVr?=
 =?utf-8?B?bzhKTm1mMDdrYUx0bXNDNHRYTVd1VnRNbDhLRk16S1B6MU5sM29VT2VGZFVy?=
 =?utf-8?B?b0JRS0xPSnVwUGRUam1wRVovOXlDVUk5Sm1TQlRONGFQdG5wcGxCcWU2QldF?=
 =?utf-8?B?SkhQaGRvWFlWQk5xYnpIMStpYm1Vd3lsT3d3c3loYjBIM2phZGhESUpmMFA4?=
 =?utf-8?B?TzQzUFFpSzdxRVY5NzFHR0N2N0l4YVdvdmxBcTBPVlBtTzhBVHBxOVpjZldt?=
 =?utf-8?B?NlQzZmoxK2tUS2Y4Nno5TFcwanFyZHkzaGxmUmRYY3M3N3VqRExwenNxOTJI?=
 =?utf-8?B?b2dvM3BEQ2lSczJUd01CbFFQaDNSTmR1TkxxOFpYRU5xYmppcGk2SmZYZU5x?=
 =?utf-8?B?UG55Y0dKWE1TY3ZJM0x4M1NEeDlkbWhWWVowNG1EREYvbXpydjRmK0JRajE3?=
 =?utf-8?B?UHpIZk9BaXE1b1I5SVozU0huOVNqNDlURDdDQ2tEcWd5QnYvSFI2U0dhdmdF?=
 =?utf-8?B?M2xpRTlVa0NLb3FvUGdlYjVhdEJjTTc2anppVG8zT1pJQlZRaHV3MWZ6ckZC?=
 =?utf-8?B?bGZORDMzUkRtMkdQUXFJRGFJd2pCTmx4R2I5ejVzb2Zka2IvbnVhb3Y2MDB1?=
 =?utf-8?B?Yk9PeVJodHJKeERYVUxKYm5lVldkYnpKZU90ZThBZTE4MDZtbjhuOForL2lD?=
 =?utf-8?B?UEpsSlNMbWV4cWJiQWdhUmxzTUpHSzFocElDMWM2dEJ2b2UrSXo1SUhGeURW?=
 =?utf-8?B?Ykx5cFBRSlo4cVpBblZGekR0R3lZNmYxRkgyRkR3azJnbXlZUGs1cXhONS9o?=
 =?utf-8?B?OEJBM1Y5R1VzWkVnUG1OS1RFakorcmxjT1daVFlmdGwzNis4RktLKzhYVUpn?=
 =?utf-8?B?eDJOV0N1N3ZCY2RUSURVSnk5Q24ySG44eTNkZzZoYlVYTkthTy9jbERPbUYv?=
 =?utf-8?B?MjVndnVMUHhjbGhITTE5b0JQaVNpNlRUK2JlVUh5THdEdlZYeGYxbFlUdWRU?=
 =?utf-8?B?WERxN1ZpcXlNU1VJWnNab2h1YUdCMExBUXg0M1lBV1BUSWNYVGVGZU9TTFN2?=
 =?utf-8?B?cU5lUXF5OFU0TXdnZ1VoenpLOXJIRU5aSUdoMXIxaUVEditUby9oRnFxNU13?=
 =?utf-8?B?cXVKK1IzeERiTFdla1ZUT3BpOEZYTzBCbkIvTmQ1aUlJZkJoREc0R1Z1OWxp?=
 =?utf-8?B?ZWZJMWdBSHRaTVl5NmYzT0NjY3ZxUm9vQ0w5c0F3T2lZZHVETEFpUmdCRnpY?=
 =?utf-8?B?SjYwSEtqV1NHUGRvK0FQdEphN3ZMMEdDcHRCMTlqdVVTd0FDakRhTnBBQnJs?=
 =?utf-8?B?ZFNmd21TV05CdTgwUm5ZV2llZmpOeU9lZEVoc1BUa3RxRHBUODRmSlhTSlI4?=
 =?utf-8?B?S3c9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	VoPsa3UPWXAS9jW7jV1Dpn+rEtIt3zx+VgMLRzWQpIL/my/+W1bFLM6Hlpk8x27bZyGewbaaebVZLysUCk7NOsDk5ik7PMnrRRU0brAocsC1oByJ6KbokCMw2VB2LKdDhl1xaYtVgvkG1FaDd2G/xQme9LkeDuiqCgE8ECLvoeu5jBFHRYbNcCtY5cJgr4dUtWyaw9JEj8lJ92LgtPGx6qmWZ6eoXG6ZnZRLbYeiwoyjs8ZP2vzrsS2v/MGnLSJ1tvb6ANx/OZQ4X8L5wEmSuxuyXTMd/yj+avuNfOu6YlfLj7PK5FO2UNdhohOJrOYvqUxaC0bNsTNZqdkfp1Stza9ZjKID/1Ej4+YUtr7bq2tUBzcU0s/FpAfaICJ/hGaPNxq8tNLwjXs5bb6zkhiZKYPw1nNxgsUwMfe+BaUS13IIqVuJzov9K5NWYT1jZQiO0hAB517UH+oQbAie6YSCyJ1DC1cl48Dm9/AtIR/d9G89F25wQfFOju9b2jLGNM/gaQt4JSyaCP06XKirPeODj9fOSNsLG85lBB4xr4trAf9xmauS/OPinLTrtUVvhSrMsITURu14yvmCJOgV7X03GYu2rTmzzgDksI2qOEJz0nM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c63b5884-cae4-4679-8160-08ddcaa2a165
X-MS-Exchange-CrossTenant-AuthSource: CH2PR10MB4312.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2025 11:10:00.5051
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +H5iMkxKlD3vklVG3Hp2eTpHZ0RZ4t1IBGhxf6xGN9Ssj5hxIR4g7OlS0pKLs3gVKgWo1NkeF0mHIhL0izIA0Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4506
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-24_01,2025-07-24_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0
 mlxlogscore=999 bulkscore=0 adultscore=0 suspectscore=0 mlxscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2505160000 definitions=main-2507240083
X-Proofpoint-ORIG-GUID: yrwY56mQLfyXuWwHE5dwBD2yJRo5ALeO
X-Authority-Analysis: v=2.4 cv=YY+95xRf c=1 sm=1 tr=0 ts=68821492 b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10
 a=gGqNo6gaPz8CTT5gL7MA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: yrwY56mQLfyXuWwHE5dwBD2yJRo5ALeO
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzI0MDA4NCBTYWx0ZWRfXxS1oeLkf1vLZ
 IlNdhMvtseSEfvHR/1y4tThK4L8oZa00xg64Hi+JWgakjuvNK8yxZVyCvEkLp8SvrPOm9NeAmdB
 /xvMcvydmAafCioBvdwxWdON9+t6wnr8LnAimKC9cRWdHbWEtx5a14pv2QPr7hH3LZx21Y4bEpi
 xeft9lw52YXHcroP8KNrJCqQCFgGMtHZDjCrJXBNB/7YvvXr7VtgGuaFEoML9GdRbNaIj1vJjqO
 j3K5YVMA9dlBeq8hr5pxcuhui9N1/uOBFrQqsi/P5tqwAd5Q6KVUh2DDr6KoE4leaa1Cic5bI8q
 Qp0Z3o2UKdXgsY/6GiCdJEhu6RluFacsN/V1aTkVjsdRL2HU62lIaNtTwWomjM0mztaLZ6wY3cM
 CEjX+krvqYZz/m6dnwIhhJ5b0rC5p2Lkbhx1lEpTJ+lHZ4dxzpiHisy0z7vlyOcTH1HI7Qkf

On 24/07/2025 12:04, Hannes Reinecke wrote:
> On 7/24/25 12:06, John Garry wrote:
>> On 22/07/2025 11:26, John Garry wrote:
>>> The merging/splitting code and other queue limits checking depends on 
>>> the
>>> physical block size being a power-of-2, so enforce it.
>>
>> JFYI, I have done an audit of all drivers setting physical_block_size 
>> queue limit. I have doubts on a couple, but it seems that NVMe may be 
>> the only driver which does not guarantee a power-of-2 physical block 
>> size - maybe I even am wrong about that.
>>
> While there are no real checks on the physical blocksize (all what
> matters to the block layer is the logical blocksize) I can't really
> see how a device can have a physical blocksize which is _not_ a
> multiple of the logical blocksize.

The logical block size must be a power-of-2 and we enforce that already. 
So checking the physical block size is a power-of-2 is a stronger check 
that just is it a multiple of the LBS.

> 
> Wouldn't that be a more meaningful check?

There is code in the queue limits checking and also merging/splitting 
code which relies on physical block size being a power-of-2, so that is 
why I wanted to enforce it.

Thanks,
John


