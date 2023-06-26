Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25876EB64D7
	for <linux-block@archiver.kernel.org>; Mon, 26 Jun 2023 08:01:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229562AbjFZIBl (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 26 Jun 2023 04:01:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229520AbjFZIBk (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 26 Jun 2023 04:01:40 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEC8590
        for <linux-block@vger.kernel.org>; Mon, 26 Jun 2023 01:01:39 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 508BF68AFE; Mon, 26 Jun 2023 10:01:37 +0200 (CEST)
Date:   Mon, 26 Jun 2023 10:01:36 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org, Damien Le Moal <dlemoal@kernel.org>,
        Ming Lei <ming.lei@redhat.com>,
        Mike Snitzer <snitzer@kernel.org>
Subject: Re: [PATCH v4 5/7] block: Preserve the order of requeued requests
Message-ID: <20230626080136.GA27039@lst.de>
References: <20230621201237.796902-1-bvanassche@acm.org> <20230621201237.796902-6-bvanassche@acm.org> <20230623055053.GE9085@lst.de> <6e57f158-a98c-0355-25a4-2d12f3ec0b23@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6e57f158-a98c-0355-25a4-2d12f3ec0b23@acm.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Jun 23, 2023 at 01:08:33PM -0700, Bart Van Assche wrote:
> Does it matter in this context whether list_empty_careful() or list_empty() 
> is used? If blk_mq_process_requeue_list() is called concurrently with code 
> that adds an element to one of these two lists it is guaranteed that the 
> queue will be run again. This is why I think that it is fine that the list 
> checks in blk_mq_process_requeue_list() race with concurrent list 
> additions.

As far as I can tell we're not holding the relevant lock, so I think we
need list_empty_careful.  Or am I missing something?
