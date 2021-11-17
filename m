Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32CF0C433F5
	for <linux-block@archiver.kernel.org>; Wed, 17 Nov 2021 04:04:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F14C46124B
	for <linux-block@archiver.kernel.org>; Wed, 17 Nov 2021 04:04:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232674AbhKQEHO (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 16 Nov 2021 23:07:14 -0500
Received: from mail-pf1-f170.google.com ([209.85.210.170]:37419 "EHLO
        mail-pf1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232063AbhKQEHO (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 16 Nov 2021 23:07:14 -0500
Received: by mail-pf1-f170.google.com with SMTP id 8so1393977pfo.4
        for <linux-block@vger.kernel.org>; Tue, 16 Nov 2021 20:04:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=IIAM0KtsZQYknRLR7zCuv/YN3zAHwaSCx4U7yQcOrb0=;
        b=bT8RuLi1yfgRBVdiSCVjI1gShgV3iiG+nej9NSUA7IVMP8WBxVRHeuLhargYu6fER9
         LSBZ/jyprLVaZ6dFJ7iqyrrc9oWirgUgy4/1GDUAGcLAdvToUCSvP8BfV2GRgwi7MCus
         S2ZX8Z8okulQ0YSyXqXpDRu4BCAdmXonHamHL/tY9VCbDeWiuhSfWXy6WAUYzGtt2Ik0
         sXgzFSbKQ8ye2L4XmQGtN8zD0UPWz16GNhhEvVh1vgmiGINujEdpFj0FUU6jQBPEuqZQ
         rRDA9oSGVZyOnPbJuMkXCEuxeA6whTGd7YjomYVHC0eP+rfwEJhmaoz2gFdoodC49K/J
         iqng==
X-Gm-Message-State: AOAM532S6AQfmp11pFHy4fKu/8lm44gFIVtZYy258wsjKnxIuOrbPOC9
        FTGLg4y1cyA4wPwcIsgT+5zIGfjRoWI=
X-Google-Smtp-Source: ABdhPJzRuezG0O1J0znzvWec4yj5G/odXq71u9cyRjRcrqRw5lzF+9dllmRyYD9PeXPpH6RGFNBNEQ==
X-Received: by 2002:a05:6a00:1ad0:b0:49f:d04e:78da with SMTP id f16-20020a056a001ad000b0049fd04e78damr46913853pfv.77.1637121856373;
        Tue, 16 Nov 2021 20:04:16 -0800 (PST)
Received: from ?IPV6:2601:647:4000:d7:feaa:14ff:fe9d:6dbd? ([2601:647:4000:d7:feaa:14ff:fe9d:6dbd])
        by smtp.gmail.com with ESMTPSA id y6sm21271366pfi.154.2021.11.16.20.04.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Nov 2021 20:04:15 -0800 (PST)
Message-ID: <7b7f78d1-b37a-4588-c127-27210b7dad74@acm.org>
Date:   Tue, 16 Nov 2021 20:04:14 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: Hang in blk_mq_freeze_queue_wait()
Content-Language: en-US
To:     Jens Axboe <axboe@kernel.dk>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Ming Lei <ming.lei@redhat.com>
References: <2f79a604-592e-a4b9-48df-020a5923311f@acm.org>
 <fb109032-3926-98ce-41c0-0670c0037bd9@kernel.dk>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <fb109032-3926-98ce-41c0-0670c0037bd9@kernel.dk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 11/16/21 16:21, Jens Axboe wrote:
> Can you try with:
> 
> https://git.kernel.dk/cgit/linux-block/commit/?h=block-5.16&id=95febeb61bf87ca803a1270498cd4cd61554a68f

With that patch applied all SRP tests pass. Feel free to add:

Tested-by: Bart Van Assche <bvanassche@acm.org>

Thanks!

Bart.


