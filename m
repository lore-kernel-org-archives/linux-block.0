Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 715D8C54E94
	for <linux-block@archiver.kernel.org>; Sun, 22 Jan 2023 07:57:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229686AbjAVH5Q (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 22 Jan 2023 02:57:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbjAVH5P (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 22 Jan 2023 02:57:15 -0500
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEECE1CADD;
        Sat, 21 Jan 2023 23:57:14 -0800 (PST)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 1370C68AA6; Sun, 22 Jan 2023 08:57:10 +0100 (CET)
Date:   Sun, 22 Jan 2023 08:57:10 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Ondrej Zary <linux@zary.sk>
Cc:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Christoph Hellwig <hch@lst.de>,
        Sergey Shtylyov <s.shtylyov@omp.ru>,
        Jens Axboe <axboe@kernel.dk>, Tim Waugh <tim@cyberelk.net>,
        linux-block@vger.kernel.org, linux-parport@lists.infradead.org,
        linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] pata_parport: add driver (PARIDE replacement)
Message-ID: <20230122075710.GA4046@lst.de>
References: <20230121225314.32459-1-linux@zary.sk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230121225314.32459-1-linux@zary.sk>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

I suspect a comment in the Kconfig for the old PARIDE code to point
to this and maybe even a runtime warning when using the old paride
code would be great.

But except for that the code looks awesome, so let's get it merged ASAP:

Reviewed-by: Christoph Hellwig <hch@lst.de>
