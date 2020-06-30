Return-Path: <SRS0=9ToN=AL=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C0DAC433DF
	for <linux-block@archiver.kernel.org>; Tue, 30 Jun 2020 06:10:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 709F5206A1
	for <linux-block@archiver.kernel.org>; Tue, 30 Jun 2020 06:10:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729671AbgF3GK2 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 30 Jun 2020 02:10:28 -0400
Received: from mx2.suse.de ([195.135.220.15]:51676 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729278AbgF3GK2 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 30 Jun 2020 02:10:28 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 058B1AAC5;
        Tue, 30 Jun 2020 06:10:27 +0000 (UTC)
Subject: Re: [PATCH 1/3] blk-mq: move blk_mq_get_driver_tag into blk-mq.c
To:     Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@infradead.org>
References: <20200630022356.2149607-1-ming.lei@redhat.com>
 <20200630022356.2149607-2-ming.lei@redhat.com>
From:   Hannes Reinecke <hare@suse.de>
Message-ID: <135d8aba-9194-ce5f-7642-06e1b4dfe7e4@suse.de>
Date:   Tue, 30 Jun 2020 08:10:25 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200630022356.2149607-2-ming.lei@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 6/30/20 4:23 AM, Ming Lei wrote:
> blk_mq_get_driver_tag() is only used by blk-mq.c and is supposed to
> stay in blk-mq.c, so move it and preparing for cleanup code of
> get/put driver tag.
> 
> Meantime hctx_may_queue() is moved to header file and it is fine
> since it is defined as inline always.
> 
> No functional change.
> 
> Cc: Christoph Hellwig <hch@infradead.org>
> Signed-off-by: Ming Lei <ming.lei@redhat.com>
> ---
>   block/blk-mq-tag.c | 58 ----------------------------------------------
>   block/blk-mq-tag.h | 39 ++++++++++++++++++++++++-------
>   block/blk-mq.c     | 34 +++++++++++++++++++++++++++
>   3 files changed, 65 insertions(+), 66 deletions(-)
> 
Curiously; I stumbled across this yesterday, too.
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke            Teamlead Storage & Networking
hare@suse.de                               +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Felix Imendörffer
