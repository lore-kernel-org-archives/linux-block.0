Return-Path: <SRS0=E+wN=EK=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B3DAC2D0A3
	for <linux-block@archiver.kernel.org>; Wed,  4 Nov 2020 14:29:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C8A63206FA
	for <linux-block@archiver.kernel.org>; Wed,  4 Nov 2020 14:29:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729772AbgKDO3N (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 4 Nov 2020 09:29:13 -0500
Received: from verein.lst.de ([213.95.11.211]:42843 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726636AbgKDO3M (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 4 Nov 2020 09:29:12 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id 1ACE968B02; Wed,  4 Nov 2020 15:29:09 +0100 (CET)
Date:   Wed, 4 Nov 2020 15:29:08 +0100
From:   "hch@lst.de" <hch@lst.de>
To:     Hannes Reinecke <hare@suse.de>
Cc:     "hch@lst.de" <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
        Javier Gonzalez <javier.gonz@samsung.com>,
        "javier@javigon.com" <javier@javigon.com>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "sagi@grimberg.me" <sagi@grimberg.me>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "joshi.k@samsung.com" <joshi.k@samsung.com>,
        "Klaus B. Jensen" <k.jensen@samsung.com>,
        "Niklas.Cassel@wdc.com" <Niklas.Cassel@wdc.com>
Subject: Re: [PATCH V2] nvme: report capacity 0 for non supported ZNS SSDs
Message-ID: <20201104142908.GA7941@lst.de>
References: <CGME20201102161505eucas1p19415e34eb0b14c7eca5a2c648569cf1e@eucas1p1.samsung.com> <0916865d50c640e3aa95dc542f3986b9@CAMSVWEXC01.scsc.local> <20201102180836.GC20182@lst.de> <20201102183355.GB1970293@dhcp-10-100-145-180.wdc.com> <20201102185851.GA21349@lst.de> <23e10fd1-d20c-cf77-4dc0-dd8b0774fd7a@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <23e10fd1-d20c-cf77-4dc0-dd8b0774fd7a@suse.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Nov 04, 2020 at 03:26:46PM +0100, Hannes Reinecke wrote:
> I hardly dare to mention bsg here; but the is pretty similar to what it set 
> out to do ...

Except that:

 a) we created a complete mess with bsg by overloading the scsi ioctls
    with some of the transport stuff.  
 b) bsg would not work with existing tools.  A character device that
    accepts the same ioctl will just work.
