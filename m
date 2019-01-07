Return-Path: <SRS0=Upb7=PP=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 388A3C43387
	for <linux-block@archiver.kernel.org>; Mon,  7 Jan 2019 16:06:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0510B2087F
	for <linux-block@archiver.kernel.org>; Mon,  7 Jan 2019 16:06:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="mB+PZFoH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728260AbfAGQGs (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 7 Jan 2019 11:06:48 -0500
Received: from mail-io1-f67.google.com ([209.85.166.67]:35532 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728308AbfAGQGs (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 7 Jan 2019 11:06:48 -0500
Received: by mail-io1-f67.google.com with SMTP id f4so721579ion.2
        for <linux-block@vger.kernel.org>; Mon, 07 Jan 2019 08:06:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=XtDT2JP307s8ZH2j7Q3doY0W4PCMWIm4eGNNhmfF5OE=;
        b=mB+PZFoHkA8I2m4TvLmXKQqF2eDHxbpPeZ8wESxPLb21IzH92hdtg8I888oHofmQlU
         c/SNQq/VGLeH7ZIhgMsG+AU+0CoZjT/yO3CKPtbzgLoAJfh7rK7yLfGd8G2+UcgMAW2P
         cUT86veo6clgeLTszQ0gxvdPtqIFt3X9TyLYL0WOIT2XJnHIyy0rVeHg/p/dh86za86y
         6JVXbWbRIwZ66yrOVCsy8yyClaYRwpZSnfFOlX7jS1vIhfb3+6MQK3hlFkPvkSBiJ8cT
         PnnHBkqrReGLZ4ioryupC+1aCLs4hl39RuIUnlHc2ItzqAf9mesXEcW0lEzW0qMCenwj
         jDkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=XtDT2JP307s8ZH2j7Q3doY0W4PCMWIm4eGNNhmfF5OE=;
        b=JdWXEi8okeFDGq8dZ1Z3P3lrzG02QslZa4xBsLMZUH63fUzFFBKTUFlvqUwT+D3a5C
         iyLN/Q699AGEiO1gb3eS8w3dwF8enXtIler/D8/dkFknEjChXDkR5PwW1P6jXIQSD+xY
         U2VQriW4wsuuLBey7+eFgNKxcWfEQ8XhFU13RfVSPxwTFU+jVDuS2mXeYk9KIIuGlo62
         lJuQVQYyZXX8MjyQQPD6s5fGrEc/ZWsL76A1knBiSd1qdXkkdvDL1hQUzxFe424p+x+p
         cGcmFLEcSSwQWg6kM4k92hk6qQpwPQIck3mpvn6yqtAMGDRS2mJh4vZIvKom6upINQQs
         ZtRg==
X-Gm-Message-State: AJcUukfhqL8ODAbFRyYX23+fjiS3CnEnsdf8DGuF+AH5W9m6l2oF/6Sr
        K3y5DqxragZoVjnOkP/+Txk3FhvuHY01dw==
X-Google-Smtp-Source: ALg8bN78mnqqk+rpMD3zyZQ2AXkNBH41IbVlnyGKOmYBrUnskCbH4aGwEKEbuTVeRTja7yDTUtwNXw==
X-Received: by 2002:a5e:a619:: with SMTP id q25mr44245301ioi.82.1546877206901;
        Mon, 07 Jan 2019 08:06:46 -0800 (PST)
Received: from [192.168.1.56] ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id 195sm4448724itm.2.2019.01.07.08.06.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 07 Jan 2019 08:06:45 -0800 (PST)
Subject: Re: [PATCH] block: don't show io_timeout if driver has no timeout
 handler
To:     Bart Van Assche <bvanassche@acm.org>, hch@infradead.org,
        linux-block@vger.kernel.org
References: <20190107125215.GA5039@192.168.3.9>
 <bdd9b6f8-4358-5d2e-d744-b2a89d6d4c5a@kernel.dk>
 <1546877098.83374.9.camel@acm.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <6d2ef1a5-94a2-a4a5-d60a-845c13a6bda1@kernel.dk>
Date:   Mon, 7 Jan 2019 09:06:44 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <1546877098.83374.9.camel@acm.org>
Content-Type: text/plain; charset=UTF-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 1/7/19 9:04 AM, Bart Van Assche wrote:
> On Mon, 2019-01-07 at 08:43 -0700, Jens Axboe wrote:
>> On 1/7/19 5:52 AM, Weiping Zhang wrote:
>>> If the low level driver has no timerout handler, the
>>> /sys/block/<disk>/queue/io_timeout will not be displayed.
>>
>> The alternative would be to make it return an error when read/written
>> instead of having this separate group code.
> 
> Hi Jens,
> 
> Christoph and I had asked Weiping to use a sysfs attribute group. See also
> https://www.mail-archive.com/linux-block@vger.kernel.org/msg25841.html

I think both solutions have parts that suck. If the file is only there
for some devices, that's a bit of an API wart. But at the same time, if the
file is there and not readable/writeable on those same devices, that's also
kind of ugly (as the wbt exercise has shown).

-- 
Jens Axboe

