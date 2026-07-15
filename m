Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9190D3E5A1D
	for <linux-block@vger.kernel.org>; Wed, 15 Jul 2026 13:20:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784121629; cv=fail; b=vDTx44rLOkMfb1OlAxUwBXHik/az9Gdbpc1rLlb/mklWNV/cA8iMTVxq/BD4SPYlHozvb3RQmpxK/c09g3m+YscWqSlSPBa9Xu8Yr5F4JYmTS0fJM9S5cHqghzVtpWOhLLTVWY7rjIyXO777ovI+hgCrvjqLXa+xHo7SSG+2Hyg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784121629; c=relaxed/simple;
	bh=MP5RyNJvL+Y2VS3OZKAgy0lXbcCiXBR4UzTebURg6gU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 MIME-Version:Content-Type; b=BwQi2AFpaqB+wF788B/uuLbOorxCGuHscTIEYxtAwEyFHjZegDJQId4+gzjD9qxnae9NHxxX5PIFRR/JIApObBDLh1Ms2rmYybOrjV0ZpaGj5PcA9D/Xn3JsqrYHjqPAmypZPX7OUdQhfiS4uhnNN9dUPwYB/3Ec7tDETllSKjA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=BVzbfns5; dkim=fail (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=U2FkqfXM reason="signature verification failed"; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="BVzbfns5";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="U2FkqfXM"
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66FBdwdL256506;
	Wed, 15 Jul 2026 13:20:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=pJt6gN/VYHc03GQsA8gvn8Avjjolyty6xqDzyP7oQ8s=; b=
	BVzbfns56oYdArESJ8CaGtIuzj5uCsycnXmkc6Q2q8PY8xLYqUeyIp/2VkCzVVfd
	Fg9nViEBSdrAc7cdm51ogm++VLCGKWdtyEvztOizqlEQIaK63A4941ZitKNlRtln
	12b+0X/8b6p0OLNksmfMSjEtLW7M5nh79QWOkd3xKThFzdZfZanlZx8rpmnIX9ax
	sVyrjPOCPUsiixKCOa9KQpbTbc8oNIAm0W9suOcPJKj5hWrEYm3OmM/3pQGEat8+
	fI8p1UI4rFxF4HqcdowkoBVZXQRIZeGfj737xdd9EHo6toRSWPDXTt8MdZizJHpc
	Eg3sLlgL3VzLlCBq5ibf7A==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4fbef0xn08-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 15 Jul 2026 13:20:10 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 66FDInQj011415;
	Wed, 15 Jul 2026 13:20:09 GMT
Received: from sj2pr03cu001.outbound.protection.outlook.com (mail-westusazon11012044.outbound.protection.outlook.com [52.101.43.44])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4fbc9jmg3p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 15 Jul 2026 13:20:09 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Zm82om5HijbAzgACgEcHSljQv5tVTvaaczjQdyQj0oVvOO9f30yr86xSqPgI3GagOJQrsn9FamcaXK6QLmatcfu1WUoaiP661B0KG7KyWioxyku7boSiSQD6V5D/lt7km2rZpIhAnAHI+ZfpnVG5+mtH0UdiIP178Z4QV9kNiFkcouYHWf+4c3+5HyX8oF7wTRdpftEYMLFojqJL41pq6NYwFQn7hKghBalBmHF9Q4YQExABxayHS5Zak9bg3Eevgx+e1Jea7txR/cu+og/gk2+AjN3sRAAw+F6/IY+3dP4iJNodWwHeje/5S+vzW/VErKdvHHzKw3SAUDTizoogRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E1c0fRBrz0Cw+Xy03PWIqTfRRjYsFQWX1WcyU5Z/t0E=;
 b=Qaz4d3CqzDX4ahMNJV/rCpEUbKPjNDv5KpFsb0yX8ytfsCsTEGqep5q+7olmVs9RAlDYTVRWPRJZBoPLeOxiC9sFvfqwT6o6xMxb/+Gd897v0Uk9eNi5t+BpJzBteln9Kpl/KXq3uYssIgBisVju0J7m6w8hpKPFV5/0F+th5r1VmdqTjydFIxf/naXp1WV+gWUbZDzGYxut25OZavzrhy4S+F1gsnYNVkyy/PNArysDJq7MCODfIrI32Ji8BkLwLZrOrKe5qkmTz4y7Ivw1AM7lter6S7W3nWEj0NrYss5YXYiVGYc2vAW9TTOy5rfNvyW5Wy0cPDKWFRQAAnEi4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E1c0fRBrz0Cw+Xy03PWIqTfRRjYsFQWX1WcyU5Z/t0E=;
 b=U2FkqfXMMsVCjU8THP1slPDWO1Q/SMzrNbeEc5pclcKOIgQGpkg1z+ex/gwQDIUVn04It+RpBWZdMfNqt265szsirB3lG7m9cTXqlb/w3o+v2JlPY+Ro+FCh7fhZaKb4rxVkIPA1poacVBkEYLkOy09Qv9ELXE42/+xdCWuqwxQ=
Received: from DM4PR10MB6229.namprd10.prod.outlook.com (2603:10b6:8:8c::12) by
 DS0PR10MB6975.namprd10.prod.outlook.com (2603:10b6:8:146::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.223.9; Wed, 15 Jul 2026 13:20:03 +0000
Received: from DM4PR10MB6229.namprd10.prod.outlook.com
 ([fe80::867:63e7:13fa:fa7d]) by DM4PR10MB6229.namprd10.prod.outlook.com
 ([fe80::867:63e7:13fa:fa7d%6]) with mapi id 15.21.0202.018; Wed, 15 Jul 2026
 13:20:03 +0000
Message-ID: <92c3a0d8-d85b-440d-8277-2dd75aebda28@oracle.com>
Date: Wed, 15 Jul 2026 14:19:59 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH blktests] nvme/069: add a test for multipath cdev lifetime
To: Daniel Wagner <dwagner@suse.de>
Cc: shinichiro.kawasaki@wdc.com, linux-block@vger.kernel.org, hch@lst.de,
        linux-nvme@lists.infradead.org, John Garry <john.garry@linux.dev>
References: <20260714094345.3370884-1-john.g.garry@oracle.com>
 <7f5c5f13-78a1-4d66-bdc4-e2e2260dd949@flourine.local>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <7f5c5f13-78a1-4d66-bdc4-e2e2260dd949@flourine.local>
X-ClientProxiedBy: FR2P281CA0094.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9b::20) To DM4PR10MB6229.namprd10.prod.outlook.com
 (2603:10b6:8:8c::12)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB6229:EE_|DS0PR10MB6975:EE_
X-MS-Office365-Filtering-Correlation-Id: 79e38db0-1c33-4ba1-8891-08dee273c788
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|23010399003|1800799024|366016|4143699003|56012099006|18002099003|22082099003|6133799003|10067099003;
X-Microsoft-Antispam-Message-Info:
	oa767B/MWQVFD2kdMPh5QVH1pWpWZp0KYEEP07KPvBvKXU7JBxIFJEjLMKeTOyxnKpXiUc9q9CUNDRJWVYqFOHeKkpDy5UNCYJzbf3pRbUh7nFceTKv9xImC6Jm6e5/lEeqCGpo/8IcuJJBts8mN1jaY6zFajD4W63JPNRQlsP/1xczpWRKWU8dWFWd/h1XIYvZmsDsh8vLZJ/4xVMs1Vfarb6nHyqJhKsK/LATH359qJ4RHWitwXfxIYZh0YQZiXI4fu1/2xxUFZr7sGSewAlkafMeKxpTKzDa6KUoSLkHB+EBPSB7bpxFU78g+SmM7hPXNwBhTzlMXhG3zecB7YSxr+YRCg8dT7gJZ7ZpJcOzeJ6hKz1BGUCk5UbZCfw1QI5pdyrC8u9kD3ViJD8ki2raC0OPndU1pPevVJprImAlzav9x6qKAGBUs001RzbiVbmaQrj+nomA4z9ebfFORTcM2tKI3+Mdxf24vOeItjgX6AYuWpDl7xKNY8lMrphCvpgF67WSCd3Xwp2C/6jbQ7y0VMOKjSysvfeqgT1q0bsIUGf0GVUX+/8M9Ofv0o5vEvaiSDStl24FbhvH52xIfAiVnl0oP87DjRv5DA8ovMax568zhb7C81vT5VKaK+ZioS12IKFVe5wiz32ISi538Aldd17IHfDcRBhkH9sou0+Q=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB6229.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(1800799024)(366016)(4143699003)(56012099006)(18002099003)(22082099003)(6133799003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RDhERWhJVW5tZnMzT1p2SGpFZlBRUldHS3RoNXVhVHJsSVQrcTB2cjdVNEJp?=
 =?utf-8?B?b2FJZlF5ZXRPOXcweURUQlIxenBDZ21rSU1SanU1UXZuVGEyZHdlQ2llaGNm?=
 =?utf-8?B?ZjhSTmd2VVlRMllWUGcvUjZtczlyYk04bXlVZk9kcUV4SDRFSXFjN002NnFz?=
 =?utf-8?B?MmQ3V1kwd1l2RlJISWpESXpuaDIxQlY3RCtjcjltUmx3T2dHUy9BVTlRMWtK?=
 =?utf-8?B?NGRhRkg5TkFyL09GWWIwK2R6VS9RdFJLNTBpNHlYeXZkam1wN3NTckxWaFhw?=
 =?utf-8?B?OEJNWnJ6dGQ4ZTI5eTREWXkyc0FITXBBWVQyckxPakFrWG5vRXJhMGgzQWRF?=
 =?utf-8?B?b3BmRjdSL1dtQ2xZL3FTTysrMm95WUp4YTRuSzBZdFh2ZFNaRWxqbStLOHds?=
 =?utf-8?B?M2Vkak94VDhXRnBJemVaaTRMT2FRWjBHUGRZbTFISFNwOVVYUWlsQzk3RVJZ?=
 =?utf-8?B?RDYrVGlCKy9jTXRobEJveFJMaUlXTmxmSkkva205TFZoMEhSSnVxN3c4Qkd6?=
 =?utf-8?B?ay85alVCUm41Y1RmUGM0ZXI1OXJxVWdQYzVMM3F6SjB6aVl0U0crNno2cWdM?=
 =?utf-8?B?MFpRZG1jUGxQUjN5K29ad0ttYk1pSDhpemF5T1gzT0lueW42WUtJSkdXMkhL?=
 =?utf-8?B?eERKSzgwbXVlVmpERzlkVVg2aG9qS0xNdUdKZ0Z0dGsxZmY1T1h2M1d1aHFy?=
 =?utf-8?B?Qk5Rdm9nRUFwMjBPckdObndJKzk3dko4NENiaE45K0dld0Rlb3NLaWtqSWZ1?=
 =?utf-8?B?NkYvSlNkeERXczJXUVVHeDRTYUNHZ3BWc2FRVTAvRTVFbXAzWUVCSjByUEtZ?=
 =?utf-8?B?S3pDTWt6eHdpbTBSWDJGSTg5YWtIK2F1UFhJUi9EdnNTWk9oQllmTmxOekZY?=
 =?utf-8?B?azhOOHlUNEJlaXFaOHhsaThwNTB6RXNVQnMwYldKZDl0ZU1uNDZPVWRtNVE4?=
 =?utf-8?B?V3dYc2JFU1ZCR0trT3AwSkkva0NVOEdqY2dyVVBHejRIdUhRZG9nd1ZOeDJs?=
 =?utf-8?B?NDhlVStDSmlKYml2NFVHcWduTFFnTjR3WWdpRzUya21TeDRva2drMEdIbnRN?=
 =?utf-8?B?VHh3VHZJWUdWSG55WTlVK3BZYjRBZHRQUHNMdUVlWDJyemtHUGtNem9IOXFh?=
 =?utf-8?B?enExNTNHRWpHQkxGVGkrT0hqb3RFS2tER1MzYjZVcWMzaERhV0ppcnZFblFo?=
 =?utf-8?B?czhQRzB4ZnBzZEx1WDVmYXdpR0RpZzVBVElMbjJZSzgrR0Rqb1BGMmdiZWt1?=
 =?utf-8?B?REJQMDc0SGFpZzhXSVhxMnVNSVN4ckZ4WUo1S1czMGhVYU1zN2F0M3BsbnBj?=
 =?utf-8?B?U1FiR1BGbElMbldGUWxybUEyQmFMUWVnQVlyTkdBcnhNUDBzZEJEcWV3amJN?=
 =?utf-8?B?MDlBb0hiUHd2NjhoTG15U0VVaGdGaWlYSkVBb3NScU93YVVHenJrZ3g1TTFY?=
 =?utf-8?B?WDZKeXFWZldGbjRPSXZjK1ZPK1FDYmlMZEtXaEpuZ0RFOFNyUDFCdTIvV1gv?=
 =?utf-8?B?Yk5DbVh4VVE0bzdHdGZSVUczTVUzelh0U3BudHRZUXVEOHR1WFZrQUtrWTVK?=
 =?utf-8?B?Qk96L1BCWk1IcE9VWVk5L2hGZ1BJYVIzZ0k2WXR0MW9waHJXUDZrTjd0SVJZ?=
 =?utf-8?B?Z1l4akhPSDdtOFV3My9HZmlZWkJGeDFDNXlOMDdCVXRQT01IYkNzdmJzSkpr?=
 =?utf-8?B?cGc2bHljUEptbnBaU3RiTnNUcDI4U2ROUjB2cDhnTENubllaYXRLR3pldld6?=
 =?utf-8?B?MTJjMTJ0OHdINWxNVk9lMXQwU3lOZ2UxWEMzeSs5ZzQxUHhtZU52RGwzS1pt?=
 =?utf-8?B?azlrc1NLQ3VKemg5ZmQxOFYzaHdKNFFqWmNGbU52aG5GVFdsMTBOSnlWRFFj?=
 =?utf-8?B?eTlubk1BNFJDVUhrdTNhRmZJWGt6WDVrajJLa21FUXkvYkFqaWZpK1pwclho?=
 =?utf-8?B?S1JVMjEwOHNyVFJEd2oxaVNhWmhDVzdxcUVXSnJoRU81ODhhMy9hQTU0SXAv?=
 =?utf-8?B?cU1xSDJRNEZPcUtQL1lBMmwzNm9KVnBYRWdkZmFTbmpUV3RUVFFqaitLSDNZ?=
 =?utf-8?B?SmRNNG1jZzZtdWhyUFlaQS91U0s1bEVhcXVkNFFEVjlSVEFwS0oxYkMrWTRl?=
 =?utf-8?B?VG1ib0xPYmIwcnZBeGw2cmRFbXl5b0k3ZUQrYzhxSVVWOGIrUXVmTXdRUHpI?=
 =?utf-8?B?UmRKaDhaZDBxdEpCK2Y3Sy9Ba1h2emwrQllCZk5WaHpFWGF6VjN2VzZpODRo?=
 =?utf-8?B?UnllRit4L2FBK0k2Q1k2WDVFZ2FLNW1GZGZwSFA1SkwwM3JNSGVkU29OemJC?=
 =?utf-8?B?K0s4dlUyaE5WY1dLWkpFOWJJZkZUaUhwRFlFYmZMVVhFbzF0alo4aDJyTkVO?=
 =?utf-8?Q?NcGJCMT6uf1p+pAY=3D?=
X-Exchange-RoutingPolicyChecked:
	qCOINf/IGrEfMe2i+KNKqsRJxOuIR1ve0wXpmgR+FbAiLm/mrerTvfZQsBkTgu8bpfpBMoI6Rm93FIwSp/6SLovyagvef5ljp8DX+nhYtNeUuGiMv75Dyl3bsG1F4s31WLugwSZgOYivflZ3ykpQFahnHWpKmdXlT7YXjnN3ZzgoV1sZTtVmld4n9T4ePd/TheR4KArC/9xYz4ql/N6VWKNEKSr7I7tXmoD5YyZ3n88ghRiIx74itTo8u5wBwcGN/5LjfjM/cU32FG91tdC+/47SBwmWWeoWAC84liJly/xCTY7EIGGJWQ9hbXdRMJLAFd1gZg77+XprqxlM2dod6w==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	geSI+wrY/qfXhZeBtXK3dF3sOXUqGGNOXHq0iu1zq7RfAGjhwIpthalvnvwjdILfAtHrXhioqSUCUZN/55KLKUJPSk7VXJ5Li+ff1gEs7Sr81I8GOq8ZtmxK7qcaWbX1Rw2Cj3I5+mQPYaUMjEZwY5sOrFUoX8jE1LvssofVarX6+MrNK23+Ffk9+ik+kZaPeEu9Wsy1PyVxs96C0YY7UgDD5MYrz0q+6aObCeco/oi29LoZnOZbUNAMfTt4aSL9cRC6d3o1tb6CfL92IpGIyhGxJ/WHycajWdh/xyqStdWdapX3PdLQRoI4P/+pp0gPI6lOdQxTtFUefiCSspsTQn2LoEa+M1FNmdExQqixXgVuuY/S/2ctGaQInHPuN695zn9NlWggW8Pgv9zeoAtqpqIeOw3CdHLAJd3pNgfCvBzwTG9Vh9eVAv5QBuosR6cKhqWR9j50hAAf90pV1jZqVF7o3RyBubdMh3Fnv6DfNUB3IIQS+K8ohJwxvgXOaeEMTQP6JSbdHZM1So+cc0JuqMpxcGFuItIoVhy5F9HcltjbqKDYzoYBrXSWRcfv09VX+t5lCGIpc290TVyLf9d/3yZX3+CIolzQBSccfzhy2Vo=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 79e38db0-1c33-4ba1-8891-08dee273c788
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB6229.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2026 13:20:03.2948
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hVW6OftbvSDgkmiULt+5re7/RrZMjQKvlaVBadoXSiXSDDzsP2kis4mPc4MW0OzXfPWK4ivkV2beRR+bb8++Rw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB6975
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-15_02,2026-07-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 spamscore=0 suspectscore=0 bulkscore=0 lowpriorityscore=0 malwarescore=0
 mlxscore=0 mlxlogscore=902 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2606160000 definitions=main-2607150132
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-GUID: 7xOzYZfGkwMeiavQJJFSj8NuYStOwteY
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE1MDEzMiBTYWx0ZWRfX+bnmmPsVFmpv
 ndw+q9trx7O7KJdK5te9KHpFC77GJHP5BC70aHcu37ZZ/+BQgWoX57iw/+wCRAcOrgO6JF/uBfH
 mZVx92NKD71k2q749CneYS920zUinYxm/luT/SfpGpVE3HdPVLam
X-Authority-Analysis: v=2.4 cv=KJZqylFo c=1 sm=1 tr=0 ts=6a57890a b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=RAioF0-LDSMA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=jiCTI4zE5U7BLdzWsZGv:22 a=EIcjfB9IiI4px24ztqRk:22 a=RpNjiQI2AAAA:8
 a=dwmD0ky2nwVxBhpvle8A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=5yU3S35YU4bGjq-dph-N:22 a=Bho9c0fBagfJEIQBS7DQ:22 cc=ntf awl=host:12218
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE1MDEzMiBTYWx0ZWRfXyxe4WWRzWMbe
 BQRTRigA7iKV2xFWqT4w4x5YqLGPhFgD6m6ImipZiLUaSGHWuWoR9vbTa/hrTszCJD4it4UCHZy
 KZiGiYDh0hyz+KfBVgl6TXfvCWzMh6f7yc4oDAQFktJhS2lJBBQghr03fMyvrPg2oG8rrm0dx96
 N4rVIq94CwONmhQUOmw4KR7DgBUyI65X3gwtdL4TtiFEayVGYGLGF06KfUHP23RngBX7vHvSWjc
 6S9cYtyc0imVqoELDW2doB7MLSzPkCK9KG/lIjV12bhKtGkV5CRV8RQofRSNlTYy37vLqWywY53
 ntn9lnEFZjkhjYe5+NiyUQN6Xv4ZHYnMScqWnoBDa0WSBKr3Q4p415xR8gLy5eLqF6veC6enQZf
 BRQpL/DVu1QoluNdglga42wVu29CZxP2W60df6Jg81qS9al17aeN20z6Jl7iBKXEXfWkncFimyy
 iB9jCq7HWMBgw8MMP0G7MS4BjfSKn/MauPTopWrI=
X-Proofpoint-ORIG-GUID: 7xOzYZfGkwMeiavQJJFSj8NuYStOwteY

On 15/07/2026 13:20, Daniel Wagner wrote:
> On Tue, Jul 14, 2026 at 09:=E2=80=8A43:=E2=80=8A45AM +0000, John Garry wr=
ote: > + # nvme-delay-
> ioctl will open the nvme-generic cdev, sleep, and then > + # issue an ioc=
tl. > +
> # We tear down the nvme-subsystem in the foreground so we can catch > +
>=20
>=20
> On Tue, Jul 14, 2026 at 09:43:45AM +0000, John Garry wrote:
>> +	# nvme-delay-ioctl will open the nvme-generic cdev, sleep, and then
>> +	# issue an ioctl.
>> +	# We tear down the nvme-subsystem in the foreground so we can catch
>> +	# if the ioctl triggers a use-after-free KASAN warn.
>> +	src/nvme-delay-ioctl "/dev/$nvmegeneric" &
>> +	sleep 0.5
>> +	_nvme_disconnect_ctrl "${nvmedev}"
>=20
> The sleep above is to give nvme-delay-ioctl enough time to setup,
> right?=20

Right

> Would it possible for nvme-delay-ioctl issue some signal (or any
> other working sync method) and we just wait for it to show up? IMO sleep
> should be avoided if possible.

I suppose we could do something like nvme-delay-ioctl writing to a file,=20
which we can poll. Or use a signal.

Let me investigate.

John
