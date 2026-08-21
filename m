Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F3AB3CF21D
	for <linux-block@vger.kernel.org>; Fri, 21 Aug 2026 08:49:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787302144; cv=fail; b=UUCCpNgsG4ECDrVELTSWrQvuiV/9WSg+Mka+w2QvyYe2glyzea+jjGfuVM9busyId3Yr27XYGpBKQU2gAVSOXbcgGPrxBAobDEktQY9GxDFj8H5d5hhDV88u+XTRdcZnoWrR+jppaTBWZXIOnODysSplGOUYnsJmWUSI/yYalaE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787302144; c=relaxed/simple;
	bh=io4TDV4PIyKQA3Yxv7sEr/ZbsmLkz2Is/hw2b7WZEQI=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=l0i+4W4DQb25YDCHUhlw7hTDNyY/LqdcKBZPyNYKdfluP3pRuf9kIdvu+bnSsxUJ3wyoIFlZ5CRNjv6cy89OJX731dBugXLGLwhGZ2qSHVRYRWoucLtR8mJPtiB5pv0t+QOFGpD4XpUHimSwhAMKrM861qS5xf+v5geKnrbmHBE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=k6TFOBA2; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=UyI3bKHw; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="k6TFOBA2";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="UyI3bKHw"
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67L0i2O8009454;
	Fri, 21 Aug 2026 08:48:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=corp-2025-04-25; bh=LWtcC5cknRJRkjOJ
	kG6Am8aubluWMC3ISQJXuP84m9s=; b=k6TFOBA25skj3vHtL+DK2Kd42sbpufTB
	FaAskzIgD3hiykPy29U2VOkcMtU7dSZdlg22glqlJeDQ8fM+gWl00cxOULuejahX
	VdpbSp3fGCuQ/XMIhPT9tqlPgapudosNjwEe4tKcNyHb/AzfjcMZLh2K+mTipgIA
	5rJb9bBbyWRQLF7wdS9/i5HvpJCI3NgDk2qYfwO3HHLdLv6kuxMbFg8rM/cqiH62
	xE2abSIsZ7D+odO2O4sd+8dZ5IPjBDc1QX7NCfudw5zKvp2TjR/XjtnlR9U5WMgd
	Qgg/40mMpT4BiHMnIGhMJEAtuR9KFDJhQhRyyJFAzjzjLs9qgIm7+w==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4g4yd9vqss-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 21 Aug 2026 08:48:45 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 67L8eans012644;
	Fri, 21 Aug 2026 08:48:45 GMT
Received: from ph0pr06cu001.outbound.protection.outlook.com (mail-westus3azon11011054.outbound.protection.outlook.com [40.107.208.54])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4g2eju6vmf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 21 Aug 2026 08:48:45 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XoFyGsQNFC+re9wRMcwQ0rMqC2hcffRz6FwVL9xqbAfOjjNlpACtgjtKr0233DWnxzLhzFy6uioEw1bUkRN2mWTcWZ0x4NYZPrcTWsoh7g6nTLUutSiDlsqScZoofVtIWiy1l/7EWi+9XHHZORXZx/Wmx0uiURKqQ/QPoOaf0oGmKecpsOn+KW3cLu28QukJy0UufdychvzqrWxDKKYcs/XWkiJEPbwLl3JQW336y8tg5s5mkheG5y9PL247PYud4krpwFKa23kZ4Bbbc0pZZTuSqClWrp5nwtl2Pu+kcceE1jh9t/z5QkmSCP+ExfPmul+HbZUxwZTKicRh7wvgxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LWtcC5cknRJRkjOJkG6Am8aubluWMC3ISQJXuP84m9s=;
 b=v5lgr4L2rBYQ+X3+BxKkFp2p53NabO5g9kmEdUqwS5hV0ABlgBw/PUyfAFVPbS0dagMhmTp734692errXiJ5W53DAV0S9hVKdpE9+QvIJpT0obRV3oNWytKY0XcDlhLtcXy3paF4ifOV85owJCzcTl5HAp8rfIBZa6/x7SwNzkNfQCP06W+Mj1AMtW8sizdrduUni7DfHzrTr9Hk2yNdXPFl0fxTehWtdOgi4xqmH+fWREMoYUhej2/qOaQtCvpkBIEWJKGdmN7ITReH3+Y9EiDduG7GBBZEfDUcDHb4o18UJH22ENs97PO8T6tEvFTTWNo4bRGKtNZyZFvWyAWoGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LWtcC5cknRJRkjOJkG6Am8aubluWMC3ISQJXuP84m9s=;
 b=UyI3bKHwyRa+Z9dDBWhgDi/0XyLm8i2X/RydTVz5NTtPQP7rD5DkDfQq4eE26JWIyBkNTvVAVVqMNO/R3w9yTJHrUWbrdIRte7Kya7iA3iYLn3ID2+TXBp8ZRAqrGZF0Oe7up3SubFxqO8hR1E/WyQoOjruV9cSAtoblh1Vd83Y=
Received: from DM4PR10MB6229.namprd10.prod.outlook.com (2603:10b6:8:8c::12) by
 DM3PPFAA42ED99C.namprd10.prod.outlook.com (2603:10b6:f:fc00::c41) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.9; Fri, 21 Aug
 2026 08:48:42 +0000
Received: from DM4PR10MB6229.namprd10.prod.outlook.com
 ([fe80::867:63e7:13fa:fa7d]) by DM4PR10MB6229.namprd10.prod.outlook.com
 ([fe80::867:63e7:13fa:fa7d%6]) with mapi id 15.21.0339.010; Fri, 21 Aug 2026
 08:48:42 +0000
From: John Garry <john.g.garry@oracle.com>
To: axboe@kernel.dk, kbusch@kernel.org, hch@lst.de, sagi@grimberg.me
Cc: linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
        John Garry <john.g.garry@oracle.com>
Subject: [PATCH RFC v3 0/3] fix NVMe multipath partition diskstats
Date: Fri, 21 Aug 2026 08:48:28 +0000
Message-ID: <20260821084831.4155943-1-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.43.7
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PH7P220CA0093.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:510:32d::16) To DM4PR10MB6229.namprd10.prod.outlook.com
 (2603:10b6:8:8c::12)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB6229:EE_|DM3PPFAA42ED99C:EE_
X-MS-Office365-Filtering-Correlation-Id: 013a9f43-5440-453e-a3d2-08deff610089
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|1800799024|23010399003|5023799004|18002099003|10067099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	ocWGw1mlAIFT4MOq+3x60urnG/dyibUyMWB3hoYQ4nnJFz67b31vVmWQraiMOUuiM4ogIf9vM69ThPUppWrxJcjQITvCtIDvJq6bjZ+tVJiS3o+uh9MR/kLPQilvBUld9bPrt6P09/6bl20oTpLXjYgkrwh/3CXpfvXbWYV5o7QE7Rtj++BJtsIEj8sh3j5BXhFBWC7gme6Ry0OIn1qHoke4hvjXYM3vTNZbmuolBCZCZ/kejU0HdL+oPjbLE/ONXekR+t+h6ORHBjaffAixEKdyeu6Xuz2zbnD6gtb+cHLQKI73Jv5F6MqC/df9KHM+ltRCtA3HHqnKDrrsnH8AB2A6jpo2L+S5Nj5ZAAyK8T0u+zeHT3HeZ7X6s9Kpt8Zeh7YNeY+hjMxg0oH2JPmAaN+5C4NJP4KwG73eyqzVxrxKg2TKsKDIYFmkEtkOjLYrGC4BZI9DIHdUtXGVEm99j0AEGJNEiQdgvm+58Dt1c/XtYOi+wblIJ1wCu510MT5rZwMevB3ePKieZV6ZvgsfWWZmRFKX8OmdDgoYpznfWRLV24b8e39RHBP8fkl0fGHjLbEIO0cWvv3Gvn6EMqAAf/jezFNC5KTpAeV89PPJG4X2Oz/dkKJdKpSpNWkZagxfZ3PeYSGCz2lnz8DrfPeBbehWihxovK5Dx0xCG4sEE6o=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB6229.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(23010399003)(5023799004)(18002099003)(10067099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?dDwtVDv/1XMggqs2af43g5mr5lq64X7Hz/QxfL/6ScI8D+0p3BFFuL29ZiUK?=
 =?us-ascii?Q?gtwPivBVl3/AIlJ15gUt1mvDmT4C+2EtYUe8Avj3aU1e35brd/R93l7Bntrg?=
 =?us-ascii?Q?UgFZpp1lA7YrrDVMU82oiqOHo6zTNJHJRyVbgmDOFSQRTjR2k3AJpID45zw4?=
 =?us-ascii?Q?KLFk5KDDt+j2d8rWX1LdTfa795F7Nv7L2d8Y6ffrmPTMMVRQM5B9IbtsIOi3?=
 =?us-ascii?Q?y0Eant2VOfnjR0KVmHHvHoZ2R2k/GJnqJ8e8DKNgP9ik9HEEMMCgDWCKanX6?=
 =?us-ascii?Q?ndGnS/KNW+J4D0pjaHQGYUDCSxsM7bDfDyhy9oNmAq4bh+0NpJnp855FrJ/L?=
 =?us-ascii?Q?EPJgoKstXpiDYHsPHJx8aCFGWwPACkeBZkfREC6uP+yhd+p/QCaCtGSf96wN?=
 =?us-ascii?Q?qwk1Mo/BS6HwHf+eWdupDC72rV6BQHF8Qk8AP8RfjPWUyK9wYoCtd1Fyqw5E?=
 =?us-ascii?Q?+vbrKtamazVa9al3mghto3O2jiYA7h63k7oksVSw78Svs+Rx4JtfSu+2ZTgz?=
 =?us-ascii?Q?O4oXaIOCqvWlLxxWemxR/DrnqXdcuKTECixI9dP/SLho8Wes4q04n+lUWu3r?=
 =?us-ascii?Q?qZ9qXH5bsLaGp8H+Uv3LJSIifKb05STS0FAiN5SK2mFqEXnBDr3fyVCA/aCl?=
 =?us-ascii?Q?TqU1AXlskvJX/f0Q8lZ70Dlkj0rqP7I9NRu4+ntVHlVOJzq1d7AHiJXRqaoU?=
 =?us-ascii?Q?iE0TfMQBc29TTZ58hQ+WrUbF4VS9tpIVyPiY+ujQ04WsdanMhWv5JDV/nesp?=
 =?us-ascii?Q?Q6OJnF7DXv3KaYvS5ITwXoyT1E7A6jrJwsFdXBDytGUKnrnZdxzjSk3o8WlM?=
 =?us-ascii?Q?Wtyo9jbXvTVAszKvuT1LhhaWlKQB76aS8N2hM/0H+WQKO1g8YU1/y830Dk1n?=
 =?us-ascii?Q?BbZN6KxVwY4WJBtQiMGtlsLu7qN+fiwMIgQkhHWpF61rDPvqQDdhmb9A5UCM?=
 =?us-ascii?Q?03KXG1gXzRkoX5Mmv901vcRJM5g71g5ARLvIhiXkcDEQ0P60Xe/t5tZ+o43X?=
 =?us-ascii?Q?CysB0UpOFP8ryR4X0XyG8WW/7xxnGuFgRQUOqbozEfnY/pLetuOTaXZpjY5A?=
 =?us-ascii?Q?xYI9MadpR2AknY56/dzXNm9tG2chASymfnTaI1H1Jcx6HKK6vRoxSt6h5Dvd?=
 =?us-ascii?Q?HBU7yk3lpzdfJLV7kcRKqip1W2LXUfHqhVOvsJvU7Hz1rY56Yjo6oVgdsOzC?=
 =?us-ascii?Q?UjlhXDygXMReXhgI9IQi+EEt8ppDIzw1PEXK6MNxOWc6Nd9C18k6vIfjdY7q?=
 =?us-ascii?Q?gWL2pJeO+udGYHU8XwT2ekICByN3+WNEcuvxCVqlz9mtCROgn60/IUsboub8?=
 =?us-ascii?Q?Oh2ssimenZCwdmgVdQZKLBf9sC9dBr+YOGX+mq9dEKQnmPCEhVBoDkuO95Q2?=
 =?us-ascii?Q?/lx2K/1A+V+msjmMo4YVaMtmDTJfhfRzbSHIlcAXUB8RtbQJXWSw7lL0EqCM?=
 =?us-ascii?Q?6F9E4VwMnu4nCDa8U2q1tAOaoZOquugpQX3w+lfD2Y2D/gqR2oBlTNoSAej7?=
 =?us-ascii?Q?yzBSCqERTBF9kYPZHT/eeI27jsJNXACHUt5LZPO4BR3jJ8qlBRBc6I5QKjSW?=
 =?us-ascii?Q?cAOUhRD263tuZfPzhlMiwg6bJyYKWmhe0RQbch0y5r2QDslJFtSz7cSbqbd2?=
 =?us-ascii?Q?yaORt7a9FKed6RsqnejBQrFEghE9mZxEmQbMHBgC0JqLbvYjqXBBLfeepNY7?=
 =?us-ascii?Q?xW9yNqojGGcSF3EexI+qFXQwLWmwbPiHZ0+8priMWmIUJ+QO7OOifXbSLU/f?=
 =?us-ascii?Q?igbIxLOTiT0Gz0OSzEM7VemdM42bCQU=3D?=
X-Exchange-RoutingPolicyChecked:
	KHAJnB6A2L9XjtB7P6YtdaNQBSeBml+vqT1LZlnqUELlcBJ4M2OuK8+3O5CqLSuV5FdyzQ3E5Q4OoIHp+GkSPZ6EYERvLBo8uA6ikSAZouaJ7PTm++lFOmitVKbvWkBGrIM8r1JvLT4L0fYhxQAFQsu+/yxBZWnqcAnI5oK2e4z4vPf/rDOfdVp8sOT+XnvSPsR554HVwb4BuIY6iYlkIcyOWZFfx6x5PvLHstyHhohQCLOra4etTlpBPnvfE2AYeGx05679E7MW9RXcjVPlhV+o4wexqGrlXeOOLum6ma69qNfz18fkCOqidZ72qZHMJzIp5cin4NASBPl8qYJpXw==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Z7X7DZmMZ5D1RyfP1XeMH+iKdh8sovUdhK+2qEI8yarRJlgODD9U2mria2oZTF+YnNF/TfB83yG/eDLSE5BwnUkMmQDb5rLE/s86bWaCPf2ipFuY3NcTiLF7EEENC1MsHlUnLqlykN+AAx1zOWpKwPcmQhjxojHQosuTgsiQ9Pf+zGAgN6sm203zCAjZxOfK4PFp3xSGK6eZbQTQD1oCk7nwA/6yLUoY7bZ6mY7T1lpUR9xk0/IWEwN5nnKlXd5Zxygj/qifMID0WQifE8wugyUQ7VuuZ6Qi9pXwxtuKKd2hjLn6eP7Pqs9oYZuB/RfjHSfMBYDJfpkkzQnxjNqJZPe9Ci2DjtjdNnDWP/A8LMUmiqEDdZHGM+giFRETl5UCJWMmmbtkGJJerw1qcuoRp7ljUBiOFcTOEH+ozscTa92L6GrP8KUl8ma7QHD5CJs4TlMnPw8/u+um+nXp3dHe+jb67xGSWA1xTfOp6jjXU9bmUZggHULRXa8OA+UCzrfVP6CFmwP/80obu0eaqsPrcbiiSIZfgG4JWig0/LOhDK4qyLfbRXVM4k6VvEww9fobROORW1lpEfA/dko9haqrhywUMmnUqdfWGQx4DxN4xzQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 013a9f43-5440-453e-a3d2-08deff610089
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB6229.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2026 08:48:42.1372
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MLng+egTkX9qIyOrZ++sq8nZSZFMoJ1zYX54WS//HFy7O8dPwX3ig9pxxLX8aU2AiCHW17hSIZBqEAajOKrt1A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PPFAA42ED99C
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-21_02,2026-08-21_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=972
 lowpriorityscore=0 malwarescore=0 bulkscore=0 suspectscore=0 adultscore=0
 phishscore=0 mlxscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2606160000 definitions=main-2608210063
X-Authority-Analysis: v=2.4 cv=VNvtWdPX c=1 sm=1 tr=0 ts=6a8810ed b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=Sv0fKeRqtYgA:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=3I1J8UUJPc9JN9BFgKH3:22 a=2xjCNr_vDHgFTRTEclgA:9 a=5yU3S35YU4bGjq-dph-N:22
 a=Bho9c0fBagfJEIQBS7DQ:22 cc=ntf awl=host:13521
X-Proofpoint-ORIG-GUID: IEf57HSD1YYWOUzfiijPm-tPQlrHaBZs
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODIxMDA2NCBTYWx0ZWRfX1Xi/k5Erqiml
 TBMw7LxRWu/FCHzMmSwI0nR9potykt3L56McRPJnRoA0VN6Pq75nTLt5KU60yCbZ+m0gt+yecBu
 ySC745MpfYz2AHRCJLyy0t4tHT+YOu1jqKKb/wY7+hUy9qEOkPsBaF2syMbZuBZuODCxqcnz2Ga
 8GhVcVzGPMFIgJTbe28c9aPcaO3z664Hxq0sDRADVjLHaNSXHV58BBbYuESDx0RfPblIDxOWpSS
 +Wjbnn7X5ITjsPwBhBOeuYKP0A5FucdqvXRXynNuCgUAAuUaKW1L6heCPnEVvdBO1BjePoNmRDh
 RM0Gz1RIS51nwWiHHj1Q/mVCfunPX/L5a0TNcki00EXU4vutOaZ1M7CIovvJYmfpiG39yoHbpo4
 qmYsPqYMUShgCsCgGqjLjWPEgbgo4nMAWIRaWHtUph0s43PmC98ZePVEUuGfGXou7/5HDGoSx+A
 GnKeMnz1qHt/n59eejLhQZ0LHq1Qf9k8wn3zA8nE=
X-Proofpoint-GUID: IEf57HSD1YYWOUzfiijPm-tPQlrHaBZs
X-Proofpoint-Spam-Info: AW1haW4tMjYwODIxMDA2NCBTYWx0ZWRfX/VGc/zK2wLNz
 od1zmt9Aj0dWGyA5hcZLIZ8rShDoemJ0A/+nPiTRFM35UGpCuipS9BirMqsVNtYHks39aETNmSx
 AK3S23AQgCaex4TnX3L+lG4RJsFK6PYRMnueyvjZM9mgJiWrv0FJ

Currently the NVMe multipath partition diskstats are not maintained.
This is because the functionality to update the diskstats only updates
for the whole disk (and not per partition).

As an example:
$ ./fio_read nvme1n1p1 # run traffic on /dev/nvme1n1p1
...
$ more /proc/diskstats | grep nvme1
 259       2 nvme1c1n1 49857 0 400344 768565 0 0 0 0 0 2334 768565 0 0 0 0 0 0
 259       3 nvme1n1 99710 0 800680 1599285 0 0 0 0 0 2346 1599285 0 0 0 0 0 0
 259       5 nvme1n1p1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
 259       4 nvme1c2n1 49853 0 400336 831472 0 0 0 0 0 2315 831472 0 0 0 0 0 0

Notice how all values are 0 for nvme1n1p1.

This series addresses that problem by first updating the gendisk code to
create the partition table for hidden disks, as suggested by Keith.

This is done by cloning the partition table from the multipath disk.

Secondly the NVMe multipath functionality to handle the diskstats is
modified to handle the gendisk partition, by looking up this partition
from the per-path disk partition.

Setting as RFC as I am not too happy with the block partition cloning
code.

Difference to v2:
- don't scan per-path disk, and clone from multipath disk instead

John Garry (3):
  block: support linking disks to clone partitions
  block: don't show partition diskstats for GENHD_FL_HIDDEN
  nvme-multipath: fix diskstats for partitions

 block/blk.h                   |  1 +
 block/genhd.c                 | 35 +++++++++++++++++++++++-
 block/partitions/core.c       | 45 +++++++++++++++++++++++++++++++
 drivers/nvme/host/core.c      |  1 +
 drivers/nvme/host/multipath.c | 51 ++++++++++++++++++++++++++++-------
 include/linux/blkdev.h        |  8 ++++++
 6 files changed, 130 insertions(+), 11 deletions(-)

-- 
2.43.7

