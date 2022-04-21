Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FA6EC433EF
	for <linux-block@archiver.kernel.org>; Thu, 21 Apr 2022 17:28:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352159AbiDURbO (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 21 Apr 2022 13:31:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230494AbiDURbN (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 21 Apr 2022 13:31:13 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58228443CB
        for <linux-block@vger.kernel.org>; Thu, 21 Apr 2022 10:28:23 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 13D3E210EC;
        Thu, 21 Apr 2022 17:28:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1650562102; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=agKVtioJLKI2qUa/KoERjVbGb4D5gFa5rE+wElYBhRg=;
        b=RpXfHORjTNWrAUeYtmapsmHjtlud+0qluHkqoUOrnVUbKVx/3xIyImTeCTfHEiYd/iBLEk
        Kvem9VSedFv30/7hmNVy7aLQXBhExCB5NywxmmqfSnAcRZSlll8Josd0js8t++nAhpU2B2
        jIf8nVXGL7qtYoKH0VZ857RvJuqbzQQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1650562102;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=agKVtioJLKI2qUa/KoERjVbGb4D5gFa5rE+wElYBhRg=;
        b=jG+HpYNtnDELLZQ/MaUMO5GsjielY/fiLyRgex17HOrUaZD4XMVEYd15g13rrPcOtwN+FZ
        w/AJg4VCHTjQVeDA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id E1D1A13A84;
        Thu, 21 Apr 2022 17:28:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 4Wm1NTWUYWKmDQAAMHmgww
        (envelope-from <hare@suse.de>); Thu, 21 Apr 2022 17:28:21 +0000
Message-ID: <54eea05d-bd3a-22ca-eab0-0bb493631f6c@suse.de>
Date:   Thu, 21 Apr 2022 19:28:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH] block: fix "Directory XXXXX with parent 'block' already
 present!"
Content-Language: en-US
To:     Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org,
        Dan Williams <dan.j.williams@intel.com>,
        yukuai <yukuai3@huawei.com>,
        Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
References: <20220421083431.2917311-1-ming.lei@redhat.com>
From:   Hannes Reinecke <hare@suse.de>
In-Reply-To: <20220421083431.2917311-1-ming.lei@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 4/21/22 10:34, Ming Lei wrote:
> q->debugfs_dir is used by blk-mq debugfs and blktrace. The dentry is
> created when adding disk, and removed when releasing request queue.
> 
> There is small window between releasing disk and releasing request
> queue, and during the period, one disk with same name may be created
> and added, so debugfs_create_dir() may complain with "Directory XXXXX
> with parent 'block' already present!"
> 
> Fixes the issue by moving debugfs_create_dir() into blk_alloc_queue(),
> and the dir name is named with q->id from beginning, and switched to
> disk name when adding disk, and finally changed to q->id in disk_release().
> 
> Reported-by: Dan Williams <dan.j.williams@intel.com>
> Cc: yukuai (C) <yukuai3@huawei.com>
> Cc: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
> Signed-off-by: Ming Lei <ming.lei@redhat.com>
> ---
>   block/blk-core.c  | 4 ++++
>   block/blk-sysfs.c | 4 ++--
>   block/genhd.c     | 8 ++++++++
>   3 files changed, 14 insertions(+), 2 deletions(-)
> 
> diff --git a/block/blk-core.c b/block/blk-core.c
> index f305cb66c72a..245ec664753d 100644
> --- a/block/blk-core.c
> +++ b/block/blk-core.c
> @@ -438,6 +438,7 @@ struct request_queue *blk_alloc_queue(int node_id, bool alloc_srcu)
>   {
>   	struct request_queue *q;
>   	int ret;
> +	char q_name[16];
>   
>   	q = kmem_cache_alloc_node(blk_get_queue_kmem_cache(alloc_srcu),
>   			GFP_KERNEL | __GFP_ZERO, node_id);
> @@ -495,6 +496,9 @@ struct request_queue *blk_alloc_queue(int node_id, bool alloc_srcu)
>   	blk_set_default_limits(&q->limits);
>   	q->nr_requests = BLKDEV_DEFAULT_RQ;
>   
> +	sprintf(q_name, "%d", q->id);
> +	q->debugfs_dir = debugfs_create_dir(q_name, blk_debugfs_root);
> +
>   	return q;
>   
>   fail_stats:
> diff --git a/block/blk-sysfs.c b/block/blk-sysfs.c
> index 88bd41d4cb59..1f986c20a07b 100644
> --- a/block/blk-sysfs.c
> +++ b/block/blk-sysfs.c
> @@ -837,8 +837,8 @@ int blk_register_queue(struct gendisk *disk)
>   	}
>   
>   	mutex_lock(&q->debugfs_mutex);
> -	q->debugfs_dir = debugfs_create_dir(kobject_name(q->kobj.parent),
> -					    blk_debugfs_root);
> +	q->debugfs_dir = debugfs_rename(blk_debugfs_root, q->debugfs_dir,
> +			blk_debugfs_root, kobject_name(q->kobj.parent));
>   	mutex_unlock(&q->debugfs_mutex);
>   
>   	if (queue_is_mq(q)) {
> diff --git a/block/genhd.c b/block/genhd.c
> index 36532b931841..08895f9f7087 100644
> --- a/block/genhd.c
> +++ b/block/genhd.c
> @@ -25,6 +25,7 @@
>   #include <linux/pm_runtime.h>
>   #include <linux/badblocks.h>
>   #include <linux/part_stat.h>
> +#include <linux/debugfs.h>
>   #include "blk-throttle.h"
>   
>   #include "blk.h"
> @@ -1160,6 +1161,7 @@ static void disk_release_mq(struct request_queue *q)
>   static void disk_release(struct device *dev)
>   {
>   	struct gendisk *disk = dev_to_disk(dev);
> +	char q_name[16];
>   
>   	might_sleep();
>   	WARN_ON_ONCE(disk_live(disk));
> @@ -1173,6 +1175,12 @@ static void disk_release(struct device *dev)
>   	kfree(disk->random);
>   	xa_destroy(&disk->part_tbl);
>   
> +	mutex_lock(&disk->queue->debugfs_mutex);
> +	sprintf(q_name, "%d", disk->queue->id);
> +	disk->queue->debugfs_dir = debugfs_rename(blk_debugfs_root,
> +			disk->queue->debugfs_dir, blk_debugfs_root, q_name);
> +	mutex_unlock(&disk->queue->debugfs_mutex);
> +
>   	disk->queue->disk = NULL;
>   	blk_put_queue(disk->queue);
>   

I don't think this is the right approach.
 From my POV the underlying reason is an imbalance between 
debugfs_create_dir() (which happens in blk_register_queue()) and
debugfs_remove_dir() (which happens in blk_release_queue())

So there is a small race window between blk_unregister_queue() and 
blk_release_queue(), during which the queue might be re-registered and 
then traipses over the (still-existant) queue.

So we should rather move the call to debugfs_remove_dir() into 
blk_unregister_queue() to have them both symmetric.

Basically the patch '[PATCH RESEND] blk-mq: fix possible creation 
failure for 'debugfs_dir'' from yukuai ...

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Felix Imendörffer
