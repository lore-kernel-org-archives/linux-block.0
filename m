Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9173B257426
	for <linux-block@vger.kernel.org>; Thu, 17 Apr 2025 18:40:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744915260; cv=fail; b=srJQKVgt8OC93ZfSRlKMYhb3b1e9n1LpAiLrwbQVL4XRzVAbPZCzIiAO1AKhmB2e2L5OaTh0i/WgO6XP6p/JPW+C24gg2FPA09seUHGLBNGnLWcbhvaE4NJg7AUjlZz8iYpHKtcJk1X+8Dgl0cOhJegPMCGFNNm90LzxbGmZT7g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744915260; c=relaxed/simple;
	bh=GYVQ25ucQ8yQIrj3VGeBuJlO8baWf8Gy9q1x+iYU5Eg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=mddVRc5bC5WDnvo1dyI0TjhdBN1DFClyvnm8uj/DBMusaLpHKFBQ6kYBfK2IFEc80jdwOAbV5obNAMFfsc/FFZsSoKJRlrZLLw3THvfPqQ+kkxyH5ZOgOfSYkpct0jPYw1Yf/QrUV69u+tqZHB1UaiPxkU3xah0/F4wjAiXj+qE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=c3japL+j; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=whnW9NhM; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="c3japL+j";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="whnW9NhM"
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53HGMtrq009721;
	Thu, 17 Apr 2025 18:40:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=GYVQ25ucQ8yQIrj3VGeBuJlO8baWf8Gy9q1x+iYU5Eg=; b=
	c3japL+jBIsOBToUq0OaK7t7QrwXyV0e6PflynnTakL59p5CklXIQRsWem9Wd4xS
	7a07cz46AmyC3SAlddIwvJynfS8wztYhrU01WoXxHRA1TBHObY0/z4DxfRSojzv1
	fuK+hQTpIOkdU1iCjNkTxdWz5mo4aQrWagbNhbERXRsmp3mVhP7e2i5NRFAqScYe
	99uS1IBroC8VfNt0vJzqpro9dR8pBNWIDII5ukk1uKaAFV8auGBBs9wHebl99qGk
	R+OCFgfTY1Kjbwpc8V8gV0yPXCuEilCYOKH/qVu7LIlF8lbceqTUgzhfNI68g/gu
	nhysw0QS/0xE1FHggAWtDw==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46187xy3h5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 17 Apr 2025 18:40:52 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 53HI3wt2008496;
	Thu, 17 Apr 2025 18:40:52 GMT
Received: from cy4pr02cu008.outbound.protection.outlook.com (mail-westcentralusazlp17011030.outbound.protection.outlook.com [40.93.6.30])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 460d2tp0sj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 17 Apr 2025 18:40:51 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ah26dyCpaRbLt0DSXmfvxWQEwZnVsB3KWZIGpICDVf0f6bfCSuMKZigomVp4iDPbUZNLIrn65jwJ7O0lGJsbxqFWVidD0QQGwgitixpGAY51klap0VVLZiByP8vU6QtYFLCMamxepQwYGiut3kbhdk1N0GMBHfGg1pBneikK6JBd2lVq28WAcCMktNGUWAC8wf6KB7mHaWbHYxjLYLm8d9bucmb67k+HC50JUinJZSuNPybme/NOl0A+u11xAiOeAOMRN50VcPaQoZBkvNMiHVe0smPcwrcef15cU+zxXysY6xvyLjNz9AV8ZE80X9R7/G9LumWz+JoZuSGwQEZ2zw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GYVQ25ucQ8yQIrj3VGeBuJlO8baWf8Gy9q1x+iYU5Eg=;
 b=yBRjzHyaiLrEH8sgh0uL2QnkC9IgyfoTIrhRjBtLj7fMBI9bq/fFtcdCvHvtjlGHGQnARRNxXgOT7sm8J4m2WYysMZv3HdU08/aaviF7Hab3w2Uk+1LL6hPAC6H9N+ga7DyzntKvl2+FsR2Es6jXnG3sAqTMlCwvCxyow1vfyERMBJ/mgZshohDa0akCvOJwMhzIrwmTxaK25fgrmsjAPD581ryVfLCTS173ny4SZ9ctcGWSnfSdy+MgP6k/WYF26e+70UQHWxF9G1pt3uZ+6rj5tR1VqhZjJHzFM9y8ynAoCBGpwdWKpvIaez27BZQteJ2DLoX+QCPUur3elIemEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GYVQ25ucQ8yQIrj3VGeBuJlO8baWf8Gy9q1x+iYU5Eg=;
 b=whnW9NhMp3E0ZplBsXEhz5ZckEIKyRTt9KXHwG56F8fAmdLXiBUNp8lQdjuwRUTcaBU6bTyhPBne1LZxHdXZyNxYgkLOoQN69ue0voe5jeT7MKwIlWNnoLl0L6S1w8Mflh8PdBa50jxpor8ZNFqXECG0HyO2/WGMuDYX0kYk0lA=
Received: from SA1PR10MB5867.namprd10.prod.outlook.com (2603:10b6:806:233::19)
 by BY5PR10MB4292.namprd10.prod.outlook.com (2603:10b6:a03:20d::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.35; Thu, 17 Apr
 2025 18:40:49 +0000
Received: from SA1PR10MB5867.namprd10.prod.outlook.com
 ([fe80::e454:8efc:f281:44d0]) by SA1PR10MB5867.namprd10.prod.outlook.com
 ([fe80::e454:8efc:f281:44d0%5]) with mapi id 15.20.8632.035; Thu, 17 Apr 2025
 18:40:48 +0000
From: Prasad Singamsetty <prasad.singamsetty@oracle.com>
To: Jens Axboe <axboe@kernel.dk>
CC: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "arnd@arndb.de" <arnd@arndb.de>, "ojeda@kernel.org" <ojeda@kernel.org>,
        "nathan@kernel.org" <nathan@kernel.org>,
        Martin Petersen
	<martin.petersen@oracle.com>
Subject: Re: [PATCH 1/1] block: prevent calls to should_fail_bio() optimized
 by gcc
Thread-Topic: [PATCH 1/1] block: prevent calls to should_fail_bio() optimized
 by gcc
Thread-Index: AQHbr7Yk6q+TTl/mDUWE5i2yevsSqbOoIvoAgAAOBgA=
Date: Thu, 17 Apr 2025 18:40:48 +0000
Message-ID: <56FC21CB-D969-418B-99E3-2DFB7E6CD9EC@oracle.com>
References: <20250417163432.1336124-1-prasad.singamsetty@oracle.com>
 <da093de5-5c7e-4f97-a2b1-9bd8e9f31552@kernel.dk>
In-Reply-To: <da093de5-5c7e-4f97-a2b1-9bd8e9f31552@kernel.dk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: Apple Mail (2.3826.500.181.1.5)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR10MB5867:EE_|BY5PR10MB4292:EE_
x-ms-office365-filtering-correlation-id: 209af8c1-4cfb-4545-22aa-08dd7ddf5f65
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?NEJuQW9YNFVlNHB2a1NWVEFnQkEwR0Z3a2pPTldvUU9CMmd6L0UvTThESldW?=
 =?utf-8?B?eFhpOFZtYkRXREI5eE9OaXd1OVJUbGdlNkcxamdMOWZyY0x0cHpEeTNVSmNO?=
 =?utf-8?B?V2E3Yk5ycUpOTlYvKzhZT1A4bkFZNmtMMjBqSzBCT2x0bHMzYkJ6YUZJWWNx?=
 =?utf-8?B?azVaazJrWjd2YVpLZUVKQWxGSER6ekZEYzFodjZUY0krNEkyQWxrcXV4akRC?=
 =?utf-8?B?WWNPRlRrTnlQMXZlMVYwVFZ6MUNPbU1YQ3VFSEtxWnhxSE9vbUJWdU5BT08w?=
 =?utf-8?B?U0JhNDNTWFplNjVnYy9SaHR5Z24wR2FtQjdwek5sNzh1aTVHNm1ycHhUUDRn?=
 =?utf-8?B?SUtCQW5mRkFJbzlDQlp2bVRiUG51blJ0N2k3ZStDTE9QMkFPTkp0T1ZrWmRp?=
 =?utf-8?B?WHl2d3NsUHNzTG1LOTVrUHlTdUNyZUJLb2l6YjcrMWFlR0J5OGJ2ZjZZbmNT?=
 =?utf-8?B?cmM3eWpCR09rWjdyTXdpMFNqZVc4SXBBdS9BSW9jNmZqYWJnUlh5d2ROSmZM?=
 =?utf-8?B?OXA0YTlFZUZVZ0ZnWU42bGM2RmJKZ0F6RmprRE96c2ExUHlScDRTU08wWTVM?=
 =?utf-8?B?WGJoZlluYW96N21RL0U4S1JYSEJudFR1a2x6cDVlZWtSOHhaanJVSHpBaU1C?=
 =?utf-8?B?dXlJY0FPMnlPOHlZWTVaWXJvakxVR3VNTTNpbXJkZWNJVm9jNTRGYnA4RVBj?=
 =?utf-8?B?N0pYN0NtcmpCV2hoamlVVUlmbGlOUms4VG0zeXlzRGt6SmFwYVJpWUNkek5t?=
 =?utf-8?B?U1BXTEU0YlViZ2l0TmRjMkZGQWtWL0xwRDdVRDVvRWRmSllqMFJzblFkZmV4?=
 =?utf-8?B?S1VVN0paaWpRQ2J4RHBjaXEybnVHN2hPSVNBN1JTS2ZFVGFIY1hPNXlWZTZR?=
 =?utf-8?B?aFNIMG1qQVQ1ejRKN0hsUndCWnlYMlMvdEZtS2puL0NlRTBlRzVVNkl5QU5Y?=
 =?utf-8?B?Z1UvVER6cXNYVEhTK2RybXpETkRxZ1NRb2tHQW9ueElSOUU4cHJTakhZNkIw?=
 =?utf-8?B?UklaSFY4OEt0U0E2cW9TQXdiQy9HY3hGcWFqWmszdHkwQ05TWGYzOFc5MjFr?=
 =?utf-8?B?bytMaFdSSVZXTWdZYkdTUWpEb3MwS0pSS0dPNzlyWkswZE5wVFNsRzV2U0E5?=
 =?utf-8?B?WVVBWXlaSXJYUDVWMGpWdUZLMjdlZkY5Mk9jNFNmKzAwQXZpTk9YWmFyaHpn?=
 =?utf-8?B?T2V0UVRYOGNwUElMRC9MSEZIa05VdVBQZmpkYWRleWt0NjJxUGdzaFhqVmNO?=
 =?utf-8?B?LzhFNXcvdFVNZjNaZUZ3ditwdWI1Wkw4V3lHZ1crenJmRjFCeS9vZ1dadVc4?=
 =?utf-8?B?UnkrOU9sV3M2TUtYZzNFTjBZUlZqQnZGaER3b0tPMzlSME1OUWNnYXhjbnJP?=
 =?utf-8?B?ZEZCU1VjRUIycXBhR3IrQU43SlNqVVVMeWNTd1FQdzJ1Vk0wc3VXV1FXeWQx?=
 =?utf-8?B?bUMwZ085RWdhdkl5RVh5RkNyWHMveXQrSDM1QjhTem1SZlJxVlF4T0FLN25n?=
 =?utf-8?B?L1BQNlJ3c3ZyVFA3M3FuZmRqbXVKeitmcjhhS0VkZktNSU9TOXlQaW00L0Mx?=
 =?utf-8?B?K3JKcDlIYU1pNG1rMWgwSmhudVozSHFVZVR2NVFyUjVud3NVQVQ5Q3crZy94?=
 =?utf-8?B?eEV1dVZtOURvM2xtVzJjaVpIaUFTREJ4T2Zxc3ZDcFBGSkltWnc5M2c1M2or?=
 =?utf-8?B?QjltZWJFcXpTVWRkVEVrOFJXVmN3TEJBQmpwZDlUaTFUUy9GZ2hndzcwbmRB?=
 =?utf-8?B?NmFDMFFXMHBqd1dLQkhObHBIb25KMStKc2FmV2hRSjA4Rnc5VWs1ajExZHM3?=
 =?utf-8?B?T283Z3M4Z3ZGSFg3Zzh4cnVLeTRzVTBZdUluZTgxVEpjdGoyS0hQUHdEbHBp?=
 =?utf-8?B?WVlUZUx6WFprYlVRRFgzM1RSSnRMNVRZOWQ5K0xHYVlRMFdBU1V2WjA5N2RQ?=
 =?utf-8?B?WnlkTHFnWWFsUnRFWVh2NUJYOW9HWUVjcUNsb3FmUU9LV2krcjRvOXk0YW5u?=
 =?utf-8?B?NUxQQnJwZTNBPT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR10MB5867.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?aFRGRU1kNmRuRkFmOTU4dkcyTHk3R0xWaGhBMVkvSVJyWDQxaUR0R2pNQ1lp?=
 =?utf-8?B?NDN3cWJjNUJET0FyM2lFcnVrNEZXajRuKzlnd284UE5mUTNZWXBINm5zb0FY?=
 =?utf-8?B?bURZNFZWblpWZllhMUkrMW15SzkzczRVT1l3OVBja0w5L1R3TytmRis5clVR?=
 =?utf-8?B?MTNlb0RvaFkyQklLb0ttTU5Sd0htd1MvZkpzSk9neTRZSnJ4clJMell5eGJw?=
 =?utf-8?B?eTU3WmpHQTFTc2xzTDVxV0JDSHJOTFh6YzdXclFsZEE1dzluWnY0L2V2M2Mz?=
 =?utf-8?B?TnBvakVIL3dPZnFqSnh3TmhJcGNhVER6SUJ6c1BWbHdsc1FQNHcza0lOWW12?=
 =?utf-8?B?bGpkWThXMUYxMWUwRmdWUks5bFNGN0JtMkdoNFdOMDZuYWN1ZGtkN2c4MWx6?=
 =?utf-8?B?azlSRkJoM1VQT1VqS0hyUFpvaFF4d09FYWRDQUhXdHdMSWtGV2R0MDJTTXlF?=
 =?utf-8?B?V01sQk1kZzd0cWw0U29QWG5IL3pZczJWMWd5L3hzSGRFTE9DR05xZmZxWk9B?=
 =?utf-8?B?V1dYYXBjOEtVay9pUSt4cklzMDV2T1d2WWQrMlo5TDFOQ05mRGI2Q2hZaUx0?=
 =?utf-8?B?cW9EWnhibzRsYTd3aWh4aXNTWU5YdndDbFlkdlV5Ky93eFVVZkxFM0xhQXor?=
 =?utf-8?B?eHBLVThzdURtTVZNS3NiRHdBR0hUeTJlRWtLOWpIQ0YybVN5MkNMVVBNM0RS?=
 =?utf-8?B?b1lCQ3dlak4xaW5oZlJOM0ZIY3puNEZ4RkN3RlBUNEpmZS8yUXI2VXo1OWN0?=
 =?utf-8?B?TFVoa3JpbkQxQlFEWUVmOFlJbXZaSDRMeDIyYlBPZUZGMXJmWk9JUHNSQ2R3?=
 =?utf-8?B?S2s0eGEzUDRsV1hFTllSbzRBR3dKaUhVK1o2L0h6Q2hFZER1QUUvNFVYdS9O?=
 =?utf-8?B?b013b1l2b2c1VzJBV1o3MGVDZTh6K3o2KzBncDV4emFnNjh3Z3NLNnpsYkMz?=
 =?utf-8?B?eFdSR21yRWRReVh5aWhsb3ZCa28zYkRPRS9EVU5lTGh0b3QreWJWTlZHSXI5?=
 =?utf-8?B?TU9XQ1FnTy9VWUhoNVdGa0NZaHJwR3ljOFUyYnQzTHBmRXBTRUVVSjhnbXA0?=
 =?utf-8?B?UFAxd2EvaXJmRW5zYmVhTmpPWjhmU2JURzNaM0JITkNQcWo3eHpvcCs3a0pZ?=
 =?utf-8?B?NXd3NFJrMEI4bE53akFkTmdFZVIwNElBODE3dTh0Q3p1Njh0OUZqKzRrZG9J?=
 =?utf-8?B?Q3RHdVJLZjlFRTV3ekJRV1VoVXFndXRmdlVlOGthLzVaZllOMnpUSDVnbGg5?=
 =?utf-8?B?cXhzUVlzYWVCbGlxbHJkOFFtS2NIeW5mbzU3VkhVZEM2SzhweisydW9mczNE?=
 =?utf-8?B?R3RWRGt1RDZ4Myt2WG4vRE9HeWdyWU5KOFd0Z0ZlZ1VjS3QwZElZTk1lVGt5?=
 =?utf-8?B?QVZyWWhyL09yODZHZmN3bnhKd0VSRGh1U2c2Qnd3WUs2RnRManBvSG1SbENy?=
 =?utf-8?B?d3lHODlnTTkvMWR4NVdCWmgySU1JV0kwRk5pU2hWcWJrZkJSWWkwdjVSNlMx?=
 =?utf-8?B?aCtwRnZXQUZEY3lMVHJHQU1FUENXeUlhSzVPZ1lQTlZrbkhhbDJnemtUaVpJ?=
 =?utf-8?B?T2V5MDh0UmYzcjhDanJIYnpFcGlrU0RYMFRObE0vY3V0VUhHQW40LzIvMWpL?=
 =?utf-8?B?Q1ZHdlg0RUFtM1hHc081Z2pxcTBrQUR1YmhNbi9laWZyTXZsV2gvQWZYNnBo?=
 =?utf-8?B?cHhZSTg1TnRYenVYSDhzTzJQc0FxcUFjL0kyZnlOeXM2MC82cTF6QUdoKzhY?=
 =?utf-8?B?U3MzMXhoeTdLR0ZVVEV3VXZYdzJQSko2dGdrN3Q5OG9hRURUcUpmUi94UW93?=
 =?utf-8?B?dHNER09KSVFlVlBMeFFZaTlEOG52OHJJUUZFK3VZQ1JZT08rT3J3cDE0a0tk?=
 =?utf-8?B?Wlc3V0Y4V1ZGbU1tdGdXUVlmMzI1eHBia01RZ3oxQXF1ckpnTkk4ZS9jOUJh?=
 =?utf-8?B?SE40UzlFNnpobkErL0l2RWlzdFh3VHpDYlRmdHBjcURmR3JPVHQ3NEQ5d0dF?=
 =?utf-8?B?cUN2Zkp5VGJjSzM2YnJNRW5NeVZZczBDR0xERlk0WUIxYlpqckpxY09ZVXBN?=
 =?utf-8?B?akVXcnZiZ0Z3Vzl4NEpkNHJjd1J2ZCtDTEVhT290YmRLeVUvOXNEeWNwcEti?=
 =?utf-8?B?RlllRVpLWmgvVGY4VGQxclJxdmV5aGc5cllVTXJyUTV2aFNWeEN5ZzlQTUVk?=
 =?utf-8?Q?Lo8h/2QivnJ0YzAwuao+1UY=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C0F9493AB0F48B4ABFC4C6165BDEDD96@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	kX349p94IpbP56uTLgDGMc/8Apf4gbBcqW3wh4Ur7XSBCXz1KnDNqLcSTmoAKrzg2kr/nAtZ8UKUNxPqVotBZl/ozVUIlud9EhGRyFTYIMjxAjGlnZSmrVql/casKa/H49w0SogQAjhVpVy6kMvfxpbLnuXhGlwrRcTgGhybRysWRqDdJcDitpFIbCxh9jO9wKQLLIyk50hyij8u2j8+mg1v0RabHdJRb2Co088jj329DfvTMBd60NBE28xibZq3H+asUKTa53FDhy/STeOuYuiTEvPd01Bng76ObH/7ofb05k6gVixVX+uMir3lg6d/zEdi3xYHrL/ZzmXjnVaQn9DfyXnrTx0WFAns5v8bgionwBApoOYIdw3DiSMtyKIDLdkfzywVuuKQWt7CtH0LUhaALrDk+WxI1r4hYRTCCdG5FWt9O8bgg/do5Ym/W+7gxKvA+OX33F/XGX2hAVBwnCkT3ypB21LaH70pi1NDlSQMyB9oyDam2B1sddvfL0tpDynm0gg0Lfl4/aDBHrI+8EEZq35/gwBD0qEuL/+fowG+8VROPO4l9WzpejIMSG+AY+chmIYROyGILibe8k32zHgp7lYtZV9SNODmM4qy1iQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR10MB5867.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 209af8c1-4cfb-4545-22aa-08dd7ddf5f65
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Apr 2025 18:40:48.7770
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4y3Q9Wb968l1GkYdYvrP39ps/Ujq7lCmyZeKlL4ALSGsK6fJTzCdHe6TT6Nae5RkqWvsdNhbzchMKov/pjIY5Stp9na9HH8TjVLIUTalKxI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4292
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-17_06,2025-04-17_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 adultscore=0
 phishscore=0 bulkscore=0 suspectscore=0 mlxscore=0 mlxlogscore=999
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2502280000 definitions=main-2504170137
X-Proofpoint-GUID: iJbSY8Sm8bmfHxjUXzu0kwgbIosCRA2W
X-Proofpoint-ORIG-GUID: iJbSY8Sm8bmfHxjUXzu0kwgbIosCRA2W

DQoNCj4gT24gQXByIDE3LCAyMDI1LCBhdCAxMDo1MOKAr0FNLCBKZW5zIEF4Ym9lIDxheGJvZUBr
ZXJuZWwuZGs+IHdyb3RlOg0KPiANCj4gT24gNC8xNy8yNSAxMDozNCBBTSwgUHJhc2FkIFNpbmdh
bXNldHR5IHdyb3RlOg0KPj4gV2hlbiBDT05GSUdfRkFJTF9NQUtFX1JFUVVFU1QgaXMgbm90IGVu
YWJsZWQsIGdjYyBtYXkgb3B0aW1pemUgb3V0DQo+PiBjYWxscyB0byBzaG91bGRfZmFpbF9iaW8o
KSBiZWNhdXNlIHRoZSBjb250ZW50IG9mIHNob3VsZF9mYWlsX2JpbygpDQo+PiBpcyBlbXB0eSBy
ZXR1cm5pbmcgYWx3YXlzICdmYWxzZScuIFRoZSBnY2MgY29tcGlsZXIgdGhlbiBkZXRlY3RzDQo+
PiB0aGUgZnVuY3Rpb24gY2FsbCB0byBzaG91bGRfZmFpbF9iaW8oKSBiZWluZyBlbXB0eSBhbmQg
b3B0aW1pemVzDQo+PiBvdXQgdGhlIGNhbGwgdG8gaXQuIFRoaXMgcHJldmVudHMgYmxvY2sgSS9P
IGVycm9yIGluamVjdGlvbiBwcm9ncmFtcw0KPj4gYXR0YWNoZWQgdG8gaXQgZnJvbSB3b3JraW5n
LiBUaGUgY29tcGlsZXIgaXMgbm90IGF3YXJlIG9mIHRoZSBzaWRlDQo+PiBlZmZlY3Qgb2YgY2Fs
bGluZyB0aGlzIHByb2JlIGZ1bmN0aW9uLg0KPiANCj4gVGhhdCdzIHdvcmtpbmcgYXMgZGVzaWdu
ZWQgYW5kIGlzIHdoYXQgd2Ugd291bGQgd2FudC4gUmF0aGVyIHRoYW4gcGF0Y2gNCj4gYXJvdW5k
IHRoYXQsIHdoeSBub3QganVzdCBlbmFibGUgQ09ORklHX0ZBSUxfTUFLRV9SRVFVRVNUIGZvciB3
aGF0ZXZlcg0KPiB5b3UncmUgdHJ5aW5nIHRvIGRvPw0KDQpXZSBkbyBub3QgaGF2ZSBDT05GSUdf
RkFJTF9NQUtFX1JFUVVFU1QgZW5hYmxlZCBvbiB0aGUgcHJvZHVjdGlvbiAoVUVLKQ0KS2VybmVs
cy4gV2UgaGF2ZSBhIGJwZiBwcm9ncmFtIHRoYXQgd2FzIHdvcmtpbmcgYmVmb3JlIHdlIHN3aXRj
aGVkIHRvIGdjYw0KdmVyc2lvbiAxNCBjb21waWxlci4gV2UgdHJpZWQgd2l0aCBhc20o4oCc4oCd
KSBvcHRpb24gdG8gZXN0YWJsaXNoIHNpZGUgZWZmZWN0DQphbmQgdGhhdCBhbHNvIHdvcmtzLiBX
ZSBjYW4gdXNlIHRoYXQgb3B0aW9uIGFzIE1pZ3VlbCBzdWdnZXN0ZWQuDQoNClRoYW5rcywNCuKA
lFByYXNhZA0KDQo=
