Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D3E91514C8
	for <linux-block@vger.kernel.org>; Thu, 11 Jul 2024 08:24:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720686250; cv=fail; b=qMxwph+uBYnZyvB53KYYpQWI75glN3cVbe7y4OxsckwmxZ5c5GOxcmw7UYDAR8kpN+m9uJieNqPZq9cIy4rXjsJdOZE+ylIiFsti5+x/gdNrloRV9JaxYlmRl9gLaDuhNIh94IKVYP7mWA4xpBaYkoP0nyIoHVFLVHTj6MSOqio=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720686250; c=relaxed/simple;
	bh=s9WYORsqys1R9bg6nBEVAhsqoi4yPt1qeaSszqfjDHI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=MkdarVmipV1bGXzOczf3lEhn+N6ri+WTnPSEe7I5g0Kdm8adCvuKiSDh+0HLyAkJyU0Jn117ioo06YWRpkUL7E1PJAevt27k38gov0+HbINcW2+Ob1jSzeVmOT9rA+j1zBrStTEiUuNVyjBnK4Kkli7Yu4fhSkp+JuilsGxoo98=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=YUIfjJ9Q; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=FJQD4U5l; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="YUIfjJ9Q";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="FJQD4U5l"
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46B7tX1d011771;
	Thu, 11 Jul 2024 08:24:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:content-transfer-encoding:content-type:mime-version; s=
	corp-2023-11-20; bh=bhfu50rABaNzyXbydtgUtu9fAssH0KemcghAlnC5wfc=; b=
	YUIfjJ9QhaKl+MsY2ETV9P5EjTO5AVDYd0FOLtDO4lNtYN5SnG/oXIhs4jtYBwKw
	lTps82j3sVKCBOafMM8U+Rup/+pSy+QaBYhQ84WW57Jcz96IOyEakm8wI21k3nzz
	CdMNGxFmSRLjd328fSUavyujWFjfcTcVGOvPhyuEr1H6hKFj3rrolM1rKuqweva6
	EmYKQJk+fm4p98YX90rrNnGtutI9nvRBPuyFWN+Tsx6SFOnoh2b/UEyMx0y+IrSL
	a7m7WnUCYeV0kziDL3COxQcBUAoPKDk5TU3zTRsR1llKO7zao5hcpteNTK98fmfD
	LanQlbiWVNxXq6jcsO7kdw==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 406wt8gywg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 11 Jul 2024 08:24:03 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 46B7Ctfo033754;
	Thu, 11 Jul 2024 08:24:03 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2040.outbound.protection.outlook.com [104.47.70.40])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 409vv1wsjr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 11 Jul 2024 08:24:03 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bX3zL+ANTgldbJQNyGKwnEM3WtNz/h2McIA+Abr7yrtttUAEEfvY25OtF8MeimE9TGiBdzLsCSV0iWLVKp6nANeb2Tz+HDps/Joidv+4n3gxtHhu3x65yUy5d5iYmOmBZPX90OifgcMBphnxMPGd0Dbv1wc7cdD6GmWC8vnRQKHdqOvZph51OSHLx8J5T40gvmRE6BbWvw7vCk6HAkIBuFw5hSiG8jkRaZWiCANlr7EpMXgb9f4bRz+Bg8HF24336DG5AYex+o8HYOsLt5sFhZ2XSjQXEqmr30CPCX9fU+Dyw48vynEvGqszBPrY9alq1j8auu8x2XA9SXVN3tXa+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bhfu50rABaNzyXbydtgUtu9fAssH0KemcghAlnC5wfc=;
 b=nVjBby+ezdtXcj4ZUbz3hlKj+3ZsX9RUVaUE/drs4PDGUZOlGGN+nXpgl5ry/XlOucEGZ4TTYIfj6XwBNJYeVxEag4L0LTAYE483b6kAGc1o8hbjCjL6qvrmEXY0T3OLT2u0GwpSusGZoniHiUZKe1RFbzFtk1TN9snebiao28w3dfYfiFhpdGkDlBugH7Hqyz9wIb1k9EtYJ945H+5/H2Rn7GC31JFjIiH9LX43JY59KeD6OWMhuS63j9A/ALmeWxJnzkFcsNtQ0L2MMNBKodd6g2xgdKwbw9UACBrvJZvspgIUPVmtYJDc5MkdvmR/NXQlG+F2BABIXu443lCriw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bhfu50rABaNzyXbydtgUtu9fAssH0KemcghAlnC5wfc=;
 b=FJQD4U5lAvT+/favlop0nUc8qWYGQWvOpekKZrgCMeZ9EbgX5aQ/sudAzjYzYONcJwpzrGbBoqbt8l9fv7qn46wF2ismZ42/mtviZUq24ATpxGZElV9qBjWQAW74IcmBaYvIO5Qlq+Hyck32pFvSQYWYlEvZz6sgo7GERLEkp54=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by MN2PR10MB4190.namprd10.prod.outlook.com (2603:10b6:208:19a::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.22; Thu, 11 Jul
 2024 08:24:00 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%6]) with mapi id 15.20.7762.016; Thu, 11 Jul 2024
 08:24:00 +0000
From: John Garry <john.g.garry@oracle.com>
To: axboe@kernel.dk, hch@lst.de
Cc: linux-block@vger.kernel.org, John Garry <john.g.garry@oracle.com>
Subject: [PATCH v2 04/12] block: Catch possible entries missing from hctx_state_name[]
Date: Thu, 11 Jul 2024 08:23:31 +0000
Message-Id: <20240711082339.1155658-5-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20240711082339.1155658-1-john.g.garry@oracle.com>
References: <20240711082339.1155658-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR15CA0065.namprd15.prod.outlook.com
 (2603:10b6:208:237::34) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|MN2PR10MB4190:EE_
X-MS-Office365-Filtering-Correlation-Id: 6d780f58-10c0-420d-09d4-08dca182d12f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?o2EbvnByFF7CDlm5FDxi+aew2HFHILmU0xUvx6XdEt5bFh34w3nX7GcAZEVo?=
 =?us-ascii?Q?DfsWsxBx1ZbE9u27yFcC41th0RDn8s853H0X+Mf71oR+ETZTA2xGhDCA//OH?=
 =?us-ascii?Q?JWJNudBB4fTfuGLCW7VePVaqzM4IgCVg2NGUR8ywdVqdP4BUzfgRQabWZa42?=
 =?us-ascii?Q?agswNzFK7+D9P1moR9iqSOzyH8+6uTh6K9hMKPpWrB4m5a1iBoT+srPLFYvg?=
 =?us-ascii?Q?7VNM1NVjV/fXGoYSk5VkEjIrtaxt0dOZHZsbw3O/v4xwmQeMFkSiumXHC1zj?=
 =?us-ascii?Q?TCQe12oer3j+ZjyHP8LprLk/MCCWpEOA3WYNYQuw5FM7REuJ3JYoltpcyOSL?=
 =?us-ascii?Q?iDcs4HCDqo5yYds7Bvon/AG+R4GUolf6VhIjMtmo3XMgVWupJL3EHcoxM7Q9?=
 =?us-ascii?Q?jgCmV32wph1wpMwsSUBP0/0Rr4OLRgTQtW9GhczSgWVPaLAbp1JZQf1L9Ulq?=
 =?us-ascii?Q?RdI7oHYizVTjMhTcq6LlcluQDCJuV3Jm3JIPe/OGSsrc8a/TUE+OMWwx+YHN?=
 =?us-ascii?Q?UzbZEjJqb+3G+CbeP8W/QavJtcLBq+UzAYqkEfXRoBZrwfnS+Stnaj52NUrJ?=
 =?us-ascii?Q?WZhLrfbWM4JcYrHA8SQYXveD2aApzZ5cRG5d5xYobxCjV9hw2Uta8TZQOi/N?=
 =?us-ascii?Q?9+eGa+4IAC1NfqLMgCnaIb9rz0hKXYuMzcXxA6OWw+ncakRfBxjrAku8W+Ge?=
 =?us-ascii?Q?lJfE+Ld0AXzcV7V7Keq+ky3VhhcjMPE8nMYX+MQiLVQ+O8EonWr6wdfXAXiu?=
 =?us-ascii?Q?RWLKIoqPnNKF7RujhXToM6Mrjh54HkwjUMKHt30NQrdec/jtXDsHwxf60g94?=
 =?us-ascii?Q?dR+BYEVq/DXVAtftHSdknT93P/arPEPGF0QmUhbcqrvQpTBr7YCYslSxLdnV?=
 =?us-ascii?Q?NB7u0NVWMnwweI5DIOD+M8ndYFyQhAFTJ2+qjDNIrw6jZKkYtX2eomUIaR8r?=
 =?us-ascii?Q?dTZN3JTBaVuqsuGtProNdSnxVWiSXfuOCYGWhJuldEWy2U2CW2SkMqW6tF0q?=
 =?us-ascii?Q?N8ii+wu2C570g8SjKUHHVSZUJf48/UMdhbq90gp9M3+tkgNBdA2Xr5H/fBm+?=
 =?us-ascii?Q?qrykU7g7HF41pivLU0EFnUVm0UbPozEDxmfC5lWRkUvOt/laRhCJEnG17KRD?=
 =?us-ascii?Q?353lv9CBzs2uUqvpJpGVip/esQf8/dMtNn2fmUqLuuLHL5Z5Fea5nvhfMK4u?=
 =?us-ascii?Q?oxVoVw6+S9Zgz5iwlfef/iJI6glpRoIoQCdQ2ckmZVKWHovUF8GgL7v4Lc4S?=
 =?us-ascii?Q?30DssrFKy5XfaQecv/OtEuURXUdSuffI4ZJLf0yGrA2j9dpQOqWXnqZA6v4/?=
 =?us-ascii?Q?LFgsJnKXQIWaklp8IE0rgZHfojpxPYDU8W1koEmylMMbUg=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?aXqTRXtn1LuSD6D+gic8/xYgEZRHU6a8eN9yj2T/AZlbaGOkbQRnMliWt5wr?=
 =?us-ascii?Q?gAu5qDFE/0EFHpZcrBpeul23FmwtQx9XM7ikO45+Vnh8dd9FERWTPwx+/H4h?=
 =?us-ascii?Q?ZCZb0BXlBFv54Ic5wwErjgZdd8V/ZCzY5pLbsXhlZX29VIWcpv/lsL5oKc0N?=
 =?us-ascii?Q?rIljcWC3dkGyu2kFGMFRj5yWhbE46w9RoIESES9v3lONCFxsFKUi08vduRUQ?=
 =?us-ascii?Q?+j58AH2wE+rq2hTYXwh3djy+Bg3z4DAEjM2pdxEceuiYDZmgHEoSwRWpC1KB?=
 =?us-ascii?Q?8sWQrNOn/lqfLl3dUeZgi7RDZV1bxOrp3ukYbmCOzdmRTBrkh75qrTrVeY89?=
 =?us-ascii?Q?CNDIUzGWytjDaBiGzw1bwIgobDos8Ac63ApnupoE2cPMO5ffafhO+985j8Qt?=
 =?us-ascii?Q?s0rIBhi5GsngX3Vjfws+tN/zYAaXeuzMzafBjrhBu1PW44ZXNlM/tt4R30Qc?=
 =?us-ascii?Q?RTbHNut7lDDm7pU0tY93SpNcE5aKLGRuDlmct6WSU09SJXwMUoH4sxCeHumf?=
 =?us-ascii?Q?7ChB/VzlYEWz7D4vMEyighID0XOECaxOEYJ1DcozrNjuTjXLqX13+7cGhm7g?=
 =?us-ascii?Q?LeCzE8d+gwLbfv94YS4hM8aI6AIaa5YHodY9A2bXgIIsZNLLmItqWqMSlZjX?=
 =?us-ascii?Q?yUweoBCMVbB4IBUCNx3ZllxIjlrRflIUUW4jWp2R71iFOlkgw9kG+qZRrrY3?=
 =?us-ascii?Q?+m4dAjp2ttMs0vdrVQi86YWT+FBZVU7oNtcFIL6ZmrdzCqnsxC1ZXctp/9xn?=
 =?us-ascii?Q?CKKNHklGGF+MWJcrKEM3tPeuRDkvdzi1Y2v+ytjRRECdDmB9/O546raZM5Gn?=
 =?us-ascii?Q?//rhYcDXBfOG0QMl7FHaGHq7KEzScCm1T0rqzBBhZVPN+JCT/IWo5zfX+F5T?=
 =?us-ascii?Q?m06G0TqeSLXR1KXt4Y4WqDYZsmXe9gkSbKydv3zXWrfv1XUhl5XI6fDxahPE?=
 =?us-ascii?Q?JhYk31nm0QVVnO7a1LwtyZb2f00USAyd9+QV0sK0fl+VTuAkLFY9IRn8O6Mh?=
 =?us-ascii?Q?ROuS4WW0oZUAAOyVXKFi9ktz9CZmuuFK0nQHhJDzwJCDUgsJwcnSl0wQIceI?=
 =?us-ascii?Q?qEuL2hcqi6G+XbgYLjfsIh9W16ZYardIw2BdrHgOx4lBNf6DOzNHdcvulki8?=
 =?us-ascii?Q?nv/FEGnEtj/734Z9+TUAwdNQ56wm8Z69+cvvghbaZ8B1iZb9+QxRTIidaE4A?=
 =?us-ascii?Q?TGCZxLZbmRmIbV1o8tqHAS5oPqv5bf5PL4gKIhTCJoFiMTq1lXumf51FXycN?=
 =?us-ascii?Q?ZsRoSFgDPcXJ/Xy25f5ymc0Wod7gvY/AJx+Ciex6MA9ZgfEQGj7vfuRABU0p?=
 =?us-ascii?Q?RKzVMr9x9+dsFq2hLeA2nCMiumHgFUjVEA+WUNBvhwhiCp+q1JMdclPwZQSj?=
 =?us-ascii?Q?zerR2ZQXbOhnfNvAlkgRmhPMYXudKwPpJe45TCEwBeNnrRIqyki6UB8szeqv?=
 =?us-ascii?Q?ie6Ebebae+ndLhjlOYJ6Co/58eBUNg1ljygRKrPCzLjNIHy5RDmAk2qOkOwd?=
 =?us-ascii?Q?+QkltGk0SfpLEiVL8qetqCEN8Oum936FMRTa850Fon9sWbFcDGGX4RL4yEru?=
 =?us-ascii?Q?vTt/jTHj84S1rqObzly5JVd65SQMwHT/FY5AU3eXNsaYZmFTLujm6H3OAV8D?=
 =?us-ascii?Q?+w=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	9TvO/46eBmrSoQzlAP1sEH2rIDWvyRBudCVUlMBnLER/tYMpp6GnEktcLm+CILkibSL7uAGA1m2dIzDzhYUH3uKu0ZcPdzdrbkJqDvsD8IBd6D7VlChxD813Gq8X7P/WpFBQnFSGS6QOlnsLnF/ER8KCXlYUGPagbXlRbqGVtacs04fO89rNGXFpTtx5UtknUyuceClpDKRPeK+9r0ptmqnKkJ4liPOBxc1/5xETwCiY2FCT1OQvNzrLnnewNp2ntwd3gCDH8KaYBO/X+uWKpj2np8Yh1HiJLboP0sb84v4bJeg14S2sJlqca1fwMiJW54ajJBPy3bMIuHwb0cibPCg0QzWPIl2zCIXYWMSH1J6Z/iMHIvXFhgrpH5Wz4QLC1cbiBEskqZnLKXQW/TXAi48mjEOtPIJoZlKbCERWBjjANhlyd1AK0z2vgrktLrHtFM8VpcwptZRewugciSYm1h2OdVWzGzt81JhcOZsTrBT1pLR09ix4k6XxwWQ14fBvrGcc6oxEs2TO25rISSghF75DcL3ernM6uzsfd+2OQHQWbltjRAjYhZeEiM/Zbb77XERSJXqOt+fQp9Uo7yqudH228KJCSLqU75+x/Bnv3TY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d780f58-10c0-420d-09d4-08dca182d12f
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2024 08:24:00.8112
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZZjpn1v5UqesvGw/yC6TJv2YRT5LhuT6QbzI/FixTBeff6p547wWI66FcVWbCMjvtAyDSIcxiB3DtdK82gf+yA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB4190
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-11_04,2024-07-10_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 mlxscore=0
 adultscore=0 suspectscore=0 malwarescore=0 phishscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2406180000
 definitions=main-2407110058
X-Proofpoint-GUID: C0Hms3Ds5j6SmFls6PmrDXZ4Vs8h1ZxL
X-Proofpoint-ORIG-GUID: C0Hms3Ds5j6SmFls6PmrDXZ4Vs8h1ZxL

Add a build-time assert that we are not missing entries from
hctx_state_name[]. For this, add a "max" entry for BLK_MQ_S_x flags.

Signed-off-by: John Garry <john.g.garry@oracle.com>
---
 block/blk-mq-debugfs.c | 1 +
 include/linux/blk-mq.h | 2 ++
 2 files changed, 3 insertions(+)

diff --git a/block/blk-mq-debugfs.c b/block/blk-mq-debugfs.c
index 9e18ba6b1c4d..fca8b82464b4 100644
--- a/block/blk-mq-debugfs.c
+++ b/block/blk-mq-debugfs.c
@@ -165,6 +165,7 @@ static int hctx_state_show(void *data, struct seq_file *m)
 {
 	struct blk_mq_hw_ctx *hctx = data;
 
+	BUILD_BUG_ON(ARRAY_SIZE(hctx_state_name) != BLK_MQ_S_MAX);
 	blk_flags_show(m, hctx->state, hctx_state_name,
 		       ARRAY_SIZE(hctx_state_name));
 	seq_puts(m, "\n");
diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index 89ba6b16fe8b..225e51698470 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -664,12 +664,14 @@ enum {
 	BLK_MQ_F_ALLOC_POLICY_START_BIT = 8,
 	BLK_MQ_F_ALLOC_POLICY_BITS = 1,
 
+	/* Keep hctx_state_name[] in sync with the definitions below */
 	BLK_MQ_S_STOPPED	= 0,
 	BLK_MQ_S_TAG_ACTIVE	= 1,
 	BLK_MQ_S_SCHED_RESTART	= 2,
 
 	/* hw queue is inactive after all its CPUs become offline */
 	BLK_MQ_S_INACTIVE	= 3,
+	BLK_MQ_S_MAX,
 
 	BLK_MQ_MAX_DEPTH	= 10240,
 
-- 
2.31.1

