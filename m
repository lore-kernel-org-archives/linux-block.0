Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C609ECAAD5
	for <linux-block@archiver.kernel.org>; Sat, 10 Sep 2022 05:30:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229546AbiIJFax (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 10 Sep 2022 01:30:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbiIJFaw (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 10 Sep 2022 01:30:52 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67C1C7F262;
        Fri,  9 Sep 2022 22:30:51 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id A536368AA6; Sat, 10 Sep 2022 07:30:45 +0200 (CEST)
Date:   Sat, 10 Sep 2022 07:30:45 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Serge Semin <Sergey.Semin@baikalelectronics.ru>
Cc:     Jonathan Derrick <jonathan.derrick@intel.com>,
        Revanth Rajashekar <revanth.rajashekar@intel.com>,
        Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>,
        Jens Axboe <axboe@fb.com>, Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        Guenter Roeck <linux@roeck-us.net>,
        Serge Semin <fancer.lancer@gmail.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] nvme-hwmon: Cache-line-align the NVME SMART
 log-buffer
Message-ID: <20220910053045.GA23052@lst.de>
References: <20220909191916.16013-1-Sergey.Semin@baikalelectronics.ru> <20220909191916.16013-2-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220909191916.16013-2-Sergey.Semin@baikalelectronics.ru>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

I think this will work, but unless we have to I'd generally prefer
to just split dta that is DMAed into into a separate allocation.
That is, do a separate kmalloc for the nvme_smart_log structure.

Guenter, is this ok with you?
