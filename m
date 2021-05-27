Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B1ADC4707F
	for <linux-block@archiver.kernel.org>; Thu, 27 May 2021 06:54:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F3826613D3
	for <linux-block@archiver.kernel.org>; Thu, 27 May 2021 06:54:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233759AbhE0G4W (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 27 May 2021 02:56:22 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:53814 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232982AbhE0G4U (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 27 May 2021 02:56:20 -0400
Received: from imap.suse.de (imap-alt.suse-dmz.suse.de [192.168.254.47])
        (using TLSv1.2 with cipher ECDHE-ECDSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 4E1D51FD2A;
        Thu, 27 May 2021 06:54:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1622098487; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Ai03IoD0PjXuznTLkTr+VH49kgP6risHsj2t6c6wQgE=;
        b=iQPOr7ZhpvauoYiBIDNUcMCwF3pwr/ZK1ctvHhCgp1sU+xJRXmhZPYgaYqmIkJSOk365Kr
        UUZngVndOv4ZI/4cr1IYLsglr13pJWwCgAVQY715JuZuOMARyimP4BxkA68G2K3yCwUJgo
        sS1zJCdTJyi3LYVUtFapXgWWlRpu/gw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1622098487;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Ai03IoD0PjXuznTLkTr+VH49kgP6risHsj2t6c6wQgE=;
        b=B5efyuY9dPbIW0H1URSmspLopYQsg5Yqjz8sfXRHQOpVzPxkIkUp/gt6ct2wFnx1i+ekB6
        VDfRLPHv9xt6kRBw==
Received: from director2.suse.de (director2.suse-dmz.suse.de [192.168.254.72])
        by imap.suse.de (Postfix) with ESMTPSA id 2DDC011A98;
        Thu, 27 May 2021 06:54:47 +0000 (UTC)
Subject: Re: [PATCH 7/9] block/mq-deadline: Reserve 25% of tags for
 synchronous requests
To:     Bart Van Assche <bvanassche@acm.org>, Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Adam Manzanares <adam.manzanares@wdc.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Ming Lei <ming.lei@redhat.com>
References: <20210527010134.32448-1-bvanassche@acm.org>
 <20210527010134.32448-8-bvanassche@acm.org>
From:   Hannes Reinecke <hare@suse.de>
Organization: SUSE Linux GmbH
Message-ID: <32cadabf-1a1c-30a4-f1cd-545e88455c66@suse.de>
Date:   Thu, 27 May 2021 08:54:46 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <20210527010134.32448-8-bvanassche@acm.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 5/27/21 3:01 AM, Bart Van Assche wrote:
> For interactive workloads it is important that synchronous requests are
> not delayed. Hence reserve 25% of tags for synchronous requests. This patch
> still allows asynchronous requests to fill the hardware queues since
> blk_mq_init_sched() makes sure that the number of scheduler requests is the
> double of the hardware queue depth. From blk_mq_init_sched():
> 
> 	q->nr_requests = 2 * min_t(unsigned int, q->tag_set->queue_depth,
> 				   BLKDEV_MAX_RQ);
> 
> Cc: Damien Le Moal <damien.lemoal@wdc.com>
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: Ming Lei <ming.lei@redhat.com>
> Signed-off-by: Bart Van Assche <bvanassche@acm.org>
> ---
>  block/mq-deadline.c | 46 +++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 46 insertions(+)
> I wonder if that's a good idea in general ... I'm thinking of poor SATA
drives which only have 31 tags; setting aside 8 of them for specific
use-cases does make a difference one would think.

Do you have testcases for this?

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		        Kernel Storage Architect
hare@suse.de			               +49 911 74053 688
SUSE Software Solutions Germany GmbH, 90409 Nürnberg
GF: F. Imendörffer, HRB 36809 (AG Nürnberg)
