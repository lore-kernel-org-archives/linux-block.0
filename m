Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B249C433ED
	for <linux-block@archiver.kernel.org>; Thu,  6 May 2021 14:51:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3D39C61073
	for <linux-block@archiver.kernel.org>; Thu,  6 May 2021 14:51:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234969AbhEFOwz (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 6 May 2021 10:52:55 -0400
Received: from mail-pj1-f47.google.com ([209.85.216.47]:44566 "EHLO
        mail-pj1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234759AbhEFOwz (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 6 May 2021 10:52:55 -0400
Received: by mail-pj1-f47.google.com with SMTP id lj11-20020a17090b344bb029015bc3073608so3605087pjb.3
        for <linux-block@vger.kernel.org>; Thu, 06 May 2021 07:51:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=xM7dJHdKW127Qy2I5sdjDKFyH0Qfit5VtWeRCfEc6r0=;
        b=BEW054r7yuBQlaPVG2bWjRPjEqeSrjzdyyW00DORCitCJ21jbjgsjCkQyJ5RTCKADV
         mKFVJ8VZ9pFW+hDXjKnLGU2sqZFCMqEYqCLJoMbjBxGrohTtIx2BwXyLYqaZymJt3a8Z
         sgArUaVIpGw6xE5K0+WgVncwmUVM/A+z19bjDh7PjYpcydzyLzhdQI4mWsAwxDfkXmfS
         B2i4ZKA6XDHCVGCvZPOvIFPmFeNJ+4k2z6IPODfi9pyUXd67rKydPclnibiyru08q2Tr
         VxpIM0MsexMDhc7SQLS8CHIQNxrTz6pKd7akDxAYVUgNRANEL/ip/+wxqT76AtVE+YzI
         e8vw==
X-Gm-Message-State: AOAM533pteAdbnciBxNq0uhQImdtJwa3teWUSrNxbBmY5fbLXel7n0Gw
        sfraH0eGdtgKYTEdRL5GUtY=
X-Google-Smtp-Source: ABdhPJwJVj2w1nXI3ixi/UEIrI9cn2Z3U3j6IfZD2M3G72EqpznMNV+wIN0mgLnuDkutFL2TwwHJ7w==
X-Received: by 2002:a17:90a:f285:: with SMTP id fs5mr4989686pjb.7.1620312716612;
        Thu, 06 May 2021 07:51:56 -0700 (PDT)
Received: from ?IPv6:2601:647:4000:d7:c791:bbbb:380d:7882? ([2601:647:4000:d7:c791:bbbb:380d:7882])
        by smtp.gmail.com with ESMTPSA id c23sm2339860pgj.50.2021.05.06.07.51.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 May 2021 07:51:55 -0700 (PDT)
Subject: Re: [PATCH V5 3/4] blk-mq: clear stale request in tags->rq[] before
 freeing one request pool
To:     Christoph Hellwig <hch@infradead.org>,
        Ming Lei <ming.lei@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Hannes Reinecke <hare@suse.de>,
        John Garry <john.garry@huawei.com>,
        David Jeffery <djeffery@redhat.com>
References: <20210505145855.174127-1-ming.lei@redhat.com>
 <20210505145855.174127-4-ming.lei@redhat.com>
 <20210506071256.GD328487@infradead.org> <YJOb+a85Cpb56Mdz@T590>
 <20210506121849.GA400362@infradead.org>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <b21d9e07-577b-f9cd-257f-323a82d8d74d@acm.org>
Date:   Thu, 6 May 2021 07:51:53 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <20210506121849.GA400362@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 5/6/21 5:18 AM, Christoph Hellwig wrote:
> On Thu, May 06, 2021 at 03:34:17PM +0800, Ming Lei wrote:
>>> {
>>> 	struct blk_mq_tags *drv_tags = set->tags[hctx_idx];
>>> 	unsigned int i = 0;
>>> 	unsigned long flags;
>>>
>>> 	spin_lock_irqsave(&drv_tags->lock, flags);
>>> 	for (i = 0; i < set->queue_depth; i++)
>>> 		WARN_ON_ONCE(refcount_read(&drv_tags->rqs[i]->ref) != 0);
>>> 		drv_tags->rqs[i] = NULL;
>>
>> drv_tags->rqs[] may be assigned from another LUN at the same time, then
>> the simple clearing will overwrite the active assignment. We just need
>> to clear mapping iff the stored rq will be freed.
> 
> So.  Even a different LUN shares the same tagset.  So I can see the
> need for the cmpxchg (please document it!), but I don't see the need
> for the complex iteration.  All the rqs are freed in one single loop,
> so we can just iterate through them sequentially.
> 
> Btw, I think ->lock might better be named ->clear_lock to document its
> purpose better.

I'm not sure that would be a better name since I don't think that it is
necessary to hold that lock around the cmpxchg() calls. How about using
something like the following code in blk_mq_clear_rq_mapping() instead
of the code in v5 of patch 3/4?

	spin_lock_irqsave(&drv_tags->lock, flags);
	spin_unlock_irqrestore(&drv_tags->lock, flags);

	list_for_each_entry(page, &tags->page_list, lru) {
		/* use cmpxchg() to clear request pointer selectively */
	}

Thanks,

Bart.
