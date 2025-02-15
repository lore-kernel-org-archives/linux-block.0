Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28CDA1624D8;
	Sat, 15 Feb 2025 07:33:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739604801; cv=fail; b=Q0yGwQMWWm7SagN+aRuwA19bX56GJUJ7dHoSI5MeKcDEcqSlfh3JQ2gHnSdxiiyUnRE2Dp5XWlpix/dpcCsoNSkubQceC6PUo4lHR6Lwan+jRNYaduTEmW7HiG01iAJiZMTOoh4uGpZXcd4e9A3BKwzeOOihtQ5IsC+V9OoJOYU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739604801; c=relaxed/simple;
	bh=CN+KIdIkF7iver9nKvi0xle7ZGMm6HHUb6ZfC6phVIc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=OTtnrw2NbuVGcmZbrUWs3ygg/ar5vWXLzxhshxFZ8Ki8lxJ5kpByQ3SwMEJAMgCArmay4BRyjSZEdwKnvKlvVmqApabHLfCLIn6yUpEDoLhRgUa7PquTr0qJg3VThc5QEDGXSHGeh5e08Mwy2FnJSyZDzYF+gaK7DT6mTy/yv8w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=fnUxkmb0; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=hcGtyg/L; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="fnUxkmb0";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="hcGtyg/L"
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51F4TvPf010563;
	Sat, 15 Feb 2025 07:33:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=6RdZqZvUSZN1veKRAh22cVsXFlAXFwqN3O/KiqbnkFA=; b=
	fnUxkmb0Dkk/WvOrlynQKh8XY9Jnt2o//gfUVMt6C/tiLTQ6+FOpED+wQIz1cYn9
	+61rBfm5qLEGK7cNQCJRHweK1PUWzWa0Cp4WK/PyRZ74286MVjKpwOBM7Z2HT8+t
	T2Ylh0oX6zysUno5/EdoO2GrgTJEvsl2KVbSVR8M2PwpUA9aiJlVjGAwv8TPfduo
	8cuaZU/KuN+7wxts9KpmyZOicYq8Xg/6w35EUexNV0oqHJiRBDsjYwgh2GULdMSG
	QhCSmXdFNXfnaJGJ0MKRpOI5MvReTpoZ1vDdLRGUPxrE5+u2snPxElLVn8KaWauf
	fIPqsvBMr2EBqG3ncAlEOQ==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44thua85f6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 15 Feb 2025 07:33:09 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 51F67tCj028339;
	Sat, 15 Feb 2025 07:33:08 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2170.outbound.protection.outlook.com [104.47.73.170])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 44thc5wn4v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 15 Feb 2025 07:33:08 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jF+7ocUSjwZmhjM9yLF7WswBj1SPe+M9qQtyj9OeFNRwGUbB2Y4G9OmxCddTcQcKjoM5cJfKDorjszk4+3Otk3XpsSqRfgty2ta98WjsmPuhfA7o7Z89TgaTCzcbcLjia164T9Ya8jNLCYatMNzyLiHh5rq6zswOFMTiwNiTUoZ1d8Aq6xp2PluDmhCdN/cfx7GBWcRoGn+BjcuTIVKEm14a913ePMxVIR6itt9BHgYx5CfSr1LDwtI8/IgAcFKd4/WTuOCBOkNYBdBNiLl+LqSJD6sTmX+gqxgi4husaqTEOVQdA+HWBTMVpek/VjHLWhcJ00uAS/aYdcZZR/1bgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6RdZqZvUSZN1veKRAh22cVsXFlAXFwqN3O/KiqbnkFA=;
 b=SceT7UuJIs+kab37r6asF8Vf/Aqwk7HWVyNyDEruY2r2pwsZjPTawUo31ahhtXfB3MQsfZrjrVAqB6TuD9xQTRt5VOsA738o5fjVner2P8bH39B71Hrm8VJgWsjFc2GGlnVEW88RvJQVWb3PhwQOkd76U1wsgM5x9fjcdZ2fnGg/shEITqsD55kczZxjHJo2keWE51hkJa5LUViYAf+GAj5UcMAuVM4sFIHSfQcUH1j0adYlCqLFlRQMXYAOjobFoPqlBpCU7QoFOXflZwSUp+2Ejkf3fMED7g7xMjxyzYM5dMqJk4QbX4To6AMAdpdiTqutrxLnN1xwTbx7WZZvAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6RdZqZvUSZN1veKRAh22cVsXFlAXFwqN3O/KiqbnkFA=;
 b=hcGtyg/L6xHhtayZVKmilQ1CZL3j64xCy8tzxR6B01YwcXYifHtHGgZCBdw9XMzFLXqaMO9DEIWvMxSmbYkOqhwFpg8QYa4q5qvu6qoycI2v9GQr90DrL8XGR37qVERKp5JpGJa+nsHkYRva2aVslP0DIf60zp+UosvZdCnM9jQ=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by CH0PR10MB5100.namprd10.prod.outlook.com (2603:10b6:610:df::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.17; Sat, 15 Feb
 2025 07:33:04 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%6]) with mapi id 15.20.8445.013; Sat, 15 Feb 2025
 07:33:04 +0000
Message-ID: <b9c1655a-83c3-4ac7-a601-6f8161cf3c13@oracle.com>
Date: Sat, 15 Feb 2025 07:33:02 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] block/merge: remove unnecessary min() with UINT_MAX
To: Caleb Sander Mateos <csander@purestorage.com>,
        Jens Axboe <axboe@kernel.dk>
Cc: Keith Busch <kbusch@kernel.org>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20250214193637.234702-1-csander@purestorage.com>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20250214193637.234702-1-csander@purestorage.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LNXP123CA0018.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:d2::30) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|CH0PR10MB5100:EE_
X-MS-Office365-Filtering-Correlation-Id: 493a2683-d7d5-4c94-5f63-08dd4d92fbdc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?L3BiQ05lYTR1MXE5QWJXR2lZbXFTYk1KWGVuSDVtUFhRVzJpWVNhbG1mOUJO?=
 =?utf-8?B?d0JESENUdHhIeks0amVwSHF2WEZmWllzNG1ScDZiMUtpSm14b3BVNS9sTWtt?=
 =?utf-8?B?eXVwZHJDOWNCRWQ4TkhrWFFJZm81V3k3UWx5NFNPWnNzelh1MGdlZjVmR2x5?=
 =?utf-8?B?NnVINXozR2RJSzBMajFyeGpMby9xTTJIdWdIWHZsSHB1STBIMk5jQWIrc2My?=
 =?utf-8?B?V29yQXBHdGxjY1MwSzZMZUcwZ0o1M3loNzVMTWNYN3dUT3A4Vk1GZjBBV2Vo?=
 =?utf-8?B?ZjNqRTRhdEF6dVViTnJaRDhZdXJyUmZBeitNTy9LTk1VK3drOVo0SjMvaHpU?=
 =?utf-8?B?eU9TUmZ6Q0xHVWNSOElOcFRYWVd0QlJYd0s4QzFlbHg0WXhQeW9zNkRwTzlM?=
 =?utf-8?B?OUFLQlEzNXJLVHJyWVZDVzBUWlBSUE1KejdGOEhTaUVSVEFHZmtjdTVpSXFH?=
 =?utf-8?B?TE9rNzl5ZUpHZTR4aFV1WFAzQ2VrU0hWcWV5bU1UY1pCZi9YaXdxVnVKdG9y?=
 =?utf-8?B?QUxHZGI1MWlDTjBxY3NoTTFwdE04NExiMHFwQm5JY011Wmc4VU1QMDNQWitY?=
 =?utf-8?B?ZzVVSEwrQnptNWtSRk1WdWdTVC9IZVArSFo5K3VEcWdxVGdtZHk5OVMwcDhB?=
 =?utf-8?B?THdxQnlHRThVd3J5eVBidVo5a1NNcmF0QUJWTkp1NkcyWXgzblc3NDA2Rmda?=
 =?utf-8?B?SGxXcW8zcTB0YngvWm5tRGhnNGJtZVU0TWo2aG5HZ1RsbHc5Yk8vMVhnQTZF?=
 =?utf-8?B?a3FWTFd3VU16WFZGZnlOTG85MURCTjNpcW5oUEJPK0lmdXM2Zjdja0puMmRU?=
 =?utf-8?B?Y3NQOEtIMXlFSVZ5Nzd5NTNmN1BLWWxDMzRmc3dra1d2L3lkMGtXQXJoYWZ5?=
 =?utf-8?B?d0EySVMvU2xuZzFrdnd6RmFySTNLZVZ6ZnZXTm9zNXV6UVQrOC9rZ28xNmRS?=
 =?utf-8?B?eFBCVkFOdUFSaE9PM29Ud2pIMlFWS1YydVFlUFAxNzRubm52QXJaTy9wS01a?=
 =?utf-8?B?dFlJZUM5S1NuWXBtSEYwSWFacEIzK0lrVE4vd3pzd1FqbkhBTWFNNDlkZW42?=
 =?utf-8?B?QnJWOUlNVGROT3oyZWY0VlE5VTkvTlg5TFU0SlIyK3h1eDkvT0dJYVhQcjlQ?=
 =?utf-8?B?Vlc3RTBqOXoxbnErS2dhaW9YdE9zWVV4WUVRNkRiQzl2dm1vclBEcldLeWdH?=
 =?utf-8?B?TUR5aXg3QTVJSndUR3h5d2p2dU8vb1dRRklJazU4ajVyQ3lzWE44WEtSaVRj?=
 =?utf-8?B?Wk1ud21kTXNkbGRmbndMcEMxRFBVK2pZV1VmN3QzeTc4c0lKeklnczJkWUpX?=
 =?utf-8?B?S000YWtsU21NNUQ2TFN3SEdkK0hvbS9KYnI4RXdhVzBFcWxSc2hWeWh2eTMy?=
 =?utf-8?B?Y0xWdHU2enA4VlAyTjB4MzczcEx6dVhEMHlqOWk2M0cvQVFtanRvc0c3N0d5?=
 =?utf-8?B?blAvL0RhdmdXbUtoVkZjUHpXN2luSXdKWGxab3dKTnZ3dnU2OVBRRFFkRTFv?=
 =?utf-8?B?RnlRYnlPSnVuL214ZW5JUDVHUkdVR2ZMS1V5UWgxK3NiR2E2UkZIeHkwek9j?=
 =?utf-8?B?a3ZxQWxUNkcwOTZCcnhBOGpuZkNsN3NYWStvZXdreUxhdWNxdm44clM0a1dt?=
 =?utf-8?B?dDQwcnhVZFI3dmRwVEoxOUhJK0N1c0RzQm9YRmJGSFExQ1dBU0tvLzAybTlT?=
 =?utf-8?B?SG1tQ0p3VmtDWEF2MHNycVZBYmszaDF5c2g0YkMrUFcrTHF3eHd1QmZnTXNC?=
 =?utf-8?B?U3RFZzFneGVKZzI5QnFBTGllMThZOWRFNG1RRnRZall3eDlCSW55M0lUd2hh?=
 =?utf-8?B?WWNlMEhyTHlDVWp4VHFxcDZrbVhuUUMzaGYydHdkdHlHam03ekJmYVJEL3cr?=
 =?utf-8?Q?LCNfchVxjdNvo?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?STJUT3NIUnFkUHBFaytWcXU0TmIzY0N3bVVCQmlhdHYyMmRySlRZTXllT25H?=
 =?utf-8?B?bThNUXhrM2dhak5sbXNadldGelFRWkE5RWpSb25QUVNuemlxMHJuOGxFVkNv?=
 =?utf-8?B?VzRZWXB0M3lYMVErYnEvc0ZpUWdSVVpxcll0MUxidDEvYzJvZ1JsTEpRYjcx?=
 =?utf-8?B?cU5ldlhqakdoc3JxZUFhVDlJaENpR0FBNXp6MDZuWVlUVGtCUG9xZWRIeW9N?=
 =?utf-8?B?dGNYMVFUUnRIN3ZnRDYxYlZ0UmhWNUhmS1NnVUI1eTdiaUNUT2YwbDdCa08r?=
 =?utf-8?B?eFNnTDQ1Z2RHVktMOC85YXZtRmZjdTJwRFYwYTBtRDZ2Z011b3F5bGZ4NDdZ?=
 =?utf-8?B?QndXY3E1UGs4RXdhbjNvNVBRNzVtSmxkaHlTeG4zeGtoMzEzemsrMlB3SndW?=
 =?utf-8?B?SXVSUUZUWktrLzJOaDc2TE55bFZSeERmb1IxUVVBSGVkYUNTQmRpRmtESkxK?=
 =?utf-8?B?YVFzK0xKVkp0TyttK1kxSlFEc3RlRmMrRzVYNi9Pd2oyT2liU2t4bW9yeU5V?=
 =?utf-8?B?UklJays0MCtMVVFLcjlXSVZuN0YwcTdsSlphVy8rT2ZRTExwRWl3VE90Y1gv?=
 =?utf-8?B?RWRVdTY4Z0ZwMlAzRGUwRThNN3I2VEd2VVpXRzNHY1hmTE5CS215eWFNUVJT?=
 =?utf-8?B?bElpMVBzUkVkK3dLSHpOalpTdFIzMGtIb3Bmbzh1MWhBVTFlZWpYL2hQLzFT?=
 =?utf-8?B?TkRsYW1VWGZ0LzRndzJmYjNoRnRuSThEOGhDWnBCTFM2UzVMZkJ5SDJBbjBH?=
 =?utf-8?B?SCs0QXYvYTVMR3duSVR5Y01pN0s0WGYwdmQ0bnh5a05KaUhtVW5iWk5jOVJ2?=
 =?utf-8?B?Tk9CYmJiOFNqOXBLZVR3cFFmR2NydkNDUjF6ZHlZUjM4ZVo0WUFUVHhWV1pU?=
 =?utf-8?B?b3JJZ29rSFQvditVZjlmcFhZUkNpS08wa2RxS2pZZkNoNmpxZlBHN3dIZHQ3?=
 =?utf-8?B?MTJOTURaaVRxa1E5V3M5SVRmQWtULzRqZjhyUERERWRXNjZWR1FXdnUybWVC?=
 =?utf-8?B?K1JPWmErRjN5cmpFdGJXakVsTGpTZjUrcHYvVmpOUkFST3pkdHloYzZEN29W?=
 =?utf-8?B?aHQ2RVAxc3ZrandBclgzQmJNQ3BRMlZCcnlvRm1rQTRUMDQvWjlsVDFlRDZK?=
 =?utf-8?B?ZzUzREpNb0IrK2xqb0dqNWk2bStZUFpBQlVieTJhbGZBV1VWVHVqb04vUUJF?=
 =?utf-8?B?NjhBek9TdGVCcXZIRWV0aEV4a0lRVzJxTHF5NDUyUC9icmk1UjVQN1VtK0Ru?=
 =?utf-8?B?a0lIMllhNld6d2RWTUhwejZsZEU4SmdKR2MzWC9qWGVLK29YOE5jbUl3amlI?=
 =?utf-8?B?ZE1iaVgrVitJci9jOFVzUVM3TmwrcFNRaGFHS21QOXF2U1Y4L1hhY0NkWHIw?=
 =?utf-8?B?a2dJL2xremFTUEpuK3VVL1oyaTE2aUNEMzhZMVFEL1dGamYwaFZlNjVUZ3gx?=
 =?utf-8?B?RVpKU3JhRXZZaHNIaGFoLzZBWUtYcDBZUnhQcGRBK3lqM2tSSlpVeXdmSDM5?=
 =?utf-8?B?RlZwWUhiYUxsOHAxbEExN1Y1N3NXV01aUFU1TDdPNjBNRTNwR2xKaHdQL0U0?=
 =?utf-8?B?a0RCRklSUHRaUVlBQkUyczVyc3lQWkRXOEhSZWhsa1VkaTRESEp0dm9WSWo0?=
 =?utf-8?B?UTQvMzRPL0RUUGUrNW5obkpBNUMyaHk5d3BoZE5mN0d3Qm1jNzFtbFlxNXl4?=
 =?utf-8?B?em41VTFaeHpwNlJGaEtsOG1DNGd3TkRPOW5wdUVHcW11M21wRXc2TFZ4NXJz?=
 =?utf-8?B?ejJ3WlkvR3FxczdJbldZMmhydUNyZ2JlWnZKMWpRdENQcURGWmhnTGFDYTly?=
 =?utf-8?B?RU5mYnFyZTFBWG5lTXRGMmRZWllaZ055dGlWSC84VjRGY0dxUFN1QmNlWldP?=
 =?utf-8?B?NXRRUWVUYUlsL3hKVXkrYlVZSUpTNHZNeXJlOEVTbS9ZVmhpOW54cGxvVUhO?=
 =?utf-8?B?TzdyTG5HSUZ0TXBxb2QzeU9sTE9uZ3lndzZ5VXh0VjVYa1RlblRGVFQ2MmQr?=
 =?utf-8?B?WWtWZ0VRNi9UWXFZa29HUER0dzA0WWw1clJUaFRkQnFmemVyaHlYeUo2UGVG?=
 =?utf-8?B?cktqbDFnSjBVZExpTHhDY0hhSjlmMUVqVkZGd0Q1dHVqSTEwOXU5a20zYllD?=
 =?utf-8?B?NlA0dHRtVzVuR0xFaXJ1WFM2NU8rOWtUaXhoOUpPdTBpMkszMmtpZS9qTFE5?=
 =?utf-8?B?clE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	djCyFIZwIY3jM7hiVV3tdLubSS11vWFyDIRveSxsSPjN2+hAtf0uZc5cetfhkgQJnKqGN29YPf1Q3LS/uY8bH3dJA0Az7glekQ/YEAjp7lMYVfSamZCmR579oEP+SBf7XwEFdtanH0rMJBzL8RqEeIvWaXz2LR4ieX3JhCHLypUnmA+Q3p5wyBohmkskBphnZ3Ffd+dNcKynJUbnn/kAY4/ICGjbulBfIY/6EQvm2FlXVH5a9m9a71wRs/gF+/fX9fInzmKMK4w9q/fcBYnOOoWQlK/bwhqXuawQ6P65KtNSjFJ5rNH4nYjYBGwu/dkPnA6mVM9BqRPFXLb4zcMiyA52GVeWQrkAmg4CdbBcVUjc+m9RmuxdeJjTp6nwCjGojkMi/MteTdBavoEayeFcTlXN5gg+K2sBy2+lEG4jCoaobv8nHaMqsqDVSIDM6+qC62nr3OoIxnLTmA68AcC8mkvgzlOMuJnxBsQx8p7lTAbbzvku4K73s2YwGD/zqgmPHwWa6mX7raiNerrEGVWo0ozp+CKaVyO2xNFH/qlUmdxlxU2eYKdKafJX3z94jjXSTShOSwHGosUzQPYfCB4tQ6da7XINbVTBRQvXVDdIZkU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 493a2683-d7d5-4c94-5f63-08dd4d92fbdc
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Feb 2025 07:33:04.5156
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HVZehRysXjPUfnWU/TtMdd6+i7psdVOX8F+PGvgfZBZGsyB3GxCKyO3TwHBzsn0ns+++pcvODQNMf3d1saPYzA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB5100
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-15_03,2025-02-13_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999
 suspectscore=0 phishscore=0 mlxscore=0 bulkscore=0 malwarescore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2501170000 definitions=main-2502150065
X-Proofpoint-GUID: 4JTTwflyZthy73IsPZgqhp2QQHnicG6t
X-Proofpoint-ORIG-GUID: 4JTTwflyZthy73IsPZgqhp2QQHnicG6t

On 14/02/2025 19:36, Caleb Sander Mateos wrote:
> In bvec_split_segs(), max_bytes is an unsigned, so it must be less than
> or equal to UINT_MAX. Remove the unnecessary min().
> 
> Prior to commit 67927d220150 ("block/merge: count bytes instead of
> sectors"), the min() was with UINT_MAX >> 9, so it did have an effect.
> 
> Signed-off-by: Caleb Sander Mateos<csander@purestorage.com>

FWIW:
Reviewed-by: John Garry <john.g.garry@oracle.com>
