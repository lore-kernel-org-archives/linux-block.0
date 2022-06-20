Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DBDAC43334
	for <linux-block@archiver.kernel.org>; Mon, 20 Jun 2022 07:29:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233620AbiFTH3P (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 20 Jun 2022 03:29:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239353AbiFTH3P (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 20 Jun 2022 03:29:15 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56E7CE0F5
        for <linux-block@vger.kernel.org>; Mon, 20 Jun 2022 00:29:14 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 08E7668AA6; Mon, 20 Jun 2022 09:29:11 +0200 (CEST)
Date:   Mon, 20 Jun 2022 09:29:10 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Christoph Hellwig <hch@lst.de>, Ming Lei <ming.lei@redhat.com>,
        Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Subject: Re: [PATCH 3/3] block: Specify the operation type when calling
 blk_mq_map_queue()
Message-ID: <20220620072910.GA11786@lst.de>
References: <20220614175725.612878-1-bvanassche@acm.org> <20220614175725.612878-4-bvanassche@acm.org> <YqkoWUjOPgpqzn4E@T590> <20220615060851.GE22115@lst.de> <d510cb62-4b19-9ae0-cad4-1ca6756cc3fd@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d510cb62-4b19-9ae0-cad4-1ca6756cc3fd@acm.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Jun 17, 2022 at 11:25:41AM -0700, Bart Van Assche wrote:
> I looked into adding a __bitwise annotation for request flags by 
> introducing a new type that is called blk_mq_opf_t. Introducing such a type 
> without modifying a lot of code seems difficult to me. This is what I ran 
> into:
> * If the type of the operation type constants (REQ_OP_READ etc.) is 
> modified into blk_mq_opf_t then their type changes from 'enum req_opf' into 
> type blk_mq_opf_t and sparse complains when passing e.g. REQ_OP_READ to a 
> function that accepts an argument with type enum req_opf.
> * If the type of the operation type constants is not modified then sparse 
> complains about bitwise or-ing the operation type and a request flag, e.g. 
> REQ_OP_WRITE | REQ_FUA.
>
> I'm not sure how to solve this other than by modifying the functions that 
> accept an 'opf' argument into accepting an additional argument (enum 
> req_opf op + blk_mq_opf_t op_flags).

I actually always though of one type for the operation plus flags
as we basically always use the together.  That might still run into
a lot of problems, but is definitively way simpler and matches how
all the argument passing actually works.
