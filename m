Return-Path: <SRS0=n79e=BX=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38AD5C433E1
	for <linux-block@archiver.kernel.org>; Thu, 13 Aug 2020 15:43:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0F7C620829
	for <linux-block@archiver.kernel.org>; Thu, 13 Aug 2020 15:43:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726334AbgHMPno (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 13 Aug 2020 11:43:44 -0400
Received: from verein.lst.de ([213.95.11.211]:46793 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726253AbgHMPnn (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 13 Aug 2020 11:43:43 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id B397B68AFE; Thu, 13 Aug 2020 17:43:40 +0200 (CEST)
Date:   Thu, 13 Aug 2020 17:43:40 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>,
        Changpeng Liu <changpeng.liu@intel.com>,
        Daniel Verkamp <dverkamp@chromium.org>,
        "Michael S . Tsirkin" <mst@redhat.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Stefano Garzarella <sgarzare@redhat.com>
Subject: Re: [PATCH V2 2/3] block: virtio_blk: fix handling single range
 discard request
Message-ID: <20200813154340.GB14200@lst.de>
References: <20200811234420.2297137-1-ming.lei@redhat.com> <20200811234420.2297137-3-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200811234420.2297137-3-ming.lei@redhat.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Aug 12, 2020 at 07:44:19AM +0800, Ming Lei wrote:
> 1f23816b8eb8 ("virtio_blk: add discard and write zeroes support") starts
> to support multi-range discard for virtio-blk. However, the virtio-blk
> disk may report max discard segment as 1, at least that is exactly what
> qemu is doing.
> 
> So far, block layer switches to normal request merge if max discard segment
> limit is 1, and multiple bios can be merged to single segment. This way may
> cause memory corruption in virtblk_setup_discard_write_zeroes().
> 
> Fix the issue by handling single max discard segment in straightforward
> way.

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
