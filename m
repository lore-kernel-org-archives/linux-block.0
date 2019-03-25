Return-Path: <SRS0=AbZH=R4=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 107B7C43381
	for <linux-block@archiver.kernel.org>; Mon, 25 Mar 2019 07:32:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D532920863
	for <linux-block@archiver.kernel.org>; Mon, 25 Mar 2019 07:32:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729760AbfCYHcq (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 25 Mar 2019 03:32:46 -0400
Received: from mx2.suse.de ([195.135.220.15]:58114 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729720AbfCYHcp (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 25 Mar 2019 03:32:45 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 5ACFBAE31;
        Mon, 25 Mar 2019 07:32:44 +0000 (UTC)
Subject: Re: [PATCH RESEND v2 1/5] block: genhd: remove async_events field
To:     Martin Wilck <mwilck@suse.com>, Jens Axboe <axboe@kernel.dk>,
        Tejun Heo <tj@kernel.org>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     James Bottomley <jejb@linux.vnet.ibm.com>,
        Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <Bart.VanAssche@sandisk.com>,
        linux-block@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-ide@vger.kernel.org
References: <20190322224353.11088-1-mwilck@suse.com>
 <20190322224353.11088-2-mwilck@suse.com>
From:   Hannes Reinecke <hare@suse.de>
Message-ID: <01f3cf19-1d81-f029-5719-a03736ae95c4@suse.de>
Date:   Mon, 25 Mar 2019 08:32:44 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190322224353.11088-2-mwilck@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 3/22/19 11:43 PM, Martin Wilck wrote:
> The async_events field, intended to be used for drivers that
> support asynchronous notifications about disk events (aka
> media change events), isn't currently used by any driver,
> and apparently that has been that way for a long time
> (if not forever). Remove it.
> 
> Signed-off-by: Martin Wilck <mwilck@suse.com>
> ---
>   block/genhd.c           | 10 ++++------
>   drivers/block/pktcdvd.c |  1 -
>   include/linux/genhd.h   |  1 -
>   3 files changed, 4 insertions(+), 8 deletions(-)
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
