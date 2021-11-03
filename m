Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B9D9C433F5
	for <linux-block@archiver.kernel.org>; Wed,  3 Nov 2021 07:22:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3EE4C603E9
	for <linux-block@archiver.kernel.org>; Wed,  3 Nov 2021 07:22:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232064AbhKCHZE (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 3 Nov 2021 03:25:04 -0400
Received: from verein.lst.de ([213.95.11.211]:58531 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232034AbhKCHZD (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 3 Nov 2021 03:25:03 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id D56F168AA6; Wed,  3 Nov 2021 08:22:23 +0100 (CET)
Date:   Wed, 3 Nov 2021 08:22:23 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     "chenxiang (M)" <chenxiang66@hisilicon.com>
Cc:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Jeffle Xu <jefflexu@linux.alibaba.com>,
        Ming Lei <ming.lei@redhat.com>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Keith Busch <kbusch@kernel.org>,
        Sagi Grimberg <sagi@grimberg.me>,
        "Wunderlich, Mark" <mark.wunderlich@intel.com>,
        "Vasudevan, Anil" <anil.vasudevan@intel.com>,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-nvme@lists.infradead.org
Subject: Re: [PATCH 14/16] block: switch polling to be bio based
Message-ID: <20211103072223.GB31003@lst.de>
References: <20211012111226.760968-1-hch@lst.de> <20211012111226.760968-15-hch@lst.de> <beb633f4-4508-ea53-4a34-adf0f20cda85@hisilicon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <beb633f4-4508-ea53-4a34-adf0f20cda85@hisilicon.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Nov 03, 2021 at 03:11:25PM +0800, chenxiang (M) wrote:
> For some scsi command sent by function __scsi_execute() without data, it 
> has request but no bio (bufflen = 0),
> then how to use bio_poll() for them ?

You can't send these requests as polled.  Note that these are passthrough
requests only.
