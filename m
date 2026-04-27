Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B15F3126C2
	for <linux-block@vger.kernel.org>; Mon, 27 Apr 2026 12:51:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777294295; cv=fail; b=SP4UgNHYC5lF/Oc8wpSUHFAEkFolG01/SR+GKnPvhQIhivECEYpCU/FzVBPDhDBPqfZDhD5G6hMsektV/V3C7TtoXXCwcXpr5URQ7YOXraIXZE3EgRcopPfHf/72KE8YyGlSsRPiT/OG2s0W0tHHcVAryXkLCo6CoL3LMKRnUzY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777294295; c=relaxed/simple;
	bh=4s3jFOok2ZqB9L6KfmB8ZV2a8QacYMtRqDVtOni4x0k=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=erZVcSAL5nWDp/p+Po/sENJbM9/lbBfguRNzP3sNQATpK/sk5l0ZqNiPNGorLmqic4iZQVN1SsftASPsoTUlxFu7w64kvW0dzkz6VND6BHyseFAOt3hfxHzTM0LCRfKFTv19Yas5WrJ9LfV/RWT8xxCCIXDsI0Fnx5SgXbMa04U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Fo1QObl+; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=IVkrxCu+; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Fo1QObl+";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="IVkrxCu+"
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63R0t9kx3067689;
	Mon, 27 Apr 2026 12:51:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=0DGpBhqyn4xFm9uuBEUv9/PG/vanhL9hDvwqrSHAMMc=; b=
	Fo1QObl+RT3gnI1C5jyqNNct+ZJvzU4LMLYibNefwc0qFoz1nShppxR1jqc3K0ls
	9Ogeqpxx8u2P6UGZbN5fEMPGHmRLS2tzwX8F/knGBYeBg+797LfzWgB6J7sucXd+
	tv2zbhbZMIug42M8tAiY9/ndfkLX39m/62nQe2Rhf4md1VaMOOLaFTXqdb7de0Qz
	VjRiw+exi34oyuqDd5OjdazvaD50SbXlXbvG4/wbCWu/gIhv0mYPnWEpp4/HMLrJ
	uFnAwiRgNSxPiDlRWfbyVL0QBxaZnjr02/PpEC3SGWDF4q5AwagHEpZ6kap6l2eV
	hXb5OifBeUEW0xRtIzwdGw==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4drm6yu3gy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 27 Apr 2026 12:51:27 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 63RCmgZ3015276;
	Mon, 27 Apr 2026 12:51:26 GMT
Received: from sa9pr02cu001.outbound.protection.outlook.com (mail-southcentralusazon11013011.outbound.protection.outlook.com [40.93.196.11])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4drm2h5b20-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 27 Apr 2026 12:51:26 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IAYZcHvKyeZ0bOo0zUt51UKHDCnm0M0eNZbdqocklVvrGlRvH7YRrqxS+QDSId1Lygf4l9pqWT1uirlZ+LvMv4lFr/DbLHRv06OJnZFOIrGOw3uZIy1a1PbZ0gxE2vRZQ41t0gTg0TtG2K5XLDXjhuFx8tfkNhGiORr94CEvKeuvx8hXwbdQBGJ+B7tikvqAXRrPiRNwdduqzkEKvw781zwSuVXGdX3c5YRETPCcnV/OuLNsI+YKVAD/az2Jle9WGbSax81nzyGgUYD5S8ksO1YkRAGLogoQ74g95qvw4KGg3kAFA+SWNS8oXg35kXGG2iI8Wh3n+gqMqT97TWz8UA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0DGpBhqyn4xFm9uuBEUv9/PG/vanhL9hDvwqrSHAMMc=;
 b=Fx+VWryby0SwO7Gh72eE4PCkWmkFVgqj9H3WobdrM+KMpCiodv/2ZBvWUITGAqyAQN/Yoy/zBJsl+9Epazf1QjCIxNki+wqnl0llKnw0vsynZquix5t2vNi7FHvRpvHn9mtO6U3BgkHMr1YyJGab+xZfAfPCl4dHafvIvx8mwvdYoVGgy+snFtgyFv3wCDS/Esj6orDGrJn/aOXknuDh4EFBhqBC5Z9mzqTpHVve+xxuar2yLJfj9BwcBcuZ7RNaoeh6IfINJhov1iSal0/9T8MeCkuNo4XZBFbwMNKwg6QR8Jz0aSPjnkpGLNG0GqOD0uW6f5dImpaAXy9utuqthA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0DGpBhqyn4xFm9uuBEUv9/PG/vanhL9hDvwqrSHAMMc=;
 b=IVkrxCu+Fm2zuz1pq1JyOTWJbBWQAc5w6A1E1TbeYpaShiwAZaQ5owBv5bunyPbwrJAouY0RXR5TsagH22XkbtItaPeuW7sRlftqDcM1nB4ELs5KNhQ/+MvVILW8ZggmLhA23NtU0KEqo+eFqFt/9Ro9yoWQ6wag5RT8bGtPsmI=
Received: from DS4PPFEAFA21C69.namprd10.prod.outlook.com
 (2603:10b6:f:fc00::d54) by DS0PR10MB8150.namprd10.prod.outlook.com
 (2603:10b6:8:203::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.26; Mon, 27 Apr
 2026 12:51:20 +0000
Received: from DS4PPFEAFA21C69.namprd10.prod.outlook.com
 ([fe80::9da2:46fe:4d63:a74b]) by DS4PPFEAFA21C69.namprd10.prod.outlook.com
 ([fe80::9da2:46fe:4d63:a74b%7]) with mapi id 15.20.9846.025; Mon, 27 Apr 2026
 12:51:20 +0000
Message-ID: <2512cec3-31a8-4703-a50e-85289c860d25@oracle.com>
Date: Mon, 27 Apr 2026 13:51:17 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH blktests] nvme/068: add a test for multipath delayed
 removal
To: Daniel Wagner <dwagner@suse.de>
Cc: shinichiro.kawasaki@wdc.com, linux-block@vger.kernel.org,
        linux-nvme@lists.infradead.org, nilay@linux.ibm.com
References: <20260415104111.1439459-1-john.g.garry@oracle.com>
 <655129a4-de84-4c10-9e55-f75143684b7c@flourine.local>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <655129a4-de84-4c10-9e55-f75143684b7c@flourine.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0223.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1a6::12) To DS4PPFEAFA21C69.namprd10.prod.outlook.com
 (2603:10b6:f:fc00::d54)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPFEAFA21C69:EE_|DS0PR10MB8150:EE_
X-MS-Office365-Filtering-Correlation-Id: 450ec1f7-0418-4ee7-d0e6-08dea45bae29
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	Z7JwJyQwbYoGZRlKw5bhFqWeJaRbXOswqMFssRIdfQmxj/XB3gt1PHtWnLajCqt0oe/9N+u0P95fkHqg5taGjDpeJ7x71q6e/vUt2W2lVMY2Xwh/jwpqeaxlrdD7+rI2wdpYNHZd03lqoa7ndfoSdZ4H/3+Wza03ilYcS+fjbmBsfB1E907YrE6dAS/FsQE0Kk9rMbGc92V/5C2CYiDuwfIJhN/I0R034OwF/RpGq1VlV/CBmN5sCuL8txYglSoXQ/Ax7dNnNEgK+F4IMbG//ubgzc/VUUEAJEC/b/cGWG5K//BVamzIUQHtwXSkaMRc6bJIqhstqOBoWClvQDysrLPyEVb550cFnOAhQsLjc8tl3I6SY48exITN3E1Ej78OzNwMtSCE5mrO2sauQmIUJ5qzqi774+fJk4JzjoOr0EP4lbsItcLbTrPmf95s0kkhlS54ysEFSN5/jB/RJ7sebTmTV6Tn8kf5vlkjHH9kDTvStgrAWnajYGLwIc+9DkMnV0v3046lHOA17x6mMR6yNjDEszi3/lcQ0KacbN8LbEM6z5EdmSZxGQQ9Y+KgXoTq07RoY/gx7l/Q6Qy1W2CC6KVTI6H+/9PmDnRRB3yh5b6CKIly3pK8xCF+cxw/tMIZ13vkH0rkryaMoZSnDazlOE7NdGZX1E8HfgxHWkLbbYrJJERexNbROj9YFa+nzQg4WoghOVj9x8VtwB+iTGyIRvizsCM0TEMUc2ntqd74IW0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPFEAFA21C69.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TVFlV3FpREczZ0c5R2ROZ3RVTlFYdXVCQjRxaGxQa2RMaUlveGMrRkhEMGg2?=
 =?utf-8?B?dHZjZ0YrUlJVcDF6NG16U1Jhc2g5WU1WT1owZi9SaVc3V0tKTk9nVkE2ajZv?=
 =?utf-8?B?MnowSVEweHU2UXNWZzBNOHQ5U2VlMXRkWW50K29zUUlxU3kwMGViM1hKeThD?=
 =?utf-8?B?U2xqNXBYSFZPckxpbWRjU2ZQbS9UVk56Q3MxaGM5OWhjSEVZU3hHaVNuMno3?=
 =?utf-8?B?UmpQQ1JILzc1NUJ0NWs4dmFHTHFvdUlsV2J2eVNLNDZadXBUb1p4cEJpdXpn?=
 =?utf-8?B?TnFzYkY1U1l5cEZ0UXIwWW9WcVZKLytwNjJ6MldKdjNTSUQ0MjZ4MUovVCs1?=
 =?utf-8?B?Szd2ZDVHd0ltLzRyVnk0bEppdEEvUExaeDFJc1d6akNPSDNjVWF4a0VZd0gw?=
 =?utf-8?B?M0t1N2JWVzNhZHpNV2Q4TkJmck91M1NqZW9EY1RSeVQrZ3k4TUxOVCtUMElR?=
 =?utf-8?B?TGc0bkdkMDRqc0NZaHJKdXpla1hMWHl0a05vSjIvQTROR1N1cStyY1JRNTZ1?=
 =?utf-8?B?WHQwS0w3TWdjc3VVZ0Z5UXlJVHlnNWpobFlnNmtJZkR4Y0dJRlJwMkpoQkxB?=
 =?utf-8?B?N0E0aE93Y1FOQWI0UXdVbHRXTEZORkp3MHg0dWYxS044US8vVzhvMUhCamht?=
 =?utf-8?B?STZ3cnQzNzJsb2haR3N0cmZnSXM0b2JyZWlxSGdXS1ZGYTZsa1RvdFZFTDh6?=
 =?utf-8?B?ODArTEdidHYvYVpXbUU4M3ROZUxsaHo2aG15QzNLMkQrVlp1UkkyYWRBMTBi?=
 =?utf-8?B?RWNCcytBQ2dWM0M1cEJzc1FYdTZnOE56RktYMXFoa2dlN2x4ZXkxT0JaYk5X?=
 =?utf-8?B?Qmh5MzUvZTR6UzRZSlgxQnpTamtBblJsZHlzQVRDam9nMWZZWGVsOVMzZ25Y?=
 =?utf-8?B?ZmpvRjUxRnVDTnZPcmZTRlI2aHY0eENvam5FaHFYamdhZjVhdGNQUEduYU1y?=
 =?utf-8?B?eEdNcjlWdG9RcUpDV0RjWXJPSzJtcmxpOGRQU3R5T2tzUnBkaXZxSVZuR1RX?=
 =?utf-8?B?a1cwYXdxaWtkRGdpbXRHV0dHSzVUSTVocDJaMmdxWXNva0pEQzFtUU1TNmd2?=
 =?utf-8?B?SjlVWXRzODQyQnp4b3hIUzlYeTlPNGVOZmRYaFA1dnVlbnpBVFRJaHVWQ3Iz?=
 =?utf-8?B?b3c3bXUvNGFKNFVUb2VYKzR1WXlYOXQxN2tLT2c3TEdWaXZxRnQrN211NWN6?=
 =?utf-8?B?ZHBHeXdPYS83V1h2Yy9HcEpBK2IyV3dreldJU0pOV1hYamxXWW1WVlVIUE16?=
 =?utf-8?B?WFk2SE0xTzRnSnNGL1FhUUY5Z09JNXV4MFFFQ29GdUYvSkxBRXpyRWd0Rjkw?=
 =?utf-8?B?Rlhoemx2Rzc3THlieVVTTHlOcDRUVWVBRC9ZVDRkT1lWSGJFRHdpdEIrTkpy?=
 =?utf-8?B?TGRuL0JJM1hrL0pxNXFVYVIwN25OeHVwT3AydkdNbkMxVEpOZFlyRktiWTBO?=
 =?utf-8?B?NHQ0cWV6Vk1pK3ROSjAwWmZDOERXL29TZ1JydmRxcUNPUXZvQS9VMWEwb3BO?=
 =?utf-8?B?TlNkdnlsQTg5eUNrNHM2QnpzUGlIcmQvZTJNMTlOVE1XbUlrakZUdVBtUlUx?=
 =?utf-8?B?MUo1NjZyb2xaTStlTWxIb00weWl2ZStBYVhaQ1dHQnkxcERHMGdRY0hza3dq?=
 =?utf-8?B?NXJONnB0M3d3cjlJQ3V6Tngvb3FIYzZhU0hTaVFDb3pXMWNWSXdSTGhDZzZn?=
 =?utf-8?B?ZG5kd2lMNCswTGh5ZkhHemJ0R3pqa0F1YmM1eUxHbWJGc1Z0TnkvQjEvR05y?=
 =?utf-8?B?MitNdzVXY2c1S3REMklQRDRxNXNPMFdlZHB4NFBnZnpKQXZOU1pvQjdJR3Br?=
 =?utf-8?B?RURhaEY5UEdhWFlZU2laQTVWQ0xrM2d2elpXVllQUytWOXMxVzh6ekZIRmRX?=
 =?utf-8?B?ZjVyM2o4bzBjcGh0eHBVOWNaa0tCSVY3WnVYTHZHV1ZTL3oxRURZYkFEcStL?=
 =?utf-8?B?NDJHSUV4Q3VsbXlrMjU0V0hOUEVDeVI1c1lIbGl3RUxJM0JvdFdoVFZiRTNW?=
 =?utf-8?B?TlNWT040Q0U0V0MxY1l2RmpMeEZITkNZbzRJOTR4eGRQU2hRM2VIQ3IzS29D?=
 =?utf-8?B?RFhRSzhid0VVTStVQmlLRW5ZN2MyMzJqZDRVQ05JVFM1eFd2QVR5c29GSElR?=
 =?utf-8?B?N3ZST1dMOWdWU2pwdUNpaUVoSEJSQ1RTOHNxbHRIWWFoaCsyOS9yMFB3T3p0?=
 =?utf-8?B?S2dQNG9URVZnVE5TS1V4ZUtyWDhlbDRGVVY3RFlKTnpkbEZkQTRVTGY2enQy?=
 =?utf-8?B?M2krcldzNGtuMWVZcmJJWFNudy9EWkRiMm9VRVdBM1NWQnBpc081V3VROUp6?=
 =?utf-8?B?K3grd2RnczFuRU9SaDJEb0RmejMwbDYxWTE1ZHpVcldrZWFMMk9iZz09?=
X-Exchange-RoutingPolicyChecked:
	g2FMeW2pkPmAEPMoM8GN47CaWiD5trlupVNOgE0sGOmrAo9eJnacL2VFXwfDwPSvAV0I3Wb7iyxv1pez4+HwRbDYhuvVNsLhIa+dvoBqxkyXeEN+KkpfJtJy/9gaDO5vm+qhSVuO76WXq8SQaT8rOF7rpWTYCpgHxJ0FbL/Ip0SVeK4Mtj2/xGzj59/2SWz/MV3vNpZs8TqgZtazxu0VC5Sv/lG4g09I7ZS5gKSXBhjysn45BXXpINeR15gQfnf9nNsFzscP9UXCAk39sy2gHLBEzQN453uLoCtERcO4paDdBsMIm7v22dHmwn75CeUWwtN99WpoSAp8/xoMJzEyHA==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Wv6IISS79IpnRUTGO9RwghDjsv9ogT/xP11t6KaeULSWk50/X/keTyyt+c8O54BXWzFAQm97nwWBga55fDa75ilHDZ4n/n+5o4+bDZC91IUjqR8oH3Ywsh3q5Dhu6FV4U0K1Qb9nbuOIdyzWjWtwe5J1VW8p3pTC+jnBqvFlYlzlwqegP+5WOp418lOCZqfavUBfEPt13b4PBY0Ohws/dyBiaQwmcPOtDLKYmCleADbTYBXN8LPXBB5ZkTjHKVk/YvBSHXbTFsyw5mEsi/p/JhAiMyTSXx8AXOKkL+a02XmSaSjfKx8y8ie4AdtWfRqMLIb1DpbLjCt+b3u5BfsTRQa5XrIjTikp8sXVFRn76j83mSC9RfoDXLHOWUBv1g+Nuuu/F60TW3QmofDPJzibi/2yVX8JAd8KEe7yaMIHq0rk/tN5XrCDdkNXfkfutMp5ypaiwi3BrNdmm6WzM3VkwaUdnxar6VThXAFE8CNAEmYO83yJV1fbD3ELWPFi2wOcEQTmihtGXb35fh/MiXb8n9TMHEUBPKNjTA7iHQqs4iathjJ8slaHzPqfueMbDLE1j0zGo35xuaLCxUf1PsoPDjvmKHvJOEvAOhv1wZM4xug=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 450ec1f7-0418-4ee7-d0e6-08dea45bae29
X-MS-Exchange-CrossTenant-AuthSource: DS4PPFEAFA21C69.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2026 12:51:20.6857
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9rVcc/X88ZSgei51iZ/FffWeiCAjUQ0Udu1fldA5wAwX8oNjVvwHsLv4UVXefvv0I/GWD+rddG5mHYr1Cg6NZw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB8150
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-27_04,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 mlxscore=0 mlxlogscore=999 bulkscore=0 phishscore=0 lowpriorityscore=0
 malwarescore=0 adultscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2604200000 definitions=main-2604270136
X-Proofpoint-GUID: akhnO5VYT5am5esqoiVYlJgNSFNQlSrA
X-Proofpoint-ORIG-GUID: akhnO5VYT5am5esqoiVYlJgNSFNQlSrA
X-Authority-Analysis: v=2.4 cv=BePoFLt2 c=1 sm=1 tr=0 ts=69ef5bcf b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=A5OVakUREuEA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=jiCTI4zE5U7BLdzWsZGv:22 a=RD47p0oAkeU5bO7t-o6f:22 a=cIeEMxUo67tBHMr5TsAA:9
 a=QEXdDO2ut3YA:10 cc=ntf awl=host:12309
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI3MDEzNiBTYWx0ZWRfX15voGnLMC+0j
 AJNH7Acqgi8iHHb77F6nTEFpZ+60SPLlRRtVV4lJPXx3TrQrd3m01JUHp+1oi0gXFJM6kxLE6a9
 F2bry6lSO0+/TEnp9wioebcIrusWUYtZuy4pgGjtzjz3z8yDAw64xTOow5r3blZj0OpXVy8EBU5
 s5aSINIG9m+OsYA3Cl27MnSlhaZahEFqAuQo1FQlsQzMRso6MTKyH4Y+fd5ycUnb03z1HU2aUHB
 z90O20x+ncIYqy87kMmy0hvhG6pM22uISc975sKXvUJZg/fPD+FzT6NIZ+QOQQEjeasgsNfxufN
 ul7+5DBQS1K153dziB/Y/MgUYiEE5brXyKWhGccwBEsmuFl3IsdDe1VLDxZcTgNys/Ocim8Bx1+
 Bvho89pokuwHl9bWwLusXktt5VXe8QURxeHGrcldmnlBeMQGXEV5aOFBkQnDLkRuenXnxdptVR9
 yCg17VlQVL2kDf2SWVu1cjyA4S4D9sAWizV+TPW8=

On 27/04/2026 13:17, Daniel Wagner wrote:
> On Wed, Apr 15, 2026 at 10:41:11AM +0000, John Garry wrote:
>> +	# Part a: Prove that writes fail when no path returns. Any reads or
>> +	#	  writes are queued during the delayed removal period. If no
>> +	#	  paths return before the timer expires, then those IOs should
>> +	#	  fail.
>> +	#	  During the delayed removal period, ensure that the module
>> +	#	  refcnt is incremented, to prove that we cannot remove the
>> +	#	  driver during this period.
>> +	nvmedev=$(_find_nvme_dev "${def_subsysnqn}")
>> +	ns=$(_find_nvme_ns "${def_subsys_uuid}")
>> +	refcnt=$(_module_use_count nvme_core)
>> +	echo 10 > "/sys/block/"$ns"/delayed_removal_secs"
>> +	refcnt_orig=$(_module_use_count nvme_core)
>> +	_nvme_disconnect_ctrl "${nvmedev}"
>> +	sleep 1
> Is there a better alternative to sleep for these tests? I'm worried
> about reliability and the extra runtime added by idling.

I suppose that I could check sysfs to ensure that the controller has 
disappeared (instead of the sleep) for the disconnect. And similar idea 
for reconnect.

However some of what we want to test is still based on timing - for 
example, if we set delayed removal timeout to X seconds, we want to 
ensure that the gendisk is gone after X seconds. So we need the X second 
delay. Currently X is 10, but can shorten that.

sound ok?



