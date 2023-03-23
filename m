Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 814CCC6FD1C
	for <linux-block@archiver.kernel.org>; Thu, 23 Mar 2023 08:26:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231367AbjCWI0Z (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 23 Mar 2023 04:26:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231387AbjCWI0S (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 23 Mar 2023 04:26:18 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEC53305F1
        for <linux-block@vger.kernel.org>; Thu, 23 Mar 2023 01:26:08 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 08EEC68AA6; Thu, 23 Mar 2023 09:26:05 +0100 (CET)
Date:   Thu, 23 Mar 2023 09:26:04 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Christoph Hellwig <hch@lst.de>, Ming Lei <ming.lei@redhat.com>,
        Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Jaegeuk Kim <jaegeuk@kernel.org>, Jan Kara <jack@suse.cz>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: Re: [PATCH 2/2] block: Split and submit bios in LBA order
Message-ID: <20230323082604.GC21977@lst.de>
References: <20230317195938.1745318-1-bvanassche@acm.org> <20230317195938.1745318-3-bvanassche@acm.org> <ZBT6EmhEfJmgRXU1@ovpn-8-18.pek2.redhat.com> <580e712c-5e43-e1a5-277b-c4e8c50485f0@acm.org> <ZBjsDy2pfPk9t6qB@ovpn-8-29.pek2.redhat.com> <50dfa89c-19fa-b655-f6b8-b8853b066c75@acm.org> <20230321055537.GA18035@lst.de> <100dfc73-d8f3-f08f-e091-3c08707e95f5@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <100dfc73-d8f3-f08f-e091-3c08707e95f5@acm.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Mar 21, 2023 at 07:36:12AM -0700, Bart Van Assche wrote:
> The UFSHCI specification is very clear about the requirement that UFS host 
> controllers must process SCSI commands in order if host software sets one 
> bit at a time in the UFSHCI 3.0 doorbell register: "For Task Management 
> Requests and Transfer Requests, software may issue multiple commands at a 
> time, and may issue new commands before previous commands have completed. 
> When software sets the corresponding doorbell register, the Task Management 
> Requests and Transfer Requests automatically get a time stamp with their 
> issue time. The commands within a command list (Task Management List or 
> Transfer Request List) shall be processed in
> the order of their time stamps, starting from the oldest time stamp. In the 
> case multiple commands from the same list have the same time stamp, they 
> shall be processed in the order of their command list index,
> starting from the lowest index."

But we can't write Linux software just for UFS.  We have no sensible
ordering guarantee anywhere else.

> Damien and Jens agree about introducing an additional hardware queue for 
> preserving the order of zoned writes as one can see here: 
> https://lore.kernel.org/linux-block/ed255a4a-a0da-a962-2da4-13321d0a75c5@kernel.dk/
>
> In our tests pipelining zoned writes (REQ_OP_WRITE) works fine as long as 
> the UFS error handler is not activated. After the UFS error handler has 
> been scheduled and before the SCSI host state is changed into 
> SHOST_RECOVERY, the UFS host controller driver responds with 
> SCSI_MLQUEUE_HOST_BUSY. I'm still working on a solution for the reordering 
> caused by this mechanism.

We'll still need REQ_OP_ZONE_APPEND as the actual file system fast path
interface.  For a low-end device like UFS the sd.c emulation might be
able to take advantage of the above separate queue as an implementation
detail.
