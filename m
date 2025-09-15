Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AF7D2FC86B
	for <linux-block@vger.kernel.org>; Mon, 15 Sep 2025 10:35:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757932519; cv=fail; b=c2PlvlDlH4LqeZIPZ4Q1mB61GmZmPj8ZKMoa/bzomuMx251ypuD7wEd43uKxrCUkzCKR0gaOLSBq2/zoTKbCqbzPBWmC/dBijeoGO2+EPH3tkH0r89XGBWhX4PX8Vpfk+yhwyL+/811Ws1n0R9/YE33ivcYHJ77aSMoE8GtKPFs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757932519; c=relaxed/simple;
	bh=ndqjF9iLkhwQkdVj6pRw39VfZeUkmcd/FkuIdV1a3qg=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=Z9Ku5ovzj3vaRt7IOJC4sy9ZgL6sqF52KOO/Vq0X6ZT9eMR9PEf+jw4ZY35TZEWlyPr3dxPwBGjIkP94Blgr0hzNYC6ZpKeBnxkqQqUy1+Ml4XXWy7mm6Hh/nP5ZP61Oa96jgJCYf911iXIs2fuQBaJafI7oECJL7x4QnAR6yHI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=AIS3UFeU; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=RVfnmCYO; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="AIS3UFeU";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="RVfnmCYO"
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58F6frgs028305;
	Mon, 15 Sep 2025 10:35:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=corp-2025-04-25; bh=zzQCuxb9IoTV+X3J
	WFnjw9wdEuQT6p2DsZMpuVd2VX0=; b=AIS3UFeUVQXjEm+vmAM7uZbPQse7VpXe
	eyaO7QJ22kN8Rq9ZjzZtaD7c0ikA9Q1BSxob/MOFBiSvcgggbQZIruX5on388484
	AzMgmXCkylfdIXIC3vaWkbsct3IzntxLQE408UU+8muPB5F7viksPjnxClb85MaH
	EYr8vjmGM/VhnxpEzBlQmne7y8lAWTan70JBctWK9k1XbZV+0KSbObQR7plTftD4
	xX5XKMZnThhZq479YdeBCha1BWmn0XSaWdp544s71t2HjVF6iDngS8OnXYXJpnTN
	SobZhY7s2legMGeyZRTrtjDRF4b/cLal88spwOIvDCFCn/7ulUxsow==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4950gbj29j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 15 Sep 2025 10:35:15 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 58F9DCEg019137;
	Mon, 15 Sep 2025 10:35:15 GMT
Received: from ch5pr02cu005.outbound.protection.outlook.com (mail-northcentralusazon11012025.outbound.protection.outlook.com [40.107.200.25])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 494y2b37u0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 15 Sep 2025 10:35:15 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=j7LO7sMFpQrG2mT/5w1uEdlzAb06uW31D8jWLbCONueeNEbAZJvABw+vjGqDMnDq64HaAt987Qm/ZX7KshzU7/rG6SHcY40rys9kCEcQKjoxEOEWRu+M2x5azZavMXu1vJ3q8+tbJN5dM2hCGOZbewRA5PbH5RWXwtUsmXJlnTW5Z9BKTtUbpbQCtJi+1yJ3oIxznwAehx30SZwD4JlgctJ2Pnj1rx0Q2Ms6+EPZETit02Fm6QbGVylGUifNGrnDBPYt7HvoA8uTr4en5MG5+h2TxcEzZwfuRO2LgKBsrXE/HmifWJGLFDcXoy8rRPdg9grQxTfb9aAoE9wzk5zrow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zzQCuxb9IoTV+X3JWFnjw9wdEuQT6p2DsZMpuVd2VX0=;
 b=ZSQVuLQWHwzLc5fS3Jqg3wQOOIIuMZZGMUmxay9m9EtVXb3QWxK1XZuD+q/o4eHJvxpMIwrRy8VN4zhmTWJU0ZC2clt/tT8Yj1vYd1oRaXA1Ey4BBRwUKW1ij7s7znTF44+2Rr+jT47HpDQO7lJU0lSIxg+xwltR432VK5Nm/JWQYgqoHRXi03WJXxWl8l4G79XyWyieRMAvKiEoXsZAuxZS6S420kmZ5W2C7ePImw0b/URRDR8jJ9KskZsNQb6aBCGHHdzhU2dhcPHV4R3sdaPd8+1xc2B1LkhXGBB8ZSsbQXgutDzLBTQyVM7vYSKx0M90xQ58fPoYWoppBkYDWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zzQCuxb9IoTV+X3JWFnjw9wdEuQT6p2DsZMpuVd2VX0=;
 b=RVfnmCYO47DLRv4v6UGau7sDWvmnM+Mghn2h/h5G6jPs+tobWqzaql2NiDA6oRphuDuuUEfh6S+ABZuUim2ml1zXCy60ryd6PTTlQW6hFWsKKjdGj//xa3dfBKg37mcNS2SeRlhKuydiEdz3o0wVbqiNmBgac0q54OUuMCPlrME=
Received: from MN2PR10MB4320.namprd10.prod.outlook.com (2603:10b6:208:1d5::16)
 by CY5PR10MB5962.namprd10.prod.outlook.com (2603:10b6:930:2d::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.22; Mon, 15 Sep
 2025 10:35:11 +0000
Received: from MN2PR10MB4320.namprd10.prod.outlook.com
 ([fe80::42ec:1d58:8ba8:800c]) by MN2PR10MB4320.namprd10.prod.outlook.com
 ([fe80::42ec:1d58:8ba8:800c%7]) with mapi id 15.20.9115.020; Mon, 15 Sep 2025
 10:35:11 +0000
From: John Garry <john.g.garry@oracle.com>
To: axboe@kernel.dk
Cc: linux-block@vger.kernel.org, nilay@linux.ibm.com,
        John Garry <john.g.garry@oracle.com>
Subject: [PATCH 0/3] block stacked devices atomic writes fixes and improvement
Date: Mon, 15 Sep 2025 10:34:57 +0000
Message-ID: <20250915103500.3335748-1-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.43.5
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PH7PR03CA0025.namprd03.prod.outlook.com
 (2603:10b6:510:339::17) To MN2PR10MB4320.namprd10.prod.outlook.com
 (2603:10b6:208:1d5::16)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR10MB4320:EE_|CY5PR10MB5962:EE_
X-MS-Office365-Filtering-Correlation-Id: ecccef15-e56a-4fdc-c7ec-08ddf4438c8f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?GR5uZauEL4ptlUtZ4f3SvKvMeyHX3hgnMr002o5oKBm1KgT6mZpbX5yBi2Ch?=
 =?us-ascii?Q?KHUqzkY23eZISVMsR2MliRmU9qM3WIy8DsrInL34DepzupO7Q6+bFZH5BOk7?=
 =?us-ascii?Q?S6VwY9WIc/FWFtGsLHnQUaHMn+aKi2E6x2nUg6EmvKbQeyzG84D56vyq4Dpq?=
 =?us-ascii?Q?DdBxz1kGmsk/ECwTAByXJZHpJpE/tA43IMZ89a1f0gg6PeTys/TJZIBeIJ56?=
 =?us-ascii?Q?5eneETmSQ7ckKCNNLkY8vAzIJBh7P6wbN3MhDGZTjXeivCenwoK3KD3LX1Fv?=
 =?us-ascii?Q?FyoHmuXdTHV9S/QKFoMF/1l1EKzch8WTH++p9brU2SjJSFn2lEErn1570232?=
 =?us-ascii?Q?fBVVo15guiwBL4cG8PZEmhI3nm9lTvO6CyzpPqLHgr5pxCdqdCvvrHogMv1N?=
 =?us-ascii?Q?tJUOfT9N1m2WfaNDTxb9hqmvcnbC90G9t/fX8f0UUL9T8nBIwow5aUeyNx9I?=
 =?us-ascii?Q?Ad+UHMpki2WvLBZj/LUJ0DCTa90MfyVXnt7q7Rag8XU9lfBiUyqAxQTYfSA0?=
 =?us-ascii?Q?TQa739HSb5JBthefhH2VyW8fpeMgNY6D2CuO3jOnkravYICqQ+7pvaXP0IGZ?=
 =?us-ascii?Q?EQwpHrrChbaOLKc9fMvCTu+JFUi1a1SJ9qM9acZ+Pxa8E7PsAFlOgwzJQ0du?=
 =?us-ascii?Q?bHdedjAmlr9iDyKlK3CH3M3s68y3+z2CfMFBtFr2zfKzmz9iepIdF6TpdCQ0?=
 =?us-ascii?Q?i0rmElHATe2aQsySvhj4k7a67jNO4O2YYfaotQT2agSrBM4BAB7HK9wgjZpd?=
 =?us-ascii?Q?X1rTYXRtHiYDmgQwl64kOoRGtWdSbWEruZ++h/YljSmKdzZU7NDjk0IESsfW?=
 =?us-ascii?Q?YfamJTr7twv37enV2A+3cDS7aUNmwGnXlwKqvXpq+DCodWw9fX4501AuOe0T?=
 =?us-ascii?Q?Ss9hBXfdjehVbei0shz36ffgGoQ6bz6XK/awD4BY1gTOOxY4he2a8zN8mmOW?=
 =?us-ascii?Q?/v2RwbCtuSzqcdmJA5XIVLsS2t7D0lNG8x4huxMgEG7ZSkiSL1NW9Zg5vIpo?=
 =?us-ascii?Q?xGIH3usBdm3LmMm/bYXxePNSB4InP1lz3WMxX55AUGW+/p4o45YOaiR6UqmE?=
 =?us-ascii?Q?jXFofbDnvqgnoNrrI15+9HJb4wP58jvy/2hLK8+pVtr6890mxkyMSXCK0Lqn?=
 =?us-ascii?Q?Yckx+1LLGXFYb53spGlyt0z4PXP5Kg70UKVRhHMyZnCvghyCYNTjJnV8Ul64?=
 =?us-ascii?Q?g/fDALN1xXPKEFASldUBo6+aqwfZys4zr5Ysn2SFpjJbSGXgFAjUaYO0RUbW?=
 =?us-ascii?Q?NsMJ0J/H4p9GzOHSRKHGACsMLaqZsTrmob8ShPRAqnLAPEnhywyEf4vwSvKU?=
 =?us-ascii?Q?sQYZHLukH84iwGHcsvmF/yd+CNTLFzKcp362Tc649eARAiEdmwgl6CGaU0x7?=
 =?us-ascii?Q?nIvb+C3J6cuDIJGxysUzbcQEseNU57ISv97jekKq64wqPguWzSKOM9DkvzcB?=
 =?us-ascii?Q?6VlJ6zl2X6M=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4320.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?27ouVVepYAvBUXtA1+BrZ94KmvPtbmiD4pDWGsiJ+OwvKRELhh/tyrawfG3C?=
 =?us-ascii?Q?zn63k5TnTaggR9ha2pq2ITcnsT9cFVo7IgtOhN3NK9iRpmIuz8AiZZ8aOAnD?=
 =?us-ascii?Q?2O60+TNO5Kfex00qtkibPe4ZWJlnnmWqxCiqqyq9LYeFKIlhjxI+GsaxIL8W?=
 =?us-ascii?Q?G6I2ZK8nuZWk7mVU9dxhhjFtjSo1kyhKgqzi6j8yGVwOegCTPvXEZ36Rt4vT?=
 =?us-ascii?Q?HY2ucivFDDMNV6F9J/SdqCqz/c3zlNthlHTv08DAMg6EM7e29x9X6+wKU40+?=
 =?us-ascii?Q?XcegmF3NSiymOI3dxkpybeoqHFlIXMRupVz47aofmsuhaxA0TDsj2OH3ZoG2?=
 =?us-ascii?Q?6AU37fnE9iLO+en/IogaSAuogcXUQiVd51VE/BSBtJr7YyXNaFS2Js3SZabE?=
 =?us-ascii?Q?kr7H37pW3RHTxfnMPM9Yj+WMza06DZ2B/48YRWNvXc7GrErmC7ZdhEQL00HI?=
 =?us-ascii?Q?bhJ/W2kLJCNM+htQkNR2TNbERD8Vj/UAoIjiwKCcWJPAiA6+M3HDnkMg4OQR?=
 =?us-ascii?Q?uVy7LUNdb3r3UBQc5jAfNWnTnzGjLlT8B1jF/8FX2Wsg8icDBhKBwsr+ms4I?=
 =?us-ascii?Q?ePBVonU4lPblcg4x2F4Rf8wJCslz8WODrD7dPazdJ+wYZnTsB4unrZXALueQ?=
 =?us-ascii?Q?z3bHHeUTtUbc4kC4U/kjvhgCMngNrJjVwcAui/ZiOv2XC+Q9DhQtqqdjMmKb?=
 =?us-ascii?Q?29nwwol741eeOYix5gyJXC7pgE8lJcuOufLyHpfKTG9lHc+Dj1nzzP/uD64f?=
 =?us-ascii?Q?nBCN+wbpwcJ64lJj2Z0c32afq02HHhBNOOZaAaxOP9J93Kk7mUTCm9IoVZ9f?=
 =?us-ascii?Q?//mSehXxnJttFNm9fVbLMvUJPErG2v8nUAx6pqM2EwffjJhUpU8TPVllPY4+?=
 =?us-ascii?Q?L2mC4r0i2KxkFsFyungi6jTw82YRNlfwu+hvPw/2bxRWK9SdZ8mE0rDJzti4?=
 =?us-ascii?Q?hHI+B2P5cRpxqfBYUw1T4Zvx/Ag7gRvSxXMJOi+fUuwNPj5lazfdcIdLlMHz?=
 =?us-ascii?Q?bXsk1fSrmdqz+ZQ10sb7At8wGlUMmJ/4gpf4+0FN72+sO3DKXKqlwNDAlLYr?=
 =?us-ascii?Q?BXYJiWZq3zZOxMhojMO2zgGyE+0+gtWnusjDYkXMzMch/Xk0lJYduoNhxOJd?=
 =?us-ascii?Q?Vu629jp0IMVe+BzzsrnAeHDpuXstNb91pl6lZfOeFUMROMwL4vGoa+F9iElp?=
 =?us-ascii?Q?WeV302dlYYr658aweQFRypr7VRZkhaFqXwfAZGha9wQqfrTMGnN10XNOA00m?=
 =?us-ascii?Q?6rY3+Ja+7TE640+pSFGSqAVgt2EaD75ekQjBW7i3ua3X6N2bUzNy75bTWg+m?=
 =?us-ascii?Q?vU9luzfECMsUeh1+Y3+0Ma9VA8Y3OwDxX86zkXzUdlGRGRSdNNRfRaBls945?=
 =?us-ascii?Q?YmdfuP56o66GOOcmhqDKwUtHsN+S/zHYRQuAIWJYLinjJ7AlRRMz/GGB7a4Q?=
 =?us-ascii?Q?pg+RL6ukfSWyTE4SjkLsuhfhbo62b9UELBZPlNvn8ifPKUt/dqQpcpkRb7E4?=
 =?us-ascii?Q?Qrnqx/bosv3aAyydFJom37BFKK/dw9tpJupsNC4/ENkqKMHFx8XYIRDyhUAM?=
 =?us-ascii?Q?hN3Bp1YpIqs0xSGEx/5+mtevUNm+gh0495bjVmM/EQpI+MPuISoqzbruJ7dW?=
 =?us-ascii?Q?vQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	m+WMzJrHIa9ugl5BPxwVt1H/M39/qErT929XgWGcfbQExlUwJN54XZKv5vEgO98qR6+UllXT3tBntcMmSz09yr1bdFTVZD+YnmOnFf5zuZEnCFnfeZmeQvZW1hugMn/fVxl3tIywJZFIXwNKNLPX+mJxpevJkLdBog+4VL8IT9XXadDaDnNNYPOdBv2r1FGm8mUUdGI8ioUCtWKHi2s5zrynH5BbPw2eLyWT/L9P/2Hqen+6VgnulEzXb5yrgSJClNdSjb1M2LWH2Oroo3qoPRhReI0C7IkWu1jYWnxKXrkZA96ovkyOSpZMe4f22HlYhqWCoMSnQepyy9i2eMS020epTqGp4fcJfwT3exdBEUFh99w4mUKHyx6yOSJOpwSlQysvFxETABBDDIx4MexYe3eEzuvq0TGsdQFPW83BbSC/TA2V5pYpe6R4ivKSThAvEI6g/r3gGhstqpFGYVbd2c/QLMdtW1fE7sJIeAuYivMxkDYL+qeYSeUwlrRfC7N11weu1TQC/wbJ80ef7WSjXq6TwRlbdb4af3caB33SjdfPujUIdF932YPwieKeJySGIe0dDclkFYyN1fr5Wy76CZX8QZWM3RQvLoTxfqcsuME=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ecccef15-e56a-4fdc-c7ec-08ddf4438c8f
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4320.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2025 10:35:11.5679
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Uc1f8mEpuDE4NoQtYob8vtxgao2X/uGuamUF9vwhH+OnlQjRq+O4CgqKoXU7MQ1IEomfvxdaGidSIyD0x3LU7w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR10MB5962
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-15_04,2025-09-12_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 phishscore=0
 suspectscore=0 spamscore=0 mlxscore=0 adultscore=0 bulkscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2508110000 definitions=main-2509150099
X-Proofpoint-GUID: DdEFNkvnJpoWY_qNlj2UaIiWI7biJPJ3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTEzMDAyNyBTYWx0ZWRfX0yVxXTVCCeEN
 dCE7xXFI88LsnH/Ejgj+ShIeyNyd4YeY6Q0Bqk5Fe6aRvsxg+ktTF7QojUog4UZf8bbt24Y3SKV
 NN5VdD1VaViupH8Ahl09jHt2DOqaELVkHNTk96sxDJfbDdk5e5EoZnDEvsm9YEWmfQoCvkEtI8a
 SOCAQYkNsoZvkiMVWNH9LcWoCEpRsGSDR/FaRF/HJCtN+Qi9SCPLjtWGyg8Zs9e3auLBXmE4EJH
 +YB3zXq3GpOxoT8xB/gIoBFPXFJPP9t5z9kZSjBwmZPM6VL35NTKGD+DvO5sV+4UZxpxPPBAvz9
 7Uo+sN+Wuzqrl9TMF+h4xY0RAGjObZvRJPNSTz/R/qBA9xG5RBhwfMH39pI1FQ4PvIRfoknAPMM
 /AGLkRG2
X-Authority-Analysis: v=2.4 cv=QIloRhLL c=1 sm=1 tr=0 ts=68c7ebe3 cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=yJojWOMRYYMA:10
 a=GoEa3M9JfhUA:10 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8 a=en3C-S3LyLESZCWn9LwA:9
X-Proofpoint-ORIG-GUID: DdEFNkvnJpoWY_qNlj2UaIiWI7biJPJ3

This series contains a couple of fixes and a small improvement for
supporting atomic writes on stacked devices.

To catch any other issues, I have sent a separate series to improve
blktests testing for the same in https://lore.kernel.org/linux-block/20250912095729.2281934-1-john.g.garry@oracle.com/

Based on 7935b843ce218 (block/for-6.18/block) md/md-llbitmap: Use DIV_ROUND_UP_SECTOR_T

John Garry (3):
  block: update validation of atomic writes boundary for stacked devices
  block: fix stacking of atomic writes when atomics are not supported
  block: relax atomic write boundary vs chunk size check

 block/blk-settings.c | 81 ++++++++++++++++++++------------------------
 1 file changed, 37 insertions(+), 44 deletions(-)

-- 
2.43.5

