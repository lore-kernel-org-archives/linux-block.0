Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3C09566A
	for <linux-block@vger.kernel.org>; Thu,  5 Jun 2025 09:02:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749114131; cv=fail; b=VEBg0b14cgtspARgOH9S+UNEgWJio71bnDVe6JwewWjgmyOUjcugYfPeogmHsaGPELkBSmdUOQAq0HIbfyzg3yqi5i8mBpBNe80n0q8E//ZM4sAsBTatPSfqTAiFwmlPNc+WZeib24I6WzCfIMWt0zkHrSBikZvCMmUirEe2zdk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749114131; c=relaxed/simple;
	bh=tlSCOyqJEmvbocCSIU90k8w/OHnQxEdyKVsmnl1oKpY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=APNSQ84GJ/CKTvoNTjD+YZXzOjG90WEUF/a/+eTHvJd3p6kKiwzGNQBgAIfvqgW/E6w+8oToJGUhj0oFyhyVRZHAQKeHNEV+gfBN2uve6lhH4GYce62OOQ2JemB8lsOMZyYOsgoNcX65mvq/QM/TJSNccJEuKdEQ/NXffELnKKk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=hEDUMy3v; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=UhoFqFcT; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="hEDUMy3v";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="UhoFqFcT"
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5554vMwU003039;
	Thu, 5 Jun 2025 09:01:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=qfudrCdqov9DNbPwCgEvVkzUgnTVK89vgcpfnODkXP8=; b=
	hEDUMy3vO6xomblfUuRwLkt/livF6C1K60z2AIiRLFepnlLC+nEUfqUbW7yQEDl+
	wvnfdADmHZPapdLVBM77AdRxueGQ/SNuYOiNIW+gfdTTvcBNouq+gY1i9NKJeB01
	wWoUre9PAknzC9/xuXjPnobCdMMuGvpM0geyLzYpawmVQWz5zUxn8iCP2vWxRY2y
	1db6uEPw0gE9rL6EtHHWn2kMpl5KnSzKliG4niPWOpf6KCxA/HdjhOni4zQmkSsz
	4QFzdoNtUc+h3AFJ42IiRxkd1+m6yX7iW27ZuBD9gy2xSG8VNc+Z9+gDO4x7+JWq
	l2IouJXvvlELQAePpkRNaw==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 471g8gdq4n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 05 Jun 2025 09:01:57 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5557hrsJ016251;
	Thu, 5 Jun 2025 09:01:57 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02on2077.outbound.protection.outlook.com [40.107.96.77])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 46yr7bu492-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 05 Jun 2025 09:01:57 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EwO8t6qOblidhcjMWTZzajoMwAp7yjdm/iXhEi3uEG3cnSm4n8vj1N+h+CTnlc/ggx14lwfYDb2AkjFXMwb1qDvdj5RXs3986nV6z+g7tl680hS8GeVUZnOzU30xsutLFSB5lt/fHe3wPhwGrVvKa7kNI4bSO8Cm48y+zclLRMJxzbHg8j8OjaLulYDyK9cx/a1lR9dDo938WtpavsZHoijsXxdPiD1gFB+7aYq7m8glkX4jWf7CrgR+uDvO7oscYtZKElRR2jRc5HdhbwDaGM1AYoS/yQhk630AkzZYj4K1riHjHEgX7/V6WIP+9aFoOlkde4ZqeWAFJH/LBJLqLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qfudrCdqov9DNbPwCgEvVkzUgnTVK89vgcpfnODkXP8=;
 b=VpS3omS07fofgkeBPlgBpIkGICQdN5atnweKrmG6AjCGktHBnhADuCJgGE1hk6py3NL8NZ8z3BZV2vdxuJkgCkd5NPHNbt/eM0TbMtrodCkC5dZRrDOHpRSF779JH0WP98BMc8moWcvKUXdS6NdJRdq85jaKmCd3eg1QgQ3RySXd5aguWYKQAxBVlMuQI1Hsxf/Ijr4MLP7RnjrMRNn5X4k0+5xkJ5092QVf8C1TjCaMjuzFT3DyMBHtooTBUs/Pez9leoj8GdVU4eybzK4E0zXEg4Rdq7NM7TKAZsJUsc3OEMUBzJ+mPsLBrCmyXy55Qca+k41OOmWDkyMm2a5b4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qfudrCdqov9DNbPwCgEvVkzUgnTVK89vgcpfnODkXP8=;
 b=UhoFqFcTCF9yiakPk5D4jM3RIjUBC28vyvehekofrWtvS7yZw95r6O42ZbrLzks0k2/p4ncRe7RoF+qngC6gnfiTox6Q5AcrhXI8PpfvGoAuN0Q/A/0CzakjS4i6szfGEQDgZLjA3SEdVh+fi3CNOQjN93ew86bhsjRUo3QWkkA=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by PH0PR10MB4599.namprd10.prod.outlook.com (2603:10b6:510:39::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8813.20; Thu, 5 Jun
 2025 09:01:54 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%6]) with mapi id 15.20.8746.041; Thu, 5 Jun 2025
 09:01:54 +0000
Message-ID: <4ab6d5a2-1780-4e81-8ea1-e5d93d651dc5@oracle.com>
Date: Thu, 5 Jun 2025 10:01:51 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] block: fix atomic write limits for stacked devices
To: Nilay Shroff <nilay@linux.ibm.com>, linux-block@vger.kernel.org
Cc: hch@lst.de, martin.petersen@oracle.com, axboe@kernel.dk,
        ojaswin@linux.ibm.com, gjoyce@ibm.com
References: <20250603112804.1917861-1-nilay@linux.ibm.com>
 <07cfb3a1-c410-4544-ae4d-5808114e02d7@oracle.com>
 <0747313c-a70d-482f-8ea6-ce2dff772c2c@linux.ibm.com>
 <2f2c8bf5-4341-4247-8a7b-f9ddd1d63422@oracle.com>
 <01e38aba-21ec-4507-8e5f-392838e8b937@linux.ibm.com>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <01e38aba-21ec-4507-8e5f-392838e8b937@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P123CA0592.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:295::9) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|PH0PR10MB4599:EE_
X-MS-Office365-Filtering-Correlation-Id: 6351cf43-709c-44ae-3913-08dda40f9e45
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?V0RldzBOSFBQYkcrRmExWG9ITDEzVmg2NW9HTjVHTkxNV3F0Zm80aWQyRTJ1?=
 =?utf-8?B?WFNuZzdYanczY2pTVkZSYUt1eUNjMHZRemd2MnpxamducEV5eCs0amt5bWtl?=
 =?utf-8?B?aitHZ3lPY0dnbjFuTlJrQnFnZHdTaWp4NzFFTGJtcXQ1UW8wa3VqSGRyby96?=
 =?utf-8?B?ZGFjNHo5TGp0bDdIN2Q4RE13RVpXc0c0U2RhVGZqYU9NeWJoSFBjV2VuMTFO?=
 =?utf-8?B?MnBuSlRjN2NhZmMrNWhQMjcvOVdDQkgvZXlUR1VQZXA3a3ZseDNmcFNYaSt4?=
 =?utf-8?B?a0VPQU0zTjlVeUZ5V1FjcDlsU1dVSVd1Y3Vnem03RUxqeDlibTBxNjRSb2Q5?=
 =?utf-8?B?T3FiQi8wdzVWNVhVNXVOT2ZUNmlYV1JQQWZyRFNaRFdsNzNGMElDNzNqQXRv?=
 =?utf-8?B?NW1Lcm54OGRDTHUrT0VWQjBUcWVSaXR5UUNENnRSbDNtQlI0N2ZLREVTb2d6?=
 =?utf-8?B?QnlmRU9XcFk3K2JsMU9sUHpnKzJUYVZEZi9Gei83ZFNpWFFLbjRMRVEyZEdM?=
 =?utf-8?B?Z3pGV3d2S0xqY2xPVmpNSlNlczJNeC8zZmU5M1J1anplbVRnSnpKcHN6bVpU?=
 =?utf-8?B?QUN4bVBvMm1uU05rWkZUVVlNdXRrUU5SOEhVWTlpWk1hSmZ2NjFicWdwbjZI?=
 =?utf-8?B?YWwxRzhiR1J0Zk42TXVFdmhwQlNNenJIc2M0U3dsQjU4MVkvTDlxMHNNUDFP?=
 =?utf-8?B?ZTRaemxvbHVnY2lCQ1pJR1NKMmNFRkZmaTJkTExQaWhacllNWml0WHVQNlBo?=
 =?utf-8?B?Wncwb1pLT2lEWGp6ZFZJSmtnbXV4cms3Q2ZNd0M2cVQ3aW53Tm56VVlHNjJJ?=
 =?utf-8?B?ZXRMV3JKMkhSU09hRDErdDJLSjQ4aTFHeTNkQXZtT1hPZDNRRFNrNSsxR09X?=
 =?utf-8?B?U082b2prbGk1U0tIem8zeEs1NzRFWmVhSTlHTTRRTHBma3plN0tMMjRSTEI2?=
 =?utf-8?B?aUk3S212Mk9nUGluYWg0aDlOaUdqZ0ordmlVZU1vb1ZtUzZzYkZNcFNMdnor?=
 =?utf-8?B?aFlkcy9hSFpsV2ZBMDh5Rng4K1V6WUw3RXJVV3d0Q0ZpbWlYMVFSM3IvT3Y3?=
 =?utf-8?B?Nkw0V2l6a3VvR083SGdzZ2R4VDVzUGw5L0gyNXdJQjlZd3VHcFdQK2NZV2JP?=
 =?utf-8?B?bHh3amYvNWZZcFRJSy9hSTg0K3EybDhBNm9haGNQN2lCa2JHdlJkcUg4eWg5?=
 =?utf-8?B?cDlPYzk0U1JGUWcvUUFqeXNpc1dSUmZoMlZkSGc2Z3FqNzN6L0lFZVFQZ0ZP?=
 =?utf-8?B?WGFDbTk3R1diZmN0cnRJT2NzcEN2Nndva1BLRThjQ05HWCszcktHbyt5Q2kx?=
 =?utf-8?B?aVY3UHloMFZuM3ZHMHVGYUF6MVNyZ2d5Q0s1aVR3dGhYSDZCSE1jMkh1Nks5?=
 =?utf-8?B?VklYQnFMdG5BQ2M2bTQ5aEhXMHU4VlBoVzRESzNPdEJPRU84VTNYTFpsTUpJ?=
 =?utf-8?B?RGI4bUJ4OUwxRm00dm50b2lGYmxPUXRLQ0ZoanNLRld2OGRQZmVUc2Z3Wmt4?=
 =?utf-8?B?eU5qOXNLSmE3WUdNbWQrRVFEaGliTGVWaU91SVZzN2pqYkx4dmc1S2xhVVZL?=
 =?utf-8?B?MnNPTEhlbzNNUE0vUVRPQ0V4NEJSek1JbGVvM0tlLzFBWVRMQVYxcFpCR2ZO?=
 =?utf-8?B?NzZVTmhqM21uRmhuN2Z5NGhPSTh0R29XT0JMQWRwSjN0eDFSUWljOXIveTJJ?=
 =?utf-8?B?ckJaWHNvUHN3NEszbld3YXhSY05kanM1c2twU3BzcldOVGVPZHhCSytWY0Zl?=
 =?utf-8?B?ekM5VldkQVlybEdrcnVscVBaS0xvRTd1bFBobFgyVTBRWGVQZGZsbEp0MnJm?=
 =?utf-8?B?MkJhMVZ2ZXpsNktGYnlPSFdCMXZQd1J0Z2swVDNRRE9Jd1dPcjhodjdlT2lt?=
 =?utf-8?B?d285VmpGUDdVU3N4c016UW5LWG9LTUxqNVQrM0tLSHF2aSsyNUZhRDVHSkNU?=
 =?utf-8?Q?vvoCSgZ3a5A=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eGpIOGxDU3JnVTAzR2hSdjRkcU5kZmtjMVRjZzZGMjlVVno3TjhVVHZ5UTJy?=
 =?utf-8?B?SDBwMzF4aWtMYUNYdzlGRUtkZVRSdlhGV0V0VDRESlhUS093dG91TUR1Y0xy?=
 =?utf-8?B?THhNd1hoT2NLRFY1ZlRLU0tvNVZyUXZvS3BKWGN5RVZydU9qdjhNL011R2Nz?=
 =?utf-8?B?RjBPdU5aazVmMk0vYU14VmhxdEZvUk9oNnBrV2JJMEc5M2VDTzE2NnJGUlRw?=
 =?utf-8?B?cWFWaUJmbFF5dnR4QXdVKzRyOU1HcjVoL1NYMFByZ3N5T3hUbkVibW1uVUJ0?=
 =?utf-8?B?Mkh2TVkvQmg1OHhnVTJrcldSYUZJM2xBQiszNGcvUUxzMlJOcUFWa09wSldI?=
 =?utf-8?B?Tm52b3I0WExjV3kyc1o5VVAyeTY0VUJBbGZ2UEI0QS9yeDg4OVQ1TG5PMUZD?=
 =?utf-8?B?RitETkEybU1SUS93YUlsSlkyeFFnSnJMcGZuNGJjYlFuOGpsV0VBMEg3dTlV?=
 =?utf-8?B?SkMrZ25ZU1hiWllpR1RTVDZsd01yVEN6dm5KV0p4VXFQYlUzQnFGY0phU0NY?=
 =?utf-8?B?MWErQjlUZEdTcDI5cVBBYmh1Rng2M1o3VnMzN2h1UnNuSER0MVZqQk41Wlc1?=
 =?utf-8?B?UmI5Wm05WU9uS2tRTWlDSHJscUlrSXNUaDBsNS84cUFJdURKOU5SV1k2dklh?=
 =?utf-8?B?a2ZhZ2VwcHJPWjI3bUIvNGJjeS9aYWhXVVdlalozKy90R3ZvQWtrOWRLQTNr?=
 =?utf-8?B?QW4rN0NUbmNVWUhmMFpKbmtBMjByOUN4ZkJTRlF6ZloxU0dmbGhWN09DK3c5?=
 =?utf-8?B?M0YyVXltcFM5dDJFbzdHU0xrL1c0Qzgwa2pQL1RQNFRQeEgvSGZzb3FFTnho?=
 =?utf-8?B?MWJxL2NxNXh3eHpYdXUraGt0SVAvSThWSlJhRE5WdGNjeEdnQW5HVHVwWVk0?=
 =?utf-8?B?YUl6RFpJTlpwSk1jYTAwSjlNS2FPQnIzVE9Gbkw5R3lOMnNTMW9kOUVRUW5h?=
 =?utf-8?B?UEFrSW9PcEVkZzQ4Z252QkpDaGUxV2dqZDhUV3JETjFITUtIbDhkZ3BnUjdM?=
 =?utf-8?B?MzB3SS9XbGVJMkRoVW1qR2NHQ0o3dW45OWRCbTBoUk5rcEpKWkhzUjlwUWc5?=
 =?utf-8?B?dDlWcUI3T2lHRjZGMXpCQ3FuU0VWM0prSlJPZWwrUjRLcnpQdE15N211MUpp?=
 =?utf-8?B?a3BjYjNaOVBPUWl3TlBabkd4TEJqOFI4Y2hleDZrWHkzVWRmRitUTklsOHNq?=
 =?utf-8?B?bXNyMEtod09SK3haOGxmR25wZHpINU4rUVhoNEdscllxK1I4bWZmM0lqaXBU?=
 =?utf-8?B?ZUVvTU9qRzJqbTgwWm1KRnNlRmFuWXJxMzV4YnhaQjllUkUvbkdtSlpQNWRu?=
 =?utf-8?B?UWIxM1czMWJSZzYyZnN1TDU2R0JKbmVqWWcxMFdUenhVMWI5b1FIL1d2cngw?=
 =?utf-8?B?WHgyY1gxR3hLSTl4OWg2ZEliTHJNaVVQU3p3NWtZdzhDeGtZeHlxNVZsM3Zs?=
 =?utf-8?B?a2J0WlFMa3lZUlRJd1dia0FqZW9YRHBOVy9IVHo4K1lCMWhaUVJWTVRhU1F5?=
 =?utf-8?B?eUZMQ2srLzdxbFRyZnoxTWNMVEw1Y2Zqd09QVFdlVzdIUEUzaXN2Tm1KUEZ0?=
 =?utf-8?B?Tm80ME9qenVjRmpkN1VCTjJaUThyR3NQN0FKMGRGV05SR1NKZ3IrbnRHdmsy?=
 =?utf-8?B?L0NMU0FERGhtbmdqd0lJNmJhVHlNZFhZOThLSm44RFZ4R21QOWFaZExjSHVS?=
 =?utf-8?B?ZTVEQkMyKzFjM053THI5YzZiZFkwOXV4V0JrMUp5T0RRN2NEb0xObnRtUlNM?=
 =?utf-8?B?Z3lha3JGVDBFU2NFM215ZERPVHRyOXVsRzVINndiME8wVllEQ1JjeVNZR1dV?=
 =?utf-8?B?dVRXS3BzQmtCTEtzcThOUUM1VFdabGZIemVjYlJNMFNNZW1Ea040TWRoT0JE?=
 =?utf-8?B?YzRjaWNpUFFVZXFXb29ueGVwTWxQaktGUXdydmdqa3laRTEyUG5KeEpVY0Iv?=
 =?utf-8?B?RkdHSlBzVUdhejFqaWZEREZLV1VHZjBOejMvbTBiQXp6aStvTjZKdUtnWnVS?=
 =?utf-8?B?bU1iMTFsQnY0aWtqS2pVc0JLdEt1OUZlOHBXdlZXaUNMT21LaE5aVm4yMURy?=
 =?utf-8?B?Z0g2VjZqN2tJSUdmTHJabW5tUE1iVlhhTEVEdVVxenphUzRNR1pFOVVldjhY?=
 =?utf-8?B?eDJaNzlkWVdPaGdwbGE5KytCM0JnV014WUtjTkFWdm1HUjRVN0pRYVJmTU9v?=
 =?utf-8?B?QXc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	ynh+f6uUadqOvJpBZ/gZ2qjCprtGReQRt55sa2cQt/H9MNp1HzIUhK8AWUI6BF1ezCRVjad2Dr6WQC+EGAQOJqxdkeJ1bmvj0tVEvIE8P6gzQUauB1Bf4d4eVQ3EZxeYhRYBNYkAB74jZE4/x8nB5okoCFLYfyNIpA/8FP9KjaeU2Fdfl0wh/j6fg9UZZsVDS5rqeQrN+fE9O5ezjivUJrO8b5q5dQWtRI2A3mvuIYHVw4Gr9FrXcfmE7ZLxn1Sjfg2XovIIaoYnA+poOBkcIp6PCwDpw232fAQustnkQ+SXQYUsWjpF5UFJ2hdzrC13mIb8UV7FqxvuLYkIht7AgS0P1tMnAp4PVIgxksP98ie+BqZMHL9rTVDpQohyoHNwbcrRjQgfO7HzwmpN6K+ScjYcsMMvYlNPfg7jOJwWdz8pDowZU8eC29ngJFxr8pHrQ+v10n97YxiVaIO+Izcrc8A+s6qTFpZ66rntDJtsWtDwvOpUiD5p+eEOQxtQ/W81hbpXWcDIXVF98NBtO+9jdDu/JAGJmAwCyUsl5dQpG51gEtxp8/O4OeGuN2aH4aJpFjRGgoyq8moN2yBpTbnC0Qyp7iRnJz6jEoXC65ZozJQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6351cf43-709c-44ae-3913-08dda40f9e45
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2025 09:01:54.6008
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JszYHzLF9gpM4iHSEoVyU3Lmip4Vrv35h86aRq7wKQLWGe2ZFsVDsmpL2d27YEbGw+WaguwauAHmCc2OvLzNhg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4599
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-05_02,2025-06-03_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 mlxscore=0 adultscore=0
 bulkscore=0 spamscore=0 suspectscore=0 malwarescore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2506050078
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjA1MDA3OCBTYWx0ZWRfXzvo4Sflpznxo QS9P+QL2gU/BHvlyT9sTb6KA/QbqtCjRA38jLcpqlIv6z6bm01YVCtim80PtUUIFm6wLdjYJWyF o222MzPwiDcwWSql40zUflJtGUp3s/cLpphVvlx55mXYyPZQVW5ANwpH5ooXcELwqsdIXF6Nk6C
 JF5kqG2thcYOFt677U4FGtLPfAZmyekKMB4BL1bFJm/nYzIvevkITnelQvhT8PF5jAwJnnhf/Yn k8vOlOlrM5X52+lNXKL1wd6veT1vztYGREuWbm5Ps85cVxKkVl8ajh0Ts5AvCQrweND3NUJizNx Seb6LElJ/vyT7/QCLWE4ITMULQwBFT8sRxysXc5yUcaFOdzRsZm6IQrYHAw4FOCvRSuxNDz1RzR
 hhIeLVyhYdMHfO6kQPiW8DKSreJtSra8Y5aR6Cg+HJv90sUEUXQC4mCtiI6QevJbWw3XrW2C
X-Proofpoint-GUID: kqINCP7SQtMFDU0n1heBvC_Xqvp5btbL
X-Proofpoint-ORIG-GUID: kqINCP7SQtMFDU0n1heBvC_Xqvp5btbL
X-Authority-Analysis: v=2.4 cv=H5Tbw/Yi c=1 sm=1 tr=0 ts=68415d06 cx=c_pps a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=GoEa3M9JfhUA:10 a=wD5bHq6XNlTyoRqY93cA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10

On 04/06/2025 16:09, Nilay Shroff wrote:
>> I need to test further, but maybe we can change the check to this:
>>
>> if (t->io_min <= SECTOR_SIZE || t->io_min == t->physical_block_size) {
>>          /* No chunk sectors, so use bottom device values directly */
>>          t->atomic_write_hw_unit_max = b->atomic_write_hw_unit_max;
>>          t->atomic_write_hw_unit_min = b->atomic_write_hw_unit_min;
>>          t->atomic_write_hw_max = b->atomic_write_hw_max;
>>          return true;
>> }
> How about instead adding a new BLK_FEAT_STRIPED flag and then use it here while
> setting atomic limits as shown below:
> 
> diff --git a/block/blk-settings.c b/block/blk-settings.c
> index a000daafbfb4..bf5d35282d42 100644
> --- a/block/blk-settings.c
> +++ b/block/blk-settings.c
> @@ -598,8 +598,14 @@ static bool blk_stack_atomic_writes_head(struct queue_limits *t,
>              !blk_stack_atomic_writes_boundary_head(t, b))
>                  return false;
>   
> -       if (t->io_min <= SECTOR_SIZE) {
> -               /* No chunk sectors, so use bottom device values directly */
> +       if (t->io_min <= SECTOR_SIZE || !(t->features & BLK_FEAT_STRIPED)) {
> +               /*
> +                * If there are no chunk sectors, or if the top device does not
> +                * advertise the STRIPED feature (i.e., it's not a striped
> +                * device like md-raid0 or dm-stripe), then we directly inherit
> +                * the atomic write capabilities from the underlying (bottom)
> +                * device.
> +                */
>                  t->atomic_write_hw_unit_max = b->atomic_write_hw_unit_max;
>                  t->atomic_write_hw_unit_min = b->atomic_write_hw_unit_min;
>                  t->atomic_write_hw_max = b->atomic_write_hw_max;
> 
> I tested the above change with md-raid0 and dm-strip setup and seems to
> be working well. What do you think?

I would hope that we don't require this complexity.

I think that this check should be fine:

if (t->io_min <= t->physical_block_size) {

}

But I have found a method to break atomic writes for raid10 on mainline 
with that - that is if I have physical_block_size > chunk size. This 
ends up that atomic write unit max comes directly from the bottom device 
atomic write unit max, and it should be limited by chunk size.

Let me send a patch for that, and we can go from there - ok?

Thanks,
John
