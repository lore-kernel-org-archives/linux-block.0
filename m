Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 638481386BF
	for <linux-block@vger.kernel.org>; Thu, 27 Jun 2024 16:07:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719504472; cv=fail; b=OXgmj1nMrIu/w7bOgw40mtPEWjacUGimVTgrZhHzWwnpGPu2RUGP4qTzCIf8LW9xb/sUSYkbdOI8PnIfLIuH6TlnkzaUShKOdxWbKKhhYcB2ePuutHU88ngX+UMN72i9wpJRppDV1WmCwEslHm7MoJ4F40zWK6N9kIsxlW9Amhk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719504472; c=relaxed/simple;
	bh=6WkvyB3awcs85dofyJI4ol0Yq8K+olj2876RustdzpU=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=BKO76Rhzx6lHqQs7K1jTrChxP2ZzzaN3TNxbgqC/4JIcsy6tQoLUGRhUI4ojkpfdqmXQiCbiWg6ATpDrVoOJKsvpGwYIM0SMM2ZEa8YFTaCaeZK3xIQgnSfuMTQpjbxZpTfmdVtEp4mwXKdz+HvLC7bN9v8THBb1ywe/TC8PlSQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=AERSVUyo; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=JFmGNx2u; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="AERSVUyo";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="JFmGNx2u"
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45RFtWT6013779;
	Thu, 27 Jun 2024 16:07:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:content-transfer-encoding
	:content-type:mime-version; s=corp-2023-11-20; bh=vRd2DEuIM7Mz9O
	7GAqQIWeexTxPEEDZR+1X5rvj6RI8=; b=AERSVUyo70T7rnzq/Kp0V7qF205ltO
	f7uY8rWumsvuzw6+bR6gyFRbJL9lLr4PenEfpucd3PkasOZctEt4PmNjnvhZegck
	/1+Cjz1QPGthx24hG0qr4FbNTU6zXiWA8JOdQRRahofdhqUiHE7Ufc0JlPLe/J1i
	WT7otgHtY4rv8f6mvc5LB78CJ48tLCnmY01XWhSrgX01v/TjaQGF/F9vnArTxIil
	Dy8hhS7KvZl1W5shd9JFJ62tNWfWF9b7dM40e0U/8kOB1NoF1Wi2QIa8hTjb6RCE
	+y5EDQZslZCNrq88rNJJS5c/FrVLQ/1Q7V5o6H+L908REFYcdLkpLcvA==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ywn1d66kg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 27 Jun 2024 16:07:44 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 45REeJ8e037093;
	Thu, 27 Jun 2024 16:07:43 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2168.outbound.protection.outlook.com [104.47.59.168])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3ywn2b72kd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 27 Jun 2024 16:07:43 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Rait+xOp3PC7SG88TdBkFOaqhZMFwu6NkRXxbvksimMaqkcBEV3t5ed2JWQoovpOqoQA6RI7xx8GUvv4Kk9h3mnyW4SyraUV1BcaoogXxPdHBwiArTyAc+LX2dD6dVF0x8xK1pM4iWhe33LmkpgBXtxiUXppBIv/Rf4FqTnnHludvHFk/q30oTeZM5Ud3y8iDTnc3ejTnhqmMx1hhXO3Q0KuPNQ7lbNTzUH1LlS7/G4YakRdiUnniVZsbpyL+AxYZ7Wr67qMk0iGM6e2z1BnSDlC+sfMia1AonF9UdzinkvXHRdlm61cUwFrHDv/8iWl7f/M+KRvjsWUrgTebfo8IQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vRd2DEuIM7Mz9O7GAqQIWeexTxPEEDZR+1X5rvj6RI8=;
 b=HMkInEuuLZmjbZHbnqhUNGJHObDR4AiCk7n3l6jy37yuJsD27NUCryOgrDdk/wkmkYbV5K+WDHVUnnBg4rX1VXMMSK0LgdE/UMkwfAXUAKjhhgriI250FE61ta7iMK2MPCzpvGKeDmw3Pqu5xH8sZy8aY/o6vGo3fgGtmxW+XdnBOqW7dc3dAstbtkj2fnd64eP2+vagFG9N9e7kkCwWjK+QRI/2h+WAOlA3RCN4F6PsOl83rS8B+cfciZCKCe9qbUO/vs4OnXudqbUrFjZlD+o9Fapf/3BUo1hDByGa7GDQlC6KqBxJq2DAT7KE1sYJs49au9cFRGINX9tXp14HZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vRd2DEuIM7Mz9O7GAqQIWeexTxPEEDZR+1X5rvj6RI8=;
 b=JFmGNx2u+33NhNqOlivHsB9zH7XT+0WKzTj25HwZjGfab0WE7UWLfjMf+vG68PtpjjGYKFUZwJwdF+NQctQfQxf+NXndwCHTkhAK5CiUybxRKW2Amhu1cACZJEygtIk7oU8lsnCW320puvwoDxtRKyZBvpLd4iw0B+Y0CI337SQ=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by CY8PR10MB7337.namprd10.prod.outlook.com (2603:10b6:930:7b::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.34; Thu, 27 Jun
 2024 16:07:41 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%6]) with mapi id 15.20.7698.033; Thu, 27 Jun 2024
 16:07:40 +0000
From: John Garry <john.g.garry@oracle.com>
To: axboe@kernel.dk
Cc: linux-block@vger.kernel.org, hch@lst.de,
        John Garry <john.g.garry@oracle.com>
Subject: [PATCH] block: Delete blk_queue_flag_test_and_set()
Date: Thu, 27 Jun 2024 16:07:35 +0000
Message-Id: <20240627160735.842189-1-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR01CA0004.prod.exchangelabs.com (2603:10b6:a02:80::17)
 To DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|CY8PR10MB7337:EE_
X-MS-Office365-Filtering-Correlation-Id: 96b73d6c-c7f4-41f8-a6b8-08dc96c34572
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?qXuSsoAhNWN3puwT1ZRWJI8R5uCSkqsdtOfIWdUL4iZ0oHd9OG4ek0GyJ4wy?=
 =?us-ascii?Q?rlE0BtZ5JkS3XktbYd0wQ9FnuihOvstzO3Ogult79tpPeJ8kLchUHkmmhJUd?=
 =?us-ascii?Q?jSc80UJtxcMZRkXZ6yUoIDsHlSLpIskzAT+sdu0iPxKiGn93oA6rX1mRZ0ui?=
 =?us-ascii?Q?FmFWOYmo5B6ixkqyy2cXLZnDod/5Ys5/IG948X9sGQssYft9xlEPWnkctX0Q?=
 =?us-ascii?Q?MXG1Q3NHKXEBSt5c7NxQpJwkZ+mmGUqfDu6xigvOok7mld4WoQvsRjnUGA3i?=
 =?us-ascii?Q?7pzHR9gRBR9MRgz6Eg98+JiZlzpEJbQYmmp1i+r9IG2AgohapP5Cn5s4LJCE?=
 =?us-ascii?Q?j9AoP3sQqxWfI8nsIGrmr/ZnhnSOASXyl3fC0iIy30UVVhBygAevQ7waab1D?=
 =?us-ascii?Q?XxyN1MKWmMXM9hEMl43jPz5aDTeSbq3DQzza7fc27flnoWxIMW74TqBPLxCw?=
 =?us-ascii?Q?z94Dxlv/6Ffuw2uYl0LIUKpCUvh5VsHfqcGGgbahliL4PIvdteTPdX0zxxn9?=
 =?us-ascii?Q?FaTh4Bw0HOydl76/Q43W0lm0Mhdsq4XvHAuJnx/nWRmeZpAIMxIvnEnXGRv2?=
 =?us-ascii?Q?whxxv/ocaH0tUqKnMbMVMAS7Qgrp5RgQafWiYTkJ390F1rbvGyMRoKuaclVb?=
 =?us-ascii?Q?BtC5gRHCh2Dzy9LdcfKsBwBIlHKLGkUBSJjwrHbEfdkeLrcIlpnouP0N1NQ2?=
 =?us-ascii?Q?dZjHjmBuzYIauCirotDQllYttx2OZheofX9eitKpC5AjzPKWCE6qUBnCmNxO?=
 =?us-ascii?Q?BP9flxARYu8c+NWWj7N/j3E9PpZoHkTNa7x18AGrJX7bqgxH3UxDJYZbNWei?=
 =?us-ascii?Q?I2+2EVvnX4J99gwkKhPpYMgC0T5G7gIchhcDillLBlMZ+tOsbTtPDnHuJ8LL?=
 =?us-ascii?Q?2DEbFBXkqDWDsbmltTZ3q+Qg7VxfusRmI3tIzXXTSZJnOA5rmrWpMVizrKKz?=
 =?us-ascii?Q?8GTUdJ7W1F0biKFqow/nnjRo4tgFAtw8SBVygWDEo9U7+rUCDqhOD3dNFLje?=
 =?us-ascii?Q?DfV1SIQAcl4KF8CB5UIJEuKEaF/83/FpntzxpqRk/W/veEiyxCeWowdeCwFZ?=
 =?us-ascii?Q?d7kVzJ8yPw+k6S3I7GYJh/RQ3tZTe8zKA0FUCX6vcm+cdpDYFeWQzOv8K+Bw?=
 =?us-ascii?Q?VD9XMJuVwpF3R/ujuDpXWNZ9pivlrZqS6S2zfMurwDSNn6nSdNTDFlMHKask?=
 =?us-ascii?Q?nLqz2IbdKwJcDvEmp80gDC0Nux7HisGfS8nDqJyZgIft01RSEwEKuixMLuIF?=
 =?us-ascii?Q?ply0qn+nWA9Hc7PTOtG8Yq6FbK/fE/y2TZfUXDP02r191AQ5W580CL0VQNBV?=
 =?us-ascii?Q?DjMoFnY3Hr73MllNHcMaLhWRlfxmeRciNHAYyTrBUl2ABA=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?CVV4D+ITy09aJcuEWMkxhBegu6IjPAQ7GS+Z+uA35LFTvjUS055gS0IDe9eL?=
 =?us-ascii?Q?sJrsljKoDRzFhOsMqrHsPKAodTFc6uX+fKx5qC1tEZa7XcKMikJhcKhmBcHF?=
 =?us-ascii?Q?MfQ4ex/yyxiGRks+R8LVN5lEUsLR34lxLyfVArmhzKbXibhveOzhQjnJQB7v?=
 =?us-ascii?Q?fj6G2vMnBS72sf8jLKrKXCzR+L374G91SyL7F27cumdRbAFI8QtUWyR3/zQe?=
 =?us-ascii?Q?+NY09szjXC/OTkzKCJNOZR8GF4dtotsKcdvH9kh7AY7wixXb3vSoOcvG8Aqw?=
 =?us-ascii?Q?uhg16EYWTobHb49Cvo8YTAkOgv7UC0DZqho7H8Jqh5sfwmTLS/MaMRHqzSCH?=
 =?us-ascii?Q?TJuUYpNy1zI/UvBob9+aQPYw76zvD/l66GngGxoLwCKsC1c/ylBe3eAY3okF?=
 =?us-ascii?Q?W9adxOo1bC44NwG/7iZCDcrxvt2Jyrw550upL7735RbVeJJmF1ogC8wv5HT3?=
 =?us-ascii?Q?TH+G1M11cgP9THNHdTd+1jRqRHfOdLvukCQ4fj5qU+KXJngsZKADHqAGW2cj?=
 =?us-ascii?Q?1u/szI+OBb9DjiAleD3vBmnn2O0TFaRgwRWlOn09CIgnwwiPjP519mK0rIZz?=
 =?us-ascii?Q?t2PRMLgoKkOC9SH2HGDetrMHRoTY/waAEzsx47Z9ZidwUVlcD/apmi7DX+dZ?=
 =?us-ascii?Q?LePpKNiSDXS7tyP1aCzYDthSd3XYs2+CMl2/I2TLD/ti9T48iAR6QOr0xhO6?=
 =?us-ascii?Q?jtT7RoMYPtUdmgw8x7iDdDhwGrSZNSB6Za4IZg4hHUbxMO1R03OVTEvFyXri?=
 =?us-ascii?Q?59XNgGA2mPlJdiqCdxTQGONoccHvw6RO87EDrYSqpJ1joCjl5tOcCmK4sKBP?=
 =?us-ascii?Q?U49a7B2CFwLsQXrGmfM9NI9+HQ2qiHHTJlH61hbp79Gjll17qLYFJfZBGd6j?=
 =?us-ascii?Q?vwd+g54IiWP3q+r/3S6WYY7hWqI2NOLzgDziv2XsIfVrVwDLaSXb1/3Ihg5U?=
 =?us-ascii?Q?4BDnpSi61lnQWx09XW/UXcSOIuQj8DmBZ4n5i1udSeLvyQhvrs4lHglu9Na5?=
 =?us-ascii?Q?8m64X1ZDsq3dIbPxTrja+tDPnQ4uDqRcYvf6zl5EV+uYie1uID76nK1NQJim?=
 =?us-ascii?Q?rHD8NqhcKRl2g3Vj3GTITrTtvUPHgVy2Vx8kDNy21cgrWSurAII0ySF04Ndj?=
 =?us-ascii?Q?MwLCyLtEkOK0kCUIWTwyMm5D+ka9V63WJcnSKOpx+jCAqurqSo3gvMSObV6S?=
 =?us-ascii?Q?Pgso2N3bfkpeIxOMsit+Cj7GvcBe5bdv9BxR4ojGb6vkB4rdvd9r2rYZBAfP?=
 =?us-ascii?Q?yPbxRJnjmitr3s5lqlonBcnsEP35uYMp+Wy07bjYhBizaQivSxi/s7cq9AIU?=
 =?us-ascii?Q?+YcUyqpA1rGbsz451DcQG/IGbQ4fDsFkdMmZ8QoSTm3Fz7rU1E4kVIzjLHoU?=
 =?us-ascii?Q?WbElet4BFMITOMawyHYgZvJDRiME8Uc3eVt9XHDq0SxwfSgyTWJoHfPriWPN?=
 =?us-ascii?Q?xCxDZtyW7aeuvNZikuM/f0JPTS18nGBMJ1zJJd/X/0u2gy1nZHpwfwyytj8Y?=
 =?us-ascii?Q?KX/qLtpqdYr4nyKIZd5n2X6qzbIjwf3SJ63DKOoY2r8s9UGziDdtfVrd5u/H?=
 =?us-ascii?Q?Z4bjYh8zGA34K1A77tqX1ETVS9Y6rxqs4/iSvinbFoudmVrH+ugbAIezsAIv?=
 =?us-ascii?Q?Qw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	mz0TnrsmbOCR+lAgMGGxEx1UmJ/I7YkmPqP5Mi7TCFycHzu1HwGw4NNK7BmISTrY9SYZx6dZx1jBplwTVdVgzRF1qal1XSvLO4rwRqkq8pFa5gbysXNkzbqSVDN45B0kDRvqc4VpiCdFNZB1uA3Gv3at0AwPwtQ0Sw1vB/fbDyvzr7uF/TAWoJpfOX5yz5KGt0c8E3bo6/qF3HbwnPo8VaTOoIasHjEL3BVp49KJGKGBQZ2zqzZE+My0VI0ixit9va7fw2axPVIZK9ZnYSkMvgAmJVIfQIGES9ZpeGMUWFZ+jlG21hBZEtN8YYJTx5OmIJ4usmOzakzGm78NjYSujuqF6dvzkR20guifdk8TydnoOUKDc39ZHtNfPIfBSY6pyAF5P2Q1jr4Sv9kCuQV+kgedf/zCILN8DoFqL/1tR8XhdUU7aJHz/k0z5EqxgY2jscMndcBNIOnptmndAhxOzD4LPymIvETHnYi10zLoiZcVIfoKeviv4iKOs1juu2vW0P6dmtYvBrCaScrJLKiktReIyroUDZisv6WYm1NvmmehMsmwmpFQS2BF3sXfs1FlU2pJPAzGQROLGmIhxSYf6oJlpvykQHrTL1kRyXUvDRI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 96b73d6c-c7f4-41f8-a6b8-08dc96c34572
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2024 16:07:40.8949
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cYkiO8y0aGRc3McBtUWmrIYFVfG7b4tWFhyhJ7FYrBe6pLadtyci+VrR+Ui/6oeSuoTWf3D1ckD10K27CIJYyA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB7337
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-27_12,2024-06-27_03,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxlogscore=999 mlxscore=0
 spamscore=0 malwarescore=0 adultscore=0 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2406180000
 definitions=main-2406270122
X-Proofpoint-GUID: lXKTGhFjZQs0MkVsEXVBDbM3tNapZLZB
X-Proofpoint-ORIG-GUID: lXKTGhFjZQs0MkVsEXVBDbM3tNapZLZB

Since commit 70200574cc22 ("block: remove QUEUE_FLAG_DISCARD"),
blk_queue_flag_test_and_set() has not been used, so delete it.

Signed-off-by: John Garry <john.g.garry@oracle.com>

diff --git a/block/blk-core.c b/block/blk-core.c
index 6fc1a5a1980d..71b7622c523a 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -94,20 +94,6 @@ void blk_queue_flag_clear(unsigned int flag, struct request_queue *q)
 }
 EXPORT_SYMBOL(blk_queue_flag_clear);
 
-/**
- * blk_queue_flag_test_and_set - atomically test and set a queue flag
- * @flag: flag to be set
- * @q: request queue
- *
- * Returns the previous value of @flag - 0 if the flag was not set and 1 if
- * the flag was already set.
- */
-bool blk_queue_flag_test_and_set(unsigned int flag, struct request_queue *q)
-{
-	return test_and_set_bit(flag, &q->queue_flags);
-}
-EXPORT_SYMBOL_GPL(blk_queue_flag_test_and_set);
-
 #define REQ_OP_NAME(name) [REQ_OP_##name] = #name
 static const char *const blk_op_name[] = {
 	REQ_OP_NAME(READ),
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index a53e3434e1a2..53c41ef4222c 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -609,7 +609,6 @@ struct request_queue {
 
 void blk_queue_flag_set(unsigned int flag, struct request_queue *q);
 void blk_queue_flag_clear(unsigned int flag, struct request_queue *q);
-bool blk_queue_flag_test_and_set(unsigned int flag, struct request_queue *q);
 
 #define blk_queue_stopped(q)	test_bit(QUEUE_FLAG_STOPPED, &(q)->queue_flags)
 #define blk_queue_dying(q)	test_bit(QUEUE_FLAG_DYING, &(q)->queue_flags)
-- 
2.31.1

