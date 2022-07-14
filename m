Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AB37C433EF
	for <linux-block@archiver.kernel.org>; Thu, 14 Jul 2022 13:13:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231486AbiGNNNs (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 14 Jul 2022 09:13:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232031AbiGNNNr (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 14 Jul 2022 09:13:47 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 650A7E02B
        for <linux-block@vger.kernel.org>; Thu, 14 Jul 2022 06:13:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Tkdh1fo3lt62tldLO7CZWMBcjOkI842vSZ7LjZXm/1Q=; b=zH+wbd5x8ioLczoqDTSTNeOPB4
        +VoxJgYKvQ8ZkRgY70YQWUqNBGFQKN+WncxGZzAWS1Ms/Ser3n9C2z9wyROtFExbuKM556ZAUkgsV
        OdrkBw2lV3WABKfRUi8q7Ox6vPK0QLTVtU2YyjqA7OuexqmlGRFmSH3Ex/JsYaKDEXkVbgxr3s+Qr
        vNSetv5JXjeitgZa/SFF+ef+PQ7Olwg8B8R81t+mEubh5vD+bg5U55rkAOsDbEMqgMyf7NU1EttZD
        gj01j9+5+0wvaoAVTx5wv59VKsBNxeJAoCL3Y7tYcg24jmomYWc6B/JAP2kmKv+ylG9236YBk4jwt
        5iq4pO6A==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oByez-00EbhC-TG; Thu, 14 Jul 2022 13:13:41 +0000
Date:   Thu, 14 Jul 2022 06:13:41 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Subject: Re: [PATCH] ublk_drv: fix request queue leak
Message-ID: <YtAWhRdXrumYEsU+@infradead.org>
References: <20220714103201.131648-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220714103201.131648-1-ming.lei@redhat.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Jul 14, 2022 at 06:32:01PM +0800, Ming Lei wrote:
> However, ublk may not add disk in case of starting device failure, then
> del_gendisk() won't be called when removing ublk device, so blk_mq_exit_queue
> will not be callsed, and it can be bit hard to deal with this kind of
> merge conflict.

So base it on a tree that has everything you need.

> Turns out ublk's queue/disk use model is very similar with scsi, so switch
> to scsi's model by allocating disk and queue independently, then it can be
> quite easy to handle v5.20 merge conflict by replacing blk_cleanup_queue
> with blk_mq_destroy_queue.

Don't do that.  That thing really is a workaround for the lack of admin
queues in scsi.  Nothing newly designed should use it.  It will not
allow to optimize things and cause maintainaince burden down the road.

Please fix the lifetime problems properly.
