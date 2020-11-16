Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAA1CC63697
	for <linux-block@archiver.kernel.org>; Mon, 16 Nov 2020 17:38:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 970A120B80
	for <linux-block@archiver.kernel.org>; Mon, 16 Nov 2020 17:38:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733284AbgKPRha (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 16 Nov 2020 12:37:30 -0500
Received: from verein.lst.de ([213.95.11.211]:55478 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733233AbgKPRh1 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 16 Nov 2020 12:37:27 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id D93FF68BEB; Mon, 16 Nov 2020 18:37:20 +0100 (CET)
Date:   Mon, 16 Nov 2020 18:37:19 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Oleksii Kurochko <olkuroch@cisco.com>,
        Sagi Grimberg <sagi@grimberg.me>, linux-block@vger.kernel.org
Subject: Re: [PATCH 1/3] block: Fix read-only block device setting after
 revalidate
Message-ID: <20201116173719.GB24173@lst.de>
References: <20201113084702.4164912-1-hch@lst.de> <20201113084702.4164912-2-hch@lst.de> <yq1tutq6mbb.fsf@ca-mkp.ca.oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <yq1tutq6mbb.fsf@ca-mkp.ca.oracle.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Sun, Nov 15, 2020 at 10:55:36PM -0500, Martin K. Petersen wrote:
> My original patch separated "should-write-bios-be-rejected?" state from
> "did-the-user-set-this-partition-ro?". In the rebased version a
> full-device state transition in update_all_part_ro_state() blows away
> any policy the user has set on a given partition.
> 
> The blktests that fail are due to something like:
> 
> # modprobe scsi_debug num_parts=2
> # blockdev --setro /dev/sda2
> # grep . /sys/block/sda/sda2/ro
> 1
> # echo 1 > /sys/module/scsi_debug/parameters/wp
> # echo 1 > /sys/block/sda/device/rescan
> # echo 0 > /sys/module/scsi_debug/parameters/wp
> # echo 1 > /sys/block/sda/device/rescan
> # grep . /sys/block/sda/sda2/ro
> 0
> 
> The user expectation is that since they set partition 2 readonly it
> should remain that way until they either clear the flag or issue
> BLKRRPART to cause the partition table to be reread.

True.  But then again I think the whole idea that a BLKROSET on the
whole device has any effect on the partitions is probably a bad idea.
Even more so once we have the proper hard ro flag in the disk.

I think I'll respin without that.
