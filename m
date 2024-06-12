Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5147723CE
	for <linux-block@vger.kernel.org>; Wed, 12 Jun 2024 01:57:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718157438; cv=fail; b=R4WT/IFVdutwenfkUBkVySPVy0s3o2tQ0+r7Ft8hdrYQhO4s8rrBA1v6J6s5aaOxKfU82vlGh0k2mo9uOxeFOWp6kXmxtEszdmUfNfVPnaLhrgQsCI8TOvzRFokhigcJeWhlErz+sqySnRBIO5ZisHKGjCLOiU2NWFhjZ8rvVkY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718157438; c=relaxed/simple;
	bh=Yf/Z5KjS2bZWDsNRD3m5RYZgXAc6/6OIaXjSkOOSJy4=;
	h=To:Cc:Subject:From:In-Reply-To:Message-ID:References:Date:
	 Content-Type:MIME-Version; b=udyqj5UnJfQ+X4a8XC0I1Rp1CDrA3QWfVtKz2Gz5Wut5utr+mTt26J42muhLb7qz2yWHZ4f9wUGPzELNejrtbkePUmSjnNQmDOqlpqslsuohcgY6Gv+y5jbLb7EL4xnKZVBXNNcZeMbMC7U13i8o2MiHKnD6u53rgfspKmFmzbg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=OscsA7ov; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=R5urEDAl; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="OscsA7ov";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="R5urEDAl"
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45C1txIa007865;
	Wed, 12 Jun 2024 01:57:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to
	:cc:subject:from:in-reply-to:message-id:references:date
	:content-type:mime-version; s=corp-2023-11-20; bh=WV0Vm/WHUBCluU
	KEiiLN8GFIank2JruSP1Rt9M3xfGk=; b=OscsA7ovvVfUfLJOyls3tSQIcqDE08
	us8UHGVnD9SrkxQnCEnDDk2nbcAj8RWUhRRJVD7pc+YRbeuUi54d+2uFpToO2Wda
	aLrZIGDs5iI11vwew17Kmw2yJhv5FLT7/7vblsUuajvKNnEzlAEqu8FwhAJEqNBE
	pj8iYTGlfGq6fyDGH45YTx1NoHxbx9XNWLzjEwxAnpGRVUUZU6K9Oox/KFl3KBqW
	szl/8RqFzCQIzjyUYH4gAaSsyArEGol9mDQw1WDckVPXiL2udzKXC45uFMnUeI3A
	SvhSSw4xvrC6f8nlgM4ahA/ikWLiwfQG4OHx+iyQEGjw5RVVKAIaDN2w==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ymh3p626x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 12 Jun 2024 01:57:03 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 45BNOstF027293;
	Wed, 12 Jun 2024 01:57:02 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02lp2040.outbound.protection.outlook.com [104.47.57.40])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3yncdu32p7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 12 Jun 2024 01:57:02 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fZB6YY0+P5QUGT22BvVOqZoLBynqCzuWhXOtJ5M9vzPQTaq/v801J92ePoVCXFCeoIKGTNx745oyW1l7OkKngEiWvvGJbScKbZaHNi8QKqHsp1N1IQu7VOpJX3Gbolf2DOl/QyjG3+CVwagnpuaSVYEhkEwLoaciFOVJ2U3+WLJKcUOicnHQQ2fNrI7CE0Elpydfm0CZdEuzbDk8Y79Xgp99IUYHk8N6q5NcgXoOzRmGO+ZDLUsNtQhdETLrhsm29wVfEe1Z33aIybz04YlPXW0iLNskCh+JS/DuzuzxiUJFKhzvAA8c6nQLNlYlRNLaDAepePJHAYARDcA+0UbyfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WV0Vm/WHUBCluUKEiiLN8GFIank2JruSP1Rt9M3xfGk=;
 b=H668KjVZLAbpaxqMHQcOo7zolS1fsrqWUZuUaJhkFbzVhMqysCyovVpajNZaFI3jTSU/cDaRfUq3PX9sUVBJ2uVRPUJFwQiowa0t2JywXRIpBbiAaHhQb50Ya+YWOtD/g8zFEG8FZhfxHkYdMSi6in9+EdiABGBBRljXQ1Tclgl1eXFvTL1eBfOJDFqVRJWx8HI4189mFTKoH7fdRPjyioDsEWL9Hbspi/cbWBRFUG8KrD5/RZ8RNLlG4gxP2WcNiXGUUEDMB+UQg2fjBCCjdHErLRjdHktpYGbqLV0S+ElYPckGCiig176+Ndy/7DCns5LzDpJLYy3wy1+PGG1RLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WV0Vm/WHUBCluUKEiiLN8GFIank2JruSP1Rt9M3xfGk=;
 b=R5urEDAlruPIYM1HZkvQA/TeNo6P3yl0LTcPb0XqPkDAlBky4+IdMeyRQOJMJfsaeOSjE/jeXuhhOaSejuj+cH+M2/tenx4ip/qO1Zt5fHA6KX3Wiv5Mct3Ki7W6Zm/aZePD87AdoOnN9n5rJKngzv+GhSUxE+amlYrnW3umbHA=
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by SJ0PR10MB5860.namprd10.prod.outlook.com (2603:10b6:a03:3ee::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.22; Wed, 12 Jun
 2024 01:57:00 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::5c74:6a24:843e:e8f7]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::5c74:6a24:843e:e8f7%4]) with mapi id 15.20.7633.037; Wed, 12 Jun 2024
 01:56:59 +0000
To: Anuj Gupta <anuj20.g@samsung.com>
Cc: axboe@kernel.dk, hch@lst.de, kbusch@kernel.org, martin.petersen@oracle.com,
        linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
        Kanchan Joshi <joshi.k@samsung.com>
Subject: Re: [PATCH v3] block: unmap and free user mapped integrity via
 submitter
From: "Martin K. Petersen" <martin.petersen@oracle.com>
In-Reply-To: <20240610111144.14647-1-anuj20.g@samsung.com> (Anuj Gupta's
	message of "Mon, 10 Jun 2024 16:41:44 +0530")
Organization: Oracle Corporation
Message-ID: <yq1plsmylcv.fsf@ca-mkp.ca.oracle.com>
References: <CGME20240610111927epcas5p1bb534d0a093a9d1243a78a6a93065df7@epcas5p1.samsung.com>
	<20240610111144.14647-1-anuj20.g@samsung.com>
Date: Tue, 11 Jun 2024 21:56:58 -0400
Content-Type: text/plain
X-ClientProxiedBy: BL0PR02CA0001.namprd02.prod.outlook.com
 (2603:10b6:207:3c::14) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB4759:EE_|SJ0PR10MB5860:EE_
X-MS-Office365-Filtering-Correlation-Id: f20ed321-243f-442e-e108-08dc8a82f279
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230032|376006|366008|1800799016;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?lPSe90J/PzU13OqPWB6NVpU+pSuC2Of9DQlQsqWqgxdGWphWfL1EKTbHQUXJ?=
 =?us-ascii?Q?Y1zyBlLqxjomhGUX7C20n1+vlcf3xM1IByJ4Z0tNU7sRuSWKDFlk/8WHUjxY?=
 =?us-ascii?Q?wwECiTH7NSRp2JHmRWoiuhJVq8DYu+I5l1c2wwzY8B/WbzDMGZ/8pZjcsscu?=
 =?us-ascii?Q?0PMjFdoPhnJWMCSWe6miMUCgqyw8ffAfUTOlONYG2UdmO5RF7hoiTbY/TwjX?=
 =?us-ascii?Q?C+XR4IJdBFJhVsGAmx9BZTg83ThuUJxZ0+7oT54rcrYQqw6LRuPFGc+VfN7C?=
 =?us-ascii?Q?TfK0PfKaTcJVDTJ+MMd70T8zdmGCClqmHAJ0wn13asc5A284LcW6SwE2Z2L+?=
 =?us-ascii?Q?/KfZ3VRkialGWTrjwBNJwc3W1IxhHfm20N0d4YHG8eC3Sh/A8ui1hTtYSTrO?=
 =?us-ascii?Q?plUw2G5GpTk04TYWrjGv41nincT7W862BZVl99QF8ySzmUlVoL/EtGO9eFvR?=
 =?us-ascii?Q?ubPp4MPqBibWUdW9wZgSw04F7gXKzi8lrVuVM0DJRUX5IVSzL7tYhEh9tfz0?=
 =?us-ascii?Q?iYXMvZ5Ihrpcf3yzazQBjYRELvbXlhYnWYeqoI6Cad9A6jFPInCS1FoHdyoK?=
 =?us-ascii?Q?Vb5qB137rXS5HDStjuuBqTl3T/68zMYEK7oAYTwngCJ/5IJS3GN8T+4H5yer?=
 =?us-ascii?Q?PFraGpfbvmbMiMm2Uh1ybvb3ZJe+1dKwIO25h+jg5XUhvA7r9NbkVWFbqNC4?=
 =?us-ascii?Q?rkySFBaYz4Pl/FWP7WduHHQZsnVc8rFwaVQcWW+NDMxC0Awxef/JXM0Sz/p9?=
 =?us-ascii?Q?3w+sLBOTYQAjBBYVTMNmFwH4KsJ0362/2YtF3so6GSUFeGGNDEFARc9qTjQr?=
 =?us-ascii?Q?cCMSUajfTI/RMznw/mPWvJTLZL/px/2Jevbb5KPKD/9cE3ugPZa/vHGCObes?=
 =?us-ascii?Q?Zdcm2J4rBs4Ry3h5HTlFM46QSTWH2DAZ2Gkv5kHE3wm+mFnkCOlDUSAfNEJ8?=
 =?us-ascii?Q?Bww39nxBEfeZElIWxmmAJ0ZuaRP4tl19pTmVpbN4/+I//vU907Ttv4XHNRpF?=
 =?us-ascii?Q?gVCLxHLixmiM9HWVf/dCrGmkBcYBXgaiGp6LMeuFNxcjqDERytHjyqcyk20e?=
 =?us-ascii?Q?Xgd/b4L+bKBagJ69UVDHZn/TDoTzVD9e0v+MivWAxX8xyhnS8D+zuRuRTvJk?=
 =?us-ascii?Q?tdDuLmsvjFjCh+6yaH6CgO1PtoHFyCqfeydEU6VXEPHjw6fu77Ey7RZdxzhp?=
 =?us-ascii?Q?ScHgh82qzGyEoSvucdjUxhZmH0jcfC+snmo6jXIeaW01ghPid/IJLMRg5ICN?=
 =?us-ascii?Q?sen1fFQmDvYy+ujyb7nILCvsZjH9dlHXgyzZKj3FcjCJ3D6Efdy5pFB8MSWF?=
 =?us-ascii?Q?/b02ZKVaNWHLAvZ1QhxitCIQ?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230032)(376006)(366008)(1800799016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?8PR+Cz2mHrIi9akXuABHm7sQ/fC8XGg9bAwurenkbqI8MwKyWNWD9YipcmhD?=
 =?us-ascii?Q?f78j/2W0YvZJr0NVwTRVGPVjZmWwAVpQllLVfNiy/nMnUY6E/VX8739DXtGB?=
 =?us-ascii?Q?1VnIv2YdYxG37x94yJiebkdgcnmkFn/ZoXzV+jII+OHhDEAwOluLnO7Hgu9Z?=
 =?us-ascii?Q?PSy3bpgF5/Rzmxb08K0H4XfmOdTBvhSacJEFinSlfE5rtXmx0utPWcpRpSMD?=
 =?us-ascii?Q?BvKiY3MjzNWsdXHva5kOuPFhiGR83ngmixNjzD3Ule5akZJsOAQ7pK6xnoqS?=
 =?us-ascii?Q?vRTzcVp1ruP9Dr2BNuT36254SmJbVe7QYk/Xqrx4SRJ19RtsZ41KIz4VVRWm?=
 =?us-ascii?Q?2JTfLzFZ/5FiW/loXGio81lk2MEGsQuAHUeTbYgPbu/J1n4qHwEV4g7Z5cbk?=
 =?us-ascii?Q?n8svmXjXtpqy8TEqB0OzWh0UscWnUChkOqINAHK+IHsqv5iNhjJd91KSn20V?=
 =?us-ascii?Q?AqxHSxRv3vYZNXctnZlSkkw4T7ip6D65ZsMDjA+Hc+mlVCtemwE/Yz5x2E8F?=
 =?us-ascii?Q?PyweG8Ca83/v1/MMBjPXSmQYeta7NUUTVfTyikCoWMDpSw7m57g+C9cBfKT6?=
 =?us-ascii?Q?GNODLrAsGKWCP112A8lYGjGgoxE3/zQipNnX+Y/mIxhzmJdfxzyKl2+1RB5J?=
 =?us-ascii?Q?A6mf1zdF3qcKMb+l+Z8ExcXPmbBUp7uCMaQjCLUEwH3GkuieYICi8xFAivdd?=
 =?us-ascii?Q?mrdEqxeUyW1aW6mfsXW4CTnhJQ3oNI59DdftQyV+vsU+03QRr8E+YpVOqC9H?=
 =?us-ascii?Q?WESpDsxEzCv3i+8EJfLwpn2rRFu5Yqx1nChBdCUao9Pm3VUXZrtqFlIlTPKx?=
 =?us-ascii?Q?xM57lVdYJtetQuZ0b8Uff4rD5BhczhwGWCtVqueE2Mocn9KRJwXqdcRhaiK0?=
 =?us-ascii?Q?rneZlADDAXL1PrBImfJ0QXmJHYJeTvnXoO8h8/2Ina3pzEUjIaELeWYqXVrw?=
 =?us-ascii?Q?p5CsB/JBBnmudONgbWzK8ouU+C/fYCQ6LW/oW0jgsrUTyRNSaGQEp2q8e6Dh?=
 =?us-ascii?Q?qsxOoPb16wIGTAcme0cD8Jn7U2nkweKu/zpXD6cvJvIlYs42FlK8tXrCipcx?=
 =?us-ascii?Q?vZDnqxLpLViXFg1IA833+KdH1vXvUhmVQccMhMWWZU8aRiBe4N5tY34qHGxx?=
 =?us-ascii?Q?4T5/K94Xw47YoxN6kEKybkWWQP67RvceGGEYuCuHA0WoZHjrcma0hnQIHEJC?=
 =?us-ascii?Q?8euxCxFyESDmKNHZN1fbEIwwL91EnCmtWw52LetN/QAnzzKDyKJEoHLdKLec?=
 =?us-ascii?Q?4kck6niSY/63JcbLlSss5a6PqbsDeF98YQZWJrtjtmKJGqcxJ8aPiH6kwYQd?=
 =?us-ascii?Q?i+cdQU3hQWQnjgoHdCZcGW2cPTU76Pht4d46X3g6Y1VyNV1onkxKBkfFZlRT?=
 =?us-ascii?Q?1gjJxR6m+lS9MJKTb3TVhsjhQtY+x0ZD7p5rr0F9XJd98f0hA6JS3vH+81g8?=
 =?us-ascii?Q?Md+9uEfJtPrNYhjdRbl+AyIIjobPf82DnP379rrLhzZWbg93DRsojNfE+StZ?=
 =?us-ascii?Q?P83nxoR2l/OcVTeiP4X8WhjMGZmDRb/JArPyQP4a/vbsHi6pyOqrzdhLx2KN?=
 =?us-ascii?Q?KtWW3h3M7C+iOrPSe10tLr2Y+w/UyeyqTo5ndS0d8LS6DV5jyJg4S6oyL/Sg?=
 =?us-ascii?Q?XQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	VaG3mmSPw8TqNfsMdF2C+P0yL6Fzgxd4tSkx7jjqC3FiKc2fJ5axnR7uVs4z7lxzY1YluUbT90bJ/yiC/Zutft97enLm/BUCO5HOaCZ4ErWAyfYTxtVmAnD8QABmatQTO6nRPqRrhbbtYDf1OukCmGVLhWSxokED45QLsVEK2KQc18kAMx5tXhQNgUdDWgLk14ZmQ2LuKtDxM9rSEp+Ohga8/ZNWNuA8SGVBd8EV5nXvgXDO4Bau2PPfR+tt6B78xdwbmAi8SMY4QZo9zawRKsIucBaMC94opbqTrhYk75Q+wIyiZggH0p4+Xao14tHrtQNrD+Xv8gHb/woeHLm/aeSAWrPVJKTXNkVcuM2yawBmTyKymLt4uzETa/adWV869vIa5nZavUxC2LIJGA2THMoY4aX9C6Gm94rS5COpv64U7SGWZL4YxX3entc1YXWR0+0r9jcnluid5kInT7wjHAjGeRUTT3Moc1wIRvWgBWsmBXrbNlekrhgD96swavfHysxlz+k2EGP8WgtqIHZKjxSojC4wtWhrmG8jJN24yFdBwdW6gxXBdzAIeDdgBjbRFJ5Yhowe1HTZwpDG9cTLNiu+TOh13FvbWXgc+wTN2ws=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f20ed321-243f-442e-e108-08dc8a82f279
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2024 01:56:59.9095
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0myHTlt8Jrk+badRbgkbARoCPFn4pfmr3inVmUOY6vLOTJc6xN6qKQJGEFgtEwHi2/Uv+VccrQmhDP9JiVz6Hn3NKQhWi2A78D2kbZzrFaA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5860
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-11_13,2024-06-11_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 malwarescore=0
 mlxlogscore=808 bulkscore=0 suspectscore=0 spamscore=0 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2405010000 definitions=main-2406120011
X-Proofpoint-GUID: 4TTRx3cDMPsRUz15Z5atYSIWT4RT4fiG
X-Proofpoint-ORIG-GUID: 4TTRx3cDMPsRUz15Z5atYSIWT4RT4fiG


Anuj,

> The user mapped intergity is copied back and unpinned by
> bio_integrity_free which is a low-level routine. Do it via the
> submitter rather than doing it in the low-level block layer code, to
> split the submitter side from the consumer side of the bio.

Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>

-- 
Martin K. Petersen	Oracle Linux Engineering
