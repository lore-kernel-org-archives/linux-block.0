Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F02C8C433F5
	for <linux-block@archiver.kernel.org>; Thu,  9 Sep 2021 09:19:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C7590610FF
	for <linux-block@archiver.kernel.org>; Thu,  9 Sep 2021 09:19:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232344AbhIIJVB (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 9 Sep 2021 05:21:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:57015 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232262AbhIIJVB (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 9 Sep 2021 05:21:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1631179191;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=gHc6yQh4bZ0nkgFs4V+Wl3ELn3opFlH0MP9OFrEUNfo=;
        b=f9SfQ3zm6lskghXnJ2i4xYw0jIhViB6csamJliW81g+E/Mi/z3S1lWRWL0dzGe0s88TakS
        GqAce1FlespzQYtmorifQ3b6VL7/X5gi2tYfAyF8IabGBA7DaoKKQBivkzni7I5kD+YXer
        S6yEjBLpu+bsrrfajLBjRqEhuopUm6E=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-553-7ViEeBETObGk_ziTOurNdQ-1; Thu, 09 Sep 2021 05:19:50 -0400
X-MC-Unique: 7ViEeBETObGk_ziTOurNdQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 88E1F1800D41;
        Thu,  9 Sep 2021 09:19:49 +0000 (UTC)
Received: from T590 (ovpn-14-6.pek2.redhat.com [10.72.14.6])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 88A8326DF2;
        Thu,  9 Sep 2021 09:19:43 +0000 (UTC)
Date:   Thu, 9 Sep 2021 17:19:47 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Hou Tao <houtao1@huawei.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Subject: Re: [PATCH] block: check the existence of tags[hctx_idx] in
 blk_mq_clear_rq_mapping()
Message-ID: <YTnRsxec3JfPINmu@T590>
References: <20210909090054.492923-1-houtao1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210909090054.492923-1-houtao1@huawei.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hello Hou,

On Thu, Sep 09, 2021 at 05:00:54PM +0800, Hou Tao wrote:
> According to commit 4412efecf7fd ("Revert "blk-mq: remove code for
> dealing with remapping queue""), for some devices queue hctx may not
> being mapped, and tagset->tags[hctx_idx] will be released and be NULL.
> 
> If an IO scheduler is used on these devices, blk_mq_clear_rq_mapping()
> will be called for all hctxs in blk_mq_sched_free_requests() during
> scheduler switch, and these will be oops. So checking the existence of
> tags[hctx_idx] before going on in blk_mq_clear_rq_mapping().

unmapped hctx should be caused by blk_mq_update_nr_hw_queues() only,
but scheduler tags is updated there too, so not sure it is one real
issue, did you observe such kernel panic? any kernel log?


Thanks,
Ming

