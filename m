Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4C8BC433C1
	for <linux-block@archiver.kernel.org>; Tue, 23 Mar 2021 11:24:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9C05E619B9
	for <linux-block@archiver.kernel.org>; Tue, 23 Mar 2021 11:24:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230368AbhCWLYY (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 23 Mar 2021 07:24:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:47087 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230269AbhCWLXy (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 23 Mar 2021 07:23:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1616498632;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Zk61jS3KqKSG6QzLB/FeC5xxXemBLc2Y0D51THWfF5Q=;
        b=aya3BioOSld2ZmTz83kJQ2DvQo5WHnx8lmpiPQOFmm0vJxdJa9wz+RcvI9B2i84gbytwLo
        ljs0oN7CLTBSKqMvvg3byitbgSFAqJ7v5cOwR0VuqhUMQPknhYCYgVr2EI/FXjpsL09sVK
        VGRkbUrqMvwOJIW+pY4+F3AWpC3aM8k=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-192-CZNsFCJKOPKVLy4xPU_lWw-1; Tue, 23 Mar 2021 07:23:50 -0400
X-MC-Unique: CZNsFCJKOPKVLy4xPU_lWw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 24E2C5F9C6;
        Tue, 23 Mar 2021 11:23:49 +0000 (UTC)
Received: from T590 (ovpn-13-171.pek2.redhat.com [10.72.13.171])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id ED02060BE5;
        Tue, 23 Mar 2021 11:23:37 +0000 (UTC)
Date:   Tue, 23 Mar 2021 19:23:32 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Mike Snitzer <snitzer@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>,
        Jeffle Xu <jefflexu@linux.alibaba.com>, dm-devel@redhat.com
Subject: Re: [RFC PATCH V2 04/13] block: create io poll context for
 submission and poll task
Message-ID: <YFnPtHiFnojajCUK@T590>
References: <20210318164827.1481133-1-ming.lei@redhat.com>
 <20210318164827.1481133-5-ming.lei@redhat.com>
 <20210319170509.GB9938@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210319170509.GB9938@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Mar 19, 2021 at 01:05:09PM -0400, Mike Snitzer wrote:
> On Thu, Mar 18 2021 at 12:48pm -0400,
> Ming Lei <ming.lei@redhat.com> wrote:
> 
> > Create per-task io poll context for both IO submission and poll task
> > if the queue is bio based and supports polling.
> > 
> > This io polling context includes two queues:
> 1) submission queue(sq) for storing HIPRI bio submission result(cookie)
>    and the bio, written by submission task and read by poll task.

BTW, V2 has switched to store bio only, and cookie is actually stored in
side bio.

> 2) polling queue(pq) for holding data moved from sq, only used in poll
>    context for running bio polling.
>  
> (nit, but it just reads a bit clearer to enumerate the 2 queues)

OK.

-- 
Ming

