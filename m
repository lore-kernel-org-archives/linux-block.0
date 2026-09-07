Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10BC241A909
	for <linux-block@vger.kernel.org>; Mon,  7 Sep 2026 09:44:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788774281; cv=fail; b=RFlt/boZZDSrzqWtGL9vpxA17QSKBZ8GI1mpUYyyyQIrL5RntpF1/63jo//mlSQRnEG583pkUMgNLnKdy07Cej12TTCivB+yW/CK58dMECYw/ccDqTUlk9mkTKIhPNV0cVXGbdo8bbMdDozQ1Wyua8yX+ihavfGnABiCraViNbk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788774281; c=relaxed/simple;
	bh=qv7MxKOj/3L/aROGJSLiSWyfzDlJy2n7esgYn+aCzHE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=PmnKNtwMzFo7WOxYZDuopyI/FG3Y3Gqn3bDKMCRq6Bg8R5tx00D50cOkQrXHjFZKLWGPUFPVWtNNXEnDOhxtNq5G6Ar82Qi6L2n/P+eavpUqJU/MFBXldpKzx8igI5X0aoO+y1RI7xAXeXLlreWpcbEC+NtGZM+Ni1wFPZtAkh4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=oURrzEHf; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=wMvToaCP; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="oURrzEHf";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="wMvToaCP"
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 686Mufuc540927;
	Mon, 7 Sep 2026 09:44:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=tdv7TJ2A8YMJtiyvkpPF/7YXlv0DK45HfN9o/jczTHw=; b=
	oURrzEHfoaXdekXVR502LO5yznqegZc1ctVY7Ywp2XxFneXvycAbnH1KNnINgg3M
	fZUAmt4nicqb47OGBbFfpQDMEa9aEhS4Ir5vs7zRmKltOsHHTk8C+5QJi5BH33Ow
	is3ghgEcU5O5eee5gYzv0PojVenPkVaILhSBR4lXxMSXZ9b/chRrMEx9fElhjlUs
	oByacfMb2H76Vdwc50Az1DVWXo3F51OQuWsVizuxjOqMJQ95gh4Oep+FbHLAEzAp
	HogdeqSihiWAU8RZomXmJq0hEXntdMguYQ/3a2qE7h/0QJ4kJw7C6YEcPvbWMw7r
	qIK22i4LVl2fvGp0PgCT7A==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4ggbd3sqqc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 07 Sep 2026 09:44:20 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 6879aTGC005984;
	Mon, 7 Sep 2026 09:44:19 GMT
Received: from bl0pr03cu003.outbound.protection.outlook.com (mail-eastusazon11012013.outbound.protection.outlook.com [52.101.53.13])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4gh7aw6jeq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 07 Sep 2026 09:44:19 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qrgPuSiThL95xYAqz/VmVSjXPOpjAnqvpOIjcV5tnBgV2S7EUsNYQhJvMJZ56RVQnAQzPt7KXBYTr4xMho7bnpT6y0YOcAUgjSe0NyVT/vb7dcZrauIkVSVq1lmPMJyCoIRydajCk6umCk1akUYUnnmV788II5L3B87KbrMDq5A81QhO6MFAegr2X8PZ0u+vNWFJ0q2D5jmdVVyk1nnJs2NwrFrP/WG1Ehc40iLaW6HFjn7xwGYuN/BDjJiTDtRXs7iBNkSKCbEV4EhHks4AsmIReyyOAZc+0Yz/27PaI2eNSDv3p8YdcEvAnfHzsSSMMId5iOC/r1s643zymii5nA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tdv7TJ2A8YMJtiyvkpPF/7YXlv0DK45HfN9o/jczTHw=;
 b=cjid7hf2BrXpGeI42D4GqF3NS/9nnT71V95yDkfDnsAkSrorZ3bkkd9DUuJCJtbzgIj9s7na/VtNypbZ9Co16TF5kQU61v4HZxlVXHaR0vhdtk6K5g9hVFIR617nBkwcRf/VwIsnOwmZlpIbHHYqJfXZD+FW7Av8vNVrMB9SjM4Yls5DW1mfK5TrQviovp16fu+oVJKzvFz+zXwJSF3OEEw2omiVBTygAZU9Dxc7TTrHQbEYpJPBsXX/TimlUi3UICWM7C7Tn9vl5Ja6/2Kzp7PPicMJLFI6bm0zCqEi+rcQFlqiFDZYxeNfPJfUMD+1SPwrts2qLWHYH6BMIUO9Bw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tdv7TJ2A8YMJtiyvkpPF/7YXlv0DK45HfN9o/jczTHw=;
 b=wMvToaCPHGXMzZygpPdUOtTgv/tJ/b/G6UlXG4D4vVfFOnd8iQFnzu7eSm79EoQ5Xnp2DCSuwwSSbR4vKsX8mY+6FLwVwOSlPbzmJsJC1N7FTH4814khabnkutPv5w7bROPFK6qoZReyk25oblqFaybjdUp7ZpCW0sWstW9F9Yk=
Received: from DM4PR10MB6229.namprd10.prod.outlook.com (2603:10b6:8:8c::12) by
 DS0PR10MB8101.namprd10.prod.outlook.com (2603:10b6:8:203::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.406.6; Mon, 7 Sep 2026 09:44:15 +0000
Received: from DM4PR10MB6229.namprd10.prod.outlook.com
 ([fe80::867:63e7:13fa:fa7d]) by DM4PR10MB6229.namprd10.prod.outlook.com
 ([fe80::867:63e7:13fa:fa7d%6]) with mapi id 15.21.0406.005; Mon, 7 Sep 2026
 09:44:12 +0000
Message-ID: <29fd52d0-a4c6-4198-8495-c02ac4de5d8a@oracle.com>
Date: Mon, 7 Sep 2026 10:44:09 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 5/5] block, nvme: add same-LBA multipath limit helpers
To: Yao Sang <sangyao@kylinos.cn>, axboe@kernel.dk, kbusch@kernel.org,
        hch@lst.de, sagi@grimberg.me
Cc: linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
        john.garry@linux.dev
References: <20260821101050.1464087-1-sangyao@kylinos.cn>
 <20260821101050.1464087-6-sangyao@kylinos.cn>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20260821101050.1464087-6-sangyao@kylinos.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO3P265CA0004.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:bb::9) To DM4PR10MB6229.namprd10.prod.outlook.com
 (2603:10b6:8:8c::12)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB6229:EE_|DS0PR10MB8101:EE_
X-MS-Office365-Filtering-Correlation-Id: 92d1afb8-8abf-4cfd-19ce-08df0cc49298
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|23010399003|1800799024|10067099003|56012099006|4143699003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	H3pYtFx+UEUDkS8KQdi9FFm5JiJAc4hBYBER/GCG4U+t7NiQfU+bWmFGXDDY6TUaDTpyv77ooApeIp/5H9dIrSRWQZATfVNjOM7uszm8SM9SllOTujDC+CcbyhnjQhgfFv5M44u8HQd5tTKYmHe15WpJQgaRw+3GmLq/z5BgseKut09sBj/ZWm4RywK1x10krpUYHeZHQHLvRW4LlNUb5W/18yCGKuT01rxAw/tAc7LrzXVZnKoNvh+iDsZlemH+Kj6RgsIJcaYGr5WkWUP4hD2UtH16hUNSTR+Qs/6YkjONkoRq1uZURlhYB4AceLcL+L3lBWr24qUUaTk2bW9nFbfAgC7Rlj6KWLyzxQe6JprRnIkT6xCB2AgaaSMVnJrcedMGaMToyMaMkS/7xMt9xdZh619n1x8FBvdBx5EQy/JMMBKIfpkkCn6b9+oIaPS/kW+pmuWxSduE0kw1adgjDcFh6is2BhHrTkRYp0H5pt3Ei74bATEl2vQXm81Affgy9SMZZWtiO5UMAG9NikF0VOPeA6mF7jAz2bbK/ZFIOPOfdlcnvW6yEEnnKVmcL6DJy16BdJK8J5jhNablAzJ1PwgmsAj9RLk8WvTXVXxT2pYaMZLaN7QxqacZva/13l46MMDEGWEN7eJbo9o9htWkbUb2j8z3Z5DyAaofEzT1umM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB6229.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(23010399003)(1800799024)(10067099003)(56012099006)(4143699003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WUVVNmFicUdkUm1kdDVCM3BuYnBSd0xINVFmRzBHUVBHQUdEdWFsYVQ1dC9K?=
 =?utf-8?B?djNWanRWVVc1U0RCd1N5WTdtdjBkWW8ycDlPVm5uSkhoU0xldXNSdFZzR0hM?=
 =?utf-8?B?V0p1MVd1RXYrb2k0c1YyYnZLbXZRQTF4WnJMNEUvZUlja0JrQVlzalpxNlB4?=
 =?utf-8?B?d0JmSWhPZUE0dkJWOWkvRjBpVXhxTjY4KzdkbUxjNWpJODFNM28wVlZOSjFH?=
 =?utf-8?B?OW9kREpaTS9LcFAvZGR4UDZFOHJsNFViMzY5SjBERklGZVp5ckFab0NFVldQ?=
 =?utf-8?B?bzl5T1RSdUV3MVdZTWJRdWl5YTNtR3VUSjBqcWZ1akRnTUFYMWxGejcvM3RH?=
 =?utf-8?B?WEhCcUhkbkJhNDJxNUZLQW0rb3RjV09Relp6M2dBb2l4c3BpQTc3b0dMUThm?=
 =?utf-8?B?anhaOTdPckI5ZmNsWnNEOGpROGNHRjQzU2xsdGNVd0NjUTVYaFBuMkdyYXRw?=
 =?utf-8?B?WVI2dEdRR3F0ZlB5QTQwaXBhbi9ybzlkUWQ3MWtCK1hoU3JrM1JZTjBZY3lt?=
 =?utf-8?B?VlNvZnkwTHFKbjZMbFAzbGtjZ1ZwQ29PUDNqUS9UbEtCdDFtUXZ1b2ViV3hL?=
 =?utf-8?B?dUdYTnFxTmV2WWJvUmtnQ2IxQWZrTWlnTW5abjZUT0VLcitIMlRiWVkyem1M?=
 =?utf-8?B?NjlSeXV0N0xPS0lhZGNSZVYwbjZiSXA3NkFxMVFpYkRPbWI3WCt0dk02dklu?=
 =?utf-8?B?cWxlWTg3S2FQckZVNnBWSnRnZWRhL0svV29kR3FwYWVZeDdibzF4TkVBSnFO?=
 =?utf-8?B?TUVaVzhQM3N6VkdyaW80VC8xMzdkeWxXVUZJR0hsbG54V2hNWTVoeTVsWTFk?=
 =?utf-8?B?TStKSzlFeC9VdE5hMCt4L1hUWDk0T3pnUWkvTXUvM3dFSkZNWjRBSmxxSWRI?=
 =?utf-8?B?U1Y5ZW1BU3cvcGRPa0xRUGJqWDdBN0VXTHUyZm9Cc3BHVFE5N0oycXNaVkRZ?=
 =?utf-8?B?VTJ1V3VURlFsdmZCNlAwSndtSnlsNEZObW5seExBejZYUTIwVTNrNDByeTRi?=
 =?utf-8?B?MTMzZVlYdHU1YUxDaUxFNkprdE0yYklXUng1bTAxbHVKYVE4clRHMkI0MDlK?=
 =?utf-8?B?dHJIWGdndmI5dzZ1cWlac0tLZVdyRVZVbndES0RKTkEyNk5MTzkyako1NnJT?=
 =?utf-8?B?TGIvTWJHNXpNTU83YnBtMmpFYU9jSzk4dlhicVgzZVE5cFJQa3ZSSzQwKzN3?=
 =?utf-8?B?ajZQVkU4WDZIQWlrZ3JpT1pRMkZZSHNibGdUWXFCVEhCd0dabE4xYVJKVldv?=
 =?utf-8?B?Y1J6SVhYQkwvL1FidXdWSmZFbDZUL1dFa3kycDNrSGw5S3g1R21tdTlEZVZl?=
 =?utf-8?B?RlgzeUZVUC93bDloNllMdUtVMmFDQUZxdUd2d3k1ODRrMk8wV002Q2dVQVhy?=
 =?utf-8?B?MzNKZFpIMnpoNTBkZHRkVld4VEE1VCtNdUdjVlFDbDhDc1JOaVJ1S3RORUpm?=
 =?utf-8?B?TDg0SkEzZ013c3lhWVlVUmJpWGxKWTBITS9BcWZ5V29tb0lZdi9oT2p3RmUv?=
 =?utf-8?B?SGVrNkhUVUJ4ckwyTmFWZ0Z5L2hEbksramkvZlozanVvcy9rMUtJWmRzdTBY?=
 =?utf-8?B?R3RVMVYvZ0hWSzdzNG5ZdE5YTE11cDlBd0hRMEc0SkQ0eVpjam5SWnlLTEo3?=
 =?utf-8?B?UEhpWE9ETjF1dU5IU0JvcTNmSHYraVV6WHVZbXFrVHVWQ1BBUHRzWUczS0s0?=
 =?utf-8?B?MVBtMDhiZWdXTDB0cXdnWDE2c2VXd1Q2RWJYc1FmMGhVcUJXOW0zWHZscGEx?=
 =?utf-8?B?VHhjRFFHajRWb1JRdm0xNEFzT3VZRTc2VzVEclhlUVp6dTR2Y1RadzV0UUNG?=
 =?utf-8?B?SkxJaGozRzlVaXpWWVFiZG55ekhra0RzaWdwZlFSeVAvOFN2cG1jQUp4K3pF?=
 =?utf-8?B?WGJzQlZFQWY2RVUxbG9IYjVwZkMwcm1mSWhQU2U2U1dZNGVudTFJNWticlNS?=
 =?utf-8?B?S2VJempYaTAvb3VKWU1kdmdyYW94YTdmSkh5MWVyQ3ZETXVSQ3RmTmFDcHFv?=
 =?utf-8?B?SkZTY09rNDhEdTEyem1YZnVsb2lUTk4vbDFZeUhEZ3JuMXIxajh2MnRlMmZ4?=
 =?utf-8?B?Yk5wSHpFSHJtd3hHS2hSaUZUWDE2R3ZvTWpNVk5neUEzQzdRdWJjVEY5WW9j?=
 =?utf-8?B?N3hINCswMUhYTnBuczhtZHZtYlRmSzlYVG9Eb3gzL1d5bVJWQThzMCtvK0dQ?=
 =?utf-8?B?Sng3R0MxTG9LWVVCZ2tCMm40VWZtTlZoK3NTNWViaEIvRlNLQ3RtUjBadnJF?=
 =?utf-8?B?VjU5ZGxuSFZUTmVGbXhpNzMwNkVmYmdnbmtwTU9XUzJQdVdkYXZxRDlUTDFl?=
 =?utf-8?B?YWZXR1RmeHQ4Y0JCQWhnN3JXU044OVhFRi85VWk5Y2l6aXI5S1VhZz09?=
X-Exchange-RoutingPolicyChecked:
	LHzR8GWooLAaBl9AJQ1YGEOUuISeneN46G4e7Du09OQxmY+7R9Fn7TXP8wgHw9CEm21oJUQ0j+i2m+QWe/tEKJ8Wu8G2W/PyLvJ1F2g44lC7kNg+xgyKm+rAdqrqS5d7syl387LIcdK3ceRVC9rLl/45oLHv33OcU2FyuKH2EwfL0/h0acH0rGolNCHNAvLdCdCR6Utm9hZftmMwYYt5UAaCXSRdQVVk5KMZg0pHugmg8G+RtojuYyBdeQVg9NQnwPjrbX55cLw7kqBTnj8v1o99FuQ0PupNYArOMisr90pz7Z94Af22UwBIY/aLkp7XAJrFSHkcTytIz1wxsNa/tA==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Nj5WhhQRBnab2s9Q/5kvJlmRQjIggUvYtjZup0RsgRCj/kW6//PdJdboqF2uduBfYrgk4J8oITGFLN+eWoGXIzouMPhl+ik++N7SJ6lsgeVh9YtZrh1UxYpun7bAt2rY+K8ZNbrnQ78leNPAR32JI/h94PgmSEPN0MpFcBfLbuTjTkWfbr0wJfNCV3WWnKDBaErDg3Lpjg8Okw9kedjMrfEaENwpGoFaUzSfWGJDwnG1NjHn5bFahIKKbbz2HrCWFHgbFg9CZbUClnynxLHX08m1bZGFNRWSuXzWf5ZbUYp4kK3GK0noIGpNCbjKqB/yeCn5NQWTCocYf5COYRiSvXqTnUcNDnH8ICXGb9h5ryJZ/i2XOu1cGQZgJy2KwNFfg2gjbVKJlox3EFwT/QZZ1/fafcWcifvOS9wtsJMlmE65IklcCoCZATPjAcLGev2kcQnjAWTze/UQLrjlbLIfvrID4dQdpUGsTcdcSEVUjzXlPMSoRfw4rfbHJ/hAh70vCPLy1vtXLatBb/cTostDUQDa9CJTkct1oXLYJYn/ni87xog1bvoyHO0Ri75LESpmwLD6mDnxqqTFGhgl4tSD0SSmrCVaOktGc1RhNV03tEo=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 92d1afb8-8abf-4cfd-19ce-08df0cc49298
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB6229.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Sep 2026 09:44:12.3435
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: y+sL0wE2PUMbZ0Y3oZzXI2cGrTLqyHGo2lA9kJ5ihfjaD5eIs/vEyRjkamw35eRzC8DmpGodd1Kp3dXqowF32w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB8101
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-07_02,2026-09-07_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 mlxlogscore=999 suspectscore=0 lowpriorityscore=0 adultscore=0 bulkscore=0
 malwarescore=0 spamscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2606160000 definitions=main-2609070104
X-Authority-Analysis: v=2.4 cv=EuDiaycA c=1 sm=1 tr=0 ts=6a9e8774 b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=VdqzKS8jKosA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=jiCTI4zE5U7BLdzWsZGv:22 a=EIcjfB9IiI4px24ztqRk:22 a=ZYb1aymv9lumvOMjy-MA:9
 a=QEXdDO2ut3YA:10 a=5yU3S35YU4bGjq-dph-N:22 a=Bho9c0fBagfJEIQBS7DQ:22 cc=ntf
 awl=host:13521
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA3MDEwNiBTYWx0ZWRfX8mcf0vWlIq9F
 nblGc6mUMDDGHMQT7BbgyeS7Y6cxuCP/D2CFrZ4loJ2nDv+C4BzdSj5kFKm3MR5a7s2YOdARS28
 r72N3fjakqdhZPUAIah3LEPDjxavZidjE3T6LozZ/TPk8ibkqQqa
X-Proofpoint-GUID: Z9JmpuCDs3Cq9ry-rQdjc0D4BBI1KEjC
X-Proofpoint-ORIG-GUID: Z9JmpuCDs3Cq9ry-rQdjc0D4BBI1KEjC
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA3MDEwNiBTYWx0ZWRfX0fUssDD30+bg
 Ee6QSI6zvdMxVBdByk/um+JWRWHvqPqDXOPDbRV42RmBaid1t6Q3MiYI3IlyepVa8mOF6wN6Ga6
 zs9ON8ojq7wpnYMQKkBOMytTMs6qmkL33qz4JN/TqRshXA7RXfxA4QwYtzXz+YHJINM2B59SxmX
 usexcNL+p6lqGyFR5GYYr1ZuiSGB/rig9RNI94PGhk3q5kQwkQATaqCSMjCGXCLP+cRtGMKcwpC
 0wg0Tnqm6dni1fjw05aDo+IGBpCGEu6fOeTYTJoHb+ZccFjEBOrpiLkUMW7B2yyTCYTuCJqKI/n
 N5sqyqWTJWs1L/LZwLhB1tDPIR0/TWzb5Q7sQxbHIyUQBZCNfWLqS7YuTtLhHPCiddSl22cTPna
 36Q3rgC+JwLxtvRNX2QFIC8TCS+qSeqZK2BTuB8H+ABZlIqGXe+6l71OsZZ+sHL+w+CBQalALo4
 9UgzCKzTMqtJdltfGala+t/I8iokpRdnhyGVP9Q0=

On 21/08/2026 11:10, Yao Sang wrote:
> A same-LBA multipath head and its paths address the same logical block
> space, so they do not need mapped-range topology calculations.
> 
> Add blk_stack_mpath_limits() to stack limits that may differ between
> paths, and blk_set_mpath_head_limits() to set head limits that are
> expected to be identical across paths. Export both helpers and use them
> for NVMe namespace heads.
> 
> Initialize max_hw_discard_sectors to UINT_MAX before stacking the first
> path. A zero limit means that a path does not support discard, so it
> disables discard for the head.
> 
> Signed-off-by: Yao Sang<sangyao@kylinos.cn>
> ---
>    block/blk-settings.c          | 58 +++++++++++++++++++++++++++++++++++
>    drivers/nvme/host/core.c      | 34 ++-------------------
>    drivers/nvme/host/multipath.c |  2 ++
>    include/linux/blkdev.h        |  3 ++
>    4 files changed, 65 insertions(+), 32 deletions(-)
> 
> diff --git a/block/blk-settings.c b/block/blk-settings.c
> index eaba38370657..8f70bab0a814 100644
> --- a/block/blk-settings.c
> +++ b/block/blk-settings.c
> @@ -800,6 +800,64 @@ static void blk_stack_path_limits(struct queue_limits *t,
>    	t->dma_alignment = max(t->dma_alignment, b->dma_alignment);
>    }
>    
> +/**
> + * blk_set_mpath_head_limits - set head limits common to all paths
> + * @t: limits for the multipath head
> + * @b: limits for one path
> + *
> + * Set head limits that are expected to be identical across paths. Stack
> + * limits that may differ between paths with blk_stack_mpath_limits().
> + */
> +void blk_set_mpath_head_limits(struct queue_limits *t,
> +			       struct queue_limits *b)

nit: mpath_head is a NVMe multipath term, so maybe we need something 
more generic

> +{
> +	t->logical_block_size = b->logical_block_size;
> +	t->physical_block_size = b->physical_block_size;
> +	t->alignment_offset = b->alignment_offset;
> +	t->io_min = b->io_min;
> +	t->io_opt = b->io_opt;

I would not say that io_opt is really fixed for the disk. For SCSI, we 
change this value from transport/HBA factors - see sd_revalidate_disk() 
and how io_opt may change from the SCSI HBA limits.

I think that you need to take a conservative approach here in deciding 
what is a fixed limit for a disk.

> +	t->discard_granularity = b->discard_granularity;
> +	t->discard_alignment = b->discard_alignment;
> +	t->zone_write_granularity = b->zone_write_granularity;
> +	t->max_write_streams = b->max_write_streams;
> +	t->write_stream_granularity = b->write_stream_granularity;
> +}
> +EXPORT_SYMBOL_GPL(blk_set_mpath_head_limits);

