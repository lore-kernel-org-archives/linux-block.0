Return-Path: <SRS0=FEuC=EL=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E32A2C00A89
	for <linux-block@archiver.kernel.org>; Thu,  5 Nov 2020 07:37:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 885DF20936
	for <linux-block@archiver.kernel.org>; Thu,  5 Nov 2020 07:37:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725320AbgKEHhl (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 5 Nov 2020 02:37:41 -0500
Received: from verein.lst.de ([213.95.11.211]:46115 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725287AbgKEHhl (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 5 Nov 2020 02:37:41 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id B57DD68B02; Thu,  5 Nov 2020 08:37:37 +0100 (CET)
Date:   Thu, 5 Nov 2020 08:37:37 +0100
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
Message-ID: <20201105073737.GA4747@lst.de>
References: <CGME20201102161505eucas1p19415e34eb0b14c7eca5a2c648569cf1e@eucas1p1.samsung.com> <0916865d50c640e3aa95dc542f3986b9@CAMSVWEXC01.scsc.local> <20201102180836.GC20182@lst.de> <20201102183355.GB1970293@dhcp-10-100-145-180.wdc.com> <20201102185851.GA21349@lst.de> <23e10fd1-d20c-cf77-4dc0-dd8b0774fd7a@suse.de> <20201104142908.GA7941@lst.de> <01c72262-1839-05cc-ba9a-94b260511a7c@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <01c72262-1839-05cc-ba9a-94b260511a7c@suse.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Nov 04, 2020 at 03:46:02PM +0100, Hannes Reinecke wrote:
> ... as would a bsg device which could accept said ioctl ...

Sure we could.  So we'd have to add more code to almost 1000 lines of
code in bsg that are not useful to the nvme use case to make it useful
for that use case.  Or we could just add about 50 lines of code to NVMe
to do the right thing.
