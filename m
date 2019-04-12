Return-Path: <SRS0=iV0P=SO=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B311EC10F0E
	for <linux-block@archiver.kernel.org>; Fri, 12 Apr 2019 11:08:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A39C2083E
	for <linux-block@archiver.kernel.org>; Fri, 12 Apr 2019 11:08:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726788AbfDLLIa (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 12 Apr 2019 07:08:30 -0400
Received: from mx2.suse.de ([195.135.220.15]:54506 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726244AbfDLLI3 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 12 Apr 2019 07:08:29 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 7E1FDAC6E;
        Fri, 12 Apr 2019 11:08:28 +0000 (UTC)
Subject: Re: [PATCH V5 7/9] blk-mq: move cancel of hctx->run_work into
 blk_mq_hw_sysfs_release
To:     Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org,
        Dongli Zhang <dongli.zhang@oracle.com>,
        James Smart <james.smart@broadcom.com>,
        Bart Van Assche <bart.vanassche@wdc.com>,
        linux-scsi@vger.kernel.org,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Christoph Hellwig <hch@lst.de>,
        "James E . J . Bottomley" <jejb@linux.vnet.ibm.com>,
        jianchao wang <jianchao.w.wang@oracle.com>
References: <20190412033032.10418-1-ming.lei@redhat.com>
 <20190412033032.10418-8-ming.lei@redhat.com>
From:   Hannes Reinecke <hare@suse.de>
Message-ID: <2405e0a5-8c49-e23a-ed58-8e8e0b7a9d32@suse.de>
Date:   Fri, 12 Apr 2019 13:08:28 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190412033032.10418-8-ming.lei@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 4/12/19 5:30 AM, Ming Lei wrote:
> hctx is always released after requeue is freed.
> 
> With holding queue's kobject refcount, it is safe for driver to run queue,
> so one run queue might be scheduled after blk_sync_queue() is done.
> 
> So moving the cancel of hctx->run_work into blk_mq_hw_sysfs_release()
> for avoiding run released queue.
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
> Signed-off-by: Ming Lei <ming.lei@redhat.com>
> ---
>   block/blk-core.c     | 8 --------
>   block/blk-mq-sysfs.c | 2 ++
>   2 files changed, 2 insertions(+), 8 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@suse.com>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		   Teamlead Storage & Networking
hare@suse.de			               +49 911 74053 688
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 Nürnberg
GF: Felix Imendörffer, Mary Higgins, Sri Rasiah
HRB 21284 (AG Nürnberg)
