Return-Path: <SRS0=RRdq=EE=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E04F5C2D0A3
	for <linux-block@archiver.kernel.org>; Thu, 29 Oct 2020 07:34:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 67D972076A
	for <linux-block@archiver.kernel.org>; Thu, 29 Oct 2020 07:34:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="MDM2gYry"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728036AbgJ2He0 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 29 Oct 2020 03:34:26 -0400
Received: from mail-bn8nam12on2076.outbound.protection.outlook.com ([40.107.237.76]:58586
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727345AbgJ2HeT (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 29 Oct 2020 03:34:19 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TmkAnO1oatz4i8PrEPdBpiz6+QFa27NhtJeMShQv3dH9I8q7HLwcLXPC+7O9LSC+EQv1xoNr1tRubXoHsOjyLJeIqub8vh8Crmpva79nLHA035/0q+35VzvRzBN7MWvRbEw216vPNPhiTlHNmoMNSteEAwgqClv+7OHnfE/0NrGCm+RZQ6k8av1z8NOU0v+28zAkcdrx6im8STBhHPy1ez3zz9U3SIbn5x5/sxl8ZDWhqiCb/UE7I/Lqpwve2D+hccluIZlJc+B8AyCFXHylSSnc/VZwGp7Y+/YiipfLcfniCTe7MNaIMdAm66oxpe/3RRbn4H6pbuWFnk6T0Z49xw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ERMYo+G17n0tQYeG7K999kNPxCHF+qiwNDwXDsYOV3o=;
 b=WVYD3CWHaXv9A0h9mRmSOALg6a9WN/uCNpvatDVq71oAmJjS5SF0yNMZqXAB0JHn2wjdP3TjGwNoJ31TjDhi71CNloHBM3Pof71ZmF33/ZG0B8CxVnmBcfatsSEYK3dtl97alWAbhYFfvdMIv6oH2ZIbjQHWSusx1xRpzacsn6gxisAnP3fJH+1c+25iWrqKWVOB4Nu1qDCmfXnsIMhH42ZTajuWRIjzNWnZVV2YkVJ8OAnH+wCVHe7kreLEPI5FosOBlF33eH8LbNEvKeoVDeG/FKid5/LgdFiSXhz+Yk0bJ694/gV35JjPp6a9PodpskL/ez7NtKdgFmYitPeQng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ERMYo+G17n0tQYeG7K999kNPxCHF+qiwNDwXDsYOV3o=;
 b=MDM2gYrysmAzK8e5tlSVq/aU3J2pThyoE0F4cvFznrz+FoXz1V1N09i3faW1efMrMjgEu9xNtSXAolCTDXFcbhT8/Dj+Lg8Khc4I3H69gWeMSPXjxosY28krKgJwFZzuUTdOfc1X71B54qb7+ETYkVRxxZzhma5fsGUinbvhLpY=
Received: from SA9PR13CA0067.namprd13.prod.outlook.com (2603:10b6:806:23::12)
 by DM6PR02MB4348.namprd02.prod.outlook.com (2603:10b6:5:1f::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.27; Thu, 29 Oct
 2020 07:18:21 +0000
Received: from SN1NAM02FT021.eop-nam02.prod.protection.outlook.com
 (2603:10b6:806:23:cafe::c2) by SA9PR13CA0067.outlook.office365.com
 (2603:10b6:806:23::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.19 via Frontend
 Transport; Thu, 29 Oct 2020 07:18:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch02.xlnx.xilinx.com;
Received: from xsj-pvapexch02.xlnx.xilinx.com (149.199.62.198) by
 SN1NAM02FT021.mail.protection.outlook.com (10.152.72.144) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3520.15 via Frontend Transport; Thu, 29 Oct 2020 07:18:20 +0000
Received: from xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1913.5; Thu, 29 Oct 2020 00:18:19 -0700
Received: from smtp.xilinx.com (172.19.127.95) by
 xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) with Microsoft SMTP Server id
 15.1.1913.5 via Frontend Transport; Thu, 29 Oct 2020 00:18:19 -0700
Envelope-to: michal.simek@xilinx.com,
 linux-block@vger.kernel.org,
 axboe@kernel.dk,
 linux-arm-kernel@lists.infradead.org,
 andriy.shevchenko@linux.intel.com
Received: from [172.30.17.110] (port=44742)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <michal.simek@xilinx.com>)
        id 1kY2CQ-0005aW-W7; Thu, 29 Oct 2020 00:18:19 -0700
Subject: Re: [PATCH v1] xsysace: use platform_get_resource() and
 platform_get_irq_optional()
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Michal Simek <michal.simek@xilinx.com>,
        <linux-arm-kernel@lists.infradead.org>,
        Jens Axboe <axboe@kernel.dk>, <linux-block@vger.kernel.org>
References: <20201027171130.56998-1-andriy.shevchenko@linux.intel.com>
From:   Michal Simek <michal.simek@xilinx.com>
Autocrypt: addr=michals@xilinx.com; keydata=
 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
 0Z1MQlmNcq2bhOMzTxuXX2NDzUZs4aqEyZQ=
Message-ID: <0984da96-3da9-4e21-8088-f4bd9fb093d4@xilinx.com>
Date:   Thu, 29 Oct 2020 08:18:16 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
MIME-Version: 1.0
In-Reply-To: <20201027171130.56998-1-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 49002ff8-9b74-4c39-c7c2-08d87bdad08a
X-MS-TrafficTypeDiagnostic: DM6PR02MB4348:
X-Microsoft-Antispam-PRVS: <DM6PR02MB4348B96796B2BB7A3E17643FC6140@DM6PR02MB4348.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: E4aqNpM/AIamGZlDRsFgdwggtYxMFmaeb0yjtMvKLVPjc6bLU1pRv4bofJ0IqAoPssRVbrM9Wi55pY7PH8dqHBWtU2N3gZrVBF3azCZymcxQAiZSjjDxBfhmt78XrRKfVDVe7Gv9McBevi5Cx+Z5ZCWRDYNoDwMBCGpkheWsYYGNlsz4bgUQrFFSDp5/S4nToQ//pNxYpJRRvkhxhxAqHFNjWdj3YsHIRT5ZgNOCasfZnbYSXQpeBBU5MSuJFi0QWSiG9qLpdfLeETOwfdGpZBm6h9ewKOUEylF76IxXicSZw1rVwzeX9z0JLKrAmMjg2h80WY9Y8XzBkUo02KHl0ruzsTyePXNjUPIN1MuaK3ORh3RURVf6rtG49VwkxeMAGQmyYrklnWotqCaJIn+NGsihZAsAsk+ciAPGJ4l62YLMlXkmClnF1HPMSB8yNhKoj3Exe1bVHdSoQCz7HgcHpw==
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch02.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(4636009)(136003)(346002)(39860400002)(376002)(396003)(46966005)(70206006)(70586007)(478600001)(316002)(9786002)(110136005)(47076004)(336012)(44832011)(356005)(82740400003)(6666004)(26005)(31686004)(83380400001)(5660300002)(2616005)(31696002)(186003)(7636003)(8936002)(8676002)(2906002)(82310400003)(426003)(36756003)(50156003)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2020 07:18:20.3958
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 49002ff8-9b74-4c39-c7c2-08d87bdad08a
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch02.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1NAM02FT021.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR02MB4348
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Andy,

On 27. 10. 20 18:11, Andy Shevchenko wrote:
> Use platform_get_resource() to fetch the memory resource and
> platform_get_irq_optional() to get optional IRQ instead of
> open-coded variants.
> 
> IRQ is not supposed to be changed at runtime, so there is
> no functional change in ace_fsm_yieldirq().
> 
> On the other hand we now take first resources instead of last ones
> to proceed. I can't imagine how broken should be firmware to have
> a garbage in the first resource slots. But if it the case, it needs
> to be documented.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/block/xsysace.c | 49 ++++++++++++++++++++++-------------------
>  1 file changed, 26 insertions(+), 23 deletions(-)
> 
> diff --git a/drivers/block/xsysace.c b/drivers/block/xsysace.c
> index 8d581c7536fb..eb8ef65778c3 100644
> --- a/drivers/block/xsysace.c
> +++ b/drivers/block/xsysace.c
> @@ -443,22 +443,27 @@ static void ace_fix_driveid(u16 *id)
>  #define ACE_FSM_NUM_STATES              11
>  
>  /* Set flag to exit FSM loop and reschedule tasklet */
> -static inline void ace_fsm_yield(struct ace_device *ace)
> +static inline void ace_fsm_yieldpoll(struct ace_device *ace)
>  {
> -	dev_dbg(ace->dev, "ace_fsm_yield()\n");
>  	tasklet_schedule(&ace->fsm_tasklet);
>  	ace->fsm_continue_flag = 0;
>  }
>  
> +static inline void ace_fsm_yield(struct ace_device *ace)
> +{
> +	dev_dbg(ace->dev, "%s()\n", __func__);
> +	ace_fsm_yieldpoll(ace);
> +}
> +
>  /* Set flag to exit FSM loop and wait for IRQ to reschedule tasklet */
>  static inline void ace_fsm_yieldirq(struct ace_device *ace)
>  {
>  	dev_dbg(ace->dev, "ace_fsm_yieldirq()\n");
>  
> -	if (!ace->irq)
> -		/* No IRQ assigned, so need to poll */
> -		tasklet_schedule(&ace->fsm_tasklet);
> -	ace->fsm_continue_flag = 0;
> +	if (ace->irq > 0)
> +		ace->fsm_continue_flag = 0;
> +	else
> +		ace_fsm_yieldpoll(ace);
>  }
>  
>  static bool ace_has_next_request(struct request_queue *q)
> @@ -1053,12 +1058,12 @@ static int ace_setup(struct ace_device *ace)
>  		ACE_CTRL_DATABUFRDYIRQ | ACE_CTRL_ERRORIRQ);
>  
>  	/* Now we can hook up the irq handler */
> -	if (ace->irq) {
> +	if (ace->irq > 0) {
>  		rc = request_irq(ace->irq, ace_interrupt, 0, "systemace", ace);
>  		if (rc) {
>  			/* Failure - fall back to polled mode */
>  			dev_err(ace->dev, "request_irq failed\n");
> -			ace->irq = 0;
> +			ace->irq = rc;
>  		}
>  	}
>  
> @@ -1110,7 +1115,7 @@ static void ace_teardown(struct ace_device *ace)
>  
>  	tasklet_kill(&ace->fsm_tasklet);
>  
> -	if (ace->irq)
> +	if (ace->irq > 0)
>  		free_irq(ace->irq, ace);
>  
>  	iounmap(ace->baseaddr);
> @@ -1123,11 +1128,6 @@ static int ace_alloc(struct device *dev, int id, resource_size_t physaddr,
>  	int rc;
>  	dev_dbg(dev, "ace_alloc(%p)\n", dev);
>  
> -	if (!physaddr) {
> -		rc = -ENODEV;
> -		goto err_noreg;
> -	}
> -
>  	/* Allocate and initialize the ace device structure */
>  	ace = kzalloc(sizeof(struct ace_device), GFP_KERNEL);
>  	if (!ace) {
> @@ -1153,7 +1153,6 @@ static int ace_alloc(struct device *dev, int id, resource_size_t physaddr,
>  	dev_set_drvdata(dev, NULL);
>  	kfree(ace);
>  err_alloc:
> -err_noreg:
>  	dev_err(dev, "could not initialize device, err=%i\n", rc);
>  	return rc;
>  }
> @@ -1176,10 +1175,11 @@ static void ace_free(struct device *dev)
>  
>  static int ace_probe(struct platform_device *dev)
>  {
> -	resource_size_t physaddr = 0;
>  	int bus_width = ACE_BUS_WIDTH_16; /* FIXME: should not be hard coded */
> +	resource_size_t physaddr;
> +	struct resource *res;
>  	u32 id = dev->id;
> -	int irq = 0;
> +	int irq;
>  	int i;
>  
>  	dev_dbg(&dev->dev, "ace_probe(%p)\n", dev);
> @@ -1190,12 +1190,15 @@ static int ace_probe(struct platform_device *dev)
>  	if (of_find_property(dev->dev.of_node, "8-bit", NULL))
>  		bus_width = ACE_BUS_WIDTH_8;
>  
> -	for (i = 0; i < dev->num_resources; i++) {
> -		if (dev->resource[i].flags & IORESOURCE_MEM)
> -			physaddr = dev->resource[i].start;
> -		if (dev->resource[i].flags & IORESOURCE_IRQ)
> -			irq = dev->resource[i].start;
> -	}
> +	res = platform_get_resource(dev, IORESOURCE_MEM, 0);
> +	if (!res)
> +		return -EINVAL;
> +
> +	physaddr = res->start;
> +	if (!physaddr)
> +		return -ENODEV;
> +
> +	irq = platform_get_irq_optional(dev, 0);
>  
>  	/* Call the bus-independent setup code */
>  	return ace_alloc(&dev->dev, id, physaddr, irq, bus_width);
> 

This driver is quite old and obsolete. I am fine with whatever patch and
I am also fine with marking driver as BROKEN or remove it because I am
not aware about any user.

Acked-by: Michal Simek <michal.simek@xilinx.com>

Thanks,
Michal
