Return-Path: <SRS0=ZVtD=YS=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AFE6CA9EA0
	for <linux-block@archiver.kernel.org>; Fri, 25 Oct 2019 20:26:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 254DA222BE
	for <linux-block@archiver.kernel.org>; Fri, 25 Oct 2019 20:26:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728443AbfJYU0x (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 25 Oct 2019 16:26:53 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:36966 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728400AbfJYU0x (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 25 Oct 2019 16:26:53 -0400
Received: by mail-wr1-f66.google.com with SMTP id e11so3765911wrv.4
        for <linux-block@vger.kernel.org>; Fri, 25 Oct 2019 13:26:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=UfQiZb2QG9QT2/xtfAi6QxvJi2mis0SR+qE3deSItHc=;
        b=b27O4QzsiY0gKv64ugRpTEq5os7gKZDq5sardEZ6d/Vze+hsG5MMsuCOljsL9G9WnO
         ulllky/51v6TE4l4so7pkB9+PZwuu/kMDxXqWDr0nudZmalsUK5ISSGE6ndaNmXaMbGb
         mFlrkFQXSC9fraPWXiyvpWmq8xTC5FC2EyQRhEMu2bippHas0+TI0sVXHBILij3Z+zYB
         lBxL7ytFYVhXs9A6v+Gymt4nQmCx3+jJk/cPWmL0VdCzA/g5hO0IatKXt1MqmpoVV7Nx
         DPaV6HG1Pkv1nTlL3tpHN8zfvaLWNPWgVPtrLM9cOdEy0ovxm2OGil7s2w+o+EFJT6uQ
         gfaw==
X-Gm-Message-State: APjAAAVChpybCzth3Mrygl8a7q6YrChr/eLqRTNV35otH8AVCanBZ+cg
        vUCOaafTKSpQxhDpqPHuLZU=
X-Google-Smtp-Source: APXvYqya3C7NNv3w7KbzIhKjfHjd2turh81+/vm2R22AKkZCqQwk7K+faDNjtdtCiH0iNFfDYEsgxg==
X-Received: by 2002:adf:ab5b:: with SMTP id r27mr4843249wrc.13.1572035210969;
        Fri, 25 Oct 2019 13:26:50 -0700 (PDT)
Received: from ?IPv6:2600:1700:65a0:78e0:514:7862:1503:8e4d? ([2600:1700:65a0:78e0:514:7862:1503:8e4d])
        by smtp.gmail.com with ESMTPSA id l26sm2593530wmg.3.2019.10.25.13.26.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 25 Oct 2019 13:26:50 -0700 (PDT)
Subject: Re: [PATCH] blk-mq: Fix cpu indexing error in
 blk_mq_alloc_request_hctx()
To:     Ming Lei <ming.lei@redhat.com>, James Smart <jsmart2021@gmail.com>
Cc:     Jens Axboe <axboe@kernel.dk>, Ming Lei <tom.leiming@gmail.com>,
        linux-block <linux-block@vger.kernel.org>,
        Shagun Agrawal <shagun.agrawal@broadcom.com>,
        Christoph Hellwig <hch@lst.de>
References: <20191023175700.18615-1-jsmart2021@gmail.com>
 <CACVXFVN+xXL9EJbrCPC50vOD0sG1pX1npUFSNZSNGBLyutLh0w@mail.gmail.com>
 <cd913d58-1b06-69df-3b4e-7d00f2d4074f@kernel.dk>
 <810e40ce-a111-f56a-84d1-03f0e74f14e3@gmail.com>
 <20191025072220.GA7197@ming.t460p>
From:   Sagi Grimberg <sagi@grimberg.me>
Message-ID: <60f569f8-688c-4b8a-86b4-48456253473a@grimberg.me>
Date:   Fri, 25 Oct 2019 13:26:46 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191025072220.GA7197@ming.t460p>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


>> hctx is specified specifically, it is the 1st command on a new nvme
>> controller queue. The command *must* be issued on the queue it is to
>> initialize (this is different from pci nvme).  The hctx is specified so the
>> correct nvme queue is selected when the command comes down the request path.
>> Saying "don't do that" means one of the following: a) snooping every rq on
>> the request path to spot initialization ios and move them to the right
>> queue; or b) creating a duplicate non-blk-mq request path for this 1
>> initialization io. Both of those are ugly.
> 
> In nvmf_connect_io_queue(), 'qid' has been encoded into instance of 'struct
> nvme_command', that means the 'nvme controller' should know the
> specified queue by parsing the command. So still not understand why you
> have to submit the command via the specified queue.

The connect command must be send on the queue that it is connecting, the
qid is telling the controller the id of the queue, but the controller
still expects the connect to be issued on the queue that it is designed
to connect (or rather initialize).

in queue_rq we take queue from hctx->driver_data and use it to issue
the command. The connect is different that it is invoked on a context
that is not necessarily running from a cpu that maps to this specific
hctx. So in essence what is needed is a tag from the specific queue tags
without running cpu consideration.
