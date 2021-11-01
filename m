Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3897DC433F5
	for <linux-block@archiver.kernel.org>; Mon,  1 Nov 2021 00:28:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 11BBB60EBC
	for <linux-block@archiver.kernel.org>; Mon,  1 Nov 2021 00:28:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230289AbhKAAbG (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 31 Oct 2021 20:31:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:44994 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230246AbhKAAbF (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 31 Oct 2021 20:31:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1635726512;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=bwK7P4QgnRnUF2ekpWubt1matGUWb4X+us3G6c5xcg8=;
        b=U7+uZV5OQm8/Y6obBxMy+pHMTUEo6/J7wZGQeaT2SIV8dWWYFlcgDwzUT3yu5sq/gVeIqw
        ixKa15YntgARDIRDMIVxNiRE7d9zYfT/rMFLZhulDWnLk7Zn13tf9I605tuCQPxhq6k1z0
        rlnxo5LKYNp0Hfpm7ovWxebb47a6GX0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-249-Q-OEjBXROCC95hHeKdPuAQ-1; Sun, 31 Oct 2021 20:28:29 -0400
X-MC-Unique: Q-OEjBXROCC95hHeKdPuAQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0BD6A8018AC;
        Mon,  1 Nov 2021 00:28:28 +0000 (UTC)
Received: from T590 (ovpn-8-17.pek2.redhat.com [10.72.8.17])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 069E72B399;
        Mon,  1 Nov 2021 00:28:19 +0000 (UTC)
Date:   Mon, 1 Nov 2021 08:28:13 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Minchan Kim <minchan@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Luis Chamberlain <mcgrof@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, ming.lei@redhat.com
Subject: Re: [PATCH V3 0/4] zram: fix two races and one zram leak
Message-ID: <YX80nS0ypqCytdwC@T590>
References: <20211025025426.2815424-1-ming.lei@redhat.com>
 <YXbbj7KhgAkgByp1@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YXbbj7KhgAkgByp1@google.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hello Andrew Morton and Jens,

On Mon, Oct 25, 2021 at 09:30:07AM -0700, Minchan Kim wrote:
> On Mon, Oct 25, 2021 at 10:54:22AM +0800, Ming Lei wrote:
> > Hello,
> > 
> > Fixes three issues reported by Luis Chamberlain with one simpler approach:
> > 
> > - race between between zram_reset_device() and disksize_store() (1/4)
> > 
> > - zram leak during unloading module, which is one race between resetting
> > and removing device (2/4)
> > 
> > - race between zram_remove and disksize_store (3/4)
> > 
> > Also replace replace fsync_bdev with sync_blockdev since no one opens
> > it.(4/4)
> > 
> > V3:
> > 	- no code change
> > 	- update commit log or comment as Luis suggested
> > 	- add reviewed-by tag
> > 
> > V2:
> > 	- take another approach to avoid failing of zram_remove()
> > 	- add patch to address race between zram_reset_device() and
> > 	  disksize_store()
> > 
> > 
> > Ming Lei (4):
> >   zram: fix race between zram_reset_device() and disksize_store()
> >   zram: don't fail to remove zram during unloading module
> >   zram: avoid race between zram_remove and disksize_store
> >   zram: replace fsync_bdev with sync_blockdev
> 
> Andrew Morton usually takes zram patches so Ccing him.
> 
> Acked-by: Minchan Kim <minchan@kernel.org>
> 
> for all patches in this thread.
 
Any chance to make it in v5.16?

Thanks,
Ming

