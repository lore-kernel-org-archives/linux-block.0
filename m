Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03C93C433B4
	for <linux-block@archiver.kernel.org>; Fri, 30 Apr 2021 03:06:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C26D660BBB
	for <linux-block@archiver.kernel.org>; Fri, 30 Apr 2021 03:06:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229623AbhD3DHX (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 29 Apr 2021 23:07:23 -0400
Received: from mail-pj1-f50.google.com ([209.85.216.50]:56075 "EHLO
        mail-pj1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229582AbhD3DHW (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 29 Apr 2021 23:07:22 -0400
Received: by mail-pj1-f50.google.com with SMTP id gj14so3810682pjb.5
        for <linux-block@vger.kernel.org>; Thu, 29 Apr 2021 20:06:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=0+wHWC69rRQHzbgHFI5udRr5CGVC1SZR2fAungx8EHk=;
        b=EHVeY1hhJZoSE/J8nARYLHdtxw7je2Jlq1sRpZL9IBZ10a16inycGQRMi7R13b+b1W
         RCXh8Rc23Ws6u/z272Us18qEdBbup+f/FqOZjhfbUyNNXtRw/CLWFF7s90aV3qefqxoh
         sMF/bckyY9HGZ3sFlNA86o7L3jDSBPv6gvJRpJqSqyxcS0hxvP0xZ6+OZO2u3Yv88giM
         k+fetLe8NVeQqqiYlJhOo6Y8XSDtgSyyGyvodiTmPJpccwE5ut+voew1B81pBpAcRcD0
         TzKp2vvs5IXqbiC9aNQEO2yGyYcaQ0aN/pDHlFksu5gfV6efSaJAZv+FI81fMVaN3Umm
         mrAg==
X-Gm-Message-State: AOAM530cK9it8GuT88m/qWNQ4iGzLIw7yBieJLeYTXX8gXy2DZ928RAn
        R2C4kOR3ayBRPxqfiL3MAAY=
X-Google-Smtp-Source: ABdhPJwvAESrJtibrJmJ+C29y3rv93X3QGaKVlvhCG8Dco9p8ScsCivWAMPKQTA5V3fN4Ci1ZhhSNw==
X-Received: by 2002:a17:90b:148c:: with SMTP id js12mr12945131pjb.147.1619751993239;
        Thu, 29 Apr 2021 20:06:33 -0700 (PDT)
Received: from [192.168.3.219] (c-73-241-217-19.hsd1.ca.comcast.net. [73.241.217.19])
        by smtp.gmail.com with ESMTPSA id j189sm438595pfd.21.2021.04.29.20.06.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Apr 2021 20:06:32 -0700 (PDT)
Subject: Re: [PATCH V4 2/4] blk-mq: grab rq->refcount before calling ->fn in
 blk_mq_tagset_busy_iter
To:     Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Khazhy Kumykov <khazhy@google.com>,
        Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
        Hannes Reinecke <hare@suse.de>,
        John Garry <john.garry@huawei.com>,
        David Jeffery <djeffery@redhat.com>
References: <20210429023458.3044317-1-ming.lei@redhat.com>
 <20210429023458.3044317-3-ming.lei@redhat.com>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <d8ca7a5f-1518-b16b-c65a-d3306991fba4@acm.org>
Date:   Thu, 29 Apr 2021 20:06:31 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <20210429023458.3044317-3-ming.lei@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 4/28/21 7:34 PM, Ming Lei wrote:
> Grab rq->refcount before calling ->fn in blk_mq_tagset_busy_iter(), and
> this way will prevent the request from being re-used when ->fn is
> running. The approach is same as what we do during handling timeout.
> 
> Fix request UAF related with completion race or queue releasing:
> 
> - If one rq is referred before rq->q is frozen, then queue won't be
> frozen before the request is released during iteration.
> 
> - If one rq is referred after rq->q is frozen, refcount_inc_not_zero()
> will return false, and we won't iterate over this request.
> 
> However, still one request UAF not covered: refcount_inc_not_zero() may
> read one freed request, and it will be handled in next patch.

Reviewed-by: Bart Van Assche <bvanassche@acm.org>
