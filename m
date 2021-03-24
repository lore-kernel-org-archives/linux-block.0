Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61AE8C433C1
	for <linux-block@archiver.kernel.org>; Wed, 24 Mar 2021 17:34:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2C58D619F3
	for <linux-block@archiver.kernel.org>; Wed, 24 Mar 2021 17:34:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237126AbhCXReF (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 24 Mar 2021 13:34:05 -0400
Received: from verein.lst.de ([213.95.11.211]:37981 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237203AbhCXRdh (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 24 Mar 2021 13:33:37 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 376A568B05; Wed, 24 Mar 2021 18:33:34 +0100 (CET)
Date:   Wed, 24 Mar 2021 18:33:33 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Johannes Thumshirn <johannes.thumshirn@wdc.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Naohiro Aota <naohiro.aota@wdc.com>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v2] block: support zone append bvecs
Message-ID: <20210324173333.GA12770@lst.de>
References: <10bd414d9326c90cd69029077db63b363854eee5.1616600835.git.johannes.thumshirn@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <10bd414d9326c90cd69029077db63b363854eee5.1616600835.git.johannes.thumshirn@wdc.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Mar 25, 2021 at 12:47:26AM +0900, Johannes Thumshirn wrote:
> Christoph reported that we'll likely trigger the WARN_ON_ONCE() checking
> that we're not submitting a bvec with REQ_OP_ZONE_APPEND in
> bio_iov_iter_get_pages() some time ago using zoned btrfs, but I couldn't
> reproduce it back then.
> 
> Now Naohiro was able to trigger the bug as well with xfstests generic/095
> on a zoned btrfs.
> 
> There is nothing that prevents bvec submissions via REQ_OP_ZONE_APPEND if
> the hardware's zone append limit is met.
> 
> Reported-by: Naohiro Aota <naohiro.aota@wdc.com>
> Reported-by: Christoph Hellwig <hch@lst.de>
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
