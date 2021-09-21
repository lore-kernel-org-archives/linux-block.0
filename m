Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93079C433EF
	for <linux-block@archiver.kernel.org>; Tue, 21 Sep 2021 06:37:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 72BDB60E73
	for <linux-block@archiver.kernel.org>; Tue, 21 Sep 2021 06:37:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229755AbhIUGi2 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 21 Sep 2021 02:38:28 -0400
Received: from verein.lst.de ([213.95.11.211]:55130 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229624AbhIUGi1 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 21 Sep 2021 02:38:27 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 2E07567373; Tue, 21 Sep 2021 08:36:57 +0200 (CEST)
Date:   Tue, 21 Sep 2021 08:36:57 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Christoph Hellwig <hch@lst.de>, axboe@kernel.dk,
        linux-block@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 01/17] mm: don't include <linux/blk-cgroup.h> in
 <linux/writeback.h>
Message-ID: <20210921063656.GA23945@lst.de>
References: <20210920123328.1399408-1-hch@lst.de> <20210920123328.1399408-2-hch@lst.de> <50b75915-b61f-d3aa-b8ab-bd790adc04af@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <50b75915-b61f-d3aa-b8ab-bd790adc04af@acm.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Sep 20, 2021 at 03:13:15PM -0700, Bart Van Assche wrote:
>> +#define wbc_blkcg_css(wbc) \
>> +	((wbc)->wb ? (wbc)->wb->blkcg_css : blkcg_root_css)
>> +#else
>> +#define wbc_blkcg_css(wbc)		(blkcg_root_css)
>> +#endif /* CONFIG_CGROUP_WRITEBACK */
>
> This change may introduce annoying set-but-not-used warnings
> with CONFIG_CGROUP_WRITEBACK=n. How about changing (blkcg_root_css)
> into ((wbc), blkcg_root_css) to prevent this?

I agree in principle, but in this case the caller pretty much has
to use wbc in other ways, so I don't think it matters much.
