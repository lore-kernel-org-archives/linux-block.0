Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B9D3C433E5
	for <linux-block@archiver.kernel.org>; Fri, 26 Mar 2021 15:03:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 299C461958
	for <linux-block@archiver.kernel.org>; Fri, 26 Mar 2021 15:03:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230329AbhCZPCx (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 26 Mar 2021 11:02:53 -0400
Received: from mx2.suse.de ([195.135.220.15]:48352 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230297AbhCZPCc (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 26 Mar 2021 11:02:32 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 12009AD8D;
        Fri, 26 Mar 2021 15:02:31 +0000 (UTC)
Subject: Re: [PATCH V3 08/13] block: prepare for supporting bio_list via other
 link
To:     Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org,
        Jeffle Xu <jefflexu@linux.alibaba.com>,
        Mike Snitzer <snitzer@redhat.com>, dm-devel@redhat.com
References: <20210324121927.362525-1-ming.lei@redhat.com>
 <20210324121927.362525-9-ming.lei@redhat.com>
From:   Hannes Reinecke <hare@suse.de>
Message-ID: <e3ef0a60-81b7-b980-ce36-984c13687e13@suse.de>
Date:   Fri, 26 Mar 2021 16:02:30 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <20210324121927.362525-9-ming.lei@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 3/24/21 1:19 PM, Ming Lei wrote:
> So far bio list helpers always use .bi_next to traverse the list, we
> will support to link bios by other bio field.
> 
> Prepare for such support by adding a macro so that users can define
> another helpers for linking bios by other bio field.
> 
> Signed-off-by: Ming Lei <ming.lei@redhat.com>
> ---
>   include/linux/bio.h | 132 +++++++++++++++++++++++---------------------
>   1 file changed, 68 insertions(+), 64 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Felix Imendörffer
