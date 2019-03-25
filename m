Return-Path: <SRS0=AbZH=R4=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B62D6C43381
	for <linux-block@archiver.kernel.org>; Mon, 25 Mar 2019 07:38:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C12E20879
	for <linux-block@archiver.kernel.org>; Mon, 25 Mar 2019 07:38:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729856AbfCYHiF (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 25 Mar 2019 03:38:05 -0400
Received: from mx2.suse.de ([195.135.220.15]:59956 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729835AbfCYHiF (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 25 Mar 2019 03:38:05 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id D31EFAE15;
        Mon, 25 Mar 2019 07:38:03 +0000 (UTC)
Subject: Re: [PATCH RESEND v2 4/5] Revert "block: unexport
 DISK_EVENT_MEDIA_CHANGE for legacy/fringe drivers"
To:     Martin Wilck <mwilck@suse.com>, Jens Axboe <axboe@kernel.dk>,
        Tejun Heo <tj@kernel.org>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     James Bottomley <jejb@linux.vnet.ibm.com>,
        Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <Bart.VanAssche@sandisk.com>,
        linux-block@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-ide@vger.kernel.org, Jiri Kosina <jikos@kernel.org>,
        Tim Waugh <tim@cyberelk.net>,
        Michal Simek <michal.simek@xilinx.com>
References: <20190322224353.11088-1-mwilck@suse.com>
 <20190322224353.11088-5-mwilck@suse.com>
From:   Hannes Reinecke <hare@suse.de>
Message-ID: <bb64eeca-f0c3-cbd1-f17a-f9237a3a88e0@suse.de>
Date:   Mon, 25 Mar 2019 08:38:01 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190322224353.11088-5-mwilck@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 3/22/19 11:43 PM, Martin Wilck wrote:
> This reverts commit 9fd097b14918875bd6f125ed699d7bbbba5893ee.
> 
> Instead of leaving disk->events completely empty, we now export the
> supported events again, and tell the block layer not to forward events to
> user space by not setting DISK_EVENT_FLAG_UEVENT. This allows the block
> layer to distinguish between devices that for which events should be
> handled in kernel only, and devices which don't support any meda change
> events at all.
> 
> Cc: Jiri Kosina <jikos@kernel.org>
> Cc: Tim Waugh <tim@cyberelk.net>
> Cc: Michal Simek <michal.simek@xilinx.com>
> Signed-off-by: Martin Wilck <mwilck@suse.com>
> ---
>   drivers/block/amiflop.c    | 1 +
>   drivers/block/ataflop.c    | 1 +
>   drivers/block/floppy.c     | 1 +
>   drivers/block/paride/pcd.c | 1 +
>   drivers/block/paride/pd.c  | 1 +
>   drivers/block/paride/pf.c  | 1 +
>   drivers/block/swim.c       | 1 +
>   drivers/block/swim3.c      | 1 +
>   drivers/block/xsysace.c    | 1 +
>   drivers/cdrom/gdrom.c      | 1 +
>   10 files changed, 10 insertions(+)
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
