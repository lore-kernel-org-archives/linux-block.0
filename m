Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68F1CC433F5
	for <linux-block@archiver.kernel.org>; Fri, 11 Mar 2022 00:57:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235415AbiCKA6H (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 10 Mar 2022 19:58:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345255AbiCKA5z (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 10 Mar 2022 19:57:55 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14ACD1A3618
        for <linux-block@vger.kernel.org>; Thu, 10 Mar 2022 16:56:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=yPaic9724hgJl0T3m1YjW9i3tNRmigXgOWKo9zDkfic=; b=cpZLI3vXqJCz7rBbFP6U+eWyhc
        uzujwvOq0a0PQcB5rDyQADRN7vlCYh1/MeAirwOCHdRicBA8bsswQOKf2fJbbmMHZQFz5NKPyktkw
        TkEJ8OpIFcLj6Q8w6UEXLWmhj3Vf21tGE2KrIHOVUsKcCACnfUnJrvD8UEOewXV2uFdhzv/AgWqkf
        emLzTjXKctQ5tEDTj7V00mtTs8agon4T3qNtUwv2+txMAgJ68avTgPte9ELtH+jZ+JRV60mpZ3Mxi
        AbgsyUtuGyeXiq7FJKV76qlZ/5C2SvkOg/fFQJum6pmF5Q1vmFAAy1bSH8SufgbY8/eA58KBRuROk
        ZDJK7HlQ==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nSTaJ-00ESJP-TU; Fri, 11 Mar 2022 00:56:47 +0000
Date:   Thu, 10 Mar 2022 16:56:47 -0800
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>
Cc:     Pankaj Raghav <p.raghav@samsung.com>,
        Adam Manzanares <a.manzanares@samsung.com>,
        Javier =?iso-8859-1?Q?Gonz=E1lez?= <javier.gonz@samsung.com>,
        kanchan Joshi <joshi.k@samsung.com>,
        Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        Matias =?iso-8859-1?Q?Bj=F8rling?= <matias.bjorling@wdc.com>,
        jiangbo.365@bytedance.com, Pankaj Raghav <pankydev8@gmail.com>,
        Kanchan Joshi <joshiiitr@gmail.com>,
        linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
Subject: Re: [PATCH 4/6] nvme: zns: Add support for power_of_2 emulation to
 NVMe ZNS devices
Message-ID: <YiqeT+lru+AmHeuK@bombadil.infradead.org>
References: <20220308165349.231320-1-p.raghav@samsung.com>
 <CGME20220308165436eucas1p1b76f3cb5b4fa1f7d78b51a3b1b44d160@eucas1p1.samsung.com>
 <20220308165349.231320-5-p.raghav@samsung.com>
 <d13c40a5-3f87-fb2c-155e-dd64535067ac@opensource.wdc.com>
 <cf527b75-8fba-96ba-659d-fbb46fbe9de7@samsung.com>
 <bdb92eac-59ef-3ba1-16cb-31219e3a264b@opensource.wdc.com>
 <YiphB2Me63kD7T5t@bombadil.infradead.org>
 <b95a7400-8338-a696-5742-fcb8fc2693b0@opensource.wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b95a7400-8338-a696-5742-fcb8fc2693b0@opensource.wdc.com>
Sender: Luis Chamberlain <mcgrof@infradead.org>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Mar 11, 2022 at 08:50:47AM +0900, Damien Le Moal wrote:
> On 3/11/22 05:35, Luis Chamberlain wrote:
> > On Thu, Mar 10, 2022 at 06:43:47AM +0900, Damien Le Moal wrote:
> >> The indirect call using a function pointer makes the code obscure. And
> >> the cost of that call is far greater and always present compared to the
> >> CPU branch prediction which will luckily avoid most of the time taking
> >> the wrong branch of an if.
> > 
> > The goal was to ensure no performance impact, and given a hot path
> > was involved and we simply cannot microbench append as there is no
> > way / API to do that, we can't be sure. But if you are certain that
> > there is no perf impact, it would be wonderful to live without it.
> 
> Use zonefs. It uses zone append.

That'd be a microbench on zonefs append, not raw append, and so I
suspect a simple branch cannot make a difference and would get lost
as noise. So I don't think a perf test is required here. Please
let me know.

  Luis
