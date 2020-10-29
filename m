Return-Path: <SRS0=RRdq=EE=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01318C55179
	for <linux-block@archiver.kernel.org>; Thu, 29 Oct 2020 14:23:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9234B20780
	for <linux-block@archiver.kernel.org>; Thu, 29 Oct 2020 14:23:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="vwO2UWmp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727048AbgJ2OXa (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 29 Oct 2020 10:23:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727110AbgJ2OWe (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 29 Oct 2020 10:22:34 -0400
Received: from mail-il1-x141.google.com (mail-il1-x141.google.com [IPv6:2607:f8b0:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61070C0613D3
        for <linux-block@vger.kernel.org>; Thu, 29 Oct 2020 07:22:17 -0700 (PDT)
Received: by mail-il1-x141.google.com with SMTP id p10so3197036ile.3
        for <linux-block@vger.kernel.org>; Thu, 29 Oct 2020 07:22:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=sQRj5N/aF3eetL2rUSxdHEyKS2lo4mkjgZcNpsnLN7A=;
        b=vwO2UWmpB20XPaSMqyO3ukX69Rye+HWIa3SwOLgy6LjJ5aabPcGHy8ZcRdwKFF/29R
         TJlr1Mwrufv8+SHlGI8R8YXfeOFNryH6uxYzWiWvCdDSe8uJ7yD8x3j9iLw8H7ZVXJro
         cP3tn+7LasqEaQlKtewY/nNbZ5Qm8D4sAPzVnb03NxbdPQzh+F+qOso+n2CodHMmZQUM
         UJZcC8RFAn3MIkrTvcjB7364xSM6dpDUxsKnEZ1iuaEt5oHsezw4uri/9M2wNyZikdAb
         ngpF1YlAE8JfXZHb4DqKrm120uslarHhHJkVfpg4bmmEMqcT2VgqecE5a5zclKxYou73
         EpBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=sQRj5N/aF3eetL2rUSxdHEyKS2lo4mkjgZcNpsnLN7A=;
        b=cWZKYIQxum55N/k2zDeTYgvYtiJT72QLYkSYZylqtN4FSEtaAKsY2clIvt2wB61ai2
         igrwn5bhsgEFT+DjyLRhtghMFNTPzsgO7ztL+WXI7Vg7zYyb68as8xj3uL3P303xWzIz
         +rLtQiX/sYfxL/8Pc2mJm2Ucy7C1NiS0wS5xPvLJy8pND7LMB6VMWj4L7YQnfLxn5XSd
         scj8YOJTOA4g65Vf4KI4RFSmLZ+PKYFwVv3KXWHfJZn6J+OBf/vOJvdbaj0esennezly
         v8ABmDvif2YLFrsJ5mqiS0MdM+1vHuGhNu9RW2tfML8JUCubB/huF0e8ItmYZSasOM9h
         JA7g==
X-Gm-Message-State: AOAM530CWrqLZ2aVzN5X7t8zVT++AI96tJzt8/Kd1giMNIHgRVMMkX2t
        e20YkdN1ZoubAhAh8gvQ0V7naUI4MEBVdA==
X-Google-Smtp-Source: ABdhPJwhQgxUyrBKUa12RfimV3cooYsMnJxa3ESC2d1x5u+dGSYF3ep2TZB6ypTplfMZ5+qObyheHA==
X-Received: by 2002:a05:6e02:11b3:: with SMTP id 19mr3362078ilj.55.1603981336221;
        Thu, 29 Oct 2020 07:22:16 -0700 (PDT)
Received: from [192.168.1.30] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id c2sm2119741ioc.29.2020.10.29.07.22.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Oct 2020 07:22:14 -0700 (PDT)
Subject: Re: [PATCH v1] xsysace: use platform_get_resource() and
 platform_get_irq_optional()
To:     Michal Simek <michal.simek@xilinx.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-arm-kernel@lists.infradead.org, linux-block@vger.kernel.org
References: <20201027171130.56998-1-andriy.shevchenko@linux.intel.com>
 <0984da96-3da9-4e21-8088-f4bd9fb093d4@xilinx.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <5ab9a2a1-20e3-c7b2-f666-2034df436e74@kernel.dk>
Date:   Thu, 29 Oct 2020 08:22:14 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <0984da96-3da9-4e21-8088-f4bd9fb093d4@xilinx.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 10/29/20 1:18 AM, Michal Simek wrote:
> Hi Andy,
> 
> On 27. 10. 20 18:11, Andy Shevchenko wrote:
>> Use platform_get_resource() to fetch the memory resource and
>> platform_get_irq_optional() to get optional IRQ instead of
>> open-coded variants.
>>
>> IRQ is not supposed to be changed at runtime, so there is
>> no functional change in ace_fsm_yieldirq().
>>
>> On the other hand we now take first resources instead of last ones
>> to proceed. I can't imagine how broken should be firmware to have
>> a garbage in the first resource slots. But if it the case, it needs
>> to be documented.
>>
>> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
>> ---
>>  drivers/block/xsysace.c | 49 ++++++++++++++++++++++-------------------
>>  1 file changed, 26 insertions(+), 23 deletions(-)
>>
>> diff --git a/drivers/block/xsysace.c b/drivers/block/xsysace.c
>> index 8d581c7536fb..eb8ef65778c3 100644
>> --- a/drivers/block/xsysace.c
>> +++ b/drivers/block/xsysace.c
>> @@ -443,22 +443,27 @@ static void ace_fix_driveid(u16 *id)
>>  #define ACE_FSM_NUM_STATES              11
>>  
>>  /* Set flag to exit FSM loop and reschedule tasklet */
>> -static inline void ace_fsm_yield(struct ace_device *ace)
>> +static inline void ace_fsm_yieldpoll(struct ace_device *ace)
>>  {
>> -	dev_dbg(ace->dev, "ace_fsm_yield()\n");
>>  	tasklet_schedule(&ace->fsm_tasklet);
>>  	ace->fsm_continue_flag = 0;
>>  }
>>  
>> +static inline void ace_fsm_yield(struct ace_device *ace)
>> +{
>> +	dev_dbg(ace->dev, "%s()\n", __func__);
>> +	ace_fsm_yieldpoll(ace);
>> +}
>> +
>>  /* Set flag to exit FSM loop and wait for IRQ to reschedule tasklet */
>>  static inline void ace_fsm_yieldirq(struct ace_device *ace)
>>  {
>>  	dev_dbg(ace->dev, "ace_fsm_yieldirq()\n");
>>  
>> -	if (!ace->irq)
>> -		/* No IRQ assigned, so need to poll */
>> -		tasklet_schedule(&ace->fsm_tasklet);
>> -	ace->fsm_continue_flag = 0;
>> +	if (ace->irq > 0)
>> +		ace->fsm_continue_flag = 0;
>> +	else
>> +		ace_fsm_yieldpoll(ace);
>>  }
>>  
>>  static bool ace_has_next_request(struct request_queue *q)
>> @@ -1053,12 +1058,12 @@ static int ace_setup(struct ace_device *ace)
>>  		ACE_CTRL_DATABUFRDYIRQ | ACE_CTRL_ERRORIRQ);
>>  
>>  	/* Now we can hook up the irq handler */
>> -	if (ace->irq) {
>> +	if (ace->irq > 0) {
>>  		rc = request_irq(ace->irq, ace_interrupt, 0, "systemace", ace);
>>  		if (rc) {
>>  			/* Failure - fall back to polled mode */
>>  			dev_err(ace->dev, "request_irq failed\n");
>> -			ace->irq = 0;
>> +			ace->irq = rc;
>>  		}
>>  	}
>>  
>> @@ -1110,7 +1115,7 @@ static void ace_teardown(struct ace_device *ace)
>>  
>>  	tasklet_kill(&ace->fsm_tasklet);
>>  
>> -	if (ace->irq)
>> +	if (ace->irq > 0)
>>  		free_irq(ace->irq, ace);
>>  
>>  	iounmap(ace->baseaddr);
>> @@ -1123,11 +1128,6 @@ static int ace_alloc(struct device *dev, int id, resource_size_t physaddr,
>>  	int rc;
>>  	dev_dbg(dev, "ace_alloc(%p)\n", dev);
>>  
>> -	if (!physaddr) {
>> -		rc = -ENODEV;
>> -		goto err_noreg;
>> -	}
>> -
>>  	/* Allocate and initialize the ace device structure */
>>  	ace = kzalloc(sizeof(struct ace_device), GFP_KERNEL);
>>  	if (!ace) {
>> @@ -1153,7 +1153,6 @@ static int ace_alloc(struct device *dev, int id, resource_size_t physaddr,
>>  	dev_set_drvdata(dev, NULL);
>>  	kfree(ace);
>>  err_alloc:
>> -err_noreg:
>>  	dev_err(dev, "could not initialize device, err=%i\n", rc);
>>  	return rc;
>>  }
>> @@ -1176,10 +1175,11 @@ static void ace_free(struct device *dev)
>>  
>>  static int ace_probe(struct platform_device *dev)
>>  {
>> -	resource_size_t physaddr = 0;
>>  	int bus_width = ACE_BUS_WIDTH_16; /* FIXME: should not be hard coded */
>> +	resource_size_t physaddr;
>> +	struct resource *res;
>>  	u32 id = dev->id;
>> -	int irq = 0;
>> +	int irq;
>>  	int i;
>>  
>>  	dev_dbg(&dev->dev, "ace_probe(%p)\n", dev);
>> @@ -1190,12 +1190,15 @@ static int ace_probe(struct platform_device *dev)
>>  	if (of_find_property(dev->dev.of_node, "8-bit", NULL))
>>  		bus_width = ACE_BUS_WIDTH_8;
>>  
>> -	for (i = 0; i < dev->num_resources; i++) {
>> -		if (dev->resource[i].flags & IORESOURCE_MEM)
>> -			physaddr = dev->resource[i].start;
>> -		if (dev->resource[i].flags & IORESOURCE_IRQ)
>> -			irq = dev->resource[i].start;
>> -	}
>> +	res = platform_get_resource(dev, IORESOURCE_MEM, 0);
>> +	if (!res)
>> +		return -EINVAL;
>> +
>> +	physaddr = res->start;
>> +	if (!physaddr)
>> +		return -ENODEV;
>> +
>> +	irq = platform_get_irq_optional(dev, 0);
>>  
>>  	/* Call the bus-independent setup code */
>>  	return ace_alloc(&dev->dev, id, physaddr, irq, bus_width);
>>
> 
> This driver is quite old and obsolete. I am fine with whatever patch and
> I am also fine with marking driver as BROKEN or remove it because I am
> not aware about any user.
> 
> Acked-by: Michal Simek <michal.simek@xilinx.com>

How about I queue this one up for 5.10, and then we can queue a removal
patch for 5.11? Or at least schedule it for removal.

-- 
Jens Axboe

