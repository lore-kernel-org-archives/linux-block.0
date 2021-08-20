Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51AE2C4320A
	for <linux-block@archiver.kernel.org>; Fri, 20 Aug 2021 23:38:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 398276108F
	for <linux-block@archiver.kernel.org>; Fri, 20 Aug 2021 23:38:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240643AbhHTXjG (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 20 Aug 2021 19:39:06 -0400
Received: from mail-pg1-f174.google.com ([209.85.215.174]:35538 "EHLO
        mail-pg1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240615AbhHTXjG (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 20 Aug 2021 19:39:06 -0400
Received: by mail-pg1-f174.google.com with SMTP id e7so10725735pgk.2
        for <linux-block@vger.kernel.org>; Fri, 20 Aug 2021 16:38:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=SvlGaqDpwFLnwxuvoFHtsCxyBABgmXqL3YRX5MpVrYw=;
        b=kDusCclGC3ID6faxaCw6h0HR1sUb6jV8ipIwaz5dGV+s6AAjVms/kgJ7EmVoG8eGY+
         G8462PElQ7V5ud8JNuhW4mcFJyCgAW1dR6go7mZ3W+GS5IF3OmaGdRiBzNXZFdonn1mg
         nNb7D10Ql01x5gRndv8Uk/eLhjX7wP36EaX6FWnwtcrzEMlA/v2UFSDZIdo5H8FnwhuB
         tmN4joacV+R/TKjEIjiOePIhbGwheRuv9VVCnbqWUpBbcMW7cFXIfOrmwcn/PTpl2snN
         hOehGSTMb7FwEEgVbNEtKoa/RwU5KPqkxaOhMUsiiF15KYMWTeZFPiv0XgCzDSc1lmE7
         NMqQ==
X-Gm-Message-State: AOAM5306/wnZ1dPf9UA3vHNw/cvwfoq+i3pOfWUnraFv6oVB3gU4gE5w
        LLEK+fhOcAhRGOrdcrKvCow=
X-Google-Smtp-Source: ABdhPJzaD3UW9DuwPEED1p851nxcdOqNYYaabcA8BytJMQ8eAaEnEYtu0JGEaeEaXo91WrH/AfIAHg==
X-Received: by 2002:a63:d104:: with SMTP id k4mr20601477pgg.196.1629502707542;
        Fri, 20 Aug 2021 16:38:27 -0700 (PDT)
Received: from bvanassche-linux.mtv.corp.google.com ([2620:15c:211:201:ddfe:8579:6783:9ed8])
        by smtp.gmail.com with ESMTPSA id pc11sm12451763pjb.17.2021.08.20.16.38.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Aug 2021 16:38:26 -0700 (PDT)
Subject: Re: [PATCH v3 16/16] block/mq-deadline: Prioritize high-priority
 requests
To:     Niklas Cassel <Niklas.Cassel@wdc.com>
Cc:     Jens Axboe <axboe@kernel.dk>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Adam Manzanares <a.manzanares@samsung.com>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Hannes Reinecke <hare@suse.de>, Ming Lei <ming.lei@redhat.com>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Himanshu Madhani <himanshu.madhani@oracle.com>
References: <20210618004456.7280-1-bvanassche@acm.org>
 <20210618004456.7280-17-bvanassche@acm.org> <YR77J/aE6sWZ6Els@x1-carbon>
 <5aa99b39-c342-abd4-00a4-dc0fbfac96aa@acm.org> <YSA1JWt9soMSs23Z@x1-carbon>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <e94f62c4-a329-398d-5003-d369506d7f89@acm.org>
Date:   Fri, 20 Aug 2021 16:38:24 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <YSA1JWt9soMSs23Z@x1-carbon>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 8/20/21 4:05 PM, Niklas Cassel wrote:
> Thank you for your patch!
> I tested it, and it does solve my problem.

That's quick. Thanks!

> I've been thinking more about this problem.
> The problem is seen on a SATA zoned drive.
> 
> These drives have mq-deadline set as default by the
> blk_queue_required_elevator_features(q, ELEVATOR_F_ZBD_SEQ_WRITE) call in
> drivers/scsi/sd_zbc.c:sd_zbc_read_zones()
> 
> This triggers block/elevator.c:elevator_init_mq() to initialize
> "mq-deadline" as default scheduler for these devices.
> 
> I think that the problem might because that drivers/scsi/sd_zbc.c
> has created the request_queue and submitted requests, before the call
> to elevator_init_mq() is done.
> 
> elevator_init_mq() will set q->elevator->type->ops, so once that is set,
> blk_mq_free_request() will call e->type->ops.finish_request(rq),
> regardless if the request was inserted through the recently initialized
> scheduler or not.
> 
> While I'm perfectly happy with your fix, would it perhaps be possible
> to do the fix in block/elevator.c instead, so that we don't need to
> do the same type of check that you did, in each and every single
> io scheduler?
> 
> Looking at block/elevator.c:elevator_init_mq(), it seems to do:
> 
> blk_mq_freeze_queue()
> blk_mq_quiesce_queue()
> 
> blk_mq_init_sched()
> 
> blk_mq_unquiesce_queue()
> blk_mq_unfreeze_queue()
> 
> This obviously isn't enough to avoid the bug that we are seeing,
> but could perhaps a more general fix be to flush/wait until all
> in-flight requests have completed, and then free them, and then
> set q->elevator->type->ops. That way, all requests inserted after
> the io scheduler has been initialized, will have gone through the
> io scheduler. So all finish_request() calls should have a
> matching insert_request() call. What do you think?

q->elevator is set from inside the I/O scheduler's init_sched callback 
and that callback is called with the request queue frozen. Freezing 
happens by calling blk_mq_freeze_queue() and that function waits until 
all previously submitted requests have finished. So I don't think that 
the race described above can happen.

Thanks,

Bart.
