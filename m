Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08442C433DB
	for <linux-block@archiver.kernel.org>; Wed, 27 Jan 2021 17:23:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A7CD664DA0
	for <linux-block@archiver.kernel.org>; Wed, 27 Jan 2021 17:23:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232596AbhA0RXG (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 27 Jan 2021 12:23:06 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:43139 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235778AbhA0RWb (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 27 Jan 2021 12:22:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1611768065;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=1k42yrzynoJdW/mIgJS2LBkAIc5NZ4zN2WGACxfV04M=;
        b=W8BwFOrB1iKhzUp2PVJNKso3R1ia1nq1dhBJCTcYcnXpBKmm3pGfd41+s0tokaqenMx1TX
        1aLl/OBI1NhbLtK4eXdyVd+KsfieePRivwrt4PPGEamD4VQMZlm3Iko4fPygEGuq55o7/C
        hBeSVuwD3ffQjLEkpcYzUFx1uEy0klg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-93-Yn7D8UwXPWu_3Es00bVwag-1; Wed, 27 Jan 2021 12:21:01 -0500
X-MC-Unique: Yn7D8UwXPWu_3Es00bVwag-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D0F641800D42;
        Wed, 27 Jan 2021 17:20:59 +0000 (UTC)
Received: from localhost (unknown [10.18.25.174])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id B5C351F0;
        Wed, 27 Jan 2021 17:20:56 +0000 (UTC)
Date:   Wed, 27 Jan 2021 12:20:56 -0500
From:   Mike Snitzer <snitzer@redhat.com>
To:     Jeffle Xu <jefflexu@linux.alibaba.com>
Cc:     joseph.qi@linux.alibaba.com, dm-devel@redhat.com,
        linux-block@vger.kernel.org, io-uring@vger.kernel.org
Subject: Re: [PATCH v2 2/6] block: add queue_to_disk() to get gendisk from
 request_queue
Message-ID: <20210127172055.GB11530@redhat.com>
References: <20210125121340.70459-1-jefflexu@linux.alibaba.com>
 <20210125121340.70459-3-jefflexu@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210125121340.70459-3-jefflexu@linux.alibaba.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Jan 25 2021 at  7:13am -0500,
Jeffle Xu <jefflexu@linux.alibaba.com> wrote:

> Sometimes we need to get the corresponding gendisk from request_queue.
> 
> It is preferred that block drivers store private data in
> gendisk->private_data rather than request_queue->queuedata, e.g. see:
> commit c4a59c4e5db3 ("dm: stop using ->queuedata").
> 
> So if only request_queue is given, we need to get its corresponding
> gendisk to get the private data stored in that gendisk.
> 
> Signed-off-by: Jeffle Xu <jefflexu@linux.alibaba.com>
> Review-by: Mike Snitzer <snitzer@redhat.com>

^typo

Reviewed-by: Mike Snitzer <snitzer@redhat.com>

