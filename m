Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B149C433B4
	for <linux-block@archiver.kernel.org>; Fri,  9 Apr 2021 15:40:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 346C7610F7
	for <linux-block@archiver.kernel.org>; Fri,  9 Apr 2021 15:40:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233137AbhDIPkP (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 9 Apr 2021 11:40:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:53799 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233837AbhDIPkP (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 9 Apr 2021 11:40:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1617982802;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=BBHSNV6tpNyVG6F/Z12ZYRQpMA5sm1Pt/DNXsG5DPU0=;
        b=fyCe+R/PujwSxjAPUbvnA4krrczUYVZdipb6aXvZbBY8xE557E05U+KPo2Rv5NzoF1OIkh
        PqrYcSrjSwXVokzkbNDChCQncyNarUneVrUZbt4RObcJNMwf5fgOz3lo2aF2cErchpgkNB
        ZZBCi1hjoMqq8eAon8VOME4muQf5uEM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-148-Unzi9YyqPNKYYSt56oKo7w-1; Fri, 09 Apr 2021 11:40:00 -0400
X-MC-Unique: Unzi9YyqPNKYYSt56oKo7w-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 882F18018AC;
        Fri,  9 Apr 2021 15:39:59 +0000 (UTC)
Received: from T590 (ovpn-13-213.pek2.redhat.com [10.72.13.213])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 6D7EF5C1A1;
        Fri,  9 Apr 2021 15:39:56 +0000 (UTC)
Date:   Fri, 9 Apr 2021 23:39:51 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org,
        Jeffle Xu <jefflexu@linux.alibaba.com>,
        Mike Snitzer <snitzer@redhat.com>, dm-devel@redhat.com,
        Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH V5 00/12] block: support bio based io polling
Message-ID: <YHB1R5qber/6kHn+@T590>
References: <20210401021927.343727-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210401021927.343727-1-ming.lei@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Apr 01, 2021 at 10:19:15AM +0800, Ming Lei wrote:
> Hi Jens,
> 
> Add per-task io poll context for holding HIPRI blk-mq/underlying bios
> queued from bio based driver's io submission context, and reuse one bio
> padding field for storing 'cookie' returned from submit_bio() for these
> bios. Also explicitly end these bios in poll context by adding two
> new bio flags.
> 
> In this way, we needn't to poll all underlying hw queues any more,
> which is implemented in Jeffle's patches. And we can just poll hw queues
> in which there is HIPRI IO queued.
> 
> Usually io submission and io poll share same context, so the added io
> poll context data is just like one stack variable, and the cost for
> saving bios is cheap.
> 
> V5:
> 	- fix one use-after-free issue in case that polling is from another
> 	context: adds one new cookie of BLK_QC_T_NOT_READY for preventing
> 	this issue in patch 8/12
> 	- add reviewed-by & tested-by tag

Hello Guys,

Ping...


Thanks,
Ming

