Return-Path: <SRS0=ZVtD=YS=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C480CA9EA0
	for <linux-block@archiver.kernel.org>; Fri, 25 Oct 2019 22:33:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D059120684
	for <linux-block@archiver.kernel.org>; Fri, 25 Oct 2019 22:33:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726510AbfJYWdW (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 25 Oct 2019 18:33:22 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:35369 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726508AbfJYWdW (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 25 Oct 2019 18:33:22 -0400
Received: by mail-wr1-f65.google.com with SMTP id l10so4021335wrb.2
        for <linux-block@vger.kernel.org>; Fri, 25 Oct 2019 15:33:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=jYGAIjxJtGy0i1l3ddvlTAAx9yrTun1A7UYc6BjOUzM=;
        b=mwi+8raGyGmfJSqiArkzdi0J3vj+AfXQPvrjwLlkpBJaq3jIqbjVRmTJzyplZh2O5S
         z1TYLP6A/nDIxvHYV2vRSRWZUWYiuFOVrhzCelsCOErCRaMSftUXlZQyZJEX28+B72ty
         Hs9DFu6E2C+DYij9oha3bkjV6wU931WByz5b+o3OANsQlFPP3ZSYyKJ18BYE+cgxb+Qw
         DANLLdUB9SmBc5SBIiM/N1vj4mS7EaEYbCSFbJGchjr3V6FB/wNrVrnYIwU1ByY7vDyu
         lhICCush9sJp0ynx/5qepUH2yKnCCZXElhrs/048TIY9FZ/MXjuWZxHGka5QLvgoXWBQ
         c+pg==
X-Gm-Message-State: APjAAAVi8ZLdhtCEGXrTOt4gbhPto5jwtuH1GQQeq1XaGcKRFj/DERio
        IIAa+BDMa4OPE6Cn168TrxxI5U/F
X-Google-Smtp-Source: APXvYqzMS2+S/+5Vkzi1fGBd/Rnfg/vgtHLpIjIw6R753CK1B8DOgP9P3sedda4dtI4L8u3PeaOWRw==
X-Received: by 2002:adf:8088:: with SMTP id 8mr4824176wrl.230.1572042799676;
        Fri, 25 Oct 2019 15:33:19 -0700 (PDT)
Received: from ?IPv6:2600:1700:65a0:78e0:514:7862:1503:8e4d? ([2600:1700:65a0:78e0:514:7862:1503:8e4d])
        by smtp.gmail.com with ESMTPSA id n3sm4194323wrr.50.2019.10.25.15.33.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 25 Oct 2019 15:33:19 -0700 (PDT)
Subject: Re: [PATCH] blk-mq: Fix cpu indexing error in
 blk_mq_alloc_request_hctx()
To:     Ming Lei <ming.lei@redhat.com>
Cc:     James Smart <jsmart2021@gmail.com>, Jens Axboe <axboe@kernel.dk>,
        Ming Lei <tom.leiming@gmail.com>,
        linux-block <linux-block@vger.kernel.org>,
        Shagun Agrawal <shagun.agrawal@broadcom.com>,
        Christoph Hellwig <hch@lst.de>
References: <20191023175700.18615-1-jsmart2021@gmail.com>
 <CACVXFVN+xXL9EJbrCPC50vOD0sG1pX1npUFSNZSNGBLyutLh0w@mail.gmail.com>
 <cd913d58-1b06-69df-3b4e-7d00f2d4074f@kernel.dk>
 <810e40ce-a111-f56a-84d1-03f0e74f14e3@gmail.com>
 <20191025072220.GA7197@ming.t460p>
 <60f569f8-688c-4b8a-86b4-48456253473a@grimberg.me>
 <20191025222000.GC7076@ming.t460p>
From:   Sagi Grimberg <sagi@grimberg.me>
Message-ID: <ed9cf494-143a-409e-cd73-1d410eb81430@grimberg.me>
Date:   Fri, 25 Oct 2019 15:33:15 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191025222000.GC7076@ming.t460p>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


>>>> hctx is specified specifically, it is the 1st command on a new nvme
>>>> controller queue. The command *must* be issued on the queue it is to
>>>> initialize (this is different from pci nvme).  The hctx is specified so the
>>>> correct nvme queue is selected when the command comes down the request path.
>>>> Saying "don't do that" means one of the following: a) snooping every rq on
>>>> the request path to spot initialization ios and move them to the right
>>>> queue; or b) creating a duplicate non-blk-mq request path for this 1
>>>> initialization io. Both of those are ugly.
>>>
>>> In nvmf_connect_io_queue(), 'qid' has been encoded into instance of 'struct
>>> nvme_command', that means the 'nvme controller' should know the
>>> specified queue by parsing the command. So still not understand why you
>>> have to submit the command via the specified queue.
>>
>> The connect command must be send on the queue that it is connecting, the
>> qid is telling the controller the id of the queue, but the controller
>> still expects the connect to be issued on the queue that it is designed
>> to connect (or rather initialize).
>>
>> in queue_rq we take queue from hctx->driver_data and use it to issue
>> the command. The connect is different that it is invoked on a context
>> that is not necessarily running from a cpu that maps to this specific
>> hctx. So in essence what is needed is a tag from the specific queue tags
>> without running cpu consideration.
> 
> OK, got it.
> 
> If nvmf_connect_io_queue() is only run before setting up IO queues, the
> shared tag problem could be solved easily, such as, use a standalone
> tagset?

Not sure what you mean exactly...

Also, keep in mind that this sequence also goes into reconnects, where
we already have our tagset allocated (with pending requests
potentially).
