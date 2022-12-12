Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F3B4C4332F
	for <linux-block@archiver.kernel.org>; Mon, 12 Dec 2022 06:50:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231302AbiLLGuR (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 12 Dec 2022 01:50:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230105AbiLLGuP (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 12 Dec 2022 01:50:15 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4141E101
        for <linux-block@vger.kernel.org>; Sun, 11 Dec 2022 22:50:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=jp5hbDSEuCBBxqq4FtmbnUPgBzjkN+ii+Vc35aDpJGY=; b=WFvwE5prADrPvSFSuGK2hKbfO8
        J+iv5hu2r3a/D/ON0ps4jGYvgUCy03PwQVE7tOHvIkCOoHVRH0voE38GdQS6VRzV/MbX/0M1Rsb4M
        9f6IjVrGNrhxYY1piQFv8kYaqiO63+WfAfIVRfiKtc8nJVYMNBjfWndFc3iCt5cZCL+XaerSKXCob
        KbNC+8ZgQ0FNai+DbKU5gMp1iA5LTw/pyBbyQAfGqrrMPiLDkPMNanpjQzgFr6b9CfON/PzZhuTBL
        yL/B51icQLs2SGlSe1tAdsnCdvgj+OQGcEwg/Vi8GpPrI6CjryYcmwPk1njPJCuUAyB9+mem/2YhI
        jZZ+5+IA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1p4cdX-0092UC-QX; Mon, 12 Dec 2022 06:50:04 +0000
Date:   Sun, 11 Dec 2022 22:50:03 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Stefan Hajnoczi <stefanha@redhat.com>, mst@redhat.com,
        jasowang@redhat.com, pbonzini@redhat.com, hch@infradead.org,
        virtualization@lists.linux-foundation.org,
        linux-block@vger.kernel.org, Suwan Kim <suwan.kim027@gmail.com>
Subject: Re: [PATCH 1/2] virtio-blk: set req->state to MQ_RQ_COMPLETE after
 polling I/O is finished
Message-ID: <Y5bPG9QGMd/cDTQG@infradead.org>
References: <20221206141125.93055-1-suwan.kim027@gmail.com>
 <Y5EJ+6qtsy8Twe/q@fedora>
 <4701aded-0464-791e-8b8c-a34c422e8e62@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4701aded-0464-791e-8b8c-a34c422e8e62@kernel.dk>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Dec 08, 2022 at 09:48:23AM -0700, Jens Axboe wrote:
> > The doc comment for blk_mq_set_request_complete() mentions this being
> > used in ->queue_rq(), but that's not the case here. Does the doc comment
> > need to be updated if we're using the function in a different way?
> 
> Looks like it's a bit outdated...

I think the comment is still entirely correct.

> 
> > I'm not familiar enough with the Linux block APIs, but this feels weird
> > to me. Shouldn't blk_mq_end_request_batch(iob) take care of this for us?
> > Why does it set the state to IDLE instead of COMPLETE?
> > 
> > I think Jens can confirm whether we really want all drivers that use
> > polling and io_comp_batch to manually call
> > blk_mq_set_request_complete().
> 
> Should not be a need to call blk_mq_set_request_complete() directly in
> the driver for this.

Exactly.  Polling or not, drivers should go through the normal completion
interface, that is blk_mq_complete_request or the lower-level options
blk_mq_complete_request_remote and blk_mq_complete_request_direct.
