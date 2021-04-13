Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FAF8C433B4
	for <linux-block@archiver.kernel.org>; Tue, 13 Apr 2021 09:36:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 40BAF613B6
	for <linux-block@archiver.kernel.org>; Tue, 13 Apr 2021 09:36:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229446AbhDMJhJ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 13 Apr 2021 05:37:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:54219 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229573AbhDMJhJ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 13 Apr 2021 05:37:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1618306609;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=xZtiYxndyvrgRiioNGZHGj1zKctLULruJBTNpZ12M30=;
        b=Bu6BD9vTTznlSeYfMJX1RDAZEWP7ZDGx5RFdGAvXJSk2N12XZyHh8qXO2JzsvaaOId7/Wu
        tnDaw1qPQkNgfVFEjwtzD4N0Vu3L2pAIgCEt2fSGL4MFy7CHYldvvzDdWRCg+OkooCtY3S
        LGIQzysVt6czqvfQWlMXOtYqcVlI/Bk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-228-cHL0jHROMuCFWGrL6Pfuhg-1; Tue, 13 Apr 2021 05:36:45 -0400
X-MC-Unique: cHL0jHROMuCFWGrL6Pfuhg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A593D88127C;
        Tue, 13 Apr 2021 09:36:44 +0000 (UTC)
Received: from T590 (ovpn-12-66.pek2.redhat.com [10.72.12.66])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 05D916F98A;
        Tue, 13 Apr 2021 09:36:30 +0000 (UTC)
Date:   Tue, 13 Apr 2021 17:36:26 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Jeffle Xu <jefflexu@linux.alibaba.com>,
        Mike Snitzer <snitzer@redhat.com>, dm-devel@redhat.com,
        Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH V5 05/12] block: add new field into 'struct bvec_iter'
Message-ID: <YHVmGggTOkqZYOM+@T590>
References: <20210401021927.343727-1-ming.lei@redhat.com>
 <20210401021927.343727-6-ming.lei@redhat.com>
 <20210412092653.GA972763@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210412092653.GA972763@infradead.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Apr 12, 2021 at 10:26:53AM +0100, Christoph Hellwig wrote:
> I don't like where this is going.
> 
> I think the model of storing the polling cookie in the bio is useful,
> but:
> 
>  (1) I think having this in the iter is a mess.  Can you measure if
>      just marking bvec_iter __packed will generate much worse code
>      at all anymore?  If not we can just move this into the bio

Just test with packed 'struct bvec_iter' by running io_uring/libaio over
nvme/null_blk with different bs size, not see obvious difference
compared with unpacked bvec_iter.

So will switch to packed bvec_iter in next version.

>      If it really generates much worse code I think you need to pick
>      a different name as  as that i really confusing vs the bio field
>      of the same name that is used entirely differenly.  Similarly
>      the bio_get_private_data and bio_set_private_data helpers are
>      entirely misnamed, as the names suggest they deal with the
>      bi_private field in struct bio.  I actually suspect not having
>      these helpers would be much preferable

OK, how about naming it as .bi_poll_data?


Thanks,
Ming

