Return-Path: <SRS0=N4qE=SZ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A87FEC10F14
	for <linux-block@archiver.kernel.org>; Tue, 23 Apr 2019 07:10:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 751132077C
	for <linux-block@archiver.kernel.org>; Tue, 23 Apr 2019 07:10:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725939AbfDWHKy (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 23 Apr 2019 03:10:54 -0400
Received: from mx2.suse.de ([195.135.220.15]:60856 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725937AbfDWHKy (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 23 Apr 2019 03:10:54 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 8C8C1AC4F;
        Tue, 23 Apr 2019 07:10:53 +0000 (UTC)
Subject: Re: [RFC PATCH v2 14/16] bcache: try to flush btree nodes as many as
 possible
To:     Coly Li <colyli@suse.de>, linux-bcache@vger.kernel.org
Cc:     linux-block@vger.kernel.org
References: <20190419160509.66298-1-colyli@suse.de>
 <20190419160509.66298-15-colyli@suse.de>
From:   Hannes Reinecke <hare@suse.de>
Message-ID: <c77479ac-6e57-c655-6879-ed11b4563a00@suse.de>
Date:   Tue, 23 Apr 2019 09:10:53 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190419160509.66298-15-colyli@suse.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 4/19/19 6:05 PM, Coly Li wrote:
> When btree_flush_write() is called, it means the journal space is
> exhuasted already. Current code only selects a single btree node to
> write out, which may introduce huge cache bounce from the spinlock on
> multiple cpu cores, when a lot of kworkers on journaling code path to
> call btree_flush_write() for journal space reclaiming.
> 
> This patch tries to flush as many btree node as possible inside
> a single call to btree_flush_write(), then the frequence of calling
> btree_flush_write() can be reduced, which in turn reduces the cache
> bounce from spinlock on multiple cpu cores. Please notice that this
> patch does not reduce the total times of acquiring spinlock, a spin
> lock is still acquired when select every single btree node to write
> out, but this patch will try best to hold the spinlock on same cpu
> core, which avoids the cache bounce where the spinlock is acquired by
> multiple different cpu cores.
> 
> After the patch applied, in my pressure testing, 'top' shows more than
> 50% sys cpu time reduced from the kworks which competing spinlock
> inside btree_flush_write().
> 
> Signed-off-by: Coly Li <colyli@suse.de>
> ---
>   drivers/md/bcache/journal.c | 7 ++++++-
>   drivers/md/bcache/journal.h | 4 ++--
>   2 files changed, 8 insertions(+), 3 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@suse.com>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		   Teamlead Storage & Networking
hare@suse.de			               +49 911 74053 688
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 Nürnberg
GF: Felix Imendörffer, Mary Higgins, Sri Rasiah
HRB 21284 (AG Nürnberg)
