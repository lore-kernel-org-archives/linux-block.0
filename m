Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 082461B3747
	for <linux-block@vger.kernel.org>; Thu, 15 Aug 2024 15:41:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723736516; cv=fail; b=X+BdUumBodcdsivXfeXFy/pMbPNwLypbuuyEklp9SfbwOdvnzVvejfLnQZqxonyP13KVAIxPUk9CKGaKaOhrZND5Q/mdMv0ALwl+Pzct/bdIWb5NYpAkGjWgYPKB3ZHjrsA5f0+YL8F+NHDWLuHreusOlnDIeYMu7v2iF2B1mXQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723736516; c=relaxed/simple;
	bh=GW8HvrU9hMM6wPWmnjv+U0mgGk0pdkDGE8lv4jYymf4=;
	h=To:Cc:Subject:From:In-Reply-To:Message-ID:References:Date:
	 Content-Type:MIME-Version; b=p1x5QmAydi1TTu0l2lgrn2xlezJV2D/hAIK2ShhmrSjz7w7HgpCTv71mmplLd0Ik+R0V8au71VXY79sVGytIjWs1jHU80HeN4r760qwSlVH2EyWAybYH2bGT+zVCQIc5qt9Ke8ifa0ACmFWOP1KhJsN+FwcbMyeY4Lyg8JNcVxE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=K+NAhfAw; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=pBPc6+lD; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="K+NAhfAw";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="pBPc6+lD"
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47FEtTZK014055;
	Thu, 15 Aug 2024 15:41:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to
	:cc:subject:from:in-reply-to:message-id:references:date
	:content-type:mime-version; s=corp-2023-11-20; bh=zeNGR7oNAeJDE6
	XBWUaUnqc6ehn59oXwgWmgbD4Os3w=; b=K+NAhfAwNCnkfYxX5VgER8ut6TgQa6
	0SuEg6YKMQX2nJoRE8vNZMuByyrNXR03M6AkyRejaOO8fjhifcdQrhD7VcTTnCu+
	Rp79U5LCYFwVlilA6zgvjUIYOV1qMOmGTT+SELvVdqPbKqYjm8y80AzQDPjP+DMm
	416abmU0J/1jxE+nMDkEoldHk6G7MIPLqL01ORnSUYwDVeU4862XKCgjcD/JGd3L
	Wx7tS6iwtB7BjvAab2+XOdAzf24ukug1spEopMp8pKGg1rzw7iYwc7HVm8bY1TzJ
	kJTXCfYEwZwDvhBHs9g2pXrvLfFyDTmCAcYbbuCmymHqnHaGgj1P9s9Q==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4104ganfhg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 15 Aug 2024 15:41:48 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 47FFGEtm017731;
	Thu, 15 Aug 2024 15:41:47 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2172.outbound.protection.outlook.com [104.47.57.172])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 40wxncacgu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 15 Aug 2024 15:41:47 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=G7LMw+n42BDlGuZPf+LrZ5dq9rKP0Ua3K4t8dtC6ZQxIjIV2AKiI8EvR3Ula14H8FcoOnleU8Ph1rVjTsIRxCkK0WvflahUjKpnJAgRkAfrrot2zlx88YjGyQuaLbKUNcSIHGc8l+unDj9Va2CYMoYdWR4BabacR3s1Ka94LpnIabtGlLbUq2MRbaTanplUSesRY3BbAWisAoJSRIQ6AXVxF02yFNOQAu8BJ9XiPm1wgFCQEqLxOanyV3pVQvDkzm3hBwaxXzDgFgUuDafhzvQB+hU+EoZLH3cvHHGWORo3jcoIGAz0jHmHeAjWHVud2rORaiRexXH2N9qe0yJ9E7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zeNGR7oNAeJDE6XBWUaUnqc6ehn59oXwgWmgbD4Os3w=;
 b=IlFdyNYJcJtiYU5/4902c/McIPvtTxV5QTzJNyzgIbDgCxNsOyjnpUBr2qKwC8V8w1UdmFwfcIhsp52ls/EzTDJLLu4wARPcg4iwd4Xm0gC61A8XmYgPVkIwwW7pHOvkVRLDUyWcd93bCSdYYBujtv0S4tG3gBV0fcpiMHKBe1eeBChP7UXGvx7pcsJPpLR4zsaYIs43e2PvvVaKtDg282Dwmq9HEtigLS7+JREk5ovKjkSPwh18vl0tIux9xL1B292SSu08XpyNtu52ZVIJw15iLr3pD98MOHJzuVEoftDlubece9rsTrCU6zuDxIGV41QV0zPEChot+apkgkYISQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zeNGR7oNAeJDE6XBWUaUnqc6ehn59oXwgWmgbD4Os3w=;
 b=pBPc6+lDVhvb7tqOdtP0V1J1gxVOZRXegk+dbQrKve1SiucO1+kT7nk2ruZgf5jwu9ezsoO5ejNnMH2TCVCj8FHU6t9/xnvTNI/m1V6KdZtPj6E4SJ7UygN52yLvOxqQygRcxWojpOVkQXqGYDQwJBC6e2g6bOFqoDDFKHBKOnQ=
Received: from CO1PR10MB4754.namprd10.prod.outlook.com (2603:10b6:303:91::24)
 by DS7PR10MB6000.namprd10.prod.outlook.com (2603:10b6:8:9c::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.9; Thu, 15 Aug
 2024 15:41:45 +0000
Received: from CO1PR10MB4754.namprd10.prod.outlook.com
 ([fe80::7878:f42b:395e:aa6a]) by CO1PR10MB4754.namprd10.prod.outlook.com
 ([fe80::7878:f42b:395e:aa6a%7]) with mapi id 15.20.7875.016; Thu, 15 Aug 2024
 15:41:45 +0000
To: Christoph Hellwig <hch@lst.de>
Cc: John Garry <john.g.garry@oracle.com>, axboe@kernel.dk,
        martin.petersen@oracle.com, linux-block@vger.kernel.org,
        kbusch@kernel.org
Subject: Re: [PATCH 1/2] block: Read max write zeroes once for
 __blkdev_issue_write_zeroes()
From: "Martin K. Petersen" <martin.petersen@oracle.com>
In-Reply-To: <20240815152638.GA17618@lst.de> (Christoph Hellwig's message of
	"Thu, 15 Aug 2024 17:26:38 +0200")
Organization: Oracle Corporation
Message-ID: <yq1ttflsswf.fsf@ca-mkp.ca.oracle.com>
References: <20240815082755.105242-1-john.g.garry@oracle.com>
	<20240815082755.105242-2-john.g.garry@oracle.com>
	<20240815124047.GA7803@lst.de>
	<3275afad-cb94-4c8e-b70f-3a7e8bacd89b@oracle.com>
	<20240815152638.GA17618@lst.de>
Date: Thu, 15 Aug 2024 11:41:43 -0400
Content-Type: text/plain
X-ClientProxiedBy: BN9PR03CA0276.namprd03.prod.outlook.com
 (2603:10b6:408:f5::11) To CO1PR10MB4754.namprd10.prod.outlook.com
 (2603:10b6:303:91::24)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR10MB4754:EE_|DS7PR10MB6000:EE_
X-MS-Office365-Filtering-Correlation-Id: c1e0c195-20e6-481b-0478-08dcbd40c4a2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Dk96DNFAo97KQHLczSzr2YlVDlEHmJxPL6TtgfQzgSvF5VIiGa/sxLZWGH5I?=
 =?us-ascii?Q?iAKjRFUYhcrS2CNbDFkNxcqhBRPczO+lM4+trxGgADYhU8DJ0I0iEsepxjCO?=
 =?us-ascii?Q?8HBJDNOzuiGlRPCRSJUFTTwe+Eub5u7DnyBcHPu5dA1b9qzUxwyIkb38b7v3?=
 =?us-ascii?Q?kj5DJUj0Y7eAQfWFmPm9BL07YqVFgoaTEStEUEsYGx1tEG1IMqNGUdN4SLJr?=
 =?us-ascii?Q?PLJNzl+K3QsBlQlN0BJOlAMlJVK8w2/3Y2sxm7gXaS5Ta0jRKnVnHHdl0pIG?=
 =?us-ascii?Q?pycPWEQmlhB5hR+7ha6Ek11vtaaELeoe/tt71U4Rx++5OeRfHEW+gzY4rc+J?=
 =?us-ascii?Q?OlRCOXvL0SexBIkShxFQK43RzP2FMHj7ijeMNRCw3IGGeKvUpi3DQeYaX3Wr?=
 =?us-ascii?Q?/+KyLTtRMdPihvl0Vp1cUNJhS7Z7SAcOmk+3FljP0HseuaosLseC3ZKxI9ta?=
 =?us-ascii?Q?d4Zj3E4pPWiuBhvD1/8o8xHx4zYCyUeUH0qagcYFXcxIp9T7zazeFvAxtdnu?=
 =?us-ascii?Q?O6wSViSjC4vpzqzyZnEDj5PUmkJp37AQ+2/J3fEWJWDCNZpr/OLTq8iR+wKK?=
 =?us-ascii?Q?ebpIw3p+aYcGSVtjGJUVzBoLd4jRVdhmKQeQ6S6aoivj/YCxUgKLkLy3AGU7?=
 =?us-ascii?Q?2HY+w4GUwcp85WY3PDNn3HJXJr2pJF2kyXKExfb/RvtkbEu/l3xbte5DQ3e7?=
 =?us-ascii?Q?rTM5hbwAk+21KY2dVymbNPmNd5O+5AUmwyrCfqtI6VaU4TpP9kCx/2VEC9Vr?=
 =?us-ascii?Q?0t8zKBooy2sqiwaADHgDefrTOfuRR+Tog6YKxhJuT1LumVnk1DK6ypOlKiA/?=
 =?us-ascii?Q?PjCikU0CqPnY04G59LIm7ERWYkp/T2DSwFS2V/RapqRCk0LOhwTfGPrATZnS?=
 =?us-ascii?Q?8I66qToLIqzO2m3j679a8rOs+rb28ZYyNGfxIpmY9o55ExpLd9AjymmYS99D?=
 =?us-ascii?Q?wthrErGziieYHfKmhJq0V3nRTnCHl2tnbyOVf1CsJUfJS/VH4zLNCApq2caD?=
 =?us-ascii?Q?ojGkD+G1IV9Dcvs273CduhXlkTFMp6xRD3cNidRKlkDvkQpATT+oHRs8jXIf?=
 =?us-ascii?Q?GM2S22NlXSLrmIfSrEoG7Qh450duDx6ET+DtBHvH1G31YYrjDy/jDb0eNyLd?=
 =?us-ascii?Q?Z9XZljHNxXvpt5WuTh7TCg1UfW+0iglC2DUltVXefrIAfbyRpfHOaXr+6kg6?=
 =?us-ascii?Q?+18qsJgLHavBgv2/aRouH6NrusXxWhZe09l3O2EbtryomAlBG6ufrYLZTeCk?=
 =?us-ascii?Q?sgDas8EloDVDd3rExE/rPFjA/3mQdtluwyG8eYDshAYE79C6u1RbPANjjTK9?=
 =?us-ascii?Q?jPU0tW07eVMXcXijpef0qgO9WnKJ7e1TnMF5FIXrbw2hUA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4754.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?KLZF40Hy0bYKr99ofmwF0G7H5X8bmHHLCFVM+MDIeSsig/ISomKmIV3xAjH3?=
 =?us-ascii?Q?4nle0zXwyMtG500DuQI5WaVi9tg25OIeOt9oyhL+ipJdirE5k8bBOIHbJMw7?=
 =?us-ascii?Q?7lhem11M+0ZYNwDf6Hw6Dzhm50DdXso3RZ6+mdlKOJe4w7uAnR3QpzK9bqrD?=
 =?us-ascii?Q?fMKbDmRR+zY89Ml7Wc/38aT5RBWPa9T8EV8Q7Vgl+0hqspM2bnVxKlgvv2R4?=
 =?us-ascii?Q?GtiVzA4UiQa0ONcyerXrNNzjrPuKlcfirABl1EVadNhh1rEIrajhYJ2nFI/Q?=
 =?us-ascii?Q?cVreVhFZx43NKNzkSWrok8ps9ovtR1r0FibZY8T5BzcjHF8xZl3YZvZtYasS?=
 =?us-ascii?Q?ko4BVvi9mAAZ6HH4HIKBSQ8y/2XSklJlobBZKvXfhtY4T/fdtxMAcJUvyGq7?=
 =?us-ascii?Q?3UAo5pFXptS9HwtriftxVoJGWeupdEJ6hXMx7zm+AFvGgqnqk9xEdnCg9Gdp?=
 =?us-ascii?Q?0JiRXAfENZolf3BJjUEp2DN9dSKJoDEcb5N4FV3asCxL9ok/8PGCjvgGrRlh?=
 =?us-ascii?Q?qTfCjfIBwciwjan7CHKlzsVolKG492PMXx2y35FOdrB1cbVMVpyl03GREFPu?=
 =?us-ascii?Q?jNA9/ChsFKMJwVo2u/2Ak5v9CYioHdRNbx2/seblY49/8b+54zMZ8JiO2K7I?=
 =?us-ascii?Q?1v+PN+KKAuTST9VIW4gpLRUbdw5m277obpUlPhFkslSyncqNROVn2MNSzLnX?=
 =?us-ascii?Q?8mXoe/Uq22jHIhXoFYuX6D89KVMmGp4HB3lbOZJDJ2cRvSg6k9gCu0kvQ4IC?=
 =?us-ascii?Q?zXN3CX90zBNAokxyrhFOBIpsH3WgUQzcBEdV/FhpJXevI4tmLSlDMHbKXLlv?=
 =?us-ascii?Q?iz8ZaaCWfQS0H3Inc2vmdPJxyv8meNlD19hoXLYQ4oY1MCS54K5wJ2PzWhSA?=
 =?us-ascii?Q?pOxEOK3hEFiuLNEaRs5BeEqDLV9nnXNsymWOYe0T/Z0ujK/AsKyQDVi6+OY+?=
 =?us-ascii?Q?D/s476kw7T3H1WPIy32Z3SEuoRaRjf6zrj550jy3C44L7FIOrh0YEOAoSM4n?=
 =?us-ascii?Q?gCz+ma40qxm+edFmE4lUA3w6Ie3j3Ugg26fDezyx4ebC/ln5PYUf4afHDSiS?=
 =?us-ascii?Q?QmKuOMNthMU0gXXAjIAcqsw1fCgEU45OA8kJ98QSLLSobdxuM+O3AI9XG3an?=
 =?us-ascii?Q?Qu6X2SoL4rEKXFx7b9ioS8uKj7S8VqwvwWhmzvfEy4ySEtTK1SLN0U1p3rtF?=
 =?us-ascii?Q?M1zhT/peRiUfvAzqLgSi4omf3xvgWSgLEJ4zbSEIBsOZmH+FXJXLV/0wieuh?=
 =?us-ascii?Q?eAwABa025hLJkV5gzmEivarjM286dqkhSzkeTvgLQS1mkKwCkxdQZGwXxw73?=
 =?us-ascii?Q?q6qwaMIISCVJyuBSDtzYHXVq17Z2bCt2/tyEn0JXc7Lm4GpG2K0/WEGAKv+A?=
 =?us-ascii?Q?82AR4E1g6/t8vuo3wqkUqhoxNE3wgUo3BJSYDmXufiyn8uEFTV1HTjfT/I8w?=
 =?us-ascii?Q?wFPXsebqsF858+HSRoKx78bZ47RnfS3NtVVAeaSyyBKCQ7m5jVTBLNAWzpFJ?=
 =?us-ascii?Q?qc4soFNW5g6asf0LvJgbQzX0pGxEyW0bLEsdnHSgJqwEcE1FpsbujxtVUW3l?=
 =?us-ascii?Q?vP1uM5vzbv/n3AMSmNbNl4Wnf4yVpU+nnaw62pbrinOnEKPbqsZMujnl2znp?=
 =?us-ascii?Q?cw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	86QzO8COHUV356pQOI2KVvvl3cDkhmXxNoC1z/0e+z60WBu98oBaMcwRJZlYOXi3lGx0fnou3Y5+mEJCyTqQjEIAivptT/NAtN781v2SUqxnkVRHb4jbqWXE35bwbNfeQULyloUS2AsWlFMP05Cza/cscIzu6Wa7RsrT9uOUfpQQQLvRg++I/O9F9eimUPcAkRgDmzh+KT7uWJRl3xIa/+K6ZItJaaZGOW595/LghJUKmVledSaMTPH7nD1L6Y3wr0M5bkxZDQmZMz/1cuX9QjgApxuuPeO5dkLHWWyNyu427BuoZSDaed5itlApZCB8sRxxGCc6okDRR2G7oC1NEsOjmigri6vGHCin9JFrB6eHCvK4g5jGQRRNHzHuAohuAvHiNcltxSeUpUY1XTgpNUx+YSzW6XdWtoOC0OpDz1r8pbGBKXW71dW2a2UE99vyMQyHZOWziqN/5kUUiP9uXnLWWZzbjWcv94Oi97R3PQOuT0z/tq0oEEua4cNTPd2tzTX3wxZkr/HduVtQWY/ZB5gstHQ37kkoJck2+QYPWIMchJCO0wYeXNiQXO9jbj5GBcX3jX78KY5f94BNSJ/lebv26lgfH2b66V5XBrVglhQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c1e0c195-20e6-481b-0478-08dcbd40c4a2
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4754.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2024 15:41:45.5221
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eJAy+fVfse14Y2nqxNYLhsHf2ym6bI0lgpxPT7ZzUJi1+6HT7uIRx4v8BlxMPd10mZQxeOAEGM+dBz+lc7cBEhtPO71OPbdDYgC1JmrQ8rQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB6000
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-15_08,2024-08-15_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 adultscore=0 spamscore=0
 phishscore=0 malwarescore=0 suspectscore=0 bulkscore=0 mlxlogscore=970
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2407110000
 definitions=main-2408150113
X-Proofpoint-GUID: 15IkdxKqMSox-EyQnccRj9JFLVk9Tq1R
X-Proofpoint-ORIG-GUID: 15IkdxKqMSox-EyQnccRj9JFLVk9Tq1R


Christoph,

>>>> +/*
>>>> + * Pass bio_write_zeroes_limit() return value in @limit, as the return
>>>> + * value may change after a REQ_OP_WRITE_ZEROES is issued.
>>>> + */
>>> I don't think that really helps all that much to explain the issue,
>>> which is about SCSI not having an ahead of time flag that reliably
>>> works for write same support, which makes it clear the limit to 0 on
>>> the first I/O completion.  Maybe you can actually spell this out?
>>
>> Please just tell me what you would like to see, and I will copy verbatim.
>
> Probably just what I just wrote.  Unless Martin can come up with
> better language.

There is no reliable way for the SCSI subsystem to determine whether a
device supports a WRITE SAME operation without actually performing a
write to media. As a result, write_zeroes is enabled by default and will
be disabled if a zeroing operation subsequently fails. This means that
this queue limit is likely to change at runtime.

Something like that, perhaps?

-- 
Martin K. Petersen	Oracle Linux Engineering
