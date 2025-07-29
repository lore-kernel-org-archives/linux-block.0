Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C26D514F98
	for <linux-block@vger.kernel.org>; Tue, 29 Jul 2025 09:15:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753780534; cv=fail; b=QLrzgKeQG1RrZq6L7EGisgPAd35aoTQln4GsFfaeaxD1FVfMZTIi9POLO8BG7paK79USAGzVBuzO1LHCz7gTCpPg//9ZaYmAYEBwCjO97HjSgfl459y9+y1alQ5h1TmD/lphSXc8bnu8J5wsC4MEUQ3BCmGGabfNJLBZai7Quf4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753780534; c=relaxed/simple;
	bh=RW0dGEYviSnkujCbKf8R6+EvdW+9rK4wdkp0OinErCE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=SFCyckl7rsQReSvHccl9gzrGaVsqyE3hhJ2kSDv4SD6v3V8uRI06UFmNc+7N4G45h++g9n1hb/L1PYrQyK3c0KOOSlQcSbgxp/W9m5BXnv7PHdJefSD8Aahsq0Ty0HiGb/tKWC5mMpegVIsnxU52v29tJJHqC/xovglWOjce1WQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=l/2a5+ys; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=E2L2cGuD; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="l/2a5+ys";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="E2L2cGuD"
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56T7fxCt029819;
	Tue, 29 Jul 2025 09:15:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=6ZaXdTezpgBcrxuk3h8A/IfWempxMWK2hSPziLTd1CI=; b=
	l/2a5+ys+FDXy5LxjwlvbqIAeB2GuR8YcM4Cf0Ihy6ww2t37mUo8uHFLzy0QTVAt
	7PII8lrk3/YdrrQmri/PO+PH0O+j3xPHvRhEiYE8RylfJZs3Ix2pg/ecvRxyeIg1
	LMBTMwzdQsEPxcai32pD4JUaVYU1MPWZfQNlE3a0mH2crRhvNJul92QTlrLDxTPo
	kkpX8D2uENAp1T3tWDstY2bzNXkEigp7YiOMTiBKoxF9bzdrvy3mKIQB7B3QxyMc
	ynihenJnbgJPafNp48HnWfmdH42jiQ9hQKgXi7g0Qxb187QRTBKxPDV49RW9wBLl
	gqhFRiPhtS9eLRPXzT8Cgw==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 484q2dye93-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 29 Jul 2025 09:15:15 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 56T7Nl4r002445;
	Tue, 29 Jul 2025 09:15:14 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10on2072.outbound.protection.outlook.com [40.107.94.72])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 484nf9pf43-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 29 Jul 2025 09:15:14 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lrLJlAdHDpdac5Qhduhh+O9/soQF1ba0iB6+SasmIYTC+OnqK9F/V992Y1bQ40J/Z5Sa2gCzFgT1Wq99YCpGcpnkU1M2mWkyAeLR9fDtfe5Fdnvq+dwSA6OV4J8gK5fQDqUl0Ae+q7NgWA0KLGwD19id7m/62nCN2w8Uj/BqDPamMx/8++Gdr74QCPxREqi024wB1PBIndqvq6m3/EpGwohTfHG8lXl5XWLrOaTggVamb40lPV8mMjyDBp/GVQEIYzirymk/DYmvISXRJWBc+T93gzZjYZphFyqnGmD1st7HAG0UX3pT+15wvhKF1oZ3uA+w/78cXPyTY0N6Ks6wCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6ZaXdTezpgBcrxuk3h8A/IfWempxMWK2hSPziLTd1CI=;
 b=kglIlnYZesKgb6b7mKj3wlqFHW+hIsdUgkiG9ThmT1oBPmutn+YE9C85YBDLE5j9iIW9JUMRak6uWrNKtVX1cUQ5q6wO1lum8wUHdd0mbKwR6oelXm4oRidVLpdoI5CQLGffQM0WT/CI5YOPytKY8OkyJeB77zvS5i4/w/Ek4jwHGmOr6IKj/cO98J0iIyoazfhO8tj/XSp5wzbkpgVoC8i1KRVXx2xOXvmG4PFXYvhPTCn8+T5T/qNGtuT5VsjHFdgutdE82+FZX7GjqZAN/PjXIsvjRIJ06YdoTD84ApBP63RXcAbttqaIMTf2ju5ES4HTeno+1vv5ksIzczY6kg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6ZaXdTezpgBcrxuk3h8A/IfWempxMWK2hSPziLTd1CI=;
 b=E2L2cGuDJ2ur0wrOIOcPEMZjz1QJQi3E2ok68JM5B48q3f3D0OHhLtX0zq6f7yOQyIDXeq3bs//T7r9spxDCcOGOp9OnHCEqs0PsqtOEOlkdOfa0kUe5Lwns+HKalQcsq4WE/faCBHcI/Y/A3EieWMLBHeBZsVofh/cYk86nQr0=
Received: from CH2PR10MB4312.namprd10.prod.outlook.com (2603:10b6:610:7b::9)
 by CH3PR10MB7117.namprd10.prod.outlook.com (2603:10b6:610:126::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.27; Tue, 29 Jul
 2025 09:15:10 +0000
Received: from CH2PR10MB4312.namprd10.prod.outlook.com
 ([fe80::fd5e:682a:f1ac:d0a2]) by CH2PR10MB4312.namprd10.prod.outlook.com
 ([fe80::fd5e:682a:f1ac:d0a2%3]) with mapi id 15.20.8964.025; Tue, 29 Jul 2025
 09:15:10 +0000
From: John Garry <john.g.garry@oracle.com>
To: axboe@kernel.dk
Cc: linux-block@vger.kernel.org, martin.petersen@oracle.com, hch@lst.de,
        hare@suse.de, bvanassche@acm.org, dlemoal@kernel.org,
        John Garry <john.g.garry@oracle.com>
Subject: [PATCH v2 2/2] block: Enforce power-of-2 physical block size
Date: Tue, 29 Jul 2025 09:14:48 +0000
Message-ID: <20250729091448.1691334-3-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250729091448.1691334-1-john.g.garry@oracle.com>
References: <20250729091448.1691334-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PH7P221CA0002.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:510:32a::13) To CH2PR10MB4312.namprd10.prod.outlook.com
 (2603:10b6:610:7b::9)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR10MB4312:EE_|CH3PR10MB7117:EE_
X-MS-Office365-Filtering-Correlation-Id: a9845f56-3f5e-4b77-363c-08ddce806ad1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?TO0CZ6qd1G4Y5MiV4+lFSBiuTXR4tkRPirs+bqOGZgyWfOETNk53DfNTtLXZ?=
 =?us-ascii?Q?CkVZpiZ95gyuSxGZFXweYjPixrjc+qV9l7YXkqjPE17NbIgCsHFtLJ2yakTm?=
 =?us-ascii?Q?nYrHK02addMeKbvDZD0L+Le1WFQh+AgkaSt+70gMs+70ammgopLQaSV2CWsf?=
 =?us-ascii?Q?/F4Z9r+TwKFr8eZ1hpng/Ys6h7MEd57BBDIE0gdR83utPfU/tT6bqsoQ8Tbi?=
 =?us-ascii?Q?3CxErWVqo1OPmzQgAGv4VkabmKRUnIhW9YVwxYGaoCVgHW6EZAst9TFcjAzZ?=
 =?us-ascii?Q?PlRXlcGPEfRbR+iMs/paLpso05r0X0XLKILRxrmJ4Vr8KScIgzxo8Co2TqU7?=
 =?us-ascii?Q?pFWK6N3kcn6s5c5snlwhNLNEpN8o8wdo06vmZL7uS2rShSPPOHdrWyxzECch?=
 =?us-ascii?Q?2wbCTZ1uuYpTL9RQ8WSZXpBGDJYPpdEmo8k1MQrqEL7a3PjCQgA4gKlwz2V2?=
 =?us-ascii?Q?uIDegoIGzAIYZgQMBNTpN64gg3L35vuCfZljkE2fklJyrX6hpmb6I9gpdtK8?=
 =?us-ascii?Q?6+7sixX6zA9f40F0eZwk+YiJ+9jZPqlFBtMFSF+LTfqzc5Ls//og7rcjyxBN?=
 =?us-ascii?Q?e05jYWDfipJoSvGgps1sapW3QCRryeHePtbKh/IEauQiQbglJeGU9IFFyTvY?=
 =?us-ascii?Q?CblFbV+f1tofw8hfDjCcHrc84wHB0pO+WO37K/l9WDAdJdXVvd2g3vuExI9b?=
 =?us-ascii?Q?AK1opfbdzBTp1ri3S278/b5O7/Jbjbh/Zdpx07HSi4dD3H4fnHGR+f3FR6V5?=
 =?us-ascii?Q?nvj4Lpa6SZyHgvBN6z1VP8KPgWRq7ln4uASWwOIAAlFA4Mi23vt5Md9kZ6QD?=
 =?us-ascii?Q?XZJeUh5ZNHFxJkFp40miPgFAmkFZS7JMq6zk3/bhslWUO5kFGpHBzLAZYOZ7?=
 =?us-ascii?Q?V2rJDuowgSm93SVvtaEH5x/FV5zD9H/WtpdrOZlBdjxTFTFz0rovp6xuK+2q?=
 =?us-ascii?Q?T6g9aX++ySR78Bnhqgf32iakqvWCAJZ19DiZUtzm2nyvhUEFgkcrVGDSmYnL?=
 =?us-ascii?Q?zhdwxc2KmpFq7GB5Ky8p2UrsbtlWyK3L1smnlwFy4N/nWnq6EiN5ycTePYVb?=
 =?us-ascii?Q?cEDt5uIiQLIVImQjZbRXS2Zd9Gy3HIxeOfLXy5fresPOzjmp1uU2h4YOWSxG?=
 =?us-ascii?Q?XerDUoObUwp7d6zX8cL2fdmE+/LrfK8v3xbwsk/ieO7DdJtROMfwbD8qDE3e?=
 =?us-ascii?Q?zB/v14r15KSjRDoFnazXNPh+O7723seWQw4miAv0JbShEwylduuxldQ3IUsh?=
 =?us-ascii?Q?QSS+SqpIr7TbrJT/7+CWVU1DvU2Xb+HZtMxev1CofC82e+ZEXlxTVxWtJo1e?=
 =?us-ascii?Q?cidq4kd1coKgljrRRCHHQMlFNgx568rcrx9iEv9yJbi61MUXXO8nnCbnkMfr?=
 =?us-ascii?Q?ROKKsBYrp1dEx9nzIleofC2pb5HeTaj4d2skmWCx1odmoN/WuZutGjFiheb+?=
 =?us-ascii?Q?DDrO1hCg2hI=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR10MB4312.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?9UUM+XgePQSUae3e7f7I6FjD/AyACEy2HwJ0UuFyHfXqZV56NfIFgb7iap77?=
 =?us-ascii?Q?iW3DBp1gw2aKtkwXiH1Fapdebp91ZmPRSktUS73YTTO4p2ZHnqDBWQgrXtZq?=
 =?us-ascii?Q?3PmOkCOQzX0K4lKWg8OV8N+1sKYlUfYwXmSVKFSTK1pAPCGaTck8Fe4htjAW?=
 =?us-ascii?Q?IIT8AXHVEnaKJLi1HE8/ryj/gELJIc8wJMNj45Gu/gCKAzE89DIA3KlZAfhX?=
 =?us-ascii?Q?dqT7ip0DxBxXQee7wdZR39LzHV7zzvRsaj2NUFplwKPeKEfOrc2bdkVRAUmW?=
 =?us-ascii?Q?k4NTj5T/4zfIJcl1eGswAYZYvUhZIeMlVBuxJuSNrZEgQ3ntluRgDHn02zBS?=
 =?us-ascii?Q?kzXsG5i6iyz84r1qLS6nGN/4WtYUgSn35D3IbOvh2HKLeUhWYCnxD6iKdbZt?=
 =?us-ascii?Q?cC/KoR0kt0rAOFNdsMBZQ9l186MsVFy6C+p0IqU7CfLoOirHa1D9N5ZYwCje?=
 =?us-ascii?Q?LiWqb1eL6FN8MwcJx3cv+rS4JCDu7AKtOFsDH3ikcqujg9L1ujDUe/kkfFmj?=
 =?us-ascii?Q?2EcsLv7XMg8pCShnyb7OIWFFP5f+ryza1N4nOJnK0lWYVsCeXWcUiwlfzy6V?=
 =?us-ascii?Q?lwQ/6/1AcqFvkeqVv3yCR5VUhjgBg+WCQ+Qb+ICmmNRABj1Tnp3Plt87E529?=
 =?us-ascii?Q?Wxt8z3qAJSaX8Xit/OUA3l+xo1puO4+X1Ll1WtMp9ez2W9tx0Hu02/SIWEnA?=
 =?us-ascii?Q?5EJX4kZrzTWhQeGPWLsIIptMcFt2Ix/QZWguCf+dFmVbgBUFFYyrKs8Sc1zE?=
 =?us-ascii?Q?zhy6FC+cu3+N/a4/mLS4nn/cVCX2MqOVitchhtyEehvL8oGYqj/2o2qKRj+y?=
 =?us-ascii?Q?EmbWpbFV4q8/0ftv8KE/Hr/zH37eT5jCBEQXno7CRXMBcq12rQPyocTVwCWH?=
 =?us-ascii?Q?QLOv4m83c4p3Ubjq+OVtSy1nN+JfRUgudbvps6F9dKZYhf6q9PZ5FjzoV0S/?=
 =?us-ascii?Q?Mv40lEE9Zy8O/qHuwHx7zbNdCT6sXrgyuRCqA3GZFwjd7Kz0uEqweHActuyV?=
 =?us-ascii?Q?UeEwRQw2HjQQyF9nDLS1vc+M/ODgMzmXoDdyD3AupXgz/xYYC1B9U8V8y5f6?=
 =?us-ascii?Q?bfTnjv5KjqZzDMloOvTyg3bxKqiTfcI11/wrDKzqmQigTHdDEwA1YD0TzIs0?=
 =?us-ascii?Q?/NjtCJDPQTXych2pFtcwr2ByCuhpF4QlwazvXWEGwRk3TLxX4c4iESnSj7VE?=
 =?us-ascii?Q?C9LKOECcievTHK3SRQtZQ+KZdcAMD2OXN+3+n7VLGdPZ0g90gDAAGEp+CBKX?=
 =?us-ascii?Q?W6hQgX64vRFvV/HqFQ9Vf97HRoMT81wGYoTnVrUt9LRdY1vgRATjGxGpCXOJ?=
 =?us-ascii?Q?uxweWflwORFMlx7biNA7YwzHxbxz71ezHC7ZfC2pymkPd7qnyQOcOtXzdGZe?=
 =?us-ascii?Q?62peG2H50A88KRpMzaW6YGwQNlymgJsKHpamONHTdPOxiwd2rcHoNe24CuBw?=
 =?us-ascii?Q?ggkb10xyk++uQwLQk2PqVdDvPcv4r7tWDcNe+M1o7kdrs5R1F1b2SZqO2LeO?=
 =?us-ascii?Q?QaGgKgN0eS3zs4u+mW27WmpeJPNR45EKrw7q9ud/mkSTi1MANjat4vVAqtSo?=
 =?us-ascii?Q?W/Hh56MjE7vNMVR8Fk9ChM06VbeWLXr8Ff3z9HXERC9X6FNBlNn2qqUteq37?=
 =?us-ascii?Q?DA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Ai7/3jahTdE2yBnkdncg9qKA/kmo6nPKWJhi4M+y+bDYoYnV3XjRCBrwvQ7S54NASgfb/Sx7rRexMIZbL1IO78+JUo80vOfS8M8/gnhFYa0Yc1c8Xu9nCtgQ01fahBC2yfLNUhJ/g2Yc7VYsJDMljt5UqrJ43PSJzi7sP1rWf5Jb7sLbB+YZX/a/ntKSDzU0gIhujcCIjZSMfv7JnRQ3e3EyvV+UU2nToRgSEUq+CfuUt8c7WHFe8eXbkIxSZLMEoIHihg64GzIzpPUoSEu5CZS3w2gOsHHbLkZFAtwV7CdDdtsTw0bjf0UR4RO+Qkno04P9D30awbr0EuaKQBSz+X+Bl5xnje+9mPlQsANEn5IwARu20Tr/yHzw4JVwmC0KigdGw+djiwgcxgHa9Qcr9DJowxGGTPVrfBLFdWa6U8L5iCnWItKX5VvxzINDcVF956UUXDk4OS3mnBTw1jO1hXGSfOvmNCcYqUsxDkAiwi4JWk6boks4ClzNLH4d33SzUdOYhmy/xkTvkeEt/Iv0yRKRjFijn1r/ZKrjo0w6nznUE0lF/V6Po+1xxwAPI2Yase7bujdxUJe2ms7shIVBWCl3DLAFYRglIo8yyOiW9Wc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a9845f56-3f5e-4b77-363c-08ddce806ad1
X-MS-Exchange-CrossTenant-AuthSource: CH2PR10MB4312.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2025 09:15:10.1341
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oTB266YWs0wW9Zx//yuHONav92dnycPyBi7GzVJNx80vvyevlWu7h68UCRsygqY9kmpXYYxR+hITlgVlhYAVog==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7117
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-29_02,2025-07-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 bulkscore=0 spamscore=0
 mlxscore=0 phishscore=0 adultscore=0 suspectscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2507290071
X-Proofpoint-GUID: srDrUO1m_bnyZYY5FWvjcW25PK80kh9-
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzI5MDA3MSBTYWx0ZWRfX7uIfykWkLIFm
 fch8yVBPv0GF5bGEqicNFJGHQKxidYQmUgiC5IMbE0wehulcsjklFg5yrRIootMHetoux0VKVXu
 UT95WUZHYFaHxZkrnu2rqE2bXTfb73OU0aTSISEYDTiFgWgXDZiC/FWF4W/GbfuAh3y8ojMucp9
 hKXkvWuhydNrTGh1wi1KCU/hMCOJhnT1O0FCli0OU5G9ZEzOxXJq4KiakwsY+aR+BG4rnGyGroC
 5hSZGiTNy4heR+OActtUbmYes1/Ga76fbXMVe+pzykkHodTSv2f/nIiXZlQwHyFZQlWyHo+NA+o
 szhwzMs1kCfSX6q+WeuagwEHstmJbsEXKzimwfuz+Rsro9E5g7cEGBxqZoInADoEEMoMAa8Jr17
 Ldj6OgkUthVvVRMMvc8w9f6QRFUO9fMPNRsFdULH/sxdHVwfVZxq7TJKxDOmdWvEmkW36CAD
X-Proofpoint-ORIG-GUID: srDrUO1m_bnyZYY5FWvjcW25PK80kh9-
X-Authority-Analysis: v=2.4 cv=A+5sP7WG c=1 sm=1 tr=0 ts=68889123 cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=Wb1JkmetP80A:10
 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=OayZC_GDeSRJYCvwa1gA:9 a=zgiPjhLxNE0A:10

The merging/splitting code and other queue limits checking depends on the
physical block size being a power-of-2, so enforce it.

Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: John Garry <john.g.garry@oracle.com>
---
 block/blk-settings.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/block/blk-settings.c b/block/blk-settings.c
index fa53a330f9b99..5ae0a253e43fd 100644
--- a/block/blk-settings.c
+++ b/block/blk-settings.c
@@ -274,6 +274,10 @@ int blk_validate_limits(struct queue_limits *lim)
 	}
 	if (lim->physical_block_size < lim->logical_block_size)
 		lim->physical_block_size = lim->logical_block_size;
+	else if (!is_power_of_2(lim->physical_block_size)) {
+		pr_warn("Invalid physical block size (%d)\n", lim->physical_block_size);
+		return -EINVAL;
+	}
 
 	/*
 	 * The minimum I/O size defaults to the physical block size unless
-- 
2.43.5

