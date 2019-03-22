Return-Path: <SRS0=iCYb=RZ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EBBEC43381
	for <linux-block@archiver.kernel.org>; Fri, 22 Mar 2019 14:06:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 45E22218D4
	for <linux-block@archiver.kernel.org>; Fri, 22 Mar 2019 14:06:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727798AbfCVOGl (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 22 Mar 2019 10:06:41 -0400
Received: from mx2.suse.de ([195.135.220.15]:40026 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727528AbfCVOGl (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 22 Mar 2019 10:06:41 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 50836AF75;
        Fri, 22 Mar 2019 14:06:40 +0000 (UTC)
Subject: Re: [PATCH v2 1/3] block: bio: kill BIO_SEG_VALID flag
To:     Johannes Thumshirn <jthumshirn@suse.de>, Jens Axboe <axboe@fb.com>
Cc:     Bart Van Assche <bvanassche@acm.org>,
        Christoph Hellwig <hch@lst.de>, Jan Kara <jack@suse.cz>,
        Linux Block Layer Mailinglist <linux-block@vger.kernel.org>,
        Linux FSDEVEL Mailinglist <linux-fsdevel@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>
References: <20190322131346.20169-1-jthumshirn@suse.de>
 <20190322131346.20169-2-jthumshirn@suse.de>
From:   Hannes Reinecke <hare@suse.de>
Message-ID: <d7c9dc19-d1b4-4e0f-aa17-23f153a0737a@suse.de>
Date:   Fri, 22 Mar 2019 15:06:40 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190322131346.20169-2-jthumshirn@suse.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 3/22/19 2:13 PM, Johannes Thumshirn wrote:
> From: Jens Axboe <axboe@kernel.dk>
> 
> Kill the BIO_SEG_VALID flag. We should just use ->bi_phys_segments to tell
> if it's valid or not.
> 
> This patch uses -1 to signify it's not.
> 
> Signed-off-by: Jens Axboe <axboe@kernel.dk>
> [ jth initialize pc bios with 1 phys segment and WARN if we're submitting
> bios with -1 segments ]
> Signed-off-by: Johannes Thumshirn <jthumshirn@suse.de>
> ---
>   block/bio.c               | 15 +++++++++------
>   block/blk-core.c          |  1 +
>   block/blk-merge.c         | 13 ++++++-------
>   drivers/md/raid5.c        |  2 +-
>   include/linux/blk_types.h |  1 -
>   5 files changed, 17 insertions(+), 15 deletions(-)
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
