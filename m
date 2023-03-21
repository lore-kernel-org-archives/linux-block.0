Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AA4EC6FD1D
	for <linux-block@archiver.kernel.org>; Tue, 21 Mar 2023 05:55:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229685AbjCUFzp (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 21 Mar 2023 01:55:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229524AbjCUFzo (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 21 Mar 2023 01:55:44 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84E2D30192
        for <linux-block@vger.kernel.org>; Mon, 20 Mar 2023 22:55:42 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 2849468AFE; Tue, 21 Mar 2023 06:55:38 +0100 (CET)
Date:   Tue, 21 Mar 2023 06:55:37 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org, Jaegeuk Kim <jaegeuk@kernel.org>,
        Christoph Hellwig <hch@lst.de>, Jan Kara <jack@suse.cz>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: Re: [PATCH 2/2] block: Split and submit bios in LBA order
Message-ID: <20230321055537.GA18035@lst.de>
References: <20230317195938.1745318-1-bvanassche@acm.org> <20230317195938.1745318-3-bvanassche@acm.org> <ZBT6EmhEfJmgRXU1@ovpn-8-18.pek2.redhat.com> <580e712c-5e43-e1a5-277b-c4e8c50485f0@acm.org> <ZBjsDy2pfPk9t6qB@ovpn-8-29.pek2.redhat.com> <50dfa89c-19fa-b655-f6b8-b8853b066c75@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <50dfa89c-19fa-b655-f6b8-b8853b066c75@acm.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Mar 20, 2023 at 04:32:57PM -0700, Bart Van Assche wrote:
> The use case I'm looking at is Android devices with UFS storage. UFS is 
> based on SCSI and hence only REQ_OP_WRITE is supported natively. There is a 
> REQ_OP_ZONE_APPEND emulation in drivers/scsi/sd_zbc.c but it restricts the 
> queue depth to one.

The queue depth (per zone) is limited for regular writes to, for the
same reason that the zone append emulations limits them.  You seem
to be very aware of that too as you've tried various methods to lift
that limit, none of which seems to ultimatively work.
