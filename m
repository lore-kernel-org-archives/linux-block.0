Return-Path: <geoff@infradead.org>
Subject: Re: [PATCH 03/17] ps3disk: convert to blk-mq
To: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Geert Uytterhoeven <geert@linux-m68k.org>
References: <20181011165909.32615-1-axboe@kernel.dk>
 <20181011165909.32615-4-axboe@kernel.dk>
 <17539e5f-742b-796e-8e36-31327120f883@infradead.org>
 <ee11f577-5766-13bc-2ff5-e3d672041462@kernel.dk>
 <7f27a68f-9cbe-c4c2-5c35-70763a5b1484@infradead.org>
 <b95e3ebf-f08d-2cbf-3f82-89424d7bf60d@kernel.dk>
 <3403ae47-1aaa-9d01-817c-cd52a7daa272@infradead.org>
 <ef7c0fb3-a31f-68e3-25f6-478958c08602@kernel.dk>
From: Geoff Levand <geoff@infradead.org>
Message-ID: <6d7ccd4c-0d41-e2d3-6ecd-b9efbd7358b5@infradead.org>
Date: Mon, 15 Oct 2018 12:24:28 -0700
MIME-Version: 1.0
In-Reply-To: <ef7c0fb3-a31f-68e3-25f6-478958c08602@kernel.dk>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

Hi Jens,

On 10/15/2018 11:38 AM, Jens Axboe wrote:
> Weird, it looks like we're waiting for something to complete, and then
> we have a few others waiting for queue new IO.
> 
> Can you try and move the blk_mq_end_request() inside the priv->lock
> section and see if that helps?

With the change below to your V2 I can't get it to have an
error.  I did mkfs.ext4, some big file downloads, and ran
'fsck.ext3 -c' for a while.

Thanks for working late on it.

-Geoff

--- a/drivers/block/ps3disk.c
+++ b/drivers/block/ps3disk.c
@@ -274,10 +274,9 @@ static irqreturn_t ps3disk_interrupt(int irq, void *data)
                        ps3disk_scatter_gather(dev, req, 0);
        }
 
-       blk_mq_end_request(req, error);
-
        spin_lock(&priv->lock);
        priv->req = NULL;
+       blk_mq_end_request(req, error);
        spin_unlock(&priv->lock);
 
        blk_mq_run_hw_queues(priv->queue, true);
@@ -458,7 +457,7 @@ static int ps3disk_probe(struct ps3_system_bus_device *_dev)
        set = &priv->tag_set;
        set->ops = &ps3disk_mq_ops;
        set->nr_hw_queues = 1;
-       set->queue_depth = 2;
+       set->queue_depth = 1;
        set->numa_node = NUMA_NO_NODE;
        set->flags = BLK_MQ_F_SHOULD_MERGE;
        error = blk_mq_alloc_tag_set(set);
