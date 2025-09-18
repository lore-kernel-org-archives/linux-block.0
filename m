Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ABE62E41E
	for <linux-block@vger.kernel.org>; Thu, 18 Sep 2025 07:36:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758181017; cv=fail; b=Y1RrcqlWXYrNhEy0xvQXZEEM3nqe5zqbKbC+bYFTvuUSCdn7OHT3Ou0fXxm7GNcfX77kB1Kc7vFAO6l5WMO/mWUr5tUO5sKefvbTGvaeWFZd6Hc9m9/QLSHmmhLUcd4YesCWu5rLJBmxp/eKOFx6z4N3RMs+iAd1RG7NQB+k79k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758181017; c=relaxed/simple;
	bh=XEiHxyXAYn0t+jYiU4X3CjHuB7DIYyUJuKp2XmTHlqc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=hJjoZtZytQ0hc7CqorAkip5tid0kkNc92F+UaLGk3inKmD7IWYKvgb9yGi9gJnWII1Mt2VcmGjTpE77KMjRgx3FbiTOf6xZg0L8R9ce9qXpbl+abjFC0yeTq7AQ+fJPJUWhAV3FJTTbRgu0sjPUJ+slAjGExPVrPVMSnek8q7Mc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=OZQA3kQ+; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=SIY5oH5x; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="OZQA3kQ+";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="SIY5oH5x"
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58HN8pSc001843;
	Thu, 18 Sep 2025 07:36:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=F9l31p42pUIO0QxRzuxJIzTBM7vrUEfzq1EeanrohiI=; b=
	OZQA3kQ+yNPQtS8x2c6I8hq2L90RFeoSW667w7uSV390Wrh4IbkCtdpkwrld7WUX
	V4G69lz+D/JVyz2h9xxhqh+2o4RLwnETrvZeIG0p6eJzsAsgbU2iJAZWvMV2T7B5
	85dDo1QT4ijZx+V1DOPLk2HpTQokwgtLqO9LxbM9uwqJezApEs7hDwfOXXGoCTKq
	3qi70xlUuHL/NfmVfAhthvDb9APW1VTgKgK5GBchAdV34nTW+0TLaBjVN1onkRWj
	JbGaENu2eRFq1trg7AJnjijYiMtG/iDEJ84qyCk0nxM3oL0mo5RXgVbg3VEctLaj
	xWW2WCZZRGiTC7MZlRjKOg==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 497fxd2up9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 18 Sep 2025 07:36:54 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 58I6Qcql036779;
	Thu, 18 Sep 2025 07:36:53 GMT
Received: from ph0pr06cu001.outbound.protection.outlook.com (mail-westus3azon11011007.outbound.protection.outlook.com [40.107.208.7])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 494y2eswgr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 18 Sep 2025 07:36:53 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eTYbofXiJ9p21OP071/9wcaduzCNUAqQ+r+y1sGePrV5Jc09wjNqClL/cm3VBjTrIPBysZUlRSaYrmvpRyJzmBHy/4nw9uYiqN2MlqQm/SKp3KmsvM+pB0zZsb4fc577WgOi2c94yMrsppC3cisBVNU8qGVpr5v3zeaFaWbZPK0Qn7R3JBTC+KkFar+6qRKRAPzL/C2eAx2G9JYwUfFRRMYkYLNEyTzLyZkvNSOOD/fwDPr/PiPhFzNHMbekcd4wA5ueYSs2KIFkxLQOWMtqBoN96oMHyofGSyO0cn++boG73hKBJFBJK+1/gyFuWAiwO+P2KByER2/cZpeagCTLPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F9l31p42pUIO0QxRzuxJIzTBM7vrUEfzq1EeanrohiI=;
 b=NnHnjKvHN1WabUnS/vppnMdo5/+0Fb7Uuv7zX8OUIXNSxXtWvcpEWQjbr40nzyF3oNs7F52TZrmwb7RgUdZ2jl77U609kX3ouHOFQU/Ozmps9lI/c3OT+WCYBxTp8Z9gwV10XKDmV1ioJqB9/hR5x6LHyWNxn02x6P8T94OHD7VvS+uyYKwlvCdkrbnYtDKoVSRO2BxGsqkvebFoAHh5w1zUlFY4CIrQFCXttgD+r7buV3euHuz3Ik6joKWOFDptQkhNPf/anQZoFlAxx6c6wRctPww/8/euhRbjRFmYqWDtzgqs+8TL2Ez4zF+VHLrhDwOtXWAtO2UccSTWWpsQ6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F9l31p42pUIO0QxRzuxJIzTBM7vrUEfzq1EeanrohiI=;
 b=SIY5oH5xkZzN+vl11/psOI76iGtet/Kg7Kk1gpydkh7Li4Kqnf8iJEIwo7s8VAPkZrj497R+U44vUnbU1xGu61opskL/aAP2zl3q852LZbiyadbqd0ASGPs/Ki3JqSTcEBaiwBi4LOC/xsq42gQ6C79iu3jeV+aajOnbBbCG0E0=
Received: from MN2PR10MB4320.namprd10.prod.outlook.com (2603:10b6:208:1d5::16)
 by PH7PR10MB7720.namprd10.prod.outlook.com (2603:10b6:510:2fe::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.13; Thu, 18 Sep
 2025 07:36:45 +0000
Received: from MN2PR10MB4320.namprd10.prod.outlook.com
 ([fe80::42ec:1d58:8ba8:800c]) by MN2PR10MB4320.namprd10.prod.outlook.com
 ([fe80::42ec:1d58:8ba8:800c%5]) with mapi id 15.20.9137.012; Thu, 18 Sep 2025
 07:36:44 +0000
Message-ID: <524a89e8-a9bf-47f8-adf4-3f2432ef7d58@oracle.com>
Date: Thu, 18 Sep 2025 08:36:43 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH blktests 2/7] md/rc: add _md_atomics_test
To: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
References: <20250912095729.2281934-1-john.g.garry@oracle.com>
 <20250912095729.2281934-3-john.g.garry@oracle.com>
 <lraho55tl3vglno2cpcackn2s6fwirhbyzbtjj3tdwij4z7yav@ka6oyi2p4ohr>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <lraho55tl3vglno2cpcackn2s6fwirhbyzbtjj3tdwij4z7yav@ka6oyi2p4ohr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0099.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:191::14) To MN2PR10MB4320.namprd10.prod.outlook.com
 (2603:10b6:208:1d5::16)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR10MB4320:EE_|PH7PR10MB7720:EE_
X-MS-Office365-Filtering-Correlation-Id: 8b9328e7-6fd0-490b-31fd-08ddf6861e05
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?a1hNUm1IZjVNYzV2TDVSTWd0OXZESDJHdFNza2Y0TDY3aGtxQ2hHZTMxU2hn?=
 =?utf-8?B?U3FtaDUxY1A2dEhTM0ZUY2FTcUxLUEpHV2VLbzZEMlZEMzRyOENmNlNmVTBo?=
 =?utf-8?B?NEgyNytUMjZLc3MzZ21OcklvUlg3Q1g4THFtckZFRXpSaVBsMUEyUEM4L2Fa?=
 =?utf-8?B?ZE4rZ2FSVzdMQ2tJWWZ6cGExUUNVdUM4a0E4ejhrdGpCZFZlRURoMm82SGps?=
 =?utf-8?B?YjBGc2V1Njl6M0lpM2QwZXYrY3gwUWhFSWM3YjRTSjh2YmpKZ0JhM2doUE9R?=
 =?utf-8?B?YXBsL0ZkbzFQaW5ON2RQbGZFNWhRdE1Rc3VEajRhM3p5Mld6dE4yZlVvcCtz?=
 =?utf-8?B?QTJITmZ4QWQ1NEVrZ3QxTVlCUGRrT0VIVmhoZnhRVGQvYW5mZFJNUnAza2x4?=
 =?utf-8?B?M1lqNktOb09jWklDLzR2VlpqZndKS2tabXZBL0VJMUw5anNuaXVDQ1VDbGhh?=
 =?utf-8?B?VE9LZno0Qmo4QkROK3lQOFB5eEFzRXRFVVZpWWpBOHV0UkxwcXR0QmhqdWs5?=
 =?utf-8?B?L2M2ZHRIVjNHWld0c0U4QTBheVpwMWJ5OXhJZGh0aGNCeDNxL3pyUjdQZmUw?=
 =?utf-8?B?NHlVQ3J4ZG41cFM5T1U5dU1meFFINGZZSkpsSWZmcDJtdFpIN0g5KzU1WXpX?=
 =?utf-8?B?cWZMWXI3Y3dkdkFnZHhmNlhyb3ArMXkrOFhpSWdzU1o4ekFwa0YxbXZWQkJC?=
 =?utf-8?B?OVlNQ1VlZU9hUkUzMU9ZSnJMSG5wQmhHSjc3VHlrWlV6cExGWlV1cDB6Ylpr?=
 =?utf-8?B?V0pXMXpBSkhrZHRPSFBvWFRDVXREREIwUWZlZGVva2JEVHZOc0hGaGcya09H?=
 =?utf-8?B?b09EanNtcTBEaEJySm1aZFRwaTd5NU9qTUwySytFVmFxK01IWmFPWERVNDlj?=
 =?utf-8?B?R0lRS0RSalI0dUVlQ24zNjg4Zm1YT1BYcHo0QnF4UWFIUkZlRy9MVFFkaTNx?=
 =?utf-8?B?MHRMNUhqL3NRaVNSNWcvUU1ZeTZUbzhPeUovdWV1bUxoa1M4dEtJRFM5MURD?=
 =?utf-8?B?VDhNVzZVMzZ6V2x1Ym90bzZMUHNnb2Z5b0dpVDRWUE1TT3VNVjI4MXFhSFAx?=
 =?utf-8?B?dHRITmxpUnUwQkRsT0VYTUZrVW1tekMzRW5jQjJiY2wyL3VGTmpmSll5OW5k?=
 =?utf-8?B?T1daeE9SUU42RyszTVp5d0toT1N4WTNtYVpMbUlabjFjdllUVUtEeDBYNks4?=
 =?utf-8?B?RTlBbUJKcnNqUHFFYUM1ZnhOM2wxajh3VEFHakNnU1ZQNkgrdm1ybEk4Wi9p?=
 =?utf-8?B?czBDbCs5OWZ3Q0tueWxQNkVOdFJJMkFTMnhvdTl6L2RVN3BwY3VMSFd4Q2RM?=
 =?utf-8?B?bzZCUERZYStJWWc3TGVQdmRzMlNZRVMwWklqWUZLVkFJeElWYktSa1pWalZX?=
 =?utf-8?B?TmlYWVUzRFcxR2NVOGxSNWdpMkJLZ1FzQVQva1F0Q0kzSWJpWENuekgvWXha?=
 =?utf-8?B?bm1BaHQzRGZ5bCtBUWRaM1hueXJoUGFYSDdrWjFZeGhtdW12TU1xRW8xTUpW?=
 =?utf-8?B?dnJCdm1JeVBoZVZsOCtwNFhOSFlPQXRrTUNXdjhxN3M3K1lyQXBacjRwR2hw?=
 =?utf-8?B?aUtvY0NMdGlFb0VDaDVZZjl1emtqc1k2eGpzcG1YQ3NVQ24wdjVYMlBlWi9V?=
 =?utf-8?B?Vkp5d29KMTZubmhRZ0dxWFRqeUErdENOMys2ZDcvanRaYUM4VmZ0NkNES0Vz?=
 =?utf-8?B?SFRFWHgvNW1nWEh5QkNKMVRhWnMzMlVsL20rL00zNjk4WWs0S0Z1Q0NiMlFn?=
 =?utf-8?B?emxKOVFTWWNvaFRNU29WUHVYQlBXUUREVFdyR3RqQnZ3L3JtSUJna3ZHTHZs?=
 =?utf-8?B?b1hDeG05WkJOSVU0WFZCWHdML05OaHhhYnI1ZGttRjAxQ3RtbllLUlNBVG5U?=
 =?utf-8?B?b1pyNmU5K1o3Vk1tUUpFbkd4a09ZN0VNZEVNcGxIbUF6OTRvbzFhc1hxQ3Ay?=
 =?utf-8?Q?KZrBSWE26aY=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4320.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UlNNSmxxMlJpcE84dlVBVlJkSE5Ndm4yYWhKdGI0a29zQTJUZVpCY1krN200?=
 =?utf-8?B?bThtb0pFd2ZiQUNqWnhNMUtxL05HWHZPWHRDZTVQZmVXbU1HUitiTXRGcWl0?=
 =?utf-8?B?SWpOMkc4VGcxcFl3bkxCRFk1c0ZBKzY3aXZvK2M3UXI3cFhxMmdVSGdDVXJ5?=
 =?utf-8?B?TWVjTk5YOFpqeGc4ak9ydVlwOHdUazNJVWJWd3QrVVkxaXVtbW9PbURjdGph?=
 =?utf-8?B?dC93anhCbmQyVGJjemY2dFVpcTdnOWQzb3hHbThOMGlDa1RIcDNrQ1NzdkJN?=
 =?utf-8?B?U0J3dmxHcjQwRk1yL2ZFMWh6ZnNIWXhRVVhGT05haWpCU2ZoUHc0N1BTeDJU?=
 =?utf-8?B?eVMwRHozMCtScG8rYktIdFEvZ1AxVFAxYjhpS1pyaUtwZ2RveDJhMC9UWDV5?=
 =?utf-8?B?YnMxWWg5dWdCU0haV2NyTUl4RXl2QlR3T0dpbmVZcXhGTithK214L3pVanNR?=
 =?utf-8?B?RUhHdDRMdGdGbk1Ea2tUN0xWTjM5RFBMdW5jQzRML2JJVTl6WnA5ZDBnUFRX?=
 =?utf-8?B?SEVuRjRSNUtXdmZMWGVSNUhuaW9rZGJFVThqMmloakJwRDkvdS9vREt3c09X?=
 =?utf-8?B?VFEwOW4wZURldzI3VTdWQnQrZ2JzSkY4UWpwNS8reXY3WWFsOVMxaTJFUGw0?=
 =?utf-8?B?ZEpieWxnVC9YblJ0MStyRVlxb0tFcVREVU1xK0tnSnpKYjJHd2Q0ZXJ3WUlQ?=
 =?utf-8?B?TjMxN2plVDBrWm02T1VKeXp2aEQyUmdmMmx5Nzd2aWtaNHJTa3Z6ZHJxTlBU?=
 =?utf-8?B?T3NLRkFJL0psUEgrZ2dBbVhWWU5EZFBRRXBhMTdDSHlrbk5vTTR3MmhBc3Ja?=
 =?utf-8?B?Q3B0cW9ZRzZJT3M5OS8vUWM3VUdOUzA1RjVYYW1FTmtiNnRTQmMzSmR4c1RZ?=
 =?utf-8?B?RDVwakdvb2JOUmdlWHpTeVZMa0k4VnpmMlJlRndHRFhUMXBuL3FVMVFBNlZh?=
 =?utf-8?B?S2RKdFdtN1lWUkk0L2tjbmJhQTVzRm8ydUdkYXFiU0FEM2RiK2E5RlNnWGdu?=
 =?utf-8?B?Z2Y1cFVHc3l1TmtQTFFUUitMUDFyTnYydEpKdFh5YTdPdnJ3b05YZlFZbXVz?=
 =?utf-8?B?MDlUdDFraEszL1JxemFZTTZDM29Oa3hwUkNRdjJEckROclRHUHZLSStJbzZ1?=
 =?utf-8?B?QlZBNDd4Y2dMMG94MUw3Q2ZDT1ZjTkhzYVRzWG5NZmMyNGw0VVRnWnRQTmFz?=
 =?utf-8?B?V0JySHJQOXpTK2hvaWNaR2RnR0h6WEFMaTZUajF4ZUU3WjZRZ3R6NTV0QnpI?=
 =?utf-8?B?d0FLcitvOFp6Ly8wSnlLM2pKRWpZaXZYUlhCejh1Z053Z3ZMLzdlMzErL0ZX?=
 =?utf-8?B?bWlLUkwzTk8zUzM3cGpQbHF2WlBuMU9xdkZER1JHck9DOHNkRmt5QUZMRGQx?=
 =?utf-8?B?SGRZTTBKK0crSUU4UytVRi9aUjBRaW5HS3ROVmw3WHA5TFcyZGxVbjNNOU5S?=
 =?utf-8?B?aUZWOXFyVWtpNDZmZDNnM2l6dzVyUVZwaC9JMDVwUWp4MjcyY3NLNnhwejJn?=
 =?utf-8?B?TDdCWU1BUVZiUUwycmhCMjlFY3NmMkt3M3dpKzY0Y3Azc0FFbjYvSGtTbHhk?=
 =?utf-8?B?Tk1veTEzMTVHd05Yb2RUcTNFcFY1bnRiTjQ3UXJySHphSm51bDA2M3lTWmhr?=
 =?utf-8?B?NmJBUW9lQlU2ZnJjV0l3NUUrNm1mcUtNVVgvNGhiR2x0b3diRHZMdU9idnZB?=
 =?utf-8?B?aFFPWVJWQ29FeDRQbndUL0VHUEtsZmh3bHJFdE85MWxMbm1OREdJNS9BK3p4?=
 =?utf-8?B?aWNNUkYycVB1ZHZIY0lxbXFlempkLzBCVWhGdERjRFRzZVYrSStud0ppV3d5?=
 =?utf-8?B?MWlyOGFJb2hPOTZSVUg0MEVMVFk4TXZDNFNYRDZOZ1hZdHJOdkU2bEYzSWtP?=
 =?utf-8?B?MlVtMklkbVpBUHRreFlYWFpEQ0hWY0FFbXlabDgvSDR1MCtEcHlENFV1QURw?=
 =?utf-8?B?cHZSRWNsWndhSnVsK0NiVWU1bXZNdjVlR1E1cWw1T3BXajhZTVJRR2VmWWt4?=
 =?utf-8?B?SXk1bGJtMk9qNjJpRVI5TWNkc0ZuZmwyb1cwbHg1ODFER2Jid3VoZzdXVFFD?=
 =?utf-8?B?V015cEx6b0NndEF5czF0KzhKZlJqYld0VjlQdGJKYnZrK1R3bndQS0luOENU?=
 =?utf-8?Q?cj4HG8SyxvlpB4EJXM1Bm8ouK?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Q7FzouGmANOkPrU9CRUwIRT9EbG4kXoQUFJZ6zrkxEgj2LXQTC89FI6E2dhryC8bFkRPoZcHQ7TZruHAUnHAfRTiL0sqltAM9jvIu/8N5AZQYV1hOmQrLm9hoDNak3ZFk2hPaosnre2u5PGwgBiZOD6Pd2ObKFmiconsr6uQKMOdYLvL+acOjTBcRMmHXhqEc16UVnVeY4qryiJiUfG9KXV+N8ZrM2hbxbj8nuCofbpMm/biMnHocqDlbQCAQA1ncWHrOMM9YkWkueOx54l2wXIItywwk6R4j+ySXE3iQfdvWb8eYCy4iGVj8NY9G3LB4n/MsAW4V/nb2Fu+1KThryrbZLmb5c6B+Po6SR3vVFiWlk9DDjZB0qg837UU7Ayq4C6TnYaGn0RrLAdXweuX96Ry18TQasmUH6VlkA6iVEJeMR7tB2VfbbNC94J57LaJsIGHphhX0bUmghSLFEq5Q4sCw21OdCUtAW8kO2Q9LyRnQXVl7nBObKH7qPc5tYP4P4/61F9vE3gPw+vCcBFzXfqP6v+uRJlVcCdGfUMmHrkTqVJOWVJOhZbBlMHDPg6eojC0h+mrAvNTlO8+7V/23m7gCDdKgc+bBIkJXlC6aZE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b9328e7-6fd0-490b-31fd-08ddf6861e05
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4320.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2025 07:36:44.8099
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qJX5wyJUiXPCh8vRZdRE7DtqhUvPZMGjVH58COVv5ak16SPSLS0MQwdP+iXv5WUFOCCXwpGCGPAm8aIclSv2Tg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB7720
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-17_01,2025-09-18_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 spamscore=0
 adultscore=0 suspectscore=0 malwarescore=0 mlxlogscore=999 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2508110000
 definitions=main-2509180068
X-Proofpoint-GUID: cZxMG7AK-2-T358UXLnO44AnwTJpLnS4
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTE2MDIwMiBTYWx0ZWRfXzS7Er3v1gcK+
 NUs0oB86oNWdf2PhHAZbC4tjVn/uK+TBLw5rWukW9mc0/45J9N4TpbKU91L1f9rlDF0CEHr16eZ
 OzFdteZM6sybONr4b+6Aa/fXV4gY17qnGlDRmEqSVoKELgoiBl9lWY9FeMuSmI42lBa/mkrVQDL
 f/eiPnhfvDe6WqNHKxcBHmRGfDsEqVFh07dnME4ubwxAMTE/UZcU+KgEt1rsNJE7ka3qrTzqLyt
 JdZB5wgFNJkucU3SaDp/R7yGdKHEYxsFkO/wXad6rQCOQZKvJigj/PdtrVBh8+R2Ewq9yZJU1mP
 j7HUSqRLHQToDeqTx137+JtpizP0zCLnMSX+h4u1eWeYplvyiTAAHLnDhpFdm77avD5oY4Yxunu
 /7bG2UYCerec8t48r59CX9234PSKCg==
X-Authority-Analysis: v=2.4 cv=cerSrmDM c=1 sm=1 tr=0 ts=68cbb696 b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=yJojWOMRYYMA:10 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=TzCtBQM6BojMMLDU-34A:9
 a=QEXdDO2ut3YA:10 cc=ntf awl=host:12084
X-Proofpoint-ORIG-GUID: cZxMG7AK-2-T358UXLnO44AnwTJpLnS4

On 18/09/2025 05:17, Shinichiro Kawasaki wrote:
> On Sep 12, 2025 / 09:57, John Garry wrote:
>> The stacked device atomic writes testing is currently limited.
>>
>> md/002 currently only tests scsi_debug. SCSI does not support atomic
>> boundaries, so it would be nice to test NVMe (which does support them).
>>
>> Furthermore, the testing in md/002 for chunk boundaries is very limited,
>> in that we test once one boundary value. Indeed, for RAID0 and RAID10, a
>> boundary should always be set for testing.
>>
>> Finally, md/002 only tests md RAID0/1/10. In future we will also want to
>> test the following stacked device personalities which support atomic
>> writes:
>> - md-linear (being upstreamed)
>> - dm-linear
>> - dm-stripe
>> - dm-mirror
>>
>> To solve all those problems, add a generic test handler,
>> _md_atomics_test(). This can be extended for more extensive testing.
>>
>> This test handler will accept a group of devices and test as follows:
>> a. calculate expected atomic write limits based on device limits
>> b. Take results from a., and refine expected limits based on any chunk
>>     size
>> c. loop through creating a stacked device for different chunk size. We loop
>>     once for any personality which does not have a chunk size, e.g. RAID1
>> d. test sysfs and statx limits vs what is calculated in a. and b.
>> e. test RWF_ATOMIC is accepted or rejected as expected
>>
>> Steps c, d, and e are really same as md/002.
>>
>> Signed-off-by: John Garry <john.g.garry@oracle.com>
>> ---
>>   tests/md/rc | 372 ++++++++++++++++++++++++++++++++++++++++++++++++++++
>>   1 file changed, 372 insertions(+)
>>
>> diff --git a/tests/md/rc b/tests/md/rc
>> index 96bcd97..105d283 100644
>> --- a/tests/md/rc
>> +++ b/tests/md/rc
>> @@ -5,9 +5,381 @@
>>   # Tests for md raid
>>   
>>   . common/rc
>> +. common/xfs
>>   
>>   group_requires() {
>> +	_have_kver 6 14 0
>>   	_have_root
>>   	_have_program mdadm
>> +	_have_xfs_io_atomic_write
> 
> I don't think either "_have_kver 6 14 0" or "_have_xfs_io_atomic_write" is
> required for md/001. I suggest to introduce a new helper,
> 
>   _stacked_atomic_test_requires() {
>       _have_kver 6 14 0
>       _have_xfs_io_atomic_write
>   }
> 
> and call it from requires() of md/002 and md/003.

ok, fine

> 
>> +	_have_driver raid0
>> +	_have_driver raid1
>> +	_have_driver raid10
>>   	_have_driver md-mod
>>   }
>> +
>> +declare -A MD_DEVICES
>> +
>> +_max_pow_of_two_factor() {
>> +	part1=$1
>> +	part2=-$1
>> +	retval=$(($part1 & $part2))
> 
> Nit: "local" declarations are missing for part1, part2 and retval.
> Same comment for some other local variables introduced by this patch.
> 

ok, will fix

>> +	echo "$retval"
>> +}
>> +
>> +# Find max atomic size given a boundary and chunk size
>> +# @unit is set if we want atomic write "unit" size, i.e power-of-2
>> +# @chunk must be > 0
>> +_md_atomics_boundaries_max() {
>> +	boundary=$1
>> +	chunk=$2
>> +	unit=$3
>> +
>> +	if [ "$boundary" -eq 0 ]
>> +	then
>> +		if [ "$unit" -eq 1 ]
>> +		then
>> +			retval=$(_max_pow_of_two_factor $chunk)
>> +			echo "$retval"
>> +			return 1
>> +		fi
>> +
>> +		echo "$chunk"
>> +		return 1
> 
> When bash functions return non-zero value, it implies the functions failed.
> When this function returns 1 at the line above, does it indicate failure?
> It looks echoing back a good number, so I guess just "return" is more
> appropriate. Same comment for other "return 1" in this function.

this function should not fail, so I will just use "return"

> 
>> +	fi
>> +
>> +	# boundary is always a power-of-2
>> +	if [ "$boundary" -eq "$chunk" ]
>> +	then
>> +		echo "$boundary"
>> +		return 1
>> +	fi
>> +
>> +	if [ "$boundary" -gt "$chunk" ]
>> +	then
>> +		if (( $boundary % $chunk == 0))
>> +		then
>> +			if [ "$unit" -eq 1 ]
>> +			then
>> +				retval=$(_max_pow_of_two_factor $chunk)
>> +				echo "$retval"
>> +				return 1
>> +			fi
>> +			echo "$chunk"
>> +			return 1
>> +		fi
>> +		echo "0"
>> +		return 1
>> +	fi
>> +
>> +	if (( $chunk % $boundary == 0))
>> +	then
>> +		echo "$boundary"
>> +		return 1
>> +	fi
>> +
>> +	echo "0"
>> +}

Thanks,
John
