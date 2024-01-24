Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2C497C08C
	for <linux-block@vger.kernel.org>; Wed, 24 Jan 2024 16:53:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706115197; cv=fail; b=WX0UQNv8s1cPla3bLMEFOw6a8jBKPA1uQ4o5UnhZok3CeQx03+kx6i7NLmKlpMoR/uvgbmMwHuRSH5G9+ij2xzEnoQez5v11V06tyJgBd+ZBz8nHzMq2qMlMwrXj5kjj/RxQFU61r5DVhyT3/dFfYO9a8Y0EkEOvW9Q7rMz+qyY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706115197; c=relaxed/simple;
	bh=Vu0AJSTTKuFq2Zv8eoG9jSmUFCD6DDKTub7Mrs573SE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=I8oyhSl9xDiw9PagUeGRs+AT/mdgqkO2xcLavROL8v36vYADwGaE0bFJ2TLC4KtZ/DtM8/ksQNOqZXofNMwOBIz9aqOG/Du3dTW/2yiNZfOuUk8mSOVXAD0AS+RiypXiBrKUxWseUUsxfKUuZy4uuLnKfyoULcW05GaX032HTn8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=ReY6GtR0; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=M2zuS4Ov; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ReY6GtR0";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="M2zuS4Ov"
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 40OEtupg002309;
	Wed, 24 Jan 2024 16:52:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=LQiq9FrEIk8CqzOxP+R4mdvM1pE6YMmAt08u/zNOTaI=;
 b=ReY6GtR0H+7lpWSSTYzw9/l4d7yU/X2DL+3S06qdnr0MUz31YbyfSeluou+nDdYmf3nJ
 tmmEvHei4xfL+7HSCiweEYc4zdNrHBBgdqoY5vlpJg5kKmXbQslXNjFSxlI3s7EC5xmz
 8yB8YnrzWrqjEhk9OIB4mXmDGmXMwVwxjapBiaVfdCHa2NrBAzbfDGQcU1XHzbKqsf/J
 f3dlwSSufl1nIgO06oYy1VHRl/P9zy3S7OppZE0gtqyJzkrZud0XiM4p4JSmAsCXF4SN
 sJuEDbamwc17kiDQE90H/vbmTrzik+RRpAtLCvS0rgDuUzOgARF8dFa8u5V0+rp+2sOn Iw== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3vr79nmetc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 24 Jan 2024 16:52:59 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 40OFwRYE026023;
	Wed, 24 Jan 2024 16:52:58 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2041.outbound.protection.outlook.com [104.47.73.41])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3vs317ft6c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 24 Jan 2024 16:52:58 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d3ECZwfkX58n3TxulO2bBMtZbBppFYb+LTWLvS+yXI1FhlUyBGQ3l2Mm3eA8RTIln7t0ro1Yr4GYRuZiw2kVFyT7yjo75sUBx8v6XjfG++zfT9NaFWlYq6crz6XQTQvJ3DciI3uCiAoqaglM8c8H1zesZ8qO9yCYxuMx6tYjYispfaYL2891BJKnySEzRlcxZYDT6I8ShQUNMvsjKO7zXwmvlXXi4gF1jAkN7+vKQGf+wSdInJs4MReAymi3G81C+V3nMMvThWlv3TCZMGtw8yGHHnPGjZiU3lo/mI6ItmGm5aVQk35ieer88fiIXqPzO8rTkQACn3erJsnxeMTwtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LQiq9FrEIk8CqzOxP+R4mdvM1pE6YMmAt08u/zNOTaI=;
 b=Wl397LtjCSYY4M4WLADRR/HgMT/ediy26GBvV7dp2EIs4Tg8DtD5jkhp5LIIzS4GPD0aFhwiALiWC5lfKoszYa4OOomDerboFzEbvll+s0sannlBOUtV2oQVPiHE9dtFNZ8OYLK2DLEz/m8/vNCXbchk01kCi0AQk/mN3tBwgP/7YdL464+ZQpACiOuQz9uGpHXw/jZvL+YdRlQCxPwNlbXvZ0WhGhe9Wg6z6WkHDOCMzQ/c1/zqjxdib0WsJ4jcKpVWCG+laQ0t9W/3PX5+mEdtzLyCEh2nGcJd3hSCz0k4Pqwma0CtQAvUTqjI6C5kfDUD2AEU5xuzwE+PD6YewQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LQiq9FrEIk8CqzOxP+R4mdvM1pE6YMmAt08u/zNOTaI=;
 b=M2zuS4OvQG13Gcb3IFx7pItbwEea/M9XRcc9tg+9Usj1PvGsx4mFuUyLF620H6VGscCdKdzkX9UYYx1Ueozh6VDyjn88bhJKosUBSXtS1COykngUnuP15vqlptEYhIc7QIT29LLCEn1EGViH1l+OWRZCLkoRU2VxwYGaIWtsiUQ=
Received: from CO6PR10MB5537.namprd10.prod.outlook.com (2603:10b6:303:134::20)
 by CO6PR10MB5393.namprd10.prod.outlook.com (2603:10b6:5:35e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.22; Wed, 24 Jan
 2024 16:52:56 +0000
Received: from CO6PR10MB5537.namprd10.prod.outlook.com
 ([fe80::a6ec:9178:f73f:e03c]) by CO6PR10MB5537.namprd10.prod.outlook.com
 ([fe80::a6ec:9178:f73f:e03c%2]) with mapi id 15.20.7228.022; Wed, 24 Jan 2024
 16:52:56 +0000
Message-ID: <d63f74b2-b455-4fd4-9b32-2657c6d81588@oracle.com>
Date: Wed, 24 Jan 2024 08:52:54 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 0/1] nvme: Add NVMe LBA Fault Injection
Content-Language: en-US
To: Christoph Hellwig <hch@lst.de>
Cc: linux-nvme@lists.infradead.org, kbusch@kernel.org, sagi@grimberg.me,
        linux-block@vger.kernel.org
References: <20240116232728.3392996-1-alan.adamson@oracle.com>
 <20240118072419.GA21315@lst.de>
 <6874a81c-3f4f-428a-8a95-19898ca004a2@oracle.com>
 <20240123090506.GA31535@lst.de>
 <7d7d7855-8a37-4de1-a32b-2edf0b53a05c@oracle.com>
 <20240124090453.GB27760@lst.de>
From: alan.adamson@oracle.com
In-Reply-To: <20240124090453.GB27760@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR13CA0151.namprd13.prod.outlook.com
 (2603:10b6:a03:2c7::6) To CO6PR10MB5537.namprd10.prod.outlook.com
 (2603:10b6:303:134::20)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5537:EE_|CO6PR10MB5393:EE_
X-MS-Office365-Filtering-Correlation-Id: ba52e751-4b4f-4731-a370-08dc1cfcea10
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	PHq4CoBUIwWUyGHtd5NlJk3bqT/DvEBpvfnwYLG9rGRaStBaH9ZWpZHsIVUUM4/e0lFkoIfhmHPV+6SUyX88K7d2zcBgno6aJlh6tvIhiYRBNGLTMIpwXG+dwIlnZSL7oAbeqaCQKJvtoHPrSOUqcauD5VZp2DEcNu6Xt41sB3jTIvR9lknA0NYAPJ6PKzVDZZpBNSRjt9Lp4sLUd+KXNmjiz/I7qqdemcym1GSlY/nI97nalhq5i4nx3bU4VkB8jMLBrTWyYSDsMYwXrIPzDa8rYbYGIr1vCp8CMp1XhNfq0DA2Bn3Job9YBHyXdUV4HdgKPCyjPhpU0OCDtaSv334t4xP4Bbg76bzfJlW5VWTOMmxl7VvTb1Uv4th6EQOZ7WFuK++X4yrggTG+eU2exXv3x5+w/O6l1AopKjqutQMfbM1RjOaRH3A8MJmsryoaBwiAMggB9YKUPGLXrE8+KYYCbWhCyIIRWjT46KZ2KRM60iFvCE8SF2NlmAl7k+Ogmv1/YdbeUQdSfJcC8YpekUIPpV0a0BW7dUZoyNA6s+bFlgvzTIH3KHVMAITVB05vLEQJBEu53txa6le+oQFThLnQ/d1u5jojFMitMBUUwijcFRIpkJmuHlwtKlbVNkuW
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5537.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(376002)(136003)(366004)(346002)(396003)(230922051799003)(186009)(64100799003)(1800799012)(451199024)(31686004)(5660300002)(4744005)(2906002)(66476007)(6916009)(316002)(66556008)(66946007)(4326008)(8936002)(41300700001)(8676002)(478600001)(31696002)(38100700002)(86362001)(36756003)(26005)(6512007)(53546011)(2616005)(9686003)(83380400001)(6486002)(6506007)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?VkhzcEdFTkhxaC91Sys1QUJvdHVQUzQ0YjEvanhpNWFLYkVJVEQyRWpweGhL?=
 =?utf-8?B?SlROUDZJQ1NPd2o0Zi9td05TcFE4UEd0a2FubXhsdU01RHZKOTcrY2d3cDZv?=
 =?utf-8?B?WERzSWMzUDNpTXh6VnJQZG9qQmZxTUszMHRXb3dac3RZTkJDdXhWaFhUTzli?=
 =?utf-8?B?T0d2eDJVak4yTk1oTHBGREFZYWk0TzA0SEE5c08xK0ZqK1pKaGFYWVBMbVMx?=
 =?utf-8?B?Rll1Wm5FNkhEdzNKcElKQk9QRzNZMXk3eGYvV25VZ05vZGRTZTJCamZadE9T?=
 =?utf-8?B?KzRCS2N6WDdMNjV1SlZ3M1l0V21CL2ZlcGNib2FvRWdLVGlnN2k0cXJ0OVY4?=
 =?utf-8?B?WGdaLzk5VEFUd1FvV1J4b3Ewem9GZWZneHFiSDBnZEVFZ1N1Q2htYU1XMWVL?=
 =?utf-8?B?azBGMVViWnNGaHFsRGRYejBpQU1zM01yTVNOYTRwRFJkNkNvdFI2V3crazR3?=
 =?utf-8?B?YkpicVdHMjNFN2RzVVVmbkp4Z2lyOElqY2tFZW9iUXBFYlpTWG9pK1g0Ynlm?=
 =?utf-8?B?WDF0cnVVc0RRVTFqb09UV25GS0drcHg1NFVxQnM5TUJxVDluVk9aZkxnQjlP?=
 =?utf-8?B?ZW5tQWhGUEx1Q0YvSDFPeEVLRmp6dE04Wm5WSm9KOC95TXZxcDlmS0piR3ZV?=
 =?utf-8?B?Y0Z3RFBNd1p3VkhSdWFqYzdkMjRLK3JmV1hpQWNHTUZZLzlOYkQrMnY1UFhi?=
 =?utf-8?B?NjdNODEvM2o1VWdDRzdFQnN0bXpWY1UyOThSMkp1OXpDRStRZUpiS0Rpb2Ro?=
 =?utf-8?B?TGJuWXo4SW1DeE1BL0xMYkM2STlJZGdEZW9GVVQ2QnQ1a1pOUHBwQXVsTXBH?=
 =?utf-8?B?N1Z1SGpVNnNxSnFSUmw5T3N2Mml2STlRRFp6LzlKMnpmQkV3RWR4dENQSDZR?=
 =?utf-8?B?TlZCMlllZkcrSm9sS3JYeEg1QThaR2gvZzJaMkVWRzVaYmVqRzFYVjZtTy95?=
 =?utf-8?B?c1daSHBvRWR5WExDQkZzcDExWW40bFFpUDJkNHVYckNNMUJaeHhWN3ZUQzAw?=
 =?utf-8?B?SisvQ2FlOTZiemcveXVJSGNPcFNPR0RkOXVuTFpBNnIvL2ZvYmdnQ3BXVW9z?=
 =?utf-8?B?SEVpUCtSdUtYem9uR0xhTkdodXFDVFZDZkFWY2g0V1ZiUmx4U3NLU2J0RzFy?=
 =?utf-8?B?L3R1Tm16OVJUcThWd1pCcmVzSW5lTFdTbW9sZmRVYmIyc2JrWUg3aVh3VFF0?=
 =?utf-8?B?eHdkT0xRY0dQbTlQZEt5WjBSSEFwTUpvVk53elFXczFUR2FjM3EyUytuM0lw?=
 =?utf-8?B?eUJHZ29xbUlEVUZ1cHcyczNGeTJETUZxdEptYTl0R3Q2Z09ONEFid09BWkgr?=
 =?utf-8?B?Z1dPbCtRVmI0clZ5WW94Yjc2STFqclB5RVZHUzhsNHpxM2F4M0R0aXJpK2o1?=
 =?utf-8?B?dFh2eXVOUGhxWkJiTHJYUEFIbzlXNDZITWJjaXAyaCt4Sm5YRjcyNkhIdlhZ?=
 =?utf-8?B?SUg3MW53WEpuWXN4S09OZEh4aHFuNEF3QnBqZGM2Q2hBMmh4eEs4VXJWMW55?=
 =?utf-8?B?Ky95WmlKLzZMRHhnQWVxL3hDQUdDVDZvS29yWjZILy9ieXpnR0k5K3hDWExl?=
 =?utf-8?B?UDNVV3F2Tyt5bG8yNEpBdEtuVTBBc0EwTHBtNGNwSW0vTEFTakd5aWJCSG5C?=
 =?utf-8?B?MlJQYmVwVXFpYWVRSm52NUg2V2RBSndDN1hEUDJiTFJHdGVWRWtZUjNpT2kw?=
 =?utf-8?B?cUJyM3JLTndhZmlRMG1sWVU5S2YxYld1M2F0YjlJMnByRHNRWlZEdVRJUlFO?=
 =?utf-8?B?ZS9rVHUraVhlVkpMd2VWa25YL2l3RlFFamxPalFMMUpzakQ3K1RTN2xMNGpy?=
 =?utf-8?B?Q1pRUGVnOGdSMEh0K0NaZllZdVJrQjhrM2UxUTRJMUpYbTlFcnp3SERKL2xI?=
 =?utf-8?B?WDJudGRwSENEbmVteEF3ZkhHdG9BOUs1UUIwZ21sdTJUVXNUcGFsRkFOM0tt?=
 =?utf-8?B?bVVkTXdrMml2V3ptWVJpbDVtQ1drcXpncU1IVmJHL0IyL2FPZTRZR0ZHN0pB?=
 =?utf-8?B?bGhqenZOVWRNZXpaT1Rxc09ReTJaUjJ0TTBWUGxjaGhKbHBzQ2dTOGtybzRN?=
 =?utf-8?B?Z1d6dlVFTThNUzMzbWdIOWg0QlFtOG8xMGVqSTd4bGk0czZKbmhaM2JhMjZ2?=
 =?utf-8?Q?TJbYgPW0mBFoajSEF8mf3e4L5?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	FmGka307nsKNzhJvaA+AH9vbSabXflzsvyWqvu8UV9uBt++2owfRkUpiCtu34cgy8dL5fgF9W50ypMHWOS7lLmdUbBk7STOEVLTz+1ead/GK+eaDHQ2oj+ug5Ejw/tf6wDdDp3K8FyuzfZQ8XqOea8VFnEy0f6xwT5cbNsgnzeCojPw6EPtgPeJi29furKhbBaWz1EONnqnFQFQvHacsaqdaA7h/rK8hHRjLpAaFYiweknKZW3gVvbCWrqgocos7ddIXffbvGwHA9hXLwIldOEHiE3N7nXriIQzj4DQugKW39VHp0FOe3yUCd5q23r5lcm4UKjOnjwcLBoYa9USH8DqPPSxnaB0FxHlpTaJky6PYCnUj1+TULVWHlN3JjvN7ipjJSBnWeq3Ss9ej4Zu9oP8RH3W+MWg294u5iM/S8MEwfuFkLeUpVbHs1YYzGW3T3A8jq6dMLmELsKMcIcvRApeE9xozu9hgrJCP60KIGsExg7Yie/Eyb4JcBLb+H1Qjb88rc/CYDtIHUDLn0sqfe2T6YrwETjzBYWnauAMv76XotrJmP1b3Fg5V77tqA0YQ2EbYEnC8LYN47BWfQw4anO3hT0nUrV22tQ7OREwSBIU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ba52e751-4b4f-4731-a370-08dc1cfcea10
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5537.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jan 2024 16:52:56.5416
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dtBBwGuZyIYWZTucMYp8OnjZok25pmQLL3bqKrR7trUJeVZx68JA3FhfsnFZc7frA9raQMQ4uMNXG65hgSP/7A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR10MB5393
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-24_06,2024-01-24_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 suspectscore=0 adultscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2401240123
X-Proofpoint-GUID: mVuB4k_69tFOV_AjU2wmmhaxHjO5XeaK
X-Proofpoint-ORIG-GUID: mVuB4k_69tFOV_AjU2wmmhaxHjO5XeaK


On 1/24/24 1:04 AM, Christoph Hellwig wrote:
> On Tue, Jan 23, 2024 at 09:25:51AM -0800, alan.adamson@oracle.com wrote:
>> I get it, but there is already an injection framework in place for nvme. Is
>> there no plan to improve it?
> Injecting fake I/O error really isn't the driver job.  For block
> I/O we could do it the block layer or DM, but that's not something
> to add to random drivers.  Error injection makes sense for testing
> the driver itself, not applications.

Thanks, I'll look at the block layer for this.  Do you think adding 
error injection to qemu-nvme makes sense?

Alan

