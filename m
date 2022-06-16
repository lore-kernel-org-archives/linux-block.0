Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C509EC433EF
	for <linux-block@archiver.kernel.org>; Thu, 16 Jun 2022 21:15:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378911AbiFPVPE (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 16 Jun 2022 17:15:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378332AbiFPVPD (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 16 Jun 2022 17:15:03 -0400
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93B3660A81
        for <linux-block@vger.kernel.org>; Thu, 16 Jun 2022 14:15:02 -0700 (PDT)
Received: by mail-pf1-f181.google.com with SMTP id z17so2523348pff.7
        for <linux-block@vger.kernel.org>; Thu, 16 Jun 2022 14:15:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=mJH/EPHkAo5mqpe2uWQAkxVjZj/yftplUSr02gzjQoU=;
        b=26kxsyuV0t1JUAZNhyaUxF/BZmOZR0uSmDvwy99apzKTEEThU5Sf+eXueb4Mi0U5Le
         Ya5Pt2bhsZwQ48ZHVFZoRQQ/aE1CkkeIner8EwkKGszGOyBYCx6wS8Y6dYk27B8eS5CR
         pe8C/qR+1hJqzh6cXSWbeCh7d9ggt6JqJW4LiiP5tINyFhBOITEY/bpk4USdEg9hvDrM
         k1noTMJK9GI9QFo8tZJXqwz8jxyDZjjkkRxHNZg9VhgN0NZKH2yK1i3UPdfGOhzkMhuF
         AM0occSaJQHW+IGBPBBdDt/JHHNswFaGi8bFlGGKa8phJW7ONVVa4nTmaiNRSyPAVgUV
         6ELg==
X-Gm-Message-State: AJIora8XbGSRE7Qg3U0MiOstRH4rOv5bH+2HP/Z3y+Rh7YknlZWXtgip
        7b8veFreuWfFjWlUAIR0Ouc=
X-Google-Smtp-Source: AGRyM1u8BIloPRt5UpQGC7aDaCEv4O8xWpoHYVlwMQP/q3HgJjAkaL63tRKapeyz5gipQXEOXBHlKw==
X-Received: by 2002:a05:6a00:cd2:b0:51c:28b5:1573 with SMTP id b18-20020a056a000cd200b0051c28b51573mr6606860pfv.59.1655414101765;
        Thu, 16 Jun 2022 14:15:01 -0700 (PDT)
Received: from ?IPV6:2620:15c:211:201:55f1:e134:5606:bb89? ([2620:15c:211:201:55f1:e134:5606:bb89])
        by smtp.gmail.com with ESMTPSA id v13-20020a63b64d000000b003fc4cc19414sm2281000pgt.45.2022.06.16.14.15.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Jun 2022 14:15:00 -0700 (PDT)
Message-ID: <6efac11f-bb1d-7458-cb6d-bcd6e99e439f@acm.org>
Date:   Thu, 16 Jun 2022 14:14:59 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH] block/bfq: Enable I/O statistics
Content-Language: en-US
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Cixi Geng <cixi.geng1@unisoc.com>, Jan Kara <jack@suse.cz>,
        Yu Kuai <yukuai3@huawei.com>,
        Paolo Valente <paolo.valente@unimore.it>
References: <20220613163234.3593026-1-bvanassche@acm.org>
 <6704edef-8c60-9fb8-ea45-1a350fdd9bf6@kernel.dk>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <6704edef-8c60-9fb8-ea45-1a350fdd9bf6@kernel.dk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 6/16/22 13:50, Jens Axboe wrote:
> On 6/13/22 10:32 AM, Bart Van Assche wrote:
>> BFQ uses io_start_time_ns. That member variable is only set if I/O
>> statistics are enabled. Hence this patch that enables I/O statistics
>> at the time BFQ is associated with a request queue.
>>
>> Compile-tested only.
> 
> Have you runtime tested it now?

This patch has been tested lightly: I ran blktests in a VM against a 
kernel that includes this patch. I'm not a BFQ expert so I was hoping 
for feedback from Paolo.

Thanks,

Bart.

