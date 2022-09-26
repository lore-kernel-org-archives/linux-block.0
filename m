Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D506DC32771
	for <linux-block@archiver.kernel.org>; Mon, 26 Sep 2022 15:53:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234540AbiIZPxA (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 26 Sep 2022 11:53:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234671AbiIZPw1 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 26 Sep 2022 11:52:27 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A667676943;
        Mon, 26 Sep 2022 07:40:04 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 61F5068AFE; Mon, 26 Sep 2022 16:39:59 +0200 (CEST)
Date:   Mon, 26 Sep 2022 16:39:59 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Serge Semin <fancer.lancer@gmail.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Jonathan Derrick <jonathan.derrick@intel.com>,
        Revanth Rajashekar <revanth.rajashekar@intel.com>,
        Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>,
        Jens Axboe <axboe@fb.com>, Sagi Grimberg <sagi@grimberg.me>,
        Guenter Roeck <linux@roeck-us.net>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] nvme-hwmon: Cache-line-align the NVME SMART
 log-buffer
Message-ID: <20220926143959.GA19918@lst.de>
References: <20220909191916.16013-1-Sergey.Semin@baikalelectronics.ru> <20220909191916.16013-2-Sergey.Semin@baikalelectronics.ru> <20220910053045.GA23052@lst.de> <20220910123542.tzxg2blegw55z5fj@mobilestation> <20220912082909.GA10666@lst.de> <20220925222325.irltbraf4e2j4vtq@mobilestation>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220925222325.irltbraf4e2j4vtq@mobilestation>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Sep 26, 2022 at 01:23:25AM +0300, Serge Semin wrote:
> IMO both the approaches seem unclear if a reader doesn't know what
> they have been introduced for. Anyway do you insist on using the
> kmalloc-ed buffer here instead? If so I'll resubmit the series with
> this patch updated accordingly.

I don't like the __aligend version too much, but I can live with it if
you strongly prefer it.
