Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF3C74CE05
	for <linux-block@vger.kernel.org>; Mon, 15 Jul 2024 17:42:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721065345; cv=fail; b=SmUuJIr91a8TPDso6Kxp0ACRyZF9W0Jp/Am/40LU0Ya8rNMKSFPXdMh5XN5r+aeo7ti43hCLI+JxwhyZbgZQrN+wrBlRKxxZ+r/wDn21YVu5snyDk/U+2tdYMymaCpeuQkV8w+UxY28oJFc2Wk3qGr/xd3e9VjNV5jDa6jUmIHs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721065345; c=relaxed/simple;
	bh=MOyUTUMnOK/obEXY78YWBMhGCN6Sf0N7Pyi/D0/6nrA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=AQwBKzJSs8tRD9KVZW1LwCwMhiDzF0Q2AeN7EzKBHRpDfaOIw6znaEZksk4LIMk59PRIKh8Z5ePmKoYlADGbeJYYWplwhQwy73W4ZOzRY8nOHMtVrFgBuyX/0To/2F5NuV4xCnQ9I7rGtkfXwCkJZgCE+6en0qZJmXt8FOLatUQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=isQSzpLr; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=d0wIfFCu; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="isQSzpLr";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="d0wIfFCu"
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46FENcZt002997;
	Mon, 15 Jul 2024 17:42:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	message-id:date:subject:to:cc:references:from:in-reply-to
	:content-type:content-transfer-encoding:mime-version; s=
	corp-2023-11-20; bh=KSAjPRyEHlGW39P495p/UAmsyQl+bx2/Oz5gHQtS3lc=; b=
	isQSzpLroHpLMs3igtG/1mKOQ4g75PSFCKyAmbOmzQGlbQGVAlUjtbnN7KyPcO2I
	jrhoY3QhV9R67O0GYmf1l79vLXEYGTJsRXqWX/8cWMNroeZHbgjXFIQA3w9+ompB
	ONYikaF47lYkSNiP3od8ONKu090foKHld6eLbO9juf35h1WsMmP3zZuAF3Rf1vu6
	aDzgBQDMP/ny29Tjrag+jN043yqJijWBWykQ7CdksTZJIQ/lzYYR+LG3m2tuv21e
	bPU2IRbAtgnzSmmXoMGfh+BhgZvXTO1sqj9MOCDbnTpfybztUWGP8QeYvNLK8WK7
	mOORU9HJ/xlKLvqxGrJVEA==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 40bh6suww0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 15 Jul 2024 17:42:09 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 46FGicxD005906;
	Mon, 15 Jul 2024 17:42:09 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2043.outbound.protection.outlook.com [104.47.66.43])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 40bg187j7y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 15 Jul 2024 17:42:08 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=loaLXQ5HVG6mO7c34cX/NmdrW8eGa5IYNl+c1bzQw/cMmax227p0iL7pc4b737fokRA+rNCDPvpPk0/ezGh/KuHI/j9sZ0Nt4h8i1nk7vIm1WSRKo+f1kPH7u25YsX1xNECwMbe5h2feVscVcdnvpO/YK15dKxdY6BOKas+1j48/4a8gEYVy0NNG5UWgbd2NFo6EJqZuEFLnttjDrR9Dx2PMNkaZVDo5eBJwI6AIEA6ZgaBtpksllGT3WfvHrK64Wt/R3Zxha4+Yk0LYb7A9qOs3saqQGYsWsW5oemDsjDd+1/u6LttiDYZIfC8uTLJIwYVSB/5ufz6lnJHm2hMnKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KSAjPRyEHlGW39P495p/UAmsyQl+bx2/Oz5gHQtS3lc=;
 b=YH5Ea2oszEdl1OGwYKUqqWT5sL9pqSIDQgnmiASbv+3DtWWu7FXdr/vqD/Hacl2lk/z9IciSFM0Efmnht7Gm6BJMRD0U8PINiCv5FCwXUTOSEOQBUipr4At0pdByrveOmPmhPBMRjlctOhc3+02v7C+iSdENnghEt4owA75+m8BNfUXKjzjpiF8SRtfJcVzODCy+5uLts/8kr9J9ikYu8g4z0dUGeQJUdgU9qLZzH4HGkwL4BcnlG+/OjfBcFTVVAMHOkoxg86su5RLvfTjxsSVPiiVcbRNY2XP+fMFSIIkSaFreA0yZIAVrxhbAfA9mwTBSqr23W88duZaQlCO5MA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KSAjPRyEHlGW39P495p/UAmsyQl+bx2/Oz5gHQtS3lc=;
 b=d0wIfFCuPDSI5bXUkDOBH/IA0d02aV1SJbSfXbcSAPfrHVZLGmrbBUmjFRPXjJMuwMlGpuXBl6tVcipIq0+Kz/lXMUnllLCXExK9dDr7nQFEZbPUdsw4arpKPPPMHlCVNTMDeWRCboiTmYq+Nr3aHS064N4Kdi35T7ZvmO8EVZA=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by CH4PR10MB8074.namprd10.prod.outlook.com (2603:10b6:610:23d::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.29; Mon, 15 Jul
 2024 17:42:07 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%6]) with mapi id 15.20.7762.027; Mon, 15 Jul 2024
 17:42:07 +0000
Message-ID: <678e14f9-6480-4ed5-96d0-dc73ffeb9905@oracle.com>
Date: Mon, 15 Jul 2024 18:42:02 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 04/12] block: Catch possible entries missing from
 hctx_state_name[]
To: Bart Van Assche <bvanassche@acm.org>, axboe@kernel.dk, hch@lst.de
Cc: linux-block@vger.kernel.org
References: <20240711082339.1155658-1-john.g.garry@oracle.com>
 <20240711082339.1155658-5-john.g.garry@oracle.com>
 <b97da63e-386d-4cb0-9bf1-cfbe00154979@acm.org>
 <5fca6dde-bbfd-4a25-8d1d-c1257540eac4@oracle.com>
 <1ef25aa9-dfd6-409f-ac92-9c443a05fe96@acm.org>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <1ef25aa9-dfd6-409f-ac92-9c443a05fe96@acm.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM9P195CA0030.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:20b:21f::35) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|CH4PR10MB8074:EE_
X-MS-Office365-Filtering-Correlation-Id: 48894b75-6de9-4197-41a1-08dca4f57214
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?S3lscEFxMXptRk9lVmE3TE1NTlRzTEpCaGtSNXhLWHFkaEJwaGFCcWNyMkxh?=
 =?utf-8?B?RWE4RnIrSGVCTk9Pc1dUbitkVXdrODMrUW4vOEhDRy95NWQ5U2k3eHliMDVk?=
 =?utf-8?B?S08rRXI5VG85SE1CVGs5OVV4bXFidVJWVTVXRFNKYXVlRlBMTFZBdGdKSW40?=
 =?utf-8?B?OEJTSFZWYjFsR1M4cFNhQVBnU1Ntam1WcDNISk5KR0FDdk52K3kwWi9mZURz?=
 =?utf-8?B?MDJFdVVGaGtFMDNTVzFlU3dKZ1BHQ2VSYWJFZW10b0lUajV2R2tXWG9SbzM0?=
 =?utf-8?B?bEs5bGhpM3F4Z2RSMVY5bmhobHY0dnNERmhOVm5MaHdBQWpwUXVQMHlNaEVt?=
 =?utf-8?B?eFNUV0N0NHNnTDl3TVFBR2hhalBneU1odnQ2T3piV2FaRTN0V0F2RDlDK29n?=
 =?utf-8?B?WGJTOTNndC9qUXVCVHNKeEQzM2VORVZGREt1SDRhdTlVV0pHaUNaSCtEY0tT?=
 =?utf-8?B?ZGsyM3didGQ2bjMrTDBUdFowRWJQc0oxNTZyYkh6Mzk2T1BXSkFFYmFITVRD?=
 =?utf-8?B?bzRMa1FGZWtOY3JoNGZCTVFoYWJ4OGJ5TVBhZ1VKNmVmWDFrRDIycHFWcC9T?=
 =?utf-8?B?RWZFMDRIS200dmZmSld2ZHZjanduK29tWmY0ZHBnazF1TU82SjJFTUY5R0dx?=
 =?utf-8?B?ZUZRQnVkUVg3UGJOcmFicXlwZmNqOWdBRUZVRmZFKzN6SFlBcnZHdlA1RXRw?=
 =?utf-8?B?TWxBckNodi9RR2VJalFmdDRDbXdSdFRlVTN0a3Z6YjJWMXlWSjczY3Z1UDJP?=
 =?utf-8?B?WCtHTVJhZ1FPZEc0bWhsbFJRNkpSeC83RHpaSzl3K2x0OEVyS29uYjhCQnpn?=
 =?utf-8?B?cnNoblBwWGU3VUtSSm9Kalo4eUEvY1BGbm5VZW1TbG0rWjhqZTdPVGpaRCtR?=
 =?utf-8?B?NXFJbHRRSGREOG1heC9LZi9raGNGaUw0NE5Ua2VQdWdpNTZWR0FySVFsSGMz?=
 =?utf-8?B?UWVKVHJVYlNQM1hzRU1zUWhwaklYQWlWZHk5R3BuKzZYMnlwZjFVSitWS1Nv?=
 =?utf-8?B?V01qRTBxT0s0dFMrUFdBNW81Mk9xNUhXK1RsSzI3RjhnUlg3eUJkSVJNNGJq?=
 =?utf-8?B?N3Q4SDhkZmRUSEkrSGpLZlBNMEFTMEpUb0dDM2FBc24rTVNkRTZTdDZqWE1I?=
 =?utf-8?B?bUlCR2d4L0c3ZFJVaFpiVXY3RC8vNkVmQ09STkVCekVZWTdUdjg3UVVqbmti?=
 =?utf-8?B?MXdQdGFGYzE5VXFacnF1aEFCR2piTVF3TlFGaUhXYk5WWS9kbENYdERKYk9P?=
 =?utf-8?B?cSt0Z0dlc1hkUGxOQytsWHlWK25iYm5RNUdrU2hpSE5yTzdRMkNXTG54MHVY?=
 =?utf-8?B?ajhMMnpIWkhDV2oxTHdNT3lJV1FZd2pNNklUbVJpWWZqWDVkYldpcjhtRTd6?=
 =?utf-8?B?UHRXZGljS0hLRGxveGgyRnIvNlZ3ZVJtc0ZQaXJlSGd4NnF2QWY5eEs3eUNy?=
 =?utf-8?B?N3NtOHZJR2JyVHl3RlNuL3B6SVlDVkk4cTBaSlJ4TXdvMVVYdXZ3UTB1ZVVy?=
 =?utf-8?B?cDJxS1RsUWtMdFo3VFk4UkVrUFhHRHJlQUtKYitxSnNxcWpVeHNFeW1aeWJY?=
 =?utf-8?B?dWZKdVdkaWg1cHNmeDZkWXJZREV1M1NrWW5jUjJVWVBoY2VQNzhyQkpOaGJN?=
 =?utf-8?B?VVROcU5GOS81RFU1OXlxdmtpaFMzVUg3VkpybktLZGxTR2I1RlA3L3ZNUlds?=
 =?utf-8?B?R1YvQ3RSNVFwUjUycGtWcEIydkMxWjJ0Z01wN0Vydks1ZXp6d2YxZml2cTdQ?=
 =?utf-8?B?L1pDOE8zUjBQRUNiWXJkZzNWdTRpdUQyQnVKbUM3ZW90ZTJtU3QxM1ZGZWNF?=
 =?utf-8?B?TGVFdjBhWTZBZ215SE1Wdz09?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?QXVZam5PYWd3d21VTzNKeVJNTmQzVDdVZ0hUc1FtbnRJcjIya252NmZIaXVT?=
 =?utf-8?B?VHlGd3FaVG9tU2ExVmFmOEFUd2MrakRvTGFnNFFkN1Z3cEI2dG9ISHdhNEcy?=
 =?utf-8?B?NVVZZnVoY251WTQrUEM1YmxPQkpmOTlISU1YMUJCc1Z6SXNic0h0MVlpSlQ4?=
 =?utf-8?B?a3I1NGdINnlwUm5uN0xwUHFvUjVBSGFOZjRzeE1FRUpsQ3lzNmVrNmRoOU9a?=
 =?utf-8?B?QUg4MnJTNUZXMGg3RGdWdUgxSXR0Y1FrdVEwT01BQ1NoWUxTZTY1b1J5L0Ro?=
 =?utf-8?B?b1F1ZSthMTVPNGpsS1N1NDlCL2NqOVBKUzJHdUNMSXdTc0FOOWcwQ0graFZs?=
 =?utf-8?B?R29uQVd4K25PakJRcEJISWpmSFlxV2M1RlRXaXh0QlFmajhacmtiNGMxNFM4?=
 =?utf-8?B?RXF2YjhUTVNrdExqSUU2VEFKQjJ6M0YwVGpDV0tGeFk0aDZXbUZwTEh4bUg3?=
 =?utf-8?B?TVhGQm5hUkt5L0xYV2Z5OS80NGJzbFdPeWlQUnVsU2thd3hIemswenYwWUNl?=
 =?utf-8?B?QmZZNjltbjhZS3NkWHd3ZjI4b0RTUnJEa1NhOXpvVE9hMHkzSDZ4cXMyMGJn?=
 =?utf-8?B?VC9qTUg1ZEVpait5MmRGbHlXeithU2ZsV3Q1YlFrNysxVUNML3pZTmhvMzNU?=
 =?utf-8?B?bktIZzBYdStONHY4dnVGMXZJSFhrSlM0VXVGRko1Nmx0TitXVXgzak9rYlRF?=
 =?utf-8?B?Ulo0UzlzU01jcjgxaWlsdTB4NFgxd3FWUWsyR2lsL3lpa1FFbUJLWTdONXpI?=
 =?utf-8?B?K0pZTElSS084bDhsSE5Oc3cvaVlGeXh2UkNudmRWVTVPb0JXNHA0Zkk3NXRi?=
 =?utf-8?B?K3RGUjYrNXo2cWthWGlDb0VPZ1RpcUloL1F2Wkl2cVI4WWZyWFRpTUk0b1By?=
 =?utf-8?B?cU80OHdFTnE3OGYzRXhjZVlrMTNSUWF4S2VnOFptVGYvUUFJZnREOURnYmU1?=
 =?utf-8?B?a29Mc24yczVYTnd5UExwTzlKY3hCU1dCaEdjcXZWRlFxdmxrUTNZVlIwREt1?=
 =?utf-8?B?a3A3OFN3NUVubHJYUkxUTmZPWUNWY3BSQ3R4amhodWpLWEpKZmdMdXl2Tjls?=
 =?utf-8?B?dkNCOWVrdHlHam1aamtoVXI2L1cxOFJmYVpheFBFSTk4M0FGWlUzZ3RzbTVv?=
 =?utf-8?B?ZVo4NlE0RnF3MGI5c3BTQXJDalZLZVdTQlVFODdRNmJyUkZWWmtRMUFXQTlr?=
 =?utf-8?B?SnVwdHdkRWF4TFlQQ0lKZnV1aVV0T0dQaXJlTGRPMGdnMzduL2ZHVlAvMkxY?=
 =?utf-8?B?OFYrNFo0NlNDWkJFbkdSckkwc0FOd1RlMnd4S2tFSEt2YnZnM1pPSEY0d2Zm?=
 =?utf-8?B?UUthUitQT0RKZ29MU2hSTG9TUFA1YUJQTVJXZDBic2YzK2xUODQySE5ZcURO?=
 =?utf-8?B?U3Q0RGtGRE96VCthY3NQNmF1L3dDZ0JNWSs4cnlLaTVwOFNZOEhhejBmWFNo?=
 =?utf-8?B?VEZ2QzJ6N2tMS2hHMHpFSGV6L21IUXZ6eEdQZjFqYm1SM1YyOVQ4T294cS9G?=
 =?utf-8?B?REIxR3EwaisvaHVwSnkrd2d6c0RmQjhBcjJZaXFpQndTV2V5RXpoNVE1Mmhi?=
 =?utf-8?B?QTFubDVXWUpOQlBxem1UZmU0bnA4R2h3RjBXMlcrZmhoV0ZHWWtHbHVxUkl0?=
 =?utf-8?B?d1QrS0lYeEplNXBBMmpjWWFUQTArcDFUSTB5QXowMWFpMFhnMEhybk5WMFE1?=
 =?utf-8?B?ZkJEa20rU0JFZDRnYkJjc0NqNHdOMlAzMlplTkRIRUN4QnJiV1pnQnN6YXFM?=
 =?utf-8?B?c0UzeGQ1MUNHNzh2RmhBM2dCOE1EUXVvdlZHcmZrbDdJblhvMkJmaTE2WHlz?=
 =?utf-8?B?M2hCU2Q5YXhuYzlFcnBYbUFqbm1qOE1TeGFFVGlzc1JLQzkyRHc3L3MyQ3FF?=
 =?utf-8?B?Rm5LZnljN2VJNzdOS3B0dUpTVTNvT1hzekRuRFBmUHlXdWQ3STBaL3c5eWRQ?=
 =?utf-8?B?cEhmZTNZTStrQ2k5eUVYU1VEVHQ4NFY0UURpUW4vbFZlSDhCd2NnM3dXcWlO?=
 =?utf-8?B?T3laWnB4SUFBOUs4NnBjWTd4azZhVWRtdnNkQ0JKN0VSVmI0Mm9SYUNzZDB1?=
 =?utf-8?B?TUhZVlN2MnRKYUZIa1FHa1F5Z2tDV2pGWk5oaEJ2MGtqMGEwVW9ST3RoS2lS?=
 =?utf-8?Q?M6i1MTmj1bljC2VVmkfUxPqum?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	ICQ/P3t5uEad27VW7FyXrUr+EsBqhGh6S0a7YIrxc3T716EitGs+vJcAmho+jkmBOiW/n2grGPHGmZwMLMU/kTxaj99ph+cnaYysvJxheESyA24VNA2MMuypRKRNL82L9a1l3REqCfoRGvl/XWMy0H3pfj8sHg4GDJwf2zBoLQS8EZU8gYbSWeoi/IPKs1ejkzhwm/Mu9iUD5euHdgFiZVWYJVujuv28gfn2PQPmyb2WglD717pOsgEDmXJqrO2ZGQ2hdl9EgqRafTMZsS9DWk0TFyHc29CLcS+a1gC5HpdbxXHskommjFtQH8eqVXZifZPhcn7uYkeZvmgIYON36AaE3Q2RyjdoheVDuXVMTiUkf5T8b4RXz/hF5VHtE6EN7IXFcZ5MpktDuvfBZhxcvkDImloOZUHZ4ChxDQMZg8iBU68cciiU+coX+SAW/XnisATQB28/9wLO7zgwkyMX0OtowZovOEhJQsE25GyhRZChL39DO9ltxN813VK4g/DJkAAVq7aEktyoBheTUNY8huaCwh1sdeRYU99LUsMvtWh2uEvx2h98qLNIqQvGl3ch5WG01mJHiUgwH7lTe41tuCyVqWrLMHef4VfjGNtHTfs=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 48894b75-6de9-4197-41a1-08dca4f57214
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2024 17:42:07.0647
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EhdhLg9Vn8ooY69aNuc/A3NtjFYfLE6fwGpj4M7iF0FBW4NWrSefpYsipZnbZVYfZ6rj8N3fQxDXUvyGE21Xkg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH4PR10MB8074
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-15_12,2024-07-11_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 suspectscore=0 bulkscore=0
 phishscore=0 spamscore=0 adultscore=0 mlxlogscore=999 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2406180000
 definitions=main-2407150137
X-Proofpoint-GUID: SK8FHTNIbxCqbXm-aAkSx_AjSVWWv785
X-Proofpoint-ORIG-GUID: SK8FHTNIbxCqbXm-aAkSx_AjSVWWv785

On 15/07/2024 18:28, Bart Van Assche wrote:
> On 7/15/24 12:54 AM, John Garry wrote:
>> BTW, BLK_MQ_CPU_WORK_BATCH is only used in block/blk-mq.c, so I don't 
>> see why it is even in a public API.
> 
> I'm in favor of moving this constant into block/blk-mq.c.

I was actually thinking of moving it to block/blk-mq.h, as much blk-mq 
internal defines/prototypes/inline functions are located there.
