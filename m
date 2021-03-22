Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98632C433DB
	for <linux-block@archiver.kernel.org>; Mon, 22 Mar 2021 23:39:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 633B6619A9
	for <linux-block@archiver.kernel.org>; Mon, 22 Mar 2021 23:39:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230156AbhCVXil (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 22 Mar 2021 19:38:41 -0400
Received: from mail-pf1-f175.google.com ([209.85.210.175]:35794 "EHLO
        mail-pf1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229622AbhCVXhf (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 22 Mar 2021 19:37:35 -0400
Received: by mail-pf1-f175.google.com with SMTP id j25so12330866pfe.2
        for <linux-block@vger.kernel.org>; Mon, 22 Mar 2021 16:37:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=9UpKNCzMfoBe6iCgWVO/ONH7BNy6Y0bhcBh0jlN88D4=;
        b=rZn6XASWmwDlkfuQ5m6W9NY9gQVBDsWkS1sDXi1GNU9N4Fmkk2K2XYX6WwrndQlgJj
         btURlOr+huizRTxf+8BWgjvOryi96FV6DhyI971tsW8/gnbNvEfGAiaYGi45WlEgYisF
         9Z1GDnjHQwXtO/SmfOEXQJQO8OGaNPpOqr3q39W5by5XZaFR9IDXeHJqyXnUc9ZHAbPD
         b0tmizrfX5rlZNzSsDZu26HP0e7RbakEr/F/U6C1lE5p0Cy51jDjwRflYpJgO/37rP97
         8oH9NABOvvKY2oeCUwNBw4cefOgeaDsJ2bBsR5lgyI0Qc1srbo09O8x114zCt0BQ0ZoV
         g8pA==
X-Gm-Message-State: AOAM532PuF9dd7mqBcn6DV4Htrs2HsuHQEuc5ZlKqrSKncPNfanW+Ofk
        w9lcDEHAuzevu21FshOBl/w=
X-Google-Smtp-Source: ABdhPJzH/FaJgSLvZA9YovnPRtA+iOUaBVbkPM4VkyX7MWKAZqovoogW/R4Z6OTcBfwdIsRiE9VEnw==
X-Received: by 2002:a62:8302:0:b029:21a:6de0:b6a7 with SMTP id h2-20020a6283020000b029021a6de0b6a7mr2081865pfe.35.1616456254864;
        Mon, 22 Mar 2021 16:37:34 -0700 (PDT)
Received: from [192.168.51.110] (c-73-241-217-19.hsd1.ca.comcast.net. [73.241.217.19])
        by smtp.gmail.com with ESMTPSA id e11sm15027721pfm.24.2021.03.22.16.37.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Mar 2021 16:37:34 -0700 (PDT)
Subject: Re: [PATCH] blk-mq: Fix races between iterating over requests and
 freeing requests
To:     Khazhy Kumykov <khazhy@google.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>, Ming Lei <ming.lei@redhat.com>,
        John Garry <john.garry@huawei.com>,
        Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
References: <20210319010009.10041-1-bvanassche@acm.org>
 <CACGdZYJCUQY0yqtUUVcKugX7DpUqG2LJUQQO5Yp4F1CG6KWvYQ@mail.gmail.com>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <0503987e-35e0-0f52-5df4-2f3923859500@acm.org>
Date:   Mon, 22 Mar 2021 16:37:32 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <CACGdZYJCUQY0yqtUUVcKugX7DpUqG2LJUQQO5Yp4F1CG6KWvYQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 3/22/21 3:39 PM, Khazhy Kumykov wrote:
> On Thu, Mar 18, 2021 at 6:00 PM Bart Van Assche <bvanassche@acm.org> wrote:
>>
>> Multiple users have reported use-after-free complaints similar to the
>> following (see also https://lore.kernel.org/linux-block/1545261885.185366.488.camel@acm.org/):
> 
> This fixes the crashes I was seeing. I also looked over the patch and
> the dereferencing rules seem correct, although that q_usage_counter
> check in the bad case seems racy itself? Thanks!
> Reviewed-By: Khazhismel Kumykov <khazhy@google.com>

Thanks Khazy for the review and for the testing. The purpose of the 
q_usage_counter check in blk_mq_tag_to_rq() is to catch calls of 
blk_mq_tag_to_rq() from outside .queue_rq() that happen during or after 
queue deletion. Maybe I should change that check into a test of 
QUEUE_FLAG_DYING.

Bart.


