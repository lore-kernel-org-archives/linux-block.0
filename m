Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9475D25757
	for <linux-block@vger.kernel.org>; Fri, 19 Jul 2024 11:30:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721388647; cv=fail; b=YYWelHvbJQsSqCSFq+xUAHfdvjhqfvj2pyBF5K/j2k543vT1yKaA682SWxklIiU4ijbocxA1rTLqmIkPqbkyP6o1JZXE3qIhRQye4Exasr0/fzdF/dq7CXE431dxQsJrCEo9VQzwsKQE6Zbjo6yZJU0e/gtzrdJv4oQvqoNw41w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721388647; c=relaxed/simple;
	bh=7ZlExACJeP3q5dn0OwCAKCGX4rDDvaLZUPsUsbWORfE=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=snVsq0FQ23AtQZDGmEq+cionxfLl7bt6Q/Ax/DnDJBSJpYINtozbuzA4U5huUHp72UU3joPX6Qt9uymQiXkUcVOyw4KrRDzs93GA7vryBEB0PMuu1bUaW8ykNHxy9HTjCC/t4SjumKwg4gzawPAck1kc6IrfQKaPOAADxLgk1Gg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Pm6GTUwS; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=V8kCPuZS; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Pm6GTUwS";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="V8kCPuZS"
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46JBK7sG027043;
	Fri, 19 Jul 2024 11:30:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:content-transfer-encoding
	:content-type:mime-version; s=corp-2023-11-20; bh=KvCDxNgzPZoyhy
	wF2R5pKyc0hHaCjWq4okbBrgFGDkQ=; b=Pm6GTUwSKz0KxIdWnfZYx5avYBm8oM
	lLh4XfmIJCtr2LRZgbeG5LvXwBtHzo3QDetlWa7ZZhRPGdtYbwh9ptmZsqN63PJI
	lIrNc3LcWX88rS4jhDCxUfAgts6Niv7N6p+qPOKT+cz0OnpYC7TdFrf4LvkSsRoD
	o8BUWzpDRpblOCcPi5cPia0DkH4R8DxHoTQdOKtxv33ERAVtrekwKUrtnSWRXJsh
	9aT8isHoBOxZzwlPtjt7i3aIzu43B2lRbtE4Fyfm7h8nZyS3Vv8tcAw1iTg063q8
	Uwd+RAVaOeHlDeuLnkmkwK+oBEjNVBmhi/H/cHzTuuH7A6s8HIFa9Qdw==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 40fq67g0nv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 19 Jul 2024 11:30:38 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 46JAro9K006829;
	Fri, 19 Jul 2024 11:29:37 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2101.outbound.protection.outlook.com [104.47.58.101])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 40dwf14cbg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 19 Jul 2024 11:29:37 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pmHZIutZC0upfRy8vaS/n/RwC6Nyiqv6AvG/eBEzfdrVogJZOC49sx1+eJ0Nor0ePTL497K6rMxDKELvoFd6oCSuS+c0RDALjYr0zLC7s4ysWjDYTUlXLVNgRT9qPRD6l9eSwdZjXdGMZz8pSHjO2YDzukQwbJrZINjeT/aF8E2EOlOJiur9Q6JsN6K7z1hRUU8XyrGZ3UIPeQmlhTXiUBtpwKMzTo8+A92HhDW44sNtAsri1soJBEUCFLH/T9NuSpfjtQUU3coQwxjVvw/dFbnriA5GiGGfvS9SwLUE5O5Ud3lILRfhkJn8UYjx7zFGLfaqmapZaX/WPzuNgumY/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KvCDxNgzPZoyhywF2R5pKyc0hHaCjWq4okbBrgFGDkQ=;
 b=hWh85V4IvocmWbP3hn0AR99mdiwup1jgSq+/T7zBjIwJNbQ07wNkFAg4RQZrkqEl+LlKwonLZDfplxJ0HBZyY9/N0sSqZjcLBdpEqGM1j9amF+ANqDqNIsFMwJrMls3WCL8kNEQJ6D75X/mvEtpgq0+AG0RjvvBOmv/9cXVAKYuG56KBNg+f9JSFoKAjZi9DmoPfE62+BqYOoS7y2VqUAsvtKusd5egkcNgIfTh8d4iTo2pzCXCCLxpnodh/pDzGol7RVCQ+/qcss4ChF7dAFHFztW62ZcWl4UyCEEsdcnvKZynqOgQAaaaKmZgIJ4uiF0zPkwRpUmqZGLcI2QW5tA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KvCDxNgzPZoyhywF2R5pKyc0hHaCjWq4okbBrgFGDkQ=;
 b=V8kCPuZSMD2iOcFvkU/W8GaPUxVgf9e3MzofBc+2QIcSIDR+FoexfYMRECfFc9ipRxiqaBUjv8gj1hAibda70U8lNrxQLNtg5S0NCda2y2tnsoVD2QdjniFhygg6nVLDqCxNDTD2kChCOPOTwa8vUID3T3TCSvEWAOeeG4beBm4=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by CY8PR10MB6537.namprd10.prod.outlook.com (2603:10b6:930:5b::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.30; Fri, 19 Jul
 2024 11:29:35 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%6]) with mapi id 15.20.7762.027; Fri, 19 Jul 2024
 11:29:35 +0000
From: John Garry <john.g.garry@oracle.com>
To: axboe@kernel.dk, hch@lst.de
Cc: linux-block@vger.kernel.org, bvanassche@acm.org,
        John Garry <john.g.garry@oracle.com>
Subject: [PATCH v3 00/15] block: Catch missing blk-mq debugfs flag array members
Date: Fri, 19 Jul 2024 11:28:57 +0000
Message-Id: <20240719112912.3830443-1-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR06CA0039.namprd06.prod.outlook.com
 (2603:10b6:a03:14b::16) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|CY8PR10MB6537:EE_
X-MS-Office365-Filtering-Correlation-Id: bd3d96c6-a67b-4792-71a2-08dca7e610f4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?EvGqmE/WSxK0Ckuy4Sw68YH2TCK9lRFUshaEbMp1qgUaXUcsFSPdw/0Cr6HP?=
 =?us-ascii?Q?Du4kd0U2iJS+b74hpVdc1arPJVrLghX0b3w6mFJOSO9kW5O/wXwTSBxcHCjE?=
 =?us-ascii?Q?BJdB71P7CwRq01I1dCDesdBiCF6PolY2N1x/D7p3pZdf3sAESC/q/78EyTKN?=
 =?us-ascii?Q?cSnCfflE91BdPj7PvuSmmXUS1IUY1wj5gZ7uC4lfC0VuYRC+Xdql+3x3ZXF2?=
 =?us-ascii?Q?yVX8xEXtyrcZX1DezBKwWGTXxj2pjr7AwkxinFesY/2OPCY1JGwzjRxlA09l?=
 =?us-ascii?Q?SnCRo7/ov+HN5RUg6UgFageax93S0edLnQJsJ1vRpdUPTWQRAjKCsmeVhkkY?=
 =?us-ascii?Q?+uyVisk/zXHNxwPnQPfO3+bXIVV05nZ/ujEu4H3IXmY6ujAli4dIc2Lmvupb?=
 =?us-ascii?Q?aRTkGEEjp4esmtvNDfv2Xi1a6fZV8tmXQsjqduObhdzc1Bg2vLEgkGyzQcvh?=
 =?us-ascii?Q?Jj6ER2CuXi0pY46GlphHY5M6UGF82ceml24OuzhtUJSosn+o3FanVkL5GLcz?=
 =?us-ascii?Q?i7JMDThBlopxggYevL6IYqDE23H21QnRbnIY90H4XSGE7sOewxGcLeDl/zER?=
 =?us-ascii?Q?xXETuvBVLYsMhtRwXdF12330cciSfE5CfNzuyuDDFRNyerefLPYcfHCiOGD2?=
 =?us-ascii?Q?6EVroJyse76XielKLhb6dNEfZQjXctRhDmnEsFN+63BFe6dE/4vaF7RHc12Y?=
 =?us-ascii?Q?O/BOqQqz4vHfzG3Gnvne2CtkViMGX3AHY/WbuWLBcKIphhBELPcqo2DUXk2K?=
 =?us-ascii?Q?YFeaV/sJ8hhHeR0woW7xA6REIghGI++KNLkCE12BMMiWKBFo0OHC30yz5ZtT?=
 =?us-ascii?Q?vb9E4OAw0mjS6eMOcYWiW+CGLBJHUUCJIpMVm8DSrsi3frZoJelN4wtZ+fwM?=
 =?us-ascii?Q?ogGiqbi2iG30BdAj7AEda4EP8Mehc/J93MnC3ntmsQyZRZFbXQA1DlrZ9p4g?=
 =?us-ascii?Q?TkooYFN57BovzUjviqyz6gQf8175oQ0afjdimwOdjfuXoey1QirxwJWxixtw?=
 =?us-ascii?Q?GGZ3mWJanBu127aUW6bo8X96IqtPC5F1TCBTxK9xkd2ZwFoU/vtYWHAJRZvV?=
 =?us-ascii?Q?iomRkdlQgY2EIfxK8hQ4NqohLn16edGkbj3gKRUP6rnEB5kR06FUGYlugEYh?=
 =?us-ascii?Q?oYf2/xUCQbUVJT46uhju+6hIpcmYQg5uxxV1HkkLI0sUO99C1exRDcrFQPOq?=
 =?us-ascii?Q?FuqZKcS8KhtmgoxqSyTeqvvgvuUarR8KEOPIrXcmIr9OinkLyatyfiLNzta3?=
 =?us-ascii?Q?DJqQPcSJLrD30ac7ct3XY17FyUrmLQX3fz3X+h9xlPeq7rb9s50a8fT/lONB?=
 =?us-ascii?Q?ITmSyfpHbIWrUPMGWiQgSmVHFfaZUgB54Atn4Z8b/W+XRg=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?1zgJbfahwSngYIaYR61uNHo4wu0WzSu1cI9smJLQ7Sy+Vv/dWFkLSFWBEIgY?=
 =?us-ascii?Q?DtRYyK5TktgVYy8Lqeflu3qA8eFo2NvQqCGzxOALLFRMmZEor+9JhpdeqJEV?=
 =?us-ascii?Q?9LtgNJDFgXM9GSpjnTAqbgcT+iLlQFKIVUBp1lpfLDJLGWXESyxYmQdaxPWE?=
 =?us-ascii?Q?ca5GXV2U2hNLBdmvN5zyrK0n7WkYVfZfsPG5ZiHecpMN3hwI2hkr/mTEDgaL?=
 =?us-ascii?Q?jx7I7lk6d/FtHFmEJxr/Cky5QCUYMsyuxjDc2arLFuNEUfI74PEWoFHwHR/Z?=
 =?us-ascii?Q?/UjPvhKQRQYu3GTBMD0ofs/5CoTBLNFoFnC0nRvZmKcCUu7CNaTvs79dUBiY?=
 =?us-ascii?Q?g+60tQFytKUFa6MmKi68dBB7uoKisWzwtUE5bzDS2V6Aw68+xL1JuN4RIMFB?=
 =?us-ascii?Q?FGWmGVDzwFNCX4xP2i57NUE4ZmbX8guqRMnRJHFFaaUwXd0SzWkATYGxKG2f?=
 =?us-ascii?Q?O5z0x2ba0E43o4IbdhAjDAOm96rXodxTBrEnSPkCsN9ywCvbM9Rrk09f7PXN?=
 =?us-ascii?Q?QxFtNr+OqbuKQpv4q5erP5GpnVy/Cdl/i2YOn4nMyDA293WsjhWpUPoelMNF?=
 =?us-ascii?Q?YfDY+1ENKfpgar4Z4GMwrwd9H0/jx5xoK/MWqzYjyI2ZQLKgEXrEeoLp+wpz?=
 =?us-ascii?Q?sntDdSM6EAT+cENOk3i5kkqUf9SgMpW33GHtr5LmKh+I0gQP9QertXY1/7NL?=
 =?us-ascii?Q?A0ByEL5+oPsMrNETIWD+HailPQ9P8L6DzV/rrhNYWq1PEYlDLRIHUq+Aaja/?=
 =?us-ascii?Q?lSzlZCjJYRz6UXoBzq1TD5p86kEy/t+hWsJi9J9znl5drFE2XUXkJa22ViVv?=
 =?us-ascii?Q?O4QpNEgEvw8iGa9bSIlRLCuKd14sy+q98GiopX+fH7gaAvQ9PjyO1vyhkmC4?=
 =?us-ascii?Q?YeXgOz3xHIlYOsFXk7HBhZ4LSDOYfXjg1kbJ9oiKrF9GznBXP/5nqOGJOJyT?=
 =?us-ascii?Q?+txksN3h5r3Oh8V6j8udwGamBBMIqGW7+RyjGVAGQdmjWvsdewWe9o52K8O/?=
 =?us-ascii?Q?SMJ7mDJgfEXMRmb7tU2P+En5CzahS7GI879j5Maub9whRZ4MGxI9rvCe2z2O?=
 =?us-ascii?Q?uYJcOlwtxOqR+6J4xk3CBPiIzeSOkuTKnIEIOglMWAgYrc+R89nSFjcZ4Itm?=
 =?us-ascii?Q?F+j94B3CiI/ZyOGx4OTe4pNEaHlch1v7s/KpYG+FzhB7VCkDH6gCPiChMTDo?=
 =?us-ascii?Q?yPffKL+YcJKP65s8iMj0Sta+mZ0VU4JpZUX2Rfar7VNd93AjYsS+65aU2XQA?=
 =?us-ascii?Q?3OwF0nJb41kdyPvWNSZrLyu5Pq7M1/IqiNBmVMTwZh5pv5xgbdf0yf9OwoW+?=
 =?us-ascii?Q?ovbEePMj1cZSKwbvSSx/mCKCMyppKpOwsd5+/c84DSBfvFtms+tfhJttqhZt?=
 =?us-ascii?Q?TIvMdOi/udlnxzy3DjQetdDsPFjOSrdagWAqo0MOjFTJcccAMiBL1saOE0ok?=
 =?us-ascii?Q?tmKuz/YXFrANB6YqqjzEX0+LEYdYPIJsL0Lj4xcqjQPGvEnvXAbcTUA4kkoQ?=
 =?us-ascii?Q?RZGwkjcS/TuaJVkpzE6BOY5ckehnmfbsxcnN0mE/sooyoyazYHVQ6bTL9hJT?=
 =?us-ascii?Q?GvlcuC/HHYRwEQA8H28KF00Z4KTM9hPF8rGIyIIBvuHiTobWdLUfYy6kEvld?=
 =?us-ascii?Q?IQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	GROFvsb1aHs063Y2j7wl6A98mWeeOgVk7ofh2wHHKJR3eENeOn5txDUpV3jwhtLMALBzcy2cPMYzmQrX77038iFNgeFOK0saUQqjp322d2Fh7tYwLeiQf0wzrAZv60PbsFVLyzrWfIj5CnV+ft1YDexiZXy92jEMGLaoxTk78ckUFC6+BPqDyL4y4G0a6DsodwftJchqWRBBG/j0HOp2OmSykmSyo18EAkdDSSLPwCNRKkJZB7IHqnUBIfSVc1FnheLepECsY5ONJSN9FpwmqbfZs76u7beXnutDOKmcILvvqQSBjzpVarPLh5a15kDNfCehLSaMZ8qPuMEBMxbJ1wExFsidkPY9WGb2M+/mjC00hKNkmDEppYD1ieyO5BzYO5Z06xaGCEKGkB0jhp5pV65TMe+y+VHXMHTvFY61sT2FnGRraWXCCpvc2fPLI7/L0qa5UJgycu2cibI91NtzKB7ZfC1EQzYphYl76q9+pWSj0BG6XbYThDOkwLcAu9aFIqKyG2q2qCjC/pIUyto8uwFZ9XQB9SAO/YSpVBC7Q+uxNOpQ7WMJPPHzpwS2c77jfUgzx+/stPdLDRkgxH7BWDtSKTT3WeyDpTF1o2hpEqY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bd3d96c6-a67b-4792-71a2-08dca7e610f4
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jul 2024 11:29:35.0284
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QeS18UWWc7SXlO3L8iR0/HR9gW1YN1I1bhBpTd4kvOYP6XXsm6iKX3NVwjXZxiOJbgfEN5bH3YLr9JVOALlB2w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB6537
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-19_06,2024-07-18_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=895 spamscore=0 mlxscore=0
 malwarescore=0 adultscore=0 phishscore=0 bulkscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2407110000
 definitions=main-2407190088
X-Proofpoint-GUID: rBliU1q2fHgJWeJgXeKzHcpH-HgrMCyh
X-Proofpoint-ORIG-GUID: rBliU1q2fHgJWeJgXeKzHcpH-HgrMCyh

Currently we rely on the developer to remember to add the appropriate
entry to a blk-mq debugfs flag array when we add a new member.

This has shown to be error prone.

Add compile-time assertions that we are not missing flag array entries.

A limitation of this approach is that if a non-end-of-array entry was now
later removed from a flag name array, we could not detect that at build
time. But this is unlikely to occur. To actually detect that, we could
make the flag name array entries a flag and name tuple. That would just
add extra complexity and slow the code, which I am not sure if is really
required.

Differences to v2:
- Add Bart's RB tags (thanks)
- Drop redundant enum initializer (Bart)
- Re-order patches to put latent fixes at the front
- Relocate BLK_MQ_CPU_WORK_BATCH and BLK_MQ_MAX_DEPTH
- Put BLK_MQ_S_x in separate enum (Bart)
- Commit message tweaks (Bart)

Christoph Hellwig (1):
  block: remove QUEUE_FLAG_STOPPED

John Garry (14):
  block: Add missing entries from cmd_flag_name[]
  block: Add zone write plugging entry to rqf_name[]
  block: Add missing entry to hctx_flag_name[]
  block: Relocate BLK_MQ_CPU_WORK_BATCH
  block: Relocate BLK_MQ_MAX_DEPTH
  block: Make QUEUE_FLAG_x as an enum
  block: Catch possible entries missing from blk_queue_flag_name[]
  block: Catch possible entries missing from hctx_state_name[]
  block: Catch possible entries missing from hctx_flag_name[]
  block: Catch possible entries missing from alloc_policy_name[]
  block: Catch possible entries missing from cmd_flag_name[]
  block: Use enum to define RQF_x bit indexes
  block: Simplify definition of RQF_NAME()
  block: Catch possible entries missing from rqf_name[]

 block/blk-mq-debugfs.c    |  26 ++++++--
 block/blk-mq.h            |   2 +
 include/linux/blk-mq.h    | 127 +++++++++++++++++++++++---------------
 include/linux/blk_types.h |   1 +
 include/linux/blkdev.h    |  31 +++++-----
 5 files changed, 118 insertions(+), 69 deletions(-)

-- 
2.31.1

