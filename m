Return-Path: <SRS0=QBb8=4U=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04794C3F2C6
	for <linux-block@archiver.kernel.org>; Tue,  3 Mar 2020 21:18:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C9E7820870
	for <linux-block@archiver.kernel.org>; Tue,  3 Mar 2020 21:18:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20150623.gappssmtp.com header.i=@toxicpanda-com.20150623.gappssmtp.com header.b="NUsAHWWH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732175AbgCCVSQ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 3 Mar 2020 16:18:16 -0500
Received: from mail-qv1-f66.google.com ([209.85.219.66]:35405 "EHLO
        mail-qv1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732075AbgCCVSQ (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 3 Mar 2020 16:18:16 -0500
Received: by mail-qv1-f66.google.com with SMTP id u10so30933qvi.2
        for <linux-block@vger.kernel.org>; Tue, 03 Mar 2020 13:18:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=suhh+kDG7gHdHRASogA0YlonJrkSmt2vdfbF/XvnQ50=;
        b=NUsAHWWHr0HStCn+DxrBX766Zu1J/a33P35eJKRiD23wR2U/F04MO1E/6BXwCh9RuK
         RrfmDCe/PZyUoKm9/im/HNiixkRZwaDuLjatSbfUUNhgYsujM7wrgyXqQYmUP1tHim5W
         FQ3/MWS9+ZzxyeH+E3UCgFI2qesNzVWyb93VgUchqj9OAMY12Th/Yecvyg+ggCDI3Wdt
         5c8zaxAjj0SWDDXL/iSE3Od3PXjVetMtwAEjehOPfs6GRG+Q8f84He9m9NTsHaJYbw5g
         L4GbITjb+7LX7GQytuyl7R2O3diTL72x7eDvIpba/O3hJzE/794CjQvRma1NbLICHzTa
         iBKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=suhh+kDG7gHdHRASogA0YlonJrkSmt2vdfbF/XvnQ50=;
        b=sJVh22KmoPjzlzMsbIehgx2CLScSd94+qgXANDCbArIECAuFb7JZ4gVxdb8QIzUeva
         arkrooFIbXgdzTaaSNKguaXcIMcER19PpAck1m2YauHU/vrxzMqt6mGykBVM+u+cOPy4
         eqQcsAH6xJfYdvtFRTGTqOhBF9tnUawO7NKorD76Si9DXo48Qearv1CHGRxLOqZEWBWA
         Yi4H4FXTTYczQNF5WxfNl0f7SsPffy+c49hHhqKV4K+qiRlB1agUQPzjxMIgk78KeYJ8
         FviMookt9RVN5LgbCSYW2lw63ASXCteqQzxfv2+MTWKBjLFhpChHSC9hh9FpsOpY7nqD
         fLDQ==
X-Gm-Message-State: ANhLgQ3EL0LrtjGRdUgZSzZiGOLjqPp33LnaCcQw4628CBwFgr81cB27
        giF20NkaO5HMPuxEWcbWo1JJZamY9fM=
X-Google-Smtp-Source: ADFU+vuV8ouvAWeJOxM3whNkg4pziPVgu9wbWJLJ93huStem10PzL4JYZrvVgbG7upUycURMfCWe5w==
X-Received: by 2002:a05:6214:1050:: with SMTP id l16mr5857619qvr.25.1583270293722;
        Tue, 03 Mar 2020 13:18:13 -0800 (PST)
Received: from [192.168.1.106] ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id j7sm9054018qti.14.2020.03.03.13.18.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Mar 2020 13:18:12 -0800 (PST)
Subject: Re: [PATCH] nbd: make starting request more reasonable
To:     Yufen Yu <yuyufen@huawei.com>, axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, nbd@other.debian.org
References: <20200303130843.12065-1-yuyufen@huawei.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <2976065c-ae72-08d4-32ca-89b0f24ded74@toxicpanda.com>
Date:   Tue, 3 Mar 2020 16:18:12 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200303130843.12065-1-yuyufen@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 3/3/20 8:08 AM, Yufen Yu wrote:
> Our test robot reported a warning for refcount_dec trying to decrease
> value '0'. The reason is that blk_mq_dispatch_rq_list() try to complete
> the failed request from nbd driver, while the request have finished in
> nbd timeout handle function. The race as following:
> 
> CPU1                             CPU2
> 
> //req->ref = 1
> blk_mq_dispatch_rq_list
> nbd_queue_rq
>    nbd_handle_cmd
>      blk_mq_start_request
>                                   blk_mq_check_expired
>                                     //req->ref = 2
>                                     blk_mq_rq_timed_out
>                                       nbd_xmit_timeout
>                                         blk_mq_complete_request
>                                           //req->ref = 1
>                                           refcount_dec_and_test(&req->ref)
> 
>                                     refcount_dec_and_test(&req->ref)
>                                     //req->ref = 0
>                                       __blk_mq_free_request(req)
>    ret = BLK_STS_IOERR
> blk_mq_end_request
> // req->ref = 0, req have been free
> refcount_dec_and_test(&rq->ref)
> 
> In fact, the bug also have been reported by syzbot:
>    https://lkml.org/lkml/2018/12/5/1308
> 
> Since the request have been freed by timeout handle, it can be reused
> by others. Then, blk_mq_end_request() may get the re-initialized request
> and free it, which is unexpected.
> 
> To fix the problem, we move blk_mq_start_request() down until the driver
> will handle the request actully. If .queue_rq return something error in
> preparation phase, timeout handle may don't need. Thus, moving start
> request down may be more reasonable. Then, nbd_queue_rq() will not return
> BLK_STS_IOERR after starting request.
> 

This won't work, you have to have the request started if you return an error 
because of this in blk_mq_dispatch_rq_list

                 if (unlikely(ret != BLK_STS_OK)) {
                         errors++;
                         blk_mq_end_request(rq, BLK_STS_IOERR);
                         continue;
                 }

The request has to be started before we return an error, pushing it down means 
we have all of these error cases where we haven't started the request.  Thanks,

Josef
