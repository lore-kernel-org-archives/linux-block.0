Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29E5BC433B4
	for <linux-block@archiver.kernel.org>; Fri, 21 May 2021 11:53:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F22B96100C
	for <linux-block@archiver.kernel.org>; Fri, 21 May 2021 11:53:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229610AbhEULzT (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 21 May 2021 07:55:19 -0400
Received: from mx2.suse.de ([195.135.220.15]:48546 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229519AbhEULzS (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 21 May 2021 07:55:18 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id CDC2EAAA6;
        Fri, 21 May 2021 11:53:54 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 923E71F2C73; Fri, 21 May 2021 13:53:54 +0200 (CEST)
Date:   Fri, 21 May 2021 13:53:54 +0200
From:   Jan Kara <jack@suse.cz>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Jan Kara <jack@suse.cz>, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org, Khazhy Kumykov <khazhy@google.com>,
        Paolo Valente <paolo.valente@linaro.org>
Subject: Re: [PATCH 1/2] block: Do not merge recursively in
 elv_attempt_insert_merge()
Message-ID: <20210521115354.GJ18952@quack2.suse.cz>
References: <20210520223353.11561-1-jack@suse.cz>
 <20210520223353.11561-2-jack@suse.cz>
 <YKcB6Hxhe3a1St31@T590>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YKcB6Hxhe3a1St31@T590>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri 21-05-21 08:42:16, Ming Lei wrote:
> On Fri, May 21, 2021 at 12:33:52AM +0200, Jan Kara wrote:
> > Most of the merging happens at bio level. There should not be much
> > merging happening at request level anymore. Furthermore if we backmerged
> > a request to the previous one, the chances to be able to merge the
> > result to even previous request are slim - that could succeed only if
> > requests were inserted in 2 1 3 order. Merging more requests in
> 
> Right, but some workload has this kind of pattern.
> 
> For example of qemu IO emulation, it often can be thought as single job,
> native aio, direct io with high queue depth. IOs is originated from one VM, but
> may be from multiple jobs in the VM, so bio merge may not hit much because of IO
> emulation timing(virtio-scsi/blk's MQ, or IO can be interleaved from multiple
> jobs via the SQ transport), but request merge can really make a difference, see
> recent patch in the following link:
> 
> https://lore.kernel.org/linux-block/3f61e939-d95a-1dd1-6870-e66795cfc1b1@suse.de/T/#t

Oh, request merging definitely does make a difference. But the elevator
hash & merge logic I'm modifying here is used only by BFQ and MQ-DEADLINE
AFAICT. And these IO schedulers will already call blk_mq_sched_try_merge()
from their \.bio_merge handler which gets called from blk_mq_submit_bio().
So all the merging that can happen in the code I remove should have already
happened. Or am I missing something?

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
