Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F42C383AC
	for <linux-block@vger.kernel.org>; Fri, 19 Jul 2024 11:34:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721388889; cv=fail; b=OtJcrIUDAJpO+9P81ducgQHVtzt4Zxs48eBsbjD2IgGifibOe5vWW+Zaj8CM289fdV+YRYu5r3E3HSpkKrnJdbjB8/CQhb2znftkrsaA4nRk2QqMIA+Yae/64siGmYj4t9DhCvZ8elo/vWd1/krXIZNltB/Wbl/FOsmDS77Rq6c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721388889; c=relaxed/simple;
	bh=8AkFNenfaM2emMydzH/HLzf20IOXd+eiuDhjIxt0ozM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=kXxVrXfYrS/M+rWicOep5q3z5TcQ3NFy6d23LkyiM70c5aL00lrCVDYHWew2joq1Dm7TXwoRqvdoEItx9tQZW0m61e6XKYJrDTataGj4JsrI3de8SWetMIbiaOlBqm5VwrAsot7yGQd6nRSo/k7s2BqaoV3L9Lydf03Ypdaa0nc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=mqgKxf7k; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=riZRJ+P0; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="mqgKxf7k";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="riZRJ+P0"
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46JBKKOG027862;
	Fri, 19 Jul 2024 11:34:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:content-transfer-encoding:content-type:mime-version; s=
	corp-2023-11-20; bh=+jKZ54eYUTnM9N8xnXfHHgPZmovH9b5heID2wUBX28w=; b=
	mqgKxf7kH6ZoZDLHk3VpWgAW8d8RHRC6S9s/DC039lhzbrkcreb7Kk00yVO9JChg
	iSa9LOi4URtWHp7ydh4pSLsvqA7Ehx2dIIkS2Mt9sPGNYOkfI32W1eixjcMvJ0hO
	7V4+OtImhTBEEyWTu0O2mN+ryHjGwJU+LgX+ruYJluKcuV9JM9uQWjUouwvn73Kg
	jI4USTgRNwDE+epB6i4AVqlHdwcWQQN2CgyWIHdfK03b6SY6kdRGEKU1823+tFb5
	fhSuH9aP2AWZZRvx5WCLX6Yy47eV45z7izgbpGBsItED1Fre+Z3Dhp3ltDqh5bAe
	jd+5752+FpBRJ2afszSrOw==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 40fq67g0xq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 19 Jul 2024 11:34:41 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 46J9dRlb021734;
	Fri, 19 Jul 2024 11:29:40 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02lp2040.outbound.protection.outlook.com [104.47.57.40])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 40dwevt7pb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 19 Jul 2024 11:29:40 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qzYBhny8GY8dPZ/FfYmvnhphcABASJTtXI9EBs0CLFaFtIXq1kj7EIKUEK6f8AubboGPDsyla2h2oUl2hYNG1/maGqLrjC6C0fH21mwNhAGiPOtLz1B9M1GYaSXXuw4E89d5yGCiDJetPT3CPGTrAX7CAEIBclRVZj01iLE6LQvCtfhgPFwFE7+nM/z8ozTiIHQS91Ie/us67WulQGXBJrsv+m15xF6Zk8NbD36YMf+OkID5bbvzraOlBPZlXidqUZc/JWqv2VJo8YSAg7TdPJEMIZGqDhf3znwGIlYklIjv0te2YS65GgFNrksbhgSadfGpi6EEmNYYztzi1PoP9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+jKZ54eYUTnM9N8xnXfHHgPZmovH9b5heID2wUBX28w=;
 b=eypopUXrBJQ+oFX35m7q1MtCf9mDdxx3GtCV3wr6Mgxxnrzcd+6eTVMwm+IVceRtOxvSxY4PpveZnH5elHS73L0b4kw3MnPl2KdTLp6GfCIKSJAtvNFBIndCtmca5ndVvNrOPTeTDZRsIWaBe5Km/32E2KCeKo0Y0P2Pfapb6RF6EVXyIdW1glU2/fT9modsC3qLJMzupsJKFpVuOfTH6B+Xgk63g/n+QW0vDWfXQ/mwO1h7FlFvG6QjpZX848Jj/3D27CMb6lFqFFjYr2hg7wh+jQWdpVL/sBgCdK1+Eohlu81yOt/3OHPUMsYT65KSnZFuQy5Srubrw8wbh11lDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+jKZ54eYUTnM9N8xnXfHHgPZmovH9b5heID2wUBX28w=;
 b=riZRJ+P0lXObrbVpFLWFe8NqlzTy3EA/IwZU0LiAjDXt6YlZDnIlRtYUB3ZEPDZsLju04g+T/bfa+6oF0st2jZhj0D+AvAnZeKqDKTcWI+gi9eiiZ9fPrH9QNRlfhT2vtAWUoJ0wGbvuGtF79ubrT6++tWX6rlOqGsmYauvvEmw=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by CY8PR10MB6537.namprd10.prod.outlook.com (2603:10b6:930:5b::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.30; Fri, 19 Jul
 2024 11:29:38 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%6]) with mapi id 15.20.7762.027; Fri, 19 Jul 2024
 11:29:38 +0000
From: John Garry <john.g.garry@oracle.com>
To: axboe@kernel.dk, hch@lst.de
Cc: linux-block@vger.kernel.org, bvanassche@acm.org,
        John Garry <john.g.garry@oracle.com>
Subject: [PATCH v3 01/15] block: Add missing entries from cmd_flag_name[]
Date: Fri, 19 Jul 2024 11:28:58 +0000
Message-Id: <20240719112912.3830443-2-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20240719112912.3830443-1-john.g.garry@oracle.com>
References: <20240719112912.3830443-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR06CA0054.namprd06.prod.outlook.com
 (2603:10b6:a03:14b::31) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|CY8PR10MB6537:EE_
X-MS-Office365-Filtering-Correlation-Id: b68a815b-6977-496c-7969-08dca7e612e7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?zMaEepfQ5wySrhjc43YgrkDMFonSfpWQJmaqpD/253v5Oo7kL3SR8YnEfopu?=
 =?us-ascii?Q?lqvG8k4v82D/kWj9OCgDokjLG9sSrF/Hf8CrhyPoAx8hGLyVGw8m3NQwY4qp?=
 =?us-ascii?Q?BXaPYWTSFBmxSWX+2vcQkJSPm76FQbR3Z2gehwnJHVPpDmGc3QZlUQP94OJw?=
 =?us-ascii?Q?u1ZZCepzKsutQwpiw9Y2FI909w93MuRGUuaGH+m76bahIAg3Hj/OeoS+inqB?=
 =?us-ascii?Q?L3TDFXpuH9zS4ZY66hJakFe5I/lzb0SFH+A+UiLOMdnPDDlZHZUOLHUrBqxb?=
 =?us-ascii?Q?FWL693g1emPB8sQf8CP4ifp2fShDcamqkwIVU92E5sGEZdiXk9p8OIE0shw8?=
 =?us-ascii?Q?bAKgSycjd6XcMICNrnw0xmw1CPgS9RY8H3P9iLlEdmpherQ4ipsOsbG1LWFd?=
 =?us-ascii?Q?+emvXPnqz6mL0IBrgBsGGCJ8WJFR9Ec1jhX9N5v1oipcsbNtvdvLsLJpqpuv?=
 =?us-ascii?Q?pEYkPKyU1C2s3Ve2Ujpfy/e2vK14liDrR2x9cM7kix0gt/CIW/GL+/9bjdQH?=
 =?us-ascii?Q?q6PuCBVeXrSQtoVUJWIf/rK7JCHRRG/jth9w/96sry7GoMd8FVcetNG07y1X?=
 =?us-ascii?Q?KLnKyOtsKYYeyUakOh3Gggx8Byd6ytpeJUKifDqFfdBkEoHFiWG+d8WpvcRs?=
 =?us-ascii?Q?M4NX5/xVp0neqhpp4+J+5E0+ZZG9IWKYnqa55fjrJ7CaYZG7syf7rmFe7bQZ?=
 =?us-ascii?Q?iBaWd2ARyMGXg3IPub7ZsvIv9JsaviPVPLCqHTaRMHTmCwRNnvqzIpEf5LKo?=
 =?us-ascii?Q?Q8HXvIAYPGwKJSZskShYtuHMg41OWvgVH/yiE86PanD9x7Sk0K0nzloi59/1?=
 =?us-ascii?Q?5eSsgnDTR4p8QiiF+YJLb8w6fHl4rAp0Q0z5Q01puEN3vM3cN+3hOT1mwqfo?=
 =?us-ascii?Q?4oZ0uWNmHU2mK4TbTB8njLw0gayIBslv5OjYkOg9C3ENCiNTUZ3GVvVQmd2Z?=
 =?us-ascii?Q?Ur5p+9VKTPxIgM+UMA4Caym5ZMDo0biYQsVEC2Ze3WQ8A26HkOXGKaEaVOdF?=
 =?us-ascii?Q?FEdRPB0atsMnmkCfUfknUXwXZ0Tp0wQmEIiI2McY2BFyMDNfaYzgS/CO97Lt?=
 =?us-ascii?Q?ooB6QADlcqJjkJ1sCK5khYwM0ULnTpsEm6Vmw/YLXtm/BH5cj6nqYTHJZWXB?=
 =?us-ascii?Q?Ixutgi321A79yJU6o91MRuQfxd/nOWJ3Fuk7UInA5PVz2JgOOPxkO6jgKG1+?=
 =?us-ascii?Q?AHyXhA2nw/EOSMsEk21gbohv0iEn1ehOAsiy+XUul7VP2qIPQ72OFmXffxu+?=
 =?us-ascii?Q?EHwY59d3GDmo7TlKWOowcpi6zjddwWheb6mUvN0q+vW4tQZXeKP/xQ3Q4dBN?=
 =?us-ascii?Q?ue/7zk46NBuSvbcd5rUbPdkpfMRALh0MJ4U8tJDIj4WrGA=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?n8YY3wrJlZJmJLSo62fW1AzwRCU9t3zXeAD+gsqgBf+9I+vdxVoOQDYViBmc?=
 =?us-ascii?Q?S8jVULMUvPQV6QF3VGUy/Q2nYRrolXEHnGMJ1AVUZUKOuo0lCBJ01FNYjQlU?=
 =?us-ascii?Q?ACoapWwhJONAGPtj0jrgP6I4jKG8ueUArfySskGmvJky7jWBUaU56wwJqatw?=
 =?us-ascii?Q?NB685ru0WVvkGLUegPC+pZZBrbulwjrrKxQLX9KCkxAHTgjT7XKQR/RCK+p1?=
 =?us-ascii?Q?sgJUa0d1m3CDQ+N0oEthJZqNYw+kqxNsw9JdtGN24X478TVdixmYR3IT737s?=
 =?us-ascii?Q?QyyhQQHr0q4knQgTCGA1aO7kPZD4wRIZsHl2YEEdPrwfX/bOMUG8sDK/LGwQ?=
 =?us-ascii?Q?Z+MWHO9vXn0erV3AaYkjNtyYa5M3mWf02BLnNbaXkc/UmEYoQfNaTmlSJdWf?=
 =?us-ascii?Q?aK5A9muE8izhNlaa43nQoyvGb/q5sWmIQQ1W/Jm+EJWW7VYodiezNUF++Pke?=
 =?us-ascii?Q?WCaenclzd9pFBm+HE8fn9pKHhjOv8/OAu4Tb8vkxbUcfrQJaNcfAYwENb3A5?=
 =?us-ascii?Q?ik5LCK5Eyxj85pN4QGi23ytZgF2DasyCzfqPiPHpQin7ut6mrLddk4HTvvJD?=
 =?us-ascii?Q?sEVkh2eKPxJv8KstqbvYej2gre/VC+0UY5E5Pv5kCBC8HiK4AOWcwMyQpjhO?=
 =?us-ascii?Q?Xr8SLn5HtSXQooX4MCL4zEDNqKtXzhw6UG4pJNZduO/4C/6DzdJkye+bE/fd?=
 =?us-ascii?Q?JXXyC8N8oY2E7Z3ZoAXjuzGMproaQItM69GhuEqO9LZ4tUbbUQzF2DNluYns?=
 =?us-ascii?Q?q8D7g+PoJX7Dc7WR3buhPqtWCYDfbpD7t+KWz/08una9JXRuT/8PtldHAaNT?=
 =?us-ascii?Q?e/K5/GUpcTdXDra735YEh9QrwLH2S6443EjJPOnBQSn3A9hTWaIuIkWhpNwt?=
 =?us-ascii?Q?30+pwDd41Ob5m4s/xbMI+EIBaicsKMFqTD77/1hWQKCUeJDDV8SrL3jq0DDf?=
 =?us-ascii?Q?FbgcrFcVZ07/gDwMxdKcCt8BpnV4tTqeeif3d80dPDxvyS3TQHFb9PPRkaO3?=
 =?us-ascii?Q?QEUUyG8U2/61GSFfPIQ/jFxMGLyv2/azpy6PxLfdUlIFoboTy3ob8XJAWbV7?=
 =?us-ascii?Q?jDdXcDQ7MGpswgAVvM8YCd6OEPwUjFDI2qON/yQOEl9e4TZ72XLuOFNedZYJ?=
 =?us-ascii?Q?O28BD2JXFrfy01HdnnrBxzyjDIoLgv4qTuMFGP6A3f8fyRKPb4lJycfadWq+?=
 =?us-ascii?Q?TWfYUbqKXZYhuy6Tm6jYibAxOcT20VmGYUxr6qICBLLs3CGa3C8fsQmV8Rwn?=
 =?us-ascii?Q?lpfe5NNOEYsr6uSSraLE72HZ9Rr9NmUQMlU7mrSROKYcZkzA4kxFabEqq5/I?=
 =?us-ascii?Q?St+8bOi/ilSgNmQ2/Z40Y472XILHK3lJqWo36JCyO2lg5+C191MqVwL79ddH?=
 =?us-ascii?Q?A5vNHYEv9kQneRKrVSxi7pql1JMS3FWANKKkfyRMlOoHa792bR93KbnL48gC?=
 =?us-ascii?Q?+fMKzsHG0xjdAP4xJE7AmBWhNezierIboGYxv84sZQ5YyskGWF90e5/Ys1M2?=
 =?us-ascii?Q?e/LE81ZXq9Q78+0Dpn8K0fFE3IOJ8H0hllGRAdwTvaBVhjk5nb2HtETnbWva?=
 =?us-ascii?Q?swdXUZXgROWJaERILxwgaM9loDSIr1xiktmkMW07cim1q4sTBddsBoyo0SWN?=
 =?us-ascii?Q?qQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	Ip4mhIGxAgQkRNyEXzGHf6x7GMS16190gpx/ocuuZlgR6V8M8guAJTUPq3IiNxK2bNXcfMxoF4/jCS2kFjnQHnDeMyl41uXTiexwoC6ws/LP3hQd9qgT3YyiJbX3Ng0JphMciNLo8PoKqism0vSBHKLSZdi9goHN+R4kR24xuezor1DSr7UreEnTo92POmlKPMWwvyMn4gb4/Pt/ohKGdKdwzZyz4+eRDb80aREnTvR91CiuweE15TMWS/LNEUhY8aDo1Pb+PfRc/pVRgCl6+60bTsOKakyOdxL6eR6DT7HMwGnB+I7Tmlv5YU7CyXpObVouBHhgXrLoeWifMMUb9asydq7BGB+PGg2mhu88UuKVXx5kO5G4QRibUnMJYwGbA9Bsyix0fmQ6B6vCc2KDGaAim7AOdmdw+r2pVAq5Sen18qFaS4xvbEpo8AQ6gHEoLJPEt9ScxRldTvhZtRiuqxxf9VpMRPCYJ5rHytEvn7Qnwl+tL62aJrwEvO5RGZ31ujsODYwL2LU0tN30NxHa/1zq1TPvQdC3HMrJUk6OTv4tHQJAuNEQSVEPJMXqUefkg151GNGiSVybwG9B12mNW0D/9utmW0z5BH2mVtnP47Y=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b68a815b-6977-496c-7969-08dca7e612e7
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jul 2024 11:29:38.2302
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: L9Lg8lEmd30mSvU0SmNvrGdIeUzmvq1MkLHne+joaPxcHy8xyF3+OEBx4EcQiftJL/3tD2PFmoetMA7v0AoIKw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB6537
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-19_06,2024-07-18_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 adultscore=0 bulkscore=0
 mlxscore=0 spamscore=0 mlxlogscore=999 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2407110000
 definitions=main-2407190088
X-Proofpoint-GUID: zO5l--6hXA_JFj_2N6XylUV0tdknmuy4
X-Proofpoint-ORIG-GUID: zO5l--6hXA_JFj_2N6XylUV0tdknmuy4

Add missing entries for req_flag_bits.

Reviewed-by: Bart Van Assche <bvanassche@acm.org>
Signed-off-by: John Garry <john.g.garry@oracle.com>
---
 block/blk-mq-debugfs.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/block/blk-mq-debugfs.c b/block/blk-mq-debugfs.c
index 344f9e503bdb..786fa4d6e019 100644
--- a/block/blk-mq-debugfs.c
+++ b/block/blk-mq-debugfs.c
@@ -223,8 +223,13 @@ static const char *const cmd_flag_name[] = {
 	CMD_FLAG_NAME(RAHEAD),
 	CMD_FLAG_NAME(BACKGROUND),
 	CMD_FLAG_NAME(NOWAIT),
-	CMD_FLAG_NAME(NOUNMAP),
 	CMD_FLAG_NAME(POLLED),
+	CMD_FLAG_NAME(ALLOC_CACHE),
+	CMD_FLAG_NAME(SWAP),
+	CMD_FLAG_NAME(DRV),
+	CMD_FLAG_NAME(FS_PRIVATE),
+	CMD_FLAG_NAME(ATOMIC),
+	CMD_FLAG_NAME(NOUNMAP),
 };
 #undef CMD_FLAG_NAME
 
-- 
2.31.1

