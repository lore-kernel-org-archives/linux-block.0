Return-Path: <SRS0=zJbT=SF=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21A8CC10F0B
	for <linux-block@archiver.kernel.org>; Wed,  3 Apr 2019 12:03:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E24612084B
	for <linux-block@archiver.kernel.org>; Wed,  3 Apr 2019 12:03:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726099AbfDCMDc (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 3 Apr 2019 08:03:32 -0400
Received: from mx2.suse.de ([195.135.220.15]:37060 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726404AbfDCMDc (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 3 Apr 2019 08:03:32 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id E228AABD4;
        Wed,  3 Apr 2019 12:03:30 +0000 (UTC)
Subject: Re: [PATCH] block: bio: ensure newly added bio flags don't override
 BVEC_POOL_IDX
To:     Johannes Thumshirn <jthumshirn@suse.de>, Jens Axboe <axboe@fb.com>
Cc:     Linux Block Layer Mailinglist <linux-block@vger.kernel.org>,
        Linux FSDEVEL Mailinglist <linux-fsdevel@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>
References: <20190403091519.13376-1-jthumshirn@suse.de>
From:   Hannes Reinecke <hare@suse.de>
Message-ID: <2a5adb69-1df4-ce19-b8c6-518ce1346133@suse.de>
Date:   Wed, 3 Apr 2019 14:03:27 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190403091519.13376-1-jthumshirn@suse.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 4/3/19 11:15 AM, Johannes Thumshirn wrote:
> With the introduction of BIO_NO_PAGE_REF we've used up all available bits
> in bio::bi_flags.
> 
> Convert the defines of the flags to an enum and add a BUILD_BUG_ON() call
> to make sure no-one adds a new one and thus overrides the BVEC_POOL_IDX
> causing crashes.
> 
> Signed-off-by: Johannes Thumshirn <jthumshirn@suse.de>
> 
> ---
> This used to be part of my bio patchset but as it's a) not clear why we
> end up calling bio_put() on the on-stack bio and b) the needed prep patch
> for the fix introduces a regression, I've decided to sent this patch out
> as it's valid on it's own.
> 
> I dropped Hannes' and Christoph's R-b though, as the context changed.
> ---
>   block/bio.c               |  3 +++
>   include/linux/blk_types.h | 29 ++++++++++++++++-------------
>   2 files changed, 19 insertions(+), 13 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@suse.com>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke            Teamlead Storage & Networking
hare@suse.de                              +49 911 74053 688
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 Nürnberg
GF: Felix Imendörffer, Mary Higgins, Sri Rasiah
HRB 21284 (AG Nürnberg)
