Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0146C4338F
	for <linux-block@archiver.kernel.org>; Wed,  4 Aug 2021 17:58:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CF51B61002
	for <linux-block@archiver.kernel.org>; Wed,  4 Aug 2021 17:58:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239985AbhHDR6S (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 4 Aug 2021 13:58:18 -0400
Received: from mail-pj1-f43.google.com ([209.85.216.43]:41898 "EHLO
        mail-pj1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238270AbhHDR6S (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 4 Aug 2021 13:58:18 -0400
Received: by mail-pj1-f43.google.com with SMTP id q17-20020a17090a2e11b02901757deaf2c8so4740630pjd.0
        for <linux-block@vger.kernel.org>; Wed, 04 Aug 2021 10:58:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=GIkQ3O0w6bhSupMgp4+vB9AZMw395lGEwUgPfZeNzx4=;
        b=P9+OL+Y19/s7vWTPK7lfwLQ57NlKsOzZ6d3JfC2nuYWQP/rJcPzEvzvHDcLDjdZKdx
         fvGiYsIN5JU6XmBfbVXSyUPBNZCdc1XtVJlzlDOdDBRkKnHR7IICY6eap6gVxrd74c6h
         SaIYkDYFtCUmsWMRlNT/9HaVPA288dlRF8QWEtVRBLov3RmgXx6HuizVOe0U5fgtKWat
         9m9AnWbEUjqqhZNrD5DM/ftb+pxBeQ04uTaB3oGHN9sdjpPN8P/yyaGK/b9sIyQY2Kto
         40iGXEWLIQyZRKLXHKJzBPkAuKp7mbRirVtlW+IWE7r1Ci1OiHBDXemjtG4ObjnwFVqd
         PfXQ==
X-Gm-Message-State: AOAM531wVfj9Ms9gRoMHQ4NZGfsYpy2OAQqWBR1tYfxRAMdeIAhlGy2v
        oVp2Nr4q4txDUh/T1b3FR2E=
X-Google-Smtp-Source: ABdhPJwZqzfJh4vbKeG+osIvAKTWEMCCrEIt4cf/OZQu1nZxbkRxOMv/CoInXdjNVnvBlrIT3gsNjA==
X-Received: by 2002:a65:6554:: with SMTP id a20mr295335pgw.107.1628099884512;
        Wed, 04 Aug 2021 10:58:04 -0700 (PDT)
Received: from bvanassche-linux.mtv.corp.google.com ([2620:15c:211:1:8587:b3fe:5419:1ed7])
        by smtp.gmail.com with ESMTPSA id 10sm3611221pjc.41.2021.08.04.10.58.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Aug 2021 10:58:03 -0700 (PDT)
Subject: Re: [PATCH v2 2/3] loop: Select I/O scheduler 'none' from inside
 add_disk()
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Ming Lei <ming.lei@redhat.com>,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        Martijn Coenen <maco@android.com>
References: <20210803182304.365053-1-bvanassche@acm.org>
 <20210803182304.365053-3-bvanassche@acm.org> <20210804053527.GA5711@lst.de>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <c6337526-8f25-7efc-96ff-fbfe054fe9c0@acm.org>
Date:   Wed, 4 Aug 2021 10:58:01 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20210804053527.GA5711@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 8/3/21 10:35 PM, Christoph Hellwig wrote:
> On Tue, Aug 03, 2021 at 11:23:03AM -0700, Bart Van Assche wrote:
>> We noticed that the user interface of Android devices becomes very slow
>> under memory pressure. This is because Android uses the zram driver on top
>> of the loop driver for swapping,
> 
> Sorry, but that is just amazingly stupid.  If you really want to swap
> to compressed files introduce that support in the swap code instead of
> coming up with dumb driver stacks from hell.

Hi Christoph,

That's an interesting suggestion. We can look into adding compression 
support in the swap code.

Independent of the use case of this patch, is it acceptable to change 
the default I/O scheduler of loop devices from mq-deadline into none 
(patches 1 and 2 of this series)?

Thanks,

Bart.


