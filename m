Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:52876 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752734AbeC0OBo (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 27 Mar 2018 10:01:44 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w2RE1Q6A118486
        for <linux-block@vger.kernel.org>; Tue, 27 Mar 2018 10:01:44 -0400
Received: from e06smtp13.uk.ibm.com (e06smtp13.uk.ibm.com [195.75.94.109])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2gyq6vrrpw-1
        (version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=NOT)
        for <linux-block@vger.kernel.org>; Tue, 27 Mar 2018 10:01:39 -0400
Received: from localhost
        by e06smtp13.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-block@vger.kernel.org> from <sth@linux.vnet.ibm.com>;
        Tue, 27 Mar 2018 15:01:24 +0100
Subject: Re: 4.16-RC7 WARNING: CPU: 2 PID: 0 at block/blk-mq.c:1400
 __blk_mq_delay_run_hw_queue
To: Ming Lei <ming.lei@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>
References: <96392d4b-f890-7b34-8f1e-8d51855327cc@linux.vnet.ibm.com>
 <20180327120143.GA20265@ming.t460p>
From: Stefan Haberland <sth@linux.vnet.ibm.com>
Date: Tue, 27 Mar 2018 16:01:21 +0200
MIME-Version: 1.0
In-Reply-To: <20180327120143.GA20265@ming.t460p>
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <c3c647d0-d44f-9711-de93-2b1453f0eeb5@linux.vnet.ibm.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org


> This warning is harmless, please try the following patch:
>
> --
>  From 7b2b5139bfef80f44d1b1424e09ab35b715fbfdb Mon Sep 17 00:00:00 2001
> From: Ming Lei <ming.lei@redhat.com>
> Date: Tue, 27 Mar 2018 19:54:23 +0800
> Subject: [PATCH] blk-mq: only run mapped hw queues in blk_mq_run_hw_queues()
>
>  From commit 20e4d813931961fe ("blk-mq: simplify queue mapping & schedule
> with each possisble CPU") on, it should be easier to see unmapped hctx
> in some CPU topo, such as, hctx may not be mapped to any CPU.
>
> This patch avoids the warning in __blk_mq_delay_run_hw_queue() by
> checking if the hctx is mapped in blk_mq_run_hw_queues().
>
> Reported-by: Stefan Haberland <sth@linux.vnet.ibm.com>
> Cc: Christoph Hellwig <hch@lst.de>
> Fixes: 20e4d813931961fe ("blk-mq: simplify queue mapping & schedule with each possisble CPU")
> Signed-off-by: Ming Lei <ming.lei@redhat.com>
> ---

Hi Ming,

thanks a lot for the patch. I tried it on top of our 4.16-rc7 branch and 
it works well.
I ran a small regression test set against it and I did not notice any 
warnings or other obvious impacts.

Regards,
Stefan
