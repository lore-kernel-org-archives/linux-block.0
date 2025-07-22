Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 897B82E9EB7
	for <linux-block@vger.kernel.org>; Tue, 22 Jul 2025 12:45:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753188320; cv=fail; b=EuvxO4XNb/C4HFutBjZDTR2M+VbHVUIqlL+Caqah2FY5+7qQlRG+z9Jo2act+tdzYvLSP7n6zPkpM8oyz0prp8RcpRTK+Py2ohw+bF2qji1curbDlnrn8TwMZhAHr9VSE7KULV4UtPwizAJviQ2HYc3ycnHvpG1J6voui72a47w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753188320; c=relaxed/simple;
	bh=wRH0+w6Xg1df92V3AsGFkIF5FQxfGZXouq+xQtNZSZU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=GSt9m2k4QadvZGBPfUYq/vwOyKVDNmOb1aKuzKxfEIk+eZflH2OsU79U0LMKo5tYMoZZo07ieuMsaTOCfk8QqnidjF9htH/pv0YlGyGSvsPPdUvgG8372HOGwts5r5xOsnIU9gEsB4KB4V4fJusymtNyFrILgXjekMof+KMyJK8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=UVcKFthO; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=j0Q442rI; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="UVcKFthO";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="j0Q442rI"
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56M5TCVG009173;
	Tue, 22 Jul 2025 12:45:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=BV6+3W4oS5w9MnCRK3oecEjwRs3Yn+tf0ppHmP72DNw=; b=
	UVcKFthOWQABWXXg+4BDwISSP8zcw5c0q4oDnl8gCoP6kaPdOPqMMpJcSHvPzKAV
	MZa3avPx2Gk9VKJkWYCVrZ3dODDEv6xEhQy5s8nzH+ShEwWPokCgfBTM2Nk3W3m2
	X9traFneaNTFw20Ri3RYgSaLQaJQX/dKjsf3SfdYtwR7ycJcPR4ME2R46GYhZniN
	XIHpqh8If9MiKEQ8/hIUSFQ/V6HvVyA0YVhrNGBED/FhFJqTy6mwUBvBShkyZXFN
	4axI/piDdaTFdRGZOcZ7SQUdZU+K5bXQEef2Pa/6BBFEP9vmmtb9FS+Q1Xe/ysHz
	VorUwa/rzq9hLZ4AzRqdvA==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4805tx58d6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 22 Jul 2025 12:45:11 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 56MArekq031526;
	Tue, 22 Jul 2025 12:45:00 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10on2080.outbound.protection.outlook.com [40.107.93.80])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4801tfjqdk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 22 Jul 2025 12:45:00 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RI3KwSbWbwsIEWMYrw/ah//jueFidTkY14NtSby/FCBB1QRyggdFGvLES2Hx1pGzGs0gCK1dcnnXyAXx8j42hnQKXFu+mFzvtDnnFG0/O3LcF4bj+LzJe+CLbcOoUMB2iVnoXZRduSEmjiA3x5+i22MmkAZmkjTQHI8gbIJFRLlN+406ZqWaAKOf1BO74YL+tQFASjqR5IxLcFtMiyqWBYEpqEgE6BDiDendizpS31HcgpIkpY6DBz5mXTj3sLTW/ual7RVJbWE5tJDhlek/ZVYMReVVI5qVGjj5y3cWZUDsG1/XN0FSM4X/JXfk4HnaWBsc3DOwHAFnSDz7s81fxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BV6+3W4oS5w9MnCRK3oecEjwRs3Yn+tf0ppHmP72DNw=;
 b=xZsOKMDBGJaGJ535WDOBSHDsshssjpOtoxqCfnk9BF7GA/7L8L1Vq/8l7ufPth3Y6mSqYZ8BUwQBeBfyHtYskTbA0d2ryhVoNT2oOrJyX6FploLZ3Dp8CHqrbYLrEW5012p97FDZFTiw2ZR/JBTa5UkcpWM4epkV4GHW+q1HoFeXvdHCZ5KLerD8kocnk0r1R7gMSTIiW9j7mWy684nrZ3dMzl4LW34u0pzu9GF0MjZwvgLdJT8DstxbWdGhWmdeAR/UnJtBAbiigCE/+Oc62fID9G9oGUSE5AfUc/iGCNp66VpDmZPnZIeqRaycDczIfelJq4Jd+Lr1Ctiqlr6UUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BV6+3W4oS5w9MnCRK3oecEjwRs3Yn+tf0ppHmP72DNw=;
 b=j0Q442rIL59A8Q40kJ1DVnDJcxRq3e20Wn1BLr0RX3mz9Vt4t+O8C+hJvQrf1r7lOE7kdqAiPA2hrtXiBmtSPJdUcJcz3PhN/A22EyRHGnlQTgZpDG0eq2Ql7uVCUHrGJHUS7CmkHERpkAGRdvArGaVtfqCVpu9rN03316lvy7E=
Received: from MN2PR10MB4320.namprd10.prod.outlook.com (2603:10b6:208:1d5::16)
 by DS0PR10MB7270.namprd10.prod.outlook.com (2603:10b6:8:f4::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.30; Tue, 22 Jul
 2025 12:44:58 +0000
Received: from MN2PR10MB4320.namprd10.prod.outlook.com
 ([fe80::42ec:1d58:8ba8:800c]) by MN2PR10MB4320.namprd10.prod.outlook.com
 ([fe80::42ec:1d58:8ba8:800c%7]) with mapi id 15.20.8943.029; Tue, 22 Jul 2025
 12:44:58 +0000
Message-ID: <5c7f71a8-98fe-467e-a238-3ebb10023c87@oracle.com>
Date: Tue, 22 Jul 2025 13:44:51 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 2/2] block: Enforce power-of-2 physical block size
To: Hannes Reinecke <hare@suse.de>, axboe@kernel.dk
Cc: linux-block@vger.kernel.org, martin.petersen@oracle.com, hch@lst.de
References: <20250722102620.3208878-1-john.g.garry@oracle.com>
 <20250722102620.3208878-3-john.g.garry@oracle.com>
 <d0adde51-8fb8-4fea-ada0-176a9d745db4@suse.de>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <d0adde51-8fb8-4fea-ada0-176a9d745db4@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN2PR01CA0219.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:ea::13) To MN2PR10MB4320.namprd10.prod.outlook.com
 (2603:10b6:208:1d5::16)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR10MB4320:EE_|DS0PR10MB7270:EE_
X-MS-Office365-Filtering-Correlation-Id: eb83a885-36e5-423f-ff4f-08ddc91d9128
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dVF6ZWI3b2grbVc5V3FGcmc5RUJENk1scnFFTTFWdTFXaFJCTlBQQjNvT1Mw?=
 =?utf-8?B?S3ZQOHZ4eXEwSjYvRVVtOEtVOW1KRWJLQ050NUtwZHJGSThqemZSN09XY3VR?=
 =?utf-8?B?SFhSTUFUODNqTmV5aGF0Qk9CbEFvSyt4OGlJVUd5TngxQVpuYXc5WndJZE1G?=
 =?utf-8?B?dzVwZStUaWs1T2c0OE1kaXpDSENYTHJyL1VISGZOYkNzSkQ0Nis1L3J3M0JK?=
 =?utf-8?B?NThoVzZJVEtWT09tUU9nU1BQMHY3eHpJRFE3TlFnaE1VSlJvQzV6Q1owSnlt?=
 =?utf-8?B?b0wyVWNqSmFMQ1lDUEY1TnE1N1orWUU3QzZDclpSZW1Jd1ZTYXI1SkgvTFlx?=
 =?utf-8?B?UThLSXFYVnhKTXY3b0NwbTFvVFNaZWpUZGVMMVhUaWtwcU5GSXdEdWdmSWxk?=
 =?utf-8?B?R1NBQlo1eHp1TTEyZzNlcFRqM1diZ3g2TU5LS2xsUXhrbXlDRU9KRUg4TGQ1?=
 =?utf-8?B?K3JBTDhsUU4wS1U1NENwYno5VDJzUHF4WTIxNXVucTN1SzRWajVLTUphQ3Bq?=
 =?utf-8?B?SlQ5TkhPdVJYejMxSktPUGh2azNqYWJYVWZZb1R0Q3gwSzFydE1WM2xvQm1O?=
 =?utf-8?B?Qlp1dkNHejRXcHh2Vm9YSStMY0h2QmNSSzdZenVoalJtS05QTUkvTHp5c2xD?=
 =?utf-8?B?ZHBKaW1UZStmbWNLclhydU5EeHRrcFRvOGpINjFnMlBGeUxaMElKMmtEYlhO?=
 =?utf-8?B?VHdZQ0oveTdYdnc3NUdPQmlHSllkWldhbFRqQ3hpa0xhSkd2TXpiQUN1eGwy?=
 =?utf-8?B?VDZJaVVCY254RU9NR08yMWdNS2Y2cExjcllaMkxSWndkL3pVN2FzUnB3VEgw?=
 =?utf-8?B?SHdma29FL08ySHVtcks4elNmREEyajVHbmdBNm5BclorT2tTdWl4dGlWZ1Zv?=
 =?utf-8?B?VVE1SnZhY0FjNHU2elQyM2tkOFpXQUx5WGM0N1BCcmdQaUxJam9ENGVwOGlu?=
 =?utf-8?B?c0YrZFYzSXJrMElJVVN3UGpwVS9oT1hmREV5R24zck9FNVZuOEVMeGdFNG80?=
 =?utf-8?B?TTI2UkhoNHpDK0dSeDFhUU1lZnJtY1YyTitENzh3WCtxdlhWTXB0L3RJK3lh?=
 =?utf-8?B?cGZpd1VRcTdwZWJmNExxdk52c1dKbEdzeXVNcTRKUkNFNEZsbFNQbmRDRDYy?=
 =?utf-8?B?YUZyb1ZVakhVQ1Z1c0VqZmdaSktHMy9pR2QxdlhNV0tUeU45ajVoUmhBbnkw?=
 =?utf-8?B?a0I4THVHZHBJd3FCR3l0dTFSMXFyMUk4NmVhTDRiMkdKV2RlZ1pVbjRYSmhv?=
 =?utf-8?B?cDhNSnBtU21qN2N2N2NleXFxcDduT1pwR0Ywd0tvS3gwQmQ1VUw4THdKcnlG?=
 =?utf-8?B?Z1BKK1hsazNrZEhrcGZLWkhlbGVJZ2JMSHM3a2lIb1JGNXRsZWNLRTZZMFFF?=
 =?utf-8?B?SUdlUU56UmFNM2pOMTh0ckRGUjBMN1JINmliSGZBVG1hZ2ZXRTJTZkE0aGdW?=
 =?utf-8?B?V0xEL2RzcXRTZ3p6cWJERWgrNG81TTV4ZFlLMll2aWdKa3NNMGpYMUMvYlln?=
 =?utf-8?B?WEFKckNPanZldDkxamhGYklsT2F5L2Rqak9Sd0RIVVl3RkhMMzBPZ05seUV3?=
 =?utf-8?B?WEtGRVhKY0J4ekJwTW9rZ04vdHdDc2NZSHAybzhQdEYyWFdjeVVEL1RLaXE0?=
 =?utf-8?B?b2tENDVjNGVpK25MbUczaHFxS0p6V0Y0S20vWlUyY2U4cEJxQWtZN1dneVRx?=
 =?utf-8?B?TlNSbGJuYnZSajVmTmgrNWp0OCs1YlNOZzVoWlFkQXQzR0J5ZkJYdlhObWJt?=
 =?utf-8?B?d0VpTDl2L1Yzc0xlTy92ZkNReExGcXJLTFJKdGFMUUpqeGxjWEp0d21qd3Br?=
 =?utf-8?B?cmdVRkNoOG04QldiOE11T2dhMi9WbDVJQ295c3loUDlmOXpURVQ3bXcyYlM5?=
 =?utf-8?B?TUJpWjZxRCs1Sk5iVlRpNDl6YmExOWlmQ040OVViOGVkVmc9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4320.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WmVtK3pwdlNybkwwbWF3RHJsaWtBWGc3dnVDaWd0SFNaK3c5NDBGOCt2NFNO?=
 =?utf-8?B?NFVsaXJ2TXBkMGtWYjVxNDVTa01JSG00T1h0THlaTE5YVzY5MnFLOXY5VEdy?=
 =?utf-8?B?OUpVckVVYW53YUMvV2d6RUg2TjJmVDcrbmk0WWFuUURiUnYxNDFRVEs0d3dN?=
 =?utf-8?B?SVg2WlZKV2YvNHdSaWVEUTJuem56UzBhWXJ5eFR0Z1gxeG1teVJ3d2tZTkJh?=
 =?utf-8?B?MDdvZzJJY0tIRlVJU0QwRFhodTBlcUkxQ3ZQZGNhMW9jVVZ0MkVuWWsxcmRi?=
 =?utf-8?B?VW53QitFU3ltaEN2elF4OENZTlRpcFBTOUdwZlBSdjFkd0NYN0Y1Q3FVTmJJ?=
 =?utf-8?B?cFQxV3hmU3pLZ1JFV0I3c2dzT1NOdHRvRm9SZktEMXJnYlBWOFErVHdETzha?=
 =?utf-8?B?MjhWZ1JQWk5lbVFwVUwzbXE2dVh2VjVKaTdwU0hNQjdLOWNpUGZueC9EK1hj?=
 =?utf-8?B?ODdHclRzTXZPNVpHSTZkQ1BHN09Xd1grRzZPOVIvTFNOampidC9lTkZhNUlj?=
 =?utf-8?B?MXB0bVdsbXVUeDFKZms5THlqQk5UUFdmODN3NHVSVUFCVVRYTGVDaG50ay9l?=
 =?utf-8?B?VDRjVGtSczMwWXFzZXNTZVczL0ZmWGxDdzBMaHl2S0VPRVZRUSs1U204aVE3?=
 =?utf-8?B?eXBnVU50ZU1iZ2gwa0MzenRPUEg2N1dZaUlmS1dtYmRuSTEwUDdBbmlHOTY3?=
 =?utf-8?B?ZW1zWk8rRGl5c0syaHprbnphNDhnYVZ1NG5vcUlDVzltMVlIeUtVUkNqNGMx?=
 =?utf-8?B?Q1FqR3lmZm5MVlpTU3BCa0ZJcTBMM0Z1Yk9zMlYxVHdTcy90UEtvNmFuNktJ?=
 =?utf-8?B?dWRxSzMyWmhSNUk1WEltNnRUZlhpTGxEU1lDMGY4R3FlcjRMMnJ3Uklmc0tW?=
 =?utf-8?B?QnhiUDhPcWxVeFFwS0Y5bWIvRk9NNloyQXRMRTFRbjMrUnlrdmFmV204QnM4?=
 =?utf-8?B?MXI0bDdSUXkyNlVIMWFkYWtaRGlyRzFKU2FIelJtUkFKcmZHald3SVRGMDlo?=
 =?utf-8?B?c2FJMjRaVjRsdlBrZHFFZlRvUDNNMys1M2FvZC9RRjFEclkvNXN1c2I5alJH?=
 =?utf-8?B?NlU1VWVsVDhGeFBFbkVGN25CZjI0WWZCL1NybE01RjRocFhvRXdVMEo2b3U3?=
 =?utf-8?B?WW8zT2hRSm5KTkdaYm9pVEJKUlUwRDJwOHM1OExDbkpjV2JqOHlaSHBJdW92?=
 =?utf-8?B?SmhPSmhsbVFlVCtwb24zdTNJWHRGSXhXOG1sdS9QT3JCbGw5dDdkRThtOHc1?=
 =?utf-8?B?Tk50NFpOMDZ1b2JEWDkvQWZLVzdVWGVJeTc2cGhBQU1GZ2NyYlgvSmswTlNa?=
 =?utf-8?B?eStUcXVNTFpxSkZHR3ArdHNpeTRHQ3pBYUhUSDU3NUNCUU1SdzdOOGFraEVo?=
 =?utf-8?B?QUZuSWVjd0xSanR4aTdVMjF0YVB3N3VJQnNsdXIyQkNhMWRRUlNEY2dHUSsy?=
 =?utf-8?B?MDYrY2xYT1Y3dmxLRys3UE1xRG5LUmQrUnlXdHVNOSs4b2o4eTJlMmNUN1R5?=
 =?utf-8?B?Q0RZa0xIejlYM1lxOHBJc05oWHMwRkd1TFRnQUVzWFBUMVYxK2JQNm9HcUhj?=
 =?utf-8?B?Y2JIcER5aUwwK1dPazNwMkQ1alRjOWNyOGJNZzNicXBmVktoRWxWSjNweWRJ?=
 =?utf-8?B?VzgrU2FhMk1oVGpOaFEvaTRDVWY0VkxDTnVmOFpkR2pmTnRMSDM2QmJEdFlE?=
 =?utf-8?B?Y1NnMHJVU3p4V2QzK0E4cGRoemkwR09DSlZZVTVaald3NFdEUzF6Y3lrcXYy?=
 =?utf-8?B?OWkxajU5czdqdURXSVFTd0pQMWQwcmhkTm50eE8rbWNuTkhDckVWdVYrU1Zo?=
 =?utf-8?B?TkRod1dwSnR1ZXlSdFZjOVNkWERBcFcrRHhTQ2NxTEU2TU0reEZ1SS93bUZ2?=
 =?utf-8?B?NHNLS1dERS92UlZFeXArQW8rT1grTVBPTzlrWXV0UldlUDZnam8zSGxwNzlv?=
 =?utf-8?B?WTNuVHZkQmgxQ0hoekxTT1RrMnZTUW9sYkRtcllTNFNtM2J2VVBrYmh2ZkNi?=
 =?utf-8?B?NnFkOUVWY2lHU1R6YmdsTWp0RkFmR2tNd0pVVWxoY1g4RWhMRXo5cGMvTXRO?=
 =?utf-8?B?clA3N0NhcTFaZGZMM0RFZGNyRDI4NHZPNlk5WUx3QzBCZjAvM3NMNmhrWFVU?=
 =?utf-8?B?Q25EaHk4UEhTR085VHJzMXNkNUxMdXh1WDR4b1NZNGl0RWNIZmliNnJ4aDM1?=
 =?utf-8?B?Smc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	15K2eTfnx71e+LJZkqBCvPfvTIfWz4ZYarrnXXQIeOFXMh2n2FShcT3P0n3rRQCjk6YqhQ3C4FYMv66DVkyYx5abL10w9FUmifmg4vNifw1295gCT3fIvTna9f6lFWk0JJnJL9nCk6cKci5g6CJeRWpXjHBVPHv0B53U3Xq7mQeMGr3sw6EOqarq0K95iFOSkw0Ft3rqXupd4CvUzg4kSokoIbPtgEqkvqfCNwdXRwX1Hq+GAnFIhGX0fVkoxjsxsYKCmvQFt4M5NKAszv12arh34YYo0kH+j5TMurWb4oixPRtiH4jTcBzFX2D706t7O7gaarrFSQ0SF3Ee5gqaoEk/5gSERgOTkRjUeY2VVChbWQPjvUOhHB/mJpCAv5TObPeqOm4kxkhX+c+mG1MznuvgH7uqmY1CTlDsmfQbp2bhx0xAHA8ntLIbvej6u7Sj41qKj+aSf23juILYfSfiq2ig+8lKLbZ0gIxElaXaOF2yjUs3lDHkekh277VLG+DmT8q4TuryrNJq3h78OYJT+edbGbd3ukNdcI7a/7riyh1uCKvcZ8BJHbAfO05TeJ/MDp4C+JGKFTX/a1tJ9/rO4ACItYDcIaIHL0yb3/LCW4Q=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eb83a885-36e5-423f-ff4f-08ddc91d9128
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4320.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2025 12:44:58.6146
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fKGvahA4GPJDKekqrcmSX9OwUMPPzZ5+8Y6Vax+zsjuW5+NFxypKW23ORWD69fYI9MZ26tBjgWKGniKMgBtakw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB7270
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-22_02,2025-07-21_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 mlxscore=0
 suspectscore=0 malwarescore=0 spamscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2507220105
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzIyMDEwNSBTYWx0ZWRfXyce2sQMYBBVp
 xFXipZnW/MNq61tZPBfWtTAbO0iPqpdtueghbGh2MjQgtK2651B0DBUySNLO5kdrZUwEWdnYGPJ
 vPlgyNhE4YpT4zY/7iYr04yBcqm7PS+xYAOeAmg67c6OHbjFu8uLEa6hRJS0SLf44SIGCzccX7t
 pDJPBeF0mav6B01x+dGX6ufU0dE/bXToxCPiPnn/fZ54JiZJcXrUDuOEBeqCo9PoX4pJdp4fTgL
 AsT5TWQJcC2X1CWgbB+QzQGbvLu6F4RR0Qb62jn59ymSP/wv00B2F84hruMe/CRJqaVXktFEHDt
 g3kwVQ/tT5Hpus8ybeZMOgUk/lLnJ9lhOKvbcJKc1Hf0ZcL/PZwCSpDuXxwfgRLFrJN4b565Zer
 0CMPfDT1MDowJeA3mwvB25xgvbelJ69yuirtZiyGtTFv//rjxI31Mkfuv4h1ry7RppgLDH4P
X-Proofpoint-GUID: 88Ft8CAU2xKTgJGRg8CTC_de4ZhckG-1
X-Authority-Analysis: v=2.4 cv=IsYecK/g c=1 sm=1 tr=0 ts=687f87d7 b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10
 a=yPCof4ZbAAAA:8 a=1PhKf-v-ultnJKlcvAoA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 cc=ntf awl=host:13600
X-Proofpoint-ORIG-GUID: 88Ft8CAU2xKTgJGRg8CTC_de4ZhckG-1

On 22/07/2025 12:28, Hannes Reinecke wrote:
>> The merging/splitting code and other queue limits checking depends on the
>> physical block size being a power-of-2, so enforce it.
>>
>> Signed-off-by: John Garry <john.g.garry@oracle.com>
>> ---
>>   block/blk-settings.c | 4 ++++
>>   1 file changed, 4 insertions(+)
>>
>> diff --git a/block/blk-settings.c b/block/blk-settings.c
>> index fa53a330f9b9..5ae0a253e43f 100644
>> --- a/block/blk-settings.c
>> +++ b/block/blk-settings.c
>> @@ -274,6 +274,10 @@ int blk_validate_limits(struct queue_limits *lim)
>>       }
>>       if (lim->physical_block_size < lim->logical_block_size)
>>           lim->physical_block_size = lim->logical_block_size;
>> +    else if (!is_power_of_2(lim->physical_block_size)) {
>> +        pr_warn("Invalid physical block size (%d)\n", lim- 
>> >physical_block_size);
>> +        return -EINVAL;
>> +    }
>>       /*
>>        * The minimum I/O size defaults to the physical block size unless
> 
> Why not calling 'blk_validate_block_size()' here?

blk_validate_block_size() enforces that that size cannot be greater than 
64K - does such a limit exist for the physical block size?

Incidentally blk_validate_block_size() also checks that the size is not 
less then SECTOR_SIZE, which would never be true in 
blk_validate_limits() for the physical block size. But duplicating such 
a check is not a huge deal.

Thanks,
John

