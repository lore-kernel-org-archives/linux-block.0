Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E30BF13D638
	for <linux-block@vger.kernel.org>; Tue, 16 Sep 2025 11:55:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758023740; cv=fail; b=TCDLICd4cfmc8+RLDzXvuWVroUUE7Mjohv6A/ZgdzgDo6O7A5yZSRx1s7pMwANMsp5RjAl9G1lJf16YwUfpWeicdxjP6owfeTdayS7mE25/wz9nuN+WWEycgyQoqhkdNqdO0MuMQ3nEo/ZRDWBDgDha/d59/nqpnpEFM/gIE9DY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758023740; c=relaxed/simple;
	bh=05wRv3YOXPu4GxHfUAVR/foCgnqXziC0G5tgy7CkStw=;
	h=Message-ID:Date:Subject:From:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=PpmyiayfTZF3IUDIw5jwyFrjbyFvP5L2Nu7qSpfw1sVJAsXeW76aYgc79kKjsEXji6rDbFw2kuklTtf/WU6hVc+bBypxIFLkD3YC2f8ch9+F9M5V8URtyjLzHNbmXtCkQjjbx3BLmxb2CiLDo2DTioWE0qRJF7Tsxq7N4GkgO3o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=JuAx7WWD; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=jbgCeeJG; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="JuAx7WWD";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="jbgCeeJG"
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58G1g39t029214;
	Tue, 16 Sep 2025 11:55:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=RNU0Q7NE468dW1KFEq2HBNcG2HqPsu9OjeqwwNHwQto=; b=
	JuAx7WWDehmwnIjiChIJ4Jw+rk4vHME0Kztq+OPLkM1HFeemvo2r0pUmdm9iEdy8
	UQ7Dfjz11g26kkxQ6DzvGv93b/w87Er2o+3OCobKdb/Io0PsyhLPtv3CD+sEqjb8
	BZzsn5k8rG9VqSYRe1rrHYi44OXY0epSQGZhXRWAiS+cLzWzSOvzsCKd2BNtQkp/
	9DcAgpdoKf5pZEPGH2owJNlXEWCpBKD2H3T1fkKJPwdC/od9y9xMRoM/+udQV4wV
	QmyiOMbw5EPmpgfFFaY0cpjHgHGEkMCtcmFH6oPf9iwHOp44T9vcLwuDZ10fR4Vt
	Ir23/St+b6wvXPI8anovyQ==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 49507w4f3f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 16 Sep 2025 11:55:31 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 58G9aG48033813;
	Tue, 16 Sep 2025 11:55:30 GMT
Received: from ch5pr02cu005.outbound.protection.outlook.com (mail-northcentralusazon11012048.outbound.protection.outlook.com [40.107.200.48])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 494y2c8u6t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 16 Sep 2025 11:55:30 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=a9H+r5H2tukH7HUn/M3vssBf7sd6pcjRkkGgWbWlhtKrcoR6OHFPyC/RUKkHsp/LAx5wztA9dZYzi4nRANR3+d8kWqj4sGHgH5Qf7u/y5SRqFWQnhd+VI/+rvEcID4VAZSU20HbnH4bNbLTCwT27xPkj0mTT1X0rAQUhRTPTL5MKwe4+V56vF3epoO8Bj5I/8/mXek2+PCh0pKjeTRtSBwrP3yhuwvwl0qtz9Xg7VZhy3ElnHVgt1RYQQZrANB3PxwbPjx+IPfHqT+dDxcv9LYRoDOAOue17gZSlVPTZlKmrzSP5jc87G95M6le125QUsVPPUF+F/7uBN6l28B63xA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RNU0Q7NE468dW1KFEq2HBNcG2HqPsu9OjeqwwNHwQto=;
 b=GT3xKjYtn0+B9XpCm7oQgjudIt6mQLP9yTmRTVut2woADeLb92gVYqlUcF9pz/ZbzTcl0NmbhAAaBCdt2Dm3oZx3VxXkQAkOr2umwaQL/O2R9PWoTsCgmHqaUWX3oZmPUvsB7pU4SDoF/lF3hMnvK325JMKQIObb8aAJOeSSVSTs8okC9O4F8hzkv9rfcDtMA9Q4v1drWlP1ngc2ZaBH4qSuToSaV9nCSfx+k3YZi7rqhLcKdxL9ZemCYkMgRobXFjbZ4gBfXyCuOE4TBYTawpsYMe4b7jZQ3+rnSIOIdd5baiA0dE//8OMsyNFCWaQHviE+YFfp46Nx0xpzvXGiHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RNU0Q7NE468dW1KFEq2HBNcG2HqPsu9OjeqwwNHwQto=;
 b=jbgCeeJGAlwsEIMfl89xd9NqXD69PA8mPYIWotkoknVAYm4UYcRpOlr/WZDy/EdLIrVVuXlHGZVpvBy3o+JjxO3cEgIExkyX4wfgwoGog/ZjGBs+KFLCZZylUZdskCAbl2IALyT3G1NuALZJ/TxZMwdsBQbHGKUsbf9nc8HcasU=
Received: from MN2PR10MB4320.namprd10.prod.outlook.com (2603:10b6:208:1d5::16)
 by CH2PR10MB4341.namprd10.prod.outlook.com (2603:10b6:610:78::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.23; Tue, 16 Sep
 2025 11:55:28 +0000
Received: from MN2PR10MB4320.namprd10.prod.outlook.com
 ([fe80::42ec:1d58:8ba8:800c]) by MN2PR10MB4320.namprd10.prod.outlook.com
 ([fe80::42ec:1d58:8ba8:800c%7]) with mapi id 15.20.9115.020; Tue, 16 Sep 2025
 11:55:28 +0000
Message-ID: <70d8a0c1-5000-4a3d-82c8-2ac7a76056e1@oracle.com>
Date: Tue, 16 Sep 2025 12:55:25 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH blktests 0/7] Further stacked device atomic writes testing
From: John Garry <john.g.garry@oracle.com>
To: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
References: <20250912095729.2281934-1-john.g.garry@oracle.com>
 <5eri4pgxaqhd2mcdruzubylfjshfo5ktye55crqgizhvr34qm7@mhqili4zugg5>
 <39c9f89a-6e6f-422f-88a2-3b2730b659a3@oracle.com>
Content-Language: en-US
Organization: Oracle Corporation
In-Reply-To: <39c9f89a-6e6f-422f-88a2-3b2730b659a3@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0521.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:272::22) To MN2PR10MB4320.namprd10.prod.outlook.com
 (2603:10b6:208:1d5::16)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR10MB4320:EE_|CH2PR10MB4341:EE_
X-MS-Office365-Filtering-Correlation-Id: 41415316-334d-49b0-71a2-08ddf517eda2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WU5wL0JMQ0x0NlhFVVNjVUZaWERPK2dCcnFRSXc0dWNTV1MwK1BnMlN1RTRi?=
 =?utf-8?B?VmpkOXZNeVRHTkVldkZ6STVyOHJZcjFwcjV3czE0TUY1WUloMzVVU3FWbWlJ?=
 =?utf-8?B?bjVGZUlMZUs5cm9jWDV2YkMxQ0xEYi9wSWphVmlHR05DVzdQTGNJM2JkQjRa?=
 =?utf-8?B?eFBWZS9EanlyUGdNZnJFcDdxUUgxOVVKODcwMDNzbG5vTVBURWNjWEZ1N053?=
 =?utf-8?B?aE1GT0lNYXBmVnZGQUlaNFdsdW5SeEJHTGk3SUR0VUN0MnNFeWZyS3FzL0xU?=
 =?utf-8?B?cDlTQzdOalBkVG1Hc2NzZmtlNWFkM1R1ZW9WRW1meXFVTkQ4WDVGUkF0ZnF5?=
 =?utf-8?B?NVRZSmpKU1c2Uk1WTXJzQ3B6NWE0UzNaRytNYTdDQXBvU09LVUZHY2tteDM2?=
 =?utf-8?B?ZW95S294M2xwdi9FQXdTVXV5TU4yNGNyNjh1dTRxSEtHeXRXbGNWb3hBelVa?=
 =?utf-8?B?YzRXSWJlWWRyMFowazdxOE9GZGZ1bmVxdGlGbU9HbHk4cWxXcTRDQjUxNSt4?=
 =?utf-8?B?N3FYb2dGMWxLczhLQ2dYaUlhNHpFVlRvK1BzWlMyMzV2MnowRWxRMytmOGtz?=
 =?utf-8?B?TEVBU3VYUEZBMWJSLzM3enNwTjQvaDlrQTUrSWFBVUpqRFNsNVQzcDA0Y0RX?=
 =?utf-8?B?VHZJSEJudkQ0QUxLOFo5QzFxcE5sdmdpRmczL0FDN012Um1EUjdubTVCbUFB?=
 =?utf-8?B?cWRHQWk3TXZpc1JQTnZhVkpTUHZha3hnSC9NbGx3SmxEU2VadmhvWXRkdUFr?=
 =?utf-8?B?b0JtdWxYSXZYWGNPazZsQk1PRzVSek1yQjJUYTl3cEc3azhGWHVEZzVKNzZY?=
 =?utf-8?B?UmN4dlRGZ3ovY1VHTDJJZTZkYzhFRkdRMHJNQWp4aUQ3b1hTOUMzcW1oWVIw?=
 =?utf-8?B?WWVJSTRhU3ZmZy8rc1pCbjZYSWk0WGloRWVBRCt6NzkzdlVvaTZpZGhROTVO?=
 =?utf-8?B?THVncGRGVmhIOUdyalpCcjhPWG1WeHZuL0xnK2N4RGM5UXhNYjVhZXVDR0lk?=
 =?utf-8?B?OE9EUS80SkdEUUJkRnl0ekpRelVvVlVPMisvdEJJTGZEdUJDNlBEM1ZiZ3d5?=
 =?utf-8?B?aTdIMnc2T01DWklORWZRMnlndCtIbHRNN2FjVHNJSVNjdCtvVVYxRFRqYlZU?=
 =?utf-8?B?K3ZBSmZkek0yTW11ZUloZlNPZHQ0R1NHV3loQjc1MXd0RFk4S2tLQlBCclQy?=
 =?utf-8?B?dDBrbzNoVUExSlVJTGR5ZmxzNzdoalM2MWFRUmNqUWxVdWUzZ21jVHlRbEVs?=
 =?utf-8?B?TlZVNU1meHpERURlNHoyL2k1VXdvNzBOVmlVVisrK29iRUhWb0FsR3Vhdksw?=
 =?utf-8?B?L1U5cVhCNm5CdE04a2dNRUZlQitVNXY3MnZvcUJ4aHU2dmRlWjcyWHBEcnBF?=
 =?utf-8?B?MlBmSDZLWERZR2tSd29aanFnWG1LallYU3ZIdGY0alkrUCtDdWZBdXFCYWNz?=
 =?utf-8?B?OHhQQWRURUZ6MG5FRVhpNFBIL0tyWTBnM2V1aUdEN0JxRnFCd0w0bDVEQU5H?=
 =?utf-8?B?cXAycWJ6d21LUTA3R1B3TUpRSG5DUFM5bml5R3ZrUk9aWkF4NFJHeXYrS3Rn?=
 =?utf-8?B?MUtobVpOU0d5czQ3L0hvcXZyNnRGNUovQW5kQ0pIaXZMVnZZdGw5QkliYVpr?=
 =?utf-8?B?QnFMaUQzakhwYXIweDRZOVpkQ2lhK2kwU1dHbmtub093c0dQakNla2tDaERD?=
 =?utf-8?B?N3Z1cWZUY1JDNDVhaXNsSUVDcWlZakpFWGtHVnpVQmM2M0dXUzkzNzg2bVVU?=
 =?utf-8?B?UnVUNU16d1A3V09tNGl5TGp3N0FxSWpyUmZncjMyMTU0QXV3V0hDRW1SdlpN?=
 =?utf-8?Q?XqufiqTYZIOFFQ36DmAUskyOXYKt3pg1ZuUrE=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4320.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?S1NmZyt6Q3Vqa2N3SGlsN1dydkVNWGlMRTVxckUrcjR5SFhra01PVTZHUUc2?=
 =?utf-8?B?YmNrcHA0TE10MnhtazNmVmNZdUVHbkMwSDhScjQybFlIRFBIU0RYbVFTdHNo?=
 =?utf-8?B?UFlDVTdUVEtrTjlVT3VJbnptUDYvYlZZZjJDMm5lTzFrSWpjTG5MNUs1dFJi?=
 =?utf-8?B?a1kyZ3VrVUdMaW1GNzZSUDY5N0x6MU1sOStQeW9TTjF3bHBVL0hDQ1VJTWM1?=
 =?utf-8?B?b05OOHhhUXFiMHJ0WWZTTUl4KzhqTUlLNFNxK3Q1MWdiclJkQVRLdHdqZjhU?=
 =?utf-8?B?aUJOVHRYb3ZDSmp2M3ZOVG1pN2hyV2MwMnJvSnBVM3ptdnB6QWhIczEvdTE2?=
 =?utf-8?B?YXQyemhmbytPYVdvbzJIbGNDaXBEQ24xWkxFc0FaeEY5Yk1HSjVObXd0Uldt?=
 =?utf-8?B?Z2YxQTJkQmJ0Q0xYd0hHd1JVZ2xLcitkZXlULzVla21qUk43bVc2RGI4MFVO?=
 =?utf-8?B?Qk4zMGRKcGtCR25IZmhIT24zRldRMm5VQ1Qycll1RFlqWFhoQWJhT2lHYzdP?=
 =?utf-8?B?SGE2RWl4V0cvRnpEd0hxQVdadkdxdHA1ZUNoQkxOakt1M1E3RFlyd2R5MHF4?=
 =?utf-8?B?YWJHQkNLVnk5WURsRDQrM2tKNzdZSVUzTHVGR1lkeUVKeXdJZG9jRUs2Q0xN?=
 =?utf-8?B?TmI1a3R5bjh1cXppdWVraEVjczk2RDVCY3pzZTl6L2Vmbnk4ejVNK1hFbENq?=
 =?utf-8?B?WXVpcHBIU09HRDNQbjBkN1VRQSt4ZFpQc3BFS3hUcllCbG51R3NLY0d5TkVT?=
 =?utf-8?B?ak1mQ2huRjlEV08rUFJGaWt5T0VSRGpTcTB2Sk9NNWhaSWZCSTZESTRPTkpk?=
 =?utf-8?B?VHBSbDhLYmNBY0puTHp2U1RhcnpKZFdIRmhPeHNYTG8ydDJrTmFxQWl0ZXF1?=
 =?utf-8?B?Y3JCY252dnAyY1JISTluUkkrOTFKVVlqQ043SUU4d2hGd0ZaNk8wMGdROURE?=
 =?utf-8?B?eXVwZEp0VDNVM3liell5ckx6eTRkK3NzY1ZCOHBWWFV4azBGSVNzS2tKL0lj?=
 =?utf-8?B?VmZLdUdQN0RhaFdGWmI4MS90SGk4QTk2U0VidTFwY0xBeHg2bW0wMWpLSU4r?=
 =?utf-8?B?enkyNFN6NTZabWVULzRHem81cDEvY2xJWUJmSGN2SmhwczhDVjZtQ3E2SGRW?=
 =?utf-8?B?TEZTbTZHK2hpT3NFNGZhQnNOaG9MMnFKR0Vzc3R3N0xoZ0lXTFBsclNPUzZv?=
 =?utf-8?B?SU1kM0VtU0NoLys1Z1o4KzZRbmNKRlVqakl3VXpybWRvQXlNeDRTOGZSa1RW?=
 =?utf-8?B?YUhLTmdtS3ZlWFM5MzdZUlRWa1lRTGlsZ0R3UUtPWXFzTGJaZ3VzZ1FuZEdu?=
 =?utf-8?B?YTAyYmdPb0h5S0psc1BQWTRNVm5HNHpWY1BhU1g0NzZJRk9Bano3dHJ3N3Zz?=
 =?utf-8?B?WnMzK1FlRUFETGt4TUxTV3kzNjBNT0x2WFpkeDIvTWNUdXE1S3RkNUdkVVl6?=
 =?utf-8?B?ajhYMngwbC9FWGIvRTZPenY2WS9aM1dxeHU2UUpHeDhkWG9LNnh5d2FLVGls?=
 =?utf-8?B?blBGM3dWWUlxa0FEdExVc1FsVFNCRS9OcGZ3RnFPbzVZUkJFRCswSUZVT0x0?=
 =?utf-8?B?cHc2cHBubmlkRUlZK3Vmb2lpRWxWejlUM3JYQllOaCtsSmQrTk42UkhSSHZO?=
 =?utf-8?B?empicElpNkpMQUtpRTlvSUF4ZzdJSko2dVh4bDNpbE9VbkNpOS8yaEptQVgz?=
 =?utf-8?B?VVVBRGRvcUgwU1ZWd2VVdnVuUFFpNWcxZjZ1c3lWMFFoZGIrcWVrY2tTOHM5?=
 =?utf-8?B?WlJsVXBVN1RjY09VSE83RjBhN0ptY2VGNkVsRDhzY2JTazYwWXRSbHg2bU43?=
 =?utf-8?B?aElGQzd2K1VPWTRQcWk4WnYwcXJueTllMjF0S2ZmbXdXc3Q2NWVNVWU3U0tW?=
 =?utf-8?B?SUZ1REZZVzJRblJFRS9BSEQxUnJVbUM3NlBQSnN4UGlCeXhsLzdSY0hOL1hr?=
 =?utf-8?B?bkt4bGdqT1J0TDlLcDh4dkxOMzNHcXE3MlFwZ0RONzVjRGVzVWg2dENvQVRP?=
 =?utf-8?B?VVVKdDhsL0ZJQmt0YjBtU1c0YTZVc3FQVUR6Q1Q5b2xodE9xU3drYU1CK01P?=
 =?utf-8?B?cFVzM3VoT0tOWEw0d3VBL1lrVmIwciswT1JiT2YrOFgvbVZOYkFnUTFuYjJj?=
 =?utf-8?B?MGMzOEt3N0JyRHNrVVlrNjlGWnBKSlVFaHQ4eGVVS1AzWHN3NzNzRlBTUXRo?=
 =?utf-8?B?K1E9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	N9DzWus4Dwwdea/yTO6gIPPriu4bIOPTKsIVn/JIUPYEjL/Hlnyh1RtGJBDf7w8hH1XBA7/OzIPnV63v5eq0ZMnEIx2xTddekaPO7O0IBQ731E0g/It2dYtoraorBvNvR0ZI4nOA0WxjHwUj1gU0YUTlGHrBuPNu8X0wSzvb0BAmJ56VRQnD0k6tXIwZCkZRiahyrdCY7x9GST5eJ/kxOOU8UML5U8eRpxxVzbSzzEjzZRZ2u9zkDvbmyq8pIV1LUFNI7baBHVbwDLAWN8rW6LIDhmq7toRqYbUYJowB8eD521/0JxWSstmIYX2yCF3avHQGbcVMbY0KaRgXc/lV5b19dUWJaLjAtbqXI7nfhmG1elN/5wlaqOvKTiHdAYTYuiZvqFqAL8MAlLi8+DdSBjvDuwdFnDR7iBBzn5RPRb5y3LM9e9BjezgLzPBjsyQDe4QAnpIQesUoD2a4oS/AcXmzrZYH6AcZbx0drgX9DsX+cYN/nOLhLBCMVuC1es359FkweEGBCkUVoYlCtIfHNHZEttJ4VlwRyRKiW+/6hKtieRnOAbUIqLqNIxamHx0d84O77QuilCOBIRPdsTpGVGMRSWjLz5r3DzCJwAbERj4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 41415316-334d-49b0-71a2-08ddf517eda2
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4320.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2025 11:55:27.9233
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wdYiwmrPjmInsOdZH3I9wy4CV3bwDSF4fRtfSySgsyaURztrsOQr2fygB9bmopgsJn9+SSf1wziBQkbuIAhl9g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR10MB4341
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-16_02,2025-09-12_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 adultscore=0
 mlxlogscore=999 spamscore=0 mlxscore=0 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2508110000
 definitions=main-2509160111
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTEzMDAyNSBTYWx0ZWRfX8nhQ4yIAJ8aQ
 FR279FlHIb/ywcSbyAX+NT9pKAn4vP+HOK5+doWQUrvPoTN6pnt+Y8Bobi+JHBZEj8ebbTuUDLj
 7o8bZ4rhHtYtfyNmLj3Wm+TMKLSRVqEvUzt5eSdq6H7Ipmvbo1cDsZXakWP1pJ9EzMt/X1eQRbE
 tZaJQgw0WoD37HYv+JsUCytLMPJfoQdevjTxKCM49MHX5mECQ2nhKRnm9sR6B59ZhXpvvOcYJA1
 hvqGnL9E4CT69SEXxIq+JMZdPk163xKgqBXEI3mZeHY2Qikt4GW8ARCP0wXxYthW6I7JGNkSKlM
 FPe23UqYZLLTc9FLOoq5yIHlxJH92Sr7g74oGLDDMn5jTgoZXoRgiNGjkjNzrUEETTTaSwqH7+i
 hpqEQOYV
X-Proofpoint-ORIG-GUID: oJuAgxaRP0PmXazV9LTS-8M9TJxCLV1k
X-Authority-Analysis: v=2.4 cv=RtPFLDmK c=1 sm=1 tr=0 ts=68c95033 b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=yJojWOMRYYMA:10 a=GoEa3M9JfhUA:10 a=uherdBYGAAAA:8 a=NEAV23lmAAAA:8
 a=A1ZiZ8SQ756uxF8wwbIA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: oJuAgxaRP0PmXazV9LTS-8M9TJxCLV1k

On 16/09/2025 11:20, John Garry wrote:
>> also modified md/003 to adapt to the change [2].
>>
>> [1] https://urldefense.com/v3/__https://github.com/kawasaki/blktests/ 
>> commit/7db35a16d7410cae728da8d6b9b2483e33e9c99b__;!!ACWV5N9M2RV99hQ! 
>> Lm9AlQ3T9qSGDEjCR0nGmjCGC_2wfuAbkP6zN9EfZD7L2Y7mgpKPah_fYZh6L_OPkH9IIxP4f9n1Q9dRRRJxbZQeqRtr$
>> [2] https://urldefense.com/v3/__https://github.com/kawasaki/blktests/ 
>> commit/278e6c74deba68e3044abf0e6c3ec350c0bc4a40__;!!ACWV5N9M2RV99hQ! 
>> Lm9AlQ3T9qSGDEjCR0nGmjCGC_2wfuAbkP6zN9EfZD7L2Y7mgpKPah_fYZh6L_OPkH9IIxP4f9n1Q9dRRRJxbSlcsw0E$
>>
>> Please let me know your thoughts on the two approaches.
> 
> Let me check it, thanks!

I gave it a spin for 003 and it looks to work ok - thanks!

I further comment I have on my own code is about this snippet from 003:

	for ((i = 0; i < ${#NVME_TEST_DEVS[@]}; ++i)); do
		TEST_DEV_SYSFS="${NVME_TEST_DEVS_SYSFS[$i]}"
		TEST_DEV="${NVME_TEST_DEVS[$i]}"
		_require_device_support_atomic_writes
		_require_test_dev_size 16m
	done

Notice that I set TEST_DEV_SYSFS and TEST_DEV, as these are required for 
the _require_device_support_atomic_writes and _require_test_dev_size 
calls. I'm just trying to reuse helpers normally used for test_device(). 
Is this ok to do so? I'm not sure if it is a bit of a bodge...

John
