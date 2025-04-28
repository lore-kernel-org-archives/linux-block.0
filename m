Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6D0E13D8A4;
	Mon, 28 Apr 2025 08:24:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745828670; cv=fail; b=o9gjW1+UoLI5m7NstoaLmy0gs8/E6yYRwbO4glOf2+YoMmOzBw7maIkTZ4rNCpYTik0yx2k3SKp2mgY7I4uowzcHwhJNihXN9bCsE/bheZJm5684LqflOXmeHFyi5Dkk+8euraJQMlnJAVtCI+puu4/LoqzndM4DYXZ06UIRbUM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745828670; c=relaxed/simple;
	bh=SLmn5Y8gsEx9ksDtEi7uxr3xtUbXwLm6RozKlXXKvxc=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=g2eXRAiOJL2N0VXG0Igtz9hwLb7bK1I1TGkYWmJiaF4EZN0ovuVPq5JBihH38nAls5Uybj9bX1D65eoVwggR9WUKjgIbba6DsM+g+bJh+dfgeRqKf96ZoyPCvKQjGMEqXnvBH749PtU8AmdMng2iN3j+ZvoBd47wij6cpePBhpk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=TBA+LAy0; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Uy+5OUbd; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="TBA+LAy0";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Uy+5OUbd"
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53S8N6NH007789;
	Mon, 28 Apr 2025 08:24:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=pGEUXq47qWzvT14J06W79yYWtjm4fs3ZH5GfvnugldU=; b=
	TBA+LAy054Gt94K9BG7OTZPUWZC4hNKHMexSNuoJt8L3efjGBbhEQ/VFS5wulC61
	b2hE4OEfHIC1qtBMnE4CufhY4SPWwofriSdGTC8xhlk5XxaHcACRU63NhOwazXDY
	dsms52IbE4gPOzJhU0kg5yoxWIWgtnoUWvSCjadfPbKUOy34+baIOBB4LtdJF3EE
	Wf1ARlhL9OW6umn9sLcg3qmQuhvZVyzgatFVrAIxbWPyZkBqbN9WA9WUhexulS6n
	I5Hj/hfX4X16lg5QWQ2uNaUpsXTxv6E8ElBaay5AUo7WnX5bSTxgPvyPR4+WBv/g
	Xrdy8gz7jx3SUszr9YxaCg==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46a642r04p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 28 Apr 2025 08:24:24 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 53S6oRpf025907;
	Mon, 28 Apr 2025 08:24:24 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2168.outbound.protection.outlook.com [104.47.59.168])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 468nxebtwx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 28 Apr 2025 08:24:24 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TsFsOXPMa0ADXVdqHol5itBAtYfliKSZnEE93smmtwZhppUeWvhyeGcrLcAJCVmVdlMN5nF10kwl3DxFz/FoonnSYp0Xa3mosQ4di1/623phot/ZTERHk0eDZVMWZ2p1mWW1ZWSk64iB/OXs5CJ1w7O+VeduTUzDZiR3Gn+oDr1MHHAFE/YooQz4PPlpkxP8piJjgw6RrnZQfUr58EWAlrszZ59b0lVAehmmAeRKyepl+Gu0NpE76L/r2t26HR7Ouy49hsWI3btn7DaXnZteX1vVlR+yB2cNRE5tcSz3kRs8WjGDxGPYQCDTqWAyvJCuMKdsivJJgUzxx2GNJxYzAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pGEUXq47qWzvT14J06W79yYWtjm4fs3ZH5GfvnugldU=;
 b=e4+SniO60jMospEVIQv0XYzrSWA+LZpeyDX6elm8OmTUp6oMY5a/yDo60Kfw81JzgjVFAH3R4Tor/9aEneCL4tt1OaxM+9l0j6bQuFLHzdPF5TynSxj/LFckYH8fvbfhuwnxp59BvXo23d9cASLZ21/DaOksvBKfFPXJSMiOMseRv3g5Ta5GLvADMPlMGGtHvYkExdTRziwop3oPJqHuikbvAI7inAasHy8zVeKs8QhCH4513aFiLWcenOcqnMIpkT6cyX8UWuSM1Z/iyyyU2w4JvVsqPUpMDugtt5YiHvaVu3pIdf+4I02S6YXcT1q536RdoNQQlLJlFvN9/Ze2RA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pGEUXq47qWzvT14J06W79yYWtjm4fs3ZH5GfvnugldU=;
 b=Uy+5OUbdE1Uw2JmtEasDo3Lhg2xlLNfOi9G1Vxes7PFBfMPWtqIH8FGSfbvGGRzD7s+McXTRshuVrKr8hRW+ycJ1sYb3JdIwT+p1rCkHVPQ4lgJ9UI0/EtLC3qCImSw+OiuzlrcOXAj5pzooNqs4cXljejP0QdqXwaHLVOGFlpw=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by BLAPR10MB5026.namprd10.prod.outlook.com (2603:10b6:208:322::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.41; Mon, 28 Apr
 2025 08:24:18 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%4]) with mapi id 15.20.8678.028; Mon, 28 Apr 2025
 08:24:18 +0000
Message-ID: <492ab2dc-d062-4dc5-8d48-4e357ea4adbf@oracle.com>
Date: Mon, 28 Apr 2025 09:24:14 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] block: rnbd: add .release to rnbd_dev_ktype
To: Jens Axboe <axboe@kernel.dk>, Salah Triki <salah.triki@gmail.com>,
        "Md. Haris Iqbal" <haris.iqbal@ionos.com>,
        Jack Wang <jinpu.wang@ionos.com>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <aA5Rzse_xM5JWjgg@pc>
 <fb3add67-c469-483e-ac51-e53dea7df360@kernel.dk>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <fb3add67-c469-483e-ac51-e53dea7df360@kernel.dk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P265CA0129.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2c6::20) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|BLAPR10MB5026:EE_
X-MS-Office365-Filtering-Correlation-Id: 295f2377-0dfe-43ef-ff71-08dd862e11bb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZFFmWFF1bmpxblo5a0VVSGV4ZE8rMTRnVTI1M1RjbXNrWG9NOGFXbDdLbm5W?=
 =?utf-8?B?ZE5lWVlFbERJOFdsblBiOHBnRHZaWW1SazNHdkNoRUxPSG40YS9TR0xGdGx4?=
 =?utf-8?B?VzVSd2R2Q3hLVlVIakFyK2RCMHIvdnBER0dabnNWSkljc0duQW9sNUFmMThW?=
 =?utf-8?B?c1JNQmd1cS8xaTNZbGg3SnZFM1pWeXhqcTB1WmUva1pnVWExb09Ob294NUNk?=
 =?utf-8?B?bDdlaHFHTkkvMEpjMlliNkxkdnJ1ektNZGlDdkhuK01kNHY0UEV5QnZEQ2d4?=
 =?utf-8?B?cnFpR1JsZkVBRklrZFowY01NMjFKZ1doT2dLYnNsUFdHUWpycTdkZmkxek5E?=
 =?utf-8?B?ZTdNazh5Q1JEbmN2V2NjMWlkdHI3YS90U0l0dFhhQlo1WHgrYjcwYWdIWkZF?=
 =?utf-8?B?MUptL3QyWWtsZ1FmT2NsOFFHQXR0K1diS3VVZW1YdEhJVlIzTk1CYVhBblZX?=
 =?utf-8?B?ZlRuMGEzTUhIWTNwN1F2SW9yMHpJcWpvc2lQTXFkbldzSnFBbnZ2YlBIbURx?=
 =?utf-8?B?Zk1SR0g5ZFVWYVRTOU1hMzNPZTk2cmlNTkJsQThVV3c1Q2l3aGZlaThPYitJ?=
 =?utf-8?B?c3dFc3Zydm1ZcmdRSzU0aS9GeHlGbno4VkY0QWhjRFNVbmw3QzA5QVlyUXFz?=
 =?utf-8?B?eWw1MVR5SXhINFdJN0FSME9kNGxHRkQyTXhTS3VONGl1a3Q4S1ZzTHJHeC9M?=
 =?utf-8?B?TXhXTzF1OS9Id1Fqeit6R3ZFdU01aGYzVlhzcXpBMnl0SzdqbmpJQVRZTkdG?=
 =?utf-8?B?NE9NZCtxUHNSa2djOWxyczhPY2V3VXU2Sy9vN05lQWlXeGpmSHlMQUNnTWdC?=
 =?utf-8?B?OGVGTTNDRGZUNTlwSkNJVHNEUXBDYm0zQVZBV0lYY0VhcFROb0Q4a0tyVWVL?=
 =?utf-8?B?MDZFWGR3M3dVNUh5YkEzb2hDRHVtQUNhT29EQUJNSU5DdUZURzBWY2ZOTEd5?=
 =?utf-8?B?WnZIYlJ4VzIyNDBmQ1dLVTZidWp3b082ZkxhM0Q0UUJDdFBpdDRHRjdodzNn?=
 =?utf-8?B?b3ZuTWtQRTVDNm1wOEFKazJPbzMwT211c2tCQm5UL1ZXS3I0bjFiQVp4YW5t?=
 =?utf-8?B?Y3Vzb2JKSkV5NENNSEJLbnNHbW04UDdiZis4YlFRN2ZJb1RaU1ZqRjhLVWlj?=
 =?utf-8?B?TjNEbnBFRWxDdWtJNjc5NXl3dlp6SytRa2M4bW8zWE9lMHNGdGs1Z29ncjNW?=
 =?utf-8?B?a1k2VWdSWkNEZGhrU0JXMHhtNlhXNDQ5RitWcFVDUnhhUVJvaGIwdk9YbTN6?=
 =?utf-8?B?Z28zZlovRTNKOE5pNXdFZmlSeWE3cmNNcUxiSTRkSUZsNEZXcVd1ZGxrYldv?=
 =?utf-8?B?Q1RwMmpLcHV6ZStNaU9FTStoNjducXVSQ1lDeVlvR0tNSjIrbGsvQStHNG11?=
 =?utf-8?B?S28wVzY4bmJNWTN4M2xldEFsYW1hVklWTFQ0RTV6WlNlRGx4R0lmbHVkK3Nl?=
 =?utf-8?B?ejRlaWlvd3RLRUY1TTc5bFk5aTB2YXpDZEo1S2duYXFEM2F1OTg3bEhiUmg1?=
 =?utf-8?B?emthTGs0bnk0M05xS2NEZEhkSHFxRWFZQXd5SVJCLy9qRmtnb0xyNFZYU0FQ?=
 =?utf-8?B?aDgvTHRiTDl6di8yMURkZWdNeVJZMGVDSTRJelk2NlhXdmlndDROYWh2Uzht?=
 =?utf-8?B?Q24xNXVsYUVEUGJaYnFXZHpaTXhYaVN4UWNOMHBwS2FCR3o5Vi9qWWxHRUd4?=
 =?utf-8?B?ZGVlQjdaOXFTRm8vN2plNlJhSHNac3Fjdm9HQ1EwWTZETitiM09RZVJTa201?=
 =?utf-8?B?dEZJc29MQVRCdTltRFlGUzJ1Zmw4R2JFYVlGeFRQeEVrVGhuWEpkUlk0Qzd1?=
 =?utf-8?B?Z3NGaVlIRDR0NU1Uc3BkVTM5eVZCUXMxOHYxdHMyQnFVbWJDZWQxZUtBYXBs?=
 =?utf-8?B?YVNleUlHWHVrRWNIRjVqdWdzUjV2RHJLU1ZVSW5scnJOUmk1TTM3aksvcnVT?=
 =?utf-8?Q?MZVXS+LBKrE=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Mkk5UE5lR25Fakw1bWl6WFlkMUtNdWlpTlhmN1Izc1dUb2hEQi96WnZQZjVl?=
 =?utf-8?B?a2U0SzdNUDdaSkVKVFcrZ3pxVkFneXlvdHN4Z25JbXBiVjdZUHo0UWI3TFlv?=
 =?utf-8?B?NXdRNFQwVnNLdUtvL2NxTGxINEdPTmViLzVaK05HbE9wSkxwYnFvTU5jaERz?=
 =?utf-8?B?QS9kb2diLzBzcVRtTmhaWXM1S1BaMnU0MkZiNXJGYjJqcys5R21lWTlPQWcw?=
 =?utf-8?B?UGMxTWVhZC9hRWlhK1dCNGllWjViZ2RXN1ZXcEQ1TzBKdURzN1gzeEtqK0Ns?=
 =?utf-8?B?TTdUa3d4YWsxS1Y1VmE3RDNzUVRyMTJDNTBpWUVMSVhPbURZcTZWWkR3UnZH?=
 =?utf-8?B?WmhlWU02N1FscTdTUlI5UzFiLzJhNThRclJ3Y3lOZEtxdnNFOFNTRUZ1Z0Vj?=
 =?utf-8?B?U3ZPV0dETXkrUURUak53czRIa3VhQXBsdXhPc1FOdXZvOG9Qc0FCZFN5UnZt?=
 =?utf-8?B?dERWVHhuSDVSbG9CekpZaFNSNkFUaTViQUNGV2VtdlFxK1lmbUxUZGl6d0ZK?=
 =?utf-8?B?LzUrWXNWaXpUVVlESnFtWVN3TnVYVzVjZGlpN2ovOW85YU1Cekx6NmF3OEtW?=
 =?utf-8?B?azMrZm83QTAyZXA5ZzFuZmpBZ2V6UVEyZWYvVlVMUE5kZFJ4QVlVVm1jazlz?=
 =?utf-8?B?K2laanBGVlgwbSsyR09nZ2lHdFBXZ1ExTzRBdUhQYTBSSGVyczdtMFlCQmtR?=
 =?utf-8?B?OGNwVklCYkhHZktyNHYvNWlDdkRITkhOMUJGNXpaMjJUN0QvSnJxWWFtajdC?=
 =?utf-8?B?RnJtazhUcVZCQ1ZNMFJJRkt1WHMzNmRVY0I5MmJ0aUxyUHZFbWxBMzE3Z1BF?=
 =?utf-8?B?S2RhcEpxRE90eEUvZU9udjJ2NUtjMW53Mnd5OTU2T25ieVFwOUJPLzlJdUVj?=
 =?utf-8?B?a1pYcThGb280amhuMDZPUGZHY091RjhRZEJOK2ZpY05hYWlOMU1PbWF3T3Ex?=
 =?utf-8?B?YWNJT0dyUFdwM25MNWsxTUdwUkhFeERITUNSdHpWdkFKbVdVenRTSjZqMkF4?=
 =?utf-8?B?bU5PZCtXZi9IRFlvbm1hNEFGSWVrZkpDTUdHZjJMTlV6SExqKzMvVHdJQUsy?=
 =?utf-8?B?cUpNSkhBUTFxWlcxRUhENytBV2k5WjNDUmZpL3dkR1JpRTM0Z1ZoQnp0Z0xr?=
 =?utf-8?B?M0tqTE8rMHFpdElEMW9yYVRrcFNYL1ByeWJUS3Y1UkZ0YWlNUStvV1o5Tkpo?=
 =?utf-8?B?M3BrU1VpQjg5UXBMQmRpRUZTY0lFU2QwSHQzTkplSGpzekYyL0ZvUU55THps?=
 =?utf-8?B?T2dQM2NjbDhEQ0hOdUpuV1g2ZU41SGRnWVJEMDhjcEJ1cmtSR1A5RGpiUk5F?=
 =?utf-8?B?SHZsdGwrTXlMeGUxbjNxSnVaNUtmVFNNNU9rSkFHNUFaKytSeEpuQVFpandv?=
 =?utf-8?B?dFYvSVhxdGNYS2tCWXlySkptUTZQTmo1Qy8yUUxmdnlXUWowMVUrU0dhTWk4?=
 =?utf-8?B?ckE5SnFkSXN3Zk5PcFA4Tmo3UWhQY2g2eUVXUnlCMFlXVDR2Tzd6WlV0SThO?=
 =?utf-8?B?NlR4eTBGZkkyOHRRR1RtRU9jM0RYZ2RseXNwSHZHdEtDMDNVZithR2ZwTDNL?=
 =?utf-8?B?bWdNSXJ2MFBnSElQYmdWclNKSzBEdEswS3pLVmpuNWV1QWl6Tk9kRlNxTy94?=
 =?utf-8?B?VEdMUHhQa1VScnBJc1pGRXhuL0hQRXVhcjE1cmNRWG4xUW9TRGpPek9rRFho?=
 =?utf-8?B?WCtUMFFxMitIcWRaTlhvWk9UcHZFeXRsUjU5WFhyQmxNSnB1TE5GYlBBY3Rp?=
 =?utf-8?B?eG95NXJzYnRZQzg3ODQ0U2NMRFp1ek1xQnZ0UVUyZmZHdUJUSVhSNnIwWHhV?=
 =?utf-8?B?dkI0c1BYZTZtRE1NWnpia2pOeVprdFRIS0V1VDR2ckQ1MkpvdlYxS1lOYlpJ?=
 =?utf-8?B?ekw5eGhISmJIN1BTcWdnd3ZKTkliL2g0RVNEbzJCQkl3TnFrKzNwREtWNk9T?=
 =?utf-8?B?ajVnSjNWb1QxeW1EZkxmVEpqUk1TWUYrcHBUSU1hb2pJSktVU0NmUEo0eDdR?=
 =?utf-8?B?aHFmYzJ3bU81b3hXZzBPS0NlS3BwUFN5SkxaSVkvQmE1MXRkRldMbDdHODhu?=
 =?utf-8?B?b3krM2lBakVpa3NSdnVGY3E0aUkrcEpxVDlqRUJqUmc3cUtRSTU4Skw2bzFZ?=
 =?utf-8?Q?DJL/QqWTDEkyPOAUon5m65ICJ?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	VHvVndu+8y6Ao4V0UiM2q/y3pC0dicOGWjJU16zHcstPEt+gj7NZ0gEBm6a/AGIYj5pf9B4UrauyNSPr8CVKJAGiNdCJb2ELFUwXQUBSwouEK2/dUr1Jqr/YBCnJHAZucb5834iXBVNP40KjuYunH6TSo/lIweRbFWZNnlNJ8EQxmpqeK72E3TmBNJljOMEylloPy2R0QqPa6C+Tqjy4TX/qVCQTHKOXM1JrBPuL+fo4+mPydpqSCzknt+PvuCrw7rqduXD4X7LoafYIqURs19+4Ek/4SiktI+ny3QbxMxHAe9z4e9Q2IY4uTMylG9wkLOvo0b+YwXL4ITCt86T4+XAqs0tLaX+YZXCyP9p3oPijFlaEHAcT7L5+7Y2dQ8hJAXjUrlsMk+ftQHgR18UQJEZzFbeIF0T/SSQHbqpyAoDA4I3Q9+rLFLDbafPjcAkRjgaWUhmz4aNVnHZ2Lde+nxtRzzZb5Ek9mJmhEpgl4EcZOfY28g5YE+VM5R74lOruBHZIyEA1wQGe+M5ko1IV38qnpnXL+lFOkoe6oUgJtjeoTprYQpfi4gank9V/LkzzziRc3tJTYrpSoOo5S9vu+2aVclwyfDJdDC4ddfo/jl0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 295f2377-0dfe-43ef-ff71-08dd862e11bb
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2025 08:24:18.3169
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3fLUps7HxYgphKFe3USK+EpIfcf4rmp5DS11ZRh3cYvMPRDFlZwP7NIcCiUXyuIjgJiYIsO4nAemDSXkuvJtww==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB5026
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-04-28_03,2025-04-24_02,2025-02-21_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=996 phishscore=0
 suspectscore=0 spamscore=0 adultscore=0 mlxscore=0 malwarescore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2504070000 definitions=main-2504280069
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDI4MDA2OCBTYWx0ZWRfX2rY0V0G5LKmH 1u5rQyxWoDNEJC4LaHopZCHKXmWh2nZawxG4sOuGxkZF55j4ibLkSgG8rndbCwuZipIF7us3aFa oNRHDkQZM2FKL81NNVrz+SKMln50otkk8ZfhRmavjEv1ZE6CJJa8UXNtgMQ+DtWm7kdYwPlPxFf
 BKgd9FuYzH5OB/vm21o4mwrhdIwn88MuciJWffkuL3+jNyoXjLlfbZxDAqFgtC+VEHf7E0Gckti BuzgkCTs/PlHVQbk000OUDlWbQG67o/wW5RzMVp1HNoxYaEAxGy7t8pWytDCVLNwrIpgG7mPV6v XQcjtDHhMwDMb+lfRbj4579ZyNVEPi4mBoKaOvmoeeS4oTvKeV6RJLm4p4xBgl/3Hw+N91PjmZL NnzBkBj1
X-Proofpoint-ORIG-GUID: JSmn6Gq03GCT7bzCcyXeFeVSTXBsWXMy
X-Proofpoint-GUID: JSmn6Gq03GCT7bzCcyXeFeVSTXBsWXMy

On 27/04/2025 23:03, Jens Axboe wrote:
> On 4/27/25 9:48 AM, Salah Triki wrote:
>> Every ktype must provides a .release function that will be called after
>> the last kobject_put.

You could mention Documentation/core-api/kobject.rst?h=v6.15-rc3#n279, 
which tells us this. As does the check in kobject_cleanup().

> 
> This commit needs:
> 
> 1) A description of the problem. There's just a vague statement in
>     there.
> 2) A Fixes tag
> 



