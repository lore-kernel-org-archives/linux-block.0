Return-Path: <SRS0=iCYb=RZ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD221C43381
	for <linux-block@archiver.kernel.org>; Fri, 22 Mar 2019 14:10:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B0C75218E2
	for <linux-block@archiver.kernel.org>; Fri, 22 Mar 2019 14:10:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727866AbfCVOKz (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 22 Mar 2019 10:10:55 -0400
Received: from mx2.suse.de ([195.135.220.15]:41824 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727487AbfCVOKy (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 22 Mar 2019 10:10:54 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 88E49AF5B;
        Fri, 22 Mar 2019 14:10:53 +0000 (UTC)
Subject: Re: [PATCH v2 3/3] block: bio: introduce BIO_ALLOCED flag and check
 it in bio_free
To:     Johannes Thumshirn <jthumshirn@suse.de>, Jens Axboe <axboe@fb.com>
Cc:     Bart Van Assche <bvanassche@acm.org>,
        Christoph Hellwig <hch@lst.de>, Jan Kara <jack@suse.cz>,
        Linux Block Layer Mailinglist <linux-block@vger.kernel.org>,
        Linux FSDEVEL Mailinglist <linux-fsdevel@vger.kernel.org>
References: <20190322131346.20169-1-jthumshirn@suse.de>
 <20190322131346.20169-4-jthumshirn@suse.de>
From:   Hannes Reinecke <hare@suse.de>
Message-ID: <dbc9d01f-bd14-ff91-d9bd-11109f470e2e@suse.de>
Date:   Fri, 22 Mar 2019 15:10:53 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190322131346.20169-4-jthumshirn@suse.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 3/22/19 2:13 PM, Johannes Thumshirn wrote:
> When we're submitting a bio from stack and this ends up being split, we
> call bio_put(). bio_put() will eventually call bio_free() if the reference
> count drops to 0. But freeing the bio is wrong, as it was never allocated
> out of the bio's mempool.
> 
> Flag each normally allocated bio as 'BIO_ALLOCATED' and skip freeing if the
> flag isn't set.
> 
> Fixes: 189ce2b9dcc3 ("block: fast-path for small and simple direct I/O requests")
> Signed-off-by: Johannes Thumshirn <jthumshirn@suse.de>
> ---
>   block/bio.c               | 4 ++++
>   include/linux/blk_types.h | 1 +
>   2 files changed, 5 insertions(+)
> 
Reviewed-by: Hannes Reinecke <hare@suse.com>

Although I do question the 'Fixes' tag here; without the first two this 
patch would be pretty pointless, so I'd rather have all 3 marked with 
'Fixes'.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		   Teamlead Storage & Networking
hare@suse.de			               +49 911 74053 688
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 Nürnberg
GF: Felix Imendörffer, Mary Higgins, Sri Rasiah
HRB 21284 (AG Nürnberg)
