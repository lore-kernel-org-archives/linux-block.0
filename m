Return-Path: <SRS0=ti8e=YB=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE4CDC4360C
	for <linux-block@archiver.kernel.org>; Tue,  8 Oct 2019 17:31:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B5B072190F
	for <linux-block@archiver.kernel.org>; Tue,  8 Oct 2019 17:31:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729069AbfJHRbC (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 8 Oct 2019 13:31:02 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:36795 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727363AbfJHRbC (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 8 Oct 2019 13:31:02 -0400
Received: by mail-pl1-f195.google.com with SMTP id j11so8770432plk.3;
        Tue, 08 Oct 2019 10:31:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=QpKqt/OKHD6qPZcZY6Aps7Fd9bEMnqahmZuN7uH5iSs=;
        b=jZRw/aYdG3uXkju1gxitYziu0q6JpK189y/3ufcw/HnVYgv9XLwWUku6ORG9h4xBOv
         Z5Si4B9e8i/+Do7EoSsoXVlB5+zDpbdHoEvHOB6T0P23axTEQCyffEw7mNKZPmdIfyTt
         RiAhvjhYetpBtT+APA0zY/wW+6Mvb6cW8R/ppAskqRY50MiwglVureD/1SUqyuVznb5h
         Cnl2mg6o8XBjSWd/bILg5EN2BQM1c3yBk8aRjofFe7QqyK33xCEFdoS5QGpmoRYPNmCk
         SEUZqpLHoE0e6uUiUJi9J2gsZymMxGhFlc9bxk1a37vHekPTnQ4hb/+dfhpocu57QuJs
         5WGg==
X-Gm-Message-State: APjAAAVGkMUQ7tTHXMLTclmtoOzHNJKfc5F53wttYeNATNbBl3YrmT+0
        JLPNRxeV8mE9Wh40E+Z/6uyP3dW5
X-Google-Smtp-Source: APXvYqxk0GB/AQZveJRkPikWLRZVQXRjbbShrU6kZVngJPrzNB76NuFBEAIT6JIyqGNhEZ+oKiFBEw==
X-Received: by 2002:a17:902:2e:: with SMTP id 43mr37601241pla.55.1570555860928;
        Tue, 08 Oct 2019 10:31:00 -0700 (PDT)
Received: from desktop-bart.svl.corp.google.com ([2620:15c:2cd:202:4308:52a3:24b6:2c60])
        by smtp.gmail.com with ESMTPSA id v43sm2791370pjb.1.2019.10.08.10.30.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Oct 2019 10:31:00 -0700 (PDT)
Subject: Re: [PATCH v2 1/1] blk-mq: fill header with kernel-doc
To:     Gabriel Krisman Bertazi <krisman@collabora.com>,
        =?UTF-8?Q?Andr=c3=a9_Almeida?= <andrealmeid@collabora.com>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        axboe@kernel.dk, kernel@collabora.com
References: <20191008001416.12656-1-andrealmeid@collabora.com>
 <854l0j19go.fsf@collabora.com>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <6aa48cd2-5f23-a4be-f777-d65bf755a976@acm.org>
Date:   Tue, 8 Oct 2019 10:30:58 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <854l0j19go.fsf@collabora.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 10/8/19 9:35 AM, Gabriel Krisman Bertazi wrote:
> André Almeida <andrealmeid@collabora.com> writes:
> 
>> diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
>> index e0fce93ac127..8b745f229789 100644
>> --- a/include/linux/blk-mq.h
>> +++ b/include/linux/blk-mq.h
>> @@ -10,74 +10,153 @@ struct blk_mq_tags;
>>   struct blk_flush_queue;
>>   
>>   /**
>> - * struct blk_mq_hw_ctx - State for a hardware queue facing the hardware block device
>> + * struct blk_mq_hw_ctx - State for a hardware queue facing the hardware
>> + * block device
>>    */
>>   struct blk_mq_hw_ctx {
>>   	struct {
>> +		/** @lock: Lock for accessing dispatch queue */
>>   		spinlock_t		lock;
>> +		/**
>> +		 * @dispatch: Queue of dispatched requests, waiting for
>> +		 * workers to send them to the hardware.
>> +		 */
> 
> It's been a few years since I looked at the block layer, but isn't
> this used to hold requests that were taken from the blk_mq_ctx,  but
> couldn't be dispatched because the queue was full?

I don't think so. I think that you are looking for the requeue_list 
member of struct request_queue.

Bart.
