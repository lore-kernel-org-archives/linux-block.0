Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4A58C433EF
	for <linux-block@archiver.kernel.org>; Wed, 15 Jun 2022 05:58:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231657AbiFOF6k (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 15 Jun 2022 01:58:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243069AbiFOF6U (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 15 Jun 2022 01:58:20 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF8772B263
        for <linux-block@vger.kernel.org>; Tue, 14 Jun 2022 22:58:19 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id AF29E67373; Wed, 15 Jun 2022 07:58:16 +0200 (CEST)
Date:   Wed, 15 Jun 2022 07:58:16 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>, Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH 1/3] blk-iocost: Simplify ioc_rqos_done()
Message-ID: <20220615055816.GA22115@lst.de>
References: <20220614175725.612878-1-bvanassche@acm.org> <20220614175725.612878-2-bvanassche@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220614175725.612878-2-bvanassche@acm.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Jun 14, 2022 at 10:57:23AM -0700, Bart Van Assche wrote:
> Leave out the superfluous "& REQ_OP_MASK" code. The definition of req_op()
> shows that that code is superfluous:
> 
>  #define req_op(req) ((req)->cmd_flags & REQ_OP_MASK)
> 
> Compile-tested only.

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
