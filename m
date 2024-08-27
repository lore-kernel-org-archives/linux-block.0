Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 848A114A90;
	Tue, 27 Aug 2024 08:41:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724748086; cv=fail; b=T+FLvomTnfGxeTVaez0+ZgasTPHqCvZilVrUBndxPW+TVDXUmJdbR6SM1HqW0pSjxsiKJOf/XI3CyAJIf2SrQOgilUKR0X5PeppyRcHhXIKGWGaDlwbGgE5z40S4HCh1cA4M3cCah+LW0lm2PSqT7xJSd9LsUEoMO7o1Qs1NCCU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724748086; c=relaxed/simple;
	bh=sHuHxLZUcC30B/myNYK24Hlx9MhvqTEgv27QWsQFxT0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=qfCeOYPueaHpXftyxDmJFh23aNGUXXB7iSA6C9APCYF5+kgIEqe9FcZg9RrtwNN5gcepcIYB9+r0fwkkaBQBk6OSjLZJpeiDNsUJYaqCDutUgBld4Bwadozmpp8qfLl5X1E5ltOVEU/K7pWlI6PDp4YdhdbFDZSba7QxFISMN2A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=I7cxu0LD; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=gukEzXP6; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="I7cxu0LD";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="gukEzXP6"
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47R5tnfD011812;
	Tue, 27 Aug 2024 08:41:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	message-id:date:subject:to:cc:references:from:in-reply-to
	:content-type:content-transfer-encoding:mime-version; s=
	corp-2023-11-20; bh=MOlEAJ7y5e/BUduskDzNjHO6oPaev33iIwBMwkg5IIo=; b=
	I7cxu0LDhLJ+yOrdFq/cW85apec+cOy6tkkQm+zPSiu8dgqDvACMISFKREnIWOwX
	TXgzaVi/B9hY/XeN5apLz5XjWANY7gENECWCBskkKH7TMO3Gx+4YVYlYPXbaKp+F
	sItbswhZzzlfSRRgypeihCsBuA3SwpcNjxzIV+NF7igHODAppMtV+kDFb+wbaNNv
	m+BXr/l0XrrND1yvbeZefyPU8K3jMkKLDKAsH0oYllDqPHwwN89O0ggRCp6DLzMX
	OJhgebD1YhONOSRqJOzr+H15TcbKFkRGvsC1EjPyTH1jVc18h6tAG+jcndc//aap
	sqPJOm2drtWnOmSGbdx3vQ==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 41782svyx9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 27 Aug 2024 08:41:04 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 47R8YC0h010469;
	Tue, 27 Aug 2024 08:41:04 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2168.outbound.protection.outlook.com [104.47.55.168])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 41894mnjns-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 27 Aug 2024 08:41:04 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CgsOmtXXgEMgpFCDlb9Ys4P7wojfNCgW6/OQ1LyEKuRKgwl/l85sUkJI6KK9AE6esSn470MaoU3c10S5DLCb5TlqA4Ryrrxsw+x2D22lIK7hT03wVuo6Gqx4jFE0VPdf2jCEw7OC6V+3PDuwPsRFbwKcir3WoQsk3V7wWjcVncmqn9/iC6W2zAP/EutW9YjdZysY/kt/UO9/yP0wYXNN85wPzQWtCKHBCWijhG+0ohbxouLEb7DUTzr6/JSWQzhnAedktRklZ4gjFnxPmtP3pZJF1mwMOZemU2Rb1UyQhzWrnhe+co3hxsFP6cpqPdxpjSOHaM+8KeqSkFNcnXCSlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MOlEAJ7y5e/BUduskDzNjHO6oPaev33iIwBMwkg5IIo=;
 b=TNPyND9ZXaLPc8AX0CHVZqy3XeaoImhzHuUPJNHimRoy0mgE609NVB1fQuwcqon81bbm8IEWoAHyi0J0Q8t+Vwnfwc0lp5JdsocH71dpZIdlkO9ZobnZltbQqy6+Hn5BI3UfrWfK/bkrxujxrMLJtl6rYi2AD9H3y12Kcak70NU1mPrNLrOg7wszcL1ejvMNpJGRZjnl4B08zALMXIMC02FY+FOuZncacYRz6VSoPN7jBE6M9kb2KUwc6c6/6OWL3NsbekSeBuqMRYdVkTlFRAb3BVFyTduqQVdWSwGPK0iKegmDydXBvgnOU9nYgP+MEtsfvf4ui7q132hAiQd7lQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MOlEAJ7y5e/BUduskDzNjHO6oPaev33iIwBMwkg5IIo=;
 b=gukEzXP6vcqHkXjUDp6qlXGxo7IDiJ1jX5uAG0btyRlg6mwfYgkjmSTtzVvVqz1Icv00fqkwyo8ZUIDWXXzVJqoVDz97emPIJm6lJwy/pAVPfTGUipjzJTLIJZXJejpQgb9xksTpyAD1wZiblKz44ZTOstVyNsD8nm+sXoxkkaI=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by SJ0PR10MB5787.namprd10.prod.outlook.com (2603:10b6:a03:3dd::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.14; Tue, 27 Aug
 2024 08:41:01 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%3]) with mapi id 15.20.7918.006; Tue, 27 Aug 2024
 08:41:01 +0000
Message-ID: <b9f2ae40-7c13-4d43-b97e-fe011688a14a@oracle.com>
Date: Tue, 27 Aug 2024 09:40:53 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCh v2] loop: Increase bsize variable from unsigned short to
 unsigned int
To: Li Wang <liwang@redhat.com>, linux-kernel@vger.kernel.org,
        linux-block@vger.kernel.org, axboe@kernel.dk, ltp@lists.linux.it
Cc: Stefan Hajnoczi <stefanha@redhat.com>,
        Damien Le Moal
 <dlemoal@kernel.org>,
        Jan Stancek <jstancek@redhat.com>
References: <20240827081757.37646-1-liwang@redhat.com>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20240827081757.37646-1-liwang@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR04CA0171.apcprd04.prod.outlook.com (2603:1096:4::33)
 To DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|SJ0PR10MB5787:EE_
X-MS-Office365-Filtering-Correlation-Id: b2b626f4-cb36-4ab9-656f-08dcc673faeb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?YUIwOW9iQzEva2tHdkFRQzQ5Qk81ek45UWozOU1uTkFFRTI2MDVLQmJPQ3lB?=
 =?utf-8?B?eDVPQi9YaXBtWVdJeUY0TVQ4VncycTJQYkxWbGtXWDlYVnpFMHRFZlU5UjdR?=
 =?utf-8?B?dlVWWDhjY0V0dFB3RUYyRVBZY2liVGNBcWRXNjI2c0RUdVV5Z0diOVo0UFZO?=
 =?utf-8?B?TFJvbUFzdkoyWjQ3cThteFpHRzFBZ1AvbmxWZE4wNjJVd3MwT0dmbVlaV2lS?=
 =?utf-8?B?UHZtV3FOd2dUQ1pvZGJFVzlPbXVySmlPaHJLOVh6L1N5MzVsR1Z4K2dodlNX?=
 =?utf-8?B?WmhaTmIxeTFQdFRzenRDTjRkQ3pwR1ZBeG9YbTh3WExQbWVVNjU2ZFY2ajhs?=
 =?utf-8?B?d3QrTmZKWHdNUlQrMGtNdlFjbUdOOC9URXl2OGFIdnBIZ0cvc1JTMk04T1o2?=
 =?utf-8?B?ZUprMi9UVkxTK210ZmwrOVJhYlZjSnZiTWpPUFljRGdjSkZtdzZucHJEQkhI?=
 =?utf-8?B?cldwSG51Ti90ZnZNQmdJUmVoWTVHMHFDYkNEZGF5Z0tDeDNFalpCTG4vdG9R?=
 =?utf-8?B?M0VLUkszU3VUOWxMc204WnJNOG9KNFhIRGNuMjNSeDIxWElzRHlEeHJsTDVE?=
 =?utf-8?B?NEZIZkpHRGpySXhnNldrTXpoYS9RSUgzVVBSTWdNT25JTE9Pa2lmaXNGY20z?=
 =?utf-8?B?N1Qxak0yZkZ5ak9GWVIyRnRpendEbnZKVWJJT0lQaHpCdGRhM1I1U0NpWUQ1?=
 =?utf-8?B?bTFaSmtNSjI5eTZxa2JhTVVoK3REYlJrdnRNTHVhN0ZGcjJidncvUjc5Sjd5?=
 =?utf-8?B?TG02SWpENHpxVUF6anlLclhwMEZGNlJISnZ1azVPNVMxa3hOZEFoT0EwM1R0?=
 =?utf-8?B?Y1FOcER1Z2kvcE1OS0lHcEluY041eXdVUzNLV1d4YVpHWllEMUZZd2pFZjZi?=
 =?utf-8?B?NGxad2l2QUNCUEVZTnl1MUREQ3JJQkNHSit0ZllDQStTdGk1TmhDa0VjRkpj?=
 =?utf-8?B?aDlKbDZ6d05MWGVzY3dBV25qbExZQVZ4OHRtNmtMTzRRSEpZOXd5QzZSWG5r?=
 =?utf-8?B?ZXdRc0lPNmpnZ0pGeURJOFg2eUEwZFNMMm5Md25yMVdpM2NsaktDZjJSTkRm?=
 =?utf-8?B?Rzd1MnNqRmpuN0E4YUhUVVArcmNBNDkrQ3luUEppOFhMRG9BZzl6WGh3MGFi?=
 =?utf-8?B?SE5YWnJ0ckg5Uzhzb1Excjl3ZkZpUUYwMGxnaVE2Ykpackp0ZktPbEdWVjV6?=
 =?utf-8?B?aERhWDJlbEl6ZUU3RXRYL01kc20vam01ejE4VzVHR1hsbHNlRkZQd09vOHVa?=
 =?utf-8?B?VWQ5ZU9UTTZqcVZlV25YRmo1RlFoN2VNbFR3bFN2aW1FMGtRcEZKbmZwNEhH?=
 =?utf-8?B?cTZ4MkVFUFkzVU1nRzVSY3ZUSjExdEhoclkxRER1NUxXMjc5UUllbFgwd2ZW?=
 =?utf-8?B?N05HWlkwT3Q0TzZYQnFWdlFObmtWMVcySit5OCtYV01RSGxnT0hxSFN0eHZn?=
 =?utf-8?B?TEFjNlZaeHZ1UmdVTXNiRjlvazlaZ1o0M1M0cjFtejhnSlhYKzFjZGQ4SEUz?=
 =?utf-8?B?a3RFRzVWV1RzbEZHdnV5L0NId285bEtSUFFwMnM4dHp5YkZVLzVUMkdyemIr?=
 =?utf-8?B?Qk9vbi92OFFsWkxjRzBBckgxVWZjRVZlcW9yOWhINVhjM0hGQnBmdXhmZ0xF?=
 =?utf-8?B?T0J6VWxFSzBCeGp0eE8rbUw1WjZNQnhPdEFNdW1paEw5ZnR6MEdRaHA5V2ZO?=
 =?utf-8?B?cFF0cWtnRFh1ZWlRQ1dTYXE1Z3o2c3lyazUrOGh1eWtPRWRzcG1qbTRVZFNN?=
 =?utf-8?Q?XtRn4j0BiiPS3zKD4s=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RHB1Mk90NUExOW9iaVpsYVJwSVFMSkhoUVYraG5tdEwremNoN3RZd3J4SXZB?=
 =?utf-8?B?MFBKc1ZRK1I3SjhjRG5ndEUwME9iT01iQkRoTFdzN0tMSDFBZG9ISjFLM095?=
 =?utf-8?B?RUtxZmwxUlpDdUc1M2NpK0NIQ1hMdGlRK2sydjJQVE9zOUJORXRqSklmN0ZO?=
 =?utf-8?B?Y2NlT0lzcGQ1VUMvazBySDZ2ZnlSUk1lci85a1hBT3AwcUtyY1ljR1pTcTRk?=
 =?utf-8?B?OHpsUGMrbmxnTytwalJ0K0dJLzBaMEhQUlYzcmRYRm12TW10V2JqcTRXdGYr?=
 =?utf-8?B?clZobEg5MENCeWs0dXNEQUQxSmhwbVlBREkxeG52UWw1OUVLRzRiMGx3SE82?=
 =?utf-8?B?eTZ5ZHNPajZGaFJGZ3ZIeFc3bTlJYVlmODl0dFA4aThRdjF2ZUNxbFhzWnJ0?=
 =?utf-8?B?aTk1ekF3aXRGWUFZZ28zRHI1WDFDUzJEdk9yZ09ydFlrbjdhSXZUTmRDNkxn?=
 =?utf-8?B?S3pRTVg1NHRJbkd4VnhKOHV3SzVEOXBZa1JKSXZ6R0ZkY2s5L0gvUmFPZGtZ?=
 =?utf-8?B?cXhCT25iUmFiZ1k3Q3VEUlVnUUhIaHRjUjdIdG5Ob3RzNnpnN2VDcEdxaWZH?=
 =?utf-8?B?N3RsVkVrcUhEQUVKSmptTzBYUjdINWpZTEJiY0UwNXNOTWgxNmdyYlJJNjQ5?=
 =?utf-8?B?QXp1d1VyK3JDejlRNy9CeXFYdGRpYitjY2ZXRnp0QlUzLzJyV2tIbXM4QXcv?=
 =?utf-8?B?cGVMZ0xhWEJkWUhyVkc4dSs0aDBoZk1URTVQQ2xLMm1XNlNiMFEyZXpRL0JH?=
 =?utf-8?B?Y2xEaVJ6ZEhHOGNOR215SEZySjJMYXZ0SWZRTm5sRGFyZ1BXRStjQnJxdlNC?=
 =?utf-8?B?WkJLRDJwbU4zZENqYWM2eDRqWGdGdkowdTQ5ZHpwRE9ETW94TkZtZ2lJWEdj?=
 =?utf-8?B?aHZucDVnSVBYRUFwbmtNcXJYTzJNSTBtUEZGTk5EMnlBQ2RiVGt5UU55U21Z?=
 =?utf-8?B?NFcrSlZUckF5S2d2ZEx2OWE3WElCK0N2YTl4WFBOQVRzTHV3MFhndENYUVNE?=
 =?utf-8?B?WDBQSjBpdW9LTGFlbFNFT3ZLbVFRYmZWYVgrNXdBaFgrbW4zUHM1Qkp6MGF4?=
 =?utf-8?B?bjdHN1NZMXhDdXdoSkpVYzBaUXVBVldtN1JlbS9PUXRCSm5ZYzA5cGFCLys3?=
 =?utf-8?B?QXNMM3BQbDkrSTNGdkRabjU2UzRVQ1pESjNzaDVaeFVOUUQ4dkdNVXlCWG1Y?=
 =?utf-8?B?bG82dVVwNGVONDl6dEpWZ2hGdGJPUkpUZWVZNlFBekdlNjdNRjZhTE5XZEFX?=
 =?utf-8?B?ZUtkeGlwMnREaFc5ajFCMnozQ3l3TU9zQlA5TDFsc05Ea2d0U3RFZEdYR1Ex?=
 =?utf-8?B?SXhWTmpja3R1bnZSWkxlZGE4S3hvYTVveTZKUVU3K2VSVzQzdXVIOWZIeUx6?=
 =?utf-8?B?cmdoajdaMU1EM2N0eFJ5RVk3KzdpN2p6WFBDZkY2QlRtZWcwYyt6dHNaRm1k?=
 =?utf-8?B?d2cxR1lCR1piWHpvSmRFTEticTViWmJTZ0psakgrNkdhRVBNOE93aTRDd1li?=
 =?utf-8?B?aUxEVkMrSGdMQXdCL0lrS1Jkd291b1BDSmY5NVRKNXAvQnVlU0RLREROYnFw?=
 =?utf-8?B?VGMyVmx5VTVGeFJhbWJJT0c3UUIwZ2I0WTlDNW8rRzJjeTU0cmpQUVM4Mlkr?=
 =?utf-8?B?b1hWUjcxLzJzR0RNSW5YaUNRSE5KQVhaNnhZcVZrcXM0Q1RTNHBkL3NHbi9n?=
 =?utf-8?B?bEE1Q1dyTGpNZmxMLzlPZ1FyRGhvQ2ZaeFZ3UFVKZzlEZUs2bVhlNThKbG5V?=
 =?utf-8?B?dTlaNk1TajlhVDBNN2JVUEU2NUpGem9FUG5FK0ZSWHVvdGo3aW5wRFk2SjNX?=
 =?utf-8?B?WEFVcGJDTGVKdW5LUGpmdlQ4aDJOUm9XdEFrK2NsbzExcVNsZ0tBbm9BUjRa?=
 =?utf-8?B?dGxLNm93Z3hKR25jVnN0RGVDMWZqdDdiWjc1ZDA2aVNOaWN0MlZuNmtFU2xh?=
 =?utf-8?B?SzgyUkpWVys1RXd5YUEwT2cwWkxNTjVxckFmblhMb0lzS2FLSTROajhhSm1K?=
 =?utf-8?B?dUZZRnRXWCtBQ0gzV1hncmluYTNzYjVJM2RySUZaMENmU0QrbXpBVVJOTFh6?=
 =?utf-8?B?Qythc0FWbWF5SXhBcENleGF1RHNlT0dPc3ZSYkpaUkZwcXlwNmxUNUlqcmFs?=
 =?utf-8?Q?QU+B9v0OtlTGpRRVUSM8iH9L2?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	rgbidVAVNEXmY52DUnxFQmBxFgCNGplFybc26E29Ogy+d7xiwP6ByMJ/C/bH/lMfHznKDEKA0wEX0WtSu6wkjjtFc+qoyc8fRq+riDDbl6SFAmH46ASuXB4Bq/I/puF73PX8CuxlmvQN66n4nDXiI8zv/N+jaub/HW+WZG82GU/23SoETO+C6Avb/JDxYFXGTuBiAQziXabWAY917KrA0YrXLLy1DEa0T/xYFe6YWRJA0gDItx/p4IKqGGBh/KYq2H2VAepSkc5A6aSaLPpt7eoMFDueuxZ2vG4E/ZuYrkRKJbAfeznueJXrJGE5FXWY6xcglqq7z3mkQvxNOZ3XtXEIq9LevUjRxAH4fpr4+rlbslr6bj5E0QHH3KrzSb/9+bDJkpR9hzcP/ptX4udUYx2akRxIXVi7UxJ6qgOuIjSOwBaA4jXPpdAL5MAB99FZeWMCtuqMCtU6TK1rBCR5hOZrnp6QsIb3ewGOOQx+s2wSUZvKk3c4BgCUNtdv18MSOsbGUqPRoGMKXzm9gk4Wb/QXgXMWI7d7gZP/VwvHtu2IH7Z9ppQrqzuRnxQgF/GKhSKcv4+9s1I5jlDbPvW5mYlqdY+Az0WqpT7hoNcAzUg=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b2b626f4-cb36-4ab9-656f-08dcc673faeb
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2024 08:41:01.6165
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EiJLX2prRqHO30I/+xY8F6TVL4WPi3sTT0n2ZfIYSjMKIbKv8KcJ3f3I7p+Niv7YuuUxzXn22rJ/nQ61sQV+jg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5787
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-27_05,2024-08-26_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 malwarescore=0 spamscore=0
 mlxlogscore=999 adultscore=0 suspectscore=0 phishscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2407110000
 definitions=main-2408270064
X-Proofpoint-GUID: mjNqUpDXsQuuwLLXuHVSs-uTLcTh-BpV
X-Proofpoint-ORIG-GUID: mjNqUpDXsQuuwLLXuHVSs-uTLcTh-BpV

On 27/08/2024 09:17, Li Wang wrote:
> This change allows the loopback driver to handle block size larger than
> PAGE_SIZE and increases the consistency of data types used within the driver.
> Especially to match the struct queue_limits.logical_block_size type.
> 
> Also, this is to get rid of the LTP/ioctl_loop06 test failure:
> 
>    12 ioctl_loop06.c:76: TINFO: Using LOOP_SET_BLOCK_SIZE with arg > PAGE_SIZE
>    13 ioctl_loop06.c:59: TFAIL: Set block size succeed unexpectedly
>    ...
>    18 ioctl_loop06.c:76: TINFO: Using LOOP_CONFIGURE with block_size > PAGE_SIZE
>    19 ioctl_loop06.c:59: TFAIL: Set block size succeed unexpectedly
> 
> Thoese fail due to the loop_reconfigure_limits() cast bsize to 'unsined short'

these

> that never gets an expected error when testing invalid logical block size,
> which was just exposed since 6.11-rc1 introduced patches:
> 
>    commit 9423c653fe61 ("loop: Don't bother validating blocksize")
>    commit fe3d508ba95b ("block: Validate logical block size in blk_validate_limits()")

Maybe it's better to add a fixes tag for original commit which 
introduced unsigned short usage.

> 
> Link:https://urldefense.com/v3/__https://lists.linux.it/pipermail/ltp/2024- 
> August/039912.html__;!!ACWV5N9M2RV99hQ! 
> MxW7Cvs_YKyihvENQFEGgHt-1KbCFD9gkUJxwI8gguQlawan3UNneBoB_THVG4zNP8Sao2a0apcOu03lcg$ 
> Signed-off-by: Li Wang<liwang@redhat.com>
> Cc: John Garry<john.g.garry@oracle.com>
> Cc: Jens Axboe<axboe@kernel.dk>
> Cc: Stefan Hajnoczi<stefanha@redhat.com>
> Reviewed-by: Damien Le Moal<dlemoal@kernel.org>
> Reviewed-by: Jan Stancek<jstancek@redhat.com>


Reviewed-by: John Garry <john.g.garry@oracle.com>
