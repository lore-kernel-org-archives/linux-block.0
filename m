Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83732C4707F
	for <linux-block@archiver.kernel.org>; Thu, 27 May 2021 19:30:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 66224613E3
	for <linux-block@archiver.kernel.org>; Thu, 27 May 2021 19:30:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235392AbhE0TcW (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 27 May 2021 15:32:22 -0400
Received: from mail-pl1-f171.google.com ([209.85.214.171]:40860 "EHLO
        mail-pl1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234786AbhE0TcN (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 27 May 2021 15:32:13 -0400
Received: by mail-pl1-f171.google.com with SMTP id n8so462482plf.7
        for <linux-block@vger.kernel.org>; Thu, 27 May 2021 12:30:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=iMmOvSXjB9HSWzUSCNR897l/x93rLjgpUWJ+uKcunak=;
        b=MPYa08+XU2FgkB2QUrfZOgnBCMKW+kPswBw9ZLEldt9z8aqAPSv151XLJMGNBuPOEO
         +PYOb/HKndz4YD0SNx0LEM6JmjLo1DtkhRXkZ0iqq7N9VxWQMKysjS6XD11oZyq8N9aJ
         N62I/TO5vNFw7tqqR0BP9L7UlV+5nUqBgMo6YYckTwqtgS6Sbom6skFopzFK9d8L9rw0
         bRGNE7yT2HTDivMOrotv/VeReGxkfJH0GWqq0CR4FK42HBoE2eUrnYfzw9xi/h8nJcWZ
         04uvdnSdoHlBB3xZFVkboCwEfcucdV7KmQ1CVLQnWXtdeJr0cui1piOMIgbjV8R6PeI9
         AaWA==
X-Gm-Message-State: AOAM531H1bbhlzGS8VoSIw8VUVKsPl7ORqY7gqEAUP7RuyYtoaLP69+7
        aauZls2Do/yu52/JYfdXx24=
X-Google-Smtp-Source: ABdhPJwKriC+Ryrw2yoyh8/m2lYajiU7TAJvFs3DbXnesR6j7TynQ8EBU3FbvJmtjVi05wgdHu495g==
X-Received: by 2002:a17:90b:3781:: with SMTP id mz1mr97114pjb.234.1622143839930;
        Thu, 27 May 2021 12:30:39 -0700 (PDT)
Received: from [192.168.3.217] (c-73-241-217-19.hsd1.ca.comcast.net. [73.241.217.19])
        by smtp.gmail.com with ESMTPSA id y66sm2388480pgb.14.2021.05.27.12.30.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 May 2021 12:30:38 -0700 (PDT)
Subject: Re: [PATCH 1/9] block/mq-deadline: Add several comments
To:     Hannes Reinecke <hare@suse.de>, Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Adam Manzanares <adam.manzanares@wdc.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Ming Lei <ming.lei@redhat.com>
References: <20210527010134.32448-1-bvanassche@acm.org>
 <20210527010134.32448-2-bvanassche@acm.org>
 <8f57c1cc-e41e-5438-ad02-5d4f0d92b079@suse.de>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <52835e79-ff65-234c-6850-ee97833a098f@acm.org>
Date:   Thu, 27 May 2021 12:30:37 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <8f57c1cc-e41e-5438-ad02-5d4f0d92b079@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 5/26/21 11:45 PM, Hannes Reinecke wrote:
> On 5/27/21 3:01 AM, Bart Van Assche wrote:
>>  /*
>> + * Callback function called from inside blk_mq_free_request().
>> + *
>>   * For zoned block devices, write unlock the target zone of
>>   * completed write requests. Do this while holding the zone lock
>>   * spinlock so that the zone is never unlocked while deadline_fifo_request()
>>
> Shouldn't these be kernel-doc comments?

Hi Hannes,

When using the kernel-doc format it is required to document the meaning
of all function arguments. It seems to me that it is easy to guess what
the meaning of the function arguments is in the deadline scheduler?

Bart.
