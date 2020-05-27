Return-Path: <SRS0=4GtC=7J=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9B5EC433E0
	for <linux-block@archiver.kernel.org>; Wed, 27 May 2020 18:16:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CB4252075A
	for <linux-block@archiver.kernel.org>; Wed, 27 May 2020 18:16:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388778AbgE0SQf (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 27 May 2020 14:16:35 -0400
Received: from mx2.suse.de ([195.135.220.15]:44140 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388720AbgE0SQf (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 27 May 2020 14:16:35 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 4A5DAAEB9;
        Wed, 27 May 2020 18:16:36 +0000 (UTC)
Subject: Re: [PATCH 3/8] blk-mq: move more request initialization to
 blk_mq_rq_ctx_init
To:     Christoph Hellwig <hch@lst.de>
Cc:     linux-block@vger.kernel.org, John Garry <john.garry@huawei.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Hannes Reinecke <hare@suse.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ming Lei <ming.lei@redhat.com>, Daniel Wagner <dwagner@suse.de>
References: <20200527180644.514302-1-hch@lst.de>
 <20200527180644.514302-4-hch@lst.de>
From:   Hannes Reinecke <hare@suse.de>
Message-ID: <70eecb04-8c44-540d-ac04-ac3a739ef8dd@suse.de>
Date:   Wed, 27 May 2020 20:16:31 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200527180644.514302-4-hch@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 5/27/20 8:06 PM, Christoph Hellwig wrote:
> Don't split request initialization between __blk_mq_alloc_request and
> blk_mq_rq_ctx_init.  Also remove the op argument as it can be derived
> from the blk_mq_alloc_data structure.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: Ming Lei <ming.lei@redhat.com>
> Reviewed-by: Bart Van Assche <bvanassche@acm.org>
> Reviewed-by: Daniel Wagner <dwagner@suse.de>
> ---
>   block/blk-mq.c | 36 +++++++++++++++++++-----------------
>   1 file changed, 19 insertions(+), 17 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke            Teamlead Storage & Networking
hare@suse.de                               +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Felix Imendörffer
