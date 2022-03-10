Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BF79C433EF
	for <linux-block@archiver.kernel.org>; Thu, 10 Mar 2022 09:47:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232513AbiCJJsd (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 10 Mar 2022 04:48:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236977AbiCJJsb (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 10 Mar 2022 04:48:31 -0500
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E3A7D76FE
        for <linux-block@vger.kernel.org>; Thu, 10 Mar 2022 01:47:30 -0800 (PST)
Received: by verein.lst.de (Postfix, from userid 2407)
        id DFE0468AFE; Thu, 10 Mar 2022 10:47:25 +0100 (CET)
Date:   Thu, 10 Mar 2022 10:47:25 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Pankaj Raghav <p.raghav@samsung.com>
Cc:     Luis Chamberlain <mcgrof@kernel.org>,
        Adam Manzanares <a.manzanares@samsung.com>,
        Javier =?iso-8859-1?Q?Gonz=E1lez?= <javier.gonz@samsung.com>,
        kanchan Joshi <joshi.k@samsung.com>,
        Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Matias =?iso-8859-1?Q?Bj=F8rling?= <matias.bjorling@wdc.com>,
        jiangbo.365@bytedance.com, Pankaj Raghav <pankydev8@gmail.com>,
        Kanchan Joshi <joshiiitr@gmail.com>,
        linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
Subject: Re: [PATCH 0/6] power_of_2 emulation support for NVMe ZNS devices
Message-ID: <20220310094725.GA28499@lst.de>
References: <CGME20220308165414eucas1p106df0bd6a901931215cfab81660a4564@eucas1p1.samsung.com> <20220308165349.231320-1-p.raghav@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220308165349.231320-1-p.raghav@samsung.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

This is complete bonkers.  IFF we have a good reason to support non
power of two zones size (and I'd like to see evidence for that) we'll
need to go through all the layers to support it.  But doing this emulation
is just idiotic and will at tons of code just to completely confuse users.

On Tue, Mar 08, 2022 at 05:53:43PM +0100, Pankaj Raghav wrote:
> 
> #Motivation:
> There are currently ZNS drives that are produced and deployed that do
> not have power_of_2(PO2) zone size. The NVMe spec for ZNS does not
> specify the PO2 requirement but the linux block layer currently checks
> for zoned devices to have power_of_2 zone sizes.

Well, apparently whoever produces these drives never cared about supporting
Linux as the power of two requirement goes back to SMR HDDs, which also
don't have that requirement in the spec (and even allow non-uniform zone
size), but Linux decided that we want this for sanity.

Do these drives even support Zone Append?
