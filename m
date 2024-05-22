Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1383D13FF9;
	Wed, 22 May 2024 19:13:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716405203; cv=fail; b=jYTjYREkXYDyWaMMuk1SLMls6vjzr00fgTBGUJHEDvfDVXv6gd3bQG69leailGf/wEMmV2pSB21L8CTOqKs5SWPFE9qeIp/tJi33DtiYTW/pH0RrkCaKczu8DJ7/DOfD4GqhPXUiP+6UbCHCHknfh1cTuBylMv1Wnb1NQjpSwtA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716405203; c=relaxed/simple;
	bh=jTgn65Is3TqRX/Y9xMe0bOBZ7mk+FeevPkjgsCgwXl8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=dEEalg5FhkflNU9Droqz135pCogRQPA1pfgBmnmDzQ70se2D3niCLcyRCVffYuJKAxvYPNnL7f7lY6DgP06ZqnOLNZIvRJLT6Fn+BbsVzDJ+Ph7s+Ea2EPzjKySeyJCsCBQjxyBL/FubcGfkGo1IY+Qi/hx/+7H2ksXSdZIkTu4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=DaIHA/i6; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=MVtoobtd; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="DaIHA/i6";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="MVtoobtd"
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 44MJ40ma029105;
	Wed, 22 May 2024 19:13:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=jTgn65Is3TqRX/Y9xMe0bOBZ7mk+FeevPkjgsCgwXl8=;
 b=DaIHA/i6x1E+J1Pmp9uJxNOEJ8i68j5aexBvDdf4FLlGkaJCLfovirFuRjqaqx1auxM8
 +kqgiA3xLGHOBHOn/7f8amuS+UEkAIZakFUtBKlpXq4ZNwMII8xmVRXL5r+JM6fvaJ2C
 AtKdFuL6dQ0/8L51w9KvJ2cvDdE9o2adxmYpF5tguA996/aK/YXmB25RlbHsqxP0Rnk/
 wm98lmtGRUGcV0tur6W+s6X16O/bhf9i6SeQKqajXN5ZQ/RU+ESZP9fPtR8Z1n5nv54r
 qNW7rFLKM4UOwSHDNq2jyfzLYl23derIA7CPRRyveFXcvq+n5LFwGmpKD5zlc+GD/xKJ Zg== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3y6kxv8k9y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 22 May 2024 19:13:02 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 44MI3cdW019530;
	Wed, 22 May 2024 19:13:02 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2101.outbound.protection.outlook.com [104.47.55.101])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3y6js9ntsc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 22 May 2024 19:13:02 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nQk8pzZ6hPcvjPkstKQdNg4MHMi0Mzt4xjtvvYtWUVJrgAXcaXc9VAQo16V8G30xgRMUWuyOEFRVn+52M60e4i5a+yehckqMBP6P2Fdw5zsPCSxwvXSgZL7DW7MOMWXUCGlkSQC6nD1D8muB+1V32JQYuKhzG8uM5Bgi25B5Cth7m0Bzwv0cfYfh3Mj960AGI4lwwIgNl/EMfSt4EUaylFh4TBZJnNqgMBewnzf8/6UhSH6foYFcr7Z52g2Ivr7O3dleemN/UQuBWKbGCntayd2FLtDGjZLSCLVl9rX2BmBFXO06C25dwp+yacvzi+zzw++rg4UYGLY8gBiRZvUP1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jTgn65Is3TqRX/Y9xMe0bOBZ7mk+FeevPkjgsCgwXl8=;
 b=gt4UGF2Vn6XaENbmYMmO1RLNKeECdqdwWgjnu+Ea5MoWS6P1/G8Kw5+DffJS0JhxEzMh4eN71UKOMD4NOxMcFOyj6DXs53mBJnrvmSKvNYntX+XYL3sQpMpFAwk3ZFz7zdf+gjWYwAI2KC/5LhC6cwzrzTNBOOtk9po4ANm3eiLGtzSeabBCh2JAYuOLevA9GjQGRm828hUZt927FgZBMPQwsiFmGA4rMhBEvEOWUe13PmR37Kheqssg0bx+JzDZ9QlePjKX03g6MlE8yTiMHlBF1cWptb5pSyYLERylv78hcnI8/vOIY1Tg+xEhl5Sd5CA3tSNfOtSKwJCNEKU4WA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jTgn65Is3TqRX/Y9xMe0bOBZ7mk+FeevPkjgsCgwXl8=;
 b=MVtoobtdI3OQSQqsjRY8KpeWA24CVpRZU6tdrHxdEPMhsD5ei7zBgQUTzTkk+4j0T0XeqitQv2IuDCt8E5zUrzpHjmQupHcX2L7bT52bpCXk5mhryZxD/9BW/AD7hTuchmvVYfhzAW2Nb/sr0IVSp+4LJ9/Uil9lmQgmzD3b9Xc=
Received: from IA1PR10MB7240.namprd10.prod.outlook.com (2603:10b6:208:3f5::9)
 by DM4PR10MB6016.namprd10.prod.outlook.com (2603:10b6:8:ab::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7611.19; Wed, 22 May 2024 19:12:59 +0000
Received: from IA1PR10MB7240.namprd10.prod.outlook.com
 ([fe80::962f:da30:466c:6a1]) by IA1PR10MB7240.namprd10.prod.outlook.com
 ([fe80::962f:da30:466c:6a1%4]) with mapi id 15.20.7587.030; Wed, 22 May 2024
 19:12:59 +0000
From: Gulam Mohamed <gulam.mohamed@oracle.com>
To: Yu Kuai <yukuai1@huaweicloud.com>, Jens Axboe <axboe@kernel.dk>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: "shinichiro.kawasaki@wdc.com" <shinichiro.kawasaki@wdc.com>,
        "chaitanyak@nvidia.com" <chaitanyak@nvidia.com>,
        "hch@lst.de" <hch@lst.de>, "yukuai (C)" <yukuai3@huawei.com>
Subject: RE: [PATCH V2 for-6.10/block 1/2] loop: Fix a race between loop
 detach and loop open
Thread-Topic: [PATCH V2 for-6.10/block 1/2] loop: Fix a race between loop
 detach and loop open
Thread-Index: AQHaq+jr9QOSb4ihfkuolttTouVFhbGiiFqAgAEXdTA=
Date: Wed, 22 May 2024 19:12:59 +0000
Message-ID: 
 <IA1PR10MB7240AB2157B46F325669859D98EB2@IA1PR10MB7240.namprd10.prod.outlook.com>
References: <20240521224249.7389-1-gulam.mohamed@oracle.com>
 <dcd2dac3-07d2-4ee8-addf-b9266a84f7fd@kernel.dk>
 <c7eb562c-97ae-455a-3859-0ed28ebdf7ae@huaweicloud.com>
In-Reply-To: <c7eb562c-97ae-455a-3859-0ed28ebdf7ae@huaweicloud.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR10MB7240:EE_|DM4PR10MB6016:EE_
x-ms-office365-filtering-correlation-id: d8ddf16f-167e-47a2-540a-08dc7a9331d6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|1800799015|376005|366007|38070700009;
x-microsoft-antispam-message-info: 
 =?utf-8?B?NFFFMlJ4V3JONlliVzduNjNheCtYYmkyeDVCQ1ZOaE12enNvRXlvVTFycUhj?=
 =?utf-8?B?czBXamFpZjhjOS9MQS9FY29GdWQ3cFI5SEhwd3RhNzR4b3Q0SlVURWZTczVI?=
 =?utf-8?B?TFBhVjVCVTNzVHhmRUFSRE44bWF0cmI1VVRsVms2N1JiU3ZFQSsrcFZSM2VH?=
 =?utf-8?B?YlpETUh0MFY3czlrVDhJQzM2VkpJdTBGNnkzWlRhRDBxK01FWEFPaC9DcE9w?=
 =?utf-8?B?Qkx0YjlqT2JYc1lqN29HMjFPaWZXSkh2RGJJYy9ST2Q4ZWZpY1JaMHZKQ09V?=
 =?utf-8?B?VXdWM1BMSU1VWEVzYjNvQlBHL1BmN2JMTE5TZHNZVXZWcllGWXdPT1U4TSsx?=
 =?utf-8?B?K291bjRSYWVRTnVST1k4QVEyVkpxRERMZ1o4ZWQ3RXlwbDB0N3l4L2xEVkdn?=
 =?utf-8?B?d1dJQTR2c2NVSGttQmNtMmdYRVlUaXhpWHVBaHBzS0FLbzBKUytnMTFsVGFx?=
 =?utf-8?B?YVNuQ2Fob1J2V2pOZWUvdTdscjlQMG5JT1lCR3k4U2dmeXp0cllHeGUxVUJn?=
 =?utf-8?B?TUxPMUdhcWpJR0ZmbmV6WDhsUkZuTkpnWjVYSTJkdXBNM0pVb2p0ZWVuSHpT?=
 =?utf-8?B?a1lXT1dHV2QvMlkyMSs1bytObWJSTlZsYVMrRW94NCt0UkpEQ0MyQmJBUFY3?=
 =?utf-8?B?VTB2QTkwQjMrNGtCTTZOcm5GT0wwZEl2RG4rY2FzQ01Wa3pOejBoelF2Q29v?=
 =?utf-8?B?RmFBeEJJOXZNa01BOHMwcWtXM1RWc2lZRmpTZ00zRjdVa3NMcmtVMmQvcS9s?=
 =?utf-8?B?ZStqUklRQ1NYK3kydTBOZmQwOWxJSHJuN0QvMHY0SzBvSGpac2pOcXltQU9o?=
 =?utf-8?B?b0tBV2ozMzkwK1VVMnFSL1NERVpLOC9mYkZSL2tjSnZibkpTSHdkVFlIeVQx?=
 =?utf-8?B?MGJGS21FQlAyY0ZEZmk4L0ZlZk9rM0R3OUZpUDNrai9DL0VoQkd3aEIwcGNP?=
 =?utf-8?B?djNCUFF2bnNRdFNXZjN6Mmx4WlBrUFg3ZmtyQXFQamVjY25VeUVOMEpTQWto?=
 =?utf-8?B?UFp0Rnc5NTIxQzNTYXl0RWd6enUzMndYcEFWV2gxVmR0VnE2RS9jbzdwQUVL?=
 =?utf-8?B?aGNsRUZxS0QxbDVQbFUxSzlrNHp5RkxzbDNIamxUaXJMTGRnenEySUpXV3R2?=
 =?utf-8?B?V0ZwTnV5ZmNLUDhxTnZkWmwwejcrMTNSRkpXTFlsMzF0RGYwYTl0bW93ZkxZ?=
 =?utf-8?B?WnBxcUwwM3RGL2RDZFdSSkRVVHRNYm9YNmlHbDlUNThzZDhuVWF6ci94eXpm?=
 =?utf-8?B?bWpESDljU3BkY0o5cTh5Z2FWSnE4RnJMbXRWRW4rZUY2QUlDZHRmK1RJOVJa?=
 =?utf-8?B?aUVRTlpOcVRER1U3NzhrTG40NisreSs5dVpJcVRpM3hQWFdNckNSNkRnNURG?=
 =?utf-8?B?TFJPZlBIcHpHc1dCeThKeHQrdms4N3cxSTZyQlM3SUZDSWkxNDh1cHMwUFA4?=
 =?utf-8?B?WlZMTjB4UXVuQXBtcmxTNzJUK01CLzZ6UzlKcFk0cjdvYVhxYjVuYVdZNGxP?=
 =?utf-8?B?M1ZCWWdOZ25kNEovQnBtaVljdnBuc1RFdWpCVktEMnVqcWZyeVlxeWo4T1ky?=
 =?utf-8?B?VDlSbHJFdHh6cEUwdm15Z3JzeENJbkEwcHMxVzcwbUtuVXRHNkU4c2liRm9a?=
 =?utf-8?B?MkpaVHkxdzVKNWxibjh2S3oxcjBGQ1hqcHJadWVNVXNvK3k3bEt3TWpGdjNq?=
 =?utf-8?B?RjBjYUF3SGtGOU5OaTduR0Z1Z3h4Q1pNTmR1dFp6R0VWVkZBNTdlMUd5MENB?=
 =?utf-8?B?YThUUm1xdDNKaE5iVldlYTZCaHNabVd5dEFvcmRSSHlPQ3NvRS80aERnaXZw?=
 =?utf-8?B?SmNHbVJFUzdVcHdTVmhOdz09?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR10MB7240.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?UUNXNXhuYkYrSzc4SWlQdDZoUjBWTkRhY1FmdzBoTkl1NHl2QndoT3duSm5q?=
 =?utf-8?B?UFVueXlaTmMwK0UzU3dCRm4xZjFITFpBbFBsdXh4QVBZUUtuMmtXMSthcHR1?=
 =?utf-8?B?Y1dCUlBjSCtMSmNIclVxYkdzMXhjNHY5VUxSOXFCU0pjbTFBbnJvejZiSVRE?=
 =?utf-8?B?czVEMFBRRWlDdHBSZEExTWVGb0F0VjNiRkMxQ0kvdzdMbGFmWGliNlN4YlA4?=
 =?utf-8?B?SnBRT0JoTG1uNWdIRjBDaExENXBzTzlKNGJkcnlIOFZGS3pjcjc3VU9LQXlj?=
 =?utf-8?B?S2I5M3ovT2p2NkovdkdSOThOV1Evd0tXZFdzdzdMcnFpTG8xQnZ4LzVDY1l6?=
 =?utf-8?B?VzhjY2xvNWtRWjg4MkNjdUpFSEdUdTNHOHVreWwrTlJiMEI3Qk04SCszT2hx?=
 =?utf-8?B?RWZUUFA2ajZRZXl3YndrNElhaGR6RURXSUl2ZFYvdXpBRUZoZ2NhN3FXL1VF?=
 =?utf-8?B?WGR2WVhtNU9VQTlwQk1jMHUwVWhjcWp0dWtKSklCU0RPeG93MmhuekliZGZJ?=
 =?utf-8?B?MC94QnZHNE5DVENEQlhza3JiTGtuNW1UV3E5bTdUaS9MTUdxWkc3M1FoR2Nq?=
 =?utf-8?B?Mi9ZYUVDank4L1NHd1ZSdFErZEN2c1Zsd2N4Zk9aKzZWQmJGUkhKbUZxenJl?=
 =?utf-8?B?R1R6OCs5MXpSTjRRaUg0aUR1K3J4U0pQT3hiTnZHZHdpUktOa1JScUJPSWIr?=
 =?utf-8?B?eWU0Wmh5TS9VaTJHbTlyUEh0dTVSY3VZNER5WmRVVUE3STRJSlFtWmwxTEs5?=
 =?utf-8?B?NDN1RElraWMvMHlaekZaaWp2cWIzZFFnZWw5emg5Qk1Bb0d5bkFCKzhTMzRF?=
 =?utf-8?B?UGRJdlZpNVJYa0VXNjRzS00xS3NvNERTNVhZai8yeWpJTU92RUhUWGowL21P?=
 =?utf-8?B?RmdKZm5xVk1xU3B4ZkxtY08zeE1YMDlPSHlNcmtmdXJncEpaK0JkdVZ5VnA1?=
 =?utf-8?B?NkRnT1ZOdnpuZS9YUGsySUdWUjgvTGFWRlIyQWN1amxBTnFFaHhicWdHOUZG?=
 =?utf-8?B?MnNtbVFkZDJQc2lza3pjODE0TEVqeTlvWndlSDRtSHJYVFpEak8wNGdma3lm?=
 =?utf-8?B?MVVYSS91MEt3TTdyQ3FYcEliSFlDdmNvcFJUcm9namF1WmdhZ1RVNkNBNG55?=
 =?utf-8?B?a1UwU1Y3RHZScHlTand3MmZKNm44TlVYRi9BZnFSaUpxRUpuTEM0SlZNQmow?=
 =?utf-8?B?TEptaUZ6a2hOWHVkMEF0c09NbG0wcG1IU0pNVUsxTTNDdUV6eThrcVg3cG5N?=
 =?utf-8?B?dURNMTFQMHFtSGxWd0xFUm5EajkrQkhMa29LYUJMSm9Cbis0Nk5udXFwcGVv?=
 =?utf-8?B?aUdoaXZQR0JzV0RJSHh0OG9ZZ21FK21HeXRXdGZtV3RQRllkUWNrZGgzODJZ?=
 =?utf-8?B?VWQ0d0w2UlZUR3FlNkVFTlVMdjU0ek40cGQrTERtMW1UaVBreEk2Qms5Ykkr?=
 =?utf-8?B?bnEvQ0lPcTQzS1EwK25aWFpibUFIb0ZNZDd2Zm5uMTlnbWU0MlpMT0o3R0Fs?=
 =?utf-8?B?b2kxS0F6V1R2SEMyYURTVHRnM3lkazJWN242azlnZnpwUmR0TTJXZG56MG1B?=
 =?utf-8?B?TEJHdlJOa0V4M3FmV3lNQ0FveUtwTzJsVGZkSjhzSEdCY09ILzlLd1ZlTDg0?=
 =?utf-8?B?dHU3Uk1DRHFwUHVtc3NFUjNOVStCMFo1Zkc4WVlvMzMybnREaVFkUjBXbFor?=
 =?utf-8?B?L2lsTmFKMEpzN0h0UGhtL3FPczlYU0lyL0tWQklzbnJCWWozYnNJOWMzQ0ox?=
 =?utf-8?B?VVVXWkM5bU9NaTU4TzhZaDZKbTNKYU91bDNDa0ZJUmpmY2lwbkxFdDNucmhF?=
 =?utf-8?B?cTZORDRVbUttREtaUmhTSTd1L1ZYdGkrS0NZbURBRkkvMVdoZytLUkhqOGZB?=
 =?utf-8?B?MUZ3M2RkNmVyRzIzajEvbHBYTzNwWC9VSzYrVm5yOGliUCtHR0t0UkpwaDdM?=
 =?utf-8?B?NVFJbjFHczBBQ2VFMkxGNkI0SHlGUFFLY0pleGtWeWZ0YUMvdnl6a0N6bnFW?=
 =?utf-8?B?NTlHVE5pV3k5RUlPNCs2dXJRQkxkUC9kOElRK2UzZXB0RXJtWlpsenVlYWVy?=
 =?utf-8?B?cnBCMjNOTFJEc1JHaXJFdXY3MVRNT0xOTFVad0szVExEYUtBdkYzZTB4SkNL?=
 =?utf-8?Q?GIzJhW8u9WnYdp8Tq0F375WbC?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	DbPVVXZd0WqaV6nwi0O1IFd1kaybOr15JpjyBUGtXnXhbAwws3p4HjQ57zDwF+3z6VE4l7x/fydYEhseb76pSLA5pi+7Fpe4cPDmxfjBWxy1CpIBWAX9wrDlALUV6LzvjVkH/6SkMGFzbOzHQxIXvRDmii1cNIDPX8eiCFt9GaKPMNaU+415+NG+lFRuOTX8eG8tI4cGRItTzIuGJFL6kGvLnGocPuTKrRHOgyDyLb49GpFIHQvCt3V1EqBpP2VlbOl9SY7X5UQ12HDE3f1oOYhjKnvg9Ttf7njLNtGerriUiVUszSz9SumNl0C+1bqWjoL724rVotKY9+g3jE2P2JBK0UMWL+dEG+Ch696N9bZQaSbBcbfxIhupQJpkWhnNBjnX3TeGZPZsX9FETmt5XYjq4kfstnDtk2z5QPPdGmZRo68lCRY2cExzfpYLatH/LCrtJngfX9qm6R8VfbigWZcz7LXrLNF1MHhctTJoeXboheCqSjU+Z6OoEgbG+7Csp4FzxjHckX9waKVooiZKGnRTJnA4AKZ70vwI5Nwho336vix/QhyLgly8r8K3EyQxUwwH3Wem7nWxclCJkJB7Wg588TbIufqdsueP10sriZA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA1PR10MB7240.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d8ddf16f-167e-47a2-540a-08dc7a9331d6
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 May 2024 19:12:59.4274
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3iV1RNacRug/kfgDXcWfW8lkO+OEr9nC9KOE8nQjTX/Tfkhpzzjkl2ewdStGn6KFyCqKikIMCdiXg4Att2reuUmL6Zq12rj/odk6VtwuqaI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB6016
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-22_10,2024-05-22_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 spamscore=0
 adultscore=0 mlxlogscore=999 malwarescore=0 suspectscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2405010000
 definitions=main-2405220133
X-Proofpoint-GUID: TCHlC6JZA-Uj9Gzx9xMtTljZgvFJxbJS
X-Proofpoint-ORIG-GUID: TCHlC6JZA-Uj9Gzx9xMtTljZgvFJxbJS

SGkgS3VhaSwNCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBZdSBLdWFp
IDx5dWt1YWkxQGh1YXdlaWNsb3VkLmNvbT4NCj4gU2VudDogV2VkbmVzZGF5LCBNYXkgMjIsIDIw
MjQgODowMSBBTQ0KPiBUbzogSmVucyBBeGJvZSA8YXhib2VAa2VybmVsLmRrPjsgR3VsYW0gTW9o
YW1lZA0KPiA8Z3VsYW0ubW9oYW1lZEBvcmFjbGUuY29tPjsgbGludXgtYmxvY2tAdmdlci5rZXJu
ZWwub3JnOyBsaW51eC0NCj4ga2VybmVsQHZnZXIua2VybmVsLm9yZw0KPiBDYzogc2hpbmljaGly
by5rYXdhc2FraUB3ZGMuY29tOyBjaGFpdGFueWFrQG52aWRpYS5jb207IGhjaEBsc3QuZGU7DQo+
IHl1a3VhaSAoQykgPHl1a3VhaTNAaHVhd2VpLmNvbT4NCj4gU3ViamVjdDogUmU6IFtQQVRDSCBW
MiBmb3ItNi4xMC9ibG9jayAxLzJdIGxvb3A6IEZpeCBhIHJhY2UgYmV0d2VlbiBsb29wDQo+IGRl
dGFjaCBhbmQgbG9vcCBvcGVuDQo+IA0KPiBIaSwNCj4gDQo+IOWcqCAyMDI0LzA1LzIyIDk6Mzks
IEplbnMgQXhib2Ug5YaZ6YGTOg0KPiA+IE9uIDUvMjEvMjQgNDo0MiBQTSwgR3VsYW0gTW9oYW1l
ZCB3cm90ZToNCj4gPj4gRGVzY3JpcHRpb24NCj4gPj4gPT09PT09PT09PT0NCj4gPj4NCj4gPj4g
MS4gVXNlcnNwYWNlIHNlbmRzIHRoZSBjb21tYW5kICJsb3NldHVwIC1kIiB3aGljaCB1c2VzIHRo
ZSBvcGVuKCkgY2FsbA0KPiA+PiAgICAgdG8gb3BlbiB0aGUgZGV2aWNlDQo+ID4+IDIuIEtlcm5l
bCByZWNlaXZlcyB0aGUgaW9jdGwgY29tbWFuZCAiTE9PUF9DTFJfRkQiIHdoaWNoIGNhbGxzIHRo
ZQ0KPiA+PiAgICAgZnVuY3Rpb24gbG9vcF9jbHJfZmQoKQ0KPiA+PiAzLiBJZiBMT09QX0NMUl9G
RCBpcyB0aGUgZmlyc3QgY29tbWFuZCByZWNlaXZlZCBhdCB0aGUgdGltZSwgdGhlbiB0aGUNCj4g
Pj4gICAgIEFVVE9DTEVBUiBmbGFnIGlzIG5vdCBzZXQgYW5kIGRlbGV0aW9uIG9mIHRoZQ0KPiA+
PiAgICAgbG9vcCBkZXZpY2UgcHJvY2VlZHMgYWhlYWQgYW5kIHNjYW5zIHRoZSBwYXJ0aXRpb25z
IChkcm9wL2FkZA0KPiA+PiAgICAgcGFydGl0aW9ucykNCj4gPj4NCj4gPj4gCWlmIChkaXNrX29w
ZW5lcnMobG8tPmxvX2Rpc2spID4gMSkgew0KPiA+PiAJCWxvLT5sb19mbGFncyB8PSBMT19GTEFH
U19BVVRPQ0xFQVI7DQo+ID4+IAkJbG9vcF9nbG9iYWxfdW5sb2NrKGxvLCB0cnVlKTsNCj4gPj4g
CQlyZXR1cm4gMDsNCj4gPj4gCX0NCj4gPj4NCj4gPj4gICA0LiBCZWZvcmUgc2Nhbm5pbmcgcGFy
dGl0aW9ucywgaXQgd2lsbCBjaGVjayB0byBzZWUgaWYgYW55IHBhcnRpdGlvbiBvZg0KPiA+PiAg
ICAgIHRoZSBsb29wIGRldmljZSBpcyBjdXJyZW50bHkgb3BlbmVkDQo+ID4+ICAgNS4gSWYgYW55
IHBhcnRpdGlvbiBpcyBvcGVuZWQsIHRoZW4gaXQgd2lsbCByZXR1cm4gRUJVU1k6DQo+ID4+DQo+
ID4+ICAgICAgaWYgKGRpc2stPm9wZW5fcGFydGl0aW9ucykNCj4gPj4gCQlyZXR1cm4gLUVCVVNZ
Ow0KPiA+PiAgIDYuIFNvLCBhZnRlciByZWNlaXZpbmcgdGhlICJMT09QX0NMUl9GRCIgY29tbWFu
ZCBhbmQganVzdCBiZWZvcmUgdGhlDQo+IGFib3ZlDQo+ID4+ICAgICAgY2hlY2sgZm9yIG9wZW5f
cGFydGl0aW9ucywgaWYgYW55IG90aGVyIGNvbW1hbmQNCj4gPj4gICAgICAobGlrZSBibGtpZCkg
b3BlbnMgYW55IHBhcnRpdGlvbiBvZiB0aGUgbG9vcCBkZXZpY2UsIHRoZW4gdGhlIHBhcnRpdGlv
bg0KPiA+PiAgICAgIHNjYW4gd2lsbCBub3QgcHJvY2VlZCBhbmQgRUJVU1kgaXMgcmV0dXJuZWQg
YXMgc2hvd24gaW4gYWJvdmUgY29kZQ0KPiA+PiAgIDcuIEJ1dCBpbiAiX19sb29wX2Nscl9mZCgp
IiwgdGhpcyBFQlVTWSBlcnJvciBpcyBub3QgcHJvcGFnYXRlZA0KPiA+PiAgIDguIFdlIGhhdmUg
bm90aWNlZCB0aGF0IHRoaXMgaXMgY2F1c2luZyB0aGUgcGFydGl0aW9ucyBvZiB0aGUgbG9vcCB0
bw0KPiA+PiAgICAgIHJlbWFpbiBzdGFsZSBldmVuIGFmdGVyIHRoZSBsb29wIGRldmljZSBpcyBk
ZXRhY2hlZCByZXN1bHRpbmcgaW4gdGhlDQo+ID4+ICAgICAgSU8gZXJyb3JzIG9uIHRoZSBwYXJ0
aXRpb25zDQo+ID4+DQo+ID4+IEZpeA0KPiA+PiAtLS0NCj4gPj4gUmUtaW50cm9kdWNlIHRoZSBs
b19vcGVuKCkgY2FsbCB0byByZXN0cmljdCBhbnkgcHJvY2VzcyB0byBvcGVuIHRoZQ0KPiA+PiBs
b29wIGRldmljZSB3aGVuIGl0cyBiZWluZyBkZXRhY2hlZA0KPiA+Pg0KPiA+PiBUZXN0IGNhc2UN
Cj4gPj4gPT09PT09PT09DQo+ID4+IFRlc3QgY2FzZSBpbnZvbHZlcyB0aGUgZm9sbG93aW5nIHR3
byBzY3JpcHRzOg0KPiA+Pg0KPiA+PiBzY3JpcHQxLnNoDQo+ID4+IC0tLS0tLS0tLS0NCj4gPj4g
d2hpbGUgWyAxIF07DQo+ID4+IGRvDQo+ID4+IAlsb3NldHVwIC1QIC1mIC9ob21lL29wdC9sb29w
dGVzdC90ZXN0MTAuaW1nDQo+ID4+IAlibGtpZCAvZGV2L2xvb3AwcDENCj4gPj4gZG9uZQ0KPiA+
Pg0KPiA+PiBzY3JpcHQyLnNoDQo+ID4+IC0tLS0tLS0tLS0NCj4gPj4gd2hpbGUgWyAxIF07DQo+
ID4+IGRvDQo+ID4+IAlsb3NldHVwIC1kIC9kZXYvbG9vcDANCj4gPj4gZG9uZQ0KPiA+Pg0KPiA+
PiBXaXRob3V0IGZpeCwgdGhlIGZvbGxvd2luZyBJTyBlcnJvcnMgaGF2ZSBiZWVuIG9ic2VydmVk
Og0KPiA+Pg0KPiA+PiBrZXJuZWw6IF9fbG9vcF9jbHJfZmQ6IHBhcnRpdGlvbiBzY2FuIG9mIGxv
b3AwIGZhaWxlZCAocmM9LTE2KQ0KPiA+PiBrZXJuZWw6IEkvTyBlcnJvciwgZGV2IGxvb3AwLCBz
ZWN0b3IgMjA5NzEzOTIgb3AgMHgwOihSRUFEKSBmbGFncyAweDgwNzAwDQo+ID4+ICAgICAgICAg
IHBoeXNfc2VnIDEgcHJpbyBjbGFzcyAwDQo+ID4+IGtlcm5lbDogSS9PIGVycm9yLCBkZXYgbG9v
cDAsIHNlY3RvciAxMDg4Njggb3AgMHgwOihSRUFEKSBmbGFncyAweDANCj4gPj4gICAgICAgICAg
cGh5c19zZWcgMSBwcmlvIGNsYXNzIDANCj4gPj4ga2VybmVsOiBCdWZmZXIgSS9PIGVycm9yIG9u
IGRldiBsb29wMHAxLCBsb2dpY2FsIGJsb2NrIDI3MjAxLCBhc3luYyBwYWdlDQo+ID4+ICAgICAg
ICAgIHJlYWQNCj4gPj4NCj4gPj4gVjEtPlYyOg0KPiA+PiAJQWRkZWQgYSB0ZXN0IGNhc2UsIDAx
MCwgaW4gYmxrdGVzdHMgaW4gdGVzdHMvbG9vcC8NCj4gPj4gU2lnbmVkLW9mZi1ieTogR3VsYW0g
TW9oYW1lZCA8Z3VsYW0ubW9oYW1lZEBvcmFjbGUuY29tPg0KPiA+PiAtLS0NCj4gPj4gICBkcml2
ZXJzL2Jsb2NrL2xvb3AuYyB8IDE5ICsrKysrKysrKysrKysrKysrKysNCj4gPj4gICAxIGZpbGUg
Y2hhbmdlZCwgMTkgaW5zZXJ0aW9ucygrKQ0KPiA+Pg0KPiA+PiBkaWZmIC0tZ2l0IGEvZHJpdmVy
cy9ibG9jay9sb29wLmMgYi9kcml2ZXJzL2Jsb2NrL2xvb3AuYyBpbmRleA0KPiA+PiAyOGE5NWZk
MzY2ZmUuLjlhMjM1ZDhjMDYyZCAxMDA2NDQNCj4gPj4gLS0tIGEvZHJpdmVycy9ibG9jay9sb29w
LmMNCj4gPj4gKysrIGIvZHJpdmVycy9ibG9jay9sb29wLmMNCj4gPj4gQEAgLTE3MTcsNiArMTcx
NywyNCBAQCBzdGF0aWMgaW50IGxvX2NvbXBhdF9pb2N0bChzdHJ1Y3QgYmxvY2tfZGV2aWNlDQo+
ICpiZGV2LCBibGtfbW9kZV90IG1vZGUsDQo+ID4+ICAgfQ0KPiA+PiAgICNlbmRpZg0KPiA+Pg0K
PiA+PiArc3RhdGljIGludCBsb19vcGVuKHN0cnVjdCBnZW5kaXNrICpkaXNrLCBibGtfbW9kZV90
IG1vZGUpIHsNCj4gPj4gKyAgICAgICAgc3RydWN0IGxvb3BfZGV2aWNlICpsbyA9IGRpc2stPnBy
aXZhdGVfZGF0YTsNCj4gPj4gKyAgICAgICAgaW50IGVycjsNCj4gPj4gKw0KPiA+PiArICAgICAg
ICBpZiAoIWxvKQ0KPiA+PiArICAgICAgICAgICAgICAgIHJldHVybiAtRU5YSU87DQo+ID4+ICsN
Cj4gPj4gKyAgICAgICAgZXJyID0gbXV0ZXhfbG9ja19raWxsYWJsZSgmbG8tPmxvX211dGV4KTsN
Cj4gPj4gKyAgICAgICAgaWYgKGVycikNCj4gPj4gKyAgICAgICAgICAgICAgICByZXR1cm4gZXJy
Ow0KPiA+PiArDQo+ID4+ICsgICAgICAgIGlmIChsby0+bG9fc3RhdGUgPT0gTG9fcnVuZG93bikN
Cj4gPj4gKyAgICAgICAgICAgICAgICBlcnIgPSAtRU5YSU87DQo+ID4+ICsgICAgICAgIG11dGV4
X3VubG9jaygmbG8tPmxvX211dGV4KTsNCj4gDQo+IFRoaXMgZG9lc24ndCBmaXggdGhlIHByb2Js
ZW0gY29tcGxldGVseSwgdGhlcmUgaXMgc3RpbGwgYSByYWNlIHdpbmRvdy4NCj4gDQo+IGxvX3Jl
bGVhc2UNCj4gICBpZiAoZGlza19vcGVuZXJzKGRpc2spID4gMCkNCj4gICAgcmV1dHJuDQo+ICAg
IC0+IG5vIG9wZW5lcnMgbm93DQo+IAkJbG9fb3Blbg0KPiAJCSBpZiAobG8tPmxvX3N0YXRlID09
IExvX3J1bmRvd24pDQo+IAkJIC0+IG5vIHNldCB5ZXQNCj4gCQkgb3BlbiBzdWNjZWVkDQo+ICAg
bXV0ZXhfbG9jayhsb19tdXRleCkNCj4gICBsby0+bG9fc3RhdGUgPSBMb19ydW5kb3duDQo+ICAg
bXV0ZXhfdW5sb2NrKGxvX211dGV4KQ0KPiAgIF9fbG9vcF9jbHJfZmQNCldlIGhhdmUgbm90aWNl
ZCB0aGF0LCBhdCBibG9jayBsYXllciwgYm90aCBvcGVuKCkgYW5kIHJlbGVhc2UoKSBhcmUgcHJv
dGVjdGVkIGJ5IGdlbmRpc2stPm9wZW5fbXV0ZXguDQpTbywgdGhpcyByYWNlIG1heSBub3QgaGFw
cGVuLiBDYW4geW91IHBsZWFzZSBsZXQgbWUga25vdyBpZiBJIHVuZGVyc3RhbmQgY29ycmVjdGx5
Pw0KPiANCj4gQW5kIHdpdGggdGhlIHJlc3BlY3QsIGxvb3BfY2xyX2ZkKCkgaGFzIHRoZSBzYW1l
IHByb2JsZW0uDQo+IA0KPiBJIHRoaW5rIHByb2JhYmx5IGxvb3AgbmVlZCBhIG9wZW4gY291bnRl
ciBmb3IgaXRzZWxmLg0KV2UgYXJlIGxvb2tpbmcgdG8gc2VlIGhvdyB0byBoYW5kbGUgdGhpcyBj
YXNlDQo+IA0KPiBUaGFua3MsDQo+IEt1YWkNCj4gDQo+ID4+ICsJcmV0dXJuIGVycjsNCj4gPj4g
K30NCj4gPg0KPiA+IE1vc3Qgb2YgdGhpcyBmdW5jdGlvbiB1c2VzIHNwYWNlcyByYXRoZXIgdGhh
biB0YWJzLg0KPiA+DQoNCg==
