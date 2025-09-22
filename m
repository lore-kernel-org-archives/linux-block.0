Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AD19285045
	for <linux-block@vger.kernel.org>; Mon, 22 Sep 2025 10:24:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758536698; cv=fail; b=o7JAJCiRjJp3PQAthyVpmLL2qa7X22Ble5e7XxUSusuENTftkvnrY92jgYOAuO39BVdV8EZGnGWlJ8+QaEvoXlJ146rw1qtfOuBm6fC8eZPT7gRJaGYB+MLEZSL8IGk6F5zz0/L6gMmNYqLOdvy2C4MYO8megPJiu1a1Q1l0Ag4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758536698; c=relaxed/simple;
	bh=r4IqOZnf5lixYLrm9XwNTIoNgBjtH2q8j1EDuyyVpvM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=DOCTExGxmfkrimD1ha4gW5fu7Nb6NeW+p85EBG+5VawM5wr0p+72GeetLh3ExI3gH7QtobwUdabktisYhM7Pi5WUeSv5VAKKk7qR1bBHN5AFh069iAgWUakkSbLitb4hHZTThciXRu6cYf863sZg1Hhu8+u+yEZPfICMXH2rEEk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=DB111uRs; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=oRtsIT49; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="DB111uRs";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="oRtsIT49"
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58M7N3eQ031363;
	Mon, 22 Sep 2025 10:24:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=sWCBX56oJM7ATzl3cdTjXtCN1q0RBXICO8+PA0Co8mQ=; b=
	DB111uRswpP0b+mWEZtu36yO33QBeFpHUcHykHXyjzVI1tqNC7oiMB2Y2yymgHS/
	NVDdYkLymn22FOW0DcDLv0MuvUBcQC1EqFOQ2R+Ovdzhzi6gzNZmPbJf2Sel6IwI
	+Uf8fB50l8sPhboqaGFhH+ekaBeF0ab2JCN2I0a/q2iRm/CnANIFgcU5qnRufi/M
	ZwUoe6cZT8vecNO/IdQxJ+4n/A4XemXpK0GXnBo0CeoNJuXLst5n9jKtpYEuQV0d
	LnAmFdjFz7IIex0OdB0fRy3j0SZIonbtZXSYeCUa5WKf5RE/MBdyGjIG4VQp7ne7
	ZXXXz2s9vtvLKQYD3T5YeQ==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 499jv124fe-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 22 Sep 2025 10:24:56 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 58MADKsR034256;
	Mon, 22 Sep 2025 10:24:55 GMT
Received: from byapr05cu005.outbound.protection.outlook.com (mail-westusazon11010018.outbound.protection.outlook.com [52.101.85.18])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 49a6nh41wt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 22 Sep 2025 10:24:55 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eMcS2eCbRiEtO5fC75DDhUp9hP1RxWMFg0cjFjBZhT82N388suMgoTPScwLEP6eb3jSNKKOiXPiH+vfGbD5gQhkN0TRnLMn1gOW7GusLSaPXe5WfH+HjffUzS4phmPPOwEEc/o2sgwNZXTl7moyfhgGT3Dj83gCEi8rLJv31NfAV8RbF/JcismbdtdrxxaMiW5Y/2SO5H6MtzI3Ds2SJQyqXkFp9qB6FTpuUjdwkIwSerb9xflBne6C5G+RiJEEueUS1eYuVDH9OQGxGwNBanAzLzv4+vdqtGCiVmNFA+kUJ8eYPd7X4A0ZJC/udcwT+auuqouUvtvPRIJykJxhMfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sWCBX56oJM7ATzl3cdTjXtCN1q0RBXICO8+PA0Co8mQ=;
 b=rAIT5wPndhOrKJIiprw21h2x08yVRhMo2i0tqpQF4mGo9zDhInbatxbEbUlTlAcI9aUStHbWqnEWcMlN1+/NBowdH845duJzLSLbFuf95hGZdOk2aLB0+sNUnwCb+athgZ3v3R+hCq9xrii5xly4DmE4RxwRK1+oMGrfeMgwbj+4qVN3IpLhcD5f8SfKTGgaFYhxUKmeB10ZB8LomUz8cjcDFy0MNa0TwDJBI5dNspgcNa52OzsSeciUm3vSd4+Z9rYsAugET2KF6+l3/bdkdFhN/XSqssjfjjgcK4nm1DVENUmotKw51rn78OzEnXHnT/lpqcGwTSRHmCOQec0dyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sWCBX56oJM7ATzl3cdTjXtCN1q0RBXICO8+PA0Co8mQ=;
 b=oRtsIT495o/hgNuEEdN8Gw3r4vK3BBZdxbygruelhJzcDmaymYL6wG+ql40ne0cDPPyTVJYqbTdhFBLWZ8l7oeV6LuBaJP8xUeEQPvEt7ki2hvnHEZX416zQYudJi3F4Upo3IN+Fbh+IpjSWhvNjQ/C6WuZYu0Jh8Uhzuk1lvd0=
Received: from MN2PR10MB4320.namprd10.prod.outlook.com (2603:10b6:208:1d5::16)
 by CH4PR10MB8097.namprd10.prod.outlook.com (2603:10b6:610:241::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.19; Mon, 22 Sep
 2025 10:24:47 +0000
Received: from MN2PR10MB4320.namprd10.prod.outlook.com
 ([fe80::42ec:1d58:8ba8:800c]) by MN2PR10MB4320.namprd10.prod.outlook.com
 ([fe80::42ec:1d58:8ba8:800c%5]) with mapi id 15.20.9137.012; Mon, 22 Sep 2025
 10:24:47 +0000
From: John Garry <john.g.garry@oracle.com>
To: linux-block@vger.kernel.org, shinichiro.kawasaki@wdc.com
Cc: John Garry <john.g.garry@oracle.com>
Subject: [PATCH blktests v2 3/9] nvme: relocate _require_test_dev_is_nvme
Date: Mon, 22 Sep 2025 10:24:27 +0000
Message-ID: <20250922102433.1586402-4-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250922102433.1586402-1-john.g.garry@oracle.com>
References: <20250922102433.1586402-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PH7P221CA0076.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:510:328::32) To MN2PR10MB4320.namprd10.prod.outlook.com
 (2603:10b6:208:1d5::16)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR10MB4320:EE_|CH4PR10MB8097:EE_
X-MS-Office365-Filtering-Correlation-Id: f5260aa7-3cd0-47ce-47be-08ddf9c24180
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?tEKvsDdEe8pZTg7TghIbSZTUwRA8RMXSnXpiniWc9Orzpxy8v0/lbATlSehg?=
 =?us-ascii?Q?pQBj+xACQWaYCMeX9pd4uj/Sd6szfN1eP1/n/zU07DwRl4pHKz6Va+m0tzGS?=
 =?us-ascii?Q?fufzndJKElVb1AGf8OAomF65skczCMfXM+/gbY+psvJmkQhFeP3arkfXTl6w?=
 =?us-ascii?Q?CBcJRJwWghE84ZHf5oUAucMp0/OQEfasxM45cQtqyYazoR3PNxIhnEFcaqGM?=
 =?us-ascii?Q?EGq7yBVQaTuGVX6utZEBHW0D+1R+GZw6y8EHfkKMR1MApw0sbAwfPmCcLjK8?=
 =?us-ascii?Q?i462l1KU9yWLT0OyT4a91O3A52mVE/SFtt+RdciSu3QB939K6y7JPwjl+0FI?=
 =?us-ascii?Q?bpXoAze6OBK2xQSkHgyK1Km5Q59ry4mOFQxvaZXFg3ZkAcdrKWoAbHVLTBWw?=
 =?us-ascii?Q?tafe0LJtrUrj2SiGFXmvkMDAak9c7esAJ/OzmUsUt8HyadcG8OLiMtI3tPpi?=
 =?us-ascii?Q?aUSvDjIJ2ZN40ji3UVY0nu1nPG4Pi48pcr/fMe3Cxd226Th6LHWpdmCXG+e6?=
 =?us-ascii?Q?umIpuOBN5jntiulkPuxAUUzIqAifBG5237ccfLtg43Xa8BGDdZWc6g3owoos?=
 =?us-ascii?Q?ZgErIf9iqKbjyPPVCfA7DOMfqlYZOFL+BTFrpVwBrfNkoj/rH+9BDe4f8zmD?=
 =?us-ascii?Q?OGtSkhewTJUL6FgrfhTQG3alRtDSqGL2R3PifAHSA+wsUsRLvfEhqN3rksgP?=
 =?us-ascii?Q?Qgu3GYDq31mI+aAyPo5Jx/j3S/NgSiTjA1HI0c9kg+BtI6DqUWDZKofLqt54?=
 =?us-ascii?Q?bByQcS2uMCW+8Hu7WgAbkI0HFsNdRO3wXt7Ou4JFIDX+dRD1xX+pgtETkeL1?=
 =?us-ascii?Q?y7sWMVEmODieQ4ah/Hq833t8XrOQ1Q9pdjQX7QmwgZkdTQ0fTIjR2DL3lZMH?=
 =?us-ascii?Q?y3VbInZc5r3IYFYGItMpytRRr1MPV1RIfJ5H0yjYu3o/K49q90rgIaTXFdkU?=
 =?us-ascii?Q?3MF4WBH9Xx1th8TH6TfrbkgvO4iHdW3hdbJMM1C2IH1iu12sWffxZbOX/RFy?=
 =?us-ascii?Q?zgnxEdPTpIavTwgIe1BKFn1imNBwvk2fnhlIC8hHeHg2G/VucPYYUlxrceOD?=
 =?us-ascii?Q?3TR+2fEP055KcFhOIzKy/EfmAyP4h/r0LjLc7p2TJ5VTxRnOhp2mZDKnLpRI?=
 =?us-ascii?Q?F11YPfu0mkvfEnijSd7EBSieiq7BKd4dnS4n96ESmT3BCtqMD5oYTas8VBXS?=
 =?us-ascii?Q?2V2M/knPfT0z+g07id/VizN1W+MRNZNafpN3j9ji+Df8AHAHE+OVPxKh9jEA?=
 =?us-ascii?Q?D1UsvrwScNfIPg3pMyq12F0a5SWD90dIWRIi0K1vqfw6mRsjbfObdT42rDg/?=
 =?us-ascii?Q?6L/Qvj4cjnYCBRNhwuKOHUPDsvIzBerYUL2Mj/Oe8b/4bI9d6oMRjfmNXNOg?=
 =?us-ascii?Q?RKQbBjiZKeRkG6NzXnXzpSxRYUpOTVdeha99Zk3EeBQrlfYW00HMj2G28jqI?=
 =?us-ascii?Q?nvO2hYIU9iw=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4320.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?chNzYkBgkqvqqWk3yGzWwj072rPyR/CJcvKWA6stTRiFuakPpNYVUx+rFjwQ?=
 =?us-ascii?Q?VGa2P5Q9LZ5YT8RKoOzXh8LAObWq1DaW5uAFZLRfCJF/YFMgASl4BMNyxO62?=
 =?us-ascii?Q?s40PZJYKtuHBiukSNfbOWTuP1bTjszk1sOY4RMHe1vpnTcglSJ1ptOWCdWof?=
 =?us-ascii?Q?JIVSjiHs6Wbw26YHAKZzv7X46rCgjcg1+yNxfWGxFg1zmjLT8aAmHjkljcMQ?=
 =?us-ascii?Q?RuNeLh5i/wkkk4iDmwQVTgMKzSQztr8y7n4ctybzD2dJZOSALGBDowlkwtq4?=
 =?us-ascii?Q?9XgmAbQWgHOBIxheo8syLs4uX28D9iOFZqevGP9iHXHnVVSratrqpfip0dYj?=
 =?us-ascii?Q?UTfkQQgNzv3kJhcVKoY52/AeBt6+NEca80lpAHEbymsruIIxHc957ITfEhZ6?=
 =?us-ascii?Q?rX88aymxHsagXAai6UmnLBjc9TGVo/m1MfOW23FavNf5QCMgEGLB5fQYw8eD?=
 =?us-ascii?Q?MNlTDIstiF+U0z97qZseLnOOH1NnOpqJEgvUmMqcPqQOczYWXY11eFUHR4gS?=
 =?us-ascii?Q?oN5M54ns9NxAN/6Mel6qJNuHoZQJ9azCayWfZDr2BHUO/ax6cxJt5sAzKOVd?=
 =?us-ascii?Q?EsoCmHxM+hVZg6udbIEHRxM85urqJMa60wViDE0QYt+IdpV+7hHC7RtVwiOr?=
 =?us-ascii?Q?3LA4d3mvhDsWUiQB3QPhGhLZYfzJCXvqJmoJOuzoBtSkJZ5qK/8B/JJp120B?=
 =?us-ascii?Q?wMZj+uJPG3vB0rzE+KY7si/W5L7qDs58WmqHG9JAkLsCzoiFj9offQv7J3Ul?=
 =?us-ascii?Q?IeKpJl/QSZeb0fI3jENzzEb795vgpROpbI/XtqaKbfMz5DkSFLpr6D9XZTxo?=
 =?us-ascii?Q?ba7a0pSJr95fv3ywyb9xlUDhGj4+2gLijEtfc3BXnGc6fB8vJcWRwuR8agiT?=
 =?us-ascii?Q?oYhMOGVzYhAYfpOfRQMxRP4CDWAFn0OTSs+5DI3XpwTHaPk/MfQuUWQdXH05?=
 =?us-ascii?Q?LXxSfCd8A8umRHxZUD+u1KUz91QYNxcH+s/B1OE8IzzokAM9x2tSsbYfjPhl?=
 =?us-ascii?Q?ppqrG866yz4VOhq8NDZgoZDIU/4ZLB9LMsQ1eEibpcRirX8R9+jqMMAoFL2z?=
 =?us-ascii?Q?OeyXYIi763Mi/6UPZOiPUwCNhXBi9ctp1VFkGWRZmwxdUazTk2x0ACFnqwt4?=
 =?us-ascii?Q?JQ1R29ZPE4kymVpKahEPENgmO2hBNCdJaKgXEhVRA5viiMy3Kd6BGFu/EfZr?=
 =?us-ascii?Q?u7XqdcDJNIK8iJi9MwzEtkCszynKAhfuvDnGuj/caWDTZpFrxT+frZvaJBGj?=
 =?us-ascii?Q?0K2C29DwVeFNFGzGtlYL4nr0ECUYXRUKj0AoT76P0u0t/jIv7otEuRVYYvgg?=
 =?us-ascii?Q?kTp+J1fIOxQQlmgtjL6pIdnZUrOKHLNlm7kE7Jn85Ywe+E2zkuO71OPb8JxY?=
 =?us-ascii?Q?5h3SKVCJ2TAb4BOsUJNwW3BgfBldZRiZk1gy3nGZjfBxye4eKRkQW5VPHIX5?=
 =?us-ascii?Q?jzqm0V1uojIVwAkCysiMu40/PP3Cgk4XHkej0RxM8W7V/2T1Lx91EsKp68T+?=
 =?us-ascii?Q?pkILbQRanCudRN+5y68eKJOOinw1YbfujBMFxxJGxrQpvWe9YGbagYJ51B5Y?=
 =?us-ascii?Q?Hi3W0bfyb/Wc/i8iSMLZddBm+lkTx984//b3W1N2fC05Vc6x4ZFg82rr2vAQ?=
 =?us-ascii?Q?1Q=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	1hROCpWGouSVWaer+MvXqAaY5pYsAZQa6/5b3zJda5WOOvcTY3gJzXwjvHg/dqIDB/yKtDsM6nunJzC2JdWLBAKFDO8SNmZXz/4XUrlyhT+p0SMJVakkZ2kY/BiMNoTVME1NO0jvpcmt6E1IixsXWBAI2JTsq4251wqOgAWsA4bHSxfnxjcIKcz5gXWCPca+SYTfkgU6kwUCYHyVBqo1fq53nJc7pStUyBjWi5jyXH63jFIlkKWwtmU9715lqCNgfxa38nqld664+aBqArtyvHURJD5u/jtlRdgASMaePdqKA/SmmWXf8anAzczv0d838BWvA9nEuW3aIuUVQU2Rebzcnt65TwQlgyf1lreW/S5EIJF4C7Tp2ygRuFntRRpFWL0kalFVrchctMBw0RjOYm/iOcxGvAbA8YdIhST5Z3Kh0p5jTAPJcdqtvKyk0v7VTFoDxuYedAb9d3dvEh++wKiAeAXkz+f1MU+J7YVycZBzY/mY0nScopJRdL8i7MSO0XJ/oC/t8EAgJlZlCOrmHrEIWYATF8uIAokvYupEkqD80eRAEK866uiSUacFipYwy7gM5B1b5iVWcyj1v94WM6yWZWszGXgi6l7yOYjuzHw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f5260aa7-3cd0-47ce-47be-08ddf9c24180
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4320.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2025 10:24:47.6275
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZAvgk/oQTuF3rhAtK7PMFvXobk8gid4IKQFZ3LQ8Yi2NNwpWKpzUURUaM844huFWKFO0/w7buLMJ9PudqAhWSw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH4PR10MB8097
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-22_01,2025-09-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0 mlxscore=0
 spamscore=0 malwarescore=0 phishscore=0 bulkscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2508110000
 definitions=main-2509220101
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIwMDAxMyBTYWx0ZWRfX67ORlUyRvN8G
 0+X4y2LtPuLRzU2Ixg8tgwLg0DN4vVgo8gZvIk/vZ53ud7s9LOzqvpXGpB/Yif6S8qWEOI9qPTH
 XcNLzjYia3O0P1Z8Kvhq5/VUp5DzuG+nYiUagUKEXlk4zpQ394ngO+YAfe2D9VsW+VL8fROPhej
 970zGPx/UC1f0T8ulPVh+KIszaHHWJl2nNvT5O28C0NmRD9qq+hUFOnUL71Aq7QuwMcXYHeUUPH
 zfRXm9VhjXrnxWSLaeT9oMs9vtXm76WuLi80r9qGKNkMG3BGcZj/d03kq9klzJnVZMwtjtlp+YL
 /uYQklzJVKnLc93y9iG3brrE2jjNczM9xOd6izmAcqlCyC8uG9UU9aqZbVwEKzk+3CGRIFHEtN1
 6RZQWmD04YRjXpGB4MlMCSmI5dXT3g==
X-Proofpoint-GUID: ZyT6OYoIojszVizbYl4QMeShqgFUOgjO
X-Authority-Analysis: v=2.4 cv=YrMPR5YX c=1 sm=1 tr=0 ts=68d123f8 b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=yJojWOMRYYMA:10
 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=Kgtbm8pHpk71dVNKvUMA:9 cc=ntf
 awl=host:13614
X-Proofpoint-ORIG-GUID: ZyT6OYoIojszVizbYl4QMeShqgFUOgjO

Relocate helper _require_test_dev_is_nvme into common/nvme so that it may
be used for md tests.

Signed-off-by: John Garry <john.g.garry@oracle.com>
---
 common/nvme   | 8 ++++++++
 tests/nvme/rc | 8 --------
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/common/nvme b/common/nvme
index 26b3b97..c3e0df1 100644
--- a/common/nvme
+++ b/common/nvme
@@ -1174,3 +1174,11 @@ _nvme_requires() {
 
 	return 0
 }
+
+_require_test_dev_is_nvme() {
+	if ! readlink -f "$TEST_DEV_SYSFS/device" | grep -q nvme; then
+		SKIP_REASONS+=("$TEST_DEV is not a NVMe device")
+		return 1
+	fi
+	return 0
+}
diff --git a/tests/nvme/rc b/tests/nvme/rc
index 33055ef..b16418c 100644
--- a/tests/nvme/rc
+++ b/tests/nvme/rc
@@ -71,14 +71,6 @@ group_device_requires() {
 	_require_test_dev_is_nvme
 }
 
-_require_test_dev_is_nvme() {
-	if ! readlink -f "$TEST_DEV_SYSFS/device" | grep -q nvme; then
-		SKIP_REASONS+=("$TEST_DEV is not a NVMe device")
-		return 1
-	fi
-	return 0
-}
-
 _require_test_dev_is_nvme_pci() {
 	if [[ ! "$(readlink -f "$TEST_DEV_SYSFS/device")" =~ devices/pci ]]; then
 		SKIP_REASONS+=("$TEST_DEV is not a PCI NVMe device")
-- 
2.43.5

