Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCC6722B584
	for <linux-block@vger.kernel.org>; Tue, 25 Nov 2025 16:11:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764087099; cv=fail; b=ec8HuPeUP4+tNJ1FcucJhCqRWhoziafZ+Y+sCk/C0eqZHxndZFr/J2er22RZj9fFO/Q+6XmFK+Ioo4yfVqx9i2r2wdWHytDT/df2kp5+az22I/SDu91yDD0T5n4De5jW2LHdJ0ww2gRKHj6IZAWF6ww+yPfnxNSxhO78ZGnEuKQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764087099; c=relaxed/simple;
	bh=XbcQQlq3MDPo6B83qHexhQTQbWNLdliFYja+adsDvcs=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=ok6bn4MY8QSlezXuu3B8H9rg2L2xl7uk0IWyXCOKryPSoaz9SPELCQUGF2bp+qDeS3H3LM8mUgYHrmwpKMZYn/wFT1KgAelQ8DjT0O2BtBIWip4Wx+q/vFlLmTJ8QEVu1+BJ45EjABJusq9/+NPYfgnK9pLL3G0RM6WUSRzmtto=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=XCkKYzUd; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=VUaB+ly5; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="XCkKYzUd";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="VUaB+ly5"
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5APG7gCL4040912;
	Tue, 25 Nov 2025 16:11:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=corp-2025-04-25; bh=S5pPY5pFzRr5RkRK
	Yt+0qS2LpIP+ckiVY2Knm/nUdFg=; b=XCkKYzUd0mJxFicMdgG2FpuLPS8m6ywV
	ISru6woAfT5eW5l3A8F4TQyw2Crc8Wlkev0VRup3AzI3vOmB3UM9lPEo9sqxh/Il
	nQckl42edHVgZ0kr5Njto4e1805Qcg9W1rtiD6Qc/No2qmuD9Z4KZZhDtscMXRRa
	1SdgVGKp//fLKTOlYLzBo2BYSVBQwRAdIV8eAoPlV8TDuNC/YOQlM8RZetkdkKo7
	olfUg2CUTogvE/4V1bwt24/HDgG9u0xconV7DvK4kMinawExGCyU4xxMyJGlNPlN
	8yVK8dlfGks4d6M+yAcH6uIZhEdlrJFKy8g3LmNbNHMa2rpSQIbOrg==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4ak7xd6aac-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 25 Nov 2025 16:11:33 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5APFWhWB032084;
	Tue, 25 Nov 2025 16:11:32 GMT
Received: from sn4pr0501cu005.outbound.protection.outlook.com (mail-southcentralusazon11011056.outbound.protection.outlook.com [40.93.194.56])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4ak3m9q2xs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 25 Nov 2025 16:11:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yC1ViDmJdc97s/JeWiFSJvk72A/vgIzxCrKg+r8c4SIT7nB0ss/8PGd7Q9KipG65mAlKQRj7lUq+sWWUqBSmE2Mj4ckK0mtK8fAzu4AahMV1SYhoeb3FPv4dlhCJU155XVY/lO4BljAEXY5r6p9pzPM00I0tndFQS3NuYAmRcz2nutxOPWx6GxxmtLy6flNIz9locYOr9Lf4B8YbvF1upGOBwamXGVq5Sgivx6tFSntqVGaieDXZSCD4mS5fVrIV5WMIsgZg7CuZNowEFC2eiZKNkNqKhbPC0IBFHMQ8wpvtcmDatGkrShxIAB+HSFO3sqbDc9TXKTC5oX/bt4yRKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S5pPY5pFzRr5RkRKYt+0qS2LpIP+ckiVY2Knm/nUdFg=;
 b=i9qFs4/glwV12ACSLZFy95VfsRRV+9gXErwOwMw20cDe0bWXW/xW9Rze4hiVQWbw2n8AniJ/+CWukGVUxgeQNmCaMDtolbakxs3n9gSGSfHqhuhnkoxD5bQwWQyNqgZOuN/Ld2Rcv2V/C/TS5bAqSu5f0O1zpTkKdJNXHtSyP9gvUZPSu2wzrVzwQeM1wkcchU8LtXAHMNSFos+oxOX+raR2tI0tIi/7br0nihUTD8BzA3g/0B+5xy1FSOctYigJugYsAUnrgggo/rMM+a8EtLvzZz2B7z1CdLLaGGo2GN8i37zJaTtqH/yO1srAXJ4Q/QymnK+JXlym+HWAAnpj8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S5pPY5pFzRr5RkRKYt+0qS2LpIP+ckiVY2Knm/nUdFg=;
 b=VUaB+ly5zNKiCLf80ZKeKaQFQWGyQEYg0zsjBzvYj28DAfSmLPcXPb9drlwSXU8YJtCAR+bb3bC+djyF33EDglNEwQ9b/CG3PhSV8fu0xwj3tyuQ/OYFhotdkfdV+t2VK4v8QGTBJxxBKaPYXQuNCsIEaIe7XNExAhgtnSZCV10=
Received: from MN2PR10MB4320.namprd10.prod.outlook.com (2603:10b6:208:1d5::16)
 by BL3PR10MB6209.namprd10.prod.outlook.com (2603:10b6:208:3bd::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.11; Tue, 25 Nov
 2025 16:11:29 +0000
Received: from MN2PR10MB4320.namprd10.prod.outlook.com
 ([fe80::42ec:1d58:8ba8:800c]) by MN2PR10MB4320.namprd10.prod.outlook.com
 ([fe80::42ec:1d58:8ba8:800c%5]) with mapi id 15.20.9343.011; Tue, 25 Nov 2025
 16:11:28 +0000
From: John Garry <john.g.garry@oracle.com>
To: axboe@kernel.dk, hch@lst.de
Cc: linux-block@vger.kernel.org, John Garry <john.g.garry@oracle.com>
Subject: [PATCH] block: Remove references to __device_add_disk()
Date: Tue, 25 Nov 2025 16:11:13 +0000
Message-ID: <20251125161113.2923343-1-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.43.5
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PH0PR07CA0113.namprd07.prod.outlook.com
 (2603:10b6:510:4::28) To MN2PR10MB4320.namprd10.prod.outlook.com
 (2603:10b6:208:1d5::16)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR10MB4320:EE_|BL3PR10MB6209:EE_
X-MS-Office365-Filtering-Correlation-Id: e1da2a73-8d29-4e69-c696-08de2c3d4a88
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?qFNo4iDQD3L+XNZQ4ZYZmqGq+Q4K0o4CL1c6tplnz0jEMh6uW9Wlh+NFo1/k?=
 =?us-ascii?Q?KqyM/Jz0CPt/8MUowu56MuQDZyGJV4/7bxnF12QbR6SudzDpVsocAps3TQAq?=
 =?us-ascii?Q?ZskXNSOf/6pfh/SHPvWK6GLlQmqKFshEO71SjIXcZ8IZMBqcbzwD1sVXMCFa?=
 =?us-ascii?Q?OkH1FwdMyplVLmzZY88Rxt9NaFdkzCG5Sa1HnlylxlWG68R/DLQ7U5G8npgB?=
 =?us-ascii?Q?x4WAtHnLo0ZtdVpMm47UN1TX7UUfKwociLzIzwrM3WHbWALRkr/PQwOP0vxM?=
 =?us-ascii?Q?00Aerl6UFEoXpRWL8sAhmI3tFQBJnn35kO8KWiU9MisRT5ufmSwehrfqoQ+y?=
 =?us-ascii?Q?GusBSURr5Yfe8MaGYVN9beNtb0fxlDZgaISLE9IaUS31B5r8D0zvTm1RYU91?=
 =?us-ascii?Q?m5V7tnbJfIScCLwITvfVIsEa4Q5cBPPVWf/0ipAhxIicJmH31m0rsZuoX38Q?=
 =?us-ascii?Q?/giM6XVzAwxhP632l4HdLvpGO1vhnUry3S/zoj5ulPyiFFzZV76h0IG/mqA9?=
 =?us-ascii?Q?YiXF1TvNPLbp3pcAaAFtg0n7JAeQbHPOP0AhKCvyq5oDuPgXHfRDyBWd9yZt?=
 =?us-ascii?Q?xvc+iyHio3lo+nE+ch6dLv1KnzjqodT91ZayM81suZZImV2rIw1nhqAMmzVG?=
 =?us-ascii?Q?7TCeNcbdawR55n0dxtqarfj8e2hvKRfRMBrXcx0DZHgs6nv0CirQueBenq64?=
 =?us-ascii?Q?zenmt7WWBgNUVmzu7fTY8RBrRq7nFWJFDKcqv5fTF70QNu2/wI4yer7sFEII?=
 =?us-ascii?Q?2Nd/zEUhXu22Q3+MLx67c45Sml37g/N8Kl2jzcZgJefgMbC4A2a4qcXGx5K9?=
 =?us-ascii?Q?8HNjoVmLMg3HbYFCOeQFTR8okxqgsVRPrGwLPDexI+RoaRAuOD4EHfTqMVvU?=
 =?us-ascii?Q?g+4yCs6BI9lCuV5Dsoe63wz56cKzy7rWYphn7ET3+hS5ebj4X2xmYuBGws7L?=
 =?us-ascii?Q?P6H+bXLw5SGuzXPZKcxRbT3jSq5b54a5S0fIjGjJcZVB7RZK42Q317iW36Ei?=
 =?us-ascii?Q?uERK9pmEFL43m1QsyVt1hT9ULO6iOt7poOXTE6V1UGb38uvC1k6QuZISagF3?=
 =?us-ascii?Q?TGB70rTlpcawWvPR7SbBJM6dlaKqnqFzEhIzVnO1WcD4XBTmITpMxnhtMqd+?=
 =?us-ascii?Q?QNPwYw3sEQk8muN75D6eX5hCa3o7hlduzCxRTeliNZrgCCMqpS5BoBKHP7Yo?=
 =?us-ascii?Q?AP5lYQAGJEwQ9r0My2BT7axQBpGBOsPXm6G7SWEs+X7IdlMbZoaqM+eA2u3j?=
 =?us-ascii?Q?4PGcZy7xKW+cPA60qYRj/WSr93md7jfIx9iOB1TM6euQNqecRN6TW5td5Gx4?=
 =?us-ascii?Q?29uA5qR8x/ThY6bcFClpN1mUTEg9y1/AXYBIxb6oTIf0Lsf9MYgyeH6ZUYwB?=
 =?us-ascii?Q?+j9r+ESThtn6DBrTrLdc0tKheiIg+5YhdX8+rfRNXrj1OQzHItqYfwUxUwjW?=
 =?us-ascii?Q?FtL1N7v7t0vKI/ILA87et2U/IMUKEgDq?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4320.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?AVOFxN7Bzy+9AuCZV7LukgDJcuraJpWrkaMY7QiTPl6fczRcKSoCL6OFSdhF?=
 =?us-ascii?Q?0Gog6OaNBRvFcn3uyE8/Pw/omaPwir4JCmDIBfO07sgXmEpvJBaEHVX9syFW?=
 =?us-ascii?Q?YGA4DWB4WESASk9CSh8OECGHbXTC1YDXkNbxDOPNtms/VaEWvZ4/6b2F2gHr?=
 =?us-ascii?Q?AQGEfaUaulrA5qf99m9Mgb0D2KDeSTPohCkdn1TsCuhPCZw2jDTf7EsX+Ldp?=
 =?us-ascii?Q?8o0mc3uuNHakrWoYV/MMzeLgMJYnOLTP8sGwdAul0xH2dk1YXVUd2WrvbX5v?=
 =?us-ascii?Q?wskXqoXacTw5+dAhZfwz2h4aYpaLe4Ne8jJjj40BEZDiquGC7DDuK1ojLTSC?=
 =?us-ascii?Q?xfAubdml7zbRDiB0GQAT5IWt/CPaMw1ToOVBdQb77bP2cRlm/09NDYedAWjh?=
 =?us-ascii?Q?QSegUInp+TS7qtG7bZ0YPXQRycN3lXX9fa9X6upi3X1X8fFsQkvlqcqnTt/r?=
 =?us-ascii?Q?ZWmwLfQQpBCsBWXmgA6vD3IQ8eKEmpzBQNfMrRzafVHwHYfiiJILt5tMrf+D?=
 =?us-ascii?Q?NgUsJ3wbG/WhJv11yL/G70i7y2y9gXRcC2uDkxYxrV4m+7zOIsf+lyOke2Xg?=
 =?us-ascii?Q?IsIRAJhi4BVY+o9O4q0x5i8G2mzMMa8tK0m0xR17Fs6hRL+QG1jBMxSRMoVn?=
 =?us-ascii?Q?xyntebeMNmstsRAq8VssJkZDwiNhAuRovHkF3+2RbRqfgFsAbu32MXv849WY?=
 =?us-ascii?Q?9VA1NfCJy0VEPR9kHcPx9oQj3df2LRCQSqxVCtoTkMITrQOJnM1L18p3jLlY?=
 =?us-ascii?Q?l1ZmltDgyYbNab3ikra+1pFJ6fx/0bFl9lmCtSD7fVPm0tTF40siOBog862n?=
 =?us-ascii?Q?a2oXaKHIqlvhN53RILBdnZSuq/i7sAuJqT9l6E6XgmMeDuCTvc56c+yk3jA+?=
 =?us-ascii?Q?lqTBGpspoXUfxzd6vQoD0kz9wr3pUJkUe3JZShxl8QPM4wjFj2epi7Zjiknx?=
 =?us-ascii?Q?fC2tw+oB4UuBfMacRHLUq2MO9mH4RN93A0JxYSq+BboGeodNPcap2Ey2CeFI?=
 =?us-ascii?Q?TFQmBdbSGc/uXtLiGyp1rZGJRhzOpEHYoKEPqdv12gLip16/RJrlJEqk2FjO?=
 =?us-ascii?Q?3nSpb302VHZZDa+y+HFCtZoB/JreYYG/+mpsJrssLFuZNVPcope5wXWRujVH?=
 =?us-ascii?Q?Pd4o6fsAEkHDBsF6jgyAz+k2xN+9xXzHQLe/sWruwVcyRuqX+Z+0PW02b+wG?=
 =?us-ascii?Q?2nZ2wwEP8fiy65utKq6rPxCja93QI/fCEAD9coqxjiqHuxA7umfgdg0xqd1/?=
 =?us-ascii?Q?kjzrJaPCeoCOZ29UOBF0Doiy1cgeMen4pA9L2M96IhAdUS7kUx3kzEYvViIh?=
 =?us-ascii?Q?R/zsDJ0BkpmjgWQ+jXUxEVXGmvY66QpsFfm7UQfES2GrTjLJMfVjbgjeQ0dC?=
 =?us-ascii?Q?dRw78msAqKvGAL813aEbOOoMzoAkps2JwhHPQRjaD15psTTH0O10ccB++Lol?=
 =?us-ascii?Q?BkMUgBdTeBHrLsezV1DfJZcn+y8H5CZDqWzApsa3ygMpNhDt++h/sLnI1K13?=
 =?us-ascii?Q?8JE8pYt2mzbmie9lymVBQDcVwJyTV5gTZLTggIY+eUFXA5iyczSyRiQGpMf6?=
 =?us-ascii?Q?0EbUsWbHgUTPS3eMmPeNFXo7ITKBXwDobgR7swuXFQzbWHBetht+atQX4GAT?=
 =?us-ascii?Q?jg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	y44VtYZyCei8KfvCXGieu36eaRLv3gqFgBzBylVDlUNYHI6/BCxq4KuuRdWqozdeH4Vyw3cNhWM/AvI+1HPBVPtmMTucqI/rD0f9q/pRSQzlUMsq9o4NRAGlnozoYlabOWLVj73WEGI8ORZ+iVgH8mST9Z58ODf+P0pNYnuKuPc8tmwk1msXIbJA/zH0sU93Kbpgah5nevBD3oYnr7H3uxrUFy5MuCKjLFCzMf6U6mP07B4LgXaej5j6qc00vjRSD1vCtMJSfnpBV2lNB8Mvd98Mtue78mntZRl3EE+MOYekmL2I1R89N9WA75JYdRwO0PBQ3QtyA62NijtnDS3LYh4E/GIJLZZuFex3PoIINq3dEh2A04dmzo5i2Rjxf+nxSn2kMILexd+sty6VMnwdn1N5q3AH6xqLAZliZAd89iPLmmv0NhX0sQ14wPo/sq8juLe7bM855qE5RXTxGNNSlc4ba6loSUZDvcH9yPvy2R41KRSz2Vsy/mYWPZqErRwvUIC4DkPXGplzIXbqEW8MfNHdiq7LwDvX8KLMvY91/XSDtjswMYj+XefnAbrANzJLeFWfQrKEWJuSRvK7neXjonor7K7LAS+aB5QMSnuZqhA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e1da2a73-8d29-4e69-c696-08de2c3d4a88
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4320.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2025 16:11:28.9463
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qj0X7DHEFptjRK+OAyX2yoGm5Bh4kEj1h2KH4oCkFHqfTgEmGrcdyEaWimC8MaYmuy2wZBstBBdswpi5XJn6ZA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR10MB6209
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-25_02,2025-11-25_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999 bulkscore=0
 mlxscore=0 adultscore=0 phishscore=0 malwarescore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510240000
 definitions=main-2511250134
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTI1MDEzNSBTYWx0ZWRfX2Gy5CaDjNq09
 1iCPkVdkBko9suo/Ulk7M4+hjD849iTzWXbOY9PwHg19TkYARm/1mIGkANwWe3GBuihPlLjMbbD
 3RzC3guJX+wnRIiXwEXpaYTL91kKLqaihJ6BlhwWITvplNYLBmTe+bm8txgxy4AwLK2Ruq0Rn9K
 XW7wSkeO+La++MM/srxf8W9fz0uJm+5EgmjyYfUrlwtrKaF5akXDhOyjNXN99f784ZW11UWkv6U
 3G5S+8WX90fVvCC/nfUE9l7A1gQ6ketAJrexSkggU66HUAixRP5x74q9B4t9QWSarH8FZ+zy+RQ
 DIpCx7dyA3+OQhWHNyOGfnVFbedfOJuO4+jGHokx+TiZzpFYW/LRyKeFOXkTnIDuVw2xflasaU2
 RpF0k7yy/Du7hVrBJa4woIo0PSixBg==
X-Proofpoint-ORIG-GUID: TFaPobxnBDBocKfbN9CWYR_q9RMQUsWN
X-Proofpoint-GUID: TFaPobxnBDBocKfbN9CWYR_q9RMQUsWN
X-Authority-Analysis: v=2.4 cv=K88v3iWI c=1 sm=1 tr=0 ts=6925d535 b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=6UeiqGixMTsA:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=yPCof4ZbAAAA:8
 a=_LLsrhgO6nBkHzn3uc0A:9

Since commit d1254a874971 ("block: remove support for delayed queue
registrations"), function __device_add_disk() has been replaced with
device_add_disk(), so fix up comments.

Signed-off-by: John Garry <john.g.garry@oracle.com>
---
Please also check whether disk_release() comments are still accurate.

diff --git a/block/genhd.c b/block/genhd.c
index 9bbc38d127926..b40da968e69e0 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -795,11 +795,11 @@ static void disable_elv_switch(struct request_queue *q)
  * partitions associated with the gendisk, and unregisters the associated
  * request_queue.
  *
- * This is the counter to the respective __device_add_disk() call.
+ * This is the counter to the respective device_add_disk() call.
  *
  * The final removal of the struct gendisk happens when its refcount reaches 0
  * with put_disk(), which should be called after del_gendisk(), if
- * __device_add_disk() was used.
+ * device_add_disk() was used.
  *
  * Drivers exist which depend on the release of the gendisk to be synchronous,
  * it should not be deferred.
@@ -1265,7 +1265,7 @@ static const struct attribute_group *disk_attr_groups[] = {
  *
  * This function releases all allocated resources of the gendisk.
  *
- * Drivers which used __device_add_disk() have a gendisk with a request_queue
+ * Drivers which used device_add_disk() have a gendisk with a request_queue
  * assigned. Since the request_queue sits on top of the gendisk for these
  * drivers we also call blk_put_queue() for them, and we expect the
  * request_queue refcount to reach 0 at this point, and so the request_queue
-- 
2.43.5

