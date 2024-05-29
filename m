Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49DF41C68B7
	for <linux-block@vger.kernel.org>; Wed, 29 May 2024 20:52:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717015934; cv=fail; b=VoYKdBOHcHBEVrViOMSO0GZktWermXzPMcf8JTmy04XuDKGdWcvxY8h3meQ8VXll0xbz4F+Hh/Sw/cjsyP4TItvMezwHhZCIa4ZZ9H/MzMo6MsHuzja/EAMvRiJqzuZMVoGmzRMcnlMdS1AwK8aolVOTuhlzu+GNt0cnet1Eddg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717015934; c=relaxed/simple;
	bh=pvvxAQXXAHSbAfsESbnQaa6gsPW2NwgG7RyeychIIYQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Rc2lvX5V4P2wavpQk1NEWGj27T3XBfOnb40JQltOYYTG9jmgvEXpArj9Ep0GoGJU8yBBzXin9pQlsYHxnuCqLfhzf0shPdYcmzJ+byw/3usDTDlYDpRFzqcsnmOvT5gjNBtXeeacta98glFOMWHjj+FfxijlnemAmH3xjbXuoys=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 44TKkagA005409;
	Wed, 29 May 2024 20:52:10 GMT
DKIM-Signature: =?UTF-8?Q?v=3D1;_a=3Drsa-sha256;_c=3Drelaxed/relaxed;_d=3Doracle.com;_h?=
 =?UTF-8?Q?=3Dcc:content-transfer-encoding:content-type:date:from:in-reply?=
 =?UTF-8?Q?-to:message-id:mime-version:references:subject:to;_s=3Dcorp-202?=
 =?UTF-8?Q?3-11-20;_bh=3DpvvxAQXXAHSbAfsESbnQaa6gsPW2NwgG7RyeychIIYQ=3D;_b?=
 =?UTF-8?Q?=3DcQy5vWLqjtxaTgu1dAX6BFeVPArlOK2F9cCMSlX3aieg1HHOb3nComkpIuBZ?=
 =?UTF-8?Q?gPacSRem_NzR3TmBYSPasRl6ng9nKwH5/ekUj5ouUsH5BY5viSXzyT0I/uh3ZSd?=
 =?UTF-8?Q?SVp3HjVXC7dQzv_K6G48c5ulIwi6iDjmrM3dRg98xzkqAsPT1amwxHLGipDZdfa?=
 =?UTF-8?Q?vjkwkPa/jXucRPyUREHJ_EeBYcL9M1bMg+Eg6hu7hHPxGoTEOeCzyG2NGaQMxOv?=
 =?UTF-8?Q?o+EzGbWUi6v3Knz1htQxzoMa2F_sgmVeKdNEibcPdttfMrncumZiUhT1mlRfRM7?=
 =?UTF-8?Q?q8FXcb4RPHjuyxoMqvmbnA3rL2IohK0w_cg=3D=3D_?=
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3yb8g9qqq5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 29 May 2024 20:52:09 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 44TKG1mU026568;
	Wed, 29 May 2024 20:52:08 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2040.outbound.protection.outlook.com [104.47.56.40])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3yc507qs22-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 29 May 2024 20:52:08 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QeNKbB1M6ld5/mka+Rhm6gPH06gOODYqtbUIKs0TAYGARhOmYFzW8+k66Fe7FasJB9l/NlhDDyflJ38Kg9F1iSBk7XbbpgGamXWSQtgqfQdx3nC+heb5Bt/GEQRhhIPKTq9PSwnIPOFAvz4WQFBKglI0cGvNyTFIonxgLAUfRyB77xoQUHWZp0nVg+xeYVRqN5Rd3hIko77h4WTrP2NfcggDJZnwAxr8dx7kAf6m1Kfnl3h/pnO/ihNboRT2ezGN6nhUVDG1UycZRyG1t76i72N1OAzxJ16W0z7a9twgCywfJ0MrUrOJzae9GlYc+igZ5fzOC+CppN/usV+pt3Wz2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pvvxAQXXAHSbAfsESbnQaa6gsPW2NwgG7RyeychIIYQ=;
 b=lNvna2f9Cq7CEEXLYPJQbmqncXcrWBNMFEqHVVesRCLmb4DqhG2lTxU/ZgQc9g9RRBh5wyafKlOcNoQp8Nupr6WEkZ35Tc+jUmyiRrOPKAzh3YHwuZvtvWfcTHfrn33Tp1AEJRIrHAD9+g24aHWmdgybO5q9OIDz/EZw4uXjPUWISTfxtvPu8i1mhJpzJg5e0m83loKItdxD6A/2jROC7ZJXHChB3fOVZKDugZZzqnrItrn78Mh9tcUCmqKih8/MaVMRnpahdi9JQcCRovXs1AR5Lvzi/L+M5Yp1nqVhZo9jxMYySaxKCcou/unjFxwtvMHX7SxLrP7qN/yeOspLvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pvvxAQXXAHSbAfsESbnQaa6gsPW2NwgG7RyeychIIYQ=;
 b=ftcBoGiXhUc2ztjWNNWOlZp2YCXuyiSOvu/NaKnaENp66czgRX86L2HYOEoW7pH0XC4K6mmCyNrvmOsxyPIgGVpszXipC7fQli/cJk26SLr6ofJQXQKdOgbXABGcxKY2hXMjnUZSjLrbuWmTygIFren5YsAZ6Gm+bizx4owcZH8=
Received: from IA1PR10MB7240.namprd10.prod.outlook.com (2603:10b6:208:3f5::9)
 by SA1PR10MB7813.namprd10.prod.outlook.com (2603:10b6:806:3a9::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.30; Wed, 29 May
 2024 20:52:06 +0000
Received: from IA1PR10MB7240.namprd10.prod.outlook.com
 ([fe80::962f:da30:466c:6a1]) by IA1PR10MB7240.namprd10.prod.outlook.com
 ([fe80::962f:da30:466c:6a1%4]) with mapi id 15.20.7611.025; Wed, 29 May 2024
 20:52:06 +0000
From: Gulam Mohamed <gulam.mohamed@oracle.com>
To: Chaitanya Kulkarni <chaitanyak@nvidia.com>
CC: "shinichiro.kawasaki@wdc.com" <shinichiro.kawasaki@wdc.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: RE: [PATCH V2 blktests] loop: Detect a race condition between loop
 detach and open
Thread-Topic: [PATCH V2 blktests] loop: Detect a race condition between loop
 detach and open
Thread-Index: AQHasevOZr6Y0sN42ke/8xdhwSqBHbGulOUAgAAOGhA=
Date: Wed, 29 May 2024 20:52:06 +0000
Message-ID: 
 <IA1PR10MB7240923E1C732FA7BBE183C598F22@IA1PR10MB7240.namprd10.prod.outlook.com>
References: <20240529171516.54111-1-gulam.mohamed@oracle.com>
 <ac8696f8-b24a-4556-8a08-b59521dcd5f9@nvidia.com>
In-Reply-To: <ac8696f8-b24a-4556-8a08-b59521dcd5f9@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR10MB7240:EE_|SA1PR10MB7813:EE_
x-ms-office365-filtering-correlation-id: 246abd4c-28de-4f3f-e6d4-08dc8021335a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|1800799015|376005|366007|38070700009;
x-microsoft-antispam-message-info: 
 =?utf-8?B?OVNidWZvbGNzQkRQd1VyWnAzdFVPYUhzZ2tTMDhPOW82ZXUvenFqSkhoTVVj?=
 =?utf-8?B?ZkRRak9Fa0Q2aklxMUZJa0xseXRIOWdqc3JTTHl4cXA3SE9qTGMwSndsamE3?=
 =?utf-8?B?MVZ1SUNQdWpVRDFHU0N0dWpEdXFCbTBldE9oK01hdmRlZEErR3Nmayt5UWFC?=
 =?utf-8?B?VDh6RkFQOExjdm1UNkdsYyt3SGUvUzJqOFZTUFAxRUFzZE5CbGtsbm1wTmw4?=
 =?utf-8?B?Qm91WXFZbHg0UGlIa0dBTU5PM0JRRytkZXNHNThOUWJjdjV5VTFHUVJjTWFY?=
 =?utf-8?B?RnNHYjB0Q3NkR2wyWnZvclN3bTlIekFVRWNzaEhoWjRpbW53MnV2THRjekhP?=
 =?utf-8?B?SWg2RXJ1MWJhVGhHMVIrbVpZODFYZ092a0NlUS8vb3JMTjNWc2RCRmErcGpN?=
 =?utf-8?B?ekFNWmdOREhmOEhlVVM2SVBPajJ0MUN1bDlWdlJsOTM5Ky9xclBIWTFpTFFj?=
 =?utf-8?B?VUpMa1BVMWpHTHdaSzhndDRHeTBMeDF0OVhCSXlqZ1p3NjQwVVdDc3JaTTBG?=
 =?utf-8?B?TzNDK3lsMjlWMlhGYnMwakZyR3VwdGtaRlhjTGhEVStxYmFnVERRZnBKdHBQ?=
 =?utf-8?B?MFBzSUZ2Smhzbmx6aU1uZXRCWmpNN1dFT0Z6dzE3bCtjTlNNdDN5UW5zQW9u?=
 =?utf-8?B?TkFpSWVwVEtSbjZxaWFqT044R1pvaDhPUUlrSzF1L3drQnlOamNWWm1hZjhh?=
 =?utf-8?B?dW1zOGs5S09OUXhNQThYVG9CU1FBMUJYbjdNUnF6cnJKS2xEMzVHdjlaSVBQ?=
 =?utf-8?B?Y0gzU1BnVVNsZytaYXA1S1RNY29aVWlOU2pZWjZsT01qcGJyRFJRR1JnUGQ1?=
 =?utf-8?B?UEYrZDdxSVNCcGxYMnRyWXZHU01mM3VjQXovcVk2dERFRFJmYkhKelBMdzg3?=
 =?utf-8?B?ZUhHVldwemN6c0NSMHJuUDVJQnlZYjh5YVJwVENGclBTOFY0VVk4cHFtTTcx?=
 =?utf-8?B?cW9nS2Z4MUZXYStYa2N5Z3lSdU1nWlVjdEdJNGQvVlNaQklvZXdsSHQ3Z21G?=
 =?utf-8?B?NTFiQ2dZYXFQbkthU0hWRFhkMGZrK3R6RVh4RzVaaWFkZnhBUkJVTkkyRGU3?=
 =?utf-8?B?ejVFMFZqblg4WG15U1lUYW01R2xCNzNWVlJPK2hOWjRveUp5a0xIeXB6NGxl?=
 =?utf-8?B?MGFwR0kvbXc2TFhJb0NxOVJWY21PYmJmVVplSDBucmUzblN4bnNSLzh5anl4?=
 =?utf-8?B?dVV4REFsNzNZejZ4SjVOWWlKRS9aQ25TQ3pBRVJxYWxsZko2SlRsSU9ITnR6?=
 =?utf-8?B?WnVMaXlFc0srQ3EvcFdZWWVMcDJvNkxTNGZ4U2RMVVpaVHFBcU8yamhRTjdR?=
 =?utf-8?B?T1ZhK0xJNjlYbUF1VVZiUVVucTRKbjNoTTRrd3hZTnJZTG11SzAvb1ZVaUE5?=
 =?utf-8?B?dGIyaExGOEpGcjZ4NWp3aDQzZDJDNCtqOW5YemhXMEJyS3cwV3JaSTZGYkc4?=
 =?utf-8?B?cXYxUFVGWHRaREQwVmtwTFdCSlhQRnBKMGJyNlJGaGpwMTRkMitxM2o5V0da?=
 =?utf-8?B?c2s2L3pURnY4VXZHTVlPQmtITTNpWHlHMlBxcVFaQSt0TUpLY013ZDJMVkpu?=
 =?utf-8?B?dzJFK25MRGJXeGVwazY2NEFQWU05eHpUN2U4YWdwaFZxR1VpMDMwVGVNNVVQ?=
 =?utf-8?B?YllZTFZPTDdtUVY4N3h4dENad0l0MnRPV3h4TjlRcFdRcWJaTkFESUZVUThx?=
 =?utf-8?B?bFFDM2hGalRwaUs2RDFHV241N0RKV3JoVG9GMGhPa3R0ZkphcUwwNGlFRFZ4?=
 =?utf-8?B?OE1oQVo2dnA2VTV2UVZoVWwwZ3MxKzRYWGpiVjJIS2Q0TVpEZnljZGpXSk9V?=
 =?utf-8?B?N1pQSWhHdjlVK3VYTi9lUT09?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR10MB7240.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?SjNuc2orU0l4V3NsWVp4MTZDRnBUd01tcmdNYzJzYU1ud2RSNENEOFMrakd5?=
 =?utf-8?B?YU5NbjZ6ck40aVhaNy95SHlkdWR5L29wdkdQRnpuSGc2VWk1K1piVFRyYkNS?=
 =?utf-8?B?ZDNZK1M1ZzlSeXVhQVdXbVNXd2dSMFhobFgydFNVR1Y3MDVFV2U1WEZ1VlBL?=
 =?utf-8?B?M2N5KzQ2R3VsL0pIN2FyZVF1T1daYmRRVjZDQytUNGtKMk1kNkNGdmkzTzh6?=
 =?utf-8?B?blVqNlI3YXNIcGFpd29wTkpGZTZJUHEvMWVaWmxab2ttRzluc1phV2dFVm9B?=
 =?utf-8?B?MkozQktlekx4WHdIdysvUXdzSDhabkNsWE81VDlYQTVhWlpXdW5lM3V5Nk40?=
 =?utf-8?B?SEVGNG5CTTBEbzZEelBscGJ6cjAyaUN1TnZZakFtanh2cXQxSVpOMTJ0aWNZ?=
 =?utf-8?B?dUQwWmc0SW5jaXpoMFZXdkppOHBqY0JtNng5aXp6S2Jza093d3ZCMDBvZWVi?=
 =?utf-8?B?dHkxWmhFQ0lvR24yMFJIZ0Y2dDBwKytwOG9WeHlFUzZFbFhYaHkrWG1qQS9H?=
 =?utf-8?B?ZFMvZHhkbm1tMDRoRUpTK1dldFk3dXJxdWVWR0I3Y2IzdkpqellrbEN4OTRa?=
 =?utf-8?B?OHkxODFlM3JZeitUek1pQ2Z2WEhBWFVuajRCcFRjemJnNFRsc2hpRWdZSFZx?=
 =?utf-8?B?Yjh2bnJ3Z0VVQk5nY08yTHV5UXM5QldSaXNDSzc1NDBiazZobk9nTERWSWNQ?=
 =?utf-8?B?c0FOdFdkK3BEUUwvT2d3VnlJdkJWSHZnVU5mSkFDQStMQ292NUhnR2ZIYkZC?=
 =?utf-8?B?MktKV3FHU09jVFdQbTlha3kzOGcyQnNVMWRIYlB0ZEVSMzNSVGhka1ZJTE1H?=
 =?utf-8?B?cDFxT2ZBbmxPTC9GWVh2WWV1aEgwaFk3MnQzMUpDNXl0bjQ5d2cxY0RQaWNk?=
 =?utf-8?B?Z3JaRnhjV09YcDVXNDdqc1lhblY3TTJwVmgvSnhuclVrNmFXUndUZ3MyUllX?=
 =?utf-8?B?b1Ntb2RKS3JXcW9zUWVjS0l5clVWQzEwd1NCZDlSbHhHTHF6L0EzRXJGOFpj?=
 =?utf-8?B?N1hVbnBsd0pveUtKSnE2TDgydmEvcFRDR002eTdCeTV2L2NnTDQyUmdWUVpK?=
 =?utf-8?B?M0hBcHR1ZFhXY3NuaVFtWnZZektVWm5tTVdtS01CbjdpVzNJelhEdTdpK1py?=
 =?utf-8?B?RXlmTzF4VUF0Q050M0NUdHVPYTRBRDl4bW5OYnF2RE1RNU9vdGRxWGh1NGFR?=
 =?utf-8?B?ZGxzUW5XbzJpODBEU25KQmVEOGQ1Q2lZQjF5RGNjMVUzdkdIemtKWTIyb2Yy?=
 =?utf-8?B?ZzQ5dThrUGxOMVZucm1QNGhwbmNHNmlZWW42Zys5bTFYYlhUY2pzSTM0VmhP?=
 =?utf-8?B?aEdhS0htUXRPL2FFSndLL2pGTUNKeDhYRkNaY0kwYk81Z0FEUHo2aURHL2RK?=
 =?utf-8?B?NHFRMnovUWd0ZW9XMmwwckwvbys2a2lUeVhXb2pKeXNHcExWa2w1WHVCcHpK?=
 =?utf-8?B?U3pzMW9mV2Z0MmN2WFFQWkhVRG9sVEwvUEEvRUx1cWFCWVNaRklmZTBwYjJx?=
 =?utf-8?B?OTcvOXJZa2hPcE1zNjdqdUJWR1h1Rm91UzFRcVluWjAzY0NFQmtvOVZDa01R?=
 =?utf-8?B?NWI3ekJSUUtlV0pUYkduZFdLNXFrK2xGbDZ4cW05VEdBdTN3U3d4OXk5KzBn?=
 =?utf-8?B?MnBmblU1YXBKd1NMeithSDdDMHcxaElXMWtHOVJhanRraGF5Y0VydktmcjhI?=
 =?utf-8?B?ZjZLanc2SUhvR2x6U1A5UVVZMVl6QVNaTzJrblJOcE5GRndyN2wzbVJmZGdJ?=
 =?utf-8?B?ZmVhUDFnMURJU0JKS0ZOZzVGcTU4eldTeG5NK09JRGxkUjdyOTJvZGhoQnY0?=
 =?utf-8?B?NmpvT1U2bTdYeUszK2hZVlJHdTFRbmlUMy90U2dWbS9lbjdJb0VGc01XWlFU?=
 =?utf-8?B?UVRaMUVkS0FsbzQ2cGFOZ2U5OGF6OEpjMjdFNHZzTVRiQ084VXB6dUpzTUYy?=
 =?utf-8?B?UlJZKzZJaDkxdDdXa2FndTBMem8xNGRsTEJyTHVrWVAvclRwUVNPdVI1bTlK?=
 =?utf-8?B?UjNlb01ubHdGcS9OV1I2czVSVVJkMFVsdVBrS0tnSWdBakxSVWljeXRVL2E4?=
 =?utf-8?B?ZUVNNHJZRWt6aW5VcHV3MEppNGQ5cHpHZUgvR0pHRWZEd2dDNEJNbHcrTzdp?=
 =?utf-8?Q?YRdxuwLw0p/isQJKQI5isc5FM?=
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
	isab8Q4J+g4od3xmRkIAXm22BMlRO4WVjxufupiqQSS5IZlxdIs+d2mWTEdHnf9zPJ+dRosajJJPQt7oj7h1N8HjT92oqPGmYonr5O9klysq5otkdVQ3AVigIFTx3gkoxnRocRTGb0NxH2QCMSDxssK9TVnGe9bFojIbjw2BaJpfhoyOUGH30jxONj/fi1xVGByCSYWC2XvQBpeAbNwPpTAJlvYx9GTnm7Y5qBvjNyT5fgMD5DsNQxxXShxFlQ8nXrfT0H8p2QdtC31sf3cKq1HjqestzpVt/l58dbD4hbSqm0bbaxL7v94bTwFor0jSQKvZMjLDMvutS5ilnoiclLtXm7q6DHkhRJjvVAvCQjfdnKE1S7yEC1RBE2UAm+C3WazXfgWy+U9ey1zHdVJB2OPZpGUf43Hbo+jxiVldLeeKucUwoQwkHS63usB8+S4IpJf12CDW3c9lkbmr/RHXYNO05HeXTBCCQ2SPFwVlY5TTgsgUSmXjUApC6IwWRyyc41P4PQbiMWqwPGwPjx8PXNtKYMnyLk4sAFUifl+H6m63JixvldpiYwF3ajNZ+uUcB02rEbG2Vz+z8DwSZygA6yg9XuMw4BbzPf95u7ilIVs=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA1PR10MB7240.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 246abd4c-28de-4f3f-e6d4-08dc8021335a
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 May 2024 20:52:06.3054
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Nh0G/wN2be3A6o9P9mUqclyQhaz5zCce+S4MRKRJl0MdXOi1CPrAWQNQK6hBwdd8QmN5fTcwsQIqU11oLZ2dwQFK/bXtX1IVTeAp8n+ctD4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB7813
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-29_16,2024-05-28_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 mlxscore=0 adultscore=0
 suspectscore=0 malwarescore=0 phishscore=0 bulkscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2405010000
 definitions=main-2405290147
X-Proofpoint-GUID: KjWxnTMwwTdm0_ySsS4K0667iVjSP8Wx
X-Proofpoint-ORIG-GUID: KjWxnTMwwTdm0_ySsS4K0667iVjSP8Wx

SGkgQ2hhaXRhbnlhLA0KDQpUaGFua3MgZm9yIHRoZSByZXZpZXcsDQoNCj4gLS0tLS1PcmlnaW5h
bCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogQ2hhaXRhbnlhIEt1bGthcm5pIDxjaGFpdGFueWFrQG52
aWRpYS5jb20+DQo+IFNlbnQ6IFRodXJzZGF5LCBNYXkgMzAsIDIwMjQgMTI6NDQgQU0NCj4gVG86
IEd1bGFtIE1vaGFtZWQgPGd1bGFtLm1vaGFtZWRAb3JhY2xlLmNvbT4NCj4gQ2M6IHNoaW5pY2hp
cm8ua2F3YXNha2lAd2RjLmNvbTsgbGludXgtYmxvY2tAdmdlci5rZXJuZWwub3JnDQo+IFN1Ympl
Y3Q6IFJlOiBbUEFUQ0ggVjIgYmxrdGVzdHNdIGxvb3A6IERldGVjdCBhIHJhY2UgY29uZGl0aW9u
IGJldHdlZW4gbG9vcA0KPiBkZXRhY2ggYW5kIG9wZW4NCj4gDQo+IE9uIDUvMjkvMjQgMTA6MTUs
IEd1bGFtIE1vaGFtZWQgd3JvdGU6DQo+ID4gV2hlbiBvbmUgcHJvY2VzcyBvcGVucyBhIGxvb3Ag
ZGV2aWNlIHBhcnRpdGlvbiBhbmQgYW5vdGhlciBwcm9jZXNzDQo+ID4gZGV0YWNoZXMgaXQsIHRo
ZXJlIHdpbGwgYmUgYSByYWNlIGNvbmRpdGlvbiBkdWUgdG8gd2hpY2ggc3RhbGUgbG9vcA0KPiA+
IHBhcnRpdGlvbnMgYXJlIGNyZWF0ZWQgY2F1c2luZyBJTyBlcnJvcnMuIFRoaXMgdGVzdCB3aWxs
IGRldGVjdCB0aGUNCj4gPiByYWNlDQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBHdWxhbSBNb2hh
bWVkIDxndWxhbS5tb2hhbWVkQG9yYWNsZS5jb20+DQo+IA0KPiB0aGFua3MgZm9yIHRoZSB0ZXN0
LCB0aGVyZSBzZWVtcyB0byBiZSBhbiBpc3N1ZSB3aXRoIHRoZSBmb3JtYXR0aW5nIG9mIHRoZQ0K
PiBwYXRjaCA/DQpUaGVyZSB3ZXJlIGluZGVudGF0aW9uL3NwYWNlIGVycm9ycy4gQ29ycmVjdGVk
IGFuZCByYW4gIm1ha2UgY2hlY2siIGFuZCBmb3VuZCBubyBlcnJvcnMvd2FybmluZ3MgaW4gdGhp
cyBzY3JpcHQNCj4gDQo+ID4gLS0tDQo+ID4gICB0ZXN0cy9sb29wLzAxMCAgICAgfCA3NQ0KPiAr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrDQo+ID4gICB0ZXN0
cy9sb29wLzAxMC5vdXQgfCAgMiArKw0KPiA+ICAgMiBmaWxlcyBjaGFuZ2VkLCA3NyBpbnNlcnRp
b25zKCspDQo+ID4gICBjcmVhdGUgbW9kZSAxMDA3NTUgdGVzdHMvbG9vcC8wMTANCj4gPiAgIGNy
ZWF0ZSBtb2RlIDEwMDY0NCB0ZXN0cy9sb29wLzAxMC5vdXQNCj4gPg0KPiA+IGRpZmYgLS1naXQg
YS90ZXN0cy9sb29wLzAxMCBiL3Rlc3RzL2xvb3AvMDEwIG5ldyBmaWxlIG1vZGUgMTAwNzU1DQo+
ID4gaW5kZXggMDAwMDAwMDAwMDAwLi5hYTljMWQzM2JkYjkNCj4gPiAtLS0gL2Rldi9udWxsDQo+
ID4gKysrIGIvdGVzdHMvbG9vcC8wMTANCj4gPiBAQCAtMCwwICsxLDc1IEBADQo+ID4gKyMhL2Jp
bi9iYXNoDQo+ID4gKyMgU1BEWC1MaWNlbnNlLUlkZW50aWZpZXI6IEdQTC0zLjArDQo+ID4gKyMg
Q29weXJpZ2h0IChDKSAyMDI0LCBPcmFjbGUgYW5kL29yIGl0cyBhZmZpbGlhdGVzLg0KPiA+ICsj
DQo+ID4gKyMgVGVzdCB0byBkZXRlY3QgYSByYWNlIGJldHdlZW4gbG9vcCBkZXRhY2ggYW5kIGxv
b3Agb3BlbiB3aGljaA0KPiA+ICtjcmVhdGVzICMgc3RhbGUgbG9vcCBwYXJ0aXRpb25zIHdoZW4g
b25lIHByb2Nlc3Mgb3BlbnMgdGhlIGxvb3ANCj4gPiArcGFydGl0aW9uIGFuZCAjIGFub3RoZXIg
cHJvY2VzcyBkZXRhY2hlcyB0aGUgbG9vcCBkZXZpY2UgIyAuDQo+ID4gK3Rlc3RzL2xvb3AvcmMg
REVTQ1JJUFRJT049ImNoZWNrIHN0YWxlIGxvb3AgcGFydGl0aW9uIg0KPiA+ICtUSU1FRD0xDQo+
ID4gKw0KPiA+ICtyZXF1aXJlcygpIHsNCj4gPiArICAgICAgICBfaGF2ZV9wcm9ncmFtIHBhcnRl
ZA0KPiA+ICsgICAgICAgIF9oYXZlX3Byb2dyYW0gbWtmcy54ZnMNCj4gDQo+IG5pdDotDQo+IGRv
IHdlIG5lZWQgdG8gYWRkIGJsa2lkL3VkZXZhZG0gPyBpZiBub3QgaWdub3JlIHRoaXMgY29tbWVu
dCAuLg0KWWVzLCBibGtpZCBhbmQgdWRldmFkbSBjb21tYW5kcyBhcmUgbmVlZGVkLiBJbmNsdWRl
ZCB0aGVtDQo+IA0KPiA+ICt9DQo+ID4gKw0KPiA+ICtpbWFnZV9maWxlPSIkVE1QRElSL2xvb3BJ
bWciDQo+ID4gKw0KPiA+ICtjcmVhdGVfbG9vcCgpDQo+ID4gK3sNCj4gPiArICAgICAgICB3aGls
ZSB0cnVlDQo+ID4gKyAgICAgICAgZG8NCj4gPiArICAgICAgICAgICAgICAgIGxvb3BfZGV2aWNl
PSIkKGxvc2V0dXAgLVAgLWYgLS1zaG93ICIke2ltYWdlX2ZpbGV9IikiDQo+ID4gKyAgICAgICAg
ICAgICAgICBibGtpZCAvZGV2L2xvb3AwcDEgPj4gL2Rldi9udWxsIDI+JjENCj4gPiArICAgICAg
ICBkb25lDQo+ID4gK30NCj4gPiArDQo+ID4gK2RldGFjaF9sb29wKCkNCj4gPiArew0KPiA+ICsg
ICAgICAgIHdoaWxlIHRydWUNCj4gPiArICAgICAgICBkbw0KPiA+ICsgICAgICAgICAgICAgICAg
aWYgWyAtZSAvZGV2L2xvb3AwIF07IHRoZW4NCj4gPiArICAgICAgICAgICAgICAgICAgICAgICAg
bG9zZXR1cCAtZCAvZGV2L2xvb3AwID4gL2Rldi9udWxsIDI+JjENCj4gDQo+IG5pdDotDQo+IGRv
IHdlIHdhbnQgdG8gcmVjb3JkIHRoaXMgc29tZXdoZXJlIGZvciBkZWJ1Z2dpbmcgcHVycG9zZSBp
bnN0ZWFkIG9mDQo+IC9kZXYvbnVsbCA/DQpUaGlzIGlzIG5vdCBuZWVkZWQNCj4gDQo+ID4gKyAg
ICAgICAgICAgICAgICBmaQ0KPiA+ICsgICAgICAgIGRvbmUNCj4gPiArfQ0KPiA+ICsNCj4gPiAr
dGVzdCgpIHsNCj4gPiArCWVjaG8gIlJ1bm5pbmcgJHtURVNUX05BTUV9Ig0KPiA+ICsJbG9jYWwg
bG9vcF9kZXZpY2UNCj4gPiArDQo+ID4gKwl0cnVuY2F0ZSAtcyAxRyAiJHtpbWFnZV9maWxlfSIN
Cj4gPiArCXBhcnRlZCAtYSBub25lIC1zICIke2ltYWdlX2ZpbGV9IiBta2xhYmVsIGdwdA0KPiA+
ICsJbG9vcF9kZXZpY2U9IiQobG9zZXR1cCAtUCAtZiAtLXNob3cgIiR7aW1hZ2VfZmlsZX0iKSIN
Cj4gPiArCXBhcnRlZCAtYSBub25lIC1zICIke2xvb3BfZGV2aWNlfSIgbWtwYXJ0IHByaW1hcnkg
NjRzIDEwOTA1MXMNCj4gPiArDQo+ID4gKwl1ZGV2YWRtIHNldHRsZQ0KPiA+ICsgICAgICAgIGlm
IFsgISAtZSAiJHtsb29wX2RldmljZX0iIF07IHRoZW4NCj4gPiArCQlyZXR1cm4gMQ0KPiA+ICsg
ICAgICAgIGZpDQo+ID4gKw0KPiA+ICsgICAgICAgIG1rZnMueGZzIC1mICIke2xvb3BfZGV2aWNl
fXAxIiA+IC9kZXYvbnVsbCAyPiYxDQo+ID4gKw0KPiANCj4gc2FtZSBoZXJlIC4uLg0KTm90IG5l
ZWRlZCBhcyB3ZSBoYXZlIHN1ZmZpY2llbnQgc3BhY2UgZm9yIHhmcyBhbmQgd2UgYXJlIHVzaW5n
IGZvcmNlIG9wdGlvbiBhbHNvDQo+IA0KPiA+ICsgICAgICAgIGxvc2V0dXAgLWQgIiR7bG9vcF9k
ZXZpY2V9IiA+ICAvZGV2L251bGwgMj4mMQ0KPiA+ICsNCj4gDQo+IHNhbWUgaGVyZSAuLi4NCk5v
dCBuZWVkZWQNCj4gDQo+ID4gKyAgICAgICAgY3JlYXRlX2xvb3AgJg0KPiA+ICsJY3JlYXRlX3Bp
ZD0kIQ0KPiA+ICsgICAgICAgIGRldGFjaF9sb29wICYNCj4gPiArCWRldGFjaF9waWQ9JCENCj4g
PiArDQo+ID4gKwlzbGVlcCAiJHtUSU1FT1VUOi05MH0iDQo+ID4gKyAgICAgICAgew0KPiA+ICsg
ICAgICAgICAgICAgICAga2lsbCAtOSAkY3JlYXRlX3BpZA0KPiA+ICsJCWtpbGwgLTkgJGRldGFj
aF9waWQNCj4gPiArICAgICAgICAgICAgICAgIHdhaXQNCj4gPiArICAgICAgICAgICAgICAgIHNs
ZWVwIDENCj4gPiArICAgICAgICB9IDI+L2Rldi9udWxsDQo+ID4gKw0KPiA+ICsgICAgICAgIGxv
c2V0dXAgLUQgPiAvZGV2L251bGwgMj4mMQ0KPiANCj4gc2FtZSBoZXJlIC4uLg0KTm90IG5lZWRl
ZA0KPiANCj4gPiArCWlmIF9kbWVzZ19zaW5jZV90ZXN0X3N0YXJ0IHwgZ3JlcCAtcSAicGFydGl0
aW9uIHNjYW4gb2YgbG9vcDAgZmFpbGVkDQo+ID4gKyhyYz0tMTYpIjsgdGhlbg0KPiANCj4gZG8g
d2Ugd2FudCB0byBrZWVwIHRoZSBlcnJvciBtZXNzYWdlIHNob3J0IGFuZCBhY2hpZXZlIHNhbWUg
cmVzdWx0ID8NCj4ganVzdCBhIHRob3VnaHQgZmVlbCBmcmVlIHRvIGlnbm9yZSB0aGlzIGNvbW1l
bnTCoCAuLg0KS2VwdCB0aGlzIG1lc3NhZ2Ugc28gdGhhdCBpdHMgZW5vdWdoIHRvIGRpc3Rpbmd1
aXNoIHdpdGggb3RoZXIgbWVzc2FnZXMNCj4gDQo+ID4gKwkJZWNobyAiRmFpbCINCj4gPiArCWZp
DQo+ID4gKwllY2hvICJUZXN0IGNvbXBsZXRlIg0KPiA+ICt9DQo+ID4gZGlmZiAtLWdpdCBhL3Rl
c3RzL2xvb3AvMDEwLm91dCBiL3Rlc3RzL2xvb3AvMDEwLm91dCBuZXcgZmlsZSBtb2RlDQo+ID4g
MTAwNjQ0IGluZGV4IDAwMDAwMDAwMDAwMC4uNjRhNmFlZTAwYjhhDQo+ID4gLS0tIC9kZXYvbnVs
bA0KPiA+ICsrKyBiL3Rlc3RzL2xvb3AvMDEwLm91dA0KPiA+IEBAIC0wLDAgKzEsMiBAQA0KPiA+
ICtSdW5uaW5nIGxvb3AvMDEwDQo+ID4gK1Rlc3QgY29tcGxldGUNCj4gDQo+IGFwYXJ0IGZyb20g
Zm9ybWF0dGluZyBhbmQgbml0IGNvbW1lbnRzIGl0IGxvb2tzIGdvb2QgLi4uDQo+IA0KPiBSZXZp
ZXdlZC1ieTogQ2hhaXRhbnlhIEt1bGthcm5pIDxrY2hAbnZpZGlhLmNvbT4NCj4gDQo+IC1jaw0K
PiANCkFkZHJlc3NlZCBhbGwgdGhlIGNvbW1lbnRzIGFib3ZlLiBDYW4geW91IHBsZWFzZSBsZXQg
bWUga25vdyB0aGUgbmV4dCBzdGVwPw0KDQpSZWdhcmRzLA0KR3VsYW0gTW9oYW1lZC4NCg==
