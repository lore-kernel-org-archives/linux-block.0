Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B805C433EF
	for <linux-block@archiver.kernel.org>; Fri,  1 Jul 2022 13:48:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231205AbiGANs1 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 1 Jul 2022 09:48:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231553AbiGANs0 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 1 Jul 2022 09:48:26 -0400
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F29F615A39
        for <linux-block@vger.kernel.org>; Fri,  1 Jul 2022 06:48:24 -0700 (PDT)
Received: by mail-pg1-f173.google.com with SMTP id v126so2437199pgv.11
        for <linux-block@vger.kernel.org>; Fri, 01 Jul 2022 06:48:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=A9Gp3Fi/hFnMixvX+V0W9u9TkqYx87wIxshV3THCRes=;
        b=49F+4K8VBSnxX8hPhXMuf2uz8rFnlKj6dzXp0NA72dVKZRE/3P6vFaSficqDgfodpx
         +qRSS0jatr7RHt46EEc9fx5F9kXfxL8P68bHi6kC9zt8wUfopNzxichsYFod3A0P+44m
         2b4ZlXWHrb0GTwK/hubHiZGa4XNR8Xzt4kt9/3njkq7uyb7FZinwJgKGzOb/lnE4C6FB
         8aDZ0dSnAGBOpgEiQExXtK0RgYrRCUYrQY/itSTjRyNmmM5RmXy7RQofC0x11Q+LU443
         xfl4EN4IOtH9bP3gOWEaSirkwmg7cxOq2dSTpbP01OyoWbwLDxh3y53ALE5h39Sza6Iq
         jC1Q==
X-Gm-Message-State: AJIora9pAwIKciFzOR8blo4kwTo5YfNBpyQb+pXK3qR7clqMQVkk9RgD
        V6D5+UihJmKOdI4y5FK0VKY6FdYtKXo=
X-Google-Smtp-Source: AGRyM1tmGdDAhNuZmR8gu4pyT5oWcbJESgw6kF7kT2XHZtatqZw4fY2leESGvodLr5+jTONUXWYTlQ==
X-Received: by 2002:a63:106:0:b0:40d:2db:1c92 with SMTP id 6-20020a630106000000b0040d02db1c92mr12640328pgb.571.1656683304373;
        Fri, 01 Jul 2022 06:48:24 -0700 (PDT)
Received: from ?IPV6:2601:647:4000:d7:feaa:14ff:fe9d:6dbd? ([2601:647:4000:d7:feaa:14ff:fe9d:6dbd])
        by smtp.gmail.com with ESMTPSA id g13-20020a17090a290d00b001ece6f492easm3947290pjd.44.2022.07.01.06.48.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 Jul 2022 06:48:23 -0700 (PDT)
Message-ID: <92913c7d-853a-c326-a43c-635d517f218e@acm.org>
Date:   Fri, 1 Jul 2022 06:48:22 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v2 60/63] fs/ocfs2: Use the enum req_op and blk_opf_t
 types
Content-Language: en-US
To:     Joseph Qi <joseph.qi@linux.alibaba.com>,
        Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Mark Fasheh <mark@fasheh.com>, Joel Becker <jlbec@evilplan.org>
References: <20220629233145.2779494-1-bvanassche@acm.org>
 <20220629233145.2779494-61-bvanassche@acm.org>
 <087a250f-01fd-a38e-78a8-4449175b6d4a@linux.alibaba.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <087a250f-01fd-a38e-78a8-4449175b6d4a@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 6/30/22 18:47, Joseph Qi wrote:
> On 6/30/22 7:31 AM, Bart Van Assche wrote:
>> -	bio = o2hb_setup_one_bio(reg, write_wc, &slot, slot+1, REQ_OP_WRITE,
>> +	bio = o2hb_setup_one_bio(reg, write_wc, &slot, slot+1, REQ_OP_WRITE |
>>   				 REQ_SYNC);
> 
> Better to let 'REQ_OP_WRITE | REQ_SYNC' at the same line.
> Other looks fine.
> Reviewed-by: Joseph Qi <joseph.qi@linux.alibaba.com>

Hi Joseph,

I will make sure that REQ_OP_WRITE | REQ_SYNC appears on the same line. 
Thanks for the review.

Bart.
