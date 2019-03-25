Return-Path: <SRS0=AbZH=R4=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38B08C43381
	for <linux-block@archiver.kernel.org>; Mon, 25 Mar 2019 07:37:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0FFB12087E
	for <linux-block@archiver.kernel.org>; Mon, 25 Mar 2019 07:37:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729831AbfCYHhP (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 25 Mar 2019 03:37:15 -0400
Received: from mx2.suse.de ([195.135.220.15]:59834 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729720AbfCYHhP (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 25 Mar 2019 03:37:15 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 463AAAE15;
        Mon, 25 Mar 2019 07:37:14 +0000 (UTC)
Subject: Re: [PATCH RESEND v2 3/5] Revert "ide: unexport
 DISK_EVENT_MEDIA_CHANGE for ide-gd and ide-cd"
To:     Martin Wilck <mwilck@suse.com>, Jens Axboe <axboe@kernel.dk>,
        Tejun Heo <tj@kernel.org>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     James Bottomley <jejb@linux.vnet.ibm.com>,
        Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <Bart.VanAssche@sandisk.com>,
        linux-block@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-ide@vger.kernel.org, Borislav Petkov <bp@alien8.de>
References: <20190322224353.11088-1-mwilck@suse.com>
 <20190322224353.11088-4-mwilck@suse.com>
From:   Hannes Reinecke <hare@suse.de>
Message-ID: <795d5684-5d83-99be-594e-a80e23fd8b31@suse.de>
Date:   Mon, 25 Mar 2019 08:37:14 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190322224353.11088-4-mwilck@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 3/22/19 11:43 PM, Martin Wilck wrote:
> This reverts commit 7eec77a1816a7042591a6cbdb4820e9e7ebffe0e.
> 
> Instead of leaving disk->events completely empty, we now export the
> supported events again, and tell the block layer not to forward events to
> user space by not setting DISK_EVENT_FLAG_UEVENT. This allows the block
> layer to distinguish between devices that for which events should be
> handled in kernel only, and devices which don't support any meda change
> events at all.
> 
> Cc: Borislav Petkov <bp@alien8.de>
> Signed-off-by: Martin Wilck <mwilck@suse.com>
> ---
>   drivers/ide/ide-cd.c       | 1 +
>   drivers/ide/ide-cd_ioctl.c | 5 +++--
>   drivers/ide/ide-gd.c       | 6 ++++--
>   3 files changed, 8 insertions(+), 4 deletions(-)
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
