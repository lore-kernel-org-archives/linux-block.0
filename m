Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C599F73459;
	Mon,  8 Jul 2024 09:17:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720430244; cv=fail; b=tQ8goQROtG8VVkZqYYe7/aPzkkk8wLsJo7n4GGXxA+6g6rxrp8UOqQcF9kY8iDbZ3Em3r9+W1FiCC3clPQOUxjOTELfazjvrh+w0zjvzSXLHj6OhQ2AyEEBA3OosPWvuITYkTm44CXAhcnXTOtkk46Mqz189LetO5jYYdK9glWs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720430244; c=relaxed/simple;
	bh=MIDlf5qR41P2BYlbuUuNHrlqFaUR7cS9PsnOwU1HzEE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=nVWPVlKc7TqbplTb7HrNriINXn0oCYGt//UskQA6qg2Z4kqB3LoIDjkHMoBSds5zsV6kDfFStbl+vwZPPZwr0IYWK6QQ36PDlBy8tIKtRl9fxhCenqM7Sz3xDecwnJ0hZ6eN1Ey9W5+gCSH4Y8sVKhCWvfp5VHoUqwNNUa3v1kE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=ENefULNa; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=AQddPor1; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ENefULNa";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="AQddPor1"
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4687fTCe000623;
	Mon, 8 Jul 2024 09:17:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:content-transfer-encoding:content-type:mime-version; s=
	corp-2023-11-20; bh=FPL3ZZX9u3o4sooyi7LvwApX0K74xlsWOHiXFDJ7rpk=; b=
	ENefULNahB/BL2V+Jh3Wt7ht3ul9JnnMLaqZJ/NEeNItaCE2j1dV0jWd/fiDoHgu
	cmJ8r0/F/ZaTUrH4QNRq7wdS/uj95Tm1jTAgvL5W6vPkS7Yh0jOFOe4nYF9tUHgT
	xVk1GO9cq83vh8swouktlWAk05p0nyFIg4usWwmE3PcW40cu5UhzbGhYIek/kTUF
	pC2n0ZEQzveLkAcM75ftRktOlPk/hZXoafqufNZD5M5T9msKj07Wu0+xKQaYNUsx
	PbSxkpsFoYMR4icf6WYYERSumSpXWT5Cai+Ub7Kf0VvzOTIelhUaER2Lp7thS05z
	rf1uPE8hpRF6pSNC1InjSQ==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 406wkca61s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 08 Jul 2024 09:17:04 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 4687FHQc005608;
	Mon, 8 Jul 2024 09:17:03 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2168.outbound.protection.outlook.com [104.47.57.168])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 407tx0vxf5-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 08 Jul 2024 09:17:03 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JWyDDZAOfLd56C12leBNzNkFqlszmw0MeDtrowgx4h7r3OWLGry/Bj+s+GMqJzYAIf2FqSsaPNeXeh9y2mepqdDZzmvbUTSmJD10X8oqXJDcoaEFTHX9h2C/7AzmqGJaakVyEmg0YD0lEM8dnu5wRXnOETiPoNZ1tKji1El3afGaPdCecSI4S0TcH0Sk9cRhtRBZCIpdBUzom49C3PUd0Q3xnNVYV+bOuz3jpEexyzBy86oNoIfZBkMCZFuQquf913HMlsdMus1IdtKsPo0ZJDs7xZ41l1FIJRPuXH4fEvvq/lpElKiOPGF/tWOqvJKm2bd4LuPFlOLFNJ+2yQIO0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FPL3ZZX9u3o4sooyi7LvwApX0K74xlsWOHiXFDJ7rpk=;
 b=JiCJnnJXMaZ09CXxeESdQzUgCHEvNr5QzZOZgB1Mjm4ngPCcWmi9xpgSjOpjmmfm7AHJ/lmHKx4V9ft/sP9mlB04J7MW78He/61aKtNaKNnz1Vwo9vcq+s4TPs7MY9ZemYzT2RnLTvk2k9Sii/UFHHyaz5vkSlmvGgZC9ocY8S+2RIBPQAIAyGLRYfvIyTHVBj31zpj01QSarb3tqukBjKqq06dguaSxVpGLhgzctPVpeA/wl1cTv5PbuEWzJwh80kku5oUhHP8EuRh3k8eLfs5q3PuAqXqEJDJFWZVV6Y20o191Nug/Rf8hWndxt1EvjCPSyEbdMP5KLaIzHa6Kgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FPL3ZZX9u3o4sooyi7LvwApX0K74xlsWOHiXFDJ7rpk=;
 b=AQddPor1vPfZiP9wJFT7DkJjeob0VbdtHdmXFhgljCVbjxsNNzUR+R6GDuD/w61rGI/KPaAz5Kz3/UoD2G6zLfFowTEtXJZxp96ku000Wd1fEP8i59HhzvPKoRkppmo4N7FWoS+U9wVbcwdYgblqPHuZTIse+wVhP48TCDp9AIg=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by DS0PR10MB6799.namprd10.prod.outlook.com (2603:10b6:8:13f::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.35; Mon, 8 Jul
 2024 09:17:01 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%6]) with mapi id 15.20.7741.033; Mon, 8 Jul 2024
 09:17:01 +0000
From: John Garry <john.g.garry@oracle.com>
To: axboe@kernel.dk, mst@redhat.com, jasowang@redhat.com,
        xuanzhuo@linux.alibaba.com, eperezma@redhat.com, pbonzini@redhat.com,
        stefanha@redhat.com, hare@suse.de, kbusch@kernel.org, hch@lst.de
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        virtualization@lists.linux.dev, John Garry <john.g.garry@oracle.com>
Subject: [PATCH v2 2/5] block: Validate logical block size in blk_validate_limits()
Date: Mon,  8 Jul 2024 09:16:48 +0000
Message-Id: <20240708091651.177447-3-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20240708091651.177447-1-john.g.garry@oracle.com>
References: <20240708091651.177447-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR13CA0005.namprd13.prod.outlook.com
 (2603:10b6:208:160::18) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|DS0PR10MB6799:EE_
X-MS-Office365-Filtering-Correlation-Id: 80e6f45f-a165-4275-437b-08dc9f2eb9f1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|376014|7416014|1800799024|366016|921020;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?uj7Bp1d2YUbL8CQjF+VoG+3JA70RHw6Rk8QySalGxCp/rqvdzA3+fNl+uA03?=
 =?us-ascii?Q?d90mgztVddd8qLcNdFosBJN9rXA749biY4aXInMCvxhr5qZEXLoAvKIeciEX?=
 =?us-ascii?Q?OlNmxzh8YjgPSOg8TSQtTzyX8Pw4IZE/2dtKb+uONIplBD1jzDp1pFPKTk4e?=
 =?us-ascii?Q?jh41qIJrnLaT1j0ftsYJFGrO7qQBlnZraXxd7NOKsnqT4PXknTOmEYbNQoza?=
 =?us-ascii?Q?mYJd8lEfNCzdE/pRoXBHqekWy7VGxqifSEC0R/1t3FFFlkOAWj+wfR6xIE5q?=
 =?us-ascii?Q?3Axpx/yjWfdAC/FSShnstXdrsvMNhMz126mlpm21G3Az9eRUc1LKd7dpp57M?=
 =?us-ascii?Q?sH6P2H4S6za54XzFTwFmIuxAJLq0QyqdX9Wy6dG+IuPVTL/NH4d7BySQB4p9?=
 =?us-ascii?Q?Ds809W8iUyDVylcXprMRKYcszSD+XFSn074jvKpBkO+O5ek+qzZkiAN79UuW?=
 =?us-ascii?Q?TllilFs4yOLdE3InY3YG7ZIX5hyvcHTOshprNUPzEZ10eqe55tkLRxkJ+pol?=
 =?us-ascii?Q?6fzoCFcEIFsTzxNthd5hlcZyaT1cRjRXsrUiJtpfl7lxxegskjb76GBqZBi4?=
 =?us-ascii?Q?47swTTu9WjKQgY/BxCO0zETLqdWzfPV3J8+AscnKK5NmTPkzMrWI1SS+pc3s?=
 =?us-ascii?Q?20Iv3Nsr9ZsSzZABAkIWF5VfEIZrRJgvmb+VbmqfSMEhWTDd60LCjhmnPqeM?=
 =?us-ascii?Q?RptWGSZ1FpmVNOdwGdYIcQXnLcnSHfnhj3wj+rVUrXSodARCP2I6NBUvchyK?=
 =?us-ascii?Q?SjULbZfXkYLrTC7iAMPofpMZ4gPo8guzFO7BlcifyQ/iN/2Jt0fdv4usE882?=
 =?us-ascii?Q?LBRbKM1obwveSaQsiHo492cWs3HnLpwOfCGGQ/9RPDEeduUldQ4F9jBJj6uh?=
 =?us-ascii?Q?e0g23J/iDL3coDMqRsaIl2QaFZwIuEcSWsZOnYk5l28N+76/o86NxGBZIBYX?=
 =?us-ascii?Q?NCJLAHMsGWbdkZEvntPPUBGjHruFmhcNDH+ACgF97yK421KHX48uHLjYJPdO?=
 =?us-ascii?Q?7KoGg8av0L1SM17hYd4VDZ7sL7/xcnipV4Chb0yLiqJYWz/FCkApNUQYUsDk?=
 =?us-ascii?Q?z9IPF+QV/Q9yFgN/FWGd7Z7MtaoZr1rHwie2w/hehYkM9OP/Oxpzg+u+K36L?=
 =?us-ascii?Q?TZBByiL2E2Ue8EIIQijZcM9z4UNkndzN+gTRWUqxm9CYAbj8Q7bnFYomXxHe?=
 =?us-ascii?Q?AI+3Oy3IAgy9i0juiDGN+XxsaDaZJr5bVuavEwTzahoPHxupDlVsDCghAJxu?=
 =?us-ascii?Q?qN5w7cAGFA8HX9QpWN84hWl7cu5X6aviWQFoPiElE3Bq2u8TnkAU6jnMnVF/?=
 =?us-ascii?Q?0O7dmAg6fkO4D1dzf4Tbs0jArrNwynze91YJD91P2gEAGnKPh0fY/VC8Od5s?=
 =?us-ascii?Q?E/mRmKVWGmAk/eGJ1xvteLULykml?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?RguL3MyQqVPJdgbzeClFT12YGlTsESDC95ChlD0pKGSsV/XnTstPBO+ZU8WT?=
 =?us-ascii?Q?9RwyapBRol4MInjYevAc+l2obq09ERv6U+B2nHoKy9nakQFQ0QIGc4PjZbqd?=
 =?us-ascii?Q?6cGcK/2sWMMOBJOdZfMhwJD9vZvFxkOS7zR0Om5zCjvo235tZiLQH6dPkjrv?=
 =?us-ascii?Q?75J+IQ/pKI7qUXLdkKJVW3/u/3T12PcUsXW/s5Z9cYlOhLgb8avsCgULnyqv?=
 =?us-ascii?Q?E3xwmx1kZCwF7kOUORSEgP/Vb7j1WsFwBG7gYK9Hh958tOUFJLaQ7Bn43j0t?=
 =?us-ascii?Q?yLxcQqIBSFiib2nrKUBR8p4lrAG0SxOadRhxHUZUSAt2HkTPP5AaH6ysWeS3?=
 =?us-ascii?Q?FaNH3T4qvD7LYb2CXXQ67253sq2fPfgQi+SJyAstKhhiKM/GNtQZVp5VWD/A?=
 =?us-ascii?Q?JRnz6H0ukP6nl0RIFJlrI9q8RC72ohNqKAPnF5ljOAtJw7Db7pDQtsZGjPsl?=
 =?us-ascii?Q?pO6GoSJGBB9a8FtLwCcaiCci4PC7s1WRVkSd2BghfiXxFPKuO1CgHPUonKYR?=
 =?us-ascii?Q?Vip8g1L0lwALDMYPbvC/vfVExNy23G93GjSQqYP15hkhqDH0ugCtP2wAvcv/?=
 =?us-ascii?Q?+1ZmnwDQ6KZtDB1Zd2DxPdCjScWtzzheGBCtnfjjPBPcl1xCq7t+86oNWLz6?=
 =?us-ascii?Q?Py/giOBSy58+rrtp+QsyKSdIRqtojbwSISDUuaMo6YlwyOPCayRhb+xSFUnu?=
 =?us-ascii?Q?Sx+o8feXUWZgmNGZD4CyIOat0u5FvVTfcaXKnalHlbt+yg8qGUqNa9OP1Keu?=
 =?us-ascii?Q?8BDzvuXJ8vi43o4KEq24Z3g3iG1EZy5RJARDAvxZA+BzQjhJPIdccOzQObRC?=
 =?us-ascii?Q?qYoOTZMIeekp6vV0VHMLhCpnspm1dAvmmXMmekBNcV9hYd+3aV6umAK8Oxlo?=
 =?us-ascii?Q?kTmSCH9DrLM6c3XMpuxxHdCdSaeRFH8EVia3vB+PCLIHb+cS8r7uLIlZNEVv?=
 =?us-ascii?Q?IIcdNGqwiO3E/2eN5FpMa3PhL+O1BcZlTXucTNZC1uxruG0BJ9FSruvz3v/j?=
 =?us-ascii?Q?GZ/Nr9+Ch48n+RdeoPhmOWlhPeGyuhBi07QaT4aQ4IwNaKRR24dWEZfvxx4i?=
 =?us-ascii?Q?MZpcznKX4ZWRzFL+ZobqIEB3cul5oQb2TVTb8Ptn3RD+LSynpiQeipqvdp1/?=
 =?us-ascii?Q?j8EsepkRb73oGuxSdbCaa6izGJ5D62hmXyOfdGVbmCHOFaxm8v02vPd/Wq/P?=
 =?us-ascii?Q?+w5H43IslyMBOh+bdK+j5pmKWLhPcF1LleHs/NwhOSHbfSMtfkqKE7PIt4dJ?=
 =?us-ascii?Q?Tu6iNEz4KEB/cZf7uqZnUpUP+NSZ9BUg7/lX0hCH0QEI/CXLJFZ28jxOGTg7?=
 =?us-ascii?Q?0xFi79yL6P7WkizOnSz0PABeJCfBjHOHAGRSgUxNHAdxIBZX7WYfepbn3sTb?=
 =?us-ascii?Q?opi0C18j4t4lozPdnah7HrWATAv6wTUgV9sq8P+W2nSbhugvmkBxyLGPtDcm?=
 =?us-ascii?Q?9zeozXuiuEIO04yhXIdI3K/PRguP53PDuCR8wYCXdFx0GNsjl7TWHNhExh3x?=
 =?us-ascii?Q?csJ27k/maGfhDsQJiidZm97CWiAFPlTT1gV0HgFUkU6dZiaIKmbf0LmUlhXz?=
 =?us-ascii?Q?aUqrv3Q3Wy6wLkSujn9W6ALaCMRHI351UCYxnkplWUYuabqV1YRmDCp5vMz5?=
 =?us-ascii?Q?ug=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	BVNJjsQ/CJ756iOn/1L0UYSh5C1ZJmnGu7lQaTk6g8O4yC7rp9Q02psOPyjewcgHvdIoZT5yuyaXULSDovyWi9hxVH27kM1+OVmbicVru0joR289KuKLkLp2HReTMV2EfXjgNtHfab+hVV1t1Piu+1AJB7u3Opazx7fpbHuy3V8MizDjXyt/wBvF289EsadRKn7JdDJOZgpyyAH9K8mPACo+uLm5PmiYDSt6ZmK5nfBkrKhB4k7/WhSZeajSWsDZzec3OYqDU9xPf2cJ1XkiC+xu5XwLSgFM+5zp4I+ek9SMYEK7FeV1hWH244C5G3QKG/qp2aePXOkjZXNqk9pbA+2D2O8GYkH3eBj8vV2Vik6ybsccz2IXiIJv6tRS0DrCJ2mhzjBgW90eDdnOxk2MsXFqrsn6LHpgxK0PIxVYV0NQ2MqkZmdBz3W6rEdZCjbAZFLXDuUzDpeFQF0nszkUU/+r0y48tBy8A2LD1LTPXZWtaJ2jCF+jyVJ4kjQvoAarxo35ByGrhk6HbawVD3yKoHO18QyCKmFig0Ark7gX4M0TbmyN06vRlMDluXaFjRpfAeFBA5FQVlIT+dABwT3umYwLtK0CC5gUyCBFoNSCyw4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 80e6f45f-a165-4275-437b-08dc9f2eb9f1
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2024 09:17:01.7609
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7k1ISspTk7rIWkW3IiY44kTA42AEQYSXwbl5geAK2XpLD0H2QcqSBpEFAL2AFtaZTTafhvh3mdaHN2J4AqKRWg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB6799
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-08_04,2024-07-05_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 malwarescore=0
 mlxlogscore=999 mlxscore=0 adultscore=0 bulkscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2406180000
 definitions=main-2407080071
X-Proofpoint-ORIG-GUID: wXWeIqH5ZFXYNJKkUF9tLn6bSSlgWELc
X-Proofpoint-GUID: wXWeIqH5ZFXYNJKkUF9tLn6bSSlgWELc

Some drivers validate that their own logical block size. It is no harm to
always do this, so validate in blk_validate_limits().

This allows us to remove the validation in most of those drivers.

Add a comment to blk_validate_block_size() to inform users that self-
validation of LBS is usually unnecessary.

Signed-off-by: John Garry <john.g.garry@oracle.com>
---
 block/blk-settings.c   | 4 ++++
 include/linux/blkdev.h | 1 +
 2 files changed, 5 insertions(+)

diff --git a/block/blk-settings.c b/block/blk-settings.c
index 9fa4eed4df06..cd8a8eabc9a5 100644
--- a/block/blk-settings.c
+++ b/block/blk-settings.c
@@ -235,6 +235,10 @@ static int blk_validate_limits(struct queue_limits *lim)
 	 */
 	if (!lim->logical_block_size)
 		lim->logical_block_size = SECTOR_SIZE;
+	else if (blk_validate_block_size(lim->logical_block_size)) {
+		pr_warn("Invalid logical block size (%d)\n", lim->logical_block_size);
+		return -EINVAL;
+	}
 	if (lim->physical_block_size < lim->logical_block_size)
 		lim->physical_block_size = lim->logical_block_size;
 
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 02e04df27282..dce4a6bf7307 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -268,6 +268,7 @@ static inline dev_t disk_devt(struct gendisk *disk)
 	return MKDEV(disk->major, disk->first_minor);
 }
 
+/* blk_validate_limits() validates bsize, so drivers don't usually need to */
 static inline int blk_validate_block_size(unsigned long bsize)
 {
 	if (bsize < 512 || bsize > PAGE_SIZE || !is_power_of_2(bsize))
-- 
2.31.1

