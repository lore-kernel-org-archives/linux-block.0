Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4AACC76188
	for <linux-block@archiver.kernel.org>; Mon,  3 Apr 2023 15:15:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230527AbjDCPP3 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 3 Apr 2023 11:15:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232536AbjDCPP2 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 3 Apr 2023 11:15:28 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA4E82D6B
        for <linux-block@vger.kernel.org>; Mon,  3 Apr 2023 08:15:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=QFVVqjusEIvNfI/jJIUeOuNQUDBhyrjRmT3zSp6yXXA=; b=YZdj4v0wZa10lmZa9OWvGpEdqI
        ktiJhoIXUpnSP5Zab7A0mCTyioZTbMAl+X1c+ry/ei8yv5egJjEuBbClwCkt4r9KxhnfT4UmJscCC
        avG4nd5wAFEwzCl7bWS0dMP0srk7FuRB0/Nom6crduX3XI5duU9TQQEosSRv3IAVEJLfkauDyQKt1
        Sdtb4sZeh4JCN9ZcyAiRff1NS03Rc4r9LTaojVVH0P1sYh2/UWujIoylejW1F0cRlfVKXdJJJf4rX
        BSfo2EitjzJk6HUWUfkl7objlX0Nrp6HiKGR3rI8tggvK5qphFR/RsU/oudxOFAgRx70k+JrPuYSQ
        mgLH6dWA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1pjLu2-00Fkfl-1G;
        Mon, 03 Apr 2023 15:15:26 +0000
Date:   Mon, 3 Apr 2023 08:15:26 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Dmitry Fomichev <dmitry.fomichev@wdc.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Stefan Hajnoczi <stefanha@gmail.com>,
        Hannes Reinecke <hare@suse.de>,
        Sam Li <faithilikerun@gmail.com>,
        virtio-dev@lists.oasis-open.org,
        virtualization@lists.linux-foundation.org
Subject: Re: [PATCH v2 1/2] virtio-blk: migrate to the latest patchset version
Message-ID: <ZCrtjrYQHnppV8gN@infradead.org>
References: <20230330214953.1088216-1-dmitry.fomichev@wdc.com>
 <20230330214953.1088216-2-dmitry.fomichev@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230330214953.1088216-2-dmitry.fomichev@wdc.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

What is "migrate to the latest patchset version" even supposed to mean?

I don't think that belongs into a kernel commit description.
