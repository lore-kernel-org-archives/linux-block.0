Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2068.outbound.protection.outlook.com [40.107.212.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80870144304
	for <linux-block@vger.kernel.org>; Sun, 18 May 2025 19:12:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747595561; cv=fail; b=ZsTJqdANMvGce9Eq3eiu2cIOKFd5rMlfn6clY66nCE1HupRwLr4VOlzaN8Skx1szTcGj4F8IO3hZMEkqTU+8veSkxpU1NlwYAX+2Wd2R2lprglsI1BBlSbE61a9Zzqqx41c+8chy72bEJzt+WGbnwXt7Gm9PmyJy10oBY383xp0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747595561; c=relaxed/simple;
	bh=6bTval+WtVCJQvnlMs9jTFylxfOud/QVvFJ0o9NbeRQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=fITKq/MDvVg2VaWSDZk0ERpqb+kdX2gZgK+8xzhpAvNx73qTj+yPPIxnP0yQlxJBmXrS4u2n2WVWw3it+8HwO8LrBAnn+jcm33bKWpSorKyak8bsG4Hen3rGDRwbufYYw7h+jzI1CdIjQtlv+YUQwVNqKtjgogJBAU1ZmN7lJCE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ehUYi3sP; arc=fail smtp.client-ip=40.107.212.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ehUYi3sP"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XJJfb5zys5H32Q90MPXdfZoTUl+/e0bjd8mg1oa+195OijMMajXgK/AryiKOsd3/+LD+wgvypKuAde4QnxSsZ/L8p64SGSiZTLiMSsqhMsdzSzKmWJJl9u+aorh+eJ9W1JiEpNTB13uHTmhWwwjYuXBefWLBj7PG+c6xj++NqNTWCCZ6pLeJlEorJOWOuPM6o+xEFIfFIHNX/zMRkar9kzCC5UXJCWDrayYhmIRYfVoZzD9lCnfkDHyH7qbus8gHhvtgnNQ3cXhg4j1rspt2mfWwM6Gz6bHCWOEaMn1IXLKbu5zSdyu5THiIjj12AKWm0eu5el0fdvzVAOoamUusPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gw+sPI6qqWb+MiWgbZsvXhi7Yr+N0nY0hFdQVfqUTrE=;
 b=BCZMHajQ3vCNYs3iBo0w3m4yC9JaJfJms9tZjlsT1LQT8EWu76qRZ+AkU485KRfRn1qKCjtNKoayz25znlaB0gCYwYLjyR7f9jGMBnFiIcwOYTP4C/IfgZReMTWjeuT5JCYsW6wwFMtbqRqc08nq/5ob49jMYCIoagnoWuvJHDBLPDRSaSippkaiEktzY29Qa3hPmj/DnbB9lQO4FL1tr/3JkaCco4M2U0gNgXbDGaNh7MPtGI78u9K0EsrvnCKvhY6KO1HVyfnHBHyQQAgfVz7ZdVhZ9LKlgL1JuRAKoBLC68cBN40nL/yE1H75inhabKP7C7lho2oFLS3laGJLYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gw+sPI6qqWb+MiWgbZsvXhi7Yr+N0nY0hFdQVfqUTrE=;
 b=ehUYi3sPAenElscVm8w+TJSajfkTRfjf+O/b5JSrlMcup/EtU5czEYQMhJgGAI2hkm4xIzLeMBJPaaK03c2HMb8gXsmeMe0Z15Q50LSJAXiVaA9cxjVS8ZOs/vSfQmEcaAUuk2+2A/RS1uNqn0g2n5EoqPhKJHvwZxTQirzMhGQ4zf3gmMTiueWzMPgwlU6gzb/M6pnc2auP+EqCz2OD5AVq0qUEPZcJc5/X0Uomw6HRQ+EfHgG4qFhObj4RzQDEVw2+1RCQGTMYMUiWNa3nVqVW9326gGBcyiu7+ZqMa4nSjmCoW8bUcDDP8yFQca5nf+N9MghW4Rns05eZ72M4QA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ1PR12MB6363.namprd12.prod.outlook.com (2603:10b6:a03:453::9)
 by SA0PR12MB4397.namprd12.prod.outlook.com (2603:10b6:806:93::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.33; Sun, 18 May
 2025 19:12:36 +0000
Received: from SJ1PR12MB6363.namprd12.prod.outlook.com
 ([fe80::bec3:4521:c231:d03b]) by SJ1PR12MB6363.namprd12.prod.outlook.com
 ([fe80::bec3:4521:c231:d03b%6]) with mapi id 15.20.8722.031; Sun, 18 May 2025
 19:12:35 +0000
Message-ID: <4395080b-7628-4290-9edd-ba442f0e096b@nvidia.com>
Date: Sun, 18 May 2025 22:12:29 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 2/2] ublk: fix race between
 io_uring_cmd_complete_in_task and ublk_cancel_cmd
To: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
 Ming Lei <ming.lei@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 Uday Shankar <ushankar@purestorage.com>,
 Caleb Sander Mateos <csander@purestorage.com>,
 Guy Eisenberg <geisenberg@nvidia.com>, Yoav Cohen <yoav@nvidia.com>,
 Omri Levi <omril@nvidia.com>, Ofer Oshri <ofer@nvidia.com>
References: <20250425013742.1079549-1-ming.lei@redhat.com>
 <20250425013742.1079549-3-ming.lei@redhat.com>
 <mruqwpf4tqenkbtgezv5oxwq7ngyq24jzeyqy4ixzvivatbbxv@4oh2wzz4e6qn>
Content-Language: en-US
From: Jared Holzman <jholzman@nvidia.com>
Organization: NVIDIA
In-Reply-To: <mruqwpf4tqenkbtgezv5oxwq7ngyq24jzeyqy4ixzvivatbbxv@4oh2wzz4e6qn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TL2P290CA0011.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:2::14) To SJ1PR12MB6363.namprd12.prod.outlook.com
 (2603:10b6:a03:453::9)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PR12MB6363:EE_|SA0PR12MB4397:EE_
X-MS-Office365-Filtering-Correlation-Id: 410bf7d0-543d-43af-2dc9-08dd963ff25b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cnNRbVpWZnR1ak13WU1qbWxrWGZEazhtY2d0ZU5udWJFanFmKzhsNFZLVEpN?=
 =?utf-8?B?Rmo3M1YxNytUeW03YTJYNklCck11bWdwTmFCekJnMjdXeGJJSnNXUnM1RHNG?=
 =?utf-8?B?cEJqdW14V0JJRjZKV094TUUwcFZxOWlXd0xscSszNkcxVS9RTFBGRStUS2Y4?=
 =?utf-8?B?QTJGNWhJU1NaTCsxNXRLNlRsWGhUdUxoYlBLdEtzZnlzT05rajlrTWJrMDFj?=
 =?utf-8?B?TjlQMmVpTHBSQjhITE9YMnFxdHhIY1NLV29XMEU0V2VJS1YvMFEvZVJzS3J2?=
 =?utf-8?B?b29yVEw4emgyaFdvdnJGUXRiT0hYYWZKWkM2UmVQcDhTL1hSSm1oQ214ZUp2?=
 =?utf-8?B?eFpkOHRpamxwelJTQmQ3OVhQWC9kcWlnZmxUTEJzZGRvM3piN1cxZ2Rpc1py?=
 =?utf-8?B?L2ZQdzNkYzJVKzV4WnFmeTV3QlJONFF1WE1rOXNQeERpMWxPNVFQSVQwWERa?=
 =?utf-8?B?VUExd08xY21oMGtpNE92QXd2Z2V2UzBteUNpOHJKdGNLd3hWM3FzMGJVK2JZ?=
 =?utf-8?B?NGpIeW43WXJ0WENTVGlOdUlRNWJUOVQ4dGtldTM4Rk5SWTBiNkdReEx3RHI1?=
 =?utf-8?B?R1pVRC90ZVMwOE92SjIwYjJqMmxZbFZSQ2tlaDVNRkVKMjlGeVo4V1FhWlM0?=
 =?utf-8?B?YzAwbU90YndFZDd1bVY5b0xlQ01DYnlJZ0ROUjdpZGtNYjFXQ3NJN0UxWDZQ?=
 =?utf-8?B?MUJMb2dWcTZKaXhyNG9TUjlwMWRvZmRtbzZrNjJYUWpBaS9kU0ZzVHBLaDVF?=
 =?utf-8?B?SnN5eUVvVWFlU2UrSXpYZGZzczdiQ3NDbWhZNWI2VU1aUFhmTGlxMGQwS1JI?=
 =?utf-8?B?bGpFM1JFVmpRNFUvR3E4S09nOHN2eXpMd1c2VVd1UGcyN1pWQkRkdmYvdXU5?=
 =?utf-8?B?UDFqRFZ2OHdxTGpJdW5OZFZtQVRaNEc0akdrL0lES2gzbGZGVFFuMm45aUMv?=
 =?utf-8?B?U0NyRjhUd2FaQ2N4d0J2ZTRCUmMrNkV6Qis2TysrdzlXS25DUC83ZlBrQ0tC?=
 =?utf-8?B?Qm9uaEUrMVJOa0pjS0ZORkpuZms2WGJQRmNLaEtvZ1ZYUXVueHFXOE1HWEdh?=
 =?utf-8?B?anUyNkZRNWs2SHY0d05YYmtvQ0t3KzA1U1hnOG5qOWlKN2NCOFVBWHhVbFFp?=
 =?utf-8?B?NEMzTHB6ajArUFBIL0tKWExwdjduUzFINElzRU8wK1lHeVBDZWJIclJoTGo0?=
 =?utf-8?B?djNEN09iNnhVY2hibmtvODd6eEVmTEtPRHQ4cnRxYjdPL204VExZU0tuL3pZ?=
 =?utf-8?B?Yk5RNldNanFWZ2RoYXN2Mkh0VkhFQnc2b3p5RjRHSXJWcWZPUWZURTZNbjZ3?=
 =?utf-8?B?Q0h1RVRndlpzRmxiSkViZVpDUys1clAvTjloRGJmdGIzcXgyN0FYTVBNNEhv?=
 =?utf-8?B?amg3MUVBUjMwM0xQOHZqTXhCb2VOb0tIZkg4cGtNTHplRHRHRlV1NUtYdFBW?=
 =?utf-8?B?aTlsbDM5bFpJQ1Job25rRTlvVjVBSXFHT1piVDhXbDV3c0M3d01WTmUxdFRP?=
 =?utf-8?B?ZFlrWUdjZWp6WTM4VGNPT0xoeC92dGhhRm1ocmVEZ3VVNFJuT2ZGMDBEaVRx?=
 =?utf-8?B?REFhYUcxNzJZV25PYXA4ZWxBYjdLSUM5Z095Z0U0UlRXRkFrQ2R4YjVoL0Nz?=
 =?utf-8?B?OTZsbnU3T2JFSlFCZXY3ZjBFNnBsQXhnb3ljd2RXc1ZiK1VaV2JLM3MzU2Ev?=
 =?utf-8?B?WFBWUWRHVWh0MG5RS2h6d2pBMHphdTVoU3hOQkdYcktGSzZ6QVF3L09zVHVY?=
 =?utf-8?B?emtUTWwwUUZFQ054TnBrVitwZkRwOFhpR2hucVlDLzFnQjArU0RwU01oQmhR?=
 =?utf-8?B?NTM3L1Nycldwbzh4YVkrWGxyWWlYeHRDQ3RtaTVyaW5Xa2lMUjI5Wk5ERVRG?=
 =?utf-8?B?c3MxYkwxQ1BLSlh4RkRXd3V0eDNwNlhTd1BBeG4zMzE4YVFQQVJiYk9HMTdN?=
 =?utf-8?Q?09CFBaQUR1c=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR12MB6363.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eUhCSjJpc3BRa2xUMWtINHNWMWNEOTl5OG1MR1M5MWU0akpMMTRTUXA4MXVj?=
 =?utf-8?B?R3l1R1FRbGhHTTZTeEsrUTZLNXJFUXBTd05WWXRVMW5QcldTZHpML1ZHQ251?=
 =?utf-8?B?dnRIdVhpUk4xR1I2dmJkWFg1bDhrbWtuMGI4SW82QU5KeFZhSEh3VG94K3Rr?=
 =?utf-8?B?RHd5cWpnZ0t2d1EvYzF0L3phWmxlS3JaTGVkS04weURmWXJqK1BGYVhBU05r?=
 =?utf-8?B?UTdPNGUwVkJVbk5qY1gyczdRd2V6TnRWV0QzUDdjaUtmOUFFTmNCbmhkTVhn?=
 =?utf-8?B?ZndGYWttc0Jwd3RJUHUzMy9hdm44NnhmOEc3L3ZqSmJMNWwzWFpXS3VWQjVk?=
 =?utf-8?B?YnBGQjIyUUFsWGF5Z2JLMEdUMjlOWitScnFWcTNTSlV4UWQxRDY3d3dtcnVO?=
 =?utf-8?B?L21jcDBaaEZGbzNyTEthaWtaNUZJNTFQT2g2RlpOc1NkMDRnUXIyelVFbllG?=
 =?utf-8?B?U0tIRXdzR1VCMlp0bmd5eGQ5cVVRb2phcTVycmJpRVFkaEtIbjBPdWVUcEI4?=
 =?utf-8?B?SHJvaHpySTNRQ3ZDQTJjbXdRTTlralBpSlhLQmxUZDk2eGptRXh0YVRNZC9Y?=
 =?utf-8?B?U3VBdHkvV1NHVU94OFlnTTlBRk1hNXF3OG83M1o4c21aMTdaUzM5RzBwNmVH?=
 =?utf-8?B?RVhTdXRQRGFkOEJCTnBlQ3ZZN25zOUpXSkE4MDFzbzZYR2ZMVVNyTjRLWi9v?=
 =?utf-8?B?cVpaSFhPRHNzcDJCRHZFWUVYdzF5aHJHZk9BLytSMzJiOFQwTmVJSVJtSHIr?=
 =?utf-8?B?Y2V0VW40SFVxYWFaRUIyLzFpV21HM3FrZ3duMGhXaDIxa2VrQ3ZUdjlRWGpU?=
 =?utf-8?B?SWNtYWlqTVNCUDJPVzNLRXNuYUhJTU1HOUZWUGY0Z3I1MUdOUC9JSWtKNGpG?=
 =?utf-8?B?L3VPK2ljZ2t1ZHZZWW5qOTh0MEYwQ0NZWkFMZGw4TndnZ2xrRU41Qk9MbWtS?=
 =?utf-8?B?Nzd3L1loSjd5V3ZpbEFTUXpSdUdzSitFb21JNkFFTlM3SGdJTWF3VnNLeWY1?=
 =?utf-8?B?empaS0hHS0NPTmZQeVNVS2xXSlhYVUtuTUo0bTEvK2lNVC96R2JJYlB0dTlp?=
 =?utf-8?B?Z1ZteGdWSUVGbVNMWWNkbnB3M1RPelExd0xuVzJ6KzZVaWlxUXFqTlN5ZGc2?=
 =?utf-8?B?UVZWcHZIVkJCdUZpb3ZvRUlWOFJuNmt3TWFMTmM1UVNRQnV0R2dsZXZGRnZJ?=
 =?utf-8?B?MGV5cURZMTVRWTFJNkorcVpqZkN2dXgyZDV5NnhtQ0QxZHFiTWd3em9JYW11?=
 =?utf-8?B?d3RpTmFZa0pRS3FyT3d2QlZhT3hjUEFQaEI5SUdtanJRb1NnRHdmUk5kV044?=
 =?utf-8?B?ejVrZUliWm5hVS9rVVkwSEVOaklmeG42cm5kaHZYMGlnRjNvaDJFaWJKOEh3?=
 =?utf-8?B?azJqL2kzajhiYXRkNktXUCtMV2xrRldMYnBpK2NqbTdQMVRJMFQyUnBjRk00?=
 =?utf-8?B?S3FXczZ5Yk1xWktoblpmdGVqeG5lWlN3SWNSc1ZtR2Vhb0VraDRkY05ZOVk1?=
 =?utf-8?B?SW00UXV0bHgrbU9Ncyt6MG5lcnVFRmdHOTRuNm5iVVBMSWlrZG1RSFRxM2lu?=
 =?utf-8?B?QnB6QlBlZWV0OHFHZnlFZ2FKWWdNZU5NQjBDUlo0WGlnVnhOb1pZMFV1UGpa?=
 =?utf-8?B?N3lZV1JJd055QTkyQlVYajNsR1pwWEYzdnNoV2VYWTNKaTgranhKWTRqSDQv?=
 =?utf-8?B?cFFheStnSnZlR2NEeUUyYkNjK2d2L05wNjYvRHZzd3N2d3FmT2ZGQndjMm44?=
 =?utf-8?B?OXVwc1hRVkNZZ3libXlXSVRhdXNIYUZrU012SEgxVkRpWDZ4azlmSjlDdkRC?=
 =?utf-8?B?YVI4dXA3bnEyTkhlQ2xTUTNFSk9EeHIyYmdRaHRqTGJvYUtSQ2IxaDBjNVpt?=
 =?utf-8?B?blNwcjlrT3pUV1VaVzZDV1RFMEJ5SlNGM0gvZ2gydk4wTzBYU1o4TnpuTVFt?=
 =?utf-8?B?ODB0REZOUUVxczZCbG9XZkJ3RkpsZVpWUEV1TGVYbU5xUnR2Vjl6NVpLMW0y?=
 =?utf-8?B?Zy9uZWJ3b0hMSXpJYmIrS1htVFlYZUowd3BsVm1XSmVxS1c2MnB1WGFsVXVv?=
 =?utf-8?B?UHg1K2lGc2lVNzk3Vkd3eS9nUW1wWW1BUURWM3c0YXBsbEZ1U2VWN3FCQVkz?=
 =?utf-8?Q?O7FkHV+52MOgCedX5Fj0bvOuL?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 410bf7d0-543d-43af-2dc9-08dd963ff25b
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR12MB6363.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2025 19:12:35.2443
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8GQ22JRF+oQ5GbrSrF+9EhQQtyf6Ka0oMWZhZMTGXnlgGNxtkk1rRtvmAeaGcIANWJjWELM0oea/s24i25wSzA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4397

On 14/05/2025 4:50, Shinichiro Kawasaki wrote:
> On Apr 25, 2025 / 09:37, Ming Lei wrote:
>> ublk_cancel_cmd() calls io_uring_cmd_done() to complete uring_cmd, but
>> we may have scheduled task work via io_uring_cmd_complete_in_task() for
>> dispatching request, then kernel crash can be triggered.
>>
>> Fix it by not trying to canceling the command if ublk block request is
>> started.
> 
> I found that the blktests test case ublk/002 often hangs with the recent
> v6.15-rcX kernel tags with the INFO at iou-wrk-X [1]. The hang is recreated
> in stable manner when I repeat the test case a few times.
> 
> I bisected and this patch as the commit f40139fde527 triggers the hang.
> When I reverted the commit from the kernel v6.15-rc6, the hang disappeared.
> (I repeated ublk/002 20 times, and observed no hang.)
> 
> The hang was observed with test systems with Fedora 42. I do not observe
> the hang with Fedora 41, but not sure why. liburing version difference
> could be the reason (v2.6 for Fedora 41, v2.9 for Fedora 42).
> 
> Actions for fix will be appreciated.
> 
> [1]
> 
> [ 4497.777695] [ T130863] run blktests ublk/002 at 2025-05-07 14:48:32
> [ 4499.983130] [  T67084] blk_print_req_error: 58 callbacks suppressed
> [ 4499.983136] [  T67084] I/O error, dev ublkb0, sector 106830432 op 0x0:(READ) flags 0x800 phys_seg 1 prio class 0
> [ 4499.985230] [  T67084] I/O error, dev ublkb0, sector 165364248 op 0x0:(READ) flags 0x800 phys_seg 1 prio class 0
> [ 4499.998194] [  T57173] I/O error, dev ublkb0, sector 251279584 op 0x0:(READ) flags 0x800 phys_seg 1 prio class 0
> [ 4671.208372] [     T46] INFO: task iou-wrk-131061:131062 blocked for more than 122 seconds.
> [ 4671.209417] [     T46]       Not tainted 6.15.0-rc5 #317
> [ 4671.210182] [     T46] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> [ 4671.211194] [     T46] task:iou-wrk-131061  state:D stack:0     pid:131062 tgid:131061 ppid:131060 task_flags:0x404150 flags:0x00004000
> [ 4671.212573] [     T46] Call Trace:
> [ 4671.213364] [     T46]  <TASK>
> [ 4671.214047] [     T46]  __schedule+0xf8c/0x5c80
> [ 4671.214920] [     T46]  ? rcu_is_watching+0x11/0xb0
> [ 4671.215831] [     T46]  ? __mutex_lock+0x2d9/0x1b50
> [ 4671.216760] [     T46]  ? rcu_is_watching+0x11/0xb0
> [ 4671.217718] [     T46]  ? lock_release+0x244/0x300
> [ 4671.218621] [     T46]  ? lock_release+0x244/0x300
> [ 4671.219521] [     T46]  ? __pfx___schedule+0x10/0x10
> [ 4671.220433] [     T46]  ? do_raw_spin_lock+0x124/0x260
> [ 4671.221425] [     T46]  ? rcu_is_watching+0x11/0xb0
> [ 4671.222292] [     T46]  ? rcu_is_watching+0x11/0xb0
> [ 4671.223121] [     T46]  ? lock_release+0x244/0x300
> [ 4671.223984] [     T46]  ? lock_release+0x244/0x300
> [ 4671.224844] [     T46]  schedule+0xda/0x390
> [ 4671.225667] [     T46]  blk_mq_freeze_queue_wait+0x121/0x170
> [ 4671.226653] [     T46]  ? __pfx_blk_mq_freeze_queue_wait+0x10/0x10
> [ 4671.227656] [     T46]  ? __pfx_autoremove_wake_function+0x10/0x10
> [ 4671.228656] [     T46]  ? trace_hardirqs_on+0x14/0x150
> [ 4671.229564] [     T46]  ? _raw_spin_unlock_irq+0x34/0x50
> [ 4671.230484] [     T46]  del_gendisk+0x4f9/0xa20
> [ 4671.231320] [     T46]  ? ublk_stop_dev+0x24/0x200 [ublk_drv]
> [ 4671.232379] [     T46]  ? __pfx_del_gendisk+0x10/0x10
> [ 4671.233197] [     T46]  ? __pfx___mutex_lock+0x10/0x10
> [ 4671.234094] [     T46]  ublk_stop_dev_unlocked.part.0+0xb6/0x580 [ublk_drv]
> [ 4671.235153] [     T46]  ? __pfx_ublk_stop_dev_unlocked.part.0+0x10/0x10 [ublk_drv]
> [ 4671.236303] [     T46]  ? kvm_sched_clock_read+0xd/0x20
> [ 4671.237156] [     T46]  ublk_stop_dev+0x62/0x200 [ublk_drv]
> [ 4671.238081] [     T46]  ? security_capable+0x79/0x110
> [ 4671.238964] [     T46]  ublk_ctrl_uring_cmd+0xe87/0x2a70 [ublk_drv]
> [ 4671.239967] [     T46]  ? __pfx_avc_has_perm+0x10/0x10
> [ 4671.240858] [     T46]  ? lock_release+0x244/0x300
> [ 4671.241759] [     T46]  ? rcu_is_watching+0x11/0xb0
> [ 4671.242677] [     T46]  ? __pfx_ublk_ctrl_uring_cmd+0x10/0x10 [ublk_drv]
> [ 4671.243751] [     T46]  ? finish_task_switch.isra.0+0x202/0x850
> [ 4671.244728] [     T46]  ? selinux_uring_cmd+0x1c3/0x280
> [ 4671.245623] [     T46]  ? __schedule+0x2f21/0x5c80
> [ 4671.246504] [     T46]  ? __pfx_selinux_uring_cmd+0x10/0x10
> [ 4671.247438] [     T46]  ? rcu_is_watching+0x11/0xb0
> [ 4671.248228] [     T46]  ? __pfx_do_raw_spin_lock+0x10/0x10
> [ 4671.249109] [     T46]  io_uring_cmd+0x221/0x3c0
> [ 4671.249952] [     T46]  io_issue_sqe+0x6ab/0x1800
> [ 4671.250767] [     T46]  ? trace_hardirqs_on+0x14/0x150
> [ 4671.251634] [     T46]  ? __pfx_io_issue_sqe+0x10/0x10
> [ 4671.252502] [     T46]  ? __timer_delete_sync+0x16c/0x270
> [ 4671.253392] [     T46]  ? __pfx___timer_delete_sync+0x10/0x10
> [ 4671.254402] [     T46]  ? rcu_is_watching+0x11/0xb0
> [ 4671.255162] [     T46]  io_wq_submit_work+0x3ea/0xf70
> [ 4671.255990] [     T46]  io_worker_handle_work+0x615/0x1280
> [ 4671.256854] [     T46]  io_wq_worker+0x2ee/0xbd0
> [ 4671.257670] [     T46]  ? __pfx_io_wq_worker+0x10/0x10
> [ 4671.258491] [     T46]  ? rcu_is_watching+0x11/0xb0
> [ 4671.259285] [     T46]  ? lock_acquire+0x2af/0x310
> [ 4671.260035] [     T46]  ? rcu_is_watching+0x11/0xb0
> [ 4671.260800] [     T46]  ? do_raw_spin_lock+0x124/0x260
> [ 4671.261604] [     T46]  ? lock_acquire+0x2af/0x310
> [ 4671.262376] [     T46]  ? __pfx_do_raw_spin_lock+0x10/0x10
> [ 4671.263186] [     T46]  ? lock_release+0x244/0x300
> [ 4671.263947] [     T46]  ? rcu_is_watching+0x11/0xb0
> [ 4671.264718] [     T46]  ? __pfx_io_wq_worker+0x10/0x10
> [ 4671.265529] [     T46]  ret_from_fork+0x30/0x70
> [ 4671.266277] [     T46]  ? __pfx_io_wq_worker+0x10/0x10
> [ 4671.267070] [     T46]  ret_from_fork_asm+0x1a/0x30
> [ 4671.267855] [     T46]  </TASK>
> [ 4671.268495] [     T46] INFO: lockdep is turned off.
> [ 4794.088765] [     T46] INFO: task iou-wrk-131061:131062 blocked for more than 245 seconds.
> [ 4794.090310] [     T46]       Not tainted 6.15.0-rc5 #317
> [ 4794.091453] [     T46] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> [ 4794.093379] [     T46] task:iou-wrk-131061  state:D stack:0     pid:131062 tgid:131061 ppid:131060 task_flags:0x404150 flags:0x00004000
> [ 4794.095353] [     T46] Call Trace:
> [ 4794.096142] [     T46]  <TASK>
> [ 4794.096929] [     T46]  __schedule+0xf8c/0x5c80
> [ 4794.097878] [     T46]  ? rcu_is_watching+0x11/0xb0
> [ 4794.098869] [     T46]  ? __mutex_lock+0x2d9/0x1b50
> [ 4794.099866] [     T46]  ? rcu_is_watching+0x11/0xb0
> [ 4794.100870] [     T46]  ? lock_release+0x244/0x300
> [ 4794.101857] [     T46]  ? lock_release+0x244/0x300
> [ 4794.102797] [     T46]  ? __pfx___schedule+0x10/0x10
> [ 4794.103726] [     T46]  ? do_raw_spin_lock+0x124/0x260
> [ 4794.104752] [     T46]  ? rcu_is_watching+0x11/0xb0
> [ 4794.105744] [     T46]  ? rcu_is_watching+0x11/0xb0
> [ 4794.106678] [     T46]  ? lock_release+0x244/0x300
> [ 4794.107575] [     T46]  ? lock_release+0x244/0x300
> [ 4794.108528] [     T46]  schedule+0xda/0x390
> [ 4794.109391] [     T46]  blk_mq_freeze_queue_wait+0x121/0x170
> [ 4794.110437] [     T46]  ? __pfx_blk_mq_freeze_queue_wait+0x10/0x10
> [ 4794.111527] [     T46]  ? __pfx_autoremove_wake_function+0x10/0x10
> [ 4794.112662] [     T46]  ? trace_hardirqs_on+0x14/0x150
> [ 4794.113626] [     T46]  ? _raw_spin_unlock_irq+0x34/0x50
> [ 4794.114644] [     T46]  del_gendisk+0x4f9/0xa20
> [ 4794.115518] [     T46]  ? ublk_stop_dev+0x24/0x200 [ublk_drv]
> [ 4794.116548] [     T46]  ? __pfx_del_gendisk+0x10/0x10
> [ 4794.117536] [     T46]  ? __pfx___mutex_lock+0x10/0x10
> [ 4794.118521] [     T46]  ublk_stop_dev_unlocked.part.0+0xb6/0x580 [ublk_drv]
> [ 4794.119749] [     T46]  ? __pfx_ublk_stop_dev_unlocked.part.0+0x10/0x10 [ublk_drv]
> [ 4794.121060] [     T46]  ? kvm_sched_clock_read+0xd/0x20
> [ 4794.122081] [     T46]  ublk_stop_dev+0x62/0x200 [ublk_drv]
> [ 4794.123102] [     T46]  ? security_capable+0x79/0x110
> [ 4794.124139] [     T46]  ublk_ctrl_uring_cmd+0xe87/0x2a70 [ublk_drv]
> [ 4794.125225] [     T46]  ? __pfx_avc_has_perm+0x10/0x10
> [ 4794.126054] [     T46]  ? lock_release+0x244/0x300
> [ 4794.126850] [     T46]  ? rcu_is_watching+0x11/0xb0
> [ 4794.127579] [     T46]  ? __pfx_ublk_ctrl_uring_cmd+0x10/0x10 [ublk_drv]
> [ 4794.128512] [     T46]  ? finish_task_switch.isra.0+0x202/0x850
> [ 4794.129379] [     T46]  ? selinux_uring_cmd+0x1c3/0x280
> [ 4794.130178] [     T46]  ? __schedule+0x2f21/0x5c80
> [ 4794.130926] [     T46]  ? __pfx_selinux_uring_cmd+0x10/0x10
> [ 4794.131701] [     T46]  ? rcu_is_watching+0x11/0xb0
> [ 4794.132357] [     T46]  ? __pfx_do_raw_spin_lock+0x10/0x10
> [ 4794.133159] [     T46]  io_uring_cmd+0x221/0x3c0
> [ 4794.133931] [     T46]  io_issue_sqe+0x6ab/0x1800
> [ 4794.134653] [     T46]  ? trace_hardirqs_on+0x14/0x150
> [ 4794.135417] [     T46]  ? __pfx_io_issue_sqe+0x10/0x10
> [ 4794.136191] [     T46]  ? __timer_delete_sync+0x16c/0x270
> [ 4794.136984] [     T46]  ? __pfx___timer_delete_sync+0x10/0x10
> [ 4794.137833] [     T46]  ? rcu_is_watching+0x11/0xb0
> [ 4794.138527] [     T46]  io_wq_submit_work+0x3ea/0xf70
> [ 4794.139268] [     T46]  io_worker_handle_work+0x615/0x1280
> [ 4794.140062] [     T46]  io_wq_worker+0x2ee/0xbd0
> [ 4794.140806] [     T46]  ? __pfx_io_wq_worker+0x10/0x10
> [ 4794.141478] [     T46]  ? rcu_is_watching+0x11/0xb0
> [ 4794.142189] [     T46]  ? lock_acquire+0x2af/0x310
> [ 4794.142930] [     T46]  ? rcu_is_watching+0x11/0xb0
> [ 4794.143663] [     T46]  ? do_raw_spin_lock+0x124/0x260
> [ 4794.144363] [     T46]  ? lock_acquire+0x2af/0x310
> [ 4794.145087] [     T46]  ? __pfx_do_raw_spin_lock+0x10/0x10
> [ 4794.145897] [     T46]  ? lock_release+0x244/0x300
> [ 4794.146617] [     T46]  ? rcu_is_watching+0x11/0xb0
> [ 4794.147340] [     T46]  ? __pfx_io_wq_worker+0x10/0x10
> [ 4794.148070] [     T46]  ret_from_fork+0x30/0x70
> [ 4794.148817] [     T46]  ? __pfx_io_wq_worker+0x10/0x10
> [ 4794.149576] [     T46]  ret_from_fork_asm+0x1a/0x30
> [ 4794.150307] [     T46]  </TASK>
> [ 4794.150959] [     T46] INFO: lockdep is turned off.
> ...

Hi Shinichiro,

Are you referring to test_generic_02.sh in tools/testing/selftests/ublk?

I tried running it 20 times and it didn't get stuck

Kernel: 6.15.0-rc6
liburing: v2.9

Jared
