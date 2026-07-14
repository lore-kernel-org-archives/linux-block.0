Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF3CC363C60
	for <linux-block@vger.kernel.org>; Tue, 14 Jul 2026 11:25:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784028340; cv=fail; b=tfQRPTNIgBUHf9aJp7jltHlQYVYcvkqF0oyIfaKF2b10llYUi35OfhHG+kGRxOYD7Dge/wt6YN/j5GLCQb4X2awEyZocfwdydUJItOjUo9QTDi5G472N5S1IF5QlEsZBMKQziRlGiyqpAdzngJT10Hv4Nx5shuykr9hJgpI94n4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784028340; c=relaxed/simple;
	bh=x51aC2t5ku2USd0BdVCWZQKuxy5htMv4dKjqHPOBe/Q=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=jZex0hSivUnFnLKotzFYHjMn0IAL62YTe+RWRHJW66HyvexCVaxT4ILvoEcU007o8V1pyhHaxClfZpkaN4OoHBMDAbieP1BB/PabW6TAtWbRHlDcKIRqltZK6qhZrXbMNvORN8nEnCij5bzN66Vmb6P4/usG4DbolpsjI5kcF7Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=YlcW8SRS; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=oT8EUAu5; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="YlcW8SRS";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="oT8EUAu5"
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66E8UX40010421;
	Tue, 14 Jul 2026 11:25:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=corp-2025-04-25; bh=iFLL6PcXjD9stX2C
	9a4jTu3G/t7aoJfnr9ELdumB8gQ=; b=YlcW8SRS19q27lSq/rq2fEBI457TL+wL
	/JN4ZW489EMbM0qAvY0ZgTuuEexr9GVu8O0TipARCEmYcpKhlxIW1FJLk35TSixc
	D4PAxGScrgEtiXh79XyUpIIkuWXt9thYgT/vGvvo0frPImhTbkTKu70QLQtxJCE6
	XRMzOchFdXjaxi57Z6Stbfr74Lco9IPR1Ib7zinBJ+2SFlROqoLpWHSSe2TIKftX
	YlXnu/QvhRZDC+5DbEy9HioLnbdQ5Rg9ddu8D/yJzpPs7oXgG5jWEVamiFMOc2js
	r8p8Esk0PvtaYmk91XKQrp8O2pM/eAf7bTFQ9cSEIVcQzRQfPqyXxg==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4fdhn086dm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 14 Jul 2026 11:25:28 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 66EBI90L020309;
	Tue, 14 Jul 2026 11:25:27 GMT
Received: from ph0pr06cu001.outbound.protection.outlook.com (mail-westus3azon11011018.outbound.protection.outlook.com [40.107.208.18])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4fbc9e2ajf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 14 Jul 2026 11:25:27 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Xauj9a+7W44uq3U40wXi5JhWVV97ZZ2LaFSSY4QWozR3skSKOh2uY4T2UszD6lmu0EN342YAsQlCyj+igx4EGWc4BEkBs3pLHZGNf1l6msdmvKGRhE8VaPtXcw6QeTq3T0EDRrPq3WfyFyNOz5T256aIatwEonZ1l/hMVzDhAbblOi8YTG8fTGYjIdITUeKArt2xUGQHoPbinq9/6g5LbcCuYmzXpiw5VpEogrjbX2UlA+7GDrgW2ni8oc8silLy47GQa4ziUnFU+TU5aaIBBauWrqbbrst3edVHqHsvRWL5sPKa/g3y2VFBO4xKJQZ+zQHVXEKArlAd1lkh0ZPcsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iFLL6PcXjD9stX2C9a4jTu3G/t7aoJfnr9ELdumB8gQ=;
 b=ZJxU99N6XLSVZZ7e7ZN3cbHw5g8f6Ojt3RjkUMaQwqgt5VcvVkG+X4hl/nF5rOiDVu40b9IlqpMmTUzjsSz2rsgKyhjEjsTBq20zdYipJinfJyvwvAmtlzXo68ZAebdKZnmWfibr8olc23M11fWckwDB1XNlXFaHqUWTDiEu9b8CwxbZRMAjGFONVwIRilPbZuWKNGtapPmfoFGm3CzkFI/3E1OBtOHZ/BAkFwpTLq/5+xpAZATtz6yBAhL3DFvwx/uA1Bj1ojPYoyCCGfZ5OTrr/w2vhRvd9SXdmR7+BBZ6EqIQ0N4bGhvTcNitzg0DjRDIz/Ge7YWdiTpFY1r6Mg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iFLL6PcXjD9stX2C9a4jTu3G/t7aoJfnr9ELdumB8gQ=;
 b=oT8EUAu5j4mGzL0kryLDiyD6US14xIqzyY3nyaoxa6XwfNv6PKlJZbtdiPe/ObcNRVTu3fboT9wO8yItGLEYA1Ec2RKJQq19RE6ThpoxKChWAzZW2Ooeg5Uylf2AYdCoLfeNmyz53uRBuyx+jNYoaAtLcOLLa6tTD9vAMi+54F0=
Received: from DM4PR10MB6229.namprd10.prod.outlook.com (2603:10b6:8:8c::12) by
 SA1PR10MB6367.namprd10.prod.outlook.com (2603:10b6:806:257::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.223.10; Tue, 14 Jul 2026 11:25:23 +0000
Received: from DM4PR10MB6229.namprd10.prod.outlook.com
 ([fe80::867:63e7:13fa:fa7d]) by DM4PR10MB6229.namprd10.prod.outlook.com
 ([fe80::867:63e7:13fa:fa7d%6]) with mapi id 15.21.0202.018; Tue, 14 Jul 2026
 11:25:23 +0000
From: John Garry <john.g.garry@oracle.com>
To: shinichiro.kawasaki@wdc.com, linux-block@vger.kernel.org
Cc: hch@lst.de, linux-nvme@lists.infradead.org,
        John Garry <john.garry@linux.dev>,
        John Garry <john.g.garry@oracle.com>
Subject: [PATCH v2] nvme/069: add a test for multipath cdev lifetime
Date: Tue, 14 Jul 2026 11:25:18 +0000
Message-ID: <20260714112518.3395603-1-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.43.7
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CH0PR07CA0019.namprd07.prod.outlook.com
 (2603:10b6:610:32::24) To DM4PR10MB6229.namprd10.prod.outlook.com
 (2603:10b6:8:8c::12)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB6229:EE_|SA1PR10MB6367:EE_
X-MS-Office365-Filtering-Correlation-Id: 5762454c-34fa-4b39-d873-08dee19a985d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|23010399003|1800799024|56012099006|6133799003|18002099003;
X-Microsoft-Antispam-Message-Info:
	DleVjA0w/whXyTe6OAi1fEONtwAy95dsL+NUIrwEylsMdw9yHTS8wciv1JIodhAbICiIXZQbbnx2tT9p3CBl5B9l5QDGfKPy2OG51SH6/Dceoz0OLfMxiXOYuMA8tZS7U6rUx1XhL85et0xZIqwvAXzKMqcaNTt19uC4HEvU2f23f4npINwMJuvl+sJQaKsCH5OAD87cYZfBn1BgLqg0yH6Qvo4Wp+sI2ck8n38whUXuy+HjrAbPB4hPkyWL/5MqEjXwF2sZzXXGwRx+epPOq5iAZcixggpXhBimTs46mSkzBR3zhrhX0zRT1Fwd0hkwYpkVXJPDjI3NkjDtfad8a2PhHa95fenuHqZuKViXQdDmA9kGqpt8lxEETX/uPcs5Kc2iVQ9Tj2Qt4yi6Lk4RIECbA+H0zWP2+3zB46vU9cEdVELhUShzazAsSfkxRaz0023O6DlVPYLXfrzREKm58e+9J+7lUhHdg5OkrFhzZAV7uMQenBADHGsD71eNb3HvDxoTu4ChXuNWZoA5tSr3BH8LoLSatJUJ1dHYYZS+tspQbsji9trS2NeWlX3/3YpmP2O4jxbew8DBqfKqff1WxJ4O83Nu/jdQaRGNcqXVpAcD99uNQVOP9aphZ7TvDvJL
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB6229.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(23010399003)(1800799024)(56012099006)(6133799003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?FzSO6TT94CTbw3/581BbMgAqqcvcJcHNKV6sSYPK4psYMFgLThD33DJy+dMF?=
 =?us-ascii?Q?/NowPwa9uyHmTZEyt0IV3KxFNu59pApQ2ezv+awQe0J9MD/Sf0eYT1NBgnHH?=
 =?us-ascii?Q?CqC05g0bDX8BeiVaZmetqJDftPllD3A01Onw84ojfTFGw4xI6tc2TP6BrDRt?=
 =?us-ascii?Q?LVp86aJWrORifiU376gNPbVgOzs/M/und2i3IkE4wk7yYp7RqdYh8c3BE9YM?=
 =?us-ascii?Q?gTeV+13t8I5YBcoxwOdvJUFMZjC0eOtIStTnoqX86+EiQWWAQwDjx3Z9XYmB?=
 =?us-ascii?Q?7RsLLbP8H/ee05uxb7NSiTBUBmxGsXAMgALKHnVR7nGcBMvSeWda0WAFWUXV?=
 =?us-ascii?Q?3WXGD+cWtKks0E/Ab4diXKGLkFHYzFD1BTJvaKVdyYU4LvtQvPQZ3+ocVlWT?=
 =?us-ascii?Q?ZShpXGs2j0zwUeyp7ulDUqqW8c/jhIJFjfa9Eligmtni5tQEQ2GGBZ0RR5gF?=
 =?us-ascii?Q?Cj1qdClGbXoMyQXztg9cVNqzTLt/oSX3VsdbLWki5lBsFaeZ4mDG+Z2xU0NX?=
 =?us-ascii?Q?zKWtjeDBtZErnhU5XcHagDMTsmdxrnpRtWXfRFN6Pn/nt2TPgwsJ0yDXw52t?=
 =?us-ascii?Q?RVPuVPC1rhbSd19QdULERpEUrgYrkwvM75pQw4anyovSMEIkRz+TfM+d6tAp?=
 =?us-ascii?Q?WuuKFaggNpTGGIXYryrV7PQ7aUxnB7hqz8eTkVjHp5JNiPUh9DygnKzQ6bsS?=
 =?us-ascii?Q?cwDxz+esU+TUukabN4S2O7JHCJ9ml363N6HxSliUh6tbEimZr/BmzB88Lw8D?=
 =?us-ascii?Q?XWQyElopTMyb1eu8S8HzOLOpru+mOILhX0QM9YhXn1jiSSPemzhBo7hMz+pi?=
 =?us-ascii?Q?hW+RlezxCTNyq7zid1rzr2ZJF4hMYDSoEQIgUn/umn6aKIhv0EdbgwZ6roNb?=
 =?us-ascii?Q?A/Mok+yMxSY8ucFBpNhINaAJOWxKgXH9VJX5yKDuGjPVRQagklGAj5UymjwP?=
 =?us-ascii?Q?iF0pw2nA2h05c6Ll1pKg8zBxiYhP+Ri//MQWLE5oecehaf5ZFtAyyXCmOfJJ?=
 =?us-ascii?Q?YGoHHDaWt30X4aAm0NSU0osTmYplqt79O0xNF/eG4ZwJD0wuTH2FAmUSLGQk?=
 =?us-ascii?Q?qEI8C1tOGBwEgJNCKPRI+fVmDZgzqxbmqyyU+FStxK7MwyxKw05kjyII8jYC?=
 =?us-ascii?Q?XQBwMJMFASmQiqGEbNmDsJZvXHCDdulVn4Fx1bl2RQKJ51vwxghq+yfsPgNc?=
 =?us-ascii?Q?YsclqYaHJ8W2Zw8SR3KhNLPYVeeMlhStzWAonU80qG2X2s7yV4tD9AM48OoT?=
 =?us-ascii?Q?TF9/bwap2yHCJPGlqoMju2YEX4lhq++DnSrmO2JpqjaSgSrg5KGPBYNbB5g6?=
 =?us-ascii?Q?9MBUKOmJbDmCxcuIMC2QEk70yp0EslQm5tXqP7n/pmV3op24P6BEh6hPyBuo?=
 =?us-ascii?Q?T+oXMySJXsVOzaZfjkrqzJMJT4ipyhQCW3vtPmFpIgh3mwUWIJu7EHrOGGPo?=
 =?us-ascii?Q?Q2ureHNTtjUQ2NFjMjgi/xE3VdKHa8h5Cld7D5m0Yj7aXEk0EZPx3P/BlLJO?=
 =?us-ascii?Q?bm/lFRm1UEV8ik9Sp65Dy8Nnmku57BOG0WKSE/XG0eX6W01hiD5OV5Dh4anq?=
 =?us-ascii?Q?hwMVB7T2K/IK5WOO56B2Qmz/wetM6Y/47B+QudavjkV2++ppswJ4i6soahYx?=
 =?us-ascii?Q?BKAvl/INPmJq2R/gcgoEZRHaZlrRh7bbx9DPK6PV63pAuVBF6Xn3XNv+vUrf?=
 =?us-ascii?Q?7pix0QukNuowAZO2oNWgBXMtsUZ0asQSswizEJESV9hUfWBJS2IYZFo0IJGN?=
 =?us-ascii?Q?j1ABnIAxPQ=3D=3D?=
X-Exchange-RoutingPolicyChecked:
	iP/ESa3O1dHCca0PFZmfXg3/oahSA1BaeZYK50G17ccJlmHUjgF3sdJiX1krrtu2WCjIiGBzqwN1S4X0TueMqZliB2xDDRn1a2KbyyJxbNiL/ptGc1QThnfrXSdr+lkmKFo6qgCvvlh/2aPNwJGo8sski7AO1E0ZIGnzsBfgoLVpuR/JpxqQ10lW5+eX8ud643R8T1kvokOQS+PGzGShE2lKroWE6LiKvu2cgKgphfTHyNmCGmgcmE4M8LIirwM+NbnAi3VqfqVeMOLFbJtcwhah2F3DLVmsRnL9NmxahbN76W9B1p81zzVCIR/NKYiwqXAtsXENMmPghyVHq9OEfA==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	NSay5F50zY/bTFpTs6s79IThFs8H5acnnjNyNpLM9vk85EPsiIlkUAUlVcTbwysrADgbczTHWYOrVHSnQAW2vglkAPhIzblrM+wl+6taBGS53H8/NstfZc6y1fWfsY5fqrPxw3DCXqs5vdxfRYE8mRPFtFnI2aFD6QGJJ0B0w/lSgfqzbAwVgkkZltkGal+Ti1ZZJntl+lQLvtzYdK0iKBUHNjZ4CWI017jIv8zXVGyGiw4d06Yfa6kiRtBTe+1bUZGd1zRXs1AAbh8Fy/R3p7UjB+Vf6CgMMQ0vnFbBw9uhjdvoM/JBNOqyan+1H/Ubpe4+/NbJm1MagQZGMV+mNRKz6qD6Aa+mdrXVXmsQeMjf/FGa0Xid++6F45t2z/X4DuOPdDjPxO+fWthA2Bksg0ofGiJuAOwMhc05YiMmsoB2flZ/nyy4B2edeoFhBSiDMP3a/hX2eHQiYNmjWVc0IgO8VZL8RVeu1KKsKoBOxk0+7b7xD7HL0R4x738VPHh9opR9GOA4jzQ0ATJ1pWmDNGJke9kOLSDE2KI4I0jBexhTYl39r8igZQyy5CTIRoHh/hEAmztJD2iIeYCOUtIDHwYsuFMYUMMpghjp5NrgY+Y=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5762454c-34fa-4b39-d873-08dee19a985d
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB6229.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2026 11:25:23.3662
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +WR/Oy3RC+uTTZX2d71vYgvPWuraEoBAbmAle0qplB0pfONuswILZWXHbA9KZrUYQ+L/hCpDRs+4HWjVw6S7nA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB6367
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-14_02,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 lowpriorityscore=0 mlxscore=0 adultscore=0 spamscore=0 mlxlogscore=999
 malwarescore=0 suspectscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2606160000 definitions=main-2607140117
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE0MDExOCBTYWx0ZWRfX7HcsKoD8Roqw
 gWL9F0Qvg8vLCOytobzmDRtJtqDldod4vs7bWhq4Oqr14K15fLNvr0KP8bliHEgvJQcZIGchDPN
 xVdHpY6dbyO76fPwptkZKHdhcqw8pPmh11PWmNl0XEP8PxYyyz1J
X-Proofpoint-GUID: Z1BGNEXbWmYreN_MWN8b_OfbvjJAmiOy
X-Authority-Analysis: v=2.4 cv=ddewG3Xe c=1 sm=1 tr=0 ts=6a561ca8 cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=RAioF0-LDSMA:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=BqU2WV_vvsyTyxaotp0D:22 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8
 a=QOYSxItt2YxLaTtbhTcA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE0MDExOCBTYWx0ZWRfX+lJsMDkEOwuh
 Rpe4vU/RuUmsmVQRNJJQyeK0PRIkAVI9A3oPiACALwXfxPx6Z6xjXHc5lpqxSeJkID5UWV+8EZZ
 /lSZzUj705hVot8IkZYcvuQTiuMVetmWSAhLheeuWjaukNF47ddpZ8Bk2w8C+yDdgtwY0fWvBo9
 r5OobU2bQ2HGuSSljyBQNJfR/FK1Gc6iMqEMlSvoICM6rikq0J3iGm0EbhafHan/UoRdc+nVCPT
 YTC39ZdhagVE0fcUD80VGg7TgScLoDC9MgpP5/2qnF4rCpdbbDje1snn+4dpWO+54ElZGScvAOM
 l7Q/7kM7/QivocMihPHUE50vjWPk/TcVM9NrebDjR9EBfDSvcTH8mSvVZg+5w4Cl1ESfNhPQDeC
 lFCXs8RgLP55VpqYMWzvXVq3xLyIjElI5BPS7S5ykZNQyS6lLuNLLkPvdSMDdGcb9z/n1cFr+gv
 AcXMpslcJfB6SGkpKZQ==
X-Proofpoint-ORIG-GUID: Z1BGNEXbWmYreN_MWN8b_OfbvjJAmiOy

From: John Garry <john.garry@linux.dev>

In [0], a fix was proposed for the NS and NS head (multipath) cdev
lifetime.

The issue was that fds for the nvme-generic cdev may exist after we tear
down the nvme-subsystem. Issuing an ioctl on that cdev may expose a
use-after-free.

This test recreates the method described in [0] to expose this issue
for NS head cdev.

First a fd is created by opening the nvme-generic cdev. Next we tear down
the nvme-subsystem. Finally we try to issue an ioctl on the cdev - without
the kernel fix in [0], this should trigger a KASAN warn.

[0] https://lore.kernel.org/linux-nvme/20260713104238.3034640-1-john.g.garry@oracle.com/T/#me118851584fbcbb960795d0f04e2262e5a295613

Signed-off-by: John Garry <john.g.garry@oracle.com>
---
Difference to v1:
- improve shell script formatting

diff --git a/common/nvme b/common/nvme
index 15e9c3f..902a33f 100644
--- a/common/nvme
+++ b/common/nvme
@@ -300,6 +300,26 @@ _nvme_wait_subsys_removed() {
 	done
 }
 
+_nvme_find_subsys_nvme_generic() {
+	local subsysnqn="$def_subsysnqn"
+
+	for subsyspath in /sys/class/nvme-subsystem/*; do
+		_subsysnqn=$(cat "${subsyspath}/subsysnqn" 2> /dev/null)
+		if [ "$subsysnqn" == "$_subsysnqn" ]; then
+			subsyspathbase="$(basename "$subsyspath")"
+			for nvmegeneric in /sys/class/nvme-generic/*; do
+				nvmegenericbase="$(basename "$nvmegeneric")"
+				devicelink="$(readlink "$nvmegeneric/device")"
+				if [[ "$devicelink" =~ $subsyspathbase ]]; then
+					echo "$nvmegenericbase"
+					break
+				fi
+			done
+			break
+		fi
+	done
+}
+
 _nvme_connect_subsys() {
 	local subsysnqn="$def_subsysnqn"
 	local hostnqn="$def_hostnqn"
diff --git a/src/.gitignore b/src/.gitignore
index 988d785..af9ebf6 100644
--- a/src/.gitignore
+++ b/src/.gitignore
@@ -14,3 +14,4 @@
 /nvme-passthrough-meta
 /ioctl-lbmd-query
 /nvme-passthru-admin-uring
+/nvme-delay-ioctl
diff --git a/src/Makefile b/src/Makefile
index d75daf1..4779ffd 100644
--- a/src/Makefile
+++ b/src/Makefile
@@ -18,6 +18,7 @@ C_TARGETS := \
 	loop_change_fd \
 	loop_get_status_null \
 	mount_clear_sock \
+	nvme-delay-ioctl \
 	nvme-passthrough-meta \
 	ioctl-lbmd-query \
 	nbdsetsize \
diff --git a/src/nvme-delay-ioctl.c b/src/nvme-delay-ioctl.c
new file mode 100644
index 0000000..8699afa
--- /dev/null
+++ b/src/nvme-delay-ioctl.c
@@ -0,0 +1,67 @@
+// SPDX-License-Identifier: GPL-3.0+
+
+/*
+ * Simple test to issue an ioctl some time after opening a cdev.
+ * This is to test lifetime of cdev, and whether we can handle
+ * removing the cdev while we have active fds.
+ */
+#define _GNU_SOURCE
+#include <dirent.h>
+#include <errno.h>
+#include <fcntl.h>
+#include <stdint.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <unistd.h>
+
+#include <inttypes.h>
+#include <sys/ioctl.h>
+#include <linux/types.h>
+
+#ifndef _LINUX_NVME_IOCTL_H
+#define _LINUX_NVME_IOCTL_H
+#define NVME_IOCTL_ID		_IO('N', 0x40)
+#endif /* _UAPI_LINUX_NVME_IOCTL_H */
+
+int main(int argc, char **argv)
+{
+	int fd, fd1;
+	int count;
+
+	int delay_seconds = 2;
+
+	if (argc < 2) {
+		fprintf(stderr, "usage: %s /dev/ngXnX", argv[0]);
+		return EINVAL;
+	}
+
+	fd = open(argv[1], O_RDONLY);
+	if (fd < 0)
+		return fd;
+
+	/*
+	 * Steps:
+	 * a. Try to open device until disallowed/gone
+	 * b. sleep to allow nvme-subsystem be torn down
+	 * c. issue the ioctl on original fd
+	 */
+	count = 0;
+	for (;;) {
+		fd1 = open(argv[1], O_RDONLY);
+		usleep(500000);
+		if (fd1 < 0)
+			break;
+		close(fd1);
+		count++;
+		if (count > 10) {
+			fprintf(stderr, "%s still present", argv[0]);
+			return EINVAL;
+		}
+	}
+	sleep(delay_seconds);
+	ioctl(fd, NVME_IOCTL_ID);
+	close(fd);
+
+	return 0;
+}
diff --git a/tests/nvme/069 b/tests/nvme/069
new file mode 100755
index 0000000..46c3e5a
--- /dev/null
+++ b/tests/nvme/069
@@ -0,0 +1,49 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-3.0+
+# Copyright (C) 2026 John Garry
+#
+# Test NVMe multipath nvme-generic cdev lifetime behaves as expected.
+
+. tests/nvme/rc
+
+DESCRIPTION="NVMe multipath cdev lifetime test"
+CHECK_DMESG=1
+
+requires() {
+	_nvme_requires
+	_have_loop
+	_have_module_param_value nvme_core multipath Y
+	_require_nvme_trtype_is_fabrics
+	_have_kernel_options KASAN
+}
+
+set_conditions() {
+	_set_nvme_trtype "$@"
+}
+
+test() {
+	echo "Running ${TEST_NAME}"
+
+	_setup_nvmet
+
+	local nvmedev
+	_nvmet_target_setup
+
+	_nvme_connect_subsys
+
+	nvmedev=$(_find_nvme_dev "${def_subsysnqn}")
+
+	nvmegeneric=$(_nvme_find_subsys_nvme_generic)
+
+	# nvme-delay-ioctl will open the nvme-generic cdev, sleep, and then
+	# issue an ioctl.
+	# We tear down the nvme-subsystem in the foreground so we can catch
+	# if the ioctl triggers a use-after-free KASAN warn.
+	src/nvme-delay-ioctl "/dev/$nvmegeneric" &
+	sleep 0.5
+	_nvme_disconnect_ctrl "${nvmedev}"
+	_nvmet_target_cleanup
+	wait < <(jobs -p)
+
+	echo "Test complete"
+}
diff --git a/tests/nvme/069.out b/tests/nvme/069.out
new file mode 100644
index 0000000..cd2e1fd
--- /dev/null
+++ b/tests/nvme/069.out
@@ -0,0 +1,2 @@
+Running nvme/069
+Test complete
-- 
2.43.7

