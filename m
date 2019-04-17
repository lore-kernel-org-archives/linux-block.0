Return-Path: <SRS0=3KWi=ST=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B51EAC282DC
	for <linux-block@archiver.kernel.org>; Wed, 17 Apr 2019 12:00:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 81132206BA
	for <linux-block@archiver.kernel.org>; Wed, 17 Apr 2019 12:00:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731499AbfDQMAb (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 17 Apr 2019 08:00:31 -0400
Received: from mx2.suse.de ([195.135.220.15]:44810 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729522AbfDQMAa (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 17 Apr 2019 08:00:30 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 61D43B024;
        Wed, 17 Apr 2019 12:00:29 +0000 (UTC)
Subject: Re: [PATCH V6 2/9] blk-mq: move cancel of requeue_work into
 blk_mq_release
To:     Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Hannes Reinecke <hare@suse.com>,
        Keith Busch <keith.busch@intel.com>,
        linux-nvme@lists.infradead.org, Sagi Grimberg <sagi@grimberg.me>,
        Dongli Zhang <dongli.zhang@oracle.com>,
        James Smart <james.smart@broadcom.com>,
        Bart Van Assche <bart.vanassche@wdc.com>,
        linux-scsi@vger.kernel.org,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Christoph Hellwig <hch@lst.de>,
        "James E . J . Bottomley" <jejb@linux.vnet.ibm.com>,
        jianchao wang <jianchao.w.wang@oracle.com>
References: <20190417034410.31957-1-ming.lei@redhat.com>
 <20190417034410.31957-3-ming.lei@redhat.com>
From:   Hannes Reinecke <hare@suse.de>
Message-ID: <12f1c64b-c9ad-bc2f-1557-d71d182ca0fd@suse.de>
Date:   Wed, 17 Apr 2019 14:00:25 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190417034410.31957-3-ming.lei@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 4/17/19 5:44 AM, Ming Lei wrote:
> With holding queue's kobject refcount, it is safe for driver
> to schedule requeue. However, blk_mq_kick_requeue_list() may
> be called after blk_sync_queue() is done because of concurrent
> requeue activities, then requeue work may not be completed when
> freeing queue, and kernel oops is triggered.
> 
> So moving the cancel of requeue_work into blk_mq_release() for
> avoiding race between requeue and freeing queue.
> 
> Cc: Dongli Zhang <dongli.zhang@oracle.com>
> Cc: James Smart <james.smart@broadcom.com>
> Cc: Bart Van Assche <bart.vanassche@wdc.com>
> Cc: linux-scsi@vger.kernel.org,
> Cc: Martin K . Petersen <martin.petersen@oracle.com>,
> Cc: Christoph Hellwig <hch@lst.de>,
> Cc: James E . J . Bottomley <jejb@linux.vnet.ibm.com>,
> Cc: jianchao wang <jianchao.w.wang@oracle.com>
> Reviewed-by: Bart Van Assche <bvanassche@acm.org>
> Reviewed-by: Johannes Thumshirn <jthumshirn@suse.de>
> Signed-off-by: Ming Lei <ming.lei@redhat.com>
> ---
>   block/blk-core.c | 1 -
>   block/blk-mq.c   | 2 ++
>   2 files changed, 2 insertions(+), 1 deletion(-)
> 
Reviewed-by: Hannes Reinecke <hare@suse.com>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke            Teamlead Storage & Networking
hare@suse.de                              +49 911 74053 688
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 Nürnberg
GF: Felix Imendörffer, Mary Higgins, Sri Rasiah
HRB 21284 (AG Nürnberg)
