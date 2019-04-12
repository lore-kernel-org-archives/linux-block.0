Return-Path: <SRS0=iV0P=SO=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0E4CC10F0E
	for <linux-block@archiver.kernel.org>; Fri, 12 Apr 2019 11:04:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F53B2083E
	for <linux-block@archiver.kernel.org>; Fri, 12 Apr 2019 11:04:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726930AbfDLLEP (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 12 Apr 2019 07:04:15 -0400
Received: from mx2.suse.de ([195.135.220.15]:52682 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726827AbfDLLEO (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 12 Apr 2019 07:04:14 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 90634ABC4;
        Fri, 12 Apr 2019 11:04:13 +0000 (UTC)
Subject: Re: [PATCH V5 4/9] blk-mq: move all hctx alloction & initialization
 into __blk_mq_alloc_and_init_hctx
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
 <20190412033032.10418-5-ming.lei@redhat.com>
From:   Hannes Reinecke <hare@suse.de>
Message-ID: <0918c76b-e557-6ee3-3199-e9651ecdd0ab@suse.de>
Date:   Fri, 12 Apr 2019 13:04:13 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190412033032.10418-5-ming.lei@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 4/12/19 5:30 AM, Ming Lei wrote:
> Move all hctx related allocation and initialization into
> __blk_mq_alloc_and_init_hctx, and prepare for splitting blk_mq_alloc_and_init_hctx
> into real two functions, one is for allocate everything, and another is for
> initializing everyting.
> 
> Cc: Dongli Zhang <dongli.zhang@oracle.com>
> Cc: James Smart <james.smart@broadcom.com>
> Cc: Bart Van Assche <bart.vanassche@wdc.com>
> Cc: linux-scsi@vger.kernel.org,
> Cc: Martin K . Petersen <martin.petersen@oracle.com>,
> Cc: Christoph Hellwig <hch@lst.de>,
> Cc: James E . J . Bottomley <jejb@linux.vnet.ibm.com>,
> Cc: jianchao wang <jianchao.w.wang@oracle.com>
> Signed-off-by: Ming Lei <ming.lei@redhat.com>
> ---
>   block/blk-mq.c | 93 +++++++++++++++++++++++++++-------------------------------
>   1 file changed, 44 insertions(+), 49 deletions(-)
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
