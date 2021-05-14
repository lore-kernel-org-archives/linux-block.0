Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52939C433B4
	for <linux-block@archiver.kernel.org>; Fri, 14 May 2021 00:43:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2ECEA61421
	for <linux-block@archiver.kernel.org>; Fri, 14 May 2021 00:43:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231159AbhENApC (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 13 May 2021 20:45:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:28538 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231826AbhENApC (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 13 May 2021 20:45:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1620953031;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=fSpObU/MutR7JjIlPvkAIGgdfX9rUhAqm4YtXAKuWAw=;
        b=XnVBFuBci8FPO7H7388vE4QT1eHRUNRnjzy4xM4HoXvJ1NHwYVS+qzpRjDwDG1Qxry8WkA
        yxLEtKVc8NUoEtZmizKnSJALmbuKFfdPpnNDe0dI4pWf/MvpH7BlFJ0BADNu/jX8df4oZU
        bYRXYCMQKCW7xfabr3zIUB/m8lejRKk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-352-_4lbc2wFPxmVUBnbnPfouQ-1; Thu, 13 May 2021 20:43:47 -0400
X-MC-Unique: _4lbc2wFPxmVUBnbnPfouQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5E148107ACE3;
        Fri, 14 May 2021 00:43:46 +0000 (UTC)
Received: from T590 (ovpn-12-87.pek2.redhat.com [10.72.12.87])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 7EF955D9E3;
        Fri, 14 May 2021 00:43:39 +0000 (UTC)
Date:   Fri, 14 May 2021 08:43:34 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Bart Van Assche <bvanassche@acm.org>,
        Hannes Reinecke <hare@suse.de>,
        John Garry <john.garry@huawei.com>,
        Christoph Hellwig <hch@lst.de>,
        David Jeffery <djeffery@redhat.com>,
        Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: Re: [PATCH V7 0/4] blk-mq: fix request UAF related with iterating
 over tagset requests
Message-ID: <YJ3Htj8rlJ6uunqn@T590>
References: <20210511152236.763464-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210511152236.763464-1-ming.lei@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, May 11, 2021 at 11:22:32PM +0800, Ming Lei wrote:
> Hi Jens,
> 
> This patchset fixes the request UAF issue by one simple approach,
> without clearing ->rqs[] in fast path, please consider it for 5.13.
> 
> 1) grab request's ref before calling ->fn in blk_mq_tagset_busy_iter,
> and release it after calling ->fn, so ->fn won't be called for one
> request if its queue is frozen, done in 2st patch
> 
> 2) clearing any stale request referred in ->rqs[] before freeing the
> request pool, one per-tags spinlock is added for protecting
> grabbing request ref vs. clearing ->rqs[tag], so UAF by refcount_inc_not_zero
> in bt_tags_iter() is avoided, done in 3rd patch.
> 
> V7:
> 	- fix one null-ptr-deref during updating nr_hw_queues, because
> 	blk_mq_clear_flush_rq_mapping() may touch non-mapped hw queue's
> 	tags, only patch 4/4 is modified, reported and verified by
> 	Shinichiro Kawasaki
> 	- run blktests and not see regression

Hi Jens,

We have been working on this issue for a bit long, so any chance to get
the fixes merged? Either 5.13 or 5.14 is fine.


Thanks,
Ming

