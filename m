Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E5D61F5F6
	for <linux-block@vger.kernel.org>; Mon, 15 Sep 2025 10:35:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757932523; cv=fail; b=NUsJ+CWslcXEdX0ANk6Z6eR/JsrvphMsoejuejjvYN28mJ0v5rFr/IGPPATeGIcXu+KpZ2sy4+pHr+hlr7Ef9GrTYzen1/swKoXSwAtD12pt0qMAq3ky7eeBtbaAK2k4CMl6cqySdzA56sA1DuBBXaCimdY135Yk4eg8o0XsTgk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757932523; c=relaxed/simple;
	bh=zzYF0BoYNEfQQD9p+3ty96xFJXVn3qIUIgd/gnudBig=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Q2ZTn6ID/gA5/Dh1xdiJtdYsEwzt+FFcWt1zYnc+1lL0UrgGgX44+uF03grixFna7VEUX5JDJOx7NrHJRQizK3ilakzEy4SqW1/Ch8FT2k2G+gRwaAanN0+3op+rJSMV1upz3TMFlMNcHtSPrvD5cA7G08gSelVBgHpBRB9JCDA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=HOWqBA5k; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=gJq9x7Bv; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="HOWqBA5k";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="gJq9x7Bv"
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58F6g6ox014450;
	Mon, 15 Sep 2025 10:35:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=NorjxsZXlt1FJoJANl0ajQ8bPZ8ssZKzKyyLpceoNBk=; b=
	HOWqBA5k4RbNH29ED0XEUsNYBiuGLt11kKgjQhEnIUw2EQi8ZzotJSmY01NY3BT6
	qyEfx3vpqWylIXhKDvsTbOlFojaEDZ68SAAvxlWw4oyPMqtdfU+MmXIU4wLeOoaE
	ScK+fS2dWUWUvk0pZXxkwLJOMDU0XSAjBNELs4xwmgJiTSX2nvK6iowXo1XZ4qZf
	KKSm8UlU8DjBRvzOC9uoqkPf8mOjeEcYwT1fyBIr7mXvEW/YybiqJFUwT4w//clX
	Jknbq3nP5yxmhi4KHb2YphowybiTasivG9eoajlpg+TDRNDqw2Tz3uPhWLUxeacC
	ZpV52f099LYBGtFAGvNL0g==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 494yd8j3k5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 15 Sep 2025 10:35:18 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 58FADxj6010926;
	Mon, 15 Sep 2025 10:35:17 GMT
Received: from cy3pr05cu001.outbound.protection.outlook.com (mail-westcentralusazon11013039.outbound.protection.outlook.com [40.93.201.39])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 494y2au3ah-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 15 Sep 2025 10:35:17 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=u+b3/GQbTRpKCYGKzJkndyLANLpni+qdqv3ahdoKPDh+YfrqWdHn5h+HytTmV4TzAQJ2Vac7HQFDvTDR4uhLzxpsj2ime3GgXCZ/fZxvMMs/FOuyoz39M98341H+JEzxvaqYh097tSeK98SnJEOvxpNT35M7P/2ylY+CoUkQBLloVoDDLRolg0yFhDGfC4mdbi+C8FHoszG91V8BVYEsdaXLo1Djr2TY1oz+Iq/t5D3a3HLq7lCanObT3uC9EqruktV8PITHdkIOuJcznah2Y8w/ZVyUyw05SRN+kMydpYk7Bc/0OFppwbbFLZZm/+nWx33o203bytz617A8r7LUtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NorjxsZXlt1FJoJANl0ajQ8bPZ8ssZKzKyyLpceoNBk=;
 b=qJI4mA3IstUi7a42EKQfD4mpMFJ5YtEVpK9GPj+WTBxEk0pywTZpJSca0VuFHXNI5/xZZHY85LohtL5JzjhPsOvPz9kgYPbGpxmVrRYAA+zVLfgA04u3BR6e0rAEqiXq9B2gG2hBZiGinKZyDODxxnqTm6/7S05u8NpjxMfyfMCEBbDBb7K1wFWFPmnF+0Mh9xZz7uABzIbLiLgRr9bLNcKWxC9eftBOfUH15R4M+6lCLFAe5h8ej3vztV8iM7YoBTNLKTRjhCRMxhf/g2KVjwqWIdwgXvoXwi9kmk3fR7zK+cid5fjepu39nRli6qniqBMiya9X3Xhr9EvALZKSTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NorjxsZXlt1FJoJANl0ajQ8bPZ8ssZKzKyyLpceoNBk=;
 b=gJq9x7Bv+uU/h1F0bhLBBSu08xvS2AqHo1N8Df3hvg9w3pYqzc7mkQOToDJQszF8loEIosiFl8TvpmmszUifXa+59BNdO9Zo604ns9cwI4bkptZupObFmOe1yr80em6qI1ThqRa7ogRGlbEMGfB0TzKsJh9IsDCuFEfVeKBY2iI=
Received: from MN2PR10MB4320.namprd10.prod.outlook.com (2603:10b6:208:1d5::16)
 by CY5PR10MB5962.namprd10.prod.outlook.com (2603:10b6:930:2d::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.22; Mon, 15 Sep
 2025 10:35:15 +0000
Received: from MN2PR10MB4320.namprd10.prod.outlook.com
 ([fe80::42ec:1d58:8ba8:800c]) by MN2PR10MB4320.namprd10.prod.outlook.com
 ([fe80::42ec:1d58:8ba8:800c%7]) with mapi id 15.20.9115.020; Mon, 15 Sep 2025
 10:35:15 +0000
From: John Garry <john.g.garry@oracle.com>
To: axboe@kernel.dk
Cc: linux-block@vger.kernel.org, nilay@linux.ibm.com,
        John Garry <john.g.garry@oracle.com>
Subject: [PATCH 2/3] block: fix stacking of atomic writes when atomics are not supported
Date: Mon, 15 Sep 2025 10:34:59 +0000
Message-ID: <20250915103500.3335748-3-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250915103500.3335748-1-john.g.garry@oracle.com>
References: <20250915103500.3335748-1-john.g.garry@oracle.com>
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
X-MS-Office365-Filtering-Correlation-Id: 05cfaeb4-da19-4f7e-867a-08ddf4438ee6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?3Dh9RGaumGxYFAByvs0jhRHcoKdCdneKDCl7HV6P3zKzQfv5qrfVu4OUah+t?=
 =?us-ascii?Q?52he26NConC5rGQCd1dKWECRTh5idb7zlt5RHIMNEfaZAj7pgbs95EChCQNB?=
 =?us-ascii?Q?fg3A6qrP5Wtj9LgXeg8O2dpi5kuJx12BaCBRkW17o1IUojHSy41BM7v0nRyt?=
 =?us-ascii?Q?a5P0nKdFxWCx5i+W0rdrnAbJhgLh1TJ9CpsgqnDudK1IDUFbZ9tH9Xy8fEXc?=
 =?us-ascii?Q?5LAuw1gtdt7mbBHok2mZ7Uxl8cesDxD9gfdvTkoqGXUzvicJtRpZA4pwOE1i?=
 =?us-ascii?Q?XqpwnhWS5imJ3fFfZPOERD6XavYE/FkKXWSIJPbV6t9baAzDVF8XHGb5T4GS?=
 =?us-ascii?Q?ckezxbn3a8aOfdfICiA+mluCtiSt9gNwz2O2ro3yrZEf72Oat2ijdHWXXrsV?=
 =?us-ascii?Q?QpJ1WFTAQB38LBl1ou4ZLUkHtucbwCk4karFch9030YqJDBvtJoVeYNrpk7m?=
 =?us-ascii?Q?cIrmXsd5vs8YerqkeFcnKnCKS7Wxw8ywTl0rCDaToFxbFh6YkPKBZIQlqj+0?=
 =?us-ascii?Q?G8L4b9IY7z1FTDCqGAfFp8J2H0Sj34KKqzh88qSYKnP4WBAkKNlAD+hJnTLZ?=
 =?us-ascii?Q?PfLh+NSCbOPBC6d2bFRLp09jQx5tt4KEvjIhgbDOvdjYEbI5qxluum6uRgEf?=
 =?us-ascii?Q?p28nkSZDV03P88t8bgCsO2f0Ki87s62nTwWv0N0rQzlPItVbXctb09eVfEMs?=
 =?us-ascii?Q?wJY836Ewdx3FlO51zFjvwhnkeGQaXTqC0us51glzaa0C9pL+5+ufz+IHwBx1?=
 =?us-ascii?Q?tev0HxIpRpBB4Cy2dXllbUSOvxUoW7QjEmCzy041xahBDC6v/CzhGoAITqpy?=
 =?us-ascii?Q?BDEQgbtNxxzeoL574vLXz8frubMgAEbC9B9A+Oy/f9ufU0ICN7t4oD36pm0n?=
 =?us-ascii?Q?y3swEOv22Rq6siFSaOdy609PwgIAyUuGvTZeOQs3JhNH5mnkF91CwIeIsHzi?=
 =?us-ascii?Q?sWyS/lbQGqU1ks0R3oD4h/D6BTH1kymizb/XaropAEkNvFg03K0fesSSZjbj?=
 =?us-ascii?Q?y1O53j5emhlKnTmSEko5pBoktY5abcDiTu4fN1xhck8JKwAUwGkBwqLbZEXR?=
 =?us-ascii?Q?Xs7QQuAfTCKo6bI0jWEn6t6Ir9qQEofrN4mvvpjsUbSabE4JQzwIteR7QUF9?=
 =?us-ascii?Q?vo6iRl6wjb0o6cQ1EGz2zF/xjxn0tyHdLrzovFFeGsft8uzcpyk+War45bO5?=
 =?us-ascii?Q?kd0HNDAo3a0XtFBS+R8i8ghVRgFra/6gjYjMkBmx8AUMWK0b4pOTYnWvZFit?=
 =?us-ascii?Q?NyStNiRRvqQ8XLNoryyyILihUE7osTHAyZb3Yc0U597YPK/7kp+LnQnp0dIs?=
 =?us-ascii?Q?kGtfZudAIL3P2kbYHMhTc4bYrJjjsCbw9ym8JfSbc/co3lWLbQ0rbuw1/MQ7?=
 =?us-ascii?Q?qRfGMAcEuZRcxve3QNrdc+uK98QvChwC3GCtU8wjw0x/dSgBmQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4320.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?o0YbdAoOhRw/V3KSmA0ODNoT1Rx6yuNSeRkMttBuUBK+uMYhkQ/iLGq2RtD9?=
 =?us-ascii?Q?InBn2RDpK3bD2tgNQ2Rkv0AngtYgFmJm5Zh8JRb1wE+yMVL9tACBYXLWaXSP?=
 =?us-ascii?Q?yVmGZLKH/5+JM/+QeoQWG2T6RJdRGng6joNBNTRJTeqRPt/sxvFCycuPgSj1?=
 =?us-ascii?Q?AQOp/slEIcKTgmxiXpDZVSXSTNpN5dkH4lWMQ8GiXkRDp/J7r1AhqmuqsEbJ?=
 =?us-ascii?Q?IbjFIaGDPbS7jjehDq9384xKTnYeYXl3smEdQV8t12FFQEHNaumc3h8lJs7d?=
 =?us-ascii?Q?EKScw0bHqv8L71zGoUqTJPvUL2f5v+OiEeZZH1r+3e/u0A3BZ6c1riKRAk/r?=
 =?us-ascii?Q?JaVYE33uYl+w3EfXjMunnOpqHJHGUM97U1ZzZhcmkGZ4biJfEE9bD0CYVyxx?=
 =?us-ascii?Q?MToFk+Nb67pEUJik0+W1u/L+iRe255dno8DFTEAxGp4uiZbkE5Y4fhZ7qb+z?=
 =?us-ascii?Q?bXgAxmJqCM6IZ4w8cCUaPCGxehWdsmyKBxCwm8RVDDqCSwZUTQF2ZmxJPgVg?=
 =?us-ascii?Q?5P28zlfCMvEuB1Ak/Ur4jp/5gtHLv7WdhchxotXwT/3h48IbBS8lOnp1ueCN?=
 =?us-ascii?Q?7/9OkhqstS99CxYEqfP+rUjERIG/cQleXqCJpGQ2785nRH187517gzf1ZKy3?=
 =?us-ascii?Q?K9LHO4CF3Z2upV5NasAkvPwwH1S/JXK7zKtuwtK07GPnWkRQhAmB53darjmO?=
 =?us-ascii?Q?bq29YUSmL6sltGeQ2rMqF48WR2mZgKnmgS6Xvro6I0znBiUabBu+zO8+AD7p?=
 =?us-ascii?Q?KNBhkvOWMw3sDKVp+Ovok/5sJttfPj9TCn9X4E7S8eqIicZPt4PZXk6ukc86?=
 =?us-ascii?Q?UwsxbX09/Mf75e+4ZdBQ90saJmWrvOp72t8EAfDxUBR4lb3orxOI+LKatrLE?=
 =?us-ascii?Q?l2AXFeNhyykeUJetg7nmj6xlpL8lSxZs9o5V879xzCeNG2LzRKjq/JzDbPg5?=
 =?us-ascii?Q?plGI4EVW74J2wB97UcjOwil3QtO+NHHBDf7yKiAB7GSIixkMWNvd45f/ifDO?=
 =?us-ascii?Q?8rZrHwGUTXNZc7SlkUp2h+9ocKtNi2ORuX78U5IX2mLEVzoXQywkIBxAtiMv?=
 =?us-ascii?Q?XIFAVNvXqNirfZP0naEzZAv1pX+WIz9f3eLxFKMglLBHkuqZ5KwRBo9dkh0g?=
 =?us-ascii?Q?GiW7DKUTIFIDItIodVAnaBmiSEAFS4wPoJux5FUHJjUr7VxN6hOcINs6nUiF?=
 =?us-ascii?Q?OKBCbc7aD1RxbzrJYxWFzanoGwsorQ08rWbuOADYRPcZvXEKdqS0KyB+ycl+?=
 =?us-ascii?Q?0HPPE8xYRV8/rdLLcKJsr6wrhIpY/cFGV77xHIPizPbaJNAJg4EosBEQPEV3?=
 =?us-ascii?Q?mYDePLHTPGFhdXOhM1c8l+2JYEA3QajvyxCx/PQx01tdXPU356fwo0er6R54?=
 =?us-ascii?Q?alI+/0J+L9bY6BfEy1ab6zBldAIbYuzhUXS9K0axTlXzQcVlt+WE304L4y71?=
 =?us-ascii?Q?h7JoQQ0w+BzuB+ko4J7KtQQrVV6IUk8f5u3OtVd3V5I0phyTJ6ZgOAd8yYo7?=
 =?us-ascii?Q?pjnmvcC6ey4U9W3ja2LQGC8v3ZHHiGYYIYJUkS9pfwMusSvxZUv1Uideu2h3?=
 =?us-ascii?Q?3zJ7HGJ+Jgwq05N70gtjLnJnLlLjPSbTcfs51QNbE+AkCDu9enl5JbYqVaOI?=
 =?us-ascii?Q?qA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	4NWRwQSPKy8uiEDvHV6L3x5A/8rmcJlFAIs2KMjo1P4nXXbqI1DDOadQZDHEHkWLj7Wf6VOeXGUhGw6eb7+Eijk1e7VjQpo9f7Vh/YXtE438jqjvinPDypbnbD7GSUi8XLm5yCojLELI4m4F4uD7iIp3TL0tRPoDrXcYHdm/MkIU6enY1VrIVM9VZR96qSgl1N4KQv315lhcNMv4V1C4lkUEC5S4NWGFuFyo3O53gzt2P0YIVX+VEiamiJwdbX8fT5mPoK1D/4aWDwg6DMNtylxDTxajJYmmtr051ZwLvaq0+jhXgiulUqwaAPkpZDd+0O2ynBWU24BsVr+bj1Ss4PNfk0iGNPsaiGNjCeD2pSyiEm6CCZemKk0AnkmUc5bZNfE4eIp3OikuuhSrYEkLbNETneOR71x1sDhyDOwP1I0FqbcLAsTs8PZyhU9NNp+JgIh4mCm2TfkqWUbidpQj3l5OsCQew68/eKD27wLKLOYOpCrR82uxtDvhaF+VRc4SYGM/PA1nInI/ujTekigrtkToUJnybbMSehKIkAfH8SVR1yEiHiWKll/JgcVf0NQHywXB3Zigmm3cPEVCOfGimTiY37VUr1Bd/LICUGB7D50=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 05cfaeb4-da19-4f7e-867a-08ddf4438ee6
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4320.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2025 10:35:15.5584
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jJ1w6fAQcLx3wZq8kPnL3adBOAqtTqmt6Ao7BwZfWIHaCq0MdXmaB4vsb/1hKEXzjgxbgsxHyITteRWMBeb3pA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR10MB5962
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-15_04,2025-09-12_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 adultscore=0
 mlxlogscore=999 spamscore=0 mlxscore=0 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2508110000
 definitions=main-2509150099
X-Proofpoint-GUID: -mQ53zm4rUZV9WOKLPa1QoYOX3n9HZ2d
X-Authority-Analysis: v=2.4 cv=M5RNKzws c=1 sm=1 tr=0 ts=68c7ebe6 b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=yJojWOMRYYMA:10
 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=PJGmqymv2iDFWGlkl34A:9
X-Proofpoint-ORIG-GUID: -mQ53zm4rUZV9WOKLPa1QoYOX3n9HZ2d
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTEzMDAxNiBTYWx0ZWRfX0/BqYrkne3G+
 /NqryfWxHLIYCQF2ivJ4E05rA1AEh6FvlsQq9AYF+Jsf+GOUBJw8a+jOU1JoLenBATA77sV+cJF
 jB3QYOJrwwQquyBHlB0DqXpwZJRjTEUepFJgAsRd6j+imWW3SxrrswUklcpnkEJWWoMVK0QB8VE
 kS7FB8ygYNYnNd9MFOksbCfPSPq2GK/gJmtap5IUD7Mcj6k525nrWAu/7EeKB+x0ueERK802D2B
 L5yD2eectbw1UUy8/IPpMiKMbfrdzCVrYg+BXSqwep4k+R3RYcPzPoRfdJGirPH/mPGg+HOmxF0
 uapIxmYySSjhYXJr+PE2xJQJaMjvAWR6LNVNcEvhKUffbNAHrxhV7UXEy5OR1jAQGAtXRBSQ5tG
 v11E1XlH

Atomic writes support may not always be possible when stacking devices
which support atomic writes. Such as case is a different atomic write
boundary between stacked devices (which is not supported).

In the case that atomic writes cannot supported, the top device queue HW
limits are set to 0.

However, in blk_stack_atomic_writes_limits(), we detect that we are
stacking the first bottom device by checking the top device
atomic_write_hw_max value == 0. This get confused with the case of atomic
writes not supported, above.

Make the distinction between stacking the first bottom device and no
atomics supported by initializing stacked device atomic_write_hw_max =
UINT_MAX and checking that for stacking the first bottom device.

Fixes: d7f36dc446e8 ("block: Support atomic writes limits for stacked devices")
Signed-off-by: John Garry <john.g.garry@oracle.com>
---
 block/blk-settings.c | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/block/blk-settings.c b/block/blk-settings.c
index 6760dbf130b24..8fa52914e16b0 100644
--- a/block/blk-settings.c
+++ b/block/blk-settings.c
@@ -56,6 +56,7 @@ void blk_set_stacking_limits(struct queue_limits *lim)
 	lim->max_user_wzeroes_unmap_sectors = UINT_MAX;
 	lim->max_hw_zone_append_sectors = UINT_MAX;
 	lim->max_user_discard_sectors = UINT_MAX;
+	lim->atomic_write_hw_max = UINT_MAX;
 }
 EXPORT_SYMBOL(blk_set_stacking_limits);
 
@@ -232,6 +233,10 @@ static void blk_validate_atomic_write_limits(struct queue_limits *lim)
 	if (!(lim->features & BLK_FEAT_ATOMIC_WRITES))
 		goto unsupported;
 
+	/* UINT_MAX indicates stacked limits in initial state */
+	if (lim->atomic_write_hw_max == UINT_MAX)
+		goto unsupported;
+
 	if (!lim->atomic_write_hw_max)
 		goto unsupported;
 
@@ -723,18 +728,14 @@ static void blk_stack_atomic_writes_limits(struct queue_limits *t,
 	if (!blk_atomic_write_start_sect_aligned(start, b))
 		goto unsupported;
 
-	/*
-	 * If atomic_write_hw_max is set, we have already stacked 1x bottom
-	 * device, so check for compliance.
-	 */
-	if (t->atomic_write_hw_max) {
+	/* UINT_MAX indicates no stacking of bottom devices yet */
+	if (t->atomic_write_hw_max == UINT_MAX) {
+		if (!blk_stack_atomic_writes_head(t, b))
+			goto unsupported;
+	} else {
 		if (!blk_stack_atomic_writes_tail(t, b))
 			goto unsupported;
-		return;
 	}
-
-	if (!blk_stack_atomic_writes_head(t, b))
-		goto unsupported;
 	blk_stack_atomic_writes_chunk_sectors(t);
 	return;
 
-- 
2.43.5

