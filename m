Return-Path: <SRS0=81jf=ZZ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E209C432C0
	for <linux-block@archiver.kernel.org>; Tue,  3 Dec 2019 15:18:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 207CA206EC
	for <linux-block@archiver.kernel.org>; Tue,  3 Dec 2019 15:18:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726592AbfLCPSL (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 3 Dec 2019 10:18:11 -0500
Received: from verein.lst.de ([213.95.11.211]:44236 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726057AbfLCPSL (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 3 Dec 2019 10:18:11 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id 2EC0568BFE; Tue,  3 Dec 2019 16:18:09 +0100 (CET)
Date:   Tue, 3 Dec 2019 16:18:08 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Javier =?iso-8859-1?Q?Gonz=E1lez?= <javier@javigon.com>
Cc:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Hans Holmberg <hans@owltronix.com>, linux-block@vger.kernel.org
Subject: Re: [PATCH 8/8] block: set the zone size in
 blk_revalidate_disk_zones atomically
Message-ID: <20191203151808.GA558@lst.de>
References: <20191203093908.24612-1-hch@lst.de> <20191203093908.24612-9-hch@lst.de> <20191203140009.weqdw2kopzaizuoo@mpHalley.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20191203140009.weqdw2kopzaizuoo@mpHalley.local>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Dec 03, 2019 at 03:00:09PM +0100, Javier González wrote:
>> This change also allows to check for a power of two zone size in generic
>> code.
>
> I think however that this checks should remain at the driver level, or
> at least depend on a flag that signals that the zoned device is actually
> a power of two.

The block layer requires a power of two zone size / chunk size,
including having a BUG_ON for that requirement blk_queue_chunk_sectors.
I'd much rather have a proper check in the zone code with proper
diagnostics than triggering a BUG_ON..
