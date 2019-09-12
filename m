Return-Path: <SRS0=MetK=XH=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B67FC4CEC7
	for <linux-block@archiver.kernel.org>; Thu, 12 Sep 2019 20:18:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0001B2084D
	for <linux-block@archiver.kernel.org>; Thu, 12 Sep 2019 20:18:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="KxOqhi12"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726529AbfILUSv (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 12 Sep 2019 16:18:51 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:45346 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726099AbfILUSv (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 12 Sep 2019 16:18:51 -0400
Received: by mail-pf1-f194.google.com with SMTP id y72so16629709pfb.12
        for <linux-block@vger.kernel.org>; Thu, 12 Sep 2019 13:18:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=zKchAKrBCbNjwn1FUHEEWdmCEcU1x6NNTSYvbbZuug4=;
        b=KxOqhi12TtHqM1CluyGypo1kqDCyv07Cibifo87wI2In7FdPx6eRr1NqIbT60LRMk6
         7yTYs98H3bAlSSj0cmLPxZzj6lpTJwBcUjPZj34Tslozfyyej4/kI6s1Zu+38WRi7BWG
         fgLzQlke88xagYBTbcpz/ROGhOuhIs6w4BYRaDtTtbc39gibqerq2p2BJ9nD0HRRJOse
         Y1Pg25F4V2BB+fWw5j7H7jWrGTcHPxInPOv0JoxeCgwSJ5Lr10cX4J19Bz0bJ1D6vmkF
         GBdqAS719A+vUTEm1NQvfr7yfx14a26YjgAKncFwH6NNsG/HF9NV1SYRcu2d7+y7CUMr
         Uktg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=zKchAKrBCbNjwn1FUHEEWdmCEcU1x6NNTSYvbbZuug4=;
        b=YWLOHcKrKylBPVkLCDfdqEdR0UwlYm0UQWVn+J6acIO51dpt3HMECxg240paxZkF81
         /GgfLRWDQZynqY5FHpLCKkIQshsoWMfSrGLhqJyXeByPAwdFeC73YbcqxG7PIn8s9I3D
         RJez7FENfw/BelTcobg2tD1BO4AudzNzp+V8EdWdxohWhYqGqsNnhQgTjXudONROfeSu
         P70x82dvjnYWV8KUTeexp42fAt5yVdj45xzjjqev/QoR9v4JEfqzSkaKyPaaRpgwAbFs
         swkzResU2iEdywf95IlacqmCsjgFMnxeR1EZmhpXUS063Lg+jTbY0MJwO+im9fwDwABh
         iU8Q==
X-Gm-Message-State: APjAAAUcC+yjEjH+bgBZiUt5Z54DI5FF+5lAj/zgB2ze6Jz7GuZwwTgc
        /B+kOjWTW0bvYlIX63WQprg9nhJpL+Y=
X-Google-Smtp-Source: APXvYqyVirsgEYxZGEunHRuSdfI1ve2flmK2VuZnIIkN3iX6/tfvjwOLoFmjpVmO2yE/Q2Z0xkzyxg==
X-Received: by 2002:a63:4b02:: with SMTP id y2mr39264352pga.135.1568319528412;
        Thu, 12 Sep 2019 13:18:48 -0700 (PDT)
Received: from ?IPv6:2600:380:4b35:ccb0:f0cb:c243:15f:c2c0? ([2600:380:4b35:ccb0:f0cb:c243:15f:c2c0])
        by smtp.gmail.com with ESMTPSA id w187sm4092240pgw.88.2019.09.12.13.18.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 12 Sep 2019 13:18:47 -0700 (PDT)
Subject: Re: [PATCH] io_uring: extend async work merging
To:     Jeff Moyer <jmoyer@redhat.com>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
References: <0b62fee7-d3bd-f60e-ae81-27880f42d508@kernel.dk>
 <x49o8zptgr3.fsf@segfault.boston.devel.redhat.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <cf7e27fd-8e6f-a616-5e29-008f9881e700@kernel.dk>
Date:   Thu, 12 Sep 2019 14:18:44 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <x49o8zptgr3.fsf@segfault.boston.devel.redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 9/12/19 2:13 PM, Jeff Moyer wrote:
> Jens Axboe <axboe@kernel.dk> writes:
> 
>> We currently merge async work items if we see a strict sequential hit.
>> This helps avoid unnecessary workqueue switches when we don't need
>> them. We can extend this merging to cover cases where it's not a strict
>> sequential hit, but the IO still fits within the same page. If an
>> application is doing multiple requests within the same page, we don't
>> want separate workers waiting on the same page to complete IO. It's much
>> faster to let the first worker bring in the page, then operate on that
>> page from the same worker to complete the next request(s).
>>
>> Signed-off-by: Jens Axboe <axboe@kernel.dk>
> 
> Reviewed-by: Jeff Moyer <jmoyer@redhat.com>
> 
> Minor nit below.
> 
>> @@ -1994,7 +2014,7 @@ static void io_sq_wq_submit_work(struct work_struct *work)
>>    */
>>   static bool io_add_to_prev_work(struct async_list *list, struct io_kiocb *req)
>>   {
>> -	bool ret = false;
>> +	bool ret;
>>   
>>   	if (!list)
>>   		return false;
> 
> This hunk looks unrelated.  Also, I think you could actually change that
> to be initialized to true, and get rid of the assignment later:

Yeah I could, but that would have added more unrelated changes... I'm
fine with it later, even though the compiler probably takes care of it.

-- 
Jens Axboe

