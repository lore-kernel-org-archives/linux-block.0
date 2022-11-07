Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBDE1C433FE
	for <linux-block@archiver.kernel.org>; Mon,  7 Nov 2022 05:50:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230050AbiKGFuW (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 7 Nov 2022 00:50:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230214AbiKGFuV (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 7 Nov 2022 00:50:21 -0500
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1A6EB7C4;
        Sun,  6 Nov 2022 21:50:20 -0800 (PST)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 322CE68BFE; Mon,  7 Nov 2022 06:50:18 +0100 (CET)
Date:   Mon, 7 Nov 2022 06:50:17 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>
Cc:     linux-ide@vger.kernel.org, linux-block@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>,
        "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>,
        Hannes Reinecke <hare@suse.de>, Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v5 6/7] ata: libata: blacklist FUA support for known
 buggy drives
Message-ID: <20221107055017.GE28873@lst.de>
References: <20221107005021.1327692-1-damien.lemoal@opensource.wdc.com> <20221107005021.1327692-7-damien.lemoal@opensource.wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221107005021.1327692-7-damien.lemoal@opensource.wdc.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
