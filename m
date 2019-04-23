Return-Path: <SRS0=N4qE=SZ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 779CCC10F14
	for <linux-block@archiver.kernel.org>; Tue, 23 Apr 2019 07:00:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4CDB6206BA
	for <linux-block@archiver.kernel.org>; Tue, 23 Apr 2019 07:00:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725970AbfDWHA0 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 23 Apr 2019 03:00:26 -0400
Received: from mx2.suse.de ([195.135.220.15]:59540 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725888AbfDWHA0 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 23 Apr 2019 03:00:26 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 9A570AE78;
        Tue, 23 Apr 2019 07:00:24 +0000 (UTC)
Subject: Re: [RFC PATCH v2 05/16] bcache: reserve space for journal_meta() in
 run time
To:     Coly Li <colyli@suse.de>, linux-bcache@vger.kernel.org
Cc:     linux-block@vger.kernel.org
References: <20190419160509.66298-1-colyli@suse.de>
 <20190419160509.66298-6-colyli@suse.de>
From:   Hannes Reinecke <hare@suse.de>
Message-ID: <66001bc5-4586-d1f8-12d8-5327d85da833@suse.de>
Date:   Tue, 23 Apr 2019 09:00:24 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190419160509.66298-6-colyli@suse.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 4/19/19 6:04 PM, Coly Li wrote:
> Another journal deadlock of bcache jouranling can happen in normal
> bcache runtime. It is very rare to happen but there are people report
> bkey insert work queue blocked which caused by such deadlock.
> 
> This is how such jouranling deadlock in runtime happens,
> - Journal space is totally full and no free space to reclaim, jouranling
>    tasks waiting for space to write in journal_wait_for_write().
> - In order to have free journal space, btree_flush_write() is called to
>    flush earlest journaled in-memory btree key into btree node. Then all
>    journaled bkey in early used journal buckets are flushed to on-disk
>    btree, this journal bucket can be reclaimed for new coming jouranl
>    request.
> - But if the earlest jouranled bkey causes a btree node split during
>    insert it into btree node, finally journal_meta() will be called to
>    journal btree root (and other information) into the journal space.
> - Unfortunately the journal space is full, and the jouranl entries has
>    to be flushed in linear turn. So bch_journal_meta() from bkey insert
>    is blocked too.
> Then jouranling deadlock during bcache run time happens.
> 
> A method to fix such deadlock is to reserve some journal space too. The
> reserved space can only be used when,
> - Current journal bucket is the last journal bucket which has available
>    space to write into.
> - When calling bch_journal(), current jset is empty and there is no key
>    in the inserting key list. This means the journal request if from
>    bch_journal_meta() and no non-reserved space can be used.
> 
> Then if such journaling request is from bch_journal_meta() of inserting
> the earlest journaled bkey back into btree, the deadlock condition won't
> happen any more because the reserved space can be used for such
> scenario.
> 
> Since there are already 6 sectors reserved for journal replay, here we
> reserve 7 sectors for runtime meta journal from btree split caused by
> flushing journal entries back to btree node. Depends on block size from
> 1 sector to 4KB, the reserved space can serve for form 7 to 2 journal
> blocks. Indeed only one journal block reserved for such journal deadlock
> scenario is enough, 2 continuous btree splits cause by two adjoin bkey
> flushing from journal is very very rare to happen. So reserve 7 sectors
> should works.
> 
> Another reason for reserving 7 sectors is, there are already 6 sectors
> reserved fo journal repley, so in total there are 13 sectors reserved in
> last available journal bucket. 13 sectors won't be a proper bucket size,
> so we don't need to add more code to handle journal.blocks_free
> initialization for whole reserved jouranl bucket. Even such code logic
> is simple, less code is better in my humble opinion.
> 
> Again, if in future the reserved space turns out to be not enough, let's
> extend it then.
> 
> Signed-off-by: Coly Li <colyli@suse.de>
> ---
>   drivers/md/bcache/journal.c | 89 +++++++++++++++++++++++++++++++++------------
>   drivers/md/bcache/journal.h |  1 +
>   2 files changed, 66 insertions(+), 24 deletions(-)
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
