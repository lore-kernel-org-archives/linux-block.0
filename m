Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CE99155303
	for <linux-block@vger.kernel.org>; Tue,  9 Jul 2024 11:07:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720523227; cv=fail; b=B1GTL18O1vWTYWkinPsluMO6nM2eCTFfViGxhC/yhAFTqOXppfzSfyuwiyP5ntSK1+2m6ufj883ZKGRjMsTojNS9loU+0IZXQLbifWKdw2OVluh6TuN4pnX145Hkqg0eI7lSYSHhqn3xa1LYQIDgzCAb7BkF+QHdZ05Jucvxi3s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720523227; c=relaxed/simple;
	bh=+544KEqbgXBNsn/4+d6UPy0kC2U09KDUn1dnBBtKPj8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Qs5r3FaVVaT+VOnOlq10yTAQAUuvz2c+u32dmssDigaZFoySr8aRvk29rVitcPjvJWT7XPalwQjvp+szK7+KfA/XUcM193QqcH+0aJgIQ7zZLBN5rcpFBBjLF+5P+hq9LAfehTKHMMFxXAez9W62x82JDZ87bEsbZdH7G/kwM8s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=EMs9zO3F; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=emIVO0li; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="EMs9zO3F";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="emIVO0li"
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4697tjgT001495;
	Tue, 9 Jul 2024 11:06:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:content-transfer-encoding:content-type:mime-version; s=
	corp-2023-11-20; bh=/FQcLX9FA9sIGyi/b/Zf6UCwKNRcC3eq6Q0TzMHtkWU=; b=
	EMs9zO3FKz4eisCgzM6my/LW2TkHt5W/MYlTK2f1UBGp2lr4PVCNy31WT0gEXJt5
	1BCNSgJ+7+QUx5exyy2vl21I/c76lC09JSRozsze84ilR59Pt+fwWVMF9yjwfiZf
	5VS3mOlgJZB4awlLlb+Grmh93GJv1/YdnuAqAPMqEEDO/z32q6Ct95xCKSwquoxS
	+EScuffYKBxdsMCG8b0ZsNHZWNFnEeclQ5kONHsJBxCbmLKRqiQTb+o8rxLMkh4y
	vKgw75K6XDfrdJm3OvQLUiVwQMszPKD3AljV3iYHc7hXfsBRIB5HpquHVFKf7DSw
	lqn2cad65FSZGMI+CDL7vA==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 407emsv1nf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 09 Jul 2024 11:06:03 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 469AIZw3029928;
	Tue, 9 Jul 2024 11:06:02 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2044.outbound.protection.outlook.com [104.47.70.44])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 407tttg5jr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 09 Jul 2024 11:06:02 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CNwtmatmigwrMnBvhYGI87Ym9v3cDRoKeb3hsDMbauoGZu0QrGgtPW1S604lxiKymwqRsC0CVzUH4RcDB9Dz155sVlVWRSunSAjgtvSeDC19aywG+4VdVoI/lWawI6udbzCAY5WVMO8m/vX7aHDkOeuV/AZGt+JN/L6tMGhYmu/xRairK0qGQsJJhkM7zm3DPTiG2YKnpv5GUti9Zrahaau6taCAHw0DQ/WzscqXoO1sCOlFO7DRW3AoG+brUx3mV20NxSb5VNK/jysoFoEFtKA6623Zi9z5bKWsnZgcA3vQKoRMY3Q5ypaMgQs2xXOY6lGlZNFRBecvKP1zFCPqvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/FQcLX9FA9sIGyi/b/Zf6UCwKNRcC3eq6Q0TzMHtkWU=;
 b=ArquEPkEUGVvU3c+Bm4yEDHW9dFa103f9+GV32fKiTQrYzgFjUqGHuAw/a0KRiq00Hc7CTp3ncJk7YKBYDbT6ioUAGGgWGiEHNrrfDpBS/3wQV0WHn3ePVok/Uwz5g1WNir+0WuI78d8bgrslXTvse8RnegAmjg5DKBYtTjtLWv+vEfrurKQhCiDfgtyIzsegiot5al1gzryFytQLN7qwcndQbiVUvCuwfg4rzf64LnKtgILycwOXOZAS3AFgOz/DuU59DEWytndzMM6semZY26v0a1MfeSF+ehNfAGZuMqFQkZX8b06DGNxptHV4IZ/NLeXhP9kFKQvc58VfH/CAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/FQcLX9FA9sIGyi/b/Zf6UCwKNRcC3eq6Q0TzMHtkWU=;
 b=emIVO0lif3K3+0pxiOpi88HUCcT9AFzuVW5k9Cd8zPSgq77yjXAmGHA9SUAY23Jm8U8+wLHEEQI+ffpqu2k65P1BJZRApgrppOZWdI73BaqcjnvuXtK2leLnJme5FtcUilDsTWSjmaNjLFN9YvTdqt6NhcngN6RQbh3P4715Zik=
Received: from CH2PR10MB4312.namprd10.prod.outlook.com (2603:10b6:610:7b::9)
 by IA3PR10MB8068.namprd10.prod.outlook.com (2603:10b6:208:505::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.19; Tue, 9 Jul
 2024 11:06:00 +0000
Received: from CH2PR10MB4312.namprd10.prod.outlook.com
 ([fe80::fd5e:682a:f1ac:d0a2]) by CH2PR10MB4312.namprd10.prod.outlook.com
 ([fe80::fd5e:682a:f1ac:d0a2%4]) with mapi id 15.20.7741.033; Tue, 9 Jul 2024
 11:06:00 +0000
From: John Garry <john.g.garry@oracle.com>
To: axboe@kernel.dk, hch@lst.de
Cc: linux-block@vger.kernel.org, John Garry <john.g.garry@oracle.com>
Subject: [PATCH 07/11] block: Add missing entries from cmd_flag_name[]
Date: Tue,  9 Jul 2024 11:05:34 +0000
Message-Id: <20240709110538.532896-8-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20240709110538.532896-1-john.g.garry@oracle.com>
References: <20240709110538.532896-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR06CA0025.namprd06.prod.outlook.com
 (2603:10b6:208:23d::30) To CH2PR10MB4312.namprd10.prod.outlook.com
 (2603:10b6:610:7b::9)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR10MB4312:EE_|IA3PR10MB8068:EE_
X-MS-Office365-Filtering-Correlation-Id: 617cd091-ee11-4e1f-6cf6-08dca0071d60
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?8IOJBKzcYVslHjWnuEiNQm3Mn1ETRzJRhDhPRnVKiBeTwElfOI2i/Uf8/OM4?=
 =?us-ascii?Q?578A78TD3hZBq9ICbi4R4bTbNsV/xNfOR7r0nRhVeziytESGHbvbD9arHc0v?=
 =?us-ascii?Q?zHuWJuvBo9Mx9V8c6Wyed1GGTDyhtJSpkQA3yQsrrj3CCReOHyH+CCoMHdrI?=
 =?us-ascii?Q?NaNfhRdNLLHZ1CcxVeBR/xsTGm/jO6Q64cPSRb02hYH+dpShWHMPwFfyilPw?=
 =?us-ascii?Q?Rc2jv+TlQbVejud1qMaEGqwLE6wkvzrgF3R9I4EC7Fw9RYyarL0SLMGpaeW+?=
 =?us-ascii?Q?oJMphuXanPlsMOfiVUh8eZk+70DwzGDBfl/4q0PcQGZ2RvEnAaPOYhdVCL8L?=
 =?us-ascii?Q?G45Was0xEx6o0bhq4Y7j9wYWsapgBu0mabAb2k5o4kvffVw/e0YameKq9Q1y?=
 =?us-ascii?Q?MM4WSOROpfw0aDj1QHGpQ1i1ED/3foF8li4GwKSeecUyGsnarUuDLyJyY6By?=
 =?us-ascii?Q?b7kPh88e8cDgtxKPQ1hdXSp1a24sQMyVAqB7s/RFiy2xJLcaURc2MBhISm+w?=
 =?us-ascii?Q?N5h5qK3B6hWvqqR2Oxd6BuZASlgbxAUkBhQ/+2nUPakGN46U/zzX+L/i3kqM?=
 =?us-ascii?Q?4CQT2Em0mQsbl/Chizh72ZxtC7Xg/C9b2PiHbXuY7mp2WclSYPNbMK4OTHxo?=
 =?us-ascii?Q?H/8gNYYA/JVYDgOpiBxPIGniavACRQngKCp8is8pD7v0DV7d9dJ2okSFzEbC?=
 =?us-ascii?Q?NhDqRdYOC5YAjuaGvxJ2+NmfwLzCOjAf4UBUxthQIUxvmQDIbQRW3d+69kzE?=
 =?us-ascii?Q?YVeTdyyGwXCZlyYGbdWL6uNkE8ZjeyW9HtXIB3ddeW/w8tthUWjHA0qVCv7U?=
 =?us-ascii?Q?JiW/v9XeiwA7584cahcjJz3ACV7d86Xtqmxvw1RmIPdoQTC6ySoLa2kWuZgx?=
 =?us-ascii?Q?70estphEvIGoouaII1tqLNnt0YdCKFr3P/Yabsa7uy5yfgYQ9v5ohQdJp83w?=
 =?us-ascii?Q?f8oo22tghhehIpOPgbRHJBvr04CIoEVa1m5b/HmcycwZncsUeyU/QzkaWODD?=
 =?us-ascii?Q?8U8bpD874QUVU82WUbByTPCtjJh3egKAVSI2ANPdXcZ9Goav/pA+VIMKtZsk?=
 =?us-ascii?Q?D7AUiKHrcWUkyPaS7yDOvfnRk7jCbEikAV51GJR0TQVfDTcXkS4Bs6BdFvKw?=
 =?us-ascii?Q?ew0lF+6qM+tsCE/53YNac/fhKmlYd5YvhwLiBJ4zEtFkRZfoRPdX+8Mt/Ul2?=
 =?us-ascii?Q?A7pktNhSeWkuCho9+Tn/TlQQxZZBSXPJPjEsDzZ1MzURiMM5hcwMH9L6elzr?=
 =?us-ascii?Q?AeOa9drcrymM13txMLtF8y3mWag6Ib9Wmkvgf0rADtn31BMniJg1G6aOkkGp?=
 =?us-ascii?Q?beY1lXz2DqeX7SegJ7hIN7OKqXKRPDuzN2ZTMKHrIhRMNw=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR10MB4312.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?n8kVUdNtNOPg6tkbgHzl/qYr1ssmeWIBcS3tDbxAGiIbXr2TWfyk4vMRi9nC?=
 =?us-ascii?Q?nBifpSWD9dCsdKFa/YNNItU/b6DhrSm3WS9m9cqSahJY0j1ZQShh+S5vsH6b?=
 =?us-ascii?Q?jp2gnQnBACfj0h+NODj5M9S2jM1rgfqNm8j3tSkJCVUBvH8X7CPjLMFDZjnc?=
 =?us-ascii?Q?Mo37BCFgQ/ydiiCqAd2qVJ1A7KCSfwpsvWZqr8rK8ClTlxVBmr0bTY88QPpN?=
 =?us-ascii?Q?DBMD29kUJXT+aJZwYQC+0xWX+CYSLTJu9wga9462RC0k7O9SdaEoZg8RW6Dt?=
 =?us-ascii?Q?Tc5axtZfwijiDEYQXSnrxgThmKCvnhnLsnX25V+7diLmFyq4V2KfD/asnd3t?=
 =?us-ascii?Q?kyAAyR5FLyhRDP6rGuvTNDIkXqu2LH3M/9YVBERwdBrdKk1Lm0sbhVih0Ap3?=
 =?us-ascii?Q?buJPj1ymgsndqMkHYRUO6/owIAp1KXtPudaaesjphrkIGn51kNLQDjk9oBbB?=
 =?us-ascii?Q?tlH+scVa5gIVi2X3FIw2ZFEe9mvz16NutS7oGM24NL7PhASvp49rojio2mpc?=
 =?us-ascii?Q?ohuDMqoq6d5JJ47w5zPCA3rByoT/oHc9lkij36oVnDC1z7WTwKfJTTIBnsKZ?=
 =?us-ascii?Q?pMBY3AdSmXRQmQSPOtgRGrg5uD3AG+Zi967eaaCO0tFifikA4ftyKG1SdTP5?=
 =?us-ascii?Q?W8HMAV4KxEAlyUg+o7JLxs4yJcRmtPwZZj7yOhIG3S/qYhQzifGbUKf8kSSa?=
 =?us-ascii?Q?HDTLVR7DaumzdhGOIpoN/la9Qv5sD5Odl9qigKSkBYzeFuetz4elUwsnNTpO?=
 =?us-ascii?Q?rfCkheiUMP5vE2hpItZwEnqoL+Mbs8ZuDhVX6K34a9nk0Kvw/KJf5ejlDHnJ?=
 =?us-ascii?Q?9/Y6F/CuO80m8yz6KlUz/EkSIirIdx41sX5spoxDdaiLGzYyb4J+ElC7pEQH?=
 =?us-ascii?Q?OPmUggkNSESYdrckgdgVXQHoE2B7ydmu5ldsHCh4j2TyBv6k2yEfh/HWWrbh?=
 =?us-ascii?Q?MncguM2zlhNzezNw7Ob+UXJaikYtJZ7B2uLxnjTIMDf2HLziawCwFS/PbQcu?=
 =?us-ascii?Q?GYLELGB9MEEEbdo2AYLmqMy/gB4bhqnmbKaK66uPBVrsHkJk5byNLSt4shdB?=
 =?us-ascii?Q?PBMh6qCfbmoaizNyM0BTtwQf2A5mtUJ8H6dXxVX2/5Lyd9F5UNQbdLkbnXdE?=
 =?us-ascii?Q?elN5xbbKv0x/ZpXTboxHPMOvX3lxlbhqnM1i6w1iI1SKLApq/wJE3ouPDOP1?=
 =?us-ascii?Q?2ybu6HHRB4KTbcghT6FX12+za/1NV6w7hf/30xcjzonf3bBxCxE11eQXcd+U?=
 =?us-ascii?Q?BkRSbJmF75QGiEbBvnnCWObaEt/eIYPnfs/MBdUJWc6zing4dNuO31EZM250?=
 =?us-ascii?Q?R4WwJlUlsQAZ0ZboBAj/KQi4n6kXiPloYjMk9hekwgkk1Uo+AgKXs66koA2K?=
 =?us-ascii?Q?rBXwC+wW0etHdks0B++rqjQvNRiXfxWroB06lyVHrgZXhKzv/B1IXk7j2Ovw?=
 =?us-ascii?Q?OhjMSSzzjFdfxm1Hjjn6A9+F1uk1hsVfxXZ/PHO7Bn9n1SQaSAZwlFi8HoXV?=
 =?us-ascii?Q?MVa9SOW0A9XxQnzK93+uj3R/0lNmF7Vc2Ecp9NCG5ECqiIOOOhn8AY1esl37?=
 =?us-ascii?Q?GT//LHO3eDRim8gTrrRmeGSoCAjOHLXRGjT6CKQcMBtpeYQy0KyxP6/yfTEP?=
 =?us-ascii?Q?Zg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	BGlFycuzuDi+Fe7CZHXsD/SnZFCqMtwJAWNFKxnhpdvAoGCbTVRseqrm8Pjh0yXkuJHpyC6zw3RScndzHXueyPpauqqAMzROFnfukeJT9p1SzspCILHoLK1dSRDp1RtGK+6YIoLj0KHowzERX5ZNhqCBfXI7Wx3es/rXSPCkKOMTnKsIam29p919rSMDhBr+x0OT9/tCeN97VV3d/mldQLaJJiCltPCAaofdhqjAULpL9ou79q0dbKyG5E4ALyLF2Fn+l7axJzjkOcasnMcKqV9sD6FPX5f+wXtsd+IAN4YV7RIuUxbmG9jN7XbAaVQlKj7fOLqvQL2QeElMPDImPXK5OTukUp/zudHbO8sisfC0AnEN8CeWkegbHtOabtzFK8iaxXyEtlLZSBk5j0FFA5yyW05zJdVjXpwb4LLwt/WQpHZpLKXX4oIuUB69KjDxKTLobM1i5ks+9RUa+ZITT0WjM+rrUVUehbC5qL0/xDDZsKAMo+TuT4+GpiI8fpR5fRtZyEO0VM2IhphCy3djY5FmytejhFifUJrer45cPn458HVmO6/IQj/IeKqdMR7r0qxe6bQsYKfcCrB7QSfqiJXYycwZmN85VNRj22xklGY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 617cd091-ee11-4e1f-6cf6-08dca0071d60
X-MS-Exchange-CrossTenant-AuthSource: CH2PR10MB4312.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2024 11:06:00.0599
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LXldoOCqaRdk2RK6vL9Oi5W+Tzx1dXzEmJzXyKhy+f+TXrafcC/WZvfllCfN2JGrk8L6PrYYldNC+k+TcTjuZA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR10MB8068
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-09_02,2024-07-08_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 adultscore=0 suspectscore=0
 malwarescore=0 spamscore=0 phishscore=0 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2406180000
 definitions=main-2407090076
X-Proofpoint-GUID: mbUP7vuxvwANt3YjpoQBk-pzsanEQpMk
X-Proofpoint-ORIG-GUID: mbUP7vuxvwANt3YjpoQBk-pzsanEQpMk

Add missing entries for req_flag_bits.

Signed-off-by: John Garry <john.g.garry@oracle.com>
---
 block/blk-mq-debugfs.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/block/blk-mq-debugfs.c b/block/blk-mq-debugfs.c
index e37d5a2dd942..62ad3ddf0175 100644
--- a/block/blk-mq-debugfs.c
+++ b/block/blk-mq-debugfs.c
@@ -230,6 +230,11 @@ static const char *const cmd_flag_name[] = {
 	CMD_FLAG_NAME(NOWAIT),
 	CMD_FLAG_NAME(NOUNMAP),
 	CMD_FLAG_NAME(POLLED),
+	CMD_FLAG_NAME(ALLOC_CACHE),
+	CMD_FLAG_NAME(SWAP),
+	CMD_FLAG_NAME(DRV),
+	CMD_FLAG_NAME(FS_PRIVATE),
+	CMD_FLAG_NAME(NOUNMAP),
 };
 #undef CMD_FLAG_NAME
 
-- 
2.31.1

