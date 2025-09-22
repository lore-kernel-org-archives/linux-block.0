Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58B6B2F9982
	for <linux-block@vger.kernel.org>; Mon, 22 Sep 2025 10:24:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758536692; cv=fail; b=g4PKHCC2qaQ2YTuyOOnpxFkuZ5LIl3SLcxH6WAHDkGsApgLRdWSBZPe1YBjxWUJzvv36dPtKYdniZhM15SvBMDzr4yte/CAG/OTOj7kUdq4IKRsDw+R64Yy/aRdLna2eLJyMyBvte8mDpgvceRioQmPiRfQB25iqNBV+61+SOvY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758536692; c=relaxed/simple;
	bh=vFeip+D7KFuy9acFdZg648BRewXnTLRH2OQ/mcun6AI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=GV+rcj/9gZnVhIPTJGTGNzOrrTuGovIKfe4i/cdqAGDt8avUc/4BiYoso/r/n+wKDgx5dew0V9SUE+XigIsrho59vaer/J6dnA5mZ98v+Qpew8t2GfEJJMv4giXTOe8PPEoIggo0/FIM1AbRV3ENgIfcWFi+QAnG9HBhvyXeBDA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=BXotixk0; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=hLfVLusI; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="BXotixk0";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="hLfVLusI"
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58M7NNr1030897;
	Mon, 22 Sep 2025 10:24:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=05QueE4eG4n4bxBYJCp1O3zkO/z0BW+bDvPG6GnwSlY=; b=
	BXotixk0ghRJIURDyV//IN/tnrpuN/k5qveaO2NI5MpMoO5jlCNrJjHCpp+hq/O2
	/9hQKtqKRefiYDLYPyJlgHHrd2kkXYKRQSHMNKzv/jq6UhyQd9PbpzyEXjDdBtz+
	iSxR6fql6FHc2Uo6St5YFB73oljxALC8cuZOxzqpIL2vm72vCjfn/qxI6jD8RVbL
	MGnE/qQFiisvPQCiRcFkt6pHbLCLBOu9U64X+T+9sYARRgz8CZDHA3r5ey9tVtuM
	6roYBCnhJ78DAB7DMymXwC7j5z6bDdSG4NHFfXrhto4vlu4KvxQH3vIoFEN+UYpr
	bytR7zyla1R+juhNTfsQ7Q==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 499mad24pq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 22 Sep 2025 10:24:49 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 58M8DYGm026123;
	Mon, 22 Sep 2025 10:24:48 GMT
Received: from bn8pr05cu002.outbound.protection.outlook.com (mail-eastus2azon11011033.outbound.protection.outlook.com [52.101.57.33])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 499jq6upjv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 22 Sep 2025 10:24:48 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ha5ekycACHPglMNSbJYZvJ1J+9urEP2vQTQ8d6PoLVdn8WnMkXugBza8CV8ovLoh8UyPnJtcSfR9cjWATmU8fg9JrOoT1Z14Er8NFAcc0V8GQZfnk71kdXA2Fs+i9ok6i/mUmn7O8mySUrxeLgvXGKFXIMUN82z7We39pC4FFLTt7i4W0y4SmOWZNAQ3t4h+NaizdbppPCsoJJr+YEGRM4v5XFfOpxUALqmWFsqTnBIFGUEOVtgXwH/j5jnXcuZBvJcsfH1M+0M475m2mZVIk0/eTtHuqYzUGQEL9jssx+OhH0RxDnI5JO6rmoiW/tFG9x3i39+9Rx1pOBq/tP27oA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=05QueE4eG4n4bxBYJCp1O3zkO/z0BW+bDvPG6GnwSlY=;
 b=ijjoZOlQfs/5hSqtMgH6S+dWHLCF00BxJC9ekH8zDdldjPPHhxWyCpFaBwmB2NaTMrgWzfB6smMvbLOH6Qt8IGkbWbjklaPh/njqWQSMvaO0tPTJ6njO0qhksVXOo6O8uM2sx1oIKt7QeqgYAt/v0hFaKkHEB9rSwnpq1EcNLtItxx3J6/U/ZYQaGFUZP9+E99g1qn1QDNoDipr1RTnu9cSVchOhqnnxu9HJUSWqceTuA6pXiTYZRTbCPCoLs4YV1gSPaFsOIaSSSW935zugkvCZUL+dmqYD/FtgSAIUqzNgBSEw9RT1LapK6/P5H4KAORBtmf90f1eIGB5iFN0HsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=05QueE4eG4n4bxBYJCp1O3zkO/z0BW+bDvPG6GnwSlY=;
 b=hLfVLusIGtyAne1rauPgGO71mzaDr/44wL2NBTwpNnj6Ujv2sx5j4nSRbgdcCBYiYoDuSggGno6iQoi2LuQ9QG+4VlSviC6XCbtC/Z89qtFX++yhN+FS3uoUaPeyhJ3PQ1php8DGprPoVuywUo9jhnYnbrZ12kw6n9hkB9m4FZw=
Received: from MN2PR10MB4320.namprd10.prod.outlook.com (2603:10b6:208:1d5::16)
 by CH2PR10MB4293.namprd10.prod.outlook.com (2603:10b6:610:7f::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.19; Mon, 22 Sep
 2025 10:24:45 +0000
Received: from MN2PR10MB4320.namprd10.prod.outlook.com
 ([fe80::42ec:1d58:8ba8:800c]) by MN2PR10MB4320.namprd10.prod.outlook.com
 ([fe80::42ec:1d58:8ba8:800c%5]) with mapi id 15.20.9137.012; Mon, 22 Sep 2025
 10:24:45 +0000
From: John Garry <john.g.garry@oracle.com>
To: linux-block@vger.kernel.org, shinichiro.kawasaki@wdc.com
Cc: John Garry <john.g.garry@oracle.com>
Subject: [PATCH blktests v2 2/9] nvme: relocate _nvme_requires and _require_nvme_test_img_size
Date: Mon, 22 Sep 2025 10:24:26 +0000
Message-ID: <20250922102433.1586402-3-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250922102433.1586402-1-john.g.garry@oracle.com>
References: <20250922102433.1586402-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PH7PR03CA0022.namprd03.prod.outlook.com
 (2603:10b6:510:339::6) To MN2PR10MB4320.namprd10.prod.outlook.com
 (2603:10b6:208:1d5::16)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR10MB4320:EE_|CH2PR10MB4293:EE_
X-MS-Office365-Filtering-Correlation-Id: 087f9fa0-6f27-4468-197a-08ddf9c2404c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?nEIV9MCGh53iPKpnd+rImoUJaRrh0K+qRObRYGXVTLldp+5eLaUfLZw3Lqvx?=
 =?us-ascii?Q?/wqP/I6Hi8Y2IP275ygKbxg4YwCvVTuUZOyGTWwq5sKzMq2TIEHextTgNNd0?=
 =?us-ascii?Q?MHLQWvyhLzPjss8VUZmDOwPDKttaHfonBt2W90NWcy3+5ToToDc8iS5N/Dd7?=
 =?us-ascii?Q?HzrKmG4sv8HG68Sc/mn+XNU5Odq49pVfqoCpxXdHISwV0jy6ufSd3CpHxtHB?=
 =?us-ascii?Q?AUk4C550ToSYasug6Vyqof4B8AJBOm85peCl6JVkfc/XBiUSVxw96AL30fEA?=
 =?us-ascii?Q?t1c9AJPPdxpGS9RKxIlD8uTepS0IBkC3dE3kCRTbQJMggf18W4xt3AKlp7S4?=
 =?us-ascii?Q?Rze0n9Zt7Ah5EEG1njpp/aWSGvYilblgunbBZuyTmuaSmjZUCStSZKmYzNEh?=
 =?us-ascii?Q?I7QLq48WZxYXTNp4nguHjEzJ3t/+qINRUJNHLmeJjmcD1UUpOgFm6KJdCu6B?=
 =?us-ascii?Q?jaupAjfBDrVcvqU5hJz9gcQe0U5jaO6XcTPWVFw/WQnLtub0Jl2jbrEguNFN?=
 =?us-ascii?Q?eW7+AwrsHJFtXHLxCZi0fLbAvWnIHJd0wmqu+uHn94Gh9OnhMKuY359J0ZCu?=
 =?us-ascii?Q?cNTYa/zNmo/l0PuvGUG9F3c5OfBBSRmEtE/8oRiqNrr5fhKIalmTjLcaQrSC?=
 =?us-ascii?Q?7BJrkg2ejiF3EipoYEr+X8Rz+JdMH92DqwOk6BddoufycTdOYwtSoBXwurUG?=
 =?us-ascii?Q?11hfVOrGKBuRokzEq4Gp1QS79YSHE2msMeSlFVWwH6NIBcWo/6ggwKDQp+qZ?=
 =?us-ascii?Q?hxK8VgsvBh0Ok0/bnJS/9BuehRxxDJHLUGzb9mxEH5NBCg4FwgH4X0ytrNPP?=
 =?us-ascii?Q?SzIOYLisu02bEqDVjpgwC4zJU4h/VdXJPdaClLpJCdckJagFFW8AtnlGDnjy?=
 =?us-ascii?Q?2n6Y0ekSdliJB24QVFkVN8wDcRWUdZVo/dg6qS1pyaePq2tvML7TxnR6VScu?=
 =?us-ascii?Q?lDVOSXUEQdSnSxxyu3L6JCZIRI5A+9DwqLTnY38IrEq766NAzRIr+Jrw+LvS?=
 =?us-ascii?Q?78kgZYBkuu1IQp5AyQ+jGfX8Y3JDb8a2g6owFOh9YFREagNsPWtrtlELoTBn?=
 =?us-ascii?Q?FgYyIJSx3qRtSVV8XUyn/VLetPc7hyeH7DOYIgwP/6meaRoMveOlgJ5nqjee?=
 =?us-ascii?Q?gHXfAmyNqJPiUQ9ieKbY81p4cFNaQtsiIS1akLFIQQFrMelmCxJ+94ilb00e?=
 =?us-ascii?Q?oVRowlYNfZAVKXkiYkzzTnKzhdlMaUp8LQXc9BRY0bY1G04Pd6rHrw5hr6n+?=
 =?us-ascii?Q?I+jG0FK0bO7sHO7sJGCfuk8eOg9NRLtSjOQgaJoFt4j05JV/8hKT69RZkeZf?=
 =?us-ascii?Q?ESQTixkHiiKNZThxOnm/W4VBPWRww+6XbLioPGxOhXpUKt5dJOL4AHO5gHP0?=
 =?us-ascii?Q?kq8D39htw8ds7MIzdr2AU2BSILaal3ZzIJp51FCCwfrYLfcDGHA0PZRTB1Vi?=
 =?us-ascii?Q?cvpnNMcXAe4=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4320.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?T7xjtcA0z6/hCOT84F7M2yJ1Dciqb+QUhFDAfmqFI+QF/WxPh1Cui1JF/OF0?=
 =?us-ascii?Q?NupxzbP10Iidi1ZS26i1BaB419UpxpnejpO8cimNgD1hvCCd0PjypKcG5jgv?=
 =?us-ascii?Q?oXZaZlJCjhxyG/rtzi9ONdz7lDk00GyIHWx/Zd7EH83F6qi6Wj5wQl8uVjkl?=
 =?us-ascii?Q?1rxV9/se3foanSsvcV89WSywywBA/Qu4rUnCaKn06VuG/YSCIM/5VVLmRX1c?=
 =?us-ascii?Q?tt6xQJW0z+cxOFvO0yvoK3QtbSaCL3sGNBatvHyUf85Es4LVEkqsMuvxYOx9?=
 =?us-ascii?Q?lhCJqnhPLnxiYMnrdgEcfFiUO+BUOvIbMflkT31EbZ4j1DVU4Vaf53ECf1Nd?=
 =?us-ascii?Q?CH/w0DI8NyktcoLuJFydA54qiQOlVsdPIRQhNviaGJ1XivYm5hwELmXWjpcz?=
 =?us-ascii?Q?8w7+DIz1/BRajNC3cX1rxK+TVuJGXloXR9zx3hPPPw2efa3T6zFzqhl5BAXv?=
 =?us-ascii?Q?1eV8zmaAGggWff5++Dea0XEVfhzbBEe0z0VyBdBcy+SeWt/+nKvuTNSLUhRu?=
 =?us-ascii?Q?0VLSt+onza8S/mAPcU+PG14YhdJnnfVMCefjcZVQNKIx8+1mRRo1PJRhVOAk?=
 =?us-ascii?Q?5SKzvLGPXl7sMeRH8BFvJCzuNMsJ1mwfXsznx+iHc71WF1LgT+RkKcuR7Ld/?=
 =?us-ascii?Q?2c2VlzE5SUZNX6sYnVAkRR1jDfoDfNh61OXVxoHjZqarYq38b09l/kzc/qBA?=
 =?us-ascii?Q?T6FVpwnX61Cg47UJdzPJ6LJtp0eBkGnZXAYazRUBmrJmWDWn81tuLEw2FgSg?=
 =?us-ascii?Q?crrEu2+sLqoN/JRGO/83+zGegsIw6cjfX2TAOmdad2yoGCXwSNOYa6fdS6Q2?=
 =?us-ascii?Q?lsVcfTwVGZgvr9JwNPt2MhvPRmif0GUYWC+FHfEH3EmeZRNUN+Ua3ndlkwqf?=
 =?us-ascii?Q?SnX6M/Bbcfp4lGYL8msAT7rgsYneS/qhZp7UFmjCX4Lr81eISqfYKESHtxFi?=
 =?us-ascii?Q?Jvg3QZGGcyjsawk6NISYycGouQUaVxzdNYpQEYR+gvrGPL9xgmyf5Cxj/ZAN?=
 =?us-ascii?Q?GCWBIACxD0sl6g0x25imil2cX7oe6SV3XQKSeJ6E3FOX1c9DmtF7paIzwk+R?=
 =?us-ascii?Q?ZAbWiBvwWV72ZtZmyDx7nQhOQtMZTZapxbEDVRC4Nl4pFOkdiUmiUbDYfNU1?=
 =?us-ascii?Q?FPIQ1O1R63Dg+vln82Nivio1aPxjkcvlLh1cH4fPwYemv8eX4dXua17NUoZC?=
 =?us-ascii?Q?n3lrZ/AHpUxPv7hr+XmNzAhKapbki5QManyARx/mA4quJkRk6Slf/3ehTTQy?=
 =?us-ascii?Q?pvwUtiFS4uXPI7zNMVRZX+pT3m3DqFv3hy9OBoBAL79s9kFuYksYOuGKDasc?=
 =?us-ascii?Q?DqjX6gVFxJlTxvMtxL8pfsqtNiCfdXlb3M/kQkI7oIcwN1D6GiEAkoEOTz8a?=
 =?us-ascii?Q?TzowRsWKRd8qdDXnGbpNMGy5xITE9rQ36Iil8nGqkycoLmVLPH/q2/IeOTXa?=
 =?us-ascii?Q?RyJYe1Xtf++FBmHm2I+PcS7/5CB3SEaeUkgzY3tKYIava9F9Zmg9glntnYQe?=
 =?us-ascii?Q?eTr5TUrpi6Y5RcFX44TzrmSmgte776Fq0+2yoYPHLplQPfyYj+F9p+H1x8Vz?=
 =?us-ascii?Q?UUCjktFaBcl8C5Brku/rX5AJ2qnSdNROd9SrNZQNQl1D4Hv6u41hc5huuxcr?=
 =?us-ascii?Q?mA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	YS466beqHS30CHiDMLgcMRFWQtW8NtITcaAi0mMudxnHxt0EhGic/pZR9xIxwcdXNtDVfE780IKe3KHs5Tl5JctjWXe2MtaA6C+8hc/F9REgJjKGsUr4YGfzowydHvZvw6yLS3L9zL/rJr8mLfwJNCbdKtTnCvWiqJc8sT2B4/Bv5T97Ce8NJwwL4ZRUqe5KsgrTPtQGhKRZ2BrZdNnrLVqYI0TyLxbcFixBBgngcLPrFs4Cx+jgj1LhgRLdszGb0lXAXFh0nCXtnsL1cxQWj1RuYoTOhbRDV7P8c7CffhtC2hkCT+QC3I4ikB/ijF4KjUDv25NO/mAXMScr1KnY9CvYvjil38wEPCVJXODS4XJ8rk0FItvFFA4JURgljsOlXOcpawPwRpFVf2vFzaxjmy88DKQWoc2eciPOjEVnBV1ic+stQXQ/QlIxpvj6PCZ5tNrLxja4sZPYH/oYNhZZOIpXfDFz+UWu/uwRealbS7zqbig7HJnF5I7ygsCE/WV5pOWybVQhk5E9BezewVvXr9aQeIXZCuhuma6SUnJ1Ph5MTKYwQ8vBUQkU/rfhsaRqsMpPcA4bPuXDlo52ojtI92lnjKa1cjjRO5onYbZfxc8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 087f9fa0-6f27-4468-197a-08ddf9c2404c
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4320.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2025 10:24:45.5866
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IHE8gZSHvcQxR9J4tX77rN0oiMlv1Oy47IUWrQelGz7f+zuCqiGymop/57Y/QQhB+I7kZUuOSSSD1i7c8L7DZA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR10MB4293
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-22_01,2025-09-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 bulkscore=0 mlxlogscore=999
 malwarescore=0 spamscore=0 adultscore=0 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2508110000
 definitions=main-2509220101
X-Proofpoint-ORIG-GUID: eWYNKhKc2BTtGn4FNDKalIzX5EgO7UEc
X-Proofpoint-GUID: eWYNKhKc2BTtGn4FNDKalIzX5EgO7UEc
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIwMDAyOSBTYWx0ZWRfX1l48tSgA6JmI
 Be6wvLKh6qB92c7v0Mv+7raLSPBpDziP8RE50/Gtoc5IwWzLvMa+usLGZJV3ehUFM68PZC13Tlc
 7Lk7mBseEkIC6Qd3kGbOqsQtog8buSTid3G7+ZAplOxtS90FY9Y16ukt8mP5mYmU+LYOyoeAHld
 K0YlnoKRvUpzbLwA4ZcJ8JjFsgp8q4bGRqVLeiokcA9UTJ0jEEHqPP6t5IcKdybX43nnTyZjTmO
 EkKHoher7M4kmeqvXtw/t3wSfSO4ERKzGpLnYCBomMZJjsOGnjF4dolN4fUsKPx2QUNf3ij3A+J
 B1PvZvvjd/ajfUdt15PYtAm+XQFqka2GC2TcnSLBdGDrZTe+I6nSYUM6NG+S0EWIVl/1YLbgGwi
 Mch3fr3j
X-Authority-Analysis: v=2.4 cv=Vfv3PEp9 c=1 sm=1 tr=0 ts=68d123f1 cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=yJojWOMRYYMA:10
 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=7LHRemu1fIr-7oFre8oA:9

Helper _nvme_requires will be required for md atomics NVMe testing, so
relocate to a common file.

Helper _require_nvme_test_img_size is referenced by _nvme_requires, so
relocate that as well.

Signed-off-by: John Garry <john.g.garry@oracle.com>
---
 common/nvme   | 72 +++++++++++++++++++++++++++++++++++++++++++++++++++
 tests/nvme/rc | 72 ---------------------------------------------------
 2 files changed, 72 insertions(+), 72 deletions(-)

diff --git a/common/nvme b/common/nvme
index 8de41fa..26b3b97 100644
--- a/common/nvme
+++ b/common/nvme
@@ -1102,3 +1102,75 @@ _nvmet_target_cleanup() {
 		_cleanup_blkdev
 	fi
 }
+
+_require_nvme_test_img_size() {
+	local require_sz_mb
+	local nvme_img_size_mb
+
+	require_sz_mb="$(convert_to_mb "$1")"
+	nvme_img_size_mb="$(convert_to_mb "${NVME_IMG_SIZE}")"
+
+	if ((nvme_img_size_mb < require_sz_mb)); then
+		SKIP_REASONS+=("NVME_IMG_SIZE must be at least ${require_sz_mb}m")
+		return 1
+	fi
+	return 0
+}
+
+_nvme_requires() {
+	_require_nvme_test_img_size 4m
+	case ${nvme_trtype} in
+	loop)
+		_have_driver nvme-loop
+		_have_configfs
+		;;
+	pci)
+		_have_driver nvme
+		;;
+	tcp)
+		_have_driver nvme-tcp
+		_have_driver nvmet-tcp
+		_have_configfs
+		;;
+	rdma)
+		_have_driver nvme-rdma
+		_have_driver nvmet-rdma
+		_have_configfs
+		_have_program rdma
+		if [ -n "$USE_RXE" ]; then
+			_have_driver rdma_rxe
+		else
+			_have_driver siw
+		fi
+		;;
+	fc)
+		_have_driver nvme-fc
+		_have_driver nvme-fcloop
+		_have_configfs
+		def_adrfam="fc"
+		;;
+	esac
+
+	if [[ -n ${nvme_adrfam} ]]; then
+		case ${nvme_adrfam} in
+		ipv6)
+			def_traddr="::1"
+			def_adrfam="ipv6"
+			;;
+		ipv4)
+			;; # was already set
+		fc)
+			def_adrfam="fc"
+			;;
+		*)
+			# ignore for non ip transports
+			if [[ "${nvme_trtype}" == "tcp" ||
+			      "${nvme_trtype}" == "rdma" ]]; then
+				SKIP_REASONS+=("unsupported nvme_adrfam=${nvme_adrfam}")
+				return 1
+			fi
+		esac
+	fi
+
+	return 0
+}
diff --git a/tests/nvme/rc b/tests/nvme/rc
index 6d86ad4..33055ef 100644
--- a/tests/nvme/rc
+++ b/tests/nvme/rc
@@ -54,64 +54,6 @@ _set_nvmet_blkdev_type() {
 	COND_DESC="bd=${nvmet_blkdev_type}"
 }
 
-_nvme_requires() {
-	_require_nvme_test_img_size 4m
-	case ${nvme_trtype} in
-	loop)
-		_have_driver nvme-loop
-		_have_configfs
-		;;
-	pci)
-		_have_driver nvme
-		;;
-	tcp)
-		_have_driver nvme-tcp
-		_have_driver nvmet-tcp
-		_have_configfs
-		;;
-	rdma)
-		_have_driver nvme-rdma
-		_have_driver nvmet-rdma
-		_have_configfs
-		_have_program rdma
-		if [ -n "$USE_RXE" ]; then
-			_have_driver rdma_rxe
-		else
-			_have_driver siw
-		fi
-		;;
-	fc)
-		_have_driver nvme-fc
-		_have_driver nvme-fcloop
-		_have_configfs
-		def_adrfam="fc"
-		;;
-	esac
-
-	if [[ -n ${nvme_adrfam} ]]; then
-		case ${nvme_adrfam} in
-		ipv6)
-			def_traddr="::1"
-			def_adrfam="ipv6"
-			;;
-		ipv4)
-			;; # was already set
-		fc)
-			def_adrfam="fc"
-			;;
-		*)
-			# ignore for non ip transports
-			if [[ "${nvme_trtype}" == "tcp" ||
-			      "${nvme_trtype}" == "rdma" ]]; then
-				SKIP_REASONS+=("unsupported nvme_adrfam=${nvme_adrfam}")
-				return 1
-			fi
-		esac
-	fi
-
-	return 0
-}
-
 group_setup() {
 	if [[ -n "${nvme_target_control}" ]]; then
 		NVMET_TRTYPES="$(${nvme_target_control} config --show-trtype)"
@@ -186,20 +128,6 @@ _test_dev_disables_extended_lba() {
 	return 0
 }
 
-_require_nvme_test_img_size() {
-	local require_sz_mb
-	local nvme_img_size_mb
-
-	require_sz_mb="$(convert_to_mb "$1")"
-	nvme_img_size_mb="$(convert_to_mb "${NVME_IMG_SIZE}")"
-
-	if ((nvme_img_size_mb < require_sz_mb)); then
-		SKIP_REASONS+=("NVME_IMG_SIZE must be at least ${require_sz_mb}m")
-		return 1
-	fi
-	return 0
-}
-
 _require_nvme_cli_auth() {
 	if ! nvme gen-dhchap-key --nqn nvmf-test-subsys > /dev/null 2>&1 ; then
 		SKIP_REASONS+=("nvme gen-dhchap-key command missing")
-- 
2.43.5

