Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A880C433ED
	for <linux-block@archiver.kernel.org>; Wed, 14 Apr 2021 11:25:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E614E61164
	for <linux-block@archiver.kernel.org>; Wed, 14 Apr 2021 11:25:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350423AbhDNLZz (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 14 Apr 2021 07:25:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:35556 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1350346AbhDNLZ3 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 14 Apr 2021 07:25:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1618399508;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=o5AfkVNBiB9daKdhjQ5//WEK3xyfYoRYmBAHAAyv7i8=;
        b=dPfwwVFC1QHVJnMejPmPAyUJofWso5izz0sgjqRqetdipgtHCMc5uZIHTOxgG0WD3qkUJv
        /VTdOg9Gp4nIbabRU2L4KZ3e0fpgGYeZO/UTCKwRDKyrQe+ihlTB0ixhIRe/ssLMm7Knyf
        6vZx6qKVnfr/c8oaUamsg8c+rrcmRFQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-587-HCbjsELuNau_X6i9fUL_Qw-1; Wed, 14 Apr 2021 07:25:04 -0400
X-MC-Unique: HCbjsELuNau_X6i9fUL_Qw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5EC718026B1;
        Wed, 14 Apr 2021 11:25:03 +0000 (UTC)
Received: from T590 (ovpn-12-91.pek2.redhat.com [10.72.12.91])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 6A1D15D9D0;
        Wed, 14 Apr 2021 11:24:51 +0000 (UTC)
Date:   Wed, 14 Apr 2021 19:24:46 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     JeffleXu <jefflexu@linux.alibaba.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Mike Snitzer <snitzer@redhat.com>, dm-devel@redhat.com,
        Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH V5 11/12] block: add poll_capable method to support
 bio-based IO polling
Message-ID: <YHbQ/rZUPoTFUMDs@T590>
References: <20210401021927.343727-1-ming.lei@redhat.com>
 <20210401021927.343727-12-ming.lei@redhat.com>
 <20210412093856.GA978201@infradead.org>
 <a6d46979-810e-bc53-bc19-8acd449e3718@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a6d46979-810e-bc53-bc19-8acd449e3718@linux.alibaba.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Apr 14, 2021 at 04:38:25PM +0800, JeffleXu wrote:
> 
> 
> On 4/12/21 5:38 PM, Christoph Hellwig wrote:
> > On Thu, Apr 01, 2021 at 10:19:26AM +0800, Ming Lei wrote:
> >> From: Jeffle Xu <jefflexu@linux.alibaba.com>
> >>
> >> This method can be used to check if bio-based device supports IO polling
> >> or not. For mq devices, checking for hw queue in polling mode is
> >> adequate, while the sanity check shall be implementation specific for
> >> bio-based devices. For example, dm device needs to check if all
> >> underlying devices are capable of IO polling.
> >>
> >> Though bio-based device may have done the sanity check during the
> >> device initialization phase, cacheing the result of this sanity check
> >> (such as by cacheing in the queue_flags) may not work. Because for dm
> >> devices, users could change the state of the underlying devices through
> >> '/sys/block/<dev>/io_poll', bypassing the dm device above. In this case,
> >> the cached result of the very beginning sanity check could be
> >> out-of-date. Thus the sanity check needs to be done every time 'io_poll'
> >> is to be modified.
> > 
> > I really don't think thi should be a method, and I really do dislike
> > how we have all this "if (is_mq)" junk.  Why can't we have a flag on
> > the gendisk that signals if the device can support polling that
> > is autoamtically set for blk-mq and as-needed by bio based drivers?
> 
> That would consume one more bit of queue->queue_flags.
> 
> Besides, DM/MD is somehow special here that when one of the underlying
> devices is disabled polling through '/sys/block/<dev>/io_poll',
> currently there's no mechanism notifying the above MD/DM to clear the
> previously set queue_flags. Thus the outdated queue_flags still
> indicates this DM/MD is capable of polling, while in fact one of the
> underlying device has been disabled for polling.

Right, just like there isn't queue limit progagation.

Another blocker could be that bio based queue doesn't support queue
freezing.

> 
> Mike had ever suggested that we can trust the queue_flag, and clear the
> outdated queue_flags when later the IO submission or polling routine
> finally finds that the device is not capable of polling. Currently
> submit_bio_checks() will silently clear the REQ_HIPRI flag and still
> submit the bio when the device is actually not capable of polling. To
> fix the issue, could we break the submission and return an error code in
> submit_bio_checks() if the device is not capable of polling when
> submitting HIPRI bio?

I think we may just leave it alone, if underlying queue becomes not pollable,
the bio still can be submitted & completed via IRQ, just not efficient enough.


Thanks,
Ming

