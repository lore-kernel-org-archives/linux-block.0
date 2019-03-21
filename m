Return-Path: <SRS0=o3qj=RY=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE932C43381
	for <linux-block@archiver.kernel.org>; Thu, 21 Mar 2019 02:13:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE77A218D3
	for <linux-block@archiver.kernel.org>; Thu, 21 Mar 2019 02:13:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726914AbfCUCNn (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 20 Mar 2019 22:13:43 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:38719 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726487AbfCUCNm (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 20 Mar 2019 22:13:42 -0400
Received: by mail-wm1-f68.google.com with SMTP id a188so1113487wmf.3
        for <linux-block@vger.kernel.org>; Wed, 20 Mar 2019 19:13:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=hamRAJEU4Al1z4yC+j0o+0Bjec3gVu0r0q1n2fWiPSA=;
        b=uHaZRXGoJ08baG0Fj2nqkUc7ovRyfLTWqshnNxI0SFnXiwhdW6KtpQY60LyTfL1vvj
         sA85tRL+cHWbOBj0r3FzvFvwkq/N/dVv6GbI846+M/E8HIDyknBWQqE+f7kveLumzpAs
         ghpzuKFMq/AkQ93pPGVTcHeC/k1m72x7Va0u9qlr/IDzAqrIgd/J9e5g3QPUY1Hg8Y0c
         DIKMFBReMpGa+z69C1UGMSl8VUNJBXf3J7t8tEVy+gUM9BYaF3YQ5HzOtLbBALz2jlZM
         5e4+DXre2XgpkkZEofkRD6PDFYi8Y8FX15gfVu57HEzU84rPEbYnYhLo4iidk3nCy3D2
         4o/w==
X-Gm-Message-State: APjAAAWKLVTmHwXNxF8vudJSLyx0FWsBQY86a3QN6vQ06LJIl+7aj04t
        rmu075qKuhOEjyBxGycYwzQ=
X-Google-Smtp-Source: APXvYqyQPVIMUBNmuBvn9KZj+rM+ABUEUWRLN0qcBOXehUj49pvFmPX6o7DZQadsQIRfWiDVxGOzmA==
X-Received: by 2002:a1c:7dcb:: with SMTP id y194mr791315wmc.1.1553134420871;
        Wed, 20 Mar 2019 19:13:40 -0700 (PDT)
Received: from [192.168.1.114] (162-195-240-247.lightspeed.sntcca.sbcglobal.net. [162.195.240.247])
        by smtp.gmail.com with ESMTPSA id g8sm8805030wro.77.2019.03.20.19.13.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 20 Mar 2019 19:13:40 -0700 (PDT)
Subject: Re: [PATCH 1/2] blk-mq: introduce blk_mq_complete_request_sync()
To:     Ming Lei <ming.lei@redhat.com>,
        Bart Van Assche <bvanassche@acm.org>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>, linux-nvme@lists.infradead.org
References: <20190318032950.17770-1-ming.lei@redhat.com>
 <20190318032950.17770-2-ming.lei@redhat.com>
 <f708ee0c-dfa4-0bca-f996-8d834471f1fd@acm.org>
 <20190318073826.GA29746@ming.t460p>
From:   Sagi Grimberg <sagi@grimberg.me>
Message-ID: <7429e912-5978-91b9-bbba-75b0264596d4@grimberg.me>
Date:   Wed, 20 Mar 2019 19:13:31 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190318073826.GA29746@ming.t460p>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


>>> In NVMe's error handler, follows the typical steps for tearing down
>>> hardware:
>>>
>>> 1) stop blk_mq hw queues
>>> 2) stop the real hw queues
>>> 3) cancel in-flight requests via
>>> 	blk_mq_tagset_busy_iter(tags, cancel_request, ...)
>>> cancel_request():
>>> 	mark the request as abort
>>> 	blk_mq_complete_request(req);
>>> 4) destroy real hw queues
>>>
>>> However, there may be race between #3 and #4, because blk_mq_complete_request()
>>> actually completes the request asynchronously.
>>>
>>> This patch introduces blk_mq_complete_request_sync() for fixing the
>>> above race.
>>
>> Other block drivers wait until outstanding requests have completed by
>> calling blk_cleanup_queue() before hardware queues are destroyed. Why can't
>> the NVMe driver follow that approach?
> 
> The tearing down of controller can be done in error handler, in which
> the request queues may not be cleaned up, almost all kinds of NVMe
> controller's error handling follows the above steps, such as:
> 
> nvme_rdma_error_recovery_work()
> 	->nvme_rdma_teardown_io_queues()

Clarification, this happens in its dedicated context, not the timeout or
error handler.

But I still don't understand the issue here, what is the exact race you
are referring to? that we abort/cancel a request and then we complete
it again when we destroy the HW queue?

If so, that is not the case (at least for rdma/tcp) because
nvme_rdma_teardown_io_queues() first flushes the hw queue and then
aborts inflight I/O.
