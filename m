Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A7381CF2A3
	for <linux-block@vger.kernel.org>; Tue, 19 Nov 2024 16:32:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732033942; cv=fail; b=Ii1O98KUNIt8uaQv56aH1w2BS0G04kySyOzsxbcBtxLsUbGDMFw2DWPkTGrUYBsl+I43IBBbgbgE9wofpoS6jP2AklnOo8RQJ9ZGTXtNX7L5lGDBbJBuKVv3UWtTYM1AqFs3Rr2ETFNH7Q7SIc5YOKRi+pVBXKM7ZwXg3fpyREo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732033942; c=relaxed/simple;
	bh=5S26Fx/y6MDACGCYilFD5V6/L2tArHOB4kqwOsfNgM0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=CE0SZGRv1hlXKkcxNk/yF78CQ4KsBrOjj5WwrcfCnaXjMZDH7GcdnThS6AjC44UErChY7Dtgn74xgvysDKQcXuoupV0mhtkqbgQy6IUV0F1Kx+6h43N2LF5a5/PkdH154fFb0qGVl3GH7LiUTmoXX7erujdkq2FuV9KVMzWbqvc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=iSvtD2zg; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=KrQU6WHs; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="iSvtD2zg";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="KrQU6WHs"
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AJGOCPL013063;
	Tue, 19 Nov 2024 16:32:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=rN7pNpzjQAL3AIeMqNtPJNPIRkYLDQYZmeyVx+0EeQQ=; b=
	iSvtD2zgpEQWuScjweJBrJVQpo6u4dHuCE3gPobm4MEAjj1mRkz99iiHFPxn5e2m
	v2X4tgJsXa2HOnmZvrCwLk5UoX6nKbeF/AwJy0xEGvX6BmVpGNffebEkR1XAhvXH
	j1v2QZSLacTYcn3uYTqr9EPHesQ4zLbKLK3U4eF5C4pxPGEtds0I+G7sy4lfrL31
	PsgPAvVpuWP6A5dsEk6eDiZAouUVxeWnoUZEF2WcjZKazSRNemAgyqzPwA6g/csi
	RgcbQWkWw+JZ9LXoBc/RQXurkRmNHHShdPfl5h1WQAeWe04PNJ7C/k2VvBLUQ6OC
	lqTrAyhvq/q83tLQnh+GKA==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42xk98n948-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 19 Nov 2024 16:32:15 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4AJF1IjR008655;
	Tue, 19 Nov 2024 16:32:13 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2171.outbound.protection.outlook.com [104.47.73.171])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 42xhu8s4xv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 19 Nov 2024 16:32:13 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NRnDn47ehBtItzKdssWRCfooZWX+IzGRX3l5MloIO1V3eSfeMv8uZIaJ8Qm8f2EO8OwZX4cahHM/8h1rO8dmy4vnDWWFpOCgQFkeEQpcuqIdzruNH+Qzx6CiRaeoHcaO/T5rzkC1ePnDA5b4nq1aSbySRbFie5jxuts1wXQzN6R1PN/EgkQPh4Pu0LP6De9vIOzdN0Eq7Q4vTKXNOcRSVe7qbZ12bwU+ZaFZgbfiI9WNBQ5Xenafc4v3haX4wRMx76/CCbV+uBEFZQzSKnXH+MbkC7jPEotdkjfevqAbE1mWtTfqXqOMzCLUHaxpVL+z0IenzxLrLGozJ1qWcdhWpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rN7pNpzjQAL3AIeMqNtPJNPIRkYLDQYZmeyVx+0EeQQ=;
 b=NDXGUGxbOQAdK0cjdK5CuigaURPhpJs1u8+l/BXW9cDEQgE4izJJVb32RSLbxAFHQ3nZ+BTyCU10+CM783PIOrBKu/MPJJOpmWp3O/u0C4kGu++Qa7XdwJ+CVGhTUyPOL0R9XftNJ8t6/g28bwQ0LARZNhHDg9yfZGq3DCku16eUbjJczgjTpBa1H8/PZ4gDO26sXeDfavmCl06y2NH2PN9HTSPmVG88LP+wBVvCcPzyHHWGj/OOzrByL4tSQuYphJCCKgC/COtTOgZrK7M03sBVW8JUEf0JjONKmj4Rrs68plDMYU2fPddRifGY5Q9hd0o55AQD03n3ur6dCYTFMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rN7pNpzjQAL3AIeMqNtPJNPIRkYLDQYZmeyVx+0EeQQ=;
 b=KrQU6WHs/e1zt2H/omE0X56w+u+dZzEobYFBnimft3euYJ7bgciG8Mlt8GM66lhNnoUJ0POtfuy7JicWioJkDLIogszFNLJYsdWx6JFf28fdgkD/GsBFOOg6/1R4z0XHk/CnujizttxHmFMKfKQ6RCJSOseMC/RU1qj+cT0W6HM=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by DS0PR10MB7224.namprd10.prod.outlook.com (2603:10b6:8:f5::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.21; Tue, 19 Nov
 2024 16:32:11 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%5]) with mapi id 15.20.8182.014; Tue, 19 Nov 2024
 16:32:11 +0000
Message-ID: <8f394afa-0dc7-4431-a9e3-d8f3e700e2c3@oracle.com>
Date: Tue, 19 Nov 2024 16:32:07 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/6] block: remove a duplicate definition for
 bdev_read_only
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org
References: <20241119160932.1327864-1-hch@lst.de>
 <20241119160932.1327864-6-hch@lst.de>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20241119160932.1327864-6-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AS4P191CA0045.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:20b:657::28) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|DS0PR10MB7224:EE_
X-MS-Office365-Filtering-Correlation-Id: ee64dcdd-e6f7-4b18-2e61-08dd08b7b786
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?akFLc2ovbTN3azg0U1V1MUFHSzVZZWhGZ0hKY3J5TnZHemRYSkI3YlZ2S1pC?=
 =?utf-8?B?THpsSC91SjJnSzVpTWlOSGJSRU5iTVVLWGhGMVdManpoc0M0b2tKYmd5aFFy?=
 =?utf-8?B?ZU9CV3RodTVSS2hURWNsc3RwVFArbGFUNGJobEpxNkgrTEhHejZhVFB5V1l0?=
 =?utf-8?B?Q2U3bnBGU0hvRGtHcENpZ01LdmhxdnpZYnNQTDBBN1UycVNEZENoSGU5RmZs?=
 =?utf-8?B?RGd5TElZelphVDIxeHhIWjFlMWRDNTByRmhrM0ZHUTR5dlBRaXNkWEp3YVRQ?=
 =?utf-8?B?Nkk2cmhRMzVMdlNxZjRUSjhpUGxaRHVCNHdnVE1TVXpVLzA0WWZoNmhiaWww?=
 =?utf-8?B?TWJQN2FzVW55MDdJc0N6QXhUVTk3VWZnWldTOS9LbTNmeUNBVE9VSno1NUNi?=
 =?utf-8?B?VFB5VTcrU1FZUVBYNkkrQTBpNGlXMnlCbnYreFJLemVwWDF1SEVUdG9YNGt0?=
 =?utf-8?B?V25GdVpyd3o3S3dTd2pvUmVCSGRNeXBkYmI5M0xGMHBzLzhyczYvMkRwYjI5?=
 =?utf-8?B?QWFDUWJtaVlnK0hqOVBES05qRWc4dFZvT3J1SnZpbTRJZ2I4YnNjb2JqQXR5?=
 =?utf-8?B?V1d0VU1CMjJVQnFQOTNYME5BUXRLZzNwT2J4a3VGYlVlMUdtRERHbXU2ejM0?=
 =?utf-8?B?Ykl6SkN2VUxFZWpONEVFWGM5ZzhmNnpWaHNCc052eW1iaTNXb2hGQlVuNklF?=
 =?utf-8?B?QkxoZUgvZ2swYm5iSU01TVlMY1BqOWo4OTN5S0JYVkhodFZ6ZFZCTzB3ZVd0?=
 =?utf-8?B?OC8yRG1hVnpzMUFua3BXdjlZS3QreGhmcm13ZzlkQVdNYmtFY3ozeU91SzVT?=
 =?utf-8?B?TjVhZ0Zpc3VIYUZlUTBjdHJhNmlKMzFhQXk3L2pRb1pIYW9lTCtJRWpSSmVx?=
 =?utf-8?B?c0t4T0gya1NSY2YzWERvL09zTXNqUnFiKzNqZjBCbU95d3dYS1F0SWsrN2Vy?=
 =?utf-8?B?dEtnUU42VVZndEtweDRaaU1PcCttVURoRWxQaVlKV21zeUE3bjY3cjI5amIy?=
 =?utf-8?B?OFJiRUh1THd0Lys3M3lKRm5yOVJYYVA2TWFId2R6SlNKZGVpdTQra1lUUjI3?=
 =?utf-8?B?M1huYWZ4VDFJdlljSGxwbWlaQTRDNTltVDR3OHByV3U5TDFrUGFiWVJJODNy?=
 =?utf-8?B?T21BRHNTakxCM1dYNHFRM2ljVzZtYWg3M2dEN0FnSEp4c1ZkRElRdVg5NWlt?=
 =?utf-8?B?cjNpaVlyVmNLSCt2RlZKL09rTGdyaGdGdVFZOGtXcHpYRGEyQUNhR0pmZkZQ?=
 =?utf-8?B?YWpQZ0ppaTdnc3FoeTA4c21hT0dVekZZWTVkcFJ0aWc0SGI0K3NkV2NxTE44?=
 =?utf-8?B?WUt2dUVWNSswVmF4OStxbllZdzZPbFB4RTVhVEFhNVBrSWltRkluVzZETXp1?=
 =?utf-8?B?NGZ6Qk0wRnRZeFhUZzNDMWZGbTlyZXZ3NkZrYm03TktkN05ra2JnYko3c0RW?=
 =?utf-8?B?SDY4N000SXpGbkRiKzBJK0RTOE1MRGg5L0xhblErNjdWMlBmaG5ySTJSSlh1?=
 =?utf-8?B?TVQrYUJKdjdNYk5paGtNbE1BaGRPVEFDSk11ZHpHeWowVDY1eDd5TjVQZk9o?=
 =?utf-8?B?cVY5aHhUQmFhN29vMEU1SExYVG1xSU8yVEFudGFsSitaMzNkT05wekVvU05o?=
 =?utf-8?B?U3hNRHd2YWpSK0NjcGxTU0gxQjVyL3NDTHJXM2tVRG56T25oZGpkejF6Mk1w?=
 =?utf-8?B?M0o1TGFlN1MzMHBZUHZuemlsOGFTWWd3d29QNVQzdW92RUtoMTJsT2VyMHRm?=
 =?utf-8?Q?a8QNijCyL9C/p4MdRTOFNTLKLFg31E3GNCbtLmY?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?a0JRM0EyTjUrb012L0RSRnh4Y08vd2JLazRJMmNOOVIvMUFmTGR4ZGpKYXRQ?=
 =?utf-8?B?RE9rVUtnanl6c3AwOVF1SkMwejRuT2hRK1dYTjZoN1NIVHFUVlJURjAwei9R?=
 =?utf-8?B?WDloM200Y0RKdzQ3dEhQYVR3Y1gzUVNHN2pHdmkxRStLMDl6b3ZJaXJ4QkdB?=
 =?utf-8?B?cUNXRlRFTHowY0swK2lrZmkxWVlGLzlaWGhCMVlOS3ZyUGozOVJhMnNxSVhl?=
 =?utf-8?B?N1BPK3F5aUo4T3N0MmJSUDZJQmhzRDRJYUx2ZW96SjhhbEdVbXUrQXpEcXJ6?=
 =?utf-8?B?MGY5Um95eTB3YXJlMElUQTdxQS9NcGx3WnZCdElUdHRhdElmK0xVT3ZYcDNM?=
 =?utf-8?B?eUFBK2txbjJXRW9vaVRXKzRTUzJJWFJiNDRCL1FIaVVkU1RuTmY4UHFTVDZj?=
 =?utf-8?B?aUlmMzJVRkFJQnIxRDNjWk1WMHlCdVhIZUNFcmxOZXpGL2IrNFUyb3BEOHZG?=
 =?utf-8?B?Wm1hVGpsa0RnTDBzd2hScWpoU2RIbHRRUlEwYWhmeFM1M1NRclNpbE5qOXNs?=
 =?utf-8?B?Z0FtcVFzUDZRWGlWSFhRb05GWEQ0T2VWRG5BeGE0eDcxM2h6OGN2cFJOVUs5?=
 =?utf-8?B?MzhaY0lJcDFUNEhzNUNCREhESUJIeUhvY0F5ay90ZHRaOEFUbk9HZzFoQWZH?=
 =?utf-8?B?MS96RGhoZFc5Mk9ZS3FYdkF4VWpKTWtKUkNtYUx5UG5GYUdkOEU1bUU1aXp2?=
 =?utf-8?B?MEt5YzgvZXRmUG1nQVgvVVEzRjdWWW03Y1B5K1JBRHpadzlEZjZNRUpCVEov?=
 =?utf-8?B?VWRWeFNoc1VFZExUM3I5NDhxVTk5cGh1SzBhSG8yTGsrZEFjb3FISmZaRmpP?=
 =?utf-8?B?aUJONFJUeTBTTEtuN1dxMEJaQnlsNWxRYitjcDRyai9IK3FMUE5XeUZyTUs5?=
 =?utf-8?B?SUwvQmdLVm4xS3Y2N1hPT3N5NXJOazA0TFJxWjd3L2M0VFJmQUpEOHBYZFJi?=
 =?utf-8?B?TW5HQ1FMN3daOVhZY09aQjBITWdHTFV6VmR6MzVsTzUrTTdTU095QUthamdJ?=
 =?utf-8?B?SHhPZERkNUhqQUp2dE82QUh5R3g5c3dDMFloMkF6SklualQzN3NJRzZZUCtS?=
 =?utf-8?B?Sm5jRUE2R3hjejl5VHNoTkdJak1rVHo5dFIwdW1hZldRZEVHR1hoQzcrTEZ4?=
 =?utf-8?B?YjQ5ZTNMVkhVRE9MYzBFQkFiOHcwZkl5MUc0T0dnNGgwaUtuSTlpZ2VCNTB1?=
 =?utf-8?B?UFJZeGFQTkdTaTdtWVlYNGE4ZzAvNGF0UndxenRpTmQ0bCsxbTBaYkUzYkNE?=
 =?utf-8?B?T1NpcGhqZ3UxOXRJcm9TR01xRjVoYS9OenpJdTVNK2lEaWdtRXFxMzBZSGhr?=
 =?utf-8?B?ODN3VHZINHg3UHh4aStmWTNPd1U1eS9iVjVFZlduSUtlTS9iTkFnTG12TlF6?=
 =?utf-8?B?OG9Kb1E5ZjkzOGJwNWVMa1NScWlKYTIyTXZycnlTOHdGdEZPMlV2bGlhMDRS?=
 =?utf-8?B?MFVJSnNIRVEzVHlsUDRCbDZ4YnZzQzdtZWVwb1N3c2hRMG9aUHRWT2FnUUtU?=
 =?utf-8?B?RGUwWW1YU3dXZVBsWm9lR3ZOS1FZSWZraDFTdDc0bUljVnhWNVFYRU95czNj?=
 =?utf-8?B?T1kzRWZtRTcwbTE3aGNvbzN1ZFlxTmp0a0M1M3Fha2VkZjYwMkFnM1NTcEgr?=
 =?utf-8?B?YWFBcXNSN3R0RzZEWUZHK0w5MnBLUUtscHhpUnF5ZjZzVVRtaEo1c0Q3aEVo?=
 =?utf-8?B?WXZBNjAvOVVSVmZGdHpkUEdZWGhYYUQ4ejNQV1ZsSzlNMGE0QlVacGRDbkt3?=
 =?utf-8?B?cmdSY1BRQlk1M0NKY053MWVvcGNudkdiTlNiaklVNFlzNGx0bldISDdXbVk5?=
 =?utf-8?B?MUR5aW4wamJhUGdGY2wraE5tWHQ4NTh5VHUzRTJ3NlpiK2FZOG1ydWxUM1di?=
 =?utf-8?B?V1hoTkROa0VVaEtWd0hpNHRETlRHOUk0NDhDQUZ4Qnl0ZWxhR21ZTGVNdy9x?=
 =?utf-8?B?N3d3N2lzeFNLaFB6VFNWTStveWNlY0xPbXkxZ1BkTUJFQ2FGVWNLZzdENmEy?=
 =?utf-8?B?QjFXUHNlbHFpWTFTTVJFaHZIMXU4N3gyNFU4c2pDY2VwaVM5M1hCUlBzN1dI?=
 =?utf-8?B?cmpYZVk4ZStvRFhGclhCMjV5QWNQVkVZbzRzZENSMkk4M0sxUS9ldkk1R2RZ?=
 =?utf-8?Q?wHdQ5Fl+1PoUpc8DWn5ZiWItY?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	YV4H8KgTasEnnLjRNbkJ8lXZLbOPo0EXG7ZZZH1CHudiYcn2WMgFDpZdJgi0CBf9UXXnn9s49/mX5x0/CSLTS3R8y+Q+sjvG7lF4H+ZfAWeaYil6qo/w3bZVoLwmOEgfeh3Kb+XvrGdOWV10Dja+GP3Q02VRQmPGKJJJ2pybcU8vRAGeLgu/I9EKzF8FWSkQiFAS7LA4jewpJpWLpEqGgjM4vS6TByCGreywa6h3TUlj5nB2qJf3Y+H0xDEv0LXutYAXR/lvYRb41wlLfbZ9AIiB+trq58FNLDQEiQ1aYdaGhYl6y7BP16NdescXVD+Qw4qDk+FxzHhOEQzrG8wn8hx3jwOuDnpYyS1kY44Iq3S+x8ecfQNOmMbh6xuV3rrfUK9RRzATZNsIy9c/N4jNHBWrkkZN4DP1fa5XcI3mimr/QqDaKDZM9wuo6/6JxNtE2ZixbABhXTBkRWFX5xwTkNU9x3Mlo0juQrJNLQHWxuXyCuDJeQKMzfrsNAhWNKRuLnU6OqVdpJkDRWiT9/1VYS2aagaAuqt7IXsARNp8XxajiIVPZCFpyqcejyeYtGaKTEUbJgITBp5+qYzV+91ypJijUcGDsHRPmivzBh2teDw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ee64dcdd-e6f7-4b18-2e61-08dd08b7b786
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2024 16:32:11.0133
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fTHfrfYl+zfL83dTiP6NzV8vhwHzF7VuJkSaraNXL8rG0V/D/DQX54bI0YAcqJCJzLUX2BhHdiaFBwHxs63RjA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB7224
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-19_08,2024-11-18_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 bulkscore=0
 malwarescore=0 mlxlogscore=999 phishscore=0 mlxscore=0 adultscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2409260000 definitions=main-2411190122
X-Proofpoint-ORIG-GUID: kofqM3nTnkOdgmesnaFIGkokA1YYjmjL
X-Proofpoint-GUID: kofqM3nTnkOdgmesnaFIGkokA1YYjmjL

On 19/11/2024 16:09, Christoph Hellwig wrote:
> bdev_read_only is already defined as an inline function in blkdev.h.
> 
> Signed-off-by: Christoph Hellwig<hch@lst.de>

Reviewed-by: John Garry <john.g.garry@oracle.com>
