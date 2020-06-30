Return-Path: <SRS0=9ToN=AL=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58431C433E0
	for <linux-block@archiver.kernel.org>; Tue, 30 Jun 2020 05:12:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3DD8820775
	for <linux-block@archiver.kernel.org>; Tue, 30 Jun 2020 05:12:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726213AbgF3FMt (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 30 Jun 2020 01:12:49 -0400
Received: from verein.lst.de ([213.95.11.211]:34501 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725372AbgF3FMt (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 30 Jun 2020 01:12:49 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 38B936736F; Tue, 30 Jun 2020 07:12:47 +0200 (CEST)
Date:   Tue, 30 Jun 2020 07:12:47 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Cc:     linux-block@vger.kernel.org, dm-devel@redhat.com, jack@suse.czi,
        rdunlap@infradead.org, sagi@grimberg.me, mingo@redhat.com,
        rostedt@goodmis.org, snitzer@redhat.com, agk@redhat.com,
        axboe@kernel.dk, paolo.valente@linaro.org, ming.lei@redhat.com,
        bvanassche@acm.org, fangguoju@gmail.com, colyli@suse.de, hch@lst.de
Subject: Re: [PATCH 09/11] block: remove unsed param in blk_fill_rwbs()
Message-ID: <20200630051247.GF27033@lst.de>
References: <20200629234314.10509-1-chaitanya.kulkarni@wdc.com> <20200629234314.10509-10-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200629234314.10509-10-chaitanya.kulkarni@wdc.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Jun 29, 2020 at 04:43:12PM -0700, Chaitanya Kulkarni wrote:
> The last parameter for the function blk_fill_rwbs() was added in
> 5782138e47 ("tracing/events: convert block trace points to
> TRACE_EVENT()") in order to signal read request and use of that parameter
> was replaced with using switch case REQ_OP_READ with
> 1b9a9ab78b0 ("blktrace: use op accessors"), but the parameter was never
> removed.
> 
> This patch removes unused parameter which also allows us to merge existing
> trace points in the following patch.
> 
> Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
> ---
>  include/linux/blktrace_api.h  |  2 +-
>  include/trace/events/bcache.h | 10 +++++-----
>  include/trace/events/block.h  | 19 +++++++++----------
>  kernel/trace/blktrace.c       |  2 +-
>  4 files changed, 16 insertions(+), 17 deletions(-)
> 
> diff --git a/include/linux/blktrace_api.h b/include/linux/blktrace_api.h
> index 3b6ff5902edc..80123eebf005 100644
> --- a/include/linux/blktrace_api.h
> +++ b/include/linux/blktrace_api.h
> @@ -120,7 +120,7 @@ struct compat_blk_user_trace_setup {
>  
>  #endif
>  
> -extern void blk_fill_rwbs(char *rwbs, unsigned int op, int bytes);
> +extern void blk_fill_rwbs(char *rwbs, unsigned int op);

You might want to drop the extern while you're at it.
