Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C420AC433FE
	for <linux-block@archiver.kernel.org>; Mon, 13 Sep 2021 01:44:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9C84D610A3
	for <linux-block@archiver.kernel.org>; Mon, 13 Sep 2021 01:44:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236863AbhIMBpP (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 12 Sep 2021 21:45:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:59621 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231810AbhIMBpO (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 12 Sep 2021 21:45:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1631497439;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=LkmP91slQwsUP8ZD49/oIcABO5O4kc//bi/gYOi9hak=;
        b=h7P8VISOEOrUY8EAqZ8cjXnUGUR0D3OMi1TBalvd+gXRweNWMrLQhhj1u6pLHyC+mx21hW
        hZ+Sg83G99rQldLhzwOw9TiTmtyrEfl0n5axlrqCv80TXInXBtFs7mmF0MSq5GUthGiY9e
        h7Q001p9fET9Aw03GDaUkN9sbR91Mfw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-57-FI2ST22FNteMNCE-0kf0kw-1; Sun, 12 Sep 2021 21:43:58 -0400
X-MC-Unique: FI2ST22FNteMNCE-0kf0kw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4D74F835DE0;
        Mon, 13 Sep 2021 01:43:57 +0000 (UTC)
Received: from T590 (ovpn-12-120.pek2.redhat.com [10.72.12.120])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 819213AB2;
        Mon, 13 Sep 2021 01:43:51 +0000 (UTC)
Date:   Mon, 13 Sep 2021 09:43:59 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Hou Tao <houtao1@huawei.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Subject: Re: [PATCH] block: check the existence of tags[hctx_idx] in
 blk_mq_clear_rq_mapping()
Message-ID: <YT6s35QwBSiFJ1Ko@T590>
References: <20210909090054.492923-1-houtao1@huawei.com>
 <YTnRsxec3JfPINmu@T590>
 <96dd1720-343f-64db-42e9-788baec4b466@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <96dd1720-343f-64db-42e9-788baec4b466@huawei.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Sep 09, 2021 at 07:14:20PM +0800, Hou Tao wrote:
> Hi,
> 
> On 9/9/2021 5:19 PM, Ming Lei wrote:
> > Hello Hou,
> >
> > On Thu, Sep 09, 2021 at 05:00:54PM +0800, Hou Tao wrote:
> >> According to commit 4412efecf7fd ("Revert "blk-mq: remove code for
> >> dealing with remapping queue""), for some devices queue hctx may not
> >> being mapped, and tagset->tags[hctx_idx] will be released and be NULL.
> >>
> >> If an IO scheduler is used on these devices, blk_mq_clear_rq_mapping()
> >> will be called for all hctxs in blk_mq_sched_free_requests() during
> >> scheduler switch, and these will be oops. So checking the existence of
> >> tags[hctx_idx] before going on in blk_mq_clear_rq_mapping().
> > unmapped hctx should be caused by blk_mq_update_nr_hw_queues() only,
> > but scheduler tags is updated there too, so not sure it is one real
> > issue, did you observe such kernel panic? any kernel log?
> Not a real issue, just find the potential "problem" during code review.
> 
> But is the case below possible ?
> There is an unmapped hctx and a freed tags[hctx_idx] after
> blk_mq_update_nr_hw_queues(), and IO scheduler is used. When
> switching IO scheduler to none, the previous schedule tag
> on each hctx will be freed in blk_mq_sched_free_requests().
> blk_mq_sched_free_requests() will call blk_mq_free_rqs(), and
> 
> blk_mq_free_rqs() will access the NULLed tags[hctx_idx].

It isn't possible. One invariant is that the first 'q->nr_hw_queues'
elements of ->queue_hw_ctx[] / ->tags[] are valid and the others are
freed after blk_mq_update_nr_hw_queues() returns.


thanks,
Ming

