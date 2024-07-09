Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58E1915099C
	for <linux-block@vger.kernel.org>; Tue,  9 Jul 2024 11:51:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720525885; cv=fail; b=JkWiXUsl4uc+2wDlXQysqRXJTx6MwwFfu4nHZJrId6/49508MdkMmawz9bnzZyksHAf97NYLVO9379KP9byg60sS5uWVg07An/O7EVxawcQaWHSxfWTA0FpkR8N1GcIbvWEjboyHB4OGbwv/bRNbX/nLECrRph0mzZytjiDFA2s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720525885; c=relaxed/simple;
	bh=iKPJiL7EaT1bYvlJ23QwboX448+1T4vFuLxqCPJHJro=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=tDVeqbv++jbCRrPNyWfo0HkYmak63FeuMVxhQWgoiv1NOGs0G+ISmQhiYOfusiTWudIBqYEHu+RVURaB99HHR+mk86Qqp7cyWSj0KqRPhbK3x+xq2o7EY6CfmFkCmz7VwulxOd6FAX1ba1GadEc6aQveXzjlovSQXE1OPVUmjfM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=XER2rmd2; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=rdEhPTp9; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="XER2rmd2";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="rdEhPTp9"
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4697tf7C006468;
	Tue, 9 Jul 2024 11:51:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	message-id:date:subject:to:cc:references:from:in-reply-to
	:content-type:content-transfer-encoding:mime-version; s=
	corp-2023-11-20; bh=/S6Q/5g5ZkbnXzRC+eX0eqApGe2E2KOgT4zS+3g2i6E=; b=
	XER2rmd2Gexot3HT7eXu7vIli1BsDS1wfPkiCRGwttesPMKOQ+W/y3I17byMaAAi
	7EjTCdCuOdEtEB0jFjm5q87St5JiIuxJ9DuDj0k5zVPUa8HT7Fa93RB1xn1GcN7G
	OfgyTMsKLt8pgdhMGPPf6BA270MdsPKgg0g1ZifvfVjUdvxZ1rd+xvD2Ui8EqRzl
	CG7Zq0rJB083QhoxTQue5FalBtDPDLSTIU6nZrSgcDnmC7XIBs8oNDA6gDD6Uu5X
	YtJ+eMeYit23xDh0pgiM2xM5NkhorqlZ/xtpbb3yLF5PmgJ+P6vBIHohfhnGprQS
	nX2C7xBQN1rpepC43CHiAg==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 406wt8cp2s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 09 Jul 2024 11:51:19 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 469AELLO029822;
	Tue, 9 Jul 2024 11:51:19 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2040.outbound.protection.outlook.com [104.47.56.40])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 407ttthqpq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 09 Jul 2024 11:51:18 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Iv+huJ5sZtBJFziDK+Od4CEzgFGSFd1wITXvrixJtvGYGtqxVYq1fA+oyx7z6vjjYCqpJ55/UMY4bgzljWEQcRblYiyAkYnR7RHTCu1MX9D3P/YlQHDXi+lcO6er1z/w1uDX0pSIjSj3311Y/URtEkbe3QWt/+Wyz5q36PavoUQvRgt5SHUO+sihx8KlkoOrUguyvJa74ICMg6+QqhGs14GgtF63TpvY7BaTYbf+9Axc+9Gn21o+/0L47Sv7pJalnnDTVmds/6mBFL5orjckrZOoSselc/hK1Hmt8dIx+QmiR8D7n9e8vNgTLmHd0TVEmw/6fTgONJjfHD1k+HSekQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/S6Q/5g5ZkbnXzRC+eX0eqApGe2E2KOgT4zS+3g2i6E=;
 b=TdBQvSLRYr9Ow53nrLBugPf6OFmXNS+pTgXwnK7Cyw6HUqFvTapkziZKy9dgSdSgyel1mAeouQOj1ko2Zdi0ggmLKHxdM3mwZb33TotUHt95D672C/Vo0xh7Xx2OKBhqp6v+vEX+xGXioyJ/rBCE1Ufa82fgA6E9+b8/4yba3cQ7WDwvvBVZbFKZjxmwCD05jNilaj9tmpy9fmiGW674eSLw7soqO1jqEppyGkIx9ro95PcAKePF1/ufPJxEp9jJBW0/wdHG7ubr+eH/m9xvsT4Hmdvbqj0hKvtcb/y7GHQKCKX2yPQfqpRilwPgemheGMnyQZd9DvO+W/fX4YeKVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/S6Q/5g5ZkbnXzRC+eX0eqApGe2E2KOgT4zS+3g2i6E=;
 b=rdEhPTp92SeKclU6tpolDJJhOL3LGPoXooz4qs5w1+6qTKR0ujp+5j/XzjMc934tQp8vkpeG7+g3tmHkjnHilbtXf2kkOpLsjH3YNYzgPtX5gj5RQBJq4tRA9i870npWgYi2MUUFVBqG8klTpnzjiZB1hM83wwAUdGLbUt3dnD4=
Received: from CH2PR10MB4312.namprd10.prod.outlook.com (2603:10b6:610:7b::9)
 by MN2PR10MB4397.namprd10.prod.outlook.com (2603:10b6:208:1d4::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.35; Tue, 9 Jul
 2024 11:51:16 +0000
Received: from CH2PR10MB4312.namprd10.prod.outlook.com
 ([fe80::fd5e:682a:f1ac:d0a2]) by CH2PR10MB4312.namprd10.prod.outlook.com
 ([fe80::fd5e:682a:f1ac:d0a2%4]) with mapi id 15.20.7741.033; Tue, 9 Jul 2024
 11:51:16 +0000
Message-ID: <b1539d6b-63ab-4bc9-97f9-e45cc8803630@oracle.com>
Date: Tue, 9 Jul 2024 12:51:12 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 09/11] block: Make RQF_x as an enum
To: Christoph Hellwig <hch@lst.de>
Cc: axboe@kernel.dk, linux-block@vger.kernel.org
References: <20240709110538.532896-1-john.g.garry@oracle.com>
 <20240709110538.532896-10-john.g.garry@oracle.com>
 <20240709112318.GA5358@lst.de>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20240709112318.GA5358@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0263.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:194::16) To CH2PR10MB4312.namprd10.prod.outlook.com
 (2603:10b6:610:7b::9)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR10MB4312:EE_|MN2PR10MB4397:EE_
X-MS-Office365-Filtering-Correlation-Id: 6dfd0d65-a2c4-4cce-5060-08dca00d705e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?ejI3bTVVVVVMZ3NGVHJLMkhVbVJvcjgxZUtmYmVsWm85VHhodjRvTzRLM3lY?=
 =?utf-8?B?NndCa1ZtSHN1cnZaV1oyQW0zcGhMNE9WekUzSUNtT2xlNTM0OVBIRTcraXg0?=
 =?utf-8?B?SHR4WW9Qd3Jvb3d4eFlnSTlOSjc1YWd0QWc3OGVpT0tFcnJnUi9wTm03VjBm?=
 =?utf-8?B?aFlSeCtyWTE4TWVUVXNrdVp2TWNZZXN5TExUNkdVNGt3ZVIxeVBab1F2Sm85?=
 =?utf-8?B?RVJTOHZOUUplelBNNno3QzNKQndtZTNWT1VuekJtRU0zS3ZtSzhwTEhFeTIy?=
 =?utf-8?B?T0RlQTdpblQ5Sm1Tb2tTdG02VjlXQmx6V05aakJRVExaMUwyZ0hJd01nek56?=
 =?utf-8?B?aFJZK3lTY1IwSEJ2MGdKcC9rU2FMNVZmenI0UXpKbXdCUEs2enY5emg0RGxU?=
 =?utf-8?B?WXZNYllwaFA0bG95TzdOOEJNU2VXMnNlbjVueVByVEdldkt0NE1NeVJsQ05x?=
 =?utf-8?B?N2Njbm90MllLR0VMS0hBbXJUdkdMTXJEa0tWVjJaeXhOMUJBTytiQy92R3VU?=
 =?utf-8?B?aFNaUzdBQksyREEvZFJONHRzZW1uNXhMcXc1VWZ1aXZ5SFJNcFdXQUwzWnlB?=
 =?utf-8?B?UWVCaHRyN0ZuclBBQjdMUG5oZngvNWRvbkVWb21DUDNaSTlRbHNPYWF4emFl?=
 =?utf-8?B?MjJjWEFSNnNXaFlDOEdUQ1QvTEdWOTJ0QmpQWHZ3c3N5UFE0RVJBak96cWxJ?=
 =?utf-8?B?Uk8xeUpxYmt5UWc5UnAvYXFqeERUN0cwclhJZUdvWVdaUWRscWVTSlVVeGdJ?=
 =?utf-8?B?cHAyd3piMW0rQzdkSTg4WGc2RFYvMjVNdzh3emlGZjBDYzJLOWE3WnRjZzRu?=
 =?utf-8?B?anRNWUlHOU0ycFNJa01aNmdQcjZrY0J4Skk4cEVXcnZPSkZvd3ViUm1aNU5V?=
 =?utf-8?B?UW95d0J4cHE5clFqMXlGZklqTGllT1J4MFg2aW1iTE5XS3BKWHFteDR3aHZu?=
 =?utf-8?B?WTlMMktNaWJVS0FsSUVEcGU2L2VMZzFWelVNd3RDOUVFUU8zVVFsKy93RWRK?=
 =?utf-8?B?MWFwNlBwVSt4b0RVYU42NEZGME5jQnA3ZVFodks4b0poOEVKUnphRG9SQWV4?=
 =?utf-8?B?VXpBMlFSNUpwY2trT29vangweGo3dlZqckpDL1ZERlhqN0N3WWprZ2tQM1k2?=
 =?utf-8?B?VHVKanBoMHZyVHpaZFpqRUxQOEVYZEJDck5aSG9yK293dkdVd01uZENnSzVZ?=
 =?utf-8?B?S1hHWEs0QXljRmRLSHdmK3pobzJIZGs0Snk1V21JTjh6ZjZCN0tUaStXbVAz?=
 =?utf-8?B?R2tpbWdpckhYNjM5ak5VRFN0OHRCRlhybUp4SXVvSDA3elNjMTdiQ1lPalBj?=
 =?utf-8?B?bVgyOHBPdTVpZHg4RDVKeSt6bkpBamR4UXN3WHhPc2xTdmV6UjE4anppVG9o?=
 =?utf-8?B?QTJsL1VucjNZaG54aE92TTIrYzNzNC82NWtTRlliZEFQd3FXR3lvM2JGWU1w?=
 =?utf-8?B?cGVOb3QxNVB3eVQxc3FwNkVaVGYxeC8xRGhNcDczQ1VjSkZhOVhKZS93RVVy?=
 =?utf-8?B?SFRlZFdBeEdkUHBmdlBrdWFocTRXeGZUS1Fvb0dCQ1hab0tGS2MxNUVkd1U0?=
 =?utf-8?B?cTcyUDVCUXFvS2krMUhqb1FwQW4wdEZiM2t0S0ljQStmUnY4VHVwU3JLWExR?=
 =?utf-8?B?em9pb1BoSi9MZElMeGpWN0dHazg3d0NtK2w3ekJ5UW4rdkEzcmJQSVdVZ0tS?=
 =?utf-8?B?VHlvOG8wbnByZDF4OHlSaUQraGNtY1JFTU5EMXFFcElJYTJTWlpqdXBTWGl0?=
 =?utf-8?B?bm9LVE5VUU5udnJDOVJhUDl3S0ZYb2dWWjVQc0hNZGVvWlk1dGlzUzgzc2Ru?=
 =?utf-8?B?eWlhZFhlK2VnY1k2N1lZUT09?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR10MB4312.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?QVB5UzRWK0x2Q0dFNkNESGtWTGpKMDNiMEgvVHhnUVNYT2ozbE9lWjNGQXpR?=
 =?utf-8?B?YUhQTXowa3dvMXRGOEpmbjFwVlh0bk4rbnFPNTdUK2ZqVFVGQkdxYWpnQklW?=
 =?utf-8?B?c001eDM0NmhRU3RDSGZEZ2dNOGhrcFAwOHdvWkV6T1l6d3JnUVNyZ2REM3Uz?=
 =?utf-8?B?WlMvdzdnVUJmRUZzYm9VSUo1ajhPUTFLdE1HTCtNeUFZYUJ4YlVwN1pjQVVj?=
 =?utf-8?B?cW15dWQ0TmU1OGt3b3dxZXY5UDlOaWltL0F0a0h1MEh4Y01kVmdoN0RJKzhC?=
 =?utf-8?B?MjBSNERoYWhzNHh1VUJpd1JFY2krcFRaQUhDQ0JZdUx4SUUrUG1CdGF0NE1I?=
 =?utf-8?B?WTVtZjBtSG9RUEdSYzM4OVFsc2NGcDF0SElkSVU5bWppR0FyMU0rbE1PN1Ax?=
 =?utf-8?B?TXlzNEtwenc3aE5GV25weU5NaHBOMmsrd1luZ2dLblpZRUNjdTBvZVRVdHFD?=
 =?utf-8?B?aWRtWW14aVhxQ2RMaldjK1dpUDZzbm0yREI3WWRLQk9UWnFPSnhGYmcvT3dR?=
 =?utf-8?B?K0l5cHBBektwMzRaM2VkOGZJS0VlK3gxaERkYWpLVUxpYTNFN04vQzFUSk1B?=
 =?utf-8?B?QWVwYW0zd2J4MkVhN0tPbkI4dXRRS0Vaa21XOWVMUkRoU0VBbWdVK3kxdGN3?=
 =?utf-8?B?eHFGaEZFUE1CbnhQWVpVbmJOQ0lFUGwxYmROOHdvRTRYSlFXNHVYZGl2QTY3?=
 =?utf-8?B?NTNJUVNvREp6KzJWdThnb1NpNTFDQ2NNeWpITWdobzdvbVU2NndRM2FWVjlC?=
 =?utf-8?B?bU40bnN5Z3d5dzU2Rm92c2FPNFNGL0FOOWoxdzZGcFhGbjNjOWVrZTcyV3Zk?=
 =?utf-8?B?OHFmNGdPSDE3WnhLVnludmczTFRTUzRBdmk0MC9tOFJXdllVbkg2bXc1bXFU?=
 =?utf-8?B?aXd0R25FME14OVZpTFBOK1BKL3hCTmJUVCtpQ0RCVFNiRVNxNEw2aWIyR0ZF?=
 =?utf-8?B?MWlIRmgyQkVIQy9sNW0yc3EzWmY5L0NHdjlLTGZVQVlKTUNMODdoVHZxUHIr?=
 =?utf-8?B?TzFsWG9ObDg5am5xbHViT2wvanlPcCtMYTc2b1phL1gwRHBWZ3pLVUNjL2Yr?=
 =?utf-8?B?RVQyemJDMUNyN3JtM1M3SlJ0RmNXdEpBZWprQUlGZDhjT3VqckpkOVlmSU9J?=
 =?utf-8?B?eHZtVHltb1YxUVRNSTh4R01vVE16YXcycUhDbE5raGdzM2Q0UER0SU11bklw?=
 =?utf-8?B?NGV2NDdwcEw1WFE3TkFmUDNEY2VDRGtSYzhEUmg4K1FUTkZvQkZzVGRmWXBh?=
 =?utf-8?B?OU5Wc2RyajdPbU94eHRlSmdmM0xtT0hkTmVybDNpb1FoY1orOVg4TlUzakRS?=
 =?utf-8?B?VkhtVzFxTGxoTEYzWE11VG96V1pyY0ZhK3VUWWcyS2MrcmhXV3JQMUpnMDdq?=
 =?utf-8?B?ZnNLV1c3eEVCMkRhbXRDR3BBNEpTRHBlaWZUSWJRVXdHQjZKS0dBblN1cWt4?=
 =?utf-8?B?b0FKMXd3SmJFQlNiQjJ4QjlWSTc1c3R0UktpMTRtN01SbmRSVWR5Y2s2NDM5?=
 =?utf-8?B?VVNJRnpHNlE0ZytQeDM3ck1mYmhOQTFSQ3E2c1g3SVQ4UGtNQWQ1eVFCaG1Z?=
 =?utf-8?B?N2lqVVozQkZLc2szZ2xyOG1WSW9yT1E4aTRuN21NWnJ1dzJvUm1XOGFPQ2Y2?=
 =?utf-8?B?L1NhWnhtcVIxZ1ZJNXVGS0s1bG5rUk1tY1lwRmttcUJYSnZEN3BBNmNBY2x3?=
 =?utf-8?B?SEh2RVJlNmxWaVM0UTkwR0E2V25iLzNDZFBRK2VLNHh4Y3V3UUlUaXdlUlVq?=
 =?utf-8?B?WTA5b1ZrYk13WE9mU3dlOFp0Z0tEVkJvaWlzbzcwZnBjWjdTOGFiRlk5aWdq?=
 =?utf-8?B?cXRrdCtMaHg4NzhSYnlEemlsSXNYTDlhK293cEd1WTJ0MXRrbllxeS90RlpL?=
 =?utf-8?B?eWtmaGt5T1NTVWNzTW9LTFZvOWtteWZia1EvR213eERXOWk0M1YxRnFRZzVT?=
 =?utf-8?B?TmN0ZUlZM0ZZVktRRFliWVBXVVJ6NGRBMTREK1NCNkNhVnNmZGkrdzdtc1Jw?=
 =?utf-8?B?WEVZOWhwSFgwTVdpVGZTcUNXMk91bFI5YUVyeE0wNENQVE44MFlMbjl6RHZD?=
 =?utf-8?B?aDkwRVZ1NmpMTmluVkVIZExtdzB5VlF1anN0VHI5R1lSU2gycmQ4ajJveWVX?=
 =?utf-8?B?eTMwRXZGZmtSZmNrZ1JYbUFvUU9JLzRlN0FtZlhLeHpKRk1tRGdjOWsyTVhi?=
 =?utf-8?B?VUE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	LuDJGc1xE8NAXPV3BInjD5+HN2KJPuODY18SLLZYOxOxyHkIGuCj6FmKqawxwzmH+X6wwIv+TlkzWgrdZk/b9+kvvG3QsKsmWc00Zo91ea/02K8Ev45qvrOYiodTUQgdgKpWWirXyZBs84z0x1fJuppHOa+4w8xbQyva4Iq4RnM82DFQi0w47tHAr1/S0IOMNqTwa8yOFfl0NwnUM9szfGiMC+8ad2YO4fIpdp1nud4N6nuz1NUb0WHwPcfArU4RUwwsL791hHQbeUMRs09dovgnCsGFsvy7hZszIubAFZ5heA2N9FjNNqm6PZFlIsCCpyL/aoUgSl/UlK2hTblyKttnWd00moXAzzG/LXmCZJuxcB/teu+RCx8g84CP+beRc7wrHPUoYo562hdtQZVOR7LoHF/poTbP/XS+CjTosQ6djGh9m9+yIcQQ9RO1Zu7iBEMdfc5xgyg4i9XOytbR8myQ7tTeRJUhTT8FBJv/200AM6jGJKAbylp52Ro+aSPYx+eYBX0mK6d/kogiy5QbekxSHmbjdCdB9kLFGH/3G1PkAbfxM+1H/3Hyj3EpYGnJH383XgbTsvAsXEhmiFDMQlv6wG8KVOXuKeWZ8Ci8kIo=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6dfd0d65-a2c4-4cce-5060-08dca00d705e
X-MS-Exchange-CrossTenant-AuthSource: CH2PR10MB4312.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2024 11:51:16.3563
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zV88b3F0HADT2F38r0luQNZMyLs9435NkhgaTizPkLkjY+DjT5aniGRCFfmk80ybYVxlcMjcMguzGp7dgNjpgQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB4397
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-09_02,2024-07-09_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 adultscore=0 suspectscore=0
 malwarescore=0 spamscore=0 phishscore=0 mlxlogscore=788 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2406180000
 definitions=main-2407090079
X-Proofpoint-GUID: TkmMDztmzY0oDpKUYbah3n5CjsKjQyVG
X-Proofpoint-ORIG-GUID: TkmMDztmzY0oDpKUYbah3n5CjsKjQyVG

On 09/07/2024 12:23, Christoph Hellwig wrote:
>> +enum {
>> +	/* drive already may have started this one */
>> +	RQF_STARTED		=	((__force req_flags_t)(1 << 0)),
> 
> Last time I tried to mix __bitwise and enums sparse was very unhappy.
> Did this get fixed?

For me, sparse only complains about RQF_MAX, which is added later.

But, as I noted, I think that needs to change to a bit count from a flag 
anyway. I am not sure how that would look, maybe:

enum {

	RQF_STARTED_BIT = 0,

	...
	RQF_MAX_BITS

};

and then use a macro to define RQF_STARTED as ((__force 
req_flags_t)(RQF_STARTED_BIT  << 0))

But do you remember how you generated the sparse warning specifically?

> 

