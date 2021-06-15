Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09DF4C48BE5
	for <linux-block@archiver.kernel.org>; Tue, 15 Jun 2021 16:25:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DFDBB616EB
	for <linux-block@archiver.kernel.org>; Tue, 15 Jun 2021 16:25:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229734AbhFOQ1Q (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 15 Jun 2021 12:27:16 -0400
Received: from verein.lst.de ([213.95.11.211]:50228 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229557AbhFOQ1O (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 15 Jun 2021 12:27:14 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id CAEFE67373; Tue, 15 Jun 2021 18:25:07 +0200 (CEST)
Date:   Tue, 15 Jun 2021 18:25:07 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Cc:     linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
        axboe@kernel.dk, sagi@grimberg.me, hch@lst.de
Subject: Re: [PATCH V15 0/5] nvmet: add ZBD backened support
Message-ID: <20210615162507.GA1089@lst.de>
References: <20210610013252.53874-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210610013252.53874-1-chaitanya.kulkarni@wdc.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Thanks,

applied to nvme-5.14.
