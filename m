Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70731157E78
	for <linux-block@vger.kernel.org>; Tue,  9 Jul 2024 11:06:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720523170; cv=fail; b=bgMvl0i4iQd1/cJ6PgLKeD2AVjx9371nj4EyqT2iJ/xD0KZBkRQJpfM/S+Yu6RjT9WSlZeuSTIWwi28gyFkaJ1AUQfRHFhDgfJFYrW0CUoaHpfERXF5W8U4RDeeaNv4uwlG5085Sy03zlHkcvYR1VDiRGu9vAu+KJIQJCsADhi8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720523170; c=relaxed/simple;
	bh=s9WYORsqys1R9bg6nBEVAhsqoi4yPt1qeaSszqfjDHI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=WvAQHtvNvlsuy+cmOi4dh9IOUfjov6Vb0/GaWvzOskNyFyyUwbc8d2UurdeTrfebvAtQhjf5IZJgT6ds/KeFSc+3eURWFDOjbBu4yIC6swjFbLbVwnwAoP51Rv8M2mMkvotWKN2c4wzX3n8iFma/AiOZtmf9SxnjvaQicX8uJRY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=IqSUd+fF; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=byyo/SCI; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="IqSUd+fF";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="byyo/SCI"
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4697tVJA017900;
	Tue, 9 Jul 2024 11:05:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:content-transfer-encoding:content-type:mime-version; s=
	corp-2023-11-20; bh=bhfu50rABaNzyXbydtgUtu9fAssH0KemcghAlnC5wfc=; b=
	IqSUd+fF9VC+gndKRPbCPkJCWg/hdanZKrKx6PU0kkf+g96ZgqkZQUR5Z+DQl7V2
	8O8Ook1FfNp9mq5+SVcldzdq1S+wBVGoxL6ggPiXnP1uyyfWyIzAOE4c8AePiO+z
	WdOGv6zLiFjSbLezQ7KaQaIvQ7b0s4b1jy4i7289ybSA9CgSKO0xqAXWphK1tDMO
	9wmhkups4f66ZXJyFA8C5UNaIiKnucwhPdoaU6E03NB9YYMPs0OW5DFyXCg05kVG
	1f/F86Zjsgeuu5L3mKbgyvInxwgavPFGRkg4X3FZ0GnvMAAqqjQMHzEtYO0+b1go
	MMfnNqXa0KZNEJ0DUF7VIQ==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 406wgpvntj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 09 Jul 2024 11:05:57 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 469A8VA5005730;
	Tue, 9 Jul 2024 11:05:56 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2040.outbound.protection.outlook.com [104.47.73.40])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 407tx2hh2h-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 09 Jul 2024 11:05:56 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LWMYIy4sOVPLMs3ah1ml+Rfo7SR+scIbF9rKOtLjaT0ghbq2xU/ujNFNHHqkcTErVv5Xhhc1TiN59jW9wxSFwwAP1S9uCBr+QhDW9lPIVS+FCmGCN9qE+P88tOqD0Pom5FMcppjUoBE7ttJQIvtN7dSpW/NVLgvU0Cf7Sk4VRsWNZY4LEV42tVMfjtFjuxspHzCDCVoZeaeA04AHzIw/SJZXXATSykOXkxC7bHTLAFYcKfpGWU1SVfSybxoeL3oy0eD85CDG9DMB6NJ1djTu3eF7PvfN2O/ZCCcpZQ1jOoJ194dtUGhQHvkdzbSTgaESLW5cbuA3xHQrA02dJtO9Zw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bhfu50rABaNzyXbydtgUtu9fAssH0KemcghAlnC5wfc=;
 b=U/KcSFn7Sfs1EmBi9qQyEn6UQBuIN7h+aZQz8nIGD9WXMXsMPvkSI/y0elIvkljyLf0ueLdahxFufl47UVklpwKLL47ryqO7bOnKNCOgSIMYfIyqqB/lLlYPyUqEbzii1RxWPKkMxPbPOSJ99nNQYTv6uF9OzbinIANTdLWbrsGmCC+d5WYQf1k8gZRAsHV7kqO4WRj0IRClzGY3pjlGpfi2gWjFmNYDpe54jVC4BTbP+Ad9yk5PKx0zGoBQOQgN3eV/CZw6m+BVZYanRBPvywS7Jrt3jGwcwWfGWHRQzGWHAHe8bpQs1EHIqBFnI5y6c1QWit7tZBOdZ0Wc8waWBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bhfu50rABaNzyXbydtgUtu9fAssH0KemcghAlnC5wfc=;
 b=byyo/SCINo1aE5I2q7RNnR8VbZkEk8x2U3Fo+rsFAkazzwlAIJwBpwmKtQ6YPh5vDQnlifUl2HdDGjitt7T/COZm7nWEKuCKQOkyq4BWS4OP10jQ2vSJ72PnOdTLS7FxE3m3iOa5bIRdkQn/HvC+bxAX2w8P18PJy6hVNNqiDjY=
Received: from CH2PR10MB4312.namprd10.prod.outlook.com (2603:10b6:610:7b::9)
 by IA3PR10MB8068.namprd10.prod.outlook.com (2603:10b6:208:505::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.19; Tue, 9 Jul
 2024 11:05:54 +0000
Received: from CH2PR10MB4312.namprd10.prod.outlook.com
 ([fe80::fd5e:682a:f1ac:d0a2]) by CH2PR10MB4312.namprd10.prod.outlook.com
 ([fe80::fd5e:682a:f1ac:d0a2%4]) with mapi id 15.20.7741.033; Tue, 9 Jul 2024
 11:05:54 +0000
From: John Garry <john.g.garry@oracle.com>
To: axboe@kernel.dk, hch@lst.de
Cc: linux-block@vger.kernel.org, John Garry <john.g.garry@oracle.com>
Subject: [PATCH 04/11] block: Catch possible entries missing from hctx_state_name[]
Date: Tue,  9 Jul 2024 11:05:31 +0000
Message-Id: <20240709110538.532896-5-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20240709110538.532896-1-john.g.garry@oracle.com>
References: <20240709110538.532896-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BLAPR03CA0075.namprd03.prod.outlook.com
 (2603:10b6:208:329::20) To CH2PR10MB4312.namprd10.prod.outlook.com
 (2603:10b6:610:7b::9)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR10MB4312:EE_|IA3PR10MB8068:EE_
X-MS-Office365-Filtering-Correlation-Id: 68c5a85d-d1c5-4140-d25b-08dca0071a4e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?eZK3s0EtxjyQ7+dk85kVV4c2GAwa9ZuppiWGlQu/8JJkqj2rIBYHgMhK9+EQ?=
 =?us-ascii?Q?b49gUAGqgqKE6gyfAZXDbsR1gIdgLawAW0g+JosPSxrW+kn/Af7xNPhSPaIT?=
 =?us-ascii?Q?38Jq4g/55W22+tPiIDaFSLfxlu6EhmLDsdq1+IgfDuvbFYcRZWU+cD+dtd/3?=
 =?us-ascii?Q?ZmGqaFZoLasxZ4MTMCM8SXo5Yll8Vz3G5zMev3nG8SH1MhFaa2Bf1fo0+G3v?=
 =?us-ascii?Q?R8hVN4crZjHqmn8aFi2YUdagYieXEz4C2LbiEwKHFs/UI4q3DwX75zBDUBLd?=
 =?us-ascii?Q?FOFkzN5CkBI61J1Xv9kfkbYi6KvfjJefz6OvzpfTh4MpX5z1qpcCEkjXA4b3?=
 =?us-ascii?Q?Kp5dQWPmNkrXnwAzSEJPWDKMrfNSEhYtNkNBHvKM1iGPyfkkrfqkPHCJsxI8?=
 =?us-ascii?Q?CBXRbUBYSRo3Fnqpsg0bLYzuLhEcaGsk/MjYsobI6iXWzXLhBbCuEmUqTH2u?=
 =?us-ascii?Q?dtgl1qZsLjJEY8k4T46EDQXmXDWLIOeL2tvf0IX9tm/MpMZ2ifIDahE0kYFn?=
 =?us-ascii?Q?HIWUUTGBND0Qj23acMzCwzhszB+bcYPeM4WneErcfIG/rJUpjMAivoEMhWW2?=
 =?us-ascii?Q?9jOUfRxaREf0U8Lg5k0YUP5WsQvRnEslXVwDVqCAvbmdCik/kxgdyGpsnauC?=
 =?us-ascii?Q?y5mecOPoMd+UdlcTdogM7js9ekBTuGPsNE+UXwRD4RDc9VcEcJFeYeB5oZDR?=
 =?us-ascii?Q?rnO+9HWk9FYsLnlsA2W/njIf3xvwN9ymq6ykVNdxBk9BlqFimtlaiKj9Asb8?=
 =?us-ascii?Q?PyK0gM/pkR38Nfcc5iyShq2V0wWCGV31/iZcQ83kZbLn6f8sqGyZHbM9E15b?=
 =?us-ascii?Q?ybHSwOsHWtFn7U1DMKYWa9mnOugrjgzEc2UGyZWm7Z45nnxtoqamisrOjaoo?=
 =?us-ascii?Q?X9Vv3g8W7Prgwaz0YwqxQPTyLszNaxeKykOTFFVCu8MQB3GtbXY7wwImXhNH?=
 =?us-ascii?Q?F8TvHDutu0twO4b+MkJ5NBom12Cf/EcxDq6TOteO+j3y2jOk9bUS5GfY/VqE?=
 =?us-ascii?Q?b4xyJEG/0vEHnCKP1u0bprkZ4QlBhqAuRT7h4k26GysnktiLz7SYjrk2+/kT?=
 =?us-ascii?Q?/zyfVK5qSCzWHarB1wX7AJbfe2pks0Yx/YQ+pgLsM12FyTDMTbklB/A3Pwfd?=
 =?us-ascii?Q?9ht1SMzW7w//rbJW4UeRONYh5bBKo/O0q2b9oRJRpxzRrVW5iOYpnscugdCc?=
 =?us-ascii?Q?NgSuGHewitBED5+noFcd47NZSsksYXJ2GRE37WCNSkykNMt76mXCX4voZUER?=
 =?us-ascii?Q?TwGHkADsypOA0P0DXWgiyxhp+yyON6S3r51uc5xkPkRH/5ad6KsoHvVls59Y?=
 =?us-ascii?Q?ofPCo0Ts/ftXYIx+6+Qklbog8q/1ExdE027BuoKKggLhQg=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR10MB4312.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?fB6o0XfRb5Y9779Z0u0xupIl+bwgrgL9zXZLTDaJj0SnLERLJ3KbxyhUdNah?=
 =?us-ascii?Q?Glx/fq5NnuPKMyEYmQj3KMDKPWPyUpYKH/y8/e1j13c4WCLHalYdOU5WqzIS?=
 =?us-ascii?Q?Ezl4sIcjV/ovvzET2/Y+E2u9kOWUQa6y+Qek+mJZxWEYDDidoyaD4ljx5X9z?=
 =?us-ascii?Q?IMN0Ccxw7quIFfi4HiWcFXwEuLTnnXbg31ZMawirydSShSqphf38uQhR8Tf8?=
 =?us-ascii?Q?30qXucZLVq1P6lBUkeU8zKQa4lUMgmhJOzaqyEnn62QeYqnoH5qj9LnSBXiS?=
 =?us-ascii?Q?cI6WfjaAkbuLPfqcutRl0GYLT47Q2Ioud3ZxoVev9PrpK71cZ8ctH9p3rBf/?=
 =?us-ascii?Q?wbenF42j3HMyrJPGVn1cFtO80GLOHRid3zG9IirJcUJQR5seFkf5R9Uk4g03?=
 =?us-ascii?Q?F1RzhaIbDS6hLjQnty0znxB0WD4D83A4K4hYcKmaBrQs/EHvGStWaJ2lNMDy?=
 =?us-ascii?Q?LBlEGtRC/F0HdOsIQvBpJGvgKAtjGMIw2D9x2L+hGGMs4qweELw+G/itdzlA?=
 =?us-ascii?Q?KXTHMYQaDNj3H79ILAY5+3FUWaSU/dI04pZSKGF3IhTkq5LNlpxejjZD5zSK?=
 =?us-ascii?Q?sgrm5IaNr/W9JqvEHGL0pHVf9HJ0V4++ipQpwAAEvTrbWRrMF7+IRz+qQMmq?=
 =?us-ascii?Q?ecZ4vcCBGPSWpXkQ3xZSrOoLxQhgVTHOZG/oJwkdjlzJ29Y9HfXDinycJHIk?=
 =?us-ascii?Q?v0PE1YSZyNiy1n70cIPhvSBOglX1Qw3JSOkJCAnEeY2SvCnUxz3h9UpcXQe2?=
 =?us-ascii?Q?CzCAyaNfRCCM+7ldB8l5INweQobA/WGiBABFhP/0tcvzaeGdPvr5rSWltwtt?=
 =?us-ascii?Q?X7ttXWx1XhGsS6/Dg5KdkNMpMIfgS9+8/x7za/h0MGtIGHfQqCXbXI9djhb8?=
 =?us-ascii?Q?NAFhFVmBBkk209Tjzk/+SD2pg3meYxqahAxTj0sM8TjnjTIwrzSRIqpbTJKX?=
 =?us-ascii?Q?DehpMY5J3WODcbwdCwxX0Ez2iAuiUfDNezQ9NN28AZ+sHW57kzHxtkv72q01?=
 =?us-ascii?Q?8OS89Z44GblXXY2IpgcBKKAOCp0x6uJZLiuRRkdV26SFe9NSDy2Ru62zF5iz?=
 =?us-ascii?Q?r7eOKetk4zw/yoxQHPac255TReRauuSSnq+r954bfgXv/7yjIdG0yIFBXnIz?=
 =?us-ascii?Q?NqPkY30jLxXK635uwJBrYzaz2IxuqWg54eVLSX7y99TjbvbXe6Xa7bYLpuSz?=
 =?us-ascii?Q?jH7Ib0SSKZquIems8UTrykMvk8vkcD1nQfnkCGJE1xCHSmNGWyn/xqJDhemI?=
 =?us-ascii?Q?mMhcYYXE0/p6BDOPj1MkU+mb+UJ3px+eD4javLA2n8sA+1DZD6kL8aEswNkX?=
 =?us-ascii?Q?dTmCXbMSVKNR160PRXCxHTFs/KKtUbzU5ICjHgWysuWiZtqWplORb38BJUbM?=
 =?us-ascii?Q?jWibZOk3Weoy5JuL/pLzOcJ5RQ64+WNfIDtaAY383Ar49MlthGL0p3q0pvVH?=
 =?us-ascii?Q?3P03awphl70FAUNFwvzkDd9q7NLXCwNmWU2HfmHo0mN9acQM9WJrCHIVeHuw?=
 =?us-ascii?Q?tuirGlifGcrwa3iIgYRtvDdIsMiW4DBIlRT7vgCddKfhYpSUBSMFqRAoQPvn?=
 =?us-ascii?Q?QBf41UyEdPRQBPEWNbKEv4LvZvCzvBswM3VccwBbuj70KOAc79LMRjHdU/Pp?=
 =?us-ascii?Q?MQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	MYS9N+U9f1ihL2VeQy1X/fL5ROjKwwJ2nERBXmVpDBUJj591oUxEMTm5nz4ey0OfhQ+r04bxHHCGu8PhYn9fylNdmvHTeRD75xqCzUfG6agbKsyhNPpsSj0c1gBjx7BTThxZUlQknpxT18UcgykgOpa4HHvdII2DtMmuD4/0ElDyqofGLWC5dzBZLb8iR77dF840qAgnYKvo7achB7CwUWNIg+l8idcFsHCcM/j5mdpSxJPOOgFbC+JjWyZxnVTiKz2MkA+iM5CKyvvTY8blLR5mz1VvRDCuhO+Za2VIqeNUQe6xER5jFAe2iJzvzPkkQ7ydw4M2rBdRf9bDaqTFEdYRm7z1mWatbwpa3jvyUbqJtyOAm+7YaJwzTwIowgxaApfY7jqoaXhUcPcesPP+6QP3HoBi6rfUjRvv8RiRFUlGM/3addgy1ozDkV9KXz5p33jn0UNEmCNQoXIViQMmRJqOXAzk5hnbfkX+NxpgW0INdPT9qHNnmZ1uI5XnK2qFT8f1IRW+frVR0O9Js83cc/8duTSaxDziNBaw5QyAk01rtLQKVGSofym+f7HUHZhJPCAmywk7IBhhrbrE/+OwvIw1MDR05VnBd/NLMKS8tr0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 68c5a85d-d1c5-4140-d25b-08dca0071a4e
X-MS-Exchange-CrossTenant-AuthSource: CH2PR10MB4312.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2024 11:05:54.8484
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3esIFGPzDq8j2Z0F4bCStb/tlIio0eIMs2DLvl+9aE/WehGI5tlqnm9dMai4Gb+bqMdIv9Au9mXaQitwnijz9w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR10MB8068
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-09_02,2024-07-08_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 malwarescore=0
 mlxlogscore=999 mlxscore=0 adultscore=0 bulkscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2406180000
 definitions=main-2407090076
X-Proofpoint-ORIG-GUID: ppAxyVKw9GCtgUhUmR32Tem4pU3bOj8C
X-Proofpoint-GUID: ppAxyVKw9GCtgUhUmR32Tem4pU3bOj8C

Add a build-time assert that we are not missing entries from
hctx_state_name[]. For this, add a "max" entry for BLK_MQ_S_x flags.

Signed-off-by: John Garry <john.g.garry@oracle.com>
---
 block/blk-mq-debugfs.c | 1 +
 include/linux/blk-mq.h | 2 ++
 2 files changed, 3 insertions(+)

diff --git a/block/blk-mq-debugfs.c b/block/blk-mq-debugfs.c
index 9e18ba6b1c4d..fca8b82464b4 100644
--- a/block/blk-mq-debugfs.c
+++ b/block/blk-mq-debugfs.c
@@ -165,6 +165,7 @@ static int hctx_state_show(void *data, struct seq_file *m)
 {
 	struct blk_mq_hw_ctx *hctx = data;
 
+	BUILD_BUG_ON(ARRAY_SIZE(hctx_state_name) != BLK_MQ_S_MAX);
 	blk_flags_show(m, hctx->state, hctx_state_name,
 		       ARRAY_SIZE(hctx_state_name));
 	seq_puts(m, "\n");
diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index 89ba6b16fe8b..225e51698470 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -664,12 +664,14 @@ enum {
 	BLK_MQ_F_ALLOC_POLICY_START_BIT = 8,
 	BLK_MQ_F_ALLOC_POLICY_BITS = 1,
 
+	/* Keep hctx_state_name[] in sync with the definitions below */
 	BLK_MQ_S_STOPPED	= 0,
 	BLK_MQ_S_TAG_ACTIVE	= 1,
 	BLK_MQ_S_SCHED_RESTART	= 2,
 
 	/* hw queue is inactive after all its CPUs become offline */
 	BLK_MQ_S_INACTIVE	= 3,
+	BLK_MQ_S_MAX,
 
 	BLK_MQ_MAX_DEPTH	= 10240,
 
-- 
2.31.1

