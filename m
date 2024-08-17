Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EC17804
	for <linux-block@vger.kernel.org>; Sat, 17 Aug 2024 15:33:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723908829; cv=fail; b=rn9zmOu6S6FZ5M9uHrWLEhXfvZ+bp0V+lhKe9FE70Iv11Cmnl6hNUOC8fJm7fVAwEInChzlyfPQ82eo7oEqwn8nikEgz9JzUY9girIJE+tdR4epTRSPU0cdAJ5hZWbCokgK8cdDUlMEdhLRhje5APK4tQ9F6vZ8PW0uaomwIOmE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723908829; c=relaxed/simple;
	bh=R3LQbk1Vf7cqctEBqJd5CLieC14uxBqHKK/s81ZfuAQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=AbqP+70ouiCTOvqhoXKxGTM4k48oMimn7PRVY8QGEMZtBSmZCMgv2k6azlHjNVy7ww7Lv/AhJTtw5cyCnieJl8qloS/xPr90ece3I+WzPuYc8VlywSTy+yLozLFxtiCtuoExzTyOiQNzD6Uews54e6U/2YVKs6NshqWqUkCiDz4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=K/tPHboN; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=uk2cSW/m; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="K/tPHboN";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="uk2cSW/m"
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47H6es07028718;
	Sat, 17 Aug 2024 15:33:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	message-id:date:subject:to:cc:references:from:in-reply-to
	:content-type:content-transfer-encoding:mime-version; s=
	corp-2023-11-20; bh=pfvYfjWB9uXRrZOCIsLbKQtTXhIzBFXBUK23GgdpNog=; b=
	K/tPHboNCs/47y0WEPkxmyz+hP+iPaUQjG6VqAA6GZ40kvxjGG5idnQDj/TbPFl3
	0HSZmWROeofrnHWI3LCkoy4h5Os3XHVvC80GDPIVCJIQpSF2LXQLLPcpQy6sTuDB
	R748o1N7GNfUPWAKVV/tLpYWzDVIZKYe1Hn34pV+pXmk08hNbDfDeNj+sh7xPk1L
	ltW2Upc5mWEwvQ/K2rmJbm95iSdzxgmjDwIlvZ606rJi6fWheF+2RmSHQ6Bcbr/R
	xbFHYObRpe8uRxy+kOtBH+cWtwPHia3Vlisp6VKyQST1V+n8Ct4KmZskZeuYrLdN
	SwOyIqsA6C6ZtNZToClJBQ==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 412m4urd71-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 17 Aug 2024 15:33:31 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 47HBU6S7022117;
	Sat, 17 Aug 2024 15:33:30 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2045.outbound.protection.outlook.com [104.47.74.45])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 412ja64gnj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 17 Aug 2024 15:33:30 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ojalDnNAFf8w1HAYQ3cxlkpOdnHSXcgn4MkMI+FHLOqPc1XmOiYxXWYZ9TI2v2eWdd88+zW9xmsmOVpGbVKBaINNv05oD2j+JXG8L55WjVQep6AufzWylju23dpPTRIbW9MvBorQcUslxFb/fH3Hsfk30aAHLHokalJ+NsNwIfvOKcn2/DsTbfLDY7PUN4NsDkHKGMis5ni00Nk4bDHpQNML/WwZRjlmJGBdhrIqQXlQsRREFDhCwb6oxsc5GoElDbfVkw6Jf9ah6vD6HORBRlPalWmXakh3Mg8D6zORZ1DzddsmD60tG83Spbq06i8mAOshcFG5P3UIZum7mUrEJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pfvYfjWB9uXRrZOCIsLbKQtTXhIzBFXBUK23GgdpNog=;
 b=t/hyCFp7wGuklsTg+4TG8fOrc+e4qkjry1EjLamyxqr4jc7wpzABW312XbstEnSArcRVrHaFEyiFDEbkTl5GBN6DTR7VXqbVqsZUd97uU1cD/pfVHshy0QFa8AJJ2MwKHxLtEkdhwp8l+grst0Gy0X1gsDn34YVdukfQh+ysDIInBbR+nRQvSoZDd02NGBsGe8MmkeXEgPwI215dzsj1RmOkLldsVcrVDYHRJwXvSPrM20Y1WYTb/KsfZ6xDmSNmwqQ1/QLhG6UH9yTE5S6k8zdtRVvy/1wwU0KwUJ2z6cFcwMhw6luH0+/DEC11jazhHc6+2C/Nc+itF5h2vzNcFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pfvYfjWB9uXRrZOCIsLbKQtTXhIzBFXBUK23GgdpNog=;
 b=uk2cSW/mT27+97JTJQ8xNO4FdaKiIufPRdYYI12iT7GBKuwZTEr0enz30/dUujlNHFQGswDn8PxLq69EgNYdkEZzy+htg9XNdTQXB0g5WPozu9S0EO1cGVV70ZVplLS9sULPy2KDlBTkLRXGnd9eUfXGvWZ/jjQF/laiMRnbgOo=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by SJ2PR10MB7013.namprd10.prod.outlook.com (2603:10b6:a03:4c6::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.11; Sat, 17 Aug
 2024 15:33:27 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%6]) with mapi id 15.20.7897.009; Sat, 17 Aug 2024
 15:33:27 +0000
Message-ID: <5d2f21e4-1496-4d03-9c31-cfc57fc9c8c7@oracle.com>
Date: Sat, 17 Aug 2024 16:33:22 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] block: Read max write zeroes once for
 __blkdev_issue_write_zeroes()
To: Nitesh Shetty <nj.shetty@samsung.com>
Cc: axboe@kernel.dk, hch@lst.de, martin.petersen@oracle.com,
        linux-block@vger.kernel.org, kbusch@kernel.org
References: <20240815163228.216051-1-john.g.garry@oracle.com>
 <20240815163228.216051-2-john.g.garry@oracle.com>
 <CGME20240816184134epcas5p3b673a0619a2e696f845ee09ab7f5a087@epcas5p3.samsung.com>
 <20240816183129.a2uwtlkbvddg5uxm@nj.shetty@samsung.com>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20240816183129.a2uwtlkbvddg5uxm@nj.shetty@samsung.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P123CA0310.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:197::9) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|SJ2PR10MB7013:EE_
X-MS-Office365-Filtering-Correlation-Id: 7973617f-7c65-4288-3b00-08dcbed1f01c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RmlNVUxtbmtZNHpSOTIvSmR2Q1NXSWU3NXI5cU5TM3ZJU0I1S1dURk94WHJr?=
 =?utf-8?B?TTBQMXJJR084T0tYWWsrNUVjTmhPKyt5TlhTcWN5UHJCR1dqUjR1b2xSblRJ?=
 =?utf-8?B?VGw1cWwya1MzbmJCWTNFV0VYcmpobkQzWFRNbUNKV2hFa0d3SVZkWjVyam9r?=
 =?utf-8?B?cCs4SGNMUFAyWWphaFBENFRFUTMwQWkvODdMS1V2bjM2SGRpSWxZaWl4d3FF?=
 =?utf-8?B?SytzR1R1U2ZPUU9DVWRZMElrYStNZndFSVhwYm1VVkxSNUZnS28yY2l4WDZm?=
 =?utf-8?B?d1JtcHhWVlN5ZTl4SGs5R3NBUmp4dys3bXI1OHI1aVAwY3FWMkVZdmREU2Fk?=
 =?utf-8?B?REcxcisra0NVQmhLRFB4QUd0UGE3bTVFVWMrNHloZ2Jhem1MbkJEMmpra3B0?=
 =?utf-8?B?SjdTSjJRRGFXb1RXTFJnUEhxd0I1UG13UmtwNnZOVjJGWkJuOHo5SnFuNWdx?=
 =?utf-8?B?Nzh0WERFaHNXaUlwajdiVzUzOUlDUGk0bDRscEovK1lEczVpQ3V5T1BLNHNK?=
 =?utf-8?B?eEFyVGJBanJBRU5uMTNSUUF2Q3VVNThqeTk3OU5tcmJIQmFrSDFYbmJCOVVZ?=
 =?utf-8?B?M1BqVlpPdVJzUGdINkVFYTJVZDdhaWwwWlBFZkhodW44OEY3RWpWUXNMa0pE?=
 =?utf-8?B?bW1hd0R5cklPV21KTEtUVmc3ZURxN0FDZXJTRU9lZHZtNXJaZkQya2lpK0VI?=
 =?utf-8?B?aUJXVyttdStKN1JxdzRUSVZQVDUxRnh5Ui8xaXBBdElZbGhEcmx4bUxPQnVy?=
 =?utf-8?B?Nm84bFgxZVBtL2RxNFdVM2VLVHNGcTJkc2QzdUZmQWhNTXNTTHhXZTZjWHl6?=
 =?utf-8?B?QVBUdWgrYW9IdkhaWXJCNXV1RmRMSDJZRURuV25WUTg5emRTRzlwMjNwQkp4?=
 =?utf-8?B?alJNRytlOTBqT1V6SFI1ZVVsUDF0N1l1ckhCM3R5c0hVUVVNVWFwdjhiRDkv?=
 =?utf-8?B?UTQyT0pGbXgzbUF6TFgzbkJRM2FrQ292Zmt5ZmNRWVRpWW1RODVGOXhlU0RN?=
 =?utf-8?B?dG43NnZHR094UHErOXlmaXVXNGZ2dGw4eUlYZk0xajZ1c3YxOXAzQTQ4djdk?=
 =?utf-8?B?T2VJckZ1bzhNQy9LT1JQaiswUStGc1gyYVV0VG41SVBjcW15dGdqaGJib0Ir?=
 =?utf-8?B?WVkvNU9jNFd6L25COW9seXBtbURiSzM5aGcxSEZ3L2p1WEhCSFhNYlBtMnVn?=
 =?utf-8?B?dW9UUVNiRTNyS3U3ZUhIVTh0cE9UanpWZFluUml3cUE3TzBIN25iWXhpMVR6?=
 =?utf-8?B?ZGd5OVJJZG1NOTZmWWtOWmdsMWJReFRnSHVGQXRiZG84bWdJcHdDcGxVblRZ?=
 =?utf-8?B?V0dwUUtVNDJFdnZBdzZsRzNIYjBoSCsrM2NGTVhoMHV5UjVsTmYwRXVZdCt1?=
 =?utf-8?B?Rk9YMTAxL05qT0hkb1R3NUUrZ2VNNW1wRHo1cXlrUGFORnlpdFVENWk1QXJj?=
 =?utf-8?B?amxHNmNzelFSVUhsMG5rVGx4bjJxTTJMSy9ENVkzaytrOTlGRFdJcFdBQmww?=
 =?utf-8?B?QXpqUXZicW5jeW1QRnY5anR4TGJ0M2NXaStmV1RZbk5oMFVianVNZjNJeitG?=
 =?utf-8?B?elRTMEQ5cFJJaWc5dkdwUFA0MHBxc2tXcDRybzNPd044c3VEUWFlbmxkNCtn?=
 =?utf-8?B?NEJnTFdVMnh1MFR3MGowOUtKbDhDWUNnWTk3eFJ2UGcwN1VwWjRlOHA0bEVN?=
 =?utf-8?B?d2trUStRYkFpZUdNWU9vSXc4eFI2ZExpSzZGWjJRM0RrNHdlZnZSbkRvY0V3?=
 =?utf-8?Q?4sQ0k6GhSmuN0G1oOw=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bFExbzljWkNZZGNudlpJbldYTHg5NXVCSWlTTDVqdEFRa2l5WHFBYkVsRStZ?=
 =?utf-8?B?Y1VrWjRobzkxLzNOb1dhVXlVZ3ZFYXpuMEtpSW0zYmFMalJYYm04bXFmNE5m?=
 =?utf-8?B?THVpV1dTNHZXQ3daT1UvNCtOekxqd21mZ1pIQXU1QW9KcUlUd2lHRU1kM0Vp?=
 =?utf-8?B?RGgzQVFoWGt3Q3prbmV5TkhwTDVERDg4RHRGZFRvdXhValRubTJlK1QzVzhx?=
 =?utf-8?B?Y2ZQM0hRQWV6RGJ4cVI2NThvbkxIL3FNVHZoc3NDSjVDWlArdWloUS9KZzd3?=
 =?utf-8?B?eXpYMisvUmtmOWJqQTlnM1pRa3UvbkhCVXZaNUo3L0Z3VHZCSU05L1Q1c0FP?=
 =?utf-8?B?ejdJOG1RWGxweXlpRW1MWUpUbEUzTGxCY1dTaHd4eDg1b3crR3JGVmUwVGJ1?=
 =?utf-8?B?NGVManprRXRZbGtPb0hrOG1qN3hycTkxVy9xVGlNY01oMXNMRVlGcXlxMXZr?=
 =?utf-8?B?ZHI2N1NSS1JIb1VLbVVZeEU2a2ZubDJDTnVzNGZwQ2lLN3ZFdzBaZUZsZEYx?=
 =?utf-8?B?b210cGNqZjg2aDgzWS9kTDhGQ245NWEvQk5EU1ljMENwWXZVL0I2aHNnTmlj?=
 =?utf-8?B?YzVGQlFaR2E4MHQ5Wk1EYjFSQUlUUDc3QnZXRThEamJrWWFOd3NuZmJUZjlI?=
 =?utf-8?B?aFVJcTBhVlFWSm9GVU9LVkc5OVpwRHZaS280aEdTcDdkNEpXZzlBSVJwM252?=
 =?utf-8?B?WkR5dThpbWhrSUV0dG05aWpxdlJaMG9FNWtUb0pFOHV6Q0toTEJ5RGZHOFQ5?=
 =?utf-8?B?YTZsUk9PUlI1TjBzOW9mM3ArcWQyZkpGZ0N3SHlYbVV0NkxybEFob3MzY0s4?=
 =?utf-8?B?REc5SWxxSHNDVVFQa2ZCcUF0T2Y2STVMVHZ0ckg3YStGcitXZ3Y4NnZuWTZU?=
 =?utf-8?B?U1BVNXhCeU11SU80VlUwKzNDeDVWMlRabnpzaEF0S2ZXZXUrRFNmRzhPeXN5?=
 =?utf-8?B?YTFCQW1EaFRjdHRJb3BDM1RrUnZqWTJvYW1Cd3hvZXora3BvMFlsVEVFSlZm?=
 =?utf-8?B?Q0k1czdQc1lxbkN5QjRqZjQwcURLRjl2Uy8zcWlYbi9TMzlFenNucmxlYUtU?=
 =?utf-8?B?emlUREZWR2NmM0lFcFFmVVpYMndZS0RpN21aUGY0STZ3bGlGeS9VWnJpcWxL?=
 =?utf-8?B?TExXVEVBdGxLYWFNM0JlRE9JaFRMN0hqc1ErcVB6by9xY3NqS3ozMjRGS3ly?=
 =?utf-8?B?MlBBbHBlSDdmMi9DczBVaUZPUmRZWnYvODVPRTBHV2FHNFdMTEU4Z25NZkps?=
 =?utf-8?B?Q0lsY0lYTy9uK0VYWmdld041TGdSb3NLWVJPekt2cEpweTNJYlVudGltU3Nu?=
 =?utf-8?B?eTVhdkxDSjlEOE9iL1V5VFR5TFoxQ0JMTVRRNkFpZkJ4dm51VVZKNWZMOGRH?=
 =?utf-8?B?WFErNUNuL1VtV2dlMmZ0eGdUYkxwamdiVFljZi9TZEJhUGVQd3ZFeU05SDFq?=
 =?utf-8?B?Ri8xYVlzT0h2R0llckhFNW93NVdkTVBPN29vNUdtMVRHS0l6UlNjVEhqZmRO?=
 =?utf-8?B?VFU5SlVPNEFnaFNaQ3JMSFFMWndhR1UydjA2NDZJTURWVWxDK0o3Qy9abzNX?=
 =?utf-8?B?VHQrdTNkZ3FCQm85aHNJUERkSE9ncUhYbzhsWGlxc1JvMGNkYUxBQlE4TDFC?=
 =?utf-8?B?WGVOM2dzZjZCeWFvemQxdEJvbUFNMVA5VHErT2FIcnR2TW1lK1dMdWxZbXRk?=
 =?utf-8?B?bjVtR1JaUXE1VG5CT1RoeTBIbWFPZDg2SzA3ZnBxeDlhaUZVcHBZd05VRnN4?=
 =?utf-8?B?ejBuV3o0OHF2MjJ0N3JWc1J2MW5ZVC9TWFNtWnVMamwxK1drZGxYWi9TeXM3?=
 =?utf-8?B?Q0VYM3NTMzFnOFpGMWZhTzJXYnh3OGtJQlQxTlAwUUkxZEhFWHVVOXZVajIz?=
 =?utf-8?B?Z21aenY3aW1JQlYyUCtlcFJCRVgzbllaUUFMQmJWckJhLzJqVHNRUk85dTVW?=
 =?utf-8?B?VWhqbmNTc0xHa1dtdDJ0YUMzTDhuWXNJaHp3VEtYRDJuL3JHNFh6UGJyMjNP?=
 =?utf-8?B?aFFYb2dEdlpiTXkrOUpsaEFpSkVaQUQvLzQzMFh1a3VpM2JHa0tpRVBsckY1?=
 =?utf-8?B?ZldFMHZzZ2h0a0dXRFV4ZmdPQkYzTVNuK1VYendrZmsreXEwMXdmZnNvR2E4?=
 =?utf-8?B?MEdjWEhaTEZMcjZpOE5STDI1Zkxid1BicnovVitVZXp4ZWZkR0tFQVFLdTYx?=
 =?utf-8?B?NWc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	4SmBAILb0C4a+9P7R2Km5Kds9q+ETDqVWj28RbhbXiNywpWFlnaTaoSlr9Guq7vWDqUiE0c2eCruxXwgLE18nIMx/cCAkHt1Lr1t3ZI4fgvG8cIXVo2awNxjcvAv8CNL9kHV48dHWg6Crp2YZx88HCSfSM3jlzzscQVYG16FS6H3im4J7whIXpMd8ZAd887C3c17uXYPzCn+NI3QhwewBaKD5jnw2kJ8PdlBJ2cSeLlAbuNotIqc7bej45tH0EYXO3l1OWujto01a6rckyOt6fxa7gPjfPu2HiP6xcejM7hehcHMlLvo2f7Vl3atJjXFnXEnXTj8JxSu4nJ2g/6gxiSS4cKab5aliUZZih+mcvE6F64lEyx6SGRq2Em5U1+LEAmrTteWi/k0X4QaWqVZMEkVhcMBdSMWu0F+xJUvFdTlyhmDjXmEdpAA2jJLXdapqvmY647VDTPGK7gsjoos3v0iirK9XOlhPe8l3Q0YfMXjTPeXMHjVMel10VO4jt51pq/c8c7znoI/ctLxjXDLHZU53r5M43Pp1ZqBocoWpNtUpREpElIaQcTjDxf05p5ELAniI80pDSzqPasSzLioexcDo9nLHyZn6+lAiijRxbs=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7973617f-7c65-4288-3b00-08dcbed1f01c
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Aug 2024 15:33:26.9437
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Yw4/d8srXr3NKMvYL/AeNR3ZnguvX8Xb2xjAT4zmJzQbJH77D78otqiEe1lD7mVsvWsMhX/kv9W3sI1gWk+zJQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR10MB7013
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-17_10,2024-08-16_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0
 mlxlogscore=999 suspectscore=0 mlxscore=0 phishscore=0 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2407110000 definitions=main-2408170105
X-Proofpoint-ORIG-GUID: hEtBMj_aWCrTKAhQ4NPULAIh0xRywmIY
X-Proofpoint-GUID: hEtBMj_aWCrTKAhQ4NPULAIh0xRywmIY

On 16/08/2024 19:34, Nitesh Shetty wrote:
> On 15/08/24 04:32PM, John Garry wrote:
>> As reported in [0], we may get a hang when formatting a XFS FS on a RAID0
>> drive.
>>
>> Commit 73a768d5f955 ("block: factor out a blk_write_zeroes_limit helper")
>> changed __blkdev_issue_write_zeroes() to read the max write zeroes
>> value in the loop. This is not safe as max write zeroes may change in
>> value. Specifically for the case of [0], the value goes to 0, and we get
>> an infinite loop.
>>
>> Lift the limit reading out of the loop.
>>
>> [0] https://urldefense.com/v3/__https://lore.kernel.org/linux- 
>> xfs/4d31268f-310b-4220-88a2-e191c3932a82@oracle.com/T/*t__;Iw!! 
>> ACWV5N9M2RV99hQ! 
>> KNrgu0c216k_Y_2RLxTasjxizyhbN8eKD61JwIwDxT5OJJDamER6hw1nvf5biNMqQLaLl9PqC2qRUDdHlrGF7g$
>> Fixes: 73a768d5f955 ("block: factor out a blk_write_zeroes_limit helper")
>> Reviewed-by: Christoph Hellwig <hch@lst.de>
>> Signed-off-by: John Garry <john.g.garry@oracle.com>
>> ---
>> block/blk-lib.c | 25 ++++++++++++++++++-------
>> 1 file changed, 18 insertions(+), 7 deletions(-)
>>
>> diff --git a/block/blk-lib.c b/block/blk-lib.c
>> index 9f735efa6c94..83eb7761c2bf 100644
>> --- a/block/blk-lib.c
>> +++ b/block/blk-lib.c
>> @@ -111,13 +111,20 @@ static sector_t bio_write_zeroes_limit(struct 
>> block_device *bdev)
>>         (UINT_MAX >> SECTOR_SHIFT) & ~bs_mask);
>> }
>>
>> +/*
>> + * There is no reliable way for the SCSI subsystem to determine 
>> whether a
>> + * device supports a WRITE SAME operation without actually performing 
>> a write
>> + * to media. As a result, write_zeroes is enabled by default and will be
>> + * disabled if a zeroing operation subsequently fails. This means 
>> that this
>> + * queue limit is likely to change at runtime.
>> + */
>> static void __blkdev_issue_write_zeroes(struct block_device *bdev,
>>         sector_t sector, sector_t nr_sects, gfp_t gfp_mask,
>> -        struct bio **biop, unsigned flags)
>> +        struct bio **biop, unsigned flags, sector_t limit)
>> {
>> +
>>     while (nr_sects) {
>> -        unsigned int len = min_t(sector_t, nr_sects,
>> -                bio_write_zeroes_limit(bdev));
>> +        unsigned int len = min(nr_sects, limit);
> 
> I feel changes something like below will simplify the whole patch.
> 
> --- a/block/blk-lib.c
> +++ b/block/blk-lib.c
> @@ -115,9 +115,13 @@ static void __blkdev_issue_write_zeroes(struct 
> block_device *bdev,
>           sector_t sector, sector_t nr_sects, gfp_t gfp_mask,
>           struct bio **biop, unsigned flags)
>   {
> +    sector_t limit = bio_write_zeroes_limit(bdev);
> +
> +    if (!limit)
> +        return;

Just this?

If yes, then __blkdev_issue_write_zeroes() does not return an error 
code, so can we tell whether the zeroes were actually issued?

Furthermore, I would rather limit points at which we call 
bio_write_zeroes_limit()

BTW, I am going on a short vacation now, so I can't quickly rework this 
(if that was actually required).

> +
>       while (nr_sects) {
> -        unsigned int len = min_t(sector_t, nr_sects,
> -                bio_write_zeroes_limit(bdev));
> +        unsigned int len = min_t(sector_t, nr_sects, limit);
>           struct bio *bio;
> 
>           if ((flags & BLKDEV_ZERO_KILLABLE) &&
> 
> 
> Otherwise, this series looks good to me.
> 
> -- Nitesh Shetty
> 

