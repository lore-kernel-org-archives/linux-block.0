Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B57DC433E0
	for <linux-block@archiver.kernel.org>; Fri, 22 Jan 2021 19:56:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EF5D12343E
	for <linux-block@archiver.kernel.org>; Fri, 22 Jan 2021 19:56:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728323AbhAVTzt (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 22 Jan 2021 14:55:49 -0500
Received: from mx2.suse.de ([195.135.220.15]:34156 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728123AbhAVOLx (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 22 Jan 2021 09:11:53 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 23267AE53;
        Fri, 22 Jan 2021 14:11:06 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id C7F0A1E14C3; Fri, 22 Jan 2021 15:11:05 +0100 (CET)
Date:   Fri, 22 Jan 2021 15:11:05 +0100
From:   Jan Kara <jack@suse.cz>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Ming Lei <ming.lei@redhat.com>,
        Jan Kara <jack@suse.cz>
Subject: Re: [PATCH 0/2 v3] blk-mq: Improve performance of non-mq IO
 schedulers with multiple HW queues
Message-ID: <20210122141105.GA19988@quack2.suse.cz>
References: <20210111164717.21937-1-jack@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210111164717.21937-1-jack@suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon 11-01-21 17:47:15, Jan Kara wrote:
> Hello!
> 
> This patch series aims to fix a regression we've noticed on our test grid when
> support for multiple HW queues in megaraid_sas driver was added during the 5.10
> cycle (103fbf8e4020 scsi: megaraid_sas: Added support for shared host tagset
> for cpuhotplug). The commit was reverted in the end for other reasons but I
> believe the fundamental problem still exists for any other similar setup. The
> problem manifests when the storage card supports multiple hardware queues
> however storage behind it is slow (single rotating disk in our case) and so
> using IO scheduler such as BFQ is desirable. See the second patch for details.
> 
> Changes since v2
> * Modified code to avoid useless sbitmap_any_set() calls on submit path
> 
> Changes since v1
> * Fixed queue running code to don't leave pending requests that bypass IO
>   scheduler.

Jens, can you please pickup these patches? Thanks!

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
