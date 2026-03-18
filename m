Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A954315C14F
	for <linux-block@vger.kernel.org>; Wed, 18 Mar 2026 01:22:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773796931; cv=fail; b=knkrvKlyGqrKgtODHxPFoj7ysK0Yc844tRfl9e49+ExYzg0r30uwMD/3Zy1jyoVUQIx0kKll+0z5g/SPzcH+JEaUExMra7yRyIJPMH3kJRv+vTpuKpPt6CvmeJ0lC4uFRCgjoz7yIEU47JL0oGdJ39cxZU+37RsQvVxeBEYxOSM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773796931; c=relaxed/simple;
	bh=mzHPED6k4FIfAwmoKjFt86+3QMQ1/TkCLYEuwHFUupE=;
	h=To:Cc:Subject:From:In-Reply-To:Message-ID:References:Date:
	 Content-Type:MIME-Version; b=oilxGiFI0f6lidu27lsGP9BtsWXqCFxf/cgz7HXjWVA6H0d9oGh7jRHcIxauAM7/eaUXkNmWWvcP++BntkF4bZstdQPRMb5HXXTUKN2vewwM9RXZAuFsGGskzEvPS9sohnkpE2gQvwiJvWaGK2lyDxIujchNj84Wu9tLYlQ6jVI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Om0Qnbwe; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Gtmjhnke; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Om0Qnbwe";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Gtmjhnke"
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62HIuAtL316510;
	Wed, 18 Mar 2026 01:22:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=CjsJn/Glryk32m4W0s
	olozMTANAF/Ixu3A6mgkjWiK0=; b=Om0Qnbwe984I6DAVEEwop8zBqwM3bHuOwI
	NiXJbuhsZydKG41O/cwz7+SRwgQJ5BP53KYuvXu0KxUu9xlBKErYO9dHe9eKfOa9
	F9o5ogkaisjx21/JXhUkAbwnOBrTQc+1CRhupqWHq3VeAdr2/iSQVJdoc12LtiTd
	vAMY/dVVwcY5WocJxI+5wGJiyijmUkdY3diSRx0EeUVe3aneHF98wSa9ZijW+hW+
	XP+7AeHZeEf8MzmRPxgCRzEQlgeyt2m7GNe9IvoNBPcUry4h7Uzr+3Di5PNcqgaT
	lCHtiuQTJysf6CgIW0XneRx2n5AFL/pLLBLMmddMceZS4vVU9F5A==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4cvx8x5bda-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 18 Mar 2026 01:22:01 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 62I0Wo5i003327;
	Wed, 18 Mar 2026 01:22:01 GMT
Received: from sj2pr03cu001.outbound.protection.outlook.com (mail-westusazon11012045.outbound.protection.outlook.com [52.101.43.45])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4cvx4axj42-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 18 Mar 2026 01:22:01 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=m7ucGAPCh7n7a0Gyk0xGVd/kz1R6Be7iYs47FYs5K9XEZovxfu/00OlBqxoAYzGYs22ni0Crh1DncuH+OBIWFp6y9j0/+qFndyMues0O2QBAMDAaeh0jZKvycsnHdoeszxQMch4wAXBONqE+iUplu6OfkiFhd1fjZjfKakqvUi2d5XHEwkIxLkEskVisWc5ZgFuDowp0NtxCC1JwSmNDNsd24de4HoghWM8mLmyKti0yz/tIoM+WGefpBTXmH5tKYZC09qHKGcAYi6dMuf05ZS2q5Is5KWSSwa6DM9KzLXmxC8thVKYweZxGUz9HVWLVM7JTECEQY2v1IZd0zYr/0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CjsJn/Glryk32m4W0solozMTANAF/Ixu3A6mgkjWiK0=;
 b=JiXySbWXb97SBDVVpflFxPIulF2EY1jABKs/ioGCHSndVUMN1NPkmQuWFhyw/iljqgXdqdsr5CgkZn6BHmvYB2gneWbZdcANeK0yTQEgH2NGk64qtpHZePvTsquKwkU2HgMU0PYvn04aNJH4nip4Z671SnP8fNlUDlnBwEU/3dZuvuuVqBTkRL6GRSH+YEDdN86RL45d0VlYPY/v+sCi55hFRwklUUGFFwnQlcfkUds662tt60MjOt4uPL8cp3681dbO03JFZizYJ3sLnItGuP+gWmOt+G4DwTMX7t9TtbZxuIfaeIplyMGtWLQ4XJGXyqQL3whp1pLvIFHQ7D5LcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CjsJn/Glryk32m4W0solozMTANAF/Ixu3A6mgkjWiK0=;
 b=GtmjhnkeQTx+v44zekSbrk3tF0GojwJHBqCoSMFMwLiNHcDTi89QAe9QA1crCz2Pia0V6USkB5f49hZlN54qbw38+1hBMBOR6uNkcw6SKjTVSKsQoj/ZtnyAR+CzG/+7+EfVraK8bU9b/ITSg75GO7bgOa31quWO/v0C6zEWWTw=
Received: from CH0PR10MB5338.namprd10.prod.outlook.com (2603:10b6:610:cb::8)
 by MN0PR10MB5958.namprd10.prod.outlook.com (2603:10b6:208:3ce::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.19; Wed, 18 Mar
 2026 01:21:57 +0000
Received: from CH0PR10MB5338.namprd10.prod.outlook.com
 ([fe80::e525:dd71:b002:6ad5]) by CH0PR10MB5338.namprd10.prod.outlook.com
 ([fe80::e525:dd71:b002:6ad5%6]) with mapi id 15.20.9723.018; Wed, 18 Mar 2026
 01:21:57 +0000
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Subject: Re: bio allocation cleanups
From: "Martin K. Petersen" <martin.petersen@oracle.com>
In-Reply-To: <20260316161144.1607877-1-hch@lst.de> (Christoph Hellwig's
	message of "Mon, 16 Mar 2026 17:11:28 +0100")
Organization: Oracle Corporation
Message-ID: <yq1cy12nd9o.fsf@ca-mkp.ca.oracle.com>
References: <20260316161144.1607877-1-hch@lst.de>
Date: Tue, 17 Mar 2026 21:21:55 -0400
Content-Type: text/plain
X-ClientProxiedBy: YT3PR01CA0094.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:85::7) To CH0PR10MB5338.namprd10.prod.outlook.com
 (2603:10b6:610:cb::8)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR10MB5338:EE_|MN0PR10MB5958:EE_
X-MS-Office365-Filtering-Correlation-Id: ab2d18d0-fc20-4c15-2556-08de848cbec3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|366016|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	Nr3KxLKv4r1A89HjkIaJeaIk9b6xft1RnEOGv61eMy8NlcEla9YEBAPEHuymvRt0zcak4skAnH0HatL/W9DcS2mcdlAZBxa/yHgJCQHM9bQJfjVF3E3R2UFUGXqubEQ0YBr/9DGSWyMrDKs/T/dUp97vCfumNthFRqXc9OFsPpHUeOMFGKlkT8KIJNLdXvo5fWDkOFMyQhevmigTZHFAMYBE94ctz0f1V6QiPKZEEaLrZRDuygWjAj+jZWSubpi/EjPtKSE85SL0ZjtVEw6U7YOCelej7DOKcLOTzs9WuEGilVLXMODEGxxfFvo9CveYzbEmFPRQ9nKFTdBxWsRcV5CLdiGz1/QXEtuyZxpKiWe880dTk9+VMiduwgVILwmUnp7Sf//WD8Fl4InNkTOFq2PhAiNPTm24M6q4DAZ43yMGZ/QKpMS9hhhhCwd6StBuQg+hHdWnLSVoMDRvyYqh1+nt2e6NV/C4Uf+jd41DRlWbz//VAubult+aLFiy6eaQcINoRK4gMz1knjUn+fYEjPxQNmFIwl3cXYLk3vIYPqIA+RqYIrmozyeNGUwwRn4tzBxDREOjJiVUnlv1f8rACbItEWhn2Kbt7DEkShrxLnTx8oJmWYRw9fW9dNegeirHAiMMeXI8S2IZ+53qjcmYpBlJ+HC+/HhriGVCWiUkH7CE9A6MDMKuc/QDWzbDTqe77AX04P2srob9mlHKwpDGZez6vYICjgc6/LeFi5z7LP8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR10MB5338.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?uNLGfYbeObEH2rYiWboB4Y4j4TGJRABOwvDNP7OknvpGdrYHNHZT5nYKMtHs?=
 =?us-ascii?Q?g2ZpWYBdqVWriqkCnFxwSe0zmizGgTHqnU714DeCoaDuJBIlaB8sBbnNjivx?=
 =?us-ascii?Q?NNSU6Mwxg9Mw3hNl0TC1UXv/l9eX4q1Glx92jjFPUBfcaixdO0nvQBMnbk1i?=
 =?us-ascii?Q?DogYykJgLA81Lwg5/ejvGNfJVmw/hxBapPLBF9Cd3dIueLJjI5RaOo1EZxhJ?=
 =?us-ascii?Q?xEda+gjl3mK7u+ThjTJ2Ob8yU/19qQzRYF+aWxZG9ldL4jP1eRhqEC1VYp0M?=
 =?us-ascii?Q?Utu4bIIOo92C0CzbNYGOwHVTGNtHQ5OObKv0bfxHex0SBWt14JznkdBEFsT9?=
 =?us-ascii?Q?mbb/ASRhPvUO6hU7XJOndwLR5CFehuhQGp2bruAUHzg0jkwU+YnlHkY6GnN4?=
 =?us-ascii?Q?mEpN+FIsctc17VcbCuQaCfw3Db/BUErIeptZXZbi9FpF6b0oiDBVr8LQUZ+5?=
 =?us-ascii?Q?o7IaPGXRhSCa7mk3W9Ib+MR95GEXeFLvnBSjV8QQVp3eQ0tpQ8Tcc+RQTtj9?=
 =?us-ascii?Q?/VuGeu9/e888ADbCSl1vQJUblqoNzBgnomoUFOJsjvVQyiV0oaZkhvOtrSCW?=
 =?us-ascii?Q?ZNnyLCfWVtTVEqJIeOBmozqz1m2e9oBPII8a2XY1SITNY6IjGkGQdDu5UFZI?=
 =?us-ascii?Q?oJyE8vD/oPGaUO2O0Y4W5DbZ8jUycjbyBkuCtRr17oM350rX818Gk+af+Skw?=
 =?us-ascii?Q?VcPE3juQ8YnxWrSKJwhl4Dxk4tNsn/r+DufrK0yDVGSMvsG7l/gfoNid4vsR?=
 =?us-ascii?Q?lilmUWkXgt+fTjCU/4bJrCOk8JVMvLzlddWllni8xNNye7at60vaLtpicEfh?=
 =?us-ascii?Q?Boc+Dk3M64K7rHRjBA60vCadiqpc/iIDbR8/ezfXgOgBS9zVdAdoPHASndSR?=
 =?us-ascii?Q?ivTXjHTL2pdpbJrQLffxAe422HfI+HR08iP8e3NKbxWwCQU8vcrCYf64QmE3?=
 =?us-ascii?Q?XxVCx7YHVemegqurZxYMQPf3Qe4mUwOASqLlYEbK7Zuu3YZ5bcsWf9wn2dJG?=
 =?us-ascii?Q?cAFsmNgCFAjX7TDzUmEEHKSuodR6rzlpFw+4BQc32TqfFFBaVp6qTBGR2Ad5?=
 =?us-ascii?Q?KRCCONzFjMOvhFGaxRjw23wGj6DvAnfgj6Xb6DTfZsjzzDCSG3ATiATjYpIe?=
 =?us-ascii?Q?+d1PZkSsjE7QXquo/HhN5xGNQUawUwt6YzpN9xqejsSyK0kHsYz6coT78y1c?=
 =?us-ascii?Q?Jrg5A4QrH9HaxWpsKW4o6pbkjuyj48Z+x37WzRKtrJhnc12BBAvsgJciYqDc?=
 =?us-ascii?Q?Y09je2yeqPPcD3OGMQmUjb8Sd6H0XdD0bxBQRLxnWQGSoK3wo7DIifvrJ9b7?=
 =?us-ascii?Q?p3zX+AcBBRj6gwEATjk1i4qjZbvjeLnuu/BBnPD6SedE461HPoNWaqVViBEE?=
 =?us-ascii?Q?fIoqfA1nNPKPg4b7Zzyz863IQxQP1n1YqnrRU+4cBgJ5/H8jdFto3zxvv9Hj?=
 =?us-ascii?Q?BlgvBR4nPY3ws/GdPkkOCulHmp8NU/NSyoCOmH07XDThS1TC2c2lcWcxgRY2?=
 =?us-ascii?Q?saosgDrn9tUBPbj4bKzFQhMoz7HlTFqIUhzGAUI9pdhSbEvyX+ism/FWf3rY?=
 =?us-ascii?Q?iZeveQxhzMqlcY4HDR3k34LdstR1qUPRohFBBeGlicetHCuoXmugjiLh+u3g?=
 =?us-ascii?Q?mWQYb8kl3z2cvr7Os7JtQL2NUAOdmAn6oI5mVSDmiqxqNsU4dklSVYW/tSBI?=
 =?us-ascii?Q?xbvXxxzYiEnhiRovXTUY/adNGHr4mH+yahheJL4ztVlQJoeZXYysjFL+j0o0?=
 =?us-ascii?Q?YjYFVgv/1l7yPlx9Jsi7S3Io4ymOy7U=3D?=
X-Exchange-RoutingPolicyChecked:
	IkLp+61xYK5CjaH50DUqD8v2nZhWuZnCz86rzRW/qpOQhOPC1U5LSD/Wugath8y6tXvB5uSOJm6ETM0rQrml7g8tfysSTtAoDymqAkEwjAZX5px2CmddHmbJ2fhWHK99mQ9nRV1Kci9jc7CFbYbjrWRqjjDbLrqdSOm7MhNld3D1X0Y/m5TjnjeHrUkMxGSDyf+68Wr3SBtgNI8ZETuIoByTHnnvCbG1Pe51S95VuQMAs5mYRQSTfCWnWiJc0N1vhlc7mPLXM/RxNe589Mzgdmq/yEhL7hnA2H8TxlC7ukXJhTsrg2I3GTfWOrp0T/jq6SPw0oEoBe1he1mHTDQo0g==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	J+WBQDUhhdkIh8rQI0G1JEokJXqZD+AOPH6upoXgUh4nmjEQzjEqCPM9J0zbvE6PHhPdOo3xSBJG1NbhbSRERLFo2x8mUWrKaPR4rySf1dzMcoqc8qE3FyyhnvfHK266J6gvAU38VggRFlNkWm/qK6q0HROoJ53DKEc12WtwLr7fUrBy2jDsfP10n2ZpyY8yotkJHBiNhnOVM5ZunAV9+TTliIyHSrIodS5kZz+jh8/Seuii/eYhZvkF1Gtq21tvxa3mVsspgOzUw4VvAyykuiXUFVes9Kv1Haw+p/DsBV8nnGvIX5USHHlaPYqln1RFmd//lHOyhJAhVosq6BwkJINWkyLYZnHZClmx4J/EKVFoDOfp1N63PVd91QXhNsuMqSHlWwq/VEfVqLrou6qcifD0LE9Ahvg5EJZ535CAXdpC7WM1dsLvu/yo6QcfxjR08RaxDC6H9TS2CzyetNpj8kUFTAKJHaPjxgeAtDEQXiPqaYUmtLYdRVog+72aMp1dVMe+WDOqlHRclAcW2hVxE41evzxK/EMhDGzg5rsg302LuxhvlhOfYFDktFjz3XYyYRLpwq6yB0/vuPrHL+U5vTrcrkeATjgqzfydhOFacl0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ab2d18d0-fc20-4c15-2556-08de848cbec3
X-MS-Exchange-CrossTenant-AuthSource: CH0PR10MB5338.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2026 01:21:57.3340
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: R2seWvORxv8BQrdxQCuEGuWi2g3jm0k8HBlXbdXvfd4I257sRuSAXgLhj4HCDub6OXkCur++yQO1NTBITE/38HFnrkznPyVoqhAwHlH6OZw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR10MB5958
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-17_05,2026-03-17_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxlogscore=899
 adultscore=0 phishscore=0 malwarescore=0 suspectscore=0 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2603050001 definitions=main-2603180009
X-Proofpoint-GUID: jE_cXREbhn5-u0LcGP-1tvaJiq7L9MgT
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE4MDAwOSBTYWx0ZWRfX17xAk1qE+7Ik
 VdjAi91tD7L3MznyQlPSqxapeVLnQ51Fah6RK+2xOfX+3L8QQfT4lpco5c++2zbnKBUiltca5Hj
 nUhQW/Q3ptep9nLXS3dcq5w69ne8wMZprnkbZbHyjUS4U6AyvZqxwFF2ppuk1y1RtpqtmRTmewS
 wSYFHfqEN+iRO0gqco0eOhzjyGJcq26XafmK8a50UrqTqE+C3jN+SKQQ8f3gT7BU/wbqMSqAbFl
 P+B74fJTDBbOiW2AwnfPpi+75Hyiy6ESYScyFPajLsIK/MYJgVC+h8/cgZ2R4J5OFY5x1mnevma
 zIJuQL9yqqgnAPfQwqS/SNTMwLYytOmHrwt/G0FpDrha7RIjuSfG9sIYaefaYv7nCKLd76I44/X
 RbFCRVVgAemxBR9M4IPc7c2Zro3NnVwtPp8DVBmAIGxZLBNh1cL+m2hvGKY+n2MtTBju4A+fl99
 ptxzNixGx/ckJ1Wet/w==
X-Authority-Analysis: v=2.4 cv=dJmrWeZb c=1 sm=1 tr=0 ts=69b9fe39 cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=Yq5XynenixoA:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=RD47p0oAkeU5bO7t-o6f:22 a=yPCof4ZbAAAA:8 a=4WGPwHxStp6TzRB0RnQA:9
X-Proofpoint-ORIG-GUID: jE_cXREbhn5-u0LcGP-1tvaJiq7L9MgT


Christoph,

> I recently looked into a batch bio allocator for a project I'm working
> on, and notice how convoluted the bio allocator has become.
>
> This series unwinds it so that the the fast-path slab allocation is
> better separated from the mempool fallback, which reduces the code
> complexity a lot, and avoids indirect calls for common cases.

LGTM.

Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>

-- 
Martin K. Petersen
