Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9A6AC46467
	for <linux-block@archiver.kernel.org>; Tue, 10 Jan 2023 07:09:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230086AbjAJHJf (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 10 Jan 2023 02:09:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229577AbjAJHJe (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 10 Jan 2023 02:09:34 -0500
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 858213FA04;
        Mon,  9 Jan 2023 23:09:33 -0800 (PST)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 2104168AFE; Tue, 10 Jan 2023 08:09:30 +0100 (CET)
Date:   Tue, 10 Jan 2023 08:09:29 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Tejun Heo <tj@kernel.org>
Cc:     axboe@kernel.dk, josef@toxicpanda.com, hch@lst.de,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/4] blkcg: Restructure blkg_conf_prep() and friends
Message-ID: <20230110070929.GH10289@lst.de>
References: <20230105212432.289569-1-tj@kernel.org> <20230105212432.289569-3-tj@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230105212432.289569-3-tj@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Jan 05, 2023 at 11:24:30AM -1000, Tejun Heo wrote:
> * blkg_conf_open_bdev() is updated to take a pointer to blkg_conf_ctx like
>   blkg_conf_prep() and can be called multiple times safely. Instead of
>   modifying the double pointer to input string directly,
>   blkg_conf_open_bdev() now sets blkg_conf_ctx->body.

This looks pretty awkward for the externals callers of blkcg_conf_open_bdev
in blk-iocost.  I'd either keep the calling conventions as they are
at the moment, or just open code blkcg_conf_open_bdev in blk-iocost.
