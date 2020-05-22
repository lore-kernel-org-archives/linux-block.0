Return-Path: <SRS0=5dBz=7E=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC026C433E1
	for <linux-block@archiver.kernel.org>; Fri, 22 May 2020 09:11:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D6B47206B6
	for <linux-block@archiver.kernel.org>; Fri, 22 May 2020 09:11:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729582AbgEVJLx (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 22 May 2020 05:11:53 -0400
Received: from mx2.suse.de ([195.135.220.15]:46386 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728068AbgEVJLw (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 22 May 2020 05:11:52 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 453D9B1FFE;
        Fri, 22 May 2020 09:11:53 +0000 (UTC)
Subject: Re: [PATCH 1/6] blk-mq: remove the bio argument to ->prepare_request
To:     Christoph Hellwig <hch@lst.de>
Cc:     linux-block@vger.kernel.org, John Garry <john.garry@huawei.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Hannes Reinecke <hare@suse.com>,
        Thomas Gleixner <tglx@linutronix.de>
References: <20200520170635.2094101-1-hch@lst.de>
 <20200520170635.2094101-2-hch@lst.de>
From:   Hannes Reinecke <hare@suse.de>
Message-ID: <2351df60-fd7a-4eba-3b05-97ae7f5beb9d@suse.de>
Date:   Fri, 22 May 2020 11:11:49 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200520170635.2094101-2-hch@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 5/20/20 7:06 PM, Christoph Hellwig wrote:
> None of the I/O schedulers actually needs it.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>   block/bfq-iosched.c      | 2 +-
>   block/blk-mq.c           | 2 +-
>   block/kyber-iosched.c    | 2 +-
>   block/mq-deadline.c      | 2 +-
>   include/linux/elevator.h | 2 +-
>   5 files changed, 5 insertions(+), 5 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke            Teamlead Storage & Networking
hare@suse.de                               +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Felix Imendörffer
