Return-Path: <SRS0=N4qE=SZ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98723C10F14
	for <linux-block@archiver.kernel.org>; Tue, 23 Apr 2019 07:14:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6FFC520674
	for <linux-block@archiver.kernel.org>; Tue, 23 Apr 2019 07:14:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726330AbfDWHOK (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 23 Apr 2019 03:14:10 -0400
Received: from mx2.suse.de ([195.135.220.15]:33126 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725888AbfDWHOI (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 23 Apr 2019 03:14:08 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 78C35AC4F;
        Tue, 23 Apr 2019 07:14:07 +0000 (UTC)
Subject: Re: [RFC PATCH v2 16/16] bcache: introduce spinlock_t
 flush_write_lock in struct journal
To:     Coly Li <colyli@suse.de>, linux-bcache@vger.kernel.org
Cc:     linux-block@vger.kernel.org
References: <20190419160509.66298-1-colyli@suse.de>
 <20190419160509.66298-17-colyli@suse.de>
From:   Hannes Reinecke <hare@suse.de>
Message-ID: <afa6672f-69a3-eb85-ba65-23ea2046f1ab@suse.de>
Date:   Tue, 23 Apr 2019 09:14:07 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190419160509.66298-17-colyli@suse.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 4/19/19 6:05 PM, Coly Li wrote:
> In btree_flush_write(), iterating all cached btree nodes and adding them
> into ordered heap c->flush_btree takes quite long time. In order to
> protect ordered heap c->flush_btree, spin lock c->journal.lock is held
> for all the iteration and heap ordering. When journal space is fully
> occupied, btree_flush_write() might be called frequently, if the cached
> btree node iteration takes too much time, kenrel will complain that
> normal journal kworkers are blocked too long. Of cause write performance
> drops at this moment.
> 
> This patch introduces a new spin lock member in struct journal, named
> flush_write_lock. This lock is only used in btree_flush_write() and
> protect the ordered heap c->flush_btree during all the cached btree node
> iteration. Then there won't be lock contention on c->journal.lock.
> 
> After this fix, when journal space is fully occupied, it is very rare to
> observe the journal kworker blocking timeout warning.
> 
> Signed-off-by: Coly Li <colyli@suse.de>
> ---
>   drivers/md/bcache/journal.c | 5 +++--
>   drivers/md/bcache/journal.h | 1 +
>   2 files changed, 4 insertions(+), 2 deletions(-)
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
