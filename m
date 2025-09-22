Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27638285045
	for <linux-block@vger.kernel.org>; Mon, 22 Sep 2025 10:24:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758536688; cv=fail; b=VB65OpGJRUZz+U9OVprfTwycJyUuDG37WPeNq7fggCBcoXYFoDaxAtbFqTZeIzHD7J4c+RBGjBDrF55FNQ0UmvqWXkBp7yv2PD1iFmHr8hGr9Zuzj6mphZCqEN0c2R4UvWTcXhYokzWcTreaFL25ClrgEKnNjQzbxCV3igWE+nI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758536688; c=relaxed/simple;
	bh=xCpbE+iYHtuw4rjSjLLx+N7KW7v1LZ3AlF+KWHYrgBk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Z1Vv614oTWCvQvT/iZthEAJsT1VE7krPV16DmzuZohXeORBFek5dA/Yl1LElTnUvrwWVFBAcQuT0l85i1Ac2aHsmrBeghE/jiTMScbHrzKNGdvOXL28xBoUdTpnvg24dt6b237DNHet/WM9pzT2wgxEBxsRWY84l+FN+v9REq08=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=PoAaNcyB; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=S1/aOJON; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="PoAaNcyB";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="S1/aOJON"
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58M7NJvZ031889;
	Mon, 22 Sep 2025 10:24:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=bAEkpT6d/d+Zpw4eamu2HjwdtTQ5aHN6HdcQ30AtRh4=; b=
	PoAaNcyBC1A/E45gS8qpOXDtUBMS5va5YzfEmDbPelZ4tUgTrnuK4xF4QkmqUQNq
	M0Po011fW71O17g/13rlRGn72WhOMiR4GZ4bHiIsoro20ETbS6KEzS702r7vkWUf
	dUedqqUU7MXfZ8C2K0LAUyEjYFri6xenVhlRnpXByuOjainP+WlMdqqZuBZ8eTLu
	+FNM/IIpYO5AmMLxwi/sj4U0jT5RMx8gkSaRtK5UgKmCqYAPaTkfdUhIzIuhHb/S
	BBy94iN6qrOqzCjppLCCl6BgufdDLkBoGVPFabxUWwpasp+bPztEOJ3zAezJBfaI
	FIBNC2AZwmyiwR4nHEJqXQ==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 499jv124eg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 22 Sep 2025 10:24:46 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 58M8SjqB028363;
	Mon, 22 Sep 2025 10:24:45 GMT
Received: from bn8pr05cu002.outbound.protection.outlook.com (mail-eastus2azon11011029.outbound.protection.outlook.com [52.101.57.29])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 499jq6wx4q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 22 Sep 2025 10:24:45 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BJlcLsM63cDG4GlWdCAUa2gmcBFoISqNBKLzRMF9c0tc9Pt1LkgYyZY7rvOJJohTk9HaXpC2j3npt/6yXtXn85krSt9dmkib/6QRdzpPYqDwCIcGQVRiYh+Sb0GbwN15ZSmv30DzN8Afe72raGIB3TnFYP+EvTE0Yc8Tc3fGSrpdMZg/V220LMspvM3vtY7iI/9+BctaPzjNXV3QV+0zdNjhKRFwQujYtkJtjHdnfO9f6znvQsmBekxfnzYbzulboNiuRj9WKI2mdjvm08aVaLb9Nt0mKcoUDFXMsiqeMg6Mf88TKLcRupYXJ/mNCxaeRHEd7fwIynZqS5RmHrA9+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bAEkpT6d/d+Zpw4eamu2HjwdtTQ5aHN6HdcQ30AtRh4=;
 b=us8MmweL3DdYGCGnNg5i1yWHhsAHvHsYM4oTunQ13HuDcFi+jiuY3MJJLe1sShS78VGzATYZPaxxMLfqQRw6IGzA30rfk7wYyFtax1Ova34LjsEXixDhY+ZoDCE+vqaW+/UtWpxxUP1AcqpruEaTle05q6B4e8L6MP/M9so/YPRCv2ayvd3JBgGFZtiMaJXXBzLI/JNJmVDksX/ukH48BrIgXDmNHGOitXSHzC+bRyMSeIcOmr6Q9lj0YE2rBj6+5uroD/1d2aroeVHh2Nfwz3hYdht09CFCvVnHRltr/VbPLALGLo+1R4bQ9mveWrK/nCqWrnpESd7mr0k0OZPBiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bAEkpT6d/d+Zpw4eamu2HjwdtTQ5aHN6HdcQ30AtRh4=;
 b=S1/aOJONO3XEsg+abq0hEvS2AJ48bnXkNlGSknAVeTGeF50mFRMdHv7CtNRTUmNqRxpIMPQyKiauL9/OHYvaACWgayjMhEVcu5DQAHPoMR7REY0O4YccVImZDmv9gAnotXOKQVJAcGyzLNNAWUZPW9y9v37HS/RBNJUrdXbHXig=
Received: from MN2PR10MB4320.namprd10.prod.outlook.com (2603:10b6:208:1d5::16)
 by CH2PR10MB4293.namprd10.prod.outlook.com (2603:10b6:610:7f::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.19; Mon, 22 Sep
 2025 10:24:43 +0000
Received: from MN2PR10MB4320.namprd10.prod.outlook.com
 ([fe80::42ec:1d58:8ba8:800c]) by MN2PR10MB4320.namprd10.prod.outlook.com
 ([fe80::42ec:1d58:8ba8:800c%5]) with mapi id 15.20.9137.012; Mon, 22 Sep 2025
 10:24:43 +0000
From: John Garry <john.g.garry@oracle.com>
To: linux-block@vger.kernel.org, shinichiro.kawasaki@wdc.com
Cc: John Garry <john.g.garry@oracle.com>
Subject: [PATCH blktests v2 1/9] common/rc: add _min()
Date: Mon, 22 Sep 2025 10:24:25 +0000
Message-ID: <20250922102433.1586402-2-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250922102433.1586402-1-john.g.garry@oracle.com>
References: <20250922102433.1586402-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PH0PR07CA0111.namprd07.prod.outlook.com
 (2603:10b6:510:4::26) To MN2PR10MB4320.namprd10.prod.outlook.com
 (2603:10b6:208:1d5::16)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR10MB4320:EE_|CH2PR10MB4293:EE_
X-MS-Office365-Filtering-Correlation-Id: 72941f6d-edac-447f-bee1-08ddf9c23ef9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?yjuK+MUg50ExHJalz8jbj+6SwqaKlAeA2HmAzuHXE76171NCms+FYsRy5/Bi?=
 =?us-ascii?Q?EdEWpT1OJ4p9SigXsf+jt0crYj3gblQVefmmrH0OhOjzchgV2CrFVfBraTdG?=
 =?us-ascii?Q?MMkYCV0BQ05rDGh0jUtqyH5FLuWq3a3fIMpCKL4bVqZcLjNF6NcCab6PI6tB?=
 =?us-ascii?Q?sU8KCLYXdBQEkhLR7UMckAP4TI3MIrzv4Q38hBI84mV0b2NPEEYmDEKRhaei?=
 =?us-ascii?Q?3s7GfnwxMroOCGicf/FMfV4nWFwEgUDK/XdbfcrHM4RoY5hgAi8Qu5WXYrLK?=
 =?us-ascii?Q?R0n7Fm2LGYmbVWLzEhAka+KtdpYEJCdioirtDSNO/ALesa7M8KAsEZvgBl+E?=
 =?us-ascii?Q?nF7D7sXbp0cTBLvhQXebtJHrHu0LbJZb+CopFRX+JfVKjsJrqX+STk+86JcW?=
 =?us-ascii?Q?i8T1fiEFrVMC8oMDXIRkwr2dJhQpMPMBaagJzjwu0p1pl60xG5HS93PSTLG8?=
 =?us-ascii?Q?bWn8UsKuwFCXFH9WJgSzZarbZID2om5cysm92Nd0Xng1hL4rtBSunBISNU4h?=
 =?us-ascii?Q?KaHoZd/oLkaM1F8+qFjvOzOMQmeMIi8d5N6fYr11lUY0UQKrRstGi+XAWQeK?=
 =?us-ascii?Q?7eqfcdynUK19kDQ2oGEKwVi9WWV1MeQ6IYEcjHn13edalXLnpkdyZwTDw77D?=
 =?us-ascii?Q?HnVdNLnN0dfVLIMH79DSLotm9XFnD4YdEHwBT6C5Hc+6t+zp1nZcttCpMFZ4?=
 =?us-ascii?Q?H8u8ZmzArkjVN0n0He21eCGjeHOKECtFSa7qwVvLf+RtFfoyo48PcBu77Zpq?=
 =?us-ascii?Q?chgkWzBFPzdDS4y8EMTYVQInbs0iPcced++/c44cEGhCcVFupy7eB+/DZxRu?=
 =?us-ascii?Q?jIXSsu4MhqCq8dEuY0cTiJc3RyiNJ8BTiLEJX0Fg3X4+GK16KYG0cUwQB0ez?=
 =?us-ascii?Q?HY/Bydv+wOoFbAupEWdruQ+usTCuQeWoJDNbPoU7fPehKjqRQWoQ5KfaUQwR?=
 =?us-ascii?Q?eGTcOe2PTrD+s7eaafXKN2ymgh8k4KCkh3DZm0KNQwjpEHqqym6OhunJQU6x?=
 =?us-ascii?Q?DWvmzAndaf7fwmFD0BhJZuL/Vp51zDIozYzJm2FXhqfYbZ7vUAbFF8VYj3qE?=
 =?us-ascii?Q?rIB85eoLCEr7/PmYL5n8IwiwFTcsCkEL/tVW3wJ9Hi+qi+fMu41Di9Z/ijFp?=
 =?us-ascii?Q?odVS3xrQR3sCAxfmb8FPP9hOf/pWEjCcHU957jsrLVt0lo6q65ZDmJU51NdW?=
 =?us-ascii?Q?9jb8d0KpQyVugIfPCAj4P4lVcg5xTsHa3/IcB7LSjURIaUoUOpfQJ+cX80R6?=
 =?us-ascii?Q?j4o2t8wiMtJEe54TDgc8u+eMjFv37QPHbsWKwu8uHtxhIu3MOulE6190VIH0?=
 =?us-ascii?Q?KIJQnWVQM+yDwR17txVpWCCLzcMz/MsYiu4k25UDAyqFHAb6y+2VH5562r8D?=
 =?us-ascii?Q?5eS4OSZlbx4WeeeRUmz+qI6XMPFJ?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4320.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?G7rbDELVYr6VZ1ekr2wmbmfmq6LJpWePDlqsBNpYcyLLf8KpwvVdsB2D4aXW?=
 =?us-ascii?Q?lNaQ6tFg5UUBbt14s1ggDjuu81ubLq7F8mCpoNVbsEy9qeS7LlaVBn0yaeAC?=
 =?us-ascii?Q?Z3xAnOnVrXxafNVv75m8Pnz2mC0vFFZ7x/IVUwfaqLxvNQvjDWTKrvzfw9wI?=
 =?us-ascii?Q?1eMAqW5lN76oE732t87ELHfTdm9JgDjwOQE5+hgmVHN66Rpdr94/x1dNuHVA?=
 =?us-ascii?Q?uvC8jhajAJIxRJbu2w9a0M5D0PfRVf6Qc8okNZuMVzfNIAL9/2s36T00N6c0?=
 =?us-ascii?Q?Or5wE0VG2Wo3hFHRr5289ZGpcPhN1fPBzYZTMWYl10LaWpX4iaR39FTGdaWo?=
 =?us-ascii?Q?dUWLDP27p3caZ7kPqgngGmhzXQB0ujp5CdKMw4zvQyUoJC0/n4eZChR6RLVd?=
 =?us-ascii?Q?MJrby/bpJ4SGgA+5DPU1MDJRVUtbbxlh4wKecQKzxdF6yrRx/N7IRmTcKaH6?=
 =?us-ascii?Q?RY6FvgWtctsrNHOfHFFp5yNToqijs3wcuC/D+CzHQvx0xoq5pBT02Xb10B/J?=
 =?us-ascii?Q?fqpgh2hNVwqf8OCLPj666VrOAvoTLJOfrw0tooGoypuv3qeNeYGqTvDA9aM+?=
 =?us-ascii?Q?XaYlu4oyXPhbAZ5ytesoMY44cswTmAaESpT04QJhUMe+IFZ3FiW5PifuFqa/?=
 =?us-ascii?Q?LyqviazTEahDBtYCi3Oit7kphj0QhjE14EYs2fsuRBAunM9X8Gx8mn1HoK6k?=
 =?us-ascii?Q?hUdRjR8JvWl79lUTGUiNg/HUK0j6atWC/tNASXkVhxRnKSe+bcKZO5DsBv7e?=
 =?us-ascii?Q?c5Xxzh81pX/rKWoOLo/IPJeUZMNe53J4jq8naCHO60/UcSv8Hl4AJGdELu06?=
 =?us-ascii?Q?WQ0uOTK/bmdi5TRWIBHYSuK5dZIOiCQigokkcXXUhCYNqIOi+8XKjJJBtHhv?=
 =?us-ascii?Q?V9obs0KdTs+6K4y+X21Ek/Ek+leoEP8jA17JMvR9Z6b1mQI9/IRd/cQpZiOr?=
 =?us-ascii?Q?CkxySOXA89ElIA/c3DsngL0AhmAAYjv1F1Aq0++06TS6tbHpug0UQFybe6Rm?=
 =?us-ascii?Q?8nVzgw3/6A48HQI3TqkfunfuMCcJLndTUIHZuJVr2UVvLfShrnaqinUmh/Dz?=
 =?us-ascii?Q?SJhaxRZuQeK9FjTNs4gjWySUBp4sGeSMmU/Y2YkNoYasjUsMHWqYz65mq0OZ?=
 =?us-ascii?Q?se3jMcsLwvjuHJCOFJVAFIStix4DXbshfWEHbEND+ecQgeI7NcSPSt3cjFbs?=
 =?us-ascii?Q?WaKYWkLYqVn9J5YXU4Yf8JyYRU18YMENarLFpQGZu6yS3lc7EhKOnc4B0lZl?=
 =?us-ascii?Q?CJuKXa66OCkNKM3K8dZ3jSb3rsVT9MRN8ngOXniwVALag5maSZrCWLCrNlsQ?=
 =?us-ascii?Q?Agn4ty8Gz5UvUVxN/IrCddG5PrVqL4pvgeJW1yI+yuyCaENZLyxxerBwcIXr?=
 =?us-ascii?Q?c6UHcd6bNHYWUJU3ZDGixJvzykdJ+K3Ssh4AcV0nPR7Ir/pnpe2ZhSi6yt2B?=
 =?us-ascii?Q?wFjqgUU3p4emjsSVMxH+HfIf/LY+xkvEGj85Qp5bOLobHLSLlM+7W8qawdK4?=
 =?us-ascii?Q?XgG4YtDnQvKE+u0zLAVTMldAy/sVQMJup/Ou7rZksQ3FhLmK4vnO322OAjQQ?=
 =?us-ascii?Q?jEa+osjaWOeY9o1CnqdTnPYh54ALmY/CJzuUF9792i4nSaTr4j2HUpMf40aC?=
 =?us-ascii?Q?xg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	TKNf8BtJpurvZRwprT3iFpyfRIR6ZscCS5A05OoM7jyDAT17vsRfA4QnYgADSL+OY/5Nwg868fT/gLfizMFjkxA02ToIBMQ3bpRPMgR5ZtbvfAcMSnt6r84BXvZtMq+jobBwhBElSMfyg4oL8AnYmgLS4MrgRBN8dqQNQKOHWS/QQdCFMBnpmucb/0+xWHavu5vnapW6cRrZEdtqN1oneRKXTTP/T5EPq9wwzLat4JYxtjmisQEPe+qXa2reKWzUOzHNBAdFX9eMeQ/M7cFkXZBxFxISs4ck1fvTQY7V9nBq6azi4Q9omCEo54hQreWnCUgbSea52lXuGKAEAcaPfwrcwQ5y/fwEgH5CvlVoisoSr467eNJnuxOf9uRhWUI4CtgtP0MTIH7Ksm/jX4nfBAIc56CZ4T+9v6xbFOyCFpj1tsG5cRrW6uhnDoGGkxy7cPq/8LbR60smEfP9cLjgYqQQQqXT4jKozGbc90E6HGo9OdMlhaA6LTxO+YbT3bnFPjiI/PG0ZvLQW/TCt2T1V2SbTWmhA6zBOt9aKknBGiTb4M0uGEGRMOgKZGryuGdUB2lwiqp0F6okPvLVtn0ERIeT8bmA7/FZendrsYmKVeU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 72941f6d-edac-447f-bee1-08ddf9c23ef9
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4320.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2025 10:24:43.3529
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pBZHyQHhBgxADeyguJg5Sssjam2spsVYfC5waVeK8GIOpsVLs1mnJkdSR4/VGxQSc8ls+n912meoVSB6wdj1qA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR10MB4293
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-22_01,2025-09-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0 suspectscore=0
 phishscore=0 mlxlogscore=999 mlxscore=0 spamscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2508110000
 definitions=main-2509220101
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIwMDAxMyBTYWx0ZWRfXyNsXK8Phdrte
 2Y679rANU4JWFGU0oWUGZPXXyZ/uV3Gvvr0xivp3tlatPpZp1yzD6suk4G72ymf6Cc88OoJHtoz
 t3Lm71q8joE67xAZoV5avyFjCqoyaqtHqyQSYp+jKtBUhFg6Jv7pq4stDUjJsx4XWXD5p4ikxZD
 l3QecgwuYvKI+pJ5akULnGVXshW6kGmWXuSNPtx/2oMGA3ERHn/bm8etVvyb8qbFSe+QxvFCjEc
 z3moy/NcAKgX710wRiK9QODPau5lvu9jyzUL+xCxzof+0WqMXtL5T3uvnMCBvhIgLgsJhM0dXUT
 8yH9i47YqwDwTcGscrw2JyA3YGwFGlnKCTYWToNswryPcG+42XhR496Mof4W29M8DXd10Jlp2MI
 QhPAqk2T
X-Proofpoint-GUID: FW8LJ3zgSFkfKr5VHm__bNm7csNMwlhy
X-Authority-Analysis: v=2.4 cv=YrMPR5YX c=1 sm=1 tr=0 ts=68d123ee b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=yJojWOMRYYMA:10
 a=GoEa3M9JfhUA:10 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8 a=yPCof4ZbAAAA:8
 a=kbZeckHvrlXEZlkM69oA:9
X-Proofpoint-ORIG-GUID: FW8LJ3zgSFkfKr5VHm__bNm7csNMwlhy

Add a helper to find the minimum of two numbers.

A similar helper is being added in xfstests:
https://lore.kernel.org/linux-xfs/cover.1755849134.git.ojaswin@linux.ibm.com/T/#m962683d8115979e57342d2644660230ee978c803

Signed-off-by: John Garry <john.g.garry@oracle.com>
---
 common/rc | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/common/rc b/common/rc
index 946dee1..6406b51 100644
--- a/common/rc
+++ b/common/rc
@@ -700,3 +700,14 @@ _real_dev()
 	fi
 	echo "$dev"
 }
+
+_min() {
+	local ret
+
+	for arg in "$@"; do
+		if [ -z "$ret" ] || (( arg < ret )); then
+			ret="$arg"
+		fi
+	done
+	echo "$ret"
+}
-- 
2.43.5

