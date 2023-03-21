Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDD5FC74A5B
	for <linux-block@archiver.kernel.org>; Tue, 21 Mar 2023 05:58:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229524AbjCUF6M (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 21 Mar 2023 01:58:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229579AbjCUF6L (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 21 Mar 2023 01:58:11 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90CEF9EF9
        for <linux-block@vger.kernel.org>; Mon, 20 Mar 2023 22:58:06 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id E725868AFE; Tue, 21 Mar 2023 06:58:02 +0100 (CET)
Date:   Tue, 21 Mar 2023 06:58:02 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Christoph Hellwig <hch@lst.de>, Ming Lei <ming.lei@redhat.com>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: Re: [PATCH v2 3/3] block: Preserve LBA order when requeuing
Message-ID: <20230321055802.GA18078@lst.de>
References: <20230320234905.3832131-1-bvanassche@acm.org> <20230320234905.3832131-4-bvanassche@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230320234905.3832131-4-bvanassche@acm.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Mar 20, 2023 at 04:49:05PM -0700, Bart Van Assche wrote:
> When requeuing a request to a zoned block device, preserve the LBA order
> per zone.

What causes this requeue?
