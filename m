Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9BFB43179
	for <linux-block@vger.kernel.org>; Tue, 19 Nov 2024 16:59:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732035590; cv=fail; b=OnYOg+2ZF+nZoAwpwmUsO1wCw4Dakmb1NFyhCWI5fD79IPsbLXwFvkydu11iCrX3yG/suUGGYP7B95vnUklYCPewaXXx2+WWLXFtWxiRqWULO18gvg53/UozuM1I8w4U+mN0/XvFlFDxiMIupoHo41ZT6YVMU92o4Rb5wqkQAdI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732035590; c=relaxed/simple;
	bh=/uEXPCBLb2RL0D5F9kNl/NGQwTXvcLD71eD5rg39NHk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=opcH4Cn/W2ZWBGbMKaKRb3y1pb8trjcCxhJKch5yyw++CF6OhypnSXG7Wgy4i+LuWBIs5b/Yb6wqiFNJS0O0tkNf/gAQyXkLFTdPTo09QawRYontQpt9qtZId+OpIESknaYNMNFgxZ6AETwxMVI7tXos/J1sqLP9XgpOFmJhw0o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=E90FDJrf; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=G9HSew58; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="E90FDJrf";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="G9HSew58"
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AJGtZ5T030724;
	Tue, 19 Nov 2024 16:59:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=nZscs1P8ZOTRQSfPJx/DO1DfXZJhi38uuRZecinxMgE=; b=
	E90FDJrfRuTW3GFw+eUtTZVkEOPrxRH7S4dwLl4qZMuzadXxT2YFjZfPoTTUgNBw
	eXPHY5aSAq8JSgcfqSaRX2oVcrWsjOxEmwKrvWJOv6fnhGLF5TZpPo508M1hZ4Ow
	/dDqSl1gX8iyWBHtOchRt98/We7HkeFo7v8MbOLxLr8F/Yn78qK1A0osJQo7TmIX
	OGamAl7iwbxF6lKSVMCtztWZfl4uAnJzJ4pplgvTeKbO0CAW3S1WchUMJkKif7XO
	ciAqJ/jTeyJMOy8YheqqdnEr12o5cJNfyidXTQ9AWgv/rnQIFZy3B/H5OihzG5Kz
	JhrYJlg3jiu8nsgdBjZT9A==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42xjaa5fu5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 19 Nov 2024 16:59:42 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4AJGf6MA023223;
	Tue, 19 Nov 2024 16:59:41 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2168.outbound.protection.outlook.com [104.47.56.168])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 42xhu979fj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 19 Nov 2024 16:59:41 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tbqwn0JEbLd7aM0zolpmNVRUnw9gWA9/2/VqsH1wTVqZ6vlLbWdZzDQTsiwafR8nR3575Vdf84MifMizosYHohoATQZe1vArgBdlnjHWX2lnVS6hIQdvOtVfNOpW6KdmfqAdWO1mLk6R8cJYCnM3MmeObkPI9tyixTU/90P9yD+nG/HMHML2AKiR7d4VbnZ+D38YNy+dKJWl+8mRsLnSvnBbPEVO5+xj6iCZZf+TFNGvdE28pts62kry+w4oXqqi/NCZ1KEr4VlotpMQyt/lgCcvA9oqhPAWjrHRMx03wfonI6+4NRBeEQR7pG2FkaFh5tXws6d/8GlOziyhEkQiQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nZscs1P8ZOTRQSfPJx/DO1DfXZJhi38uuRZecinxMgE=;
 b=Hk9y05jN2qvwXLdhe5oGCoT+s+vU3HrX3cPHxCrVkZ5wrFzUuSxeEerJlTdvgrgwwLsk0OtMeKbFVCA3gT1lyC4F0gewphR9pTM+YfNnhQ/p68eFucWXPx3q/RecBPIo+9mMJ/EGL83yQ0LS2+OTv0frq1/2tEe4XmQWomjwZhAdnQjPo6Xw5dGA92xV1V0SXnIMf+RgpEcFMQfMyE4KZzjzr5JWsZ6RRlO+WRBO0wduPuZ//R0Z1Fly/oQF1Un4PTXehhwZdbaicM4Rp2Gf2oa9X7SkXWux6nUVTGWDQSZumOoPMg0r5+oY0UBjyBiabFrcfU/prY/EGs0GwZLLdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nZscs1P8ZOTRQSfPJx/DO1DfXZJhi38uuRZecinxMgE=;
 b=G9HSew58mWip3tUl9YW7ioLGAYfLdH0OPUZBULVD82kVbRK0XSPxQ0179FNBf79RobYzGO8Qyjbzp/BAptw2XWzHl/juU5kyAPOcD/I9n/pzJRQzovVteR+fzcBgJbLx7JhHNw979YWKgtDSoxzaqw/5hHL3Bho6LTN5kx7oNKM=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by SA1PR10MB7588.namprd10.prod.outlook.com (2603:10b6:806:376::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.23; Tue, 19 Nov
 2024 16:59:37 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%5]) with mapi id 15.20.8182.014; Tue, 19 Nov 2024
 16:59:37 +0000
Message-ID: <31a5ad6f-033f-4d64-b235-fd1d1a12c1d3@oracle.com>
Date: Tue, 19 Nov 2024 16:59:31 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] block: req->bio is always set in the merge code
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, Dan Carpenter <dan.carpenter@linaro.org>
References: <20241119161157.1328171-1-hch@lst.de>
 <20241119161157.1328171-3-hch@lst.de>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20241119161157.1328171-3-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI1PR02CA0044.apcprd02.prod.outlook.com
 (2603:1096:4:1f6::6) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|SA1PR10MB7588:EE_
X-MS-Office365-Filtering-Correlation-Id: 45ed7635-7a82-4374-3b7f-08dd08bb8cea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RDVBdDFpbDZ4V1U1SkFzQnJkZmo2TFhCNTZ0ZG9rNmtiL01KUTNaUGUzSVk4?=
 =?utf-8?B?ODZ5STR4eXA4cHJSc1dGZE5WcnJWenF1NnlDUnBIUEdoTFV5WEFaRDZKVVNt?=
 =?utf-8?B?TXYzQjJSczZ5eUtzR1ZPMVhFZ0NMSTF5dHAzMm5jRXVzaW1LcmtaS2Z2elAy?=
 =?utf-8?B?ZXQwc3ViM2NMbHQzWEV1OStZN291QkhtSmVnbnRad2FIODdsdDN1U21WUlZu?=
 =?utf-8?B?bG9PUWR3VzZuZVhBa2k1RXBoU0x0cFNzWkN5aTlIckl1RmxtMVdFdVdYaENi?=
 =?utf-8?B?b2lqU25oak4zK3JFbHZwMUVsM25aRnY3bklkSERLTmhQdkFUVXhIVkpidCs5?=
 =?utf-8?B?UUxweEJGQWlQS2Z5dGlLbmlnbTdHcXRKMUdOMjdSRzkrZ3JZTFp4by9TZ2xY?=
 =?utf-8?B?MzZkUWtLZXMzd2h1TlRCR0x6SnlWN0tLUHdIT2VhdmNQczBRWkcvQzNuMGUw?=
 =?utf-8?B?NVppOVd4SlM4NU5QbDF0aStBSnNHWWIvK01SbWFyV3huWWw1NURzc091MXlv?=
 =?utf-8?B?TmcrcGZ5VEZuYW5ybmtpT0dqb21oM2hOd2Z1dWlGNm9kcmR2VWZRU0E1cGNn?=
 =?utf-8?B?VzZ1c29uN3BNdzlWTmNRNXp1Wmd4WDBTTDBUd0JyMHhveERjMGxZL3FXbDdG?=
 =?utf-8?B?djRoR2d5Y0RNVjA0L1djdVJyVldtRVVRZG9YSXlERjltSjV5ZDBQb0VEa0Fw?=
 =?utf-8?B?eHhuVy9Ta2I0bU9GaEI1aEpHNHA3ZzhPQTJhbkdwZklyZ1A3MUM0Wjk4akxT?=
 =?utf-8?B?c2RCR2NFVEtjQXFBWE5haGtxQzU5U0FFOUFVK1B0UDZFa2N1UFREV3E1MkEw?=
 =?utf-8?B?eCtDOEdCK2VXZzVyTTJWMlA0Q1RXcVpPdldkZ2F1YUU1RlFraVlJWHdiT2ZT?=
 =?utf-8?B?RXdYV3VmNXp2M1RzaEJqc1RmOUxaSHJleUdEN3VITWNJOVRXV0ZxYjZjM2V5?=
 =?utf-8?B?dUl5cDR4ZWRoN05xU3B4U1QyODgxVGFvY3pxdTdXZG5Tem9RSm4wb0pPMFlh?=
 =?utf-8?B?V0xJSXhlSHBUZnNFajNDQUlUTGhoZjRtK0QwSjBYS0FWa0J3dFFHU3paZElO?=
 =?utf-8?B?S2xWamMwVDMwVHR4b0JPL0lMUUd4N1ExOCtEdUwzK1ZGVWkzaXJaZUtBQVdC?=
 =?utf-8?B?ZFRKdElHYkUwazJ2bUdZRlppRUMyUUV2ZnRqbGZyL1BvMmZWRzN1OFRzY1hT?=
 =?utf-8?B?aExZTHdPSnJ1SVAwUHJXVkJNbkVuMFMxUnBjVFFYN3BwRk9ueEV4ODNuTTB2?=
 =?utf-8?B?K3RZZ1gxODBKNW13ZHV6UllZclRMTFJvSTRzMzZzSUFpKzQ5YitMWUVsU2dv?=
 =?utf-8?B?ZUUrQ05KQ1c4cVJHVmtsdzlxYWZVb2M1a08vOWxQcUplMWx3WmRaamhXdkZp?=
 =?utf-8?B?K1owSDhaVDBiVTc2bkpPR0tOOVc0cmlCT2pJZHAxeFJuWVEvN3hVQjNKZVNk?=
 =?utf-8?B?ZFhmeXJ5dVd6SjZHZTBJR3VVSnVIY2pSN05VZmF3U3Q4eWwyWHgvSjVBZFhK?=
 =?utf-8?B?MHVyL2w5MmIrTFJ1MlpKOUZGWER6SFB3Y1ZCS3QxMXNCVTJFM0p2YkhLdFFV?=
 =?utf-8?B?ZVNnWWdlS0ZlQUFjWStoVW9BYUl5cG5XWDNMVFErVmJDMU5CbzB6aUNyb0NR?=
 =?utf-8?B?WEVHNFdUL3c4aUwySUFRTkY0K1pURjE5bU90cklYZDhOSkdOVmxsMW5qWVhu?=
 =?utf-8?B?L2M4amJlcE9FdVdsRlUwV0V0akluTlVVcURHVERaMVpqVlkxeHd5RzVra1By?=
 =?utf-8?Q?BmVB1PwRemmff4+C6/6hLS0smye7HDA+l7uRp3G?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?empHaGd5eWtMYlNKUVMxYy9VbDAxeFlMVTh6aktwRUliaXo5MnVmUDM3SmFz?=
 =?utf-8?B?YkxVZi9TY3BDTVhtdURKWXVHLzB0YVBudWpRYjFlaGxzMVY3RFJYQnBueGQv?=
 =?utf-8?B?L3N1VkQ0eVE0cWhVdVBmMGk4MkdoN2dSRElBZjd1RFoyNUExc0hCL0V2cmdz?=
 =?utf-8?B?czVwdjl6NXY5c29KNk9GQXBERmpVOStpamFRbUNmY3E5STlDRG5PVkVYSmdj?=
 =?utf-8?B?UGt1eEpXTUZ0WkpiQmxwQzdpY05jVTUwK05Eb0JUdE1mR084WTgzcldMRUxV?=
 =?utf-8?B?UDB2SHdPM2h3REI0WGlZOEYzVktPTDZnTm52a1Z1MmV4bFZjNVB3a2ZvbW9J?=
 =?utf-8?B?bzJEMG5NUHVSYllpRklzWmp0Z29WWVdoRmhMNE1lRnVVMWpoY0YrRmlud0Q3?=
 =?utf-8?B?WUQvOUpyMTdmREdOLzdkSURtTmVJZlN1aWs3Ly9acFZucDFhUzM4ckxhOUlt?=
 =?utf-8?B?S2dUR2RidEM3OW91c1ZJSExOK2NlNHU4R0JFNng2c2JKaUVLUVVYd1lJZzdw?=
 =?utf-8?B?NmZLcUFCVzFac1B6RktHbFRjMHZUZklHTFp3Vm0wdFAveFp4S1FJTURuRnpW?=
 =?utf-8?B?cW5xbG04c1lWODRLMU9DVUtHbGpSdmsxSC9jVG5DeGUrcnpuK21VUDJxRUQy?=
 =?utf-8?B?TFlYTGhYTk9jQjBIY0ZzdE1mQythQ2NpQW9rdm5Ed0lGVUU5cWM4UWpEaUhN?=
 =?utf-8?B?V0krU1M5VEp0YkFJSlplYk9SRFR4SDRtQTlaK2JIcE9jM3N4enUyUFJCZzhL?=
 =?utf-8?B?RTdDcHQ0Q0ZsTXVYU0kvdkFVWGNtZ0JRVGlzRDcrc2Y4ZWJHRnhVMjQ1QWZE?=
 =?utf-8?B?RFA1bjFkamljcXVsdlhnUWxqUG9pQy9wSFFMS3JkSFZxTWhzOCtqQ24yMGt4?=
 =?utf-8?B?S3czNHRycWN0eFJQa1BBT3JyeURHR1JPaXdqQjlxeWd2NGN4S0s2Q2VwelhO?=
 =?utf-8?B?eGlGZGhsTWZiemh2N0pmYXlRWjNWbFR4dHhIR0Z3VU9XTjlMdXJpQUhnTEhq?=
 =?utf-8?B?RDNtZXMzS0U2dEVKTm9IM3lPZStLazBzQjE0aFBURG52NE53S3NZbk55ZEZq?=
 =?utf-8?B?S09HNzltNkJxT2c0dXF2SFpTcE96TWc3eGhMazZsQmVOQTE3N2NUQjBudHZY?=
 =?utf-8?B?UUNqaFNRT0tuVFp5WFJWd01nUncrdHBKSytrdDU5MEFLSEs0cWZ6Qk0rSzhj?=
 =?utf-8?B?NVdEUHBveEJEdTRoQWduY2ZwZWdkUDd3QmlrSWdpT3B1UlgwMzNGdVFTTW5j?=
 =?utf-8?B?TnBUOUxud0RReEpOQ25HblZ1TVJZTUYwemtEdURpQmZiaFB4VzlzQ3YwMFh4?=
 =?utf-8?B?OW5GZmxJNXRybEdQOExBandMVmo4OFJRZlEzeXNOSDRhTFJUU1E4T0U1QzAv?=
 =?utf-8?B?cThqWUUwZmZOdmxKV3ZhRUFvbnVSNHJjT0lHbTdiNVJnaE1pQnRwWUhPcmRQ?=
 =?utf-8?B?OEM5ZUEvUjFqWmxIU1gzYXViQkRoVE1vaitRS3NSVFJPVkgyWjJGY3FTV0NB?=
 =?utf-8?B?c0E3eExEY1dYNWMzQUZNbDNZNUZXc1BGTEZiQy9na0RyRE9wVUt3QytpZWZU?=
 =?utf-8?B?M3Fpd0VEYnRPME55S21BR2F5NS9zUnJDM3NvTkQ0dTJ0STNSS2YvdlA5WU5v?=
 =?utf-8?B?NmE1cW9GRzc0SVh5Wk4wODBBcHM2MVMxUmRKVHhGcUowL011c3VDV2pvR2tL?=
 =?utf-8?B?NWxCNjZMcHUzbDhUTGhaLzRqMUNBUTBDblhUZTNyZUhRNnBFMzhIdTlYbENy?=
 =?utf-8?B?UVFMT3hLWXRkWDN4RXlPc1EzbFFlUjFFY3hjTng4RjlaV3lJSVJ5aE9kK2lR?=
 =?utf-8?B?TDRkMzZEREIzaUhoWEJXL2ZOMzRaYjFUeUZ6WlQzRzg5OGhxSUsxS0pENjdi?=
 =?utf-8?B?T2UxT25Da2kxYmpMNHg5NUdqS1FYL1pXN3R1ek1YbTFWSVN0OUVNRzFGNC9v?=
 =?utf-8?B?b0RxcjFOOGZWUmIyL3gyQ1FKMTYxeGRJVUU0WjRmVVVkTlA2SVlPd2FtSDBk?=
 =?utf-8?B?ZGlKcENBS3JYaGRYTlVuVEEycERsTnZublVYbDBsSUJNWDZOcUorTFVRMDMw?=
 =?utf-8?B?bmpJa2dvdmkwMEJrdGZmT3VuK0xJUlRFUzM4OWkybDJSdlpCcDFvKzZCd1ht?=
 =?utf-8?B?K3VvT1pkRU43bThxQ3FIek5ZdDhZeG96UEJxalQ0Y3lNZi9xeU5PWWVQdi9W?=
 =?utf-8?B?WlE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	ovI+VRsEgfPaE7tKz0BJ0g67SJvh6kImxjTs2MQwGD7ICJLc6QylvtDIc4btk2FOSYMCEy7mqHjTiwasU3WbM461UXea8V6xWtblETaB3JJHTzdc5H+f7YtxLArotgaxVfnl3fPaB0Yh2yJl6lhjvw4WzZjH2cWOqxfb8M7VKzYsNbJtwnpjoRh9QMAO+ZZJeaSGzDZqyrAMcH9k4kD1LFTK/5TokziMdNJ5vrppjVp8EDdsfI3lb9ntSQM9qcDyl2J5KUsxGPJ3npgnl0JZAkgi4LNpcUDL55nzU5W+re35hVqb9hIxW+qxhMbhJOdbNcuOcEZoQaGxW9dGJY2SF/eJGGASfY60+4ftG4nJNFlZ6y9saqkUW65U8App4NKRptOdzEP/ZfgYGnoOltnV4hwOdFiIxmTAl7R4UbwXJmgqAQamPO+emp4+irQPNTDJspX7vwBv8v2frQwjbWt+WlnuTqD5S0dVbmcZES7KsSGe/nKokJ1TH4FC3HOy+Vo4/MqvYSGyfPLCRtuWPOrp5I7S9c4JmrFetioZ8jAGzJQbnULaLZzK6NktqTkWl+in9LNGWxPFfiLT+V+SDrzMUApdX5yLm3L8gcCOpYZMNVI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 45ed7635-7a82-4374-3b7f-08dd08bb8cea
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2024 16:59:37.6188
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EECcnTtMalvFGmGrvO/DXFiOiS+cFJ/SMuCvO9HmxCtITM2hbiTLSPtIJQKiiLjYILnTIxrd7p3YMNBm2+b0sg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB7588
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-19_08,2024-11-18_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0 suspectscore=0
 phishscore=0 spamscore=0 mlxscore=0 malwarescore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2411190126
X-Proofpoint-ORIG-GUID: AJ3a21fjevxZf3trwKe4gX2jgr6t816c
X-Proofpoint-GUID: AJ3a21fjevxZf3trwKe4gX2jgr6t816c

On 19/11/2024 16:11, Christoph Hellwig wrote:
> As smatch, which is a lot smarter than me noticed.  So remove the checks
> for it, and condense these checks a bit including the comments stating
> the obvious.
> 
> Reported-by: Dan Carpenter<dan.carpenter@linaro.org>
> Signed-off-by: Christoph Hellwig<hch@lst.de>
> ---

Reviewed-by: John Garry <john.g.garry@oracle.com>
