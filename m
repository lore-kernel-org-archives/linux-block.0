Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19BCF18C939
	for <linux-block@vger.kernel.org>; Mon, 28 Oct 2024 10:27:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730111232; cv=fail; b=fkMaAfPx4pi1VD8qlModDG6/EzXBYizFMKWGNn+9Jar/efnq9mQhgr5kHErtpFyKcbr/c8sdBa+sLzVtbHWVwx7zgjsnn4Uv8WRtUa6l6zmLB7eX0CKr/a7cZytjTF43tSt7vhobUR0XmgOhh8x/7oIcvP3upqYUkBTfo8Kf+fA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730111232; c=relaxed/simple;
	bh=uvcQiCWvMRjw0+zICt7b/NO4D5nEyJpVAh8xvOqA0xY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=i42bAKokUvLHYZRzkXNRBoMTqDfhw6sC7zqd5mfv45I8aWBWTVwKLy9jV1/8LxUiWuakSPtVsckoFckGIjH+1YI7oIEX0xx3is7pA8yCvj+4RfxZp4FP/BZn0iw+ZHgXjFDdnEJYNdIMdEuRNt2WSw0stLMepZhM1ZupbxVXq70=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=EaHnH3Ya; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=L1gtdNLj; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="EaHnH3Ya";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="L1gtdNLj"
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49S7taLv018927;
	Mon, 28 Oct 2024 10:27:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=oum7H8vU5FzfrYNlQ86QBqp/VVtaA5DNNgA0xpB0Lag=; b=
	EaHnH3YaIWNJdiQRGLbsXRFB0oC2d625sW6q1D6B3Dsx43g+GsQ/JmwBCGk1TZO3
	NF+ZZnEhs2JPMnejNbW8xQtMebQD9P6GIK1PM/34+T1Shg8bmuENSaD17d1LJiMd
	6zFl3o2UEzGD5kkJl/q3zW63e0RUFnikDf2KjPuVHv3pbA4/wSqQmWDZxEzmhEA4
	rqUQVq+AwfhJNDc3pwgp8+l/OwbqVPDUmuZvvJQ4nm9DonIPzJ/Gn0X9x3lfAWnV
	CSexekp/aqRQfiUoajBwFHhylIfvx5TCSQuTK8rTCYXYPh1uuxMQs5ABoWahNmpf
	5nc4TPp/Fw4JMkbT2z6f3A==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42grc1td80-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 28 Oct 2024 10:27:01 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49S8RiZm040216;
	Mon, 28 Oct 2024 10:27:00 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2040.outbound.protection.outlook.com [104.47.74.40])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 42hnam6y0b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 28 Oct 2024 10:27:00 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VU+Vpe6GlZHY6sasw28wxu0yRN47FGNEpQyFC0sp/s45Yucb6EAw+hHcM52NX/CafjazLUMTlRQGQHuHrKyc2t0RLzHSYIjWX8CNG3Mm3OBcQgIGYfKBf1P0w6rpbgI2BJWPoo9bATHDRzAn4BB5C5ElCIHVdBsF1spcH7e2dh5UfCCL81uxzlThdC4+E1t9Q38kNLzf+t+ceya2p7RqdchQJfZea9tuwSOdDnuDbaO7uYodHGL6Xk/mmmNso/yVWVKj2EaUE7fRgbvfi9EXlJr7dpogX3eQDMmPbg5AKe9LacNDFaS3Po22VWwGr6l0lAnu0F4FEf3ZVmw4p3iOdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oum7H8vU5FzfrYNlQ86QBqp/VVtaA5DNNgA0xpB0Lag=;
 b=BvthQ5I+lnbncn38duDNcfr2yuDCeiJmCdzM4csPgSp8oqXr4kSCZbOnJy4PrIeUmk2HFkjKNGkJ3IEAxzHl6Y6N/yI7ybLNOnooZI+kyeHE1qKxP+z5XsuEDR32AcG+ohrXa92K/OQsbEVh++KuATzl/1J6UnIRMmcNrEt+1ny+KRtWbILp62ea7xGKlfsXruoEjhmA28b1cnrtX1r5d3osr6MgMIKUuqyPLOzXmPC1trvq431KbFudfyFgwk2I1+hCtLWYMvGGtQ9R5EkY718Vk6fcUggBAr6AGcE3iZOe8fXHlHQIJPrMy1tGs3VotZ8Bl2+NdVN5t/MaGtXgfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oum7H8vU5FzfrYNlQ86QBqp/VVtaA5DNNgA0xpB0Lag=;
 b=L1gtdNLj07RRb34LjcH2l4k3CcLN9wyDLHO5nWdopIPH9mWVpW/K68fNVmKBPEqEpw4yO9vD8PuAkLPI5tJw2EHTdCg0NaKIYLIWxdGn6KTkynrbYDNWU86W+pAcqAOoxLTYF/71gL1RSDaA8PTpbT0OsLdHvgPs7HKrCaUuajA=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by DM4PR10MB7425.namprd10.prod.outlook.com (2603:10b6:8:180::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.20; Mon, 28 Oct
 2024 10:26:53 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%5]) with mapi id 15.20.8093.024; Mon, 28 Oct 2024
 10:26:53 +0000
Message-ID: <a25c1c2c-21da-48cf-ad35-acaf9c4be9ba@oracle.com>
Date: Mon, 28 Oct 2024 10:26:50 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] block: fix queue limits checks in blk_rq_map_user_bvec
 for real
To: Christoph Hellwig <hch@lst.de>, axboe@kernel.dk
Cc: ushankar@purestorage.com, xizhang@purestorage.com, joshi.k@samsung.com,
        anuj20.g@samsung.com, linux-block@vger.kernel.org
References: <20241028090840.446180-1-hch@lst.de>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20241028090840.446180-1-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P265CA0057.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:60::21) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|DM4PR10MB7425:EE_
X-MS-Office365-Filtering-Correlation-Id: e8d98375-e122-4d7a-c3ea-08dcf73b0a98
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RjFFTmpYdk5zM2taODJmUXJhZmxvZnI0eFNocUlpbVNOd1JEUUI5dTJGdFlI?=
 =?utf-8?B?TUtna3Rxa1JROXAwb0Z5V3ZScml3dGtDMENSTHhvRUhKL2YzVEIzREM0V1Jr?=
 =?utf-8?B?bER3djdqcW1nVlF3NXZPdjdhcC9kMXdEV0RjVERMa3N2c24wRzNrNkVJZGp5?=
 =?utf-8?B?Y0tZd2VVYWhNNVVWSzVIcU5Md2RnNjBLTmlKRzJmT3h2emZEd0dSRkw1c0wr?=
 =?utf-8?B?QXNjWHRsN2RuOHI1SGNGYWZkbkF2S3JhZjhuQ1Vtb1NKYkFJY0g0cDFNYk5E?=
 =?utf-8?B?cmxUWHFBdHprajNsQzU1L0xZaUthMk80aFE2Tm5kSjF6bjhMdlo1MnN6S2oy?=
 =?utf-8?B?UWVhMklqN0ExRDUrOGk0eVJyWnQ0RDFaUVVac21sMzlFM0RNLzRVZGl1ZjJw?=
 =?utf-8?B?VW80QnpEV2EyY3crdXV0N0tUOU9QSG5DYjl0a2wrTUVyem45WGxBcjVnQk5S?=
 =?utf-8?B?Nkc5MmJNNzJyYjhtKzQ5ZnZteTlsKzAwb1Z2aWFwUzVzVTYvc1YwTU9ndXRK?=
 =?utf-8?B?ZUM0d29lWWFsYlIyNW9iU1hmVTRxR3NTMHJqK2cvSlRrSFRtMytLQWpzZDcv?=
 =?utf-8?B?NnAvd1Iwa0N3aUk4WHhqMzNkZFZ4ekd2WVArT2FRd0R3UE91NkJsRkFiKzBj?=
 =?utf-8?B?RWRjSTBzM0YzbnZMVTltVyt0aVNidVlzRDA4WmEzcGlUVGpkSUJ4WVpVMmx0?=
 =?utf-8?B?V3RXcGVHVjZWYkJQWWQzaVU1SzB1SHIxTnJuc1dQaGErOWVLSGo3V0Mwd2gz?=
 =?utf-8?B?Q3Y0Z0xxNnQreHhYdWxEaytrUEtzakRKcE1qSXFtK01URVRpZEMwbnMxWFBt?=
 =?utf-8?B?M3BORWk5U0Vqc3U4QWFpeS83MWthMUo4R2RYZlVkUTlKR21XS09ucmZ1dklm?=
 =?utf-8?B?d2RXMVJheUlyT01ZNC9VeWo2bksycUFjQUtrOUdPY2c0T0lSeWZhVklQWXFr?=
 =?utf-8?B?U3BOa2ZmNnRySEFybVd2VkpWMVAwRnBKbUM2b3Z2dDhtNzFHV0lNejlpeGxM?=
 =?utf-8?B?UlFwRUVmWmFSYyt4VXJ0Z0FMdWdmN1RVaTBPeUhoMHRFMGdsTndMSlZ6dXZY?=
 =?utf-8?B?ZDRxQXoyVU9qM2dZK1I0cGpIUWN4dUs1ZmNwVWxHY3ljSTVUdzFZMkUyVHZs?=
 =?utf-8?B?MlR3eWtLWkFVYUlxL2lLdTRsQmJjY2dManZKZnFDMzhEa25ib1FxNGlzR2lp?=
 =?utf-8?B?Q2JGVjhGbWVQMlNpWlJPdDRnejFtYWtSeGM4dklSVjZOcGsvS3ZsWFQwSWsy?=
 =?utf-8?B?YlNaTlhFdnR3VUU1VUdVOUpRUHMyUW1oWGtUYWEwOHU5ZHl5TTU1UEpML0RY?=
 =?utf-8?B?bDJYb0FDa3VHZUZSK1lZQSs4Y1ROSitNTUQ3djNnZzRrcUoyWWFlQ2plVGNZ?=
 =?utf-8?B?cnBSSEV5NTF5OVR2MzZ1NjFFNzdlQWxJUjBURFRzeHhodzREYjdKMkJCSkRS?=
 =?utf-8?B?OGxyM2huS3FLSEUxVXZzblY0TExoU0ZmcW5VMzFVSWlCL1ova251VmtaR2o5?=
 =?utf-8?B?ZXpDaTh5blMxbU9PZUdyWlo2NHNpK25oTWFqRXJVSG9zSThYRUszU2c2YnJs?=
 =?utf-8?B?WFVBYXJXV1ZxWnEvRUlJKzhJRWZIbjFCQmovUVlyVTJXMzJraGhqa2J1a3la?=
 =?utf-8?B?dkFvak5qckdlWWZ3Qk9wckh5TmliRWtSRUlmcXNkVlhWWTk3V2FMdUxqOXk2?=
 =?utf-8?B?S3dYUURBT1Vsdm9nZEtXRHpPZGJPT0VtSDJPNXpxNDVKQStyaVU0NjhGQW9p?=
 =?utf-8?Q?C2lgmC+PdiflAfJpRwq9Uv3CQjN2656ufcqCtqB?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?K2pBNGJ4SkZBbThtT3Z4Tk1maHkzRWJ6S3pDenhPbUlFdXl1eGl3MzcrWGRr?=
 =?utf-8?B?SEErUlFqWFUzREdwOVd5T01TNGpEUFhJc1FHTmFHQW9jSHRvWXcwNG5HcnFr?=
 =?utf-8?B?ZWpEcVI1SVp2VXYvOTQzVXZiUEJQVG4xMFFvWm83NUVJZW5QbHFJVXhnaXcz?=
 =?utf-8?B?QUFMME53MjVnclNsMXVBcEp1czhIV2x3VTFINXFwRVpEWUJ6aUd1eXA2dlJu?=
 =?utf-8?B?ajBFL0crVHpDK2w0MFFIZzRLQ1AzZmlsc3ZKaU5vbWZvQ1FXekJsT3dGSk55?=
 =?utf-8?B?V3BZQU1uN2luYnVoQjBGSjVmVUVrZ0NtdldhUU9FNTJ6NXY2WWgvd1Q3QnJV?=
 =?utf-8?B?UmFOb2R5RzdWclVpU0lIN1VWNTgzQS9UYW1uSFJjL2hlbHdKem9qdTdOZGVC?=
 =?utf-8?B?Q3JFOWNqVW8wREYzYnIrQzJrdFI4bWlpR1FyaksvZ1c0ekhVLytwOFdLQzRn?=
 =?utf-8?B?VnIyb2VmYVFOaFA4cUxTTCtzc1Fzc05weDg2TmZQU0pSUU5xMUdWU09zWjFH?=
 =?utf-8?B?ZkhOYkVVcVVTQkpDTHRhN2YxOVZDNUp0eGJ0dDdCdGE3UnpVY2xnM2tHUGJk?=
 =?utf-8?B?QnZ5OHg1NWJKSXhNV3ArNnd4bUFScWlSUG9MUGpiUkpJVVhkWDh3Uk0zbkRS?=
 =?utf-8?B?ZE9Ma2hYMUZxMnE1blBSb0I2UGFXeGk0QmhQOWdKVHlzVHc5bVgyRnEyY1d4?=
 =?utf-8?B?SlVkTkptZmJFc21JdXNGTDVFTjJTWVVDL2pIRSsxYnArRFNyUXRrU0tyOTVy?=
 =?utf-8?B?elBrZzF2ZzBXcC9GeDlsL1FGNUJSVUorT0l0UmRDMGZENFhWS08yZ3pDU3hO?=
 =?utf-8?B?N0FldDB5bFlnRDIyRFdBSlAzNjYvbGpEVmE2RVUzYUdlWU1IYk9XTUhzbmo4?=
 =?utf-8?B?QVNoODJYMUhrWUY1cCthTEtFWk9EcktFU3FMaW5EdmRvVUs4d0xJVUtxVlFp?=
 =?utf-8?B?YjMwb0lxMDNmaEpSNUZoUlZmQTh0Um9QbmN2RkdlblVzKzBqaEVCclo3VXQr?=
 =?utf-8?B?TkhQYmNQL3JVR1Y3VGxyYmlrdzRocDhOeHBDeXRaZjh3ckxXcjJxS0pkdGd0?=
 =?utf-8?B?WDZWNDV2NlVhenh0K09CZWlGaUxJVVliNjc5UUplblN6MHJUN05BQXZKZWw0?=
 =?utf-8?B?VVpPZjBhUm9CNWxTZTBiVDZxa2tyd0wyMENvbDIyVDJTamY4V1owQVZDNGNG?=
 =?utf-8?B?YVRmbEZuSzNsZDJzTDdqQ0NGUDNjZmZDVWM3eU9IV04yS1kwNjVmbjg4NnZr?=
 =?utf-8?B?VU01OVBCZjQ0aWdpVEZ0L3B4UXU4ZWVYeWdMRnlHc3NmUGdkT2IvclhOYllM?=
 =?utf-8?B?Q2EwNkZaRTZvcmhRazlUeXZRMk1jWlpXY1NPR2JqbHVkeVBJVWdFQVAzcVlU?=
 =?utf-8?B?TTVqdW01bWZPUUgzN2VCbkVKVlc1MWhoZkIyMzZ1bWRJLytadmNnMmo2dzJM?=
 =?utf-8?B?QjI2VzMrU0s0WGdiV2NvQklVVFJCOGg1UnFubTR0S29Idm12MTNUL09Qamxk?=
 =?utf-8?B?dmxjNVJLZnI2OFlJMDZYcWE3NXdQejZHZFc4Tm1TNjkrNzhUR2Q0SGlxUXZu?=
 =?utf-8?B?ZlRBVkd3NkFiTUc4Yko4aFdEWUEydkFKejgwbzhUK3pRYWFhU1VpazJoYzlt?=
 =?utf-8?B?Q1RzSXB0VHJaenJKdmhXb2MwRGVDTUVRd2hTd214QUJiZW1WU1pldHhFNXhP?=
 =?utf-8?B?RjI2TWxGVk1oaGNFMFN5NlRjbndJbm90S05welNFUnhiVXN6Y2QrM0hIL1F6?=
 =?utf-8?B?UHNFNUFab2l6cnhzVjFQY0d6aFVWb1JZbHIwRDBZVmxOaVlzai9ibjl2OXl6?=
 =?utf-8?B?ZUtMV1hrakJVcEV4TDJMWFdkQnl4TDFwbTVXU1E5NXBIS3dkSjN6VXFGV1hY?=
 =?utf-8?B?MDZlbmcxN3AvRjJQaDJ1UnZYdFF6bUpOM2ZLVGNOQWUrTnYyZUM0NnYxWDR6?=
 =?utf-8?B?SGoyRHY5RWk2L3ZXdW9vQ1NOQnR3SDFrb1RlQ2ZYNWJ2L1VyVzkzZ0RWaGdx?=
 =?utf-8?B?b0pkdUtvVzNnbnpzWklFM1EzUk5Db2l0bWV4Rm1nZkdFeHAyeGV2cStNWWxL?=
 =?utf-8?B?ZUZJMWIzSGVLM2g4MXZwTmMwM3pRRHhaQ2NyKzZIb3IydUZYeTlhRjdRZFJu?=
 =?utf-8?Q?KoD9zpbn+eloHBJzl/1A10MdH?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	/znW8YBEEuW+WFFC2Te3/tVPtFalnH+x5+/GEF8aP+R2FiVw3Z6rhVF0E11+Z6+YY5XBapX28wrV0nYaChmtllPU0v27se43VJgOsHm0mR2q9NkJFvhiYKzSxAYd4vD0F0L5UJtzuaDMUvi+cDgTiWbwj7U5m+Mm4cs1+veTrWzIiF4TUjuxq7MyZy6r/bGPeW/OxGRB/uEeOOFBuU6jKjUAfH3LlOUVPvPpn5IKMlPSIKuex7axFh0nBzZS/nYcpw8wp5CIQviA8Rgn43SOti2w46AbZINI5/pRHMojsq8sz7CMJRQw9MFiOcShtSMdTOi/Tv1xPerrAfkCzivyeWxhoUeePPQZJ5AjEFYRDTyN27+OL5GgE7RPdskDa3aMcpz6AB9f6PudL47U3MrsOme3gFdGAlSWFJANVJKkIXEJG2tioDMqMrcVCBU18TtPc+cRP217KbHW4n7TJE5sS0o5sp+xYLJlj0NNcZHtXF6hoRsZNseVUTf6rlrP0gbiK8RKPtgjSQAyEQfTGDiO8tsZW5wjwHMQzfLKjBLPuPLEgcVilnSBw+UeLRPChPeOHN5+tPxxY2dN0o316SSdaiSLT3Au+Wg1dvz+CXTMHQw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e8d98375-e122-4d7a-c3ea-08dcf73b0a98
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2024 10:26:53.5108
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nHQoiiyAtPhBAtdWOTv4TAREDZTNa9dT+bqNpmIaL6IGfKmd08YhIjVinVM04Oo7zKteBjQQMV1OOXbJDQuuQA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB7425
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-28_02,2024-10-28_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxscore=0 adultscore=0
 mlxlogscore=999 phishscore=0 bulkscore=0 malwarescore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2410280085
X-Proofpoint-GUID: s-WfujEQ5hBbHi9yhHTyS5yNWI01eXB_
X-Proofpoint-ORIG-GUID: s-WfujEQ5hBbHi9yhHTyS5yNWI01eXB_

On 28/10/2024 09:07, Christoph Hellwig wrote:
> blk_rq_map_user_bvec currently only has ad-hoc checks for queue limits,
> and the last fix to it enabled valid NVMe I/O to pass, but also allowed
> invalid one for drivers that set a max_segment_size or seg_boundary
> limit.
> 
> Fix it once for all by using the bio_split_rw_at helper from the I/O
> path that indicates if and where a bio would be have to be split to
> adhere to the queue limits, and it it returns a positive value, turn

super nit: check "it it "

> that into -EREMOTEIO to retry using the copy path.
> 
> Fixes: 2ff949441802 ("block: fix sanity checks in blk_rq_map_user_bvec")
> Signed-off-by: Christoph Hellwig <hch@lst.de>

FWIW,

Reviewed-by: John Garry <john.g.garry@oracle.com>

> ---
> 
> Changes since v1:
>   - correctly shift the max_hw_sectors value.  Tested by actually
>     checking for max_hw_sectors exceeding I/Os to fail properly
> 
>   block/blk-map.c | 56 +++++++++++++++----------------------------------
>   1 file changed, 17 insertions(+), 39 deletions(-)
> 
> diff --git a/block/blk-map.c b/block/blk-map.c
> index 6ef2ec1f7d78..b5fd1d857461 100644
> --- a/block/blk-map.c
> +++ b/block/blk-map.c
> @@ -561,55 +561,33 @@ EXPORT_SYMBOL(blk_rq_append_bio);
>   /* Prepare bio for passthrough IO given ITER_BVEC iter */
>   static int blk_rq_map_user_bvec(struct request *rq, const struct iov_iter *iter)
>   {
> -	struct request_queue *q = rq->q;
> -	size_t nr_iter = iov_iter_count(iter);
> -	size_t nr_segs = iter->nr_segs;
> -	struct bio_vec *bvecs, *bvprvp = NULL;
> -	const struct queue_limits *lim = &q->limits;
> -	unsigned int nsegs = 0, bytes = 0;
> +	const struct queue_limits *lim = &rq->q->limits;
> +	unsigned int max_bytes = lim->max_hw_sectors << SECTOR_SHIFT;
> +	unsigned int nsegs;
>   	struct bio *bio;
> -	size_t i;
> +	int ret;
>   
> -	if (!nr_iter || (nr_iter >> SECTOR_SHIFT) > queue_max_hw_sectors(q))
> -		return -EINVAL;
> -	if (nr_segs > queue_max_segments(q))
> +	if (!iov_iter_count(iter) || iov_iter_count(iter) > max_bytes)
>   		return -EINVAL;
>   
> -	/* no iovecs to alloc, as we already have a BVEC iterator */
> +	/* reuse the bvecs from the iterator instead of allocating new ones */
>   	bio = blk_rq_map_bio_alloc(rq, 0, GFP_KERNEL);
> -	if (bio == NULL)
> +	if (!bio)
>   		return -ENOMEM;
> -
>   	bio_iov_bvec_set(bio, (struct iov_iter *)iter);

totally separate comment to this patch, but I think that 
bio_iov_bvec_set() could be changed to accept const struct iov_iter * 
(and so we could drop the casting here)

> -	blk_rq_bio_prep(rq, bio, nr_segs);
> -
> -	/* loop to perform a bunch of sanity checks */
> -	bvecs = (struct bio_vec *)iter->bvec;
> -	for (i = 0; i < nr_segs; i++) {
> -		struct bio_vec *bv = &bvecs[i];
> -
> -		/*
> -		 * If the queue doesn't support SG gaps and adding this
> -		 * offset would create a gap, fallback to copy.
> -		 */
> -		if (bvprvp && bvec_gap_to_prev(lim, bvprvp, bv->bv_offset)) {
> -			blk_mq_map_bio_put(bio);
> -			return -EREMOTEIO;
> -		}
> -		/* check full condition */
> -		if (nsegs >= nr_segs || bytes > UINT_MAX - bv->bv_len)
> -			goto put_bio;
> -		if (bytes + bv->bv_len > nr_iter)
> -			break;
>   
> -		nsegs++;
> -		bytes += bv->bv_len;
> -		bvprvp = bv;
> +	/* check that the data layout matches the hardware restrictions */
> +	ret = bio_split_rw_at(bio, lim, &nsegs, max_bytes);
> +	if (ret) {
> +		/* if we would have to split the bio, copy instead */
> +		if (ret > 0)
> +			ret = -EREMOTEIO;
> +		blk_mq_map_bio_put(bio);
> +		return ret;
>   	}
> +
> +	blk_rq_bio_prep(rq, bio, nsegs);
>   	return 0;
> -put_bio:
> -	blk_mq_map_bio_put(bio);
> -	return -EINVAL;
>   }
>   
>   /**

