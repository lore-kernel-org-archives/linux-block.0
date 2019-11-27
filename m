Return-Path: <SRS0=Lpm0=ZT=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03384C432C0
	for <linux-block@archiver.kernel.org>; Wed, 27 Nov 2019 09:00:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE65A20678
	for <linux-block@archiver.kernel.org>; Wed, 27 Nov 2019 09:00:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="qyNGXAML"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726191AbfK0JAc (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 27 Nov 2019 04:00:32 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:55510 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726112AbfK0JAc (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 27 Nov 2019 04:00:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=JmTonCKgBwtH6ZCVvvwC0xYOpQiZgyClbkDvnybuHtY=; b=qyNGXAMLgO2TTMGb2Td8AI4m+
        PCOkAfCO0joXtNVP9+JPW9awSmqB2GzhLrHj22gsOAtVSrKg6d/6W6adhJorKoXkY5BaplSIhIeYp
        EjT+nB1V747ljsacXboUhg6x76TOwqjflIHqx4eI+/jpRx6bUcdLDF3kCpgFBMxhGFD+LjyONGCWP
        mD22ZsmLp6peakUCMmRIYJPnNA0N2cawuDYgEP5hMDU8E3Z3eX75UEqvGktfu3xtV8EMCYVy6PJzE
        WScVHuOl59ZGVaNGCA+FrLA6DeALfOia6cydMSnVZQwgFWtudK2Qoyz9fCvNihRp6R3xfAt5BIXe2
        GYvMy1H5Q==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iZtBP-0000Io-Jy; Wed, 27 Nov 2019 09:00:23 +0000
Date:   Wed, 27 Nov 2019 01:00:23 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Hannes Reinecke <hare@suse.de>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        "(Exiting) Baolin Wang" <baolin.wang@linaro.org>,
        Baolin Wang <baolin.wang7@gmail.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>, asutoshd@codeaurora.org,
        Orson Zhai <orsonzhai@gmail.com>,
        Lyra Zhang <zhang.lyra@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Hannes Reinecke <hare@suse.com>,
        linux-block <linux-block@vger.kernel.org>,
        Paolo Valente <paolo.valente@linaro.org>
Subject: Re: [PATCH v6 0/4] Add MMC software queue support
Message-ID: <20191127090023.GA23040@infradead.org>
References: <cover.1573456283.git.baolin.wang@linaro.org>
 <CAK8P3a1we9D5C2NOBww=cW-4L1PT3t0NnDRmknLwiLm652TmKg@mail.gmail.com>
 <CAMz4kuK9HEuGdhNqHO_qoy9jD=ccsPPhD_dKYwNRgQyWyYwqRA@mail.gmail.com>
 <CAK8P3a0rNhyxmUWLUV1js3FsuAESDOPX3E4b8ActtL4GRT4uTA@mail.gmail.com>
 <CADBw62pzV+5ZXBEbFvTQJ9essAd4cd7Xkz5j9AXB5rAQy0wLqA@mail.gmail.com>
 <CAMz4kuK_3q4JY1vNXe6zGHDNF8Ep-SkcUq6Z25r790VSz4+Bjw@mail.gmail.com>
 <CAK8P3a11vJb1riYseqPnF_5SuJA+YnYuGwC0XWx6_rk+eQ0Bmw@mail.gmail.com>
 <f88856aa-9175-2a93-3747-c98215cb79c3@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f88856aa-9175-2a93-3747-c98215cb79c3@suse.de>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Nov 26, 2019 at 12:17:15PM +0100, Hannes Reinecke wrote:
> Aligning with the 'traditional' linux way for partition handling is
> definitely the way to go IMO; otherwise you'll end up having to worry
> about resource allocation between distinct queues (like you have to do
> now), and will be having a hard time trying to map it properly to the
> underlying hardware abstraction in blk-mq.

Sorry, but this is complete bullshit.  Except for the very unfortunate
name MMC partitions have nothing to do with partitions.  They are a
concept roughly equivalent to SCSI logical units and nvme namespace,
just with a pretty idiotic design decision that only allows I/O to one
of them at a time.  The block layer way to deal with them is to use
a shared tagset for multiple request queues, which doesn't use up a
whole lot of resources.  The only hard part is the draining when
switching between partitions, and there is no really nice way to
deal with that.   If requests are batched enough we could just drain
and switch every time an other partition access comes in.  Especially
so if people only use partitions for boot partitions and other rarely
used areas.  If that doesn't work out we'll just have to reject other
partition access and then use a timer and/or counter to eventually
switch and provide basic fairness.
