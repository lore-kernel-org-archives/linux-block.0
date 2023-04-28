Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6C79C77B60
	for <linux-block@archiver.kernel.org>; Fri, 28 Apr 2023 05:46:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345012AbjD1FqW (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 28 Apr 2023 01:46:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230133AbjD1FqW (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 28 Apr 2023 01:46:22 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74C872109
        for <linux-block@vger.kernel.org>; Thu, 27 Apr 2023 22:46:21 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id CE47968D0A; Fri, 28 Apr 2023 07:46:18 +0200 (CEST)
Date:   Fri, 28 Apr 2023 07:46:18 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Ming Lei <ming.lei@redhat.com>
Subject: Re: [PATCH v3 4/9] block: mq-deadline: Clean up
 deadline_check_fifo()
Message-ID: <20230428054618.GE8549@lst.de>
References: <20230424203329.2369688-1-bvanassche@acm.org> <20230424203329.2369688-5-bvanassche@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230424203329.2369688-5-bvanassche@acm.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Apr 24, 2023 at 01:33:24PM -0700, Bart Van Assche wrote:
> Change the return type of deadline_check_fifo() from 'int' into 'bool'.
> Use time_is_before_eq_jiffies() instead of time_after_eq(). No
> functionality has been changed.

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
