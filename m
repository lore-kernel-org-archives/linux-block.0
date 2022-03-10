Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D05C6C433F5
	for <linux-block@archiver.kernel.org>; Thu, 10 Mar 2022 15:11:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344483AbiCJPMp (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 10 Mar 2022 10:12:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344860AbiCJPMV (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 10 Mar 2022 10:12:21 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEE9513DE0
        for <linux-block@vger.kernel.org>; Thu, 10 Mar 2022 07:07:36 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 61B65B825A7
        for <linux-block@vger.kernel.org>; Thu, 10 Mar 2022 15:07:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1F45C340E8;
        Thu, 10 Mar 2022 15:07:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646924854;
        bh=0hp00Jy+IMNoo5h1gFYV80g0XT2H6yvLfY36fSISqJQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Mk6L/CTfW44dSyQzZ1FMHeI78vMTU6lplukD5YoKNiwUkjML3fbhaiG10sMJFnmJ8
         luKAFgWldJFTkuU8Lm75+LzgsUyeRgbhrKY+zFRhT5kpILfZVZ/5W2F/B1TfY8ctk+
         8Semr7MuyLjveVOZw7pTipBEzvQHlSmtBFTakDhk5PUcQCFmIcPxT6m5CGyLiQxIPR
         JLCnSydaSkTHU2DjPjHeBGiT2ytlwBMfyaLmB8EPdVjxlcBsu71ZutnXq/a2ugQRJz
         Is0Z/Z8CvFtRASmK/i4bSJXCVsLioTv1gKQleoTfyVZYSX3EhjyoHfmAtgLB6WbWdr
         0wrVrbvPpbvzQ==
Date:   Thu, 10 Mar 2022 07:07:30 -0800
From:   Keith Busch <kbusch@kernel.org>
To:     Matias =?iso-8859-1?Q?Bj=F8rling?= <Matias.Bjorling@wdc.com>
Cc:     Javier =?iso-8859-1?Q?Gonz=E1lez?= <javier@javigon.com>,
        Pankaj Raghav <p.raghav@samsung.com>,
        Christoph Hellwig <hch@lst.de>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Adam Manzanares <a.manzanares@samsung.com>,
        Javier =?iso-8859-1?Q?Gonz=E1lez?= <javier.gonz@samsung.com>,
        "jiangbo.365@bytedance.com" <jiangbo.365@bytedance.com>,
        kanchan Joshi <joshi.k@samsung.com>,
        Jens Axboe <axboe@kernel.dk>, Sagi Grimberg <sagi@grimberg.me>,
        Pankaj Raghav <pankydev8@gmail.com>,
        Kanchan Joshi <joshiiitr@gmail.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>
Subject: Re: [PATCH 0/6] power_of_2 emulation support for NVMe ZNS devices
Message-ID: <20220310150730.GA329710@dhcp-10-100-145-180.wdc.com>
References: <BYAPR04MB4968FA68FA8B670163EEC1EFF10B9@BYAPR04MB4968.namprd04.prod.outlook.com>
 <C2710A6C-340D-4BFC-A8DB-28D456095468@javigon.com>
 <BYAPR04MB49684A8C6FEDA0B999ABCBB2F10B9@BYAPR04MB4968.namprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <BYAPR04MB49684A8C6FEDA0B999ABCBB2F10B9@BYAPR04MB4968.namprd04.prod.outlook.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Mar 10, 2022 at 02:58:07PM +0000, Matias Bjørling wrote:
>  >> Yes, these drives are intended for Linux users that would use the
> > >> zoned block device. Append is supported but holes in the LBA space
> > >> (due to diff in zone cap and zone size) is still a problem for these users.
> > >
> > > With respect to the specific users, what does it break specifically? What are
> > key features are they missing when there's holes?
> > 
> > What we hear is that it breaks existing mapping in applications, where the
> > address space is seen as contiguous; with holes it needs to account for the
> > unmapped space. This affects performance and and CPU due to unnecessary
> > splits. This is for both reads and writes.
> > 
> > For more details, I guess they will have to jump in and share the parts that
> > they consider is proper to share in the mailing list.
> > 
> > I guess we will have more conversations around this as we push the block
> > layer changes after this series.
> 
> Ok, so I hear that one issue is I/O splits - If I assume that reads
> are sequential, zone cap/size between 100MiB and 1GiB, then my gut
> feeling would tell me its less CPU intensive to split every 100MiB to
> 1GiB of reads, than it would be to not have power of 2 zones due to
> the extra per io calculations. 

Don't you need to split anyway when spanning two zones to avoid the zone
boundary error?

Maybe this is a silly idea, but it would be a trivial device-mapper
to remap the gaps out of the lba range.
