Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 687FDC4332F
	for <linux-block@archiver.kernel.org>; Thu,  3 Feb 2022 13:06:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350702AbiBCNG1 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 3 Feb 2022 08:06:27 -0500
Received: from verein.lst.de ([213.95.11.211]:37546 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1350696AbiBCNG0 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 3 Feb 2022 08:06:26 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id 7E93768AFE; Thu,  3 Feb 2022 14:06:22 +0100 (CET)
Date:   Thu, 3 Feb 2022 14:06:22 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Stefan Hajnoczi <stefanha@redhat.com>
Cc:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Maxim Levitsky <maximlevitsky@gmail.com>,
        Alex Dubov <oakad@yahoo.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-block@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        linux-mmc@vger.kernel.org
Subject: Re: [PATCH 2/5] virtio_blk: simplify refcounting
Message-ID: <20220203130622.GA12361@lst.de>
References: <20220202155659.107895-1-hch@lst.de> <20220202155659.107895-3-hch@lst.de> <YfudSXcT2rNh/Jhl@stefanha-x1.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YfudSXcT2rNh/Jhl@stefanha-x1.localdomain>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Feb 03, 2022 at 09:15:53AM +0000, Stefan Hajnoczi wrote:
>           /* Make sure no work handler is accessing the device. */
>           flush_work(&vblk->config_work);
>   
>           del_gendisk(vblk->disk);
>           blk_cleanup_disk(vblk->disk);
> 	          ^--- is virtblk_free_disk() called here?
>           blk_mq_free_tag_set(&vblk->tag_set);
> 	                         ^--- use after free

Yeah.  We need to split up blk_cleanup_disk again for this into
separate calls to blk_cleanup_queue and put_disk..
