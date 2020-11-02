Return-Path: <SRS0=t87n=EI=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A903DC00A89
	for <linux-block@archiver.kernel.org>; Mon,  2 Nov 2020 18:58:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5F29E22275
	for <linux-block@archiver.kernel.org>; Mon,  2 Nov 2020 18:58:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725797AbgKBS6y (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 2 Nov 2020 13:58:54 -0500
Received: from verein.lst.de ([213.95.11.211]:34403 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725817AbgKBS6y (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 2 Nov 2020 13:58:54 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id 6CCF268B05; Mon,  2 Nov 2020 19:58:51 +0100 (CET)
Date:   Mon, 2 Nov 2020 19:58:51 +0100
From:   "hch@lst.de" <hch@lst.de>
To:     Keith Busch <kbusch@kernel.org>
Cc:     "hch@lst.de" <hch@lst.de>,
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
Message-ID: <20201102185851.GA21349@lst.de>
References: <CGME20201102161505eucas1p19415e34eb0b14c7eca5a2c648569cf1e@eucas1p1.samsung.com> <0916865d50c640e3aa95dc542f3986b9@CAMSVWEXC01.scsc.local> <20201102180836.GC20182@lst.de> <20201102183355.GB1970293@dhcp-10-100-145-180.wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201102183355.GB1970293@dhcp-10-100-145-180.wdc.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Nov 02, 2020 at 10:33:55AM -0800, Keith Busch wrote:
> I can see this going one of two ways:
> 
>  a) Set up the existing controller character device with a generic
>     disk-less request_queue to the IO queues accepting IO commands to
>     arbitrary NSIDs.
> 
>  b) Each namespace that can't be supported gets their own character
>     device.
> 
> I'm leaning toward option "a". While it doesn't create handles to unique
> namespaces, it has more resilience to potentially future changes. And I
> recall the target side had a potential use for that, too.

The problem with a) is that it can't be used to give users or groups
access to just one namespaces, so it causes a real access control
nightmare.  The problem with b) is that now applications will break
when we add support for new command sets or features.  I think

  c) Each namespace gets its own character device, period.

is the only sensible option.
