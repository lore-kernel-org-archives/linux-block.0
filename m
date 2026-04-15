Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB1232C0F8C
	for <linux-block@vger.kernel.org>; Wed, 15 Apr 2026 10:41:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776249697; cv=fail; b=jvU2cEA6uf6j8XB9hDxHESUsuMTqkDKKMsN2IyUeM3gdlekLYuY4E3GDy/MRmBwLS8VCcwkU3F6mL/pQJfZY7a4Cuv+2p+mPRCa2P5bcbsFN/tX4Da74YFOv5aGgXLjLhaTNX3CBH7qjbmjDopMnUSOYGa63409d2yDE4UATjV4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776249697; c=relaxed/simple;
	bh=GTiv6lzQsswsqk59ZSp9e6krl19geSih4X5QIsYf3K0=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=k0+M+enxYcI6roIxEkrBPxrv0oZsWHYoW4iXXgENk2S7L5G8lojwF+kSP3Fs3B2yd4N5SRfRGmATqOotCp76z9V5FZDbguizICqCK/U34N9j8o0w25jnA9rlAe7nSG+nWMGxIH+m7/3o7Iz9gihMfsxW82MVkhMnVfUBL98Jae4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=hbnehhlx; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Q1VLaXV9; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="hbnehhlx";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Q1VLaXV9"
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63F9Bbvr270459;
	Wed, 15 Apr 2026 10:41:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=corp-2025-04-25; bh=hoW5JkPs6XiM+Wzt
	yqT4VbTVvefKVn9/yUuXGilWKmY=; b=hbnehhlxR9byk+OnzS/mOTAj+lk6wrF/
	LBvg7WuNTir2UkcphP8vOlbrS9o4v/CQtk2C6RNrx10EfxnNOfWm88ZZgA3UGHo/
	9NCEOEI1/Unq30QBukPSmK5RMVQ+pdWYs/xLLgTX9LYxKkUxCtiX4ZTGhfp+Gkhu
	8oZuzcJnQUOQba9IxnpueDa6gT0722zzVVKtpF7Bxr69eIHrIQd5DOHH/3yIKdGJ
	G5akaJb20kISwpbSnYJQUqB4/PQEa4BWG46Qdi+1sjObMu7Tuz9b78rPvNE1HIS9
	682rIUCuaoHV5Pi5n9ItDJxWOqMbeirPi7CvkzyzsSLegVKNtFpZCw==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4dh87h4r6y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 15 Apr 2026 10:41:29 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 63FAdSlt017172;
	Wed, 15 Apr 2026 10:41:28 GMT
Received: from ch4pr04cu002.outbound.protection.outlook.com (mail-northcentralusazon11013036.outbound.protection.outlook.com [40.107.201.36])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4dh7nnrhuj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 15 Apr 2026 10:41:28 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UldpE97q5THVsbGJ2a60vXB53U5o3ODBYa7v449EqAw+xsM+qAdKX3vz77tt3MFiQKn3FHzZsJ2qUO+lJ9x5b5y0T3PZddYLpmPT/0VRB1DS1NL1Hp0/cXaOEqSIRqY8zZ3HuegsPXGI2gtyLvUib3d+WE+E0atMwemFtOZ4Z/XOFFBY59ib6y98tGDu+E2iu6JQD6vhyAJ3gx4AmJzZ+2CUbUy+eVMG/+Z4fdEPsvgookReiDsXw5kfwTnfMC6eRodLxkU99b8nIyYeV2HJd3sGlbue6g5+d8gy1MkpSiFjflRl4PTiUEutBtpDb9IGkysFwiEYgfa6A+kL5K12Pw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hoW5JkPs6XiM+WztyqT4VbTVvefKVn9/yUuXGilWKmY=;
 b=bGxZ/nsuLsvQ3texhVXCxRv/Nb1b2jMVW2x9kLnZV7sBWGiSDeqfknfcxuWv6TiskUWoEJf0GTZgs0PE5+VV1k4cj9cZvL2eBqYJv1ksfFFekBpKBE4nAGrEO627YxI7oEdXlbrAR3s8XK2guG0Qr2765ZPsk9sIXNggQHwUHP4cXYOV9sEnWt4EGNTqP6DfWa64IIfJ8jaqMCMf2VDhnaVsJfWFt0uNTRYYNDRQi4ARcPOucnlGF20KeusY7f2AOF/BjqrALsePMF+tTkQfk/0Bxrv5eg6pWYqdiAzBuVjWPJghez/XG6gp9hL2jOTeaWN+5GbKMUjn3/eVJNaF7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hoW5JkPs6XiM+WztyqT4VbTVvefKVn9/yUuXGilWKmY=;
 b=Q1VLaXV91Vp+j/6Tyr4Zhc+nUZjGvRXLcJGiEn3FiilwlZpR7jo9o7c24E/GBruHnPhypsy6BuHRlZHkng+h6SQ554dV8abi1hJ7BT3tciM1+4qZw0Y/XdV+aDYmvXBC17NMEco7uQ/uc4k3359r4WygSuh1qOdx6VEghETt3mw=
Received: from DS4PPFEAFA21C69.namprd10.prod.outlook.com
 (2603:10b6:f:fc00::d54) by PH7PR10MB5813.namprd10.prod.outlook.com
 (2603:10b6:510:132::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.48; Wed, 15 Apr
 2026 10:41:25 +0000
Received: from DS4PPFEAFA21C69.namprd10.prod.outlook.com
 ([fe80::5266:1601:5598:3f0a]) by DS4PPFEAFA21C69.namprd10.prod.outlook.com
 ([fe80::5266:1601:5598:3f0a%5]) with mapi id 15.20.9769.046; Wed, 15 Apr 2026
 10:41:25 +0000
From: John Garry <john.g.garry@oracle.com>
To: shinichiro.kawasaki@wdc.com, linux-block@vger.kernel.org
Cc: linux-nvme@lists.infradead.org, nilay@linux.ibm.com,
        John Garry <john.g.garry@oracle.com>
Subject: [PATCH blktests] nvme/068: add a test for multipath delayed removal
Date: Wed, 15 Apr 2026 10:41:11 +0000
Message-ID: <20260415104111.1439459-1-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.43.5
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PH7P220CA0082.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:510:32c::17) To DS4PPFEAFA21C69.namprd10.prod.outlook.com
 (2603:10b6:f:fc00::d54)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPFEAFA21C69:EE_|PH7PR10MB5813:EE_
X-MS-Office365-Filtering-Correlation-Id: e1b42e2c-f925-470c-6632-08de9adb8ae8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	aLHV5ZfNP6kVP5xIHmxpCER3oorJfz4n1e5pBLuc8GW1UaycZ1sFQCKMaW5HoDWGY6628U4Tt5PM/4kbFX3nBCVT/pDao/zKsKUNiuPbbzi81AEFUG5tzRuq/mceniBmLPJ+CMJA/6VEZiR/gZgZeWKRTTs6Xg0yn8vl0I9maKWMXo971ifQHGj3D89hcUMYPWes/L/qIEl6/U0ydD401nz61BgZgSmkcK/PbxN/V6OG3I0IDuRiaVIefRdu5oFzXbvIuN4terlCSxSIrn2Vbi8MwvOX1fga4YsRcZnE0iNBouBy4yxRuzrTSZoLjxjBMOvpTcU/bIf3VLKdRHMXbCyYnLi/DeMfNY7kNWCTOHOnYHQwtt6zLMXxHc3pfdUSkQDBMdYuY4r9Ya8lKnPuNlTCPpTd72YecYd8vqtKarAa6ob144mBhJ0M5WYYLDIO6Sgn229sZDX+09s6o5gO7CDU2hEBI0hSIs9K6ABu0OopRh0UooszWizxA3C4+iKmRYuBP7swoWqcUdQZu/RkxjHj830a80R1gGXhoevGrXnPaicWs0l5iQuFMZKhumjUbKehtsbUcXNgZnsmFBkytjElnCY98+IKSweLHBFVF7a2/M6i0SPUhlgwBDYDfB4HHS2QTFZE0l67KdQ1NBQXoewJCsTJkk7w9rcPDHZWhpKlR0Cym+RBhzVVIOPVsFB8wZ+MbaLg3ssF7Owar+GRofHt5tHBnPAV2s2gmXBA7ic=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPFEAFA21C69.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?9JQ3pBeNotPLkxxji/8qCbY/55kVEfpOP+YNUzf7jwCVaFIqL7gwbFeVGtkF?=
 =?us-ascii?Q?I7AAM8yr0L1t1E6zV4ydIAWtwY7Zisj2E42T/3ST1kLOgx+oDyguMdn1yG12?=
 =?us-ascii?Q?3s7LniTWk83iqlWCvBEMA9tcIauhTogiN1L+aCgvNaruwcz/pzcKyuAhDpF7?=
 =?us-ascii?Q?rwCR8r1U5lJoazpAu3sLr1aV8wRtVoovr7ha8FvRRmWQxvsC/GBfm7wScoP5?=
 =?us-ascii?Q?cYVlZH4d0aBojkkNPuj0Ntsv5/codr5Idm9AAzGZMUDwKf/721tq1weP4Or2?=
 =?us-ascii?Q?PHaHgnFAbZwW4Ht4ncRSXYamyYDRXb7WoIo9r6wj53WyFFMeY02W1y1wX3Km?=
 =?us-ascii?Q?KV/RbeHecsnYCvhDNT5nTS8vdxEgzaFHDC+GcK8jTvsolu8IJXX8QYl8I5GT?=
 =?us-ascii?Q?H3fUWFg2bxEb8tHlLzWz97BwCyGdTalwFdB+9qi04Olm99gysED7QniZEbL1?=
 =?us-ascii?Q?rSC1JyLLg9tolsFqvCrhryHNiDA9KdEIrEvgqfwyAD7rm56mYZXSKUpi4lUD?=
 =?us-ascii?Q?mS3Shap76K2nJTfRVa2os3XKAPPlaYZX2hYaQ4FVhrReUpUZZSBeIrK+OU5y?=
 =?us-ascii?Q?RBnN526PX0mIqnXnTaAoSASry17z5NV2bsQaRzvoqP3pNDQiRTN8/fQP7n/9?=
 =?us-ascii?Q?85Yqk+mxgZMx9+2Kd1brkXgPJYPTX4RcP7iyrkRY+eUXFxmOzf0rZuOmHVDb?=
 =?us-ascii?Q?NXBn+k2SRXFFfgcvFQG4kz49sa1/8Hyf8j5F74AmuxL43YYbkoTjLoPHzxB5?=
 =?us-ascii?Q?4FEMlvAtxksSDbNHd5kO6echyuZlQp/OelrSFXCirnSw7II54DnuKJobYRBy?=
 =?us-ascii?Q?xjWMfGypcj5OVrH5Mt9+P82GgKmGRD2C6gAF2eBtwVfE89ijjkVkr04WLZXl?=
 =?us-ascii?Q?d+GyFnRjNwN8TJm0W0KueGxSYg6BboMhjahIrh3i0hq66CBzCN69ZSoFOv5G?=
 =?us-ascii?Q?O3L97NwQ+FLJKq6+SYzVFEa2kMhVGZv6oswaEyRoCO/9OAvLmhXddUjLMB9d?=
 =?us-ascii?Q?NtXiQzcuTRmRh7bz9SoEwke2LE3jmPh52s6k+kNZbeBjJNNO4RFFe46jpNs+?=
 =?us-ascii?Q?z65LQrW/mmE9eK+qDWEZoXUNjoAzh7vpB6ISseGCLCIvJGVL1PAeQNbX/xe9?=
 =?us-ascii?Q?4gXL5jw0jsToohtT8DVD36TeoHsldK6nl4nbPskcMrXcRLzRw+jgveno15bV?=
 =?us-ascii?Q?QZuoP9NXvthiV14kuH0KC0iZmhsP0AY0Dc0mHlZM4X5dV2bL/36SJNcySMvC?=
 =?us-ascii?Q?YM35pYRNwXH6LkOTl1i4LDA8PBgWvwTKUDDYV82Yi4cMFaBohtjEAtbn0U1B?=
 =?us-ascii?Q?6BeqYp/cpv8GtaBUaV28m9fUqTC3EKKafkf/HIG+/1QUdD/K0Bqaq6S9pvA6?=
 =?us-ascii?Q?yqwJhVAkTkjI9a0EyxnlVZLedzeiWtGDUS3aheWtfgFJ8Kx8CtU7qdC1WZYj?=
 =?us-ascii?Q?vm+vwd2lTtLW2sKXxgyzeUWN1hqi9EX4g+QXereyLA+UPahCBksO4fUAX1iJ?=
 =?us-ascii?Q?aySskzXwZ6NDcqEK5wTJ1i+4STJYD73wQRGupXU0BbhCYlSGOoQ/taz7FIGN?=
 =?us-ascii?Q?Bk31/sdOlh4FtNHNDhrsUPq0fDQK4w+TjwAp144J5jVNzHrOe3rAQJGlAeAR?=
 =?us-ascii?Q?IBJjGeDwHZduhLBWrF+v1CiqI1F9yNfNy/TOFfqUwU89qV8Jhcn+Do2FMf3c?=
 =?us-ascii?Q?SSvgpdZEtfN3IdZZdnFr/HwTkINOj+pOsu0oHSGcfiWgxPQEiuu2fpINlp+Z?=
 =?us-ascii?Q?oAAFHTDdpQ=3D=3D?=
X-Exchange-RoutingPolicyChecked:
	ADwFrPfS46u0S61BGMDr89um2N/ogBgF0Z8Oxv1r7d4Y+hG67uqRXXUIfP438u2gZY1qbIeMExcGGLYAJdUf6mAhGMMfx6/IHf0Sd8WyJbIQXHv/cCRvZh8HTS0xUZ9l6fd/yp9ptD1Zzmk8A2SpZCha/B2DLS/J2VGXG3sx4WVG+q28/Twp+TCpvpYinGCHXiXxXA7A11M8kF78fX9PYRBUA2NWC0BUQJ7L7Eu/PBZlNsVrzLhXSIQf4mzP8PFv9/bl9c6DdiAGA/qy9xrcutwd6KeFW7tn10sRDHly5uGjrqcDcY/4Xvo/E85dzQhj7mP8TONqbqKC1pp2SfkWlg==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	ZsDbIfQZCUG9nlwuq3L2KfxEdZYIF01XXmALvzWaLOGUDjRh6z2Z8GYvM09egWunGhJULLotH6il6DZ62WSt1NAg8DnZaRTHbjtfgjpNix2qHmJVfUtvpO2p+yJPbjZYv97FIJGk2UjThn/SmH7ojt4wpc+s8UDfv6m/vCcIsvrwGFkCOnx1eHpivYJYNMOsRtCdBYavheXRO9At/+pq4YnY4lFvB5/JTyFieEcwjj1IdGTFYVi8aIWX46/An2owGxdM4pOPCEy4KuMY/ZVm/q6h8P51sg5Q/YZfhzSnEbVTfmWLaSEMyQIlaQunHEDQOWHKBttK2ISTI1VGnvg+70jbEpCweWAl7r7Xb5pF6N3kGhzEp7DIUHFqnljvdyS4D+PSeeUdU6DxIfjxfKFiqglMu4wdYgMjGcyc2oTVZiWbHotDCouSTyZJBle/TU1U2nmZ7hsv/V2EAvYsWwcvrSar3gkL+e/PGuCAYfVqWs063XFMOSZOKRoUcvGXy8gQc37j58wLyPwIEQd/Gr5kuGsES1c97AE7acuAHESl3e+dhpYRkx3Nb1AXxTLuIdZSOhpehPRUaDZiTqxwfmUwo92oebj6isSvKAwc2U1ID2s=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e1b42e2c-f925-470c-6632-08de9adb8ae8
X-MS-Exchange-CrossTenant-AuthSource: DS4PPFEAFA21C69.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2026 10:41:25.3978
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EksfGSVlzTkrhNdhjWlZEJktJpB44Esrn8xe+V71sOVQ62KCDU6fu9qjC3vpv7kHoET7IKg69C5pfZNE3MMwhw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB5813
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-14_04,2026-04-13_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 phishscore=0 lowpriorityscore=0 suspectscore=0 mlxlogscore=999 bulkscore=0
 mlxscore=0 adultscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2604070000 definitions=main-2604150098
X-Authority-Analysis: v=2.4 cv=eJUjSnp1 c=1 sm=1 tr=0 ts=69df6b59 b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=A5OVakUREuEA:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=EIcjfB9IiI4px24ztqRk:22 a=yPCof4ZbAAAA:8 a=AyUperUMAjGy_iXkiYIA:9 cc=ntf
 awl=host:12291
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDE1MDA5OCBTYWx0ZWRfXzQSjRGKG/XnT
 0bGEfuk7+xcqa9erE+DzVhEc2UnAj6fzN8Y6DFWRCScsKRoA+CWmjJT2O0rxfVJJnJvDndnrF/V
 WzWEabaFcyjzxZd+Hlnx7zPuyS9WbA41Lbm49/iputSM92ZCD8JQIjzUbEsbB8e/PW4fnVfEud1
 s0lZUMopRrACNFP9dYhfOaS+wTFA+ulcZjUxrnJAv9jGwn5RS/qOJQVck7lPwN+CboNqTiPUljV
 YLJsHhxV4nqzy8+9CQVRNrVngzgt+EoqPwFFc6+btxl9tN/qffoXGkIwhwoIzbU1ojm43PRigk2
 /KKOOO102+IXRbPNkvLFmsZ/XUXQraahdjtxCrWfwf7ZqAoKriaGmDlDiXcCeS3m5Yp0Gy+sDAZ
 8REp3UfglFu+PDtAf+Cn1cWTMLA+wDcfmVZ+81LknrFRygwki567io/Z9oYVBoJZNM83CIAnhiv
 6aApe7nNCQ8zlZBT31egCewYr/5waz6K0M1GBwyk=
X-Proofpoint-ORIG-GUID: XmR6DBiZk97qlDT6kBY7SSScqYrPdVUE
X-Proofpoint-GUID: XmR6DBiZk97qlDT6kBY7SSScqYrPdVUE

For NVMe multipath, the delayed removal feature allows the multipath
gendisk to remain present when all available paths are gone. The purpose of
this feature is to ensure that we keep the gendisk for intermittent path
failures.

The delayed removal works on a timer - when all paths are gone, a timer is
kicked off; once the timer expires and no paths have returned, the gendisk
is removed.

When all paths are gone and the gendisk is still present, all reads and
writes to the disk are queued. If a path returns before the timer
expiration, the timer canceled and the queued IO is submitted;
otherwise they fail when the timer expires.

This testcase covers two scenarios in separate parts:
a. test that IOs submitted after all paths are removed (and do not return)
   fail
b. test that IOs submitted between all paths removed and a path
   returning succeed

During the period of the timer being active, it must be ensured that the
nvme-core module is not removed. Otherwise the driver may not be present
to handle the timeout expiry. The kernel ensures this by taking a
reference to the module. Ideally, we would try to remove the module during
this test to prove that this is not possible (and the kernel behaves as
expected), but that module will probably not be removable anyway due to
many references. To test this feature, check that the refcount of the
nvme-core module is incremented when the delayed timer is active.

Signed-off-by: John Garry <john.g.garry@oracle.com>

diff --git a/common/rc b/common/rc
index 5350057..6eae0e2 100644
--- a/common/rc
+++ b/common/rc
@@ -117,6 +117,16 @@ _module_not_in_use() {
 	fi
 }
 
+_module_use_count() {
+	local refcnt
+	if [ -f "/sys/module/$1/refcnt" ]; then
+		refcnt="$(cat /sys/module/"$1"/refcnt)"
+		echo $refcnt
+		return
+	fi
+	echo ""
+}
+
 _have_module_param() {
 	 _have_driver "$1" || return
 
diff --git a/tests/nvme/068 b/tests/nvme/068
new file mode 100644
index 0000000..e06fd6b
--- /dev/null
+++ b/tests/nvme/068
@@ -0,0 +1,118 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-3.0+
+# Copyright (C) 2026 John Garry
+#
+# Test NVMe multipath delayed removal works as expected
+
+. tests/nvme/rc
+. common/xfs
+
+DESCRIPTION="NVMe multipath delayed removal test"
+QUICK=1
+
+requires() {
+	_nvme_requires
+	_have_loop
+	_have_module_param_value nvme_core multipath Y
+	_require_nvme_trtype_is_fabrics
+}
+
+set_conditions() {
+	_set_nvme_trtype "$@"
+}
+
+_delayed_nvme_reconnect_ctrl() {
+	sleep 5
+	_nvme_connect_subsys
+}
+
+test() {
+	echo "Running ${TEST_NAME}"
+
+	_setup_nvmet
+
+	local nvmedev
+	local ns
+	local bytes_written
+	local refcnt_orig
+	local refcnt
+	_nvmet_target_setup
+
+	_nvme_connect_subsys
+
+	# Part a: Prove that writes fail when no path returns. Any reads or
+	#	  writes are queued during the delayed removal period. If no
+	#	  paths return before the timer expires, then those IOs should
+	#	  fail.
+	#	  During the delayed removal period, ensure that the module
+	#	  refcnt is incremented, to prove that we cannot remove the
+	#	  driver during this period.
+	nvmedev=$(_find_nvme_dev "${def_subsysnqn}")
+	ns=$(_find_nvme_ns "${def_subsys_uuid}")
+	refcnt=$(_module_use_count nvme_core)
+	echo 10 > "/sys/block/"$ns"/delayed_removal_secs"
+	refcnt_orig=$(_module_use_count nvme_core)
+	_nvme_disconnect_ctrl "${nvmedev}"
+	sleep 1
+	ns=$(_find_nvme_ns "${def_subsys_uuid}")
+	if [[ "${ns}" = "" ]]; then
+		echo "could not find ns after disconnect"
+	fi
+	refcnt=$(_module_use_count nvme_core)
+	if [ "$refcnt" != "" ] && [ "$refcnt" -le "$refcnt_orig" ]; then
+		echo "module refcount did not increase"
+	fi
+	bytes_written=$(run_xfs_io_pwritev2 /dev/"$ns" 4096)
+	if [ "$bytes_written" == 4096 ]; then
+		echo "wrote successfully after disconnect"
+	fi
+	sleep 10
+	ns=$(_find_nvme_ns "${def_subsys_uuid}")
+	if [[ !"${ns}" = "" ]]; then
+		echo "found ns after delayed removal"
+	fi
+	refcnt=$(_module_use_count nvme_core)
+	if [ "$refcnt" != "" ] && [ "$refcnt" -ne "$refcnt_orig" ]; then
+		echo "module refcount not as original"
+	fi
+
+	# Part b: Ensure writes for an intermittent disconnect are successful.
+	#	  During an intermittent disconnect, any reads or writes
+	#	  queued should succeed after a path returns.
+	#	  Also ensure module refcount behaviour is as expected, as
+	#	  above.
+	_nvme_connect_subsys
+
+	nvmedev=$(_find_nvme_dev "${def_subsysnqn}")
+	ns=$(_find_nvme_ns "${def_subsys_uuid}")
+	refcnt_orig=$(_module_use_count nvme_core)
+	echo 10 > "/sys/block/"$ns"/delayed_removal_secs"
+	_nvme_disconnect_ctrl "${nvmedev}"
+	sleep 1
+	ns=$(_find_nvme_ns "${def_subsys_uuid}")
+	if [[ "${ns}" = "" ]]; then
+		echo "could not find ns after disconnect"
+	fi
+	_delayed_nvme_reconnect_ctrl "${nvmedev}" &
+	bytes_written=$(run_xfs_io_pwritev2 /dev/"$ns" 4096)
+	if [ "$bytes_written" != 4096 ]; then
+		echo "could not write successfully with reconnect"
+	fi
+	sleep 10
+	ns=$(_find_nvme_ns "${def_subsys_uuid}")
+	if [[ "${ns}" = "" ]]; then
+		echo "could not find ns after delayed reconnect"
+	fi
+	refcnt=$(_module_use_count nvme_core)
+	if [ "$refcnt" != "" ] && [ "$refcnt" -ne "$refcnt_orig" ]; then
+		echo "module refcount not as original"
+	fi
+
+	# Final tidy-up
+	echo 0 > /sys/block/"$ns"/delayed_removal_secs
+	nvmedev=$(_find_nvme_dev "${def_subsysnqn}")
+	_nvme_disconnect_ctrl "${nvmedev}"
+	_nvmet_target_cleanup
+
+	echo "Test complete"
+}
diff --git a/tests/nvme/068.out b/tests/nvme/068.out
new file mode 100644
index 0000000..b913d19
--- /dev/null
+++ b/tests/nvme/068.out
@@ -0,0 +1,3 @@
+Running nvme/068
+pwrite: Input/output error
+Test complete
-- 
2.43.5

