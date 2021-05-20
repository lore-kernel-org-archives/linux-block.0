Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45D09C433B4
	for <linux-block@archiver.kernel.org>; Thu, 20 May 2021 05:49:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1EFBF611BD
	for <linux-block@archiver.kernel.org>; Thu, 20 May 2021 05:49:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229923AbhETFux (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 20 May 2021 01:50:53 -0400
Received: from mx2.suse.de ([195.135.220.15]:45146 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229547AbhETFuw (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 20 May 2021 01:50:52 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 77D53AF95;
        Thu, 20 May 2021 05:49:30 +0000 (UTC)
Subject: Re: [PATCH v2 01/11] block: improve handling of all zones reset
 operation
To:     Damien Le Moal <damien.lemoal@wdc.com>, dm-devel@redhat.com,
        Mike Snitzer <snitzer@redhat.com>, linux-block@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>
References: <20210520042228.974083-1-damien.lemoal@wdc.com>
 <20210520042228.974083-2-damien.lemoal@wdc.com>
From:   Hannes Reinecke <hare@suse.de>
Message-ID: <de53c430-6eaf-ad09-73be-771f243decab@suse.de>
Date:   Thu, 20 May 2021 07:49:29 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <20210520042228.974083-2-damien.lemoal@wdc.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 5/20/21 6:22 AM, Damien Le Moal wrote:
> SCSI, ZNS and null_blk zoned devices support resetting all zones using
> a single command (REQ_OP_ZONE_RESET_ALL), as indicated using the device
> request queue flag QUEUE_FLAG_ZONE_RESETALL. This flag is not set for
> device mapper targets creating zoned devices. In this case, a user
> request for resetting all zones of a device is processed in
> blkdev_zone_mgmt() by issuing a REQ_OP_ZONE_RESET operation for each
> zone of the device. This leads to different behaviors of the
> BLKRESETZONE ioctl() depending on the target device support for the
> reset all operation. E.g.
> 
> blkzone reset /dev/sdX
> 
> will reset all zones of a SCSI device using a single command that will
> ignore conventional, read-only or offline zones.
> 
> But a dm-linear device including conventional, read-only or offline
> zones cannot be reset in the same manner as some of the single zone
> reset operations issued by blkdev_zone_mgmt() will fail. E.g.:
> 
> blkzone reset /dev/dm-Y
> blkzone: /dev/dm-0: BLKRESETZONE ioctl failed: Remote I/O error
> 
> To simplify applications and tools development, unify the behavior of
> the all-zone reset operation by modifying blkdev_zone_mgmt() to not
> issue a zone reset operation for conventional, read-only and offline
> zones, thus mimicking what an actual reset-all device command does on a
> device supporting REQ_OP_ZONE_RESET_ALL. This emulation is done using
> the new function blkdev_zone_reset_all_emulated(). The zones needing a
> reset are identified using a bitmap that is initialized using a zone
> report. Since empty zones do not need a reset, also ignore these zones.
> The function blkdev_zone_reset_all() is introduced for block devices
> natively supporting reset all operations. blkdev_zone_mgmt() is modified
> to call either function to execute an all zone reset request.
> 
> Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>
> [hch: split into multiple functions]
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>   block/blk-zoned.c | 117 +++++++++++++++++++++++++++++++++++-----------
>   1 file changed, 90 insertions(+), 27 deletions(-)
> Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Felix Imendörffer
