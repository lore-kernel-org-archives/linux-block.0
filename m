Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5764C255F5E
	for <linux-block@vger.kernel.org>; Fri, 20 Feb 2026 14:32:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771597973; cv=fail; b=JE2POLW3JWqeCNrdH5YaKNJRBhG4oE3fSiDTbydEM2LH4AWN2yd8ULJYgaPZKQNvolMkDMWFi8JRB69cMGG1/K2go3sEjVWTec0mjxuQfGWzQaW+/E6vb3qhWvgLhyQ4QJMMxIODclNKvRC+waupjYjYSQi1RyhxCOUrOBAZ7V8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771597973; c=relaxed/simple;
	bh=nyKXSB4Ygxwd+yCQsgRVNsQ03gUZ7LMoPfuohjS0YeY=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=Mg9fK/tQZQdP5ALDC+trsF/nZi+ifjgVEh0JJjlSbpej9J+vdPHBwfHkXyZUR8AsVOTlMc9PubKF3HUMpznOGTUMiv0C4oQ9sHgaDBREEfHYLpc+dF1Qx2fRTDxvr54qCKDtg74DO4LHS4WnOcbIiYTWS9xU95nr43M9gAfWd4c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=o2VGuV4k; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=L3BHYZZ0; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="o2VGuV4k";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="L3BHYZZ0"
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61KDjQoB1575116;
	Fri, 20 Feb 2026 14:32:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=corp-2025-04-25; bh=1rcuzqC6tWFl0aRC
	3zpA3k+QT49i8b2c83y7+x0oUxw=; b=o2VGuV4kYIIhdLMgu/fri4+cDcIC2XWa
	ObNj0H36plgnxYzLanRAtLYtWUkZdma5Vmxy3+xmT2jluatxq6uEeGtvECGFAQuP
	EdndWPJfAE9oNKC+gf8h5hcciT16wybo2xLVSWVSbXp5Ar/o7SrJlB1A61gWpsKp
	mQNjzPoj//LNQOXA2CsapKrQafIsjhhaBNU2wF/Ypc8Ru9gpnTfY2530R0kcX2nc
	fzORsJMH4gyuVxqVcIEUOe4w5D4ce7GAPa6Pk2I61s6kMBCb8hOFyQvTmj7ju7I4
	e31KRsEpRAdb/U8Q97olxJtqt34dkmzm2RIZm9BicAU6JKJxOYZpTg==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4caj0rhcsa-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 20 Feb 2026 14:32:47 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 61KD0Dpq033224;
	Fri, 20 Feb 2026 14:32:46 GMT
Received: from bl0pr03cu003.outbound.protection.outlook.com (mail-eastusazon11012030.outbound.protection.outlook.com [52.101.53.30])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4ccb23tv3b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 20 Feb 2026 14:32:46 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cJISfwPNMSd0OKVg71WssM2KkcwaBuH1Qb+xVfgAGrT2uCpczyfJTSWqlG0kd1bzthWi9sx5PhCjdVfcD+MV5dqmC6weFiGCdyAzbp2u4zF32tI1klmUJiXCTFqc/T9vEjrwMyHn/la5PPZtWWDWs10tSsCY7ozNfT0i25Ooqi6YbLmkmW50+crKvUOv6yQKYg99dqZ1L33E0NQO3aAbRCRxsRHWWUU0AgWkghxNrKZAOLjWknAZbqjDG4i39N+kXdAXguL5KEBETHM5T5NMEWqB53okL+x7j6EgtLHqmz1gC8nhnROMXHfLETuPVonFziE+QLQrLX4IyWxv/QNAmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1rcuzqC6tWFl0aRC3zpA3k+QT49i8b2c83y7+x0oUxw=;
 b=U1X2gDNf7NHdxTpIcGXIX0FGMiAIlPI56q5+Xv/xMUQJLRnqBZmtrC+uxRgkqUegq5Awe5p6K7dYSggieOkMGOIAZcGfrtF9Yy2sWOTBU/SPxC4zhyWN+h55PmiO3uV0ftNoGHqRSW5fy0uQMycGXY9T2hDtfQTn2sJqwWtRQJ+c/da6cttHun6PYGOzTKyCjekCgEqPDyfiIR2M+7Sy56FKCp3rTdFMAZYSaeqF88xOz+qQ6cqA0iclglYniz3lI2TdEfrrgy2WsbgSHIUW6ueF0qaJKoen/CYBfC4p12PuW89M3zQqnSKQnY5sQV/L7ggUYt90FenckqyHroehUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1rcuzqC6tWFl0aRC3zpA3k+QT49i8b2c83y7+x0oUxw=;
 b=L3BHYZZ0iZ2hMCXkDv1oD3Mq6AYGaM8TtsFIj/G+9dOb+zJ8OkN7UD6tanGOgkipPwP02tNPDOK86DCBiXg0I0hlArf27aZRuDsFfFsaRYC07a15RkZDABYAMSm1bchWSWbG/LAPD/8FoX/v2BPZrgE3mECUbxu4993YyyOrDPk=
Received: from DS4PPFEAFA21C69.namprd10.prod.outlook.com
 (2603:10b6:f:fc00::d54) by CYYPR10MB7605.namprd10.prod.outlook.com
 (2603:10b6:930:c8::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.16; Fri, 20 Feb
 2026 14:32:43 +0000
Received: from DS4PPFEAFA21C69.namprd10.prod.outlook.com
 ([fe80::ba87:9589:750c:6861]) by DS4PPFEAFA21C69.namprd10.prod.outlook.com
 ([fe80::ba87:9589:750c:6861%5]) with mapi id 15.20.9611.012; Fri, 20 Feb 2026
 14:32:42 +0000
From: John Garry <john.g.garry@oracle.com>
To: axboe@kernel.dk
Cc: linux-block@vger.kernel.org, hch@lst.de,
        John Garry <john.g.garry@oracle.com>
Subject: [PATCH] block: Correct comment on bio_alloc_clone()
Date: Fri, 20 Feb 2026 14:32:33 +0000
Message-ID: <20260220143233.3500551-1-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.43.5
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PH5P220CA0012.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:510:34a::9) To DS4PPFEAFA21C69.namprd10.prod.outlook.com
 (2603:10b6:f:fc00::d54)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPFEAFA21C69:EE_|CYYPR10MB7605:EE_
X-MS-Office365-Filtering-Correlation-Id: affb3cf5-c1ef-4f03-af86-08de708ce7d7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?gZSAVtXFk3L+THX3/6oVzwApXkD/AE3bwth60eTWagmn1jcqOvICtzMiibtB?=
 =?us-ascii?Q?XeHQP4ILi4AZOdFmZh5dQ7orDREjRlY9p2sjHJ45f0oB+pSmGIUt0fvAHmfr?=
 =?us-ascii?Q?++wB2DoY2JD/SCVs6DMMQd9253ha5f/vzSWltBVLcnOklDHz4kxWaRT7S4Ej?=
 =?us-ascii?Q?/UetYKUA/YkQxECdEuDwRWrSUpqeHIm7xek2VxcUAcJG413cJmRcS59I2H6r?=
 =?us-ascii?Q?10S58qVYsKzEX1IPo2ZzP1LJeg7pM7Ywn/MoyTTY5+D+wIMPAFpXfsTMKwqm?=
 =?us-ascii?Q?ZVsTyJ5XtiQdOGRrc2HHTOzUoTFqHNX7/iEf8oF/58+sd0qgMcPmXrYDNd7E?=
 =?us-ascii?Q?rh54Iag/xDZHhKt/4Al1jx1MGcmPTofRIX3/4xtERi0xCb25IIT9jWuF1LLv?=
 =?us-ascii?Q?p7k2nOUf3x5F3iorZ/fHNEV4ne5OgMqpjh0VpqS1bIIrn2oMFmT5PbnfWqvv?=
 =?us-ascii?Q?RWdRAlUTqzBRQu9Wt1FalAGICOqmWJOdwcvl6mlN1cccJ8vh1isssXcZm3yp?=
 =?us-ascii?Q?zUA/s1e5pVm/9xV6vMOYxZT7RBID7mDR/XwInLSvi3crOzA3sV/n8/PH2vDP?=
 =?us-ascii?Q?bO7/DRDNmr5N+ZdaCRrParPXup70kG/9TP0EAhkFXPx82EHQlnuOl3JGcK/E?=
 =?us-ascii?Q?DJXw92LXxKTalegfk1QUzP+HCLIscPZR660e4eTqlJAhEKDpxR/o/1NZpy8E?=
 =?us-ascii?Q?gOKcbQO00gLH5JJrgZUlNocBrWaZsXdJHpSdaM4L3uKo92BOsHa9OBtOOZEH?=
 =?us-ascii?Q?JoiUnVX8kHqccK+wBxyP0s6kfKqYiBDKQ1ZoP8oW4JY1XhfJ9h34RTTUZ6Ks?=
 =?us-ascii?Q?yfmSW961f8ukUff6xMWaDsjxyqAiUdj7hz2dtUa+CnyC8jbBiauLw1oyouMy?=
 =?us-ascii?Q?dr423LlM4x2E8n6VrAp6Ne4sZ2LvpaWCSQlqNsY+uPqrdYvBAcI/Rng2HIn1?=
 =?us-ascii?Q?yTfnSWabCgkofOjylHEJB5PslNNYv45/foYCQU4NR7byizWwuHPqFPqAILto?=
 =?us-ascii?Q?soy9R1jMQgxD82W2ufG6J2lYTnPH176i7F1CLJ5tG2bI1JNDSg8VRJGwYPpA?=
 =?us-ascii?Q?FnsgPu/9dNB4+yLFPUJY68Q6T/0ALtq+N0nDDGNjs+mym6qCOhLCw8ADmhc/?=
 =?us-ascii?Q?jZjJjy6MjmSP1GTt6CFMQtERAJ5wZsQbl777Ggw80npT9n5Y+XwKR+788Gog?=
 =?us-ascii?Q?keStTqeI49RF1O7rjLd1kG4lx61qj0JlcbZ21XOUx43/uISwTc2mvoUhFieF?=
 =?us-ascii?Q?+zukdmJ6GfZzfP963+7GZl+AinqveCW8UXKuMUagKhm9Q8E4VjY9QhHKAf89?=
 =?us-ascii?Q?pdZOb7MfBghXsKWZzttHELxyOAXyi0rV/hFw2dECzGEj9ghuNoxzTI8yrFLb?=
 =?us-ascii?Q?/Z5W16Q/FeCKQfRGGXiQtiGIXdd2y7ZiTcXBha2ZyMZvyJsLtVWNE3YeBUQh?=
 =?us-ascii?Q?8Iz+Y4Yiqg1JKC7V6PXs9rwZXdOH3TwNcHO/tsqHmELMrBXPdRqSeq+e4QQ4?=
 =?us-ascii?Q?5YwR7yYbCdIT7Ilt5o08a1KUBro5N6/SUmEqMW0YPQd0qbOvltdkAkr1kxTI?=
 =?us-ascii?Q?U2E+ry3pGANRF6K3AUE=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPFEAFA21C69.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?giaqxv9Ecw971qhcW2i+8XCVv1iubKMKX4hKY0ZdD/0jLLk11KUkHG5w8tlE?=
 =?us-ascii?Q?D2SyD1M1yfvrZeTbUz+DuEet6Wkpdfh4KfEFoigOx3V2c2gEVivhX9+J9FGz?=
 =?us-ascii?Q?/GffQwNR2qqVsQ21gU6J2mcPqNLW5lrbgI6X9U16d+sPHtJuKFIj2yeQcCvn?=
 =?us-ascii?Q?kxUJHQUHVIRwuvBpOnIdhy2IJDOW4AgmwPCeTiZ/54FzdiyJ073Uiqvb+Ve+?=
 =?us-ascii?Q?Ai62AvzyESO9fL9vnEKQ+gMg95J+VOs9NKrk7uPtiTdUJWCtDvv/QDWzFiOy?=
 =?us-ascii?Q?XBJKyovW/ODwdQJBAXl5tkKCekblrWgIPrfq5b9ArDvjGnp+vUddcRWe/TSu?=
 =?us-ascii?Q?LwPxs9RdrqCJ8+9UP3MXQJTGu81AxtHlP+dvC5g/+TKW3OzsjCENjUp4n78t?=
 =?us-ascii?Q?3o0xVvFSZWocgsF2IOP11kREDXb9HImJ5YT12PJ1U1jZXNGiiPxfrfPdMBcQ?=
 =?us-ascii?Q?swX1uTlnq0ZVejH1uTj01kyGomVkiAlzvp6CE3UDGNScuAWdmaZc0XLni1LT?=
 =?us-ascii?Q?lH9k0C7GQ6qxcFnSLWQvxvvhY6WGFpBMQuI8lEy10GJ8nzD4CkUFZF0zNfGW?=
 =?us-ascii?Q?Fi5XyMuPjKDiox1B8qGNOKLk2mkMWB+fokvv3DTe/9wK5kFmZ4509336ZY9u?=
 =?us-ascii?Q?FXiYL+btcaU/kRIvl+agB6hDW+aonUgbl6Wux8oyXF2nUtPP42tQRjc6txlZ?=
 =?us-ascii?Q?1Uu/upoQjSU5fkqBWuIeJag0QLlrdYq7akHr5Ou2QVZY1UR4wd8kWDpWQ1ba?=
 =?us-ascii?Q?TkNtY5bNXOLORUn8V403//zDORCAv6AO3FR0udXEw02jLVLvBZ2z5qpvsPp1?=
 =?us-ascii?Q?TBLJ8gegP8oCcgfWKyxsTevOb98CA6ioyX9meau74uBbSweM2yRHFTdAqQdx?=
 =?us-ascii?Q?jQVWpY6T5oQqbiLA4Qlsu1yjxFv5s7ZOighDC414qOAj7lhtB28xMMqybnhn?=
 =?us-ascii?Q?3kHIEUZOJll3nNTUNFL1owzBb+Qv0uUXKTpIaDbBaeHA1FWcnxAibiQJSP/Z?=
 =?us-ascii?Q?0rOcX9OgM1jj7QC2mm02E5P4Cm8xPFvYwUTXV52mFUkvgylpdy+fewfGBQf+?=
 =?us-ascii?Q?xQEwJHe/OzAYSkAJGxaQ6NutRSvazPMSCGoW6hu+Aci6srxznmZDwYT48Oyl?=
 =?us-ascii?Q?HM1vTCbP291M9zjxxiJPRry7Rtmos3B3+CeYabJZU71M/hNQCcBqcYdvrDnp?=
 =?us-ascii?Q?NfzJ9Aa7IyOZ3HU6RoAQIQZUZ7KRA9AopZeKM35h/xWYl2yDnZ+y3G+4Mwzs?=
 =?us-ascii?Q?u2myQcy1Jd98MdKYGuaYni3i0EmCdp5FpwWXv5rzVAdPZBfm+XjWXsSMVLUl?=
 =?us-ascii?Q?pDKLo3oroHCwjRxk0VpsiIwIhW+fHJeYVJRxYZfBgsZOOldN0WuZ6WfJp9+w?=
 =?us-ascii?Q?wHn9gBi0PiNfEeQuE6s+P/qEOIuZz0Yg3ucEoS+AfIWudfqtsLuYykzpUBzF?=
 =?us-ascii?Q?3lmv43Am148Xzw5gVpCZb15g2WW22kMhx6j5fz0ElP6xbwsz9ABwyqJdt/8a?=
 =?us-ascii?Q?UUX5QfgkxtKY7ftTyEOR3Nneq4/IuPY5tuBUrg3Wt14dfRD27uwU0ocGvK4+?=
 =?us-ascii?Q?PUf8HdfsL0Abp4aD8h5Yxl3ZFqNuM//yo047Mh6rol5rBj7Ms/rdtIUEBRMP?=
 =?us-ascii?Q?VJ0GQTW97kJyUV+3lcBqMQ7f72L/BEZmEtCJggdxeOdYq2lrc6/PFG6R0JXY?=
 =?us-ascii?Q?hfwO6vfkOZ6dl8a7izXURzIwdYZdX29lfdDjHQfq2Wk+vO73z+lJpDaW/12z?=
 =?us-ascii?Q?ehIRTpL4zA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	x0XitOUuY66UMyrYn+akMGqnTc9JvIMpBgFxahG7uSYlIeDMPvwKmuD2QCyoJgUFiJO4X+BL9hrlz1M84wdLxAMDMdW94Sin5ZLjhNPKygS3uHe69MkYfS1H5O2MgZKjGwaNdnh/ZJfwuJs28SLx90DMg95Wj5G5vp2ncV7DQPEOCgseIxME7UK5y+u3FC2P1qzycprSTfmSUOx0LYYDKNQsgTaV2MNdIcxckLKIUGhiJMHDE7LEXmH1NUjs0wqTc40IZh5wsUhFhqQf+wDAD2+HMa1bZvFMHm6Aq5sQsU4Q/3GW3LW+hqVdPvwBod4S3j/ZzKtMxfuY8bwF7CEskMLP6ytoSPjUj35VSs7wSSYDyx1RMb0OLLrRuVlor2Jfwpc3nmPSXP5mRNyw4Ght2W9Ooapi/EHBvNEWEqVsN26XKohk9fsb3hlws7loMtnwux7TwEoU4MDNd9qeWprm7aWToqU5ZKnIPr5p9IQAWl9lBJyKX4NGJWC03A8M5prnonynQP6iOAQoNK+XIytNxy6F6QS3zB9uDzQ5+rzHI4snRdM2+bnGyirW6C5pc8EoI0jjEkr2msC9aFoEpbPjKl+afHDurU8vDgGRL+AlqNQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: affb3cf5-c1ef-4f03-af86-08de708ce7d7
X-MS-Exchange-CrossTenant-AuthSource: DS4PPFEAFA21C69.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2026 14:32:42.8176
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2GevCKSVByJGyneP9uwdczum2JuuhnJDfGakFtNWWIogenB0UBnXihZbQbhVfwrd3gI+CtScIfseYP1FoDfeCw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR10MB7605
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-20_01,2026-02-20_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 spamscore=0 mlxscore=0
 suspectscore=0 malwarescore=0 adultscore=0 phishscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2602130000
 definitions=main-2602200126
X-Authority-Analysis: v=2.4 cv=V6RwEOni c=1 sm=1 tr=0 ts=6998708f cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=HzLeVaNsDn8A:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22
 a=GgsMoib0sEa3-_RKJdDe:22 a=yPCof4ZbAAAA:8 a=EHjxp2AXlnSXxmfpwtcA:9
X-Proofpoint-ORIG-GUID: ec8KBkxAW8sobcTZ3CfP71CmQyaaW7Ub
X-Proofpoint-GUID: ec8KBkxAW8sobcTZ3CfP71CmQyaaW7Ub
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjIwMDEyNyBTYWx0ZWRfX93RQb7+fufHT
 Ce5W0l2W57v4fmBbYRhtFvdmJohnlRidv5HrbNpsP0U7yYXrwtbBod2PNK/ZSMokDPABpT7vg/4
 dbmL2HupiwrZUX2jgMQR/DtLbgtNrXWxtGDM3yQXyN1eFHan7PqHdCB8feK6zifhCIbDKbgz9Lf
 cFuoMyjWwheIpQUhN60eN3bJpol6KCp7BqCyJzgCcUZU6Ndu7FzSkHSTJdy9FjhL+tD6L5/6Aag
 IL4yNlkl5gz+ABZqEAxcDLLEE+EIhwruHzylqKLE3iTP29NV+FybX2K+rKWd1WKqyrVehv6FsAL
 DsBxwHrdpkdzgCmxB39Eq8mt8wUzh9EN6eTP1nPlTUbVdlSYAyIlCg96K6ix8IVVt/q4r8p1hk+
 JDpYts3a+esIqS3qDakpJqMwoNGVyZoZAAYYz30B5VHGMoIDjtmVKlb3C2ob/psTWJcSpzsNKHW
 mPleK5TEUvg6M0HeTNQ==

Correct the comment that the source bio must not be freed before the clone.

Signed-off-by: John Garry <john.g.garry@oracle.com>

diff --git a/block/bio.c b/block/bio.c
index 8203bb7455a9f..9d9191fe19b50 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -900,7 +900,7 @@ static int __bio_clone(struct bio *bio, struct bio *bio_src, gfp_t gfp)
  * Allocate a new bio that is a clone of @bio_src. The caller owns the returned
  * bio, but not the actual data it points to.
  *
- * The caller must ensure that the return bio is not freed before @bio_src.
+ * The caller must ensure that @bio_src is not freed before the returned bio.
  */
 struct bio *bio_alloc_clone(struct block_device *bdev, struct bio *bio_src,
 		gfp_t gfp, struct bio_set *bs)
-- 
2.43.5

