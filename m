Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAE161509B1
	for <linux-block@vger.kernel.org>; Thu, 11 Jul 2024 08:24:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720686252; cv=fail; b=W7teI0OeDM2fJYQ5JAVCQwpB4ErB4beh/r7HkJ1VLY6W0a82jWn+cJ3k/2Gbm9iELSibyiYY/DrTAHBoOWwQ3WK/907n83oK+Zbb0HjHRJ/zl2nHLhtWn9OKs/cYy8QgUQ8OhIHErE7agEDPsWeizCRTaGZEGNrIwoIH6p0P9bA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720686252; c=relaxed/simple;
	bh=sN1BcmTptJOeA8gjTlY2SmDyU7YzOXUptqmSpJrd+NQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=TatoxiLA3TVVvlZCBircQWbExIijyrZ+qm9tKIwH4IreD+aGpuzQ5bxd71lFKSECdZjXx6JAL/oy3FEaDwEP8TVYqHNoDAQhUPazEZ1APN6mZeVFxByKsuUkO7pXjklyCNNKtUEZaZUfi9+TztYBHk7lTD51ZZ/O1awnHKHhJI0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=WoSQcBEM; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=N/g8mlDi; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="WoSQcBEM";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="N/g8mlDi"
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46B7uCAT026543;
	Thu, 11 Jul 2024 08:24:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:content-transfer-encoding:content-type:mime-version; s=
	corp-2023-11-20; bh=QjvTVPZhQ9oHlDil7LBTxKK6Ut34mfK/rj6EhyOA2rM=; b=
	WoSQcBEMUtkjZPMaSz9UpfPbnTbYIZEa6WyhUbUkrtDwlb9BznIaRt3IOFSCwKS/
	O9h8JjnVxv+bbkjW0dJMvtaT3x48HkvQHLwI0ABoREd7L6zBiF9EWYiUnB0Abea5
	UEM8k0XHfrldJRu/zU9hmOt9Pa6Jzg1ifKJYzF1bH1nQHV3T/GHtbGI7EWIghVWV
	AVs3BkdvDUuhdmfkIp4X6Z1JvuLfvPomfSXzyOvI++nSZ469SfnaNT36KyuShZXu
	Kml/it1hMXuYLE9k7ybVUrLSTCvRtljFQ0JU0DOrZ5+McDHoEQumiQD5qK/zIqgN
	3I0JhmVXUePwDKTgieD0Ug==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 407emt0cf8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 11 Jul 2024 08:24:07 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 46B71oAL028764;
	Thu, 11 Jul 2024 08:24:06 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2044.outbound.protection.outlook.com [104.47.70.44])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 409vv4p3wn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 11 Jul 2024 08:24:06 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HpYDYlRnOus2/Tg/Bmx42a4QKTrddS8Cw3Wk1OJF1wohtune+p3cDiUtjFqrAE59MDKxM5NQHq/e8lleclKEM+cAL7zzuCbeWqUWkAuElni9srknUB2kR4NSdvcmZhEvxjChHyfLCb3naMYEBXeErNqot06nk+Ueo3eP18F9g4lNhFiEty0WG0fp7JCfDbHTFAvuwXC/sYl2QeVfN/o8QoPJdpZujAUvJJ4C3uf9OYi5PdRuOOfLaIOG7Enaoomm30yDdczuCMs+J9BEROOYr07PIM4gLexgNo2znH4DcEJfOzfxYGJ6XK3n9pnQWoOQY+3fQ9csn8K9XVqSLEh6ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QjvTVPZhQ9oHlDil7LBTxKK6Ut34mfK/rj6EhyOA2rM=;
 b=Sb8EY5SUlgRl1zTcW9blKHNKYyXh+StrkYsndhL6Gk0pjEzuNPzKY5IiQsO9TX4q8V6Y+yyt+0dN847IXjO5grWQr66oipndJnDQCxirP/lQNZuEtU5XXX7NVo1zc2KgzKuV9Ydg0EBa8b7ODEPSzyLows3t80ZQjF++rIc7zBLe/sQb5pMUNAJEpgA1eyXXr6RsVHMMp1HPSta5V6CYAUBiUaoI1JhX/WQXt4+4GtdfaYF9jlJ/09NwLskwx6XExTb5p6SgI1lt+oLte7NiWgkLdHvOMvIx+guxmSH3VZBvcl2Aqd1o5ak3xm94QO+HxKTA77sbuGKiuDL7xi037Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QjvTVPZhQ9oHlDil7LBTxKK6Ut34mfK/rj6EhyOA2rM=;
 b=N/g8mlDiisxt3XBc9ZFRNs27Vb5kDd6MfaGx0WL5mlxpoEGC8hXoFZnO+MbWOx6qKgQhSrhRImXcZlHAd5tWjcrhtooQmvuqd1cDgLglOcce9T8i4xGgO0QGUjT/BcEK38oqdZsmgtkEEEKoMLtCutGyYWJkXjwWmVADe6bn5XM=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by PH8PR10MB6672.namprd10.prod.outlook.com (2603:10b6:510:216::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.35; Thu, 11 Jul
 2024 08:24:05 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%6]) with mapi id 15.20.7762.016; Thu, 11 Jul 2024
 08:24:05 +0000
From: John Garry <john.g.garry@oracle.com>
To: axboe@kernel.dk, hch@lst.de
Cc: linux-block@vger.kernel.org, John Garry <john.g.garry@oracle.com>
Subject: [PATCH v2 06/12] block: Catch possible entries missing from alloc_policy_name[]
Date: Thu, 11 Jul 2024 08:23:33 +0000
Message-Id: <20240711082339.1155658-7-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20240711082339.1155658-1-john.g.garry@oracle.com>
References: <20240711082339.1155658-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR11CA0083.namprd11.prod.outlook.com
 (2603:10b6:a03:f4::24) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|PH8PR10MB6672:EE_
X-MS-Office365-Filtering-Correlation-Id: c1fe7e4c-d441-422f-b1b5-08dca182d3cf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?FtmSSNymzGlbOdL5D+Lg/lFsgrnOXeN/aTsvqyEMK+VxXl0ZepjzEU7c5KIx?=
 =?us-ascii?Q?+JhtTgRnn/YvJmN+4fOTezAQvBYNH3Mywh2GpkMj8jWxVomb8QVQ88edf5Iw?=
 =?us-ascii?Q?Y7NcybnUsYlwG/+g6kLr+Se5DGldhi745IF7zLpzdZlZ07k+QJJ7rQjOdVRJ?=
 =?us-ascii?Q?/UoyUtq9PcrmtzuIhNBCn/VyxflNxJ6ZK5zfr+g1pFJj8LOMaQOsGM2Qrvtj?=
 =?us-ascii?Q?YuQfflad2PCusYcat3p02NkppzoeBhNZiYHVJFWel7+7XRBH0gAgnv69zjvL?=
 =?us-ascii?Q?i4jz6OL7JM5AX0LWV1qQ3H5lytScd12VuZQaOOv2ISEU3Vcxph8HT9fnKMXm?=
 =?us-ascii?Q?HAN0c35R6LY32Af1p2MnBtNjplqUt8FWaCyPF+z8XtPPTfWHc0Jrcon9lAGz?=
 =?us-ascii?Q?IWra610TzfysUgXDc2isbjC8fwPgjX0MrMpuvErWIHyilChUfALGxtZAQ+ez?=
 =?us-ascii?Q?vqnhGzDLGa5loQO1iwbVWc3I6paDWDhcrSW/rJUj3/pMRbLvmlGtJSTzvspc?=
 =?us-ascii?Q?kuBMgPV2BEymCDuIDMCmJ37HsMQFygdiZu+fGLBZykrRDMoO8EjH+ewj6biR?=
 =?us-ascii?Q?zKA2zvNnoGjzRihEh8+MqtzxX8SsuFoNAF+H2eWFM3r2fY7TAvogVQOPo1hE?=
 =?us-ascii?Q?IF4oVDBeQeN1S9QylNnALFDC/Tj2OujTDcq00NRnLR+4nUhsJNug8yzsa84B?=
 =?us-ascii?Q?O3W8iq/aszR1SgFtztrTSzH8/CouFGu8ukRnuETeQvKlUro/YaXRzrZO17IJ?=
 =?us-ascii?Q?KsI4o3AhhKU/Z40in2IWKSGBU2209WYmu7d/0eDYo2yv+ZPiMw2SDu5SxDoN?=
 =?us-ascii?Q?Xh3UDsHCIhMUI1wOyCgMwpZseERE1zkhFcy8Xn7ZHy7WkQKEOE3VFpYShoBL?=
 =?us-ascii?Q?Lm4EjVx7DV4OGXgjgfXcmlaREgMFXO1Iv1JjXy6Sgiek/r7q/dgX9iH38ihG?=
 =?us-ascii?Q?ubwpziqDtgcwljXkrzLbTyafVszJOamwk864shafaXCODib6st97dGmmtIHb?=
 =?us-ascii?Q?hfxf+gw5RcbYmhWlyxBcBYHvRdBPxgLpVcmy2VJWRsIjCd1cLXFSNjx7hXAf?=
 =?us-ascii?Q?VXqpMOW3Wct2zUdgv24+NklbZXIWmSutyCt9vitoNyzJRpLczkg6jjEaR4I4?=
 =?us-ascii?Q?SL3UOhAs5fTTHR73HJJAFDnK+/hyHLpQwr7h8cSIcwno+YIQySumbLiDmzbB?=
 =?us-ascii?Q?KaxEr9DO8ZTCHxFIfXoqZksqB60r1I2dXUDiPv2rlVjVkSxD4KXeaQ/0ll52?=
 =?us-ascii?Q?SDAcsZZfbeWSU3ysP3SGxpsluymy4n7M4vRcmzJHuDBxeeh+kI1O7NL1mhQE?=
 =?us-ascii?Q?5s4UaE8V/Ad0XUvRkXbLounzw2fEl70elx6VP+zUsW+BQg=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?2oIDQGOeJidjs4YLjRf+DgeOD8eJV69iC6iYP9s9AumWuPxqxylJ4dRHLLzm?=
 =?us-ascii?Q?0FIUkV+LaudP1q4uXZ4VXPe7/mdDQ8PCo5l9w4/PJsTTIwEjT9HIPMZZVuHN?=
 =?us-ascii?Q?I496e2dXeafR+48Fwtd5dxC6P4DeOrw7sFpjThodQZt+IsoOGpSlTnYR5ETU?=
 =?us-ascii?Q?wiCUm2Ch1MM3ikqJtCTPvW6e/JXwWhS+03FaqFwHMcOHq1FQpc4b3paDHGpk?=
 =?us-ascii?Q?y73bi/kXcIVcg844+kxuOEs8+HqN5m9h6L1AjoppmKhiZJr/ueDaeYOKH4t7?=
 =?us-ascii?Q?Hzo0fOipky6Dw8fjwtNKYoS2zhK67+Bjgsj/AdoFB5uueYNbbAlSuq/V959W?=
 =?us-ascii?Q?36ILjmOvS637k2ygZiK4j58QXCLNKVP87Pjhrru54qj73yUcwx72t5x0WwCD?=
 =?us-ascii?Q?Try/2O5iwGSJLR8hktnzPICFptDtb0nmD4uvH2v/6ZsKbZKawyRHB2nQyI8A?=
 =?us-ascii?Q?He/iTOmsezrkMyNYwqU39FqhNV780oKyoTsYWvs9oykaBj8qiUbso9lF7HVX?=
 =?us-ascii?Q?tNLqbjaov00xYftpHSOaWOIQawRtLtfIzdwmjxWhHjDcWb0bai/sXkXG1kxJ?=
 =?us-ascii?Q?ZvdsBXLFyW79dY5cy78TAA5lFvv/JYYHW5sqFc7MHfROtKooI+kXPF6sCYLl?=
 =?us-ascii?Q?TxEDKs4b2NRomL2qJ4Pu2kI9QoTEVk1KcW5n/TqNuk40Ym14SXdM/O3AgOCM?=
 =?us-ascii?Q?p/dSCd4+tqJLWIU7cZMK8F+JNQ8DJB+1v42YHk8bFaG184pJ3mtQkWmY5ZeS?=
 =?us-ascii?Q?iMaBx1LI6S74mYXET2GTI/QoQ2cxAgU2/N4gVSkGYBwFZZ+F3oPKcQIb2w0e?=
 =?us-ascii?Q?/rzgXnzRmmevC5vOSz9B+QJ+nNk3YccL8sbqWmqm0/IUd/24NSEyO5e+UXDp?=
 =?us-ascii?Q?dytPsFWqaKkO5FPbrKJDXKtlEc67U4jqfxHoNOlHrVf9bGwUfrIW5B/bChDq?=
 =?us-ascii?Q?LhA79Zz9cQjV8IteaQksY9VKRA+Fqa0dyhMJrfXjG1sIXrFR50a94q1vbsmE?=
 =?us-ascii?Q?6MsaCGnXLjJ42eU77FNGWHqHzB3uLWRcCTAyjROxKf6iUDrZQk/E2RUmCo1F?=
 =?us-ascii?Q?lM3rrn5e7I4c3A0yuD0u7RUFGcpmvOQmiO1OFfkDFm50BWPxt1g7QxN7kssg?=
 =?us-ascii?Q?ExloEMHgh9xzVs0c7sT0Gu1Pncvb2tfWOQinaq1418Cl99iwSu3C3BUEgxxx?=
 =?us-ascii?Q?V52yLpUjsVzl1WkTRu4QsgEnr8UES2F0vjZ80w1f6HdOfDhKOSRfMQyj5zXF?=
 =?us-ascii?Q?+3NVvR3LIKWw8la/4S9uViMP17MIePjJpwTjfdDhCjpuLl1iOBcZSimaceqc?=
 =?us-ascii?Q?hYlwL9RIudT8JWQM7TduQ6Zr9pY5She+wJtQwSpwDSgQgvD+55XgM0HMcRen?=
 =?us-ascii?Q?IP5piSjHJRa8WeIfYfhgs27NE4Gdfl6y6JyAM6BZ5FnBjGjSn1TXA+YKO97F?=
 =?us-ascii?Q?HCcv1/evgCjE55ZuMqP1AYCaNit5gV34yWC3Zom1zey9lcgn5JQdXJGCfa2K?=
 =?us-ascii?Q?8e4aAwben2+wZuf9t9MmhRM0xhsAoqYzhupldj4tZ+MnG94rLw+QhbN3JttP?=
 =?us-ascii?Q?mQRt5nPj+FpUfoMy/nW6vKybJ5JNAVUcnaRFBqD+D1HUYfk90otYH6gdSoVU?=
 =?us-ascii?Q?Vg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	2Fu3CncHZu1lPHw87Fdv04FePyrCL5ZWB8TY+FuRzrwWRNTnB0vuejrvbifQhRNGNaMnP79VpfQsaVCnn3YIks4fti6flXFOQrkG7mhgyWFgYS8ivNsqKEv7q2uBprdlmN5b7jAuNTOulL+Rn3PczJmmVN2irNbS3hPq4lQaOvdr3kmL5Q6z+t//FG/QH0MZCA4XWPv2K1a5HS7aVvxYgYKY/Adi69YZjr+HclDIF2zUjgd/kEykzEmLkZEjXc70ETiRV5OzB32jFLXI6OsxQZeOCSzfk/mf+t8ERBW/SW6fsZIqtkWAzLEn3xhvDmu4tfrUsjNej5QabgNjBie/g54VJYhykd7p8g5+y+ZZUHInT1k0vT1joxTD59sZUeUFAF2MGa1XcQCKvsLnHmMKDxXV8YBJK0g66+3h3jx04K5GOVa+MjQTMAKVmYrz1ptynuN6S47581L3vt+0Kq+lnTAgd22ZFIHokD7u3dNJFEpFReSmLlPqv8pSuOqIzs8lInvT3b/iQS1Snd6fSdCuXrm7Trb8N38KcstVuwoDi0JQZOV9lrjR80x1I5cFVWN8BmCxzR+D9lNQzAn0OlM11IC2H1oJKARXdPjK70wMDgg=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c1fe7e4c-d441-422f-b1b5-08dca182d3cf
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2024 08:24:05.2195
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6lWd2GTwSv/DhEyM9iBQDbHhf38qW9dUsILnnpT4sT1CwaWs6C044wj+2rKNJ8S/SLVV/L/zx1Mzh0kwhVMDjA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR10MB6672
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-11_04,2024-07-10_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 bulkscore=0 spamscore=0
 mlxlogscore=999 phishscore=0 malwarescore=0 mlxscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2406180000
 definitions=main-2407110058
X-Proofpoint-GUID: Lo4wAkXtJHShO5Zj4oTWUop7NN1IgDEg
X-Proofpoint-ORIG-GUID: Lo4wAkXtJHShO5Zj4oTWUop7NN1IgDEg

Make BLK_TAG_ALLOC_x an enum and add a "max" entry.

Also add a BUILD_BUG_ON() call to ensure that we are not missing entries
in hctx_flag_name[].

Signed-off-by: John Garry <john.g.garry@oracle.com>
---
 block/blk-mq-debugfs.c |  1 +
 include/linux/blk-mq.h | 10 ++++++++--
 2 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/block/blk-mq-debugfs.c b/block/blk-mq-debugfs.c
index b9bf4b25b267..91396f205f0d 100644
--- a/block/blk-mq-debugfs.c
+++ b/block/blk-mq-debugfs.c
@@ -198,6 +198,7 @@ static int hctx_flags_show(void *data, struct seq_file *m)
 
 	BUILD_BUG_ON(ARRAY_SIZE(hctx_flag_name) !=
 			BLK_MQ_F_ALLOC_POLICY_START_BIT);
+	BUILD_BUG_ON(ARRAY_SIZE(alloc_policy_name) != BLK_TAG_ALLOC_MAX);
 
 	seq_puts(m, "alloc_policy=");
 	if (alloc_policy < ARRAY_SIZE(alloc_policy_name) &&
diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index 6a41d5097dd8..454008397e64 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -278,8 +278,14 @@ enum blk_eh_timer_return {
 	BLK_EH_RESET_TIMER,
 };
 
-#define BLK_TAG_ALLOC_FIFO 0 /* allocate starting from 0 */
-#define BLK_TAG_ALLOC_RR 1 /* allocate starting from last allocated tag */
+/* Keep alloc_policy_name[] in sync with the definitions below */
+enum {
+	/* allocate starting from 0 */
+	BLK_TAG_ALLOC_FIFO	= 0,
+	/* allocate starting from last allocated tag */
+	BLK_TAG_ALLOC_RR,
+	BLK_TAG_ALLOC_MAX
+};
 
 /**
  * struct blk_mq_hw_ctx - State for a hardware queue facing the hardware
-- 
2.31.1

