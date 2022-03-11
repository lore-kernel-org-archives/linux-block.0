Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D6B2C4332F
	for <linux-block@archiver.kernel.org>; Fri, 11 Mar 2022 22:51:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230012AbiCKWwV (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 11 Mar 2022 17:52:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229952AbiCKWwO (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 11 Mar 2022 17:52:14 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76E8EF3933
        for <linux-block@vger.kernel.org>; Fri, 11 Mar 2022 14:30:37 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 13A7760EDF
        for <linux-block@vger.kernel.org>; Fri, 11 Mar 2022 22:30:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8AEEC340E9;
        Fri, 11 Mar 2022 22:30:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647037836;
        bh=4qAmf848tVCoto8fyRKeB+O8cV3hMrlD10emBl9050w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dhgwiYDEnBy7NbwgBcJArz4oWWBs0JOvO3uDZO3zpKs6GrTGV725J3d3wsMh8lcVA
         2TpBIC5GBhPleOZOSaPsmUln2ndPCpK4dqTHckKn/loM5WZjVfpedqyhyMXjfkJVKd
         hMee2AY7nqrPsHkbbNNdDsxfzXQmC8lqjGj9d26kmPJkRsTvqKBfvicVlpmdRRoMs9
         jvn6kGXHRvxJZpsAB9A3PzH9RuIZipXAat2SLthp8k2UKAjOzPVlSe62dTki8olVbd
         GqAp3hkoFPhQlRl/cEmIKE0ypfNFCU4hEpkKMw0eqEItzdzI9a37KuKB3xYclN9ggp
         Jnce1lAweUz7g==
Date:   Fri, 11 Mar 2022 14:30:32 -0800
From:   Keith Busch <kbusch@kernel.org>
To:     Adam Manzanares <a.manzanares@samsung.com>
Cc:     Luis Chamberlain <mcgrof@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Pankaj Raghav <p.raghav@samsung.com>,
        Javier =?iso-8859-1?Q?Gonz=E1lez?= <javier.gonz@samsung.com>,
        "jiangbo.365@bytedance.com" <jiangbo.365@bytedance.com>,
        kanchan Joshi <joshi.k@samsung.com>,
        Jens Axboe <axboe@kernel.dk>, Sagi Grimberg <sagi@grimberg.me>,
        Matias =?iso-8859-1?Q?Bj=F8rling?= <matias.bjorling@wdc.com>,
        Pankaj Raghav <pankydev8@gmail.com>,
        Kanchan Joshi <joshiiitr@gmail.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>
Subject: Re: [PATCH 0/6] power_of_2 emulation support for NVMe ZNS devices
Message-ID: <20220311223032.GA2439@dhcp-10-100-145-180.wdc.com>
References: <CGME20220308165414eucas1p106df0bd6a901931215cfab81660a4564@eucas1p1.samsung.com>
 <20220308165349.231320-1-p.raghav@samsung.com>
 <20220310094725.GA28499@lst.de>
 <e02dfd21-31c6-95b6-1127-3f18c79116ee@samsung.com>
 <20220310144449.GA1695@lst.de>
 <Yiuu2h38owO9ioIW@bombadil.infradead.org>
 <20220311205135.GA413653@dhcp-10-100-145-180.wdc.com>
 <20220311222326.GA110401@bgt-140510-bm01>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220311222326.GA110401@bgt-140510-bm01>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Mar 11, 2022 at 10:23:33PM +0000, Adam Manzanares wrote:
> On Fri, Mar 11, 2022 at 12:51:35PM -0800, Keith Busch wrote:
> > And po2 does not even seem to be the real problem here. The holes seem
> > to be what's causing a concern, which you have even without po2 zones.
> > I'm starting to like the previous idea of creating an unholey
> > device-mapper for such users...
> 
> I see holes as being caused by having to make zone size po2 when capacity is 
> not po2. po2 should be tied to the holes, unless I am missing something. 

Practically speaking, you're probably not missing anything. The spec,
however, doesn't constrain the existence of holes to any particular zone
size.

> BTW if we go down the dm route can we start calling it dm-unholy.

I was thinking "dm-evil" but unholy works too. :)
