Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F0481509A0;
	Fri, 30 Aug 2024 07:23:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725002620; cv=fail; b=SGrjnvctZ2rCywfmUZHgJjZ5cbLEOtQG0JsEj8lYKUFaYyEQ3jsihtui7dm4QFOWRlOklIfa4B7ZeuxAavsLplxf7RyfOjINCd8IE0oYzU4DbCDmLeUTrNd7N/AxrdY9It7FLzK2Ky8zOen5nsektGHgIGg2Li6w32NIpJUKw4Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725002620; c=relaxed/simple;
	bh=tGWDu+o654vQ6F7Xfj9DM7SxcYs4pKYO0r+LrEqM2Fc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=iMep4Ldl4F0QcYQZqRo4l0Moq+IeSHe1sHAcwC55D578ABZkrUWPgYHM4XOgIYJ49H/RK7H69oPsRMOP6jPPVX4P5u8hb6Wywj/V8T2m1ba6emGRpQBi9JI423Apb0IFrO0dbxzVCZrud64tkXtiB/oQm1TBWPrvJYLaEC/s5vw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=O1lCRmY1; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=z/jMBQ9t; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="O1lCRmY1";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="z/jMBQ9t"
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47U2fVmV001106;
	Fri, 30 Aug 2024 07:23:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	message-id:date:subject:to:cc:references:from:in-reply-to
	:content-type:content-transfer-encoding:mime-version; s=
	corp-2023-11-20; bh=FvjKgtliWJtPXNxMi01SvbPJCaAxkZSy0ei4l0+S39I=; b=
	O1lCRmY1FYIemR11kaLr3Nwndqww82xGiRpFYv/FFpS9j1KIFHV7bvvfsUxK48Dv
	PpFFNdJzBjQ1Lyu2Yftuyjv7mJ2L6/0fA3UFb/023vyzccczkPPxIfq1ks5lQda3
	GN0c+3//Gv7xBh4c//kShv4dSm/YYoGktjVg00FYAD8itingHpRkEQdOkl5x3n9m
	F198S1sJIXiVaQfb0gjZe4iF/dxOutDN7D59pwM6KMWvjeE1fwrl2BVkupSkmZP6
	v/Sx4i/8g1Hzc/gGQtSQ2xwdkb4GIuqKJIz2lKWo/jBfqsIA+b+XFFdw+JeWNc08
	guUZ02LIOlyp2zSVMp8sOw==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 41b25qggjq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 30 Aug 2024 07:23:22 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 47U7K8B5032437;
	Fri, 30 Aug 2024 07:23:22 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2043.outbound.protection.outlook.com [104.47.66.43])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 418a0xqucx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 30 Aug 2024 07:23:21 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dlRl8KravSm28stseJueLdQbf33KgIynLeVLGSBRh+vx6UJ/KPBi5n9/5SB/KXqH0jinnOFP9brJjNvqY7bIy5ebacJhYTUUnJ6dXBNf7lQtAKD/Herh/0fwdNvEjHY9cXhmpQAtCXDFCm0PfgA/abSZ2QFq5ZFDHpCLpDq02VYWCMVyGeFOnbZyuohUy4sqLRFJ3Caeqv/jBymHhLXgBdzFOeW475gBhBKFuHTqsGpbVmzMLsfek8UJI6MktPDJZMKKwMnptJEoi824XIZtoQzjo3jHd1bRKRKLHpOz/M7CI2gwXKP0RaRE2bO0Xz/NFBeLbC9iP6ijmrqmgPmadw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FvjKgtliWJtPXNxMi01SvbPJCaAxkZSy0ei4l0+S39I=;
 b=rhAB/km8PKjBMw/bii8IKf7ei0Sb0BOuRyhbE2abDAqm3vAgGRoX0xlJwtbyDHOi1JCZt40YgfNqI0bcK9JSWsxS0bkn8CW7Hza65ZP7AcoOGuuJxoWgbjC4AGemVBNFA7BMxctgXHMX9XeG4MB3u7Q310gc8lekttiH29fIPhCmGfsv7y2hDgm6RtU/YP692AUMaeYgqZYN0h2rjX6eiSpfR9M9Ey9wtUs5W3PoWfE537qfVKO+FJtfgusIVAlJf7xJezsplBFr6ENCYY+B8gU7h1VqUIvtsFAYtj19AQ3E39Vtw7PpMz2XV4ZRKIdLuDCj8Ah20Lk3OZlB7lMljw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FvjKgtliWJtPXNxMi01SvbPJCaAxkZSy0ei4l0+S39I=;
 b=z/jMBQ9tigKmqL1+yi5ZZIOVHuyYjdohp8mMRGpYim2kF/A77DeB9SovPNhYO28hWYVV212vqWmBsT26gmYkzQ9fk9b3eKmmDqa4qnKG1bMm7j0IMNUX6CBN2Ao5L0GmlAyT6OFb8sO5Ehz1wV87H4vACXh3n+Z4qhZirdMsvcU=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by IA0PR10MB6698.namprd10.prod.outlook.com (2603:10b6:208:442::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.19; Fri, 30 Aug
 2024 07:23:18 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%3]) with mapi id 15.20.7918.006; Fri, 30 Aug 2024
 07:23:18 +0000
Message-ID: <f9e2ed82-6b2f-493a-be71-4549ce21f6c3@oracle.com>
Date: Fri, 30 Aug 2024 08:23:16 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [linus:master] [block] 64b582ca88: xfstests.generic.351.fail
To: kernel test robot <oliver.sang@intel.com>
Cc: oe-lkp@lists.linux.dev, lkp@intel.com, linux-kernel@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-block@vger.kernel.org, djwong@kernel.org
References: <202408301415.8923e617-oliver.sang@intel.com>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <202408301415.8923e617-oliver.sang@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0431.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:18b::22) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|IA0PR10MB6698:EE_
X-MS-Office365-Filtering-Correlation-Id: 4b387442-89a3-473b-1be1-08dcc8c49ee7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WHhOOTUra01YeG83TjR6VWxKd053ODAzNDQ0M1JSL2toRDB1elNNZ3RFZDBE?=
 =?utf-8?B?cHRKNVNkVVRPckl1a3JzYXRIeDE1ZW82Q0RoWnVXQWtLdC9kNUNjMzZTK3dO?=
 =?utf-8?B?RDJPeEw3YjZJYU80VTBPdVRPMjU1cWNSQXhNZHhDSWFNdjhoK2JBeU1JNFE4?=
 =?utf-8?B?SXVhYlhZUTJYVlBtYUpHMXhsZ1AvdGw5QUJlMTRsQk50dHJoRWR2UmZpUGdx?=
 =?utf-8?B?eVU4WHBXbjdKajlna3ExOXZjMldhY1lSdmZVVnlQWHZWdHFZWFN1S3ZtUnBR?=
 =?utf-8?B?bzhIdCtlT3JiOWgrMFhiRU9lcW1tVVM5TFh3eWVzbktrM0JvK1FnSmdEcjhx?=
 =?utf-8?B?QTVEUDBBemJJVnVXQ2ZIWnFwdkNJMXRkTDhxem82Q2Q5RFRlSUw4dkQyUFI1?=
 =?utf-8?B?Qm81aEc2ZHFJenNMUXBvUldzWVZ2dWliQnFrZXZsMXgrMDNQWVQrZDRlblJl?=
 =?utf-8?B?bWlpMnJqRm05MmhnaitVOEZHRW1QN1U0SE5nVlBMSDlWNWYzMDJOYkRWNjJS?=
 =?utf-8?B?WVY3dTdQM1REV05PM2RSOFk2R3JNYjVZd01wa3lxemFIdi9jYVVtNmR4Zyty?=
 =?utf-8?B?bEliMDdENzN5U3BqRWRaWGl5eUw0eldlRTRHSEpFcm52dUZZdWwwZXhRS29B?=
 =?utf-8?B?YXVRM3FpeHArMjBRSlkrYXN6eGk1S2R3d1lTdnpYblNiNXdmemRoVXFNUXYx?=
 =?utf-8?B?aTZkNzg1WC90ZDE5YUJLSkVmZmNRVWlQSjBtZnlwQjVjQWlqYmg1WGpnMlg4?=
 =?utf-8?B?WWZNQ1VLU2Vkc0hNTURXcm4wWVpjL1RIWGduZ0paN2lGa1g5b1JsdHRRaysz?=
 =?utf-8?B?MUhhQk9VUW5NYWhtL3Y4RmZyZ09mUjdDSlBTTEw1UTRvL3J6TEZVanpGa0hE?=
 =?utf-8?B?U21TRTZYUll6d0M5bzA3b2J5RFkzc3JGaDQzSVcxM2hDVGF3RzVFVzJXb1VG?=
 =?utf-8?B?dFlvN3JEUGtQQTZSZXVaZTVmVW9JTXJ5Z2liWWJiYnU1Q0Vja2pvMjh5dnl0?=
 =?utf-8?B?RjFOa1VYNHlIQVJtSUdQbUhUSGhXUFNOTnZ4VjdKN3VydmlzZ0dudFIvcE9a?=
 =?utf-8?B?VWU1cHROaVR3NUM2WmVzMDNqOHhEQXgzeUVIQVN3RlpqMkp0bTJKVUZHMWdY?=
 =?utf-8?B?RFJkTU9NSHNFbUx1K3ZZZFpYa1JnaWhCekZENDhvNk55TndNU0ZHOEpjOHJ0?=
 =?utf-8?B?TzRMU24xMnA5bEhSMUx6RlVVQjcwcEdNT0N1TlcrVFdyUUwwSE04VjEvNEI5?=
 =?utf-8?B?RHhSUVAwb1phTnNRQTNUWEY5Yml4QlNUV2tKcDcwZ0lKL0RsaGluSi9LWGFz?=
 =?utf-8?B?NHliWENLRzExR1gzZW5FWGV6eWppdGpic0lMY3JRM2lTUG9WM28rM1MraERm?=
 =?utf-8?B?NnpZU3NtUlFsdXlMcUEyY3YvNVZZc2I2czdVSlcwQm9hRHVSTTVxRnFydTc5?=
 =?utf-8?B?MGdabTQzdnp2cmZ0aTIwWUFMcVlVWUR1clp1TkxNenY4RE16SEdlK0xPNVAr?=
 =?utf-8?B?MXlXL3lrSG9SZllha1kvR1JmMjRjbk1tYTN3MGpqVkdpdmk3UVA2eml4eWJW?=
 =?utf-8?B?RzlTeVNhK2FRdXVJbnlDR2hnUVlmVlRoNUhFMEpRd3pnQ1c5bldDU0xKd05G?=
 =?utf-8?B?YWNURVdHT2QzQWhQSkNhYUR3QkcxUFdLQS8wb012ZHV0WS9TNWNaL3NJSDdM?=
 =?utf-8?B?aWQ2MUFNYWhqWmdic29TcDVkTVdXQVI2RkcxdHlGbUN3SmM0N2pIWEhrNFhk?=
 =?utf-8?Q?hnUth5cuLpqBZvW+rzOvAhG3hZ4Hk6cttYJjM5B?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QXE3eExHKy9OTUtDb2ZkeHN2SUdXMlV1M2kvcGFuY3BoQ0Rrb1V6bTVkcDBn?=
 =?utf-8?B?WUhJcFhWenBqdTV2MmtsWXJvTHg1ZmJONmE2Nkg1WFNQTVIvSTJ0MWhjNWJa?=
 =?utf-8?B?b0VnOFQzTE5jbnhCVHFCaWhZbEorNUV4c0Jna2IrVHc2cVJiYjNHcTAwT3ZU?=
 =?utf-8?B?Zi9xOVovbEZ4VzFFVUxrUUQyVWtuNEc4aVVhK08ybFNrT0RSR2dJVXB0cjV1?=
 =?utf-8?B?dVl2bnFvcENWOVNYdHFnVnRFMnRubC8rY3NVT0pRS0JReEs5ZG5RTzNnR21k?=
 =?utf-8?B?YnhPdzZ0bElXa3liaWh0emwxai9ZRUVwR05zRUY2a1RaOFR0dlRUczI4Umtn?=
 =?utf-8?B?MkJTNjdTWnVnZTlZMkxxcnVCdGtQVjdjYUdtY1FMd1JDbnk5OXcvTWxHNWtX?=
 =?utf-8?B?elpwbkdrZ2xLR2czYXFBM1c2ZFJ6NWtpVWFKWTY3MEZqRjBYTDdKaU4rWUJU?=
 =?utf-8?B?M0crY1VYbElpQWdvU09oNHlEN1VnTlZVbWZSWEJFeis2OWhuOUF1VTVpT1U0?=
 =?utf-8?B?V2IxWDhscXpzNDZJTzYzN0ZIbCtadWo3eUNhWTFNU3VXcnZVS3IyTURZcUk3?=
 =?utf-8?B?dDdXaUhPWDh4enFhNFgwQ0p1cnZiSmczYmUwWmpuUTUwdGlqdGFyaGkyU1Z1?=
 =?utf-8?B?cWxmaXFQcE00MmxTdWdSUHdGRHFXY1UzRHkzZVFLKy9oYkNwTlNDZHRNdisr?=
 =?utf-8?B?c2pORTNKdkhLZEVESDJyeDFDRWYzL1FnRzlzVWM0QjgvMHhOaW5LU1R5S3NP?=
 =?utf-8?B?TWlPQ1hBYzF5ejV2d1IzRkJFRUlkVEFCc09rZGdLM1dMTHF3VXBRWjVQNTEv?=
 =?utf-8?B?VHhqd2J6dGVKYlNZOHF0STUrOHgwOUJ6UUdkUmdiR25sUmE1SVd1ZVQ5MUVS?=
 =?utf-8?B?eU9kb0xBN2s0ZHlmQkFFQUVBNXBlaTNJakJCRk5sVmVaVVNoUlB0YjRROVZG?=
 =?utf-8?B?c3g1ZGU1VjhTdi9Rc1ROMHBkUXA3N0QzWHU2UjNkUVBiYVRqODh3d3E2TU5C?=
 =?utf-8?B?Q0dzQ3dqWlVRYnBKRnMzMXBjRlNFNzFHOWJna005bjlEdXZNWFBoVzVPVWho?=
 =?utf-8?B?MU1wSkI3b2ZLOWI0NTFpTVlraFB5Z3B1WTBnRm1US01MWFhaZWcvTHA4c3ly?=
 =?utf-8?B?MmRDSEpqR1VsOW94UjYvOFJ0Zi94OTJPejNibUNTOC9ZNE4zd0Q5YTlxdVd2?=
 =?utf-8?B?eXlQZDJTMTZtTHM1NDNTdGVueVVrbXBlaVp0eStWWlNPN2xIdGN0YUp5U1dY?=
 =?utf-8?B?TGJNb1hFRVo4VHI2bGxsdjFKUFN2QmJZWkZSU1lqaUMrYmNUL241eEFiOENv?=
 =?utf-8?B?Wm12eXRuS1JCd3c4VG0zTCtUS1ZNUHlWNDNQZGVuWDh6b2xramFFRjB0TVli?=
 =?utf-8?B?dVgwWHF5WC92OWNidlMxSDVvLy90RW5sdlB4VUlYZEhKNGlBV0lhNURLTW5L?=
 =?utf-8?B?K01ta1IrQUxNNVFzT1p1MmdtdkNxbi94NHVTUUlUV0wxd3E2MElMTGpKWk5y?=
 =?utf-8?B?S1MweDNyUFVPL0xaWTRuN0RPSG9lQXFKcW5mcjhqT0I5aTVQYlUvSlJxa0ls?=
 =?utf-8?B?dmU0ZWFsRHMzTjRGWFBWUWZUV2JzTU5GMDJPTG96T1dVL1RnYWRnbXRYVGlT?=
 =?utf-8?B?TTBjalNrMldaYVgzQjdlVUVTOEh6cG9VN1ljNlJDVzBLV29zTXFtSXBIczBP?=
 =?utf-8?B?NHRkUUJRSTJCRTh4d1BnS0JBZGRDL2FsaUl5K3AzZ3RNbkVzZ2hEcmJDKzBw?=
 =?utf-8?B?UzRmR0ZmYkxYZmRvRVNESVlJT2kwOW0wbTdpd29uck9tRlFBb0xXZ2gxanh1?=
 =?utf-8?B?M3dvcFV3a1BHWXhmTWtONnkwQi9obFdWZGhaNllJMXFJMkwzR3h3U3ZIL1No?=
 =?utf-8?B?SkxRUTM3ZE1ZaTE3THp2Y3dKTnpKU1loNU9QOWdNRXZ3a2huRjd6NXVHQUl0?=
 =?utf-8?B?MnlLYTNzZEdZZVVrYWN4bDlBU2hDYVRER1ZnRUY3Y2FxcU52VjhxVUVTMzNC?=
 =?utf-8?B?WXdLL2xCYXVoY3ZpM3dkcXpaYUxQbCt0N3ByVHZGSmJGc3lPMUhaa0xienBF?=
 =?utf-8?B?MEtMUVZveUNra05WcjN6QVhjSHFnVFZ4bzBIVUQxTzhQWTIwclRoNGZSWGli?=
 =?utf-8?B?NUhHczNqQTB2UEMwR2hoeGZwRE5BN0RJbkRSZ3lXcUdJeU5CbzlUcGsyeUl4?=
 =?utf-8?B?eHc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	jQag0JKt6slPwKS/LVbE7/Xkrt9T22L0OG4raDFyZuv4FfxTxap0e7hvWVt/08EL+7YCfvCcWgy6WGSWBdjDmEuBfgTa+SA8dMatVf+3cmBIqHGWUFrMb7LDyWBmC6x5pNtBQKQ+I7i4uaijFci7Ra8v78q1Hq2B83hd5AcfsExq+tXXJHz6RqnLEFQeRruB522E0s3y2qf4Dk4pmh8piUFdH28eQX8VZEGNIt+Y9fCX0YsX5fGfn/WuNnXOxV26+s2vp9fcpTAtNNwN0JSO/03qtJnUncEElGew06LMDZrM2AwzhAtgjqjvceGHSEoBwcy8emSnGItMFpR1JspjkKGTIEaUeqELoJg9g7piCQnKCZo/9QTXPIVCXcONZAlHNtVk+FBgcq3sGLSlpec19ZyNWXHT8iNJYtiEXMcsaA26gA2aK0CUczQcF9ZJwjl2kvuH8EQR+9840aPzv0daI83A3FSN62BsJWaxaecXO8uOAlh9sYP2ace3Xz7tDEV42bYv+IpcKWu6YxW7j0MpROcrn+Lyp8DXN903n2pjj/6yP7cwPvk5bxjbT5vEFy9htx3WphdqWDzWlu1RpIKrMqN7uF7k+5JASBHe3dC00kY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b387442-89a3-473b-1be1-08dcc8c49ee7
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Aug 2024 07:23:18.7074
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TIW4cKUWEy+b/JeSPagoSHOPVVsEke6THVNYxO0UKqxaJ/Jh66W0gUaS/HMwVEQPeAULvHeZr4dHMGuXhtTpcg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR10MB6698
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-30_02,2024-08-29_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxlogscore=999 mlxscore=0
 suspectscore=0 malwarescore=0 spamscore=0 adultscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2407110000
 definitions=main-2408300053
X-Proofpoint-GUID: ChDDF-5YyANvpHHEBBm_Ejvvo4BYdp2C
X-Proofpoint-ORIG-GUID: ChDDF-5YyANvpHHEBBm_Ejvvo4BYdp2C

On 30/08/2024 08:03, kernel test robot wrote:
> 
> 
> Hello,

Darrick sent a fix for this in 
https://lore.kernel.org/linux-block/20240827175340.GB1977952@frogsfrogsfrogs/

> 
> kernel test robot noticed "xfstests.generic.351.fail" on:
> 
> commit: 64b582ca88ca11400467b282d5fa3b870ded1c11 ("block: Read max write zeroes once for __blkdev_issue_write_zeroes()")
> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master
> 
> [test failed on linus/master      d5d547aa7b51467b15d9caa86b116f8c2507c72a]
> [test failed on linux-next/master b18bbfc14a38b5234e09c2adcf713e38063a7e6e]
> 
> in testcase: xfstests
> version: xfstests-x86_64-d9423fec-1_20240826
> with following parameters:
> 
> 	disk: 4HDD
> 	fs: f2fs
> 	test: generic-351
> 
> 
> 
> compiler: gcc-12
> test machine: 4 threads Intel(R) Core(TM) i5-6500 CPU @ 3.20GHz (Skylake) with 32G memory
> 
> (please refer to attached dmesg/kmsg for entire log/backtrace)
> 
> 
> 
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <oliver.sang@intel.com>
> | Closes: https://lore.kernel.org/oe-lkp/202408301415.8923e617-oliver.sang@intel.com
> 
> 2024-08-29 11:48:35 export TEST_DIR=/fs/sda1
> 2024-08-29 11:48:35 export TEST_DEV=/dev/sda1
> 2024-08-29 11:48:35 export FSTYP=f2fs
> 2024-08-29 11:48:35 export SCRATCH_MNT=/fs/scratch
> 2024-08-29 11:48:35 mkdir /fs/scratch -p
> 2024-08-29 11:48:35 export SCRATCH_DEV=/dev/sda4
> 2024-08-29 11:48:35 export MKFS_OPTIONS="-f"
> 2024-08-29 11:48:35 echo generic/351
> 2024-08-29 11:48:35 ./check generic/351
> FSTYP         -- f2fs
> PLATFORM      -- Linux/x86_64 lkp-skl-d02 6.10.0-12052-g64b582ca88ca #1 SMP PREEMPT_DYNAMIC Wed Aug 28 21:41:11 CST 2024
> MKFS_OPTIONS  -- -f /dev/sda4
> MOUNT_OPTIONS -- -o acl,user_xattr /dev/sda4 /fs/scratch
> 
> generic/351       - output mismatch (see /lkp/benchmarks/xfstests/results//generic/351.out.bad)
>      --- tests/generic/351.out	2024-08-26 19:09:50.000000000 +0000
>      +++ /lkp/benchmarks/xfstests/results//generic/351.out.bad	2024-08-29 11:49:27.839575963 +0000
>      @@ -25,7 +25,7 @@
>       Destroy device
>       Create w/o unmap or writesame and format
>       Zero punch, no fallback available
>      -fallocate: Operation not supported
>      +fallocate: Remote I/O error
>       Zero range, write fallback
>       Check contents
>      ...
>      (Run 'diff -u /lkp/benchmarks/xfstests/tests/generic/351.out /lkp/benchmarks/xfstests/results//generic/351.out.bad'  to see the entire diff)
> Ran: generic/351
> Failures: generic/351
> Failed 1 of 1 tests
> 
> 
> 
> 
> The kernel config and materials to reproduce are available at:
> https://download.01.org/0day-ci/archive/20240830/202408301415.8923e617-oliver.sang@intel.com
> 
> 
> 

