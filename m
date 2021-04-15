Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A567C433B4
	for <linux-block@archiver.kernel.org>; Thu, 15 Apr 2021 15:55:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0CE9C610EA
	for <linux-block@archiver.kernel.org>; Thu, 15 Apr 2021 15:55:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234157AbhDOP4E (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 15 Apr 2021 11:56:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234189AbhDOPz6 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 15 Apr 2021 11:55:58 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A8B0C06175F;
        Thu, 15 Apr 2021 08:55:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=mR6aTb9tMsehQ85JfxDLTFgtEG2ZF6gM+5hV07mju9w=; b=bB7Vy1Zyuc+VF+CnYkm3CktkTa
        /MfZtVhQNhvG9xlaabU2om/GEmDpDPqvpyS/dE0XsPBxvZbyb/wHnRJOAZTsUyQXV5lNuJ5B6lTSU
        9IBPI/4vphuH6cA2gG7PbA3UUNLGfeGboW3361tNpnY/tKjFpHtmAY4WrSJNJOTmM467Wwc35V9Zs
        w/sluGzUJ4YON/DZmCISR96XZsXL//cnLlMSh10oyYkemM5Oe2ZXEVYnbQqlyEQYrkknpQnAon4Am
        A4WdMGFtfMBJpUjjQEXXi3uLEeh+yV81Yj2u9W1YIt8tjBq2dikKGaqmtG96v2OeMB7Oc00j3K5WQ
        ycVjsp9w==;
Received: from hch by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lX4Jn-008m2a-62; Thu, 15 Apr 2021 15:54:23 +0000
Date:   Thu, 15 Apr 2021 16:54:11 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Enrico Granata <egranata@google.com>, jasowang@redhat.com,
        pbonzini@redhat.com, axboe@kernel.dk,
        virtualization@lists.linux-foundation.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] virtio_blk: Add support for lifetime feature
Message-ID: <20210415155411.GA2090820@infradead.org>
References: <20210330231602.1223216-1-egranata@google.com>
 <YHQQL1OTOdnuOYUW@stefanha-x1.localdomain>
 <20210412094217.GA981912@infradead.org>
 <20210412074309-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210412074309-mutt-send-email-mst@kernel.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Apr 12, 2021 at 08:00:24AM -0400, Michael S. Tsirkin wrote:
> On Mon, Apr 12, 2021 at 10:42:17AM +0100, Christoph Hellwig wrote:
> > A note to the virtio committee:  eMMC is the worst of all the currently
> > active storage standards by a large margin.  It defines very strange
> > ad-hoc interfaces that expose very specific internals and often provides
> > very poor abstractions.
> 
> Are we talking about the lifetime feature here?  UFS has it too right?

Ok, the wide margin above ignores UFS, which has a lot of the same
issues as EMMC, just a little less cruft.

> It's not too late to
> change things if necessary... it would be great if you could provide
> more of the feedback on this on the TC mailing list.

I think the big main issue here is that it just forwards an awkwardly
specific concept through virtio.  If we want a virtio feature it really
needs to stand a lone and be properly documented without referring to
external specifications that are not openly available.

> > It would be great it you could reach out to the
> > wider storage community before taking bad ideas from the eMMC standard
> > and putting it into virtio.
> 
> Noted.  It would be great if we had more representation from the storage
> community ... meanwhile what would a good forum for this be?
> linux-block@vger.kernel.org ?

At least for linux, yes.
