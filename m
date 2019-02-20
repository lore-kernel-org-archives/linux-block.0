Return-Path: <SRS0=4lGM=Q3=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FDA8C43381
	for <linux-block@archiver.kernel.org>; Wed, 20 Feb 2019 07:09:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 198EC20449
	for <linux-block@archiver.kernel.org>; Wed, 20 Feb 2019 07:09:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="G3nYuLlo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726540AbfBTHJV (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 20 Feb 2019 02:09:21 -0500
Received: from mail-eopbgr790057.outbound.protection.outlook.com ([40.107.79.57]:19680
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725869AbfBTHJV (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 20 Feb 2019 02:09:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hq91WI73ykc3lmeInUtWhXn3ZkinU6kfUsESgbqlFlQ=;
 b=G3nYuLlohFxPN0rTguWUXxBWcaStI6lXt+90AjRB/rEr15zNDJbLRiHGNuqWNvFySH0PRtcaty6pVBDqs44eiruod9qqDMXS4/iAFT1p/4yZl896C8SRst61MsLoAHU72hPsNLOpOzEFrgH5EDyix80twP7NljZQLkanRi788q0=
Received: from SN4PR0201CA0015.namprd02.prod.outlook.com
 (2603:10b6:803:2b::25) by BLUPR02MB1665.namprd02.prod.outlook.com
 (2a01:111:e400:525f::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1643.15; Wed, 20 Feb
 2019 07:09:16 +0000
Received: from BL2NAM02FT014.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e46::206) by SN4PR0201CA0015.outlook.office365.com
 (2603:10b6:803:2b::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1622.16 via Frontend
 Transport; Wed, 20 Feb 2019 07:09:15 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; roeck-us.net; dkim=none (message not signed)
 header.d=none;roeck-us.net; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 BL2NAM02FT014.mail.protection.outlook.com (10.152.76.154) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1643.11
 via Frontend Transport; Wed, 20 Feb 2019 07:09:15 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <michal.simek@xilinx.com>)
        id 1gwM0I-0004A9-LR; Tue, 19 Feb 2019 23:09:14 -0800
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <michal.simek@xilinx.com>)
        id 1gwM0D-0007aR-I6; Tue, 19 Feb 2019 23:09:09 -0800
Received: from xsj-pvapsmtp01 (mailman.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp2.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id x1K7936h019234;
        Tue, 19 Feb 2019 23:09:03 -0800
Received: from [172.30.17.111]
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <michals@xilinx.com>)
        id 1gwM06-0007Vx-Vu; Tue, 19 Feb 2019 23:09:03 -0800
Subject: Re: [PATCH] xsysace: Fix error handling in ace_setup
To:     Guenter Roeck <linux@roeck-us.net>,
        Michal Simek <michal.simek@xilinx.com>
CC:     Jens Axboe <axboe@kernel.dk>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <1550594996-11453-1-git-send-email-linux@roeck-us.net>
From:   Michal Simek <michal.simek@xilinx.com>
Message-ID: <0e62ae52-9aec-dff9-4fdb-51c3dd0568c5@xilinx.com>
Date:   Wed, 20 Feb 2019 08:09:01 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <1550594996-11453-1-git-send-email-linux@roeck-us.net>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(979002)(39860400002)(136003)(396003)(346002)(376002)(2980300002)(199004)(189003)(64126003)(58126008)(8936002)(81166006)(81156014)(8676002)(110136005)(316002)(54906003)(106002)(36756003)(9786002)(45080400002)(31696002)(478600001)(4326008)(6246003)(11346002)(36386004)(476003)(446003)(5660300002)(31686004)(44832011)(2616005)(486006)(63266004)(229853002)(65806001)(65956001)(106466001)(126002)(5024004)(14444005)(305945005)(336012)(356004)(23676004)(2486003)(76176011)(47776003)(2906002)(26005)(186003)(77096007)(426003)(65826007)(230700001)(50466002)(107986001)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1101;SCL:1;SRVR:BLUPR02MB1665;H:xsj-pvapsmtpgw01;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-83.xilinx.com;A:1;MX:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9a1c6d0e-2227-44f0-629d-08d6970252d1
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605104)(4608103)(4709054)(2017052603328)(7153060);SRVR:BLUPR02MB1665;
X-MS-TrafficTypeDiagnostic: BLUPR02MB1665:
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Exchange-Diagnostics: 1;BLUPR02MB1665;20:It4o1t+JgxIHPe8+VRX1pBc87jv6bW3O9At0kLEc9eJA1V/EsKfZkplDaPlId0u4IZIk14obcQZsursGAzB9pJ5tj38Z3LmzcRnrKjuBal9DJ42dhHazXxaHMvNQgjTtIvRNa0maVacFU7leVvP+ZVXXKiJr7/1u0Cr9LDOw62K3pHH9EWlF1cYWgVfAIvhOQhK90F9rMtTjk29R4CBaShKsYZo7ogS562U+B7cEGIn3mmaTzDqaxGc//eKtkOL4CB+k9OJfaN3L5ZLVuo86qI0BAqW9Vy3ysNQFA4NTxFuMQE8znbskWGv6vKTmXRR1YTR32k8QuvNaLYqI4zApL44olmLcohdeJGQwTncvmPJfAjImBZMZ9jjH5GBxqWScbdKW2xRHTUPbdSaD8FiNy06iHcRrlEQK82bLMyyGIIbN69ck9E9r+K+2UydJV2Fz+4w8WDFW7Cy50gf75U6AWTp8s8EBRDlYdzwA5cA2fwxfBf93MjGqTw3xV2TT+HG9
X-Microsoft-Antispam-PRVS: <BLUPR02MB16658DC92D16892952DE828CC67D0@BLUPR02MB1665.namprd02.prod.outlook.com>
X-Forefront-PRVS: 0954EE4910
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtCTFVQUjAyTUIxNjY1OzIzOkludlFYYnQ1aTZvWmlUdm9YT1lBZ1hCdElD?=
 =?utf-8?B?RThycE1ZR2pVeWx2Q0hMOWgvZWNnL2lKdXdHQm5zZlErdTIrM0J2Z3Z2OS8v?=
 =?utf-8?B?akZ6Q2JmZFlNaUNsSWxuT0JMTXFZVFJUUFI5ZUNNUmN6ajdhL1k1UnplcWU2?=
 =?utf-8?B?RWRnb09aOWsvV0ErdVliOTdwaitsT1NaWlBvWUN0bUNicmplRzhPMnY4TWJY?=
 =?utf-8?B?eWxJeHo4Slh3SVhsdWoxbk4yOW5CYlpvYlRSNlAxZTFCalJnVXY1T0lSYWZD?=
 =?utf-8?B?MU9kZGdIT3BBMTVQU1Q4MEFlNW5wd0lweWhSWURMeEtFbXdDMW1KYnpRRzVy?=
 =?utf-8?B?MkxobGNVMS9CMmdhUk4xN0h0YXdOTGVXRkJoWjVxQzM0dlFMcGVuQWt3c0xj?=
 =?utf-8?B?VVRlS2NZNnNKUEZXNWdTSmZFaDNjaEpSdS95WHBXejZ2L0lMbUw5bWF2Rmk2?=
 =?utf-8?B?Mng2N0swNXh0YXhsKy9STVpiekp5UFI3M3Z2ZUxhNjN6dlhkWDUyOFpwNVow?=
 =?utf-8?B?RGF3VlczZDc4ODE5d3VCSExBc2tOazBsZzRJMXhVUk1xb0xPeHdFbS9VZUpY?=
 =?utf-8?B?MU9IVnlKdVFYekt5L1VyTDcvd1pCbmlBTXIxa3JxY2tWVWVvNlhTdFRGS1o2?=
 =?utf-8?B?NUtWWlh4Sno2WTI1aUFSR1hNOTFzeTBSQ1ZxdVZPWGhMTTZ4MW9jV1VpL2Fh?=
 =?utf-8?B?VDNtSmZqaENtZ3FRTHQ1bFBKamdkUTAzdk5HTGMybVdRSHRUeHp1SURkaEpx?=
 =?utf-8?B?anRjUlMwTXluby9adHp2Q205REFjOUlDbUlvdktldkt2UUo4azZOSWlYaWFt?=
 =?utf-8?B?Q3p4T2kxeWdKL3RlYTFSUmhjQkdyOUgvdHpTTGdVekwyaVhFVHVCNngxVEJk?=
 =?utf-8?B?SkFLMWEzbGUwNU1Iei9jRGYyTDMvTjNOdFBqbmdqaXk1ZXpweGJVZUFqK0tp?=
 =?utf-8?B?SVh0TnA5WE56K3k3TFJKY04zS3lVd3p5ZSswZVNYN2pPdWM2UWZvbXpPeitZ?=
 =?utf-8?B?aU0rYitya2xCNEU0YllXK3pqRHU0dFVkQ0txcS9TTUI1NHl4YzJJcU5JN1ln?=
 =?utf-8?B?bXNKOVBRWnB3RHNTSDNUbzFUWE5pVTRoTWo4dFYwMEVOOVNBb3hKN3pvbG5v?=
 =?utf-8?B?c2VxRnJBQWtvK2toTWM1dnRzdnZmVlpZL1JRcHRwQTJ3VnN5TGZERTR4ZW1N?=
 =?utf-8?B?L2psQzE2MmtLL0U2SXNYU2hlTlZuTkZuQWF2V3NpbGZQZWY4WHZRRFBOY3Z1?=
 =?utf-8?B?V2tUR01CVlpHbU5uRUFIUzhieXV2Qm1jcVJvUFdjVkJGMkdXaWowRy9KOWVy?=
 =?utf-8?B?dnJZclIxbDVFUVdGaEFqeHpNTGY1UXV0bEpPRW5NSXZaaUQ0V3hkdHVhZGxU?=
 =?utf-8?B?MjU3aWNscUhMb1drZUV5eDZlVTFpaHNWV1VxWkdkbnVuQzRXK2pCODNDZDNm?=
 =?utf-8?B?YThiSHJqNmlKbGhSL2w5aXcwajM3N0YvNzhNRXJRRVJuZEFHWGExUDJwKzJX?=
 =?utf-8?B?WFpzZExVYis1L2ZCRE1OTEVDNUNwRTd0amdyV3VYQTN3WVAxZ05SL3BQeW9R?=
 =?utf-8?B?andtUm5RVXF2ZFp3Mll2ZlJaaHVxOERLbkhDRTVDaDBYdmVIRXN1bnhyMXp5?=
 =?utf-8?B?QlM5SGIyQllDbWdNVE95WjRQTzZER2M4OTdUampDczc5cTlveW10a2RuYUVl?=
 =?utf-8?B?K2FKV3VMR2dPMk5GNlVNdTRJYktrNUdsVk1ZRi9JM2UrMzY4a1cydHVqWFlD?=
 =?utf-8?B?TWdxdEZDWDdlZnNGR0EyQkFXbng1dHlSWlQrczJqUGMreldBWWg0Q2RITVhv?=
 =?utf-8?B?cEVBeU1CN0xPZ1MwTk5PNmhPUVRwNnJXaDN6cHQ1ZGR0OHh1c2JhRFg2RUl2?=
 =?utf-8?Q?HRKhn4N8c7M=3D?=
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: mHdbqx3dHrpzEAlkJNHmUFYCyJY8jBAoid6M60rtPUZqutV0UBKGlBotXXmWiiDA9MnhPdf2ZxN2HeTb4zqc8Yt8C0c/MNQPwd82o6YKimz+Jx86FnFhsBMlvf/fJNRMUyK+SUFg2Juy36vje8pqJKJg2CcNYn7tZA1DqvdYKrSOz9eCl5ZZV6nGkT+AsQKKSKejllA4nE+6hvBTogvC0cYGsB//7qObTAYK36BHdgmcAJ8u4DFgHEt5jKgptggbVrKPfaXN/gQ42DV5t7NKvQJENzqIBJsPegv9ohF5IgGId46uR9Ocgy3VRmsIv08LCJo+D1SFshp1q/rtVMFEkGugryo53GgE+xMwxusRFdZUvocqslEAdcHp/nNSmDhn86dnfS4QoJH0/vbYnMYzzbo4DHMw4j2ux3Ql4jLQ0EA=
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2019 07:09:15.2283
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a1c6d0e-2227-44f0-629d-08d6970252d1
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLUPR02MB1665
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 19. 02. 19 17:49, Guenter Roeck wrote:
> If xace hardware reports a bad version number, the error handling code
> in ace_setup() calls put_disk(), followed by queue cleanup. However, since
> the disk data structure has the queue pointer set, put_disk() also
> cleans and releases the queue. This results in blk_cleanup_queue()
> accessing an already released data structure, which in turn may result
> in a crash such as the following.
> 
> [   10.681671] BUG: Kernel NULL pointer dereference at 0x00000040
> [   10.681826] Faulting instruction address: 0xc0431480
> [   10.682072] Oops: Kernel access of bad area, sig: 11 [#1]
> [   10.682251] BE PAGE_SIZE=4K PREEMPT Xilinx Virtex440
> [   10.682387] Modules linked in:
> [   10.682528] CPU: 0 PID: 1 Comm: swapper Tainted: G        W         5.0.0-rc6-next-20190218+ #2
> [   10.682733] NIP:  c0431480 LR: c043147c CTR: c0422ad8
> [   10.682863] REGS: cf82fbe0 TRAP: 0300   Tainted: G        W          (5.0.0-rc6-next-20190218+)
> [   10.683065] MSR:  00029000 <CE,EE,ME>  CR: 22000222  XER: 00000000
> [   10.683236] DEAR: 00000040 ESR: 00000000
> [   10.683236] GPR00: c043147c cf82fc90 cf82ccc0 00000000 00000000 00000000 00000002 00000000
> [   10.683236] GPR08: 00000000 00000000 c04310bc 00000000 22000222 00000000 c0002c54 00000000
> [   10.683236] GPR16: 00000000 00000001 c09aa39c c09021b0 c09021dc 00000007 c0a68c08 00000000
> [   10.683236] GPR24: 00000001 ced6d400 ced6dcf0 c0815d9c 00000000 00000000 00000000 cedf0800
> [   10.684331] NIP [c0431480] blk_mq_run_hw_queue+0x28/0x114
> [   10.684473] LR [c043147c] blk_mq_run_hw_queue+0x24/0x114
> [   10.684602] Call Trace:
> [   10.684671] [cf82fc90] [c043147c] blk_mq_run_hw_queue+0x24/0x114 (unreliable)
> [   10.684854] [cf82fcc0] [c04315bc] blk_mq_run_hw_queues+0x50/0x7c
> [   10.685002] [cf82fce0] [c0422b24] blk_set_queue_dying+0x30/0x68
> [   10.685154] [cf82fcf0] [c0423ec0] blk_cleanup_queue+0x34/0x14c
> [   10.685306] [cf82fd10] [c054d73c] ace_probe+0x3dc/0x508
> [   10.685445] [cf82fd50] [c052d740] platform_drv_probe+0x4c/0xb8
> [   10.685592] [cf82fd70] [c052abb0] really_probe+0x20c/0x32c
> [   10.685728] [cf82fda0] [c052ae58] driver_probe_device+0x68/0x464
> [   10.685877] [cf82fdc0] [c052b500] device_driver_attach+0xb4/0xe4
> [   10.686024] [cf82fde0] [c052b5dc] __driver_attach+0xac/0xfc
> [   10.686161] [cf82fe00] [c0528428] bus_for_each_dev+0x80/0xc0
> [   10.686314] [cf82fe30] [c0529b3c] bus_add_driver+0x144/0x234
> [   10.686457] [cf82fe50] [c052c46c] driver_register+0x88/0x15c
> [   10.686610] [cf82fe60] [c09de288] ace_init+0x4c/0xac
> [   10.686742] [cf82fe80] [c0002730] do_one_initcall+0xac/0x330
> [   10.686888] [cf82fee0] [c09aafd0] kernel_init_freeable+0x34c/0x478
> [   10.687043] [cf82ff30] [c0002c6c] kernel_init+0x18/0x114
> [   10.687188] [cf82ff40] [c000f2f0] ret_from_kernel_thread+0x14/0x1c
> [   10.687349] Instruction dump:
> [   10.687435] 3863ffd4 4bfffd70 9421ffd0 7c0802a6 93c10028 7c9e2378 93e1002c 38810008
> [   10.687637] 7c7f1b78 90010034 4bfffc25 813f008c <81290040> 75290100 4182002c 80810008
> [   10.688056] ---[ end trace 13c9ff51d41b9d40 ]---
> 
> Fix the problem by setting the disk queue pointer to NULL before calling
> put_disk(). A more comprehensive fix might be to rearrange the code
> to check the hardware version before initializing data structures,
> but I don't know if this would have undesirable side effects, and
> it would increase the complexity of backporting the fix to older kernels.
> 
> Fixes: 74489a91dd43a ("Add support for Xilinx SystemACE CompactFlash interface")
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> ---
>  drivers/block/xsysace.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/block/xsysace.c b/drivers/block/xsysace.c
> index 87ccef4bd69e..32a21b8d1d85 100644
> --- a/drivers/block/xsysace.c
> +++ b/drivers/block/xsysace.c
> @@ -1090,6 +1090,8 @@ static int ace_setup(struct ace_device *ace)
>  	return 0;
>  
>  err_read:
> +	/* prevent double queue cleanup */
> +	ace->gd->queue = NULL;
>  	put_disk(ace->gd);
>  err_alloc_disk:
>  	blk_cleanup_queue(ace->queue);
> 

This driver is quite old and we are not actively using/testing it.
Are you wiring that up with qemu?

Maybe it should be labeled differently in MAINTAINERS file.

Anyway whatever fix is fine for me.

Acked-by: Michal Simek <michal.simek@xilinx.com>

Thanks,
Michal
