Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBE7EC43460
	for <linux-block@archiver.kernel.org>; Mon, 26 Apr 2021 07:12:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8C2FB611BF
	for <linux-block@archiver.kernel.org>; Mon, 26 Apr 2021 07:12:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231816AbhDZHM7 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 26 Apr 2021 03:12:59 -0400
Received: from mx2.suse.de ([195.135.220.15]:41092 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231616AbhDZHM7 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 26 Apr 2021 03:12:59 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 55022B00D;
        Mon, 26 Apr 2021 07:12:17 +0000 (UTC)
Subject: Re: [PATCH V6 04/12] block: move block polling code into one
 dedicated source file
To:     Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org,
        Jeffle Xu <jefflexu@linux.alibaba.com>,
        Mike Snitzer <snitzer@redhat.com>, dm-devel@redhat.com,
        Christoph Hellwig <hch@lst.de>
References: <20210422122038.2192933-1-ming.lei@redhat.com>
 <20210422122038.2192933-5-ming.lei@redhat.com>
From:   Hannes Reinecke <hare@suse.de>
Organization: SUSE Linux GmbH
Message-ID: <2811ba56-dee3-9c3b-0bc6-d1072425032d@suse.de>
Date:   Mon, 26 Apr 2021 09:12:08 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.1
MIME-Version: 1.0
In-Reply-To: <20210422122038.2192933-5-ming.lei@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 4/22/21 2:20 PM, Ming Lei wrote:
> Prepare for supporting bio based io polling, and move blk polling
> code into one dedicated source file. And three shared functions are
> put into private header of blk-mq.h
> 
> Suggested-by: Christoph Hellwig <hch@lst.de>
> Signed-off-by: Ming Lei <ming.lei@redhat.com>
> ---
>  block/Makefile   |   3 +-
>  block/blk-mq.c   | 230 -----------------------------------------------
>  block/blk-mq.h   |  40 +++++++++
>  block/blk-poll.c | 196 ++++++++++++++++++++++++++++++++++++++++
>  4 files changed, 238 insertions(+), 231 deletions(-)
>  create mode 100644 block/blk-poll.c
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		        Kernel Storage Architect
hare@suse.de			               +49 911 74053 688
SUSE Software Solutions Germany GmbH, 90409 Nürnberg
GF: F. Imendörffer, HRB 36809 (AG Nürnberg)
