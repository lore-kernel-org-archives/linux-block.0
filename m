Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5528238166
	for <linux-block@vger.kernel.org>; Tue, 11 Nov 2025 08:52:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762851128; cv=fail; b=pCYRLOKGpr6RVyX4UYVpKCU1tDJc6pBBUKQ2pusoT1rWzTCUr5wZxoKjlOgAoW8c0d1Kzdlx5K7sWhh0bIEUm1rxNkpvuFRbv72WnfZR8oOhdLdn+gKZVhldkFMFPLnMZmvJ56mucIs0WdMP+x7Ns0eyUlT90Mk/jUfPZ3B8zok=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762851128; c=relaxed/simple;
	bh=ouFCCMA65Ulhx1ylPVSplgV1x9CqAOnbc4+wocToZw8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=BILDTI0a3ESOP5jFrBXEOv7p3d+5wu28QgzgTy+/O6fLJWTvi0w5HgEeIvMm3tyuIZP88rI6nZQofWT0aepquZEawl6EXhPGrBQ8Ps39mKTZ2EOtvntFI/C/K1Ym851aNPrM120QhsGnFWji6fc9C/LoGZpsCMQlWo1J1jSzTVQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=m2BDvJHo; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=n1/P1Cex; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="m2BDvJHo";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="n1/P1Cex"
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5AB8bUKF009545;
	Tue, 11 Nov 2025 08:52:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=yrCBnbBygAR/KWsUGR6a+qDKTyu6oP02u1oCdZW+qP4=; b=
	m2BDvJHoA/K0RWTDT0hQs63OuoffSWTp91K+AtQOBh3in03R2aOCGH3JhBtT2zP9
	+EGGdMna/LZfRYSA37afLINTa4tcF2csbZf1+3HjiM9jgnpfDyj9HHLa+UkD7xl5
	//LNZeYx1iQxWEI0amOE4GAMK9+CgyjIoHdBgygBEZVZ8pNlyxHoIcFxZRUURycK
	g7/x5qB5IcxCM4bzLb9bn9JtAHFwl5yfvp4sOQdH6bmbzZ8sVO/MGyEF/j9LuJrh
	i9s0eg5DV8x3fJPBfbl8RRTYp6W4k9ZZgrrxFTx2byKJDFK5Be6MnQHqN4yvMWX0
	bksdzty3Ukl80J/sc7QKFQ==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4ac164g2wn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 11 Nov 2025 08:52:01 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5AB7Du9L021240;
	Tue, 11 Nov 2025 08:52:00 GMT
Received: from dm1pr04cu001.outbound.protection.outlook.com (mail-centralusazon11010047.outbound.protection.outlook.com [52.101.61.47])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4a9va983eg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 11 Nov 2025 08:52:00 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GnyC6ri1HBy3AXzW2pqYC5jFEP60dSL8+NcQ3y2Tw34K6cx94ePkWLJUVHt7aUlEkkNEMWtZaP8m/Wsi/VXNo1fjpQM5YjqtGPc6j3BdVln9PDbqOwrlFxT7TjPhTnR/L78zjxfzjLGZr793lUgAzmpSnwM8wtwra4SF8oLkOVBZZRGgA2thbqb4ag6Zv/tty00ihE5TJqk+KV9QQwWNQxGiiUY1QNY3xln6e4Ey7PWofuW58G384uvEMnr+5mmjokRuof2a7AWr4SSL7W0FJ8AfwEoW8qaG6nZPASQuiaKZ8dqHE8vMcc+xtEoaWOOLO2Esrk7n+Fv/T6i+NWIEWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yrCBnbBygAR/KWsUGR6a+qDKTyu6oP02u1oCdZW+qP4=;
 b=ayucfsqTZDjFl4CY/Do2xPEWYY4pNxwxTnC/MVW+Np1TMo4A3Q/lgYZmaKvGxFSjnofJ9+t9fl3iSpaNcXjTUbekGp4BxlfmxAO+taHnaaIWEphjskhf4piAc1EwWpbf1XAo6jCeEps8DfkPMjcGWk71y1B+udVq49c8Fm6ZRzP0pAh7107dR4aVecSj6/nx0YlukbEA5ntzw+4DlGriMeGHajnW6Cm+HJhJHfBtRfHH7mos29LYT0r3QdsTtuVRAZVlo7yibv5kdoUQXDpVHvSTJaUe4EbF8a6Sye/MH5vJbpiVEBFvG1l+3uKd+AqfY5o5WTeOUdsDyUR2CvkgAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yrCBnbBygAR/KWsUGR6a+qDKTyu6oP02u1oCdZW+qP4=;
 b=n1/P1CexssryeAWB7U3+QIinoIQkcVeXuztzboKgq1hfge8p8JAB1e1sQvTMIIACyrCru6kV2o81ZE5BWqLCiZVtjbKwGqSKnZZ9M7ZL6/8VzpW8twQ8LEy1vAvIUMi5iUJvEElYrld6jzj9LF0444DoF7VrNJCirTwi66qG6I0=
Received: from MN2PR10MB4320.namprd10.prod.outlook.com (2603:10b6:208:1d5::16)
 by CY5PR10MB6237.namprd10.prod.outlook.com (2603:10b6:930:43::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.13; Tue, 11 Nov
 2025 08:51:58 +0000
Received: from MN2PR10MB4320.namprd10.prod.outlook.com
 ([fe80::42ec:1d58:8ba8:800c]) by MN2PR10MB4320.namprd10.prod.outlook.com
 ([fe80::42ec:1d58:8ba8:800c%5]) with mapi id 15.20.9298.015; Tue, 11 Nov 2025
 08:51:56 +0000
Message-ID: <0ec951d9-c307-46b5-92fe-abca93b993bb@oracle.com>
Date: Tue, 11 Nov 2025 08:51:54 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] block: add lockdep to queue_limits_commit_update()
To: Chaitanya Kulkarni <ckulkarnilinux@gmail.com>, hch@lst.de
Cc: axboe@kernel.dk, linux-block@vger.kernel.org
References: <20251109074426.6674-1-ckulkarnilinux@gmail.com>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20251109074426.6674-1-ckulkarnilinux@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0026.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:14::13) To MN2PR10MB4320.namprd10.prod.outlook.com
 (2603:10b6:208:1d5::16)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR10MB4320:EE_|CY5PR10MB6237:EE_
X-MS-Office365-Filtering-Correlation-Id: 286f4a5e-399f-41be-3179-08de20ff91ae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dnVIR0pwWGM2YklqTlhkUmViUFVQYlozRTlkOHdlWkJUQjg0VVhYbG5vNVN2?=
 =?utf-8?B?VU1UVkNYYkpCMmxUbGFkdlQ5YUM0Mk80YjY3aHplZ0xGcHpLTWYvRnE1V0NN?=
 =?utf-8?B?M1lobEJKakpNSThtWXdMcWYyamZ2enN6NlNVeTIxRGdML0VEbVlPVWppVm9R?=
 =?utf-8?B?bGkrS1pxSFBZZ01GWi9nKzlOYWRmM3ZrallrdEx1eHZidmlQUzd6TmVDU0cr?=
 =?utf-8?B?K3V6QTlpbCswKzhQYUwwYzQ0RERSRW9YU1ZzRlQ4QVVoTWlyV1NWakhsUzhJ?=
 =?utf-8?B?RUJ1TTRIYWhuS1BrbGRySFNnempTdkZDeVlsbGtnQXV2NUUvdFlWSEo4dDdI?=
 =?utf-8?B?OVpIelhBNXVhRFBiNy9PdnJQMFFLRmlSTXg4YllQV3NPZGgvM2JXcU5hOS8y?=
 =?utf-8?B?bkpyM1pVSUlzY1dKYTUzU3VvY21uTGwrbVJianducURQREFNVG5qYWs3dkhF?=
 =?utf-8?B?WmxhZnBWTHJiV1FwRHJwRk1sM1NIMHZNNW5aRmVTcjlra3U1T3ZseEZDcHFi?=
 =?utf-8?B?U0VQTE1uK0l5a0N5dGVURzBFWmo0Vmtna0JtZmoxTEFLeWNacnk4V1NCcTZF?=
 =?utf-8?B?QXdXQS9mRURNMnd1MklqekEwYUd5RnJJTnlRZzFueXhrQUZsN3B6UlhRL1lo?=
 =?utf-8?B?R0ZkUUk4T0VaN2MwTTg4RG1HQXNXYjd6VHdkQm1IYmV1UDRueDNKcDliNVFG?=
 =?utf-8?B?N2VadkhMS29OR1N5V2hOdC9RdFNuOXJiU0JaeGpJWDNvTFpKa2VNTWtUMEZD?=
 =?utf-8?B?NlgwblVkZWUyQTI4OXVUdXd6N2RPcGhXSkZtMnh3UlBHOUtRU1BHSnhCNkU3?=
 =?utf-8?B?RzFrSi9DSXJOTm9mOWpzcVFaUCtQbXN6a2liT1JMUVh3L0hNanBpSFl3ZVpW?=
 =?utf-8?B?SGxiL0FPdWVxbEZWMUVRb0IxYkEwQStIUWc5ZDJ3OTVLaFUyaDhYOGFyYjYx?=
 =?utf-8?B?VXVidWxwdmN4aVFQdFFYb0RGY0tGcjFJZTFtNG1qZ1Bqa3pYYUJobE9vTTI4?=
 =?utf-8?B?VVc0OXFxSHlMNXJxMXRoYno4S1FCQ0pCKzYwaUJvdjc1c1d2VFFtQWxrejk3?=
 =?utf-8?B?UUJNT09aTlJpNE56Mml6NTBVTm9tMnVNRGRYekRpanFtKzkwTVBIeGhSU1Vk?=
 =?utf-8?B?Y2MrVlZ6T1Exa1dHNDRFS2JVVC9VdnNYdGhLWTNpbDlYSks5MnpEbklUNzNU?=
 =?utf-8?B?NEhZbjdwb0RzUUJRMDllV1F4VTRodi9LSkZlRnpPbllVZ3R0bXFFdURTS29Q?=
 =?utf-8?B?eU00MzFIYTFoQ0JGTHJhM29Ha1BzZU9RTyt6dFdsb0dtODN1U3B5SzVCdTh6?=
 =?utf-8?B?dFJReHVGSjhJNmREVThsSlozeHNQS2xOWXQwQnBtbzBLRTNYMWp4VVFReldM?=
 =?utf-8?B?N1BHUXlBc2RtRG1SRXVHK0M0WDhEUVk0QXdiZnZHTnVIVmxsUDBzZHVTaWpz?=
 =?utf-8?B?VUFCK2sxZk9nbTZJdGxOT1ZOUGZrOVVpZnFVTHpRRlJoeG04Wm10WDZMSnJN?=
 =?utf-8?B?T3lHR2NiZGx2RnhkUVFYNjlybFcvRXRPWUVjeU1veCtnckdGa2czT2IxMDZH?=
 =?utf-8?B?bjI2OG5mWUJGakNkZ0FSRjhJVEJlTmt3ak15cUtPcUlncGY5aitZSUtBZEhV?=
 =?utf-8?B?eUEzSWZQREpJMDNSMktMemV6aTVqZ3VlZzNPUmp0R25vbi9hOUJKbUE1TVZv?=
 =?utf-8?B?aW1HamFpc1RpT0lOVlNmdDFBQThCRkFSa1JaQ3NJREt4Wm5nb1k4ZGdMM3pJ?=
 =?utf-8?B?SUpzQXUrWGhuTU95aThIUUJ3R01ONlBCK2tSTS9nanVabWptcHdVWkNPaW12?=
 =?utf-8?B?NG1aTG1xdGptVHJUOVJObEJ5OWtzVXNTMklkMUc2T1V5ZGZRb2NjaWl4SVgr?=
 =?utf-8?B?RVFPTWt4c0JtSVYrbkNxNCtZMTlMQllUbUFzM0h0akc4WXlXSzlsRDlvYXNP?=
 =?utf-8?Q?maMaWJGxg5vi/a4adRdCDCsTUQwAUsAx?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4320.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZmJ3MzMxK3dYV0RWd1JBMm4ya3pEYWpoSUpmTlM3cWZmSGxlODJOQWlPdEF1?=
 =?utf-8?B?UVhjT3NwdnI3REtUZUhFSG1Ud3o0aUlENllSYUpzalNMbFF4L3lTSkdKRElU?=
 =?utf-8?B?OUg1bEFCN2lpQ1F5bHNvSGNOa1ZEeERYbmZPMHMzREpnbitPa1B0bTNRUU9F?=
 =?utf-8?B?NEQvWEpSb0VCb212bkZkVlQ1dTQ0ZU80MDhTNlMzY2VzcjVPU21Dc1pOZm5w?=
 =?utf-8?B?N2YvRmppbmtidGU3NFFMdXd5eTMyZmZ0ZHlpSG1RVklmL0VnWXFKRk8wYkFO?=
 =?utf-8?B?eGtmc09yMXh5MkdscXNuQUp0SFU5NnFQalhEdm1EbDZ0emtBZG9GTUZOdzdQ?=
 =?utf-8?B?bXNRWjFFM3p4YkJZbXcyanA0aXpiZitBVHRINHpFRGV5cGhJSzRzQ2NhMXk5?=
 =?utf-8?B?T0g3QlJ6RzFrTEt3Nm1oVTlaWC9mZmd4VTVXRFZMNFBLR1YxbUc1bFFvRmU2?=
 =?utf-8?B?QjhxREhIeTZldnhNQnljMHdoeHIyMjdzMERRMXh0OWEvNkNWZmFJMXhTdGJk?=
 =?utf-8?B?Q0ZvWU1iSVZ1c3krQXo0MnIxem5tcHVEYWVvWnVCeWJ6NVlBc2hWNFNMQ0JN?=
 =?utf-8?B?Yi91eEhQQW83SFNVblBWVjFoTFZRby9vQnY5dEpqKzA1WkR3b1dzQ0pJbW54?=
 =?utf-8?B?eE1SZkZLK0tBV1dPRTFWaTRFeGJtYi9BVVBTRzcrMVVETFdQdE5ISktQeHJs?=
 =?utf-8?B?RmxsR1lCVm1lKzBZVVZmeHJybEtDVmdVNDBVRXNqbWd2MFRIbkI3ZmRqNVlu?=
 =?utf-8?B?eDFNSnF6ejNRNG9IVVhDYzJYMzg3VGx4ajl4QisvWUVndGkrelJMZ3RUT3lQ?=
 =?utf-8?B?VjcwdWkrUEdTcWo4Wjg0YzkzaXlEVWFZRVVEMVd6ZllxUC9uOU84TnVJNWdo?=
 =?utf-8?B?UEptWEJjVGh0aUl1a2Q4Mis0enhLampwTXNDMXdkRFlXd3hwSS9vdkdDR1pD?=
 =?utf-8?B?WDlFcG05M3NjcWVBVEFkaW5Ld0NESzd0Ym5Xbys0YUxma09oL1RHSllTbHRV?=
 =?utf-8?B?dXpiMnRVZGdKcTdtT2syUlZEMUNYTngydUYzYkpScS84eTRZbEV6TFIwaVhU?=
 =?utf-8?B?MmhIbW00R1lzNnBLdnhXQ215THV0UUJ4KzNPQS9wQjROZzNvWkI4V2RCN0JB?=
 =?utf-8?B?MWwvRURkT3dIa3U4U1dMcHZkdWhJaS80ZmVFc1lTTGN6SUt4dGRwU2ZJWGdj?=
 =?utf-8?B?ZHprNkxqWGMzMEZBa05RMjFmUzZMeHpGSVhhbHRjazFQb1JpU1JTQ29FMjgw?=
 =?utf-8?B?RFBrdFJsWVZoMHpCeDVoVnlhUGp4TTlRSUF2RnIzcTNVbzRyd2dsOE55VVkw?=
 =?utf-8?B?ZktVcENWRlNxMkZjS2pPbG9DVjFUTU5GbTlMT0l0cFVaRDZTaVp4bXZsdHRo?=
 =?utf-8?B?S0RqNUZncnpOMmR6QmMxSk5ISVpndnFNbVlpa1BWQURDK2U0Vk9HcldrL1pM?=
 =?utf-8?B?NlA1eEM2Z1dabTRuWU5oZEFLcGV6dUhUc3Q5T1RkalRFS1M1V0JId2NrTnFq?=
 =?utf-8?B?REVKa3pGTmdBUVd0cGpzdk5GM0phNzROc0RRWnFnUkJKUDF1Ui9PMFpQdjRW?=
 =?utf-8?B?OXZDTDNSV0phTmw4VzRiNUlOcjVSZHZ4U29jbVNsZE1aZXlEbEV5QUpVMXoy?=
 =?utf-8?B?VEI0c2ZxcFFmVnlmVEx5cmFKZS9sTVBxazAxeExoRTh4U3lHMjg5NzV1UlBn?=
 =?utf-8?B?eG9xM0tWVDdxY1Q5UmgzcWVYU1g1bGM0cERybUNML05MWkIzZU5QV3dwNnBs?=
 =?utf-8?B?cU1WRFBGaHBjRUtGSWhVUURoRCtWbVNoMzMvVVBITEEweFVVYmozaVdsN05Z?=
 =?utf-8?B?Vk1aRmdJT1JONXNMb3ZtRHNBc2MxbG56anpQSStsaU8vSGRzR0R5RUViT2Jo?=
 =?utf-8?B?ckZocE92MG40UyszM3RrU0NieUlsS2V0SnNrdEJPckFRQ0RTdEZMK0NSRnMv?=
 =?utf-8?B?UTRQdE8zdU9pY1ZvZGtmTmRLWVUyNHoxRVRzdjMwdEIzakRKbjBpTlNaRkYx?=
 =?utf-8?B?a0lXUUVKUENzMDNONng1QVJvcXFoK3hEWWVYZ3hZZU1zQlVsMmV4YXdKY0VM?=
 =?utf-8?B?SXVrcGxMRXJwRGVTcFlTMVcwS0UzUmdGKzFXS2dkclZ2V09VVERTcFBlUnps?=
 =?utf-8?B?aitjZk52QzdoV3IrMlg4dWM1SExFNmp1T2ZDRzFMTmcxSXZYazRzbnovVlNi?=
 =?utf-8?B?VFE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	wfvj3RwGACdMffnLepjJFnlbFibOLbka6KjWCgrb4XvtpPifpP1SjyZHhNe6AeiKHs0OSo+JYC8sHK7y4ou3f/TKnVsqu8ydl3KyMnPa06mtYo6gBtoguush3wThF3VVMVV+6YxOJX9Nk0q//OwR0r7cQXP//PDS1rakAWofEqKra6q+cgVD+vLAn/Ln1lnWnUzioG0aCOvNlNqy4pw7ynoe+1ZV2Taw5ub8Zb49A50if78Dohx2M3ZnbDlVgbnwOZpi1L/ZBsqjk9OKz6Ggs9JlR428lsgRcmJezrQao6keec6qBgvN+A0l7fZ58A5Chf5Q7HNe8MO0z7eTUFsLJIubeeeCHIoIL+LvMYpTetmNiaK5qNEIcvkAU5+4TRD3hVDF8Enz09ycCelzVu4pyBh98UF56Juw1eFp7geeVHLp38EcmFJLp4/0NfS29NLOx5OJW/WGv45yw4x0huYPWOlHI+AAtngqh2s8KejK/bo++eCZti0MGHuCdf/sgjTrhMAwjN7Q7zeWCdnPpMxt7VSZKoxdzTBku8orKbgftjMK3WNAgPEYUYQY68oR3vsgXTHVgEQGneAYqIOyRqIg0n27rxeAlaUnA3jBNoenoxY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 286f4a5e-399f-41be-3179-08de20ff91ae
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4320.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2025 08:51:56.8098
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: R5rk5+dHV2Q/fRjVMqiyHPGsW/C2RSOND2B5pls0H66yp09XsBrgpF2BVgbsjqKzoAs2ystKiGGRWWCoLfFRTg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR10MB6237
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-11_01,2025-11-11_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 malwarescore=0
 adultscore=0 bulkscore=0 suspectscore=0 spamscore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2510240000 definitions=main-2511110068
X-Authority-Analysis: v=2.4 cv=Sar6t/Ru c=1 sm=1 tr=0 ts=6912f931 cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=6UeiqGixMTsA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=pGLkceISAAAA:8 a=ID6ng7r3AAAA:8 a=meMUdlO5FAK299v8cW0A:9 a=QEXdDO2ut3YA:10
 a=AkheI1RvQwOzcTXhi5f4:22
X-Proofpoint-GUID: z1GyBKgpluOJqkOsfN80glVJ4rqinJg_
X-Proofpoint-ORIG-GUID: z1GyBKgpluOJqkOsfN80glVJ4rqinJg_
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTExMDA2MSBTYWx0ZWRfX/umOOafAPLih
 L4Zr5lkcu5UVzMA2BjpG1oJ7i6ipTz/K1BY628gNemJc+GJJwX9juO5kO8oY76P4cEbt7Nz2JbP
 BMVHPeonssdygL3h8JWXuI+Zv5DS2JSPilFp6tESp95/AYNVcVYz+i7ShN/MAr4RS8Tj4oc0MgD
 7Qgz8WueuwTOli4L0ZXJCOaQqST3lQMaIFhvjnQKmb3k7/zrQyTux6FnZDqpKLShE+/NAN9CW2r
 7LqHH8wcqEAed/d1NvxML16NrB69d1p8RGVxJ7OWnoSW7RDKbuEMXKzbJjkwXrQArXBXHy/5LLF
 zpvfIacuQw3st+OQebcMGsv7sl4yV9vXKObC3qA8sFjVdUtjwzVM7X38UKeAHLIgJEFYxmbgo4G
 dGkSmMo2OwSi0SmiWjZ0z/JkZohypA==

On 09/11/2025 07:44, Chaitanya Kulkarni wrote:
> queue_limits_commit_update() expects q->limits_lock to be held by
> the caller (via queue_limits_start_update()).
> 
> The API pattern is:
> 
>    lim = queue_limits_start_update(q);  /* acquires lock */
>                /* modify lim */
>    queue_limits_commit_update(q, &lim); /* releases lock */
> 
>    OR
> 
>    queue_limits_commit_update_frozen(q, &lim);
>     lim = queue_limits_start_update(q); /* acquires lock */
>    queue_limits_commit_update(q, &lim); /* releases lock */
> 
> Add lockdep_assert_held() to report incorrect API usage.
> 
> Signed-off-by: Chaitanya Kulkarni <ckulkarnilinux@gmail.com>
> ---
> 
> With this patch incorrect calls to queue_limits_commit_update() will
> report following :-
> 
> [  800.055674] ------------[ cut here ]------------
> [  800.055676] WARNING: CPU: 36 PID: 5507 at block/blk-settings.c:559 queue_limits_commit_update+0xc2/0xd0
> [  800.055691] Modules linked in: test_lockdep(O+) snd_seq_dummy snd_hrtimer snd_seq snd_seq_device snd_timer snd soundcore bridge stp llc ip_set nf_tables rfkill nfnetlink tun sunrpc xfs squashfs loop intel_rapl_msr intel_rapl_common kvm_amd ccp kvm ppdev parport_pc parport irqbypass i2c_piix4 joydev pcspkr i2c_smbus qxl drm_exec drm_ttm_helper bochs ttm drm_shmem_helper drm_client_lib virtio_net drm_kms_helper net_failover ghash_clmulni_intel virtio_blk failover drm ata_generic serio_raw pata_acpi qemu_fw_cfg ipmi_devintf ipmi_msghandler fuse [last unloaded: test_lockdep(O)]
> [  800.055785] CPU: 36 UID: 0 PID: 5507 Comm: insmod Tainted: G           O     N  6.18.0-rc4lblk+ #103 PREEMPT(voluntary)
> [  800.055792] Tainted: [O]=OOT_MODULE, [N]=TEST
> [  800.055794] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.16.3-0-ga6ed6b701f0a-prebuilt.qemu.org 04/01/2014
> [  800.055797] RIP: 0010:queue_limits_commit_update+0xc2/0xd0
> [  800.055801] Code: e8 f3 b8 89 00 44 89 e0 5b 5d 41 5c c3 cc cc cc cc 48 8d bf f8 06 00 00 be ff ff ff ff e8 06 2f 89 00 85 c0 0f 85 5b ff ff ff <0f> 0b e9 54 ff ff ff 0f 1f 80 00 00 00 00 90 90 90 90 90 90 90 90
> [  800.055805] RSP: 0018:ffffc90007e37b30 EFLAGS: 00010246
> [  800.055809] RAX: 0000000000000000 RBX: ffff88815afaae40 RCX: 0000000000000001
> [  800.055812] RDX: 0000000000000000 RSI: ffffffff8294deb9 RDI: ffffffff829e7716
> [  800.055815] RBP: ffffc90007e37b50 R08: ffffc90007e37b50 R09: ffff88815afaae40
> [  800.055818] R10: ffff8897df0a0000 R11: ffff88983fed3bc0 R12: 0000000000000000
> [  800.055820] R13: 000055d8c85e62a0 R14: ffff8881761b24a8 R15: ffffffff8457b4e0
> [  800.055825] FS:  00007faf1f802b80(0000) GS:ffff88985c0e7000(0000) knlGS:0000000000000000
> [  800.055834] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [  800.055837] CR2: 000055d8c85e9eb8 CR3: 000000021fc44000 CR4: 0000000000350ef0
> [  800.055842] DR0: ffffffff845fdc70 DR1: ffffffff845fdc71 DR2: ffffffff845fdc72
> [  800.055844] DR3: ffffffff845fdc73 DR6: 00000000ffff0ff0 DR7: 0000000000000600
> [  800.055847] Call Trace:
> [  800.055850]  <TASK>
> [  800.055853]  ? __pfx_test_lockdep_init+0x10/0x10 [test_lockdep]
> [  800.055860]  test_lockdep_init+0x1f1/0xff0 [test_lockdep]
> [  800.055881]  ? lock_acquire+0xe3/0x2f0
> [  800.055889]  ? find_held_lock+0x2b/0x80
> [  800.055895]  ? __kmalloc_cache_noprof+0x5d/0x770
> [  800.055906]  ? lock_release+0x14a/0x2b0
> [  800.055911]  ? fs_reclaim_acquire+0x48/0xd0
> [  800.055923]  ? __pfx_test_lockdep_init+0x10/0x10 [test_lockdep]
> [  800.055929]  do_one_initcall+0x58/0x2b0
> [  800.055941]  do_init_module+0x64/0x260
> [  800.055952]  init_module_from_file+0x8a/0xd0
> [  800.055969]  idempotent_init_module+0x17b/0x280
> [  800.055980]  ? netif_queue_set_napi+0xe0/0x150
> [  800.056007]  __x64_sys_finit_module+0x66/0xd0
> [  800.056012]  ? do_syscall_64+0x38/0xb00
> [  800.056064]  do_syscall_64+0x76/0xb00
> [  800.056072]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
> [  800.056076] RIP: 0033:0x7faf1f32bddd
> 
> ---
>   block/blk-settings.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/block/blk-settings.c b/block/blk-settings.c
> index 78dfef117623..51401f08ce05 100644
> --- a/block/blk-settings.c
> +++ b/block/blk-settings.c
> @@ -556,6 +556,8 @@ int queue_limits_commit_update(struct request_queue *q,
>   {
>   	int error;
>   
> +	lockdep_assert_held(&q->limits_lock);
> +

We always unlock the mutex in this function (not shown).

With your change, if CONFIG_LOCKDEP is enabled then we get the above 
warning. However, if CONFIG_DEBUG_MUTEXES was enabled, we would already 
be getting a warning.

Maybe using LOCKDEP is much more preferred than DEBUG_MUTEXES.

>   	error = blk_validate_limits(lim);
>   	if (error)
>   		goto out_unlock;

