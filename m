Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6903C433EF
	for <linux-block@archiver.kernel.org>; Mon, 20 Jun 2022 08:49:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238780AbiFTItK (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 20 Jun 2022 04:49:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238619AbiFTItJ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 20 Jun 2022 04:49:09 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A29DC12D05
        for <linux-block@vger.kernel.org>; Mon, 20 Jun 2022 01:49:08 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 645021F896;
        Mon, 20 Jun 2022 08:49:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1655714947; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=l13KXKTvQHINy9mBBTvynxZOwhiFpl77e969TSq85Hs=;
        b=BXA3+bIU2zvVQRmPLS91pNW/9K8+4XiZ4ns30l8aeIb6tQPjyylA49zcWEfWURbkxJR5oX
        +/1obgYcmTXvkxOS+eANgaNDaG54VZdutCo49ccpjv5RLNMKByPK23ESkgjO8dTwH2oXLB
        2navMsgmNdQlTeIY+5TM8NpWrwGxdNY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1655714947;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=l13KXKTvQHINy9mBBTvynxZOwhiFpl77e969TSq85Hs=;
        b=mm2lX81prNJ4gP4V/7+Zw1lpxls1/5hu+E8Anzy6HqfPq2ry9hYg3NPGjd1RGqzOn5Fktr
        yhz0nT26ETVpklAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 560D613638;
        Mon, 20 Jun 2022 08:49:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id e76ZFIM0sGLMLwAAMHmgww
        (envelope-from <hare@suse.de>); Mon, 20 Jun 2022 08:49:07 +0000
Message-ID: <25329ddf-73d1-70e9-cd2f-372309e509ba@suse.de>
Date:   Mon, 20 Jun 2022 10:49:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH 6/6] block: remove blk_cleanup_disk
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc:     Ming Lei <ming.lei@redhat.com>, linux-block@vger.kernel.org
References: <20220619060552.1850436-1-hch@lst.de>
 <20220619060552.1850436-7-hch@lst.de>
From:   Hannes Reinecke <hare@suse.de>
In-Reply-To: <20220619060552.1850436-7-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 6/19/22 08:05, Christoph Hellwig wrote:
> blk_cleanup_disk is nothing but a trivial wrapper for put_disk now,
> so remove it.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>   arch/m68k/emu/nfblock.c             |  4 ++--
>   arch/um/drivers/ubd_kern.c          |  4 ++--
>   arch/xtensa/platforms/iss/simdisk.c |  4 ++--
>   block/genhd.c                       | 15 ---------------
>   drivers/block/amiflop.c             |  2 +-
>   drivers/block/aoe/aoeblk.c          |  2 +-
>   drivers/block/aoe/aoedev.c          |  2 +-
>   drivers/block/ataflop.c             |  4 ++--
>   drivers/block/brd.c                 |  4 ++--
>   drivers/block/drbd/drbd_main.c      |  4 ++--
>   drivers/block/floppy.c              |  6 +++---
>   drivers/block/loop.c                |  2 +-
>   drivers/block/mtip32xx/mtip32xx.c   |  2 +-
>   drivers/block/n64cart.c             |  2 +-
>   drivers/block/nbd.c                 |  4 ++--
>   drivers/block/null_blk/main.c       |  4 ++--
>   drivers/block/paride/pcd.c          |  4 ++--
>   drivers/block/paride/pd.c           |  4 ++--
>   drivers/block/paride/pf.c           |  4 ++--
>   drivers/block/pktcdvd.c             |  4 ++--
>   drivers/block/ps3disk.c             |  4 ++--
>   drivers/block/ps3vram.c             |  4 ++--
>   drivers/block/rbd.c                 |  2 +-
>   drivers/block/rnbd/rnbd-clt.c       |  4 ++--
>   drivers/block/sunvdc.c              |  4 ++--
>   drivers/block/swim.c                |  2 +-
>   drivers/block/swim3.c               |  2 +-
>   drivers/block/sx8.c                 |  2 +-
>   drivers/block/virtio_blk.c          |  2 +-
>   drivers/block/xen-blkfront.c        |  4 ++--
>   drivers/block/z2ram.c               |  2 +-
>   drivers/block/zram/zram_drv.c       |  4 ++--
>   drivers/cdrom/gdrom.c               |  2 +-
>   drivers/md/bcache/super.c           |  2 +-
>   drivers/md/dm.c                     |  2 +-
>   drivers/md/md.c                     |  4 ++--
>   drivers/memstick/core/ms_block.c    |  2 +-
>   drivers/memstick/core/mspro_block.c |  2 +-
>   drivers/mtd/mtd_blkdevs.c           |  4 ++--
>   drivers/mtd/ubi/block.c             |  4 ++--
>   drivers/nvdimm/btt.c                |  4 ++--
>   drivers/nvdimm/pmem.c               |  4 ++--
>   drivers/nvme/host/core.c            |  2 +-
>   drivers/nvme/host/multipath.c       |  2 +-
>   drivers/s390/block/dcssblk.c        |  8 ++++----
>   drivers/s390/block/scm_blk.c        |  4 ++--
>   include/linux/blkdev.h              |  1 -
>   47 files changed, 74 insertions(+), 90 deletions(-)
> 
I wish we could have blktests for tearing down device-drivers; doing a 
regression test here will be really hard.

Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		           Kernel Storage Architect
hare@suse.de			                  +49 911 74053 688
SUSE Software Solutions Germany GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), GF: Felix Imendörffer
