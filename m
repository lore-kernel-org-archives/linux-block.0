Return-Path: <SRS0=6FHI=5E=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3ADDDC4332E
	for <linux-block@archiver.kernel.org>; Thu, 19 Mar 2020 10:31:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C4EC20740
	for <linux-block@archiver.kernel.org>; Thu, 19 Mar 2020 10:31:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="VJ7fyQtf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726967AbgCSKbk (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 19 Mar 2020 06:31:40 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:37248 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726589AbgCSKbk (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 19 Mar 2020 06:31:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=2NIRlggA6V5s7w/WatEzDWyK07/fYQbMifNENgCvD98=; b=VJ7fyQtfafU7YlitY/lnQtYhZm
        8QKZEcEsUlb/NpY9D+Poj13QQghczXHmgNZni4JWn+ojqKt11KvhHbKpggZu8wISwxp/zbR2ZTEXI
        e0KVRiEotzoPpbrDbwE/lyrJAwhZKC80H+Wcbv2yf1nRhqulIrAqH2Ux5bxLxM9/yhqJ8/4N4NIH9
        fdBVi7z+rJ/gQd2WhlP9CqB64Cwn48axHfvakGceu2JLXjgfM+QYKgJ345ZrNRrTaHHU0psl1sHap
        eFSydR3r3hRXkDvU7vE7EF+EpWzB3aBcyd+x1jrhPRQZ1ujyTHfkvSQcmrMkl8sbJ3LYbGiuvXfnl
        eJ/dt6nQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jEsSh-000197-9D; Thu, 19 Mar 2020 10:31:39 +0000
Date:   Thu, 19 Mar 2020 03:31:39 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Ram Muthiah <rammuthiah@google.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@android.com
Subject: Re: [PATCH] Inline contents of BLK_MQ_VIRTIO config
Message-ID: <20200319103139.GA30601@infradead.org>
References: <20200311235653.141701-1-rammuthiah@google.com>
 <20200312082427.GA32229@infradead.org>
 <CA+CXyWsw1VGMvETx8Qb=x7PjTsRR5XATbnHkfht1jij54SO75A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+CXyWsw1VGMvETx8Qb=x7PjTsRR5XATbnHkfht1jij54SO75A@mail.gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Mar 13, 2020 at 01:50:01PM -0700, Ram Muthiah wrote:
> The config here, blk_mq_virtio, is needed for virtio-blk but it is
> binary. blk-mq-virtio cannot be built into this generic kernel in the
> interest of keeping all virtio related configs as modules. (This
> compromise is needed to enable all physical devices to run this
> generic kernel.)

But that is your personal problem and doesn't otherwise matter.  Stop
having stupid policies based on stupid promises and your will be much
easier.

> To fix this problem,

It is not in any meaningful way a problem.  Stop creating problems where
none actually exist.
