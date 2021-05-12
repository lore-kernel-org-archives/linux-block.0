Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 864C4C433ED
	for <linux-block@archiver.kernel.org>; Wed, 12 May 2021 15:11:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 18A4661964
	for <linux-block@archiver.kernel.org>; Wed, 12 May 2021 15:11:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232441AbhELPMV (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 12 May 2021 11:12:21 -0400
Received: from mx2.suse.de ([195.135.220.15]:37700 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232157AbhELPKk (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 12 May 2021 11:10:40 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 9741AAF80;
        Wed, 12 May 2021 15:09:31 +0000 (UTC)
Subject: Re: [PATCH v1 4/8] block: move disk unregistration work from
 del_gendisk() to a helper
To:     Luis Chamberlain <mcgrof@kernel.org>, axboe@kernel.dk
Cc:     bvanassche@acm.org, ming.lei@redhat.com, hch@infradead.org,
        jack@suse.cz, osandov@fb.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20210512064629.13899-1-mcgrof@kernel.org>
 <20210512064629.13899-5-mcgrof@kernel.org>
From:   Hannes Reinecke <hare@suse.de>
Message-ID: <282ddaaf-eee9-3b50-2b70-6cdba33a1931@suse.de>
Date:   Wed, 12 May 2021 17:09:30 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.1
MIME-Version: 1.0
In-Reply-To: <20210512064629.13899-5-mcgrof@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 5/12/21 8:46 AM, Luis Chamberlain wrote:
> There is quite a bit of code on del_gendisk() which relates to
> unregistering the disk, using register_disk() as an counter.
> Move all this code into a helper instead of re-writing our own,
> which we'll need later to handle errors on add_disk().
> 
> Since disk unregistrationa also deals with parition unregistration,
> provide a halper for that as well, as we'll later need this when
> adding error handling for add_disk().
> 
> Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
> ---
>   block/genhd.c | 56 +++++++++++++++++++++++++++++----------------------
>   1 file changed, 32 insertions(+), 24 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Felix Imendörffer
