Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48CD6C4338F
	for <linux-block@archiver.kernel.org>; Mon,  9 Aug 2021 06:42:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1B9B860E93
	for <linux-block@archiver.kernel.org>; Mon,  9 Aug 2021 06:42:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233256AbhHIGmW (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 9 Aug 2021 02:42:22 -0400
Received: from verein.lst.de ([213.95.11.211]:59610 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233234AbhHIGmW (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 9 Aug 2021 02:42:22 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 1B3D667373; Mon,  9 Aug 2021 08:42:00 +0200 (CEST)
Date:   Mon, 9 Aug 2021 08:41:59 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-kernel@vger.kernel.org,
        linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Dan Schatzberg <schatzberg.dan@gmail.com>
Subject: Re: [PATCH V4 0/7] loop: cleanup charging io to mem/blkcg
Message-ID: <20210809064159.GA19070@lst.de>
References: <20210806080302.298297-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210806080302.298297-1-ming.lei@redhat.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

FYI, I am still of the firm opinion that the current cgroup support in
the loop driver needs to be reverted and be redone cleanly from scratch
without impacting the normal non-cgroup path at all.

On Fri, Aug 06, 2021 at 04:02:55PM +0800, Ming Lei wrote:
> Hello Guys,
> 
> Cleanup charging io to mem/blkcg a bit:
> 
> - avoid to store blkcg_css/memcg_css in loop_cmd, and store blkcg_css in
> loop_worker instead
> 
> - avoid to acquire ->lo_work_lock in IO path
> 
> - simplify blkcg_css query via xarray
> 
> - other misc cleanup
> 
> V4:
> 	- fix build failure in case of !CONFIG_CGROUPS: changed to use
> 	'struct cgroup_subsys_state' as parameter of the added memcg helper;
> 	meantime add helper loop_blkcg_css_id()
> 
> V3:
> 	- one patch style change in 7/7
> 	- rebase patch 4/7 against for-5.15/block
> 	- add acked-by tag
> 
> V2:
> 	- add helper of memcg_get_e_css
> 	- cleanup #ifdef
> 	- improve the last patch, as discussed with Dan Schatzberg
> 
> 
> Ming Lei (7):
>   mm: memcontrol: add helper of memcg_get_e_css
>   loop: clean up blkcg association
>   loop: conver timer for monitoring idle worker into dwork
>   loop: add __loop_free_idle_workers() for covering freeing workers in
>     clearing FD
>   loop: improve loop_process_work
>   loop: use xarray to store workers
>   loop: don't add worker into idle list
> 
>  drivers/block/loop.c       | 331 +++++++++++++++++++++----------------
>  drivers/block/loop.h       |   7 +-
>  include/linux/memcontrol.h |  10 ++
>  3 files changed, 201 insertions(+), 147 deletions(-)
> 
> -- 
> 2.31.1
---end quoted text---
