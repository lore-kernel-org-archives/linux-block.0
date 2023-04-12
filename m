Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1421CC77B6E
	for <linux-block@archiver.kernel.org>; Wed, 12 Apr 2023 05:04:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229481AbjDLFEO (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 12 Apr 2023 01:04:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjDLFEO (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 12 Apr 2023 01:04:14 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 591AA2D66
        for <linux-block@vger.kernel.org>; Tue, 11 Apr 2023 22:04:13 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id CA6B168BFE; Wed, 12 Apr 2023 07:04:10 +0200 (CEST)
Date:   Wed, 12 Apr 2023 07:04:10 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org
Subject: Re: [PATCH 15/16] blk-mq: pass a flags argument to
 blk_mq_request_bypass_insert
Message-ID: <20230412050410.GC17948@lst.de>
References: <20230411133329.554624-1-hch@lst.de> <20230411133329.554624-16-hch@lst.de> <c5f73293-c804-9513-d68d-3d0dca8a9e7f@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c5f73293-c804-9513-d68d-3d0dca8a9e7f@acm.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Apr 11, 2023 at 11:16:29AM -0700, Bart Van Assche wrote:
> On 4/11/23 06:33, Christoph Hellwig wrote:
>> Replace the two boolean arguments with the same flags that are already
>> passed to blk_mq_insert_request.  Also add the currently unused
>> BLK_MQ_INSERT_ASYNC support so that the flags support is complete.
>
> Hmm ... which two boolean arguments? This patch only converts a single 
> boolean argument of blk_mq_request_bypass_insert() into an unsigned 
> integer.
>
> Additionally, I don't see any reference to BLK_MQ_INSERT_ASYNC in this 
> patch?

Sorry, this slipped over from an earlier version before I moved the
queue runs up the stack.  I'll fix up the commit message.
