Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3FAE537E9
	for <linux-block@vger.kernel.org>; Fri, 12 Sep 2025 09:57:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757671065; cv=fail; b=l0UwTRSW5CU/hJ3ljixbIK9MYZ8RF8nPtIj09koayL+EeWvqyWVxogVKHdCeyj2GU4P5Izv3YDbEu5rmzmSI66/CQodv3Sxk/h6Jq779+u1cQgAgUFMzzGF/nDBzmUK0aYdsGbwiGtI5enkXLPmGWi8xTy2iBqHeuRdsDokvtfA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757671065; c=relaxed/simple;
	bh=VXuLcr0YPdaAi0ibssSTau+/qfN7peO5TZioKgxUly4=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=sCoOuMg53jZCFKnL3TCuS8IYjaK6XoIP8/ir90FHKSx8c+Xif43u0VNjEAWChdzTwUGQR10bIsUTqH8YPXAO+n+Ix2kycK3eHYTJMn1UnfulUMeBibzjvmdTwTCK8ooGV63JyaCD/9fOu6OTZjols4yPq8E7LM/YPbJivr7bTeM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=U6fB8i9z; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=fJWTsQg8; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="U6fB8i9z";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="fJWTsQg8"
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58C1uepv009585;
	Fri, 12 Sep 2025 09:57:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=corp-2025-04-25; bh=Z+L82SfMlZ4uNSCS
	woY75KHiKt25wJmn8YYD1LT4pdI=; b=U6fB8i9zHi95meMj+LHJbnARQ9Z4MqMU
	xGGJ1K20+EujyEZKh4w030bvuhKDmv2DpjsKULege0K+7f6Z5sNaZLB3ZvuWeRxU
	uKcmNRPmyRWIO7CVdZq3CZVm/+aDyUTKsXHW2SC9fJWVBMxerPBuyBQ/YDbRO58+
	GKQWEy/0uH5kF9h+fBcbVLRDzlhIAsUKJWYa+yduvcN9XgwrxPUMZflyKfnr/LcL
	H0PjieHTzAMGeVq4+pgd/u+W0r4c4sjFCz1EezWv2t+Y5sNPmw2sdy+Cf40njS1w
	Qo1Be72KxxjyCc+H7FMRcekJtBIYW6oqeFIyVbVhC+nvwk97/+j0cA==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4921m2ywe9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 12 Sep 2025 09:57:42 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 58C8pQfT013398;
	Fri, 12 Sep 2025 09:57:41 GMT
Received: from sn4pr0501cu005.outbound.protection.outlook.com (mail-southcentralusazon11011059.outbound.protection.outlook.com [40.93.194.59])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 490bddudc7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 12 Sep 2025 09:57:41 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Bm0qDEq7nTbAl/2kjtPSMbKg5G60RZ2WbK2tg4CuCrxE8ouC0TvDZOk5G9eH1oIZIz3glFiLF34BT2oxcrOZbjzp6qk29FfMZDCX6/LAI+BwcKsie9HdVsMNF28u65m6fNFTfUNACJ43kTRazTfIozo4ATpxMm+G+/u7bb3iojHAosKezEL1jUX4+z2QsEuBn3gDOU2xwk54XEn6o4w+9umoEIea2kiDZp8In6thfWC7W1jnQrP6xBxDej0VZsMX3W3veULFWfLeSfyjNche42ki7M2hjuNPI4RPIDmAhKETH1yNBaZkH9JAbMc/i/01CBz5JbnPTjlJR5HJ4e6IyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z+L82SfMlZ4uNSCSwoY75KHiKt25wJmn8YYD1LT4pdI=;
 b=eiGKxd8lW/WVfVEcBlNn9FMnru1Ejd8kzI2i3NuwWv/XBVcj/6tsWnqgWBcz9PNB6nucDj2B3ur6CO47cp1gGwH63m5sZsHCDhyg0tMkNbF6hx8WGWzwPkaSvJeNYLFi9wbAa47fjtF18l/Uj+BDpbPGmcHCHJsJ+Z13795aR0dWS7MwtIzYXJfPCyYTfqlmOYUUHfF5rrABBlRVIQtOyqMiGvTbITi4u4kaq529yQHRiB8UM4cifI3RgOS5GNBwE/L0xAxoFTQD2wlS46gjt4UfWq5fM3Cn4EteawE3lQqRKMNjDagkReFOivvUEB1lqemns/29KyO8g5DTESpzGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z+L82SfMlZ4uNSCSwoY75KHiKt25wJmn8YYD1LT4pdI=;
 b=fJWTsQg86h0defgBNVUIvUsTdPKRuzlmuq+2BxNpunxvxLy3/IrAhgFEHSYOEL/6G2RjcLw1YPpn/VgaLnAKzG4UYULADbkt31lk0G5fTczb6vT38f1Pwz60Eo9JYra304q6mQI4sY0gb/PxmKVQqpKOMU6B9wyvsGEMGEdi3kY=
Received: from MN2PR10MB4320.namprd10.prod.outlook.com (2603:10b6:208:1d5::16)
 by MN0PR10MB5909.namprd10.prod.outlook.com (2603:10b6:208:3cf::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Fri, 12 Sep
 2025 09:57:39 +0000
Received: from MN2PR10MB4320.namprd10.prod.outlook.com
 ([fe80::42ec:1d58:8ba8:800c]) by MN2PR10MB4320.namprd10.prod.outlook.com
 ([fe80::42ec:1d58:8ba8:800c%7]) with mapi id 15.20.9094.021; Fri, 12 Sep 2025
 09:57:39 +0000
From: John Garry <john.g.garry@oracle.com>
To: linux-block@vger.kernel.org, shinichiro.kawasaki@wdc.com
Cc: John Garry <john.g.garry@oracle.com>
Subject: [PATCH blktests 0/7] Further stacked device atomic writes testing
Date: Fri, 12 Sep 2025 09:57:22 +0000
Message-ID: <20250912095729.2281934-1-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.43.5
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PH7PR13CA0014.namprd13.prod.outlook.com
 (2603:10b6:510:174::28) To MN2PR10MB4320.namprd10.prod.outlook.com
 (2603:10b6:208:1d5::16)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR10MB4320:EE_|MN0PR10MB5909:EE_
X-MS-Office365-Filtering-Correlation-Id: ca563acf-3dec-4ba1-675e-08ddf1e2ceaf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?nLB0ZlJtqrnUEEaWfOBBGoypwEk0onxLxP2MlsZDplXzL2rWalmhpEer0Fu4?=
 =?us-ascii?Q?LepYmNPe5Ma7XamwPQXlj/FALfMVjrrhwy+Inp3MPMH2jC2tNld5I0b9E20T?=
 =?us-ascii?Q?ea4FmAluNTcBsPnesM81O5QtYP+z8d6boP3KkpbyKt6L0wZLp29C80aNPiXH?=
 =?us-ascii?Q?qhiWkZ4uZTEhQ3N2V+pdmlDVvhrrWMJs9cdvh8AT7oanC3DPOD78/Vlv1fl9?=
 =?us-ascii?Q?ks/1AmpgHUeJ+/E2IvX48IQInf4aRUBNZ4FFrlzLyBT953y3qJbPAOrkmstf?=
 =?us-ascii?Q?qt7BYS1tQTY573OvBwDdjtuzkmUHEwZKjudBkaAGzi2LQEgSaoNQkBW7me9S?=
 =?us-ascii?Q?kQ5bnf2ODVVd/WhE/saaUihZMWsshg/7JV0uzOd+vT2LYuHiBlo0UbK3Rxod?=
 =?us-ascii?Q?9EsyCH/+505tBuNWCvdlkDt6ixoLscgT51zLBg7ZZMViq52GUM53vMIoRxVC?=
 =?us-ascii?Q?DDXbfTdCwQ7ibyxBrwh+vgdzOzWVhEPba86SxEWTT2IJNfhRsnvrAfZ9NB0F?=
 =?us-ascii?Q?KeQGRsKVIc6lkQkmNcYvUJMUuAF1eW1TpcYO6KNOHgPR25rPXxr9MS9nRXxo?=
 =?us-ascii?Q?R+TpPL07xjz2YYmVymvZHVK/4LdmrIXFhIo462izwBJV7NjL18ANWWIUFTts?=
 =?us-ascii?Q?D2ieDJoSjp8VHX5d4Lqzn2N8e6i9D/I3od8h4b4AMArfSlGJy++SEeAiWlhj?=
 =?us-ascii?Q?GJETXa9Pme5DbTwTBRePXPwyrBHBcKiJf/9BEU/ZNUgb3PUlp28CWmi2yJDG?=
 =?us-ascii?Q?iMokcA6gppXOKXVXHdNXoeXOEiUsJ/gv3jfeWOOE+7IBbvAjkq4AYHCQ+/2h?=
 =?us-ascii?Q?jEBBky3s3FeLIcBGfBpT6+KRMDBOq5nP0vkMHx0EjhcU/fnSaeNjqWjH5HhZ?=
 =?us-ascii?Q?Ul/KSp/JdUFRg6zgWNnqC+9nXcCknKSbqyxqacEZ5Dak4l+SZfS8ZeGVW335?=
 =?us-ascii?Q?CF1a4w2zKfe6324BaAB16O7sqAlyPJ80HuJSy+T2eVR23pyJTxtI5BopCtLt?=
 =?us-ascii?Q?lEe/kelo1zcMEZb/Anxvgihr+fUHufAJsQYgTlrrbqEj1Q/0BxlBmiIANuu2?=
 =?us-ascii?Q?yI9Mx6wq38y23i9rd+xfpMG2DVLsmIUA6K4rAYd8lBtAmeCULB2TxKe5RNeQ?=
 =?us-ascii?Q?OGAw85Budo4mufOuwaC5VkiyqXBQb46kkXrAi8LvSJDGd+uXA6pLQVNMu4Hr?=
 =?us-ascii?Q?KUpkzQq2zv6grCyuAUkIhwYCdN7iNmh6dmmKp6zgWf4iApgKShzdTSdAyFSw?=
 =?us-ascii?Q?UIsHyMXA+9MDh9wrEPMjNwqT18Bsd+mVaypoXXdP3/43fwBWz2YsEg22+XL5?=
 =?us-ascii?Q?E56waWVgK/+cdPe6gdOmoSLjxRTyHvalGbEiTT+yRaDkiDWwISE98qrMV1Pz?=
 =?us-ascii?Q?RTRG76U9uPmnRM8VloYgX3B0OR9XAMZO6q3Y30nTCfp3qNbYr5A/2V7NnMLb?=
 =?us-ascii?Q?w3npCcibhNk=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4320.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?DqymwPPxB/3jj7puDwOufqQU5tiYygeKsQ8llt0q4GMwxSJtjZ0vqSJEd+TE?=
 =?us-ascii?Q?LWl3e7y0pZj+9eMMpeifSwXVhcdfACEdivfJrdcG6tV7PFYUl8QWmQxUr/sv?=
 =?us-ascii?Q?GD5UuC0VBllDMj0jpe+zV93ObVmVT2ZSrkk3Sx3HWHxm8cqKQEiAP2ecOorv?=
 =?us-ascii?Q?hIDu6hZ5sxdFTFF+KHlMuBPhTk4mLaZT5OuvBk3vT6jGfD1lRiig6aMA8drB?=
 =?us-ascii?Q?eeNhOjJ6+NZ+cB4DAcQM4Vo44TWcz36bwffUB+t5Owttb2RVNwyaJmoXXC/N?=
 =?us-ascii?Q?LiFxzG5dUaqbb8Xo88riSqiGUFTOu6QwajzKYIyYTjNxWAlSjlaSYuFGQKVS?=
 =?us-ascii?Q?WnYNyQQkcjRiNpf/ME9NzIi7h9Y+G0u4wwy4kf6TzarsywZFHezrEqjko3Em?=
 =?us-ascii?Q?Bw60JlItk3kBG8HaXiS1InA766YtHYnr4u7k5gfOBEG7QtuCMjxaBKXIPRRt?=
 =?us-ascii?Q?og3KmBRkNIrAcY+RNZNdL9CyC4JQfRs54gFy8LSJR4sPy76qXeefCTpigjnJ?=
 =?us-ascii?Q?9IvykEya6Jfy+u3wlLfkSvVHK4/uQeh2ikzzyMapBD+zflNbq814zSVneQkO?=
 =?us-ascii?Q?OFujgJ5J2TzlS3eVnpYr3UaOR9nUZ8XveZNij7Jqm2Pj4Jdlb1mhn6QywXt6?=
 =?us-ascii?Q?tpBgx5SUBK9u/NidRigouSzVbuV1xcpTuf2t3qu0j2LuabeiWsM1Yv58RhAS?=
 =?us-ascii?Q?ifYLgCzOBRfdCKHRh+bbetZULK1Zb1dy0Crhde7fTOVF4oLnSlMaWXYXrhA3?=
 =?us-ascii?Q?2zlq3QknY1X0gUJTEJq1mojjU0F5uRQ0HDmqWx6R6WfcYh2kxgP8AceIcA7g?=
 =?us-ascii?Q?qkwHnn9bmRpFvtWYC+yEwiW6yNppObTozBYssSN9YIJk1tRNVSaSgW3h9ch6?=
 =?us-ascii?Q?08NSlhSOY2oOwlKmNnqX1tcjIHsyNAjpgxT6ZV/Ta9ZO4JNpV7E4qe7esw/J?=
 =?us-ascii?Q?gnB/uVmJ3AUp6Ka+PTpMl1C73pnaU5LX+Efzj7XPu4TeI+/XqqbFGz0/ca0f?=
 =?us-ascii?Q?+/gGG2UtxOlKzhKvhJFUu2VF2J86VB96SHPqDgQLDXi3xUsQYE8+w2OnteY+?=
 =?us-ascii?Q?uPyk9heBu6Yg8Y8MhN74Dhq/PGWqyx5yARG4QR+oU1L61qHyMQd0CvDFMgJa?=
 =?us-ascii?Q?b8pNiIi+/rdjguiSszThbxOYz2cZCx0PbWTL+aauc9OSsXRFXkpIUpWGbpRk?=
 =?us-ascii?Q?NMRL8Zz3zkWo5w7IHhb6Q+S4WPCKHWltvwWkyGqROAg5n3T+zCzS1LXcotIM?=
 =?us-ascii?Q?wL0GeSKh+dAzCQd2tJCneDccyclBEERN1iPoRRpms3GIlmdEOjhR9j9g2ODZ?=
 =?us-ascii?Q?/tOxz6nYbr5nWNgiNfe8F1CMOiFLfYz4pu+z2FzC4rqWneS26ZZdpVBhdiUV?=
 =?us-ascii?Q?+63Mwg9Yv9XF1QHNYKxwDGipHErkYwQkXJd4QO7mXmo7ZQ7vyDUMGDahtf6Z?=
 =?us-ascii?Q?1F3GeAB5z8ptGMJMoCTkF05JMyOFeHHTBdWOBA0xBOiFpfWucfOY/OX9pMsU?=
 =?us-ascii?Q?EfaaJ55UQZMlrq2EEISFCh+KshLURz91vV0WT9yU8kC1xthXq0eFEFmeJSHY?=
 =?us-ascii?Q?TZbuiYKrEodyZ+DGRbpyNeoxP0Q3GLMv3vkVzCj2gBCaUKYPNsUTpN8bUTNq?=
 =?us-ascii?Q?NA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	A7kNPGdlUTYD+6y37aGzVAQt8tkf+X9FT71qtg2b6LI3Rh8x3pBUM88ff57Gp1ubSA4+xTMK7jjwiqWh1AfZ19HCYGTAQdlHcu+7x9emqzDUDEumsUWJeU3Ftzpn4EbSVm09v6fN2NlxzIgDTsvBeWxH4Uq6hlTBty6/FwCmUkbDcQJIn6lQRmhUs1TvPSUrOxDI/zyQKuOp5wtQt/R0bxKflQZSrEMaX8sKHdpiqeqDvRKl6foFcS7DS4DzPaRnDuxesnarlOQfY77v2iuTNTIz7/tHHtEiO1SvhTftAgnDqo//QvmZe4nMBhtM20sWk+gSKq9GFog03WQWp83rQVWXJOfxO1WRzW8fbxaVpp+dnqtZWhUrAr4jeM73r3+ObppzRddZSeMTFmBGflxJ+m8ozy/E+CPXP5k05g7li2Wl9RjHYp6poHfpYghPFRkamGnUsLhkydyqTYD9vOEGd5s6F4L2hsVgx2czRN9/Rsv7PHWZyZot76U6NgqmufduQ3m9gvA4kfyfyzPNife3HOHbpHFn4VwDs5kgmiZKBWMtk6+JpSdic4B6qIu3QDpYCmxg+WorymOTsunSb2eF/QP4dkmroJc9kI1uX5Dz3y4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ca563acf-3dec-4ba1-675e-08ddf1e2ceaf
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4320.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2025 09:57:39.2870
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: x2Q6wvq1iAmsraADQPRbR6JXyQW8t0PyHM9yek6Z1+g7xjQUldpZSXCwybRrS3xVZbkMdzo80vt7j4xTJhsPgA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR10MB5909
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-12_03,2025-09-11_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 spamscore=0 mlxscore=0
 mlxlogscore=858 adultscore=0 phishscore=0 bulkscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2508110000
 definitions=main-2509120093
X-Proofpoint-GUID: qf-NiX-srQ0EpKsHEdrLrUxdIQTCkg2e
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA4MDE1MSBTYWx0ZWRfX7oApy7aecGhN
 HA5Yn+sIt7Pmp9VZ+6v4dlVZVZbOiPLDVbfMvTcmlVr7QngaPgHXR0TR4aGexm64VzXfi+MXVk6
 VVN2yLcSFuXZemG2VztuRd+eBdlfa+7yphnpWWiRKy/L770jSxVeC0wHsznTjzJZotVm8OQQsK3
 OKai+4AveybcKhMDUJK4Vqy3vD4kBO6VjuZJfWLktTbBpgzTpIpBU5o5DqvTmM6sG025xmCNl45
 bTO7rFKP8k7XIkxwlEQk22Iog6k2C7jIAC1MRM1ARBcGLonPust30I5mICF9xIbeARTr+l6PU0b
 MRCb2cmoR+AgZZLjXpltEHJjhiZ6J6YoJASIqJ3t5uskmoh7TJmI0wdinD0u7b/qW9c6ujbYv72
 AG5WRvEu
X-Authority-Analysis: v=2.4 cv=Dp5W+H/+ c=1 sm=1 tr=0 ts=68c3ee96 b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=yJojWOMRYYMA:10
 a=GoEa3M9JfhUA:10 a=O-p1e9WbuDlc2-BoR8gA:9
X-Proofpoint-ORIG-GUID: qf-NiX-srQ0EpKsHEdrLrUxdIQTCkg2e

The testing of atomic writes support for stacked devices is limited.

We only test scsi_debug and for a limited sets of personalities.

Extend to test NVMe and also extend to the following stacked device
personalities:
- dm-linear
- dm-stripe
- dm-mirror

Also add more strict atomic writes limits testing.

John Garry (7):
  common/rc: add _min()
  md/rc: add _md_atomics_test
  md/002: convert to use _md_atomics_test
  md/003: add NVMe atomic write tests for stacked devices
  md/rc: test atomic writes for dm-linear
  md/rc: test atomic writes for dm-stripe
  md/rc: test atomic writes for dm-mirror

 common/rc        |  11 ++
 tests/md/002     | 213 +----------------------
 tests/md/002.out | 238 ++++++++++++++++++++-----
 tests/md/003     |  52 ++++++
 tests/md/003.out |   1 +
 tests/md/rc      | 441 +++++++++++++++++++++++++++++++++++++++++++++++
 6 files changed, 705 insertions(+), 251 deletions(-)
 create mode 100755 tests/md/003
 create mode 120000 tests/md/003.out

-- 
2.43.5

