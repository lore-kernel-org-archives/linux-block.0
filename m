Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39FA6C43461
	for <linux-block@archiver.kernel.org>; Mon, 12 Apr 2021 09:46:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1299D611AD
	for <linux-block@archiver.kernel.org>; Mon, 12 Apr 2021 09:46:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240384AbhDLJql (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 12 Apr 2021 05:46:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243737AbhDLJmz (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 12 Apr 2021 05:42:55 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 103E6C061574;
        Mon, 12 Apr 2021 02:42:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=YS9rUfAaFraTST+vXue/0eDUYwela3jJ0Z8xBNf5UYk=; b=n7QXyakpl2KmOmEFeCivlGPDqb
        GVgsGtspChp4+CIRmPbUgA56GjXJ6t/hTQgt7VJIeu2WM/lIeU9+aBeLbWPz/PaoTdyBLORyevrp4
        MLFkLtmMQNLiFBTxB2EoYTvvd6WhDzDBDq9qxWKd0EK1fwRJkVurKRcJ2c/vz3YLz4SoWVzEKDuW0
        G/fjXsxhUUGxjXgfGF/xR//L/T2QYXqA9MX60tKreWQ3+7h7JMznbYNHAss/+jhWhulbn6f6Afkuy
        D2fwN6kgZD9MFuwwfWKL9WWms+949ZxtlqMcpy5IckEJjZuqgNw8BZIuYEanb1iocy3q/H6O+JL9F
        GwBS48nw==;
Received: from hch by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lVt5F-0047XO-Jf; Mon, 12 Apr 2021 09:42:22 +0000
Date:   Mon, 12 Apr 2021 10:42:17 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Stefan Hajnoczi <stefanha@redhat.com>
Cc:     Enrico Granata <egranata@google.com>, mst@redhat.com,
        jasowang@redhat.com, pbonzini@redhat.com, axboe@kernel.dk,
        virtualization@lists.linux-foundation.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] virtio_blk: Add support for lifetime feature
Message-ID: <20210412094217.GA981912@infradead.org>
References: <20210330231602.1223216-1-egranata@google.com>
 <YHQQL1OTOdnuOYUW@stefanha-x1.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YHQQL1OTOdnuOYUW@stefanha-x1.localdomain>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

A note to the virtio committee:  eMMC is the worst of all the currently
active storage standards by a large margin.  It defines very strange
ad-hoc interfaces that expose very specific internals and often provides
very poor abstractions.  It would be great it you could reach out to the
wider storage community before taking bad ideas from the eMMC standard
and putting it into virtio.
