Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F325A2459DA
	for <linux-block@vger.kernel.org>; Tue,  8 Jul 2025 21:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752010840; cv=fail; b=GagP3Ev6ZRR+IuYfNtKrkKtoqMChvtlOEjrGCFQTOU9ElC6a/lMmqzcz11T58IZgV+5w6AdXQnLQAHttqNijmk5GaWWS8rgLMjHrWccNMKGkku2mqsC3AOY6IFqsJD/jc4IBzqr/wvQ6ew0DXGRn02GOrFRAG+PDnQxNnKmx0nU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752010840; c=relaxed/simple;
	bh=E51YzvKyU2MdXScUntvFSfMXvUMPxwHuLv5iAI5llHA=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=u7cgOC5r32FcZF2R/UaMHDaAN9qP0I9gphf/gYcm8AJquQ2fBdx4SXy89dcqzbT2DwxJq31sOK/nQKjl2gXzPPOn3oWxInpoxrOAH88ZI0HXdbQyqVCuxhVtKcztIiNHQ/FTURumFFFtpi9iEWEYD/MmNQDWnho8O1f+Eb4Em/I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=kH98AVld; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=r21Cgf6L; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="kH98AVld";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="r21Cgf6L"
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 568LZ80Q000314;
	Tue, 8 Jul 2025 21:40:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=W7vkL3mATQmcBHVgpyXATOANsFEr2HG4uDRzgY2lud4=; b=
	kH98AVldAvSC6PoLFWd426aaVzSnL3rtVc4bzSFVJSWXM1oPW/ZJ3e2EMkJHQA4M
	wDaAorqQtqEExOGiL4q3cVyFVHa+obGLOKdVbz7uWkyGFjrMgawpnN2xtPf66yDz
	x88BFMu/BoW/OxnEhsIzEz9G/VC8daTvIuikgKG6u7RnHhbmchhxEc85bxQh1PR4
	G5xBu31FhuqUe8QD4ItHpE6vlYMMJL/D0oKPfSumujuoqjuwJfkQvUyMroHSzI0x
	2HhcJHONWEWXgMP/FepzYA6hW1eusdG59wgfaJg5zSKEOCg7aMG2eKMZsNbpfqbJ
	QZA7kW/jfXqIhr2MtWGkdA==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47sar602hm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 08 Jul 2025 21:40:37 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 568L2gYk027323;
	Tue, 8 Jul 2025 21:40:36 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10on2079.outbound.protection.outlook.com [40.107.94.79])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 47ptga5h5k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 08 Jul 2025 21:40:36 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yDmVqczvEJjQJKFNvaxuc7Lunah+bd9T4d9OQk1j5xrnIDAmNBdN+j06SO22BO7DlwiN7golJ+ZNeN2z1yXyY9uwauNBgLl1q8mh5+ZSwFlgz5VnLMyoYNHVnmD7+xNtjYCnEjREs75qpm5JEhF1tPKB84drmeo3GotFy8IDVrkBGCFModkpS3Hqhg3g1JJmM1mwoXzqnUGwKV375W5dNldvnPwo/eKzIh3e9eBb1Q2h0TIJ1mwaw1rl9GB4nQfyMC8wAsQMsyP4KNDDkAxaUB1F0ObKYFqQvNOsVH9JyOKkb9rxciBqpB7IW3lvfo9a909hGRtPMknZFnBE1tfdEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W7vkL3mATQmcBHVgpyXATOANsFEr2HG4uDRzgY2lud4=;
 b=vhBB6kT6fAg2+2di2EZp6X37p9DC/pSSB4BjAr4D8hU+7wI5LYiiV0rmvVCL3Nk17PvMM4fcCKs6VlvD9J4iJ12MVesECY86+XeSA07zBYYpBjA2n5ZFAIDGvtCRC0ZEywJSzWeXRwxqGVfp9AIlhALD0BXDKw0YoprziYDhr3sqyzEBcpSLWfy/BbzibNZWDYSBXuOLeEo0UH7zVYgNT8CxPTmKkyXrg+7/VpjctBuhYqxuTqKoYiBfVMvNjR7vinSaMTGRH8XDie23en+A8gwSoNsAmiQtOFTABC6aTnMYjcI6vA7DBfluHqeux+CU/1Kng0CaQ2SL7/gP6xkxDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W7vkL3mATQmcBHVgpyXATOANsFEr2HG4uDRzgY2lud4=;
 b=r21Cgf6LJ/cLy0hOmrPq3vsGI9ar4AYN0m+njJOIbZNlyBN9f+3S5sv1lNe4bb0zi/P6mGmsC9Gmdmh5ylmRhzNz7akBCVatXBvRHVZv6RhRaEa1PWR9Sm/k9yyLB8Rr5Jgw9Hq06ZF7AYRc7iM3w1m5+RLDve4xfi7IzaoYtjg=
Received: from SJ0PR10MB5550.namprd10.prod.outlook.com (2603:10b6:a03:3d3::5)
 by IA3PR10MB8441.namprd10.prod.outlook.com (2603:10b6:208:581::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.28; Tue, 8 Jul
 2025 21:40:33 +0000
Received: from SJ0PR10MB5550.namprd10.prod.outlook.com
 ([fe80::10a5:f5f4:a06d:ecdf]) by SJ0PR10MB5550.namprd10.prod.outlook.com
 ([fe80::10a5:f5f4:a06d:ecdf%5]) with mapi id 15.20.8857.036; Tue, 8 Jul 2025
 21:40:33 +0000
Message-ID: <9a425680-3bb5-41e6-8d3b-89ea63916fb6@oracle.com>
Date: Tue, 8 Jul 2025 14:40:22 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH blktests v2] md/002: add atomic write tests for md/stacked
 devices
To: John Garry <john.g.garry@oracle.com>,
        Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
        linux-block@vger.kernel.org
References: <20250708113811.58691-1-shinichiro.kawasaki@wdc.com>
 <37df2f62-f5d2-4d6c-903a-de56a6ebc6f8@oracle.com>
Content-Language: en-US
From: alan.adamson@oracle.com
In-Reply-To: <37df2f62-f5d2-4d6c-903a-de56a6ebc6f8@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR13CA0150.namprd13.prod.outlook.com
 (2603:10b6:a03:2c6::35) To SJ0PR10MB5550.namprd10.prod.outlook.com
 (2603:10b6:a03:3d3::5)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5550:EE_|IA3PR10MB8441:EE_
X-MS-Office365-Filtering-Correlation-Id: fc32a6b9-77c4-4ef2-f40a-08ddbe681108
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?QWxlRlk4NzNLWkExMFZYVnRJbTVlOTFFSE5wT0QrK0lvUm1KL3VBZUdyOW5V?=
 =?utf-8?B?NUhnbkt4NjV1cGhJaVFMblFqWHMvQVFxRlFwVUNFeXlKMVdYSklEWnRLblZH?=
 =?utf-8?B?cXgraURXRVpod01rRGRmWlBpR3NpT2hLYURTYjNabXJ2bDVmNm96K1M5TUJY?=
 =?utf-8?B?WTA4SmVaZ2hNYVV2bGJqZHlyM2ZvY3ZzNllFOHhBaUQ1N1VYSitmUUZseGRT?=
 =?utf-8?B?TUt0UVl1NFRyV1JZQ1YzQmJTN2ZQOERzOHNKZThoSXJHSG9VaGFJN3pDbTNi?=
 =?utf-8?B?VTZ3N0hUT2FJbGZtckw0VGw5Q1QzUjgyUGkySzg5OFRwVzRqaFZJV3FxR0Fv?=
 =?utf-8?B?T25Pbm1NTTkvY1NRU0tJTUQvZ09Ta0FCWjN3bkRkK3grQUc2VzBkY0l6RHVC?=
 =?utf-8?B?WDVWdEthTTFJL0p1ZWVQSmJGRUxZVmh5ekdxVTFQaVdkT0JiWE14UTFPa0Zl?=
 =?utf-8?B?V3B1VEt5MHFuQWNWaEtjd1BsREE3OEZ5YlBRRENpZHoxWGZzT211V01ya0Iw?=
 =?utf-8?B?d0k4aTdmSHR4Q0dKR0hSeGRGaFhtRmJxR3V1ekltSURrTzUxSkZ1UDI5MVdk?=
 =?utf-8?B?V05yUFpyUGFVblNkOC90c0NxWVk5blcycXZPaTIyY0k5VFVCaiswWTFGMlJz?=
 =?utf-8?B?RHg1RlhMWW5JK0ZidXZpSFpTclN1WUNSYk52c0R4QVk3NnZjOXZYNEVMSU5n?=
 =?utf-8?B?MlVCdkQ4aGFPMjM0K0JldnB2ZWRXS0VEcFRNeEhQWVM3azl0UzJuQ1BxUC9D?=
 =?utf-8?B?S3phWVFVVTF5anpZeEtpTkhpUjhBVUY2QVFsZGMySkNnaVN5eGlTVms4SmRG?=
 =?utf-8?B?eGRLTzg3WWpER0lWT1lwV0FvS0pLSGlvd3NaVGlBdmxraE1Fejh6bG45b0Q2?=
 =?utf-8?B?L2RDbncvY0s0VlhlREhDYWdRaUdoZUxjZWw1OTk1NWFCSGlPSmd6SG5kdUU3?=
 =?utf-8?B?VzlSaVkvb0NERC9kWFNvOUo5L2pBbFdzeXVCWTV6TnltbGtBZ0RJTjN4MWFV?=
 =?utf-8?B?OHlyOWg4Y0Z2V0xidko4ZzZielg5MXZDUXZ3L0FOSFVaZkppN1hGNXNER2dF?=
 =?utf-8?B?d2JncUl3Tjd3Z2c5UkJ2N3hJVG1NaUFVY3RJbjcwbG15cWFVd3Y4WVFKeGtL?=
 =?utf-8?B?NXl0REhsNjRvTGhHT3dLRWo3Rnl2QWJZWlB6T252Y2NIUjBnOU1NQzZndGNF?=
 =?utf-8?B?Nmd6ZVBVNHRRRWtaK1Y2dVRyTVRRTHZsSkExTk52Y083ZVdBTmFpOG4rUnI3?=
 =?utf-8?B?QmY5MStEVXYrVFFha1FXbVE4RHhGeHVvUDhVNzdZTUJ5SGp5R2JNNkhjeFU3?=
 =?utf-8?B?Uk9YYm5sQmNFb2dUREw1aUlnQm43bXlDQzlnbWYrQk5xeFlEdEo5ZDdSbEhs?=
 =?utf-8?B?NUo3TWhCaktpVGNva21mRXpaSG1RbStGc1pNNzNUT1BzSmoxdHQzdjhOOTRW?=
 =?utf-8?B?M3FrUm14N0tOTy9kaS85SkY5TEJQUlRWeisxZWZQU2gwVzJPUU5FdkpwOUtt?=
 =?utf-8?B?VnFxRk9XQyt5bGlvNU5qTk9yR2FVd0VpTlVTdjNDTGFueWg0OTlUR2paUm1w?=
 =?utf-8?B?dmI1YzRqKy9ES1FkRWhhY1g0U2p6TWdWdWpnREZKMklWZVNBUktrelRTcjNt?=
 =?utf-8?B?OFJsNkloRG13L0Q5NnNTTFRkTVFENThPYzNNR0ROTlBJbDEvWVpaeFlRYlBo?=
 =?utf-8?B?NWdidmFZT3dHVWlHV0hsY1BYbXp4YUtXMDBSaGtuamlyUHkxTU5EcExOWnh4?=
 =?utf-8?B?NEdwMVYrTWhuT3pFdmlSazhpTlNiUmVjWEJXSTVzU2I3cjI0cE5GeE9nQjZE?=
 =?utf-8?B?ZDhOQXBxOEtTNk0rNVRVT2M5TFA0d2pwUnliNUQrWHFBZTk2YVNBSllEK0hl?=
 =?utf-8?B?UHBoUUlIeVEwNHFSem5rSWVDSWxhR3RmeXBuMG1RUUkzRkJkNEdtSERGWDlv?=
 =?utf-8?Q?GccXjDn2CSY=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB5550.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UExBaHp4RjdEcTBPUHZGcGNEMWJ5VVZzQjJjVjkySE82Y1U2K255N3JSWFdY?=
 =?utf-8?B?dmdzT2toalh0Vm9uS0lQVDcvSXpMQVZJSU55S09YRVRGK0hGTlVWWllaZnhv?=
 =?utf-8?B?c3BYUG9kS1d0aWVWS3g0QnlESGEyTTBwM281Q1A3c3E3YkdSQXNucU1oS1I4?=
 =?utf-8?B?d2pBa21vME5vVjIyMkFhQnN0Znk1dGxrSXhKN25FTmVha01sZyswVHlDMm5y?=
 =?utf-8?B?Rzl5WUt1NHU4Vk1lOUNqUjRvcWVlWmZoM0VEZlFCWHVTTUJtc1NCaGt1dStW?=
 =?utf-8?B?bjVVWnM2VVM5WjMwSElQZ3dzNDNlZzdpRFZ6WlBaZ0duRUNLU3ZPbGJsUXRJ?=
 =?utf-8?B?ODhXL0ozeHBEemhNcndDbHFhRHhWNm1qSTVOODZKL2xlK3piMEpGVWtlbGlo?=
 =?utf-8?B?SHRiSldYL3Q4OTMwaFhaeXlnaWJpclgyK09QUTNIYm1XQ0k1dTdVc3A3Y29s?=
 =?utf-8?B?VGlLMTJNWW1XdG5MQUgxaUlha1dLdFJBaHNINy9QdHlVaTZjN0RCSU5vNkl1?=
 =?utf-8?B?QXhWbWNjMUZ0d3hwc29qd09IUXFXS1E3aHo1Y0puYmNyWDVNUGRIQ0ZiZDlm?=
 =?utf-8?B?RFJhdFh3U1VvL3ZGTllhQWJSd05FL1pPQkE4WlhlRzZTZmN4VEtURGcvMHNU?=
 =?utf-8?B?RDZMRmdwZ096WWplblVEMDR3QUo1aThJSDVmbzRFWW9FY3RCOHd5VGgvdHFs?=
 =?utf-8?B?U1J2bWpaZWZJTGx5SEtkT1VZeUl3azI4d3FEb1dxY2ZYODNFeGJJSTgvU1NR?=
 =?utf-8?B?NjFLaGpYOWl2WTlCTXgybHlwQUVTSHc0OFFqTGJIQXl2Sk1LeFZwRHVXb2JL?=
 =?utf-8?B?RHRQeDMzbk85TmVFMzQ3Wm5uV0p1dzVUdEFpSklpTmNXdnkxTWZwdkt5aGJ6?=
 =?utf-8?B?Vm93SldBUEVxOUxxWmRjR1dudmpFd09IY1NWZ2VjRlVpUk1wVFNTRFlsNzU1?=
 =?utf-8?B?d1hUd01NdTFvNmlYWFMxenJ0NTI4eDZzRm1qSHBRZDZmbEpWdy8xQ1c3VE9P?=
 =?utf-8?B?ZW9lQVdKeXNvNXNTYk05c0tMNjBjNzRJNFNEVXdtSkZObGVncmVHQnAzUmJW?=
 =?utf-8?B?eFk5M1doWVl3dnNaeUVpUU16NXdaOFFRWlA4MmpZTHlqcFQzbVVLSHAyNDg5?=
 =?utf-8?B?QzBlMWhjU1RGMlI3T3A2alVPSWlIQTRLSFJYaTkvWm13aytQdGJnSnQ0NDNQ?=
 =?utf-8?B?cDB4UEp1cUpIYWYreU5XYlc2UzFiSkUwMWhWSDN2dDM2aUdwemM0cUl6ekhY?=
 =?utf-8?B?WWpTekJ0aXJLdXRnVkRjbVU1ci9NSStiVGg1YmMvbnpsbmxaakh6NDFlTXlF?=
 =?utf-8?B?T2ZRNmhBcUErbXJ2OWg0OGFRNTdweVkrRjF2cUt1TXZGeDJxOTZlVjh4Y1B1?=
 =?utf-8?B?TTg2L0tKWXBueEF5ZWZHWWJsQmMyN1NydlV5RGFBSjVyc0NyeGFBRjNhaldm?=
 =?utf-8?B?bkZrUlA5dnRkM0xUMVZQcGJYRVlNeFB5bXRCSkJ5Q0djTUtjTnUvVkZJSlB3?=
 =?utf-8?B?SXhLbjBWMldLTlpXNkV4S25Pbkk2dUN4cFhwU1lZMmQ5aVdhQnUzL0R2cnNN?=
 =?utf-8?B?ZmNZUzdNL25RMCtHTWYyTi9rSGFPdFp4dllZZ0pBNVh0S3Zmb0lLZ1pSbS9q?=
 =?utf-8?B?TSs3VGRnb2JGYUxtUjNqaE1IVHBGVVhLVWlqd01YSWFPcDdxaUt2Q3lzU2J3?=
 =?utf-8?B?YjYxZ0NzS2o0cExGLyt1dUwvclVLSXVlKzJ5Zmk1UDlDbmM5Qm9NaTZTQ0U5?=
 =?utf-8?B?N1BOUDk3NTdCemhrcEdlWjFSWTZTamdzWEVpNDI0VDJQTWhGU2EybUU2aEhC?=
 =?utf-8?B?TmI4d1dPdXlpTTRzQlIwSXJVZm10anBMVEJEeTdDWmhHQXMzditYd1J1ZFla?=
 =?utf-8?B?TmduQU9oUlVDM1hLa3VUTXZSUE8yV1ZnYldWU1JkRnZKRXJtZTRiWEpTQUpJ?=
 =?utf-8?B?SlFna3BRM1Y0NkZpbkorcHYrbno4NGNiZFo0Mm9MMjl5Mm9vaUordFpJcEda?=
 =?utf-8?B?cVF5YkM0b0ZzR2xXR3ZCbm81TVIrYnZYdldqZUN1dGU2ZndqNmZaMTNQeFVH?=
 =?utf-8?B?bkVWT09qc3J3dzcyTjJhMVIrTithNzdFOXhBS3VPZDZaN1BwT0Z2SHJITWh5?=
 =?utf-8?B?Ym9vMERuR0pETm9EaTZtZXQ1Sm50ZzNyZHptL0V1ZzNuYXhIKzBBeThTWS9s?=
 =?utf-8?B?ZGc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	AVe/gHQdbjrzNjGkHDZH3gYItP9nRPrBl13F25FW5LQ6mYQd9RZN6RwsDEUPwLwg0Q7MWu7xMaIoAM8lOdrYBTPttUqfH9Nf1wH8ZgFEOtJNffYcWrbigr51v87zNkCuWXSesrbTqEs7d9iNDRKzdyvRg8sjHfqpx5rj78H1C/Si8AWeqTPwZW1zAB1OWz3EjzliZR/1Huhcuj+IPgXqbI7Wg87X31uY1rxaxAHOUZ0REX43IaUR5N7lLEcGoH3jXwwby16NFkxN9IinB1uIk09gBvuoGkcjsaUuSw1qDztnIKTcSAiFR5aNlMVVHtizIOiGk6/ihoDNc6NXgEL3UjGGPswkt39wTm3zGA23lJdeELUZZa7kKotNGAhfzPj0jKb69cKrvo99Y1KNiwOjaGva9c5Dyp76ILeorcqIC1CmvBJqPib8qXiBW4IYCcZVWXEIzgso1uFsgarbIjAm2ezZBRMfdShAZjZDWWLbzAeHSIM6VVawuE1Zd37tIltuFJNU3/t4jbzOfJoT0BrKMXQQlhlmAvf+vRFer8dAs0O5nE2tl+o496d0ff1ig0/VjChr6t4fttXsddjIEKbV4B6pIl8BE/P39LHaNLdtipU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fc32a6b9-77c4-4ef2-f40a-08ddbe681108
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB5550.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2025 21:40:32.9576
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: X6kzP/ntjk544YNVe0nshGbqrSfz/s0npZ4Va45FeXARbBOCJWQgXQIQino2wTf5WNFWAezwSlISik7pfH1hdg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR10MB8441
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-08_06,2025-07-08_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 malwarescore=0 adultscore=0
 suspectscore=0 phishscore=0 mlxlogscore=999 bulkscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2507080185
X-Proofpoint-GUID: 9ZFeGX5IHzgKBvx7VetBqdwOnis1bG1K
X-Proofpoint-ORIG-GUID: 9ZFeGX5IHzgKBvx7VetBqdwOnis1bG1K
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzA4MDE4NCBTYWx0ZWRfX3UDS+PADptbG KIa+fHteaKT8KCb11D7sqABznNWRNAQBX7zVuZLJBYr+2MHIpzQZltVqSBCHNZ1Zb0kjbKzABqA qNXUlLS5rbGrSE32AlgV8Sh2LvociTTFGCLxxh2NuArLorLFYAS5Ls7K/7lXvwB0ETyLrq6Hq9u
 2ZfCVZ9Mi8cgvPRGY4GBLOWXuLSVfHrgs/VBOOFr7dmvt4nLA8NUVaujZVpB97Q/eS5TmwPAUlf EyxcraEQiJkvwQlsrW3rdXbU+puYU/ANLStE8ovgv7Ud3HS46zJpyqaLbIS4OpaWBbC6Q2bUthp qrKQYF8dn2aMUaH0hAvmAtsnUQ0lf4xlxLmaz4/gI9DDehaVVjMqzOGl8vAmvBqY3Wff0qftACn
 YkW+gD7x5doeLTfN7weSglXsjGb2StH2g5RJRxWXC4LItA7fun8uryojVoIV5VaIrlje0Rrg
X-Authority-Analysis: v=2.4 cv=SuGQ6OO0 c=1 sm=1 tr=0 ts=686d9055 b=1 cx=c_pps a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=nrx7IS_m5JrWTyQ1yGQA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 cc=ntf awl=host:12057


On 7/8/25 7:36 AM, John Garry wrote:
>
> Just a small comment, but regardless of that.
>
> Reviewed-by: John Garry <john.g.garry@oracle.com>
>
>> +
>> +            md_dev=$(readlink /dev/md/blktests_md | sed 's|\.\./||')
>> +            md_dev_sysfs="/sys/devices/virtual/block/${md_dev}"
>> +            md_sysfs_atomic_unit_max_bytes=$(< 
>> "${md_dev_sysfs}"/queue/atomic_write_unit_max_bytes)
>> +            test_desc="TEST 12 RAID $raid_level - Verify 
>> sysfs_atomic_unit_max_bytes <= chunk size "
>> +            if [ "$md_chunk_size" -le 
>> "$md_sysfs_atomic_unit_max_bytes" ]
>
> you should also test that md_sysfs_atomic_unit_max_bytes is evenly 
> divisible into md_chunk_size
>
>
We could do:

diff --git a/tests/md/002 b/tests/md/002
index e586daf..215d672 100755
--- a/tests/md/002
+++ b/tests/md/002
@@ -226,8 +226,10 @@ test() {
                         md_dev=$(readlink /dev/md/blktests_md | sed 
's|\.\./||')
md_dev_sysfs="/sys/devices/virtual/block/${md_dev}"
                         md_sysfs_atomic_unit_max_bytes=$(< 
"${md_dev_sysfs}"/queue/atomic_write_unit_max_bytes)
-                       test_desc="TEST 12 RAID $raid_level - Verify 
sysfs_atomic_unit_max_bytes <= chunk size "
-                       if [ "$md_chunk_size" -le 
"$md_sysfs_atomic_unit_max_bytes" ]
+                       test_desc="TEST 12 RAID $raid_level - Verify 
chunk size "
+                       if [ "$md_chunk_size" -le 
"$md_sysfs_atomic_unit_max_bytes" ] && \
+                               (( $md_sysfs_atomic_unit_max_bytes % 
$md_chunk_size == 0 ))
+
                         then
                                 echo "$test_desc - pass"
                         else
diff --git a/tests/md/002.out b/tests/md/002.out
index 61fb265..6b0a431 100644
--- a/tests/md/002.out
+++ b/tests/md/002.out
@@ -12,7 +12,7 @@ TEST 9 RAID 0 - perform a pwritev2 with size of 
sysfs_atomic_unit_max_bytes + 51
  TEST 10 RAID 0 - perform a pwritev2 with size of 
sysfs_atomic_unit_min_bytes with RWF_ATOMIC flag - pwritev2 should be 
succesful - pass
  pwrite: Invalid argument
  TEST 11 RAID 0 - perform a pwritev2 with a size of 
sysfs_atomic_unit_min_bytes - 512 bytes with RWF_ATOMIC flag - pwritev2 
should fail - pass
-TEST 12 RAID 0 - Verify sysfs_atomic_unit_max_bytes <= chunk size  - pass
+TEST 12 RAID 0 - Verify chunk size  - pass
  TEST 1 RAID 1 - Verify md sysfs atomic attributes matches scsi - pass
  TEST 2 RAID 1 - Verify sysfs atomic attributes - pass
  TEST 3 RAID 1 - Verify md sysfs_atomic_max_bytes is less than or equal 
scsi sysfs_atomic_max_bytes - pass
@@ -39,5 +39,5 @@ TEST 9 RAID 10 - perform a pwritev2 with size of 
sysfs_atomic_unit_max_bytes + 5
  TEST 10 RAID 10 - perform a pwritev2 with size of 
sysfs_atomic_unit_min_bytes with RWF_ATOMIC flag - pwritev2 should be 
succesful - pass
  pwrite: Invalid argument
  TEST 11 RAID 10 - perform a pwritev2 with a size of 
sysfs_atomic_unit_min_bytes - 512 bytes with RWF_ATOMIC flag - pwritev2 
should fail - pass
-TEST 12 RAID 10 - Verify sysfs_atomic_unit_max_bytes <= chunk size  - pass
+TEST 12 RAID 10 - Verify chunk size  - pass
  Test complete


Alan

