Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 281873ACEE9
	for <linux-block@vger.kernel.org>; Mon, 28 Sep 2026 07:30:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790580641; cv=fail; b=D08pfnI4vJ4GvlmEXrEEdnlRXXeF4CpMwoLQGdzaE+ThPA67MhLu4cV/6Q2fDU/pQyopAJe2M5VDw0ngOLhZS0JlvuNWUmIvbWJsf/BJQA2z/NSYIwodliYgtOPBjrIOATfLEq4gU36VBs+RMikvlj+RDvpp4ZiCz2sl04hlXvw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790580641; c=relaxed/simple;
	bh=ghmrEmM8zSJtB9OKSMQbD05MsGmzzwz+s44fEIt7XE8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=jf0/gdfq9feUTQaMTv5RNGLeJkSmq9Uz/EbR6KiQ6c3DJ1vDiAzhv2F1rCjaVqUoq3d5meZ4id8nqTIpPFgD8FXK9dM4ZSz+yxAq4CXa8P+FIZtESimQJTwyVKnXMMnfX4NcwJKydzwxMg+aVZHOSzcx+wMlXvqGYJmhxrLlw5w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=QT+0eLup; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=JitGosrH; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="QT+0eLup";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="JitGosrH"
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68RMoaSw113592;
	Mon, 28 Sep 2026 07:30:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=9gy8cLZ57Om856oMNchDLqHpUjA8RAn7pI1yb6jRvmU=; b=
	QT+0eLupckMxniwl9FcI+aBuo+mkxjlbBMXqrEF1iuil0cEiyS3+AcdG7sK1/QPs
	lmaISMuFCWK5L38m+KqUUw8DNDIzNqCiObL0s5UK8jV1hLM1P9TL7epOHrrfXRLP
	YQuM/qe7oDWfkXyA4BAlSLVApZWjMzywNpJ9Ql99xfzWWgAddS3+8q6jzV/K4i5v
	m1i9UwCGi+vGdpuQWosGM8KeCq+KP1MI77Vap9VZ7th22peiePkHJDSY8YM9KoIo
	8Qj4nuPx9GG8mrilVBWL/6p1TtBvfuRjd+jbUhV3AvwZmcfsyIe2Xj2WCYYs/H0j
	xej0zP20O9TrDgWwq5yuFQ==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4gx4fba2q0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 28 Sep 2026 07:30:18 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 68S7K30f012673;
	Mon, 28 Sep 2026 07:30:16 GMT
Received: from ph0pr06cu001.outbound.protection.outlook.com (mail-westus3azon11011048.outbound.protection.outlook.com [40.107.208.48])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4gx4gajdxk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 28 Sep 2026 07:30:16 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IQxDo0xU0LVlh9mlXh77gdfAkJ5kmgzYHOq4H3n0BQbUZE1042d/AP/K/bEVqD1O6v28DOd5zShrQbqcCKz3G5sN2bgUeR4SniCFx2Qe3YlF/lxxf6rvHfnD730cvZ50kf13z6OA3Mf6JOed9Dn3RsimF4kpdmghN3BatTSFw6+roztgxp/+cQHcO7pHXWxKu2Bs7mLVk1twUNmQjvt7swf9uQmHvZBS1OCV513lm8YSuPvsgsl+OgY0DL+SM0kn5Yt1tYm3WNZA4fhDeqyM+wWoXgpLm90x/TsXm3JHqZdUn17e2+BX9SioIii+SIhNEzKCHYFh6KyXM40iS08MUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9gy8cLZ57Om856oMNchDLqHpUjA8RAn7pI1yb6jRvmU=;
 b=q7R3Y05HVUo/hgDxorQ+izclrYKgryUiKOtUbIu93zCvhOS3iV7cKQ+qgNQe4+iUSv5YJQFY3n2Bx1WM1S58yf1JbQeu41GRvo3PrVA96NawHJeM8vDA4vK02mwfv2QgPHfLkiNeSe24BHXpagNX2/fxvMdfwCYQI+V0MGHLO86VEm17rN78xmjb/Sg4re+Ypm+ATSHOhI8SLdJO/r6qkVpdgRsO+FdCdQw5l+0azn+xxUfgCpm1yJRQ8zpGwXubIxfZhGXUIn9iX441HXADGwKiQjq3sNz2FTAXqzjv1weH/ER677FG2tljocL+W22CrqNgQC95fwqp1Ogk9QW3Xg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9gy8cLZ57Om856oMNchDLqHpUjA8RAn7pI1yb6jRvmU=;
 b=JitGosrHezthRSqq3SnNbvQgjyIHrOLbvD1hCB8/EwbT+FmZhTCbX4UsO4iWCe2I7b8pymbiJtmWFGW3XUqK5KtbXffnBzbzpGhuSVzm4inhU8gs6hFik3byCu1byR4+AeLaHYdoDM/mBzIfmyL9s0SDQVK56Ee0PdbUBOQqjB4=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oracle.com;
Received: from DM4PR10MB6229.namprd10.prod.outlook.com (2603:10b6:8:8c::12) by
 PH7PR10MB6401.namprd10.prod.outlook.com (2603:10b6:510:1ab::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.13; Mon, 28 Sep 2026 07:30:13 +0000
Received: from DM4PR10MB6229.namprd10.prod.outlook.com
 ([fe80::867:63e7:13fa:fa7d]) by DM4PR10MB6229.namprd10.prod.outlook.com
 ([fe80::867:63e7:13fa:fa7d%3]) with mapi id 15.21.0451.014; Mon, 28 Sep 2026
 07:30:12 +0000
Message-ID: <5fe0a938-aaf4-46cb-8fba-3524586ac5b4@oracle.com>
Date: Mon, 28 Sep 2026 08:30:10 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/4] fix NVMe multipath partition diskstats
To: John Garry <john.garry@linux.dev>, axboe@kernel.dk, kbusch@kernel.org,
        sagi@grimberg.me, hch@lst.de
Cc: linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
References: <20260921083752.1154316-1-john.garry@linux.dev>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20260921083752.1154316-1-john.garry@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0376.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:18e::21) To DM4PR10MB6229.namprd10.prod.outlook.com
 (2603:10b6:8:8c::12)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB6229:EE_|PH7PR10MB6401:EE_
X-MS-Office365-Filtering-Correlation-Id: 60121713-efaf-429b-b62c-08df1d32550f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|23010399003|1800799024|10067099003|56012099006|5023799004|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	THEtigN7rbe2pq/obxWuyiwyqPUPcuYwykHgAIe7Ee7Q4FiTZEIUpOwIOQy41WfsqSdxzogqr9c/hcisssAG4oAGQiDMjm02BbjR60EKsMav+LTwWiATW45TKKydQjkbpeFNmszVCju7hghvgm7/nuA7aw/ns7pcq47vWRlAn07u5GH4kLTrgQS050h+QnzaO+GbZQwHVXkeZ6Bi8uVET0Ol6i1ODY+XWFmy01JRZlKn5ltAoM9N0jMYZINGHP8O4Qnqyi1lT/90CYsB2S+Z7zkyLnn4uW2dJt9UG7O4tsHhs8QrZufZybMYZTmOmTRnHxsdR4aEtaRYKRyXWxWsPlKdPgdJiR6+HTTNXs7hNMhDoshYGgJxnrHvA3Og/2d+oLHWdzvvQyIEPucaS78IGVYoTC+utYX71xhfKwhA399C4KMIlyIkVO7cAouzp/MVth+QAy0FdRYw10IjKzRVSVsGUHPfa41tcnLzY5Hn7AFlAFUbKE77HOEVNHLdYp+aIOVFSw1SWCA1y0AA9pPou1NWz0dSzAov1skHv6ey6AMMa33Hguxjl0rkG0YdTGQ40io5cc8PQgku7QEKeIN8JmobwuMCW3z7z3YuNJvhsDUWZUcW5EhlQS2XurK2pzF4xkM41yrHN2SSdkWB7O5FzQshtjsN7GNv2txdnBYuTzI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB6229.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(23010399003)(1800799024)(10067099003)(56012099006)(5023799004)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MmRTS2czVFJlVzVjTVlNN1JKYiszbkZnckppUEEyNHV5bU9EV2NGU3pDQUFT?=
 =?utf-8?B?MTJ1dG5scWlSakFIVitwNkhFR2dTb2ZDZFhwdHBUVFJ5OXIwZkE0d3RINzNV?=
 =?utf-8?B?Y3Q5WE9QbC9XenZQbURCc2lmdmgzNk9SQzYxTitqRGlPTzB0ZDJaV3FBbkF4?=
 =?utf-8?B?OXpkL2pBaDRSRzJyUitRTzJ4dFFZZEQ4SzBUOW5KQ0hOMEJxU1N6QnVHSTFi?=
 =?utf-8?B?b2hRbjhXblB1N2ZXVGNyZmJNQUdETE1oaG0rOHdhbXVQWitkWkFVcm5ISGZL?=
 =?utf-8?B?SkhGMXRrM0ZEcjBEbVBkTFhZOHMxNm5FTm5RSkp6YmU4dWkxWlREekFRak1R?=
 =?utf-8?B?VXFVbUFUTHJGVVBhYk4vKzlFVlMwUEFibUg0MGZ5VXVsSkw2SG8rNEM2N2pI?=
 =?utf-8?B?dVdwT2tmOVVSQ1Q0eXJBd0F5OG1hZW1jblVDZzYzVDYwS2xvRmcyZTRhS0JU?=
 =?utf-8?B?bkpvMlRnazdKcXNqR25zR1ZhbTk1SERhOEtUZXEvUlVDbnRVbEJGSzVoWndw?=
 =?utf-8?B?ck1EL2xteFF3K0YrS3JjdkVIQk9jUTgrU1IzM2d5K2NZSzh4THZpMUllTGNR?=
 =?utf-8?B?bTN1SXg2V0JmNDBJOFFrQ3ZUeXNQQ2JKcU0wQnB1SmFib2U0cWZMblg4TlFR?=
 =?utf-8?B?ZXNhRm1Nb2RRcGxPaXdrbDY2WnloemRkcDlJUWJ2aUpLQ2pKTExIZDgvUDVu?=
 =?utf-8?B?TCsvdUhRcWN3cVRhVmsvS3lBQnJSMkkveHl5c2V2L29TWGxYUjZaSVcxQTht?=
 =?utf-8?B?V2J5OFc4K09UeFVleWcyc3lianYzQmxTYnlmUWtRaFpOQ1JpRG95b0pBcnlr?=
 =?utf-8?B?YnhmaDdGN05BNmhtTW8rNU1LL1g5T1ZvOUVLeFJIdCtqYmNCTlBLdTAvMkwx?=
 =?utf-8?B?K21KMStXcFAveElCb0xzL3RLM0Y4N3lOV1d6Y3RnUlF5M1VsWFNtT29lUVd1?=
 =?utf-8?B?ak5qT2lZMm1FNzlLa0toQmFkS1poVmRqejc2Tzg3Z0VweTUxVWFtbGY0dnlw?=
 =?utf-8?B?akJnZy95WTNsSzVVeTdKM2JPTjA0eUVmUE1UVVZoS2N4bmlmVHFsMnRCZk1N?=
 =?utf-8?B?cENGUCtFMC9TRGhrcjhZc1VlVWphakUxRi9wWjFXOVZFRDdjcEJlU3grTThU?=
 =?utf-8?B?bHJMY0tHdzBBem9VOVZ0b0RFQzlMRXU1VTk1UnJ2aDVaZDAzLzJ3bUpEaElR?=
 =?utf-8?B?VXpZTHFyWklzeGdJSnYxSXRNcmphWjFsVzAyVnJ4VnJ3NkF4cnRUVFdNOGlm?=
 =?utf-8?B?Tks4eDlCSU0xWjZwTGVyNmh5VGdTUG91QlcyUzBIUVp3QXd2NmhnNks2NUV5?=
 =?utf-8?B?K1A4VjhEWlNaVHAyTlVMcmtTNUhWQVJOZ1VHZm15SDRvcWtWU1VkczZqSHp4?=
 =?utf-8?B?T01zdWxTc3pCd1lRamxzSFBGY0N3dWNYUHJZRU1aQ1UrSFlIaitlWXR2Zjd3?=
 =?utf-8?B?SHhmTXRWWjJoRU4va3dRU0ViT3kxL1J2QzV1K3JmNlhveGRDVnV5TkloVHRO?=
 =?utf-8?B?MkQ5em5pQVhIWVp2SmtDdDYxSlpjMDBXRmNLVE5jNWIvVVNibExhU2FzVm9V?=
 =?utf-8?B?cG5sL2VoSWZyZ3BpWXlzcUoxSEN2V2hjN1dteVM5SGRmbkVHQVc2djZlY1Jj?=
 =?utf-8?B?NDJmTzFnZmxzQkZ4WU5EdERlS0ZDMFpBdHYrODFFeEw4UzRJYlU2UTc5NnZD?=
 =?utf-8?B?SU9QL2RIM1ZzVjV1bEdtVVduTmcrYWt3R0hYMFBXTVBPZS9GdStvY1hHbTBW?=
 =?utf-8?B?RWJqWmxYYkcvaG5NTWoxLzl6SzFhS1NNdVNSdCtiekFJSGM0cGZuT1JoTG00?=
 =?utf-8?B?b0xGMEg1cDhsNWlqbmlMOEx3N1RqTkhDWFprZDkzeWxOcytaZGJYOG5PYTZ5?=
 =?utf-8?B?WmVmb0dySVRRVktkTEtBMDZqNGIrQjEvUTVDSERiUTJxS2NoSVkyN2tFR3BE?=
 =?utf-8?B?ME9GSlpyRmN5VVFYK25DNlM0am1KMWN3MXBXSWJFQUxZSHMxSW13d1hYRFlU?=
 =?utf-8?B?Rm53YnFvWHZyYkNKZk5TRVU3c0FqZGZkdzBhOXYzU3N6a1ErZkQwY1NCOUFn?=
 =?utf-8?B?TWRiMUlSV0hxZ2xyVkFjZkU3MWtrdWR2c2htTTIxUjZ5TU5pcFRjbXZSdnBv?=
 =?utf-8?B?MisxMTh1NHZ2RVdBVTNyTnlaUGpkY1FiNFllYks5ZW5kTUpQbmlzYjRzb3Va?=
 =?utf-8?B?NHorcDRBUFBOSHhQK1BaYmJ6T0ZVMXRnV0U4NmRvV3ZOV1BUSHAvUXpNL3cw?=
 =?utf-8?B?Z2lwWDZrbTdMTnFoU2hWZDdkOEpuNFE5WWRqQllaMC8rSExQYWxXWkJCeEdV?=
 =?utf-8?B?T0xPRi9vNEMzWC9KRW1reUZZbXpWWDg3MGFMQlJycy9XYnN0bWJ1Zz09?=
X-Exchange-RoutingPolicyChecked:
	JAGsmqV+riHLhaJN8nN6r0d0ky471H2KatR7Y86ZWcBdDfSXVKeos3tqXfjMLi8x81eekT10Xp+8IfhFSuKB9Y9096HJbBy002LdnmdZWSlMJQQk0aD7alfrTX5SdGRiLklsmIiLteLQlKhm+91T13FYR5eVK4wfRVK+nOCXDBFIgMRzpxndKbzc13FuHwM3S1isH787NiLmhrGmEGlX6c/CXycI3U6Jn0v9ww49SrWKKFeZeT7/Nt1X79aJ/UVdADZnwdhi+X3y2Vwf3X31CjL3CBr6+aleHnv6H1uHyuwRABzTTHAufjzGoSE8gvqJaLS+NLDuHn3PVLXt/89IZg==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	seu3DJjc+R4Z5Njfrsj1eDuWrd3Fx0WOyOOA2DKz5txhGXQ9XaXbX2dirbvdPCB8FPfXjAEcls6wiAPC21uurkHUwr/W5vadBadmIw/Og5OXXbFlIqvjDIDFiD2xU429IaQBQV6p3JwvrXgXlPdDAHVcurp60WosqN4NQHBtjpW1zMMuee6A0WjWCXSF6fnzHziAqYiv+JgtchIXuDujrIt1Vgr8YrK4FWgcFSDHSx5Mm87GoZOTMKeqjDWPoTYQnfpBeVCrYnRYHUcJ7I5IQjw4IvfTE8lkGOiqGgdEmYrXIU1Un/K65zShRXtelfXIEOvtPdrgqTpDFtIg8NJvdNk5cvlLhEsoOfAhVZWNd8kOgf8iqRhe/XwRSQSrWOyRba6a4jwxxxeaUOw0CzDTSU77AuRO886bZmKEFsKbV5I6JrAusaHBpQ5dc5pyVml8Ks25LVGHdgMI6iJ/TRFiBNYyOo8ItrFo4Op30dLfcdDtHZEnZrr5alZFAarCUaUimz6Myv/3yuZoB/Xwp9rHcXEVAGX+WL5OvQtcokXQLbv3yz1LFBYhdrPRGq0u0t20WXLkvtsEV0KHc+SaxD5GLKbeTvQ0ddDbEk/aZv51M2M=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 60121713-efaf-429b-b62c-08df1d32550f
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB6229.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2026 07:30:12.4749
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9MjTbUtg7H/uSZ/Iv4bIJWZ/TWuQlK3Acdb5A1DzF+sOsbIOs3z9Fr93YHghO+KUXtg6IM2IivIRad2OSPdCrA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6401
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-26_05,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 lowpriorityscore=0 mlxlogscore=999 suspectscore=0 mlxscore=0 bulkscore=0
 spamscore=0 adultscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2609040000 definitions=main-2609280029
X-Proofpoint-ORIG-GUID: EsuzFb7jof9leqyqDhtbhhbPThqONWD0
X-Proofpoint-GUID: EsuzFb7jof9leqyqDhtbhhbPThqONWD0
X-Authority-Analysis: v=2.4 cv=eJCGH3p1 c=1 sm=1 tr=0 ts=6aba178a cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=VdqzKS8jKosA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=jiCTI4zE5U7BLdzWsZGv:22 a=x4eqshVgHu-cdnggieHk:22 a=XNhLk42N8j_XklSECEEA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI4MDAyOSBTYWx0ZWRfX+wocJLnktoZ6
 REp7ojhMh+eGKHL3r/Mqj/4g9+3PaWD6neHh40psKuAQ66KOylgS95keAlMjltNj0scsrw+7cM1
 av5eaGBpsuLSNuBIjZv36GYZiRpkx2GtVdYSBlQnZTbT8mC/gz+0
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI4MDAyOSBTYWx0ZWRfX9FSJjufYEUse
 +qBo19cc+NFQ9awRB4C5voclZnq407jOb3LwTMornWdqpMIhu2e8SOP/5GQFVifo3eaEc4tRb/f
 cMkeQ8JE00Ho4gv+XoAYvmOh/qRqPHwREbQRdiaUjF2Ai6EGXkcB0B9SG0RMGSnhAYJ4sX3Mbmg
 v416wFbs5uPM9G6O14Amj1b8RbMfbPnqIrMQ0msbXNiYPRQrNpfPNovNIpaeOSMxAl3FzfJ0cvr
 7UKjpu48cF+/L84cYFJgOCj5PKvV8gP9o3XmafVATyoOpdzJr+LGhmuqHOpriMZFGUYMAH0Sva9
 XUy3CpjRcd38ArNT0/Yk1dAd9olXTPriFIqV4E8CvFyHUp8qMJdrojGhATw3VpXlZkqJHkMSXNX
 d6L3URbsvCA7z+GFpGstl4nKg1knmjhjf1Ovbz08nV2yB5KNqlOmK6NT5fEwxmDlJ2eR2cmuGsA
 Ean9G7NaGSNuR1EZFJw==

On 21/09/2026 09:37, John Garry wrote:

A reminder on this one ... or are we just going to leave this broken?

> 
> Currently the NVMe multipath partition diskstats are not maintained.
> This is because the functionality to update the diskstats only updates
> for the whole disk (and not per partition).
> 
> As an example:
> $ ./fio_read nvme1n1p1 # run traffic on /dev/nvme1n1p1
> ...
> $ more /proc/diskstats | grep nvme1
>   259       2 nvme1c1n1 49857 0 400344 768565 0 0 0 0 0 2334 768565 0 0 0 0 0 0
>   259       3 nvme1n1 99710 0 800680 1599285 0 0 0 0 0 2346 1599285 0 0 0 0 0 0
>   259       5 nvme1n1p1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
>   259       4 nvme1c2n1 49853 0 400336 831472 0 0 0 0 0 2315 831472 0 0 0 0 0 0
> 
> Notice how all values are 0 for nvme1n1p1.
> 
> This series addresses that problem by first updating the gendisk code to
> create the partition table for hidden disks, as suggested by Keith.
> 
> This is done by cloning the partition table from the multipath disk.
> 
> Secondly the NVMe multipath functionality to handle the diskstats is
> modified to handle the gendisk partition, by looking up this partition
> from the per-path disk partition.
> 
> Difference to v3:
> - Add block device operation disk changed CB
> 
> Difference to v2:
> - don't scan per-path disk, and clone from multipath disk instead
> 
> John Garry (4):
>    block: support cloning partitions
>    block: don't show partition diskstats for GENHD_FL_HIDDEN
>    nvme-multipath: clone head disk partitions to per-path disks
>    nvme-multipath: fix diskstats for partitions
> 
>   block/genhd.c                 |  3 +-
>   block/partitions/core.c       | 43 ++++++++++++++++++
>   drivers/nvme/host/multipath.c | 83 ++++++++++++++++++++++++++++++-----
>   include/linux/blkdev.h        |  2 +
>   4 files changed, 120 insertions(+), 11 deletions(-)
> 

