Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDD9328643C
	for <linux-block@vger.kernel.org>; Fri, 12 Sep 2025 09:58:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757671100; cv=fail; b=nkUMlWV+eK6uq77v1eeyVr+RFg1KhcTSIGYwtD4VXPdaTwAuwxjjRPkbSF1nnztoznNilBFzNSDfw2s8L2H4BxGjTIZdTtzqTZ/KfQjL/gFosfl8VcB03m1tS1vxl+xY+GBZoATIsKDZtTvV1FMQd50UZGBmwupQyVr/GseJoX8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757671100; c=relaxed/simple;
	bh=/wJY7DfZkpp2irfAvc6hQQwYvbHr+OyGRQ529A2Y/RA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ub2+UvIaoVhp0Z0vTxLFSoOKJOUQTt3jMbUK2S8Jqg7C7OOuSlDG9Q0H10l0c2/5UZ9MMEp32mFk6sllUqYX2vo9QY9ajtyDDnB1apG2qSGqoiHiU5qClf1yuVm7HeFBxXLtsCTBwzmrbZNrWDcZscqlUXLDgI3ZlhoYXey5CZM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=bay6iQOK; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=TCg+cX0D; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="bay6iQOK";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="TCg+cX0D"
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58C1uBuW016704;
	Fri, 12 Sep 2025 09:58:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=kIQFMQ5+vYlkt8qZWFVpOtM/ZT81jHtzgrUxQbSNw7o=; b=
	bay6iQOKpj+TEgwBqyXMunq9Ln67bhdRNH2rzFS0iIt+o1TnbA44ThKm+3hp3Ldj
	RmBOxHodQD3oodJ37ClL/jzVcMNRFn8wrQg22NJC/GxH8PmEzpKRqSUkgS2x+i16
	+57zC3b0h35YPC4+Mze+ONuETaajhsa6Za+Atm9Gg3o7EnHvghG3eAFwmBU4D1V9
	UvY5okn7L6YfPQ/jGp3V7fOi9Jt3sVFP+77jgiVjiOlZ2/A2U/TGzNuo1QftDa74
	VCymaeGPJmpAPcM5xnRxZVansVVIG5Z53MOJpdrXt8eCUyyHvNTdEhslb2AgQxG3
	hzhI4g+N8NBvqnl9IAE6kQ==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4922967yk1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 12 Sep 2025 09:58:17 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 58C8uNOu038862;
	Fri, 12 Sep 2025 09:58:16 GMT
Received: from ch5pr02cu005.outbound.protection.outlook.com (mail-northcentralusazon11012047.outbound.protection.outlook.com [40.107.200.47])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 490bddnqaf-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 12 Sep 2025 09:58:16 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oTuzs7pyHmRApsNCFekJ91wEcT8K//9E8EKjGUN+NW7m3auDTHqwIiz6ySLSV982HyHc59fUYfQAL39u5mqsTNSF3w+V5PBNm0m/iBoYOGFioToYojoiIbEJ4IEvw4hiaIO8t4NZxlz9yz0UJB3rhkvEt6RSsXLIR9TeSUxLL0YZoulgMdwSdFpgZbihFGhMepLWL/0CgwX9usKSC8EmjzwZrh46qOki7yo3w8dZnG85s3uIoHudN1K72vA8qUWfOSxc4ueahwQJ84ckf8O3KgKHBgWTGcm1IexRCdqgNebPN1m0+NBJFoPxmx5DCmWYkUTyKDGZvZTYlNSZ6Kiz0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kIQFMQ5+vYlkt8qZWFVpOtM/ZT81jHtzgrUxQbSNw7o=;
 b=x7XfxnjLU2rBK9Ev4eHBQY/POGhTWDeX9wHwk0dg5P+XU2zj4wWB1cmHkImfRDAnQAHBe9B9v0F5UUbrrMRxZGGjZqVD7ucnzeLb1bEQ+RpC9kwdBmtrCeOIEIuOBMM+owgIvE6+M8Xds4yQJNk036pP16lIi+F0lVpo46DkVfHooXmqb7s/YaqkZ93/8eN0CQ41jkJugvHhSFGaC5jBnxrrVocbRlgjz2xDxGCg1QEpNCMW80HCZtmNGCR4K0f5DndQuD/CbeCO1bDilSRBkzH1sSY5nCUTZHqgpAZk9TKuOf15AUsyJoKq1El1Ix1exdw740bBDrbEICvF7Tn1cw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kIQFMQ5+vYlkt8qZWFVpOtM/ZT81jHtzgrUxQbSNw7o=;
 b=TCg+cX0D7aVzV5EuBXHWXWatxVm8ijZlzFLUlB0Q/fDwCA9JYbWBvZPNyc5RC51qdmif+uHRW2kQz/kDZgxO/4MLcui+41sCANc/7+ANzEwKBJcepl9QAXbYbFriYwc6115AUbdUbxfQkSkir5uBwZZpMF0miJumd7lylw057Qk=
Received: from MN2PR10MB4320.namprd10.prod.outlook.com (2603:10b6:208:1d5::16)
 by DS7PR10MB5118.namprd10.prod.outlook.com (2603:10b6:5:3b0::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Fri, 12 Sep
 2025 09:57:49 +0000
Received: from MN2PR10MB4320.namprd10.prod.outlook.com
 ([fe80::42ec:1d58:8ba8:800c]) by MN2PR10MB4320.namprd10.prod.outlook.com
 ([fe80::42ec:1d58:8ba8:800c%7]) with mapi id 15.20.9094.021; Fri, 12 Sep 2025
 09:57:49 +0000
From: John Garry <john.g.garry@oracle.com>
To: linux-block@vger.kernel.org, shinichiro.kawasaki@wdc.com
Cc: John Garry <john.g.garry@oracle.com>
Subject: [PATCH blktests 4/7] md/003: add NVMe atomic write tests for stacked devices
Date: Fri, 12 Sep 2025 09:57:26 +0000
Message-ID: <20250912095729.2281934-5-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250912095729.2281934-1-john.g.garry@oracle.com>
References: <20250912095729.2281934-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PH7P220CA0035.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:510:32b::30) To MN2PR10MB4320.namprd10.prod.outlook.com
 (2603:10b6:208:1d5::16)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR10MB4320:EE_|DS7PR10MB5118:EE_
X-MS-Office365-Filtering-Correlation-Id: 22915266-fd4e-4321-96ae-08ddf1e2d4cd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ss4VEgXwlerKpk+IHZf2R0zPHrE5pUjElIqZYZrYSLGp+kOXg6ANAeYZMHez?=
 =?us-ascii?Q?9hOKkTYqTVRMBxTNIGcrOrAOec02mHYCuJySEyq6bvLm7K8FnUv/zQ4CTfGV?=
 =?us-ascii?Q?ZbC4f3gNReUPut2CtRkZJbkTt8hsqcF84IzsXI1+ltM9BJCD8Ur1dhTavdb3?=
 =?us-ascii?Q?mkE7JflGMVDk3UyFs03upeOeDQfH6aQ6OHhctiGP/7G/t63AcjPq4KCX1eXF?=
 =?us-ascii?Q?iKibqejAd7hKK7BWEPA9Vxp7bWXKOyHf6hNn4qtbEWshZPI/TR1Yza2HNFV/?=
 =?us-ascii?Q?VGWCy4AZOoh/LXQetLDdtZYWMHlpMM/Bf77d7Vt29tNDgWH4HSKcaPLoZu7L?=
 =?us-ascii?Q?5YyMTYNOU4+RZm1XxNoUYGbF2La/5jIHbAEl+z7qP136nXopS4NIMC0MJQtH?=
 =?us-ascii?Q?1x7KTi4rZA/diC5BVv5LcN+qOw7ijxH72XnPzksab2MDClzGlyPQZy9doo0G?=
 =?us-ascii?Q?SeHuyP+N6o2LvcciII6lgimPwt4UjOUvtvLdC7qiPKeHraXgrixF/0Tu3UXk?=
 =?us-ascii?Q?Itw3+RTxaMWjH2miawCONoX871/TA2w9Zsv8EDWt24f/xiPLrsHRxgZBfAKx?=
 =?us-ascii?Q?mqqNzgFevtuchSgceNWAIVLluvrHSthgBsBf+RwpovjijZnRlBG3BwcUg9RF?=
 =?us-ascii?Q?fFaPuPMQrLMTVr8I8DLYoOsBN7Fs5Zc6Ev1PG4jy+EWLvJESAcjwzdtXwO//?=
 =?us-ascii?Q?8ZbFjqoZix5BnSFD57XSMgFcGn9cikgjlQJ0uClNU8wE6NhMkRoC07iIZ3BY?=
 =?us-ascii?Q?RacX9n3ClNiIB+Kg5PcYdnRdRLWxm1fxzwxrOwIs2rJyn9Hmir7NGqdrikZt?=
 =?us-ascii?Q?RzKBtTx1CGrzJURJp8H+lq7jqhKrdn7HKmOz7UETduvT3fkCME0WRccmnXDK?=
 =?us-ascii?Q?ity0uKt3E8QwUdQ5o9hB1R8Sp7CBleYW9Mcza/3fJbLFl/KRwgvf7Qbjm6x6?=
 =?us-ascii?Q?NgA8CqeBHrUSeQPcm8N3g9U8AlF3J/50OTjggfOiCSRvyZOVFT88BWKV8E9R?=
 =?us-ascii?Q?ObUbg8oI4ogEIx82qVGcNJpK253yfpTAYypalXZ3lFX/c2sSX5MTAJOLL0Yw?=
 =?us-ascii?Q?x7rdCCO+gn62GuJCO2nOkDBQ6OGspmdsFioFa+Mbnwh7MzpEir4doNsaAcTt?=
 =?us-ascii?Q?DF9V49hDsTLB8nl827xF7PoIFjXbzOqvUOK0hfIQuR/2gWCFwEyFjF5+QYvi?=
 =?us-ascii?Q?MTat9fgSqM4fYy2WMbrJLfLfpGCGS4DRVah/UxTAsw0mXofCPU8e0GUZyo9p?=
 =?us-ascii?Q?f8CJTuZ1dNySrodAeJMrfltyv9HSdlit1coeBJOiopTsIYdQpTK62MOz12BT?=
 =?us-ascii?Q?6oWRoZSEH0Zz3R14Hbdvs+z8OgVgu2NotpvlnipkHy4yFajfMuAUTsqGbsdA?=
 =?us-ascii?Q?VMlGzsIQbLrSWZaQxqf8vxPU5G6YNIq9E3/hzSQxst72DjM2jwAE5ahomAjr?=
 =?us-ascii?Q?2AAZYNoqExk=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4320.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?sb/XLbXyRvnW+tWfkWyxvCdezATi0qzGvyCkJmLaqUYj/1DTFETHMC/HE8dh?=
 =?us-ascii?Q?HFnJK0vMYeYLmYyV6HnjQNk0cM3vpm+X92OhPkjOFa3bgj2wl/dPHdWRWSxb?=
 =?us-ascii?Q?wgB55U/0lkvucvfNpuZi3Jd1qIt5qS9d3GSFHdK4gH1VsnqifS+wqRkN3R5d?=
 =?us-ascii?Q?c5eFc0ak09/EBmfI2hiJvZMRMEv5BgWyhxXfBP+U3SUtvhKObSSoPsGdoayb?=
 =?us-ascii?Q?FueOSp7E9IBdt79LZvU3/pWYRP7MPkA7l/Ivv+1rw9oHOKGS2WoPtIgJ6HYr?=
 =?us-ascii?Q?g1yOLyl9fQGFLYVbGWsZpawVt4b1yHX9tq6URaKGgJSizEP8bc5v4casaPBW?=
 =?us-ascii?Q?Hi181jMesvfC9K4HW6JFlM32edvEiBgQjBUYzgR3xPnmLkMrtmcpDJhGb0Lt?=
 =?us-ascii?Q?DvODO+6EuLZYtRz4eXNHN/b+K5E9NSTd/1tzPHdRtQpAP1TfryLtw4gCsiEY?=
 =?us-ascii?Q?C4PyGuX2l03InkC55o/hdgX1/evOujkdXMp32C/S44ZSJ1nF24d8+lbWlGKy?=
 =?us-ascii?Q?+kz4Nu5IT76V2iKlOSK11XoETZfuLJFjFaEBEa4FDFwlMDFa8Dz4zNwyxPoV?=
 =?us-ascii?Q?DeL6Wnpu8XLd7XP9FQPUkvPgdQaec0um+nO4EvyZYVY2eso1jRTohgVDIQFi?=
 =?us-ascii?Q?imppYsAC1FEdUjqyvFsikOhPf6zudZWxlUTJXh5GT/N9KyKHsmReo5146DYW?=
 =?us-ascii?Q?udD9NDLfAufumEODciYQ8iJdL6zi57UqeZLtZ2dWCTjaQd2Rqgor8ICH5ZxJ?=
 =?us-ascii?Q?10150vaJDlZ09AMreYPZDqbRqkxnVlnrxJT0y/eyEekDOvkER1bAmv+owGNk?=
 =?us-ascii?Q?AcqMwrZ26temIrrDVmEaanvIEr9NyDGDXgc3A8kBMo6ceUoV2Ayk1UO6J130?=
 =?us-ascii?Q?IBVNznJttXtda4ynQlixN+OC3ioeZw08hZ9znXazteHyl5rRBi+48B5PgsDN?=
 =?us-ascii?Q?q7NupWiYMI0einTTCThK+Pll2FrwdKSKUxGwJxgdc5hohlckRvdcdqTAQZKS?=
 =?us-ascii?Q?Sf2Te1sZOzCLDB1iid7RFVfqHuqzDzqte7w4TSiQnFkO/BU1hTi6AXOkdUzu?=
 =?us-ascii?Q?5DPtqIfhZ57KEo+xMJPwOB+ltxxibMPfJsZFKVnmzTMV9NWXUqGonafKYN9d?=
 =?us-ascii?Q?+1pIu9JDZKpmmI39Br3u5YGe77US/jcaiRY/jqvgRGO7jPEFmMX/Lj+K42y6?=
 =?us-ascii?Q?ERnNXRk6xNxVpR+iO3KAiygq6wTxrnCuCy24nrDizq9Y5FHwp1ngwwFViDXr?=
 =?us-ascii?Q?uatnFgn9xEwolLbnlujrpPuORWIteN8WQRkpv9TkeeqUW5xdGgnSgFoXRSat?=
 =?us-ascii?Q?Jc9bN+RjBEZsOQsqZp2RovtH2y75p/9g161YGwe59DfunjtvUqDxDxMIaETd?=
 =?us-ascii?Q?j0UxnodO7Bm5k+EyRf3TFcnAwsVsmo1beLec2QhKPfhti1UxB53N28OC5i3Y?=
 =?us-ascii?Q?E2v31689XV8YW5lOaHjuaBb9XiOt4vt29SsVCM6eXLc9CZMnjWPTFnQISf+v?=
 =?us-ascii?Q?lSlBftRmvvH4gbpFwjxwOUVWIH9uyoNLpwCcxpR96S5jvRc+QyEjcve79JcF?=
 =?us-ascii?Q?TtQ/R63Lm48WtOkCHb/Ydn6sWuMHDECHRDQbo5HoKgHV4IsOAOs4DzqIqJ9x?=
 =?us-ascii?Q?Mg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	4VmPfe16VE6A3KHKCOvWfFDRW6YWCpqk6FpVcinX7OU9pZuLIujL3W6rgMrEGe0hrkMRKzgN//YzbXF2Bz1ABd8qHUsaxEqwW73MFwlikmTxKpH+4Zi38A6t30DYE5Z7J2l153D4qxKUVDCPl3NDdhvZKMvCoV+xYhdVsdeYAtnuE08DwoRPoe0E037iK4J5vwUPuvLQfTLSTyrW6hxADIfySmIvSlEkH3MgMq1j9QWLj+Bug/R4MNFZjH3tJirGSaeUsF60xn7HeA7pJseL9QPgolIBMNpKNjbicMKoumi4rhmgf0BcT9r26iECqwUrDAXtzZKbTxnCPZYoQUWdACo3/L5SjJnoFyqOzM6SlsZEUdx+czj5eS0FyEUKmxRKy6WMYoNiBYBBrFMkY07TtAzzJdwFUGDPULKjbAFN4o8GlC+5IUgW0r5LS7/Euvm/D9y68PfM4FOz81ETE0CTIalUSc5yCA6xElaMu5fnQDH4h9WADDbw/hIGnIGgBsEDGiQ+Q/Y4EMsGQznYn7nC/nzfp7elKy5wp+kONs5Cc4JCEiaSyd/14ZiECTep+GteU5QxQyyreZXHwocc/8O7pfBHfE2F0wcddTUiacEkH6s=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 22915266-fd4e-4321-96ae-08ddf1e2d4cd
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4320.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2025 09:57:49.3416
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2x4FQIUMJw0E5m4vi8AO93fzC+g/Gbwkt0t3K6W9GDmyceA+bX/ePHovdV2uSKhaj7Uk3Z3MDzOThRaxDFws1A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5118
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-12_03,2025-09-11_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 bulkscore=0 suspectscore=0
 mlxlogscore=999 adultscore=0 spamscore=0 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2508110000
 definitions=main-2509120094
X-Proofpoint-GUID: MQ47TmQYj0rlqLeHP3VbvhFc74J1T5FM
X-Authority-Analysis: v=2.4 cv=CPEqXQrD c=1 sm=1 tr=0 ts=68c3eeb9 b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=yJojWOMRYYMA:10
 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=BTtKC8koXsyJMWZaKPgA:9 cc=ntf
 awl=host:12083
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA4MDE1OSBTYWx0ZWRfX+foYxxRukhWt
 bMhSW2Jnf1rvl8cVwRSvdUK+AuLPDoWBdrsfn35j/IY6xgcO/9bOrBbsn/pfCGkGutnCVaWvwnn
 InPOxy29nhBOCL93s75gDfEFY8QQiJCWnC/VKmgHqSXn/5a2A1NFf/xB6JRKZrrrvthUEkGiBXn
 OicTVC7Vt6Mh9+I/Uv5/UDSQrECeeG1BAt6qzNCbmgt4bqi4tKdq3+sw0jUEPmm78bxxwbsUwP8
 FkhXDYaClpqD+rAOmq8jDS60vejEKIvW+X+uDk8GbSTR7yo2NqieMUc4rSzxyxA3Id5Q6sfCbRH
 SH3oZfruGo76ssPisMYz1ZIdVQcMnyh7efm8qPM7g0hcyjN06YSGVyBjjQTS1reejE/zQrh+5RG
 RSU+ozDXwaqIRaw6iOfDGav2UiTXJQ==
X-Proofpoint-ORIG-GUID: MQ47TmQYj0rlqLeHP3VbvhFc74J1T5FM

md/002 only tests SCSI via scsi_debug.

It is also useful to test NVMe, so add a specific test for that.

The results for 002 and 003 should be the same, so link them.

_md_atomics_test requires 4x devices with atomics support, so check for
that.

Signed-off-by: John Garry <john.g.garry@oracle.com>
---
 tests/md/002     |  2 +-
 tests/md/002.out |  2 +-
 tests/md/003     | 51 ++++++++++++++++++++++++++++++++++++++++++++++++
 tests/md/003.out |  1 +
 4 files changed, 54 insertions(+), 2 deletions(-)
 create mode 100755 tests/md/003
 create mode 120000 tests/md/003.out

diff --git a/tests/md/002 b/tests/md/002
index 990b64b..87b13f2 100755
--- a/tests/md/002
+++ b/tests/md/002
@@ -24,7 +24,7 @@ test() {
 		per_host_store=true
 	)
 
-	echo "Running ${TEST_NAME}"
+	echo "Running md_atomics_test"
 
 	if ! _configure_scsi_debug "${scsi_debug_params[@]}"; then
 		return 1
diff --git a/tests/md/002.out b/tests/md/002.out
index cd34e38..b311a50 100644
--- a/tests/md/002.out
+++ b/tests/md/002.out
@@ -1,4 +1,4 @@
-Running md/002
+Running md_atomics_test
 TEST 1 raid0 step 1 - Verify md sysfs atomic attributes matches - pass
 TEST 2 raid0 step 1 - Verify sysfs atomic attributes - pass
 TEST 3 raid0 step 1 - Verify md sysfs_atomic_write_max is equal to expected_atomic_write_max - pass
diff --git a/tests/md/003 b/tests/md/003
new file mode 100755
index 0000000..8128f8d
--- /dev/null
+++ b/tests/md/003
@@ -0,0 +1,51 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-3.0+
+# Copyright (C) 2025 Oracle and/or its affiliates
+#
+# Test NMVe Atomic Writes with MD devices
+
+. tests/nvme/rc
+. common/xfs
+
+DESCRIPTION="test md atomic writes for NVMe drives"
+QUICK=1
+
+requires() {
+	_nvme_requires
+}
+
+test() {
+	local ns
+	local testdev_count=0
+	declare -A NVME_TEST_DEVS
+	declare -A NVME_TEST_DEVS_NAME
+	declare -A NVME_TEST_DEVS_SYSFS
+
+	echo "Running md_atomics_test"
+
+	for i in "${!TEST_DEV_SYSFS_DIRS[@]}"; do
+		TEST_DEV=${TEST_DEV_SYSFS_DIRS[$i]}
+		if readlink -f "$TEST_DEV" | grep -q nvme; then
+			NVME_TEST_DEVS["$testdev_count"]="$i";
+			NVME_TEST_DEVS_SYSFS["$testdev_count"]="$TEST_DEV";
+			NVME_TEST_DEVS_NAME["$testdev_count"]="$(awk '{print substr($1,6)   }' <<< $i)"
+			let testdev_count=testdev_count+1;
+		fi
+	done
+
+	for ((i = 0; i < ${#NVME_TEST_DEVS[@]}; ++i)); do
+		TEST_DEV_SYSFS="${NVME_TEST_DEVS_SYSFS[$i]}"
+		TEST_DEV="${NVME_TEST_DEVS[$i]}"
+		_require_device_support_atomic_writes
+	done
+
+	if [[ $testdev_count -lt 4 ]]; then
+		SKIP_REASONS+=("requires at least 4 NVMe devices")
+		return 1
+	fi
+
+	_md_atomics_test "${NVME_TEST_DEVS_NAME[0]}" "${NVME_TEST_DEVS_NAME[1]}" \
+			"${NVME_TEST_DEVS_NAME[2]}" "${NVME_TEST_DEVS_NAME[3]}"
+
+	echo "Test complete"
+}
diff --git a/tests/md/003.out b/tests/md/003.out
new file mode 120000
index 0000000..0412a1f
--- /dev/null
+++ b/tests/md/003.out
@@ -0,0 +1 @@
+002.out
\ No newline at end of file
-- 
2.43.5

