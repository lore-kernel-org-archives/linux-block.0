Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2078.outbound.protection.outlook.com [40.107.243.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DC3D26E15F
	for <linux-block@vger.kernel.org>; Mon, 14 Apr 2025 11:44:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744631075; cv=fail; b=JG4hD/81ZHz+W5iMglvPlLtaNDVkQUjTwjMEd/D7NeHhWc03B6NQRzSWn2WT6cwclCL7fn1/x0C4NulWz8Pvnqj+bk3LjokZKePJlW45UdqzNdDQ5jQAq2CWDUWbeU5j4sJF7OVHIcKYKqQRlZZnfXY65S4WMFaMU9qIieDCiDo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744631075; c=relaxed/simple;
	bh=N+g6T3Mth5ioZuslbUygeay1juuthkKmWOMUcz9FknA=;
	h=Message-ID:Date:To:Cc:From:Subject:Content-Type:MIME-Version; b=CTwM+He4HvTKO6S+ZIxVheXyeWHsZMzb2BBxGyFaumaBOel7UgGC8yyhp28X3cnSFCinegsH9AAxinS5egJ+pHG+6QqWT0K1SLNWwWGV63DmsKyutboIJz2bMnS+fEb7fy9F/VPzqmezxu6vmaXU5otrgl/j9Er4hb4VODdakS0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Zq2c4741; arc=fail smtp.client-ip=40.107.243.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Zq2c4741"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=u7LXiLOuX3lCmXdHjr+zpoDecGhb/ki6GHhefcdu4lFQhCDgk85g24zdpr/zgVWd9JwsZFIW85AIfnH71zVrJ21QvqGN2YuC5RzhPaqBuGQ2Ek00p5Vkx3+SftEujdUne5ChmozUPBF6q005XEWDLGz+hP6LWFKgH05f40L+btQRU2rIVbFxHl3GIteRE5cv/UazSbFHOV5mWvw8ipb81yme9ZR5CkmiKRvxX6zJ0pduChg3Cb4zfVvNj89qLbozvu8u5XWdeHlYFozW0r4pDtXtNPiieyjjNmOFaOTg4omThBafllIMbhpAdUWNzHA7Wri35Ra5Z7H7VWYCpIhegg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lZep1AtpiZOLTUUWtox1jhFbv0tkHiOSnXWs7QoaOTc=;
 b=YV/E2ev66orNTbwrNiOu1sSR0fnu7KEw191RliyNScfVNj/6J96V+fmcBmHLBVh2O7tcE7PnCFR1xpcIAIjcAfJ4B7VVm7FoUHooYxd+j910n/JffxXgfCDZDvFsT5/gpeiRNLirNoJ9Ig9zcT9qJ1dPEdPtWse3tbMsAlac3LTdjkX4VWjLK+J+lHpVIyuM1/npS1a7kl0oIYO0J0s0XM8nunbIBt0phvInJzc81ZTw5J1v5Z35I+3D8ZjSLcGhXvukcEKpqEgCHSkYlghvzEHLyAmYVWcZCPgDgcRV605BrvcXZLtYf9TRm1WieKcA+rHUNx8kV2t7U/n37qPoAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lZep1AtpiZOLTUUWtox1jhFbv0tkHiOSnXWs7QoaOTc=;
 b=Zq2c4741GAQjb+KeOsfJQhvgP5JSh6UFGySSDYeOO2kkdS8AnkgEQYdZ/O4NnnKOpAhKj3VjRoV+DqHtQkdj27X76mzcAyYzF+yLM9xJikOwMaj6RoEgqSQIzGsV4CwH8iMniU17R0/zn+1OXDbuw4wSlXgskYO5KCcOQSI/FEtz9pwBgzZMsoNNFmC753naBMGvNKEuptkdsJV4QrJQjFpdSoClhoMwuAEuEubjg49i7ohNOocvwFrXM/E8TBF5ZYpNJkR30OXDCHJvu9Io+DUKwRNkotD3lwjtFueKPMExVKtcwHtigkPHpwlwQLqMPOEZ7AGaf1ey4YN+1oRABg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ1PR12MB6363.namprd12.prod.outlook.com (2603:10b6:a03:453::9)
 by PH8PR12MB6674.namprd12.prod.outlook.com (2603:10b6:510:1c1::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.34; Mon, 14 Apr
 2025 11:44:29 +0000
Received: from SJ1PR12MB6363.namprd12.prod.outlook.com
 ([fe80::bec3:4521:c231:d03b]) by SJ1PR12MB6363.namprd12.prod.outlook.com
 ([fe80::bec3:4521:c231:d03b%3]) with mapi id 15.20.8632.030; Mon, 14 Apr 2025
 11:44:28 +0000
Message-ID: <36ba7ff3-ff0e-4db1-acb1-8e7a60a427cc@nvidia.com>
Date: Mon, 14 Apr 2025 14:44:04 +0300
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Cc: Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>
From: Jared Holzman <jholzman@nvidia.com>
Subject: [PATCH v3]: ublk: Add UBLK_U_CMD_UPDATE_SIZE
Organization: NVIDIA
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P123CA0402.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:189::11) To SJ1PR12MB6363.namprd12.prod.outlook.com
 (2603:10b6:a03:453::9)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PR12MB6363:EE_|PH8PR12MB6674:EE_
X-MS-Office365-Filtering-Correlation-Id: 1d3eb89f-b03c-43dd-85de-08dd7b49ab3c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MGNiampnSmtIWU9zZWlpM1JIaTJNM1hlUURFcmphNkJaK1poeG9CblpHa3Yw?=
 =?utf-8?B?VjlWWHdvbWE1WHJmdlBVT3luOFVGSW9qU25FdVh6YnZXSjZWNjJ4YTFtODhk?=
 =?utf-8?B?aHNGaGVyWFFzTWtkRTZuTk9LZTFwTk1pK0M4SkJFa1NlMnRlMzl0OUJ3SlBI?=
 =?utf-8?B?V1NoZHhGeDE0RUUvMzBWN1hNclB2Uy94NEJ2MDBZSW1WeS9ITWw0elNGUnZC?=
 =?utf-8?B?RmV3c21nSlJWS2pZUUJ1Y1IyTWVDSU02bG1CQ3BybVNpNzJsSS9JSWFnV0Rz?=
 =?utf-8?B?aTFDRU41T0RFT0hiWUozMmtoZmVVOC9XcVBkVkhteEhKUWJvdHBjRENjaXNQ?=
 =?utf-8?B?cGpZRmZCdU9SczFyZjYvMFRjTGtHcUVSeGFBZzlTRVJQMHNlOUZqMEsyUjRE?=
 =?utf-8?B?RVRCTG1IQ2J6NUV1cVZXaSsvekJMazlqTkVFTEVnaG4rYUoyNWRyNFpEM0Y4?=
 =?utf-8?B?dmZIdEJhQkNweDhnUkpnMi9YZ25jVEgxZU1ua2F6aXA1NjdIcUFSVzdlTU05?=
 =?utf-8?B?MUltRUNjQ0tKRUx6VGtwYUNicTVxNURYQ1grR0tWeHZBbDJFWEthMmU0RnIy?=
 =?utf-8?B?VU5PanR4WjY5Z2NMQ2ppNWlTQzV2ZnU3TjloK051bW9XKzFpRURoZkM2cDB2?=
 =?utf-8?B?aDRIQ1pjMEZOV2pEdjZUUVFLZlpvOG04Tk9TMUxCS2kxTTFPK2N6di9qOFZY?=
 =?utf-8?B?UmJxYXdPNmJpVDQyUjYwRHhNMHBxOUphTmx4UDVUT2JKTEE3WEpEV2Q1YWxZ?=
 =?utf-8?B?WXJ2SUFSMmJKeVJQd3IxZ2x1TEZQRTZUcS9PdzNsS3VVWU1CUGlTektrWFBz?=
 =?utf-8?B?UFJaQnM1R1hnRkRxQVE4RWRUSkpiWGxncVBhTldhc2J5SWp4QlBSalVMcHk4?=
 =?utf-8?B?UlludElwTEdxMTRuajdjMGpZK0p0eDNpd0R1aEw3QlMzMWNzNG5RdTRNclFH?=
 =?utf-8?B?dkh6czVMUXpFSzh6R0R4bzJkN2RQRWxjWHhCR1JNdmdZcUpuYW9PakpFVXd6?=
 =?utf-8?B?cXBCaWZQOEJMWTc5MmhmaXhEOGNqMTVEUndDUVZjYXo0d2lyZ1RKZURtcDN3?=
 =?utf-8?B?MG5xcDVTbUZ5RWhHREN2VG9ReWx6MW5RUTZqSlpaNVV0all6UHNUdFErQ2x1?=
 =?utf-8?B?MDhoOHhFMjNuUFM0R1NvWENrMkRNRTl3RUN4TDIzUkx6V3VqSkx3RDllRVhp?=
 =?utf-8?B?ODBZUUFOa3JwdWhNbXJXcDlLTHFialh0WGZSQW1XUlpES0JKZkJjd3ZpQ3JK?=
 =?utf-8?B?bXVyR1lUWGNoOVhhcWZRNjRFcWlHYU54blJqaWFMV3loNUNiUXZNWnhzUnFm?=
 =?utf-8?B?Z3J1Ui91VkorK1BrVDFUbXZhWVFCbTRHVDI2akkxaEYyZzFmaGJ2VTJRYTVR?=
 =?utf-8?B?ZGtLNFVyUXowaXBSYUgwcTVMUHkvVnBXUndBZ0JvZWdBUW15U09TVGZCNTE4?=
 =?utf-8?B?T0tjQjFCbG9OSG9vTGY0dGcwUkt2Y3hlSlQrNy9yQW84Y2NYdDYyQ1Y0dHZP?=
 =?utf-8?B?MkZCMWxJLzhyM1oyd3h3SWlCdEcwTkhtQ0IzblBJem1zclBpTnhtQVNwTW9L?=
 =?utf-8?B?ZWNMcXVsZ2ZXb2o2bzczbWlKSlpwaXZNcWdQOWJ0elBOL3NXdWs0ZjlvajJO?=
 =?utf-8?B?NXpqaldvQllGSnpRR1FvQU5ITElwWjY5M2VDa0hRY2xiSVg3OGpaaW45UDVv?=
 =?utf-8?B?Qm9sUVpVY0JvY0c1K1Zua3Yxc0F3OWdER3pBMHZiVEVBeGw4R3BtS2VCbm1I?=
 =?utf-8?B?MUVSdXNGQ3ZnRGY5dHJlc2pWTTBzUW9WeGRvNHpQLzlDbEtmWWYwOVdDM2tP?=
 =?utf-8?B?MDJkOUVRTGNoOHBKNmlmcHFMMjdRSzQ1ZTduQjVyWEFnYjFzcVgwS0tzUURY?=
 =?utf-8?B?V05HUk43NnFTdyt5ZlRQcHk4cTZXcVNmVkNvWVQvcVdENENtbTExRy90ZmNH?=
 =?utf-8?Q?kZisf93LiNA=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR12MB6363.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aXJQUEtyUlZCT1RBSjh1ejQzS2ZDR08wS015UEd3MTMzSXNVL3RPQkJhRS9o?=
 =?utf-8?B?QzQyeCtsQ09JYkdneW5sQ3QvY1MvRkpCb2Q1ZWFSTWdybWlLakdIK0l4YjRR?=
 =?utf-8?B?Qit3TDlSNEZNNEJoTlBQT2hjS2lPdlZ4L1pHcCt4VG1FY0YzbEtpUWtDMU9x?=
 =?utf-8?B?b1M4ZUt6Mno1cHppN1ZxdXkvRkxzK2RXeHBnNmNKc1UvY2NqcldMaXhKNzJB?=
 =?utf-8?B?S05UV1BtS0UxU2s1QTVWMUR5Zi9GeWNTN1A1bGtsWnhzcVByRXZTS2R4TnRY?=
 =?utf-8?B?U01aMURBcjZtcmRCa0hOeG1hUGlsSDFzTDRKVkl2emNyZVY1U0RqVU1yM1FE?=
 =?utf-8?B?T3UyZ3Z2MjA1aDhoVEhjSS9DMTdXdk0rSWJUbUxxRGtWRXVpaVpJcVZkRzRi?=
 =?utf-8?B?MjF3Q0NINUhQc21oMFdKRU8zWEhoVmMvVVNaKzNWaDZld0VmVXdwZHRsa3ZF?=
 =?utf-8?B?cFg3UFJSbWg1SlBhSGtrY01PUzQyNlA0UWJsY2FES3RxMUJiaEx0azNtQUd0?=
 =?utf-8?B?NkJ6Wlh5V01hN0Z0L3JwZk4zTmtEem5FamV1cFJLT3FOMGtHZnFGMTUxR21p?=
 =?utf-8?B?VnpPTWpZZlUzZDJvbDJQY0t2WHlCejVJOHVJSWI2M2U4Z0NEdzB0c3RVVWdk?=
 =?utf-8?B?VVdaYThHWlRmV1lHeTRvWWlXQjlHQTFaUHNSTEdDTEMwS3NwYW5IdElrVWdO?=
 =?utf-8?B?ZTQrNDUveU5xNlZWYmpnNGxUN2w0OTJ5RWNLQ2ZlOFc3WEg3WnViU29heEFp?=
 =?utf-8?B?VzRiV2N4SFNZTUdRcTE0T211RmFqalJNSnNlbDdkcXhIb1BJVGtMZlp1cURk?=
 =?utf-8?B?UXU2TStmMHJ5RlFyVWtRVGJDUXpRUWVLOFpDUUovYmlMZC9ZV1FGaTk1dzJk?=
 =?utf-8?B?Q2gvSGxuY0pINE1WVlhZWHVodmNTMDhLWVV1eUNpaUJMNE45NTNlSDVkMlZ2?=
 =?utf-8?B?c1ZFQnpyUzRFY0lNRCtEcVdqcW9hZU0xNXFUZHlHU2trWnRvQkUwT1RFd1BE?=
 =?utf-8?B?VmovNE9XYTFpSCtDaG0vb2xXM0FybVlWV1M4WUxqc2F2RTBxb3hBT0N4dmV1?=
 =?utf-8?B?YXdPWXdDa293a2grWDBwVHBhVTk4VHVibEtmRk5DRlR0c1lWbkJHVE1YeUxa?=
 =?utf-8?B?UjdPWmI1aEE4S05IQmJJS2xQaVFjR3VtMlhHbjBJbUJIUkh3OUo2VzVEc0dv?=
 =?utf-8?B?d1dtRmVEdFRRM0ZEeWxDb0tZa3RqWkJhc1ZGcDFZS2xYOEh5clZReGd3K282?=
 =?utf-8?B?ZEpxQWZHZ2ZNckZsTVVtellZOHY3YS9OdFo2THdUc0NnUWZWUE9IdEF3dnl4?=
 =?utf-8?B?Qnl6NkJxa0FCYlF0dEI1OTIwWCs0ZFNaNHl6Y3Nsc0NMQ2JoTE8yQmxYMDVX?=
 =?utf-8?B?bzZnRURKQVNlYWpFTE9QZW5aa0lDZFNzY3AvN0UycGwvNmJLRVZqc3dzNGI0?=
 =?utf-8?B?ZkV6cjlzZmdBVmdMb2cvU0VqTXpYNGV3Z2g5Mi9VMERsb1QyYXFvakRQM2dH?=
 =?utf-8?B?Mkl1NnNTWWFBWitWVlF2ME53Mm8zc1ZHaXBXdSthNXpYeGIwZGMxUjF3QXpR?=
 =?utf-8?B?UTN0OEtrSlFZc3QzNytmbEwvdXR3RCt2UHBhck9DazBxNXBEVDlGbkE4SWhL?=
 =?utf-8?B?bk9MRjFRbExKYW5pKzUrSnpwbURkL0pDTjduR1htc2Z0d1ZPMjdpMGtXKzBl?=
 =?utf-8?B?dHlRZ1FDMjVHcjdQL2Vja0c3c3g5RmM3b2tUZjBpaGE0TUVMNmNyWnU5enV1?=
 =?utf-8?B?TXVQOUx5akJaK1U0cXcyWjZUeS8rd2FqQjlyd2hSeWhJUzFRU1kwc21BMzFB?=
 =?utf-8?B?bnFyeHpWUTBadUdMREhDVWdMbjhLN3lON2dubEFLNmRuaTdFb1VtMkQ5VUtQ?=
 =?utf-8?B?VnQ0Y25zUjYxTTMxRk9ISUJaSjBrMi9Qb2ZWVmd3cHR3QUpIMFQxSVppZ3or?=
 =?utf-8?B?QWJRSCt0dlZVei84VnVEbGdQenVoN1NZL1BwdlMvN2tGQlg2QXNua0lOSTVO?=
 =?utf-8?B?Zm53czRVRVYxbHB0UHNhVWtnb0JYN3p5ejg5a2MyTU45NExzRXZRZnliQjVL?=
 =?utf-8?B?bzFKZFhJNllWYXVmdnNwUmM4ZlhtYWNoaTY2ZnJNZm5NVjZaTExmTno1Z3Ju?=
 =?utf-8?Q?kIl8mJvRf5BfsDYjqNI0+QCaX?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d3eb89f-b03c-43dd-85de-08dd7b49ab3c
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR12MB6363.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2025 11:44:28.7514
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rJ2Z0cdMbCs0dMk+XDRYdjzfxb99CGOUgLxoQR4BOSI64EvSP5hipuMl3N38gWD94UooRF7CaHXN2HdLlYTrpg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6674

Currently ublk only allows the size of the ublkb block device to be
set via UBLK_CMD_SET_PARAMS before UBLK_CMD_START_DEV is triggered.

This does not provide support for extendable user-space block devices
without having to stop and restart the underlying ublkb block device
causing IO interruption.

This patch adds a new ublk command UBLK_U_CMD_UPDATE_SIZE to allow the
ublk block device to be resized on-the-fly.

Feature flag UBLK_F_UPDATE_SIZE is also added to indicate support for 
this command.

Signed-off-by: Omri Mann <omri@nvidia.com>
---
  drivers/block/ublk_drv.c      | 19 ++++++++++++++++++-
  include/uapi/linux/ublk_cmd.h |  7 +++++++
  2 files changed, 25 insertions(+), 1 deletion(-)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index 2fd05c1bd30b..2a8d8b864ef9 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -64,7 +64,8 @@
                 | UBLK_F_CMD_IOCTL_ENCODE \
                 | UBLK_F_USER_COPY \
                 | UBLK_F_ZONED \
-               | UBLK_F_USER_RECOVERY_FAIL_IO)
+               | UBLK_F_USER_RECOVERY_FAIL_IO \
+               | UBLK_F_UPDATE_SIZE)

  #define UBLK_F_ALL_RECOVERY_FLAGS (UBLK_F_USER_RECOVERY \
                 | UBLK_F_USER_RECOVERY_REISSUE \
@@ -3052,6 +3053,17 @@ static int ublk_ctrl_get_features(struct 
io_uring_cmd *cmd)
         return 0;
  }

+static void ublk_ctrl_set_size(struct ublk_device *ub, struct 
io_uring_cmd *cmd)
+{
+       const struct ublksrv_ctrl_cmd *header = io_uring_sqe_cmd(cmd->sqe);
+       struct ublk_param_basic *p = &ub->params.basic;
+       size_t new_size = (int)header->data[0];
+
+       mutex_lock(&ub->mutex);
+       p->dev_sectors = new_size;
+       set_capacity_and_notify(ub->ub_disk, p->dev_sectors);
+       mutex_unlock(&ub->mutex);
+}
  /*
   * All control commands are sent via /dev/ublk-control, so we have to 
check
   * the destination device's permission
@@ -3137,6 +3149,7 @@ static int ublk_ctrl_uring_cmd_permission(struct 
ublk_device *ub,
         case UBLK_CMD_SET_PARAMS:
         case UBLK_CMD_START_USER_RECOVERY:
         case UBLK_CMD_END_USER_RECOVERY:
+       case _IOC_NR(UBLK_U_CMD_UPDATE_SIZE):
                 mask = MAY_READ | MAY_WRITE;
                 break;
         default:
@@ -3228,6 +3241,10 @@ static int ublk_ctrl_uring_cmd(struct 
io_uring_cmd *cmd,
         case UBLK_CMD_END_USER_RECOVERY:
                 ret = ublk_ctrl_end_recovery(ub, cmd);
                 break;
+       case _IOC_NR(UBLK_U_CMD_UPDATE_SIZE):
+               ublk_ctrl_set_size(ub, cmd);
+               ret = 0;
+               break;
         default:
                 ret = -EOPNOTSUPP;
                 break;
diff --git a/include/uapi/linux/ublk_cmd.h b/include/uapi/linux/ublk_cmd.h
index 583b86681c93..0e40e497c28f 100644
--- a/include/uapi/linux/ublk_cmd.h
+++ b/include/uapi/linux/ublk_cmd.h
@@ -51,6 +51,8 @@
         _IOR('u', 0x13, struct ublksrv_ctrl_cmd)
  #define UBLK_U_CMD_DEL_DEV_ASYNC       \
         _IOR('u', 0x14, struct ublksrv_ctrl_cmd)
+#define UBLK_U_CMD_UPDATE_SIZE         \
+       _IOWR('u', 0x15, struct ublksrv_ctrl_cmd)

  /*
   * 64bits are enough now, and it should be easy to extend in case of
@@ -211,6 +213,11 @@
   */
  #define UBLK_F_USER_RECOVERY_FAIL_IO (1ULL << 9)

+/*
+ * Resisizing a block device is possible with UBLK_U_CMD_UPDATE_SIZE
+ */
+#define UBLK_F_UPDATE_SIZE              (1ULL << 10)
+
  /* device state */
  #define UBLK_S_DEV_DEAD        0
  #define UBLK_S_DEV_LIVE        1
-- 
2.43.0

