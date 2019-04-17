Return-Path: <SRS0=3KWi=ST=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09325C282DC
	for <linux-block@archiver.kernel.org>; Wed, 17 Apr 2019 17:22:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE14820821
	for <linux-block@archiver.kernel.org>; Wed, 17 Apr 2019 17:22:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="GQFhrL2u"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733071AbfDQRWt (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 17 Apr 2019 13:22:49 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:39041 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732949AbfDQRWr (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 17 Apr 2019 13:22:47 -0400
Received: by mail-pg1-f193.google.com with SMTP id k3so12309397pga.6
        for <linux-block@vger.kernel.org>; Wed, 17 Apr 2019 10:22:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=KTtixvViV2zvnEojz5yvoR8apIeVo24Cvgk+PM3zVWk=;
        b=GQFhrL2uq09t7YcdovJssgOteG9B98kmK168Vxe+h+gnYAi7WDg8ETzTxOYkpVBGxX
         WVudEhqM5xcw3EnR4Hlpmtgge26Ff2dKz82NFD+aCi7DrWPKbsc44Jmua7HT2ZBjNqxc
         RZ9oGrX2W3U1MrxCfoFdbLh7CazQnhlULdArQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=KTtixvViV2zvnEojz5yvoR8apIeVo24Cvgk+PM3zVWk=;
        b=FAB3bcB1K2czVgKWgGxJl4Sof1rlQvdqGTIhS6IYUpKEyeJA5NSp5J5QFPAC9mDzig
         q/3j9HXaXQbig1xjPUyPNhHcLphXFb9+5t4eu2sIo+Nch+4NuIdxfy4LMtZUtiSdzuda
         6RLYAn2xG28tv3rVODsxgIHhKBwd3aRrKVlohMWkxVeCM9+qDvNStedX/5VIVrxACXTd
         sh8KaCpawgiURdLTP6HzAe9gSSamdGCShBPHTYn7m2zQizahX5R/RumLWolf3MFnel9Y
         S7PIYecnXmJYT/dJEJNHeP54G21wQ/5J01R6mVb/3sIA7Grho4q79GP/3V1DmFHUS5QU
         Bs5A==
X-Gm-Message-State: APjAAAU4KIvveaqLiN7k2gA56xONYk/gCWFOwHBt0pXw7skNF7lLbEo3
        7STXvv70ZhN1DbVzoym2GKcifg==
X-Google-Smtp-Source: APXvYqw1iOzgNWci6pzRyz+Z4I2i5rTkMo8sbehwApK1vKcEozTiLFb0lB6gpC4orD6Ww2MoAn2xLw==
X-Received: by 2002:aa7:9089:: with SMTP id i9mr92318343pfa.115.1555521766038;
        Wed, 17 Apr 2019 10:22:46 -0700 (PDT)
Received: from [10.69.37.149] ([192.19.223.250])
        by smtp.gmail.com with ESMTPSA id o81sm78536654pfa.156.2019.04.17.10.22.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 17 Apr 2019 10:22:44 -0700 (PDT)
Subject: Re: [PATCH V6 0/9] blk-mq: fix races related with freeing queue
To:     Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Hannes Reinecke <hare@suse.com>,
        Keith Busch <keith.busch@intel.com>,
        linux-nvme@lists.infradead.org, Sagi Grimberg <sagi@grimberg.me>,
        Dongli Zhang <dongli.zhang@oracle.com>,
        Bart Van Assche <bart.vanassche@wdc.com>,
        linux-scsi@vger.kernel.org,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Christoph Hellwig <hch@lst.de>,
        "James E . J . Bottomley" <jejb@linux.vnet.ibm.com>,
        jianchao wang <jianchao.w.wang@oracle.com>
References: <20190417034410.31957-1-ming.lei@redhat.com>
From:   James Smart <james.smart@broadcom.com>
Message-ID: <6374aea8-7cae-2dac-d0b2-d5a579ffd22f@broadcom.com>
Date:   Wed, 17 Apr 2019 10:22:42 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190417034410.31957-1-ming.lei@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 4/16/2019 8:44 PM, Ming Lei wrote:
> Hi,
>
> Since 45a9c9d909b2 ("blk-mq: Fix a use-after-free"), run queue isn't
> allowed during cleanup queue even though queue refcount is held.
>
> This change has caused lots of kernel oops triggered in run queue path,
> turns out it isn't easy to fix them all.
>
> So move freeing of hw queue resources into hctx's release handler, then
> the above issue is fixed. Meantime, this way is safe given freeing hw
> queue resource doesn't require tags.
>
> V3 covers more races.
>
> V6:
> 	- remove previous SCSI patch which will be routed via SCSI tree
> 	- add reviewed-by tag
> 	- fix one related NVMe scan vs reset race
>
> V5:
> 	- refactor blk_mq_alloc_and_init_hctx()
> 	- fix race related updating nr_hw_queues by always freeing hctx
> 	  after request queue is released
>
> V4:
> 	- add patch for fixing potential use-after-free in blk_mq_update_nr_hw_queues
> 	- fix comment in the last patch
>
> V3:
> 	- cancel q->requeue_work in queue's release handler
> 	- cancel hctx->run_work in hctx's release handler
> 	- add patch 1 for fixing race in plug code path
> 	- the last patch is added for avoiding to grab SCSI's refcont
> 	in IO path
>
> V2:
> 	- moving freeing hw queue resources into hctx's release handler
>
> Ming Lei (9):
>    blk-mq: grab .q_usage_counter when queuing request from plug code path
>    blk-mq: move cancel of requeue_work into blk_mq_release
>    blk-mq: free hw queue's resource in hctx's release handler
>    blk-mq: move all hctx alloction & initialization into
>      __blk_mq_alloc_and_init_hctx
>    blk-mq: split blk_mq_alloc_and_init_hctx into two parts
>    blk-mq: always free hctx after request queue is freed
>    blk-mq: move cancel of hctx->run_work into blk_mq_hw_sysfs_release
>    block: don't drain in-progress dispatch in blk_cleanup_queue()
>    nvme: hold request queue's refcount in ns's whole lifetime
>
>   block/blk-core.c         |  23 +-----
>   block/blk-mq-sysfs.c     |   8 ++
>   block/blk-mq.c           | 195 ++++++++++++++++++++++++++++-------------------
>   block/blk-mq.h           |   2 +-
>   drivers/nvme/host/core.c |  10 ++-
>   include/linux/blk-mq.h   |   2 +
>   include/linux/blkdev.h   |   7 ++
>   7 files changed, 143 insertions(+), 104 deletions(-)
>
> Cc: Dongli Zhang <dongli.zhang@oracle.com>
> Cc: James Smart <james.smart@broadcom.com>
> Cc: Bart Van Assche <bart.vanassche@wdc.com>
> Cc: linux-scsi@vger.kernel.org,
> Cc: Martin K . Petersen <martin.petersen@oracle.com>,
> Cc: Christoph Hellwig <hch@lst.de>,
> Cc: James E . J . Bottomley <jejb@linux.vnet.ibm.com>,
> Cc: jianchao wang <jianchao.w.wang@oracle.com>

We've been testing with the series and so far have been seeing success.

Tested-by:  James Smart   <james.smart@broadcom.com>


