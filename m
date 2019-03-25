Return-Path: <SRS0=AbZH=R4=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE08FC43381
	for <linux-block@archiver.kernel.org>; Mon, 25 Mar 2019 07:39:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7930D20879
	for <linux-block@archiver.kernel.org>; Mon, 25 Mar 2019 07:39:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729803AbfCYHjp (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 25 Mar 2019 03:39:45 -0400
Received: from mx2.suse.de ([195.135.220.15]:60096 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729720AbfCYHjo (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 25 Mar 2019 03:39:44 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 6964BAECD;
        Mon, 25 Mar 2019 07:39:43 +0000 (UTC)
Subject: Re: [PATCH RESEND v2 5/5] block: check_events: don't bother with
 events if unsupported
To:     Martin Wilck <mwilck@suse.com>, Jens Axboe <axboe@kernel.dk>,
        Tejun Heo <tj@kernel.org>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     James Bottomley <jejb@linux.vnet.ibm.com>,
        Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <Bart.VanAssche@sandisk.com>,
        linux-block@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-ide@vger.kernel.org
References: <20190322224353.11088-1-mwilck@suse.com>
 <20190322224353.11088-6-mwilck@suse.com>
From:   Hannes Reinecke <hare@suse.de>
Message-ID: <6c08e09f-1a10-af01-a6f0-3c88fef69c59@suse.de>
Date:   Mon, 25 Mar 2019 08:39:43 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190322224353.11088-6-mwilck@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 3/22/19 11:43 PM, Martin Wilck wrote:
> Drivers now report to the block layer if they support media change
> events. If this is not the case, there's no need to allocate
> the event structure, and all event handling code can effectively
> be skipped. This simplifies code flow in particular for
> non-removable sd devices.
> 
> This effectively reverts commit 75e3f3ee3c64 ("block: always allocate
> genhd->ev if check_events is implemented").
> 
> The sysfs files for the events are kept in place even if no events
> are supported, as user space may rely on them being present. The only
> difference is that an error code is now returned if the user tries
> to set poll_msecs.
> 
> Signed-off-by: Martin Wilck <mwilck@suse.com>
> ---
>   block/genhd.c | 28 +++++++++++++++++-----------
>   1 file changed, 17 insertions(+), 11 deletions(-)
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
