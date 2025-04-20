Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2044.outbound.protection.outlook.com [40.107.237.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 038408F54
	for <linux-block@vger.kernel.org>; Sun, 20 Apr 2025 08:41:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745138519; cv=fail; b=RE3Ck1dd0rqUNECQd87AvY4YHrk6tvJ9xTGOvyR47y7CNZSg3sAy1hZxBiD+xxTW1yRIp1VASiYYZKecBw4hAPFZ+zhV+KLoj0Knb4GhiR5lQFvsoV3ntIx1qN0fepXwM/T09Xg1sat7FX8283+o1u5CRpE9yqRo4iKNVCnGI7E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745138519; c=relaxed/simple;
	bh=XPAYrKhnq1X6mWOOlaS8x4xwccl/pNJ2TRvD+M8Nquc=;
	h=Message-ID:Date:From:Subject:References:To:Cc:In-Reply-To:
	 Content-Type:MIME-Version; b=iQd2WFk0cnm8uVxn2DEUGZ7lhdmsSPlYwjDb2XVRs+C9lgqwrDgzP5bgeb03TkbIxLw13efm6hQ4oNQ74BHLkbstT/AdAeoj22RCd4f0qRr4a0MLy9P5bdZAkn8WNN5r5r21qwFGbmR5JZCU6Bf57FmQn2qIQ9Ndm4Kf3whOj2M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=utE6cxsm; arc=fail smtp.client-ip=40.107.237.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="utE6cxsm"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ehmCAHIbEEnbwBcjXQRiQHdowqPIU9KT7BTTgdaeaGDOdNBs6E5GzdMdTGMSv7X5IvZ7cTJhXmC8zLm8NR7RQ+/S2HsQKC1ab1ZZcEZ0sAtaevHOvZO1ZZMpALh3gAAVDXUcuDroYGhn5hDl9FJCnyesA0eJB2hWwNODy1bmdp7CvAzkP9LcvUankFnk2qqGu38e/Uuf09RUOynwr9h6C+H2asBG1sE3HCW92JvspzsiI6BUbJlCUWze0KL1R1GdEMPkN4aosiJSrf5CRv34KvUtVndI2A4EyOg1FLsxrQhnjYY+jMljRNLsmHgY63ZAhJy8j/IenTCvU7/dD5ImLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=comq6VLZZjM/QzFv43csMszmcFYMsZd1Ix2CLr0cooQ=;
 b=bZGcySPDMQmJvLQy5ZM9/LjO49no7nA/ZbRIlMDP8bW6P3h3Iqr8MVTEbK/poxO0KaFCbjC5y3jtyHzh3RcZcTzyTiVRjFljSoS5Qf/BDtkNJ0jctTGYNmPyj05m6oJ851efAYkQcbewv3zz4YeH7/p1X3ofYeb4aA35xNQZ/o1jKQ588tiLaAc1pcS5Ft3gFDmM1Kd5Qt/2keERECxPhAnQXLejkwklCOTGLBQubCZSMvb5iBc0/G88pfpoJiryEFaHwa5rQt8kTQp8BYe8HZOmQrs2eRc9EmojnK5FYvMaQ22YKxj9RPm6m++Wve2/5Y76Rl6gIeHEBXwJT0xfBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=comq6VLZZjM/QzFv43csMszmcFYMsZd1Ix2CLr0cooQ=;
 b=utE6cxsmXbzAxlL6yk+NJoqQ3tob70xm2JqGAhomlmy/zwDZ1II7gfIfePMe9qdbnJGzgtcl6JAZSTw007UTSfOrP123GDE/CHa2ab0aWwceLWFz/eCdhXrPVzi3AxH3HKiPDUqh69oshBeyrpB5DMUbLEQICgr2Yc60m0Z8TZ2Tq637Q1M/y6aTJ5vVkCmQyfKMNLiVWQb80ijjmnHr2Vpp0/TaEMKVpHeRCEvVwxpJ1U+7mxCCuAG1PiQ9cCAjo6eiqMWDRwn+fQP+qLPMqu+LO5BRUyLxvHOYdebtH9YZM/wnxpF8ZFQE17JZUDVjiuIvtbuto3Cycgjk1AASMQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ1PR12MB6363.namprd12.prod.outlook.com (2603:10b6:a03:453::9)
 by CY8PR12MB7121.namprd12.prod.outlook.com (2603:10b6:930:62::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.25; Sun, 20 Apr
 2025 08:41:54 +0000
Received: from SJ1PR12MB6363.namprd12.prod.outlook.com
 ([fe80::bec3:4521:c231:d03b]) by SJ1PR12MB6363.namprd12.prod.outlook.com
 ([fe80::bec3:4521:c231:d03b%3]) with mapi id 15.20.8655.031; Sun, 20 Apr 2025
 08:41:54 +0000
Message-ID: <54c01128-1536-4919-be86-9c655dd7adf9@nvidia.com>
Date: Sun, 20 Apr 2025 11:41:50 +0300
User-Agent: Mozilla Thunderbird
From: Jared Holzman <jholzman@nvidia.com>
Subject: [PATCH v5] ublk: Add UBLK_U_CMD_UPDATE_SIZE
Reply-To: Jared Holzman <jholzman@nvidia.com>
References: <20250420083612.247622-1-jholzman@nvidia.com>
Content-Language: en-US
To: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Cc: Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>
Organization: NVIDIA
In-Reply-To: <20250420083612.247622-1-jholzman@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TL2P290CA0024.ISRP290.PROD.OUTLOOK.COM (2603:1096:950:3::8)
 To SJ1PR12MB6363.namprd12.prod.outlook.com (2603:10b6:a03:453::9)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PR12MB6363:EE_|CY8PR12MB7121:EE_
X-MS-Office365-Filtering-Correlation-Id: b541cb6e-d44f-4c45-80f3-08dd7fe733d9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bWJzOXZNNHdXbjJWOEdSWHAxYVNvblhOMkdXbzhiYk5CczNXQ3IwakFRbXlG?=
 =?utf-8?B?U2hRT0FzazZmTkd2SVo1aUx2TmxWeGI4aGcrSlY1UHRLVEFwLzJPYjRseVJi?=
 =?utf-8?B?aTk3VmM4QndVUW1pWFNsdmpMdG01YzJGZmliTWYxblgrRFo1M0dFaWo5RlVI?=
 =?utf-8?B?ZXk4TGtXcDluRzM1YnM2MjF5ZlFGZjhkeGpIWlBIYmcrcmxKSitpNU9DUmlD?=
 =?utf-8?B?NjdBT21PaGNNMk5GcmZTMW1PRkgvRG9admJGTHZNVU1XNHF5NW5kMWtTb0lG?=
 =?utf-8?B?c1FXNkIyRmtRSHgwMFhXQ1pqWG0xZVMzOG4veGlpYlZjTzB0N2ZQQUhzdmUw?=
 =?utf-8?B?cHBJcTY2WjFyRjQvSXpSRm1PNWovZGx1WHdjQTRpMTRUek5XTmFtYW9nWVJj?=
 =?utf-8?B?NXArNHZxaFY1SjFnNm1qc0xadkxzaHJOd2NENjdxR1IvSStBcGM1eDBXN2Ny?=
 =?utf-8?B?KzV6V2lnTkdlSStRU3dxaUIxcDQvNkpXNFd4MGJvaU10TmpKcWFoTFoyK2pH?=
 =?utf-8?B?MDY2eDkvRzhSbUZKbU9PbFZGUlNob1F4b3JwVWZGSVRudmVIa0gxSmNvUjRI?=
 =?utf-8?B?SXloZk9POEhNa1pMZmdnOEdmcjc0VmYxTmxDanEwenNMQXBMbUtUbUNIWlla?=
 =?utf-8?B?Wk9MODZ0RmQ2OW9Tc0NBSGRkdUR5WjFVT2ZyTENSYVZ6bm43YXRrY3VsTkpy?=
 =?utf-8?B?Nk5PN2I4dTVTVlA2VmhWelY3SkpFKzRQRmU2M0pzdFdFbVJyZDJiNHpmd3hE?=
 =?utf-8?B?QWZkMlFIK3dDbDhRTjA2VXhjckx5NUJUZm5sT0svQnVqUWJRaHB2cFhvdXNt?=
 =?utf-8?B?ZzUvSm5sZk5VbFJCelQvQUNzNHFFOWY0YUxabk1BeFBOakw4Uk04eHZtYzVF?=
 =?utf-8?B?WUtDWlNDalcrMXlOSHRNeUF5ZFBKTC9MQkhJM2p2YmRhYVAvSThUREtRUGxH?=
 =?utf-8?B?V2VkK25KcWxCNTJJS2ZCVldLc00weS9UbWUrcXcrcGQzVHc4VlZXS0h0d2pV?=
 =?utf-8?B?NERsSUFtVHJHSFoxTUttUWJKTWcxRGZCZnlwd2hCcCtqcVozL2FxSWhsdTg2?=
 =?utf-8?B?NEN2Zm45QnNjWVVFckJjb2F5TmFsTWkzZmhWbDJKang4eXB3WmFEZll2SzZi?=
 =?utf-8?B?V3UzTEF5aUIzdkxHelJkdFhEZzlPTTRRRkRXY2NXUHJCcXRwRFMzSURmcEEw?=
 =?utf-8?B?Mkw5NG5YS1JreXBneWxjSUZZN1I2VFdsT0gzc3QyMWtKQ041eStMOVlYRTdi?=
 =?utf-8?B?SkNucGhKbUw5MmpGaUhyUG9mWFNxTUZLMXZiTzRSaTVwMEFvL1d0aFh6WXRz?=
 =?utf-8?B?LzRUdjYxeTdaWUxlNFpLS1hWYlFSVy8vQjY5TDlWczRoQ2grYnpaU2ZrWThO?=
 =?utf-8?B?ZHZnMG9meGxOcGpaSnlkekMveWx3NSthNzd5eW5iK01YQnFoN2ZDbkh1WjlM?=
 =?utf-8?B?L1lsTkdoeW4zTEF3V2ErYW4zd1NOby9pcEdISlpxUkJGZ2dHUnp2SGJ2Y01p?=
 =?utf-8?B?QmxXMVRKTW40R1NJT2pVdWw2NUJ1VXhidS9QeU9UYWxaR1g2ZTR4WHc1d0NS?=
 =?utf-8?B?c25sZE5SR1gvNVpHZElsQVFwRWFlblFRZ25RTmFrdzE3RXAwcDBGcVdzU3Nk?=
 =?utf-8?B?dmprdkwvRWpKbEtKdHRPdGFBc25TS2V4Q2hhWnhRejBTcDJlRFM3SXRpWXJY?=
 =?utf-8?B?TVpCaEJyd2J4MHRZem55SXl2L0pZOTJmeFMrSk1sZE5DV1RkRjRnVHZGSEl6?=
 =?utf-8?B?MUV3bHJFOFlmd1FHYVBoNzVDWHJlTE9JeUIwMm5RVEcvUmQ0MXpRZmtHdHZK?=
 =?utf-8?B?b2Z2QkYza1hOdk1lY1NHR1JSR1YyV3FCTzRKSHpmYnc3NUs0SzFzUzk2M01K?=
 =?utf-8?B?WU5xbWxtQlA1NmVobk1pdVowUmZEWE8wU2FrZTk3OTRGLyt4bnlNeW8yVnZ2?=
 =?utf-8?Q?y1X86UDV18Q=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR12MB6363.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?T3VENGNHTWdjMFBJMUpIRTgzN05tTjg1VGJ1aDRGS1l2NXBRamNHL0tHYldK?=
 =?utf-8?B?MU9uVURSVGVIMDZOVlN4b2RXUEt5NzJpbVU0dHVhRXUvR0NDZGVrUUdHTGkz?=
 =?utf-8?B?ajJ6YTVtb2h2L29Bck1FM1ZYMWZ4QUoxVTFwSVFlZWVuTzBEY2JsaFlKOW11?=
 =?utf-8?B?ZHFiKzc5N2NZZ0tFRHkrZVllS3E2WU8yRGpYN1AzdEdMcnpRanZsbTFUaXZU?=
 =?utf-8?B?L2I3VkFCQmkwRGgybXhjZ05vakpsQkdhNUd5UHZJN2pCcTVrVWo4blhJTmZa?=
 =?utf-8?B?YmcrVmR3bWhDVU9SZUQ4dEJ6bTg3d2o5NnRUQzR6K0w1cnI2Wlh2YnlvaW93?=
 =?utf-8?B?ZW5SSklzYUI4aU5qNThDWWFrVjVvVlNRQlpzaEZMSkNiTEhmNjhjZyt2Ums3?=
 =?utf-8?B?RU95OUtMSDBTemJrcTMxbkhBd0NKLytCWE9VZW9UZXN5YmgzaVV1eVA4NlN6?=
 =?utf-8?B?TS8vTEJPSmtOUG5SSVJCNVdjVXlmVVh4Ky9OUmZxck5ySjVVRGMzNk1uc3BO?=
 =?utf-8?B?eE43OUdVRmdRYmFUMm5FNFJFM0MzVVRJdEdPT2xteXl5WTI5Rm03MlJQWDhW?=
 =?utf-8?B?OXRLYVFBS0hqTGZaenNUVWZUVDg0T1Z0MUNyNVpPV0w4RStxaGErMXJGUW5M?=
 =?utf-8?B?OFlZR3ZWTW9lY2JUbG5jQVVOaFdMd0cyMkRsalJEMnUvZUJSV2diaTI4MU5p?=
 =?utf-8?B?MHZNckd5ZXRTSzViWUFwT1hnZks0RWhGNmFiSXR6Z3Mwd1N4Ynl6a3M4eUY0?=
 =?utf-8?B?RGFzMVAyK1VUbkx5Y2FsR3BONmpTbTMvL2NPQjlHTDAwYmJBcDNpT1ZZL3hD?=
 =?utf-8?B?N0VrVkpRZWE0dXU3V0J2TmM4UkIzSHdiTU5zYmszcW1HSDFJN2NTbTFIazhG?=
 =?utf-8?B?ZGdNNnZhTEdtbGU4ZHJ5TUtxUkpRbi9DeTBONmJUTndISFFVZ2U4dG1Tc1lF?=
 =?utf-8?B?eXArRkY2V1VjbFY2Y0Q1cURQcWRYeHhFekhmajhvMTIrZFV6SEdxbEhUSk4v?=
 =?utf-8?B?TGpuenpjTWk1T1Q1cm01VE9ZUmtCSjZkZ3ByUHVubm51VTMzWGNOVi9WMXNn?=
 =?utf-8?B?RUppSzFiSXNud0hySHpicEJDb2Zmd2VpM09BdkVjQWpIa1dqWmJkME5yMlVz?=
 =?utf-8?B?d0Z3RFFlUEZhUWdNWmFKUS83Q3o1bmovRE5IWGpVQjdwUjJtcmN4WForTit5?=
 =?utf-8?B?Y3NTM1hWS3VIR2pqN2dJa0grbmRtb00vWTdiTEdiekx6bFdDcUJtN1RaWndV?=
 =?utf-8?B?TjI5RWRPbC84V0Ewem1kWVVZdmFodGpSaVVKdjUrT3BkV3JZaUxZNEx4a2dr?=
 =?utf-8?B?U1Q0N2xuanI3WWg5NHhKazVMTnNoSFJzdUdVSnZzT3VpckVxcUVsSExIV1Bq?=
 =?utf-8?B?TFJucWN0d2xkQWdlbUwzQU1yQUVJVWpBNytzbUkzdWZyeGJwaXVsQUt6LzJY?=
 =?utf-8?B?WVQ2cnlwK2NzOEFzNGVBRXl6TnBuWitsWktIZVo4eFlvZFprRDNwQ2ozQmNJ?=
 =?utf-8?B?K3Z2eStOU1hCRHVGSEpWb3dSMjAvT3pJWk1QWXZVRElCNnllM2p1Q2xDQndj?=
 =?utf-8?B?MnJRUjFWMEFLRzEwc1pCamlzK2g3WlMrSUNzR1l4ZUVaWmEzUDk0Wk83bkxR?=
 =?utf-8?B?Q05RT2tTNjUrQnpqVWgxRjczeTNTUHhSWkszTVRnTWprN0dxVDZ4NE9NMVFO?=
 =?utf-8?B?SkpadENkc3k4WmNhbTFLZGFnM1BNaHFsZXZ1dC9BdGpiQUk4ajMrczdvTnNZ?=
 =?utf-8?B?aFFkS3lQcVNJRXNnRTFoeGtmdHNjNE1qMC9iemNYSzZNNTBrR1A5OFc3dllM?=
 =?utf-8?B?c0dmRUpaVjVOay9PWG5WUktHaDlLZ1VVaTBiNXpXSG5zZ3cwLzZzL3NFTlMx?=
 =?utf-8?B?dEg5QldhWmdhRmF6ZXpUL3hTL3FiTlpyT1JJcTR4aTlmZ0VqVGR0VDRKcXZN?=
 =?utf-8?B?NzlxSXN1Nm5sanJjNkhLUjJHZTVEcXZiUmtqWnpib2dQdTloQzlYQ0g1dmpy?=
 =?utf-8?B?NTZkaHhmaXVrOWUyVmJlRmYzODRaQk5JRHVLcVNycldrc1QwVXZqWitQaURS?=
 =?utf-8?B?WDQwNGFwUS84LzVYUDg0L0dadE40cmN3aFVJcnJYeWZET0kzRFJGNUhmdkhy?=
 =?utf-8?Q?5Hln4MXGET6EpbWbDRepWhsqY?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b541cb6e-d44f-4c45-80f3-08dd7fe733d9
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR12MB6363.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Apr 2025 08:41:54.1876
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QgfEpzsKJp3+mgJHAOtsk08IR3XqFW/DuQfzmuhzet0gm4Bw3aTLHIWwpKk9k8h5hvqM/OHoVciQfqpnUYVbTw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7121


From: Omri Mann <omri@nvidia.com>

Currently ublk only allows the size of the ublkb block device to be
set via UBLK_CMD_SET_PARAMS before UBLK_CMD_START_DEV is triggered.

This does not provide support for extendable user-space block devices
without having to stop and restart the underlying ublkb block device
causing IO interruption.

This patch adds a new ublk command UBLK_U_CMD_UPDATE_SIZE to allow the
ublk block device to be resized on-the-fly.

Feature flag UBLK_F_UPDATE_SIZE is also added to indicate support.

Signed-off-by: Omri Mann <omri@nvidia.com>
---
  drivers/block/ublk_drv.c      | 19 ++++++++++++++++++-
  include/uapi/linux/ublk_cmd.h |  8 ++++++++
  2 files changed, 26 insertions(+), 1 deletion(-)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index 2de7b2bd409d..03653bd7a1df 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -50,6 +50,7 @@
   /* private ioctl command mirror */
  #define UBLK_CMD_DEL_DEV_ASYNC	_IOC_NR(UBLK_U_CMD_DEL_DEV_ASYNC)
+#define UBLK_CMD_UPDATE_SIZE	_IOC_NR(UBLK_U_CMD_UPDATE_SIZE)
   #define UBLK_IO_REGISTER_IO_BUF		_IOC_NR(UBLK_U_IO_REGISTER_IO_BUF)
  #define UBLK_IO_UNREGISTER_IO_BUF	_IOC_NR(UBLK_U_IO_UNREGISTER_IO_BUF)
@@ -64,7 +65,8 @@
  		| UBLK_F_CMD_IOCTL_ENCODE \
  		| UBLK_F_USER_COPY \
  		| UBLK_F_ZONED \
-		| UBLK_F_USER_RECOVERY_FAIL_IO)
+		| UBLK_F_USER_RECOVERY_FAIL_IO \
+		| UBLK_F_UPDATE_SIZE)
   #define UBLK_F_ALL_RECOVERY_FLAGS (UBLK_F_USER_RECOVERY \
  		| UBLK_F_USER_RECOVERY_REISSUE \
@@ -3075,6 +3077,16 @@ static int ublk_ctrl_get_features(const struct 
ublksrv_ctrl_cmd *header)
  	return 0;
  }
  +static void ublk_ctrl_set_size(struct ublk_device *ub, const struct 
ublksrv_ctrl_cmd *header)
+{
+	struct ublk_param_basic *p = &ub->params.basic;
+	u64 new_size = header->data[0];
+
+	mutex_lock(&ub->mutex);
+	p->dev_sectors = new_size;
+	set_capacity_and_notify(ub->ub_disk, p->dev_sectors);
+	mutex_unlock(&ub->mutex);
+}
  /*
   * All control commands are sent via /dev/ublk-control, so we have to 
check
   * the destination device's permission
@@ -3160,6 +3172,7 @@ static int ublk_ctrl_uring_cmd_permission(struct 
ublk_device *ub,
  	case UBLK_CMD_SET_PARAMS:
  	case UBLK_CMD_START_USER_RECOVERY:
  	case UBLK_CMD_END_USER_RECOVERY:
+	case UBLK_CMD_UPDATE_SIZE:
  		mask = MAY_READ | MAY_WRITE;
  		break;
  	default:
@@ -3251,6 +3264,10 @@ static int ublk_ctrl_uring_cmd(struct 
io_uring_cmd *cmd,
  	case UBLK_CMD_END_USER_RECOVERY:
  		ret = ublk_ctrl_end_recovery(ub, header);
  		break;
+	case UBLK_CMD_UPDATE_SIZE:
+		ublk_ctrl_set_size(ub, header);
+		ret = 0;
+		break;
  	default:
  		ret = -EOPNOTSUPP;
  		break;
diff --git a/include/uapi/linux/ublk_cmd.h b/include/uapi/linux/ublk_cmd.h
index 583b86681c93..be5c6c6b16e0 100644
--- a/include/uapi/linux/ublk_cmd.h
+++ b/include/uapi/linux/ublk_cmd.h
@@ -51,6 +51,8 @@
  	_IOR('u', 0x13, struct ublksrv_ctrl_cmd)
  #define UBLK_U_CMD_DEL_DEV_ASYNC	\
  	_IOR('u', 0x14, struct ublksrv_ctrl_cmd)
+#define UBLK_U_CMD_UPDATE_SIZE		\
+	_IOWR('u', 0x15, struct ublksrv_ctrl_cmd)
   /*
   * 64bits are enough now, and it should be easy to extend in case of
@@ -211,6 +213,12 @@
   */
  #define UBLK_F_USER_RECOVERY_FAIL_IO (1ULL << 9)
  +/*
+ * Resizing a block device is possible with UBLK_U_CMD_UPDATE_SIZE
+ * New size is passed in cmd->data[0] and is in units of sectors
+ */
+#define UBLK_F_UPDATE_SIZE		 (1ULL << 10)
+
  /* device state */
  #define UBLK_S_DEV_DEAD	0
  #define UBLK_S_DEV_LIVE	1
-- 
2.43.0

