Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C539C433F5
	for <linux-block@archiver.kernel.org>; Mon, 25 Oct 2021 08:41:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0370960555
	for <linux-block@archiver.kernel.org>; Mon, 25 Oct 2021 08:41:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232148AbhJYIna (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 25 Oct 2021 04:43:30 -0400
Received: from verein.lst.de ([213.95.11.211]:56093 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232046AbhJYIna (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 25 Oct 2021 04:43:30 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id A463468B05; Mon, 25 Oct 2021 10:41:05 +0200 (CEST)
Date:   Mon, 25 Oct 2021 10:41:05 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Max Gurtovoy <mgurtovoy@nvidia.com>
Cc:     "Michael S. Tsirkin" <mst@redhat.com>,
        linux-kernel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@lst.de>,
        kernel test robot <lkp@intel.com>,
        Jason Wang <jasowang@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Feng Li <lifeng1519@gmail.com>,
        Israel Rukshin <israelr@nvidia.com>,
        virtualization@lists.linux-foundation.org,
        linux-block@vger.kernel.org
Subject: Re: [PATCH] virtio_blk: corrent types for status handling
Message-ID: <20211025084105.GA14544@lst.de>
References: <20211025075825.1603118-1-mst@redhat.com> <ed3bcce8-ede4-f4a3-d0a3-91662d5aae4e@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ed3bcce8-ede4-f4a3-d0a3-91662d5aae4e@nvidia.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Oct 25, 2021 at 11:24:57AM +0300, Max Gurtovoy wrote:
> Maybe we can compare the returned status to BLK_STS_OK. But I see we don't 
> do it also in NVMe subsystem so I guess we can assume BLK_STS_OK == 0 
> forever.

Jes,  BLK_STS_OK == 0 is an intentional allowed short cut.  It is not
just a block layer design, but part of how the sparse __bitwise__
annotations work.
