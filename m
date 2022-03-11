Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47589C433EF
	for <linux-block@archiver.kernel.org>; Fri, 11 Mar 2022 22:52:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230102AbiCKWxo (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 11 Mar 2022 17:53:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231127AbiCKWx1 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 11 Mar 2022 17:53:27 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA75B111DC2
        for <linux-block@vger.kernel.org>; Fri, 11 Mar 2022 14:27:04 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2B2E961FBC
        for <linux-block@vger.kernel.org>; Fri, 11 Mar 2022 21:31:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8779EC340E9;
        Fri, 11 Mar 2022 21:31:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647034265;
        bh=hYel3HbpvLen6sZ3euben+avywStvvz0gp95k3KsGBk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qpUuCWrCbsGl/LITMp1atVWBazFlnkYOWtEbc3DsKA1++oysWd5hGW3/PXkhS7ZY0
         CpKdqSlg9/3iwHmT0vTqdf7tXpplB6NPuoqnlDf8nLqRs5QF7ojqd6R+WYXC3lqoqc
         TkgSoYtCNLGAEeCZNv7aT1hg3sUKBpD6CposEQkRKdJFNFi1rk8W1XLZDUJDbXEWw0
         BwS26apkIj8l9pqKb6G+ElCEk6ELp9mDMA7eaon6rTbtOEAtF487QSpoMXGg1PUZb0
         2LZFD93Sf/Fg6pzvjLjbh9eyCdXfgZO4lASBKSBA04rjA5MgjKTLYqfrC7Fr35lzB4
         O8jwE1TKTUznw==
Date:   Fri, 11 Mar 2022 13:31:02 -0800
From:   Keith Busch <kbusch@kernel.org>
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     Christoph Hellwig <hch@lst.de>,
        Pankaj Raghav <p.raghav@samsung.com>,
        Adam Manzanares <a.manzanares@samsung.com>,
        Javier =?iso-8859-1?Q?Gonz=E1lez?= <javier.gonz@samsung.com>,
        jiangbo.365@bytedance.com, kanchan Joshi <joshi.k@samsung.com>,
        Jens Axboe <axboe@kernel.dk>, Sagi Grimberg <sagi@grimberg.me>,
        Matias =?iso-8859-1?Q?Bj=F8rling?= <matias.bjorling@wdc.com>,
        Pankaj Raghav <pankydev8@gmail.com>,
        Kanchan Joshi <joshiiitr@gmail.com>,
        linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>
Subject: Re: [PATCH 0/6] power_of_2 emulation support for NVMe ZNS devices
Message-ID: <20220311213102.GA2309@dhcp-10-100-145-180.wdc.com>
References: <CGME20220308165414eucas1p106df0bd6a901931215cfab81660a4564@eucas1p1.samsung.com>
 <20220308165349.231320-1-p.raghav@samsung.com>
 <20220310094725.GA28499@lst.de>
 <e02dfd21-31c6-95b6-1127-3f18c79116ee@samsung.com>
 <20220310144449.GA1695@lst.de>
 <Yiuu2h38owO9ioIW@bombadil.infradead.org>
 <20220311205135.GA413653@dhcp-10-100-145-180.wdc.com>
 <Yiu5YzxU/PjxLiUL@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yiu5YzxU/PjxLiUL@bombadil.infradead.org>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Mar 11, 2022 at 01:04:35PM -0800, Luis Chamberlain wrote:
> On Fri, Mar 11, 2022 at 12:51:35PM -0800, Keith Busch wrote:
> 
> > I'm starting to like the previous idea of creating an unholey
> > device-mapper for such users...
> 
> Won't that restrict nvme with chunk size crap. For instance later if we
> want much larger block sizes.

I'm not sure I understand. The chunk_size has nothing to do with the
block size. And while nvme is a user of this in some circumstances, it
can't be used concurrently with ZNS because the block layer appropriates
the field for the zone size.
