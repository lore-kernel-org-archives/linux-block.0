Return-Path: <SRS0=4UPx=RO=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAED9C43381
	for <linux-block@archiver.kernel.org>; Mon, 11 Mar 2019 15:23:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF2C5206BA
	for <linux-block@archiver.kernel.org>; Mon, 11 Mar 2019 15:23:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726864AbfCKPXg (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 11 Mar 2019 11:23:36 -0400
Received: from verein.lst.de ([213.95.11.211]:42087 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726820AbfCKPXg (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 11 Mar 2019 11:23:36 -0400
Received: by newverein.lst.de (Postfix, from userid 2407)
        id 72D3E68C7B; Mon, 11 Mar 2019 16:23:31 +0100 (CET)
Date:   Mon, 11 Mar 2019 16:23:31 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Keith Busch <kbusch@kernel.org>
Cc:     Ming Lei <ming.lei@redhat.com>, linux-nvme@lists.infradead.org,
        linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Jens Axboe <axboe@kernel.dk>,
        Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Subject: Re: NVMe: Regression: write zeros corrupts ext4 file system
Message-ID: <20190311152331.GA9000@lst.de>
References: <20190311022441.GA16849@ming.t460p> <20190311145457.GA10411@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190311145457.GA10411@localhost.localdomain>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Mar 11, 2019 at 08:54:59AM -0600, Keith Busch wrote:
> In QEMU, blk_aio_pwrite_zeroes() takes bytes, but the nvme controller
> thought it was blocks. Oops, that went by unnoticed till now!
> 
> We should fix QEMU (patch below). Question is, should we quirk driver 
> for older versions too?

I think we should.  We are actually still quirking all qemu controllers
for broken Identify behavior, at some point we'll have to make them
version specific..
