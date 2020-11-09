Return-Path: <SRS0=Ui87=EP=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7F89C2D0A3
	for <linux-block@archiver.kernel.org>; Mon,  9 Nov 2020 11:00:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 574BC20897
	for <linux-block@archiver.kernel.org>; Mon,  9 Nov 2020 11:00:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="DUPwC+ju"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729038AbgKILAU (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 9 Nov 2020 06:00:20 -0500
Received: from mail-mw2nam10on2067.outbound.protection.outlook.com ([40.107.94.67]:51882
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727915AbgKILAU (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 9 Nov 2020 06:00:20 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QvId7P9o2tu2QCHSYoWPzEULCbjL3FBTK3ok1ZDkHW0ODh6s4mpkzSyvtuvZbwauSzYzZsTZULQS12176cKDJHv6Y7fu+f9KtFBxYroITxS/xaXhBnBBJtRWo455D4brlorOp8PtE9zZLAkik5JERlzf5JWYIc6YrGmoxf2+/FLfeDH+BKsc33VtIVVIYpjZvcPV6keds2wMRK37qz6hyPvmhybWtK9GeucyEwGebm1lxHOgTkzAQo6zX5UaExLghNa3f5gNjYfYTFdS2rWDRvTE6upoywbV66DbaX7T4pREIGf0tDV/8RqqIEVpoDI7hDD76ALUkP9UdaokWF5/qg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qYRDHVVdujXkzrCTEbyBomK2dRdEstWMjeIC0cUHxbg=;
 b=booC6KfD6LVQWxUToiRTYgA+6hu6OZ8bK5QFtAbub82hs//2DEdb2VFs932OETyo/2jqZqmbMdiZY9jQXee+k/MiLbqLgxwH3cSb+9skccy4bkTqehMhkGj31E8H0R0dXuB0WU/J3wSwbllkRpSTA/QujufeHv5ttfcP7xEvvwtROks2hr511wgZhVZgWDaJ7S1iqMyTKuOcVwJjCLZrnxCyBDlvvT1nToaJ/aQjs0pxtB3DYfn8pleCYaqqL24RTq9+SSeeDgbWDI3hWy46rO+w5uKOTdRxKM0mYBMBbkjJfxz9G6RZtClqgrhur3RDQ4RYm3T8wmcB8viHDGXtEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qYRDHVVdujXkzrCTEbyBomK2dRdEstWMjeIC0cUHxbg=;
 b=DUPwC+juyq56tFVXxQ3Scn0Guzxueg3I15+EjP5b7fq9jmYRkDxcnDg/QAkt+dR8CDvGfD5Dp40ssn4AnlaOqaGrJeBupRcIDbsYzYZ9FLoDv+iT0Zm+uAC7ggn20kbp4RCrV1zx4C1tGVm0vlgiJm9mZN4brMp6eu9J+1ci+2w=
Received: from SN4PR0501CA0141.namprd05.prod.outlook.com
 (2603:10b6:803:2c::19) by SN6PR02MB5151.namprd02.prod.outlook.com
 (2603:10b6:805:6a::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3541.22; Mon, 9 Nov
 2020 11:00:16 +0000
Received: from SN1NAM02FT006.eop-nam02.prod.protection.outlook.com
 (2603:10b6:803:2c:cafe::aa) by SN4PR0501CA0141.outlook.office365.com
 (2603:10b6:803:2c::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3564.13 via Frontend
 Transport; Mon, 9 Nov 2020 11:00:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch02.xlnx.xilinx.com;
Received: from xsj-pvapexch02.xlnx.xilinx.com (149.199.62.198) by
 SN1NAM02FT006.mail.protection.outlook.com (10.152.72.68) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3541.17 via Frontend Transport; Mon, 9 Nov 2020 11:00:16 +0000
Received: from xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1913.5; Mon, 9 Nov 2020 03:00:11 -0800
Received: from smtp.xilinx.com (172.19.127.96) by
 xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) with Microsoft SMTP Server id
 15.1.1913.5 via Frontend Transport; Mon, 9 Nov 2020 03:00:11 -0800
Envelope-to: michal.simek@xilinx.com,
 linux-block@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org,
 andriy.shevchenko@linux.intel.com,
 axboe@kernel.dk
Received: from [172.30.17.110] (port=47506)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <michal.simek@xilinx.com>)
        id 1kc4uB-0002ov-59; Mon, 09 Nov 2020 03:00:11 -0800
Subject: Re: [PATCH v1] xsysace: use platform_get_resource() and
 platform_get_irq_optional()
To:     Michal Simek <michal.simek@xilinx.com>,
        Jens Axboe <axboe@kernel.dk>,
        "Andy Shevchenko" <andriy.shevchenko@linux.intel.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-block@vger.kernel.org>
References: <20201027171130.56998-1-andriy.shevchenko@linux.intel.com>
 <0984da96-3da9-4e21-8088-f4bd9fb093d4@xilinx.com>
 <5ab9a2a1-20e3-c7b2-f666-2034df436e74@kernel.dk>
 <6f668246-e01c-c8d3-b985-53f705054cd0@xilinx.com>
From:   Michal Simek <michal.simek@xilinx.com>
Message-ID: <5112b536-ea20-947a-75ab-a535568a45e1@xilinx.com>
Date:   Mon, 9 Nov 2020 12:00:08 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <6f668246-e01c-c8d3-b985-53f705054cd0@xilinx.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9f669fa4-5b9b-4f23-2d14-08d8849ea3ec
X-MS-TrafficTypeDiagnostic: SN6PR02MB5151:
X-Microsoft-Antispam-PRVS: <SN6PR02MB51513A4A7301A5D805233503C6EA0@SN6PR02MB5151.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FuRuj/78kxYWEAClfAihdlOtFQghQd1y8MxufK3C6PA/qEQFIlILW1qp1zWF9QfZIiwIzMY/V7ZI5OiU8ibKhOQkDQurgThj78BnTr6Xpde0neXopBbvZ7yCY7tyqgQreZbjSriCZqnvypWWHvjaZwqL0Il2VZxY7uudvKO3Dpp6VVS5hOQHGol9DMP0Kf+PA277SwHxXROT3qnnZIxV3RhZ3wCQqu1v0IC22uJm+jwPHutUHqLAdY2GJSH1obWtNP34zZLFfAJaLr3qIDReKMtpa8557jaVjzgMF5ghtunwNlA6EotQB0/byIgUcD9dDQTcVXg1/l2MrRYny3OFkexvlJAomE1NJ7a0z8TBFCUUvw78NQh2xs7XyGDTv4NaZSARNI5pqquWSJawvhqDlZY9dK+EHrU9v7Q3gnq5hd91CdqLMF8Ax3gqQCvC2Y0VUUcuVwAlSRYWXTQoZZBvuyN34tQoiFbmCsFU9W+p/kw=
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch02.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(4636009)(396003)(376002)(346002)(136003)(39860400002)(46966005)(36906005)(2906002)(8676002)(8936002)(82310400003)(5660300002)(36756003)(9786002)(478600001)(110136005)(316002)(7636003)(336012)(44832011)(2616005)(70206006)(70586007)(6666004)(47076004)(82740400003)(356005)(426003)(83380400001)(31686004)(186003)(53546011)(26005)(31696002)(50156003)(43740500002)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2020 11:00:16.1875
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f669fa4-5b9b-4f23-2d14-08d8849ea3ec
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch02.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1NAM02FT006.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR02MB5151
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



On 30. 10. 20 8:08, Michal Simek wrote:
> 
> 
> On 29. 10. 20 15:22, Jens Axboe wrote:
>> On 10/29/20 1:18 AM, Michal Simek wrote:
>>> Hi Andy,
>>>
>>> On 27. 10. 20 18:11, Andy Shevchenko wrote:
>>>> Use platform_get_resource() to fetch the memory resource and
>>>> platform_get_irq_optional() to get optional IRQ instead of
>>>> open-coded variants.
>>>>
>>>> IRQ is not supposed to be changed at runtime, so there is
>>>> no functional change in ace_fsm_yieldirq().
>>>>
>>>> On the other hand we now take first resources instead of last ones
>>>> to proceed. I can't imagine how broken should be firmware to have
>>>> a garbage in the first resource slots. But if it the case, it needs
>>>> to be documented.
>>>>
>>>> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
>>>> ---
>>>>  drivers/block/xsysace.c | 49 ++++++++++++++++++++++-------------------
>>>>  1 file changed, 26 insertions(+), 23 deletions(-)
>>>>
>>>> diff --git a/drivers/block/xsysace.c b/drivers/block/xsysace.c
>>>> index 8d581c7536fb..eb8ef65778c3 100644
>>>> --- a/drivers/block/xsysace.c
>>>> +++ b/drivers/block/xsysace.c
>>>> @@ -443,22 +443,27 @@ static void ace_fix_driveid(u16 *id)
>>>>  #define ACE_FSM_NUM_STATES              11
>>>>  
>>>>  /* Set flag to exit FSM loop and reschedule tasklet */
>>>> -static inline void ace_fsm_yield(struct ace_device *ace)
>>>> +static inline void ace_fsm_yieldpoll(struct ace_device *ace)
>>>>  {
>>>> -	dev_dbg(ace->dev, "ace_fsm_yield()\n");
>>>>  	tasklet_schedule(&ace->fsm_tasklet);
>>>>  	ace->fsm_continue_flag = 0;
>>>>  }
>>>>  
>>>> +static inline void ace_fsm_yield(struct ace_device *ace)
>>>> +{
>>>> +	dev_dbg(ace->dev, "%s()\n", __func__);
>>>> +	ace_fsm_yieldpoll(ace);
>>>> +}
>>>> +
>>>>  /* Set flag to exit FSM loop and wait for IRQ to reschedule tasklet */
>>>>  static inline void ace_fsm_yieldirq(struct ace_device *ace)
>>>>  {
>>>>  	dev_dbg(ace->dev, "ace_fsm_yieldirq()\n");
>>>>  
>>>> -	if (!ace->irq)
>>>> -		/* No IRQ assigned, so need to poll */
>>>> -		tasklet_schedule(&ace->fsm_tasklet);
>>>> -	ace->fsm_continue_flag = 0;
>>>> +	if (ace->irq > 0)
>>>> +		ace->fsm_continue_flag = 0;
>>>> +	else
>>>> +		ace_fsm_yieldpoll(ace);
>>>>  }
>>>>  
>>>>  static bool ace_has_next_request(struct request_queue *q)
>>>> @@ -1053,12 +1058,12 @@ static int ace_setup(struct ace_device *ace)
>>>>  		ACE_CTRL_DATABUFRDYIRQ | ACE_CTRL_ERRORIRQ);
>>>>  
>>>>  	/* Now we can hook up the irq handler */
>>>> -	if (ace->irq) {
>>>> +	if (ace->irq > 0) {
>>>>  		rc = request_irq(ace->irq, ace_interrupt, 0, "systemace", ace);
>>>>  		if (rc) {
>>>>  			/* Failure - fall back to polled mode */
>>>>  			dev_err(ace->dev, "request_irq failed\n");
>>>> -			ace->irq = 0;
>>>> +			ace->irq = rc;
>>>>  		}
>>>>  	}
>>>>  
>>>> @@ -1110,7 +1115,7 @@ static void ace_teardown(struct ace_device *ace)
>>>>  
>>>>  	tasklet_kill(&ace->fsm_tasklet);
>>>>  
>>>> -	if (ace->irq)
>>>> +	if (ace->irq > 0)
>>>>  		free_irq(ace->irq, ace);
>>>>  
>>>>  	iounmap(ace->baseaddr);
>>>> @@ -1123,11 +1128,6 @@ static int ace_alloc(struct device *dev, int id, resource_size_t physaddr,
>>>>  	int rc;
>>>>  	dev_dbg(dev, "ace_alloc(%p)\n", dev);
>>>>  
>>>> -	if (!physaddr) {
>>>> -		rc = -ENODEV;
>>>> -		goto err_noreg;
>>>> -	}
>>>> -
>>>>  	/* Allocate and initialize the ace device structure */
>>>>  	ace = kzalloc(sizeof(struct ace_device), GFP_KERNEL);
>>>>  	if (!ace) {
>>>> @@ -1153,7 +1153,6 @@ static int ace_alloc(struct device *dev, int id, resource_size_t physaddr,
>>>>  	dev_set_drvdata(dev, NULL);
>>>>  	kfree(ace);
>>>>  err_alloc:
>>>> -err_noreg:
>>>>  	dev_err(dev, "could not initialize device, err=%i\n", rc);
>>>>  	return rc;
>>>>  }
>>>> @@ -1176,10 +1175,11 @@ static void ace_free(struct device *dev)
>>>>  
>>>>  static int ace_probe(struct platform_device *dev)
>>>>  {
>>>> -	resource_size_t physaddr = 0;
>>>>  	int bus_width = ACE_BUS_WIDTH_16; /* FIXME: should not be hard coded */
>>>> +	resource_size_t physaddr;
>>>> +	struct resource *res;
>>>>  	u32 id = dev->id;
>>>> -	int irq = 0;
>>>> +	int irq;
>>>>  	int i;
>>>>  
>>>>  	dev_dbg(&dev->dev, "ace_probe(%p)\n", dev);
>>>> @@ -1190,12 +1190,15 @@ static int ace_probe(struct platform_device *dev)
>>>>  	if (of_find_property(dev->dev.of_node, "8-bit", NULL))
>>>>  		bus_width = ACE_BUS_WIDTH_8;
>>>>  
>>>> -	for (i = 0; i < dev->num_resources; i++) {
>>>> -		if (dev->resource[i].flags & IORESOURCE_MEM)
>>>> -			physaddr = dev->resource[i].start;
>>>> -		if (dev->resource[i].flags & IORESOURCE_IRQ)
>>>> -			irq = dev->resource[i].start;
>>>> -	}
>>>> +	res = platform_get_resource(dev, IORESOURCE_MEM, 0);
>>>> +	if (!res)
>>>> +		return -EINVAL;
>>>> +
>>>> +	physaddr = res->start;
>>>> +	if (!physaddr)
>>>> +		return -ENODEV;
>>>> +
>>>> +	irq = platform_get_irq_optional(dev, 0);
>>>>  
>>>>  	/* Call the bus-independent setup code */
>>>>  	return ace_alloc(&dev->dev, id, physaddr, irq, bus_width);
>>>>
>>>
>>> This driver is quite old and obsolete. I am fine with whatever patch and
>>> I am also fine with marking driver as BROKEN or remove it because I am
>>> not aware about any user.
>>>
>>> Acked-by: Michal Simek <michal.simek@xilinx.com>
>>
>> How about I queue this one up for 5.10, and then we can queue a removal
>> patch for 5.11? Or at least schedule it for removal.
>>
> 
> Works for me. I will send removal patch for 5.11.

patch sent.
M

