Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F455C433E6
	for <linux-block@archiver.kernel.org>; Wed, 27 Jan 2021 15:32:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F272520809
	for <linux-block@archiver.kernel.org>; Wed, 27 Jan 2021 15:32:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343858AbhA0PcF (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 27 Jan 2021 10:32:05 -0500
Received: from mx2.suse.de ([195.135.220.15]:35244 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1343844AbhA0P2L (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 27 Jan 2021 10:28:11 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id F0047ADE0;
        Wed, 27 Jan 2021 15:27:29 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 789FA1E14D0; Wed, 27 Jan 2021 16:27:29 +0100 (CET)
Date:   Wed, 27 Jan 2021 16:27:29 +0100
From:   Jan Kara <jack@suse.cz>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org,
        Paolo Valente <paolo.valente@linaro.org>,
        Jan Kara <jack@suse.cz>
Subject: Re: [PATCH 0/3 v2] bfq: Two fixes and a cleanup for sequential
 readers
Message-ID: <20210127152729.GA15748@quack2.suse.cz>
References: <20200605140837.5394-1-jack@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200605140837.5394-1-jack@suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed 13-01-21 11:09:24, Jan Kara wrote:
> Hello,
> 
> this patch series contains one tiny cleanup and two relatively simple fixes
> for BFQ I've uncovered when analyzing behavior of four parallel sequential
> readers on one machine. The fio jobfile is like:
> 
> [global]
> direct=0
> ioengine=sync
> invalidate=1
> size=16g
> rw=read
> bs=4k
> 
> [reader]
> numjobs=4
> directory=/mnt
> 
> The first patch fixes a problem due to which the four bfq queues were getting
> merged without a reason. The third patch fixes a problem where we were unfairly
> raising bfq queue think time (leading to clearing of short_ttime and subsequent
> reduction in throughput).
> 
> Jens, since Paolo has acked all the patches, can you please merge them?

Jens, ping? Can you please pick up these fixes? Thanks!

								Honza

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
