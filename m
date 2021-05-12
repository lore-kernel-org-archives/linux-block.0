Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DC78C2BA05
	for <linux-block@archiver.kernel.org>; Wed, 12 May 2021 15:29:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E4D9B61CB3
	for <linux-block@archiver.kernel.org>; Wed, 12 May 2021 15:29:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232080AbhELPaq (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 12 May 2021 11:30:46 -0400
Received: from mx2.suse.de ([195.135.220.15]:35564 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234960AbhELP0B (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 12 May 2021 11:26:01 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id D0A0CAF31;
        Wed, 12 May 2021 15:24:52 +0000 (UTC)
Subject: Re: [PATCH] blk-mq: Use helpers to access rq->state
To:     Nikolay Borisov <nborisov@suse.com>, linux-block@vger.kernel.org,
        axboe@kernel.dk
References: <20210512095017.235295-1-nborisov@suse.com>
From:   Hannes Reinecke <hare@suse.de>
Message-ID: <35620af6-90b4-3a16-7ae8-521c7b888a69@suse.de>
Date:   Wed, 12 May 2021 17:24:52 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.1
MIME-Version: 1.0
In-Reply-To: <20210512095017.235295-1-nborisov@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 5/12/21 11:50 AM, Nikolay Borisov wrote:
> Instead of having a mixed bag of opencoded usage and helper usage,
> simply replace opencoded sites with the appropriate helper. No
> functional changes.
> 
> Signed-off-by: Nikolay Borisov <nborisov@suse.com>
> ---
>   block/blk-mq.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Felix Imendörffer
