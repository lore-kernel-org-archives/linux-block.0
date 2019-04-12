Return-Path: <SRS0=iV0P=SO=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7ED16C10F0E
	for <linux-block@archiver.kernel.org>; Fri, 12 Apr 2019 11:09:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 40FA62083E
	for <linux-block@archiver.kernel.org>; Fri, 12 Apr 2019 11:09:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726714AbfDLLJm (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 12 Apr 2019 07:09:42 -0400
Received: from mx2.suse.de ([195.135.220.15]:55022 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726244AbfDLLJm (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 12 Apr 2019 07:09:42 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 5B359ACBD;
        Fri, 12 Apr 2019 11:09:41 +0000 (UTC)
Subject: Re: [PATCH V5 9/9] SCSI: don't hold device refcount in IO path
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
 <20190412033032.10418-10-ming.lei@redhat.com>
From:   Hannes Reinecke <hare@suse.de>
Message-ID: <89b801d0-2ea3-500f-5d62-0b72692b9ffa@suse.de>
Date:   Fri, 12 Apr 2019 13:09:41 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190412033032.10418-10-ming.lei@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 4/12/19 5:30 AM, Ming Lei wrote:
> scsi_device's refcount is always grabbed in IO path.
> 
> Turns out it isn't necessary, because blk_queue_cleanup() will
> drain any in-flight IOs, then cancel timeout/requeue work, and
> SCSI's requeue_work is canceled too in __scsi_remove_device().
> 
> Also scsi_device won't go away until blk_cleanup_queue() is done.
> 
> So don't hold the refcount in IO path, especially the refcount isn't
> required in IO path since blk_queue_enter() / blk_queue_exit()
> is introduced in the legacy block layer.
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
>   drivers/scsi/scsi_lib.c | 28 ++--------------------------
>   1 file changed, 2 insertions(+), 26 deletions(-)
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
