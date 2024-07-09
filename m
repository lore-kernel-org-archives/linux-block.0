Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CF74155303
	for <linux-block@vger.kernel.org>; Tue,  9 Jul 2024 11:05:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720523156; cv=fail; b=ITlcDTgGzP9LwpskMZ2ljlJwXbth65EmRnX64ddNG7rvhfKxT4v3dNHYp1pYCzGC3ujAMoaNVMzEhWvt6AKUxAofZLDz+wl9dMymRbs3gVKy0RIfSnhMggAGKA80ASmamZY1DZdAkZr78JRDWU2otMUg/2flWOHY8lSvNpXlFjg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720523156; c=relaxed/simple;
	bh=ciTFroQKukC9+rZQEctUxhFFjH/qQopPFTCWvTR6QQg=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=jEOe2lCSFLawaq8w1xI3835kf1KKiee60q223sPk3FQVX/RAYXy7FwqR8/l/4Ei2YedXKhYs5+f/42ickC5J3ldbw+KRPBzk4OJXDwfKmj8T062gZpExnjEzqgpL0rGjv/PDPB351b7lheytgCJFopNas4yCRrycD1tYXF+7QQA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=TOJ/wRF3; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=lMcOnEjI; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="TOJ/wRF3";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="lMcOnEjI"
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4697tYiH001445;
	Tue, 9 Jul 2024 11:05:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:content-transfer-encoding
	:content-type:mime-version; s=corp-2023-11-20; bh=AqQ8qP/QMQrsyT
	FVGvJpfopiVSTHKDrfmsMDpZo3LkA=; b=TOJ/wRF35Oj8PsvaZOvNnTgbQm1Y5H
	D2BLGhTooKU9Glay3XN4jsZSB/RymA605kXomyKO6u9csy7G85LnU6CaqySchP5g
	NjQvv+dOwP3T9L43a6fsbIBrojNG3Azd91cFVUKE2IUpF/kN/wDAJfp6HCth80AQ
	Mt59Vuwps5NlbSndDkWnjZKgmQqXv7skq7biQeZPtTy14acSbaDpkTmMK4zwEChd
	o8geis7pgOQO2lI0N44wK5nKk+P3EkgkqkVqicAetJaF2rSfauMDTwYOkCvfVmEa
	jNloMXZfnoQ2ZrDvcptlB7HExbdiXDizmtRl2oaWBwMUv/LMEB8s2fZg==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 407emsv1n3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 09 Jul 2024 11:05:49 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 469AGNSo014401;
	Tue, 9 Jul 2024 11:05:49 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2044.outbound.protection.outlook.com [104.47.55.44])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 407txgs9bs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 09 Jul 2024 11:05:49 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NDDAoC4KDSEwEUEUPd4inflk/wZankDf4t+vNb9bQWmswrtwyfofrrAeQ4sCUncclEoat/27b2Zd6lMMeynyI0X6w0BEjcVyenePc2s4wj8FF6dooLMo/mBCNSgQMCyqLU0P2qDY/OcduUDJEgMZyPUkkJQuMSxYwi5gtiG5hdBTS2sTHhaJ7SbSVwYtf5VS1hlHGQyxzVWHDzAwMzXdfem2bqdz4SpWw19Cxrfx/xKPVug3UbjKl4nl3EB1W3765nbHRmB3Az5jErVXo73Sa5LjvBxI2Ay+M7ZbvlbeCD68SQwhY+oij5TOjxIarABr9FPVt9xSKVOI0Og/NG05SQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AqQ8qP/QMQrsyTFVGvJpfopiVSTHKDrfmsMDpZo3LkA=;
 b=Smi5Q2qKrojllnfc2rHBr9J/HWmrIDlhRq0xk99rM9gCUXJ78/fhNRggIWkisJ72ttxKApIufEt1Swt15bNl46O69YbB+GwRf8joh5V2CoyI7K/ayRQOinklZx1HdXv/aTDJAjECmK3CoFSX5AmjIY30P2QT9OYNHpwIfGqhOzFsSoHOBkFtsNMPcFDWJf5aCOIh5PVZKHqEtRlv5yS0eZCKNT8QoNR7jfX+ZAMjp1lJFXk2qVgUcdu8qfttqRLAcTDNhU0i0hgg5KrSzYYkwLpD8xhHtaSJtxdbIV/qyrE7uOOKhQtsgfm4Y5hnz9zQpCn6qXvHE1viDGtPsCV4xw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AqQ8qP/QMQrsyTFVGvJpfopiVSTHKDrfmsMDpZo3LkA=;
 b=lMcOnEjI8LFNKkYnmNUwtF/uZglAfos8COD4o4/xPmbe4qsWo1GFqb5eXh62BPx0ynZc+fEX+oZ9vJ06kmzJRdDAB1oyzrxO95OCcDw+E9b5yZS29gijpvy8C5guPR1OWW8gY1dL2PZ/37Py29VWpNmPVlICT8nRDSdMNuvF/wc=
Received: from CH2PR10MB4312.namprd10.prod.outlook.com (2603:10b6:610:7b::9)
 by IA3PR10MB8068.namprd10.prod.outlook.com (2603:10b6:208:505::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.19; Tue, 9 Jul
 2024 11:05:46 +0000
Received: from CH2PR10MB4312.namprd10.prod.outlook.com
 ([fe80::fd5e:682a:f1ac:d0a2]) by CH2PR10MB4312.namprd10.prod.outlook.com
 ([fe80::fd5e:682a:f1ac:d0a2%4]) with mapi id 15.20.7741.033; Tue, 9 Jul 2024
 11:05:46 +0000
From: John Garry <john.g.garry@oracle.com>
To: axboe@kernel.dk, hch@lst.de
Cc: linux-block@vger.kernel.org, John Garry <john.g.garry@oracle.com>
Subject: [PATCH RFC 00/11] block debugfs: Catch missing flag array members
Date: Tue,  9 Jul 2024 11:05:27 +0000
Message-Id: <20240709110538.532896-1-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL1P223CA0024.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:208:2c4::29) To CH2PR10MB4312.namprd10.prod.outlook.com
 (2603:10b6:610:7b::9)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR10MB4312:EE_|IA3PR10MB8068:EE_
X-MS-Office365-Filtering-Correlation-Id: 31d57d74-e981-4952-9fe7-08dca0071557
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?lHEXh+Uc3gnLNqZxz7JajEurJRFh3AtQ6mAqaZoYa9fpLbbx2esGW0cfIgzT?=
 =?us-ascii?Q?yIM+JN3ZZWKc1t+MjI6T1RBF6MEp/VXTWOLBupSKo0uKApn+heu7e72jREAq?=
 =?us-ascii?Q?cpLm5M1Bs7z2/8Dw+4DUFvH2cEol0Lc9cETnsKNDbne661YPXJhBWaEgqKk/?=
 =?us-ascii?Q?SIsnkggk/oIBO75yVmacPFqvyJEI9eb4DpTUYaBoa5oFakvV7mgMIjFu9CC1?=
 =?us-ascii?Q?7Ny8X6Id4rUFFLtBuRy8PW3PkWUisNSI6LV8ZL87QTUqDZ/4jk+00mrecr/m?=
 =?us-ascii?Q?A0UxR/08TQBZQQwQ75NMFQLZ40hfiIFEpC5cJ8gMKTwoTJTf9s+zCkUukc29?=
 =?us-ascii?Q?A0f91WJiqksoKiQqZbqupaV8vJYbk8XwESyDNu6m6d40jpgf+Xl4fXcgexQl?=
 =?us-ascii?Q?h4KNem30O3HqTYgLPYaN5d7DUFlkTmB3F60pKYJdAiCI8/SAXq6b1C8wSERL?=
 =?us-ascii?Q?fqTeERlwcbgrJI4U5lKKB6Mk6jl60KTsRj3xiogHkT60JZHKr3YbFXu4+UZ9?=
 =?us-ascii?Q?XXqWFRVli3LICJsDF2z1ixGL84FKrTfVjXLd9K/TrXLmZbk5w+mfiejtxq77?=
 =?us-ascii?Q?6WYa7X/Mnn/TSVhcmUOnMC2Icq7Bcp2RMXhHVSaG0IihmK8QDBJ/ArE2QmLR?=
 =?us-ascii?Q?Ocg1GDNYdSFhL0/j7MFIoI+gZEkpdXyHfPFZ1dXLk7J4cn8cXkJw6hCHPIJ4?=
 =?us-ascii?Q?Jex6FgDQ+CQXC8pdOopK4B6LGnq5c2njpr8Ebd2atUpOisCVw8YYw+tmTVTN?=
 =?us-ascii?Q?rfwITHMGmKMxqUu4XAPdZT7IMxqwLQYL3ADsB8sNdrIiWmYPxf9ORenKPndV?=
 =?us-ascii?Q?L5Z2zzuavVCp3SpyiXz/CilKA1WZxxxas+jxT4BUrstZQpTAP2a6OgZb3NH7?=
 =?us-ascii?Q?OqJaPNb+uMLgtDft6x3z5TfNKfilXi9QoAVbAxLRvwfU8n4KhIPiYIXFRdfT?=
 =?us-ascii?Q?PJqsjfHDHHXON7Wf3vMYzuii2rFO7W3QmQDV8ufl6GHgnd2Sq5gSr+I4Qbyd?=
 =?us-ascii?Q?ezHrqG1dtULB8u1ixzYy+/J8TZ8igk9T5yG6C+jxJcgc5dY/vJXRBnJubhxh?=
 =?us-ascii?Q?Oir4KzZ1C0eFFDFnBflKsG2mwW3sUgJPAx5JgHytL2uuHcauDb+paAoYEv9q?=
 =?us-ascii?Q?TQAXVoY+Tbw7UhZ0/K0yI3bXGtEEweivVCuTnJ4CqO9xu6wzPUyxgNp33oXF?=
 =?us-ascii?Q?9p3NpZ7fLclNVS4nsiTYyvaKRBPgSlS/rdQm3A0jFAHGeXxU4sUTFiTfpMs+?=
 =?us-ascii?Q?3UuUuXf2jAFwR6/NDXpd3h4C7z2BEydH9xS2DSszUulZhPaznYPJ8MtKvDNN?=
 =?us-ascii?Q?/qY4/Ded3up0N/qQFgpScp5wTRWc+x+N8j/ogj9bDwpIOg=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR10MB4312.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?ZertKIRdtwhwEWLpJqjwpfCV0JIEaUMjuG+DveIwuEwZB9juqgzh8FiWUdHY?=
 =?us-ascii?Q?990d3T9XtcweUOAQaYfNWg56VhtN+TqE2a9uJlO52v62mXPB1bQdxJbwL+zP?=
 =?us-ascii?Q?Czha65HJCpvTDqGbM+ngrsl5qoSt/63KYM/1mx6PefSqId2b8Cc4TyDHu24S?=
 =?us-ascii?Q?7JlE9/LOna9nUQZEAHisDNERDM4Wf2Y+yfInuBH2TSAq69slOQL4xwAFdIrx?=
 =?us-ascii?Q?iKmGnFXxA15QzpjS9VyOkHQS1VJ9nij5JPQgBFQVzlLw5mwSCm8er67PuTrM?=
 =?us-ascii?Q?hrXqn1rDBpbEz5FQk+EL60RplFl9V8nj6DuGW04JQJFUH6Dd551Deu5KdbEr?=
 =?us-ascii?Q?4H3NY20YhARW7XFlSbdJPKoGuMUb98oW/1EEH1HXjEbfHaoKtrdzTsLW/7DF?=
 =?us-ascii?Q?8EJ2otJ9sjS6nrX7u8SbuNJnOWby+T9bRa8ONgTakd26xTvg7jDmMd4+GUzM?=
 =?us-ascii?Q?8gIy3ZKBkmrfjp3HLoARHHAMwvxPjm3ZwWkYMc/hyfRJ/Yvlu7lwpSnTggz8?=
 =?us-ascii?Q?Nfrose5kdWt3XlSG/pVVZ1oDHjX/lkvAU92E9D/iQcNZzWyN5fURqU5Z99St?=
 =?us-ascii?Q?qu8KC5lqI6p9DVKq9riL/aPGsoaHErmlpE2I3f9Yc4aXxX2Br/fu1QHOSScl?=
 =?us-ascii?Q?pochB8sg9AA2l1EndX0uwCSvyXwA0FFfg6UD+191lX9tU/ir/eZTyhdWHf9Y?=
 =?us-ascii?Q?KPk3OPKIoPyrTH8Sbz9kJSK6iXnQzPUdT9iQQFmeqgpkReAUOYAIVZAKDK4u?=
 =?us-ascii?Q?AmubT1hWNUHdOhQtPmcaztrUVOelqRPF1Hupplh82TxQL6kLV0UdFNl+ho9i?=
 =?us-ascii?Q?Khf6lyeC2A4d9uiOVSEbHv2PZCNI+mKCWhdIZm02Wjznv/Vv7jiV3KdinDY8?=
 =?us-ascii?Q?3JbdPXn+1un8W2gqhyHiNhVsS7DY+PPZmrbvkuUcqTpYcVgCr3bCw6Ocfc//?=
 =?us-ascii?Q?6JpO4z3OMLwnXeohnRQUT14SrXidB7qpaXUv5rXBjHq5dZi1ZC4aB/81AUVl?=
 =?us-ascii?Q?uRj/VRh/OJ34UtJiWv/wOBP7r3lH8wOl8wDXmaFc1WoDA0Ukiz8Q5wZ1LAyL?=
 =?us-ascii?Q?OMSACKwGYRBkreVM3NKceccANRyuPvpwKtXQfvPmmgbg3FPm+BtGIkCAsdxN?=
 =?us-ascii?Q?l9XhMK6d0X+9vQbWKQtWjn8n2o6SEuruZxpYLWsiZAZd6zlOl0vNPqTb9rRO?=
 =?us-ascii?Q?WA7YTfH8OtAUMWxI4KRHo19buf2t4SMwtihdYUYOVNi4Jts9RokDxbRxYHkW?=
 =?us-ascii?Q?p2N+weOPhpwr8tfeSvZ3BksjgROfn/CsenZvmRgJ0x4ThJl3m0Qmrh6BrwFX?=
 =?us-ascii?Q?G5CpixYfpId0vio4bideDU503WL7Ifd8n/HAaKhsNzBJaPorfsSJx7cJdtyK?=
 =?us-ascii?Q?2jOy3YT8ZJxmI6yS0cnmUrndhz09y2FQwYAFCtY2xZPvz404lCRhFD4fe709?=
 =?us-ascii?Q?ot7q9cjHbGAV2L9hoI2XqcXPTGQhsx1CwrTtxnabUaFWVad2mDEOngP4Sm7S?=
 =?us-ascii?Q?eZTrmySW+vLtGVuSwD8r6J6UIOagDT7fG1xA6pAGEp9StXKyyEQEcduwzjp2?=
 =?us-ascii?Q?Yle0F+JjCPm7yCzWOFC4GpHz7akxAqpJm9N3Ri74ZtVKlC7CCxxZ/s8wrdCv?=
 =?us-ascii?Q?RA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	dTrB8r3f/q5ZAzi0q/G0IhWvJ6vIoC+F1usjQIwZlyk9XGn0bzhK68Q1tvUKi1JpkH1Ufa0iSYcWxLNHq1ip8oty/sIMHWNfINtBT0qP80E9Z15aEsdjOsCZUFfavr8ikJRIo3+039H5GALaxzqcQSlt57AJ3OUHNqe8iV+rXWxEgVchbgUr1xa5u7uVARSVeYHsKoCH1rhA678qZ4WmHSpFVlfRwW/0RtfF5HRrDaLBEgodRH02tnsGo/P5M+qK9XpLRziDFRpQYol6dY0iu+6703Ocuhg76/jFewtnP/I6jxKiI9Ar4lkYgH+znUTFt7Y4e1aqAU19yXGJPr1vBofQHcPL1HYCsHar/yeb/R8KKg9/Z1gSOuAsccXkQoo8TibDBEXY9i0LtbC0zgcwFPAHIa1bBdfM2g/zzGc/nG9HGD4td02HcvtbIRs8sp0nZJVxjY1kQORX6K0ix/DkLV5wYvXfWvSbH84G7g2OkByZp6Jnt6OAIt/fhlWUaosQJZq4uB0RzNZx9+5fsOtes54raHaUWd0Dc7Zfwuzdho5WNsIep0c2a5zDPa6XWLs47gC485FXPy34LSQXQJ6m856M4/N2osqbJHAWLBybhKA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 31d57d74-e981-4952-9fe7-08dca0071557
X-MS-Exchange-CrossTenant-AuthSource: CH2PR10MB4312.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2024 11:05:46.5047
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qsqO9HKSSWGcG8EduUAPU0qcG+ojGdmHyrgm0OVdWUBSgAcjNiW1qE7qEnwIm4/s0xYK0mjMT/2YCkKa/NtL3g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR10MB8068
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-09_02,2024-07-08_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0
 suspectscore=0 malwarescore=0 bulkscore=0 mlxscore=0 spamscore=0
 mlxlogscore=867 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2406180000 definitions=main-2407090076
X-Proofpoint-GUID: Xk4xtyIbAX7gP-pX5H7l5QPaBlZLOuSi
X-Proofpoint-ORIG-GUID: Xk4xtyIbAX7gP-pX5H7l5QPaBlZLOuSi

Currently we rely on the developer to add the appropriate entry to the
debugfs flag array when we add a new member.

This has shown to be error prone.

As an attempt to solve this problem, add compile-time assertions that we
are not missing flag array entries.

This should solve the problem that we don't miss entries, but we still
rely on the developer to add in the proper order.

Marking as an RFC as I am not sure if this is the best approach. And the
enum-related changes will require further work, I think.

Christoph Hellwig (1):
  block: remove QUEUE_FLAG_STOPPED

John Garry (10):
  block: Make QUEUE_FLAG_x as an enum
  block: Add build-time assert for size of blk_queue_flag_name[]
  block: Catch possible entries missing from hctx_state_name[]
  block: Catch possible entries missing from hctx_flag_name[]
  block: Catch possible entries missing from alloc_policy_name[]
  block: Add missing entries from cmd_flag_name[]
  block: Catch possible entries missing from cmd_flag_name[]
  block: Make RQF_x as an enum
  block: Add zone write plugging entry to rqf_name[]
  block: Catch possible entries missing from rqf_name[]

 block/blk-mq-debugfs.c    | 20 +++++++--
 include/linux/blk-mq.h    | 88 +++++++++++++++++++++++----------------
 include/linux/blk_types.h |  1 +
 include/linux/blkdev.h    | 31 +++++++-------
 4 files changed, 86 insertions(+), 54 deletions(-)

-- 
2.31.1

