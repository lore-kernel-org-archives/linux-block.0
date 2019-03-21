Return-Path: <SRS0=o3qj=RY=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B64ABC43381
	for <linux-block@archiver.kernel.org>; Thu, 21 Mar 2019 02:04:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C4F620643
	for <linux-block@archiver.kernel.org>; Thu, 21 Mar 2019 02:04:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726914AbfCUCEY (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 20 Mar 2019 22:04:24 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:33277 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726487AbfCUCEY (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 20 Mar 2019 22:04:24 -0400
Received: by mail-wr1-f66.google.com with SMTP id q1so4913275wrp.0
        for <linux-block@vger.kernel.org>; Wed, 20 Mar 2019 19:04:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ZFoX/8euyNYr8L5pbEXKjutx6LeF5Gz5uKooisVs+3k=;
        b=eiaIVU9ywxJcfS0+NGv9OEyzQqQFECBIRjoC7cZCwzIPWLqnnYKwi1jsg4B4+ojd2/
         fXDiOPmb7kGK4VaMdQafO6EspmL387C5XPB8VYCrb2fX8g+PXYffa+5Iz5wpBB+eHkxH
         pWsec4t6RXVDYXtPZWiXiR0tOwYyj5OezSb8WO7o/MCzo9PKsM9JeIbFP6Le4tSLRetg
         nyz5Fq3KnG+nTXlta7QcZnYG4YMRQjV8GUUdM6Lf7iYDP7/x2D06sA+JyMnk4WpHsetC
         99oapsYF4G7h+h9w+p0aLFWDbZBelFcfTZQVDhDS3TiDts8305cocYn1rtCwC8Ty53JG
         FQLg==
X-Gm-Message-State: APjAAAVAgyWoR9XmsSX8WUEDRDlPCEuvZ6KmcAicN1c44guMNbJPsVC8
        IuXMKnN/4SA3M7E1MHokDAc=
X-Google-Smtp-Source: APXvYqzbXFzrwBNubGTF14t2JnYY1mcLjhwDY2lN3sSlDv3vW/P3P1iZzDWsiVe08AJEnL17q0YQkw==
X-Received: by 2002:a05:6000:5:: with SMTP id h5mr669803wrx.271.1553133863108;
        Wed, 20 Mar 2019 19:04:23 -0700 (PDT)
Received: from [192.168.1.114] (162-195-240-247.lightspeed.sntcca.sbcglobal.net. [162.195.240.247])
        by smtp.gmail.com with ESMTPSA id z198sm3029315wmc.10.2019.03.20.19.04.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 20 Mar 2019 19:04:22 -0700 (PDT)
Subject: Re: [PATCH 1/2] blk-mq: introduce blk_mq_complete_request_sync()
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Bart Van Assche <bvanassche@acm.org>,
        linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>
References: <20190318032950.17770-1-ming.lei@redhat.com>
 <20190318032950.17770-2-ming.lei@redhat.com>
 <f708ee0c-dfa4-0bca-f996-8d834471f1fd@acm.org>
 <20190318073826.GA29746@ming.t460p> <1552921495.152266.8.camel@acm.org>
 <20190318151618.GA20371@ming.t460p> <1552924164.152266.21.camel@acm.org>
 <448615db-64e2-cbe7-c09e-19b2d86a720a@grimberg.me>
 <20190321013908.GA15115@ming.t460p>
From:   Sagi Grimberg <sagi@grimberg.me>
Message-ID: <95da080a-7fb4-33a9-1dc3-4452c565c83a@grimberg.me>
Date:   Wed, 20 Mar 2019 19:04:09 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190321013908.GA15115@ming.t460p>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


>> Hi Bart,
>>
>> If I understand the race correctly, its not between the requests
>> completion and the queue pairs removal nor the timeout handler
>> necessarily, but rather it is between the async requests completion and
>> the tagset deallocation.
>>
>> Think of surprise removal (or disconnect) during I/O, drivers
>> usually stop/quiesce/freeze the queues, terminate/abort inflight
>> I/Os and then teardown the hw queues and the tagset.
>>
>> IIRC, the same race holds for srp if this happens during I/O:
>> 1. srp_rport_delete() -> srp_remove_target() -> srp_stop_rport_timers() ->
>> __rport_fail_io_fast()
>>
>> 2. complete all I/Os (async remotely via smp)
>>
>> Then continue..
>>
>> 3. scsi_host_put() -> scsi_host_dev_release() -> scsi_mq_destroy_tags()
>>
>> What is preventing (3) from happening before (2) if its async? I would
>> think that scsi drivers need the exact same thing...
> 
> blk_cleanup_queue() will do that, but it can't be used in device recovery
> obviously.

But in device recovery we never free the tagset... I might be missing
the race here then...

> BTW, blk_mq_complete_request_sync() is a bit misleading, maybe
> blk_mq_complete_request_locally() is better.

Not really...
