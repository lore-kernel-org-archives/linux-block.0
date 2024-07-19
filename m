Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 460B525757
	for <linux-block@vger.kernel.org>; Fri, 19 Jul 2024 11:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721388653; cv=fail; b=jiTqQGL/TfTBno+c67hP85UbpJC3gzXPiscRYL4tPwm+xN0ApSjefFZWqDPK0F9HZPTJMZUj4gedQbr8WfHYG5F6I+bgSJyMNzKL+eNPriN3LGKv2r4jhnKQ0NDnfVeHcBAUlefLwv++IelY69mMpBZkzW9v45FKrBx6kcLpLOI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721388653; c=relaxed/simple;
	bh=v32qEGghBAKUkd/j3WeUVPtBTAnSAkITclLXDHXOu90=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=J+St+UXSRcnljahC5+gksfZ/9VhkHVwQMrtgi+H8kWgZfZyoslikGF+Cyh9/WyLLARue0wP5e4dxeA1MyEb3dTED+LyXZT1c/JWfbLBSWw1zTcO+qt0liftPi8rv/jR2JeS4NB/bTKHaCwi1S327qoSx08eFZUxOGqFSRham+GA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Uq6NCnHA; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=HkU9Ydim; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Uq6NCnHA";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="HkU9Ydim"
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46JBKLFF027867;
	Fri, 19 Jul 2024 11:30:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:content-transfer-encoding:content-type:mime-version; s=
	corp-2023-11-20; bh=sVrSbEJSYFjoyxgJJvLXzHFFV1LJuRHZtXFs8kGMwSM=; b=
	Uq6NCnHAwkq01xj6Ffce/nSIgWLNOjSl3T0Pgmc6Ix3+aEhOSK+0+HSY+9nN9MS+
	qea7LWK8jzrOioabC2gdf/hKSgMZjbAgfPPxap1IkgJTZivjTqGaajSEOWNpx/QS
	y/PCRnjKZtuJ3K58TxoyKmY72y/nUPHXp1DRjuzFkIUF8/3w1eG30+9I+FvNo8CS
	/u2aIkgW+9bceKfbTEtJpIwRagzFUywIbWjZYQy3p+2IaZrOZ8eqZCqCjybiDRXu
	dKeoO+h7njZ8aioTP/Zyhwe7psd/8hkNpNIxrtic8VZZ69WTLCHOu8+vfT4duncN
	XhXHtLgnI69uRVUA6g0p1w==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 40fq67g0pq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 19 Jul 2024 11:30:44 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 46JB20PC031701;
	Fri, 19 Jul 2024 11:29:56 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2045.outbound.protection.outlook.com [104.47.70.45])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 40dwf11j1g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 19 Jul 2024 11:29:56 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=o9X83GdrQkyAJaTnymon2VTVyZgoGOzS8TBD92tcjX3LaWelQST/+mF8+xoZ5/ElZF/l+PmhEU3qLshl5oZSiHzWQt0gMCMrc4Gpn20I3oGE1isUkbQgHMLrMhMsRMR7bHqmydtqwYFajK2fQzG4RA0c2r+P+Hkmi7FYjyVL10TsmYz3bdlmpGWIwTZ7s1efkiSRqeMy+cxmKNNgt68qmwS4Qu5jJfUOVdq3YhZ7iGGajHKCYyPh77IZGjl8ss0pPjy1bWKhv/YxXoa6vJtDaLSAY+EBw69E0iyT5x49Vb1/KrOqtTzLGaotdNL/ULQP1NpDBiRyspuUPknCzsNX9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sVrSbEJSYFjoyxgJJvLXzHFFV1LJuRHZtXFs8kGMwSM=;
 b=h/geEaOjXaUIyKOhBc2mVo3+T3HjtQEjIWBzHuHkUHlLrAqtCSvub8vP0qUvy5kt5emTORqwKW22TZb9VJvWXM9rY9E1U8zZSpGeQKg2C4VxU40+6etrvmr+p2OlzBv7Lrdy4hWqotqyKF8aoiumXhBjAmBbDVMuMPLZPf35HnTFTOxMPL5f2PbWeNHmhjVtucQ7iXrbSU7Ia0Dzth3DiJaVo5wKQV+n4kJNiI19b9bOCBaTBviBaXTQg5r5h6ZvARJFyHCzezNrkcHwCHLQQN7y8c2HKW0cP0I0xWqhCzyrqixZE8gZZ8Jcl/OhN3xk3OHyyTZ4wL379jB4eYdldg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sVrSbEJSYFjoyxgJJvLXzHFFV1LJuRHZtXFs8kGMwSM=;
 b=HkU9Ydim4E3oulSB/0migXpQl/AlUPYFmbm41+ea71Ud+Bt+aDs+dd5KyaCARWZYROmjMPYmaVcJHkC7eZhdC7e7ebdywK8fF1HaUSH+SUM43p/ccSPTLXqIoyowUr+ujwLcI0EtLBNDpCR7WUZn0hqwUUwTHxnkDX7W0U0zExg=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by CY8PR10MB6537.namprd10.prod.outlook.com (2603:10b6:930:5b::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.30; Fri, 19 Jul
 2024 11:29:54 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%6]) with mapi id 15.20.7762.027; Fri, 19 Jul 2024
 11:29:54 +0000
From: John Garry <john.g.garry@oracle.com>
To: axboe@kernel.dk, hch@lst.de
Cc: linux-block@vger.kernel.org, bvanassche@acm.org,
        John Garry <john.g.garry@oracle.com>
Subject: [PATCH v3 08/15] block: Catch possible entries missing from blk_queue_flag_name[]
Date: Fri, 19 Jul 2024 11:29:05 +0000
Message-Id: <20240719112912.3830443-9-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20240719112912.3830443-1-john.g.garry@oracle.com>
References: <20240719112912.3830443-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BLAPR03CA0146.namprd03.prod.outlook.com
 (2603:10b6:208:32e::31) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|CY8PR10MB6537:EE_
X-MS-Office365-Filtering-Correlation-Id: ee51b443-43e4-4b90-3735-08dca7e61c92
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?dr7s4BBvHnCw80UskFT9E1iXFYyh5s/CjjisSFDlm4RKPY/wJofsoDkB9Ck/?=
 =?us-ascii?Q?ErP94nBIxkFVZpa9q91rs8GjfAVl8LMmaxfawb2fnJ7hli8NoH8m8U9d5Xvv?=
 =?us-ascii?Q?8OaNGV5g+Qr+zVyx3Rt6e3IRfoBZkAaiC8cEKzpYGqIBAC3OxUPWmFtUPAl3?=
 =?us-ascii?Q?tzHPjNAN41Z+lKeDchCV3nVKiMoombiSkqSvkM16zR5oDBZf3cJBVvruv/vv?=
 =?us-ascii?Q?l0CoFCf0wg2o1yE59+6Ot13/n13i3anyH+Us+q38wieKQufFavjyIRYWCMVB?=
 =?us-ascii?Q?pv/MVPzmC3GkVq2Qebhl6MUbXvVxEeYJCXynVviabnaWNa5IGN3qJsN/yhOs?=
 =?us-ascii?Q?02LWvz+YiHdEmbN+z761Dxm2sPhB/GRz1V0rnTjvD/5x7xB5KjMsj15S9OlB?=
 =?us-ascii?Q?Dci7R1Szg8AHggQFbK6VysAMGivKw2s4lRNoMcpOPs4ym+dU1PxfWW6peyNn?=
 =?us-ascii?Q?tdlWOvUTpaVg5pnG3Yai/zR5+bf97qXiEH+15ccl/N0mmUCSvca+CAlssc0z?=
 =?us-ascii?Q?d6gcNCHKvrn8hKo6JucM3O5PYQp4sb5cqXbYu+vP8dEMXpy3GYEt3CURhOtb?=
 =?us-ascii?Q?f0p7w0f4BaMzGs6KuOPq9nBFbI+QW37/j+yutgF1vobiq+hMRSb1v41zdxFN?=
 =?us-ascii?Q?eacMblnZWQOII2Hgq9fosS1pXKGZGHo6ySKCVs40GYGfOesD8ba9P3oPz/le?=
 =?us-ascii?Q?eUPdo9mO0v3PhNPFSH/5C2t8SD4fS6QFhEBOxH8UbbIf6nWSgx1VEf3zRkSr?=
 =?us-ascii?Q?ljKqDbtTX9tf0veztlKxk0zDUaUqWtwn3wxVkaEoS4qskpY0/cxQCAzpbel0?=
 =?us-ascii?Q?b5ENRy2GeDv6VhZuDCUsBnEeCRqSZ+6Dan4UI+ULEf+hN7Zq1NB+Xhj+Hlkk?=
 =?us-ascii?Q?SULJlOpq+p/JlburX2d4FbZzrZ8X4KEihpm/Vbmohb7byMwTwlEqZNQIcy7p?=
 =?us-ascii?Q?I7B+R8Ja0zlwV2LO172EuTgTa3wWM5pCxrMT88TJumLK/M8zPQbQNwxD368E?=
 =?us-ascii?Q?AhXQEAeIgxQ4PixRkQfUDkrCTosetAqX3tZGvH02fCi/jV5MeiuVNFNFIQY4?=
 =?us-ascii?Q?QAxebGcTiPTPtp09OUywwsa854gB5WXwQob/SiECk/V2r6HnLXLCt2LdJE3X?=
 =?us-ascii?Q?G9EkcRnQotLy84M1Sm+HRGtTu64cnDuKFm23iBbp+qBKlJWo9xoDVODH4K0q?=
 =?us-ascii?Q?sT5zq3DlUSy5W22SJpEq5bO9hCmqPdamPXW4oAiTq2yLcCRaoz184442Ee+V?=
 =?us-ascii?Q?q1v+wTfM4w1f5ACSNqJ/2imXbPVA+wFGzwQpL+j5h+JIg0habe+GzcNu/uvM?=
 =?us-ascii?Q?j8xlVfaTpWN3R2cL1YlSRDQijxzT+lUhTV2vSTmVHafZqQ=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?R1tNI9OZrB+7hDyaCMpCYcu8dYbJntvV4vPOqZZOms2scRGMGMjIkzx4qoNj?=
 =?us-ascii?Q?RDJ9rRsOVOsv/KRwXX9BmU0d8uh4q0P1kFrX5UBJ6NQQAo0G0MbJZvkRRKbO?=
 =?us-ascii?Q?24hUOVwTyzuMftGRlKAzUjBnJzB4GKaHZAIU8hmxWFEGs86WxgtrepT/r6p2?=
 =?us-ascii?Q?BbdyZno+G2bloLj/ZfhV9HiB95Hh49j4Mw39/V5ytX2XVCZYPcLiIOIFYr58?=
 =?us-ascii?Q?MFXWai1s4uwi4F4WtUBKf5F9A1D3UoSmJS6RihY/O5yo+qgdbDGYKINR8z2j?=
 =?us-ascii?Q?ygr7mNGsY7zCz2jYE3ubhwHoSkGcSyptjAHc5Mq8NGoASTPPrOdNVEGx2ARP?=
 =?us-ascii?Q?WoFWAz095oOEhsfWmFhQZpZc7pqP8UCx/fftm5sZ5BaSJ942dZlWbr7iupWJ?=
 =?us-ascii?Q?KGSQolOxQ+nyWOnr9AJNnbGqAn5Mot7t9JfXwwFunF5Fp1HsuirIbn4qsnZK?=
 =?us-ascii?Q?zJ5ZVaXWmxyK1Zn9yCTYY2/yH+LOV/bbjLXfNF/NvWs1MktesCm/rhtWm90M?=
 =?us-ascii?Q?GknG2KfdSTYGJI8D7mxt6svFFe230FvwSZC1cu5DZIrphQdJpfIIclF2E2H1?=
 =?us-ascii?Q?vOVNughyyap8JBqCmSBVrZ0xAiat+qfRPGj3vSyu61hb4ov5WcWVhpRcmNU4?=
 =?us-ascii?Q?3JZkXXqO45Wdvw6rIfoFadk3sbFfBTxnV5NdQqVHECxVSj61YZwpwhmgdul7?=
 =?us-ascii?Q?+PYWpwYOhB/Avo/wc+hLG4DhoL65qeIQSduEt1NuwNl0YVXxpK3OEQ9Oshsb?=
 =?us-ascii?Q?86ujUvTct7Bvk28pVEyvCjNoKjLoUe/7v0s+Mo9T+H9DYBgXx/VW7OEjI7s/?=
 =?us-ascii?Q?gquboj/+zWqAuO4uUPU5J2UcvqgM6U5q3PRapt8jb4ahBXiDfNkf6X+ypw3l?=
 =?us-ascii?Q?owQu07ve4hoxHkYFXLDa3LAoOKZoLm/3atFeiXKFZyVbawoA4PivL6DnisDg?=
 =?us-ascii?Q?j/kCAgKihQ1fBXbybR6OicxZblSfR9ruKLjJeODDU7GOJupQyyOcUB9v+gmd?=
 =?us-ascii?Q?v1ZGGsZbmW8TR6yIzYdZuLmeZM4mPG5lIWlxqo6rXPjXVr9mNt99Uud0YC1h?=
 =?us-ascii?Q?wlUGizQBVuoIH/BcR4+Rad0+NWeOIyP7FJ5uPzPhQWMjF5YQOdrKt9BWwcP7?=
 =?us-ascii?Q?4nzpvdy0+AUkqFLSKxKaG61MWTsEf79Go8OTbOXyXf1TJuflYgoQEwGFXlhU?=
 =?us-ascii?Q?JShz1eKWbACKBd+dkZkbiTIu739KNBeJpcOEEJVg+H26MJAykEfD+n/55hPo?=
 =?us-ascii?Q?/9nFN4tUmBXDekYxNS6OzENCjEyUqyGaQQApwoMzDMhcmqH7DnmeEMnDcL4v?=
 =?us-ascii?Q?BJmn8wgJvsJeK8ebJncWVzromBTyuIk8fQAIORZhua+ywy+xovZMWbP4bxX7?=
 =?us-ascii?Q?vD9v9nGuWqCF4R++hOepNIpAzhJuzQVKtLXERh5SwJtT+gbLIr7X4PjexRtz?=
 =?us-ascii?Q?n3elY7zP0dDsQ0SzpaYGozl9Z9QKDYKmXuKEqD3N8PhiKgWlaMv6vmEHE7+v?=
 =?us-ascii?Q?Uxv9GPYLnuPG6ItkScb2fHD83OE1X2eKlPWXL7ssGNGLDeBO4mKprbLJiLEQ?=
 =?us-ascii?Q?lWH8TcxDYVwvYr+aI2ou02EYo1EWU1/tLpmFRDNWzzxRswzpwMSMi2xK12r+?=
 =?us-ascii?Q?5A=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	cbnQGXH7nQkyym559PM/lSI7fJ8dcF/zATo35StTYn0vd+plf8MBJVO1XYPhSxDisy1Nmz0mmw4FMof1OkTJCzQWKaL5gIIQ4HPcaaF7JAmqi1m4mLFpNCDR/SFMu53IDiYyNrYBUtnbwAEYI90V5jd1Y+eZgCl12dp0KyqD9cC0YbjaayTKxebwd9hU2r96QdxVrJ5ZDNk3X08dipY0ZH0JoIYfP20KKoRT43g7NCBsCaYHiz3inO+dvsNJMtmJa7Ut5QZpvYSM9DbGOdv7MSJCnvgm9gOKARnpnaFVqgXCP1zZ47IC1mzpjlLmb6oTi1zC+wpSgG89BwTkik55u+A4xdswSvlTyqpgMwv+v804y1V9jWr/kGMwMEvnPgCPnQpGbufunbmj4DeH+ZnHHnSVbxNHbZbNvK0yL0Iv+5iC9lk5616a6rOnZRgEk9Je4fzxs3nx6sqsKqvOaIlImC15aGZ9NQ26Jfm7K9VxSR6sDgSQPflAypZ40WiTszV8Ho9sNF4SztHwSw7wmm9+85dCozNEt6GZKBW/nMOla0RLODwamIMgi70dr1TwLtC0C4ZEq0VpueF7MYbfahXm6dH+SohgFK1bKIx792pe9Kw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ee51b443-43e4-4b90-3735-08dca7e61c92
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jul 2024 11:29:54.5145
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6Dd+azdwSwmt+kdasulndLlH0w2TCfu2VH7VXHgppTCUMKLEFBKpMFM8GGSg5zkqIIHRZrQRMTSG8Tu638wi7Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB6537
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-19_06,2024-07-18_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=999
 suspectscore=0 mlxscore=0 spamscore=0 adultscore=0 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2407110000 definitions=main-2407190088
X-Proofpoint-GUID: 8k1y_T9Ia1_nsKzbfb5kte2DnT4muedW
X-Proofpoint-ORIG-GUID: 8k1y_T9Ia1_nsKzbfb5kte2DnT4muedW

Assert that we are not missing flag entries in blk_queue_flag_name[].

Signed-off-by: John Garry <john.g.garry@oracle.com>
---
 block/blk-mq-debugfs.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/block/blk-mq-debugfs.c b/block/blk-mq-debugfs.c
index 866e8c6bebd0..d28784c1957f 100644
--- a/block/blk-mq-debugfs.c
+++ b/block/blk-mq-debugfs.c
@@ -5,6 +5,7 @@
 
 #include <linux/kernel.h>
 #include <linux/blkdev.h>
+#include <linux/build_bug.h>
 #include <linux/debugfs.h>
 
 #include "blk.h"
@@ -99,6 +100,7 @@ static int queue_state_show(void *data, struct seq_file *m)
 {
 	struct request_queue *q = data;
 
+	BUILD_BUG_ON(ARRAY_SIZE(blk_queue_flag_name) != QUEUE_FLAG_MAX);
 	blk_flags_show(m, q->queue_flags, blk_queue_flag_name,
 		       ARRAY_SIZE(blk_queue_flag_name));
 	seq_puts(m, "\n");
-- 
2.31.1

