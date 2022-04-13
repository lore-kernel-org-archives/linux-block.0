Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1D97C433EF
	for <linux-block@archiver.kernel.org>; Wed, 13 Apr 2022 17:38:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232862AbiDMRko (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 13 Apr 2022 13:40:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231937AbiDMRkl (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 13 Apr 2022 13:40:41 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DEC36C973
        for <linux-block@vger.kernel.org>; Wed, 13 Apr 2022 10:38:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=AZJsY66c5TcYQ4vjMN6WkMeM3ErEPd6p9C0SMGe9KOE=; b=KkjaVr2Uo+R1NoPCbH/avT5gcP
        SVVDo4MHnIWwgcR4FMu0CHLjXfIIvC6GPFeUhkUxk0RgkYwXsJrtYCb/s9VjpE3A5X03FbWP1Fe/e
        gtH+68XIp2nH6GFLulVnrxCQc8vpLLOXJIwsJ3hjY1/GwwmDmtLkf/L/6Hp6HqT6Gwo3l1tZNoCzE
        vIDMgdNXS4n6PPqhdA9lM37pTpN3UaWpD93xaOEf68X8YR0HaG1BmsettcWWBRe7ll6QdUYZSaA7W
        qMf3oWp6xehqMv0anOF2QKnySEdXcR2nVZO7zqhxs8yPfPYwS1DbYME2dEw+DJPyPmNxnlX8DUWuN
        eqs5MK/g==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1negwX-001xw6-KM; Wed, 13 Apr 2022 17:38:13 +0000
Date:   Wed, 13 Apr 2022 10:38:13 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Yi Zhang <yi.zhang@redhat.com>
Cc:     Bart Van Assche <bvanassche@acm.org>,
        Sagi Grimberg <sagi@grimberg.me>,
        linux-block <linux-block@vger.kernel.org>,
        "open list:NVM EXPRESS DRIVER" <linux-nvme@lists.infradead.org>
Subject: Re: can't run nvme-mp blktests
Message-ID: <YlcKheNsvNSKZ3CE@bombadil.infradead.org>
References: <YlYYJC/WUEsnI9Im@bombadil.infradead.org>
 <CAHj4cs-HD_uQ_=SQKyFcUJvxFmiJMZSxX5uaqCAkN3h2Zw93ZQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHj4cs-HD_uQ_=SQKyFcUJvxFmiJMZSxX5uaqCAkN3h2Zw93ZQ@mail.gmail.com>
Sender: Luis Chamberlain <mcgrof@infradead.org>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Apr 13, 2022 at 11:02:47AM +0800, Yi Zhang wrote:
> On Wed, Apr 13, 2022 at 8:24 AM Luis Chamberlain <mcgrof@kernel.org> wrote:
> >
> > I do have CONFIG_NVME_MULTIPATH=y but I also have:
> >
> > cat /etc/modprobe.d/nvme.conf
> > options nvme_core multipath=N
> >
> > And yet I always end up booting with:
> >
> > cat /sys/module/nvme_core/parameters/multipath
> > Y
> >
> > So trying to run:
> >
> > nvme_trtype=rdma ./check nvmeof-mp
> >
> > I end up with the warning:
> >
> > nvmeof-mp/***                                                [not run]
> >     CONFIG_NVME_MULTIPATH has been set in .config and multipathing has been enabled in the nvme_core kernel module
> >
> > Are there times where one cannot disable multipath? I'm not using
> > any nvme drive at boot, but I do use one for a random data parition.
> 
> So the multipath is not updated with N, pls try manually removing the
> nvme_core module and retest.

I can't remove the module as a filesystem is mounted on one of the nvme
drives used at boot. It is not an OS partition, ie, it is just /data/.
The blktests is intended for some other nvme drives.

> Or just reboot can also help update the parameter.

Reboot does not help, that is my point.

> BTW, to run blktests nvmeof-mp, the correct way is:
> # ./check nvmeof-mp
> # use_siw=1 ./check nvmeof-mp

That does not let me do anything different as CONFIG_NVME_MULTIPATH is
still found to be set and the module parameter for nvme_core for
multipath is still "Y".

  Luis
