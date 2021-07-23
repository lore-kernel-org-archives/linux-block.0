Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AB69C432BE
	for <linux-block@archiver.kernel.org>; Fri, 23 Jul 2021 08:16:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 54C6B60EBD
	for <linux-block@archiver.kernel.org>; Fri, 23 Jul 2021 08:16:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234529AbhGWHgO (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 23 Jul 2021 03:36:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:36098 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234497AbhGWHgM (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 23 Jul 2021 03:36:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1627028206;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kkHeqBN9xvRmsaZS4MvNMczkNr3D6j3+VlyTB6yFx9A=;
        b=PyWErowDbZWqdyg8Fir0OZYG4Gw84R8qkCQ0BxkltvqixF2M2uYvDfrlUd9QrGOlr5mLRg
        dWj2NPXT7ljTnY0jkLQagGxGf8s5KMIPaTizll8AtZt19nO/hIUKJ0nOBxw8m3HJabtQnu
        LIxEH/GlKijMykEn2R6gBpEUrbfXA2I=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-210-4FyVzKZ4NQaeJ4rMpiVKJg-1; Fri, 23 Jul 2021 04:16:42 -0400
X-MC-Unique: 4FyVzKZ4NQaeJ4rMpiVKJg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E72F187D541;
        Fri, 23 Jul 2021 08:16:40 +0000 (UTC)
Received: from T590 (ovpn-12-180.pek2.redhat.com [10.72.12.180])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id B92F55D9C6;
        Fri, 23 Jul 2021 08:16:35 +0000 (UTC)
Date:   Fri, 23 Jul 2021 16:16:30 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Wen Xiong <wenxiong@us.ibm.com>
Cc:     dwagner@suse.de, axboe@kernel.dk, gregkh@linuxfoundation.org,
        hare@suse.de, hch@lst.de, john.garry@huawei.com,
        linux-block@vger.kernel.org, sagi@grimberg.me, tglx@linutronix.de
Subject: Re: [PATCH V6 0/3] blk-mq: fix blk_mq_alloc_request_hctx
Message-ID: <YPp63niga//Q6GLV@T590>
References: <20210722131245.u4dhcqotepxhwgbz@beryllium.lan>
 <20210722095246.1240526-1-ming.lei@redhat.com>
 <OFDADF39F5.DDB99A55-ON0025871A.00794382-0025871A.00797A2E@ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <OFDADF39F5.DDB99A55-ON0025871A.00794382-0025871A.00797A2E@ibm.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Jul 22, 2021 at 10:06:51PM +0000, Wen Xiong wrote:
>    > Wen Xiong has verified V4 in her nvmef test.
> 
>    >>FWIW, I am testing this series right now. I observe hanging I/Os
>    >>again, but I am not totally sure if my test setup is working
>    >>properly. Working on it. I'll keep you posted.
>     
> 
>  I built the latest upstream(v5.14-rc2) + Ming's V6 + Daniel's V3: didn't work.
> 

Hi Wenxiong,

V6 is basically same with V4, can you figure out where the failure
comes?(v5.14-rc2, V6 or Daniel's V3) 

I verified that V6 works as expected by tracing blk_mq_update_queue_map():

#!/usr/bin/bpftrace
#include <linux/blk-mq.h>
kprobe:blk_mq_update_queue_map
{
	@in_map[tid]=1;
	@set[tid] = (struct blk_mq_tag_set *)arg0;
	@ms[tid] = kstack;
}

kretprobe:blk_mq_update_queue_map
/@in_map[tid]==1/
{
	$s = @set[tid];
	$m = (struct blk_mq_queue_map *)$s->map;

	printf("%s %d: %s queues %d use_managed_irq %d\n",
		comm, pid, @ms[tid], $s->nr_hw_queues, $m->use_managed_irq);
}


Thanks,
Ming

