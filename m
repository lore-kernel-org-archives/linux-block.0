Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:43285 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751235AbdCHIn6 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 8 Mar 2017 03:43:58 -0500
Subject: Re: [PATCH] zram: set physical queue limits to avoid array out of
 bounds accesses
To: Minchan Kim <minchan@kernel.org>
References: <20170306102335.9180-1-jthumshirn@suse.de>
 <20170307052242.GA29458@bbox> <95c31a93-32cd-ad06-6cc0-e11b42ec2f68@suse.de>
 <CAEwNFnAb4x+sm6=vWd1W4Xj7Snp1V_LtRRx9ORFKpm1b-58kyw@mail.gmail.com>
 <ed4d83a1-9bdd-9e24-7768-ba5e85429110@suse.de> <20170307085545.GA538@bbox>
 <10a2335c-0ed0-43de-1cbd-625845301aef@suse.de> <20170308051118.GA11206@bbox>
Cc: Hannes Reinecke <hare@suse.de>, Jens Axboe <axboe@fb.com>,
        Nitin Gupta <ngupta@vflare.org>,
        Christoph Hellwig <hch@lst.de>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        yizhan@redhat.com,
        Linux Block Layer Mailinglist <linux-block@vger.kernel.org>,
        Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>
From: Johannes Thumshirn <jthumshirn@suse.de>
Message-ID: <1073055f-e71b-bb07-389a-53b60ccdee20@suse.de>
Date: Wed, 8 Mar 2017 08:58:02 +0100
MIME-Version: 1.0
In-Reply-To: <20170308051118.GA11206@bbox>
Content-Type: text/plain; charset=windows-1252
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On 03/08/2017 06:11 AM, Minchan Kim wrote:
> And could you test this patch? It avoids split bio so no need new bio
> allocations and makes zram code simple.
> 
> From f778d7564d5cd772f25bb181329362c29548a257 Mon Sep 17 00:00:00 2001
> From: Minchan Kim <minchan@kernel.org>
> Date: Wed, 8 Mar 2017 13:35:29 +0900
> Subject: [PATCH] fix
> 
> Not-yet-Signed-off-by: Minchan Kim <minchan@kernel.org>
> ---

[...]

Yup, this works here.

I did a mkfs.xfs /dev/nvme0n1
dd if=/dev/urandom of=/test.bin bs=1M count=128
sha256sum test.bin
mount /dev/nvme0n1 /dir
mv test.bin /dir/
sha256sum /dir/test.bin

No panics and sha256sum of the 128MB test file still matches

Tested-by: Johannes Thumshirn <jthumshirn@suse.de>
Reviewed-by: Johannes Thumshirn <jthumshirn@suse.de>

Now that you removed the one page limit in zram_bvec_rw() you can also
add this hunk to remove the queue splitting:

diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index 85f4df8..27b168f6 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -868,8 +868,6 @@ static blk_qc_t zram_make_request(struct
request_queue *queue, struct bio *bio)
 {
        struct zram *zram = queue->queuedata;

-       blk_queue_split(queue, &bio, queue->bio_split);
-
        if (!valid_io_request(zram, bio->bi_iter.bi_sector,
                                        bio->bi_iter.bi_size)) {
                atomic64_inc(&zram->stats.invalid_io);

Byte,
	Johannes

-- 
Johannes Thumshirn                                          Storage
jthumshirn@suse.de                                +49 911 74053 689
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N�rnberg
GF: Felix Imend�rffer, Jane Smithard, Graham Norton
HRB 21284 (AG N�rnberg)
Key fingerprint = EC38 9CAB C2C4 F25D 8600 D0D0 0393 969D 2D76 0850
