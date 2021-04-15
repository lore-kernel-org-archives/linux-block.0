Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0873C43460
	for <linux-block@archiver.kernel.org>; Thu, 15 Apr 2021 15:58:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9DE29611AB
	for <linux-block@archiver.kernel.org>; Thu, 15 Apr 2021 15:58:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234140AbhDOP6y (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 15 Apr 2021 11:58:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233835AbhDOP6x (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 15 Apr 2021 11:58:53 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFE80C061574;
        Thu, 15 Apr 2021 08:58:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Dcyz1074VpfC9/KG5fq4BgAjL98SX176tM5LVJKoiEc=; b=eN1BGaWmf8M9ZQhalJDr8k4uBz
        qL5onMzPFL/UYAEKhXJ1yTNpTLRi3rqmwcm8wQXQzCgkmMRXP7OFVbqDrX36e13UPqqHd0N1CtFGW
        4B47pGNNLyu060o1hR/Wacu81EEdvkI+HtZgsmjPOZZmNlx4GPOLjAMDZpX/eGrMtQv5Y1SNvfB5a
        o4PWxPWSgRj8NStUEai59hgNzLmy96BzX+isomGvWv7PGPdgms+yqKwDXYIdwdiewNpPrN5nY6zV8
        LudCeRZOFKT2/IUzv+bclFEVBfqRzfixM8ggc8xf2R2QsU3zWuJ0wWFQA23hSUFcdh8M0ALSplwWN
        lrRONqSQ==;
Received: from hch by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lX4NL-008mEB-Fz; Thu, 15 Apr 2021 15:57:54 +0000
Date:   Thu, 15 Apr 2021 16:57:51 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Stefan Hajnoczi <stefanha@redhat.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Enrico Granata <egranata@google.com>, mst@redhat.com,
        jasowang@redhat.com, pbonzini@redhat.com, axboe@kernel.dk,
        virtualization@lists.linux-foundation.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] virtio_blk: Add support for lifetime feature
Message-ID: <20210415155751.GB2090820@infradead.org>
References: <20210330231602.1223216-1-egranata@google.com>
 <YHQQL1OTOdnuOYUW@stefanha-x1.localdomain>
 <20210412094217.GA981912@infradead.org>
 <YHarc5gGgjyQOaA+@stefanha-x1.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YHarc5gGgjyQOaA+@stefanha-x1.localdomain>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Apr 14, 2021 at 09:44:35AM +0100, Stefan Hajnoczi wrote:
> On Mon, Apr 12, 2021 at 10:42:17AM +0100, Christoph Hellwig wrote:
> > A note to the virtio committee:  eMMC is the worst of all the currently
> > active storage standards by a large margin.  It defines very strange
> > ad-hoc interfaces that expose very specific internals and often provides
> > very poor abstractions.  It would be great it you could reach out to the
> > wider storage community before taking bad ideas from the eMMC standard
> > and putting it into virtio.
> 
> As Michael mentioned, there is still time to change the virtio-blk spec
> since this feature hasn't been released yet.
> 
> Why exactly is exposing eMMC-style lifetime information problematic?
> 
> Can you and Enrico discuss the use case to figure out an alternative
> interface?

Mostly because it exposed a very awkward encoding that is not actually
documented in any publically available spec.

If you want to incorporate a more open definition doing something
like the NVMe 'Endurance Estimate' and 'Percentage Used' fields.  But
the most important thing is to fully document the semantics in the
virtio document instead of refercing a closed standard.
