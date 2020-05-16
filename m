Return-Path: <SRS0=73YH=66=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EBF0C433DF
	for <linux-block@archiver.kernel.org>; Sat, 16 May 2020 15:52:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F030A207C3
	for <linux-block@archiver.kernel.org>; Sat, 16 May 2020 15:51:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726242AbgEPPv7 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 16 May 2020 11:51:59 -0400
Received: from verein.lst.de ([213.95.11.211]:60913 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726206AbgEPPv7 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Sat, 16 May 2020 11:51:59 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id D1DEA68B05; Sat, 16 May 2020 17:51:56 +0200 (CEST)
Date:   Sat, 16 May 2020 17:51:56 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     axboe@kernel.dk
Cc:     linux-block@vger.kernel.org
Subject: Re: [PATCH] block: remove the REQ_NOWAIT_INLINE flag
Message-ID: <20200516155156.GA16951@lst.de>
References: <20200504161005.2841033-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200504161005.2841033-1-hch@lst.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

ping?

On Mon, May 04, 2020 at 06:10:05PM +0200, Christoph Hellwig wrote:
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  include/linux/blk_types.h | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h
> index 90895d594e647..7443e474cdad5 100644
> --- a/include/linux/blk_types.h
> +++ b/include/linux/blk_types.h
> @@ -323,7 +323,6 @@ enum req_flag_bits {
>  	__REQ_RAHEAD,		/* read ahead, can fail anytime */
>  	__REQ_BACKGROUND,	/* background IO */
>  	__REQ_NOWAIT,           /* Don't wait if request will block */
> -	__REQ_NOWAIT_INLINE,	/* Return would-block error inline */
>  	/*
>  	 * When a shared kthread needs to issue a bio for a cgroup, doing
>  	 * so synchronously can lead to priority inversions as the kthread
> @@ -358,7 +357,6 @@ enum req_flag_bits {
>  #define REQ_RAHEAD		(1ULL << __REQ_RAHEAD)
>  #define REQ_BACKGROUND		(1ULL << __REQ_BACKGROUND)
>  #define REQ_NOWAIT		(1ULL << __REQ_NOWAIT)
> -#define REQ_NOWAIT_INLINE	(1ULL << __REQ_NOWAIT_INLINE)
>  #define REQ_CGROUP_PUNT		(1ULL << __REQ_CGROUP_PUNT)
>  
>  #define REQ_NOUNMAP		(1ULL << __REQ_NOUNMAP)
> -- 
> 2.26.2
---end quoted text---
