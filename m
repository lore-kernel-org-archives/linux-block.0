Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C5502E6D22
	for <linux-block@vger.kernel.org>; Thu, 10 Jul 2025 17:39:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752169152; cv=fail; b=ePC/5jqe7zm/zmdUGqOH1qcObopKpj5Y+4BjOHFBxLE9SCArLxNGPsT3k//NdW98JS+SFsLrLhRGrbYPUb+mG9pmDTUgRHUen5OW4Bnptbv29u3qyNvKRjPztbd8gymESzK9KHuwR/7ejG6wt4eibfp7FrYynmpVd3mKHzu5thc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752169152; c=relaxed/simple;
	bh=CVbklZPcwYEGy8MgMJQ7HTUlxEofDdaC9TGy1QC5vFg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=CKNM4XV6djUWs3dWTtI+Bjk24dTHR5CQ+gqmTl7JlT4uknP8pz1V6b/CHKCiAbYMsLlxSMXL9gGPsTDVyCLYVtIM4IVw/FL0fGVKqilqwml/EkX+v95uVKWDdq8UtU9p07OLxGmoxgKW5jCB8Al0eQ27vCRRfGXlmjpPdUU4TYY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=shQhaItj; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Gm2wzoik; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="shQhaItj";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Gm2wzoik"
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56AHYuXA013154;
	Thu, 10 Jul 2025 17:39:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=CpChBmN1TnM0p/pdOAfAmRhEer20aFBjDJ67oQcjaGc=; b=
	shQhaItjAo8m7AjqwSpN2f/rbpHq4GT6Sf7RUykM7gBf4Z7haEAXMCorc95lrEC5
	Gf5Btf/z5JFyuWeNZ4JGcaEGPlIUSShdMlKxgdc5IBHciMwucmBNol9dg1MXW8p2
	5acq662tVWsaUYdd09NYEy5ZCNg9AslnZ2gO5YH0wx6AlGVLCJfOYbJR1OruxX+A
	f3ve4i4/iXPoTbCnDB9cSIqE/EIfdvVXu6uZQAYjYiPjz191fIslaZ7VQ8l2yE83
	q/aE+b6sMEY+pwfBJTFRo4MBqWTRWoSca6x04dqjza0LhneLO4FX/IKf5pz83QKG
	+6keMQ0CZQ2QZ9FO3xLp3Q==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47thwxr130-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 10 Jul 2025 17:39:09 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 56AHLeCv014067;
	Thu, 10 Jul 2025 17:39:09 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11on2078.outbound.protection.outlook.com [40.107.236.78])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 47ptgckqp6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 10 Jul 2025 17:39:08 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ej+2LtS/Zd8d7Ch9YeymwWqmbwN2R55kAu66/SBkvGtnKv4NHuOd3Dfu46Y2mv1rsI7vPkJiw8LEvD31ECov8D7wN0YBhZoKWevJXg04hFWtNbUkxNBy+TLKonYKwQE4RLj3Z6h6cS1oJYRl1FGi033P5Bj7m8NiMSt5rVkVEXRu6fNSjWWKwUzRpCQoaViBmvb9rHw5gcdBs2HS7lrtIgPTBQFdy4Fkwh/MTuTLwOXM4YfjZGEUQmy2d5/CK8092aSNt2Ix2U9BP2u6njlJhkEe70/b21ABqzN10MqS92BpTpPYTjzgf7XaeRmWPX30Qfa5hR1R2KfkkGbH/3qqIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CpChBmN1TnM0p/pdOAfAmRhEer20aFBjDJ67oQcjaGc=;
 b=fnLG1smDh/CxxOEaA751CHsiZOUKe5z3Xgs2f2kvpMFiXoaQbAdBeAPJyRPYiKdz3CS75IVb7epFdCl0gJv8GHe4IougtFbHrvLEjp7JW/bvwDRhO3e6VMEuvY3k4QQcI1eqOSDAAVS7oEoMrgZyhd3CR4NW4M7DzswhUMEZGrqxzeLTMEELExcaDB53KJxdv0HO9Vcyog9ubJdtCx2wVi714p2Qj6lpstzg3Q/gun7eLnAkh/Ru88AlT77BUgw7EKtj01y02VOQsHj67WCk39s86XnGkpFMaysXfOMiMmVL9/a6OlClpZFxDu0klNmWJaMiT/mpps376x3xOt2umg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CpChBmN1TnM0p/pdOAfAmRhEer20aFBjDJ67oQcjaGc=;
 b=Gm2wzoikvH78mIaa5nWymAWGrjMS08C5XYoNq9SK6zO3sT35Hv5sT41c9wTJKrDKCD1LWOBuByxwl1cIpV1bgrMirHtt7r1/TE+InppTwGqgZYyVsdUqQBOhPpQr6HZ2bvXr3+EThJe+vkhPZcua0MYWXLkEciOadut1H0ZV/oY=
Received: from SJ0PR10MB5550.namprd10.prod.outlook.com (2603:10b6:a03:3d3::5)
 by SJ5PPFB6A054FAC.namprd10.prod.outlook.com (2603:10b6:a0f:fc02::7c5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.28; Thu, 10 Jul
 2025 17:39:05 +0000
Received: from SJ0PR10MB5550.namprd10.prod.outlook.com
 ([fe80::10a5:f5f4:a06d:ecdf]) by SJ0PR10MB5550.namprd10.prod.outlook.com
 ([fe80::10a5:f5f4:a06d:ecdf%6]) with mapi id 15.20.8901.030; Thu, 10 Jul 2025
 17:39:05 +0000
Message-ID: <1c2ce026-2ba7-417e-bafc-f6bebfd79ad3@oracle.com>
Date: Thu, 10 Jul 2025 10:38:58 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH blktests v3] md/002: add atomic write tests for md/stacked
 devices
To: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
        linux-block@vger.kernel.org
Cc: John Garry <john.g.garry@oracle.com>
References: <20250710045537.70498-1-shinichiro.kawasaki@wdc.com>
Content-Language: en-US
From: alan.adamson@oracle.com
In-Reply-To: <20250710045537.70498-1-shinichiro.kawasaki@wdc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM0PR02CA0143.eurprd02.prod.outlook.com
 (2603:10a6:20b:28d::10) To SJ0PR10MB5550.namprd10.prod.outlook.com
 (2603:10b6:a03:3d3::5)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5550:EE_|SJ5PPFB6A054FAC:EE_
X-MS-Office365-Filtering-Correlation-Id: 9ad72171-080a-4678-9fa0-08ddbfd8aa81
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?b2dyVGgveWZES05SRytlV1VoKzhUNnJXQzhjc0NOWm1VYXp3RUFWbExqdFVQ?=
 =?utf-8?B?NHE1bjJzVHFqNHp5YkNIZmR1MUJZWGl2d3dVckR0TDRseVZNdVZ3YUZpUnh0?=
 =?utf-8?B?VGxoU2VPVGgwekZoMU1rak5LUUxyNnI2clZCdnp4UENZeTZQb1hocXQyUTV2?=
 =?utf-8?B?bjIvaW1pZ2lvMEVTQUZNYnBmMS9BQzQ4N0hFSEo1aUo4ZmM0UFpNeUNXcWtO?=
 =?utf-8?B?c3lNU3lGUkpOYW1oNWxWeXUxS2VlSFNhdTBwWUNUTXpsS0pYR2Fvdk1TTytp?=
 =?utf-8?B?QVg3b09QeDFKRWE3amxWQ0kvenBIdWltRUFlR29jbStKOGZ5NGh0VXhyTWZj?=
 =?utf-8?B?a3RsWStYRkRKR25qNzJYYmV0QmVVRWlJeTNyWmpZdmJ1TTNVZjF6Nzd1cEVS?=
 =?utf-8?B?VFROSjErbndvMTRMU0I4N1Z6Sk9DbmEyTmxDWFhyWFZtMHAwVkZKUDU5Q1RM?=
 =?utf-8?B?Y0pKZ1pMUTc1cGxuYzZRbUlibk85eGl3TzNRZHBOY094YXFmOFUxOXFjU0la?=
 =?utf-8?B?Q2lINndCUDE0a1dIZDZVdS9lR2lxTG5nUkl6TGdBYTYzTHE1NVlGZ25NUDNh?=
 =?utf-8?B?WFJmSXlrQjU5Zk81WkFzdmJpSVY3QXQxUUFvYjdiREhXNk4wMXpMZ3lrWE1H?=
 =?utf-8?B?encwTjEzek5MZUF1MzV1T25HUFRHSTJkMVlDV0VPYS9iNzQ1VW1oOElqdk9z?=
 =?utf-8?B?NG10YUJENjRKcWFDcW4vYnJRQ0ZtVEJhaDR4ZjdWbG1qc0U1NFhSemdaRnhl?=
 =?utf-8?B?TmN0VU1JWnRqdmI4UXJRNnVpV2FpZDRhaDlPLy85cjJBMUdWVHQ2MGNhVHpw?=
 =?utf-8?B?Y05JN01EWG5HcjRNcjZDZjdXc0lzYmdiTnBBaThjS2NxVkRDbXRkUDlXMllP?=
 =?utf-8?B?ZVF1Z3E3Rm9qeVRPNTdUUzNlekpxdTJBbk1XbEVSMGNBTyt5eFA5Tk9nT3pK?=
 =?utf-8?B?SjFraXFtSUxQd3RHc1lMVER5Y2ZhT3lFbkw1aXRRQzkrYTdEMlE1M1B6QzJC?=
 =?utf-8?B?TVpwTkdvTldOY05reUxlSlllVUdVR00yWGJlc0JibnppTzZ4OXdjWWZRSmQ0?=
 =?utf-8?B?MFBuRTNXaHM2TUw3V2VLVFpvQm1pbEhHRllvcC9wUUZiQW1mSm03bXRKNy9u?=
 =?utf-8?B?cGFrU3RUOWhMdTJZUE5TMHlsVUdYNlZzOE9oemVPaXRLMmtxTWFMQnU0aXBD?=
 =?utf-8?B?WnpITzhJYUJPSHpNRXAxdTZmREx0T3RBaDJZV3h5TEpLbnpRSlZ3UlhzcTlV?=
 =?utf-8?B?UTJ0V3Bhc0EzN3pidDFNT0FHN3YxUTg4OGZ4WGtUWmFkSG5wbW5XWUtCaEhp?=
 =?utf-8?B?ZUUyS2tNQTd5WkZiWExLV0ZtbExaVE9LZEp1OGx1R1lIWHFqT2lCQ1ppQnU5?=
 =?utf-8?B?bkU3WjExTnBoUmFXbkUxRWxUZ2puTUFEeXQvejVyMzJCUU5oMnJQU0V3b3Ar?=
 =?utf-8?B?YWFtREZneE5MQ0FlYVdqT05kV1NFVEVZNFp1a1dGcXNlNnNCRDRZVlcydFJJ?=
 =?utf-8?B?WS9CSWhobWY1SmZFOEhJQk42Y3NyNEp6YVdlNGQxSU9tT0xzNmRYcmF2WTRv?=
 =?utf-8?B?OG8zcjZvVUdZSnczR0M3K0FkNHdqMVdTWUFSTjV5TFV2YWplb1FzTlBUcDZ1?=
 =?utf-8?B?ZVBESHVIOGFjajdRYXNvRzMyTVVMZVZmSnR6aGJqRTVCUnc1dHdKSnhTV0Y1?=
 =?utf-8?B?Y2lyOSticktidzdtRTFuTCt1ZE5lR1dvUHdGcHNPelZOSEsvWFJoZjRDRGRv?=
 =?utf-8?B?SFY2QzR2bXZBWFo5Vzlra0ZiVUJzSHJ5MUFZRGtFVU9PSkdwMjNudUVoUWE4?=
 =?utf-8?B?ejZ5bm8xalJucFFlVGJoNUNDaDgzaEtsd3pheDVqQWMyUStJUHhzemJoRHNQ?=
 =?utf-8?B?QytYbzNtdFRVWWQ1UmZuRitydUF0QkhYTEpPSmgwc0EweWRlSXFhVjNlMG9r?=
 =?utf-8?Q?ctwFRO7dSDc=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB5550.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UUFoNjBHRXNwbUhqcC9nV3BzaFNKQXZFcW03bUhIT3k1THNhM2RuNnRQYXk1?=
 =?utf-8?B?RTBUYU1Ud3pRWVpqMUgvdlZCcGFvSnlVL3BBMkd4MHNzcFhDeWlBV0loa055?=
 =?utf-8?B?dzVIMzdIZDJpUzdBK25qREdXMzZVWkVXRStjaHJDL2VPYW9yQThnTGpGVUtw?=
 =?utf-8?B?cmovUndKMzJkM2JETEw0NnlwQnBUbWYrWXcreXNnN1g0UlJrSGw5VUVNV0Fu?=
 =?utf-8?B?dEhnQkZ2OU5JQUlFTnNHblFRbE90dGNvMnhWNFNubVdzQ3pBVVd3ZHptdlZ2?=
 =?utf-8?B?dWE0b1VIRjlEakFtcG5YWFpFUElvU3BkZ3hmUVpmeEN4Sk5tQ1l2TjlmWmNO?=
 =?utf-8?B?R1IvQnlBU29obitRdmp0T09oNmhxU2oxQkRYRk1rUy9vVCs4aWNUTk5GVTB0?=
 =?utf-8?B?aHV0UUZiUUkwWlhqWGRNbHBvRzlHdTRqUDBiSUtEa0MwNUZldjhXdEhGTE5G?=
 =?utf-8?B?eWZuZkJwTjFwemw3RXhFam84YitVWTFpY2FxaHI4bHNZZDVUWTdMZENmRG5a?=
 =?utf-8?B?TmdLTHBGQmVzVEFnV0tBM2pScWoyYnJ0V1lzQU1MempJYWo0QzBscjRjT3Y5?=
 =?utf-8?B?M3V5UmVRb1ptSzh3T09xaG5ScitzTG8wTXZlbUFJNEU4a205M092QlVYcyt1?=
 =?utf-8?B?RkR0ejJURHEvV0pkb0VxRVBsS2hvdXN2OTBDTkVxTENCWm9NMGEvN0JtSklr?=
 =?utf-8?B?RzZSU2tscjgzcjFEZzNubkFwSHVLdS8yT08wU1ZmUDVrRE5aOGd2THd0QnBy?=
 =?utf-8?B?clkvOVhBdDNzVktzWm4yeUsxR1lRSVVxVDNwck1RWGNIY2RPK3F0bUwvWXAr?=
 =?utf-8?B?cWdKQURHaUZpazZTTXNJWGpacFlGU1ZVQjRiRUwzYzR5QlBPSEc3Q2locGZV?=
 =?utf-8?B?a0hITDJNTjJjWXBTWGw0OTdBNFJoRTRiL0d3UXlwRTZzK0s2eEovaUdiQmZz?=
 =?utf-8?B?NjVhVTF5ZWQ1RUFBWndXSFIrc2pPd3h3ZFB4Q29GSzE4d09yWDh0VkhYRTBS?=
 =?utf-8?B?MndpMnBJa2wvclNaODNhanUvK09XL1RIZEZSMEdxUTJwejJiVkl2T21lUFFU?=
 =?utf-8?B?VlpUeE1vRVpRRmhtaGN5NlgrNXllNFZ2S3VOdmJCYm1hNEFIQnVYQk5OcVdp?=
 =?utf-8?B?eUx2bTk4djBTcTc0RVgzbGpyYlRmeGhEczhuNWxrMTVsQjlOT0RSdEtFUzRx?=
 =?utf-8?B?L2d6NjNHWVNYQU9lM3Y0dXhSZmhONEUxOWlJN21TUk95bTFiVUNPNjEwb2U3?=
 =?utf-8?B?SGcrV2IwbUlaOEsrcTRoelJZZjM4U2pPTExBRVRGck1yMlM2VTVQcXZYaENL?=
 =?utf-8?B?RmlzdjhuODdBT1Mwbnc2R2p2VlJTdm1kZEZzNnNreVNBSFlqV2tYUGpqODZh?=
 =?utf-8?B?cCt0UDdYbmV4TmdQdFQ3ZkxQSmpFTVRIU1RzekZiaCt6OElOQXJ3OHQ5WC9y?=
 =?utf-8?B?TFljVkNNUVpOYU85SWhVRk8yd0lsRjhNbStYQmdrR24zUFhWa0dqektBQ1Ry?=
 =?utf-8?B?SmV3b0w3dGYydGRDUGU4TEROM3pjcW5TTXlBbHVTVGhXT0Q4Nm84YVVpWS9t?=
 =?utf-8?B?dzlIR1BVMVdNcE1YQVBUdmN1QW0rZGttMzlQWktPMHMzWTFsSG9KRnh4QUEx?=
 =?utf-8?B?eEQ0amlDZGdobUVLaHFuRytVQ1c2ZThEc1ByRjN6dlhYK1BpU0FDalhlL3Nx?=
 =?utf-8?B?T09XOFBCMGpodkpkYkZWRk90NzhqTU5UMkdOSXBhUThLemNFQ1RSRWFtZ3lY?=
 =?utf-8?B?Ym9FOG5yWXZxZWc3NjZ0MW85T2FHRnoxbm1kMVcvVzl1bDJ0OEM5TnpzNXhS?=
 =?utf-8?B?ZlNxYjc5eFQwenVZVys0MkdIOGFKc1g0Q0pCQXhXUU0remw0Ymh3RlA4MGxS?=
 =?utf-8?B?Q2NjcVQ2UG1Wd2dyV01pWmEram5NYU93Rmt4dTVLUG56UUxCT0ZSMDJYbkw3?=
 =?utf-8?B?dk1ORURXMVVqNjlEZEFERTRpbXFXNzhVZmthQ3lhb1hTbnlwOGRCa2I1Vmh5?=
 =?utf-8?B?L2Y1dVo1dVdNNG5jQ1VNWi9VQU94Y2tFZjJxbVNITjZlSnpZQlBybmlWb0F4?=
 =?utf-8?B?R1B0ZGplczN6cFNvMmxzV1NNSm96eEZiV21xQmJMQk4zdmtMU2Nod3FYM200?=
 =?utf-8?B?cFJVTHlCbm42VWRQM3ZLQXJoVGpzSzQ1THd0bm9WRWNzYWw3QVhYaFlGM1lx?=
 =?utf-8?B?L1E9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	MPhxF6T1mlLlo/byG/WwsPs+DbhkdTCmU/hk3MYnnmeuFZ2eI0MPI38+uYvcXEELCEU+j2fdMNq4aDVNs96k97vDAwdfclv8e9ylevY+xmjWi5cNhf+2zx1Fj7jD09vkOeS86aCcSuHnI0XTfIP+3ZAhZ4pfanVJsW7dMLGSEoZEYq8VWzttgAohTrbZy7ynHpbnJSkL+CIytgPnxjF5efjGcGpJoA5sjI/q1aS+tcpIzC9nXJz1qW3F7Hriznmx/ja8+MK9NNo5ckqrtaWMe6GgcIUZ2utFhs6msCH7QJ0/CKhKKHaXn3cgfPcLzgs/7ufZV7LA0IaXe5OV0Q/MUAgeDJeG0KaM/63uBkdjvAXnZl46b1yi9f9gUyg2vGgkpxGMZPdpwIPYnNboelEWL+zU5D343S3LnQL48drHuKCZKaI/tJJB8HbqMEZY4uptfMBCgEf4o5R8vjFyyv/uOeDiTx9OxAqc9y/KD7Hccn6FBK1/qML6XoJROyYrUMbsWnkAMu4+tr7P3X8otRDJYe8kopsN7xmF7BGTWTqPiWkfzJa8IkFCXwQoapB6oMGtwbvW4qWBdpQfwinep2P4NeE0MNbgzd1WuAiTVMaeLe0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ad72171-080a-4678-9fa0-08ddbfd8aa81
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB5550.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2025 17:39:05.5341
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cKNbiyZeyh37RfqHN9yOhciWdMlRRyV+vLiqDbsARo+SJQOqGR55zOuwkmDcDslqGgL0wfXSFYI3mla03RulaA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPFB6A054FAC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-10_04,2025-07-09_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 adultscore=0
 suspectscore=0 malwarescore=0 bulkscore=0 mlxlogscore=999 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2505160000 definitions=main-2507100150
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzEwMDE1MCBTYWx0ZWRfX3qE1+8JT5qcL y359hvMDLkarnJsgRspGi9cgsWqwZmi+CUaR33+AlElOa8qtOCOpcGHeRm9/Kt1nsEmGFQoIsfh SbyVSamZTlpewm8G8fD0e//6PAKnvjkDDTLdX4FrrToIirdCWa2C8ugM8UN1UDA8AcNf8Q6LMEo
 R1PNs/vKUQrUxkpqhumju5AADuZngun7CFKcjnMHi16AUdmvn8SyasMbhr6z4O/WVz0QrPjE+o8 SW4FrCJ3oEFZCF1hzr0aScM9PDV784BniXvpE8S1nyxz6tKT9SGiDomoPjnmv6j+CaFFn4PBqMF RLYzKsvOqDLNAegnlgTx3IVE7+u1PIKkh8g73o7o0H+/OBcj1FqloQdF9fYLcc/mKOmewgeiTE2
 mnmcK2W1MHHqPaERuu6DLXjzQzZJH57TnSBuY5D03spVFh+pxCOYr7SD5AD7z4ZaPLtilaF7
X-Proofpoint-GUID: 1sG_nOnAjSG2c2bOrLocNi6MoxOW1Zw5
X-Authority-Analysis: v=2.4 cv=JeO8rVKV c=1 sm=1 tr=0 ts=686ffabd b=1 cx=c_pps a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10 a=KboM1uzekkU_W5_Bh0YA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 cc=ntf awl=host:12062
X-Proofpoint-ORIG-GUID: 1sG_nOnAjSG2c2bOrLocNi6MoxOW1Zw5

> +		if [ "$raid_level" = 0 ] || [ "$raid_level" = 10 ]
> +		then
> +			md_chunk_size=$(( "$scsi_sysfs_atomic_unit_max_bytes" / 2048))
> +
> +			if [ "$raid_level" = 0 ]
> +			then
> +				echo y | mdadm --create /dev/md/blktests_md --level=$raid_level \
> +					--raid-devices=2 --chunk="${md_chunk_size}"K --force \
> +					/dev/"${scsi_0}" /dev/"${scsi_1}" 2> /dev/null 1>&2
> +			else
> +				echo y | mdadm --create /dev/md/blktests_md --level=$raid_level \
> +					--raid-devices=4 --chunk="${md_chunk_size}"K --force \
> +					/dev/"${scsi_0}" /dev/"${scsi_1}" \
> +					/dev/"${scsi_2}" /dev/"${scsi_3}" 2> /dev/null 1>&2
> +			fi
> +
> +			md_dev=$(readlink /dev/md/blktests_md | sed 's|\.\./||')
> +			md_dev_sysfs="/sys/devices/virtual/block/${md_dev}"
> +			md_sysfs_atomic_unit_max_bytes=$(< "${md_dev_sysfs}"/queue/atomic_write_unit_max_bytes)
> +			test_desc="TEST 12 RAID $raid_level - Verify chunk size "
> +			if [ "$md_chunk_size" -le "$md_sysfs_atomic_unit_max_bytes" ] && \
> +				   (( md_sysfs_atomic_unit_max_bytes % md_chunk_size == 0 ))
> +			then
> +				echo "$test_desc - pass"
> +			else
> +				echo "$test_desc - fail $md_chunk_size - $md_sysfs_atomic_unit_max_bytes"
> +			fi
> +

Oops, md_chunk_size is in kbs.  Should be in bytes.


diff --git a/tests/md/002 b/tests/md/002
index 79c0d15..79f260b 100755
--- a/tests/md/002
+++ b/tests/md/002
@@ -29,6 +29,7 @@ test() {
         local md_sysfs_max_hw_sectors_kb
         local md_max_hw_bytes
         local md_chunk_size
+       local md_chunk_size_bytes
         local md_sysfs_logical_block_size
         local md_sysfs_atomic_max_bytes
         local md_sysfs_atomic_unit_max_bytes
@@ -226,13 +227,14 @@ test() {
                         md_dev=$(readlink /dev/md/blktests_md | sed 
's|\.\./||')
md_dev_sysfs="/sys/devices/virtual/block/${md_dev}"
                         md_sysfs_atomic_unit_max_bytes=$(< 
"${md_dev_sysfs}"/queue/atomic_write_unit_max_bytes)
+                       md_chunk_size_bytes=$(( "$md_chunk_size" * 1024))
                         test_desc="TEST 12 RAID $raid_level - Verify 
chunk size "
-                       if [ "$md_chunk_size" -le 
"$md_sysfs_atomic_unit_max_bytes" ] && \
-                                  (( md_sysfs_atomic_unit_max_bytes % 
md_chunk_size == 0 ))
+                       if [ "$md_chunk_size_bytes" -le 
"$md_sysfs_atomic_unit_max_bytes" ] && \
+                                  (( md_sysfs_atomic_unit_max_bytes % 
md_chunk_size_bytes == 0 ))
                         then
                                 echo "$test_desc - pass"
                         else
-                               echo "$test_desc - fail $md_chunk_size - 
$md_sysfs_atomic_unit_max_bytes"
+                               echo "$test_desc - fail 
$md_chunk_size_bytes - $md_sysfs_atomic_unit_max_bytes"
                         fi

                         mdadm --quiet --stop /dev/md/blktests_md


Alan


