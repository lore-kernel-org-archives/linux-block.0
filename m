Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 110C284FDF
	for <linux-block@vger.kernel.org>; Fri, 19 Jul 2024 11:30:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721388608; cv=fail; b=MQ7sxLayQmWAuj9p0K2mBj/MVTFqk5jiTJ15Q4xcZgql4jirKW0YuCNr+enQAig+b8dq4aQXxMAmVLOfDEq0KIZ/VGRY9Z7k79hy6lXHWRkxlu+On0BimgxZMv0/2xde1u4Q3o0QApsBc6L7g1K1kuJ8DINVCpacynLex70k7DU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721388608; c=relaxed/simple;
	bh=Dx19eEBdFehdBrtL90E1B5+IP0uPEC5lK7eydNbWaA0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=rXltdeH6P3qyQF7K+syJFup8BK8xe6xoM+B7iW+04TLLdDh9AwdgTQ4z1RBUGJRaEDe0GeRg5jfUaPTxK//8Qw3qqgWPe880OGCBdhtAyBwRC+VcoSC4yHIwLycsIA7VYGUjQTIorYIawyNlxvcHMrMbU1R4srSnzYfDcdp4k6k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=FFRNFD+N; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=TNX9avtT; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="FFRNFD+N";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="TNX9avtT"
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46JBK6T6011789;
	Fri, 19 Jul 2024 11:29:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:content-transfer-encoding:content-type:mime-version; s=
	corp-2023-11-20; bh=LInwdmS3TD7gvGQmDOnwOIcY8IXbQwwmCQNy9DsmSqA=; b=
	FFRNFD+Npt9Zmet662n6wmqzLkoLztgNB5JL365oSTe/pF7B+tCQbRxw9j/rUtEA
	WlwpE6oqpnv7i0RjpkeSiVRptQALXWqRObD+ImNaTCAetAWc1KF6fHiQ22DTLJt7
	11745plI/4MbU3VgDUelwJbqJKIf56L0oDD5650boBgqN4pSE03AZ9Hok0L2mVy9
	OPI1HIEI+nDJoUWpIoMe3sP25L02XvAampFODqdxpSWkWIw+0+sTFLCACcnWzBYm
	chukF/X3kV+a3OjNd3JcdazYcUrVQ9gxVT8U0eUAo921qC/x6nNQDgvzdG7IF9p0
	Wy09O6WNnf9EWlY11qRVnw==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 40fq67g0qb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 19 Jul 2024 11:29:58 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 46JB20PD031701;
	Fri, 19 Jul 2024 11:29:57 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2045.outbound.protection.outlook.com [104.47.70.45])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 40dwf11j1g-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 19 Jul 2024 11:29:57 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oAAiWHMqIAv/PScJCI5SRRJj5KxvLNLoXtyKyFTnIHDKaJVz+OsJEUcFg0SIGyCQlRPASr5CLNleqBM51ot0kSIzHCEfHHMO2IHmyINByMMg+2/CHSpifpKTaPz1HaNjhLyjicx7DxFyS7k+pgRUWk9AvsJG5GtUdF8VMljt/cxS1NCl5ICH5iQxhMOWcxKD5ssVyMCy1DHziBq336pYaRUkaD9ZtKdXXA26wXJlcEcKEiNraemFQV/qPh/DLwXelUhKYcqWoCAU1p2DkXujEwOEolzDVqRJKOzDAGUj/gWbc4jf3Ws7lJ/+n5U2ZECbqFMyhLYWJLvw/gGqYwDhQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LInwdmS3TD7gvGQmDOnwOIcY8IXbQwwmCQNy9DsmSqA=;
 b=gPfIQQf3xb0zKHKaKhQm/Kl1RYBTilZhZGIH3kohHBnlttf1CDl+BV27JAZ1ZH1K+OYv0AzySUWr8sxAq0LEidTIQ1EzCXyWDk8EmuxA1v2ZtwR06qMumJqVJngLyuz79aLTRirp5PxvUDWFYoAMY/nRS+SGNBSxGORRyw3V6Sjrgh31nD2iFqIKoZuZyUGp79cyt+wPAvYxr94vJrtS5FACrMyktoHJosPBOqBpJLsaPO8CsrlqFjD60WLr5V9cUsB5Pv1/W5cWhvXQJOS7MQSslonAcTRqej9jCLgas7LUK6aRP2DM4VGueMph9fLfGvjW2awdlRCZxYNknsPM/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LInwdmS3TD7gvGQmDOnwOIcY8IXbQwwmCQNy9DsmSqA=;
 b=TNX9avtTNjUSY1nTxANtw2tdEfdVnxws/VgRW/8q5EgqHIIAxAAk0EghALLJ1JMkYhbbiM68YjKf9/HevaRf1Z57Py4rTK4pt3y4MaaAeABS1msKwD9vLscF0A3q6IawKyMDp79aFi6A2J6IRnyPWcNNQtUSC/ASJPF85CWULxc=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by CY8PR10MB6537.namprd10.prod.outlook.com (2603:10b6:930:5b::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.30; Fri, 19 Jul
 2024 11:29:56 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%6]) with mapi id 15.20.7762.027; Fri, 19 Jul 2024
 11:29:56 +0000
From: John Garry <john.g.garry@oracle.com>
To: axboe@kernel.dk, hch@lst.de
Cc: linux-block@vger.kernel.org, bvanassche@acm.org,
        John Garry <john.g.garry@oracle.com>
Subject: [PATCH v3 09/15] block: Catch possible entries missing from hctx_state_name[]
Date: Fri, 19 Jul 2024 11:29:06 +0000
Message-Id: <20240719112912.3830443-10-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20240719112912.3830443-1-john.g.garry@oracle.com>
References: <20240719112912.3830443-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR13CA0015.namprd13.prod.outlook.com
 (2603:10b6:208:160::28) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|CY8PR10MB6537:EE_
X-MS-Office365-Filtering-Correlation-Id: c9a36e91-61cc-4158-bccf-08dca7e61d85
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?GvU2d8+yXoVxE1GGCCul3ih3YGcElJiaHWindcvLzYFJ8mxrLfpnJUfojE5I?=
 =?us-ascii?Q?tQEDGj14OHN7u5cqYAEdPEvGxuDZDvKSYBAwuGblkgjOnCMMiaf1d4c7PNF7?=
 =?us-ascii?Q?+zklt4+EdVJGteUCf7b0wIkoH8NJJCyp1sMI/6g+4ysBBwRH18rzEqKIhh/w?=
 =?us-ascii?Q?sPnQCdEUeN775nLQTTA9vHi5gFEo4V8KkW8EN4oai7gTcCPa82pWSkRepwC8?=
 =?us-ascii?Q?DWxym3F7XRXoSuLZupvrPeHOnqRISmurX0SK5M653y3XTpqg3xU+lUZoDPrE?=
 =?us-ascii?Q?Bbmnzb3Z2g9fC/U91WkB8xwjrxSQWXQ1t0JAovlDsl0/6jlSHe4vUWigBCFg?=
 =?us-ascii?Q?maX6frmSyI/uyM1E1DgzOwe4hB9ORSb63ESxy7WCU3rZsNeNMatBYIYWWaPi?=
 =?us-ascii?Q?0OkVRXkbU5ZKBH+x7VpkrNP0lA7c1A+LSxTAUPIwSsARX/BMLJTnZRERsCR9?=
 =?us-ascii?Q?75e6aiPcdhRyOh1uDoaX4WlX6k2HsJT4C8QQcCTL/y3lf6m5xWtk2dwUB8aR?=
 =?us-ascii?Q?9mniwefayEU1coev/zZHXVJy1pW2euUWXhUcWBN5BfzpMHsGb6cqWc0VTtwR?=
 =?us-ascii?Q?0Ll9hnF/YwN7rpuqY+Jg7KemUpBxjh0Z4bqhI7yHtE+f0eoQUJEAuJU2gTms?=
 =?us-ascii?Q?ddLvThSfatTHgKYgjkgGIIeZ7ZP2lWDVNf3AqL+k0Uus1GbwJ1NQ2AvkmGEK?=
 =?us-ascii?Q?ipvL5BluOlyHxhZMYJjplEO+0qKveW7v5+fBr1vhTN4iGaV9HohS8R2toAE1?=
 =?us-ascii?Q?/v7y5VjyHY4loEqCzXiSKXMREIqD24NJcstD9VMGOfkoZepYHl8tUhdBkIsG?=
 =?us-ascii?Q?PiAqju0vAWXN7K9vjXPDF0VVQ3wiFUpOInZ3jVlRVTm/d5KU/J/sTHp63LlC?=
 =?us-ascii?Q?KdA3EgCYv39vg8EF/MW0A+dNxOZxKPaIrttafoOrY+SNCXJkAqMNoKtlDbRZ?=
 =?us-ascii?Q?R9AJMT0Z/XfhedMo2W8M/Wmxyqepv1NJedO/eG8FUu7IC8Il5DbGCIYzAC3s?=
 =?us-ascii?Q?Dqs/TR4QL14nixUMa0LDRldGY19Rt6nrS0fv5Wqa0kKZ2tFmwwTJBybFcZaS?=
 =?us-ascii?Q?zRZVLp7YG7QMi/BYNVX+i1GZ66+QyLXrgBwLheXqwFcOEUf327jdpFzw6Z5y?=
 =?us-ascii?Q?pgmFN7FNMYayeAeQSal/pJ0IIP/kBzIadQ34loY2/SP6XOT2KuyIcew93NKt?=
 =?us-ascii?Q?x1wkLfDm9Jp1FUIfxWprvknXMqf/8WTCQG4WlgnyZbEj4bg7PkGCWAV6HS79?=
 =?us-ascii?Q?NhNUac7/wPUe4PhPdLoM1gKajBauhybKin1Ri7Yl7bqOLlpEjSQGXuTox60e?=
 =?us-ascii?Q?w/AxROzrcaFs8WuZr6tHmWTGVro76+NQm3yKc4nqdOZapw=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?7j4MnBynLqfa7Ovo4ITJzxMeN8x34cSLiuNPc4JInnw6m03ubfZLn1fBKtOx?=
 =?us-ascii?Q?a15G1QZlx+cfislZOCt1v/dm7lB6iqn3pJQB+9d8HvXbhK+hh6cCTNzjNP7r?=
 =?us-ascii?Q?X8NLbPnjS/o7a8AnEqK1ZFfzmZzwmYl3fhB1tpn4UIWrtklgSh0sPfAjo0kC?=
 =?us-ascii?Q?fLuImvdnQcGitRdM2pHiNYPiAXUlI+mhYJKKAp3+uZUgx9xdOYmEE0rKJwiZ?=
 =?us-ascii?Q?xyfMc3172YE+F18X8h0ck2GnOXieLa81sJay0R2KiAOHgeXFeN3UjFZy8IQT?=
 =?us-ascii?Q?BjaMNyAma0SlSdfIY902QC/l5HOp4gMyEeoZO35HNr3EuglzolzHsZCqmKDZ?=
 =?us-ascii?Q?o6VrnL4z3DQKUlNROjcT1oYkojNr1o8zq+vv9VZekb3sO42CbgZoQ8BU1N8y?=
 =?us-ascii?Q?NcdkHD5X6NBNBI7c8C9D3mdXJoYXsMy2BGoxT4wINdr6y29UM67fIFBjC7zp?=
 =?us-ascii?Q?W/nwHSRMWnPNBnogEKmYL8tlR/avFs4goMhxIk1C2ePHzuxXXaNl4kn0P2ej?=
 =?us-ascii?Q?wtu0dJkvDh7t+ajzYm0gjt2EbL2ksDmDqIfGmEUbzqsInsIF3t2tiPjXMq3x?=
 =?us-ascii?Q?F8ipK3g53d9MwEiKMxF7HxVDkWQWWj2Stl84Bvj1SaJ2RqxSXhBhavvniX/N?=
 =?us-ascii?Q?3+Bu80hvchzviac7wG9E0NcaK+/Lbjv3yIo1JA+0sAgnTSBhLSOQhbZgCIaG?=
 =?us-ascii?Q?xj+dsBVM2S61hQf+3Uu4QLy2JdQ9d3Sg6h2J/aZKPODtShv9V6/a2Y/KAmub?=
 =?us-ascii?Q?97u7DD62JOZZDCDCc1flRHyhcGsCeTh90B9PDhPKmrB5UFGNnc61OSDwoc8q?=
 =?us-ascii?Q?6ja0SnGGbDG+gR9jUaWnzZ9aH0OO4kdHHIavdRvL6xX36SviYzeefj1YoCwJ?=
 =?us-ascii?Q?WX0IoYUS4NkbAZQ71UnPCdUh8tGQqCJmyaU8JPQFJJwZDN8ZPtftapRXIM3y?=
 =?us-ascii?Q?F8FKx69gqOiNYgrJR7QE+T8/yPKoC07eyS2/yPP+trVr6c1rudqmG9gmAsUN?=
 =?us-ascii?Q?Ht22JXt4KRnwCh5Vm7kjyJFg2ei5BwxokPAVW68CKbkMlzhBrrhHurBPJhh0?=
 =?us-ascii?Q?2Mu15T3x9XU0x85NjAeYW4SAvq4WJRzk9jHciKZkNRVhS3ctxhfK9+JsbBgl?=
 =?us-ascii?Q?Ip2mAWoDNguQtQiGkIuCSjk5TnkCdmnXZhr7HEQip910ERohhc5Cbi6TtQV3?=
 =?us-ascii?Q?ascRt+j/cLUQYZn3I+SWLeC37TpWofP80uYIuDXUe9sY2ukwFrVKA6XbRh5d?=
 =?us-ascii?Q?Oofmq0cN/gROhWWfQcZDThG9OMwUb6cL1VR+APOGGYTius+LMgDmN9pC5GK4?=
 =?us-ascii?Q?uYq2L4QLdaa0u0JRXuHlFarLfMY9NElUbKtpfmdTScepb8GeRGuoa99dyxfC?=
 =?us-ascii?Q?w9vxuZDEvQx0BlNKdKSvWE7lVfHVusLyWzPNViE6FKdZmQi7FXP0Wlq8kSKy?=
 =?us-ascii?Q?J1bOLP1Wjp47jPeyPs2fO+vnVB4r2JQ/hJuaH3ynw3+qBbdJ0tRhYCoX0w6O?=
 =?us-ascii?Q?BYvMo83V/RZZZjHytM0K3owqJ7G7P42AFIKHvbwFvb729NmJA/vBlm5xGt57?=
 =?us-ascii?Q?NLF6Jjr5VSSuXnGFxetFfk+hKp+piyWd/8wueShefaYvUFFglE5F41VQcV4K?=
 =?us-ascii?Q?uw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	5IMhwFZUnQXquKvl6uCCP9gLaOUFjTYB6lB6Cgu9H0XuygCAmZFwhxPwxklbfHqdCqyUtFLxeUoKSfVUjmFT8F/JI5OKaokpxzdb1xh5qZUfUt93iELjcGwskQJ+LD2JEOauzHZCiuT9WAQwNUqlvsnfbmSalIEHmUXjK55u3EWqO3U5GIDhm18KESUVjKBZUFMGK1p4PTEE6PCMS4fixOc7bQp9+QrAi72RR+QE2yYpVartTbdQVWjp7r5wHxpFZPzUd6Ekp+vfmMtIfDweAnCrscIxF3ISHPeAO/ADqTb9Lyhl454rDUL68q6TBXtGgHkZq5fTMwVLIqxtOWj2FfConXWpD/FzJxG+pKiCE9ocX82P1ZNn979TPu7W/V9/5f+ij6uisp0SBBUjflxD/HT3cGZOkSV9H+rGsxAhMOf+y/8Bz2PLy5HcPlW1DWvkIhDdzC6J0TsQE52JqhP/pkqzXLUNlKZTnON5vaarQ0mIthg2QkbK9vZSu1J8GjIHG2XMg3GSKcD8yAkmQIaIHVnHO/pSgBWOwGlGpsfFQPdrv2jYRquAwdjh40qp9pgb+EcVbIU54zxrkIjTdUtF17+WSkxU0pST6Xz4axu53bo=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c9a36e91-61cc-4158-bccf-08dca7e61d85
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jul 2024 11:29:56.0972
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sjnNJTUWZwm3vhYlacsy8jCRwaq9rOYjWBZX8CuiqrHhcwfyM7ZiHeF5UzCF3LtVB+4BnXFq8xymAte/ZUpiDg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB6537
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-19_06,2024-07-18_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=999
 suspectscore=0 mlxscore=0 spamscore=0 adultscore=0 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2407110000 definitions=main-2407190088
X-Proofpoint-ORIG-GUID: RjwiV3cYgMZ-cFmnEXD2iRpYelVdcpR4
X-Proofpoint-GUID: RjwiV3cYgMZ-cFmnEXD2iRpYelVdcpR4

Add a build-time assert that we are not missing entries from
hctx_state_name[]. For this, create a separate enum for state flags and add
a "max" entry for BLK_MQ_S_x flags.

The numbering for those enum values is as default, so don't explicitly
number.

Signed-off-by: John Garry <john.g.garry@oracle.com>
---
 block/blk-mq-debugfs.c |  1 +
 include/linux/blk-mq.h | 17 ++++++++++-------
 2 files changed, 11 insertions(+), 7 deletions(-)

diff --git a/block/blk-mq-debugfs.c b/block/blk-mq-debugfs.c
index d28784c1957f..85be8aa39b90 100644
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
index 8a84f49468d5..4905a1d67551 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -663,13 +663,6 @@ enum {
 	BLK_MQ_F_NO_SCHED_BY_DEFAULT	= 1 << 7,
 	BLK_MQ_F_ALLOC_POLICY_START_BIT = 8,
 	BLK_MQ_F_ALLOC_POLICY_BITS = 1,
-
-	BLK_MQ_S_STOPPED	= 0,
-	BLK_MQ_S_TAG_ACTIVE	= 1,
-	BLK_MQ_S_SCHED_RESTART	= 2,
-
-	/* hw queue is inactive after all its CPUs become offline */
-	BLK_MQ_S_INACTIVE	= 3,
 };
 #define BLK_MQ_FLAG_TO_ALLOC_POLICY(flags) \
 	((flags >> BLK_MQ_F_ALLOC_POLICY_START_BIT) & \
@@ -681,6 +674,16 @@ enum {
 #define BLK_MQ_MAX_DEPTH	(10240)
 #define BLK_MQ_NO_HCTX_IDX	(-1U)
 
+enum {
+	/* Keep hctx_state_name[] in sync with the definitions below */
+	BLK_MQ_S_STOPPED,
+	BLK_MQ_S_TAG_ACTIVE,
+	BLK_MQ_S_SCHED_RESTART,
+	/* hw queue is inactive after all its CPUs become offline */
+	BLK_MQ_S_INACTIVE,
+	BLK_MQ_S_MAX
+};
+
 struct gendisk *__blk_mq_alloc_disk(struct blk_mq_tag_set *set,
 		struct queue_limits *lim, void *queuedata,
 		struct lock_class_key *lkclass);
-- 
2.31.1

