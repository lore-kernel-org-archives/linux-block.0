Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EA0414AD3A
	for <linux-block@vger.kernel.org>; Tue, 19 Nov 2024 16:37:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732034269; cv=fail; b=P74z151TtyCJljnEJgc4GF+vxXqlTExJvDzeTE9bh4hfIcmzuipKIzZdOlt5vXCIXnmtQk0gAeEzAEX/Kx6outZ5JjlPjhTWhuE43yHZnkhU/AkyOo9eWrgukaTLb/pkcjpfeCoAyzPFSmB4TbaXZ3t5NaVyj9AsCxUhE0eCD7w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732034269; c=relaxed/simple;
	bh=o8gwEQdZn2WDlrDROI4OGH1QlT8FbLKbteTWv70gmD4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=WyJz/l1GDAZNb8sYUvXqVunnNas2+3g5d4dI5Foa7fJTMw33lvmCsd/Sf+bshAH6DaJ9GXX6IfxGL8vv9VNtDBzLc/XmW003WecW5RaoY7RMhWeK20cYTBlfxLeaNErNut4srybdPIY2PIrByVtER5IQ2ewfYuQMSPn0oTA/oFo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=UpzLyyNs; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=cajQtU7J; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="UpzLyyNs";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="cajQtU7J"
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AJGO4u6026714;
	Tue, 19 Nov 2024 16:37:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=d6lDPn6HSo/ApEk3ONsdKt6zpmbvsvPvyIGepk9q6U0=; b=
	UpzLyyNsdU0HSinG6qDgBGsIVAm5sOa83Avf2bPaObIL6ViDbnkix+zhOpAFND2p
	41UK/NIZOU7g5oDOQeaQNUSE/itsIzHg9QhNvNfczatcsAkE+p0GND88NjtfdvvJ
	fpkhILv/D9+y7YvTfoQs2PflwQn+XKz99pD44mryFMTfGGTM6aoUDKXUNbT9n6hg
	wYCDpVe5Q31NmdtHgv4HnkXGYXewP7Qzt642RBzLgaucSdZUhuJ0URL8zxJzPWD6
	5YbqSiUjcE+3Ch6qNzKl74akXrbxRsA3X1F9naZn5W7FV5AYI9FoFxuEipEPMFzM
	geMcYwWZlL6MfPm4dGIODQ==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42xhyyddda-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 19 Nov 2024 16:37:44 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4AJGF0uN023137;
	Tue, 19 Nov 2024 16:37:42 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2047.outbound.protection.outlook.com [104.47.74.47])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 42xhu96d05-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 19 Nov 2024 16:37:42 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mv4Rd7WMlpDDJfE9mtlM6XeGgEMXPhZ8LR/dt97GR8u3kow2wBWmOPUTqsw4/BliUrPxlbpKeK6yJPx44PuUOi7Krrfj4qSq0YaWxTK06TYH7WqxJWNLPBMKm30b6CWWBb6uMRkCbkd9j7bqjjEdUpfgN6YPEhGL4Yd/E+PUnyyRm9jQOOrKGtUbM0KtgKutTxobuP7QQEjTa+IKy5lkuhwa7OVPR1Gqb3tR9gF5y2PvM+i8rETWg0TTJKbFSbARpsyCwo6RIgiX5I9a5/KMP8LF73lA+SYKKcHWEbmpKFlSkk/jDsuBfWAqQcM91qWSFcrMKRayj/jgCDyA4UYofg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d6lDPn6HSo/ApEk3ONsdKt6zpmbvsvPvyIGepk9q6U0=;
 b=Xuap05bpYLhqi/fHeDFblj5EjehZc2h/KBxVqMIjGBLnxyowukPiPk7bBTfhrXWG4Q8RQPG0pfIuCPDjDGkXXMHG4hWBSAxBlbWe0fzF+S9ylorMSGykMv0wxw/eL8JZW9r0lRFfYvZV8f19xmC1UtCAC83Z7/JaArj/HsV6d+ez+Dyd1VKAfkePIZ3DpQYcQdHSdX8P/0O1wvSxuhI0q8H86D77SBY2blRfx7zttmyr+yPhsmrH6xN8qRl1gwJh8a5JJNHm7t1rd2B1uixnmJ1Zu67/SiOULH5VhmlsWuqKArnKcdqYJ7zOEbU2Im7hgEZtAfWwJM/4fwdDrSvHFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d6lDPn6HSo/ApEk3ONsdKt6zpmbvsvPvyIGepk9q6U0=;
 b=cajQtU7J8MoVECt2HnrMxcLpdW69GWyX24DUjJgCNT57b/cd/saEuimOXLLcWCD96ogEvbZYYGBi6oKoGi0z1+WQeW2d8ZEF/x3Ddomb9iyV0Vn3Wm0m2Mo/tW9BUM77WfD47fvM7VsHLtkYopnyqKo7n5oNk/RgXLlT9JOalP0=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by CH2PR10MB4135.namprd10.prod.outlook.com (2603:10b6:610:ac::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.24; Tue, 19 Nov
 2024 16:37:40 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%5]) with mapi id 15.20.8182.014; Tue, 19 Nov 2024
 16:37:40 +0000
Message-ID: <9e9679ac-bc7a-48dc-8e15-86e09ba8e6f9@oracle.com>
Date: Tue, 19 Nov 2024 16:37:38 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/6] block: return bool from get_disk_ro and
 bdev_read_only
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org
References: <20241119160932.1327864-1-hch@lst.de>
 <20241119160932.1327864-7-hch@lst.de>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20241119160932.1327864-7-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AS4P195CA0054.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:20b:65a::14) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|CH2PR10MB4135:EE_
X-MS-Office365-Filtering-Correlation-Id: 5fb03da3-3ad6-41ff-984d-08dd08b87c0e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bXJNMlpvM29XTExvVzMrU0dkMmJ6a1hqRElUWWZ2Q09ZUE9NNmdhSTBaaTNS?=
 =?utf-8?B?cytIRmNJMnZqZDVTRk9EOEdjSnZBZXl1MUZUSmNNbktTemI4VWErMmRLUnhH?=
 =?utf-8?B?cWt6MldoTkNKZXRzMzNxNlhmSnhxd2JyMEZUajhvY2Yxc1lUUVlFMStrTnVN?=
 =?utf-8?B?MjlpQ3JZM2ZuUjZVVUpjNUpQdkY2RGo5ZXIxa3BKcW1LYTFmcDBOa0dzY211?=
 =?utf-8?B?RnZWNzh4Q2tvRXFRTUR4MVhBd1hJenJoVlJsT0lqYzhZU09zRFBjT1kvdmI5?=
 =?utf-8?B?Q1ZrUUpTZkVZeUJxMjVUd2Rmc1BUa0xNNG9hVGxaOTJtOGJWUzdYRnRzdGhi?=
 =?utf-8?B?bVNtZEpNZDFrMnJjVWEzYXllc1lMZ2huR0J4Q3dvMmV1NXJtUWpUWmVrOHQ1?=
 =?utf-8?B?bDFaZ3AyeXRGU0RhSjArZWs1eUlJT2pvQUw4S2VSMEJ4QzBHa25TK0VscjNm?=
 =?utf-8?B?Zm5xSTJVbU9yNEhldWRNNWpmcFhzWkNJaXVLWGZ0clFpdWtYdmE0UXJqTThS?=
 =?utf-8?B?YTUwRFhoYUNiZlN2ZVB0SW5NaVRJb0taTjNBUnNtNlAzUjJTTnZpU2N3MDVD?=
 =?utf-8?B?bURpbHRRU2xmalUwUUlQZDlLYzdDV3ZiRTRUOGJueUorcjlzQkhhWVNVWlNX?=
 =?utf-8?B?dWloTmNiVVE2WU9mUlZHNmtSQ0lrOFdYdWlVOUtkdW5nVWh4Zy93UXFRTWdK?=
 =?utf-8?B?RUdjWnBiYS9qVE5SUXJmZExjVzVTd3hjU09hV1pwTFFHSlJuY1ZKSzVQODBz?=
 =?utf-8?B?S0NoMUx5NVVDSXUzYVRTbGhqZjRsVUR4MXh3blBobWVtRlBMbTljbUdsb1Fv?=
 =?utf-8?B?ZUp6UEpBWHhBNDU5OGgrV1g5L2ZIWEIxK3UrNUNOQWsyayt5eFZRY3hvYytr?=
 =?utf-8?B?UnlaMFpMWkVBQ0VrYk95Zy9YT2pCV2xIK05CSWt3SG5KUDdVbWxhYXhxWldM?=
 =?utf-8?B?c3h3akt3VzV5TWxFSTBvbXQ1aXAvZXdzajhkTjFhRHZvbitjSDZDdGtpdWp3?=
 =?utf-8?B?Z29zOUc3czdVcVlaUkR3eWdsZVNMekwzOHl6TC9QbnJsdEgyLy9pZUZtSHVq?=
 =?utf-8?B?MndLakJ2L3ExdmxCVWVaTHFnaFVQakg2K0V6Nm8wYWZNT3JmdVZxUm5KQnB0?=
 =?utf-8?B?ZVN2RWRVZGpmcHNkUVBZZytobys3YkxyaHF5dHRKbS9saFoxanpMTm9XN0tM?=
 =?utf-8?B?bGFidlN5d1BuKzRwZDl0RVYwdlE2bG93d2U3N0t5N2I4dWdQRW8zVzl5WlJL?=
 =?utf-8?B?dklvbngvb2FudUpZby90Q2tJemk1WkVwUnNkR2hURG5BaCszNC9zUmUwUUlQ?=
 =?utf-8?B?MHlOTlJSdzFuamVuZkFoTUlXd3R4c3F4UXRTMnFxY2NqTFA2M2J1Zkc1Qm1p?=
 =?utf-8?B?d0xWU3czNkpRMmVHTFFnMmJrek1pUWlaOEFKazhOcWlsTU1XQTV0RlVRODBD?=
 =?utf-8?B?QkhZVFRZYmJqVTlvYlNpNjFiYkJXa2NRaWpmS1UvajdmUzVsT2F4L2lUU3Ji?=
 =?utf-8?B?Q05NYmtyQlhFcnM4SDBxVXp6dGNmMjdIb3RoWFVPbXVWN2g1ZXlITlhlRU0y?=
 =?utf-8?B?WHlEaTBnRGlRdUhYOTM1NWlSUU5pWmc5TXZseXZnVWlQbkFhN1MvOUpRWlVV?=
 =?utf-8?B?c0FWN0o2ejBUeSswWkFvdlhkTTV5eEMydWdjZ0JWRDVLUVkrR0p5MFFGU2tD?=
 =?utf-8?B?RmNWLzQwczRwME4wbGV0R1ZWYWg2cGk5SkIvdlJIUG5RSUt6MEQ5cGowR0ha?=
 =?utf-8?Q?/HVJsA5d610zEyE9bmB4W99L4Th1XMglrsCs6Dz?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?K2xwOXBhKzFkcERpSUZIVUVGYWZOOTUweHNqNlJ1UVdxbHhHbXVWeWorVGJ3?=
 =?utf-8?B?eDlIbHhPM1NlaW9TdFZoOUVKSlFOQ0FqZ2Y1N1J3Skdqdk44UEZZOEovY0VU?=
 =?utf-8?B?T1VXMWpNWm1MOWdnREt4MFhFVm5lK0FaeUd3aFpaendoeWRMMWhHYkNvM050?=
 =?utf-8?B?SlRCSSt0aWlTcytyc2J1OXZRaWxlMmtyNGhRV0Zpb3VKblJRTERCb1ozbjVX?=
 =?utf-8?B?Yng3MHJiT01rVllINlBOZ3JhZ3hqQ3piYTFheUVjUEhEREdXS3JGTTFIK0tL?=
 =?utf-8?B?aGtVTnp0WWhDK2MwalkxL0xJRi9IOWNuVDNqWnRuRU05a2pSWThmS1hjNXpE?=
 =?utf-8?B?ajVsL3N6bnNMRFh6c3ZDcDNiNUh0clZPRFoyamcwSTB1MURnVlhNR2hKWWtl?=
 =?utf-8?B?cG1lU2NEVENRMmUrQ3J6cjRtU3NDV0xMTjNFUnRQbFlNdXdiN1k3TktqWGdP?=
 =?utf-8?B?Q05UOGlLT0tjcythQUQ3OXJMRXJucktTUjNuTHRpTUIwMXZSNmt1blUrS3Zw?=
 =?utf-8?B?MFZ6Q21KaDFJSE1sL2E4bzlRUmR2cDRvUmJHSnZKRE4xdkhFaXJXbGFCWEtI?=
 =?utf-8?B?OFYxMTFHRm9zU3l0VWZ3Mjk0TTlLSTkxd0RSM0QrN3R6dnJpemNwamlXRjZY?=
 =?utf-8?B?RUhYUzFqcGtvT3BsUnVQZDR4RFZNNElRYSthdnBOTW1UbmZNYWtmNXkrazZS?=
 =?utf-8?B?eDlLVWo5Y3l4Wm5JSHlKSnoxK0duWk9HR0t3TWlhdmlYZmg4QzViS3JpdTcy?=
 =?utf-8?B?UG1vcFRQajdxTXZGZHJXL09Yd2p3YWUzY2E2eUNQWkQ2M05lam1HNnBrdklk?=
 =?utf-8?B?dGRPUzhkR0dVNDlJM3Q0ZVhZdkZ5RmpCaWYzY04yaWVWZnNXVmdqcDdaZkdC?=
 =?utf-8?B?T0kxSHBoeFdHZ01QL0J2cDViZnVDdnVBMUNpdDJqYmdWYXNiWmZLdm1hL0Fs?=
 =?utf-8?B?MW9jS3BSQXI0VitWbnlKWm9iTW1GRnY3MWNFREFESGVXaDBHYVhQS25rbGZm?=
 =?utf-8?B?cW9tNkRlL1RLQ3ZXYjY2TzNmYm9QNGFVT09PNW5hWEZrMWtYeC9PWnM4dUUw?=
 =?utf-8?B?b0Z4UkFNdGRoV1A0aENPSnFFMHdXcFdndHc3UnFiZGRTZ2MyNGRNcEpWNWZv?=
 =?utf-8?B?eUZHWXZyczZjRTVGdHZFNVkvT2YrOWxRWndqSU93dzhObWRHKytjZitrSW8z?=
 =?utf-8?B?ckh0ZHgvNUM3NmtmSmxXNm80MTV0R1hSV2I5d2xmSDRVc0ZrTEFIWTdkT1dT?=
 =?utf-8?B?RkZrTTIxMnQ0VEw3aSszeGFEcUVrNklLdWtRYlJlUEptSytOZ0lmS1IzQUdn?=
 =?utf-8?B?bHJ4OStrckVsM2l5MXFNbjQ5U3RtVURDZDZEWDJKcENYZER2SWJ6Rmx6c0I0?=
 =?utf-8?B?ZGM3N0d2MGQ3Vzd1NWdEQVRLSDBiQnFiR0FqN3RuTGN1djEvRzloVTc0dDZN?=
 =?utf-8?B?d2x3WGs5bzBoK3ZqVDM5ZFI0VFhCME91WC93R2oyUXpjK1VjaUVCbWwySW9i?=
 =?utf-8?B?eWVpeERmWkJ3ZEFEVGx2U2IxYjUwdU1NcHRPVEs3MElBOE5RejFwcXdNZTg2?=
 =?utf-8?B?K1c2OFRnc0k4WXVuR09qYms2VzZUa2VyVEZvUFR6UlhBMnBRYzFSVlltcStl?=
 =?utf-8?B?WDVEZ0tnbi9LWnltU05hQk5mQkplMnl5VTg4czF5bVhBTTVTNzdYRWc1bkMy?=
 =?utf-8?B?U21BYzc4TGNLVmFLVXBVV0t5Vkc4VHpBNnYxTDIwNUI5NW4yV2VxdmZ4UnR3?=
 =?utf-8?B?VVhmWXZkSGxmdWxIcndsRkVxaHRXL2xQTWs0cWZIbE5mbEZwUFFRbWhveEVQ?=
 =?utf-8?B?MUY0TXRaUUJ5dklKaUJKNVNkb2Z6bEoyUnB1S0wwdGV5QWFMbDJiVzNyb0p2?=
 =?utf-8?B?TE11b3ZXT1JJRFZNamxkTnR0Vmxpbko4ZlZOWkFWUkJTTVRLb05yb0puU3I2?=
 =?utf-8?B?a2QwUWQ4czBRY0Z2eExEYzlCcFNTTWowNk4xYUVmWkt1ZUk4dWNHV0dOSFFP?=
 =?utf-8?B?SlJpY1Jpb01UcVk3cVBMYVBoTkt2R0l4QllES2tNMTgxUi9zWG8vaGE4emxn?=
 =?utf-8?B?UnBCeDBVdVphMFNISldaOEZJek4rMEVZM09iNkJML21UbW1PbUdjUUJ1SHRq?=
 =?utf-8?Q?N3NxO+UrISXaVSkk+hL91sW1F?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	earExdK406aJO0Ao2m/JHCWe89yRVSadhZjeRrz+mm8FU6qqJ5PQ0RGxJi2+yMOFpRxbVMId+J1wyrkzSdakqtz8AvA/gQQR3Qk5noa1Q89Zrn9B7uynzTh1FeAuqAQFmhuh4KNOiTEIUKfGWDPGf+f0edBE8RN6vTWKHd8CBXgqlnFHJR5/A8KWWq1TosUGgo0bhObrvm4MoWYdhH/W9nVUga/N9S6yS+cmAoC+h9Q9e6MoIqnBNSNUPPF5NF+FXSL7Q2PIqXCjbFuimrCNTEAAVbYVy6VrpMFq3J2lNL5hGLvVzvBofDRvRDhApq2hOxayOqp0cN1XDCktCJvYelIeeMOlUfj2H+W1V8QMHFQVdRB19riRkee7j9jqYYM67bpHN/BqOBKPiw/t0XCy350K1pMoP03DRXoGgsZlblwElBcj6J6THr3RLSEt1JEwo/OIt5JuElAFQTGGqvvETkbcg7B6lnu8i3KrAwpwEVWiJvCjmtksEHmU4OIF4v6fH8sY+TyBcKw1NCFMwt+yITmZtdi8uBPyCnp1yIR3U52U879cCs5nNvv6AOrF9gL50jnPqGy5R93k4DLlhegOrvc7CGn/Asf6eGTgD56n8TY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5fb03da3-3ad6-41ff-984d-08dd08b87c0e
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2024 16:37:40.7380
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UZgCPeZbwXssgHs1P7OCx3Yz+BsTnWs7r2SLHVgDhAX4a7rIEsDWzPynhsw0NC5U6YN7m/fl2XnmMges9PZeOg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR10MB4135
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-19_08,2024-11-18_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0 suspectscore=0
 phishscore=0 spamscore=0 mlxscore=0 malwarescore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2411190123
X-Proofpoint-ORIG-GUID: UtVhTPSBqQFsbkjSOIQPi_QFVDeKMFyy
X-Proofpoint-GUID: UtVhTPSBqQFsbkjSOIQPi_QFVDeKMFyy

On 19/11/2024 16:09, Christoph Hellwig wrote:
> get_disk_ro and bdev_read_only return boolean conditions,
> don't masquerade them as int.
> 
> Signed-off-by: Christoph Hellwig<hch@lst.de>

Reviewed-by: John Garry <john.g.garry@oracle.com>
