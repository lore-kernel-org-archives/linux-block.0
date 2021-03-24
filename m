Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC609C433DB
	for <linux-block@archiver.kernel.org>; Wed, 24 Mar 2021 13:22:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7E64061A0B
	for <linux-block@archiver.kernel.org>; Wed, 24 Mar 2021 13:22:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234844AbhCXNVx (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 24 Mar 2021 09:21:53 -0400
Received: from mx2.suse.de ([195.135.220.15]:33848 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234381AbhCXNVt (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 24 Mar 2021 09:21:49 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id A69BEAD9F;
        Wed, 24 Mar 2021 13:21:48 +0000 (UTC)
Subject: Re: [PATCH V3 02/13] block: add one helper to free io_context
To:     Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org,
        Jeffle Xu <jefflexu@linux.alibaba.com>,
        Mike Snitzer <snitzer@redhat.com>, dm-devel@redhat.com
References: <20210324121927.362525-1-ming.lei@redhat.com>
 <20210324121927.362525-3-ming.lei@redhat.com>
From:   Hannes Reinecke <hare@suse.de>
Message-ID: <5c3e5bdf-e591-c7c3-1f4d-cf89de5656be@suse.de>
Date:   Wed, 24 Mar 2021 14:21:48 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <20210324121927.362525-3-ming.lei@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 3/24/21 1:19 PM, Ming Lei wrote:
> Prepare for putting bio poll queue into io_context, so add one helper
> for free io_context.
> 
> Signed-off-by: Ming Lei <ming.lei@redhat.com>
> ---
>   block/blk-ioc.c | 11 ++++++++---
>   1 file changed, 8 insertions(+), 3 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Felix Imendörffer
