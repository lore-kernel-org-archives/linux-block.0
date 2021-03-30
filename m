Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B259CC433C1
	for <linux-block@archiver.kernel.org>; Tue, 30 Mar 2021 06:18:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5CCAD61957
	for <linux-block@archiver.kernel.org>; Tue, 30 Mar 2021 06:18:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230077AbhC3GRh (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 30 Mar 2021 02:17:37 -0400
Received: from mx2.suse.de ([195.135.220.15]:35370 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230339AbhC3GR0 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 30 Mar 2021 02:17:26 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 282A2AD6D;
        Tue, 30 Mar 2021 06:17:25 +0000 (UTC)
Subject: Re: [PATCH V4 03/12] block: create io poll context for submission and
 poll task
To:     Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org,
        Jeffle Xu <jefflexu@linux.alibaba.com>,
        Mike Snitzer <snitzer@redhat.com>, dm-devel@redhat.com
References: <20210329152622.173035-1-ming.lei@redhat.com>
 <20210329152622.173035-4-ming.lei@redhat.com>
From:   Hannes Reinecke <hare@suse.de>
Message-ID: <9f485fcf-4846-fd58-86e5-deddfe78635f@suse.de>
Date:   Tue, 30 Mar 2021 08:17:24 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <20210329152622.173035-4-ming.lei@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 3/29/21 5:26 PM, Ming Lei wrote:
> Create per-task io poll context for both IO submission and poll task
> if the queue is bio based and supports polling.
> 
> This io polling context includes two queues:
> 
> 1) submission queue(sq) for storing HIPRI bio, written by submission task
>     and read by poll task.
> 2) polling queue(pq) for holding data moved from sq, only used in poll
>     context for running bio polling.
> 
> Following patches will support bio based io polling.
> 
> Signed-off-by: Ming Lei <ming.lei@redhat.com>
> ---
>   block/blk-core.c          | 79 +++++++++++++++++++++++++++++++++------
>   block/blk-ioc.c           |  1 +wed
>   block/blk-mq.c            | 14 +++++++
>   block/blk.h               | 38 +++++++++++++++++++
>   include/linux/iocontext.h |  2 +
>   5 files changed, 123 insertions(+), 11 deletions(-)
> Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Felix Imendörffer
