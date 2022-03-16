Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B128C433F5
	for <linux-block@archiver.kernel.org>; Wed, 16 Mar 2022 02:13:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230083AbiCPCOv (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 15 Mar 2022 22:14:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345597AbiCPCOs (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 15 Mar 2022 22:14:48 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82FA9CE4
        for <linux-block@vger.kernel.org>; Tue, 15 Mar 2022 19:13:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=vG1Hmk74Aif2YazQJqrchYYEWEpwf++vOsVZXzznyFI=; b=QjqpDOwUQy5RDhnxJ+cb6/4l0T
        76sNHG1HJaGYasmr/wQy14g7ZRbROk1gri97uUywWvnzazLWqIMsJLwKgNxhsJpNxRVkrsOug5sHC
        9m+ubFikokcJZMrfV70bbJmwjKb9Rir5D/Byy3kvWHzwDDzJRU/p7orrbbskdrM/ELxkEQArNJCgE
        uOHUDEmHyzA9zulkcJUKHiMP93T6/slG0lxaOCpz/e9A4a/ZijJ50djYo8aNgJvW3rAnMmNdeH+mp
        wnCMKUre0smmLaIJlJ7Q6I1/2RECG1L3Kc6jaWDBI8oNhdk9GKexwuTrKWC1ydXF7Q9vxcpaWrZeD
        G1eYHfxg==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nUJA6-00BBBU-M8; Wed, 16 Mar 2022 02:13:18 +0000
Date:   Tue, 15 Mar 2022 19:13:18 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        Javier =?iso-8859-1?Q?Gonz=E1lez?= <javier@javigon.com>,
        Matias =?iso-8859-1?Q?Bj=F8rling?= <Matias.Bjorling@wdc.com>,
        Keith Busch <kbusch@kernel.org>,
        Pankaj Raghav <p.raghav@samsung.com>,
        Adam Manzanares <a.manzanares@samsung.com>,
        "jiangbo.365@bytedance.com" <jiangbo.365@bytedance.com>,
        kanchan Joshi <joshi.k@samsung.com>,
        Jens Axboe <axboe@kernel.dk>, Sagi Grimberg <sagi@grimberg.me>,
        Pankaj Raghav <pankydev8@gmail.com>,
        Kanchan Joshi <joshiiitr@gmail.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH 0/6] power_of_2 emulation support for NVMe ZNS devices
Message-ID: <YjFHvuKshW6Sg6ZT@bombadil.infradead.org>
References: <20220315130501.q7fjpqzutadadfu3@ArmHalley.localdomain>
 <BYAPR04MB49689803ED6E1E32C49C6413F1109@BYAPR04MB4968.namprd04.prod.outlook.com>
 <20220315132611.g5ert4tzuxgi7qd5@unifi>
 <20220315133052.GA12593@lst.de>
 <YjDGS6ROx6tI5FBR@bombadil.infradead.org>
 <62ed2891-f4b2-d63c-553d-8cae49b586bc@opensource.wdc.com>
 <YjEuAv/RNpF4GvsJ@bombadil.infradead.org>
 <c3d71cd7-cf95-c290-bfc6-29d307b7b4e8@opensource.wdc.com>
 <YjE8VZ1bbdE9nV0C@bombadil.infradead.org>
 <8e842ca0-1885-4738-0099-24409c108b2a@opensource.wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8e842ca0-1885-4738-0099-24409c108b2a@opensource.wdc.com>
Sender: Luis Chamberlain <mcgrof@infradead.org>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Mar 16, 2022 at 10:44:56AM +0900, Damien Le Moal wrote:
> On 3/16/22 10:24, Luis Chamberlain wrote:
> > SMR != ZNS
> 
> Not for the block layer nor for any in-kernel <etc>

Back to kernel, I thought you wanted to focus on applications.

> Considering the zone size requirement problem in the context of ZNS only
> is thus far from ideal in my opinion, to say the least.

It's the reality for ZNS though.

  Luis
