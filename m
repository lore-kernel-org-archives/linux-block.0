Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 233D16D1CC
	for <linux-block@vger.kernel.org>; Tue, 30 Jan 2024 11:46:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706615216; cv=fail; b=Y+ukO2VCn6Lo3q7Z3Pt6Rdr3nQEwVDf+SshLLYL/JFA6U7En79fnd1VLyiyTS6Mp1JGLWS7K2Dh3m+YnMhph1/wmakhBsb4y/LufzuAXYQZ/7rGK8zq3/p8Z6UBTRtKlUikJkSSDCenmp3j6e/GxFRCUXssRRaLtApuwHsJyymg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706615216; c=relaxed/simple;
	bh=s5RQo99krMatgzcmVbMrVoUMVEIp3967JqBY24aO1Sc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=K/JlHZMw0zz0pH6CrU6o0Z1GxJ+4aIGS4iXqtWtBNkCe9EJVcP989wZQNgg0Mhw2Xd5P8OgN9toyXvi+tPlfW/bPlcHAo8ClbbQWFkOopkCPwmRBDar+zUOvGiB1Lbr0wkiDQDMB89x7piuXYyaw86owopxARShwwGavNX64bvk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=FZy/N1E7; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=wBvv1lvs; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="FZy/N1E7";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="wBvv1lvs"
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 40U949Df001214;
	Tue, 30 Jan 2024 11:46:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=BNthg1NwDn1WxHTe5TI0V0FnMo0dWCftElbulcc8c/Y=;
 b=FZy/N1E7eTq71ZcZl9RZGlNlfTjGph2znWp8dMho3iDuI1CRwrgB8W9pWrzxeiOdiZdC
 sHoUc2ekecDhPlcx6A68P2ugSiDs9d2lP8P1fKCWsa3S68d0KiuCrrmr+iOX0xZ0FgFR
 EMfGkfZYfgyRn51GIhso+zhGaVCwY3zuxwg7wuKyPY5He26RKAAWYY61UqZ3JfzP5j6n
 ChegEQ3LOsGeOwMvhFgnV+/d1dCf3GTPhlN4cSipz4Bt0uNeETAvg0ngZeXDYnu2whE+
 /UD5Vp0gu0hs0ouKfmEt6p7xX1VR+9fmZmphH7lrpf1uowiCQPODjwho2rjQvrbAuQO6 5g== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3vvrm3xhh0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 30 Jan 2024 11:46:31 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 40UBKI6Z040137;
	Tue, 30 Jan 2024 11:46:30 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2041.outbound.protection.outlook.com [104.47.56.41])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3vvr976qn8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 30 Jan 2024 11:46:30 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IKBa9XVkQ3tr/lvHzn2aTm4xQnOXeGGeFlY9OavkWppp4hQuMaaLAoKzunntakrIcKsc+1TRZk9YA5GMeF1IedPxp9HXZZrsI6doJODZdbdVzmJQyu78uruXtrvNJ5N48ZOcT433R8pSyG9qLYU30dy3wDtYiEKRPBlZcH6BaAy0Lp5mHCps0C+zEPFL7DS0kt8H+Pg2sAyiEZai+JVNzMIq81G5LXFG6wGYya756GP5xOeJMrrC6xhwGw0rNHYauLwtE8KqfUceDkqiFnevQOrKTDyOTgNdfR3NHi5k3ZWORZEYtfThYsCubwahAcUTVxZP4s2/ZaY5z6lxup3u6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BNthg1NwDn1WxHTe5TI0V0FnMo0dWCftElbulcc8c/Y=;
 b=hNtM1Uld1oLMUG9QUgx5GSQhOM0qwJg2DATr9/+0PkTQtYn0xpIH3Zff0ECo7suX5lgSTEQOOAV9cFzozyuhdOMJbcYrAHNTD67imA0sZMV+lLL/KNtsDMpT8X3rXaYFYdIMxfhAPKb/mfUw9UtoI01T1DXhpO57VCfraVDRJZU1tUsI5wAJhOPl2gqF3VIlL63YaL5mwGCfEWML2ebXsFY2SkR19g/DXA9hjYW/4wlGwSFv9V8qVHJRmGD2qwboQEAdWb4aaXpPaNGju+o//xmgs1bhfxdR0ygvOq/cwSgmRfLnicuJmpq+6dz7vkkpo/RiX7Sa02kItNGRg08SmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BNthg1NwDn1WxHTe5TI0V0FnMo0dWCftElbulcc8c/Y=;
 b=wBvv1lvsc/k0JxmQKvnlTfLeOAyGjvI5PCxru1P2uHL+zoe0gDjJVdtgjV/cB8mLoP/Uft+to10X0VwcIgOp/K/CPdEl9MtbylJNTOWEx8nH9Hb/8o9cG8Q9z9RU2Ft4O0/+V78x0ogjAHfjuwtII3JfECE9Syysy/WKcsA+cdo=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by DS0PR10MB6775.namprd10.prod.outlook.com (2603:10b6:8:13f::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.22; Tue, 30 Jan
 2024 11:46:28 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::f11:7303:66e7:286c]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::f11:7303:66e7:286c%5]) with mapi id 15.20.7228.029; Tue, 30 Jan 2024
 11:46:28 +0000
Message-ID: <c489e14c-aea7-4d76-88cd-f60026477c68@oracle.com>
Date: Tue, 30 Jan 2024 11:46:24 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/14] block: add an API to atomically update queue limits
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
        Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Damien Le Moal <dlemoal@kernel.org>, Keith Busch <kbusch@kernel.org>,
        Sagi Grimberg <sagi@grimberg.me>, linux-block@vger.kernel.org,
        linux-nvme@lists.infradead.org, virtualization@lists.linux.dev
References: <20240128165813.3213508-1-hch@lst.de>
 <20240128165813.3213508-4-hch@lst.de>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20240128165813.3213508-4-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P265CA0185.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:311::14) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|DS0PR10MB6775:EE_
X-MS-Office365-Filtering-Correlation-Id: 9572e5ff-37a6-4c0b-1f7c-08dc21891873
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	1Q3jUontRV/bjmuDMhGAqqhqpvp8u9DVaBTYq3tKM1ofFjE59OH51qh63vxqdLlgNXiF8lz2EQmXUmPJn68YS/IkX6/WMK342jr/230SvRobyzssD4S0Zm/KPvlUes2uqQ8JtLWcssSXyD92Mvmz8D5BxpcJKK48/a+l29a9qaWLQ6Ysi8JzONzOIi4yG9wj7ze6SPnaeAbMKfKT5UNVqnBqOCz3wM0dNGm1xATfgwh9AoE/nhP0I54huzLuG/PcT9MekiI6z/gMzN2hKqlNou75LcsGEVRANQZ6CWJoFuiwb6QSlm71eU+JMFqngoaAupzS41DwP3FYcVXfjohBkBkaiZP8d4QqycBm1dins+EaHo/bXRIcextjT1pyeUyAcXfPhE6OzdIlQzhpR81rYAEw+gT3qFEUWbJiZ2QlLVaLpKPlhmTnD0BrCfOlwHuOd3nTyI4/kGItpXwHRktCAlTv7HUhTYesee20mLby4SxleC13Xa7qLktiSOzOPnny3hmrx3pXTChPV5yk5n0PmtKAtwaW5PZQtHvzg4mrNX6nzwWXKH7cHTXlML3O3NQvw2UKk4dwuiYnb0wHgd3us2DZtn1GXz4v7th05uhW3/wietQKr20hqpwysSIkhn4I0Zuj1yVzOW26dfIMssSvXw==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(366004)(396003)(346002)(39860400002)(136003)(230922051799003)(64100799003)(451199024)(1800799012)(186009)(31686004)(83380400001)(2616005)(86362001)(36756003)(31696002)(4326008)(26005)(38100700002)(6512007)(5660300002)(41300700001)(36916002)(2906002)(6486002)(6506007)(6666004)(66946007)(316002)(478600001)(8936002)(66556008)(54906003)(66476007)(53546011)(15650500001)(110136005)(8676002)(7416002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?OU1HakNyVFR2dlBhTVdwUkdXT01BZE5OWE5uOWVXUHl1YUtKc0U4dytJNkRY?=
 =?utf-8?B?NmRzRjRZYlVrcnlBMHcxU3MwY0k2YmdYc0pLKzQ5YkNnV3dnK016UGd4eUxU?=
 =?utf-8?B?RW8xZXRpVXhwS1NFUkF6VHl6VXZwRUt4Vm5wTG0yVFBRU1Q5cngxVkdIL0Mx?=
 =?utf-8?B?QkNVc1Q5elJDMzEyUWNUb3dGWmVZb0hmMXdEWmdMdS9aSS85Z3B1VTZ4Q3FU?=
 =?utf-8?B?TUVTT0xTVTFXUEYyOXhIMWpNMEhRN1BhTURXb3VLVDJmWjVUOUp6bnFwM1Z6?=
 =?utf-8?B?M2psSG1TQmR3MEJ3cHp6U21XTmhtcHM2Vmo4M3VYdDJtbzlDZlZCN2lVUHJK?=
 =?utf-8?B?MkdKUkJBQk5OUWJFdEl0WDNkR0ZLaXRDUWc1YUVJUUZWSTRLeThldmYwZmhV?=
 =?utf-8?B?emNJbFl1RmJwQVVINVFzMzAyL2k0c2xYZ2FJNGFLaTUyRSs5Ukg0amJLRlVB?=
 =?utf-8?B?VExoT3pDVFZSakl4UHZ2RkQ3c0tEcy9WdTFwbGkrWksxNFVWVjhQQ3hhTW9n?=
 =?utf-8?B?Y2MrRUVsOW8vOUcxTUlEOExHNXhwUC9lcFZTZ1gzZVBSWGJsTmRTVFFYQUxX?=
 =?utf-8?B?ckJaeklYQjV3dThEbUI5dkJqOGZJNVpRaHdHVG43ZHkxLzd1bXFLWFY2aWtY?=
 =?utf-8?B?clgzSndqMVF1dnNQczhTMkJ4eGhJNHFWS1VQWVhoa3E1VlZ6UVRTMlNlV0Y3?=
 =?utf-8?B?aXMzV2V3ekpsV0NodkNvLzQxMjUxdVJHRTUydmpiUm9MamRtV0I4eUcxa09u?=
 =?utf-8?B?YXN6dVRkSnN5dThkNUkzTU9uK3hQdEwwY1NmT1ZBVldadGpIWGI1MTFTQXZK?=
 =?utf-8?B?VUN1bHRvTXRxZUV6MlZzd2xyQVo1T3pkc0tUU01TZmJPS3ZOTGJueUgrUXl3?=
 =?utf-8?B?M0tOV24wSi9ZZGhjQ001MDJsZHJObWpJQXFvRkNGbFNKR3FrZ1AyMXNtbkVR?=
 =?utf-8?B?U1AyZUdySUgrbnU4QysvRjZvYWhWdVNoa2k3eEloUDZjTE5hekdyK1BsTlVp?=
 =?utf-8?B?R0llc1ZWNnRja1hsRWxNTWxyV1RRTWVsbys4R2hTeElwMmR6QnlhSERYWWF1?=
 =?utf-8?B?RnlabWdmNVBZQUIwRmRiOUs2cFNSaVdnYkZpbnRvUm5RYXFyQThtajkrcjdm?=
 =?utf-8?B?YytIUUFJbGxYM1ZLQVQrdmJDSlJGbGdxcy9uRUZmaGdhalNKc2NkdUpVNmlH?=
 =?utf-8?B?ekFmVUtNM0F0YXl0N2pZM1pUYXBaQnJ1djB3bTE2RjN6TTZzeTRXR3hGTkh4?=
 =?utf-8?B?UGtUd3lQelhJU0VjVGRTZFpBckJlVG9OaUYxaEtZSXBmOFo2R05HVG5XTGsy?=
 =?utf-8?B?eEtRQ3dUeW83eGZTNjVVbjhJNzZrNFc2RkoxNHpycG9uV0RCODdlcjkwQ0Qy?=
 =?utf-8?B?SDhLbVFwTEpiT2d5Tk9CUUNHRVdkSTY5RzhVTlZFYkV2aCtsbDRoSGVuWDVE?=
 =?utf-8?B?blVXMHNDTnpyUEJBSzBOVzJKZHdWRGpja1hldGFRUTZOa0d6N3JnSjE1SDlj?=
 =?utf-8?B?VndVRDM5WkNXdW1nNWZ0WGljejBVOEdOZGFrRHExbFM4eU5JeFVjN0JDa0N0?=
 =?utf-8?B?dFF5Z3BKZDFCVTlodWVtaVEzSDk5NnN3NkhOc1pPVEV4YXg1d3NTNy9tK0Vq?=
 =?utf-8?B?ZU8xTXROSXlpT0VuTzFsRVloamlXend3bXlWdll6Szd3OWd1cUVEYk1KOWMv?=
 =?utf-8?B?WXptNnBCMzlJRVoyWnVmNEpaNHQ5b01NSDBCVXBSVGpYY2J1SjFIcmoyWG5R?=
 =?utf-8?B?YjJlcHJGVFF4NVBReENxSW9leTFDbGdkcU42SHdaRFhzYzZ0d0NPenJpdGEz?=
 =?utf-8?B?dHpiNnJwcVk0UHk2YU9EVGh1MTRTeHc4SWZmb1JlTG5WVk1GYjVPeHZXZlBl?=
 =?utf-8?B?Vk5kRjZCV3c3bGpVVE53Z2IwQWs5TG1mUlR1azBndnlMbWtrR0hjR1poV2V4?=
 =?utf-8?B?WVVZNWdnSEI4SmR3RGMwc04zbjZlVGM5dFBwUk5yZnVHa3ZlWitBaVExcnpt?=
 =?utf-8?B?SGdTMVZVTDRLRmpIdnJGVHpMTms3TjRDbVF1dHlIbVJNMU5mM1FLL0VBcFBh?=
 =?utf-8?B?RG9Eb05mY2hUajJtRXZJSHJXTFJLUkJqMFpSaFdQVy9vRHRSV3FlTnhSUmdI?=
 =?utf-8?Q?oALJbICattCgscvYw5SqXb4f4?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	RUxc8IuBwjf3XDZpuZIQ1x2u8WH8fAh0PW60YuICcToho/FyVEcLxvRJnvuYLFSuIPbxFUaF7yHXhnp9rX1qO5/JmXwJaDf4eGAH/3B2UOwFNLUMBqVaZI23AbpuhM2+YEVZxnnq0UR0QN9I8+tc/Hmg92hVDide1jyvhW2WSUfuQ57ZXNayYaTFS4PGfxGOvR7zFsXda7jrk5h0kvwrqRvZ1uLHJ1nU/sSEwlmmOVvnr8FMUvcjoknNCf3UP8xvozxjYgyg/+LkS54yjRidPO+a098k9vWIKKcXE2OYPwzp76lxShQx8f+qce8roBlplXpclcRqBQ6TS4FUe5fOlHSef8TmBzrIcSE01FQU9XF+NMteIzsoK7nl/+HYmUlsmFuLtABR2Ira+IfU6E2AKypaLAwn1BVEZRs1um5t0arDykZ9ZP3OERs6F/L4aWjsiPoodsHlY4FzKlRd3mrXhe0pzZca240rtwY3+1VUlpcS2uGumyM6ELQgdfsdHE5Mdzj5TJDtn/nlYkfWu9Q7ws7eOWAYIq8o79qdeCi39SahY81EfYsKNraJ3KvV727a2cvVubOGo5rFOW3ZtreT/tYensBlOqCr8Ouc24+rGzY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9572e5ff-37a6-4c0b-1f7c-08dc21891873
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2024 11:46:28.6276
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xjqmpWNwVq7EOikVDM2Rtx312gzrKq/Ake+Bx0xt74lRiKOac/jTsAhVvXWe4ly3mgTdAWssxbzMkpvEEfIEuA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB6775
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-30_05,2024-01-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 malwarescore=0 mlxscore=0
 spamscore=0 suspectscore=0 adultscore=0 mlxlogscore=999 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2401300086
X-Proofpoint-GUID: PTzW1SRizMZSvjKFMtFGZEQDqPTZfhIo
X-Proofpoint-ORIG-GUID: PTzW1SRizMZSvjKFMtFGZEQDqPTZfhIo

On 28/01/2024 16:58, Christoph Hellwig wrote:
> Add a new queue_limits_{start,commit}_update pair of functions that
> allows taking an atomic snapshot of queue limits, update it, and
> commit it if it passes validity checking.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Feel free to add:
Reviewed-by: John Garry <john.g.garry@oracle.com>

However there's still some nitpicking and maybe a real issue, below.

> ---
>   block/blk-core.c       |   1 +
>   block/blk-settings.c   | 182 +++++++++++++++++++++++++++++++++++++++++
>   block/blk.h            |   1 +
>   include/linux/blkdev.h |  23 ++++++
>   4 files changed, 207 insertions(+)
> 
> diff --git a/block/blk-core.c b/block/blk-core.c
> index 11342af420d0c4..09f4a44a4aa3cc 100644
> --- a/block/blk-core.c
> +++ b/block/blk-core.c
> @@ -424,6 +424,7 @@ struct request_queue *blk_alloc_queue(int node_id)
>   	mutex_init(&q->debugfs_mutex);
>   	mutex_init(&q->sysfs_lock);
>   	mutex_init(&q->sysfs_dir_lock);
> +	mutex_init(&q->limits_lock);
>   	mutex_init(&q->rq_qos_mutex);
>   	spin_lock_init(&q->queue_lock);
>   
> diff --git a/block/blk-settings.c b/block/blk-settings.c
> index e872b0e168525e..1287bf0177b6db 100644
> --- a/block/blk-settings.c
> +++ b/block/blk-settings.c
> @@ -96,6 +96,188 @@ static void blk_apply_bdi_limits(struct backing_dev_info *bdi,
>   	bdi->io_pages = lim->max_sectors >> (PAGE_SHIFT - 9);
>   }
>   
> +static int blk_validate_zoned_limits(struct queue_limits *lim)
> +{
> +	if (!lim->zoned) {
> +		if (WARN_ON_ONCE(lim->max_open_zones) ||
> +		    WARN_ON_ONCE(lim->max_active_zones) ||
> +		    WARN_ON_ONCE(lim->zone_write_granularity) ||
> +		    WARN_ON_ONCE(lim->max_zone_append_sectors))

nit: some - like me - prefer {} for multi-line if statements, but that's 
personal taste

> +			return -EINVAL;
> +		return 0;
> +	}
> +
> +	if (WARN_ON_ONCE(!IS_ENABLED(CONFIG_BLK_DEV_ZONED)))
> +		return -EINVAL;
> +
> +	if (lim->zone_write_granularity < lim->logical_block_size)
> +		lim->zone_write_granularity = lim->logical_block_size;
> +
> +	if (lim->max_zone_append_sectors) {
> +		/*
> +		 * The Zone Append size is limited by the maximum I/O size
> +		 * and the zone size given that it can't span zones.
> +		 */
> +		lim->max_zone_append_sectors =
> +			min3(lim->max_hw_sectors,
> +			     lim->max_zone_append_sectors,
> +			     lim->chunk_sectors);
> +	}
> +
> +	return 0;
> +}
> +
> +/*
> + * Check that the limits in lim are valid, initialize defaults for unset
> + * values, and cap values based on others where needed.
> + */
> +int blk_validate_limits(struct queue_limits *lim)
> +{
> +	unsigned int max_hw_sectors;
> +
> +	/*
> +	 * Unless otherwise specified, default to 512 byte logical blocks and a
> +	 * physical block size equal to the logical block size.
> +	 */
> +	if (!lim->logical_block_size)
> +		lim->logical_block_size = SECTOR_SIZE;
> +	if (lim->physical_block_size < lim->logical_block_size)
> +		lim->physical_block_size = lim->physical_block_size;

I guess that should really be:
lim->physical_block_size = lim->logical_block_size;

> +
> +	/*
> +	 * The minimum I/O size defaults to the physical block size unless
> +	 * explicitly overridden.
> +	 */
> +	if (lim->io_min < lim->physical_block_size)
> +		lim->io_min = lim->physical_block_size;
> +
> +	/*
> +	 * max_hw_sectors has a somewhat weird default for historical reason,
> +	 * but driver really should set their own instead of relying on this
> +	 * value.
> +	 *
> +	 * The block layer relies on the fact that every driver can
> +	 * handle at lest a page worth of data per I/O, and needs the value
> +	 * aligned to the logical block size.
> +	 */
> +	if (!lim->max_hw_sectors)
> +		lim->max_hw_sectors = BLK_SAFE_MAX_SECTORS;
> +	if (WARN_ON_ONCE(lim->max_hw_sectors < PAGE_SECTORS))
> +		return -EINVAL;
> +	lim->max_hw_sectors = round_down(lim->max_hw_sectors,
> +			lim->logical_block_size >> SECTOR_SHIFT);
> +
> +	/*
> +	 * The actual max_sectors value is a complex beast and also takes the
> +	 * max_dev_sectors value (set by SCSI ULPs) and a user configurable
> +	 * value into account.  The ->max_sectors value is always calculated
> +	 * from these, so directly setting it won't have any effect.
> +	 */
> +	max_hw_sectors = min_not_zero(lim->max_hw_sectors,
> +				lim->max_dev_sectors);

nit: maybe we should use a different variable for this for sake of clarity

> +	if (lim->max_user_sectors) {
> +		if (lim->max_user_sectors > max_hw_sectors ||
> +		    lim->max_user_sectors < PAGE_SIZE / SECTOR_SIZE)
> +			return -EINVAL;
> +		lim->max_sectors = min(max_hw_sectors, lim->max_user_sectors);
> +	} else {
> +		lim->max_sectors = min(max_hw_sectors, BLK_DEF_MAX_SECTORS_CAP);
> +	}
> +	lim->max_sectors = round_down(lim->max_sectors,
> +			lim->logical_block_size >> SECTOR_SHIFT);
> +
> +	/*
> +	 * Random default for the maximum number of sectors.  Driver should not
> +	 * rely on this and set their own.
> +	 */
> +	if (!lim->max_segments)
> +		lim->max_segments = BLK_MAX_SEGMENTS;
> +
> +	lim->max_discard_sectors = lim->max_hw_discard_sectors;
> +	if (!lim->max_discard_segments)
> +		lim->max_discard_segments = 1;
> +
> +	if (lim->discard_granularity < lim->physical_block_size)
> +		lim->discard_granularity = lim->physical_block_size;
> +
> +	/*
> +	 * By default there is no limit on the segment boundary alignment,
> +	 * but if there is one it can't be smaller than the page size as
> +	 * that would break all the normal I/O patterns.
> +	 */
> +	if (!lim->seg_boundary_mask)
> +		lim->seg_boundary_mask = BLK_SEG_BOUNDARY_MASK;
> +	if (WARN_ON_ONCE(lim->seg_boundary_mask < PAGE_SIZE - 1))
> +		return -EINVAL;
> +
> +	/*
> +	 * The maximum segment size has an odd historic 64k default that
> +	 * drivers probably should override.  Just like the I/O size we
> +	 * require drivers to at least handle a full page per segment.
> +	 */
> +	if (!lim->max_segment_size)
> +		lim->max_segment_size = BLK_MAX_SEGMENT_SIZE;
> +	if (WARN_ON_ONCE(lim->max_segment_size < PAGE_SIZE))
> +		return -EINVAL;
> +
> +	/*
> +	 * Devices that require a virtual boundary do not support scatter/gather
> +	 * I/O natively, but instead require a descriptor list entry for each
> +	 * page (which might not be identical to the Linux PAGE_SIZE).  Because
> +	 * of that they are not limited by our notion of "segment size".
> +	 */
> +	if (lim->virt_boundary_mask) {
> +		if (WARN_ON_ONCE(lim->max_segment_size &&
> +				 lim->max_segment_size != UINT_MAX))
> +			return -EINVAL;
> +		lim->max_segment_size = UINT_MAX;
> +	}
> +
> +	/*
> +	 * We require drivers to at least do logical block aligned I/O, but
> +	 * historically could not check for that due to the separate calls
> +	 * to set the limits.  Once the transition is finished the check
> +	 * below should be narrowed down to check the logical block size.
> +	 */
> +	if (!lim->dma_alignment)
> +		lim->dma_alignment = SECTOR_SIZE - 1;

It would be also nice to update blk_set_default_limits to use this (and 
not '511') or also any other instances of hard-coding SECTOR_SIZE for 512

> +	if (WARN_ON_ONCE(lim->dma_alignment > PAGE_SIZE))
> +		return -EINVAL;
> +
> +	if (lim->alignment_offset) {
> +		lim->alignment_offset &= (lim->physical_block_size - 1);
> +		lim->misaligned = 0;
> +	}
> +
> +	return blk_validate_zoned_limits(lim);
> +}
> +

