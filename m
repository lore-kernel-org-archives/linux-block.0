Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31DA72ECEB7
	for <linux-block@vger.kernel.org>; Fri, 11 Jul 2025 17:19:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752254377; cv=fail; b=bsUO2TaTm9ivuK8EOuZmMuDpwbKazRvugXDMl72u/1RXyPq6LX6GAVPO7BP55a5w52yOn4Nm93z9Na2eXNPWyXiJVRm2OY6hpxome5sGNsSpobL9m4EEoInh0hHFymJdc76iQREf9IrAHyfvxNYOCuIcJCkSJFiy0jbdeuFsgJ4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752254377; c=relaxed/simple;
	bh=kTzQGSql/ISCBbC54itSl5kDXxal0kV41WXa0dbyrlA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ZbnbbheYvcC0SiOeUjYkKmTjcnVegn9pWzv/LpRMtBvF4BIoEIDEtsCcejI4eUFCMck81MAQpJNnn26qWbzUl07l3iWv26BsmlulTq0FDkyg0r8E6zOOdNB/dUmEdD/CP2rFlzu4zDISk8dMojUcBc3p6zmjZINmQK8ppA3EGAU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=CXkMufO/; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=xDjM5TLF; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="CXkMufO/";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="xDjM5TLF"
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56BH2MXv001820;
	Fri, 11 Jul 2025 17:19:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=1Qg7z4QwPAgKakhEBMeiDQMEnXEEHKcvFjSb1FBp0jI=; b=
	CXkMufO/V3OeFmRi7ePrI7d/wRM44y7324goxqjMwwk+645g7mlaoPiRw9xym8+1
	nWqshkLQw8wD6HDTx3oLf3SwfooHtGtgvGdo8tBHIfOaQdcEguSH7eEfFxQ8nGh+
	/AxsNP+AwrkJcQArljbpAab+xFloKwX7ZFgHDpZV3ojua9CfWe6NGqvODld8HD+G
	9lHDCxOAdj00bA5+CggmT8Swoz01aWazwmrzo+H7mhC5zpk/YV4TfJewQK1ezxTU
	wcvkhDiX6zJD5KbofFeorQJD/+YL5tyxw8eLkJl8YcKcCktZck3Z7ZqrsNg8Q185
	BRQge71UFSwb80MLk0dazQ==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47u6nc0109-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 11 Jul 2025 17:19:29 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 56BGhHV4021566;
	Fri, 11 Jul 2025 17:19:28 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11on2073.outbound.protection.outlook.com [40.107.223.73])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 47ptgdt19e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 11 Jul 2025 17:19:28 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=L923/CdVhrspWoHszfAs7fWbn4LuZrkarvI+iYnSA/r4Ky25ilM+cc+irNpRMlUYKUnd3uHoleiMg1QeI3byla0su/JfUbezOVV+2x3Dwnfhce6iMOEd1+yYZhRAWD5ZWo0FVoKUyJJVjA+xeVsd50OZ1qmG7iox7LuF5v5ft6dKxt2aPRv1hNyUWofvGH0y5/qzIxfL3EctX4eDv4XTya7owmiR17swwOv1M3tPkMm9V05YKD44hN8eLA9Z441dHp0mf+Sp4WLFKwW0nXHjHMphFvnoJnJETmSNs4DyuAHwPfDNDcM5HCGNiBGlb/nVQ6U3MocG3z8GhSwR+ef7wg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1Qg7z4QwPAgKakhEBMeiDQMEnXEEHKcvFjSb1FBp0jI=;
 b=UwE6V/nA8w1vUQLJjxEtlIUeQUIqjbmyVwwGz//8mVA4njdx3xEBRCf9bih0RXit6wLxMLZjchLv3S1C4ee6JYFB04Ov0vSqyQYGyqf6TQPT5tYkRCnrRUl8vmLU1pKFy5fW+ADLoN2EALTWHQZLpuUrOJe8HUpp9gZquqcATjrbsbCQntQn7Lyi7MkaAfHKYA2k1T3qW6+UB7Q11EMskmacHHY+GFPjK3FMdUjQYR901H7yswYpbE21GDKoVshvbsbLLHWB5YAgLJSyQGXxrf9Xr3jdHuo+quHW58auHUMmJ8kn/8qz7jDhvbKpMyt/hZmJL1vWyIZ8WWvXGyge9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1Qg7z4QwPAgKakhEBMeiDQMEnXEEHKcvFjSb1FBp0jI=;
 b=xDjM5TLFsldyG9S4R7zZbV09E3KyT4SsUmvjz4xMnR/e5ge2JO0GAiwFglsSkUYIuB82mKnkIjcs39SkQ+BG6cO5GrNVnmhsoB3PjipjYV/nzy9PFuYGY9ygOHevkHUlqgzZWa8+0cKfSdzRNYkpCZfDJyVH0dRHXEqjq8HuVWM=
Received: from SJ0PR10MB5550.namprd10.prod.outlook.com (2603:10b6:a03:3d3::5)
 by IA4PR10MB8636.namprd10.prod.outlook.com (2603:10b6:208:568::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.26; Fri, 11 Jul
 2025 17:19:25 +0000
Received: from SJ0PR10MB5550.namprd10.prod.outlook.com
 ([fe80::10a5:f5f4:a06d:ecdf]) by SJ0PR10MB5550.namprd10.prod.outlook.com
 ([fe80::10a5:f5f4:a06d:ecdf%6]) with mapi id 15.20.8901.030; Fri, 11 Jul 2025
 17:19:25 +0000
Message-ID: <74592189-697d-44d7-a29c-bd6b246bc2b0@oracle.com>
Date: Fri, 11 Jul 2025 10:19:24 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH blktests v4] md/002: add atomic write tests for md/stacked
 devices
To: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
        linux-block@vger.kernel.org
Cc: John Garry <john.g.garry@oracle.com>
References: <20250711095734.159020-1-shinichiro.kawasaki@wdc.com>
Content-Language: en-US
From: alan.adamson@oracle.com
In-Reply-To: <20250711095734.159020-1-shinichiro.kawasaki@wdc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY5PR04CA0024.namprd04.prod.outlook.com
 (2603:10b6:a03:1d0::34) To SJ0PR10MB5550.namprd10.prod.outlook.com
 (2603:10b6:a03:3d3::5)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5550:EE_|IA4PR10MB8636:EE_
X-MS-Office365-Filtering-Correlation-Id: 90fb64a0-c573-4a03-3c72-08ddc09f15b3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NUtTbDhVU0tHU2R3WDZaZlJsN28xSm14YW13ZHBuaG14Uy80N1BkQTQ3ajBq?=
 =?utf-8?B?V2hlSFpnTjJ0Nyt5SnNHMlgvNmx2RzZGMERNRm9YK2VlSjF1TXBPUHBQb0k1?=
 =?utf-8?B?cnVSUHV5Wm5tT2hCMVZEMldxb2JDWUZ0Q1M4S3JlYjNyTEh2djZvVUhDdmFC?=
 =?utf-8?B?Qlg1cERrb1RhTkNPYmNVMjRhRkp6SjVWQ2QzU04yZE1JcUc4bDVvVzNtL3Zy?=
 =?utf-8?B?TnF4OCtwQStDaFZ3eWJZaVhKZzltd2RFdjJuZEhubWt1SFpBbWhSTXNtSmVL?=
 =?utf-8?B?a3k5Q1c2WEdNTWxJMEVpS0x1SnJQMDlwU3JjRFlHbkJTZ3UyNlJBQ2d4V0cy?=
 =?utf-8?B?d2xpa3BzUGRpYlk5anppZFZTbEpXTWhMRWhCYW1PZEQyRzcxSFMyUTYxUHFS?=
 =?utf-8?B?bkFSYVlXWTljMnZMV0dYQ1RFaWFZbXhOYWVMQW1MSDhHV2hoRU9rNExwa0Jr?=
 =?utf-8?B?a2RvblNsT0pxcDk5eWs4cnFoTTJlZjFzNUZ1U1UwNFhrZ2x4Z1pqdmZJdUpl?=
 =?utf-8?B?UzF3dUdBdCtwV0pERjVEdEIzS0xibGxOYUpxbndmaURzd3V5ZVA3b0tJcnhm?=
 =?utf-8?B?V3ZoMEJRd3dnT2JKWUJaallnaTJuWlFBTk0ybEF1d1BWdnczc1laeXc0eXBh?=
 =?utf-8?B?OXBVaGNhNHpvWHR4a0JFN3BXaktBY1ppWHl6eFQ1Q24xWWJyYWJZVmVWYW04?=
 =?utf-8?B?dGFNbjNhYmZBRWpnMnFJaVdOWGN1QVQ2emtId3A0RDMrWmdaL0UwQ3Y3Nmxh?=
 =?utf-8?B?K09nNWFXSlVaa0txcU1RcHdWUGhaeHBnbWFvbjlFU1hZWVRLZklGUUc3dVlW?=
 =?utf-8?B?MGYrRWh0MG9udTl0WjJtMTJoam03UDRxZytneDlZeEpITG16RkVYNkxLN0J2?=
 =?utf-8?B?U1U4WTYzWERvUnZtdjVJR2JzbmpRd1JFSEZnR1NZak9qUVVOVjFLNTk3YXJL?=
 =?utf-8?B?a2NkYjZvd0NEekRKbTA2QzFzanBnTy9VQU5tMDB0amVvYjVPNUZXUFJ2Zjhj?=
 =?utf-8?B?cDRTMXlTZllpTGRiUngrNE9FZXNxSUgvSlA3ZFlUWHF4cTd1aHk0bkJLT0ZI?=
 =?utf-8?B?eUFZRHkzMjZjQWZQams4U0tjTUx4VEF6UStieGRqWCtMMlRmd2JVRVFUc3R5?=
 =?utf-8?B?cFl4cFZiNUhhNlAvWkpiRHJoRVlZZTlPdVQxT0lHNTJONFViUC9Sd3EvM2Yy?=
 =?utf-8?B?Y1NvMUgzTWJwYlBpNStnYXo0MDAwNm9kN2VqSzlQN3h2c0grVEN5Tytpakdn?=
 =?utf-8?B?VTE0YmoxanNYTnEzWmpXWThwamNsaHZnWWZqa1R3cS84MlZuYVVvMGw5OHpP?=
 =?utf-8?B?MkpWY2FpVjBoQlJmMUMzMUFkVmRTV0djUWlPMVdyRXhQV0RSYlVuMVNTa3hI?=
 =?utf-8?B?dFMzSnBCVWNvUGc3L3B4Q29MQ3lIYVo5OXIxT1poUzRiOFpBanB5NGdSelEr?=
 =?utf-8?B?QktTOHpTa1BLbTFkN2FhV3FmRXhzU2FVYll4UXp3dys4ZlljWGg3SVovV0Q2?=
 =?utf-8?B?TEpXZ2wrTWRmT0M0QXdPWkVjREE0aCtjNHlRa1dXaUhXR2hnNFBrM3d5T0N2?=
 =?utf-8?B?UzB4bWtIOFhNcTlDcWxCWjVleHRvZEN2OEJUQ2NiZTFva2F1ZFNJYTFqNy9H?=
 =?utf-8?B?UHVERWZwQnZrZEE5ZDI0OVlCM05zc3p1SnRwdGdPa3JNU09pamtTUWtzZ2c3?=
 =?utf-8?B?QkRpbHR2MlQxbUdVVGdSdXJiV0M3blJrWjR3UmgzUE9jbjMyb3FtZ0g4T1gv?=
 =?utf-8?B?ZlhLQWMyZEpwNzVqTGsvMXROejA1UW16R0kvVUtxckhtbEtPK2tuSC9Nb0l2?=
 =?utf-8?B?SjBQSi9oelljYXhGeG5wY3diWGdhckdJZFVUZ0hKMU14VnQyc0k5RFlvZWds?=
 =?utf-8?B?T0FDMHpFN2dzWXl2M3NmZ1FiYm5Wd0JwMldRREZuUW44Y0Y2RDd1SE8rZ285?=
 =?utf-8?Q?G+n/JHfPOOM=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB5550.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?T1RWSjlJd0RMUzdPRWFyRS8zcCtlV004NnYwVEtHUEZOMFRPREo5NjZrNlNj?=
 =?utf-8?B?TTJCNzkzbjFSL2FOZEdXQ2g1Y3dOVzdnTXozUzlRUjd5QzVncyttMUNNWkli?=
 =?utf-8?B?K3BhS3g5S3dDQWNtSjZhL1JESTlod0Q2ZnJVTlJZZXBNOTZ3V3lZdHFWc3J0?=
 =?utf-8?B?VW5sb1pIbjVUaWphWVJETzRlMEM2Tyt3QmJOR0Y3OHdTN1FHei9OVXgzL1ZC?=
 =?utf-8?B?SlZ2R05Ud3JwZzVYUEdOQ2xwZFNoVk81dzFFbGpFR1RxWkJIdlMyQndiVld4?=
 =?utf-8?B?Q1NleERVRG9xSzFvUi9RY2N1WUFva3hhc1ZXLy9zWHhubndXS3c1aEhrNVE0?=
 =?utf-8?B?RVVJTUlVNENjd3EwWUZiVCtZRXdxK0xzd2h1UUIzY08xY1l1Rkh1OERLaVB2?=
 =?utf-8?B?UnJ2MVhCelNiL3VwdW9wd00zUjNFcmNZN2E2QWxzTHBaUkFvSXFDOCtFSTdv?=
 =?utf-8?B?TGppTTZHYTdPUGdrdlhVU2oyVFJpM2RXTzUvK2x2RUhMK3pZWFFOaTdjY0g5?=
 =?utf-8?B?RGhVQUE1OERVNGNUSUxOUHRMSURCNkU2ZGt0OXRXOUYrM1ozOTluTit1c3Bo?=
 =?utf-8?B?b2NJSnduRHo2R1gwOW9qYTBSOGxFL0ZRWmxsZTdUeFBvaG5NeVJESWw0TThQ?=
 =?utf-8?B?R0lZQlNlNnpZRUtDR2dyM0tIcDdJa21JdlpFaTFQbm1CTHBKS2pBUEF2SGxM?=
 =?utf-8?B?ckY5aDdVbzFpdVRFOU9Ed3NKVmNEc1UyOXoxQlRmcXc0WlZleVd2TWwxSStS?=
 =?utf-8?B?cjZRZEhtbW1lYS94RzRrVUl3THZ0Y1lId1RWZGkzRVZubjQwakZob215NjRI?=
 =?utf-8?B?dUJXQ2RXT1llSUF2Q1FHcm1VR0VkVjBiQ2JvRFhTY3ZQb0lpYzc2TUNoYjE1?=
 =?utf-8?B?YTdFMkJUTEhjV3NWUGFOTVY1dlNmMHhNL1phRS9pR01YL0pvR3h0K3d2T0Fl?=
 =?utf-8?B?NmRWaENNSUV3eHh5akNLbzRwVjE2QUpzUlBTZDlLSnhBUllPdk5kYWFuWGM4?=
 =?utf-8?B?bUJybjJTVGhZbG9RcEdxMWV6dmlFRHZjTURoMjFLUHZnRFFPNkFaNWoxWDM4?=
 =?utf-8?B?MkxDbHExWVFpUGkxdUd4clpJNFF6MEp6S3pCM0pVQ0hKVHdWNjdkWExmTTl4?=
 =?utf-8?B?aUZDOWhTOVkxS202dmU1dU9SWUtXb3NJaTVsczhjUnptbVp3endQL2lFL1gy?=
 =?utf-8?B?aWt3OXI0ZFVWZU9rVlkyNVR2QUZqNStWcnVMS01Jdy9VY2NMNFUrWm5oQzJ1?=
 =?utf-8?B?ZTNZMDZoWWF6ZjBUNDVWSUNVbnpvNmIvVjZLanA3ZU1tZ0VIZG9aaXloOVJK?=
 =?utf-8?B?b0Z3ZStRZUpEVE5NUENPU3ZUcWpQMm5aUGp1T1BDMUNsbzNqdE5ScXQyQ0Yy?=
 =?utf-8?B?cEV5c3kvVXdvV0ExQkRPVDFZSjhpd1hWejNSdDhRWkJXUmhEbFZvZHZxWXRD?=
 =?utf-8?B?OUM2RXdOWTlEazZOUGlyZHA5ejRwSTh1MUhRUW9xbmFuY1lNZU81QWd2SXV2?=
 =?utf-8?B?ZjFjTENkb0RxWlpvL3ZnTjZuZ3FOb2xHdjNVYjJKU3dHa1NUQjV1MGo0ZmxW?=
 =?utf-8?B?TWNyV0x4VVpXUGgreWZSS3Z5NXRZY2ZOenpaMHVIMTQySjJSQjFuemRBbmgv?=
 =?utf-8?B?ZzVsWkNQSGxDZEpqRjVSc2lmZnFKZU94a05tK1lWNDJCNmxDVDRYZ0JaQ1RI?=
 =?utf-8?B?dG1jTHZYaTNGMUxjYnJ6bmFRT1N3NG5VOU44dmJFV1pNcHhmTmRwV2lUOEE2?=
 =?utf-8?B?eFZXME9HQy9FTVhmaXlYTkNvOXdpRkdKRHIzcW43cDA2VlB4dy85NkJsSDZs?=
 =?utf-8?B?a1lhU21RUzdYVk85WHZ2WkkwRG9reUNZOEcwcUpNL3RDOEZQU2Z3c08wL0tO?=
 =?utf-8?B?bmhZNkgxTEpDd1hhcHlwSlhCMWVsdEkvVnVLMXVkbHdna0lSaVFEaGsxeFNO?=
 =?utf-8?B?Qm85UWM4bUgyV045SGJRT1FOdXJKVjZJWm9FZXQzZGpOODRaVmFBRC9OSWd2?=
 =?utf-8?B?TnJjM1RPNk10QVBkWlZjV2JPZ1loZGhibVljMTBiK042elNhMlFtYmhRcjVZ?=
 =?utf-8?B?VEpvOCs0SWdWYXhzams5Q0NhTU1UcThNazN5ZDRsaTRBNVBEMjNyRUExSmVJ?=
 =?utf-8?B?UEtKYVZSWEdWY0R0ZWFmRHhqVkpTRTlESGIrcFFhdTZFZ0k2dDVsdXJMdGFi?=
 =?utf-8?B?Umc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	KjvlIXPNFvZ5B755gNG/RhUCWhE0vI8O7J00TB/co6vC7mGKZqEmk7HDyvdXSTb4JWxSMd2K3z60tbJ2v96hs0x/0ojLOq4eEfcDa+sdf1yPb1pUJRx36KKoqcJ5wJTF9VViID5n970q889WgMyiwl8z2G0ht77SJI+AMCZG5wYOwqPm88EE0Lp3jWHOU5YFkIYs+RfqS3ClINHw68mbt0MWSGKAz+m3CNXkq+KjTY3hC50LmucNpNXFg/e5aLrcGT419D0IP5JUH5C6kGwU6p/Q97IV9e8V/yPVIkwutMOYg393iDHbxv0MM5wOuCJMU0RBAZcSXhxoFTfd+o9O3UMMhiI97jJ2xsrmFvMyZ7MaSKUe3tGZURf5nYK5lMqA/GYc5ybukX5cT87KtCF5duJuQCIci/zBpY2+5+Is3r9mPspAdennTkdRnvapHW/KunidehEIuXiwZwcIdhG0d9coCGY9vwbIz5dzkx2YQX27wJLQRP0Y+XpCyK2yPZ/wk1k24Kp/2d1dzpTRvDjPf1TFNyNLuzQ7OfMlccIRULp5a4ybZvz7AWdXm6vtWxv9MqEH/eCbXnT7KGqHiQhb5VbiCY2OqwmLLRj+65lSri4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 90fb64a0-c573-4a03-3c72-08ddc09f15b3
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB5550.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2025 17:19:25.4588
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: x+BLtBxFZTNPBOUPtKhHPKSftqJAqKvx0loQ42D1qTcfMhJEtMJI9REFMLvhMOE49f/6X95xzIV16iejBbL/bQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA4PR10MB8636
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-11_04,2025-07-09_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0 suspectscore=0
 mlxlogscore=999 phishscore=0 malwarescore=0 mlxscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2507110127
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzExMDEyNyBTYWx0ZWRfX0I4S7pQ3kKSA vuz7pvwrpg6FEGfAdTS9mRLV6r7rUxLugIK3Wy2uRP1NQw8tlHm0qjMuHLm77ZSrWTyoSg7E7hx MmOvcKZuK4LX8xhOckffZ+9NHN3GSwW924VO0YZaNGtVD/CMwBw8WQDnz0E081hSx0SDYevzUOy
 F2V4Z2uYbPEl4sPz/WAZxgv9ZuddWkoV3xhVWjgPEJySwtPNuX+xbO6vQbk16XEXSEidtCtXl6h MFpT8YGIkzt/JQgHg7P0AT6uEkiNXs0qefHPiIKQ6O2lTFSe3Ac8KJ3bF4ViF43zL69wzZrBaTC a0Zs6ebhsL4AY2KqqYCY3B/DTXOz0cKS8W5CCZmf0HoLNU+tamyCKzaE/PYuacs9q1ORqy3hQ/n
 xFK2qNnT5BK/exvOU4wiqzFKuWHHqf7kfcWzW8iEAF6V0Ob0gtG80xA8HFsM5pmDFSKlIqqp
X-Authority-Analysis: v=2.4 cv=HKvDFptv c=1 sm=1 tr=0 ts=687147a1 cx=c_pps a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=JF9118EUAAAA:8 a=ah1HNImnR6Lqo_ZChQUA:9 a=QEXdDO2ut3YA:10 a=xVlTc564ipvMDusKsbsT:22
X-Proofpoint-GUID: gefpjwmfpsj7XRVC_LPH3UjdAnqHQwbp
X-Proofpoint-ORIG-GUID: gefpjwmfpsj7XRVC_LPH3UjdAnqHQwbp


On 7/11/25 2:57 AM, Shin'ichiro Kawasaki wrote:
> From: Alan Adamson <alan.adamson@oracle.com>
>
> Add a new test (md/002) to verify atomic write support for MD devices
> (RAID 0, 1, and 10) stacked on top of SCSI devices using scsi_debug with
> atomic write emulation enabled.
>
> This test validates that atomic write sysfs attributes are correctly
> propagated through MD layers, and that pwritev2() with RWF_ATOMIC
> behaves as expected on these devices.
>
> Specifically, the test checks:
>      - That atomic write attributes in /sys/block/.../queue are consistent
>        between MD and underlying SCSI devices
>      - That atomic write limits are respected in user-space via xfs_io
>      - That statx reports accurate atomic_write_unit_{min,max} values
>      - That invalid writes (too small or too large) fail as expected
>      - That chunk size affects max atomic write limits (for RAID 0/10)
>
> Signed-off-by: Alan Adamson <alan.adamson@oracle.com>
> Reviewed-by: John Garry <john.g.garry@oracle.com>
> Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
> ---

Looks good.

Alan

