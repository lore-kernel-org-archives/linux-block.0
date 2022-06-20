Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57AC6C433EF
	for <linux-block@archiver.kernel.org>; Mon, 20 Jun 2022 08:47:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238807AbiFTIry (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 20 Jun 2022 04:47:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239997AbiFTIrx (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 20 Jun 2022 04:47:53 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A99D4334
        for <linux-block@vger.kernel.org>; Mon, 20 Jun 2022 01:47:51 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 6A4B221B99;
        Mon, 20 Jun 2022 08:47:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1655714870; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Rl3lhg7v5a6y/hVUwNhfWfwO5NFMqFA+CuoH2uR12Ko=;
        b=wjwJUk/xYB8w6G2+U4BrOTEXtVN9cuHxv6YQZ8WAtDV/l2/Rmm8iEZPRC6oqYgsOPhhmdb
        AACIFNWbWzWg8DyY5ny5LeXXHxLQSqzxBOIEdtKhKrsV1TL3f0aQe5v0/hc3/1iNzSysoc
        gSWs5w04NaHjTYNEPEslzHRf9WDQ/38=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1655714870;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Rl3lhg7v5a6y/hVUwNhfWfwO5NFMqFA+CuoH2uR12Ko=;
        b=6OgeFLY7jgnmXci+wTGU7kQ9p+3ubc8rWYgqgJ1b5wtiuiBLF2JNzstPQQbx34UT+nyFEE
        pIu3icawI4SdeoBg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 5EB9E13638;
        Mon, 20 Jun 2022 08:47:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id FNDbFjY0sGL7LgAAMHmgww
        (envelope-from <hare@suse.de>); Mon, 20 Jun 2022 08:47:50 +0000
Message-ID: <3701cdcd-6fc2-4125-333d-51aaf4c80348@suse.de>
Date:   Mon, 20 Jun 2022 10:47:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc:     Ming Lei <ming.lei@redhat.com>, linux-block@vger.kernel.org
References: <20220619060552.1850436-1-hch@lst.de>
 <20220619060552.1850436-6-hch@lst.de>
From:   Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH 5/6] block: simplify disk shutdown
In-Reply-To: <20220619060552.1850436-6-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 6/19/22 08:05, Christoph Hellwig wrote:
> Set the queue dying flag and call blk_mq_exit_queue from del_gendisk for
> all disks that do not have separately allocated queues, and thus remove
> the need to call blk_cleanup_queue for them.
> 
> Rename blk_cleanup_disk to blk_mq_destroy_queue to make it clear that
> this function is intended only for separately allocated blk-mq queues.
> 
> This saves an extra queue freeze for devices without a separately
> allocated queue.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>   block/blk-core.c                    | 37 -------------------------
>   block/blk-mq.c                      | 43 +++++++++++++++++++++++++++--
>   block/blk-sysfs.c                   |  5 ----
>   block/blk.h                         |  3 ++
>   block/bsg-lib.c                     |  4 +--
>   block/genhd.c                       | 23 ++++++++-------
>   drivers/block/ataflop.c             |  1 -
>   drivers/block/loop.c                |  1 -
>   drivers/block/mtip32xx/mtip32xx.c   |  2 --
>   drivers/block/rnbd/rnbd-clt.c       |  2 +-
>   drivers/block/sx8.c                 |  4 +--
>   drivers/block/virtio_blk.c          |  1 -
>   drivers/block/z2ram.c               |  1 -
>   drivers/cdrom/gdrom.c               |  1 -
>   drivers/memstick/core/ms_block.c    |  1 -
>   drivers/memstick/core/mspro_block.c |  1 -
>   drivers/mmc/core/block.c            |  1 -
>   drivers/mmc/core/queue.c            |  1 -
>   drivers/nvme/host/apple.c           |  2 +-
>   drivers/nvme/host/core.c            |  1 -
>   drivers/nvme/host/fc.c              | 12 ++++----
>   drivers/nvme/host/pci.c             |  2 +-
>   drivers/nvme/host/rdma.c            | 12 ++++----
>   drivers/nvme/host/tcp.c             | 12 ++++----
>   drivers/nvme/target/loop.c          | 12 ++++----
>   drivers/s390/block/dasd.c           |  2 +-
>   drivers/s390/block/dasd_genhd.c     |  4 +--
>   drivers/scsi/scsi_lib.c             |  6 ++--
>   drivers/scsi/scsi_sysfs.c           |  2 +-
>   drivers/scsi/sd.c                   |  4 +--
>   drivers/scsi/sr.c                   |  4 +--
>   drivers/ufs/core/ufshcd.c           |  4 +--
>   include/linux/blk-mq.h              |  3 ++
>   include/linux/blkdev.h              |  4 +--
>   34 files changed, 105 insertions(+), 113 deletions(-)
> 
(This will come back to haunt me once I have to do a backport ...)
(But anyway.)

Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		           Kernel Storage Architect
hare@suse.de			                  +49 911 74053 688
SUSE Software Solutions Germany GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), GF: Felix Imendörffer
