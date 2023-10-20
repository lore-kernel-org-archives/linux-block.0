Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CE66CDB474
	for <linux-block@archiver.kernel.org>; Fri, 20 Oct 2023 04:42:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231279AbjJTEmG (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 20 Oct 2023 00:42:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229695AbjJTEmF (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 20 Oct 2023 00:42:05 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 872A11AE
        for <linux-block@vger.kernel.org>; Thu, 19 Oct 2023 21:42:03 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 9CFB867373; Fri, 20 Oct 2023 06:41:59 +0200 (CEST)
Date:   Fri, 20 Oct 2023 06:41:59 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Ming Lei <ming.lei@redhat.com>,
        Keith Busch <kbusch@kernel.org>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Yu Kuai <yukuai1@huaweicloud.com>,
        Ed Tsai <ed.tsai@mediatek.com>
Subject: Re: [PATCH] block: Improve shared tag set performance
Message-ID: <20231020044159.GB11984@lst.de>
References: <20231018180056.2151711-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231018180056.2151711-1-bvanassche@acm.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Oct 18, 2023 at 11:00:56AM -0700, Bart Van Assche wrote:
> Note: it has been attempted to rework this algorithm. See also "[PATCH
> RFC 0/7] blk-mq: improve tag fair sharing"
> (https://lore.kernel.org/linux-block/20230618160738.54385-1-yukuai1@huaweicloud.com/).
> Given the complexity of that patch series, I do not expect that patch
> series to be merged.

Work is hard, so let's skip it?  That's not really the most convincing
argument.  Hey, I'm the biggest advocate for code improvement by code
removal, but you better have a really good argument why it doesn't hurt
anyone.
