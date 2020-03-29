Return-Path: <SRS0=N2dH=5O=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DA73C2D0EB
	for <linux-block@archiver.kernel.org>; Sun, 29 Mar 2020 12:09:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0CBED206DB
	for <linux-block@archiver.kernel.org>; Sun, 29 Mar 2020 12:09:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728087AbgC2MJr (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 29 Mar 2020 08:09:47 -0400
Received: from verein.lst.de ([213.95.11.211]:58312 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728160AbgC2MJr (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Sun, 29 Mar 2020 08:09:47 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 0EE1C68C4E; Sun, 29 Mar 2020 14:09:45 +0200 (CEST)
Date:   Sun, 29 Mar 2020 14:09:44 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Cc:     axboe@kernel.dk, linux-block@vger.kernel.org, hch@lst.de
Subject: Re: [PATCH] block: return NULL in blk_alloc_queue() on error
Message-ID: <20200329120944.GA5324@lst.de>
References: <20200328182734.5585-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200328182734.5585-1-chaitanya.kulkarni@wdc.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Sat, Mar 28, 2020 at 11:27:34AM -0700, Chaitanya Kulkarni wrote:
> This patch fixes follwoing warning:
> 
> block/blk-core.c: In function ‘blk_alloc_queue’:
> block/blk-core.c:558:10: warning: returning ‘int’ from a function with return type ‘struct request_queue *’ makes pointer from integer without a cast [-Wint-conversion]
>    return -EINVAL;
> 
> Fixes: 3d745ea5b095a ("block: simplify queue allocation")
> Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>

Oops.  Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
