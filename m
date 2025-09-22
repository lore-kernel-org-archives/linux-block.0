Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3591F2FDC53
	for <linux-block@vger.kernel.org>; Mon, 22 Sep 2025 10:25:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758536705; cv=fail; b=erAXFALRSKXXMC9W8v80BM79eAA3dJMNnqcWBi4jbn47/AHDZopkfYRajmL7PK4eQjCiu8K4bHWG7sOP3NBQ3jaBD5jP8hQ20M0Yk96LDIGWRCoFGhRwtqF+mc8yBBvLymodjewkMa7lR7euHUKsywqy5HkloSpIEEBjI5aUDsQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758536705; c=relaxed/simple;
	bh=JI9GPX4iMOrm5qfwryKwMzGrS8jDXLFcqbY6DKaqo6c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=llQdcwMVs5/WvP+2bODzbZ3IeBZS32LU2NeruTx/XEr92r/iYf+zzCRR5fmFJxd0UntNi2KkurBKr/0SgTwc4aG0qoco1aO5XEqRzx4d6TqBM1SVzeBul8/9jvKjb/B6+H3KsE0h8ymscJjaz/dDjye9z+CJIjrg9Y+kZdlRSA8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=RlUGDEnw; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=q4JZqIuM; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="RlUGDEnw";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="q4JZqIuM"
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58M7N1Jp010549;
	Mon, 22 Sep 2025 10:25:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=wvBDvChqe5u9XVmRH3t/VkYFElGKNHaSyFoI8aQiM54=; b=
	RlUGDEnwEuzldjsRVFcjOv3CfF2vQRLuERGRGiribitTvbINQIZ3OjwmJf/T5MvI
	SfikB/B0Njw8WUqdVXcNsSr65HyEPQWnj4kqDhTShNPFWDjHokPAqIIsjIkDuHlK
	99udLaNMfkd1IyQrpwMgq1F3q5o6kHuHwgwlkbcVqsWzJbkjNzhNBpgWZqmW7Hvi
	+oPbAOxSLoeGWI2qSlPXk1+7+5wNp3eHo1jm4QTm3HTm2Q1RbFwh2abOzeW4Mn5o
	kApg3/ZZCR75e5c9SZz/i7Mr/PPw3M4bv6cDDy0UFZDiwA4+8g7y5JVKfD8PzFc8
	mhfQWdlRliLlWBN1+GPbUQ==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 499k6at4gg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 22 Sep 2025 10:25:03 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 58M8nBMD028395;
	Mon, 22 Sep 2025 10:25:02 GMT
Received: from cy7pr03cu001.outbound.protection.outlook.com (mail-westcentralusazon11010062.outbound.protection.outlook.com [40.93.198.62])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 499jq6wxf8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 22 Sep 2025 10:25:02 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jS1i2zDSACHSM+L0FElwf/3MzDcCsCTBW2Fm7Dltk2t4IPE7rPapWO3Pae3urM9fuG1/MGBv65Nuovpdoy/j2TiXFQHSueW3pMBvsTg6gV5Ohuz1Po9dtczT9j5P6oY/Dp9o8aaKI0QnSXKMOEbFDztvwSWqajp2oQaVqHXUUHz/gYcSufB6j7A7EMOhaS7uQhU7eSQX1Emf2As9SEVIDfsgkdXtiMPKXODsWfCWPksnUhHLc1R//xmrMRo1lKJUYFNWqjYnqdIYt5d4RQZpoIn/JvjEsnTSanIMn9XpLUKLLFrSDH7kpKu5R7inpKP0v3VidY0AiBynCQoclWd6eA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wvBDvChqe5u9XVmRH3t/VkYFElGKNHaSyFoI8aQiM54=;
 b=fp27ui3MR8HfMIrLseZrbmed8UJjUaUlCMmviAgHqKMGs9XDaPNPnRFi8uoOxOD4tgwhA7cVNhQdIATKbiJAg7qqANLvxi/MzGfWDw62qWmcrR7ViyV/v8z1ZPyPjgxQBvKyIYxiQdq9m01bDWJc9zfNEyhQ0FKy5W5jv+/IhNralhlBy5RN5ge3jsaub+j1TJUd/fgcoIphdAwGPCfLXavD1NokM60cmFRBSnimwUrqfs0j6RsXlr9jq6A/Vgw0SMzKfAczZ/GFjwfRUxueqcliXIJ0Lpipnnat5FcjKJMNyCipo+NhQKt606eaUkvYYgZakG0UT/vIlXU2bWkoPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wvBDvChqe5u9XVmRH3t/VkYFElGKNHaSyFoI8aQiM54=;
 b=q4JZqIuMg/pCqj1xk5WRgR8UilhjpPaFgNxFQqDiNitH7udRlS1QYgoY+YPo3aQeNlk0USseXyL4I3SLfZI0h+zFLvOPZHAybwHF/Trg+S2nT+/v2BikaFQHeSlzGEpcHEuVcKPLhX2JI2G87QQd9/QbzVi8cObKJGOBp/UKNy0=
Received: from MN2PR10MB4320.namprd10.prod.outlook.com (2603:10b6:208:1d5::16)
 by CH2PR10MB4293.namprd10.prod.outlook.com (2603:10b6:610:7f::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.19; Mon, 22 Sep
 2025 10:25:00 +0000
Received: from MN2PR10MB4320.namprd10.prod.outlook.com
 ([fe80::42ec:1d58:8ba8:800c]) by MN2PR10MB4320.namprd10.prod.outlook.com
 ([fe80::42ec:1d58:8ba8:800c%5]) with mapi id 15.20.9137.012; Mon, 22 Sep 2025
 10:25:00 +0000
From: John Garry <john.g.garry@oracle.com>
To: linux-block@vger.kernel.org, shinichiro.kawasaki@wdc.com
Cc: John Garry <john.g.garry@oracle.com>
Subject: [PATCH blktests v2 9/9] md/rc: test atomic writes for dm-mirror
Date: Mon, 22 Sep 2025 10:24:33 +0000
Message-ID: <20250922102433.1586402-10-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250922102433.1586402-1-john.g.garry@oracle.com>
References: <20250922102433.1586402-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PH7P220CA0081.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:510:32c::29) To MN2PR10MB4320.namprd10.prod.outlook.com
 (2603:10b6:208:1d5::16)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR10MB4320:EE_|CH2PR10MB4293:EE_
X-MS-Office365-Filtering-Correlation-Id: 0828c01c-8284-4590-c3d1-08ddf9c2493e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ifhD1u1g5Iszjf4oaI1HrblFPB8Q8KRSf63cXXXnLaVmNxpaXc6EVXz2SB2J?=
 =?us-ascii?Q?wHyknjfSDfv9rzfBoCjvgbqEovnrCgKYmnbtdCHoULEXCQj12M2lM61bLJfd?=
 =?us-ascii?Q?ev1u3okezaYKah3OkS0OQkc+ieMH3dkZyWyeft/6PwO0S2woo6jKOYWlhMXe?=
 =?us-ascii?Q?Ch40JV99BU6p+lr4mM6nicxzqRc8MLuiuxAuHnoZSrrK2ODlZjkbw+G7W3XE?=
 =?us-ascii?Q?WNUoJkat5Ly/m4KxX289I+jKq4VP1hoCg8bTAaqzq8xcZAFH8eOubS3JezwP?=
 =?us-ascii?Q?p9UjSBMdSC4y/13pwjjhl034puVyZK4ZRqg281il80d/bZDAenarR0iUHx6i?=
 =?us-ascii?Q?fdwY//Bf4YGJFt4xntTlfZr2qcRkBsXVJsEC/wUmuRPTBqIork23ERrRRU2v?=
 =?us-ascii?Q?FYSheLAW9plwvxgaKXubLfN+VONvaoBXUjZLfF5HDkpMSK8KNZYt2tKkcrnO?=
 =?us-ascii?Q?y3I9M82WnByEALHy6whvJNTgTyp7w7GFpRXmbbdjeoF6KEL1lrqqq2nLnVXN?=
 =?us-ascii?Q?aPJ6UH3TtTTtBo3CmrMY79HSt7Se98+xKCRwVX6f0Aq1ipEPhtG1xrmLQIvB?=
 =?us-ascii?Q?U2S9NZwFNB7NwnlHX7sk+TUhxycGzTGCB/HO9H4iNWu8L1OkJTUwgyynJmhb?=
 =?us-ascii?Q?k8n1rzaViMr7Y9kzTMpo3Zlun9J5AM3skjluik34RE7Y5HWvlwJ/IvGAfhgq?=
 =?us-ascii?Q?fctRIiP203tf7OL8Y67Dlqa49TuG9jKRIQz6CWwBJihR1wia+uoUCtInjZ20?=
 =?us-ascii?Q?5shdXe1npkws0yJL4On3t+MjZpUH44riNAQmzTW9XMBwwJlcneAqMa/WhBfa?=
 =?us-ascii?Q?r4N3Fdu6+ANRQr+ylxk+bNh/AzWwo9qar73AyEZ38qMRd0UEUhIrChnnfl8S?=
 =?us-ascii?Q?iyaatt38MR2a6Gur7PpP5imD1BnbuMCuhYmQKIVPr1gE8FJgKnHIrIxh54Ai?=
 =?us-ascii?Q?tav0NOrzbT2m4UnODlFHodDbzXhWXj4v0GlMdWTaBeHRKTkCjMfTpnxWGEhW?=
 =?us-ascii?Q?x6i3lu17/X7lhOq+MVYxRPE9IaGDhzK6jZkd/3m0uKPMFHP30unxkxn5P3AZ?=
 =?us-ascii?Q?mEzlTkmxp5CSKyJlcsx/OYILXLr0GHAQwdYC2nYQ5gjTpc+koNbyC0KKmWF0?=
 =?us-ascii?Q?CdUmttVWzPv123H/h+P0vdamACIHQoIY2O4qSQIBy63hQkDQBPRMD6XkncP/?=
 =?us-ascii?Q?qjAG6b3iESx2rrf7/c9Uz+gPPTxVYwZi8mdLpw8fmuJsJcz0nwK/0lQCaTur?=
 =?us-ascii?Q?g5RQ3IpD+/RWioJQK7vEMHeiygXiqr74G1ciE2rZbo8jq8F7M6AXXMJs8cpZ?=
 =?us-ascii?Q?+wvaK8PjpqLUOvh55QEOxIIfqaKhsZHoLiwNKRJhqQuHVSy/GSG6+YKSouw9?=
 =?us-ascii?Q?hM9ta6thRpq5PKRE+EgwV8deNnMXSOGTUELTB6dNVB6djZ783wxF3OWiRW4Y?=
 =?us-ascii?Q?5IX518XxYqw=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4320.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?p4hrV53qP6I++S+s1lzUB2vyjzV6FqQqyL/HSGIWlUW0SUsUZ4Zr8aZtU0h+?=
 =?us-ascii?Q?P85DJh0fmp885Y/LCCXf0HspVzGFBvu/ZL3mU1ENk+FciGGMe73Ii5SyGveG?=
 =?us-ascii?Q?q5P9LajE9nCsgcPEVJtcuzfQobYrzQjdii6N3fj6XqYBvKxwgSJM2gbt/GLO?=
 =?us-ascii?Q?zuzlUz38g83PvKwrWtfj6iMTlxyksd3p69+m4rk/O2Z1krHbOdkde6IClCcM?=
 =?us-ascii?Q?ys1ZbB7qDFJ7Ufji7ySioHnevvFVK4JsT0s3NTQkjK38uvfcWeCVkltwawH+?=
 =?us-ascii?Q?p72TgpXpzMflhdLBeuygt4Taf+JjI0GTurLafCmGeD+FchmXUyWUvxYwfdDw?=
 =?us-ascii?Q?FE4J08TMBTX0SBw0m543dLxdaHEeHGR9/ij1m9GMQDbbpb3ekyFif5SVqwdy?=
 =?us-ascii?Q?5bHUOcPfQsYQHAoikbsucKtkN1obVb3MnJWYZJL24RqhMbl61uEuNkmnzA9X?=
 =?us-ascii?Q?YDruQOltWPACGvSeuqCv8AUvh5/JinUAtRMz9a56YRiA2IOc4CAve8xS/GUC?=
 =?us-ascii?Q?z5FxMRx3X+p5aHsYCUhDtbsf5BU3jjPaoO0/KhdAbVJmVNdH+J7NQdW+tZUQ?=
 =?us-ascii?Q?6YIn8PqvjsfVmvXX3TZG1xr9wxS8OMcHQ3qXIsYkKKpK2+1BrrSCJ17xgR54?=
 =?us-ascii?Q?Cy+oCfF+LzNmMmqCLi/MTgsDrdWwsmbTp6GnG5lAgS/+rW2OrvRUPohDAqYH?=
 =?us-ascii?Q?pJe5svIxGc0g7xcbCOFiE5YJRD8RxHl3IK3GC3nUz9lngBnzWFXa/FBOFZmb?=
 =?us-ascii?Q?b3a4ktsMuuTdvoKfVsjxof09P6MlkVy6Qr0u+HZjeUjjG0NKxA84L1+2LEXi?=
 =?us-ascii?Q?9djoHPTSE0wrhR7RyGodLVUYG2X+9qfmIqjG2g5jYY+p8Ulq1MoHZPHzKZ6K?=
 =?us-ascii?Q?oNbkgmdJAgx+/GyDyTGF5m+a4wB+J2yepKF5qI8DBHZeOgOqfNMyvZtGDjJR?=
 =?us-ascii?Q?9cZ3IrShTNLMdz68CAPVmlLjehH3g25MsIpd0lw2CHRsyB9su8NjqDUmtV38?=
 =?us-ascii?Q?MetjUdpCCcRIDdfGRT/jvBZP0fpMirFXmvcqyKI3bXCrMcZzrQs+PiU4K/1K?=
 =?us-ascii?Q?RifYkpNWaOJBBc9EdtYkX9bb/hyhSWpFdRUAtmL1fxKxJvwEdFOcqstpLq3U?=
 =?us-ascii?Q?PhyehhD5o/BoIeuUyGsUzIHay963TKE1A6LFkMEPal3ivJ0OTPAKqtsfO1ah?=
 =?us-ascii?Q?vnXI19mSZxzkjoehcdbBbj040uVsOexOBFe0JLhrMYqfeJwZnlmPb9s4Fovx?=
 =?us-ascii?Q?hjXMz47AwntzVU4W4Fc31E8CApRA6PJ2vr50ts5Kru4aWTz2p+1o7J4Q98Pd?=
 =?us-ascii?Q?uLyD+SIwzUAlw5fZ8qjoJIf+4Qml9DvgM+hEdowphIZIDUpZf2es7zQjkBYL?=
 =?us-ascii?Q?Opm0vWEZWVSgiFaNV/VKV/1rWSRwWoiUy8Od3ddbfl/IWkSf3EPSKL83pNWk?=
 =?us-ascii?Q?4UiiOcyET7jjW4+PHRVrmdpvL0BmSFFkKtlnYWu3zMObgl0ZwbvGAcV+0+kq?=
 =?us-ascii?Q?9RVE0pADjJDZUQ3cJ8yaNGLHWZsl3dlJMSwdZU1jNkjfa3QRoorBH7wzO5nW?=
 =?us-ascii?Q?PmdTMihecBSUW9/1/c5/LLHQu6gYkqEuDdspZ34qKmKZhbEInFSDSYSEFliV?=
 =?us-ascii?Q?Fw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	jkB0R0wKrmt+ayW4Npk2ipiVnRycZKWswOPIBxsIlKbZhN0ombJB1BBI6DCcuy8je7TlF/UfFg2F3jHKBgwMMJ3JYGKDQTj1FeAM9mWlcALBDglOFzayt7HHXlwZAWU0/z2xlZENUWY9EHynBbQd1Mk/IhsjycC3NK3AZqrFIOFsnSsJIWILxCNhPUHayvrffFXuOYQfrEe/EciaZ+Q07UcCU/Q+JK3LyOJzmwGzDUTqEGftl8z+2VJbj4uISMNRJ+1gy04GPYqhTaQJ8gpNNf0bqTdpbJUD0e2MlmTpq3Qx6w4qevDfkQfm+Xya4Z7SBfYOEQ30nKeH/1vyfWZZjTurYvGxUytyOJlxKx4aJsygiV/cLXrKhfAlVZMFi4CMADWHOfZkoKVfATy/cqbjYi1DbXNjvOgxdrEtytg3jje+grGxEAdi5uKS3weHb7Ahp5hWTBeCDwF2T1a1O8ou+7Mb531yYz3Dk6uz33/sxSDww4lwjDy8GEz0Y7L+cllMA0CtY1kG9m7h/0Xl0fC/4WkFjZiej7OMrbYFvUtRHF4+ascMB+anB0BUsN9sFhlTcxIs2HFq5fYOCPgyhCbDF6TZk6YCP8D0ck93m9/lyjw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0828c01c-8284-4590-c3d1-08ddf9c2493e
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4320.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2025 10:25:00.5184
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4iuMGDCpK9voayy4LCLDRCY5rBbLzKPaGpYwWokZNYuf1PSQgqGkmlOnMIo2YG5wXad/ASBI7cqaNeY92iqV/g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR10MB4293
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-22_01,2025-09-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0 suspectscore=0
 phishscore=0 mlxlogscore=999 mlxscore=0 spamscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2508110000
 definitions=main-2509220101
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIwMDAxNyBTYWx0ZWRfX5jpjzzi2fi2n
 uF6puoXU2ni5oeQNRNf1fxZjLGSbkrpuLjVShXxuOsOjKuO9Xkx1/tUkQ7WD7tuT/Tts1cntwlm
 n6/xXoVapGpCYCpN/tS7DK1FBt5rF3hejfXgUyLHLy7Vcj2FQjFM8C2eQCgJpmCxR2B6C6FpSK9
 /edDx2t1W3jmX0rTPHAsRxhQbN+raRSCcH+RM3ajcp/iWkZ9Nz2/Sh78OAXzZOfSqjXWxUxKToE
 /3U6R1CkEjKJ4ZKI8swa4kNRPsxXYJvtjZTkb7uci2qmviOoWzyIYX8b46Jpq2LM7yAZzIoSlw4
 4aJTfixkzXeoxdtu9D6UCr4orCFSzAthuaKlhZY8mdV6LgNMir1KVqJATMLBJOPm24m0T/xbb7G
 ocfOzrWr
X-Proofpoint-GUID: clsG74pjWPIOZFfw4JDYS2VExnYVUGCo
X-Authority-Analysis: v=2.4 cv=E47Npbdl c=1 sm=1 tr=0 ts=68d123ff b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=yJojWOMRYYMA:10
 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=O49_6yY3b9FuruliYdEA:9
X-Proofpoint-ORIG-GUID: clsG74pjWPIOZFfw4JDYS2VExnYVUGCo

Raise the required device size to 16MB, which would be enough to create a
2M mirror array.

Signed-off-by: John Garry <john.g.garry@oracle.com>
---
 tests/md/002     |  2 +-
 tests/md/002.out | 13 +++++++++++++
 tests/md/003     |  2 +-
 tests/md/rc      | 17 +++++++++++++----
 4 files changed, 28 insertions(+), 6 deletions(-)

diff --git a/tests/md/002 b/tests/md/002
index b0cbeb9..1af4bfb 100755
--- a/tests/md/002
+++ b/tests/md/002
@@ -23,7 +23,7 @@ test() {
 		num_tgts=1
 		add_host=4
 		per_host_store=true
-		dev_size_mb=5
+		dev_size_mb=16
 	)
 
 	echo "Running md_atomics_test"
diff --git a/tests/md/002.out b/tests/md/002.out
index cce1b1c..c6628bf 100644
--- a/tests/md/002.out
+++ b/tests/md/002.out
@@ -181,4 +181,17 @@ TEST 9 dm-stripe step 4 - perform a pwritev2 with size of sysfs_atomic_unit_max_
 TEST 10 dm-stripe step 4 - perform a pwritev2 with size of sysfs_atomic_unit_min_bytes with RWF_ATOMIC flag - pwritev2 should fail - pass
 pwrite: Invalid argument
 TEST 11 dm-stripe step 4 - perform a pwritev2 with a size of sysfs_atomic_write_unit_max_bytes - LBS bytes with RWF_ATOMIC flag - pwritev2 should fail - pass
+TEST 1 dm-mirror step 1 - Verify md sysfs atomic attributes matches - pass
+TEST 2 dm-mirror step 1 - Verify sysfs atomic attributes - pass
+TEST 3 dm-mirror step 1 - Verify md sysfs_atomic_write_max is equal to expected_atomic_write_max - pass
+TEST 4 dm-mirror step 1 - Verify sysfs atomic_write_unit_max_bytes =  expected_atomic_write_unit_max - pass
+TEST 5 dm-mirror step 1 - Verify sysfs atomic_write_unit_boundary_bytes = expected atomic_write_unit_boundary_bytes - pass
+TEST 6 dm-mirror step 1 - Verify statx stx_atomic_write_unit_min - pass
+TEST 7 dm-mirror step 1 - Verify statx stx_atomic_write_unit_max - pass
+TEST 8 dm-mirror step 1 - perform a pwritev2 with size of sysfs_atomic_unit_max_bytes with RWF_ATOMIC flag - pwritev2 should fail - pass
+pwrite: Invalid argument
+TEST 9 dm-mirror step 1 - perform a pwritev2 with size of sysfs_atomic_unit_max_bytes + LBS bytes with RWF_ATOMIC flag - pwritev2 should not be succesful - pass
+TEST 10 dm-mirror step 1 - perform a pwritev2 with size of sysfs_atomic_unit_min_bytes with RWF_ATOMIC flag - pwritev2 should fail - pass
+pwrite: Invalid argument
+TEST 11 dm-mirror step 1 - perform a pwritev2 with a size of sysfs_atomic_write_unit_max_bytes - LBS bytes with RWF_ATOMIC flag - pwritev2 should fail - pass
 Test complete
diff --git a/tests/md/003 b/tests/md/003
index b9b2075..83746ae 100755
--- a/tests/md/003
+++ b/tests/md/003
@@ -18,7 +18,7 @@ requires() {
 
 device_requires() {
 	_require_test_dev_is_nvme
-	_require_test_dev_size 5m
+	_require_test_dev_size 16m
 }
 
 test_device_array() {
diff --git a/tests/md/rc b/tests/md/rc
index 9f0472e..ba9013d 100644
--- a/tests/md/rc
+++ b/tests/md/rc
@@ -20,6 +20,7 @@ _stacked_atomic_test_requires() {
 	_have_driver raid1
 	_have_driver raid10
 	_have_driver dm-mod
+	_have_driver dm-mirror
 	_have_program vgcreate
 	_have_program lvm
 }
@@ -157,8 +158,7 @@ _md_atomics_test() {
 		raw_atomic_write_boundary=0;
 	fi
 
-
-	for personality in raid0 raid1 raid10 dm-linear dm-stripe; do
+	for personality in raid0 raid1 raid10 dm-linear dm-stripe dm-mirror; do
 		local step_limit
 		if [ "$personality" = raid0 ] || [ "$personality" = raid10 ] || \
 		    [ "$personality" = dm-stripe ]
@@ -227,7 +227,8 @@ _md_atomics_test() {
 				md_dev=$(readlink /dev/md/blktests_md | sed 's|\.\./||')
 			fi
 
-			if [ "$personality" = dm-linear ] || [ "$personality" = dm-stripe ]
+			if [ "$personality" = dm-linear ] || [ "$personality" = dm-stripe ] || \
+				[ "$personality" = dm-mirror ]
 			then
 				for i in "${MD_DEVICES[@]}"; do
 					pvremove --force /dev/"$i" 2> /dev/null 1>&2
@@ -266,6 +267,13 @@ _md_atomics_test() {
 				md_dev=$(readlink /dev/mapper/blktests_vg00-blktests_lv | sed 's|\.\./||')
 			fi
 
+			if [ "$personality" = dm-mirror ]
+			then
+				echo y | lvm lvcreate --type mirror -m3  -L 2M -n blktests_lv blktests_vg00 2> /dev/null 1>&2
+
+				md_dev=$(readlink /dev/mapper/blktests_vg00-blktests_lv | sed 's|\.\./||')
+			fi
+
 			md_dev_sysfs="/sys/devices/virtual/block/${md_dev}"
 
 			sysfs_logical_block_size=$(< "${md_dev_sysfs}"/queue/logical_block_size)
@@ -437,7 +445,8 @@ _md_atomics_test() {
 				done
 			fi
 
-			if [ "$personality" = dm-linear ] || [ "$personality" = dm-stripe ]
+			if [ "$personality" = dm-linear ] || [ "$personality" = dm-stripe ] || \
+				[ "$personality" = dm-mirror ]
 			then
 				lvremove --force  /dev/mapper/blktests_vg00-blktests_lv  2> /dev/null 1>&2
 				vgremove --force blktests_vg00 2> /dev/null 1>&2
-- 
2.43.5

