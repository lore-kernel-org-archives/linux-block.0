Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2DF91514DA
	for <linux-block@vger.kernel.org>; Thu, 11 Jul 2024 08:24:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720686265; cv=fail; b=PC8v3lmNtWwVXCgBcokxhkSSWuqDM/ZtsxqZbrqltfbFyN1YTQFoX3rR4chs4ZdHJSzVKuvfpbHmOafGolfTocjt1SFqhNTWyK7q8qT51BUmS8c+uEzgiQ4z0wKKYV9Su37SzrVYYZIcF+zIa15B/37T5t7Io8SzG3aCuMefUBI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720686265; c=relaxed/simple;
	bh=25RgP1Y9/ubHNpkq6I/nizU56Wcx2uEAc7XMuL5otbc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=MTFo96q6knyvfhHhhQyutufJm23tq3bfLa2ecgcjKLHPoMQ5IVsg3B3jKz1YG1GSIw0/fwo+Nq+AEfA38sUYaB1hbYg2Kmz4Y/QnkueqZJikZESeCClpLAx/jBHZiGX0O+ukuI4e+Nly3EgqXixJ2YFmkeP3nqQlUEGDaE1eNFg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=f6cf1BHU; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=gG/fvrDY; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="f6cf1BHU";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="gG/fvrDY"
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46B7tVxs014064;
	Thu, 11 Jul 2024 08:24:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:content-transfer-encoding:content-type:mime-version; s=
	corp-2023-11-20; bh=Av6KlY5/H+ZO/s2QZAPEiQ9Ze3hf77mbCHwlrwKLJTo=; b=
	f6cf1BHURfi9neaJjUxvQvJHeRcIfFFhQMIdVRYZBzqOXCyh0ShlOfARTbHgLjJR
	6i5L8tP1/k7YUMDTZFbZC4AqGh9DET4OwFrO4BbRjk1bJAzDqtlXTBfVh2gC0Wm1
	8sGNoEHnIcsswWv1/rmhA3CDC5eOG3yN9FCzVL2fEwIB5zJjHwfSQL2+RGLFBrt0
	x07z10MkFlAl3K1EaTfojHKoWYNT7Fh3YToBo3iw6OEqIPB+l7BzzA6gznQ/ubPp
	WPYbglDCUOrbR8KFbnOUWmvkIYPRvPOChdxQyBdp+kS/iAqEunKQM7Ywr3s8v9GX
	BwHgbPa0SpYpOmNhDN6KbQ==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 406wkch04d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 11 Jul 2024 08:24:20 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 46B7I6nU022701;
	Thu, 11 Jul 2024 08:24:19 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam02lp2040.outbound.protection.outlook.com [104.47.51.40])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 409vv25h4q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 11 Jul 2024 08:24:19 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xVSkvJAFej7dvVFtjoOSB+PBAe4Aq5ceWXkw0sMDoxlg5GoYufM15b07KTpGc6vqql8FsX6UwX3rLAO/6MA04S/c0JwPxm0ZpFj+DujeZdaqxTnBnslBbWUfM0C0qCm0PEw07DsagFjY33BN8eeEO/ktBKjYI4wD00oqhvsxpdaen8DB8czeogKFx5qJYDfADogfqxBe/Fal6eiWztdN9peKLit7RM9jv69U6TSvMwsGW9S+ikYi6kCw0qlMx9Tg7WQSoXfc7Y4gebvVMGy1JqKn+I/+hoU6GFmXqpQbaiBwigDhg4RZ+WBdnYykWCqBV+9A+AiJfab44uuB/c5etg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Av6KlY5/H+ZO/s2QZAPEiQ9Ze3hf77mbCHwlrwKLJTo=;
 b=dyMmOYoCU8X3cAQcqRdr2rr7n93/2++RlI7kSHplCr5cHCOnDYelCc1uqOddqpA1q9Blvm8raI2sZsZs/UEE4IC5m0rEfZFx4Rcf+fruJHCmYxFimDaHdthoW3Cs11oxgLcrkDTYwQaRg5HoOW1ZVgf/12id2FFMqp9dvy1f20ZOb50b10Xfhwwaw+c1nwF31G8LXCmR0mZSNCT+zouTtPbSdacoliHHTrxDgORP3+083B+necUj2ZU1AMbUrLHzc8n3s3nJoWHFywDnhYB4A0KtXhWXP53cbIJKPvn+Ix3LTRsTmqZQglQodGGglmGzzvdm1A1Vvg7dQraq18Ubtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Av6KlY5/H+ZO/s2QZAPEiQ9Ze3hf77mbCHwlrwKLJTo=;
 b=gG/fvrDY17Ys65CzSYNMeIURoJZc2LFcLVOD+7ACfly/UzsdOV4acFJlCwmAzq0Yh5dlXMo6+eX88tmBWEvBwvdvyZ3OYroxaVMlxJdUkfmez7GgfMmcVfx5i8IPqxiXIbPnhKJRxbxTujRi3BGdQ+fgXcw0mV0X5JIStrCuMD4=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by PH8PR10MB6672.namprd10.prod.outlook.com (2603:10b6:510:216::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.35; Thu, 11 Jul
 2024 08:24:16 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%6]) with mapi id 15.20.7762.016; Thu, 11 Jul 2024
 08:24:16 +0000
From: John Garry <john.g.garry@oracle.com>
To: axboe@kernel.dk, hch@lst.de
Cc: linux-block@vger.kernel.org, John Garry <john.g.garry@oracle.com>
Subject: [PATCH v2 11/12] block: Add zone write plugging entry to rqf_name[]
Date: Thu, 11 Jul 2024 08:23:38 +0000
Message-Id: <20240711082339.1155658-12-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20240711082339.1155658-1-john.g.garry@oracle.com>
References: <20240711082339.1155658-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0057.namprd03.prod.outlook.com
 (2603:10b6:a03:33e::32) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|PH8PR10MB6672:EE_
X-MS-Office365-Filtering-Correlation-Id: f0a7232e-5aaa-4d84-e8ae-08dca182da89
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?w+DjhbwmWBbkOS7/6Qo5/9RoA7N0Qu4/ThwObkhlQHkwiuFq1aVdtXM6uVRI?=
 =?us-ascii?Q?bCEUmnuQHjk78Cnpb5dGJlysJlJYUsf3/bt28qZFwJPfHSWUoKJGe7BkwWrJ?=
 =?us-ascii?Q?XFhPBxk/fmhE15tQzuFMByMqIe0ZWDD3d0CyO60pM1TEtw4N/j3j4DPtB2Rm?=
 =?us-ascii?Q?klgMjirngJsddTwZsIg9vHGbvU2S68weSgi/BFoa4Mfv18z6CWiexDYAZXLv?=
 =?us-ascii?Q?jNC2zGUuEMG1QmkzCHxlHXU9ltfO9gmhbmg5ckCv6EafbjDVgt5ir5lwMdWN?=
 =?us-ascii?Q?eP7BrN2DhRe0W1My9OCmCk+Pu4lMN66dZWGYsPfNszt+dOwRNQj7mVPyxVmV?=
 =?us-ascii?Q?kaawSbzISk0zvPjqrwncoGPHOK/sakbX2Q/p+v7l42mx4Xu7+B2x2o09xIaM?=
 =?us-ascii?Q?/099HyBJnflPXVDqMVLHbasllyHWquy2wy40td2w+6C4jAXxbrJcyqxp5hRD?=
 =?us-ascii?Q?Xqxdu5PXyX0p1lSpFvCRHeAd9s0j8dhWsf3IyOWiOlpFNgadSd3XK8Xg9ZnA?=
 =?us-ascii?Q?f43X8BceMAmGYJKui2LQvJHUeWRjsn7VjzliG4IdPWqb7QAVdyX9Fjljzr4J?=
 =?us-ascii?Q?GbPS3FHUOV84NU4roijj5HDpw/bJujHPyN2FaJLcGBvTp3Oo/JO5s0cVTZsG?=
 =?us-ascii?Q?wjUDGXm+GDKH4HbJJGOgYDGd7koD/dDAKljyd0LcuqZGUwxYgAw9PwsjNfT3?=
 =?us-ascii?Q?PMHm9nuTRTfj6VAqs/DFRtR9cYaexJ8qHBqOSFVd9Bwqt2BBAk+bc+tycKDy?=
 =?us-ascii?Q?kuYmo8dtdTOyj3XwT48i3cBzeG32JraOHcPpSvg6WRIIX3TIcd9xNdVcNcRu?=
 =?us-ascii?Q?PGKRnJ0psngMpoURwEZEkvgPH1L9Gx53ItvHLx2CHV5NHRHUqLO5JXzUtnvC?=
 =?us-ascii?Q?9HnwKbTM9roOZ80lp/8uWTrXGnCAth+kGGwgKmTywkMwK5rXxOZCYXMFeTtR?=
 =?us-ascii?Q?9vJ3V22ytdjsXjK0pLwZ9dRl8FMasaMG+u/y14mYsNvMV7UiSRMdmx2otnVo?=
 =?us-ascii?Q?sX/VreRe2fVRnv19LjtHS9Jo1IHDeP3/EdNsdhhnhG4ElZhTqllRrYS1HkzA?=
 =?us-ascii?Q?NgP8jq7YRXVl5HlKRLTgu5fQ0Tq7z3hlX8GW8CLrQRzc9BR56moF6OZevvXZ?=
 =?us-ascii?Q?8VsbbyChQelvWXkyTRVnNyFilmJEtP/WjTn6GuIJjNzA6VwtU7UD11G9End1?=
 =?us-ascii?Q?VW5n7d/nG6hARXn4k+/FQXD5FH6eiSMpIvrDUlNCiIhwIe8Mpo4dgYvHncfl?=
 =?us-ascii?Q?/TkDt7sWjn6GzKoNnM7lZ2n5HbxkQZAUZQuHg2Gqmt85c1cmrmxE6TnOlnCT?=
 =?us-ascii?Q?a51As5Xjp6OmgyOjZ+5ox3Xt93IlLviitn5qeDbnwMDkBQ=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?yA7d7FHx5npld5MmLITSTKa7KhJTqdTfyS/XdkAdQmH3RQ4hKp5m4419bogX?=
 =?us-ascii?Q?BN2C46i1ndfU05SCJHo5CbWm9MXjA/erb1Cq01AdCtenIX9kwgzt4MMRMaj0?=
 =?us-ascii?Q?vXwiy8yWmvdBwHWxL93kDYu9S8yWHbdt5udUgmstFclKtz+VE76QNq/p5wlY?=
 =?us-ascii?Q?zRG2wzG9bzOttM0VncuxXLTOgJIlhCyHxKOHx6YU6DVWiB5jel7Hb5BHC+ar?=
 =?us-ascii?Q?aFfD80ZZJ8tAq7xumBkghO8JgHg2dAfOYEdCZpEwXtwPAgB8x/BfMFWUXZAM?=
 =?us-ascii?Q?XLqAmfx6OQalPy+IAroJOWmIf3Ev91osWI7VP838nN0oPWfWCoS2S11FsCup?=
 =?us-ascii?Q?ywJynxPIIh5SYVJ4oVDyEeRTz68L7ugMcS1RLIfKmwUOUgrzFe9W7f7d2CJy?=
 =?us-ascii?Q?vK7XBeN1Qypukp/dOC2fJTWzKsDk4hTJCBbi7l7V99NJY2SWmYLmiCKSdcWZ?=
 =?us-ascii?Q?rCMjR0MfULpQfqXTSwaJWjJidh5RQqC/mKhfvi3KUQAhomauS3DhXA+OUVxI?=
 =?us-ascii?Q?bSGlFwG8Opt+pFMZCkP0xlGWvON65TXRRJjswQNooMDlZ53DZlc/5UpZDEtt?=
 =?us-ascii?Q?F/BCwbh3IPgvCYhzk8OJv9cQdnMakSUwdBOjjjH81LIwq2TDHwTM/LU9seh0?=
 =?us-ascii?Q?apvacUl5hzl97XVwRm88jpa1nNp1QcTIKvZe5XEfs/u/fl1/0OoNerLWXkis?=
 =?us-ascii?Q?pAHeZ5qTXaetc6L37krVxHb6SyVsrzi2ywzpmse9RUWodZm3Ku+QP3rD3zj5?=
 =?us-ascii?Q?NU45VWvnb8eX5JgIxD97eXtV7cUa1OfQKib67rBZ79JHJzZLItfTMO5O/vkk?=
 =?us-ascii?Q?3BuB5TBww8KHq6TTmRzY2Xq8OtXsuhBQ94hl0q1e5uTWdCnKd1x2iFV8ATcL?=
 =?us-ascii?Q?A3mk3/YPGyInzyGObIg3fJ1tzx9SS1MFIwkk+AFQXriaMR4JfGRqyDsAIQal?=
 =?us-ascii?Q?4y12mAK6rYJtBDpZk/1elHZs1eRnzW/lx/8aJtr/0oFyrH4krQQyO2+gfNmw?=
 =?us-ascii?Q?MW3yd1U/FoIxt65qRVwKquQosoaEW/+1jqV1vFaJZrDv+tiOSa1748+dsWf9?=
 =?us-ascii?Q?4Qeaz8FNcgrpTXtI3SYtlkeATeisYODtP6K6lXl8hpqH89mVnBUVs5qrrIW2?=
 =?us-ascii?Q?VnUXUaZi2KDEcqZl9XSqJsPPX2A50tYS7NphYOMl3DcXVS8wdDYq3NhWiK5v?=
 =?us-ascii?Q?hS8P7eqsV7WCQDm6UDTyu8OQdQkxcBUWUYrJYYWQ97U6ga4XBFaQAqJoi54a?=
 =?us-ascii?Q?qhAbsquibGHHKrlhPITi5WCr+lr+yWDDAuEdH1qWWzYWn/KFE7M7EPZ0+kC4?=
 =?us-ascii?Q?z7L+pN0BlwaVwbYUQ/0efI0Lmzqo5/orFv+NAQv2vhc0k8gnZfj53TqXDCXv?=
 =?us-ascii?Q?bSkiofuYHsKShZqxtwq/kvnq3JxHg5niX3pOv0Q8Fx2R9wiIC4pqjiE62TMK?=
 =?us-ascii?Q?O1JbvGDh8hgAhwFOFfGuZTYtv5Bia5wdlhg9y5F/itXEYTxInwpSqQk3VkZW?=
 =?us-ascii?Q?Pt5jomF63jHOW50zs/iuiILiABv9d/2jWKn6ThmU/C2CRhORfIgGKKWstSwk?=
 =?us-ascii?Q?LWjB4MtGdmlUUZQJEpmnhVy4OUAXTcH87gvzYGCyYZcS92eHS0Cmul7W2Esj?=
 =?us-ascii?Q?oQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	B+3Y2RQjao4pn4AUQv+Af0I/cUWibolzoW7bMji03vZ6tD5Q9Ezyyyl5d73opzDvjhFPT/O4NR2r6A1iz1LoPGVNJEvkrR5xJ5rfOBZVz1z+pNelapIrp5AjuGTOAPQpmiH8rwOabd70K+c2WjSOlnR1+OnuxNIZq2KKAYJfSocQhUL/anPc9DDh0abdZdTL4yKeS0UG91btUGBRoggLmZP06TgPytlj9aW1v4U9uRodCT46IaPXVwbnU0LjxaPEiGguvM/dqz0u1VnGkNWW5EUA6zCB5e14ED5qTSVTSOtxXYrObX7uxMg4BWtifTccxtnI0H4b91FiRuolWQLu6O3+BxMeWS3BfqQ6uOzjlRrPtTCGw9ZpFz1gRDHTNHX2EWmju7o3jt2VbXo1SrAytO0WIQopEdoFO8HQsRN2vjykF09VSHfwGljwAxaLS5AExbhab6DSh04kfLz8NmN+IvW/g1uQjaJSzjBvRVsmBVzKodxkM1J3qgTDQhXPe5YncG1dpp6qX1VeLo6sqVf2nfznrhl072XibKyeB49chAR4pCXp9N5nwqePgPPmp+OP++nLg4Pz2ThVuUWgoXgNhgRCMSiekwtKaCqNw3Jp+rY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f0a7232e-5aaa-4d84-e8ae-08dca182da89
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2024 08:24:16.4726
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: izSguVqBTghTfYcp2grHxckgvTJUQ4uroSad78FbVJk9OhnADgSz2dsd1+EAidg9Szgtx90VZsjapD94WDQGoA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR10MB6672
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-11_04,2024-07-10_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 phishscore=0 mlxscore=0
 mlxlogscore=999 bulkscore=0 spamscore=0 adultscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2406180000
 definitions=main-2407110058
X-Proofpoint-ORIG-GUID: RkUXA5lZ499EZDskdK4QPbvy_wwt3aeX
X-Proofpoint-GUID: RkUXA5lZ499EZDskdK4QPbvy_wwt3aeX

Add missing entry.

Signed-off-by: John Garry <john.g.garry@oracle.com>
---
 block/blk-mq-debugfs.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/block/blk-mq-debugfs.c b/block/blk-mq-debugfs.c
index 305c53459fb5..34ed099c3429 100644
--- a/block/blk-mq-debugfs.c
+++ b/block/blk-mq-debugfs.c
@@ -255,6 +255,7 @@ static const char *const rqf_name[] = {
 	RQF_NAME(HASHED),
 	RQF_NAME(STATS),
 	RQF_NAME(SPECIAL_PAYLOAD),
+	RQF_NAME(ZONE_WRITE_PLUGGING),
 	RQF_NAME(TIMED_OUT),
 	RQF_NAME(RESV),
 };
-- 
2.31.1

