Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6C99C4338F
	for <linux-block@archiver.kernel.org>; Mon, 16 Aug 2021 07:22:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A56C461A8C
	for <linux-block@archiver.kernel.org>; Mon, 16 Aug 2021 07:22:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233782AbhHPHWd (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 16 Aug 2021 03:22:33 -0400
Received: from verein.lst.de ([213.95.11.211]:53271 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233725AbhHPHWc (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 16 Aug 2021 03:22:32 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 12B2567373; Mon, 16 Aug 2021 09:21:59 +0200 (CEST)
Date:   Mon, 16 Aug 2021 09:21:58 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Mike Snitzer <snitzer@redhat.com>, linux-block@vger.kernel.org,
        dm-devel@redhat.com
Subject: Re: [dm-devel] [PATCH 4/8] block: support delayed holder
 registration
Message-ID: <20210816072158.GA27147@lst.de>
References: <20210804094147.459763-1-hch@lst.de> <20210804094147.459763-5-hch@lst.de> <20210814211309.GA616511@roeck-us.net> <20210815070724.GA23276@lst.de> <a8d66952-ee44-d3fa-d699-439415b9abfe@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a8d66952-ee44-d3fa-d699-439415b9abfe@roeck-us.net>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Sun, Aug 15, 2021 at 07:27:37AM -0700, Guenter Roeck wrote:
> [   14.467748][    T1]  Possible unsafe locking scenario:
> [   14.467748][    T1]
> [   14.467928][    T1]        CPU0                    CPU1
> [   14.468058][    T1]        ----                    ----
> [   14.468187][    T1]   lock(&disk->open_mutex);
> [   14.468317][    T1]                                lock(mtd_table_mutex);
> [   14.468493][    T1]                                lock(&disk->open_mutex);
> [   14.468671][    T1]   lock(mtd_table_mutex);

Oh, that ooks like a really old one, fixed by
b7abb0516822 ("mtd: fix lock hierarchy in deregister_mtd_blktrans")
in linux-next.
