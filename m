Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAB7EC77B75
	for <linux-block@archiver.kernel.org>; Wed, 17 May 2023 22:07:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229733AbjEQWHv (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 17 May 2023 18:07:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbjEQWHu (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 17 May 2023 18:07:50 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C4E926B9
        for <linux-block@vger.kernel.org>; Wed, 17 May 2023 15:07:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3178D64B3B
        for <linux-block@vger.kernel.org>; Wed, 17 May 2023 22:07:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1CDFC433EF;
        Wed, 17 May 2023 22:07:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684361268;
        bh=bRJuioNZARRWfIRT/raY8il0x7nQx3Og6MIU+Sn2PzI=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=ENwAZaxiWxNaLxs46qjnpWraPXU0d4VBNxONUuYpy0KVfxdfX1gkQS6vNBUuyOjpP
         yrDSI7X11H8qYvd5R+jbc4SpcaqbpFWZxKiIyC12x3DqFRuc5zYROplJVKBdPzbNzP
         +aM1YyuCiWK1ydX0vqbQRD5R7KVO/1q4V5M7l7N/DYNsp4lvHvxE6jb9GXVLJAs8nC
         qKSeHM5+WH7iwAQjL+4zmVHDjSoLT9WOMhWEAOCe9y8VdkOsb2/C9IQV2bYK2AkI79
         7jxd/K4gEJHSv7SZZZRlmdSbTEAasuEANQs8n4jDYNDeavzDgZx8NDqzO0DmtADfAZ
         3cu7T5GbVDrGg==
Message-ID: <a6775f96-13d5-ca61-21e0-7d25468dadae@kernel.org>
Date:   Thu, 18 May 2023 07:07:47 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v5 05/11] block: mq-deadline: Clean up
 deadline_check_fifo()
Content-Language: en-US
To:     Bart Van Assche <bvanassche@acm.org>, Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Jaegeuk Kim <jaegeuk@kernel.org>,
        Christoph Hellwig <hch@lst.de>, Ming Lei <ming.lei@redhat.com>
References: <20230516223323.1383342-1-bvanassche@acm.org>
 <20230516223323.1383342-6-bvanassche@acm.org>
 <c46b14b0-56e3-ace9-91f7-15434ae93c2e@kernel.org>
 <44be286c-37ff-cda5-6aa1-b9e8ff3e194b@acm.org>
From:   Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <44be286c-37ff-cda5-6aa1-b9e8ff3e194b@acm.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 5/18/23 00:01, Bart Van Assche wrote:
> On 5/16/23 18:02, Damien Le Moal wrote:
>> On 5/17/23 07:33, Bart Van Assche wrote:
>>> -	if (time_after_eq(jiffies, (unsigned long)rq->fifo_time))
>>> -		return 1;
>>> -
>>> -	return 0;
>>> +	return time_is_before_eq_jiffies((unsigned long)rq->fifo_time);
>>
>> This looks wrong: isn't this reversing the return value ?
>> Shouldn't this be:
>>
>> 	return time_after_eq(jiffies, (unsigned long)rq->fifo_time));
>>
>> To return true if the first request in fifo list *expired* as indicated by the
>> function kdoc comment.
> 
> Hi Damien,
> 
>  From include/linux/jiffies.h:
> 
> #define time_is_before_eq_jiffies(a) time_after_eq(jiffies, a)

Thanks for clarifying. However, it begs the question: is this macro name correct
at all ? Why does "after" is changed to "before" ? That seems bogus to me at
worst and super confusing at best. This macro should really be:

#define time_after_eq_jiffies(a) time_after_eq(jiffies, a)

> 
> Hence, time_is_before_eq_jiffies((unsigned long)rq->fifo_time) is 
> equivalent to time_after_eq(jiffies, (unsigned long)rq->fifo_time). Both 
> expressions check whether or not rq->fifo_time is in the past.
> 
> Bart.

-- 
Damien Le Moal
Western Digital Research

