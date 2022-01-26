Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19935C28CF5
	for <linux-block@archiver.kernel.org>; Wed, 26 Jan 2022 07:19:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237686AbiAZHTI (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 26 Jan 2022 02:19:08 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:32014 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237685AbiAZHTH (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 26 Jan 2022 02:19:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643181546;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=wKoqkCH+N7EH9oaGV6vnXSi8T641QYOTg5q8SmGyjXo=;
        b=KD/S9PGHQrYTmTAHCMnZ6MLeQIEabQbJpP6e137aE2Gehc9/LTmuGDiFUrSefeEQRCQvCQ
        HkQsgicPo1F2yFTEVOCQxF8omdlYN9gEC4bbZlr4oiR7MwqvRMwwisNb9ESk5ArxqRGLGM
        thDFlR2j+FhgrcwhZhmyAAG4wN9NJEk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-641-SguHQcSsN_yi9obvyOt4ag-1; Wed, 26 Jan 2022 02:19:02 -0500
X-MC-Unique: SguHQcSsN_yi9obvyOt4ag-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 65025835B4D;
        Wed, 26 Jan 2022 07:19:01 +0000 (UTC)
Received: from T590 (ovpn-8-26.pek2.redhat.com [10.72.8.26])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 9CF2A610DF;
        Wed, 26 Jan 2022 07:18:35 +0000 (UTC)
Date:   Wed, 26 Jan 2022 15:18:30 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Jens Axboe <axboe@kernel.dk>, Jan Kara <jack@suse.cz>,
        linux-block@vger.kernel.org
Subject: Re: [PATCH v3 1/5] task_work: export task_work_add()
Message-ID: <YfD1xo/bepV17ggx@T590>
References: <20220121114006.3633-1-penguin-kernel@I-love.SAKURA.ne.jp>
 <20220125154730.GA4611@lst.de>
 <ec15d9ef-a659-e4f0-fc3f-c75acaa0be2a@I-love.SAKURA.ne.jp>
 <20220126052159.GA20838@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220126052159.GA20838@lst.de>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Jan 26, 2022 at 06:21:59AM +0100, Christoph Hellwig wrote:
> On Wed, Jan 26, 2022 at 08:47:17AM +0900, Tetsuo Handa wrote:
> > > As far as I can tell we do not need the freeze at all for given that
> > > by the time release is called I/O is quiesced.
> > 
> > Why? lo_release() is called when close() is called. But (periodically-scheduled
> > or triggered-on-demand) writeback of previously executed buffered write() calls
> > can start while lo_release() or __loop_clr_fd() is running. Then, why not to
> > wait for I/O requests to complete?
> 
> Let's refine my wording, the above should be "... by the time the final
> lo_release is called".  blkdev_put_whole ensures all writeback has finished
> and all buffers are gone by writing all data back and waiting for it and then
> truncating the pages from blkdev_flush_mapping.
> 
> > Isn't that the reason of
> > 
> > 	} else if (lo->lo_state == Lo_bound) {
> > 		/*
> > 		 * Otherwise keep thread (if running) and config,
> > 		 * but flush possible ongoing bios in thread.
> > 		 */
> > 		blk_mq_freeze_queue(lo->lo_queue);
> > 		blk_mq_unfreeze_queue(lo->lo_queue);
> > 	}
> > 
> > path in lo_release() being there?
> 
> This looks completely spurious to me.  Adding Ming who added it.

It was added when converting to blk-mq.

I remember it was to replace original loop_flush() which uses
wait_for_completion() for draining all inflight bios, but seems
the flush isn't needed in lo_release().


Thanks,
Ming

