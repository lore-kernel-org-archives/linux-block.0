Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F7ACC433EF
	for <linux-block@archiver.kernel.org>; Mon, 14 Mar 2022 07:36:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230312AbiCNHh5 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 14 Mar 2022 03:37:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230334AbiCNHh4 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 14 Mar 2022 03:37:56 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E2B540E56
        for <linux-block@vger.kernel.org>; Mon, 14 Mar 2022 00:36:47 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 5F11D68AFE; Mon, 14 Mar 2022 08:36:44 +0100 (CET)
Date:   Mon, 14 Mar 2022 08:36:44 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Adam Manzanares <a.manzanares@samsung.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        Pankaj Raghav <p.raghav@samsung.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Javier =?iso-8859-1?Q?Gonz=E1lez?= <javier.gonz@samsung.com>,
        kanchan Joshi <joshi.k@samsung.com>,
        Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>,
        Sagi Grimberg <sagi@grimberg.me>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Matias =?iso-8859-1?Q?Bj=F8rling?= <matias.bjorling@wdc.com>,
        "jiangbo.365@bytedance.com" <jiangbo.365@bytedance.com>,
        Pankaj Raghav <pankydev8@gmail.com>,
        Kanchan Joshi <joshiiitr@gmail.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH 0/6] power_of_2 emulation support for NVMe ZNS devices
Message-ID: <20220314073644.GB4204@lst.de>
References: <CGME20220308165414eucas1p106df0bd6a901931215cfab81660a4564@eucas1p1.samsung.com> <20220308165349.231320-1-p.raghav@samsung.com> <20220310094725.GA28499@lst.de> <20220310173835.GB89599@bgt-140510-bm01>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220310173835.GB89599@bgt-140510-bm01>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Mar 10, 2022 at 05:38:35PM +0000, Adam Manzanares wrote:
> > Do these drives even support Zone Append?
> 
> Should it matter if the drives support append? SMR drives do not support append
> and they are considered zone block devices. Append seems to be an optimization
> for users that want higher concurrency per zone. One can also build concurrency
> by leveraging multiple zones simultaneously as well.

Not supporting it natively for SMR is a major pain.  Due to hard drives
being relatively slow the emulation is somewhat workable, but on SSDs
the serialization would completely kill performance.
