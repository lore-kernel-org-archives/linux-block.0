Return-Path: <SRS0=JXuJ=C2=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07679C43461
	for <linux-block@archiver.kernel.org>; Thu, 17 Sep 2020 08:13:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8B2A82075B
	for <linux-block@archiver.kernel.org>; Thu, 17 Sep 2020 08:13:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=flawful.org header.i=@flawful.org header.b="X1HQvE3V"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726342AbgIQIMv (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 17 Sep 2020 04:12:51 -0400
Received: from ste-pvt-msa2.bahnhof.se ([213.80.101.71]:3265 "EHLO
        ste-pvt-msa2.bahnhof.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726397AbgIQIMt (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 17 Sep 2020 04:12:49 -0400
Received: from localhost (localhost [127.0.0.1])
        by ste-pvt-msa2.bahnhof.se (Postfix) with ESMTP id EE8213F762;
        Thu, 17 Sep 2020 09:56:45 +0200 (CEST)
Authentication-Results: ste-pvt-msa2.bahnhof.se;
        dkim=pass (1024-bit key; unprotected) header.d=flawful.org header.i=@flawful.org header.b=X1HQvE3V;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at bahnhof.se
Authentication-Results: ste-ftg-msa2.bahnhof.se (amavisd-new);
        dkim=pass (1024-bit key) header.d=flawful.org
Received: from ste-pvt-msa2.bahnhof.se ([127.0.0.1])
        by localhost (ste-ftg-msa2.bahnhof.se [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id z_8LVB7HjWHy; Thu, 17 Sep 2020 09:56:45 +0200 (CEST)
Received: by ste-pvt-msa2.bahnhof.se (Postfix) with ESMTPA id A8E7C3F72C;
        Thu, 17 Sep 2020 09:56:44 +0200 (CEST)
Received: by flawful.org (Postfix, from userid 1001)
        id D114D248; Thu, 17 Sep 2020 09:56:47 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flawful.org; s=mail;
        t=1600329407; bh=BpxofZvaVEhQmECSv26XKE0FKE17L5sKd5/ebBQFuzM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=X1HQvE3VaovOGFCL5T08OfkjhbbLhyDHFmBxxP9vVJMMwXcKZyhkDswjyc0Cjq1ly
         poj56wrWsv/rzB5uRPIZVIfV4IvCsb9dM7OSMTva9mO+8EgrcUz7WWQSWh5j6+eOUt
         70vucYJriq7O+MdkuKQVAUc6o67vGdHq+WHc99eY=
Date:   Thu, 17 Sep 2020 09:56:47 +0200
From:   Niklas Cassel <nks@flawful.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Damien Le Moal <Damien.LeMoal@wdc.com>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Niklas Cassel <Niklas.Cassel@wdc.com>
Subject: Re: [PATCH v3] null_blk: add support for max open/active zone limit
 for zoned devices
Message-ID: <20200917075647.GA20845@flawful.org>
References: <20200828105400.80893-1-niklas.cassel@wdc.com>
 <20200907081824.GA260080@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200907081824.GA260080@localhost.localdomain>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Sep 07, 2020 at 08:18:26AM +0000, Niklas Cassel wrote:
> On Fri, Aug 28, 2020 at 12:54:00PM +0200, Niklas Cassel wrote:
> > Add support for user space to set a max open zone and a max active zone
> > limit via configfs. By default, the default values are 0 == no limit.
> > 
> > Call the block layer API functions used for exposing the configured
> > limits to sysfs.
> > 
> > Add accounting in null_blk_zoned so that these new limits are respected.
> > Performing an operation that would exceed these limits results in a
> > standard I/O error.
> > 
> > A max open zone limit exists in the ZBC standard.
> > While null_blk_zoned is used to test the Zoned Block Device model in
> > Linux, when it comes to differences between ZBC and ZNS, null_blk_zoned
> > mostly follows ZBC.
> > 
> > Therefore, implement the manage open zone resources function from ZBC,
> > but additionally add support for max active zones.
> > This enables user space not only to test against a device with an open
> > zone limit, but also to test against a device with an active zone limit.
> > 
> > Signed-off-by: Niklas Cassel <niklas.cassel@wdc.com>
> > Reviewed-by: Damien Le Moal <damien.lemoal@wdc.com>
> > ---
> > Changes since v2:
> > -Picked up Damien's Reviewed-by tag.
> > -Fixed a typo in the commit message.
> > -Renamed null_manage_zone_resources() to null_has_zone_resources().
> > 
> >  drivers/block/null_blk.h       |   5 +
> >  drivers/block/null_blk_main.c  |  16 +-
> >  drivers/block/null_blk_zoned.c | 319 +++++++++++++++++++++++++++------
> >  3 files changed, 282 insertions(+), 58 deletions(-)
> 
> Hello Jens,
> 
> A gentle ping on this.
> 
> As far as I can tell, there are no outstanding review comments.


Hello Jens,

Pinging you from another address, in case my corporate email is getting
stuck in your spam filter.

Kind regards,
Niklas
