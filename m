Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2496DC433EF
	for <linux-block@archiver.kernel.org>; Thu, 10 Mar 2022 14:54:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241118AbiCJOze (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 10 Mar 2022 09:55:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346768AbiCJOuB (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 10 Mar 2022 09:50:01 -0500
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C713918A787
        for <linux-block@vger.kernel.org>; Thu, 10 Mar 2022 06:44:53 -0800 (PST)
Received: by verein.lst.de (Postfix, from userid 2407)
        id AB73D68AFE; Thu, 10 Mar 2022 15:44:49 +0100 (CET)
Date:   Thu, 10 Mar 2022 15:44:49 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Pankaj Raghav <p.raghav@samsung.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Adam Manzanares <a.manzanares@samsung.com>,
        Javier =?iso-8859-1?Q?Gonz=E1lez?= <javier.gonz@samsung.com>,
        jiangbo.365@bytedance.com, kanchan Joshi <joshi.k@samsung.com>,
        Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>,
        Sagi Grimberg <sagi@grimberg.me>,
        Matias =?iso-8859-1?Q?Bj=F8rling?= <matias.bjorling@wdc.com>,
        Pankaj Raghav <pankydev8@gmail.com>,
        Kanchan Joshi <joshiiitr@gmail.com>,
        linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>
Subject: Re: [PATCH 0/6] power_of_2 emulation support for NVMe ZNS devices
Message-ID: <20220310144449.GA1695@lst.de>
References: <CGME20220308165414eucas1p106df0bd6a901931215cfab81660a4564@eucas1p1.samsung.com> <20220308165349.231320-1-p.raghav@samsung.com> <20220310094725.GA28499@lst.de> <e02dfd21-31c6-95b6-1127-3f18c79116ee@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e02dfd21-31c6-95b6-1127-3f18c79116ee@samsung.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Mar 10, 2022 at 01:57:58PM +0100, Pankaj Raghav wrote:
> Yes, these drives are intended for Linux users that would use the zoned
> block device. Append is supported but holes in the LBA space (due to
> diff in zone cap and zone size) is still a problem for these users.

I'd really like to hear from the users.  Because really, either they
should use a proper file system abstraction (including zonefs if that is
all they need), or raw nvme passthrough which will alredy work for this
case.  But adding a whole bunch of crap because people want to use the
block device special file for something it is not designed for just
does not make any sense.
