Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B984C678D4
	for <linux-block@archiver.kernel.org>; Tue, 17 Jan 2023 06:05:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235615AbjAQGFK (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 17 Jan 2023 01:05:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235612AbjAQGFH (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 17 Jan 2023 01:05:07 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F7A91F92D;
        Mon, 16 Jan 2023 22:05:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=i95Bj8Tr9xoekMAaCSBax6WW3QQZv9faY/6wdPnW11s=; b=Smxr3cdFUm9ViiON7uzeg4qGsE
        BdfsUYfz3/shimYz3oS8mWvTEJhlNzv+h24NFO+Cz/ytdgRQjE9E9K0gFSAs1FnmnjTp/l9dV1T31
        2R75ugt6CBbP5+bJ7Fh/5EpXTTFH1yNzqmgc/HEPIgw44wlmwfMg9WiCK6msTORG/nOuq8V8fEUn/
        xZKt7zPfODx9iZjMNs0daJWmW2WKh+M14X81BF1Y8q5EvMPuPLCARQYYCSLvmjD/fyw3ZvEpqB0u2
        hqoxanDurkJH+yxesKMWLhLw43wRWUGvq0IFJ1ZQSC4+pKHzkycYN2ASc7KE5WnvWaQfaCXok+PUk
        PLStB4gA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pHf5g-00D26l-Ai; Tue, 17 Jan 2023 06:05:00 +0000
Date:   Mon, 16 Jan 2023 22:05:00 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Fabio Fantoni <fantonifabio@tiscali.it>
Cc:     Christoph Hellwig <hch@infradead.org>, corbet@lwn.net,
        axboe@kernel.dk, linux-block@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sergei Shtepa <sergei.shtepa@veeam.com>
Subject: Re: [PATCH v2] documentation: fix Generic Block Device Capability
Message-ID: <Y8Y6jLdXnnBTps7l@infradead.org>
References: <20230110132104.12499-1-fantonifabio@tiscali.it>
 <Y8WPFMFxpfdZKs5a@infradead.org>
 <62a18c7d-93d9-657e-48fd-1af06d6d1d9e@tiscali.it>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <62a18c7d-93d9-657e-48fd-1af06d6d1d9e@tiscali.it>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Jan 16, 2023 at 07:14:41PM +0100, Fabio Fantoni wrote:
> Il 16/01/2023 18:53, Christoph Hellwig ha scritto:
> > On Tue, Jan 10, 2023 at 02:21:04PM +0100, Fabio Fantoni wrote:
> > > - * ``GENHD_FL_REMOVABLE``: indicates that the block device gives access to
> > > + * ``GENHD_FL_REMOVABLE`` (0x01): indicates that the block device gives access to
> > The numberic values really do not belong into the documentation.  They
> > are just implementation details.
> > 
> Thanks for reply, if values are not into the documentation see from
> /sys/block/<disk>/capability output what flags are enabled will require look
> to source code of include/linux/blkdev.h and
> Documentation/block/capability.rst will be less useful, or I'm wrong?

Urgg.  I think this file is generally just a bad idea.  The flags are
kernel internal and not isolated from userspace.  It seems nothing broke
with the various renumbering lately, but we need to isolate it from
the implementation details.  And if it really should be a user API
we need a text version of it.
