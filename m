Return-Path: <SRS0=5dBz=7E=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5161C433DF
	for <linux-block@archiver.kernel.org>; Fri, 22 May 2020 09:18:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BD68C207CB
	for <linux-block@archiver.kernel.org>; Fri, 22 May 2020 09:18:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729708AbgEVJSd (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 22 May 2020 05:18:33 -0400
Received: from mx2.suse.de ([195.135.220.15]:50912 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729697AbgEVJSc (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 22 May 2020 05:18:32 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 8121CB2191;
        Fri, 22 May 2020 09:18:22 +0000 (UTC)
Subject: Re: [PATCH 5/6] blk-mq: add blk_mq_all_tag_iter
To:     Christoph Hellwig <hch@lst.de>
Cc:     linux-block@vger.kernel.org, John Garry <john.garry@huawei.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Hannes Reinecke <hare@suse.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ming Lei <ming.lei@redhat.com>
References: <20200520170635.2094101-1-hch@lst.de>
 <20200520170635.2094101-6-hch@lst.de>
From:   Hannes Reinecke <hare@suse.de>
Message-ID: <27f569c7-98ee-df3c-0f13-4a63d3a4d348@suse.de>
Date:   Fri, 22 May 2020 11:18:18 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200520170635.2094101-6-hch@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 5/20/20 7:06 PM, Christoph Hellwig wrote:
> From: Ming Lei <ming.lei@redhat.com>
> 
> Add one new function of blk_mq_all_tag_iter so that we can iterate every
> allocated request from either io scheduler tags or driver tags, and this
> way is more flexible since it allows the callers to do whatever they want
> on allocated request.
> 
> It will be used to implement draining allocated requests on specified
> hctx in this patchset.
> 
> Signed-off-by: Ming Lei <ming.lei@redhat.com>
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>   block/blk-mq-tag.c | 33 +++++++++++++++++++++++++++++----
>   block/blk-mq-tag.h |  2 ++
>   2 files changed, 31 insertions(+), 4 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke            Teamlead Storage & Networking
hare@suse.de                               +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Felix Imendörffer
