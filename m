Return-Path: <SRS0=8pZC=OW=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5A1FC65BAE
	for <linux-block@archiver.kernel.org>; Thu, 13 Dec 2018 14:32:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 935B820870
	for <linux-block@archiver.kernel.org>; Thu, 13 Dec 2018 14:32:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 935B820870
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727916AbeLMOcU (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 13 Dec 2018 09:32:20 -0500
Received: from verein.lst.de ([213.95.11.211]:41350 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727618AbeLMOcU (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 13 Dec 2018 09:32:20 -0500
Received: by newverein.lst.de (Postfix, from userid 2407)
        id E302868D8D; Thu, 13 Dec 2018 15:32:18 +0100 (CET)
Date:   Thu, 13 Dec 2018 15:32:18 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Hannes Reinecke <hare@suse.de>
Cc:     Thadeu Lima de Souza Cascardo <cascardo@canonical.com>,
        linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@fb.com>
Subject: Re: [PATCH 4/4] block: expose devt for GENHD_FL_HIDDEN disks
Message-ID: <20181213143218.GA8723@lst.de>
References: <20181206164812.30925-1-cascardo@canonical.com> <20181206164812.30925-5-cascardo@canonical.com> <b3ef062d-3bc3-fdf8-f395-31d1822a3192@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b3ef062d-3bc3-fdf8-f395-31d1822a3192@suse.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Dec 13, 2018 at 10:18:40AM +0100, Hannes Reinecke wrote:
> Welll ... this is not just 'lsblk', but more importantly this will force 
> udev to create _block_ device nodes for the hidden devices, essentially 
> 'unhide' them.
>
> Is this what we want?
> Christoph?
> I thought the entire _point_ of having hidden devices is that the are ... 
> well ... hidden ...

Yes, that is why I really don't like the last two patches.

And I've checked back - lsblk actually works just fine at the moment.
But it turns out once we create the slave links it stops working,
which is a really good argument against the first two patches, which
would otherwise seem nice..
