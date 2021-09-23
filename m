Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0439AC433EF
	for <linux-block@archiver.kernel.org>; Thu, 23 Sep 2021 01:51:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DB1F461050
	for <linux-block@archiver.kernel.org>; Thu, 23 Sep 2021 01:51:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238827AbhIWBx2 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 22 Sep 2021 21:53:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:33910 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238817AbhIWBx2 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 22 Sep 2021 21:53:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1632361917;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=dyuxoV4RBxyTzGCZksaUnizHq5UMywQKXiNbZoUn/Dw=;
        b=bWxkds8OEAJv5MEvUGG4DqGLS+QdiQ/hKNskP6mYH7BGv5nIZSbdhYy44Taj2lcM4q5nqv
        6kVt7o2MJHDdKtBir2vIHN9s5P5wS1iMurDqe5xqz3ZbLFcsL/VtWrD1ptAvfwyna6oRjO
        sBr/uz87O8gLkaoHZqgn6cKxJ1bWuLs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-531-SsDKfbExNxK9KgSZScUW6A-1; Wed, 22 Sep 2021 21:51:55 -0400
X-MC-Unique: SsDKfbExNxK9KgSZScUW6A-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1E9121084684;
        Thu, 23 Sep 2021 01:51:54 +0000 (UTC)
Received: from T590 (ovpn-8-17.pek2.redhat.com [10.72.8.17])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id E9FF060BF1;
        Thu, 23 Sep 2021 01:51:47 +0000 (UTC)
Date:   Thu, 23 Sep 2021 09:51:58 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Jan Kara <jack@suse.cz>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Subject: Re: [PATCH] block: hold ->invalidate_lock in blkdev_fallocate
Message-ID: <YUvdviw/S8TewUvJ@T590>
References: <20210915123545.1000534-1-ming.lei@redhat.com>
 <20210916141655.GI10610@quack2.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210916141655.GI10610@quack2.suse.cz>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Sep 16, 2021 at 04:16:55PM +0200, Jan Kara wrote:
> On Wed 15-09-21 20:35:45, Ming Lei wrote:
> > When running ->fallocate(), blkdev_fallocate() should hold
> > mapping->invalidate_lock to prevent page cache from being
> > accessed, otherwise stale data may be read in page cache.
> > 
> > Without this patch, blktests block/009 fails sometimes. With
> > this patch, block/009 can pass always.
> > 
> > Cc: Jan Kara <jack@suse.cz>
> > Signed-off-by: Ming Lei <ming.lei@redhat.com>
> 
> Interesting. Looking at block/009 testcase I'm somewhat struggling to see
> how it could trigger a situation where stale data would be seen. Do you
> have some independent read accesses to the block device while the testcase
> is running? That would explain it and yes, this patch should fix that.

Yeah, the issue can be reproduced quite easily if independent read is
run. However, sometimes it can be triggered without this read, since
systemd-udev or reading partition table may do that too.

> 
> BTW, you'd need to rebase this against current Linus' tree - Christoph has
> moved this code to block/...

OK.

> 
> Also with the invalidate_lock held, there's no need for the second
> truncate_bdev_range() call anymore. No pages can be created in the
> discarded area while you are holding the invalidate_lock.

Good catch, will remove the 2nd truncate_bdev_range() in V2.


Thanks, 
Ming

