Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1565983CD5
	for <linux-block@vger.kernel.org>; Fri, 19 Jul 2024 11:29:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721388592; cv=fail; b=JHlvpbcZT1ZiuGZYlYoBhH2zOXOlT8Nk19zAOoR53X3J+IjyVRAYM5LPIM+SwrnplrPNSs0jXzBxVBwS36SvQtZKQsfOc/pD5ndW5tDTA0E/uUymuSbTJldWdvlDNUUes4nqHwwaH1UsGE1NVH8dZkK6qEg8ne1HwoZ5aANWqbg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721388592; c=relaxed/simple;
	bh=0ytB0ZuLGq/IdMUqa071RdHizSsv7L3e/p2uJw29M94=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=BGQNpIXaFZUtX8U5pMJKa95jdmwBh+PnVK4GrHXjvZ5zUbDlVmbGCtlGm008oTNKH2TlC5kPTrUgg3rvRW/pgK7JApCDJ44sfIJXCDglRQ5o0NNaWzNuZNlSIsgrPlMw0xrebB+qqfK11AtsTucoCQQwRtsAeNcPPQhu7E4QphM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=BM54athq; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=XB7nesRb; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="BM54athq";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="XB7nesRb"
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46JBKKCT012235;
	Fri, 19 Jul 2024 11:29:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:content-transfer-encoding:content-type:mime-version; s=
	corp-2023-11-20; bh=w1K0c1FGyPYQq4wQozYLM4RprxF1JA2OGZ2SxUB9SLQ=; b=
	BM54athqkNpB1QFzI/LdwO1koFtogUt0IEtQ2GOUNHUcY6CUUh+6AYT4wyx2Kk72
	1TZ8fF0YjQjp1pX/rVqp0ZMfLCeGzpVy435wGt2lR6eOgRbbTNBKEnn7fuKNeD/i
	ee6+CCf/zI7HTlM7Mk39RWocjOQ1l+6GBCRMRAshZaCcVeSJGuKOaQ6d65jXhmqT
	Ik6jdkBOYBa5xigL7QmRyOGxDCAfkNdjksArKl713lXbAI0gp111Y+IACdRMX0ZA
	S1mPQPQtcjK6qJ7vYhOr1Z5dDocbeoCPHY6A0Qun+RZ9GWqCdgwrg+RaFW7HgGnU
	9dYxdthW/w/X2xhhq4eRqQ==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 40fq67g0p1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 19 Jul 2024 11:29:43 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 46JBBN3i021786;
	Fri, 19 Jul 2024 11:29:42 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02lp2040.outbound.protection.outlook.com [104.47.57.40])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 40dwevt7pv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 19 Jul 2024 11:29:42 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=H88Ml3lAFtyjdU9Y9q0sUK6tGKORsxKsYXKGnKMlN+vRBrbMTwbtA1MJUyR9DDfHeoHI8xYTY+kdZQ6Siwi30ZYwN437xcWDk5i3F9Gf7zRXjN8dIBHN5wdg3B5dTyCRI7xn4jheHInap0jvIKSfFpZDEyqsZDA6GYaHSh8ZixrHnyq6WGdzSjwpzyAXAmw7lEnUYtxUADOeiloWq+UeA8ulOlQ6GJReoqfiTWMy5SUIZ61R9kM4wu2Sme0QRil0RTcuEDxVhxLpw8yPqp+lE44d0k3KGxXfT2TwcGP6hznHCagGFOmNUWGw3wZ+eytF7/dX+Wqa5aNiElAPE7qQxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w1K0c1FGyPYQq4wQozYLM4RprxF1JA2OGZ2SxUB9SLQ=;
 b=FxDOqpUfjURGJpWSufG5ErUUKsHMygqU1Lw2Lwm4yPSJ27plZbz+UJUUUN1N4H6blxHjGQUTXsStjVKGbezKvMNPX2A1Kqr95jQeOj1UNXap5CqhfWgej7jkXeqa6WAFv80f7X/RxdmAL2WkOGfDnoUhCoaaP16Jc/PZtTON5dcbc5kNiZguNk3MVjw4uqQnFC+g27x4MQBXV5+PunnxsicWQ5Fx6c4Lb3tqbmLuuYfvt7UsgIoHs+r1yDTUaYmKl7/8JcxR5G1k9EIVAEEvJWYF9gFfOL1ZDCkmh5NuxJFwzXU1flk4MgM8wnbNcG5yW1pRsHdDwhP+xN8kGFVH5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w1K0c1FGyPYQq4wQozYLM4RprxF1JA2OGZ2SxUB9SLQ=;
 b=XB7nesRbzDZRArriMJonuKIXOyBIxkvs1fbufm/FvjB6qVpKT9dutsN4AtqABcQd4iAdUIr2+NWMmaQO0LIDIc6LQmtSot+7qd/My90v8M4QeZGJZ6BVsLKxUajufTiTES5ZpCtAmGkhRVoKzKfvunhhBZoo6jlJJcUFNoXXLys=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by CY8PR10MB6537.namprd10.prod.outlook.com (2603:10b6:930:5b::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.30; Fri, 19 Jul
 2024 11:29:40 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%6]) with mapi id 15.20.7762.027; Fri, 19 Jul 2024
 11:29:40 +0000
From: John Garry <john.g.garry@oracle.com>
To: axboe@kernel.dk, hch@lst.de
Cc: linux-block@vger.kernel.org, bvanassche@acm.org,
        John Garry <john.g.garry@oracle.com>
Subject: [PATCH v3 02/15] block: Add zone write plugging entry to rqf_name[]
Date: Fri, 19 Jul 2024 11:28:59 +0000
Message-Id: <20240719112912.3830443-3-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20240719112912.3830443-1-john.g.garry@oracle.com>
References: <20240719112912.3830443-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR05CA0016.namprd05.prod.outlook.com
 (2603:10b6:a03:c0::29) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|CY8PR10MB6537:EE_
X-MS-Office365-Filtering-Correlation-Id: 9361dba6-c3f4-4878-3734-08dca7e6144d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?sQgox/s5CfjmsZMKneFU/4Z4p3RwXTKnYxKr54hm9SsNuEc807vuqF7EtExN?=
 =?us-ascii?Q?07n4PKUn5vV9h2QX4S6NuhuXqy2uDxehxTWK4u9ZeGhY7hZkrFHomtEXQi/U?=
 =?us-ascii?Q?YJC2qf9nIitYDRn0CpjYnBVJHx8nspxIPmzczLvEhy2JDSSLHTp6XN6Z/bh1?=
 =?us-ascii?Q?rpB2QbR3b/xP/1X0h9xvwXMHbrM/dPtrTnlEYe4qCHZcVzPS9lBFp8LrQhLj?=
 =?us-ascii?Q?jr3eFrBRRQl0JGMh8G+2vFEbboIH0n1JvMzWT7FTpkXdM+GARqiBcUfF2smx?=
 =?us-ascii?Q?sNmQsad1T02qjRkij1HueHHlQUDvghGexJ/DVzvc1eGP94f4JxveU4etHExi?=
 =?us-ascii?Q?lZ8M9+moaZ6hypq8NEvzJEP1Oz3eOf3yrzzJUiBVw660ulPjBgfqSYz+6qs3?=
 =?us-ascii?Q?oi33r3zNRZMJOPgNrsPWXAhJD3m+8SbScLa68iBKO2m6EzssGNcMRzpllYRv?=
 =?us-ascii?Q?+Gl61sfH+nkEYWfmDXbsr3S4J8D6oybW+ooA7BNsZp07QsbN+nxwkfWM7fXf?=
 =?us-ascii?Q?m6iSv2XLswVFvsVIYIaVgv2sHMKdXHv+Wk71GNo2o3TZHxULOwEwLV3pCIQW?=
 =?us-ascii?Q?vmesUFRTBL82mab8xvNnnFM0a08T0MYt/yhUpSx4LtpyzJU2zxrLPH8nK49c?=
 =?us-ascii?Q?2iJOCrYMj1XznSC8ozEuQAtJ5VdEAT7PwDphZEBy/kSJJ/S4R7Go+rZ0IfIl?=
 =?us-ascii?Q?9rcHvuyf5df86JIYysBQCoche7THd27dF9H3JqoS7U+nSOxZxYYR+pRdh9lA?=
 =?us-ascii?Q?75obNPCqJYX44N7984UhiXDAKTsKU3dJ76fdX82h/AXp/2OByfrkbJZWGddZ?=
 =?us-ascii?Q?18kaFvSwJQmQi6VNNRFEwVVWZ9ibBUhm/yTQCef7jVplGLOTwSc9jLwGvRHa?=
 =?us-ascii?Q?gGe3tBF0dVFDmXiDfNTVm3XFpLbBc7MEJwnQ0C7GQpmeTyytgW6xPGE7sqMl?=
 =?us-ascii?Q?rBSp7rCxTr2lduOyPq3AIjEI98R4i83pZwyOTJWAz+yQiazOeUPQPRsmaHIa?=
 =?us-ascii?Q?S3xG9k+hSbANM5rhGb7VzfteYauMbNKMRooPifWnDTE43HTYRwHrHlQ2kL3n?=
 =?us-ascii?Q?kyAt9MEU+CYx5/1/RqlKZgFIotI0QNXXR55Dh+vDlSSqHPZKfs+mMICqyAgK?=
 =?us-ascii?Q?smKWkES+6Xhqfak2bhs4R2s/AvSxKpybfmjmdvtfVjkF8dqQZ86+1jLjQyDR?=
 =?us-ascii?Q?sJUhA2jYxpd8KO2jzbQKUJyA8RmKEmNQX7QGaW4gdvuAve5GmMCXG0pK/U4d?=
 =?us-ascii?Q?5bWAzOONkzLQr8+HZHoQeercFChANzBA9kcFG6Xs5jMjFI/WPC4WeS/vjJer?=
 =?us-ascii?Q?fJeMIx3ucQc8HGBwFgo7h3ngI4+sJ2mmiRFAOJGVTYTE7Q=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?cTS//1pfnCyWjYhNYWGx1E/whUixoBKHleBf9aABFzpIyZUsdQgOBPCoU40O?=
 =?us-ascii?Q?DuYQIgwR+5DWRE+rWCkGGs2LVCGyv1dae6Fn82Ank+Kpz2MMOB0IMx+CL1kl?=
 =?us-ascii?Q?32AuCaCt9GvSqtBvJoufBVDN4gV9vPn2E226djEqX0rF6cNk1P+K/GYMIskY?=
 =?us-ascii?Q?hN0rcUQGrMWaG39cGxmPEhM/nkqxFZVnPeT12J8Wau3JeZCCiLabqqOP5KTG?=
 =?us-ascii?Q?miX8r6soApk/mZ/2P3BtdI5Eot+f2+yx4dt+BjrdSrZZp+ixTZhY6R9MXrM0?=
 =?us-ascii?Q?pXakvqJtV1I+Izvw0BqoUyh3TGvXKzmdRwvF3lK9kWwY8EARrzPPkbBONEin?=
 =?us-ascii?Q?zy5Et4mGKJiSkn58WZgC3MF4XXc59evATOViPvClxX0NzUNoFa5qC84oPHDG?=
 =?us-ascii?Q?f55zgE19Zln2Kzhep8a/aB7ZIpEj6q9cJiSpz8/il/84J3ccUrS5PCZsYGDr?=
 =?us-ascii?Q?LvI45PSb0FnOynu/kEM4toPJwxZiyJbICIfX3Hzla35F106OHOKNQCYeZQ4l?=
 =?us-ascii?Q?tKlPmQI5onYp4E6b5aNN3LvZDo9C5EsbcbMAmT01mciybuNZDFDW7CAdxOAR?=
 =?us-ascii?Q?6kr+xn/iew4nsAuwnbeRDxpcZ+bcxcsjoqRoCWFI9+i+JigyhF9j5QYHqLg6?=
 =?us-ascii?Q?gHtHh0XoWvDKInapS63I1/J48CZwVfNWbK9LQiI/0EdJukPaQJUTmwiMfr0f?=
 =?us-ascii?Q?huoad8SiGa2Pk8HzYxIuw8CzVZxpsUfcIavwwD+/IrjaJtkQJtNxaLzWiWi1?=
 =?us-ascii?Q?13kiSK6npOdjbMm+TgtUivxGoUj6Iyv/KEeuqxes7fAEfwUBVklrx31/HTwQ?=
 =?us-ascii?Q?OhCJb12U0CZZlXOTHJNwPgpN9pxqH8RmpDk3FTXhEi27aoo8K66a7r790P2n?=
 =?us-ascii?Q?nGIPqAh/rW5gT/obdrK465mkalM6Tnyis84zqRqd0J0ZqjfGhfXoGbF7U+lX?=
 =?us-ascii?Q?XagRjctSZ2ly540fOwHPVQqFkMCJSSYSnh/ItIKfs7m+BqB3uiwQseJrbB87?=
 =?us-ascii?Q?C8j8f0caVActYjG/z6YjNIozdj1hyHioxqNmBijFFR5h+ZwAQMy0135dJfmf?=
 =?us-ascii?Q?ClKU1hj3Qiytbzjt2YvaFFOWS9s/HeJhF74iauzkrr8/PDTxjpn028NbtXg4?=
 =?us-ascii?Q?TTLuYtStBkRvrOvwusTQEwZuyfw8InQvhhsiFizhqUNsHcjnD2Hy93KuN1O2?=
 =?us-ascii?Q?7xo+tIhROoyuTMr0sJxXT2Qyjkcxj7jfijaPyjNv1cLY9U0LqpnajOxBR6xm?=
 =?us-ascii?Q?vAfqASgP0r4AwtdIiFB33kzbWCaDW0UCYI2ZDSg/DkslagLP7HylicpEbH1I?=
 =?us-ascii?Q?e0kbEubnH2k5Sxjamht/Gg+Cx/RTW1PInbkprw+d/0OdNRjO8WfkdHKXC1VI?=
 =?us-ascii?Q?ieVQpAlCl6OQ6sAiKGc5yUTImpCLvx5/i38eMMdvaSijXX+9Djz6fqf+xnhP?=
 =?us-ascii?Q?YYsqOmp0FDqdfD8jk5H50Qj6qGTChNZ4+/CYo5jkRIn/taFz8PPHOm6xycwu?=
 =?us-ascii?Q?SsgzTF+OmNBuAUqDhlK2tHDpAHhUVwItz/XNgku/jUALEuPSlbQlfzUht33S?=
 =?us-ascii?Q?kUqDPlUyQiDraKCUvKshPqybsqDj2vvUcn2F3WK2Uyc+tbjoMweo3bqLeHQL?=
 =?us-ascii?Q?Og=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	Sz/qLvsnsXvDTZzKuoKlaZ2THVtFBbg+WTJfyDrL62ExdAXUQvmFwaZ4R5/kmCHYFZXeQIObhVneJ9LV+e4t9crNdt71GVtQspB6ESRgiPFJLxX1J90Y/Puyzqbz88YdZYbz9dYVq0g5AwNm4MU+2L+2tJBnhHoCMP3ESAwBQT9EoQRV8lyTvgP1zM67/aBrA6wBWevzIbeUZyMhp13mqL8msIqCdmbz6UX4dI5nMJtPUfrA2cZz4QC54sTKbpEjRzqRK/iCQMfxJmlS2VvRInRzc4BCqdnt6NH0nnw4bIOeuW9s9co/b3WsX9kmJQh9U9AQcMLLbaT0vwbIUPPJb47jVRpL2jyls43SLLkRDnsZ/syIlsOBAajmXLrGqA3mUdDRVqc7vtjWt+d3EuxR1oG3ep63+bb5WKfG28vSyGcTNsTihU3OJZlEZOSr6pzdqqZC7aWEF0XmDSY2BMD6C2E+IdlSWwahIG91tShBDallGVed0ZI5plE1fXROlpheCXfxm0UweIlKQJcAFZqakSmfAsixLUbSVPnz6qczP3TXhuyUKzxmVbwSOZdfjc7/wzHMNW2On6BZg9H21KS75fHcCvDquXbJfE3s2DZHtOk=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9361dba6-c3f4-4878-3734-08dca7e6144d
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jul 2024 11:29:40.5894
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2omi7lWGE/wXz8/0A88KPQ5q7Aq7NiA1F6Yxzuc2FPdn2WWku1E/NZlng6h7Tk6Si046nJVzSfH3B7dzZVDZnQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB6537
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-19_06,2024-07-18_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 adultscore=0 bulkscore=0
 mlxscore=0 spamscore=0 mlxlogscore=999 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2407110000
 definitions=main-2407190088
X-Proofpoint-ORIG-GUID: eSVxIQmFDenx7PV0UvehX-drnO93WsWy
X-Proofpoint-GUID: eSVxIQmFDenx7PV0UvehX-drnO93WsWy

Add missing entry.

Reviewed-by: Bart Van Assche <bvanassche@acm.org>
Signed-off-by: John Garry <john.g.garry@oracle.com>
---
 block/blk-mq-debugfs.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/block/blk-mq-debugfs.c b/block/blk-mq-debugfs.c
index 786fa4d6e019..49d4f6e0a719 100644
--- a/block/blk-mq-debugfs.c
+++ b/block/blk-mq-debugfs.c
@@ -248,6 +248,7 @@ static const char *const rqf_name[] = {
 	RQF_NAME(HASHED),
 	RQF_NAME(STATS),
 	RQF_NAME(SPECIAL_PAYLOAD),
+	RQF_NAME(ZONE_WRITE_PLUGGING),
 	RQF_NAME(TIMED_OUT),
 	RQF_NAME(RESV),
 };
-- 
2.31.1

