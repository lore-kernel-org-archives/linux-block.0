Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20DA3C433FE
	for <linux-block@archiver.kernel.org>; Tue,  8 Nov 2022 06:21:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230053AbiKHGVd (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 8 Nov 2022 01:21:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229660AbiKHGVc (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 8 Nov 2022 01:21:32 -0500
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C43C13F7A;
        Mon,  7 Nov 2022 22:21:31 -0800 (PST)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 177FB67373; Tue,  8 Nov 2022 07:21:28 +0100 (CET)
Date:   Tue, 8 Nov 2022 07:21:27 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>
Cc:     linux-ide@vger.kernel.org, linux-block@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>,
        "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>,
        Hannes Reinecke <hare@suse.de>, Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v6 5/7] ata: libata: Fix FUA handling in
 ata_build_rw_tf()
Message-ID: <20221108062127.GB19853@lst.de>
References: <20221108055544.1481583-1-damien.lemoal@opensource.wdc.com> <20221108055544.1481583-6-damien.lemoal@opensource.wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221108055544.1481583-6-damien.lemoal@opensource.wdc.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
