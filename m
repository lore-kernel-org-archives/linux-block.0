Return-Path: <SRS0=bHvQ=DU=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC218C43467
	for <linux-block@archiver.kernel.org>; Tue, 13 Oct 2020 22:31:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BEC34218AC
	for <linux-block@archiver.kernel.org>; Tue, 13 Oct 2020 22:31:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728753AbgJMWbX (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 13 Oct 2020 18:31:23 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:37409 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725935AbgJMWbW (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 13 Oct 2020 18:31:22 -0400
Received: by mail-pf1-f195.google.com with SMTP id 144so729453pfb.4
        for <linux-block@vger.kernel.org>; Tue, 13 Oct 2020 15:31:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=fGbQscbBmKdccLfNzPmjtUYi2nV7gv4Od0IK12wktQE=;
        b=DV9ZJMplZItfclvDWE+Yb3YXsDC7ELD1MoUSjSm8ndujkZ8EG9l8xGJcIsS1iodgzr
         HwjBeHVYmTivFXskUHEgo7s8SRcZHYR+5weRFK503K56XeW5+VzPRWb4SnyP0G+Q0Jpw
         elwOPAD5l7MQG7Jb94mmJgZILBHv76UjrF/Zk9IqXz6gy6G5O3SBYsnK2pHNsw9aVDiD
         i+q1zi5wYpe8gZwaB0P7ujAoAevCzehq7Aw8IcsdnnqI0ERz+o9kMoy4oGIdDlsOgBGk
         iV0ZjzuEjUGo/BwUUi/+3xOh4g0Kj9owjb4bZHTE7wN3bCimD42HSNUb7PaAAPUI37mc
         VAYA==
X-Gm-Message-State: AOAM5331Rx7z4o6Lf+1rALYrHbZK9JTVCwT8q+5GMl/FFJH9+ODWZqpL
        vcgWgxFtnZQgcR3P0JKMRpA=
X-Google-Smtp-Source: ABdhPJyrkZo5IcWnVEFCz3JbAHrF5ntnLrmiW011ZGrt512iLGJlt8oyC4onKiaJNwKx6T+C1oBSDQ==
X-Received: by 2002:a63:40c1:: with SMTP id n184mr1371918pga.215.1602628281679;
        Tue, 13 Oct 2020 15:31:21 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:5a09:2d7:19f0:1ee0? ([2601:647:4802:9070:5a09:2d7:19f0:1ee0])
        by smtp.gmail.com with ESMTPSA id c10sm685027pfc.196.2020.10.13.15.31.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Oct 2020 15:31:20 -0700 (PDT)
Subject: Re: [PATCH] block: re-introduce blk_mq_complete_request_sync
To:     Ming Lei <ming.lei@redhat.com>, Chao Leng <lengchao@huawei.com>
Cc:     Yi Zhang <yi.zhang@redhat.com>, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org, Keith Busch <kbusch@kernel.org>,
        linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>
References: <20201008213750.899462-1-sagi@grimberg.me>
 <20201009043938.GC27356@T590>
 <1711488120.3435389.1602219830518.JavaMail.zimbra@redhat.com>
 <e39b711e-ebbd-8955-ca19-07c1dad26fa2@grimberg.me>
 <23f19725-f46b-7de7-915d-b97fd6d69cdc@redhat.com>
 <ced685bf-ad48-ac41-8089-8c5ba09abfcb@grimberg.me>
 <7a7aca6e-30f5-0754-fb7f-599699b97108@redhat.com>
 <6f2a5ae2-2e6a-0386-691c-baefeecb5478@huawei.com>
 <20201012081306.GB556731@T590>
From:   Sagi Grimberg <sagi@grimberg.me>
Message-ID: <0b5bfc44-d925-960d-b2a2-d0ba88b51111@grimberg.me>
Date:   Tue, 13 Oct 2020 15:31:18 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201012081306.GB556731@T590>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


>>>>>> -- 
>>>>>> diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
>>>>>> index 629b025685d1..46428ff0b0fc 100644
>>>>>> --- a/drivers/nvme/host/tcp.c
>>>>>> +++ b/drivers/nvme/host/tcp.c
>>>>>> @@ -2175,7 +2175,7 @@ static void nvme_tcp_complete_timed_out(struct request *rq)
>>>>>>          /* fence other contexts that may complete the command */
>>>>>>          mutex_lock(&to_tcp_ctrl(ctrl)->teardown_lock);
>>>>>>          nvme_tcp_stop_queue(ctrl, nvme_tcp_queue_id(req->queue));
>>>>>> -       if (!blk_mq_request_completed(rq)) {
>>>>>> +       if (blk_mq_request_started(rq) && !blk_mq_request_completed(rq)) {
>>>>>>                  nvme_req(rq)->status = NVME_SC_HOST_ABORTED_CMD;
>>>>>>                  blk_mq_complete_request_sync(rq);
>>>>>>          }
>> This may just reduce the probability. The concurrency of timeout and teardown will cause the same request
>> be treated repeatly, this is not we expected.
> 
> That is right, not like SCSI, NVME doesn't apply atomic request completion, so
> request may be completed/freed from both timeout & nvme_cancel_request().
> 
> .teardown_lock still may cover the race with Sagi's patch because teardown
> actually cancels requests in sync style.
> 
>> In the teardown process, after quiesced queues delete the timer and cancel the timeout work maybe a better option.
> 
> Seems better solution, given it is aligned with NVME PCI's reset
> handling. nvme_sync_queues() may be called in nvme_tcp_teardown_io_queues() to
> avoid this race.

We can't call nvme_sync_queues, that flushes the timeout work that is
serializing with the teardown, it will deadlock.
