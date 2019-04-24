Return-Path: <SRS0=lHMQ=S2=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88AB6C10F11
	for <linux-block@archiver.kernel.org>; Wed, 24 Apr 2019 18:56:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E9AD208E4
	for <linux-block@archiver.kernel.org>; Wed, 24 Apr 2019 18:56:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727847AbfDXS4I (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 24 Apr 2019 14:56:08 -0400
Received: from mx2.suse.de ([195.135.220.15]:57194 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727503AbfDXS4I (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 24 Apr 2019 14:56:08 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 05828AC32;
        Wed, 24 Apr 2019 18:56:06 +0000 (UTC)
Subject: Re: [PATCH] block: use static bio_set for bio_split() calls
To:     Sagi Grimberg <sagi@grimberg.me>, Ming Lei <ming.lei@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, Hannes Reinecke <hare@suse.com>,
        Bart van Assche <bvanassche@acm.org>,
        Ming Lei <ming.lei@gmail.com>, neilb@suse.com,
        linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>
References: <20190418140632.60606-1-hare@suse.de>
 <20190418143429.GA19175@ming.t460p>
 <98d8549a-2663-b404-e38a-6f55dfb575bf@grimberg.me>
From:   Hannes Reinecke <hare@suse.de>
Message-ID: <69845bdb-cfc6-58d4-4fea-b06c2dd44872@suse.de>
Date:   Wed, 24 Apr 2019 20:56:05 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <98d8549a-2663-b404-e38a-6f55dfb575bf@grimberg.me>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 4/24/19 7:20 PM, Sagi Grimberg wrote:
> 
>> per-queue bioset is used originally for avoiding deadlock, are you
>> sure the static bioset is safe?
> 
> Can you explain this? I didn't find any indication of that in the change
> log history...
> 
> Originally introduced by Kent:
> -- 
> commit 54efd50bfd873e2dbf784e0b21a8027ba4299a3e
> Author: Kent Overstreet <kent.overstreet@gmail.com>
> Date:   Thu Apr 23 22:37:18 2015 -0700
> 
Phew. I was wondering whether I'd been too stupid to find it.
And having looked at it a bit closer, moving the bioset into the holding 
structure would induce more churn, as we'd need to pass the bioset into
blk_queue_split(), which would mean to update all drivers (11 in total) 
for no real gain IMO; bio splitting shouldn't really be a regular 
occurrence and hence the bioset should only be used infrequently.

However, I really would like to get feedback to the actual patch, as 
this solves a real customer issues we've had (or still have, depending 
on the view :-)

Cheers,

Hannes
-- 
Dr. Hannes Reinecke            Teamlead Storage & Networking
hare@suse.de                              +49 911 74053 688
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 Nürnberg
GF: Felix Imendörffer, Mary Higgins, Sri Rasiah
HRB 21284 (AG Nürnberg)
