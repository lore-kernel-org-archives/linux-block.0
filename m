Return-Path: <SRS0=PBJN=RB=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04CD7C43381
	for <linux-block@archiver.kernel.org>; Tue, 26 Feb 2019 15:32:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C4B5720C01
	for <linux-block@archiver.kernel.org>; Tue, 26 Feb 2019 15:32:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b="Cwuh9Bn4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727036AbfBZPak (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 26 Feb 2019 10:30:40 -0500
Received: from a9-36.smtp-out.amazonses.com ([54.240.9.36]:35466 "EHLO
        a9-36.smtp-out.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726539AbfBZPak (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 26 Feb 2019 10:30:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=ug7nbtf4gccmlpwj322ax3p6ow6yfsug; d=amazonses.com; t=1551195039;
        h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:MIME-Version:Content-Type:Feedback-ID;
        bh=77D7T9rT28LezgnI2F/Twf1vqeCxGWnkTDI0cd2LU9M=;
        b=Cwuh9Bn4YOPwc2G8avlvb5V/KpMzxNjiYRZ1hYABExxhazCjWYiVSX+UHzSMKyQ1
        t4e4Rr+n3WKwVxJi9PsH29vdbsKLRAUAnjunUVA1v1G7OIP8hdgR4+hy6PyNLlxPkg4
        oj7KrZdC1aWUP08xzNIwp4HY7tQ1ugjnmcis6dNI=
Date:   Tue, 26 Feb 2019 15:30:39 +0000
From:   Christopher Lameter <cl@linux.com>
X-X-Sender: cl@nuc-kabylake
To:     Ming Lei <ming.lei@redhat.com>
cc:     Matthew Wilcox <willy@infradead.org>,
        Ming Lei <tom.leiming@gmail.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Dave Chinner <david@fromorbit.com>,
        "Darrick J . Wong" <darrick.wong@oracle.com>,
        "open list:XFS FILESYSTEM" <linux-xfs@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Dave Chinner <dchinner@redhat.com>,
        Christoph Hellwig <hch@lst.de>,
        Alexander Duyck <alexander.h.duyck@linux.intel.com>,
        Aaron Lu <aaron.lu@intel.com>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>,
        linux-block <linux-block@vger.kernel.org>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>
Subject: Re: [PATCH] xfs: allocate sector sized IO buffer via
 page_frag_alloc
In-Reply-To: <20190226134247.GA30942@ming.t460p>
Message-ID: <010001692a6de63c-e2304a50-263c-49c5-a9fd-675cfb7094f5-000000@email.amazonses.com>
References: <20190226022249.GA17747@ming.t460p> <20190226030214.GI23020@dastard> <20190226032737.GA11592@bombadil.infradead.org> <20190226045826.GJ23020@dastard> <20190226093302.GA24879@ming.t460p> <a641feb8-ceb2-2dac-27aa-7b1df10f5ae5@suse.cz>
 <CACVXFVMX=WpTRBbDTSibfXkTZxckk3ootetbE+rkJtHhsZkRAw@mail.gmail.com> <20190226121209.GC11592@bombadil.infradead.org> <20190226123545.GA6163@ming.t460p> <20190226130230.GD11592@bombadil.infradead.org> <20190226134247.GA30942@ming.t460p>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-SES-Outgoing: 2019.02.26-54.240.9.36
Feedback-ID: 1.us-east-1.fQZZZ0Xtj2+TD7V5apTT/NrT6QKuPgzCT/IC7XYgDKI=:AmazonSES
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, 26 Feb 2019, Ming Lei wrote:

> Then something like the following patch should work for all fs, could
> anyone comment on this approach?

Note that various subsystems have similar implementations. Have a look at

drivers/dma/dmaengine.c

struct dmaengine_unmap_pool {
        struct kmem_cache *cache;
        const char *name;
        mempool_t *pool;
        size_t size;
};

#define __UNMAP_POOL(x) { .size = x, .name = "dmaengine-unmap-"
__stringify(x) }
static struct dmaengine_unmap_pool unmap_pool[] = {
        __UNMAP_POOL(2),
        #if IS_ENABLED(CONFIG_DMA_ENGINE_RAID)
        __UNMAP_POOL(16),
        __UNMAP_POOL(128),
        __UNMAP_POOL(256),
        #endif
};

Or drivers/md/dm-bufio.c:

struct dm_bufio_client {
        struct mutex lock;

        struct list_head lru[LIST_SIZE];
        unsigned long n_buffers[LIST_SIZE];

        struct block_device *bdev;
        unsigned block_size;
        s8 sectors_per_block_bits;
        void (*alloc_callback)(struct dm_buffer *);
        void (*write_callback)(struct dm_buffer *);

        struct kmem_cache *slab_buffer;
        struct kmem_cache *slab_cache;
        struct dm_io_client *dm_io;

        struct list_head reserved_buffers;
        unsigned need_reserved_buffers;

        unsigned minimum_buffers;

        struct rb_root buffer_tree;
        wait_queue_head_t free_buffer_wait;

        sector_t start;

        int async_write_error;

        struct list_head client_list;
        struct shrinker shrinker;
};
