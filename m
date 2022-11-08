Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 450B3C4332F
	for <linux-block@archiver.kernel.org>; Tue,  8 Nov 2022 06:22:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232956AbiKHGWO (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 8 Nov 2022 01:22:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229660AbiKHGWO (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 8 Nov 2022 01:22:14 -0500
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0263175AA;
        Mon,  7 Nov 2022 22:22:13 -0800 (PST)
Received: by verein.lst.de (Postfix, from userid 2407)
        id CB2CD67373; Tue,  8 Nov 2022 07:22:09 +0100 (CET)
Date:   Tue, 8 Nov 2022 07:22:09 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Serge Semin <Sergey.Semin@baikalelectronics.ru>
Cc:     Jens Axboe <axboe@kernel.dk>, Jens Axboe <axboe@fb.com>,
        Keith Busch <kbusch@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Jonathan Derrick <jonathan.derrick@linux.dev>,
        Sagi Grimberg <sagi@grimberg.me>,
        Scott Bauer <scott.bauer@intel.com>,
        Rafael Antognolli <Rafael.Antognolli@intel.com>,
        Serge Semin <fancer.lancer@gmail.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] block: sed-opal: kmalloc the cmd/resp buffers
Message-ID: <20221108062209.GA19929@lst.de>
References: <20220929224648.8997-4-Sergey.Semin@baikalelectronics.ru> <20221107203944.31686-1-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221107203944.31686-1-Sergey.Semin@baikalelectronics.ru>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
