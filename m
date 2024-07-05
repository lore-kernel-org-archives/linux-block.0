Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D74D14A087;
	Fri,  5 Jul 2024 11:52:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720180331; cv=fail; b=LIKKi6SD0obj2rozQ1BRakuCh6cRER6HtZOCmXMf1YVrmzLVi8XBKNiiizDQiwQbtQQ/p6kAhtnL/JYxQS1V/zb2EbVdLCy3F6DMJu+i5fpIUXBcOpimY9Ywkt6I/UVRNPpYaFyfdartEIVXBK2U896VSAjiY4j+eiaurPc3/VY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720180331; c=relaxed/simple;
	bh=GQk81zmwq1VLffzG1g3xnYgh0T3TMC2GV0XBDluyPb8=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=C+eFqTIt5k5OkBOG6CBALlFgxd5eO5kgJri9AIT5V/y4++d7wWr1az7GW/HgJ1eol+H4czT6xqNOE+V/vUYzk3Ofx8+1xQ1SKKCvVS9t8DAlWDnvaoe5nHVP7s8A86OEZ3Q8Oj9ygjl1W7lHWOlV4IgveQStv6YbPmb+XJTlGGM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=nyOSIKeu; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=rXiqXoaA; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="nyOSIKeu";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="rXiqXoaA"
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 465BfVrk017674;
	Fri, 5 Jul 2024 11:51:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:content-transfer-encoding
	:content-type:mime-version; s=corp-2023-11-20; bh=ouDqZd2FcenzRc
	H26qvD0q4+Xs4dMOuumXdf8PCfA70=; b=nyOSIKeuLIJXfCgw3wnOzmo5fKPnSC
	jn0SP4N9T+/k1Qxsz5GHLUzoUwlrel7duwU6ghLWv1l2M4qWG1hr6iH98g2Rzzni
	pIGiczSVNFD7rW8wlRQzW0pXO5mabnoiz3D6tzKnSFB58lmEnWs6xlCKxCiLFGjn
	5/9A1jcBhAFhFcC5mNC8uS1fJDUo5DUE0mZK6bY5TLzkypVW5awYMFM6Yflst2sa
	hRQJSa1WzMUSRQ7DWlRCNJIMB5pG1OFG0AlGrF+bwqzcLd0DXposSZmfZxhA+7Jr
	le7rlr8tCgFuvppDXYFTAI6cGLQWE0vRbTzry0engunrzsjr0Ei3T7ZQ==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 404nxgnauc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 05 Jul 2024 11:51:45 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 465ARPX0024944;
	Fri, 5 Jul 2024 11:51:44 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2173.outbound.protection.outlook.com [104.47.58.173])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4028qbsb6f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 05 Jul 2024 11:51:44 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M1Jqrrs3GsXX1pPa9EriZTDMKnrE6COougn13A78fKt6qpHIdbEuD90wZZC/V2WM8mxt2SO6kNfrWwH0R1PzrRHW11P/sU12Yu6uds2BCAxi6VKB1IpSzpEXDCkMURdxXHID9P/bOmEDy/akYkAHkrLYEyuVdDCWhuJ4bUSWE4rYX24mhvdjkQcX37i/As8/jKmctYeADNg4pal79z4HXOlN6z+dm2+P/f7aLg3D7SWEA/HJwVCEUgNNbk2qcK+2RBfcYvexSVIkDb30VtSPB2qwtvNNqyWREWVG0mYfu51WNqWi4YOnMEYp1dxK+ouNwBFYEemKY9qlm/UZWAOPmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ouDqZd2FcenzRcH26qvD0q4+Xs4dMOuumXdf8PCfA70=;
 b=HK5vUN/gfprU6Mo7hjUfCWq+seS47H4XyeOfvkWAl6eleNuHERfB1BKVSvXcRmzbgRMq5jzUaswPIkDVupvRE+5rjE27wy5+ex6qTxSGPVXwUGvYUuIoeb7AxtvnmtOuZrsuIwUBPHndONtDSCknIQii3eG2hP8cceCjfeuONollLnEDMlgW9Kkb/wlE5heu0gqY+/2IYtuW2tdp6GaIuanYdAa8enGtFSAYHbtXZPOUr7CHTVSoa3H9Pv7Ib3GZOMLITgoUT8igeFJtSyAglTZigiM+IldRKW16osjELqPuLdBf1DnYgLqXTOj6ytm6To1qJDDqlAgmAzeooGFQMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ouDqZd2FcenzRcH26qvD0q4+Xs4dMOuumXdf8PCfA70=;
 b=rXiqXoaARCFuNW6hPXt8X5BuKIWk7CKUZUYiB2gORZV3j0rKpZ4/AecmLh5/bTIgYp6LGIZ5RYrsEwM9XEddXxkeEV6i77ulf42iqokFdUrmKH/5x660Dd3Gyrc/4r2JfV8dk6Z2SdQEmxoGRCzhBtSyqCUYHNEgbtjhZvyhwfA=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by DS0PR10MB8080.namprd10.prod.outlook.com (2603:10b6:8:1f7::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.27; Fri, 5 Jul
 2024 11:51:42 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%6]) with mapi id 15.20.7741.025; Fri, 5 Jul 2024
 11:51:41 +0000
From: John Garry <john.g.garry@oracle.com>
To: axboe@kernel.dk, mst@redhat.com, jasowang@redhat.com,
        xuanzhuo@linux.alibaba.com, eperezma@redhat.com, pbonzini@redhat.com,
        stefanha@redhat.com, hare@suse.de, kbusch@kernel.org, hch@lst.de
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        virtualization@lists.linux.dev, John Garry <john.g.garry@oracle.com>
Subject: [PATCH 0/5] Validate logical block size in blk_validate_limits()
Date: Fri,  5 Jul 2024 11:51:22 +0000
Message-Id: <20240705115127.3417539-1-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR05CA0048.namprd05.prod.outlook.com
 (2603:10b6:208:236::17) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|DS0PR10MB8080:EE_
X-MS-Office365-Filtering-Correlation-Id: ff0a57d5-2879-4ecd-7bc1-08dc9ce8d61b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|7416014|376014|1800799024|366016|921020;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?n9nwg1+ezNZLiO+7wuSNuVPhp0fkC8vvufjte2p6ReqSwCR57udFvmZ/xJFE?=
 =?us-ascii?Q?4LP4zvR46GHXkfen3Lh7M/ZpsMYbm+l745u+7nJ9abrZ/umhU8Y05GKlTgc3?=
 =?us-ascii?Q?d5RmrapE9lpk+6x19b9LbrkPdBT+5BBYXwVywObSJTbWb+4H7G48eRENJV8q?=
 =?us-ascii?Q?5k4E3M9LdLId9mKDgDmi/L18YSyhrLunUgd+XF0YQIDNvPupPetWflEQ6Tmw?=
 =?us-ascii?Q?048e/5C8PckLOtPKwK7oFG8XU6TFpiuHlWZxY3o7Vv6W5xXrM9FeDd6RmdEv?=
 =?us-ascii?Q?EGawIID24jUuPH7p8MjmJevVRiIXYcYiUStOvWebYUWKJyZGCfOMCIuWds29?=
 =?us-ascii?Q?82B2NAXaefkTfzA05/t/hAdJ3aUZx3V2dBqCWtH+LCh67Ze7cjFMSDVgokR+?=
 =?us-ascii?Q?fPf9K1oJqAgcNPZtTTM/oZ7W2wCW2y+MttyryD/trOxfBgs28Lqn5B/eNenz?=
 =?us-ascii?Q?4GlR6lg0lIT4W4MUsaC0uSBHjX9Hg8psJYU2VTTsLWZLBPpqlH7cdL4I9cxS?=
 =?us-ascii?Q?qTONVjnURgm6x+sPM5Cm3auLMyVa5rZHelmZdVOIspJVE3AnB+JHKzNIgCs9?=
 =?us-ascii?Q?4h4tyQ/EIdMXOcoXKJnXDbIevFI76XIWgvCTFsI4hz39TVPitaWBOYrVXIzE?=
 =?us-ascii?Q?3rjWeOcsPm2LTYAOtwzHjawqAr49rzpI9qmI9gUZmmppk0zuX3WGh7A8b5bC?=
 =?us-ascii?Q?u/j5Sv4NYKgSAo/96/M/sZx57NLeLnuURsWZCADphVC2j/YWm/tynGVx6OiI?=
 =?us-ascii?Q?RVBfVzqPz2V/mbtPUqj5ebHcMPXOWYteeL8NDOmA1F1ktQGL/5rP1Q4dEFkE?=
 =?us-ascii?Q?X0dCq7Y3M+jMCMbv58uhct2KifEkLXVk3q5wJW809VnNpxePxbZbKGaoNp7L?=
 =?us-ascii?Q?yl9M9qmWzu52E+YH+mnxx6Uek99lnxipvTKP+7GktLOAi1qD6pUtQTNomNpg?=
 =?us-ascii?Q?O1w/xhogttifpe2UxjzsI9hwEVxlWPNybDGoOCjzIwt9QX59PNphsE8tiyla?=
 =?us-ascii?Q?n77Y0iJhkD9RTGLR7DLec5ViS7RocRk/VaNxWdTaJb8KXCwLMFtUxxNla88a?=
 =?us-ascii?Q?pohJNj26hKLLEyZ7S7+YJ949ZkjpDTAZ/5uV+o6jvUS7WKtZ0RPulKXs61So?=
 =?us-ascii?Q?bcaiDY6ZpbwgyVQ0zuTvStoTF8CwVCVRrLdV3jd5B07IX2cuhXAKYJIh3AKG?=
 =?us-ascii?Q?LY6i8481+/XtUYkIsOkMwSt2hj8kBcYs0FUbH16a/I1AOBzP30XEvpBIh2Vf?=
 =?us-ascii?Q?2xFOX59sp2D5MsuLkepr2A6hxB7bdiEDf1j6bLdOPqfylVbZQuniqItHxBUR?=
 =?us-ascii?Q?CSb9PVnQG2huh7a71vlj4QHH/Jyy8wuJ76tVQLBKXuEp2+OYms1TQCgeCJFq?=
 =?us-ascii?Q?ljOicJQ=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?qhxF012AdwyYO7hBneUgNUKTDlRT5JtXisYdWKhjVtvsqQD/y5s1i/w7fr0M?=
 =?us-ascii?Q?rTOWtQBoCKd8K7zdlDc0iafFyTYLEKxKVKQH10mTkDyPc69d24usVRv3hcmq?=
 =?us-ascii?Q?CIKMZWfTkwxAES0UMkHA+oiCBiPi/42NjEUzuGofbKKiqbLRraxlelqUoQGj?=
 =?us-ascii?Q?vF9zAsCfaf2w4IPADGs0iQY6vJLyyDXLfZUxf9E9b5PdhzSAwBWSFgqviyaU?=
 =?us-ascii?Q?IzPRRLZ/i4lopn2SN/y8pmzBmv5CXwV4NJ3k4kGGUucdsPV1ArxNt4SL0Hoe?=
 =?us-ascii?Q?tI5s9MYfjZB7bf7kblvL2ld4qeJHcwsnxk589rg8volrfBq4RW/oTvS5X6gs?=
 =?us-ascii?Q?gqSXZWx9O10Nrwe2lQ/D+0TYw5d5eFg1uU8zkP+GdcWA9eDVAzafRy1okdEB?=
 =?us-ascii?Q?Dc2Qd5B+0MmxYUeibjDqBuFu8S9I07J/nMHpl5ppRlnzj7o+B+9xItTSevUU?=
 =?us-ascii?Q?aOO7YrCBImlSLUMm1DmK+7h/CQxkhR9TfnJdmFheAr2LthyFtMm7ieOsuKyR?=
 =?us-ascii?Q?Hc39gegfS51sbnWeI0FZc/CkpUU+jwOpBcDDs66eiKjikntxsZ7kbvOi92kF?=
 =?us-ascii?Q?qj3/K+nBJtH9NtEHQ92fy7LI1KR892zh1RkLEWNFhsTXEh3rwuIuVQ+qbQBu?=
 =?us-ascii?Q?+2RrEa8fXBLXA1b4VQnofxV0VitODtrir8LrKZxZC1w5sobS7lmcgtDF6sGY?=
 =?us-ascii?Q?uHFkVGgH4H5oJ0MGzgPqLFuTScAHnQwzLJ3W4RruXyewfjptkBCckpCP1/sw?=
 =?us-ascii?Q?CMmLXi7hXI800Q+6JdhnRMn57t5rA0RAd1RAMMDUTp4ri9MaMha/7k4jDEhx?=
 =?us-ascii?Q?K07mmlgll2gJMy8RbsjdTvZ5MWHstXaivQJX8ifagzeUJSF5r7JZBuRvrkGB?=
 =?us-ascii?Q?3Y9PHRVDCC8H/T+ue6pvfml5xruVOhvDUkvfqZorAmOvbcE/1ZCqjh17WJFw?=
 =?us-ascii?Q?w0jwwXoaRDO4Wjpea71xiJ3HBX/+6fMr/o6JHFRU061PbBCIhM9gGncBlS37?=
 =?us-ascii?Q?gt3zTW8eKttzSUqGftMRYAotZBEfSk8tuT+XT98/5SBysA4qKzjJRZCpEd0t?=
 =?us-ascii?Q?kJp2a1qBDz3o97zLfZhLI2TapBhE1y7cpT4uE181uB6Za9oGPZu6aai1SlmP?=
 =?us-ascii?Q?jOdAzay1jC6MtThWLtQ347EoS/pIyW0q2cMPWO/6Zl/VLJ2ceL5zE9s+1tG6?=
 =?us-ascii?Q?39VrVY7av4GbyGQu4zNsDbMp3/4NIWR+VOZQa52UPyEh9GCR0qX+Mt1otPLt?=
 =?us-ascii?Q?6WK2yQ1xF5XwDuvZGRmAoSE+idwVZBaDohoLuvsLfm6l9gKlHwMuq8cOWurK?=
 =?us-ascii?Q?I42vo3xGBE6xEwzo5nHcvwAYMAfJ1pE/MM5WhwcCyDH4HclIMPT3zL7HA1bk?=
 =?us-ascii?Q?PvZtcNb5EyOpQS+xzKRWchAyQLiE+wEI54+uVb2csU9D4fBkSgsBKcejn6d0?=
 =?us-ascii?Q?5HiYwEM8M1jKsPpugngnfy3isbk4nyLj8GaVvzCuCG+UVhJ1WRVcrM34r+20?=
 =?us-ascii?Q?PAPKI9oYhiudlb1g/1O6sTnyEFIfEoMXwzSYfREFDNoO9yutWSRQtnJcgnxN?=
 =?us-ascii?Q?Thn5tTWD/H6R6Y6dhqycBcHCcBO27xaX0le86D+Ijr7pTtxdhy9/PqLV9iuI?=
 =?us-ascii?Q?sQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	TIbZ9CmMteQzC6kgNA2zIRxIelMNJKRMOZCp6t4Kc80pLa6TEaTC20N4QTOo6dw6gOtwd6x7riZxC5PzGI9Y8M/PQSOOA14RAwf6+CZb3hS9fnBgNP25lNa5f4uICSSdbUve3yFfyavv8NBNpQ7zW1L8KHG56hDuy8vnjrsHnUliFEWW//6txuWA/3yontHe/y3DmamgILrWsR6vSmnMcBqLUUwWW5eisjb2dHlNJ7Hx8v3G2vC1j2pKzuOpZ9PbQi1ecmIdF8uLlIFNfRIDri8n/PGh3sPGwKLfilPmPTpd47z0aXVE6PrM22RjeAE5zKwDCbn4PXvJjigOx/enz4OK2U51uz4smEs0GdwvtSQwDnri7GVV62ZfPzqtjSnqglcxRr894UWYXYvn+OtgTBNzAaLvTnUbYpLuRqelfOPXs55Aj81SjksFJBzm/ziz0cxtkK97JcNPwaWV+qZ7e8/VztvX5rWPYSfTM09FdI9vD3Gvfxg2fwHGWe+3SH/Hmj2eCNoamM7rQNIK4gJ7dCApzbYrscOeqgvEtyK8KcECnyldGC/IQhmtTM1dEYwi0v1IEMc/Q/JW9IWQIWZxyJvja1GfUl8U2CguTE6vBOY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ff0a57d5-2879-4ecd-7bc1-08dc9ce8d61b
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jul 2024 11:51:41.9276
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HFr4pj+WcHlRSq3Afr1j4LPpAgoo8toHK5N909Sx7B/4B1LAMUdhXBRHYszxP2bTb3zBVGbDbFZDxspPehJhJw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB8080
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-05_08,2024-07-05_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxlogscore=999
 bulkscore=0 suspectscore=0 adultscore=0 spamscore=0 malwarescore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2406180000 definitions=main-2407050088
X-Proofpoint-GUID: ltYVS90xjz90BvYm3uCc9IM0IxxmHUBA
X-Proofpoint-ORIG-GUID: ltYVS90xjz90BvYm3uCc9IM0IxxmHUBA

This series adds validation of the logical block size in
blk_validate_limits().

Some drivers had already been validating this themselves. As such, we can
mostly drop that driver validation.

nbd is problematic, as we cannot only change to just stop calling
blk_validate_limits(). This is because the LBS is updated in a 2-stage
process:
a. update block size in the driver and validate
b. update queue limits

So if we stop validating the limits in a., there is a user-visible change
in behaviour (as we stop rejecting invalid limits from the NBD_SET_BLKSIZE
ioctl). So I left that untouched.

This topic was originally mentioned in [0] and then again in [1] by
Keith.

I have also included a related virtio_blk change to deal with
blk_size config fallback.

[0] https://lore.kernel.org/linux-block/10b3e3fe-6ad5-4e0e-b822-f51656c976ee@oracle.com/
[1] https://lore.kernel.org/linux-block/Zl4dxaQgPbw19Irk@kbusch-mbp.dhcp.thefacebook.com/

John Garry (5):
  virtio_blk: Fix default logical block size fallback
  block: Validate logical block size in blk_validate_limits()
  null_blk: Don't bother validating blocksize
  virtio_blk: Don't bother validating blocksize
  loop: Don't bother validating blocksize

 block/blk-settings.c          |  2 ++
 drivers/block/loop.c          | 12 +-----------
 drivers/block/null_blk/main.c |  3 ---
 drivers/block/virtio_blk.c    | 31 +++++++++++--------------------
 include/linux/blkdev.h        |  1 +
 5 files changed, 15 insertions(+), 34 deletions(-)

-- 
2.31.1

