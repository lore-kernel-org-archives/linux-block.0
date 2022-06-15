Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D5CEC43334
	for <linux-block@archiver.kernel.org>; Wed, 15 Jun 2022 05:49:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238751AbiFOFtQ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 15 Jun 2022 01:49:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231417AbiFOFtQ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 15 Jun 2022 01:49:16 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E71501EEF8
        for <linux-block@vger.kernel.org>; Tue, 14 Jun 2022 22:49:14 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 70A9D68AFE; Wed, 15 Jun 2022 07:49:10 +0200 (CEST)
Date:   Wed, 15 Jun 2022 07:49:09 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Khazhy Kumykov <khazhy@google.com>,
        Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: [PATCH 2/5] scsi: Retry unaligned zoned writes
Message-ID: <20220615054909.GA22044@lst.de>
References: <20220614174943.611369-1-bvanassche@acm.org> <20220614174943.611369-3-bvanassche@acm.org> <399e595b-06d2-ceb1-1b42-2a98a7724320@opensource.wdc.com> <29a13708-56b1-60e8-558a-ec4a469eaa6d@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <29a13708-56b1-60e8-558a-ec4a469eaa6d@acm.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Jun 14, 2022 at 04:56:52PM -0700, Bart Van Assche wrote:
> The performance penalty of zone locking is not acceptable for our use case. 
> Does this mean that zone locking needs to be preserved for AHCI but not for 
> UFS?

It means you use case needs to use zone append, and we need to make sure
it is added to SCSI assuming your are on SCSI based on your other comments.
